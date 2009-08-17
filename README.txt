ASK'EM
======

A primitive web poll engine.


Poll scope and accuracy
-----------------------

As a default minimum, publishing a question (with answer options) through the
Askem service requires only the question text.
- This string (as well as other parameters mentioned below) is used to form the
  poll URL -- for the widget HTML code.
- The widget HTML code may be generated using the API spec, or rather more
  friendly to a user, at any service web page (client-side JS).
- The HTML code then goes to a host web page which can be an aggregation of
  posts, or a permanent poll web page, or even some kind of protected page.
- A good user's browser also submits the referrer (host) page URL upon reply
  submission, and it is stored alongside the reply (see more on this below).

This technique implies the following conditions:
- Goodness of a user is an isolated and separate subject which is not mentioned
  hereafter - here we suppose a user is either good or it's no user
  The service is not restrictive in its nature at all; if you want a "closed"
  poll, you publish a restricted web page with that poll on.
- The poll results will be aggregated relatively to some specified reference, or
  -- if no reference is specified -- to referrer second-level domain name, or
  both (see below on the reference parameter), as well as per question.
- A poll URL may be accidentally or intentionally duplicated (asking the same
  question, specifying a well known reference, plain copying HTML code from the
  host page) meaning unwanted replies may come into picture.
- A user is always presented with a "confirmation" view clearly showing what the
  reply has been aggregated for.

Askem will accept any answer to any question (while trying to filter spam out,
of course), and it provides the following facilities for this matter:
  - The (web) API puts no substantial restriction on answer submit
  - Answer hints may be specified as a parameter: &ans=Good:)|Evil:(
  - The default answer hints are Yes|No|Well...
  - A user is presented with the answer options (hints) to choose from
  - When a hint text ends with ellipsis, the service will ask the user
    choosing that answer to complete it: Well... I dunno
    A single ellipsis hint specifies a totally free answer option.

As mentioned above, a poll reference may be specified:
  - If it is a valid URL, reply requests with referrer URL not starting with it
    will be "redirected" to the reference URL (not counting as replies).
    * This is the most restrictive technique, especially when used together with
      a protected host web page.
    Thus, the reference and the question effectively identify the poll.
  - Otherwise, the reference is used together with the referrer 2nd-level domain
    name for poll identification.
    To obtain an above degree of protection without having users have to answer
    a question through a specific page only, one may consider (freely supplied)
    *random* references: if a post is protected, and no one would want to copy
    the reference for public fun, the chances are that the poll will hold its
    maximum accuracy; if the post is public, accidental poll collision is still
    improbable (but it may be subject to malicious activity).
  - Also, Askem encourages *tagging*! Yes, the same reference parameter may be
    used to specify the context of the question -- for natural user orientation.
  - A user will be offered to place the "same" poll at their web page (with the
    same HTML code) - the reference parameter cleared if it was a valid URL.
    Techniques of poll protection are explained/configured on the same page.
