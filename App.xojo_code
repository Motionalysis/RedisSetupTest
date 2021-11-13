#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  LocalServer = NewLocalServer
		  LocalServer.Port = RedisPort
		  LocalServer.Start
		  
		  var r as new Redis_MTC(RedisPassword,RedisAddress,RedisPort)
		  
		  var redisready as Boolean = r.Set("attached","alive")
		  If r.Get("attached")="alive" then
		    wndMain.loRedis.FillColor=Color.Green
		  end if
		  wndMain.Show
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  If error <> Nil Then
		    Var type As String = Introspection.GetType(error).Name
		    MessageBox(type + EndOfLine + EndOfLine + Join(error.Stack, EndOfLine))
		  End If
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Initialize()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NewLocalServer() As RedisServer_MTC
		  dim serverFile as FolderItem 
		  #if TargetMacOS then
		    
		    dim folderName as string  = "Redis Server Mac "
		    if IsAppleARM then
		      folderName = folderName + "ARM"
		    else
		      folderName = folderName + "Intel"
		    end if
		    
		    serverFile = ResourcesFolder.Child( folderName ).Child( "redis-server" )
		  #else
		    serverFile = ResourcesFolder.Child( "Redis Server Windows" ).Child( "redis-server.exe" )
		  #endif
		  
		  // no saving conf file
		  'dim configFile as FolderItem = ResourcesFolder.Child( "redis-port-31999-no-save.conf" )
		  
		  // saving conf file
		  dim configFile as FolderItem = ResourcesFolder.Child("Motionalysis").Child("redis-server-gui.conf")
		  
		  dim server as new RedisServer_MTC
		  server.RedisServerFile = serverFile
		  server.ConfigFile = configFile
		  server.DBFilename = "testmotiodata.rdb"
		  server.WorkingDirectory=SpecialFolder.SharedApplicationData.Child("Motionalysis")
		  return server
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		LocalServer As RedisServer_MTC
	#tag EndProperty

	#tag Property, Flags = &h0
		RedisAddress As String = "localhost"
	#tag EndProperty

	#tag Property, Flags = &h0
		RedisPassword As String
	#tag EndProperty

	#tag Property, Flags = &h0
		RedisPort As Integer = 6379
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if TargetMacOS then
			    
			    dim contents as FolderItem = App.ExecutableFile.Parent.Parent
			    return contents.Child( "Resources" )
			    
			  #else
			    
			    dim name as string = App.ExecutableFile.Name
			    if name.Right( 4 ) = ".exe" then
			      name = name.Left( name.Len - 4 )
			    end if
			    
			    dim parent as FolderItem = App.ExecutableFile.Parent
			    dim resourcesName as string = name + " Resources"
			    dim resourcesFolder as FolderItem = parent.Child( resourcesName )
			    return resourcesFolder
			    
			  #endif
			End Get
		#tag EndGetter
		ResourcesFolder As FolderItem
	#tag EndComputedProperty


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


End Class
#tag EndClass
