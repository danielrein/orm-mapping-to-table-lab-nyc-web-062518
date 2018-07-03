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
    run_sql('CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER)')
  end

  def self.drop_table
    run_sql('DROP TABLE students')
  end

  def save
    run_sql('INSERT INTO students (name, grade) VALUES (?, ?)',
    self.name, self.grade)
    @id = run_sql('SELECT MAX(id) from students').flatten[0]
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
