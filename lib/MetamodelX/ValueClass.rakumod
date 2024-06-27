unit class MetamodelX::ValueClass is Metamodel::ClassHOW;

method compose(Mu \ValueClass) {
  ValueClass.^add_method: "WHICH", method () {
    ValueObjAt.new: [
      self.^name,
      |(.^attributes.map: {
        |(.name.substr(2), .get_value(self).WHICH)
      } with self)
    ].join: "|"
  } unless ValueClass.^find_method("WHICH", :local);

  my &tweak = method (|) {
    for self.^attributes -> Attribute $attr {
      my \data = $attr.get_value: self;
      die "All attributes of a value-class should be value type" unless data.WHICH ~~ ValueObjAt;
      $attr.set_value: self, Proxy.new:
        FETCH => sub (|) { data },
        STORE => sub (|) { die "Attribute values of a value-class can't be changed" }
    }
  }
  with ValueClass.^find_method: "TWEAK" {
    .wrap: method (|c) { tweak self, |c; nextsame }
  } else {
    ValueClass.^add_method: "TWEAK", &tweak;
  }
  callsame
}
