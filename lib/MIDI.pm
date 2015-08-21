use v6;

class MIDI:auth<github:jonathanstowe>:ver<v0.0.1> {

    has Str $!filename;
    has IO::Handle $!file-handle;

    class Track {
        class Event {
        }

        has Str     $.MTrk      = "MTrk";
        has uint32  $.length    = 0;

        has Event @.events;

    }

    class Header {
        has Str     $.preamble          = "MThd";
        has uint32  $.header-length     = 6;
        has uint16  $.format            = 1;
        has uint16  $.track-chunks      = 0;
        has uint16  $.division          = 96;

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
