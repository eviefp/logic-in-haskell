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
          authorizedSshKeys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCgyRLzazCIXAc+y6Tsgy6ryX+sYTVZEjHhaGYFGqUEoGMwygKUZmO9ykBBb6qxpeAe7q7d/RfxHNsLNyY2DTZmh5niNT8Rpr5EHcWDoD7VBUee0GZ4I/ne/KXrcK7QGQ6rejIDc2FMJtWe+AosyGp2YHVSDpp19ViFk6HUQ1PfYCfwAzbIjfIIkTZfdLAwkzgMDGhYQHWZEv5Bfl2p6DNqXFPAR6jp8eglrp/7tXfayK7Wuw1OR3J7ydEigtOX253cpn7Syv/R8azJAoREFN6QhviiNopUoPI/EbulxY/ABEgR0BShVfgPXv039IjrnP82yVJxsxL5R73B/6nQfYyBsdc9mUs738Wa8G7LHBAd2LuWGsrx0jPSkhYVfvUv6a/1Lg/UUSXC946ohB+od6LROAEtKxU5Ke8LgDABMF/wX6ZCmJNj0eiS7FdPxL8x+7g4LuHip2MyRQNR2O/37oFPh2evMsjUNWLQhfikvgCzlb7ZMlSjzitK/P5OSydXJV8862EZ567GifUWv7/UaYytam9wgnjxzTUYSVcJ1xjWBlGwu3HNWB5L4EYXKQVpgqFo0wmo6xUKiqUzXURUwYipISnZrPK1wNGY3+zJGXHqZTKTJeqC/oqEXAO8vjGYdaMBitV7dR7qWG9Hz49Zs4MBmAnreah0cVZYgpxmqhsgVQ== cardno:31_472_473" ];
          groups = [  ];
          shell = "zsh";
          user = "evie";
        };
      };

      garnix.deployBranch = "master";
    };
  };
}
