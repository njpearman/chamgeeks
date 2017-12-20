document.addEventListener('turbolinks:load', function () {
  if(typeof(StripeCheckout) !== 'undefined') {
    var handler = StripeCheckout.configure({
      key: 'pk_test_YCWUf8yvww0W893I2lruWUGf',
      image: 'https://stripe.com/img/documentation/checkout/marketplace.png',
      locale: 'auto',
      token: function(token) {
        // You can access the token ID with `token.id`.
        // Get the token ID to your server-side code for use.

        // here is where I need to post the form.
        document.getElementById('membershipForm').submit();
      }
    });

    document.getElementById('joinAsMember').addEventListener('click', function(e) {
      // Open Checkout with further options:
      handler.open({
        name: 'Cham Geeks',
        description: 'Membership for 2018',
        amount: 1000,
        currency: 'EUR'
      });
      e.preventDefault();
    });

    // Close Checkout on page navigation:
    window.addEventListener('popstate', function() {
      handler.close();
    });
  }
});
