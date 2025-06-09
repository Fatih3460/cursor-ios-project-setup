# ⚡ Hızlı Başlangıç Rehberi

Bu rehber, 5 dakikada ilk iOS projenizi oluşturmanızı sağlar.

## 🎯 Hedef

Bu rehberin sonunda:
- ✅ Cursor iOS Setup sistemi kurulu olacak
- ✅ İlk iOS projeniz hazır olacak
- ✅ AI modes'larını kullanmayı öğreneceksiniz
- ✅ İlk SwiftUI view'ınızı oluşturacaksınız

## ⏱️ 5 Dakikalık Kurulum

### 1. Repository'yi Clone Edin (30 saniye)
```bash
git clone https://github.com/Fatih3460/cursor-ios-project-setup.git
cd cursor-ios-project-setup
```

### 2. Otomatik Kurulum (2 dakika)
```bash
chmod +x setup.sh
./setup.sh
```

### 3. İlk Projeyi Oluşturun (1 dakika)
```bash
./create-project.sh MyFirstApp ios
cd MyFirstApp
```

### 4. Cursor'da Açın (30 saniye)
```bash
cursor .
```

### 5. AI Mode'u Test Edin (1 dakika)
1. `⌘⇧C` tuşlarına basın (iOS Coder Mode)
2. Şu promptu yazın: "Create a simple counter app with SwiftUI"
3. AI'nın kodu otomatik oluşturmasını izleyin

## 🎮 İlk Proje: Counter App

### Adım 1: UI Designer Mode ile Tasarım
`⌘⇧D` tuşlarına basın ve şu promptu verin:

```
Design a simple counter app with:
- A number display in the center
- Plus and minus buttons
- Reset button
- Nice colors and animations
```

### Adım 2: iOS Coder Mode ile Implementation
`⌘⇧C` tuşlarına basın ve şu promptu verin:

```
Implement the counter app with:
- @State for counter value
- Increment/decrement functions
- Smooth animations
- Modern SwiftUI design
```

### Adım 3: Code Analyst Mode ile Review
`⌘⇧L` tuşlarına basın ve şu promptu verin:

```
Review the counter app code for:
- SwiftUI best practices
- Performance optimization
- Accessibility compliance
- Code quality
```

## 🚀 Gelişmiş Örnek: Todo App

### Project Planner Mode ile Planlama
`⌘⇧P` tuşlarına basın:

```
Plan a simple Todo app with:
- Add/delete tasks
- Mark as complete
- Local storage
- Nice UI design
What features should I prioritize?
```

### Architect Mode ile Tasarım
`⌘⇧A` tuşlarına basın:

```
Design architecture for Todo app:
- MVVM pattern
- Data persistence
- State management
- File organization
```

### Implementation Workflow
1. **UI Designer** (`⌘⇧D`): UI components tasarımı
2. **iOS Coder** (`⌘⇧C`): Models ve ViewModels oluşturma
3. **iOS Coder** (`⌘⇧C`): Views implementation
4. **Code Analyst** (`⌘⇧L`): Code review ve optimization

## 🔌 Supabase Entegrasyonu (İsteğe Bağlı)

### Backend'li Proje Oluşturun
```bash
./create-project.sh MyBackendApp ios-supabase
cd MyBackendApp
cursor .
```

### Supabase MCP'yi Aktifleştirin
```bash
# Environment variables set edin
export SUPABASE_ACCESS_TOKEN="your_token"
export SUPABASE_PROJECT_ID="your_project_id"
```

### Backend Integration Testi
`⌘⇧C` tuşlarına basın:

```
Create a simple user authentication system using Supabase:
- Login screen
- Signup functionality
- User session management
- Secure storage
```

## 🎯 Mode Seçim Rehberi

### Ne Zaman Hangi Mode?

| Görev | Mode | Kısayol | Örnek |
|-------|------|---------|--------|
| **Planlama** | Project Planner | `⌘⇧P` | "Bu app'te hangi feature'lar olmalı?" |
| **Architecture** | iOS Architect | `⌘⇧A` | "MVVM nasıl implement edilmeli?" |
| **UI Tasarım** | UI Designer | `⌘⇧D` | "Login screen nasıl görünmeli?" |
| **Kod Yazma** | iOS Coder | `⌘⇧C` | "User authentication implement et" |
| **Code Review** | Code Analyst | `⌘⇧L` | "Bu kodu optimize edebilir misin?" |

### Otomatik Mode Seçimi
Sistem prompt'unuzu analiz ederek otomatik olarak uygun mode'u önerir:

```
🤖 **Önerilen Mode:** iOS Coder Mode (⌘⇧C)
📋 **Sebep:** Implementation isteği tespit edildi
🔄 **Alternatif:** UI Designer Mode (⌘⇧D) tasarım odaklı yaklaşım için
```

## 💡 Pro Tips

### 1. Workflow Kombinasyonları
```
Plan → Design → Implement → Review
  📋      🎨        💻        📊
(⌘⇧P)  (⌘⇧D)    (⌘⇧C)    (⌘⇧L)
```

### 2. Context Switching
Mode'lar arası geçişte context korunur:
- Önceki mode'daki dosyalar açık kalır
- Conversation history devam eder
- Project state korunur

### 3. Prompt Optimization
Her mode için optimize edilmiş prompt örnekleri:

**iOS Architect:**
```
"Design a scalable architecture for a social media app with offline support"
```

**iOS Coder:**
```
"Implement Core Data model for User with relationships to Posts and Comments"
```

**UI Designer:**
```
"Create a modern onboarding flow with 3 screens, animations, and iOS 17 design language"
```

## 🐛 Hızlı Sorun Giderme

### Mode Çalışmıyor?
```bash
# Cursor'u yeniden başlatın
# Config dosyalarını kontrol edin
ls -la ~/.config/cursor/User/.cursor/
```

### Rules Uygulanmıyor?
```bash
# Rules dosyalarının varlığını kontrol edin
ls -la .cursor/rules/
```

### MCP Bağlanmıyor?
```bash
# Environment variables'ları kontrol edin
echo $SUPABASE_ACCESS_TOKEN
echo $GITHUB_PERSONAL_ACCESS_TOKEN
```

## 📚 Sonraki Adımlar

Temel kurulum tamamlandı! Şimdi:

1. 📖 [AI Modes Detaylı Kullanımı](ai-modes.md)
2. ⚙️ [Rules Sistemi Deep Dive](rules-system.md)
3. 🔌 [MCP Entegrasyonu](mcp-integration.md)
4. 🍎 [iOS Best Practices](ios-best-practices.md)
5. 🏗️ [Architecture Patterns](architecture-patterns.md)

## 🎉 Başarılı!

Artık Cursor'u iOS geliştirme için en optimize şekilde kullanmaya hazırsınız. Her mode ile farklı uzmanlık alanlarına erişiminiz var ve workflow'unuz otomatize edildi.

**İyi kodlamalar!** 🚀

---

**Sonraki:** [AI Modes Detaylı Kullanımı →](ai-modes.md)