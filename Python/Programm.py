# Eelarve loomise programm.
# Programmi looja: {Enter name}


# Loon koodi loetavuse eesmärgil faili kirjutamiseks eraldiseisva funktsiooni.
def new_file(file_name):
    f = open(file_name + ".txt", "w", encoding= "utf-8") # Avan uue faili argumendiga "W", ehk write.
    
    # Loon massiivi sisestatud andmete meelde jätmiseks.
    data = []
    
    budget = input("Mis on sinu esialgne rahasumma? \n")
    f.write(budget + "\n") # kirjutan olemasoleva raha esimesele reale.
    data.append(float(budget)) # Jätan oma olemasoleva rahasumma alati esimeseks, sest siis on lihtsam sellega töödata.
    
    expense = input("Sisesta väljamineku nimetus: \n") # Algväärtustan while loopi lõputingimuse.
    i = 1 # Algväärtustan järjekorranumbri, et saaksin hiljem seda kasutada "maksmiseks".
    while expense != "":
        money = input("Sisesta väljamineku suurus: \n")
        f.write(str(i) + "," + expense + "," + money + "\n") # Kirjutan faili uue rea.
        
        # Jätan programmi meelde kõik elemendid juba eraldatult.
        data.append([i, expense, float(money)])
        
        # Jätkan küsimisega.
        i += 1
        expense = str(input("Sisesta väljamineku nimetus (Lõpetamiseks vajuta enter klahvi): \n"))
        
    f.close()
    return data

def new_balance(file_name, data, new_bal):
    data[0] = str(new_bal) + "\n"

    f = open(file_name + ".txt", "w", encoding="utf-8")
    f.writelines(data)

    print("Uus rahasumma on: " + str(new_bal) + " eurot\n")
    f.close()
    return data


# Valik kasutajale, kas ta soovib mõne varasema eelarve avada või uue luua. 
user_option = str(input("Kas soovite luua uue eelarve? [J/E]\n")).lower()

# Failist lugemine, kui kasutaja soovib kasutada vana eelarvet.
if user_option == "e" :
    file_name = input("Mis on faili nimi?\n") 
    f = open(file_name + ".txt", "r+", encoding= "utf-8") # R+ -> Read ja Write.
    data = f.readlines()
    
    # Küsin kas kasutaja soovib oma olemasolevat raha muuta ja vajadusel lasen tal seda teha.
    print("Hetkel on kirjas andmestikus Teie eelarves oleva rahana: " + data[0] + " eurot")
    change_balance = input("Soovid olemasolevat rahasummat muuta? [J/E]\n").lower()
    
    if change_balance == "j":
        new_bal = input("Hektel on mul eurosid: \n")
        data = new_balance(file_name, data, new_bal)
    
    # Korrastan failist saadud andmed ehk loon igast komaga eraldatud stringi osast eraldi elemendi.
    for i in range(len(data)):
        data[i] = data[i].strip() # Eemaldan uue rea märkme \n 
        data[i] = data[i].split(",")
    
# Faili loomine, kui kasutaja soovib luua uue eelarve.
elif user_option == "j":
    file_name = str(input("Mis on uue faili nimi?\n")) 
    data = new_file(file_name)


# Maksmine

# Eemaldan esialgse raha ja jätan selle hilisemaks esitamiseks meelde.
if user_option == "e":
    budget_original = float(data[0][0])
elif user_option == "j":
    budget_original = float(data[0])
data.pop(0)
budget = budget_original


i = 0
expense_num = 0
while True: # Loon lõpmatu while loopi.
    print("\n\nLõpetamiseks vajuta Enter klahvi!")
    
    # Väljastan andmed.
    for i in range(len(data)): 
        print("|" + str(data[i][0]) + "|" + data[i][1] + "|" +  str(data[i][2]) + "|") # Siin võid muuta neid | toru sümboleid, kuidas tahad.
        
    expense_num = input("Mida soovid maksta? (Järjekorranumber)\n")
    if expense_num == "": # kui sisestatakse tühi string, loop lõpeb. 
        break
    payment = float(input("Kui palju soovid maksta?\n"))
    
    # Eemaldan makstud summa "arvelt"
    for j in range(len(data)):
        if int(expense_num) == int(data[j][0]):
            data[j][2] = float(data[j][2]) - payment
            budget -= payment
            break
        else:
            print("Sellist numbrit pole...")

f = open(file_name + ".txt", "w", encoding="utf-8")
# Muudan andmed failis
data.insert(0, str(abs(budget)) + "\n")

# Korrastan andmed, selleks, et neid uuesti faili kirjutada.
for i in range(1, len(data)):
    data[i] = str(data[i][0]) + "," + str(data[i][1]) + "," + str(data[i][2]) + "\n"

# Kirjutan uued andmed faili
for e in range(len(data)):
    f.write(data[e])
f.close() # Sulgen faili


# Lõpusõnum
if budget > 0 :
    print(str(budget_original) + " eurost jäi alles vaid: " + str(budget) + " eurot :(")
else: 
    print("Sa oled miinuses, aeg tööle minna, sul on vaja juurde teenida: " + str(abs(budget)) + " eurot\n edu...")
