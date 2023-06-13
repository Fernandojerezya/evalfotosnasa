{ pkgs }: {
  deps = [
    pkgs.run
    pkgs.ruby_3_1
    pkgs.rubyPackages_3_1.solargraph
  ];
}