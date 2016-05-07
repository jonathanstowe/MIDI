#!perl6

use v6.c;
use Test;

use Audio::MIDI;

my $test-data = "t/data".IO;

my $mandelbrot = $test-data.child('mandelbrot.mid');

my $obj;

lives-ok { $obj = Audio::MIDI.new(filename => $mandelbrot) }, "new Audio::MIDI object with filename";

isa-ok($obj, Audio::MIDI, "right sort of object");

ok($obj.header.defined, "header is defined");
isa-ok($obj.header, Audio::MIDI::Header, "and got the right sort of thing");
is($obj.header.preamble, "MThd", "got correct preamble");
is($obj.header.division, 96, "got correct division");
is($obj.header.track-chunks,1, "got no track chunks");
is($obj.header.format, 1, "got correct format");
is($obj.header.header-length, 6, "header-length");

done-testing;


# vim: expandtab shiftwidth=4 ft=perl6
