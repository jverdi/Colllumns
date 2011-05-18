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

#import "ListingTableMessageItem.h"


@implementation ListingTableMessageItem

@synthesize title     = _title;
@synthesize caption   = _caption;
@synthesize timestamp = _timestamp;


- (void)dealloc {
  TT_RELEASE_SAFELY(_title);
  TT_RELEASE_SAFELY(_caption);
  TT_RELEASE_SAFELY(_timestamp);

  [super dealloc];
}

- (void)cellTapped {
  NSLog(@"test");
}

+ (id)itemWithTitle:(NSString*)title text:(NSString*)text
          timestamp:(NSDate*)timestamp {
  
  ListingTableMessageItem* item = [[[self alloc] init] autorelease];
  item.title = title;
  item.text = text;
  item.timestamp = timestamp;
  return item;
}

+ (id)itemWithTitle:(NSString*)title text:(NSString*)text 
		   timestamp:(NSDate*)timestamp delegate:(id)delegate 
		   selector:(SEL)selector {
  
  ListingTableMessageItem* item = [[[self alloc] init] autorelease];
  item.title = title;
  item.text = text;
  item.timestamp = timestamp;
  item.delegate = delegate;
  item.selector = selector;
  return item;
}

- (id)initWithCoder:(NSCoder*)decoder {
  
  if (self = [super initWithCoder:decoder]) {
    self.title = [decoder decodeObjectForKey:@"title"];
    self.timestamp = [decoder decodeObjectForKey:@"timestamp"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  
  [super encodeWithCoder:encoder];
  
  if (self.title) {
    [encoder encodeObject:self.title forKey:@"title"];
  }
  if (self.timestamp) {
    [encoder encodeObject:self.timestamp forKey:@"timestamp"];
  }
}


@end
