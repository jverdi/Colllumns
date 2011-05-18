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

#import "NSDateFormatter+Extras.h"


@implementation NSDateFormatter (Extras)

+ (NSString *)dateDifferenceStringFromDate:(NSDate *)date {
  
  NSDate *now = [NSDate date];
  
  NSTimeInterval time = [date timeIntervalSinceDate:now];
  time *= -1;
  
  if(time < 1) {
    return @"moments ago";
  }
  else if (time < 60) {
    return [NSString stringWithFormat:@"%d secs ago", time];
  }
  else if (time < 3600) {
    int diff = round(time / 60);
    
    if (diff == 1) {
      return [NSString stringWithFormat:@"1 min ago", diff];
    }
    
    return [NSString stringWithFormat:@"%d mins ago", diff];
  }
  else if (time < 86400) {
    int diff = round(time / 60 / 60);
    
    if (diff == 1) {
      return [NSString stringWithFormat:@"1 hour ago", diff];
    }
    
    return [NSString stringWithFormat:@"%d hours ago", diff];
  }
  else if (time < 604800) {
    int diff = round(time / 60 / 60 / 24);
    
    if (diff == 1) {
      return [NSString stringWithFormat:@"yesterday", diff];
    }
    
    return[NSString stringWithFormat:@"%d days ago", diff];
  }
  else {
    int diff = round(time / 60 / 60 / 24 / 7);
    
    if (diff == 1) {
      return [NSString stringWithFormat:@"last week", diff];
    }
    
    return [NSString stringWithFormat:@"%d weeks ago", diff];
  }   
}

@end