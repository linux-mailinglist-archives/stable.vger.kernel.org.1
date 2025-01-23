Return-Path: <stable+bounces-110309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6605A1A8B4
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B93188E27F
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 17:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E0E14F126;
	Thu, 23 Jan 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GWlHIuXl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5090214C5AE;
	Thu, 23 Jan 2025 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652350; cv=none; b=WJYRZhkfS4BSpAgslk8lzPZhVdPnGKJSrdxsbFNm7fWHg/8572ywO5czIFFTGZMXgZCGzlTmFcpEXZXACzVYKFteF6TDB71yzXJuITjl5cOxbXE3A4kF649iFXR0y31iWqlPmjXWSaCxh0sw/tfLoHhf4FEXOCxllDAmqDz6XrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652350; c=relaxed/simple;
	bh=sFNuTF5ETxWpDWklh8sj6qvpJBk6YqYzNuFF+HL2F9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uJw3pSWOeIfXSYg2oaMUUGfBQLq6RecIt4ksDe6LkV9B2vvlxDgWckqU0wuQ8u56famzIhOIlo71CMEFG4LYbJ+3GfFQaPVXI0nCRlqVfI3asLlKU9SDhdsmHn6wwxmaMlksfmCJwgEPhPW9apeOJJqFFe2Xvdne6kw9wA6/7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GWlHIuXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A35CC4CED3;
	Thu, 23 Jan 2025 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737652349;
	bh=sFNuTF5ETxWpDWklh8sj6qvpJBk6YqYzNuFF+HL2F9o=;
	h=From:To:Cc:Subject:Date:From;
	b=GWlHIuXlRnnxznjw3QQMpJB/MYdVIQFH2HLDnUGJp+sJPVldrKruVwGX59WhT2Uds
	 zFHnQrgbxiAB5g8N0GaK0JDg0hH/AzZZDaB5J6wkaJ8j3f3Kw0ER7XEEC4KyIHRuE/
	 +xG7WEfmCs4l3i+nSQ/N7vcHYme15j60Ibl2uvOo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.11
Date: Thu, 23 Jan 2025 18:12:21 +0100
Message-ID: <2025012322-scuff-culminate-51b4@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.11 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                            |    2 
 arch/x86/include/asm/special_insns.h                                |    2 
 arch/x86/kernel/fred.c                                              |    8 
 drivers/acpi/resource.c                                             |    6 
 drivers/block/zram/zram_drv.c                                       |    1 
 drivers/cpufreq/Kconfig                                             |    4 
 drivers/cpuidle/governors/teo.c                                     |   91 +--
 drivers/firmware/efi/Kconfig                                        |    4 
 drivers/firmware/efi/libstub/Makefile.zboot                         |   18 
 drivers/gpio/gpio-sim.c                                             |   48 +
 drivers/gpio/gpio-virtuser.c                                        |   47 +
 drivers/gpio/gpio-xilinx.c                                          |   32 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                          |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c                  |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c                              |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                   |   41 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c               |   25 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c              |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h              |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c           |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c         |   14 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c               |   35 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h               |    3 
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c                |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                |   11 
 drivers/gpu/drm/i915/display/intel_fb.c                             |    2 
 drivers/gpu/drm/nouveau/nouveau_fence.c                             |    6 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/mcp77.c                    |    1 
 drivers/gpu/drm/tests/drm_kunit_helpers.c                           |    3 
 drivers/gpu/drm/v3d/v3d_irq.c                                       |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                                  |    3 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                                  |    3 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                                 |    7 
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c                                 |    1 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                                 |   20 
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c                              |    7 
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c                          |    5 
 drivers/gpu/drm/xe/xe_hw_engine.c                                   |    2 
 drivers/gpu/drm/xe/xe_oa.c                                          |    1 
 drivers/hwmon/ltc2991.c                                             |    2 
 drivers/hwmon/tmp513.c                                              |    7 
 drivers/i2c/busses/i2c-rcar.c                                       |   20 
 drivers/i2c/i2c-atr.c                                               |    2 
 drivers/i2c/i2c-core-base.c                                         |    1 
 drivers/i2c/i2c-slave-testunit.c                                    |   19 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                               |    4 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                            |    1 
 drivers/infiniband/hw/bnxt_re/ib_verbs.h                            |    4 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                            |    1 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                            |    1 
 drivers/irqchip/irq-gic-v3-its.c                                    |    2 
 drivers/irqchip/irq-gic-v3.c                                        |    2 
 drivers/irqchip/irqchip.c                                           |    4 
 drivers/mtd/spi-nor/core.c                                          |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c                         |   19 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                           |   25 
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                           |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                       |    7 
 drivers/net/ethernet/freescale/fec_main.c                           |   19 
 drivers/net/ethernet/intel/ice/ice.h                                |    5 
 drivers/net/ethernet/intel/ice/ice_adapter.c                        |    6 
 drivers/net/ethernet/intel/ice/ice_adapter.h                        |   22 
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h                     |    1 
 drivers/net/ethernet/intel/ice/ice_common.c                         |   51 +
 drivers/net/ethernet/intel/ice/ice_common.h                         |    1 
 drivers/net/ethernet/intel/ice/ice_main.c                           |    6 
 drivers/net/ethernet/intel/ice/ice_ptp.c                            |  165 +++--
 drivers/net/ethernet/intel/ice/ice_ptp.h                            |    9 
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h                     |    2 
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c                         |  285 +++++-----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h                         |    5 
 drivers/net/ethernet/intel/ice/ice_type.h                           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c            |   22 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c         |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c    |   11 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c                   |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c              |    4 
 drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c                |    1 
 drivers/net/ethernet/mellanox/mlx5/core/wc.c                        |   24 
 drivers/net/ethernet/netronome/nfp/bpf/offload.c                    |    3 
 drivers/net/ethernet/renesas/ravb_main.c                            |    1 
 drivers/net/ethernet/ti/cpsw_ale.c                                  |   14 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                   |    6 
 drivers/net/gtp.c                                                   |   26 
 drivers/net/pfcp.c                                                  |   15 
 drivers/nvme/target/io-cmd-bdev.c                                   |    2 
 drivers/platform/x86/dell/dell-uart-backlight.c                     |    5 
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c         |    1 
 drivers/platform/x86/intel/tpmi_power_domains.c                     |    1 
 drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c        |    5 
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c                              |    2 
 drivers/reset/reset-rzg2l-usbphy-ctrl.c                             |    1 
 drivers/ufs/core/ufshcd.c                                           |    9 
 fs/afs/addr_prefs.c                                                 |    6 
 fs/btrfs/volumes.c                                                  |    4 
 fs/cachefiles/daemon.c                                              |   14 
 fs/cachefiles/internal.h                                            |    3 
 fs/cachefiles/security.c                                            |    6 
 fs/file.c                                                           |    1 
 fs/hfs/super.c                                                      |    4 
 fs/iomap/buffered-io.c                                              |    2 
 fs/netfs/read_collect.c                                             |    9 
 fs/proc/vmcore.c                                                    |    2 
 fs/qnx6/inode.c                                                     |   11 
 fs/smb/client/connect.c                                             |    3 
 include/linux/hrtimer.h                                             |    1 
 include/linux/poll.h                                                |   10 
 include/linux/pruss_driver.h                                        |   12 
 include/linux/userfaultfd_k.h                                       |   12 
 include/net/page_pool/helpers.h                                     |    2 
 include/trace/events/mmflags.h                                      |   63 ++
 kernel/cpu.c                                                        |    2 
 kernel/gen_kheaders.sh                                              |    1 
 kernel/sched/ext.c                                                  |   11 
 kernel/sched/fair.c                                                 |    6 
 kernel/time/hrtimer.c                                               |   11 
 kernel/time/timer_migration.c                                       |   43 +
 mm/filemap.c                                                        |    2 
 mm/huge_memory.c                                                    |   12 
 mm/hugetlb.c                                                        |   14 
 mm/kmemleak.c                                                       |    2 
 mm/mremap.c                                                         |   32 +
 mm/vmscan.c                                                         |    3 
 net/core/filter.c                                                   |   30 -
 net/core/netdev-genl-gen.c                                          |   14 
 net/core/pktgen.c                                                   |    6 
 net/mac802154/iface.c                                               |    4 
 net/mptcp/options.c                                                 |    6 
 net/mptcp/protocol.h                                                |    9 
 net/ncsi/internal.h                                                 |    2 
 net/ncsi/ncsi-manage.c                                              |   16 
 net/ncsi/ncsi-rsp.c                                                 |   19 
 net/openvswitch/actions.c                                           |    4 
 net/vmw_vsock/af_vsock.c                                            |   18 
 net/vmw_vsock/virtio_transport_common.c                             |   36 -
 net/vmw_vsock/vsock_bpf.c                                           |    9 
 security/apparmor/policy.c                                          |    1 
 sound/pci/hda/patch_realtek.c                                       |    3 
 tools/net/ynl/ynl-gen-c.py                                          |   16 
 tools/testing/selftests/mm/cow.c                                    |    8 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                   |   43 +
 tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c         |    2 
 tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c        |    4 
 tools/testing/selftests/sched_ext/dsp_local_on.bpf.c                |    7 
 tools/testing/selftests/sched_ext/dsp_local_on.c                    |    5 
 tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c        |    2 
 tools/testing/selftests/sched_ext/exit.bpf.c                        |    4 
 tools/testing/selftests/sched_ext/maximal.bpf.c                     |    8 
 tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c              |    2 
 tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c   |    2 
 tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c         |    2 
 tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c |    2 
 tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c |    4 
 tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c            |    8 
 tools/testing/selftests/tc-testing/tc-tests/filters/flow.json       |    4 
 tools/testing/shared/linux/maple_tree.h                             |    2 
 tools/testing/vma/linux/atomic.h                                    |    2 
 157 files changed, 1324 insertions(+), 636 deletions(-)

Alex Deucher (1):
      drm/amdgpu/smu13: update powersave optimizations

Ard Biesheuvel (1):
      efi/zboot: Limit compression options to GZIP and ZSTD

Artem Chernyshev (1):
      pktgen: Avoid out-of-bounds access in get_imix_entries

Ashutosh Dixit (1):
      drm/xe/oa: Add missing VISACTL mux registers

Brahmajit Das (1):
      fs/qnx6: Fix building with GCC 15

Chenyuan Yang (2):
      platform/x86: dell-uart-backlight: fix serdev race
      platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: fix serdev race

Chris Mi (1):
      net/mlx5: SF, Fix add port error handling

Christian König (1):
      drm/amdgpu: always sync the GFX pipe on ctx switch

Claudiu Beznea (1):
      reset: rzg2l-usbphy-ctrl: Assign proper of node to the allocated device

Dan Carpenter (1):
      nfp: bpf: prevent integer overflow in nfp_bpf_event_output()

Dave Airlie (1):
      nouveau/fence: handle cross device fences properly

David Howells (2):
      kheaders: Ignore silly-rename files
      netfs: Fix non-contiguous donation between completed reads

David Lechner (2):
      hwmon: (tmp513) Fix division of negative numbers
      hwmon: (ltc2991) Fix mixed signed/unsigned in DIV_ROUND_CLOSEST

David Vernet (1):
      scx: Fix maximal BPF selftest prog

Donet Tom (1):
      mm: vmscan : pgdemote vmstat is not getting updated when MGLRU is enabled.

Frederic Weisbecker (2):
      timers/migration: Fix another race between hotplug and idle entry/exit
      timers/migration: Enforce group initialization visibility to tree walkers

Greg Kroah-Hartman (1):
      Linux 6.12.11

Gui Chengming (1):
      drm/amdgpu: fix fw attestation for MP0_14_0_{2/3}

Guo Weikang (1):
      mm/kmemleak: fix percpu memory leak detection failure

Hans de Goede (1):
      ACPI: resource: acpi_dev_irq_override(): Check DMI match last

Heiner Kallweit (1):
      net: ethernet: xgbe: re-add aneg to supported features in PHY quirks

Henry Huang (1):
      sched_ext: keep running prev when prev->scx.slice != 0

Hongguang Gao (1):
      RDMA/bnxt_re: Fix to export port num to ib_query_qp

Ian Forbes (2):
      drm/vmwgfx: Unreserve BO on error
      drm/vmwgfx: Add new keep_resv BO param

Ihor Solodrai (1):
      selftests/sched_ext: fix build after renames in sched_ext API

Ilya Maximets (1):
      openvswitch: fix lockup on tx to unregistering netdev with carrier

Jakub Kicinski (3):
      eth: bnxt: always recalculate features after XDP clearing, fix null-deref
      netdev: avoid CFI problems with sock priv helpers
      selftests: tc-testing: reduce rshift value

Joe Hattori (2):
      i2c: core: fix reference leak in i2c_register_adapter()
      irqchip: Plug a OF node reference leak in platform_irqchip_probe()

Juergen Gross (1):
      x86/asm: Make serialize() always_inline

Kairui Song (1):
      zram: fix potential UAF of zram table

Karol Kolacinski (4):
      ice: Fix E825 initialization
      ice: Fix quad registers read on E825
      ice: Fix ETH56G FC-FEC Rx offset value
      ice: Add correct PHY lane assignment

Kenneth Feng (1):
      drm/amdgpu: disable gfxoff with the compute workload on gfx12

Kevin Groeneveld (1):
      net: fec: handle page_pool_dev_alloc_pages error

Koichiro Den (3):
      gpio: virtuser: lock up configfs that an instantiated device depends on
      gpio: sim: lock up configfs that an instantiated device depends on
      hrtimers: Handle CPU state correctly on hotplug

Kuniyuki Iwashima (3):
      gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().
      gtp: Destroy device along with udp socket's netns dismantle.
      pfcp: Destroy device along with udp socket's netns dismantle.

Leo Li (2):
      drm/amd/display: Do not elevate mem_type change to full update
      drm/amd/display: Do not wait for PSR disable on vbl enable

Leo Stone (1):
      hfs: Sanity check the root record

Leon Romanovsky (3):
      net/mlx5e: Fix inversion dependency warning while enabling IPsec tunnel
      net/mlx5e: Rely on reqid in IPsec tunnel mode
      net/mlx5e: Always start IPsec sequence number from 1

Lizhi Xu (2):
      mac802154: check local interfaces before deleting sdata list
      afs: Fix merge preference rule failure condition

Luis Chamberlain (1):
      nvmet: propagate npwg topology

Luke D. Jones (2):
      ALSA: hda/realtek: fixup ASUS GA605W
      ALSA: hda/realtek: fixup ASUS H7606W

MD Danish Anwar (1):
      soc: ti: pruss: Fix pruss APIs

Manivannan Sadhasivam (1):
      scsi: ufs: core: Honor runtime/system PM levels if set by host controller drivers

Marco Nelissen (2):
      iomap: avoid avoid truncating 64-bit offset to 32 bits
      filemap: avoid truncating 64-bit offset to 32 bits

Mark Zhang (1):
      net/mlx5: Clear port select structure when fail to create

Matthew Brost (1):
      drm/xe: Mark ComputeCS read mode as UC on iGPU

Max Kellermann (1):
      cachefiles: Parse the "secctx" immediately

Maíra Canal (1):
      drm/v3d: Ensure job pointer is set to NULL after job completion

Michal Luczaj (1):
      bpf: Fix bpf_sk_select_reuseport() memory leak

Nicholas Susanto (1):
      Revert "drm/amd/display: Enable urgent latency adjustments for DCN35"

Oleg Nesterov (1):
      poll_wait: add mb() to fix theoretical race between waitqueue_active() and .poll()

Paolo Abeni (3):
      mptcp: be sure to send ack when mptcp-level window re-opens
      mptcp: fix spurious wake-up on under memory pressure
      selftests: mptcp: avoid spurious errors on disconnect

Patrisious Haddad (1):
      net/mlx5: Fix RDMA TX steering prio

Paul Barker (1):
      net: ravb: Fix max TX frame size for RZ/V2M

Paul Fertser (1):
      net/ncsi: fix locking in Get MAC Address handling

Paulo Alcantara (1):
      smb: client: fix double free of TCP_Server_Info::hostname

Pavel Begunkov (1):
      net: make page_pool_ref_netmem work with net iovs

Peter Zijlstra (1):
      sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE

Pratyush Yadav (1):
      Revert "mtd: spi-nor: core: replace dummy buswidth from addr to data"

Qu Wenruo (1):
      btrfs: add the missing error handling inside get_canonical_dev_path

Rafael J. Wysocki (1):
      cpuidle: teo: Update documentation after previous changes

Rik van Riel (1):
      fs/proc: fix softlockup in __read_vmcore (part 2)

Ryan Lee (1):
      apparmor: allocate xmatch for nullpdb inside aa_alloc_null

Ryan Roberts (2):
      selftests/mm: set allocated memory to non-zero content in cow test
      mm: clear uffd-wp PTE/PMD state on mremap()

Sean Anderson (2):
      net: xilinx: axienet: Fix IRQ coalescing packet count overflow
      gpio: xilinx: Convert gpio_lock to raw spinlock

Sergey Temerkhanov (3):
      ice: Introduce ice_get_phy_model() wrapper
      ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
      ice: Use ice_adapter for PTP shared data instead of auxdev

Srinivas Pandruvada (2):
      platform/x86/intel: power-domains: Add Clearwater Forest support
      platform/x86: ISST: Add Clearwater Forest to support list

Stefan Binding (1):
      ALSA: hda/realtek: Add support for Ayaneo System using CS35L41 HDA

Stefano Garzarella (5):
      vsock/bpf: return early if transport is not assigned
      vsock/virtio: discard packets if the transport changes
      vsock/virtio: cancel close work in the destructor
      vsock: reset socket state when de-assigning the transport
      vsock: prevent null-ptr-deref in vsock_*[has_data|has_space]

Steven Rostedt (1):
      tracing: gfp: Fix the GFP enum values shown for user space tracing tools

Sudheer Kumar Doredla (1):
      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()

Suren Baghdasaryan (1):
      tools: fix atomic_set() definition to set the value correctly

Takashi Iwai (1):
      drm/nouveau/disp: Fix missing backlight control on Macbook 5,1

Tejun Heo (1):
      sched_ext: Fix dsq_local_on selftest

Tom Chung (2):
      drm/amd/display: Fix PSR-SU not support but still call the amdgpu_dm_psr_enable
      drm/amd/display: Disable replay and psr while VRR is enabled

Tomas Krcka (1):
      irqchip/gic-v3-its: Don't enable interrupts in its_irq_set_vcpu_affinity()

Tomi Valkeinen (1):
      i2c: atr: Fix client detach

Ville Syrjälä (1):
      drm/i915/fb: Relax clear color alignment to 64 bytes

Viresh Kumar (1):
      cpufreq: Move endif to the end of Kconfig file

Wayne Lin (1):
      drm/amd/display: Validate mdoe under MST LCT=1 case as well

Wolfram Sang (3):
      i2c: mux: demux-pinctrl: check initial mux selection, too
      i2c: rcar: fix NACK handling when being a target
      i2c: testunit: on errors, repeat NACK until STOP

Xiaolei Wang (1):
      pmdomain: imx8mp-blk-ctrl: add missing loop break condition

Xin Li (Intel) (1):
      x86/fred: Fix the FRED RSP0 MSR out of sync with its per-CPU cache

Yishai Hadas (1):
      net/mlx5: Fix a lockdep warning as part of the write combining test

Yogesh Lal (1):
      irqchip/gic-v3: Handle CPU_PM_ENTER_FAILED correctly

Yu-Chun Lin (1):
      drm/tests: helpers: Fix compiler warning

Zhang Kunbo (1):
      fs: fix missing declaration of init_files


