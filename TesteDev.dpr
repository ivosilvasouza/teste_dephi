program TesteDev;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {FrmPrincipal},
  DM in 'DM.pas' {FrmDM: TDataModule},
  Pedidos in 'Pedidos.pas' {FrmPedidos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmDM, FrmDM);
  Application.Run;
end.
