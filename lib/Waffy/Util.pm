package Waffy::Util;

use strict;
use warnings;
use base qw( Exporter );
use Mojo::Script;
use Path::Class;
use POSIX qw( strftime );

our @EXPORT = qw( home path_to is_iphone is_mobile_jp epoch2datetime );

sub home {
    my $file = Mojo::Script->new->class_to_path( __PACKAGE__ );
    if ( my $entry = $INC{ $file } ) {
        my $path = file( $entry )->absolute->cleanup->stringify;
        $path =~ s/$file$//;
        my $home = dir($path);
        $home = $home->parent while $home =~ /(b?lib|site_perl)$/;
        return $home->stringify if -d $home;
    }
}

sub path_to {
    my @path = @_;
    my $home = home(__PACKAGE__);
    my $path = dir($home, @path);
    return $path if -d $path;
    return file($home, @path);
}

sub epoch2datetime {
    return strftime '%Y-%m-%dT%H:%M:%S', localtime( shift || time );
}

sub is_iphone {
    my $user_agent = shift;
    my $iPhoneRE = '^Mozilla/\d\.\d \(iPhone;';
    return $user_agent =~ m#$iPhoneRE#;
}

sub is_mobile_jp {
    my $user_agent = shift;
    my $DoCoMoRE          = '^DoCoMo/\d\.\d[ /]';
    my $JPhoneRE          = '^(?i:J-PHONE/\d\.\d)';
    my $VodafoneRE        = '^Vodafone/\d\.\d';
    my $VodafoneMotRE     = '^MOT-';
    my $SoftBankRE        = '^SoftBank/\d\.\d';
    my $SoftBankCrawlerRE = '^Nokia[^/]+/\d\.\d';
    my $EZwebRE           = '^(?:KDDI-[A-Z]+\d+[A-Z]? )?UP\.Browser\/';
    my $AirHRE            = '^Mozilla/3\.0\((?:WILLCOM|DDIPOCKET)\;';
    my $MobileAgentRE     = qr/(?:($DoCoMoRE)|($JPhoneRE|$VodafoneRE|$VodafoneMotRE|$SoftBankRE|$SoftBankCrawlerRE)|($EZwebRE)|($AirHRE))/;
    return $user_agent =~ m#$MobileAgentRE#;
}

1;
