class Claudash < Formula
  desc "The control room for Claude Code: sessions that need you, where your plan limits and dollars went, MCP, specs and secrets in transcripts. Unofficial."
  homepage "https://github.com/jguajardo/claudash"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jguajardo/claudash/releases/download/v1.0.0/claudash-aarch64-apple-darwin.tar.xz"
      sha256 "357fc3aef3c2a7bc5c4eefcaeb58ebe559b7081e567ab3713e9855327e856003"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jguajardo/claudash/releases/download/v1.0.0/claudash-x86_64-apple-darwin.tar.xz"
      sha256 "35a4ff3994f2eb07834b0d2eb5b9977ade48b3b16ee678cb675c1a5028c2c261"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jguajardo/claudash/releases/download/v1.0.0/claudash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "aa783844028a728b6cf1645fe3024a8004af7114d6209ccb2da73a51987f90ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jguajardo/claudash/releases/download/v1.0.0/claudash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "378c0116519f41cf74975cd851b30e16660fd36e5c84d57a3cef4555cd365a18"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "claudash"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "claudash"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "claudash"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "claudash"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
