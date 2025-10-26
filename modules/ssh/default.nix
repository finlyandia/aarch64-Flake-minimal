{ 
  config,
  ...
}: let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.ssh;

in {
  options.module.ssh.enable = mkEnableOption "";
  config = mkIf cfg.enable {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };
}
