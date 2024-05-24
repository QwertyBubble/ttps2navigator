# TTPs to ATT&CK Navigator
Based on [generate_attacknav_layer](https://github.com/infosecB/generate_attacknav_layer)
Tutorial for using this scripts:

1. Dowload `.\default.json` file from this repo OR go to [ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/) and then:
    - create new layer;
    - expand all sub-techniques;
    - select all and toggle state into disable;
    - export via json.
2. Run ` .\to_json.ps1 .\test_array.txt` and check that `array_of_objects.json` file has appeared

> [!IMPORTANT]
> change Encoding of this file from **UTF-8-BOM** to **UTF-8**

3. Run `python.exe .\to_navigator.py -i .\array_of_objects.json -n 2024 -t .\default.json -o final.json`
4. Upload `final.json` into ATT&CK Navigator form and then:
    - select all and toggle state into enable;
    - play with color setup. I recommend to use one color with different saturation

> [!NOTE]
> ```
>usage: tech2attacknav.py [-h] -i INPUT_FILE -n NAME [-t TEMPLATE_FILE] [-o OUTPUT_FILE]
>
>optional arguments:
>  -h, --help            show this help message and exit
>  -i INPUT_FILE, --input_file INPUT_FILE  Specify the input file that contains technique IDs
>  -n NAME, --name NAME  Specify the actor or tool name for the title of the resulting layer
>  -t TEMPLATE_FILE, --template_file TEMPLATE_FILE  Specify the ATT&CK Navigator layer .JSON template you would like to use
>  -o OUTPUT_FILE, --output_file OUTPUT_FILE  Specify the file for the resulting template layer .JSON content
>```
