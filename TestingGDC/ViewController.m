//
//  ViewController.m
//  TestingGDC
//
//  Created by David Céspedes on 31/08/16.
//  Copyright © 2016 LSR Marketing Service. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.fibLbl.text = @" ";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)fibonacci:(NSInteger)fibMe{
    return (fibMe <= 1) ? fibMe : [self fibonacci:fibMe-1] + [self fibonacci:fibMe-2];
}

- (IBAction)runAlgorithm:(UIButton *)sender {
    // crear un cola
    dispatch_queue_t fib = dispatch_queue_create("calculo", 0);
    
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    numFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    __block NSNumber *fibNumber = [numFormatter numberFromString:self.numberTxtFld.text];
    __block NSString *fibStr = @" ";
    __block NSMutableArray* arr = [[NSMutableArray alloc]init];
    
    self.fibLbl.text = fibStr;
    __weak ViewController *weakSelf = self;
    
    // enviarle un bloque que se ejecuta en 2o plano
    dispatch_async(fib, ^{
        for (int k =0; k< fibNumber.intValue; k++)
        {
            if ([sender.titleLabel.text isEqualToString:@"Recursivo (Lento)"]) {
                fibStr = [NSString stringWithFormat:@"%ld", (long)[self fibonacci:k]];
                
            }else if ([sender.titleLabel.text isEqualToString:@"Array (Rapido)"]){
                if(k<2)
                {
                    fibStr = [NSString stringWithFormat:@"%d",k];
                    [arr addObject:fibStr];
                }
                else
                {
                    int fib = [[arr objectAtIndex:k-2] intValue] + [[arr objectAtIndex:k-1] intValue];
                    fibStr = [NSString stringWithFormat:@"%d",fib];
                    [arr addObject:fibStr];
                    
                }
            }
            
            //Revisar que no sea un Fibonacci muy grande.
            
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            f.numberStyle = NSNumberFormatterDecimalStyle;
            NSNumber *fibResultNumber = [f numberFromString:fibStr];
            
            if (fibResultNumber.intValue >= 0) {
                // se ejecuta en primer plano
                dispatch_sync(dispatch_get_main_queue(), ^{
                    __strong ViewController *strongSelf = weakSelf;
                    strongSelf.fibLbl.text = fibStr;
                    NSLog(@"%@",fibStr);
                });
            }else{
                dispatch_sync(dispatch_get_main_queue(), ^{
                    __strong ViewController *strongSelf = weakSelf;
                    strongSelf.fibLbl.text = [NSString stringWithFormat:@"El Fibonacci de %@ es muy grande :(", fibNumber];
                    NSLog(@"El Fibonacci de este numero excede la capadidad de un NSInteger");
                });
                
                break;
            }
            
            
        }
    });
}


@end
