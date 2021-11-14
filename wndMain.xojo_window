#tag Window
Begin Window wndMain
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   0
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   400
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1983522815
   MenuBarVisible  =   True
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Redis Local Test"
   Type            =   0
   Visible         =   True
   Width           =   497
   Begin Oval loRedis
      AllowAutoDeactivate=   True
      BorderColor     =   &c00000000
      BorderThickness =   1.0
      Enabled         =   True
      FillColor       =   &cFFFFFF00
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   455
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Visible         =   True
      Width           =   22
   End
   Begin Label Label1
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   343
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Redis Status: "
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin PushButton btnRun
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Run"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   397
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   88
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin TextField txtRedisCommand
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Set ""Butch"" ""John"""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   88
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   354
   End
   Begin TextArea txtRedisCommandResult
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   True
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   237
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   122
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   1
      ValidationMask  =   ""
      Visible         =   True
      Width           =   354
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  App.LocalServer.Port = App.RedisPort
		  App.LocalServer.Start
		  
		  Timer.CallLater(500, AddressOf RedisInit)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub RedisInit()
		  
		  
		  var r as new Redis_MTC(App.RedisPassword,App.RedisAddress,6379)
		  
		  var redisready as Boolean = r.Set("attached","alive")
		  If r.Get("attached")="alive" then
		    wndMain.loRedis.FillColor=Color.Green
		  end if
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events btnRun
	#tag Event
		Sub Action()
		  var r as new Redis_MTC(App.RedisPassword,App.RedisAddress,App.RedisPort)
		  var result as Boolean
		  Try
		    Try
		      result=r.Execute(txtRedisCommand.Text)
		    Catch error as M_Redis.RedisException
		      MessageBox(error.Message)
		      return
		    End Try
		  Catch error as RuntimeException
		    MessageBox(error.Message)
		  End Try
		  
		  if result then
		    txtRedisCommandResult.Text=txtRedisCommand.Text+":  "+str(result)
		    txtRedisCommand.Text=""
		  else
		    var s as string = txtRedisCommandResult.Text
		    txtRedisCommandResult.Text="Error in command: "+txtRedisCommand.Text+":  "+str(result)+_
		    EndOfLine + txtRedisCommandResult.Text
		    txtRedisCommand.TextColor=Color.Red
		  end if
		End Sub
	#tag EndEvent
#tag EndEvents
