#!/bin/bash

# 🚀 Cursor iOS Project Creator
# Yeni iOS projelerini otomatik olarak oluşturur ve yapılandırır

set -e

# Renkli output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Banner
echo -e "${BLUE}"
echo "📱 =============================================="
echo "   CURSOR iOS PROJECT CREATOR"
echo "   Hızlı ve optimize edilmiş iOS proje kurulumu"
echo "===============================================${NC}"
echo ""

# Kullanım kontrolü
if [[ $# -lt 2 ]]; then
    echo -e "${RED}❌ Hatalı kullanım${NC}"
    echo ""
    echo "Kullanım: ./create-project.sh <project-name> <template-type>"
    echo ""
    echo "Template Types:"
    echo "  ios                 - Temel iOS app (SwiftUI + MVVM)"
    echo "  ios-supabase        - Supabase backend'li iOS app"
    echo "  ios-mvvm            - Gelişmiş MVVM architecture"
    echo "  ios-firebase        - Firebase backend'li iOS app"
    echo ""
    echo "Örnek:"
    echo "  ./create-project.sh MyAwesomeApp ios"
    echo "  ./create-project.sh ChatApp ios-supabase"
    exit 1
fi

PROJECT_NAME="$1"
TEMPLATE_TYPE="$2"

# Geçerli karakterler kontrolü
if [[ ! "$PROJECT_NAME" =~ ^[A-Za-z][A-Za-z0-9]*$ ]]; then
    echo -e "${RED}❌ Geçersiz proje adı: $PROJECT_NAME${NC}"
    echo "Proje adı harfle başlamalı ve sadece harf/rakam içermeli"
    exit 1
fi

# Template type kontrolü
case "$TEMPLATE_TYPE" in
    "ios"|"ios-supabase"|"ios-mvvm"|"ios-firebase")
        ;;
    *)
        echo -e "${RED}❌ Geçersiz template tipi: $TEMPLATE_TYPE${NC}"
        echo "Geçerli tipler: ios, ios-supabase, ios-mvvm, ios-firebase"
        exit 1
        ;;
esac

echo -e "${BLUE}📱 Proje: ${GREEN}$PROJECT_NAME${NC}"
echo -e "${BLUE}📋 Template: ${GREEN}$TEMPLATE_TYPE${NC}"
echo ""

# Proje dizini oluştur
create_project_structure() {
    echo -e "${BLUE}📁 Proje yapısı oluşturuluyor...${NC}"
    
    if [[ -d "$PROJECT_NAME" ]]; then
        echo -e "${RED}❌ Proje dizini zaten mevcut: $PROJECT_NAME${NC}"
        exit 1
    fi
    
    mkdir -p "$PROJECT_NAME"
    cd "$PROJECT_NAME"
    
    # iOS proje yapısı
    mkdir -p "$PROJECT_NAME"/{Sources,Resources,Tests}
    mkdir -p "$PROJECT_NAME/Sources"/{Models,Views,ViewModels,Services,Utils}
    mkdir -p "$PROJECT_NAME/Resources"/{Assets,Info}
    mkdir -p "$PROJECT_NAME/Tests"/{UnitTests,UITests}
    
    # Cursor konfigürasyonu
    mkdir -p .cursor/rules
    
    echo -e "${GREEN}✅ Proje yapısı oluşturuldu${NC}"
}

# Cursor rules'ları kopyala
setup_cursor_rules() {
    echo -e "${BLUE}📋 Cursor rules yapılandırılıyor...${NC}"
    
    # Ana rules'ları kopyala
    if [[ -d "../.cursor/rules" ]]; then
        cp -r ../.cursor/rules/* .cursor/rules/
    fi
    
    if [[ -f "../.cursor/modes.json" ]]; then
        cp ../.cursor/modes.json .cursor/
    fi
    
    # Proje-spesifik rules oluştur
    cat > .cursor/rules/project-specific.mdc << EOF
---
description: Project-specific rules for $PROJECT_NAME
globs: ["**/*.swift", "**/*.md"]
alwaysApply: true
---

# Project Rules for $PROJECT_NAME

## Project Information
- **Project Name**: $PROJECT_NAME
- **Template**: $TEMPLATE_TYPE
- **Architecture**: MVVM with SwiftUI
- **Platform**: iOS 17.0+

## Naming Conventions
- **App Target**: $PROJECT_NAME
- **Bundle ID**: com.yourcompany.${PROJECT_NAME,,}
- **Main View**: ContentView
- **Main Model**: ${PROJECT_NAME}Model

## File Organization
- Models: Data structures and business logic
- Views: SwiftUI views and UI components  
- ViewModels: MVVM view model classes
- Services: API clients and external service interfaces
- Utils: Helper functions and extensions

## Development Standards
- Use SwiftUI for all UI components
- Implement MVVM architecture pattern
- Add proper error handling for all async operations
- Include unit tests for business logic
- Follow Swift style guide conventions
EOF

    echo -e "${GREEN}✅ Cursor rules yapılandırıldı${NC}"
}

# iOS temel template
create_ios_basic() {
    echo -e "${BLUE}📱 iOS temel template oluşturuluyor...${NC}"
    
    # Package.swift
    cat > Package.swift << EOF
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "$PROJECT_NAME",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "$PROJECT_NAME",
            targets: ["$PROJECT_NAME"]),
    ],
    dependencies: [
        // iOS dependencies burada eklenecek
    ],
    targets: [
        .target(
            name: "$PROJECT_NAME",
            dependencies: [],
            path: "$PROJECT_NAME/Sources"),
        .testTarget(
            name: "${PROJECT_NAME}Tests",
            dependencies: ["$PROJECT_NAME"],
            path: "$PROJECT_NAME/Tests/UnitTests"),
    ]
)
EOF

    # Main App file
    cat > "$PROJECT_NAME/Sources/${PROJECT_NAME}App.swift" << EOF
import SwiftUI

@main
struct ${PROJECT_NAME}App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
EOF

    # ContentView
    cat > "$PROJECT_NAME/Sources/Views/ContentView.swift" << EOF
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "swift")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("Welcome to $PROJECT_NAME")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Created with Cursor iOS Setup")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Button(action: viewModel.buttonTapped) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("$PROJECT_NAME")
        }
    }
}

#Preview {
    ContentView()
}
EOF

    # ViewModel
    cat > "$PROJECT_NAME/Sources/ViewModels/ContentViewModel.swift" << EOF
import Foundation
import SwiftUI

@MainActor
class ContentViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var message = ""
    
    func buttonTapped() {
        isLoading = true
        
        // Simulate some work
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            self.message = "Hello from $PROJECT_NAME!"
        }
    }
}
EOF

    # Info.plist
    cat > "$PROJECT_NAME/Resources/Info/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleName</key>
    <string>$PROJECT_NAME</string>
    <key>CFBundleDisplayName</key>
    <string>$PROJECT_NAME</string>
    <key>CFBundleIdentifier</key>
    <string>com.yourcompany.${PROJECT_NAME,,}</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>LSRequiresIPhoneOS</key>
    <true/>
    <key>UILaunchScreen</key>
    <dict/>
</dict>
</plist>
EOF

    echo -e "${GREEN}✅ iOS temel template oluşturuldu${NC}"
}

# iOS + Supabase template
create_ios_supabase() {
    echo -e "${BLUE}🔌 iOS + Supabase template oluşturuluyor...${NC}"
    
    # Önce temel template'i oluştur
    create_ios_basic
    
    # Supabase dependencies ekle
    cat > Package.swift << EOF
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "$PROJECT_NAME",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "$PROJECT_NAME",
            targets: ["$PROJECT_NAME"]),
    ],
    dependencies: [
        .package(url: "https://github.com/supabase/supabase-swift.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "$PROJECT_NAME",
            dependencies: [
                .product(name: "Supabase", package: "supabase-swift"),
            ],
            path: "$PROJECT_NAME/Sources"),
        .testTarget(
            name: "${PROJECT_NAME}Tests",
            dependencies: ["$PROJECT_NAME"],
            path: "$PROJECT_NAME/Tests/UnitTests"),
    ]
)
EOF

    # Supabase Service
    cat > "$PROJECT_NAME/Sources/Services/SupabaseService.swift" << EOF
import Foundation
import Supabase

class SupabaseService: ObservableObject {
    static let shared = SupabaseService()
    
    private let client: SupabaseClient
    
    private init() {
        // TODO: Replace with your Supabase project URL and anon key
        let url = URL(string: "YOUR_SUPABASE_URL")!
        let key = "YOUR_SUPABASE_ANON_KEY"
        
        client = SupabaseClient(supabaseURL: url, supabaseKey: key)
    }
    
    // MARK: - Authentication
    
    func signIn(email: String, password: String) async throws {
        try await client.auth.signIn(email: email, password: password)
    }
    
    func signUp(email: String, password: String) async throws {
        try await client.auth.signUp(email: email, password: password)
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    var currentUser: User? {
        client.auth.currentUser
    }
    
    // MARK: - Database Operations
    
    func fetchData<T: Codable>(from table: String, type: T.Type) async throws -> [T] {
        let response: [T] = try await client
            .from(table)
            .select()
            .execute()
            .value
        
        return response
    }
    
    func insertData<T: Codable>(_ data: T, into table: String) async throws {
        try await client
            .from(table)
            .insert(data)
            .execute()
    }
    
    func updateData<T: Codable>(_ data: T, in table: String, matching column: String, value: String) async throws {
        try await client
            .from(table)
            .update(data)
            .eq(column, value: value)
            .execute()
    }
    
    func deleteData(from table: String, matching column: String, value: String) async throws {
        try await client
            .from(table)
            .delete()
            .eq(column, value: value)
            .execute()
    }
}
EOF

    # Supabase configuration
    cat > "$PROJECT_NAME/Sources/Utils/SupabaseConfig.swift" << EOF
import Foundation

struct SupabaseConfig {
    static let url = "YOUR_SUPABASE_URL"
    static let anonKey = "YOUR_SUPABASE_ANON_KEY"
    
    // Environment-based configuration
    static var isProduction: Bool {
        #if DEBUG
        return false
        #else
        return true
        #endif
    }
}
EOF

    echo -e "${GREEN}✅ iOS + Supabase template oluşturuldu${NC}"
    echo -e "${YELLOW}💡 Supabase konfigürasyonu için:${NC}"
    echo "   1. SupabaseConfig.swift dosyasındaki URL ve key'leri güncelleyin"
    echo "   2. Supabase MCP'yi aktifleştirin"
}

# Git repository başlat
setup_git() {
    echo -e "${BLUE}📦 Git repository başlatılıyor...${NC}"
    
    git init
    
    # .gitignore oluştur
    cat > .gitignore << EOF
# Xcode
*.xcodeproj/*
!*.xcodeproj/project.pbxproj
!*.xcodeproj/xcshareddata/
!*.xcworkspace/contents.xcworkspacedata
**/xcshareddata/WorkspaceSettings.xcsettings
.DS_Store
*.xcuserstate
*.xcscmblueprint
*.xccheckout

# Swift Package Manager
Packages/
Package.pins
Package.resolved
*.xcodeproj/
.swiftpm/

# Build artifacts
.build/
DerivedData/

# Environment variables
.env
.env.local

# IDE
.vscode/
.cursor/

# Supabase
supabase/.env
supabase/config.toml
EOF

    git add .
    git commit -m "🚀 Initial commit: $PROJECT_NAME project created with $TEMPLATE_TYPE template"
    
    echo -e "${GREEN}✅ Git repository başlatıldı${NC}"
}

# README oluştur
create_readme() {
    echo -e "${BLUE}📝 README oluşturuluyor...${NC}"
    
    cat > README.md << EOF
# $PROJECT_NAME

iOS app created with Cursor iOS Project Setup.

## 📋 Project Details

- **Template**: $TEMPLATE_TYPE
- **Platform**: iOS 17.0+
- **Architecture**: MVVM with SwiftUI
- **Package Manager**: Swift Package Manager

## 🚀 Getting Started

### Prerequisites

- Xcode 15.0+
- iOS 17.0+ device or simulator
- Swift 5.9+

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd $PROJECT_NAME
   \`\`\`

2. Open in Xcode:
   \`\`\`bash
   open $PROJECT_NAME.xcodeproj
   \`\`\`

3. Build and run the project

## 📂 Project Structure

\`\`\`
$PROJECT_NAME/
├── Sources/
│   ├── Models/          # Data models
│   ├── Views/           # SwiftUI views
│   ├── ViewModels/      # MVVM view models
│   ├── Services/        # API clients and services
│   └── Utils/           # Helper functions
├── Resources/
│   ├── Assets/          # Images, colors, etc.
│   └── Info/            # Info.plist and configuration
└── Tests/
    ├── UnitTests/       # Unit tests
    └── UITests/         # UI tests
\`\`\`

## 🛠 Development

### Adding New Features

1. Create model in \`Sources/Models/\`
2. Create view in \`Sources/Views/\`
3. Create view model in \`Sources/ViewModels/\`
4. Add tests in \`Tests/\`

### Using Cursor AI Modes

- **Architect Mode** (⌘⇧A): For architecture decisions
- **Coder Mode** (⌘⇧C): For implementation
- **Designer Mode** (⌘⇧D): For UI/UX design
- **Planner Mode** (⌘⇧P): For project planning

EOF

    if [[ "$TEMPLATE_TYPE" == "ios-supabase" ]]; then
        cat >> README.md << EOF

## 🔌 Supabase Configuration

1. Create a new project at [supabase.com](https://supabase.com)
2. Update \`SupabaseConfig.swift\` with your project URL and anon key:
   \`\`\`swift
   static let url = "https://your-project.supabase.co"
   static let anonKey = "your-anon-key"
   \`\`\`
3. Set up your database schema in Supabase dashboard
4. Use \`SupabaseService.shared\` for database operations

### Environment Variables

Create a \`.env\` file (optional):
\`\`\`
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
\`\`\`

EOF
    fi

    cat >> README.md << EOF

## 📄 License

This project is licensed under the MIT License.

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (\`git checkout -b feature/amazing-feature\`)
3. Commit your changes (\`git commit -m 'Add amazing feature'\`)
4. Push to the branch (\`git push origin feature/amazing-feature\`)
5. Open a Pull Request

---

Created with ❤️ using [Cursor iOS Project Setup](https://github.com/Fatih3460/cursor-ios-project-setup)
EOF

    echo -e "${GREEN}✅ README oluşturuldu${NC}"
}

# Ana fonksiyon
main() {
    create_project_structure
    setup_cursor_rules
    
    case "$TEMPLATE_TYPE" in
        "ios")
            create_ios_basic
            ;;
        "ios-supabase")
            create_ios_supabase
            ;;
        "ios-mvvm")
            create_ios_basic  # Şimdilik basic ile aynı
            ;;
        "ios-firebase")
            create_ios_basic  # Şimdilik basic ile aynı
            ;;
    esac
    
    create_readme
    setup_git
    
    echo ""
    echo -e "${GREEN}🎉 =============================================="
    echo "   PROJE BAŞARIYLA OLUŞTURULDU!"
    echo "===============================================${NC}"
    echo ""
    echo -e "${BLUE}📁 Proje: ${GREEN}$PROJECT_NAME${NC}"
    echo -e "${BLUE}📋 Template: ${GREEN}$TEMPLATE_TYPE${NC}"
    echo -e "${BLUE}📍 Dizin: ${GREEN}$(pwd)${NC}"
    echo ""
    echo -e "${BLUE}📋 Sonraki adımlar:${NC}"
    echo "1. cd $PROJECT_NAME"
    echo "2. Cursor'da projeyi açın"
    echo "3. AI mode'larını deneyin: ⌘⇧A, ⌘⇧C, ⌘⇧D"
    
    if [[ "$TEMPLATE_TYPE" == "ios-supabase" ]]; then
        echo "4. SupabaseConfig.swift dosyasını yapılandırın"
    fi
    
    echo ""
    echo -e "${YELLOW}💡 Daha fazla bilgi: https://github.com/Fatih3460/cursor-ios-project-setup${NC}"
}

# Ana fonksiyonu çalıştır
main