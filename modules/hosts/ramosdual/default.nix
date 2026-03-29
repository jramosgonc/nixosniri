{ self, inputs, ... }: {

	flake.nixosConfigurations.ramosdual = inputs.nixpkgs.lib.nixosSystem {
	  modules = [ 
	    self.nixosModules.ramosdualConfiguration
          ];
	};
}

