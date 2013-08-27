# Cartos

This gem allows anyone who's using [cashbase](https://www.cashbasehq.com/) to export all of his data to a Google Spreadsheet. The data on one spreasheet has to belong to one single year. There will be one sheet for each month and one extra sheet summarizing the whole year.

You can see [here](https://docs.google.com/spreadsheet/ccc?key=0AqwuU2RQe3lzdEt5Rm1qZEp4RnNqOEsyRWJHcUQybnc&usp=sharing) an example of one of this Spreadsheets.

Homepage : [https://github.com/madtrick/cartos](https://github.com/madtrick/cartos)

Author : Farruco Sanjurjo ([@madtrick](https://twitter.com/madtrick))


## Installation

    $ gem install cartos
## Usage

### Configuration

Firs of all you must create the config file that ```cartos``` needs. To create it, run:

    $ cartos init

This command will create an empty config file in ```$HOME/.cartos.yml```. Following is a litle explanation of each config value:

  * ```google_spreadsheet.key```: this is the key of the spreasheet that cartos will use. You can find it in the url of the spreeadsheet

      ![Spreadsheet key](https://raw.github.com/madtrick/cartos/screenshoots/spreadsheet_url.png)

  * ```google_spreadsheet.username```: your google drive username.
  * ```google_spreadsheet.password```: your google drive password.
  * ```cashbasehq.account_name```: the wallet that you want to export.
  * ```cashbasehq.username```: your cashbase username.
  * ```cashbasehq.password```: your cashbase password.

### Exporting

For exporting your cashbase data to Google you have two choices:

  1. Download yourself an export from Cashbase and give it as input to cartos

        $ cartos export -f /path/to/the/export.csv -y 2012

  2. Let cartos handle it for you. If you have included your cashbase credentials in the config file, cartos will download itself your cashbase data.

        $ cartos export -y 2012

Notice that in both cases you have to especify the year.


### Charts

You can use [Cartos-GS](https://github.com/madtrick/cartos-gs) to create charts using the data exported by Cartos. For an example of the charts that you can create check the [example spreadsheet](https://docs.google.com/spreadsheet/ccc?key=0AqwuU2RQe3lzdEt5Rm1qZEp4RnNqOEsyRWJHcUQybnc#gid=19).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
