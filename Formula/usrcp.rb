class Usrcp < Formula
  desc "Encrypted local AI memory protocol - your context, your machine, your keys"
  homepage "https://github.com/frank-bot07/usrcp"
  # Install the published npm package (which ships prebuilt dist and resolves
  # its own deps — usrcp-core etc. — from the registry). The formula is
  # deliberately decoupled from the monorepo's internal package layout so a
  # refactor behind the public npm contract can't break the brew install.
  url "https://registry.npmjs.org/usrcp-local/-/usrcp-local-0.2.7.tgz"
  sha256 "8f4a994d1fb94008e6bcd40a7b5ddeb0d356367fecba642fdc758efc6e5a92f2"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/usrcp-local/latest"
    regex(/"version":\s*"([^"]+)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "User Context Protocol", shell_output("#{bin}/usrcp --help 2>&1")
    ENV["HOME"] = testpath
    system bin/"usrcp", "init", "--dev"
    system bin/"usrcp", "status"
  end
end
