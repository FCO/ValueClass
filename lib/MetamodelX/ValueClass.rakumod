unit class MetamodelX::ValueClass is Metamodel::ClassHOW;

method value-class(|) { True }

method add_attribute(Mu \ValueClass, Attribute $attr) {
  $attr does role :: {
    method compose(|) {
      die "Attributes { $.name } can't be rw on a value-class ({ ValueClass.^name })" if $.rw;
      nextsame
    }
  }
  nextsame
}

method set_rw(Mu \ValueClass) {
  die "value-class { ValueClass.^name } can't be rw"
}

method compose(Mu \ValueClass) {
  ValueClass.^add_attribute:
    my $wattr = Attribute.new: :name<$!WHICH>, :package(ValueClass), :is_bound, :type(Str);

  ValueClass.^add_method: "WHICH", method () {
    .return with $wattr.get_value: self;

    my $which = ValueObjAt.new: [
      self.^name,
      |(.^attributes.map: {
        |(.name.substr(2), .get_value(self).WHICH)
      } with self)
    ].join: "|";

    $wattr.set_value: self, $which;

    $which
  } unless ValueClass.^find_method("WHICH", :local);

  my &tweak = method (|) {
    for self.^attributes -> Attribute $attr {
      my \data = $attr.get_value: self;
      die "All attributes of value-class ({ $.^name }) should be value types" unless data.WHICH ~~ ValueObjAt;
      if data.^find_method("STORE") {
        $attr.set_value: self, Proxy.new:
          FETCH => sub (|) { data },
          STORE => sub (|) { die "Value of attribute ({ $attr.name }) from a value-class ({ $.^name }) can't be changed" }
      } else {
        $attr.set_value: self, $attr.get_value(self)<>
      }
    }
  }

  with ValueClass.^find_method: "TWEAK" {
    .wrap: method (|c) { callsame; tweak self, |c }
  } else {
    ValueClass.^add_method: "TWEAK", &tweak;
  }
  nextsame
}
