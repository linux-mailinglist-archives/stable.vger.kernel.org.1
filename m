Return-Path: <stable+bounces-253934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B9BANiUEWpLnwYAu9opvQ
	(envelope-from <stable+bounces-253934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:51:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A00F5BEC7B
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAF353025D10
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 11:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8243A38910F;
	Sat, 23 May 2026 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GiXndgTn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA738A711;
	Sat, 23 May 2026 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779536787; cv=none; b=BUIDRh0AjgING/aa4NmhZP58iCGscLf1BlvyL7vwLQF50jKz4GVh27Qy4UdJiS2oUmUu2g+BwT+zlylxKddX89j1npwZbEUriAVjhn2O6SioxWRDiu/edH/PytJvSgzd/y96HOcZ9rRcNBhOfJKgKctrSJzY8wniF7VcjRmkFIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779536787; c=relaxed/simple;
	bh=/P0t/wJ1dD8a3EPDLNhOMfx4kt+My30pWu/8HdYiJvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AmKriUxQtyjVNY9EURWE4ttR2npK5X2LBjN7sK+fx4MgvucTU0bBhK/K+C+yd6QzClKrcUVWJNK37O4sq+3Zn+61wzcLyZ5Xn39Gvkh6A3UjJ9QH1D3I7mHcaHPAUKnykV2umk5bZkLbtUMRUwCFwmqnDXVkdzISB+nNPtq8k2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GiXndgTn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1D31F00A3A;
	Sat, 23 May 2026 11:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779536782;
	bh=JFCEgB7q2mqySleSTWUZswhd2T+e8Y8WN9CBuhDgnA0=;
	h=From:To:Cc:Subject:Date;
	b=GiXndgTnMgHXYWNtVS3gA8TwmXpCGZ7N56/VcN1LDdKozUqf+aAyoIm1bhPKKHyB9
	 sZaB+NwJWlYUpNOtvpS1GK2WZuxic8d01Z5Hm6KetlMtMUFfeo3k0txkIv2AyRmJ7e
	 o5UqHPu0Tk3gOs79rgjcDD7Em+4w0ApIH9Bn9XVQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.91
Date: Sat, 23 May 2026 13:46:18 +0200
Message-ID: <2026052319-chastity-viper-7530@gregkh>
X-Mailer: git-send-email 2.54.0
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
	TAGGED_FROM(0.00)[bounces-253934-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,haoyu.lu:url,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0A00F5BEC7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.12.91 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml |    2 
 Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml             |    2 
 Documentation/mm/hugetlbfs_reserv.rst                                  |    2 
 Documentation/networking/netconsole.rst                                |    6 
 Makefile                                                               |    2 
 arch/arc/net/bpf_jit_arcv2.c                                           |    8 
 arch/arm/boot/dts/mediatek/mt7623.dtsi                                 |    2 
 arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi                   |    8 
 arch/arm/boot/dts/nxp/imx/imx27-eukrea-mbimxsd27-baseboard.dts         |    2 
 arch/arm/mach-omap1/clock_data.c                                       |    4 
 arch/arm/net/bpf_jit_32.c                                              |    6 
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts                   |    3 
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi                         |  161 +-
 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi              |    4 
 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi              |    4 
 arch/arm64/boot/dts/freescale/imx8mm-emtop-som.dtsi                    |    4 
 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi                    |    2 
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi                    |    2 
 arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts            |    2 
 arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts                 |    2 
 arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts            |    2 
 arch/arm64/boot/dts/freescale/imx8mp-debix-som-a.dtsi                  |    2 
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi                    |    2 
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts                           |    2 
 arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp.dtsi                  |    2 
 arch/arm64/boot/dts/freescale/imx8mp-navqp.dts                         |    2 
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314.dts       |    4 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts                           |   10 
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts                          |   10 
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi                      |    2 
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi                           |    2 
 arch/arm64/boot/dts/mediatek/mt6795.dtsi                               |    2 
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi                              |    2 
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi                              |    2 
 arch/arm64/boot/dts/mediatek/mt8365.dtsi                               |    5 
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts                      |    2 
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts                      |    2 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi           |    1 
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts                      |    4 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                   |    5 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                   |    5 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                                   |    7 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                                   |    7 
 arch/arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts                     |    4 
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts                         |    2 
 arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts                 |   12 
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts                               |   14 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                             |    2 
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                                |    6 
 arch/arm64/include/asm/kernel-pgtable.h                                |    7 
 arch/arm64/include/asm/xor.h                                           |    2 
 arch/arm64/kernel/cpufeature.c                                         |    4 
 arch/arm64/kernel/machine_kexec.c                                      |    3 
 arch/arm64/kernel/pi/patch-scs.c                                       |    4 
 arch/arm64/net/bpf_jit_comp.c                                          |    4 
 arch/loongarch/Kbuild                                                  |    2 
 arch/loongarch/include/asm/asm-prototypes.h                            |   20 
 arch/loongarch/include/asm/kvm_host.h                                  |    3 
 arch/loongarch/kvm/Makefile                                            |    3 
 arch/loongarch/kvm/main.c                                              |   35 
 arch/loongarch/kvm/switch.S                                            |   19 
 arch/powerpc/include/asm/kexec.h                                       |   14 
 arch/powerpc/kexec/crash.c                                             |   64 
 arch/powerpc/kexec/file_load_64.c                                      |   29 
 arch/powerpc/kvm/book3s_64_vio.c                                       |   21 
 arch/powerpc/kvm/powerpc.c                                             |   24 
 arch/powerpc/platforms/44x/warp.c                                      |    2 
 arch/powerpc/platforms/cell/spu_syscalls.c                             |    6 
 arch/s390/kvm/interrupt.c                                              |    3 
 arch/s390/kvm/pci.c                                                    |    6 
 arch/s390/net/bpf_jit_comp.c                                           |   39 
 arch/sparc/vdso/Makefile                                               |    7 
 arch/sparc/vdso/checkundef.sh                                          |   10 
 arch/x86/Makefile.um                                                   |    2 
 arch/x86/kernel/acpi/cppc.c                                            |    6 
 arch/x86/kernel/cpu/sgx/main.c                                         |   10 
 arch/x86/kvm/svm/sev.c                                                 |   39 
 arch/x86/kvm/trace.h                                                   |    2 
 arch/x86/um/vdso/Makefile                                              |    7 
 block/blk-cgroup.c                                                     |   16 
 block/disk-events.c                                                    |    3 
 crypto/af_alg.c                                                        |    2 
 crypto/jitterentropy-kcapi.c                                           |   14 
 drivers/acpi/arm64/agdi.c                                              |    2 
 drivers/acpi/x86/cmos_rtc.c                                            |   77 -
 drivers/ata/libata-scsi.c                                              |    4 
 drivers/base/devres.c                                                  |    2 
 drivers/block/drbd/drbd_nl.c                                           |    8 
 drivers/bluetooth/btmtk.c                                              |    4 
 drivers/bluetooth/hci_ldisc.c                                          |    3 
 drivers/bus/fsl-mc/fsl-mc-bus.c                                        |   43 
 drivers/bus/stm32_rifsc.c                                              |   52 
 drivers/cdrom/cdrom.c                                                  |   73 -
 drivers/char/ipmi/ssif_bmc.c                                           |   34 
 drivers/clk/clk-qoriq.c                                                |   17 
 drivers/clk/clk-xgene.c                                                |    2 
 drivers/clk/imx/clk-imx6q.c                                            |   12 
 drivers/clk/imx/clk-imx8mq.c                                           |    4 
 drivers/clk/qcom/dispcc-sc7180.c                                       |    8 
 drivers/clk/qcom/dispcc-sc8280xp.c                                     |    4 
 drivers/clk/qcom/dispcc-sm4450.c                                       |    1 
 drivers/clk/qcom/dispcc-sm8250.c                                       |    6 
 drivers/clk/qcom/dispcc-sm8450.c                                       |    2 
 drivers/clk/qcom/gcc-sc8180x.c                                         |   64 
 drivers/clk/qcom/gcc-x1e80100.c                                        |    1 
 drivers/clk/visconti/pll.c                                             |    2 
 drivers/crypto/atmel-aes.c                                             |   23 
 drivers/crypto/atmel-sha.c                                             |   27 
 drivers/crypto/atmel-tdes.c                                            |   25 
 drivers/crypto/ccp/ccp-crypto-aes.c                                    |    7 
 drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c                 |   20 
 drivers/crypto/intel/qat/qat_420xx/adf_drv.c                           |    2 
 drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c                   |   14 
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c                            |    2 
 drivers/crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c                 |    4 
 drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c                           |    2 
 drivers/crypto/intel/qat/qat_c62x/adf_c62x_hw_data.c                   |    4 
 drivers/crypto/intel/qat/qat_c62x/adf_drv.c                            |    4 
 drivers/crypto/intel/qat/qat_common/adf_accel_devices.h                |   12 
 drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.c                 |    2 
 drivers/crypto/intel/qat/qat_common/adf_sysfs_ras_counters.c           |   12 
 drivers/crypto/intel/qat/qat_common/icp_qat_hw_20_comp.h               |   10 
 drivers/crypto/intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c           |    6 
 drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c                        |    2 
 drivers/crypto/sa2ul.c                                                 |    4 
 drivers/crypto/tegra/tegra-se-aes.c                                    |  257 ++-
 drivers/crypto/tegra/tegra-se-hash.c                                   |  104 -
 drivers/crypto/tegra/tegra-se-key.c                                    |   19 
 drivers/crypto/tegra/tegra-se.h                                        |   33 
 drivers/cxl/pci.c                                                      |    3 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                         |    2 
 drivers/dma/mxs-dma.c                                                  |    1 
 drivers/firmware/arm_ffa/driver.c                                      |    2 
 drivers/firmware/efi/capsule-loader.c                                  |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                                    |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c                                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c                         |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                             |   28 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                                |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c                                |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                                |   57 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c                              |   23 
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c                           |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/cik.c                                       |    4 
 drivers/gpu/drm/amd/amdgpu/cik_ih.c                                    |    4 
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                                     |    4 
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                                 |   10 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                 |   10 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                                 |    8 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                                  |   70 
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                  |    8 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c                                |    8 
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c                                   |    4 
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c                                   |    4 
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c                                   |    4 
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h                                 |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                                 |    5 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c                                 |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c                                 |    5 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c                                 |    5 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c                               |    5 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c                               |    5 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c                               |    5 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/nv.c                                        |    4 
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                                 |    8 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c                               |    8 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c                                 |    8 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                                 |    8 
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c                                 |    8 
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c                                 |    8 
 drivers/gpu/drm/amd/amdgpu/si.c                                        |    4 
 drivers/gpu/drm/amd/amdgpu/si_dma.c                                    |    4 
 drivers/gpu/drm/amd/amdgpu/si_ih.c                                     |    4 
 drivers/gpu/drm/amd/amdgpu/soc15.c                                     |    4 
 drivers/gpu/drm/amd/amdgpu/soc21.c                                     |    4 
 drivers/gpu/drm/amd/amdgpu/soc24.c                                     |    4 
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                                  |   20 
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c                                  |   12 
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c                                  |    6 
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c                                  |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c                                  |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                                  |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                                  |   11 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                  |    8 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c                                |    9 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c                                |    9 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c                                |    9 
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/vi.c                                        |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                      |    6 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c                      |   62 
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c                  |    4 
 drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h            |    4 
 drivers/gpu/drm/amd/include/amd_shared.h                               |    6 
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c                             |    4 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                             |    4 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                       |    5 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c                         |   15 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                    |  118 +
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h                    |    1 
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h                           |    1 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c                    |   15 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                              |    4 
 drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c                |    6 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c                    |   72 -
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h                    |    1 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c                    |   18 
 drivers/gpu/drm/drm_syncobj.c                                          |    9 
 drivers/gpu/drm/gma500/oaktrail_hdmi.c                                 |    1 
 drivers/gpu/drm/gma500/oaktrail_lvds.c                                 |    9 
 drivers/gpu/drm/i915/display/intel_dp.c                                |    9 
 drivers/gpu/drm/i915/display/skl_watermark.c                           |  420 ++---
 drivers/gpu/drm/i915/gt/intel_reset.c                                  |    3 
 drivers/gpu/drm/imagination/pvr_rogue_fwif.h                           |    8 
 drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h                    |    6 
 drivers/gpu/drm/loongson/lsdc_drv.c                                    |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c                            |   14 
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c                                  |   14 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c                                |    2 
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                                      |    4 
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                                      |    2 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                     |   16 
 drivers/gpu/drm/msm/msm_gem_shrinker.c                                 |    5 
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c                        |    1 
 drivers/gpu/drm/panel/panel-simple.c                                   |    2 
 drivers/gpu/drm/panfrost/panfrost_drv.c                                |    2 
 drivers/gpu/drm/sun4i/sun4i_backend.c                                  |    6 
 drivers/gpu/drm/tiny/ofdrm.c                                           |    2 
 drivers/gpu/drm/v3d/v3d_drv.c                                          |   16 
 drivers/gpu/drm/v3d/v3d_submit.c                                       |    5 
 drivers/gpu/drm/xe/xe_dma_buf.c                                        |   31 
 drivers/gpu/drm/xe/xe_exec_queue.c                                     |    7 
 drivers/gpu/drm/xe/xe_gsc.c                                            |    2 
 drivers/gpu/drm/xe/xe_reg_whitelist.c                                  |    2 
 drivers/hid/hid-asus.c                                                 |   28 
 drivers/hid/usbhid/hid-core.c                                          |    2 
 drivers/hte/Kconfig                                                    |    6 
 drivers/hwmon/abituguru.c                                              |    2 
 drivers/hwmon/abituguru3.c                                             |    4 
 drivers/hwmon/aspeed-g6-pwm-tach.c                                     |    8 
 drivers/hwmon/da9052-hwmon.c                                           |    2 
 drivers/hwmon/dme1737.c                                                |    2 
 drivers/hwmon/f71805f.c                                                |    2 
 drivers/hwmon/f71882fg.c                                               |    2 
 drivers/hwmon/i5k_amb.c                                                |    2 
 drivers/hwmon/max197.c                                                 |    2 
 drivers/hwmon/mc13783-adc.c                                            |    2 
 drivers/hwmon/occ/p9_sbe.c                                             |    4 
 drivers/hwmon/pc87360.c                                                |    2 
 drivers/hwmon/pc87427.c                                                |    2 
 drivers/hwmon/sch5636.c                                                |    2 
 drivers/hwmon/sht15.c                                                  |    2 
 drivers/hwmon/sis5595.c                                                |    2 
 drivers/hwmon/smsc47m1.c                                               |    2 
 drivers/hwmon/ultra45_env.c                                            |    2 
 drivers/hwmon/via-cputemp.c                                            |    2 
 drivers/hwmon/via686a.c                                                |    2 
 drivers/hwmon/vt1211.c                                                 |    2 
 drivers/hwmon/vt8231.c                                                 |    4 
 drivers/hwmon/w83627hf.c                                               |    2 
 drivers/hwmon/w83781d.c                                                |    2 
 drivers/hwmon/xgene-hwmon.c                                            |    2 
 drivers/i3c/master/dw-i3c-master.c                                     |   16 
 drivers/i3c/master/mipi-i3c-hci/dma.c                                  |    5 
 drivers/infiniband/core/iwpm_msg.c                                     |    6 
 drivers/infiniband/hw/mana/cq.c                                        |    5 
 drivers/iommu/amd/amd_iommu_types.h                                    |   21 
 drivers/iommu/amd/iommu.c                                              |  453 ++++--
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                         |    7 
 drivers/iommu/intel/iommu.c                                            |    3 
 drivers/iommu/iommufd/fault.c                                          |    5 
 drivers/iommu/iommufd/vfio_compat.c                                    |    2 
 drivers/irqchip/irq-pic32-evic.c                                       |    2 
 drivers/irqchip/irq-riscv-imsic-early.c                                |    2 
 drivers/leds/blink/leds-lgm-sso.c                                      |    2 
 drivers/mailbox/mailbox-test.c                                         |   39 
 drivers/mailbox/mailbox.c                                              |    3 
 drivers/mailbox/mtk-cmdq-mailbox.c                                     |    8 
 drivers/md/dm-cache-metadata.c                                         |   24 
 drivers/md/dm-cache-metadata.h                                         |    5 
 drivers/md/dm-cache-policy-smq.c                                       |    4 
 drivers/md/dm-cache-target.c                                           |  143 +-
 drivers/md/dm-init.c                                                   |    4 
 drivers/md/dm-log.c                                                    |    6 
 drivers/md/md.c                                                        |   11 
 drivers/md/raid1.c                                                     |    4 
 drivers/media/i2c/og01a1b.c                                            |   93 -
 drivers/media/rc/lirc_dev.c                                            |   13 
 drivers/memory/tegra/tegra124-emc.c                                    |    2 
 drivers/memory/tegra/tegra30-emc.c                                     |    6 
 drivers/mfd/mc13xxx-core.c                                             |    2 
 drivers/mtd/maps/physmap-gemini.c                                      |    2 
 drivers/mtd/nand/raw/sunxi_nand.c                                      |    6 
 drivers/mtd/parsers/ofpart_core.c                                      |    4 
 drivers/mtd/spi-nor/core.c                                             |    2 
 drivers/mtd/spi-nor/core.h                                             |    8 
 drivers/mtd/spi-nor/sfdp.c                                             |   30 
 drivers/mtd/spi-nor/swp.c                                              |    4 
 drivers/net/bareudp.c                                                  |    3 
 drivers/net/dsa/realtek/rtl8365mb.c                                    |    2 
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c                   |    2 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                         |  702 ++++------
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                         |   68 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c                     |    4 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                           |    6 
 drivers/net/ethernet/freescale/Makefile                                |    3 
 drivers/net/ethernet/freescale/dpaa2/Kconfig                           |    4 
 drivers/net/ethernet/intel/e1000e/netdev.c                             |    1 
 drivers/net/ethernet/intel/i40e/i40e.h                                 |    1 
 drivers/net/ethernet/intel/i40e/i40e_main.c                            |    2 
 drivers/net/ethernet/intel/i40e/i40e_ptp.c                             |    3 
 drivers/net/ethernet/intel/iavf/iavf.h                                 |    9 
 drivers/net/ethernet/intel/iavf/iavf_main.c                            |   52 
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c                        |   76 -
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h                        |    2 
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h                        |   12 
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c                            |   46 
 drivers/net/ethernet/intel/ice/ice_txrx.c                              |    7 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                            |    7 
 drivers/net/ethernet/mediatek/airoha_eth.c                             |   27 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c       |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                      |    8 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                         |    4 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c                            |    2 
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c                |   17 
 drivers/net/ethernet/sfc/efx_devlink.c                                 |    2 
 drivers/net/hamradio/6pack.c                                           |    9 
 drivers/net/ipa/gsi.c                                                  |    1 
 drivers/net/ipa/ipa_main.c                                             |    6 
 drivers/net/macvlan.c                                                  |    9 
 drivers/net/mctp/mctp-i2c.c                                            |    4 
 drivers/net/netconsole.c                                               |    9 
 drivers/net/netdevsim/dev.c                                            |    2 
 drivers/net/phy/dp83869.c                                              |   13 
 drivers/net/phy/phy_device.c                                           |    4 
 drivers/net/phy/qcom/at803x.c                                          |    2 
 drivers/net/ppp/ppp_generic.c                                          |    5 
 drivers/net/ppp/pppoe.c                                                |    8 
 drivers/net/slip/slhc.c                                                |   49 
 drivers/net/usb/r8152.c                                                |    2 
 drivers/net/usb/rtl8150.c                                              |   12 
 drivers/net/virtio_net.c                                               |  125 -
 drivers/net/vrf.c                                                      |   15 
 drivers/net/wireless/ath/ath10k/wmi-tlv.c                              |   26 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c                |   15 
 drivers/net/wireless/marvell/mwifiex/11n_aggr.c                        |    1 
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c                        |   15 
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                       |    7 
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                        |   47 
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                     |    5 
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h                       |    2 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c                   |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                       |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                        |   13 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                       |    7 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                        |   62 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                        |   11 
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                     |    4 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                       |    9 
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                     |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                        |    9 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                       |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                        |    9 
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h                     |    4 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                       |    1 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                        |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                        |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                        |    4 
 drivers/net/wireless/realtek/rtlwifi/pci.c                             |    1 
 drivers/net/wireless/realtek/rtw89/phy.c                               |    2 
 drivers/nfc/trf7970a.c                                                 |    3 
 drivers/nvme/host/pci.c                                                |    1 
 drivers/nvme/target/tcp.c                                              |   51 
 drivers/nvmem/brcm_nvram.c                                             |    2 
 drivers/nvmem/layouts/u-boot-env.c                                     |    2 
 drivers/pci/controller/cadence/pcie-cadence-ep.c                       |    8 
 drivers/pci/controller/dwc/pcie-designware-ep.c                        |    9 
 drivers/pci/controller/dwc/pcie-designware-host.c                      |   18 
 drivers/pci/controller/dwc/pcie-designware.c                           |   16 
 drivers/pci/controller/dwc/pcie-designware.h                           |    2 
 drivers/pci/controller/dwc/pcie-qcom.c                                 |   17 
 drivers/pci/controller/dwc/pcie-rcar-gen4.c                            |    2 
 drivers/pci/controller/dwc/pcie-tegra194.c                             |  181 +-
 drivers/pci/controller/pcie-mediatek-gen3.c                            |    8 
 drivers/pci/endpoint/pci-epc-core.c                                    |   11 
 drivers/pci/npem.c                                                     |    2 
 drivers/pci/pci-driver.c                                               |   20 
 drivers/pci/pci-sysfs.c                                                |   28 
 drivers/pci/pci.c                                                      |   41 
 drivers/pci/probe.c                                                    |    1 
 drivers/pcmcia/rsrc_nonstatic.c                                        |    6 
 drivers/pinctrl/nomadik/pinctrl-abx500.c                               |    2 
 drivers/pinctrl/pinctrl-cy8c95x0.c                                     |   27 
 drivers/pinctrl/pinctrl-pic32.c                                        |   20 
 drivers/pinctrl/realtek/pinctrl-rtd.c                                  |    2 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                                |    7 
 drivers/platform/chrome/chromeos_tbmc.c                                |    6 
 drivers/platform/surface/surfacepro3_button.c                          |    1 
 drivers/platform/x86/asus-wmi.c                                        |   50 
 drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c            |   34 
 drivers/platform/x86/dell/dell_rbu.c                                   |    6 
 drivers/platform/x86/panasonic-laptop.c                                |    5 
 drivers/platform/x86/wmi.c                                             |   36 
 drivers/pmdomain/imx/scu-pd.c                                          |    1 
 drivers/pmdomain/ti/omap_prm.c                                         |    1 
 drivers/pwm/pwm-atmel-tcb.c                                            |   38 
 drivers/remoteproc/xlnx_r5_remoteproc.c                                |    2 
 drivers/reset/core.c                                                   |  119 +
 drivers/rtc/rtc-abx80x.c                                               |    2 
 drivers/s390/cio/cio.h                                                 |    5 
 drivers/s390/cio/css.c                                                 |   34 
 drivers/scsi/sg.c                                                      |   31 
 drivers/scsi/sr.c                                                      |   11 
 drivers/scsi/sr.h                                                      |    1 
 drivers/soc/qcom/llcc-qcom.c                                           |    2 
 drivers/soc/qcom/ocmem.c                                               |   17 
 drivers/soc/qcom/qcom_aoss.c                                           |    2 
 drivers/soc/tegra/cbb/tegra234-cbb.c                                   |    4 
 drivers/soundwire/bus.c                                                |    8 
 drivers/soundwire/cadence_master.c                                     |    8 
 drivers/soundwire/debugfs.c                                            |    9 
 drivers/spi/spi-fsl-qspi.c                                             |    3 
 drivers/spi/spi-hisi-kunpeng.c                                         |   12 
 drivers/spi/spi-mtk-snfi.c                                             |   14 
 drivers/spi/spi-nxp-fspi.c                                             |   96 +
 drivers/spi/spi-rockchip.c                                             |    3 
 drivers/spi/spi-sifive.c                                               |   29 
 drivers/target/target_core_sbc.c                                       |    3 
 drivers/thermal/spear_thermal.c                                        |    2 
 drivers/tty/hvc/hvc_iucv.c                                             |    2 
 drivers/tty/serial/ip22zilog.c                                         |    2 
 drivers/vfio/fsl-mc/vfio_fsl_mc.c                                      |    4 
 drivers/vfio/pci/vfio_pci_core.c                                       |    5 
 drivers/vhost/net.c                                                    |    4 
 drivers/video/backlight/sky81452-backlight.c                           |    3 
 drivers/video/fbdev/matrox/g450_pll.c                                  |    2 
 drivers/video/fbdev/offb.c                                             |    7 
 drivers/xen/xen-pciback/pci_stub.c                                     |    6 
 fs/adfs/super.c                                                        |    3 
 fs/btrfs/inode.c                                                       |   42 
 fs/btrfs/ioctl.c                                                       |    5 
 fs/btrfs/reflink.c                                                     |   73 -
 fs/ceph/xattr.c                                                        |   17 
 fs/debugfs/file.c                                                      |    7 
 fs/erofs/erofs_fs.h                                                    |   99 -
 fs/erofs/internal.h                                                    |    2 
 fs/erofs/zmap.c                                                        |  166 +-
 fs/eventfd.c                                                           |    9 
 fs/eventpoll.c                                                         |   23 
 fs/ext4/mballoc-test.c                                                 |    6 
 fs/f2fs/f2fs.h                                                         |    3 
 fs/f2fs/inline.c                                                       |   13 
 fs/f2fs/super.c                                                        |   11 
 fs/f2fs/sysfs.c                                                        |    7 
 fs/fhandle.c                                                           |    5 
 fs/gfs2/inode.c                                                        |    3 
 fs/gfs2/log.c                                                          |   33 
 fs/ioctl.c                                                             |   23 
 fs/kernel_read_file.c                                                  |   12 
 fs/mbcache.c                                                           |    1 
 fs/netfs/iterator.c                                                    |   15 
 fs/nfs/blocklayout/blocklayout.c                                       |    4 
 fs/nilfs2/ioctl.c                                                      |    6 
 fs/notify/fanotify/fanotify_user.c                                     |   40 
 fs/notify/inotify/inotify_user.c                                       |   17 
 fs/notify/mark.c                                                       |   39 
 fs/ntfs3/dir.c                                                         |    5 
 fs/ntfs3/fsntfs.c                                                      |    4 
 fs/ntfs3/inode.c                                                       |   13 
 fs/ntfs3/namei.c                                                       |   17 
 fs/ntfs3/super.c                                                       |    7 
 fs/ntfs3/xattr.c                                                       |    5 
 fs/ocfs2/dlm/dlmdomain.c                                               |   10 
 fs/ocfs2/ioctl.c                                                       |   18 
 fs/ocfs2/resize.c                                                      |   12 
 fs/ocfs2/xattr.c                                                       |    4 
 fs/omfs/inode.c                                                        |    6 
 fs/open.c                                                              |   36 
 fs/pstore/ram_core.c                                                   |    4 
 fs/quota/dquot.c                                                       |   38 
 fs/read_write.c                                                        |   28 
 fs/signalfd.c                                                          |    9 
 fs/smb/client/ioctl.c                                                  |    2 
 fs/smb/client/smb2file.c                                               |   27 
 fs/smb/client/smb2pdu.h                                                |    2 
 fs/smb/client/smb2transport.c                                          |   32 
 fs/smb/server/auth.c                                                   |   11 
 fs/smb/server/connection.c                                             |    9 
 fs/smb/server/mgmt/user_session.c                                      |   12 
 fs/smb/server/smb2pdu.c                                                |    2 
 fs/sync.c                                                              |   29 
 fs/tracefs/event_inode.c                                               |    2 
 include/dt-bindings/clock/qcom,dispcc-sc7180.h                         |    7 
 include/dt-bindings/clock/qcom,gcc-sc8180x.h                           |    5 
 include/linux/cdrom.h                                                  |    1 
 include/linux/cpuhotplug.h                                             |    1 
 include/linux/dmi.h                                                    |    5 
 include/linux/file.h                                                   |    6 
 include/linux/fsl/mc.h                                                 |    4 
 include/linux/if_ether.h                                               |    3 
 include/linux/moduleparam.h                                            |   11 
 include/linux/netpoll.h                                                |    6 
 include/linux/padata.h                                                 |    8 
 include/linux/pci-epc.h                                                |    6 
 include/linux/pci.h                                                    |    6 
 include/linux/pm_domain.h                                              |    4 
 include/linux/ppp_defs.h                                               |   16 
 include/linux/printk.h                                                 |    5 
 include/linux/quotaops.h                                               |    9 
 include/linux/reset.h                                                  |  274 +++
 include/linux/spinlock_up.h                                            |   20 
 include/linux/wmi.h                                                    |    4 
 include/net/page_pool/memory_provider.h                                |   15 
 include/net/page_pool/types.h                                          |    4 
 include/net/pie.h                                                      |    2 
 include/sound/soc-dai.h                                                |    6 
 include/sound/soc.h                                                    |    3 
 include/trace/events/timer.h                                           |   11 
 include/uapi/linux/mii.h                                               |    3 
 include/uapi/linux/virtio_net.h                                        |   13 
 io_uring/io-wq.c                                                       |    3 
 io_uring/kbuf.c                                                        |   14 
 io_uring/sqpoll.c                                                      |   29 
 kernel/audit.c                                                         |    4 
 kernel/auditsc.c                                                       |    2 
 kernel/bpf/arena.c                                                     |    4 
 kernel/bpf/arraymap.c                                                  |    4 
 kernel/bpf/bpf_lsm.c                                                   |    3 
 kernel/bpf/core.c                                                      |    2 
 kernel/bpf/devmap.c                                                    |    5 
 kernel/bpf/hashtab.c                                                   |    2 
 kernel/bpf/helpers.c                                                   |   17 
 kernel/bpf/local_storage.c                                             |    2 
 kernel/bpf/task_iter.c                                                 |  151 +-
 kernel/bpf/verifier.c                                                  |  127 +
 kernel/cgroup/cgroup.c                                                 |   22 
 kernel/cgroup/rdma.c                                                   |    2 
 kernel/events/core.c                                                   |   14 
 kernel/fork.c                                                          |   11 
 kernel/futex/requeue.c                                                 |   13 
 kernel/module/main.c                                                   |    4 
 kernel/nsproxy.c                                                       |    5 
 kernel/padata.c                                                        |  130 -
 kernel/params.c                                                        |   42 
 kernel/pid.c                                                           |    7 
 kernel/sched/core.c                                                    |    1 
 kernel/sched/ext.c                                                     |    8 
 kernel/sys.c                                                           |   15 
 kernel/time/hrtimer.c                                                  |   56 
 kernel/trace/trace_branch.c                                            |    8 
 kernel/trace/trace_events_hist.c                                       |   12 
 kernel/watch_queue.c                                                   |    6 
 kernel/workqueue.c                                                     |    4 
 lib/net_utils.c                                                        |    4 
 mm/fadvise.c                                                           |   10 
 mm/readahead.c                                                         |   17 
 net/bluetooth/hci_event.c                                              |    3 
 net/bluetooth/l2cap_core.c                                             |    8 
 net/bluetooth/sco.c                                                    |    3 
 net/bpf/test_run.c                                                     |   35 
 net/ceph/crush/crush.c                                                 |    6 
 net/ceph/osdmap.c                                                      |   14 
 net/core/devmem.c                                                      |   24 
 net/core/filter.c                                                      |    4 
 net/core/gro.c                                                         |    4 
 net/core/neighbour.c                                                   |   10 
 net/core/net_namespace.c                                               |   10 
 net/core/netpoll.c                                                     |  219 ++-
 net/core/page_pool.c                                                   |   34 
 net/core/skbuff.c                                                      |   11 
 net/ipv4/netfilter/arp_tables.c                                        |   18 
 net/ipv4/netfilter/arpt_mangle.c                                       |    8 
 net/ipv4/nexthop.c                                                     |    4 
 net/ipv4/syncookies.c                                                  |    2 
 net/ipv4/tcp.c                                                         |   22 
 net/ipv4/tcp_input.c                                                   |    6 
 net/ipv4/tcp_output.c                                                  |   16 
 net/ipv4/tcp_plb.c                                                     |    2 
 net/ipv4/tcp_timer.c                                                   |    5 
 net/ipv4/udp.c                                                         |   16 
 net/ipv6/icmp.c                                                        |   10 
 net/ipv6/udp.c                                                         |   17 
 net/mac80211/debugfs_sta.c                                             |    7 
 net/mac80211/mlme.c                                                    |    3 
 net/mptcp/fastopen.c                                                   |   28 
 net/mptcp/pm_netlink.c                                                 |   26 
 net/mptcp/protocol.c                                                   |    4 
 net/mptcp/protocol.h                                                   |    5 
 net/mptcp/subflow.c                                                    |    3 
 net/netfilter/ipvs/ip_vs_xmit.c                                        |   19 
 net/netfilter/nf_conntrack_proto_sctp.c                                |   10 
 net/netfilter/nf_conntrack_sip.c                                       |  160 +-
 net/netfilter/nf_nat_amanda.c                                          |    2 
 net/netfilter/nf_nat_sip.c                                             |   34 
 net/netfilter/nf_tables_api.c                                          |   30 
 net/netfilter/nfnetlink_osf.c                                          |   45 
 net/netfilter/nft_ct.c                                                 |    2 
 net/netfilter/nft_fwd_netdev.c                                         |   10 
 net/netfilter/nft_osf.c                                                |    6 
 net/netfilter/xt_mac.c                                                 |   34 
 net/netfilter/xt_owner.c                                               |   37 
 net/netfilter/xt_physdev.c                                             |   29 
 net/netfilter/xt_policy.c                                              |    2 
 net/netfilter/xt_realm.c                                               |    2 
 net/netfilter/xt_socket.c                                              |   23 
 net/openvswitch/datapath.c                                             |   35 
 net/openvswitch/vport.c                                                |    3 
 net/rds/af_rds.c                                                       |   10 
 net/rds/connection.c                                                   |   14 
 net/rds/ib.c                                                           |   24 
 net/rds/ib.h                                                           |    1 
 net/rds/ib_rdma.c                                                      |    2 
 net/rds/message.c                                                      |    1 
 net/sched/act_ct.c                                                     |    8 
 net/sched/act_mirred.c                                                 |    2 
 net/sched/sch_cake.c                                                   |   15 
 net/sched/sch_choke.c                                                  |   26 
 net/sched/sch_fq_codel.c                                               |    3 
 net/sched/sch_fq_pie.c                                                 |   19 
 net/sched/sch_hhf.c                                                    |   19 
 net/sched/sch_netem.c                                                  |   76 -
 net/sched/sch_pie.c                                                    |   52 
 net/sched/sch_red.c                                                    |   31 
 net/sched/sch_sfb.c                                                    |   54 
 net/sched/sch_taprio.c                                                 |   22 
 net/sctp/inqueue.c                                                     |    1 
 net/sctp/sm_statefuns.c                                                |    6 
 net/sctp/socket.c                                                      |    2 
 net/socket.c                                                           |  303 +---
 net/tipc/msg.c                                                         |   14 
 net/tls/tls.h                                                          |    1 
 net/tls/tls_strp.c                                                     |    6 
 net/tls/tls_sw.c                                                       |    4 
 net/unix/af_unix.c                                                     |    9 
 net/unix/unix_bpf.c                                                    |    3 
 scripts/package/builddeb                                               |    8 
 security/integrity/ima/ima_crypto.c                                    |    2 
 security/integrity/ima/ima_fs.c                                        |  157 --
 security/landlock/syscalls.c                                           |   26 
 sound/core/compress_offload.c                                          |    7 
 sound/core/sound.c                                                     |    7 
 sound/isa/sc6000.c                                                     |  152 +-
 sound/pci/hda/cs35l56_hda.c                                            |   12 
 sound/pci/hda/cs35l56_hda.h                                            |    1 
 sound/pci/hda/patch_conexant.c                                         |   20 
 sound/pci/hda/patch_realtek.c                                          |   20 
 sound/soc/amd/acp/acp-legacy-mach.c                                    |    2 
 sound/soc/amd/acp/acp-mach-common.c                                    |   22 
 sound/soc/amd/acp/acp-mach.h                                           |    4 
 sound/soc/amd/acp/acp-sof-mach.c                                       |    2 
 sound/soc/codecs/ab8500-codec.c                                        |    6 
 sound/soc/fsl/fsl_easrc.c                                              |  123 +
 sound/soc/fsl/fsl_micfil.c                                             |   60 
 sound/soc/fsl/fsl_xcvr.c                                               |   22 
 sound/soc/mediatek/mt8188/mt8188-dai-pcm.c                             |    2 
 sound/soc/mediatek/mt8195/mt8195-dai-pcm.c                             |    2 
 sound/soc/mediatek/mt8365/mt8365-dai-dmic.c                            |    6 
 sound/soc/mediatek/mt8365/mt8365-dai-pcm.c                             |    2 
 sound/soc/qcom/qdsp6/topology.c                                        |    8 
 sound/soc/sh/rcar/core.c                                               |    2 
 sound/soc/soc-compress.c                                               |    4 
 sound/soc/soc-pcm.c                                                    |   33 
 sound/soc/sof/compress.c                                               |    8 
 sound/soc/sof/intel/hda-stream.c                                       |   10 
 sound/soc/sof/ipc3.c                                                   |    2 
 sound/soc/sof/sof-priv.h                                               |    2 
 sound/soc/sti/uniperif_player.c                                        |    9 
 sound/usb/midi.c                                                       |   12 
 sound/usb/midi2.c                                                      |   12 
 sound/usb/mixer_scarlett2.c                                            |    2 
 sound/usb/quirks.c                                                     |    2 
 sound/usb/stream.c                                                     |   58 
 sound/usb/stream.h                                                     |    3 
 tools/lib/bpf/relo_core.c                                              |    2 
 tools/perf/builtin-diff.c                                              |    6 
 tools/perf/builtin-list.c                                              |   13 
 tools/perf/builtin-lock.c                                              |    2 
 tools/perf/builtin-stat.c                                              |   44 
 tools/perf/util/Build                                                  |    1 
 tools/perf/util/branch.h                                               |    3 
 tools/perf/util/cgroup.c                                               |   30 
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c                        |   51 
 tools/perf/util/evsel.c                                                |  296 ----
 tools/perf/util/evsel.h                                                |   49 
 tools/perf/util/expr.c                                                 |    3 
 tools/perf/util/maps.c                                                 |   13 
 tools/perf/util/metricgroup.c                                          |    1 
 tools/perf/util/parse-events.c                                         |   94 -
 tools/perf/util/parse-events.h                                         |   11 
 tools/perf/util/parse-events.l                                         |   11 
 tools/perf/util/parse-events.y                                         |   18 
 tools/perf/util/pmu.c                                                  |   26 
 tools/perf/util/pmu.h                                                  |    4 
 tools/perf/util/pmus.c                                                 |    9 
 tools/perf/util/print-events.c                                         |   36 
 tools/perf/util/print-events.h                                         |    1 
 tools/perf/util/python.c                                               |   61 
 tools/perf/util/stat-display.c                                         |    6 
 tools/perf/util/stat-shadow.c                                          |    1 
 tools/perf/util/symbol-elf.c                                           |    8 
 tools/perf/util/tool_pmu.c                                             |  417 +++++
 tools/perf/util/tool_pmu.h                                             |   51 
 tools/perf/util/util.h                                                 |    1 
 tools/testing/ktest/ktest.pl                                           |   35 
 tools/testing/selftests/bpf/prog_tests/snprintf.c                      |    3 
 tools/testing/selftests/bpf/progs/bpf_misc.h                           |    2 
 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c                |    8 
 tools/testing/selftests/cgroup/test_memcontrol.c                       |   11 
 tools/testing/selftests/mm/migration.c                                 |    3 
 tools/testing/selftests/net/netfilter/nft_tproxy_udp.sh                |   14 
 tools/testing/selftests/powerpc/vphn/Makefile                          |    2 
 tools/testing/selftests/sched_ext/exit.c                               |    2 
 virt/kvm/dirty_ring.c                                                  |    3 
 virt/kvm/vfio.c                                                        |    8 
 745 files changed, 8154 insertions(+), 5262 deletions(-)

Aaro Koskinen (1):
      ARM: OMAP1: Fix DEBUG_LL and earlyprintk on OMAP16XX

Aaron Sacks (1):
      KVM: Reject wrapped offset in kvm_reset_dirty_gfn()

Abdun Nihaal (1):
      mfd: mc13xxx-core: Fix memory leak in mc13xxx_add_subdevice_pdata()

Ahsan Atta (2):
      crypto: qat - disable 4xxx AE cluster when lead engine is fused off
      crypto: qat - disable 420xx AE cluster when lead engine is fused off

Akari Tsuyukusa (3):
      arm64: dts: mediatek: mt6795: Fix gpio-ranges pin count
      arm64: dts: mediatek: mt7981b: Fix gpio-ranges pin count
      arm64: dts: mediatek: mt7986a: Fix gpio-ranges pin count

Akhil P Oommen (1):
      drm/msm/a6xx: Use barriers while updating HFI Q headers

Akhil R (3):
      crypto: tegra - finalize crypto req on error
      crypto: tegra - Transfer HASH init function to crypto engine
      crypto: tegra - Reserve keyslots to allocate dynamically

Akihiko Odaki (3):
      virtio_net: Split struct virtio_net_rss_config
      virtio_net: Fix endian with virtio_net_ctrl_rss
      virtio_net: Use new RSS config structs

Aksh Garg (1):
      PCI: dwc: ep: Fix MSI-X Table Size configuration in dw_pcie_ep_set_msix()

Al Viro (5):
      net/socket.c: switch to CLASS(fd)
      fdget(), trivial conversions
      ima_fs: don't bother with removal of files in directory we'll be removing
      ima_fs: get rid of lookup-by-dentry stuff
      ntfs: ->d_compare() must not block

Alex Deucher (2):
      drm/amdgpu/gfx10: look at the right prop for gfx queue priority
      drm/amdgpu/gfx11: look at the right prop for gfx queue priority

Alexander Konyukhov (1):
      drm/komeda: fix integer overflow in AFBC framebuffer size check

Alexander Koskovich (2):
      drm/msm/dsi: rename MSM8998 DSI version from V2_2_0 to V2_0_0
      arm64: dts: qcom: sm8250: Add missing CPU7 3.09GHz OPP

Alexandre Demers (1):
      drm/amdgpu: fix spelling typos

Alexandru Dadu (1):
      drm/imagination: Switch reset_reason fields from enum to u32

Alexei Starovoitov (1):
      bpf: Fix variable length stack write over spilled pointers

Alexey Kodanev (1):
      nfp: fix swapped arguments in nfp_encode_basic_qdr() calls

Alexey Velichayshiy (1):
      wifi: rtw89: phy: fix uninitialized variable access in rtw89_phy_cfo_set_crystal_cap()

Alice Mikityanska (1):
      ice: Remove jumbo_remove step from TX path

Allison Henderson (1):
      net/rds: reset op_nents when zerocopy page pin fails

Alok Tiwari (5):
      wifi: mt76: mt7996: fix FCS error flag check in RX descriptor
      ipv4: udp: fix typos in comments
      ipv6: udp: fix typos in comments
      soc: qcom: llcc: fix v1 SB syndrome register offset
      soc: qcom: aoss: compare against normalized cooling state

Altan Hacigumus (1):
      tcp: make probe0 timer handle expired user timeout

Amir Goldstein (1):
      fsnotify: fix inode reference leak in fsnotify_recalc_mask()

Amit Machhiwal (1):
      selftests/powerpc: Suppress -Wmaybe-uninitialized with GCC 15

Andreas Gruenbacher (3):
      gfs2: Call unlock_new_inode before d_instantiate
      gfs2: add some missing log locking
      gfs2: prevent NULL pointer dereference during unmount

Andy Shevchenko (5):
      fbdev: matroxfb: Mark variable with __maybe_unused to avoid W=1 build break
      pinctrl: cy8c95x0: remove duplicate error message
      pinctrl: cy8c95x0: Unify messages with help of dev_err_probe()
      pinctrl: cy8c95x0: Avoid returning positive values to user space
      nfs/blocklayout: Fix compilation error (`make W=1`) in bl_write_pagelist()

AnishMulay (1):
      selftests/mm: skip migration tests if NUMA is unavailable

Anthony Pighin (Nokia) (1):
      rtc: abx80x: Disable alarm feature if no interrupt attached

Arnaldo Carvalho de Melo (1):
      perf util: Kill die() prototype, dead for a long time

Arnd Bergmann (1):
      clk: qoriq: avoid format string warning

Ashutosh Desai (1):
      drm/v3d: Reject empty multisync extension to prevent infinite loop

Bae Yeonju (1):
      fs/adfs: validate nzones in adfs_validate_bblk()

Baochen Qiang (1):
      wifi: ath10k: fix station lookup failure during disconnect

Barnabás Czémán (2):
      arm64: dts: qcom: msm8953-xiaomi-vince: correct wled ovp value
      arm64: dts: qcom: msm8953-xiaomi-daisy: fix backlight

Bart Van Assche (2):
      drbd: Balance RCU calls in drbd_adm_dump_devices()
      locking: Fix rwlock support in <linux/spinlock_up.h>

Biju Das (1):
      pinctrl: renesas: rzg2l: Fix save/restore of {IOLH,IEN,PUPD,SMT} registers

Billy Tsai (2):
      hwmon: (aspeed-g6-pwm-tach): remove redundant driver remove callback
      i3c: mipi-i3c-hci: fix IBI payload length calculation for final status

Breno Leitao (8):
      tracing: branch: Fix inverted check on stat tracer registration
      netpoll: Extract carrier wait function
      netpoll: extract IPv4 address retrieval into helper function
      netpoll: fix IPv6 local-address corruption
      netconsole: propagate device name truncation in dev_name_store()
      netpoll: Extract IPv6 address retrieval function
      netpoll: pass buffer size to egress_dev() to avoid MAC truncation
      workqueue: Fix wq->cpu_pwq leak in alloc_and_link_pwqs() WQ_UNBOUND path

Brett Creeley (1):
      virtio_net: sync rss_trailer.max_tx_vq on queue_pairs change via VQ_PAIRS_SET

Brian Masney (2):
      irqchip/irq-pic32-evic: Address warning related to wrong printf() formatter
      clk: visconti: pll: initialize clk_init_data to zero

Cai Xinchen (2):
      dpaa2: add independent dependencies for FSL_DPAA2_SWITCH
      dpaa2: compile dpaa2 even CONFIG_FSL_DPAA2_ETH=n

Chaitanya Kumar Borah (1):
      drm/i915/dp: Fix VSC dynamic range signaling for RGB formats

Chao Yu (2):
      erofs: do sanity check on m->type in z_erofs_load_compact_lcluster()
      f2fs: fix false alarm of lockdep on cp_global_sem lock

Charles Perry (1):
      net: phy: fix a return path in get_phy_c45_ids()

Chen Ni (3):
      mtd: physmap_of_gemini: Fix disabled pinctrl state check
      backlight: sky81452-backlight: Check return value of devm_gpiod_get_optional() in sky81452_bl_parse_dt()
      leds: lgm-sso: Remove duplicate assignments for priv->mmap

Chen-Yu Tsai (1):
      PCI: mediatek-gen3: Prevent leaking IRQ domains when IRQ not found

Chih Kai Hsu (1):
      r8152: fix incorrect register write to USB_UPHY_XTAL

Chris Morgan (2):
      arm64: dts: rockchip: Correct Fan Supply for Gameforce Ace
      arm64: dts: rockchip: Correct Joystick Axes on Gameforce Ace

Christian A. Ehrhardt (1):
      ASoC: codecs: ab8500: Fix casting of private data

Christian König (1):
      drm/amdgpu: fix AMDGPU_INFO_READ_MMR_REG

Christoph Hellwig (1):
      arm64/xor: fix conflicting attributes for xor_block_template

Chuck Lever (1):
      perf tools: Fix module symbol resolution for non-zero .text sh_addr

Chuyi Zhou (1):
      padata: Remove cpu online check from cpu add and removal

Cole Leavitt (2):
      pstore/ram: fix resource leak when ioremap() fails
      soundwire: bus: demote UNATTACHED state warnings to dev_dbg()

Connor Abbott (1):
      drm/msm/a6xx: Fix dumping A650+ debugbus blocks

Cosmin Tanislav (2):
      mtd: parsers: ofpart: call of_node_put() only in ofpart_fail path
      mtd: parsers: ofpart: call of_node_get() for dedicated subpartitions

Cássio Gabriel (5):
      ALSA: core: Validate compress device numbers without dynamic minors
      ASoC: SOF: compress: return the configured codec from get_params
      ALSA: sc6000: Keep the programmed board state in card-private data
      ALSA: usb-audio: Bound MIDI 2.0 endpoint descriptor scans
      ALSA: usb-audio: Bound MIDI endpoint descriptor scans

Daan De Meyer (2):
      loop: fix partition scan race between udev and loop_reread_partitions()
      cdrom, scsi: sr: propagate read-only status to block layer via set_disk_ro()

DaeMyung Kang (3):
      ksmbd: destroy tree_conn_ida in ksmbd_session_destroy()
      ksmbd: destroy async_ida in ksmbd_conn_free()
      ksmbd: fix durable fd leak on ClientGUID mismatch in durable v2 open

Dan Carpenter (1):
      sfc: fix error code in efx_devlink_info_running_versions()

Daniel Baluta (1):
      ASoC: SOF: ipc3: Use standard dev_dbg API

Daniel Borkmann (3):
      bpf: Enforce regsafe base id consistency for BPF_ADD_CONST scalars
      bpf, arm64: Fix off-by-one in check_imm signed range check
      bpf: Fix precedence bug in convert_bpf_ld_abs alignment check

Daniel Hodges (1):
      ima: check return value of crypto_shash_final() in boot aggregate

Daniel Jordan (1):
      padata: Put CPU offline callback in ONLINE section to allow failure

Danilo Krummrich (5):
      devres: fix missing node debug info in devm_krealloc()
      PCI: use generic driver_override infrastructure
      platform/wmi: use generic driver_override infrastructure
      s390/cio: use generic driver_override infrastructure
      bus: fsl-mc: use generic driver_override infrastructure

David Carlier (3):
      bpf: Use RCU-safe iteration in dev_map_redirect_multi() SKB path
      selftests/sched_ext: Add missing error check for exit__load()
      eventfs: Use list_add_tail_rcu() for SRCU-protected children list

David Heidelberg (1):
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Mark l1a regulator as powered during boot

David Howells (1):
      netfs: Fix potential uninitialised var in netfs_extract_user_iter()

David Sterba (1):
      btrfs: pass struct btrfs_inode to clone_copy_inline_extent()

Deepanshu Kartikey (1):
      nilfs2: reject zero bd_oblocknr in nilfs_ioctl_mark_blocks_dirty()

Denis Benato (4):
      HID: asus: make asus_resume adhere to linux kernel coding standards
      HID: asus: do not abort probe when not necessary
      platform/x86: asus-wmi: adjust screenpad power/brightness handling
      platform/x86: asus-wmi: fix screenpad brightness range

Denis Rastyogin (1):
      ASoC: rsnd: Fix potential out-of-bounds access of component_dais[]

Dmitry Baryshkov (6):
      drm/panel: sharp-ls043t1le01: make use of prepare_prev_first
      PM: domains: De-constify fields in struct dev_pm_domain_attach_data
      soc: qcom: ocmem: make the core clock optional
      soc: qcom: ocmem: register reasons for probe deferrals
      soc: qcom: ocmem: return -EPROBE_DEFER is ocmem is not available
      clk: qcom: dispcc-sm8450: use RCG2 ops for DPTX1 AUX clock source

Dmitry Safonov (1):
      ima_fs: Correctly create securityfs files for unsupported hash algos

Doug Berger (3):
      net: bcmgenet: add bcmgenet_has_* helpers
      net: bcmgenet: move DESC_INDEX flow to ring 0
      net: bcmgenet: support reclaiming unsent Tx packets

Dudu Lu (4):
      Bluetooth: l2cap: Add missing chan lock in l2cap_ecred_reconf_rsp
      net/sched: act_mirred: fix wrong device for mac_header_xmit check in tcf_blockcast_redir
      macvlan: fix macvlan_get_size() not reserving space for IFLA_MACVLAN_BC_CUTOFF
      net/sched: sch_cake: fix NAT destination port not being updated in cake_update_flowkeys

Duoming Zhou (3):
      wifi: rtlwifi: pci: fix possible use-after-free caused by unfinished irq_prepare_bcn_tasklet
      wifi: mt76: mt7915: fix use-after-free bugs in mt7915_mac_dump_work()
      wifi: mt76: mt7996: fix use-after-free bugs in mt7996_mac_dump_work()

Eduard Zingerman (1):
      selftests/bpf: fix __jited_unpriv tag name

Emil Tsalapatis (1):
      bpf: Allow instructions with arena source and non-arena dest registers

Eric Dumazet (18):
      macvlan: annotate data-races around port->bc_queue_len_used
      tcp: add data-race annotations around tp->data_segs_out and tp->total_retrans
      tcp: add data-race annotations for TCP_NLA_SNDQ_SIZE
      tcp: annotate data-races around tp->bytes_sent
      tcp: annotate data-races around tp->bytes_retrans
      tcp: annotate data-races around tp->dsack_dups
      tcp: annotate data-races around (tp->write_seq - tp->snd_nxt)
      tcp: annotate data-races around tp->plb_rehash
      ipv6: fix possible UAF in icmpv6_rcv()
      net_sched: sch_hhf: annotate data-races in hhf_dump_stats()
      net/sched: sch_pie: annotate data-races in pie_dump_stats()
      net/sched: sch_fq_codel: remove data-races from fq_codel_dump_stats()
      net/sched: sch_red: annotate data-races in red_dump_stats()
      net/sched: sch_sfb: annotate data-races in sfb_dump_stats()
      net/sched: sch_choke: annotate data-races in choke_dump_stats()
      net/sched: sch_fq_pie: annotate data-races in fq_pie_dump_stats()
      net/sched: sch_cake: annotate data-races in cake_dump_stats() (V)
      net/sched: sch_pie: annotate more data-races in pie_dump_stats()

Ethan Tidmore (5):
      wifi: brcmfmac: Fix error pointer dereference
      drm/sun4i: backend: fix error pointer dereference
      drm/sun4i: Fix resource leaks
      ASoC: SOF: Intel: hda: Place check before dereference
      pinctrl: pinctrl-pic32: Fix resource leak

Fedor Pchelkin (1):
      platform/x86: dell_rbu: avoid uninit value usage in packet_size_write()

Felix Gu (8):
      spi: nxp-fspi: Use reinit_completion() for repeated operations
      spi: fsl-qspi: Use reinit_completion() for repeated operations
      pmdomain: ti: omap_prm: Fix a reference leak on device node
      pmdomain: imx: scu-pd: Fix device_node reference leak during ->probe()
      i3c: master: dw-i3c: Fix missing reset assertion in remove() callback
      i3c: dw: Fix memory leak in dw_i3c_master_i3c_xfers()
      clk: imx: imx6q: Fix device node reference leak in pll6_bypassed()
      clk: imx: imx6q: Fix device node reference leak in of_assigned_ldb_sels()

Feng Yang (1):
      bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap

Fernando Fernandez Mancera (2):
      netfilter: nfnetlink_osf: fix out-of-bounds read on option matching
      netfilter: nfnetlink_osf: fix potential NULL dereference in ttl check

Filipe Manana (4):
      btrfs: fix deadlock between reflink and transaction commit when using flushoncommit
      btrfs: use inode already stored in local variable at btrfs_rmdir()
      btrfs: use btrfs inodes in btrfs_rmdir() to avoid so much usage of BTRFS_I()
      btrfs: fix missing last_unlink_trans update when removing a directory

Florian Westphal (7):
      netfilter: xt_socket: enable defrag after all other checks
      netfilter: nft_fwd_netdev: check ttl/hl before forwarding
      selftests: netfilter: nft_tproxy.sh: adjust to socat changes
      RDMA/core: Prefer NLA_NUL_STRING
      netfilter: conntrack: remove sprintf usage
      netfilter: nf_conntrack_sip: don't use simple_strtoul
      neigh: let neigh_xmit take skb ownership

Francesco Dolcini (2):
      arm64: dts: imx8-apalis: Fix LEDs name collision
      arm64: dts: ti: k3-am62-verdin: Fix SPI_1 GPIO CS pinctrl label

Francesco Lavra (1):
      hte: tegra194: remove Kconfig dependency on Tegra194 SoC

Frank Li (2):
      ARM: dts: imx27-eukrea: replace interrupts with interrupts-extended
      dmaengine: mxs-dma: Fix missing return value from of_dma_controller_register()

Gabor Juhos (1):
      arm64: dts: marvell: armada-37xx: use 'usb2-phy' in USB3 controller's phy-names

Gabriel Krisman Bertazi (1):
      udp: Force compute_score to always inline

Gal Pressman (2):
      net/mlx5e: Fix features not applied during netdev registration
      net/mlx5e: IPsec, fix ASO poll timeout with read_poll_timeout_atomic()

Gao Xiang (3):
      erofs: add encoded extent on-disk definition
      erofs: avoid infinite loops due to corrupted subpage compact indexes
      erofs: unify lcn as u64 for 32-bit platforms

Gatien Chevallier (1):
      bus: rifsc: fix RIF configuration check for peripherals

Geert Uytterhoeven (3):
      dt-bindings: interrupt-controller: arm,gic-v3: Fix EPPI range
      clk: xgene: Fix mapping leak in xgene_pllclk_init()
      lib/hexdump: print_hex_dump_bytes() calls print_hex_dump_debug()

Gerd Bayer (1):
      PCI: Enable AtomicOps only if Root Port supports them

Giovanni Cabiddu (2):
      crypto: qat - fix type mismatch in RAS sysfs show functions
      crypto: qat - use swab32 macro

Gopi Krishna Menon (1):
      thermal/drivers/spear: Fix error condition for reading st,thermal-flags

Greg Jumper (1):
      net/rds: Restrict use of RDS/IB to the initial network namespace

Greg Kroah-Hartman (2):
      smb: client: fix OOB reads parsing symlink error response
      Linux 6.12.91

Grzegorz Nitka (2):
      ice: update PCS latency settings for E825 10G/25Gb modes
      ice: fix timestamp interrupt configuration for E825C

Gui-Dong Han (3):
      debugfs: check for NULL pointer in debugfs_create_str()
      debugfs: fix placement of EXPORT_SYMBOL_GPL for debugfs_create_str()
      soundwire: debugfs: initialize firmware_file to empty string

Guilherme G. Piccoli (1):
      ASoC: amd: acp: Add DMI quirk for Valve Steam Deck OLED

Guillaume Gonnet (1):
      dm init: ensure device probing has finished in dm-mod.waitfor=

Gyeyoung Baek (1):
      drm/panfrost: Fix wait_bo ioctl leaking positive return from dma_resv_wait_timeout()

Haibo Chen (2):
      spi: spi-nxp-fspi: enable runtime pm for fspi
      mtd: spi-nor: core: correct the op.dummy.nbytes when check read operations

Haixin Xu (1):
      crypto: jitterentropy - replace long-held spinlock with mutex

Haoyu Lu (1):
      ACPI: AGDI: fix missing newline in error message

Harikrishna Shenoy (1):
      drm/bridge: cadence: cdns-mhdp8546-core: Handle HDCP state in bridge atomic check

Hasan Basbunar (1):
      page_pool: fix memory-provider leak in page_pool_create_percpu() error path

Heiko Schocher (1):
      net: phy: dp83869: fix setting CLK_O_SEL field.

Heiko Stuebner (1):
      arm64: dts: rockchip: Make Jaguar PCIe-refclk pin use pull-up config

Herbert Xu (2):
      crypto: tegra - Disable softirqs before finalizing request
      crypto: af_alg - Cap AEAD AD length to 0x80000000

HyungJung Joo (2):
      fs/omfs: reject s_sys_blocksize smaller than OMFS_DIR_START
      fs/mbcache: cancel shrink work before destroying the cache

Hyunwoo Kim (2):
      ksmbd: scope conn->binding slowpath to bound sessions only
      net: skbuff: propagate shared-frag marker through frag-transfer helpers

Håkon Bugge (1):
      net/rds: Optimize rds_ib_laddr_check

Ian Rogers (9):
      perf branch: Avoid incrementing NULL
      perf lock: Fix option value type in parse_max_stack
      perf stat: Fix opt->value type for parse_cache_level
      perf evsel: Add alternate_hw_config and use in evsel__match
      perf tool_pmu: Factor tool events into their own PMU
      perf python: Add parse_events function
      perf cgroup: Update metric leader in evlist__expand_cgroup
      perf maps: Fix copy_from that can break sorted by name order
      perf tool_pmu: Fix aggregation on duration_time

Ido Schimmel (1):
      vrf: Fix a potential NPD when removing a port from a VRF

Igor Pylypiv (1):
      ata: libata-scsi: fix requeue of deferred ATA PASS-THROUGH commands

Ilya Leoshkevich (1):
      s390/bpf: Zero-extend bpf prog return values and kfunc arguments

Jackie Liu (1):
      blk-cgroup: fix disk reference leak in blkcg_maybe_throttle_current()

Jacob Keller (1):
      ice: fix ice_ptp_read_tx_hwtstamp_status_eth56g

Jacob Pan (1):
      iommufd: vfio compatibility extension check for noiommu mode

Jagadeesh Kona (1):
      clk: qcom: gcc-x1e80100: Keep GCC USB QTB clock always ON

Jakub Kicinski (1):
      net: tls: fix strparser anchor skb leak on offload RX setup failure

Jamal Hadi Salim (1):
      net/sched: act_ct: Only release RCU read lock after ct_ft

James Clark (1):
      arm64: cpufeature: Make PMUVer and PerfMon unsigned

Jan Kara (1):
      quota: Fix race of dquot_scan_active() with quota deactivation

Jane Chu (1):
      Documentation: fix a hugetlbfs reservation statement

Jason Gunthorpe (2):
      iommu/amd: Put list_add/del(dev_data) back under the domain->lock
      RDMA/mana: Remove user triggerable WARN_ON() in mana_ib_create_qp_rss()

Jason-JH Lin (1):
      mailbox: mtk-cmdq: Fix CURR and END addr for task insert case

Jayesh Choudhary (2):
      drm/bridge: cadence: cdns-mhdp8546-core: Set the mhdp connector earlier in atomic_enable()
      drm/bridge: cadence: cdns-mhdp8546-core: Add mode_valid hook to drm_bridge_funcs

Jian Zhang (3):
      ipmi: ssif_bmc: fix missing check for copy_to_user() partial failure
      ipmi: ssif_bmc: fix message desynchronization after truncated response
      ipmi: ssif_bmc: change log level to dbg in irq callback

Jiayuan Chen (3):
      bpf: Drop task_to_inode and inet_conn_established from lsm sleepable hooks
      net, bpf: fix null-ptr-deref in xdp_master_redirect() for down master
      nexthop: fix IPv6 route referencing IPv4 nexthop

Jiexun Wang (1):
      netfilter: xt_policy: fix strict mode inbound policy matching

Johan Hovold (4):
      drm/gma500/oaktrail_hdmi: fix i2c adapter leak on setup
      drm/gma500/oaktrail_lvds: fix hang on init failure
      drm/gma500/oaktrail_lvds: fix i2c adapter leaks on init
      spi: sifive: fix controller deregistration

John Madieu (1):
      spi: rockchip: Read ISR, not IMR, to detect cs-inactive IRQ

Jonas Gorski (1):
      mtd: spi-nor: update spi_nor_fixups::post_sfdp() documentation

Jonathan Rissanen (1):
      Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on error

Joshua Klinesmith (1):
      ksmbd: fix use-after-free from async crypto on Qualcomm crypto engine

Josua Mayer (7):
      dt-bindings: net: dsa: nxp,sja1105: make spi-cpol optional for sja1110
      arm64: dts: lx2160a: change i2c0 (iic1) pinmux mask to one bit
      arm64: dts: lx2160a: remove duplicate pinmux nodes
      arm64: dts: lx2160a: rename pinmux nodes for readability
      arm64: dts: lx2160a: add sda gpio references for i2c bus recovery
      arm64: dts: lx2160a: change zeros to hexadecimal in pinmux nodes
      arm64: dts: lx2160a: complete pinmux for rcwsr12 configuration word

Judith Mendez (2):
      arm64: dts: ti: k3-am62p5-sk: Disable MMC1 internal pulls on data pins
      arm64: dts: ti: k3-am62-lp-sk: Enable internal pulls for MMC0 data pins

Jun Yan (1):
      arm64: dts: meson-gxl-p230: fix ethernet PHY interrupt number

Junrui Luo (5):
      dm log: fix out-of-bounds write due to region_count overflow
      ocfs2/dlm: validate qr_numregions in dlm_match_regions()
      ocfs2/dlm: fix off-by-one in dlm_match_regions() region comparison
      scsi: target: core: Fix integer overflow in UNMAP bounds check
      KVM: s390: pci: fix GAIT table indexing due to double-scaling pointer arithmetic

Justin Chen (3):
      net: bcmgenet: fix off-by-one in bcmgenet_put_txcb
      net: bcmgenet: fix racing timeout handler
      net: bcmgenet: fix leaking free_bds

Kailang Yang (1):
      ALSA: hda/realtek - fixed speaker no sound update

Keith Busch (1):
      nvme-pci: fix missed admin queue sq doorbell write

Khairul Anuar Romli (1):
      dmaengine: dw-axi-dmac: Remove unnecessary return statement from void function

Kohei Enju (2):
      i40e: don't advertise IFF_SUPP_NOFCS
      vhost_net: fix sleeping with preempt-disabled in vhost_net_busy_poll()

Koichiro Den (1):
      PCI: dwc: rcar-gen4: Change EPC BAR alignment to 4K as per the documentation

Konrad Dybcio (6):
      arm64: dts: qcom: sm8450: Fix GIC_ITS range length
      arm64: dts: qcom: sm8550: Fix GIC_ITS range length
      arm64: dts: qcom: sm8650: Fix GIC_ITS range length
      clk: qcom: dispcc-sm4450: Fix DSI byte clock rate setting
      dt-bindings: clock: qcom,dispcc-sc7180: Define MDSS resets
      clk: qcom: dispcc-sc7180: Add missing MDSS resets

Krishna Chaitanya Chundru (1):
      PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support

Kuninori Morimoto (2):
      ASoC: add symmetric_ prefix for dai->rate/channels/sample_bits
      ASoC: soc-compress: use function to clear symmetric params

Kuniyuki Iwashima (1):
      tcp: Don't set treq->req_usec_ts in cookie_tcp_reqsk_init().

Lang Xu (1):
      bpf: Fix OOB in pcpu_init_value

Laurent Pinchart (1):
      media: i2c: og01a1b: Replace client->dev usage

Lee Jones (1):
      tipc: fix double-free in tipc_buf_append()

Lei Huang (1):
      ALSA: hda/realtek: fix code style (ERROR: else should follow close brace '}')

Leo Yan (1):
      perf expr: Return -EINVAL for syntax error in expr__find_ids()

Leon Yen (1):
      wifi: mt76: mt7925: Fix incorrect MLO mode in firmware control

Li Ming (1):
      cxl/pci: Check memdev driver binding status in cxl_reset_done()

Li Xiasong (2):
      netfilter: nf_conntrack_sip: get helper before allocating expectation
      netfilter: nft_ct: fix missing expect put in obj eval

Liang Jie (1):
      smb: client: correctly handle ErrorContextData as a flexible array

Lorenzo Bianconi (3):
      net: airoha: Implement BQL support
      net: airoha: Add missing RX_CPU_IDX() configuration in airoha_qdma_cleanup_rx_queue()
      net: airoha: Move ndesc initialization at end of airoha_qdma_init_rx_queue()

Luca Weiss (3):
      net: ipa: Fix programming of QTIME_TIMESTAMP_CFG
      net: ipa: Fix decoding EV_PER_EE for IPA v5.0+
      arm64: dts: qcom: sm7225-fairphone-fp4: Fix conflicting bias pinctrl

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix printing wrong information if SDU length exceeds MTU

Ma Ke (1):
      powerpc/warp: Fix error handling in pika_dtm_thread

Manikanta Maddireddy (6):
      PCI: tegra194: Increase LTSSM poll time on surprise link down
      PCI: tegra194: Disable LTSSM after transition to Detect on surprise link down
      PCI: tegra194: Disable PERST# IRQ only in Endpoint mode
      PCI: tegra194: Use DWC IP core version
      PCI: dwc: Apply ECRC workaround to DesignWare 5.00a as well
      PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on

Manivannan Sadhasivam (2):
      PCI: dwc: Perform cleanup in the error path of dw_pcie_resume_noirq()
      PCI: tegra194: Rename 'root_bus' to 'root_port_bus' in tegra_pcie_downstream_dev_to_D0()

Mario Limonciello (1):
      Revert "ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn"

Mario Limonciello (AMD) (1):
      firmware: dmi: Correct an indexing error in dmi.h

Mark Harmstone (1):
      btrfs: fix double-decrement of bytes_may_use in submit_one_async_extent()

Mashiro Chen (1):
      net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf

Mathias Krause (1):
      kbuild: builddeb - avoid recompiles for non-cross-compiles

Matt Roper (1):
      drm/xe/debugfs: Correct printing of register whitelist ranges

Matt Vollrath (2):
      e1000e: Unroll PTP in probe error handling
      i40e: Cleanup PTP pins on probe failure

Matthew Auld (1):
      drm/xe/dma-buf: handle empty bo and UAF races

Matthieu Baerts (NGI0) (4):
      mptcp: pm: prio: skip closed subflows
      mptcp: pm: kernel: correctly retransmit ADD_ADDR ID 0
      mptcp: pm: ADD_ADDR rtx: fix potential data-race
      mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker

Maurizio Lombardi (1):
      nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec() errors to its callers

Maxime Chevallier (1):
      net: phy: qcom: at803x: Use the correct bit to disable extended next page

Maíra Canal (1):
      drm/v3d: Handle error from drm_sched_entity_init()

Michael Bommarito (2):
      sctp: fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
      net/rds: zero per-item info buffer before handing it to visitors

Michael Lo (1):
      wifi: mt76: mt7921: fix 6GHz regulatory update on connection

Michal Grzedzicki (1):
      unshare: fix nsproxy leak in ksys_unshare() on set_cred_ucounts() failure

Michal Luczaj (3):
      bpf, sockmap: Fix af_unix iter deadlock
      bpf, sockmap: Fix af_unix null-ptr-deref in proto update
      bpf, sockmap: Take state lock for af_unix iter

Michal Schmidt (1):
      ice: fix double-free of tx_buf skb

Mieczyslaw Nalewaj (1):
      net: dsa: realtek: rtl8365mb: fix mode mask calculation

Mike Leach (1):
      perf: tools: cs-etm: Fix print issue for Coresight debug in ETE/TRBE trace

Mikko Perttunen (2):
      memory: tegra124-emc: Fix dll_change check
      memory: tegra30-emc: Fix dll_change check

Mina Almasry (1):
      page_pool: fix incorrect mp_ops error handling

Ming Lei (1):
      blk-cgroup: wait for blkcg cleanup before initializing new disk

Ming Wang (1):
      arm64: dts: rockchip: Fix Bluetooth stability on LCKFB TaiShan Pi

Ming Yen Hsieh (2):
      wifi: mt76: mt7925: prevent NULL pointer dereference in mt7925_tx_check_aggr()
      wifi: mt76: mt7925: prevent NULL vif dereference in mt7925_mac_write_txwi

Ming-Hung Tsai (9):
      dm cache: fix null-deref with concurrent writes in passthrough mode
      dm cache: fix write path cache coherency in passthrough mode
      dm cache: fix write hang in passthrough mode
      dm cache policy smq: fix missing locks in invalidating cache blocks
      dm cache: fix concurrent write failure in passthrough mode
      dm cache: support shrinking the origin device
      dm cache: fix dirty mapping checking in passthrough mode switching
      dm cache metadata: fix memory leak on metadata abort retry
      dm cache: fix missing return in invalidate_committed's error path

MingTao Huang (1):
      bpf: Fix stale offload->prog pointer after constant blinding

Mohsin Bashir (1):
      eth: fbnic: Use wake instead of start

Morduan Zang (1):
      net: usb: rtl8150: free skb on usb_submit_urb() failure in xmit

Myeonghun Pak (1):
      drm/loongson: Use managed KMS polling

Mykyta Yatsenko (1):
      bpf: Fix NULL deref in map_kptr_match_type for scalar regs

Naval Alcalá (1):
      iommu/vt-d: Disable DMAR for Intel Q35 IGFX

Nicholas Carlini (1):
      io-wq: check that the predecessor is hashed in io_wq_remove_pending()

Nicolas Escande (1):
      wifi: mac80211: handle VHT EXT NSS in ieee80211_determine_our_sta_mode()

Nicolin Chen (1):
      iommu/tegra241-cmdqv: Set supports_cmd op in tegra241_vcmdq_hw_init()

Niklas Cassel (1):
      PCI: endpoint: Align pci_epc_set_msix(), pci_epc_ops::set_msix() nr_irqs encoding

Nikola Z. Ivanov (1):
      netdevsim: zero initialize struct iphdr in dummy sk_buff

Nora Schiffer (1):
      arm64: dts: freescale: imx8mp-tqma8mpql-mba8mp-ras314: fix UART1 RTS/CTS muxing

Nícolas F. R. A. Prado (1):
      arm64: dts: mediatek: mt8365: Describe infracfg-nao as a pure syscon

Oliver Neukum (1):
      HID: usbhid: fix deadlock in hid_post_reset()

Ondrej Mosnacek (1):
      fanotify: call fanotify_events_supported() before path_permission() and security_path_notify()

Pablo Neira Ayuso (4):
      netfilter: nft_osf: restrict it to ipv4
      netfilter: xtables: restrict several matches to inet family
      netfilter: arp_tables: fix IEEE1394 ARP payload parsing
      netfilter: nf_tables: unconditionally bump set->nelems before insertion

Panagiotis Petrakopoulos (1):
      ALSA: scarlett2: Add missing sentinel initializer field

Paolo Abeni (3):
      net/sched: cls_flower: revert unintended changes
      mptcp: drop __mptcp_fastopen_gen_msk_ackseq()
      mptcp: fix rx timestamp corruption on fastopen

Paul Geurts (1):
      NFC: trf7970a: Ignore antenna noise when checking for RF field

Paul Greenwalt (1):
      ice: fix ICE_AQ_LINK_SPEED_M for 200G

Paul Moses (1):
      crypto: ccp - copy IV using skcipher ivsize

Pauli Virtanen (2):
      Bluetooth: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER
      Bluetooth: btmtk: accept too short WMT FUNC_CTRL events

Paulo Alcantara (1):
      netfs: fix error handling in netfs_extract_user_iter()

Pavel Begunkov (2):
      io_uring/kbuf: use mem_is_zero()
      net: page_pool: create hooks for custom memory providers

Pei Xiao (3):
      spi: hisi-kunpeng: prevent infinite while() loop in hisi_spi_flush_fifo
      spi: mtk-snfi: unregister ECC engine on probe failure and remove() callback
      spi: sifive: Simplify clock handling with devm_clk_get_enabled()

Peng Fan (9):
      arm64: dts: imx8mp-debix-model-a: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-debix-som-a: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-navqp: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-icore-mx8mp: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-dhcom-som: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-data-modul-edm-sbc: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mm-emtop-som: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mn-tqma8mqnl: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mm-tqma8mqml: Correct PAD settings for PMIC_nINT

Pengpeng Hou (3):
      tracing: Rebuild full_name on each hist_field_name() call
      fs/ntfs3: terminate the cached volume label after UTF-8 conversion
      platform/x86: dell-wmi-sysman: bound enumeration string aggregation

Pengyu Luo (3):
      drm/msm/dsi: add the missing parameter description
      drm/msm/dsi: fix bits_per_pclk
      drm/msm/dsi: fix hdisplay calculation for CMD mode panel

Peter Zijlstra (1):
      hrtimer: Avoid pointless reprogramming in __hrtimer_start_range_ns()

Petr Malat (1):
      cgroup: Increment nr_dying_subsys_* from rmdir context

Petr Oros (5):
      iavf: rename IAVF_VLAN_IS_NEW to IAVF_VLAN_ADDING
      iavf: stop removing VLAN filters from PF on interface down
      iavf: wait for PF confirmation before removing VLAN filters
      iavf: add VIRTCHNL_OP_ADD_VLAN to success completion handler
      ice: fix NULL pointer dereference in ice_reset_all_vfs()

Petr Pavlu (2):
      params: Replace __modinit with __init_or_module
      module: Fix freeing of charp module parameters when CONFIG_SYSFS=n

Philipp Zabel (2):
      reset: replace boolean parameters with flags parameter
      reset: Add devres helpers to request pre-deasserted reset controls

Piyush Sachdeva (1):
      smb: client: Use FullSessionKey for AES-256 encryption key derivation

Prathamesh Deshpande (1):
      net/mlx5: Fix HCA caps leak on notifier init failure

Puranjay Mohan (6):
      bpf: fix mm lifecycle in open-coded task_vma iterator
      bpf: switch task_vma iterator from mmap_lock to per-VMA locks
      bpf: return VMA snapshot from task_vma iterator
      bpf: Relax scalar id equivalence for state pruning
      bpf: Validate node_id in arena_alloc_pages()
      bpf, arm32: Reject BPF-to-BPF calls and callbacks in the JIT

Qiang Ma (1):
      KVM: x86: Fix Xen hypercall tracepoint argument assignment

Qingfang Deng (1):
      pppoe: drop PFC frames

Qu Wenruo (1):
      btrfs: do not mark inode incompressible after inline attempt fails

Rafael J. Wysocki (5):
      ACPI: x86: cmos_rtc: Clean up address space handler driver
      ACPI: x86: cmos_rtc: Improve coordination with ACPI TAD driver
      platform/chrome: chromeos_tbmc: Drop wakeup source on remove
      platform/surface: surfacepro3_button: Drop wakeup source on remove
      platform/x86: panasonic-laptop: Fix OPTD notifier registration and cleanup

Rafał Miłecki (1):
      ARM: dts: mediatek: mt7623: fix efuse fallback compatible

Randy Dunlap (1):
      tty: hvc_iucv: fix off-by-one in number of supported devices

Raphael Zimmer (4):
      libceph: Fix potential out-of-bounds access in osdmap_decode()
      libceph: Fix potential null-ptr-deref in decode_choose_args()
      libceph: Fix potential out-of-bounds access in crush_decode()
      libceph: handle rbtree insertion error in decode_choose_args()

René Rebe (1):
      PCMCIA: Fix garbled log messages for KERN_CONT

Ricardo B. Marlière (3):
      ktest: Avoid undef warning when WARNINGS_FILE is unset
      ktest: Honor empty per-test option overrides
      ktest: Run POST_KTEST hooks on failure and cancellation

Richard Cheng (1):
      PCI/NPEM: Set LED_HW_PLUGGABLE for hotplug-capable ports

Richard Clark (1):
      hrtimers: Update the return type of enqueue_hrtimer()

Richard Fitzgerald (2):
      soundwire: cadence: Clear message complete before signaling waiting thread
      ALSA: hda: cs35l56: Fix uninitialized value in cs35l56_hda_read_acpi()

Richard Genoud (1):
      mtd: rawnand: sunxi: fix sunxi_nfc_hw_ecc_read_extra_oob

Richard Zhu (1):
      PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()

Rob Clark (2):
      drm/msm/a6xx: Fix HLSQ register dumping
      drm/msm/shrinker: Fix can_block() logic

Rory Little (1):
      wifi: mt76: mt7921: Place upper limit on station AID

Ryder Lee (2):
      wifi: mt76: mt7615: fix use_cts_prot support
      wifi: mt76: mt7915: fix use_cts_prot support

Ryo Takakura (1):
      net: bcmgenet: Initialize u64 stats seq counter

Samiullah Khawaja (2):
      page_pool: Set `dma_sync` to false for devmem memory provider
      PCI: Initialize temporary device in new_id_store()

Sander Vanheule (2):
      ASoC: sti: Return errors from regmap_field_alloc()
      ASoC: sti: use managed regmap_field allocations

Sangyun Kim (1):
      pwm: atmel-tcb: Cache clock rates and mark chip as atomic

Sean Wang (1):
      wifi: mt76: mt7921: Reset ampdu_state state in case of failure in mt76_connac2_tx_check_aggr()

Sebastian Andrzej Siewior (1):
      futex: Prevent lockup in requeue-PI during signal/ timeout wakeup

Sebastian Brzezinka (1):
      drm/i915: skip __i915_request_skip() for already signaled requests

Sebastian Ene (1):
      firmware: arm_ffa: Use the correct buffer size during RXTX_MAP

Sebastian Krzyszkowiak (1):
      clk: imx8mq: Correct the CSI PHY sels

Sebastian Reichel (1):
      drm/panel: simple: Correct G190EAN01 prepare timing

Sechang Lim (1):
      bpf: Fix RCU stall in bpf_fd_array_map_clear()

Sergio Correia (2):
      audit: fix incorrect inheritable capability in CAPSET records
      audit: enforce AUDIT_LOCKED for AUDIT_TRIM and AUDIT_MAKE_EQUIV

Shengjiu Wang (10):
      ASoC: fsl_micfil: Add access property for "VAD Detected"
      ASoC: fsl_micfil: Fix event generation in hwvad_put_enable()
      ASoC: fsl_micfil: Fix event generation in hwvad_put_init_mode()
      ASoC: fsl_micfil: Fix event generation in micfil_put_dc_remover_state()
      ASoC: fsl_micfil: Fix event generation in micfil_quality_set()
      ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_arc_mode_put()
      ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_mode_put()
      ASoC: fsl_easrc: Check the variable range in fsl_easrc_iec958_put_bits()
      ASoC: fsl_easrc: Fix value type in fsl_easrc_iec958_get_bits()
      ASoC: fsl_easrc: Change the type for iec958 channel status controls

Sherry Sun (1):
      arm64: dts: imx8mp-evk: Enable pull select bit for PCIe regulator GPIO (M.2 W_DISABLE1)

Shiji Yang (1):
      mtd: spi-nor: swp: check SR_TB flag when getting tb_mask

Shuicheng Lin (2):
      drm/xe: Fix error cleanup in xe_exec_queue_create_ioctl()
      drm/xe/gsc: Fix BO leak on error in query_compatibility_version()

Sourabh Jain (2):
      powerpc/crash: fix backup region offset update to elfcorehdr
      powerpc/crash: Update backup region offset in elfcorehdr on memory hotplug

Srinivas Kandagatla (1):
      ASoC: qcom: qdsp6: topology: check widget type before accessing data

Srinivasan Shanmugam (1):
      drm/amdgpu: Add default case in DVI mode validation

StanleyYP Wang (1):
      wifi: mt76: mt7996: fix struct mt7996_mcu_uni_event

Stefan Metzmacher (1):
      Bluetooth: SCO: check for codecs->num_codecs == 1 before assigning to sco_pi(sk)->codec

Stephen Hemminger (6):
      net/sched: netem: fix probability gaps in 4-state loss model
      net/sched: netem: fix queue limit check to include reordered packets
      net/sched: netem: only reseed PRNG when seed is explicitly provided
      net/sched: netem: validate slot configuration
      net/sched: netem: fix slot delay calculation overflow
      net/sched: netem: check for negative latency and jitter

Suman Kumar Chakraborty (1):
      crypto: qat - introduce fuse array

Sumit Gupta (1):
      soc/tegra: cbb: Set ERD on resume for err interrupt

Sun Jian (1):
      bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb

Sunil Khatri (3):
      drm/amdgpu: add amdgpu_device reference in ip block
      drm/amdgpu: update the handle ptr in dump_ip_state
      drm/amdgpu: update the handle ptr in early_init

Suravee Suthikulpanit (2):
      iommu/amd: Introduce helper function to update 256-bit DTE
      iommu/amd: Introduce helper function get_dte256()

T Pratham (1):
      crypto: sa2ul - Fix AEAD fallback algorithm names

Taegu Ha (1):
      ppp: require CAP_NET_ADMIN in target netns for unattached ioctls

Takahiro Kuwano (2):
      mtd: spi-nor: sfdp: introduce smpt_read_dummy fixup hook
      mtd: spi-nor: sfdp: introduce smpt_map_id fixup hook

Takashi Iwai (1):
      ALSA: usb-audio: Fix potential leak of pd at parsing UAC3 streams

Tejun Heo (1):
      sched_ext: Guard scx_dsq_move() against NULL kit->dsq after failed iter_new

Thomas Bogendoerfer (1):
      tty: serial: ip22zilog: Fix section mispatch warning

Thomas Gleixner (1):
      hrtimer: Reduce trace noise in hrtimer_start()

Thomas Huth (1):
      efi/capsule-loader: fix incorrect sizeof in phys array reallocation

Thomas Weißschuh (4):
      sparc/vdso: Always reject undefined references during linking
      sparc64: vdso: Link with -z noexecstack
      x86/um/vdso: Drop VDSO64-y from Makefile
      x86/um: fix vDSO installation

Thorsten Blum (2):
      crypto: atmel - Use unregister_{aeads,ahashes,skciphers}
      crypto: atmel-aes - guard unregister on error in atmel_aes_register_algs

Tim Michals (1):
      remoteproc: xlnx: Fix sram property parsing

Timur Kristóf (13):
      drm/amd/pm/ci: Use highest MCLK on CI when MCLK DPM is disabled
      drm/amd/pm/ci: Disable MCLK DPM on problematic CI ASICs
      drm/amd/pm/smu7: Fix SMU7 voltage dependency on display clock
      drm/amd/pm/ci: Fix powertune defaults for Hawaii 0x67B0
      drm/amd/pm/ci: Clear EnabledForActivity field for memory levels
      drm/amd/pm/ci: Fill DW8 fields from SMC
      drm/amd/pm/smu7: Add SCLK cap for quirky Hawaii board
      drm/amdgpu/uvd4.2: Don't initialize UVD 4.2 when DPM is disabled
      drm/amdgpu/gmc: Fix AMDGPU_GART_PLACEMENT_LOW to not overlap with VRAM
      drm/amdgpu/uvd3.1: Don't validate the firmware when already validated
      drm/amdgpu/gfx6: Support harvested SI chips with disabled TCCs (v2)
      drm/amd/display: Allow DCE link encoder without AUX registers
      drm/amd/display: Read EDID from VBIOS embedded panel info

Uday Shankar (2):
      net, treewide: define and use MAC_ADDR_STR_LEN
      netconsole: allow selection of egress interface via MAC address

Uwe Kleine-König (1):
      hwmon: Switch back to struct platform_driver::remove()

Val Packett (6):
      dt-bindings: clock: qcom,gcc-sc8180x: Add missing GDSCs
      clk: qcom: gcc-sc8180x: Add missing GDSCs
      clk: qcom: gcc-sc8180x: Use retention for USB power domains
      clk: qcom: gcc-sc8180x: Use retention for PCIe power domains
      clk: qcom: dispcc-sm8250: Use shared ops on the mdss vsync clk
      clk: qcom: dispcc-sm8250: Enable parents for pixel clocks

Vasant Hegde (8):
      iommu/amd: Remove protection_domain.dev_cnt variable
      iommu/amd: xarray to track protection_domain->iommu list
      iommu/amd: Do not detach devices in domain free path
      iommu/amd: Reduce domain lock scope in attach device path
      iommu/amd: Rearrange attach device code
      iommu/amd: Convert dev_data lock from spinlock to mutex
      iommu/amd: Fix clone_alias() to use the original device's devid
      iommu/amd: Reorder attach device code

Viacheslav Dubeyko (2):
      ceph: fix a buffer leak in __ceph_setxattr()
      ceph: fix BUG_ON in __ceph_build_xattrs_blob() due to stale blob size

Vidya Sagar (7):
      PCI: tegra194: Fix polling delay for L2 state
      PCI: tegra194: Don't force the device into the D0 state before L2
      PCI: tegra194: Use devm_gpiod_get_optional() to parse "nvidia,refclk-select"
      PCI: tegra194: Disable direct speed change for Endpoint mode
      PCI: tegra194: Set LTR message request before PCIe link up in Endpoint mode
      PCI: tegra194: Allow system suspend when the Endpoint link is not up
      PCI: tegra194: Free up Endpoint resources during remove()

Ville Syrjälä (2):
      drm/i915: Relocate the SKL wm sanitation code
      drm/i915/wm: Verify the correct plane DDB entry

Vinicius Costa Gomes (1):
      net/sched: taprio: fix use-after-free in advance_sched() on schedule switch

Vladimir Zapolskiy (6):
      media: i2c: og01a1b: Fix V4L2 subdevice data initialization on probe
      arm64: dts: qcom: sm8550: Fix xo clock supply of platform SD host controller
      arm64: dts: qcom: sm8650: Fix xo clock supply of SD host controller
      arm64: dts: qcom: sm8450: Enable UHS-I SDR50 and SDR104 SD card modes
      arm64: dts: qcom: sm8550: Enable UHS-I SDR50 and SDR104 SD card modes
      arm64: dts: qcom: sm8650: Enable UHS-I SDR50 and SDR104 SD card modes

Waiman Long (1):
      selftest: memcg: skip memcg_sock test if address family not supported

Wang Wensheng (1):
      arm64: kexec: Remove duplicate allocation for trans_pgd

Weiming Shi (7):
      bpf: fix end-of-list detection in cgroup_storage_get_next_key()
      bpf: reject negative CO-RE accessor indices in bpf_core_parse_spec()
      openvswitch: cap upcall PID array size and pre-size vport replies
      slip: reject VJ receive packets on instances with no rstate array
      slip: bound decode() reads against the compressed packet length
      net/sched: taprio: fix NULL pointer dereference in class dump
      bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()

Wentao Guan (1):
      arm64/scs: Fix potential sign extension issue of advance_loc4

White Lewis (1):
      clk: qcom: dispcc-sc8280xp: remove CLK_SET_RATE_PARENT from byte_div_clk_src dividers

William A. Kennington III (1):
      net: mctp i2c: check length before marking flow active

William Bowling (1):
      net: skbuff: preserve shared-frag marker during coalescing

Wolfram Sang (5):
      mailbox: mailbox-test: free channels on probe error
      mailbox: add sanity check for channel array
      mailbox: mailbox-test: don't free the reused channel
      mailbox: mailbox-test: initialize struct earlier
      mailbox: mailbox-test: make data_ready a per-instance variable

Xiang Mei (1):
      netfilter: nfnetlink_osf: fix divide-by-zero in OSF_WSS_MODULO

Xianglai Li (1):
      LoongArch: KVM: Compile switch.S directly into the kernel

Xiao Ni (1):
      md/raid1: fix the comparing region of interval tree

Xin Long (3):
      sctp: fix missing encap_port propagation for GSO fragments
      netfilter: skip recording stale or retransmitted INIT
      sctp: discard stale INIT after handshake completion

Xu Yang (2):
      arm64: dts: imx8qm-mek: switch Type-C connector power-role to dual
      arm64: dts: imx8qxp-mek: switch Type-C connector power-role to dual

Yang Erkun (2):
      scsi: sg: Fix sysctl sg-big-buff register during sg_init()
      scsi: sg: Resolve soft lockup issue when opening /dev/sgX

Ye Bin (2):
      ext4: fix possible null-ptr-deref in mbt_kunit_exit()
      smb/client: fix possible infinite loop and oob read in symlink_data()

Yihan Ding (1):
      bpf: allow UTF-8 literals in bpf_bprintf_prepare()

Yingnan Zhang (1):
      ipvs: fix MTU check for GSO packets in tunnel mode

Yinjie Yao (13):
      drm/amdgpu/vcn: set no_user_fence for VCN v2.0 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v2.5 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v3.0 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0.3 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0.5 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v5.0.0 enc ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v2.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v3.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0.3 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0.5 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.0 ring

Yong-Xuan Wang (1):
      irqchip/riscv-imsic: Clear interrupt move state during CPU offlining

Yongpeng Yang (2):
      f2fs: protect extension_list reading with sb_lock in f2fs_sbi_show()
      f2fs: fix incorrect file address mapping when inline inode is unwritten

Yu Kuai (1):
      md: wake raid456 reshape waiters before suspend

Yu-Chun Lin (2):
      pinctrl: realtek: Fix function signature for config argument
      pinctrl: abx500: Fix type of 'argument' variable

Yuanjie Yang (1):
      drm/msm/dpu: fix mismatch between power and frequency

Yuho Choi (2):
      fbdev: offb: fix PCI device reference leak on probe failure
      drm/sysfb: ofdrm: fix PCI device reference leaks

Zak Kemble (1):
      net: bcmgenet: switch to use 64bit statistics

Zhan Jun (1):
      net: usb: rtl8150: fix use-after-free in rtl8150_start_xmit()

Zhaoyang Huang (1):
      arm64: Reserve an extra page for early kernel mapping

ZhengYuan Huang (3):
      ocfs2: fix listxattr handling when the buffer is full
      ocfs2: validate bg_bits during freefrag scan
      ocfs2: validate group add input before caching

Zhenzhong Duan (1):
      iommufd: Fix return value of iommufd_fault_fops_write()

Zicheng Qu (1):
      sched/fair: Clear rel_deadline when initializing forked entities

Zilin Guan (1):
      wifi: mwifiex: Fix memory leak in mwifiex_11n_aggregate_pkt()

Zoran Ilievski (1):
      net: atlantic: preserve PCI wake-from-D3 on shutdown when WOL enabled

cuitao (1):
      cgroup/rdma: fix integer overflow in rdmacg_try_charge()

haoyu.lu (1):
      bpf,arc_jit: Fix missing newline in pr_err messages

wangdicheng (2):
      ALSA: hda/conexant: Renaming the codec with device ID 0x1f86 and 0x1f87
      ALSA: hda/conexant: Fix missing error check for jack detection


