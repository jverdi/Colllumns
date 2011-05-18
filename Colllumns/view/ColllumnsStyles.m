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

#import "ColllumnsStyles.h"


@implementation ColllumnsStyles

//http://github.com/facebook/three20/blob/master/src/Three20Style/Sources/TTDefaultStyleSheet.m

- (UIColor *)textColor {
	return UIColorFromRGB(0x999999);
}

- (UIColor *)highlightedTextColor {
	return UIColorFromRGB(0x000000);
}

- (UIColor *)titleTextColor {
	return UIColorFromRGB(0x999999);
}

- (UIColor *)detailTextColor {
	return UIColorFromRGB(0xf7f6f6);
}

- (UIColor *)timestampTextColor {
	return UIColorFromRGB(0x999999);
}

- (UIColor *)articleTextColor {
	return UIColorFromRGB(0x000000);
}

- (UIFont *)tableFont {
	return [UIFont boldSystemFontOfSize:22];
}

- (UIFont *)tableTimestampFont {
	return [UIFont systemFontOfSize:13];
}

- (UIFont *)tableTitleFont {
	return [UIFont boldSystemFontOfSize:15];
}

- (UIFont *)articleTableFont {
	return [UIFont systemFontOfSize:13];
}

- (UIColor*)navigationBarTintColor {
  return UIColorFromRGB(0x303030);
}

- (UIColor*)tableRefreshHeaderBackgroundColor {
  return [UIColor clearColor];
}

- (UIColor*)tableRefreshHeaderTextColor {
  return UIColorFromRGB(0xf7f6f6);
}

- (UIColor*)tableRefreshHeaderTextShadowColor {
  return [UIColor clearColor];
}

@end
