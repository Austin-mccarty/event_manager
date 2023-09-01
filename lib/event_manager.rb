require 'csv'
require 'date'

def clean_regdate(regdate_str)
    return unless regdate_str  # Handle potential nil values

    time_format = '%m/%d/%y %H:%M'
    hour_output = '%H'
    
    regdate = DateTime.strptime(regdate_str, time_format)
    regdate.strftime(hour_output)
    
end

def clean_regday(regdate_str)
    return unless regdate_str  # Handle potential nil values

    time_format = '%m/%d/%y %H:%M'
    
    regdate = DateTime.strptime(regdate_str, time_format)
    regdate = regdate.wday

    # convert day number to day name
    days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    day_name = days[regdate]
    return day_name
        
    
end

# add regdate into an array then test for most common number within arrray
def most_common_hour(regdate)
    hour_count = Hash.new(0)

    regdate.each do |hour|
        hour_count[hour] += 1
    end

    hour, count = hour_count.max_by{|k, v| v}
    return hour
end

def most_common_day(regdate)
    
    day_count = Hash.new(0)

    regdate.each do |day|
        day_count[day] += 1
    end

    day, count = day_count.max_by{|k, v| v}
    return day
end





puts 'EventManager Initialized!'

contents = CSV.open(
    'event_attendees.csv',
    headers: true,
    header_converters: :symbol
)

all_hours = []
all_days = []

contents.each do |row|
    hour = clean_regdate(row[:regdate])
    all_hours << hour if hour

    day = clean_regday(row[:regdate])
    all_days << day if day
end

common_hour = most_common_hour(all_hours)
puts "The most common hour is #{common_hour}"

common_day = most_common_day(all_days)

puts "The most common day is #{common_day}"


