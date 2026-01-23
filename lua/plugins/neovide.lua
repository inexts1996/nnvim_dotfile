if not vim.g.neovide then
  return {} -- do nothing if not in a Neovide session
end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = { -- configure vim.opt options
        -- configure font
        guifont = "JetBrains Maple Mono:h13",
        -- line spacing
        linespace = 0,
      },
      g = { -- configure vim.g variables
        -- configure scaling
        neovide_scale_factor = 1.0,
        -- configure padding
        neovide_padding_top = 0,
        neovide_padding_bottom = 0,
        neovide_padding_right = 0,
        neovide_padding_left = 0,
        neovide_refresh_rate = 120,
        neovide_no_idle = true,
        --cursor动画时长
        neovide_cursor_animation_length = 0.10,
        neovide_cursor_antialiasing = true,
        neovide_cursor_animate_in_insert_mode = true,
        neovide_cursor_animate_command_line = true,
        neovide_cursor_smooth_blink = true,
        neovide_cursor_vfx_mode = "railgun", --"pixiedust",
        neovide_cursor_vfx_particle_lifetime = 0.5,
        neovide_cursor_vfx_particle_highlight_lifetime = 0.2,
        neovide_cursor_vfx_particle_density = 1,
        neovide_cursor_vfx_particle_speed = 10.0,
        neovide_cursor_vfx_particle_phase = 1.5,
        neovide_cursor_vfx_particle_curl = 1.0,
      },
    },
  },
}
