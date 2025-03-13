{
  inputs = {
    garnix-lib.url = "github:garnix-io/garnix-lib";
    PostgreSQL.url = "github:garnix-io/postgresql-module";
    User.url = "github:garnix-io/user-module";
  };

  nixConfig = {
    extra-substituters = [ "https://cache.garnix.io" ];
    extra-trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
  };

  outputs = inputs: inputs.garnix-lib.lib.mkModules {
    modules = [
      inputs.PostgreSQL.garnixModules.default
      inputs.User.garnixModules.default
    ];

    config = { pkgs, ... }: {
      postgresql = {
        postgresql-project = {
          port = 5432;
        };
      };
      user = {
        user-project = {
          authorizedSshKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINBLUMCHFgEo647k0NSAzVybQLndXxPdVyOaN4ua9DF2 me@eevie.ro" ];
          groups = [  ];
          shell = "fish";
          user = "evie";
        };
      };

      garnix.deployBranch = "master";
    };
  };
}
