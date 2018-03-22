//
//  CakeListViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "CakeListViewController.h"
#import "CakeDataSource.h"



@implementation CakeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Separate the data handling from the view controller
    self.cakeDataSource = [[CakeDataSource alloc] init];
    
    self.tableView.dataSource = self.cakeDataSource;
    self.tableView.delegate = self.cakeDataSource;
    
}





@end
