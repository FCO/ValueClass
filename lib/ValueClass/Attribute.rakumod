use Tuple;
use ValueMap;
unit class ValueClass::Attribute is Attribute;

method compose(|) {
  die "Attributes { $.name } can't be rw on a value-class ({ ValueClass.^name })" if $.rw;
  nextsame
}

method container_initializer(|c) {
  use nqp;
  my $has-build = so nqp::isconcrete(self.build);
  my $ah        = so $.name.starts-with: <@ %>.any;
  if $has-build && $ah {
    die qq:to/END/
    Defaults on compound attribute types not yet implemented. Sorry.
    Workaround: Create/Adapt TWEAK method in class { $.package.^name }, e.g:

      method TWEAK() \{
        { $.name } := { $.name.starts-with("@") ?? "Tuple" !! "ValueMap" }.new(initial values) unless { $.name };
      }
    END
  }
  if $.name.starts-with: '@' {
    return -> { Tuple.new }
  } elsif $.name.starts-with: '%' {
    return -> { ValueMap.new }
  }
  nextsame
}
