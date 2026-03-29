{ self, inputs, ... }: {

	flake.nixosConfigurations.ramoslap = inputs.nixpkgs.lib.nixosSystem {
	  modules = [ 
	    self.nixosModules.ramoslapConfiguration
          ];
	};
}

