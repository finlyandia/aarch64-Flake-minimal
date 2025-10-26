{
  lib,
  config,
  ...
}: let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.user;

in {
  options.module.user.enable = mkEnableOption "";
  config = mkIf cfg.enable {
    users = { 
      mutableUsers = false;
      users = {
        user = {
          isNormalUser = true;
          hashedPassword = 123123;
          extraGroups = [ "wheel" ];
          createHome = true;
          home = "/home/user";
        };
      };
    };
  };
}
