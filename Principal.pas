unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Pedidos1: TMenuItem;
    procedure Pedidos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses Pedidos, DM;

procedure TFrmPrincipal.Pedidos1Click(Sender: TObject);
begin
    if not Assigned(FrmPedidos) then
      Application.CreateForm(TFrmPedidos, FrmPedidos);
    FrmPedidos.ShowModal;
end;

end.
