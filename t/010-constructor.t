#!perl6

use v6;
use lib 'lib';
use Test;

use MIDI;

my $test-data = "t/data".IO;

my $empty = $test-data.child('empty.mid');

my $obj;

lives-ok { $obj = MIDI.new(filename => $empty) }, "new MIDI object with filename";

isa-ok($obj, MIDI, "right sort of object");

ok($obj.header.defined, "header is defined");
isa-ok($obj.header, MIDI::Header, "and got the right sort of thing");
is($obj.header.preamble, "MThd", "got correct preamble");
is($obj.header.division, 96, "got correct division");
is($obj.header.track-chunks,1, "got no track chunks");
is($obj.header.format, 1, "got correct format");
is($obj.header.header-length, 6, "header-length");

done;


# vim: expandtab shiftwidth=4 ft=perl6
