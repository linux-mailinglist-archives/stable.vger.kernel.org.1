Return-Path: <stable+bounces-249104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPuHFC3hCWo6twQAu9opvQ
	(envelope-from <stable+bounces-249104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:39:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A14562076
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 170333003999
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0903B774F;
	Sun, 17 May 2026 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lcukXlST"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99CA32B99E;
	Sun, 17 May 2026 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032362; cv=none; b=HP6nl56hhb1zkRZZ4fmKd5TuXkLjVCSiVSOZiWCpw0NbZ74CcTd85uanH6f57bJ96MG0vruRSROjVN6iOb+bfLZ4zmwU4X/sHPVs77gskoMDocwAbdIfidNwt6LHr/QjnoqwKyz6djvo39XwaQA/B3Nu9Mo0yVTTuS/NDtppYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032362; c=relaxed/simple;
	bh=pGh6ZJxWmLkBk1GT5qHjY9qc+eUBqfR+m1e21KwhEl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Np54ODbJThQgW9CGh+0HYcLetqcAriRJ9aSYdZEj+Dl0yv5J46Q+lKE1yUGtOUDlcjt/BY6nYyF6zhTnc7bwHkXdY0bPaQ7I83Nf5+MOLLi/VhxLPyeEg8+paZbs36C9l+VBj/7Rzx+kG2IS068Zi+mCbkXlKUS/nFOYbKA48UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lcukXlST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4D8C2BCB0;
	Sun, 17 May 2026 15:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779032362;
	bh=pGh6ZJxWmLkBk1GT5qHjY9qc+eUBqfR+m1e21KwhEl8=;
	h=From:To:Cc:Subject:Date:From;
	b=lcukXlSTqT5usFQojAnWCfTak5rg6AEq43dHFRT60AioYKCzlJ98Uk0umXYVpqC8i
	 xczVfI3AsgBKlyA8nJ7qMKhc0GMpYTTlyKMXlSwmDZ37drA7zGyYBRp8thMVrnNWjK
	 46wFSklnu88BVUcFk3yR1GiCdSPZmCBKb23S+1+U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.140
Date: Sun, 17 May 2026 17:39:23 +0200
Message-ID: <2026051724-refinish-random-89f1@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D7A14562076
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249104-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

I'm announcing the release of the 6.6.140 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                     |   20 
 arch/arm64/crypto/aes-modes.S                                  |    4 
 arch/arm64/kvm/arm.c                                           |    5 
 arch/arm64/kvm/hyp/nvhe/setup.c                                |    6 
 arch/arm64/kvm/vgic/vgic-mmio-v2.c                             |    2 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                             |    2 
 arch/arm64/mm/mmu.c                                            |   36 -
 arch/loongarch/kernel/cpu-probe.c                              |    7 
 arch/loongarch/kernel/syscall.c                                |    3 
 arch/loongarch/pci/acpi.c                                      |    5 
 arch/loongarch/pci/pci.c                                       |    3 
 arch/parisc/kernel/syscalls/syscall.tbl                        |    2 
 arch/powerpc/kexec/Makefile                                    |    2 
 arch/s390/kernel/debug.c                                       |    5 
 arch/um/drivers/cow_user.c                                     |    8 
 arch/x86/kernel/shstk.c                                        |   45 +
 arch/x86/kvm/hyperv.c                                          |    2 
 arch/x86/kvm/mmu/mmu.c                                         |   35 -
 arch/x86/kvm/svm/nested.c                                      |   56 +
 arch/x86/kvm/svm/svm.c                                         |   17 
 arch/x86/kvm/svm/svm.h                                         |    2 
 arch/x86/kvm/x86.c                                             |   62 +-
 block/bio-integrity.c                                          |    2 
 block/bio.c                                                    |   14 
 block/blk.h                                                    |   21 
 certs/extract-cert.c                                           |    6 
 crypto/authencesn.c                                            |    5 
 crypto/pcrypt.c                                                |    7 
 drivers/acpi/cppc_acpi.c                                       |    6 
 drivers/acpi/power.c                                           |    2 
 drivers/acpi/scan.c                                            |    2 
 drivers/acpi/video_detect.c                                    |    8 
 drivers/base/core.c                                            |   39 -
 drivers/base/dd.c                                              |   20 
 drivers/block/rbd.c                                            |    6 
 drivers/block/zram/zram_drv.c                                  |    3 
 drivers/bluetooth/virtio_bt.c                                  |   39 +
 drivers/bus/imx-weim.c                                         |    2 
 drivers/char/ipmi/ipmi_si_intf.c                               |   70 +-
 drivers/char/ipmi/ipmi_ssif.c                                  |   36 +
 drivers/char/tpm/tpm_tis_core.c                                |   11 
 drivers/clk/clk-rk808.c                                        |    2 
 drivers/clk/imx/clk-imx8-acm.c                                 |    3 
 drivers/clk/microchip/clk-mpfs-ccc.c                           |    6 
 drivers/cpuidle/cpuidle-powernv.c                              |    5 
 drivers/cpuidle/cpuidle-pseries.c                              |    5 
 drivers/crypto/atmel-aes.c                                     |    2 
 drivers/crypto/atmel-ecc.c                                     |    1 
 drivers/crypto/atmel-sha204a.c                                 |    6 
 drivers/crypto/atmel-tdes.c                                    |    8 
 drivers/crypto/caam/caamalg_qi2.c                              |    4 
 drivers/crypto/caam/caamhash.c                                 |    4 
 drivers/crypto/ccree/cc_hash.c                                 |    1 
 drivers/crypto/hisilicon/sec/sec_algs.c                        |    2 
 drivers/crypto/nx/nx-842.c                                     |   47 -
 drivers/crypto/nx/nx-842.h                                     |   25 
 drivers/crypto/nx/nx-common-powernv.c                          |   31 -
 drivers/crypto/nx/nx-common-pseries.c                          |   33 -
 drivers/crypto/talitos.c                                       |  254 +++++----
 drivers/dma/idxd/device.c                                      |    3 
 drivers/extcon/extcon-ptn5150.c                                |   14 
 drivers/firmware/google/framebuffer-coreboot.c                 |   12 
 drivers/gpio/gpiolib-of.c                                      |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c               |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c                    |   43 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c                       |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h                       |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                          |    3 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                         |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                          |   25 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                          |   46 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                       |   29 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                          |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                      |   11 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h              |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    7 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c            |   13 
 drivers/gpu/drm/drm_gem_framebuffer_helper.c                   |    4 
 drivers/gpu/drm/nouveau/nouveau_gem.c                          |    2 
 drivers/gpu/drm/radeon/ci_dpm.c                                |    9 
 drivers/gpu/drm/tiny/arcpgu.c                                  |    3 
 drivers/hid/hid-playstation.c                                  |    6 
 drivers/hwmon/corsair-psu.c                                    |    4 
 drivers/hwmon/ltc2992.c                                        |   43 +
 drivers/i2c/i2c-core-of.c                                      |    2 
 drivers/iio/adc/ad7768-1.c                                     |    9 
 drivers/iio/adc/ti-ads7950.c                                   |   11 
 drivers/infiniband/core/addr.c                                 |    3 
 drivers/infiniband/hw/hns/hns_roce_qp.c                        |    7 
 drivers/infiniband/hw/mana/qp.c                                |   15 
 drivers/infiniband/hw/mlx4/srq.c                               |    4 
 drivers/infiniband/hw/mlx5/main.c                              |    1 
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c                    |    4 
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c                |    2 
 drivers/infiniband/sw/rxe/rxe_recv.c                           |   14 
 drivers/infiniband/sw/rxe/rxe_resp.c                           |   14 
 drivers/iommu/amd/amd_iommu_types.h                            |    2 
 drivers/iommu/amd/init.c                                       |    2 
 drivers/iommu/amd/iommu.c                                      |   18 
 drivers/iommu/iommufd/io_pagetable.c                           |   10 
 drivers/leds/rgb/leds-qcom-lpg.c                               |    7 
 drivers/md/dm-ioctl.c                                          |    6 
 drivers/md/dm-raid1.c                                          |    6 
 drivers/md/dm-verity-fec.c                                     |    8 
 drivers/md/persistent-data/dm-btree-remove.c                   |    8 
 drivers/md/raid10.c                                            |    6 
 drivers/md/raid5-cache.c                                       |   48 +
 drivers/md/raid5.c                                             |    8 
 drivers/media/common/videobuf2/videobuf2-dma-sg.c              |    1 
 drivers/media/dvb-frontends/dib8000.c                          |    4 
 drivers/media/i2c/imx219.c                                     |    3 
 drivers/media/i2c/imx412.c                                     |    2 
 drivers/media/i2c/ov08d10.c                                    |   10 
 drivers/media/i2c/ov8856.c                                     |   10 
 drivers/media/pci/saa7164/saa7164-core.c                       |   47 +
 drivers/media/pci/zoran/zoran_card.c                           |    2 
 drivers/media/platform/amphion/vpu_v4l2.c                      |    9 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c           |    1 
 drivers/media/platform/ti/omap3isp/ispvideo.c                  |    1 
 drivers/media/rc/igorplugusb.c                                 |   16 
 drivers/media/rc/streamzap.c                                   |   12 
 drivers/media/rc/ttusbir.c                                     |   13 
 drivers/media/rc/xbox_remote.c                                 |    9 
 drivers/media/usb/uvc/uvc_queue.c                              |    3 
 drivers/mfd/stpmic1.c                                          |   20 
 drivers/misc/ibmasm/ibmasmfs.c                                 |    7 
 drivers/misc/ibmasm/lowlevel.c                                 |   12 
 drivers/misc/ibmasm/remote.c                                   |    5 
 drivers/mmc/core/block.c                                       |   12 
 drivers/mmc/core/card.h                                        |    5 
 drivers/mmc/core/queue.c                                       |    8 
 drivers/mmc/core/queue.h                                       |    3 
 drivers/mmc/core/quirks.h                                      |    9 
 drivers/mmc/host/sdhci-of-dwcmshc.c                            |   19 
 drivers/mtd/devices/docg3.c                                    |    8 
 drivers/mtd/spi-nor/debugfs.c                                  |    4 
 drivers/mtd/spi-nor/sst.c                                      |   50 +
 drivers/net/bonding/bond_main.c                                |    6 
 drivers/net/can/usb/ucan.c                                     |    2 
 drivers/net/ethernet/ibm/ibmveth.c                             |   22 
 drivers/net/ethernet/ibm/ibmveth.h                             |    1 
 drivers/net/ethernet/micrel/ks8851.h                           |    6 
 drivers/net/ethernet/micrel/ks8851_common.c                    |   69 +-
 drivers/net/ethernet/micrel/ks8851_par.c                       |   15 
 drivers/net/ethernet/micrel/ks8851_spi.c                       |   11 
 drivers/net/ethernet/microsoft/mana/mana_en.c                  |   11 
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c               |    2 
 drivers/net/ethernet/stmicro/stmmac/common.h                   |    2 
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c                |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c              |   47 -
 drivers/net/ethernet/wangxun/libwx/wx_hw.c                     |    7 
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c                |    3 
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c                 |    2 
 drivers/net/phy/mdio_bus.c                                     |    4 
 drivers/net/wireless/ath/ath5k/base.c                          |    3 
 drivers/net/wireless/broadcom/b43/xmit.c                       |    3 
 drivers/net/wireless/broadcom/b43legacy/xmit.c                 |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c        |    6 
 drivers/net/wireless/marvell/mwifiex/init.c                    |    2 
 drivers/net/wireless/mediatek/mt76/mt76_connac.h               |    6 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c           |    4 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c           |    3 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h           |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c               |    7 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                |    3 
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h               |    4 
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c                |   51 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c          |   28 
 drivers/net/wireless/realtek/rtw88/pci.c                       |    3 
 drivers/net/wireless/rsi/rsi_common.h                          |    5 
 drivers/net/wwan/t7xx/t7xx_modem_ops.c                         |   20 
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c                     |   18 
 drivers/net/wwan/t7xx/t7xx_port_proxy.h                        |    2 
 drivers/nvme/host/apple.c                                      |    6 
 drivers/nvme/host/core.c                                       |    2 
 drivers/nvme/host/pci.c                                        |    2 
 drivers/nvme/target/core.c                                     |    2 
 drivers/of/base.c                                              |    2 
 drivers/of/dynamic.c                                           |    2 
 drivers/of/platform.c                                          |    2 
 drivers/of/unittest.c                                          |    1 
 drivers/parisc/lasi.c                                          |   12 
 drivers/pci/endpoint/functions/pci-epf-mhi.c                   |    4 
 drivers/pci/endpoint/functions/pci-epf-ntb.c                   |   56 -
 drivers/pci/pci.c                                              |    7 
 drivers/pci/pcie/aer.c                                         |    2 
 drivers/platform/x86/hp/hp-wmi.c                               |    5 
 drivers/power/supply/axp288_charger.c                          |   19 
 drivers/power/supply/max17042_battery.c                        |    2 
 drivers/pwm/pwm-imx-tpm.c                                      |    8 
 drivers/regulator/act8945a-regulator.c                         |    3 
 drivers/regulator/bd9571mwv-regulator.c                        |    3 
 drivers/regulator/max77650-regulator.c                         |    2 
 drivers/regulator/mt6357-regulator.c                           |    2 
 drivers/regulator/rk808-regulator.c                            |    3 
 drivers/remoteproc/xlnx_r5_remoteproc.c                        |   20 
 drivers/rtc/rtc-ntxec.c                                        |    2 
 drivers/scsi/sd.c                                              |    1 
 drivers/spi/spi-at91-usart.c                                   |    8 
 drivers/spi/spi-atmel.c                                        |    8 
 drivers/spi/spi-bcm63xx.c                                      |    8 
 drivers/spi/spi-bcmbca-hsspi.c                                 |    4 
 drivers/spi/spi-cadence.c                                      |   15 
 drivers/spi/spi-coldfire-qspi.c                                |   10 
 drivers/spi/spi-dln2.c                                         |    8 
 drivers/spi/spi-fsl-espi.c                                     |   10 
 drivers/spi/spi-fsl-spi.c                                      |   14 
 drivers/spi/spi-img-spfi.c                                     |    8 
 drivers/spi/spi-imx.c                                          |    5 
 drivers/spi/spi-lantiq-ssc.c                                   |    8 
 drivers/spi/spi-meson-spicc.c                                  |    2 
 drivers/spi/spi-microchip-core-qspi.c                          |   41 -
 drivers/spi/spi-mpc52xx.c                                      |    3 
 drivers/spi/spi-mtk-nor.c                                      |    4 
 drivers/spi/spi-omap2-mcspi.c                                  |    8 
 drivers/spi/spi-orion.c                                        |    9 
 drivers/spi/spi-qup.c                                          |    8 
 drivers/spi/spi-rockchip.c                                     |    4 
 drivers/spi/spi-rspi.c                                         |   10 
 drivers/spi/spi-s3c64xx.c                                      |    9 
 drivers/spi/spi-sh-hspi.c                                      |   10 
 drivers/spi/spi-sprd.c                                         |    8 
 drivers/spi/spi-sun4i.c                                        |   80 +-
 drivers/spi/spi-sun6i.c                                        |  154 ++---
 drivers/spi/spi-synquacer.c                                    |   88 +--
 drivers/spi/spi-tegra114.c                                     |    8 
 drivers/spi/spi-tegra20-sflash.c                               |    8 
 drivers/spi/spi-ti-qspi.c                                      |   97 +--
 drivers/spi/spi-topcliff-pch.c                                 |    6 
 drivers/spi/spi-uniphier.c                                     |  212 +++----
 drivers/spi/spi-zynq-qspi.c                                    |   79 --
 drivers/spi/spi-zynqmp-gqspi.c                                 |    4 
 drivers/spi/spi.c                                              |   63 +-
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c              |    4 
 drivers/staging/media/imx/imx-media-csi.c                      |   40 -
 drivers/staging/vme_user/vme_fake.c                            |    2 
 drivers/target/target_core_configfs.c                          |    2 
 drivers/thermal/sprd_thermal.c                                 |    4 
 drivers/thermal/thermal_core.c                                 |    7 
 drivers/usb/chipidea/core.c                                    |   45 -
 drivers/usb/chipidea/otg.c                                     |    7 
 drivers/usb/class/usblp.c                                      |    3 
 drivers/usb/common/ulpi.c                                      |    5 
 drivers/usb/dwc3/core.c                                        |   12 
 drivers/usb/gadget/udc/omap_udc.c                              |    4 
 drivers/usb/host/xhci.c                                        |    1 
 drivers/usb/serial/option.c                                    |    4 
 drivers/usb/typec/tcpm/tcpm.c                                  |    2 
 drivers/video/fbdev/core/fb_defio.c                            |  179 +++++-
 drivers/video/fbdev/core/fbcon_rotate.c                        |    5 
 drivers/video/fbdev/udlfb.c                                    |   31 +
 fs/binfmt_elf.c                                                |    2 
 fs/btrfs/ioctl.c                                               |    5 
 fs/btrfs/space-info.c                                          |    2 
 fs/ceph/dir.c                                                  |    6 
 fs/erofs/decompressor.c                                        |    1 
 fs/erofs/dir.c                                                 |   28 
 fs/ext2/inode.c                                                |   14 
 fs/ext4/extents.c                                              |   15 
 fs/ext4/xattr.c                                                |    6 
 fs/f2fs/data.c                                                 |   32 -
 fs/f2fs/extent_cache.c                                         |   17 
 fs/f2fs/f2fs.h                                                 |    2 
 fs/f2fs/inode.c                                                |    2 
 fs/f2fs/node.c                                                 |   17 
 fs/f2fs/segment.c                                              |    6 
 fs/f2fs/super.c                                                |   11 
 fs/hfsplus/bfind.c                                             |   51 +
 fs/hfsplus/catalog.c                                           |    4 
 fs/hfsplus/dir.c                                               |    2 
 fs/hfsplus/hfsplus_fs.h                                        |    9 
 fs/hfsplus/super.c                                             |    6 
 fs/isofs/export.c                                              |    2 
 fs/isofs/rock.c                                                |    9 
 fs/notify/fsnotify.c                                           |    2 
 fs/notify/inotify/inotify_user.c                               |    1 
 fs/notify/mark.c                                               |   18 
 fs/ntfs3/run.c                                                 |   18 
 fs/ocfs2/aops.c                                                |   74 +-
 fs/smb/client/cached_dir.c                                     |    8 
 fs/smb/client/cifsacl.c                                        |  177 ++++--
 fs/smb/client/cifsacl.h                                        |   91 ---
 fs/smb/client/smb2inode.c                                      |   12 
 fs/smb/client/smb2misc.c                                       |    3 
 fs/smb/client/smb2ops.c                                        |   11 
 fs/smb/common/smbacl.h                                         |  122 ++++
 fs/smb/server/connection.c                                     |   28 
 fs/smb/server/connection.h                                     |    6 
 fs/smb/server/smb2pdu.c                                        |    4 
 fs/smb/server/smbacl.c                                         |   48 +
 fs/smb/server/smbacl.h                                         |  113 ----
 fs/smb/server/transport_rdma.c                                 |    5 
 fs/smb/server/transport_tcp.c                                  |   25 
 fs/smb/server/vfs_cache.c                                      |   40 +
 fs/tracefs/event_inode.c                                       |   14 
 fs/tracefs/inode.c                                             |    5 
 fs/tracefs/internal.h                                          |    3 
 fs/udf/misc.c                                                  |    8 
 fs/udf/super.c                                                 |    4 
 fs/userfaultfd.c                                               |    2 
 fs/xfs/xfs_buf.c                                               |    1 
 include/linux/bpf_verifier.h                                   |   31 -
 include/linux/damon.h                                          |    2 
 include/linux/device.h                                         |   45 +
 include/linux/f2fs_fs.h                                        |    1 
 include/linux/fb.h                                             |    4 
 include/linux/fsnotify_backend.h                               |    1 
 include/linux/fwnode.h                                         |   44 +
 include/linux/mmap_lock.h                                      |    6 
 include/linux/mmc/card.h                                       |    1 
 include/linux/padata.h                                         |    4 
 include/linux/printk.h                                         |   13 
 include/linux/randomize_kstack.h                               |   26 
 include/linux/sched.h                                          |    4 
 include/linux/tpm_eventlog.h                                   |    9 
 include/linux/usb.h                                            |    3 
 include/net/mana/mana.h                                        |    1 
 include/net/mctp.h                                             |    3 
 include/trace/events/rxrpc.h                                   |    6 
 include/video/udlfb.h                                          |    1 
 init/main.c                                                    |    1 
 io_uring/poll.c                                                |   14 
 io_uring/timeout.c                                             |    4 
 kernel/bpf/verifier.c                                          |  236 +++++---
 kernel/exit.c                                                  |    3 
 kernel/fork.c                                                  |    2 
 kernel/locking/rtmutex.c                                       |   13 
 kernel/padata.c                                                |  136 +---
 kernel/regset.c                                                |    6 
 kernel/sched/core.c                                            |    2 
 kernel/sched/rt.c                                              |    2 
 kernel/sched/sched.h                                           |    2 
 kernel/taskstats.c                                             |    1 
 kernel/trace/trace_probe.c                                     |    6 
 kernel/trace/trace_probe.h                                     |    4 
 kernel/tracepoint.c                                            |    2 
 lib/crypto/mpi/mpicoder.c                                      |    2 
 lib/scatterlist.c                                              |    8 
 lib/test_hmm.c                                                 |   86 +--
 lib/ts_kmp.c                                                   |   18 
 mm/damon/core.c                                                |   37 +
 mm/damon/lru_sort.c                                            |   88 +--
 mm/damon/reclaim.c                                             |   88 +--
 mm/damon/sysfs-schemes.c                                       |   12 
 mm/hugetlb.c                                                   |    1 
 net/batman-adv/bat_iv_ogm.c                                    |   85 ++-
 net/batman-adv/bridge_loop_avoidance.c                         |   11 
 net/batman-adv/main.c                                          |    1 
 net/batman-adv/tp_meter.c                                      |  116 +++-
 net/batman-adv/tp_meter.h                                      |    1 
 net/batman-adv/types.h                                         |    4 
 net/bluetooth/hci_conn.c                                       |   19 
 net/bluetooth/hci_event.c                                      |   45 +
 net/bluetooth/l2cap_sock.c                                     |    9 
 net/bluetooth/mgmt.c                                           |  262 ++++++---
 net/bluetooth/mgmt_util.c                                      |   46 +
 net/bluetooth/mgmt_util.h                                      |    3 
 net/bridge/br_arp_nd_proxy.c                                   |    8 
 net/bridge/br_fdb.c                                            |   28 
 net/caif/cfsrvl.c                                              |   14 
 net/ceph/auth.c                                                |    4 
 net/ceph/mon_client.c                                          |    2 
 net/core/flow_dissector.c                                      |   13 
 net/core/rtnetlink.c                                           |    1 
 net/ipv4/ah4.c                                                 |   29 -
 net/ipv4/icmp.c                                                |    8 
 net/ipv4/inet_connection_sock.c                                |    3 
 net/ipv6/ah6.c                                                 |   27 
 net/ipv6/exthdrs.c                                             |    9 
 net/ipv6/ip6_gre.c                                             |    5 
 net/ipv6/rpl_iptunnel.c                                        |    9 
 net/ipv6/seg6_iptunnel.c                                       |   12 
 net/ipv6/xfrm6_protocol.c                                      |    4 
 net/mac80211/mlme.c                                            |    9 
 net/mac80211/rx.c                                              |    2 
 net/mctp/route.c                                               |    8 
 net/mptcp/protocol.c                                           |    3 
 net/mptcp/sockopt.c                                            |   12 
 net/mptcp/subflow.c                                            |    4 
 net/netfilter/nft_bitwise.c                                    |    3 
 net/openvswitch/vport-netdev.c                                 |    6 
 net/qrtr/ns.c                                                  |   86 ++-
 net/rds/message.c                                              |   20 
 net/rds/rdma.c                                                 |    4 
 net/rxrpc/ar-internal.h                                        |    1 
 net/rxrpc/call_event.c                                         |   27 
 net/rxrpc/conn_event.c                                         |   44 +
 net/rxrpc/io_thread.c                                          |   24 
 net/rxrpc/rxkad.c                                              |  112 +--
 net/rxrpc/skbuff.c                                             |    9 
 net/sched/sch_red.c                                            |    2 
 net/sctp/socket.c                                              |    9 
 net/smc/smc_clc.c                                              |    4 
 net/strparser/strparser.c                                      |    8 
 net/unix/af_unix.c                                             |    3 
 net/vmw_vsock/af_vsock.c                                       |    6 
 net/vmw_vsock/hyperv_transport.c                               |    4 
 net/vmw_vsock/virtio_transport_common.c                        |   11 
 net/xfrm/xfrm_state.c                                          |   12 
 net/xfrm/xfrm_user.c                                           |    1 
 security/selinux/hooks.c                                       |    3 
 security/selinux/selinuxfs.c                                   |   54 -
 sound/aoa/codecs/onyx.c                                        |  104 +--
 sound/aoa/codecs/tas.c                                         |  113 +---
 sound/aoa/core/gpio-feature.c                                  |   20 
 sound/aoa/core/gpio-pmf.c                                      |   26 
 sound/aoa/soundbus/i2sbus/core.c                               |   12 
 sound/aoa/soundbus/i2sbus/pcm.c                                |  143 ++---
 sound/core/control.c                                           |    4 
 sound/core/misc.c                                              |   44 -
 sound/core/seq/oss/seq_oss_rw.c                                |    6 
 sound/core/seq/seq_clientmgr.c                                 |    9 
 sound/core/seq/seq_clientmgr.h                                 |    5 
 sound/core/seq/seq_ump_client.c                                |    4 
 sound/drivers/pcmtest.c                                        |   19 
 sound/firewire/tascam/tascam-hwdep.c                           |    1 
 sound/pci/ctxfi/ctatc.c                                        |    3 
 sound/pci/hda/cs35l56_hda.c                                    |   19 
 sound/soc/amd/yc/acp6x-mach.c                                  |   14 
 sound/soc/fsl/fsl_easrc.c                                      |    2 
 sound/soc/intel/boards/bytcr_wm5102.c                          |    1 
 sound/soc/qcom/qdsp6/q6apm-dai.c                               |    1 
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c                        |    2 
 sound/soc/qcom/qdsp6/q6apm.c                                   |    3 
 sound/soc/sof/compress.c                                       |    3 
 sound/usb/6fire/control.c                                      |   10 
 sound/usb/caiaq/control.c                                      |   52 +
 sound/usb/caiaq/device.c                                       |   35 -
 sound/usb/caiaq/input.c                                        |    2 
 sound/usb/endpoint.c                                           |    6 
 sound/usb/format.c                                             |    2 
 sound/usb/midi2.c                                              |    9 
 sound/usb/misc/ua101.c                                         |    7 
 sound/usb/mixer.c                                              |    7 
 sound/usb/mixer_quirks.c                                       |   12 
 sound/usb/stream.c                                             |    4 
 tools/accounting/getdelays.c                                   |   41 +
 tools/accounting/procacct.c                                    |   40 +
 tools/testing/ktest/ktest.pl                                   |    2 
 tools/testing/selftests/bpf/progs/verifier_spill_fill.c        |  281 ++++++++++
 tools/testing/selftests/bpf/progs/verifier_subprog_precision.c |   87 ++-
 tools/testing/selftests/bpf/verifier/precise.c                 |   38 -
 tools/testing/selftests/mqueue/setting                         |    1 
 tools/testing/selftests/mqueue/settings                        |    1 
 448 files changed, 5508 insertions(+), 2882 deletions(-)

Aaro Koskinen (1):
      USB: omap_udc: DMA: Don't enable burst 4 mode

Abdun Nihaal (1):
      media: pci: zoran: fix potential memory leak in zoran_probe()

Alex Deucher (3):
      drm/radeon: add missing revision check for CI
      drm/amdgpu/pm: add missing revision check for CI
      drm/amdgpu/pm: align Hawaii mclk workaround with radeon

Alexander Koskovich (1):
      media: i2c: ov8856: free control handler on error in ov8856_init_controls()

Alistair Popple (1):
      lib: test_hmm: evict device pages on file close to avoid use-after-free

Alysa Liu (2):
      drm/amdkfd: Add upper bound check for num_of_nodes
      drm/amdkfd: validate SVM ioctl nattr against buffer size

Amir Shetaia (1):
      drm/amdkfd: Clear VRAM on allocation to prevent stale data exposure

Amit Kumar Mahapatra (1):
      mtd: spi-nor: sst: Fix SST write failure

Amit Sunil Dhamne (1):
      usb: typec: tcpm: reset internal port states on soft reset AMS

Andrea Mayer (2):
      seg6: fix seg6 lwtunnel output redirect for L2 reduced encap mode
      net: ipv6: fix NOREF dst use in seg6 and rpl lwtunnels

Andrii Nakryiko (10):
      bpf: support non-r10 register spill/fill to/from stack in precision tracking
      selftests/bpf: add stack access precision test
      bpf: preserve STACK_ZERO slots on partial reg spills
      selftests/bpf: validate STACK_ZERO is preserved on subreg spill
      bpf: preserve constant zero when doing partial register restore
      selftests/bpf: validate zero preservation for sub-slot loads
      bpf: track aligned STACK_ZERO cases as imprecise spilled registers
      selftests/bpf: validate precision logic in partial_stack_load_preserves_zeros
      bpf: handle fake register spill to stack with BPF_ST_MEM instruction
      selftests/bpf: validate fake register spill/fill precision backtracking logic

André Draszik (1):
      power: supply: max17042: avoid overflow when determining health

Ankit Soni (1):
      iommu/amd: serialize sequence allocation under concurrent TLB invalidations

Anshuman Khandual (1):
      arm64/mm: Enable batched TLB flush in unmap_hotplug_range()

Ao Zhou (1):
      net: rds: fix MR cleanup on copy error

Ard Biesheuvel (1):
      crypto: nx - Migrate to scomp API

Arjan van de Ven (1):
      drm/amdgpu: fix zero-size GDS range init on RDNA4

Arnd Bergmann (1):
      tpm: avoid -Wunused-but-set-variable

Ashutosh Desai (1):
      drm/gem: Fix inconsistent plane dimension calculation in drm_gem_fb_init_with_funcs()

Bartosz Golaszewski (1):
      gpio: of: clear OF_POPULATED on hog nodes in remove path

Ben Levinsky (1):
      remoteproc: xlnx: Only access buffer information if IPI is buffered

Ben Morris (1):
      sctp: revalidate list cursor after sctp_sendmsg_to_asoc() in SCTP_SENDALL

Bence Csókás (1):
      mtd: spi-nor: sst: Factor out common write operation to `sst_nor_write_data()`

Benjamin Cheng (7):
      drm/amdgpu: Add bounds checking to ib_{get,set}_value
      drm/amdgpu/vcn4: Prevent OOB reads when parsing IB
      drm/amdgpu/vce: Prevent partial address patches
      drm/amdgpu/vcn4: Prevent OOB reads when parsing dec msg
      drm/amdgpu/vcn3: Prevent OOB reads when parsing dec msg
      drm/amdgpu/vcn3: Avoid overflow on msg bound check
      drm/amdgpu/vcn4: Avoid overflow on msg bound check

Bin Liu (1):
      mmc: block: use single block write in retry

Bjoern Doebel (1):
      smb: client: use kzalloc to zero-initialize security descriptor buffer

Catherine (1):
      wifi: mac80211: drop stray 'static' from fast-RX rx_result

Cen Zhang (1):
      f2fs: add READ_ONCE() for i_blocks in f2fs_update_inode()

Chaitanya Kulkarni (1):
      nvmet: avoid recursive nvmet-wq flush in nvmet_ctrl_free

Chao Yu (2):
      f2fs: fix to detect potential corrupted nid in free_nid_list
      f2fs: fix to do sanity check on dcc->discard_cmd_cnt conditionally

Chen Ni (1):
      media: i2c: imx219: Check return value of devm_gpiod_get_optional() in imx219_probe()

Chen Zhao (1):
      IB/core: Fix zero dmac race in neighbor resolution

ChenXiaoSong (1):
      smb: move some duplicate definitions to common/smbacl.h

Chia-Ming Chang (2):
      md/raid5: fix soft lockup in retry_aligned_read()
      inotify: fix watch count leak when fsnotify_add_inode_mark_locked() fails

Christian A. Ehrhardt (2):
      lib/scatterlist: fix length calculations in extract_kvec_to_sg
      lib/scatterlist: fix temp buffer in extract_user_to_sg()

Conor Dooley (1):
      clk: microchip: mpfs-ccc: fix out of bounds access during output registration

Corey Minyard (5):
      ipmi: Add limits to event and receive message requests
      ipmi: Check event message buffer response for bad data
      ipmi:si: Return state to normal if message allocation fails
      ipmi:ssif: Fix a shutdown race
      ipmi:ssif: Clean up kthread on errors

Cássio Gabriel (16):
      ALSA: usb-audio: stop parsing UAC2 rates at MAX_NR_RATES
      ALSA: usb-audio: Avoid false E-MU sample-rate notifications
      ALSA: usb-audio: Fix Audio Advantage Micro II SPDIF switch
      ALSA: aoa: i2sbus: fix OF node lifetime handling
      ALSA: seq_oss: return full count for successful SEQ_FULLSIZE writes
      ALSA: caiaq: Fix control_put() result and cache rollback
      ALSA: 6fire: Fix input volume change detection
      ALSA: pcmtest: Fix resource leaks in module init error paths
      ALSA: usb-audio: midi2: Restart output URBs on resume
      ALSA: usb-audio: Fix UAC3 cluster descriptor size check
      ALSA: firewire-tascam: Do not drop unread control events
      ASoC: Intel: bytcr_wm5102: Fix MCLK leak on platform_clock_control error
      ALSA: aoa: i2sbus: clear stale prepared state
      ALSA: hda: cs35l56: Propagate ASP TX source control errors
      ALSA: core: Serialize deferred fasync state checks
      ALSA: seq: Fix UMP group 16 filtering

DaeMyung Kang (1):
      ksmbd: reset rcount per connection in ksmbd_conn_wait_idle_sess_id()

Daniel Hodges (2):
      wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()
      PCI: epf-mhi: Return 0, not remaining timeout, when eDMA ops complete

David Carlier (3):
      eventfs: Hold eventfs_mutex and SRCU when remount walks events
      tracepoint: balance regfunc() on func_add() failure in tracepoint_add_func()
      Bluetooth: hci_conn: fix potential UAF in create_big_sync

David Howells (6):
      rxrpc: Fix memory leaks in rxkad_verify_response()
      rxrpc: Fix rxkad crypto unalignment handling
      rxrpc: Fix re-decryption of RESPONSE packets
      rxrpc: Fix potential UAF after skb_unshare() failure
      rxrpc: Fix rxrpc_input_call_event() to only unshare DATA packets
      rxrpc: Fix conn-level packet handling to unshare RESPONSE packets

David Lechner (1):
      iio: adc: ti-ads7950: use iio_push_to_buffers_with_ts_unaligned()

David Windsor (1):
      selinux: don't reserve xattr slot when we won't fill it

David Woodhouse (1):
      KVM: arm64: vgic: Fix IIDR revision field extracted from wrong value

Dawei Feng (1):
      rbd: fix null-ptr-deref when device_add_disk() fails

Deepanshu Kartikey (3):
      ext4: fix bounds check in check_xattrs() to prevent out-of-bounds access
      ALSA: caiaq: fix usb_dev refcount leak on probe failure
      hfsplus: fix uninit-value by validating catalog record size

Denis M. Karpov (1):
      userfaultfd: allow registration of ranges below mmap_min_addr

Deren Wu (1):
      wifi: mt76: connac: introduce helper for mt7925 chipset

Dong Chenchen (1):
      net: Fix icmp host relookup triggering ip_rt_bug

Douglas Anderson (4):
      regset: use kvzalloc() for regset_get_alloc()
      device property: Make modifications of fwnode "flags" thread safe
      driver core: Don't let a device probe until it's ready
      driver core: Add kernel-doc for DEV_FLAG_COUNT enum value

Dudu Lu (1):
      vsock/virtio: fix accept queue count leak on transport mismatch

Eric Biggers (5):
      crypto: arm64/aes - Fix 32-bit aes_mac_update() arg treated as 64-bit
      dm-verity-fec: correctly reject too-small FEC devices
      dm-verity-fec: correctly reject too-small hash devices
      net: ipv4: stop checking crypto_ahash_alignmask
      net: ipv6: stop checking crypto_ahash_alignmask

Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion LE910Cx compositions

Fan Wu (1):
      media: mtk-jpeg: fix use-after-free in release path due to uncancelled work

Fedor Pchelkin (2):
      wifi: rtw88: check for PCI upstream bridge existence
      nvme-apple: drop invalid put of admin queue reference count

Felix Gu (2):
      spi: meson-spicc: Fix double-put in remove path
      usb: ulpi: fix memory leak on ulpi_register() error paths

Francesco Dolcini (1):
      arm64: dts: ti: am62-verdin: Enable pullup for eMMC data pins

Gang Yan (2):
      mptcp: sockopt: set timestamp flags on subflow socket, not msk
      mptcp: fix scheduling with atomic in timestamp sockopt

Gao Xiang (1):
      erofs: fix the out-of-bounds nameoff handling for trailing dirents

Greg Kroah-Hartman (8):
      drm/nouveau: fix u32 overflow in pushbuf reloc bounds check
      leds: qcom-lpg: Check for array overflow when selecting the high resolution
      LoongArch: Add spectre boundry for syscall dispatch table
      ipv6: rpl: reserve mac_len headroom when recompressed SRH grows
      scsi: target: configfs: Bound snprintf() return in tg_pt_gp_members_show()
      usb: usblp: fix heap leak in IEEE 1284 device ID via short response
      usb: usblp: fix uninitialized heap leak via LPGETSTATUS ioctl
      Linux 6.6.140

Guangshuo Li (3):
      ALSA: pcmtest: fix reference leak on failed device registration
      ACPI: scan: Use acpi_dev_put() in object add error paths
      btrfs: fix double free in create_space_info() error path

Gustavo A. R. Silva (1):
      crypto: nx - Avoid -Wflex-array-member-not-at-end warning

Hamza Mahfooz (1):
      hv_sock: fix ARM64 support

Haoxiang Li (3):
      crypto: ccree - fix a memory leak in cc_mac_digest()
      media: omap3isp: drop the use count of v4l2 pipeline
      xfs: fix a resource leak in xfs_alloc_buftarg()

Harin Lee (1):
      ALSA: ctxfi: Add fallback to default RSR for S/PDIF

Helge Deller (1):
      parisc: _llseek syscall is only available for 32-bit userspace

Heming Zhao (1):
      ocfs2: split transactions in dio completion to avoid credit exhaustion

Herbert Xu (3):
      padata: Fix pd UAF once and for all
      padata: Remove comment for reorder_work
      crypto: pcrypt - Fix handling of MAY_BACKLOG requests

Hongling Zeng (1):
      parisc: Fix IRQ leak in LASI driver

Huacai Chen (2):
      LoongArch: Show CPU vulnerabilites correctly
      LoongArch: Use per-root-bridge PCIH flag to skip mem resource fixup

Hyunwoo Kim (1):
      rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present

Ilya Maximets (1):
      openvswitch: vport: fix self-deadlock on release of tunnel ports

Jacqueline Wong (2):
      tpm: tpm_tis: add error logging for data transfer
      tpm: tpm_tis: stop transmit if retries are exhausted

Jamal Hadi Salim (1):
      net/sched: sch_red: Replace direct dequeue call with peek and qdisc_dequeue_peeked

James Kim (1):
      mtd: docg3: fix use-after-free in docg3_release()

Jann Horn (1):
      exit: prevent preemption of oopsing TASK_DEAD task

Janne Grunau (1):
      media: videobuf2: Set vma_flags in vb2_dma_sg_mmap

Jason Gunthorpe (4):
      RDMA/hns: Fix unlocked call to hns_roce_qp_remove()
      RDMA/mlx4: Fix resource leak on error in mlx4_ib_create_srq()
      RDMA/ocrdma: Don't NULL deref uctx on errors in ocrdma_copy_pd_uresp()
      RDMA/vmw_pvrdma: Fix double free on pvrdma_alloc_ucontext() error path

Jens Axboe (2):
      io_uring/poll: ensure EPOLL_ONESHOT is propagated for EPOLL_URING_WAKE
      io_uring/poll: fix multishot recv missing EOF on wakeup race

Jeongjun Park (1):
      wifi: rsi: fix kthread lifetime race between self-exit and external-stop

Jesse.Zhang (1):
      drm/amdgpu: Limit BO list entry count to prevent resource exhaustion

Jianpeng Chang (1):
      Bluetooth: MGMT: Fix memory leak in set_ssp_complete

Jiawen Wu (3):
      net: txgbe: fix firmware version check
      net: txgbe: fix RTNL assertion warning when remove module
      net: libwx: fix VF illegal register access

Jiexun Wang (4):
      af_unix: Reject SIOCATMARK on non-stream sockets
      batman-adv: reject new tp_meter sessions during teardown
      batman-adv: stop caching unowned originator pointers in BAT IV
      batman-adv: stop tp_meter sessions during mesh teardown

Jinjie Ruan (1):
      ACPI: CPPC: Fix related_cpus inconsistency during CPU hotplug

Jiri Slaby (SUSE) (1):
      wifi: ath5k: do not access array OOB

Johan Hovold (47):
      spi: imx: fix use-after-free on unbind
      rtc: ntxec: fix OF node reference imbalance
      can: ucan: fix devres lifetime
      spi: rockchip: fix controller deregistration
      spi: zynqmp-gqspi: fix controller deregistration
      spi: s3c64xx: fix NULL-deref on driver unbind
      staging: vme_user: fix root device leak on init failure
      clk: rk808: fix OF node reference imbalance
      spi: topcliff-pch: fix use-after-free on unbind
      spi: bcm63xx: fix controller deregistration
      spi: atmel: fix controller deregistration
      regulator: mt6357: fix OF node reference imbalance
      regulator: max77650: fix OF node reference imbalance
      regulator: rk808: fix OF node reference imbalance
      regulator: act8945a: fix OF node reference imbalance
      regulator: bd9571mwv: fix OF node reference imbalance
      spi: lantiq-ssc: fix controller deregistration
      spi: qup: fix controller deregistration
      spi: at91-usart: fix controller deregistration
      spi: dln2: fix controller deregistration
      spi: s3c64xx: fix controller deregistration
      spi: fsl-espi: fix controller deregistration
      spi: omap2-mcspi: fix controller deregistration
      spi: mtk-nor: fix controller deregistration
      spi: sh-hspi: fix controller deregistration
      spi: fsl: fix controller deregistration
      spi: bcmbca-hsspi: fix controller deregistration
      spi: coldfire-qspi: fix controller deregistration
      spi: sprd: fix controller deregistration
      spi: rspi: fix controller deregistration
      spi: img-spfi: fix controller deregistration
      spi: imx: fix runtime pm leak on probe deferral
      spi: orion: fix runtime pm leak on unbind
      spi: orion: fix clock imbalance on registration failure
      spi: mpc52xx: fix use-after-free on unbind
      spi: cadence: fix controller deregistration
      spi: cadence: fix unclocked access on unbind
      spi: fix resource leaks on device setup failure
      spi: syncuacer: fix controller deregistration
      spi: sun4i: fix controller deregistration
      spi: ti-qspi: fix controller deregistration
      spi: zynq-qspi: fix controller deregistration
      spi: sun6i: fix controller deregistration
      spi: tegra114: fix controller deregistration
      spi: tegra20-sflash: fix controller deregistration
      spi: uniphier: fix controller deregistration
      spi: microchip-core-qspi: fix controller deregistration

Johannes Berg (1):
      wifi: mac80211: remove station if connection prep fails

John B. Moore (2):
      drm/amdgpu/gfx9: drop unnecessary 64-bit fence flag check in KIQ
      drm/amdgpu/sdma4: replace BUG_ON with WARN_ON in fence emission

Jonathan Santos (1):
      iio: adc: ad7768-1: fix one-shot mode data acquisition

Joseph Salisbury (2):
      ASoC: fsl_easrc: fix comment typo
      sched: Use u64 for bandwidth ratio calculations

Josh Hunt (1):
      md/raid10: fix deadlock with check operation and nowait requests

Josh Law (1):
      lib/ts_kmp: fix integer overflow in pattern length calculation

Junrui Luo (5):
      md/raid5: validate payload size before accessing journal metadata
      dm mirror: fix integer overflow in create_dirty_log()
      md/raid10: fix divide-by-zero in setup_geo() with zero far_copies
      RDMA/mlx5: Fix error path fall-through in mlx5_ib_dev_res_srq_init()
      erofs: fix unsigned underflow in z_erofs_lz4_handle_overlap()

Kai Ma (1):
      netfilter: reject zero shift in nft_bitwise

Kai Zen (1):
      net: rtnetlink: zero ifla_vf_broadcast to avoid stack infoleak in rtnl_fill_vfinfo

Keenan Dong (1):
      rtmutex: Use waiter::task instead of current in remove_waiter()

Kevin Cheng (1):
      KVM: SVM: Inject #UD for INVLPGA if EFER.SVME=0

Koichiro Den (1):
      PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown

Krishna Chomal (1):
      platform/x86: hp-wmi: Ignore backlight and FnLock events

Krzysztof Kozlowski (1):
      power: supply: axp288_charger: Do not cancel work before initializing it

Kumar Kartikeya Dwivedi (1):
      bpf: Don't mark STACK_INVALID as STACK_MISC in mark_stack_slot_misc

Leon Yen (1):
      wifi: mt76: mt7921: fix a potential clc buffer length underflow

Li Zetao (1):
      spi: microchip-core-qspi: Use helper function devm_clk_get_enabled()

Linus Torvalds (1):
      x86: shadow stacks: proper error handling for mmap lock

Long Li (1):
      RDMA/mana_ib: Disable RX steering on RSS QP destroy

Longxuan Yu (1):
      io_uring/poll: fix signed comparison in io_poll_get_ownership()

Luca Ceresoli (1):
      drm/arcpgu: fix device node leak

Luiz Augusto von Dentz (3):
      Bluetooth: MGMT: Fix possible UAFs
      Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt
      Bluetooth: MGMT: Fix dangling pointer on mgmt_add_adv_patterns_monitor_complete

Lukas Wunner (2):
      lib/crypto: mpi: Fix integer underflow in mpi_read_raw_from_sgl()
      PCI/AER: Stop ruling out unbound devices as error source

Luke Wang (1):
      mmc: core: Optimize time for secure erase/trim for some Kingston eMMCs

Luxiao Xu (1):
      net: strparser: fix skb_head leak in strp_abort_strp()

Lyes Bourennani (1):
      batman-adv: fix integer overflow on buff_pos

Manivannan Sadhasivam (5):
      net: qrtr: ns: Fix use-after-free in driver remove()
      net: qrtr: ns: Free the node during ctrl_cmd_bye()
      net: qrtr: ns: Limit the maximum server registration per node
      net: qrtr: ns: Limit the maximum number of lookups
      net: qrtr: ns: Limit the total number of nodes

Maoyi Xie (1):
      ip6_gre: Use cached t->net in ip6erspan_changelink().

Marc Zyngier (1):
      KVM: arm64: Wake-up from WFI when iqrchip is in userspace

Marek Szyprowski (1):
      wifi: brcmfmac: Fix potential use-after-free issue when stopping watchdog task

Marek Vasut (3):
      mfd: stpmic1: Attempt system shutdown twice in case PMIC is confused
      net: ks8851: Reinstate disabling of BHs around IRQ handler
      net: ks8851: Avoid excess softirq scheduling

Mark Brown (1):
      ASoC: SOF: Don't allow pointer operations on unconfigured streams

Matthias Fend (1):
      media: i2c: ov08d10: fix image vertical start setting

Matthieu Baerts (NGI0) (1):
      mptcp: fastclose msk when linger time is 0

Max Kellermann (1):
      ceph: only d_add() negative dentries when they are unhashed

Michael Bommarito (12):
      um: drivers: call kernel_strrchr() explicitly in cow_user.c
      Bluetooth: virtio_bt: clamp rx length before skb_put
      Bluetooth: virtio_bt: validate rx pkt_type header length
      udf: reject descriptors with oversized CRC length
      isofs: validate Rock Ridge CE continuation extent against volume size
      isofs: validate block number from NFS file handle in isofs_export_iget
      smb: client: validate dacloffset before building DACL pointers
      RDMA/rxe: Reject non-8-byte ATOMIC_WRITE payloads
      RDMA/rxe: Reject unknown opcodes before ICRC processing
      ksmbd: require minimum ACE size in smb_check_perm_dacl()
      smb: client: validate the whole DACL before rewriting it in cifsacl
      xfrm: ah: account for ESN high bits in async callbacks

Michael Tretter (1):
      media: staging: imx: request mbus_config in csi_start

Michal Kosiorek (1):
      xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete

Michal Pecio (1):
      usb: xhci: Make usb_host_endpoint.hcpriv survive endpoint_disable()

Miklos Szeredi (1):
      fanotify: fix false positive on permission events

Mikulas Patocka (3):
      dm-thin: fix metadata refcount underflow
      dm: don't report warning when doing deferred remove
      dm: fix a buffer overflow in ioctl processing

Ming Qian (1):
      media: amphion: Fix race between m2m job_abort and device_run

Mingming Cao (1):
      ibmveth: Disable GSO for packets with small MSS

Myeonghun Pak (1):
      hwmon: (corsair-psu) Close HID device on probe errors

Naman Jain (2):
      block: add pgmap check to biovec_phys_mergeable
      block: relax pgmap check in bio_add_page for compatible zone device pages

Namjae Jeon (4):
      smb: common: change the data type of num_aces to le16
      ksmbd: use msleep instaed of schedule_timeout_interruptible()
      ksmbd: replace connection list with hash table
      ksmbd: fix use-after-free in __ksmbd_close_fd() via durable scavenger

Nan Li (1):
      net/rds: handle zerocopy send cleanup before the message is queued

Nathan Chancellor (1):
      extract-cert: Wrap key_pass with '#ifdef USE_PKCS11_ENGINE'

Nikolay Aleksandrov (1):
      bonding: fix use-after-free due to enslave fail after slave array update

Norbert Szetei (1):
      vsock: fix buffer size clamping order

Oliver Neukum (4):
      media: rc: xbox_remote: heed DMA restrictions
      media: rc: streamzap: Error handling in probe
      media: rc: ttusbir: respect DMA coherency rules
      media: rc: igorplugusb: heed coherency rules

Paolo Bonzini (2):
      KVM: SVM: check validity of VMCB controls when returning from SMM
      KVM: x86: check for nEPT/nNPT in slow flush hypercalls

Paul E. McKenney (1):
      exit: Sleep at TASK_IDLE when waiting for application core dump

Paul Louvel (2):
      crypto: talitos - fix SEC1 32k ahash request limitation
      crypto: talitos - rename first/last to first_desc/last_desc

Pavel Begunkov (1):
      io_uring/timeout: check unused sqe fields

Pavitra Jha (1):
      net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler

Pei Xiao (2):
      spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled()
      spi: uniphier: Simplify clock handling with devm_clk_get_enabled()

Philip Yang (1):
      drm/amdgpu: zero-initialize GART table on allocation

Qingfang Deng (1):
      flow_dissector: do not dissect PPPoE PFC frames

Quan Zhou (1):
      wifi: mt76: mt7921: fix ROC abort flow interruption in mt7921_roc_work

Quentin Perret (1):
      KVM: arm64: Fix initialisation order in __pkvm_init_finalise()

Rafael J. Wysocki (1):
      thermal: core: Fix thermal zone governor cleanup issues

Rajat Gupta (1):
      fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent use-after-free

Raphael Zimmer (2):
      libceph: Prevent potential null-ptr-deref in ceph_handle_auth_reply()
      libceph: Fix slab-out-of-bounds access in auth message processing

Ricardo Ribalda (1):
      media: uvcvideo: Enable VB2_DMABUF for metadata stream

Rick Edgecombe (1):
      x86/shstk: Prevent deadlock during shstk sigreturn

Robert Beckett (2):
      nvme-pci: add NVME_QUIRK_DISABLE_WRITE_ZEROES for Kingston OM3SGP4
      nvme: respect NVME_QUIRK_DISABLE_WRITE_ZEROES when wzsl is set

Rong Zhang (1):
      Revert "ALSA: usb: Increase volume range that triggers a warning"

Ruide Cao (1):
      ipv4: icmp: validate reply type before using icmp_pointers

Ruijie Li (2):
      net/smc: avoid early lgr access in smc_clc_wait_msg
      xfrm: provide message size for XFRM_MSG_MAPPING

Russell King (Oracle) (2):
      net: stmmac: avoid shadowing global buf_sz
      net: stmmac: rename STMMAC_GET_ENTRY() -> STMMAC_NEXT_ENTRY()

Ryan Roberts (1):
      randomize_kstack: Maintain kstack_offset per task

Sakari Ailus (1):
      staging: media: atomisp: Disallow all private IOCTLs

Sam Edwards (1):
      net: stmmac: Prevent NULL deref when RX memory exhausted

Sang-Heon Jeon (1):
      mm/hugetlb_cma: round up per_node before logging it

Sanjaikumar V S (1):
      mtd: spi-nor: sst: Fix write enable before AAI sequence

Sanman Pradhan (2):
      hwmon: (ltc2992) Clamp threshold writes to hardware range
      hwmon: (ltc2992) Fix u32 overflow in power read path

Sean Christopherson (3):
      KVM: x86: Defer non-architectural deliver of exception payload to userspace read
      KVM: SVM: Explicitly mark vmcb01 dirty after modifying VMCB intercepts
      KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

Sean Wang (2):
      wifi: mt76: mt792x: describe USB WFSYS reset with a descriptor
      wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling

Selvarasu Ganesan (1):
      usb: dwc3: Move GUID programming after PHY initialization

Seohyeon Maeng (1):
      udf: fix partition descriptor append bookkeeping

SeongJae Park (6):
      mm/damon/core: use time_in_range_open() for damos quota window start
      mm/damon/sysfs-schemes: protect memcg_path kfree() with damon_sysfs_lock
      mm/damon/core: disallow time-quota setting zero esz
      mm/damon/core: implement damon_kdamond_pid()
      mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
      mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values

Sergey Senozhatsky (1):
      zram: do not forget to endio for partial discard requests

Sergey Shtylyov (1):
      media: dib8000: avoid division by 0 in dib8000_set_dds()

SeungJu Cheon (1):
      sound: ua101: fix division by zero at probe

Shardul Bankar (2):
      mptcp: use MPJoinSynAckHMacFailure for SynAck HMAC failure
      mptcp: use MPTCP_RST_EMPTCP for ACK HMAC validation failure

Shawn Lin (1):
      mmc: sdhci-of-dwcmshc: Disable clock before DLL configuration

Shivam Kalra (1):
      ACPI: video: force native backlight on HP OMEN 16 (8A44)

Shrikanth Hegde (1):
      cpuidle: powerpc: avoid double clear when breaking snooze

Shuai Xue (1):
      PCI/AER: Clear only error bits in PCIe Device Status

Shuvam Pandey (1):
      Bluetooth: hci_event: fix potential UAF in SSP passkey handlers

Shyam Prasad N (2):
      cifs: abort open_cached_dir if we don't request leases
      cifs: change_conf needs to be called for session setup

Simon Liebold (1):
      selftests/mqueue: Fix incorrectly named file

Sina Hassani (1):
      iommufd: Fix a race with concurrent allocation and unmap

Siwei Zhang (3):
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_new_connection_cb()
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()

Sohei Koyama (1):
      ext4: fix missing brelse() in ext4_xattr_inode_dec_ref_all()

Sourabh Jain (1):
      powerpc/kdump: fix KASAN sanitization flag for core_$(BITS).o

Srinivas Kandagatla (3):
      ASoC: qcom: q6apm-dai: reset queue ptr on trigger stop
      ASoC: qcom: q6apm-lpass-dai: Fix multiple graph opens
      ASoC: qcom: q6apm: remove child devices when apm is removed

Stefan Eichenberger (1):
      clk: imx: imx8-acm: fix flags for acm clocks

Stefano Garzarella (1):
      vsock/virtio: fix length and offset in tap skb for split packets

Stephen Smalley (2):
      selinux: shrink critical section in sel_write_load()
      selinux: prune /sys/fs/selinux/disable

Steven Rostedt (2):
      ktest: Fix the month in the name of the failure directory
      tracing/probes: Limit size of event probe to 3K

Sven Eckelmann (4):
      batman-adv: bla: prevent use-after-free when deleting claims
      batman-adv: bla: only purge non-released claims
      batman-adv: bla: put backbone reference on failed claim hash insert
      batman-adv: tp_meter: fix tp_num leak on kmalloc failure

T.J. Mercier (1):
      HID: playstation: Clamp num_touch_reports

Takashi Iwai (9):
      ALSA: usb-audio: Evaluate packsize caps at the right place
      ALSA: core: Fix potential data race at fasync handling
      ALSA: caiaq: Handle probe errors properly
      ALSA: caiaq: Fix potentially leftover ep1_in_urb at error path
      ALSA: caiaq: Don't abort when no input device is available
      ALSA: usb-audio: Avoid potential endless loop in convert_chmap_v3()
      ALSA: aoa: Use guard() for mutex locks
      ALSA: misc: Use guard() for spin locks
      ALSA: seq: Notify client and port info changes

Tejas Bharambe (1):
      ext4: validate p_idx bounds in ext4_ext_correct_indexes

Thomas Fourier (1):
      crypto: hisilicon - Fix dma_unmap_single() direction

Thomas Zimmermann (4):
      firmware: google: framebuffer: Do not mark framebuffer as busy
      fbdev: defio: Disconnect deferred I/O from the lifetime of struct fb_info
      firmware: google: framebuffer: Do not unregister platform device
      fbcon: Avoid OOB font access if console rotation fails

Thorsten Blum (11):
      crypto: atmel-aes - Fix 3-page memory leak in atmel_aes_buff_cleanup
      crypto: atmel-ecc - Release client on allocation failure
      crypto: atmel-tdes - fix DMA sync direction
      crypto: atmel-sha204a - Fix potential UAF and memory leak in remove path
      thermal/drivers/sprd: Fix temperature clamping in sprd_thm_temp_to_rawdata
      thermal/drivers/sprd: Fix raw temperature clamping in sprd_thm_rawdata_to_temp
      ALSA: aoa: Skip devices with no codecs in i2sbus_resume()
      crypto: nx - fix bounce buffer leaks in nx842_crypto_{alloc,free}_ctx
      printk: add print_hex_dump_devel()
      crypto: caam - guard HMAC key hex dumps in hash_digest_key
      crypto: nx - fix context leak in nx842_crypto_free_ctx

Tobias Gaertner (2):
      ntfs3: add buffer boundary checks to run_unpack()
      ntfs3: fix integer overflow in run_unpack() volume boundary check

Tommaso Soncin (1):
      ASoC: amd: yc: Add HP OMEN Gaming Laptop 16-ap0xxx product line in quirk table

Tristan Madani (2):
      wifi: b43legacy: enforce bounds check on firmware key index in RX path
      wifi: b43: enforce bounds check on firmware key index in b43_rx()

Tudor Ambarus (1):
      mtd: spi-nor: debugfs: fix out-of-bounds read in spi_nor_params_show()

Tvrtko Ursulin (1):
      drm/amdgpu: Use vmemdup_array_user in amdgpu_bo_create_list_entry_array

Tyllis Xu (3):
      misc: ibmasm: fix OOB MMIO read in ibmasm_handle_mouse_interrupt()
      ibmasm: fix OOB reads in command_file_write due to missing size checks
      ibmasm: fix heap over-read in ibmasm_send_i2o_message()

Uros Bizjak (1):
      iommu/amd: Use atomic64_inc_return() in iommu.c

Uwe Kleine-König (2):
      mtd: docg3: Convert to platform remove callback returning void
      spi: spi-ti-qspi: Convert to platform remove callback returning void

Vasiliy Kovalev (1):
      ext2: reject inodes with zero i_nlink and valid mode in ext2_iget()

Vasily Gorbik (1):
      s390/debug: Reject zero-length input in debug_input_flush_fn()

Vinicius Costa Gomes (2):
      dmaengine: idxd: Fix crash when the event log is disabled
      dmaengine: idxd: Fix leaking event log memory

Viorel Suman (OSS) (1):
      pwm: imx-tpm: Count the number of enabled channels in probe

Wang Jun (1):
      media: saa7164: add ioremap return checks and cleanups

Wenmeng Liu (1):
      media: i2c: imx412: Assert reset GPIO during probe

Wentao Guan (1):
      LoongArch: Fix potential ADE in loongson_gpu_fixup_dma_hang()

Wentao Liang (1):
      of: unittest: fix use-after-free in testdrv_probe()

Xu Yang (3):
      usb: chipidea: otg: not wait vbus drop if use role_switch
      usb: chipidea: core: allow ci_irq_handler() handle both ID and VBUS change
      extcon: ptn5150: handle pending IRQ events during system resume

Yang Xiuwei (1):
      scsi: sd: fix missing put_disk() when device_add(&disk_dev) fails

Yang Yingliang (6):
      spi: synquacer: switch to use modern name
      spi: sun4i: switch to use modern name
      spi: spi-ti-qspi: switch to use modern name
      spi: zynq-qspi: switch to use modern name
      spi: sun6i: switch to use modern name
      spi: uniphier: switch to use modern name

Yi Cong (1):
      wifi: rtl8xxxu: fix potential use of uninitialized value

Yilin Zhu (1):
      ipv6: xfrm6: release dst on error in xfrm6_rcv_encap()

Yiyang Chen (2):
      tools/accounting: handle truncated taskstats netlink messages
      taskstats: set version in TGID exit notifications

Yochai Eisenrich (1):
      btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU which can lead to info-leak

Yongpeng Yang (4):
      f2fs: fix fiemap boundary handling when read extent cache is incomplete
      f2fs: fix incorrect multidevice info in trace_f2fs_map_blocks()
      f2fs: fix node_cnt race between extent node destroy and writeback
      f2fs: fix UAF caused by decrementing sbi->nr_pages[] in f2fs_write_end_io()

Yosry Ahmed (11):
      KVM: nSVM: Mark all of vmcb02 dirty when restoring nested state
      KVM: nSVM: Sync NextRIP to cached vmcb12 after VMRUN of L2
      KVM: nSVM: Sync interrupt shadow to cached vmcb12 after VMRUN of L2
      KVM: nSVM: Ensure AVIC is inhibited when restoring a vCPU to guest mode
      KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12 on nested #VMEXIT
      KVM: nSVM: Always inject a #GP if mapping VMCB12 fails on nested VMRUN
      KVM: nSVM: Clear GIF on nested #VMEXIT(INVALID)
      KVM: nSVM: Clear EVENTINJ fields in vmcb12 on nested #VMEXIT
      KVM: nSVM: Clear tracking of L1->L2 NMI and soft IRQ on nested #VMEXIT
      KVM: nSVM: Add missing consistency check for EFER, CR0, CR4, and CS
      KVM: nSVM: Add missing consistency check for nCR3 validity

Yuan Zhaoming (1):
      net: mctp: fix don't require received header reserved bits to be zero

Yucheng Lu (1):
      crypto: authencesn - reject short ahash digests during instance creation

Yussuf Khalil (1):
      drm/amd/display: Do not skip unrelated mode changes in DSC validation

Zhengchuan Liang (2):
      net: caif: clear client service pointer on teardown
      net: bridge: use a stable FDB dst snapshot in RCU readers

Zhenzhong Wu (1):
      tcp: call sk_data_ready() after listener migration

Zilin Guan (1):
      hfsplus: fix held lock freed on hfsplus_fill_super()

Ziqing Chen (1):
      ALSA: control: Validate buf_len before strnlen() in snd_ctl_elem_init_enum_names()

Zisen Ye (2):
      smb/client: fix out-of-bounds read in smb2_compound_op()
      smb/client: fix out-of-bounds read in symlink_data()

hkbinbin (1):
      RDMA/rxe: Validate pad and ICRC before payload_size() in rxe_rcv


