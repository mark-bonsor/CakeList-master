//
//  CakeDataSource.m
//  Cake Data Source
//
//  Created by Mark Bonsor on 22/03/2018.
//


#import "CakeDataSource.h"
#import "CakeCell.h"
#import "Cake.h"


@interface CakeDataSource ()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *objects;
@property (strong, nonatomic) NSMutableArray *cakeArray;
@property (strong, nonatomic) NSMutableDictionary *images;
@end

@implementation CakeDataSource


- (id)init
{
    self = [super init];
    if (self) {
        
        self.images = [@{} mutableCopy];
        
        [self getData];
		
    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cakeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CakeCell";
    CakeCell *cell = (CakeCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CakeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Cake *thisCake = self.cakeArray[indexPath.row];
    cell.titleLabel.text = thisCake.cakeTitle;
    cell.descriptionLabel.text = thisCake.cakeDescription;
    
    // Download and display images in the table asynchronously...
    NSString *imgPath = thisCake.cakeImagePath;
    UIImage *image = self.images[imgPath];
    if (image) {
        [cell.cakeImageView setImage:image];
    } else {
        [cell.cakeImageView setImage:[UIImage imageNamed:@"cakeSliceIcon.jpg"]]; // Placeholder image
        [self imageWithPath:imgPath completion:^(UIImage *image, NSError *error) {
            // The image is ready, but don't assign it to the cell's subview.
            // Just reload here, so we get the right cell for the indexPath
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
    }
    
    return cell;
}


- (void)imageWithPath:(NSString *)path completion:(void (^)(UIImage *, NSError *))completion {
    if (self.images[path]) {
        return completion(self.images[path], nil);
    }
    NSURL *imageURL = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    [NSURLConnection
     sendAsynchronousRequest:request
     queue:[NSOperationQueue mainQueue]
     completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
         if (!error){
             UIImage *image = [UIImage imageWithData:data];
             self.images[path] = image;
             completion(image, nil);
         } else {
             completion(nil, error);
         }
     }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)getData {
    
    NSURL *url = [NSURL URLWithString:@"https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *jsonError;
    id responseData = [NSJSONSerialization
                       JSONObjectWithData:data
                       options:kNilOptions
                       error:&jsonError];
    if (!jsonError){
        self.objects = responseData;
        
        [self parseCakeData];
        [self.tableView reloadData];
        
    } else {
    }
    
}


- (void)parseCakeData {
    
    self.cakeArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *aCakeDict in self.objects) {
        Cake *aCake = [[Cake alloc] init];
        [aCake loadCakeData:aCakeDict];
        [self.cakeArray addObject:aCake];
    }
    
}


@end
