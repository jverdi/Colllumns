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

#import "FeedListingController.h"
#import "FeedListingDataSource.h"
#import "FeedListingResultsModel.h"
#import "FeedArticle.h"


@implementation FeedListingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
	
    self.title = @"LOADING...";
    self.statusBarStyle = UIStatusBarStyleBlackOpaque;
    self.variableHeightRows = YES;
    //self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
		self.navigationItem.backBarButtonItem =
			[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered
											 target:nil action:nil] autorelease];
    
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
	
	[super dealloc];
}


- (void)createModel {
  
	FeedListingDataSource *flds = (FeedListingDataSource *)[FeedListingDataSource dataSourceWithItems:nil];
  
  [flds setTapDelegate:self selector:@selector(viewArticle)];

	flds.model = [[FeedListingResultsModel alloc] init];
	
	self.dataSource = flds;
}

- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

- (void)viewDidLoad {
	
	self.tableView.backgroundColor = UIColorFromRGB(0x282828);
	self.tableView.separatorColor = UIColorFromRGB(0x4f4f4f);
}

- (void)didLoadModel:(BOOL)firstTime {
  
	[super didLoadModel:firstTime];
	
	FeedListingDataSource *ds = self.dataSource;
	FeedListingResultsModel *model = (FeedListingResultsModel *)ds.model;
	
	if(![model isLoaded]) {
		return;
	}
	
	FeedListing *listing = (FeedListing *)model.result;
	
	if(firstTime) {
		self.title = [listing.title uppercaseString];
    UILabel *titleLabel = (UILabel *)self.navigationItem.titleView;
    titleLabel.text = self.title;
	}
}

- (void)viewArticle {
  
  FeedListingDataSource *ds = self.dataSource;
	FeedListingResultsModel *model = (FeedListingResultsModel *)ds.model;
	
	if(![model isLoaded]) {
		return;
	}
  
	NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
  NSUInteger articleIndex = selectedPath.row;
  
  NSDictionary *articleQuery = [NSDictionary dictionaryWithObjectsAndKeys:
                                model, @"model",
                                [NSNumber numberWithUnsignedInt:articleIndex], @"articleIndex",
                                nil];
  
  TTURLAction *articleAction = [TTURLAction actionWithURLPath:@"tt://feedarticle/(initWithName:)"];
  articleAction.query = articleQuery;
  
  [[TTNavigator navigator] openURLAction:articleAction];
}


@end
