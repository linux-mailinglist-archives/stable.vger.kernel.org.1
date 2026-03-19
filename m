Return-Path: <stable+bounces-227331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC7gL98avGlEsQIAu9opvQ
	(envelope-from <stable+bounces-227331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:48:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F362CDF91
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A78AC301DF5B
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5112E3E92BD;
	Thu, 19 Mar 2026 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EAoSveJt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CB3E9580;
	Thu, 19 Mar 2026 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935253; cv=none; b=X2RXwwa8CgjTK0BkW0ab2Gve+ipbYo2YjwFPWl8VmdS/iGO9WEnAqCsAFXJUFfuM2awez7xa/OX8q6sEeIZhp/Ccs1kUBKb6t6FABDkjDLHfpazsWiTAMAciUuK1uFHPlVXFaeyNerv9ryxqHX99FFMc4EnIPolG4neRazWWjl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935253; c=relaxed/simple;
	bh=pkPgrpSjSIWdjldfz4KXW3PWzOeIqoisFHXMflXzfww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GtGif5//MB5QB4NvFQ5IdHNXokGgx/6Mn7j9nsm8GSQjRjy/4o2UH07AP4a7r6f/8veH0WkpmiGQIPRvrfkyWbp+t2tbJnNdvGKk5Umk700xHlK+7Dj7lM95pi6KOPjsIPnoATzAzdXI/ivkGFIy0MaBS+X3soUINXkuea9M8O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EAoSveJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC01C19424;
	Thu, 19 Mar 2026 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773935252;
	bh=pkPgrpSjSIWdjldfz4KXW3PWzOeIqoisFHXMflXzfww=;
	h=From:To:Cc:Subject:Date:From;
	b=EAoSveJt2DWe261zl7mWaKTXtIcfmDATAlYIYFdEeDfimwmvYbaniByWkvwSAaRta
	 vMsxYsFivq6FPXkUpc06vc5fQz6t1mAljsnrRYjec+Q6RV0+Uj/gyJDuXQWGu7Q5m3
	 xYNlTuJUlhf4t+pKCkIZiAGP/CWsBzTmjyBRtF0c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.19.9
Date: Thu, 19 Mar 2026 16:47:19 +0100
Message-ID: <2026031919-target-recite-a695@gregkh>
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
	TAGGED_FROM(0.00)[bounces-227331-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52F362CDF91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.19.9 kernel.

All users of the 6.19 kernel series must upgrade.

The updated 6.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/display/msm/dp-controller.yaml    |   21 +
 Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml |   16 
 Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml |    2 
 Documentation/virt/kvm/api.rst                                      |    8 
 Makefile                                                            |    3 
 arch/arm64/include/asm/kvm_host.h                                   |    3 
 arch/arm64/include/asm/pgtable-prot.h                               |   10 
 arch/arm64/kernel/cpufeature.c                                      |    9 
 arch/arm64/kvm/hyp/nvhe/mem_protect.c                               |    2 
 arch/arm64/kvm/mmu.c                                                |   12 
 arch/arm64/kvm/vgic/vgic-init.c                                     |   34 -
 arch/arm64/kvm/vgic/vgic-v2.c                                       |    4 
 arch/arm64/kvm/vgic/vgic-v3.c                                       |   12 
 arch/arm64/kvm/vgic/vgic.c                                          |    6 
 arch/arm64/mm/contpte.c                                             |   53 ++
 arch/arm64/mm/mmap.c                                                |    6 
 arch/parisc/include/asm/pgtable.h                                   |    2 
 arch/parisc/kernel/head.S                                           |    7 
 arch/parisc/kernel/setup.c                                          |   20 -
 arch/powerpc/include/asm/uaccess.h                                  |    2 
 arch/powerpc/kexec/core.c                                           |   17 
 arch/powerpc/kexec/file_load_64.c                                   |   14 
 arch/powerpc/net/bpf_jit_comp.c                                     |   30 +
 arch/powerpc/net/bpf_jit_comp64.c                                   |  101 ++++-
 arch/powerpc/perf/callchain.c                                       |    5 
 arch/powerpc/perf/callchain_32.c                                    |    1 
 arch/powerpc/perf/callchain_64.c                                    |    1 
 arch/powerpc/platforms/83xx/km83xx.c                                |    4 
 arch/powerpc/platforms/pseries/msi.c                                |    2 
 arch/s390/include/asm/processor.h                                   |    2 
 arch/s390/lib/xor.c                                                 |    5 
 arch/s390/mm/pfault.c                                               |    4 
 arch/x86/include/asm/kvm_host.h                                     |    3 
 arch/x86/include/uapi/asm/kvm.h                                     |    1 
 arch/x86/kernel/apic/apic.c                                         |    6 
 arch/x86/kvm/svm/avic.c                                             |    9 
 arch/x86/kvm/svm/svm.c                                              |    9 
 arch/x86/kvm/vmx/nested.c                                           |   22 -
 drivers/accel/amdxdna/aie2_ctx.c                                    |   14 
 drivers/accel/amdxdna/amdxdna_ctx.c                                 |   10 
 drivers/acpi/osi.c                                                  |   13 
 drivers/acpi/osl.c                                                  |    2 
 drivers/acpi/sleep.c                                                |    8 
 drivers/android/binder/page_range.rs                                |   83 +++-
 drivers/android/binder/process.rs                                   |    3 
 drivers/android/binder/range_alloc/array.rs                         |   35 +
 drivers/android/binder/range_alloc/mod.rs                           |    4 
 drivers/android/binder/range_alloc/tree.rs                          |   18 
 drivers/android/binder/thread.rs                                    |   17 
 drivers/ata/libata-core.c                                           |    2 
 drivers/base/property.c                                             |   27 -
 drivers/block/ublk_drv.c                                            |   12 
 drivers/char/ipmi/ipmi_si_intf.c                                    |   37 +
 drivers/cpufreq/intel_pstate.c                                      |    4 
 drivers/cpuidle/cpuidle.c                                           |   10 
 drivers/crypto/ccp/sev-dev.c                                        |   10 
 drivers/cxl/Kconfig                                                 |    1 
 drivers/firmware/cirrus/cs_dsp.c                                    |   24 -
 drivers/firmware/stratix10-rsu.c                                    |    2 
 drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c                          |    7 
 drivers/gpio/gpiolib.c                                              |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                    |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                          |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                             |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h                            |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c                     |   14 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                              |    5 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                              |    5 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c                             |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c              |    1 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c           |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                |   11 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c                |    3 
 drivers/gpu/drm/bridge/samsung-dsim.c                               |   25 -
 drivers/gpu/drm/bridge/ti-sn65dsi83.c                               |   13 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                               |    6 
 drivers/gpu/drm/i915/display/intel_alpm.c                           |   13 
 drivers/gpu/drm/i915/display/intel_display.c                        |    1 
 drivers/gpu/drm/i915/display/intel_dp.c                             |    7 
 drivers/gpu/drm/i915/display/intel_psr.c                            |   50 ++
 drivers/gpu/drm/i915/display/intel_vrr.c                            |   14 
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c                           |   12 
 drivers/gpu/drm/msm/adreno/a2xx_gpummu.c                            |    2 
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c                           |    3 
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c                               |   14 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h            |   12 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h              |   12 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h             |    4 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h              |   12 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_1_sar2130p.h            |   12 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h            |   12 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                  |   43 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c                         |    3 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c               |   12 
 drivers/gpu/drm/sitronix/st7586.c                                   |   15 
 drivers/gpu/drm/ttm/ttm_pool_internal.h                             |    2 
 drivers/gpu/drm/xe/xe_sync.c                                        |   30 +
 drivers/gpu/drm/xe/xe_wa.c                                          |   13 
 drivers/hwmon/pmbus/q54sj108a2.c                                    |   19 -
 drivers/i3c/master/dw-i3c-master.c                                  |    4 
 drivers/i3c/master/mipi-i3c-hci/cmd.h                               |    1 
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c                            |    2 
 drivers/i3c/master/mipi-i3c-hci/cmd_v2.c                            |    2 
 drivers/i3c/master/mipi-i3c-hci/core.c                              |    9 
 drivers/i3c/master/mipi-i3c-hci/dma.c                               |   96 +++--
 drivers/i3c/master/mipi-i3c-hci/hci.h                               |    2 
 drivers/i3c/master/mipi-i3c-hci/pio.c                               |   16 
 drivers/iio/chemical/bme680_core.c                                  |    2 
 drivers/iio/chemical/sps30_i2c.c                                    |    2 
 drivers/iio/chemical/sps30_serial.c                                 |    2 
 drivers/iio/dac/ds4424.c                                            |    2 
 drivers/iio/frequency/adf4377.c                                     |    2 
 drivers/iio/gyro/mpu3050-core.c                                     |   18 
 drivers/iio/gyro/mpu3050-i2c.c                                      |    3 
 drivers/iio/imu/adis.c                                              |    2 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                   |    2 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c                  |    4 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                    |    2 
 drivers/iio/imu/inv_icm45600/inv_icm45600.h                         |    2 
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c                    |   11 
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c                          |    8 
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h                           |    2 
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c                       |    5 
 drivers/iio/industrialio-buffer.c                                   |    6 
 drivers/iio/light/bh1780.c                                          |    2 
 drivers/iio/magnetometer/tlv493d.c                                  |    2 
 drivers/iio/potentiometer/mcp4131.c                                 |    2 
 drivers/iio/proximity/hx9023s.c                                     |    6 
 drivers/irqchip/irq-gic-v3-its.c                                    |    4 
 drivers/irqchip/irq-riscv-aplic-direct.c                            |   10 
 drivers/irqchip/irq-riscv-aplic-main.c                              |  187 +++++++++-
 drivers/irqchip/irq-riscv-aplic-main.h                              |   19 +
 drivers/media/dvb-core/dvb_net.c                                    |    3 
 drivers/mmc/host/dw_mmc-rockchip.c                                  |   38 +-
 drivers/mmc/host/mmci_qcom_dml.c                                    |    1 
 drivers/mmc/host/sdhci-brcmstb.c                                    |    2 
 drivers/net/bonding/bond_main.c                                     |   70 +++
 drivers/net/caif/caif_serial.c                                      |    3 
 drivers/net/can/dev/calc_bittiming.c                                |    2 
 drivers/net/can/spi/hi311x.c                                        |    5 
 drivers/net/can/usb/gs_usb.c                                        |   22 -
 drivers/net/dsa/microchip/ksz_ptp.c                                 |   11 
 drivers/net/dsa/realtek/rtl8365mb.c                                 |    3 
 drivers/net/dsa/realtek/rtl8366rb-leds.c                            |    6 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                            |   19 -
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c                         |   82 ++++
 drivers/net/ethernet/amd/xgbe/xgbe.h                                |    4 
 drivers/net/ethernet/arc/emac_main.c                                |   11 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                   |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                      |   31 -
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                      |    5 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                        |   10 
 drivers/net/ethernet/cadence/macb_main.c                            |   98 +++++
 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c                |   24 -
 drivers/net/ethernet/intel/e1000/e1000_main.c                       |    2 
 drivers/net/ethernet/intel/e1000e/netdev.c                          |    2 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                  |   14 
 drivers/net/ethernet/intel/iavf/iavf.h                              |    3 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c                      |   19 -
 drivers/net/ethernet/intel/iavf/iavf_main.c                         |   81 +---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c                     |    1 
 drivers/net/ethernet/intel/ice/devlink/devlink.c                    |    4 
 drivers/net/ethernet/intel/ice/ice_common.c                         |   13 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                        |   35 -
 drivers/net/ethernet/intel/ixgbevf/vf.c                             |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c             |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c            |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c         |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                     |   23 -
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                   |    7 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                   |    2 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c          |   45 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c                     |    1 
 drivers/net/ethernet/microsoft/mana/mana_en.c                       |   23 -
 drivers/net/ethernet/spacemit/k1_emac.c                             |   19 -
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                            |   16 
 drivers/net/ethernet/ti/am65-cpsw-nuss.h                            |    2 
 drivers/net/mctp/mctp-i2c.c                                         |    1 
 drivers/net/mctp/mctp-usb.c                                         |    3 
 drivers/net/phy/sfp.c                                               |    8 
 drivers/net/usb/lan78xx.c                                           |   12 
 drivers/net/usb/lan78xx.h                                           |    3 
 drivers/net/usb/qmi_wwan.c                                          |    4 
 drivers/net/usb/usbnet.c                                            |    7 
 drivers/nvme/host/pci.c                                             |    8 
 drivers/pinctrl/pinctrl-cy8c95x0.c                                  |    4 
 drivers/pmdomain/bcm/bcm2835-power.c                                |    6 
 drivers/pmdomain/rockchip/pm-domains.c                              |    2 
 drivers/regulator/pca9450-regulator.c                               |   14 
 drivers/regulator/pf9453-regulator.c                                |    2 
 drivers/remoteproc/mtk_scp.c                                        |   39 ++
 drivers/remoteproc/qcom_sysmon.c                                    |    2 
 drivers/remoteproc/qcom_wcnss.c                                     |    2 
 drivers/s390/block/dasd_eckd.c                                      |   16 
 drivers/s390/crypto/zcrypt_ccamisc.c                                |   12 
 drivers/s390/crypto/zcrypt_cex4.c                                   |    3 
 drivers/scsi/hisi_sas/hisi_sas_main.c                               |    2 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                              |    2 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                     |   34 +
 drivers/scsi/qla2xxx/qla_iocb.c                                     |    2 
 drivers/scsi/scsi_scan.c                                            |    8 
 drivers/scsi/ses.c                                                  |    5 
 drivers/scsi/storvsc_drv.c                                          |    5 
 drivers/spi/spi-amlogic-spifc-a4.c                                  |    5 
 drivers/spi/spi-rockchip-sfc.c                                      |    2 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                      |   15 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                           |    5 
 drivers/staging/sm750fb/sm750.c                                     |    1 
 drivers/staging/sm750fb/sm750_hw.c                                  |   22 -
 drivers/ufs/core/ufshcd.c                                           |   11 
 drivers/usb/class/cdc-acm.c                                         |    5 
 drivers/usb/class/cdc-acm.h                                         |    1 
 drivers/usb/class/cdc-wdm.c                                         |    4 
 drivers/usb/class/usbtmc.c                                          |    6 
 drivers/usb/core/message.c                                          |  100 ++++-
 drivers/usb/core/phy.c                                              |    8 
 drivers/usb/core/quirks.c                                           |   16 
 drivers/usb/dwc3/dwc3-pci.c                                         |    2 
 drivers/usb/gadget/function/f_hid.c                                 |    4 
 drivers/usb/gadget/function/f_mass_storage.c                        |   12 
 drivers/usb/gadget/function/f_ncm.c                                 |  146 ++++---
 drivers/usb/gadget/function/f_tcm.c                                 |   14 
 drivers/usb/gadget/function/u_ether.c                               |   67 +--
 drivers/usb/gadget/function/u_ether.h                               |   56 +-
 drivers/usb/gadget/function/u_ether_configfs.h                      |  176 ---------
 drivers/usb/gadget/function/u_ncm.h                                 |    4 
 drivers/usb/gadget/function/uvc_video.c                             |    2 
 drivers/usb/host/xhci-debugfs.c                                     |   10 
 drivers/usb/host/xhci-ring.c                                        |    1 
 drivers/usb/host/xhci.c                                             |    4 
 drivers/usb/image/mdc800.c                                          |    6 
 drivers/usb/misc/uss720.c                                           |    2 
 drivers/usb/misc/yurex.c                                            |    2 
 drivers/usb/renesas_usbhs/common.c                                  |    9 
 drivers/usb/roles/class.c                                           |    7 
 drivers/usb/typec/altmodes/displayport.c                            |    7 
 drivers/usb/typec/tcpm/tcpm.c                                       |    2 
 fs/afs/addr_list.c                                                  |    8 
 fs/btrfs/extent_io.c                                                |    1 
 fs/btrfs/inode.c                                                    |   19 +
 fs/btrfs/ioctl.c                                                    |   24 +
 fs/btrfs/space-info.c                                               |    5 
 fs/btrfs/transaction.c                                              |   16 
 fs/btrfs/uuid-tree.c                                                |   38 ++
 fs/btrfs/uuid-tree.h                                                |    2 
 fs/btrfs/volumes.c                                                  |    6 
 fs/ceph/addr.c                                                      |    1 
 fs/ceph/debugfs.c                                                   |    4 
 fs/ceph/dir.c                                                       |   17 
 fs/ceph/file.c                                                      |    4 
 fs/ceph/inode.c                                                     |    2 
 fs/ceph/mds_client.c                                                |    3 
 fs/file_attr.c                                                      |    2 
 fs/iomap/buffered-io.c                                              |   15 
 fs/iomap/ioend.c                                                    |   13 
 fs/nfs/nfs3proc.c                                                   |    7 
 fs/nfsd/nfsctl.c                                                    |    2 
 fs/nsfs.c                                                           |   15 
 fs/smb/client/cifsglob.h                                            |   11 
 fs/smb/client/dir.c                                                 |    1 
 fs/smb/client/file.c                                                |   18 
 fs/smb/client/fs_context.c                                          |    2 
 fs/smb/client/smb2ops.c                                             |   14 
 fs/smb/client/smb2pdu.c                                             |    5 
 fs/smb/server/auth.c                                                |   22 -
 fs/smb/server/oplock.c                                              |   35 +
 fs/smb/server/oplock.h                                              |    5 
 fs/smb/server/smb2pdu.c                                             |    8 
 fs/xfs/libxfs/xfs_defer.c                                           |    2 
 fs/xfs/xfs_bmap_item.c                                              |    2 
 fs/xfs/xfs_dquot.c                                                  |    8 
 fs/xfs/xfs_log.c                                                    |    2 
 include/kunit/run-in-irq-context.h                                  |   44 +-
 include/linux/damon.h                                               |   10 
 include/linux/io_uring_types.h                                      |    1 
 include/linux/irqchip/arm-gic-v3.h                                  |    1 
 include/linux/kthread.h                                             |   21 +
 include/linux/liveupdate.h                                          |    9 
 include/linux/migrate.h                                             |   10 
 include/linux/mm.h                                                  |   17 
 include/linux/mmc/host.h                                            |    9 
 include/linux/netdevice.h                                           |   32 +
 include/linux/ns_common.h                                           |    2 
 include/linux/rseq_types.h                                          |    6 
 include/linux/sched.h                                               |    2 
 include/linux/usb.h                                                 |    8 
 include/linux/usb/usbnet.h                                          |    1 
 include/net/ip6_tunnel.h                                            |   14 
 include/net/ip_tunnels.h                                            |    7 
 include/net/page_pool/types.h                                       |    2 
 include/trace/events/kmem.h                                         |    8 
 io_uring/eventfd.c                                                  |   10 
 io_uring/io_uring.c                                                 |   26 +
 io_uring/kbuf.c                                                     |   13 
 io_uring/net.c                                                      |    2 
 io_uring/register.c                                                 |   12 
 io_uring/zcrx.c                                                     |    5 
 kernel/bpf/verifier.c                                               |    1 
 kernel/cgroup/cgroup.c                                              |    7 
 kernel/exit.c                                                       |    6 
 kernel/fork.c                                                       |    5 
 kernel/kprobes.c                                                    |    8 
 kernel/kthread.c                                                    |   41 --
 kernel/liveupdate/luo_file.c                                        |   41 +-
 kernel/nscommon.c                                                   |    6 
 kernel/nstree.c                                                     |   29 -
 kernel/sched/core.c                                                 |   79 +---
 kernel/sched/ext.c                                                  |   85 +++-
 kernel/sched/idle.c                                                 |   11 
 kernel/time/time.c                                                  |    2 
 kernel/trace/bpf_trace.c                                            |    4 
 kernel/trace/trace.c                                                |    6 
 kernel/trace/trace_events.c                                         |   58 ++-
 kernel/trace/trace_functions_graph.c                                |   19 -
 kernel/workqueue.c                                                  |    2 
 lib/bootconfig.c                                                    |    6 
 mm/damon/core.c                                                     |   79 ++--
 mm/damon/lru_sort.c                                                 |    4 
 mm/damon/reclaim.c                                                  |    4 
 mm/damon/stat.c                                                     |    2 
 mm/damon/sysfs.c                                                    |   11 
 mm/damon/tests/vaddr-kunit.h                                        |    2 
 mm/damon/vaddr.c                                                    |   24 -
 mm/filemap.c                                                        |   15 
 mm/huge_memory.c                                                    |   13 
 mm/kfence/core.c                                                    |   29 +
 mm/memcontrol.c                                                     |    2 
 mm/memfd_luo.c                                                      |   56 ++
 mm/memory.c                                                         |    3 
 mm/migrate.c                                                        |    8 
 mm/migrate_device.c                                                 |    2 
 mm/page_alloc.c                                                     |    3 
 mm/slub.c                                                           |   54 +-
 net/batman-adv/bat_v_elp.c                                          |   10 
 net/batman-adv/hard-interface.c                                     |    8 
 net/batman-adv/hard-interface.h                                     |    1 
 net/ceph/auth.c                                                     |    6 
 net/ceph/messenger_v2.c                                             |   31 +
 net/ceph/mon_client.c                                               |    6 
 net/core/dev.c                                                      |   17 
 net/core/dev.h                                                      |   35 -
 net/core/neighbour.c                                                |    3 
 net/core/page_pool_user.c                                           |    4 
 net/ipv4/Kconfig                                                    |    2 
 net/ipv4/ip_tunnel_core.c                                           |   15 
 net/ipv4/nexthop.c                                                  |   14 
 net/ipv4/tcp.c                                                      |    3 
 net/ipv4/tcp_ao.c                                                   |    3 
 net/ipv4/tcp_ipv4.c                                                 |    3 
 net/ipv6/tcp_ipv6.c                                                 |    3 
 net/mac80211/link.c                                                 |    2 
 net/mctp/route.c                                                    |   11 
 net/ncsi/ncsi-aen.c                                                 |    3 
 net/ncsi/ncsi-rsp.c                                                 |   16 
 net/netfilter/nf_tables_api.c                                       |    4 
 net/netfilter/nfnetlink_cthelper.c                                  |    8 
 net/netfilter/nfnetlink_queue.c                                     |    4 
 net/netfilter/nft_chain_filter.c                                    |    2 
 net/netfilter/nft_set_pipapo.c                                      |    3 
 net/netfilter/xt_IDLETIMER.c                                        |    6 
 net/netfilter/xt_dccp.c                                             |    4 
 net/netfilter/xt_tcpudp.c                                           |    6 
 net/rxrpc/af_rxrpc.c                                                |    8 
 net/sched/sch_teql.c                                                |    1 
 net/shaper/shaper.c                                                 |   11 
 net/sunrpc/xprtrdma/verbs.c                                         |    7 
 net/tipc/socket.c                                                   |    2 
 rust/Makefile                                                       |    6 
 rust/kernel/str.rs                                                  |    4 
 sound/core/pcm_native.c                                             |   19 -
 sound/hda/codecs/realtek/alc269.c                                   |   25 +
 sound/soc/amd/acp/acp-mach-common.c                                 |   18 
 sound/soc/amd/acp3x-rt5682-max9836.c                                |    9 
 sound/soc/amd/yc/acp6x-mach.c                                       |   14 
 sound/soc/codecs/cs42l43-jack.c                                     |    1 
 sound/soc/codecs/rt1011.c                                           |    2 
 sound/soc/generic/simple-card-utils.c                               |   12 
 sound/soc/qcom/qdsp6/q6apm-dai.c                                    |    1 
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c                             |    1 
 sound/soc/qcom/qdsp6/q6apm.c                                        |    1 
 sound/soc/soc-core.c                                                |   11 
 sound/usb/endpoint.c                                                |    1 
 sound/usb/format.c                                                  |   70 +++
 sound/usb/mixer_scarlett2.c                                         |    2 
 sound/usb/quirks.c                                                  |    2 
 tools/objtool/check.c                                               |   10 
 tools/objtool/elf.c                                                 |    2 
 tools/objtool/klp-diff.c                                            |    3 
 tools/perf/builtin-ftrace.c                                         |    9 
 tools/perf/util/annotate.c                                          |    5 
 tools/perf/util/disasm.c                                            |    2 
 tools/perf/util/synthetic-events.c                                  |    5 
 tools/testing/selftests/filesystems/nsfs/iterate_mntns.c            |   25 -
 394 files changed, 3523 insertions(+), 1770 deletions(-)

A1RM4X (1):
      USB: add QUIRK_NO_BOS for video capture several devices

Abel Vesa (1):
      dt-bindings: display: msm: Fix reg ranges and clocks on Glymur

Abhinav Kumar (1):
      drm/msm/dpu: Correct the SA8775P intr_underrun/intr_underrun index

Adrian Hunter (7):
      i3c: mipi-i3c-hci: Use ETIMEDOUT instead of ETIME for timeout errors
      i3c: mipi-i3c-hci: Factor out DMA mapping from queuing path
      i3c: mipi-i3c-hci: Consolidate spinlocks
      i3c: mipi-i3c-hci: Restart DMA ring correctly after dequeue abort
      i3c: mipi-i3c-hci: Add missing TID field to no-op command descriptor
      i3c: mipi-i3c-hci: Fix race in DMA ring dequeue
      i3c: mipi-i3c-hci: Correct RING_CTRL_ABORT handling in DMA dequeue

Adrian Ng Ho Yin (1):
      i3c: dw-i3c-master: Set SIR_REJECT in DAT on device attach and reattach

Akhil P Oommen (2):
      drm/msm/a6xx: Fix the bogus protect error on X2-85
      drm/msm/a8xx: Fix ubwc config related to swizzling

Al Viro (1):
      unshare: fix unshare_fs() handling

Alan Stern (3):
      USB: usbcore: Introduce usb_bulk_msg_killable()
      USB: usbtmc: Use usb_bulk_msg_killable() with user-specified timeouts
      USB: core: Limit the length of unkillable synchronous timeouts

Alexander Gordeev (1):
      s390/pfault: Fix virtual vs physical address confusion

Alexander Potapenko (2):
      mm/kfence: fix KASAN hardware tag faults during late enablement
      mm/kfence: disable KFENCE upon KASAN HW tags enablement

Alexandre Courbot (1):
      rust: str: make NullTerminatedFormatter public

Alice Ryhl (3):
      rust_binder: check ownership before using vma
      rust_binder: avoid reading the written value in offsets array
      rust_binder: call set_notification_done() without proc lock

Alok Tiwari (3):
      i40e: fix src IP mask checks and memcpy argument names in cloud filter
      octeontx2-af: devlink: fix NIX RAS reporter recovery condition
      octeontx2-af: devlink: fix NIX RAS reporter to use RAS interrupt status

Alysa Liu (1):
      drm/amdgpu: Fix use-after-free race in VM acquire

Andreas Kemnade (1):
      iio: imu: inv-mpu9150: fix irq ack preventing irq storms

Andrei-Alexandru Tachici (1):
      tracing: Fix enabling multiple events on the kernel command line and bootconfig

Andy Shevchenko (2):
      device property: Allow secondary lookup in fwnode_get_next_child_node()
      pinctrl: cy8c95x0: Don't miss reading the last bank registers

Antoniu Miclaus (6):
      iio: chemical: sps30_serial: fix buffer size in sps30_serial_read_meas()
      iio: chemical: sps30_i2c: fix buffer size in sps30_i2c_read_meas()
      iio: magnetometer: tlv493d: remove erroneous shift in X-axis data
      iio: gyro: mpu3050-core: fix pm_runtime error handling
      iio: gyro: mpu3050-i2c: fix pm_runtime error handling
      iio: light: bh1780: fix PM runtime leak on error path

Ariel Silver (1):
      media: dvb-net: fix OOB access in ULE extension header tables

Artem Lytkin (1):
      staging: sm750fb: add missing pci_release_region on error and removal

Arun R Murthy (1):
      drm/i915/dp: Read ALPM caps after DPCD init

Ashish Kalra (1):
      crypto: ccp - allow callers to use HV-Fixed page API when SEV is disabled

Axel Rasmussen (1):
      Revert "ptdesc: remove references to folios from __pagetable_ctor() and pagetable_dtor()"

Azamat Almazbek uulu (1):
      ASoC: amd: yc: Add ASUS EXPERTBOOK BM1503CDA to quirk table

Bart Van Assche (1):
      btrfs: add missing RCU unlock in error path in try_release_subpage_extent_buffer()

Bartosz Golaszewski (1):
      gpiolib: normalize the return value of gc->get() on behalf of buggy drivers

Bastien Curutchet (Schneider Electric) (1):
      net: dsa: microchip: Fix error path in PTP IRQ setup

Ben Dooks (1):
      ACPI: OSL: fix __iomem type on return from acpi_os_map_generic_address()

Bharath SM (1):
      smb: client: fix in-place encryption corruption in SMB2_write()

Bjorn Andersson (1):
      remoteproc: sysmon: Correct subsys_name_len type in QMI request

Breno Leitao (1):
      workqueue: Use POOL_BH instead of WQ_BH when checking pool flags

Calvin Owens (1):
      tracing: Fix trace_buf_size= cmdline parameter with sizes >= 2G

Carlos Llamas (1):
      rust_binder: fix oneway spam detection

Carlos Maiolino (1):
      xfs: fix returned valued from xfs_defer_can_append

Carolina Jubran (1):
      net/mlx5: Fix peer miss rules host disabled checks

Casey Connolly (1):
      ASoC: detect empty DMI strings

Catalin Marinas (2):
      arm64: gcs: Honour mprotect(PROT_NONE) on shadow stack mappings
      arm64: mm: Add PTE_DIRTY back to PAGE_KERNEL* to fix kexec/hibernation

Charles Keepax (1):
      ASoC: cs42l43: Report insert for exotic peripherals

Chen Ni (4):
      perf annotate: Fix hashmap__new() error checking
      perf ftrace: Fix hashmap__new() error checking
      ASoC: amd: acp3x-rt5682-max9836: Add missing error check for clock acquisition
      ASoC: amd: acp-mach-common: Add missing error check for clock acquisition

Cheng-Yang Chou (1):
      sched_ext: Remove redundant css_put() in scx_cgroup_init()

Chengfeng Ye (1):
      mctp: route: hold key->lock in mctp_flow_prepare_output()

Chintan Vankar (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix rx_filter value for PTP support

Chris Spencer (1):
      iio: chemical: bme680: Fix measurement wait duration calculation

Christian Brauner (5):
      nsfs: tighten permission checks for ns iteration ioctls
      kthread: consolidate kthread exit paths to prevent use-after-free
      nsfs: tighten permission checks for handle opening
      nstree: tighten permission checks for listing
      selftests: fix mntns iteration selftests

Christian Loehle (1):
      bpf: drop kthread_exit from noreturn_deny

Christoffer Sandberg (1):
      usb/core/quirks: Add Huawei ME906S-device to wakeup quirk

Christophe Leroy (CS GROUP) (1):
      powerpc/uaccess: Fix inline assembly for clang build on PPC32

Chuck Lever (1):
      perf synthetic-events: Fix stale build ID in module MMAP2 records

Corey Minyard (4):
      ipmi:si: Don't block module unload if the BMC is messed up
      ipmi:si: Use a long timeout when the BMC is misbehaving
      ipmi:si: Handle waiting messages when BMC failure detected
      ipmi:si: Fix check for a misbehaving BMC

Cosmin Ratiu (1):
      net/mlx5: Fix deadlock between devlink lock and esw->wq

Cristian Ciocaltea (1):
      drm/amdgpu: Fix kernel-doc comments for some LUT properties

Darrick J. Wong (2):
      iomap: reject delalloc mappings during writeback
      xfs: fix undersized l_iclog_roundoff values

Dave Airlie (2):
      nouveau/gsp: drop WARN_ON in ACPI probes
      nouveau/dpcd: return EBUSY for aux xfer if the device is asleep

David Arcari (1):
      cpufreq: intel_pstate: Fix NULL pointer dereference in update_cpu_qos_request()

David Dull (1):
      netfilter: x_tables: guard option walkers against 1-byte tail reads

David Lechner (1):
      drm/sitronix/st7586: fix bad pixel data due to byte swap

Dayu Jiang (1):
      usb: xhci: Prevent interrupt storm on host controller error (HCE)

Dillon Varone (1):
      drm/amd/display: Fallback to boot snapshot for dispclk

Dragos Tatulea (2):
      net/mlx5e: RX, Fix XDP multi-buf frag counting for striding RQ
      net/mlx5e: RX, Fix XDP multi-buf frag counting for legacy RQ

Edward Adam Davis (1):
      fs: init flags_valid before calling vfs_fileattr_get

Eric Badger (1):
      xprtrdma: Decrement re_receiving on the early exit paths

Eric Biggers (3):
      kunit: irq: Ensure timer doesn't fire too frequently
      net/tcp-ao: Fix MAC comparison to be constant-time
      net/tcp-md5: Fix MAC comparison to be constant-time

Eric Dumazet (1):
      net: prevent NULL deref in ip[6]tunnel_xmit()

Fan Wu (2):
      usb: renesas_usbhs: fix use-after-free in ISR during device removal
      net: ethernet: arc: emac: quiesce interrupts before requesting IRQ

Felix Gu (3):
      spi: amlogic: spifc-a4: Fix DMA mapping error handling
      spi: rockchip-sfc: Fix double-free in remove() callback
      mmc: mmci: Fix device_node reference leak in of_get_dml_pipe_index()

Filipe Manana (4):
      btrfs: fix transaction abort when snapshotting received subvolumes
      btrfs: fix transaction abort on file creation due to name hash collision
      btrfs: fix transaction abort on set received ioctl due to item overflow
      btrfs: abort transaction on failure to update root in the received subvol ioctl

Florian Westphal (1):
      netfilter: nf_tables: always walk all pending catchall elements

Franz Schnyder (2):
      drm/bridge: ti-sn65dsi86: Enable HPD polling if IRQ is not used
      regulator: pf9453: Respect IRQ trigger settings from firmware

Gabor Juhos (1):
      usb: core: don't power off roothub PHYs if phy_set_mode() fails

Gal Pressman (1):
      net/mlx5e: Fix DMA FIFO desync on error CQE SQ recovery

Gary Guo (1):
      rust: kbuild: emit dep-info into $(depfile) directly

Geoffrey D. Bennett (1):
      ALSA: usb-audio: Improve Focusrite sample rate filtering

Greg Kroah-Hartman (3):
      usb: misc: uss720: properly clean up reference in uss720_probe()
      staging: rtl8723bs: properly validate the data in rtw_get_ie_ex()
      Linux 6.19.9

Guenter Roeck (1):
      smb/server: Fix another refcount leak in smb2_open()

Haibo Chen (1):
      can: dev: keep the max bitrate error at 5%

Haiyue Wang (1):
      mctp: i2c: fix skb memory leak in receive path

Hangbin Liu (2):
      bonding: do not set usable_slaves for broadcast mode
      bonding: handle BOND_LINK_FAIL, BOND_LINK_BACK as valid link states

Hao Li (1):
      memcg: fix slab accounting in refill_obj_stock() trylock path

Harald Freudenberger (1):
      s390/zcrypt: Enable AUTOSEL_DOM for CCA serialnr sysfs attribute

Hari Bathini (2):
      powerpc64/bpf: fix kfunc call support
      powerpc64/bpf: fix the address returned by bpf_get_func_ip

Harry Yoo (1):
      mm/slab: fix an incorrect check in obj_exts_alloc_size()

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Nova Lake -H

Heiko Carstens (2):
      s390/stackleak: Fix __stackleak_poison() inline assembly constraint
      s390/xor: Fix xor_xc_2() inline assembly constraints

Helge Deller (3):
      parisc: Increase initial mapping to 64 MB with KALLSYMS
      parisc: Fix initial page table creation for boot
      parisc: Check kernel mapping earlier at bootup

Henrique Carvalho (1):
      smb: client: fix iface port assignment in parse_server_interfaces

Hristo Venev (1):
      ceph: do not skip the first folio of the next object in writeback

Huiwen He (1):
      tracing: Fix syscall events activation by ensuring refcount hits zero

Hyunwoo Kim (2):
      netfilter: nfnetlink_queue: fix entry leak in bridge verdict error path
      netfilter: nfnetlink_cthelper: fix OOB read in nfnl_cthelper_dump_table()

Ilya Dryomov (3):
      libceph: reject preamble if control segment is empty
      libceph: prevent potential out-of-bounds reads in process_message_header()
      libceph: admit message frames only in CEPH_CON_S_OPEN state

J. Neuschäfer (1):
      powerpc: 83xx: km83xx: Fix keymile vendor prefix

Jakub Kicinski (1):
      page_pool: store detach_time as ktime_t to avoid false-negatives

Jakub Staniszewski (2):
      ice: reintroduce retry mechanism for indirect AQ
      ice: fix retry for AQ command 0x06EE

Jan Kiszka (1):
      scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT

Janusz Krzysztofik (1):
      drm/i915: Fix potential overflow of shmem scatterlist length

Jean-Baptiste Maneyrol (4):
      iio: imu: inv_icm45600: fix regulator put warning when probe fails
      iio: imu: inv_icm45600: fix INT1 drive bit inverted
      iio: imu: inv_icm42600: fix odr switch to the same value
      iio: imu: inv_icm42600: fix odr switch when turning buffer off

Jedrzej Jagielski (1):
      ixgbevf: fix link setup issue

Jenny Guanni Qu (1):
      netfilter: nft_set_pipapo: fix stack out-of-bounds read in pipapo_drop()

Jens Axboe (3):
      io_uring/kbuf: check if target buffer list is still legacy on recycle
      io_uring: ensure ctx->rings is stable for task work flags manipulation
      io_uring/eventfd: use ctx->rings_rcu for flags checking

Jessica Liu (2):
      irqchip/riscv-aplic: Do not clear ACPI dependencies on probe failure
      irqchip/riscv-aplic: Register syscore operations only once

Jian Zhang (1):
      net: ncsi: fix skb leak in error paths

Jiasheng Jiang (1):
      usb: gadget: f_tcm: Fix NULL pointer dereferences in nexus handling

Jiayuan Chen (1):
      bonding: fix type confusion in bond_setup_by_slave()

Jim Mattson (1):
      KVM: x86: Introduce KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM

Jiri Olsa (1):
      bpf: Fix kprobe_multi cookies access in show_fdinfo callback

Joanne Koong (1):
      iomap: don't mark folio uptodate if read IO has bytes pending

Johan Hovold (2):
      gpib: lpvo_usb: fix unintended binding of FTDI 8U232AM devices
      net: mctp: fix device leak on probe failure

John Keeping (1):
      usb: gadget: f_hid: fix SuperSpeed descriptors

Josh Law (3):
      lib/bootconfig: fix off-by-one in xbc_verify_tree() unclosed brace error
      lib/bootconfig: fix snprintf truncation check in xbc_node_compose_key_after()
      lib/bootconfig: check bounds before writing in __xbc_open_brace()

Josh Poimboeuf (3):
      objtool/klp: Fix detection of corrupt static branch/call entries
      objtool: Fix data alignment in elf_add_data()
      objtool: Fix another stack overflow in validate_branch()

Jouni Högander (2):
      drm/i915/alpm: ALPM disable fixes
      drm/i915/psr: Repeat Selective Update area alignment

Junxiao Bi (1):
      scsi: core: Fix error handling for scsi_alloc_sdev()

Junzhong Pan (1):
      usb: gadget: uvc: fix interval_duration calculation

Kalesh Singh (1):
      mm/tracing: rss_stat: ensure curr is false from kthread context

Kamal Dasu (1):
      mmc: sdhci-brcmstb: use correct register offset for V1 pin_sel restore

Keith Busch (1):
      cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate mismatch

Kevin Hao (1):
      net: macb: Shuffle the tx ring before enabling tx

Konrad Dybcio (1):
      drm/msm/dpu: Fix LM size on a number of platforms

Krzysztof Kozlowski (1):
      dt-bindings: display/msm: qcom,sm8750-mdss: Fix model typo

Kuen-Han Tsai (8):
      usb: gadget: f_ncm: Fix atomic context locking issue
      usb: legacy: ncm: Fix NPE in gncm_bind
      Revert "usb: gadget: f_ncm: Fix atomic context locking issue"
      Revert "usb: legacy: ncm: Fix NPE in gncm_bind"
      Revert "usb: gadget: u_ether: Add auto-cleanup helper for freeing net_device"
      Revert "usb: gadget: f_ncm: align net_device lifecycle with bind/unbind"
      Revert "usb: gadget: u_ether: add gether_opts for config caching"
      usb: gadget: f_ncm: Fix net_device lifecycle with device_move

Kuniyuki Iwashima (1):
      nfsd: Fix cred ref leak in nfsd_nl_listener_set_doit().

Laurent Vivier (1):
      qmi_wwan: allow max_mtu above hard_mtu to control rx_urb_size

Liwei Song (1):
      firmware: stratix10-rsu: Fix NULL pointer dereference when RSU is disabled

Lizhi Hou (1):
      accel/amdxdna: Fix runtime suspend deadlock when there is pending job

Long Li (3):
      net: mana: Ring doorbell at 4 CQ wraparounds
      xfs: fix integer overflow in bmap intent sort comparator
      xfs: ensure dquot item is deleted from AIL only after log shutdown

Luca Ceresoli (2):
      drm/bridge: ti-sn65dsi83: fix CHA_DSI_CLK_RANGE rounding
      drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual LVDS output

Luka Gejak (1):
      staging: rtl8723bs: fix potential out-of-bounds read in rtw_restruct_wmm_ie

Lukas Schmid (1):
      iio: potentiometer: mcp4131: fix double application of wiper shift

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_open(): always configure bitrates before starting device

Marc Zyngier (7):
      KVM: arm64: Fix protected mode handling of pages larger than 4kB
      KVM: arm64: pkvm: Fallback to level-3 mapping on host stage-2 fault
      KVM: arm64: vgic: Pick EOIcount deactivations from AP-list tail
      KVM: arm64: pkvm: Don't reprobe for ICH_VTR_EL2.TDS on CPU hotplug
      usb: cdc-acm: Restore CAP_BRK functionnality to CH343
      irqchip/gic-v3-its: Limit number of per-device MSIs to the range the ITS supports
      KVM: arm64: Eagerly init vgic dist/redist on vgic creation

Marek Behún (1):
      net: dsa: realtek: Fix LED group port bit for non-zero LED group

Mario Limonciello (4):
      drm/amd: Disable MES LR compute W/A
      drm/amd: Set num IP blocks to 0 if discovery fails
      drm/amd: Fix NULL pointer dereference in device cleanup
      drm/amd: Fix a few more NULL pointer dereference in device cleanup

Marios Makassikis (1):
      smb: server: fix use-after-free in smb2_open()

Mark Harmstone (1):
      btrfs: fix chunk map leak in btrfs_map_block() after btrfs_chunk_map_num_copies()

Masami Hiramatsu (Google) (2):
      kprobes: avoid crash when rmmod/insmod after ftrace killed
      kprobes: Remove unneeded warnings from __arm_kprobe_ftrace()

Mathias Nyman (1):
      xhci: Fix NULL pointer dereference when reading portli debugfs files

Matt Roper (1):
      drm/xe/xe2_hpg: Correct implementation of Wa_16025250150

Matt Vollrath (1):
      e1000/e1000e: Fix leak in DMA error cleanup

Max Kellermann (3):
      ceph: fix i_nlink underrun during async unlink
      ceph: fix memory leaks in ceph_mdsc_build_path()
      ceph: add a bunch of missing ceph_path_info initializers

Maximilian Pezzullo (1):
      ata: libata-core: Disable LPM on ST1000DM010-2EP102

Maíra Canal (1):
      pmdomain: bcm: bcm2835-power: Fix broken reset status read

Mehul Rao (4):
      ALSA: pcm: fix use-after-free on linked stream runtime in snd_pcm_drain()
      tipc: fix divide-by-zero in tipc_sk_filter_connect()
      net: nexthop: fix percpu use-after-free in remove_nh_grp_entry
      ublk: fix NULL pointer dereference in ublk_ctrl_set_size()

Miaoqian Lin (1):
      rxrpc, afs: Fix missing error pointer check after rxrpc_kernel_lookup_peer()

Mieczyslaw Nalewaj (1):
      net: dsa: realtek: rtl8365mb: remove ifOutDiscards from rx_packets

Miguel Ojeda (1):
      rust: kbuild: allow `unused_features`

Nam Cao (1):
      powerpc/pseries: Correct MSI allocation tracking

Namjae Jeon (2):
      ksmbd: fix use-after-free in smb_lazy_parent_lease_break_close()
      ksmbd: fix use-after-free by using call_rcu() for oplock_info

Nick Hu (1):
      irqchip/riscv-aplic: Preserve APLIC states across suspend/resume

Nicolai Buchwitz (1):
      net: bcmgenet: fix broken EEE by converting to phylib-managed state

Nikolay Aleksandrov (1):
      drivers: net: ice: fix devlink parameters get without irdma

Nuno Sá (1):
      iio: buffer: Fix wait_queue not being removed

Oleksij Rempel (5):
      net: usb: lan78xx: fix silent drop of packets with checksum errors
      net: usb: lan78xx: fix TX byte statistics for small packets
      net: usb: lan78xx: fix WARN in __netif_napi_del_locked on disconnect
      net: usb: lan78xx: skip LTM configuration for LAN7850
      iio: dac: ds4424: reject -128 RAW value

Oliver Neukum (3):
      usb: yurex: fix race in probe
      usb: class: cdc-wdm: fix reordering issue in read code path
      usb: mdc800: handle signal and read racing

Osama Abdelkader (1):
      drm/bridge: samsung-dsim: Fix memory leak in error path

Patrisious Haddad (1):
      net/mlx5: Fix crash when moving to switchdev mode

Paul Moses (1):
      net-shapers: don't free reply skb after genlmsg_reply()

Paulo Alcantara (1):
      smb: client: fix atomic open with O_DIRECT & O_SYNC

Pavan Chebbi (1):
      bnxt_en: Fix RSS table size check when changing ethtool channels

Pavel Begunkov (2):
      io_uring/zcrx: use READ_ONCE with user shared RQEs
      io_uring/net: reject SEND_VECTORIZED when unsupported

Pedro Falcato (1):
      ata: libata-core: Add BRIDGE_OK quirk for QEMU drives

Peng Fan (2):
      regulator: pca9450: Correct interrupt type
      regulator: pca9450: Correct probed name for PCA9452

Penghe Geng (1):
      mmc: core: Avoid bitfield RMW for claim/retune flags

Pengyu Luo (2):
      drm/msm/dsi: fix hdisplay calculation when programming dsi registers
      drm/msm/dsi: fix pclk rate calculation for bonded dsi

Perry Yuan (1):
      drm/amdgpu: ensure no_hw_access is visible before MMIO

Peter Collingbourne (1):
      perf disasm: Fix off-by-one bug in outside check

Peter Ujfalusi (1):
      ASoC: codecs: rt1011: Use component to get the dapm context in spk_mode_put

Peter Wang (1):
      scsi: ufs: core: Fix possible NULL pointer dereference in ufshcd_add_command_trace()

Petr Oros (2):
      iavf: fix PTP use-after-free during reset
      iavf: fix incorrect reset handling in callbacks

Phil Sutter (1):
      netfilter: nf_tables: Fix for duplicate device in netdev hooks

Philip Yang (1):
      drm/amdkfd: Unreserve bo if queue update failed

Piotr Jaroszynski (1):
      arm64: contpte: fix set_access_flags() no-op check for SMMU/ATS faults

Piotr Mazek (1):
      ACPI: PM: Save NVS memory on Lenovo G70-35

Pratyush Yadav (Google) (3):
      liveupdate: luo_file: remember retrieve() status
      mm: memfd_luo: always make all folios uptodate
      mm: memfd_luo: always dirty all folios

Qingye Zhao (1):
      cgroup: fix race between task migration and iteration

RD Babiera (1):
      usb: typec: altmode/displayport: set displayport signaling rate in configure message

Radu Sabau (1):
      iio: imu: adis: Fix NULL pointer dereference in adis_init

Rafael J. Wysocki (1):
      sched: idle: Make skipping governor callbacks more consistent

Raju Rangoju (3):
      amd-xgbe: fix link status handling in xgbe_rx_adaptation
      amd-xgbe: prevent CRC errors during RX adaptation with AN disabled
      amd-xgbe: reset PHY settings before starting PHY

Ramanathan Choodamani (1):
      wifi: mac80211: set default WMM parameters on all links

Ranjan Kumar (1):
      scsi: mpi3mr: Add NULL checks when resetting request and reply queues

Raphael Zimmer (2):
      libceph: Fix potential out-of-bounds access in ceph_handle_auth_reply()
      libceph: Use u32 for non-negative values in ceph_monmap_decode()

Raul Pazemecxas De Andrade (1):
      mm/damon/core: clear walk_control on inactive context in damos_walk()

Ravi Hothi (1):
      ASoC: qcom: qdsp6: Fix q6apm remove ordering during ADSP stop and start

Ricardo B. Marlière (1):
      net: bonding: Fix nd_tbl NULL dereference when IPv6 is disabled

Richard Fitzgerald (1):
      firmware: cs_dsp: Fix fragmentation regression in firmware download

Rob Herring (Arm) (1):
      remoteproc: qcom_wcnss: Fix reserved region mapping failure

Roberto Bergantinos Corpas (1):
      nfs: return EISDIR on nfs3_proc_create if d_alias is a dir

Sabrina Dubroca (1):
      neighbour: restore protocol != 0 check in pneigh update

Sanman Pradhan (1):
      hwmon: (pmbus/q54sj108a2) fix stack overflow in debugfs read

Sascha Bischoff (1):
      KVM: arm64: gic: Set vgic_model before initing private IRQs

Sean Christopherson (2):
      KVM: SVM: Initialize AVIC VMCB fields if AVIC is enabled with in-kernel APIC
      KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activated

Sean Rhodes (1):
      ALSA: hda/realtek: Fix speaker pop on Star Labs StarFighter

Sebastian Andrzej Siewior (1):
      cgroup: Don't expose dead tasks in cgroup

Sen Wang (1):
      ASoC: simple-card-utils: fix graph_util_is_ports0() for DT overlays

SeongJae Park (3):
      mm/damon: rename DAMON_MIN_REGION to DAMON_MIN_REGION_SZ
      mm/damon: rename min_sz_region of damon_ctx to min_region_sz
      mm/damon/core: disallow non-power of two min_region_sz

SeungJu Cheon (1):
      iio: frequency: adf4377: Fix duplicated soft reset mask

Seungjin Bae (1):
      usb: gadget: f_mass_storage: Fix potential integer overflow in check_command_size_in_blocks()

Shashank Balaji (1):
      x86/apic: Disable x2apic on resume if the kernel expects so

Shawn Lin (2):
      mmc: dw_mmc-rockchip: Fix runtime PM support for internal phase support
      pmdomain: rockchip: Fix PD_VCODEC for RK3588

Shengming Hu (2):
      fgraph: Fix thresh_return clear per-task notrace
      fgraph: Fix thresh_return nosleeptime double-adjust

Shiraz Saleem (1):
      net/mana: Null service_wq on setup error to prevent double destroy

Shuangpeng Bai (1):
      serial: caif: hold tty->link reference in ldisc_open and ser_release

Shuicheng Lin (2):
      drm/xe/sync: Fix user fence leak on alloc failure
      drm/xe/sync: Cleanup partially initialized sync on parse failure

Shyam Prasad N (1):
      cifs: make default value of retrans as zero

Sofia Schneider (1):
      ACPI: OSI: Add DMI quirk for Acer Aspire One D255

Sourabh Jain (2):
      powerpc/kexec/core: use big-endian types for crash variables
      powerpc/crash: adjust the elfcorehdr size

Stefan Haberland (2):
      s390/dasd: Move quiesce state with pprc swap
      s390/dasd: Copy detected format information to secondary device

Steven Rostedt (1):
      time/jiffies: Mark jiffies_64_to_clock_t() notrace

Sun YangKai (1):
      btrfs: hold space_info->lock when clearing periodic reclaim ready

Sungwoo Kim (2):
      nvme-pci: Fix slab-out-of-bounds in nvme_dbbuf_set
      nvme-pci: Fix race bug in nvme_poll_irqdisable()

Sunil Khatri (2):
      drm/amdgpu: add upper bound check on user inputs in signal ioctl
      drm/amdgpu: add upper bound check on user inputs in wait ioctl

Sven Eckelmann (1):
      batman-adv: Avoid double-rtnl_lock ELP metric worker

Takashi Iwai (3):
      ALSA: usb-audio: Avoid implicit feedback mode on DIYINHK USB Audio 2.0
      ALSA: usb-audio: Check max frame size for implicit feedback mode, too
      ALSA: usb-audio: Check endpoint numbers at parsing Scarlett2 mixer interfaces

Tejun Heo (3):
      sched_ext: Disable preemption between scx_claim_exit() and kicking helper work
      sched_ext: Fix starvation of scx_enable() under fair-class saturation
      sched_ext: Fix enqueue_task_scx() truncation of upper enqueue flags

Thomas Fourier (1):
      drm/msm: Fix dma_free_attrs() buffer size

Thomas Gleixner (4):
      sched/mmcid: Prevent CID stalls due to concurrent forks
      sched/mmcid: Handle vfork()/CLONE_VM correctly
      sched/mmcid: Remove pointless preempt guard
      sched/mmcid: Avoid full tasklist walks

Thomas Hellström (1):
      mm: Fix a hmm_range_fault() livelock / starvation problem

Thorsten Blum (1):
      ksmbd: Don't log keys in SMB3 signing and encryption key generation

Tom Ryan (1):
      io_uring: fix physical SQE bounds check for SQE_MIXED 128-byte ops

Tomas Henzl (1):
      scsi: ses: Fix devices attaching to different hosts

Tvrtko Ursulin (2):
      drm/amdgpu/userq: Fix reference leak in amdgpu_userq_wait_ioctl
      drm/ttm: Fix ttm_pool_beneficial_order() return type

Tzung-Bi Shih (1):
      remoteproc: mediatek: Unprepare SCP clock during system suspend

Vasily Gorbik (1):
      s390/xor: Fix xor_xc_5() inline assembly

Viktor Malik (1):
      powerpc, perf: Check that current->mm is alive before getting user callchain

Ville Syrjälä (1):
      drm/i915/vrr: Configure VRR timings after enabling TRANS_DDI_FUNC_CTL

Vivian Wang (2):
      net: spacemit: Fix error handling in emac_alloc_rx_desc_buffers()
      net: spacemit: Fix error handling in emac_tx_mem_map()

Vladimir Riabchun (1):
      scsi: qla2xxx: Completely fix fcport double free

Vlastimil Babka (1):
      slab: distinguish lock and trylock for sheaf_flush_main()

Vyacheslav Vahnenko (1):
      USB: ezcap401 needs USB_QUIRK_NO_BOS to function on 10gbs usb speed

Wang Shuaiwei (1):
      scsi: ufs: core: Fix SError in ufshcd_rtc_work() during UFS suspend

Wei Fang (2):
      net: enetc: fix incorrect fallback PHY address handling
      net: enetc: do not skip setting LaBCR[MDIO_PHYAD_PRTAD] for addr 0

Weiming Shi (2):
      net/sched: teql: fix NULL pointer dereference in iptunnel_xmit on TEQL slave xmit
      net: add xmit recursion limit to tunnel xmit functions

Wenyuan Li (1):
      can: hi311x: hi3110_open(): add check for hi3110_power_enable() return value

Won Jung (1):
      scsi: ufs: core: Reset urgent_bkops_lvl to allow runtime PM power mode

Xingui Yang (1):
      scsi: hisi_sas: Fix NULL pointer exception during user_scan()

Xu Yang (2):
      usb: roles: get usb role switch from parent only for usb-b-connector
      Revert "tcpm: allow looking for role_sw device in the main node"

Yang Wang (3):
      drm/amd/pm: add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu v13
      drm/amd/pm: add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu v14
      drm/amd/pm: remove invalid gpu_metrics.energy_accumulator on smu v13.0.x

Yasin Lee (2):
      iio: proximity: hx9023s: fix assignment order for __counted_by
      iio: proximity: hx9023s: Protect against division by zero in set_samp_freq

YiFei Zhu (1):
      net: Fix rcu_tasks stall in threaded busypoll

Yuan Tan (1):
      netfilter: xt_IDLETIMER: reject rev0 reuse of ALARM timer labels

Zhang Heng (1):
      ASoC: amd: yc: Add DMI quirk for ASUS EXPERTBOOK PM1503CDA

Zi Yan (1):
      mm/huge_memory: fix a folio_split() race condition with folio_try_get()

Zilin Guan (1):
      usb: xhci: Fix memory leak in xhci_disable_slot()

Ziyi Guo (1):
      usb: image: mdc800: kill download URB on timeout

matteo.cotifava (2):
      ASoC: soc-core: drop delayed_work_pending() check before flush
      ASoC: soc-core: flush delayed work before removing DAIs and widgets

sguttula (1):
      drm/amdgpu/vcn5: Add SMU dpm interface type

wangshuaiwei (1):
      scsi: ufs: core: Fix shift out of bounds when MAXQ=32

zhidao su (1):
      sched_ext: Use WRITE_ONCE() for the write side of scx_enable helper pointer

Álvaro Fernández Rojas (1):
      net: sfp: improve Huawei MA5671a fixup


