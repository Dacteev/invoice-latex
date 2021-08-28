%% Copyright 2014 Dacteev

%-------------------------------------------------------------------------------
%                identification
%-------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{invoice}[2014/02/11 v0.1.0 invoice class]

\LoadClass[11pt,a4paper]{article}

%-------------------------------------------------------------------------------
%                required packages
%-------------------------------------------------------------------------------
\RequirePackage{fancyhdr}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{url}
\RequirePackage{graphicx}
\RequirePackage{calc}
\RequirePackage{microtype}
\RequirePackage{babel}
\RequirePackage[autolanguage]{numprint}
\RequirePackage[unicode]{hyperref}
\RequirePackage{translator}
\RequirePackage{etoolbox}
\RequirePackage{bookmark}
\RequirePackage{marvosym}

% do not show thumbnails or bookmarks on opening (on supporting browsers); set \pdfpagemode to "UseOutlines" to show bookmarks
\newcommand*\pdfpagemode{UseNone}

\AtEndPreamble{
    % has to be issued before loading hyperref, as to set \thepage and hence to avoid hyperref issuing a warning and setting pdfpagelabels=false

    \hypersetup{
        breaklinks,
        baseurl        = http://,
        pdfborder      = 0 0 0,
        pdfpagemode    = \pdfpagemode,
        pdfstartpage   = 1,
        pdfcreator     = {\LaTeX{} with 'invoice-latex' package by Dacteev},
%       pdfproducer    = {\LaTeX{}},% will/should be set automatically to the correct TeX engine used
        bookmarksopen  = true,
        bookmarksdepth = 2,% to show sections and subsections
        pdfauthor      = {\@companyname{}},
        pdftitle       = {\translate{Invoice}\@clientname{}},
%        pdfsubject     = {Resum\'{e} of \@firstname{}~\@lastname{}},
        pdfkeywords    = {\translate{Invoice},\@clientname{}}
    }
}


%-------------------------------------------------------------------------------
%                some overall usefull commands
%-------------------------------------------------------------------------------

\newcommand*{\isargempty}[2]{
	\ifx&#1&%
	% #1 is empty
	\else
	% #1 is nonempty
	#2%
	\fi
}


%-------------------------------------------------------------------------------
%                overall design commands definitions
%-------------------------------------------------------------------------------



% SYMBOLS
\newcommand*{\marvosymbol}[1]{}
\renewcommand*{\marvosymbol}[1]{{\fontfamily{mvs}\fontencoding{U}\fontseries{m}\fontshape{n}\selectfont\char#1}}

\newcommand*{\addresssymbol}{}
\newcommand*{\mobilesymbol}{}
\newcommand*{\phonesymbol}{}
\newcommand*{\faxsymbol}{}
\newcommand*{\emailsymbol}{}
\newcommand*{\homepagesymbol}{}

% Invoice number
\newcounter{invoicenumber}

% Invoice total ext VAT
\def\@total{0}

% Invoice items
\def\@invoiceitems{}

% Use invoice style
%
% usage \invoicestyle{<style_name>}
\newcommand*{\invoicestyle}[1]{%
    \RequirePackage{invoice#1}%
}

% Define invoice number
%
% usage: \invoicenumber{<invoice_number>}
\newcommand*{\invoicenumber}[1]{%
    \setcounter{invoicenumber}{#1}%
}

% Define global vat
%
% usage: \vat{<vat_value>}
\newcommand*{\vat}[1]{%
    \def\@vat{#1}%
}

% Toggle whether the currency symbol should appear after the amount
%
% usage: \currencysymbolpostfix
\newtoggle{@postfixcurrencysymbol}
\newcommand*{\currencysymbolpostfix}{%
  \toggletrue{@postfixcurrencysymbol}%
}

% Define currency
%
% usage: \currency{<currency_code>}{<currency_symbol>}
\newcommand*{\currency}[2]{
    \def\@currencycode{#1}
    \def\@currencysymbol{#2}

    \iftoggle{@postfixcurrencysymbol}{
        \def\@currencybeforesymbol{}
        \def\@currencyaftersymbol{ #2}
    }{
        \def\@currencybeforesymbol{#2 }
        \def\@currencyaftersymbol{}
    }
}

% Define company name
%
% usage: \companyname{<name>}
\newcommand*{\companyname}[1]{%
    \def\@companyname{#1}%
}

% Define company address
%
% usage: \companyaddress{<address_street>}{<address_zipcode>}{<address_city>}{<address_state>}{address_country}
\newcommand*{\companyaddress}[5]{%
    \def\@companystreet{#1}%
    \def\@companyzipcode{#2}%
    \def\@companycity{#3}%
    \def\@companystate{#4}%
    \def\@companycountry{#5}%
}

% Define company phone
%
% usage: \companyphone{<phone_number>}
\newcommand*{\companyphone}[1]{%
    \def\@companyphone{#1}%
}

% Define company fax
%
% usage: \companyfax{<fax_number>}
\newcommand*{\companyfax}[1]{%
    \def\@companyfax{#1}%
}

% Define company email
%
% usage: \companyemail{<email_address>}
\newcommand*{\companyemail}[1]{%
    \def\@companyemail{#1}%
}

% Define company website
%
% usage: \companywebsite{<url>}
\newcommand*{\companywebsite}[1]{%
    \def\@companywebsite{#1}%
}

% Define company logo
%
% usage: \companylogo{<logo_name>}
\newcommand*{\companylogo}[1]{%
    \def\@companylogo{#1}%
}

% Define company taxnumber
%
% usage: \companytaxnumber{<name>}
\newcommand*{\companytaxnumber}[1]{%
	\def\@companytaxnumber{#1}%
}

% Define company iban
%
% usage: \companyiban{<name>}
\newcommand*{\companyiban}[1]{%
	\def\@companyiban{#1}%
}

% Define company bic
%
% usage: \companybic{<name>}
\newcommand*{\companybic}[1]{%
	\def\@companybic{#1}%
}

% Define company bank
%
% usage: \companybank{<name>}
\newcommand*{\companybank}[1]{%
	\def\@companybank{#1}%
}

% Define client ref
%
% usage: \clientref{<ref>}
\newcommand*{\clientref}[1]{%
    \def\@clientref{#1}%
}

% Define client name
%
% usage: \clientname{<name>}
\newcommand*{\clientname}[1]{%
    \def\@clientname{#1}%
}

% Define client address
%
% usage: \clientaddress{<address_street>}{<address_zipcode>}{<address_city>}{<address_state>}{address_country}
\newcommand*{\clientaddress}[5]{%
    \def\@clientstreet{#1}%
    \def\@clientzipcode{#2}%
    \def\@clientcity{#3}%
    \def\@clientstate{#4}%
    \def\@clientcountry{#5}%
}

% Define client phone
%
% usage: \clientphone{<phone>}
\newcommand*{\clientphone}[1]{%
    \def\@clientphone{#1}%
}

% Define client email
%
% usage: \clientemail{<email>}
\newcommand*{\clientemail}[1]{%
    \def\@clientemail{#1}%
}

% Define payment terms
%
% usage: \paymentterms{<terms_text>}
\newcommand*{\paymentterms}[1]{%
    \def\@paymentterms{#1}%
}

% Display invoice number
%
% usage: \showinvoicenumber
\newcommand*{\showinvoicenumber}{}

% Formats inputed number with 2 digits after the decimal place
%
% usage: \formatnumber[decimal]{<number>}
\newcommand*{\formatnumber}[2][2]{%
    \FPround{\cost}{#2}{#1}%
    \numprint{\cost}%
}

% Calculates the subtotal of given quantity and its unit price
% and formats the input with two digits after the decimal place
% and currency symbol
%
% usage: \subtotal[decimal]{<qty>}{<unit price>}
\newcommand*{\thesubtotal}[3][2]{%
	\FPeval{\cost}{#3 * #2}%
	\FPround{\cost}{\cost}{#1}%
	\@currencybeforesymbol\numprint{\cost}\@currencyaftersymbol%
}

% Formats inputed number with 2 digits after the decimal place
% and currency symbol
%
% usage: \showcurrency[decimal]{<number>}
\newcommand*{\showcurrency}[2][2]{%
    \FPround{\cost}{#2}{#1}%
    \@currencybeforesymbol\numprint{\cost}\@currencyaftersymbol%
}

% Make invoice logo
%
% usage: \makeinvoicelogo
\newcommand*{\makeinvoicelogo}{}

% Make invoice header
%
% usage: \makeinvoiceheader
\newcommand*{\makeinvoiceheader}{}

% Make invoice table
%
% usage: \makeinvoicelist
\newcommand*{\makeinvoicelist}{}

% Add invoice item
%
% usage: \invoiceitem{<label>}{<volume>}{<cpm>}
\newcommand*{\invoiceitem}[3]{}

% Make invoice footer
%
% usage: \makeinvoicefooter
\newcommand*{\makeinvoicefooter}{}

% Make invoice
%
% usage: \makeinvoice
\newcommand*{\makeinvoice}{
    \makeinvoiceheader
    \makeinvoicelist
    \makeinvoicefooter
}

% use default style
\invoicestyle{classic}

\endinput
