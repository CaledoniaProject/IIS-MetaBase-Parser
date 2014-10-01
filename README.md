IIS MetaBase.xml parser
----------------------------

The module matches ServerBindings with Physical Paths. *Much more* helpful than the adsutil script

Usage:
<pre>./metabase.pl /path/to/MetaBase.xml</pre>


Output:
<pre>
Physical Path: c:\inetpub\wwwroot
Domain name:  
    - (any) 80

Physical Path: d:\website
Domain name:  
    - website.com
    - demo.website.com:8080
</pre>

I cannot provide real-world examples here.
