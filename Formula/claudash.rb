class Claudash < Formula
  desc "The control room for Claude Code: sessions that need you, where your plan limits and dollars went, MCP, specs and secrets in transcripts. Unofficial."
  homepage "https://github.com/jguajardo/claudash"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jguajardo/claudash/releases/download/v1.1.0/claudash-aarch64-apple-darwin.tar.xz"
      sha256 "ec7babb87ff534f684ed0122164315892652888fdf30d202d3c78257bfdd6ba2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jguajardo/claudash/releases/download/v1.1.0/claudash-x86_64-apple-darwin.tar.xz"
      sha256 "d3abeb79f592301f2398df61649f8843b4f9ea41aefde4bab04d96406d953382"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jguajardo/claudash/releases/download/v1.1.0/claudash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5dc8f3be56711437b280846160c817c0ab10d3252761474d57324f2c8813e5ab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jguajardo/claudash/releases/download/v1.1.0/claudash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "66e5205dfc331f7d543a88c51cf275db8ee5bb3a7e1c3fa3d7dddf8c648a9b71"
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
