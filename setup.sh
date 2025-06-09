#!/bin/bash

# 🚀 Cursor iOS Project Setup - Ana Kurulum Scripti
# Herhangi bir bilgisayarda Cursor'u iOS geliştirme için optimize eder

set -e

# Renkli output için
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logo ve banner
echo -e "${BLUE}"
echo "🚀 ==============================================="
echo "   CURSOR iOS PROJECT SETUP INSTALLER"
echo "   iOS geliştirme için optimize edilmiş kurulum"
echo "===============================================${NC}"
echo ""

# Platform detection
OS=""
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    CURSOR_CONFIG_DIR="$HOME/Library/Application Support/Cursor/User"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    CURSOR_CONFIG_DIR="$HOME/.config/cursor/User"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    OS="windows"
    CURSOR_CONFIG_DIR="$APPDATA/Cursor/User"
else
    echo -e "${RED}❌ Desteklenmeyen işletim sistemi: $OSTYPE${NC}"
    exit 1
fi

echo -e "${BLUE}🖥️  Platform tespit edildi: ${GREEN}$OS${NC}"

# Cursor yüklü mü kontrol et
check_cursor() {
    if ! command -v cursor &> /dev/null; then
        echo -e "${YELLOW}⚠️  Cursor IDE bulunamadı. Lütfen önce Cursor'u yükleyin:${NC}"
        echo "   macOS: https://cursor.sh/"
        echo "   Linux: https://cursor.sh/"
        echo "   Windows: https://cursor.sh/"
        exit 1
    fi
    echo -e "${GREEN}✅ Cursor IDE tespit edildi${NC}"
}

# Cursor config dizinini oluştur
create_cursor_config() {
    echo -e "${BLUE}📁 Cursor config dizinleri oluşturuluyor...${NC}"
    
    if [[ ! -d "$CURSOR_CONFIG_DIR" ]]; then
        mkdir -p "$CURSOR_CONFIG_DIR"
        echo -e "${GREEN}✅ Cursor config dizini oluşturuldu: $CURSOR_CONFIG_DIR${NC}"
    fi
    
    # .cursor dizinlerini oluştur
    mkdir -p "$CURSOR_CONFIG_DIR/.cursor/rules"
    mkdir -p "$CURSOR_CONFIG_DIR/.cursor/modes"
    
    echo -e "${GREEN}✅ Cursor config yapısı hazırlandı${NC}"
}

# Rules dosyalarını kopyala
install_rules() {
    echo -e "${BLUE}📋 Cursor rules yükleniyor...${NC}"
    
    # Eğer .cursor/rules/ dizini varsa, oradan kopyala
    if [[ -d ".cursor/rules" ]]; then
        cp -r .cursor/rules/* "$CURSOR_CONFIG_DIR/.cursor/rules/"
        echo -e "${GREEN}✅ Rules dosyaları yüklendi${NC}"
    else
        echo -e "${YELLOW}⚠️  Rules dizini bulunamadı, basic rules oluşturuluyor...${NC}"
        create_basic_rules
    fi
}

# Custom modes yükle
install_modes() {
    echo -e "${BLUE}🤖 AI Modes yükleniyor...${NC}"
    
    if [[ -f ".cursor/modes.json" ]]; then
        cp .cursor/modes.json "$CURSOR_CONFIG_DIR/.cursor/"
        echo -e "${GREEN}✅ AI Modes yüklendi${NC}"
    else
        echo -e "${YELLOW}⚠️  Modes dosyası bulunamadı, default modes oluşturuluyor...${NC}"
        create_default_modes
    fi
}

# MCP ayarlarını yükle
configure_mcp() {
    echo -e "${BLUE}🔌 Supabase MCP konfigürasyonu...${NC}"
    
    # MCP config dosyasını oluştur
    cat > "$CURSOR_CONFIG_DIR/mcp_settings.json" << 'EOF'
{
  "mcpServers": {
    "supabase": {
      "command": "npx",
      "args": ["-y", "@supabase/mcp-server"],
      "env": {
        "SUPABASE_ACCESS_TOKEN": "${SUPABASE_ACCESS_TOKEN}",
        "SUPABASE_PROJECT_ID": "${SUPABASE_PROJECT_ID}"
      }
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    }
  }
}
EOF
    
    echo -e "${GREEN}✅ MCP konfigürasyonu oluşturuldu${NC}"
    echo -e "${YELLOW}💡 MCP'leri aktifleştirmek için environment variable'ları set edin:${NC}"
    echo "   export SUPABASE_ACCESS_TOKEN=your_token"
    echo "   export SUPABASE_PROJECT_ID=your_project_id"
    echo "   export GITHUB_PERSONAL_ACCESS_TOKEN=your_token"
}

# Basic rules oluştur (fallback)
create_basic_rules() {
    cat > "$CURSOR_CONFIG_DIR/.cursor/rules/001-core.mdc" << 'EOF'
---
description: Core development rules for iOS projects
globs: 
alwaysApply: true
---

# Core iOS Development Rules

## Language Standards
- All code, APIs, schemas, functions, variables, comments must be in **English**
- All user interaction (explanations, questions, warnings) must be in **Turkish**
- Never mix languages in either context

## iOS Development Standards
- Use latest Swift and SwiftUI versions
- Follow Swift style guidelines and naming conventions
- Apply MVVM architecture pattern
- Use native SwiftUI components
- Design for both iPhone and iPad
- Support light and dark modes
- Implement proper error handling
- Apply memory management best practices
EOF

    echo -e "${GREEN}✅ Basic rules oluşturuldu${NC}"
}

# Default modes oluştur (fallback)
create_default_modes() {
    cat > "$CURSOR_CONFIG_DIR/.cursor/modes.json" << 'EOF'
{
  "modes": {
    "ios-architect": {
      "name": "🏗️ iOS Architect",
      "description": "iOS architecture design and analysis expert",
      "model": "claude-3.5-sonnet",
      "systemPrompt": "You are an expert iOS architect. Focus on system design, architecture patterns, and technical decisions for iOS applications.",
      "tools": ["codebase_search", "web_search", "create_diagram"]
    },
    "ios-coder": {
      "name": "💻 iOS Coder", 
      "description": "Swift/SwiftUI development specialist",
      "model": "claude-3.5-sonnet",
      "systemPrompt": "You are an expert iOS developer. Focus on writing clean, efficient Swift/SwiftUI code following best practices.",
      "tools": ["edit_file", "read_file", "run_terminal_cmd", "codebase_search"]
    },
    "ui-designer": {
      "name": "🎨 UI Designer",
      "description": "SwiftUI UI/UX design specialist", 
      "model": "claude-3.5-sonnet",
      "systemPrompt": "You are a SwiftUI UI/UX expert. Focus on creating beautiful, accessible, and user-friendly interfaces.",
      "tools": ["edit_file", "web_search", "create_diagram"]
    }
  }
}
EOF

    echo -e "${GREEN}✅ Default modes oluşturuldu${NC}"
}

# Xcode command line tools kontrol
check_xcode_tools() {
    if [[ "$OS" == "macos" ]]; then
        echo -e "${BLUE}🔧 Xcode Command Line Tools kontrol ediliyor...${NC}"
        
        if ! xcode-select -p &> /dev/null; then
            echo -e "${YELLOW}⚠️  Xcode Command Line Tools yüklü değil. Yükleniyor...${NC}"
            xcode-select --install
            echo -e "${GREEN}✅ Xcode Command Line Tools yükleme başlatıldı${NC}"
        else
            echo -e "${GREEN}✅ Xcode Command Line Tools zaten yüklü${NC}"
        fi
    fi
}

# Ana kurulum fonksiyonu
main() {
    echo -e "${BLUE}🚀 Kurulum başlatılıyor...${NC}"
    
    check_cursor
    check_xcode_tools
    create_cursor_config
    install_rules
    install_modes
    configure_mcp
    
    echo ""
    echo -e "${GREEN}🎉 ==============================================="
    echo "   KURULUM BAŞARIYLA TAMAMLANDI!"
    echo "===============================================${NC}"
    echo ""
    echo -e "${BLUE}📋 Sonraki adımlar:${NC}"
    echo "1. Cursor'u yeniden başlatın"
    echo "2. Yeni proje oluşturun: ./create-project.sh MyApp ios"
    echo "3. Custom mode'ları deneyin: ⌘⇧A (Architect), ⌘⇧C (Coder), ⌘⇧D (Designer)"
    echo ""
    echo -e "${YELLOW}💡 Daha fazla bilgi için: https://github.com/Fatih3460/cursor-ios-project-setup${NC}"
}

# Parametreleri kontrol et
if [[ "$1" == "--help" ]]; then
    echo "Kullanım: ./setup.sh [options]"
    echo ""
    echo "Options:"
    echo "  --help              Bu yardım mesajını göster"
    echo "  --existing-project  Mevcut projeye rules ekle"
    echo ""
    exit 0
fi

if [[ "$1" == "--existing-project" ]]; then
    if [[ -z "$2" ]]; then
        echo -e "${RED}❌ Proje yolu belirtilmedi${NC}"
        echo "Kullanım: ./setup.sh --existing-project /path/to/project"
        exit 1
    fi
    
    PROJECT_PATH="$2"
    if [[ ! -d "$PROJECT_PATH" ]]; then
        echo -e "${RED}❌ Proje dizini bulunamadı: $PROJECT_PATH${NC}"
        exit 1
    fi
    
    echo -e "${BLUE}📁 Mevcut projeye rules ekleniyor: $PROJECT_PATH${NC}"
    
    # Projeye .cursor dizini oluştur
    mkdir -p "$PROJECT_PATH/.cursor/rules"
    
    # Rules'ları kopyala
    if [[ -d ".cursor/rules" ]]; then
        cp -r .cursor/rules/* "$PROJECT_PATH/.cursor/rules/"
    fi
    
    if [[ -f ".cursor/modes.json" ]]; then
        cp .cursor/modes.json "$PROJECT_PATH/.cursor/"
    fi
    
    echo -e "${GREEN}✅ Rules başarıyla eklendi: $PROJECT_PATH${NC}"
    exit 0
fi

# Ana kurulumu çalıştır
main