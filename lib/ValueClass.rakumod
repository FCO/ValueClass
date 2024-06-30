use MetamodelX::ValueClassHOW;
use ValueClass::Attribute;

my package EXPORTHOW {
    package DECLARE {
        constant value-class = MetamodelX::ValueClassHOW;
        constant value-class-attr = ValueClass::Attribute;
    }
}

use Tuple;
use ValueMap;

sub EXPORT(|) {
    Map.new: {
        Tuple    => Tuple,
        ValueMap => ValueMap,
    }
}

=begin pod

=head1 NAME

ValueClass - A way to create immutable value objects

=head1 SYNOPSIS

=begin code :lang<raku>
use ValueClass;

value-class Bla {
    has $.a = 42;
    has @.b;
    has %.c;

    method TWEAK() {
        %!c := ValueMap.new: (a => 1)
    }
}

say Bla.new: :b[1,2,3];
# Bla.new(a => 42, b => Tuple.new(1, 2, 3), c => ValueMap.new((:a(1))))

=end code

=head1 DESCRIPTION

ValueClass creates immutable objects.

If you are only worried about other people mutating your objects, you may take a look at [ValueType](https://raku.land/zef:lizmat/ValueType).
But if you want to avoid letting even yourself, on your internal methods, mutate your objects, you will probably need something like this
module.

Classes created using the value-class keyword will create objects that will die whenever anyone try to mutate them.
It will also die when the object is created with any attribute that's not a value type.

The object will become immutable just after TWEAK. So TWEAK is your last chance to mutate your objects.

(It does not allow default values for `@` and `%` sigled attributes. You will need to use `TWEAK` to populate them)

ValueType will change the default type for a attribute using the @ to Tuple and the % to ValueMap to make it possible to use Positionals and
Associative on ValueClass.

=head1 AUTHOR

Fernando Corrêa de Oliveira <fco@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2024 Fernando Corrêa de Oliveira

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
