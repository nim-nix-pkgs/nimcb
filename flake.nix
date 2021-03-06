{
  description = ''Integrate nim projects in the C++Builder build process'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."nimcb-master".dir   = "master";
  inputs."nimcb-master".owner = "nim-nix-pkgs";
  inputs."nimcb-master".ref   = "master";
  inputs."nimcb-master".repo  = "nimcb";
  inputs."nimcb-master".type  = "github";
  inputs."nimcb-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimcb-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}