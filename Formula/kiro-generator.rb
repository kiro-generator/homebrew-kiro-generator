class KiroGenerator < Formula
  desc "Kiro Agent CLI configuration management"
  homepage "https://kiro-generator.io"
  url "https://github.com/kiro-generator/kiro-generator/releases/download/v0.2.2/kg-arm64-darwin.tar.gz"
  sha256 "f7e36e995079246d5c24ebf4a47e8a51de10120002150b21f25f00eb12eef5fd"
  license "MIT"

  def install
    bin.install "bin/kg"
    (pkgshare/"kg-helper").install "resources/kg-helper/SKILL.md"
    (pkgshare/"kg-helper/references").install Dir["resources/kg-helper/references/*.md"]
    (pkgshare/"kg-helper/assets").install "resources/kg-helper/assets/mappings.json"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kg --version")
  end
end
