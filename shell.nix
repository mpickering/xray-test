let
  np = import <nixpkgs> {};
in
  np.mkShell { buildInputs = [ np.clang np.graphviz np.llvm_6 np.simple-server]; }
