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
#import "ListingTableMessageItemCell.h"
#import "NSDateFormatter+Extras.h"
#import "ColllumnsStyles.h"

static const NSInteger  kColllumnsItemCellHMargin	= 15;
static const NSInteger  kColllumnsItemCellVMargin	= 18;
static const NSInteger  kColllumnsAuthorTitleSep	= 8;

@implementation ListingTableMessageItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
  if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {

    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.timestampLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
	  
    self.textLabel.font = TTSTYLEVAR(font);
    self.textLabel.textColor = TTSTYLEVAR(textColor);
    self.textLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
    self.textLabel.textAlignment = UITextAlignmentLeft;
    self.textLabel.contentMode = UIViewContentModeLeft;

    self.detailTextLabel.textColor = CLSTYLEVAR(detailTextColor);
    self.detailTextLabel.font = TTSTYLEVAR(tableFont);
    self.detailTextLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
    self.detailTextLabel.textAlignment = UITextAlignmentLeft;
    self.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.contentMode = UIViewContentModeLeft;
  }

  return self;
}


- (void)dealloc {
  TT_RELEASE_SAFELY(_titleLabel);
  TT_RELEASE_SAFELY(_timestampLabel);
  
  [super dealloc];
}

+ (CGFloat)rowHeightForObject:(id)object {
 	
	int cellWidth = [[UIScreen mainScreen] applicationFrame].size.width - (2 * kColllumnsItemCellHMargin);
	int cellHeight = 0;
	
	ListingTableMessageItem* item = object;
	
	CGSize maximumLabelSize = CGSizeMake(cellWidth, 99999);

	CGSize expectedDetailLabelSize = 
	  [item.text sizeWithFont:TTSTYLEVAR(tableFont) 
			constrainedToSize:maximumLabelSize 
				lineBreakMode:UILineBreakModeWordWrap];
	
	cellHeight += 2 * kColllumnsItemCellVMargin;
	cellHeight += [((UIFont*)TTSTYLEVAR(tableTitleFont)) ttLineHeight];
	cellHeight += kColllumnsAuthorTitleSep;
	cellHeight += expectedDetailLabelSize.height;
	
	return cellHeight; 
}

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
  return [self rowHeightForObject:object];
}

- (void)prepareForReuse {
  
  [super prepareForReuse];
  
  _titleLabel.text = nil;
  _timestampLabel.text = nil;
}

- (void)layoutSubviews {
  
  [super layoutSubviews];

  CGFloat left = kColllumnsItemCellHMargin;
  CGFloat top = kColllumnsItemCellVMargin;
  CGFloat width = self.contentView.width - (2 * kColllumnsItemCellHMargin);

  
  CGSize expectedAuthorSize = CGSizeMake(0, 0);
	
  if (_titleLabel.text.length) {
    
    expectedAuthorSize =
      [_titleLabel.text sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(180, 20)];
    
    NSLog(@"%f", left);
    
    _titleLabel.frame = CGRectMake(left, top, expectedAuthorSize.width, _titleLabel.font.ttLineHeight);
    
    top += _titleLabel.height;
  }
  else {
    _titleLabel.frame = CGRectZero;
  }
  
  if (_timestampLabel.text.length) {
    
    [_timestampLabel sizeToFit];
    
    _timestampLabel.top = _titleLabel.top + 2;
    _timestampLabel.left = _titleLabel.left + expectedAuthorSize.width + 5;
    
  }
  else {
    _titleLabel.frame = CGRectZero;
  }
  
	
	top += kColllumnsAuthorTitleSep;

  if (self.detailTextLabel.text.length) {
	  
    CGSize maximumLabelSize = CGSizeMake(width, 99999);

    CGSize expectedLabelSize = 
      [self.detailTextLabel.text sizeWithFont:self.detailTextLabel.font 
                            constrainedToSize:maximumLabelSize 
                                lineBreakMode:self.detailTextLabel.lineBreakMode];

    self.detailTextLabel.frame = CGRectMake(left, top, width, expectedLabelSize.height);
    top += expectedLabelSize.height;
    
  }
  else {
    self.detailTextLabel.frame = CGRectZero;
  }
}

- (void)setObject:(id)object {
  
  if (_item != object) {
    
    [super setObject:object];

    ListingTableMessageItem* item = object;
    
    if (item.title.length) {
      self.titleLabel.text = item.title;
    }
    
    if (item.text.length) {
      self.detailTextLabel.text = item.text;
    }
    
    if (item.timestamp) {
      
      self.timestampLabel.text = [NSDateFormatter dateDifferenceStringFromDate:item.timestamp];
    }
	
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleGray;
  }
}

- (UILabel*)titleLabel {
  
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = CLSTYLEVAR(titleTextColor);
    _titleLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
    _titleLabel.font = TTSTYLEVAR(tableTitleFont);
    _titleLabel.contentMode = UIViewContentModeLeft;
    [self.contentView addSubview:_titleLabel];
  }
  
  return _titleLabel;
}

- (UILabel*)timestampLabel {
  
  if (!_timestampLabel) {
    _timestampLabel = [[UILabel alloc] init];
    _timestampLabel.font = TTSTYLEVAR(tableTimestampFont);
    _timestampLabel.textColor = TTSTYLEVAR(timestampTextColor);
    _timestampLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);;
    _timestampLabel.contentMode = UIViewContentModeLeft;
    [self.contentView addSubview:_timestampLabel];
  }
  
  return _timestampLabel;
}


@end
