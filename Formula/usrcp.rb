class Usrcp < Formula
  desc "Encrypted local AI memory protocol — your context, your machine, your keys"
  homepage "https://github.com/frank-bot07/usrcp"
  url "https://github.com/frank-bot07/usrcp/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "706bbf6c11fdd7426bce525504c637be05ee3df14074355e83fd40a24389c5ea"
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
    output = shell_output("\"#{bin}/usrcp\" --help 2>&1", 1)
    assert_match "usrcp", output
  end
end
