Invoice-latex - a professional invoice.
=======================================

_**Work in progress.**_

Create beautiful and professionnal invoice with latex thanks to these easy to use tex classes.

Get started
-----------

Install invoice-latex on your system and copy demo file.

~~~bash
cp demo/invoice_english.tex your/path/to/invoice.tex
~~~

~~~bash
cd your/path/to/
pdflatex invoice.tex
~~~

Commands
--------

### \invoicestyle

Select style by name.

\invoicestyle{`style_name`}

~~~latex
\invoicestyle{classic} % use classic style
~~~

### \invoicenumber

Set the invoice number.

\invoicenumber{`number`}

~~~latex
\invoicenumber{1234}
~~~

### \vat

Set the vat.

\vat{`number`}

~~~latex
\vat{8.75} % set 8.75\%
~~~

### \currency

Set the currency code and symbol.

\currency{`currency_code`}{`currency_symbol`}

~~~latex
\currency{USD}{\$}
~~~

License
-------

invoice-latex is licensed under the MIT licenses.
