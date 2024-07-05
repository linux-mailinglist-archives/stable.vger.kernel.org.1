Return-Path: <stable+bounces-58116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B0928302
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 09:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F8B23D5A
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 07:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BDF144D01;
	Fri,  5 Jul 2024 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZLcPPpZt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE89143866;
	Fri,  5 Jul 2024 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165453; cv=none; b=c3G12388xKDNmfgF60cEypHk+6t8phagY5bH3aLQgdLd5uNto4ZUb7OEfICGSlhu8FV1Hm/NBNJFRDc3qKzs1TCb1wefDQbyEOTZp7JSjWeozzpvYwm4PuWHqJ3p40DW1mjzdyS1fUckFFcEBY0MlrKXzOixUG3pGKgiazaveGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165453; c=relaxed/simple;
	bh=1C1KbiyPv5ebtg/v5uuueXSqBXPFZOd7cwlLS8mRzTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rW8dHKlVS1nTL+FxWibl5v87koKU1gQ0wDlvRyO1SIEdR6qA+SjmsIFxrp9h4vPWILqdx/ldSH9k+M5yn8f0g2MUUkZih3NA82qbPgK8tsc7Sc3BaAF3ckPX1UCPjsEvasug/dlW7Hi8Nffjm7lnGHZnGs6DT7HUM1tBsO0bM6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZLcPPpZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BC0C116B1;
	Fri,  5 Jul 2024 07:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720165453;
	bh=1C1KbiyPv5ebtg/v5uuueXSqBXPFZOd7cwlLS8mRzTw=;
	h=From:To:Cc:Subject:Date:From;
	b=ZLcPPpZt3nIHtoEtP9NjS3ZjPUCAYeh8mvHno5ZEpyOnTJW8TLzdnvzfGasL/B5g/
	 RQbQ+FGA42YlHWahYOWyDV1Bktrjfkr+wFVEX3CEmT87BHCEfq0XjuDkqjkVUxmFFh
	 Bv/xIA341MuABq8fg4bh0VGG1VprdfNItRvxkYQY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.97
Date: Fri,  5 Jul 2024 09:44:08 +0200
Message-ID: <2024070508-uncivil-unviable-c930@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.97 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml  |    4 
 Documentation/devicetree/bindings/i2c/apple,i2c.yaml           |    4 
 Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml   |    2 
 Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml      |    4 
 Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml        |    4 
 Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml  |    4 
 Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml        |    2 
 Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml |    4 
 Makefile                                                       |    2 
 arch/arm/boot/dts/rk3066a.dtsi                                 |    1 
 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts              |   18 
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts              |    4 
 arch/arm64/boot/dts/rockchip/rk3368.dtsi                       |    3 
 arch/arm64/include/asm/unistd32.h                              |    2 
 arch/arm64/kernel/syscall.c                                    |   16 
 arch/csky/include/uapi/asm/unistd.h                            |    1 
 arch/hexagon/include/asm/syscalls.h                            |    6 
 arch/hexagon/include/uapi/asm/unistd.h                         |    1 
 arch/hexagon/kernel/syscalltab.c                               |    7 
 arch/mips/kernel/syscalls/syscall_n32.tbl                      |    2 
 arch/mips/kernel/syscalls/syscall_o32.tbl                      |    2 
 arch/parisc/Kconfig                                            |    1 
 arch/parisc/kernel/sys_parisc32.c                              |    9 
 arch/parisc/kernel/syscalls/syscall.tbl                        |    6 
 arch/powerpc/kernel/syscalls/syscall.tbl                       |    6 
 arch/riscv/kernel/stacktrace.c                                 |    2 
 arch/s390/include/asm/entry-common.h                           |    2 
 arch/s390/kernel/syscalls/syscall.tbl                          |    2 
 arch/s390/pci/pci_irq.c                                        |    2 
 arch/sh/kernel/sys_sh32.c                                      |   11 
 arch/sh/kernel/syscalls/syscall.tbl                            |    3 
 arch/sparc/kernel/sys32.S                                      |  221 --------
 arch/sparc/kernel/syscalls/syscall.tbl                         |    8 
 arch/x86/entry/syscalls/syscall_32.tbl                         |    2 
 arch/x86/include/asm/efi.h                                     |   11 
 arch/x86/include/asm/entry-common.h                            |   15 
 arch/x86/kernel/fpu/core.c                                     |    4 
 arch/x86/kernel/time.c                                         |   20 
 arch/x86/platform/efi/Makefile                                 |    3 
 arch/x86/platform/efi/efi.c                                    |    8 
 arch/x86/platform/efi/memmap.c                                 |  249 ++++++++++
 crypto/ecdh.c                                                  |    2 
 drivers/acpi/x86/utils.c                                       |   23 
 drivers/ata/ahci.c                                             |   17 
 drivers/ata/libata-core.c                                      |    8 
 drivers/counter/ti-eqep.c                                      |    6 
 drivers/cpufreq/amd-pstate.c                                   |    2 
 drivers/cpufreq/intel_pstate.c                                 |   13 
 drivers/firmware/efi/fdtparams.c                               |    4 
 drivers/firmware/efi/memmap.c                                  |  238 ---------
 drivers/gpio/gpio-davinci.c                                    |    5 
 drivers/gpio/gpiolib-cdev.c                                    |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                     |   68 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c                       |   18 
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c                   |    1 
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c                      |    6 
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c                  |    6 
 drivers/gpu/drm/panel/panel-simple.c                           |    1 
 drivers/gpu/drm/radeon/radeon.h                                |    1 
 drivers/gpu/drm/radeon/radeon_display.c                        |    8 
 drivers/i2c/i2c-slave-testunit.c                               |    5 
 drivers/iio/accel/Kconfig                                      |    2 
 drivers/iio/adc/ad7266.c                                       |    2 
 drivers/iio/adc/xilinx-ams.c                                   |    8 
 drivers/iio/chemical/bme680.h                                  |    2 
 drivers/iio/chemical/bme680_core.c                             |   62 ++
 drivers/infiniband/core/restrack.c                             |   51 --
 drivers/input/touchscreen/ili210x.c                            |    4 
 drivers/irqchip/irq-loongson-liointc.c                         |    4 
 drivers/media/dvb-core/dvbdev.c                                |    2 
 drivers/mmc/host/sdhci-brcmstb.c                               |    4 
 drivers/mmc/host/sdhci-pci-core.c                              |   11 
 drivers/mmc/host/sdhci.c                                       |   25 -
 drivers/mtd/parsers/redboot.c                                  |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c                 |   14 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c                   |   55 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h                      |    5 
 drivers/net/dsa/microchip/ksz9477.c                            |   10 
 drivers/net/dsa/microchip/ksz9477_reg.h                        |    1 
 drivers/net/dsa/microchip/ksz_common.c                         |    2 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c               |   14 
 drivers/net/ethernet/ibm/ibmvnic.c                             |    6 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c         |   20 
 drivers/net/phy/micrel.c                                       |    1 
 drivers/net/usb/ax88179_178a.c                                 |    6 
 drivers/pinctrl/core.c                                         |    2 
 drivers/pinctrl/pinctrl-rockchip.c                             |   68 ++
 drivers/pinctrl/pinctrl-rockchip.h                             |    1 
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                       |    1 
 drivers/pwm/pwm-stm32.c                                        |    3 
 drivers/soc/ti/wkup_m3_ipc.c                                   |    7 
 drivers/tty/serial/8250/8250_omap.c                            |   22 
 drivers/tty/serial/imx.c                                       |   10 
 drivers/tty/serial/mcf.c                                       |    2 
 drivers/usb/atm/cxacru.c                                       |   14 
 drivers/usb/dwc3/core.c                                        |    6 
 drivers/usb/gadget/function/f_printer.c                        |   40 +
 drivers/usb/gadget/udc/aspeed_udc.c                            |    4 
 drivers/usb/musb/da8xx.c                                       |    8 
 drivers/usb/typec/ucsi/ucsi.c                                  |   55 +-
 drivers/usb/typec/ucsi/ucsi_stm32g0.c                          |   19 
 drivers/vdpa/vdpa_user/vduse_dev.c                             |   14 
 fs/btrfs/free-space-cache.c                                    |    2 
 fs/gfs2/super.c                                                |    2 
 fs/nfs/direct.c                                                |    2 
 fs/ocfs2/aops.c                                                |    5 
 fs/ocfs2/journal.c                                             |   17 
 fs/ocfs2/journal.h                                             |    2 
 fs/ocfs2/ocfs2_trace.h                                         |    2 
 fs/open.c                                                      |    4 
 include/linux/compat.h                                         |    2 
 include/linux/efi.h                                            |   10 
 include/linux/filter.h                                         |    5 
 include/linux/ieee80211.h                                      |    2 
 include/linux/mmzone.h                                         |    9 
 include/linux/nvme.h                                           |    4 
 include/linux/syscalls.h                                       |    8 
 include/net/inet_connection_sock.h                             |    2 
 include/net/netfilter/nf_tables.h                              |   21 
 include/trace/events/qdisc.h                                   |    4 
 include/uapi/asm-generic/unistd.h                              |    2 
 kernel/bpf/core.c                                              |    6 
 kernel/bpf/ringbuf.c                                           |   31 +
 kernel/bpf/verifier.c                                          |    8 
 kernel/cpu.c                                                   |    8 
 kernel/sys_ni.c                                                |    2 
 mm/page_alloc.c                                                |    8 
 net/batman-adv/originator.c                                    |   27 +
 net/can/j1939/main.c                                           |    6 
 net/can/j1939/transport.c                                      |   21 
 net/core/filter.c                                              |    3 
 net/core/xdp.c                                                 |    4 
 net/dccp/ipv4.c                                                |    7 
 net/dccp/ipv6.c                                                |    7 
 net/ipv4/inet_connection_sock.c                                |   17 
 net/ipv4/tcp_input.c                                           |   45 +
 net/iucv/iucv.c                                                |   26 -
 net/netfilter/nf_tables_api.c                                  |   12 
 net/netfilter/nft_lookup.c                                     |    3 
 net/netfilter/nft_set_hash.c                                   |    8 
 net/netfilter/nft_set_pipapo.c                                 |   18 
 net/netfilter/nft_set_rbtree.c                                 |    6 
 scripts/Makefile.dtbinst                                       |    2 
 security/integrity/ima/ima_api.c                               |   16 
 security/integrity/ima/ima_template_lib.c                      |   17 
 sound/pci/hda/patch_realtek.c                                  |    3 
 sound/soc/amd/acp/acp-i2s.c                                    |    8 
 sound/soc/fsl/fsl-asoc-card.c                                  |    3 
 sound/soc/rockchip/rockchip_i2s_tdm.c                          |   13 
 sound/synth/emux/soundfont.c                                   |   17 
 152 files changed, 1233 insertions(+), 943 deletions(-)

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

Andrew Davis (1):
      soc: ti: wkup_m3_ipc: Send NULL dummy message instead of pointer message

Andy Chiu (1):
      riscv: stacktrace: convert arch_stack_walk() to noinstr

Anton Protopopov (1):
      bpf: Add a check for struct bpf_fib_lookup size

Ard Biesheuvel (3):
      efi: memmap: Move manipulation routines into x86 arch tree
      efi: xen: Set EFI_PARAVIRT for Xen dom0 boot on all architectures
      efi/x86: Free EFI memory map only when installing a new one.

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

Christophe Leroy (1):
      bpf: Take return from set_memory_ro() into account with bpf_prog_lock_ro()

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

Dragan Simic (1):
      kbuild: Install dtb files as 0644 in Makefile.dtbinst

Elinor Montmasson (1):
      ASoC: fsl-asoc-card: set priv->pdev before using it

Enguerrand de Ribaucourt (2):
      net: phy: micrel: add Microchip KSZ 9477 to the device table
      net: dsa: microchip: use collision based back pressure mode

Erick Archer (1):
      drm/radeon/radeon_display: Decrease the size of allocated memory

FUKAUMI Naoki (1):
      arm64: dts: rockchip: fix PMIC interrupt pin on ROCK Pi E

Fabrice Gasnier (1):
      usb: ucsi: stm32: fix command completion handling

Fernando Yang (1):
      iio: adc: ad7266: Fix variable checking bug

Greg Kroah-Hartman (2):
      Revert "cpufreq: amd-pstate: Fix the inconsistency in max frequency units"
      Linux 6.1.97

Hagar Hemdan (1):
      pinctrl: fix deadlock in create_pinctrl() when handling -EPROBE_DEFER

Hannes Reinecke (1):
      nvme: fixup comment for nvme RDMA Provider Type

Heikki Krogerus (1):
      usb: typec: ucsi: Ack also failed Get Error commands

Huacai Chen (1):
      irqchip/loongson-liointc: Set different ISRs for different cores

Huang-Huang Bao (4):
      pinctrl: rockchip: fix pinmux bits for RK3328 GPIO2-B pins
      pinctrl: rockchip: fix pinmux bits for RK3328 GPIO3-B pins
      pinctrl: rockchip: use dedicated pinctrl type for RK3328
      pinctrl: rockchip: fix pinmux reset in rockchip_pmx_set

Ido Schimmel (1):
      mlxsw: spectrum_buffers: Fix memory corruptions on Spectrum-4 systems

Ilpo Järvinen (1):
      mmc: sdhci-pci: Convert PCIBIOS_* return codes to errnos

Jan Kara (1):
      ocfs2: fix DIO failure due to insufficient transaction credits

Janusz Krzysztofik (1):
      drm/i915/gt: Fix potential UAF by revoke of fence registers

Jean-Michel Hautbois (1):
      tty: mcf: MCF54418 has 10 UARTS

Jeremy Kerr (1):
      usb: gadget: aspeed_udc: fix device address configuration

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

Jonas Karlman (2):
      arm64: dts: rockchip: Fix SD NAND and eMMC init on rk3308-rock-pi-s
      arm64: dts: rockchip: Rename LED related pinctrl nodes on rk3308-rock-pi-s

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: improve link status logs

Julia Zhang (1):
      drm/amdgpu: avoid using null object of framebuffer

Juntong Deng (1):
      gfs2: Fix slab-use-after-free in gfs2_qd_dealloc

Kamal Dasu (1):
      mmc: sdhci-brcmstb: check R1_STATUS for erase/trim/discard

Kees Cook (1):
      randomize_kstack: Remove non-functional per-arch entropy filtering

Kent Gibson (1):
      gpiolib: cdev: Disallow reconfiguration without direction (uAPI v1)

Krzysztof Kozlowski (1):
      dt-bindings: i2c: atmel,at91sam: correct path to i2c-controller schema

Laurent Pinchart (1):
      drm/panel: ilitek-ili9881c: Fix warning with GPIO controllers that sleep

Lijo Lazar (1):
      drm/amdgpu: Fix pci state save during mode-1 reset

Linus Torvalds (1):
      x86: stop playing stack games in profile_pc()

Liu Ying (1):
      drm/panel: simple: Add missing display timing flags for KOE TX26D202VM0BWA

Ma Ke (2):
      drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_ld_modes
      drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_hd_modes

Mario Limonciello (2):
      ACPI: x86: utils: Add Picasso to the list for forcing StorageD3Enable
      ACPI: x86: Force StorageD3Enable on more products

Martin KaFai Lau (1):
      bpf: Mark bpf prog stack with kmsan_unposion_memory in interpreter mode

Martin Schiller (1):
      MIPS: pci: lantiq: restore reset gpio polarity

Maxime Coquelin (2):
      vduse: validate block features only with block devices
      vduse: Temporarily fail if control queue feature requested

Meng Li (1):
      usb: dwc3: core: remove lock of otg mode during gadget suspend/resume to avoid deadlock

Naohiro Aota (1):
      btrfs: zoned: fix initial free space detection

Neal Cardwell (1):
      tcp: fix tcp_rcv_fastopen_synack() to enter TCP_CA_Loss for failed TFO

Nick Child (1):
      ibmvnic: Free any outstanding tx skbs during scrq reset

Nikita Zhandarovich (1):
      usb: atm: cxacru: fix endpoint checking in cxacru_bind()

Niklas Cassel (2):
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

Pablo Neira Ayuso (2):
      netfilter: nf_tables: use timestamp to check for set element timeout
      netfilter: nf_tables: fully validate NFT_DATA_VALUE on store to data registers

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Use HWP to initialize ITMT if CPPC is missing

Ricardo Ribalda (1):
      media: dvbdev: Initialize sbuf

Rob Herring (1):
      dt-bindings: i2c: Drop unneeded quotes

Sean Anderson (1):
      iio: xilinx-ams: Don't include ams_ctrl_channels in scan_mask

Shigeru Yoshida (1):
      net: can: j1939: Initialize unused data in j1939_send_one()

Srinivasan Shanmugam (1):
      drm/amd/amdgpu: Fix style errors in amdgpu_drv.c & amdgpu_device.c

Stefan Berger (1):
      ima: Fix use-after-free on a dentry's dname.name

Stefan Eichenberger (2):
      serial: imx: set receiver level before starting uart
      serial: imx: only set receiver level if it is zero

Sven Eckelmann (1):
      batman-adv: Don't accept TT entries for out-of-spec VIDs

Thomas Bogendoerfer (1):
      Revert "MIPS: pci: lantiq: restore reset gpio polarity"

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

Vijendar Mukunda (1):
      ASoC: amd: acp: remove i2s configuration check in acp_i2s_probe()

Vitor Soares (1):
      can: mcp251xfd: fix infinite loop when xmit fails

Wenchao Hao (1):
      RDMA/restrack: Fix potential invalid address access

Wolfram Sang (2):
      i2c: testunit: don't erase registers after STOP
      i2c: testunit: discard write requests while old command is running

Yunseong Kim (1):
      tracing/net_sched: NULL pointer dereference in perf_trace_qdisc_reset()

Yuntao Wang (1):
      cpu/hotplug: Fix dynstate assignment in __cpuhp_setup_state_cpuslocked()

luoxuanqiang (1):
      Fix race for duplicate reqsk on identical SYN

yangge (1):
      mm/page_alloc: Separate THP PCP into movable and non-movable categories


