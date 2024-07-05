Return-Path: <stable+bounces-58120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8C592830F
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 09:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752BA289A6B
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E73145355;
	Fri,  5 Jul 2024 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vkywUmOA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4EA145B10;
	Fri,  5 Jul 2024 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165480; cv=none; b=cvsQYEeX0YLUU5YVUIXE/iCm3ImiPy6Ip9piqKapLs0jZW+Z3CRMA+HbgP0lO9UJJPOdnMM+bX5BN9lZ7I1ekPrH/eMx0meudsGblgZGDTRiabEOjIr2Zy/K7sfQBhOH7dL5kO1YZ5yvqnJMvxXzUfuT2nX0bNlvlQCipMkwhms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165480; c=relaxed/simple;
	bh=EEYAXMrvdvkvcPSN6QM521g6l0JFpyAaqdokJloJqLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fyd/HjiSTL1mAk6Vd04JC/WfYlSdokv+jwDuVfzpPu/p0jevJRmwG0UuEXj5lSYDkcwOoLzUFqdmgmy+SYY3ruHqgcFZk+XUyBJ7tkmMvH6oWq8ptuALufsZG9Cw3vF+J0DY8EU3KAEOYx4ynZd4pseZmb+iC3JcaRtRbcDI0OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vkywUmOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8A7C32786;
	Fri,  5 Jul 2024 07:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720165480;
	bh=EEYAXMrvdvkvcPSN6QM521g6l0JFpyAaqdokJloJqLc=;
	h=From:To:Cc:Subject:Date:From;
	b=vkywUmOAfaphpk3TUdwoGgevppy1v/7PnK35kUecpqwbGyUeKS5qI4z3iolcRgzYv
	 kVSwsSTbyMYWvBpyp4FjhH88NkXEp4p909SmfsZADbo58V7fujxi/RscoNP9CSi76H
	 JzKxcvsHx74/MQDMCyehp3SGL5EujCRPQoSaXjts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.9.8
Date: Fri,  5 Jul 2024 09:44:35 +0200
Message-ID: <2024070535-graph-crisping-553b@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.9.8 kernel.

All users of the 6.9 kernel series must upgrade.

The updated 6.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.9.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/kbuild/modules.rst                                   |    8 
 Makefile                                                           |    2 
 arch/arm/boot/dts/rockchip/rk3066a.dtsi                            |    1 
 arch/arm/net/bpf_jit_32.c                                          |   25 
 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts                  |   18 
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts                  |    4 
 arch/arm64/boot/dts/rockchip/rk3368.dtsi                           |    3 
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi                       |    2 
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts            |    1 
 arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts                |    1 
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts                    |    1 
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi                     |    5 
 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts                 |    4 
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts                   |    2 
 arch/arm64/include/asm/unistd32.h                                  |    2 
 arch/arm64/kernel/pi/map_kernel.c                                  |    2 
 arch/arm64/kernel/syscall.c                                        |   16 
 arch/csky/include/uapi/asm/unistd.h                                |    1 
 arch/hexagon/include/asm/syscalls.h                                |    6 
 arch/hexagon/include/uapi/asm/unistd.h                             |    1 
 arch/hexagon/kernel/syscalltab.c                                   |    7 
 arch/loongarch/net/bpf_jit.c                                       |   22 
 arch/mips/kernel/syscalls/syscall_n32.tbl                          |    2 
 arch/mips/kernel/syscalls/syscall_o32.tbl                          |    2 
 arch/mips/net/bpf_jit_comp.c                                       |    3 
 arch/parisc/Kconfig                                                |    1 
 arch/parisc/kernel/sys_parisc32.c                                  |    9 
 arch/parisc/kernel/syscalls/syscall.tbl                            |    6 
 arch/parisc/net/bpf_jit_core.c                                     |    8 
 arch/powerpc/kernel/syscalls/syscall.tbl                           |    6 
 arch/riscv/include/asm/insn.h                                      |    2 
 arch/riscv/kernel/stacktrace.c                                     |    2 
 arch/s390/include/asm/entry-common.h                               |    2 
 arch/s390/kernel/syscalls/syscall.tbl                              |    2 
 arch/s390/net/bpf_jit_comp.c                                       |    6 
 arch/s390/pci/pci_irq.c                                            |    2 
 arch/sh/kernel/sys_sh32.c                                          |   11 
 arch/sh/kernel/syscalls/syscall.tbl                                |    3 
 arch/sparc/kernel/sys32.S                                          |  221 ------
 arch/sparc/kernel/syscalls/syscall.tbl                             |    8 
 arch/sparc/net/bpf_jit_comp_64.c                                   |    6 
 arch/x86/entry/syscalls/syscall_32.tbl                             |    2 
 arch/x86/include/asm/entry-common.h                                |   15 
 arch/x86/kernel/fpu/core.c                                         |    4 
 arch/x86/kernel/time.c                                             |   20 
 arch/x86/net/bpf_jit_comp32.c                                      |    3 
 crypto/ecdh.c                                                      |    2 
 drivers/ata/ahci.c                                                 |   17 
 drivers/ata/libata-core.c                                          |   32 
 drivers/counter/ti-eqep.c                                          |    6 
 drivers/cpufreq/intel_pstate.c                                     |   13 
 drivers/cxl/core/core.h                                            |    7 
 drivers/cxl/core/hdm.c                                             |   13 
 drivers/cxl/core/memdev.c                                          |   44 -
 drivers/cxl/core/pmem.c                                            |   16 
 drivers/cxl/core/region.c                                          |  182 ++++-
 drivers/cxl/cxl.h                                                  |    6 
 drivers/cxl/cxlmem.h                                               |   10 
 drivers/cxl/mem.c                                                  |   17 
 drivers/gpio/gpio-davinci.c                                        |    5 
 drivers/gpio/gpiolib-cdev.c                                        |   28 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c                   |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                         |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c                           |   18 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c                   |    5 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c |   10 
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c     |    2 
 drivers/gpu/drm/amd/display/include/dpcd_defs.h                    |    5 
 drivers/gpu/drm/drm_fb_helper.c                                    |    6 
 drivers/gpu/drm/drm_fbdev_dma.c                                    |    5 
 drivers/gpu/drm/drm_file.c                                         |    8 
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c                       |    1 
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c                          |    6 
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c                      |    6 
 drivers/gpu/drm/panel/panel-simple.c                               |    1 
 drivers/gpu/drm/radeon/radeon.h                                    |    1 
 drivers/gpu/drm/radeon/radeon_display.c                            |    8 
 drivers/gpu/drm/xe/xe_devcoredump.c                                |   10 
 drivers/gpu/drm/xe/xe_pat.c                                        |    2 
 drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c                             |    5 
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c                               |    2 
 drivers/i2c/i2c-slave-testunit.c                                   |    5 
 drivers/iio/accel/Kconfig                                          |    2 
 drivers/iio/adc/ad7266.c                                           |    2 
 drivers/iio/adc/xilinx-ams.c                                       |    8 
 drivers/iio/chemical/bme680.h                                      |    2 
 drivers/iio/chemical/bme680_core.c                                 |   62 +
 drivers/iio/humidity/hdc3020.c                                     |  325 +++++++---
 drivers/infiniband/core/restrack.c                                 |   51 -
 drivers/input/touchscreen/ili210x.c                                |    4 
 drivers/iommu/amd/amd_iommu.h                                      |    1 
 drivers/iommu/amd/init.c                                           |    1 
 drivers/iommu/amd/iommu.c                                          |   34 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c                    |    3 
 drivers/irqchip/Kconfig                                            |    2 
 drivers/irqchip/irq-loongson-eiointc.c                             |    5 
 drivers/irqchip/irq-loongson-liointc.c                             |    4 
 drivers/media/dvb-core/dvbdev.c                                    |    2 
 drivers/mmc/host/moxart-mmc.c                                      |   78 +-
 drivers/mmc/host/sdhci-brcmstb.c                                   |    4 
 drivers/mmc/host/sdhci-pci-core.c                                  |   11 
 drivers/mmc/host/sdhci-pci-o2micro.c                               |   41 -
 drivers/mmc/host/sdhci.c                                           |   25 
 drivers/mtd/parsers/redboot.c                                      |    2 
 drivers/net/bonding/bond_main.c                                    |    3 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c                     |   14 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c                       |   55 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h                          |    5 
 drivers/net/dsa/microchip/ksz9477.c                                |   10 
 drivers/net/dsa/microchip/ksz9477_reg.h                            |    1 
 drivers/net/dsa/microchip/ksz_common.c                             |    2 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                   |   14 
 drivers/net/ethernet/ibm/ibmvnic.c                                 |    6 
 drivers/net/ethernet/intel/ice/ice_main.c                          |   10 
 drivers/net/ethernet/mellanox/mlxsw/pci.c                          |   18 
 drivers/net/ethernet/mellanox/mlxsw/reg.h                          |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c             |   20 
 drivers/net/ethernet/microsoft/mana/mana_en.c                      |    2 
 drivers/net/ethernet/pensando/ionic/ionic_dev.h                    |    4 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                    |    2 
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c                   |   55 +
 drivers/net/phy/micrel.c                                           |    1 
 drivers/net/phy/sfp.c                                              |   18 
 drivers/net/usb/ax88179_178a.c                                     |    6 
 drivers/net/vxlan/vxlan_core.c                                     |    9 
 drivers/net/wireless/realtek/rtw89/fw.c                            |   27 
 drivers/nvme/target/configfs.c                                     |   41 -
 drivers/nvme/target/fc.c                                           |    2 
 drivers/pci/msi/msi.c                                              |   10 
 drivers/pinctrl/core.c                                             |    2 
 drivers/pinctrl/pinctrl-rockchip.c                                 |   68 +-
 drivers/pinctrl/pinctrl-rockchip.h                                 |    1 
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                           |    1 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                            |    4 
 drivers/pwm/pwm-stm32.c                                            |   62 +
 drivers/reset/Kconfig                                              |    1 
 drivers/s390/virtio/virtio_ccw.c                                   |    4 
 drivers/scsi/libsas/sas_ata.c                                      |    6 
 drivers/scsi/libsas/sas_discover.c                                 |    2 
 drivers/soc/ti/wkup_m3_ipc.c                                       |    7 
 drivers/tty/mxser.c                                                |    2 
 drivers/tty/serial/8250/8250_omap.c                                |   22 
 drivers/tty/serial/8250/8250_pci.c                                 |   13 
 drivers/tty/serial/bcm63xx_uart.c                                  |    7 
 drivers/tty/serial/imx.c                                           |   10 
 drivers/tty/serial/mcf.c                                           |    2 
 drivers/usb/atm/cxacru.c                                           |   14 
 drivers/usb/dwc3/core.c                                            |   26 
 drivers/usb/gadget/function/f_printer.c                            |   40 -
 drivers/usb/gadget/function/u_ether.c                              |    4 
 drivers/usb/gadget/udc/aspeed_udc.c                                |    4 
 drivers/usb/musb/da8xx.c                                           |    8 
 drivers/usb/typec/ucsi/ucsi.c                                      |   55 -
 drivers/usb/typec/ucsi/ucsi_glink.c                                |    5 
 drivers/usb/typec/ucsi/ucsi_stm32g0.c                              |   19 
 drivers/vdpa/vdpa_user/vduse_dev.c                                 |   14 
 fs/bcachefs/bcachefs.h                                             |   44 -
 fs/bcachefs/btree_gc.c                                             |   15 
 fs/bcachefs/btree_gc.h                                             |   48 -
 fs/bcachefs/btree_gc_types.h                                       |   29 
 fs/bcachefs/ec.c                                                   |    2 
 fs/bcachefs/sb-downgrade.c                                         |   17 
 fs/bcachefs/super-io.c                                             |   12 
 fs/btrfs/free-space-cache.c                                        |    2 
 fs/btrfs/tree-log.c                                                |   43 -
 fs/gfs2/log.c                                                      |    3 
 fs/gfs2/super.c                                                    |    4 
 fs/netfs/buffered_write.c                                          |   12 
 fs/nfs/direct.c                                                    |    2 
 fs/nfsd/nfsctl.c                                                   |    2 
 fs/nfsd/nfssvc.c                                                   |    1 
 fs/ocfs2/aops.c                                                    |    5 
 fs/ocfs2/journal.c                                                 |   17 
 fs/ocfs2/journal.h                                                 |    2 
 fs/ocfs2/ocfs2_trace.h                                             |    2 
 fs/open.c                                                          |    4 
 include/linux/compat.h                                             |    2 
 include/linux/filter.h                                             |   10 
 include/linux/ieee80211.h                                          |    2 
 include/linux/libata.h                                             |    1 
 include/linux/mmzone.h                                             |    9 
 include/linux/nvme.h                                               |    6 
 include/linux/serial_core.h                                        |   21 
 include/linux/syscalls.h                                           |    8 
 include/linux/workqueue.h                                          |    2 
 include/net/inet_connection_sock.h                                 |    2 
 include/net/netfilter/nf_tables.h                                  |    5 
 include/trace/events/qdisc.h                                       |    4 
 include/uapi/asm-generic/unistd.h                                  |    2 
 io_uring/io_uring.c                                                |    4 
 kernel/bpf/arena.c                                                 |   16 
 kernel/bpf/core.c                                                  |    6 
 kernel/bpf/ringbuf.c                                               |   31 
 kernel/bpf/verifier.c                                              |   69 +-
 kernel/cpu.c                                                       |   11 
 kernel/sys_ni.c                                                    |    2 
 mm/kasan/common.c                                                  |    2 
 mm/memory.c                                                        |    3 
 mm/page_alloc.c                                                    |    9 
 mm/vmalloc.c                                                       |   21 
 net/batman-adv/originator.c                                        |   27 
 net/can/j1939/main.c                                               |    6 
 net/can/j1939/transport.c                                          |   21 
 net/core/filter.c                                                  |    3 
 net/core/xdp.c                                                     |    4 
 net/dccp/ipv4.c                                                    |    7 
 net/dccp/ipv6.c                                                    |    7 
 net/ipv4/inet_connection_sock.c                                    |   17 
 net/ipv4/tcp_input.c                                               |   45 +
 net/iucv/iucv.c                                                    |   26 
 net/netfilter/nf_hooks_lwtunnel.c                                  |    3 
 net/netfilter/nf_tables_api.c                                      |    8 
 net/netfilter/nft_lookup.c                                         |    3 
 net/openvswitch/conntrack.c                                        |    7 
 net/sunrpc/svc.c                                                   |    5 
 net/unix/af_unix.c                                                 |   37 -
 scripts/Makefile.dtbinst                                           |    2 
 scripts/Makefile.package                                           |    2 
 scripts/package/kernel.spec                                        |    8 
 security/integrity/evm/evm_main.c                                  |   12 
 sound/core/seq/seq_ump_convert.c                                   |   10 
 sound/pci/hda/patch_realtek.c                                      |    3 
 sound/soc/amd/acp/acp-i2s.c                                        |    8 
 sound/soc/amd/acp/acp-pci.c                                        |   12 
 sound/soc/atmel/atmel-classd.c                                     |    7 
 sound/soc/codecs/cs42l43-jack.c                                    |    4 
 sound/soc/fsl/fsl-asoc-card.c                                      |    3 
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c                 |   10 
 sound/soc/mediatek/mt8195/mt8195-mt6359.c                          |    1 
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c                            |   32 
 sound/soc/rockchip/rockchip_i2s_tdm.c                              |   13 
 sound/synth/emux/soundfont.c                                       |   17 
 tools/power/x86/turbostat/turbostat.c                              |    2 
 tools/testing/cxl/test/cxl.c                                       |    4 
 234 files changed, 2108 insertions(+), 1184 deletions(-)

Adrian Hunter (2):
      mmc: sdhci: Do not invert write-protect twice
      mmc: sdhci: Do not lock spinlock around mmc_gpio_get_ro()

Aleksandr Mishin (1):
      gpio: davinci: Validate the obtained number of IRQs

Alex Bee (1):
      arm64: dts: rockchip: Add sound-dai-cells for RK3368

Alex Deucher (1):
      drm/amdgpu/atomfirmware: fix parsing of vram_info

Alexander Sverdlin (1):
      iio: accel: fxls8962af: select IIO_BUFFER & IIO_KFIFO_BUF

Alexei Starovoitov (3):
      bpf: Fix remap of arena.
      bpf: Fix the corner case with may_goto and jump to the 1st insn.
      bpf: Fix may_goto with negative offset.

Alibek Omarov (1):
      ASoC: rockchip: i2s-tdm: Fix trcm mode by setting clock on right mclk

Alison Schofield (2):
      cxl/region: Move cxl_dpa_to_region() work to the region driver
      cxl/region: Avoid null pointer dereference in region lookup

Andreas Gruenbacher (1):
      gfs2: Fix NULL pointer dereference in gfs2_log_flush

Andrei Simion (1):
      ASoC: atmel: atmel-classd: Re-add dai_link->platform to fix card init

Andrew Bresticker (1):
      mm/memory: don't require head page for do_set_pmd()

Andrew Davis (1):
      soc: ti: wkup_m3_ipc: Send NULL dummy message instead of pointer message

Andrey Konovalov (1):
      kasan: fix bad call to unpoison_slab_object

Andy Chiu (1):
      riscv: stacktrace: convert arch_stack_walk() to noinstr

Andy Yan (1):
      arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi 4B

Anton Protopopov (1):
      bpf: Add a check for struct bpf_fib_lookup size

Arnd Bergmann (11):
      sparc: fix old compat_sys_select()
      sparc: fix compat recv/recvfrom syscalls
      parisc: use correct compat recv/recvfrom syscalls
      powerpc: restore some missing spu syscalls
      parisc: use generic sys_fanotify_mark implementation
      sh: rework sync_file_range ABI
      csky, hexagon: fix broken sys_sync_file_range
      hexagon: fix fadvise64_64 calling conventions
      ftruncate: pass a signed offset
      syscalls: fix compat_sys_io_pgetevents_time64 usage
      syscalls: fix sys_fanotify_mark prototype

Chen-Yu Tsai (1):
      ASoC: mediatek: mt8195: Add platform entry for ETDM1_OUT_BE dai link

Chia-Yuan Li (1):
      wifi: rtw89: download firmware with five times retry

Christian A. Ehrhardt (1):
      usb: typec: ucsi: Never send a lone connector change ack

Christoph Hellwig (1):
      nfs: drop the incorrect assertion in nfs_swap_rw()

Christophe Leroy (2):
      bpf: Take return from set_memory_ro() into account with bpf_prog_lock_ro()
      bpf: Take return from set_memory_rox() into account with bpf_jit_binary_lock_ro()

Chuck Lever (1):
      SUNRPC: Fix backchannel reply, again

Claudiu Beznea (1):
      pinctrl: renesas: rzg2l: Use spin_{lock,unlock}_irq{save,restore}

Crescent Hsieh (1):
      tty: serial: 8250: Fix port count mismatch with the device

Dan Carpenter (1):
      usb: musb: da8xx: fix a resource leak in probe()

Dan Williams (1):
      cxl/region: Convert cxl_pmem_region_alloc to scope-based resource management

Daniel Borkmann (1):
      bpf: Fix overrunning reservations in ringbuf

Daniil Dulov (1):
      xdp: Remove WARN() from __xdp_reg_mem_model()

David Arcari (1):
      tools/power turbostat: option '-n' is ambiguous

David Howells (2):
      netfs: Fix netfs_page_mkwrite() to check folio->mapping is valid
      netfs: Fix netfs_page_mkwrite() to flush conflicting data, not wait

David Lechner (1):
      counter: ti-eqep: enable clock at probe

Dawei Li (2):
      net/iucv: Avoid explicit cpumask var allocation on stack
      net/dpaa2: Avoid explicit cpumask var allocation on stack

Denis Arefev (1):
      mtd: partitions: redboot: Added conversion of operands to a larger type

Dimitri Fedrau (1):
      iio: humidity: hdc3020: fix hysteresis representation

Dirk Su (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for EliteBook 645/665 G11.

Doug Brown (1):
      Revert "serial: core: only stop transmit when HW fifo is empty"

Dragan Simic (1):
      kbuild: Install dtb files as 0644 in Makefile.dtbinst

Elinor Montmasson (1):
      ASoC: fsl-asoc-card: set priv->pdev before using it

Enguerrand de Ribaucourt (2):
      net: phy: micrel: add Microchip KSZ 9477 to the device table
      net: dsa: microchip: use collision based back pressure mode

Erick Archer (1):
      drm/radeon/radeon_display: Decrease the size of allocated memory

FUKAUMI Naoki (3):
      Revert "arm64: dts: rockchip: remove redundant cd-gpios from rk3588 sdmmc nodes"
      arm64: dts: rockchip: make poweroff(8) work on Radxa ROCK 5A
      arm64: dts: rockchip: fix PMIC interrupt pin on ROCK Pi E

Fabrice Gasnier (1):
      usb: ucsi: stm32: fix command completion handling

Fernando Yang (1):
      iio: adc: ad7266: Fix variable checking bug

Ferry Toth (2):
      Revert "usb: gadget: u_ether: Re-attach netif device to mirror detachment"
      Revert "usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach"

Filipe Manana (1):
      btrfs: use NOFS context when getting inodes during logging and log replay

Greg Kroah-Hartman (2):
      Revert "net: sfp: enhance quirk for Fibrestore 2.5G copper SFP module"
      Linux 6.9.8

Guillaume Nault (1):
      vxlan: Pull inner IP header in vxlan_xmit_one().

Hagar Hemdan (1):
      pinctrl: fix deadlock in create_pinctrl() when handling -EPROBE_DEFER

Halil Pasic (1):
      s390/virtio_ccw: Fix config change notifications

Hangbin Liu (1):
      bonding: fix incorrect software timestamping report

Hannes Reinecke (3):
      nvmet: do not return 'reserved' for empty TSAS values
      nvme: fixup comment for nvme RDMA Provider Type
      nvmet: make 'tsas' attribute idempotent for RDMA

Heikki Krogerus (1):
      usb: typec: ucsi: Ack also failed Get Error commands

Heiko Stuebner (1):
      arm64: dts: rockchip: set correct pwm0 pinctrl on rk3588-tiger

Himal Prasad Ghimiray (1):
      drm/xe/xe_devcoredump: Check NULL before assignments

Hsin-Te Yuan (2):
      ASoC: mediatek: mt8183-da7219-max98357: Fix kcontrol name collision
      arm64: dts: rockchip: Fix the value of `dlg,jack-det-rate` mismatch on rk3399-gru

Huacai Chen (3):
      irqchip/loongson-eiointc: Use early_cpu_to_node() instead of cpu_to_node()
      cpu: Fix broken cmdline "nosmp" and "maxcpus=0"
      irqchip/loongson-liointc: Set different ISRs for different cores

Huang-Huang Bao (4):
      pinctrl: rockchip: fix pinmux bits for RK3328 GPIO2-B pins
      pinctrl: rockchip: fix pinmux bits for RK3328 GPIO3-B pins
      pinctrl: rockchip: use dedicated pinctrl type for RK3328
      pinctrl: rockchip: fix pinmux reset in rockchip_pmx_set

Ido Schimmel (2):
      mlxsw: pci: Fix driver initialization with Spectrum-4
      mlxsw: spectrum_buffers: Fix memory corruptions on Spectrum-4 systems

Ilpo Järvinen (2):
      mmc: sdhci-pci-o2micro: Convert PCIBIOS_* return codes to errnos
      mmc: sdhci-pci: Convert PCIBIOS_* return codes to errnos

Jan Kara (1):
      ocfs2: fix DIO failure due to insufficient transaction credits

Jan Sokolowski (1):
      ice: Rebuild TC queues on VSI queue reconfiguration

Jann Horn (1):
      drm/drm_file: Fix pid refcounting race

Janusz Krzysztofik (1):
      drm/i915/gt: Fix potential UAF by revoke of fence registers

Jason Gunthorpe (1):
      iommu/arm-smmu-v3: Do not allow a SVA domain to be set on the wrong PASID

Javier Carrasco (1):
      usb: typec: ucsi: glink: fix child node release in probe function

Jean-Michel Hautbois (1):
      tty: mcf: MCF54418 has 10 UARTS

Jens Axboe (1):
      io_uring: signal SQPOLL task_work with TWA_SIGNAL_NO_IPI

Jeremy Kerr (1):
      usb: gadget: aspeed_udc: fix device address configuration

Jesse Taube (1):
      RISC-V: fix vector insn load/store width mask

Jianguo Wu (1):
      netfilter: fix undefined reference to 'netfilter_lwtunnel_*' when CONFIG_SYSCTL=n

Joachim Vandersmissen (1):
      crypto: ecdh - explicitly zeroize private_key

Johan Hovold (1):
      pinctrl: qcom: spmi-gpio: drop broken pm8008 support

Johan Jonker (1):
      ARM: dts: rockchip: rk3066a: add #sound-dai-cells to hdmi node

Johannes Berg (1):
      wifi: ieee80211: check for NULL in ieee80211_mle_size_ok()

John Keeping (1):
      Input: ili210x - fix ili251x_read_touch_data() return value

Jonas Gorski (2):
      serial: core: introduce uart_port_tx_limited_flags()
      serial: bcm63xx-uart: fix tx after conversion to uart_port_tx_limited()

Jonas Karlman (2):
      arm64: dts: rockchip: Fix SD NAND and eMMC init on rk3308-rock-pi-s
      arm64: dts: rockchip: Rename LED related pinctrl nodes on rk3308-rock-pi-s

Jos Wang (1):
      usb: dwc3: core: Workaround for CSR read timeout

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: improve link status logs

Julia Zhang (1):
      drm/amdgpu: avoid using null object of framebuffer

Kamal Dasu (1):
      mmc: sdhci-brcmstb: check R1_STATUS for erase/trim/discard

Kees Cook (1):
      randomize_kstack: Remove non-functional per-arch entropy filtering

Kent Gibson (2):
      gpiolib: cdev: Disallow reconfiguration without direction (uAPI v1)
      gpiolib: cdev: Ignore reconfiguration without direction

Kent Overstreet (5):
      bcachefs: Fix sb_field_downgrade validation
      bcachefs: Fix sb-downgrade validation
      bcachefs: Fix bch2_sb_downgrade_update()
      bcachefs: Fix setting of downgrade recovery passes/errors
      bcachefs: btree_gc can now handle unknown btrees

Kuniyuki Iwashima (4):
      af_unix: Stop recv(MSG_PEEK) at consumed OOB skb.
      af_unix: Don't stop recv(MSG_DONTWAIT) if consumed OOB skb is at the head.
      af_unix: Don't stop recv() at consumed ex-OOB skb.
      af_unix: Fix wrong ioctl(SIOCATMARK) when consumed OOB skb is at the head.

Laurent Pinchart (1):
      drm/panel: ilitek-ili9881c: Fix warning with GPIO controllers that sleep

Li Ming (1):
      cxl/mem: Fix no cxl_nvd during pmem region auto-assembling

Lijo Lazar (1):
      drm/amdgpu: Fix pci state save during mode-1 reset

Linus Torvalds (1):
      x86: stop playing stack games in profile_pc()

Linus Walleij (1):
      Revert "mmc: moxart-mmc: Use sg_miter for PIO"

Liu Ying (1):
      drm/panel: simple: Add missing display timing flags for KOE TX26D202VM0BWA

Ma Ke (3):
      net: mana: Fix possible double free in error handling path
      drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_ld_modes
      drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_hd_modes

Maciej Strozek (1):
      ASoC: cs42l43: Increase default type detect time and button delay

Mark Brown (1):
      reset: gpio: Fix missing gpiolib dependency for GPIO reset controller

Mark-PK Tsai (1):
      kbuild: doc: Update default INSTALL_MOD_DIR from extra to updates

Martin KaFai Lau (1):
      bpf: Mark bpf prog stack with kmsan_unposion_memory in interpreter mode

Martin Schiller (1):
      MIPS: pci: lantiq: restore reset gpio polarity

Masahiro Yamada (1):
      kbuild: rpm-pkg: fix build error with CONFIG_MODULES=n

Maxime Coquelin (2):
      vduse: validate block features only with block devices
      vduse: Temporarily fail if control queue feature requested

Meng Li (1):
      usb: dwc3: core: remove lock of otg mode during gadget suspend/resume to avoid deadlock

Michael Strauss (1):
      drm/amd/display: Send DP_TOTAL_LTTPR_CNT during detection if LTTPR is present

Michal Wajdeczko (1):
      drm/xe: Check pat.ops before dumping PAT settings

Mostafa Saleh (1):
      PCI/MSI: Fix UAF in msi_capability_init

Muhammad Ahmed (1):
      drm/amd/display: Skip pipe if the pipe idx not set properly

Naohiro Aota (1):
      btrfs: zoned: fix initial free space detection

Nathan Chancellor (2):
      tty: mxser: Remove __counted_by from mxser_board.ports[]
      nvmet-fc: Remove __counted_by from nvmet_fc_tgt_queue.fod[]

Neal Cardwell (1):
      tcp: fix tcp_rcv_fastopen_synack() to enter TCP_CA_Loss for failed TFO

NeilBrown (1):
      nfsd: initialise nfsd_info.mutex early.

Nick Child (1):
      ibmvnic: Free any outstanding tx skbs during scrq reset

Nikita Zhandarovich (1):
      usb: atm: cxacru: fix endpoint checking in cxacru_bind()

Niklas Cassel (5):
      ata: libata-core: Fix null pointer dereference on error
      ata,scsi: libata-core: Do not leak memory for ata_port struct members
      ata: ahci: Clean up sysfs file on error
      ata: libata-core: Add ATA_HORKAGE_NOLPM for all Crucial BX SSD1 models
      ata: libata-core: Fix double free on error

Niklas Schnelle (1):
      s390/pci: Add missing virt_to_phys() for directed DIBV

Nirmoy Das (2):
      drm/xe: Fix potential integer overflow in page size calculation
      drm/xe: Add a NULL check in xe_ttm_stolen_mgr_init

Oleksij Rempel (2):
      net: can: j1939: recover socket queue on CAN bus error during BAM transmission
      net: can: j1939: enhanced error handling for tightly received RTS messages in xtp_rx_rts_session_new

Oliver Neukum (2):
      usb: gadget: printer: SS+ support
      usb: gadget: printer: fix races against disable

Oswald Buddenhagen (1):
      ALSA: emux: improve patch ioctl data validation

Pablo Neira Ayuso (1):
      netfilter: nf_tables: fully validate NFT_DATA_VALUE on store to data registers

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Use HWP to initialize ITMT if CPPC is missing

Ricardo Ribalda (1):
      media: dvbdev: Initialize sbuf

Sean Anderson (1):
      iio: xilinx-ams: Don't include ams_ctrl_channels in scan_mask

Shannon Nelson (1):
      ionic: use dev_consume_skb_any outside of napi

Sherry Wang (1):
      drm/amd/display: correct hostvm flag

Shigeru Yoshida (1):
      net: can: j1939: Initialize unused data in j1939_send_one()

Srinivas Kandagatla (1):
      ASoC: q6apm-lpass-dai: close graph on prepare errors

Stefan Berger (1):
      evm: Enforce signatures on unsupported filesystem for EVM_INIT_X509

Stefan Eichenberger (2):
      serial: imx: set receiver level before starting uart
      serial: imx: only set receiver level if it is zero

Sven Eckelmann (1):
      batman-adv: Don't accept TT entries for out-of-spec VIDs

Taehee Yoo (1):
      ionic: fix kernel panic due to multi-buffer handling

Takashi Iwai (2):
      ALSA: seq: Fix missing channel at encoding RPN/NRPN MIDI2 messages
      ALSA: seq: Fix missing MSB in MIDI2 SPP conversion

Thayne Harbaugh (1):
      kbuild: Fix build target deb-pkg: ln: failed to create hard link

Thomas Bogendoerfer (1):
      Revert "MIPS: pci: lantiq: restore reset gpio polarity"

Thomas Zimmermann (1):
      drm/fbdev-dma: Only set smem_start is enable per module option

Tiezhu Yang (1):
      irqchip/loongson: Select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP for IRQ_LOONGARCH_CPU

Tristram Ha (2):
      net: dsa: microchip: fix initial port flush problem
      net: dsa: microchip: fix wrong register write when masking interrupt

Udit Kumar (2):
      serial: 8250_omap: Implementation of Errata i2310
      serial: 8250_omap: Fix Errata i2310 with RX FIFO level check

Uros Bizjak (1):
      x86/fpu: Fix AMD X86_BUG_FXSAVE_LEAK fixup

Uwe Kleine-König (6):
      pwm: stm32: Improve precision of calculation in .apply()
      pwm: stm32: Fix for settings using period > UINT32_MAX
      pwm: stm32: Calculate prescaler with a division instead of a loop
      pwm: stm32: Refuse too small period requests
      pwm: stm32: Fix calculation of prescaler
      pwm: stm32: Fix error message to not describe the previous error path

Vasant Hegde (3):
      iommu/amd: Introduce per device DTE update function
      iommu/amd: Invalidate cache before removing device from domain list
      iommu/amd: Fix GT feature enablement again

Vasileios Amoiridis (4):
      iio: chemical: bme680: Fix pressure value output
      iio: chemical: bme680: Fix calibration data variable
      iio: chemical: bme680: Fix overflows in compensate() functions
      iio: chemical: bme680: Fix sensor data read operation

Vijendar Mukunda (3):
      ASoC: amd: acp: add a null check for chip_pdev structure
      ASoC: amd: acp: remove i2s configuration check in acp_i2s_probe()
      ASoC: amd: acp: move chip->flag variable assignment

Vitor Soares (1):
      can: mcp251xfd: fix infinite loop when xmit fails

Wenchao Hao (2):
      workqueue: Increase worker desc's length to 32
      RDMA/restrack: Fix potential invalid address access

Wolfram Sang (2):
      i2c: testunit: don't erase registers after STOP
      i2c: testunit: discard write requests while old command is running

Xin Long (1):
      openvswitch: get related ct labels from its master if it is not confirmed

Yao Xingtao (1):
      cxl/region: check interleave capability

Yonghong Song (2):
      bpf: Add missed var_off setting in set_sext32_default_val()
      bpf: Add missed var_off setting in coerce_subreg_to_size_sx()

Yunseong Kim (1):
      tracing/net_sched: NULL pointer dereference in perf_trace_qdisc_reset()

Yuntao Wang (1):
      cpu/hotplug: Fix dynstate assignment in __cpuhp_setup_state_cpuslocked()

Zenghui Yu (1):
      arm64: Clear the initial ID map correctly before remapping

Zhaoyang Huang (1):
      mm: fix incorrect vbq reference in purge_fragmented_block

luoxuanqiang (1):
      Fix race for duplicate reqsk on identical SYN

yangge (1):
      mm/page_alloc: Separate THP PCP into movable and non-movable categories


