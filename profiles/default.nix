{
  imports = [
    ../modules/hardware/default.nix
    ../modules/users/default.nix
    ../modules/ssh/default.nix
  ];
  module = {
    hardware.enable = true;
    user.enable = true;
    ssh.enable = true;
  };
}
