require File.join( File.dirname(__FILE__), '.', "spec_helper" )

=begin

# Reference Scenario

## An unsuspecting user is visiting a certain host web page (at a _REF_URL_)
   with a question UI-let embedded

### _BASE_URL_=http://askem.org/{Question}?ans={A1}|{A2}|{A3}
### (Optional) Parameters:
#### ans - a |-separated list of reply options, also used to restrict the dataset
           / default is {Question}-specific, e.g. Yes|No|Maybe
#### hui - img/... (hosted user interface) represents embedding method
           / default is a web page/frame UI (see below)
#### ref - an HTTP-encoded referrer (host web page) URL pattern to restrict
           the UI availability/dataset to
           / default is no restriction - the UI will be operational on any page
         - alternatively, when replying it's an actual referrer URL encoded
#### skin - hui-dependent skin name
#### style - skin-dependent style option string
             / for the default skin (and maybe others as well)
               it's an HTTP-encoded CSS-like formatted string
#### flash - seconds till hitting BACK with JS

   The embedded code should look like:
    <A HREF="_BASE_URL_&hui=img" TITLE="Hit it!" ><IMG SRC="_BASE_URL_&hui=img"  ALT=":(" ISMAP="ismap" /></A>
   The UI-let may include indication of the replies ratios based on the defined
   dataset, e.g. the answers' relative font sizes may represent those ratios

### After reading the question and the answer options the user chooses one
#### If it is a server-side image map ui (hui=img), the user's click on
     an answer region yields a request to
     _BASE_URL_&hui=img?{X},{Y}
     which relies on the HTML code validity to detect the chosen reply

### The service registers the user's reply and optionally shows question stats
    (including a clear notice on the chosen user reply, if any)
#### If it is a server-side image map ui (hui=img), the user is redirected
     to the question stats page at
     _BASE_URL_&flash={DELAY}
     which will return the user back after a DELAY

## A user may browse the questions database

### _BASE_URL_=http://askem.org/
### (Optional) Parameters:
#### TODO TBD

## A user may see a question stats page

FEATURE IDEAS

# HUI autodetection - e.g. by first-level domain
=end

# TODO describe Askem, :as => 'webservice' # which should enable:
#        it "should display a web page", :eg => url(:webpage)
#
describe Askem do

  describe "when requested a question on a host web page" do

    describe "as an image" do

      it "should return an image with question and answers (proportionally sized) rendered on it"
      # TODO and more than that, think of marking the user-replied answer
      # TODO think of caching or performance tests
      # TODO it should work with styles

      describe "when the request parameters are invalid" do

        it "should return a special (error) image"

      end

    end

  end

  describe "when a question is answered on a host web page" do

    describe "when a question image map is clicked" do

      it "should deduce the reply from the click coordinates"

      it "should redirect the user to the question stats flash page"

    end

    it "should store the user reply"

    describe "when the user has previously replied to the question" do
      it "should effectively replace the reply record"
    end

  end

  describe "when requested a question stats page" do

    it "should show the question stats page with all the correct statistics"

    describe "when the user has previously replied to the question" do

      it "should show an appropriate notice with an option to clear the reply"

    end

  end

  describe "when requested to clear a user's reply" do

    it "should clear the user's reply"

  end

end
