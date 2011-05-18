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

#import "FeedListingDataSource.h"
#import "FeedListingResultsModel.h"
#import "FeedListing.h"
#import "FeedArticle.h"
#import "ListingTableMessageItem.h"
#import "ListingTableMessageItemCell.h"

@implementation FeedListingDataSource

@synthesize tapDelegate, tapSelector;


- (void)dealloc {
	[super dealloc];
}

- (void)tableViewDidLoadModel:(UITableView *)tableView {
  
  [super tableViewDidLoadModel:tableView];

  [self.items removeAllObjects];

  FeedListing *listing = (FeedListing *)[(FeedListingResultsModel *)self.model result];

  for (FeedArticle *article in [listing entries]) {

    ListingTableMessageItem* tmi = 
      [ListingTableMessageItem itemWithTitle:article.author
                                          text:article.title
                                     timestamp:article.publishedDate
                                      delegate:self.tapDelegate
                                      selector:self.tapSelector];



    [self.items addObject:tmi];
  }
}

- (void)setTapDelegate:(id)delegate selector:(SEL)selector {
  
  self.tapDelegate = delegate;
  self.tapSelector = selector;
}

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id) object { 
	
	if ([object isKindOfClass:[ListingTableMessageItem class]]) { 
		return [ListingTableMessageItemCell class]; 	
	}
  else { 
		return [super tableView:tableView cellClassForObject:object]; 
	}
}

- (UIImage*)imageForEmpty {
	return [UIImage imageNamed:@"Three20.bundle/images/empty.png"];
}

- (UIImage*)imageForError:(NSError*)error {
  return [UIImage imageNamed:@"Three20.bundle/images/error.png"];
}

@end
