#!/usr/bin/ruby
# encoding: UTF-8
#
# ignore comments and trackback/logs
#

require 'nokogiri'
require 'date'
require 'uri'
require 'base64'
require 'reverse_markdown'

input = ARGV[0]

if input != nil
  puts "Input: #{ARGV[0]}"
else
  puts "usage: #{$PROGRAM_NAME} BACKUP_XML"
  exit
end

#
# read blog from backup file.
data = File.read(input)
puts "Read #{data.size} Byte from #{input}."
doc = Nokogiri::XML(data)

#
# make target directories.
attachments = "/attachments"
post_base = Dir.pwd + "/_in"
file_base = Dir.pwd + attachments
Dir.mkdir(post_base) unless File.directory?(post_base)
Dir.mkdir(file_base) unless File.directory?(file_base)

#
# extract posts and attachements
doc.xpath('//post').each do |p|
  id = p.at_xpath('id').content
  title = p.at_xpath('title').content
  content = p.at_xpath('content').content
  category = 'None'
  if p.at_xpath('category')
    category = p.at_xpath('category').content
  end
  published = Time.at(p.at_xpath('published').content.to_i).to_datetime
  modified = Time.at(p.at_xpath('modified').content.to_i).to_datetime
  file_date = published.strftime('%Y-%m-%d')

  tags = []
  p.children.each do |c|
    if c.name == 'attachment'
      afile = "#{file_date}-#{c.at_xpath('label').content}"
      File.open(file_base + '/' + afile, 'wb') do |f|
        f.write(Base64.decode64(c.at_xpath('content').content))
      end
    elsif c.name == 'tag'
      tags.push(c.content.downcase.gsub(/ /, '-'))
    elsif ['title', 'author', 'id', 'content', 'isKorea', 'visibility',
        'location', 'password', 'acceptComment', 'acceptTrackback',
        'published', 'created', 'modified', 'category',
        'device', 'uselessMargin', 'text'
    ].include?(c.name)
      # exclude while debugging.
    else
      # debugging output.
      puts "P #{c.name}: #{c.content[0..30]}"
    end
  end

  filename = title.gsub(/ /, '-').gsub(/[\/\,\!\"\(\)\|\:\[\]\?\'\n]/, '')
  filename = "#{file_date}-#{filename}.md"
  content = ReverseMarkdown.convert content

  File.open(post_base + '/' + filename, 'w') do |f|
    f.write("---\n")
    f.write("title: #{title}\n")
    f.write("category: #{category}\n")
    f.write("keywords: #{tags.join(', ')}\n")
    f.write("tags: #{tags.join(' ')}\n")
    f.write("published: #{published}\n")
    f.write("modified: #{modified}\n")
    f.write("---\n")
    f.write(content.gsub(/\[##.* alt="([^"]*)".* filename="([^"]+)" .*_##\]/, "![\\1](#{attachments}/#{file_date}-\\2)"))
  end
end

