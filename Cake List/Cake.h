//
//  Cake.h
//  Cake Model
//
//  Created by Mark Bonsor on 22/03/2018.
//

#import <Foundation/Foundation.h>

@interface Cake : NSObject {
	
}


@property (nonatomic, strong) NSString *cakeTitle;
@property (nonatomic, strong) NSString *cakeDescription;
@property (nonatomic, strong) NSString *cakeImagePath;


- (void)loadCakeData: (NSDictionary *)thisCakeDictionary;


@end


