require 'open-uri'
require 'pry'
#require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html=File.read(index_url)

    index_students=Nokogiri::HTML(html)

    #Using #collect to return a new array of the student hashes
    index_students.css("div.student-card").collect do |student|
      {
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end

    ###################################################################################
    #Code below works but relies on creating and returning the local variable, students

    #students=[]

    #Either line of code works
    #index_students.css("div.student-card").each do |student|
    #index_students.css("div.roster-cards-container div.student-card").each do |student|
      #students << {
        #:name => student.css("div.card-text-container h4.student-name").text,
        #:location => student.css("div.card-text-container p.student-location").text,
        ##:profile_url => student.css("div.student-card a href")#.value#.attribute("href")).value
        #:profile_url => student.css("a").attribute("href").value

      #}
    #end

    #students
  end

  def self.scrape_profile_page(profile_url)
    html=File.read(profile_url)

    student_page=Nokogiri::HTML(html)

    #binding.pry

    student_profile={
      :profile_quote => student_page.css("div.profile-quote").text,
      :bio => student_page.css("div.bio-content.content-holder div.description-holder p").text.gsub("\n","").gsub("  ",""),
      ##:twitter => student_page.css("div.social-icon-container a").attribute("href").value,
      ##:linkedin => student_page.css("div.social-icon-container a").attribute("href").value,
      ##:github => student_page.css("div.social-icon-container a").attribute("href").value,
      ##:blog => student_page.css("div.social-icon-container a").attribute("href").value
      }
      ##student_page.css("div.social-icon-container").each do |social_media|
      student_page.css("div.social-icon-container a").each do |social_media|
        ##:profile_quote => student_page.css("div.profile-quote").text,
        ##:bio => student_page.css("div.bio-content.content-holder div.description-holder").text.gsub("\n","").gsub("  ","")

        ##if social_media.css("a").attribute("href").value.include?("twitter")
        if social_media.attribute("href").value.include?("twitter")
          ##:twitter => social_media.css("a").attribute("href").value
          ##student_profile[:twitter] = social_media.css("a").attribute("href").value
          student_profile[:twitter] = social_media.attribute("href").value

        ##elsif social_media.css("a").attribute("href").value.include?("linkedin")
        elsif social_media.attribute("href").value.include?("linkedin")
          ##:linkedin => social_media.css("a").attribute("href").value
          ##student_profile[:linkedin] = social_media.css("a").attribute("href").value
          student_profile[:linkedin] = social_media.attribute("href").value
        ##elsif social_media.css("a").attribute("href").value.include?("github")
        elsif social_media.attribute("href").value.include?("github")
          ##:github => social_media.css("a").attribute("href").value
          ##student_profile[:github] = social_media.css("a").attribute("href").value
          student_profile[:github] = social_media.attribute("href").value
        else
          ##:blog => social_media.css("a").attribute("href").value
          ##student_profile[:blog] = social_media.css("a").attribute("href").value
          student_profile[:blog] = social_media.attribute("href").value if social_media.attribute("href").value != nil
        end
      end

    #binding.pry

    student_profile

  end

end
