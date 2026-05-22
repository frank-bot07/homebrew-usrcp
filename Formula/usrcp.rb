class Usrcp < Formula
  desc "Encrypted local AI memory protocol — your context, your machine, your keys"
  homepage "https://github.com/frank-bot07/usrcp"
  url "https://github.com/frank-bot07/usrcp/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "d17af3814e4f2055bc419dc89ad046d4f9bb38b55c05b88283b45c884e15c451"
  license "Apache-2.0"

  depends_on "node"

  def install
    cd "packages/usrcp-local" do
      system "npm", "ci"
      system "npm", "run", "build"
      system "npm", "install", *std_npm_args
      bin.install_symlink Dir["#{libexec}/bin/*"]
    end
  end

  test do
    output = shell_output("#{bin}/usrcp --help 2>&1", 1)
    assert_match "usrcp", output
  end
end
