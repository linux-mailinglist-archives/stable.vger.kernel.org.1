Return-Path: <stable+bounces-45390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A82F8C8604
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 14:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E17281F11
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9274644E;
	Fri, 17 May 2024 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1jJ18P/+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39A745957;
	Fri, 17 May 2024 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947134; cv=none; b=Vm7593Dr95MVYMZybl9ZkffvMGzMY2ho0DewVVW0rTIj3cTmyEDLYvXK1hKKL/Ypbg96mJQ5uIIloOrsc/Gar6Fh493OO52V3Ybxd5MdAyMeFGzN4ImOojINmXGNlZprTni6SBWSEM+rBpTUIJfdi62Ki7CwZFgt77Eh22cK548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947134; c=relaxed/simple;
	bh=TrIrBnrsfTtk/wp08EkmHrIm2+D+y3bhLVnklZfaWyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X9RdZl0SJi8dVBdeIAvIj9ZhxJSX4u+uRZ/cqgQ/GHVWzfCTsdE+uGNmwH94uizOtcxra/utnjbJk8mFu5FYTXE0sOD/kbmmUG9TrzG8gcw7UHdA9ok24SLDiqG4jlJFPTWWr7w6BsOWYj25Wur5HF6Yvib1xl5+roktMoD3hQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1jJ18P/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C63C2BD10;
	Fri, 17 May 2024 11:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715947134;
	bh=TrIrBnrsfTtk/wp08EkmHrIm2+D+y3bhLVnklZfaWyg=;
	h=From:To:Cc:Subject:Date:From;
	b=1jJ18P/+kjnngX35a2BssR18ruH5xEJHnok9Bm4H/fQcGrHw9LNj/Js3vkP2gXdfR
	 CC3S2AxwvJfaesm/2IPRBVbE+IcHN+QkItL+nzMspS8JVP73+Fnt3vBZ1IzaR1vlDX
	 OZbcVScZVMHS6geduLZr6CXrMQ6Wf6pVtGERIj1c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.31
Date: Fri, 17 May 2024 13:58:38 +0200
Message-ID: <2024051739-scallop-varnish-f3b7@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.31 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml      |    2 
 Documentation/devicetree/bindings/net/mediatek,net.yaml               |   22 
 Makefile                                                              |    2 
 arch/arm/kernel/sleep.S                                               |    4 
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts                              |   30 
 arch/arm64/kvm/vgic/vgic-kvm-device.c                                 |   12 
 arch/arm64/net/bpf_jit_comp.c                                         |    6 
 arch/mips/include/asm/ptrace.h                                        |    2 
 arch/mips/kernel/asm-offsets.c                                        |    1 
 arch/mips/kernel/ptrace.c                                             |   15 
 arch/mips/kernel/scall32-o32.S                                        |   23 
 arch/mips/kernel/scall64-n32.S                                        |    3 
 arch/mips/kernel/scall64-n64.S                                        |    3 
 arch/mips/kernel/scall64-o32.S                                        |   33 
 arch/powerpc/crypto/chacha-p10-glue.c                                 |    8 
 arch/powerpc/include/asm/plpks.h                                      |    5 
 arch/powerpc/platforms/pseries/iommu.c                                |    8 
 arch/powerpc/platforms/pseries/plpks.c                                |   10 
 arch/riscv/net/bpf_jit_comp64.c                                       |    6 
 arch/s390/include/asm/dwarf.h                                         |    1 
 arch/s390/kernel/vdso64/vdso_user_wrapper.S                           |    2 
 arch/s390/mm/gmap.c                                                   |    2 
 arch/s390/mm/hugetlbpage.c                                            |    2 
 arch/x86/kernel/apic/apic.c                                           |   16 
 arch/xtensa/include/asm/processor.h                                   |    8 
 arch/xtensa/include/asm/ptrace.h                                      |    2 
 arch/xtensa/kernel/process.c                                          |    5 
 arch/xtensa/kernel/stacktrace.c                                       |    3 
 block/blk-iocost.c                                                    |   14 
 block/ioctl.c                                                         |    5 
 drivers/ata/sata_gemini.c                                             |    5 
 drivers/base/regmap/regmap.c                                          |   37 +
 drivers/bluetooth/btqca.c                                             |  206 +++++-
 drivers/bluetooth/btqca.h                                             |    8 
 drivers/bluetooth/hci_qca.c                                           |   13 
 drivers/clk/clk.c                                                     |   12 
 drivers/clk/qcom/clk-smd-rpm.c                                        |    1 
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c                                 |    2 
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c                                  |   19 
 drivers/clk/sunxi-ng/ccu_common.c                                     |   19 
 drivers/clk/sunxi-ng/ccu_common.h                                     |    3 
 drivers/dma/idxd/cdev.c                                               |   77 ++
 drivers/dma/idxd/idxd.h                                               |    3 
 drivers/dma/idxd/init.c                                               |    4 
 drivers/dma/idxd/registers.h                                          |    3 
 drivers/dma/idxd/sysfs.c                                              |   27 
 drivers/firewire/nosy.c                                               |    6 
 drivers/firewire/ohci.c                                               |   14 
 drivers/gpio/gpio-crystalcove.c                                       |    2 
 drivers/gpio/gpio-lpc32xx.c                                           |    1 
 drivers/gpio/gpio-wcove.c                                             |    2 
 drivers/gpio/gpiolib-cdev.c                                           |  181 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                               |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                            |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h                            |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                               |   52 -
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c                            |   15 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c                              |   16 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                              |   11 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                               |   17 
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c                      |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c                      |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c                       |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                     |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c             |   48 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                    |    1 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c      |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c                  |    2 
 drivers/gpu/drm/drm_connector.c                                       |    2 
 drivers/gpu/drm/i915/display/intel_audio.c                            |  113 ---
 drivers/gpu/drm/i915/display/intel_bios.c                             |   19 
 drivers/gpu/drm/i915/display/intel_vbt_defs.h                         |    5 
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c                           |    6 
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h                           |    2 
 drivers/gpu/drm/i915/gt/intel_workarounds.c                           |    4 
 drivers/gpu/drm/meson/meson_dw_hdmi.c                                 |   70 --
 drivers/gpu/drm/nouveau/nouveau_dp.c                                  |   13 
 drivers/gpu/drm/panel/Kconfig                                         |    2 
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c                          |   13 
 drivers/gpu/drm/qxl/qxl_release.c                                     |   50 -
 drivers/gpu/drm/radeon/pptable.h                                      |   10 
 drivers/gpu/drm/ttm/ttm_tt.c                                          |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                                    |    1 
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c                                 |    2 
 drivers/gpu/host1x/bus.c                                              |    8 
 drivers/hv/channel.c                                                  |   29 
 drivers/hv/connection.c                                               |   29 
 drivers/hwmon/corsair-cpro.c                                          |   45 -
 drivers/hwmon/pmbus/ucd9000.c                                         |    6 
 drivers/iio/accel/mxc4005.c                                           |   24 
 drivers/iio/imu/adis16475.c                                           |    4 
 drivers/iio/pressure/bmp280-spi.c                                     |    4 
 drivers/infiniband/hw/qib/qib_fs.c                                    |    1 
 drivers/iommu/mtk_iommu.c                                             |    1 
 drivers/iommu/mtk_iommu_v1.c                                          |    1 
 drivers/md/md.c                                                       |    1 
 drivers/misc/eeprom/at24.c                                            |   47 +
 drivers/misc/mei/hw-me-regs.h                                         |    2 
 drivers/misc/mei/pci-me.c                                             |    2 
 drivers/mtd/mtdcore.c                                                 |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                                      |   20 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                        |   32 
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                        |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c                    |    8 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                          |    6 
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c                       |    4 
 drivers/net/ethernet/chelsio/cxgb4/sge.c                              |    6 
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                           |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c               |   52 -
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h               |    5 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c                |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c             |   20 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h             |    2 
 drivers/net/ethernet/intel/e1000e/phy.c                               |    8 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c               |    4 
 drivers/net/ethernet/micrel/ks8851_common.c                           |   16 
 drivers/net/ethernet/qlogic/qede/qede_filter.c                        |   14 
 drivers/net/hyperv/netvsc.c                                           |    7 
 drivers/net/usb/qmi_wwan.c                                            |    1 
 drivers/net/vxlan/vxlan_core.c                                        |   49 +
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c                      |    7 
 drivers/net/wireless/intel/iwlwifi/queue/tx.c                         |    2 
 drivers/nvme/host/core.c                                              |    2 
 drivers/nvme/host/nvme.h                                              |    5 
 drivers/nvme/host/pci.c                                               |   14 
 drivers/nvmem/apple-efuses.c                                          |    1 
 drivers/nvmem/core.c                                                  |    8 
 drivers/nvmem/imx-ocotp-scu.c                                         |    1 
 drivers/nvmem/imx-ocotp.c                                             |    1 
 drivers/nvmem/meson-efuse.c                                           |    1 
 drivers/nvmem/meson-mx-efuse.c                                        |    1 
 drivers/nvmem/microchip-otpc.c                                        |    1 
 drivers/nvmem/mtk-efuse.c                                             |    1 
 drivers/nvmem/qcom-spmi-sdam.c                                        |    1 
 drivers/nvmem/qfprom.c                                                |    1 
 drivers/nvmem/rave-sp-eeprom.c                                        |    1 
 drivers/nvmem/rockchip-efuse.c                                        |    1 
 drivers/nvmem/sc27xx-efuse.c                                          |    1 
 drivers/nvmem/sec-qfprom.c                                            |    1 
 drivers/nvmem/sprd-efuse.c                                            |    1 
 drivers/nvmem/stm32-romem.c                                           |    1 
 drivers/nvmem/sunplus-ocotp.c                                         |    1 
 drivers/nvmem/sunxi_sid.c                                             |    1 
 drivers/nvmem/uniphier-efuse.c                                        |    1 
 drivers/nvmem/zynqmp_nvmem.c                                          |    1 
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c                            |   34 -
 drivers/pinctrl/core.c                                                |    8 
 drivers/pinctrl/devicetree.c                                          |   10 
 drivers/pinctrl/intel/pinctrl-baytrail.c                              |   74 +-
 drivers/pinctrl/intel/pinctrl-intel.h                                 |    4 
 drivers/pinctrl/mediatek/pinctrl-paris.c                              |   40 -
 drivers/pinctrl/meson/pinctrl-meson-a1.c                              |    6 
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c           |    1 
 drivers/power/supply/mt6360_charger.c                                 |    2 
 drivers/power/supply/rt9455_charger.c                                 |    2 
 drivers/regulator/core.c                                              |   27 
 drivers/regulator/mt6360-regulator.c                                  |   32 
 drivers/regulator/tps65132-regulator.c                                |    7 
 drivers/rtc/nvmem.c                                                   |    1 
 drivers/s390/cio/cio_inject.c                                         |    2 
 drivers/s390/net/qeth_core_main.c                                     |   61 -
 drivers/scsi/bnx2fc/bnx2fc_tgt.c                                      |    2 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                |   10 
 drivers/scsi/libsas/sas_expander.c                                    |    2 
 drivers/scsi/lpfc/lpfc.h                                              |    2 
 drivers/scsi/lpfc/lpfc_attr.c                                         |    4 
 drivers/scsi/lpfc/lpfc_bsg.c                                          |   20 
 drivers/scsi/lpfc/lpfc_debugfs.c                                      |   12 
 drivers/scsi/lpfc/lpfc_els.c                                          |   20 
 drivers/scsi/lpfc/lpfc_hbadisc.c                                      |    5 
 drivers/scsi/lpfc/lpfc_init.c                                         |    5 
 drivers/scsi/lpfc/lpfc_nvme.c                                         |    4 
 drivers/scsi/lpfc/lpfc_scsi.c                                         |   13 
 drivers/scsi/lpfc/lpfc_sli.c                                          |   34 -
 drivers/scsi/lpfc/lpfc_vport.c                                        |    8 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                      |    2 
 drivers/slimbus/qcom-ngd-ctrl.c                                       |    6 
 drivers/spi/spi-axi-spi-engine.c                                      |  227 +++---
 drivers/spi/spi-hisi-kunpeng.c                                        |    2 
 drivers/spi/spi-microchip-core-qspi.c                                 |    1 
 drivers/spi/spi.c                                                     |    1 
 drivers/target/target_core_configfs.c                                 |   12 
 drivers/ufs/core/ufs-mcq.c                                            |    2 
 drivers/ufs/core/ufshcd.c                                             |    9 
 drivers/uio/uio_hv_generic.c                                          |   12 
 drivers/usb/core/hub.c                                                |    5 
 drivers/usb/core/port.c                                               |    8 
 drivers/usb/dwc3/core.c                                               |   90 +-
 drivers/usb/dwc3/core.h                                               |    1 
 drivers/usb/dwc3/gadget.c                                             |    2 
 drivers/usb/dwc3/host.c                                               |   27 
 drivers/usb/gadget/composite.c                                        |    6 
 drivers/usb/gadget/function/f_fs.c                                    |    9 
 drivers/usb/gadget/function/uvc_configfs.c                            |    4 
 drivers/usb/host/ohci-hcd.c                                           |    8 
 drivers/usb/host/xhci-plat.h                                          |    4 
 drivers/usb/host/xhci-rzv2m.c                                         |    1 
 drivers/usb/typec/tcpm/tcpm.c                                         |   36 -
 drivers/usb/typec/ucsi/ucsi.c                                         |   12 
 drivers/vfio/pci/vfio_pci.c                                           |    2 
 drivers/w1/slaves/w1_ds250x.c                                         |    1 
 fs/9p/fid.h                                                           |    3 
 fs/9p/vfs_file.c                                                      |    2 
 fs/9p/vfs_inode.c                                                     |    5 
 fs/9p/vfs_super.c                                                     |    1 
 fs/btrfs/extent_io.c                                                  |   14 
 fs/btrfs/inode.c                                                      |    2 
 fs/btrfs/ordered-data.c                                               |    1 
 fs/btrfs/send.c                                                       |    4 
 fs/btrfs/transaction.c                                                |    2 
 fs/btrfs/volumes.c                                                    |   18 
 fs/gfs2/bmap.c                                                        |    5 
 fs/nfs/client.c                                                       |    5 
 fs/nfs/inode.c                                                        |   13 
 fs/nfs/internal.h                                                     |    2 
 fs/nfs/netns.h                                                        |    2 
 fs/smb/client/cifsglob.h                                              |    1 
 fs/smb/client/connect.c                                               |    8 
 fs/smb/client/fs_context.c                                            |   21 
 fs/smb/client/fs_context.h                                            |    2 
 fs/smb/client/misc.c                                                  |    1 
 fs/smb/client/smb2pdu.c                                               |   11 
 fs/smb/server/oplock.c                                                |   35 -
 fs/smb/server/transport_tcp.c                                         |    4 
 fs/tracefs/event_inode.c                                              |   45 -
 fs/tracefs/inode.c                                                    |   92 ++
 fs/tracefs/internal.h                                                 |    7 
 fs/userfaultfd.c                                                      |    4 
 fs/vboxsf/file.c                                                      |    1 
 include/linux/compiler_types.h                                        |   11 
 include/linux/dma-fence.h                                             |    7 
 include/linux/gfp_types.h                                             |    2 
 include/linux/hyperv.h                                                |    1 
 include/linux/nvmem-provider.h                                        |    2 
 include/linux/pci_ids.h                                               |    2 
 include/linux/regmap.h                                                |    8 
 include/linux/regulator/consumer.h                                    |    4 
 include/linux/skbuff.h                                                |   15 
 include/linux/skmsg.h                                                 |    2 
 include/linux/slab.h                                                  |    2 
 include/linux/sunrpc/clnt.h                                           |    1 
 include/net/gro.h                                                     |    9 
 include/net/xfrm.h                                                    |    3 
 include/sound/emu10k1.h                                               |    3 
 include/sound/sof.h                                                   |    7 
 include/trace/events/rxrpc.h                                          |    2 
 include/uapi/linux/kfd_ioctl.h                                        |   17 
 include/uapi/scsi/scsi_bsg_mpi3mr.h                                   |    2 
 kernel/bpf/bloom_filter.c                                             |   13 
 kernel/bpf/verifier.c                                                 |    3 
 kernel/dma/swiotlb.c                                                  |    1 
 kernel/workqueue.c                                                    |    8 
 lib/Kconfig.debug                                                     |    5 
 lib/dynamic_debug.c                                                   |    6 
 lib/maple_tree.c                                                      |   16 
 lib/scatterlist.c                                                     |    2 
 mm/hugetlb.c                                                          |    4 
 mm/readahead.c                                                        |    4 
 net/8021q/vlan_core.c                                                 |    2 
 net/bluetooth/hci_core.c                                              |    3 
 net/bluetooth/hci_event.c                                             |    2 
 net/bluetooth/l2cap_core.c                                            |    3 
 net/bluetooth/msft.c                                                  |    2 
 net/bluetooth/msft.h                                                  |    4 
 net/bluetooth/sco.c                                                   |    4 
 net/bridge/br_forward.c                                               |    9 
 net/bridge/br_netlink.c                                               |    3 
 net/core/filter.c                                                     |   42 -
 net/core/gro.c                                                        |    1 
 net/core/link_watch.c                                                 |    4 
 net/core/net-sysfs.c                                                  |    4 
 net/core/net_namespace.c                                              |   13 
 net/core/rtnetlink.c                                                  |    6 
 net/core/skbuff.c                                                     |   27 
 net/core/skmsg.c                                                      |    5 
 net/core/sock.c                                                       |    4 
 net/hsr/hsr_device.c                                                  |   31 
 net/ipv4/af_inet.c                                                    |    1 
 net/ipv4/ip_output.c                                                  |    2 
 net/ipv4/raw.c                                                        |    3 
 net/ipv4/tcp.c                                                        |    4 
 net/ipv4/tcp_input.c                                                  |    2 
 net/ipv4/tcp_ipv4.c                                                   |    8 
 net/ipv4/tcp_output.c                                                 |    4 
 net/ipv4/udp.c                                                        |    3 
 net/ipv4/udp_offload.c                                                |   15 
 net/ipv4/xfrm4_input.c                                                |    6 
 net/ipv6/addrconf.c                                                   |   11 
 net/ipv6/fib6_rules.c                                                 |    6 
 net/ipv6/ip6_input.c                                                  |    4 
 net/ipv6/ip6_offload.c                                                |   52 +
 net/ipv6/ip6_output.c                                                 |    4 
 net/ipv6/udp.c                                                        |    3 
 net/ipv6/udp_offload.c                                                |    3 
 net/ipv6/xfrm6_input.c                                                |    6 
 net/l2tp/l2tp_eth.c                                                   |    3 
 net/mac80211/ieee80211_i.h                                            |    4 
 net/mac80211/mlme.c                                                   |    5 
 net/mptcp/ctrl.c                                                      |   39 +
 net/mptcp/protocol.c                                                  |    3 
 net/nfc/nci/core.c                                                    |    1 
 net/nsh/nsh.c                                                         |   14 
 net/phonet/pn_netlink.c                                               |    2 
 net/rxrpc/ar-internal.h                                               |    2 
 net/rxrpc/call_object.c                                               |    7 
 net/rxrpc/conn_event.c                                                |   16 
 net/rxrpc/conn_object.c                                               |    9 
 net/rxrpc/input.c                                                     |   71 +-
 net/rxrpc/output.c                                                    |   14 
 net/rxrpc/protocol.h                                                  |    6 
 net/smc/smc_ib.c                                                      |   19 
 net/sunrpc/clnt.c                                                     |    5 
 net/sunrpc/xprtsock.c                                                 |    1 
 net/tipc/msg.c                                                        |    8 
 net/wireless/nl80211.c                                                |    2 
 net/wireless/trace.h                                                  |    2 
 net/xfrm/xfrm_input.c                                                 |    8 
 rust/kernel/lib.rs                                                    |    2 
 rust/macros/module.rs                                                 |  185 +++--
 scripts/Makefile.modfinal                                             |    2 
 security/keys/key.c                                                   |    3 
 sound/hda/intel-sdw-acpi.c                                            |    2 
 sound/pci/emu10k1/emu10k1.c                                           |    3 
 sound/pci/emu10k1/emu10k1_main.c                                      |  139 ++--
 sound/pci/hda/patch_realtek.c                                         |    1 
 sound/soc/codecs/wsa881x.c                                            |    1 
 sound/soc/intel/avs/topology.c                                        |    2 
 sound/soc/meson/Kconfig                                               |    1 
 sound/soc/meson/axg-card.c                                            |    1 
 sound/soc/meson/axg-fifo.c                                            |   52 -
 sound/soc/meson/axg-fifo.h                                            |   12 
 sound/soc/meson/axg-frddr.c                                           |    5 
 sound/soc/meson/axg-tdm-interface.c                                   |   34 -
 sound/soc/meson/axg-toddr.c                                           |   22 
 sound/soc/sof/intel/hda-dsp.c                                         |   20 
 sound/soc/sof/intel/pci-lnl.c                                         |    3 
 sound/soc/tegra/tegra186_dspk.c                                       |    7 
 sound/soc/ti/davinci-mcasp.c                                          |   12 
 sound/usb/line6/driver.c                                              |    6 
 tools/include/linux/kernel.h                                          |    1 
 tools/include/linux/mm.h                                              |    5 
 tools/include/linux/panic.h                                           |   19 
 tools/power/x86/turbostat/turbostat.8                                 |    2 
 tools/power/x86/turbostat/turbostat.c                                 |   45 +
 tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c             |    6 
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c                  |   52 -
 tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc |    2 
 tools/testing/selftests/mm/Makefile                                   |    6 
 tools/testing/selftests/net/test_bridge_neigh_suppress.sh             |  333 ++++------
 tools/testing/selftests/timers/valid-adjtimex.c                       |   73 +-
 350 files changed, 3141 insertions(+), 1836 deletions(-)

Adam Goldman (1):
      firewire: ohci: mask bus reset interrupts between ISR and bottom half

Adam Skladowski (1):
      clk: qcom: smd-rpm: Restore msm8976 num_clk

Al Viro (1):
      qibfs: fix dentry leak

Alan Stern (2):
      usb: Fix regression caused by invalid ep0 maxpacket in virtual SuperSpeed device
      USB: core: Fix access violation during port device removal

Aleksa Savic (3):
      hwmon: (corsair-cpro) Use a separate buffer for sending commands
      hwmon: (corsair-cpro) Use complete_all() instead of complete() in ccp_raw_event()
      hwmon: (corsair-cpro) Protect ccp->wait_input_report with a spinlock

Alex Deucher (2):
      drm/radeon: silence UBSAN warning (v3)
      drm/amdkfd: don't allow mapping the MMIO HDP page with large pages

Alex Hung (1):
      drm/amd/display: Skip on writeback when it's not applicable

Alexander Potapenko (1):
      kmsan: compiler_types: declare __no_sanitize_or_inline

Alexander Usyskin (1):
      mei: me: add lunar lake point M DID

Alexandra Winter (1):
      s390/qeth: Fix kernel panic after setting hsuid

Amadeusz Sławiński (1):
      ASoC: Intel: avs: Set name of control as in topology

Aman Dhoot (1):
      ALSA: hda/realtek: Fix mute led of HP Laptop 15-da3001TU

Amit Sunil Dhamne (1):
      usb: typec: tcpm: unregister existing source caps before re-registration

Anand Jain (1):
      btrfs: return accurate error code on open failure in open_fs_devices()

Andi Shyti (1):
      drm/i915/gt: Automate CCS Mode setting during engine resets

Andrei Matei (1):
      bpf: Check bloom filter map value size

Andrew Price (1):
      gfs2: Fix invalid metadata access in punch_hole

Andrii Nakryiko (1):
      bpf, kconfig: Fix DEBUG_INFO_BTF_MODULES Kconfig definition

André Apitzsch (1):
      regulator: tps65132: Add of_match table

Andy Shevchenko (5):
      drm/panel: ili9341: Correct use of device property APIs
      drm/panel: ili9341: Respect deferred probe
      drm/panel: ili9341: Use predefined error codes
      gpio: wcove: Use -ENOTSUPP consistently
      gpio: crystalcove: Use -ENOTSUPP consistently

AngeloGioacchino Del Regno (2):
      power: supply: mt6360_charger: Fix of_match for usb-otg-vbus regulator
      regulator: mt6360: De-capitalize devicetree regulator subnodes

Anton Protopopov (1):
      bpf: Fix a verifier verbose message

Arjan van de Ven (2):
      VFIO: Add the SPR_DSA and SPR_IAX devices to the denylist
      dmaengine: idxd: add a new security check to deal with a hardware erratum

Arnd Bergmann (1):
      power: rt9455: hide unused rt9455_boost_voltage_values

Asbjørn Sloth Tønnesen (4):
      net: qede: sanitize 'rc' in qede_add_tc_flower_fltr()
      net: qede: use return from qede_parse_flow_attr() for flower
      net: qede: use return from qede_parse_flow_attr() for flow_spec
      net: qede: use return from qede_parse_actions()

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Check for port partner validity before consuming it

Benjamin Berg (1):
      wifi: iwlwifi: mvm: guard against invalid STA ID on removal

Benno Lossin (1):
      rust: macros: fix soundness issue in `module!` macro

Billy Tsai (1):
      pinctrl: pinctrl-aspeed-g6: Fix register offset for pinconf of GPIOR-T

Boris Burkov (2):
      btrfs: make btrfs_clear_delalloc_extent() free delalloc reserve
      btrfs: always clear PERTRANS metadata during commit

Borislav Petkov (AMD) (1):
      kbuild: Disable KCSAN for autogenerated *.mod.c intermediaries

Boy.Wu (1):
      ARM: 9381/1: kasan: clear stale stack poison

Bui Quang Minh (3):
      bna: ensure the copied buf is NUL terminated
      octeontx2-af: avoid off-by-one read from userspace
      s390/cio: Ensure the copied buf is NUL terminated

Bumyong Lee (1):
      dmaengine: pl330: issue_pending waits until WFP state

Chaitanya Kumar Borah (1):
      drm/i915/audio: Fix audio time stamp programming for DP

Chen Ni (1):
      ata: sata_gemini: Check clk_enable() result

Chen-Yu Tsai (2):
      pinctrl: mediatek: paris: Fix PIN_CONFIG_INPUT_SCHMITT_ENABLE readback
      pinctrl: mediatek: paris: Rework support for PIN_CONFIG_{INPUT,OUTPUT}_ENABLE

Chris Wulff (1):
      usb: gadget: f_fs: Fix a race condition when processing setup packets.

Christian A. Ehrhardt (2):
      usb: typec: ucsi: Check for notifications after init
      usb: typec: ucsi: Fix connector check on init

Christian König (1):
      drm/amdgpu: once more fix the call oder in amdgpu_ttm_move() v2

Christian Marangi (1):
      mtd: limit OTP NVMEM cell parse to non-NAND devices

Claudio Imbrenda (2):
      s390/mm: Fix storage key clearing for guest huge pages
      s390/mm: Fix clearing storage keys for huge pages

Conor Dooley (1):
      spi: microchip-core-qspi: fix setting spi bus clock rate

Dan Carpenter (2):
      pinctrl: core: delete incorrect free in pinctrl_enable()
      mm/slab: make __free(kfree) accept error pointers

Daniel Golle (1):
      dt-bindings: net: mediatek: remove wrongly added clocks and SerDes

Daniel Okazaki (1):
      eeprom: at24: fix memory corruption race condition

Dave Airlie (1):
      Revert "drm/nouveau/firmware: Fix SG_DEBUG error with nvkm_firmware_ctor()"

David Bauer (1):
      net l2tp: drop flow hash on forward

David Howells (4):
      Fix a potential infinite loop in extract_user_to_sg()
      rxrpc: Fix the names of the fields in the ACK trailer struct
      rxrpc: Fix congestion control algorithm
      rxrpc: Only transmit one ACK per jumbo packet received

David Lechner (5):
      spi: axi-spi-engine: simplify driver data allocation
      spi: axi-spi-engine: use devm_spi_alloc_host()
      spi: axi-spi-engine: move msg state to new struct
      spi: axi-spi-engine: use common AXI macros
      spi: axi-spi-engine: fix version format string

Devyn Liu (1):
      spi: hisi-kunpeng: Delete the dump interface of data registers in debugfs

Dmitry Antipov (1):
      btrfs: fix kvcalloc() arguments order in btrfs_ioctl_send()

Dominique Martinet (1):
      btrfs: add missing mutex_unlock in btrfs_relocate_sys_chunks()

Doug Berger (3):
      net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
      net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
      net: bcmgenet: synchronize UMAC_CMD access

Doug Smythies (1):
      tools/power turbostat: Fix added raw MSR output

Douglas Anderson (1):
      drm/connector: Add \n to message about demoting connector force-probes

Duoming Zhou (2):
      Bluetooth: Fix use-after-free bugs caused by sco_sock_timeout
      Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout

Eric Dumazet (6):
      tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets
      phonet: fix rtm_phonet_notify() skb allocation
      ipv6: fib6_rules: avoid possible NULL dereference in fib6_rule_action()
      net-sysfs: convert dev->operstate reads to lockless ones
      ipv6: annotate data-races around cnf.disable_ipv6
      ipv6: prevent NULL dereference in ip6_output()

Felix Fietkau (3):
      net: bridge: fix multicast-to-unicast with fraglist GSO
      net: core: reject skb_copy(_expand) for fraglist GSO skbs
      net: bridge: fix corrupted ethernet header on multicast-to-unicast

Frank Oltmanns (2):
      clk: sunxi-ng: common: Support minimum and maximum rate
      clk: sunxi-ng: a64: Set minimum and maximum rate for PLL-MIPI

Gabe Teeger (1):
      drm/amd/display: Atom Integrated System Info v2_2 for DCN35

Gaurav Batra (1):
      powerpc/pseries/iommu: LPAR panics during boot up with a frozen PE

George Shen (1):
      drm/amd/display: Handle Y carry-over in VCP X.Y calculation

Greg Kroah-Hartman (1):
      Linux 6.6.31

Gregory Detal (1):
      mptcp: only allow set existing scheduler for net.mptcp.scheduler

Guenter Roeck (1):
      usb: ohci: Prevent missed ohci interrupts

Guillaume Nault (3):
      vxlan: Fix racy device stats updates.
      vxlan: Add missing VNI filter counter update in arp_reduce().
      vxlan: Pull inner IP header in vxlan_rcv().

Hangbin Liu (1):
      selftests/net: convert test_bridge_neigh_suppress.sh to run it in unique namespace

Hans de Goede (2):
      pinctrl: baytrail: Fix selecting gpio pinctrl state
      iio: accel: mxc4005: Interrupt handling fixes

Heiner Kallweit (1):
      eeprom: at24: Probe for DDR3 thermal sensor in the SPD case

Hersen Wu (1):
      drm/amd/display: Fix incorrect DSC instance for MST

Ian Forbes (1):
      drm/vmwgfx: Fix Legacy Display Unit

Ido Schimmel (1):
      selftests: test_bridge_neigh_suppress.sh: Fix failures due to duplicate MAC

Igor Artemiev (1):
      wifi: cfg80211: fix rdev_dump_mpp() arguments order

Ivan Avdeev (1):
      usb: gadget: uvc: use correct buffer size when parsing configfs lists

Jan Dakinevich (1):
      pinctrl/meson: fix typo in PDM's pin name

Jason Xing (1):
      bpf, skmsg: Fix NULL pointer dereference in sk_psock_skb_ingress_enqueue

Javier Carrasco (1):
      dt-bindings: iio: health: maxim,max30102: fix compatible check

Jeff Johnson (1):
      wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc

Jeff Layton (2):
      vboxsf: explicitly deny setlease attempts
      9p: explicitly deny setlease attempts

Jeffrey Altman (1):
      rxrpc: Clients must accept conn from any address

Jens Remus (1):
      s390/vdso: Add CFI for RA register to asm macro vdso_func

Jernej Skrabec (1):
      clk: sunxi-ng: h6: Reparent CPUX during PLL CPUX rate change

Jerome Brunet (7):
      ASoC: meson: axg-fifo: use FIELD helpers
      ASoC: meson: axg-fifo: use threaded irq to check periods
      ASoC: meson: axg-card: make links nonatomic
      ASoC: meson: axg-tdm-interface: manage formatters in trigger
      ASoC: meson: cards: select SND_DYNAMIC_MINORS
      drm/meson: dw-hdmi: power up phy on device init
      drm/meson: dw-hdmi: add bandgap setting for g12

Jian Shen (1):
      net: hns3: direct return when receive a unknown mailbox message

Jiaxun Yang (1):
      MIPS: scall: Save thread_info.syscall unconditionally on entry

Jim Cromie (1):
      dyndbg: fix old BUG_ON in >control parser

Joakim Sindholt (4):
      fs/9p: only translate RWX permissions for plain 9P2000
      fs/9p: translate O_TRUNC into OTRUNC
      fs/9p: fix the cache always being enabled on files with qid flags
      fs/9p: drop inodes immediately on non-.L too

Joao Paulo Goncalves (1):
      ASoC: ti: davinci-mcasp: Fix race condition during probe

Johan Hovold (9):
      regulator: core: fix debugfs creation regression
      Bluetooth: qca: fix invalid device address check
      Bluetooth: qca: fix wcn3991 device address check
      Bluetooth: qca: add missing firmware sanity checks
      Bluetooth: qca: fix NVM configuration parsing
      Bluetooth: qca: generalise device address check
      Bluetooth: qca: fix info leak when fetching board id
      Bluetooth: qca: fix info leak when fetching fw build id
      Bluetooth: qca: fix firmware check error path

Johannes Berg (3):
      wifi: nl80211: don't free NULL coalescing rule
      wifi: mac80211: fix prep_connection error path
      wifi: iwlwifi: read txq->read_ptr under lock

John Stultz (1):
      selftests: timers: Fix valid-adjtimex signed left-shift undefined behavior

Jonathan Kim (1):
      drm/amdkfd: range check cp bad op exception interrupts

Josef Bacik (3):
      sunrpc: add a struct rpc_stats arg to rpc_create_args
      nfs: expose /proc/net/sunrpc/nfs in net namespaces
      nfs: make the rpc_stat per net namespace

Justin Ernst (1):
      tools/power/turbostat: Fix uncore frequency file string

Justin Tee (6):
      scsi: lpfc: Move NPIV's transport unregistration to after resource clean up
      scsi: lpfc: Remove IRQF_ONESHOT flag from threaded IRQ handling
      scsi: lpfc: Update lpfc_ramp_down_queue_handler() logic
      scsi: lpfc: Replace hbalock with ndlp lock in lpfc_nvme_unregister_port()
      scsi: lpfc: Release hbalock before calling lpfc_worker_wake_up()
      scsi: lpfc: Use a dedicated lock for ras_fwlog state

Karthikeyan Ramasubramanian (1):
      drm/i915/bios: Fix parsing backlight BDB data

Kefeng Wang (1):
      mm: use memalloc_nofs_save() in page_cache_ra_order()

Kent Gibson (2):
      gpiolib: cdev: relocate debounce_period_us from struct gpio_desc
      gpiolib: cdev: fix uninitialised kfifo

Krzysztof Kozlowski (2):
      iommu: mtk: fix module autoloading
      gpio: lpc32xx: fix module autoloading

Kuniyuki Iwashima (3):
      nfs: Handle error of rpc_proc_register() in nfs_net_init().
      nsh: Restore skb->{protocol,data,mac_header} for outer header in nsh_gso_segment().
      tcp: Use refcount_inc_not_zero() in tcp_twsk_unique().

Lakshmi Yadlapati (1):
      hwmon: (pmbus/ucd9000) Increase delay from 250 to 500us

Len Brown (1):
      tools/power turbostat: Fix warning upon failed /dev/cpu_dma_latency read

Li Nan (3):
      block: fix overflow in blk_ioctl_discard()
      blk-iocost: do not WARN if iocg was already offlined
      md: fix kmemleak of rdev->serial

Li Zetao (1):
      spi: spi-axi-spi-engine: Use helper function devm_clk_get_enabled()

Liam R. Howlett (1):
      maple_tree: fix mas_empty_area_rev() null pointer dereference

Lijo Lazar (2):
      drm/amdgpu: Refine IB schedule error logging
      drm/amdgpu: Fix VCN allocation in CPX partition

Linus Torvalds (1):
      Reapply "drm/qxl: simplify qxl_fence_wait"

Lukasz Majewski (1):
      hsr: Simplify code for announcing HSR nodes timer setup

Lyude Paul (2):
      drm/nouveau/dp: Don't probe eDP ports twice harder
      drm/nouveau/firmware: Fix SG_DEBUG error with nvkm_firmware_ctor()

Mans Rullgard (1):
      spi: fix null pointer dereference within spi_sync

Marc Zyngier (1):
      KVM: arm64: vgic-v2: Use cpuid from userspace as vcpu_id

Marek Behún (1):
      net: dsa: mv88e6xxx: Fix number of databases for 88E6141 / 88E6341

Marek Vasut (1):
      net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs

Mario Limonciello (1):
      dm/amd/pm: Fix problems with reboot/shutdown for some SMU 13.0.4/13.0.11 users

Mark Rutland (1):
      selftests/ftrace: Fix event filter target_func selection

Matti Vaittinen (2):
      regulator: change stubbed devm_regulator_get_enable to return Ok
      regulator: change devm_regulator_get_enable_optional() stub to return Ok

Maurizio Lombardi (1):
      scsi: target: Fix SELinux error when systemd-modules loads the target module

Max Filippov (1):
      xtensa: fix MAKE_PC_FROM_RA second argument

Miaohe Lin (1):
      mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when dissolve_free_hugetlb_folio()

Michael Ellerman (2):
      powerpc/crypto/chacha-p10: Fix failure on non Power10
      selftests/mm: fix powerpc ARCH check

Michael Kelley (1):
      Drivers: hv: vmbus: Don't free ring buffers that couldn't be re-encrypted

Michel Dänzer (1):
      drm/amdgpu: Fix comparison in amdgpu_res_cpu_visible

Mukul Joshi (1):
      drm/amdkfd: Check cgroup when returning DMABuf info

Namjae Jeon (3):
      ksmbd: off ipv6only for both ipv4/ipv6 binding
      ksmbd: avoid to send duplicate lease break notifications
      ksmbd: do not grant v2 lease if parent lease key and epoch are not set

Nayna Jain (1):
      powerpc/pseries: make max polling consistent for longer H_CALLs

Nikhil Rao (1):
      dmaengine: idxd: add a write() method for applications to submit work

Olga Kornievskaia (1):
      SUNRPC: add a missing rpc_stat for TCP TLS

Oliver Upton (1):
      KVM: arm64: vgic-v2: Check for non-NULL vCPU in vgic_v2_parse_attr()

Oswald Buddenhagen (4):
      ALSA: emu10k1: fix E-MU card dock presence monitoring
      ALSA: emu10k1: factor out snd_emu1010_load_dock_firmware()
      ALSA: emu10k1: move the whole GPIO event handling to the workqueue
      ALSA: emu10k1: fix E-MU dock initialization

Paolo Abeni (2):
      mptcp: ensure snd_nxt is properly initialized on connect
      tipc: fix UAF in error path

Patryk Wlazlyn (1):
      tools/power turbostat: Print ucode revision only if valid

Paul Davey (1):
      xfrm: Preserve vlan tags for transport mode software GRO

Pei Xiao (1):
      Revert "selftests/bpf: Add netkit to tc_redirect selftest"

Peiyang Wang (4):
      net: hns3: using user configure after hardware reset
      net: hns3: change type of numa_node_mask as nodemask_t
      net: hns3: release PTP resources if pf initialization failed
      net: hns3: use appropriate barrier function after setting a bit value

Peng Liu (1):
      tools/power turbostat: Fix Bzy_MHz documentation typo

Peter Korsgaard (1):
      usb: gadget: composite: fix OS descriptors w_value logic

Peter Ujfalusi (2):
      ASoC: SOF: Introduce generic names for IPC types
      ASoC: SOF: Intel: hda-dsp: Skip IMR boot on ACE platforms in case of S3 suspend

Peter Wang (2):
      scsi: ufs: core: WLUN suspend dev/link state error recovery
      scsi: ufs: core: Fix MCQ mode dev command timeout

Peter Xu (1):
      mm/userfaultfd: reset ptes when close() for wr-protected ones

Phil Elwell (1):
      net: bcmgenet: Reset RBUF on first open

Pierre-Louis Bossart (2):
      ASoC: SOF: Intel: add default firmware library path for LNL
      ALSA: hda: intel-sdw-acpi: fix usage of device_get_named_child_node()

Qu Wenruo (2):
      btrfs: set correct ram_bytes when splitting ordered extent
      btrfs: do not wait for short bulk allocation

RD Babiera (1):
      usb: typec: tcpm: clear pd_event queue in PORT_RESET

Rafał Miłecki (1):
      nvmem: add explicit config option to read old syntax fixed OF cells

Ramona Gradinariu (1):
      iio:imu: adis16475: Fix sync mode setting

Richard Fitzgerald (1):
      regmap: Add regmap_read_bypassed()

Richard Gobert (3):
      net: gro: parse ipv6 ext headers without frag0 invalidation
      net: gro: fix udp bad offset in socket lookup by adding {inner_}network_offset to napi_gro_cb
      net: gro: add flush check in udp_gro_receive_segment

Rick Edgecombe (4):
      Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails
      Drivers: hv: vmbus: Track decrypted status in vmbus_gpadl
      hv_netvsc: Don't free decrypted memory
      uio_hv_generic: Don't free decrypted memory

Rik van Riel (1):
      blk-iocost: avoid out of bounds shift

Roded Zats (1):
      rtnetlink: Correct nested IFLA_VF_VLAN_LIST attribute validation

Rohit Ner (1):
      scsi: ufs: core: Fix MCQ MAC configuration

Sameer Pujar (1):
      ASoC: tegra: Fix DSPK 16-bit playback

Saurav Kashyap (1):
      scsi: bnx2fc: Remove spin_lock_bh while releasing resources after upload

Sean Anderson (1):
      nvme-pci: Add quirk for broken MSIs

Sebastian Andrzej Siewior (1):
      cxgb4: Properly lock TX queue for the selftest.

Shashank Sharma (1):
      drm/amdgpu: fix doorbell regression

Shigeru Yoshida (2):
      ipv4: Fix uninit-value access in __ip_make_skb()
      ipv6: Fix potential uninit-value access in __ip6_make_skb()

Shin'ichiro Kawasaki (1):
      scsi: mpi3mr: Avoid memcpy field-spanning write WARNING

Silvio Gissi (1):
      keys: Fix overwrite of key expiration on instantiation

Srinivas Kandagatla (1):
      ASoC: codecs: wsa881x: set clk_stop_mode1 flag

Srinivas Pandruvada (1):
      platform/x86: ISST: Add Granite Rapids-D to HPM CPU list

Steffen Bätz (1):
      net: dsa: mv88e6xxx: add phylink_get_caps for the mv88e6320/21 family

Stephen Boyd (1):
      clk: Don't hold prepare_lock when calling kref_put()

Steve French (1):
      smb3: fix broken reconnect when password changing on the server by allowing password rotation

Steven Rostedt (Google) (3):
      tracefs: Reset permissions on remount if permissions are options
      tracefs: Still use mount point as default permissions for instances
      eventfs: Do not treat events directory different than other directories

Sungwoo Kim (2):
      Bluetooth: msft: fix slab-use-after-free in msft_do_close()
      Bluetooth: HCI: Fix potential null-ptr-deref

Sven Schnelle (1):
      workqueue: Fix selection of wake_cpu in kick_pool()

Takashi Iwai (1):
      ALSA: line6: Zero-initialize message buffers

Takashi Sakamoto (1):
      firewire: ohci: fulfill timestamp for some local asynchronous transaction

Tao Zhou (1):
      drm/amdgpu: implement IRQ_STATE_ENABLE for SDMA v4.4.2

Tetsuo Handa (1):
      nfc: nci: Fix kcov check in nci_rx_work()

Thadeu Lima de Souza Cascardo (1):
      net: fix out-of-bounds access in ops_init

Thanassis Avgerinos (1):
      firewire: nosy: ensure user_length is taken into account when fetching packet contents

Thierry Reding (1):
      gpu: host1x: Do not setup DMA for virtual devices

Thinh Nguyen (2):
      usb: xhci-plat: Don't include xhci.h
      usb: dwc3: core: Prevent phy suspend during init

Thomas Bertschinger (1):
      rust: module: place generated init_module() function in .init.text

Thomas Gleixner (1):
      x86/apic: Don't access the APIC when disabling x2APIC

Tim Jiang (1):
      Bluetooth: qca: add support for QCA2066

Toke Høiland-Jørgensen (1):
      xdp: use flags field to disambiguate broadcast redirect

Vanillan Wang (1):
      net:usb:qmi_wwan: support Rolling modules

Vasileios Amoiridis (1):
      iio: pressure: Fixes BME280 SPI driver data

Viken Dadhaniya (1):
      slimbus: qcom-ngd-ctrl: Add timeout for wait operation

Vinod Koul (1):
      dmaengine: Revert "dmaengine: pl330: issue_pending waits until WFP state"

Vitaly Lifshits (1):
      e1000e: change usleep_range to udelay in PHY mdic access

Volodymyr Babchuk (1):
      arm64: dts: qcom: sa8155p-adp: fix SDHC2 CD pin configuration

Wedson Almeida Filho (1):
      rust: kernel: require `Send` for `Module` implementations

Wei Yang (3):
      memblock tests: fix undefined reference to `early_pfn_to_nid'
      memblock tests: fix undefined reference to `panic'
      memblock tests: fix undefined reference to `BIT'

Wen Gu (1):
      net/smc: fix neighbour and rtable leak in smc_ib_find_route()

Wesley Cheng (1):
      usb: gadget: f_fs: Fix race between aio_cancel() and AIO request complete

Will Deacon (1):
      swiotlb: initialise restricted pool list_head when SWIOTLB_DYNAMIC=y

Wyes Karny (1):
      tools/power turbostat: Increase the limit for fd opened

Xiang Chen (1):
      scsi: hisi_sas: Handle the NCQ error returned by D2H frame

Xin Long (1):
      tipc: fix a possible memleak in tipc_buf_append

Xu Kuohai (2):
      bpf, arm64: Fix incorrect runtime stats
      riscv, bpf: Fix incorrect runtime stats

Yi Zhang (1):
      nvme: fix warn output about shared namespaces without CONFIG_NVME_MULTIPATH

Yihang Li (1):
      scsi: libsas: Align SMP request allocation to ARCH_DMA_MINALIGN

Yonglong Liu (2):
      net: hns3: fix port vlan filter not disabled issue
      net: hns3: fix kernel crash when devlink reload during initialization

Zack Rusin (2):
      drm/ttm: Print the memory decryption status just once
      drm/vmwgfx: Fix invalid reads in fence signaled events

Zeng Heng (1):
      pinctrl: devicetree: fix refcount leak in pinctrl_dt_to_map()

Zhigang Luo (1):
      amd/amdkfd: sync all devices to wait all processes being evicted

Zhongqiu Han (1):
      gpiolib: cdev: Fix use after free in lineinfo_changed_notify

linke li (1):
      net: mark racy access on sk->sk_rcvbuf


