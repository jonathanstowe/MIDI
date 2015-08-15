use v6;

class MIDI:auth<github:jonathanstowe>:ver<v0.0.1> {
    class Header {
        has Str     $.MThd          = "MThd";
        has uint32  $.header-length = 6;
        has uint16  $.format        = 1;
        has uint16  $.track-chunks  = 0;
        has uint16  $.division      = 96;
    }

=begin comment

say MIDI::Header.new;
#!perl6

use v6;

my $file = open "foo.mid", :bin;

my Buf $buf = Buf.new();

my Str $preamble;
my Int $header_length;
my Int $format;
my Int $n;
my Int $division;

my Buf $header = $file.read(14);

($preamble, $header_length, $format, $n, $division ) = $header.unpack("A4 N n n n");

say $header;


say $preamble;
say $header_length;
say $format;
say $n;
say $division;

=end comment

}
# vim: expandtab shiftwidth=4 ft=perl6
