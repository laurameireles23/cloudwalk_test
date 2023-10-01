class Quake
  def execute
    informations = game_informations
    statistics = game_statistics(informations)
    dead_reasons = dead_reasons(informations)
    classification = organize_classification(statistics)

    puts "Summary of game matches:"
    puts statistics
    puts "----------------------------"

    puts "Reason for deaths per round:"
    puts dead_reasons
    puts "----------------------------"

    puts "Rating of players:"
    puts classification
  end

  private

  def game_informations
    round = 1
    infos = []

    File.foreach('quake.log') do |line|
      if line.include?('ShutdownGame:')
        round += 1
      elsif (match = line.match(/Kill: \d+ \d+ \d+: (.+) killed (.+) by (.+)/))
        killer, victim, mean = match.captures
        point = (killer == "<world>" || killer == victim) ? -1 : 1

        infos << {"round" => round, "killer" => killer, "victim" => victim, "mean" => mean, "point" => point }
      end
    end

    infos
  end

  def game_statistics(infos)
    game_stats = {}
    points_per_player_e_round = {}

    infos.each do |info|
      round, killer, victim, mean, point = info["round"], info["killer"], info["victim"], info["mean"], info["point"]
      round = "game_#{round}"

      game_stats[round] ||= {
        "total_kills" => 0,
        "players" => [],
        "kills" => {}
      }

      game_stats[round]["total_kills"] += point.abs

      game_stats[round]["players"] << killer unless killer == "<world>"
      game_stats[round]["players"] << victim
      game_stats[round]["players"].uniq!

      points_per_player_e_round[round] ||= {}
      points_per_player_e_round[round][killer] ||= 0
      points_per_player_e_round[round][victim] ||= 0

      if killer == "<world>" || killer == victim
        points_per_player_e_round[round][victim] -= 1
      else
        points_per_player_e_round[round][killer] += 1
      end

      game_stats[round]["kills"] = points_per_player_e_round.transform_values do |kills|
        kills.reject { |key, _| key == "<world>" }
      end
    end

    game_stats
  end

  def dead_reasons(game_stats)
    means_by_round = Hash.new { |hash, key| hash[key] = Hash.new(0) }

    game_stats.each do |info|
      round, mean = info["round"], info["mean"]

      means_by_round["game-#{round}"][mean] += 1
    end

    formatted_output = {}

    means_by_round.each do |round, means|
      formatted_output[round] = {
        "kills_by_means" => means
      }
    end

    formatted_output
  end

  def organize_classification(statistics)
    player_scores = {}
    all_players = []

    statistics.each do |game_name, game_data|
      game_data["players"].each do |player|
        player_scores[player] ||= 0
        all_players << player
        player_scores[player] += game_data["kills"][game_name][player].to_i
      end
    end

    all_players.uniq.each { |player| player_scores[player] ||= 0 }

    sorted_players = player_scores.sort_by { |player, score| [-score, player] }
    classification = []

    sorted_players.each_with_index do |(player, score), index|
      classification << "#{index + 1}. #{player}: #{score} points"
    end

    classification
  end
end

Quake.new.execute