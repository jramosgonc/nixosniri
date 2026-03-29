{ self, inputs, ... }: {

	flake.nixosConfigurations.ramos = inputs.nixpkgs.lib.nixosSystem {
	  modules = [ 
	    self.nixosModules.ramosConfiguration
          ];
	};
}

