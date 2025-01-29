{
  inputs = {
    garnix-lib.url = "github:garnix-io/garnix-lib?ref=ed90ee8a52715b5e0e35b304b21dc64f4ceb30a5";
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
          user = "evie";
        };
      };

      garnix.deployBranch = "master";
    };
  };
}
