Merb::Config[:framework] = {
  :application => Merb.root / "askem.rb",
  :config => [Merb.root / "config", nil],
  :public => [Merb.root / "public", nil],
  :view   => Merb.root / "views",
  :model  => Merb.root / "models",
  :rest   => Merb.root / "src"  # TODO figure the stuff out
#  :helper => Merb.root
}

