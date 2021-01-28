# g-translate-scraper
> Scrap translations from Gxxgle.

## Why?
I made this project to study ruby and scraping techniques. Also, I needed a translation API for another project and I don't want to use any paid API.

## Dependencies
- [Ruby](https://www.ruby-lang.org/en/)
- [Bundler](https://bundler.io/) 
- [Chrome webdriver](https://sites.google.com/a/chromium.org/chromedriver/downloads)

## Install
After cloning this repository, navigate to project folder and run:
```bash
bundle install
```
then spin up the webserver
```bash
bundle exec rackup -p 9292 config.ru
```
Use any port you like.

## Usage
```
GET /translate
```
Query parameters:
- **text**: the text to be translated.
- **sl**: the original text language.
    -  Default: **en** ([see all available languages](https://cloud.google.com/translate/docs/languages))
- **tl**: the desired translantion language
    - Default: **pt-BR** ([see all available languages](https://cloud.google.com/translate/docs/languages))
- **hl**: the default browser language. You should set this to your native language for best comprehension of the translations.
    -  Default: **pt-BR**


### Example 1
```bash
GET http://localhost:9292/translate?text=i%20love%20ruby
```

##### Response:
```json

{
    "text": "i love ruby",
    "translations": [
        {
            "data": "eu amo rubi"
        }
    ]
}
```
### Example 2
```bash
GET http://localhost:9292/translate?text=beautiful
```

##### Response:
Portuguese has gender variations for "beautiful" adjective.
```json
{
    "text": "beautiful",
    "translations": [
        {
            "data": "bonita",
            "variationDescription": "(feminino)"
        },
        {
            "data": "bonito",
            "variationDescription": "(masculino)"
        }
    ]
}
```

### Example 3
```bash
GET http://localhost:9292/translate?text=I%27m%20hungry&sl=en&tl=fr
```
```json

{
    "text": "I'm hungry",
    "translations": [
        {
            "data":"j'ai faim"
        }
    ]
}
```
