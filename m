Return-Path: <stable+bounces-139437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE1DAA6A6E
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 08:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216739A7097
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 06:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC521E7C18;
	Fri,  2 May 2025 06:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GgjsJfW6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA2B1E5B93;
	Fri,  2 May 2025 06:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166045; cv=none; b=mqp5fJwrA3mqyfGm8jHAKyMtKMpVmO+1Pw9tQL0582QEPnFv9IzMLLOD2CycaFtm6klp38HCwaw055hkkZwoJz+a4tVuBq19sBYpz+HuLEVtZC10T45HqiNdlpNg+KkL3RkxRYMKTrlczIK1B3wcyCk+wHDF99qa6iU6qT8sOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166045; c=relaxed/simple;
	bh=aWC1TozatRNXzUl/isi+Fbwwj1esdVhpAVknodHUr6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kj90m0j0ou2J3Gf3evJwSmRCE3KWMX79HDJZwrCd2IUQT9w+WEHcPXM2zfRijg+FU6kS05w5IhbLU8UT54lwujqqW+58CQxUpxmcldNpKjYjAjX+dWQLpAMk6d46t+6CToZD2VSVOJywvrxsisAuHGep9I/WuckwsLV7AV91RnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GgjsJfW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3C9C4CEEE;
	Fri,  2 May 2025 06:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746166045;
	bh=aWC1TozatRNXzUl/isi+Fbwwj1esdVhpAVknodHUr6I=;
	h=From:To:Cc:Subject:Date:From;
	b=GgjsJfW6trfVZ+cBciEKMbc0PXdUP5bqWxOENW/QoKyr8M2PzUUuGmIUZUQofjn3r
	 caQSME+AI9mKaPOx1EbE3cnR+rcYmntgPapja8kzXf9jOIn6oCrZYAoFUMn/ekNFPM
	 UJ+QdhAUbrMH8YVayVfP6O09ouvXuH3M4mv1w9h4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.181
Date: Fri,  2 May 2025 08:07:11 +0200
Message-ID: <2025050211-climatic-remarry-3f9d@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.181 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/scsi/libsas.rst                             |    2 
 Makefile                                                  |    5 
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                  |    6 
 arch/arm64/include/asm/cputype.h                          |    4 
 arch/arm64/include/asm/fpsimd.h                           |    4 
 arch/arm64/include/asm/kvm_host.h                         |   17 
 arch/arm64/include/asm/kvm_hyp.h                          |    7 
 arch/arm64/include/asm/processor.h                        |    7 
 arch/arm64/include/asm/spectre.h                          |    1 
 arch/arm64/kernel/fpsimd.c                                |  117 +++-
 arch/arm64/kernel/process.c                               |    3 
 arch/arm64/kernel/proton-pack.c                           |  218 ++++----
 arch/arm64/kernel/ptrace.c                                |    3 
 arch/arm64/kernel/signal.c                                |    3 
 arch/arm64/kvm/arm.c                                      |    1 
 arch/arm64/kvm/fpsimd.c                                   |   72 +-
 arch/arm64/kvm/hyp/entry.S                                |    5 
 arch/arm64/kvm/hyp/include/hyp/switch.h                   |   86 ++-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                        |    9 
 arch/arm64/kvm/hyp/nvhe/switch.c                          |   52 +-
 arch/arm64/kvm/hyp/vhe/switch.c                           |    4 
 arch/arm64/kvm/reset.c                                    |    3 
 arch/mips/dec/prom/init.c                                 |    2 
 arch/mips/include/asm/ds1287.h                            |    2 
 arch/mips/include/asm/mips-cm.h                           |   22 
 arch/mips/kernel/cevt-ds1287.c                            |    1 
 arch/mips/kernel/mips-cm.c                                |   14 
 arch/parisc/kernel/pdt.c                                  |    2 
 arch/powerpc/kernel/rtas.c                                |    4 
 arch/riscv/include/asm/kgdb.h                             |    9 
 arch/riscv/include/asm/syscall.h                          |    7 
 arch/riscv/kernel/kgdb.c                                  |    6 
 arch/riscv/kernel/setup.c                                 |   36 +
 arch/s390/kvm/trace-s390.h                                |    4 
 arch/sparc/mm/tlb.c                                       |    5 
 arch/x86/entry/entry.S                                    |    2 
 arch/x86/events/intel/ds.c                                |    8 
 arch/x86/events/intel/uncore_snbep.c                      |  107 ----
 arch/x86/kernel/cpu/amd.c                                 |    2 
 arch/x86/kernel/cpu/bugs.c                                |   30 -
 arch/x86/kernel/e820.c                                    |   17 
 arch/x86/kvm/svm/avic.c                                   |   60 +-
 arch/x86/kvm/vmx/posted_intr.c                            |   28 -
 arch/x86/mm/tlb.c                                         |    6 
 arch/x86/platform/pvh/head.S                              |    7 
 block/blk-cgroup.c                                        |   24 
 block/blk-iocost.c                                        |    7 
 crypto/crypto_null.c                                      |   39 +
 drivers/acpi/platform_profile.c                           |   20 
 drivers/acpi/pptt.c                                       |    4 
 drivers/ata/ahci.c                                        |    2 
 drivers/ata/libata-eh.c                                   |   11 
 drivers/ata/pata_pxa.c                                    |    6 
 drivers/ata/sata_sx4.c                                    |  118 +---
 drivers/auxdisplay/hd44780.c                              |    9 
 drivers/base/devres.c                                     |    7 
 drivers/block/loop.c                                      |    9 
 drivers/bluetooth/btrtl.c                                 |    2 
 drivers/bluetooth/hci_ldisc.c                             |   19 
 drivers/bluetooth/hci_uart.h                              |    1 
 drivers/bus/mhi/host/main.c                               |   16 
 drivers/char/virtio_console.c                             |    7 
 drivers/clk/clk.c                                         |    4 
 drivers/clocksource/timer-stm32-lp.c                      |    4 
 drivers/comedi/drivers/jr3_pci.c                          |   17 
 drivers/cpufreq/cppc_cpufreq.c                            |    2 
 drivers/cpufreq/cpufreq.c                                 |    8 
 drivers/cpufreq/scmi-cpufreq.c                            |   10 
 drivers/cpufreq/scpi-cpufreq.c                            |   13 
 drivers/crypto/atmel-sha204a.c                            |    7 
 drivers/crypto/caam/qi.c                                  |    6 
 drivers/crypto/ccp/sp-pci.c                               |   15 
 drivers/dma-buf/udmabuf.c                                 |    2 
 drivers/dma/dmatest.c                                     |    6 
 drivers/gpio/gpio-tegra186.c                              |   95 ++-
 drivers/gpio/gpio-zynq.c                                  |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                   |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                  |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c    |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         |   20 
 drivers/gpu/drm/amd/display/dc/core/dc_link.c             |    2 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c |   22 
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c     |    2 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c        |    3 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c         |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c     |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c   |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c   |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c         |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c            |    2 
 drivers/gpu/drm/drm_atomic_helper.c                       |    2 
 drivers/gpu/drm/drm_panel.c                               |    5 
 drivers/gpu/drm/drm_panel_orientation_quirks.c            |   10 
 drivers/gpu/drm/i915/gt/intel_engine_cs.c                 |    7 
 drivers/gpu/drm/mediatek/mtk_dpi.c                        |    9 
 drivers/gpu/drm/msm/adreno/a6xx.xml.h                     |    4 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                     |  148 +++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                     |   14 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h                     |    1 
 drivers/gpu/drm/nouveau/nouveau_bo.c                      |    3 
 drivers/gpu/drm/nouveau/nouveau_gem.c                     |    3 
 drivers/gpu/drm/sti/Makefile                              |    2 
 drivers/gpu/drm/tiny/repaper.c                            |    4 
 drivers/hid/usbhid/hid-pidff.c                            |   60 +-
 drivers/hsi/clients/ssi_protocol.c                        |    1 
 drivers/i2c/busses/i2c-cros-ec-tunnel.c                   |    3 
 drivers/i3c/master.c                                      |    3 
 drivers/i3c/master/svc-i3c-master.c                       |    2 
 drivers/iio/adc/ad7768-1.c                                |    5 
 drivers/infiniband/core/umem_odp.c                        |    6 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                  |    3 
 drivers/infiniband/hw/hns/hns_roce_main.c                 |    2 
 drivers/infiniband/hw/qib/qib_fs.c                        |    1 
 drivers/infiniband/hw/usnic/usnic_ib_main.c               |   14 
 drivers/iommu/amd/iommu.c                                 |    2 
 drivers/mcb/mcb-parse.c                                   |    2 
 drivers/md/dm-cache-target.c                              |   24 
 drivers/md/dm-integrity.c                                 |    3 
 drivers/md/raid1.c                                        |   26 -
 drivers/md/raid10.c                                       |    1 
 drivers/media/common/siano/smsdvb-main.c                  |    2 
 drivers/media/i2c/adv748x/adv748x.h                       |    2 
 drivers/media/i2c/ccs/ccs-core.c                          |    6 
 drivers/media/i2c/ov7251.c                                |    4 
 drivers/media/platform/qcom/venus/hfi_parser.c            |  100 ++-
 drivers/media/platform/qcom/venus/hfi_venus.c             |   18 
 drivers/media/rc/streamzap.c                              |  135 ++---
 drivers/media/test-drivers/vim2m.c                        |    6 
 drivers/media/v4l2-core/v4l2-dv-timings.c                 |    4 
 drivers/mfd/ene-kb3930.c                                  |    2 
 drivers/misc/mei/hw-me-regs.h                             |    1 
 drivers/misc/mei/pci-me.c                                 |    1 
 drivers/misc/pci_endpoint_test.c                          |    6 
 drivers/mtd/inftlcore.c                                   |    9 
 drivers/mtd/mtdpstore.c                                   |   12 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                  |    2 
 drivers/mtd/nand/raw/r852.c                               |    3 
 drivers/net/dsa/b53/b53_common.c                          |   10 
 drivers/net/dsa/mv88e6xxx/chip.c                          |   32 +
 drivers/net/dsa/mv88e6xxx/devlink.c                       |    3 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c        |    1 
 drivers/net/ethernet/intel/igc/igc_defines.h              |    1 
 drivers/net/ethernet/intel/igc/igc_main.c                 |    1 
 drivers/net/ethernet/intel/igc/igc_ptp.c                  |   93 ++-
 drivers/net/ethernet/microsoft/mana/mana.h                |    2 
 drivers/net/ethernet/microsoft/mana/mana_en.c             |   21 
 drivers/net/phy/phy_led_triggers.c                        |   23 
 drivers/net/ppp/ppp_synctty.c                             |    5 
 drivers/net/wireless/ath/ath10k/sdio.c                    |    5 
 drivers/net/wireless/atmel/at76c50x-usb.c                 |    2 
 drivers/net/wireless/mediatek/mt76/eeprom.c               |    4 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c           |    1 
 drivers/net/wireless/ti/wl1251/tx.c                       |    4 
 drivers/ntb/hw/idt/ntb_hw_idt.c                           |   18 
 drivers/ntb/ntb_transport.c                               |    2 
 drivers/nvme/host/core.c                                  |    9 
 drivers/nvme/target/fc.c                                  |   39 -
 drivers/nvme/target/fcloop.c                              |    2 
 drivers/of/irq.c                                          |   13 
 drivers/pci/controller/pcie-brcmstb.c                     |   13 
 drivers/pci/controller/vmd.c                              |   12 
 drivers/pci/pci.c                                         |  107 ++--
 drivers/pci/probe.c                                       |   54 +-
 drivers/pci/remove.c                                      |    7 
 drivers/perf/arm_pmu.c                                    |    8 
 drivers/phy/tegra/xusb.c                                  |    2 
 drivers/pinctrl/qcom/pinctrl-msm.c                        |   12 
 drivers/platform/x86/asus-laptop.c                        |    9 
 drivers/pwm/pwm-fsl-ftm.c                                 |    6 
 drivers/pwm/pwm-mediatek.c                                |    8 
 drivers/pwm/pwm-rcar.c                                    |   24 
 drivers/s390/char/sclp_con.c                              |   17 
 drivers/s390/char/sclp_tty.c                              |   12 
 drivers/scsi/aic94xx/aic94xx.h                            |    1 
 drivers/scsi/aic94xx/aic94xx_init.c                       |    1 
 drivers/scsi/aic94xx/aic94xx_tmf.c                        |    9 
 drivers/scsi/hisi_sas/hisi_sas.h                          |   14 
 drivers/scsi/hisi_sas/hisi_sas_main.c                     |  363 ++++++--------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c                    |    2 
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c                    |   13 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                    |   16 
 drivers/scsi/isci/init.c                                  |    1 
 drivers/scsi/isci/task.c                                  |   18 
 drivers/scsi/isci/task.h                                  |    4 
 drivers/scsi/lpfc/lpfc_els.c                              |   51 +
 drivers/scsi/lpfc/lpfc_hbadisc.c                          |    2 
 drivers/scsi/mvsas/mv_defs.h                              |    5 
 drivers/scsi/mvsas/mv_init.c                              |    1 
 drivers/scsi/mvsas/mv_sas.c                               |   31 -
 drivers/scsi/mvsas/mv_sas.h                               |    1 
 drivers/scsi/pm8001/pm8001_hwi.c                          |    4 
 drivers/scsi/pm8001/pm8001_init.c                         |    1 
 drivers/scsi/pm8001/pm8001_sas.c                          |   27 -
 drivers/scsi/pm8001/pm8001_sas.h                          |   11 
 drivers/scsi/scsi_transport_iscsi.c                       |    7 
 drivers/scsi/st.c                                         |    2 
 drivers/scsi/ufs/ufs_bsg.c                                |    1 
 drivers/soc/samsung/exynos-chipid.c                       |   74 ++
 drivers/soc/ti/omap_prm.c                                 |    2 
 drivers/spi/spi-cadence-quadspi.c                         |    6 
 drivers/thermal/rockchip_thermal.c                        |    1 
 drivers/tty/serial/sifive.c                               |    6 
 drivers/usb/cdns3/cdns3-gadget.c                          |    2 
 drivers/usb/chipidea/ci_hdrc_imx.c                        |   44 +
 drivers/usb/class/cdc-wdm.c                               |   21 
 drivers/usb/core/quirks.c                                 |    9 
 drivers/usb/dwc3/dwc3-pci.c                               |   10 
 drivers/usb/dwc3/gadget.c                                 |    6 
 drivers/usb/gadget/udc/aspeed-vhub/dev.c                  |    3 
 drivers/usb/host/max3421-hcd.c                            |    7 
 drivers/usb/host/ohci-pci.c                               |   23 
 drivers/usb/host/xhci-ring.c                              |   11 
 drivers/usb/serial/ftdi_sio.c                             |    2 
 drivers/usb/serial/ftdi_sio_ids.h                         |    5 
 drivers/usb/serial/option.c                               |    3 
 drivers/usb/serial/usb-serial-simple.c                    |    7 
 drivers/usb/storage/unusual_uas.h                         |    7 
 drivers/vdpa/mlx5/core/mr.c                               |    7 
 drivers/video/backlight/led_bl.c                          |   11 
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c              |    6 
 drivers/xen/Kconfig                                       |    2 
 drivers/xen/xenfs/xensyms.c                               |    4 
 fs/Kconfig                                                |    1 
 fs/btrfs/super.c                                          |    3 
 fs/cifs/cifs_debug.c                                      |    4 
 fs/cifs/cifsglob.h                                        |    1 
 fs/cifs/cifsproto.h                                       |    7 
 fs/cifs/connect.c                                         |    2 
 fs/cifs/fs_context.c                                      |    5 
 fs/cifs/ioctl.c                                           |    3 
 fs/cifs/smb2misc.c                                        |   11 
 fs/cifs/smb2ops.c                                         |   48 +
 fs/cifs/smb2pdu.c                                         |   10 
 fs/cifs/transport.c                                       |   43 -
 fs/ext4/block_validity.c                                  |    5 
 fs/ext4/inode.c                                           |   75 ++
 fs/ext4/namei.c                                           |    2 
 fs/ext4/super.c                                           |   19 
 fs/ext4/xattr.c                                           |   11 
 fs/f2fs/f2fs.h                                            |   12 
 fs/f2fs/node.c                                            |    9 
 fs/f2fs/super.c                                           |   27 -
 fs/f2fs/sysfs.c                                           |   14 
 fs/fuse/virtio_fs.c                                       |    3 
 fs/hfs/bnode.c                                            |    6 
 fs/hfsplus/bnode.c                                        |    6 
 fs/isofs/export.c                                         |    2 
 fs/jbd2/journal.c                                         |    1 
 fs/jfs/jfs_dinode.h                                       |    2 
 fs/jfs/jfs_dmap.c                                         |   12 
 fs/jfs/jfs_imap.c                                         |   10 
 fs/jfs/jfs_incore.h                                       |    2 
 fs/jfs/jfs_txnmgr.c                                       |    4 
 fs/jfs/jfs_xtree.c                                        |    4 
 fs/jfs/jfs_xtree.h                                        |   37 -
 fs/ksmbd/oplock.c                                         |    2 
 fs/ksmbd/smb2misc.c                                       |   22 
 fs/ksmbd/smb2pdu.c                                        |   49 +
 fs/ksmbd/transport_ipc.c                                  |    7 
 fs/namespace.c                                            |    3 
 fs/nfs/Kconfig                                            |    2 
 fs/nfs/internal.h                                         |   22 
 fs/nfs/nfs4session.h                                      |    4 
 fs/nfsd/Kconfig                                           |    1 
 fs/nfsd/nfs4state.c                                       |    2 
 fs/nfsd/nfsfh.h                                           |    7 
 fs/ntfs3/file.c                                           |    1 
 fs/proc/array.c                                           |   53 +-
 include/linux/backing-dev.h                               |    1 
 include/linux/blk-cgroup.h                                |    1 
 include/linux/filter.h                                    |    9 
 include/linux/nfs.h                                       |   13 
 include/linux/pci.h                                       |    1 
 include/linux/sched/task_stack.h                          |    2 
 include/linux/soc/samsung/exynos-chipid.h                 |    6 
 include/net/bluetooth/bluetooth.h                         |    1 
 include/net/net_namespace.h                               |    1 
 include/net/sctp/structs.h                                |    3 
 include/net/sock.h                                        |   10 
 include/scsi/libsas.h                                     |   10 
 include/uapi/linux/kfd_ioctl.h                            |    2 
 include/uapi/linux/landlock.h                             |    2 
 include/xen/interface/xen-mca.h                           |    2 
 init/Kconfig                                              |    3 
 kernel/bpf/helpers.c                                      |   14 
 kernel/bpf/syscall.c                                      |   17 
 kernel/dma/contiguous.c                                   |    3 
 kernel/locking/lockdep.c                                  |    3 
 kernel/sched/cpufreq_schedutil.c                          |   18 
 kernel/trace/ftrace.c                                     |    1 
 kernel/trace/trace_events.c                               |    4 
 kernel/trace/trace_events_filter.c                        |    4 
 lib/sg_split.c                                            |    2 
 lib/string.c                                              |   15 
 lib/test_ubsan.c                                          |   18 
 mm/filemap.c                                              |    2 
 mm/gup.c                                                  |    4 
 mm/memory-failure.c                                       |   11 
 mm/memory.c                                               |    4 
 mm/vmscan.c                                               |    2 
 net/8021q/vlan_dev.c                                      |   31 -
 net/bluetooth/af_bluetooth.c                              |   22 
 net/bluetooth/hci_event.c                                 |    5 
 net/bluetooth/l2cap_core.c                                |    3 
 net/bluetooth/sco.c                                       |   18 
 net/core/dev.c                                            |    1 
 net/core/filter.c                                         |   80 +--
 net/core/net_namespace.c                                  |   21 
 net/core/page_pool.c                                      |    8 
 net/core/rtnetlink.c                                      |    2 
 net/core/selftests.c                                      |   18 
 net/core/sock.c                                           |   10 
 net/dsa/tag_8021q.c                                       |    2 
 net/ethtool/netlink.c                                     |    8 
 net/ipv6/route.c                                          |    6 
 net/mac80211/iface.c                                      |    3 
 net/mac80211/mesh_hwmp.c                                  |   14 
 net/mctp/af_mctp.c                                        |    3 
 net/mptcp/sockopt.c                                       |   16 
 net/mptcp/subflow.c                                       |   23 
 net/netfilter/ipvs/ip_vs_ctl.c                            |   10 
 net/netfilter/nft_set_pipapo_avx2.c                       |    3 
 net/openvswitch/actions.c                                 |    4 
 net/openvswitch/flow_netlink.c                            |    3 
 net/phonet/pep.c                                          |   41 +
 net/sched/sch_hfsc.c                                      |   23 
 net/sctp/socket.c                                         |   22 
 net/sctp/transport.c                                      |    2 
 net/tipc/link.c                                           |    1 
 net/tipc/monitor.c                                        |    3 
 net/tls/tls_main.c                                        |    6 
 security/landlock/errata.h                                |   87 +++
 security/landlock/setup.c                                 |   30 +
 security/landlock/setup.h                                 |    3 
 security/landlock/syscalls.c                              |   22 
 sound/pci/hda/hda_intel.c                                 |   15 
 sound/soc/codecs/lpass-wsa-macro.c                        |  117 +++-
 sound/soc/codecs/wcd934x.c                                |    2 
 sound/soc/fsl/fsl_audmix.c                                |   16 
 sound/soc/qcom/qdsp6/q6asm-dai.c                          |   19 
 sound/usb/midi.c                                          |   80 ++-
 sound/virtio/virtio_pcm.c                                 |   21 
 tools/objtool/check.c                                     |    3 
 tools/power/cpupower/bench/parse.c                        |    4 
 tools/testing/ktest/ktest.pl                              |    8 
 tools/testing/selftests/landlock/base_test.c              |   46 +
 tools/testing/selftests/mincore/mincore_selftest.c        |    3 
 tools/testing/selftests/ublk/test_stripe_04.sh            |   24 
 tools/testing/selftests/vm/charge_reserved_hugetlb.sh     |    4 
 tools/testing/selftests/vm/hugetlb_reparenting_test.sh    |    2 
 352 files changed, 3456 insertions(+), 1946 deletions(-)

Abdun Nihaal (3):
      wifi: at76c50x: fix use after free access in at76_disconnect
      wifi: wl1251: fix memory leak in wl1251_tx_work
      cxgb4: fix memory leak in cxgb4_init_ethtool_filters() error path

Abhinav Kumar (1):
      drm: allow encoder mode_set even when connectors change for crtc

Adam Xue (1):
      USB: serial: option: add Sierra Wireless EM9291

Akhil P Oommen (4):
      drm/msm/a6xx: Improve gpu recovery sequence
      drm/msm/a6xx: Handle GMU prepare-slumber hfi failure
      drm/msm/a6xx: Avoid gx gbit halt during rpm suspend
      drm/msm/a6xx: Fix stale rpmh votes from GPU

Al Viro (1):
      qibfs: fix _another_ leak

Alex Williamson (1):
      Revert "PCI: Avoid reset when disabled via sysfs"

Alexander Potapenko (1):
      kmsan: disable strscpy() optimization under KMSAN

Alexander Stein (1):
      usb: host: max3421-hcd: Add missing spi_device_id table

Alexander Usyskin (1):
      mei: me: add panther lake H DID

Alexandra Diupina (1):
      cifs: avoid NULL pointer dereference in dbg call

Alexandre Torgue (1):
      clocksource/drivers/stm32-lptimer: Use wakeup capable instead of init wakeup

Alexey Klimov (1):
      ASoC: qdsp6: q6asm-dai: fix q6asm_dai_compr_set_params error path

Andreas Gruenbacher (1):
      writeback: fix false warning in inode_to_wb()

Andrew Wyatt (2):
      drm: panel-orientation-quirks: Add support for AYANEO 2S
      drm: panel-orientation-quirks: Add new quirk for GPD Win 2

Andrii Nakryiko (1):
      bpf: avoid holding freeze_mutex during mmap operation

Andy Shevchenko (1):
      usb: dwc3: gadget: Avoid using reserved endpoints on Intel Merrifield

AngeloGioacchino Del Regno (1):
      drm/mediatek: mtk_dpi: Explicitly manage TVD clock in power on/off

Ard Biesheuvel (1):
      x86/pvh: Call C code via the kernel virtual mapping

Arnaud Lecomte (1):
      net: ppp: Add bound checking for skb data on ppp_sync_txmung

Arnd Bergmann (2):
      dma/contiguous: avoid warning about unused size_bytes
      ntb: reduce stack usage in idt_scan_mws

Arseniy Krasnov (2):
      Bluetooth: hci_uart: fix race during initialization
      Bluetooth: hci_uart: Fix another race during initialization

Artem Sadovnikov (1):
      ext4: fix off-by-one error in do_split

Ayush Jain (1):
      ktest: Fix Test Failures Due to Missing LOG_FILE Directories

Baoquan He (1):
      mm/gup: fix wrongly calculated returned value in fault_in_safe_writeable()

Ben Dooks (1):
      bpf: Add endian modifiers to fix endian warnings

Bhupesh (1):
      ext4: ignore xattrs past end

Björn Töpel (1):
      riscv: Properly export reserved regions in /proc/iomem

Boqun Feng (1):
      locking/lockdep: Decrease nr_unused_locks if lock unused in zap_class()

Chao Yu (2):
      f2fs: fix to avoid out-of-bounds access in f2fs_truncate_inode_blocks()
      f2fs: check validation of fault attrs in f2fs_build_fault_attr()

Chen Hanxiao (1):
      ipvs: properly dereference pe in ip_vs_add_service

Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8173: Fix disp-pwm compatible string

ChenXiaoSong (1):
      smb/server: fix potential null-ptr-deref of lease_ctx_info in smb2_open()

Chengchang Tang (1):
      RDMA/hns: Fix wrong maximum DMA segment size

Chenyuan Yang (3):
      mfd: ene-kb3930: Fix a potential NULL pointer dereference
      soc: samsung: exynos-chipid: Add NULL pointer check in exynos_chipid_probe()
      usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()

Chris Bainbridge (1):
      drm/nouveau: prime: fix ttm_bo_delayed_delete oops

Chris Wilson (1):
      drm/i915/gt: Cleanup partial engine discovery failures

Christopher S M Hall (4):
      igc: fix PTM cycle trigger logic
      igc: move ktime snapshot into PTM retry loop
      igc: handle the IGC_PTP_ENABLED flag correctly
      igc: cleanup PTP module if probe fails

Cong Wang (2):
      net_sched: hfsc: Fix a UAF vulnerability in class handling
      net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too

Craig Hesling (1):
      USB: serial: simple: add OWON HDS200 series oscilloscope support

Dan Carpenter (1):
      Bluetooth: btrtl: Prevent potential NULL dereference

Daniel Kral (1):
      ahci: add PCI ID for Marvell 88SE9215 SATA Controller

Daniel Wagner (3):
      nvmet-fcloop: swap list_add_tail arguments
      nvmet-fc: take tgtport reference only once
      nvmet-fc: put ref when assoc->del_work is already scheduled

Dapeng Mi (1):
      perf/x86/intel: Allow to update user space GPRs from PEBS records

Dave Kleikamp (1):
      jfs: define xtree root and page independently

David Yat Sin (1):
      drm/amdkfd: clamp queue size to minimum

Denis Arefev (7):
      asus-laptop: Fix an uninitialized variable
      drm/amd/pm: Prevent division by zero
      drm/amd/pm/powerplay: Prevent division by zero
      drm/amd/pm/powerplay/hwmgr/smu7_thermal: Prevent division by zero
      drm/amd/pm/swsmu/smu13/smu_v13_0: Prevent division by zero
      drm/amd/pm/powerplay/hwmgr/vega20_thermal: Prevent division by zero
      ksmbd: Prevent integer overflow in calculation of deadtime

Douglas Anderson (6):
      arm64: cputype: Add QCOM_CPU_PART_KRYO_3XX_GOLD
      arm64: cputype: Add MIDR_CORTEX_A76AE
      arm64: errata: Add QCOM_KRYO_4XX_GOLD to the spectre_bhb_k24_list
      arm64: errata: Assume that unknown CPUs _are_ vulnerable to Spectre BHB
      arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre BHB safe list
      arm64: errata: Add newer ARM cores to the spectre_bhb_loop_affected() lists

Edward Adam Davis (4):
      jfs: Prevent copying of nlink with value 0 from disk inode
      jfs: add sanity check for agwidth in dbMount
      isofs: Prevent the use of too small fid
      fs/ntfs3: Fix WARNING in ntfs_extend_initialized_size

Enzo Matsumiya (2):
      smb: client: fix UAF in async decryption
      cifs: print TIDs as hex

Eric Biggers (1):
      nfs: add missing selections of CONFIG_CRC32

Eric Dumazet (2):
      net: make sock_inuse_add() available
      net: defer final 'struct net' free in netns dismantle

Fedor Pchelkin (4):
      ntb: use 64-bit arithmetic for the MSI doorbell mask
      usb: chipidea: ci_hdrc_imx: fix usbmisc handling
      usb: chipidea: ci_hdrc_imx: fix call balance of regulator routines
      usb: chipidea: ci_hdrc_imx: implement usb_phy_init() error handling

Felix Huettner (1):
      net: openvswitch: fix race on port output

Florian Westphal (1):
      nft_set_pipapo: fix incorrect avx2 match of 5th field octet

Frode Isaksen (1):
      usb: dwc3: gadget: check that event count does not exceed event buffer length

Frédéric Danis (1):
      Bluetooth: l2cap: Check encryption key size on incoming connection

Fuad Tabba (1):
      KVM: arm64: Calculate cptr_el2 traps on activating traps

Gabriele Paoloni (1):
      tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER

Gang Yan (1):
      mptcp: fix NULL pointer in can_accept_new_subflow

Gavrilov Ilia (1):
      wifi: mac80211: fix integer overflow in hwmp_route_info_get()

Geert Uytterhoeven (2):
      pwm: rcar: Simplify multiplication/shift logic
      PCI: Fix dropping valid root bus resources with .end = zero

Greg Kroah-Hartman (1):
      Linux 5.15.181

Gregory CLEMENT (1):
      MIPS: cm: Detect CM quirks from device tree

Guixin Liu (2):
      scsi: ufs: bsg: Set bsg_queue to NULL after removal
      gpio: tegra186: fix resource handling in ACPI probe path

Halil Pasic (1):
      virtio_console: fix missing byte order handling for cols and rows

Hannes Reinecke (4):
      ata: sata_sx4: Drop pointless VPRINTK() calls and convert the remaining ones
      nvme: requeue namespace scan on missed AENs
      nvme: re-read ANA log page after ns scan completes
      nvme: fixup scan failure for non-ANA multipath controllers

Haoxiang Li (5):
      wifi: mt76: Add check for devm_kstrdup()
      auxdisplay: hd44780: Fix an API misuse in hd44780.c
      mcb: fix a double free bug in chameleon_parse_gdd()
      s390/sclp: Add check for get_zeroed_page()
      s390/tty: Fix a potential memory leak bug

Heiko Stuebner (1):
      clk: check for disabled clock-provider in of_clk_get_hw_from_clkspec()

Henry Martin (3):
      ata: pata_pxa: Fix potential NULL pointer dereference in pxa_ata_probe()
      cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
      cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()

Herbert Xu (2):
      crypto: caam/qi - Fix drv_ctx refcount bug
      crypto: null - Use spin lock instead of mutex

Hersen Wu (1):
      drm/amd/display: Stop amdgpu_dm initialize when link nums greater than max_links

Herve Codina (1):
      backlight: led_bl: Hold led_access lock when calling led_sysfs_disable()

Hou Tao (1):
      bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers

Huacai Chen (1):
      USB: OHCI: Add quirk for LS7A OHCI controller (rev 0x02)

Ian Abbott (1):
      comedi: jr3_pci: Fix synchronous deletion of timer

Icenowy Zheng (1):
      wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table

Igor Pylypiv (1):
      scsi: pm80xx: Set phy_attached to zero when device is gone

Ilya Maximets (2):
      net: openvswitch: fix nested key length validation in the set() action
      openvswitch: fix lockup on tx to unregistering netdev with carrier

Jakub Kicinski (1):
      net: tls: explicitly disallow disconnect

James Smart (1):
      scsi: lpfc: Fix null pointer dereference after failing to issue FLOGI and PLOGI

Jan Beulich (1):
      xenfs/xensyms: respect hypervisor's "next" indication

Jan Kara (1):
      jbd2: remove wrong sb->s_sequence check

Jann Horn (1):
      ext4: don't treat fhandle lookup of ea_inode as FS corruption

Jason Andryuk (1):
      xen: Change xen-acpi-processor dom0 dependency

Jason Xing (1):
      page_pool: avoid infinite loop to schedule delayed worker

Jean-Marc Eurin (1):
      ACPI PPTT: Fix coding mistakes in a couple of sizeof() calls

Jeff Hugo (1):
      bus: mhi: host: Fix race between unprepare and queue_buf

Jeff Layton (1):
      nfs: move nfs_fhandle_hash to common include file

Jiasheng Jiang (2):
      mtd: Add check for devm_kcalloc()
      mtd: Replace kcalloc() with devm_kcalloc()

Johannes Berg (1):
      Revert "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

Johannes Kimmel (1):
      btrfs: correctly escape subvol in btrfs_show_options()

John Garry (6):
      scsi: hisi_sas: Start delivery hisi_sas_task_exec() directly
      scsi: hisi_sas: Pass abort structure for internal abort
      scsi: hisi_sas: Factor out task prep and delivery code
      scsi: hisi_sas: Fix setting of hisi_sas_slot.is_internal
      scsi: libsas: Delete lldd_clear_aca callback
      scsi: libsas: Add struct sas_tmf_task

John Stultz (1):
      sound/virtio: Fix cancel_sync warnings on uninitialized work_structs

Jonas Gorski (1):
      net: b53: enable BPDU reception for management port

Jonathan Cameron (1):
      iio: adc: ad7768-1: Move setting of val a bit later to avoid unnecessary return value check

Josh Poimboeuf (6):
      pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()
      objtool, ASoC: codecs: wcd934x: Remove potential undefined behavior in wcd934x_slim_irq_handler()
      objtool: Stop UNRET validation on UD2
      x86/bugs: Use SBPB in write_ibpb() if applicable
      x86/bugs: Don't fill RSB on VMEXIT with eIBRS+retpoline
      x86/bugs: Don't fill RSB on context switch with eIBRS

Kai Mäkisara (1):
      scsi: st: Fix array overflow in st_setup()

Kai-Heng Feng (1):
      PCI: Coalesce host bridge contiguous apertures

Kaixin Wang (1):
      HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition

Kamal Dasu (1):
      mtd: rawnand: brcmnand: fix PM resume warning

Kan Liang (3):
      perf/x86/intel/uncore: Fix the scale of IIO free running counters on SNR
      perf/x86/intel/uncore: Fix the scale of IIO free running counters on ICX
      perf/x86/intel/uncore: Fix the scale of IIO free running counters on SPR

Kang Yang (1):
      wifi: ath10k: avoid NULL pointer error during sdio remove

Karina Yankevich (1):
      media: v4l2-dv-timings: prevent possible overflow in v4l2_detect_gtf()

Kees Cook (1):
      xen/mcelog: Add __nonstring annotations for unterminated strings

Kirill A. Shutemov (1):
      mm: fix apply_to_existing_page_range()

Krzysztof Kozlowski (2):
      gpio: zynq: Fix wakeup source leaks on device unbind
      soc: samsung: exynos-chipid: avoid soc_device_to_device()

Kunihiko Hayashi (3):
      misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
      misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
      misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type

Kunwu Chan (1):
      pmdomain: ti: Add a null pointer check to the omap_prm_domain_init

Leonid Arapov (1):
      fbdev: omapfb: Add 'plane' value check

Li Lingfeng (1):
      nfsd: decrease sc_count directly if fail to queue dl_recall

Li Nan (1):
      blk-iocost: do not WARN if iocg was already offlined

Luca Ceresoli (1):
      drm/bridge: panel: forbid initializing a panel with unknown connector type

Lucas De Marchi (1):
      drivers: base: devres: Allow to release group on device release

Luiz Augusto von Dentz (2):
      Bluetooth: hci_event: Fix sending MGMT_EV_DEVICE_FOUND for invalid address
      Bluetooth: SCO: Fix UAF on sco_sock_timeout

Ma Ke (2):
      PCI: Fix reference leak in pci_alloc_child_bus()
      PCI: Fix reference leak in pci_register_host_bridge()

Manjunatha Venkatesh (1):
      i3c: Add NULL pointer check in i3c_master_queue_ibi()

Marc Zyngier (2):
      KVM: arm64: Always start with clearing SVE flag on load
      cpufreq: cppc: Fix invalid return value in .get() callback

Marek Behún (6):
      net: dsa: mv88e6xxx: workaround RGMII transmit delay erratum for 6320 family
      net: dsa: mv88e6xxx: fix VTU methods for 6320 family
      crypto: atmel-sha204a - Set hwrng quality to lowest possible
      net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
      net: dsa: mv88e6xxx: enable PVT for 6321 switch
      net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family

Mark Brown (6):
      KVM: arm64: Get rid of host SVE tracking/saving
      KVM: arm64: Discard any SVE state when entering KVM guests
      arm64/fpsimd: Track the saved FPSIMD state type separately to TIF_SVE
      arm64/fpsimd: Have KVM explicitly say which FP registers to save
      arm64/fpsimd: Stop using TIF_SVE to manage register saving in KVM
      selftests/mm: generate a temporary mountpoint for cgroup filesystem

Mark Rutland (5):
      perf: arm_pmu: Don't disable counter in armpmu_add()
      KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
      KVM: arm64: Remove host FPSIMD saving for non-protected KVM
      KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
      KVM: arm64: Eagerly switch ZCR_EL{1,2}

Mathieu Desnoyers (1):
      mm: add missing release barrier on PGDAT_RECLAIM_LOCKED unlock

Matt Johnston (1):
      net: mctp: Set SOCK_RCU_FREE

Matthew Auld (1):
      drm/amdgpu/dma_buf: fix page_link check

Matthew Majewski (1):
      media: vim2m: print device name after registering device

Matthieu Baerts (NGI0) (2):
      mptcp: only inc MPJoinAckHMacFailure for HMAC failures
      mptcp: sockopt: fix getting IPV6_V6ONLY

Max Grobecker (1):
      x86/cpu: Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in a virtual machine

Maxim Mikityanskiy (1):
      ALSA: hda: intel: Fix Optimus when GPU has no sound

Maxime Chevallier (1):
      net: ethtool: Don't call .cleanup_data when prepare_data fails

Meir Elisha (1):
      md/raid1: Add check for missing source disk in process_checks()

Miao Li (2):
      usb: quirks: add DELAY_INIT quirk for Silicon Motion Flash Drive
      usb: quirks: Add delay init quirk for SanDisk 3.2Gen1 Flash Drive

Miaoqian Lin (2):
      scsi: iscsi: Fix missing scsi_host_put() in error path
      phy: tegra: xusb: Fix return value of tegra_xusb_find_port_node function

Michael Ehrenreich (1):
      USB: serial: ftdi_sio: add support for Abacus Electrics Optical Probe

Michal Pecio (1):
      usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems Running

Michal Schmidt (1):
      bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq

Mickaël Salaün (1):
      landlock: Add the errata interface

Mikulas Patocka (1):
      dm-integrity: set ti->error on memory allocation failure

Ming Lei (1):
      selftests: ublk: fix test_stripe_04

Ming-Hung Tsai (1):
      dm cache: fix flushing uninitialized delayed_work on cache_ctr error

Miquel Raynal (1):
      spi: cadence-qspi: Fix probe on AM62A LP SK

Mostafa Saleh (1):
      ubsan: Fix panic from test_ubsan_out_of_bounds

Murad Masimov (2):
      media: streamzap: prevent processing IR data on URB failure
      media: streamzap: fix race between device disconnection and urb callback

Myrrh Periwinkle (1):
      x86/e820: Fix handling of subpage regions when calculating nosave ranges in e820__register_nosave_regions()

Namjae Jeon (1):
      ksmbd: fix potencial out-of-bounds when buffer offset is invalid

Nathan Chancellor (4):
      ACPI: platform-profile: Fix CFI violation when accessing sysfs files
      riscv: Avoid fortify warning in syscall_get_arguments()
      kbuild: Add '-fno-builtin-wcslen'
      f2fs: Add inline to f2fs_build_fault_attr() stub

Nathan Lynch (1):
      powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()

Nikita Zhandarovich (1):
      drm/repaper: fix integer overflows in repeat functions

Niklas Cassel (1):
      ata: libata-eh: Do not use ATAPI DMA for a device limited to PIO mode

Niklas Söderlund (1):
      media: i2c: adv748x: Fix test pattern selection mask

Ojaswin Mujoo (2):
      ext4: protect ext4_release_dquot against freezing
      ext4: make block validity check resistent to sb bh corruption

Oleg Nesterov (2):
      fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats
      sched/isolation: Make CONFIG_CPU_ISOLATION depend on CONFIG_SMP

Oleksij Rempel (1):
      net: selftests: initialize TCP header and skb payload with zero

Oliver Neukum (6):
      USB: storage: quirk for ADATA Portable HDD CH94
      USB: VLI disk crashes if LPM is used
      USB: wdm: handle IO errors in wdm_wwan_port_start
      USB: wdm: close race between wdm_open and wdm_wwan_port_stop
      USB: wdm: wdm_wwan_port_tx_complete mutex in atomic context
      USB: wdm: add annotation

Pali Rohár (1):
      PCI: Assign PCI domain IDs by ida_alloc()

Paolo Abeni (1):
      ipv6: release nexthop on device removal

Paulo Alcantara (5):
      smb: client: fix potential UAF in cifs_dump_full_key()
      smb: client: fix use-after-free bug in cifs_debug_data_proc_show()
      smb: client: fix NULL ptr deref in crypto_aead_setkey()
      smb: client: fix potential deadlock when releasing mids
      smb: client: fix potential UAF in cifs_stats_proc_show()

Pei Li (1):
      jfs: Fix shift-out-of-bounds in dbDiscardAG

Peter Collingbourne (1):
      string: Add load_unaligned_zeropad() code path to sized_strscpy()

Philip Yang (1):
      drm/amdkfd: Fix pqm_destroy_queue race with GPU reset

Qingfang Deng (1):
      net: phy: leds: fix memory leak

Qiuxu Zhuo (1):
      selftests/mincore: Allow read-ahead pages to reach the end of the file

Qun-Wei Lin (1):
      sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers

Rafael J. Wysocki (2):
      cpufreq/sched: Fix the usage of CPUFREQ_NEED_UPDATE_LIMITS
      cpufreq: Reference count policy in cpufreq_update_limits()

Ralph Siemsen (1):
      usb: cdns3: Fix deadlock when using NCM gadget

Rand Deeb (2):
      fs/jfs: cast inactags to s64 to prevent potential overflow
      fs/jfs: Prevent integer overflow in AG size calculation

Remi Pommarel (2):
      wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()
      wifi: mac80211: Purge vif txq in ieee80211_do_stop()

Ricard Wanderlof (1):
      ALSA: usb-audio: Fix CME quirk for UF series keyboards

Ricardo Cañuelo Navarro (1):
      sctp: detect and prevent references to a freed transport in sendmsg

Rob Herring (1):
      PCI: Fix use-after-free in pci_bus_release_domain_nr()

Rolf Eike Beer (1):
      drm/sti: remove duplicate object names

Roman Li (1):
      drm/amd/display: Fix gpu reset in multidisplay config

Roman Smirnov (1):
      cifs: fix integer overflow in match_server()

Ross Lagerwall (1):
      PCI: Release resource invalidated by coalescing

Ryan Roberts (1):
      sparc/mm: disable preemption in lazy mmu mode

Ryo Takakura (2):
      PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t type
      serial: sifive: lock port in startup()/shutdown() callbacks

Rémi Denis-Courmont (1):
      phonet/pep: fix racy skb_queue_empty() use

Sakari Ailus (4):
      media: i2c: ccs: Set the device's runtime PM status correctly in remove
      media: i2c: ccs: Set the device's runtime PM status correctly in probe
      media: i2c: ov7251: Set enable GPIO low in probe
      media: i2c: ov7251: Introduce 1 ms delay between regulators and en GPIO

Sam Protsenko (1):
      soc: samsung: exynos-chipid: Pass revision reg offsets

Sean Christopherson (3):
      iommu/amd: Return an error if vCPU affinity is set for non-vCPU IRTE
      KVM: SVM: Allocate IR data using atomic allocation
      KVM: x86: Reset IRTE to host control if *new* route isn't postable

Sean Young (4):
      media: streamzap: remove unnecessary ir_raw_event_reset and handle
      media: streamzap: no need for usb pid/vid in device name
      media: streamzap: less chatter
      media: streamzap: remove unused struct members

Sebastian Andrzej Siewior (1):
      xdp: Reset bpf_redirect_info before running a xdp's BPF prog.

Sergiu Cuciurean (1):
      iio: adc: ad7768-1: Fix conversion result sign

Shay Drory (1):
      RDMA/core: Silence oversized kvmalloc() warning

Shengjiu Wang (1):
      ASoC: fsl_audmix: register card device depends on 'dais' property

Shuai Xue (1):
      mm/hwpoison: do not send SIGBUS to processes with recovered clean pages

Si-Wei Liu (1):
      vdpa/mlx5: Fix oversized null mkey longer than 32bit

Souradeep Chakrabarti (1):
      net: mana: Fix error handling in mana_create_txq/rxq's NAPI cleanup

Srinivas Kandagatla (2):
      ASoC: codecs:lpass-wsa-macro: Fix vi feedback rate
      ASoC: codecs:lpass-wsa-macro: Fix logic of enabling vi channels

Srinivasan Shanmugam (2):
      drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
      drm/amd/display: Add null checks for 'stream' and 'plane' before dereferencing

Stanimir Varbanov (1):
      PCI: brcmstb: Fix missing of_node_put() in brcm_pcie_probe()

Stanislav Fomichev (1):
      net: vlan: don't propagate flags on open

Stanley Chu (1):
      i3c: master: svc: Use readsb helper for reading MDB

Stephan Gerhold (1):
      pinctrl: qcom: Clear latched interrupt status when changing IRQ type

Steven Rostedt (1):
      tracing: Fix filter string testing

T Pratham (1):
      lib: scatterlist: fix sg_split_phys to preserve original scatterlist offsets

Thadeu Lima de Souza Cascardo (1):
      i2c: cros-ec-tunnel: defer probe if parent EC is not present

Thierry Reding (1):
      gpio: tegra186: Force one interrupt per bank

Thomas Bogendoerfer (1):
      MIPS: cm: Fix warning if MIPS_CM is disabled

Thomas Weißschuh (3):
      loop: properly send KOBJ_CHANGED uevent for disk device
      loop: LOOP_SET_FD: send uevents for partitions
      KVM: s390: Don't use %pK through tracepoints

Thorsten Leemhuis (1):
      module: sign with sha512 instead of sha1 by default

Tim Huang (1):
      drm/amd/display: fix double free issue during amdgpu module unload

Tom Lendacky (1):
      crypto: ccp - Fix check for the primary ASP device

Tomasz Pakuła (3):
      HID: pidff: Convert infinite length from Linux API to PID standard
      HID: pidff: Do not send effect envelope if it's empty
      HID: pidff: Fix null pointer dereference in pidff_find_fields

Trevor Woerner (1):
      thermal/drivers/rockchip: Add missing rk3328 mapping entry

Trond Myklebust (2):
      umount: Allow superblock owners to force umount
      filemap: Fix bounds checking in filemap_read()

Tung Nguyen (2):
      tipc: fix memory leak in tipc_link_xmit
      tipc: fix NULL pointer dereference in tipc_mon_reinit_self()

Tuo Li (1):
      scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()

Uwe Kleine-König (4):
      pwm: rcar: Improve register calculation
      pwm: fsl-ftm: Handle clk_get_rate() returning 0
      auxdisplay: hd44780: Convert to platform remove callback returning void
      backlight: led_bl: Convert to platform remove callback returning void

Vasiliy Kovalev (1):
      hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key

Vikash Garodia (4):
      media: venus: hfi: add a check to handle OOB in sfr region
      media: venus: hfi: add check to handle incorrect queue size
      media: venus: hfi_parser: add check to avoid out of bound access
      media: venus: hfi_parser: refactor hfi packet parsing logic

Vinicius Costa Gomes (1):
      dmaengine: dmatest: Fix dmatest waiting less when interrupted

Vitaly Prosyak (1):
      drm/amdgpu: fix usage slab after free

Vladimir Oltean (2):
      net: dsa: mv88e6xxx: avoid unregistering devlink regions which were never registered
      net: dsa: avoid refcount warnings when ds->ops->tag_8021q_vlan_del() fails

Wang Liang (1):
      net: fix crash when config small gso_max_size/gso_ipv4_max_size

WangYuli (6):
      riscv: KGDB: Do not inline arch_kgdb_breakpoint()
      riscv: KGDB: Remove ".option norvc/.option rvc" for kgdb_compiled_break
      nvmet-fc: Remove unused functions
      MIPS: dec: Declare which_prom() as static
      MIPS: cevt-ds1287: Add missing ds1287.h include
      MIPS: ds1287: Match ds1287_set_base_clock() function types

Wentao Liang (3):
      ata: sata_sx4: Add error handling in pdc20621_i2c_read()
      mtd: inftlcore: Add error check for inftl_read_oob()
      mtd: rawnand: Add status chack in r852_ready()

Willem de Bruijn (1):
      bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags

Xiangsheng Hou (1):
      virtiofs: add filesystem context source name check

Xiaogang Chen (1):
      udmabuf: fix a buf size overflow issue during udmabuf creation

Xiaxi Shen (1):
      ext4: fix timer use-after-free on failed mount

Xingui Yang (2):
      scsi: hisi_sas: Enable force phy when SATA disk directly connected
      scsi: hisi_sas: Fix I/O errors caused by hardware port ID changes

Yu Kuai (2):
      md/raid10: fix missing discard IO accounting
      blk-cgroup: support to track if policy is online

Yu-Chun Lin (1):
      parisc: PDT: Fix missing prototype warning

Yuan Can (1):
      media: siano: Fix error handling in smsdvb_module_init()

Yue Haibing (1):
      RDMA/usnic: Fix passing zero to PTR_ERR in usnic_ib_pci_probe()

Yunlong Xing (1):
      loop: aio inherit the ioprio of original request

Zhang Xiaoxu (1):
      cifs: Fix UAF in cifs_demultiplex_thread()

Zhikai Zhai (1):
      drm/amd/display: Update Cursor request mode to the beginning prefetch always

Zhongqiu Han (2):
      pm: cpupower: bench: Prevent NULL dereference on malloc failure
      jfs: Fix uninit-value access of imap allocated in the diMount() function

Zijun Hu (3):
      of/irq: Fix device node refcount leakages in of_irq_count()
      of/irq: Fix device node refcount leakage in API irq_of_parse_and_map()
      of/irq: Fix device node refcount leakages in of_irq_init()

zhoumin (1):
      ftrace: Add cond_resched() to ftrace_graph_set_hash()


