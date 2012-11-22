XULStrap (alpha)
================

XULStrap is just a single XSLT file to translate some XUL semantics into HTML ones based on Twitter Bootstrap.

Why do I need XULStrap?
-----------------------

Twitter Bootstrap makes easy to develop HTML layouts, with nice buttons, forms, and so one...
But problem is that HTML **IS NOT** a GUI language

For instance, if you want to add a navigation bar to your web page with Twitter Bootstrap, you need to write:

    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          ...
        </div>
      </div>
    </div>

It's resulting in a nice toolbar but why so much code? Because... HTML **IS NOT** a GUI language

Now, let's see a bit of XUL code :

    <menubar>
      ...
    </menubar>

See? There is really few lines of code! Why? Because... XUL **IS** a GUI language

How does it work?
-----------------

(to be written)
