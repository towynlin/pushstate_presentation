guard 'rspec', version: 2 do
  watch('pushstate_app.rb')
  watch(%r{^spec/})
  watch(%r{^views/}) { 'spec' }
end

guard 'coffeescript', input: 'assets', output: 'public'
guard 'sass', input: 'assets', output: 'public'

guard 'bundler' do
  watch('Gemfile')
end
