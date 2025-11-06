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
    services.displayManager.autoLogin = {
      enable = true;
      user = "user"; 
    };
    users = { 
      mutableUsers = false;
      users = {
        user = {
          isNormalUser = true;
          password = "12345";
          extraGroups = [ "wheel" ];
          createHome = true;
          home = "/home/user";
        };
      };
    };
  };
}
