use v6;

use experimental :pack;

class Audio::MIDI:auth<github:jonathanstowe>:ver<0.0.1> {

    role Picture[Str $picture] {
        has Str $.picture = $picture;
    }

    multi sub trait_mod:<is> (Attribute $a, Str :$picture!) {
        $a does Picture[$picture];
    }

    role BlobData[Int :$length]  {
    }

    has Str        $!filename;
    has IO::Handle $!file-handle;

    class Track {
        class Event {
            has Int $.timestamp;
            has Int $.status;
            has Int $.data-one;
            has Int $.data-two;
        }

        has Str     $.MTrk      = "MTrk";
        has Int     $.length    = 0;

        has Event @.events;

    }

    class Header {
        has Str     $.preamble          is picture('A4')    = "MThd";
        has Int     $.header-length     is picture('N')     = 6;
        has Int     $.format            is picture('n')     = 1;
        has Int     $.track-chunks      is picture('n')     = 0;
        has Int     $.division          is picture('n')     = 96;

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
