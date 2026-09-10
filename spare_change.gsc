main()
{
	function = getfunction( "maps/mp/zm_tomb_ee_side", "check_for_change" );

	if( isdefined( function ) )
		replacefunc( function, common_scripts\utility::empty );
}

init()
{
	level thread spare_change();
}

spare_change()
{
	a_t_audio = getentarray( "audio_bump_trigger", "targetname" );

	if( isdefined( a_t_audio ) )
	{
		for( i = 0; i < a_t_audio.size; i++ )
		{
			if( a_t_audio[ i ].script_sound == "zmb_perks_bump_bottle" )
				a_t_audio[ i ] thread check_for_change();
		}
	}
}

check_for_change()
{
	self endon( "death" );

	while( true )
	{
		self waittill( "trigger", e_player );

		if( e_player getstance() == "prone" )
		{
			e_player maps\mp\zombies\_zm_score::add_to_player_score( 100 );
			maps\mp\zombies\_zm_utility::play_sound_at_pos( "purchase", e_player.origin );
			break;
		}

		wait 0.1;
	}
}