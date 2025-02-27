Return-Path: <stable+bounces-119838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AB1A47E13
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 13:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A294B3ABE42
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E5422DFFC;
	Thu, 27 Feb 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GuPlvkAl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA9C22E011;
	Thu, 27 Feb 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660145; cv=none; b=gc4NU9SbrRuD6ZDN02i00lS5dvKWwmWoJZd7/oyNhtT73cbWgr3Ma6IqEJC+XwNLs4I9Bx0qiDtIoOCMtKxqDLAddYMi0e3ypaUA8NCuM2o0mF3XhGEMu1mfvYGl7iqg9PM8MXlmyjUlblSW7It5Qgh3N78Bp1FLgwFyhOb0vgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660145; c=relaxed/simple;
	bh=+x2jF96qZh07CuiCAWXLdc0rFRaMYLj3Jl31Vg1gDAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oD2IhcD1GNUmFwyRnPx+sWalUPzG72sX/2gUu5loofdtfzbooFYwormwX/gWS/KJdma+9feIgmAyrxnpE7fdhPN0grGakO7V+NPvpzCnEB0K3a+J3qgloRGvcilLBZNmw+s8mQ+nWLdHa4HZih2N8Co70o2DmfZx9Ci8ASWWNvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GuPlvkAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB581C4CEE7;
	Thu, 27 Feb 2025 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740660145;
	bh=+x2jF96qZh07CuiCAWXLdc0rFRaMYLj3Jl31Vg1gDAU=;
	h=From:To:Cc:Subject:Date:From;
	b=GuPlvkAlFXBIklouRNVcmazNPmzgOtbAtJvjSGSdkdDhOCp3ynUe4KaFIeUupXFea
	 nwxuycfBCRugDKDsy22pGHFuoQVRo2VNq0viKQElJkYOoc3b06LNPY2w/Ti06mewpv
	 acycLHLalfIE3FImAJZUNsVJtoaIPudodsLZwI6E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.13.5
Date: Thu, 27 Feb 2025 04:41:13 -0800
Message-ID: <2025022714-jackknife-undated-f3b8@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.13.5 kernel.

All users of the 6.13 kernel series must upgrade.

The updated 6.13.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.13.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                      |    2 
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts         |    1 
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi               |    6 
 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts  |    3 
 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts      |    1 
 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi     |    1 
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi       |    8 
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi          |    6 
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi                  |   22 
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                 |   22 
 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts    |    4 
 arch/powerpc/include/asm/book3s/64/hash-4k.h                  |   12 
 arch/powerpc/lib/code-patching.c                              |    4 
 arch/s390/boot/startup.c                                      |    2 
 arch/x86/events/intel/core.c                                  |   20 
 arch/x86/events/intel/ds.c                                    |    2 
 drivers/bluetooth/btqca.c                                     |  118 -
 drivers/clocksource/jcore-pit.c                               |   15 
 drivers/edac/qcom_edac.c                                      |    4 
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c           |    4 
 drivers/firmware/imx/Kconfig                                  |    1 
 drivers/gpio/gpio-vf610.c                                     |    4 
 drivers/gpio/gpiolib.c                                        |   48 
 drivers/gpio/gpiolib.h                                        |    4 
 drivers/gpu/drm/Kconfig                                       |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                       |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                         |   32 
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h                |    3 
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm        |  202 -
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm        | 1130 ++++++++++
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile               |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c              |    5 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c |  140 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  132 -
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h  |    4 
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h      |   59 
 drivers/gpu/drm/drm_panic_qr.rs                               |    2 
 drivers/gpu/drm/i915/display/icl_dsi.c                        |    4 
 drivers/gpu/drm/i915/display/intel_ddi.c                      |    2 
 drivers/gpu/drm/i915/display/intel_display.c                  |   18 
 drivers/gpu/drm/i915/display/intel_dp_link_training.c         |   15 
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c             |    4 
 drivers/gpu/drm/i915/i915_reg.h                               |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h        |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h       |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h        |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                   |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c                    |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c                    |    2 
 drivers/gpu/drm/msm/dp/dp_display.c                           |   11 
 drivers/gpu/drm/msm/dp/dp_drm.c                               |    5 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c                     |   53 
 drivers/gpu/drm/msm/msm_drv.h                                 |   11 
 drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml         |   11 
 drivers/gpu/drm/nouveau/nouveau_svm.c                         |    9 
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c               |    2 
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c              |    8 
 drivers/gpu/drm/xe/display/ext/i915_irq.c                     |   13 
 drivers/gpu/drm/xe/xe_device.c                                |    4 
 drivers/gpu/drm/xe/xe_device.h                                |    3 
 drivers/gpu/drm/xe/xe_device_types.h                          |    8 
 drivers/gpu/drm/xe/xe_irq.c                                   |  290 ++
 drivers/gpu/drm/xe/xe_irq.h                                   |    3 
 drivers/hv/vmbus_drv.c                                        |   17 
 drivers/irqchip/irq-gic-v3.c                                  |   53 
 drivers/irqchip/irq-jcore-aic.c                               |    2 
 drivers/md/raid0.c                                            |    4 
 drivers/md/raid1.c                                            |    4 
 drivers/md/raid10.c                                           |    4 
 drivers/mtd/nand/raw/cadence-nand-controller.c                |   42 
 drivers/mtd/spi-nor/sst.c                                     |    2 
 drivers/net/ethernet/google/gve/gve.h                         |   10 
 drivers/net/ethernet/google/gve/gve_main.c                    |    6 
 drivers/net/ethernet/ibm/ibmvnic.c                            |    4 
 drivers/net/ethernet/netronome/nfp/bpf/cmsg.c                 |    2 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c             |    1 
 drivers/net/geneve.c                                          |   16 
 drivers/net/gtp.c                                             |    5 
 drivers/net/pse-pd/pd692x0.c                                  |   45 
 drivers/net/pse-pd/pse_core.c                                 |   94 
 drivers/nvme/host/ioctl.c                                     |    3 
 drivers/nvme/host/tcp.c                                       |    7 
 drivers/nvme/target/core.c                                    |   40 
 drivers/pci/devres.c                                          |   58 
 drivers/pci/pci.c                                             |   16 
 drivers/platform/cznic/Kconfig                                |    1 
 drivers/power/supply/axp20x_battery.c                         |   31 
 drivers/power/supply/da9150-fg.c                              |    4 
 drivers/s390/net/ism_drv.c                                    |   14 
 drivers/soc/loongson/loongson2_guts.c                         |    5 
 drivers/tee/optee/supp.c                                      |   35 
 drivers/tty/serial/sh-sci.c                                   |   68 
 drivers/usb/gadget/function/f_midi.c                          |    2 
 fs/btrfs/extent_io.c                                          |  102 
 fs/btrfs/inode.c                                              |    3 
 fs/smb/client/inode.c                                         |    4 
 fs/smb/client/smb2ops.c                                       |    4 
 fs/xfs/scrub/common.h                                         |    5 
 fs/xfs/scrub/repair.h                                         |   11 
 fs/xfs/scrub/scrub.c                                          |   12 
 include/linux/mm_types.h                                      |    7 
 include/linux/netdevice.h                                     |    2 
 include/linux/pci.h                                           |    1 
 include/linux/pse-pd/pse.h                                    |   16 
 include/net/gro.h                                             |    3 
 include/net/tcp.h                                             |   14 
 io_uring/io_uring.c                                           |    2 
 io_uring/rw.c                                                 |   13 
 kernel/acct.c                                                 |  134 -
 kernel/bpf/arena.c                                            |    2 
 kernel/bpf/bpf_cgrp_storage.c                                 |    2 
 kernel/bpf/btf.c                                              |    2 
 kernel/bpf/ringbuf.c                                          |    4 
 kernel/bpf/syscall.c                                          |   43 
 kernel/sched/sched.h                                          |   25 
 kernel/trace/ftrace.c                                         |   36 
 kernel/trace/trace.c                                          |  277 --
 kernel/trace/trace_functions.c                                |    6 
 lib/iov_iter.c                                                |    3 
 mm/madvise.c                                                  |   11 
 mm/migrate_device.c                                           |   13 
 mm/zswap.c                                                    |   35 
 net/bpf/test_run.c                                            |    5 
 net/core/dev.c                                                |   37 
 net/core/drop_monitor.c                                       |   29 
 net/core/flow_dissector.c                                     |   49 
 net/core/gro.c                                                |    3 
 net/core/skbuff.c                                             |   10 
 net/core/sock_map.c                                           |    8 
 net/ipv4/arp.c                                                |    2 
 net/ipv4/tcp_fastopen.c                                       |    4 
 net/ipv4/tcp_input.c                                          |   20 
 net/ipv4/tcp_ipv4.c                                           |    2 
 net/sched/cls_api.c                                           |    2 
 net/vmw_vsock/af_vsock.c                                      |    3 
 net/vmw_vsock/virtio_transport.c                              |   10 
 net/vmw_vsock/vsock_bpf.c                                     |    2 
 rust/ffi.rs                                                   |   37 
 rust/kernel/device.rs                                         |    4 
 rust/kernel/error.rs                                          |    5 
 rust/kernel/firmware.rs                                       |    2 
 rust/kernel/miscdevice.rs                                     |   12 
 rust/kernel/print.rs                                          |    4 
 rust/kernel/security.rs                                       |    2 
 rust/kernel/seq_file.rs                                       |    2 
 rust/kernel/str.rs                                            |    6 
 rust/kernel/uaccess.rs                                        |   27 
 samples/rust/rust_print_main.rs                               |    2 
 sound/core/seq/seq_clientmgr.c                                |   12 
 sound/pci/hda/hda_codec.c                                     |    4 
 sound/pci/hda/patch_conexant.c                                |    1 
 sound/pci/hda/patch_cs8409-tables.c                           |    6 
 sound/pci/hda/patch_cs8409.c                                  |   20 
 sound/pci/hda/patch_cs8409.h                                  |    5 
 sound/pci/hda/patch_realtek.c                                 |    1 
 sound/soc/fsl/fsl_micfil.c                                    |    2 
 sound/soc/fsl/imx-audmix.c                                    |   31 
 sound/soc/rockchip/rockchip_i2s_tdm.c                         |    4 
 sound/soc/sof/ipc4-topology.c                                 |   12 
 sound/soc/sof/pcm.c                                           |    2 
 sound/soc/sof/stream-ipc.c                                    |    6 
 161 files changed, 3023 insertions(+), 1280 deletions(-)

Aaron Kling (1):
      drm/nouveau/pmu: Fix gp10b firmware guard

Abel Wu (1):
      bpf: Fix deadlock when freeing cgroup storage

Abhinav Kumar (1):
      drm/msm/dp: account for widebus and yuv420 during mode validation

Alan Maguire (1):
      bpf: Fix softlockup in arena_map_free on 64k page kernel

Alex Deucher (2):
      drm/amdgpu/gfx9: manually control gfxoff for CS on RV
      drm/amdgpu: bump version for RV/PCO compute fix

Alexander Shiyan (1):
      arm64: dts: rockchip: Fix broken tsadc pinctrl names for rk3588

Amit Kumar Mahapatra (1):
      mtd: spi-nor: sst: Fix SST write failure

Andrey Vatoropin (1):
      power: supply: da9150-fg: fix potential overflow

Andrii Nakryiko (2):
      bpf: unify VM_WRITE vs VM_MAYWRITE use in BPF map mmaping logic
      bpf: avoid holding freeze_mutex during mmap operation

Andy Yan (1):
      arm64: dts: rockchip: Fix lcdpwr_en pin for Cool Pi GenBook

Arnd Bergmann (1):
      drm: select DRM_KMS_HELPER from DRM_GEM_SHMEM_HELPER

Artur Rojek (1):
      irqchip/jcore-aic, clocksource/drivers/jcore: Fix jcore-pit interrupt request

Bart Van Assche (1):
      md/raid*: Fix the set_queue_limits implementations

Bartosz Golaszewski (1):
      gpiolib: protect gpio_chip with SRCU in array_info paths in multi get/set

Breno Leitao (2):
      net: Add non-RCU dev_getbyhwaddr() helper
      arp: switch to dev_getbyhwaddr() in arp_req_set_public()

Caleb Sander Mateos (2):
      nvme-tcp: fix connect failure on receiving partial ICResp PDU
      nvme/ioctl: add missing space in err message

Charlene Liu (1):
      drm/amd/display: update dcn351 used clock offset

Cheng Jiang (1):
      Bluetooth: qca: Update firmware-name to support board specific nvm

Chris Morgan (1):
      power: supply: axp20x_battery: Fix fault handling for AXP717

Christian Brauner (2):
      acct: perform last write from workqueue
      acct: block access to kernel internal filesystems

Christophe Leroy (3):
      powerpc/code-patching: Disable KASAN report during patching via temporary mm
      powerpc/64s: Rewrite __real_pte() and __rpte_to_hidx() as static inline
      powerpc/code-patching: Fix KASAN hit by not flagging text patching area as VM_ALLOC

Claudiu Beznea (3):
      serial: sh-sci: Move runtime PM enable to sci_probe_single()
      serial: sh-sci: Clean sci_ports[0] after at earlycon exit
      serial: sh-sci: Increment the runtime usage counter for the earlycon device

Cong Wang (2):
      flow_dissector: Fix handling of mixed port and port-range keys
      flow_dissector: Fix port range key handling in BPF conversion

Damien Le Moal (1):
      nvme: tcp: Fix compilation warning with W=1

Darrick J. Wong (1):
      xfs: fix online repair probing when CONFIG_XFS_ONLINE_REPAIR=n

David Hildenbrand (2):
      nouveau/svm: fix missing folio unlock + put after make_device_exclusive_range()
      mm/migrate_device: don't add folio to be freed to LRU in migrate_device_finalize()

David Sterba (1):
      btrfs: use btrfs_inode in extent_writepage()

Dmitry Baryshkov (2):
      drm/msm/dpu: skip watchdog timer programming through TOP on >= SM8450
      drm/msm/dpu: enable DPU_WB_INPUT_CTRL for DPU 5.x

Gary Guo (2):
      rust: map `long` to `isize` and `char` to `u8`
      rust: cleanup unnecessary casts

Gavrilov Ilia (1):
      drop_monitor: fix incorrect initialization order

Geert Uytterhoeven (2):
      firmware: imx: IMX_SCMI_MISC_DRV should depend on ARCH_MXC
      platform: cznic: CZNIC_PLATFORMS should depend on ARCH_MVEBU

Greg Kroah-Hartman (1):
      Linux 6.13.5

Hannes Reinecke (1):
      nvmet: Fix crash when a namespace is disabled

Haoxiang Li (3):
      soc: loongson: loongson2_guts: Add check for devm_kstrdup()
      nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
      smb: client: Add check for next_buffer in receive_encrypted_standard()

Heiko Carstens (1):
      s390/boot: Fix ESSA detection

Heiko Stuebner (1):
      arm64: dts: rockchip: fix fixed-regulator renames on rk3399-gru devices

Hugo Villeneuve (1):
      drm: panel: jd9365da-h3: fix reset signal polarity

Hyeonggon Yoo (1):
      mm/zswap: fix inconsistency when zswap_store_page() fails

Ilia Levi (2):
      drm/xe: Make irq enabled flag atomic
      drm/xe/irq: Separate MSI and MSI-X flows

Imre Deak (3):
      drm/i915/dp: Fix error handling during 128b/132b link training
      drm/i915/ddi: Fix HDMI port width programming in DDI_BUF_CTL
      drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro

Jakub Kicinski (1):
      tcp: adjust rcvq_space after updating scaling ratio

Jay Cornwall (1):
      drm/amdkfd: Move gfx12 trap handler to separate file

Jessica Zhang (1):
      drm/msm/dpu: Disable dither in phys encoder cleanup

Jiayuan Chen (1):
      bpf: Disable non stream socket for strparser

Jill Donahue (1):
      USB: gadget: f_midi: f_midi_complete to call queue_work

Johan Korsnes (1):
      gpio: vf610: add locking to gpio direction functions

John Keeping (1):
      ASoC: rockchip: i2s-tdm: fix shift config for SND_SOC_DAIFMT_DSP_[AB]

John Starks (1):
      Drivers: hv: vmbus: Log on missing offers if any

John Veness (1):
      ALSA: hda/conexant: Add quirk for HP ProBook 450 G4 mute LED

Joshua Washington (1):
      gve: set xdp redirect target only when it is available

Julian Ruess (1):
      s390/ism: add release function for struct device

Junnan Wu (1):
      vsock/virtio: fix variables initialization during resuming

Kailang Yang (1):
      ALSA: hda/realtek: Fixup ALC225 depop procedure

Kan Liang (1):
      perf/x86/intel: Fix event constraints for LNC

Komal Bajaj (1):
      EDAC/qcom: Correct interrupt enable register configuration

Kory Maincent (4):
      net: pse-pd: Avoid setting max_uA in regulator constraints
      net: pse-pd: Use power limit at driver side instead of current limit
      net: pse-pd: pd692x0: Fix power limit retrieval
      net: pse-pd: Fix deadlock in current limit functions

Krzysztof Karas (1):
      drm/i915/gt: Use spin_lock_irqsave() in interruptible context

Krzysztof Kozlowski (3):
      drm/msm/dsi/phy: Protect PHY_CMN_CLK_CFG0 updated from driver side
      drm/msm/dsi/phy: Protect PHY_CMN_CLK_CFG1 against clock driver
      drm/msm/dsi/phy: Do not overwite PHY_CMN_CLK_CFG1 when choosing bitclk source

Kuniyuki Iwashima (4):
      geneve: Fix use-after-free in geneve_find_dev().
      gtp: Suppress list corruption splat in gtp_net_exit_batch_rtnl().
      geneve: Suppress list corruption splat in geneve_destroy_tunnels().
      net: Add rx_skb of kfree_skb to raw_tp_null_args[].

Lancelot SIX (1):
      drm/amdkfd: Ensure consistent barrier state saved in gfx12 trap handler

Lucas De Marchi (1):
      drm/xe: Fix error handling in xe_irq_install()

Lukasz Czechowski (2):
      arm64: dts: rockchip: Move uart5 pin configuration to px30 ringneck SoM
      arm64: dts: rockchip: Disable DMA for uart5 on px30-ringneck

Marc Zyngier (1):
      irqchip/gic-v3: Fix rk3399 workaround when secure interrupts are enabled

Marijn Suijten (1):
      drm/msm/dpu: Don't leak bits_per_component into random DSC_ENC fields

Mathieu Desnoyers (1):
      sched: Compact RSEQ concurrency IDs with reduced threads and affinity

Michal Luczaj (2):
      sockmap, vsock: For connectible sockets allow only connected
      vsock/bpf: Warn on socket without transport

Miguel Ojeda (1):
      rust: finish using custom FFI integer types

Nick Child (1):
      ibmvnic: Don't reference skb after sending to VIOS

Nick Hu (1):
      net: axienet: Set mac_managed_pm

Nikita Zhandarovich (1):
      ASoC: fsl_micfil: Enable default case in micfil_set_quality()

Niravkumar L Rabara (3):
      mtd: rawnand: cadence: fix error code in cadence_nand_init()
      mtd: rawnand: cadence: use dma_map_resource for sdma address
      mtd: rawnand: cadence: fix incorrect device in dma_unmap_single

Paolo Abeni (1):
      net: allow small head cache usage with large MAX_SKB_FRAGS values

Patrick Wildt (1):
      arm64: dts: rockchip: adjust SMMU interrupt type on rk3588

Paulo Alcantara (1):
      smb: client: fix chmod(2) regression with ATTR_READONLY

Pavel Begunkov (3):
      io_uring/rw: forbid multishot async reads
      io_uring: prevent opcode speculation
      lib/iov_iter: fix import_iovec_ubuf iovec management

Peng Fan (1):
      firmware: arm_scmi: imx: Correct tx size of scmi_imx_misc_ctrl_set

Peter Ujfalusi (3):
      ASoC: SOF: ipc4-topology: Harden loops for looking up ALH copiers
      ASoC: SOF: stream-ipc: Check for cstream nullity in sof_ipc_msg_data()
      ASoC: SOF: pcm: Clear the susbstream pointer to NULL on close

Philipp Stanner (2):
      PCI: Export pci_intx_unmanaged() and pcim_intx()
      PCI: Remove devres from pci_intx()

Pierre Riteau (1):
      net/sched: cls_api: fix error handling causing NULL dereference

Qu Wenruo (2):
      btrfs: fix double accounting race when btrfs_run_delalloc_range() failed
      btrfs: fix double accounting race when extent_writepage_io() failed

Ricardo Cañuelo Navarro (1):
      mm,madvise,hugetlb: check for 0-length range after end address adjustment

Rob Clark (1):
      drm/msm: Avoid rounding up to one jiffy

Sabrina Dubroca (1):
      tcp: drop secpath at the same time as we currently drop dst

Sebastian Andrzej Siewior (1):
      ftrace: Correct preemption accounting for function tracing.

Shengjiu Wang (1):
      ASoC: imx-audmix: remove cpu_mclk which is from cpu dai device

Shigeru Yoshida (1):
      bpf, test_run: Fix use-after-free issue in eth_skb_pkt_type()

Steven Rostedt (5):
      tracing: Switch trace.c code over to use guard()
      tracing: Have the error of __tracing_resize_ring_buffer() passed to user
      ftrace: Fix accounting of adding subops to a manager ops
      ftrace: Do not add duplicate entries in subops manager ops
      tracing: Fix using ret variable in tracing_set_tracer()

Sumit Garg (1):
      tee: optee: Fix supplicant wait loop

Takashi Iwai (2):
      PCI: Restore original INTX_DISABLE bit by pcim_intx()
      ALSA: seq: Drop UMP events when no UMP-conversion is set

Tianling Shen (1):
      arm64: dts: rockchip: change eth phy mode to rgmii-id for orangepi r1 plus lts

Ville Syrjälä (1):
      drm/i915: Make sure all planes in use by the joiner have their crtc included

Vitaly Rodionov (1):
      ALSA: hda/cirrus: Correct the full scale volume set logic

Wentao Liang (1):
      ALSA: hda: Add error check for snd_ctl_rename_id() in snd_hda_create_dig_out_ctls()

Yan Zhai (1):
      bpf: skip non exist keys in generic_map_lookup_batch

Zijun Hu (1):
      Bluetooth: qca: Fix poor RF performance for WCN6855

loanchen (1):
      drm/amd/display: Correct register address in dcn35


