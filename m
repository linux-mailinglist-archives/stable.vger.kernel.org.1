Return-Path: <stable+bounces-67660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A787951CA6
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 16:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5562D1C211BF
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 14:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B70A1B29C3;
	Wed, 14 Aug 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GJmXP0mv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84791B1421;
	Wed, 14 Aug 2024 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644617; cv=none; b=n6kKJWSdmDA+5LqDs/P6hkEvPh6OufAFJhk45uqxD06TaSPbcyuAYbyclPuKjEytKlspmsj1/pql9gC8HjnXk9dshjK3y6dqa7h+g6IGw91L/D4DrOBFDWIo05AEXghkSkoy0W6McgAYoHqjt+6kn9tVOE99IhqfAfZ1xvGq0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644617; c=relaxed/simple;
	bh=TQvkoh6nF5hcppMSakYuEW6CiTHiR8C/d/LmjHPn3IY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jeDxwNbJoIWsBUayEnhNu3MMrdDQdnzVtT2ZcMLY2alvjKqVLtjiYDWNNFdSEUKjqJpiH2fYVUsXh9VLuf4oxYJg4mRvvFhhrHzYQbgTFOEdM91TunHyjU3/Gr6HG9UinlSQjAubu/sqtweMTXewVhgWYDlpbWyTgFeZYh5gse4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GJmXP0mv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B42C32786;
	Wed, 14 Aug 2024 14:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723644617;
	bh=TQvkoh6nF5hcppMSakYuEW6CiTHiR8C/d/LmjHPn3IY=;
	h=From:To:Cc:Subject:Date:From;
	b=GJmXP0mvKOKj8tItT2srGtEUblkXYNcdRHMDPNfnrm+39l7Z6H7ZOcj2qGEXt0UAY
	 sgmmB+oNakjl1utemn3uERh89IW0+FB5pvVDOEEVDopGXqWD0WN9xEZ5HGS/opbt42
	 gafsmGIyFlpJ6FFUJ4ctIwWkp1sfSL2VQNMkD3RU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.10.5
Date: Wed, 14 Aug 2024 16:10:11 +0200
Message-ID: <2024081412-washhouse-washtub-9a0c@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.10.5 kernel.

All users of the 6.10 kernel series must upgrade.

The updated 6.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/cifs/usage.rst                                        |    2 
 Documentation/admin-guide/kernel-parameters.txt                                 |    4 
 Documentation/arch/arm64/silicon-errata.rst                                     |   34 +
 Documentation/hwmon/corsair-psu.rst                                             |    6 
 Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst                       |    4 
 Makefile                                                                        |    2 
 arch/arm64/Kconfig                                                              |   62 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi                               |   22 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                                      |    6 
 arch/arm64/include/asm/cpucaps.h                                                |    2 
 arch/arm64/include/asm/cputype.h                                                |   10 
 arch/arm64/kernel/cpu_errata.c                                                  |   26 -
 arch/arm64/kernel/proton-pack.c                                                 |    2 
 arch/loongarch/kernel/efi.c                                                     |    6 
 arch/parisc/Kconfig                                                             |    1 
 arch/parisc/include/asm/cache.h                                                 |   11 
 arch/parisc/net/bpf_jit_core.c                                                  |    2 
 arch/x86/events/amd/core.c                                                      |   28 -
 arch/x86/events/amd/uncore.c                                                    |    8 
 arch/x86/events/core.c                                                          |  116 ++--
 arch/x86/events/intel/core.c                                                    |  164 +++---
 arch/x86/events/intel/cstate.c                                                  |   35 +
 arch/x86/events/intel/ds.c                                                      |   34 -
 arch/x86/events/intel/knc.c                                                     |    2 
 arch/x86/events/intel/p4.c                                                      |   10 
 arch/x86/events/intel/p6.c                                                      |    2 
 arch/x86/events/perf_event.h                                                    |   62 ++
 arch/x86/events/zhaoxin/core.c                                                  |   12 
 arch/x86/include/asm/intel_ds.h                                                 |    1 
 arch/x86/include/asm/qspinlock.h                                                |   12 
 arch/x86/kernel/cpu/mtrr/mtrr.c                                                 |    2 
 arch/x86/kernel/paravirt.c                                                      |    7 
 arch/x86/mm/pti.c                                                               |    8 
 drivers/acpi/battery.c                                                          |   16 
 drivers/acpi/resource.c                                                         |   14 
 drivers/acpi/sbs.c                                                              |   23 
 drivers/base/core.c                                                             |   13 
 drivers/base/module.c                                                           |    4 
 drivers/base/regmap/regmap-kunit.c                                              |   72 +-
 drivers/bluetooth/btnxpuart.c                                                   |    2 
 drivers/clocksource/sh_cmt.c                                                    |   13 
 drivers/cpufreq/amd-pstate.c                                                    |   32 -
 drivers/cpufreq/amd-pstate.h                                                    |    1 
 drivers/gpio/gpiolib.c                                                          |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                      |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                                         |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c                                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                                         |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                                        |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h                                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c                                     |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                            |    9 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                               |    9 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                     |  247 ++++++----
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                               |   58 +-
 drivers/gpu/drm/amd/display/dc/core/dc_state.c                                  |   67 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c                                |    9 
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c                         |   49 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c                         |    3 
 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c |    5 
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c                                 |    3 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c             |    3 
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c                  |    9 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                                |    8 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c                                 |    8 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                             |   57 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c                             |   14 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c                           |   36 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                                       |   16 
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c                               |    5 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                                   |   11 
 drivers/gpu/drm/drm_atomic_uapi.c                                               |   15 
 drivers/gpu/drm/drm_client_modeset.c                                            |    5 
 drivers/gpu/drm/i915/display/intel_backlight.c                                  |    3 
 drivers/gpu/drm/i915/display/intel_pps.c                                        |    3 
 drivers/gpu/drm/i915/gem/i915_gem_mman.c                                        |   55 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c                                         |   13 
 drivers/gpu/drm/lima/lima_drv.c                                                 |    1 
 drivers/gpu/drm/mgag200/mgag200_i2c.c                                           |    8 
 drivers/gpu/drm/radeon/pptable.h                                                |    2 
 drivers/gpu/drm/tests/drm_gem_shmem_test.c                                      |   11 
 drivers/gpu/drm/xe/regs/xe_engine_regs.h                                        |    4 
 drivers/gpu/drm/xe/xe_guc_submit.c                                              |    2 
 drivers/gpu/drm/xe/xe_hwmon.c                                                   |    3 
 drivers/gpu/drm/xe/xe_lrc.c                                                     |   17 
 drivers/gpu/drm/xe/xe_preempt_fence.c                                           |   14 
 drivers/gpu/drm/xe/xe_rtp.c                                                     |    2 
 drivers/gpu/drm/xe/xe_sync.c                                                    |    2 
 drivers/hwmon/corsair-psu.c                                                     |    7 
 drivers/i2c/busses/i2c-qcom-geni.c                                              |    5 
 drivers/i2c/i2c-smbus.c                                                         |   64 ++
 drivers/irqchip/irq-loongarch-cpu.c                                             |    6 
 drivers/irqchip/irq-mbigen.c                                                    |   20 
 drivers/irqchip/irq-meson-gpio.c                                                |   14 
 drivers/irqchip/irq-riscv-aplic-msi.c                                           |   32 +
 drivers/irqchip/irq-xilinx-intc.c                                               |    2 
 drivers/md/md.c                                                                 |   15 
 drivers/md/md.h                                                                 |    2 
 drivers/md/raid1.c                                                              |    3 
 drivers/md/raid10.c                                                             |    3 
 drivers/md/raid5.c                                                              |   23 
 drivers/media/i2c/ov5647.c                                                      |   11 
 drivers/media/pci/intel/ipu6/Kconfig                                            |    3 
 drivers/media/platform/amphion/vdec.c                                           |    2 
 drivers/media/platform/amphion/venc.c                                           |    2 
 drivers/media/tuners/xc2028.c                                                   |    9 
 drivers/media/usb/uvc/uvc_video.c                                               |   37 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c                                  |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c                                   |  125 ++---
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h                                       |   13 
 drivers/net/dsa/bcm_sf2.c                                                       |    4 
 drivers/net/dsa/microchip/ksz_common.c                                          |   16 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                       |   13 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c                              |   14 
 drivers/net/ethernet/freescale/fec_ptp.c                                        |    3 
 drivers/net/ethernet/google/gve/gve_ethtool.c                                   |    2 
 drivers/net/ethernet/google/gve/gve_main.c                                      |   12 
 drivers/net/ethernet/intel/ice/ice_main.c                                       |    2 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                                      |   48 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                                     |   43 -
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                                 |    3 
 drivers/net/ethernet/mellanox/mlxsw/pci.c                                       |    6 
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c                         |   23 
 drivers/net/pse-pd/tps23881.c                                                   |    5 
 drivers/net/usb/qmi_wwan.c                                                      |    1 
 drivers/net/virtio_net.c                                                        |    8 
 drivers/net/wireless/ath/ath12k/dp_rx.c                                         |    1 
 drivers/net/wireless/ath/ath12k/pci.c                                           |    4 
 drivers/net/wireless/realtek/rtlwifi/usb.c                                      |   34 +
 drivers/net/wireless/realtek/rtw89/pci.c                                        |   13 
 drivers/nvme/host/apple.c                                                       |   27 -
 drivers/nvme/host/pci.c                                                         |    6 
 drivers/platform/chrome/cros_ec_lpc.c                                           |   50 +-
 drivers/platform/x86/intel/ifs/runtest.c                                        |    2 
 drivers/platform/x86/intel/vbtn.c                                               |    9 
 drivers/power/supply/axp288_charger.c                                           |   22 
 drivers/power/supply/qcom_battmgr.c                                             |    8 
 drivers/power/supply/rt5033_battery.c                                           |    1 
 drivers/s390/char/sclp_sd.c                                                     |   10 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                                 |   11 
 drivers/scsi/mpt3sas/mpt3sas_base.c                                             |   20 
 drivers/scsi/sd.c                                                               |    5 
 drivers/soc/qcom/icc-bwmon.c                                                    |   12 
 drivers/spi/spi-fsl-lpspi.c                                                     |    6 
 drivers/spi/spidev.c                                                            |    1 
 drivers/spmi/spmi-pmic-arb.c                                                    |   11 
 drivers/thermal/intel/intel_hfi.c                                               |   30 -
 drivers/tty/serial/sc16is7xx.c                                                  |   25 -
 drivers/tty/serial/serial_core.c                                                |    8 
 drivers/tty/vt/conmakehash.c                                                    |   20 
 drivers/ufs/core/ufshcd-priv.h                                                  |    5 
 drivers/ufs/core/ufshcd.c                                                       |   19 
 drivers/usb/gadget/function/f_fs.c                                              |    6 
 drivers/usb/gadget/function/f_midi2.c                                           |   21 
 drivers/usb/gadget/function/u_audio.c                                           |   42 +
 drivers/usb/gadget/function/u_serial.c                                          |    1 
 drivers/usb/gadget/udc/core.c                                                   |   10 
 drivers/usb/serial/usb_debug.c                                                  |    7 
 drivers/usb/typec/mux/fsa4480.c                                                 |   14 
 drivers/usb/usbip/vhci_hcd.c                                                    |    9 
 drivers/vhost/vdpa.c                                                            |    8 
 drivers/xen/privcmd.c                                                           |   25 -
 fs/btrfs/ctree.c                                                                |   57 +-
 fs/btrfs/ctree.h                                                                |   11 
 fs/btrfs/defrag.c                                                               |    2 
 fs/btrfs/disk-io.c                                                              |    4 
 fs/btrfs/extent-tree.c                                                          |   46 -
 fs/btrfs/extent-tree.h                                                          |    8 
 fs/btrfs/extent_io.c                                                            |    4 
 fs/btrfs/file.c                                                                 |   60 +-
 fs/btrfs/free-space-cache.c                                                     |    1 
 fs/btrfs/free-space-tree.c                                                      |   10 
 fs/btrfs/ioctl.c                                                                |    6 
 fs/btrfs/print-tree.c                                                           |    2 
 fs/btrfs/qgroup.c                                                               |    6 
 fs/btrfs/relocation.c                                                           |    8 
 fs/btrfs/transaction.c                                                          |    8 
 fs/buffer.c                                                                     |    2 
 fs/ext4/inline.c                                                                |    6 
 fs/ext4/inode.c                                                                 |    5 
 fs/jbd2/journal.c                                                               |    1 
 fs/nfsd/nfsctl.c                                                                |    3 
 fs/smb/client/cifs_debug.c                                                      |    2 
 fs/smb/client/cifsglob.h                                                        |    8 
 fs/smb/client/inode.c                                                           |   17 
 fs/smb/client/misc.c                                                            |    9 
 fs/smb/client/reparse.c                                                         |    4 
 fs/smb/client/reparse.h                                                         |   19 
 fs/smb/client/smb2inode.c                                                       |    2 
 fs/smb/client/smb2pdu.c                                                         |    3 
 fs/tracefs/event_inode.c                                                        |    4 
 fs/tracefs/inode.c                                                              |   12 
 fs/tracefs/internal.h                                                           |    5 
 fs/udf/balloc.c                                                                 |   36 -
 include/linux/blk-integrity.h                                                   |   16 
 include/linux/fs.h                                                              |    2 
 include/linux/pci_ids.h                                                         |    2 
 include/linux/profile.h                                                         |    1 
 include/linux/rcupdate.h                                                        |    2 
 include/linux/trace_events.h                                                    |    1 
 include/linux/virtio_net.h                                                      |   16 
 include/sound/cs35l56.h                                                         |   14 
 io_uring/net.c                                                                  |    7 
 kernel/bpf/verifier.c                                                           |   17 
 kernel/irq/irqdesc.c                                                            |    1 
 kernel/jump_label.c                                                             |    4 
 kernel/kcov.c                                                                   |   15 
 kernel/kprobes.c                                                                |    4 
 kernel/locking/qspinlock_paravirt.h                                             |    2 
 kernel/module/main.c                                                            |   41 +
 kernel/padata.c                                                                 |    7 
 kernel/pid_namespace.c                                                          |   17 
 kernel/profile.c                                                                |   11 
 kernel/rcu/rcutorture.c                                                         |    2 
 kernel/rcu/tasks.h                                                              |   16 
 kernel/rcu/tree.c                                                               |   10 
 kernel/sched/core.c                                                             |   68 +-
 kernel/sched/cputime.c                                                          |    6 
 kernel/sched/stats.c                                                            |   10 
 kernel/time/clocksource.c                                                       |    2 
 kernel/time/ntp.c                                                               |    9 
 kernel/time/tick-broadcast.c                                                    |    3 
 kernel/time/timekeeping.c                                                       |    2 
 kernel/trace/trace.h                                                            |   23 
 kernel/trace/trace_events.c                                                     |   33 -
 kernel/trace/trace_events_hist.c                                                |    4 
 kernel/trace/trace_events_inject.c                                              |    2 
 kernel/trace/trace_events_trigger.c                                             |    6 
 kernel/trace/tracing_map.c                                                      |    6 
 lib/debugobjects.c                                                              |   21 
 mm/list_lru.c                                                                   |   28 -
 mm/memcontrol.c                                                                 |   22 
 mm/slub.c                                                                       |    3 
 net/bluetooth/hci_sync.c                                                        |   14 
 net/bluetooth/l2cap_core.c                                                      |    1 
 net/bridge/br_multicast.c                                                       |    4 
 net/core/link_watch.c                                                           |    4 
 net/ipv4/tcp_ao.c                                                               |   43 +
 net/ipv4/tcp_offload.c                                                          |    3 
 net/ipv4/udp_offload.c                                                          |    4 
 net/l2tp/l2tp_core.c                                                            |   15 
 net/mac80211/agg-tx.c                                                           |    4 
 net/mptcp/options.c                                                             |    3 
 net/mptcp/pm_netlink.c                                                          |   47 +
 net/sctp/input.c                                                                |   19 
 net/smc/smc_stats.h                                                             |    2 
 net/sunrpc/sched.c                                                              |    4 
 net/unix/af_unix.c                                                              |   34 -
 net/wireless/nl80211.c                                                          |   37 +
 sound/pci/hda/patch_hdmi.c                                                      |    2 
 sound/pci/hda/patch_realtek.c                                                   |    1 
 sound/soc/amd/yc/acp6x-mach.c                                                   |    7 
 sound/soc/codecs/cs-amp-lib.c                                                   |    2 
 sound/soc/codecs/cs35l56-sdw.c                                                  |   77 +++
 sound/soc/codecs/cs35l56-shared.c                                               |  101 ----
 sound/soc/codecs/cs35l56.c                                                      |  205 --------
 sound/soc/codecs/cs35l56.h                                                      |    1 
 sound/soc/codecs/wcd938x-sdw.c                                                  |    4 
 sound/soc/codecs/wcd939x-sdw.c                                                  |    4 
 sound/soc/codecs/wsa881x.c                                                      |    2 
 sound/soc/codecs/wsa883x.c                                                      |   10 
 sound/soc/codecs/wsa884x.c                                                      |   10 
 sound/soc/meson/axg-fifo.c                                                      |   26 -
 sound/soc/sof/mediatek/mt8195/mt8195.c                                          |    2 
 sound/soc/sti/sti_uniperif.c                                                    |    2 
 sound/soc/sti/uniperif.h                                                        |    1 
 sound/soc/sti/uniperif_player.c                                                 |    1 
 sound/soc/sti/uniperif_reader.c                                                 |    1 
 sound/usb/line6/driver.c                                                        |    5 
 sound/usb/quirks-table.h                                                        |    4 
 tools/testing/selftests/bpf/prog_tests/send_signal.c                            |    3 
 tools/testing/selftests/devices/ksft.py                                         |    2 
 tools/testing/selftests/mm/Makefile                                             |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                                 |   55 +-
 274 files changed, 2688 insertions(+), 1723 deletions(-)

Abdulrasaq Lawani (1):
      media: i2c: ov5647: replacing of_node_put with __free(device_node)

Alex Hung (1):
      drm/amd/display: Add null checker before passing variables

Alexander Lobakin (2):
      idpf: fix memory leaks and crashes while performing a soft reset
      idpf: fix UAFs when destroying the queues

Andi Kleen (1):
      x86/mtrr: Check if fixed MTRRs exist before saving them

Andi Shyti (2):
      drm/i915/gem: Fix Virtual Memory mapping boundaries calculation
      drm/i915/gem: Adjust vma offset for framebuffer mmap offset

Andrey Konovalov (1):
      kcov: properly check for softirq context

Anton Khirnov (1):
      Bluetooth: hci_sync: avoid dup filtering when passive scanning with adv monitor

Arnd Bergmann (2):
      net: pse-pd: tps23881: include missing bitfield.h header
      media: ipu-bridge: fix ipu6 Kconfig dependencies

Arseniy Krasnov (1):
      irqchip/meson-gpio: Convert meson_gpio_irq_controller::lock to 'raw_spinlock_t'

Aurabindo Pillai (1):
      drm/amd/display: Fix null pointer deref in dcn20_resource.c

Baochen Qiang (2):
      wifi: ath12k: fix race due to setting ATH12K_FLAG_EXT_IRQ_ENABLED too early
      wifi: ath12k: fix memory leak in ath12k_dp_rx_peer_frag_setup()

Bartosz Golaszewski (1):
      net: stmmac: qcom-ethqos: enable SGMII loopback during DMA reset on sa8775p-ride-r3

Ben Walsh (1):
      platform/chrome: cros_ec_lpc: Add a new quirk for ACPI id

Benjamin Coddington (1):
      SUNRPC: Fix a race to wake a sync task

Bill Wendling (1):
      drm/radeon: Remove __counted_by from StateArray.states[]

Bingbu Cao (1):
      media: intel/ipu6: select AUXILIARY_BUS in Kconfig

Bob Zhou (1):
      drm/amd/pm: Fix the null pointer dereference for vega10_hwmgr

Breno Leitao (1):
      debugobjects: Annotate racy debug variables

Chen Yu (1):
      x86/paravirt: Fix incorrect virt spinlock setting on bare metal

Chi Zhiling (1):
      media: xc2028: avoid use-after-free in load_firmware_cb()

Chris Wulff (2):
      usb: gadget: core: Check for unset descriptor
      usb: gadget: u_audio: Check return codes from usb_ep_enable and config_ep_by_speed.

Csókás, Bence (1):
      net: fec: Stop PPS on driver remove

Curtis Malainey (1):
      ASoC: SOF: Remove libraries from topology lookups

Damien Le Moal (2):
      scsi: mpt3sas: Avoid IOMMU page faults on REPORT ZONES
      scsi: mpi3mr: Avoid IOMMU page faults on REPORT ZONES

Dan Williams (1):
      driver core: Fix uevent_show() vs driver detach race

Daniele Palmas (1):
      net: usb: qmi_wwan: fix memory leak for not ip packets

Dave Airlie (1):
      drm/test: fix the gem shmem test to map the sg table.

David Collins (1):
      spmi: pmic-arb: add missing newline in dev_err format strings

David Gow (2):
      drm/i915: Allow evicting to use the requested placement
      drm/i915: Attempt to get pages without eviction first

Dmitry Antipov (1):
      Bluetooth: l2cap: always unlock channel in l2cap_conless_channel()

Dmitry Safonov (1):
      net/tcp: Disable TCP-AO static key after RCU grace period

Dnyaneshwar Bhadane (1):
      drm/i915/display: correct dual pps handling for MTL_PCH+

Dragan Simic (1):
      drm/lima: Mark simple_ondemand governor as softdep

Dragos Tatulea (1):
      net/mlx5e: SHAMPO, Fix invalid WQ linked list unlink

Dustin L. Howett (1):
      ALSA: hda/realtek: Add Framework Laptop 13 (Intel Core Ultra) to quirks

Eric Dumazet (1):
      net: linkwatch: use system_unbound_wq

FUJITA Tomonori (1):
      PCI: Add Edimax Vendor ID to pci_ids.h

Fangzhi Zuo (1):
      drm/amd/display: Skip Recompute DSC Params if no Stream on Link

Filipe Manana (6):
      btrfs: do not BUG_ON() when freeing tree block after error
      btrfs: reduce nesting for extent processing at btrfs_lookup_extent_info()
      btrfs: fix data race when accessing the last_trans field of a root
      btrfs: fix bitmap leak when loading free space cache on duplicate entry
      btrfs: fix corruption after buffer fault in during direct IO append write
      btrfs: fix double inode unlock for direct IO sync writes

Florian Fainelli (1):
      net: bcmgenet: Properly overlay PHY and MAC Wake-on-LAN capabilities

Francesco Dolcini (1):
      arm64: dts: ti: k3-am62-verdin-dahlia: Keep CTRL_SLEEP_MOCI# regulator on

Frederic Weisbecker (2):
      Revert "rcu-tasks: Fix synchronize_rcu_tasks() VS zap_pid_ns_processes()"
      rcu: Fix rcu_barrier() VS post CPUHP_TEARDOWN_CPU invocation

Gaosheng Cui (2):
      i2c: qcom-geni: Add missing clk_disable_unprepare in geni_i2c_runtime_resume
      i2c: qcom-geni: Add missing geni_icc_disable in geni_i2c_runtime_resume

Geert Uytterhoeven (1):
      spi: spidev: Add missing spi_device_id for bh2228fv

George Kennedy (1):
      serial: core: check uartclk for zero to avoid divide by zero

Gleb Korobeynikov (1):
      cifs: cifs_inval_name_dfs_link_error: correct the check for fullpath

Greg Kroah-Hartman (1):
      Linux 6.10.5

Grzegorz Nitka (1):
      ice: Fix reset handler

Guenter Roeck (2):
      i2c: smbus: Improve handling of stuck alerts
      i2c: smbus: Send alert notifications to all devices if source not found

Hagar Hemdan (1):
      gpio: prevent potential speculation leaks in gpio_device_get_desc()

Hans de Goede (3):
      platform/x86: intel-vbtn: Protect ACPI notify handler against recursion
      power: supply: axp288_charger: Fix constant_charge_voltage writes
      power: supply: axp288_charger: Round constant_charge_voltage writes down

Heng Qi (1):
      virtio-net: unbreak vq resizing when coalescing is not negotiated

Huacai Chen (1):
      irqchip/loongarch-cpu: Fix return value of lpic_gsi_to_irq()

Hugo Villeneuve (2):
      serial: sc16is7xx: fix TX fifo corruption
      serial: sc16is7xx: fix invalid FIFO access with special register set

Ido Schimmel (1):
      mlxsw: pci: Lock configuration space of upstream bridge during reset

Ivan Lipski (1):
      Revert "drm/amd/display: Add NULL check for 'afb' before dereferencing in amdgpu_dm_plane_handle_cursor_update"

James Chapman (1):
      l2tp: fix lockdep splat

Jason Wang (1):
      vhost-vdpa: switch to use vmf_insert_pfn() in the fault handler

Jean-Michel Hautbois (1):
      media: v4l: Fix missing tabular column hint for Y14P format

Jeff Layton (1):
      nfsd: don't set SVC_SOCK_ANONYMOUS when creating nfsd sockets

Jens Axboe (4):
      io_uring/net: ensure expanded bundle recv gets marked for cleanup
      io_uring/net: ensure expanded bundle send gets marked for cleanup
      io_uring/net: don't pick multiple buffers for non-bundle send
      block: use the right type for stub rq_integrity_vec()

Jerome Audu (1):
      ASoC: sti: add missing probe entry for player and reader

Jerome Brunet (1):
      ASoC: meson: axg-fifo: fix irq scheduling issue with PREEMPT_RT

Jesse Zhang (1):
      drm/admgpu: fix dereferencing null pointer context

Joe Hattori (1):
      net: dsa: bcm_sf2: Fix a possible memory leak in bcm_sf2_mdio_register()

Johan Hovold (1):
      scsi: Revert "scsi: sd: Do not repeat the starting disk message"

Johannes Berg (2):
      wifi: nl80211: disallow setting special AP channel widths
      wifi: nl80211: don't give key data to userspace

Jonathan Cavitt (1):
      drm/xe/xe_guc_submit: Fix exec queue stop race condition

Joshua Ashton (1):
      drm/amdgpu: Forward soft recovery errors to userspace

Justin Stitt (2):
      ntp: Clamp maxerror and esterror to operating range
      ntp: Safeguard against time_constant overflow

Kan Liang (2):
      perf/x86/intel: Support the PEBS event mask
      perf/x86: Support counter mask

Karthik Poosa (1):
      drm/xe/hwmon: Fix PL1 disable flow in xe_hwmon_power_max_write

Keith Busch (1):
      nvme: apple: fix device reference counting

Kemeng Shi (1):
      jbd2: avoid memleak in jbd2_journal_write_metadata_buffer

Konrad Dybcio (2):
      usb: typec: fsa4480: Check if the chip is really there
      spmi: pmic-arb: Pass the correct of_node to irq_domain_add_tree

Krzysztof Kozlowski (5):
      ASoC: codecs: wcd938x-sdw: Correct Soundwire ports mask
      ASoC: codecs: wcd939x-sdw: Correct Soundwire ports mask
      ASoC: codecs: wsa881x: Correct Soundwire ports mask
      ASoC: codecs: wsa883x: Correct Soundwire ports mask
      ASoC: codecs: wsa884x: Correct Soundwire ports mask

Kuniyuki Iwashima (2):
      sctp: Fix null-ptr-deref in reuseport_add_sock().
      af_unix: Don't retry after unix_state_lock_nested() in unix_stream_connect().

Kuppuswamy Sathyanarayanan (1):
      platform/x86/intel/ifs: Initialize union ifs_status to zero

Kyle Swenson (1):
      net: pse-pd: tps23881: Fix the device ID check

Laura Nao (1):
      selftests: ksft: Fix finished() helper exit code on skipped tests

Li Huafei (1):
      perf/x86: Fix smp_processor_id()-in-preemptible warnings

Li Nan (2):
      md: do not delete safemode_timer in mddev_suspend
      md: change the return value type of md_write_start to void

Linus Torvalds (2):
      module: warn about excessively long module waits
      module: make waiting for a concurrent module loader interruptible

Lucas De Marchi (1):
      drm/xe/rtp: Fix off-by-one when processing rules

Lucas Stach (1):
      drm/bridge: analogix_dp: properly handle zero sized AUX transactions

Luke Wang (1):
      Bluetooth: btnxpuart: Shutdown timer and prevent rearming when driver unloading

Ma Jun (4):
      drm/amdgpu/pm: Fix the param type of set_power_profile_mode
      drm/amdgpu/pm: Fix the null pointer dereference for smu7
      drm/amdgpu: Fix the null pointer dereference to ras_manager
      drm/amdgpu/pm: Fix the null pointer dereference in apply_state_adjust_rules

Ma Ke (1):
      drm/client: fix null pointer dereference in drm_client_modeset_probe

Manivannan Sadhasivam (1):
      scsi: ufs: core: Do not set link to OFF state while waking up from hibernation

Marc Kleine-Budde (2):
      can: mcp251xfd: tef: prepare to workaround broken TEF FIFO tail index erratum
      can: mcp251xfd: tef: update workaround for erratum DS80000789E 6 of mcp2518fd

Marek Marczykowski-Górecki (1):
      USB: serial: debug: do not echo input by default

Mario Limonciello (1):
      cpufreq: amd-pstate: Allow users to write 'default' EPP string

Mark Rutland (8):
      arm64: cputype: Add Cortex-X3 definitions
      arm64: cputype: Add Cortex-A720 definitions
      arm64: cputype: Add Cortex-X925 definitions
      arm64: errata: Unify speculative SSBS errata logic
      arm64: errata: Expand speculative SSBS workaround
      arm64: cputype: Add Cortex-X1C definitions
      arm64: cputype: Add Cortex-A725 definitions
      arm64: errata: Expand speculative SSBS workaround (again)

Martin Whitaker (1):
      net: dsa: microchip: disable EEE for KSZ8567/KSZ9567/KSZ9896/KSZ9897.

Masami Hiramatsu (Google) (1):
      kprobes: Fix to check symbol prefixes correctly

Mathias Krause (3):
      tracefs: Fix inode allocation
      eventfs: Don't return NULL in eventfs_create_dir()
      eventfs: Use SRCU for freeing eventfs_inodes

Matt Bobrowski (1):
      bpf: add missing check_func_arg_reg_off() to prevent out-of-bounds memory accesses

Matthew Auld (1):
      drm/xe/preempt_fence: enlarge the fence critical section

Matthew Brost (2):
      drm/xe: Use dma_fence_chain_free in chain fence unused as a sync
      drm/xe: Take ref to VM in delayed snapshot

Matthieu Baerts (NGI0) (7):
      mptcp: fully established after ADD_ADDR echo on MPJ
      mptcp: pm: deny endp with signal + subflow + port
      mptcp: pm: reduce indentation blocks
      mptcp: pm: don't try to create sf if alloc failed
      mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
      selftests: mptcp: join: ability to invert ADD_ADDR check
      selftests: mptcp: join: test both signal & subflow

Max Krummenacher (1):
      tty: vt: conmakehash: cope with abs_srctree no longer in env

Menglong Dong (1):
      bpf: kprobe: remove unused declaring of bpf_kprobe_override

Miao Wang (1):
      LoongArch: Enable general EFI poweroff method

Michael Chan (1):
      bnxt_en : Fix memory out-of-bounds in bnxt_fill_hw_rss_tbl()

Michael Strauss (1):
      drm/amd/display: Add delay to improve LTTPR UHBR interop

Michal Kubiak (1):
      idpf: fix memleak in vport interrupt configuration

Michal Pecio (1):
      media: uvcvideo: Fix the bandwdith quirk on USB 3.x

Mikulas Patocka (3):
      block: change rq_integrity_vec to respect the iterator
      parisc: fix unaligned accesses in BPF
      parisc: fix a possible DMA corruption

Ming Qian (1):
      media: amphion: Remove lock in s_ctrl callback

Muchun Song (1):
      mm: list_lru: fix UAF for memory cgroup

Natanel Roizenman (1):
      drm/amd/display: Add null check in resource_log_pipe_topology_update

Neil Armstrong (1):
      power: supply: qcom_battmgr: return EAGAIN when firmware service is not up

Nicholas Kazlauskas (1):
      drm/amd/display: Wake DMCUB before sending a command for replay feature

Nico Pache (1):
      selftests: mm: add s390 to ARCH check

Nikita Travkin (1):
      power: supply: rt5033: Bring back i2c_set_clientdata

Niklas Söderlund (1):
      clocksource/drivers/sh_cmt: Address race condition for clock events

Nikolay Aleksandrov (1):
      net: bridge: mcast: wait for previous gc cycles when removing port

Niranjana Vishwanathapura (1):
      drm/xe: Minor cleanup in LRC handling

Oliver Neukum (1):
      usb: vhci-hcd: Do not drop references before new references are gained

Paul E. McKenney (2):
      rcutorture: Fix rcu_torture_fwd_cb_cr() data race
      clocksource: Fix brown-bag boolean thinko in cs_watchdog_read()

Paulo Alcantara (1):
      smb: client: handle lack of FSCTL_GET_REPARSE_POINT support

Perry Yuan (1):
      cpufreq: amd-pstate: auto-load pstate driver by default

Peter Oberparleiter (1):
      s390/sclp: Prevent release of buffer in I/O

Peter Wang (1):
      scsi: ufs: core: Fix deadlock during RTC update

Peter Zijlstra (3):
      jump_label: Fix the fix, brown paper bags galore
      x86/mm: Fix pti_clone_pgtable() alignment assumption
      x86/mm: Fix pti_clone_entry_text() for i386

Ping-Ke Shih (2):
      wifi: rtlwifi: handle return value of usb init TX/RX
      wifi: rtw89: pci: fix RX tag race condition resulting in wrong RX length

Prashanth K (1):
      usb: gadget: u_serial: Set start_delayed during suspend

Praveen Kaligineedi (1):
      gve: Fix use of netif_carrier_ok()

Qu Wenruo (2):
      btrfs: do not clear page dirty inside extent_write_locked_range()
      btrfs: avoid using fixed char array size for tree names

Radhey Shyam Pandey (1):
      irqchip/xilinx: Fix shift out of bounds

Ramesh Errabolu (1):
      drm/amd/amdkfd: Fix a resource leak in svm_range_validate_and_map()

Ricardo Ribalda (1):
      media: uvcvideo: Ignore empty TS packets

Richard Fitzgerald (4):
      regmap: kunit: Fix memory leaks in gen_regmap() and gen_raw_regmap()
      ASoC: cs-amp-lib: Fix NULL pointer crash if efi.get_variable is NULL
      ASoC: cs35l56: Revert support for dual-ownership of ASP registers
      ASoC: cs35l56: Handle OTP read latency over SoundWire

Rik van Riel (1):
      mm, slub: do not call do_slab_free for kfence object

Rodrigo Siqueira (2):
      drm/amd/display: Fix NULL pointer dereference for DTN log in DCN401
      drm/amd/display: Replace dm_execute_dmub_cmd with dc_wake_and_execute_dmub_cmd

Roman Smirnov (1):
      udf: prevent integer overflow in udf_bitmap_free_blocks()

Shakeel Butt (1):
      memcg: protect concurrent access to mem_cgroup_idr

Shay Drory (1):
      genirq/irqdesc: Honor caller provided affinity in alloc_desc()

Sibi Sankar (1):
      soc: qcom: icc-bwmon: Allow for interrupts to be shared across instances

Simon Ser (1):
      drm/atomic: allow no-op FB_ID updates for async flips

Srinivas Kandagatla (2):
      ASoC: codecs: wsa883x: parse port-mapping information
      ASoC: codecs: wsa884x: parse port-mapping information

Srinivasan Shanmugam (2):
      drm/amd/display: Add null checks for 'stream' and 'plane' before dereferencing
      drm/amd/display: Add NULL check for 'afb' before dereferencing in amdgpu_dm_plane_handle_cursor_update

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Fix scldiv calculation

Steve French (1):
      smb3: fix setting SecurityFlags when encryption is required

Steven 'Steve' Kendall (1):
      ALSA: hda: Add HP MP9 G4 Retail System AMS to force connect list

Steven Rostedt (2):
      tracefs: Use generic inode RCU for synchronizing freeing
      tracing: Have format file honor EVENT_FILE_FL_FREED

Sung-huai Wang (2):
      drm/amd/display: Handle HPD_IRQ for internal link
      Revert "drm/amd/display: Handle HPD_IRQ for internal link"

Swapnil Patel (1):
      drm/amd/display: Change ASSR disable sequence

Takashi Iwai (5):
      ALSA: usb-audio: Re-add ScratchAmp quirk entries
      ALSA: line6: Fix racy access to midibuf
      ALSA: hda/hdmi: Yet more pin fix for HP EliteDesk 800 G4
      usb: gadget: midi2: Fix the response for FB info with block 0xff
      ASoC: amd: yc: Add quirk entry for OMEN by HP Gaming Laptop 16-n0xxx

Tamim Khan (2):
      ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MU
      ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MJ

Tetsuo Handa (1):
      profiling: remove profile=sleep support

Thomas Gleixner (2):
      tick/broadcast: Move per CPU pointer access into the atomic section
      timekeeping: Fix bogus clock_was_set() invocation in do_adjtimex()

Thomas Weißschuh (2):
      ACPI: battery: create alarm sysfs attribute atomically
      ACPI: SBS: manage alarm sysfs attribute through psy core

Thomas Zimmermann (2):
      drm/mgag200: Set DDC timeout in milliseconds
      drm/mgag200: Bind I2C lifetime to DRM device

Tim Huang (1):
      drm/amdgpu: fix potential resource leak warning

Tristram Ha (1):
      net: dsa: microchip: Fix Wake-on-LAN check to not return an error

Tudor Ambarus (1):
      usb: gadget: f_fs: restore ffs_func_disable() functionality

Tze-nan Wu (1):
      tracing: Fix overflow in get_free_elt()

Uros Bizjak (2):
      locking/pvqspinlock: Correct the type of "old" variable in pv_kick_node()
      perf/x86/amd: Use try_cmpxchg() in events/amd/{un,}core.c

Vamshi Gajjela (1):
      scsi: ufs: core: Fix hba->last_dme_cmd_tstamp timestamp updating logic

Victor Skvortsov (1):
      drm/amdgpu: Add lock around VF RLCG interface

Viresh Kumar (1):
      xen: privcmd: Switch from mutex to spinlock for irqfds

Waiman Long (1):
      padata: Fix possible divide-by-0 panic in padata_mt_helper()

Wayne Lin (3):
      drm/amd/display: Refactor function dm_dp_mst_is_port_support_mode()
      drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
      drm/dp_mst: Skip CSN if topology probing is not done yet

Wenjing Liu (2):
      drm/amd/display: reduce ODM slice count to initial new dc state only when needed
      drm/amd/display: remove dpp pipes on failure to update pipe params

Wilken Gottwalt (1):
      hwmon: corsair-psu: add USB id of HX1200i Series 2023 psu

Willem de Bruijn (1):
      net: drop bad gso csum_start and offset in virtio_net_hdr

Wojciech Gładysz (1):
      ext4: sanity check for NULL pointer after ext4_force_shutdown

Xiaxi Shen (1):
      ext4: fix uninitialized variable in ext4_inlinedir_to_tree

Yang Yingliang (4):
      sched/smt: Introduce sched_smt_present_inc/dec() helper
      sched/smt: Fix unbalance sched_smt_present dec/inc
      sched/core: Introduce sched_set_rq_on/offline() helper
      sched/core: Fix unbalance set_rq_online/offline() in sched_cpu_deactivate()

Yipeng Zou (1):
      irqchip/mbigen: Fix mbigen node address layout

Yong-Xuan Wang (1):
      irqchip/riscv-aplic: Retrigger MSI interrupt on source configuration

Yonghong Song (1):
      selftests/bpf: Fix send_signal test with nested CONFIG_PARAVIRT

Yu Kuai (1):
      md/raid5: avoid BUG_ON() while continue reshape after reassembling

Zhang Rui (3):
      perf/x86/intel/cstate: Add Arrowlake support
      perf/x86/intel/cstate: Add Lunarlake support
      thermal: intel: hfi: Give HFI instances package scope

Zheng Zucheng (1):
      sched/cputime: Fix mul_u64_u64_div_u64() precision for cputime

Zhengchao Shao (1):
      net/smc: add the max value of fallback reason count

Zhenyu Wang (1):
      perf/x86/intel/cstate: Add pkg C2 residency counter for Sierra Forest

Zong-Zhe Yang (1):
      wifi: mac80211: fix NULL dereference at band check in starting tx ba session


