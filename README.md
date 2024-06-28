[![Actions Status](https://github.com/FCO/ValueClass/actions/workflows/test.yml/badge.svg)](https://github.com/FCO/ValueClass/actions)

NAME
====

ValueClass - blah blah blah

SYNOPSIS
========

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

DESCRIPTION
===========

ValueClass is ...

AUTHOR
======

Fernando Corrêa de Oliveira <fernando.correa@humanstate.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2024 Fernando Corrêa de Oliveira

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

