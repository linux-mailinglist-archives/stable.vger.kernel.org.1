Return-Path: <stable+bounces-139442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D9AAA6A7D
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 08:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5E218994D3
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 06:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9621EA7FD;
	Fri,  2 May 2025 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wXbxp8t5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587A91EEA47;
	Fri,  2 May 2025 06:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166073; cv=none; b=MEE2lpL4WmXO14ptFX/o0Qglm4OECoF+5zIac/I6K0uNYAoNxR8dsnbd5XkTBc9JDCgWD6lNHf12giQNb+poHnJlstdpYrLzVYmOD0fy2Mw28i395FnPOM/hy8ENipF2l6iDpBtkZD6Rxh/7nT+oKWW+vsXZhJR3oFeUiL0bbvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166073; c=relaxed/simple;
	bh=nos+p33chJkkca5FT8HSfUnmpj5J61ls+Z6QGSOLOSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rhfq6e60E+gf1m+I+UqNIaXjiLiRRwcgoLFZM6+QRVFuZvKwCIlq9p5yrLULb4WTw6+WpuQYso7jFYvde/Ja3P2L+RxHK/rSInpSRJZ2GdVfkkQ99ZVa1jaGgAIbe9GQXPt8C6C+TFtYPR1PI38tQr92QjSvq+S8fOmcs/W29Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wXbxp8t5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A91C4CEE9;
	Fri,  2 May 2025 06:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746166072;
	bh=nos+p33chJkkca5FT8HSfUnmpj5J61ls+Z6QGSOLOSc=;
	h=From:To:Cc:Subject:Date:From;
	b=wXbxp8t5H7lhvjTxNNDZ6qcM9lJS5MgCtd/mxWOQFJOyW5LyIe/TJyaOLl+X1jKtw
	 fZIjLLuwFnaFbK3BTZtBmGWyxIjXSsMpJ6S3mSLeGsScO/q2O9hrgpljDvnqavhANd
	 0+2FzS/y8eFScyg90aArt3PUmhBKBIC4XE0i8P0Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.89
Date: Fri,  2 May 2025 08:07:29 +0200
Message-ID: <2025050230-drool-phoniness-40fc@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.89 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/scheduler/sched-capacity.rst          |   13 -
 Makefile                                            |    2 
 arch/arm64/boot/dts/nvidia/tegra234-p3768-0000.dtsi |    7 
 arch/loongarch/Kconfig                              |    1 
 arch/loongarch/include/asm/ptrace.h                 |    4 
 arch/loongarch/kernel/traps.c                       |   20 +-
 arch/loongarch/mm/hugetlbpage.c                     |    2 
 arch/loongarch/mm/init.c                            |    3 
 arch/mips/include/asm/mips-cm.h                     |   22 ++
 arch/mips/kernel/mips-cm.c                          |   14 +
 arch/parisc/kernel/pdt.c                            |    2 
 arch/riscv/include/asm/alternative-macros.h         |   19 --
 arch/s390/kvm/intercept.c                           |    2 
 arch/s390/kvm/interrupt.c                           |    8 
 arch/s390/kvm/kvm-s390.c                            |   10 -
 arch/s390/kvm/trace-s390.h                          |    4 
 arch/x86/entry/entry.S                              |    2 
 arch/x86/events/core.c                              |    2 
 arch/x86/include/asm/asm.h                          |    3 
 arch/x86/include/asm/extable_fixup_types.h          |    2 
 arch/x86/include/asm/intel-family.h                 |    2 
 arch/x86/kernel/cpu/bugs.c                          |   30 +--
 arch/x86/kernel/cpu/mce/severity.c                  |   12 -
 arch/x86/kernel/i8253.c                             |    3 
 arch/x86/kvm/svm/avic.c                             |   60 +++---
 arch/x86/kvm/vmx/posted_intr.c                      |   28 +--
 arch/x86/kvm/x86.c                                  |    3 
 arch/x86/mm/extable.c                               |    9 -
 arch/x86/mm/tlb.c                                   |    6 
 arch/x86/platform/pvh/head.S                        |    7 
 crypto/crypto_null.c                                |   39 ++--
 drivers/acpi/ec.c                                   |   28 +++
 drivers/acpi/pptt.c                                 |    4 
 drivers/ata/libata-scsi.c                           |   25 +-
 drivers/auxdisplay/hd44780.c                        |    9 -
 drivers/base/base.h                                 |   17 +
 drivers/base/bus.c                                  |    2 
 drivers/base/core.c                                 |   38 +++-
 drivers/base/dd.c                                   |    6 
 drivers/block/loop.c                                |    2 
 drivers/char/misc.c                                 |    2 
 drivers/char/virtio_console.c                       |    7 
 drivers/clk/clk.c                                   |    4 
 drivers/clk/renesas/r9a07g043-cpg.c                 |   28 ++-
 drivers/clk/renesas/r9a07g044-cpg.c                 |   21 ++
 drivers/clk/renesas/rzg2l-cpg.c                     |  180 ++++++++++++++------
 drivers/clk/renesas/rzg2l-cpg.h                     |   24 +-
 drivers/comedi/drivers/jr3_pci.c                    |    2 
 drivers/cpufreq/apple-soc-cpufreq.c                 |   10 -
 drivers/cpufreq/cppc_cpufreq.c                      |    2 
 drivers/cpufreq/scmi-cpufreq.c                      |   10 -
 drivers/cpufreq/scpi-cpufreq.c                      |   13 +
 drivers/crypto/atmel-sha204a.c                      |    6 
 drivers/crypto/ccp/sp-pci.c                         |    1 
 drivers/cxl/core/regs.c                             |    4 
 drivers/dma-buf/udmabuf.c                           |    2 
 drivers/dma/dmatest.c                               |    6 
 drivers/gpio/gpiolib-of.c                           |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |    9 -
 drivers/iio/adc/ad7768-1.c                          |    5 
 drivers/infiniband/hw/qib/qib_fs.c                  |    1 
 drivers/iommu/amd/iommu.c                           |    2 
 drivers/irqchip/irq-gic-v2m.c                       |    2 
 drivers/mailbox/pcc.c                               |   15 +
 drivers/mcb/mcb-parse.c                             |    2 
 drivers/md/raid1.c                                  |   26 +-
 drivers/media/test-drivers/vimc/vimc-streamer.c     |    6 
 drivers/media/v4l2-core/v4l2-subdev.c               |  101 +++++++----
 drivers/misc/lkdtm/perms.c                          |   14 +
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c     |    8 
 drivers/misc/mei/hw-me-regs.h                       |    1 
 drivers/misc/mei/pci-me.c                           |    1 
 drivers/mmc/host/sdhci-msm.c                        |    2 
 drivers/net/dsa/mt7530.c                            |    6 
 drivers/net/dsa/mv88e6xxx/chip.c                    |   27 ++-
 drivers/net/ethernet/amd/pds_core/adminq.c          |   36 +---
 drivers/net/ethernet/amd/pds_core/auxbus.c          |    3 
 drivers/net/ethernet/amd/pds_core/core.c            |    4 
 drivers/net/ethernet/amd/pds_core/core.h            |    2 
 drivers/net/ethernet/amd/pds_core/devlink.c         |    4 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c         |   24 ++
 drivers/net/ethernet/mediatek/mtk_eth_soc.h         |   10 +
 drivers/net/phy/microchip.c                         |   46 -----
 drivers/net/phy/phy_led_triggers.c                  |   23 +-
 drivers/net/vmxnet3/vmxnet3_xdp.c                   |    2 
 drivers/net/xen-netfront.c                          |   17 +
 drivers/ntb/hw/amd/ntb_hw_amd.c                     |    1 
 drivers/ntb/hw/idt/ntb_hw_idt.c                     |   18 --
 drivers/nvme/host/core.c                            |    9 +
 drivers/nvme/host/multipath.c                       |    2 
 drivers/nvme/target/fc.c                            |   25 +-
 drivers/of/resolver.c                               |   37 +---
 drivers/pci/probe.c                                 |    9 -
 drivers/pinctrl/renesas/pinctrl-rza2.c              |    3 
 drivers/regulator/rk808-regulator.c                 |    4 
 drivers/rtc/rtc-pcf85063.c                          |   19 ++
 drivers/s390/char/sclp_con.c                        |   17 +
 drivers/s390/char/sclp_tty.c                        |   12 +
 drivers/scsi/hisi_sas/hisi_sas_main.c               |   20 ++
 drivers/scsi/pm8001/pm8001_sas.c                    |    1 
 drivers/scsi/scsi.c                                 |   36 ++--
 drivers/scsi/scsi_lib.c                             |    6 
 drivers/soc/qcom/ice.c                              |   48 +++++
 drivers/spi/spi-imx.c                               |    5 
 drivers/spi/spi-tegra210-quad.c                     |    6 
 drivers/thunderbolt/tb.c                            |   16 +
 drivers/tty/serial/msm_serial.c                     |    6 
 drivers/tty/serial/sifive.c                         |    6 
 drivers/ufs/core/ufs-mcq.c                          |   12 -
 drivers/ufs/host/ufs-exynos.c                       |   10 -
 drivers/ufs/host/ufs-qcom.c                         |    2 
 drivers/usb/cdns3/cdns3-gadget.c                    |    2 
 drivers/usb/chipidea/ci_hdrc_imx.c                  |   44 +++-
 drivers/usb/class/cdc-wdm.c                         |   21 +-
 drivers/usb/core/quirks.c                           |    9 +
 drivers/usb/dwc3/dwc3-pci.c                         |   10 +
 drivers/usb/dwc3/dwc3-xilinx.c                      |    4 
 drivers/usb/dwc3/gadget.c                           |   28 ++-
 drivers/usb/gadget/udc/aspeed-vhub/dev.c            |    3 
 drivers/usb/host/max3421-hcd.c                      |    7 
 drivers/usb/host/ohci-pci.c                         |   23 ++
 drivers/usb/host/xhci-mvebu.c                       |   10 -
 drivers/usb/host/xhci-mvebu.h                       |    6 
 drivers/usb/host/xhci-plat.c                        |    2 
 drivers/usb/host/xhci-ring.c                        |   13 -
 drivers/usb/serial/ftdi_sio.c                       |    2 
 drivers/usb/serial/ftdi_sio_ids.h                   |    5 
 drivers/usb/serial/option.c                         |    3 
 drivers/usb/serial/usb-serial-simple.c              |    7 
 drivers/usb/storage/unusual_uas.h                   |    7 
 drivers/xen/Kconfig                                 |    2 
 fs/btrfs/file.c                                     |    9 -
 fs/ceph/inode.c                                     |    2 
 fs/ext4/block_validity.c                            |    5 
 fs/ext4/inode.c                                     |    9 -
 fs/iomap/buffered-io.c                              |    2 
 fs/namespace.c                                      |   69 ++++---
 fs/ntfs3/file.c                                     |    1 
 fs/smb/client/sess.c                                |   60 ++++--
 fs/smb/client/smb1ops.c                             |   36 ++++
 fs/splice.c                                         |    2 
 include/linux/energy_model.h                        |    1 
 include/media/v4l2-subdev.h                         |   25 ++
 include/soc/qcom/ice.h                              |    2 
 include/trace/stages/stage3_trace_output.h          |    8 
 include/trace/stages/stage7_class_define.h          |    1 
 init/Kconfig                                        |    2 
 io_uring/io_uring.c                                 |   15 -
 io_uring/refs.h                                     |    7 
 kernel/bpf/bpf_cgrp_storage.c                       |   11 -
 kernel/bpf/verifier.c                               |   32 +++
 kernel/dma/contiguous.c                             |    3 
 kernel/events/core.c                                |    6 
 kernel/module/Kconfig                               |    1 
 kernel/panic.c                                      |    6 
 kernel/sched/core.c                                 |   92 ++++------
 kernel/sched/cpudeadline.c                          |    2 
 kernel/sched/cpufreq_schedutil.c                    |   63 +++++--
 kernel/sched/deadline.c                             |    4 
 kernel/sched/fair.c                                 |   40 +++-
 kernel/sched/rt.c                                   |    2 
 kernel/sched/sched.h                                |   28 ---
 kernel/sched/topology.c                             |    7 
 kernel/time/tick-common.c                           |   22 ++
 kernel/trace/bpf_trace.c                            |    7 
 kernel/trace/trace_events.c                         |    7 
 lib/test_ubsan.c                                    |   18 +-
 net/9p/client.c                                     |   30 +--
 net/core/lwtunnel.c                                 |   26 ++
 net/core/selftests.c                                |   18 +-
 net/sched/sch_hfsc.c                                |   23 +-
 net/tipc/monitor.c                                  |    3 
 samples/trace_events/trace-events-sample.h          |   18 +-
 scripts/Makefile.lib                                |    2 
 sound/soc/codecs/wcd934x.c                          |    2 
 sound/soc/qcom/apq8016_sbc.c                        |    2 
 sound/soc/qcom/apq8096.c                            |    2 
 sound/soc/qcom/common.c                             |    2 
 sound/soc/qcom/lpass-apq8016.c                      |    4 
 sound/soc/qcom/lpass-cpu.c                          |    7 
 sound/soc/qcom/lpass-hdmi.c                         |    2 
 sound/soc/qcom/lpass-ipq806x.c                      |    4 
 sound/soc/qcom/lpass-platform.c                     |    2 
 sound/soc/qcom/lpass-sc7180.c                       |    4 
 sound/soc/qcom/lpass-sc7280.c                       |    2 
 sound/soc/qcom/lpass.h                              |    4 
 sound/soc/qcom/qdsp6/q6afe.c                        |    8 
 sound/soc/qcom/qdsp6/q6apm-dai.c                    |   61 +++---
 sound/soc/qcom/qdsp6/q6asm.h                        |   20 +-
 sound/soc/qcom/qdsp6/topology.c                     |    3 
 sound/soc/qcom/sc7180.c                             |    2 
 sound/soc/qcom/sc8280xp.c                           |    2 
 sound/soc/qcom/sdm845.c                             |    2 
 sound/soc/qcom/sdw.c                                |    2 
 sound/soc/qcom/sm8250.c                             |    2 
 sound/soc/qcom/storm.c                              |    2 
 sound/virtio/virtio_pcm.c                           |   21 +-
 tools/bpf/bpftool/prog.c                            |    1 
 tools/objtool/check.c                               |   36 +++-
 tools/testing/selftests/mincore/mincore_selftest.c  |    3 
 tools/testing/selftests/ublk/test_stripe_04.sh      |   24 ++
 201 files changed, 1783 insertions(+), 907 deletions(-)

Adam Xue (1):
      USB: serial: option: add Sierra Wireless EM9291

Al Viro (2):
      fix a couple of races in MNT_TREE_BENEATH handling by do_move_mount()
      qibfs: fix _another_ leak

Alexander Stein (1):
      usb: host: max3421-hcd: Add missing spi_device_id table

Alexander Usyskin (1):
      mei: me: add panther lake H DID

Alexei Starovoitov (1):
      bpf: Fix deadlock between rcu_tasks_trace and event_mutex.

Alexey Nepomnyashih (1):
      xen-netfront: handle NULL returned by xdp_convert_buff_to_frame()

Anastasia Kovaleva (1):
      scsi: core: Clear flags for scsi_cmnd that did not complete

Andrew Jones (1):
      riscv: Provide all alternative macros all the time

Andy Shevchenko (3):
      usb: dwc3: gadget: Refactor loop to avoid NULL endpoints
      usb: dwc3: gadget: Avoid using reserved endpoints on Intel Merrifield
      gpiolib: of: Move Atmel HSMCI quirk up out of the regulator comment

Ard Biesheuvel (1):
      x86/pvh: Call C code via the kernel virtual mapping

Arnd Bergmann (2):
      dma/contiguous: avoid warning about unused size_bytes
      ntb: reduce stack usage in idt_scan_mws

Baokun Li (1):
      ext4: goto right label 'out_mmap_sem' in ext4_setattr()

Basavaraj Natikar (1):
      ntb_hw_amd: Add NTB PCI ID for new gen CPU

Bo-Cun Chen (1):
      net: ethernet: mtk_eth_soc: net: revise NETSYSv3 hardware configuration

Breno Leitao (2):
      spi: tegra210-quad: use WARN_ON_ONCE instead of WARN_ON for timeouts
      spi: tegra210-quad: add rate limiting and simplify timeout error message

Brett Creeley (2):
      pds_core: handle unsupported PDS_CORE_CMD_FW_CONTROL result
      pds_core: Remove unnecessary check in pds_client_adminq_cmd()

Chenyuan Yang (3):
      scsi: ufs: mcq: Add NULL check in ufshcd_mcq_abort()
      pinctrl: renesas: rza2: Fix potential NULL pointer dereference
      usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()

Claudiu Beznea (6):
      clk: renesas: rzg2l: Use u32 for flag and mux_flags
      clk: renesas: rzg2l: Add struct clk_hw_data
      clk: renesas: rzg2l: Remove CPG_SDHI_DSEL from generic header
      clk: renesas: rzg2l: Refactor SD mux driver
      clk: renesas: r9a07g04[34]: Use SEL_SDHI1_STS status configuration for SD1 mux
      clk: renesas: r9a07g04[34]: Fix typo for sel_shdi variable

Cong Wang (2):
      net_sched: hfsc: Fix a UAF vulnerability in class handling
      net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too

Craig Hesling (1):
      USB: serial: simple: add OWON HDS200 series oscilloscope support

Damien Le Moal (4):
      ata: libata-scsi: Improve CDL control
      ata: libata-scsi: Fix ata_mselect_control_ata_feature() return type
      ata: libata-scsi: Fix ata_msense_control_ata_feature()
      scsi: Improve CDL control

Daniel Borkmann (1):
      vmxnet3: Fix malformed packet sizing in vmxnet3_process_xdp

Daniel Golle (1):
      net: dsa: mt7530: sync driver-specific behavior of MT7531 variants

Daniel Wagner (2):
      nvmet-fc: take tgtport reference only once
      nvmet-fc: put ref when assoc->del_work is already scheduled

David Howells (1):
      ceph: Fix incorrect flush end position calculation

Devaraj Rangasamy (1):
      crypto: ccp - Add support for PCI device 0x1134

Dmitry Torokhov (3):
      Revert "drivers: core: synchronize really_probe() and dev_uevent()"
      driver core: introduce device_set_driver() helper
      driver core: fix potential NULL pointer dereference in dev_uevent()

Dominique Martinet (1):
      9p/net: fix improper handling of bogus negative read/write replies

Edward Adam Davis (1):
      fs/ntfs3: Fix WARNING in ntfs_extend_initialized_size

Fedor Pchelkin (3):
      usb: chipidea: ci_hdrc_imx: fix usbmisc handling
      usb: chipidea: ci_hdrc_imx: fix call balance of regulator routines
      usb: chipidea: ci_hdrc_imx: implement usb_phy_init() error handling

Fernando Fernandez Mancera (1):
      x86/i8253: Call clockevent_i8253_disable() with interrupts disabled

Fiona Klute (1):
      net: phy: microchip: force IRQ polling mode for lan88xx

Frode Isaksen (1):
      usb: dwc3: gadget: check that event count does not exceed event buffer length

Gabriel Shahrouzi (1):
      perf/core: Fix WARN_ON(!ctx) in __free_event() for partial init

Gou Hao (1):
      iomap: skip unnecessary ifs_block_is_uptodate check

Greg Kroah-Hartman (1):
      Linux 6.6.89

Gregory CLEMENT (1):
      MIPS: cm: Detect CM quirks from device tree

Halil Pasic (1):
      virtio_console: fix missing byte order handling for cols and rows

Hannes Reinecke (3):
      nvme: requeue namespace scan on missed AENs
      nvme: re-read ANA log page after ns scan completes
      nvme: fixup scan failure for non-ANA multipath controllers

Haoxiang Li (4):
      auxdisplay: hd44780: Fix an API misuse in hd44780.c
      mcb: fix a double free bug in chameleon_parse_gdd()
      s390/sclp: Add check for get_zeroed_page()
      s390/tty: Fix a potential memory leak bug

Heiko Stuebner (1):
      clk: check for disabled clock-provider in of_clk_get_hw_from_clkspec()

Henry Martin (3):
      cpufreq: apple-soc: Fix null-ptr-deref in apple_soc_cpufreq_get_rate()
      cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
      cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()

Herbert Xu (1):
      crypto: null - Use spin lock instead of mutex

Huacai Chen (1):
      USB: OHCI: Add quirk for LS7A OHCI controller (rev 0x02)

Huisong Li (1):
      mailbox: pcc: Fix the possible race in updation of chan_in_use flag

Ian Abbott (1):
      comedi: jr3_pci: Fix synchronous deletion of timer

Igor Pylypiv (1):
      scsi: pm80xx: Set phy_attached to zero when device is gone

Jason Andryuk (1):
      xen: Change xen-acpi-processor dom0 dependency

Jean-Marc Eurin (1):
      ACPI PPTT: Fix coding mistakes in a couple of sizeof() calls

Jens Axboe (1):
      io_uring: fix 'sync' handling of io_fallback_tw()

John Stultz (1):
      sound/virtio: Fix cancel_sync warnings on uninitialized work_structs

Jonathan Cameron (1):
      iio: adc: ad7768-1: Move setting of val a bit later to avoid unnecessary return value check

Josh Poimboeuf (11):
      objtool: Silence more KCOV warnings
      objtool, panic: Disable SMAP in __stack_chk_fail()
      objtool, ASoC: codecs: wcd934x: Remove potential undefined behavior in wcd934x_slim_irq_handler()
      objtool, regulator: rk808: Remove potential undefined behavior in rk806_set_mode_dcdc()
      objtool, lkdtm: Obfuscate the do_nothing() pointer
      objtool: Stop UNRET validation on UD2
      x86/bugs: Use SBPB in write_ibpb() if applicable
      x86/bugs: Don't fill RSB on VMEXIT with eIBRS+retpoline
      x86/bugs: Don't fill RSB on context switch with eIBRS
      objtool: Ignore end-of-section jumps for KCOV/GCOV
      objtool: Silence more KCOV warnings, part 2

Justin Iurman (1):
      net: lwtunnel: disable BHs when required

Krzysztof Kozlowski (2):
      ASoC: qcom: q6apm-dai: drop unused 'q6apm_dai_rtd' fields
      ASoC: qcom: Fix trivial code style issues

Lad Prabhakar (1):
      clk: renesas: r9a07g043: Fix HP clock source for RZ/Five

Lukas Stockmann (1):
      rtc: pcf85063: do a SW reset if POR failed

Luo Gengkun (1):
      perf/x86: Fix non-sampling (counting) events on certain x86 platforms

Ma Ke (1):
      PCI: Fix reference leak in pci_register_host_bridge()

Marc Zyngier (1):
      cpufreq: cppc: Fix invalid return value in .get() callback

Marek Behún (7):
      net: dsa: mv88e6xxx: fix internal PHYs for 6320 family
      net: dsa: mv88e6xxx: fix VTU methods for 6320 family
      crypto: atmel-sha204a - Set hwrng quality to lowest possible
      net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
      net: dsa: mv88e6xxx: enable PVT for 6321 switch
      net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
      net: dsa: mv88e6xxx: enable STU methods for 6320 family

Mario Limonciello (1):
      ACPI: EC: Set ec_no_wakeup for Lenovo Go S

Martin KaFai Lau (1):
      bpf: Only fails the busy counter check in bpf_cgrp_storage_get if it creates storage

Meir Elisha (1):
      md/raid1: Add check for missing source disk in process_checks()

Miao Li (2):
      usb: quirks: add DELAY_INIT quirk for Silicon Motion Flash Drive
      usb: quirks: Add delay init quirk for SanDisk 3.2Gen1 Flash Drive

Michael Ehrenreich (1):
      USB: serial: ftdi_sio: add support for Abacus Electrics Optical Probe

Michal Pecio (2):
      usb: xhci: Fix invalid pointer dereference in Etron workaround
      usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems Running

Mika Westerberg (1):
      thunderbolt: Scan retimers after device router has been enumerated

Mike Looijmans (1):
      usb: dwc3: xilinx: Prevent spike in reset signal

Ming Lei (1):
      selftests: ublk: fix test_stripe_04

Ming Wang (1):
      LoongArch: Return NULL from huge_pte_offset() for invalid PMD

Mostafa Saleh (1):
      ubsan: Fix panic from test_ubsan_out_of_bounds

Nikita Zhandarovich (1):
      media: vimc: skip .s_stream() for stopped entities

Ninad Malwade (1):
      arm64: tegra: Remove the Orin NX/Nano suspend key

Ojaswin Mujoo (1):
      ext4: make block validity check resistent to sb bh corruption

Oleg Nesterov (1):
      sched/isolation: Make CONFIG_CPU_ISOLATION depend on CONFIG_SMP

Oleksij Rempel (1):
      net: selftests: initialize TCP header and skb payload with zero

Oliver Neukum (6):
      USB: storage: quirk for ADATA Portable HDD CH94
      USB: VLI disk crashes if LPM is used
      USB: wdm: handle IO errors in wdm_wwan_port_start
      USB: wdm: close race between wdm_open and wdm_wwan_port_stop
      USB: wdm: wdm_wwan_port_tx_complete mutex in atomic context
      USB: wdm: add annotation

Pali Rohár (2):
      cifs: Fix encoding of SMB1 Session Setup Kerberos Request in non-UNICODE mode
      cifs: Fix querying of WSL CHR and BLK reparse points over SMB1

Pavel Begunkov (1):
      io_uring: always do atomic put from iowq

Peter Griffin (1):
      scsi: ufs: exynos: Ensure pre_link() executes before exynos_ufs_phy_init()

Petr Tesarik (1):
      LoongArch: Remove a bogus reference to ZONE_DMA

Pi Xiange (1):
      x86/cpu: Add CPU model number for Bartlett Lake CPUs with Raptor Cove cores

Qingfang Deng (1):
      net: phy: leds: fix memory leak

Qiuxu Zhuo (1):
      selftests/mincore: Allow read-ahead pages to reach the end of the file

Qu Wenruo (1):
      btrfs: avoid page_lockend underflow in btrfs_punch_hole_lock_range()

Rafael J. Wysocki (1):
      cpufreq/sched: Explicitly synchronize limits_changed flag handling

Ralph Siemsen (1):
      usb: cdns3: Fix deadlock when using NCM gadget

Rengarajan S (2):
      misc: microchip: pci1xxxx: Fix Kernel panic during IRQ handler registration
      misc: microchip: pci1xxxx: Fix incorrect IRQ status handling during ack

Rob Herring (Arm) (1):
      of: resolver: Simplify of_resolve_phandles() using __free()

Roman Li (2):
      drm/amd/display: Fix gpu reset in multidisplay config
      drm/amd/display: Force full update in gpu reset

Ryo Takakura (1):
      serial: sifive: lock port in startup()/shutdown() callbacks

Sean Christopherson (4):
      iommu/amd: Return an error if vCPU affinity is set for non-vCPU IRTE
      KVM: SVM: Allocate IR data using atomic allocation
      KVM: x86: Explicitly treat routing entry type changes as changes
      KVM: x86: Reset IRTE to host control if *new* route isn't postable

Sebastian Andrzej Siewior (1):
      timekeeping: Add a lockdep override in tick_freeze()

Sergiu Cuciurean (1):
      iio: adc: ad7768-1: Fix conversion result sign

Sewon Nam (1):
      bpf: bpftool: Setting error code in do_loader()

Shannon Nelson (1):
      pds_core: make wait_context part of q_info

Shuai Xue (1):
      x86/mce: use is_copy_from_user() to determine copy-from-user context

Smita Koralahalli (1):
      cxl/core/regs.c: Skip Memory Space Enable check for RCD and RCH Ports

Srinivas Kandagatla (2):
      ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs
      ASoC: q6apm-dai: make use of q6apm_get_hw_pointer

Stephan Gerhold (1):
      serial: msm: Configure correct working mode before starting earlycon

Steven Rostedt (2):
      tracing: Add __print_dynamic_array() helper
      tracing: Verify event formats that have "%*p.."

Steven Rostedt (Google) (1):
      tracing: Add __string_len() example

Sudeep Holla (1):
      mailbox: pcc: Always clear the platform ack interrupt first

Suzuki K Poulose (1):
      irqchip/gic-v2m: Prevent use after free of gicv2m_get_fwnode()

T.J. Mercier (1):
      splice: remove duplicate noinline from pipe_clear_nowait

Tamura Dai (1):
      spi: spi-imx: Add check for spi_imx_setupxfer()

Thadeu Lima de Souza Cascardo (1):
      char: misc: register chrdev region with all possible minors

Thomas Bogendoerfer (1):
      MIPS: cm: Fix warning if MIPS_CM is disabled

Thomas Weißschuh (2):
      KVM: s390: Don't use %pK through tracepoints
      KVM: s390: Don't use %pK through debug printing

Thorsten Leemhuis (1):
      module: sign with sha512 instead of sha1 by default

Théo Lebrun (1):
      usb: host: xhci-plat: mvebu: use ->quirks instead of ->init_quirk() func

Tiezhu Yang (2):
      LoongArch: Make regs_irqs_disabled() more clear
      LoongArch: Make do_xyz() exception handlers more robust

Tomi Valkeinen (3):
      media: subdev: Fix use of sd->enabled_streams in call_s_stream()
      media: subdev: Improve v4l2_subdev_enable/disable_streams_fallback
      media: subdev: Add v4l2_subdev_is_streaming()

Tong Tiangen (1):
      x86/extable: Remove unused fixup type EX_TYPE_COPY

Tudor Ambarus (3):
      soc: qcom: ice: introduce devm_of_qcom_ice_get
      mmc: sdhci-msm: fix dev reference leaked through of_qcom_ice_get
      scsi: ufs: qcom: fix dev reference leaked through of_qcom_ice_get

Tung Nguyen (1):
      tipc: fix NULL pointer dereference in tipc_mon_reinit_self()

Uday Shankar (1):
      nvme: multipath: fix return value of nvme_available_path

Uwe Kleine-König (2):
      auxdisplay: hd44780: Convert to platform remove callback returning void
      ASoC: qcom: lpass: Make asoc_qcom_lpass_cpu_platform_remove() return void

Vincent Guittot (2):
      sched/topology: Consolidate and clean up access to a CPU's max compute capacity
      sched/cpufreq: Rework schedutil governor performance estimation

Vinicius Costa Gomes (1):
      dmaengine: dmatest: Fix dmatest waiting less when interrupted

Xiaogang Chen (1):
      udmabuf: fix a buf size overflow issue during udmabuf creation

Xingui Yang (1):
      scsi: hisi_sas: Fix I/O errors caused by hardware port ID changes

Yafang Shao (1):
      bpf: Reject attaching fexit/fmod_ret to __noreturn functions

Yu-Chun Lin (1):
      parisc: PDT: Fix missing prototype warning

Yuli Wang (1):
      LoongArch: Select ARCH_USE_MEMTEST

Yunlong Xing (1):
      loop: aio inherit the ioprio of original request

Zijun Hu (1):
      of: resolver: Fix device node refcount leakage in of_resolve_phandles()


