VERSION 5.00
Begin VB.Form DataStatistics 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "数据统计"
   ClientHeight    =   8400
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   6165
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8400
   ScaleWidth      =   6165
   StartUpPosition =   2  '屏幕中心
   Begin VB.Timer DataDisplay 
      Enabled         =   0   'False
      Interval        =   10
      Left            =   5520
      Top             =   7320
   End
   Begin VB.Timer DataLoad 
      Interval        =   25
      Left            =   5520
      Top             =   7800
   End
   Begin VB.CommandButton Back 
      Caption         =   "返回"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   14.25
         Charset         =   134
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   2160
      TabIndex        =   1
      Top             =   7320
      Width           =   1935
   End
   Begin VB.ListBox DataList 
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   10.5
         Charset         =   134
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   6045
      ItemData        =   "DataStatistics.frx":0000
      Left            =   480
      List            =   "DataStatistics.frx":0002
      TabIndex        =   0
      Top             =   480
      Visible         =   0   'False
      Width           =   5175
   End
   Begin VB.Label DataLoadLabel 
      Alignment       =   2  'Center
      Caption         =   "数据加载中"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   12
         Charset         =   134
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   495
      Left            =   2520
      TabIndex        =   2
      Top             =   3200
      Width           =   1215
   End
End
Attribute VB_Name = "DataStatistics"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim LoadCount As Integer

Private Sub Back_Click()
  Main.Show
  Unload Me
End Sub

Private Sub DataDisplay_Timer()
  If LoadCount <= Meta.MateAmount Then
    If Len(Meta.Name(LoadCount)) = 2 Then
      DataName = Mid(Meta.Name(LoadCount), 1, 1) + "　" + Mid(Meta.Name(LoadCount), 2, 1)
    Else
      DataName = Meta.Name(LoadCount)
    End If
    If LoadCount < 10 Then
      DataList.AddItem "0" + CStr(LoadCount) + "号 " + DataName + " 共计被抽中: " + CStr(Meta.Data_MateCount(LoadCount)) + "次"
    Else
      DataList.AddItem CStr(LoadCount) + "号 " + DataName + " 共计被抽中: " + CStr(Meta.Data_MateCount(LoadCount)) + "次"
    End If
    LoadCount = LoadCount + 1
  Else
    DataDisplay.Enabled = False
  End If
End Sub

Private Sub DataLoad_Timer()
  DataLoadLabel.Visible = False
  DataList.Visible = True
  DataList.AddItem "本程序在本次运行期间共生成了 " + CStr(Meta.Data_GenerateCount) + " 次"
  DataList.AddItem "以下是生成数据的情况:"
  Max = 0
  If Meta.Data_GenerateCount > 0 Then
    For i = 1 To Meta.MateAmount Step 1
      If Meta.Data_MateCount(i) >= Max Then
        Max = Meta.Data_MateCount(i)
        MaxIndex = i
      End If
    Next i
    DataList.AddItem ""
    DataList.AddItem Meta.Name(MaxIndex) + "被抽中的次数最多，为 " + CStr(Max) + " 次"
    DataList.AddItem ""
  Else
    DataList.AddItem ""
    DataList.AddItem "尚未抽取过一次，无法显示相关数据"
    DataList.AddItem ""
  End If
  DataDisplay.Enabled = True
  DataLoad.Enabled = False
End Sub

Private Sub Form_Load()
  Me.Icon = Main.Icon
  LoadCount = 1
End Sub

Private Sub Form_Unload(Cancel As Integer)
  Main.Show
End Sub
