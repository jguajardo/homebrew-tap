class Claudash < Formula
  desc "The control room for Claude Code: every session and project on one screen. What a waiting session asks, resume and search conversations, MCP sign-in, branch reviews, specs, snapshots, a security audit and plan limits. Unofficial."
  homepage "https://jguajardo.github.io/claudash/"
  version "1.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jguajardo/claudash/releases/download/v1.3.0/claudash-aarch64-apple-darwin.tar.xz"
      sha256 "7b9fabdd87bef52c5da6450ae902f3d37c4a4af8bb8ab7a6fef32d6be5661698"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jguajardo/claudash/releases/download/v1.3.0/claudash-x86_64-apple-darwin.tar.xz"
      sha256 "ac8c2ae20293acaca2a59657ca5d79300e0386ca29d355c6e84821ed297723b2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jguajardo/claudash/releases/download/v1.3.0/claudash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "801644062d0af3f45cd4c3ece36dec2ef04d44f91e757420cbc36514b96bd01b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jguajardo/claudash/releases/download/v1.3.0/claudash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "152839207f01e200404f63ac5351a6c10e5af29c07e68eaaadeb5ebbdb9194dc"
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
