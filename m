Return-Path: <stable+bounces-230303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJuBDs23w2litgQAu9opvQ
	(envelope-from <stable+bounces-230303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:24:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95930322DC4
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FD1F316264B
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89763AC0D0;
	Wed, 25 Mar 2026 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mllj9E50"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5174C3AA504;
	Wed, 25 Mar 2026 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433798; cv=none; b=G33lAr+8jYNr8j+5qk4pK4EHaAI7CAl4TlZSqY69sqo9ymmHo1DGePZIsV7sQJ2IFHOgbKFyCckXhWXgo0THbwmrlcMhp9WMQFsKlKjH3LBo+Je8oJGO7VrkaaXkfOWNzHGTL/C4fgZFvU1XEZnT8vbnKRkal3wuvy7ZHmVHu70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433798; c=relaxed/simple;
	bh=U01JBVboQt7MMZE8wTfay7YiBkwHABoj7US7ZOkkTCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p+Gk+tmiRkvz35WAu0h9fDqa4/mZsk9Zj7J5sYmGLjadpu4mZaloto0SKHfQup+QermJq8fBtB9WJHInhRbDuILnGVUk//Ddv3iylZQmOGKZR44W+vO74wZ/2fWH7vvOPlz3WWnCfy7FtXFqbC7//TqTee3wCcDMU+fVTRH4pek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mllj9E50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC02C2BC9E;
	Wed, 25 Mar 2026 10:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774433798;
	bh=U01JBVboQt7MMZE8wTfay7YiBkwHABoj7US7ZOkkTCw=;
	h=From:To:Cc:Subject:Date:From;
	b=Mllj9E50z6txXr81nbNCI9FUSHDyrwF+/VifEcPrFrdCIyzCAKnDRyrp3YxqmnjU6
	 1auWvMs9y42ZCgkOJw72yLtAggUb+kdBwiEprSljWl0IP8ilZeu2Ak7q0gKrzLcjpa
	 zki35qHRnOuotEAzOndpGzqEc8d0oZ09XcDDF31k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.78
Date: Wed, 25 Mar 2026 11:15:54 +0100
Message-ID: <2026032555-absentee-wafer-f27a@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230303-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 95930322DC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.12.78 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/virt/kvm/api.rst                                   |   52 +
 Makefile                                                         |   11 
 arch/arm/kernel/machine_kexec.c                                  |   23 
 arch/arm64/Kconfig                                               |    1 
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi              |    1 
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi                       |   37 -
 arch/arm64/include/asm/pgtable-prot.h                            |   10 
 arch/arm64/kernel/machine_kexec.c                                |   31 -
 arch/arm64/mm/contpte.c                                          |   53 +-
 arch/loongarch/include/asm/uaccess.h                             |   14 
 arch/parisc/include/asm/pgtable.h                                |    2 
 arch/parisc/kernel/cache.c                                       |    4 
 arch/parisc/kernel/head.S                                        |    7 
 arch/parisc/kernel/setup.c                                       |   20 
 arch/powerpc/include/asm/kexec.h                                 |    1 
 arch/powerpc/include/asm/uaccess.h                               |    2 
 arch/powerpc/kexec/core.c                                        |   60 --
 arch/powerpc/kexec/core_32.c                                     |    1 
 arch/powerpc/kexec/file_load_64.c                                |   14 
 arch/powerpc/net/bpf_jit_comp.c                                  |    2 
 arch/powerpc/net/bpf_jit_comp64.c                                |  148 +++--
 arch/powerpc/platforms/83xx/km83xx.c                             |    4 
 arch/riscv/kernel/machine_kexec.c                                |   23 
 arch/s390/include/asm/processor.h                                |    2 
 arch/s390/lib/xor.c                                              |    4 
 arch/s390/mm/pfault.c                                            |    4 
 arch/x86/boot/compressed/sev.c                                   |    1 
 arch/x86/coco/sev/core.c                                         |    1 
 arch/x86/events/intel/core.c                                     |   25 
 arch/x86/events/intel/uncore_snbep.c                             |   76 ++
 arch/x86/include/asm/kvm_host.h                                  |    9 
 arch/x86/include/asm/msr-index.h                                 |    5 
 arch/x86/include/uapi/asm/kvm.h                                  |    3 
 arch/x86/kernel/apic/apic.c                                      |    6 
 arch/x86/kernel/apic/x2apic_uv_x.c                               |   18 
 arch/x86/kernel/uprobes.c                                        |   24 
 arch/x86/kvm/mmu.h                                               |    2 
 arch/x86/kvm/mmu/mmu.c                                           |   10 
 arch/x86/kvm/svm/avic.c                                          |   30 -
 arch/x86/kvm/svm/svm.c                                           |   14 
 arch/x86/kvm/vmx/nested.c                                        |   26 
 arch/x86/kvm/vmx/vmx.c                                           |   50 +
 arch/x86/kvm/x86.c                                               |   23 
 arch/x86/kvm/x86.h                                               |    3 
 block/blk-cgroup.c                                               |    6 
 block/blk-cgroup.h                                               |    6 
 block/blk-throttle.c                                             |    6 
 block/blk-throttle.h                                             |   18 
 drivers/acpi/acpi_processor.c                                    |   15 
 drivers/acpi/osi.c                                               |   13 
 drivers/acpi/osl.c                                               |    2 
 drivers/acpi/sleep.c                                             |    8 
 drivers/ata/libata-core.c                                        |    5 
 drivers/ata/libata-scsi.c                                        |   83 +--
 drivers/base/power/runtime.c                                     |    1 
 drivers/base/property.c                                          |   27 -
 drivers/bluetooth/btqca.c                                        |    2 
 drivers/cache/ax45mp_cache.c                                     |    4 
 drivers/cache/starfive_starlink_cache.c                          |    4 
 drivers/cpuidle/cpuidle.c                                        |   10 
 drivers/crypto/atmel-sha204a.c                                   |    5 
 drivers/dma/mmp_pdma.c                                           |    6 
 drivers/firewire/net.c                                           |    5 
 drivers/firmware/arm_ffa/driver.c                                |    8 
 drivers/firmware/arm_scpi.c                                      |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                 |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                       |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c                   |   20 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                            |   21 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                           |    5 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                           |    5 
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c                          |    9 
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c                          |    3 
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c                          |    3 
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c                          |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c           |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c         |    1 
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c                 |    8 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c   |    2 
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c                  |    2 
 drivers/gpu/drm/amd/display/dc/dm_services_types.h               |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c        |    6 
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c   |    3 
 drivers/gpu/drm/amd/include/dm_pp_interface.h                    |    1 
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c                     |   67 ++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h                 |    2 
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c                       |    4 
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c                   |    6 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                       |   69 --
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                 |   11 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c             |    8 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c             |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c             |    3 
 drivers/gpu/drm/bridge/samsung-dsim.c                            |   25 
 drivers/gpu/drm/bridge/ti-sn65dsi83.c                            |   13 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                            |  118 ++++
 drivers/gpu/drm/drm_file.c                                       |    5 
 drivers/gpu/drm/drm_mode_config.c                                |    9 
 drivers/gpu/drm/i915/display/intel_display_types.h               |    1 
 drivers/gpu/drm/i915/display/intel_psr.c                         |   71 +-
 drivers/gpu/drm/i915/display/intel_vdsc.c                        |   23 
 drivers/gpu/drm/i915/display/intel_vdsc.h                        |    3 
 drivers/gpu/drm/i915/display/intel_vdsc_regs.h                   |   12 
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c                        |   12 
 drivers/gpu/drm/i915/gt/intel_engine_cs.c                        |    3 
 drivers/gpu/drm/imagination/pvr_power.c                          |   11 
 drivers/gpu/drm/msm/adreno/a2xx_gpummu.c                         |    2 
 drivers/gpu/drm/msm/dsi/dsi_host.c                               |   43 +
 drivers/gpu/drm/nouveau/nouveau_connector.c                      |    3 
 drivers/gpu/drm/radeon/si_dpm.c                                  |    4 
 drivers/gpu/drm/tiny/st7586.c                                    |   15 
 drivers/gpu/drm/xe/xe_ggtt.c                                     |   10 
 drivers/gpu/drm/xe/xe_ggtt_types.h                               |    5 
 drivers/gpu/drm/xe/xe_oa.c                                       |    7 
 drivers/gpu/drm/xe/xe_sync.c                                     |   24 
 drivers/hid/bpf/hid_bpf_dispatch.c                               |    2 
 drivers/hwmon/max6639.c                                          |   10 
 drivers/hwmon/pmbus/isl68137.c                                   |    7 
 drivers/hwmon/pmbus/mp2975.c                                     |    2 
 drivers/hwmon/pmbus/q54sj108a2.c                                 |   19 
 drivers/i2c/busses/i2c-cp2615.c                                  |    3 
 drivers/i2c/busses/i2c-fsi.c                                     |    1 
 drivers/i2c/busses/i2c-pxa.c                                     |   17 
 drivers/i3c/master/dw-i3c-master.c                               |    4 
 drivers/i3c/master/mipi-i3c-hci/cmd.h                            |    1 
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c                         |    2 
 drivers/i3c/master/mipi-i3c-hci/cmd_v2.c                         |    2 
 drivers/i3c/master/mipi-i3c-hci/core.c                           |    6 
 drivers/i3c/master/mipi-i3c-hci/dma.c                            |    4 
 drivers/iio/chemical/bme680_core.c                               |    2 
 drivers/iio/chemical/sps30_i2c.c                                 |    2 
 drivers/iio/chemical/sps30_serial.c                              |    2 
 drivers/iio/dac/ds4424.c                                         |    2 
 drivers/iio/frequency/adf4377.c                                  |    2 
 drivers/iio/gyro/mpu3050-core.c                                  |   18 
 drivers/iio/gyro/mpu3050-i2c.c                                   |    3 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                |    2 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c               |    4 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                 |    2 
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c                       |    8 
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h                        |    2 
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c                    |    5 
 drivers/iio/industrialio-buffer.c                                |    6 
 drivers/iio/potentiometer/mcp4131.c                              |    2 
 drivers/iio/proximity/hx9023s.c                                  |    3 
 drivers/iommu/intel/dmar.c                                       |    3 
 drivers/irqchip/irq-gic-v3-its.c                                 |    4 
 drivers/md/dm-verity-fec.c                                       |    4 
 drivers/md/dm-verity-fec.h                                       |    3 
 drivers/media/dvb-core/dvb_net.c                                 |    3 
 drivers/mmc/host/dw_mmc-rockchip.c                               |   51 +
 drivers/mmc/host/mmci_qcom_dml.c                                 |    1 
 drivers/mmc/host/sdhci-pci-gli.c                                 |    9 
 drivers/mmc/host/sdhci.c                                         |    9 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                         |    6 
 drivers/mtd/nand/raw/cadence-nand-controller.c                   |    2 
 drivers/mtd/nand/raw/nand_base.c                                 |   14 
 drivers/mtd/nand/raw/pl35x-nand-controller.c                     |    3 
 drivers/mtd/parsers/redboot.c                                    |    6 
 drivers/mtd/spi-nor/core.c                                       |  145 +++++
 drivers/net/bonding/bond_debugfs.c                               |   16 
 drivers/net/bonding/bond_main.c                                  |  134 ++---
 drivers/net/caif/caif_serial.c                                   |    3 
 drivers/net/can/spi/hi311x.c                                     |    5 
 drivers/net/can/usb/gs_usb.c                                     |   22 
 drivers/net/dsa/bcm_sf2.c                                        |    8 
 drivers/net/dsa/microchip/ksz_ptp.c                              |   11 
 drivers/net/dsa/realtek/rtl8365mb.c                              |    3 
 drivers/net/dsa/realtek/rtl8366rb-leds.c                         |    6 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                         |    4 
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c                      |   82 ++-
 drivers/net/ethernet/amd/xgbe/xgbe.h                             |    4 
 drivers/net/ethernet/arc/emac_main.c                             |   11 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                   |   31 -
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                   |    5 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c               |    2 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                     |   10 
 drivers/net/ethernet/cadence/macb_main.c                         |  124 ++++
 drivers/net/ethernet/cadence/macb_ptp.c                          |    4 
 drivers/net/ethernet/google/gve/gve_tx_dqo.c                     |   54 --
 drivers/net/ethernet/intel/e1000/e1000_main.c                    |    2 
 drivers/net/ethernet/intel/e1000e/netdev.c                       |    2 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c               |   14 
 drivers/net/ethernet/intel/iavf/iavf_main.c                      |    9 
 drivers/net/ethernet/intel/ice/ice_common.c                      |   13 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                     |   35 -
 drivers/net/ethernet/intel/ice/ice_main.c                        |    3 
 drivers/net/ethernet/intel/igc/igc.h                             |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                        |   14 
 drivers/net/ethernet/intel/igc/igc_ptp.c                         |   33 +
 drivers/net/ethernet/intel/ixgbevf/vf.c                          |    3 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                  |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c              |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c          |    6 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c              |    2 
 drivers/net/ethernet/mediatek/airoha_eth.c                       |   52 +
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c         |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h         |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c |   50 -
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c                |   23 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                |   30 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                |    3 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c       |   18 
 drivers/net/ethernet/microsoft/mana/hw_channel.c                 |    6 
 drivers/net/ethernet/microsoft/mana/mana_en.c                    |   23 
 drivers/net/ethernet/stmicro/stmmac/common.h                     |    1 
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c                |    4 
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c             |    7 
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                     |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                |   36 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c            |    8 
 drivers/net/mctp/mctp-i2c.c                                      |    1 
 drivers/net/phy/phy_device.c                                     |   25 
 drivers/net/phy/sfp.c                                            |    8 
 drivers/net/usb/aqc111.c                                         |   12 
 drivers/net/usb/cdc_ncm.c                                        |   10 
 drivers/net/usb/lan78xx.c                                        |   10 
 drivers/net/usb/lan78xx.h                                        |    3 
 drivers/net/usb/qmi_wwan.c                                       |    4 
 drivers/net/usb/usbnet.c                                         |    7 
 drivers/net/wireless/marvell/libertas/main.c                     |    4 
 drivers/net/wireless/ti/wlcore/tx.c                              |    2 
 drivers/nfc/nxp-nci/i2c.c                                        |    4 
 drivers/nvdimm/bus.c                                             |    5 
 drivers/nvme/host/pci.c                                          |    8 
 drivers/platform/x86/amd/pmc/pmc.c                               |    3 
 drivers/platform/x86/amd/pmc/pmc.h                               |    1 
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c             |    9 
 drivers/pmdomain/bcm/bcm2835-power.c                             |   18 
 drivers/regulator/pca9450-regulator.c                            |    2 
 drivers/remoteproc/mtk_scp.c                                     |   39 +
 drivers/remoteproc/qcom_sysmon.c                                 |    2 
 drivers/s390/block/dasd_eckd.c                                   |   16 
 drivers/s390/crypto/zcrypt_ccamisc.c                             |   12 
 drivers/s390/crypto/zcrypt_cex4.c                                |    3 
 drivers/scsi/hisi_sas/hisi_sas.h                                 |   43 +
 drivers/scsi/hisi_sas/hisi_sas_main.c                            |   42 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                           |  246 +++++----
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                  |   34 -
 drivers/scsi/scsi_scan.c                                         |    8 
 drivers/scsi/ses.c                                               |    5 
 drivers/scsi/storvsc_drv.c                                       |    5 
 drivers/soc/fsl/qbman/qman.c                                     |   24 
 drivers/soc/fsl/qe/qmc.c                                         |    4 
 drivers/soc/microchip/mpfs-sys-controller.c                      |   13 
 drivers/soc/rockchip/grf.c                                       |    1 
 drivers/spi/spi-cadence-quadspi.c                                |   33 +
 drivers/spi/spi.c                                                |   25 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                   |   15 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                        |    5 
 drivers/tty/serial/8250/8250_dma.c                               |   15 
 drivers/tty/serial/8250/8250_pci.c                               |   17 
 drivers/tty/serial/8250/8250_port.c                              |    6 
 drivers/tty/serial/uartlite.c                                    |    1 
 drivers/ufs/core/ufshcd.c                                        |    8 
 drivers/usb/class/cdc-acm.c                                      |    5 
 drivers/usb/class/cdc-acm.h                                      |    1 
 drivers/usb/class/cdc-wdm.c                                      |    4 
 drivers/usb/class/usbtmc.c                                       |    6 
 drivers/usb/core/message.c                                       |  100 +++
 drivers/usb/core/phy.c                                           |    8 
 drivers/usb/core/quirks.c                                        |   16 
 drivers/usb/dwc3/dwc3-pci.c                                      |    2 
 drivers/usb/gadget/function/f_mass_storage.c                     |   12 
 drivers/usb/gadget/function/f_ncm.c                              |   38 -
 drivers/usb/gadget/function/f_tcm.c                              |   14 
 drivers/usb/gadget/function/u_ether.c                            |   22 
 drivers/usb/gadget/function/u_ether.h                            |   26 
 drivers/usb/gadget/function/u_ncm.h                              |    2 
 drivers/usb/host/xhci-ring.c                                     |    1 
 drivers/usb/host/xhci.c                                          |    4 
 drivers/usb/image/mdc800.c                                       |    6 
 drivers/usb/misc/uss720.c                                        |    2 
 drivers/usb/misc/yurex.c                                         |    2 
 drivers/usb/renesas_usbhs/common.c                               |    9 
 drivers/usb/roles/class.c                                        |    7 
 drivers/usb/serial/f81232.c                                      |   77 +-
 drivers/usb/typec/altmodes/displayport.c                         |    7 
 drivers/usb/typec/tcpm/tcpm.c                                    |    2 
 drivers/xen/privcmd.c                                            |   73 ++
 fs/binfmt_misc.c                                                 |    4 
 fs/btrfs/disk-io.c                                               |   22 
 fs/btrfs/extent_io.c                                             |    3 
 fs/btrfs/extent_io.h                                             |    3 
 fs/btrfs/inode.c                                                 |   19 
 fs/btrfs/ioctl.c                                                 |   24 
 fs/btrfs/space-info.c                                            |    5 
 fs/btrfs/transaction.c                                           |   16 
 fs/btrfs/tree-checker.c                                          |    2 
 fs/btrfs/tree-log.c                                              |    6 
 fs/btrfs/uuid-tree.c                                             |   38 +
 fs/btrfs/uuid-tree.h                                             |    2 
 fs/btrfs/volumes.c                                               |    6 
 fs/ceph/debugfs.c                                                |    4 
 fs/ceph/dir.c                                                    |   17 
 fs/ceph/file.c                                                   |    4 
 fs/ceph/inode.c                                                  |    2 
 fs/ceph/mds_client.c                                             |    3 
 fs/erofs/zdata.c                                                 |   21 
 fs/f2fs/compress.c                                               |   74 +-
 fs/f2fs/f2fs.h                                                   |    2 
 fs/f2fs/gc.c                                                     |   16 
 fs/iomap/buffered-io.c                                           |   15 
 fs/nfs/nfs3proc.c                                                |    7 
 fs/nfsd/nfs4xdr.c                                                |    9 
 fs/nfsd/nfsctl.c                                                 |   16 
 fs/nfsd/state.h                                                  |   17 
 fs/nsfs.c                                                        |   21 
 fs/smb/client/cifsencrypt.c                                      |    3 
 fs/smb/client/cifsfs.c                                           |    7 
 fs/smb/client/cifsglob.h                                         |   11 
 fs/smb/client/cifsproto.h                                        |    1 
 fs/smb/client/connect.c                                          |    4 
 fs/smb/client/dir.c                                              |    1 
 fs/smb/client/file.c                                             |   29 -
 fs/smb/client/fs_context.c                                       |    2 
 fs/smb/client/misc.c                                             |   42 +
 fs/smb/client/smb2ops.c                                          |   14 
 fs/smb/client/smb2pdu.c                                          |    5 
 fs/smb/client/smb2transport.c                                    |    4 
 fs/smb/client/trace.h                                            |    2 
 fs/smb/server/Kconfig                                            |    1 
 fs/smb/server/auth.c                                             |   26 
 fs/smb/server/oplock.c                                           |   35 -
 fs/smb/server/oplock.h                                           |    5 
 fs/smb/server/smb2pdu.c                                          |   34 -
 fs/tests/exec_kunit.c                                            |    3 
 fs/xfs/libxfs/xfs_defer.c                                        |    2 
 fs/xfs/scrub/agheader_repair.c                                   |   13 
 fs/xfs/scrub/alloc_repair.c                                      |    5 
 fs/xfs/scrub/attr_repair.c                                       |   20 
 fs/xfs/scrub/bmap_repair.c                                       |    6 
 fs/xfs/scrub/common.h                                            |   18 
 fs/xfs/scrub/dir.c                                               |   13 
 fs/xfs/scrub/dir_repair.c                                        |   11 
 fs/xfs/scrub/dirtree.c                                           |   11 
 fs/xfs/scrub/ialloc_repair.c                                     |    5 
 fs/xfs/scrub/nlinks.c                                            |    6 
 fs/xfs/scrub/orphanage.c                                         |    7 
 fs/xfs/scrub/parent.c                                            |   11 
 fs/xfs/scrub/parent_repair.c                                     |   23 
 fs/xfs/scrub/quotacheck.c                                        |   13 
 fs/xfs/scrub/refcount_repair.c                                   |   13 
 fs/xfs/scrub/rmap_repair.c                                       |    5 
 fs/xfs/scrub/rtsummary.c                                         |    7 
 fs/xfs/xfs_bmap_item.c                                           |    3 
 fs/xfs/xfs_dquot.c                                               |    8 
 fs/xfs/xfs_log.c                                                 |    2 
 include/linux/cleanup.h                                          |   19 
 include/linux/etherdevice.h                                      |    3 
 include/linux/huge_mm.h                                          |    4 
 include/linux/if_ether.h                                         |    3 
 include/linux/io_uring_types.h                                   |    3 
 include/linux/irq.h                                              |    3 
 include/linux/irqchip/arm-gic-v3.h                               |    1 
 include/linux/mlx5/mlx5_ifc.h                                    |    4 
 include/linux/mmc/host.h                                         |    9 
 include/linux/netdev_features.h                                  |   18 
 include/linux/netdevice.h                                        |   40 +
 include/linux/security.h                                         |    1 
 include/linux/stmmac.h                                           |    1 
 include/linux/trace_recursion.h                                  |    9 
 include/linux/uprobes.h                                          |    1 
 include/linux/usb.h                                              |    8 
 include/linux/usb/usbnet.h                                       |    1 
 include/net/dsa.h                                                |    1 
 include/net/ip6_tunnel.h                                         |   14 
 include/net/ip_tunnels.h                                         |    7 
 include/net/netfilter/nf_tables.h                                |    2 
 include/net/sch_generic.h                                        |   33 +
 include/net/tc_act/tc_gate.h                                     |   33 -
 include/net/udp_tunnel.h                                         |    2 
 include/net/xdp.h                                                |   32 +
 include/trace/events/kmem.h                                      |    8 
 include/trace/events/rxrpc.h                                     |    4 
 init/Kconfig                                                     |    3 
 io_uring/kbuf.c                                                  |   18 
 io_uring/kbuf.h                                                  |    4 
 io_uring/uring_cmd.c                                             |    9 
 kernel/cgroup/cgroup.c                                           |    1 
 kernel/events/uprobes.c                                          |   10 
 kernel/fork.c                                                    |    2 
 kernel/irq/Kconfig                                               |    6 
 kernel/irq/Makefile                                              |    2 
 kernel/irq/kexec.c                                               |   40 +
 kernel/kprobes.c                                                 |   51 -
 kernel/sched/ext.c                                               |   89 ++-
 kernel/sched/fair.c                                              |   84 ++-
 kernel/sched/idle.c                                              |   39 +
 kernel/time/time.c                                               |    2 
 kernel/trace/ring_buffer.c                                       |    2 
 kernel/trace/trace.c                                             |   12 
 kernel/trace/trace_events.c                                      |   58 +-
 kernel/trace/trace_functions_graph.c                             |    6 
 kernel/workqueue.c                                               |    2 
 lib/bootconfig.c                                                 |    9 
 mm/compaction.c                                                  |    2 
 mm/internal.h                                                    |    3 
 mm/kfence/core.c                                                 |   29 -
 mm/page_alloc.c                                                  |   59 +-
 mm/shmem.c                                                       |   97 +++
 net/batman-adv/bat_iv_ogm.c                                      |    3 
 net/batman-adv/bat_v_elp.c                                       |   10 
 net/batman-adv/hard-interface.c                                  |    8 
 net/batman-adv/hard-interface.h                                  |    1 
 net/bluetooth/hci_conn.c                                         |    4 
 net/bluetooth/hci_sync.c                                         |    2 
 net/bluetooth/hidp/core.c                                        |   16 
 net/bluetooth/l2cap_core.c                                       |   51 +
 net/bluetooth/mgmt.c                                             |    7 
 net/bluetooth/smp.c                                              |    2 
 net/bridge/br_cfm.c                                              |    4 
 net/ceph/auth.c                                                  |    6 
 net/ceph/messenger_v2.c                                          |   31 -
 net/ceph/mon_client.c                                            |    6 
 net/core/dev.c                                                   |   98 +++
 net/core/dev.h                                                   |   35 -
 net/core/dst.c                                                   |    1 
 net/core/xdp.c                                                   |   56 ++
 net/dsa/dsa.c                                                    |   59 +-
 net/ethernet/eth.c                                               |    9 
 net/ipv4/Kconfig                                                 |    1 
 net/ipv4/icmp.c                                                  |    4 
 net/ipv4/ip_gre.c                                                |    3 
 net/ipv4/ip_tunnel_core.c                                        |   15 
 net/ipv4/nexthop.c                                               |   14 
 net/ipv4/route.c                                                 |    4 
 net/ipv4/tcp.c                                                   |    3 
 net/ipv4/tcp_ao.c                                                |    3 
 net/ipv4/tcp_ipv4.c                                              |    3 
 net/ipv6/ip6_output.c                                            |   35 -
 net/ipv6/route.c                                                 |    4 
 net/ipv6/tcp_ipv6.c                                              |    3 
 net/mac80211/chan.c                                              |    6 
 net/mac80211/debugfs.c                                           |   14 
 net/mac80211/link.c                                              |    2 
 net/mac80211/mesh.c                                              |    3 
 net/mac802154/iface.c                                            |    4 
 net/mctp/route.c                                                 |   11 
 net/mpls/af_mpls.c                                               |    1 
 net/mptcp/pm.c                                                   |    2 
 net/mptcp/pm_netlink.c                                           |   72 ++
 net/mptcp/protocol.h                                             |    2 
 net/ncsi/ncsi-aen.c                                              |    3 
 net/ncsi/ncsi-rsp.c                                              |   16 
 net/netfilter/nf_bpf_link.c                                      |    2 
 net/netfilter/nf_conntrack_h323_asn1.c                           |    4 
 net/netfilter/nf_conntrack_netlink.c                             |   67 +-
 net/netfilter/nf_conntrack_sip.c                                 |    6 
 net/netfilter/nf_tables_api.c                                    |    7 
 net/netfilter/nfnetlink_cthelper.c                               |    8 
 net/netfilter/nfnetlink_osf.c                                    |   13 
 net/netfilter/nfnetlink_queue.c                                  |    4 
 net/netfilter/nft_ct.c                                           |    4 
 net/netfilter/nft_dynset.c                                       |   10 
 net/netfilter/nft_set_pipapo.c                                   |    3 
 net/netfilter/xt_CT.c                                            |    4 
 net/netfilter/xt_IDLETIMER.c                                     |    6 
 net/netfilter/xt_dccp.c                                          |    4 
 net/netfilter/xt_tcpudp.c                                        |    6 
 net/netfilter/xt_time.c                                          |    4 
 net/phonet/af_phonet.c                                           |    5 
 net/rose/af_rose.c                                               |    5 
 net/rxrpc/recvmsg.c                                              |   19 
 net/sched/act_gate.c                                             |  262 +++++++---
 net/sched/sch_generic.c                                          |   27 -
 net/sched/sch_ingress.c                                          |   14 
 net/sched/sch_teql.c                                             |    8 
 net/smc/af_smc.c                                                 |   23 
 net/smc/smc.h                                                    |    5 
 net/smc/smc_close.c                                              |    2 
 net/sunrpc/cache.c                                               |   26 
 net/sunrpc/xprtrdma/verbs.c                                      |    7 
 net/tipc/socket.c                                                |    2 
 net/wireless/pmsr.c                                              |    1 
 security/security.c                                              |    1 
 sound/core/pcm_native.c                                          |   19 
 sound/pci/hda/patch_realtek.c                                    |   25 
 sound/soc/amd/acp3x-rt5682-max9836.c                             |    9 
 sound/soc/amd/yc/acp6x-mach.c                                    |   14 
 sound/soc/codecs/cs42l43-jack.c                                  |    1 
 sound/soc/generic/simple-card-utils.c                            |   48 -
 sound/soc/qcom/qdsp6/q6apm-dai.c                                 |    1 
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c                          |    1 
 sound/soc/qcom/qdsp6/q6apm.c                                     |    1 
 sound/soc/soc-core.c                                             |   11 
 sound/usb/endpoint.c                                             |    1 
 sound/usb/mixer_scarlett2.c                                      |    2 
 sound/usb/quirks.c                                               |    2 
 tools/bootconfig/main.c                                          |    7 
 tools/objtool/Makefile                                           |    8 
 tools/perf/builtin-ftrace.c                                      |    9 
 tools/perf/util/annotate.c                                       |    5 
 tools/perf/util/disasm.c                                         |    2 
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h              |   12 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                  |   43 +
 503 files changed, 5250 insertions(+), 2255 deletions(-)

A1RM4X (1):
      USB: add QUIRK_NO_BOS for video capture several devices

Adrian Hunter (3):
      i3c: mipi-i3c-hci: Use ETIMEDOUT instead of ETIME for timeout errors
      i3c: mipi-i3c-hci: Restart DMA ring correctly after dequeue abort
      i3c: mipi-i3c-hci: Add missing TID field to no-op command descriptor

Adrian Ng Ho Yin (1):
      i3c: dw-i3c-master: Set SIR_REJECT in DAT on device attach and reattach

Al Viro (1):
      unshare: fix unshare_fs() handling

Alan Stern (3):
      USB: usbcore: Introduce usb_bulk_msg_killable()
      USB: usbtmc: Use usb_bulk_msg_killable() with user-specified timeouts
      USB: core: Limit the length of unkillable synchronous timeouts

Alessio Belle (1):
      drm/imagination: Fix deadlock in soft reset sequence

Alex Deucher (9):
      drm/amdgpu/gmc9.0: add bounds checking for cid
      drm/amdgpu/mmhub2.0: add bounds checking for cid
      drm/amdgpu/mmhub2.3: add bounds checking for cid
      drm/amdgpu/mmhub3.0.1: add bounds checking for cid
      drm/amdgpu/mmhub3.0.2: add bounds checking for cid
      drm/amdgpu/mmhub3.0: add bounds checking for cid
      drm/amdgpu/mmhub4.1.0: add bounds checking for cid
      drm/radeon: apply state adjust rules to some additional HAINAN vairants
      drm/amdgpu: apply state adjust rules to some additional HAINAN vairants

Alexander Gordeev (1):
      s390/pfault: Fix virtual vs physical address confusion

Alexander Lobakin (1):
      xdp: allow attaching already registered memory model to xdp_rxq_info

Alexander Potapenko (2):
      mm/kfence: disable KFENCE upon KASAN HW tags enablement
      mm/kfence: fix KASAN hardware tag faults during late enablement

Alok Tiwari (3):
      i40e: fix src IP mask checks and memcpy argument names in cloud filter
      octeontx2-af: devlink: fix NIX RAS reporter recovery condition
      octeontx2-af: devlink: fix NIX RAS reporter to use RAS interrupt status

Alysa Liu (1):
      drm/amdgpu: Fix use-after-free race in VM acquire

Anas Iqbal (1):
      net: dsa: bcm_sf2: fix missing clk_disable_unprepare() in error paths

Andreas Kemnade (1):
      iio: imu: inv-mpu9150: fix irq ack preventing irq storms

Andrei-Alexandru Tachici (1):
      tracing: Fix enabling multiple events on the kernel command line and bootconfig

Andrew Lunn (1):
      net: phy: register phy led_triggers during probe to avoid AB-BA deadlock

Andy Nguyen (1):
      drm/amd: fix dcn 2.01 check

Andy Shevchenko (1):
      device property: Allow secondary lookup in fwnode_get_next_child_node()

Ankit Garg (1):
      gve: fix incorrect buffer cleanup in gve_tx_clean_pending_packets for QPL

Antheas Kapenekakis (1):
      platform/x86/amd/pmc: Add support for Van Gogh SoC

Antoniu Miclaus (4):
      iio: chemical: sps30_serial: fix buffer size in sps30_serial_read_meas()
      iio: chemical: sps30_i2c: fix buffer size in sps30_i2c_read_meas()
      iio: gyro: mpu3050-core: fix pm_runtime error handling
      iio: gyro: mpu3050-i2c: fix pm_runtime error handling

Ariel Silver (1):
      media: dvb-net: fix OOB access in ULE extension header tables

Asbjørn Sloth Tønnesen (1):
      io_uring/uring_cmd: fix too strict requirement on ioctl

Ashutosh Dixit (1):
      drm/xe/oa: Allow reading after disabling OA stream

Azamat Almazbek uulu (1):
      ASoC: amd: yc: Add ASUS EXPERTBOOK BM1503CDA to quirk table

Baolin Wang (1):
      mm: shmem: fix potential data corruption during shmem swapin

Bart Van Assche (1):
      PM: runtime: Fix a race condition related to device removal

Bastien Curutchet (Schneider Electric) (1):
      net: dsa: microchip: Fix error path in PTP IRQ setup

Ben Collins (1):
      kexec: Include kernel-end even without crashkernel

Ben Dooks (1):
      ACPI: OSL: fix __iomem type on return from acpi_os_map_generic_address()

Benjamin Tissoires (2):
      selftests/hid: fix compilation when bpf_wq and hid_device are not exported
      HID: bpf: prevent buffer overflow in hid_hw_request

Bharath SM (1):
      smb: client: fix in-place encryption corruption in SMB2_write()

Bjorn Andersson (1):
      remoteproc: sysmon: Correct subsys_name_len type in QMI request

Breno Leitao (1):
      workqueue: Use POOL_BH instead of WQ_BH when checking pool flags

Calvin Owens (1):
      tracing: Fix trace_buf_size= cmdline parameter with sizes >= 2G

Carlos Maiolino (1):
      xfs: fix returned valued from xfs_defer_can_append

Casey Connolly (1):
      ASoC: detect empty DMI strings

Catalin Marinas (1):
      arm64: mm: Add PTE_DIRTY back to PAGE_KERNEL* to fix kexec/hibernation

Chao Gao (1):
      KVM: nVMX: Add consistency checks for CR0.WP and CR4.CET

Chao Yu (1):
      f2fs: fix to avoid migrating empty section

Charles Keepax (1):
      ASoC: cs42l43: Report insert for exotic peripherals

Chen Ni (5):
      perf annotate: Fix hashmap__new() error checking
      perf ftrace: Fix hashmap__new() error checking
      ASoC: amd: acp3x-rt5682-max9836: Add missing error check for clock acquisition
      mtd: rawnand: cadence: Fix error check for dma_alloc_coherent() in cadence_nand_init()
      soc: fsl: cpm1: qmc: Fix error check for devm_ioremap_resource() in qmc_qe_init_resources()

Cheng-Yang Chou (1):
      sched_ext: Remove redundant css_put() in scx_cgroup_init()

Chengfeng Ye (1):
      mctp: route: hold key->lock in mctp_flow_prepare_output()

Chris Spencer (1):
      iio: chemical: bme680: Fix measurement wait duration calculation

Christian Brauner (1):
      nsfs: tighten permission checks for ns iteration ioctls

Christian Eggers (3):
      Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU
      Bluetooth: LE L2CAP: Disconnect if sum of payload sizes exceed SDU
      Bluetooth: SMP: make SM/PER/KDU/BI-04-C happy

Christoffer Sandberg (1):
      usb/core/quirks: Add Huawei ME906S-device to wakeup quirk

Christophe JAILLET (1):
      i2c: fsi: Fix a potential leak in fsi_i2c_probe()

Christophe Leroy (CS GROUP) (1):
      powerpc/uaccess: Fix inline assembly for clang build on PPC32

Chuck Lever (1):
      NFSD: Hold net reference for the lifetime of /proc/fs/nfs/exports fd

Cosmin Ratiu (3):
      net/mlx5: Fix deadlock between devlink lock and esw->wq
      bonding: Correctly support GSO ESP offload
      net/mlx5: qos: Restrict RTNL area to avoid a lock cycle

Damien Le Moal (3):
      ata: libata-core: disable LPM on ADATA SU680 SSD
      ata: libata-scsi: Return residual for emulated SCSI commands
      ata: libata-scsi: report correct sense field pointer in ata_scsiop_maint_in()

Daniel Borkmann (1):
      clsact: Fix use-after-free in init/destroy rollback asymmetry

Daniel Hodges (1):
      wifi: libertas: fix use-after-free in lbs_free_adapter()

Daniel Jurgens (2):
      net/mlx5: IFC updates for disabled host PF
      net/mlx5: Query to see if host PF is disabled

Dapeng Mi (1):
      perf/x86/intel: Add missing branch counters constraint apply

Darrick J. Wong (3):
      xfs: fix undersized l_iclog_roundoff values
      iomap: reject delalloc mappings during writeback
      xfs: get rid of the xchk_xfile_*_descr calls

Dave Airlie (1):
      nouveau/dpcd: return EBUSY for aux xfer if the device is asleep

David Dull (1):
      netfilter: x_tables: guard option walkers against 1-byte tail reads

David Hildenbrand (2):
      mm/page_alloc: sort out the alloc_contig_range() gfp flags mess
      mm/page_alloc: forward the gfp flags from alloc_contig_range() to post_alloc_hook()

David Howells (1):
      rxrpc: Fix recvmsg() unconditional requeue

David Lechner (1):
      drm/sitronix/st7586: fix bad pixel data due to byte swap

Dayu Jiang (1):
      usb: xhci: Prevent interrupt storm on host controller error (HCE)

Deepanshu Kartikey (1):
      mm: thp: deny THP for files on anonymous inodes

Dillon Varone (1):
      drm/amd/display: Fallback to boot snapshot for dispclk

Dipayaan Roy (1):
      net: mana: fix use-after-free in mana_hwc_destroy_channel() by reordering teardown

Dmitry Baryshkov (1):
      Bluetooth: qca: fix ROM version reading on WCN3998 chips

Eliav Farber (1):
      kexec: Consolidate machine_kexec_mask_interrupts() implementation

Eric Badger (1):
      xprtrdma: Decrement re_receiving on the early exit paths

Eric Biggers (4):
      net/tcp-ao: Fix MAC comparison to be constant-time
      net/tcp-md5: Fix MAC comparison to be constant-time
      ksmbd: Compare MACs in constant time
      smb: client: Compare MACs in constant time

Eric Dumazet (4):
      net: prevent NULL deref in ip[6]tunnel_xmit()
      dst: fix races in rt6_uncached_list_del() and rt_del_uncached_list()
      ipv6: use RCU in ip6_xmit()
      bonding: prevent potential infinite loop in bond_header_parse()

Ethan Tidmore (1):
      xfs: Fix error pointer dereference

Fabrizio Castro (1):
      arm64: dts: renesas: r9a09g057: Remove wdt{0,2,3} nodes

Fan Wu (2):
      usb: renesas_usbhs: fix use-after-free in ISR during device removal
      net: ethernet: arc: emac: quiesce interrupts before requesting IRQ

Fedor Pchelkin (3):
      ksmbd: call ksmbd_vfs_kern_path_end_removing() on some error paths
      net: macb: fix use-after-free access to PTP clock
      net: macb: fix uninitialized rx_fs_lock

Felix Fietkau (1):
      mac80211: fix crash in ieee80211_chan_bw_change for AP_VLAN stations

Felix Gu (4):
      mmc: mmci: Fix device_node reference leak in of_get_dml_pipe_index()
      cache: starfive: fix device node leak in starlink_cache_init()
      cache: ax45mp: Fix device node reference leak in ax45mp_cache_init()
      firmware: arm_scpi: Fix device_node reference leak in probe path

Filipe Manana (5):
      btrfs: fix transaction abort on file creation due to name hash collision
      btrfs: fix transaction abort on set received ioctl due to item overflow
      btrfs: abort transaction on failure to update root in the received subvol ioctl
      btrfs: fix transaction abort when snapshotting received subvolumes
      btrfs: log new dentries when logging parent dir of a conflicting inode

Finn Thain (1):
      mtd: Avoid boot crash in RedBoot partition table parser

Florian Westphal (3):
      netfilter: nf_tables: always walk all pending catchall elements
      netfilter: ctnetlink: remove refcounting in expectation dumpers
      netfilter: bpf: defer hook memory release until rcu readers are done

Franz Schnyder (1):
      drm/bridge: ti-sn65dsi86: Enable HPD polling if IRQ is not used

Gabor Juhos (2):
      usb: core: don't power off roothub PHYs if phy_set_mode() fails
      i2c: pxa: defer reset on Armada 3700 when recovery is used

Gal Pressman (1):
      net/mlx5e: Fix DMA FIFO desync on error CQE SQ recovery

Gang Yan (1):
      selftests: mptcp: add a check for 'add_addr_accepted'

Gao Xiang (1):
      erofs: fix inline data read failure for ztailpacking pclusters

Greg Kroah-Hartman (3):
      usb: misc: uss720: properly clean up reference in uss720_probe()
      staging: rtl8723bs: properly validate the data in rtw_get_ie_ex()
      Linux 6.12.78

Guanghui Feng (1):
      iommu/vt-d: Fix intel iommu iotlb sync hardlockup and retry

Guenter Roeck (3):
      smb/server: Fix another refcount leak in smb2_open()
      wifi: wlcore: Return -ENOMEM instead of -EAGAIN if there is not enough headroom
      hwmon: (max6639) Fix pulses-per-revolution implementation

Guodong Xu (1):
      dmaengine: mmp_pdma: Fix race condition in mmp_pdma_residue()

Haiyue Wang (1):
      mctp: i2c: fix skb memory leak in receive path

Han Guangjiang (1):
      blk-throttle: fix access race during throttle policy activation

Hangbin Liu (3):
      bonding: handle BOND_LINK_FAIL, BOND_LINK_BACK as valid link states
      net: add a common function to compute features for upper devices
      bonding: use common function to compute the features

Harald Freudenberger (1):
      s390/zcrypt: Enable AUTOSEL_DOM for CCA serialnr sysfs attribute

Hari Bathini (1):
      powerpc64/bpf: fix kfunc call support

Hariprasad Kelam (1):
      Octeontx2-af: Add proper checks for fwdata

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Nova Lake -H

Heiko Carstens (2):
      s390/stackleak: Fix __stackleak_poison() inline assembly constraint
      s390/xor: Fix xor_xc_2() inline assembly constraints

Helge Deller (4):
      parisc: Increase initial mapping to 64 MB with KALLSYMS
      parisc: Fix initial page table creation for boot
      parisc: Check kernel mapping earlier at bootup
      parisc: Flush correct cache in cacheflush() syscall

Henrique Carvalho (1):
      smb: client: fix iface port assignment in parse_server_interfaces

Huiwen He (1):
      tracing: Fix syscall events activation by ensuring refcount hits zero

Hyunwoo Kim (6):
      netfilter: nfnetlink_queue: fix entry leak in bridge verdict error path
      netfilter: nfnetlink_cthelper: fix OOB read in nfnl_cthelper_dump_table()
      bridge: cfm: Fix race condition in peer_mep deletion
      netfilter: ctnetlink: fix use-after-free in ctnetlink_dump_exp_ct()
      ksmbd: fix use-after-free of share_conf in compound request
      ksmbd: fix use-after-free in durable v2 replay of active file handles

Ian Ray (1):
      NFC: nxp-nci: allow GPIOs to sleep

Ilpo Järvinen (1):
      serial: 8250: Add late synchronize_irq() to shutdown to handle DW UART BUSY

Ilya Dryomov (3):
      libceph: reject preamble if control segment is empty
      libceph: prevent potential out-of-bounds reads in process_message_header()
      libceph: admit message frames only in CEPH_CON_S_OPEN state

Ira Weiny (1):
      nvdimm/bus: Fix potential use after free in asynchronous initialization

J. Neuschäfer (1):
      powerpc: 83xx: km83xx: Fix keymile vendor prefix

Jakub Staniszewski (2):
      ice: reintroduce retry mechanism for indirect AQ
      ice: fix retry for AQ command 0x06EE

Jamal Hadi Salim (1):
      net/sched: teql: Fix double-free in teql_master_xmit

Jan Kiszka (1):
      scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT

Janusz Krzysztofik (1):
      drm/i915: Fix potential overflow of shmem scatterlist length

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_icm42600: fix odr switch to the same value
      iio: imu: inv_icm42600: fix odr switch when turning buffer off

Jedrzej Jagielski (1):
      ixgbevf: fix link setup issue

Jeff Layton (2):
      nfsd: fix heap overflow in NFSv4.0 LOCK replay cache
      sunrpc: fix cache_request leak in cache_release

Jenny Guanni Qu (4):
      netfilter: nft_set_pipapo: fix stack out-of-bounds read in pipapo_drop()
      netfilter: nf_conntrack_h323: fix OOB read in decode_int() CONS case
      netfilter: xt_time: use unsigned int for monthday bit shift
      netfilter: nf_conntrack_h323: check for zero length in DecodeQ931()

Jens Axboe (2):
      io_uring/kbuf: check if target buffer list is still legacy on recycle
      io_uring/kbuf: propagate BUF_MORE through early buffer commit path

Ji-Ze Hong (Peter Hong) (1):
      USB: serial: f81232: fix incomplete serial port generation

Jian Zhang (1):
      net: ncsi: fix skb leak in error paths

Jianbo Liu (3):
      bonding: add ESP offload features when slaves support
      net/mlx5e: Prevent concurrent access to IPSec ASO context
      net/mlx5e: Fix race condition during IPSec ESN update

Jiasheng Jiang (1):
      usb: gadget: f_tcm: Fix NULL pointer dereferences in nexus handling

Jiayuan Chen (3):
      bonding: fix type confusion in bond_setup_by_slave()
      net/rose: fix NULL pointer dereference in rose_transmit_link on reconnect
      net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()

Jim Mattson (1):
      KVM: x86: Introduce KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM

Jisheng Zhang (1):
      mmc: dw_mmc-rockchip: use modern PM macros

Johan Hovold (3):
      spi: fix use-after-free on controller registration failure
      spi: fix statistics allocation
      i2c: cp2615: fix serial string NULL-deref at probe

John Ripple (1):
      drm/bridge: ti-sn65dsi86: Add support for DisplayPort mode with HPD

Josh Law (5):
      lib/bootconfig: fix off-by-one in xbc_verify_tree() unclosed brace error
      lib/bootconfig: fix snprintf truncation check in xbc_node_compose_key_after()
      lib/bootconfig: check bounds before writing in __xbc_open_brace()
      lib/bootconfig: check xbc_init_node() return in override path
      tools/bootconfig: fix fd leak in load_xbc_file() on fstat failure

Jouni Högander (6):
      drm/i915/alpm: ALPM disable fixes
      drm/i915/psr: Repeat Selective Update area alignment
      drm/i915/dsc: Add Selective Update register definitions
      drm/i915/dsc: Add helper for writing DSC Selective Update ET parameters
      drm/i915/psr: Write DSC parameters on Selective Update in ET mode
      drm/i915/psr: Compute PSR entry_setup_frames into intel_crtc_state

Juergen Gross (2):
      xen/privcmd: restrict usage in unprivileged domU
      xen/privcmd: add boot control for restricted usage in domU

Junxiao Bi (1):
      scsi: core: Fix error handling for scsi_alloc_sdev()

Justin Chen (1):
      net: bcmgenet: increase WoL poll timeout

Kairui Song (2):
      mm/shmem, swap: improve cached mTHP handling and fix potential hang
      mm/shmem, swap: avoid redundant Xarray lookup during swapin

Kalesh Singh (1):
      mm/tracing: rss_stat: ensure curr is false from kthread context

Kamal Dasu (2):
      mtd: rawnand: serialize lock/unlock against other NAND operations
      mtd: rawnand: brcmnand: skip DMA during panic write

Kan Liang (1):
      perf/x86/intel/uncore: Support more units on Granite Rapids

Kees Cook (1):
      fs/tests: exec: Remove bad test vector

Kemeng Shi (1):
      mm: shmem: avoid unpaired folio_unlock() in shmem_swapin_folio()

Kevin Hao (3):
      net: macb: Shuffle the tx ring before enabling tx
      net: macb: Introduce gem_init_rx_ring()
      net: macb: Reinitialize tx/rx queue pointer registers and rx ring during resume

Khairul Anuar Romli (1):
      spi: cadence-quadspi: Implement refcount to handle unbind during busy

Kim Phillips (1):
      x86/sev: Allow IBPB-on-Entry feature for SNP guests

Kohei Enju (1):
      igc: fix missing update of skb->tail in igc_xmit_frame()

Kuen-Han Tsai (1):
      usb: gadget: f_ncm: Fix net_device lifecycle with device_move

Kuninori Morimoto (1):
      ASoC: simple-card-utils: use __free(device_node) for device node

Kuniyuki Iwashima (2):
      nfsd: Fix cred ref leak in nfsd_nl_listener_set_doit().
      wifi: mac80211: Fix static_branch_dec() underflow for aql_disable.

Kyle Meyer (1):
      x86/platform/uv: Handle deconfigured sockets

Laurent Vivier (1):
      qmi_wwan: allow max_mtu above hard_mtu to control rx_urb_size

Lijo Lazar (1):
      drm/amdgpu: Add basic validation for RAS header

Linus Torvalds (1):
      Fix CC_HAS_ASM_GOTO_OUTPUT on non-x86 architectures

Long Li (3):
      net: mana: Ring doorbell at 4 CQ wraparounds
      xfs: ensure dquot item is deleted from AIL only after log shutdown
      xfs: fix integer overflow in bmap intent sort comparator

Lorenzo Bianconi (4):
      net: airoha: read default PSE reserved pages value before updating
      net: airoha: fix PSE memory configuration in airoha_fe_pse_ports_init()
      net: airoha: Read completion queue data in airoha_qdma_tx_napi_poll()
      net: airoha: Remove airoha_dev_stop() in airoha_remove()

Luca Ceresoli (2):
      drm/bridge: ti-sn65dsi83: fix CHA_DSI_CLK_RANGE rounding
      drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual LVDS output

Luiz Augusto von Dentz (3):
      Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
      Bluetooth: ISO: Fix defer tests being unstable
      Bluetooth: HIDP: Fix possible UAF

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

Maarten Lankhorst (1):
      drm: Fix use-after-free on framebuffers and property blobs when calling drm_dev_unplug

Maciej Andrzejewski ICEYE (1):
      serial: uartlite: fix PM runtime usage count underflow on probe

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_open(): always configure bitrates before starting device

Marc Zyngier (2):
      usb: cdc-acm: Restore CAP_BRK functionnality to CH343
      irqchip/gic-v3-its: Limit number of per-device MSIs to the range the ITS supports

Marek Behún (1):
      net: dsa: realtek: Fix LED group port bit for non-zero LED group

Mario Limonciello (3):
      drm/amd: Disable MES LR compute W/A
      drm/amd: Set num IP blocks to 0 if discovery fails
      platform/x86: hp-bioscfg: Support allocations of larger data

Marios Makassikis (1):
      smb: server: fix use-after-free in smb2_open()

Mark Harmstone (1):
      btrfs: fix chunk map leak in btrfs_map_block() after btrfs_chunk_map_num_copies()

Martin Roukala (né Peres) (1):
      serial: 8250_pci: add support for the AX99100

Masami Hiramatsu (Google) (4):
      kprobes: avoid crash when rmmod/insmod after ftrace killed
      kprobes: Remove unneeded goto
      kprobes: Remove unneeded warnings from __arm_kprobe_ftrace()
      ring-buffer: Fix to update per-subbuf entries of persistent ring buffer

Matt Vollrath (1):
      e1000/e1000e: Fix leak in DMA error cleanup

Matthew Brost (1):
      drm/xe: Open-code GGTT MMIO access protection

Matthew Schwartz (1):
      mmc: sdhci-pci-gli: fix GL9750 DMA write corruption

Matthew Wilcox (Oracle) (1):
      mm/page_alloc: move set_page_refcounted() to callers of post_alloc_hook()

Matthieu Baerts (NGI0) (4):
      mptcp: pm: in-kernel: always mark signal+subflow endp as used
      mptcp: pm: avoid sending RM_ADDR over same subflow
      selftests: mptcp: join: check RM_ADDR not sent over same subflow
      mptcp: pm: in-kernel: always set ID as avail when rm endp

Max Kellermann (3):
      ceph: add a bunch of missing ceph_path_info initializers
      ceph: fix i_nlink underrun during async unlink
      ceph: fix memory leaks in ceph_mdsc_build_path()

Maximilian Pezzullo (1):
      ata: libata-core: Disable LPM on ST1000DM010-2EP102

Maíra Canal (2):
      pmdomain: bcm: bcm2835-power: Fix broken reset status read
      pmdomain: bcm: bcm2835-power: Increase ASB control timeout

Mehul Rao (3):
      ALSA: pcm: fix use-after-free on linked stream runtime in snd_pcm_drain()
      tipc: fix divide-by-zero in tipc_sk_filter_connect()
      net: nexthop: fix percpu use-after-free in remove_nh_grp_entry

Michael Grzeschik (1):
      Bluetooth: hci_sync: Fix hci_le_create_conn_sync

Mieczyslaw Nalewaj (1):
      net: dsa: realtek: rtl8365mb: remove ifOutDiscards from rx_packets

Miguel Ojeda (1):
      rust: kbuild: allow `unused_features`

Mikulas Patocka (1):
      dm-verity: disable recursive forward error correction

Muhammad Hammad Ijaz (1):
      net: mvpp2: guard flow control update with global_tx_fc in buffer switching

Namjae Jeon (4):
      ksmbd: fix use-after-free in smb_lazy_parent_lease_break_close()
      ksmbd: fix use-after-free by using call_rcu() for oplock_info
      ksmbd: unset conn->binding on failed binding request
      ksmbd: use volume UUID in FS_OBJECT_ID_INFORMATION

Natalie Vock (1):
      drm/amd/display: Use GFP_ATOMIC in dc_create_stream_for_sink

Nathan Chancellor (1):
      kbuild: Leave objtool binary around with 'make clean'

Naveen N Rao (3):
      KVM: SVM: Limit AVIC physical max index based on configured max_vcpu_ids
      KVM: SVM: Add a helper to look up the max physical ID for AVIC
      powerpc64/bpf: Fold bpf_jit_emit_func_call_hlp() into bpf_jit_emit_func_call_rel()

Nicolai Buchwitz (1):
      net: bcmgenet: fix broken EEE by converting to phylib-managed state

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

Oliver Neukum (3):
      usb: yurex: fix race in probe
      usb: class: cdc-wdm: fix reordering issue in read code path
      usb: mdc800: handle signal and read racing

Olivier Sobrie (1):
      mtd: rawnand: pl353: make sure optimal timings are applied

Osama Abdelkader (1):
      drm/bridge: samsung-dsim: Fix memory leak in error path

Ovidiu Panait (1):
      arm64: dts: renesas: r9a09g057: Add RTC node

Pablo Neira Ayuso (4):
      nf_tables: nft_dynset: fix possible stateful expression memleak in error path
      netfilter: nft_ct: drop pending enqueued packets on removal
      netfilter: xt_CT: drop pending enqueued packets on template removal
      netfilter: nf_tables: release flowtable after rcu grace period on error

Paolo Bonzini (2):
      KVM: x86: do not allow re-enabling quirks
      KVM: x86: Allow vendor code to disable quirks

Patrisious Haddad (1):
      net/mlx5: Fix crash when moving to switchdev mode

Paul Greenwalt (1):
      ice: fix devlink reload call trace

Paul Moses (1):
      net/sched: act_gate: snapshot parameters with RCU on replace

Paulo Alcantara (2):
      smb: client: fix atomic open with O_DIRECT & O_SYNC
      smb: client: fix krb5 mount with username option

Pavan Chebbi (1):
      bnxt_en: Fix RSS table size check when changing ethtool channels

Peddolla Harshavardhan Reddy (1):
      wifi: cfg80211: cancel pmsr_free_wk in cfg80211_pmsr_wdev_down

Pedro Falcato (1):
      ata: libata-core: Add BRIDGE_OK quirk for QEMU drives

Peng Fan (1):
      regulator: pca9450: Correct interrupt type

Penghe Geng (1):
      mmc: core: Avoid bitfield RMW for claim/retune flags

Pengyu Luo (2):
      drm/msm/dsi: fix hdisplay calculation when programming dsi registers
      drm/msm/dsi: fix pclk rate calculation for bonded dsi

Peter Collingbourne (1):
      perf disasm: Fix off-by-one bug in outside check

Peter Wang (1):
      scsi: ufs: core: Fix possible NULL pointer dereference in ufshcd_add_command_trace()

Peter Zijlstra (1):
      sched/fair: Fix zero_vruntime tracking

Petr Oros (1):
      iavf: fix VLAN filter lost on add/delete race

Philip Yang (1):
      drm/amdkfd: Unreserve bo if queue update failed

Piotr Jaroszynski (1):
      arm64: contpte: fix set_access_flags() no-op check for SMMU/ATS faults

Piotr Mazek (1):
      ACPI: PM: Save NVS memory on Lenovo G70-35

Pratyush Yadav (2):
      mtd: spi-nor: core: avoid odd length/address reads on 8D-8D-8D mode
      mtd: spi-nor: core: avoid odd length/address writes in 8D-8D-8D mode

Qingye Zhao (1):
      cgroup: fix race between task migration and iteration

Qu Wenruo (1):
      btrfs: do not strictly require dirty metadata threshold for metadata writepages

RD Babiera (1):
      usb: typec: altmode/displayport: set displayport signaling rate in configure message

Rafael J. Wysocki (3):
      sched: idle: Make skipping governor callbacks more consistent
      sched: idle: Consolidate the handling of two special cases
      ACPI: processor: Fix previous acpi_processor_errata_piix4() fix

Rahul Bukte (1):
      drm/i915/gt: Check set_default_submission() before deferencing

Raju Rangoju (2):
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

Richard Genoud (1):
      soc: fsl: qbman: fix race condition in qman_destroy_fq

Roberto Bergantinos Corpas (1):
      nfs: return EISDIR on nfs3_proc_create if d_alias is a dir

Russell King (Oracle) (1):
      net: stmmac: remove support for lpi_intr_o

Sabrina Dubroca (1):
      mpls: add missing unregister_netdevice_notifier to mpls_init

Sanman Pradhan (3):
      hwmon: (pmbus/q54sj108a2) fix stack overflow in debugfs read
      hwmon: (pmbus/mp2975) Add error check for pmbus_read_word_data() return value
      hwmon: (pmbus/isl68137) Fix unchecked return value and use sysfs_emit()

Sasha Levin (1):
      Revert "arm64: dts: qcom: sdm845-oneplus: Mark l14a regulator as boot-on"

Sean Christopherson (4):
      KVM: SVM: Initialize AVIC VMCB fields if AVIC is enabled with in-kernel APIC
      KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activated
      KVM: x86: Co-locate initialization of feature MSRs in kvm_arch_vcpu_create()
      KVM: x86: Quirk initialization of feature MSRs to KVM's max configuration

Sean Rhodes (1):
      ALSA: hda/realtek: Fix speaker pop on Star Labs StarFighter

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

Shawn Lin (3):
      mmc: dw_mmc-rockchip: Add memory clock auto-gating support
      mmc: dw_mmc-rockchip: Fix runtime PM support for internal phase support
      soc: rockchip: grf: Add missing of_node_put() when returning

Shengming Hu (1):
      fgraph: Fix thresh_return clear per-task notrace

Shuangpeng Bai (1):
      serial: caif: hold tty->link reference in ldisc_open and ser_release

Shuicheng Lin (1):
      drm/xe/sync: Cleanup partially initialized sync on parse failure

Shyam Prasad N (2):
      cifs: make default value of retrans as zero
      cifs: open files should not hold ref on superblock

Sofia Schneider (1):
      ACPI: OSI: Add DMI quirk for Acer Aspire One D255

Sourabh Jain (2):
      powerpc/kexec/core: use big-endian types for crash variables
      powerpc/crash: adjust the elfcorehdr size

Srinivasan Shanmugam (1):
      drm/amd/display: Fix DisplayID not-found handling in parse_edid_displayid_vrr()

Stefan Haberland (2):
      s390/dasd: Move quiesce state with pprc swap
      s390/dasd: Copy detected format information to secondary device

Steven Rostedt (2):
      time/jiffies: Mark jiffies_64_to_clock_t() notrace
      tracing: Add recursion protection in kernel stack trace recording

Sun YangKai (1):
      btrfs: hold space_info->lock when clearing periodic reclaim ready

Sungwoo Kim (2):
      nvme-pci: Fix slab-out-of-bounds in nvme_dbbuf_set
      nvme-pci: Fix race bug in nvme_poll_irqdisable()

Sven Eckelmann (1):
      batman-adv: Avoid double-rtnl_lock ELP metric worker

Takashi Iwai (3):
      ALSA: usb-audio: Avoid implicit feedback mode on DIYINHK USB Audio 2.0
      ALSA: usb-audio: Check max frame size for implicit feedback mode, too
      ALSA: usb-audio: Check endpoint numbers at parsing Scarlett2 mixer interfaces

Tejun Heo (2):
      sched_ext: Disable preemption between scx_claim_exit() and kicking helper work
      sched_ext: Fix starvation of scx_enable() under fair-class saturation

Thomas Fourier (1):
      drm/msm: Fix dma_free_attrs() buffer size

Thomas Gleixner (2):
      kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang < 17
      cleanup: Provide retain_and_null_ptr()

Thorsten Blum (2):
      ksmbd: Don't log keys in SMB3 signing and encryption key generation
      crypto: atmel-sha204a - Fix OOM ->tfm_count leak

Tiezhu Yang (1):
      LoongArch: Give more information if kmem access failed

Timur Kristóf (2):
      drm/amd/display: Add pixel_clock to amd_pp_display_configuration
      drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)

Tobi Gaertner (2):
      net: usb: cdc_ncm: add ndpoffset to NDP16 nframes bounds check
      net: usb: cdc_ncm: add ndpoffset to NDP32 nframes bounds check

Toke Høiland-Jørgensen (1):
      xdp: register system page pool as an XDP memory model

Tomas Henzl (1):
      scsi: ses: Fix devices attaching to different hosts

Tzung-Bi Shih (1):
      remoteproc: mediatek: Unprepare SCP clock during system suspend

Vladimir Oltean (1):
      net: dsa: properly keep track of conduit reference

Vyacheslav Vahnenko (1):
      USB: ezcap401 needs USB_QUIRK_NO_BOS to function on 10gbs usb speed

Wang Shuaiwei (1):
      scsi: ufs: core: Fix SError in ufshcd_rtc_work() during UFS suspend

Wang Tao (1):
      Bluetooth: MGMT: Fix list corruption and UAF in command complete handlers

Weiming Shi (4):
      net/sched: teql: fix NULL pointer dereference in iptunnel_xmit on TEQL slave xmit
      net: add xmit recursion limit to tunnel xmit functions
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

Yan Zhao (2):
      KVM: x86: Introduce supported_quirks to block disabling quirks
      KVM: x86: Introduce Intel specific quirk KVM_X86_QUIRK_IGNORE_GUEST_PAT

Yang Wang (2):
      drm/amd/pm: add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu v14
      drm/amd/pm: remove invalid gpu_metrics.energy_accumulator on smu v13.0.x

Yang Yang (1):
      batman-adv: avoid OGM aggregation when skb tailroom is insufficient

Yasin Lee (1):
      iio: proximity: hx9023s: Protect against division by zero in set_samp_freq

Yeoreum Yun (1):
      firmware: arm_ffa: Remove vm_id argument in ffa_rxtx_unmap()

Yihang Li (1):
      scsi: hisi_sas: Use macro instead of magic number

Yuan Tan (1):
      netfilter: xt_IDLETIMER: reject rev0 reuse of ALARM timer labels

Zdenek Bouska (1):
      igc: fix page fault in XDP TX timestamps handling

Zhang Heng (1):
      ASoC: amd: yc: Add DMI quirk for ASUS EXPERTBOOK PM1503CDA

ZhengYuan Huang (1):
      btrfs: tree-checker: fix misleading root drop_level error message

Zhiguo Niu (2):
      f2fs: compress: change the first parameter of page_array_{alloc,free} to sbi
      f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic

Zide Chen (1):
      perf/x86/intel/uncore: Add per-scheduler IMC CAS count events

Zilin Guan (3):
      usb: xhci: Fix memory leak in xhci_disable_slot()
      binfmt_misc: restore write access before closing files opened by open_exec()
      soc: microchip: mpfs: Fix memory leak in mpfs_sys_controller_probe()

Ziyi Guo (1):
      usb: image: mdc800: kill download URB on timeout

matteo.cotifava (2):
      ASoC: soc-core: drop delayed_work_pending() check before flush
      ASoC: soc-core: flush delayed work before removing DAIs and widgets

sguttula (1):
      drm/amdgpu/vcn5: Add SMU dpm interface type

wangshuaiwei (1):
      scsi: ufs: core: Fix shift out of bounds when MAXQ=32

Álvaro Fernández Rojas (1):
      net: sfp: improve Huawei MA5671a fixup


