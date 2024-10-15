{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShell = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          bashInteractive
          cmake
          ninja
        ] ++ (with llvmPackages_19; [
          clang
          clang-unwrapped
          lld
          llvm
        ]);

        hardeningDisable = [ "all" ];
      };
    }
  );
}
