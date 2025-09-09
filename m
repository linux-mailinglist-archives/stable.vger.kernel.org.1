Return-Path: <stable+bounces-179119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B08B50416
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 19:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DBB4E4DC5
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846E6362988;
	Tue,  9 Sep 2025 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N41MA5IO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE0E35A2A8;
	Tue,  9 Sep 2025 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437872; cv=none; b=oUdSlOYtPihf4cp6jhxvBTt/obTTRtURSYmlgBSKdqR3qfi22S7cyXWdL/h8MctlqKpZcROFJBHsiXT1wa7cVkQm7DmCsqovS39MQZBq4cMFh8UE9C96mBenyP46pIQ88QJ1JlERaAvH9SjO6PtTywyIEL4QEwesq3AbeiQcD2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437872; c=relaxed/simple;
	bh=eCPBCZt9datIMaV+w8kAxQ1BGRLorKj9h8oCa+iCvqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jl7U2Mq/7xn2oYOquV3DdueId41hYWod25fxmqXyKkKo2RrWvwkE/25SMbMOvQnRonK9RxOqe7cEDlaTwYGo73AR0X8JjeP8SAThc2RkbxWDGFRr97EO0QXI65jt8BZtYWQdv0+oGuRG3bQNkfT4WOZnSBqjN7BPu+BeBOYMXWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N41MA5IO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6E4C4CEF4;
	Tue,  9 Sep 2025 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757437872;
	bh=eCPBCZt9datIMaV+w8kAxQ1BGRLorKj9h8oCa+iCvqs=;
	h=From:To:Cc:Subject:Date:From;
	b=N41MA5IOOpCWGwgrsXBFz7Rp3aiNBRkH8Hxcjs42MNSmyvbT+DtsYFFEPgzx0zX/s
	 CPi0OmXuUZlrxhGaE7mx5F8BQB7nUEBLpybIsaNj8u9mUh2EFzEop1IRJJNLAbHdyC
	 ckC/IovfIKUzv7+Mxrk+C3voheTv1qOmYMgqGABw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.105
Date: Tue,  9 Sep 2025 19:10:56 +0200
Message-ID: <2025090957-upfront-retention-259e@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.105 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/userspace-api/netlink/specs.rst               |   18 
 Makefile                                                    |    2 
 arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts |    1 
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi         |    1 
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts        |    1 
 arch/arm64/include/asm/module.h                             |    1 
 arch/arm64/include/asm/module.lds.h                         |    1 
 arch/arm64/kernel/ftrace.c                                  |   13 
 arch/arm64/kernel/module-plts.c                             |   12 
 arch/arm64/kernel/module.c                                  |   11 
 arch/loongarch/kernel/signal.c                              |   10 
 arch/riscv/include/asm/asm.h                                |    2 
 arch/x86/include/asm/pgtable_64_types.h                     |    3 
 arch/x86/mm/init_64.c                                       |   18 
 drivers/acpi/arm64/iort.c                                   |    4 
 drivers/bluetooth/hci_vhci.c                                |   57 -
 drivers/cpufreq/intel_pstate.c                              |  122 --
 drivers/dma/mediatek/mtk-cqdma.c                            |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                     |  146 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                      |    6 
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c                      |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c                      |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c                       |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c                       |    5 
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c       |    8 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                       |   11 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                      |   42 
 drivers/gpu/drm/mediatek/mtk_drm_drv.h                      |    8 
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c             |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c            |   23 
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c            |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h             |    2 
 drivers/hwmon/mlxreg-fan.c                                  |    5 
 drivers/iio/chemical/pms7003.c                              |    5 
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c                  |    2 
 drivers/iio/light/opt3001.c                                 |    5 
 drivers/iio/pressure/mprls0025pa.c                          |   10 
 drivers/isdn/mISDN/dsp_hwec.c                               |    6 
 drivers/net/ethernet/cadence/macb_main.c                    |   28 
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c           |   20 
 drivers/net/ethernet/intel/e1000e/ethtool.c                 |   10 
 drivers/net/ethernet/intel/i40e/i40e_client.c               |    4 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                 |   10 
 drivers/net/ethernet/xircom/xirc2ps_cs.c                    |    2 
 drivers/net/macsec.c                                        |    8 
 drivers/net/pcs/pcs-rzn1-miic.c                             |    2 
 drivers/net/phy/mscc/mscc_ptp.c                             |   18 
 drivers/net/ppp/ppp_generic.c                               |    6 
 drivers/net/usb/cdc_ncm.c                                   |    7 
 drivers/net/vmxnet3/vmxnet3_drv.c                           |    5 
 drivers/net/wireless/ath/ath11k/core.h                      |    7 
 drivers/net/wireless/ath/ath11k/debugfs.c                   |    4 
 drivers/net/wireless/ath/ath11k/debugfs_sta.c               |   30 
 drivers/net/wireless/ath/ath11k/dp_rx.c                     |    8 
 drivers/net/wireless/ath/ath11k/dp_tx.c                     |    4 
 drivers/net/wireless/ath/ath11k/mac.c                       |  588 ++++++------
 drivers/net/wireless/ath/ath11k/peer.c                      |    2 
 drivers/net/wireless/ath/ath11k/wmi.c                       |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c   |    6 
 drivers/net/wireless/marvell/libertas/cfg.c                 |    9 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c             |    5 
 drivers/net/wireless/marvell/mwifiex/main.c                 |    4 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c             |    4 
 drivers/net/wireless/st/cw1200/sta.c                        |    2 
 drivers/pci/msi/msi.c                                       |    3 
 drivers/pcmcia/omap_cf.c                                    |    2 
 drivers/pcmcia/rsrc_iodyn.c                                 |    3 
 drivers/pcmcia/rsrc_nonstatic.c                             |    4 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                   |   14 
 drivers/scsi/lpfc/lpfc_nvmet.c                              |   10 
 drivers/soc/qcom/mdt_loader.c                               |   12 
 drivers/spi/spi-cadence-quadspi.c                           |    6 
 drivers/spi/spi-fsl-lpspi.c                                 |   24 
 drivers/spi/spi-fsl-qspi.c                                  |   36 
 drivers/tee/optee/ffa_abi.c                                 |    4 
 drivers/tee/tee_shm.c                                       |    6 
 drivers/thermal/mediatek/lvts_thermal.c                     |   50 -
 fs/btrfs/btrfs_inode.h                                      |    2 
 fs/btrfs/extent_io.c                                        |    2 
 fs/btrfs/inode.c                                            |    1 
 fs/btrfs/tree-log.c                                         |   78 +
 fs/fs-writeback.c                                           |    9 
 fs/ocfs2/inode.c                                            |    3 
 fs/proc/generic.c                                           |   38 
 fs/smb/client/cifs_unicode.c                                |    3 
 include/linux/bpf-cgroup.h                                  |    5 
 include/linux/bpf.h                                         |   60 -
 include/linux/pci.h                                         |    2 
 include/linux/pgtable.h                                     |   16 
 include/linux/vmalloc.h                                     |   16 
 include/net/netlink.h                                       |   69 +
 include/uapi/linux/netlink.h                                |    5 
 kernel/bpf/core.c                                           |   50 -
 kernel/bpf/syscall.c                                        |   20 
 kernel/sched/topology.c                                     |    2 
 lib/nlattr.c                                                |   22 
 mm/slub.c                                                   |   66 -
 net/atm/resources.c                                         |    6 
 net/ax25/ax25_in.c                                          |    4 
 net/batman-adv/network-coding.c                             |    7 
 net/bluetooth/hci_sync.c                                    |    2 
 net/bluetooth/l2cap_sock.c                                  |    3 
 net/bridge/br_netfilter_hooks.c                             |    3 
 net/dsa/tag_ksz.c                                           |   22 
 net/ipv4/devinet.c                                          |    7 
 net/ipv4/icmp.c                                             |    6 
 net/ipv6/ip6_icmp.c                                         |    6 
 net/mctp/af_mctp.c                                          |    2 
 net/netfilter/nf_conntrack_helper.c                         |    4 
 net/netlink/policy.c                                        |   14 
 net/smc/smc_clc.c                                           |    2 
 net/smc/smc_ib.c                                            |    3 
 net/wireless/scan.c                                         |    3 
 net/wireless/sme.c                                          |    5 
 sound/pci/hda/patch_hdmi.c                                  |    1 
 sound/pci/hda/patch_realtek.c                               |    5 
 sound/usb/mixer_quirks.c                                    |    2 
 tools/gpio/Makefile                                         |    4 
 tools/perf/util/bpf-event.c                                 |   39 
 tools/power/cpupower/utils/cpupower-set.c                   |    4 
 tools/testing/selftests/net/bind_bhash.c                    |    4 
 121 files changed, 1354 insertions(+), 835 deletions(-)

Aaron Erhardt (1):
      ALSA: hda/realtek: Fix headset mic for TongFang X6[AF]R5xxY

Alex Deucher (2):
      drm/amdgpu: drop hw access in non-DC audio fini
      Revert "drm/amdgpu: Avoid extra evict-restore process."

Alok Tiwari (2):
      xirc2ps_cs: fix register access when enabling FullDuplex
      mctp: return -ENOPROTOOPT for unknown getsockopt options

Baochen Qiang (2):
      wifi: ath11k: rename ath11k_start_vdev_delay()
      wifi: ath11k: avoid forward declaration of ath11k_mac_start_vdev_delay()

Bjorn Andersson (1):
      soc: qcom: mdt_loader: Deal with zero e_shentsize

Chen Ni (1):
      pcmcia: omap: Add missing check for platform_get_resource

Chengming Zhou (1):
      slub: Reflow ___slab_alloc()

Chris Chiu (1):
      ALSA: hda/realtek - Add new HP ZBook laptop with micmute led fixup

Christian Loehle (1):
      sched: Fix sched_numa_find_nth_cpu() if mask offline

Christoffer Sandberg (1):
      platform/x86/amd/pmc: Add TUXEDO IB Pro Gen10 AMD to spurious 8042 quirks list

Colin Ian King (1):
      drm/amd/amdgpu: Fix missing error return on kzalloc failure

Cryolitia PukNgae (1):
      ALSA: usb-audio: Add mute TLV for playback volumes on some devices

Dan Carpenter (4):
      wifi: cw1200: cap SSID length in cw1200_do_join()
      wifi: libertas: cap SSID len in lbs_associate()
      wifi: cfg80211: sme: cap SSID length in __cfg80211_connect_result()
      ipv4: Fix NULL vs error pointer check in inet_blackhole_dev_init()

Daniel Borkmann (4):
      bpf: Add cookie object to bpf maps
      bpf: Move cgroup iterator helpers to bpf.h
      bpf: Move bpf map owner out of common struct
      bpf: Fix oob access in cgroup local storage

Dave Airlie (1):
      nouveau: fix disabling the nonstall irq due to storm code

David Lechner (3):
      iio: imu: inv_mpu6050: align buffer for timestamp
      iio: chemical: pms7003: use aligned_s64 for timestamp
      iio: pressure: mprls0025pa: use aligned_s64 for timestamp

Dmitry Antipov (1):
      wifi: cfg80211: fix use-after-free in cmp_bss()

Duoming Zhou (1):
      wifi: brcmfmac: fix use-after-free when rescheduling brcmf_btcoex_info work

Edward Adam Davis (1):
      ocfs2: prevent release journal inode after journal shutdown

Eric Dumazet (1):
      ax25: properly unshare skbs in ax25_kiss_rcv()

Fabian Bläse (1):
      icmp: fix icmp_ndo_send address translation for reply direction

Felix Fietkau (1):
      net: ethernet: mtk_eth_soc: fix tx vlan tag for llc packets

Filipe Manana (3):
      btrfs: fix race between logging inode and checking if it was logged before
      btrfs: fix race between setting last_dir_index_offset and inode logging
      btrfs: avoid load/store tearing races when checking if an inode was logged

Greg Kroah-Hartman (1):
      Linux 6.6.105

Han Xu (1):
      spi: fsl-qspi: use devm function instead of driver remove

Harry Yoo (2):
      x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings()
      mm: move page table sync declarations to linux/pgtable.h

Hawking Zhang (1):
      drm/amdgpu: Replace DRM_* with dev_* in amdgpu_psp.c

Horatiu Vultur (1):
      phy: mscc: Stop taking ts_lock for tx_queue and use its own lock

Huacai Chen (1):
      LoongArch: Save LBT before FPU in setup_sigcontext()

Ian Rogers (1):
      perf bpf-event: Fix use-after-free in synthesis

Ivan Pravdin (1):
      Bluetooth: vhci: Prevent use-after-free by removing debugfs files early

Jakob Unterwurzacher (1):
      net: dsa: microchip: linearize skb for tail-tagging switches

Jakub Kicinski (1):
      netlink: add variable-length / auto integers

Jason-JH.Lin (2):
      drm/mediatek: Add crtc path enum for all_drm_priv array
      drm/mediatek: Fix using wrong drm private data to bind mediatek-drm

Jeff Johnson (1):
      wifi: ath11k: Introduce and use ath11k_sta_to_arsta()

Jinfeng Wang (2):
      Revert "spi: cadence-quadspi: fix cleanup of rx_chan on failure paths"
      Revert "spi: spi-cadence-quadspi: Fix pm runtime unbalance"

Jiufei Xue (1):
      fs: writeback: fix use-after-free in __mark_inode_dirty()

John Evans (1):
      scsi: lpfc: Fix buffer free/clear order in deferred receive path

Jonathan Currier (1):
      PCI/MSI: Add an option to write MSIX ENTRY_DATA before any reads

Josef Bacik (1):
      btrfs: adjust subpage bit start based on sectorsize

Kevin Hao (1):
      spi: fsl-qspi: Fix double cleanup in probe error path

Kuniyuki Iwashima (2):
      Bluetooth: Fix use-after-free in l2cap_sock_cleanup_listen()
      selftest: net: Fix weird setsockopt() in bind_bhash.c.

Lad Prabhakar (1):
      net: pcs: rzn1-miic: Correct MODCTRL register offset

Larisa Grigore (4):
      spi: spi-fsl-lpspi: Fix transmissions when using CONT
      spi: spi-fsl-lpspi: Set correct chip-select polarity bit
      spi: spi-fsl-lpspi: Reset FIFO and disable module on transfer abort
      spi: spi-fsl-lpspi: Clear status register after disabling the module

Li Qiong (1):
      mm/slub: avoid accessing metadata when pointer is invalid in object_err()

Liu Jian (1):
      net/smc: fix one NULL pointer dereference in smc_ib_is_sg_need_sync()

Lubomir Rintel (1):
      cdc_ncm: Flag Intel OEM version of Fibocom L850-GL as WWAN

Luca Ceresoli (1):
      iio: light: opt3001: fix deadlock due to concurrent flag access

Ma Ke (2):
      pcmcia: Fix a NULL pointer dereference in __iodyn_find_io_region()
      drm/mediatek: Fix device/node reference count leaks in mtk_drm_get_all_drm_priv

Mahanta Jambigi (1):
      net/smc: Remove validation of reserved bits in CLC Decline message

Makar Semyonov (1):
      cifs: prevent NULL pointer dereference in UTF16 conversion

Marek Vasut (2):
      arm64: dts: imx8mp: Fix missing microSD slot vqmmc on DH electronics i.MX8M Plus DHCOM
      arm64: dts: imx8mp: Fix missing microSD slot vqmmc on Data Modul i.MX8M Plus eDM SBC

Miaoqian Lin (2):
      mISDN: Fix memory leak in dsp_hwec_enable()
      ACPI/IORT: Fix memory leak in iort_rmr_alloc_sids()

Michael Walle (1):
      drm/bridge: ti-sn65dsi86: fix REFCLK setting

Nathan Chancellor (1):
      wifi: mt76: mt7996: Initialize hdr before passing to skb_put_data()

Nícolas F. R. A. Prado (1):
      thermal/drivers/mediatek/lvts: Disable low offset IRQ for minimum threshold

Pei Xiao (1):
      tee: fix NULL pointer dereference in tee_shm_put

Peter Robinson (1):
      arm64: dts: rockchip: Add vcc-supply to SPI flash on rk3399-pinebook-pro

Phil Sutter (1):
      netfilter: conntrack: helper: Replace -EEXIST by -EBUSY

Pieter Van Trappen (1):
      net: dsa: microchip: update tag_ksz masks for KSZ9477 family

Qianfeng Rong (1):
      wifi: mwifiex: Initialize the chan_stats array to zero

Qingfang Deng (1):
      ppp: fix memory leak in pad_compress_skb

Qiu-ji Chen (2):
      dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()
      dmaengine: mediatek: Fix a flag reuse error in mtk_cqdma_tx_status()

Radim Krčmář (1):
      riscv: use lw when reading int cpu in asm_per_cpu

Rafael J. Wysocki (5):
      cpufreq: intel_pstate: Fold intel_pstate_max_within_limits() into caller
      cpufreq: intel_pstate: Do not update global.turbo_disabled after initialization
      cpufreq: intel_pstate: Rearrange show_no_turbo() and store_no_turbo()
      cpufreq: intel_pstate: Read global.no_turbo under READ_ONCE()
      cpufreq: intel_pstate: Check turbo_is_disabled() in store_no_turbo()

Rameshkumar Sundaram (1):
      wifi: ath11k: fix group data packet drops during rekey

Ronak Doshi (1):
      vmxnet3: update MTU after device quiesce

Rosen Penev (2):
      net: thunder_bgx: add a missing of_node_put
      net: thunder_bgx: decrement cleanup index before use

Sabrina Dubroca (1):
      macsec: read MACSEC_SA_ATTR_PN with nla_get_uint

Sean Anderson (1):
      net: macb: Fix tx_ptr_lock locking

Shinji Nomoto (1):
      cpupower: Fix a bug where the -t option of the set subcommand was not working.

Srinivas Pandruvada (2):
      cpufreq: intel_pstate: Revise global turbo disable check
      cpufreq: intel_pstate: Unchecked MSR aceess in legacy mode

Stanislav Fort (1):
      batman-adv: fix OOB read/write in network-coding decode

Stefan Binding (1):
      ALSA: hda/realtek: Add support for HP Agusta using CS35L41 HDA

Sungbae Yoo (1):
      tee: optee: ffa: fix a typo of "optee_ffa_api_is_compatible"

Takashi Iwai (1):
      ALSA: hda/hdmi: Add pin fix for another HP EliteDesk 800 G4 model

Timur Kristóf (1):
      drm/amd/display: Don't warn when missing DCE encoder caps

Vadim Pasternak (1):
      hwmon: mlxreg-fan: Prevent fans from getting stuck at 0 RPM

Vitaly Lifshits (1):
      e1000e: fix heap overflow in e1000_set_eeprom

Wang Liang (2):
      netfilter: br_netfilter: do not check confirmed bit in br_nf_local_in() after confirm
      net: atm: fix memory leak in atm_register_sysfs when device_register fail

Wentao Liang (1):
      pcmcia: Add error handling for add_interval() in do_validate_mem()

Yang Li (1):
      Bluetooth: hci_sync: Avoid adding default advertising on startup

Zhen Ni (1):
      i40e: Fix potential invalid access when MAC list is empty

panfan (1):
      arm64: ftrace: fix unreachable PLT for ftrace_caller in init_module with CONFIG_DYNAMIC_FTRACE

wangzijie (1):
      proc: fix missing pde_set_flags() for net proc files

yangshiguang (1):
      mm: slub: avoid wake up kswapd in set_track_prepare

zhang jiao (1):
      tools: gpio: remove the include directory on make clean

zhangjiao (1):
      tools: gpio: rm .*.cmd on make clean


