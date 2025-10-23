Return-Path: <stable+bounces-189134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B27AC01D3A
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 16:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9E175618CE
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDD131283D;
	Thu, 23 Oct 2025 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XLX2kkoY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979DB324B39;
	Thu, 23 Oct 2025 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230161; cv=none; b=BlpGtgI/n/mxBvo5JJ61o56Hzt6k4M1Lk+ex85S99vU0lrwE4V5NoqpPbd3eBe4oQfiOXEnPeqVu9Y5Uwvx8Qd+DlQgdo0xHdCO/JSf2fldHkkrv14uneePVnPI3lTjHmXeG87ID4Cd0L+KglSvejCh2xM+bmxdj9EStR1/VkMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230161; c=relaxed/simple;
	bh=pAjhLUm772Fa7VQiqqr81+4Z8nxI49UWRzcnuqJaihg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IMZs2RiCVJDATADw1U5OPhsglymUtvDX+lvowQimzF55MWupcqhqjTntDOBfcscnhvSdHtSSxeNbN3f1SHDNsA/ses0RGfiD4CswAFjkQBKWHfbyglJe9mPGFt5jouac4/VYaCVD4w2aJQxwCbwDwjRsZOvnPdfkRg84HKgLdoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XLX2kkoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEC6C4CEE7;
	Thu, 23 Oct 2025 14:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761230161;
	bh=pAjhLUm772Fa7VQiqqr81+4Z8nxI49UWRzcnuqJaihg=;
	h=From:To:Cc:Subject:Date:From;
	b=XLX2kkoYH5ILn9iJ4DtqdeFoVnZ28df/DE5d47lk9NL0y0UQHkDS4d0Vrhw1hH6la
	 iXhPp5aKnu+uqcwRJ6QGsn261SVuFVGOwjKzSmT35gKD96cnkCc9ol6emkn9P/LEVf
	 BgL3KUwsZT6vU8VY92xnzfg1qKQMwSkIblhoe6b4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.17.5
Date: Thu, 23 Oct 2025 16:35:52 +0200
Message-ID: <2025102353-shuffling-isolated-dee5@gregkh>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.17.5 kernel.

All users of the 6.17 kernel series must upgrade.

The updated 6.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.17.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/arm64/silicon-errata.rst                  |    2 
 Documentation/networking/seg6-sysctl.rst                     |    3 
 Documentation/sphinx/kernel_feat.py                          |    4 
 Documentation/sphinx/kernel_include.py                       |    6 
 Documentation/sphinx/maintainers_include.py                  |    4 
 Makefile                                                     |    2 
 arch/Kconfig                                                 |    1 
 arch/arm64/Kconfig                                           |    1 
 arch/arm64/include/asm/cputype.h                             |    2 
 arch/arm64/include/asm/sysreg.h                              |   11 
 arch/arm64/kernel/cpu_errata.c                               |    1 
 arch/arm64/kernel/entry-common.c                             |    8 
 arch/arm64/kvm/arm.c                                         |    6 
 arch/powerpc/kernel/fadump.c                                 |    3 
 arch/riscv/kernel/probes/kprobes.c                           |   13 
 arch/x86/kernel/cpu/amd.c                                    |   16 
 arch/x86/kernel/cpu/resctrl/monitor.c                        |   44 +
 arch/x86/mm/tlb.c                                            |   24 -
 block/blk-cgroup.c                                           |   13 
 block/blk-mq-sched.c                                         |    2 
 block/blk-mq-tag.c                                           |    5 
 block/blk-mq.c                                               |    2 
 block/blk-mq.h                                               |    3 
 drivers/accel/qaic/qaic.h                                    |    2 
 drivers/accel/qaic/qaic_control.c                            |    2 
 drivers/accel/qaic/qaic_data.c                               |   12 
 drivers/accel/qaic/qaic_debugfs.c                            |    5 
 drivers/accel/qaic/qaic_drv.c                                |    3 
 drivers/ata/libata-core.c                                    |   11 
 drivers/cxl/acpi.c                                           |    2 
 drivers/cxl/core/features.c                                  |    3 
 drivers/cxl/core/region.c                                    |    7 
 drivers/cxl/core/trace.h                                     |    2 
 drivers/dpll/zl3073x/core.c                                  |  228 ++++++----
 drivers/dpll/zl3073x/core.h                                  |    3 
 drivers/dpll/zl3073x/devlink.c                               |   18 
 drivers/dpll/zl3073x/regs.h                                  |    3 
 drivers/gpu/drm/amd/amdgpu/Makefile                          |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c             |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                |   48 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c                    |   54 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h                     |    2 
 drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c         |   56 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c                        |    7 
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c                        |    7 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                       |    7 
 drivers/gpu/drm/amd/amdgpu/nv.h                              |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c            |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h            |    7 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c          |    3 
 drivers/gpu/drm/bridge/lontium-lt9211.c                      |    3 
 drivers/gpu/drm/drm_draw.c                                   |    2 
 drivers/gpu/drm/drm_draw_internal.h                          |    2 
 drivers/gpu/drm/i915/display/intel_fb.c                      |   38 -
 drivers/gpu/drm/i915/display/intel_frontbuffer.c             |   10 
 drivers/gpu/drm/i915/gem/i915_gem_object_frontbuffer.h       |    2 
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c                    |    9 
 drivers/gpu/drm/panthor/panthor_fw.c                         |    1 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                 |    2 
 drivers/gpu/drm/scheduler/sched_main.c                       |   13 
 drivers/gpu/drm/xe/display/xe_fb_pin.c                       |    5 
 drivers/gpu/drm/xe/display/xe_plane_initial.c                |    3 
 drivers/gpu/drm/xe/regs/xe_gt_regs.h                         |    1 
 drivers/gpu/drm/xe/xe_assert.h                               |    4 
 drivers/gpu/drm/xe/xe_bo.c                                   |    1 
 drivers/gpu/drm/xe/xe_bo.h                                   |    4 
 drivers/gpu/drm/xe/xe_bo_evict.c                             |    8 
 drivers/gpu/drm/xe/xe_bo_types.h                             |    1 
 drivers/gpu/drm/xe/xe_device.c                               |   22 
 drivers/gpu/drm/xe/xe_device_types.h                         |   62 --
 drivers/gpu/drm/xe/xe_gt_idle.c                              |    8 
 drivers/gpu/drm/xe/xe_gt_pagefault.c                         |   13 
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c                   |    3 
 drivers/gpu/drm/xe/xe_guc_submit.c                           |   13 
 drivers/gpu/drm/xe/xe_migrate.c                              |   25 -
 drivers/gpu/drm/xe/xe_pci.c                                  |    8 
 drivers/gpu/drm/xe/xe_query.c                                |    5 
 drivers/gpu/drm/xe/xe_svm.c                                  |   63 +-
 drivers/gpu/drm/xe/xe_tile.c                                 |   58 +-
 drivers/gpu/drm/xe/xe_tile.h                                 |   14 
 drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c                       |   10 
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c                         |   22 
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.h                         |    3 
 drivers/gpu/drm/xe/xe_vm.c                                   |   32 +
 drivers/gpu/drm/xe/xe_vm_types.h                             |    2 
 drivers/gpu/drm/xe/xe_vram.c                                 |  243 +++++++----
 drivers/gpu/drm/xe/xe_vram.h                                 |   12 
 drivers/gpu/drm/xe/xe_vram_types.h                           |   85 +++
 drivers/hid/hid-input.c                                      |    5 
 drivers/hid/hid-multitouch.c                                 |   28 -
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c |    3 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c           |  226 ++++------
 drivers/net/can/m_can/m_can.c                                |   62 +-
 drivers/net/can/m_can/m_can_platform.c                       |    2 
 drivers/net/can/usb/gs_usb.c                                 |   23 -
 drivers/net/ethernet/airoha/airoha_eth.c                     |   16 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                     |    1 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                    |    1 
 drivers/net/ethernet/broadcom/tg3.c                          |    5 
 drivers/net/ethernet/dlink/dl2k.c                            |   23 -
 drivers/net/ethernet/google/gve/gve.h                        |    2 
 drivers/net/ethernet/google/gve/gve_desc_dqo.h               |    3 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                 |   18 
 drivers/net/ethernet/intel/idpf/idpf_ptp.c                   |    3 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c          |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                |    3 
 drivers/net/ethernet/intel/ixgbevf/defines.h                 |    1 
 drivers/net/ethernet/intel/ixgbevf/ipsec.c                   |   10 
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h                 |    7 
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c            |   34 +
 drivers/net/ethernet/intel/ixgbevf/mbx.h                     |    8 
 drivers/net/ethernet/intel/ixgbevf/vf.c                      |  182 ++++++--
 drivers/net/ethernet/intel/ixgbevf/vf.h                      |    1 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c              |    1 
 drivers/net/ethernet/mediatek/mtk_wed.c                      |    8 
 drivers/net/ethernet/realtek/r8169_main.c                    |    5 
 drivers/net/netdevsim/netdev.c                               |    7 
 drivers/net/phy/broadcom.c                                   |   20 
 drivers/net/phy/realtek/realtek_main.c                       |   23 -
 drivers/net/usb/lan78xx.c                                    |   19 
 drivers/net/usb/r8152.c                                      |    7 
 drivers/net/usb/usbnet.c                                     |    2 
 drivers/nvme/host/auth.c                                     |    6 
 drivers/nvme/host/multipath.c                                |    6 
 drivers/nvme/host/tcp.c                                      |    3 
 drivers/pci/controller/vmd.c                                 |   13 
 drivers/phy/cadence/cdns-dphy.c                              |  131 ++++-
 drivers/usb/gadget/function/f_acm.c                          |   42 -
 drivers/usb/gadget/function/f_ecm.c                          |   48 --
 drivers/usb/gadget/function/f_ncm.c                          |   78 +--
 drivers/usb/gadget/function/f_rndis.c                        |   85 +--
 drivers/usb/gadget/udc/core.c                                |    3 
 fs/btrfs/extent_io.c                                         |    2 
 fs/btrfs/free-space-tree.c                                   |   15 
 fs/btrfs/ioctl.c                                             |    2 
 fs/btrfs/relocation.c                                        |   13 
 fs/btrfs/super.c                                             |    3 
 fs/btrfs/zoned.c                                             |    2 
 fs/coredump.c                                                |    2 
 fs/dax.c                                                     |    2 
 fs/dcache.c                                                  |    2 
 fs/exec.c                                                    |    2 
 fs/ext4/ext4_jbd2.c                                          |   11 
 fs/ext4/inode.c                                              |    8 
 fs/f2fs/data.c                                               |    2 
 fs/file_attr.c                                               |   12 
 fs/fuse/ioctl.c                                              |    4 
 fs/hfsplus/unicode.c                                         |   24 +
 fs/jbd2/transaction.c                                        |   13 
 fs/nfsd/blocklayout.c                                        |   25 -
 fs/nfsd/blocklayoutxdr.c                                     |   86 ++-
 fs/nfsd/blocklayoutxdr.h                                     |    4 
 fs/nfsd/flexfilelayout.c                                     |    8 
 fs/nfsd/flexfilelayoutxdr.c                                  |    3 
 fs/nfsd/nfs4layouts.c                                        |    1 
 fs/nfsd/nfs4proc.c                                           |   36 -
 fs/nfsd/nfs4xdr.c                                            |   25 -
 fs/nfsd/pnfs.h                                               |    1 
 fs/nfsd/xdr4.h                                               |   39 +
 fs/overlayfs/copy_up.c                                       |    2 
 fs/overlayfs/inode.c                                         |    5 
 fs/smb/client/inode.c                                        |    6 
 fs/smb/client/misc.c                                         |   17 
 fs/smb/client/smb2ops.c                                      |    8 
 fs/smb/server/mgmt/user_session.c                            |    7 
 fs/smb/server/smb2pdu.c                                      |    9 
 fs/smb/server/transport_ipc.c                                |   12 
 fs/xfs/libxfs/xfs_log_format.h                               |   30 +
 fs/xfs/libxfs/xfs_ondisk.h                                   |    2 
 fs/xfs/xfs_log.c                                             |    8 
 fs/xfs/xfs_log_priv.h                                        |    4 
 fs/xfs/xfs_log_recover.c                                     |   34 +
 include/linux/brcmphy.h                                      |    1 
 include/linux/libata.h                                       |    6 
 include/linux/suspend.h                                      |    6 
 include/linux/usb/gadget.h                                   |   25 +
 include/net/ip_tunnels.h                                     |   15 
 include/uapi/drm/amdgpu_drm.h                                |   21 
 io_uring/register.c                                          |    1 
 io_uring/rw.c                                                |    2 
 kernel/events/core.c                                         |    8 
 kernel/power/hibernate.c                                     |   11 
 kernel/sched/core.c                                          |    2 
 kernel/sched/deadline.c                                      |    3 
 kernel/sched/fair.c                                          |   26 -
 mm/slub.c                                                    |    9 
 net/can/j1939/main.c                                         |    2 
 net/core/dev.c                                               |   40 +
 net/ipv4/ip_tunnel.c                                         |   14 
 net/ipv4/tcp_output.c                                        |   19 
 net/ipv6/ip6_tunnel.c                                        |    3 
 net/tls/tls_main.c                                           |    7 
 net/tls/tls_sw.c                                             |   31 +
 rust/kernel/cpufreq.rs                                       |    3 
 sound/firewire/amdtp-stream.h                                |    2 
 sound/hda/codecs/realtek/alc269.c                            |    1 
 sound/hda/codecs/side-codecs/cs35l41_hda.c                   |    2 
 sound/hda/codecs/side-codecs/hda_component.c                 |    4 
 sound/hda/controllers/intel.c                                |    1 
 sound/soc/amd/acp/acp-sdw-sof-mach.c                         |    2 
 sound/soc/codecs/idt821034.c                                 |   12 
 sound/soc/codecs/nau8821.c                                   |  111 +++--
 sound/usb/card.c                                             |   10 
 tools/testing/selftests/bpf/prog_tests/arg_parsing.c         |   12 
 tools/testing/selftests/net/rtnetlink.sh                     |    2 
 tools/testing/selftests/net/vlan_bridge_binding.sh           |    2 
 209 files changed, 2368 insertions(+), 1221 deletions(-)

Ada Couprie Diaz (1):
      arm64: debug: always unmask interrupts in el0_softstp()

Adrian Hunter (3):
      perf/core: Fix address filter match with backing files
      perf/core: Fix MMAP event path names with backing files
      perf/core: Fix MMAP2 event device with backing files

Alex Deucher (6):
      drm/amdgpu: add ip offset support for cyan skillfish
      drm/amdgpu: add support for cyan skillfish without IP discovery
      drm/amdgpu: fix handling of harvesting for ip_discovery firmware
      drm/amdgpu: handle wrap around in reemit handling
      drm/amdgpu: set an error on all fences from a bad context
      drm/amdgpu: drop unused structures in amdgpu_drm.h

Alexey Simakov (1):
      tg3: prevent use of uninitialized remote_adv and local_adv variables

Alison Schofield (1):
      cxl/trace: Subtract to find an hpa_alias0 in cxl_poison events

Alok Tiwari (1):
      drm/rockchip: vop2: use correct destination rectangle height check

Amit Chaudhary (1):
      nvme-multipath: Skip nr_active increments in RETRY disposition

Andrey Albershteyn (1):
      Revert "fs: make vfs_fileattr_[get|set] return -EOPNOTSUPP"

Andrii Nakryiko (1):
      selftests/bpf: make arg_parsing.c more robust to crashes

Babu Moger (2):
      x86/resctrl: Refactor resctrl_arch_rmid_read()
      x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID

Benjamin Tissoires (1):
      HID: multitouch: fix sticky fingers

Bhanu Seshu Kumar Valluri (1):
      net: usb: lan78xx: Fix lost EEPROM write timeout error(-ETIMEDOUT) in lan78xx_write_raw_eeprom

Boris Burkov (1):
      btrfs: fix incorrect readahead expansion length

Breno Leitao (1):
      netdevsim: set the carrier when the device goes up

Celeste Liu (2):
      can: gs_usb: gs_make_candev(): populate net_device->dev_port
      can: gs_usb: increase max interface to U8_MAX

Christian Brauner (1):
      coredump: fix core_pattern input validation

Christoph Hellwig (2):
      xfs: rename the old_crc variable in xlog_recover_process
      xfs: fix log CRC mismatches between i386 and other architectures

Christophe Leroy (1):
      ASoC: codecs: Fix gain setting ranges for Renesas IDT821034 codec

Chuck Lever (1):
      NFSD: Define a proc_layoutcommit for the FlexFiles layout type

Conor Dooley (1):
      rust: cfi: only 64-bit arm and x86 support CFI_CLANG

Cristian Ciocaltea (4):
      ASoC: nau8821: Cancel jdet_work before handling jack ejection
      ASoC: nau8821: Generalize helper to clear IRQ status
      ASoC: nau8821: Consistently clear interrupts before unmasking
      ASoC: nau8821: Add DMI quirk to bypass jack debounce circuit

Damien Le Moal (1):
      ata: libata-core: relax checks in ata_read_log_directory()

Dan Carpenter (1):
      drm/xe: Fix an IS_ERR() vs NULL bug in xe_tile_alloc_vram()

Dave Jiang (3):
      cxl/acpi: Fix setup of memory resource in cxl_acpi_set_cache_size()
      cxl/features: Add check for no entries in cxl_feature_info
      cxl: Fix match_region_by_range() to use region_res_match_cxl_range()

Deepanshu Kartikey (1):
      ext4: detect invalid INLINE_DATA + EXTENTS flag combination

Denis Arefev (2):
      ALSA: hda: cs35l41: Fix NULL pointer dereference in cs35l41_get_acpi_mute_state()
      ALSA: hda: Fix missing pointer check in hda_component_manager_init function

Devarsh Thakkar (2):
      phy: cadence: cdns-dphy: Fix PLL lock and O_CMN_READY polling
      phy: cadence: cdns-dphy: Update calibration wait time for startup state machine

Dmitry Safonov (1):
      net/ip6_tunnel: Prevent perpetual tunnel growth

Dmitry Torokhov (1):
      HID: hid-input: only ignore 0 battery events for digitizers

Eric Dumazet (1):
      tcp: fix tcp_tso_should_defer() vs large RTT

Eugene Korenevsky (1):
      cifs: parse_dfs_referrals: prevent oob on malformed input

Even Xu (1):
      HID: intel-thc-hid: Intel-quickspi: switch first interrupt from level to edge detection

Fabian Vogt (1):
      riscv: kprobes: Fix probe address validation

Filipe Manana (2):
      btrfs: fix clearing of BTRFS_FS_RELOC_RUNNING if relocation already running
      btrfs: do not assert we found block group item when creating free space tree

Florian Westphal (1):
      net: core: fix lockdep splat on device unregister

Francesco Valla (1):
      drm/draw: fix color truncation in drm_draw_fill24

Greg Kroah-Hartman (1):
      Linux 6.17.5

Gui-Dong Han (1):
      drm/amdgpu: use atomic functions with memory barriers for vm fault info

Guoniu Zhou (1):
      media: nxp: imx8-isi: m2m: Fix streaming cleanup on release

Hao Ge (1):
      slab: reset slab->obj_ext when freeing and it is OBJEXTS_ALLOC_FAIL

Harshit Mogalapalli (1):
      Octeontx2-af: Fix missing error code in cgx_probe()

I Viswanath (1):
      net: usb: lan78xx: fix use of improperly initialized dev->chipid in lan78xx_reset

Ingo Molnar (1):
      x86/mm: Fix SMP ordering in switch_mm_irqs_off()

Inochi Amaoto (1):
      PCI: vmd: Override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info()

Ivan Vecera (2):
      dpll: zl3073x: Refactor DPLL initialization
      dpll: zl3073x: Handle missing or corrupted flash configuration

Jaegeuk Kim (1):
      f2fs: fix wrong block mapping for multi-devices

Jan Kara (1):
      vfs: Don't leak disconnected dentries on umount

Jedrzej Jagielski (2):
      ixgbevf: fix getting link speed data for E610 devices
      ixgbevf: fix mailbox API compatibility by negotiating supported features

Jeff Hugo (1):
      accel/qaic: Fix bootlog initialization ordering

Jens Axboe (1):
      Revert "io_uring/rw: drop -EOPNOTSUPP check in __io_complete_rw_common()"

Jiaming Zhang (1):
      ALSA: usb-audio: Fix NULL pointer deference in try_to_register_card

Jonathan Corbet (1):
      docs: kdoc: handle the obsolescensce of docutils.ErrorString()

Jonathan Kim (1):
      drm/amdgpu: fix gfx12 mes packet status return check

Kamil Horák - 2N (1):
      net: phy: bcm54811: Fix GMII/MII/MII-Lite selection

Kenneth Graunke (1):
      drm/xe: Increase global invalidation timeout to 1000us

Ketil Johnsen (1):
      drm/panthor: Ensure MCU is disabled on suspend

Koichiro Den (1):
      ixgbe: fix too early devlink_free() in ixgbe_remove()

Kuen-Han Tsai (6):
      usb: gadget: Store endpoint pointer in usb_request
      usb: gadget: Introduce free_usb_request helper
      usb: gadget: f_rndis: Refactor bind path to use __free()
      usb: gadget: f_acm: Refactor bind path to use __free()
      usb: gadget: f_ecm: Refactor bind path to use __free()
      usb: gadget: f_ncm: Refactor bind path to use __free()

Li Qiang (1):
      ASoC: amd/sdw_utils: avoid NULL deref when devm_kasprintf() fails

Linmao Li (1):
      r8169: fix packet truncation after S4 resume on RTL8168H/RTL8111H

Lorenzo Bianconi (1):
      net: airoha: Take into account out-of-order tx completions in airoha_dev_xmit()

Lorenzo Pieralisi (1):
      arm64/sysreg: Fix GIC CDEOI instruction encoding

Lucas De Marchi (1):
      drm/xe: Move rebar to be done earlier

Marc Kleine-Budde (4):
      can: m_can: m_can_plat_remove(): add missing pm_runtime_disable()
      can: m_can: m_can_handle_state_errors(): fix CAN state transition to Error Active
      can: m_can: m_can_chip_config(): bring up interface in correct state
      can: m_can: fix CAN state in system PM

Marek Vasut (2):
      net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not present
      drm/bridge: lt9211: Drop check for last nibble of version register

Mario Limonciello (1):
      drm/amd: Check whether secure display TA loaded successfully

Mario Limonciello (AMD) (2):
      PM: hibernate: Add pm_hibernation_mode_is_suspend()
      drm/amd: Fix hybrid sleep

Marios Makassikis (1):
      ksmbd: fix recursive locking in RPC handle list access

Mark Rutland (2):
      arm64: cputype: Add Neoverse-V3AE definitions
      arm64: errata: Apply workarounds for Neoverse-V3AE

Martin George (1):
      nvme-auth: update sc_c in host response

Matthew Auld (1):
      drm/xe/evict: drop bogus assert

Matthew Brost (1):
      drm/xe: Don't allow evicting of BOs in same VM in array of VM binds

Matthew Schwartz (1):
      Revert "drm/amd/display: Only restore backlight after amdgpu_dm_init or dm_resume"

Miguel Ojeda (1):
      rust: cpufreq: fix formatting

Milena Olech (1):
      idpf: cleanup remaining SKBs in PTP flows

Ming Lei (1):
      block: Remove elevator_lock usage from blkg_conf frozen operations

Miquel Sabaté Solà (2):
      btrfs: fix memory leak on duplicated memory in the qgroup assign ioctl
      btrfs: fix memory leaks when rejecting a non SINGLE data profile without an RST

Nicolas Dichtel (1):
      doc: fix seg6_flowlabel path

Oliver Upton (1):
      KVM: arm64: Prevent access to vCPU events before init

Pavel Begunkov (1):
      io_uring: protect mem region deregistration

Peter Zijlstra (Intel) (1):
      sched/deadline: Stop dl_server before CPU goes offline

Piotr Piórkowski (4):
      drm/xe: Use devm_ioremap_wc for VRAM mapping and drop manual unmap
      drm/xe: Use dynamic allocation for tile and device VRAM region structures
      drm/xe: Move struct xe_vram_region to a dedicated header
      drm/xe: Unify the initialization of VRAM regions

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Synchronize access to DBC request queue head & tail pointer

Qu Wenruo (1):
      btrfs: only set the device specific options after devices are opened

Rafael J. Wysocki (1):
      PM: hibernate: Fix pm_hibernation_mode_is_suspend() build breakage

Raju Rangoju (1):
      amd-xgbe: Avoid spurious link down messages during interface toggle

Randy Dunlap (1):
      ALSA: firewire: amdtp-stream: fix enum kernel-doc warnings

Rex Lu (1):
      net: mtk: wed: add dma mask limitation and GFP_DMA32 for device with more than 4GB DRAM

Rong Zhang (1):
      x86/CPU/AMD: Prevent reset reasons from being retained across reboot

Sabrina Dubroca (5):
      tls: trim encrypted message to match the plaintext on short splice
      tls: wait for async encrypt in case of error during latter iterations of sendmsg
      tls: always set record_type in tls_process_cmsg
      tls: wait for pending async decryptions if tls_strp_msg_hold fails
      tls: don't rely on tx_work during send()

Sergey Bashirov (4):
      NFSD: Rework encoding and decoding of nfsd4_deviceid
      NFSD: Minor cleanup in layoutcommit processing
      NFSD: Implement large extent array support in pNFS
      NFSD: Fix last write offset handling in layoutcommit

Shuhao Fu (1):
      smb: client: Fix refcount leak for cifs_sb_tlink

Shuicheng Lin (1):
      drm/xe/guc: Check GuC running state before deregistering exec queue

Sourabh Jain (1):
      powerpc/fadump: skip parameter area allocation when fadump is disabled

Stuart Hayhurst (1):
      ALSA: hda/intel: Add MSI X870E Tomahawk to denylist

Takashi Iwai (1):
      ALSA: hda/realtek: Add quirk entry for HP ZBook 17 G6

Tetsuo Handa (1):
      can: j1939: add missing calls in NETDEV_UNREGISTER notification handler

Thadeu Lima de Souza Cascardo (1):
      HID: multitouch: fix name of Stylus input devices

Tim Hostetler (1):
      gve: Check valid ts bit on RX descriptor before hw timestamping

Timur Kristóf (1):
      drm/amd/powerplay: Fix CIK shutdown temperature

Tomi Valkeinen (1):
      phy: cdns-dphy: Store hs_clk_rate and return it

Tvrtko Ursulin (1):
      drm/sched: Fix potential double free in drm_sched_job_add_resv_dependencies

Viacheslav Dubeyko (1):
      hfsplus: fix slab-out-of-bounds read in hfsplus_strcasecmp()

Ville Syrjälä (2):
      drm/i915/frontbuffer: Move bo refcounting intel_frontbuffer_{get,release}()
      drm/i915/fb: Fix the set_tiling vs. addfb race, again

Vinay Belgaumkar (1):
      drm/xe: Enable media sampler power gating

Vincent Guittot (1):
      sched/fair: Fix pelt lost idle time detection

Wang Liang (1):
      selftests: net: check jq command is supported

Wilfred Mallawa (1):
      nvme/tcp: handle tls partially sent records in write_space()

Xing Guo (1):
      selftests: arg_parsing: Ensure data is flushed to disk before reading.

Yeounsu Moon (1):
      net: dlink: handle dma_map_single() failure properly

Yi Cong (1):
      r8152: add error handling in rtl8152_driver_init

Youssef Samir (1):
      accel/qaic: Treat remaining == 0 as error in find_and_map_user_pages()

Yu Kuai (1):
      blk-mq: fix stale tag depth for shared sched tags in blk_mq_update_nr_requests()

Yuezhang Mo (1):
      dax: skip read lock assertion for read-only filesystems

Zhang Yi (2):
      jbd2: ensure that all ongoing I/O complete before freeing blocks
      ext4: wait for ongoing I/O to complete before freeing blocks

Zhanjun Dong (1):
      drm/i915/guc: Skip communication warning on reset in progress

Zqiang (1):
      usbnet: Fix using smp_processor_id() in preemptible code warnings


