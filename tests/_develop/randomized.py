import mimesis

uuid = mimesis.Cryptographic().uuid()
name = mimesis.Person().full_name()
email = mimesis.Person().email()
