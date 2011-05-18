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

#import "FeedArticleController.h"
#import "FeedArticle.h"
#import "ListingTableMessageItem.h"
#import "ListingTableMessageItemCell.h"


const static NSUInteger kShadowHeight = 10;

NSString *htmlWrapper = @"\
<html><head><style type=\"text/css\">\
html { margin:0; padding:0; }\
body { margin:15px; padding:0; color: #2b2c2b; font: 15px/18px Helvetica !important; }\
img { max-width:290px; width:auto; height:auto; }\
</style></head><body>\
%@\
</body></html>\
";

@implementation FeedArticleController

@synthesize listingModel, articleIndex, webView, theCell;

- (id)initWithName:(NSString *)name query:(NSDictionary*)query {
	
  if (self = [super init]) {
	
    self.listingModel = (FeedListingResultsModel *)[query objectForKey:@"model"];
    self.articleIndex = [(NSNumber *)[query objectForKey:@"articleIndex"] unsignedIntValue];
    
    FeedListing *listing = (FeedListing *)self.listingModel.result;
    
    FeedArticle *article = [listing.entries objectAtIndex:self.articleIndex];
    
    self.title = article.title;
    self.statusBarStyle = UIStatusBarStyleBlackOpaque;
    //self.variableHeightRows = YES;
    
    CGRect frame = CGRectMake(0, 0, 290, 44);
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:13.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentLeft;
    label.textColor = UIColorFromRGB(0x0bd7ef);
    label.text = self.title;
    self.navigationItem.titleView = label;
  }
  return self;
}

- (void)dealloc {
  
  [theCell release];
  [webView release];
	
	[super dealloc];
}

- (void)viewDidLoad {
	
	self.view.backgroundColor = UIColorFromRGB(0xffffff);
  
  FeedListing *listing = (FeedListing *)self.listingModel.result;
  FeedArticle *article = [listing.entries objectAtIndex:self.articleIndex];

  ListingTableMessageItem* tmi = 
    [ListingTableMessageItem itemWithTitle:article.author
                                      text:article.title
                                 timestamp:article.publishedDate];
  
  theCell = [[ListingTableMessageItemCell alloc]
          initWithStyle:UITableViewCellStyleValue2 
          reuseIdentifier:@"articleheader"];
  
  [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
  
  CGFloat rowHeight = [ListingTableMessageItemCell rowHeightForObject:tmi];
  
  UITableView *tableView = [[UITableView alloc] initWithFrame:
                            CGRectMake(0,
                                       0, 
                                       self.view.frame.size.width,
                                       rowHeight)];

  tableView.backgroundColor = UIColorFromRGB(0x282828);
  tableView.delegate = self;
  tableView.dataSource = self;
  tableView.rowHeight = rowHeight;
  tableView.separatorColor = [UIColor clearColor];
  tableView.scrollEnabled = NO;
  
  [theCell setFrame:tableView.frame];
  [theCell setObject:tmi];
  

  UIView *header = [[UIView alloc] initWithFrame:
                    CGRectMake(0,
                               0,
                               theCell.frame.size.width,
                               theCell.frame.size.height + kShadowHeight)];
   
  [header addSubview:tableView];
  [tableView release];
  
  UIImageView *shadow = [[UIImageView alloc] 
                          initWithFrame:CGRectMake(0, 
                                                   theCell.frame.size.height, 
                                                   header.frame.size.width, 
                                                   kShadowHeight)];
  
	shadow.image = [UIImage imageNamed:@"topshadow.png"];
	[header addSubview:shadow];
  [shadow release];
  
  [[self view] addSubview:header];
                                                            
  [header release];
  
  webView = [[UIWebView alloc] initWithFrame:
              CGRectMake(0, 
                         header.frame.size.height - kShadowHeight, 
                         self.view.frame.size.width, 
                         self.view.frame.size.height - header.frame.size.height + kShadowHeight)];
             
	NSString *feedHTML = [NSString stringWithFormat:htmlWrapper, article.content];
	[webView loadHTMLString:feedHTML baseURL:nil];

	webView.backgroundColor = UIColorFromRGB(0xffffff);
  
  id scroller = [webView.subviews objectAtIndex:0];

	//remove scroller content area shadows
	for (UIView *subView in [scroller subviews]) {
		if ([[[subView class] description] isEqualToString:@"UIImageView"]) {
			subView.hidden = YES;
		}
	}
  
  [self.view addSubview:webView];
  [self.view sendSubviewToBack:webView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  return theCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

@end
