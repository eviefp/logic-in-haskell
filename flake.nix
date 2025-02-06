{
  inputs = {
    garnix-lib.url = "github:garnix-io/garnix-lib";
    User.url = "github:garnix-io/user-module";
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
          user = "asdf";
        };
      };

      garnix.deployBranch = "master";
    };
  };
}
