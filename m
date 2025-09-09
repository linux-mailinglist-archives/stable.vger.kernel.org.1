Return-Path: <stable+bounces-179120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE34B5041E
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 19:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69071692E6
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37683629A6;
	Tue,  9 Sep 2025 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BQRpwojj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1B636299F;
	Tue,  9 Sep 2025 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437876; cv=none; b=AzipBhfiXpZWnHnJRtdKmPHYzKvGzAFWf4TCKylGrcuCfcUGfY2MF7qtZS6KGh6l4qPVqWU4mErUVviXeRrnb+Xqjf8oIIOL3Spq7TyI8G3GDv8mtk0KIF1FzrICcuaBUXwVIM37Y1xxmFe30VXSNfg+YUehf8UI0xTSppgtz1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437876; c=relaxed/simple;
	bh=zsjBiLw6Bnt6AEvJiY6IISJnlUJCATnzHCIbg9aJ50M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gh5L0nQ33ocmeP8p/l19dQ1U7Cb4LXeIi7vyT8yXgu6Sba4nmtG5ih1LtMmjphXhYmHekzFki5omUqrYSF9+bMhC2mNVM3Ld8R5D3F7w5bcce5B6yh+hxZEhnQ0Dlw7aDWcU+if0QwDBRzRccdVUQ/UEyGsiPvjX6ILJ8RUnqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BQRpwojj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83796C4CEF9;
	Tue,  9 Sep 2025 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757437875;
	bh=zsjBiLw6Bnt6AEvJiY6IISJnlUJCATnzHCIbg9aJ50M=;
	h=From:To:Cc:Subject:Date:From;
	b=BQRpwojj6UdggnkYKW7/eli9++xWGJs11BvFbeDsHBTWh/dRCBF0en+nT+SvZm432
	 x1JCNHZaGnWg6V+lnFG1xaa0DGAC1izNKe7r3kNr7q43H0EiHXbT2rXfWynmvV/Rym
	 DB4TqzMxibws/h0ghndDzXf2mfY4+rr4qglArLD4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.46
Date: Tue,  9 Sep 2025 19:11:03 +0200
Message-ID: <2025090904-culminate-fraternal-7edf@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.46 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                         |    2 
 arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts      |    1 
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi              |    1 
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314.dts |   13 
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts      |   13 
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi              |   22 +
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts             |    1 
 arch/arm64/include/asm/module.h                                  |    1 
 arch/arm64/include/asm/module.lds.h                              |    1 
 arch/arm64/kernel/ftrace.c                                       |   13 
 arch/arm64/kernel/module-plts.c                                  |   12 
 arch/arm64/kernel/module.c                                       |   11 
 arch/loongarch/kernel/signal.c                                   |   10 
 arch/loongarch/vdso/Makefile                                     |    3 
 arch/riscv/Kconfig                                               |    2 
 arch/riscv/include/asm/asm.h                                     |    2 
 arch/riscv/kernel/entry.S                                        |    2 
 arch/riscv/net/bpf_jit_comp64.c                                  |    4 
 arch/x86/include/asm/pgtable_64_types.h                          |    3 
 arch/x86/mm/init_64.c                                            |   18 +
 block/blk-integrity.c                                            |    4 
 block/blk-settings.c                                             |   24 +
 block/blk-zoned.c                                                |    7 
 drivers/accel/ivpu/ivpu_drv.c                                    |    2 
 drivers/accel/ivpu/ivpu_pm.c                                     |    4 
 drivers/accel/ivpu/ivpu_pm.h                                     |    2 
 drivers/acpi/arm64/iort.c                                        |    4 
 drivers/acpi/riscv/cppc.c                                        |    4 
 drivers/block/virtio_blk.c                                       |    4 
 drivers/bluetooth/hci_vhci.c                                     |   57 ++--
 drivers/dma/mediatek/mtk-cqdma.c                                 |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                           |    6 
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c                           |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c                           |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c                            |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c                            |    5 
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c            |    8 
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c             |    9 
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h             |    2 
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c             |    1 
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c        |   72 +++++
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h        |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c         |    1 
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h                      |    3 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                            |   11 
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c                  |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c                 |   23 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c                 |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h                  |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/r535.c                  |    1 
 drivers/hid/hid-core.c                                           |   74 ++---
 drivers/hid/hid-logitech-hidpp.c                                 |    6 
 drivers/hwmon/mlxreg-fan.c                                       |    5 
 drivers/isdn/mISDN/dsp_hwec.c                                    |    6 
 drivers/md/md-bitmap.c                                           |    6 
 drivers/md/md.c                                                  |    5 
 drivers/md/raid1-10.c                                            |   10 
 drivers/md/raid1.c                                               |   28 -
 drivers/md/raid10.c                                              |   20 -
 drivers/mmc/host/sdhci-of-arasan.c                               |   51 +++
 drivers/net/dsa/b53/b53_common.c                                 |   16 -
 drivers/net/dsa/b53/b53_priv.h                                   |    1 
 drivers/net/dsa/bcm_sf2.c                                        |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                        |    2 
 drivers/net/ethernet/cadence/macb_main.c                         |   28 +
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c                |   20 -
 drivers/net/ethernet/intel/e1000e/ethtool.c                      |   10 
 drivers/net/ethernet/intel/i40e/i40e_client.c                    |    4 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c                   |  123 +-------
 drivers/net/ethernet/intel/ice/ice_main.c                        |   12 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                       |    9 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                  |   12 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c                 |    4 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                      |   10 
 drivers/net/ethernet/microchip/lan865x/lan865x.c                 |    7 
 drivers/net/ethernet/oa_tc6.c                                    |    3 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                |   10 
 drivers/net/ethernet/xircom/xirc2ps_cs.c                         |    2 
 drivers/net/ipvlan/ipvlan_l3s.c                                  |    1 
 drivers/net/macsec.c                                             |    8 
 drivers/net/pcs/pcs-rzn1-miic.c                                  |    2 
 drivers/net/phy/mscc/mscc_ptp.c                                  |   18 -
 drivers/net/ppp/ppp_generic.c                                    |    6 
 drivers/net/usb/cdc_ncm.c                                        |    7 
 drivers/net/usb/qmi_wwan.c                                       |    5 
 drivers/net/vxlan/vxlan_core.c                                   |  122 +++++---
 drivers/net/vxlan/vxlan_mdb.c                                    |    2 
 drivers/net/vxlan/vxlan_private.h                                |    4 
 drivers/net/wireless/ath/ath11k/core.c                           |    1 
 drivers/net/wireless/ath/ath11k/core.h                           |    7 
 drivers/net/wireless/ath/ath11k/mac.c                            |  125 ++++++++
 drivers/net/wireless/ath/ath11k/reg.c                            |  107 +++++--
 drivers/net/wireless/ath/ath11k/reg.h                            |    3 
 drivers/net/wireless/ath/ath11k/wmi.h                            |    1 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c        |    6 
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c                     |    6 
 drivers/net/wireless/marvell/libertas/cfg.c                      |    9 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                  |    5 
 drivers/net/wireless/marvell/mwifiex/main.c                      |    4 
 drivers/net/wireless/mediatek/mt76/mac80211.c                    |    4 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                  |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                 |    7 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                  |    4 
 drivers/net/wireless/mediatek/mt76/tx.c                          |   12 
 drivers/net/wireless/st/cw1200/sta.c                             |    2 
 drivers/of/of_numa.c                                             |    5 
 drivers/pcmcia/omap_cf.c                                         |    2 
 drivers/pcmcia/rsrc_iodyn.c                                      |    3 
 drivers/pcmcia/rsrc_nonstatic.c                                  |    4 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                        |   14 
 drivers/platform/x86/asus-nb-wmi.c                               |    2 
 drivers/platform/x86/intel/tpmi_power_domains.c                  |    2 
 drivers/scsi/lpfc/lpfc_nvmet.c                                   |   10 
 drivers/scsi/sd.c                                                |   17 -
 drivers/scsi/sr.c                                                |   19 -
 drivers/soc/qcom/mdt_loader.c                                    |   12 
 drivers/spi/spi-fsl-lpspi.c                                      |   24 -
 drivers/tee/optee/ffa_abi.c                                      |    4 
 drivers/tee/tee_shm.c                                            |   14 
 drivers/thermal/mediatek/lvts_thermal.c                          |   50 ++-
 fs/btrfs/btrfs_inode.h                                           |    2 
 fs/btrfs/inode.c                                                 |    1 
 fs/btrfs/tree-log.c                                              |   78 +++--
 fs/btrfs/zoned.c                                                 |   55 ++-
 fs/ext4/ext4.h                                                   |    3 
 fs/ext4/ext4_jbd2.h                                              |   29 ++
 fs/ext4/super.c                                                  |   32 --
 fs/fs-writeback.c                                                |    9 
 fs/namespace.c                                                   |   18 -
 fs/ocfs2/inode.c                                                 |    3 
 fs/proc/generic.c                                                |   38 +-
 fs/smb/client/cifs_unicode.c                                     |    3 
 include/linux/blkdev.h                                           |    2 
 include/linux/bpf-cgroup.h                                       |    5 
 include/linux/bpf.h                                              |   60 ++--
 include/linux/hid.h                                              |    1 
 include/linux/io_uring_types.h                                   |   12 
 include/linux/pgtable.h                                          |   16 +
 include/linux/skbuff.h                                           |    8 
 include/linux/vmalloc.h                                          |   16 -
 include/net/dropreason-core.h                                    |   40 ++
 include/net/dsa.h                                                |    2 
 include/net/ip_tunnels.h                                         |   10 
 io_uring/msg_ring.c                                              |    4 
 kernel/bpf/core.c                                                |   50 ++-
 kernel/bpf/syscall.c                                             |   19 -
 kernel/sched/topology.c                                          |    2 
 mm/kasan/kasan_test_c.c                                          |    1 
 mm/kmemleak.c                                                    |   27 +
 mm/slub.c                                                        |  142 ++++++----
 mm/sparse-vmemmap.c                                              |    5 
 mm/sparse.c                                                      |   15 -
 mm/userfaultfd.c                                                 |    9 
 net/atm/resources.c                                              |    6 
 net/ax25/ax25_in.c                                               |    4 
 net/batman-adv/network-coding.c                                  |    7 
 net/bluetooth/hci_sync.c                                         |    2 
 net/bluetooth/l2cap_sock.c                                       |    3 
 net/bridge/br_netfilter_hooks.c                                  |    3 
 net/core/gen_estimator.c                                         |    2 
 net/dsa/port.c                                                   |   16 +
 net/dsa/user.c                                                   |    8 
 net/ipv4/devinet.c                                               |    7 
 net/ipv4/icmp.c                                                  |    6 
 net/ipv6/ip6_icmp.c                                              |    6 
 net/ipv6/tcp_ipv6.c                                              |   32 +-
 net/mctp/af_mctp.c                                               |    2 
 net/mctp/route.c                                                 |   35 +-
 net/netfilter/nf_conntrack_helper.c                              |    4 
 net/smc/smc_clc.c                                                |    2 
 net/smc/smc_ib.c                                                 |    3 
 net/wireless/scan.c                                              |    3 
 net/wireless/sme.c                                               |    5 
 scripts/Makefile.kasan                                           |   12 
 scripts/generate_rust_target.rs                                  |   12 
 sound/pci/hda/patch_hdmi.c                                       |    1 
 sound/pci/hda/patch_realtek.c                                    |    2 
 sound/usb/mixer_quirks.c                                         |    2 
 tools/gpio/Makefile                                              |    2 
 tools/perf/util/bpf-event.c                                      |   39 +-
 tools/perf/util/bpf-utils.c                                      |   61 ++--
 tools/power/cpupower/utils/cpupower-set.c                        |    4 
 tools/testing/selftests/drivers/net/hw/csum.py                   |    4 
 tools/testing/selftests/net/bind_bhash.c                         |    4 
 tools/testing/selftests/net/netfilter/nft_flowtable.sh           |  113 +++++--
 186 files changed, 1778 insertions(+), 921 deletions(-)

Aaron Erhardt (1):
      ALSA: hda/realtek: Fix headset mic for TongFang X6[AF]R5xxY

Abin Joseph (1):
      net: xilinx: axienet: Add error handling for RX metadata pointer retrieval

Ada Couprie Diaz (1):
      kasan: fix GCC mem-intrinsic prefix with sw tags

Al Viro (1):
      fs/fhandle.c: fix a race in call of has_locked_children()

Alan Stern (1):
      HID: core: Harden s32ton() against conversion to 0 bits

Alex Deucher (2):
      drm/amdgpu: drop hw access in non-DC audio fini
      Revert "drm/amdgpu: Avoid extra evict-restore process."

Alok Tiwari (4):
      xirc2ps_cs: fix register access when enabling FullDuplex
      bnxt_en: fix incorrect page count in RX aggr ring log
      ixgbe: fix incorrect map used in eee linkmode
      mctp: return -ENOPROTOOPT for unknown getsockopt options

Antheas Kapenekakis (1):
      platform/x86: asus-wmi: Remove extra keys from ignore_key_wlan quirk

Anup Patel (1):
      ACPI: RISC-V: Fix FFH_CPPC_CSR error handling

Bjorn Andersson (1):
      soc: qcom: mdt_loader: Deal with zero e_shentsize

Chen Ni (1):
      pcmcia: omap: Add missing check for platform_get_resource

Christian Loehle (1):
      sched: Fix sched_numa_find_nth_cpu() if mask offline

Christoffer Sandberg (1):
      platform/x86/amd/pmc: Add TUXEDO IB Pro Gen10 AMD to spurious 8042 quirks list

Christoph Hellwig (1):
      block: add a queue_limits_commit_update_frozen helper

Christoph Paasch (1):
      net/tcp: Fix socket memory leak in TCP-AO failure handling for IPv6

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
      bpf: Move bpf map owner out of common struct
      bpf: Move cgroup iterator helpers to bpf.h
      bpf: Fix oob access in cgroup local storage

Dave Airlie (1):
      nouveau: fix disabling the nonstall irq due to storm code

David Arcari (1):
      platform/x86/intel: power-domains: Use topology_logical_package_id() for package ID

Dmitry Antipov (1):
      wifi: cfg80211: fix use-after-free in cmp_bss()

Dmitry Torokhov (2):
      HID: simplify snto32()
      HID: stop exporting hid_snto32()

Duoming Zhou (1):
      wifi: brcmfmac: fix use-after-free when rescheduling brcmf_btcoex_info work

Edward Adam Davis (1):
      ocfs2: prevent release journal inode after journal shutdown

Emil Tantilov (1):
      idpf: set mac type when adding and removing MAC filters

Eric Dumazet (2):
      net_sched: gen_estimator: fix est_timer() vs CONFIG_PREEMPT_RT=y
      ax25: properly unshare skbs in ax25_kiss_rcv()

Fabian Bläse (1):
      icmp: fix icmp_ndo_send address translation for reply direction

Fabio Porcedda (3):
      net: usb: qmi_wwan: fix Telit Cinterion FN990A name
      net: usb: qmi_wwan: fix Telit Cinterion FE990A name
      net: usb: qmi_wwan: add Telit Cinterion FN990A w/audio composition

Felix Fietkau (4):
      wifi: mt76: prevent non-offchannel mgmt tx during scan/roc
      wifi: mt76: free pending offchannel tx frames on wcid cleanup
      wifi: mt76: fix linked list corruption
      net: ethernet: mtk_eth_soc: fix tx vlan tag for llc packets

Filipe Manana (3):
      btrfs: fix race between logging inode and checking if it was logged before
      btrfs: fix race between setting last_dir_index_offset and inode logging
      btrfs: avoid load/store tearing races when checking if an inode was logged

Florian Westphal (1):
      netfilter: nft_flowtable.sh: re-run with random mtu sizes

Greg Kroah-Hartman (1):
      Linux 6.12.46

Gu Bowen (1):
      mm: fix possible deadlock in kmemleak

Harry Yoo (2):
      x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings()
      mm: move page table sync declarations to linux/pgtable.h

Harshit Mogalapalli (1):
      wifi: mt76: mt7925: fix locking in mt7925_change_vif_links()

Horatiu Vultur (1):
      phy: mscc: Stop taking ts_lock for tx_queue and use its own lock

Huacai Chen (1):
      LoongArch: Save LBT before FPU in setup_sigcontext()

Hyesoo Yu (2):
      mm: slub: Print the broken data before restoring them
      mm: slub: call WARN() when detecting a slab corruption

Ian Rogers (3):
      perf bpf-event: Fix use-after-free in synthesis
      perf bpf-utils: Constify bpil_array_desc
      perf bpf-utils: Harden get_bpf_prog_info_linear

Ido Schimmel (6):
      vxlan: Fix NPD when refreshing an FDB entry with a nexthop object
      vxlan: Refresh FDB 'updated' time upon 'NTF_USE'
      vxlan: Avoid unnecessary updates to FDB 'used' time
      vxlan: Add RCU read-side critical sections in the Tx path
      vxlan: Rename FDB Tx lookup function
      vxlan: Fix NPD in {arp,neigh}_reduce() when using nexthop objects

Ivan Lipski (1):
      drm/amd/display: Clear the CUR_ENABLE register on DCN314 w/out DPP PG

Ivan Pravdin (1):
      Bluetooth: vhci: Prevent use-after-free by removing debugfs files early

Jacob Keller (2):
      ice: fix NULL access of tx->in_use in ice_ll_ts_intr
      i40e: remove read access to debugfs files

Jakub Kicinski (1):
      selftests: drv-net: csum: fix interface name for remote host

Jens Axboe (1):
      io_uring/msg_ring: ensure io_kiocb freeing is deferred for RCU

Jeremy Kerr (1):
      net: mctp: mctp_fraq_queue should take ownership of passed skb

Jiufei Xue (1):
      fs: writeback: fix use-after-free in __mark_inode_dirty()

Johannes Berg (1):
      wifi: iwlwifi: uefi: check DSM item validity

Johannes Thumshirn (1):
      btrfs: zoned: skip ZONE FINISH of conventional zones

John Evans (1):
      scsi: lpfc: Fix buffer free/clear order in deferred receive path

Jonas Gorski (1):
      net: dsa: b53: do not enable EEE on bcm63xx

Karol Wachowski (1):
      accel/ivpu: Prevent recovery work from being queued during device removal

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

Li Nan (1):
      md: prevent incorrect update of resync/recovery offset

Li Qiong (1):
      mm/slub: avoid accessing metadata when pointer is invalid in object_err()

Liu Jian (1):
      net/smc: fix one NULL pointer dereference in smc_ib_is_sg_need_sync()

Lubomir Rintel (1):
      cdc_ncm: Flag Intel OEM version of Fibocom L850-GL as WWAN

Ma Ke (1):
      pcmcia: Fix a NULL pointer dereference in __iodyn_find_io_region()

Mahanta Jambigi (1):
      net/smc: Remove validation of reserved bits in CLC Decline message

Makar Semyonov (1):
      cifs: prevent NULL pointer dereference in UTF16 conversion

Marek Vasut (2):
      arm64: dts: imx8mp: Fix missing microSD slot vqmmc on DH electronics i.MX8M Plus DHCOM
      arm64: dts: imx8mp: Fix missing microSD slot vqmmc on Data Modul i.MX8M Plus eDM SBC

Markus Niebel (1):
      arm64: dts: imx8mp-tqma8mpql: fix LDO5 power off

Menglong Dong (7):
      net: skb: add pskb_network_may_pull_reason() helper
      net: tunnel: add pskb_inet_may_pull_reason() helper
      net: vxlan: add skb drop reasons to vxlan_rcv()
      net: vxlan: make vxlan_snoop() return drop reasons
      net: vxlan: make vxlan_set_mac() return drop reasons
      net: vxlan: use kfree_skb_reason() in vxlan_xmit()
      net: vxlan: use kfree_skb_reason() in vxlan_mdb_xmit()

Miaoqian Lin (2):
      mISDN: Fix memory leak in dsp_hwec_enable()
      ACPI/IORT: Fix memory leak in iort_rmr_alloc_sids()

Michael Walle (1):
      drm/bridge: ti-sn65dsi86: fix REFCLK setting

Miguel Ojeda (1):
      rust: support Rust >= 1.91.0 target spec

Ming Lei (1):
      scsi: sr: Reinstate rotational media flag

Ming Yen Hsieh (2):
      wifi: mt76: mt7925u: use connac3 tx aggr check in tx complete
      wifi: mt76: mt7925: fix the wrong bss cleanup for SAP

Nathan Chancellor (2):
      wifi: mt76: mt7996: Initialize hdr before passing to skb_put_data()
      riscv: Only allow LTO with CMODEL_MEDANY

Nícolas F. R. A. Prado (1):
      thermal/drivers/mediatek/lvts: Disable low offset IRQ for minimum threshold

Ojaswin Mujoo (2):
      ext4: define ext4_journal_destroy wrapper
      ext4: avoid journaling sb update on error if journal is destroying

Paul Alvin (1):
      mmc: sdhci-of-arasan: Support for emmc hardware reset

Pei Xiao (2):
      tee: fix NULL pointer dereference in tee_shm_put
      tee: fix memory leak in tee_dyn_shm_alloc_helper

Peter Robinson (1):
      arm64: dts: rockchip: Add vcc-supply to SPI flash on rk3399-pinebook-pro

Phil Sutter (1):
      netfilter: conntrack: helper: Replace -EEXIST by -EBUSY

Qianfeng Rong (1):
      wifi: mwifiex: Initialize the chan_stats array to zero

Qingfang Deng (1):
      ppp: fix memory leak in pad_compress_skb

Qiu-ji Chen (2):
      dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()
      dmaengine: mediatek: Fix a flag reuse error in mtk_cqdma_tx_status()

Radim Krčmář (4):
      riscv: use lw when reading int cpu in new_vmalloc_check
      riscv: use lw when reading int cpu in asm_per_cpu
      riscv, bpf: use lw when reading int cpu in BPF_MOV64_PERCPU_REG
      riscv, bpf: use lw when reading int cpu in bpf_get_smp_processor_id

Radu Rendec (1):
      net: vxlan: rename SKB_DROP_REASON_VXLAN_NO_REMOTE

Rameshkumar Sundaram (1):
      wifi: ath11k: fix group data packet drops during rekey

Rosen Penev (2):
      net: thunder_bgx: add a missing of_node_put
      net: thunder_bgx: decrement cleanup index before use

Russell King (Oracle) (3):
      net: dsa: add hook to determine whether EEE is supported
      net: dsa: provide implementation of .support_eee()
      net: dsa: b53/bcm_sf2: implement .support_eee() method

Sabrina Dubroca (1):
      macsec: read MACSEC_SA_ATTR_PN with nla_get_uint

Sai Krishna Potthuri (1):
      mmc: sdhci-of-arasan: Ensure CD logic stabilization before power-up

Sasha Levin (1):
      mm/userfaultfd: fix kmap_local LIFO ordering for CONFIG_HIGHPTE

Sean Anderson (1):
      net: macb: Fix tx_ptr_lock locking

Shinji Nomoto (1):
      cpupower: Fix a bug where the -t option of the set subcommand was not working.

Stanislav Fort (1):
      batman-adv: fix OOB read/write in network-coding decode

Stefan Wahren (3):
      net: ethernet: oa_tc6: Handle failure of spi_setup
      microchip: lan865x: Fix module autoloading
      microchip: lan865x: Fix LAN8651 autoloading

Su Yue (1):
      md/md-bitmap: fix wrong bitmap_limit for clustermd when write sb

Sumanth Korikkar (1):
      mm: fix accounting of memmap pages

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

Vlastimil Babka (1):
      mm, slab: cleanup slab_bug() parameters

Wang Liang (3):
      netfilter: br_netfilter: do not check confirmed bit in br_nf_local_in() after confirm
      net: atm: fix memory leak in atm_register_sysfs when device_register fail
      net: fix NULL pointer dereference in l3mdev_l3_rcv

Wen Gong (2):
      wifi: ath11k: update channel list in reg notifier instead reg worker
      wifi: ath11k: update channel list in worker when wait flag is set

Wentao Guan (1):
      LoongArch: vDSO: Remove -nostdlib complier flag

Wentao Liang (1):
      pcmcia: Add error handling for add_interval() in do_validate_mem()

Xi Ruoyao (1):
      LoongArch: vDSO: Remove --hash-style=sysv

Yang Li (1):
      Bluetooth: hci_sync: Avoid adding default advertising on startup

Yeoreum Yun (1):
      kunit: kasan_test: disable fortify string checker on kasan_strings() test

Yin Tirui (1):
      of_numa: fix uninitialized memory nodes causing kernel panic

Yu Kuai (3):
      md/raid1,raid10: don't ignore IO flags
      md/raid1,raid10: don't handle IO error for REQ_RAHEAD and REQ_NOWAIT
      md/raid1: fix data lost for writemostly rdev

Zhen Ni (1):
      i40e: Fix potential invalid access when MAC list is empty

Zheng Qixing (1):
      md/raid1,raid10: strip REQ_NOWAIT from member bios

panfan (1):
      arm64: ftrace: fix unreachable PLT for ftrace_caller in init_module with CONFIG_DYNAMIC_FTRACE

wangzijie (1):
      proc: fix missing pde_set_flags() for net proc files

yangshiguang (1):
      mm: slub: avoid wake up kswapd in set_track_prepare

zhang jiao (1):
      tools: gpio: remove the include directory on make clean


