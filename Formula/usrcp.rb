class Usrcp < Formula
  desc "Encrypted local AI memory protocol - your context, your machine, your keys"
  homepage "https://github.com/frank-bot07/usrcp"
  # Install the published npm package (which ships prebuilt dist and resolves
  # its own deps — usrcp-core etc. — from the registry). The formula is
  # deliberately decoupled from the monorepo's internal package layout so a
  # refactor behind the public npm contract can't break the brew install.
  url "https://registry.npmjs.org/usrcp-local/-/usrcp-local-0.2.8.tgz"
  sha256 "3dcf14a57a6d97955832db4868a809d0ccaaf0e171a05d01ed8a7f33b71bbcea"
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
