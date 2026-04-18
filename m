Return-Path: <stable+bounces-238565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EfKrORZG42mgEAEAu9opvQ
	(envelope-from <stable+bounces-238565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 10:51:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E36142073D
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 10:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 633CF30090B8
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3BA37CD35;
	Sat, 18 Apr 2026 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KXrLxFQZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29822F1FFC;
	Sat, 18 Apr 2026 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776502289; cv=none; b=Du2MZLHLkqTy0wD6S+Ys9PnLNzjZoId00HHLkAeUjj3Vd0QwjOxvBtsfEO8QnGYLviqdw8wdroBSAg65aEobiFSnGiEzdZ77lPGE6RNFWppfTuYhelNETJxYBDtPHUOsADuUZu68OP66jV3wwXCYVecNBnV1s34mtHMD1FCHWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776502289; c=relaxed/simple;
	bh=VXRTDfFmZCr5rKbi4fdO2X6VfWUVSV+ILmItEvaoAtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LQi+2nJlKNNGPgOCM3s4ZHy8fqeUbbLScTNaLiW8k9UlWRkuHAkIUi6TZmLf4fMYV8RBVFuD4Y/ZoMM270uqLSaxhS9MFYF5UhZVj2KA1KUpIvFqgd4oY7d3dVfcDtS/5rWmmwSr3volyte2/duc1W4ELuhFssIFXyf+VmfDLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KXrLxFQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9DDC19424;
	Sat, 18 Apr 2026 08:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776502289;
	bh=VXRTDfFmZCr5rKbi4fdO2X6VfWUVSV+ILmItEvaoAtM=;
	h=From:To:Cc:Subject:Date:From;
	b=KXrLxFQZckc1hxfbCcbf2zyULW9zDwEFWtmASHY7JyflghiqPUn7Ba4AukKXw9Coe
	 xj2LmD3pvMl2Qqi9hJ2PzNxWzOTKmD+JE/A5zyN3nBg0Xn+X8mWzJ1VM1ct/qQJHN8
	 VSxMBi67uav5uMEjeInpIeSndyE6czEh/xMO1+9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.253
Date: Sat, 18 Apr 2026 10:50:55 +0200
Message-ID: <2026041855-squealing-ladybug-c430@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238565-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,iloc.bh:url]
X-Rspamd-Queue-Id: 5E36142073D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 5.10.253 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/hwmon/adm1177.rst                          |    8 
 Makefile                                                 |    2 
 arch/arm/include/asm/string.h                            |   14 
 arch/arm/mach-omap2/cm_common.c                          |    8 
 arch/arm/mach-omap2/control.c                            |   29 -
 arch/arm/mach-omap2/prm_common.c                         |    8 
 arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts     |    2 
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi           |    1 
 arch/arm64/include/asm/pgtable-prot.h                    |   10 
 arch/mips/lib/multi3.c                                   |    6 
 arch/parisc/include/asm/pgtable.h                        |    2 
 arch/parisc/kernel/head.S                                |    7 
 arch/powerpc/include/asm/uaccess.h                       |    2 
 arch/powerpc/platforms/83xx/km83xx.c                     |    4 
 arch/riscv/kernel/kgdb.c                                 |    7 
 arch/s390/include/asm/barrier.h                          |    4 
 arch/s390/kernel/entry.S                                 |    7 
 arch/s390/lib/xor.c                                      |    4 
 arch/sh/drivers/platform_early.c                         |    4 
 arch/x86/include/asm/efi.h                               |    2 
 arch/x86/include/asm/msr-index.h                         |    3 
 arch/x86/kernel/apic/apic.c                              |    6 
 arch/x86/kernel/cpu/amd.c                                |    3 
 arch/x86/kvm/svm/avic.c                                  |    2 
 arch/x86/kvm/svm/svm.c                                   |    2 
 arch/x86/mm/fault.c                                      |  118 ++---
 arch/x86/platform/efi/efi.c                              |    2 
 arch/x86/platform/efi/quirks.c                           |   55 ++
 crypto/af_alg.c                                          |    4 
 drivers/acpi/acpica/evxfregn.c                           |   92 +++-
 drivers/acpi/ec.c                                        |   32 -
 drivers/acpi/internal.h                                  |    1 
 drivers/acpi/osi.c                                       |   13 
 drivers/acpi/osl.c                                       |    2 
 drivers/acpi/sleep.c                                     |    8 
 drivers/ata/libata-core.c                                |    3 
 drivers/ata/libata-sata.c                                |    2 
 drivers/ata/libata-scsi.c                                |  123 ++---
 drivers/ata/libata-sff.c                                 |    4 
 drivers/ata/libata.h                                     |    1 
 drivers/base/power/runtime.c                             |    1 
 drivers/base/property.c                                  |  205 ++++++--
 drivers/base/regmap/regmap.c                             |   30 +
 drivers/block/drbd/drbd_actlog.c                         |   53 +-
 drivers/block/drbd/drbd_interval.h                       |    5 
 drivers/bluetooth/btusb.c                                |    5 
 drivers/bluetooth/hci_ll.c                               |    2 
 drivers/clk/tegra/clk-tegra124-emc.c                     |    2 
 drivers/cpufreq/cpufreq_conservative.c                   |   12 
 drivers/cpufreq/cpufreq_governor.c                       |   13 
 drivers/cpufreq/cpufreq_governor.h                       |    1 
 drivers/cpuidle/cpuidle.c                                |   10 
 drivers/crypto/atmel-sha204a.c                           |    5 
 drivers/dma/xilinx/xilinx_dma.c                          |   66 +-
 drivers/firmware/efi/mokvar-table.c                      |   20 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c         |    6 
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c          |    2 
 drivers/gpu/drm/ast/ast_dp501.c                          |    2 
 drivers/gpu/drm/drm_ioc32.c                              |    2 
 drivers/gpu/drm/exynos/exynos_drm_drv.h                  |    1 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                 |   72 ++-
 drivers/gpu/drm/i915/display/intel_gmbus.c               |    4 
 drivers/gpu/drm/msm/msm_gpummu.c                         |    2 
 drivers/gpu/drm/nouveau/nouveau_connector.c              |    3 
 drivers/gpu/drm/radeon/si_dpm.c                          |    4 
 drivers/gpu/drm/tegra/dsi.c                              |    6 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                  |    4 
 drivers/hid/hid-asus.c                                   |   15 
 drivers/hid/hid-cmedia.c                                 |    2 
 drivers/hid/hid-creative-sb0540.c                        |    2 
 drivers/hid/hid-mcp2221.c                                |    2 
 drivers/hid/hid-multitouch.c                             |    7 
 drivers/hid/hid-zydacron.c                               |    2 
 drivers/hid/wacom_wac.c                                  |   10 
 drivers/hwmon/adm1177.c                                  |   54 +-
 drivers/hwmon/max16065.c                                 |   26 -
 drivers/hwmon/occ/common.c                               |   19 
 drivers/hwmon/pmbus/isl68137.c                           |    7 
 drivers/hwmon/pmbus/pxe1610.c                            |    5 
 drivers/i2c/busses/i2c-fsi.c                             |    1 
 drivers/iio/chemical/bme680_core.c                       |    2 
 drivers/iio/dac/ad5770r.c                                |    2 
 drivers/iio/dac/ds4424.c                                 |    2 
 drivers/iio/gyro/mpu3050-core.c                          |   50 +-
 drivers/iio/gyro/mpu3050-i2c.c                           |    3 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c        |    2 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c       |    3 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c         |    2 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c           |    4 
 drivers/iio/light/bh1780.c                               |    4 
 drivers/iio/light/vcnl4035.c                             |   18 
 drivers/iio/potentiometer/mcp4131.c                      |    2 
 drivers/infiniband/core/rw.c                             |   21 
 drivers/infiniband/hw/mthca/mthca_provider.c             |    5 
 drivers/input/joystick/xpad.c                            |    2 
 drivers/input/misc/uinput.c                              |   35 +
 drivers/input/rmi4/rmi_f54.c                             |    4 
 drivers/input/serio/i8042-acpipnpio.h                    |    7 
 drivers/iommu/intel/dmar.c                               |    3 
 drivers/irqchip/irq-gic-v3-its.c                         |    4 
 drivers/media/dvb-core/dmxdev.c                          |    4 
 drivers/media/dvb-core/dvb_net.c                         |    3 
 drivers/media/dvb-frontends/dib7000p.c                   |   10 
 drivers/media/mc/mc-request.c                            |    5 
 drivers/media/v4l2-core/v4l2-ioctl.c                     |    5 
 drivers/mmc/host/mmci_qcom_dml.c                         |    1 
 drivers/mmc/host/sdhci-pci-gli.c                         |    9 
 drivers/mmc/host/sdhci.c                                 |    9 
 drivers/mmc/host/vub300.c                                |    2 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                 |   63 ++
 drivers/mtd/nand/raw/cadence-nand-controller.c           |    2 
 drivers/mtd/nand/raw/nand_base.c                         |   14 
 drivers/mtd/parsers/redboot.c                            |   71 +--
 drivers/net/arcnet/com20020-pci.c                        |   16 
 drivers/net/bonding/bond_debugfs.c                       |   16 
 drivers/net/bonding/bond_main.c                          |    8 
 drivers/net/caif/caif_serial.c                           |    3 
 drivers/net/can/spi/hi311x.c                             |    5 
 drivers/net/can/spi/mcp251x.c                            |   15 
 drivers/net/can/usb/ems_usb.c                            |    7 
 drivers/net/can/usb/gs_usb.c                             |   13 
 drivers/net/can/usb/ucan.c                               |    2 
 drivers/net/dsa/bcm_sf2.c                                |    8 
 drivers/net/ethernet/altera/altera_tse_main.c            |    1 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                 |   10 
 drivers/net/ethernet/amd/xgbe/xgbe-main.c                |    1 
 drivers/net/ethernet/amd/xgbe/xgbe.h                     |    3 
 drivers/net/ethernet/arc/emac_main.c                     |   11 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c       |    2 
 drivers/net/ethernet/broadcom/tg3.c                      |    2 
 drivers/net/ethernet/cadence/macb_main.c                 |   18 
 drivers/net/ethernet/cadence/macb_pci.c                  |   10 
 drivers/net/ethernet/cadence/macb_ptp.c                  |    4 
 drivers/net/ethernet/faraday/ftgmac100.c                 |   28 +
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c     |    2 
 drivers/net/ethernet/intel/e1000/e1000_main.c            |    2 
 drivers/net/ethernet/intel/e1000e/netdev.c               |    2 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c       |   14 
 drivers/net/ethernet/intel/igc/igc_main.c                |    7 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c        |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c |    1 
 drivers/net/ethernet/mellanox/mlx5/core/fw.c             |   53 +-
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h      |    4 
 drivers/net/ethernet/qualcomm/qca_uart.c                 |    2 
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c         |   11 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                 |    2 
 drivers/net/ethernet/ti/cpsw_ale.c                       |    9 
 drivers/net/ethernet/xilinx/xilinx_axienet.h             |    4 
 drivers/net/phy/phy_device.c                             |   13 
 drivers/net/usb/aqc111.c                                 |   12 
 drivers/net/usb/kalmia.c                                 |    7 
 drivers/net/usb/kaweth.c                                 |   13 
 drivers/net/usb/lan78xx.c                                |    8 
 drivers/net/usb/lan78xx.h                                |    3 
 drivers/net/usb/pegasus.c                                |   13 
 drivers/net/virtio_net.c                                 |    1 
 drivers/net/vxlan/vxlan_core.c                           |   11 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c   |    2 
 drivers/net/wireless/marvell/libertas/main.c             |    4 
 drivers/net/wireless/microchip/wilc1000/hif.c            |    2 
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c           |    2 
 drivers/net/wireless/ti/wlcore/main.c                    |    4 
 drivers/net/wireless/ti/wlcore/tx.c                      |    2 
 drivers/nfc/nxp-nci/i2c.c                                |    4 
 drivers/nfc/pn533/uart.c                                 |   14 
 drivers/nfc/pn533/usb.c                                  |    1 
 drivers/nvdimm/bus.c                                     |    5 
 drivers/nvme/host/fc.c                                   |    2 
 drivers/nvme/host/pci.c                                  |    5 
 drivers/nvme/target/tcp.c                                |    6 
 drivers/pci/pci-driver.c                                 |    8 
 drivers/pci/pci.c                                        |   10 
 drivers/pci/pci.h                                        |    1 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                 |  122 +++--
 drivers/phy/ti/phy-j721e-wiz.c                           |    2 
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c            |    9 
 drivers/platform/olpc/olpc-xo175-ec.c                    |    2 
 drivers/platform/x86/intel-hid.c                         |    7 
 drivers/platform/x86/thinkpad_acpi.c                     |    6 
 drivers/platform/x86/touchscreen_dmi.c                   |   18 
 drivers/regulator/pca9450-regulator.c                    |   41 -
 drivers/remoteproc/qcom_sysmon.c                         |    2 
 drivers/s390/crypto/zcrypt_ccamisc.c                     |   12 
 drivers/s390/crypto/zcrypt_cex4.c                        |    3 
 drivers/scsi/ibmvscsi/ibmvfc.c                           |    3 
 drivers/scsi/lpfc/lpfc_init.c                            |    2 
 drivers/scsi/lpfc/lpfc_sli.c                             |   36 +
 drivers/scsi/lpfc/lpfc_sli4.h                            |    3 
 drivers/scsi/scsi_lib.c                                  |    3 
 drivers/scsi/scsi_transport_sas.c                        |    2 
 drivers/scsi/ses.c                                       |    7 
 drivers/scsi/storvsc_drv.c                               |    5 
 drivers/scsi/ufs/ufshcd.c                                |   18 
 drivers/soc/bcm/bcm2835-power.c                          |   33 -
 drivers/soc/fsl/qbman/qman.c                             |   24 -
 drivers/spi/spi-fsl-lpspi.c                              |    3 
 drivers/staging/comedi/drivers.c                         |    8 
 drivers/staging/comedi/drivers/dt2815.c                  |   12 
 drivers/staging/comedi/drivers/me4000.c                  |   16 
 drivers/staging/comedi/drivers/me_daq.c                  |   35 -
 drivers/staging/comedi/drivers/ni_atmio16d.c             |    3 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c           |   16 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                |   13 
 drivers/thunderbolt/nhi.c                                |    2 
 drivers/tty/serial/8250/8250_dma.c                       |   15 
 drivers/tty/serial/8250/8250_pci.c                       |   17 
 drivers/tty/serial/8250/8250_port.c                      |    6 
 drivers/usb/class/cdc-acm.c                              |   14 
 drivers/usb/class/cdc-acm.h                              |    2 
 drivers/usb/class/cdc-wdm.c                              |    4 
 drivers/usb/class/usbtmc.c                               |    9 
 drivers/usb/common/ulpi.c                                |    5 
 drivers/usb/core/message.c                               |   97 +++-
 drivers/usb/core/phy.c                                   |    8 
 drivers/usb/core/quirks.c                                |    7 
 drivers/usb/gadget/function/f_hid.c                      |   11 
 drivers/usb/gadget/function/f_rndis.c                    |    3 
 drivers/usb/gadget/function/f_subset.c                   |    7 
 drivers/usb/gadget/function/f_tcm.c                      |   14 
 drivers/usb/gadget/function/f_uac1_legacy.c              |   47 +-
 drivers/usb/gadget/function/f_uvc.c                      |   46 +-
 drivers/usb/gadget/function/u_ether.c                    |    8 
 drivers/usb/gadget/function/uvc.h                        |    3 
 drivers/usb/gadget/function/uvc_v4l2.c                   |   13 
 drivers/usb/gadget/udc/dummy_hcd.c                       |   13 
 drivers/usb/host/ehci-brcm.c                             |    4 
 drivers/usb/host/xhci.c                                  |    4 
 drivers/usb/image/mdc800.c                               |    6 
 drivers/usb/misc/uss720.c                                |    2 
 drivers/usb/misc/yurex.c                                 |    2 
 drivers/usb/renesas_usbhs/common.c                       |    9 
 drivers/usb/roles/class.c                                |    7 
 drivers/usb/serial/io_edgeport.c                         |    3 
 drivers/usb/serial/io_usbvend.h                          |    1 
 drivers/usb/serial/option.c                              |    4 
 drivers/xen/privcmd.c                                    |   76 +++
 drivers/xen/xen-acpi-processor.c                         |    7 
 fs/btrfs/disk-io.c                                       |    4 
 fs/btrfs/ioctl.c                                         |    3 
 fs/btrfs/tree-checker.c                                  |    2 
 fs/btrfs/volumes.c                                       |    5 
 fs/ceph/dir.c                                            |   15 
 fs/cifs/cifsencrypt.c                                    |    3 
 fs/cifs/cifsglob.h                                       |   11 
 fs/cifs/connect.c                                        |    1 
 fs/cifs/dir.c                                            |    1 
 fs/cifs/file.c                                           |   17 
 fs/cifs/smb2ops.c                                        |   18 
 fs/cifs/smb2transport.c                                  |    4 
 fs/ext4/extents.c                                        |   22 
 fs/ext4/fast_commit.c                                    |   17 
 fs/ext4/ialloc.c                                         |    6 
 fs/ext4/inode.c                                          |   27 +
 fs/ext4/mballoc.c                                        |   37 -
 fs/ext4/super.c                                          |   13 
 fs/iomap/buffered-io.c                                   |    7 
 fs/jbd2/checkpoint.c                                     |   15 
 fs/nfsd/nfs4xdr.c                                        |    9 
 fs/nfsd/nfsctl.c                                         |   31 -
 fs/nfsd/state.h                                          |   17 
 fs/squashfs/cache.c                                      |    3 
 fs/xfs/xfs_bmap_item.c                                   |    3 
 fs/xfs/xfs_dquot.c                                       |    8 
 fs/xfs/xfs_dquot_item.c                                  |    9 
 fs/xfs/xfs_inode_item.c                                  |    9 
 fs/xfs/xfs_mount.c                                       |    7 
 include/acpi/acpixf.h                                    |  130 +++--
 include/asm-generic/tlb.h                                |   77 +++
 include/linux/dma-mapping.h                              |    4 
 include/linux/fwnode.h                                   |   10 
 include/linux/hugetlb.h                                  |   17 
 include/linux/indirect_call_wrapper.h                    |   18 
 include/linux/irqchip/arm-gic-v3.h                       |    1 
 include/linux/mm_types.h                                 |    2 
 include/linux/netfilter/ipset/ip_set.h                   |    2 
 include/linux/property.h                                 |    5 
 include/linux/security.h                                 |    1 
 include/linux/swapops.h                                  |    6 
 include/linux/usb.h                                      |    8 
 include/net/netfilter/nf_conntrack_timeout.h             |    1 
 include/net/netfilter/nf_tables.h                        |    5 
 include/net/netlink.h                                    |   39 +
 include/net/tc_act/tc_gate.h                             |   33 +
 include/net/udp_tunnel.h                                 |    2 
 include/sound/soc-dai.h                                  |   87 +++
 include/sound/soc.h                                      |    2 
 include/trace/events/kmem.h                              |    8 
 include/uapi/linux/dma-buf.h                             |    1 
 include/uapi/linux/netfilter/nf_conntrack_common.h       |    4 
 include/uapi/sound/asoc.h                                |   22 
 io_uring/io-wq.c                                         |    2 
 io_uring/io_uring.c                                      |   39 +
 kernel/bpf/verifier.c                                    |   11 
 kernel/cgroup/cgroup.c                                   |    1 
 kernel/fork.c                                            |    2 
 kernel/futex/core.c                                      |    3 
 kernel/sched/idle.c                                      |   39 +
 kernel/sysctl.c                                          |    2 
 kernel/time/alarmtimer.c                                 |    2 
 kernel/time/time.c                                       |  171 ++++++-
 kernel/trace/trace.c                                     |    6 
 kernel/trace/trace_events.c                              |   51 +-
 lib/bootconfig.c                                         |    6 
 lib/crypto/chacha.c                                      |    4 
 lib/nlattr.c                                             |   22 
 mm/hugetlb.c                                             |  143 +++---
 mm/mmu_gather.c                                          |   36 +
 mm/rmap.c                                                |   20 
 net/atm/lec.c                                            |   98 ++--
 net/atm/lec.h                                            |    2 
 net/batman-adv/bat_iv_ogm.c                              |    3 
 net/batman-adv/bat_v_elp.c                               |   10 
 net/batman-adv/hard-interface.c                          |    8 
 net/batman-adv/hard-interface.h                          |    1 
 net/batman-adv/translation-table.c                       |    9 
 net/bluetooth/hidp/core.c                                |   16 
 net/bluetooth/l2cap_core.c                               |   55 +-
 net/bluetooth/l2cap_sock.c                               |    3 
 net/bluetooth/mgmt.c                                     |    3 
 net/bluetooth/smp.c                                      |   13 
 net/bridge/br_arp_nd_proxy.c                             |   18 
 net/bridge/br_device.c                                   |    2 
 net/bridge/br_input.c                                    |    2 
 net/can/af_can.c                                         |    4 
 net/can/af_can.h                                         |    2 
 net/can/bcm.c                                            |    1 
 net/can/gw.c                                             |    6 
 net/can/proc.c                                           |    3 
 net/ceph/auth.c                                          |    6 
 net/core/dev.c                                           |    2 
 net/core/rtnetlink.c                                     |    9 
 net/ipv4/esp4.c                                          |   11 
 net/ipv4/icmp.c                                          |    4 
 net/ipv4/tcp_ipv4.c                                      |    5 
 net/ipv6/addrconf.c                                      |    6 
 net/ipv6/datagram.c                                      |   10 
 net/ipv6/esp6.c                                          |   11 
 net/ipv6/icmp.c                                          |    3 
 net/ipv6/ip6_flowlabel.c                                 |    5 
 net/ipv6/ip6_tunnel.c                                    |    7 
 net/ipv6/ndisc.c                                         |    3 
 net/ipv6/netfilter/ip6t_rt.c                             |    4 
 net/ipv6/route.c                                         |   11 
 net/ipv6/seg6_iptunnel.c                                 |   34 +
 net/ipv6/tcp_ipv6.c                                      |    5 
 net/ipv6/xfrm6_output.c                                  |    4 
 net/key/af_key.c                                         |   19 
 net/l2tp/l2tp_ppp.c                                      |   25 -
 net/mac80211/mesh.c                                      |    6 
 net/ncsi/ncsi-aen.c                                      |    3 
 net/ncsi/ncsi-rsp.c                                      |   16 
 net/netfilter/ipset/ip_set_core.c                        |    4 
 net/netfilter/ipset/ip_set_hash_gen.h                    |    2 
 net/netfilter/ipset/ip_set_list_set.c                    |    4 
 net/netfilter/nf_conntrack_h323_asn1.c                   |    4 
 net/netfilter/nf_conntrack_helper.c                      |    2 
 net/netfilter/nf_conntrack_netlink.c                     |   89 ++-
 net/netfilter/nf_conntrack_proto_tcp.c                   |   10 
 net/netfilter/nf_conntrack_sip.c                         |   20 
 net/netfilter/nf_tables_api.c                            |   12 
 net/netfilter/nfnetlink_cthelper.c                       |    8 
 net/netfilter/nfnetlink_log.c                            |   10 
 net/netfilter/nfnetlink_osf.c                            |   13 
 net/netfilter/nfnetlink_queue.c                          |    4 
 net/netfilter/nft_ct.c                                   |   11 
 net/netfilter/nft_payload.c                              |    6 
 net/netfilter/nft_set_pipapo.c                           |   46 +-
 net/netfilter/nft_set_pipapo.h                           |    2 
 net/netfilter/x_tables.c                                 |   23 +
 net/netfilter/xt_CT.c                                    |    4 
 net/netfilter/xt_IDLETIMER.c                             |    6 
 net/netfilter/xt_cgroup.c                                |    6 
 net/netfilter/xt_dccp.c                                  |    4 
 net/netfilter/xt_rateest.c                               |    5 
 net/netfilter/xt_tcpudp.c                                |    6 
 net/netfilter/xt_time.c                                  |    4 
 net/nfc/nci/core.c                                       |   31 +
 net/nfc/nci/data.c                                       |   12 
 net/nfc/rawsock.c                                        |   11 
 net/openvswitch/flow_netlink.c                           |    2 
 net/openvswitch/vport-netdev.c                           |    9 
 net/packet/af_packet.c                                   |    1 
 net/qrtr/af_qrtr.c                                       |   66 +-
 net/rds/ib_rdma.c                                        |    7 
 net/rfkill/core.c                                        |   40 +
 net/rose/af_rose.c                                       |    5 
 net/rxrpc/af_rxrpc.c                                     |    6 
 net/rxrpc/key.c                                          |    2 
 net/sched/act_gate.c                                     |  262 ++++++++---
 net/sched/cls_api.c                                      |    1 
 net/sched/cls_flow.c                                     |   10 
 net/sched/cls_fw.c                                       |   14 
 net/sched/sch_ets.c                                      |   12 
 net/sched/sch_hfsc.c                                     |    4 
 net/sched/sch_teql.c                                     |    1 
 net/smc/smc_rx.c                                         |    9 
 net/sunrpc/cache.c                                       |   26 -
 net/tipc/group.c                                         |    6 
 net/tipc/socket.c                                        |    2 
 net/wireless/core.c                                      |    1 
 net/wireless/radiotap.c                                  |    4 
 net/x25/x25_in.c                                         |    9 
 net/x25/x25_subr.c                                       |    1 
 net/xfrm/xfrm_interface_core.c                           |    2 
 net/xfrm/xfrm_output.c                                   |    7 
 net/xfrm/xfrm_policy.c                                   |    2 
 net/xfrm/xfrm_state.c                                    |    1 
 net/xfrm/xfrm_user.c                                     |    1 
 security/apparmor/apparmorfs.c                           |  228 +++++----
 security/apparmor/include/label.h                        |   16 
 security/apparmor/include/lib.h                          |   12 
 security/apparmor/include/match.h                        |    1 
 security/apparmor/include/policy.h                       |   13 
 security/apparmor/include/policy_ns.h                    |    2 
 security/apparmor/include/policy_unpack.h                |   75 +--
 security/apparmor/label.c                                |   12 
 security/apparmor/match.c                                |   58 +-
 security/apparmor/policy.c                               |   82 +++
 security/apparmor/policy_ns.c                            |    2 
 security/apparmor/policy_unpack.c                        |   58 +-
 security/security.c                                      |    1 
 sound/core/pcm_lib.c                                     |   11 
 sound/core/pcm_native.c                                  |   25 -
 sound/pci/ctxfi/ctdaio.c                                 |    1 
 sound/pci/hda/patch_conexant.c                           |   11 
 sound/pci/hda/patch_realtek.c                            |    1 
 sound/soc/amd/acp3x-rt5682-max9836.c                     |    9 
 sound/soc/fsl/fsl_easrc.c                                |   14 
 sound/soc/intel/catpt/device.c                           |   10 
 sound/soc/intel/catpt/dsp.c                              |    3 
 sound/soc/meson/meson-codec-glue.c                       |    3 
 sound/soc/soc-core.c                                     |  344 +++++++++++----
 sound/soc/soc-dai.c                                      |   63 ++
 sound/soc/soc-dapm.c                                     |   24 -
 sound/soc/soc-pcm.c                                      |   10 
 sound/soc/soc-topology.c                                 |   24 -
 sound/soc/soc-utils.c                                    |   29 +
 sound/soc/sof/topology.c                                 |    6 
 sound/soc/tegra/tegra_pcm.c                              |    3 
 sound/usb/caiaq/device.c                                 |    2 
 sound/usb/endpoint.c                                     |    3 
 sound/usb/validate.c                                     |    2 
 tools/bootconfig/main.c                                  |    7 
 tools/objtool/check.c                                    |    5 
 tools/testing/selftests/net/mptcp/simult_flows.sh        |   11 
 445 files changed, 4907 insertions(+), 2048 deletions(-)

Al Viro (1):
      unshare: fix unshare_fs() handling

Alan Stern (4):
      USB: usbcore: Introduce usb_bulk_msg_killable()
      USB: usbtmc: Use usb_bulk_msg_killable() with user-specified timeouts
      USB: core: Limit the length of unkillable synchronous timeouts
      USB: dummy-hcd: Fix locking/synchronization error

Alban Bedel (1):
      can: mcp251x: fix deadlock in error path of mcp251x_open

Alex Deucher (1):
      drm/radeon: apply state adjust rules to some additional HAINAN vairants

Alex Guo (1):
      media: dvb-frontends: w7090p: fix null-ptr-deref in w7090p_tuner_write_serpar and w7090p_tuner_read_serpar

Alexei Starovoitov (1):
      bpf: Fix regsafe() for pointers to packet

Ali Norouzi (1):
      can: gw: fix OOB heap access in cgw_csum_crc8_rel()

Alok Tiwari (2):
      i40e: fix src IP mask checks and memcpy argument names in cloud filter
      platform/olpc: olpc-xo175-ec: Fix overflow error message to print inlen

Alysa Liu (1):
      drm/amdgpu: Fix use-after-free race in VM acquire

Amadeusz Sławiński (1):
      ASoC: core: Do not call link_exit() on uninitialized rtd objects

Anas Iqbal (2):
      net: dsa: bcm_sf2: fix missing clk_disable_unprepare() in error paths
      Bluetooth: hci_ll: Fix firmware leak on error path

Andrea Mayer (1):
      seg6: separate dst_cache for input and output paths in seg6 lwtunnel

Andrew Lunn (1):
      net: phy: register phy led_triggers during probe to avoid AB-BA deadlock

Andrii Melnychenko (1):
      netfilter: nft_ct: add seqadj extension for natted connections

Andy Lutomirski (2):
      x86/fault: Fold mm_fault_error() into do_user_addr_fault()
      x86/fault: Improve kernel-executing-user-memory handling

Andy Shevchenko (5):
      regmap: Synchronize cache for the page selector
      device property: Retrieve fwnode from of_node via accessor
      device property: Unify access to of_node
      device property: Allow error pointer to be passed to fwnode APIs
      device property: Allow secondary lookup in fwnode_get_next_child_node()

Antoniu Miclaus (4):
      iio: gyro: mpu3050-core: fix pm_runtime error handling
      iio: gyro: mpu3050-i2c: fix pm_runtime error handling
      iio: light: bh1780: fix PM runtime leak on error path
      iio: dac: ad5770r: fix error return in ad5770r_read_raw()

Ard Biesheuvel (1):
      efi/mokvar-table: Avoid repeated map/unmap of the same page

Ariel Silver (1):
      media: dvb-net: fix OOB access in ULE extension header tables

Baokun Li (1):
      ext4: fix iloc.bh leak in ext4_fc_replay_inode() error paths

Bart Van Assche (3):
      wifi: wlcore: Fix a locking bug
      PM: runtime: Fix a race condition related to device removal
      Input: synaptics-rmi4 - fix a locking bug in an error path

Ben Dooks (1):
      ACPI: OSL: fix __iomem type on return from acpi_os_map_generic_address()

Ben Hutchings (1):
      ip6_tunnel: Fix usage of skb_vlan_inet_prepare()

Benoît Sevens (1):
      HID: wacom: fix out-of-bounds read in wacom_intuos_bt_irq

Berk Cem Goksel (1):
      ALSA: caiaq: fix stack out-of-bounds read in init_card

Bjorn Andersson (1):
      remoteproc: sysmon: Correct subsys_name_len type in QMI request

Borislav Petkov (AMD) (1):
      x86/CPU: Fix FPDSS on Zen1

Brian Foster (1):
      ext4: fix dirtyclusters double decrement on fs shutdown

Calvin Owens (1):
      tracing: Fix trace_buf_size= cmdline parameter with sizes >= 2G

Casey Connolly (1):
      ASoC: detect empty DMI strings

Catalin Marinas (1):
      arm64: mm: Add PTE_DIRTY back to PAGE_KERNEL* to fix kexec/hibernation

Cengiz Can (1):
      nvmet-tcp: fix use-before-check of sg in bounds validation

Cezary Rojewski (2):
      ASoC: core: Exit all links before removing their components
      ASoC: Intel: catpt: Fix the device initialization

Chen Ni (2):
      ASoC: amd: acp3x-rt5682-max9836: Add missing error check for clock acquisition
      mtd: rawnand: cadence: Fix error check for dma_alloc_coherent() in cadence_nand_init()

Chintan Vankar (1):
      net: ethernet: ti: am65-cpsw-nuss/cpsw-ale: Fix multicast entry handling in ALE table

Chris Spencer (1):
      iio: chemical: bme680: Fix measurement wait duration calculation

Christian Eggers (3):
      Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU
      Bluetooth: LE L2CAP: Disconnect if sum of payload sizes exceed SDU
      Bluetooth: SMP: make SM/PER/KDU/BI-04-C happy

Christoffer Sandberg (2):
      usb/core/quirks: Add Huawei ME906S-device to wakeup quirk
      Input: i8042 - add TUXEDO InfinityBook Max 16 Gen10 AMD to i8042 quirk table

Christophe JAILLET (1):
      i2c: fsi: Fix a potential leak in fsi_i2c_probe()

Christophe Leroy (CS GROUP) (1):
      powerpc/uaccess: Fix inline assembly for clang build on PPC32

Chuck Lever (2):
      NFSD: Hold net reference for the lifetime of /proc/fs/nfs/exports fd
      RDMA/rw: Fall back to direct SGE on MR pool exhaustion

Claudiu Beznea (4):
      phy: renesas: rcar-gen3-usb2: Fix role detection on unbind/bind
      phy: renesas: rcar-gen3-usb2: Move IRQ request in probe
      phy: renesas: rcar-gen3-usb2: Lock around hardware registers and driver data
      phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power off

Corentin Labbe (1):
      mtd: partitions: redboot: fix style issues

Damien Le Moal (1):
      ata: libata-scsi: refactor ata_scsi_translate()

Daniel Hodges (1):
      wifi: libertas: fix use-after-free in lbs_free_adapter()

Daniel Scally (3):
      media: device property: Return true in fwnode_device_is_available for NULL ops
      device property: Check fwnode->secondary in fwnode_graph_get_next_endpoint()
      device property: Check fwnode->secondary when finding properties

Daniil Dulov (1):
      wifi: cfg80211: cancel rfkill_block work in wiphy_unregister()

Danilo Krummrich (1):
      sh: platform_early: remove pdev->driver_override check

Darrick J. Wong (1):
      iomap: reject delalloc mappings during writeback

Dave Airlie (1):
      nouveau/dpcd: return EBUSY for aux xfer if the device is asleep

David Carlier (2):
      netfilter: ctnetlink: use netlink policy range checks
      net: altera-tse: fix skb leak on DMA mapping error in tse_start_xmit()

David Dull (1):
      netfilter: x_tables: guard option walkers against 1-byte tail reads

David Hildenbrand (Arm) (1):
      mm/hugetlb: fix skipping of unsharing of pmd page tables

David Hildenbrand (Red Hat) (4):
      mm/hugetlb: fix hugetlb_pmd_shared()
      mm/hugetlb: fix two comments related to huge_pmd_unshare()
      mm/rmap: fix two comments related to huge_pmd_unshare()
      mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather

David Howells (1):
      rxrpc: Fix key/keyring checks in setsockopt(RXRPC_SECURITY_KEY/KEYRING)

David Jeffery (1):
      scsi: core: Wake up the error handler when final completions race against each other

David Lechner (1):
      iio: light: vcnl4035: fix scan buffer on big-endian

David Thomson (1):
      xen/acpi-processor: fix _CST detection using undersized evaluation buffer

Davide Caratti (1):
      net/sched: ets: fix divide by zero in the offload path

Davidlohr Bueso (1):
      futex: Clear stale exiting pointer in futex_lock_pi() retry path

Deepanshu Kartikey (3):
      ext4: convert inline data to extents when truncate exceeds inline size
      atm: lec: fix use-after-free in sock_def_readable()
      comedi: dt2815: add hardware detection to prevent crash

Dmitry Torokhov (1):
      Input: uinput - take event lock when submitting FF request "event"

Eric Biggers (3):
      smb: client: Compare MACs in constant time
      net/tcp-md5: Fix MAC comparison to be constant-time
      lib/crypto: chacha: Zeroize permuted_state before it leaves scope

Eric Dumazet (6):
      indirect_call_wrapper: do not reevaluate function pointer
      l2tp: do not use sock_hold() in pppol2tp_session_get_sock()
      af_key: validate families in pfkey_send_migrate()
      ipv6: icmp: clear skb2->cb[] in ip6_err_gen_icmpv6_unreach()
      ip6_tunnel: clear skb2->cb[] in ip4ip6_err()
      ipv6: avoid overflows in ip6_datagram_send_ctl()

Ernestas Kulik (1):
      USB: serial: option: add MeiG Smart SRM825WN

Ethan Nelson-Moore (1):
      net: arcnet: com20020-pci: fix support for 2.5Mbit cards

Ethan Tidmore (5):
      staging: rtl8723bs: fix null dereference in find_network
      iio: gyro: mpu3050: Fix incorrect free_irq() variable
      iio: gyro: mpu3050: Fix irq resource leak
      iio: gyro: mpu3050: Move iio_device_register() to correct location
      iio: gyro: mpu3050: Fix out-of-sequence free_irq()

Fan Wu (2):
      usb: renesas_usbhs: fix use-after-free in ISR during device removal
      net: ethernet: arc: emac: quiesce interrupts before requesting IRQ

Fedor Pchelkin (4):
      net: macb: fix use-after-free access to PTP clock
      net: macb: fix uninitialized rx_fs_lock
      net: macb: fix clk handling on PCI glue driver removal
      net: macb: properly unregister fixed rate clocks

Felix Gu (2):
      mmc: mmci: Fix device_node reference leak in of_get_dml_pipe_index()
      phy: ti: j721e-wiz: Fix device node reference leak in wiz_get_lane_phy_types()

Fernando Fernandez Mancera (2):
      net: bridge: fix nd_tbl NULL dereference when IPv6 is disabled
      net: vxlan: fix nd_tbl NULL dereference when IPv6 is disabled

Filipe Manana (2):
      btrfs: abort transaction on failure to update root in the received subvol ioctl
      btrfs: fix lost error when running device stats on multiple devices fs

Finn Thain (1):
      mtd: Avoid boot crash in RedBoot partition table parser

Florian Westphal (10):
      netfilter: ctnetlink: remove refcounting in expectation dumpers
      netfilter: nft_set_pipapo: split gc into unlink and reclaim phase
      netlink: introduce NLA_POLICY_MAX_BE
      netfilter: nft_payload: reject out-of-range attributes via policy
      netlink: introduce bigendian integer types
      netlink: allow be16 and be32 types in all uint policy checks
      netfilter: nfnetlink_log: account for netlink header size
      netfilter: x_tables: ensure names are nul-terminated
      netfilter: ipset: use nla_strcmp for IPSET_ATTR_NAME attr
      netlink: add nla be16/32 types to minlen array

Francesco Lavra (1):
      iio: imu: st_lsm6dsx: Set FIFO ODR for accelerometer and gyroscope only

Frederic Weisbecker (1):
      net: Handle napi_schedule() calls from non-interrupt

Frej Drejhammar (1):
      USB: serial: io_edgeport: add support for Blackbox IC135A

Frieder Schrempf (1):
      regulator: pca9450: Make IRQ optional

Gabor Juhos (1):
      usb: core: don't power off roothub PHYs if phy_set_mode() fails

Gal Pressman (1):
      net/mlx5e: Fix DMA FIFO desync on error CQE SQ recovery

Greg Kroah-Hartman (15):
      nfc: pn533: properly drop the usb interface reference on disconnect
      net: usb: kaweth: validate USB endpoints
      net: usb: kalmia: validate USB endpoints
      net: usb: pegasus: validate USB endpoints
      can: ems_usb: ems_usb_read_bulk_callback(): check the proper length of a message
      can: ucan: Fix infinite loop from zero-length messages
      HID: Add HID_CLAIMED_INPUT guards in raw_event callbacks missing them
      usb: misc: uss720: properly clean up reference in uss720_probe()
      staging: rtl8723bs: properly validate the data in rtw_get_ie_ex()
      scsi: ses: Handle positive SCSI error from ses_recv_diag()
      drm/ioc32: stop speculation on the drm_compat_ioctl path
      xfrm_user: fix info leak in build_report()
      net: rfkill: prevent unlimited numbers of rfkill events from being created
      s390/syscalls: Add spectre boundary for syscall dispatch table
      Linux 5.10.253

Guanghui Feng (1):
      iommu/vt-d: Fix intel iommu iotlb sync hardlockup and retry

Guangshuo Li (2):
      usb: ulpi: fix double free in ulpi_register_interface() error path
      cpufreq: governor: fix double free in cpufreq_dbs_governor_init() error path

Guenter Roeck (1):
      wifi: wlcore: Return -ENOMEM instead of -EAGAIN if there is not enough headroom

Gui-Dong Han (1):
      hwmon: (max16065) Use READ/WRITE_ONCE to avoid compiler optimization induced race

GuoHan Zhao (1):
      xen/privcmd: unregister xenstore notifier on module exit

Günther Noack (1):
      HID: asus: avoid memory leak in asus_report_fixup()

Hangbin Liu (1):
      bonding: handle BOND_LINK_FAIL, BOND_LINK_BACK as valid link states

Hannes Reinecke (1):
      ata: libata: remove pointless VPRINTK() calls

Hans de Goede (5):
      platform/x86: touchscreen_dmi: Add quirk for y-inverted Goodix touchscreen on SUPI S10
      ACPICA: include/acpi/acpixf.h: Fix indentation
      ACPICA: Allow address_space_handler Install and _REG execution as 2 separate steps
      ACPI: EC: Fix EC address space handler unregistration
      ACPI: EC: Fix ECDT probe ordering issues

Harald Freudenberger (1):
      s390/zcrypt: Enable AUTOSEL_DOM for CCA serialnr sysfs attribute

Heiko Carstens (1):
      s390/xor: Fix xor_xc_2() inline assembly constraints

Heitor Alves de Siqueira (1):
      usb: usbtmc: Flush anchored URBs in usbtmc_release

Helen Koike (2):
      Bluetooth: L2CAP: Fix null-ptr-deref on l2cap_sock_ready_cb
      ext4: reject mount if bigalloc with s_first_data_block != 0

Helge Deller (2):
      parisc: Increase initial mapping to 64 MB with KALLSYMS
      parisc: Fix initial page table creation for boot

Henrique Carvalho (1):
      smb: client: fix iface port assignment in parse_server_interfaces

Huiwen He (1):
      tracing: Fix syscall events activation by ensuring refcount hits zero

Hyunwoo Kim (5):
      netfilter: nfnetlink_queue: fix entry leak in bridge verdict error path
      netfilter: nfnetlink_cthelper: fix OOB read in nfnl_cthelper_dump_table()
      netfilter: ctnetlink: fix use-after-free in ctnetlink_dump_exp_ct()
      Bluetooth: L2CAP: Validate PDU length before reading SDU length in l2cap_ecred_data_rcv()
      Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len infinite loop

Ian Abbott (4):
      comedi: Reinit dev->spinlock between attachments to low-level drivers
      comedi: ni_atmio16d: Fix invalid clean-up after failed attach
      comedi: me_daq: Fix potential overrun of firmware buffer
      comedi: me4000: Fix potential overrun of firmware buffer

Ian Forbes (1):
      drm/vmwgfx: Add seqno waiter for sync_files

Ian Ray (2):
      net: nfc: nci: Fix zero-length proprietary notifications
      NFC: nxp-nci: allow GPIOs to sleep

Ilpo Järvinen (1):
      serial: 8250: Add late synchronize_irq() to shutdown to handle DW UART BUSY

Ira Weiny (1):
      nvdimm/bus: Fix potential use after free in asynchronous initialization

Isaac J. Manjarres (1):
      dma-buf: Include ioctl.h in UAPI header

J. Neuschäfer (1):
      powerpc: 83xx: km83xx: Fix keymile vendor prefix

JP Hein (1):
      USB: core: add NO_LPM quirk for Razer Kiyo Pro webcam

Jakub Kicinski (6):
      ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
      nfc: nci: free skb on nci_transceive early error paths
      nfc: nci: clear NCI_DATA_EXCHANGE before calling completion callback
      nfc: rawsock: cancel tx_work before socket teardown
      nfc: nci: fix circular locking dependency in nci_close_device
      netlink: hide validation union fields from kdoc

Jan Kara (1):
      ext4: make recently_deleted() properly work with lazy itable initialization

Jan Kiszka (1):
      scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT

Jane Chu (1):
      mm/hugetlb: fix copy_hugetlb_page_range() to use ->pt_share_count

Jaskaran Singh (2):
      Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"
      nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()

Jason Gunthorpe (1):
      IB/mthca: Add missed mthca_unmap_user_db() for mthca_create_srq()

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_icm42600: fix odr switch to the same value
      iio: imu: inv_icm42600: fix odr switch when turning buffer off

Jeff Layton (2):
      sunrpc: fix cache_request leak in cache_release
      nfsd: fix heap overflow in NFSv4.0 LOCK replay cache

Jenny Guanni Qu (4):
      netfilter: nft_set_pipapo: fix stack out-of-bounds read in pipapo_drop()
      netfilter: nf_conntrack_h323: fix OOB read in decode_int() CONS case
      netfilter: xt_time: use unsigned int for monthday bit shift
      netfilter: nf_conntrack_h323: check for zero length in DecodeQ931()

Jens Axboe (4):
      media: dvb-core: fix wrong reinitialization of ringbuffer on reopen
      io_uring/io-wq: check IO_WQ_BIT_EXIT inside work run loop
      io_uring/tctx: work around xa_store() allocation error issue
      io_uring/poll: correctly handle io_poll_add() return value on update

Jeongjun Park (3):
      drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection_ioctl()
      drm/exynos: vidi: fix to avoid directly dereferencing user pointer
      drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free

Jian Zhang (1):
      net: ncsi: fix skb leak in error paths

Jiasheng Jiang (1):
      usb: gadget: f_tcm: Fix NULL pointer dereferences in nexus handling

Jiayuan Chen (4):
      atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
      net: ipv6: fix panic when IPv4 route references loopback IPv6 nexthop
      net/rose: fix NULL pointer dereference in rose_transmit_link on reconnect
      net: qrtr: replace qrtr_tx_flow radix_tree with xarray to fix memory leak

Jimmy Hu (1):
      usb: gadget: uvc: fix NULL pointer dereference during unbind race

Jinjiang Tu (1):
      mm/huge_memory: fix folio isn't locked in softleaf_to_folio()

Johan Hovold (4):
      drm/tegra: dsi: fix device leak on probe
      clk: tegra: tegra124-emc: fix device leak on set_rate()
      wifi: rt2x00usb: fix devres lifetime
      mmc: vub300: fix NULL-deref on disconnect

Johannes Berg (1):
      wifi: radiotap: reject radiotap with unknown bits

John Johansen (6):
      apparmor: fix: limit the number of levels of policy namespaces
      apparmor: Fix double free of ns_name in aa_replace_profiles()
      apparmor: fix unprivileged local user can do privileged policy management
      apparmor: fix differential encoding verification
      apparmor: fix race on rawdata dereference
      apparmor: fix race between freeing data and fs accessing it

Jon Hunter (1):
      ASoC: tegra: Fix Master Volume Control

Jonathan Teh (1):
      platform/x86: thinkpad_acpi: Fix errors reading battery thresholds

Josh Law (4):
      lib/bootconfig: fix off-by-one in xbc_verify_tree() unclosed brace error
      lib/bootconfig: fix snprintf truncation check in xbc_node_compose_key_after()
      lib/bootconfig: check bounds before writing in __xbc_open_brace()
      tools/bootconfig: fix fd leak in load_xbc_file() on fstat failure

Josh Poimboeuf (1):
      objtool: Fix Clang jump table detection

Juergen Gross (2):
      xen/privcmd: restrict usage in unprivileged domU
      xen/privcmd: add boot control for restricted usage in domU

Jun Seo (1):
      ALSA: usb-audio: Use correct version for UAC3 header validation

Justin Chen (2):
      net: bcmgenet: increase WoL poll timeout
      usb: ehci-brcm: fix sleep during atomic

Kalesh Singh (1):
      mm/tracing: rss_stat: ensure curr is false from kthread context

Kamal Dasu (4):
      mtd: rawnand: serialize lock/unlock against other NAND operations
      mtd: rawnand: brcmnand: read/write oob during EDU transfer
      mtd: rawnand: brcmnand: move to polling in pio mode on oops write
      mtd: rawnand: brcmnand: skip DMA during panic write

Keenan Dong (1):
      Bluetooth: MGMT: validate LTK enc_size on load

Keith Busch (1):
      nvme-pci: ensure we're polling a polled queue

Kevin Hao (1):
      net: macb: Move devm_{free,request}_irq() out of spin lock area

Kohei Enju (1):
      igc: fix missing update of skb->tail in igc_xmit_frame()

Konrad Dybcio (1):
      thunderbolt: Fix property read in nhi_wake_supported()

Kuen-Han Tsai (3):
      usb: gadget: f_subset: Fix unbalanced refcnt in geth_free
      usb: gadget: f_rndis: Protect RNDIS options with mutex
      usb: gadget: u_ether: Fix race between gether_disconnect and eth_stop

Kuninori Morimoto (5):
      ASoC: don't indicate error message for snd_soc_[pcm_]dai_xxx()
      ASoC: soc-core: move snd_soc_runtime_set_dai_fmt() to upside
      ASoC: soc-core: add snd_soc_runtime_get_dai_fmt()
      ASoC: soc-core: accept zero format at snd_soc_runtime_set_dai_fmt()
      ASoC: soc-core: don't use discriminatory terms on snd_soc_runtime_get_dai_fmt()

Lars Ellenberg (1):
      drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()

Lee Jones (1):
      HID: multitouch: Check to ensure report responses match the request

Leif Skunberg (1):
      platform/x86: intel-hid: Enable 5-button array on ThinkPad X1 Fold 16 Gen 1

Li Chen (1):
      ext4: publish jinode after initialization

Liao Chang (1):
      cpufreq: governor: Free dbs_data directly when gov->init() fails

Loic Poulain (2):
      net: qrtr: Add GFP flags parameter to qrtr_alloc_ctrl_packet
      net: qrtr: Release distant nodes along the bridge node

Long Li (2):
      xfs: ensure dquot item is deleted from AIL only after log shutdown
      xfs: fix integer overflow in bmap intent sort comparator

Luca Leonardo Scorcia (1):
      pinctrl: mediatek: common: Fix probe failure for devices without EINT

Luiz Augusto von Dentz (2):
      Bluetooth: HIDP: Fix possible UAF
      Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ

Luka Gejak (1):
      staging: rtl8723bs: fix potential out-of-bounds read in rtw_restruct_wmm_ie

Lukas Johannes Möller (3):
      Bluetooth: L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
      Bluetooth: L2CAP: Validate L2CAP_INFO_RSP payload length before access
      netfilter: nf_conntrack_sip: fix Content-Length u32 truncation in sip_help_tcp()

Lukas Schmid (1):
      iio: potentiometer: mcp4131: fix double application of wiper shift

Luke Wang (1):
      mmc: sdhci: fix timing selection for 1-bit bus width

Maciej W. Rozycki (1):
      MIPS: Fix the GCC version check for `__multi3' workaround

Manivannan Sadhasivam (1):
      Revert "PCI: Enable ACS after configuring IOMMU for OF platforms"

Marc Buerg (1):
      sysctl: fix uninitialized variable in proc_do_large_bitmap

Marc Kleine-Budde (2):
      can: gs_usb: gs_can_open(): always configure bitrates before starting device
      spi: spi-fsl-lpspi: fix teardown order issue (UAF)

Marc Zyngier (2):
      usb: cdc-acm: Restore CAP_BRK functionnality to CH343
      irqchip/gic-v3-its: Limit number of per-device MSIs to the range the ITS supports

Marek Vasut (3):
      dmaengine: xilinx: xilinx_dma: Fix dma_device directions
      dmaengine: xilinx: xilinx_dma: Fix residue calculation for cyclic DMA
      dmaengine: xilinx: xilinx_dma: Fix unmasked residue subtraction

Mark Brown (2):
      ASoC: fsl_easrc: Fix event generation in fsl_easrc_iec958_set_reg()
      ASoC: fsl_easrc: Fix event generation in fsl_easrc_iec958_put_bits()

Mark Harmstone (2):
      btrfs: fix incorrect key offset in error message in check_dev_extent_item()
      btrfs: fix super block offset in error message in btrfs_validate_super()

Martin Roukala (né Peres) (1):
      serial: 8250_pci: add support for the AX99100

Martin Schiller (2):
      net/x25: Fix potential double free of skb
      net/x25: Fix overflow when accumulating packets

Massimiliano Pellizzer (5):
      apparmor: validate DFA start states are in bounds in unpack_pdb
      apparmor: fix memory leak in verify_header
      apparmor: replace recursive profile removal with iterative approach
      apparmor: fix side-effect bug in match_char() macro usage
      apparmor: fix missing bounds check on DEFAULT table in verify_dfa()

Mathias Krause (1):
      scsi: lpfc: Properly set WC for DPP mapping

Matt Vollrath (1):
      e1000/e1000e: Fix leak in DMA error cleanup

Matthew Schwartz (1):
      mmc: sdhci-pci-gli: fix GL9750 DMA write corruption

Max Kellermann (1):
      ceph: fix i_nlink underrun during async unlink

Maíra Canal (2):
      pmdomain: bcm: bcm2835-power: Fix broken reset status read
      pmdomain: bcm: bcm2835-power: Increase ASB control timeout

Mehul Rao (2):
      tipc: fix divide-by-zero in tipc_sk_filter_connect()
      ALSA: pcm: fix use-after-free on linked stream runtime in snd_pcm_drain()

Miao Li (1):
      usb: quirks: add DELAY_INIT quirk for another Silicon Motion flash drive

Miaohe Lin (1):
      mm/hugetlb: make detecting shared pte more reliable

Michael Zimmermann (1):
      usb: gadget: f_hid: move list and spinlock inits from bind to alloc

Miguel Ojeda (1):
      dma-mapping: add missing `inline` for `dma_free_attrs`

Mike Rapoport (Microsoft) (2):
      x86/efi: defer freeing of boot services memory
      x86/efi: efi_unmap_boot_services: fix calculation of ranges_to_free size

Mikhail Gavrilov (1):
      Input: uinput - fix circular locking dependency with ff-core

Milos Nikic (1):
      jbd2: gracefully abort on checkpointing state corruptions

Natalie Vock (1):
      drm/amd/display: Use GFP_ATOMIC in dc_create_stream_for_sink

Nikola Z. Ivanov (1):
      net: usb: aqc111: Do not perform PM inside suspend callback

Norbert Szetei (1):
      crypto: af-alg - fix NULL pointer dereference in scatterwalk

Oleh Konko (3):
      Bluetooth: SMP: derive legacy responder STK authentication from MITM state
      Bluetooth: SMP: force responder MITM requirements before building the pairing response
      tipc: fix bc_ackers underflow on duplicate GRP_ACK_MSG

Oleksij Rempel (3):
      net: usb: lan78xx: fix silent drop of packets with checksum errors
      net: usb: lan78xx: skip LTM configuration for LAN7850
      iio: dac: ds4424: reject -128 RAW value

Oliver Hartkopp (2):
      can: bcm: fix locking for bcm_op runtime updates
      can: statistics: add missing atomic access in hot path

Oliver Neukum (4):
      usb: yurex: fix race in probe
      usb: class: cdc-wdm: fix reordering issue in read code path
      usb: mdc800: handle signal and read racing
      cdc-acm: new quirk for EPSON HMD

Oswald Buddenhagen (1):
      ALSA: pcm: fix wait_time calculations

Pablo Neira Ayuso (4):
      netfilter: nft_ct: drop pending enqueued packets on removal
      netfilter: xt_CT: drop pending enqueued packets on template removal
      netfilter: x_tables: restrict xt_check_match/xt_check_target extensions for NFPROTO_ARP
      netfilter: nf_tables: reject immediate NF_QUEUE verdict

Paolo Abeni (2):
      selftests: mptcp: more stable simult_flows tests
      ipv6: prevent possible UaF in addrconf_permanent_addr()

Paolo Valerio (1):
      net: macb: use the current queue number for stats

Paul Chaignon (1):
      bpf: Forget ranges when refining tnum after JSET

Paul Moses (1):
      net/sched: act_gate: snapshot parameters with RCU on replace

Paul Walmsley (1):
      riscv: kgdb: fix several debug register assignment bugs

Paulo Alcantara (1):
      smb: client: fix atomic open with O_DIRECT & O_SYNC

Peng Fan (1):
      regulator: pca9450: Correct interrupt type

Pengpeng Hou (4):
      Bluetooth: btusb: clamp SCO altsetting table indices
      NFC: pn533: bound the UART receive buffer
      nfc: pn533: allocate rx skb before consuming bytes
      net: qualcomm: qca_uart: report the consumed byte on RX skb allocation failure

Peter Wang (1):
      scsi: ufs: core: Move link recovery for hibern8 exit failure to wl_resume

Phillip Lougher (1):
      Squashfs: check metadata block offset is within range

Pierre-Louis Bossart (1):
      ASoC: topology: use inclusive language for bclk and fsync

Piotr Mazek (1):
      ACPI: PM: Save NVS memory on Lenovo G70-35

Qi Tang (3):
      net/smc: fix double-free of smc_spd_priv when tee() duplicates splice pipe buffer
      netfilter: nf_conntrack_helper: pass helper to expect cleanup
      netfilter: ctnetlink: zero expect NAT fields when CTA_EXPECT_NAT absent

Qingye Zhao (1):
      cgroup: fix race between task migration and iteration

Radhey Shyam Pandey (1):
      dmaengine: xilinx_dma: Program interrupt delay timeout

Rafael J. Wysocki (2):
      sched: idle: Make skipping governor callbacks more consistent
      sched: idle: Consolidate the handling of two special cases

Raju Rangoju (1):
      amd-xgbe: fix sleep while atomic on suspend/resume

Randy Dunlap (1):
      time: add kernel-doc in time.c

Raphael Zimmer (1):
      libceph: Fix potential out-of-bounds access in ceph_handle_auth_reply()

Raul E Rangel (1):
      serial: 8250: Fix TX deadlock when using DMA

Ren Wei (1):
      netfilter: ip6t_rt: reject oversized addrnr in rt_mt6_check()

Richard Genoud (1):
      soc: fsl: qbman: fix race condition in qman_destroy_fq

Romain Sioen (1):
      HID: mcp2221: cancel last I2C command on read error

Ruide Cao (1):
      batman-adv: reject oversized global TT response buffers

Sabrina Dubroca (3):
      xfrm: call xdo_dev_state_delete during state update
      esp: fix skb leak with espintcp and async crypto
      rtnetlink: count IFLA_INFO_SLAVE_KIND in if_nlmsg_size

Saeed Mahameed (1):
      net/mlx5: Avoid "No data available" when FW version queries fail

Samasth Norway Ananda (1):
      drm/i915/gmbus: fix spurious timeout on 512-byte burst reads

Sanman Pradhan (5):
      hwmon: (pmbus/isl68137) Fix unchecked return value and use sysfs_emit()
      hwmon: (adm1177) fix sysfs ABI violation and current unit conversion
      hwmon: (pxe1610) Check return value of page-select write in probe
      hwmon: (occ) Fix missing newline in occ_show_extended()
      hwmon: (occ) Fix division by zero in occ_show_power_1()

Saravana Kannan (1):
      device property: Add fwnode_is_ancestor_of() and fwnode_get_next_parent_dev()

Sasha Levin (3):
      Revert "drm/vmwgfx: Add seqno waiter for sync_files"
      Revert "scsi: core: Wake up the error handler when final completions race against each other"
      Revert "media: dvb-frontends: w7090p: fix null-ptr-deref in w7090p_tuner_write_serpar and w7090p_tuner_read_serpar"

Sean Christopherson (1):
      KVM: SVM: Initialize AVIC VMCB fields if AVIC is enabled with in-kernel APIC

Sebastian Urban (1):
      usb: gadget: dummy_hcd: fix premature URB completion when ZLP follows partial transfer

Shashank Balaji (1):
      x86/apic: Disable x2apic on resume if the kernel expects so

Shawn Guo (2):
      arm64: dts: hisilicon: poplar: Correct PCIe reset GPIO polarity
      arm64: dts: hisilicon: hi3798cv200: Add missing dma-ranges

Shuangpeng Bai (1):
      serial: caif: hold tty->link reference in ldisc_open and ser_release

Sofia Schneider (1):
      ACPI: OSI: Add DMI quirk for Acer Aspire One D255

Steffen Klassert (1):
      xfrm: Fix the usage of skb->sk

Steven Rostedt (1):
      time/jiffies: Mark jiffies_64_to_clock_t() notrace

Sungwoo Kim (1):
      nvme-pci: Fix slab-out-of-bounds in nvme_dbbuf_set

Suraj Gupta (1):
      net: xilinx: axienet: Correct BD length masks to match AXIDMA IP spec

Sven Eckelmann (1):
      batman-adv: Avoid double-rtnl_lock ELP metric worker

Taegu Ha (1):
      usb: gadget: f_uac1_legacy: validate control request size

Takashi Iwai (4):
      ALSA: usb-audio: Cap the packet size pre-calculations
      ALSA: hda/conexant: Add quirk for HP ZBook Studio G4
      ALSA: hda/conexant: Fix headphone jack handling on Acer Swift SF314
      ALSA: ctxfi: Fix missing SPDIFI1 index handling

Thomas Bogendoerfer (1):
      tg3: Fix race for querying speed/duplex

Thomas Fourier (2):
      drm/msm: Fix dma_free_attrs() buffer size
      wifi: brcmsmac: Fix dma_free_coherent() size

Thomas Weißschuh (1):
      ARM: clean up the memset64() C wrapper

Thomas Zimmermann (1):
      drm/ast: dp501: Fix initialization of SCU2C

Thorsten Blum (2):
      smb: client: Don't log plaintext credentials in cifs_set_cifscreds
      crypto: atmel-sha204a - Fix OOM ->tfm_count leak

Toke Høiland-Jørgensen (1):
      net: openvswitch: Avoid releasing netdev before teardown completes

Tom Rix (1):
      nfsd: define exports_proc_ops with CONFIG_PROC_FS

Tomas Henzl (1):
      scsi: ses: Fix devices attaching to different hosts

Tomi Valkeinen (1):
      dmaengine: xilinx_dma: Fix reset related timeout with two-channel AXIDMA

Tuan Do (1):
      netfilter: nft_ct: fix use-after-free in timeout object destroy

Tyllis Xu (2):
      scsi: ibmvfc: Fix OOB access in ibmvfc_discover_targets_done()
      net: stmmac: fix integer underflow in chain mode

Uzair Mughal (1):
      ALSA: hda/realtek: Add headset jack quirk for Thinkpad X390

Vahagn Vardanian (1):
      wifi: mac80211: fix NULL pointer dereference in mesh_rx_csa_frame()

Vasily Gorbik (1):
      s390/barrier: Make array_index_mask_nospec() __always_inline

Viresh Kumar (1):
      cpufreq: conservative: Reset requested_freq on limits change

Wang Qing (1):
      ARM: OMAP2+: add missing of_node_put before break and return

Wanquan Zhong (1):
      USB: serial: option: add support for Rolling Wireless RW135R-GL

Wei Fang (1):
      net: enetc: fix the output issue of 'ethtool --show-ring'

Weiming Shi (6):
      net/sched: teql: fix NULL pointer dereference in iptunnel_xmit on TEQL slave xmit
      nfnetlink_osf: validate individual option lengths in fingerprints
      icmp: fix NULL pointer dereference in icmp_tag_validation()
      netfilter: nfnetlink_log: fix uninitialized padding leak in NFULA_PAYLOAD
      netfilter: nf_conntrack_sip: fix use of uninitialized rtp_addr in process_sdp
      rds: ib: reject FRMR registration before IB connection is established

Wentao Liang (1):
      ARM: omap2: Fix reference count leaks in omap_control_init()

Wenyuan Li (1):
      can: hi311x: hi3110_open(): add check for hi3110_power_enable() return value

Xiang Mei (6):
      wifi: mac80211: fix NULL deref in mesh_matches_local()
      udp_tunnel: fix NULL deref caused by udp_sock_create6 when CONFIG_IPV6=n
      net: bonding: fix NULL deref in bond_debug_rlb_hash_show
      net/sched: sch_hfsc: fix divide-by-zero in rtsc_min()
      net/sched: cls_fw: fix NULL pointer dereference on shared blocks
      net/sched: cls_flow: fix NULL pointer dereference on shared blocks

Xu Yang (1):
      usb: roles: get usb role switch from parent only for usb-b-connector

Yang Yang (5):
      openvswitch: validate MPLS set/set_masked payload length
      bridge: br_nd_send: linearize skb before parsing ND options
      bridge: br_nd_send: validate ND option lengths
      vxlan: validate ND option lengths in vxlan_na_create
      batman-adv: avoid OGM aggregation when skb tailroom is insufficient

Yang Yingliang (1):
      device property: fix of node refcount leak in fwnode_graph_get_next_endpoint()

Yasuaki Torimaru (1):
      wifi: wilc1000: fix u8 overflow in SSID scan buffer size calculation

Ye Bin (1):
      ext4: avoid allocate block from corrupted group in ext4_mb_find_by_goal()

Yifan Wu (1):
      netfilter: ipset: drop logically empty buckets in mtype_del

Yihang Li (1):
      scsi: scsi_transport_sas: Fix the maximum channel scanning issue

Yochai Eisenrich (3):
      net: fix fanout UAF in packet_release() via NETDEV_UP race
      net: ipv6: ndisc: fix ndisc_ra_useropt to initialize nduseropt_padX fields to zero to prevent an info-leak
      net: sched: cls_api: fix tc_chain_fill_node to initialize tcm_info to zero to prevent an info-leak

Yuan Tan (1):
      netfilter: xt_IDLETIMER: reject rev0 reuse of ALARM timer labels

Yuchan Nam (1):
      media: mc, v4l2: serialize REINIT and REQBUFS with req_queue_mutex

Yufan Chen (1):
      net: ftgmac100: fix ring allocation unwind on open failure

Yuto Ohnuki (2):
      xfs: save ailp before dropping the AIL lock in push callbacks
      xfs: stop reclaim before pushing AIL during unmount

Zhan Xusheng (1):
      alarmtimer: Fix argument order in alarm_timer_forward()

Zhang Yi (2):
      ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before submitting I/O
      ext4: drop extent cache when splitting extent fails

Zhengchuan Liang (1):
      net: ipv6: flowlabel: defer exclusive option free until RCU teardown

Zilin Guan (1):
      usb: xhci: Fix memory leak in xhci_disable_slot()

Ziyi Guo (1):
      usb: image: mdc800: kill download URB on timeout

Zoltan Illes (1):
      Input: xpad - add support for Razer Wolverine V3 Pro

Zqiang (1):
      ext4: fix the might_sleep() warnings in kvfree()

matteo.cotifava (2):
      ASoC: soc-core: drop delayed_work_pending() check before flush
      ASoC: soc-core: flush delayed work before removing DAIs and widgets

xietangxin (1):
      virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false


