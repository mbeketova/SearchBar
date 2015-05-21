//
//  ViewController.h
//  SearchBar
//
//  Created by Admin on 21.05.15.
//  Copyright (c) 2015 Mariya Beketova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray * arrayDisplay;
@property (strong, nonatomic) NSArray * arrayValue;

@end

