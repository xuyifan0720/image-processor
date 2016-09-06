import os
import argparse

def get_file_lists(folder_name, file_extension):
    only_files = [f for f in os.listdir(folder_name)
                  if (os.path.isfile(os.path.join(folder_name,f)) and
                  f.endswith(file_extension))]
    return only_files

def modify_file_extension(location, from_name, to_name):
    original_files=get_file_lists(location,from_name)
    for f in original_files:
        basename = os.path.basename(f)
        newbasename = "%s%s" % (basename[:-1 * len(from_name)] , to_name)
        os.rename(os.path.join(location, basename), os.path.join(location, newbasename))
        print("file:%s has been renamed to:%s" % (basename, newbasename))


def main():
    parser = argparse.ArgumentParser("Argument for tool: refine name")
    parser.add_argument('-s', action='store', dest='location', required=True,
                        help='location where files name should be modified.')
    parser.add_argument('-f', action='store', dest='from_name', required=False,
                        help='Original extension of file', default='.jpg.jpg')
    parser.add_argument('-t', action='store', dest='to_name',required=False,
                        help='Intended extension of file', default='.jpg')

    args = parser.parse_args()
    modify_file_extension(args.location,args.from_name,args.to_name)

if __name__=='__main__':
    main()
