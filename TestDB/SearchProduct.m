//
//  SearchProduct.m
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "SearchProduct.h"
#import "tblProduct.h"
#import "MyTableViewCell.h"
#import "ProductDataDetail.h"

@interface SearchProduct ()

@end

@implementation SearchProduct

@synthesize  arrProdCode,arrProdName,arrProdFamily,arrProdCost; 

@synthesize productDataDetail = _productDataDetail;
@synthesize myTableView = _myTableView;
@synthesize headerView;
@synthesize productList;
@synthesize selectedProduct;
@synthesize backState;


@synthesize  txtProdCode;
@synthesize  txtProdName;
@synthesize  txtBrand;
@synthesize  txtProdFamily;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)assignBackState:(NSString *)state
{
    //    [txtShowProdID setText:prodID]; assign to text โดยตรงไม่ได้ ค่าจะหาย
    self.backState = state;
}

- (void)viewDidLoad
{        
    self.navigationItem.title = @"ค้นหาสินค้า"; 
    // Release any retained subviews of the main view.
    arrProdCode = [[NSMutableArray alloc] init];
    arrProdName = [[NSMutableArray alloc] init];
    arrProdFamily = [[NSMutableArray alloc] init];
    arrProdCost = [[NSMutableArray alloc] init];
    
    [self.myTableView reloadData]; 
    
    [super viewDidLoad];    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //In case redirect from product detail, show search result
//    NSLog(@"Back=***%@",self.backState);
//    if (![self.backState isEqualToString:@"Y"])
//    {
//        arrProdCode = [[NSMutableArray alloc] init];
//        arrProdName = [[NSMutableArray alloc] init];
//        arrProdFamily = [[NSMutableArray alloc] init];
//        arrProdCost = [[NSMutableArray alloc] init];
//        
//        [self.myTableView reloadData];    
//    }    
}

-(IBAction)backgroungTab
{
    [self.txtProdCode resignFirstResponder]; 
    [self.txtProdName resignFirstResponder];
}

- (IBAction)btnSearch:(id)sender
{
    [self SearchProduct];
}

-(void)SearchProduct
{
    tblProduct *myProduct = [[tblProduct alloc] init];
    
    if ([myProduct OpenConnection] == YES) 
    {
        NSString *tableField = [myProduct DB_Field] ; 
        NSString *cond = [[NSString alloc] initWithFormat:@"select %@ from Product where 1=1",tableField];
             
        //Search from Product Code
        if (![self.txtProdCode.text isEqualToString:@""])
        {
            cond = [NSString stringWithFormat:@"%@ and Product_Code=%@",cond , self.txtProdCode.text];
        }
        
        //Search from Product Name
        if (![self.txtProdName.text isEqualToString:@""])
        {
            cond = [NSString stringWithFormat:@"%@ and Product_Name like '%@%%'",cond , self.txtProdName.text];   
        }
        
        //Search from Brand
        if (![self.txtBrand.text isEqualToString:@""])
        {
            cond = [NSString stringWithFormat:@"%@ and Brand like '%@%%'",cond , self.txtBrand.text];   
        }
        
        //Search from Product Family
        if (![self.txtProdFamily.text isEqualToString:@""])
        {
            cond = [NSString stringWithFormat:@"%@ and Product_Family like '%@%%'",cond , self.txtProdFamily.text];   
        }
            
        NSLog(@"***%@" , cond);
        
        arrProdCode = [[NSMutableArray alloc] init];
        arrProdName = [[NSMutableArray alloc] init];
        arrProdFamily = [[NSMutableArray alloc] init];
        arrProdCost = [[NSMutableArray alloc] init];
        
        productList=[myProduct QueryData:cond];               
        
        if(productList.count > 0){
           for (int i=0;i<=productList.count-1;i++)
           {
            myProduct = [productList objectAtIndex:i]  ;
               
            [arrProdCode addObject:myProduct.product_Code];   
            [arrProdName addObject:myProduct.product_Name];
            [arrProdFamily addObject:myProduct.product_Family];
            [arrProdCost addObject:[NSString stringWithFormat:@"%d", myProduct.cost]];                                   
           }         
        }
         [_myTableView reloadData];
    }   
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrProdCode.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell" owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    cell.lblProdCode.text = [arrProdCode objectAtIndex:indexPath.row];
    cell.lblProdName.text = [arrProdName objectAtIndex:indexPath.row];
    cell.lblProdCost.text = [arrProdCost objectAtIndex:indexPath.row];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return headerView;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  30;
}


//-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    selectedProduct = [[NSString alloc]initWithFormat:@"%@",[arrData1 objectAtIndex:indexPath.row]];
//    [self.view removeFromSuperview];
//}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{

    if (!self.productDataDetail) 
    {
        self.productDataDetail = [[ProductDataDetail alloc] initWithNibName:@"ProductDataDetail" bundle:nil];
    }
    [self.productDataDetail ShowProductID:[arrProdCode objectAtIndex:indexPath.row]];
    [[self navigationController] pushViewController:self.productDataDetail  animated:YES] ;
}


@end
