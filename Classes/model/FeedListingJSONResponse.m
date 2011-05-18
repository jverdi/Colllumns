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

#import "FeedListingJSONResponse.h"
#import "FeedListing.h"
#import "FeedArticle.h"
#import "NSString+SBJSON.h"
#import "NSDictionary+EmptyStrings.h"
#import "NSString+HTML.h"

//http://code.google.com/apis/feed/v1/jsondevguide.html#resultJson

static const NSString *kGoogleReaderDateFmt = @"EEE, dd MMM yyyy HH:mm:ss zz";

@implementation FeedListingJSONResponse

@synthesize listing;

- (id)init {
  
  if ((self = [super init])) {
    listing = [[FeedListing alloc] init];
  }
  return self;
}

- (void)dealloc {
  
  [listing release];
  [super dealloc];
}

- (NSError*)request:(TTURLRequest*)request processResponse:(NSHTTPURLResponse*)response data:(id)responseData {
  
  NSString *responseBody = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
  
  NSDictionary *json = [responseBody JSONValue];
  [responseBody release];

  NSDictionary *resultSet = [json objectForKey:@"responseData"];

  NSDictionary *feed = [resultSet objectForKey:@"feed"];

  listing.url = [feed stringForKey:@"feedUrl"];
  listing.title = [[feed stringForKey:@"title"] stringByDecodingHTMLEntities];
  listing.link = [feed stringForKey:@"link"];
  listing.author = [[feed stringForKey:@"author"] stringByDecodingHTMLEntities];
  listing.description = [[feed stringForKey:@"description"] stringByDecodingHTMLEntities];
  listing.type = [feed stringForKey:@"type"];

  NSArray *entries = [feed objectForKey:@"entries"];

  listing.entries = [[NSMutableArray alloc] initWithCapacity:[entries count]];

  if([entries count] > 0) {

    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    [dateFmt setDateFormat:(NSString *)kGoogleReaderDateFmt];
    
    for (NSDictionary *entry in entries) {
      FeedArticle *article = [[FeedArticle alloc] init];
      article.media = [entry objectForKey:@"mediaGroups"];
      article.title = [[entry stringForKey:@"title"] stringByDecodingHTMLEntities];
      article.link = [entry stringForKey:@"link"];
      article.author = [[entry stringForKey:@"author"] stringByDecodingHTMLEntities];
      article.publishedDate = [dateFmt dateFromString:[entry stringForKey:@"publishedDate"]];
      article.contentSnippet = [entry stringForKey:@"contentSnippet"];
      article.content = [entry stringForKey:@"content"];
      article.categories = [entry objectForKey:@"categories"];
      
      [listing.entries addObject:article];
      
      [article release];
    }

    [dateFmt release];
  }

  return nil;
}

+ (id)response {
  return [[[[self class] alloc] init] autorelease];
}

@end
