{
  inputs = {

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    }; 

    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
    };

  };

  outputs = { 
    self, 
    nixpkgs, 
    nixos-hardware
  }: 

  {
    nixosConfigurations = {
      rpi4 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./profiles/default.nix
          nixos-hardware.nixosModules.raspberry-pi-4
        ];
      };
    };
  };
}
