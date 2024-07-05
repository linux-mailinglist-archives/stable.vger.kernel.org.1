Return-Path: <stable+bounces-58119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7474B92830D
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 09:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FFB1F2431D
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 07:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22175145B01;
	Fri,  5 Jul 2024 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yf9eBwV6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE797143C7B;
	Fri,  5 Jul 2024 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165474; cv=none; b=cRBL1ksKPgOlkYxkbkB0mXkrZOkYPWb7AMr9yku8R7bfDBX7nfgu5Rmd3WFNZTE4SGfQ2j2cU0zgGHpOA5TBy5ndEFnA45JieZq9wMdcbt/Aq0pKnRV+jwYFf7SYOIL83UGRHeAfBljt9YU64YAqbVBYKArOhSLQWux0g0powlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165474; c=relaxed/simple;
	bh=Remqfepp4mzZChlgFBsTRQ2kdTZNzehe6uRkbvjN+mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W8V1VT73Kl40CuIV5yUCeZ8ov+yfW2EAz080bunK+XEFfCOvEKz5taaOHPrHIYlSwiKtJ1Q8587GvQJUK36twPInTH3k0ivQpZ/f4/ygRUa4xnLRr7Eep1ST+dfz7s3003k3zSbILSm1Rokn4LAtmWsoL5nyqaqKA+M7ShiQeqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yf9eBwV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2603C32786;
	Fri,  5 Jul 2024 07:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720165474;
	bh=Remqfepp4mzZChlgFBsTRQ2kdTZNzehe6uRkbvjN+mk=;
	h=From:To:Cc:Subject:Date:From;
	b=yf9eBwV6kemO504QwIZ8W0WXlYdWtOuqjjSiW2i++95wpCSaA5oq3YwH374Qojlr+
	 wr6XOuqhvKiSlJusKihqGkeEIMAU4/NUsTKdfdnfotuHj7isvk0/Gn4GExFM8864rM
	 w8W6HZ7ifTg5A1u0dBstVyVBW3q52rYz/KqkqSV8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.37
Date: Fri,  5 Jul 2024 09:44:25 +0200
Message-ID: <2024070525-duke-dinner-a806@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.37 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/kbuild/modules.rst                                   |    8 
 Makefile                                                           |    2 
 arch/arm/boot/dts/rockchip/rk3066a.dtsi                            |    1 
 arch/arm/net/bpf_jit_32.c                                          |   25 -
 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts                  |   18 
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts                  |    4 
 arch/arm64/boot/dts/rockchip/rk3368.dtsi                           |    3 
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi                       |    2 
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts                   |    1 
 arch/arm64/include/asm/unistd32.h                                  |    2 
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
 arch/powerpc/net/bpf_jit.h                                         |   18 
 arch/powerpc/net/bpf_jit_comp.c                                    |  110 +++-
 arch/powerpc/net/bpf_jit_comp32.c                                  |   13 
 arch/powerpc/net/bpf_jit_comp64.c                                  |   10 
 arch/riscv/include/asm/insn.h                                      |    2 
 arch/riscv/kernel/stacktrace.c                                     |    2 
 arch/s390/include/asm/entry-common.h                               |    2 
 arch/s390/kernel/syscalls/syscall.tbl                              |    2 
 arch/s390/net/bpf_jit_comp.c                                       |    6 
 arch/s390/pci/pci_irq.c                                            |    2 
 arch/sh/kernel/sys_sh32.c                                          |   11 
 arch/sh/kernel/syscalls/syscall.tbl                                |    3 
 arch/sparc/kernel/sys32.S                                          |  221 ----------
 arch/sparc/kernel/syscalls/syscall.tbl                             |    8 
 arch/sparc/net/bpf_jit_comp_64.c                                   |    6 
 arch/x86/entry/syscalls/syscall_32.tbl                             |    2 
 arch/x86/include/asm/entry-common.h                                |   15 
 arch/x86/kernel/fpu/core.c                                         |    4 
 arch/x86/kernel/time.c                                             |   20 
 arch/x86/net/bpf_jit_comp32.c                                      |    3 
 crypto/ecdh.c                                                      |    2 
 drivers/ata/ahci.c                                                 |   17 
 drivers/ata/libata-core.c                                          |   29 -
 drivers/counter/ti-eqep.c                                          |    6 
 drivers/cpufreq/amd-pstate.c                                       |    2 
 drivers/cpufreq/intel_pstate.c                                     |   13 
 drivers/cxl/core/core.h                                            |    7 
 drivers/cxl/core/hdm.c                                             |   13 
 drivers/cxl/core/memdev.c                                          |   44 -
 drivers/cxl/core/region.c                                          |  137 ++++++
 drivers/cxl/cxl.h                                                  |    2 
 drivers/cxl/cxlmem.h                                               |   10 
 drivers/gpio/gpio-davinci.c                                        |    5 
 drivers/gpio/gpiolib-cdev.c                                        |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c                   |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                         |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c                           |   18 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c |   10 
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
 drivers/i2c/i2c-slave-testunit.c                                   |    5 
 drivers/iio/accel/Kconfig                                          |    2 
 drivers/iio/adc/ad7266.c                                           |    2 
 drivers/iio/adc/xilinx-ams.c                                       |    8 
 drivers/iio/chemical/bme680.h                                      |    2 
 drivers/iio/chemical/bme680_core.c                                 |   62 ++
 drivers/iio/pressure/bmp280-core.c                                 |   14 
 drivers/iio/pressure/bmp280.h                                      |    2 
 drivers/infiniband/core/restrack.c                                 |   51 --
 drivers/input/touchscreen/ili210x.c                                |    4 
 drivers/irqchip/Kconfig                                            |    2 
 drivers/irqchip/irq-loongson-eiointc.c                             |    5 
 drivers/irqchip/irq-loongson-liointc.c                             |    4 
 drivers/media/dvb-core/dvbdev.c                                    |    2 
 drivers/mmc/host/sdhci-brcmstb.c                                   |    4 
 drivers/mmc/host/sdhci-pci-core.c                                  |   11 
 drivers/mmc/host/sdhci-pci-o2micro.c                               |   41 -
 drivers/mmc/host/sdhci.c                                           |   25 -
 drivers/mtd/parsers/redboot.c                                      |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c                     |   14 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c                       |   55 ++
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h                          |    5 
 drivers/net/dsa/microchip/ksz9477.c                                |   10 
 drivers/net/dsa/microchip/ksz9477_reg.h                            |    1 
 drivers/net/dsa/microchip/ksz_common.c                             |    2 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                   |   14 
 drivers/net/ethernet/ibm/ibmvnic.c                                 |    6 
 drivers/net/ethernet/intel/ice/ice_main.c                          |   10 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c             |   20 
 drivers/net/ethernet/microsoft/mana/mana_en.c                      |    2 
 drivers/net/phy/micrel.c                                           |    1 
 drivers/net/usb/ax88179_178a.c                                     |    6 
 drivers/pci/msi/msi.c                                              |   10 
 drivers/pinctrl/core.c                                             |    2 
 drivers/pinctrl/pinctrl-rockchip.c                                 |   68 ++-
 drivers/pinctrl/pinctrl-rockchip.h                                 |    1 
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                           |    1 
 drivers/pwm/pwm-stm32.c                                            |    3 
 drivers/scsi/libsas/sas_ata.c                                      |    6 
 drivers/scsi/libsas/sas_discover.c                                 |    2 
 drivers/soc/ti/wkup_m3_ipc.c                                       |    7 
 drivers/tty/serial/8250/8250_omap.c                                |   22 
 drivers/tty/serial/bcm63xx_uart.c                                  |    7 
 drivers/tty/serial/imx.c                                           |   10 
 drivers/tty/serial/mcf.c                                           |    2 
 drivers/usb/atm/cxacru.c                                           |   14 
 drivers/usb/dwc3/core.c                                            |   26 -
 drivers/usb/dwc3/core.h                                            |    1 
 drivers/usb/gadget/function/f_printer.c                            |   40 +
 drivers/usb/gadget/udc/aspeed_udc.c                                |    4 
 drivers/usb/musb/da8xx.c                                           |    8 
 drivers/usb/typec/ucsi/ucsi.c                                      |   55 +-
 drivers/usb/typec/ucsi/ucsi_glink.c                                |    5 
 drivers/usb/typec/ucsi/ucsi_stm32g0.c                              |   19 
 drivers/vdpa/vdpa_user/vduse_dev.c                                 |   14 
 fs/btrfs/free-space-cache.c                                        |    2 
 fs/btrfs/tree-log.c                                                |   43 +
 fs/erofs/data.c                                                    |    5 
 fs/gfs2/log.c                                                      |    3 
 fs/gfs2/super.c                                                    |    4 
 fs/nfs/direct.c                                                    |    2 
 fs/ocfs2/aops.c                                                    |    5 
 fs/ocfs2/journal.c                                                 |   17 
 fs/ocfs2/journal.h                                                 |    2 
 fs/ocfs2/ocfs2_trace.h                                             |    2 
 fs/open.c                                                          |    4 
 include/linux/compat.h                                             |    2 
 include/linux/filter.h                                             |   10 
 include/linux/ieee80211.h                                          |   15 
 include/linux/libata.h                                             |    1 
 include/linux/mmzone.h                                             |    9 
 include/linux/nvme.h                                               |    4 
 include/linux/serial_core.h                                        |   21 
 include/linux/syscalls.h                                           |    8 
 include/linux/workqueue.h                                          |    2 
 include/net/inet_connection_sock.h                                 |    2 
 include/net/netfilter/nf_tables.h                                  |    5 
 include/trace/events/qdisc.h                                       |    4 
 include/uapi/asm-generic/unistd.h                                  |    2 
 kernel/bpf/core.c                                                  |    6 
 kernel/bpf/ringbuf.c                                               |   31 +
 kernel/bpf/verifier.c                                              |   10 
 kernel/cpu.c                                                       |    8 
 kernel/sys_ni.c                                                    |    2 
 mm/page_alloc.c                                                    |    9 
 mm/vmalloc.c                                                       |   21 
 net/batman-adv/originator.c                                        |   27 +
 net/can/j1939/main.c                                               |    6 
 net/can/j1939/transport.c                                          |   21 
 net/core/xdp.c                                                     |    4 
 net/dccp/ipv4.c                                                    |    7 
 net/dccp/ipv6.c                                                    |    7 
 net/ipv4/inet_connection_sock.c                                    |   17 
 net/ipv4/tcp_input.c                                               |   45 +-
 net/iucv/iucv.c                                                    |   26 -
 net/netfilter/nf_hooks_lwtunnel.c                                  |    3 
 net/netfilter/nf_tables_api.c                                      |    8 
 net/netfilter/nft_lookup.c                                         |    3 
 net/openvswitch/conntrack.c                                        |    7 
 scripts/Makefile.dtbinst                                           |    2 
 scripts/Makefile.package                                           |    2 
 sound/core/seq/seq_ump_convert.c                                   |   10 
 sound/pci/hda/patch_realtek.c                                      |    3 
 sound/soc/amd/acp/acp-i2s.c                                        |    8 
 sound/soc/amd/acp/acp-pci.c                                        |   10 
 sound/soc/atmel/atmel-classd.c                                     |   17 
 sound/soc/atmel/atmel-pcm-dma.c                                    |    8 
 sound/soc/atmel/atmel-pcm-pdc.c                                    |    4 
 sound/soc/atmel/atmel-pdmic.c                                      |   12 
 sound/soc/atmel/atmel_wm8904.c                                     |    4 
 sound/soc/atmel/mikroe-proto.c                                     |    2 
 sound/soc/atmel/sam9g20_wm8731.c                                   |    2 
 sound/soc/atmel/sam9x5_wm8731.c                                    |    2 
 sound/soc/fsl/fsl-asoc-card.c                                      |    3 
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c                 |   10 
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c                            |   32 -
 sound/soc/rockchip/rockchip_i2s_tdm.c                              |   13 
 sound/synth/emux/soundfont.c                                       |   17 
 tools/testing/cxl/test/cxl.c                                       |    4 
 tools/testing/selftests/net/mptcp/userspace_pm.sh                  |   50 +-
 192 files changed, 1473 insertions(+), 908 deletions(-)

Adam Rizkalla (1):
      iio: pressure: bmp280: Fix BMP580 temperature reading

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

Alibek Omarov (1):
      ASoC: rockchip: i2s-tdm: Fix trcm mode by setting clock on right mclk

Alison Schofield (2):
      cxl/region: Move cxl_dpa_to_region() work to the region driver
      cxl/region: Avoid null pointer dereference in region lookup

Andreas Gruenbacher (1):
      gfs2: Fix NULL pointer dereference in gfs2_log_flush

Andrei Simion (1):
      ASoC: atmel: atmel-classd: Re-add dai_link->platform to fix card init

Andrew Davis (1):
      soc: ti: wkup_m3_ipc: Send NULL dummy message instead of pointer message

Andy Chiu (1):
      riscv: stacktrace: convert arch_stack_walk() to noinstr

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

Christian A. Ehrhardt (1):
      usb: typec: ucsi: Never send a lone connector change ack

Christoph Hellwig (1):
      nfs: drop the incorrect assertion in nfs_swap_rw()

Christophe Leroy (2):
      bpf: Take return from set_memory_ro() into account with bpf_prog_lock_ro()
      bpf: Take return from set_memory_rox() into account with bpf_jit_binary_lock_ro()

Dan Carpenter (1):
      usb: musb: da8xx: fix a resource leak in probe()

Daniel Borkmann (1):
      bpf: Fix overrunning reservations in ringbuf

Daniil Dulov (1):
      xdp: Remove WARN() from __xdp_reg_mem_model()

David Lechner (1):
      counter: ti-eqep: enable clock at probe

Dawei Li (2):
      net/iucv: Avoid explicit cpumask var allocation on stack
      net/dpaa2: Avoid explicit cpumask var allocation on stack

Denis Arefev (1):
      mtd: partitions: redboot: Added conversion of operands to a larger type

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

FUKAUMI Naoki (2):
      arm64: dts: rockchip: make poweroff(8) work on Radxa ROCK 5A
      arm64: dts: rockchip: fix PMIC interrupt pin on ROCK Pi E

Fabrice Gasnier (1):
      usb: ucsi: stm32: fix command completion handling

Fernando Yang (1):
      iio: adc: ad7266: Fix variable checking bug

Filipe Manana (1):
      btrfs: use NOFS context when getting inodes during logging and log replay

Geliang Tang (1):
      selftests: mptcp: print_test out of verify_listener_events

Greg Kroah-Hartman (2):
      Revert "cpufreq: amd-pstate: Fix the inconsistency in max frequency units"
      Linux 6.6.37

Hagar Hemdan (1):
      pinctrl: fix deadlock in create_pinctrl() when handling -EPROBE_DEFER

Hannes Reinecke (1):
      nvme: fixup comment for nvme RDMA Provider Type

Hari Bathini (2):
      powerpc/bpf: rename powerpc64_jit_data to powerpc_jit_data
      powerpc/bpf: use bpf_jit_binary_pack_[alloc|finalize|free]

Heikki Krogerus (1):
      usb: typec: ucsi: Ack also failed Get Error commands

Hsin-Te Yuan (2):
      ASoC: mediatek: mt8183-da7219-max98357: Fix kcontrol name collision
      arm64: dts: rockchip: Fix the value of `dlg,jack-det-rate` mismatch on rk3399-gru

Huacai Chen (2):
      irqchip/loongson-eiointc: Use early_cpu_to_node() instead of cpu_to_node()
      irqchip/loongson-liointc: Set different ISRs for different cores

Huang-Huang Bao (4):
      pinctrl: rockchip: fix pinmux bits for RK3328 GPIO2-B pins
      pinctrl: rockchip: fix pinmux bits for RK3328 GPIO3-B pins
      pinctrl: rockchip: use dedicated pinctrl type for RK3328
      pinctrl: rockchip: fix pinmux reset in rockchip_pmx_set

Ido Schimmel (1):
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

Javier Carrasco (1):
      usb: typec: ucsi: glink: fix child node release in probe function

Jean-Michel Hautbois (1):
      tty: mcf: MCF54418 has 10 UARTS

Jeff Johnson (1):
      wifi: mac80211: Use flexible array in struct ieee80211_tim_ie

Jeremy Kerr (1):
      usb: gadget: aspeed_udc: fix device address configuration

Jesse Taube (1):
      RISC-V: fix vector insn load/store width mask

Jianguo Wu (1):
      netfilter: fix undefined reference to 'netfilter_lwtunnel_*' when CONFIG_SYSCTL=n

Jingbo Xu (1):
      erofs: fix NULL dereference of dif->bdev_handle in fscache mode

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

Kent Gibson (1):
      gpiolib: cdev: Disallow reconfiguration without direction (uAPI v1)

Kuninori Morimoto (1):
      ASoC: atmel: convert not to use asoc_xxx()

Laurent Pinchart (1):
      drm/panel: ilitek-ili9881c: Fix warning with GPIO controllers that sleep

Li peiyu (1):
      iio: pressure: fix some word spelling errors

Lijo Lazar (1):
      drm/amdgpu: Fix pci state save during mode-1 reset

Linus Torvalds (1):
      x86: stop playing stack games in profile_pc()

Liu Ying (1):
      drm/panel: simple: Add missing display timing flags for KOE TX26D202VM0BWA

Ma Ke (3):
      net: mana: Fix possible double free in error handling path
      drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_ld_modes
      drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_hd_modes

Mark-PK Tsai (1):
      kbuild: doc: Update default INSTALL_MOD_DIR from extra to updates

Martin KaFai Lau (1):
      bpf: Mark bpf prog stack with kmsan_unposion_memory in interpreter mode

Martin Schiller (1):
      MIPS: pci: lantiq: restore reset gpio polarity

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: userspace_pm: fixed subtest names

Maxime Coquelin (2):
      vduse: validate block features only with block devices
      vduse: Temporarily fail if control queue feature requested

Meng Li (1):
      usb: dwc3: core: remove lock of otg mode during gadget suspend/resume to avoid deadlock

Michael Strauss (1):
      drm/amd/display: Send DP_TOTAL_LTTPR_CNT during detection if LTTPR is present

Mostafa Saleh (1):
      PCI/MSI: Fix UAF in msi_capability_init

Naohiro Aota (1):
      btrfs: zoned: fix initial free space detection

Neal Cardwell (1):
      tcp: fix tcp_rcv_fastopen_synack() to enter TCP_CA_Loss for failed TFO

Nick Child (1):
      ibmvnic: Free any outstanding tx skbs during scrq reset

Nikita Zhandarovich (1):
      usb: atm: cxacru: fix endpoint checking in cxacru_bind()

Niklas Cassel (4):
      ata: libata-core: Fix null pointer dereference on error
      ata,scsi: libata-core: Do not leak memory for ata_port struct members
      ata: ahci: Clean up sysfs file on error
      ata: libata-core: Fix double free on error

Niklas Schnelle (1):
      s390/pci: Add missing virt_to_phys() for directed DIBV

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

Shigeru Yoshida (1):
      net: can: j1939: Initialize unused data in j1939_send_one()

Srinivas Kandagatla (1):
      ASoC: q6apm-lpass-dai: close graph on prepare errors

Stefan Eichenberger (2):
      serial: imx: set receiver level before starting uart
      serial: imx: only set receiver level if it is zero

Sven Eckelmann (1):
      batman-adv: Don't accept TT entries for out-of-spec VIDs

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

Uwe Kleine-König (1):
      pwm: stm32: Refuse too small period requests

Vasileios Amoiridis (4):
      iio: chemical: bme680: Fix pressure value output
      iio: chemical: bme680: Fix calibration data variable
      iio: chemical: bme680: Fix overflows in compensate() functions
      iio: chemical: bme680: Fix sensor data read operation

Vijendar Mukunda (2):
      ASoC: amd: acp: add a null check for chip_pdev structure
      ASoC: amd: acp: remove i2s configuration check in acp_i2s_probe()

Vitor Soares (1):
      can: mcp251xfd: fix infinite loop when xmit fails

Wenchao Hao (2):
      workqueue: Increase worker desc's length to 32
      RDMA/restrack: Fix potential invalid address access

Wesley Cheng (1):
      usb: dwc3: core: Add DWC31 version 2.00a controller

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

Zhaoyang Huang (1):
      mm: fix incorrect vbq reference in purge_fragmented_block

luoxuanqiang (1):
      Fix race for duplicate reqsk on identical SYN

yangge (1):
      mm/page_alloc: Separate THP PCP into movable and non-movable categories


