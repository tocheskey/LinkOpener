/**
 * LinkOpener- Opens links in 3rd party apps.
 *
 * By Ad@m <http://hbang.ws and changed by adaminsull>
 * Licensed under the GPL license <(http://www.gnu.org/copyleft/gpl.html>
 */

%hook SpringBoard
-(void)_openURLCore:(NSURL *)url display:(id)display publicURLsOnly:(BOOL)publicOnly animating:(BOOL)animated additionalActivationFlag:(unsigned int)flags {
	if (([[url scheme] isEqualToString:@"http"] || [[url scheme] isEqualToString:@"https"])
		&& ([[url host] isEqualToString:@"twitter.com"] || [[url host] isEqualToString:@"www.twitter.com"])
		&& [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]
                && [[url pathComponents] count] == 2 ) {
		NSArray *params = [[url query] componentsSeparatedByString:@"&"];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitter://user?screen_name=" stringByAppendingString:[[url pathComponents] objectAtIndex:1]]]];
	%orig;
        return;
}
%end
