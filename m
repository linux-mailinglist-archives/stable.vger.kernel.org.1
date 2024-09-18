Return-Path: <stable+bounces-76704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5812497BFA5
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 19:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDE01F21978
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 17:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5201C9DFA;
	Wed, 18 Sep 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TUP4oIQL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3E1C9DE0;
	Wed, 18 Sep 2024 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726680636; cv=none; b=pkg3dMUFZFvQVacQFwWmUKP0WCWDQLghhvnbVPGvxYftkcQCWkWh8zURS3biXL3e9rZgTWPu1H2S+UDZBmGt+HmV/BNa/b4Mz7YVCeHkNQaK0B7LNCwVwuF/j3Ursn5dr/OAMcV8x4eK7VEuuS2A5320R7pOVdK82nqoW6LPT/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726680636; c=relaxed/simple;
	bh=fA3ZSiFo1SRMEIueCzQyAmiEZMkdgPJJVFGZ2qAQdm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MZ/Og2Tu1cHNrSEnasbh9z/IYEtZkOxUEmhJwtz51CNgnVBEYGNikOh7w8cvX/eLauS+/nlbADm9n5Mjm9R7NZtEptqt1FGq2voByaU5gR5DkNraoq0bB4o0RiqT63vVZJtkztLrEr1DFcseyNNrN26nvSXQOSMBQM0vUawlAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TUP4oIQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13985C4CEC2;
	Wed, 18 Sep 2024 17:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726680634;
	bh=fA3ZSiFo1SRMEIueCzQyAmiEZMkdgPJJVFGZ2qAQdm4=;
	h=From:To:Cc:Subject:Date:From;
	b=TUP4oIQLO7dxg84ErqWtMcK1VBPTnwB+n/R7d22CgvtHfntwds81/FJMYsKcjkUAm
	 UNyk5XrxD6R6SDICWldPnS6+AUxXCpkgZsEkdW6mpq8fZBs5njupsIV28QpFC+uCfQ
	 R46dtwzHS8gD2/lvzhNAS6TqfMt618jKzhc/h3cQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.111
Date: Wed, 18 Sep 2024 19:30:26 +0200
Message-ID: <2024091826-cardinal-squealing-4c71@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.111 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                |    2 
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts       |    2 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi           |   36 ++-
 arch/powerpc/kernel/setup-common.c                      |    1 
 arch/powerpc/mm/mem.c                                   |    2 
 drivers/cxl/cxlmem.h                                    |    2 
 drivers/dma-buf/heaps/cma_heap.c                        |    2 
 drivers/gpu/drm/amd/include/atomfirmware.h              |    4 
 drivers/gpu/drm/drm_panel_orientation_quirks.c          |   12 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c       |    4 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                 |    2 
 drivers/hid/hid-ids.h                                   |    2 
 drivers/hid/hid-multitouch.c                            |   33 ++
 drivers/hwmon/pmbus/pmbus.h                             |    6 
 drivers/hwmon/pmbus/pmbus_core.c                        |   17 +
 drivers/input/mouse/synaptics.c                         |    1 
 drivers/input/serio/i8042-acpipnpio.h                   |    9 
 drivers/input/touchscreen/ads7846.c                     |    2 
 drivers/md/dm-integrity.c                               |    4 
 drivers/misc/eeprom/digsy_mtc_eeprom.c                  |    2 
 drivers/net/ethernet/faraday/ftgmac100.h                |    2 
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c          |    9 
 drivers/net/ethernet/intel/ice/ice_switch.c             |    2 
 drivers/net/ethernet/intel/igb/igb_main.c               |   17 +
 drivers/net/ethernet/jme.c                              |   10 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h         |   15 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c     |  177 +++++++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c    |    4 
 drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c    |    4 
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c       |   51 ++--
 drivers/net/ethernet/mellanox/mlx5/core/main.c          |    1 
 drivers/net/ethernet/mellanox/mlx5/core/qos.c           |    7 
 drivers/net/ethernet/xilinx/xilinx_axienet.h            |    3 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c       |    8 
 drivers/net/phy/vitesse.c                               |   14 -
 drivers/net/usb/ipheth.c                                |    5 
 drivers/pinctrl/intel/pinctrl-meteorlake.c              |    1 
 drivers/platform/surface/surface_aggregator_registry.c  |    8 
 drivers/platform/x86/panasonic-laptop.c                 |   58 ++++-
 drivers/soc/ti/omap_prm.c                               |    2 
 drivers/soundwire/stream.c                              |    8 
 drivers/spi/spi-geni-qcom.c                             |   22 -
 drivers/spi/spi-nxp-fspi.c                              |    5 
 drivers/staging/media/atomisp/pci/sh_css_frac.h         |   26 +-
 fs/btrfs/inode.c                                        |    1 
 fs/nfs/delegation.c                                     |   15 -
 fs/nfs/nfs4proc.c                                       |    9 
 fs/nfs/pnfs.c                                           |    5 
 fs/ntfs3/attrlist.c                                     |    4 
 fs/ntfs3/bitmap.c                                       |    4 
 fs/ntfs3/frecord.c                                      |    4 
 fs/ntfs3/super.c                                        |    2 
 fs/smb/server/mgmt/share_config.c                       |   15 +
 fs/smb/server/mgmt/share_config.h                       |    4 
 fs/smb/server/mgmt/tree_connect.c                       |    9 
 fs/smb/server/mgmt/tree_connect.h                       |    4 
 fs/smb/server/smb2pdu.c                                 |   11 
 fs/smb/server/smb_common.c                              |    9 
 fs/smb/server/smb_common.h                              |    2 
 include/linux/mlx5/mlx5_ifc.h                           |   12 -
 include/linux/virtio_net.h                              |    3 
 mm/memory.c                                             |   27 +-
 net/ipv4/fou.c                                          |    4 
 net/mptcp/pm_netlink.c                                  |   13 -
 net/netfilter/nft_socket.c                              |    7 
 scripts/kconfig/merge_config.sh                         |    2 
 sound/soc/meson/axg-card.c                              |    3 
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c |    3 
 68 files changed, 603 insertions(+), 173 deletions(-)

Alex Deucher (1):
      drm/amdgpu/atomfirmware: Silence UBSAN warning

Anders Roxell (1):
      scripts: kconfig: merge_config: config files: add a trailing newline

Andy Shevchenko (1):
      eeprom: digsy_mtc: Fix 93xx46 driver probe failure

Arseniy Krasnov (1):
      ASoC: meson: axg-card: fix 'use-after-free'

Benjamin Poirier (1):
      net/mlx5: Fix bridge mode operations when there are no VFs

Bouke Sybren Haarsma (2):
      drm: panel-orientation-quirks: Add quirk for Ayn Loki Zero
      drm: panel-orientation-quirks: Add quirk for Ayn Loki Max

Carolina Jubran (3):
      net/mlx5: Explicitly set scheduling element and TSAR type
      net/mlx5: Add missing masks and QoS bit masks for scheduling elements
      net/mlx5: Verify support for scheduling element and TSAR type

ChenXiaoSong (1):
      smb/server: fix return value of smb2_open()

Christophe Leroy (1):
      powerpc/mm: Fix boot warning with hugepages and CONFIG_DEBUG_VIRTUAL

Cosmin Ratiu (1):
      net/mlx5: Correct TASR typo into TSAR

Dmitry Savin (1):
      HID: multitouch: Add support for GT7868Q

Edward Adam Davis (1):
      mptcp: pm: Fix uaf in __timer_delete_sync

FUKAUMI Naoki (1):
      arm64: dts: rockchip: fix PMIC interrupt pin in pinctrl for ROCK Pi E

Florian Westphal (1):
      netfilter: nft_socket: fix sk refcount leaks

Foster Snowhill (1):
      usbnet: ipheth: fix carrier detection in modes 1 and 4

Greg Kroah-Hartman (1):
      Linux 6.1.111

Han Xu (1):
      spi: nxp-fspi: fix the KASAN report out-of-bounds bug

Hans de Goede (2):
      platform/x86: panasonic-laptop: Fix SINF array out of bounds accesses
      platform/x86: panasonic-laptop: Allocate 1 entry extra in the sinf array

Jacky Chou (1):
      net: ftgmac100: Enable TX interrupt to avoid TX timeout

Jacob Keller (1):
      ice: fix accounting for filters shared by multiple VSIs

Jeff Layton (1):
      btrfs: update target inode's ctime on unlink

Jinjie Ruan (2):
      spi: geni-qcom: Undo runtime PM changes at driver exit time
      spi: geni-qcom: Fix incorrect free_irq() sequence

Jonathan Denose (1):
      Input: synaptics - enable SMBus for HP Elitebook 840 G2

Konstantin Komarov (1):
      fs/ntfs3: Use kvfree to free memory allocated by kvmalloc

Krzysztof Kozlowski (1):
      soundwire: stream: Revert "soundwire: stream: fix programming slave ports for non-continous port maps"

Kunwu Chan (1):
      pmdomain: ti: Add a null pointer check to the omap_prm_domain_init

Linus Torvalds (1):
      mm: avoid leaving partial pfn mappings around in error case

Lorenzo Stoakes (1):
      minmax: reduce min/max macro expansion in atomisp driver

Maher Sanalla (1):
      net/mlx5: Update the list of the PCI supported devices

Marek Vasut (1):
      Input: ads7846 - ratelimit the spi_sync error message

Maximilian Luz (2):
      platform/surface: aggregator_registry: Add Support for Surface Pro 10
      platform/surface: aggregator_registry: Add support for Surface Laptop Go 3

Michal Luczaj (1):
      selftests/bpf: Support SOCK_STREAM in unix_inet_redir_to_connected()

Mika Westerberg (1):
      pinctrl: meteorlake: Add Arrow Lake-H/U ACPI ID

Mikulas Patocka (1):
      dm-integrity: fix a race condition when accessing recalc_sector

Moon Yeounsu (1):
      net: ethernet: use ip_hdrlen() instead of bit shift

Muhammad Usama Anjum (1):
      fou: fix initialization of grc

Namjae Jeon (2):
      ksmbd: override fsids for share path check
      ksmbd: override fsids for smb2_query_info()

Naveen Mamindlapalli (2):
      octeontx2-af: Set XOFF on other child transmit schedulers during SMQ flush
      octeontx2-af: Modify SMQ flush sequence to drop packets

Nikita Zhandarovich (1):
      drm/i915/guc: prevent a possible int overflow in wq offsets

Patryk Biel (1):
      hwmon: (pmbus) Conditionally clear individual status bits for pmbus rev >= 1.2

Pawel Dembicki (1):
      net: phy: vitesse: repair vsc73xx autonegotiation

Quentin Schulz (2):
      arm64: dts: rockchip: fix eMMC/SPI corruption when audio has been used on RK3399 Puma
      arm64: dts: rockchip: override BIOS_DISABLE signal via GPIO hog on RK3399 Puma

Rob Clark (1):
      drm/msm/adreno: Fix error return if missing firmware-name

Sean Anderson (2):
      net: xilinx: axienet: Fix race in axienet_stop
      net: dpaa: Pad packets to ETH_ZLEN

Shahar Shitrit (1):
      net/mlx5e: Add missing link modes to ptys2ethtool_map

Sriram Yagnaraman (1):
      igb: Always call igb_xdp_ring_update_tail() under Tx lock

T.J. Mercier (1):
      dma-buf: heaps: Fix off-by-one in CMA heap fault handler

Takashi Iwai (1):
      Input: i8042 - add Fujitsu Lifebook E756 to i8042 quirk table

Trond Myklebust (2):
      NFSv4: Fix clearing of layout segments in layoutreturn
      NFS: Avoid unnecessary rescanning of the per-server delegation list

Uwe Kleine-König (1):
      spi: geni-qcom: Convert to platform remove callback returning void

Willem de Bruijn (1):
      net: tighten bad gso csum offset check in virtio_net_hdr

peng guo (1):
      cxl/core: Fix incorrect vendor debug UUID define


