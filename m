Return-Path: <stable+bounces-89466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191B49B886D
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 02:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DC2282AA6
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 01:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE8A73451;
	Fri,  1 Nov 2024 01:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xu9xSsQl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12983762F7;
	Fri,  1 Nov 2024 01:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424414; cv=none; b=jrx6jbt9ds0E3oWdr8CG0nSKW2pBfL4HkGuOYBjMMdQ9jNfeAEum4svUI+FLQulzKxBQMPGm1pFTGuO8UFZj5/USS1ukMhCRmdDNElFxF577YU6uNE+cQPqNKggQ+knoruAxOWQeVcXZk9MfpbvtN766YeNgb4hGsnVGX13ewWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424414; c=relaxed/simple;
	bh=gbiyykx2CfPx7zp/uyi8wnJHwIZDNIZM2pceynWj+Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j7XtuN/292t04FDcmfsi6Ehso/SzkGGy4YnnedO1h24Q/h8JASIVywnZgdCSNHatda/iViwoRDOlSAK1Hy4hr78IO5kFm8A92IImeAWdqAatviozsE4u0bSH1V0hqBYqLpwKyQgBOVsv/68ECrclDtzrhTpWe+SeHezExY1zVHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xu9xSsQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8232EC4CEC3;
	Fri,  1 Nov 2024 01:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730424413;
	bh=gbiyykx2CfPx7zp/uyi8wnJHwIZDNIZM2pceynWj+Js=;
	h=From:To:Cc:Subject:Date:From;
	b=xu9xSsQlmWncclQg8ZKsPS3eTAr8hkfoekaXRlMnVjUb9UVjUBCo6obYGX61W8i90
	 M5uaNVG0BhAVFU85yqYou6LcXlBfubQgEIYbsb5yB3k6ECO5dECyPfjUqcUFNtieqs
	 K5BKzM1mzhj+dLYsZcFG6b719hpgUCXmp7FgYYnI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.11.6
Date: Fri,  1 Nov 2024 02:26:31 +0100
Message-ID: <2024110131-reborn-rotting-7f8f@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.11.6 kernel.

All users of the 6.11 kernel series must upgrade.

The updated 6.11.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.11.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml |   18 
 Makefile                                                         |    2 
 arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts               |    2 
 arch/arm64/Makefile                                              |    2 
 arch/arm64/kvm/arm.c                                             |    3 
 arch/arm64/kvm/sys_regs.c                                        |    2 
 arch/arm64/kvm/vgic/vgic-init.c                                  |   28 +
 arch/arm64/net/bpf_jit_comp.c                                    |   12 
 arch/loongarch/include/asm/bootinfo.h                            |    4 
 arch/loongarch/include/asm/kasan.h                               |    2 
 arch/loongarch/kernel/process.c                                  |   16 
 arch/loongarch/kernel/setup.c                                    |    3 
 arch/loongarch/kernel/traps.c                                    |    5 
 arch/riscv/net/bpf_jit_comp64.c                                  |    8 
 arch/s390/include/asm/perf_event.h                               |    1 
 arch/s390/pci/pci_event.c                                        |   17 
 arch/x86/Kconfig                                                 |    1 
 arch/x86/events/rapl.c                                           |   47 ++
 arch/x86/include/asm/runtime-const.h                             |    4 
 arch/x86/include/asm/uaccess_64.h                                |   45 +-
 arch/x86/kernel/amd_nb.c                                         |    6 
 arch/x86/kernel/cpu/common.c                                     |   10 
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c                        |   23 -
 arch/x86/kernel/vmlinux.lds.S                                    |    1 
 arch/x86/kvm/svm/nested.c                                        |    6 
 arch/x86/lib/getuser.S                                           |    9 
 arch/x86/virt/svm/sev.c                                          |    2 
 block/elevator.c                                                 |   17 
 drivers/accel/qaic/qaic_control.c                                |    2 
 drivers/accel/qaic/qaic_data.c                                   |    6 
 drivers/acpi/button.c                                            |   11 
 drivers/acpi/cppc_acpi.c                                         |   22 -
 drivers/acpi/prmt.c                                              |   29 +
 drivers/acpi/resource.c                                          |    7 
 drivers/ata/libata-eh.c                                          |    1 
 drivers/cdrom/cdrom.c                                            |    2 
 drivers/clk/rockchip/clk.c                                       |    2 
 drivers/cpufreq/amd-pstate.c                                     |   10 
 drivers/firewire/core-topology.c                                 |    2 
 drivers/firmware/arm_scmi/driver.c                               |    4 
 drivers/firmware/arm_scmi/mailbox.c                              |   32 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                         |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                          |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c        |   13 
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c        |    2 
 drivers/gpu/drm/bridge/aux-bridge.c                              |    3 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                            |   16 
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c                         |   20 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                      |   68 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c             |    7 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c              |    5 
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c                |   19 
 drivers/gpu/drm/msm/dsi/dsi_host.c                               |    4 
 drivers/gpu/drm/panel/panel-himax-hx83102.c                      |   12 
 drivers/gpu/drm/vboxvideo/hgsmi_base.c                           |   10 
 drivers/gpu/drm/vboxvideo/vboxvideo.h                            |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c                             |    4 
 drivers/gpu/drm/xe/xe_device.c                                   |    4 
 drivers/gpu/drm/xe/xe_exec.c                                     |   12 
 drivers/gpu/drm/xe/xe_gpu_scheduler.h                            |    2 
 drivers/gpu/drm/xe/xe_gt_mcr.c                                   |    2 
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c                      |   29 -
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h                      |    1 
 drivers/gpu/drm/xe/xe_guc_submit.c                               |    7 
 drivers/gpu/drm/xe/xe_vm.c                                       |    8 
 drivers/hwmon/jc42.c                                             |    2 
 drivers/iio/accel/bma400_core.c                                  |    3 
 drivers/iio/adc/Kconfig                                          |    2 
 drivers/iio/frequency/Kconfig                                    |   33 -
 drivers/infiniband/core/addr.c                                   |    2 
 drivers/infiniband/hw/bnxt_re/hw_counters.c                      |    2 
 drivers/infiniband/hw/bnxt_re/ib_verbs.h                         |    1 
 drivers/infiniband/hw/bnxt_re/main.c                             |   29 -
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                         |   16 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                         |    3 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                       |    2 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                        |   21 -
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                         |   11 
 drivers/infiniband/hw/bnxt_re/qplib_sp.h                         |    1 
 drivers/infiniband/hw/cxgb4/cm.c                                 |    9 
 drivers/infiniband/hw/irdma/cm.c                                 |    2 
 drivers/infiniband/ulp/srpt/ib_srpt.c                            |   80 +++
 drivers/irqchip/irq-renesas-rzg2l.c                              |   16 
 drivers/irqchip/irq-riscv-imsic-platform.c                       |    2 
 drivers/md/raid10.c                                              |    7 
 drivers/net/dsa/microchip/ksz_common.c                           |   21 -
 drivers/net/dsa/mv88e6xxx/chip.c                                 |    2 
 drivers/net/dsa/mv88e6xxx/chip.h                                 |    6 
 drivers/net/dsa/mv88e6xxx/port.c                                 |    1 
 drivers/net/dsa/mv88e6xxx/ptp.c                                  |  108 +++--
 drivers/net/dsa/vitesse-vsc73xx-core.c                           |    1 
 drivers/net/ethernet/aeroflex/greth.c                            |    3 
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c                 |    1 
 drivers/net/ethernet/broadcom/bcmsysport.c                       |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                        |   22 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c                    |   70 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h                    |   12 
 drivers/net/ethernet/emulex/benet/be_main.c                      |   10 
 drivers/net/ethernet/freescale/fman/mac.c                        |   68 ++-
 drivers/net/ethernet/freescale/fman/mac.h                        |    6 
 drivers/net/ethernet/i825xx/sun3_82586.c                         |    1 
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c                |   82 ++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c              |    4 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                    |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                |    4 
 drivers/net/ethernet/mellanox/mlx5/core/eq.c                     |    6 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                |    5 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c            |    9 
 drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c            |   12 
 drivers/net/ethernet/realtek/r8169_main.c                        |    4 
 drivers/net/ethernet/renesas/ravb_main.c                         |   25 -
 drivers/net/ethernet/renesas/rtsn.c                              |    1 
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c                |   14 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                |    2 
 drivers/net/hyperv/netvsc_drv.c                                  |   30 +
 drivers/net/macsec.c                                             |   18 
 drivers/net/netdevsim/dev.c                                      |   15 
 drivers/net/phy/dp83822.c                                        |    4 
 drivers/net/plip/plip.c                                          |    2 
 drivers/net/pse-pd/pse_core.c                                    |    4 
 drivers/net/usb/usbnet.c                                         |    4 
 drivers/net/virtio_net.c                                         |    2 
 drivers/net/vmxnet3/vmxnet3_xdp.c                                |    2 
 drivers/net/wwan/wwan_core.c                                     |    2 
 drivers/nvme/host/pci.c                                          |   19 
 drivers/pci/probe.c                                              |    2 
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c                           |   58 ++
 drivers/platform/x86/dell/dell-wmi-base.c                        |    9 
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c               |    1 
 drivers/platform/x86/intel/pmc/core_ssram.c                      |    4 
 drivers/powercap/dtpm_devfreq.c                                  |    2 
 drivers/reset/starfive/reset-starfive-jh71x0.c                   |    3 
 drivers/soundwire/intel_ace2x.c                                  |   19 
 drivers/target/target_core_device.c                              |    2 
 drivers/target/target_core_user.c                                |    2 
 drivers/usb/host/xhci-dbgcap.h                                   |    2 
 drivers/usb/host/xhci-dbgtty.c                                   |   73 ++-
 drivers/usb/typec/class.c                                        |    3 
 drivers/video/fbdev/Kconfig                                      |    1 
 fs/9p/v9fs.h                                                     |   34 +
 fs/9p/v9fs_vfs.h                                                 |    2 
 fs/9p/vfs_inode.c                                                |  129 ++++--
 fs/9p/vfs_inode_dotl.c                                           |  112 ++++-
 fs/9p/vfs_super.c                                                |    2 
 fs/backing-file.c                                                |    8 
 fs/btrfs/block-group.c                                           |    2 
 fs/btrfs/dir-item.c                                              |    4 
 fs/btrfs/disk-io.c                                               |    2 
 fs/btrfs/extent_map.c                                            |   31 -
 fs/btrfs/inode.c                                                 |    7 
 fs/btrfs/qgroup.c                                                |    2 
 fs/btrfs/qgroup.h                                                |    2 
 fs/btrfs/super.c                                                 |   12 
 fs/fuse/passthrough.c                                            |    8 
 fs/jfs/jfs_dmap.c                                                |    2 
 fs/namespace.c                                                   |    4 
 fs/nfsd/nfs4state.c                                              |   50 ++
 fs/nfsd/state.h                                                  |    2 
 fs/nilfs2/page.c                                                 |    6 
 fs/notify/fsnotify.c                                             |   21 -
 fs/notify/inotify/inotify_user.c                                 |    2 
 fs/notify/mark.c                                                 |    8 
 fs/open.c                                                        |    2 
 fs/overlayfs/file.c                                              |    9 
 fs/select.c                                                      |    4 
 fs/smb/client/cifsfs.c                                           |    2 
 fs/smb/client/fs_context.c                                       |    7 
 fs/smb/client/reparse.c                                          |   23 +
 fs/smb/client/smb2ops.c                                          |    3 
 fs/smb/client/smb2pdu.c                                          |    9 
 fs/udf/balloc.c                                                  |   38 +
 fs/udf/directory.c                                               |   23 -
 fs/udf/inode.c                                                   |  202 ++++++----
 fs/udf/partition.c                                               |    6 
 fs/udf/super.c                                                   |    3 
 fs/udf/truncate.c                                                |   43 +-
 fs/udf/udfdecl.h                                                 |   15 
 fs/xfs/scrub/repair.c                                            |    8 
 include/linux/backing-file.h                                     |    2 
 include/linux/bpf.h                                              |   14 
 include/linux/bpf_types.h                                        |    1 
 include/linux/huge_mm.h                                          |   18 
 include/linux/netdevice.h                                        |   12 
 include/linux/shmem_fs.h                                         |   11 
 include/linux/task_work.h                                        |    5 
 include/linux/uaccess.h                                          |    7 
 include/net/bluetooth/bluetooth.h                                |    1 
 include/net/genetlink.h                                          |    3 
 include/net/sock.h                                               |    5 
 include/net/xfrm.h                                               |   28 -
 include/uapi/linux/bpf.h                                         |   16 
 include/uapi/sound/asoc.h                                        |    2 
 kernel/bpf/btf.c                                                 |   15 
 kernel/bpf/devmap.c                                              |   11 
 kernel/bpf/helpers.c                                             |   10 
 kernel/bpf/inode.c                                               |    5 
 kernel/bpf/log.c                                                 |    3 
 kernel/bpf/ringbuf.c                                             |   14 
 kernel/bpf/syscall.c                                             |   31 +
 kernel/bpf/task_iter.c                                           |    2 
 kernel/bpf/verifier.c                                            |  107 ++---
 kernel/sched/core.c                                              |    4 
 kernel/task_work.c                                               |   15 
 kernel/time/posix-clock.c                                        |    6 
 kernel/trace/bpf_trace.c                                         |   42 --
 kernel/trace/fgraph.c                                            |   15 
 kernel/trace/ring_buffer.c                                       |   44 +-
 kernel/trace/trace_eprobe.c                                      |    7 
 kernel/trace/trace_fprobe.c                                      |    6 
 kernel/trace/trace_kprobe.c                                      |    6 
 kernel/trace/trace_probe.c                                       |    2 
 kernel/trace/trace_uprobe.c                                      |   13 
 lib/Kconfig.debug                                                |    2 
 lib/objpool.c                                                    |    2 
 lib/strncpy_from_user.c                                          |    9 
 lib/strnlen_user.c                                               |    9 
 mm/huge_memory.c                                                 |   24 -
 mm/memory.c                                                      |    9 
 mm/shmem.c                                                       |   55 +-
 net/bluetooth/af_bluetooth.c                                     |   22 +
 net/bluetooth/bnep/core.c                                        |    3 
 net/bluetooth/hci_core.c                                         |   24 -
 net/bluetooth/hci_sync.c                                         |   12 
 net/bluetooth/iso.c                                              |   18 
 net/bluetooth/sco.c                                              |   18 
 net/core/filter.c                                                |   50 --
 net/core/sock_map.c                                              |    8 
 net/ipv4/devinet.c                                               |   35 +
 net/ipv4/inet_connection_sock.c                                  |   21 -
 net/ipv4/xfrm4_policy.c                                          |   40 -
 net/ipv6/xfrm6_policy.c                                          |   31 -
 net/l2tp/l2tp_netlink.c                                          |    4 
 net/netfilter/nf_bpf_link.c                                      |    7 
 net/netfilter/xt_NFLOG.c                                         |    2 
 net/netfilter/xt_TRACE.c                                         |    1 
 net/netfilter/xt_mark.c                                          |    2 
 net/netlink/genetlink.c                                          |   28 -
 net/sched/act_api.c                                              |   23 +
 net/sched/sch_generic.c                                          |    8 
 net/sched/sch_taprio.c                                           |   21 -
 net/smc/smc_pnet.c                                               |    2 
 net/smc/smc_wr.c                                                 |    6 
 net/vmw_vsock/virtio_transport_common.c                          |   14 
 net/vmw_vsock/vsock_bpf.c                                        |    8 
 net/wireless/nl80211.c                                           |    8 
 net/xfrm/xfrm_device.c                                           |   11 
 net/xfrm/xfrm_policy.c                                           |   50 +-
 net/xfrm/xfrm_user.c                                             |   10 
 sound/firewire/amdtp-stream.c                                    |    3 
 sound/pci/hda/Kconfig                                            |    2 
 sound/pci/hda/patch_cs8409.c                                     |    5 
 sound/pci/hda/patch_realtek.c                                    |   48 +-
 sound/soc/amd/yc/acp6x-mach.c                                    |    7 
 sound/soc/codecs/lpass-rx-macro.c                                |    2 
 sound/soc/codecs/max98388.c                                      |    1 
 sound/soc/fsl/fsl_micfil.c                                       |   43 ++
 sound/soc/fsl/fsl_sai.c                                          |    5 
 sound/soc/fsl/fsl_sai.h                                          |    1 
 sound/soc/loongson/loongson_card.c                               |    1 
 sound/soc/qcom/Kconfig                                           |    2 
 sound/soc/qcom/lpass-cpu.c                                       |    2 
 sound/soc/qcom/sc7280.c                                          |   10 
 sound/soc/qcom/sdm845.c                                          |    7 
 sound/soc/qcom/sm8250.c                                          |    1 
 sound/soc/sh/rcar/core.c                                         |    7 
 sound/soc/soc-dapm.c                                             |    4 
 sound/soc/sof/intel/hda-dai-ops.c                                |   23 -
 sound/soc/sof/intel/hda-dai.c                                    |   37 +
 sound/soc/sof/intel/hda-loader.c                                 |   17 
 sound/soc/sof/ipc4-topology.c                                    |   15 
 tools/include/uapi/linux/bpf.h                                   |    3 
 tools/testing/selftests/bpf/Makefile                             |    2 
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c          |    9 
 274 files changed, 2654 insertions(+), 1268 deletions(-)

Abel Vesa (1):
      drm/bridge: Fix assignment of the of_node of the parent to aux bridge

Abhishek Mohapatra (1):
      RDMA/bnxt_re: Fix the max CQ WQEs for older adapters

Aleksa Sarai (1):
      openat2: explicitly return -E2BIG for (usize > PAGE_SIZE)

Aleksandr Mishin (4):
      octeon_ep: Implement helper for iterating packets in Rx queue
      octeon_ep: Add SKB allocation failures handling in __octep_oq_process_rx()
      fsl/fman: Save device references taken in mac_probe()
      fsl/fman: Fix refcount handling of fman-related devices

Alexander Zubkov (1):
      RDMA/irdma: Fix misspelling of "accept*"

Alexey Klimov (3):
      ASoC: codecs: lpass-rx-macro: add missing CDC_RX_BCL_VBAT_RF_PROC2 to default regs values
      ASoC: qcom: sm8250: add qrb4210-rb2-sndcard compatible string
      ASoC: qcom: sdm845: add missing soundwire runtime stream alloc

Amadeusz Sławiński (1):
      ASoC: topology: Bump minimal topology ABI version

Amir Goldstein (2):
      fs: pass offset and result to backing_file end_write() callback
      fuse: update inode size after extending passthrough write

Andrea Parri (1):
      riscv, bpf: Make BPF_CMPXCHG fully ordered

Andrew Jones (1):
      irqchip/riscv-imsic: Fix output text of base address

Andrey Shumilin (1):
      ALSA: firewire-lib: Avoid division by zero in apply_constraint_to_size()

Andrii Nakryiko (1):
      bpf: fix do_misc_fixups() for bpf_get_branch_snapshot()

Anumula Murali Mohan Reddy (2):
      RDMA/core: Fix ENODEV error for iWARP test over vlan
      RDMA/cxgb4: Fix RDMA_CM_EVENT_UNREACHABLE error for iWARP

Armin Wolf (1):
      platform/x86: dell-wmi: Ignore suspend notifications

Arnd Bergmann (1):
      fbdev: wm8505fb: select CONFIG_FB_IOMEM_FOPS

Ashish Kalra (1):
      x86/sev: Ensure that RMP table fixups are reserved

Aurabindo Pillai (1):
      drm/amd/display: temp w/a for DP Link Layer compliance

Baolin Wang (2):
      mm: shmem: rename shmem_is_huge() to shmem_huge_global_enabled()
      mm: shmem: move shmem_huge_global_enabled() into shmem_allowable_huge_orders()

Bart Van Assche (1):
      RDMA/srpt: Make slab cache names unique

Bartosz Golaszewski (2):
      PCI: Hold rescan lock while adding devices during host probe
      PCI/pwrctl: Abandon QCom WCN probe on pre-pwrseq device-trees

Benjamin Bara (1):
      ASoC: dapm: avoid container_of() to get component

Bhargava Chenna Marreddy (1):
      RDMA/bnxt_re: Fix a bug while setting up Level-2 PBL pages

Binbin Zhou (1):
      ASoC: loongson: Fix component check failed on FDT systems

Boris Burkov (1):
      btrfs: fix read corruption due to race with extent map merging

Breno Leitao (2):
      elevator: do not request_module if elevator exists
      elevator: Remove argument from elevator_find_get

Chancel Liu (1):
      ASoC: fsl_micfil: Add a flag to distinguish with different volume control types

Chandramohan Akula (1):
      RDMA/bnxt_re: Change the sequence of updating the CQ toggle value

Changhuang Liang (1):
      reset: starfive: jh71x0: Fix accessing the empty member on JH7110 SoC

Christian Brauner (1):
      fs: don't try and remove empty rbtree node

Christian Heusel (1):
      ACPI: resource: Add LG 16T90SP to irq1_level_low_skip_override[]

Colin Ian King (2):
      octeontx2-af: Fix potential integer overflows on integer shifts
      ASoC: max98388: Fix missing increment of variable slot_found

Cong Yang (1):
      drm/panel: himax-hx83102: Adjust power and gamma to optimize brightness

Cosmin Ratiu (2):
      net/mlx5: Unregister notifier on eswitch init failure
      net/mlx5e: Don't call cleanup on profile rollback failure

Crag Wang (1):
      platform/x86: dell-sysman: add support for alienware products

Dan Carpenter (1):
      ACPI: PRM: Clean up guid type in struct prm_handler_info

Daniel Borkmann (6):
      vmxnet3: Fix packet corruption in vmxnet3_xdp_xmit_frame
      bpf: Fix incorrect delta propagation between linked registers
      bpf: Fix print_reg_state's constant scalar dump
      bpf: Add MEM_WRITE attribute
      bpf: Fix overloading of MEM_UNINIT's meaning
      bpf: Remove MEM_UNINIT from skb/xdp MTU helpers

Daniel Machon (1):
      net: sparx5: fix source port register when mirroring

Darrick J. Wong (1):
      xfs: don't fail repairs on metadata files with no attr fork

Dave Kleikamp (1):
      jfs: Fix sanity check in dbMount

David Hildenbrand (1):
      mm: don't install PMD mappings when THPs are disabled by the hw/process/vma

David Lawrence Glanzman (1):
      ASoC: amd: yc: Add quirk for HP Dragonfly pro one

Dhananjay Ugwekar (2):
      cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory systems
      perf/x86/rapl: Fix the energy-pkg event for AMD CPUs

Dimitar Kanaliev (1):
      bpf: Fix truncation bug in coerce_reg_to_size_sx()

Dmitry Antipov (2):
      net: sched: fix use-after-free in taprio_change()
      net: sched: use RCU read-side critical section in taprio_dump()

Dmitry Baryshkov (3):
      drm/msm/dpu: make sure phys resources are properly initialized
      drm/msm/dpu: move CRTC resource assignment to dpu_encoder_virt_atomic_check
      drm/msm/dpu: check for overflow in _dpu_crtc_setup_lm_bounds()

Dominique Martinet (4):
      Revert " fs/9p: mitigate inode collisions"
      Revert "fs/9p: remove redundant pointer v9ses"
      Revert "fs/9p: fix uaf in in v9fs_stat2inode_dotl"
      Revert "fs/9p: simplify iget to remove unnecessary paths"

Douglas Anderson (2):
      drm/msm: Avoid NULL dereference in msm_disp_state_print_regs()
      drm/msm: Allocate memory for disp snapshot with kvzalloc()

Eduard Zingerman (1):
      bpf: sync_linked_regs() must preserve subreg_def

Eric Biggers (1):
      ALSA: hda/tas2781: select CRC32 instead of CRC32_SARWATE

Eric Dumazet (3):
      netdevsim: use cond_resched() in nsim_dev_trap_report_work()
      genetlink: hold RCU in genlmsg_mcast()
      net: fix races in netdev_tx_sent_queue()/dev_watchdog()

Eyal Birger (2):
      xfrm: extract dst lookup parameters into a struct
      xfrm: respect ip protocols rules criteria when performing dst lookups

Fabrizio Castro (1):
      irqchip/renesas-rzg2l: Fix missing put_device

Felix Fietkau (1):
      net: ethernet: mtk_eth_soc: fix memory corruption during fq dma init

Filipe Manana (1):
      btrfs: clear force-compress on remount when compress mount option is given

Florian Kauer (1):
      bpf: devmap: provide rxq after redirect

Florian Klink (1):
      ARM: dts: bcm2837-rpi-cm3-io3: Fix HDMI hpd-gpio pin

Florian Westphal (1):
      netfilter: bpf: must hold reference on net namespace

Gal Pressman (1):
      ravb: Remove setting of RX software timestamp

Gianfranco Trad (1):
      udf: fix uninit-value use in udf_get_fileshortad

Greg Kroah-Hartman (1):
      Linux 6.11.6

Gustavo Sousa (1):
      drm/xe/mcr: Use Xe2_LPM steering tables for Xe2_HPM

Haiyang Zhang (1):
      hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event

Hans de Goede (1):
      drm/vboxvideo: Replace fake VLA at end of vbva_mouse_pointer_shape with real VLA

Heiko Carstens (1):
      s390: Initialize psw mask in perf_arch_fetch_caller_regs()

Heiner Kallweit (1):
      r8169: avoid unsolicited interrupts

Henrique Carvalho (1):
      smb: client: Handle kstrdup failures for passwords

Hongguang Gao (1):
      RDMA/bnxt_re: Get the toggle bits from SRQ events

Hou Tao (3):
      bpf: Check the remaining info_cnt before repeating btf fields
      bpf: Preserve param->string when parsing mount options
      bpf: Add the missing BPF_LINK_TYPE invocation for sockmap

Huacai Chen (3):
      LoongArch: Get correct cores_per_package for SMT systems
      LoongArch: Enable IRQ if do_ale() triggered in irq-enabled context
      LoongArch: Make KASAN usable for variable cpu_vabits

Ian Forbes (1):
      drm/vmwgfx: Handle possible ENOMEM in vmw_stdu_connector_atomic_check

Ilkka Koskinen (1):
      KVM: arm64: Fix shift-out-of-bounds bug

Jakub Boehm (1):
      net: plip: fix break; causing plip to never transmit

Jan Kara (1):
      fsnotify: Avoid data race between fsnotify_recalc_mask() and fsnotify_object_watched()

Javier Carrasco (3):
      iio: frequency: {admv4420,adrf6780}: format Kconfig entries
      iio: frequency: admv4420: fix missing select REMAP_SPI in Kconfig
      iio: adc: ti-lmp92064: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig

Jean Delvare (1):
      [PATCH} hwmon: (jc42) Properly detect TSE2004-compliant devices again

Jessica Zhang (2):
      drm/msm/dpu: Don't always set merge_3d pending flush
      drm/msm/dpu: don't always program merge_3d block

Jinjie Ruan (1):
      posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime()

Jiri Olsa (2):
      bpf: Fix memory leak in bpf_core_apply
      bpf,perf: Fix perf_event_detach_bpf_prog error handling

Jiri Slaby (SUSE) (2):
      xhci: dbgtty: remove kfifo_out() wrapper
      xhci: dbgtty: use kfifo from tty_port struct

Jonathan Marek (2):
      drm/msm/dsi: improve/fix dsc pclk calculation
      drm/msm/dsi: fix 32-bit signed integer extension in pclk_rate calculation

Jordan Rome (1):
      bpf: Fix iter/task tid filtering

Josh Poimboeuf (1):
      cdrom: Avoid barrier_nospec() in cdrom_ioctl_media_changed()

José Relvas (1):
      ALSA: hda/realtek: Add subwoofer quirk for Acer Predator G9-593

Justin Chen (1):
      firmware: arm_scmi: Queue in scmi layer for mailbox implementation

Kai Shen (1):
      net/smc: Fix memory leak when using percpu refs

Kai Vehmanen (1):
      ASoC: SOF: Intel: hda-loader: do not wait for HDaudio IOC

Kailang Yang (1):
      ALSA: hda/realtek: Update default depop procedure

Kalesh AP (5):
      RDMA/bnxt_re: Fix a possible memory leak
      RDMA/bnxt_re: Add a check for memory allocation
      RDMA/bnxt_re: Fix out of bound check
      RDMA/bnxt_re: Return more meaningful error
      RDMA/bnxt_re: Fix the GID table length

Kashyap Desai (1):
      RDMA/bnxt_re: Fix incorrect dereference of srq in async event

Kefeng Wang (1):
      mm: huge_memory: add vma_thp_disabled() and thp_disabled_by_hw()

Koba Ko (1):
      ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and context

Konrad Dybcio (1):
      PCI/pwrctl: Add WCN6855 support

Kory Maincent (1):
      net: pse-pd: Fix out of bound for loop

Krzysztof Kozlowski (2):
      ASoC: qcom: sc7280: Fix missing Soundwire runtime stream alloc
      ASoC: qcom: Select missing common Soundwire module code on SDM845

Kuniyuki Iwashima (1):
      tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().

Lad Prabhakar (1):
      ASoC: rsnd: Fix probe failure on HiHope boards due to endpoint parsing

Leo Yan (1):
      tracing: Consider the NULL character when validating the event length

Li Huafei (1):
      fgraph: Fix missing unlock in register_ftrace_graph()

Li RongQing (1):
      net/smc: Fix searching in list of known pnetids in smc_pnet_add_pnetid

Lin Ma (1):
      net: wwan: fix global oob in wwan_rtnl_policy

Linus Torvalds (3):
      x86: support user address masking instead of non-speculative conditional
      x86: fix whitespace in runtime-const assembler output
      x86: fix user address masking non-canonical speculation issue

Luiz Augusto von Dentz (3):
      Bluetooth: hci_core: Disable works on hci_unregister_dev
      Bluetooth: SCO: Fix UAF on sco_sock_timeout
      Bluetooth: ISO: Fix UAF on iso_sock_timeout

Maher Sanalla (1):
      net/mlx5: Check for invalid vector index on EQ creation

Marc Zyngier (1):
      KVM: arm64: Don't eagerly teardown the vgic on init error

Mario Limonciello (2):
      drm/amd: Guard against bad data for ATIF ACPI method
      drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too

Mark Rutland (1):
      arm64: Force position-independent veneers

Martin Kletzander (1):
      x86/resctrl: Avoid overflow in MB settings in bw_validate()

Mathias Nyman (1):
      xhci: dbc: honor usb transfer size boundaries.

Matthew Auld (2):
      drm/xe: fix unbalanced rpm put() with fence_fini()
      drm/xe: fix unbalanced rpm put() with declare_wedged()

Matthew Brost (3):
      drm/xe: Take job list lock in xe_sched_add_pending_job
      drm/xe: Don't free job in TDR
      drm/xe: Use bookkeep slots for external BO's in exec IOCTL

Maurizio Lombardi (1):
      nvme-pci: fix race condition between reset and nvme_dev_disable()

Michael S. Tsirkin (1):
      virtio_net: fix integer overflow in stats

Michal Luczaj (4):
      bpf, sockmap: SK_DROP on attempted redirects of unsupported af_vsock
      vsock: Update rx_bytes on read_skb()
      vsock: Update msg_count on read_skb()
      bpf, vsock: Drop static vsock_bpf_prot initialization

Michel Alex (1):
      net: phy: dp83822: Fix reset pin definitions

Mikel Rychliski (1):
      tracing/probes: Fix MAX_TRACE_ARGS limit handling

Mikhail Lobanov (1):
      iio: accel: bma400: Fix uninitialized variable field_value in tap event handling.

Miquel Raynal (2):
      ASoC: dt-bindings: davinci-mcasp: Fix interrupts property
      ASoC: dt-bindings: davinci-mcasp: Fix interrupt properties

Murad Masimov (1):
      ALSA: hda/cs8409: Fix possible NULL dereference

Naohiro Aota (1):
      btrfs: zoned: fix zone unusable accounting for freed reserved extent

Niklas Cassel (1):
      ata: libata: Set DID_TIME_OUT for commands that actually timed out

Niklas Schnelle (1):
      s390/pci: Handle PCI error codes other than 0x3a

Niklas Söderlund (1):
      net: ravb: Only advertise Rx/Tx timestamps if hardware supports it

Olga Kornievskaia (1):
      nfsd: fix race between laundromat and free_stateid

Oliver Neukum (2):
      net: usb: usbnet: fix race in probe failure
      net: usb: usbnet: fix name regression

Oliver Upton (1):
      KVM: arm64: Unregister redistributor for failed vCPU creation

Pablo Neira Ayuso (1):
      netfilter: xtables: fix typo causing some targets not to load on IPv6

Pali Rohár (1):
      cifs: Validate content of NFS reparse point buffer

Paritosh Dixit (1):
      net: stmmac: dwmac-tegra: Fix link bring-up sequence

Paulo Alcantara (1):
      smb: client: fix OOBs when building SMB2_IOCTL request

Pawan Gupta (1):
      x86/lam: Disable ADDRESS_MASKING in most cases

Peter Collingbourne (1):
      bpf, arm64: Fix address emission with tag-based KASAN enabled

Peter Rashleigh (2):
      net: dsa: mv88e6xxx: Fix the max_vid definition for the MV88E6361
      net: dsa: mv88e6xxx: Fix error when setting port policy on mv88e6393x

Petr Pavlu (1):
      ring-buffer: Fix reader locking when changing the sub buffer order

Petr Vaganov (1):
      xfrm: fix one more kernel-infoleak in algo dumping

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Fix the for loop used to walk SG table

Pu Lehui (1):
      riscv, bpf: Fix possible infinite tailcall when CONFIG_CFI_CLANG is enabled

Qiao Ma (1):
      uprobe: avoid out-of-bounds memory access of fetching args

Qu Wenruo (2):
      btrfs: qgroup: set a more sane default value for subtree drop threshold
      btrfs: reject ro->rw reconfiguration if there are hard ro requirements

Ranjani Sridharan (4):
      ASoC: SOF: Intel: hda: Handle prepare without close for non-HDA DAI's
      ASoC: SOF: Intel: hda: Always clean up link DMA during stop
      ASoC: SOF: ipc4-topology: Do not set ALH node_id for aggregated DAIs
      soundwire: intel_ace2x: Send PDI stream number during prepare

Richard Gong (2):
      x86/amd_nb: Add new PCI IDs for AMD family 1Ah model 60h-70h
      x86/amd_nb: Add new PCI ID for AMD family 1Ah model 20h

Rob Clark (1):
      drm/msm/a6xx+: Insert a fence wait before SMMU table update

Ryusuke Konishi (1):
      nilfs2: fix kernel bug due to missing clearing of buffer delay flag

Sabrina Dubroca (2):
      macsec: don't increment counters for an unrelated SA
      xfrm: validate new SA's prefixlen using SA family when sel.family is unset

Saravanan Vajravel (1):
      RDMA/bnxt_re: Fix incorrect AVID type in WQE structure

Sean Christopherson (1):
      KVM: nSVM: Ignore nCR3[4:0] when loading PDPTEs from memory

Selvin Xavier (1):
      RDMA/bnxt_re: Avoid CPU lockups due fifo occupancy check loop

Shay Drory (1):
      net/mlx5: Fix command bitmask initialization

Shenghao Yang (3):
      net: dsa: mv88e6xxx: group cycle counter coefficients
      net: dsa: mv88e6xxx: read cycle counter period from hardware
      net: dsa: mv88e6xxx: support 4000ps cycle counter period

Shengjiu Wang (1):
      ASoC: fsl_sai: Enable 'FIFO continue on error' FCONT bit

Shubham Panwar (1):
      ACPI: button: Add DMI quirk for Samsung Galaxy Book2 to fix initial lid detection issue

Srinivasan Shanmugam (1):
      drm/amd/amdgpu: Fix double unlock in amdgpu_mes_add_ring

Steven Rostedt (2):
      fgraph: Allocate ret_stack_list with proper size
      fgraph: Change the name of cpuhp state to "fgraph:online"

Su Hui (2):
      firmware: arm_scmi: Fix the double free in scmi_debugfs_common_setup()
      smb: client: fix possible double free in smb2_set_ea()

Takashi Sakamoto (1):
      firewire: core: fix invalid port index for parent device

Thadeu Lima de Souza Cascardo (1):
      usb: typec: altmode should keep reference to parent

Thomas Weißschuh (1):
      LoongArch: Don't crash in stack_top() for tasks without vDSO

Tim Harvey (1):
      net: dsa: microchip: disable EEE for KSZ879x/KSZ877x/KSZ876x

Timo Grautstueck (1):
      lib/Kconfig.debug: fix grammar in RUST_BUILD_ASSERT_ALLOW

Toke Høiland-Jørgensen (2):
      bpf: Make sure internal and UAPI bpf_redirect flags don't overlap
      bpf: fix kfunc btf caching for modules

Tony Ambardar (1):
      selftests/bpf: Fix cross-compiling urandom_read

Tyrone Wu (4):
      bpf: fix unpopulated name_len field in perf_event link info
      selftests/bpf: fix perf_event link info name_len assertion
      bpf: Fix unpopulated path_size when uprobe_multi fields unset
      bpf: Fix link info netfilter flags to populate defrag flag

Vadim Fedorenko (1):
      bnxt_en: replace ptp_lock with irqsave variant

Vamsi Krishna Brahmajosyula (1):
      platform/x86/intel/pmc: Fix pmc_core_iounmap to call iounmap for valid addresses

Viktor Malik (1):
      objpool: fix choosing allocation for percpu slots

Vladimir Oltean (2):
      net: dsa: vsc73xx: fix reception from VLAN-unaware bridges
      net/sched: act_api: deny mismatched skip_sw/skip_hw flags for actions created by classifiers

Waiman Long (1):
      sched/core: Disable page allocation in task_tick_mm_cid()

Wander Lairson Costa (1):
      bpf: Use raw_spinlock_t in ringbuf

Wang Hai (8):
      net: ethernet: aeroflex: fix potential memory leak in greth_start_xmit_gbit()
      net: xilinx: axienet: fix potential memory leak in axienet_start_xmit()
      net: ethernet: rtsn: fix potential memory leak in rtsn_start_xmit()
      net: systemport: fix potential memory leak in bcm_sysport_xmit()
      net: bcmasp: fix potential memory leak in bcmasp_xmit()
      scsi: target: core: Fix null-ptr-deref in target_alloc_device()
      net/sun3_82586: fix potential memory leak in sun3_82586_send_packet()
      be2net: fix potential memory leak in be_xmit()

Xin Long (1):
      ipv4: give an IPv4 dev to blackhole_netdev

Yang Erkun (1):
      nfsd: cancel nfsd_shrinker_work using sync mode in nfs4_state_shutdown_net

Yao Zi (1):
      clk: rockchip: fix finding of maximum clock ID

Ye Bin (2):
      Bluetooth: bnep: fix wild-memory-access in proto_unregister
      cifs: fix warning when destroy 'cifs_io_request_pool'

Yu Kuai (1):
      md/raid10: fix null ptr dereference in raid10_size()

Yuan Can (2):
      mlxsw: spectrum_router: fix xa_store() error checking
      powercap: dtpm_devfreq: Fix error check against dev_pm_qos_add_request()

Yue Haibing (1):
      btrfs: fix passing 0 to ERR_PTR in btrfs_search_dir_index_item()

Zhao Mengmeng (3):
      udf: refactor udf_current_aext() to handle error
      udf: refactor udf_next_aext() to handle error
      udf: refactor inode_bmap() to handle error

Zichen Xie (1):
      ASoC: qcom: Fix NULL Dereference in asoc_qcom_lpass_cpu_platform_probe()

liwei (1):
      cpufreq: CPPC: fix perf_to_khz/khz_to_perf conversion exception


