class KiroGenerator < Formula
  desc "Kiro Agent CLI configuration management"
  homepage "https://kiro-generator.io"
  url "https://github.com/kiro-generator/kiro-generator/releases/download/v0.3.0/kg-arm64-darwin.tar.gz"
  sha256 "b13161b985c58249b2a673a665cf6004c7deaeeb0ff835693f3ab8d4fa3f32dd"
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
