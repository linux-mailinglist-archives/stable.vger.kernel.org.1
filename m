Return-Path: <stable+bounces-160286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEF8AFA3E6
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8123BA400
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 09:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F311F4717;
	Sun,  6 Jul 2025 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bcJwFFTC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45881F4706;
	Sun,  6 Jul 2025 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751793233; cv=none; b=gUDHMIvkl52leQjbHxme66yzx7wkldf+H+6AKs0EI1K3MxpxpqT6rv4BNXduJK4AHdpLlDD8J5Fk/qeqlYEzhxMTaENCwDrOVxaoZ1BDPoMkO21AlJJooMxr2B0u1J3A7q1KcCNEE1D8Q333llrFT+oA/IMgvhyUrDgZ+i7Al+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751793233; c=relaxed/simple;
	bh=nSkCWuzyhD20Gjuj5yryDKeFjD3qAoM+rwoitQE1xL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pcbjBROpnxUcyj+jPUM+ZlMDWLP45D+IY7mUghF3grE/q0bwkpcASSOa9gQkbgr4aFK5tHwoXAUKgK+wsiZCR8BL9mdmSLM+7pGMj0uHupQ/VPyNDR5DF3F4fym4jwg9RFfRNj/uQwLeb7hSN6FKfCkklA8cRA7ZYB+5WkmYDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bcJwFFTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D586DC4CEED;
	Sun,  6 Jul 2025 09:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751793233;
	bh=nSkCWuzyhD20Gjuj5yryDKeFjD3qAoM+rwoitQE1xL8=;
	h=From:To:Cc:Subject:Date:From;
	b=bcJwFFTCs5mNAmjCEDGBbNYPLgjmtxuJyThCDXZnsSTDBhLA2HV4ifLHi84Flxlqd
	 4io6SOOmXNf53aGm1yaFPDzLNpeg7HyEesaFqWi0Gi+hg054MByQlmAQJYxbDL8tWf
	 0ciCMeh6f9bZc1Kwv8/dMQVb8Qh6XVfhDVoqYp7M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.15.5
Date: Sun,  6 Jul 2025 11:13:45 +0200
Message-ID: <2025070646-unopposed-nutrient-8e1c@gregkh>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.15.5 kernel.

All users of the 6.15 kernel series must upgrade.

The updated 6.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/8250.yaml                             |    2 
 Documentation/netlink/specs/tc.yaml                                            |    4 
 Makefile                                                                       |    2 
 arch/arm64/boot/dts/qcom/x1-crd.dtsi                                           | 1277 ++++++++++
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts                     |   45 
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts                                      | 1270 ---------
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                                         |    2 
 arch/loongarch/kvm/intc/eiointc.c                                              |   89 
 arch/powerpc/crypto/Kconfig                                                    |    1 
 arch/riscv/include/asm/cpufeature.h                                            |    5 
 arch/riscv/include/asm/pgtable.h                                               |    1 
 arch/riscv/include/asm/processor.h                                             |    1 
 arch/riscv/include/asm/runtime-const.h                                         |    2 
 arch/riscv/include/asm/vector.h                                                |   12 
 arch/riscv/kernel/asm-offsets.c                                                |    5 
 arch/riscv/kernel/entry.S                                                      |    9 
 arch/riscv/kernel/setup.c                                                      |    1 
 arch/riscv/kernel/traps_misaligned.c                                           |    6 
 arch/riscv/mm/cacheflush.c                                                     |   15 
 arch/s390/kernel/ptrace.c                                                      |    2 
 arch/s390/mm/fault.c                                                           |    2 
 arch/um/drivers/ubd_user.c                                                     |    2 
 arch/um/include/asm/asm-prototypes.h                                           |    5 
 arch/um/kernel/trap.c                                                          |  129 -
 arch/x86/include/uapi/asm/debugreg.h                                           |   21 
 arch/x86/kernel/cpu/common.c                                                   |   24 
 arch/x86/kernel/fpu/signal.c                                                   |   11 
 arch/x86/kernel/fpu/xstate.h                                                   |   22 
 arch/x86/kernel/traps.c                                                        |   34 
 arch/x86/um/asm/checksum.h                                                     |    3 
 drivers/ata/ahci.c                                                             |    2 
 drivers/bus/mhi/host/pci_generic.c                                             |   39 
 drivers/cxl/core/ras.c                                                         |   47 
 drivers/cxl/core/region.c                                                      |    9 
 drivers/dma/idxd/cdev.c                                                        |    4 
 drivers/dma/xilinx/xilinx_dma.c                                                |    2 
 drivers/edac/amd64_edac.c                                                      |   57 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                                  |   28 
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c                                      |   30 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                                        |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                                        |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h                                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                                        |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                                        |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h                                       |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c                                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c                                      |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h                                      |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                                   |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                         |    5 
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c                                         |    9 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                                         |   10 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                                         |    3 
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c                                         |    2 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c                                       |    6 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                                          |   19 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                                          |   20 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                          |   20 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c                                        |   21 
 drivers/gpu/drm/amd/amdkfd/kfd_events.c                                        |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c                             |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                              |   97 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c                      |    4 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                       |   33 
 drivers/gpu/drm/amd/display/dc/dc.h                                            |    8 
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h                                   |    4 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c           |    1 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c |    5 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c                  |    1 
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c                      |    9 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c                        |   28 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c             |   46 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h             |    3 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c               |    1 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c        |   52 
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c                 |    3 
 drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c               |    3 
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c                 |    3 
 drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c               |    3 
 drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c                 |    3 
 drivers/gpu/drm/amd/display/include/link_service_types.h                       |    2 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c                            |    3 
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                                            |   22 
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h                                        |    1 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                                 |   12 
 drivers/gpu/drm/ast/ast_mode.c                                                 |    6 
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c                                 |   32 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                                          |  109 
 drivers/gpu/drm/drm_writeback.c                                                |    7 
 drivers/gpu/drm/etnaviv/etnaviv_sched.c                                        |    5 
 drivers/gpu/drm/i915/display/intel_cx0_phy.c                                   |   27 
 drivers/gpu/drm/i915/display/intel_cx0_phy_regs.h                              |   15 
 drivers/gpu/drm/i915/display/intel_display_driver.c                            |   30 
 drivers/gpu/drm/i915/display/intel_dp.c                                        |   17 
 drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c                             |    4 
 drivers/gpu/drm/i915/display/vlv_dsi.c                                         |    4 
 drivers/gpu/drm/i915/i915_pmu.c                                                |    2 
 drivers/gpu/drm/msm/msm_gpu_devfreq.c                                          |    1 
 drivers/gpu/drm/panel/panel-simple.c                                           |    6 
 drivers/gpu/drm/scheduler/sched_entity.c                                       |    1 
 drivers/gpu/drm/tegra/dc.c                                                     |   17 
 drivers/gpu/drm/tegra/hub.c                                                    |    4 
 drivers/gpu/drm/tegra/hub.h                                                    |    3 
 drivers/gpu/drm/tiny/cirrus-qemu.c                                             |    1 
 drivers/gpu/drm/tiny/simpledrm.c                                               |    4 
 drivers/gpu/drm/udl/udl_drv.c                                                  |    2 
 drivers/gpu/drm/xe/display/xe_display.c                                        |    2 
 drivers/gpu/drm/xe/display/xe_dsb_buffer.c                                     |   11 
 drivers/gpu/drm/xe/display/xe_fb_pin.c                                         |    5 
 drivers/gpu/drm/xe/xe_ggtt.c                                                   |   11 
 drivers/gpu/drm/xe/xe_gpu_scheduler.h                                          |   10 
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c                                    |    8 
 drivers/gpu/drm/xe/xe_guc_ct.c                                                 |   17 
 drivers/gpu/drm/xe/xe_guc_ct.h                                                 |    5 
 drivers/gpu/drm/xe/xe_guc_pc.c                                                 |    2 
 drivers/gpu/drm/xe/xe_guc_submit.c                                             |   23 
 drivers/gpu/drm/xe/xe_guc_types.h                                              |    5 
 drivers/gpu/drm/xe/xe_vm.c                                                     |    8 
 drivers/hid/hid-appletb-kbd.c                                                  |    5 
 drivers/hid/hid-lenovo.c                                                       |   11 
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c                   |   26 
 drivers/hid/wacom_sys.c                                                        |    7 
 drivers/hwmon/isl28022.c                                                       |    6 
 drivers/hwmon/pmbus/max34440.c                                                 |   48 
 drivers/hwtracing/coresight/coresight-core.c                                   |    3 
 drivers/hwtracing/coresight/coresight-priv.h                                   |    1 
 drivers/i2c/busses/i2c-imx.c                                                   |    3 
 drivers/i2c/busses/i2c-omap.c                                                  |    7 
 drivers/i2c/busses/i2c-robotfuzz-osif.c                                        |    6 
 drivers/i2c/busses/i2c-tiny-usb.c                                              |    6 
 drivers/iio/adc/ad7606_spi.c                                                   |    8 
 drivers/iio/adc/ad_sigma_delta.c                                               |    4 
 drivers/iio/dac/adi-axi-dac.c                                                  |   24 
 drivers/iio/light/al3000a.c                                                    |    9 
 drivers/iio/light/hid-sensor-prox.c                                            |    3 
 drivers/iio/pressure/zpa2326.c                                                 |    2 
 drivers/leds/led-class-multicolor.c                                            |    3 
 drivers/mailbox/mailbox.c                                                      |    2 
 drivers/md/bcache/Kconfig                                                      |    1 
 drivers/md/bcache/alloc.c                                                      |   57 
 drivers/md/bcache/bcache.h                                                     |    2 
 drivers/md/bcache/bset.c                                                       |  116 
 drivers/md/bcache/bset.h                                                       |   40 
 drivers/md/bcache/btree.c                                                      |   69 
 drivers/md/bcache/extents.c                                                    |   45 
 drivers/md/bcache/movinggc.c                                                   |   33 
 drivers/md/bcache/super.c                                                      |   10 
 drivers/md/bcache/sysfs.c                                                      |    4 
 drivers/md/bcache/util.h                                                       |   67 
 drivers/md/bcache/writeback.c                                                  |   13 
 drivers/md/dm-raid.c                                                           |    2 
 drivers/md/dm-vdo/indexer/volume.c                                             |   24 
 drivers/md/md-bitmap.c                                                         |    2 
 drivers/media/usb/uvc/uvc_ctrl.c                                               |   70 
 drivers/media/usb/uvc/uvc_v4l2.c                                               |   91 
 drivers/media/usb/uvc/uvcvideo.h                                               |    5 
 drivers/mfd/88pm886.c                                                          |    6 
 drivers/mfd/max14577.c                                                         |    1 
 drivers/mfd/max77541.c                                                         |    2 
 drivers/mfd/max77705.c                                                         |    4 
 drivers/mfd/sprd-sc27xx-spi.c                                                  |    5 
 drivers/misc/tps6594-pfsm.c                                                    |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                      |    5 
 drivers/net/ethernet/freescale/enetc/enetc_hw.h                                |    2 
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c                               |   12 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                                    |    2 
 drivers/net/wireless/intel/iwlwifi/mld/fw.c                                    |    8 
 drivers/nvme/host/core.c                                                       |   83 
 drivers/nvme/host/nvme.h                                                       |    3 
 drivers/nvme/host/tcp.c                                                        |   22 
 drivers/pci/controller/dwc/pci-imx6.c                                          |   15 
 drivers/pci/controller/dwc/pcie-designware.c                                   |    5 
 drivers/pci/controller/pcie-apple.c                                            |    3 
 drivers/s390/crypto/pkey_api.c                                                 |    2 
 drivers/scsi/fnic/fdls_disc.c                                                  |  122 
 drivers/scsi/fnic/fnic.h                                                       |    2 
 drivers/scsi/fnic/fnic_fcs.c                                                   |    2 
 drivers/scsi/fnic/fnic_fdls.h                                                  |    1 
 drivers/scsi/megaraid/megaraid_sas_base.c                                      |    6 
 drivers/spi/spi-cadence-quadspi.c                                              |   12 
 drivers/staging/rtl8723bs/core/rtw_security.c                                  |   44 
 drivers/tty/serial/8250/8250_pci1xxxx.c                                        |   10 
 drivers/tty/serial/imx.c                                                       |   17 
 drivers/tty/serial/serial_base_bus.c                                           |    1 
 drivers/tty/serial/uartlite.c                                                  |   25 
 drivers/ufs/core/ufshcd.c                                                      |    6 
 drivers/usb/class/cdc-wdm.c                                                    |   23 
 drivers/usb/common/usb-conn-gpio.c                                             |   25 
 drivers/usb/core/usb.c                                                         |   14 
 drivers/usb/dwc2/gadget.c                                                      |    6 
 drivers/usb/gadget/function/f_hid.c                                            |   19 
 drivers/usb/gadget/function/f_tcm.c                                            |    4 
 drivers/usb/typec/altmodes/displayport.c                                       |    4 
 drivers/usb/typec/mux.c                                                        |    4 
 drivers/usb/typec/tcpm/tcpci_maxim_core.c                                      |    5 
 drivers/usb/typec/tipd/core.c                                                  |    2 
 fs/btrfs/backref.h                                                             |    4 
 fs/btrfs/direct-io.c                                                           |    4 
 fs/btrfs/disk-io.c                                                             |   25 
 fs/btrfs/extent_io.h                                                           |    2 
 fs/btrfs/inode.c                                                               |   93 
 fs/btrfs/ordered-data.c                                                        |   14 
 fs/btrfs/raid56.c                                                              |    5 
 fs/btrfs/tests/extent-io-tests.c                                               |    6 
 fs/btrfs/tree-log.c                                                            |   14 
 fs/btrfs/volumes.c                                                             |    6 
 fs/btrfs/zstd.c                                                                |    2 
 fs/ceph/file.c                                                                 |    2 
 fs/f2fs/file.c                                                                 |   38 
 fs/f2fs/super.c                                                                |   30 
 fs/fuse/dir.c                                                                  |   11 
 fs/fuse/inode.c                                                                |    4 
 fs/namespace.c                                                                 |   18 
 fs/nfs/inode.c                                                                 |   51 
 fs/nfs/nfs4proc.c                                                              |   25 
 fs/overlayfs/util.c                                                            |    4 
 fs/proc/task_mmu.c                                                             |    2 
 fs/smb/client/cifsglob.h                                                       |    2 
 fs/smb/client/cifspdu.h                                                        |    6 
 fs/smb/client/cifssmb.c                                                        |    1 
 fs/smb/client/connect.c                                                        |   58 
 fs/smb/client/misc.c                                                           |    8 
 fs/smb/client/reparse.c                                                        |   20 
 fs/smb/client/sess.c                                                           |   21 
 fs/smb/client/trace.h                                                          |   24 
 fs/smb/server/connection.h                                                     |    1 
 fs/smb/server/smb2pdu.c                                                        |   72 
 fs/smb/server/smb2pdu.h                                                        |    3 
 include/net/bluetooth/hci_core.h                                               |    2 
 include/uapi/linux/vm_sockets.h                                                |    4 
 io_uring/io_uring.c                                                            |    3 
 io_uring/kbuf.c                                                                |    1 
 io_uring/kbuf.h                                                                |    1 
 io_uring/net.c                                                                 |   34 
 io_uring/rsrc.c                                                                |   57 
 io_uring/rsrc.h                                                                |    3 
 io_uring/zcrx.c                                                                |  101 
 io_uring/zcrx.h                                                                |   11 
 kernel/sched/ext.c                                                             |   12 
 lib/group_cpus.c                                                               |    9 
 lib/maple_tree.c                                                               |    4 
 mm/damon/sysfs-schemes.c                                                       |    1 
 mm/gup.c                                                                       |   14 
 mm/memory.c                                                                    |   20 
 mm/shmem.c                                                                     |    6 
 mm/swap.h                                                                      |   23 
 mm/userfaultfd.c                                                               |   33 
 net/atm/clip.c                                                                 |   11 
 net/atm/resources.c                                                            |    3 
 net/bluetooth/hci_core.c                                                       |   34 
 net/bluetooth/l2cap_core.c                                                     |    9 
 net/bridge/br_multicast.c                                                      |    9 
 net/core/netpoll.c                                                             |    2 
 net/core/selftests.c                                                           |    5 
 net/mac80211/chan.c                                                            |    3 
 net/mac80211/ieee80211_i.h                                                     |   12 
 net/mac80211/iface.c                                                           |   12 
 net/mac80211/link.c                                                            |   94 
 net/mac80211/util.c                                                            |    2 
 net/sunrpc/clnt.c                                                              |    9 
 net/unix/af_unix.c                                                             |   31 
 rust/Makefile                                                                  |    2 
 rust/bindings/bindings_helper.h                                                |    1 
 rust/helpers/completion.c                                                      |    8 
 rust/helpers/helpers.c                                                         |    1 
 rust/kernel/devres.rs                                                          |   53 
 rust/kernel/revocable.rs                                                       |   18 
 rust/kernel/sync.rs                                                            |    2 
 rust/kernel/sync/completion.rs                                                 |  112 
 rust/macros/module.rs                                                          |    1 
 scripts/gdb/linux/vfs.py                                                       |    2 
 security/selinux/ss/services.c                                                 |   16 
 sound/pci/hda/hda_bind.c                                                       |    2 
 sound/pci/hda/hda_intel.c                                                      |    3 
 sound/pci/hda/patch_realtek.c                                                  |    1 
 sound/soc/amd/ps/acp63.h                                                       |    4 
 sound/soc/amd/ps/ps-common.c                                                   |   18 
 sound/soc/amd/yc/acp6x-mach.c                                                  |    7 
 sound/soc/codecs/rt1320-sdw.c                                                  |   17 
 sound/soc/codecs/wcd9335.c                                                     |   40 
 sound/usb/quirks.c                                                             |    2 
 sound/usb/stream.c                                                             |    2 
 tools/lib/bpf/btf_dump.c                                                       |    3 
 tools/lib/bpf/libbpf.c                                                         |   10 
 tools/testing/selftests/bpf/progs/test_global_map_resize.c                     |   16 
 287 files changed, 4524 insertions(+), 2532 deletions(-)

Adin Scannell (1):
      libbpf: Fix possible use-after-free for externs

Aidan Stewart (1):
      serial: core: restore of_node information in sysfs

Al Viro (2):
      attach_recursive_mnt(): do not lock the covering tree when sliding something under it
      userns and mnt_idmap leak in open_tree_attr(2)

Alex Deucher (4):
      drm/amdgpu/mes: add compatibility checks for set_hw_resource_1
      drm/amdgpu: disable workload profile switching when OD is enabled
      drm/amdgpu: switch job hw_fence to amdgpu_fence
      drm/amdgpu/mes: add missing locking in helper functions

Alex Hung (2):
      drm/amd/display: Check dce_hwseq before dereferencing it
      drm/amd/display: Fix mpv playback corruption on weston

Alexis Czezar Torreno (1):
      hwmon: (pmbus/max34440) Fix support for max34451

Andy Chiu (1):
      riscv: add a data fence for CMODX in the kernel mode

Andy Shevchenko (1):
      usb: Add checks for snprintf() calls in usb_alloc_dev()

Angelo Dureghello (1):
      iio: dac: adi-axi-dac: add cntrl chan check

Ankit Nautiyal (1):
      drm/i915/snps_hdmi_pll: Fix 64-bit divisor truncation by using div64_u64

Aradhya Bhatia (5):
      drm/bridge: cdns-dsi: Fix the clock variable for mode_valid()
      drm/bridge: cdns-dsi: Fix phy de-init and flag it so
      drm/bridge: cdns-dsi: Fix connecting to next bridge
      drm/bridge: cdns-dsi: Check return value when getting default PHY config
      drm/bridge: cdns-dsi: Wait for Clk and Data Lanes to be ready

Arnd Bergmann (1):
      drm/i915: fix build error some more

Avadhut Naik (1):
      EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs

Ben Dooks (1):
      riscv: save the SR_SUM status over switches

Benjamin Berg (1):
      um: use proper care when taking mmap lock during segfault

Bibo Mao (6):
      LoongArch: KVM: Avoid overflow with array index
      LoongArch: KVM: Check validity of "num_cpu" from user space
      LoongArch: KVM: Disable updating of "num_cpu" and "feature"
      LoongArch: KVM: Add address alignment check for IOCSR emulation
      LoongArch: KVM: Fix interrupt route update with EIOINTC
      LoongArch: KVM: Check interrupt route from physical CPU

Breno Leitao (1):
      net: netpoll: Initialize UDP checksum field before checksumming

Cezary Rojewski (1):
      ALSA: hda: Ignore unsol events for cards being shut down

Chance Yang (1):
      usb: common: usb-conn-gpio: use a unique name for usb connector device

Chang S. Bae (2):
      x86/fpu: Refactor xfeature bitmask update code for sigframe XSAVE
      x86/pkeys: Simplify PKRU update in signal frame

Chao Yu (2):
      f2fs: don't over-report free space or inodes in statvfs
      f2fs: fix to zero post-eof page

Charles Mirabile (1):
      riscv: fix runtime constant support for nommu kernels

Chen Yu (1):
      scsi: megaraid_sas: Fix invalid node index

Chen Yufeng (1):
      usb: potential integer overflow in usbg_make_tpg()

Chenyuan Yang (1):
      misc: tps6594-pfsm: Add NULL pointer check in tps6594_pfsm_probe()

Christoph Hellwig (2):
      nvme: refactor the atomic write unit detection
      nvme: fix atomic write size validation

Christophe JAILLET (1):
      i2c: omap: Fix an error handling path in omap_i2c_probe()

Clément Léger (1):
      riscv: misaligned: declare misaligned_access_speed under CONFIG_RISCV_MISALIGNED

Cyril Bur (1):
      riscv: uaccess: Only restore the CSR_STATUS SUM bit

Dan Williams (1):
      cxl/ras: Fix CPER handler device confusion

Daniele Ceraolo Spurio (1):
      drm/xe: Fix early wedge on GuC load failure

Daniele Palmas (1):
      bus: mhi: host: pci_generic: Add Telit FN920C04 modem support

Danilo Krummrich (4):
      rust: completion: implement initial abstraction
      rust: revocable: indicate whether `data` has been revoked already
      rust: devres: fix race in Devres::drop()
      rust: devres: do not dereference to the internal Revocable

David (Ming Qiang) Wu (4):
      drm/amdgpu/vcn5.0.1: read back register after written
      drm/amdgpu/vcn4: read back register after written
      drm/amdgpu/vcn3: read back register after written
      drm/amdgpu/vcn2.5: read back register after written

David Heidelberg (1):
      iio: light: al3000a: Fix an error handling path in al3000a_probe()

David Hildenbrand (2):
      fs/proc/task_mmu: fix PAGE_IS_PFNZERO detection for the huge zero folio
      mm/gup: revert "mm: gup: fix infinite loop within __get_longterm_locked"

David Lechner (1):
      iio: adc: ad7606_spi: check error in ad7606B_sw_mode_config()

David Sterba (1):
      btrfs: use unsigned types for constants defined as bit shifts

Dmitry Kandybka (1):
      ceph: fix possible integer overflow in ceph_zero_objects()

Eric Biggers (1):
      crypto: powerpc/poly1305 - add depends on BROKEN for now

Eric Dumazet (1):
      atm: clip: prevent NULL deref in clip_push()

Even Xu (1):
      HID: Intel-thc-hid: Intel-quicki2c: Enhance QuickI2C reset flow

FUJITA Tomonori (1):
      rust: module: place cleanup_module() in .exit.text section

Fabio Estevam (1):
      serial: imx: Restore original RXTL for console to fix data loss

Fedor Pchelkin (1):
      s390/pkey: Prevent overflow in size calculation for memdup_user()

Filipe Manana (4):
      btrfs: fix race between async reclaim worker and close_ctree()
      btrfs: fix qgroup reservation leak on failure to allocate ordered extent
      btrfs: fix a race between renames and directory logging
      btrfs: fix invalid inode pointer dereferences during log replay

Florian Fainelli (1):
      scripts/gdb: fix dentry_name() lookup

Frank Min (2):
      drm/amdgpu: Add kicker device detection
      drm/amdgpu: add kicker fws loading for gfx11/smu13/psp13

Frédéric Danis (1):
      Bluetooth: L2CAP: Fix L2CAP MTU negotiation

Greg Kroah-Hartman (1):
      Linux 6.15.5

Gregory Price (1):
      cxl: core/region - ignore interleave granularity when ways=1

Guang Yuan Wu (1):
      fuse: fix race between concurrent setattrs from multiple nodes

Haiyue Wang (1):
      fuse: fix runtime warning on truncate_folio_batch_exceptionals()

Han Gao (1):
      riscv: vector: Fix context save/restore with xtheadvector

Han Young (1):
      NFSv4: Always set NLINK even if the server doesn't support it

Hannes Reinecke (2):
      nvme-tcp: fix I/O stalls on congested sockets
      nvme-tcp: sanitize request list handling

Haoxiang Li (2):
      drm/i915/display: Add check for alloc_ordered_workqueue() and alloc_workqueue()
      drm/xe/display: Add check for alloc_ordered_workqueue()

Hector Martin (1):
      PCI: apple: Fix missing OF node reference in apple_pcie_setup_port

Heiko Carstens (2):
      s390/mm: Fix in_atomic() handling in do_secure_storage_access()
      s390/ptrace: Fix pointer dereferencing in regs_get_kernel_stack_nth()

Heinz Mauelshagen (1):
      dm-raid: fix variable in journal device check

Ido Schimmel (1):
      bridge: mcast: Fix use-after-free during router port configuration

Ilan Peer (1):
      wifi: iwlwifi: mld: Move regulatory domain initialization

Imre Deak (2):
      drm/i915/ptl: Use everywhere the correct DDI port clock select mask
      drm/i915/dp_mst: Work around Thunderbolt sink disconnect after SINK_COUNT_ESI read

Iusico Maxim (1):
      HID: lenovo: Restrict F7/9/11 mode to compact keyboards only

Jakub Kicinski (2):
      netlink: specs: tc: replace underscores with dashes in names
      net: selftests: fix TCP packet checksum

Jakub Lewalski (1):
      tty: serial: uartlite: register uart driver in init

James Clark (1):
      coresight: Only check bottom two claim bits

Jay Cornwall (1):
      drm/amdkfd: Fix race in GWS queue scheduling

Jayesh Choudhary (1):
      drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort connector type

Jens Axboe (3):
      io_uring/net: mark iov as dynamically allocated even for single segments
      io_uring/kbuf: flag partial buffer mappings
      io_uring: gate REQ_F_ISREG on !S_ANON_INODE as well

Jesse Zhang (1):
      drm/amdgpu: Fix SDMA UTC_L1 handling during start/stop sequences

Jiawen Wu (1):
      net: libwx: fix the creation of page_pool

Johan Hovold (1):
      arm64: dts: qcom: x1e80100-crd: mark l12b and l15b always-on

Johannes Berg (1):
      wifi: mac80211: finish link init before RCU publish

John Olender (1):
      drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to total vram

Jonathan Cameron (1):
      iio: pressure: zpa2326: Use aligned_s64 for the timestamp

Joonas Lahtinen (1):
      Revert "drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1"

Jos Wang (1):
      usb: typec: displayport: Receive DP Status Update NAK request exit dp altmode

Kairui Song (2):
      mm: userfaultfd: fix race of userfaultfd_move and swap cache
      mm/shmem, swap: fix softlockup with mTHP swapin

Karan Tilak Kumar (2):
      scsi: fnic: Fix crash in fnic_wq_cmpl_handler when FDMI times out
      scsi: fnic: Turn off FDMI ACTIVE flags on link down

Kees Cook (1):
      ovl: Check for NULL d_inode() in ovl_dentry_upper()

Khairul Anuar Romli (1):
      spi: spi-cadence-quadspi: Fix pm runtime unbalance

Klara Modin (1):
      riscv: export boot_cpu_hartid

Konrad Dybcio (1):
      arm64: dts: qcom: Commonize X1 CRD DTSI

Krzysztof Kozlowski (8):
      mfd: max77541: Fix wakeup source leaks on device unbind
      mfd: max14577: Fix wakeup source leaks on device unbind
      mfd: max77705: Fix wakeup source leaks on device unbind
      mfd: 88pm886: Fix wakeup source leaks on device unbind
      mfd: sprd-sc27xx: Fix wakeup source leaks on device unbind
      usb: typec: tcpci: Fix wakeup source leaks on device unbind
      usb: typec: tipd: Fix wakeup source leaks on device unbind
      ASoC: codecs: wcd9335: Fix missing free of regulator supplies

Kuan-Wei Chiu (3):
      bcache: remove unnecessary select MIN_HEAP
      Revert "bcache: update min_heap_callbacks to use default builtin swap"
      Revert "bcache: remove heap-related macros and switch to generic min_heap"

Kuniyuki Iwashima (4):
      af_unix: Don't leave consecutive consumed OOB skbs.
      Bluetooth: hci_core: Fix use-after-free in vhci_flush()
      af_unix: Don't set -ECONNRESET for consumed OOB skb.
      atm: Release atm_dev_mutex after removing procfs in atm_dev_deregister().

Lachlan Hodges (1):
      wifi: mac80211: fix beacon interval calculation overflow

Liam R. Howlett (1):
      maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()

Lin.Cao (1):
      drm/scheduler: signal scheduled fence when kill job

Linggang Zeng (1):
      bcache: fix NULL pointer in cache_set_flush()

Louis Chauvet (1):
      drm: writeback: Fix drm_writeback_connector_cleanup signature

Luca Ceresoli (1):
      drm/panel: simple: Tianma TM070JDHG34-00: add delays

Lucas De Marchi (2):
      drm/xe: Fix memset on iomem
      drm/xe: Fix taking invalid lock on wedge

Lukasz Kucharczyk (1):
      i2c: imx: fix emulated smbus block read

Maarten Lankhorst (1):
      drm/xe: Move DSB l2 flush to a more sensible place

Mario Limonciello (8):
      ALSA: usb-audio: Add a quirk for Lenovo Thinkpad Thunderbolt 3 dock
      drm/amd: Adjust output for discovery error handling
      drm/amd/display: Add debugging message for brightness caps
      drm/amd/display: Fix default DC and AC levels
      drm/amd/display: Only read ACPI backlight caps once
      drm/amd/display: Optimize custom brightness curve
      drm/amd/display: Export full brightness range to userspace
      drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value

Mark Harmstone (1):
      btrfs: update superblock's device bytes_used when dropping chunk

Matthew Auld (4):
      drm/xe: move DPT l2 flush to a more sensible place
      drm/xe/vm: move rebind_work init earlier
      drm/xe/sched: stop re-submitting signalled jobs
      drm/xe/guc_submit: add back fix

Matthew Sakai (1):
      dm vdo indexer: don't read request structure after enqueuing

Maíra Canal (1):
      drm/etnaviv: Protect the scheduler's pending list with its lock

Michael Grzeschik (2):
      usb: dwc2: also exit clock_gating when stopping udc while suspended
      usb: typec: mux: do not return on EOPNOTSUPP in {mux, switch}_set

Michael Strauss (2):
      drm/amd/display: Add early 8b/10b channel equalization test pattern sequence
      drm/amd/display: Get LTTPR IEEE OUI/Device ID From Closest LTTPR To Host

Michal Wajdeczko (2):
      drm/xe/guc: Explicitly exit CT safe mode on unwind
      drm/xe: Process deferred GGTT node removals on device unwind

Muna Sinada (2):
      wifi: mac80211: Add link iteration macro for link data
      wifi: mac80211: Create separate links for VLAN interfaces

Nam Cao (2):
      Revert "riscv: Define TASK_SIZE_MAX for __access_ok()"
      Revert "riscv: misaligned: fix sleeping function called during misaligned access handling"

Namjae Jeon (2):
      ksmbd: allow a filename to contain special characters on SMB3.1.1 posix extension
      ksmbd: provide zero as a unique ID to the Mac client

Nathan Chancellor (1):
      staging: rtl8723bs: Avoid memset() in aes_cipher() and aes_decipher()

Nicholas Kazlauskas (1):
      drm/amd/display: Add more checks for DSC / HUBP ONO guarantees

Nikhil Jha (1):
      sunrpc: don't immediately retransmit on seqno miss

Niklas Cassel (1):
      ata: ahci: Use correct DMI identifier for ASUSPRO-D840SA LPM quirk

Olga Kornievskaia (1):
      NFSv4.2: fix listxattr to return selinux security label

Oliver Schramm (1):
      ASoC: amd: yc: Add DMI quirk for Lenovo IdeaPad Slim 5 15

Pali Rohár (3):
      cifs: Correctly set SMB1 SessionKey field in Session Setup Request
      cifs: Fix cifs_query_path_info() for Windows NT servers
      cifs: Fix encoding of SMB1 Session Setup NTLMSSP Request in non-UNICODE mode

Paulo Alcantara (2):
      smb: client: fix regression with native SMB symlinks
      smb: client: fix potential deadlock when reconnecting channels

Pavel Begunkov (7):
      io_uring/zcrx: move io_zcrx_iov_page
      io_uring/zcrx: improve area validation
      io_uring/zcrx: split out memory holders from area
      io_uring/zcrx: fix area release on registration failure
      io_uring/rsrc: fix folio unpinning
      io_uring/rsrc: don't rely on user vaddr alignment
      io_uring: don't assume uaddr alignment in io_vec_fill_bvec

Peichen Huang (1):
      drm/amd/display: Add dc cap for dp tunneling

Peng Fan (2):
      mailbox: Not protect module_put with spin_lock_irqsave
      ASoC: codec: wcd9335: Convert to GPIO descriptors

Peter Korsgaard (1):
      usb: gadget: f_hid: wake up readers on disable/unbind

Philip Yang (1):
      drm/amdgpu: seq64 memory unmap uses uninterruptible lock

Purva Yeshi (1):
      iio: adc: ad_sigma_delta: Fix use of uninitialized status_pos

Qasim Ijaz (4):
      HID: appletb-kbd: fix "appletb_backlight" backlight device reference counting
      HID: wacom: fix memory leak on kobject creation failure
      HID: wacom: fix memory leak on sysfs attribute creation failure
      HID: wacom: fix kobject reference count leak

Qiu-ji Chen (1):
      drm/tegra: Fix a possible null pointer dereference

Qu Wenruo (1):
      btrfs: handle csum tree error with rescue=ibadroots correctly

Rengarajan S (1):
      8250: microchip: pci1xxxx: Add PCIe Hot reset disable support for Rev C0 and later devices

Ricardo Ribalda (4):
      media: uvcvideo: Keep streaming state in the file handle
      media: uvcvideo: Create uvc_pm_(get|put) functions
      media: uvcvideo: Increase/decrease the PM counter per IOCTL
      media: uvcvideo: Rollback non processed entities on error

Richard Zhu (1):
      PCI: imx6: Add workaround for errata ERR051624

Robert Hodaszi (1):
      usb: cdc-wdm: avoid setting WDM_READ for ZLP-s

Robert Richter (1):
      cxl/region: Add a dev_err() on missing target list entries

Rudraksha Gupta (1):
      rust: arm: fix unknown (to Clang) argument '-mno-fdpic'

Sagi Grimberg (1):
      NFSv4.2: fix setattr caching of TIME_[MODIFY|ACCESS]_SET when timestamps are delegated

Salvatore Bonaccorso (1):
      ALSA: hda/realtek: Fix built-in mic on ASUS VivoBook X507UAR

Sami Tolvanen (1):
      um: Add cmpxchg8b_emu and checksum functions to asm-prototypes.h

Sasha Levin (3):
      arm64: dts: qcom: x1e78100-t14s: mark l12b and l15b always-on
      arm64: dts: qcom: x1e78100-t14s: fix missing HID supplies
      sched_ext: Make scx_group_set_weight() always update tg->scx.weight

Scott Mayhew (1):
      NFSv4: xattr handlers should check for absent nfs filehandles

SeongJae Park (1):
      mm/damon/sysfs-schemes: free old damon_sysfs_scheme_filter->memcg_path on write

Shuming Fan (1):
      ASoC: rt1320: fix speaker noise when volume bar is 100%

Simon Horman (1):
      net: enetc: Correct endianness handling in _enetc_rd_reg64

Sonny Jiang (1):
      drm/amdgpu: VCN v5_0_1 to prevent FW checking RB during DPG pause

Stefan Metzmacher (1):
      smb: client: remove \t from TP_printk statements

Stefano Garzarella (1):
      vsock/uapi: fix linux/vm_sockets.h userspace compilation errors

Stephan Gerhold (2):
      drm/msm/gpu: Fix crash when throttling GPU immediately during boot
      arm64: dts: qcom: x1-crd: Fix vreg_l2j_1p2 voltage

Stephen Smalley (1):
      selinux: change security_compute_sid to return the ssid or tsid on match

Sven Schwermer (1):
      leds: multicolor: Fix intensity setting while SW blinking

Takashi Iwai (1):
      drm/amd/display: Add sanity checks for drm_edid_raw()

Thierry Reding (1):
      drm/tegra: Assign plane type before registration

Thomas Fourier (2):
      scsi: fnic: Fix missing DMA mapping error in fnic_send_frame()
      ethernet: ionic: Fix DMA mapping tests

Thomas Gessler (1):
      dmaengine: xilinx_dma: Set dma_device directions

Thomas Zeitlhofer (1):
      HID: wacom: fix crash in wacom_aes_battery_handler()

Thomas Zimmermann (4):
      drm/ast: Fix comment on modeset lock
      drm/cirrus-qemu: Fix pitch programming
      drm/simpledrm: Do not upcast in release helpers
      drm/udl: Unregister device before cleaning up on disconnect

Tiwei Bie (1):
      um: ubd: Add missing error check in start_io_thread()

Vijendar Mukunda (2):
      ALSA: hda: Add new pci id for AMD GPU display HD audio controller
      ASoC: amd: ps: fix for soundwire failures during hibernation exit sequence

Ville Syrjälä (2):
      drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1
      drm/i915/dsi: Fix off by one in BXT_MIPI_TRANS_VTOTAL

Wenbin Yao (1):
      PCI: dwc: Make link training more robust by setting PORT_LOGIC_LINK_WIDTH to one lane

Wentao Liang (1):
      drm/amd/display: Add null pointer check for get_first_active_display()

Wolfram Sang (3):
      i2c: tiny-usb: disable zero-length read messages
      i2c: robotfuzz-osif: disable zero-length read messages
      drm/bridge: ti-sn65dsi86: make use of debugfs_init callback

Xin Li (Intel) (1):
      x86/traps: Initialize DR6 by writing its architectural reset value

Yan Zhai (1):
      bnxt: properly flush XDP redirect lists

Yao Zi (1):
      dt-bindings: serial: 8250: Make clocks and clock-frequency exclusive

Yi Sun (1):
      dmaengine: idxd: Check availability of workqueue allocated by idxd wq driver before using

Yifan Zhang (1):
      amd/amdkfd: fix a kfd_process ref leak

Yihan Zhu (1):
      drm/amd/display: Fix RMCM programming seq errors

Yikai Tsai (1):
      hwmon: (isl28022) Fix current reading calculation

Youngjun Lee (1):
      ALSA: usb-audio: Fix out-of-bounds read in snd_usb_get_audioformat_uac3()

Yu Kuai (2):
      md/md-bitmap: fix dm-raid max_write_behind setting
      lib/group_cpus: fix NULL pointer dereference from group_cpus_evenly()

Yuan Chen (1):
      libbpf: Fix null pointer dereference in btf_dump__free on allocation failure

Zhang Lixu (1):
      iio: hid-sensor-prox: Add support for 16-bit report size

Zhongwei Zhang (1):
      drm/amd/display: Correct non-OLED pre_T11_delay.

Ziqi Chen (1):
      scsi: ufs: core: Don't perform UFS clkscaling during host async scan

anvithdosapati (1):
      scsi: ufs: core: Fix clk scaling to be conditional in reset and restore


