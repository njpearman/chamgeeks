document.addEventListener('turbolinks:load', function () {
  if(typeof(StripeCheckout) !== 'undefined') {
    document.getElementById('joinAsMember').disabled = false;
    var handler = StripeCheckout.configure({
      key: ChamGeeks.config.stripeKey,
      image: ChamGeeks.config.merchantGeekImage,
      locale: 'auto',
      token: function(token) {
        // You can access the token ID with `token.id`.
        // Get the token ID to your server-side code for use.

        // here is where I need to post the form.
        document.getElementById('paymentRef').value = token.id;
        document.getElementById('membershipForm').submit();
      }
    });

    document.getElementById('joinAsMember').addEventListener('click', function(e) {
      var form, email, amount, year;

      form = document.getElementById('membershipForm');

      if(form.checkValidity() === false) {
        return;
      }

      e.preventDefault();
      email = document.getElementById('membershipEmail').value;
      amount = document.getElementById('amountOfMembership').value;
      year = document.getElementById('yearOfMembership').value;

      // Open Checkout with further options:
      handler.open({
        email: email,
        name: 'Cham Geeks',
        description: 'Membership for ' + year,
        amount: amount,
        currency: 'EUR'
      });
    });

    // Close Checkout on page navigation:
    window.addEventListener('popstate', function() {
      handler.close();
    });
  }
});
