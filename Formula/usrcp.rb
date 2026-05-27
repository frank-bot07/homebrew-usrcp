class Usrcp < Formula
  desc "Encrypted local AI memory protocol - your context, your machine, your keys"
  homepage "https://github.com/frank-bot07/usrcp"
  url "https://github.com/frank-bot07/usrcp/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "2533bab00f72e28df2d8f3a71bfdb710ae5426a6735802c51db90d4463244f3a"
  license "Apache-2.0"

  depends_on "node@22"

  def install
    ENV.prepend_path "PATH", Formula["node@22"].opt_bin

    cd "packages/usrcp-local" do
      system "npm", "ci"
      system "npm", "run", "build"
      system "npm", "install", *std_npm_args
    end

    cd libexec/"lib/node_modules/usrcp-local" do
      rm_r "node_modules/better-sqlite3/build", force: true
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
