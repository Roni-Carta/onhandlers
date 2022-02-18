# OnHandlers

## The Idea

The goal of this small script is to simply enumerate all event handlers that **potentially** can be called from an HTML attribute. This might be handful for Security Researchers when crafting XSS payloads where there is a Black List filter removing the obvious event handlers.

## Run the Script

$ bash onhandlers.sh | tee wordlist.txt

## How to use the Wordlist

Let's assume that you found an HTML Injection like this:

- `https://www.example.com/"><svg>`

You add a `onfocus=a` event but then you have the WAF forbidding you from exploiting the vulnerability !
Then you try `onxxx=a` but you don't get blocked. It seems it's a Black List Based Filter ;D

You could simply do something like and wait for the right response code:

```bash
fuzz -w wordlist.txt -u 'https://www.example.com/"><svg FUZZ=a>' -fc 403 -c
```

Use your favorite way to fuzz and hack the planet !

## Side Note

This script is bonded by the links on the [MDN Documentation](https://developer.mozilla.org/en-US/docs/Web/Events) page. You'll see that the page misses some event handlers such as [`onpointerrawupdate`](https://github.com/w3c/pointerevents/pull/260).

Moreover not all event handlers on the Wordlist will result in an XSS triggering or sometimes they'll need precondition (like a `contenteditable` attribute). Therefore the recommendation would be to check for the MDN documentation when you have a match in other to confirm the bypass of the filter.
