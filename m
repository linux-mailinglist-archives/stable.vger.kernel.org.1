Return-Path: <stable+bounces-139440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6F8AA6A77
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 08:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3974A504B
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 06:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C911EDA3A;
	Fri,  2 May 2025 06:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S1R5zm1U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D41F1E5B93;
	Fri,  2 May 2025 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166061; cv=none; b=bGeD1K9iyT+odDJBkDfHr9zQvuUH6xqAvbLgryGTGs5jfEfLTxnDqrIsPvjogOf2B+t6GhnMQ0dZa43bvmBNy8TJxDMsqdWCcwHJsGzErniC4jEh8PupNujDG+6xCLf2NAC07B/trB+l1nWcXkH1378H8dBk5gHvzyPJoEGVu3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166061; c=relaxed/simple;
	bh=mMhteHfdOns4XE3TmHDMj9/SEUk8dpRAXbMKoIsQx+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UL1OTFgFAFMpUjRpc9D4csMu6/7UyEr4J6p6Jz56UuGNKzwsaTEP5YAlYwoO7xojMULqPu9DgIlD7Kn2UqRgcY7cwNojViZgAsREWISNw0XSiAd9VAYPW2tBPdjNTo61FOCTz3YvE4xbAs8/W5Stw0wrthAK4tYg/Ln1IUWbEBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S1R5zm1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256B5C4CEE9;
	Fri,  2 May 2025 06:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746166060;
	bh=mMhteHfdOns4XE3TmHDMj9/SEUk8dpRAXbMKoIsQx+g=;
	h=From:To:Cc:Subject:Date:From;
	b=S1R5zm1UyfQqc6GF4xAqFrF3bHUcgvKomvkqkmsT2Z57Y4Rh9rUWXWP0gGKqVZuwu
	 jmPwOD+vE5zk+r+Yjzv+Z27GhOQSb9Iiw133MneDAneuhdodT5yYp5LV2orZAObXhH
	 V7l2uRablTKhMDi8mMUZK+HUxG+j8joZmOxHPQhg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.136
Date: Fri,  2 May 2025 08:07:20 +0200
Message-ID: <2025050221-unwashed-food-9850@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.136 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                               |    2 
 arch/loongarch/Kconfig                                 |    1 
 arch/loongarch/include/asm/ptrace.h                    |    4 
 arch/loongarch/mm/hugetlbpage.c                        |    2 
 arch/loongarch/mm/init.c                               |    3 
 arch/mips/include/asm/mips-cm.h                        |   22 ++
 arch/mips/kernel/mips-cm.c                             |   14 +
 arch/parisc/kernel/pdt.c                               |    2 
 arch/s390/kvm/trace-s390.h                             |    4 
 arch/x86/entry/entry.S                                 |    2 
 arch/x86/events/core.c                                 |    2 
 arch/x86/kernel/cpu/bugs.c                             |   30 +-
 arch/x86/kernel/i8253.c                                |    3 
 arch/x86/kvm/svm/avic.c                                |   60 +++--
 arch/x86/kvm/vmx/posted_intr.c                         |   28 --
 arch/x86/kvm/x86.c                                     |    3 
 arch/x86/mm/tlb.c                                      |    6 
 crypto/crypto_null.c                                   |   39 ++-
 drivers/acpi/ec.c                                      |   28 ++
 drivers/acpi/pptt.c                                    |    4 
 drivers/auxdisplay/hd44780.c                           |    9 
 drivers/block/loop.c                                   |    2 
 drivers/char/virtio_console.c                          |    7 
 drivers/clk/clk.c                                      |    4 
 drivers/clk/renesas/r9a07g043-cpg.c                    |   28 ++
 drivers/clk/renesas/r9a07g044-cpg.c                    |   21 +
 drivers/clk/renesas/rzg2l-cpg.c                        |  180 ++++++++++++-----
 drivers/clk/renesas/rzg2l-cpg.h                        |   24 +-
 drivers/comedi/drivers/jr3_pci.c                       |   17 +
 drivers/cpufreq/cppc_cpufreq.c                         |    2 
 drivers/cpufreq/scmi-cpufreq.c                         |   10 
 drivers/cpufreq/scpi-cpufreq.c                         |   13 -
 drivers/crypto/atmel-sha204a.c                         |    7 
 drivers/dma-buf/udmabuf.c                              |    2 
 drivers/dma/dmatest.c                                  |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      |    9 
 drivers/iio/adc/ad7768-1.c                             |    5 
 drivers/infiniband/hw/qib/qib_fs.c                     |    1 
 drivers/iommu/amd/iommu.c                              |    2 
 drivers/mcb/mcb-parse.c                                |    2 
 drivers/md/raid1.c                                     |   26 +-
 drivers/misc/lkdtm/perms.c                             |   14 +
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c        |    8 
 drivers/misc/mei/hw-me-regs.h                          |    1 
 drivers/misc/mei/pci-me.c                              |    1 
 drivers/net/dsa/mv88e6xxx/chip.c                       |  106 ++++++----
 drivers/net/dsa/mv88e6xxx/chip.h                       |    5 
 drivers/net/dsa/mv88e6xxx/global2.c                    |   25 --
 drivers/net/phy/phy_led_triggers.c                     |   23 +-
 drivers/net/wireless/realtek/rtw88/main.c              |    2 
 drivers/net/wireless/realtek/rtw88/tx.c                |    2 
 drivers/net/xen-netfront.c                             |   17 +
 drivers/ntb/hw/amd/ntb_hw_amd.c                        |    1 
 drivers/ntb/hw/idt/ntb_hw_idt.c                        |   18 -
 drivers/nvme/host/core.c                               |    9 
 drivers/nvme/target/fc.c                               |   25 --
 drivers/of/device.c                                    |    7 
 drivers/of/resolver.c                                  |   37 +--
 drivers/pci/pci.c                                      |  103 +++++----
 drivers/pci/probe.c                                    |   16 +
 drivers/pci/remove.c                                   |    7 
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c             |   46 +++-
 drivers/pinctrl/renesas/pinctrl-rza2.c                 |    3 
 drivers/rtc/rtc-pcf85063.c                             |   19 +
 drivers/s390/char/sclp_con.c                           |   17 +
 drivers/s390/char/sclp_tty.c                           |   12 +
 drivers/scsi/hisi_sas/hisi_sas_main.c                  |   20 +
 drivers/scsi/pm8001/pm8001_sas.c                       |    1 
 drivers/scsi/scsi_lib.c                                |    6 
 drivers/spi/spi-imx.c                                  |    5 
 drivers/spi/spi-tegra210-quad.c                        |    6 
 drivers/thunderbolt/tb.c                               |   16 +
 drivers/tty/serial/msm_serial.c                        |    6 
 drivers/tty/serial/sifive.c                            |    6 
 drivers/ufs/host/ufs-exynos.c                          |   10 
 drivers/usb/cdns3/cdns3-gadget.c                       |    2 
 drivers/usb/chipidea/ci_hdrc_imx.c                     |   44 ++--
 drivers/usb/class/cdc-wdm.c                            |   21 +
 drivers/usb/core/quirks.c                              |    9 
 drivers/usb/dwc3/dwc3-pci.c                            |   10 
 drivers/usb/dwc3/dwc3-xilinx.c                         |    4 
 drivers/usb/dwc3/gadget.c                              |   28 ++
 drivers/usb/gadget/udc/aspeed-vhub/dev.c               |    3 
 drivers/usb/host/max3421-hcd.c                         |    7 
 drivers/usb/host/ohci-pci.c                            |   23 ++
 drivers/usb/host/xhci-mvebu.c                          |   10 
 drivers/usb/host/xhci-mvebu.h                          |    6 
 drivers/usb/host/xhci-plat.c                           |    2 
 drivers/usb/host/xhci-ring.c                           |   11 -
 drivers/usb/serial/ftdi_sio.c                          |    2 
 drivers/usb/serial/ftdi_sio_ids.h                      |    5 
 drivers/usb/serial/option.c                            |    3 
 drivers/usb/serial/usb-serial-simple.c                 |    7 
 drivers/usb/storage/unusual_uas.h                      |    7 
 drivers/video/backlight/led_bl.c                       |   11 -
 drivers/xen/Kconfig                                    |    2 
 fs/btrfs/file.c                                        |    9 
 fs/ext4/block_validity.c                               |    5 
 fs/ext4/inode.c                                        |    7 
 fs/jfs/jfs_dinode.h                                    |    2 
 fs/jfs/jfs_imap.c                                      |    6 
 fs/jfs/jfs_incore.h                                    |    2 
 fs/jfs/jfs_txnmgr.c                                    |    4 
 fs/jfs/jfs_xtree.c                                     |    4 
 fs/jfs/jfs_xtree.h                                     |   37 ++-
 fs/ntfs3/file.c                                        |    1 
 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h     |    8 
 include/linux/filter.h                                 |    9 
 include/linux/pci.h                                    |    1 
 include/net/dsa.h                                      |    6 
 include/net/mac80211.h                                 |   13 +
 include/trace/bpf_probe.h                              |    6 
 include/trace/perf.h                                   |    6 
 include/trace/stages/stage1_struct_define.h            |    6 
 include/trace/stages/stage2_data_offsets.h             |    6 
 include/trace/stages/stage3_trace_output.h             |   14 +
 include/trace/stages/stage4_event_fields.h             |   12 +
 include/trace/stages/stage5_get_offsets.h              |    6 
 include/trace/stages/stage6_event_callback.h           |   20 +
 include/trace/stages/stage7_class_define.h             |    3 
 init/Kconfig                                           |    2 
 kernel/dma/contiguous.c                                |    3 
 kernel/module/Kconfig                                  |    1 
 kernel/trace/bpf_trace.c                               |    7 
 kernel/trace/trace_events.c                            |    7 
 lib/test_ubsan.c                                       |   18 +
 net/9p/client.c                                        |   30 +-
 net/core/lwtunnel.c                                    |   26 +-
 net/core/selftests.c                                   |   18 +
 net/dsa/port.c                                         |   32 +++
 net/mac80211/ieee80211_i.h                             |    2 
 net/mac80211/status.c                                  |    1 
 net/sched/act_mirred.c                                 |   22 +-
 net/sched/sch_hfsc.c                                   |   23 +-
 net/tipc/monitor.c                                     |    3 
 samples/trace_events/trace-events-sample.c             |    2 
 samples/trace_events/trace-events-sample.h             |   46 +++-
 scripts/Makefile.lib                                   |    2 
 sound/soc/codecs/wcd934x.c                             |    2 
 sound/soc/qcom/lpass.h                                 |    3 
 sound/soc/qcom/qdsp6/q6afe-dai.c                       |    2 
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c               |   43 ++--
 sound/virtio/virtio_pcm.c                              |   21 +
 tools/objtool/check.c                                  |    9 
 tools/testing/selftests/mincore/mincore_selftest.c     |    3 
 tools/testing/selftests/ublk/test_stripe_04.sh         |   24 ++
 tools/testing/selftests/vm/charge_reserved_hugetlb.sh  |    4 
 tools/testing/selftests/vm/hugetlb_reparenting_test.sh |    2 
 148 files changed, 1429 insertions(+), 575 deletions(-)

Adam Xue (1):
      USB: serial: option: add Sierra Wireless EM9291

Al Viro (1):
      qibfs: fix _another_ leak

Alexander Stein (1):
      usb: host: max3421-hcd: Add missing spi_device_id table

Alexander Usyskin (1):
      mei: me: add panther lake H DID

Alexei Starovoitov (1):
      bpf: Fix deadlock between rcu_tasks_trace and event_mutex.

Alexey Nepomnyashih (1):
      xen-netfront: handle NULL returned by xdp_convert_buff_to_frame()

Alexis Lothoré (2):
      net: dsa: mv88e6xxx: pass directly chip structure to mv88e6xxx_phy_is_internal
      net: dsa: mv88e6xxx: add field to specify internal phys layout

Anastasia Kovaleva (1):
      scsi: core: Clear flags for scsi_cmnd that did not complete

Andy Shevchenko (2):
      usb: dwc3: gadget: Refactor loop to avoid NULL endpoints
      usb: dwc3: gadget: Avoid using reserved endpoints on Intel Merrifield

Arnd Bergmann (2):
      dma/contiguous: avoid warning about unused size_bytes
      ntb: reduce stack usage in idt_scan_mws

Basavaraj Natikar (1):
      ntb_hw_amd: Add NTB PCI ID for new gen CPU

Breno Leitao (2):
      spi: tegra210-quad: use WARN_ON_ONCE instead of WARN_ON for timeouts
      spi: tegra210-quad: add rate limiting and simplify timeout error message

Chenyuan Yang (2):
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

Daniel Wagner (2):
      nvmet-fc: take tgtport reference only once
      nvmet-fc: put ref when assoc->del_work is already scheduled

Dave Kleikamp (1):
      jfs: define xtree root and page independently

Dominique Martinet (1):
      9p/net: fix improper handling of bogus negative read/write replies

Edward Adam Davis (1):
      fs/ntfs3: Fix WARNING in ntfs_extend_initialized_size

Evgeny Pimenov (1):
      ASoC: qcom: Fix sc7280 lpass potential buffer overflow

Fedor Pchelkin (3):
      usb: chipidea: ci_hdrc_imx: fix usbmisc handling
      usb: chipidea: ci_hdrc_imx: fix call balance of regulator routines
      usb: chipidea: ci_hdrc_imx: implement usb_phy_init() error handling

Fernando Fernandez Mancera (1):
      x86/i8253: Call clockevent_i8253_disable() with interrupts disabled

Frode Isaksen (1):
      usb: dwc3: gadget: check that event count does not exceed event buffer length

Greg Kroah-Hartman (1):
      Linux 6.1.136

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

Henry Martin (2):
      cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
      cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()

Herbert Xu (1):
      crypto: null - Use spin lock instead of mutex

Herve Codina (1):
      backlight: led_bl: Hold led_access lock when calling led_sysfs_disable()

Huacai Chen (1):
      USB: OHCI: Add quirk for LS7A OHCI controller (rev 0x02)

Ian Abbott (1):
      comedi: jr3_pci: Fix synchronous deletion of timer

Igor Pylypiv (1):
      scsi: pm80xx: Set phy_attached to zero when device is gone

Jakub Kicinski (1):
      net/sched: act_mirred: don't override retval if we already lost the skb

Jason Andryuk (1):
      xen: Change xen-acpi-processor dom0 dependency

Jean-Marc Eurin (1):
      ACPI PPTT: Fix coding mistakes in a couple of sizeof() calls

John Stultz (1):
      sound/virtio: Fix cancel_sync warnings on uninitialized work_structs

Jonathan Cameron (1):
      iio: adc: ad7768-1: Move setting of val a bit later to avoid unnecessary return value check

Josh Poimboeuf (8):
      objtool: Silence more KCOV warnings
      objtool, ASoC: codecs: wcd934x: Remove potential undefined behavior in wcd934x_slim_irq_handler()
      objtool, lkdtm: Obfuscate the do_nothing() pointer
      objtool: Stop UNRET validation on UD2
      x86/bugs: Use SBPB in write_ibpb() if applicable
      x86/bugs: Don't fill RSB on VMEXIT with eIBRS+retpoline
      x86/bugs: Don't fill RSB on context switch with eIBRS
      objtool: Silence more KCOV warnings, part 2

Justin Iurman (1):
      net: lwtunnel: disable BHs when required

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

Mark Brown (1):
      selftests/mm: generate a temporary mountpoint for cgroup filesystem

Meir Elisha (1):
      md/raid1: Add check for missing source disk in process_checks()

Miao Li (2):
      usb: quirks: add DELAY_INIT quirk for Silicon Motion Flash Drive
      usb: quirks: Add delay init quirk for SanDisk 3.2Gen1 Flash Drive

Michael Ehrenreich (1):
      USB: serial: ftdi_sio: add support for Abacus Electrics Optical Probe

Michal Pecio (1):
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

Pali Rohár (1):
      PCI: Assign PCI domain IDs by ida_alloc()

Peter Griffin (1):
      scsi: ufs: exynos: Ensure pre_link() executes before exynos_ufs_phy_init()

Petr Tesarik (1):
      LoongArch: Remove a bogus reference to ZONE_DMA

Ping-Ke Shih (2):
      wifi: mac80211: export ieee80211_purge_tx_queue() for drivers
      wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb

Qingfang Deng (1):
      net: phy: leds: fix memory leak

Qiuxu Zhuo (1):
      selftests/mincore: Allow read-ahead pages to reach the end of the file

Qu Wenruo (1):
      btrfs: avoid page_lockend underflow in btrfs_punch_hole_lock_range()

Ralph Siemsen (1):
      usb: cdns3: Fix deadlock when using NCM gadget

Rengarajan S (2):
      misc: microchip: pci1xxxx: Fix Kernel panic during IRQ handler registration
      misc: microchip: pci1xxxx: Fix incorrect IRQ status handling during ack

Richard Zhu (3):
      phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY support
      phy: freescale: imx8m-pcie: Do CMN_RST just before PHY PLL lock check
      phy: freescale: imx8m-pcie: Add one missing error return

Rob Herring (1):
      PCI: Fix use-after-free in pci_bus_release_domain_nr()

Rob Herring (Arm) (1):
      of: resolver: Simplify of_resolve_phandles() using __free()

Roman Li (2):
      drm/amd/display: Fix gpu reset in multidisplay config
      drm/amd/display: Force full update in gpu reset

Russell King (Oracle) (2):
      net: dsa: add support for mac_prepare() and mac_finish() calls
      net: dsa: mv88e6xxx: move link forcing to mac_prepare/mac_finish

Ryo Takakura (1):
      serial: sifive: lock port in startup()/shutdown() callbacks

Sean Christopherson (4):
      iommu/amd: Return an error if vCPU affinity is set for non-vCPU IRTE
      KVM: SVM: Allocate IR data using atomic allocation
      KVM: x86: Explicitly treat routing entry type changes as changes
      KVM: x86: Reset IRTE to host control if *new* route isn't postable

Sebastian Andrzej Siewior (1):
      xdp: Reset bpf_redirect_info before running a xdp's BPF prog.

Sergey Shtylyov (1):
      of: module: add buffer overflow check in of_modalias()

Sergiu Cuciurean (1):
      iio: adc: ad7768-1: Fix conversion result sign

Srinivas Kandagatla (2):
      ASoC: qcom: q6dsp: add support to more display ports
      ASoC: qcom: q6afe-dai: fix Display Port Playback stream name

Stefan Eichenberger (1):
      phy: freescale: imx8m-pcie: assert phy reset and perst in power off

Stephan Gerhold (1):
      serial: msm: Configure correct working mode before starting earlycon

Steven Rostedt (2):
      tracing: Add __print_dynamic_array() helper
      tracing: Verify event formats that have "%*p.."

Steven Rostedt (Google) (4):
      tracing: Add __cpumask to denote a trace event field that is a cpumask_t
      tracing: Fix cpumask() example typo
      tracing: Add __string_len() example
      tracing: Remove pointer (asterisk) and brackets from cpumask_t field

Tamura Dai (1):
      spi: spi-imx: Add check for spi_imx_setupxfer()

Thomas Bogendoerfer (1):
      MIPS: cm: Fix warning if MIPS_CM is disabled

Thomas Weißschuh (1):
      KVM: s390: Don't use %pK through tracepoints

Thorsten Leemhuis (1):
      module: sign with sha512 instead of sha1 by default

Théo Lebrun (1):
      usb: host: xhci-plat: mvebu: use ->quirks instead of ->init_quirk() func

Tiezhu Yang (1):
      LoongArch: Make regs_irqs_disabled() more clear

Tung Nguyen (1):
      tipc: fix NULL pointer dereference in tipc_mon_reinit_self()

Uwe Kleine-König (2):
      auxdisplay: hd44780: Convert to platform remove callback returning void
      backlight: led_bl: Convert to platform remove callback returning void

Vinicius Costa Gomes (1):
      dmaengine: dmatest: Fix dmatest waiting less when interrupted

Vladimir Oltean (1):
      net: dsa: mv88e6xxx: don't dispose of Global2 IRQ mappings from mdiobus code

Xiaogang Chen (1):
      udmabuf: fix a buf size overflow issue during udmabuf creation

Xingui Yang (1):
      scsi: hisi_sas: Fix I/O errors caused by hardware port ID changes

Yu-Chun Lin (1):
      parisc: PDT: Fix missing prototype warning

Yuli Wang (1):
      LoongArch: Select ARCH_USE_MEMTEST

Yunlong Xing (1):
      loop: aio inherit the ioprio of original request

Zijun Hu (1):
      of: resolver: Fix device node refcount leakage in of_resolve_phandles()


