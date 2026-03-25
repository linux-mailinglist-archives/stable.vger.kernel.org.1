Return-Path: <stable+bounces-230300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Am5KyG3w2litgQAu9opvQ
	(envelope-from <stable+bounces-230300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:21:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B3E322CD3
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2750930965FA
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7F33A16A8;
	Wed, 25 Mar 2026 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LG6o3mcE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6543D39DBFD;
	Wed, 25 Mar 2026 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433779; cv=none; b=GzB9YCYvm15qtcv8Mzeu/iBdTijzpBkQ4NNt6Uc1ReLemt3it8CuAvbWjV1mKAzQu3Cpo0YNTOeL7ZbHrSK+K+dd1706s6oaKVjfPHljKksNKxiRA1bV0dvVCEgSJdfQm6x6tVKpwO83jZiEtlP4+pH0EZu0yKetIBavgwhMzoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433779; c=relaxed/simple;
	bh=jE4RtYY3BmDblzNc3TyAquIwaJayxGVPbQmWYZA0r4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hSU8esPZ7ESWQGnu7h9EadJ7zbguo8Q59qosclz3HG5aU5vW3gUTD7LCkf8jZc4HlVwkI9SIajgUcxqyZ3Ws1aa/4HDl+1oDm2bBXg10PGagYLlzXoypBZ3cg35w6CbAVfFUJ/WHjtK2z0ey+jKxAc2gkgjvHDE7Ga4vJlOuokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LG6o3mcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED74C4CEF7;
	Wed, 25 Mar 2026 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774433779;
	bh=jE4RtYY3BmDblzNc3TyAquIwaJayxGVPbQmWYZA0r4E=;
	h=From:To:Cc:Subject:Date:From;
	b=LG6o3mcETdm8WgdyWsr9SXSxdJBN19Jp3nv0NDlcVDmCS94wfsPAD8UfngmmrDdGH
	 H5SKm3qKcVbAkLS5Eg30WtnpLTj8wxxIWtYSH89RMumEVchLWuYaRdMrY+iVL1rcv5
	 N/ga/pcDxuTSQNT+LN6ZltVr1opBvvtKNz43Kr2g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.130
Date: Wed, 25 Mar 2026 11:15:48 +0100
Message-ID: <2026032549-depravity-oxford-4c85@gregkh>
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
	TAGGED_FROM(0.00)[bounces-230300-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 89B3E322CD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.6.130 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/hwmon/aht10.rst                                      |   10 
 Makefile                                                           |   10 
 arch/arm/include/asm/string.h                                      |   14 
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi                |    1 
 arch/arm64/boot/dts/rockchip/rk3568.dtsi                           |    4 
 arch/arm64/boot/dts/rockchip/rk356x.dtsi                           |    2 
 arch/arm64/include/asm/pgtable-prot.h                              |   10 
 arch/arm64/include/asm/pgtable.h                                   |    7 
 arch/arm64/mm/mmu.c                                                |   92 -
 arch/loongarch/include/asm/uaccess.h                               |   14 
 arch/parisc/include/asm/pgtable.h                                  |    2 
 arch/parisc/kernel/cache.c                                         |    4 
 arch/parisc/kernel/head.S                                          |    7 
 arch/parisc/kernel/setup.c                                         |   20 
 arch/powerpc/include/asm/uaccess.h                                 |    2 
 arch/powerpc/platforms/83xx/km83xx.c                               |    4 
 arch/riscv/kernel/traps.c                                          |    5 
 arch/s390/include/asm/processor.h                                  |    2 
 arch/s390/lib/xor.c                                                |    4 
 arch/x86/boot/compressed/sev.c                                     |    5 
 arch/x86/include/asm/efi.h                                         |    2 
 arch/x86/include/asm/msr-index.h                                   |    5 
 arch/x86/kernel/apic/apic.c                                        |    6 
 arch/x86/kernel/apic/x2apic_uv_x.c                                 |   18 
 arch/x86/kernel/sev-shared.c                                       |  104 +
 arch/x86/kernel/sev.c                                              |    5 
 arch/x86/kernel/uprobes.c                                          |   24 
 arch/x86/kvm/svm/avic.c                                            |   30 
 arch/x86/kvm/svm/svm.c                                             |   11 
 arch/x86/kvm/vmx/vmx.c                                             |    2 
 arch/x86/kvm/x86.c                                                 |   69 -
 arch/x86/kvm/x86.h                                                 |   15 
 arch/x86/platform/efi/efi.c                                        |    2 
 arch/x86/platform/efi/quirks.c                                     |   55 -
 drivers/acpi/acpi_processor.c                                      |   15 
 drivers/acpi/osi.c                                                 |   13 
 drivers/acpi/osl.c                                                 |    2 
 drivers/acpi/sleep.c                                               |    8 
 drivers/base/power/runtime.c                                       |    1 
 drivers/base/property.c                                            |   27 
 drivers/block/drbd/drbd_actlog.c                                   |   53 
 drivers/block/drbd/drbd_interval.h                                 |    5 
 drivers/block/drbd/drbd_req.c                                      |    3 
 drivers/bluetooth/btqca.c                                          |    2 
 drivers/bus/omap-ocp2scp.c                                         |   19 
 drivers/cache/ax45mp_cache.c                                       |    4 
 drivers/clk/tegra/clk-tegra124-emc.c                               |    2 
 drivers/cpuidle/cpuidle.c                                          |   10 
 drivers/crypto/atmel-sha204a.c                                     |    5 
 drivers/dma/mmp_pdma.c                                             |    6 
 drivers/firmware/arm_scpi.c                                        |    5 
 drivers/firmware/efi/mokvar-table.c                                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                   |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                         |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                            |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c                     |   20 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                              |   21 
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c                            |    9 
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c                            |    3 
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c                            |    3 
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c                          |    3 
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c                          |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                  |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c           |    1 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c     |    2 
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c                    |    2 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c              |    2 
 drivers/gpu/drm/amd/display/dc/dm_services_types.h                 |    2 
 drivers/gpu/drm/amd/include/dm_pp_interface.h                      |    1 
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c                       |   67 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h                   |    2 
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c                         |    4 
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c                     |    6 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                         |   69 -
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                   |   11 
 drivers/gpu/drm/bridge/samsung-dsim.c                              |   25 
 drivers/gpu/drm/bridge/ti-sn65dsi83.c                              |   13 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                              |  118 ++
 drivers/gpu/drm/drm_file.c                                         |    5 
 drivers/gpu/drm/drm_mode_config.c                                  |    9 
 drivers/gpu/drm/exynos/exynos_drm_drv.h                            |    1 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                           |   72 +
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c                          |   12 
 drivers/gpu/drm/i915/gt/intel_engine_cs.c                          |    3 
 drivers/gpu/drm/logicvc/logicvc_drm.c                              |    4 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                 |   62 +
 drivers/gpu/drm/msm/msm_gpummu.c                                   |    2 
 drivers/gpu/drm/nouveau/nouveau_connector.c                        |    3 
 drivers/gpu/drm/radeon/si_dpm.c                                    |    4 
 drivers/gpu/drm/scheduler/sched_main.c                             |    1 
 drivers/gpu/drm/solomon/ssd130x.c                                  |  186 ++-
 drivers/gpu/drm/solomon/ssd130x.h                                  |    5 
 drivers/gpu/drm/tegra/dsi.c                                        |    6 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                            |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c                         |    9 
 drivers/hid/hid-cmedia.c                                           |    2 
 drivers/hid/hid-creative-sb0540.c                                  |    2 
 drivers/hid/hid-zydacron.c                                         |    2 
 drivers/hwmon/Kconfig                                              |    6 
 drivers/hwmon/aht10.c                                              |   21 
 drivers/hwmon/it87.c                                               |    5 
 drivers/hwmon/max16065.c                                           |   26 
 drivers/hwmon/pmbus/isl68137.c                                     |    7 
 drivers/hwmon/pmbus/mp2975.c                                       |    2 
 drivers/hwmon/pmbus/q54sj108a2.c                                   |   19 
 drivers/i2c/busses/i2c-cp2615.c                                    |    5 
 drivers/i2c/busses/i2c-fsi.c                                       |    1 
 drivers/i2c/busses/i2c-pxa.c                                       |   17 
 drivers/i3c/master/dw-i3c-master.c                                 |    4 
 drivers/i3c/master/mipi-i3c-hci/cmd.h                              |    1 
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c                           |    2 
 drivers/i3c/master/mipi-i3c-hci/cmd_v2.c                           |    2 
 drivers/i3c/master/mipi-i3c-hci/core.c                             |    6 
 drivers/i3c/master/mipi-i3c-hci/dma.c                              |    4 
 drivers/iio/chemical/bme680_core.c                                 |    2 
 drivers/iio/chemical/sps30_i2c.c                                   |    2 
 drivers/iio/chemical/sps30_serial.c                                |    2 
 drivers/iio/dac/ds4424.c                                           |    2 
 drivers/iio/frequency/adf4377.c                                    |    2 
 drivers/iio/gyro/mpu3050-core.c                                    |   18 
 drivers/iio/gyro/mpu3050-i2c.c                                     |    3 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                  |    2 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                   |    2 
 drivers/iio/industrialio-buffer.c                                  |    6 
 drivers/iio/light/bh1780.c                                         |    4 
 drivers/iio/potentiometer/mcp4131.c                                |    2 
 drivers/infiniband/hw/irdma/verbs.c                                |    2 
 drivers/infiniband/hw/mthca/mthca_provider.c                       |    5 
 drivers/iommu/intel/dmar.c                                         |    3 
 drivers/irqchip/irq-gic-v3-its.c                                   |    4 
 drivers/irqchip/irq-sifive-plic.c                                  |    7 
 drivers/mailbox/mailbox.c                                          |  150 +-
 drivers/md/dm-verity-fec.c                                         |    4 
 drivers/md/dm-verity-fec.h                                         |    3 
 drivers/media/dvb-core/dmxdev.c                                    |    4 
 drivers/media/dvb-core/dvb_net.c                                   |    3 
 drivers/memory/mtk-smi.c                                           |   13 
 drivers/mfd/omap-usb-host.c                                        |   11 
 drivers/mfd/qcom-pm8xxx.c                                          |   14 
 drivers/mmc/host/mmci_qcom_dml.c                                   |    1 
 drivers/mmc/host/sdhci-pci-gli.c                                   |    9 
 drivers/mmc/host/sdhci.c                                           |    9 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                           |    6 
 drivers/mtd/nand/raw/cadence-nand-controller.c                     |    2 
 drivers/mtd/nand/raw/nand_base.c                                   |   14 
 drivers/mtd/nand/raw/pl35x-nand-controller.c                       |    3 
 drivers/mtd/parsers/redboot.c                                      |    6 
 drivers/net/arcnet/com20020-pci.c                                  |   16 
 drivers/net/bonding/bond_debugfs.c                                 |   16 
 drivers/net/bonding/bond_main.c                                    |   19 
 drivers/net/bonding/bond_options.c                                 |    2 
 drivers/net/caif/caif_serial.c                                     |    3 
 drivers/net/can/spi/hi311x.c                                       |    5 
 drivers/net/can/spi/mcp251x.c                                      |   15 
 drivers/net/can/usb/ems_usb.c                                      |    7 
 drivers/net/can/usb/etas_es58x/es58x_core.c                        |    8 
 drivers/net/can/usb/f81604.c                                       |   45 
 drivers/net/can/usb/gs_usb.c                                       |   22 
 drivers/net/can/usb/ucan.c                                         |    2 
 drivers/net/dsa/bcm_sf2.c                                          |    8 
 drivers/net/dsa/microchip/ksz_ptp.c                                |   11 
 drivers/net/dsa/realtek/rtl8365mb.c                                |    5 
 drivers/net/ethernet/amd/xgbe/xgbe-common.h                        |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                           |   14 
 drivers/net/ethernet/amd/xgbe/xgbe-main.c                          |    1 
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c                        |   82 +
 drivers/net/ethernet/amd/xgbe/xgbe.h                               |    7 
 drivers/net/ethernet/arc/emac_main.c                               |   11 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                          |   25 
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                          |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                      |    7 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c                 |    2 
 drivers/net/ethernet/cadence/macb.h                                |    7 
 drivers/net/ethernet/cadence/macb_main.c                           |  184 +++
 drivers/net/ethernet/cadence/macb_ptp.c                            |    4 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c                |    7 
 drivers/net/ethernet/google/gve/gve.h                              |    1 
 drivers/net/ethernet/google/gve/gve_main.c                         |    5 
 drivers/net/ethernet/google/gve/gve_tx_dqo.c                       |   54 -
 drivers/net/ethernet/intel/e1000/e1000_main.c                      |    2 
 drivers/net/ethernet/intel/e1000e/defines.h                        |    1 
 drivers/net/ethernet/intel/e1000e/ich8lan.c                        |    9 
 drivers/net/ethernet/intel/e1000e/netdev.c                         |    2 
 drivers/net/ethernet/intel/i40e/i40e_main.c                        |   41 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                        |    5 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                 |   14 
 drivers/net/ethernet/intel/iavf/iavf_main.c                        |    9 
 drivers/net/ethernet/intel/ice/ice_common.c                        |   13 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                       |   35 
 drivers/net/ethernet/intel/igc/igc_main.c                          |    7 
 drivers/net/ethernet/intel/ixgbevf/vf.c                            |    3 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                    |    4 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c                |   40 
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c                  |   27 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c            |  468 ++------
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                        |   15 
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c           |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h           |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c   |   50 
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c                  |   23 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                  |   30 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                  |    3 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c         |   18 
 drivers/net/ethernet/microsoft/mana/hw_channel.c                   |    6 
 drivers/net/ethernet/microsoft/mana/mana_en.c                      |   23 
 drivers/net/ethernet/stmicro/stmmac/common.h                       |    1 
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c                  |    4 
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c               |    9 
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                       |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                  |   54 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c              |    8 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                           |    2 
 drivers/net/ethernet/ti/cpsw_ale.c                                 |    9 
 drivers/net/mctp/mctp-i2c.c                                        |    1 
 drivers/net/phy/phy_device.c                                       |   25 
 drivers/net/phy/sfp.c                                              |   62 -
 drivers/net/usb/aqc111.c                                           |   12 
 drivers/net/usb/cdc_ncm.c                                          |   10 
 drivers/net/usb/kalmia.c                                           |    7 
 drivers/net/usb/kaweth.c                                           |   13 
 drivers/net/usb/lan78xx.c                                          |   10 
 drivers/net/usb/lan78xx.h                                          |    3 
 drivers/net/usb/pegasus.c                                          |   13 
 drivers/net/vxlan/vxlan_core.c                                     |    5 
 drivers/net/wireless/marvell/libertas/main.c                       |    4 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c               |    1 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                    |    1 
 drivers/net/wireless/st/cw1200/pm.c                                |    2 
 drivers/net/wireless/ti/wlcore/main.c                              |    4 
 drivers/net/wireless/ti/wlcore/tx.c                                |    2 
 drivers/nfc/nxp-nci/i2c.c                                          |    4 
 drivers/nfc/pn533/usb.c                                            |    1 
 drivers/nvdimm/bus.c                                               |    5 
 drivers/nvme/host/pci.c                                            |    8 
 drivers/nvme/host/pr.c                                             |   10 
 drivers/pci/iov.c                                                  |    7 
 drivers/pci/pci.c                                                  |   85 +
 drivers/pci/pci.h                                                  |    2 
 drivers/pci/probe.c                                                |   32 
 drivers/pci/quirks.c                                               |   15 
 drivers/pci/setup-bus.c                                            |   30 
 drivers/pci/setup-res.c                                            |   72 -
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c                           |    5 
 drivers/pinctrl/pinctrl-equilibrium.c                              |   31 
 drivers/platform/x86/amd/pmc/pmc.c                                 |    3 
 drivers/platform/x86/amd/pmc/pmc.h                                 |    1 
 drivers/platform/x86/dell/dell-wmi-base.c                          |    6 
 drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c |    1 
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c               |    9 
 drivers/platform/x86/thinkpad_acpi.c                               |    6 
 drivers/pmdomain/bcm/bcm2835-power.c                               |   18 
 drivers/regulator/pca9450-regulator.c                              |   41 
 drivers/remoteproc/mtk_scp.c                                       |   39 
 drivers/remoteproc/qcom_sysmon.c                                   |    2 
 drivers/s390/block/dasd_eckd.c                                     |   16 
 drivers/s390/crypto/zcrypt_ccamisc.c                               |   12 
 drivers/s390/crypto/zcrypt_cex4.c                                  |    3 
 drivers/scsi/hisi_sas/hisi_sas.h                                   |   43 
 drivers/scsi/hisi_sas/hisi_sas_main.c                              |   42 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                             |  246 ++--
 drivers/scsi/lpfc/lpfc_init.c                                      |    2 
 drivers/scsi/lpfc/lpfc_sli.c                                       |   36 
 drivers/scsi/lpfc/lpfc_sli4.h                                      |    3 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                    |   34 
 drivers/scsi/pm8001/pm8001_sas.c                                   |    5 
 drivers/scsi/scsi_scan.c                                           |    7 
 drivers/scsi/ses.c                                                 |    5 
 drivers/scsi/storvsc_drv.c                                         |    5 
 drivers/soc/fsl/qbman/qman.c                                       |   24 
 drivers/soc/qcom/pmic_glink.c                                      |   10 
 drivers/spi/spi.c                                                  |   25 
 drivers/staging/media/tegra-video/vi.c                             |   27 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                     |   15 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                          |    5 
 drivers/target/target_core_configfs.c                              |   15 
 drivers/tty/serial/8250/8250_dma.c                                 |   15 
 drivers/tty/serial/8250/8250_pci.c                                 |   17 
 drivers/tty/serial/8250/8250_port.c                                |    6 
 drivers/tty/serial/uartlite.c                                      |    1 
 drivers/ufs/core/ufshcd.c                                          |   26 
 drivers/usb/cdns3/core.c                                           |   11 
 drivers/usb/class/cdc-acm.c                                        |    5 
 drivers/usb/class/cdc-acm.h                                        |    1 
 drivers/usb/class/cdc-wdm.c                                        |    4 
 drivers/usb/class/usbtmc.c                                         |    6 
 drivers/usb/core/message.c                                         |  100 +
 drivers/usb/core/phy.c                                             |    8 
 drivers/usb/core/quirks.c                                          |   16 
 drivers/usb/dwc3/dwc3-pci.c                                        |    2 
 drivers/usb/gadget/function/f_mass_storage.c                       |   12 
 drivers/usb/gadget/function/f_tcm.c                                |   14 
 drivers/usb/host/xhci-ring.c                                       |    1 
 drivers/usb/host/xhci.c                                            |    4 
 drivers/usb/image/mdc800.c                                         |    6 
 drivers/usb/misc/uss720.c                                          |    2 
 drivers/usb/misc/yurex.c                                           |    2 
 drivers/usb/renesas_usbhs/common.c                                 |    9 
 drivers/usb/roles/class.c                                          |    7 
 drivers/usb/serial/f81232.c                                        |   77 -
 drivers/usb/typec/tcpm/tcpm.c                                      |    2 
 drivers/usb/typec/ucsi/ucsi_glink.c                                |   27 
 drivers/xen/privcmd.c                                              |   73 +
 drivers/xen/xen-acpi-processor.c                                   |    7 
 fs/binfmt_misc.c                                                   |    4 
 fs/btrfs/Makefile                                                  |    2 
 fs/btrfs/accessors.h                                               |    8 
 fs/btrfs/bio.c                                                     |   21 
 fs/btrfs/block-rsv.c                                               |    6 
 fs/btrfs/ctree.h                                                   |   19 
 fs/btrfs/disk-io.c                                                 |   46 
 fs/btrfs/extent-tree.c                                             |    7 
 fs/btrfs/extent_io.c                                               |    3 
 fs/btrfs/extent_io.h                                               |    3 
 fs/btrfs/file.c                                                    |   16 
 fs/btrfs/free-space-cache.c                                        |    9 
 fs/btrfs/fs.h                                                      |    1 
 fs/btrfs/inode-item.h                                              |    7 
 fs/btrfs/inode.c                                                   |   27 
 fs/btrfs/ioctl.c                                                   |   24 
 fs/btrfs/locking.c                                                 |    1 
 fs/btrfs/ordered-data.c                                            |    1 
 fs/btrfs/ordered-data.h                                            |    2 
 fs/btrfs/raid-stripe-tree.c                                        |   87 +
 fs/btrfs/raid-stripe-tree.h                                        |   35 
 fs/btrfs/scrub.c                                                   |    2 
 fs/btrfs/send.c                                                    |    6 
 fs/btrfs/transaction.c                                             |   16 
 fs/btrfs/tree-checker.c                                            |    6 
 fs/btrfs/tree-log.c                                                |    6 
 fs/btrfs/uuid-tree.c                                               |   43 
 fs/btrfs/uuid-tree.h                                               |    2 
 fs/btrfs/volumes.c                                                 |    4 
 fs/btrfs/volumes.h                                                 |   16 
 fs/ceph/dir.c                                                      |   15 
 fs/ceph/mds_client.c                                               |    3 
 fs/eventpoll.c                                                     |    5 
 fs/ext4/ext4.h                                                     |    9 
 fs/ext4/extents.c                                                  |  536 +++++-----
 fs/ext4/fast_commit.c                                              |    8 
 fs/ext4/mballoc.c                                                  |  242 ++--
 fs/ext4/mballoc.h                                                  |    4 
 fs/ext4/migrate.c                                                  |    5 
 fs/ext4/move_extent.c                                              |    7 
 fs/f2fs/gc.c                                                       |   19 
 fs/iomap/buffered-io.c                                             |   15 
 fs/iomap/direct-io.c                                               |   10 
 fs/nfs/file.c                                                      |    8 
 fs/nfs/nfs4proc.c                                                  |    6 
 fs/nfs/nfstrace.h                                                  |   39 
 fs/nfs/pnfs.c                                                      |   58 -
 fs/nfs/pnfs.h                                                      |   17 
 fs/nfs/read.c                                                      |    8 
 fs/nfs/write.c                                                     |   43 
 fs/nfsd/nfs4xdr.c                                                  |    9 
 fs/nfsd/nfsctl.c                                                   |   14 
 fs/nfsd/state.h                                                    |   17 
 fs/smb/client/cifsencrypt.c                                        |    3 
 fs/smb/client/cifsfs.c                                             |    7 
 fs/smb/client/cifsglob.h                                           |   11 
 fs/smb/client/cifsproto.h                                          |    1 
 fs/smb/client/connect.c                                            |    5 
 fs/smb/client/dir.c                                                |    1 
 fs/smb/client/file.c                                               |   29 
 fs/smb/client/fs_context.c                                         |    2 
 fs/smb/client/misc.c                                               |   43 
 fs/smb/client/smb2inode.c                                          |    4 
 fs/smb/client/smb2ops.c                                            |   14 
 fs/smb/client/smb2pdu.c                                            |   29 
 fs/smb/client/smb2transport.c                                      |    4 
 fs/smb/client/trace.h                                              |    2 
 fs/smb/client/transport.c                                          |   21 
 fs/smb/server/Kconfig                                              |    1 
 fs/smb/server/auth.c                                               |   26 
 fs/smb/server/oplock.c                                             |   35 
 fs/smb/server/oplock.h                                             |    5 
 fs/smb/server/smb2pdu.c                                            |   26 
 fs/squashfs/cache.c                                                |    3 
 fs/xfs/xfs_bmap_item.c                                             |    3 
 fs/xfs/xfs_dquot.c                                                 |    8 
 fs/xfs/xfs_log.c                                                   |    2 
 include/linux/bpf.h                                                |    6 
 include/linux/indirect_call_wrapper.h                              |   18 
 include/linux/ioport.h                                             |   32 
 include/linux/irqchip/arm-gic-v3.h                                 |    1 
 include/linux/mailbox_client.h                                     |    2 
 include/linux/mailbox_controller.h                                 |    9 
 include/linux/mlx5/mlx5_ifc.h                                      |    4 
 include/linux/mmc/host.h                                           |    9 
 include/linux/nfs_fs.h                                             |    1 
 include/linux/security.h                                           |    1 
 include/linux/stmmac.h                                             |    1 
 include/linux/trace_recursion.h                                    |    9 
 include/linux/uprobes.h                                            |    1 
 include/linux/usb.h                                                |    8 
 include/net/act_api.h                                              |    1 
 include/net/bonding.h                                              |    1 
 include/net/dsa.h                                                  |    1 
 include/net/netfilter/nf_tables.h                                  |    5 
 include/net/sch_generic.h                                          |   43 
 include/net/tc_act/tc_gate.h                                       |   33 
 include/net/tc_act/tc_ife.h                                        |    4 
 include/net/udp_tunnel.h                                           |    2 
 include/net/xdp_sock_drv.h                                         |   24 
 include/net/xsk_buff_pool.h                                        |    3 
 include/trace/events/btrfs.h                                       |    4 
 include/trace/events/kmem.h                                        |    8 
 include/trace/events/rxrpc.h                                       |    4 
 include/uapi/linux/btrfs.h                                         |    1 
 include/uapi/linux/btrfs_tree.h                                    |   29 
 include/uapi/linux/pci_regs.h                                      |    2 
 io_uring/kbuf.c                                                    |    8 
 kernel/bpf/devmap.c                                                |   22 
 kernel/bpf/syscall.c                                               |    3 
 kernel/bpf/trampoline.c                                            |    4 
 kernel/bpf/verifier.c                                              |    4 
 kernel/cgroup/cgroup.c                                             |    1 
 kernel/events/core.c                                               |   42 
 kernel/events/uprobes.c                                            |   10 
 kernel/fork.c                                                      |    2 
 kernel/kprobes.c                                                   |   51 
 kernel/rcu/tree_nocb.h                                             |    5 
 kernel/rseq.c                                                      |    5 
 kernel/sched/fair.c                                                |    6 
 kernel/sched/idle.c                                                |   45 
 kernel/time/time.c                                                 |    2 
 kernel/trace/trace.c                                               |   12 
 kernel/trace/trace_events.c                                        |   52 
 kernel/trace/trace_events_trigger.c                                |    3 
 lib/bootconfig.c                                                   |    9 
 mm/kfence/core.c                                                   |   29 
 mm/mempolicy.c                                                     |    4 
 net/atm/lec.c                                                      |   26 
 net/batman-adv/bat_iv_ogm.c                                        |    3 
 net/batman-adv/bat_v_elp.c                                         |   10 
 net/batman-adv/hard-interface.c                                    |    8 
 net/batman-adv/hard-interface.h                                    |    1 
 net/bluetooth/hci_conn.c                                           |    4 
 net/bluetooth/hci_sync.c                                           |    2 
 net/bluetooth/hidp/core.c                                          |   16 
 net/bluetooth/l2cap_core.c                                         |   51 
 net/bluetooth/smp.c                                                |    2 
 net/bridge/br_device.c                                             |    2 
 net/bridge/br_input.c                                              |    2 
 net/can/bcm.c                                                      |    1 
 net/ceph/auth.c                                                    |    6 
 net/ceph/messenger_v2.c                                            |   31 
 net/ceph/mon_client.c                                              |    6 
 net/core/dst.c                                                     |    1 
 net/core/filter.c                                                  |    8 
 net/dsa/dsa.c                                                      |   59 -
 net/ipv4/icmp.c                                                    |    4 
 net/ipv4/route.c                                                   |    4 
 net/ipv4/tcp.c                                                     |    3 
 net/ipv4/tcp_input.c                                               |   18 
 net/ipv4/tcp_ipv4.c                                                |    3 
 net/ipv4/tcp_offload.c                                             |   74 +
 net/ipv4/udp_offload.c                                             |    3 
 net/ipv6/ip6_output.c                                              |   35 
 net/ipv6/route.c                                                   |   15 
 net/ipv6/tcp_ipv6.c                                                |    3 
 net/ipv6/tcpv6_offload.c                                           |   65 +
 net/l2tp/l2tp_ppp.c                                                |   25 
 net/mac80211/debugfs.c                                             |   14 
 net/mac80211/link.c                                                |    2 
 net/mac80211/mesh.c                                                |    6 
 net/mac80211/mlme.c                                                |    3 
 net/mctp/route.c                                                   |   11 
 net/mpls/af_mpls.c                                                 |    1 
 net/mptcp/pm.c                                                     |    2 
 net/mptcp/pm_netlink.c                                             |   72 +
 net/mptcp/protocol.h                                               |    2 
 net/ncsi/ncsi-aen.c                                                |    3 
 net/ncsi/ncsi-rsp.c                                                |   16 
 net/netfilter/nf_bpf_link.c                                        |    2 
 net/netfilter/nf_conntrack_h323_asn1.c                             |    4 
 net/netfilter/nf_conntrack_netlink.c                               |   67 -
 net/netfilter/nf_conntrack_sip.c                                   |    6 
 net/netfilter/nf_tables_api.c                                      |    6 
 net/netfilter/nfnetlink_cthelper.c                                 |    8 
 net/netfilter/nfnetlink_osf.c                                      |   13 
 net/netfilter/nfnetlink_queue.c                                    |    4 
 net/netfilter/nft_ct.c                                             |    9 
 net/netfilter/nft_set_pipapo.c                                     |   54 -
 net/netfilter/nft_set_pipapo.h                                     |    2 
 net/netfilter/xt_CT.c                                              |    4 
 net/netfilter/xt_IDLETIMER.c                                       |    6 
 net/netfilter/xt_dccp.c                                            |    4 
 net/netfilter/xt_tcpudp.c                                          |    6 
 net/netfilter/xt_time.c                                            |    4 
 net/nfc/nci/core.c                                                 |   21 
 net/nfc/nci/data.c                                                 |   12 
 net/nfc/rawsock.c                                                  |   11 
 net/rds/tcp.c                                                      |   14 
 net/rose/af_rose.c                                                 |    5 
 net/rxrpc/ar-internal.h                                            |    9 
 net/rxrpc/conn_event.c                                             |    2 
 net/rxrpc/output.c                                                 |   11 
 net/rxrpc/peer_event.c                                             |   17 
 net/rxrpc/proc.c                                                   |    4 
 net/rxrpc/recvmsg.c                                                |   19 
 net/rxrpc/rxkad.c                                                  |    2 
 net/sched/act_ct.c                                                 |    6 
 net/sched/act_gate.c                                               |  262 +++-
 net/sched/act_ife.c                                                |   93 -
 net/sched/cls_api.c                                                |    7 
 net/sched/sch_ets.c                                                |   12 
 net/sched/sch_generic.c                                            |   27 
 net/sched/sch_ingress.c                                            |   14 
 net/sched/sch_teql.c                                               |    8 
 net/smc/af_smc.c                                                   |   23 
 net/smc/smc.h                                                      |    5 
 net/smc/smc_close.c                                                |    2 
 net/sunrpc/cache.c                                                 |   26 
 net/sunrpc/xprtrdma/verbs.c                                        |    7 
 net/tipc/socket.c                                                  |    2 
 net/wireless/core.c                                                |    1 
 net/wireless/pmsr.c                                                |    1 
 net/wireless/radiotap.c                                            |    4 
 net/xdp/xsk.c                                                      |   28 
 net/xdp/xsk_buff_pool.c                                            |   15 
 rust/kernel/kunit.rs                                               |    8 
 security/apparmor/apparmorfs.c                                     |  225 ++--
 security/apparmor/include/label.h                                  |   16 
 security/apparmor/include/lib.h                                    |   12 
 security/apparmor/include/match.h                                  |    1 
 security/apparmor/include/policy.h                                 |   10 
 security/apparmor/include/policy_ns.h                              |    2 
 security/apparmor/include/policy_unpack.h                          |   75 -
 security/apparmor/label.c                                          |   12 
 security/apparmor/match.c                                          |   58 -
 security/apparmor/policy.c                                         |   77 +
 security/apparmor/policy_ns.c                                      |    2 
 security/apparmor/policy_unpack.c                                  |   49 
 security/security.c                                                |    1 
 sound/core/pcm_native.c                                            |   19 
 sound/pci/hda/cs35l56_hda.c                                        |   14 
 sound/pci/hda/patch_conexant.c                                     |   11 
 sound/soc/amd/acp3x-rt5682-max9836.c                               |    9 
 sound/soc/amd/yc/acp6x-mach.c                                      |   14 
 sound/soc/codecs/cs42l43-jack.c                                    |    1 
 sound/soc/generic/simple-card-utils.c                              |   48 
 sound/soc/qcom/qdsp6/q6apm-dai.c                                   |    1 
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c                            |    1 
 sound/soc/qcom/qdsp6/q6apm.c                                       |    1 
 sound/soc/soc-core.c                                               |   11 
 sound/usb/endpoint.c                                               |   10 
 sound/usb/mixer_scarlett2.c                                        |    2 
 sound/usb/quirks.c                                                 |    4 
 sound/usb/validate.c                                               |    2 
 tools/bootconfig/main.c                                            |    7 
 tools/objtool/Makefile                                             |    8 
 tools/testing/kunit/kunit_kernel.py                                |    6 
 tools/testing/kunit/kunit_tool_test.py                             |   26 
 tools/testing/selftests/arm64/abi/hwcap.c                          |    4 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                    |   56 +
 tools/testing/selftests/net/mptcp/simult_flows.sh                  |   11 
 557 files changed, 6674 insertions(+), 3229 deletions(-)

A1RM4X (1):
      USB: add QUIRK_NO_BOS for video capture several devices

Adrian Hunter (3):
      i3c: mipi-i3c-hci: Use ETIMEDOUT instead of ETIME for timeout errors
      i3c: mipi-i3c-hci: Restart DMA ring correctly after dequeue abort
      i3c: mipi-i3c-hci: Add missing TID field to no-op command descriptor

Adrian Ng Ho Yin (1):
      i3c: dw-i3c-master: Set SIR_REJECT in DAT on device attach and reattach

Akhilesh Patil (1):
      hwmon: (aht10) Add support for dht20

Al Viro (1):
      unshare: fix unshare_fs() handling

Alan Stern (3):
      USB: usbcore: Introduce usb_bulk_msg_killable()
      USB: usbtmc: Use usb_bulk_msg_killable() with user-specified timeouts
      USB: core: Limit the length of unkillable synchronous timeouts

Alban Bedel (1):
      can: mcp251x: fix deadlock in error path of mcp251x_open

Alex Deucher (9):
      drm/amdgpu: keep vga memory on MacBooks with switchable graphics
      drm/amdgpu/gmc9.0: add bounds checking for cid
      drm/amdgpu/mmhub2.0: add bounds checking for cid
      drm/amdgpu/mmhub2.3: add bounds checking for cid
      drm/amdgpu/mmhub3.0.1: add bounds checking for cid
      drm/amdgpu/mmhub3.0.2: add bounds checking for cid
      drm/amdgpu/mmhub3.0: add bounds checking for cid
      drm/radeon: apply state adjust rules to some additional HAINAN vairants
      drm/amdgpu: apply state adjust rules to some additional HAINAN vairants

Alexander Potapenko (2):
      mm/kfence: disable KFENCE upon KASAN HW tags enablement
      mm/kfence: fix KASAN hardware tag faults during late enablement

Alexandre Courbot (1):
      rust: kunit: fix warning when !CONFIG_PRINTK

Allison Henderson (1):
      net/rds: Fix circular locking dependency in rds_tcp_tune

Alok Tiwari (3):
      i40e: fix src IP mask checks and memcpy argument names in cloud filter
      octeontx2-af: devlink: fix NIX RAS reporter recovery condition
      octeontx2-af: devlink: fix NIX RAS reporter to use RAS interrupt status

Alysa Liu (1):
      drm/amdgpu: Fix use-after-free race in VM acquire

Anas Iqbal (1):
      net: dsa: bcm_sf2: fix missing clk_disable_unprepare() in error paths

Andrew Lunn (1):
      net: phy: register phy led_triggers during probe to avoid AB-BA deadlock

Andrii Melnychenko (1):
      netfilter: nft_ct: add seqadj extension for natted connections

Andy Shevchenko (1):
      device property: Allow secondary lookup in fwnode_get_next_child_node()

Ankit Garg (2):
      gve: defer interrupt enabling until NAPI registration
      gve: fix incorrect buffer cleanup in gve_tx_clean_pending_packets for QPL

Antheas Kapenekakis (1):
      platform/x86/amd/pmc: Add support for Van Gogh SoC

Antoniu Miclaus (5):
      iio: chemical: sps30_serial: fix buffer size in sps30_serial_read_meas()
      iio: chemical: sps30_i2c: fix buffer size in sps30_i2c_read_meas()
      iio: gyro: mpu3050-core: fix pm_runtime error handling
      iio: gyro: mpu3050-i2c: fix pm_runtime error handling
      iio: light: bh1780: fix PM runtime leak on error path

Anup Patel (1):
      mailbox: Allow controller specific mapping using fwnode

Ariel Silver (2):
      wifi: mac80211: bounds-check link_id in ieee80211_ml_reconfiguration
      media: dvb-net: fix OOB access in ULE extension header tables

Azamat Almazbek uulu (1):
      ASoC: amd: yc: Add ASUS EXPERTBOOK BM1503CDA to quirk table

Baokun Li (9):
      ext4: get rid of ppath in ext4_find_extent()
      ext4: get rid of ppath in ext4_ext_create_new_leaf()
      ext4: get rid of ppath in ext4_ext_insert_extent()
      ext4: get rid of ppath in ext4_split_extent_at()
      ext4: get rid of ppath in ext4_split_extent()
      ext4: get rid of ppath in ext4_split_convert_extents()
      ext4: get rid of ppath in ext4_convert_unwritten_extents_endio()
      ext4: get rid of ppath in ext4_ext_convert_to_initialized()
      ext4: get rid of ppath in ext4_ext_handle_unwritten_extents()

Bart Van Assche (4):
      hwmon: (it87) Check the it87_lock() return value
      wifi: cw1200: Fix locking in error paths
      wifi: wlcore: Fix a locking bug
      PM: runtime: Fix a race condition related to device removal

Bastien Curutchet (Schneider Electric) (1):
      net: dsa: microchip: Fix error path in PTP IRQ setup

Ben Dooks (1):
      ACPI: OSL: fix __iomem type on return from acpi_os_map_generic_address()

Bharath SM (1):
      smb: client: fix in-place encryption corruption in SMB2_write()

Bjorn Andersson (2):
      remoteproc: sysmon: Correct subsys_name_len type in QMI request
      usb: typec: ucsi: Move unregister out of atomic section

Bjorn Helgaas (1):
      PCI: Correct PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 value

Borislav Petkov (AMD) (1):
      x86/sev: Harden #VC instruction emulation somewhat

Brad Spengler (1):
      drm/vmwgfx: Fix invalid kref_put callback in vmw_bo_dirty_release

Brian Foster (1):
      ext4: fix dirtyclusters double decrement on fs shutdown

Calvin Owens (1):
      tracing: Fix trace_buf_size= cmdline parameter with sizes >= 2G

Casey Connolly (1):
      ASoC: detect empty DMI strings

Catalin Marinas (1):
      arm64: mm: Add PTE_DIRTY back to PAGE_KERNEL* to fix kexec/hibernation

Chao Yu (2):
      f2fs: fix to avoid migrating empty section
      f2fs: zone: fix to avoid inconsistence in between SIT and SSA

Charles Keepax (1):
      ASoC: cs42l43: Report insert for exotic peripherals

Chen Ni (2):
      ASoC: amd: acp3x-rt5682-max9836: Add missing error check for clock acquisition
      mtd: rawnand: cadence: Fix error check for dma_alloc_coherent() in cadence_nand_init()

Chengfeng Ye (1):
      mctp: route: hold key->lock in mctp_flow_prepare_output()

Chintan Vankar (1):
      net: ethernet: ti: am65-cpsw-nuss/cpsw-ale: Fix multicast entry handling in ALE table

Chris Morgan (1):
      net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick

Chris Spencer (1):
      iio: chemical: bme680: Fix measurement wait duration calculation

Christian Eggers (3):
      Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU
      Bluetooth: LE L2CAP: Disconnect if sum of payload sizes exceed SDU
      Bluetooth: SMP: make SM/PER/KDU/BI-04-C happy

Christoffer Sandberg (1):
      usb/core/quirks: Add Huawei ME906S-device to wakeup quirk

Christoph Böhmwalder (1):
      drbd: fix null-pointer dereference on local read error

Christoph Hellwig (2):
      nfs: pass explicit offset/count to trace events
      iomap: allocate s_dio_done_wq for async reads as well

Christophe JAILLET (1):
      i2c: fsi: Fix a potential leak in fsi_i2c_probe()

Christophe Leroy (CS GROUP) (1):
      powerpc/uaccess: Fix inline assembly for clang build on PPC32

Chuck Lever (1):
      NFSD: Hold net reference for the lifetime of /proc/fs/nfs/exports fd

Cosmin Ratiu (2):
      net/mlx5: Fix deadlock between devlink lock and esw->wq
      net/mlx5: qos: Restrict RTNL area to avoid a lock cycle

Daniel Borkmann (1):
      clsact: Fix use-after-free in init/destroy rollback asymmetry

Daniel Hodges (1):
      wifi: libertas: fix use-after-free in lbs_free_adapter()

Daniel Jurgens (2):
      net/mlx5: IFC updates for disabled host PF
      net/mlx5: Query to see if host PF is disabled

Daniil Dulov (1):
      wifi: cfg80211: cancel rfkill_block work in wiphy_unregister()

Darrick J. Wong (2):
      xfs: fix undersized l_iclog_roundoff values
      iomap: reject delalloc mappings during writeback

Dave Airlie (1):
      nouveau/dpcd: return EBUSY for aux xfer if the device is asleep

David Dull (1):
      netfilter: x_tables: guard option walkers against 1-byte tail reads

David Hildenbrand (Arm) (1):
      mm/mempolicy: fix wrong mmap_read_unlock() in migrate_to_node()

David Howells (2):
      rxrpc: Fix recvmsg() unconditional requeue
      rxrpc: Fix data-race warning and potential load/store tearing

David Thomson (1):
      xen/acpi-processor: fix _CST detection using undersized evaluation buffer

Davide Caratti (1):
      net/sched: ets: fix divide by zero in the offload path

Dayu Jiang (1):
      usb: xhci: Prevent interrupt storm on host controller error (HCE)

Dipayaan Roy (1):
      net: mana: fix use-after-free in mana_hwc_destroy_channel() by reordering teardown

Dmitry Baryshkov (2):
      drm/msm/dsi: Document DSC related pclk_rate and hdisplay calculations
      Bluetooth: qca: fix ROM version reading on WCN3998 chips

Eric Badger (1):
      xprtrdma: Decrement re_receiving on the early exit paths

Eric Biggers (3):
      smb: client: Compare MACs in constant time
      ksmbd: Compare MACs in constant time
      net/tcp-md5: Fix MAC comparison to be constant-time

Eric Dumazet (4):
      indirect_call_wrapper: do not reevaluate function pointer
      dst: fix races in rt6_uncached_list_del() and rt_del_uncached_list()
      ipv6: use RCU in ip6_xmit()
      l2tp: do not use sock_hold() in pppol2tp_session_get_sock()

Ethan Nelson-Moore (1):
      net: arcnet: com20020-pci: fix support for 2.5Mbit cards

Fan Wu (2):
      usb: renesas_usbhs: fix use-after-free in ISR during device removal
      net: ethernet: arc: emac: quiesce interrupts before requesting IRQ

Fedor Pchelkin (3):
      ksmbd: call ksmbd_vfs_kern_path_end_removing() on some error paths
      net: macb: fix use-after-free access to PTP clock
      net: macb: fix uninitialized rx_fs_lock

Felix Fietkau (2):
      net: add support for segmenting TCP fraglist GSO packets
      net: gso: fix tcp fraglist segmentation after pull from frag_list

Felix Gu (5):
      drm/logicvc: Fix device node reference leak in logicvc_drm_config_parse()
      pinctrl: cirrus: cs42l43: Fix double-put in cs42l43_pin_probe()
      mmc: mmci: Fix device_node reference leak in of_get_dml_pipe_index()
      cache: ax45mp: Fix device node reference leak in ax45mp_cache_init()
      firmware: arm_scpi: Fix device_node reference leak in probe path

Fernando Fernandez Mancera (2):
      net: bridge: fix nd_tbl NULL dereference when IPv6 is disabled
      net: vxlan: fix nd_tbl NULL dereference when IPv6 is disabled

Filipe Manana (5):
      btrfs: abort transaction on failure to update root in the received subvol ioctl
      btrfs: fix transaction abort when snapshotting received subvolumes
      btrfs: fix transaction abort on set received ioctl due to item overflow
      btrfs: fix transaction abort on file creation due to name hash collision
      btrfs: log new dentries when logging parent dir of a conflicting inode

Finn Thain (1):
      mtd: Avoid boot crash in RedBoot partition table parser

Florian Eckert (2):
      pinctrl: equilibrium: rename irq_chip function callbacks
      pinctrl: equilibrium: fix warning trace on load

Florian Westphal (3):
      netfilter: ctnetlink: remove refcounting in expectation dumpers
      netfilter: bpf: defer hook memory release until rcu readers are done
      netfilter: nft_set_pipapo: split gc into unlink and reclaim phase

Francesco Lavra (1):
      drm/solomon: Fix page start when updating rectangle in page addressing mode

Franz Schnyder (1):
      drm/bridge: ti-sn65dsi86: Enable HPD polling if IRQ is not used

Frieder Schrempf (1):
      regulator: pca9450: Make IRQ optional

Gabor Juhos (2):
      usb: core: don't power off roothub PHYs if phy_set_mode() fails
      i2c: pxa: defer reset on Armada 3700 when recovery is used

Gal Pressman (1):
      net/mlx5e: Fix DMA FIFO desync on error CQE SQ recovery

Gang Yan (1):
      selftests: mptcp: add a check for 'add_addr_accepted'

Geert Uytterhoeven (1):
      drm/ssd130x: Use bool for ssd130x_deviceinfo flags

Geoffrey D. Bennett (1):
      ALSA: usb-audio: Remove VALIDATE_RATES quirk for Focusrite devices

Gou Hao (1):
      ext4: delete redundant calculations in ext4_mb_get_buddy_page_lock()

Greg Kroah-Hartman (14):
      nfc: pn533: properly drop the usb interface reference on disconnect
      net: usb: kaweth: validate USB endpoints
      net: usb: kalmia: validate USB endpoints
      net: usb: pegasus: validate USB endpoints
      can: ems_usb: ems_usb_read_bulk_callback(): check the proper length of a message
      can: usb: f81604: correctly anchor the urb in the read bulk callback
      can: ucan: Fix infinite loop from zero-length messages
      can: usb: etas_es58x: correctly anchor the urb in the read bulk callback
      can: usb: f81604: handle short interrupt urb messages properly
      can: usb: f81604: handle bulk write errors properly
      HID: Add HID_CLAIMED_INPUT guards in raw_event callbacks missing them
      usb: misc: uss720: properly clean up reference in uss720_probe()
      staging: rtl8723bs: properly validate the data in rtw_get_ie_ex()
      Linux 6.6.130

Guanghui Feng (1):
      iommu/vt-d: Fix intel iommu iotlb sync hardlockup and retry

Guenter Roeck (4):
      dpaa2-switch: Fix interrupt storm after receiving bad if_id in IRQ handler
      tracing: Add NULL pointer check to trigger_data_free()
      smb/server: Fix another refcount leak in smb2_open()
      wifi: wlcore: Return -ENOMEM instead of -EAGAIN if there is not enough headroom

Gui-Dong Han (1):
      hwmon: (max16065) Use READ/WRITE_ONCE to avoid compiler optimization induced race

Guodong Xu (1):
      dmaengine: mmp_pdma: Fix race condition in mmp_pdma_residue()

Haiyue Wang (1):
      mctp: i2c: fix skb memory leak in receive path

Hangbin Liu (1):
      bonding: handle BOND_LINK_FAIL, BOND_LINK_BACK as valid link states

Hao Yu (1):
      hwmon: (aht10) Fix initialization commands for AHT20

Harald Freudenberger (1):
      s390/zcrypt: Enable AUTOSEL_DOM for CCA serialnr sysfs attribute

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Nova Lake -H

Heiko Carstens (2):
      s390/xor: Fix xor_xc_2() inline assembly constraints
      s390/stackleak: Fix __stackleak_poison() inline assembly constraint

Helge Deller (4):
      parisc: Increase initial mapping to 64 MB with KALLSYMS
      parisc: Fix initial page table creation for boot
      parisc: Check kernel mapping earlier at bootup
      parisc: Flush correct cache in cacheflush() syscall

Henrique Carvalho (2):
      smb: client: fix cifs_pick_channel when channels are equally loaded
      smb: client: fix iface port assignment in parse_server_interfaces

Hongyu Xie (1):
      usb: cdns3: remove redundant if branch

Huacai Chen (1):
      net: stmmac: dwmac-loongson: Set clk_csr_i to 100-150MHz

Huiwen He (1):
      tracing: Fix syscall events activation by ensuring refcount hits zero

Hyunwoo Kim (5):
      netfilter: nfnetlink_queue: fix entry leak in bridge verdict error path
      netfilter: nfnetlink_cthelper: fix OOB read in nfnl_cthelper_dump_table()
      netfilter: ctnetlink: fix use-after-free in ctnetlink_dump_exp_ct()
      ksmbd: fix use-after-free of share_conf in compound request
      ksmbd: fix use-after-free in durable v2 replay of active file handles

Ian Forbes (1):
      drm/vmwgfx: Return the correct value in vmw_translate_ptr functions

Ian Ray (2):
      net: nfc: nci: Fix zero-length proprietary notifications
      NFC: nxp-nci: allow GPIOs to sleep

Ilpo Järvinen (3):
      resource: Add resource set range and size helpers
      PCI: Use resource_set_range() that correctly sets ->end
      serial: 8250: Add late synchronize_irq() to shutdown to handle DW UART BUSY

Ilya Dryomov (3):
      libceph: reject preamble if control segment is empty
      libceph: prevent potential out-of-bounds reads in process_message_header()
      libceph: admit message frames only in CEPH_CON_S_OPEN state

Ioana Ciornei (1):
      dpaa2-switch: do not clear any interrupts automatically

Ira Weiny (1):
      nvdimm/bus: Fix potential use after free in asynchronous initialization

J. Neuschäfer (1):
      powerpc: 83xx: km83xx: Fix keymile vendor prefix

Jakub Kicinski (5):
      ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
      nfc: nci: free skb on nci_transceive early error paths
      nfc: nci: clear NCI_DATA_EXCHANGE before calling completion callback
      nfc: rawsock: cancel tx_work before socket teardown
      eth: bnxt: always recalculate features after XDP clearing, fix null-deref

Jakub Staniszewski (2):
      ice: reintroduce retry mechanism for indirect AQ
      ice: fix retry for AQ command 0x06EE

Jamal Hadi Salim (2):
      net/sched: act_ife: Fix metalist update behavior
      net/sched: teql: Fix double-free in teql_master_xmit

Jan Kara (1):
      ext4: always allocate blocks only from groups inode can use

Jan Kiszka (1):
      scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT

Jann Horn (1):
      eventpoll: Fix integer overflow in ep_loop_check_proc()

Janusz Krzysztofik (1):
      drm/i915: Fix potential overflow of shmem scatterlist length

Jason Gunthorpe (2):
      IB/mthca: Add missed mthca_unmap_user_db() for mthca_create_srq()
      RDMA/irdma: Fix kernel stack leak in irdma_create_user_ah()

Javier Martinez Canillas (2):
      drm/ssd130x: Store the HW buffer in the driver-private CRTC state
      drm/ssd130x: Replace .page_height field in device info with a constant

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: fix odr switch to the same value

Jedrzej Jagielski (1):
      ixgbevf: fix link setup issue

Jeff Layton (2):
      sunrpc: fix cache_request leak in cache_release
      nfsd: fix heap overflow in NFSv4.0 LOCK replay cache

Jenny Guanni Qu (4):
      netfilter: nft_set_pipapo: fix stack out-of-bounds read in pipapo_drop()
      netfilter: nf_conntrack_h323: fix OOB read in decode_int() CONS case
      netfilter: xt_time: use unsigned int for monthday bit shift
      netfilter: nf_conntrack_h323: check for zero length in DecodeQ931()

Jens Axboe (2):
      media: dvb-core: fix wrong reinitialization of ringbuffer on reopen
      io_uring/kbuf: check if target buffer list is still legacy on recycle

Jeongjun Park (3):
      drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection_ioctl()
      drm/exynos: vidi: fix to avoid directly dereferencing user pointer
      drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free

Ji-Ze Hong (Peter Hong) (1):
      USB: serial: f81232: fix incomplete serial port generation

Jian Zhang (1):
      net: ncsi: fix skb leak in error paths

Jianbo Liu (2):
      net/mlx5e: Prevent concurrent access to IPSec ASO context
      net/mlx5e: Fix race condition during IPSec ESN update

Jiasheng Jiang (1):
      usb: gadget: f_tcm: Fix NULL pointer dereferences in nexus handling

Jiayuan Chen (5):
      atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
      bpf/bonding: reject vlan+srcmac xmit_hash_policy change when XDP is loaded
      net: ipv6: fix panic when IPv4 route references loopback IPv6 nexthop
      net/rose: fix NULL pointer dereference in rose_transmit_link on reconnect
      net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()

Jibin Zhang (1):
      net: fix segmentation of forwarding fraglist GRO

Johan Hovold (10):
      memory: mtk-smi: fix device leaks on common probe
      memory: mtk-smi: fix device leak on larb probe
      drm/tegra: dsi: fix device leak on probe
      bus: omap-ocp2scp: fix OF populate on driver rebind
      mfd: qcom-pm8xxx: Fix OF populate on driver rebind
      mfd: omap-usb-host: Fix OF populate on driver rebind
      clk: tegra: tegra124-emc: fix device leak on set_rate()
      spi: fix use-after-free on controller registration failure
      spi: fix statistics allocation
      i2c: cp2615: fix serial string NULL-deref at probe

Johannes Berg (1):
      wifi: radiotap: reject radiotap with unknown bits

Johannes Thumshirn (3):
      btrfs: add raid stripe tree definitions
      btrfs: read raid stripe tree from disk
      btrfs: add support for inserting raid stripe extents

John Johansen (6):
      apparmor: fix: limit the number of levels of policy namespaces
      apparmor: Fix double free of ns_name in aa_replace_profiles()
      apparmor: fix unprivileged local user can do privileged policy management
      apparmor: fix differential encoding verification
      apparmor: fix race on rawdata dereference
      apparmor: fix race between freeing data and fs accessing it

John Ripple (1):
      drm/bridge: ti-sn65dsi86: Add support for DisplayPort mode with HPD

Jonathan Teh (1):
      platform/x86: thinkpad_acpi: Fix errors reading battery thresholds

Joonwon Kang (1):
      mailbox: Prevent out-of-bounds access in fw_mbox_index_xlate()

Josef Bacik (3):
      btrfs: move btrfs_crc32c_final into free-space-cache.c
      btrfs: remove btrfs_crc32c wrapper
      btrfs: move btrfs_extref_hash into inode-item.h

Josh Law (5):
      lib/bootconfig: fix off-by-one in xbc_verify_tree() unclosed brace error
      lib/bootconfig: fix snprintf truncation check in xbc_node_compose_key_after()
      lib/bootconfig: check bounds before writing in __xbc_open_brace()
      lib/bootconfig: check xbc_init_node() return in override path
      tools/bootconfig: fix fd leak in load_xbc_file() on fstat failure

Juergen Gross (2):
      xen/privcmd: restrict usage in unprivileged domU
      xen/privcmd: add boot control for restricted usage in domU

Jun Seo (1):
      ALSA: usb-audio: Use correct version for UAC3 header validation

Junxiao Bi (2):
      scsi: core: Fix refcount leak for tagset_refcnt
      scsi: core: Fix error handling for scsi_alloc_sdev()

Justin Chen (1):
      net: bcmgenet: increase WoL poll timeout

Justin Stitt (1):
      i2c: cp2615: replace deprecated strncpy with strscpy

Kalesh Singh (1):
      mm/tracing: rss_stat: ensure curr is false from kthread context

Kamal Dasu (2):
      mtd: rawnand: serialize lock/unlock against other NAND operations
      mtd: rawnand: brcmnand: skip DMA during panic write

Kevin Hao (3):
      net: macb: Shuffle the tx ring before enabling tx
      net: macb: Introduce gem_init_rx_ring()
      net: macb: Reinitialize tx/rx queue pointer registers and rx ring during resume

Kim Phillips (1):
      x86/sev: Allow IBPB-on-Entry feature for SNP guests

Kohei Enju (2):
      bpf: Fix stack-out-of-bounds write in devmap
      igc: fix missing update of skb->tail in igc_xmit_frame()

Koichiro Den (1):
      net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue race for lockless qdiscs

Kui-Feng Lee (1):
      bpf: export bpf_link_inc_not_zero.

Kuninori Morimoto (2):
      ALSA: pci: hda: use snd_kcontrol_chip()
      ASoC: simple-card-utils: use __free(device_node) for device node

Kuniyuki Iwashima (1):
      wifi: mac80211: Fix static_branch_dec() underflow for aql_disable.

Kurt Borja (1):
      platform/x86: dell-wmi: Add audio/mic mute key codes

Kyle Meyer (1):
      x86/platform/uv: Handle deconfigured sockets

Lang Xu (1):
      bpf: Fix a UAF issue in bpf_trampoline_link_cgroup_shim

Lars Ellenberg (1):
      drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()

Larysa Zaremba (5):
      xdp: use modulo operation to calculate XDP frag tailroom
      xsk: introduce helper to determine rxq->frag_size
      i40e: fix registering XDP RxQ info
      i40e: use xdp.frame_sz as XDP RxQ info frag_size
      xdp: produce a warning when calculated tailroom is negative

Laurent Pinchart (1):
      media: tegra-video: Use accessors for pad config 'try_*' fields

Lijo Lazar (1):
      drm/amdgpu: Add basic validation for RAS header

Long Li (3):
      net: mana: Ring doorbell at 4 CQ wraparounds
      xfs: fix integer overflow in bmap intent sort comparator
      xfs: ensure dquot item is deleted from AIL only after log shutdown

Lorenzo Bianconi (3):
      wifi: mt76: mt7996: Fix possible oob access in mt7996_mac_write_txwi_80211()
      wifi: mt76: Fix possible oob access in mt76_connac2_mac_write_txwi_80211()
      net: ethernet: mtk_eth_soc: Reset prog ptr to old_prog in case of error in mtk_xdp_setup()

Luca Ceresoli (2):
      drm/bridge: ti-sn65dsi83: fix CHA_DSI_CLK_RANGE rounding
      drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual LVDS output

Luiz Augusto von Dentz (3):
      Bluetooth: ISO: Fix defer tests being unstable
      Bluetooth: HIDP: Fix possible UAF
      Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ

Luka Gejak (1):
      staging: rtl8723bs: fix potential out-of-bounds read in rtw_restruct_wmm_ie

Lukas Gerlach (1):
      riscv: Sanitize syscall table indexing under speculation

Lukas Johannes Möller (3):
      Bluetooth: L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
      Bluetooth: L2CAP: Validate L2CAP_INFO_RSP payload length before access
      netfilter: nf_conntrack_sip: fix Content-Length u32 truncation in sip_help_tcp()

Lukas Schmid (1):
      iio: potentiometer: mcp4131: fix double application of wiper shift

Luke Wang (1):
      mmc: sdhci: fix timing selection for 1-bit bus width

Maarten Lankhorst (1):
      drm: Fix use-after-free on framebuffers and property blobs when calling drm_dev_unplug

Maciej Andrzejewski ICEYE (1):
      serial: uartlite: fix PM runtime usage count underflow on probe

Maciej Fijalkowski (2):
      xsk: Get rid of xdp_buff_xsk::xskb_list_node
      xsk: s/free_list_node/list_node/

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_open(): always configure bitrates before starting device

Marc Zyngier (2):
      usb: cdc-acm: Restore CAP_BRK functionnality to CH343
      irqchip/gic-v3-its: Limit number of per-device MSIs to the range the ITS supports

Mario Limonciello (4):
      drm/amd: Fix hang on amdgpu unload by using pci_dev_is_disconnected()
      drm/amd: Drop special case for yellow carp without discovery
      drm/amd: Set num IP blocks to 0 if discovery fails
      platform/x86: hp-bioscfg: Support allocations of larger data

Marios Makassikis (1):
      smb: server: fix use-after-free in smb2_open()

Mark Harmstone (4):
      btrfs: fix incorrect key offset in error message in check_dev_extent_item()
      btrfs: fix objectid value in error message in check_extent_data_ref()
      btrfs: fix warning in scrub_verify_one_metadata()
      btrfs: fix compat mask in error messages in btrfs_check_features()

Martin Roukala (né Peres) (1):
      serial: 8250_pci: add support for the AX99100

Masami Hiramatsu (Google) (3):
      kprobes: avoid crash when rmmod/insmod after ftrace killed
      kprobes: Remove unneeded goto
      kprobes: Remove unneeded warnings from __arm_kprobe_ftrace()

Massimiliano Pellizzer (5):
      apparmor: validate DFA start states are in bounds in unpack_pdb
      apparmor: fix memory leak in verify_header
      apparmor: replace recursive profile removal with iterative approach
      apparmor: fix side-effect bug in match_char() macro usage
      apparmor: fix missing bounds check on DEFAULT table in verify_dfa()

Mathias Krause (2):
      scsi: lpfc: Properly set WC for DPP mapping
      KVM: x86: Fix KVM_GET_MSRS stack info leak

Mathieu Desnoyers (1):
      rseq: Clarify rseq registration rseq_size bound check comment

Matt Vollrath (1):
      e1000/e1000e: Fix leak in DMA error cleanup

Matthew Schwartz (1):
      mmc: sdhci-pci-gli: fix GL9750 DMA write corruption

Matthew Wilcox (Oracle) (2):
      ext4: convert bd_bitmap_page to bd_bitmap_folio
      ext4: convert bd_buddy_page to bd_buddy_folio

Matthieu Baerts (NGI0) (5):
      selftests: mptcp: join: check removing signal+subflow endp
      mptcp: pm: avoid sending RM_ADDR over same subflow
      mptcp: pm: in-kernel: always mark signal+subflow endp as used
      selftests: mptcp: join: check RM_ADDR not sent over same subflow
      mptcp: pm: in-kernel: always set ID as avail when rm endp

Max Kellermann (2):
      ceph: fix i_nlink underrun during async unlink
      ceph: fix memory leaks in ceph_mdsc_build_path()

Maíra Canal (2):
      pmdomain: bcm: bcm2835-power: Fix broken reset status read
      pmdomain: bcm: bcm2835-power: Increase ASB control timeout

Mehul Rao (2):
      ALSA: pcm: fix use-after-free on linked stream runtime in snd_pcm_drain()
      tipc: fix divide-by-zero in tipc_sk_filter_connect()

Menglong Dong (1):
      net: tcp: accept old ack during closing

Michael Grzeschik (1):
      Bluetooth: hci_sync: Fix hci_le_create_conn_sync

Mieczyslaw Nalewaj (2):
      net: dsa: realtek: rtl8365mb: fix rtl8365mb_phy_ocp_write return value
      net: dsa: realtek: rtl8365mb: remove ifOutDiscards from rx_packets

Mike Rapoport (Microsoft) (1):
      x86/efi: defer freeing of boot services memory

Mikulas Patocka (1):
      dm-verity: disable recursive forward error correction

Miquel Sabaté Solà (1):
      btrfs: fix NULL dereference on root when tracing inode eviction

Muhammad Hammad Ijaz (1):
      net: mvpp2: guard flow control update with global_tx_fc in buffer switching

Nam Cao (1):
      irqchip/sifive-plic: Fix frozen interrupt due to affinity setting

Namjae Jeon (3):
      ksmbd: fix use-after-free in smb_lazy_parent_lease_break_close()
      ksmbd: fix use-after-free by using call_rcu() for oplock_info
      ksmbd: unset conn->binding on failed binding request

Natalie Vock (1):
      drm/amd/display: Use GFP_ATOMIC in dc_create_stream_for_sink

Nathan Chancellor (1):
      kbuild: Leave objtool binary around with 'make clean'

Naveen N Rao (2):
      KVM: SVM: Limit AVIC physical max index based on configured max_vcpu_ids
      KVM: SVM: Add a helper to look up the max physical ID for AVIC

Nikhil P. Rao (2):
      xsk: Fix fragment node deletion to prevent buffer leak
      xsk: Fix zero-copy AF_XDP fragment drop

Nikola Z. Ivanov (1):
      net: usb: aqc111: Do not perform PM inside suspend callback

Nuno Sá (1):
      iio: buffer: Fix wait_queue not being removed

Oleg Nesterov (1):
      x86/uprobes: Fix XOL allocation failure for 32-bit tasks

Oleksij Rempel (4):
      net: usb: lan78xx: fix silent drop of packets with checksum errors
      net: usb: lan78xx: fix TX byte statistics for small packets
      net: usb: lan78xx: skip LTM configuration for LAN7850
      iio: dac: ds4424: reject -128 RAW value

Oliver Hartkopp (1):
      can: bcm: fix locking for bcm_op runtime updates

Oliver Neukum (3):
      usb: yurex: fix race in probe
      usb: class: cdc-wdm: fix reordering issue in read code path
      usb: mdc800: handle signal and read racing

Olivier Sobrie (1):
      mtd: rawnand: pl353: make sure optimal timings are applied

Osama Abdelkader (1):
      drm/bridge: samsung-dsim: Fix memory leak in error path

Ovidiu Panait (1):
      net: stmmac: Fix error handling in VLAN add and delete paths

Pablo Neira Ayuso (3):
      netfilter: nft_ct: drop pending enqueued packets on removal
      netfilter: xt_CT: drop pending enqueued packets on template removal
      netfilter: nf_tables: release flowtable after rcu grace period on error

Paolo Abeni (1):
      selftests: mptcp: more stable simult_flows tests

Paul Chaignon (1):
      bpf: Forget ranges when refining tnum after JSET

Paul Moses (1):
      net/sched: act_gate: snapshot parameters with RCU on replace

Paulo Alcantara (3):
      smb: client: fix broken multichannel with krb5+signing
      smb: client: fix atomic open with O_DIRECT & O_SYNC
      smb: client: fix krb5 mount with username option

Peddolla Harshavardhan Reddy (1):
      wifi: cfg80211: cancel pmsr_free_wk in cfg80211_pmsr_wdev_down

Peng Fan (3):
      mailbox: Use dev_err when there is error
      mailbox: Use guard/scoped_guard for con_mutex
      regulator: pca9450: Correct interrupt type

Penghe Geng (1):
      mmc: core: Avoid bitfield RMW for claim/retune flags

Pengyu Luo (1):
      drm/msm/dsi: fix pclk rate calculation for bonded dsi

Peter Wang (2):
      scsi: ufs: core: Move link recovery for hibern8 exit failure to wl_resume
      scsi: ufs: core: Fix possible NULL pointer dereference in ufshcd_add_command_trace()

Peter Zijlstra (1):
      perf: Fix __perf_event_overflow() vs perf_remove_from_context() race

Petr Oros (1):
      iavf: fix VLAN filter lost on add/delete race

Phillip Lougher (1):
      Squashfs: check metadata block offset is within range

Piotr Mazek (1):
      ACPI: PM: Save NVS memory on Lenovo G70-35

Prithvi Tambewagh (1):
      scsi: target: Fix recursive locking in __configfs_open_file()

Przemek Kitszel (1):
      octeontx2-af: devlink health: use retained error fmsg API

Puranjay Mohan (2):
      PCI: Update BAR # and window messages
      PCI: Use resource names in PCI log messages

Qingye Zhao (1):
      cgroup: fix race between task migration and iteration

Qu Wenruo (2):
      btrfs: always fallback to buffered write if the inode requires checksum
      btrfs: do not strictly require dirty metadata threshold for metadata writepages

Rafael J. Wysocki (3):
      sched: idle: Make skipping governor callbacks more consistent
      sched: idle: Consolidate the handling of two special cases
      ACPI: processor: Fix previous acpi_processor_errata_piix4() fix

Rahul Bukte (1):
      drm/i915/gt: Check set_default_submission() before deferencing

Raju Rangoju (4):
      amd-xgbe: fix MAC_TCR_SS register width for 2.5G and 10M speeds
      amd-xgbe: fix sleep while atomic on suspend/resume
      amd-xgbe: fix link status handling in xgbe_rx_adaptation
      amd-xgbe: prevent CRC errors during RX adaptation with AN disabled

Ramanathan Choodamani (1):
      wifi: mac80211: set default WMM parameters on all links

Ranjan Kumar (1):
      scsi: mpi3mr: Add NULL checks when resetting request and reply queues

Raphael Zimmer (2):
      libceph: Fix potential out-of-bounds access in ceph_handle_auth_reply()
      libceph: Use u32 for non-negative values in ceph_monmap_decode()

Raul E Rangel (1):
      serial: 8250: Fix TX deadlock when using DMA

Ravi Hothi (1):
      ASoC: qcom: qdsp6: Fix q6apm remove ordering during ADSP stop and start

Ricardo B. Marlière (1):
      net: bonding: Fix nd_tbl NULL dereference when IPv6 is disabled

Richard Fitzgerald (1):
      ALSA: hda: cs35l56: Fix signedness error in cs35l56_hda_posture_put()

Richard Genoud (1):
      soc: fsl: qbman: fix race condition in qman_destroy_fq

Rob Herring (Arm) (1):
      mailbox: Use of_property_match_string() instead of open-coding

Russell King (Oracle) (3):
      net: sfp: re-implement ignoring the hardware TX_FAULT signal
      net: sfp: improve Nokia GPON sfp fixup
      net: stmmac: remove support for lpi_intr_o

Ryan Roberts (3):
      arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
      arm64: mm: Batch dsb and isb when populating pgtables
      arm64: mm: Don't remap pgtables for allocate vs populate

Sabrina Dubroca (1):
      mpls: add missing unregister_netdevice_notifier to mpls_init

Salomon Dushimirimana (1):
      scsi: pm8001: Fix use-after-free in pm8001_queue_command()

Sanman Pradhan (3):
      hwmon: (pmbus/q54sj108a2) fix stack overflow in debugfs read
      hwmon: (pmbus/mp2975) Add error check for pmbus_read_word_data() return value
      hwmon: (pmbus/isl68137) Fix unchecked return value and use sysfs_emit()

Sasha Levin (1):
      Revert "arm64: dts: qcom: sdm845-oneplus: Mark l14a regulator as boot-on"

Sean Christopherson (6):
      KVM: x86: Rename KVM_MSR_RET_INVALID to KVM_MSR_RET_UNSUPPORTED
      KVM: x86: Return "unsupported" instead of "invalid" on access to unsupported PV MSR
      KVM: x86: WARN if a vCPU gets a valid wakeup that KVM can't yet inject
      KVM: x86: Ignore -EBUSY when checking nested events from vcpu_block()
      KVM: SVM: Initialize AVIC VMCB fields if AVIC is enabled with in-kernel APIC
      KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activated

Sen Wang (1):
      ASoC: simple-card-utils: fix graph_util_is_ports0() for DT overlays

SeungJu Cheon (1):
      iio: frequency: adf4377: Fix duplicated soft reset mask

Seungjin Bae (1):
      usb: gadget: f_mass_storage: Fix potential integer overflow in check_command_size_in_blocks()

Shashank Balaji (1):
      x86/apic: Disable x2apic on resume if the kernel expects so

Shaurya Rane (1):
      Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user

Shawn Lin (1):
      arm64: dts: rockchip: Fix rk356x PCIe range mappings

Shuangpeng Bai (1):
      serial: caif: hold tty->link reference in ldisc_open and ser_release

Shuvam Pandey (1):
      kunit: tool: copy caller args in run_kernel to prevent mutation

Shyam Prasad N (2):
      cifs: make default value of retrans as zero
      cifs: open files should not hold ref on superblock

Sofia Schneider (1):
      ACPI: OSI: Add DMI quirk for Acer Aspire One D255

Srinivasan Shanmugam (1):
      drm/amd/display: Fix DisplayID not-found handling in parse_edid_displayid_vrr()

Stefan Haberland (2):
      s390/dasd: Move quiesce state with pprc swap
      s390/dasd: Copy detected format information to secondary device

Stefan Hajnoczi (1):
      nvme: reject invalid pr_read_keys() num_keys values

Steven Rostedt (2):
      time/jiffies: Mark jiffies_64_to_clock_t() notrace
      tracing: Add recursion protection in kernel stack trace recording

Sungwoo Kim (3):
      nvme: fix memory allocation in nvme_pr_read_keys()
      nvme-pci: Fix slab-out-of-bounds in nvme_dbbuf_set
      nvme-pci: Fix race bug in nvme_poll_irqdisable()

Sven Eckelmann (1):
      batman-adv: Avoid double-rtnl_lock ELP metric worker

Takashi Iwai (7):
      ALSA: usb-audio: Cap the packet size pre-calculations
      ALSA: usb-audio: Use inclusive terms
      ALSA: hda/conexant: Add quirk for HP ZBook Studio G4
      ALSA: hda/conexant: Fix headphone jack handling on Acer Swift SF314
      ALSA: usb-audio: Avoid implicit feedback mode on DIYINHK USB Audio 2.0
      ALSA: usb-audio: Check max frame size for implicit feedback mode, too
      ALSA: usb-audio: Check endpoint numbers at parsing Scarlett2 mixer interfaces

Thomas Fourier (1):
      drm/msm: Fix dma_free_attrs() buffer size

Thomas Richard (TI) (1):
      usb: cdns3: fix role switching during resume

Thomas Weißschuh (1):
      ARM: clean up the memset64() C wrapper

Thorsten Blum (4):
      platform/x86: dell-wmi-sysman: Don't hex dump plaintext password data
      smb: client: Don't log plaintext credentials in cifs_set_cifscreds
      ksmbd: Don't log keys in SMB3 signing and encryption key generation
      crypto: atmel-sha204a - Fix OOM ->tfm_count leak

Théo Lebrun (1):
      usb: cdns3: call cdns_power_is_lost() only once in cdns_resume()

Tiezhu Yang (1):
      LoongArch: Give more information if kmem access failed

Timur Kristóf (2):
      drm/amd/display: Add pixel_clock to amd_pp_display_configuration
      drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)

Tobi Gaertner (2):
      net: usb: cdc_ncm: add ndpoffset to NDP16 nframes bounds check
      net: usb: cdc_ncm: add ndpoffset to NDP32 nframes bounds check

Tom Lendacky (1):
      x86/sev: Check for MWAITX and MONITORX opcodes in the #VC handler

Tomas Henzl (1):
      scsi: ses: Fix devices attaching to different hosts

Trond Myklebust (2):
      NFS: Fix a deadlock involving nfs_release_folio()
      pNFS: Fix a deadlock when returning a delegation during open()

Tudor Ambarus (3):
      mailbox: don't protect of_parse_phandle_with_args with con_mutex
      mailbox: sort headers alphabetically
      mailbox: remove unused header files

Tzung-Bi Shih (1):
      remoteproc: mediatek: Unprepare SCP clock during system suspend

Uwe Kleine-König (4):
      memory: mtk-smi: Convert to platform remove callback returning void
      bus: omap-ocp2scp: Convert to platform remove callback returning void
      mfd: qcom-pm8xxx: Convert to platform remove callback returning void
      mfd: omap-usb-host: Convert to platform remove callback returning void

Vahagn Vardanian (1):
      wifi: mac80211: fix NULL pointer dereference in mesh_rx_csa_frame()

Victor Nogueira (1):
      net/sched: Only allow act_ct to bind to clsact/ingress qdiscs and shared blocks

Vimlesh Kumar (2):
      octeon_ep: Relocate counter updates before NAPI
      octeon_ep: avoid compiler and IQ/OQ reordering

Vincent Guittot (1):
      sched/fair: Fix pelt clock sync when entering idle

Vineeth Karumanchi (1):
      net: macb: queue tie-off or disable during WOL suspend

Vitaly Lifshits (1):
      e1000e: clear DPG_EN after reset to avoid autonomous power-gating

Vladimir Oltean (1):
      net: dsa: properly keep track of conduit reference

Vyacheslav Vahnenko (1):
      USB: ezcap401 needs USB_QUIRK_NO_BOS to function on 10gbs usb speed

Wang Shuaiwei (1):
      scsi: ufs: core: Fix SError in ufshcd_rtc_work() during UFS suspend

Weiming Shi (3):
      net/sched: teql: fix NULL pointer dereference in iptunnel_xmit on TEQL slave xmit
      nfnetlink_osf: validate individual option lengths in fingerprints
      icmp: fix NULL pointer dereference in icmp_tag_validation()

Wenyuan Li (1):
      can: hi311x: hi3110_open(): add check for hi3110_power_enable() return value

Xi Ruoyao (1):
      drm/amd/display: Wrap dcn32_override_min_req_memclk() in DC_FP_{START, END}

Xiang Mei (3):
      wifi: mac80211: fix NULL deref in mesh_matches_local()
      udp_tunnel: fix NULL deref caused by udp_sock_create6 when CONFIG_IPV6=n
      net: bonding: fix NULL deref in bond_debug_rlb_hash_show

Xingui Yang (2):
      scsi: hisi_sas: Add time interval between two H2D FIS following soft reset spec
      scsi: hisi_sas: Fix NULL pointer exception during user_scan()

Xu Yang (2):
      usb: roles: get usb role switch from parent only for usb-b-connector
      Revert "tcpm: allow looking for role_sw device in the main node"

Yang Erkun (1):
      ext4: correct the comments place for EXT4_EXT_MAY_ZEROOUT

Yang Yang (1):
      batman-adv: avoid OGM aggregation when skb tailroom is insufficient

Yifan Wu (1):
      selftest/arm64: Fix sve2p1_sigill() to hwcap test

Yihang Li (1):
      scsi: hisi_sas: Use macro instead of magic number

Yongjian Sun (1):
      ext4: fix e4b bitmap inconsistency reports

Yuan Tan (1):
      netfilter: xt_IDLETIMER: reject rev0 reuse of ALARM timer labels

Yujie Liu (1):
      drm/sched: Fix kernel-doc warning for drm_sched_job_done()

Zhang Heng (1):
      ASoC: amd: yc: Add DMI quirk for ASUS EXPERTBOOK PM1503CDA

Zhang Yi (5):
      ext4: subdivide EXT4_EXT_DATA_VALID1
      ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1
      ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before submitting I/O
      ext4: drop extent cache after doing PARTIAL_VALID1 zeroout
      ext4: drop extent cache when splitting extent fails

ZhangGuoDong (2):
      smb/client: fix buffer size for smb311_posix_qinfo in smb2_compound_op()
      smb/client: fix buffer size for smb311_posix_qinfo in SMB311_posix_query_info()

ZhengYuan Huang (1):
      btrfs: tree-checker: fix misleading root drop_level error message

Zilin Guan (3):
      media: tegra-video: Fix memory leak in __tegra_channel_try_format()
      usb: xhci: Fix memory leak in xhci_disable_slot()
      binfmt_misc: restore write access before closing files opened by open_exec()

Ziyi Guo (1):
      usb: image: mdc800: kill download URB on timeout

Zqiang (1):
      rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread pointer access

matteo.cotifava (2):
      ASoC: soc-core: drop delayed_work_pending() check before flush
      ASoC: soc-core: flush delayed work before removing DAIs and widgets

wangshuaiwei (1):
      scsi: ufs: core: Fix shift out of bounds when MAXQ=32

Álvaro Fernández Rojas (1):
      net: sfp: improve Huawei MA5671a fixup


