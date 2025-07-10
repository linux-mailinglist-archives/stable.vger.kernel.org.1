Return-Path: <stable+bounces-161597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F3FB005AE
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 16:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD5A760942
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 14:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF0D27604B;
	Thu, 10 Jul 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QEcyvypW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A82749CF;
	Thu, 10 Jul 2025 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158879; cv=none; b=MrYWIxbJM/x2xOiQWJZ58Zia2g1ABnjrAuIwtRTar4WNPLE7Mwjccg5Suucer4txGsnBdO+d2TKAPxtgj1JcW1FHCvmLq4++ABVieh0h512jv+6A2IC2480dyGaZBFvZkX7tQCV3kvBuEPXD14RT+qFExjvNBJz3SzKQFABG+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158879; c=relaxed/simple;
	bh=ev61yJGCWaC1EO0aN2nz597OuEZHQfboJek2eUU/0Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f4p1VbOkQrp0T3hf7kSE9lxZq5+iuafC6g2WrwpJKlKeyRw0wReEDfCredkA4ayYtbi8gH1S6vMDvK+P2XR/1fbAh1SQGLyu0Ncda+6///qkNQN2o56mxgfTV3MXm5ZHF/lANze1oGY6mVpDgiWFBzDnbSjoBC5LGidsKQvF7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QEcyvypW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA8CC4CEF5;
	Thu, 10 Jul 2025 14:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752158878;
	bh=ev61yJGCWaC1EO0aN2nz597OuEZHQfboJek2eUU/0Qc=;
	h=From:To:Cc:Subject:Date:From;
	b=QEcyvypWyTcYTfmQsV9fwmUA2NiWyPb1DcXsp/ztfmfFEamG9WFBpOSB1Kp8rHBjQ
	 QoG8HDBBah/fUnULXtzlWM3uQiQjXDW1Ea0sWIakrzEjypmSGmExtavQ1QTjtpootK
	 lGQC+YrO+/QFCxCylA9EOYD09ovtmoD8AGnHy9/A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.37
Date: Thu, 10 Jul 2025 16:47:42 +0200
Message-ID: <2025071043-grass-unknotted-2378@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.37 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu              |    1 
 Documentation/ABI/testing/sysfs-driver-ufs                      |    2 
 Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst |    4 
 Documentation/admin-guide/kernel-parameters.txt                 |   13 
 Documentation/arch/x86/mds.rst                                  |    8 
 Documentation/core-api/symbol-namespaces.rst                    |   22 
 Makefile                                                        |    2 
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi                       |    2 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                            |  163 -
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts                       |    2 
 arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi             |    3 
 arch/arm64/boot/dts/renesas/cat875.dtsi                         |    3 
 arch/arm64/boot/dts/renesas/condor-common.dtsi                  |    3 
 arch/arm64/boot/dts/renesas/draak.dtsi                          |    3 
 arch/arm64/boot/dts/renesas/ebisu.dtsi                          |    3 
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi                 |    3 
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts                  |    3 
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts                  |    3 
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts                  |    3 
 arch/arm64/boot/dts/renesas/r8a779a0-falcon.dts                 |    3 
 arch/arm64/boot/dts/renesas/r8a779f0-spider-ethernet.dtsi       |    9 
 arch/arm64/boot/dts/renesas/r8a779f4-s4sk.dts                   |    6 
 arch/arm64/boot/dts/renesas/r8a779g2-white-hawk-single.dts      |   63 
 arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts       |    3 
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi                |    6 
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi               |    3 
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi               |    6 
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi                |    6 
 arch/arm64/boot/dts/renesas/salvator-common.dtsi                |    3 
 arch/arm64/boot/dts/renesas/ulcb.dtsi                           |    3 
 arch/arm64/boot/dts/renesas/white-hawk-cpu-common.dtsi          |    3 
 arch/arm64/boot/dts/renesas/white-hawk-ethernet.dtsi            |    6 
 arch/arm64/boot/dts/renesas/white-hawk-single.dtsi              |   77 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                   |   42 
 arch/powerpc/include/uapi/asm/ioctls.h                          |    8 
 arch/powerpc/kernel/Makefile                                    |    2 
 arch/riscv/kernel/cpu_ops_sbi.c                                 |    6 
 arch/s390/pci/pci_event.c                                       |   15 
 arch/x86/Kconfig                                                |    9 
 arch/x86/entry/entry.S                                          |    8 
 arch/x86/include/asm/cpu.h                                      |   12 
 arch/x86/include/asm/cpufeatures.h                              |    6 
 arch/x86/include/asm/irqflags.h                                 |    4 
 arch/x86/include/asm/mwait.h                                    |   28 
 arch/x86/include/asm/nospec-branch.h                            |   37 
 arch/x86/kernel/cpu/amd.c                                       |   60 
 arch/x86/kernel/cpu/bugs.c                                      |  133 
 arch/x86/kernel/cpu/common.c                                    |   14 
 arch/x86/kernel/cpu/microcode/amd.c                             |   12 
 arch/x86/kernel/cpu/microcode/amd_shas.c                        |  112 
 arch/x86/kernel/cpu/scattered.c                                 |    2 
 arch/x86/kernel/process.c                                       |   16 
 arch/x86/kvm/cpuid.c                                            |    8 
 arch/x86/kvm/reverse_cpuid.h                                    |    8 
 arch/x86/kvm/svm/vmenter.S                                      |    6 
 arch/x86/kvm/vmx/vmx.c                                          |    2 
 drivers/acpi/acpica/dsmethod.c                                  |    7 
 drivers/acpi/thermal.c                                          |   12 
 drivers/ata/libata-acpi.c                                       |   24 
 drivers/ata/pata_cs5536.c                                       |    2 
 drivers/ata/pata_via.c                                          |    6 
 drivers/base/cpu.c                                              |    3 
 drivers/block/aoe/aoe.h                                         |    1 
 drivers/block/aoe/aoecmd.c                                      |    8 
 drivers/block/aoe/aoedev.c                                      |    5 
 drivers/crypto/intel/iaa/iaa_crypto_main.c                      |  140 
 drivers/crypto/xilinx/zynqmp-sha.c                              |   18 
 drivers/dma-buf/dma-resv.c                                      |   12 
 drivers/firmware/arm_ffa/driver.c                               |   59 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                         |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                         |   10 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                          |    4 
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c                          |    6 
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c                         | 1624 ++++++++++
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c         |   35 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                  |    8 
 drivers/gpu/drm/bridge/aux-hpd-bridge.c                         |    3 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                        |   12 
 drivers/gpu/drm/i915/display/intel_dp.c                         |   18 
 drivers/gpu/drm/i915/gt/intel_gsc.c                             |    2 
 drivers/gpu/drm/i915/gt/intel_ring_submission.c                 |    3 
 drivers/gpu/drm/i915/selftests/i915_request.c                   |   20 
 drivers/gpu/drm/i915/selftests/mock_request.c                   |    2 
 drivers/gpu/drm/msm/msm_gem_submit.c                            |   17 
 drivers/gpu/drm/tiny/simpledrm.c                                |    4 
 drivers/gpu/drm/v3d/v3d_drv.h                                   |    8 
 drivers/gpu/drm/v3d/v3d_gem.c                                   |    2 
 drivers/gpu/drm/v3d/v3d_irq.c                                   |   37 
 drivers/gpu/drm/xe/Kconfig                                      |    3 
 drivers/gpu/drm/xe/abi/guc_communication_ctb_abi.h              |    1 
 drivers/gpu/drm/xe/compat-i915-headers/gem/i915_gem_stolen.h    |    2 
 drivers/gpu/drm/xe/display/xe_dsb_buffer.c                      |   18 
 drivers/gpu/drm/xe/display/xe_fb_pin.c                          |   17 
 drivers/gpu/drm/xe/regs/xe_reg_defs.h                           |    2 
 drivers/gpu/drm/xe/xe_bo.c                                      |   78 
 drivers/gpu/drm/xe/xe_bo.h                                      |   40 
 drivers/gpu/drm/xe/xe_bo_evict.c                                |   14 
 drivers/gpu/drm/xe/xe_bo_types.h                                |   10 
 drivers/gpu/drm/xe/xe_device.c                                  |   55 
 drivers/gpu/drm/xe/xe_ggtt.c                                    |   35 
 drivers/gpu/drm/xe/xe_guc.c                                     |    4 
 drivers/gpu/drm/xe/xe_guc_ct.c                                  |  350 +-
 drivers/gpu/drm/xe/xe_guc_ct.h                                  |    2 
 drivers/gpu/drm/xe/xe_guc_ct_types.h                            |   23 
 drivers/gpu/drm/xe/xe_guc_pc.c                                  |  144 
 drivers/gpu/drm/xe/xe_guc_pc.h                                  |    2 
 drivers/gpu/drm/xe/xe_guc_pc_types.h                            |    2 
 drivers/gpu/drm/xe/xe_irq.c                                     |    4 
 drivers/gpu/drm/xe/xe_trace_bo.h                                |    2 
 drivers/i2c/busses/i2c-designware-master.c                      |    1 
 drivers/infiniband/hw/mlx5/counters.c                           |    4 
 drivers/infiniband/hw/mlx5/devx.c                               |    2 
 drivers/infiniband/hw/mlx5/main.c                               |   33 
 drivers/infiniband/hw/mlx5/mr.c                                 |   63 
 drivers/infiniband/hw/mlx5/odp.c                                |    8 
 drivers/infiniband/sw/rxe/rxe_qp.c                              |    7 
 drivers/input/joystick/xpad.c                                   |    2 
 drivers/input/misc/cs40l50-vibra.c                              |    2 
 drivers/input/misc/iqs7222.c                                    |    7 
 drivers/iommu/ipmmu-vmsa.c                                      |    2 
 drivers/iommu/rockchip-iommu.c                                  |    3 
 drivers/mfd/exynos-lpass.c                                      |   25 
 drivers/mmc/core/quirks.h                                       |   12 
 drivers/mmc/host/mtk-sd.c                                       |   21 
 drivers/mmc/host/sdhci.c                                        |    9 
 drivers/mmc/host/sdhci.h                                        |   16 
 drivers/mtd/nand/spi/core.c                                     |    1 
 drivers/net/bonding/bond_main.c                                 |    8 
 drivers/net/ethernet/amd/xgbe/xgbe-common.h                     |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                       |   13 
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c                     |   24 
 drivers/net/ethernet/amd/xgbe/xgbe.h                            |    4 
 drivers/net/ethernet/atheros/atlx/atl1.c                        |   79 
 drivers/net/ethernet/cisco/enic/enic_main.c                     |    4 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                |   26 
 drivers/net/ethernet/intel/idpf/idpf_controlq.c                 |   23 
 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h             |    2 
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c                  |    4 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                      |   12 
 drivers/net/ethernet/intel/igc/igc_main.c                       |   10 
 drivers/net/ethernet/sun/niu.c                                  |   31 
 drivers/net/ethernet/sun/niu.h                                  |    4 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                     |    1 
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c                  |    2 
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c                 |   22 
 drivers/net/usb/lan78xx.c                                       |    2 
 drivers/net/virtio_net.c                                        |   60 
 drivers/net/wireless/ath/ath12k/dp_rx.c                         |    3 
 drivers/net/wireless/ath/ath12k/dp_rx.h                         |    3 
 drivers/net/wireless/ath/ath12k/dp_tx.c                         |   21 
 drivers/net/wireless/ath/ath12k/mac.c                           |   16 
 drivers/net/wireless/ath/ath6kl/bmi.c                           |    4 
 drivers/nvme/host/core.c                                        |    2 
 drivers/nvme/target/nvmet.h                                     |    2 
 drivers/platform/mellanox/mlxbf-pmc.c                           |    2 
 drivers/platform/mellanox/mlxbf-tmfifo.c                        |    3 
 drivers/platform/mellanox/mlxreg-lc.c                           |    2 
 drivers/platform/mellanox/nvsw-sn2201.c                         |    2 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                       |    9 
 drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h     |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c     |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c      |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c  |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c   |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c              |   25 
 drivers/platform/x86/firmware_attributes_class.c                |   41 
 drivers/platform/x86/firmware_attributes_class.h                |    3 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c                    |   14 
 drivers/platform/x86/think-lmi.c                                |  103 
 drivers/powercap/intel_rapl_common.c                            |   18 
 drivers/regulator/fan53555.c                                    |   14 
 drivers/regulator/gpio-regulator.c                              |    8 
 drivers/remoteproc/ti_k3_dsp_remoteproc.c                       |    6 
 drivers/remoteproc/ti_k3_m4_remoteproc.c                        |    6 
 drivers/remoteproc/ti_k3_r5_remoteproc.c                        |  180 -
 drivers/rtc/rtc-cmos.c                                          |   10 
 drivers/rtc/rtc-pcf2127.c                                       |    7 
 drivers/scsi/lpfc/lpfc_bsg.c                                    |    6 
 drivers/scsi/lpfc/lpfc_crtn.h                                   |    2 
 drivers/scsi/lpfc/lpfc_ct.c                                     |   18 
 drivers/scsi/lpfc/lpfc_debugfs.c                                |    4 
 drivers/scsi/lpfc/lpfc_disc.h                                   |   60 
 drivers/scsi/lpfc/lpfc_els.c                                    |  437 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c                                |  305 -
 drivers/scsi/lpfc/lpfc_init.c                                   |   58 
 drivers/scsi/lpfc/lpfc_nportdisc.c                              |  329 --
 drivers/scsi/lpfc/lpfc_nvme.c                                   |    9 
 drivers/scsi/lpfc/lpfc_nvmet.c                                  |    2 
 drivers/scsi/lpfc/lpfc_scsi.c                                   |    8 
 drivers/scsi/lpfc/lpfc_sli.c                                    |   78 
 drivers/scsi/lpfc/lpfc_vport.c                                  |    6 
 drivers/scsi/qla2xxx/qla_mbx.c                                  |    2 
 drivers/scsi/qla4xxx/ql4_os.c                                   |    2 
 drivers/scsi/sd.c                                               |    2 
 drivers/spi/spi-fsl-dspi.c                                      |   11 
 drivers/target/target_core_pr.c                                 |    4 
 drivers/tee/optee/ffa_abi.c                                     |   41 
 drivers/tee/optee/optee_private.h                               |    2 
 drivers/ufs/core/ufs-sysfs.c                                    |    4 
 drivers/usb/cdns3/cdnsp-debug.h                                 |    5 
 drivers/usb/cdns3/cdnsp-ep0.c                                   |   18 
 drivers/usb/cdns3/cdnsp-gadget.h                                |    6 
 drivers/usb/cdns3/cdnsp-ring.c                                  |    7 
 drivers/usb/chipidea/udc.c                                      |    7 
 drivers/usb/core/hub.c                                          |    3 
 drivers/usb/core/quirks.c                                       |    3 
 drivers/usb/core/usb-acpi.c                                     |    4 
 drivers/usb/dwc3/core.c                                         |    9 
 drivers/usb/dwc3/gadget.c                                       |   22 
 drivers/usb/host/xhci-dbgcap.c                                  |    4 
 drivers/usb/host/xhci-dbgtty.c                                  |    1 
 drivers/usb/host/xhci-mem.c                                     |    4 
 drivers/usb/host/xhci-pci.c                                     |   25 
 drivers/usb/host/xhci-plat.c                                    |    3 
 drivers/usb/host/xhci-ring.c                                    |    5 
 drivers/usb/host/xhci.c                                         |   31 
 drivers/usb/host/xhci.h                                         |    3 
 drivers/usb/typec/altmodes/displayport.c                        |    5 
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c                  |   14 
 fs/anon_inodes.c                                                |   27 
 fs/bcachefs/fsck.c                                              |    2 
 fs/bcachefs/recovery.c                                          |    2 
 fs/bcachefs/util.h                                              |    2 
 fs/btrfs/file.c                                                 |   21 
 fs/btrfs/inode.c                                                |   36 
 fs/btrfs/ioctl.c                                                |    4 
 fs/btrfs/tree-log.c                                             |  377 +-
 fs/erofs/xattr.c                                                |    2 
 fs/f2fs/data.c                                                  |    2 
 fs/f2fs/f2fs.h                                                  |   35 
 fs/f2fs/file.c                                                  |    3 
 fs/f2fs/gc.h                                                    |    1 
 fs/f2fs/segment.c                                               |   11 
 fs/f2fs/segment.h                                               |   10 
 fs/f2fs/super.c                                                 |   42 
 fs/file_table.c                                                 |    4 
 fs/gfs2/aops.c                                                  |   54 
 fs/gfs2/aops.h                                                  |    3 
 fs/gfs2/bmap.c                                                  |    3 
 fs/gfs2/glock.c                                                 |   19 
 fs/gfs2/glops.c                                                 |    9 
 fs/gfs2/incore.h                                                |    3 
 fs/gfs2/inode.c                                                 |   96 
 fs/gfs2/inode.h                                                 |    1 
 fs/gfs2/log.c                                                   |    7 
 fs/gfs2/super.c                                                 |  114 
 fs/gfs2/trace_gfs2.h                                            |    9 
 fs/gfs2/trans.c                                                 |   21 
 fs/gfs2/trans.h                                                 |    2 
 fs/gfs2/xattr.c                                                 |   11 
 fs/gfs2/xattr.h                                                 |    2 
 fs/kernfs/file.c                                                |    2 
 fs/netfs/buffered_write.c                                       |    2 
 fs/netfs/direct_write.c                                         |    8 
 fs/netfs/write_collect.c                                        |    5 
 fs/nfs/flexfilelayout/flexfilelayout.c                          |  121 
 fs/nfs/inode.c                                                  |   17 
 fs/nfs/pnfs.c                                                   |    4 
 fs/smb/client/cifsglob.h                                        |    2 
 fs/smb/client/cifsproto.h                                       |    1 
 fs/smb/client/cifssmb.c                                         |    2 
 fs/smb/client/connect.c                                         |   15 
 fs/smb/client/misc.c                                            |    6 
 fs/smb/client/readdir.c                                         |    2 
 fs/smb/client/smb2pdu.c                                         |   11 
 include/linux/bpf_verifier.h                                    |   31 
 include/linux/cpu.h                                             |    1 
 include/linux/dcache.h                                          |    1 
 include/linux/export.h                                          |   12 
 include/linux/fs.h                                              |    2 
 include/linux/libata.h                                          |    7 
 include/linux/spinlock.h                                        |   13 
 include/linux/usb.h                                             |    2 
 include/linux/usb/typec_dp.h                                    |    1 
 kernel/bpf/verifier.c                                           |  125 
 kernel/irq/irq_sim.c                                            |    2 
 kernel/rcu/tree.c                                               |    4 
 kernel/sched/core.c                                             |    4 
 kernel/sched/debug.c                                            |    7 
 kernel/sched/ext.c                                              |   12 
 kernel/sched/fair.c                                             |  117 
 kernel/sched/pelt.c                                             |    4 
 kernel/sched/sched.h                                            |    5 
 lib/Kconfig.ubsan                                               |    2 
 lib/test_objagg.c                                               |    4 
 mm/secretmem.c                                                  |   10 
 mm/userfaultfd.c                                                |   33 
 mm/vmalloc.c                                                    |   63 
 net/bluetooth/hci_event.c                                       |   36 
 net/bluetooth/hci_sync.c                                        |  227 -
 net/bluetooth/mgmt.c                                            |   25 
 net/mac80211/rx.c                                               |    4 
 net/rose/rose_route.c                                           |   15 
 net/sched/sch_api.c                                             |   19 
 net/sunrpc/rpc_pipe.c                                           |   14 
 net/vmw_vsock/vmci_transport.c                                  |    4 
 security/selinux/ss/services.c                                  |   16 
 sound/isa/sb/sb16_main.c                                        |    7 
 sound/soc/amd/yc/acp6x-mach.c                                   |   14 
 sound/soc/codecs/tas2764.c                                      |   46 
 sound/soc/codecs/tas2764.h                                      |    3 
 tools/testing/kunit/qemu_configs/sparc.py                       |    7 
 tools/testing/selftests/iommu/iommufd.c                         |   30 
 304 files changed, 5903 insertions(+), 2737 deletions(-)

Ahmed Zaki (1):
      idpf: convert control queue mutex to a spinlock

Al Viro (1):
      add a string-to-qstr constructor

Alex Deucher (1):
      drm/amdgpu/mes: add missing locking in helper functions

Alok Tiwari (5):
      platform/mellanox: mlxbf-pmc: Fix duplicate event ID for CACHE_DATA1
      platform/mellanox: nvsw-sn2201: Fix bus number in adapter error message
      nvme: Fix incorrect cdw15 value in passthru error logging
      platform/mellanox: mlxreg-lc: Fix logic error in power state check
      enic: fix incorrect MTU comparison in enic_change_mtu()

Andreas Gruenbacher (12):
      gfs2: Initialize gl_no_formal_ino earlier
      gfs2: Rename GIF_{DEFERRED -> DEFER}_DELETE
      gfs2: Rename dinode_demise to evict_behavior
      gfs2: Prevent inode creation race
      gfs2: Decode missing glock flags in tracepoints
      gfs2: Add GLF_PENDING_REPLY flag
      gfs2: Replace GIF_DEFER_DELETE with GLF_DEFER_DELETE
      gfs2: Move gfs2_dinode_dealloc
      gfs2: Move GIF_ALLOC_FAILED check out of gfs2_ea_dealloc
      gfs2: deallocate inodes in gfs2_create_inode
      gfs2: Move gfs2_trans_add_databufs
      gfs2: Don't start unnecessary transactions during log flush

Andrei Kuchynski (1):
      usb: typec: displayport: Fix potential deadlock

Andrii Nakryiko (1):
      bpf: use common instruction history across all states

Armin Wolf (1):
      ACPI: thermal: Execute _SCP before reading trip points

Arnd Bergmann (1):
      iommu: ipmmu-vmsa: avoid Wformat-security warning

Avri Altman (1):
      mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier

Bart Van Assche (1):
      scsi: ufs: core: Fix spelling of a sysfs attribute name

Beleswar Padhi (5):
      remoteproc: k3-r5: Add devm action to release reserved memory
      remoteproc: k3-r5: Use devm_kcalloc() helper
      remoteproc: k3-r5: Use devm_ioremap_wc() helper
      remoteproc: k3-r5: Use devm_rproc_add() helper
      remoteproc: k3-r5: Refactor sequential core power up/down operations

Benjamin Coddington (1):
      NFSv4/pNFS: Fix a race to wake on NFS_LAYOUT_DRAIN

Borislav Petkov (AMD) (5):
      x86/bugs: Rename MDS machinery to something more generic
      x86/bugs: Add a Transient Scheduler Attacks mitigation
      KVM: SVM: Advertise TSA CPUID bits to guests
      x86/microcode/AMD: Add TSA microcode SHAs
      x86/process: Move the buffer clearing before MONITOR

Bui Quang Minh (2):
      virtio-net: xsk: rx: fix the frame's length check
      virtio-net: ensure the received length does not exceed allocated size

Chao Yu (2):
      f2fs: zone: introduce first_zoned_segno in f2fs_sb_info
      f2fs: zone: fix to calculate first_zoned_segno correctly

Christian Eggers (4):
      Bluetooth: HCI: Set extended advertising data synchronously
      Bluetooth: hci_sync: revert some mesh modifications
      Bluetooth: MGMT: set_mesh: update LE scan interval and window
      Bluetooth: MGMT: mesh_send: check instances prior disabling advertising

Christian König (1):
      dma-buf: fix timeout handling in dma_resv_wait_timeout v2

Christian Marangi (1):
      spinlock: extend guard with spinlock_bh variants

Christophe JAILLET (1):
      mfd: exynos-lpass: Fix another error handling path in exynos_lpass_probe()

Cosmin Ratiu (1):
      bonding: Mark active offloaded xfrm_states

Daeho Jeong (1):
      f2fs: decrease spare area for pinned files for zoned devices

Dan Carpenter (2):
      drm/i915/selftests: Change mock_request() to return error pointers
      lib: test_objagg: Set error message in check_expect_hints_stats()

David Gow (1):
      kunit: qemu_configs: Disable faulting tests on 32-bit SPARC

David Howells (2):
      netfs: Fix i_size updating
      netfs: Fix oops in write-retry from mis-resetting the subreq iterator

David Thompson (1):
      platform/mellanox: mlxbf-tmfifo: fix vring_desc.len assignment

Dmitry Baryshkov (1):
      drm/bridge: aux-hpd-bridge: fix assignment of the of_node

Dmitry Bogdanov (1):
      nvmet: fix memory leak of bio integrity

Elena Popa (1):
      rtc: pcf2127: fix SPI command byte for PCF2131

Ewan D. Milne (1):
      scsi: lpfc: Restore clearing of NLP_UNREG_INP in ndlp->nlp_flag

Filipe Manana (10):
      btrfs: fix missing error handling when searching for inode refs during log replay
      btrfs: fix iteration of extrefs during log replay
      btrfs: return a btrfs_inode from btrfs_iget_logging()
      btrfs: return a btrfs_inode from read_one_inode()
      btrfs: fix invalid inode pointer dereferences during log replay
      btrfs: fix inode lookup error handling during log replay
      btrfs: record new subvolume in parent dir earlier to avoid dir logging races
      btrfs: propagate last_unlink_trans earlier when doing a rmdir
      btrfs: use btrfs_record_snapshot_destroy() during rmdir
      btrfs: fix wrong start offset for delalloc space release during mmap write

Frank Min (1):
      drm/amdgpu: add kicker fws loading for gfx11/smu13/psp13

Fushuai Wang (1):
      dpaa2-eth: fix xdp_rxq_info leak

Gabriel Santese (1):
      ASoC: amd: yc: Add quirk for MSI Bravo 17 D7VF internal mic

Geert Uytterhoeven (3):
      arm64: dts: renesas: Use interrupts-extended for Ethernet PHYs
      arm64: dts: renesas: Factor out White Hawk Single board support
      arm64: dts: renesas: white-hawk-single: Improve Ethernet TSN description

Greg Kroah-Hartman (1):
      Linux 6.12.37

Gyeyoung Baek (1):
      genirq/irq_sim: Initialize work context pointers properly

Harry Austen (1):
      drm/xe: Allow dropping kunit dependency as built-in

HarshaVardhana S A (1):
      vsock/vmci: Clear the vmci transport packet properly when initializing it

Heikki Krogerus (1):
      usb: acpi: fix device link removal

Heiko Stuebner (1):
      regulator: fan53555: add enable_time support and soft-start times

Herbert Xu (3):
      crypto: iaa - Remove dst_null support
      crypto: iaa - Do not clobber req->base.data
      crypto: zynqmp-sha - Add locking

Hongyu Xie (1):
      xhci: Disable stream for xHC controller with XHCI_BROKEN_STREAMS

Hugo Villeneuve (1):
      rtc: pcf2127: add missing semicolon after statement

Imre Deak (1):
      drm/i915/dp_mst: Work around Thunderbolt sink disconnect after SINK_COUNT_ESI read

James Clark (1):
      spi: spi-fsl-dspi: Clear completion counter before initiating transfer

Janne Grunau (1):
      arm64: dts: apple: t8103: Fix PCIe BCM4377 nodename

Janusz Krzysztofik (1):
      drm/i915/gt: Fix timeline left held on VMA alloc error

Jeff LaBundy (1):
      Input: iqs7222 - explicitly define number of external channels

Jens Wiklander (1):
      optee: ffa: fix sleep in atomic context

Jeongjun Park (1):
      mm/vmalloc: fix data race in show_numa_info()

Jiawen Wu (2):
      net: txgbe: request MISC IRQ in ndo_open
      net: libwx: fix the incorrect display of the queue number

Johan Hovold (1):
      arm64: dts: qcom: x1e80100-crd: mark l12b and l15b always-on

Johannes Berg (3):
      ata: pata_cs5536: fix build on 32-bit UML
      wifi: mac80211: drop invalid source address OCB frames
      wifi: ath6kl: remove WARN on bad firmware input

John Harrison (1):
      drm/xe/guc: Dead CT helper

Juha-Pekka Heikkila (1):
      drm/xe: add interface to request physical alignment for buffer objects

Junxiao Chang (1):
      drm/i915/gsc: mei interrupt top half should be in irq disabled context

Justin Sanders (1):
      aoe: defer rexmit timer downdev work to workqueue

Justin Tee (3):
      scsi: lpfc: Remove NLP_RELEASE_RPI flag from nodelist structure
      scsi: lpfc: Change lpfc_nodelist nlp_flag member into a bitmask
      scsi: lpfc: Avoid potential ndlp use-after-free in dev_loss_tmo_callbk

Kairui Song (1):
      mm: userfaultfd: fix race of userfaultfd_move and swap cache

Kees Cook (1):
      ubsan: integer-overflow: depend on BROKEN to keep this out of CI

Kohei Enju (1):
      rose: fix dangling neighbour pointers in rose_rt_device_down()

Krzysztof Kozlowski (1):
      arm64: dts: qcom: sm8650: change labels to lower-case

Kuen-Han Tsai (1):
      usb: dwc3: Abort suspend on soft disconnect failure

Kuniyuki Iwashima (1):
      nfs: Clean up /proc/net/rpc/nfs when nfs_fs_proc_net_init() fails.

Kurt Borja (7):
      platform/x86: dell-wmi-sysman: Fix WMI data block retrieval in sysfs callbacks
      platform/x86: hp-bioscfg: Fix class device unregistration
      platform/x86: think-lmi: Fix class device unregistration
      platform/x86: dell-wmi-sysman: Fix class device unregistration
      platform/x86: think-lmi: Create ksets consecutively
      platform/x86: think-lmi: Fix kobject cleanup
      platform/x86: think-lmi: Fix sysfs group cleanup

Lion Ackermann (1):
      net/sched: Always pass notifications when child class becomes empty

Longfang Liu (2):
      hisi_acc_vfio_pci: bugfix cache write-back issue
      hisi_acc_vfio_pci: bugfix the problem of uninstalling driver

Luca Weiss (1):
      arm64: dts: qcom: sm8650: Fix domain-idle-state for CPU2

Lukasz Czechowski (1):
      arm64: dts: rockchip: fix internal USB hub instability on RK3399 Puma

Maarten Lankhorst (2):
      drm/xe: Fix DSB buffer coherency
      drm/xe: Move DSB l2 flush to a more sensible place

Madhavan Srinivasan (2):
      powerpc: Fix struct termio related ioctl macros
      powerpc/kernel: Fix ppc_save_regs inclusion in build

Manivannan Sadhasivam (1):
      regulator: gpio: Fix the out-of-bounds access to drvdata::gpiods

Marek Szyprowski (1):
      drm/exynos: fimd: Guard display clock control with runtime PM calls

Mario Limonciello (1):
      platform/x86/amd/pmc: Add PCSpecialist Lafite Pro V 14M to 8042 quirks list

Mark Zhang (1):
      RDMA/mlx5: Initialize obj_event->obj_sub_list before xa_insert

Markus Elfring (1):
      remoteproc: k3: Call of_node_put(rmem_np) only once in three functions

Martin Povišer (2):
      ASoC: tas2764: Extend driver to SN012776
      ASoC: tas2764: Reinit cache on part reset

Masami Hiramatsu (Google) (2):
      mtk-sd: Fix a pagefault in dma_unmap_sg() for not prepared data
      mtk-sd: Prevent memory corruption from DMA map failure

Mateusz Jończyk (1):
      rtc: cmos: use spin_lock_irqsave in cmos_interrupt

Mathias Nyman (1):
      xhci: dbc: Flush queued requests before stopping dbc

Matthew Auld (1):
      drm/xe: move DPT l2 flush to a more sensible place

Maurizio Lombardi (1):
      scsi: target: Fix NULL pointer dereference in core_scsi3_decode_spec_i_port()

Maíra Canal (1):
      drm/v3d: Disable interrupts before resetting the GPU

Michael Guralnik (1):
      RDMA/mlx5: Fix cache entry update on dereg error

Michael J. Ruhl (1):
      i2c/designware: Fix an initialization issue

Michal Swiatkowski (1):
      idpf: return 0 size for RSS key if not supported

Michal Wajdeczko (1):
      drm/xe/guc: Explicitly exit CT safe mode on unwind

Nicholas Kazlauskas (1):
      drm/amd/display: Add more checks for DSC / HUBP ONO guarantees

Nicolas Escande (1):
      wifi: ath12k: fix skb_ext_desc leak in ath12k_dp_tx() error path

Nicolin Chen (1):
      iommufd/selftest: Fix iommufd_dirty_tracking with large hugepage sizes

Niklas Schnelle (2):
      s390/pci: Fix stale function handles in error handling
      s390/pci: Do not try re-enabling load/store if device is disabled

Nilton Perim Neto (1):
      Input: xpad - support Acer NGR 200 Controller

Niranjana Vishwanathapura (1):
      drm/xe: Allow bo mapping on multiple ggtts

Nitin Gote (1):
      drm/xe: Replace double space with single space after comma

Oleksij Rempel (1):
      net: usb: lan78xx: fix WARN in __netif_napi_del_locked on disconnect

Oliver Neukum (1):
      Logitech C-270 even more broken

Or Har-Toov (2):
      RDMA/mlx5: Fix unsafe xarray access in implicit ODP handling
      IB/mlx5: Fix potential deadlock in MR deregistration

P Praneesh (1):
      wifi: ath12k: Handle error cases during extended skb allocation

Pablo Martin-Gomez (1):
      mtd: spinand: fix memory leak of ECC engine conf

Patrisious Haddad (3):
      RDMA/mlx5: Fix HW counters query for non-representor devices
      RDMA/mlx5: Fix CC counters query for MPV
      RDMA/mlx5: Fix vport loopback for MPV device

Paulo Alcantara (4):
      smb: client: fix warning when reconnecting channel
      smb: client: set missing retry flag in smb2_writev_callback()
      smb: client: set missing retry flag in cifs_readv_callback()
      smb: client: set missing retry flag in cifs_writev_callback()

Pawel Laszczak (1):
      usb: cdnsp: Fix issue with CV Bad Descriptor test

Pengyu Luo (1):
      arm64: dts: qcom: sm8650: add the missing l2 cache node

Peter Chen (1):
      usb: cdnsp: do not disable slot for disabled slot

Peter Zijlstra (1):
      module: Provide EXPORT_SYMBOL_GPL_FOR_MODULES() helper

Philipp Kerling (1):
      smb: client: fix readdir returning wrong type with POSIX extensions

Qu Wenruo (1):
      btrfs: prepare btrfs_page_mkwrite() for large folios

RD Babiera (1):
      usb: typec: altmodes/displayport: do not index invalid pin_assignments

Rafael J. Wysocki (1):
      ACPICA: Refuse to evaluate a method if arguments are missing

Raju Rangoju (3):
      amd-xgbe: align CL37 AN sequence as per databook
      amd-xgbe: do not double read link status
      usb: xhci: quirk for data loss in ISOC transfers

Rameshkumar Sundaram (1):
      wifi: ath12k: fix wrong handling of CCMP256 and GCMP ciphers

Raven Black (1):
      ASoC: amd: yc: update quirk data for HP Victus

Rob Clark (2):
      drm/msm: Fix a fence leak in submit error path
      drm/msm: Fix another leak in the submit error path

Roy Luo (2):
      usb: xhci: Skip xhci_reset in xhci_resume if xhci is being removed
      Revert "usb: xhci: Implement xhci_handshake_check_state() helper"

Sergey Senozhatsky (1):
      mtk-sd: reset host->mrq on prepare_data() error

Shivank Garg (1):
      fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass

Shyam Prasad N (1):
      cifs: all initializations for tcon should happen in tcon_info_alloc

Simon Xue (1):
      iommu/rockchip: prevent iommus dead loop when two masters share one IOMMU

Sonny Jiang (1):
      drm/amdgpu: VCN v5_0_1 to prevent FW checking RB during DPG pause

Stephen Smalley (1):
      selinux: change security_compute_sid to return the ssid or tsid on match

Sudeep Holla (3):
      firmware: arm_ffa: Fix memory leak by freeing notifier callback node
      firmware: arm_ffa: Move memory allocation outside the mutex locking
      firmware: arm_ffa: Replace mutex with rwlock to avoid sleep in atomic context

Takashi Iwai (2):
      ALSA: sb: Don't allow changing the DMA mode during operations
      ALSA: sb: Force to disable DMAs once when DMA mode is changed

Tasos Sahanidis (1):
      ata: libata-acpi: Do not assume 40 wire cable if no devices are enabled

Tejun Heo (1):
      sched_ext: Make scx_group_set_weight() always update tg->scx.weight

Thomas Fourier (4):
      scsi: qla2xxx: Fix DMA mapping test in qla24xx_get_port_database()
      scsi: qla4xxx: Fix missing DMA mapping error in qla4xxx_alloc_pdu()
      ethernet: atl1: Add missing DMA mapping error checks and count errors
      nui: Fix dma_mapping_error() check

Thomas Weißschuh (7):
      platform/x86: hp-bioscfg: Directly use firmware_attributes_class
      platform/x86: firmware_attributes_class: Move include linux/device/class.h
      platform/x86: firmware_attributes_class: Simplify API
      platform/x86: think-lmi: Directly use firmware_attributes_class
      platform/x86: dell-sysman: Directly use firmware_attributes_class
      kunit: qemu_configs: sparc: use Zilog console
      kunit: qemu_configs: sparc: Explicitly enable CONFIG_SPARC32=y

Thomas Zimmermann (1):
      drm/simpledrm: Do not upcast in release helpers

Trond Myklebust (1):
      NFSv4/flexfiles: Fix handling of NFS level errors in I/O

Uladzislau Rezki (Sony) (1):
      rcu: Return early if callback is not specified

Ulf Hansson (1):
      Revert "mmc: sdhci: Disable SD card clock before changing parameters"

Victor Shih (1):
      mmc: sdhci: Add a helper function for dump register in dynamic debug mode

Vinay Belgaumkar (1):
      drm/xe/bmg: Update Wa_22019338487

Vincent Guittot (2):
      sched/fair: Rename h_nr_running into h_nr_queued
      sched/fair: Add new cfs_rq.h_nr_runnable

Vitaly Lifshits (1):
      igc: disable L1.2 PCI-E link substate to avoid performance issue

Vivian Wang (1):
      riscv: cpu_ops_sbi: Use static array for boot_data

Wang Zhaolong (1):
      smb: client: fix race condition in negotiate timeout by using more precise timing

Xu Yang (1):
      usb: chipidea: udc: disconnect/reconnect from host when do suspend/resume

Xuewen Yan (1):
      sched/fair: Fixup wake_up_sync() vs DELAYED_DEQUEUE

Yang Li (1):
      Bluetooth: Prevent unintended pause by checking if advertising is active

Yonghong Song (1):
      bpf: Do not include stack ptr register in precision backtracking bookkeeping

Yunshui Jiang (1):
      Input: cs40l50-vibra - fix potential NULL dereference in cs40l50_upload_owt()

Zhang Rui (1):
      powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit cannot be changed

Zhu Yanjun (1):
      RDMA/rxe: Fix "trying to register non-static key in rxe_qp_do_cleanup" bug

jackysliu (1):
      scsi: sd: Fix VPD page 0xb7 length check

xueqin Luo (1):
      ACPI: thermal: Fix stale comment regarding trip points

Łukasz Bartosik (1):
      xhci: dbctty: disable ECHO flag by default


