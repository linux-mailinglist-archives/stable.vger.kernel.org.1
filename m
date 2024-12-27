Return-Path: <stable+bounces-106202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC809FD50E
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 14:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4DC7A19E1
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 13:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9A61F426F;
	Fri, 27 Dec 2024 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zx5zeq3d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC2155389;
	Fri, 27 Dec 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735307129; cv=none; b=QbvYvItiR9TQxJi5ndzhbOT3yKlZNsOHU2qb1JadNKuaR1t7fgrTm9xnyYpcQj9B29PQghGkHV56V46A2mzuI8/RnEMRE8L48/4wMNPkeZJOT1H3zl+ivpaacO0pImnBKByo++9SXUwpfXfW0CEjVk+SruICnX++1AjE0uKmHQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735307129; c=relaxed/simple;
	bh=Os23GSG8Y8KQOPsT5VZ6YyqS4vkq1drseW0PGDFaInQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DYtzbcZWD8IP/QUkre3yLrvSd7FGfkyN6XwyoZ//qHvcZ3MCaFzuHeqY3JfSDJYg4sKiSFlJh3HiwS/SRF8s+dBOWIIGIgn18BfpezsnTNvkEd/ornEXVuenjj0GaPcTABpRHg7C0Fku5cuT9qFzTzpq0hxyvZdOdOHvXebOpe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zx5zeq3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EA0C4CED6;
	Fri, 27 Dec 2024 13:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735307128;
	bh=Os23GSG8Y8KQOPsT5VZ6YyqS4vkq1drseW0PGDFaInQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Zx5zeq3dVITQSVxcWCOzvM2cDXPRh3PJ03EVyhnfvj3tjeq5vPQeKK6rnzq2ua1s7
	 YvpXmbj/xFJD2KDp79JNnRNmysg753JPPNBKbWlF300kiYHw7xNRQ181ZVRigDpdIc
	 L9aYxxLLsSET/p9ABpBHSFc9e++FxzEj2MKuo3Bk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.68
Date: Fri, 27 Dec 2024 14:45:13 +0100
Message-ID: <2024122713-plunging-giggly-c6f9@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.68 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-fs-xfs                        |    8 
 Documentation/devicetree/bindings/net/fsl,fec.yaml            |    7 
 Makefile                                                      |    2 
 arch/hexagon/Makefile                                         |    6 
 arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dts        |    1 
 arch/x86/kvm/cpuid.c                                          |   31 +
 arch/x86/kvm/cpuid.h                                          |    1 
 arch/x86/kvm/x86.c                                            |    4 
 drivers/block/zram/zram_drv.c                                 |   15 
 drivers/cxl/core/region.c                                     |   25 -
 drivers/cxl/pci.c                                             |    3 
 drivers/dma-buf/udmabuf.c                                     |    2 
 drivers/edac/amd64_edac.c                                     |   32 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                       |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                        |    7 
 drivers/gpu/drm/drm_modes.c                                   |   11 
 drivers/gpu/drm/i915/gt/intel_engine_types.h                  |    5 
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c             |   41 +-
 drivers/gpu/drm/panel/panel-novatek-nt35950.c                 |    4 
 drivers/hv/hv_kvp.c                                           |    6 
 drivers/hv/hv_snapshot.c                                      |    6 
 drivers/hv/hv_util.c                                          |    9 
 drivers/hv/hyperv_vmbus.h                                     |    2 
 drivers/hwmon/tmp513.c                                        |   74 +--
 drivers/i2c/busses/i2c-pnx.c                                  |    4 
 drivers/i2c/busses/i2c-riic.c                                 |    2 
 drivers/mmc/host/mtk-sd.c                                     |    2 
 drivers/mmc/host/sdhci-tegra.c                                |    1 
 drivers/net/ethernet/broadcom/bgmac-platform.c                |    5 
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c |    5 
 drivers/net/ethernet/freescale/fec_ptp.c                      |   11 
 drivers/net/ethernet/huawei/hinic/hinic_main.c                |    2 
 drivers/net/ethernet/mscc/ocelot.c                            |    2 
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c           |    4 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c               |    4 
 drivers/net/ethernet/renesas/rswitch.c                        |   74 +--
 drivers/net/ethernet/renesas/rswitch.h                        |   13 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c             |    7 
 drivers/net/mdio/fwnode_mdio.c                                |   13 
 drivers/net/netdevsim/health.c                                |    2 
 drivers/net/tun.c                                             |    2 
 drivers/of/address.c                                          |    2 
 drivers/of/base.c                                             |   15 
 drivers/of/irq.c                                              |    2 
 drivers/pci/controller/pci-host-common.c                      |    4 
 drivers/pci/controller/vmd.c                                  |    8 
 drivers/pci/pcie/aer.c                                        |   18 
 drivers/pci/probe.c                                           |   20 -
 drivers/pci/quirks.c                                          |    4 
 drivers/platform/x86/p2sb.c                                   |   92 ++--
 drivers/thunderbolt/tb.c                                      |   41 ++
 drivers/usb/cdns3/cdns3-ti.c                                  |   15 
 drivers/usb/cdns3/core.h                                      |    1 
 drivers/usb/cdns3/drd.c                                       |   10 
 drivers/usb/cdns3/drd.h                                       |    3 
 drivers/usb/dwc2/gadget.c                                     |    4 
 drivers/usb/serial/option.c                                   |   27 +
 fs/btrfs/tree-checker.c                                       |   27 +
 fs/ceph/file.c                                                |   34 -
 fs/ceph/super.c                                               |    2 
 fs/efivarfs/inode.c                                           |    2 
 fs/efivarfs/internal.h                                        |    1 
 fs/efivarfs/super.c                                           |    3 
 fs/eventpoll.c                                                |    5 
 fs/nfs/pnfs.c                                                 |    2 
 fs/nilfs2/btnode.c                                            |    1 
 fs/nilfs2/gcinode.c                                           |    2 
 fs/nilfs2/inode.c                                             |   13 
 fs/nilfs2/namei.c                                             |    5 
 fs/nilfs2/nilfs.h                                             |    1 
 fs/smb/client/connect.c                                       |   36 +
 fs/smb/server/connection.c                                    |   18 
 fs/smb/server/connection.h                                    |    1 
 fs/smb/server/server.c                                        |    7 
 fs/smb/server/server.h                                        |    1 
 fs/smb/server/transport_ipc.c                                 |    5 
 fs/xfs/Kconfig                                                |   12 
 fs/xfs/libxfs/xfs_dir2_data.c                                 |   31 +
 fs/xfs/libxfs/xfs_dir2_priv.h                                 |    7 
 fs/xfs/libxfs/xfs_quota_defs.h                                |    2 
 fs/xfs/libxfs/xfs_trans_resv.c                                |   28 -
 fs/xfs/scrub/agheader_repair.c                                |    2 
 fs/xfs/scrub/bmap.c                                           |    8 
 fs/xfs/scrub/trace.h                                          |   10 
 fs/xfs/xfs.h                                                  |    4 
 fs/xfs/xfs_bmap_util.c                                        |   22 -
 fs/xfs/xfs_buf_item.c                                         |   32 +
 fs/xfs/xfs_dquot_item.c                                       |   31 +
 fs/xfs/xfs_file.c                                             |   33 -
 fs/xfs/xfs_file.h                                             |   15 
 fs/xfs/xfs_fsmap.c                                            |    6 
 fs/xfs/xfs_inode.c                                            |   29 +
 fs/xfs/xfs_inode.h                                            |    2 
 fs/xfs/xfs_inode_item.c                                       |   32 +
 fs/xfs/xfs_ioctl.c                                            |   12 
 fs/xfs/xfs_iops.c                                             |    1 
 fs/xfs/xfs_iops.h                                             |    3 
 fs/xfs/xfs_rtalloc.c                                          |   78 +++
 fs/xfs/xfs_symlink.c                                          |    8 
 include/linux/hyperv.h                                        |    1 
 include/linux/io_uring.h                                      |    4 
 include/linux/wait.h                                          |    1 
 io_uring/io_uring.c                                           |   15 
 io_uring/io_uring.h                                           |    1 
 io_uring/rw.c                                                 |   31 +
 kernel/trace/trace_events.c                                   |  197 +++++++---
 mm/vmalloc.c                                                  |    6 
 net/netfilter/ipset/ip_set_list_set.c                         |    3 
 net/netfilter/ipvs/ip_vs_conn.c                               |    4 
 net/sched/sch_cake.c                                          |    2 
 net/sched/sch_choke.c                                         |    2 
 net/smc/af_smc.c                                              |   18 
 net/smc/smc_clc.c                                             |   17 
 net/smc/smc_clc.h                                             |   22 -
 net/smc/smc_core.c                                            |    9 
 sound/soc/intel/boards/sof_sdw.c                              |   18 
 tools/hv/hv_set_ifconfig.sh                                   |    2 
 tools/testing/selftests/bpf/sdt.h                             |    2 
 tools/testing/selftests/memfd/memfd_test.c                    |   14 
 tools/testing/selftests/net/openvswitch/openvswitch.sh        |    6 
 120 files changed, 1231 insertions(+), 442 deletions(-)

Adrian Moreno (1):
      selftests: openvswitch: fix tcpdump execution

Ajit Khaparde (1):
      PCI: Add ACS quirk for Broadcom BCM5760X NIC

Alex Markuze (1):
      ceph: improve error handling and short/overflow-read logic in __ceph_sync_read()

Andy Shevchenko (3):
      hwmon: (tmp513) Don't use "proxy" headers
      hwmon: (tmp513) Simplify with dev_err_probe()
      hwmon: (tmp513) Use SI constants from units.h

Borislav Petkov (AMD) (1):
      EDAC/amd64: Simplify ECC check on unified memory controllers

Brett Creeley (1):
      ionic: Fix netdev notifier unregister on failure

Chen Ni (1):
      xfs: convert comma to semicolon

Christoph Hellwig (1):
      xfs: fix the contact address for the sysfs ABI documentation

Dan Carpenter (2):
      net: hinic: Fix cleanup in create_rxqs/txqs()
      chelsio/chtls: prevent potential integer overflow on 32bit

Daniel Swanemar (1):
      USB: serial: option: add TCL IK512 MBIM & ECM

Daniele Palmas (1):
      USB: serial: option: add Telit FE910C04 rmnet compositions

Darrick J. Wong (10):
      xfs: verify buffer, inode, and dquot items every tx commit
      xfs: use consistent uid/gid when grabbing dquots for inodes
      xfs: declare xfs_file.c symbols in xfs_file.h
      xfs: create a new helper to return a file's allocation unit
      xfs: fix file_path handling in tracepoints
      xfs: attr forks require attr, not attr2
      xfs: conditionally allow FS_XFLAG_REALTIME changes if S_DAX is set
      xfs: use XFS_BUF_DADDR_NULL for daddrs in getfsmap code
      xfs: take m_growlock when running growfsrt
      xfs: reset rootdir extent size hint after growfsrt

David Laight (1):
      ipvs: Fix clamp() of ip_vs_conn_tab on small memory systems

Davidlohr Bueso (1):
      cxl/pci: Fix potential bogus return value upon successful probing

Edward Adam Davis (1):
      nilfs2: prevent use of deleted inode

Enzo Matsumiya (1):
      smb: client: fix TCP timers deadlock after rmmod

Eric Dumazet (2):
      netdevsim: prevent bad user input in nsim_dev_health_break_write()
      net: tun: fix tun_napi_alloc_frags()

Francesco Dolcini (3):
      net: fec: refactor PPS channel configuration
      net: fec: make PPS channel configurable
      dt-bindings: net: fec: add pps channel property

Geert Uytterhoeven (1):
      i2c: riic: Always round-up when calculating bus period

Greg Kroah-Hartman (1):
      Linux 6.6.68

Guangguan Wang (6):
      net/smc: protect link down work from execute after lgr freed
      net/smc: check sndbuf_space again after NOSPACE flag is set in smc_poll
      net/smc: check iparea_offset and ipv6_prefixes_cnt when receiving proposal msg
      net/smc: check v2_ext_offset/eid_cnt/ism_gid_cnt when receiving proposal msg
      net/smc: check smcd_v2_ext_offset when receiving proposal msg
      net/smc: check return value of sock_recvmsg when draining clc data

Hans de Goede (1):
      platform/x86: p2sb: Make p2sb_get_devfn() return void

Herve Codina (1):
      of: Fix error path in of_parse_phandle_with_args_map()

Huaisheng Ye (1):
      cxl/region: Fix region creation for greater than x2 switches

Ilya Dryomov (1):
      ceph: validate snapdirname option length when mounting

Isaac J. Manjarres (1):
      selftests/memfd: run sysctl tests when PID namespace support is enabled

Jack Wu (1):
      USB: serial: option: add MediaTek T7XX compositions

James Bottomley (1):
      efivarfs: Fix error on non-existent file

Jann Horn (2):
      io_uring: Fix registered ring file refcount leak
      udmabuf: also check for F_SEAL_FUTURE_WRITE

Jens Axboe (2):
      io_uring/rw: split io_read() into a helper
      io_uring/rw: treat -EOPNOTSUPP for IOCB_NOWAIT like -EAGAIN

Jiaxun Yang (1):
      MIPS: Loongson64: DTS: Fix msi node for ls7a

Jiwei Sun (1):
      PCI: vmd: Create domain symlink before pci_bus_add_devices()

Joe Hattori (3):
      net: ethernet: bgmac-platform: fix an OF node reference leak
      net: mdiobus: fix an OF node reference leak
      mmc: mtk-sd: disable wakeup in .remove() and in the error path of .probe()

John Garry (2):
      xfs: Fix xfs_flush_unmap_range() range for RT
      xfs: Fix xfs_prepare_shift() range for RT

Julian Sun (1):
      xfs: remove unused parameter in macro XFS_DQUOT_LOGRES

Kai-Heng Feng (1):
      PCI/AER: Disable AER service on suspend

Kairui Song (2):
      zram: refuse to use zero sized block device as backing device
      zram: fix uninitialized ZRAM not releasing backing device

Lion Ackermann (1):
      net: sched: fix ordering of qlen adjustment

Mank Wang (1):
      USB: serial: option: add Netprisma LCUK54 modules for WWAN Ready

Marios Makassikis (2):
      ksmbd: count all requests in req_running counter
      ksmbd: fix broken transfers when exceeding max simultaneous operations

Matthew Wilcox (Oracle) (1):
      vmalloc: fix accounting with i915

Max Kellermann (1):
      ceph: fix memory leaks in __ceph_sync_read()

Michael Kelley (1):
      Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet

Michal Hrusecky (1):
      USB: serial: option: add MeiG Smart SLM770A

Michel Dänzer (1):
      drm/amdgpu: Handle NULL bo->tbo.resource (again) in amdgpu_vm_bo_update

Mika Westerberg (1):
      thunderbolt: Improve redrive mode handling

Murad Masimov (3):
      hwmon: (tmp513) Fix interpretation of values of Shunt Voltage and Limit Registers
      hwmon: (tmp513) Fix Current Register value interpretation
      hwmon: (tmp513) Fix interpretation of values of Temperature Result and Limit Registers

Nathan Chancellor (1):
      hexagon: Disable constant extender optimization for LLVM prior to 19.1.0

Nikita Yushchenko (1):
      net: renesas: rswitch: rework ts tags management

Olaf Hering (1):
      tools: hv: change permissions of NetworkManager configuration file

Pavel Begunkov (2):
      io_uring: check if iowq is killed before queuing
      io_uring/rw: avoid punting to io-wq directly

Peng Hongchi (1):
      usb: dwc2: gadget: Don't write invalid mapped sg entries into dma_desc with iommu enabled

Phil Sutter (1):
      netfilter: ipset: Fix for recursive locking warning

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: don't access invalid sched

Pierre-Louis Bossart (2):
      ASoC: Intel: sof_sdw: fix jack detection on ADL-N variant RVP
      ASoC: Intel: sof_sdw: add quirk for Dell SKU 0B8C

Prathamesh Shete (1):
      mmc: sdhci-tegra: Remove SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk

Qu Wenruo (1):
      btrfs: tree-checker: reject inline extent items with 0 ref count

Roger Quadros (2):
      usb: cdns3-ti: Add workaround for Errata i2409
      usb: cdns3: Add quirk flag to enable suspend residency

Russell King (Oracle) (1):
      net: stmmac: fix TSO DMA API usage causing oops

Ryusuke Konishi (1):
      nilfs2: fix buffer head leaks in calls to truncate_inode_pages()

Sean Christopherson (2):
      KVM: x86: Cache CPUID.0xD XSTATE offsets+sizes during module init
      KVM: x86: Play nice with protected guests in complete_hypercall_exit()

Shannon Nelson (1):
      ionic: use ee->offset when returning sprom data

Shin'ichiro Kawasaki (4):
      p2sb: Factor out p2sb_read_from_cache()
      p2sb: Introduce the global flag p2sb_hidden_by_bios
      p2sb: Move P2SB hide and unhide code to p2sb_scan_and_cache()
      p2sb: Do not scan and remove the P2SB device when it is unhidden

Steven Rostedt (3):
      tracing: Fix test_event_printk() to process entire print argument
      tracing: Add missing helper functions in event pointer dereference check
      tracing: Add "%s" check in test_event_printk()

Tiezhu Yang (1):
      selftests/bpf: Use asm constraint "m" for LoongArch

Trond Myklebust (1):
      NFS/pnfs: Fix a live lock between recalled layouts and layoutget

Umesh Nerlige Ramappa (3):
      i915/guc: Reset engine utilization buffer before registration
      i915/guc: Ensure busyness counter increases motonically
      i915/guc: Accumulate active runtime on gt reset

Vidya Sagar (1):
      PCI: Use preserve_config in place of pci_flags

Ville Syrjälä (1):
      drm/modes: Avoid divide by zero harder in drm_mode_vrefresh()

Vladimir Oltean (1):
      net: mscc: ocelot: fix incorrect IFH SRC_PORT field in ocelot_ifh_set_basic()

Vladimir Riabchun (1):
      i2c: pnx: Fix timeout in wait functions

Xuewen Yan (1):
      epoll: Add synchronous wakeup support for ep_poll_callback

Yang Yingliang (1):
      drm/panel: novatek-nt35950: fix return value check in nt35950_probe()

Zijun Hu (3):
      of/irq: Fix interrupt-map cell length check in of_irq_parse_imap_parent()
      of/irq: Fix using uninitialized variable @addr_len in API of_irq_parse_one()
      of: Fix refcount leakage for OF node returned by __of_get_dma_parent()

Zizhi Wo (1):
      xfs: Fix the owner setting issue for rmap query in xfs fsmap

lei lu (1):
      xfs: don't walk off the end of a directory data block


