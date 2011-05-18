//
// Copyright 2010 Jared Verdi
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// Author: Jared Verdi, Co-Founder: Thumb Labs 
// Contact: jared@thumblabs.com
// URL: http://www.thumblabs.com
//

#import "ColllumnsAppDelegate.h"
#import "FeedListingController.h"
#import "FeedArticleController.h"
#import "ColllumnsStyles.h"

@implementation ColllumnsAppDelegate

@synthesize shadow, window;

- (void)dealloc {
  [window release];
  [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
	[[TTURLRequestQueue mainQueue] setMaxContentLength:0];
	
	[TTStyleSheet setGlobalStyleSheet:[[[ColllumnsStyles alloc] init] autorelease]];
	
	TTNavigator* navigator = [TTNavigator navigator];
	navigator.supportsShakeToReload = NO;
	navigator.persistenceMode = TTNavigatorPersistenceModeAll;
	navigator.delegate = self;
	
	TTURLMap* map = navigator.URLMap;
	[map from:@"*" toViewController:[TTWebController class]];
	[map from:@"tt://feedlisting" toViewController:[FeedListingController class]];
	[map from:@"tt://feedarticle/(initWithName:)" toViewController:[FeedArticleController class]];
	
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
  navigator.window = window;
  
	[navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://feedlisting"]];
	
	shadow = [[UIImageView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] applicationFrame].origin.y + 44, 320, 10)];
	shadow.image = [UIImage imageNamed:@"topshadow.png"];
	[navigator.window addSubview:shadow];
  [shadow release];
	
	[navigator.window makeKeyAndVisible];
	
  return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	
	[[TTURLCache sharedCache] removeAll:YES];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	
	[[TTURLCache sharedCache] removeAll:YES];
}


@end
