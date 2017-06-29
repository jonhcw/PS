function bounce([int]$length = 20, [int]$delay = 20) {
	cls
	$leftText = "BANG!"
	$rightText = "PONG!!"
	
	[System.Console]::CursorVisible = $false
	$posY = [int]([console]::WindowHeight / 2)
	$pos = [int]([console]::WindowWidth / 2) - [int]($length/2)
	
	$min = $pos - 1
	$max = $min + $length + 1
	
	if (($min - 1 - $leftText.length -lt 0) -or ($max + 2 + $rightText.length -gt [console]::WindowWidth)) {
		write-error "stupid length"
		return
	}
	
	[console]::SetCursorPosition($pos - 1, $posY)
	
	write-host "[" -foregroundcolor green -nonewline
	
	[console]::CursorLeft = $pos + $length + 1
	write-host "]" -foregroundcolor green -nonewline
	
	[console]::CursorLeft = $pos
	write-host "." -foregroundcolor red -nonewline
	
	$direction = "ascend"
	while (1) {
		# reset previous spot
		[console]::CursorLeft = $pos
		write-host " " -nonewline
		
		#get next spot
		If ($direction -eq "ascend") {
			$pos++
			if ($pos -eq $max) {
				$direction = "descend"
				[console]::SetCursorPosition($max + 2, $posY)
				write-host $rightText -foregroundcolor yellow -nonewline
			} elseif ($pos -gt $min + 5) {
				[console]::SetCursorPosition($min - $leftText.Length - 1, $posY)
				write-host (new-object -typename "string" -argumentlist " ", $leftText.length)
			}
		} else {
			$pos--
			if ($pos -le $min+1) {
				$direction = "ascend"
				[console]::SetCursorPosition($min - $leftText.Length - 1, $posY)
				write-host $leftText -foregroundcolor gray -nonewline
			} elseif ($pos -lt $max - 5) {
				[console]::SetCursorPosition($max + 2, $posY)
				write-host (new-object -typename "string" -argumentlist " ", $rightText.length)
			}
		}
		[console]::SetCursorPosition($pos, $posY)
		write-host "." -foregroundcolor red -nonewline
		[System.Threading.Thread]::Sleep($delay)
	}
}
