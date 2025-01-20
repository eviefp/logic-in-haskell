{
  inputs = {
    garnix-lib.url = "github:garnix-io/garnix-lib?ref=9ceb30a47e1ca5bcdfa3744da6c9cd27a4bdd141";
    Haskell.url = "github:garnix-io/haskell-module?ref=6e804778ea4a15c7e2abc585082cb004f55c0d20";
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
          ghcVersion = "9.0";
          runtimeDependencies = [  ];
          src = ./.;
          webServer = null;
        };
      };

      garnix.deployBranch = "master";
    };
  };
}
