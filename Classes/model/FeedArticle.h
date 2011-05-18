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


@interface FeedArticle : NSObject <NSCopying> {
	NSMutableArray *media;
	NSString *title;
	NSString *link;
	NSString *author;
	NSString *content;
	NSString *contentSnippet;
	NSDate *publishedDate;
	NSMutableArray *categories;
}

@property (nonatomic, retain) NSMutableArray *media;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *contentSnippet;
@property (nonatomic, retain) NSDate *publishedDate;
@property (nonatomic, retain) NSMutableArray *categories;

- (id)copyWithZone:(NSZone *)zone;

@end
