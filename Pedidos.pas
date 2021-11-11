unit Pedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,DateUtils;

type
  TFrmPedidos = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    EdtCliente: TEdit;
    BtnBuscaCliente: TBitBtn;
    lblNomeCliente: TLabel;
    DBGridPedidos_Produtos: TDBGrid;
    Panel2: TPanel;
    Label2: TLabel;
    EdtCodProduto: TEdit;
    BtnBuscaProduto: TBitBtn;
    lblDescricaoProduto: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BtnSalvar: TBitBtn;
    EdtQuantidade: TMaskEdit;
    EdtValorUnitario: TMaskEdit;
    EdtValorTotal: TMaskEdit;
    lblNumeroPedido: TLabel;
    EdtNumeroPedido: TEdit;
    BtnIncluirPedido: TBitBtn;
    Label6: TLabel;
    EdtTotalPedidos: TMaskEdit;
    BtnCarregarPedido: TBitBtn;
    Label7: TLabel;
    EdtDataEntrega: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtClienteExit(Sender: TObject);
    procedure BtnBuscaClienteClick(Sender: TObject);
    procedure BuscaCliente(codcliente:string);
    procedure BuscaProduto(codproduto:string);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure BtnBuscaProdutoExit(Sender: TObject);
    procedure Calc_TotalProduto(quantidade:real;valor_unitario:real);
    procedure EdtQuantidadeExit(Sender: TObject);
    procedure EdtValorUnitarioExit(Sender: TObject);
    procedure AdicionarPedido(codcliente:string);
    procedure BtnIncluirPedidoClick(Sender: TObject);
    procedure AdicionarProdutos(codproduto:string; quantidade:string; valor_unitario:string; valor_total:string);
    procedure AtualizaTotalPedidos();
    procedure BtnSalvarClick(Sender: TObject);
    procedure LimparControles();
    procedure CarregaPedido(numero_pedido:string);
    procedure BtnCarregarPedidoClick(Sender: TObject);
    procedure Deleta_PedidoProduto(numero_pedido:string; codpedido_produto:string);
    procedure DBGridPedidos_ProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edita_PedidoProduto(numero_pedido:string; codpedido_produto:string);
    procedure FormShow(Sender: TObject);
    procedure Filtra_Pedido_Produtos(numero_pedido:string);
    function BuscaPascoa(ano: Word): TDate;
    function Feriado(data: TDate): Boolean;
    function DiaUtil(dia: TDate; sabado: Boolean): Boolean;
    function Entrega_Pedido(): TDate;
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  FrmPedidos: TFrmPedidos;

implementation

{$R *.dfm}

uses DM;

procedure TFrmPedidos.EdtClienteExit(Sender: TObject);
begin
  //Chama a procedure que busca o cliente
  BuscaCliente(edtcliente.Text);
end;

procedure TFrmPedidos.EdtCodProdutoExit(Sender: TObject);
begin
  //Chama a procedure que busca o produto
  BuscaProduto(EdtCodProduto.text);
  //Coloca a tabela de pedidos em modo insert
  FrmDM.FDMemPedidos_Produtos.Append;
end;

procedure TFrmPedidos.EdtQuantidadeExit(Sender: TObject);
begin
  //Chama a procedure que calcula o total do item
    Calc_TotalProduto(strtofloat(EdtQuantidade.text),strtofloat(EdtValorUnitario.text));
end;

procedure TFrmPedidos.EdtValorUnitarioExit(Sender: TObject);
begin
  //Chama a procedure que calcula o total do item
    Calc_TotalProduto(strtofloat(EdtQuantidade.text),strtofloat(EdtValorUnitario.text));
end;

procedure TFrmPedidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Fecha as tabelas e limpa os filtros
  FrmDM.FDMemPedidos_Produtos.close;
  FrmDM.FDMemPedidos_Produtos.filter := '';
  FrmDM.FDMemPedidos_Produtos.filtered := False;
  FrmDM.FDMemPedidos_Geral.close;
  FrmDM.FDMemClientes.close;
  FrmDM.FDMemProdutos.close;

  //Tira o form da memória
  Action := caFree;
  FrmPedidos := nil;
end;

procedure TFrmPedidos.FormShow(Sender: TObject);
begin
  //Abre as tabelas
  FrmDM.FDMemPedidos_Geral.Open;
  FrmDM.FDMemPedidos_Produtos.Open;

  //Inclui clientes manualmente
  with FrmDM.FDMemClientes do
  begin
    open;
    append;
    FieldByName('nome').Asstring := 'Ivo Aparecido da Silva de Souza';
    post;

    append;
    FieldByName('nome').AsString := 'Aline Christofolo Ferreira';
    post;

    append;
    FieldByName('nome').AsString := 'Valentina Christofolo Ferreira Souza';
    post;

  end;


  //Inclui produtos manualmente
  with FrmDM.FDMemProdutos do
  begin
    open;

    append;
    FieldByName('descricao').Asstring := 'Creme Dental';
    FieldByName('preco_venda').AsCurrency := 3.59;
    post;

    append;
    FieldByName('descricao').Asstring := 'Carne Moída';
    FieldByName('preco_venda').AsCurrency := 20.35;
    post;

    append;
    FieldByName('descricao').Asstring := 'Sabonete Líquido';
    FieldByName('preco_venda').AsCurrency := 9.98;
    post;

    append;
    FieldByName('descricao').Asstring := 'Chinelo Havaiana';
    FieldByName('preco_venda').AsCurrency := 21.50;
    post;

    append;
    FieldByName('descricao').Asstring := 'Biscoito Recheado';
    FieldByName('preco_venda').AsCurrency := 3.50;
    post;
  end;

end;

procedure TFrmPedidos.BtnIncluirPedidoClick(Sender: TObject);
begin

  if EdtCliente.Text <> '' then
  begin
    //Inclui um pedido novo
    AdicionarPedido(EdtCliente.Text);
    //Chama a procedure que limpa os edits
    LimparControles();
    //Filtra o pedido na tabela itens do pedido
    Filtra_Pedido_Produtos(EdtNumeroPedido.Text);
    //Preenche a data de entrega
    EdtDataEntrega.Text := FormatDateTime('dd/mm/yyyy',Entrega_Pedido());
  end;
end;

procedure TFrmPedidos.BtnSalvarClick(Sender: TObject);
begin
  //Chama a procedure que irá incluir os itens do pedido
  AdicionarProdutos(EdtCodProduto.text, EdtQuantidade.Text, EdtValorUnitario.text, EdtValorTotal.Text);
end;

procedure TFrmPedidos.BtnBuscaClienteClick(Sender: TObject);
begin
  //chama a procedure que irá buscar o cliente
  BuscaCliente(edtcliente.Text);
end;

procedure TFrmPedidos.BtnBuscaProdutoExit(Sender: TObject);
begin
  //chama a procedure que irá buscar o produto
  BuscaProduto(EdtCodProduto.text);
end;

procedure TFrmPedidos.BtnCarregarPedidoClick(Sender: TObject);
var
  numero_pedido : string;
begin
   numero_pedido := InputBox('Carregar Pedido','Insira o número do pedido','');
   if numero_pedido <> '' then
   begin
    //Chama a procedure que irá buscar o Pedido
    CarregaPedido(numero_pedido);
    //Procedure que irá filtar os itens do pedido
    Filtra_Pedido_Produtos(EdtNumeroPedido.Text);
   end;

end;

//Procedure que irá buscar o Cliente
procedure TFrmPedidos.BuscaCliente(codcliente:string);
begin
  if EdtCliente.Text = '' then
  begin
    EdtCliente.Clear;
    lblNomeCliente.Caption := '';
    BtnCarregarPedido.Visible := True;
    BtnIncluirPedido.Visible := False;
    exit;
  end;

  try
    strtoint(codcliente);
  except
    application.MessageBox('O código do cliente deve ser numérico','Atenção', MB_OK + MB_ICONWARNING);
    edtcliente.Clear;
    exit;
  end;

  with FrmDM.FDMemClientes do
  begin
    locate('codigo',codcliente, [loPartialKey,loCaseInsensitive ]);
    if not isempty then
    begin
      edtCliente.text :=  fieldbyname('codigo').asstring;
      lblnomecliente.caption :=  fieldbyname('nome').asstring;
      BtnCarregarPedido.Visible := false;
      BtnIncluirPedido.Visible := True;
    end;
  end;
end;

//Procedure que irá buscar o Produto
procedure TFrmPedidos.BuscaProduto(codproduto:string);
begin
  if EdtCodProduto.Text = '' then
  begin
    application.MessageBox('Digite o código do produto','Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  try
    strtoint(codproduto);
  except
    application.MessageBox('O código do produto deve ser numérico','Atenção', MB_OK + MB_ICONWARNING);
    edtcodproduto.Clear;
    abort;
  end;

  with FrmDM.FDMemProdutos do
  begin
    locate('codigo',codproduto, [loPartialKey,loCaseInsensitive ]);
    edtcodproduto.text :=  fieldbyname('codigo').asstring;
    lblDescricaoProduto.caption :=  fieldbyname('descricao').asstring;
    EdtQuantidade.text :=  '1';
    EdtValorUnitario.text :=  fieldbyname('preco_venda').asstring;
    Calc_TotalProduto(strtofloat(EdtQuantidade.text),strtofloat(EdtValorUnitario.text));
  end;
end;

//Procedure que irá calcular o total dos produtos
procedure TFrmPedidos.Calc_TotalProduto(quantidade:real;valor_unitario:real);
begin
  EdtValorTotal.Text := FormatFloat('#,###0.00',(quantidade * valor_Unitario));
end;


//Procedure que irá adicionar o Pedido
procedure TFrmPedidos.AdicionarPedido(codcliente:string);
begin

  with FrmDM.FDMemPedidos_Geral do
  begin
    append;
    EdtNumeroPedido.Text := fieldbyname('numero_pedido').asstring;
    EdtCodProduto.SetFocus;
  end;
end;

//Procedure que irá adicionar os itens do Pedido
procedure TFrmPedidos.AdicionarProdutos(codproduto:string; quantidade:string; valor_unitario:string; valor_total:string);
begin

  if FrmDM.FDMemPedidos_Produtos.State in [dsinsert] then
  begin

    with FrmDM.FDMemPedidos_Produtos do
    begin

        fieldbyname('numero_pedido').asinteger := strtoint(EdtNumeroPedido.text);
        fieldbyname('codigo_produto').asinteger := strtoint(EdtCodProduto.text);
        fieldbyname('quantidade').asfloat := strtofloat(EdtQuantidade.text);
        fieldbyname('valor_unitario').asfloat := strtofloat(EdtValorUnitario.Text);
        fieldbyname('valor_total').asfloat := strtofloat(EdtValorTotal.text);
        post;
      end;


      EdtCodProduto.SetFocus;


  end;

  if FrmDM.FDMemPedidos_Produtos.State in [dsEdit] then
  begin
    FrmDM.FDMemPedidos_Produtos.fieldbyname('quantidade').asfloat := strtofloat(EdtQuantidade.text);
    FrmDM.FDMemPedidos_Produtos.fieldbyname('valor_unitario').asfloat := strtofloat(EdtValorUnitario.Text);
    FrmDM.FDMemPedidos_Produtos.fieldbyname('valor_total').asfloat := strtofloat(EdtValorTotal.text);
    FrmDM.FDMemPedidos_Produtos.post;
    EdtCodProduto.ReadOnly := False;
    BtnBuscaProduto.Enabled := true;
  end;

  AtualizaTotalPedidos();


end;

//Procedure que irá atualizar o total do pedido
procedure TFrmPedidos.AtualizaTotalPedidos();
var
  marca : TBookMark;
  total : double;
begin

  total := 0;
  with FrmDM.FDMemPedidos_Produtos do
  begin
    marca := getbookmark;
    first;
    while not eof do
    begin
      total  :=  total + FrmDM.FDMemPedidos_Produtos.fieldbyname('valor_total').AsFloat;
      next;
    end;
    EdtTotalPedidos.Text := FormatFloat('#,###0.00',total);
    GotoBookmark(marca);
    freeBookmark(marca);
  end;


end;


//Procedure que irá limpar os controles
procedure TFrmPedidos.LimparControles();
begin
  EdtCodProduto.Clear;
  EdtQuantidade.Clear;
  EdtValorUnitario.Clear;
  EdtValorTotal.Clear;
  EdtTotalPedidos.Clear;
  lblDescricaoProduto.Caption := '';
end;


//Procedure que irá carregar o pedido
procedure TFrmPedidos.CarregaPedido(numero_pedido:string);
begin

    with FrmDM.FDMemPedidos_Geral do
    begin
      locate('numero_pedido',numero_pedido,[loPartialKey,loCaseInsensitive ]);
      if not isempty then
      begin
        LimparControles;
        EdtNumeroPedido.Text := fieldbyname('numero_pedido').asstring;
        EdtDataEntrega.Text := formatdatetime('dd/mm/yyyy',fieldbyname('numero_pedido').asdatetime);
        AtualizaTotalPedidos();
        DBGridPedidos_Produtos.SetFocus;
      end
      else
        application.MessageBox('Pedido não encontrado!','Atenção', MB_OK + MB_ICONWARNING);

    end;
end;

procedure TFrmPedidos.DBGridPedidos_ProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //Caso o usuário aperte o delete, exluir o item do pedido
  if key = VK_DELETE then
    Deleta_PedidoProduto(EdtNumeroPedido.Text, FrmDM.FDMemPedidos_Produtos.FieldByName('codigo').AsString);

  //Caso o usuário aperte enter, edita o item do pedido
  if key = VK_RETURN then
  begin
    Edita_PedidoProduto(EdtNumeroPedido.Text, FrmDM.FDMemPedidos_Produtos.FieldByName('codigo').AsString);
  end;

end;

//Procedure que deleta um item do pedido
procedure TFrmPedidos.Deleta_PedidoProduto(numero_pedido:string; codpedido_produto:string);
var
marca : TBookmark;
begin
  if MessageDlg('Deseja realmente excluir esse item?', mtConfirmation,[mbYes, mbNo], 0) = mrYes then
  begin

    with FrmDM.FDMemPedidos_Produtos do
    begin

      delete;
    end;

    AtualizaTotalPedidos();
  end;

end;

//Procedure que edita um item do pedido
procedure TFrmPedidos.Edita_PedidoProduto(numero_pedido:string; codpedido_produto:string);
var
marca : TBookmark;
begin

   with FrmDM.FDMemPedidos_Produtos do
    begin
      if not isempty then
      begin
        EdtCodProduto.Text := FieldByName('codigo_produto').AsString;
        EdtCodProduto.ReadOnly := true;
        BtnBuscaProduto.Enabled := false;
        lblDescricaoProduto.caption := FieldByName('descr_produto').AsString;
        EdtQuantidade.Text := FormatFloat('#,###0.00',(fieldbyname('quantidade').AsFloat)) ;
        EdtValorUnitario.Text := FormatFloat('#,###0.00',(fieldbyname('valor_unitario').AsFloat)) ;
        EdtValorTotal.Text := FormatFloat('#,###0.00',(fieldbyname('valor_total').AsFloat)) ;

        AtualizaTotalPedidos();
        EdtQuantidade.SetFocus;
        Edit;
      end;

    end;

end;


//Procedure que filtra um pedido na tabela de itens
procedure TFrmPedidos.Filtra_Pedido_Produtos(numero_pedido:string);
begin
  with FrmDM.FDMemPedidos_Produtos do
  begin
    filtered := false;
    filter := 'numero_pedido= ' + quotedstr(numero_pedido);
    filtered := true;
  end;
end;

//Função que localiza em qual dia cai a páscoa afim de calcular os feriados móveis
function TFrmPedidos.BuscaPascoa(ano: Word): TDate;
var
 n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12: Integer;
 mes, dia: Word;
begin

  n1  := ano mod 19;
  n2  := trunc(ano/100);
  n3  := ano mod 100;
  n4  := trunc(n2/4);
  n5  := n2 mod 4;
  n6  := trunc((n2+8)/25);
  n7  := trunc((n2-n6+1)/3);
  n8  := (19*n1+n2-n4-n7+15) mod 30;
  n9  := trunc(n3/4);
  n10 := n3 mod 4;
  n11 := (32+2*n5+2*n9-n8-n10) mod 7;
  n12 := trunc((n1+11*n8+22*n11)/451);

  mes := trunc((n8+n11-7*n12+114)/31);
  dia := (n8+n11-7*n12+114) mod 31;

  Result := IncDay(StrToDateTime(IntToStr(dia) + '/' + IntToStr(mes) + '/' + IntToStr(ano)),1);

end;


//Função que localiza os feriados fixos e móveis
function TFrmPedidos.Feriado(data: TDate): Boolean;
var
  i: integer;
  dia, mes, ano: Word;
  n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12: Integer;
  pascoa, carnaval, paixao, corpus: TDate;

begin

  Result := false;

  dia := DayOf(data);
  mes := MonthOf(data);


  // feriados fixos
  if ((dia = 1)   and (mes = 1))  or
     ((dia = 21)  and (mes = 4))  or
     ((dia = 1)   and (mes = 5))  or
     ((dia = 7)   and (mes = 9))  or
     ((dia = 12)  and (mes = 10)) or
     ((dia = 2)   and (mes = 11)) or
     ((dia = 15)  and (mes = 11)) or
     ((dia = 25)  and (mes = 12)) then
  begin
    Result := true;
    Exit;
  end;

  ano := YearOf(data);

  // feriados móveis
  pascoa := BuscaPascoa(ano);
  carnaval := IncDay(pascoa, -47);
  paixao := IncDay(pascoa, -2);
  corpus := IncDay(pascoa, 60);

  if (data = pascoa) or
     (data = carnaval) or
     (data = paixao) or
     (data = corpus) then
  begin
    Result := true;
    Exit;
  end;

end;

//Função que verifica se um dia é útil
function TFrmPedidos.DiaUtil(dia: TDate; sabado: Boolean): Boolean;
begin
  Result := true;
  if (Feriado(dia)) or (DayOfWeek(dia) = 1) then
    Result := False
  else
  begin
    if (not sabado) and (DayOfWeek(dia) = 7) then
      Result := false;
  end;
end;

//Função que calcula o dia da entrega
function TFrmPedidos.Entrega_Pedido(): TDate;
var
  i: integer;
  vContDiaUtil: integer;

begin

  vContDiaUtil := 0;
  Result := date;

  while vContDiaUtil < 10 do
  begin
    if DiaUtil(Result, false) then
        Inc(vContDiaUtil);
    Result := Result + 1;
  end;

end;


end.
