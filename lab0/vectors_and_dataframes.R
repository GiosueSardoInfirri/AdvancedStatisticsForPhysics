loch = c()
volume = c()
area = c()
lenght = c()
max_depth = c()
mean_depth = c()

filein = "/mnt/d/magistral/courses/Advanced Statistics for Physics Analysis/exercises/lab0/lakes.txt"
data = read.csv(filein, header = F, sep = ",")

# x = length(readLines(file(filein)))
x = 13
for (i in 1:as.integer(x)) {
    loch = c(loch, data[i, 1])
    volume = c(volume, data[i, 2])
    area = c(area, data[i, 3])
    lenght = c(lenght, data[i, 4])
    max_depth = c(max_depth, data[i, 5])
    mean_depth = c(mean_depth, data[i, 6])
}

df = data.frame(loch, volume, area, lenght, max_depth, mean_depth)
# print(df)

cat("The lake with highest volume is :", df[df['volume'] == max(df['volume'])][1], "\n")
cat("The lake with lowest volume is :", df[df['volume'] == min(df['volume'])][1], "\n")
cat("The lake with highest area is :", df[df['area'] == max(df['area'])][1], "\n")
cat("The lake with lowest area is :", df[df['area'] == min(df['area'])][1], "\n")

# Initial dataframe
print(df)


# Ordered dataframe
df = df[order(df["area"], decreasing = T), ]
print(df)

cat("Lakes with highest aera are", df[['loch']][1], "and", df[['loch']][2], "\n")


# Total area occupied by water
cat("Total area occupied by water:", sum(df['area']), "km squared\n")