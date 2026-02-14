class KiroGenerator < Formula
  desc "Kiro Agent CLI configuration management"
  homepage "https://github.com/kiro-generator/kiro-generator"
  url "https://github.com/kiro-generator/kiro-generator/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "" # Will be calculated on first release
  license "MIT"
  head "https://github.com/kiro-generator/kiro-generator.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    # Install systemd user units (Linux only)
    if OS.linux?
      (prefix/"lib/systemd/user").install "resources/systemd/kiro-generator.service"
      (prefix/"lib/systemd/user").install "resources/systemd/kiro-generator-local@.service"
      (prefix/"lib/systemd/user").install "resources/systemd/kiro-generator.path"
      (prefix/"lib/systemd/user").install "resources/systemd/kiro-generator-local@.path"
    end

    # Install default environment files
    (etc/"kg").install "resources/systemd/global.env"
    (etc/"kg").install "resources/systemd/home.env"

    # Install documentation
    doc.install "README.md"
    (doc/"kg-helper").install "resources/kg-helper/SKILL.md"
    (doc/"kg-helper/references").install Dir["resources/kg-helper/references/*.md"]
  end

  def post_install
    # Reload systemd user daemon on Linux
    if OS.linux?
      system "systemctl", "--user", "daemon-reload" rescue nil
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kg --version")
    
    # Test basic commands
    system bin/"kg", "init"
    assert_predicate testpath/".kiro/generators/manifests/kg.toml", :exist?
  end
end
