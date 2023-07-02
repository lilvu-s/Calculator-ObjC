//
//  ViewController.h
//  Calculator
//
//  Created by Ангеліна Семенченко on 02.07.2023.
//

#import <UIKit/UIKit.h>
#import "Operations.h"

@interface CalculatorViewController : UIViewController

@property (nonatomic, strong) Operations *calculator;
@property (nonatomic, strong) NSDecimalNumber *currentOperand;
@property (nonatomic, strong) NSDecimalNumber *updatedOperand;
@property (nonatomic, strong) UILabel *inputLabel;
@property (nonatomic, strong) NSString *operation;

@end

