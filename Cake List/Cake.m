//
//  Cake.m
//  Cake Model
//
//  Created by Mark Bonsor on 22/03/2018.
//


#import "Cake.h"

@implementation Cake


- (id)init
{
    self = [super init];
    if (self) {
		
    }
    return self;
}

- (void)loadCakeData: (NSDictionary *)thisCakeDictionary
{
	NSString *thisCakeTitle = thisCakeDictionary[@"title"];
	NSString *thisCakeDescription = thisCakeDictionary[@"desc"];
	NSString *thisCakeImagePath = thisCakeDictionary[@"image"];

     // Capitalize first leter of each word of the title
    _cakeTitle = [thisCakeTitle capitalizedString];
    
     // Capitalize the first letter of the description
    _cakeDescription = [self sentenceCapitalizedString:thisCakeDescription];
    
    _cakeImagePath = thisCakeImagePath;
    
}

- (NSString *)sentenceCapitalizedString:(NSString *)inputString {
    if (![inputString length]) {
        return inputString;
    }
    NSString *uppercase = [[inputString substringToIndex:1] uppercaseString];
    NSString *lowercase = [inputString substringFromIndex:1];
    return [uppercase stringByAppendingString:lowercase];
}


@end
