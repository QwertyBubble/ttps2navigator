import json
import argparse

def extract_techniques(input_file):
    with open(input_file, 'r') as tech:
        data =  json.loads(tech.read())
        return data

def get_template(template_file):
    with open(template_file, 'r') as temp:
        data = json.load(temp)
        return data
 
def write_template(template_dict, filename=""):       
    outfile = open(filename, "w")
    outfile.write(json.dumps(template_dict))
    outfile.close()
    print("Success!")
 
def count_ttps(template_dict, techniques):
    for technique in techniques:
        for item in template_dict["techniques"]:
            if technique["Name"] == item["techniqueID"]:
                item["score"] = technique["Score"]
 
def set_title(title_name, template):
    template.update({"name": title_name + " TTPs"})
 
def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-i",
        "--input_file",
        help="Specify the input file that contains technique IDs",
        required=True,
    )
    parser.add_argument(
        "-n",
        "--name",
        help="Specify the actor or tool name for the title of the resulting layer",
        required=True,
    )
    parser.add_argument(
        "-t",
        "--template_file",
        help="Specify the ATT&CK Navigator layer .JSON template you would like to use",
        default="default",
    )
    parser.add_argument(
        "-o",
        "--output_file",
        help="Specify the file for the resulting template layer .JSON content",
        default="results.json",
    )
    args = parser.parse_args()
 
    techniques = extract_techniques(args.input_file)
    template = get_template(args.template_file)
    set_title(args.name, template)
    count_ttps(template, techniques)
    write_template(template, args.output_file)
    return 0
 
 
if __name__ == "__main__":
    main()