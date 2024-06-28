use MetamodelX::ValueClass;

my package EXPORTHOW {
    package DECLARE {
        constant value-class = MetamodelX::ValueClass;
    }
}

=begin pod

=head1 NAME

ValueClass - blah blah blah

=head1 SYNOPSIS

=begin code

➜  ValueClass git:(main) raku -Ilib -MValueClass -e '


value-class Bla { has $.a = 42; has @b }

my $bla = Bla.new: :a(3.14);

say $bla.WHICH;

say $bla.a;

'
All attributes of a value-class should be value type
  in method <anon> at /Users/fernando/ValueClass/lib/MetamodelX/ValueClass.rakumod (MetamodelX::ValueClass) line 16
  in block <unit> at -e line 6

➜  ValueClass git:(main) raku -Ilib -MValueClass -e '


value-class Bla { has $.a = 42; method should-not-be-allowed { $!a = 13 } }

my $bla = Bla.new: :a(3.14);

say $bla.WHICH;

say $bla.a;

$bla.should-not-be-allowed

'
Bla|a|Rat|157/50
3.14
Attribute values of a value-class can't be changed
  in sub  at /Users/fernando/ValueClass/lib/MetamodelX/ValueClass.rakumod (MetamodelX::ValueClass) line 19
  in method should-not-be-allowed at -e line 4
  in block <unit> at -e line 12

=end code

=head1 DESCRIPTION

ValueClass is ...

=head1 AUTHOR

Fernando Corrêa de Oliveira <fernando.correa@humanstate.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2024 Fernando Corrêa de Oliveira

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
