@tool
extends EditorPlugin

## Editor entry point for GameSpice Server Query. Registers inspector types only; no autoloads.

const _ICON := "res://addons/gs_server_query/icon_placeholder.svg"

const _TYPES := [
	["GSQueryHost", "Node", "res://addons/gs_server_query/host/gs_query_host.gd"],
	["GSQuerySource", "Node", "res://addons/gs_server_query/source/gs_query_source.gd"],
	["GSQueryServer", "Node", "res://addons/gs_server_query/dqp/gs_query_server.gd"],
	["GSA2SServer", "Node", "res://addons/gs_server_query/a2s/gs_a2s_server.gd"],
	["GSQueryStats", "Node", "res://addons/gs_server_query/stats/gs_query_stats.gd"],
]


func _enter_tree() -> void:
	var icon: Texture2D = null
	if ResourceLoader.exists(_ICON):
		icon = load(_ICON) as Texture2D

	for entry in _TYPES:
		add_custom_type(entry[0], entry[1], load(entry[2]), icon)


func _exit_tree() -> void:
	# Reversed so a type is never removed before something that referenced it,
	# which matters when the editor reloads the plugin.
	for i in range(_TYPES.size() - 1, -1, -1):
		remove_custom_type(_TYPES[i][0])
