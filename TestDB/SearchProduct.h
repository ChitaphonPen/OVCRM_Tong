//
//  SearchProduct.h
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDataDetail.h"
#import "MyTableViewCell.h"
@class ProductDataDetail;

@class tblProduct;

@interface SearchProduct : UIViewController
<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)  ProductDataDetail * productDataDetail;
@property(strong,nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) IBOutlet UIView *headerView;
@property(strong,nonatomic)NSMutableArray *productList;

@property (strong, nonatomic) NSMutableArray * arrProdCode; 
@property (strong, nonatomic) NSMutableArray * arrProdName; 
@property (strong, nonatomic) NSMutableArray * arrProdFamily; 
@property (strong, nonatomic) NSMutableArray * arrProdCost; 
@property (strong, nonatomic) NSString * backState;

@property(strong,nonatomic) IBOutlet UITextField *txtProdCode;
@property(strong,nonatomic) IBOutlet UITextField *txtProdName;
@property(strong,nonatomic) IBOutlet UITextField *txtBrand;
@property(strong,nonatomic) IBOutlet UITextField *txtProdFamily;


@property (strong, nonatomic) NSString * selectedProduct;

- (IBAction)btnSearch:(id)sender;
- (void)assignBackState:(NSString *)state;
- (void)SearchProduct;
- (IBAction)backgroungTab;

@end
