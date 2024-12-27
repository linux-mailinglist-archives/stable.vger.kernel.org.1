Return-Path: <stable+bounces-106203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A972B9FD510
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 14:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2861C1883FFB
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 13:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517DB192580;
	Fri, 27 Dec 2024 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xr+5D5Br"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30F21F2C30;
	Fri, 27 Dec 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735307132; cv=none; b=d5s6PQCUcbkWZNQK9xLzTQR9QDBJ6Kf7HC8QCopgfjlCEGGbkTAGC+AHMh4KueDE9nft0ILIcZUtzJe+opQorAdx9HucLOSWDaVdcxRHoNv7IB+Ev4ZRdxe+aCdTSrrlI9BWBTYnLpnOtSv7JHbwXokdMAMX7zmtGWNWUIG2CuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735307132; c=relaxed/simple;
	bh=AyXUg2btc4r9kZm6bd354u1lTGTbHQ1fu8vZrgjFXmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E4M4VUWNUh6bwIQgtx+DafntFpE+2/hsNDfbbYh9fYq1v/hP3K90e5L9BmXRMfNzbOLZxV/xzGgXXMBB/YtXlGN2UZifRQ1PoJXrvc0BU1xeMtdkHm/mCD/S6GaRAcNIydtHh6+kPlm5/MRgHf29YeGrT6i7W0ShKlF+OQL1HJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xr+5D5Br; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C793C4CED4;
	Fri, 27 Dec 2024 13:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735307131;
	bh=AyXUg2btc4r9kZm6bd354u1lTGTbHQ1fu8vZrgjFXmU=;
	h=From:To:Cc:Subject:Date:From;
	b=xr+5D5BrRx8pjwmtLKJJuiX2TI1bgXW4RjQAEujN1AfodS5GOQZeYreN3w0wCVl7I
	 0HsaLyAWkQBNi80iF3iphTQAkurk5+X5XDNzzCOwgXsFpOE521oGvwt/ASVBV1Dt20
	 GjEcrIJBixskiEGhj1brjq2/ye6pkSEo7uPONLf4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.7
Date: Fri, 27 Dec 2024 14:45:19 +0100
Message-ID: <2024122720-aviator-famished-fdc3@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.7 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                      |    2 
 arch/arm64/kvm/sys_regs.c                                     |    3 
 arch/hexagon/Makefile                                         |    6 
 arch/riscv/kvm/aia.c                                          |    2 
 arch/s390/boot/startup.c                                      |    2 
 arch/s390/boot/vmem.c                                         |    6 
 arch/s390/kernel/ipl.c                                        |    2 
 arch/x86/kernel/cpu/mshyperv.c                                |   58 ++
 arch/x86/kvm/cpuid.c                                          |   31 -
 arch/x86/kvm/cpuid.h                                          |    1 
 arch/x86/kvm/svm/svm.c                                        |    9 
 arch/x86/kvm/x86.c                                            |    4 
 block/blk-mq-sysfs.c                                          |   16 
 block/blk-mq.c                                                |   40 -
 block/blk-sysfs.c                                             |    4 
 drivers/accel/ivpu/ivpu_gem.c                                 |    2 
 drivers/accel/ivpu/ivpu_pm.c                                  |    2 
 drivers/block/zram/zram_drv.c                                 |   15 
 drivers/clocksource/hyperv_timer.c                            |   14 
 drivers/cxl/core/region.c                                     |   25 
 drivers/cxl/pci.c                                             |    3 
 drivers/dma-buf/dma-buf.c                                     |    2 
 drivers/dma-buf/udmabuf.c                                     |  174 +++---
 drivers/edac/amd64_edac.c                                     |   32 -
 drivers/firmware/arm_ffa/bus.c                                |   15 
 drivers/firmware/arm_ffa/driver.c                             |    7 
 drivers/firmware/arm_scmi/vendors/imx/Kconfig                 |    1 
 drivers/firmware/imx/Kconfig                                  |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c              |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                       |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                        |    7 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                        |    2 
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c                     |    2 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c                        |   11 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c                       |    2 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c                        |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c          |    2 
 drivers/gpu/drm/display/drm_dp_tunnel.c                       |   10 
 drivers/gpu/drm/drm_modes.c                                   |   11 
 drivers/gpu/drm/i915/gt/intel_engine_types.h                  |    5 
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c             |   41 +
 drivers/gpu/drm/panel/panel-himax-hx83102.c                   |    2 
 drivers/gpu/drm/panel/panel-novatek-nt35950.c                 |    4 
 drivers/gpu/drm/panel/panel-sitronix-st7701.c                 |    1 
 drivers/gpu/drm/panel/panel-synaptics-r63353.c                |    2 
 drivers/hv/hv_kvp.c                                           |    6 
 drivers/hv/hv_snapshot.c                                      |    6 
 drivers/hv/hv_util.c                                          |    9 
 drivers/hv/hyperv_vmbus.h                                     |    2 
 drivers/hwmon/tmp513.c                                        |   10 
 drivers/i2c/busses/i2c-pnx.c                                  |    4 
 drivers/i2c/busses/i2c-riic.c                                 |    2 
 drivers/irqchip/irq-gic-v3.c                                  |   17 
 drivers/mmc/host/mtk-sd.c                                     |    2 
 drivers/mmc/host/sdhci-tegra.c                                |    1 
 drivers/net/can/m_can/m_can.c                                 |   36 -
 drivers/net/can/m_can/m_can.h                                 |    1 
 drivers/net/can/m_can/m_can_pci.c                             |    1 
 drivers/net/ethernet/broadcom/bgmac-platform.c                |    5 
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c |    5 
 drivers/net/ethernet/huawei/hinic/hinic_main.c                |    2 
 drivers/net/ethernet/mscc/ocelot.c                            |    2 
 drivers/net/ethernet/oa_tc6.c                                 |   11 
 drivers/net/ethernet/pensando/ionic/ionic_dev.c               |    5 
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c           |    4 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c               |    4 
 drivers/net/ethernet/renesas/rswitch.c                        |   74 +-
 drivers/net/ethernet/renesas/rswitch.h                        |   13 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c             |    7 
 drivers/net/mdio/fwnode_mdio.c                                |   13 
 drivers/net/netdevsim/health.c                                |    2 
 drivers/net/netdevsim/netdev.c                                |    4 
 drivers/net/team/team_core.c                                  |    8 
 drivers/net/tun.c                                             |    2 
 drivers/of/address.c                                          |    5 
 drivers/of/base.c                                             |   15 
 drivers/of/irq.c                                              |    2 
 drivers/of/property.c                                         |    2 
 drivers/platform/x86/p2sb.c                                   |   77 ++
 drivers/thunderbolt/nhi.c                                     |    8 
 drivers/thunderbolt/nhi.h                                     |    4 
 drivers/thunderbolt/retimer.c                                 |   19 
 drivers/thunderbolt/tb.c                                      |   41 +
 drivers/usb/host/xhci-ring.c                                  |    2 
 drivers/usb/serial/option.c                                   |   27 +
 fs/btrfs/bio.c                                                |   10 
 fs/btrfs/ctree.h                                              |   19 
 fs/btrfs/extent-tree.c                                        |    6 
 fs/btrfs/tree-checker.c                                       |   27 -
 fs/ceph/file.c                                                |   77 +-
 fs/ceph/mds_client.c                                          |    9 
 fs/ceph/super.c                                               |    2 
 fs/efivarfs/inode.c                                           |    2 
 fs/efivarfs/internal.h                                        |    1 
 fs/efivarfs/super.c                                           |    3 
 fs/erofs/data.c                                               |   36 -
 fs/erofs/fileio.c                                             |    9 
 fs/erofs/fscache.c                                            |   10 
 fs/erofs/internal.h                                           |   15 
 fs/erofs/super.c                                              |   78 +-
 fs/erofs/zdata.c                                              |    4 
 fs/eventpoll.c                                                |    5 
 fs/hugetlbfs/inode.c                                          |    2 
 fs/nfs/pnfs.c                                                 |    2 
 fs/nilfs2/btnode.c                                            |    1 
 fs/nilfs2/gcinode.c                                           |    2 
 fs/nilfs2/inode.c                                             |   13 
 fs/nilfs2/namei.c                                             |    5 
 fs/nilfs2/nilfs.h                                             |    1 
 fs/ocfs2/localalloc.c                                         |    8 
 fs/smb/client/connect.c                                       |   36 -
 fs/smb/server/connection.c                                    |   18 
 fs/smb/server/connection.h                                    |    1 
 fs/smb/server/server.c                                        |    7 
 fs/smb/server/server.h                                        |    1 
 fs/smb/server/transport_ipc.c                                 |    5 
 fs/xfs/libxfs/xfs_ialloc.c                                    |   16 
 fs/xfs/libxfs/xfs_sb.c                                        |   15 
 fs/xfs/scrub/agheader.c                                       |   29 +
 fs/xfs/xfs_fsmap.c                                            |   29 -
 include/clocksource/hyperv_timer.h                            |    2 
 include/linux/alloc_tag.h                                     |    7 
 include/linux/arm_ffa.h                                       |   13 
 include/linux/hyperv.h                                        |    1 
 include/linux/io_uring.h                                      |    4 
 include/linux/page-flags.h                                    |   12 
 include/linux/sched.h                                         |    7 
 include/linux/trace_events.h                                  |    6 
 include/linux/wait.h                                          |    1 
 io_uring/io_uring.c                                           |    7 
 kernel/sched/core.c                                           |    2 
 kernel/sched/deadline.c                                       |    8 
 kernel/sched/debug.c                                          |    1 
 kernel/sched/fair.c                                           |   73 ++
 kernel/sched/pelt.c                                           |    2 
 kernel/sched/sched.h                                          |   13 
 kernel/trace/fgraph.c                                         |    8 
 kernel/trace/ring_buffer.c                                    |    6 
 kernel/trace/trace.c                                          |  264 ++--------
 kernel/trace/trace.h                                          |    6 
 kernel/trace/trace_events.c                                   |  225 ++++++--
 kernel/trace/trace_output.c                                   |    6 
 mm/huge_memory.c                                              |    8 
 mm/hugetlb.c                                                  |    5 
 mm/memory.c                                                   |    8 
 mm/page_alloc.c                                               |    6 
 mm/shmem.c                                                    |   22 
 mm/vmalloc.c                                                  |    6 
 net/core/netdev-genl.c                                        |   19 
 net/dsa/tag.h                                                 |   16 
 net/mctp/route.c                                              |   36 -
 net/mctp/test/route-test.c                                    |   86 +++
 net/netfilter/ipset/ip_set_list_set.c                         |    3 
 net/netfilter/ipvs/ip_vs_conn.c                               |    4 
 net/psample/psample.c                                         |    9 
 net/sched/sch_cake.c                                          |    2 
 net/sched/sch_choke.c                                         |    2 
 net/smc/af_smc.c                                              |   18 
 net/smc/smc_clc.c                                             |   17 
 net/smc/smc_clc.h                                             |   22 
 net/smc/smc_core.c                                            |    9 
 sound/soc/fsl/Kconfig                                         |    1 
 tools/hv/hv_fcopy_uio_daemon.c                                |    8 
 tools/hv/hv_set_ifconfig.sh                                   |    2 
 tools/net/ynl/lib/ynl.py                                      |    6 
 tools/testing/selftests/bpf/sdt.h                             |    2 
 tools/testing/selftests/memfd/memfd_test.c                    |   14 
 tools/testing/selftests/net/openvswitch/openvswitch.sh        |    6 
 168 files changed, 1680 insertions(+), 886 deletions(-)

Adrian Moreno (2):
      selftests: openvswitch: fix tcpdump execution
      psample: adjust size if rate_as_probability is set

Alex Deucher (6):
      drm/amdgpu/nbio7.11: fix IP version check
      drm/amdgpu/nbio7.7: fix IP version check
      drm/amdgpu/smu14.0.2: fix IP version check
      drm/amdgpu/nbio7.0: fix IP version check
      drm/amdgpu/gfx12: fix IP version check
      drm/amdgpu/mmhub4.1: fix IP version check

Alex Markuze (1):
      ceph: improve error handling and short/overflow-read logic in __ceph_sync_read()

Alexander Gordeev (1):
      s390/ipl: Fix never less than zero warning

Andrea della Porta (1):
      of: address: Preserve the flags portion on 1:1 dma-ranges mapping

Arnd Bergmann (1):
      firmware: arm_scmi: Fix i.MX build dependency

Borislav Petkov (AMD) (1):
      EDAC/amd64: Simplify ECC check on unified memory controllers

Brett Creeley (1):
      ionic: Fix netdev notifier unregister on failure

Christian König (1):
      drm/amdgpu: fix amdgpu_coredump

Christoph Hellwig (1):
      btrfs: split bios to the fs sector size boundary

Dan Carpenter (2):
      net: hinic: Fix cleanup in create_rxqs/txqs()
      chelsio/chtls: prevent potential integer overflow on 32bit

Daniel Borkmann (1):
      team: Fix feature exposure when no ports are present

Daniel Swanemar (1):
      USB: serial: option: add TCL IK512 MBIM & ECM

Daniele Palmas (1):
      USB: serial: option: add Telit FE910C04 rmnet compositions

Darrick J. Wong (3):
      xfs: fix off-by-one error in fsmap's end_daddr usage
      xfs: fix sb_spino_align checks for large fsblock sizes
      xfs: fix zero byte checking in the superblock scrubber

Dave Chinner (2):
      xfs: sb_spino_align is not verified
      xfs: fix sparse inode limits on runt AG

David Hildenbrand (1):
      mm/page_alloc: don't call pfn_to_page() on possibly non-existent PFN in split_large_buddy()

David Laight (1):
      ipvs: Fix clamp() of ip_vs_conn_tab on small memory systems

Davidlohr Bueso (1):
      cxl/pci: Fix potential bogus return value upon successful probing

Dexuan Cui (1):
      tools: hv: Fix a complier warning in the fcopy uio daemon

Donald Hunter (1):
      tools/net/ynl: fix sub-message key lookup for nested attributes

Edward Adam Davis (2):
      ring-buffer: Fix overflow in __rb_map_vma
      nilfs2: prevent use of deleted inode

Enzo Matsumiya (1):
      smb: client: fix TCP timers deadlock after rmmod

Eric Dumazet (3):
      netdevsim: prevent bad user input in nsim_dev_health_break_write()
      net: netdevsim: fix nsim_pp_hold_write()
      net: tun: fix tun_napi_alloc_frags()

Gao Xiang (5):
      erofs: fix PSI memstall accounting
      erofs: add erofs_sb_free() helper
      erofs: use `struct erofs_device_info` for the primary device
      erofs: reference `struct erofs_device_info` for erofs_map_dev
      erofs: use buffered I/O for file-backed mounts by default

Geert Uytterhoeven (1):
      i2c: riic: Always round-up when calculating bus period

Greg Kroah-Hartman (1):
      Linux 6.12.7

Guangguan Wang (6):
      net/smc: protect link down work from execute after lgr freed
      net/smc: check sndbuf_space again after NOSPACE flag is set in smc_poll
      net/smc: check iparea_offset and ipv6_prefixes_cnt when receiving proposal msg
      net/smc: check v2_ext_offset/eid_cnt/ism_gid_cnt when receiving proposal msg
      net/smc: check smcd_v2_ext_offset when receiving proposal msg
      net/smc: check return value of sock_recvmsg when draining clc data

Heiko Carstens (1):
      s390/mm: Fix DirectMap accounting

Heming Zhao (1):
      ocfs2: fix the space leak in LA when releasing LA

Herve Codina (1):
      of: Fix error path in of_parse_phandle_with_args_map()

Huaisheng Ye (1):
      cxl/region: Fix region creation for greater than x2 switches

Huan Yang (1):
      udmabuf: udmabuf_create pin folio codestyle cleanup

Hugh Dickins (1):
      mm: shmem: fix ShmemHugePages at swapout

Ilya Dryomov (2):
      ceph: validate snapdirname option length when mounting
      ceph: fix memory leak in ceph_direct_read_write()

Isaac J. Manjarres (1):
      selftests/memfd: run sysctl tests when PID namespace support is enabled

Jacek Lawrynowicz (2):
      accel/ivpu: Fix general protection fault in ivpu_bo_list()
      accel/ivpu: Fix WARN in ivpu_ipc_send_receive_internal()

Jack Wu (1):
      USB: serial: option: add MediaTek T7XX compositions

Jakub Kicinski (3):
      netdev: fix repeated netlink messages in queue dump
      netdev: fix repeated netlink messages in queue stats
      netdev-genl: avoid empty messages in queue dump

James Bottomley (1):
      efivarfs: Fix error on non-existent file

Jann Horn (4):
      udmabuf: fix memory leak on last export_udmabuf() error path
      io_uring: Fix registered ring file refcount leak
      udmabuf: fix racy memfd sealing check
      udmabuf: also check for F_SEAL_FUTURE_WRITE

Jeremy Kerr (1):
      net: mctp: handle skb cleanup on sock_queue failures

Joe Hattori (3):
      net: ethernet: bgmac-platform: fix an OF node reference leak
      net: mdiobus: fix an OF node reference leak
      mmc: mtk-sd: disable wakeup in .remove() and in the error path of .probe()

Josef Bacik (1):
      btrfs: fix improper generation check in snapshot delete

K Prateek Nayak (1):
      sched/fair: Fix NEXT_BUDDY

Kairui Song (2):
      zram: refuse to use zero sized block device as backing device
      zram: fix uninitialized ZRAM not releasing backing device

Kefeng Wang (2):
      mm: use aligned address in clear_gigantic_page()
      mm: use aligned address in copy_user_gigantic_page()

Krzysztof Karas (1):
      drm/display: use ERR_PTR on DP tunnel manager creation fail

Levi Yun (1):
      firmware: arm_ffa: Fix the race around setting ffa_dev->properties

Lion Ackermann (1):
      net: sched: fix ordering of qlen adjustment

Mank Wang (1):
      USB: serial: option: add Netprisma LCUK54 modules for WWAN Ready

Marc Zyngier (2):
      irqchip/gic-v3: Work around insecure GIC integrations
      KVM: arm64: Do not allow ID_AA64MMFR0_EL1.ASIDbits to be overridden

Marek Vasut (1):
      drm/panel: st7701: Add prepare_prev_first flag to drm_panel

Mario Limonciello (2):
      thunderbolt: Don't display nvm_version unless upgrade supported
      drm/amd: Update strapping for NBIO 2.5.0

Marios Makassikis (2):
      ksmbd: count all requests in req_running counter
      ksmbd: fix broken transfers when exceeding max simultaneous operations

Mathias Nyman (1):
      xhci: Turn NEC specific quirk for handling Stop Endpoint errors generic

Matthew Wilcox (Oracle) (1):
      vmalloc: fix accounting with i915

Matthias Schiffer (2):
      can: m_can: set init flag earlier in probe
      can: m_can: fix missed interrupts with m_can_pci

Max Kellermann (2):
      ceph: give up on paths longer than PATH_MAX
      ceph: fix memory leaks in __ceph_sync_read()

Michael Kelley (1):
      Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet

Michael Neuling (1):
      RISC-V: KVM: Fix csr_write -> csr_set for HVIEN PMU overflow bit

Michael Trimarchi (1):
      drm/panel: synaptics-r63353: Fix regulator unbalance

Michal Hrusecky (1):
      USB: serial: option: add MeiG Smart SLM770A

Michel Dänzer (1):
      drm/amdgpu: Handle NULL bo->tbo.resource (again) in amdgpu_vm_bo_update

Mika Westerberg (2):
      thunderbolt: Add support for Intel Panther Lake-M/P
      thunderbolt: Improve redrive mode handling

Ming Lei (2):
      block: Revert "block: Fix potential deadlock while freezing queue and acquiring sysfs_lock"
      block: avoid to reuse `hctx` not removed from cpuhp callback list

Murad Masimov (3):
      hwmon: (tmp513) Fix interpretation of values of Shunt Voltage and Limit Registers
      hwmon: (tmp513) Fix Current Register value interpretation
      hwmon: (tmp513) Fix interpretation of values of Temperature Result and Limit Registers

Naman Jain (1):
      x86/hyperv: Fix hv tsc page based sched_clock for hibernation

Nathan Chancellor (1):
      hexagon: Disable constant extender optimization for LLVM prior to 19.1.0

Nikita Yushchenko (1):
      net: renesas: rswitch: rework ts tags management

Olaf Hering (1):
      tools: hv: change permissions of NetworkManager configuration file

Parthiban Veerasooran (2):
      net: ethernet: oa_tc6: fix infinite loop error when tx credits becomes 0
      net: ethernet: oa_tc6: fix tx skb race condition between reference pointers

Pavel Begunkov (1):
      io_uring: check if iowq is killed before queuing

Peter Zijlstra (1):
      sched/eevdf: More PELT vs DELAYED_DEQUEUE

Phil Sutter (1):
      netfilter: ipset: Fix for recursive locking warning

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: don't access invalid sched

Prathamesh Shete (1):
      mmc: sdhci-tegra: Remove SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk

Qu Wenruo (1):
      btrfs: tree-checker: reject inline extent items with 0 ref count

Russell King (Oracle) (1):
      net: stmmac: fix TSO DMA API usage causing oops

Ryusuke Konishi (1):
      nilfs2: fix buffer head leaks in calls to truncate_inode_pages()

Samuel Holland (1):
      of: property: fw_devlink: Do not use interrupt-parent directly

Sean Christopherson (3):
      KVM: x86: Cache CPUID.0xD XSTATE offsets+sizes during module init
      KVM: x86: Play nice with protected guests in complete_hypercall_exit()
      KVM: SVM: Allow guest writes to set MSR_AMD64_DE_CFG bits

Shannon Nelson (2):
      ionic: no double destroy workqueue
      ionic: use ee->offset when returning sprom data

Shin'ichiro Kawasaki (4):
      p2sb: Factor out p2sb_read_from_cache()
      p2sb: Introduce the global flag p2sb_hidden_by_bios
      p2sb: Move P2SB hide and unhide code to p2sb_scan_and_cache()
      p2sb: Do not scan and remove the P2SB device when it is unhidden

Steven Rostedt (6):
      trace/ring-buffer: Do not use TP_printk() formatting for boot mapped buffers
      fgraph: Still initialize idle shadow stacks when starting
      tracing: Fix test_event_printk() to process entire print argument
      tracing: Add missing helper functions in event pointer dereference check
      tracing: Add "%s" check in test_event_printk()
      tracing: Check "%s" dereference via the field and not the TP_printk format

Suren Baghdasaryan (1):
      alloc_tag: fix set_codetag_empty() when !CONFIG_MEM_ALLOC_PROFILING_DEBUG

T.J. Mercier (1):
      dma-buf: Fix __dma_buf_debugfs_list_del argument for !CONFIG_DEBUG_FS

Tiezhu Yang (1):
      selftests/bpf: Use asm constraint "m" for LoongArch

Trond Myklebust (1):
      NFS/pnfs: Fix a live lock between recalled layouts and layoutget

Umesh Nerlige Ramappa (3):
      i915/guc: Reset engine utilization buffer before registration
      i915/guc: Ensure busyness counter increases motonically
      i915/guc: Accumulate active runtime on gt reset

Usama Arif (1):
      mm: convert partially_mapped set/clear operations to be atomic

Vasily Gorbik (1):
      s390/mm: Consider KMSAN modules metadata for paging levels

Ville Syrjälä (1):
      drm/modes: Avoid divide by zero harder in drm_mode_vrefresh()

Vincent Guittot (1):
      sched/fair: Fix sched_can_stop_tick() for fair tasks

Vineeth Pillai (Google) (2):
      sched/dlserver: Fix dlserver double enqueue
      sched/dlserver: Fix dlserver time accounting

Vladimir Oltean (2):
      net: mscc: ocelot: fix incorrect IFH SRC_PORT field in ocelot_ifh_set_basic()
      net: dsa: restore dsa_software_vlan_untag() ability to operate on VLAN-untagged traffic

Vladimir Riabchun (1):
      i2c: pnx: Fix timeout in wait functions

Xuewen Yan (1):
      epoll: Add synchronous wakeup support for ep_poll_callback

Yang Yingliang (1):
      drm/panel: novatek-nt35950: fix return value check in nt35950_probe()

Zhang Zekun (1):
      drm/panel: himax-hx83102: Add a check to prevent NULL pointer dereference

Zijun Hu (3):
      of/irq: Fix interrupt-map cell length check in of_irq_parse_imap_parent()
      of/irq: Fix using uninitialized variable @addr_len in API of_irq_parse_one()
      of: Fix refcount leakage for OF node returned by __of_get_dma_parent()


