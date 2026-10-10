class Claudash < Formula
  desc "The control room for Claude Code: every session and project on one screen. What a waiting session asks, resume and search conversations, MCP sign-in, branch reviews, specs, snapshots, a security audit and plan limits. Unofficial."
  homepage "https://github.com/jguajardo/claudash"
  version "1.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jguajardo/claudash/releases/download/v1.2.0/claudash-aarch64-apple-darwin.tar.xz"
      sha256 "f3c79557d9fe8a991494de25a4796d9b7869ef8c05a977e728fc402964115b21"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jguajardo/claudash/releases/download/v1.2.0/claudash-x86_64-apple-darwin.tar.xz"
      sha256 "873313b39225c893b225b115c84b5dbd412b886ef1650563ce8eee8c1fccf394"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jguajardo/claudash/releases/download/v1.2.0/claudash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "af53c77436bd2607b68db888d382fe2703ab523aae17d4781cbc87daf6929d44"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jguajardo/claudash/releases/download/v1.2.0/claudash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "df3b3bf7405fb2368b9f591b006f9ae624576a6a0fb6646091434212c0334cb0"
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
