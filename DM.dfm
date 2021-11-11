object FrmDM: TFrmDM
  OldCreateOrder = False
  Height = 392
  Width = 713
  object DSClientes: TDataSource
    DataSet = FDMemClientes
    Left = 216
    Top = 120
  end
  object DSProdutos: TDataSource
    DataSet = FDMemProdutos
    Left = 216
    Top = 168
  end
  object DSPedidos_Geral: TDataSource
    DataSet = FDMemPedidos_Geral
    Left = 216
    Top = 224
  end
  object DSPedidos_Produtos: TDataSource
    DataSet = FDMemPedidos_Produtos
    Left = 216
    Top = 288
  end
  object FDMemClientes: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 104
    Top = 120
    object FDMemClientescodigo: TFDAutoIncField
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      AutoIncrementSeed = 1
      AutoIncrementStep = 1
      IdentityInsert = True
    end
    object FDMemClientesnome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      Size = 100
    end
  end
  object FDMemProdutos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 104
    Top = 176
    object FDMemProdutoscodigo: TFDAutoIncField
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      AutoIncrementSeed = 1
      AutoIncrementStep = 1
    end
    object FDMemProdutosdescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 100
    end
    object FDMemProdutospreco_venda: TBCDField
      FieldName = 'preco_venda'
      Origin = 'preco_venda'
      Required = True
      DisplayFormat = 'R$ #,##0.00'
      EditFormat = 'R$ #,##0.00'
      Precision = 9
      Size = 2
    end
  end
  object FDMemPedidos_Geral: TFDMemTable
    IndexFieldNames = 'numero_pedido'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 104
    Top = 232
    object FDMemPedidos_Geralnumero_pedido: TFDAutoIncField
      FieldName = 'numero_pedido'
      Origin = 'numero_pedido'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      AutoIncrementSeed = 1
      AutoIncrementStep = 1
      IdentityInsert = True
    end
    object FDMemPedidos_Geraldata_emissao: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'data_emissao'
      Origin = 'data_emissao'
    end
    object FDMemPedidos_Geralcodigo_cliente: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'codigo_cliente'
      Origin = 'codigo_cliente'
    end
    object FDMemPedidos_Geralvalor_total: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_total'
      Origin = 'valor_total'
      DisplayFormat = 'R$ #,##0.00'
      EditFormat = 'R$ #,##0.00'
      Precision = 9
      Size = 2
    end
    object FDMemPedidos_Geraldata_entrega: TDateField
      FieldName = 'data_entrega'
    end
  end
  object FDMemPedidos_Produtos: TFDMemTable
    MasterSource = DSPedidos_Geral
    MasterFields = 'numero_pedido'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 96
    Top = 288
    object FDMemPedidos_Produtoscodigo: TFDAutoIncField
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      AutoIncrementSeed = 1
      AutoIncrementStep = 1
      IdentityInsert = True
    end
    object FDMemPedidos_Produtosnumero_pedido: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'numero_pedido'
      Origin = 'numero_pedido'
    end
    object FDMemPedidos_Produtoscodigo_produto: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'codigo_produto'
      Origin = 'codigo_produto'
    end
    object FDMemPedidos_Produtosquantidade: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade'
      Origin = 'quantidade'
      DisplayFormat = 'R$ #,##0.000'
      EditFormat = 'R$ #,##0.000'
      Precision = 12
      Size = 3
    end
    object FDMemPedidos_Produtosvalor_unitario: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_unitario'
      Origin = 'valor_unitario'
      DisplayFormat = 'R$ #,##0.00'
      EditFormat = 'R$ #,##0.000'
      Precision = 9
      Size = 2
    end
    object FDMemPedidos_Produtosvalor_total: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_total'
      Origin = 'valor_total'
      DisplayFormat = 'R$ #,##0.00'
      EditFormat = 'R$ #,##0.00'
      Precision = 9
      Size = 2
    end
    object FDMemPedidos_ProdutosDescr_Produto: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'Descr_Produto'
      Origin = 'descricao'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
  end
end
