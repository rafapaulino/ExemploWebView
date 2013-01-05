//
//  PrincipalViewController.h
//  ExemploWebView
//
//  Created by Rafael Brigagão Paulino on 10/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrincipalViewController : UIViewController <UIWebViewDelegate, UITextFieldDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *meuWebView;
@property (nonatomic, weak) IBOutlet UITextField *txtEndereco;
@property (nonatomic, weak) IBOutlet UILabel *lblTitulo;
@property (nonatomic, weak) IBOutlet UISearchBar *barraBusca;
@property (nonatomic, assign) BOOL pesquisando;


-(IBAction)exibirBarraBusca:(id)sender;

@end
