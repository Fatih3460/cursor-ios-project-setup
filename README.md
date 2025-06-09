# 🚀 Cursor iOS Project Setup

iOS geliştirme için optimize edilmiş Cursor IDE setup sistemi - Otomatik rules, custom modes, MCP entegrasyonu ve proje kurulumu.

## 📋 Özellikler

- ✅ **Otomatik Mode Seçimi**: Promta göre uygun specialized mode'u aktif eder
- ✅ **Supabase MCP Entegrasyonu**: Backend işlemleri için otomatik MCP kullanımı  
- ✅ **iOS Optimized Rules**: Swift/SwiftUI için en iyi pratikler
- ✅ **Tek Komut Kurulum**: 30 saniyede profesyonel proje setupı
- ✅ **Cross-Platform**: macOS, Windows, Linux desteği
- ✅ **AI Powered**: 5 specialized AI mode (Architect, Coder, Designer, Planner, Analyst)

## 🚀 Hızlı Kurulum

```bash
# 1. Repo'yu clone et
git clone https://github.com/Fatih3460/cursor-ios-project-setup.git
cd cursor-ios-project-setup

# 2. Kurulum scriptini çalıştır  
chmod +x setup.sh
./setup.sh

# 3. Yeni iOS projesi oluştur
./create-project.sh MyAwesomeApp ios
```

## 📂 Proje Yapısı

```
cursor-ios-project-setup/
├── 📁 .cursor/
│   ├── 📁 rules/           # Otomatik rules sistemi
│   │   ├── 001-core.mdc    # Ana kurallar
│   │   ├── 010-ios.mdc     # iOS specialized rules  
│   │   ├── 020-supabase.mdc # Supabase MCP rules
│   │   └── 030-automation.mdc # Otomatik mode seçimi
│   └── modes.json          # Custom AI modes
├── 📁 scripts/             # Kurulum ve otomatizasyon
│   ├── setup.sh           # Ana kurulum scripti
│   ├── create-project.sh  # Yeni proje oluşturma
│   └── update-cursor.sh   # Cursor ayarlarını güncelleme
├── 📁 templates/          # iOS proje template'leri
│   ├── basic-ios/         # Temel iOS app template
│   ├── supabase-ios/      # Supabase entegrasyon template
│   └── mvvm-ios/          # MVVM architecture template
├── 📁 docs/               # Detaylı dökümanlar
└── README.md              # Bu dosya
```

## 🤖 AI Modes

| Mode | Kısayol | Açıklama |
|------|---------|----------|
| 🏗️ **iOS Architect** | `⌘⇧A` | Architecture tasarımı ve analizi |
| 💻 **iOS Coder** | `⌘⇧C` | Hızlı kod geliştirme ve implementation |
| 🎨 **UI Designer** | `⌘⇧D` | SwiftUI tasarım ve UX optimization |
| 📋 **Project Planner** | `⌘⇧P` | Proje planlama ve task management |
| 📊 **Code Analyst** | `⌘⇧L` | Code review ve analiz |

## 🔧 Kullanım

### Yeni Proje Oluşturma
```bash
# iOS app projesi
./create-project.sh MyApp ios

# Supabase backend'li iOS app
./create-project.sh MyApp ios-supabase

# MVVM architecture ile iOS app  
./create-project.sh MyApp ios-mvvm
```

### Mevcut Projeye Rules Ekleme
```bash
./setup.sh --existing-project /path/to/your/project
```

### Cursor Ayarlarını Güncelleme
```bash
./update-cursor.sh
```

## 📚 Detaylı Dökümanlar

- [🔧 Kurulum Rehberi](docs/installation.md)
- [📖 AI Modes Kullanımı](docs/ai-modes.md)  
- [⚙️ Rules Sistemi](docs/rules-system.md)
- [🔌 MCP Entegrasyonu](docs/mcp-integration.md)
- [🍎 iOS Best Practices](docs/ios-best-practices.md)

## 🤝 Katkıda Bulunma

1. Fork edin
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit edin (`git commit -m 'Add amazing feature'`)
4. Push edin (`git push origin feature/amazing-feature`)
5. Pull Request açın

## 📄 Lisans

MIT License - Detaylar için [LICENSE](LICENSE) dosyasına bakın.

## 🆘 Destek

Sorularınız için:
- [Issues](https://github.com/Fatih3460/cursor-ios-project-setup/issues) açın
- [Discussions](https://github.com/Fatih3460/cursor-ios-project-setup/discussions) bölümünü kullanın

---

⭐ Bu proje faydalıysa yıldız vermeyi unutmayın!