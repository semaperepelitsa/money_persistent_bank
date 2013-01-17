0.2.0

* Rates are now updated on each request using middleware.
  Use import_rates manually outside of web-requests.
* Save renamed to export_rates.
* Cache is separated from the main app to avoid fast expiration.

0.1.0. Update rates also when the rates are accessed directly: `bank.rates`
