{
  inputs = {
    garnix-lib.url = "github:garnix-io/garnix-lib?ref=0573417fc462b0eeed5d762c8fe08093afb35a3d";
    User.url = "github:garnix-io/user-module?ref=df33c072965493308bb35def15b025db437d7e4e";
  };

  nixConfig = {
    extra-substituters = [ "https://cache.garnix.io" ];
    extra-trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
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
