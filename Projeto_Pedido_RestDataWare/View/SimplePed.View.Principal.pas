unit SimplePed.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, SimplePed.Controller.Interfaces,
  SimplePed.Controller.Produto.Interfaces, Vcl.DBCtrls,
  SimplePed.Controller.Pedido.Interfaces;

type
  TForm6 = class(TForm)
    edtID: TEdit;
    edtDESCRICAO: TEdit;
    edtVALORUNITARIO: TEdit;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    DataSource1: TDataSource;
    DBGrid2: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    Edit1: TEdit;
    Button5: TButton;
    DBGrid3: TDBGrid;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    FController : iController;
    FProduto : iControllerProduto;
    FPedido : iControllerPedido;
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses
  SimplesPed.Controller;

{$R *.dfm}

procedure TForm6.Button1Click(Sender: TObject);
begin
  FProduto.Buscar;
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  FProduto.Entidade.DESCRICAO := edtDESCRICAO.Text;
  FProduto.Entidade.VALORUNITARIO := StrToCurr(edtVALORUNITARIO.Text);
  FProduto.Insert;
  FProduto.Buscar;
end;

procedure TForm6.Button3Click(Sender: TObject);
begin
  FProduto.Entidade.ID := StrToInt(edtID.Text);
  FProduto.Entidade.DESCRICAO := edtDESCRICAO.Text;
  FProduto.Entidade.VALORUNITARIO := StrToCurr(edtVALORUNITARIO.Text);
  FProduto.Update;
  FProduto.Buscar;
end;

procedure TForm6.Button4Click(Sender: TObject);
begin
  FProduto.Entidade.ID := StrToInt(edtID.Text);
  FProduto.Delete;
  FProduto.Buscar;
end;

procedure TForm6.Button5Click(Sender: TObject);
begin
  FPedido.Itens.Entidade.ID_PEDIDO  := DataSource2.DataSet.FieldByName('ID').AsInteger;
  FPedido.Itens.Entidade.ID_PRODUTO := DataSource1.DataSet.FieldByName('ID').AsInteger;
  FPedido.Itens.Entidade.VALORUNITARIO := DataSource1.DataSet.FieldByName('VALORUNITARIO').AsCurrency;
  FPedido.Itens.Entidade.QUANTIDADE := StrToCurr(Edit1.Text);
  FPedido.Itens.Entidade.VALORTOTAL := (FPedido.Itens.Entidade.VALORUNITARIO * FPedido.Itens.Entidade.QUANTIDADE);
  FPedido.Itens.Insert;
  FPedido.Itens.Buscar(DataSource2.DataSet.FieldByName('ID').AsInteger);
end;

procedure TForm6.Button6Click(Sender: TObject);
begin
  FPedido.Buscar;
end;

procedure TForm6.Button7Click(Sender: TObject);
begin
  FPedido.Entidade.DATA := now;
  FPedido.Insert;
  FPedido.Buscar;
end;

procedure TForm6.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  edtID.Text := DataSource1.DataSet.FieldByName('ID').AsString;
  edtDESCRICAO.Text := DataSource1.DataSet.FieldByName('DESCRICAO').AsString;
  edtVALORUNITARIO.Text := DataSource1.DataSet.FieldByName('VALORUNITARIO').AsString;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  FController := TController.New(Self);
  FProduto := FController.Produto.DataSource(DataSource1);
  FPedido := FController.Pedido.DataSource(DataSource2);
  FPedido.Itens.DataSource(DataSource3);
end;

end.
