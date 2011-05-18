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

#import "FeedListingResultsModel.h"
#import "FeedListingJSONResponse.h"
#import "GTMNSDictionary+URLArguments.h"

const static NSUInteger kColllumnsBatchSize = 20;
const static NSString *kFeedUrl = @"http://feeds.feedburner.com/TechCrunch";

@implementation FeedListingResultsModel


- (id)init {
  
  if ((self = [super init])) {
    responseProcessor = [[FeedListingJSONResponse alloc] init];
  }
  return self;
}

- (void)dealloc {
  [responseProcessor release];
  [super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	
  NSString *batchSize = [NSString stringWithFormat:@"%lu", (unsigned long)kColllumnsBatchSize];

  // Construct the request.
  NSString *path = @"/ajax/services/feed/load";
  NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"1.0", @"v",
                              kFeedUrl, @"q",
                              batchSize, @"num",
                              nil];
          
  NSString *url = [@"https://ajax.googleapis.com" stringByAppendingFormat:@"%@?%@", path, [parameters gtm_httpArgumentsString]];
  TTURLRequest *request = [TTURLRequest requestWithURL:url delegate:self];
  request.cachePolicy = TTURLRequestCachePolicyNoCache;
  request.response = responseProcessor;
  request.httpMethod = @"GET";

  // Dispatch the request.
  [request send];
}

- (FeedListing *)result {
  
  return [[[responseProcessor listing] copy] autorelease];
}

+ (id)response {
  
  return [[[[self class] alloc] init] autorelease];
}


@end
