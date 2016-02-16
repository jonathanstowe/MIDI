use v6.c;

use experimental :pack;

class MIDI:auth<github:jonathanstowe>:ver<0.0.1> {

    has Str        $!filename;
    has IO::Handle $!file-handle;

    class Track {
        class Event {
        }

        has Str     $.MTrk      = "MTrk";
        has Int  $.length    = 0;

        has Event @.events;

    }

    class Header {
        has Str     $.preamble          = "MThd";
        has Int     $.header-length     = 6;
        has Int     $.format            = 1;
        has Int     $.track-chunks      = 0;
        has Int     $.division          = 96;

        my Str $pattern = "A4 N n n n";
        my Int $length  = 14;

        has IO::Handle $!file-handle;
        has Buf $!buf;

        multi submethod BUILD(:$!file-handle!) {
            $!buf = $!file-handle.read($length);
            ($!preamble, $!header-length, $!format, $!track-chunks, $!division) = $!buf.unpack($pattern);
        }

    }

    has Header $.header;
    has Track @.tracks;

    multi submethod BUILD(Str() :$!filename!) {
        $!file-handle = $!filename.IO.open(:bin, :r);
        $!header = Header.new(:$!file-handle);
    }
}
# vim: expandtab shiftwidth=4 ft=perl6
