class KiroGenerator < Formula
  desc "Kiro Agent CLI configuration management"
  homepage "https://kiro-generator.io"
  url "https://github.com/kiro-generator/kiro-generator/releases/download/v0.2.1/kg-arm64-darwin.tar.gz"
  sha256 "2e1db988420d62c17a830c8ede7806315c2430dbe7cf27570ab1ee25e1b7e50d"
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
