use Tuple;
use ValueMap;
unit class ValueClass::Attribute is Attribute;

method compose(|) {
  die "Attributes { $.name } can't be rw on a value-class ({ ValueClass.^name })" if $.rw;
  nextsame
}

method container_initializer(|c) {
  if $.name.starts-with: '@' {
    return -> { Tuple.new }
  } elsif $.name.starts-with: '%' {
    return -> { ValueMap.new }
  }
  nextsame
}
