Return-Path: <stable+bounces-132100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C86A843DA
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 14:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D3517A713
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8C42836A2;
	Thu, 10 Apr 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wqeftJJd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DB02857D4;
	Thu, 10 Apr 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289860; cv=none; b=dabYg5l12jtvsP51OzMLeG5o0fw4wGyH2Q1bMdx0VcihV4fhg0jUPgRrnqKpmy7x4bsYYvQgiXbNGdZstRUnVwtOe5I01VWLMOyr6Wv5V816jXsKplXSEUzJhesXAQ0y4rrhqxhXWPzKEeTlkIPexfgMDU0JWDc26HPp/DikY7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289860; c=relaxed/simple;
	bh=I0ECm7bPVFwikIp993tTQP6VvXloL0EeZ3XUjqKz/cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jaAVaiHflINnukGStHOywJk3k0nrNZCriIU1B4afJamDVtyZcpX3yELIqAARF6/oaZRKykgTbUVLJi8khUlGz6Q9Px9z2Rgm44GgEPNtCqYucgx+lPtERrbQhPgx4DQrtdGIQX5ferOH6Ev/6ymKerSQbPK4QYS7HEwdD/q1vbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wqeftJJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F54BC4CEDD;
	Thu, 10 Apr 2025 12:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744289860;
	bh=I0ECm7bPVFwikIp993tTQP6VvXloL0EeZ3XUjqKz/cg=;
	h=From:To:Cc:Subject:Date:From;
	b=wqeftJJdzVvsUEfCPyIXvIA5RzPNjDI9Fc3gbaCdFkD30zPRSZVuFZ5+NlMJAp8TT
	 +r/x6ZtEhZHJRM66zdBSSyL057bamh8GsIlxHTZB51cj8170P/5mgbUhU+S8hHJU1S
	 xymYSSnXo++grZHZ+zyVgnmv6h4hh/Qb//VPoaRc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.236
Date: Thu, 10 Apr 2025 14:55:54 +0200
Message-ID: <2025041055-viable-ember-1805@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.236 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/timers/no_hz.rst                                 |    7 
 Makefile                                                       |    2 
 arch/alpha/include/asm/elf.h                                   |    6 
 arch/alpha/include/asm/pgtable.h                               |    2 
 arch/alpha/include/asm/processor.h                             |    8 
 arch/alpha/kernel/osf_sys.c                                    |   11 
 arch/arm/boot/dts/bcm2711.dtsi                                 |   11 
 arch/arm/mach-shmobile/headsmp.S                               |    1 
 arch/arm/mm/fault.c                                            |    8 
 arch/powerpc/platforms/cell/spufs/inode.c                      |    9 
 arch/x86/Kconfig                                               |    2 
 arch/x86/entry/calling.h                                       |    2 
 arch/x86/include/asm/tlbflush.h                                |    2 
 arch/x86/kernel/cpu/microcode/amd.c                            |    2 
 arch/x86/kernel/cpu/mshyperv.c                                 |   11 
 arch/x86/kernel/crash.c                                        |    4 
 arch/x86/kernel/dumpstack.c                                    |    5 
 arch/x86/kernel/irq.c                                          |    2 
 arch/x86/kernel/machine_kexec_64.c                             |   12 
 arch/x86/kernel/process.c                                      |    7 
 arch/x86/kernel/tsc.c                                          |    4 
 arch/x86/kvm/hyperv.c                                          |    6 
 arch/x86/mm/pat/cpa-test.c                                     |    2 
 block/bio.c                                                    |    2 
 drivers/acpi/nfit/core.c                                       |    2 
 drivers/acpi/processor_idle.c                                  |    4 
 drivers/acpi/resource.c                                        |   13 
 drivers/base/power/main.c                                      |   21 
 drivers/base/power/runtime.c                                   |    2 
 drivers/clk/meson/g12a.c                                       |   38 
 drivers/clk/meson/gxbb.c                                       |   14 
 drivers/clk/rockchip/clk-rk3328.c                              |    2 
 drivers/clk/samsung/clk.c                                      |    2 
 drivers/clocksource/i8253.c                                    |   36 
 drivers/counter/microchip-tcb-capture.c                        |   19 
 drivers/counter/stm32-lptimer-cnt.c                            |   24 
 drivers/cpufreq/cpufreq_governor.c                             |   45 
 drivers/cpufreq/scpi-cpufreq.c                                 |    5 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                     |    8 
 drivers/edac/ie31200_edac.c                                    |   19 
 drivers/firmware/imx/imx-scu.c                                 |    1 
 drivers/firmware/iscsi_ibft.c                                  |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |  106 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c      |   14 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c         |    1 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c              |  585 +++-------
 drivers/gpu/drm/amd/display/dc/dc.h                            |    1 
 drivers/gpu/drm/amd/display/dc/dc_types.h                      |    5 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c          |   12 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c          |   14 
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c |   12 
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h      |    2 
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c          |   40 
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h              |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c                |   21 
 drivers/gpu/drm/drm_atomic_uapi.c                              |    4 
 drivers/gpu/drm/drm_connector.c                                |    4 
 drivers/gpu/drm/drm_dp_mst_topology.c                          |    8 
 drivers/gpu/drm/gma500/mid_bios.c                              |    5 
 drivers/gpu/drm/mediatek/mtk_dsi.c                             |    6 
 drivers/gpu/drm/mediatek/mtk_hdmi.c                            |   33 
 drivers/gpu/drm/nouveau/nouveau_connector.c                    |    1 
 drivers/gpu/drm/radeon/radeon_vce.c                            |    2 
 drivers/gpu/drm/v3d/v3d_sched.c                                |    9 
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                            |    2 
 drivers/hid/hid-ids.h                                          |    1 
 drivers/hid/hid-plantronics.c                                  |  144 +-
 drivers/hid/hid-quirks.c                                       |    1 
 drivers/hid/intel-ish-hid/ipc/ipc.c                            |    6 
 drivers/hv/vmbus_drv.c                                         |   13 
 drivers/hwmon/nct6775.c                                        |    4 
 drivers/hwtracing/coresight/coresight-catu.c                   |    2 
 drivers/i2c/busses/i2c-ali1535.c                               |   12 
 drivers/i2c/busses/i2c-ali15x3.c                               |   12 
 drivers/i2c/busses/i2c-omap.c                                  |   26 
 drivers/i2c/busses/i2c-sis630.c                                |   12 
 drivers/i2c/i2c-dev.c                                          |   15 
 drivers/iio/accel/mma8452.c                                    |   10 
 drivers/infiniband/core/mad.c                                  |   38 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                       |    2 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h                     |    3 
 drivers/infiniband/hw/hns/hns_roce_hem.c                       |   23 
 drivers/infiniband/hw/hns/hns_roce_hem.h                       |    2 
 drivers/infiniband/hw/hns/hns_roce_main.c                      |    2 
 drivers/infiniband/hw/hns/hns_roce_mr.c                        |    4 
 drivers/infiniband/hw/mlx5/cq.c                                |    2 
 drivers/media/dvb-frontends/dib8000.c                          |    5 
 drivers/media/i2c/et8ek8/et8ek8_driver.c                       |    4 
 drivers/memstick/host/rtsx_usb_ms.c                            |    1 
 drivers/mfd/sm501.c                                            |    6 
 drivers/mmc/host/atmel-mci.c                                   |    4 
 drivers/mmc/host/sdhci-pxav3.c                                 |    1 
 drivers/net/arcnet/com20020-pci.c                              |   17 
 drivers/net/can/flexcan.c                                      |    6 
 drivers/net/dsa/mv88e6xxx/chip.c                               |   11 
 drivers/net/dsa/mv88e6xxx/phy.c                                |    3 
 drivers/net/ethernet/intel/ice/ice_arfs.c                      |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c              |    6 
 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c        |    5 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c       |    8 
 drivers/net/usb/qmi_wwan.c                                     |    2 
 drivers/net/usb/usbnet.c                                       |   21 
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                    |   86 -
 drivers/ntb/hw/intel/ntb_hw_gen3.c                             |    3 
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c                         |    2 
 drivers/ntb/test/ntb_perf.c                                    |    4 
 drivers/nvme/host/core.c                                       |    2 
 drivers/nvme/host/fc.c                                         |    3 
 drivers/nvme/host/pci.c                                        |   21 
 drivers/nvme/host/tcp.c                                        |    5 
 drivers/nvme/target/rdma.c                                     |   33 
 drivers/pci/controller/cadence/pcie-cadence-ep.c               |    3 
 drivers/pci/controller/cadence/pcie-cadence.h                  |    2 
 drivers/pci/controller/pcie-brcmstb.c                          |    4 
 drivers/pci/controller/pcie-xilinx-cpm.c                       |   10 
 drivers/pci/hotplug/pciehp_hpc.c                               |    4 
 drivers/pci/pcie/aspm.c                                        |   17 
 drivers/pci/pcie/portdrv_core.c                                |    8 
 drivers/pci/probe.c                                            |    5 
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c                         |    2 
 drivers/pinctrl/renesas/pinctrl-rza2.c                         |    2 
 drivers/pinctrl/tegra/pinctrl-tegra.c                          |    3 
 drivers/platform/x86/intel-hid.c                               |    7 
 drivers/power/supply/max77693_charger.c                        |    2 
 drivers/powercap/powercap_sys.c                                |    3 
 drivers/regulator/core.c                                       |   12 
 drivers/remoteproc/qcom_q6v5_pas.c                             |   10 
 drivers/s390/cio/chp.c                                         |    3 
 drivers/scsi/qla1280.c                                         |    2 
 drivers/soc/qcom/pdr_interface.c                               |    8 
 drivers/thermal/cpufreq_cooling.c                              |    2 
 drivers/thermal/intel/int340x_thermal/int3402_thermal.c        |    3 
 drivers/tty/serial/8250/8250_dma.c                             |    2 
 drivers/tty/serial/8250/8250_pci.c                             |   16 
 drivers/tty/serial/fsl_lpuart.c                                |   25 
 drivers/usb/serial/ftdi_sio.c                                  |   14 
 drivers/usb/serial/ftdi_sio_ids.h                              |   13 
 drivers/usb/serial/option.c                                    |   48 
 drivers/video/console/Kconfig                                  |    2 
 drivers/video/fbdev/au1100fb.c                                 |    4 
 drivers/video/fbdev/hyperv_fb.c                                |    2 
 drivers/video/fbdev/sm501fb.c                                  |    7 
 fs/affs/file.c                                                 |    9 
 fs/btrfs/extent-tree.c                                         |    5 
 fs/exfat/fatent.c                                              |    2 
 fs/ext4/dir.c                                                  |    3 
 fs/ext4/super.c                                                |   27 
 fs/fuse/dir.c                                                  |    2 
 fs/isofs/dir.c                                                 |    3 
 fs/jfs/jfs_dtree.c                                             |    3 
 fs/jfs/xattr.c                                                 |   15 
 fs/namei.c                                                     |   24 
 fs/nfs/delegation.c                                            |   33 
 fs/nfsd/nfs4state.c                                            |   31 
 fs/ocfs2/alloc.c                                               |    8 
 fs/proc/base.c                                                 |    2 
 fs/proc/generic.c                                              |   10 
 fs/proc/inode.c                                                |    6 
 fs/proc/internal.h                                             |   14 
 fs/vboxsf/super.c                                              |    3 
 include/drm/drm_dp_mst_helper.h                                |    7 
 include/linux/fs.h                                             |    2 
 include/linux/i8253.h                                          |    1 
 include/linux/interrupt.h                                      |    8 
 include/linux/netfilter/nf_conntrack_common.h                  |    8 
 include/linux/pm_runtime.h                                     |    2 
 include/linux/proc_fs.h                                        |    7 
 include/linux/sched/smt.h                                      |    2 
 include/net/ipv6.h                                             |    4 
 kernel/events/ring_buffer.c                                    |    2 
 kernel/kexec_elf.c                                             |    2 
 kernel/locking/semaphore.c                                     |   13 
 kernel/sched/deadline.c                                        |    2 
 kernel/time/hrtimer.c                                          |   22 
 kernel/trace/bpf_trace.c                                       |    2 
 kernel/trace/ring_buffer.c                                     |    4 
 kernel/trace/trace_events_synth.c                              |   34 
 kernel/trace/trace_functions_graph.c                           |    1 
 kernel/trace/trace_irqsoff.c                                   |    2 
 kernel/trace/trace_sched_wakeup.c                              |    2 
 kernel/watch_queue.c                                           |    9 
 lib/842/842_compress.c                                         |    2 
 net/8021q/vlan_netlink.c                                       |   10 
 net/atm/lec.c                                                  |    3 
 net/atm/mpc.c                                                  |    2 
 net/batman-adv/bat_iv_ogm.c                                    |    3 
 net/batman-adv/bat_v_ogm.c                                     |    3 
 net/bluetooth/6lowpan.c                                        |    7 
 net/bluetooth/hci_event.c                                      |   13 
 net/can/af_can.c                                               |   12 
 net/can/af_can.h                                               |   12 
 net/can/proc.c                                                 |   46 
 net/core/neighbour.c                                           |    1 
 net/core/netpoll.c                                             |    9 
 net/core/rtnetlink.c                                           |    3 
 net/core/sock_map.c                                            |    5 
 net/ipv4/ip_tunnel_core.c                                      |    4 
 net/ipv6/addrconf.c                                            |   37 
 net/ipv6/calipso.c                                             |   21 
 net/ipv6/ip6_output.c                                          |    6 
 net/ipv6/netfilter/nf_socket_ipv6.c                            |   23 
 net/ipv6/route.c                                               |    5 
 net/mptcp/protocol.h                                           |    2 
 net/netfilter/ipvs/ip_vs_ctl.c                                 |    8 
 net/netfilter/nf_conncount.c                                   |    2 
 net/netfilter/nf_conntrack_core.c                              |   48 
 net/netfilter/nf_conntrack_expect.c                            |    4 
 net/netfilter/nf_conntrack_netlink.c                           |    7 
 net/netfilter/nf_conntrack_standalone.c                        |    7 
 net/netfilter/nf_flow_table_core.c                             |    2 
 net/netfilter/nf_synproxy_core.c                               |    1 
 net/netfilter/nft_ct.c                                         |   11 
 net/netfilter/nft_exthdr.c                                     |   10 
 net/netfilter/nft_tunnel.c                                     |    6 
 net/netfilter/xt_CT.c                                          |    3 
 net/openvswitch/actions.c                                      |    6 
 net/openvswitch/conntrack.c                                    |    1 
 net/sched/act_ct.c                                             |    1 
 net/sched/act_tunnel_key.c                                     |    2 
 net/sched/cls_flower.c                                         |    2 
 net/sched/sch_api.c                                            |    6 
 net/sched/sch_skbprio.c                                        |    3 
 net/sctp/stream.c                                              |    2 
 net/vmw_vsock/af_vsock.c                                       |    6 
 net/xfrm/xfrm_output.c                                         |    2 
 scripts/selinux/install_policy.sh                              |   15 
 sound/pci/hda/patch_realtek.c                                  |   28 
 sound/soc/codecs/arizona.c                                     |   14 
 sound/soc/codecs/madera.c                                      |   10 
 sound/soc/codecs/tas2764.c                                     |   10 
 sound/soc/codecs/tas2764.h                                     |    8 
 sound/soc/codecs/tas2770.c                                     |    2 
 sound/soc/codecs/wm0010.c                                      |   13 
 sound/soc/codecs/wm5110.c                                      |    8 
 sound/soc/sh/rcar/core.c                                       |   14 
 sound/soc/sh/rcar/rsnd.h                                       |    1 
 sound/soc/sh/rcar/src.c                                        |   18 
 sound/soc/sof/intel/hda-codec.c                                |    1 
 sound/soc/ti/j721e-evm.c                                       |    2 
 sound/usb/mixer_quirks.c                                       |   51 
 tools/perf/util/python.c                                       |   17 
 tools/perf/util/units.c                                        |    2 
 243 files changed, 1865 insertions(+), 1175 deletions(-)

Acs, Jakub (1):
      ext4: fix OOB read when checking dotdot dir

Al Viro (2):
      spufs: fix a leak on spufs_new_file() failure
      spufs: fix a leak in spufs_create_context()

Alex Hung (1):
      drm/amd/display: Assign normalized_pix_clk when color depth = 14

Alexey Kashavkin (1):
      netfilter: nft_exthdr: fix offset with ipv4_find_option()

Andreas Kemnade (1):
      i2c: omap: fix IRQ storms

Andy Shevchenko (2):
      hrtimers: Mark is_migration_base() with __always_inline
      i2c: dev: check return value when calling dev_set_name()

AngeloGioacchino Del Regno (2):
      drm/mediatek: mtk_hdmi: Unregister audio platform device on failure
      drm/mediatek: mtk_hdmi: Fix typo for aud_sampe_size member

Arnaldo Carvalho de Melo (5):
      perf units: Fix insufficient array space
      perf python: Fixup description of sample.id event member
      perf python: Decrement the refcount of just created event on failure
      perf python: Don't keep a raw_data pointer to consumed ring buffer space
      perf python: Check if there is space to copy all the event

Arnd Bergmann (3):
      x86/irq: Define trace events conditionally
      x86/platform: Only allow CONFIG_EISA for 32-bit
      mdacon: rework dependency list

Artur Weber (2):
      pinctrl: bcm281xx: Fix incorrect regmap max_registers value
      power: supply: max77693: Fix wrong conversion of charge input threshold value

Baoquan He (1):
      x86/kexec: fix memory leak of elf header buffer

Bart Van Assche (1):
      fs/procfs: fix the comment above proc_pid_wchan()

Benjamin Berg (1):
      x86/fpu: Avoid copying dynamic FP state from init_task in arch_dup_task_struct()

Boon Khai Ng (1):
      USB: serial: ftdi_sio: add support for Altera USB Blaster 3

Brahmajit Das (1):
      vboxsf: fix building with GCC 15

Breno Leitao (1):
      netpoll: hold rcu read lock in __netpoll_send_skb()

Cameron Williams (1):
      tty: serial: 8250: Add some more device IDs

Carolina Jubran (1):
      net/mlx5e: Prevent bridge link show failure for non-eswitch-allowed devices

Chengchang Tang (1):
      RDMA/hns: Remove redundant 'phy_addr' in hns_roce_hem_list_find_mtt()

Chengen Du (1):
      iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in ibft_attr_show_nic()

Chenyuan Yang (1):
      thermal: int340x: Add NULL check for adev

Chia-Lin Kao (AceLan) (1):
      HID: ignore non-functional sensor in HP 5MP Camera

Christian Eggers (1):
      regulator: check that dummy regulator has been probed before using it

Christophe JAILLET (4):
      ASoC: codecs: wm0010: Fix error handling path in wm0010_spi_probe()
      i2c: ali1535: Fix an error handling path in ali1535_probe()
      i2c: ali15x3: Fix an error handling path in ali15x3_probe()
      i2c: sis630: Fix an error handling path in sis630_probe()

Chuck Lever (1):
      NFSD: Skip sending CB_RECALL_ANY when the backchannel isn't up

Cong Wang (2):
      net_sched: Prevent creation of classes with TC_H_ROOT
      net_sched: skbprio: Remove overly strict queue assertions

Cosmin Ratiu (1):
      xfrm_output: Force software GSO only in tunnel mode

Dan Carpenter (5):
      ipvs: prevent integer overflow in do_ip_vs_get_ctl()
      Bluetooth: Fix error code in chan_alloc_skb_cb()
      net: atm: fix use after free in lec_send()
      PCI: Remove stray put_device() in pci_register_host_bridge()
      drm/mediatek: dsi: fix error codes in mtk_dsi_host_transfer()

Daniel Lezcano (1):
      thermal/cpufreq_cooling: Remove structure member documentation

Daniel Stodden (1):
      PCI/ASPM: Fix link state exit during switch upstream function removal

Daniel Wagner (2):
      nvme-fc: go straight to connecting state when initializing
      nvme: only allow entering LIVE from CONNECTING state

Danila Chernetsov (1):
      fbdev: sm501fb: Add some geometry checks.

David Oberhollenzer (1):
      net: dsa: mv88e6xxx: propperly shutdown PPU re-enable timer on destroy

David Woodhouse (1):
      clockevents/drivers/i8253: Fix stop sequence for timer 0

Debin Zhu (1):
      netlabel: Fix NULL pointer exception caused by CALIPSO on IPv4 sockets

Dhruv Deshpande (1):
      ALSA: hda/realtek: Support mute LED on HP Laptop 15s-du3xxx

Dmitry Panchenko (1):
      platform/x86: intel-hid: fix volume buttons on Microsoft Surface Go 4 tablet

Dmytro Laktyushkin (1):
      drm/amd/display: fix odm scaling

Dominique Martinet (1):
      net: usb: usbnet: restore usb%d name exception for local mac addresses

Douglas Raillard (1):
      tracing: Ensure module defining synth event cannot be unloaded while tracing

Eric Dumazet (1):
      vlan: fix memory leak in vlan_newlink()

Eric Sandeen (1):
      watch_queue: fix pipe accounting mismatch

Eric W. Biederman (1):
      alpha/elf: Fix misc/setarch test of util-linux by removing 32bit support

Fabio Porcedda (4):
      USB: serial: option: add Telit Cinterion FE990B compositions
      USB: serial: option: fix Telit Cinterion FE990A name
      net: usb: qmi_wwan: add Telit Cinterion FN990B composition
      net: usb: qmi_wwan: add Telit Cinterion FE990B composition

Fabrice Gasnier (1):
      counter: stm32-lptimer-cnt: fix error handling when enabling

Fabrizio Castro (1):
      pinctrl: renesas: rza2: Fix missing of_node_put() call

Feng Tang (1):
      PCI/portdrv: Only disable pciehp interrupts early when needed

Feng Yang (1):
      ring-buffer: Fix bytes_dropped calculation issue

Fernando Fernandez Mancera (1):
      ipv6: fix omitted netlink attributes when using RTEXT_FILTER_SKIP_STATS

Florent Revest (1):
      x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA nodes

Florian Westphal (3):
      netfilter: conntrack: convert to refcount_t api
      netfilter: nft_ct: fix use after free when attaching zone template
      netfilter: conntrack: fix crash due to confirmed bit load reordering

Gannon Kolding (1):
      ACPI: resource: IRQ override for Eluktronics MECH-17

Geert Uytterhoeven (1):
      ARM: shmobile: smp: Enforce shmobile_smp_* alignment

Geetha sowjanya (1):
      octeontx2-af: Fix mbox INTR handler when num VFs > 64

Giovanni Gherdovich (1):
      ACPI: processor: idle: Return an error if both P_LVL{2,3} idle states are invalid

Greg Kroah-Hartman (1):
      Linux 5.10.236

Grzegorz Nitka (1):
      ice: fix memory leak in aRFS after reset

Gu Bowen (1):
      mmc: atmel-mci: Add missing clk_disable_unprepare()

Guilherme G. Piccoli (1):
      x86/tsc: Always save/restore TSC sched_clock() on suspend/resume

Guillaume Nault (1):
      tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu().

Haibo Chen (1):
      can: flexcan: only change CAN state when link up in system PM

Hans Zhang (1):
      PCI: cadence-ep: Fix the driver to send MSG TLP for INTx without data payload

Haoxiang Li (1):
      qlcnic: fix memory leak issues in qlcnic_sriov_common.c

Hector Martin (3):
      ASoC: tas2770: Fix volume scale
      ASoC: tas2764: Fix power control mask
      ASoC: tas2764: Set the SDOUT polarity correctly

Henry Martin (1):
      arcnet: Add NULL check in com20020pci_probe()

Hersen Wu (1):
      drm/amd/display: Skip inactive planes within ModeSupportAndSystemConfiguration

Hou Tao (1):
      bpf: Use preempt_count() directly in bpf_send_signal_common()

Icenowy Zheng (2):
      nvme-pci: clean up CMBMSC when registering CMB fails
      nvme-pci: skip CMB blocks incompatible with PCI P2P DMA

Ilkka Koskinen (1):
      coresight: catu: Fix number of pages while using 64k pages

Ilpo Järvinen (1):
      PCI: pciehp: Don't enable HPIE when resuming in poll mode

Ivan Abramov (1):
      drm/gma500: Add NULL check for pci_gfx_root in mid_get_vbt_data()

Jann Horn (3):
      x86/entry: Fix ORC unwinder for PUSH_REGS with save_ret=1
      x86/dumpstack: Fix inaccurate unwinding from exception stacks due to misplaced assignment
      x86/mm: Fix flush_tlb_range() when used for zapping normal PMDs

Jayesh Choudhary (1):
      ASoC: ti: j721e-evm: Fix clock configuration for ti,j7200-cpb-audio compatible

Jerome Brunet (4):
      clk: amlogic: gxbb: drop incorrect flag on 32k clock
      clk: amlogic: g12b: fix cluster A parent data
      clk: amlogic: gxbb: drop non existing 32k clock parent
      clk: amlogic: g12a: fix mmc A peripheral clock

Jesse Zhang (1):
      drm/amd/pm: Fix negative array index read

Jie Zhan (1):
      cpufreq: governor: Fix negative 'idle_time' handling in dbs_update()

Jim Quinlan (1):
      PCI: brcmstb: Use internal register to change link capability

Joe Hattori (2):
      powercap: call put_device() on an error path in powercap_register_control_type()
      firmware: imx-scu: fix OF node leak in .probe()

Johan Hovold (1):
      USB: serial: option: match on interface class for Telit FN990B

Johannes Berg (1):
      wifi: iwlwifi: fw: allocate chained SG tables for dump

John Keeping (1):
      serial: 8250_dma: terminate correct DMA in tx_dma_flush()

Jonathan Cameron (1):
      iio: accel: mma8452: Ensure error return on failure to matching oversampling ratio

Josef Bacik (1):
      btrfs: handle errors from btrfs_dec_ref() properly

Josh Poimboeuf (2):
      objtool, media: dib8000: Prevent divide-by-zero in dib8000_set_dds()
      sched/smt: Always inline sched_smt_active()

Junxian Huang (2):
      RDMA/hns: Fix soft lockup during bt pages loop
      RDMA/hns: Fix wrong value of max_sge_rd

Karel Balej (1):
      mmc: sdhci-pxav3: set NEED_RSP_BUSY capability

Kashyap Desai (1):
      RDMA/bnxt_re: Add missing paranthesis in map_qp_id_to_tbl_indx

Kees Cook (2):
      ARM: 9350/1: fault: Implement copy_from_kernel_nofault_allowed()
      ARM: 9351/1: fault: Add "cut here" line for prefetch aborts

Kohei Enju (1):
      netfilter: nf_conncount: Fully initialize struct nf_conncount_tuple in insert_tree()

Kuninori Morimoto (1):
      ASoC: rsnd: don't indicate warning on rsnd_kctrl_accept_runtime()

Kuniyuki Iwashima (2):
      ipv6: Fix memleak of nhc_pcpu_rth_output in fib_check_nh_v6_gw().
      ipv6: Set errno after ip_fib_metrics_init() in ip6_route_info_create().

Lee Jones (1):
      drm/amd/display/dc/core/dc_resource: Staticify local functions

Li Lingfeng (1):
      nfsd: put dl_stid if fail to queue dl_recall

Lin Ma (3):
      net/neighbor: add missing policy for NDTPA_QUEUE_LENBYTES
      netfilter: nft_tunnel: fix geneve_opt type confusion addition
      net: fix geneve_opt length integer overflow

Luca Weiss (1):
      remoteproc: qcom_q6v5_pas: Make single-PD handling more robust

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE

Luo Qiu (1):
      memstick: rtsx_usb_ms: Fix slab-use-after-free in rtsx_usb_ms_drv_remove

Ma Ke (1):
      drm/amd/display: Fix null check for pipe_ctx->plane_state in resource_build_scaling_params

Magnus Lindholm (1):
      scsi: qla1280: Fix kernel oops when debug level > 2

Maher Sanalla (1):
      IB/mad: Check available slots before posting receive WRs

Mario Kleiner (1):
      drm/amd/display: Check plane scaling against format specific hw plane caps.

Mario Limonciello (1):
      drm/amd/display: Fix slab-use-after-free on hdcp_work

Mark Zhang (1):
      rtnetlink: Allocate vfinfo size for VF GUIDs when supported

Markus Elfring (2):
      fbdev: au1100fb: Move a variable assignment behind a null pointer check
      ntb_perf: Delete duplicate dmaengine_unmap_put() call in perf_copy_chunk()

Matthieu Baerts (NGI0) (1):
      mptcp: safety check before fallback

Maxim Mikityanskiy (1):
      netfilter: socket: Lookup orig tuple for IPv6 SNAT

Maíra Canal (1):
      drm/v3d: Don't run jobs that have errors flagged in its fence

Michael Kelley (2):
      fbdev: hyperv_fb: iounmap() the correct memory when removing a device
      Drivers: hv: vmbus: Don't release fb_mmio resource in vmbus_free_mmio()

Michael Strauss (1):
      drm/amd/display: Check for invalid input params when building scaling params

Michal Luczaj (1):
      bpf, sockmap: Fix race between element replace and close()

Mike Rapoport (Microsoft) (1):
      x86/mm/pat: cpa-test: fix length for CPA_ARRAY test

Miklos Szeredi (1):
      fuse: don't truncate cached, mutated symlink

Ming Lei (1):
      block: fix 'kmem_cache of name 'bio-108' already exists'

Minjoong Kim (1):
      atm: Fix NULL pointer dereference

Murad Masimov (1):
      acpi: nfit: fix narrowing conversion in acpi_nfit_ctl

Navon John Lukose (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion x360 14-dy1xxx

Nikita Shubin (1):
      ntb: intel: Fix using link status DB's

Nikita Zhandarovich (2):
      drm/radeon: fix uninitialized size issue in radeon_vce_cs_parse()
      mfd: sm501: Switch to BIT() to mitigate integer overflows

Nikola Cornij (1):
      drm/amd/display: Reject too small viewport size when validating plane

Oleg Nesterov (1):
      sched/isolation: Prevent boot crash when the boot CPU is nohz_full

Oliver Hartkopp (1):
      can: statistics: use atomic access in hot path

Patrik Jakobsson (1):
      drm/amdgpu: Fix even more out of bound writes from debugfs

Patrisious Haddad (1):
      RDMA/mlx5: Fix mlx5_poll_one() cur_qp update flow

Paul Menzel (1):
      ACPI: resource: Skip IRQ override on ASUS Vivobook 14 X1404VAP

Peter Geis (1):
      clk: rockchip: rk3328: fix wrong clk_ref_usb3otg parent

Peter Oberparleiter (1):
      s390/cio: Fix CHPID "configure" attribute caching

Phil Elwell (2):
      ARM: dts: bcm2711: PL011 UARTs are actually r1p5
      ARM: dts: bcm2711: Don't mark timer regs unconfigured

Prathamesh Shete (1):
      pinctrl: tegra: Set SFIO mode to Mux Register

Qasim Ijaz (2):
      isofs: fix KMSAN uninit-value bug in do_isofs_readdir()
      jfs: fix slab-out-of-bounds read in ea_get()

Qiuxu Zhuo (3):
      EDAC/ie31200: Fix the size of EDAC_MC_LAYER_CHIP_SELECT layer
      EDAC/ie31200: Fix the DIMM size mask for several SoCs
      EDAC/ie31200: Fix the error path order of ie31200_init()

Rafael J. Wysocki (2):
      PM: sleep: Adjust check before setting power.must_resume
      PM: sleep: Fix handling devices with direct_complete set on errors

Roman Smirnov (1):
      jfs: add index corruption check to DT_GETPAGE()

Ruozhu Li (1):
      nvmet-rdma: recheck queue state is LIVE in state lock in recv done

Sagi Grimberg (1):
      nvme-tcp: fix possible UAF in nvme_tcp_poll

Saranya R (1):
      soc: qcom: pdr: Fix the potential deadlock

Saravanan Vajravel (1):
      RDMA/bnxt_re: Avoid clearing VLAN_ID mask in modify qp path

Sean Christopherson (1):
      KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if local APIC isn't in-kernel

Sebastian Andrzej Siewior (2):
      netfilter: nft_ct: Use __refcount_inc() for per-CPU nft_ct_pcpu_template.
      lockdep: Don't disable interrupts on RT in disable_irq_nosync_lockdep.*()

Sherry Sun (2):
      tty: serial: fsl_lpuart: use UARTMODIR register bits for lpuart32 platform
      tty: serial: fsl_lpuart: disable transmitter before changing RS485 related registers

Shrikanth Hegde (1):
      sched/deadline: Use online cpus for validating runtime

Simon Tatham (2):
      affs: generate OFS sequence numbers starting at 1
      affs: don't write overlarge OFS data block size fields

Sourabh Jain (1):
      kexec: initialize ELF lowest address to ULONG_MAX

Stefano Garzarella (1):
      vsock: avoid timeout during connect() if the socket is closing

Steven Rostedt (1):
      tracing: Do not use PERF enums when perf is not defined

Sven Eckelmann (1):
      batman-adv: Ignore own maximum aggregation size during RX

Takashi Iwai (2):
      ALSA: hda/realtek: Always honor no_shutup_pins
      x86/kexec: Fix double-free of elf header buffer

Tanya Agarwal (1):
      lib: 842: Improve error handling in sw842_compress()

Tao Chen (1):
      perf/ring_buffer: Allow the EPOLLRDNORM flag for poll

Tasos Sahanidis (1):
      hwmon: (nct6775-core) Fix out of bounds access for NCT679{8,9}

Tengda Wu (1):
      tracing: Fix use-after-free in print_graph_function_flags during tracer switching

Terry Cheong (1):
      ASoC: SOF: Intel: hda: add softdep pre to snd-hda-codec-hdmi module

Terry Junge (2):
      ALSA: usb-audio: Add quirk for Plantronics headsets to fix control names
      HID: hid-plantronics: Add mic mute mapping and generalize quirks

Theodore Ts'o (1):
      ext4: don't over-report free space or inodes in statvfs

Thippeswamy Havalige (1):
      PCI: xilinx-cpm: Fix IRQ domain leak in error path of probe

Thomas Zimmermann (1):
      drm/nouveau: Do not override forced connector status

Tim Schumacher (1):
      selinux: Chain up tool resolving errors in install_policy.sh

Tomi Valkeinen (1):
      drm: xlnx: zynqmp: Fix max dma segment size

Trond Myklebust (1):
      NFSv4: Don't trigger uneccessary scans for return-on-close delegations

Uwe Kleine-König (1):
      media: i2c: et8ek8: Don't strip remove function when driver is builtin

Vasiliy Kovalev (1):
      ocfs2: validate l_tree_depth to avoid out-of-bounds access

Ville Syrjälä (1):
      drm/atomic: Filter out redundant DPMS calls

Vitaliy Shevtsov (1):
      drm/amd/display: fix type mismatch in CalculateDynamicMetadataParameters()

Vitaly Rodionov (1):
      ASoC: arizona/madera: use fsleep() in up/down DAPM event delays.

Waiman Long (1):
      locking/semaphore: Use wake_q to wake up processes outside lock critical section

Wang Yufen (1):
      ipv6: Fix signed integer overflow in __ip6_append_data

Wayne Lin (1):
      drm/dp_mst: Fix drm RAD print

Wenkai Lin (1):
      crypto: hisilicon/sec2 - fix for aead auth key length

Wentao Liang (1):
      net/mlx5: handle errors in mlx5_chains_create_table()

Will McVicker (1):
      clk: samsung: Fix UBSAN panic in samsung_clk_init()

William Breathitt Gray (1):
      counter: microchip-tcb-capture: Fix undefined counter channel state on probe

Yajun Deng (1):
      ntb_hw_switchtec: Fix shift-out-of-bounds in switchtec_ntb_mw_set_trans

Yanjun Yang (1):
      ARM: Remove address checking for MMUless devices

Ye Bin (1):
      proc: fix UAF in proc_get_inode()

Yu-Chun Lin (1):
      sctp: Fix undefined behavior in left shift operation

Yuezhang Mo (1):
      exfat: fix the infinite loop in exfat_find_last_cluster()

Zhang Lixu (1):
      HID: intel-ish-hid: fix the length of MNG_SYNC_FW_CLOCK in doorbell

zuoqian (1):
      cpufreq: scpi: compare kHz instead of Hz


