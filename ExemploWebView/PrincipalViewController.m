//
//  PrincipalViewController.m
//  ExemploWebView
//
//  Created by Rafael Brigagão Paulino on 10/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "PrincipalViewController.h"

@interface PrincipalViewController ()

@end


@implementation PrincipalViewController

//text field botao confirmacao do textfiled mandaremos ele acessar a ul digitado
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //verificar se o usuario digitou o http://
    if ([textField.text rangeOfString:@"http://"].location == NSNotFound) {
        //o usuario nao digitou o http,vamos adicoonar via codigo
        textField.text = [NSString stringWithFormat:@"http://%@", textField.text];
    }
    //ocultar o teclado
    [textField resignFirstResponder];
    //preparar uma url de destino
    NSURL *url = [NSURL URLWithString:textField.text];
    //preparando a requisicao a ser efeutada pelo webview
    NSURLRequest *requisicao = [NSURLRequest requestWithURL:url];
    
    [_meuWebView loadRequest:requisicao];
    
    return YES;
}

//chamado quando houver uma alteracao no segmento selecionadodentro da barra de busca
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    if (_barraBusca.text.length > 0) {
        //se houver algum texto para a busca realizamos nova busca considerando o novo escopo selecionado
        [self searchBarSearchButtonClicked:_barraBusca];
    }
}

//semelhante ao textFIeldSholdReturn onde a busca deve ser realizada
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *linkBusca;
    
    if (_barraBusca.selectedScopeButtonIndex == 0) {
        //busca no google 
        linkBusca = [NSString stringWithFormat:@"http://google.com.br/search?q=%@", _barraBusca.text];
    }
    else {
        //busca no yahoo
        linkBusca = [NSString stringWithFormat:@"http://search.yahoo.com/search?p=%@", _barraBusca.text];
    }
    
    linkBusca = [linkBusca stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSURL *url = [NSURL URLWithString:linkBusca];
    //preparando a requisicao a ser efeutada pelo webview
    NSURLRequest *requisicao = [NSURLRequest requestWithURL:url];
    
    [_meuWebView loadRequest:requisicao];
    
    [_barraBusca resignFirstResponder];
    
    
}

//chamado quando o carregamento da pg for iniciado
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

//metodo chamado quando a pag for carregada
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSURL *urlAcessado = [_meuWebView.request URL];
    //exibindo o enderec o final apos os redirecionamentos
    _txtEndereco.text = [urlAcessado relativeString];
    //ajustar o titluto da pagina na label
    _lblTitulo.text = [_meuWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

//botao que exibe a barra de busca
-(IBAction)exibirBarraBusca:(id)sender
{
    if (_pesquisando == YES) {
        [UIView animateWithDuration:.5 animations:^{
            _barraBusca.center = CGPointMake(160,-44);
        }];
       
    }
    else {
        [UIView animateWithDuration:.5 animations:^{
            _barraBusca.center = CGPointMake(160,44);
        }];
    }
    _pesquisando = !_pesquisando;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
