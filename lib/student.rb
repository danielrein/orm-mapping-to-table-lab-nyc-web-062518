class Student

  attr_accessor :name, :grade
  attr_reader :id

  @@all = []

  def initialize(id=nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER)
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade) VALUES (?, ?)
    SQL
    run_sql(sql, self.name, self.grade)
    run_sql('SELECT MAX(id) from students').flatten[0]
  end

  def self.create(hash)
    student = Student.new(hash[:name], hash[:grade])
    student.save
    student
  end

  def run_sql(string, *args)
    DB[:conn].execute(string, *args)
  end

  def self.run_sql(string, *args)
    DB[:conn].execute(string, *args)
  end

end
