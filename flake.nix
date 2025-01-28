{
  inputs = {
    garnix-lib.url = "github:garnix-io/garnix-lib?ref=22f244c723924550983237c2b105a7f56006ab4e";
    User.url = "github:garnix-io/user-module?ref=0dcceb91903541f298f3f8e94193b0bae7800cd0";
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
