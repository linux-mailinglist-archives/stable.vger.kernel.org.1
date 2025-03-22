Return-Path: <stable+bounces-125816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA917A6CC0E
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 21:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5CB17E497
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 20:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2D1235377;
	Sat, 22 Mar 2025 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z9Wccr4N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075FA235360;
	Sat, 22 Mar 2025 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742673683; cv=none; b=sxI7MuMiSlC4xHe3ITAphiEN7V91r4NIkUG5/qdTw98di46yADRiJ1bgxySe1bjQLmrGdFdTPBbRAyryEe9Lbtobe18VluM7cVJGJTbeQiQJDp3QfCz7y2LCaN/Hv8pxZu8pm05kvuRRtcaVQpUqj7oPOlD5BrpEghetOpEcgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742673683; c=relaxed/simple;
	bh=Q8I/reuw4dN5v5PJ5//zR8H7PzNVqBRFEFO3tiJIATs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n92bq6PygunKumx1vxhsQUVxGu91qTdfa87Mg3dSVn4qdVNEFS588P70a5uUcCS9oiufNzH/nJ4Fuv3elwVko83QyJAghOPTlysZ2Fs/ypIO8JbLXc6DM1x556HZpVtcHda1fKnCAaiPpLE3m3F+59TMCd85QSQLKZ9dMy0go90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z9Wccr4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B270C4CEDD;
	Sat, 22 Mar 2025 20:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742673682;
	bh=Q8I/reuw4dN5v5PJ5//zR8H7PzNVqBRFEFO3tiJIATs=;
	h=From:To:Cc:Subject:Date:From;
	b=Z9Wccr4NJtc75KN333g93y5rptnSFbK7CArFtE7PRDEcSsrywdNx+ZtXBCCNOgyF6
	 kE0rpkR+6b7mGVmHWz6EYKUbypYGvMsMhAB0KBfVhbhg30Gq4tPYRKMTS9XK6EcD4v
	 F9fauzL4uRCXAMo/rnnl1NgKG1DnGMi/DC0YANvc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.20
Date: Sat, 22 Mar 2025 12:59:56 -0700
Message-ID: <2025032257-popsicle-surprise-1fc5@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.20 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/rust/quick-start.rst                                   |    2 
 Makefile                                                             |    2 
 arch/alpha/include/asm/elf.h                                         |    6 
 arch/alpha/include/asm/pgtable.h                                     |    2 
 arch/alpha/include/asm/processor.h                                   |    8 
 arch/alpha/kernel/osf_sys.c                                          |   11 
 arch/arm64/include/asm/tlbflush.h                                    |   22 
 arch/arm64/kernel/topology.c                                         |   22 
 arch/arm64/mm/mmu.c                                                  |    5 
 arch/loongarch/kvm/switch.S                                          |    2 
 arch/loongarch/mm/pageattr.c                                         |    3 
 arch/x86/events/intel/core.c                                         |   85 ++
 arch/x86/events/rapl.c                                               |    1 
 arch/x86/kernel/cpu/microcode/amd.c                                  |    2 
 arch/x86/kernel/cpu/vmware.c                                         |    4 
 arch/x86/kernel/devicetree.c                                         |    3 
 arch/x86/kernel/irq.c                                                |    2 
 arch/x86/kvm/mmu/mmu.c                                               |    2 
 block/bio.c                                                          |    2 
 drivers/acpi/resource.c                                              |    6 
 drivers/block/null_blk/main.c                                        |    4 
 drivers/block/virtio_blk.c                                           |    5 
 drivers/clk/samsung/clk-gs101.c                                      |    8 
 drivers/clk/samsung/clk-pll.c                                        |    7 
 drivers/firmware/iscsi_ibft.c                                        |    5 
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c                               |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                    |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c               |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c                |   64 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c              |    7 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                    |    7 
 drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c        |    1 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c |    4 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c        |    6 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                        |   40 -
 drivers/gpu/drm/drm_atomic_uapi.c                                    |    4 
 drivers/gpu/drm/drm_connector.c                                      |    4 
 drivers/gpu/drm/drm_panic_qr.rs                                      |   16 
 drivers/gpu/drm/gma500/mid_bios.c                                    |    5 
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c                              |    2 
 drivers/gpu/drm/i915/display/intel_display.c                         |    5 
 drivers/gpu/drm/i915/gem/i915_gem_mman.c                             |    5 
 drivers/gpu/drm/nouveau/nouveau_connector.c                          |    1 
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c                   |  193 +++---
 drivers/gpu/drm/vkms/vkms_composer.c                                 |    2 
 drivers/gpu/drm/xe/xe_guc_submit.c                                   |    4 
 drivers/gpu/drm/xe/xe_hmm.c                                          |    6 
 drivers/gpu/drm/xe/xe_pm.c                                           |   13 
 drivers/hid/Kconfig                                                  |    3 
 drivers/hid/hid-apple.c                                              |   13 
 drivers/hid/hid-ids.h                                                |    3 
 drivers/hid/hid-quirks.c                                             |    1 
 drivers/hid/hid-steam.c                                              |    6 
 drivers/hid/hid-topre.c                                              |    7 
 drivers/hid/intel-ish-hid/ipc/hw-ish.h                               |    2 
 drivers/hid/intel-ish-hid/ipc/ipc.c                                  |   15 
 drivers/hid/intel-ish-hid/ipc/pci-ish.c                              |    7 
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h                          |    2 
 drivers/hv/vmbus_drv.c                                               |   13 
 drivers/i2c/busses/i2c-ali1535.c                                     |   12 
 drivers/i2c/busses/i2c-ali15x3.c                                     |   12 
 drivers/i2c/busses/i2c-sis630.c                                      |   12 
 drivers/input/joystick/xpad.c                                        |   39 +
 drivers/input/misc/iqs7222.c                                         |   50 -
 drivers/input/serio/i8042-acpipnpio.h                                |  111 +--
 drivers/input/touchscreen/ads7846.c                                  |    2 
 drivers/input/touchscreen/goodix_berlin_core.c                       |   24 
 drivers/md/dm-flakey.c                                               |    2 
 drivers/net/bonding/bond_options.c                                   |   55 +
 drivers/net/dsa/mv88e6xxx/chip.c                                     |   59 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                            |  286 ++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                            |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                        |   13 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h                        |    3 
 drivers/net/ethernet/intel/ice/ice_arfs.c                            |    2 
 drivers/net/ethernet/intel/ice/ice_eswitch.c                         |    6 
 drivers/net/ethernet/intel/ice/ice_lag.c                             |   27 
 drivers/net/ethernet/intel/ice/ice_lib.c                             |   18 
 drivers/net/ethernet/intel/ice/ice_lib.h                             |    4 
 drivers/net/ethernet/intel/ice/ice_txrx.c                            |    4 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c                    |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c              |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                    |    6 
 drivers/net/ethernet/mellanox/mlx5/core/eq.c                         |    2 
 drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c               |    2 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                    |    4 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h                    |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c                  |    3 
 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c              |    5 
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h                   |    4 
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c                    |   13 
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h                    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.h   |    2 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c             |    8 
 drivers/net/ethernet/realtek/rtase/rtase_main.c                      |   10 
 drivers/net/mctp/mctp-i2c.c                                          |    5 
 drivers/net/mctp/mctp-i3c.c                                          |    5 
 drivers/net/phy/nxp-c45-tja11xx.c                                    |   68 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                          |    6 
 drivers/net/wwan/mhi_wwan_mbim.c                                     |    2 
 drivers/nvme/host/apple.c                                            |    5 
 drivers/nvme/host/core.c                                             |   14 
 drivers/nvme/host/fc.c                                               |   59 --
 drivers/nvme/host/pci.c                                              |    7 
 drivers/nvme/target/rdma.c                                           |   33 -
 drivers/phy/ti/phy-gmii-sel.c                                        |   15 
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c                               |    2 
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c                            |    3 
 drivers/platform/x86/intel/int3472/discrete.c                        |   85 ++
 drivers/platform/x86/intel/pmc/core.c                                |    4 
 drivers/platform/x86/thinkpad_acpi.c                                 |   50 +
 drivers/powercap/powercap_sys.c                                      |    3 
 drivers/s390/cio/chp.c                                               |    3 
 drivers/scsi/qla1280.c                                               |    2 
 drivers/scsi/scsi_scan.c                                             |    2 
 drivers/spi/spi-microchip-core.c                                     |   41 -
 drivers/thermal/cpufreq_cooling.c                                    |    2 
 drivers/ufs/core/ufshcd.c                                            |    7 
 drivers/usb/phy/phy-generic.c                                        |    2 
 drivers/usb/serial/ftdi_sio.c                                        |   14 
 drivers/usb/serial/ftdi_sio_ids.h                                    |   13 
 drivers/usb/serial/option.c                                          |   48 +
 drivers/vhost/vhost.c                                                |    2 
 drivers/video/fbdev/hyperv_fb.c                                      |   52 +
 drivers/xen/swiotlb-xen.c                                            |    2 
 fs/btrfs/extent_io.c                                                 |   11 
 fs/btrfs/qgroup.c                                                    |    6 
 fs/fuse/dir.c                                                        |    2 
 fs/namei.c                                                           |   24 
 fs/netfs/read_collect.c                                              |    2 
 fs/smb/client/asn1.c                                                 |    2 
 fs/smb/client/cifs_spnego.c                                          |    4 
 fs/smb/client/cifsglob.h                                             |    4 
 fs/smb/client/connect.c                                              |   16 
 fs/smb/client/fs_context.c                                           |   18 
 fs/smb/client/inode.c                                                |   13 
 fs/smb/client/reparse.c                                              |   10 
 fs/smb/client/sess.c                                                 |    3 
 fs/smb/client/smb2pdu.c                                              |    4 
 fs/smb/common/smbfsctl.h                                             |    3 
 fs/smb/server/connection.c                                           |   20 
 fs/smb/server/connection.h                                           |    2 
 fs/smb/server/ksmbd_work.c                                           |    3 
 fs/smb/server/ksmbd_work.h                                           |    1 
 fs/smb/server/oplock.c                                               |   43 -
 fs/smb/server/oplock.h                                               |    1 
 fs/smb/server/server.c                                               |   14 
 fs/vboxsf/super.c                                                    |    3 
 include/linux/blk-mq.h                                               |   16 
 include/linux/fs.h                                                   |    2 
 include/linux/hugetlb.h                                              |    5 
 include/linux/pci_ids.h                                              |    1 
 include/net/bluetooth/hci_core.h                                     |  108 +--
 include/net/bluetooth/l2cap.h                                        |    3 
 include/net/netfilter/nf_tables.h                                    |    4 
 include/sound/soc.h                                                  |    5 
 init/Kconfig                                                         |    2 
 io_uring/futex.c                                                     |    2 
 io_uring/io-wq.c                                                     |   23 
 kernel/futex/core.c                                                  |    5 
 kernel/futex/futex.h                                                 |   11 
 kernel/futex/pi.c                                                    |    2 
 kernel/futex/waitwake.c                                              |    4 
 kernel/rcu/tree.c                                                    |   14 
 kernel/sched/core.c                                                  |    5 
 kernel/sched/debug.c                                                 |    2 
 kernel/sched/ext.c                                                   |    3 
 kernel/time/hrtimer.c                                                |   22 
 kernel/vhost_task.c                                                  |    4 
 mm/hugetlb.c                                                         |    8 
 mm/page_isolation.c                                                  |   10 
 mm/userfaultfd.c                                                     |   91 ++-
 net/bluetooth/hci_core.c                                             |   10 
 net/bluetooth/hci_event.c                                            |   37 -
 net/bluetooth/iso.c                                                  |    6 
 net/bluetooth/l2cap_core.c                                           |  181 ++----
 net/bluetooth/l2cap_sock.c                                           |   15 
 net/bluetooth/rfcomm/core.c                                          |    6 
 net/bluetooth/sco.c                                                  |   12 
 net/core/dev.c                                                       |    5 
 net/core/netpoll.c                                                   |    9 
 net/ipv6/addrconf.c                                                  |   15 
 net/mac80211/util.c                                                  |    8 
 net/mctp/route.c                                                     |   10 
 net/mctp/test/route-test.c                                           |  109 +++
 net/mptcp/protocol.h                                                 |    2 
 net/netfilter/ipvs/ip_vs_ctl.c                                       |    8 
 net/netfilter/nf_conncount.c                                         |    6 
 net/netfilter/nf_tables_api.c                                        |   24 
 net/netfilter/nft_compat.c                                           |    8 
 net/netfilter/nft_ct.c                                               |    6 
 net/netfilter/nft_exthdr.c                                           |   10 
 net/openvswitch/conntrack.c                                          |   30 -
 net/openvswitch/datapath.h                                           |    3 
 net/openvswitch/flow_netlink.c                                       |   15 
 net/sched/sch_api.c                                                  |    6 
 net/sched/sch_gred.c                                                 |    3 
 net/sctp/stream.c                                                    |    2 
 net/switchdev/switchdev.c                                            |   25 
 net/wireless/core.c                                                  |    7 
 rust/kernel/alloc/allocator_test.rs                                  |   18 
 rust/kernel/error.rs                                                 |    2 
 rust/kernel/init.rs                                                  |   23 
 rust/kernel/init/macros.rs                                           |    6 
 rust/kernel/lib.rs                                                   |    2 
 rust/kernel/sync.rs                                                  |   16 
 scripts/generate_rust_analyzer.py                                    |   73 +-
 scripts/rustdoc_test_gen.rs                                          |    4 
 sound/hda/intel-dsp-config.c                                         |    5 
 sound/pci/hda/hda_intel.c                                            |    2 
 sound/pci/hda/patch_realtek.c                                        |    1 
 sound/soc/amd/yc/acp6x-mach.c                                        |    7 
 sound/soc/codecs/arizona.c                                           |   14 
 sound/soc/codecs/cs42l43.c                                           |    2 
 sound/soc/codecs/madera.c                                            |   10 
 sound/soc/codecs/rt722-sdca-sdw.c                                    |    4 
 sound/soc/codecs/tas2764.c                                           |   10 
 sound/soc/codecs/tas2764.h                                           |    8 
 sound/soc/codecs/tas2770.c                                           |    2 
 sound/soc/codecs/wm0010.c                                            |   13 
 sound/soc/codecs/wm5110.c                                            |    8 
 sound/soc/generic/simple-card-utils.c                                |    1 
 sound/soc/intel/boards/sof_sdw.c                                     |   33 -
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c                    |    2 
 sound/soc/sh/rcar/core.c                                             |   14 
 sound/soc/sh/rcar/rsnd.h                                             |    1 
 sound/soc/sh/rcar/src.c                                              |  116 +++-
 sound/soc/sh/rcar/ssi.c                                              |    3 
 sound/soc/soc-ops.c                                                  |   15 
 sound/soc/sof/amd/acp-ipc.c                                          |   23 
 sound/soc/sof/amd/acp.c                                              |    1 
 sound/soc/sof/amd/acp.h                                              |    1 
 sound/soc/sof/amd/vangogh.c                                          |   18 
 sound/soc/sof/intel/hda-codec.c                                      |    1 
 sound/soc/sof/intel/hda.c                                            |   18 
 sound/soc/sof/intel/pci-ptl.c                                        |    1 
 tools/objtool/check.c                                                |    9 
 tools/sched_ext/include/scx/common.bpf.h                             |   11 
 tools/sound/dapm-graph                                               |    2 
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c               |    6 
 tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh                  |    2 
 tools/testing/selftests/drivers/net/bonding/bond_options.sh          |    4 
 tools/testing/selftests/filesystems/statmount/statmount_test.c       |   22 
 tools/testing/selftests/sched_ext/dsp_local_on.bpf.c                 |    2 
 245 files changed, 2447 insertions(+), 1311 deletions(-)

Aaron Ma (1):
      perf/x86/rapl: Add support for Intel Arrow Lake U

Ajay Kaher (1):
      x86/vmware: Parse MP tables for SEV-SNP enabled guests under VMware hypervisors

Alban Kurti (2):
      rust: error: add missing newline to pr_warn! calls
      rust: init: add missing newline to pr_info! calls

Alex Henrie (2):
      HID: apple: fix up the F6 key on the Omoton KB066 keyboard
      HID: apple: disable Fn key handling on the Omoton KB066

Alex Hung (2):
      drm/amd/display: Fix out-of-bound accesses
      drm/amd/display: Assign normalized_pix_clk when color depth = 14

Alexander Stein (1):
      usb: phy: generic: Use proper helper for property detection

Alexey Kashavkin (1):
      netfilter: nft_exthdr: fix offset with ipv4_find_option()

Aliaksei Urbanski (1):
      drm/amd/display: fix missing .is_two_pixels_per_container

Amit Cohen (1):
      net: switchdev: Convert blocking notification chain to a raw one

Andrea Righi (3):
      sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()
      sched_ext: selftests/dsp_local_on: Fix selftest on UP systems
      tools/sched_ext: Add helper to check task migration state

Andrei Botila (2):
      net: phy: nxp-c45-tja11xx: add TJA112X PHY configuration errata
      net: phy: nxp-c45-tja11xx: add TJA112XB SGMII PCS restart errata

Andrew Davis (1):
      phy: ti: gmii-sel: Do not use syscon helper to build regmap

Andy Shevchenko (1):
      hrtimers: Mark is_migration_base() with __always_inline

Antheas Kapenekakis (3):
      Input: xpad - add support for ZOTAC Gaming Zone
      Input: xpad - add support for TECNO Pocket Go
      Input: xpad - rename QH controller to Legion Go S

Arnd Bergmann (1):
      x86/irq: Define trace events conditionally

Artur Weber (1):
      pinctrl: bcm281xx: Fix incorrect regmap max_registers value

Bard Liao (3):
      ASoC: Intel: soc-acpi-intel-mtl-match: declare adr as ull
      ASoC: SOF: Intel: don't check number of sdw links when set dmic_fixup
      ASoC: rt722-sdca: add missing readable registers

Barry Song (1):
      mm: fix kernel BUG when userfaultfd_move encounters swapcache

Beata Michalska (1):
      arm64: amu: Delay allocating cpumask for AMU FIE support

Benno Lossin (1):
      rust: init: fix `Zeroable` implementation for `Option<NonNull<T>>` and `Option<KBox<T>>`

Bharadwaj Raju (1):
      selftests/cgroup: use bash in test_cpuset_v1_hp.sh

Bibo Mao (1):
      LoongArch: KVM: Set host with kernel mode when switch to VM mode

Boon Khai Ng (1):
      USB: serial: ftdi_sio: add support for Altera USB Blaster 3

Brahmajit Das (1):
      vboxsf: fix building with GCC 15

Breno Leitao (1):
      netpoll: hold rcu read lock in __netpoll_send_skb()

Carolina Jubran (1):
      net/mlx5e: Prevent bridge link show failure for non-eswitch-allowed devices

Charles Han (1):
      pinctrl: nuvoton: npcm8xx: Add NULL check in npcm8xx_gpio_fw

Charles Keepax (2):
      ASoC: ops: Consistently treat platform_max as control value
      ASoC: cs42l43: Fix maximum ADC Volume

Chengen Du (1):
      iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in ibft_attr_show_nic()

Chia-Lin Kao (AceLan) (1):
      HID: ignore non-functional sensor in HP 5MP Camera

Christian Loehle (1):
      sched/debug: Provide slice length for fair tasks

Christophe JAILLET (4):
      ASoC: codecs: wm0010: Fix error handling path in wm0010_spi_probe()
      i2c: ali1535: Fix an error handling path in ali1535_probe()
      i2c: ali15x3: Fix an error handling path in ali15x3_probe()
      i2c: sis630: Fix an error handling path in sis630_probe()

Christopher Lentocha (1):
      nvme-pci: quirk Acer FA100 for non-uniqueue identifiers

Cong Wang (1):
      net_sched: Prevent creation of classes with TC_H_ROOT

Conor Dooley (1):
      spi: microchip-core: prevent RX overflows when transmit size > FIFO size

Cristian Ciocaltea (2):
      ASoC: SOF: amd: Add post_fw_run_delay ACP quirk
      ASoC: SOF: amd: Handle IPC replies before FW_BOOT_COMPLETE

Dan Carpenter (1):
      ipvs: prevent integer overflow in do_ip_vs_get_ctl()

Daniel Brackenbury (1):
      HID: topre: Fix n-key rollover on Realforce R3S TKL boards

Daniel Lezcano (1):
      thermal/cpufreq_cooling: Remove structure member documentation

Daniel Wagner (4):
      nvme-fc: go straight to connecting state when initializing
      nvme-fc: do not ignore connectivity loss during connecting
      nvme: only allow entering LIVE from CONNECTING state
      nvme-fc: rely on state transitions to handle connectivity loss

David Rosca (1):
      drm/amdgpu/display: Allow DCC for video formats on GFX12

David Wei (2):
      bnxt_en: refactor tpa_info alloc/free into helpers
      bnxt_en: handle tpa_info in queue API implementation

Dmitry Kandybka (1):
      platform/x86/intel: pmc: fix ltr decode in pmc_core_ltr_show()

Dmytro Maluka (1):
      x86/of: Don't use DTB for SMP setup if ACPI is enabled

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on Positivo ARN50

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: fix PNVM timeout for non-MSI-X platforms

Eric W. Biederman (1):
      alpha/elf: Fix misc/setarch test of util-linux by removing 32bit support

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FE990B compositions
      USB: serial: option: fix Telit Cinterion FE990A name

Filipe Manana (1):
      btrfs: avoid starting new transaction when cleaning qgroup during subvolume drop

Florent Revest (1):
      x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA nodes

Florian Westphal (1):
      netfilter: nf_tables: make destruction work queue pernet

Frederic Weisbecker (1):
      net: Handle napi_schedule() calls from non-interrupt

Gannon Kolding (1):
      ACPI: resource: IRQ override for Eluktronics MECH-17

Ge Yang (1):
      mm/hugetlb: wait for hugetlb folios to be freed

Greg Kroah-Hartman (1):
      Linux 6.12.20

Grzegorz Nitka (1):
      ice: fix memory leak in aRFS after reset

Guillaume Nault (1):
      gre: Fix IPv6 link-local address generation.

H. Nikolaus Schaller (1):
      Input: ads7846 - fix gpiod allocation

Hangbin Liu (2):
      bonding: fix incorrect MAC address setting to receive NS messages
      selftests: bonding: fix incorrect mac address

Haoxiang Li (1):
      qlcnic: fix memory leak issues in qlcnic_sriov_common.c

Harry Wentland (1):
      drm/vkms: Round fixp2int conversion in lerp_u16

Hector Martin (4):
      apple-nvme: Release power domains when probe fails
      ASoC: tas2770: Fix volume scale
      ASoC: tas2764: Fix power control mask
      ASoC: tas2764: Set the SDOUT polarity correctly

Henrique Carvalho (1):
      smb: client: Fix match_session bug preventing session reuse

Huacai Chen (1):
      LoongArch: Fix kernel_page_present() for KPRANGE/XKPRANGE

Ievgen Vovk (1):
      HID: hid-apple: Apple Magic Keyboard a3203 USB-C support

Ilya Maximets (1):
      net: openvswitch: remove misbehaving actions length check

Imre Deak (1):
      drm/dp_mst: Fix locking when skipping CSN before topology probing

Ivan Abramov (1):
      drm/gma500: Add NULL check for pci_gfx_root in mid_get_vbt_data()

Jakub Kicinski (1):
      eth: bnxt: use page pool for head frags

Jan Beulich (1):
      Xen/swiotlb: mark xen_swiotlb_fixup() __init

Jann Horn (1):
      sched: Clarify wake_up_q()'s write to task->wake_q.next

Jeff LaBundy (1):
      Input: iqs7222 - preserve system status register

Jens Axboe (1):
      futex: Pass in task to futex_queue()

Jianbo Liu (1):
      net/mlx5: Bridge, fix the crash caused by LAG state check

Jiayuan Chen (1):
      selftests/bpf: Fix invalid flag of recv()

Jiri Pirko (1):
      net/mlx5: Fill out devlink dev info only for PFs

Joe Hattori (1):
      powercap: call put_device() on an error path in powercap_register_control_type()

Johan Hovold (1):
      USB: serial: option: match on interface class for Telit FN990B

Joseph Huang (1):
      net: dsa: mv88e6xxx: Verify after ATU Load ops

Josh Poimboeuf (1):
      objtool: Ignore dangling jump table entries

José Roberto de Souza (1):
      drm/i915: Increase I915_PARAM_MMAP_GTT_VERSION version to indicate support for partial mmaps

Jun Yang (1):
      sched: address a potential NULL pointer dereference in the GRED scheduler.

Justin Lai (1):
      rtase: Fix improper release of ring list entries in rtase_sw_reset

Kan Liang (1):
      perf/x86/intel: Use better start period for frequency mode

Keith Busch (1):
      vhost: return task creation error instead of NULL

Kent Overstreet (1):
      dm-flakey: Fix memory corruption in optional corrupt_bio_byte feature

Kohei Enju (1):
      netfilter: nf_conncount: Fully initialize struct nf_conncount_tuple in insert_tree()

Kuninori Morimoto (4):
      ASoC: simple-card-utils.c: add missing dlc->of_node
      ASoC: rsnd: indicate unsupported clock rate
      ASoC: rsnd: don't indicate warning on rsnd_kctrl_accept_runtime()
      ASoC: rsnd: adjust convert rate limitation

Larysa Zaremba (1):
      ice: do not configure destination override for switchdev

Leo Li (1):
      drm/amd/display: Disable unneeded hpd interrupts during dm_init

Luca Weiss (1):
      Input: goodix-berlin - fix vddio regulator references

Luiz Augusto von Dentz (4):
      Bluetooth: hci_event: Fix enabling passive scanning
      Revert "Bluetooth: hci_core: Fix sleeping function called from invalid context"
      Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
      Bluetooth: L2CAP: Fix corrupted list in hci_chan_del

Magnus Lindholm (1):
      scsi: qla1280: Fix kernel oops when debug level > 2

Marcin Szycik (1):
      ice: Fix switchdev slow-path in LAG

Mario Limonciello (3):
      drm/amd/display: fix default brightness
      drm/amd/display: Restore correct backlight brightness after a GPU reset
      drm/amd/display: Fix slab-use-after-free on hdcp_work

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Support for V9 DYTC platform profiles

Matt Johnston (3):
      net: mctp i3c: Copy headers if cloned
      net: mctp i2c: Copy headers if cloned
      net: mctp: unshare packets when reassembling

Matthew Maurer (1):
      rust: Disallow BTF generation with Rust + LTO

Matthew Wilcox (Oracle) (1):
      btrfs: fix two misuses of folio_shift()

Matthieu Baerts (NGI0) (1):
      mptcp: safety check before fallback

Max Kellermann (1):
      fs/netfs/read_collect: add to next->prev_donated

Maxime Ripard (3):
      drm/tests: hdmi: Remove redundant assignments
      drm/tests: hdmi: Reorder DRM entities variables assignment
      drm/tests: hdmi: Fix recursive locking

Michael Kelley (4):
      fbdev: hyperv_fb: iounmap() the correct memory when removing a device
      drm/hyperv: Fix address space leak when Hyper-V DRM device is removed
      fbdev: hyperv_fb: Fix hang in kdump kernel when on Hyper-V Gen 2 VMs
      Drivers: hv: vmbus: Don't release fb_mmio resource in vmbus_free_mmio()

Miguel Ojeda (3):
      rust: remove leftover mentions of the `alloc` crate
      drm/panic: use `div_ceil` to clean Clippy warning
      drm/panic: fix overindented list items in documentation

Miklos Szeredi (2):
      selftests: always check mask returned by statmount(2)
      fuse: don't truncate cached, mutated symlink

Mina Almasry (1):
      netmem: prevent TX of unreadable skbs

Ming Lei (1):
      block: fix 'kmem_cache of name 'bio-108' already exists'

Miri Korenblit (2):
      wifi: mac80211: don't queue sdata::work for a non-running sdata
      wifi: cfg80211: cancel wiphy_work before freeing wiphy

Mitchell Levy (1):
      rust: lockdep: Remove support for dynamically allocated LockClassKeys

Murad Masimov (4):
      cifs: Fix integer overflow while processing acregmax mount option
      cifs: Fix integer overflow while processing acdirmax mount option
      cifs: Fix integer overflow while processing actimeo mount option
      cifs: Fix integer overflow while processing closetimeo mount option

Namjae Jeon (2):
      ksmbd: fix use-after-free in ksmbd_free_work_struct
      ksmbd: prevent connection release during oplock break notification

Natalie Vock (1):
      drm/amdgpu: NULL-check BO's backing store when determining GFX12 PTE flags

Nicklas Bo Jensen (1):
      netfilter: nf_conncount: garbage collection is not skipped when jiffies wrap around

Nicolas Frattaroli (1):
      ASoC: dapm-graph: set fill colour of turned on nodes

Nilton Perim Neto (1):
      Input: xpad - add 8BitDo SN30 Pro, Hyperkin X91 and Gamesir G7 SE controllers

Pali Rohár (3):
      cifs: Treat unhandled directory name surrogate reparse points as mount directory nodes
      cifs: Validate content of WSL reparse point buffers
      cifs: Throw -EOPNOTSUPP error on unsupported reparse point type from parse_reparse_point()

Paulo Alcantara (2):
      smb: client: fix noisy when tree connecting to DFS interlink targets
      smb: client: fix regression with guest option

Pavel Rojtberg (1):
      Input: xpad - add multiple supported devices

Peter Griffin (1):
      clk: samsung: gs101: fix synchronous external abort in samsung_clk_save()

Peter Oberparleiter (1):
      s390/cio: Fix CHPID "configure" attribute caching

Peter Ujfalusi (2):
      ASoC: SOF: Intel: pci-ptl: Add support for PTL-H
      ASoC: Intel: sof_sdw: Fix unlikely uninitialized variable use in create_sdw_dailinks()

Pierre-Louis Bossart (3):
      PCI: pci_ids: add INTEL_HDA_PTL_H
      ALSA: hda: intel-dsp-config: Add PTL-H support
      ALSA: hda: hda-intel: add Panther Lake-H support

Piotr Jaroszynski (1):
      Fix mmu notifiers for range-based invalidates

Richard Fitzgerald (2):
      ASoC: Intel: sof_sdw: Add lookup of quirk using PCI subsystem ID
      ASoC: Intel: sof_sdw: Add quirk for Asus Zenbook S14

Rik van Riel (1):
      scsi: core: Use GFP_NOIO to avoid circular locking dependency

Rodrigo Vivi (1):
      drm/xe/pm: Temporarily disable D3Cold on BMG

Ruozhu Li (1):
      nvmet-rdma: recheck queue state is LIVE in state lock in recv done

Sakari Ailus (2):
      platform/x86: int3472: Use correct type for "polarity", call it gpio_flags
      platform/x86: int3472: Call "reset" GPIO "enable" for INT347E

Saurabh Sengar (2):
      fbdev: hyperv_fb: Simplify hvfb_putmem
      fbdev: hyperv_fb: Allow graceful removal of framebuffer

Sebastian Andrzej Siewior (1):
      netfilter: nft_ct: Use __refcount_inc() for per-CPU nft_ct_pcpu_template.

Seunghui Lee (1):
      scsi: ufs: core: Fix error return with query response

Shay Drory (2):
      net/mlx5: Fix incorrect IRQ pool usage when releasing IRQs
      net/mlx5: Lag, Check shared fdb before creating MultiPort E-Switch

Shin'ichiro Kawasaki (2):
      nvme: move error logging from nvme_end_req() to __nvme_end_req()
      block: change blk_mq_add_to_batch() third argument type to bool

Stephan Gerhold (1):
      net: wwan: mhi_wwan_mbim: Silence sequence number glitch errors

Steve French (1):
      smb3: add support for IAKerb

Suren Baghdasaryan (1):
      userfaultfd: fix PTE unmapping stack-allocated PTE copies

Sybil Isabel Dorsett (1):
      platform/x86: thinkpad_acpi: Fix invalid fan speed on ThinkPad X120e

Taehee Yoo (6):
      eth: bnxt: fix truesize for mb-xdp-pass case
      eth: bnxt: return fail if interface is down in bnxt_queue_mem_alloc()
      eth: bnxt: do not use BNXT_VNIC_NTUPLE unconditionally in queue restart logic
      eth: bnxt: do not update checksum in bnxt_xdp_build_skb()
      eth: bnxt: fix kernel panic in the bnxt_get_queue_stats{rx | tx}
      eth: bnxt: fix memory leak in queue reset

Tamir Duberstein (4):
      rust: alloc: satisfy POSIX alignment requirement
      scripts: generate_rust_analyzer: add missing macros deps
      scripts: generate_rust_analyzer: add missing include_dirs
      scripts: generate_rust_analyzer: add uapi crate

Tejas Upadhyay (2):
      drm/xe: cancel pending job timer before freeing scheduler
      drm/xe: Release guc ids before cancelling work

Tejun Heo (1):
      sched_ext: selftests/dsp_local_on: Fix sporadic failures

Terry Cheong (1):
      ASoC: SOF: Intel: hda: add softdep pre to snd-hda-codec-hdmi module

Thomas Hellström (1):
      drm/xe/userptr: Fix an incorrect assert

Thomas Mizrahi (1):
      ASoC: amd: yc: Support mic on another Lenovo ThinkPad E16 Gen 2 model

Thomas Zimmermann (1):
      drm/nouveau: Do not override forced connector status

Uday Shankar (1):
      io-wq: backoff when retrying worker creation

Uladzislau Rezki (Sony) (1):
      mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq

Varada Pavani (1):
      clk: samsung: update PLL locktime for PLL142XX used on FSD platform

Vicki Pfau (1):
      HID: hid-steam: Fix issues with disabling both gamepad mode and lizard mode

Ville Syrjälä (2):
      drm/i915/cdclk: Do cdclk post plane programming later
      drm/atomic: Filter out redundant DPMS calls

Vitaly Rodionov (1):
      ASoC: arizona/madera: use fsleep() in up/down DAPM event delays.

Vlad Dogaru (1):
      net/mlx5: HWS, Rightsize bwc matcher priority

Wentao Liang (1):
      net/mlx5: handle errors in mlx5_chains_create_table()

Werner Sembach (4):
      Input: i8042 - swap old quirk combination with new quirk for NHxxRZQ
      Input: i8042 - add required quirks for missing old boardnames
      Input: i8042 - swap old quirk combination with new quirk for several devices
      Input: i8042 - swap old quirk combination with new quirk for more devices

Xin Long (1):
      Revert "openvswitch: switch to per-action label counting in conntrack"

Yifan Zha (1):
      drm/amd/amdkfd: Evict all queues even HWS remove queue failed

Yu-Chun Lin (1):
      sctp: Fix undefined behavior in left shift operation

Zhang Lixu (3):
      HID: intel-ish-hid: fix the length of MNG_SYNC_FW_CLOCK in doorbell
      HID: intel-ish-hid: Send clock sync message immediately after reset
      HID: intel-ish-hid: ipc: Add Panther Lake PCI device IDs

Zhenhua Huang (1):
      arm64: mm: Populate vmemmap at the page level if not section aligned


