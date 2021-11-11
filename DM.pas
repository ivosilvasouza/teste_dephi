unit DM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Win.ADODB;

type
  TFrmDM = class(TDataModule)
    DSClientes: TDataSource;
    DSProdutos: TDataSource;
    DSPedidos_Geral: TDataSource;
    DSPedidos_Produtos: TDataSource;
    FDMemClientes: TFDMemTable;
    FDMemClientescodigo: TFDAutoIncField;
    FDMemClientesnome: TStringField;
    FDMemProdutos: TFDMemTable;
    FDMemProdutoscodigo: TFDAutoIncField;
    FDMemProdutosdescricao: TStringField;
    FDMemProdutospreco_venda: TBCDField;
    FDMemPedidos_Geral: TFDMemTable;
    FDMemPedidos_Geralnumero_pedido: TFDAutoIncField;
    FDMemPedidos_Geraldata_emissao: TDateTimeField;
    FDMemPedidos_Geralcodigo_cliente: TIntegerField;
    FDMemPedidos_Geralvalor_total: TBCDField;
    FDMemPedidos_Geraldata_entrega: TDateField;
    FDMemPedidos_Produtos: TFDMemTable;
    FDMemPedidos_Produtoscodigo: TFDAutoIncField;
    FDMemPedidos_Produtosnumero_pedido: TIntegerField;
    FDMemPedidos_Produtoscodigo_produto: TIntegerField;
    FDMemPedidos_Produtosquantidade: TBCDField;
    FDMemPedidos_Produtosvalor_unitario: TBCDField;
    FDMemPedidos_Produtosvalor_total: TBCDField;
    FDMemPedidos_ProdutosDescr_Produto: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDM: TFrmDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
