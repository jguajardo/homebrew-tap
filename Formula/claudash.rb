class Claudash < Formula
  desc "The control room for Claude Code: every session and project on one screen. What a waiting session asks, resume and search conversations, MCP sign-in, branch reviews, specs, snapshots, a security audit and plan limits. Unofficial."
  homepage "https://github.com/jguajardo/claudash"
  version "1.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jguajardo/claudash/releases/download/v1.1.2/claudash-aarch64-apple-darwin.tar.xz"
      sha256 "3d6e87d98b44ed7164cf0755a147af86d280077b8e6d6115e3f74fc960459c03"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jguajardo/claudash/releases/download/v1.1.2/claudash-x86_64-apple-darwin.tar.xz"
      sha256 "e410ee23e442496afd83f31bd9fd677bf1a7369e06ba116950c0765dd98dfd90"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jguajardo/claudash/releases/download/v1.1.2/claudash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f9e014ebe594000b8566ade76324d1430954a1e9197555bc8358309767fc9597"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jguajardo/claudash/releases/download/v1.1.2/claudash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dbe10ffec8a5f0b321b63275f58849da67d6ca37873d6ac25d0bde7b3f4a3f66"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

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
