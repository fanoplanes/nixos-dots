{ pkgs, ... }:

{
  home.packages = with pkgs; [
    sdrangel
    sdrpp
    fldigi
    qpwgraph
  ];
}
