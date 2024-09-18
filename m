Return-Path: <stable+bounces-76706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9581997BFA9
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 19:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BAA1F21933
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CD71C9EDD;
	Wed, 18 Sep 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MqRk9ole"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E51C9ED4;
	Wed, 18 Sep 2024 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726680644; cv=none; b=KfoC3q97PDkjp5ptdNjMKW1rh1cxQVyl6VnFxHwAuetk/TH8sdwBXjI7OR3g54Q7dWH6WJj+1SUHDSrM9wK6+/6QtftZrNw1muXwCNXLj2OXgAM1KKlNh6SmM0JQxvKpm4IxotT8skGmgIAOySSkSw9hegf1rLX+WGja1C1JXyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726680644; c=relaxed/simple;
	bh=FtirbeiRyVESyIjQ8au7Otmp0dRYc6ULqgCnbw+SCp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uMWuNZZzfN0JVkPDSqNPnw1hHZkaI8H6Yb0Rod3HqTI7MdZWV73JOtDMQiCrhAd9rS03i+mfFVW+vfCc7qwSruTum8tYB6PDiVx6AuWt3XpHhkpCCkMRb5b6VWcsbeQXdD4awL8S+Nv0Jb2oHhRSvOirOsNgy6QEqq7VoJBkxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MqRk9ole; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60330C4CEC2;
	Wed, 18 Sep 2024 17:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726680644;
	bh=FtirbeiRyVESyIjQ8au7Otmp0dRYc6ULqgCnbw+SCp8=;
	h=From:To:Cc:Subject:Date:From;
	b=MqRk9oleESFmiUaGTU9ZenV7Q5vwq8W9NOxusD2bMJRhNumq1HiB0dIF7DRrzKvIu
	 XLnGcIzaXARaHK+3QJ0GiU+Y0WS9U79JlVuDZhhL21eTfhzUxJoG68zqntf6/VuWZ/
	 65KKyWv5UaaF6dn30xYb4PTfEIhwDQw8XEvBFPoQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.52
Date: Wed, 18 Sep 2024 19:30:36 +0200
Message-ID: <2024091836-sash-buffing-6841@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.52 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts              |    2 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                  |   36 +++
 arch/powerpc/kernel/setup-common.c                             |    1 
 arch/powerpc/mm/mem.c                                          |    2 
 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi |    4 
 arch/x86/hyperv/hv_init.c                                      |    5 
 arch/x86/include/asm/mshyperv.h                                |    1 
 arch/x86/kernel/cpu/mshyperv.c                                 |    4 
 drivers/cxl/cxlmem.h                                           |    2 
 drivers/dma-buf/heaps/cma_heap.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c                         |   76 ++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h                         |   11 +
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c    |   55 ++----
 drivers/gpu/drm/amd/include/atomfirmware.h                     |    4 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                 |   12 +
 drivers/gpu/drm/drm_syncobj.c                                  |   17 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c              |    4 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                        |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ram.h                   |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c              |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp102.c              |    1 
 drivers/hid/hid-ids.h                                          |    2 
 drivers/hid/hid-multitouch.c                                   |   33 +++
 drivers/hwmon/pmbus/pmbus.h                                    |    6 
 drivers/hwmon/pmbus/pmbus_core.c                               |   17 +
 drivers/iio/adc/ad7124.c                                       |   58 ++----
 drivers/infiniband/hw/mlx5/main.c                              |    2 
 drivers/input/mouse/synaptics.c                                |    1 
 drivers/input/serio/i8042-acpipnpio.h                          |    9 
 drivers/input/touchscreen/ads7846.c                            |    2 
 drivers/md/dm-integrity.c                                      |    4 
 drivers/misc/eeprom/digsy_mtc_eeprom.c                         |    2 
 drivers/net/dsa/ocelot/felix_vsc9959.c                         |   11 -
 drivers/net/ethernet/faraday/ftgmac100.h                       |    2 
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                 |    9 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c        |    2 
 drivers/net/ethernet/intel/ice/ice_lib.c                       |   15 -
 drivers/net/ethernet/intel/ice/ice_switch.c                    |    4 
 drivers/net/ethernet/intel/igb/igb_main.c                      |   17 +
 drivers/net/ethernet/jme.c                                     |   10 -
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c            |   59 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c           |   10 +
 drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c           |    4 
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c              |   51 +++--
 drivers/net/ethernet/mellanox/mlx5/core/main.c                 |    1 
 drivers/net/ethernet/mellanox/mlx5/core/port.c                 |    2 
 drivers/net/ethernet/mellanox/mlx5/core/qos.c                  |    7 
 drivers/net/ethernet/xilinx/xilinx_axienet.h                   |    3 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c              |    8 
 drivers/net/phy/vitesse.c                                      |   14 -
 drivers/net/usb/ipheth.c                                       |   18 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c               |    2 
 drivers/nvmem/core.c                                           |   13 +
 drivers/nvmem/u-boot-env.c                                     |   91 +++++-----
 drivers/pinctrl/intel/pinctrl-meteorlake.c                     |    1 
 drivers/platform/surface/surface_aggregator_registry.c         |    8 
 drivers/platform/x86/panasonic-laptop.c                        |   58 +++++-
 drivers/soundwire/stream.c                                     |    8 
 drivers/spi/spi-geni-qcom.c                                    |   17 -
 drivers/spi/spi-nxp-fspi.c                                     |    5 
 drivers/staging/media/atomisp/pci/sh_css_frac.h                |   26 ++
 fs/btrfs/inode.c                                               |    1 
 fs/nfs/delegation.c                                            |   15 -
 fs/nfs/nfs4proc.c                                              |    9 
 fs/nfs/pnfs.c                                                  |    5 
 fs/smb/client/cifsencrypt.c                                    |    2 
 fs/smb/server/mgmt/share_config.c                              |   15 +
 fs/smb/server/mgmt/share_config.h                              |    4 
 fs/smb/server/mgmt/tree_connect.c                              |    9 
 fs/smb/server/mgmt/tree_connect.h                              |    4 
 fs/smb/server/smb2pdu.c                                        |   11 -
 fs/smb/server/smb_common.c                                     |    9 
 fs/smb/server/smb_common.h                                     |    2 
 include/linux/mlx5/mlx5_ifc.h                                  |   12 +
 include/linux/mlx5/port.h                                      |    2 
 include/linux/nvmem-consumer.h                                 |    1 
 include/linux/property.h                                       |    8 
 include/linux/virtio_net.h                                     |    3 
 kernel/trace/trace_osnoise.c                                   |   10 -
 mm/memory.c                                                    |   27 ++
 net/ipv4/fou_core.c                                            |    4 
 net/mptcp/pm_netlink.c                                         |   13 -
 net/netfilter/nft_socket.c                                     |    7 
 scripts/kconfig/merge_config.sh                                |    2 
 sound/soc/codecs/peb2466.c                                     |    3 
 sound/soc/meson/axg-card.c                                     |    3 
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c        |    3 
 tools/testing/selftests/net/csum.c                             |   16 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh                |    4 
 91 files changed, 741 insertions(+), 325 deletions(-)

Alex Deucher (1):
      drm/amdgpu/atomfirmware: Silence UBSAN warning

Anders Roxell (1):
      scripts: kconfig: merge_config: config files: add a trailing newline

Andy Shevchenko (1):
      eeprom: digsy_mtc: Fix 93xx46 driver probe failure

Anirudh Rayabharam (Microsoft) (1):
      x86/hyperv: fix kexec crash due to VP assist page corruption

Arseniy Krasnov (1):
      ASoC: meson: axg-card: fix 'use-after-free'

Ben Skeggs (1):
      drm/nouveau/fb: restore init() for ramgp102

Benjamin Poirier (1):
      net/mlx5: Fix bridge mode operations when there are no VFs

Bert Karwatzki (1):
      wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_change

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

Cruise (1):
      drm/amd/display: Disable error correction if it's not supported

David (Ming Qiang) Wu (1):
      drm/amd/amdgpu: apply command submission parser for JPEG v1

David Howells (1):
      cifs: Fix signature miscalculation

Dmitry Savin (1):
      HID: multitouch: Add support for GT7868Q

Dumitru Ceclan (1):
      iio: adc: ad7124: fix DT configuration parsing

Edward Adam Davis (1):
      mptcp: pm: Fix uaf in __timer_delete_sync

FUKAUMI Naoki (1):
      arm64: dts: rockchip: fix PMIC interrupt pin in pinctrl for ROCK Pi E

Florian Westphal (1):
      netfilter: nft_socket: fix sk refcount leaks

Foster Snowhill (4):
      usbnet: ipheth: remove extraneous rx URB length check
      usbnet: ipheth: drop RX URBs with no payload
      usbnet: ipheth: do not stop RX on failing RX callback
      usbnet: ipheth: fix carrier detection in modes 1 and 4

Greg Kroah-Hartman (1):
      Linux 6.6.52

Han Xu (1):
      spi: nxp-fspi: fix the KASAN report out-of-bounds bug

Hans de Goede (2):
      platform/x86: panasonic-laptop: Fix SINF array out of bounds accesses
      platform/x86: panasonic-laptop: Allocate 1 entry extra in the sinf array

Ilya Bakoulin (1):
      drm/amd/display: Fix FEC_READY write on DP LT

Jacky Chou (1):
      net: ftgmac100: Enable TX interrupt to avoid TX timeout

Jacob Keller (1):
      ice: fix accounting for filters shared by multiple VSIs

Jeff Layton (1):
      btrfs: update target inode's ctime on unlink

Jinjie Ruan (2):
      spi: geni-qcom: Undo runtime PM changes at driver exit time
      spi: geni-qcom: Fix incorrect free_irq() sequence

John Thomson (1):
      nvmem: u-boot-env: error if NVMEM device is too small

Jonathan Cameron (3):
      device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
      device property: Introduce device_for_each_child_node_scoped()
      iio: adc: ad7124: Switch from of specific to fwnode based property handling

Jonathan Denose (1):
      Input: synaptics - enable SMBus for HP Elitebook 840 G2

Krzysztof Kozlowski (1):
      soundwire: stream: Revert "soundwire: stream: fix programming slave ports for non-continous port maps"

Linus Torvalds (1):
      mm: avoid leaving partial pfn mappings around in error case

Lorenzo Stoakes (1):
      minmax: reduce min/max macro expansion in atomisp driver

Maher Sanalla (1):
      net/mlx5: Update the list of the PCI supported devices

Marek Vasut (1):
      Input: ads7846 - ratelimit the spi_sync error message

Martyna Szapar-Mudlaw (1):
      ice: Fix lldp packets dropping after changing the number of channels

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: join: restrict fullmesh endp on 1st sf

Maximilian Luz (2):
      platform/surface: aggregator_registry: Add Support for Surface Pro 10
      platform/surface: aggregator_registry: Add support for Surface Laptop Go 3

Michal Luczaj (1):
      selftests/bpf: Support SOCK_STREAM in unix_inet_redir_to_connected()

Michal Schmidt (1):
      ice: fix VSI lists confusion when adding VLANs

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

Naveen Mamindlapalli (1):
      octeontx2-af: Modify SMQ flush sequence to drop packets

Nikita Zhandarovich (1):
      drm/i915/guc: prevent a possible int overflow in wq offsets

Patrisious Haddad (1):
      IB/mlx5: Rename 400G_8X speed to comply to naming convention

Patryk Biel (1):
      hwmon: (pmbus) Conditionally clear individual status bits for pmbus rev >= 1.2

Pawel Dembicki (1):
      net: phy: vitesse: repair vsc73xx autonegotiation

Peiyang Wang (1):
      net: hns3: use correct release function during uninitialization

Quentin Schulz (2):
      arm64: dts: rockchip: fix eMMC/SPI corruption when audio has been used on RK3399 Puma
      arm64: dts: rockchip: override BIOS_DISABLE signal via GPIO hog on RK3399 Puma

Rafał Miłecki (4):
      nvmem: core: add nvmem_dev_size() helper
      nvmem: u-boot-env: use nvmem_add_one_cell() nvmem subsystem helper
      nvmem: u-boot-env: use nvmem device helpers
      nvmem: u-boot-env: improve coding style

Rob Clark (1):
      drm/msm/adreno: Fix error return if missing firmware-name

Sean Anderson (3):
      net: xilinx: axienet: Fix race in axienet_stop
      selftests: net: csum: Fix checksums for packets with non-zero padding
      net: dpaa: Pad packets to ETH_ZLEN

Shahar Shitrit (2):
      net/mlx5e: Add missing link modes to ptys2ethtool_map
      net/mlx5e: Add missing link mode to ptys2ext_ethtool_map

Sriram Yagnaraman (1):
      igb: Always call igb_xdp_ring_update_tail() under Tx lock

Steven Rostedt (1):
      tracing/osnoise: Fix build when timerlat is not enabled

Su Hui (1):
      ASoC: codecs: avoid possible garbage value in peb2466_reg_read()

T.J. Mercier (2):
      drm/syncobj: Fix syncobj leak in drm_syncobj_eventfd_ioctl
      dma-buf: heaps: Fix off-by-one in CMA heap fault handler

Takashi Iwai (1):
      Input: i8042 - add Fujitsu Lifebook E756 to i8042 quirk table

Trond Myklebust (2):
      NFSv4: Fix clearing of layout segments in layoutreturn
      NFS: Avoid unnecessary rescanning of the per-server delegation list

Willem de Bruijn (1):
      net: tighten bad gso csum offset check in virtio_net_hdr

William Qiu (1):
      riscv: dts: starfive: add assigned-clock* to limit frquency

Xiaoliang Yang (1):
      net: dsa: felix: ignore pending status of TAS module when it's disabled

peng guo (1):
      cxl/core: Fix incorrect vendor debug UUID define


