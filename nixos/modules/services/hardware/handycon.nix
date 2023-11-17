{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.services.handycon;
in {
  options.services.handycon = {
    enable = mkEnableOption "Enable handycon service";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.handycon];

    systemd.services.handycon = {
      description = "HandyGCCS";

      wantedBy = ["multi-user.target"];

      restartIfChanged = true;

      serviceConfig = {
        DynamicUser = true;
        ExecStart = "${pkgs.handycon}/bin/handycon";
        Restart = "always";
      };
    };
  };

  meta.maintainers = [maintainers.appsforartists];
}
