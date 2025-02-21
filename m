Return-Path: <stable+bounces-118582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6297BA3F5EA
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B01861877
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 13:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EEA20D4E4;
	Fri, 21 Feb 2025 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ohtyR32H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795D218E025;
	Fri, 21 Feb 2025 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144476; cv=none; b=Pv5MTOqklrA1h5ZcEo7KYKE9YX5Ux6zzc2FIm6nVW7Bf6F/R4zInp49LwZWGTcdvVwgKf7wDfecvunOKL4ek9teyGiHdRheRV0zKpji1rurQnwLud4E7xcJ7iUi5R7np8r81crNmcUEd/X3SuJpMaw+Ut9rMx3J/m5zqTnHYmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144476; c=relaxed/simple;
	bh=TKOUq5Ru2tkzIXhaKOSC/Sj7KKSE80SPgBeEIxaRrB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NN0J7YVm4V9a0A6x+1xHmGz+z7UqAnZBitld/p8Cf6EetQbTwMHtCjLxr96TSYwwxMw9ubxBIdL49kYtDNhsK+Qdaax/vvfKbp0Fb6q/1NKvqqeS4kU7u4GDOnPWG1ZnAKL+WipthgCcc17c9TxBSelQ2WpLytLeDBvgACx8iqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ohtyR32H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E13C4CEE4;
	Fri, 21 Feb 2025 13:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740144475;
	bh=TKOUq5Ru2tkzIXhaKOSC/Sj7KKSE80SPgBeEIxaRrB8=;
	h=From:To:Cc:Subject:Date:From;
	b=ohtyR32HUw/VrsQAxRt87rR8uNHkfYJ/gv79PXMVDdfncpHp6PxTYt7YvoZbGLlqg
	 K0zY/E1Q1WS89hj96/g5To3nubbdoSd00mY1k+MI5FCgrFuyJiHOTA5ik7UEWZYzLs
	 VvULIYFStkYjvpDtencnLJtdZVLgqXDrmFc4SXP4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.79
Date: Fri, 21 Feb 2025 14:27:47 +0100
Message-ID: <2025022147-uproar-daybreak-7ad6@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.79 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/arm64/elf_hwcaps.rst                                 |   36 
 Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml |    2 
 Makefile                                                                |   15 
 arch/alpha/include/uapi/asm/ptrace.h                                    |    2 
 arch/alpha/kernel/asm-offsets.c                                         |    2 
 arch/alpha/kernel/entry.S                                               |   24 
 arch/alpha/kernel/traps.c                                               |    2 
 arch/alpha/mm/fault.c                                                   |    4 
 arch/arm64/kernel/cacheinfo.c                                           |   12 
 arch/arm64/kernel/cpufeature.c                                          |   38 
 arch/arm64/kernel/vdso/vdso.lds.S                                       |    1 
 arch/arm64/kernel/vmlinux.lds.S                                         |    1 
 arch/loongarch/kernel/genex.S                                           |   28 
 arch/loongarch/kernel/idle.c                                            |    3 
 arch/loongarch/kernel/reset.c                                           |    6 
 arch/loongarch/lib/csum.c                                               |    2 
 arch/x86/events/intel/core.c                                            |    5 
 arch/x86/include/asm/mmu.h                                              |    2 
 arch/x86/include/asm/mmu_context.h                                      |    1 
 arch/x86/include/asm/msr-index.h                                        |    3 
 arch/x86/include/asm/tlbflush.h                                         |    1 
 arch/x86/kernel/i8253.c                                                 |   11 
 arch/x86/kernel/static_call.c                                           |    1 
 arch/x86/kvm/hyperv.c                                                   |    6 
 arch/x86/kvm/mmu/mmu.c                                                  |    2 
 arch/x86/kvm/svm/nested.c                                               |   10 
 arch/x86/mm/tlb.c                                                       |   35 
 arch/x86/xen/mmu_pv.c                                                   |   75 -
 block/partitions/mac.c                                                  |   18 
 drivers/acpi/x86/utils.c                                                |   13 
 drivers/base/regmap/regmap-irq.c                                        |    2 
 drivers/clocksource/i8253.c                                             |   13 
 drivers/firmware/efi/efi.c                                              |    6 
 drivers/firmware/efi/libstub/randomalloc.c                              |    3 
 drivers/firmware/efi/libstub/relocate.c                                 |    3 
 drivers/gpio/gpio-bcm-kona.c                                            |   71 
 drivers/gpio/gpio-stmpe.c                                               |   15 
 drivers/gpio/gpiolib-acpi.c                                             |   14 
 drivers/gpio/gpiolib.c                                                  |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                                 |    5 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c                   |    3 
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c                 |    4 
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c                   |    3 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                               |    3 
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c                           |    4 
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c                         |    2 
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h                    |    1 
 drivers/gpu/drm/tidss/tidss_dispc.c                                     |   22 
 drivers/gpu/drm/v3d/v3d_perfmon.c                                       |    5 
 drivers/hid/hid-multitouch.c                                            |    5 
 drivers/hid/hid-steam.c                                                 |  740 +++++++---
 drivers/hid/hid-thrustmaster.c                                          |    2 
 drivers/infiniband/hw/efa/efa_main.c                                    |    9 
 drivers/md/md-bitmap.c                                                  |   75 -
 drivers/md/md-bitmap.h                                                  |    6 
 drivers/md/md.c                                                         |   26 
 drivers/md/md.h                                                         |    5 
 drivers/md/raid1.c                                                      |   35 
 drivers/md/raid1.h                                                      |    1 
 drivers/md/raid10.c                                                     |   26 
 drivers/md/raid10.h                                                     |    1 
 drivers/md/raid5-cache.c                                                |    4 
 drivers/md/raid5.c                                                      |  174 +-
 drivers/md/raid5.h                                                      |    4 
 drivers/media/dvb-frontends/cxd2841er.c                                 |    8 
 drivers/media/i2c/ds90ub913.c                                           |   25 
 drivers/media/i2c/ds90ub953.c                                           |   46 
 drivers/media/test-drivers/vidtv/vidtv_bridge.c                         |    8 
 drivers/media/usb/uvc/uvc_driver.c                                      |   18 
 drivers/media/usb/uvc/uvc_video.c                                       |   27 
 drivers/media/usb/uvc/uvcvideo.h                                        |    1 
 drivers/mmc/host/mtk-sd.c                                               |   31 
 drivers/net/can/c_can/c_can_platform.c                                  |    5 
 drivers/net/can/ctucanfd/ctucanfd_base.c                                |   10 
 drivers/net/can/usb/etas_es58x/es58x_devlink.c                          |    6 
 drivers/net/ethernet/intel/igc/igc_main.c                               |    1 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c                  |    4 
 drivers/net/netdevsim/ipsec.c                                           |   12 
 drivers/net/team/team.c                                                 |    4 
 drivers/net/vxlan/vxlan_core.c                                          |    7 
 drivers/net/wireless/ath/ath12k/wmi.c                                   |   61 
 drivers/net/wireless/ath/ath12k/wmi.h                                   |    1 
 drivers/pci/quirks.c                                                    |   12 
 drivers/pci/switch/switchtec.c                                          |   26 
 drivers/pinctrl/pinctrl-cy8c95x0.c                                      |    2 
 drivers/soc/tegra/fuse/fuse-tegra30.c                                   |   17 
 drivers/spi/spi-sn-f-ospi.c                                             |    3 
 drivers/tty/serial/8250/8250.h                                          |    2 
 drivers/tty/serial/8250/8250_dma.c                                      |   16 
 drivers/tty/serial/8250/8250_port.c                                     |    9 
 drivers/tty/serial/serial_port.c                                        |    5 
 drivers/ufs/core/ufs_bsg.c                                              |    1 
 drivers/usb/class/cdc-acm.c                                             |   28 
 drivers/usb/core/hub.c                                                  |   14 
 drivers/usb/core/quirks.c                                               |    6 
 drivers/usb/dwc2/gadget.c                                               |    1 
 drivers/usb/dwc3/gadget.c                                               |   34 
 drivers/usb/gadget/function/f_midi.c                                    |   17 
 drivers/usb/gadget/udc/renesas_usb3.c                                   |    2 
 drivers/usb/host/pci-quirks.c                                           |    9 
 drivers/usb/roles/class.c                                               |    5 
 drivers/usb/serial/option.c                                             |   49 
 drivers/vfio/pci/vfio_pci_rdwr.c                                        |    1 
 drivers/vfio/platform/vfio_platform_common.c                            |   10 
 drivers/video/fbdev/omap/lcd_dma.c                                      |    4 
 drivers/xen/swiotlb-xen.c                                               |   20 
 fs/btrfs/file.c                                                         |    4 
 fs/nfs/sysfs.c                                                          |    6 
 fs/nfsd/nfs2acl.c                                                       |    2 
 fs/nfsd/nfs3acl.c                                                       |    2 
 fs/nfsd/nfs4callback.c                                                  |    7 
 fs/orangefs/orangefs-debugfs.c                                          |    4 
 include/linux/blk-mq.h                                                  |   18 
 include/linux/cgroup-defs.h                                             |    6 
 include/linux/efi.h                                                     |    1 
 include/linux/i8253.h                                                   |    1 
 include/linux/netdevice.h                                               |    6 
 include/linux/sched/task.h                                              |    1 
 include/net/l3mdev.h                                                    |    2 
 include/net/net_namespace.h                                             |   15 
 include/net/route.h                                                     |    9 
 io_uring/kbuf.c                                                         |   15 
 kernel/cgroup/cgroup.c                                                  |   20 
 kernel/cgroup/rstat.c                                                   |    1 
 kernel/time/clocksource.c                                               |    9 
 mm/gup.c                                                                |   14 
 net/ax25/af_ax25.c                                                      |   11 
 net/batman-adv/bat_v.c                                                  |    2 
 net/batman-adv/bat_v_elp.c                                              |  122 +
 net/batman-adv/bat_v_elp.h                                              |    2 
 net/batman-adv/types.h                                                  |    3 
 net/can/j1939/socket.c                                                  |    4 
 net/can/j1939/transport.c                                               |    5 
 net/core/flow_dissector.c                                               |   21 
 net/core/neighbour.c                                                    |   11 
 net/ipv4/arp.c                                                          |    4 
 net/ipv4/devinet.c                                                      |    3 
 net/ipv4/icmp.c                                                         |   31 
 net/ipv4/route.c                                                        |   39 
 net/ipv6/icmp.c                                                         |   42 
 net/ipv6/mcast.c                                                        |   45 
 net/ipv6/ndisc.c                                                        |   24 
 net/ipv6/route.c                                                        |    7 
 net/openvswitch/datapath.c                                              |   12 
 net/vmw_vsock/af_vsock.c                                                |   12 
 sound/soc/intel/boards/bytcr_rt5640.c                                   |   17 
 tools/testing/selftests/gpio/gpio-sim.sh                                |   31 
 tools/testing/selftests/net/pmtu.sh                                     |  112 +
 tools/testing/selftests/net/rtnetlink.sh                                |    4 
 tools/tracing/rtla/src/timerlat_hist.c                                  |    8 
 tools/tracing/rtla/src/timerlat_top.c                                   |    8 
 151 files changed, 2106 insertions(+), 844 deletions(-)

Aaro Koskinen (1):
      fbdev: omap: use threaded IRQ for LCD DMA

Aditya Kumar Singh (1):
      wifi: ath12k: fix handling of 6 GHz rules

Alan Stern (1):
      USB: hub: Ignore non-compliant devices with too many configs or interfaces

Alex Hung (1):
      drm/amd/display: Pass non-null to dcn20_validate_apply_pipe_split_flags

Alexander Hölzl (1):
      can: j1939: j1939_sk_send_loop(): fix unable to send messages with data length zero

Andrew Cooper (1):
      x86/static-call: Remove early_boot_irqs_disabled check to fix Xen PVH dom0

Andy Shevchenko (4):
      pinctrl: cy8c95x0: Respect IRQ trigger settings from firmware
      gpiolib: Fix crash on error in gpiochip_get_ngpios()
      serial: port: Assign ->iotype correctly when ->iobase is set
      serial: port: Always update ->iotype in __uart_read_properties()

Andy Strohman (1):
      batman-adv: fix panic during interface removal

Andy-ld Lu (1):
      mmc: mtk-sd: Fix register settings for hs400(es) mode

Ard Biesheuvel (1):
      efi: Avoid cold plugged memory for placing the kernel

Arnd Bergmann (1):
      media: cxd2841er: fix 64-bit division on gcc-9

Artur Weber (3):
      gpio: bcm-kona: Fix GPIO lock/unlock for banks above bank 0
      gpio: bcm-kona: Make sure GPIO bits are unlocked when requesting IRQ
      gpio: bcm-kona: Add missing newline to dev_err format string

Benjamin Marzinski (1):
      md/raid5: recheck if reshape has finished with device_lock held

Charles Han (1):
      HID: multitouch: Add NULL check in mt_input_configured

Chester A. Unal (1):
      USB: serial: option: add MeiG Smart SLM828

Christian Gmeiner (1):
      drm/v3d: Stop active perfmon if it is being destroyed

Dai Ngo (1):
      NFSD: fix hang in nfsd4_shutdown_callback

Dan Carpenter (2):
      HID: hid-steam: remove pointless error message
      HID: hid-steam: Fix cleanup in probe()

David Woodhouse (1):
      x86/i8253: Disable PIT timer 0 when not in use

Devarsh Thakkar (1):
      drm/tidss: Clear the interrupt status for interrupts being disabled

Edward Adam Davis (1):
      media: vidtv: Fix a null-ptr-deref in vidtv_mux_stop_thread

Elson Roy Serrao (1):
      usb: roles: set switch registered flag early on

Eric Dumazet (21):
      ndisc: ndisc_send_redirect() must use dev_get_by_index_rcu()
      vrf: use RCU protection in l3mdev_l3_out()
      vxlan: check vxlan_vnigroup_init() return value
      team: better TEAM_OPTION_TYPE_STRING validation
      ipv4: add RCU protection to ip4_dst_hoplimit()
      net: add dev_net_rcu() helper
      ipv4: use RCU protection in ipv4_default_advmss()
      ipv4: use RCU protection in rt_is_expired()
      ipv4: use RCU protection in inet_select_addr()
      ipv4: use RCU protection in __ip_rt_update_pmtu()
      ipv4: icmp: convert to dev_net_rcu()
      flow_dissector: use RCU protection to fetch dev_net()
      ipv6: use RCU protection in ip6_default_advmss()
      ipv6: icmp: convert to dev_net_rcu()
      ndisc: use RCU protection in ndisc_alloc_skb()
      neighbour: use RCU protection in __neigh_notify()
      arp: use RCU protection in arp_xmit()
      openvswitch: use RCU protection in ovs_vport_cmd_fill_info()
      ndisc: extend RCU protection in ndisc_send_skb()
      ipv6: mcast: extend RCU protection in igmp6_send()
      ipv6: mcast: add RCU protection to mld_newpack()

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990B compositions
      USB: serial: option: fix Telit Cinterion FN990A name

Fabrice Gasnier (1):
      usb: dwc2: gadget: remove of_node reference upon udc_stop

Fedor Pchelkin (1):
      can: ctucanfd: handle skb allocation failure

Filipe Manana (1):
      btrfs: fix hole expansion when writing at an offset beyond EOF

Greg Kroah-Hartman (2):
      Revert "vfio/platform: check the bounds of read/write syscalls"
      Linux 6.6.79

Guixin Liu (1):
      scsi: ufs: bsg: Set bsg_queue to NULL after removal

Guo Ren (1):
      usb: gadget: udc: renesas_usb3: Fix compiler warning

Hangbin Liu (2):
      netdevsim: print human readable IP address
      selftests: rtnetlink: update netdevsim ipsec output format

Hans de Goede (2):
      ACPI: x86: Add skip i2c clients quirk for Vexia EDU ATLA 10 tablet 5V
      ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet 5V

Huacai Chen (1):
      USB: pci-quirks: Fix HCCPARAMS register error for LS7A EHCI

Isaac Scott (3):
      media: uvcvideo: Implement dual stream quirk to fix loss of usb packets
      media: uvcvideo: Add new quirk definition for the Sonix Technology Co. 292a camera
      media: uvcvideo: Add Kurokesu C1 PRO camera

Ivan Kokshaysky (3):
      alpha: make stack 16-byte aligned (most cases)
      alpha: align stack for page fault and user unaligned trap handlers
      alpha: replace hardcoded stack offsets with autogenerated ones

Jann Horn (3):
      usb: cdc-acm: Check control transfer buffer size before access
      usb: cdc-acm: Fix handling of oversized fragments
      partitions: mac: fix handling of bogus partition table

Jens Axboe (1):
      block: cleanup and fix batch completion adding conditions

Jiang Liu (2):
      drm/amdgpu: bail out when failed to load fw in psp_init_cap_microcode()
      drm/amdgpu: avoid buffer overflow attach in smu_sys_set_pp_table()

Jiasheng Jiang (1):
      regmap-irq: Add missing kfree()

Jiri Pirko (1):
      net: treat possible_net_t net pointer as an RCU one and add read_pnet_rcu()

Johan Hovold (1):
      USB: serial: option: drop MeiG Smart defines

John Keeping (2):
      usb: gadget: f_midi: fix MIDI Streaming descriptor lengths
      serial: 8250: Fix fifo underflow on flush

Juergen Gross (2):
      xen/swiotlb: relax alignment requirements
      x86/xen: allow larger contiguous memory regions in PV guests

Kartik Rajput (1):
      soc/tegra: fuse: Update Tegra234 nvmem keepout list

Koichiro Den (1):
      selftests: gpio: gpio-sim: Fix missing chip disablements

Krzysztof Karas (1):
      drm/i915/selftests: avoid using uninitialized context

Krzysztof Kozlowski (1):
      can: c_can: fix unbalanced runtime PM disable in error path

Kunihiko Hayashi (1):
      spi: sn-f-ospi: Fix division by zero

Lei Huang (1):
      USB: quirks: add USB_QUIRK_NO_LPM quirk for Teclast dist

Li Lingfeng (1):
      nfsd: clear acl_access/acl_default after releasing them

Li Zetao (1):
      neighbour: delete redundant judgment statements

Maksym Planeta (1):
      Grab mm lock before grabbing pt lock

Marc Zyngier (1):
      arm64: Filter out SVE hwcaps when FEAT_SVE isn't implemented

Marco Crivellari (1):
      LoongArch: Fix idle VS timer enqueue

Marek Vasut (1):
      USB: cdc-acm: Fill in Renesas R-Car D3 USB Download mode quirk

Mario Limonciello (1):
      gpiolib: acpi: Add a quirk for Acer Nitro ANV14

Masahiro Yamada (1):
      tools: fix annoying "mkdir -p ..." logs when building tools in parallel

Mathias Nyman (1):
      USB: Add USB_QUIRK_NO_LPM quirk for sony xperia xz1 smartphone

Max Maisel (1):
      HID: hid-steam: Add Deck IMU support

Michael Margolin (1):
      RDMA/efa: Reset device on probe failure

Michal Luczaj (2):
      vsock: Keep the binding until socket destruction
      vsock: Orphan socket after transport release

Mike Marshall (1):
      orangefs: fix a oob in orangefs_debug_write

Muhammad Adeel (1):
      cgroup: Remove steal time from usage_usec

Murad Masimov (1):
      ax25: Fix refcount leak caused by setting SO_BINDTODEVICE sockopt

Nathan Chancellor (1):
      arm64: Handle .ARM.attributes section in linker scripts

Pavel Begunkov (1):
      io_uring/kbuf: reallocate buf lists on upgrade

Radu Rendec (1):
      arm64: cacheinfo: Avoid out-of-bounds write to cacheinfo array

Rakesh Babu Saladi (1):
      PCI: switchtec: Add Microchip PCI100X device IDs

Ramesh Thomas (1):
      vfio/pci: Enable iowrite64 and ioread64 for vfio pci

Rik van Riel (1):
      x86/mm/tlb: Only trim the mm_cpumask once a second

Sean Christopherson (3):
      KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if local APIC isn't in-kernel
      KVM: nSVM: Enter guest mode before initializing nested NPT MMU
      perf/x86/intel: Ensure LBRs are disabled when a CPU is starting

Selvarasu Ganesan (2):
      usb: gadget: f_midi: Fixing wMaxPacketSize exceeded issue during MIDI bind retries
      usb: dwc3: Fix timeout issue during controller enter/exit from halt state

Shakeel Butt (1):
      cgroup: fix race between fork and cgroup.kill

Song Yoong Siang (1):
      igc: Set buffer type for empty frames in igc_init_empty_frame

Srinivasan Shanmugam (1):
      drm/amd/display: Add null check for head_pipe in dcn201_acquire_free_pipe_for_layer

Stefan Eichenberger (1):
      usb: core: fix pipe creation for get_bMaxPacketSize0

Sven Eckelmann (2):
      batman-adv: Ignore neighbor throughput metrics in error case
      batman-adv: Drop unmanaged ELP metric worker

Takashi Iwai (1):
      PCI/DPC: Quirk PIO log size for Intel Raptor Lake-P

Thomas Weißschuh (1):
      kbuild: userprogs: fix bitsize and target detection on clang

Tomas Glozar (2):
      rtla/timerlat_hist: Abort event processing on second signal
      rtla/timerlat_top: Abort event processing on second signal

Tomi Valkeinen (4):
      media: i2c: ds90ub913: Add error handling to ub913_hw_init()
      media: i2c: ds90ub953: Add error handling for i2c reads/writes
      drm/tidss: Fix issue in irq handling causing irq-flood issue
      drm/rcar-du: dsi: Fix PHY lock bit check

Tulio Fernandes (1):
      HID: hid-thrustmaster: fix stack-out-of-bounds read in usb_check_int_endpoints()

Varadarajan Narayanan (1):
      regulator: qcom_smd: Add l2, l5 sub-node to mp5496 regulator

Vicki Pfau (8):
      HID: hid-steam: Avoid overwriting smoothing parameter
      HID: hid-steam: Disable watchdog instead of using a heartbeat
      HID: hid-steam: Clean up locking
      HID: hid-steam: Update list of identifiers from SDL
      HID: hid-steam: Add gamepad-only mode switched to by holding options
      HID: hid-steam: Make sure rumble work is canceled on removal
      HID: hid-steam: Move hidraw input (un)registering to work
      HID: hid-steam: Don't use cancel_delayed_work_sync in IRQ context

Vincent Mailhol (1):
      can: etas_es58x: fix potential NULL pointer dereference on udev->serial

Vladimir Vdovin (1):
      net: ipv4: Cache pmtu for all packet paths if multipath enabled

Waiman Long (2):
      clocksource: Use pr_info() for "Checking clocksource synchronization" message
      clocksource: Use migrate_disable() to avoid calling get_random_u32() in atomic context

Wentao Liang (2):
      gpio: stmpe: Check return value of stmpe_reg_read in stmpe_gpio_irq_sync_unlock
      mlxsw: Add return value check for mlxsw_sp_port_get_stats_raw()

Yu Kuai (5):
      md/md-bitmap: factor behind write counters out from bitmap_{start/end}write()
      md/md-bitmap: remove the last parameter for bimtap_ops->endwrite()
      md: add a new callback pers->bitmap_sector()
      md/raid5: implement pers->bitmap_sector()
      md/md-bitmap: move bitmap_{start, end}write to md upper layer

Yuli Wang (1):
      LoongArch: csum: Fix OoB access in IP checksum code for negative lengths

Zhaoyang Huang (1):
      mm: gup: fix infinite loop within __get_longterm_locked

Zichen Xie (1):
      NFS: Fix potential buffer overflowin nfs_sysfs_link_rpc_client()


