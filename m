Return-Path: <stable+bounces-139433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C21AA6A66
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 08:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F183BCE86
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 06:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1C21DF98B;
	Fri,  2 May 2025 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xt+BgoWY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371A1C6FE1;
	Fri,  2 May 2025 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166019; cv=none; b=i1vUFGGqDDB57scYB9Swhq5Fhl6Tymj3GOykzmO8oRMrcPy0/Ze22uwW/UMA5H0m+elN05htgq59Ps+G/jerwby8y2aihR8j+h0k7q+pCpxSxcOT3xkAk+Zz+25ylO/DaXYOwemfpHBBVcMhuJ/PtQxvoYNeDjPY0FdhLsrmoYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166019; c=relaxed/simple;
	bh=9Ki6OpGE+YpodptrlDwbZh0fsaNUlQvQuwVRqb3g2Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oHwi0ews1KzqsX0g5nQ9FBLVush9Td6Wo57JIwOp9G7W49QCRCUoJREhHVjW1Fvo6dCBnxustmr2o4aTdVeTCrhkJXetE/sk0BY627BkaVhFqZiPp2PlaqXXwAmfs7i/pd4r8EDdORsKkQ4CiBzbnTLV1zbiqSp2eD3PqfCeRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xt+BgoWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC69C4CEE4;
	Fri,  2 May 2025 06:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746166018;
	bh=9Ki6OpGE+YpodptrlDwbZh0fsaNUlQvQuwVRqb3g2Kw=;
	h=From:To:Cc:Subject:Date:From;
	b=xt+BgoWY8vJ59JuLnnnXrCjwnn5bpLLA183Rg/0PNd6ePX9XlTdTlhjCCt4hwt2tc
	 7ifpnvbcWmv6nLDAy9dMgqVxmDfSUMyfZ5xJY0hUD3omGPEu280jjr4FFg7lYwOv5u
	 btuh0F3ajiNMqHOji15OfLY+/wAH9lmzF/ZXvZ6k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.293
Date: Fri,  2 May 2025 08:06:53 +0200
Message-ID: <2025050254-cycle-patchy-ba3a@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.293 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    5 
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                    |    6 
 arch/arm64/include/asm/cputype.h                            |    2 
 arch/mips/dec/prom/init.c                                   |    2 
 arch/mips/include/asm/ds1287.h                              |    2 
 arch/mips/include/asm/mips-cm.h                             |   22 ++
 arch/mips/kernel/cevt-ds1287.c                              |    1 
 arch/mips/kernel/mips-cm.c                                  |   14 +
 arch/parisc/kernel/pdt.c                                    |    2 
 arch/powerpc/kernel/Makefile                                |    1 
 arch/riscv/include/asm/syscall.h                            |    7 
 arch/s390/kvm/trace-s390.h                                  |    4 
 arch/sparc/mm/tlb.c                                         |    5 
 arch/x86/events/intel/ds.c                                  |    8 
 arch/x86/events/intel/uncore_snbep.c                        |   16 -
 arch/x86/kernel/cpu/amd.c                                   |    2 
 arch/x86/kernel/cpu/bugs.c                                  |    8 
 arch/x86/kernel/e820.c                                      |   17 -
 crypto/crypto_null.c                                        |   39 ++-
 drivers/acpi/pptt.c                                         |    4 
 drivers/ata/ahci.c                                          |    2 
 drivers/ata/libata-eh.c                                     |   11 -
 drivers/ata/pata_pxa.c                                      |    6 
 drivers/ata/sata_sx4.c                                      |  118 ++++--------
 drivers/bluetooth/btrtl.c                                   |    2 
 drivers/bluetooth/hci_ldisc.c                               |   19 +
 drivers/bluetooth/hci_uart.h                                |    1 
 drivers/char/virtio_console.c                               |    7 
 drivers/clk/clk.c                                           |    4 
 drivers/cpufreq/cpufreq.c                                   |    8 
 drivers/cpufreq/scpi-cpufreq.c                              |   13 +
 drivers/crypto/atmel-sha204a.c                              |    7 
 drivers/crypto/ccp/sp-pci.c                                 |   15 -
 drivers/dma-buf/udmabuf.c                                   |    2 
 drivers/dma/dmatest.c                                       |    6 
 drivers/gpio/gpio-zynq.c                                    |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                    |   10 +
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c      |    2 
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c        |    2 
 drivers/gpu/drm/drm_atomic_helper.c                         |    2 
 drivers/gpu/drm/drm_panel_orientation_quirks.c              |   10 -
 drivers/gpu/drm/mediatek/mtk_dpi.c                          |    9 
 drivers/gpu/drm/nouveau/nouveau_bo.c                        |    3 
 drivers/gpu/drm/nouveau/nouveau_gem.c                       |    3 
 drivers/gpu/drm/sti/Makefile                                |    2 
 drivers/gpu/drm/tiny/repaper.c                              |    4 
 drivers/hid/usbhid/hid-pidff.c                              |   60 ++++--
 drivers/hsi/clients/ssi_protocol.c                          |    1 
 drivers/i2c/busses/i2c-cros-ec-tunnel.c                     |    3 
 drivers/i3c/master.c                                        |    3 
 drivers/iio/adc/ad7768-1.c                                  |    5 
 drivers/infiniband/hw/qib/qib_fs.c                          |    1 
 drivers/infiniband/hw/usnic/usnic_ib_main.c                 |   14 -
 drivers/infiniband/ulp/srpt/ib_srpt.c                       |    8 
 drivers/mcb/mcb-parse.c                                     |    2 
 drivers/md/dm-integrity.c                                   |    3 
 drivers/md/raid1.c                                          |   26 +-
 drivers/media/common/siano/smsdvb-main.c                    |    2 
 drivers/media/i2c/adv748x/adv748x.h                         |    2 
 drivers/media/i2c/ov7251.c                                  |    4 
 drivers/media/platform/qcom/venus/hfi_parser.c              |    2 
 drivers/media/platform/qcom/venus/hfi_venus.c               |   18 +
 drivers/media/platform/vim2m.c                              |    6 
 drivers/media/rc/streamzap.c                                |   68 +++---
 drivers/media/v4l2-core/v4l2-dv-timings.c                   |    4 
 drivers/misc/pci_endpoint_test.c                            |   36 ++-
 drivers/mmc/host/cqhci.c                                    |    2 
 drivers/mtd/inftlcore.c                                     |    9 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                    |    2 
 drivers/mtd/nand/raw/r852.c                                 |    3 
 drivers/net/dsa/b53/b53_common.c                            |   10 +
 drivers/net/dsa/mv88e6xxx/chip.c                            |   25 ++
 drivers/net/phy/phy_led_triggers.c                          |   23 +-
 drivers/net/ppp/ppp_synctty.c                               |    5 
 drivers/net/virtio_net.c                                    |   22 +-
 drivers/net/wireless/atmel/at76c50x-usb.c                   |    2 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c             |    1 
 drivers/net/wireless/ti/wl1251/tx.c                         |    4 
 drivers/ntb/hw/idt/ntb_hw_idt.c                             |   18 -
 drivers/ntb/ntb_transport.c                                 |    2 
 drivers/nvme/target/fc.c                                    |   14 -
 drivers/of/irq.c                                            |   13 +
 drivers/pci/probe.c                                         |    5 
 drivers/perf/arm_pmu.c                                      |    8 
 drivers/platform/x86/asus-laptop.c                          |    9 
 drivers/platform/x86/intel_speed_select_if/isst_if_common.c |    2 
 drivers/pwm/pwm-fsl-ftm.c                                   |    6 
 drivers/pwm/pwm-mediatek.c                                  |   20 +-
 drivers/scsi/pm8001/pm8001_sas.c                            |    1 
 drivers/scsi/scsi_transport_iscsi.c                         |    7 
 drivers/scsi/st.c                                           |    2 
 drivers/staging/comedi/drivers/jr3_pci.c                    |   15 +
 drivers/thermal/rockchip_thermal.c                          |    1 
 drivers/tty/serial/sifive.c                                 |    6 
 drivers/usb/cdns3/gadget.c                                  |    2 
 drivers/usb/core/quirks.c                                   |    9 
 drivers/usb/dwc3/core.c                                     |   11 -
 drivers/usb/dwc3/gadget.c                                   |    6 
 drivers/usb/gadget/udc/aspeed-vhub/dev.c                    |    3 
 drivers/usb/host/max3421-hcd.c                              |    7 
 drivers/usb/host/ohci-pci.c                                 |   23 ++
 drivers/usb/serial/ftdi_sio.c                               |    2 
 drivers/usb/serial/ftdi_sio_ids.h                           |    5 
 drivers/usb/serial/option.c                                 |    3 
 drivers/usb/serial/usb-serial-simple.c                      |    7 
 drivers/usb/storage/unusual_uas.h                           |    7 
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c                |    6 
 drivers/xen/xenfs/xensyms.c                                 |    4 
 fs/Kconfig                                                  |    1 
 fs/btrfs/super.c                                            |    3 
 fs/ext4/dir.c                                               |   12 -
 fs/ext4/inode.c                                             |   69 +++++--
 fs/ext4/namei.c                                             |    2 
 fs/ext4/super.c                                             |   61 +++---
 fs/ext4/xattr.c                                             |   11 +
 fs/fuse/virtio_fs.c                                         |    3 
 fs/hfs/bnode.c                                              |    6 
 fs/hfsplus/bnode.c                                          |    6 
 fs/isofs/export.c                                           |    2 
 fs/jbd2/journal.c                                           |    1 
 fs/jfs/jfs_dmap.c                                           |   10 -
 fs/jfs/jfs_imap.c                                           |    2 
 fs/nfs/Kconfig                                              |    2 
 fs/nfs/internal.h                                           |   22 --
 fs/nfs/nfs4session.h                                        |    4 
 fs/nfsd/Kconfig                                             |    1 
 fs/nfsd/nfsfh.h                                             |   12 -
 include/linux/backing-dev.h                                 |    1 
 include/linux/nfs.h                                         |   13 +
 include/linux/pci.h                                         |    4 
 include/net/sctp/structs.h                                  |    3 
 include/uapi/linux/kfd_ioctl.h                              |    2 
 include/uapi/linux/pcitest.h                                |    3 
 include/xen/interface/xen-mca.h                             |    2 
 init/Kconfig                                                |    3 
 kernel/locking/lockdep.c                                    |    3 
 kernel/trace/ftrace.c                                       |    1 
 kernel/trace/trace_events.c                                 |    4 
 lib/sg_split.c                                              |    2 
 mm/vmscan.c                                                 |    2 
 net/8021q/vlan_dev.c                                        |   31 ---
 net/bluetooth/hci_event.c                                   |    5 
 net/core/dev.c                                              |    1 
 net/core/filter.c                                           |   80 ++++----
 net/core/page_pool.c                                        |    8 
 net/ipv4/inet_connection_sock.c                             |   19 +
 net/mac80211/iface.c                                        |    3 
 net/mac80211/mesh_hwmp.c                                    |   14 +
 net/openvswitch/actions.c                                   |    4 
 net/openvswitch/flow_netlink.c                              |    3 
 net/sched/sch_hfsc.c                                        |   23 +-
 net/sctp/socket.c                                           |   22 +-
 net/sctp/transport.c                                        |    2 
 net/tipc/link.c                                             |    1 
 net/tipc/monitor.c                                          |    3 
 sound/pci/hda/hda_intel.c                                   |   15 +
 sound/usb/midi.c                                            |   80 +++++++-
 tools/power/cpupower/bench/parse.c                          |    4 
 tools/testing/selftests/ublk/test_stripe_04.sh              |   24 ++
 159 files changed, 1106 insertions(+), 545 deletions(-)

Abdun Nihaal (2):
      wifi: at76c50x: fix use after free access in at76_disconnect
      wifi: wl1251: fix memory leak in wl1251_tx_work

Abhinav Kumar (1):
      drm: allow encoder mode_set even when connectors change for crtc

Acs, Jakub (1):
      ext4: fix OOB read when checking dotdot dir

Adam Xue (1):
      USB: serial: option: add Sierra Wireless EM9291

Al Viro (1):
      qibfs: fix _another_ leak

Alexander Stein (1):
      usb: host: max3421-hcd: Add missing spi_device_id table

Andreas Gruenbacher (1):
      writeback: fix false warning in inode_to_wb()

Andrew Wyatt (2):
      drm: panel-orientation-quirks: Add support for AYANEO 2S
      drm: panel-orientation-quirks: Add new quirk for GPD Win 2

AngeloGioacchino Del Regno (1):
      drm/mediatek: mtk_dpi: Explicitly manage TVD clock in power on/off

Arnaud Lecomte (1):
      net: ppp: Add bound checking for skb data on ppp_sync_txmung

Arnd Bergmann (1):
      ntb: reduce stack usage in idt_scan_mws

Arseniy Krasnov (2):
      Bluetooth: hci_uart: fix race during initialization
      Bluetooth: hci_uart: Fix another race during initialization

Artem Sadovnikov (1):
      ext4: fix off-by-one error in do_split

Bart Van Assche (1):
      RDMA/srpt: Support specifying the srpt_service_guid parameter

Ben Dooks (1):
      bpf: Add endian modifiers to fix endian warnings

Bhupesh (1):
      ext4: ignore xattrs past end

Bjorn Helgaas (1):
      PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX

Boqun Feng (1):
      locking/lockdep: Decrease nr_unused_locks if lock unused in zap_class()

Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8173: Fix disp-pwm compatible string

Chengguang Xu (1):
      ext4: code cleanup for ext4_statfs_project()

Chenyuan Yang (1):
      usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()

Chris Bainbridge (1):
      drm/nouveau: prime: fix ttm_bo_delayed_delete oops

Chuck Lever (1):
      NFSD: Constify @fh argument of knfsd_fh_hash()

Cong Wang (2):
      net_sched: hfsc: Fix a UAF vulnerability in class handling
      net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too

Craig Hesling (1):
      USB: serial: simple: add OWON HDS200 series oscilloscope support

Damien Le Moal (1):
      misc: pci_endpoint_test: Use INTX instead of LEGACY

Dan Carpenter (1):
      Bluetooth: btrtl: Prevent potential NULL dereference

Daniel Golle (1):
      pwm: mediatek: always use bus clock for PWM on MT7622

Daniel Kral (1):
      ahci: add PCI ID for Marvell 88SE9215 SATA Controller

Dapeng Mi (1):
      perf/x86/intel: Allow to update user space GPRs from PEBS records

David Yat Sin (1):
      drm/amdkfd: clamp queue size to minimum

Denis Arefev (2):
      asus-laptop: Fix an uninitialized variable
      drm/amd/pm: Prevent division by zero

Douglas Anderson (1):
      arm64: cputype: Add MIDR_CORTEX_A76AE

Edward Adam Davis (3):
      jfs: Prevent copying of nlink with value 0 from disk inode
      jfs: add sanity check for agwidth in dbMount
      isofs: Prevent the use of too small fid

Eric Biggers (2):
      ext4: reject casefold inode flag without casefold feature
      nfs: add missing selections of CONFIG_CRC32

Fabien Parent (1):
      pwm: mediatek: Always use bus clock

Fedor Pchelkin (1):
      ntb: use 64-bit arithmetic for the MSI doorbell mask

Felix Huettner (1):
      net: openvswitch: fix race on port output

Frode Isaksen (1):
      usb: dwc3: gadget: check that event count does not exceed event buffer length

Gabriele Paoloni (1):
      tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER

Gavrilov Ilia (1):
      wifi: mac80211: fix integer overflow in hwmp_route_info_get()

Greg Kroah-Hartman (1):
      Linux 5.4.293

Gregory CLEMENT (1):
      MIPS: cm: Detect CM quirks from device tree

Halil Pasic (1):
      virtio_console: fix missing byte order handling for cols and rows

Hannes Reinecke (1):
      ata: sata_sx4: Drop pointless VPRINTK() calls and convert the remaining ones

Haoxiang Li (1):
      mcb: fix a double free bug in chameleon_parse_gdd()

Heiko Stuebner (1):
      clk: check for disabled clock-provider in of_clk_get_hw_from_clkspec()

Henry Martin (2):
      ata: pata_pxa: Fix potential NULL pointer dereference in pxa_ata_probe()
      cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()

Herbert Xu (1):
      crypto: null - Use spin lock instead of mutex

Huacai Chen (1):
      USB: OHCI: Add quirk for LS7A OHCI controller (rev 0x02)

Ian Abbott (1):
      comedi: jr3_pci: Fix synchronous deletion of timer

Icenowy Zheng (1):
      wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table

Igor Pylypiv (1):
      scsi: pm80xx: Set phy_attached to zero when device is gone

Ilya Maximets (2):
      net: openvswitch: fix nested key length validation in the set() action
      openvswitch: fix lockup on tx to unregistering netdev with carrier

Jan Beulich (1):
      xenfs/xensyms: respect hypervisor's "next" indication

Jan Kara (2):
      jbd2: remove wrong sb->s_sequence check
      ext4: simplify checking quota limits in ext4_statfs()

Jann Horn (1):
      ext4: don't treat fhandle lookup of ea_inode as FS corruption

Jason Xing (1):
      page_pool: avoid infinite loop to schedule delayed worker

Jean-Marc Eurin (1):
      ACPI PPTT: Fix coding mistakes in a couple of sizeof() calls

Jeff Layton (1):
      nfs: move nfs_fhandle_hash to common include file

Johannes Berg (1):
      Revert "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

Johannes Kimmel (1):
      btrfs: correctly escape subvol in btrfs_show_options()

Jonas Gorski (1):
      net: b53: enable BPDU reception for management port

Jonathan Cameron (1):
      iio: adc: ad7768-1: Move setting of val a bit later to avoid unnecessary return value check

Josh Poimboeuf (2):
      pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()
      x86/bugs: Don't fill RSB on VMEXIT with eIBRS+retpoline

Kai Mäkisara (1):
      scsi: st: Fix array overflow in st_setup()

Kaixin Wang (1):
      HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition

Kamal Dasu (1):
      mtd: rawnand: brcmnand: fix PM resume warning

Kan Liang (1):
      perf/x86/intel/uncore: Fix the scale of IIO free running counters on SNR

Karina Yankevich (1):
      media: v4l2-dv-timings: prevent possible overflow in v4l2_detect_gtf()

Kees Cook (1):
      xen/mcelog: Add __nonstring annotations for unterminated strings

Krzysztof Kozlowski (1):
      gpio: zynq: Fix wakeup source leaks on device unbind

Kunihiko Hayashi (3):
      misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
      misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
      misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error

Kuniyuki Iwashima (1):
      tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().

Leonid Arapov (1):
      fbdev: omapfb: Add 'plane' value check

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix sending MGMT_EV_DEVICE_FOUND for invalid address

Ma Ke (1):
      PCI: Fix reference leak in pci_alloc_child_bus()

Manjunatha Venkatesh (1):
      i3c: Add NULL pointer check in i3c_master_queue_ibi()

Marek Behún (3):
      net: dsa: mv88e6xxx: workaround RGMII transmit delay erratum for 6320 family
      net: dsa: mv88e6xxx: fix VTU methods for 6320 family
      crypto: atmel-sha204a - Set hwrng quality to lowest possible

Mark Rutland (1):
      perf: arm_pmu: Don't disable counter in armpmu_add()

Martin Kepplinger (1):
      usb: dwc3: support continuous runtime PM with dual role

Mathieu Desnoyers (1):
      mm: add missing release barrier on PGDAT_RECLAIM_LOCKED unlock

Matthew Majewski (1):
      media: vim2m: print device name after registering device

Max Grobecker (1):
      x86/cpu: Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in a virtual machine

Maxim Mikityanskiy (1):
      ALSA: hda: intel: Fix Optimus when GPU has no sound

Meir Elisha (1):
      md/raid1: Add check for missing source disk in process_checks()

Miao Li (2):
      usb: quirks: add DELAY_INIT quirk for Silicon Motion Flash Drive
      usb: quirks: Add delay init quirk for SanDisk 3.2Gen1 Flash Drive

Miaoqian Lin (1):
      scsi: iscsi: Fix missing scsi_host_put() in error path

Michael Ehrenreich (1):
      USB: serial: ftdi_sio: add support for Abacus Electrics Optical Probe

Mikulas Patocka (1):
      dm-integrity: set ti->error on memory allocation failure

Ming Lei (1):
      selftests: ublk: fix test_stripe_04

Murad Masimov (1):
      media: streamzap: prevent processing IR data on URB failure

Myrrh Periwinkle (1):
      x86/e820: Fix handling of subpage regions when calculating nosave ranges in e820__register_nosave_regions()

Nathan Chancellor (3):
      riscv: Avoid fortify warning in syscall_get_arguments()
      kbuild: Add '-fno-builtin-wcslen'
      powerpc/prom_init: Use -ffreestanding to avoid a reference to bcmp

Nikita Zhandarovich (1):
      drm/repaper: fix integer overflows in repeat functions

Niklas Cassel (1):
      ata: libata-eh: Do not use ATAPI DMA for a device limited to PIO mode

Niklas Söderlund (1):
      media: i2c: adv748x: Fix test pattern selection mask

Ojaswin Mujoo (1):
      ext4: protect ext4_release_dquot against freezing

Oleg Nesterov (1):
      sched/isolation: Make CONFIG_CPU_ISOLATION depend on CONFIG_SMP

Oliver Neukum (2):
      USB: storage: quirk for ADATA Portable HDD CH94
      USB: VLI disk crashes if LPM is used

Philip Yang (1):
      drm/amdkfd: Fix pqm_destroy_queue race with GPU reset

Qingfang Deng (1):
      net: phy: leds: fix memory leak

Rafael J. Wysocki (1):
      cpufreq: Reference count policy in cpufreq_update_limits()

Ralph Siemsen (1):
      usb: cdns3: Fix deadlock when using NCM gadget

Rand Deeb (2):
      fs/jfs: cast inactags to s64 to prevent potential overflow
      fs/jfs: Prevent integer overflow in AG size calculation

Remi Pommarel (2):
      wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()
      wifi: mac80211: Purge vif txq in ieee80211_do_stop()

Ricard Wanderlof (1):
      ALSA: usb-audio: Fix CME quirk for UF series keyboards

Ricardo Cañuelo Navarro (1):
      sctp: detect and prevent references to a freed transport in sendmsg

Rolf Eike Beer (1):
      drm/sti: remove duplicate object names

Ryan Roberts (1):
      sparc/mm: disable preemption in lazy mmu mode

Ryo Takakura (1):
      serial: sifive: lock port in startup()/shutdown() callbacks

Sakari Ailus (2):
      media: i2c: ov7251: Set enable GPIO low in probe
      media: i2c: ov7251: Introduce 1 ms delay between regulators and en GPIO

Sergiu Cuciurean (1):
      iio: adc: ad7768-1: Fix conversion result sign

Seunghwan Baek (1):
      mmc: cqhci: Fix checking of CQHCI_HALT state

Srinivas Pandruvada (1):
      platform/x86: ISST: Correct command storage data length

Stanislav Fomichev (1):
      net: vlan: don't propagate flags on open

T Pratham (1):
      lib: scatterlist: fix sg_split_phys to preserve original scatterlist offsets

Thadeu Lima de Souza Cascardo (1):
      i2c: cros-ec-tunnel: defer probe if parent EC is not present

Theodore Ts'o (2):
      ext4: don't over-report free space or inodes in statvfs
      ext4: optimize __ext4_check_dir_entry()

Thomas Bogendoerfer (1):
      MIPS: cm: Fix warning if MIPS_CM is disabled

Thomas Weißschuh (1):
      KVM: s390: Don't use %pK through tracepoints

Thorsten Leemhuis (1):
      module: sign with sha512 instead of sha1 by default

Tom Lendacky (1):
      crypto: ccp - Fix check for the primary ASP device

Tomasz Pakuła (3):
      HID: pidff: Convert infinite length from Linux API to PID standard
      HID: pidff: Do not send effect envelope if it's empty
      HID: pidff: Fix null pointer dereference in pidff_find_fields

Trevor Woerner (1):
      thermal/drivers/rockchip: Add missing rk3328 mapping entry

Tung Nguyen (2):
      tipc: fix memory leak in tipc_link_xmit
      tipc: fix NULL pointer dereference in tipc_mon_reinit_self()

Uwe Kleine-König (1):
      pwm: fsl-ftm: Handle clk_get_rate() returning 0

Vasiliy Kovalev (1):
      hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key

Vikash Garodia (3):
      media: venus: hfi: add a check to handle OOB in sfr region
      media: venus: hfi: add check to handle incorrect queue size
      media: venus: hfi_parser: add check to avoid out of bound access

Vinicius Costa Gomes (1):
      dmaengine: dmatest: Fix dmatest waiting less when interrupted

WangYuli (4):
      nvmet-fc: Remove unused functions
      MIPS: dec: Declare which_prom() as static
      MIPS: cevt-ds1287: Add missing ds1287.h include
      MIPS: ds1287: Match ds1287_set_base_clock() function types

Wentao Liang (3):
      ata: sata_sx4: Add error handling in pdc20621_i2c_read()
      mtd: inftlcore: Add error check for inftl_read_oob()
      mtd: rawnand: Add status chack in r852_ready()

Willem de Bruijn (1):
      bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags

Xiangsheng Hou (1):
      virtiofs: add filesystem context source name check

Xiaogang Chen (1):
      udmabuf: fix a buf size overflow issue during udmabuf creation

Xie Yongji (1):
      virtio-net: Add validation for used length

Yu-Chun Lin (1):
      parisc: PDT: Fix missing prototype warning

Yuan Can (1):
      media: siano: Fix error handling in smsdvb_module_init()

Yue Haibing (1):
      RDMA/usnic: Fix passing zero to PTR_ERR in usnic_ib_pci_probe()

Zhongqiu Han (1):
      pm: cpupower: bench: Prevent NULL dereference on malloc failure

Zijun Hu (3):
      of/irq: Fix device node refcount leakages in of_irq_count()
      of/irq: Fix device node refcount leakage in API irq_of_parse_and_map()
      of/irq: Fix device node refcount leakages in of_irq_init()

zhoumin (1):
      ftrace: Add cond_resched() to ftrace_graph_set_hash()


