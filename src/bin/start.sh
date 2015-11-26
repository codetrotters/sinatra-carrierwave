DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../
bundle exec shotgun -o 0.0.0.0
