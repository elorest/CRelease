require "yaml"
require "colorize"

if new_version = ARGV[0]?
  shard = YAML.parse(File.read("./shard.yml"))
  name = shard["name"].as_s
  version = shard["version"].as_s

  files = {"shard.yml" => "version: #{version}", "src/#{name}/version.cr" => %Q("#{version}")}
  files.each do |filename, version_str|
    puts "Updating version numbers in #{filename}.".colorize(:light_magenta)
    file_string = File.read(filename).gsub(version_str, version_str.gsub(version, new_version))
    File.write(filename, file_string)
  end

  message = "Bumped version number to v#{new_version}." unless message = ARGV[1]?
  puts "git commit -am \"#{message}\"".colorize(:yellow)
  `git commit -am "#{message}"`
  `git push`
  puts "git tag -a v#{new_version} -m \"#{name} v#{new_version}\"".colorize(:yellow)
  `git tag -a v#{new_version} -m "#{name} v#{new_version}"`
  puts "git push origin v#{new_version}".colorize(:yellow)
  `git push origin v#{new_version}`
else
  puts "Error: Version number required\n".colorize(:red)
  puts "crelease 0.1.1".colorize(:cyan)
  puts "or".colorize(:light_gray)
  puts "crelease 0.1.1 \"Commit message\"\n".colorize(:cyan)
end
