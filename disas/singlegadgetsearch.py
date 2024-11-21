def search_text_file(filename, search_term):
  try:
    number = 0
    with open(filename, 'r') as file:
    #   prev_line = None

    #   for line in file:
    #     line = line.strip()
    #     next_line = next(file)
    #     if search_term.lower() in line.lower():
    #       if next_line and (("rt" in next_line) or ("pop pc" in next_line)):
    #         print(line)
    #         next_line = 
    #         print(next_line)
        lines = file.readlines()
        for i, line in enumerate(lines):
            line = line.strip()

            if search_term.lower() in line.lower():
                if i < len(lines) - 1 and (("rt" in lines[i+1]) or ("pop pc" in lines[i+1])):
                    number = number + 1
                    print(str(number)+".")
                    print("        " + line)
                    print(lines[i+1])

  except FileNotFoundError:
    print(f"Error: File '{filename}' not found.")

filename = input("Enter the name of the text file: ")
while True:
    
    search_term = input("Enter the term to search for: ")
    search_text_file(filename, search_term)
