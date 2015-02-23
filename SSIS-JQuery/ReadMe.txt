The purpose of this project was to allow the execution of SSIS  packages files (.dtsx) via a Web based Single Page Application.

Business users without access to SSMS can use the Web page to execute the SSIS packages on demand. 


The application looks in the Web.Config file for the designated directory where the SSIS packages reside.

Below you can see an example directory.

-<appSettings>
	<add value="C:\SSIS Files" key="SSISDirectory"/>


The Web application is built around the SSIS packages it detects in the directory. Rendering the web page elements per each package. 


An IIS Application pool may run under a Domain account if the SSIS packages has to access restricted file shares or if a Sql  proxy account is needed to access locked down objects in a Sql Server (Tables\ Views\ Stored procs etc). 


