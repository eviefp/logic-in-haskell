{
  inputs = {
    garnix-lib.url = "github:garnix-io/garnix-lib?ref=22f244c723924550983237c2b105a7f56006ab4e";
    User.url = "github:garnix-io/user-module?ref=8513236d257ea480bea3ffef1bf633088b2c86df";
  };

  outputs = inputs: inputs.garnix-lib.lib.mkModules {
    modules = [
      inputs.User.garnixModules.default
    ];

    config = { pkgs, ... }: {
      user = {
        user-project = {
          authorizedSshKeys = [  ];
          groups = [  ];
          shell = "bash";
          user = "aaaa";
        };
      };

      garnix.deployBranch = "master";
    };
  };
}
