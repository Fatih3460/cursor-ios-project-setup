# 🔧 Kurulum Rehberi

Bu rehber, Cursor iOS Project Setup'ı herhangi bir bilgisayarda nasıl kuracağınızı adım adım açıklar.

## 📋 Sistem Gereksinimleri

### Temel Gereksinimler
- **İşletim Sistemi**: macOS 12+, Linux, Windows 10+
- **Cursor IDE**: v0.40.0 veya üzeri
- **Node.js**: v18+ (MCP için)
- **Git**: v2.30+ (proje yönetimi için)

### macOS Ek Gereksinimler
- **Xcode**: 15.0+ (iOS development için)
- **Command Line Tools**: Xcode ile otomatik yüklenir
- **Homebrew**: Önerilen (isteğe bağlı)

### Linux Gereksinimler
- **Build Essential**: `sudo apt install build-essential`
- **Python**: v3.8+ (bazı MCP serverlar için)

### Windows Gereksinimler
- **Git Bash**: Windows için Git
- **Node.js**: Windows installer
- **PowerShell**: 7.0+ önerilen

## 🚀 Hızlı Kurulum

### 1. Repository'yi Clone Edin
```bash
# HTTPS ile
git clone https://github.com/Fatih3460/cursor-ios-project-setup.git

# SSH ile (önerilen)
git clone git@github.com:Fatih3460/cursor-ios-project-setup.git

cd cursor-ios-project-setup
```

### 2. Kurulum Scriptini Çalıştırın
```bash
# macOS/Linux
chmod +x setup.sh
./setup.sh

# Windows (Git Bash)
bash setup.sh
```

### 3. Cursor'u Yeniden Başlatın
Kurulum tamamlandıktan sonra Cursor'u tamamen kapatıp yeniden açın.

## 🔧 Detaylı Kurulum Adımları

### Manuel Kurulum (Script Çalışmazsa)

#### 1. Cursor Config Dizinini Bulun
```bash
# macOS
~/Library/Application\ Support/Cursor/User

# Linux
~/.config/cursor/User

# Windows
%APPDATA%/Cursor/User
```

#### 2. Rules Dosyalarını Kopyalayın
```bash
# Config dizinine .cursor klasörü oluşturun
mkdir -p "$CURSOR_CONFIG_DIR/.cursor/rules"

# Rules dosyalarını kopyalayın
cp -r .cursor/rules/* "$CURSOR_CONFIG_DIR/.cursor/rules/"
cp .cursor/modes.json "$CURSOR_CONFIG_DIR/.cursor/"
```

#### 3. MCP Konfigürasyonunu Ekleyin
```bash
# MCP settings dosyasını oluşturun
cp config/mcp_settings.json "$CURSOR_CONFIG_DIR/"
```

## 🤖 Custom Modes Kurulumu

### Modes Dosyasını Kontrol Edin
Kurulum sonrası modes.json dosyasının doğru yerleştirildiğini kontrol edin:

```bash
# Dosyanın var olduğunu kontrol edin
ls -la "$CURSOR_CONFIG_DIR/.cursor/modes.json"

# İçeriğini kontrol edin
cat "$CURSOR_CONFIG_DIR/.cursor/modes.json"
```

### Keyboard Shortcuts
Kurulum sonrası kullanılabilir kısayollar:
- `⌘⇧A` - iOS Architect Mode
- `⌘⇧C` - iOS Coder Mode  
- `⌘⇧D` - UI Designer Mode
- `⌘⇧P` - Project Planner Mode
- `⌘⇧L` - Code Analyst Mode

## 🔌 MCP Entegrasyonu

### Supabase MCP Kurulumu
```bash
# Supabase MCP'yi global olarak yükleyin
npm install -g @supabase/mcp-server

# Environment variable'ları set edin
export SUPABASE_ACCESS_TOKEN="your_token"
export SUPABASE_PROJECT_ID="your_project_id"
```

### GitHub MCP Kurulumu
```bash
# GitHub MCP'yi global olarak yükleyin
npm install -g @modelcontextprotocol/server-github

# GitHub token'ınızı set edin
export GITHUB_PERSONAL_ACCESS_TOKEN="your_github_token"
```

### MCP Konfigürasyon Dosyası
`mcp_settings.json` dosyasını Cursor config dizinine ekleyin:

```json
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
```

## 🧪 Kurulum Testi

### 1. Yeni Proje Oluşturun
```bash
./create-project.sh TestApp ios
cd TestApp
```

### 2. Cursor'da Açın
```bash
cursor .
```

### 3. Mode'ları Test Edin
1. `⌘⇧A` tuşlarına basıp Architect mode'u deneyin
2. Bir prompt yazın: "How should I structure my iOS app?"
3. Mode'un doğru çalıştığını kontrol edin

### 4. Rules'ları Test Edin
1. Yeni bir Swift dosyası oluşturun
2. Bir kod parçası yazın
3. Rules'ların otomatik uygulandığını kontrol edin

## 🔧 Sorun Giderme

### Kurulum Sorunları

#### "Cursor not found" Hatası
```bash
# Cursor'un PATH'te olduğunu kontrol edin
which cursor

# Yoksa symlink oluşturun (macOS)
ln -s "/Applications/Cursor.app/Contents/Resources/app/bin/cursor" /usr/local/bin/cursor
```

#### "Permission denied" Hatası
```bash
# Script'e execute permission verin
chmod +x setup.sh
chmod +x create-project.sh

# Veya sudo ile çalıştırın
sudo ./setup.sh
```

#### Config Dizini Bulunamıyor
```bash
# Manuel olarak oluşturun
mkdir -p "$HOME/Library/Application Support/Cursor/User/.cursor/rules"
```

### Mode Sorunları

#### Modes Çalışmıyor
1. `modes.json` dosyasının doğru yerde olduğunu kontrol edin
2. JSON syntax'ının doğru olduğunu kontrol edin
3. Cursor'u yeniden başlatın

#### Kısayollar Çalışmıyor
1. Cursor preferences'tan keyboard shortcuts'u kontrol edin
2. Çakışan shortcuts olup olmadığını kontrol edin
3. Modes'ların doğru yüklendiğini kontrol edin

### MCP Sorunları

#### MCP Server Başlamıyor
```bash
# Node.js version'ını kontrol edin
node --version

# MCP paketini yeniden yükleyin
npm uninstall -g @supabase/mcp-server
npm install -g @supabase/mcp-server
```

#### Environment Variables Tanınmıyor
```bash
# Shell profile'ınıza ekleyin (.bashrc, .zshrc, etc.)
echo 'export SUPABASE_ACCESS_TOKEN="your_token"' >> ~/.zshrc
source ~/.zshrc
```

## 🔄 Güncelleme

### Sistem Güncellemesi
```bash
# Repository'yi pull edin
git pull origin main

# Güncelleme scriptini çalıştırın
./update-cursor.sh
```

### Manual Güncelleme
```bash
# Yeni rules'ları kopyalayın
cp -r .cursor/rules/* "$CURSOR_CONFIG_DIR/.cursor/rules/"
cp .cursor/modes.json "$CURSOR_CONFIG_DIR/.cursor/"

# Cursor'u yeniden başlatın
```

## 📞 Destek

Kurulum sorunları için:

1. **İlk önce**: [Troubleshooting Guide](troubleshooting.md)'ı kontrol edin
2. **GitHub Issues**: Yeni issue açın ve aşağıdaki bilgileri ekleyin:
   - İşletim sistemi ve versiyonu
   - Cursor versiyonu
   - Hata mesajının tam metni
   - Çalıştırdığınız komutlar

3. **Log Dosyaları**: Gerekirse log dosyalarını paylaşın:
   ```bash
   # Cursor logs
   ls -la ~/Library/Logs/Cursor/
   
   # Setup script logs
   ./setup.sh 2>&1 | tee setup.log
   ```

## 📋 Kurulum Sonrası

Kurulum tamamlandıktan sonra:

1. ✅ [AI Modes Kullanımı](ai-modes.md)'nı okuyun
2. ✅ [İlk projenizi oluşturun](../README.md#hızlı-kurulum)
3. ✅ [Best Practices](ios-best-practices.md)'leri inceleyin
4. ✅ [MCP Integration](mcp-integration.md)'u yapılandırın

---

**Sonraki:** [AI Modes Kullanımı →](ai-modes.md)