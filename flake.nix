{
  inputs = {
    garnix-lib.url = "github:garnix-io/garnix-lib?ref=22f244c723924550983237c2b105a7f56006ab4e";
    Haskell.url = "github:garnix-io/haskell-module?ref=703b7b9b3fa3d8aa5ac6c599fabfea4947fb2533";
  };

  outputs = inputs: inputs.garnix-lib.lib.mkModules {
    modules = [
      inputs.Haskell.garnixModules.default
    ];

    config = { pkgs, ... }: {
      haskell = {
        haskell-project = {
          buildDependencies = [  ];
          devTools = [  ];
          ghcVersion = "9.8";
          runtimeDependencies = [  ];
          src = ./.;
          webServer = null;
        };
      };

      garnix.deployBranch = "master";
    };
  };
}
