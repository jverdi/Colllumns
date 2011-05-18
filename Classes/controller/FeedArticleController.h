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

#import <Foundation/Foundation.h>
#import "FeedListingResultsModel.h"
#import "FeedArticle.h"
#import "ListingTableMessageItemCell.h"


@interface FeedArticleController : TTModelViewController <UITableViewDataSource, UITableViewDelegate> {
  FeedListingResultsModel* listingModel;
  NSUInteger articleIndex;
  UIWebView *webView;
  ListingTableMessageItemCell *theCell;
}

@property (nonatomic, retain) FeedListingResultsModel* listingModel;
@property NSUInteger articleIndex;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) ListingTableMessageItemCell *theCell;

@end
