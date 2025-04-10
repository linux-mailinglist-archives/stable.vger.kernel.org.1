Return-Path: <stable+bounces-132107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCC6A843FD
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4F319E4DB1
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 13:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270B6284B4E;
	Thu, 10 Apr 2025 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mGedEbyG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB2C2857C7;
	Thu, 10 Apr 2025 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290283; cv=none; b=NMKqBCRci4WX/DIBQhEPTi9sivNbl8oO7MqUNut5NK5ySoF2YUqX4o5UDkmvi18EZRMAMfxqp/7pUEWA0dITjVsL0QnJE/htkCZD+DhWSbatJRUeoPKM+jbPRQLDgQ8zIV69DSDV/T4w9PaGPnKJNpjIOQWCs7Ykor2UoipbWsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290283; c=relaxed/simple;
	bh=xZnGooKHzmG2YA7FDX3EzG99rM3rTSWEP1wndfRci7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SrQvBcbt16om0STT/aG15IrUjWt/Wv2XdKmPFDLup7W+0z3TDH6fG0HX60/p6iozNB6JRKWBNJmfhuNy2cArVuIQrYTF1yiRvsOHGzqjans0G80Letzk/0XvNoCVLpCl5Udb49hHFZJUmOh95xxpFowrSJ5DzlI/MOTfgoZQ6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mGedEbyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A194FC4CEDD;
	Thu, 10 Apr 2025 13:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744290282;
	bh=xZnGooKHzmG2YA7FDX3EzG99rM3rTSWEP1wndfRci7g=;
	h=From:To:Cc:Subject:Date:From;
	b=mGedEbyGFmMsVBn5YzO22rMqQ9ASxTWCRDi5P42J4xduZI7oAZ2kwXQI1tsIVqi8E
	 gDaKDJLi/A2o3HJ6CQHSgCKnYyn6vB1Fmjdt3el9Cj6IaE+OH5u+vXDrgVkTlBVaks
	 WDW5hMDTIU7RSAlBLwRppYYAlCccEyyCT73B7xSQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.87
Date: Thu, 10 Apr 2025 15:03:01 +0200
Message-ID: <2025041002-partly-deuce-8e99@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.87 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/vendor-prefixes.yaml         |    2 
 Makefile                                                       |    2 
 arch/arm64/kernel/compat_alignment.c                           |    2 
 arch/loongarch/Kconfig                                         |    4 
 arch/loongarch/include/asm/cache.h                             |    2 
 arch/loongarch/kernel/kgdb.c                                   |    5 
 arch/loongarch/net/bpf_jit.c                                   |   12 
 arch/loongarch/net/bpf_jit.h                                   |    5 
 arch/powerpc/configs/mpc885_ads_defconfig                      |    2 
 arch/powerpc/platforms/cell/spufs/gang.c                       |    1 
 arch/powerpc/platforms/cell/spufs/inode.c                      |   63 ++-
 arch/powerpc/platforms/cell/spufs/spufs.h                      |    2 
 arch/riscv/errata/Makefile                                     |    6 
 arch/riscv/include/asm/ftrace.h                                |    4 
 arch/riscv/kvm/vcpu_pmu.c                                      |    1 
 arch/riscv/mm/hugetlbpage.c                                    |   76 ++-
 arch/um/include/shared/os.h                                    |    1 
 arch/um/kernel/Makefile                                        |    2 
 arch/um/kernel/maccess.c                                       |   19 
 arch/um/os-Linux/process.c                                     |   51 --
 arch/x86/Kconfig                                               |    2 
 arch/x86/entry/calling.h                                       |    2 
 arch/x86/events/intel/core.c                                   |   43 +-
 arch/x86/events/intel/ds.c                                     |   13 
 arch/x86/events/perf_event.h                                   |    3 
 arch/x86/hyperv/hv_vtl.c                                       |    1 
 arch/x86/hyperv/ivm.c                                          |    5 
 arch/x86/include/asm/tlbflush.h                                |    2 
 arch/x86/kernel/cpu/microcode/amd.c                            |    2 
 arch/x86/kernel/cpu/sgx/driver.c                               |   10 
 arch/x86/kernel/dumpstack.c                                    |    5 
 arch/x86/kernel/fpu/core.c                                     |    6 
 arch/x86/kernel/process.c                                      |    7 
 arch/x86/kernel/traps.c                                        |   18 
 arch/x86/kernel/tsc.c                                          |    4 
 arch/x86/lib/copy_user_64.S                                    |   18 
 arch/x86/mm/mem_encrypt_identity.c                             |    4 
 arch/x86/mm/pat/cpa-test.c                                     |    2 
 arch/x86/mm/pat/memtype.c                                      |   52 +-
 drivers/acpi/nfit/core.c                                       |    2 
 drivers/acpi/processor_idle.c                                  |    4 
 drivers/acpi/resource.c                                        |    7 
 drivers/acpi/x86/utils.c                                       |    3 
 drivers/base/power/main.c                                      |   21 -
 drivers/base/power/runtime.c                                   |    2 
 drivers/clk/imx/clk-imx8mp-audiomix.c                          |    6 
 drivers/clk/meson/g12a.c                                       |   38 +
 drivers/clk/meson/gxbb.c                                       |   14 
 drivers/clk/qcom/gcc-msm8953.c                                 |    2 
 drivers/clk/qcom/mmcc-sdm660.c                                 |    2 
 drivers/clk/rockchip/clk-rk3328.c                              |    2 
 drivers/clk/samsung/clk.c                                      |    2 
 drivers/cpufreq/cpufreq_governor.c                             |   45 +-
 drivers/cpufreq/scpi-cpufreq.c                                 |    5 
 drivers/crypto/hisilicon/sec2/sec.h                            |    1 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                     |  125 ++----
 drivers/crypto/nx/nx-common-pseries.c                          |   37 -
 drivers/dma/fsl-edma-main.c                                    |    2 
 drivers/edac/i10nm_base.c                                      |    2 
 drivers/edac/ie31200_edac.c                                    |   19 
 drivers/edac/skx_common.c                                      |   33 +
 drivers/edac/skx_common.h                                      |   11 
 drivers/firmware/cirrus/cs_dsp.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                        |   11 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                         |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c          |   15 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c         |   16 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |    5 
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c          |    3 
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c          |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c |   12 
 drivers/gpu/drm/bridge/ite-it6505.c                            |    7 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                          |    2 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                  |    8 
 drivers/gpu/drm/mediatek/mtk_dp.c                              |    6 
 drivers/gpu/drm/mediatek/mtk_dsi.c                             |    6 
 drivers/gpu/drm/mediatek/mtk_hdmi.c                            |   33 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c                       |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                    |    3 
 drivers/gpu/drm/msm/dsi/dsi_host.c                             |    8 
 drivers/gpu/drm/msm/dsi/dsi_manager.c                          |   32 +
 drivers/gpu/drm/msm/msm_dsc_helper.h                           |   11 
 drivers/gpu/drm/vkms/vkms_drv.c                                |   15 
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                            |    2 
 drivers/hid/Makefile                                           |    1 
 drivers/hid/i2c-hid/i2c-hid-core.c                             |    2 
 drivers/hwmon/nct6775-core.c                                   |    4 
 drivers/hwtracing/coresight/coresight-catu.c                   |    2 
 drivers/hwtracing/coresight/coresight-core.c                   |   20 
 drivers/hwtracing/coresight/coresight-etm4x-core.c             |   48 ++
 drivers/i3c/master/svc-i3c-master.c                            |    2 
 drivers/iio/accel/mma8452.c                                    |   10 
 drivers/iio/accel/msa311.c                                     |   26 -
 drivers/iio/adc/ad4130.c                                       |   41 +-
 drivers/iio/adc/ad7124.c                                       |   35 +
 drivers/infiniband/core/device.c                               |    9 
 drivers/infiniband/core/mad.c                                  |   38 -
 drivers/infiniband/core/sysfs.c                                |    1 
 drivers/infiniband/hw/erdma/erdma_cm.c                         |    1 
 drivers/infiniband/hw/mana/main.c                              |    2 
 drivers/infiniband/hw/mlx5/cq.c                                |    2 
 drivers/infiniband/hw/mlx5/odp.c                               |   10 
 drivers/leds/led-core.c                                        |   22 -
 drivers/media/dvb-frontends/dib8000.c                          |    5 
 drivers/media/platform/allegro-dvt/allegro-core.c              |    1 
 drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c        |    1 
 drivers/media/rc/streamzap.c                                   |    2 
 drivers/memory/omap-gpmc.c                                     |   20 
 drivers/mfd/sm501.c                                            |    6 
 drivers/mmc/host/omap.c                                        |   19 
 drivers/mmc/host/sdhci-omap.c                                  |    4 
 drivers/mmc/host/sdhci-pxav3.c                                 |    1 
 drivers/net/arcnet/com20020-pci.c                              |   17 
 drivers/net/dsa/mv88e6xxx/chip.c                               |   11 
 drivers/net/dsa/mv88e6xxx/phy.c                                |    3 
 drivers/net/ethernet/ibm/ibmveth.c                             |   39 +
 drivers/net/ethernet/intel/e1000e/defines.h                    |    3 
 drivers/net/ethernet/intel/e1000e/ich8lan.c                    |   80 +++
 drivers/net/ethernet/intel/e1000e/ich8lan.h                    |    4 
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h                     |    3 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                |    3 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c                 |  201 ++++++----
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c            |    8 
 drivers/net/usb/rndis_host.c                                   |   16 
 drivers/net/usb/usbnet.c                                       |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c      |   20 
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                    |   86 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                  |    8 
 drivers/ntb/hw/intel/ntb_hw_gen3.c                             |    3 
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c                         |    2 
 drivers/ntb/test/ntb_perf.c                                    |    4 
 drivers/nvme/host/pci.c                                        |   34 +
 drivers/nvme/host/tcp.c                                        |    5 
 drivers/pci/controller/cadence/pcie-cadence-ep.c               |    3 
 drivers/pci/controller/cadence/pcie-cadence.h                  |    2 
 drivers/pci/controller/dwc/pcie-histb.c                        |   12 
 drivers/pci/controller/pcie-brcmstb.c                          |    9 
 drivers/pci/controller/pcie-xilinx-cpm.c                       |   10 
 drivers/pci/hotplug/pciehp_hpc.c                               |    4 
 drivers/pci/pci.c                                              |    4 
 drivers/pci/pcie/aspm.c                                        |   17 
 drivers/pci/pcie/portdrv.c                                     |    8 
 drivers/pci/probe.c                                            |    5 
 drivers/pci/setup-bus.c                                        |    3 
 drivers/pinctrl/intel/pinctrl-intel.c                          |    1 
 drivers/pinctrl/renesas/pinctrl-rza2.c                         |    2 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                        |    2 
 drivers/pinctrl/renesas/pinctrl-rzv2m.c                        |    2 
 drivers/pinctrl/tegra/pinctrl-tegra.c                          |    3 
 drivers/platform/x86/dell/dell-wmi-ddv.c                       |    6 
 drivers/platform/x86/intel/hid.c                               |    7 
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c    |    2 
 drivers/platform/x86/intel/vsec.c                              |    7 
 drivers/power/supply/max77693_charger.c                        |    2 
 drivers/remoteproc/qcom_q6v5_mss.c                             |   21 -
 drivers/remoteproc/qcom_q6v5_pas.c                             |   12 
 drivers/remoteproc/remoteproc_core.c                           |    1 
 drivers/scsi/qla2xxx/qla_os.c                                  |    2 
 drivers/soundwire/slave.c                                      |    1 
 drivers/staging/rtl8723bs/Kconfig                              |    1 
 drivers/thermal/intel/int340x_thermal/int3402_thermal.c        |    3 
 drivers/tty/n_tty.c                                            |   13 
 drivers/usb/host/xhci-mem.c                                    |    6 
 drivers/usb/typec/ucsi/ucsi_ccg.c                              |    5 
 drivers/vhost/scsi.c                                           |   25 -
 drivers/video/console/Kconfig                                  |    2 
 drivers/video/fbdev/au1100fb.c                                 |    4 
 drivers/video/fbdev/sm501fb.c                                  |    7 
 fs/affs/file.c                                                 |    9 
 fs/btrfs/extent-tree.c                                         |    5 
 fs/exec.c                                                      |   15 
 fs/exfat/fatent.c                                              |    2 
 fs/ext4/dir.c                                                  |    3 
 fs/ext4/super.c                                                |   27 -
 fs/fuse/dax.c                                                  |    1 
 fs/fuse/dir.c                                                  |    2 
 fs/fuse/file.c                                                 |    4 
 fs/hostfs/hostfs.h                                             |    2 
 fs/hostfs/hostfs_kern.c                                        |    7 
 fs/hostfs/hostfs_user.c                                        |   59 +-
 fs/isofs/dir.c                                                 |    3 
 fs/jfs/jfs_dtree.c                                             |    3 
 fs/jfs/xattr.c                                                 |   15 
 fs/nfs/delegation.c                                            |   33 -
 fs/nfs/sysfs.c                                                 |   22 +
 fs/nfsd/nfs4state.c                                            |   31 +
 fs/ntfs3/index.c                                               |    4 
 fs/ntfs3/ntfs.h                                                |    2 
 fs/ocfs2/alloc.c                                               |    8 
 fs/proc/base.c                                                 |    2 
 fs/smb/client/cifsacl.c                                        |    8 
 fs/smb/client/connect.c                                        |   16 
 fs/smb/server/auth.c                                           |    6 
 fs/smb/server/mgmt/user_session.c                              |   33 +
 fs/smb/server/mgmt/user_session.h                              |    2 
 fs/smb/server/oplock.c                                         |   12 
 fs/smb/server/smb2pdu.c                                        |   40 +
 fs/smb/server/smbacl.c                                         |    5 
 include/drm/display/drm_dp_mst_helper.h                        |    7 
 include/linux/context_tracking_irq.h                           |    8 
 include/linux/coresight.h                                      |    4 
 include/linux/fwnode.h                                         |    2 
 include/linux/interrupt.h                                      |    8 
 include/linux/pgtable.h                                        |   28 +
 include/linux/pm_runtime.h                                     |    2 
 include/linux/rcupdate.h                                       |    2 
 include/linux/sched/smt.h                                      |    2 
 include/linux/trace.h                                          |    4 
 include/linux/trace_events.h                                   |   14 
 include/rdma/ib_verbs.h                                        |    1 
 kernel/events/core.c                                           |   46 +-
 kernel/events/ring_buffer.c                                    |    2 
 kernel/events/uprobes.c                                        |   13 
 kernel/fork.c                                                  |    4 
 kernel/kexec_elf.c                                             |    2 
 kernel/locking/semaphore.c                                     |   13 
 kernel/sched/deadline.c                                        |    2 
 kernel/trace/bpf_trace.c                                       |    2 
 kernel/trace/ring_buffer.c                                     |    4 
 kernel/trace/trace.c                                           |   23 -
 kernel/trace/trace.h                                           |    1 
 kernel/trace/trace_boot.c                                      |    2 
 kernel/trace/trace_events.c                                    |   62 ++-
 kernel/trace/trace_events_hist.c                               |  133 +++++-
 kernel/trace/trace_events_synth.c                              |   36 +
 kernel/trace/trace_functions_graph.c                           |    1 
 kernel/trace/trace_irqsoff.c                                   |    2 
 kernel/trace/trace_osnoise.c                                   |    1 
 kernel/trace/trace_sched_wakeup.c                              |    2 
 kernel/watch_queue.c                                           |    9 
 lib/842/842_compress.c                                         |    2 
 lib/overflow_kunit.c                                           |    3 
 mm/memory.c                                                    |   13 
 net/can/af_can.c                                               |   12 
 net/can/af_can.h                                               |   12 
 net/can/proc.c                                                 |   46 +-
 net/core/dst.c                                                 |    8 
 net/core/rtnetlink.c                                           |    3 
 net/ipv4/ip_tunnel_core.c                                      |    4 
 net/ipv4/udp.c                                                 |   16 
 net/ipv6/addrconf.c                                            |   37 +
 net/ipv6/calipso.c                                             |   21 -
 net/ipv6/route.c                                               |   42 +-
 net/mac80211/sta_info.c                                        |   20 
 net/netfilter/nf_tables_api.c                                  |    4 
 net/netfilter/nft_set_hash.c                                   |    3 
 net/netfilter/nft_tunnel.c                                     |    6 
 net/openvswitch/actions.c                                      |    6 
 net/sched/act_tunnel_key.c                                     |    2 
 net/sched/cls_flower.c                                         |    2 
 net/sched/sch_skbprio.c                                        |    3 
 net/vmw_vsock/af_vsock.c                                       |    6 
 samples/ftrace/sample-trace-array.c                            |    2 
 scripts/selinux/install_policy.sh                              |   15 
 security/smack/smack.h                                         |    6 
 security/smack/smack_lsm.c                                     |   10 
 sound/pci/hda/patch_realtek.c                                  |   33 +
 sound/soc/codecs/cs35l41-spi.c                                 |    4 
 sound/soc/codecs/rt5665.c                                      |   24 -
 sound/soc/fsl/imx-card.c                                       |    4 
 sound/soc/ti/j721e-evm.c                                       |    2 
 tools/lib/bpf/linker.c                                         |    2 
 tools/objtool/check.c                                          |   35 -
 tools/perf/bench/syscall.c                                     |   22 -
 tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S |    2 
 tools/perf/util/arm-spe.c                                      |    8 
 tools/perf/util/evlist.c                                       |   13 
 tools/perf/util/pmu.c                                          |    7 
 tools/perf/util/pmu.h                                          |    5 
 tools/perf/util/pmus.c                                         |   20 
 tools/perf/util/python.c                                       |   17 
 tools/perf/util/stat-shadow.c                                  |    3 
 tools/perf/util/units.c                                        |    2 
 tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c      |    5 
 tools/testing/selftests/bpf/progs/strncmp_bench.c              |    5 
 tools/testing/selftests/mm/cow.c                               |    2 
 278 files changed, 2329 insertions(+), 1175 deletions(-)

Acs, Jakub (1):
      ext4: fix OOB read when checking dotdot dir

Al Viro (3):
      spufs: fix a leak on spufs_new_file() failure
      spufs: fix gang directory lifetimes
      spufs: fix a leak in spufs_create_context()

Alex Deucher (1):
      drm/amdgpu/gfx11: fix num_mec

Alex Hung (1):
      drm/amd/display: Check link_index before accessing dc->links[]

Alexandre Ghiti (1):
      riscv: Fix hugetlb retrieval of number of ptes in case of !present pte

Alistair Popple (1):
      fuse: fix dax truncate/punch_hole fault path

Andrii Nakryiko (1):
      libbpf: Fix hypothetical STT_SECTION extern NULL deref case

Andy Shevchenko (1):
      pinctrl: intel: Fix wrong bypass assignment in intel_pinctrl_probe_pwm()

AngeloGioacchino Del Regno (2):
      drm/mediatek: mtk_hdmi: Unregister audio platform device on failure
      drm/mediatek: mtk_hdmi: Fix typo for aud_sampe_size member

Angelos Oikonomopoulos (1):
      arm64: Don't call NULL in do_compat_alignment_fixup()

Anshuman Khandual (1):
      arch/powerpc: drop GENERIC_PTDUMP from mpc885_ads_defconfig

Antheas Kapenekakis (1):
      ALSA: hda/realtek: Fix Asus Z13 2025 audio

Antoine Tenart (1):
      net: decrease cached dst counters in dst_release

Armin Wolf (1):
      platform/x86: dell-ddv: Fix temperature calculation

Arnaldo Carvalho de Melo (5):
      perf units: Fix insufficient array space
      perf python: Fixup description of sample.id event member
      perf python: Decrement the refcount of just created event on failure
      perf python: Don't keep a raw_data pointer to consumed ring buffer space
      perf python: Check if there is space to copy all the event

Arnd Bergmann (2):
      x86/platform: Only allow CONFIG_EISA for 32-bit
      mdacon: rework dependency list

Artur Weber (1):
      power: supply: max77693: Fix wrong conversion of charge input threshold value

Atish Patra (1):
      RISC-V: KVM: Disable the kernel perf counter during configure

Barnabás Czémán (1):
      clk: qcom: mmcc-sdm660: fix stuck video_subcore0 clock

Bart Van Assche (1):
      fs/procfs: fix the comment above proc_pid_wchan()

Benjamin Berg (3):
      x86/fpu: Avoid copying dynamic FP state from init_task in arch_dup_task_struct()
      um: remove copy_from_kernel_nofault_allowed
      um: hostfs: avoid issues on inode number reuse by host

Benjamin Gaignard (1):
      media: verisilicon: HEVC: Initialize start_bit field

Boris Ostrovsky (1):
      x86/microcode/AMD: Fix __apply_microcode_amd()'s return value

Chao Gao (1):
      x86/fpu/xstate: Fix inconsistencies in guest FPU xfeatures

Cheng Xu (1):
      RDMA/erdma: Prevent use-after-free in erdma_accept_newconn()

Chenyuan Yang (1):
      thermal: int340x: Add NULL check for adev

Chiara Meiohas (1):
      RDMA/mlx5: Fix calculation of total invalidated pages

Christophe JAILLET (2):
      PCI: histb: Fix an error handling path in histb_pcie_probe()
      ASoC: codecs: rt5665: Fix some error handling paths in rt5665_probe()

Chuck Lever (1):
      NFSD: Skip sending CB_RECALL_ANY when the backchannel isn't up

Cong Wang (1):
      net_sched: skbprio: Remove overly strict queue assertions

Cyan Yang (1):
      selftests/mm/cow: fix the incorrect error handling

Dan Carpenter (4):
      PCI: Remove stray put_device() in pci_register_host_bridge()
      drm/mediatek: dsi: fix error codes in mtk_dsi_host_transfer()
      fs/ntfs3: Fix a couple integer overflows on 32bit systems
      fs/ntfs3: Prevent integer overflow in hdr_first_de()

Daniel Bárta (1):
      ALSA: hda: Fix speakers on ASUS EXPERTBOOK P5405CSA 1.0

Daniel Stodden (1):
      PCI/ASPM: Fix link state exit during switch upstream function removal

Danila Chernetsov (1):
      fbdev: sm501fb: Add some geometry checks.

Dave Marquardt (1):
      net: ibmveth: make veth_pool_store stop hanging

David E. Box (1):
      platform/x86/intel/vsec: Add Diamond Rapids support

David Hildenbrand (2):
      x86/mm/pat: Fix VM_PAT handling when fork() fails in copy_page_range()
      kernel/events/uprobes: handle device-exclusive entries correctly in __replace_page()

David Laight (1):
      objtool: Fix verbose disassembly if CROSS_COMPILE isn't set

David Oberhollenzer (1):
      net: dsa: mv88e6xxx: propperly shutdown PPU re-enable timer on destroy

Debin Zhu (1):
      netlabel: Fix NULL pointer exception caused by CALIPSO on IPv4 sockets

Dmitry Baryshkov (1):
      drm/msm/dpu: don't use active in atomic_check()

Dmitry Panchenko (1):
      platform/x86: intel-hid: fix volume buttons on Microsoft Surface Go 4 tablet

Douglas Anderson (1):
      drm/mediatek: dp: drm_err => dev_err in HPD path to avoid NULL ptr

Douglas Raillard (2):
      tracing: Ensure module defining synth event cannot be unloaded while tracing
      tracing: Fix synth event printk format for str fields

Emmanuel Grumbach (2):
      wifi: iwlwifi: mvm: use the right version of the rate API
      wifi: mac80211: flush the station before moving it to UN-AUTHORIZED state

Eric Sandeen (1):
      watch_queue: fix pipe accounting mismatch

Fabrizio Castro (3):
      pinctrl: renesas: rza2: Fix missing of_node_put() call
      pinctrl: renesas: rzg2l: Fix missing of_node_put() call
      pinctrl: renesas: rzv2m: Fix missing of_node_put() call

Feng Tang (1):
      PCI/portdrv: Only disable pciehp interrupts early when needed

Feng Yang (1):
      ring-buffer: Fix bytes_dropped calculation issue

Fernando Fernandez Mancera (1):
      ipv6: fix omitted netlink attributes when using RTEXT_FILTER_SKIP_STATS

Florian Westphal (1):
      netfilter: nf_tables: don't unregister hook when table is dormant

Geert Uytterhoeven (1):
      drm/bridge: ti-sn65dsi86: Fix multiple instances

Geetha sowjanya (2):
      octeontx2-af: Fix mbox INTR handler when num VFs > 64
      octeontx2-af: Free NIX_AF_INT_VEC_GEN irq

Giovanni Gherdovich (1):
      ACPI: processor: idle: Return an error if both P_LVL{2,3} idle states are invalid

Greg Kroah-Hartman (1):
      Linux 6.6.87

Guilherme G. Piccoli (1):
      x86/tsc: Always save/restore TSC sched_clock() on suspend/resume

Guillaume Nault (1):
      tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu().

Hans Zhang (1):
      PCI: cadence-ep: Fix the driver to send MSG TLP for INTx without data payload

Hans de Goede (1):
      ACPI: x86: Extend Lenovo Yoga Tab 3 quirk with skip GPIO event-handlers

Hengqi Chen (3):
      LoongArch: BPF: Fix off-by-one error in build_prologue()
      LoongArch: BPF: Don't override subprog's return value
      LoongArch: BPF: Use move_addr() for BPF_PSEUDO_FUNC

Henry Martin (2):
      ASoC: imx-card: Add NULL check in imx_card_probe()
      arcnet: Add NULL check in com20020pci_probe()

Herbert Xu (1):
      crypto: nx - Fix uninitialised hv_nxc on error

Hermes Wu (1):
      drm/bridge: it6505: fix HDCP V match check is not performed correctly

Herton R. Krzesinski (1):
      x86/uaccess: Improve performance by aligning writes to 8 bytes in copy_user_generic(), on non-FSRM/ERMS CPUs

Hou Tao (1):
      bpf: Use preempt_count() directly in bpf_send_signal_common()

Huacai Chen (1):
      LoongArch: Increase ARCH_DMA_MINALIGN up to 16

Ian Rogers (2):
      perf stat: Fix find_stat for mixed legacy/non-legacy events
      perf evlist: Add success path to evlist__create_syswide_maps

Icenowy Zheng (2):
      nvme-pci: clean up CMBMSC when registering CMB fails
      nvme-pci: skip CMB blocks incompatible with PCI P2P DMA

Ido Schimmel (2):
      ipv6: Start path selection from the first nexthop
      ipv6: Do not consider link down nexthops in path selection

Ilkka Koskinen (1):
      coresight: catu: Fix number of pages while using 64k pages

Ilpo Järvinen (1):
      PCI: pciehp: Don't enable HPIE when resuming in poll mode

Ivan Orlov (1):
      kunit/overflow: Fix UB in overflow_allocation_test

James Clark (1):
      perf pmu: Don't double count common sysfs and json events

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

Jie Zhan (1):
      cpufreq: governor: Fix negative 'idle_time' handling in dbs_update()

Jim Quinlan (3):
      PCI: brcmstb: Use internal register to change link capability
      PCI: brcmstb: Fix error path after a call to regulator_bulk_get()
      PCI: brcmstb: Fix potential premature regulator disabling

Jiri Kosina (1):
      HID: remove superfluous (and wrong) Makefile entry for CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER

Jiri Slaby (SUSE) (1):
      tty: n_tty: use uint for space returned by tty_write_room()

Joe Hattori (2):
      media: platform: allgro-dvt: unregister v4l2_device on the error path
      soundwire: slave: fix an OF node reference leak in soundwire slave device

Johannes Berg (1):
      wifi: iwlwifi: fw: allocate chained SG tables for dump

Jonathan Cameron (2):
      iio: accel: mma8452: Ensure error return on failure to matching oversampling ratio
      iio: accel: msa311: Fix failure to release runtime pm if direct mode claim fails.

Josef Bacik (1):
      btrfs: handle errors from btrfs_dec_ref() properly

Josh Poimboeuf (6):
      x86/traps: Make exc_double_fault() consistently noreturn
      objtool, media: dib8000: Prevent divide-by-zero in dib8000_set_dds()
      objtool: Fix segfault in ignore_unreachable_insn()
      sched/smt: Always inline sched_smt_active()
      context_tracking: Always inline ct_{nmi,irq}_{enter,exit}()
      rcu-tasks: Always inline rcu_irq_work_resched()

José Expósito (1):
      drm/vkms: Fix use after free and double free on init error

Juhan Jin (1):
      riscv: ftrace: Add parentheses in macro definitions of make_call_t0 and make_call_ra

Kai-Heng Feng (1):
      PCI: Use downstream bridges for distributing resources

Kan Liang (1):
      perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample read

Karel Balej (1):
      mmc: sdhci-pxav3: set NEED_RSP_BUSY capability

Kees Bakker (1):
      RDMA/mana_ib: Ensure variable err is initialized

Keith Busch (1):
      nvme-pci: fix stuck reset on concurrent DPC and HP

Kevin Loughlin (1):
      x86/sev: Add missing RIP_REL_REF() invocations during sme_enable()

Konstantin Andreev (1):
      smack: dont compile ipv6 code unless ipv6 is configured

Kuniyuki Iwashima (1):
      udp: Fix memory accounting leak.

Lama Kayal (1):
      net/mlx5e: SHAMPO, Make reserved size independent of page size

Laurentiu Mihalcea (1):
      clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents

Leo Yan (1):
      perf arm-spe: Fix load-store operation checking

Li Lingfeng (1):
      nfsd: put dl_stid if fail to queue dl_recall

Lin Ma (2):
      netfilter: nft_tunnel: fix geneve_opt type confusion addition
      net: fix geneve_opt length integer overflow

Lubomir Rintel (1):
      rndis_host: Flag RNDIS modems as WWAN devices

Luca Weiss (3):
      remoteproc: qcom_q6v5_pas: Make single-PD handling more robust
      remoteproc: qcom_q6v5_pas: Use resource with CX PD for MSM8226
      remoteproc: qcom_q6v5_mss: Handle platforms with one power domain

Maher Sanalla (1):
      IB/mad: Check available slots before posting receive WRs

Marcus Meissner (1):
      perf tools: annotate asm_pure_loop.S

Marijn Suijten (2):
      drm/msm/dsi: Use existing per-interface slice count in DSC timing
      drm/msm/dsi: Set PHY usescase (and mode) before registering DSI host

Mario Limonciello (2):
      ucsi_ccg: Don't show failed to get FW build information error
      drm/amd: Keep display off while going into S4

Mark Zhang (1):
      rtnetlink: Allocate vfinfo size for VF GUIDs when supported

Markus Elfring (2):
      fbdev: au1100fb: Move a variable assignment behind a null pointer check
      ntb_perf: Delete duplicate dmaengine_unmap_put() call in perf_copy_chunk()

Masami Hiramatsu (Google) (2):
      tracing/hist: Add poll(POLLIN) support on hist file
      tracing/hist: Support POLLPRI event for poll on histogram

Matthias Proske (1):
      wifi: brcmfmac: keep power during suspend if board requires it

Maud Spierings (1):
      dt-bindings: vendor-prefixes: add GOcontroll

Miaoqian Lin (2):
      ksmbd: use aead_request_free to match aead_request_alloc
      mmc: omap: Fix memory leak in mmc_omap_new_slot

Michael Kelley (1):
      x86/hyperv: Fix output argument to hypercall that changes page visibility

Mike Christie (1):
      vhost-scsi: Fix handling of multiple calls to vhost_scsi_set_endpoint

Mike Rapoport (Microsoft) (1):
      x86/mm/pat: cpa-test: fix length for CPA_ARRAY test

Murad Masimov (2):
      acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
      media: streamzap: fix race between device disconnection and urb callback

Naman Jain (1):
      x86/hyperv/vtl: Stop kernel from probing VTL0 low memory

Namjae Jeon (6):
      ksmbd: fix multichannel connection failure
      ksmbd: fix r_count dec/increment mismatch
      cifs: fix incorrect validation for num_aces field of smb_acl
      ksmbd: add bounds check for durable handle context
      ksmbd: fix use-after-free in ksmbd_sessions_deregister()
      ksmbd: fix session use-after-free in multichannel connection

Navon John Lukose (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion x360 14-dy1xxx

Nikita Shubin (1):
      ntb: intel: Fix using link status DB's

Nikita Zhandarovich (1):
      mfd: sm501: Switch to BIT() to mitigate integer overflows

Niklas Neronin (1):
      usb: xhci: correct debug message page size calculation

Nishanth Aravamudan (1):
      PCI: Avoid reset when disabled via sysfs

Norbert Szetei (2):
      ksmbd: add bounds check for create lease context
      ksmbd: validate zero num_subauth before sub_auth is accessed

Oleg Nesterov (1):
      exec: fix the racy usage of fs_struct->in_exec

Oliver Hartkopp (1):
      can: statistics: use atomic access in hot path

Pablo Neira Ayuso (1):
      netfilter: nft_set_hash: GC reaps elements with conncount for dynamic sets only

Palmer Dabbelt (1):
      RISC-V: errata: Use medany for relocatable builds

Patrisious Haddad (1):
      RDMA/mlx5: Fix mlx5_poll_one() cur_qp update flow

Paul Menzel (1):
      ACPI: resource: Skip IRQ override on ASUS Vivobook 14 X1404VAP

Peng Fan (2):
      remoteproc: core: Clear table_sz when rproc_shutdown
      dmaengine: fsl-edma: cleanup chan after dma_async_device_unregister

Peter Geis (1):
      clk: rockchip: rk3328: fix wrong clk_ref_usb3otg parent

Peter Zijlstra (2):
      lockdep/mm: Fix might_fault() lockdep check of current->mm->mmap_lock
      perf/core: Fix perf_pmu_register() vs. perf_init_event()

Peter Zijlstra (Intel) (1):
      perf/x86/intel: Apply static call for drain_pebs

Prathamesh Shete (1):
      pinctrl: tegra: Set SFIO mode to Mux Register

Qasim Ijaz (2):
      isofs: fix KMSAN uninit-value bug in do_isofs_readdir()
      jfs: fix slab-out-of-bounds read in ea_get()

Qiuxu Zhuo (4):
      EDAC/{skx_common,i10nm}: Fix some missing error reports on Emerald Rapids
      EDAC/ie31200: Fix the size of EDAC_MC_LAYER_CHIP_SELECT layer
      EDAC/ie31200: Fix the DIMM size mask for several SoCs
      EDAC/ie31200: Fix the error path order of ie31200_init()

Rafael J. Wysocki (2):
      PM: sleep: Adjust check before setting power.must_resume
      PM: sleep: Fix handling devices with direct_complete set on errors

Ran Xiaokai (1):
      tracing/osnoise: Fix possible recursive locking for cpus_read_lock()

Remi Pommarel (1):
      leds: Fix LED_OFF brightness race

Richard Fitzgerald (1):
      firmware: cs_dsp: Ensure cs_dsp_load[_coeff]() returns 0 on success

Roger Quadros (1):
      memory: omap-gpmc: drop no compatible check

Roman Gushchin (1):
      RDMA/core: Don't expose hw_counters outside of init net namespace

Roman Smirnov (1):
      jfs: add index corruption check to DT_GETPAGE()

Sagi Grimberg (1):
      nvme-tcp: fix possible UAF in nvme_tcp_poll

Saket Kumar Bhaskar (1):
      selftests/bpf: Select NUMA_NO_NODE to create map

Sebastian Andrzej Siewior (1):
      lockdep: Don't disable interrupts on RT in disable_irq_nosync_lockdep.*()

Shrikanth Hegde (1):
      sched/deadline: Use online cpus for validating runtime

Simon Tatham (2):
      affs: generate OFS sequence numbers starting at 1
      affs: don't write overlarge OFS data block size fields

Sourabh Jain (1):
      kexec: initialize ELF lowest address to ULONG_MAX

Srinivas Pandruvada (1):
      platform/x86: ISST: Correct command storage data length

Srinivasan Shanmugam (1):
      drm/amdkfd: Fix Circular Locking Dependency in 'svm_range_cpu_invalidate_pagetables'

Stanislav Spassov (1):
      x86/fpu: Fix guest FPU state buffer allocation size

Stanley Chu (1):
      i3c: master: svc: Fix missing the IBI rules

Stefan Binding (2):
      ALSA: hda/realtek: Add support for ASUS ROG Strix G614 Laptops using CS35L41 HDA
      ALSA: hda/realtek: Add support for ASUS Zenbook UM3406KA Laptops using CS35L41 HDA

Stefano Garzarella (1):
      vsock: avoid timeout during connect() if the socket is closing

Steven Rostedt (2):
      tracing: Switch trace_events_hist.c code over to use guard()
      tracing: Do not use PERF enums when perf is not defined

Steven Rostedt (Google) (1):
      tracing: Allow creating instances with specified system events

Takashi Iwai (2):
      ALSA: hda/realtek: Always honor no_shutup_pins
      ALSA: hda/realtek: Fix built-in mic breakage on ASUS VivoBook X515JA

Tanya Agarwal (1):
      lib: 842: Improve error handling in sw842_compress()

Tao Chen (1):
      perf/ring_buffer: Allow the EPOLLRDNORM flag for poll

Tasos Sahanidis (1):
      hwmon: (nct6775-core) Fix out of bounds access for NCT679{8,9}

Tengda Wu (2):
      tracing: Correct the refcount if the hist/hist_debug file fails to open
      tracing: Fix use-after-free in print_graph_function_flags during tracer switching

Thadeu Lima de Souza Cascardo (1):
      drm/amd/display: avoid NPD when ASIC does not support DMUB

Theodore Ts'o (1):
      ext4: don't over-report free space or inodes in statvfs

Thippeswamy Havalige (1):
      PCI: xilinx-cpm: Fix IRQ domain leak in error path of probe

Thomas Richter (1):
      perf bench: Fix perf bench syscall loop count

Tianyu Lan (1):
      x86/hyperv: Fix check of return value from snp_set_vmsa()

Tim Schumacher (1):
      selinux: Chain up tool resolving errors in install_policy.sh

Tobias Waldekranz (1):
      net: mvpp2: Prevent parser TCAM memory corruption

Tomi Valkeinen (1):
      drm: xlnx: zynqmp: Fix max dma segment size

Trond Myklebust (2):
      NFSv4: Don't trigger uneccessary scans for return-on-close delegations
      NFS: Shut down the nfs_client only after all the superblocks

Ulf Hansson (1):
      mmc: sdhci-omap: Disable MMC_CAP_AGGRESSIVE_PM for eMMC/SD

Uwe Kleine-König (2):
      iio: adc: ad4130: Fix comparison of channel setups
      iio: adc: ad7124: Fix comparison of channel configs

Vasiliy Kovalev (1):
      ocfs2: validate l_tree_depth to avoid out-of-bounds access

Viktor Malik (1):
      selftests/bpf: Fix string read in strncmp benchmark

Vitaliy Shevtsov (2):
      ASoC: cs35l41: check the return value from spi_setup()
      drm/amd/display: fix type mismatch in CalculateDynamicMetadataParameters()

Vitaly Lifshits (1):
      e1000e: change k1 configuration on MTP and later platforms

Vladimir Lypak (1):
      clk: qcom: gcc-msm8953: fix stuck venus0_core0 clock

Vladis Dronov (1):
      x86/sgx: Warn explicitly if X86_FEATURE_SGX_LC is not enabled

Waiman Long (1):
      locking/semaphore: Use wake_q to wake up processes outside lock critical section

Wang Zhaolong (1):
      smb: client: Fix netns refcount imbalance causing leaks and use-after-free

Wayne Lin (1):
      drm/dp_mst: Fix drm RAD print

Wenkai Lin (3):
      crypto: hisilicon/sec2 - fix for aead authsize alignment
      crypto: hisilicon/sec2 - fix for sec spec check
      crypto: hisilicon/sec2 - fix for aead auth key length

Wentao Guan (1):
      HID: i2c-hid: improve i2c_hid_get_report error message

Will McVicker (1):
      clk: samsung: Fix UBSAN panic in samsung_clk_init()

Yajun Deng (1):
      ntb_hw_switchtec: Fix shift-out-of-bounds in switchtec_ntb_mw_set_trans

Yeoreum Yun (1):
      perf/core: Fix child_total_time_enabled accounting bug at task exit

Ying Lu (1):
      usbnet:fix NPE during rx_complete

Yuanfang Zhang (1):
      coresight-etm4x: add isb() before reading the TRCSTATR

Yuezhang Mo (1):
      exfat: fix the infinite loop in exfat_find_last_cluster()

Yuli Wang (1):
      LoongArch: Rework the arch_kgdb_breakpoint() implementation

Zijun Hu (1):
      of: property: Increase NR_FWNODE_REFERENCE_ARGS

zuoqian (1):
      cpufreq: scpi: compare kHz instead of Hz

谢致邦 (XIE Zhibang) (2):
      staging: rtl8723bs: select CONFIG_CRYPTO_LIB_AES
      LoongArch: Fix help text of CMDLINE_EXTEND in Kconfig


