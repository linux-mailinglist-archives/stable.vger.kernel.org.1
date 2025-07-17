Return-Path: <stable+bounces-163290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83228B092B4
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 19:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1575E3A7840
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 17:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357BE2FCE3F;
	Thu, 17 Jul 2025 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SXVSgxLc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83552FCFEF;
	Thu, 17 Jul 2025 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771877; cv=none; b=LV5l+C+Hj455teUiQMOiSA6Pagj8jwrGB+TahrLNsDCFKtbAa0P9rW7zzUKJGk2ti+R4y5gw+qYW/tfX83zaVsALenjWvqwNP5FOQ7AVgk9kuWt4y+UIUd2HLmgtl5Gcs5tkAgFV7zIAZZ8prK2mI/0MEKfP/TkNqu4n1pG0OKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771877; c=relaxed/simple;
	bh=frNRxMDsNjEbbXpXV7nc+u2RFAcCcWp7f7E+AGeJbfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OvaBJgueyd3+5PBESU90oIYda9XlPMI/2UYHWxDWH/kwSaDNhcMPnSq2e7aZwBkVnap5ZTk9PYAbJs6vMRMZWB4pV9umgWrVAEVD+Q0fjaXMoc1huIDiWtU/NX+xuB7Pu7bT4RlMCjtusvpGjH4hPiUBiL4C/l2m3jFtYoN9gGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SXVSgxLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F40C4CEE3;
	Thu, 17 Jul 2025 17:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752771877;
	bh=frNRxMDsNjEbbXpXV7nc+u2RFAcCcWp7f7E+AGeJbfg=;
	h=From:To:Cc:Subject:Date:From;
	b=SXVSgxLc/1Sdx4oNYWT53saOAd3Nn59O4JqIAB06/lElCwfdJsyi/1r62r1UgvTai
	 xsybmrwmByJxiiGmEpRBKI+Cp84QY+NaXhCLSzNkFsMlf2DPFIOxv1kgC6T9qsA4z4
	 ZZGOs+NOeZe5M7sciSJ8HBdT5lZQ8HWIRg8jhtv8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.15.7
Date: Thu, 17 Jul 2025 19:04:21 +0200
Message-ID: <2025071722-patronage-feminize-1fc2@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.15.7 kernel.

All users of the 6.15 kernel series must upgrade.

The updated 6.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/bpf/map_hash.rst                                     |    8 
 Documentation/bpf/map_lru_hash_update.dot                          |    6 
 Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml |    3 
 Makefile                                                           |    2 
 arch/arm64/kernel/cpufeature.c                                     |   57 +-
 arch/arm64/kernel/process.c                                        |    5 
 arch/arm64/mm/fault.c                                              |   30 -
 arch/arm64/mm/proc.S                                               |    1 
 arch/riscv/kernel/vdso/vdso.lds.S                                  |    2 
 arch/s390/crypto/sha1_s390.c                                       |    2 
 arch/s390/crypto/sha256_s390.c                                     |    3 
 arch/s390/crypto/sha512_s390.c                                     |    3 
 arch/um/drivers/vector_kern.c                                      |   42 -
 arch/x86/Kconfig                                                   |    2 
 arch/x86/coco/sev/core.c                                           |   22 
 arch/x86/include/asm/msr-index.h                                   |    1 
 arch/x86/include/asm/sev.h                                         |   17 
 arch/x86/kernel/cpu/amd.c                                          |   10 
 arch/x86/kernel/cpu/mce/amd.c                                      |   28 -
 arch/x86/kernel/cpu/mce/core.c                                     |   24 
 arch/x86/kernel/cpu/mce/intel.c                                    |    1 
 arch/x86/kvm/hyperv.c                                              |    3 
 arch/x86/kvm/svm/sev.c                                             |    4 
 arch/x86/kvm/xen.c                                                 |   15 
 drivers/acpi/battery.c                                             |   19 
 drivers/atm/idt77252.c                                             |    5 
 drivers/block/nbd.c                                                |    6 
 drivers/block/ublk_drv.c                                           |    3 
 drivers/bluetooth/hci_qca.c                                        |   13 
 drivers/char/ipmi/ipmi_msghandler.c                                |    3 
 drivers/clk/clk-scmi.c                                             |   18 
 drivers/clk/imx/clk-imx95-blk-ctl.c                                |   12 
 drivers/edac/ecs.c                                                 |    4 
 drivers/edac/mem_repair.c                                          |    1 
 drivers/edac/scrub.c                                               |    1 
 drivers/gpio/gpiolib.c                                             |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c                  |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c                  |    8 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c                           |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                               |   43 -
 drivers/gpu/drm/drm_framebuffer.c                                  |   31 +
 drivers/gpu/drm/drm_gem.c                                          |   74 ++
 drivers/gpu/drm/drm_internal.h                                     |    2 
 drivers/gpu/drm/exynos/exynos7_drm_decon.c                         |    4 
 drivers/gpu/drm/imagination/pvr_power.c                            |    4 
 drivers/gpu/drm/nouveau/nouveau_debugfs.c                          |    6 
 drivers/gpu/drm/nouveau/nouveau_debugfs.h                          |    5 
 drivers/gpu/drm/nouveau/nouveau_drm.c                              |    4 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c                     |   20 
 drivers/gpu/drm/tegra/nvdec.c                                      |    6 
 drivers/gpu/drm/ttm/ttm_bo_util.c                                  |   13 
 drivers/gpu/drm/xe/xe_gt_pagefault.c                               |    1 
 drivers/gpu/drm/xe/xe_lmtt.c                                       |   11 
 drivers/gpu/drm/xe/xe_migrate.c                                    |    2 
 drivers/gpu/drm/xe/xe_pci.c                                        |    1 
 drivers/gpu/drm/xe/xe_pm.c                                         |   11 
 drivers/hid/hid-ids.h                                              |    6 
 drivers/hid/hid-lenovo.c                                           |    8 
 drivers/hid/hid-multitouch.c                                       |    8 
 drivers/hid/hid-nintendo.c                                         |   38 +
 drivers/hid/hid-quirks.c                                           |    3 
 drivers/irqchip/Kconfig                                            |    1 
 drivers/md/md-bitmap.c                                             |    3 
 drivers/md/raid1.c                                                 |    4 
 drivers/md/raid10.c                                                |   12 
 drivers/net/can/m_can/m_can.c                                      |    2 
 drivers/net/ethernet/airoha/airoha_eth.c                           |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                          |   10 
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c                 |   18 
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c                      |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                      |    2 
 drivers/net/ethernet/ibm/ibmvnic.h                                 |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h                    |    9 
 drivers/net/ethernet/mellanox/mlx5/core/en_dim.c                   |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c                    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c                  |    1 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c                  |   13 
 drivers/net/ethernet/microsoft/mana/gdma_main.c                    |    3 
 drivers/net/ethernet/renesas/rtsn.c                                |    5 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c                 |   24 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                           |    4 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                        |   16 
 drivers/net/ethernet/wangxun/libwx/wx_type.h                       |    2 
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c                      |    2 
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h                      |    2 
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c                     |    4 
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h                    |    4 
 drivers/net/ethernet/xilinx/ll_temac_main.c                        |    2 
 drivers/net/phy/microchip.c                                        |    3 
 drivers/net/phy/qcom/at803x.c                                      |   27 -
 drivers/net/phy/qcom/qca808x.c                                     |    2 
 drivers/net/phy/qcom/qcom-phy-lib.c                                |   25 
 drivers/net/phy/qcom/qcom.h                                        |    5 
 drivers/net/phy/smsc.c                                             |   57 ++
 drivers/net/usb/qmi_wwan.c                                         |    1 
 drivers/net/wireless/marvell/mwifiex/util.c                        |    4 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c               |    6 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                   |    3 
 drivers/net/wireless/mediatek/mt76/mt7925/init.c                   |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                   |    6 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                    |    4 
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h                   |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                    |   40 -
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                   |    5 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                    |  188 +++++--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                 |   16 
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.c                     |    4 
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.h                     |    2 
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c                       |    6 
 drivers/pci/pci-acpi.c                                             |   23 
 drivers/pinctrl/nuvoton/pinctrl-ma35.c                             |   10 
 drivers/pinctrl/pinctrl-amd.c                                      |   11 
 drivers/pinctrl/qcom/pinctrl-msm.c                                 |   20 
 drivers/pwm/core.c                                                 |    2 
 drivers/pwm/pwm-mediatek.c                                         |   13 
 drivers/tty/vt/vt.c                                                |    1 
 drivers/usb/gadget/function/u_serial.c                             |   12 
 fs/btrfs/free-space-tree.c                                         |   16 
 fs/erofs/data.c                                                    |   21 
 fs/erofs/decompressor.c                                            |   12 
 fs/erofs/fileio.c                                                  |    6 
 fs/erofs/internal.h                                                |    6 
 fs/erofs/zdata.c                                                   |   13 
 fs/erofs/zmap.c                                                    |    9 
 fs/eventpoll.c                                                     |   12 
 fs/proc/inode.c                                                    |    2 
 fs/proc/proc_sysctl.c                                              |   18 
 fs/proc/task_mmu.c                                                 |   14 
 fs/smb/server/smb2pdu.c                                            |   29 -
 fs/smb/server/transport_rdma.c                                     |    5 
 fs/smb/server/vfs.c                                                |    1 
 include/drm/drm_file.h                                             |    3 
 include/drm/drm_framebuffer.h                                      |    7 
 include/drm/spsc_queue.h                                           |    4 
 include/linux/blkdev.h                                             |    5 
 include/linux/ieee80211.h                                          |   45 +
 include/linux/io_uring_types.h                                     |    2 
 include/linux/mm.h                                                 |    5 
 include/linux/psp-sev.h                                            |    2 
 include/net/af_vsock.h                                             |    2 
 include/net/bluetooth/hci_core.h                                   |    3 
 include/net/netfilter/nf_flow_table.h                              |    2 
 include/sound/soc-acpi.h                                           |   13 
 include/trace/events/erofs.h                                       |    2 
 io_uring/msg_ring.c                                                |    4 
 io_uring/opdef.c                                                   |    1 
 io_uring/zcrx.c                                                    |    3 
 kernel/bpf/bpf_lru_list.c                                          |    9 
 kernel/bpf/bpf_lru_list.h                                          |    1 
 kernel/events/core.c                                               |    6 
 kernel/module/main.c                                               |    4 
 kernel/sched/core.c                                                |    7 
 kernel/sched/deadline.c                                            |   10 
 kernel/stop_machine.c                                              |   20 
 lib/alloc_tag.c                                                    |    3 
 lib/maple_tree.c                                                   |    1 
 mm/damon/core.c                                                    |    8 
 mm/kasan/report.c                                                  |   45 -
 mm/rmap.c                                                          |   46 +
 mm/vmalloc.c                                                       |   22 
 net/appletalk/ddp.c                                                |    1 
 net/atm/clip.c                                                     |   64 +-
 net/bluetooth/hci_event.c                                          |    3 
 net/bluetooth/hci_sync.c                                           |    4 
 net/ipv4/tcp.c                                                     |    2 
 net/ipv6/addrconf.c                                                |    9 
 net/mac80211/cfg.c                                                 |   14 
 net/mac80211/mlme.c                                                |    7 
 net/mac80211/parse.c                                               |    6 
 net/mac80211/util.c                                                |    9 
 net/netlink/af_netlink.c                                           |   82 +--
 net/rxrpc/call_accept.c                                            |    4 
 net/sched/sch_api.c                                                |   23 
 net/tipc/topsrv.c                                                  |    2 
 net/vmw_vsock/af_vsock.c                                           |   57 +-
 net/wireless/nl80211.c                                             |    7 
 net/wireless/util.c                                                |   52 +-
 samples/damon/prcl.c                                               |    8 
 samples/damon/wsse.c                                               |    8 
 scripts/gdb/linux/constants.py.in                                  |    7 
 scripts/gdb/linux/interrupts.py                                    |   16 
 scripts/gdb/linux/mapletree.py                                     |  252 ++++++++++
 scripts/gdb/linux/vfs.py                                           |    2 
 scripts/gdb/linux/xarray.py                                        |   28 +
 sound/isa/ad1816a/ad1816a.c                                        |    2 
 sound/pci/hda/patch_realtek.c                                      |   10 
 sound/soc/amd/yc/acp6x-mach.c                                      |    7 
 sound/soc/codecs/cs35l56-shared.c                                  |    2 
 sound/soc/codecs/rt721-sdca.c                                      |   23 
 sound/soc/fsl/fsl_asrc.c                                           |    3 
 sound/soc/fsl/fsl_sai.c                                            |   14 
 sound/soc/intel/boards/Kconfig                                     |    1 
 sound/soc/intel/common/Makefile                                    |    2 
 sound/soc/intel/common/soc-acpi-intel-arl-match.c                  |   21 
 sound/soc/intel/common/sof-function-topology-lib.c                 |  136 +++++
 sound/soc/intel/common/sof-function-topology-lib.h                 |   15 
 sound/soc/sof/intel/hda.c                                          |    6 
 tools/arch/x86/include/asm/msr-index.h                             |    1 
 tools/include/linux/kallsyms.h                                     |    4 
 tools/objtool/check.c                                              |    1 
 tools/testing/selftests/bpf/test_lru_map.c                         |  105 ++--
 tools/testing/selftests/net/lib.sh                                 |    2 
 virt/kvm/kvm_main.c                                                |    3 
 203 files changed, 2006 insertions(+), 827 deletions(-)

Aaron Thompson (1):
      drm/nouveau: Do not fail module init on debugfs errors

Achill Gilgenast (1):
      kallsyms: fix build without execinfo

Akira Inoue (1):
      HID: lenovo: Add support for ThinkPad X1 Tablet Thin Keyboard Gen2

Al Viro (2):
      fix proc_sys_compare() handling of in-lookup dentries
      ksmbd: fix a mount write count leak in ksmbd_vfs_kern_path_locked()

Alessio Belle (1):
      drm/imagination: Fix kernel crash when hard resetting the GPU

Alex Deucher (1):
      drm/amdkfd: add hqd_sdma_get_doorbell callbacks for gfx7/8

Alexander Gordeev (1):
      mm/vmalloc: leave lazy MMU mode on PTE mapping error

Alok Tiwari (1):
      net: ll_temac: Fix missing tx_pending check in ethtools_set_ringparam()

Anshuman Khandual (1):
      arm64/mm: Drop wrong writes into TCR2_EL1

Arun Raghavan (1):
      ASoC: fsl_sai: Force a software reset when starting in consumer mode

Baolin Wang (1):
      mm: fix the inaccurate memory statistics issue for users

Bard Liao (4):
      ASoC: Intel: SND_SOC_INTEL_SOF_BOARD_HELPERS select SND_SOC_ACPI_INTEL_MATCH
      ASoC: soc-acpi: add get_function_tplg_files ops
      ASoC: Intel: add sof_sdw_get_tplg_files ops
      ASoC: Intel: soc-acpi-intel-arl-match: set get_function_tplg_files ops

Bartosz Golaszewski (1):
      pinctrl: qcom: msm: mark certain pins as invalid for interrupts

Ben Skeggs (1):
      drm/nouveau/gsp: fix potential leak of memory used during acpi init

Carolina Jubran (2):
      net/mlx5: Reset bw_share field when changing a node's parent
      net/mlx5e: Fix race between DIM disable and net_dim()

Chao Yu (2):
      erofs: fix to add missing tracepoint in erofs_read_folio()
      erofs: fix to add missing tracepoint in erofs_readahead()

Charles Keepax (1):
      ASoC: Intel: soc-acpi: arl: Correct order of cs42l43 matches

Chia-Lin Kao (AceLan) (1):
      HID: quirks: Add quirk for 2 Chicony Electronics HP 5MP Cameras

Chintan Vankar (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix skb size by accounting for skb_shared_info

Chris Chiu (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for HP EliteBook 6 G1a

Christian König (1):
      drm/ttm: fix error handling in ttm_buffer_object_transfer

Christophe JAILLET (1):
      net: airoha: Fix an error handling path in airoha_probe()

Dan Carpenter (1):
      ipmi:msghandler: Fix potential memory corruption in ipmi_create_user()

Daniel J. Ogorchock (1):
      HID: nintendo: avoid bluetooth suspend/resume stalls

Daniil Dulov (1):
      wifi: zd1211rw: Fix potential NULL pointer dereference in zd_mac_tx_to_dev()

David Howells (2):
      rxrpc: Fix bug due to prealloc collision
      rxrpc: Fix oops due to non-existence of prealloc backlog struct

David Woodhouse (1):
      KVM: x86/xen: Allow 'out of range' event channel ports in IRQ routing table.

Deren Wu (2):
      wifi: mt76: mt7921: prevent decap offload config before STA initialization
      wifi: mt76: mt7925: prevent NULL pointer dereference in mt7925_sta_set_decap_offload()

Edip Hazuri (1):
      ALSA: hda/realtek - Add mute LED support for HP Victus 15-fb2xxx

Eric Biggers (1):
      crypto: s390/sha - Fix uninitialized variable in SHA-1 and SHA-2

Eric Dumazet (1):
      netfilter: flowtable: account for Ethernet header in nf_flow_pppoe_proto()

EricChan (1):
      net: stmmac: Fix interrupt handling for level-triggered mode in DWC_XGMAC2

Fangrui Song (1):
      riscv: vdso: Exclude .rodata from the PT_DYNAMIC segment

Felix Fietkau (1):
      wifi: rt2x00: fix remove callback type mismatch

Fengnan Chang (1):
      io_uring: make fallocate be hashed work

Filipe Manana (1):
      btrfs: fix assertion when building free space tree

Florian Fainelli (3):
      scripts/gdb: fix interrupts display after MCP on x86
      scripts/gdb: de-reference per-CPU MCE interrupts
      scripts/gdb: fix interrupts.py after maple tree conversion

Gao Xiang (3):
      erofs: address D-cache aliasing
      erofs: fix large fragment handling
      erofs: refine readahead tracepoint

Greg Kroah-Hartman (1):
      Linux 6.15.7

Guillaume Nault (1):
      gre: Fix IPv6 multicast route creation.

Hangbin Liu (1):
      selftests: net: lib: fix shift count out of range

Haoxiang Li (1):
      net: ethernet: rtsn: Fix a null pointer dereference in rtsn_probe()

Harry Yoo (1):
      lib/alloc_tag: do not acquire non-existent lock in alloc_tag_top_users()

Heiko Carstens (1):
      objtool: Add missing endian conversion to read_annotate()

Henry Martin (1):
      wifi: mt76: mt7925: Fix null-ptr-deref in mt7925_thermal_init()

Honggyu Kim (3):
      mm/damon: fix divide by zero in damon_get_intervals_score()
      samples/damon: fix damon sample prcl for start failure
      samples/damon: fix damon sample wsse for start failure

Hugo Villeneuve (1):
      gpiolib: fix performance regression when using gpio_chip_get_multiple()

Håkon Bugge (1):
      md/md-bitmap: fix GPF in bitmap_get_stats()

Illia Ostapyshyn (1):
      scripts: gdb: vfs: support external dentry names

JP Kobryn (1):
      x86/mce: Make sure CMCI banks are cleared during shutdown on Intel

Jack Yu (1):
      ASoC: rt721-sdca: fix boost gain calculation error

Jakub Kicinski (1):
      netlink: make sure we allow at least one dump skb

Jann Horn (1):
      x86/mm: Disable hugetlb page table sharing on 32-bit

Jason Xing (1):
      bnxt_en: eliminate the compile warning in bnxt_request_irq due to CONFIG_RFS_ACCEL

Jens Axboe (1):
      io_uring/msg_ring: ensure io_kiocb freeing is deferred for RCU

Jianbo Liu (1):
      net/mlx5e: Add new prio for promiscuous mode

Jiawen Wu (1):
      net: wangxun: revert the adjustment of the IRQ vector sequence

Jiayuan Chen (1):
      tcp: Correct signedness in skb remaining space calculation

Johannes Berg (1):
      wifi: mac80211: fix non-transmitted BSSID profile search

Julien Massot (1):
      dt-bindings: clock: mediatek: Add #reset-cells property for MT8188

Kaustabh Chakraborty (1):
      drm/exynos: exynos7_drm_decon: add vblank check in IRQ handling

Kent Russell (1):
      drm/amdgpu: Include sdma_4_4_4.bin

Kevin Brodsky (1):
      arm64: poe: Handle spurious Overlay faults

Kito Xu (1):
      net: appletalk: Fix device refcount leak in atrtr_create()

Kuen-Han Tsai (2):
      usb: gadget: u_serial: Fix race condition in TTY wakeup
      Revert "usb: gadget: u_serial: Add null pointer check in gs_start_io"

Kuniyuki Iwashima (6):
      netlink: Fix wraparounds of sk->sk_rmem_alloc.
      tipc: Fix use-after-free in tipc_conn_close().
      atm: clip: Fix potential null-ptr-deref in to_atmarpd().
      atm: clip: Fix memory leak of struct clip_vcc.
      atm: clip: Fix infinite recursive call of clip_push().
      netlink: Fix rmem check in netlink_broadcast_deliver().

Lachlan Hodges (2):
      wifi: cfg80211: fix S1G beacon head validation in nl80211
      wifi: mac80211: correctly identify S1G short beacon

Lance Yang (1):
      mm/rmap: fix potential out-of-bounds page table access during batched unmap

Liam Merwick (1):
      KVM: Allow CPU to reschedule while setting per-page memory attributes

Linus Torvalds (1):
      eventpoll: don't decrement ep refcount while still holding the ep mutex

Long Li (1):
      net: mana: Record doorbell physical address in PF mode

Lorenzo Bianconi (5):
      wifi: mt76: Assume __mt76_connac_mcu_alloc_sta_req runs in atomic context
      wifi: mt76: Move RCU section in mt7996_mcu_set_fixed_field()
      wifi: mt76: Move RCU section in mt7996_mcu_add_rate_ctrl_fixed()
      wifi: mt76: Move RCU section in mt7996_mcu_add_rate_ctrl()
      wifi: mt76: Remove RCU section in mt7996_mac_sta_rc_work()

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix not disabling advertising instance
      Bluetooth: hci_core: Remove check of BDADDR_ANY in hci_conn_hash_lookup_big_state
      Bluetooth: hci_sync: Fix attempting to send HCI_Disconnect to BIS handle
      Bluetooth: hci_event: Fix not marking Broadcast Sink BIS as connected

Luo Gengkun (1):
      perf/core: Fix the WARN_ON_ONCE is out of lock protected region

Luo Jie (2):
      net: phy: qcom: move the WoL function to shared library
      net: phy: qcom: qca808x: Fix WoL issue by utilizing at8031_set_wol()

Manuel Andreas (1):
      KVM: x86/hyper-v: Skip non-canonical addresses during PV TLB flush

Mario Limonciello (1):
      pinctrl: amd: Clear GPIO debounce for suspend

Mark Brown (1):
      arm64: Filter out SME hwcaps when FEAT_SME isn't implemented

Mathy Vanhoef (1):
      wifi: prevent A-MSDU attacks in mesh networks

Matthew Auld (1):
      drm/xe/bmg: fix compressed VRAM handling

Matthew Brost (3):
      drm/sched: Increment job count before swapping tail spsc queue
      Revert "drm/xe/xe2: Enable Indirect Ring State support for Xe2"
      drm/xe: Allocate PF queue size on pow2 boundary

Michael Lo (1):
      wifi: mt76: mt7925: fix invalid array index in ssid assignment during hw scan

Michal Luczaj (3):
      vsock: Fix transport_{g2h,h2g} TOCTOU
      vsock: Fix transport_* TOCTOU
      vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_local`

Michal Wajdeczko (1):
      drm/xe/pf: Clear all LMTT pages on alloc

Mikhail Paulyshka (2):
      x86/rdrand: Disable RDSEED on AMD Cyan Skillfish
      x86/CPU/AMD: Disable INVLPGB on Zen2

Mikko Perttunen (1):
      drm/tegra: nvdec: Fix dma_alloc_coherent error check

Ming Yen Hsieh (1):
      wifi: mt76: mt7925: fix the wrong config for tx interrupt

Mingming Cao (1):
      ibmvnic: Fix hardcoded NUM_RX_STATS/NUM_TX_STATS with dynamic sizeof

Miquel Raynal (1):
      pinctrl: nuvoton: Fix boot on ma35dx platforms

Miri Korenblit (1):
      wifi: mac80211: add the virtual monitor after reconfig complete

Moon Hee Lee (1):
      wifi: mac80211: reject VHT opmode for unsupported channel widths

Nam Cao (1):
      irqchip/irq-msi-lib: Select CONFIG_GENERIC_MSI_IRQ

Namjae Jeon (1):
      ksmbd: fix potential use-after-free in oplock/lease break ack

Nicolas Pitre (1):
      vt: add missing notification when switching back to text mode

Nigel Croxon (1):
      raid10: cleanup memleak at raid10_make_request

Nikunj A Dadhania (2):
      KVM: SVM: Add missing member in SNP_LAUNCH_START command structure
      x86/sev: Use TSC_FACTOR for Secure TSC frequency calculation

Oleksij Rempel (5):
      net: phy: smsc: Fix Auto-MDIX configuration when disabled by strap
      net: phy: smsc: Force predictable MDI-X state on LAN87xx
      net: phy: smsc: Fix link failure in forced mode with Auto-MDIX
      net: phy: microchip: Use genphy_soft_reset() to purge stale LPA bits
      net: phy: microchip: limit 100M workaround to link-down events on LAN88xx

Pankaj Raghav (1):
      block: reject bs > ps block devices when THP is disabled

Pavel Begunkov (1):
      io_uring/zcrx: fix pp destruction warnings

Peter Ujfalusi (1):
      ASoC: Intel: sof-function-topology-lib: Print out the unsupported dmic count

Peter Zijlstra (2):
      sched/core: Fix migrate_swap() vs. hotplug
      perf: Revert to requiring CAP_SYS_ADMIN for uprobes

Petr Pavlu (1):
      module: Fix memory deallocation on error path in move_module()

Philip Yang (1):
      drm/amdkfd: Don't call mmput from MMU notifier callback

Rafael J. Wysocki (1):
      Revert "ACPI: battery: negate current when discharging"

Richard Fitzgerald (1):
      ASoC: cs35l56: probe() should fail if the device ID is not recognized

Ronnie Sahlberg (1):
      ublk: sanity check add_dev input for underflow

Sascha Hauer (1):
      clk: scmi: Handle case where child clocks are initialized before their parents

Sean Christopherson (1):
      KVM: SVM: Reject SEV{-ES} intra host migration if vCPU creation is in-flight

Sean Nyekjaer (1):
      can: m_can: m_can_handle_lost_msg(): downgrade msg lost in rx message to debug level

SeongJae Park (1):
      mm/damon/core: handle damon_call_control as normal under kdmond deactivation

Shengjiu Wang (1):
      ASoC: fsl_asrc: use internal measured ratio for non-ideal ratio mode

Shiju Jose (1):
      EDAC: Initialize EDAC features sysfs attributes

Shravya KN (1):
      bnxt_en: Fix DCB ETS validation

Shruti Parab (1):
      bnxt_en: Flush FW trace before copying to the coredump

Shuai Zhang (1):
      driver: bluetooth: hci_qca:fix unable to load the BT driver

Shuicheng Lin (2):
      drm/xe/pm: Restore display pm if there is error after display suspend
      drm/xe/pm: Correct comment of xe_pm_set_vram_threshold()

Simona Vetter (1):
      drm/gem: Fix race in drm_gem_handle_create_tail()

Somnath Kotur (1):
      bnxt_en: Set DMA unmap len correctly for XDP_REDIRECT

Stefan Metzmacher (1):
      smb: server: make use of rdma_destroy_qp()

Stefano Garzarella (1):
      vsock: fix `vsock_proto` declaration

Takashi Iwai (1):
      ALSA: hda/realtek: Add mic-mute LED setup for ASUS UM5606

Tamura Dai (1):
      ASoC: SOF: Intel: hda: Use devm_kstrdup() to avoid memleak.

Thomas Fourier (1):
      atm: idt77252: Add missing `dma_map_error()`

Thomas Weißschuh (1):
      sched: Fix preemption string of preempt_dynamic_none

Thomas Zimmermann (2):
      drm/gem: Acquire references on GEM handles for framebuffers
      drm/framebuffer: Acquire internal references on GEM handles

Thorsten Blum (1):
      ALSA: ad1816a: Fix potential NULL pointer deref in snd_card_ad1816a_pnp()

Tim Crawford (1):
      ALSA: hda/realtek: Add quirks for some Clevo laptops

Tiwei Bie (1):
      um: vector: Reduce stack usage in vector_eth_configure()

Uwe Kleine-König (2):
      pwm: Fix invalid state detection
      pwm: mediatek: Ensure to disable clocks in error path

Victor Nogueira (1):
      net/sched: Abort __tc_modify_qdisc if parent class does not exist

Vitor Soares (1):
      wifi: mwifiex: discard erroneous disassoc frames on STA interface

Wang Jinchao (1):
      md/raid1: Fix stack memory use after return in raid1_reshape

Wei Yang (1):
      maple_tree: fix mt_destroy_walk() on root leaf node

Willem de Bruijn (2):
      bpf: Adjust free target to avoid global starvation of LRU map
      selftests/bpf: adapt one more case in test_lru_map to the new target_free

Xiaolei Wang (1):
      clk: imx: Fix an out-of-bounds access in dispmix_csr_clk_dev_data

Xiaowei Li (1):
      net: usb: qmi_wwan: add SIMCom 8230C composition

Yasmin Fitzgerald (1):
      ALSA: hda/realtek - Enable mute LED on HP Pavilion Laptop 15-eg100

Yazen Ghannam (4):
      x86/mce/amd: Add default names for MCA banks and blocks
      x86/mce/amd: Fix threshold limit reset
      x86/mce: Don't remove sysfs if thresholding sysfs init fails
      x86/mce: Ensure user polling settings are honored when restarting timer

Yeoreum Yun (1):
      kasan: remove kasan_find_vm_area() to prevent possible deadlock

Yue Haibing (1):
      atm: clip: Fix NULL pointer dereference in vcc_sendmsg()

Yuzuru10 (1):
      ASoC: amd: yc: add quirk for Acer Nitro ANV15-41 internal mic

Zhang Heng (1):
      HID: Add IGNORE quirk for SMARTLINKTECHNOLOGY

Zhe Qiao (1):
      Revert "PCI/ACPI: Fix allocated memory release on error in pci_acpi_scan_root()"

Zheng Qixing (2):
      md/raid1,raid10: strip REQ_NOWAIT from member bios
      nbd: fix uaf in nbd_genl_connect() error path

kuyo chang (1):
      sched/deadline: Fix dl_server runtime calculation formula


