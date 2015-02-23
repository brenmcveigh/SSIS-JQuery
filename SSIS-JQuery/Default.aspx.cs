using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.IO;
using Microsoft.SqlServer.Dts.Runtime;
using System.Runtime.Serialization.Json;

public partial class _Default : System.Web.UI.Page
{

    string[] _filePaths;
    
    ClientScriptManager _cs;


    protected void Page_Load(object sender, EventArgs e)
    {
        _cs = Page.ClientScript;
        _filePaths = ReadDirectory();
        foreach (var str in _filePaths)
        {
             buttonbody.InnerHtml += @"<tr><td width=""10%"" ><img  src=""Images/loader.gif"" id=""imgLoading" + Path.GetFileNameWithoutExtension(str) + @""" style=""display: none;  float:right""/></td><td class=""tablecellstyle1""><button type=""button"" class=""buttonstyle1""  id=" + Path.GetFileNameWithoutExtension(str) + @" onclick=""callSSISPackage(this)""; >" + Path.GetFileNameWithoutExtension(str) + "</button></td></tr>";
            
        }

        ManageCallBacks();

    }

    //read directory from web config file
    string ReadWebConfig(string value)
    {
        string ssisDirectory = ConfigurationManager.AppSettings[value];
        return ssisDirectory;
    }


    string[] ReadDirectory()
    {

        var dir = ReadWebConfig("SSISDirectory");
        var fileExtension = ReadWebConfig("SSISExtension");
        string[] filePaths = Directory.GetFiles(@dir,fileExtension);
        return filePaths;
        
    }

    class MyEventListener : DefaultEvents
    {
        public string _t;
 
        public override bool OnError(DtsObject source, int errorCode, string subComponent,string description, string helpFile, int helpContext, string idofInterfaceWithError)
        {
            // Add application-specific diagnostics here.
            Console.WriteLine("Error in {0}/{1} : {2}", source, subComponent, description);
           
           
            _t = @description + @source + @subComponent + errorCode;
            
            return false;
        }

        
    }

    string ExecuteSSISPackage( string packageLocation)
    {
        string pkgLocation = null;
        Package pkg;
        Application app;
        DTSExecResult pkgResults;

        MyEventListener eventListener = new MyEventListener();

        foreach (var dirpth in _filePaths)
        {
            if (dirpth.ToString().Contains(packageLocation))
                pkgLocation = dirpth;

        }

        
                
        app = new Application();
        pkg = app.LoadPackage(pkgLocation, eventListener);
        pkgResults = pkg.Execute(null, null, eventListener, null, null);
        
        return  pkgResults.ToString()   + ':'+eventListener._t ;
        
    }


    void ManageCallBacks()
    {
        string callback = Request.Params["Callback"];
        string buttonId = Request.Params["buttonId"];
        string ssisStatus = null;

        if (string.IsNullOrEmpty(callback))
            return;

        if (callback == "EntryList") 
        ssisStatus = ExecuteSSISPackage(buttonId);
        
        Response.Write(ssisStatus);
        Response.End();

    }


}