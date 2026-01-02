local webhookService = {}
local https = game:GetService("HttpService")

function webhookService:createMessage(url, message)
	local data = { ["content"] = message }
	local finalData = https:JSONEncode(data)
	https:PostAsync(url, finalData)
end

function webhookService:createEmbed(url, title, message, fields, image)
	local data = {
		content = "",
		embeds = { {
			image = { url = image },
			title = "**" .. title .. "**",
			description = message,
			type = "rich",
			color = tonumber(0xffffff),
			fields = fields,
		} },
	}
	https:PostAsync(url, https:JSONEncode(data))
end

function webhookService:createAuthorEmbed(url, authorName, iconurl, description, fields)
	local data = {
		embeds = { {
			author = {
				name = authorName,
				icon_url = iconurl,
			},
			description = description,
			color = tonumber(0xFFFAFA),
			fields = fields,
		} },
	}
	https:PostAsync(url, https:JSONEncode(data))
end

return webhookService
