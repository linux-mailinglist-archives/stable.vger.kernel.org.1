Return-Path: <stable+bounces-76707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E021A97BFAC
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 19:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E58283945
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 17:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F881C9ED4;
	Wed, 18 Sep 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eSW5p+Uc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B71C9EC3;
	Wed, 18 Sep 2024 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726680655; cv=none; b=cbhA5nwBN7fOI7GJivLEBoRiVhVU6wYLhGXdzbjL0rzksbRqE3DxDv7NxZCthMr0lR3klH8dKFVeK/Vs/mTQOxwOXKzG73EupfCgWgFXY+B7+/aDbWP19nZ5J+/3/UgVMy65BNp7m/7qMDaxyBEjOmdf6UE1tBFrfuIc9qCqCnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726680655; c=relaxed/simple;
	bh=lBGmtZvroZ4S7DeePHpYAbyztFJehrqSuT1c6z7AZmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a6RjnINM1d6bdPuptIEe09mrGg44g3iqHysWJJoaFnQ2po9jOielmk0N/eHFP9o/yTOe7IIj8khdU9qeCmTguslpv11x/xXozIMUOPLu0wdxfH056Q7tboZNQdsydQyPjz0Bz87gAgAEbMzq5p/yWjmrRE0hkRJJxTCN0OVrUvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eSW5p+Uc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA2BC4CEC2;
	Wed, 18 Sep 2024 17:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726680654;
	bh=lBGmtZvroZ4S7DeePHpYAbyztFJehrqSuT1c6z7AZmI=;
	h=From:To:Cc:Subject:Date:From;
	b=eSW5p+UcQ4zBdeHZ8bLEjIR95fYYt3TCFzY1oavqOMIuC7VOa4AZOcekBz0lxZ4UD
	 joQWcABw5xXyN9APC4yAcmGPJxnCkwabrCZydQ3dUij+Q4t5CO0PkSf5dJNbEqXN9N
	 R1Hwn3+R/jxmsLfjh3ty8FS6qfE8+F9pPl0wrvi0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.10.11
Date: Wed, 18 Sep 2024 19:30:50 +0200
Message-ID: <2024091849-crease-jovial-ff9d@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.10.11 kernel.

All users of the 6.10 kernel series must upgrade.

The updated 6.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/netlink/specs/mptcp_pm.yaml                   |    1 
 Makefile                                                    |    2 
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts           |    2 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi               |   36 ++
 arch/powerpc/kernel/setup-common.c                          |    1 
 arch/powerpc/mm/mem.c                                       |    2 
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi             |    6 
 arch/riscv/mm/cacheflush.c                                  |   12 
 arch/s390/Kconfig                                           |   13 +
 arch/s390/boot/startup.c                                    |    3 
 arch/x86/hyperv/hv_init.c                                   |    5 
 arch/x86/include/asm/mshyperv.h                             |    1 
 arch/x86/kernel/cpu/mshyperv.c                              |   20 +
 drivers/clk/sophgo/clk-cv18xx-ip.c                          |    2 
 drivers/clocksource/hyperv_timer.c                          |   16 +
 drivers/cxl/acpi.c                                          |   40 +++
 drivers/cxl/core/region.c                                   |   23 +
 drivers/cxl/cxl.h                                           |    3 
 drivers/cxl/cxlmem.h                                        |    2 
 drivers/dma-buf/heaps/cma_heap.c                            |    2 
 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c             |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h                     |    5 
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c                      |   76 ++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h                      |   11 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                      |   63 ++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h                      |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c                      |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c                      |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c                      |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h                      |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c                    |   57 ----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h                    |    7 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c                    |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c                    |    3 
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c     |   20 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c     |   20 -
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c |   55 +---
 drivers/gpu/drm/amd/include/atomfirmware.h                  |    4 
 drivers/gpu/drm/drm_panel_orientation_quirks.c              |   12 
 drivers/gpu/drm/drm_syncobj.c                               |   17 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c           |    4 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                      |    4 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                     |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ram.h                |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c           |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp102.c           |    1 
 drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h           |    2 
 drivers/gpu/drm/xe/xe_bo.c                                  |    6 
 drivers/gpu/drm/xe/xe_drm_client.c                          |   45 +++
 drivers/gpu/drm/xe/xe_gsc.c                                 |    4 
 drivers/gpu/drm/xe/xe_wa.c                                  |   10 
 drivers/hid/hid-asus.c                                      |    3 
 drivers/hid/hid-ids.h                                       |    3 
 drivers/hid/hid-multitouch.c                                |   33 ++
 drivers/hwmon/pmbus/pmbus.h                                 |    6 
 drivers/hwmon/pmbus/pmbus_core.c                            |   17 +
 drivers/input/mouse/synaptics.c                             |    1 
 drivers/input/serio/i8042-acpipnpio.h                       |    9 
 drivers/input/touchscreen/ads7846.c                         |    2 
 drivers/input/touchscreen/edt-ft5x06.c                      |    6 
 drivers/md/dm-integrity.c                                   |    4 
 drivers/misc/eeprom/digsy_mtc_eeprom.c                      |    2 
 drivers/net/dsa/ocelot/felix_vsc9959.c                      |   11 
 drivers/net/ethernet/faraday/ftgmac100.h                    |    2 
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c              |    9 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c     |    2 
 drivers/net/ethernet/intel/ice/ice_lib.c                    |   15 -
 drivers/net/ethernet/intel/ice/ice_switch.c                 |    4 
 drivers/net/ethernet/intel/igb/igb_main.c                   |   17 +
 drivers/net/ethernet/jme.c                                  |   10 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h             |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c         |   59 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c        |   10 
 drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c        |    4 
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c           |   51 ++--
 drivers/net/ethernet/mellanox/mlx5/core/main.c              |    1 
 drivers/net/ethernet/mellanox/mlx5/core/qos.c               |    7 
 drivers/net/ethernet/wangxun/libwx/wx_type.h                |    6 
 drivers/net/phy/dp83822.c                                   |   35 +-
 drivers/net/phy/vitesse.c                                   |   14 -
 drivers/net/usb/ipheth.c                                    |   18 -
 drivers/net/wireless/mediatek/mt76/mt7921/main.c            |    2 
 drivers/perf/riscv_pmu_sbi.c                                |    7 
 drivers/pinctrl/intel/pinctrl-meteorlake.c                  |    1 
 drivers/platform/surface/surface_aggregator_registry.c      |   58 ++++
 drivers/platform/x86/asus-wmi.c                             |   16 +
 drivers/platform/x86/panasonic-laptop.c                     |   58 +++-
 drivers/soundwire/stream.c                                  |    8 
 drivers/spi/spi-geni-qcom.c                                 |   17 -
 drivers/spi/spi-nxp-fspi.c                                  |    5 
 drivers/spi/spi-zynqmp-gqspi.c                              |   30 +-
 drivers/staging/media/atomisp/pci/sh_css_frac.h             |   26 +-
 drivers/usb/typec/ucsi/ucsi.c                               |   44 ++-
 drivers/usb/typec/ucsi/ucsi.h                               |    1 
 fs/bcachefs/extents.c                                       |   23 +
 fs/bcachefs/fs-io-buffered.c                                |  149 +++---------
 fs/bcachefs/fs.c                                            |    8 
 fs/bcachefs/fs.h                                            |    7 
 fs/bcachefs/fsck.c                                          |   18 +
 fs/btrfs/inode.c                                            |    1 
 fs/nfs/delegation.c                                         |   15 -
 fs/nfs/nfs4proc.c                                           |    9 
 fs/nfs/pnfs.c                                               |    5 
 fs/smb/client/cifsencrypt.c                                 |    2 
 fs/smb/server/mgmt/share_config.c                           |   15 -
 fs/smb/server/mgmt/share_config.h                           |    4 
 fs/smb/server/mgmt/tree_connect.c                           |    9 
 fs/smb/server/mgmt/tree_connect.h                           |    4 
 fs/smb/server/smb2pdu.c                                     |   11 
 fs/smb/server/smb_common.c                                  |    9 
 fs/smb/server/smb_common.h                                  |    2 
 include/linux/mlx5/mlx5_ifc.h                               |   12 
 include/linux/virtio_net.h                                  |    3 
 kernel/cgroup/cpuset.c                                      |   33 +-
 kernel/trace/trace_kprobe.c                                 |   25 +-
 kernel/trace/trace_osnoise.c                                |   10 
 mm/memory.c                                                 |   27 +-
 net/hsr/hsr_device.c                                        |   67 ++++-
 net/hsr/hsr_forward.c                                       |   37 ++
 net/hsr/hsr_framereg.c                                      |   12 
 net/hsr/hsr_framereg.h                                      |    2 
 net/hsr/hsr_main.h                                          |    4 
 net/hsr/hsr_netlink.c                                       |    1 
 net/ipv4/fou_core.c                                         |    4 
 net/mptcp/pm_netlink.c                                      |   13 -
 net/netfilter/nft_socket.c                                  |    7 
 scripts/kconfig/merge_config.sh                             |    2 
 sound/soc/codecs/peb2466.c                                  |    3 
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c           |    1 
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c           |    1 
 sound/soc/meson/axg-card.c                                  |    3 
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c     |    3 
 tools/testing/selftests/net/lib/csum.c                      |   16 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh             |    4 
 134 files changed, 1308 insertions(+), 550 deletions(-)

Alex Deucher (1):
      drm/amdgpu/atomfirmware: Silence UBSAN warning

Alexander Gordeev (1):
      s390/mm: Pin identity mapping base to zero

Alexandre Ghiti (1):
      drivers: perf: Fix smp_processor_id() use in preemptible code

Alison Schofield (1):
      cxl: Restore XOR'd position bits during address translation

Anders Roxell (1):
      scripts: kconfig: merge_config: config files: add a trailing newline

Andy Shevchenko (1):
      eeprom: digsy_mtc: Fix 93xx46 driver probe failure

AngeloGioacchino Del Regno (1):
      drm/mediatek: Set sensible cursor width/height values to fix crash

Anirudh Rayabharam (Microsoft) (1):
      x86/hyperv: fix kexec crash due to VP assist page corruption

Arseniy Krasnov (1):
      ASoC: meson: axg-card: fix 'use-after-free'

Asbjørn Sloth Tønnesen (1):
      netlink: specs: mptcp: fix port endianness

Bard Liao (2):
      ASoC: Intel: soc-acpi-intel-lnl-match: add missing empty item
      ASoC: Intel: soc-acpi-intel-mtl-match: add missing empty item

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

Charlie Jenkins (1):
      riscv: Disable preemption while handling PR_RISCV_CTX_SW_FENCEI_OFF

ChenXiaoSong (1):
      smb/server: fix return value of smb2_open()

Christophe Leroy (1):
      powerpc/mm: Fix boot warning with hugepages and CONFIG_DEBUG_VIRTUAL

Cosmin Ratiu (1):
      net/mlx5: Correct TASR typo into TSAR

Cruise (1):
      drm/amd/display: Disable error correction if it's not supported

Dan Carpenter (1):
      firmware: qcom: uefisecapp: Fix deadlock in qcuefi_acquire()

Daniele Ceraolo Spurio (2):
      drm/xe: fix WA 14018094691
      drm/xe: use devm instead of drmm for managed bo

David (Ming Qiang) Wu (2):
      drm/amd/amdgpu: apply command submission parser for JPEG v1
      drm/amd/amdgpu: apply command submission parser for JPEG v2+

David Howells (1):
      cifs: Fix signature miscalculation

Dexuan Cui (1):
      clocksource: hyper-v: Use lapic timer in a TDX VM without paravisor

Dmitry Savin (1):
      HID: multitouch: Add support for GT7868Q

Edward Adam Davis (1):
      mptcp: pm: Fix uaf in __timer_delete_sync

FUKAUMI Naoki (1):
      arm64: dts: rockchip: fix PMIC interrupt pin in pinctrl for ROCK Pi E

Felix Kaechele (1):
      Input: edt-ft5x06 - add support for FocalTech FT8201

Florian Westphal (1):
      netfilter: nft_socket: fix sk refcount leaks

Foster Snowhill (4):
      usbnet: ipheth: remove extraneous rx URB length check
      usbnet: ipheth: drop RX URBs with no payload
      usbnet: ipheth: do not stop RX on failing RX callback
      usbnet: ipheth: fix carrier detection in modes 1 and 4

Greg Kroah-Hartman (1):
      Linux 6.10.11

Han Xu (1):
      spi: nxp-fspi: fix the KASAN report out-of-bounds bug

Hans de Goede (2):
      platform/x86: panasonic-laptop: Fix SINF array out of bounds accesses
      platform/x86: panasonic-laptop: Allocate 1 entry extra in the sinf array

Heikki Krogerus (1):
      usb: typec: ucsi: Fix cable registration

Ilya Bakoulin (1):
      drm/amd/display: Fix FEC_READY write on DP LT

Jacky Chou (1):
      net: ftgmac100: Enable TX interrupt to avoid TX timeout

Jacob Keller (1):
      ice: fix accounting for filters shared by multiple VSIs

Jameson Thies (2):
      usb: typec: ucsi: Always set number of alternate modes
      usb: typec: ucsi: Only set number of plug altmodes after registration

Jani Nikula (1):
      drm/xe/display: fix compat IS_DISPLAY_STEP() range end

Jeff Layton (1):
      btrfs: update target inode's ctime on unlink

Jeongjun Park (1):
      net: hsr: prevent NULL pointer dereference in hsr_proxy_announce()

Jiawen Wu (1):
      net: libwx: fix number of Rx and Tx descriptors

Jinjie Ruan (2):
      spi: geni-qcom: Undo runtime PM changes at driver exit time
      spi: geni-qcom: Fix incorrect free_irq() sequence

Jonathan Denose (1):
      Input: synaptics - enable SMBus for HP Elitebook 840 G2

Kent Overstreet (3):
      bcachefs: Fix bch2_extents_match() false positive
      bcachefs: Revert lockless buffered IO path
      bcachefs: Don't delete open files in online fsck

Krzysztof Kozlowski (1):
      soundwire: stream: Revert "soundwire: stream: fix programming slave ports for non-continous port maps"

Li Qiang (1):
      clk/sophgo: Using BUG() instead of unreachable() in mmux_get_parent_id()

Linus Torvalds (1):
      mm: avoid leaving partial pfn mappings around in error case

Lorenzo Stoakes (1):
      minmax: reduce min/max macro expansion in atomisp driver

Lukasz Majewski (1):
      net: hsr: Send supervisory frames to HSR network with ProxyNodeTable data

Luke D. Jones (2):
      hid-asus: add ROG Ally X prod ID to quirk list
      platform/x86: asus-wmi: Add quirk for ROG Ally X

Maher Sanalla (1):
      net/mlx5: Update the list of the PCI supported devices

Marek Vasut (1):
      Input: ads7846 - ratelimit the spi_sync error message

Martyna Szapar-Mudlaw (1):
      ice: Fix lldp packets dropping after changing the number of channels

Masami Hiramatsu (Google) (1):
      tracing/kprobes: Fix build error when find_module() is not available

Matthew Auld (2):
      drm/xe/client: fix deadlock in show_meminfo()
      drm/xe/client: add missing bo locking in show_meminfo()

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: join: restrict fullmesh endp on 1st sf

Maximilian Luz (5):
      platform/surface: aggregator_registry: Add Support for Surface Pro 10
      platform/surface: aggregator_registry: Add support for Surface Laptop Go 3
      platform/surface: aggregator_registry: Add support for Surface Laptop Studio 2
      platform/surface: aggregator_registry: Add fan and thermal sensor support for Surface Laptop 5
      platform/surface: aggregator_registry: Add support for Surface Laptop 6

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

Ngai-Mint Kwan (1):
      drm/xe/xe2lpm: Extend Wa_16021639441

Nikita Zhandarovich (1):
      drm/i915/guc: prevent a possible int overflow in wq offsets

Patryk Biel (1):
      hwmon: (pmbus) Conditionally clear individual status bits for pmbus rev >= 1.2

Pawel Dembicki (1):
      net: phy: vitesse: repair vsc73xx autonegotiation

Peiyang Wang (1):
      net: hns3: use correct release function during uninitialization

Quentin Schulz (2):
      arm64: dts: rockchip: fix eMMC/SPI corruption when audio has been used on RK3399 Puma
      arm64: dts: rockchip: override BIOS_DISABLE signal via GPIO hog on RK3399 Puma

Rob Clark (1):
      drm/msm/adreno: Fix error return if missing firmware-name

Sean Anderson (3):
      spi: zynqmp-gqspi: Scale timeout by data size
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

Tobias Jakobi (2):
      drm/amd/display: Avoid race between dcn10_set_drr() and dc_state_destruct()
      drm/amd/display: Avoid race between dcn35_set_drr() and dc_state_destruct()

Tomas Paukrt (1):
      net: phy: dp83822: Fix NULL pointer dereference on DP83825 devices

Trond Myklebust (2):
      NFSv4: Fix clearing of layout segments in layoutreturn
      NFS: Avoid unnecessary rescanning of the per-server delegation list

Waiman Long (1):
      cgroup/cpuset: Eliminate unncessary sched domains rebuilds in hotplug

Willem de Bruijn (1):
      net: tighten bad gso csum offset check in virtio_net_hdr

Xiaoliang Yang (1):
      net: dsa: felix: ignore pending status of TAS module when it's disabled

Xingyu Wu (1):
      riscv: dts: starfive: jh7110-common: Fix lower rate of CPUfreq by setting PLL0 rate to 1.5GHz

Yinjie Yao (1):
      drm/amdgpu: Update kmd_fw_shared for VCN5

peng guo (1):
      cxl/core: Fix incorrect vendor debug UUID define


