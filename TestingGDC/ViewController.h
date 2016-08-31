//
//  ViewController.h
//  TestingGDC
//
//  Created by David Céspedes on 31/08/16.
//  Copyright © 2016 LSR Marketing Service. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *fibLbl;
@property (weak, nonatomic) IBOutlet UITextField *numberTxtFld;

- (IBAction)runAlgorithm:(UIButton *)sender;

@end

