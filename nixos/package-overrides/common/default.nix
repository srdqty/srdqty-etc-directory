pkgs: {
  icestorm = pkgs.icestorm.overrideAttrs (oldAttrs: rec {
    name = "icestorm-${version}";
    version = "2017.08.01";
    src = pkgs.fetchFromGitHub {
      owner = "cliffordwolf";
      repo = "icestorm";
      rev = "873eb9effaef6f97df24ca8d7b6eae3721303454";
      sha256 = "1ywyalqavlj3134xsa6p95xqmdgjw4ixndkxfp77yk3bfs04sxl7";
    };
  });

  arachne-pnr = pkgs.arachne-pnr.overrideAttrs (oldAttrs: rec {
    name = "arachne-pnr-${version}";
    version = "2017.06.29";
    src = pkgs.fetchFromGitHub {
      owner = "cseed";
      repo = "arachne-pnr";
      rev = "7e135edb31feacde85ec5b7e5c03fc9157080977";
      sha256 = "1wszcx6hgw4q4r778zswrlwdwvwxq834bkajck8w9yfqwxs9lmq8";
    };
  });

  yosys = pkgs.yosys.overrideAttrs (oldAttrs: rec {
    name = "yosys-${version}";
    version = "2017.08.14";
    src = pkgs.fetchFromGitHub {
      owner = "cliffordwolf";
      repo = "yosys";
      rev = "2cf0b5c1575b2ea4f8d949854eab7ab2bfdcd10e";
      sha256 = "00sfkq9z7g0ga5x3xphagyrvxrqafkd4429bx39lxwkm8l302w6h";
    };
  });

  youtube-dl = pkgs.youtube-dl.overrideAttrs (oldAttrs: rec {
    name = "youtube-dl-${version}";
    version = "2017.08.13";
    src = pkgs.fetchurl {
      url = "https://yt-dl.org/downloads/${version}/${name}.tar.gz";
      sha256 = "212c4e6a622d4e20ea888d1b1539ab063e171bed2a05c9e00db71ed53ab059dd";
    };
  });

  lastpass-cli = pkgs.lastpass-cli.overrideAttrs (oldAttrs: rec {
    version = "1.2.1";
    src = pkgs.fetchFromGitHub {
      owner = "lastpass";
      repo = "lastpass-cli";
      rev = "eda59f8b9a064c38b8a6d3093695ee0d29afe837";
      sha256 = "0nrsrd5cqyv2zydzzl1vryrnj1p0x17cx1rmrp4kmzh83bzgcfvv";
    };
  });

  img2txt = pkgs.callPackage ../../custom-packages/img2txt {
    inherit (pkgs) fetchFromGitHub licenses;
    inherit (pkgs.pythonPackages) buildPythonPackage docopt pillow;
  };

  aseprite = pkgs.callPackage ../../custom-packages/aseprite { };

  sql-workbench = pkgs.callPackage ../../custom-packages/sql-workbench {
    mysql-jdbc = pkgs.callPackage ../../custom-packages/mysql-jdbc { };
    postgresql-jdbc = pkgs.callPackage ../../custom-packages/postgresql-jdbc { };
    redshift-jdbc = pkgs.callPackage ../../custom-packages/redshift-jdbc { };

    inherit (pkgs) stdenv fetchurl jre unzip;
  };

  kubectl = pkgs.callPackage ../../custom-packages/kubectl { };

  docker-compose-1-14-0 = pkgs.docker_compose.overrideAttrs (oldAttrs: rec {
    name = "docker-compose-${version}";
    version = "1.14.0";
    src = pkgs.fetchurl {
      url = "mirror://pypi/d/docker-compose/${name}.tar.gz";
      sha256 = "0ybc4x7bydkp0fnnk3dw6gxcm4b91vgaprjliqlnc6ziym6i4jan";
    };
  });

  spotify = pkgs.spotify.overrideAttrs (oldAttrs: rec {
    name = "spotify-${version}";
    version = "1.0.70.399.g5ffabd56-26";
    src = pkgs.fetchurl {
      url = "https://repository-origin.spotify.com/pool/non-free/s/spotify-client/spotify-client_${version}_amd64.deb";
      sha256 = "0kpakz11xkyqqjvln4jkhc3z5my8zgpw8m6jx954cjdbc6vkxd29";
    };
  });

  slack = pkgs.slack.overrideAttrs (oldAttrs: rec {
    name = "slack-${version}";
    version = "3.0.2";
    src = pkgs.fetchurl {
      url = "https://downloads.slack-edge.com/linux_releases/slack-desktop-${version}-amd64.deb";
      sha256 = "1w3swb4zsvrbpr5jn6znwphhk4hian8d4m4746ilcly5k00bg0q5";
    };
  });

  weechat = pkgs.callPackage ../../custom-packages/weechat { };
}
