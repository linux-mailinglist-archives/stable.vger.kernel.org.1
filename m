Return-Path: <stable+bounces-232996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKwQNNpazmmgnAYAu9opvQ
	(envelope-from <stable+bounces-232996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:02:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7855E388BAA
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3150305433C
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 11:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C603DB625;
	Thu,  2 Apr 2026 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mpHMPK2W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4992E3D810A;
	Thu,  2 Apr 2026 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775130693; cv=none; b=gDLU+jVOZHNH+1LeqeC604tCx0uQI9S68r0AUncC1cCTfYTF3mppu/SXIOwDp2TqRnbI2B+DasXygX6b69tjGWnrOSFfO7sWbzD7IxL6dl7fTjCMdT0ttxVrR0beZTWu/74c0E/FU5MrEL3OICmxhytMbtwOXM9Wfmsn9xYHLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775130693; c=relaxed/simple;
	bh=b+H7bPGQxV0Xv71vxBfWVSy9g9uaE6VuTIAxOeNxKS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mbe9IVd/tybUm9uHR9IuzHA7r7e4Ttt4EnoEBdp9VuJ/kn9BoamEtup/PKpGFGkO4pA3sK1ivn+xS9ewA/4zodg1BssdBH+5/aZnInpS0dm5F9U5tm4eayoIgf6mHIoinPpHSvYHq1Ya/8XaO/vl+kEd5Ivr5ztblP0yHjd2Bsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mpHMPK2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48625C2BC9E;
	Thu,  2 Apr 2026 11:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775130692;
	bh=b+H7bPGQxV0Xv71vxBfWVSy9g9uaE6VuTIAxOeNxKS4=;
	h=From:To:Cc:Subject:Date:From;
	b=mpHMPK2WVD6hYvMVIuUCSowk1NS+zid+D28/mUVP26Odk8/lGVxAEcSNMgNTSigdg
	 GBFGP2t+yyjWcDxZti4hKS8bA6kSpd1i7DlFY6eiC/PTHeICFxpqK3ZImQ/EQYv5b9
	 Ra923LvsuAAZH2Hvli7S+De8DfTftbSrMTGt32N8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.19.11
Date: Thu,  2 Apr 2026 13:51:22 +0200
Message-ID: <2026040223-untying-clamp-a54e@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232996-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.976];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7855E388BAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.19.11 kernel.

All users of the 6.19 kernel series must upgrade.

The updated 6.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                      |    3 
 Documentation/devicetree/bindings/sound/st,stm32-sai.yaml            |    2 
 Documentation/filesystems/overlayfs.rst                              |   50 +
 Documentation/hwmon/adm1177.rst                                      |    8 
 Documentation/hwmon/peci-cputemp.rst                                 |   10 
 Makefile                                                             |    4 
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts            |   13 
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi                  |   22 
 arch/arm64/kvm/at.c                                                  |    2 
 arch/arm64/kvm/reset.c                                               |   14 
 arch/loongarch/include/asm/linkage.h                                 |   36 
 arch/loongarch/include/asm/sigframe.h                                |    9 
 arch/loongarch/kernel/asm-offsets.c                                  |    2 
 arch/loongarch/kernel/env.c                                          |    7 
 arch/loongarch/kernel/signal.c                                       |    6 
 arch/loongarch/kvm/intc/eiointc.c                                    |   16 
 arch/loongarch/kvm/vcpu.c                                            |    3 
 arch/loongarch/pci/pci.c                                             |   80 +
 arch/loongarch/vdso/Makefile                                         |    4 
 arch/loongarch/vdso/sigreturn.S                                      |    6 
 arch/powerpc/net/bpf_jit_comp64.c                                    |   23 
 arch/powerpc/tools/ftrace-gen-ool-stubs.sh                           |    4 
 arch/s390/include/asm/barrier.h                                      |    4 
 arch/s390/kernel/entry.S                                             |    3 
 arch/s390/kernel/syscall.c                                           |    5 
 arch/s390/mm/fault.c                                                 |   11 
 arch/sh/drivers/platform_early.c                                     |    4 
 arch/x86/coco/sev/noinstr.c                                          |    6 
 arch/x86/entry/entry_fred.c                                          |   14 
 arch/x86/events/core.c                                               |    4 
 arch/x86/kernel/cpu/common.c                                         |   20 
 arch/x86/kvm/mmu/mmu.c                                               |   17 
 arch/x86/platform/efi/quirks.c                                       |    2 
 block/blk-mq.c                                                       |   45 -
 drivers/accel/ivpu/ivpu_drv.h                                        |    1 
 drivers/accel/ivpu/ivpu_hw.c                                         |    6 
 drivers/acpi/ec.c                                                    |    2 
 drivers/base/bus.c                                                   |   43 +
 drivers/base/core.c                                                  |    2 
 drivers/base/dd.c                                                    |   60 +
 drivers/base/platform.c                                              |   37 
 drivers/base/regmap/regmap.c                                         |   30 
 drivers/bluetooth/btintel.c                                          |   11 
 drivers/bluetooth/btusb.c                                            |    5 
 drivers/bluetooth/hci_ll.c                                           |    2 
 drivers/bus/simple-pm-bus.c                                          |    4 
 drivers/clk/imx/clk-scu.c                                            |    3 
 drivers/cpufreq/cpufreq.c                                            |    9 
 drivers/cpufreq/cpufreq_conservative.c                               |   12 
 drivers/cpufreq/cpufreq_governor.c                                   |    3 
 drivers/cpufreq/cpufreq_governor.h                                   |    1 
 drivers/cpufreq/freq_table.c                                         |    4 
 drivers/cxl/core/hdm.c                                               |   25 
 drivers/cxl/core/port.c                                              |    8 
 drivers/cxl/core/region.c                                            |    4 
 drivers/cxl/pmem.c                                                   |    2 
 drivers/dma/dw-edma/dw-hdma-v0-core.c                                |    6 
 drivers/dma/fsl-edma-main.c                                          |   26 
 drivers/dma/idxd/cdev.c                                              |    8 
 drivers/dma/idxd/device.c                                            |    6 
 drivers/dma/idxd/init.c                                              |    4 
 drivers/dma/idxd/submit.c                                            |    2 
 drivers/dma/idxd/sysfs.c                                             |    1 
 drivers/dma/sh/rz-dmac.c                                             |   66 -
 drivers/dma/xilinx/xdma.c                                            |    4 
 drivers/dma/xilinx/xilinx_dma.c                                      |   46 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                           |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                           |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c                              |   45 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h                              |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                               |    1 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                               |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                    |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                    |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c          |    4 
 drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c     |    6 
 drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c     |    5 
 drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c     |    5 
 drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c     |    5 
 drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c       |   14 
 drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c       |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c                 |    2 
 drivers/gpu/drm/i915/display/intel_display.c                         |    8 
 drivers/gpu/drm/i915/display/intel_dp_tunnel.c                       |   20 
 drivers/gpu/drm/i915/display/intel_dp_tunnel.h                       |   11 
 drivers/gpu/drm/i915/display/intel_gmbus.c                           |    4 
 drivers/gpu/drm/i915/display/intel_plane.c                           |   11 
 drivers/gpu/drm/i915/i915_wait_util.h                                |    2 
 drivers/gpu/drm/mediatek/mtk_dsi.c                                   |    9 
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c                              |    4 
 drivers/gpu/drm/xe/regs/xe_gt_regs.h                                 |    1 
 drivers/gpu/drm/xe/xe_pt.c                                           |   12 
 drivers/gpu/drm/xe/xe_sriov_packet.c                                 |    2 
 drivers/gpu/drm/xe/xe_vm.c                                           |   22 
 drivers/gpu/drm/xe/xe_vm_types.h                                     |    4 
 drivers/gpu/drm/xe/xe_wa.c                                           |    3 
 drivers/hid/hid-apple.c                                              |    7 
 drivers/hid/hid-asus.c                                               |   18 
 drivers/hid/hid-ids.h                                                |    1 
 drivers/hid/hid-magicmouse.c                                         |    6 
 drivers/hid/hid-mcp2221.c                                            |    2 
 drivers/hid/intel-ish-hid/ipc/hw-ish.h                               |    2 
 drivers/hid/intel-ish-hid/ipc/pci-ish.c                              |   12 
 drivers/hwmon/adm1177.c                                              |   54 -
 drivers/hwmon/axi-fan-control.c                                      |    2 
 drivers/hwmon/peci/cputemp.c                                         |    4 
 drivers/hwmon/pmbus/ina233.c                                         |    3 
 drivers/hwmon/pmbus/isl68137.c                                       |   21 
 drivers/hwmon/pmbus/pmbus_core.c                                     |  192 +++-
 drivers/i2c/busses/i2c-designware-amdisp.c                           |   11 
 drivers/i2c/busses/i2c-imx.c                                         |   51 -
 drivers/i3c/master/dw-i3c-master.c                                   |    2 
 drivers/infiniband/core/rw.c                                         |   21 
 drivers/infiniband/hw/bng_re/bng_dev.c                               |   14 
 drivers/infiniband/hw/efa/efa_com.c                                  |  173 ++--
 drivers/infiniband/hw/ionic/ionic_controlpath.c                      |    4 
 drivers/infiniband/hw/irdma/cm.c                                     |   29 
 drivers/infiniband/hw/irdma/uk.c                                     |   39 
 drivers/infiniband/hw/irdma/utils.c                                  |    2 
 drivers/infiniband/hw/irdma/verbs.c                                  |    9 
 drivers/irqchip/irq-qcom-mpm.c                                       |    3 
 drivers/irqchip/irq-renesas-rzv2h.c                                  |    2 
 drivers/media/mc/mc-request.c                                        |    5 
 drivers/media/platform/verisilicon/imx8m_vpu_hw.c                    |    2 
 drivers/media/v4l2-core/v4l2-ioctl.c                                 |    5 
 drivers/net/can/dev/netlink.c                                        |    4 
 drivers/net/ethernet/airoha/airoha_ppe.c                             |    2 
 drivers/net/ethernet/broadcom/Kconfig                                |    2 
 drivers/net/ethernet/broadcom/asp2/bcmasp.c                          |   66 -
 drivers/net/ethernet/cadence/macb_main.c                             |   41 
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c                 |    2 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c                       |   31 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                         |   14 
 drivers/net/ethernet/intel/ice/ice_repr.c                            |    5 
 drivers/net/ethernet/microchip/lan743x_main.c                        |    5 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                      |   17 
 drivers/net/ethernet/ti/icssg/icssg_common.c                         |    4 
 drivers/net/team/team_core.c                                         |   65 +
 drivers/net/tun_vnet.h                                               |    2 
 drivers/net/usb/r8152.c                                              |    1 
 drivers/net/virtio_net.c                                             |    7 
 drivers/nvme/host/fabrics.c                                          |    4 
 drivers/nvme/host/pci.c                                              |   11 
 drivers/nvme/target/admin-cmd.c                                      |    2 
 drivers/nvme/target/core.c                                           |   14 
 drivers/nvme/target/nvmet.h                                          |    1 
 drivers/nvme/target/rdma.c                                           |    1 
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c                              |    3 
 drivers/phy/ti/phy-j721e-wiz.c                                       |    2 
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c                        |    9 
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                             |   16 
 drivers/pinctrl/renesas/pinctrl-rza1.c                               |    2 
 drivers/pinctrl/renesas/pinctrl-rzt2h.c                              |    1 
 drivers/pinctrl/stm32/Kconfig                                        |    1 
 drivers/platform/olpc/olpc-xo175-ec.c                                |    2 
 drivers/platform/x86/hp/hp-wmi.c                                     |   12 
 drivers/platform/x86/intel/hid.c                                     |   23 
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c          |    5 
 drivers/platform/x86/lenovo/wmi-gamezone.c                           |    2 
 drivers/platform/x86/oxpec.c                                         |   30 
 drivers/platform/x86/touchscreen_dmi.c                               |   18 
 drivers/scsi/ibmvscsi/ibmvfc.c                                       |    3 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                      |   10 
 drivers/scsi/scsi_devinfo.c                                          |    2 
 drivers/scsi/scsi_transport_sas.c                                    |    2 
 drivers/scsi/ses.c                                                   |    2 
 drivers/slimbus/qcom-ngd-ctrl.c                                      |    6 
 drivers/spi/spi-dw-dma.c                                             |    2 
 drivers/spi/spi-fsl-lpspi.c                                          |    3 
 drivers/spi/spi-intel-pci.c                                          |    1 
 drivers/spi/spi-meson-spicc.c                                        |    2 
 drivers/spi/spi-sn-f-ospi.c                                          |   17 
 drivers/spi/spi.c                                                    |   19 
 drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c |    8 
 drivers/usb/core/config.c                                            |    6 
 drivers/usb/core/quirks.c                                            |    5 
 drivers/vfio/pci/vfio_pci_dmabuf.c                                   |    5 
 drivers/virt/coco/tdx-guest/tdx-guest.c                              |   12 
 drivers/xen/privcmd.c                                                |    3 
 fs/btrfs/block-group.c                                               |    2 
 fs/btrfs/disk-io.c                                                   |    4 
 fs/btrfs/ioctl.c                                                     |    7 
 fs/btrfs/volumes.c                                                   |    5 
 fs/erofs/fileio.c                                                    |    6 
 fs/erofs/zdata.c                                                     |    3 
 fs/ext4/Makefile                                                     |    4 
 fs/ext4/crypto.c                                                     |    9 
 fs/ext4/ext4.h                                                       |    6 
 fs/ext4/extents.c                                                    |   23 
 fs/ext4/fast_commit.c                                                |   17 
 fs/ext4/fsync.c                                                      |   16 
 fs/ext4/ialloc.c                                                     |    6 
 fs/ext4/inline.c                                                     |   10 
 fs/ext4/inode.c                                                      |   75 +
 fs/ext4/mballoc-test.c                                               |   81 -
 fs/ext4/mballoc.c                                                    |  132 ++-
 fs/ext4/mballoc.h                                                    |   30 
 fs/ext4/page-io.c                                                    |   10 
 fs/ext4/super.c                                                      |   16 
 fs/ext4/sysfs.c                                                      |   10 
 fs/fs-writeback.c                                                    |   18 
 fs/fuse/file.c                                                       |    4 
 fs/fuse/inode.c                                                      |    1 
 fs/iomap/buffered-io.c                                               |   15 
 fs/jbd2/checkpoint.c                                                 |   15 
 fs/netfs/buffered_read.c                                             |    3 
 fs/netfs/direct_read.c                                               |    3 
 fs/netfs/direct_write.c                                              |   15 
 fs/netfs/iterator.c                                                  |   43 +
 fs/netfs/read_collect.c                                              |    4 
 fs/netfs/read_retry.c                                                |    5 
 fs/netfs/read_single.c                                               |    1 
 fs/netfs/write_collect.c                                             |    4 
 fs/netfs/write_issue.c                                               |    3 
 fs/overlayfs/copy_up.c                                               |    6 
 fs/overlayfs/overlayfs.h                                             |   21 
 fs/overlayfs/ovl_entry.h                                             |    7 
 fs/overlayfs/params.c                                                |   33 
 fs/overlayfs/super.c                                                 |    2 
 fs/overlayfs/util.c                                                  |    5 
 fs/smb/server/oplock.c                                               |   72 +
 fs/smb/server/smb2pdu.c                                              |   73 +
 fs/xfs/scrub/quota.c                                                 |    4 
 fs/xfs/scrub/trace.h                                                 |   12 
 fs/xfs/xfs_attr_item.c                                               |    5 
 fs/xfs/xfs_dquot_item.c                                              |    9 
 fs/xfs/xfs_inode_item.c                                              |    9 
 fs/xfs/xfs_mount.c                                                   |    7 
 fs/xfs/xfs_trace.h                                                   |   47 -
 fs/xfs/xfs_trans_ail.c                                               |   26 
 include/linux/damon.h                                                |    7 
 include/linux/device.h                                               |   54 +
 include/linux/device/bus.h                                           |    4 
 include/linux/dma-mapping.h                                          |    4 
 include/linux/fs/super_types.h                                       |    1 
 include/linux/leafops.h                                              |   32 
 include/linux/mempolicy.h                                            |    1 
 include/linux/netfs.h                                                |    1 
 include/linux/pagemap.h                                              |   11 
 include/linux/platform_device.h                                      |    5 
 include/linux/spi/spi.h                                              |    5 
 include/linux/usb/quirks.h                                           |    3 
 include/linux/usb/r8152.h                                            |    1 
 include/linux/virtio_net.h                                           |   53 +
 include/net/bluetooth/l2cap.h                                        |    2 
 include/net/codel_impl.h                                             |    1 
 include/net/inet_hashtables.h                                        |   14 
 include/net/ip6_fib.h                                                |   21 
 include/sound/cs35l56.h                                              |    1 
 include/trace/events/netfs.h                                         |    8 
 include/trace/events/task.h                                          |    7 
 include/uapi/linux/dma-buf.h                                         |    1 
 include/uapi/linux/netfilter/nf_conntrack_common.h                   |    4 
 io_uring/fdinfo.c                                                    |    4 
 kernel/bpf/btf.c                                                     |   24 
 kernel/bpf/core.c                                                    |   43 -
 kernel/bpf/verifier.c                                                |   36 
 kernel/dma/swiotlb.c                                                 |   21 
 kernel/events/core.c                                                 |   19 
 kernel/futex/core.c                                                  |    2 
 kernel/futex/pi.c                                                    |    3 
 kernel/futex/syscalls.c                                              |    8 
 kernel/module/main.c                                                 |    7 
 kernel/power/main.c                                                  |    2 
 kernel/power/snapshot.c                                              |   11 
 kernel/sched/ext.c                                                   |    2 
 kernel/sysctl.c                                                      |    2 
 kernel/time/alarmtimer.c                                             |    2 
 kernel/trace/trace_events_trigger.c                                  |   79 +
 kernel/trace/trace_osnoise.c                                         |   10 
 lib/bug.c                                                            |    7 
 mm/damon/core.c                                                      |    9 
 mm/damon/stat.c                                                      |   53 +
 mm/damon/sysfs.c                                                     |   10 
 mm/memory.c                                                          |   18 
 mm/mempolicy.c                                                       |   10 
 mm/mseal.c                                                           |    3 
 mm/pagewalk.c                                                        |   25 
 net/bluetooth/l2cap_core.c                                           |  105 +-
 net/bluetooth/l2cap_sock.c                                           |    3 
 net/bluetooth/mgmt.c                                                 |    2 
 net/bluetooth/sco.c                                                  |   10 
 net/can/af_can.c                                                     |    4 
 net/can/af_can.h                                                     |    2 
 net/can/gw.c                                                         |    6 
 net/can/isotp.c                                                      |   24 
 net/can/proc.c                                                       |    3 
 net/core/rtnetlink.c                                                 |   28 
 net/ipv4/esp4.c                                                      |    9 
 net/ipv4/inet_connection_sock.c                                      |   20 
 net/ipv4/udp.c                                                       |    2 
 net/ipv6/addrconf.c                                                  |    4 
 net/ipv6/esp6.c                                                      |    9 
 net/ipv6/ip6_fib.c                                                   |   15 
 net/ipv6/netfilter/ip6t_rt.c                                         |    4 
 net/ipv6/route.c                                                     |    2 
 net/key/af_key.c                                                     |   19 
 net/netfilter/nf_conntrack_expect.c                                  |    4 
 net/netfilter/nf_conntrack_netlink.c                                 |   16 
 net/netfilter/nf_conntrack_proto_tcp.c                               |   10 
 net/netfilter/nf_conntrack_sip.c                                     |   14 
 net/netfilter/nfnetlink_log.c                                        |    8 
 net/netfilter/nft_set_rbtree.c                                       |   92 +-
 net/nfc/nci/core.c                                                   |   10 
 net/openvswitch/flow_netlink.c                                       |    2 
 net/openvswitch/vport-netdev.c                                       |   11 
 net/packet/af_packet.c                                               |    1 
 net/smc/smc_rx.c                                                     |    9 
 net/tls/tls_sw.c                                                     |    2 
 net/xfrm/xfrm_iptfs.c                                                |   17 
 net/xfrm/xfrm_nat_keepalive.c                                        |    2 
 net/xfrm/xfrm_policy.c                                               |    2 
 net/xfrm/xfrm_state.c                                                |    1 
 net/xfrm/xfrm_user.c                                                 |    7 
 rust/kernel/regulator.rs                                             |   33 
 rust/pin-init/src/macros.rs                                          |   16 
 scripts/livepatch/klp-build                                          |    9 
 scripts/package/install-extmod-build                                 |    4 
 sound/firewire/amdtp-stream.c                                        |    2 
 sound/hda/codecs/hdmi/tegrahdmi.c                                    |    1 
 sound/hda/codecs/realtek/alc269.c                                    |   42 -
 sound/hda/codecs/realtek/alc662.c                                    |    9 
 sound/hda/codecs/senarytech.c                                        |    5 
 sound/hda/controllers/intel.c                                        |    1 
 sound/soc/amd/acp/amd-acp63-acpi-match.c                             |  413 ++++++++++
 sound/soc/codecs/adau1372.c                                          |   34 
 sound/soc/codecs/cs35l56-shared.c                                    |   16 
 sound/soc/codecs/cs35l56.c                                           |    8 
 sound/soc/codecs/rt1320-sdw.c                                        |    5 
 sound/soc/codecs/sma1307.c                                           |    6 
 sound/soc/codecs/wcd934x.c                                           |    2 
 sound/soc/fsl/fsl_easrc.c                                            |   14 
 sound/soc/fsl/imx-card.c                                             |    2 
 sound/soc/generic/simple-card-utils.c                                |    4 
 sound/soc/intel/boards/sof_sdw.c                                     |    8 
 sound/soc/intel/catpt/device.c                                       |   10 
 sound/soc/intel/catpt/dsp.c                                          |    3 
 sound/soc/samsung/i2s.c                                              |    6 
 sound/soc/sdca/sdca_functions.c                                      |   11 
 sound/soc/sof/ipc4-topology.c                                        |    2 
 sound/usb/quirks.c                                                   |    4 
 tools/objtool/Makefile                                               |    2 
 tools/objtool/arch/x86/decode.c                                      |   62 -
 tools/objtool/check.c                                                |   14 
 tools/objtool/klp-diff.c                                             |   26 
 tools/perf/pmu-events/Build                                          |   14 
 tools/perf/util/metricgroup.c                                        |    6 
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c                  |   62 +
 tools/testing/selftests/bpf/progs/exceptions_fail.c                  |    9 
 tools/testing/selftests/mount_setattr/mount_setattr_test.c           |    2 
 350 files changed, 3983 insertions(+), 1331 deletions(-)

Abel Vesa (1):
      phy: qcom: qmp-ufs: Fix SM8650 PCS table for Gear 4

Abhijit Gangurde (1):
      RDMA/ionic: Preserve and set Ethernet source MAC after ib_ud_header_init()

Alan Borzeszkowski (1):
      spi: intel-pci: Add support for Nova Lake mobile SPI flash

Alberto Garcia (1):
      PM: hibernate: Drain trailing zero pages on userspace restore

Alex Deucher (2):
      drm/amd/display: Fix DCE LVDS handling
      drm/amd/display: check if ext_caps is valid in BL setup

Alex Hung (1):
      drm/amd/display: Fix drm_edid leak in amdgpu_dm

Alex Williamson (1):
      vfio/pci: Fix double free in dma-buf feature

Alexander Stein (1):
      dmaengine: xilinx: xdma: Fix regmap init error handling

Alexey Nepomnyashih (1):
      ALSA: firewire-lib: fix uninitialized local variable

Ali Norouzi (1):
      can: gw: fix OOB heap access in cgw_csum_crc8_rel()

Alice Ryhl (1):
      rust: regulator: do not assume that regulator_get() returns non-null

Alison Schofield (1):
      cxl/port: Fix use after free of parent_port in cxl_detach_ep()

Alok Tiwari (1):
      platform/olpc: olpc-xo175-ec: Fix overflow error message to print inlen

Amelie Delaunay (1):
      pinctrl: stm32: fix HDP driver dependency on GPIO_GENERIC

Amir Goldstein (1):
      ovl: fix wrong detection of 32bit inode numbers

Anas Iqbal (1):
      Bluetooth: hci_ll: Fix firmware leak on error path

Andy Shevchenko (1):
      regmap: Synchronize cache for the page selector

Anil Samal (1):
      RDMA/irdma: Fix deadlock during netdev reset with active connections

Antheas Kapenekakis (4):
      platform/x86: oxpec: Add support for OneXPlayer APEX
      platform/x86: oxpec: Add support for OneXPlayer X1z
      platform/x86: oxpec: Add support for Aokzoe A2 Pro
      platform/x86: oxpec: Add support for OneXPlayer X1 Air

Anton Plotnikov (1):
      platform/x86: hp-wmi: add Omen 14-fb1xxx (board 8E41) support

Arnd Bergmann (2):
      net: b44: always select CONFIG_FIXED_PHY
      bug: avoid format attribute warning for clang as well

Asad Kamal (1):
      drm/amd/pm: Return -EOPNOTSUPP for unsupported OD_MCLK on smu_v13_0_6

Baokun Li (1):
      ext4: fix iloc.bh leak in ext4_fc_replay_inode() error paths

Benno Lossin (1):
      rust: pin-init: internal: init: document load-bearing fact of field accessors

Bibo Mao (1):
      LoongArch: KVM: Fix base address calculation in kvm_eiointc_regs_access()

Biju Das (1):
      irqchip/renesas-rzv2h: Fix error path in rzv2h_icu_probe_common()

Boris Burkov (1):
      btrfs: set BTRFS_ROOT_ORPHAN_CLEANUP during subvol create

Borislav Petkov (AMD) (1):
      x86/cpu: Remove X86_CR4_FRED from the CR4 pinned bits mask

Cen Zhang (1):
      Bluetooth: btintel: serialize btintel_hw_error() with hci_req_sync_lock

Cezary Rojewski (1):
      ASoC: Intel: catpt: Fix the device initialization

Chaitanya Kulkarni (1):
      nvmet: move async event work off nvmet-wq

Charles Mirabile (1):
      kbuild: Delete .builtin-dtbs.S when running make clean

Christian Brauner (1):
      selftests/mount_setattr: increase tmpfs size for idmapped mount tests

Chuck Lever (2):
      tls: Purge async_hold in tls_decrypt_async_wait()
      RDMA/rw: Fall back to direct SGE on MR pool exhaustion

Claudiu Beznea (2):
      dmaengine: sh: rz-dmac: Protect the driver specific lists
      dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock

Cui Chao (1):
      cxl: Adjust the startup priority of cxl_pmem to be higher than that of cxl_acpi

Daniel Hodges (1):
      nvme-fabrics: use kfree_sensitive() for DHCHAP secrets

Daniel Wade (1):
      bpf: Fix unsound scalar forking in maybe_fork_scalars() for BPF_OR

Danilo Krummrich (5):
      hwmon: axi-fan: don't use driver_override as IRQ name
      sh: platform_early: remove pdev->driver_override check
      driver core: generalize driver_override in struct device
      driver core: platform: use generic driver_override infrastructure
      spi: use generic driver_override infrastructure

Darrick J. Wong (2):
      xfs: don't irele after failing to iget in xfs_attri_recover_work
      xfs: remove file_path tracepoint data

David Carlier (2):
      net: ti: icssg-prueth: fix use-after-free of CPPI descriptor in RX path
      netfilter: ctnetlink: use netlink policy range checks

David Hildenbrand (Arm) (1):
      mm/memory: fix PMD/PUD checks in follow_pfnmap_start()

David Howells (2):
      netfs: Fix read abandonment during retry
      netfs: Fix the handling of stream->front by removing it

David McFarland (1):
      platform/x86: intel-hid: disable wakeup_mode during hibernation

Davidlohr Bueso (2):
      cxl/region: Fix leakage in __construct_region()
      futex: Clear stale exiting pointer in futex_lock_pi() retry path

Deepanshu Kartikey (3):
      ext4: convert inline data to extents when truncate exceeds inline size
      netfs: Fix kernel BUG in netfs_limit_iter() for ITER_KVEC iterators
      netfs: Fix NULL pointer dereference in netfs_unbuffered_write() on retry

Denis Benato (1):
      HID: asus: add xg mobile 2023 external hardware support

Dmitry Torokhov (1):
      pinctrl: renesas: rza1: Normalize return value of gpio_get()

Eduard Zingerman (1):
      bpf: Fix u32/s32 bounds when ranges cross min/max boundary

Edward Adam Davis (1):
      ext4: avoid infinite loops caused by residual data

Eric Dumazet (1):
      af_key: validate families in pfkey_send_migrate()

Eric Huang (1):
      drm/amdgpu: prevent immediate PASID reuse case

Ethan Tidmore (1):
      RDMA/efa: Fix possible deadlock

Fei Lv (1):
      ovl: make fsync after metadata copy-up opt-in mount option

Felix Gu (4):
      pinctrl: renesas: rzt2h: Fix device node leak in rzt2h_gpio_register()
      spi: sn-f-ospi: Fix resource leak in f_ospi_probe()
      spi: meson-spicc: Fix double-put in remove path
      phy: ti: j721e-wiz: Fix device node reference leak in wiz_get_lane_phy_types()

Fernando Fernandez Mancera (1):
      xfrm: iptfs: fix skb_put() panic on non-linear skb during reassembly

Filipe Manana (1):
      btrfs: fix lost error when running device stats on multiple devices fs

Florian Fuchs (1):
      scsi: devinfo: Add BLIST_SKIP_IO_HINTS for Iomega ZIP

Geoffrey D. Bennett (2):
      ALSA: usb-audio: Exclude Scarlett 2i2 1st Gen from SKIP_IFACE_SETUP
      ALSA: usb-audio: Exclude Scarlett 2i4 1st Gen from SKIP_IFACE_SETUP

Greg Kroah-Hartman (4):
      s390/syscalls: Add spectre boundary for syscall dispatch table
      scsi: ses: Handle positive SCSI error from ses_recv_diag()
      Revert "perf jevents: Handle deleted JSONS in out of source builds"
      Linux 6.19.11

Guangshuo Li (1):
      ASoC: sma1307: fix double free of devm_kzalloc() memory

Guenter Roeck (3):
      hwmon: (pmbus) Mark lowest/average/highest/rated attributes as read-only
      hwmon: (pmbus) Introduce the concept of "write-only" attributes
      hwmon: (pmbus/core) Protect regulator operations with mutex

GuoHan Zhao (1):
      xen/privcmd: unregister xenstore notifier on module exit

Günther Noack (3):
      HID: asus: avoid memory leak in asus_report_fixup()
      HID: magicmouse: avoid memory leak in magicmouse_report_fixup()
      HID: apple: avoid memory leak in apple_report_fixup()

HONG Yifan (1):
      objtool: Use HOSTCFLAGS for HAVE_XXHASH test

Hans de Goede (1):
      platform/x86: touchscreen_dmi: Add quirk for y-inverted Goodix touchscreen on SUPI S10

Hao-Yu Yang (1):
      futex: Fix UaF between futex_key_to_node_opt() and vma_replace_policy()

Hari Bathini (2):
      powerpc64/ftrace: fix OOL stub count with clang
      powerpc64/bpf: do not increment tailcall count when prog is NULL

Helen Koike (2):
      Bluetooth: L2CAP: Fix null-ptr-deref on l2cap_sock_ready_cb
      ext4: reject mount if bigalloc with s_first_data_block != 0

Huacai Chen (3):
      LoongArch: Workaround LS2K/LS7A GPU DMA hang bug
      LoongArch: KVM: Make kvm_get_vcpu_by_cpuid() more robust
      LoongArch: KVM: Handle the case that EIOINTC's coremap is empty

Hyunwoo Kim (6):
      xfrm: Fix work re-schedule after cancel in xfrm_nat_keepalive_net_fini()
      Bluetooth: L2CAP: Validate PDU length before reading SDU length in l2cap_ecred_data_rcv()
      Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold
      Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
      Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len infinite loop
      ksmbd: do not expire session on binding failure

Ian Rogers (1):
      perf metricgroup: Fix metricgroup__has_metric_or_groups()

Ihor Solodrai (2):
      bpf: Fix exception exit lock checking for subprogs
      module: Fix kernel panic when a symbol st_shndx is out of bounds

Imre Deak (1):
      drm/i915/dp_tunnel: Fix error handling when clearing stream BW in atomic state

Isaac J. Manjarres (1):
      dma-buf: Include ioctl.h in UAPI header

Ivan Barrera (1):
      RDMA/irdma: Clean up unnecessary dereference of event->cm_node

Jacob Moroni (1):
      RDMA/irdma: Initialize free_qp completion before using it

Jakub Kicinski (1):
      nfc: nci: fix circular locking dependency in nci_close_device

Jan Kara (3):
      ext4: fix stale xarray tags after writeback
      ext4: fix fsync(2) for nojournal mode
      ext4: make recently_deleted() properly work with lazy itable initialization

Janosch Frank (1):
      s390/mm: Add missing secure storage access fixups for donated memory

Jassi Brar (1):
      irqchip/qcom-mpm: Add missing mailbox TX done acknowledgment

Jenny Guanni Qu (1):
      bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN

Jens Axboe (1):
      io_uring/fdinfo: fix SQE_MIXED SQE displaying

Jiayuan Chen (2):
      team: fix header_ops type confusion with non-Ethernet ports
      ext4: fix use-after-free in update_super_work when racing with umount

Jie Deng (1):
      usb: core: new quirk to handle devices with zero configurations

Jihed Chaibi (3):
      ASoC: dt-bindings: stm32: Fix incorrect compatible string in stm32h7-sai match
      ASoC: adau1372: Fix unchecked clk_prepare_enable() return value
      ASoC: adau1372: Fix clock leak on PLL lock failure

Jinjiang Tu (1):
      mm/huge_memory: fix folio isn't locked in softleaf_to_folio()

Jiucheng Xu (1):
      erofs: add GFP_NOIO in the bio completion if needed

Joanne Koong (2):
      writeback: don't block sync for filesystems with no data integrity guarantees
      iomap: fix invalid folio access when i_blkbits differs from I/O granularity

Joe Lawrence (1):
      objtool/klp: fix data alignment in __clone_symbol()

Jonas Köppeler (1):
      net_sched: codel: fix stale state for empty flows in fq_codel

Josh Law (3):
      mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
      mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
      mm/damon/sysfs: check contexts->nr in repeat_call_fn

Josh Poimboeuf (3):
      livepatch/klp-build: Fix inconsistent kernel version
      objtool/klp: Disable unsupported pr_debug() usage
      objtool: Handle Clang RSP musical chairs

Joy Zou (1):
      dmaengine: fsl-edma: fix channel parameter config for fixed channel requests

Julius Lehmann (1):
      HID: magicmouse: fix battery reporting for Apple Magic Trackpad 2

Justin Chen (3):
      net: bcmasp: streamline early exit in probe
      net: bcmasp: fix double free of WoL irq
      net: bcmasp: fix double disable of clk

Kamal Heib (1):
      RDMA/bng_re: Fix silent failure in HWRM version query

Karol Wachowski (1):
      accel/ivpu: Add disable clock relinquish workaround for NVL-A0

Keith Busch (2):
      nvme-pci: cap queue creation to used queues
      nvme-pci: ensure we're polling a polled queue

Kevin Hao (3):
      net: macb: Move devm_{free,request}_irq() out of spin lock area
      net: macb: Protect access to net_device::ip_ptr with RCU lock
      net: macb: Use dev_consume_skb_any() to free TX SKBs

Kohei Enju (1):
      iavf: fix out-of-bounds writes in iavf_get_ethtool_stats()

Krishna Chomal (2):
      platform/x86: hp-wmi: Add Omen 16-wf0xxx fan and thermal support
      platform/x86: hp-wmi: Add Omen 16-xd0xxx fan and thermal support

Kumar Kartikeya Dwivedi (1):
      bpf: Release module BTF IDR before module unload

Kuniyuki Iwashima (2):
      ipv6: Remove permanent routes from tb6_gc_hlist when all exceptions expire.
      ipv6: Don't remove permanent routes with exceptions from tb6_gc_hlist.

LUO Haowen (1):
      dmaengine: dw-edma: Fix multiple times setting of the CYCLE_STATE and CYCLE_BIT bits for HDMA.

Leif Skunberg (1):
      platform/x86: intel-hid: Enable 5-button array on ThinkPad X1 Fold 16 Gen 1

Li Chen (1):
      ext4: publish jinode after initialization

Li Jun (1):
      LoongArch: Fix missing NULL checks for kstrdup()

Li RongQing (1):
      platform/x86: ISST: Check HWP support before MSR access

Lianqin Hu (1):
      ALSA: usb-audio: Add iface reset and delay quirk for SPACETOUCH USB Audio

Liucheng Lu (1):
      ALSA: hda/realtek: add HP Laptop 14s-dr5xxx mute LED quirk

Long Li (1):
      xfs: fix ri_total validation in xlog_recover_attri_commit_pass2

Lorenzo Stoakes (Oracle) (1):
      mm/mseal: update VMA end correctly on merge

Luca Leonardo Scorcia (2):
      pinctrl: mediatek: common: Fix probe failure for devices without EINT
      drm/mediatek: dsi: Store driver data before invoking mipi_dsi_host_register

Luiz Augusto von Dentz (3):
      Bluetooth: MGMT: Fix dangling pointer on mgmt_add_adv_patterns_monitor_complete
      Bluetooth: L2CAP: Fix not tracking outstanding TX ident
      Bluetooth: L2CAP: Fix regressions caused by reusing ident

Luo Haiyang (1):
      tracing: Fix potential deadlock in cpu hotplug with osnoise

Maarten Lankhorst (1):
      drm/ttm/tests: Fix build failure on PREEMPT_RT

Marc Buerg (1):
      sysctl: fix uninitialized variable in proc_do_large_bitmap

Marc Kleine-Budde (2):
      spi: spi-fsl-lpspi: fix teardown order issue (UAF)
      can: netlink: can_changelink(): add missing error handling to call can_ctrlmode_changelink()

Marc Zyngier (1):
      KVM: arm64: Discard PC update state on vcpu reset

Marek Vasut (3):
      dmaengine: xilinx: xilinx_dma: Fix dma_device directions
      dmaengine: xilinx: xilinx_dma: Fix residue calculation for cyclic DMA
      dmaengine: xilinx: xilinx_dma: Fix unmasked residue subtraction

Mario Limonciello (1):
      Revert "ALSA: hda/intel: Add MSI X870E Tomahawk to denylist"

Mark Brown (2):
      ASoC: fsl_easrc: Fix event generation in fsl_easrc_iec958_set_reg()
      ASoC: fsl_easrc: Fix event generation in fsl_easrc_iec958_put_bits()

Mark Harmstone (1):
      btrfs: fix super block offset in error message in btrfs_validate_super()

Markus Niebel (1):
      arm64: dts: imx8mn-tqma8mqnl: fix LDO5 power off

Martin KaFai Lau (1):
      udp: Fix wildcard bind conflict check when using hash2

Matt Roper (1):
      drm/xe: Implement recent spec updates to Wa_16025250150

Matthew Auld (1):
      drm/xe: always keep track of remap prev/next

Max Boone (1):
      mm/pagewalk: fix race between concurrent split and refault

Michał Winiarski (1):
      drm/xe/pf: Fix use-after-free in migration restore

Miguel Ojeda (1):
      dma-mapping: add missing `inline` for `dma_free_attrs`

Mike Rapoport (Microsoft) (1):
      x86/efi: efi_unmap_boot_services: fix calculation of ranges_to_free size

Milos Nikic (1):
      jbd2: gracefully abort on checkpointing state corruptions

Ming Qian (1):
      media: verisilicon: Fix kernel panic due to __initconst misuse

Minseo Park (1):
      Bluetooth: L2CAP: Fix stack-out-of-bounds read in l2cap_ecred_conn_req

Minwoo Ra (1):
      xfrm: prevent policy_hthresh.work from racing with netns teardown

Mohammad Heib (1):
      ionic: fix persistent MAC address override on PF

Namjae Jeon (2):
      ksmbd: replace hardcoded hdr2_len with offsetof() in smb2_calc_max_out_buf_len()
      ksmbd: fix potencial OOB in get_file_all_info() for compound requests

Nathan Chancellor (1):
      platform/x86: lenovo: wmi-gamezone: Drop gz_chain_head

Neil Armstrong (1):
      pinctrl: qcom: spmi-gpio: implement .get_direction()

Nicholas Carlini (1):
      io_uring/fdinfo: fix OOB read in SQE_MIXED wrap check

Nikunj A Dadhania (2):
      x86/cpu: Enable FSGSBASE early in cpu_init_exception_handling()
      x86/fred: Fix early boot failures on SEV-ES/SNP guests

Nilay Shroff (1):
      block: break pcpu_alloc_mutex dependency on freeze_lock

Oliver Freyermuth (1):
      ASoC: Intel: sof_sdw: Add quirk for Alienware Area 51 (2025) 0CCD SKU

Oliver Hartkopp (2):
      can: statistics: add missing atomic access in hot path
      can: isotp: fix tx.buf use-after-free in isotp_sendmsg()

Pablo Neira Ayuso (2):
      netfilter: nft_set_rbtree: revisit array resize logic
      netfilter: nf_conntrack_expect: skip expectations in other netns via proc

Paolo Valerio (1):
      net: macb: use the current queue number for stats

Paul Moses (1):
      xfrm: iptfs: only publish mode_data after clone setup

Pengpeng Hou (1):
      Bluetooth: btusb: clamp SCO altsetting table indices

Peter Metz (1):
      platform/x86: intel-hid: Add Dell 14 Plus 2-in-1 to dmi_vgbs_allow_list

Peter Ujfalusi (1):
      ASoC: SOF: ipc4-topology: Allow bytes controls without initial payload

Peter Yin (1):
      i3c: master: dw-i3c: Fix missing of_node for virtual I2C adapter

Peter Zijlstra (3):
      x86/perf: Make sure to program the counter value for stopped events on migration
      perf: Make sure to use pmu_ctx->pmu for groups
      futex: Require sys_futex_requeue() to have identical flags

Petr Oros (2):
      ice: fix inverted ready check for VF representors
      ice: use ice_update_eth_stats() for representor stats

Pratap Nirujogi (1):
      i2c: designware: amdisp: Fix resume-probe race condition issue

Qi Tang (1):
      net/smc: fix double-free of smc_spd_priv when tee() duplicates splice pipe buffer

Qingfang Deng (1):
      net: airoha: add RCU lock around dev_fill_forward_path

Ranjan Kumar (1):
      scsi: mpi3mr: Clear reset history on ready and recheck state after timeout

Ren Wei (1):
      netfilter: ip6t_rt: reject oversized addrnr in rt_mt6_check()

Richard Fitzgerald (1):
      ASoC: cs35l56: Only patch ASP registers if the DAI is part of a DAIlink

Romain Sioen (1):
      HID: mcp2221: cancel last I2C command on read error

Roshan Kumar (1):
      xfrm: iptfs: validate inner IPv4 header length in IPTFS payload

Ruijing Dong (1):
      drm/amdgpu: fix strsep() corrupting lockup_timeout on multi-GPU (v3)

Sabrina Dubroca (7):
      xfrm: add missing extack for XFRMA_SA_PCPU in add_acquire and allocspi
      xfrm: fix the condition on x->pcpu_num in xfrm_sa_len
      xfrm: call xdo_dev_state_delete during state update
      esp: fix skb leak with espintcp and async crypto
      rtnetlink: count IFLA_PARENT_DEV_{NAME,BUS_NAME} in if_nlmsg_size
      rtnetlink: count IFLA_INFO_SLAVE_KIND in if_nlmsg_size
      rtnetlink: fix leak of SRCU struct in rtnl_link_register

Sachin Kumar (1):
      bpf: Fix constant blinding for PROBE_MEM32 stores

Samasth Norway Ananda (1):
      drm/i915/gmbus: fix spurious timeout on 512-byte burst reads

Sanman Pradhan (5):
      hwmon: (adm1177) fix sysfs ABI violation and current unit conversion
      hwmon: (pmbus/ina233) Fix error handling and sign extension in shunt voltage read
      hwmon: (pmbus/isl68137) Add mutex protection for AVS enable sysfs attributes
      hwmon: (peci/cputemp) Fix crit_hyst returning delta instead of absolute temperature
      hwmon: (peci/cputemp) Fix off-by-one in cputemp_is_visible()

Sean Christopherson (2):
      KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
      KVM: x86/mmu: Only WARN in direct MMUs when overwriting shadow-present SPTE

Sean Rhodes (1):
      ALSA: hda/realtek: Sequence GPIO2 on Star Labs StarFighter

SeongJae Park (2):
      mm/damon/stat: monitor all System RAM resources
      mm/damon/core: avoid use of half-online-committed context

Sheetal (1):
      ALSA: hda/hdmi: Add Tegra238 HDA codec device ID

Sheng Yong (1):
      erofs: set fileio bio failed in short read case

Shengjiu Wang (2):
      ASoC: simple-card-utils: Check value of is_playback_only and is_capture_only
      ASoC: fsl: imx-card: initialize playback_only and capture_only

Shigeru Yoshida (1):
      dma: swiotlb: add KMSAN annotations to swiotlb_bounce()

Shin'ichiro Kawasaki (1):
      btrfs: fix leak of kobject name for sub-group space_info

Shiraz Saleem (1):
      RDMA/irdma: Harden depth calculation functions

Shuming Fan (2):
      ASoC: rt1321: fix DMIC ch2/3 mask issue
      ASoC: SDCA: fix finding wrong entity

Simon Trimmer (1):
      ASoC: amd: acp: Add ACP6.3 match entries for Cirrus Logic parts

Simon Weber (1):
      ext4: fix journal credit check when setting fscrypt context

Smita Koralahalli (1):
      cxl/hdm: Avoid incorrect DVSEC fallback when HDM decoders are enabled

Srinivas Kandagatla (1):
      ASoC: codecs: wcd934x: fix typo in dt parsing

Srinivas Pandruvada (2):
      thermal: intel: int340x: soc_slider: Set offset only for balanced mode
      platform/x86: ISST: Correct locked bit width

Srinivasan Shanmugam (1):
      drm/amdgpu: Fix fence put before wait in amdgpu_amdkfd_submit_ib

Stefan Eichenberger (2):
      i2c: imx: fix i2c issue when reading multiple messages
      i2c: imx: ensure no clock is generated after last read

Takashi Iwai (1):
      HID: apple: Add EPOMAKER TH87 to the non-apple keyboards list

Tatyana Nikolova (4):
      RDMA/irdma: Update ibqp state to error if QP is already in error state
      RDMA/irdma: Remove a NOP wait_event() in irdma_modify_qp_roce()
      RDMA/irdma: Remove reset check from irdma_modify_qp_to_err()
      RDMA/irdma: Return EINVAL for invalid arp index error

Tejas Bharambe (1):
      ext4: validate p_idx bounds in ext4_ext_correct_indexes

Thangaraj Samynathan (1):
      net: lan743x: fix duplex configuration in mac_link_up

Theodore Ts'o (2):
      ext4: handle wraparound when searching for blocks for indirect mapped blocks
      ext4: always drain queued discard work in ext4_mb_release()

Thomas Weißschuh (1):
      kbuild: install-extmod-build: Package resolve_btfids if necessary

Toke Høiland-Jørgensen (1):
      net: openvswitch: Avoid releasing netdev before teardown completes

Tomi Valkeinen (1):
      dmaengine: xilinx_dma: Fix reset related timeout with two-channel AXIDMA

Tuo Li (1):
      dmaengine: idxd: fix possible wrong descriptor completion in llist_abort_desc()

Tyllis Xu (1):
      scsi: ibmvfc: Fix OOB access in ibmvfc_discover_targets_done()

Uzair Mughal (1):
      ALSA: hda/realtek: Add headset jack quirk for Thinkpad X390

Valentin Spreckels (1):
      net: usb: r8152: add TRENDnet TUC-ET2G

Vasily Gorbik (2):
      s390/barrier: Make array_index_mask_nospec() __always_inline
      s390/entry: Scrub r12 register on kernel entry

Victor Lattaro Volpini (1):
      platform/x86: hp-wmi: Add Victus 16-d0xxx support

Ville Syrjälä (2):
      drm/i915: Order OP vs. timeout correctly in __wait_for()
      drm/i915: Unlink NV12 planes earlier

Vinicius Costa Gomes (6):
      dmaengine: idxd: Fix crash when the event log is disabled
      dmaengine: idxd: Fix possible invalid memory access after FLR
      dmaengine: idxd: Fix not releasing workqueue on .release()
      dmaengine: idxd: Fix memory leak when a wq is reset
      dmaengine: idxd: Fix freeing the allocated ida too late
      dmaengine: idxd: Fix leaking event log memory

Viresh Kumar (2):
      cpufreq: Don't skip cpufreq_frequency_table_cpuinfo()
      cpufreq: conservative: Reset requested_freq on limits change

Vladimir Yakovlev (1):
      spi: spi-dw-dma: fix print error log when wait finish transaction

Wei Fang (1):
      net: enetc: fix the output issue of 'ethtool --show-ring'

Weiming Shi (3):
      netfilter: nfnetlink_log: fix uninitialized padding leak in NFULA_PAYLOAD
      netfilter: nf_conntrack_sip: fix use of uninitialized rtp_addr in process_sdp
      ACPI: EC: clean up handlers on probe failure in acpi_ec_setup()

Werner Kasselman (2):
      ksmbd: fix memory leaks and NULL deref in smb2_lock()
      ksmbd: fix use-after-free and NULL deref in smb_grant_oplock()

Wesley Atwell (1):
      tracing: Drain deferred trigger frees if kthread creation fails

Xi Ruoyao (1):
      LoongArch: vDSO: Emit GNU_EH_FRAME correctly

Xuan Zhuo (2):
      virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
      virtio-net: correct hdr_len handling for tunnel gso

Xuewen Yan (1):
      tracing: Revert "tracing: Remove pid in task_rename tracing output"

Yang Wang (1):
      drm/amdgpu: fix gpu idle power consumption issue for gfx v12

Yang Yang (2):
      openvswitch: defer tunnel netdev_put to RCU release
      openvswitch: validate MPLS set/set_masked payload length

Yazhou Tang (1):
      bpf: Reset register ID for BPF_END value tracking

Ye Bin (4):
      ext4: test if inode's all dirty pages are submitted to disk
      ext4: avoid allocate block from corrupted group in ext4_mb_find_by_goal()
      ext4: introduce EXPORT_SYMBOL_FOR_EXT4_TEST() helper
      ext4: fix mballoc-test.c is not compiled when EXT4_KUNIT_TESTS=M

Yihang Li (1):
      scsi: scsi_transport_sas: Fix the maximum channel scanning issue

Yochai Eisenrich (1):
      net: fix fanout UAF in packet_release() via NETDEV_UP race

Yonatan Nachum (3):
      RDMA/efa: Check stored completion CTX command ID with received one
      RDMA/efa: Improve admin completion context state machine
      RDMA/efa: Fix use of completion ctx after free

Youngjun Park (1):
      PM: sleep: Drop spurious WARN_ON() from pm_restore_gfp_mask()

Yuchan Nam (1):
      media: mc, v4l2: serialize REINIT and REQBUFS with req_queue_mutex

Yussuf Khalil (1):
      drm/amd/display: Do not skip unrelated mode changes in DSC validation

Yuto Ohnuki (4):
      xfs: stop reclaim before pushing AIL during unmount
      xfs: save ailp before dropping the AIL lock in push callbacks
      xfs: avoid dereferencing log items after push callbacks
      ext4: replace BUG_ON with proper error handling in ext4_read_inline_folio

Zenghui Yu (Huawei) (1):
      KVM: arm64: Fix the descriptor address in __kvm_at_swap_desc()

Zhan Xusheng (1):
      alarmtimer: Fix argument order in alarm_timer_forward()

Zhang Chen (1):
      Bluetooth: L2CAP: Fix send LE flow credits in ACL link

Zhang Heng (3):
      ALSA: hda/realtek: Add quirk for Gigabyte Technology to fix headphone
      ALSA: hda/realtek: add quirk for ASUS UM6702RC
      ALSA: hda/realtek: add quirk for ASUS Strix G16 G615JMR

Zhang Lixu (1):
      HID: intel-ish-hid: ipc: Add Nova Lake-H/S PCI device IDs

Zhang Yi (1):
      ext4: do not check fast symlink during orphan recovery

Zqiang (1):
      ext4: fix the might_sleep() warnings in kvfree()

Zubin Mithra (1):
      virt: tdx-guest: Fix handling of host controlled 'quote' buffer length

hongao (1):
      xfs: scrub: unlock dquot before early return in quota scrub

wangdicheng (1):
      ALSA: hda/senary: Ensure EAPD is enabled during init

xietangxin (1):
      virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false

zhidao su (1):
      sched_ext: Use WRITE_ONCE() for the write side of dsq->seq update


