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

#import "ArticleTableMessageItemCell.h"
#import "ArticleTableMessageItem.h"
#import "ColllumnsStyles.h"
#import "NSDateFormatter+Extras.h"


static const NSInteger  kColllumnsItemCellHMargin	= 15;
static const NSInteger  kColllumnsItemCellVMargin	= 18;

@implementation ArticleTableMessageItemCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
  if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {

    self.detailTextLabel.backgroundColor = [UIColor clearColor];
	  
    self.textLabel.font = TTSTYLEVAR(articleTableFont);
    self.textLabel.textColor = TTSTYLEVAR(articleTextColor);
    self.textLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
    self.textLabel.textAlignment = UITextAlignmentLeft;
    self.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.textLabel.numberOfLines = 0;
    self.textLabel.contentMode = UIViewContentModeLeft;

    self.detailTextLabel.textColor = CLSTYLEVAR(articleTextColor);
    self.detailTextLabel.font = TTSTYLEVAR(articleTableFont);
    self.detailTextLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
    self.detailTextLabel.textAlignment = UITextAlignmentLeft;
    self.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.contentMode = UIViewContentModeLeft;
  }

  return self;
}

- (void)dealloc {
  
  [super dealloc];
}

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
	
	int cellWidth = [[UIScreen mainScreen] applicationFrame].size.width - (2 * kColllumnsItemCellHMargin);
	int cellHeight = 0;
	
	ArticleTableMessageItem* item = object;
	
	CGSize maximumLabelSize = CGSizeMake(cellWidth, 99999);

	CGSize expectedDetailLabelSize = 
	  [item.text sizeWithFont:TTSTYLEVAR(articleTableFont) 
			constrainedToSize:maximumLabelSize 
				lineBreakMode:UILineBreakModeWordWrap];
	
  cellHeight += expectedDetailLabelSize.height;
	cellHeight += 2 * kColllumnsItemCellVMargin;
	
  return cellHeight;
}

- (void)prepareForReuse {
  
  [super prepareForReuse];
}

- (void)layoutSubviews {
  
  [super layoutSubviews];

  CGFloat left = kColllumnsItemCellHMargin;
  CGFloat top = kColllumnsItemCellVMargin;
  CGFloat width = self.contentView.width - left - kColllumnsItemCellHMargin;

  if (self.textLabel.text.length) {
	  
    CGSize maximumLabelSize = CGSizeMake(width, 99999);

    CGSize expectedLabelSize = 
      [self.textLabel.text sizeWithFont:self.textLabel.font 
                            constrainedToSize:maximumLabelSize 
                                lineBreakMode:self.textLabel.lineBreakMode];

    self.textLabel.frame = CGRectMake(left, top, width, expectedLabelSize.height);
    top += expectedLabelSize.height;
    
  }
  else {
    self.textLabel.frame = CGRectZero;
  }
}

- (void)setObject:(id)object {
  
  if (_item != object) {
    
    [super setObject:object];

    ArticleTableMessageItem* item = object;
    
    if (item.text.length) {
      self.textLabel.text = item.text;
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
}

@end
