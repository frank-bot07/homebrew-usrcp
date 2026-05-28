class Usrcp < Formula
  desc "Encrypted local AI memory protocol - your context, your machine, your keys"
  homepage "https://github.com/frank-bot07/usrcp"
  url "https://github.com/frank-bot07/usrcp/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "0b44de7d33d013e434a8eb4d18aeb7b42809499aa327baf47d98b7e94c22f648"
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
