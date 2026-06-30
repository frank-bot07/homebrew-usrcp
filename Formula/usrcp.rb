class Usrcp < Formula
  desc "Encrypted local AI memory protocol - your context, your machine, your keys"
  homepage "https://github.com/frank-bot07/usrcp"
  # Install the published npm package (which ships prebuilt dist and resolves
  # its own deps — usrcp-core etc. — from the registry). The formula is
  # deliberately decoupled from the monorepo's internal package layout so a
  # refactor behind the public npm contract can't break the brew install.
  url "https://registry.npmjs.org/usrcp-local/-/usrcp-local-0.2.0.tgz"
  sha256 "11ea1d4ee9aea33cf5d60827674be7289de6a2f02353cdb6bf5830a7af8e3b8b"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/usrcp-local/latest"
    regex(/"version":\s*"([^"]+)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    # std_npm_args runs npm with --ignore-scripts (Homebrew's default), so the
    # package's postinstall did not rebuild the better-sqlite3 native binding.
    # Rebuild it against this Node so the ledger opens.
    cd libexec/"lib/node_modules/usrcp-local" do
      rm_rf "node_modules/better-sqlite3/build"
      system "npm", "rebuild", "better-sqlite3"
    end
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "User Context Protocol", shell_output("#{bin}/usrcp --help 2>&1")
    ENV["HOME"] = testpath
    system bin/"usrcp", "init", "--dev"
    system bin/"usrcp", "status"
  end
end
