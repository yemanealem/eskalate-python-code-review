# Bug Explanation

## Bug

The Client.request() method only refreshed the OAuth2 token when the token was
missing or when it was an expired OAuth2Token instance.

However, the client allowed oauth2_token to also be a dictionary. When a
dictionary token was provided, the refresh logic did not trigger because the
condition only checked for OAuth2Token expiration. As a result, the client
proceeded without refreshing the token and no Authorization header was added.

## Why It Happened

The refresh condition used:

not self.oauth2_token OR (OAuth2Token AND expired)

This failed to handle the case where oauth2_token was a dictionary. Since the
dictionary was truthy but not an OAuth2Token instance, the refresh logic was
skipped.

## Fix

The condition was updated to refresh whenever the token is not an OAuth2Token
instance or when the OAuth2Token is expired:

not isinstance(self.oauth2_token, OAuth2Token) OR self.oauth2_token.expired

This ensures that invalid token types such as dictionaries trigger a refresh
and the Authorization header is correctly added.

## Edge Case Not Covered

The tests do not cover the case where an OAuth2Token expires during a long
running request or when the token contains malformed expiration values.
