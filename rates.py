import bs4
import requests
import random
from requests.adapters import HTTPAdapter
from urllib3.util import Retry
from flask import Flask ,jsonify,render_template

app = Flask(__name__,template_folder='templates')

#All supported conversions by app
conversions = ['USDtoEUR','USDtoEGP','USDtoKWD','USDtoCHF','USDtoQAR','USDtoTRY','EGPtoEUR','EGPtoKWD','EGPtoCHF','EGPtoQAR','EGPtoTRY','EURtoKWD','EURtoCHF','EURtoQAR','EURtoTRY','KWDtoCHF','KWDtoQAR','KWDtoTRY','CHFtoQAR','CHFtoTRY','QARtoTRY']

#Dictionary which will be returned as JSON
live_cnvrates = {}

headers = {
"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36"
    }

#Function that Scrapes conversion rates selected page
def scrape(page):
    soup = bs4.BeautifulSoup(page,'html.parser')
    column = soup.find('div',class_='result-cur2')
    for span in column.find_all('span'):
        try:
            float(span.text)
        except ValueError:
            continue
        rate = float(span.text)
        #print(f'Conversion rate is {rate}')
        return rate

def getall():
    #Loops through all conversions list to get appropriate page link
    for conversion in conversions:
        currencies = []
        currencies = conversion.split('to')
        session = requests.Session()
        retry = Retry(connect=3, backoff_factor=0.5)
        adapter = HTTPAdapter(max_retries=retry)
        session.mount(f'https://www.exchange-rates.org/converter/{currencies[0]}/{currencies[1]}/1', adapter)
        session.mount(f'https://www.exchange-rates.org/converter/{currencies[0]}/{currencies[1]}/1', adapter)
        source = session.get(f'https://www.exchange-rates.org/converter/{currencies[0]}/{currencies[1]}/1',headers=headers).text
        result = scrape(source)
        live_cnvrates[conversion] = result
    session.close()

@app.route("/")
def home():
  getall()
  if len(live_cnvrates)>0:
    return jsonify(live_cnvrates),200
  else: return 'Nothing Found',404

if __name__ == '__main__':
    app.run(host="0.0.0.0",port=random.randint(2000, 9000))

