Return-Path: <stable+bounces-219868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NiIMQPUoGmrnAQAu9opvQ
	(envelope-from <stable+bounces-219868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:15:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 064F71B0D13
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 454DE3024193
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 23:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812433A4F25;
	Thu, 26 Feb 2026 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pLpOZXKP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6C44DB98;
	Thu, 26 Feb 2026 23:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772147702; cv=none; b=dj6gVpcHmRmwdYwW/dT+KdTOXWpXSCLMvAUhB5DlUnAIaIxbGAIYHUowSETwe0U1TTRfZ9O/Uny4BuUzj0DU/YTWcoIPooAxX1yaIYxvphzX/brwQh7XDR1+4QBItdYEEGkW2i8eLg/5ruv/Ota7Ix2WsbyL31CvS5pIyEbc8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772147702; c=relaxed/simple;
	bh=Z4ZE/Hm6wi9KLjG5aCSwDB4xWTLhN15ZYLB44Ajc39M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HD86n2trSxw+M+JZBLtsG1NUJHFd5KdDWO6N1bxblFsuWyrvwPBsOhwa8555zAgV9zYzPhDHikFnOCCc8//c+nrFMvnTR08BZADDr9qRlq71cWm8vgMCI4ESTD48prxzLHA4JpMv1gQJwPMB4JkgTDh76U98yrhZyGzFdqXiyj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pLpOZXKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9986FC116C6;
	Thu, 26 Feb 2026 23:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772147701;
	bh=Z4ZE/Hm6wi9KLjG5aCSwDB4xWTLhN15ZYLB44Ajc39M=;
	h=From:To:Cc:Subject:Date:From;
	b=pLpOZXKP5AF7mLCvQfWvgX6IN9mjMDytzAuL6UVPwIuU9yuS/hdF2MFJW/CI15GIe
	 nVroWUatlJTsE356ojtmvqFUoLd4d8Zmi3t9DN7IV4T2+tCj3at3k7jAbUJnga5+hy
	 2/MgRO5ny11q/otCXFGGuo9sDm9MBFFoxqYr0PxI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.14
Date: Thu, 26 Feb 2026 15:14:51 -0800
Message-ID: <2026022652-lyricist-washtub-eeb4@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219868-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 064F71B0D13
X-Rspamd-Action: no action

I'm announcing the release of the 6.18.14 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/PCI/endpoint/pci-vntb-howto.rst                    |   14 
 Documentation/devicetree/bindings/media/qcom,qcs8300-camss.yaml  |   13 
 Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml          |   28 
 Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml  |    6 
 Documentation/devicetree/bindings/sound/asahi-kasei,ak5558.yaml  |    4 
 Documentation/driver-api/dpll.rst                                |   36 
 Documentation/netlink/specs/dpll.yaml                            |    7 
 Documentation/networking/ip-sysctl.rst                           |    7 
 Documentation/trace/events-pci.rst                               |   74 
 Documentation/trace/index.rst                                    |    1 
 Makefile                                                         |   13 
 arch/arm/boot/dts/allwinner/sun5i-a13-utoo-p66.dts               |    1 
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi                           |    1 
 arch/arm/kernel/vdso.c                                           |    1 
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi                      |    7 
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                       |    6 
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi                |    9 
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                      |    9 
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                       |    9 
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi                        |   13 
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314.dts |    2 
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts      |    2 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts      |    2 
 arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi         |    2 
 arch/arm64/boot/dts/qcom/qcm2290.dtsi                            |    8 
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts                         |    2 
 arch/arm64/boot/dts/qcom/sdm630.dtsi                             |    4 
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts                       |    8 
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi              |    3 
 arch/arm64/boot/dts/qcom/sm6115.dtsi                             |    8 
 arch/arm64/boot/dts/qcom/sm6150.dtsi                             |    1 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                           |    8 
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts               |    1 
 arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi            |    4 
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi         |   36 
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi                       |   58 
 arch/arm64/mm/gcs.c                                              |    4 
 arch/arm64/net/bpf_jit_comp.c                                    |    2 
 arch/loongarch/net/bpf_jit.c                                     |    2 
 arch/mips/Kconfig                                                |    1 
 arch/mips/kernel/relocate.c                                      |   13 
 arch/powerpc/include/asm/eeh.h                                   |    2 
 arch/powerpc/include/asm/kup.h                                   |    2 
 arch/powerpc/include/asm/uaccess.h                               |    4 
 arch/powerpc/kernel/eeh_driver.c                                 |   11 
 arch/powerpc/kernel/eeh_pe.c                                     |   74 
 arch/powerpc/net/bpf_jit_comp.c                                  |    2 
 arch/s390/Kconfig                                                |    3 
 arch/x86/events/core.c                                           |    4 
 arch/x86/hyperv/hv_vtl.c                                         |    8 
 arch/x86/include/asm/ftrace.h                                    |    2 
 arch/x86/kernel/cpu/amd.c                                        |   30 
 arch/x86/kernel/ftrace_64.S                                      |    5 
 arch/x86/xen/enlighten.c                                         |    2 
 drivers/accel/amdxdna/aie2_ctx.c                                 |    8 
 drivers/accel/amdxdna/amdxdna_mailbox.c                          |   27 
 drivers/accel/amdxdna/amdxdna_pci_drv.c                          |    5 
 drivers/accel/amdxdna/amdxdna_pci_drv.h                          |    1 
 drivers/accel/amdxdna/amdxdna_ubuf.c                             |   10 
 drivers/acpi/acpica/evregion.c                                   |    4 
 drivers/acpi/cppc_acpi.c                                         |    4 
 drivers/acpi/power.c                                             |   13 
 drivers/acpi/processor_driver.c                                  |    2 
 drivers/ata/libata-core.c                                        |    5 
 drivers/ata/libata-eh.c                                          |   28 
 drivers/ata/libata-scsi.c                                        |  174 
 drivers/ata/libata.h                                             |    2 
 drivers/ata/pata_ftide010.c                                      |    6 
 drivers/auxdisplay/arm-charlcd.c                                 |    2 
 drivers/base/power/wakeirq.c                                     |    9 
 drivers/base/power/wakeup.c                                      |    4 
 drivers/block/drbd/drbd_main.c                                   |    3 
 drivers/block/drbd/drbd_nl.c                                     |   20 
 drivers/block/rnbd/rnbd-srv.c                                    |   33 
 drivers/block/ublk_drv.c                                         |   10 
 drivers/bluetooth/btintel_pcie.c                                 |    9 
 drivers/char/hw_random/airoha-trng.c                             |    1 
 drivers/char/hw_random/core.c                                    |  173 
 drivers/char/misc_minor_kunit.c                                  |    2 
 drivers/char/tpm/st33zp24/st33zp24.c                             |    6 
 drivers/char/tpm/tpm_i2c_infineon.c                              |    6 
 drivers/clk/actions/owl-composite.c                              |   11 
 drivers/clk/actions/owl-divider.c                                |   17 
 drivers/clk/actions/owl-divider.h                                |    5 
 drivers/clk/clk-bm1880.c                                         |    5 
 drivers/clk/clk-loongson1.c                                      |    5 
 drivers/clk/clk-milbeaut.c                                       |    5 
 drivers/clk/clk-versaclock3.c                                    |    7 
 drivers/clk/hisilicon/clkdivider-hi6220.c                        |    6 
 drivers/clk/mediatek/clk-mt7981-eth.c                            |    6 
 drivers/clk/mediatek/clk-mt8196-mfg.c                            |   13 
 drivers/clk/mediatek/clk-mt8516.c                                |    2 
 drivers/clk/mediatek/clk-mtk.c                                   |   12 
 drivers/clk/mediatek/clk-pll.c                                   |    3 
 drivers/clk/mediatek/clk-pll.h                                   |    1 
 drivers/clk/meson/g12a.c                                         |   17 
 drivers/clk/meson/gxbb.c                                         |   17 
 drivers/clk/microchip/clk-core.c                                 |   10 
 drivers/clk/nuvoton/clk-ma35d1-divider.c                         |    7 
 drivers/clk/nxp/clk-lpc32xx.c                                    |    6 
 drivers/clk/qcom/clk-alpha-pll.c                                 |   21 
 drivers/clk/qcom/clk-rcg2.c                                      |    7 
 drivers/clk/qcom/clk-regmap-divider.c                            |   16 
 drivers/clk/qcom/common.c                                        |    2 
 drivers/clk/qcom/dispcc-sdm845.c                                 |    4 
 drivers/clk/qcom/dispcc-sm7150.c                                 |    2 
 drivers/clk/qcom/gcc-glymur.c                                    |    4 
 drivers/clk/qcom/gcc-ipq5018.c                                   |    1 
 drivers/clk/qcom/gcc-milos.c                                     |    6 
 drivers/clk/qcom/gcc-msm8917.c                                   |    1 
 drivers/clk/qcom/gcc-msm8953.c                                   |    1 
 drivers/clk/qcom/gcc-qdu1000.c                                   |    4 
 drivers/clk/qcom/gcc-sdx75.c                                     |    4 
 drivers/clk/qcom/gcc-sm4450.c                                    |    6 
 drivers/clk/qcom/gcc-sm8450.c                                    |    4 
 drivers/clk/qcom/gcc-sm8550.c                                    |    4 
 drivers/clk/qcom/gcc-sm8650.c                                    |    4 
 drivers/clk/qcom/gcc-sm8750.c                                    |    4 
 drivers/clk/qcom/gcc-x1e80100.c                                  |    4 
 drivers/clk/rockchip/clk.c                                       |    2 
 drivers/clk/sophgo/clk-sg2042-clkgen.c                           |   15 
 drivers/clk/spacemit/Makefile                                    |    9 
 drivers/clk/spacemit/ccu-k1.c                                    |    1 
 drivers/clk/spacemit/ccu_common.c                                |    6 
 drivers/clk/spacemit/ccu_ddn.c                                   |    1 
 drivers/clk/spacemit/ccu_mix.c                                   |    9 
 drivers/clk/spacemit/ccu_pll.c                                   |    1 
 drivers/clk/sprd/div.c                                           |    6 
 drivers/clk/stm32/clk-stm32-core.c                               |   42 
 drivers/clk/thead/clk-th1520-ap.c                                |   34 
 drivers/clk/x86/clk-cgu.c                                        |    6 
 drivers/clk/zynqmp/divider.c                                     |   10 
 drivers/clk/zynqmp/pll.c                                         |    5 
 drivers/cpufreq/intel_pstate.c                                   |    2 
 drivers/cpufreq/scmi-cpufreq.c                                   |    1 
 drivers/cpuidle/cpuidle.c                                        |   10 
 drivers/cpuidle/governors/menu.c                                 |   22 
 drivers/crypto/caam/caamalg_qi2.c                                |   27 
 drivers/crypto/caam/caamalg_qi2.h                                |    2 
 drivers/crypto/cavium/cpt/cptvf_main.c                           |    3 
 drivers/crypto/ccp/ccp-ops.c                                     |    2 
 drivers/crypto/ccp/psp-dev.c                                     |   11 
 drivers/crypto/ccp/sev-dev.c                                     |   59 
 drivers/crypto/ccp/sp-dev.c                                      |   12 
 drivers/crypto/ccp/sp-dev.h                                      |    3 
 drivers/crypto/ccp/sp-pci.c                                      |   16 
 drivers/crypto/ccp/tee-dev.c                                     |   56 
 drivers/crypto/ccp/tee-dev.h                                     |    1 
 drivers/crypto/hisilicon/Kconfig                                 |    1 
 drivers/crypto/hisilicon/hpre/hpre.h                             |    5 
 drivers/crypto/hisilicon/hpre/hpre_crypto.c                      |  416 -
 drivers/crypto/hisilicon/hpre/hpre_main.c                        |    2 
 drivers/crypto/hisilicon/qm.c                                    |  112 
 drivers/crypto/hisilicon/sec2/sec.h                              |    7 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                       |  159 
 drivers/crypto/hisilicon/sec2/sec_main.c                         |   21 
 drivers/crypto/hisilicon/sgl.c                                   |    2 
 drivers/crypto/hisilicon/trng/trng.c                             |  121 
 drivers/crypto/hisilicon/zip/zip.h                               |    2 
 drivers/crypto/hisilicon/zip/zip_crypto.c                        |  133 
 drivers/crypto/hisilicon/zip/zip_main.c                          |    4 
 drivers/crypto/inside-secure/eip93/eip93-main.c                  |   94 
 drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_proto.c          |   10 
 drivers/crypto/marvell/octeontx/otx_cptvf_main.c                 |    3 
 drivers/crypto/starfive/jh7110-aes.c                             |    9 
 drivers/cxl/core/edac.c                                          |   64 
 drivers/cxl/core/hdm.c                                           |    3 
 drivers/cxl/core/memdev.c                                        |    1 
 drivers/cxl/core/port.c                                          |    8 
 drivers/cxl/cxlmem.h                                             |    5 
 drivers/dma/dma-axi-dmac.c                                       |   11 
 drivers/dma/fsl-edma-main.c                                      |    1 
 drivers/dma/mediatek/mtk-uart-apdma.c                            |   10 
 drivers/dpll/dpll_netlink.c                                      |   12 
 drivers/dpll/zl3073x/Makefile                                    |    3 
 drivers/dpll/zl3073x/core.c                                      |  225 
 drivers/dpll/zl3073x/core.h                                      |  167 
 drivers/dpll/zl3073x/dpll.c                                      |  436 -
 drivers/dpll/zl3073x/out.c                                       |  157 
 drivers/dpll/zl3073x/out.h                                       |   93 
 drivers/dpll/zl3073x/prop.c                                      |   19 
 drivers/dpll/zl3073x/ref.c                                       |  112 
 drivers/dpll/zl3073x/ref.h                                       |   66 
 drivers/dpll/zl3073x/synth.c                                     |   87 
 drivers/dpll/zl3073x/synth.h                                     |   72 
 drivers/edac/altera_edac.c                                       |   11 
 drivers/edac/i5000_edac.c                                        |    1 
 drivers/edac/i5400_edac.c                                        |    2 
 drivers/firmware/arm_ffa/driver.c                                |   33 
 drivers/firmware/efi/efi.c                                       |    8 
 drivers/gpio/gpio-amd-fch.c                                      |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                              |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                         |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                          |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                          |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                         |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                           |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                           |    6 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                           |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c                          |    6 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c                         |    8 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c                           |   14 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                           |   20 
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c                           |   14 
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c                           |    3 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c                            |   45 
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c                           |   20 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                         |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                |   36 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c          |    5 
 drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c |    8 
 drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c |    8 
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c   |    8 
 drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c |    8 
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c   |    8 
 drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c |    8 
 drivers/gpu/drm/drm_buddy.c                                      |    1 
 drivers/gpu/drm/exynos/exynos_drm_drv.h                          |    1 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                         |   36 
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h                     |    4 
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h                   |    2 
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c                       |   38 
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h                       |    8 
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h                      |    3 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c                   |   71 
 drivers/gpu/drm/i915/display/intel_acpi.c                        |    1 
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c                            |    5 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h           |   14 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                      |   18 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c             |    7 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c                      |   49 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h                      |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c                      |   35 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c                       |    7 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h                      |    7 
 drivers/gpu/drm/msm/disp/mdp_format.c                            |    8 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                                 |   24 
 drivers/gpu/drm/msm/dp/dp_display.c                              |    4 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c                       |    7 
 drivers/gpu/drm/msm/msm_mdss.c                                   |    2 
 drivers/gpu/drm/panel/panel-lg-sw43408.c                         |    4 
 drivers/gpu/drm/panthor/panthor_gpu.c                            |   21 
 drivers/gpu/drm/panthor/panthor_mmu.c                            |    4 
 drivers/gpu/drm/panthor/panthor_sched.c                          |  167 
 drivers/gpu/drm/panthor/panthor_sched.h                          |    1 
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c                   |    7 
 drivers/gpu/drm/xe/xe_bo.c                                       |    2 
 drivers/gpu/drm/xe/xe_configfs.h                                 |   12 
 drivers/gpu/drm/xe/xe_device.c                                   |    1 
 drivers/gpu/drm/xe/xe_guc_pc.c                                   |   34 
 drivers/gpu/drm/xe/xe_mmio.c                                     |   10 
 drivers/gpu/drm/xe/xe_module.h                                   |    2 
 drivers/gpu/drm/xe/xe_wa.c                                       |   18 
 drivers/hid/hid-playstation.c                                    |    4 
 drivers/hid/intel-ish-hid/ishtp/bus.c                            |    2 
 drivers/hv/mshv_eventfd.c                                        |    5 
 drivers/hv/vmbus_drv.c                                           |   66 
 drivers/hwmon/ibmpex.c                                           |    9 
 drivers/hwmon/pmbus/mpq8785.c                                    |   28 
 drivers/hwspinlock/omap_hwspinlock.c                             |    4 
 drivers/hwtracing/coresight/coresight-etm3x-core.c               |   12 
 drivers/hwtracing/coresight/coresight-tmc-etr.c                  |   13 
 drivers/i3c/master.c                                             |    6 
 drivers/i3c/master/dw-i3c-master.c                               |    3 
 drivers/iio/accel/sca3000.c                                      |    6 
 drivers/iio/gyro/mpu3050-core.c                                  |    6 
 drivers/iio/pressure/mprls0025pa.c                               |   36 
 drivers/iio/pressure/mprls0025pa.h                               |    2 
 drivers/iio/pressure/mprls0025pa_spi.c                           |   19 
 drivers/iio/test/Kconfig                                         |    1 
 drivers/infiniband/core/cache.c                                  |    3 
 drivers/infiniband/core/iwcm.c                                   |   56 
 drivers/infiniband/core/iwcm.h                                   |    1 
 drivers/infiniband/core/rw.c                                     |   53 
 drivers/infiniband/core/user_mad.c                               |    8 
 drivers/infiniband/core/uverbs_cmd.c                             |    7 
 drivers/infiniband/hw/hns/hns_roce_ah.c                          |   23 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                       |   54 
 drivers/infiniband/hw/mlx5/main.c                                |  101 
 drivers/infiniband/hw/mlx5/mlx5_ib.h                             |    2 
 drivers/infiniband/hw/mlx5/std_types.c                           |    4 
 drivers/infiniband/sw/rxe/rxe_comp.c                             |    3 
 drivers/infiniband/sw/rxe/rxe_mr.c                               |  281 -
 drivers/infiniband/sw/rxe/rxe_req.c                              |    3 
 drivers/infiniband/sw/rxe/rxe_srq.c                              |    6 
 drivers/infiniband/sw/rxe/rxe_verbs.h                            |   10 
 drivers/infiniband/sw/siw/siw_qp_rx.c                            |    3 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                           |   33 
 drivers/interconnect/mediatek/icc-emi.c                          |    9 
 drivers/iommu/amd/amd_iommu.h                                    |    1 
 drivers/iommu/amd/init.c                                         |   12 
 drivers/iommu/amd/iommu.c                                        |    5 
 drivers/iommu/intel/iommu.c                                      |    4 
 drivers/iommu/intel/iommu.h                                      |   21 
 drivers/iommu/intel/pasid.c                                      |   18 
 drivers/iommu/intel/pasid.h                                      |   14 
 drivers/leds/leds-expresswire.c                                  |   24 
 drivers/leds/rgb/leds-qcom-lpg.c                                 |    8 
 drivers/mailbox/pcc.c                                            |  102 
 drivers/mcb/mcb-core.c                                           |    9 
 drivers/md/dm-zone.c                                             |   11 
 drivers/md/dm.c                                                  |    2 
 drivers/md/md-llbitmap.c                                         |    4 
 drivers/md/md.h                                                  |    4 
 drivers/md/raid1.c                                               |    1 
 drivers/md/raid10.c                                              |    2 
 drivers/md/raid5.c                                               |   10 
 drivers/media/i2c/ccs/ccs-core.c                                 |   16 
 drivers/media/pci/mgb4/mgb4_trigger.c                            |    2 
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c         |    4 
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c         |    4 
 drivers/media/usb/uvc/uvc_video.c                                |    3 
 drivers/mfd/Kconfig                                              |   11 
 drivers/mfd/arizona-core.c                                       |    2 
 drivers/mfd/simple-mfd-i2c.c                                     |    1 
 drivers/mtd/devices/mtd_intel_dg.c                               |    9 
 drivers/mtd/nand/raw/cadence-nand-controller.c                   |    2 
 drivers/mtd/parsers/ofpart_core.c                                |   16 
 drivers/mtd/parsers/tplink_safeloader.c                          |    1 
 drivers/net/bonding/bond_main.c                                  |   21 
 drivers/net/caif/caif_serial.c                                   |    5 
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c               |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                  |   11 
 drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c           |   21 
 drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c           |   64 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.h              |    2 
 drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h      |    1 
 drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h      |    1 
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c                |    8 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c        |    3 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c        |   39 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h        |    2 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c          |    8 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                  |   11 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c              |   41 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c             |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en.h                     |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c                 |   14 
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c         |   13 
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c         |   52 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                |   40 
 drivers/net/ethernet/mellanox/mlx5/core/wc.c                     |   14 
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c                  |    3 
 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c                   |    3 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c                   |   20 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h                   |    2 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c                      |   19 
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c                  |    3 
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c                      |    5 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c                     |   43 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h                     |    3 
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c               |    2 
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.h               |    2 
 drivers/net/ethernet/mscc/ocelot_net.c                           |   75 
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c              |    7 
 drivers/net/ethernet/renesas/rswitch_l2.c                        |   15 
 drivers/net/ethernet/stmicro/stmmac/common.h                     |    5 
 drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c          |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c                |    5 
 drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c              |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c             |    6 
 drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c              |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c          |    6 
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c                   |    4 
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c                  |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c              |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c                |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c                |    2 
 drivers/net/ethernet/stmicro/stmmac/hwif.c                       |   73 
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c                 |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c             |   68 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                |   63 
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c                |   14 
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c                 |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c            |    9 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c                 |    4 
 drivers/net/ethernet/sun/sunhme.c                                |    3 
 drivers/net/macvlan.c                                            |    5 
 drivers/net/mctp/mctp-i2c.c                                      |    9 
 drivers/net/ovpn/io.c                                            |   55 
 drivers/net/ovpn/socket.c                                        |   39 
 drivers/net/ovpn/tcp.c                                           |   23 
 drivers/net/ovpn/udp.c                                           |    1 
 drivers/net/usb/catc.c                                           |   37 
 drivers/net/wireless/ath/ath10k/sdio.c                           |    6 
 drivers/net/wireless/ath/ath11k/core.c                           |   27 
 drivers/net/wireless/ath/ath11k/core.h                           |    4 
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c              |    8 
 drivers/net/wireless/ath/ath12k/mac.c                            |    4 
 drivers/net/wireless/ath/ath12k/wow.c                            |   16 
 drivers/net/wireless/ath/ath9k/Kconfig                           |    2 
 drivers/net/wireless/realtek/rtw89/debug.c                       |    8 
 drivers/net/xen-netback/xenbus.c                                 |    5 
 drivers/nvdimm/nd_virtio.c                                       |    3 
 drivers/nvdimm/virtio_pmem.c                                     |    1 
 drivers/nvdimm/virtio_pmem.h                                     |    4 
 drivers/nvmem/Kconfig                                            |    2 
 drivers/of/unittest.c                                            |    6 
 drivers/opp/core.c                                               |    2 
 drivers/pci/controller/dwc/pcie-sophgo.c                         |   18 
 drivers/pci/controller/pcie-mediatek.c                           |    4 
 drivers/pci/controller/pcie-xilinx.c                             |    9 
 drivers/pci/p2pdma.c                                             |   10 
 drivers/pci/pci-acpi.c                                           |   59 
 drivers/pci/pci.c                                                |    5 
 drivers/pci/pci.h                                                |    3 
 drivers/pci/pcie/aer.c                                           |    3 
 drivers/pci/pcie/portdrv.c                                       |    6 
 drivers/pci/pcie/ptm.c                                           |    5 
 drivers/pci/probe.c                                              |   35 
 drivers/pci/quirks.c                                             |    5 
 drivers/pci/setup-bus.c                                          |  140 
 drivers/perf/arm_spe_pmu.c                                       |   18 
 drivers/phy/freescale/phy-fsl-imx8qm-hsio.c                      |    2 
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c                |    2 
 drivers/pinctrl/meson/pinctrl-amlogic-a4.c                       |   10 
 drivers/pinctrl/pinctrl-equilibrium.c                            |    1 
 drivers/pinctrl/pinctrl-k230.c                                   |    7 
 drivers/pinctrl/pinctrl-single.c                                 |    2 
 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c                  |    2 
 drivers/platform/chrome/cros_ec_lightbar.c                       |    2 
 drivers/platform/chrome/cros_typec_switch.c                      |    6 
 drivers/platform/x86/amd/pmf/core.c                              |   62 
 drivers/platform/x86/amd/pmf/pmf.h                               |   10 
 drivers/platform/x86/amd/pmf/tee-if.c                            |   12 
 drivers/platform/x86/hp/hp-wmi.c                                 |  179 
 drivers/platform/x86/intel/int0002_vgpio.c                       |    4 
 drivers/power/reset/nvmem-reboot-mode.c                          |   15 
 drivers/power/supply/ab8500_charger.c                            |   40 
 drivers/power/supply/act8945a_charger.c                          |   16 
 drivers/power/supply/bq256xx_charger.c                           |   12 
 drivers/power/supply/bq25980_charger.c                           |   12 
 drivers/power/supply/bq27xxx_battery.c                           |    6 
 drivers/power/supply/cpcap-battery.c                             |    8 
 drivers/power/supply/goldfish_battery.c                          |   12 
 drivers/power/supply/pm8916_bms_vm.c                             |   18 
 drivers/power/supply/pm8916_lbc.c                                |   18 
 drivers/power/supply/qcom_battmgr.c                              |    3 
 drivers/power/supply/rt9455_charger.c                            |   17 
 drivers/power/supply/sbs-battery.c                               |   36 
 drivers/power/supply/wm97xx_battery.c                            |   34 
 drivers/powercap/intel_rapl_tpmi.c                               |    2 
 drivers/pwm/pwm-tiehrpwm.c                                       |    6 
 drivers/regulator/core.c                                         |   55 
 drivers/remoteproc/imx_dsp_rproc.c                               |    8 
 drivers/reset/Kconfig                                            |    2 
 drivers/rtc/rtc-amlogic-a4.c                                     |    2 
 drivers/s390/cio/css.c                                           |    2 
 drivers/scsi/csiostor/csio_scsi.c                                |    3 
 drivers/scsi/elx/efct/efct_driver.c                              |    8 
 drivers/scsi/smartpqi/smartpqi_init.c                            |   13 
 drivers/soc/mediatek/mtk-svs.c                                   |    5 
 drivers/soc/qcom/cmd-db.c                                        |    7 
 drivers/soc/qcom/smem.c                                          |    4 
 drivers/soundwire/Kconfig                                        |    1 
 drivers/spi/spi-wpcm-fiu.c                                       |    2 
 drivers/staging/gpib/common/iblib.c                              |    5 
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c                        |   14 
 drivers/staging/greybus/light.c                                  |    8 
 drivers/thermal/intel/x86_pkg_temp_thermal.c                     |    3 
 drivers/thermal/thermal_of.c                                     |    4 
 drivers/tty/serial/Kconfig                                       |    8 
 drivers/ufs/host/Kconfig                                         |    1 
 drivers/ufs/host/ufs-mediatek.c                                  |   12 
 drivers/usb/cdns3/core.c                                         |    2 
 drivers/usb/gadget/udc/bdc/bdc_core.c                            |    4 
 drivers/usb/typec/tcpm/fusb302.c                                 |    3 
 drivers/usb/typec/ucsi/Kconfig                                   |    1 
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c                   |   24 
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h                   |    2 
 drivers/vfio/pci/vfio_pci_core.c                                 |   17 
 drivers/video/backlight/qcom-wled.c                              |   42 
 drivers/video/fbdev/au1200fb.c                                   |    6 
 drivers/video/of_display_timing.c                                |    6 
 drivers/watchdog/starfive-wdt.c                                  |    2 
 drivers/xen/balloon.c                                            |   19 
 drivers/xen/grant-dma-ops.c                                      |    3 
 drivers/xen/unpopulated-alloc.c                                  |    3 
 fs/btrfs/accessors.h                                             |    1 
 fs/btrfs/bio.c                                                   |  157 
 fs/btrfs/bio.h                                                   |   28 
 fs/btrfs/block-group.c                                           |   29 
 fs/btrfs/block-rsv.c                                             |    9 
 fs/btrfs/btrfs_inode.h                                           |    8 
 fs/btrfs/compression.c                                           |    6 
 fs/btrfs/compression.h                                           |    6 
 fs/btrfs/ctree.h                                                 |    2 
 fs/btrfs/defrag.c                                                |    1 
 fs/btrfs/dir-item.c                                              |    1 
 fs/btrfs/direct-io.c                                             |    6 
 fs/btrfs/disk-io.c                                               |    1 
 fs/btrfs/disk-io.h                                               |    3 
 fs/btrfs/extent-tree.c                                           |    1 
 fs/btrfs/extent_io.c                                             |   22 
 fs/btrfs/extent_io.h                                             |    1 
 fs/btrfs/extent_map.h                                            |    3 
 fs/btrfs/file-item.c                                             |   60 
 fs/btrfs/file-item.h                                             |    4 
 fs/btrfs/inode.c                                                 |    8 
 fs/btrfs/qgroup.c                                                |   15 
 fs/btrfs/scrub.c                                                 |   51 
 fs/btrfs/space-info.c                                            |   15 
 fs/btrfs/space-info.h                                            |    5 
 fs/btrfs/subpage.h                                               |    1 
 fs/btrfs/transaction.c                                           |   11 
 fs/btrfs/transaction.h                                           |    4 
 fs/btrfs/tree-log.c                                              |    1 
 fs/btrfs/tree-log.h                                              |    3 
 fs/btrfs/volumes.c                                               |  243 
 fs/btrfs/zoned.c                                                 |    4 
 fs/btrfs/zoned.h                                                 |    1 
 fs/erofs/fileio.c                                                |   22 
 fs/erofs/fscache.c                                               |    4 
 fs/erofs/zdata.c                                                 |   30 
 fs/ext4/ext4.h                                                   |   16 
 fs/ext4/extents.c                                                |   54 
 fs/ext4/fast_commit.c                                            |   51 
 fs/ext4/mballoc-test.c                                           |    2 
 fs/ext4/mballoc.c                                                |   73 
 fs/fat/namei_msdos.c                                             |    7 
 fs/fat/namei_vfat.c                                              |    7 
 fs/file_table.c                                                  |   10 
 fs/fs_struct.c                                                   |    1 
 fs/gfs2/bmap.c                                                   |   13 
 fs/gfs2/glock.c                                                  |   36 
 fs/gfs2/glock.h                                                  |    3 
 fs/gfs2/inode.c                                                  |   18 
 fs/gfs2/quota.c                                                  |    1 
 fs/hfsplus/bnode.c                                               |    2 
 fs/iomap/direct-io.c                                             |   10 
 fs/jfs/jfs_dtree.c                                               |    4 
 fs/netfs/write_retry.c                                           |    1 
 fs/nfs/dir.c                                                     |    4 
 fs/nfs/localio.c                                                 |   92 
 fs/nfs/pnfs.c                                                    |    3 
 fs/nfsd/nfs2acl.c                                                |    2 
 fs/nfsd/nfs4idmap.c                                              |   48 
 fs/nfsd/nfs4proc.c                                               |    2 
 fs/nfsd/nfs4xdr.c                                                |   16 
 fs/nfsd/nfsproc.c                                                |    2 
 fs/ntfs3/file.c                                                  |   10 
 fs/ntfs3/fslog.c                                                 |    3 
 fs/overlayfs/readdir.c                                           |    2 
 fs/pidfs.c                                                       |    2 
 fs/proc/array.c                                                  |    2 
 fs/pstore/ram_core.c                                             |   11 
 fs/quota/quota.c                                                 |    1 
 fs/smb/client/smb2file.c                                         |    2 
 fs/smb/client/smbdirect.c                                        |   19 
 fs/tests/exec_kunit.c                                            |    6 
 include/acpi/pcc.h                                               |   29 
 include/asm-generic/rqspinlock.h                                 |    2 
 include/drm/intel/intel_lb_mei_interface.h                       |    3 
 include/linux/audit.h                                            |    6 
 include/linux/audit_arch.h                                       |    7 
 include/linux/bpf.h                                              |    5 
 include/linux/bpf_mprog.h                                        |   10 
 include/linux/capability.h                                       |    6 
 include/linux/clk.h                                              |   48 
 include/linux/device_cgroup.h                                    |    2 
 include/linux/dpll.h                                             |    1 
 include/linux/filter.h                                           |   26 
 include/linux/ftrace.h                                           |    6 
 include/linux/hisi_acc_qm.h                                      |   13 
 include/linux/hw_random.h                                        |    2 
 include/linux/input/adp5589.h                                    |  180 
 include/linux/interrupt.h                                        |    2 
 include/linux/io_uring_types.h                                   |    7 
 include/linux/leds-expresswire.h                                 |    3 
 include/linux/libata.h                                           |    3 
 include/linux/mfd/wm8350/core.h                                  |    2 
 include/linux/mlx5/driver.h                                      |    4 
 include/linux/module.h                                           |    9 
 include/linux/mtd/spinand.h                                      |    2 
 include/linux/psp.h                                              |    1 
 include/linux/skmsg.h                                            |   70 
 include/linux/soc/qcom/ubwc.h                                    |    1 
 include/linux/stmmac.h                                           |   12 
 include/linux/sunrpc/xdrgen/_builtins.h                          |   20 
 include/linux/u64_stats_sync.h                                   |   10 
 include/net/inet_ecn.h                                           |   20 
 include/net/ipv6.h                                               |   11 
 include/net/netfilter/nf_conntrack_count.h                       |    1 
 include/net/netfilter/nf_queue.h                                 |    4 
 include/net/netfilter/nf_tables.h                                |    4 
 include/net/netns/ipv4.h                                         |    9 
 include/net/tcp.h                                                |   31 
 include/net/tcp_ecn.h                                            |   66 
 include/rdma/rw.h                                                |    2 
 include/sound/sdca_function.h                                    |    1 
 include/uapi/linux/dpll.h                                        |    1 
 include/uapi/linux/nfs.h                                         |    2 
 include/ufs/ufshcd.h                                             |    4 
 include/xen/xen.h                                                |    2 
 io_uring/cancel.h                                                |    6 
 io_uring/io_uring.c                                              |   14 
 io_uring/kbuf.c                                                  |    5 
 io_uring/msg_ring.c                                              |   12 
 io_uring/register.c                                              |    3 
 io_uring/rsrc.c                                                  |   27 
 io_uring/sync.c                                                  |    2 
 ipc/ipc_sysctl.c                                                 |    2 
 kernel/bpf/core.c                                                |    4 
 kernel/bpf/helpers.c                                             |    2 
 kernel/bpf/rqspinlock.c                                          |    7 
 kernel/bpf/syscall.c                                             |   19 
 kernel/bpf/verifier.c                                            |   66 
 kernel/kallsyms.c                                                |    9 
 kernel/module/kallsyms.c                                         |    9 
 kernel/rcu/tree.h                                                |    2 
 kernel/rcu/tree_plugin.h                                         |   15 
 kernel/sched/core.c                                              |    4 
 kernel/sched/deadline.c                                          |    3 
 kernel/sched/rt.c                                                |    5 
 kernel/time/hrtimer.c                                            |    2 
 kernel/time/sched_clock.c                                        |    2 
 kernel/trace/bpf_trace.c                                         |    6 
 kernel/trace/ftrace.c                                            |    5 
 kernel/trace/trace_events.c                                      |    5 
 kernel/trace/trace_events_hist.c                                 |    2 
 kernel/ucount.c                                                  |    2 
 kernel/workqueue.c                                               |   92 
 lib/kstrtox.c                                                    |    4 
 lib/objpool.c                                                    |    2 
 mm/slub.c                                                        |   20 
 net/atm/signaling.c                                              |   56 
 net/bridge/br_multicast.c                                        |   45 
 net/core/dev.c                                                   |    2 
 net/core/filter.c                                                |   22 
 net/core/skmsg.c                                                 |   30 
 net/ipv4/icmp.c                                                  |   32 
 net/ipv4/ping.c                                                  |   31 
 net/ipv4/tcp.c                                                   |    3 
 net/ipv4/tcp_bpf.c                                               |   25 
 net/ipv4/tcp_cong.c                                              |    5 
 net/ipv4/tcp_input.c                                             |    5 
 net/ipv4/tcp_minisocks.c                                         |    7 
 net/ipv4/udp_bpf.c                                               |   23 
 net/ipv6/af_inet6.c                                              |    2 
 net/ipv6/icmp.c                                                  |   13 
 net/ipv6/ip6_fib.c                                               |    2 
 net/mptcp/protocol.c                                             |   14 
 net/mptcp/protocol.h                                             |    5 
 net/netfilter/ipvs/ip_vs_xmit.c                                  |   46 
 net/netfilter/nf_conncount.c                                     |   54 
 net/netfilter/nf_conntrack_h323_main.c                           |   10 
 net/netfilter/nf_tables_api.c                                    |   34 
 net/netfilter/nfnetlink_queue.c                                  |  267 -
 net/netfilter/nft_compat.c                                       |   13 
 net/netfilter/nft_connlimit.c                                    |    7 
 net/netfilter/nft_counter.c                                      |    4 
 net/netfilter/nft_set_hash.c                                     |    9 
 net/netfilter/nft_set_rbtree.c                                   |  800 ++-
 net/nfc/hci/llc_shdlc.c                                          |    8 
 net/psp/Kconfig                                                  |    1 
 net/rds/send.c                                                   |    6 
 net/sunrpc/auth_gss/auth_gss.c                                   |    3 
 net/sunrpc/auth_gss/gss_rpc_xdr.c                                |   82 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                         |    8 
 net/unix/af_unix.c                                               |   11 
 net/wireless/core.c                                              |    4 
 net/wireless/scan.c                                              |    2 
 rust/kernel/task.rs                                              |   24 
 security/apparmor/apparmorfs.c                                   |    9 
 security/apparmor/file.c                                         |   15 
 security/apparmor/include/match.h                                |   12 
 security/apparmor/label.c                                        |   33 
 security/apparmor/lsm.c                                          |   33 
 security/apparmor/match.c                                        |   22 
 security/apparmor/net.c                                          |    6 
 security/apparmor/policy_unpack.c                                |    6 
 security/apparmor/resource.c                                     |    5 
 security/integrity/evm/evm_crypto.c                              |   14 
 security/smack/smackfs.c                                         |   79 
 sound/core/pcm.c                                                 |    4 
 sound/core/pcm_compat.c                                          |    9 
 sound/core/pcm_native.c                                          |   50 
 sound/core/vmaster.c                                             |   12 
 sound/hda/codecs/conexant.c                                      |   10 
 sound/hda/codecs/realtek/alc269.c                                |    2 
 sound/soc/codecs/aw88261.c                                       |    3 
 sound/soc/codecs/nau8821.c                                       |    5 
 sound/soc/codecs/nau8821.h                                       |    1 
 sound/soc/fsl/fsl_xcvr.c                                         |    3 
 sound/soc/rockchip/rockchip_i2s_tdm.c                            |   10 
 sound/soc/sdca/sdca_asoc.c                                       |   54 
 sound/soc/sdca/sdca_functions.c                                  |   62 
 sound/soc/sdca/sdca_regmap.c                                     |    9 
 sound/soc/tegra/tegra210_ahub.c                                  |   57 
 sound/soc/tegra/tegra210_ahub.h                                  |   30 
 tools/bpf/bpftool/net.c                                          |    5 
 tools/lib/bpf/btf_dump.c                                         |    9 
 tools/lib/bpf/linker.c                                           |    2 
 tools/lib/bpf/netlink.c                                          |    4 
 tools/net/sunrpc/xdrgen/generators/__init__.py                   |    3 
 tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2  |    4 
 tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2    |    6 
 tools/net/sunrpc/xdrgen/templates/C/source_top/client.j2         |    1 
 tools/objtool/Makefile                                           |    2 
 tools/power/x86/intel-speed-select/isst-config.c                 |    2 
 tools/spi/.gitignore                                             |    1 
 tools/testing/selftests/bpf/Makefile                             |    2 
 tools/testing/selftests/bpf/prog_tests/check_mtu.c               |   23 
 tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c          |   19 
 tools/testing/selftests/bpf/prog_tests/wq.c                      |    5 
 tools/testing/selftests/bpf/progs/test_check_mtu.c               |   12 
 tools/testing/selftests/bpf/test_xsk.c                           | 2422 +++++++++
 tools/testing/selftests/bpf/test_xsk.h                           |  297 +
 tools/testing/selftests/bpf/veristat.c                           |    2 
 tools/testing/selftests/bpf/xskxceiver.c                         | 2545 ----------
 tools/testing/selftests/bpf/xskxceiver.h                         |  156 
 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh        |    6 
 tools/testing/selftests/drivers/net/mlxsw/tc_restrictions.sh     |    4 
 tools/testing/selftests/memfd/memfd_test.c                       |  113 
 tools/testing/selftests/mm/cow.c                                 |   16 
 tools/testing/selftests/net/forwarding/tc_actions.sh             |    2 
 tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh        |   26 
 tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh   |    2 
 tools/testing/selftests/net/lib.sh                               |    2 
 tools/testing/selftests/resctrl/resctrlfs.c                      |   10 
 724 files changed, 11619 insertions(+), 7575 deletions(-)

Aadityarangan Shridhar Iyengar (1):
      PCI/PTM: Fix pcie_ptm_create_debugfs() memory leak

Aaradhana Sahu (2):
      wifi: ath12k: Fix index decrement when array_len is zero
      wifi: ath12k: clear stale link mapping of ahvif->links_map

Abel Vesa (2):
      arm64: dts: qcom: x1e80100: Fix USB combo PHYs SS1 and SS2 ref clocks
      dt-bindings: phy: qcom-edp: Add missing clock for X Elite

Abhash Kumar Jha (2):
      arm64: dts: ti: k3-j784s4-main.dtsi: Move c71_3 node to appropriate order
      arm64: dts: ti: k3-j784s4-j742s2-main-common.dtsi: Refactor watchdog instances for j784s4

Abhishek Bapat (1):
      quota: fix livelock between quotactl and freeze_super

Aboorva Devarajan (1):
      cpuidle: Skip governor when only one idle state is available

Adrian Hunter (1):
      i3c: master: Update hot-join flag only on success

Aleks Todorov (1):
      OPP: Return correct value in dev_pm_opp_get_level

Aleksander Jan Bajkowski (3):
      crypto: inside-secure/eip93 - fix kernel panic in driver detach
      hwrng: airoha - set rng quality to 900
      crypto: inside-secure/eip93 - unregister only available algorithm

Aleksei Oladko (2):
      selftests: forwarding: vxlan_bridge_1d: fix test failure with br_netfilter enabled
      selftests: forwarding: vxlan_bridge_1d_ipv6: fix test failure with br_netfilter enabled

Alex Deucher (4):
      drm/amdgpu: move reset debug disable handling
      drm/amdgpu/sdma5: enable queue resets unconditionally
      drm/amdgpu/sdma5.2: enable queue resets unconditionally
      drm/amdgpu/sdma6: enable queue resets unconditionally

Alexander Egorenkov (1):
      s390/kexec: Make KEXEC_SIG available when CONFIG_MODULES=n

Alexander Koskovich (1):
      power: reset: nvmem-reboot-mode: respect cell size for nvmem_cell_write

Alexander Stein (2):
      arm64: dts: tqma8mpql-mba8mpxl: Fix HDMI CEC pad control settings
      arm64: dts: tqma8mpql-mba8mp-ras314: Fix HDMI CEC pad control settings

Alexander Usyskin (1):
      mtd: intel-dg: Fix accessing regions before setting nregions

Alexandre Ferrieux (1):
      ASoC: codecs: aw88261: Fix erroneous bitmask logic in Awinic init

Alexey Simakov (1):
      ACPICA: Fix NULL pointer dereference in acpi_ev_address_space_dispatch()

Alice Ryhl (1):
      rust: task: restrict Task::group_leader() to current

Alistair Popple (1):
      PCI/P2PDMA: Reset page reference count when page mapping fails

Allison Henderson (1):
      net/rds: rds_sendmsg should not discard payload_len

Alok Tiwari (1):
      mtd: rawnand: cadence: Fix return type of CDMA send-and-wait helper

Alper Ak (3):
      tpm: tpm_i2c_infineon: Fix locality leak on get_burstcount() failure
      tpm: st33zp24: Fix missing cleanup on get_burstcount() error
      char: misc: Use IS_ERR() for filp_open() return value

Amery Hung (1):
      libbpf: Fix invalid write loop logic in bpf_linker__add_buf()

Amir Goldstein (1):
      fs: move initializing f_mode before file_ref_init()

Anders Grahn (1):
      netfilter: nft_counter: fix reset of counters on 32bit archs

Andre Carvalho (1):
      selftests: netconsole: remove log noise due to socat exit

Andreas Gruenbacher (2):
      gfs2: Retries missing in gfs2_{rename,exchange}
      gfs2: Fix slab-use-after-free in qd_put

Andrew Cooper (1):
      x86/cpu/amd: Correct the microcode table for Zenbleed

André Draszik (1):
      regulator: core: move supply check earlier in set_machine_constraints()

Andy Shevchenko (1):
      platform/chrome: cros_typec_switch: Don't touch struct fwnode_handle::dev

AngeloGioacchino Del Regno (2):
      arm64: dts: mediatek: mt8183-jacuzzi-pico6: Fix typo in pinmux node
      dmaengine: mediatek: uart-apdma: Fix above 4G addressing TX/RX

Anshumali Gaur (1):
      octeontx2-af: Fix PF driver crash with kexec kernel booting

Anthony Iliopoulos (1):
      nfsd: never defer requests during idmap lookup

Anthony Pighin (Nokia) (1):
      vfio/pci: Lock upstream bridge for vfio_pci_core_disable()

Anton Protopopov (2):
      bpf: Fix a potential use-after-free of BTF object
      bpf: Add a map/btf from a fd array more consistently

Antonio Borneo (1):
      coresight: etm3x: Fix cpulocked warning on cpuhp

Antonio Quartulli (1):
      ovpn: tcp - don't deref NULL sk_socket member after tcp_close()

Aristeu Rozanski (1):
      selftests/memfd: use IPC semaphore instead of SIGSTOP/SIGCONT

Arnd Bergmann (4):
      jfs: avoid -Wtautological-constant-out-of-range-compare warning
      scsi: ufs: host: mediatek: Require CONFIG_PM
      soundwire: intel_ace2x: add SND_HDA_CORE dependency
      net: psp: select CONFIG_SKB_EXTENSIONS

Baihan Li (4):
      drm/hisilicon/hibmc: fix dp probabilistical detect errors after HPD irq
      drm/hisilicon/hibmc: add dp mode valid check
      drm/hisilicon/hibmc: fix no showing problem with loading hibmc manually
      drm/hisilicon/hibmc: Adding reset colorbar cfg in dp init.

Baochen Qiang (1):
      wifi: ath12k: do WoW offloads only on primary link

Barnabás Czémán (4):
      clk: qcom: gcc-msm8953: Remove ALWAYS_ON flag from cpp_gdsc
      clk: qcom: gcc-msm8917: Remove ALWAYS_ON flag from cpp_gdsc
      backlight: qcom-wled: Support ovp values for PMI8994
      backlight: qcom-wled: Change PM8950 WLED configurations

Bartlomiej Kubik (1):
      fs/ntfs3: Initialize new folios before use

Baruch Siach (1):
      Documentation: PCI: endpoint: Fix ntb/vntb copy & paste errors

Bastien Curutchet (eBPF Foundation) (1):
      selftests/bpf: test_xsk: Split xskxceiver

Ben Dooks (2):
      audit: move the compat_xxx_class[] extern declarations to audit_arch.h
      fs: add <linux/init_task.h> for 'init_fs'

Billy Tsai (1):
      i3c: Move device name assignment after i3c_bus_init

Bobby Eshleman (3):
      eth: fbnic: set FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT on RDE_CTL0
      eth: fbnic: increase FBNIC_HDR_BYTES_MIN from 128 to 256 bytes
      eth: fbnic: set DMA_HINT_L4 for all flows

Boris Brezillon (7):
      drm/panthor: Recover from panthor_gpu_flush_caches() failures
      drm/panthor: Fix the full_tick check
      drm/panthor: Fix the group priority rotation logic
      drm/panthor: Fix immediate ticking on a disabled tick
      drm/panthor: Fix the logic that decides when to stop ticking
      drm/panthor: Make sure we resume the tick when new jobs are submitted
      drm/panthor: Fix panthor_gpu_coherency_set()

Boris Burkov (2):
      btrfs: fix block_group_tree dirty_list corruption
      btrfs: fix EEXIST abort due to non-consecutive gaps in chunk allocation

Breno Leitao (2):
      device_cgroup: remove branch hint after code refactor
      arm64/gcs: Fix error handling in arch_set_shadow_stack_status()

Brian Foster (1):
      ext4: fix dirtyclusters double decrement on fs shutdown

Brian Masney (20):
      drm/msm/dsi_phy_14nm: convert from divider_round_rate() to divider_determine_rate()
      clk: qcom: alpha-pll: convert from divider_round_rate() to divider_determine_rate()
      clk: microchip: core: remove duplicate determine_rate on pic32_sclk_ops
      clk: qcom: regmap-divider: convert from divider_ro_round_rate() to divider_ro_determine_rate()
      clk: qcom: regmap-divider: convert from divider_round_rate() to divider_determine_rate()
      clk: actions: owl-composite: convert from owl_divider_helper_round_rate() to divider_determine_rate()
      clk: actions: owl-divider: convert from divider_round_rate() to divider_determine_rate()
      clk: bm1880: convert from divider_round_rate() to divider_determine_rate()
      clk: hisilicon: clkdivider-hi6220: convert from divider_round_rate() to divider_determine_rate()
      clk: loongson1: convert from divider_round_rate() to divider_determine_rate()
      clk: milbeaut: convert from divider_round_rate() to divider_determine_rate()
      clk: nuvoton: ma35d1-divider: convert from divider_round_rate() to divider_determine_rate()
      clk: nxp: lpc32xx: convert from divider_round_rate() to divider_determine_rate()
      clk: sophgo: sg2042-clkgen: convert from divider_round_rate() to divider_determine_rate()
      clk: sprd: div: convert from divider_round_rate() to divider_determine_rate()
      clk: stm32: stm32-core: convert from divider_ro_round_rate() to divider_ro_determine_rate()
      clk: stm32: stm32-core: convert from divider_round_rate_parent() to divider_determine_rate()
      clk: versaclock3: convert from divider_round_rate() to divider_determine_rate()
      clk: x86: cgu: convert from divider_round_rate() to divider_determine_rate()
      clk: zynqmp: divider: convert from divider_round_rate() to divider_determine_rate()

Brian Norris (1):
      PCI/PM: Avoid redundant delays on D3hot->D3cold

Caleb Sander Mateos (2):
      io_uring: use release-acquire ordering for IORING_SETUP_R_DISABLED
      ublk: restore auto buf unregister refcount optimization

Carl Lee (1):
      hwmon: (pmbus/mpq8785) fix VOUT_MODE mismatch during identification

Casey Connolly (3):
      arm64: dts: qcom: sdm845-oneplus: Don't mark ts supply boot-on
      arm64: dts: qcom: sdm845-oneplus: Don't keep panel regulator always on
      arm64: dts: qcom: sdm845-oneplus: Mark l14a regulator as boot-on

Chaitanya Mishra (2):
      lib/kstrtox: fix kstrtobool() docstring to mention enabled/disabled
      staging: greybus: lights: avoid NULL deref

Charles Keepax (3):
      ASoC: SDCA: Remove outdated todo comment
      ASoC: SDCA: Force some SDCA Controls to be volatile
      ASoC: SDCA: Handle volatile controls correctly

Cheatham, Benjamin (1):
      cxl/core: Fix cxl_dport debugfs EINJ entries

Chen Jinghuang (1):
      sched/rt: Skip currently executing CPU in rto_next_cpu()

Chen-Yu Tsai (1):
      ARM: dts: allwinner: sun5i-a13-utoo-p66: delete "power-gpios" property

Chengchang Tang (2):
      RDMA/hns: Fix WQ_MEM_RECLAIM warning
      RDMA/hns: Notify ULP of remaining soft-WCs during reset

Chengfeng Ye (1):
      fbnic: close fw_log race between users and teardown

Chenghai Huang (7):
      crypto: hisilicon/zip - adjust the way to obtain the req in the callback function
      crypto: hisilicon/sec - move backlog management to qp and store sqe in qp for callback
      crypto: hisilicon/qm - enhance the configuration of req_type in queue attributes
      crypto: hisilicon/qm - centralize the sending locks of each module into qm
      crypto: hisilicon/zip - support fallback for zip
      crypto: hisilicon - consolidate qp creation and start in hisi_qm_alloc_qps_node
      crypto: hisilicon/sgl - fix inconsistent map/unmap direction issue

Chia-Yu Chang (3):
      tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
      tcp: disable RFC3168 fallback identifier for CC modules
      tcp: accecn: handle unexpected AccECN negotiation feedback

Chiara Meiohas (1):
      RDMA/mlx5: Fix UMR hang in LAG error state unload

Christoph Böhmwalder (1):
      drbd: always set BLK_FEAT_STABLE_WRITES

Christoph Hellwig (1):
      iomap: fix submission side handling of completion side errors

Christophe Leroy (1):
      powerpc/uaccess: Move barrier_nospec() out of allow_read_{from/write}_user()

Chuck Lever (6):
      xdrgen: Fix struct prefix for typedef types in program wrappers
      NFS: NFSERR_INVAL is not defined by NFSv2
      xdrgen: Initialize data pointer for zero-length items
      xdrgen: Remove inclusion of nlm4.h header
      RDMA/core: add rdma_rw_max_sge() helper for SQ sizing
      SUNRPC: auth_gss: fix memory leaks in XDR decoding error paths

Colin Ian King (1):
      scsi: csiostor: Fix dereference of null pointer rn

Cosmin Ratiu (2):
      net/mlx5e: Fix deadlocks between devlink and netdev instance locks
      net/mlx5e: Use unsigned for mlx5e_get_max_num_channels

Cristian Ciocaltea (3):
      ASoC: nau8821: Fixup nau8821_enable_jack_detect()
      drm/rockchip: dw_hdmi_qp: Fix RK3576 HPD interrupt handling
      phy: rockchip: samsung-hdptx: Pre-compute HDMI PLL config for 461.10125 MHz output

Damien Le Moal (4):
      ata: libata-scsi: refactor ata_scsi_translate()
      ata: libata-scsi: avoid Non-NCQ command starvation
      ata: libata-eh: correctly handle deferred qc timeouts
      ata: libata-core: fix cancellation of a port deferred qc work

Dan Carpenter (4):
      EDAC/i5000: Fix snprintf() size calculation in calculate_dimm_size()
      EDAC/i5400: Fix snprintf() limit calculation in calculate_dimm_size()
      gpib: Fix error code in ibonline()
      gpib: Fix error code in ni_usb_write_registers()

Dan Williams (1):
      cxl/mem: Fix devm_cxl_memdev_edac_release() confusion

Daniel Hodges (1):
      SUNRPC: fix gss_auth kref leak in gss_alloc_msg error path

Daniel Machon (2):
      net: sparx5/lan969x: fix DWRR cost max to match hardware register width
      net: sparx5/lan969x: fix PTP clock max_adj value

David Heidelberg (3):
      drm/panel: sw43408: Remove manual invocation of unprepare at remove
      media: ccs: Accommodate C-PHY into the calculation
      clk: qcom: dispcc-sm7150: Fix dispcc_mdss_pclk1_clk_src

Deepanshu Kartikey (1):
      gfs2: Fix use-after-free in iomap inline data write path

Detlev Casanova (1):
      ASoC: rockchip: i2s-tdm: Use param rate if not provided by set_sysclk

Dimitri Daskalakis (2):
      eth: fbnic: Add validation for MTU changes
      eth: fbnic: Advertise supported XDP features.

Dmitry Baryshkov (13):
      arm64: dts: qcom: sdm630: fix gpu_speed_bin size
      soc: qcom: ubwc: add missing include
      arm64: dts: qcom: qrb4210-rb2: Fix UART3 wakeup IRQ storm
      arm64: dts: qcom: sdm845-db845c: drop CS from SPIO0
      arm64: dts: qcom: sdm845-db845c: specify power for WiFi CH1
      drm/msm/dpu: fix WD timer handling on DPU 8.x
      drm/msm/disp: set num_planes to 1 for interleaved YUV formats
      drm/msm/dpu: fix CMD panels on DPU 1.x - 3.x
      drm/msm/a2xx: fix pixel shader start on A225
      drm/msm/mdss: correct HBB programmed on UBWC 5.x and 6.x devices
      drm/msm/dpu: offset HBB values written to DPU by -13
      drm/msm/dpu: program correct register for UBWC config on DPU 8.x+
      clk: qcom: gfx3d: add parent to parent request map

Dmitry Torokhov (1):
      gpio: amd-fch: ionly return allowed values from amd_fch_gpio_get()

Dmytro Maluka (1):
      iommu/vt-d: Flush cache for PASID table before using it

Duje Mihanović (1):
      leds: expresswire: Fix chip state breakage

Edward Adam Davis (1):
      fs/ntfs3: prevent infinite loops caused by the next valid being the same

Ella Ma (1):
      crypto: ccp - Fix a crash due to incorrect cleanup usage of kfree

Eric Dumazet (8):
      tcp: tcp_tx_timestamp() must look at the rtx queue
      inet: RAW sockets using IPPROTO_RAW MUST drop incoming ICMP
      ipv6: fix a race in ip6_sock_set_v6only()
      ping: annotate data-races in ping_lookup()
      macvlan: observe an RCU grace period in macvlan_common_newlink() error path
      icmp: prevent possible overflow in icmp_global_allow()
      inet: move icmp_global_{credit,stamp} to a separate cache line
      ipv6: icmp: remove obsolete code in icmpv6_xrlim_allow()

Eric Joyner (1):
      ionic: Rate limit unknown xcvr type messages

Eric Naim (1):
      ALSA: hda/realtek: Add quirk for Gigabyte G5 KF5 (2023)

Ethan Tidmore (1):
      x86/hyperv: Fix error pointer dereference

Etienne AUJAMES (1):
      IB/cache: update gid cache on client reregister event

Felix Gu (7):
      cpufreq: scmi: Fix device_node reference leak in scmi_cpu_domain_id()
      thermal/of: Fix reference leak in thermal_of_cm_lookup()
      fbdev: of_display_timing: Fix device node reference leak in of_get_display_timings()
      fbdev: au1200fb: Fix a memory leak in au1200fb_drv_probe()
      pinctrl: equilibrium: Fix device node reference leak in pinbank_init()
      pinctrl: meson: amlogic-a4: Fix device node reference leak in bank helpers
      spi: wpcm-fiu: Fix potential NULL pointer dereference in wpcm_fiu_probe()

Fernando Fernandez Mancera (3):
      netfilter: nf_conncount: make nf_conncount_gc_list() to disable BH
      netfilter: nf_conncount: increase the connection clean up limit to 64
      netfilter: nf_conncount: fix tracking of connections from localhost

Filipe Manana (5):
      btrfs: qgroup: return correct error when deleting qgroup relation item
      btrfs: remove fs_info argument from btrfs_try_granting_tickets()
      btrfs: reduce block group critical section in btrfs_free_reserved_bytes()
      btrfs: use the correct type to initialize block reserve for delayed refs
      btrfs: fix invalid leaf access in btrfs_quota_enable() if ref key not found

Florian Westphal (6):
      netfilter: nf_tables: reset table validation state on abort
      netfilter: nft_compat: add more restrictions on netlink attributes
      netfilter: nfnetlink_queue: do shared-unconfirmed check before segmentation
      netfilter: nft_set_hash: fix get operation on big endian
      netfilter: nft_set_rbtree: don't gc elements on insert
      netfilter: nf_conntrack_h323: don't pass uninitialised l3num value

Florian-Ewald Mueller (1):
      rnbd-srv: Fix server side setting of bi_size for special IOs

Francesco Lavra (1):
      spi: tools: Add include folder to .gitignore

Fredrik Markstrom (1):
      i3c: dw: Initialize spinlock to avoid upsetting lockdep

Gabriele Monaco (2):
      sched: Export hidden tracepoints to modules
      sched: Fix build for modules using set_tsk_need_resched()

Gal Pressman (1):
      net/mlx5: Fix misidentification of write combining CQE during poll loop

Gao Xiang (3):
      erofs: get rid of raw bi_end_io() usage
      erofs: handle end of filesystem properly for file-backed mounts
      erofs: fix inline data read failure for ztailpacking pclusters

Geert Uytterhoeven (2):
      arm64: dts: renesas: r9a09g047e57-smarc: Remove duplicate SW_LCD_EN
      clk: Move clk_{save,restore}_context() to COMMON_CLK section

George Moussalem (1):
      clk: qcom: gcc-ipq5018: flag sleep clock as critical

Georgia Garcia (1):
      apparmor: fix invalid deref of rawdata when export_binary is unset

Giovanni Cabiddu (1):
      crypto: qat - fix warning on adf_pfvf_pf_proto.c

Gokul Praveen (1):
      pwm: tiehrpwm: Enable pwmchip's parent device before setting configuration

Govindarajulu Varadarajan (1):
      ublk: Validate SQE128 flag before accessing the cmd

Greg Kroah-Hartman (2):
      Revert "mmc: rtsx_pci_sdmmc: increase power-on settling delay to 5ms"
      Linux 6.18.14

Guenter Roeck (1):
      Revert "hwmon: (ibmpex) fix use-after-free in high/low store"

Gui-Dong Han (1):
      PM: sleep: wakeirq: harden dev_pm_clear_wake_irq() against races

Guillaume Gonnet (1):
      bpf: Fix tcx/netkit detach permissions when prog fd isn't given

Hangbin Liu (1):
      bonding: alb: fix UAF in rlb_arp_recv during bond up/down

Haotian Zhang (10):
      clk: qcom: Return correct error code in qcom_cc_probe_by_index()
      soc: qcom: cmd-db: Use devm_memremap() to fix memory leak in cmd_db_dev_probe
      hwspinlock: omap: Handle devm_pm_runtime_enable() errors
      HID: playstation: Add missing check for input_ff_create_memless
      PCI: mediatek: Fix IRQ domain leak when MSI allocation fails
      PCI: xilinx: Fix INTx IRQ domain leak in error paths
      power: supply: bq27xxx: fix wrong errno when bus ops are unsupported
      clk: mediatek: Fix error handling in runtime PM setup
      mfd: arizona: Fix regulator resource leak on wm5102_clear_write_sequencer() failure
      leds: qcom-lpg: Check the return value of regmap_bulk_write()

Hariprasad Kelam (2):
      octeontx2-pf: Unregister devlink on probe failure
      octeontx2-af: Fix default entries mcam entry action

Harry Yoo (1):
      mm/slab: fix false lockdep warning in __kfree_rcu_sheaf()

Harshit Mogalapalli (1):
      iio: sca3000: Fix a resource leak in sca3000_probe()

Helge Deller (2):
      AppArmor: Allow apparmor to handle unaligned dfa tables
      apparmor: Fix & Optimize table creation from possibly unaligned memory

Honggang LI (1):
      RDMA/rtrs: server: remove dead code

Hou Tao (2):
      PCI/P2PDMA: Release per-CPU pgmap ref when vm_insert_page() fails
      PCI/P2PDMA: Fix p2pmem_alloc_mmap() warning condition

Huacai Chen (1):
      net: stmmac: dwmac-loongson: Set clk_csr_i to 100-150MHz

Huang Chenming (1):
      wifi: cfg80211: Fix use_for flag update on BSS refresh

Håkon Bugge (3):
      PCI: Do not attempt to set ExtTag for VFs
      PCI: Initialize RCB from pci_configure_device()
      PCI/ACPI: Restrict program_hpx_type2() to AER bits

Ido Schimmel (1):
      selftests: mlxsw: tc_restrictions: Fix test failure with new iproute2

Ilpo Järvinen (3):
      PCI: Rewrite bridge window head alignment function
      PCI: Stop over-estimating bridge window size
      PCI: Remove old_size limit from bridge window sizing

Inochi Amaoto (2):
      PCI: sophgo: Disable L0s and L1 on Sophgo 2044 PCIe Root Ports
      clk: spacemit: Respect Kconfig setting when building modules

Inseo An (1):
      netfilter: nf_tables: fix use-after-free in nf_tables_addchain()

Ivan Lipski (2):
      drm/amd/display: Clear HDMI HPD pending work only if it is enabled
      drm/amd/display: Add an hdmi_hpd_debounce_delay_ms module

Ivan Vecera (6):
      dpll: add phase-adjust-gran pin attribute
      dpll: zl3073x: Specify phase adjustment granularity for pins
      dpll: zl3073x: Store raw register values instead of parsed state
      dpll: zl3073x: Split ref, out, and synth logic from core
      dpll: zl3073x: Cache all output properties in zl3073x_out
      dpll: zl3073x: Fix output pin phase adjustment sign

Jacob Moroni (1):
      RDMA/iwcm: Fix workqueue list corruption by removing work_list

Jagadeesh Kona (8):
      clk: qcom: gcc-sm8450: Update the SDCC RCGs to use shared_floor_ops
      clk: qcom: gcc-sm8750: Update the SDCC RCGs to use shared_floor_ops
      clk: qcom: gcc-sm4450: Update the SDCC RCGs to use shared_floor_ops
      clk: qcom: gcc-sdx75: Update the SDCC RCGs to use shared_floor_ops
      clk: qcom: gcc-milos: Update the SDCC RCGs to use shared_floor_ops
      clk: qcom: gcc-x1e80100: Update the SDCC RCGs to use shared_floor_ops
      clk: qcom: gcc-qdu1000: Update the SDCC RCGs to use shared_floor_ops
      clk: qcom: gcc-glymur: Update the SDCC RCGs to use shared_floor_ops

Jakub Kicinski (2):
      bpftool: Fix truncated netlink dumps
      selftests: tc_actions: don't dump 2MB of \0 to stdout

Jan Kara (2):
      ext4: always allocate blocks only from groups inode can use
      ext4: use optimized mballoc scanning regardless of inode format

Jan Kiszka (1):
      Drivers: hv: vmbus: Use kthread for vmbus interrupts on PREEMPT_RT

Jani Nikula (1):
      mei: late_bind: fix struct intel_lb_component_ops kernel-doc

Jared Kangas (1):
      dmaengine: fsl-edma: don't explicitly disable clocks in .remove()

Jens Axboe (4):
      io_uring/eventfd: remove unused ctx->evfd_last_cq_tail member
      io_uring/sync: validate passed in offset
      io_uring/kbuf: fix memory leak if io_buffer_add_list fails
      io_uring/cancel: de-unionize file and user_data in struct io_cancel_data

Jeongjun Park (2):
      drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection_ioctl()
      drm/exynos: vidi: fix to avoid directly dereferencing user pointer

Jerome Brunet (7):
      arm64: dts: amlogic: s4: assign mmc b clock to 24MHz
      arm64: dts: amlogic: s4: fix mmc clock assignment
      arm64: dts: amlogic: c3: assign the MMC signal clocks
      arm64: dts: amlogic: axg: assign the MMC signal clocks
      arm64: dts: amlogic: gx: assign the MMC signal clocks
      arm64: dts: amlogic: g12: assign the MMC B and C signal clocks
      arm64: dts: amlogic: g12: assign the MMC A signal clock

Jian Shen (1):
      net: hns3: fix double free issue for tx spare buffer

Jian Zhang (1):
      net: mctp-i2c: fix duplicate reception of old data

Jianpeng Chang (1):
      crypto: caam - fix netdev memory leak in dpaa2_caam_probe

Jiasheng Jiang (3):
      RDMA/rxe: Fix double free in rxe_srq_from_init
      fs/ntfs3: Fix slab-out-of-bounds read in DeleteIndexEntryRoot
      btrfs: reset block group size class when it becomes empty

Jiayu Du (1):
      pinctrl: canaan: k230: Fix NULL pointer dereference when parsing devicetree

Jiayuan Chen (5):
      bpf, sockmap: Fix incorrect copied_seq calculation
      bpf, sockmap: Fix FIONREAD for sockmap
      net: atm: fix crash due to unvalidated vcc pointer in sigd_send()
      xfrm: fix ip_rt_bug race in icmp_route_lookup reverse path
      serial: caif: fix use-after-free in caif_serial ldisc_close()

Jie Zhang (1):
      net: stmmac: fix oops when split header is enabled

Jinliang Zheng (1):
      procfs: fix missing RCU protection when reading real_parent in do_task_stat()

Jiri Olsa (3):
      x86/fgraph: Fix return_to_handler regs.rsp value
      x86/fgraph,bpf: Switch kprobe_multi program stack unwind to hw_regs path
      selftests/bpf: Fix kprobe multi stacktrace_ips test

Joanne Koong (1):
      io_uring/rsrc: clean up buffer cloning arg validation

Joel Fernandes (1):
      sched/deadline: Clear the defer params

Johannes Thumshirn (1):
      btrfs: zoned: don't zone append to conventional zone

John Johansen (7):
      apparmor: fix NULL sock in aa_sock_file_perm
      apparmor: drop in_atomic flag in common_mmap, and common_file_perm
      apparmor: move check for aa_null file to cover all cases
      apparmor: fix rlimit for posix cpu timers
      apparmor: remove apply_modes_to_perms from label_match
      apparmor: make label_match return a consistent value
      apparmor: fix aa_label to return state from compount and component match

Jonathan Marek (1):
      arm64: dts: qcom: x1e: bus is 40-bits (fix 64GB models)

Jonathan McDowell (1):
      hwrng: core - Allow runtime disabling of the HW RNG

Jorge Ramirez-Ortiz (1):
      soc: qcom: smem: handle ENOMEM error during probe

Jose Javier Rodriguez Barbarin (1):
      mcb: fix incorrect sanity check

Josh Poimboeuf (1):
      kbuild: Add objtool to top-level clean target

Julian Anastasov (1):
      ipvs: do not keep dest_dst if dev is going down

Junhui Liu (1):
      reset: canaan: k230: drop OF dependency and enable by default

Junxian Huang (1):
      RDMA/hns: Fix RoCEv1 failure due to DSCP

Justin Chen (1):
      usb: bdc: fix sleep during atomic

Jörg Wedekind (1):
      PCI: Mark 3ware-9650SA Root Port Extended Tags as broken

KP Singh (2):
      bpf: Limit bpf program signature size
      bpf: Require frozen map for calculating map hash

Kai-Heng Feng (1):
      PCI: Validate window resource type in pbus_select_window_for_type()

Kaushlendra Kumar (1):
      drm/i915/acpi: free _DSM package when no connectors

Kery Qi (2):
      selftests/bpf: Fix resource leak in serial_test_wq on attach failure
      watchdog: starfive-wdt: Fix PM reference leak in probe error path

Ketil Johnsen (1):
      drm/panthor: Evict groups before VM termination

Kevin Brodsky (1):
      selftests/mm: fix usage of FORCE_READ() in cow tests

Kiryl Shutsemau (Meta) (1):
      efi: Fix reservation of unaccepted memory table

Konrad Dybcio (2):
      arm64: dts: qcom: agatti: Add CX_MEM/DBGC GPU regions
      arm64: dts: qcom: sm6115: Add CX_MEM/DBGC GPU regions

Konstantin Andreev (2):
      smack: /smack/doi must be > 0
      smack: /smack/doi: accept previously used values

Krishna Chomal (1):
      platform/x86: hp-wmi: fix platform profile values for Omen 16-wf1xxx

Krzysztof Kozlowski (2):
      clk: zynqmp: divider: Fix zynqmp_clk_divider_determine_rate kerneldoc
      clk: zynqmp: pll: Fix zynqmp_clk_divider_determine_rate kerneldoc

Kumar Kartikeya Dwivedi (1):
      rqspinlock: Fix TAS fallback lock entry creation

Kuniyuki Iwashima (2):
      af_unix: Fix memleak of newsk in unix_stream_connect().
      ipv6: Fix out-of-bound access in fib6_add_rt2node().

Kuppuswamy Sathyanarayanan (1):
      powercap: intel_rapl_tpmi: Remove FW_BUG from invalid version check

Lad Prabhakar (1):
      arm64: dts: renesas: rzt2h-n2h-evk-common: Use GPIO for SD0 write protect

Lai Jiangshan (3):
      workqueue: Factor out assign_rescuer_work()
      workqueue: Only assign rescuer work when really needed
      workqueue: Process rescuer work items one-by-one using a cursor

Larysa Zaremba (2):
      selftests/xsk: properly handle batch ending in the middle of a packet
      selftests/xsk: fix number of Tx frags in invalid packet

Leo Yan (1):
      perf: arm_spe: Properly set hw.state on failures

Lewis Mason (1):
      ALSA: hda/realtek: Add quirk for Samsung Galaxy Book3 Pro 360 (NP965QFG)

Li Chen (2):
      ext4: fast commit: make s_fc_lock reclaim-safe
      nvdimm: virtio_pmem: serialize flush requests

Li Nan (1):
      md/raid10: fix any_working flag handling in raid10_sync_request

Li RongQing (1):
      mshv: fix SRCU protection in irqfd resampler ack handler

Li Zhijian (2):
      RDMA/rxe: Fix iova-to-va conversion for MR page sizes != PAGE_SIZE
      RDMA/rxe: Fix race condition in QP timer handlers

Lianjie Wang (1):
      hwrng: core - use RCU and work_struct to fix race condition

Linus Walleij (1):
      ata: pata_ftide010: Fix some DMA timings

Lizhi Hou (5):
      accel/amdxdna: Fix race where send ring appears full due to delayed head update
      accel/amdxdna: Fix notifier_wq flushing warning
      accel/amdxdna: Hold mm structure across iommu_sva_unbind_device()
      accel/amdxdna: Stop job scheduling across aie2_release_resource()
      accel/amdxdna: Fix incorrect error code returned for failed chain command

Lu Baolu (2):
      iommu/vt-d: Clear Present bit before tearing down PASID entry
      iommu/vt-d: Clear Present bit before tearing down context entry

Luca Boccassi (1):
      pidfs: return -EREMOTE when PIDFD_GET_INFO is called on another ns

Luca Weiss (1):
      pinctrl: qcom: sm8250-lpass-lpi: Fix i2s2_data_groups definition

Luis Gerhorst (1):
      bpf: Fix verifier_bug_if to account for BPF_CALL

Mahadevan P (1):
      drm/msm/disp/dpu: add merge3d support for sc7280

Maher Sanalla (1):
      RDMA/mlx5: Fix ucaps init error flow

Malaya Kumar Rout (1):
      tools/power/x86/intel-speed-select: Fix file descriptor leak in isolate_cpus()

Mani Chandana Ballary Kuntumalla (1):
      drm/msm/dp: Update msm_dp_controller IDs for sa8775p

Mario Kleiner (1):
      drm/amd/display: Use same max plane scaling limits for all 64 bpp formats

Mario Limonciello (AMD) (5):
      drm/amd: Drop "amdgpu kernel modesetting enabled" message
      crypto: ccp - Declare PSP dead if PSP_CMD_TEE_RING_INIT fails
      crypto: ccp - Add an S4 restore flow
      crypto: ccp - Factor out ring destroy handling to a helper
      crypto: ccp - Send PSP_CMD_TEE_RING_DESTROY when PSP_CMD_TEE_RING_INIT fails

Martin Blumenstingl (2):
      clk: meson: gxbb: Limit the HDMI PLL OD to /4 on GXL/GXM SoCs
      clk: meson: g12a: Limit the HDMI PLL OD to /4

Martin KaFai Lau (1):
      selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set

Matt Johnston (1):
      mctp i2c: initialise event handler read bytes

Matt Roper (1):
      drm/xe/xe2_hpg: Fix handling of Wa_14019988906 & Wa_14019877138

Matthew Schwartz (1):
      mmc: rtsx_pci_sdmmc: increase power-on settling delay to 5ms

Miaoqian Lin (2):
      tracing: Properly process error handling in event_hist_trigger_parse()
      clk: rockchip: Fix error pointer check after rockchip_clk_register_gate_link()

Miaoqing Pan (1):
      wifi: ath11k: add usecase firmware handling based on device compatible

Michael Dege (1):
      net: renesas: rswitch: fix forwarding offload statemachine

Michal Wajdeczko (1):
      drm/xe/configfs: Fix 'parameter name omitted' errors

Michał Grzelak (1):
      drm/buddy: release free_trees array on buddy mm teardown

Mike Snitzer (3):
      NFS/localio: prevent direct reclaim recursion into NFS via nfs_writepages
      NFS/localio: use GFP_NOIO and non-memreclaim workqueue in nfs_local_commit
      NFS/localio: remove -EAGAIN handling in nfs_local_doio()

Mikulas Patocka (3):
      dm: fix unlocked test for dm_suspended_md
      dm: use READ_ONCE in dm_blk_report_zones
      dm: use bio_clone_blkg_association

Miquel Raynal (1):
      mtd: spinand: Fix kernel doc

Miri Korenblit (1):
      wifi: cfg80211: stop NAN and P2P in cfg80211_leave

Mohsin Bashir (1):
      eth: fbnic: Configure RDE settings for pause frame

Narayana Murty N (1):
      powerpc/eeh: fix recursive pci_lock_rescan_remove locking in EEH event handling

Nathan Chancellor (1):
      drm/msm/dp: Avoid division by zero in msm_dp_ctrl_config_msa()

Nicolas Cavallari (1):
      PCI: Add ACS quirk for Pericom PI7C9X2G404 switches [12d8:b404]

Nicolas Frattaroli (3):
      clk: mediatek: Add mfg_eb as parent to mt8196 mfgpll clocks
      interconnect: mediatek: Don't hijack parent device
      interconnect: mediatek: Aggregate bandwidth with saturating add

Nikolay Aleksandrov (1):
      net: bridge: mcast: always update mdb_n_entries for vlan contexts

Nuno Sá (2):
      dma: dma-axi-dmac: fix SW cyclic transfers
      dma: dma-axi-dmac: fix HW scatter-gather not looking at the queue

Olga Kornievskaia (1):
      pNFS: fix a missing wake up while waiting on NFS_LAYOUT_DRAIN

Ondrej Mosnacek (2):
      ipc: don't audit capability check in ipc_permissions()
      ucount: check for CAP_SYS_RESOURCE using ns_capable_noaudit()

Or Har-Toov (1):
      IB/mlx5: Fix port speed query for representors

Pablo Neira Ayuso (8):
      netfilter: nft_set_rbtree: fix bogus EEXIST with NLM_F_CREATE with null interval
      netfilter: nft_set_rbtree: check for partial overlaps in anonymous sets
      netfilter: nft_set_rbtree: translate rbtree to array for binary search
      netfilter: nft_set_rbtree: use binary search array in get command
      netfilter: nft_set_rbtree: remove seqcount_rwlock_t
      netfilter: nft_set_rbtree: validate element belonging to interval
      netfilter: nft_set_rbtree: validate open interval overlap
      net: remove WARN_ON_ONCE when accessing forward path array

Paolo Abeni (2):
      mptcp: do not account for OoO in mptcp_rcvbuf_grow()
      mptcp: fix receive space timestamp initialization

Paul Chaignon (1):
      bpf: Fix bpf_xdp_store_bytes proto for read-only arg

Paulo Alcantara (1):
      smb: client: fix potential UAF and double free in smb2_open_file()

Pavel Begunkov (1):
      io_uring: delay sqarray static branch disablement

Petr Hodina (1):
      clk: qcom: dispcc-sdm845: Enable parents for pixel clocks

Petr Mladek (3):
      kallsyms/bpf: rename __bpf_address_lookup() to bpf_address_lookup()
      module: add helper function for reading module_buildid()
      kallsyms/ftrace: set module buildid in ftrace_mod_address_lookup()

Petre Rodan (5):
      iio: pressure: mprls0025pa: fix spi_transfer struct initialisation
      iio: pressure: mprls0025pa: fix SPI CS delay violation
      iio: pressure: mprls0025pa: fix interrupt flag
      iio: pressure: mprls0025pa: fix scan_type struct
      iio: pressure: mprls0025pa: fix pressure calculation

Pin-yen Lin (1):
      selftests: netconsole: Increase port listening timeout

Puranjay Mohan (2):
      selftests/bpf: veristat: fix printing order in output_stats()
      bpf: Preserve id of register in sync_linked_regs()

Qi Tao (1):
      crypto: hisilicon/sec2 - support skcipher/aead fallback for hardware queue unavailable

Qing Wang (1):
      ovl: Fix uninit-value in ovl_fill_real

Qu Wenruo (4):
      btrfs: headers cleanup to remove unnecessary local includes
      btrfs: remove btrfs_bio::fs_info by extracting it from btrfs_bio::inode
      btrfs: make sure all btrfs_bio::end_io are called in task context
      btrfs: introduce btrfs_bio::async_csum

Raag Jadav (1):
      drm/xe/bo: Redirect faults to dummy page for wedged device

Rafael J. Wysocki (3):
      ACPI: processor: Update cpuidle driver check in __acpi_processor_start()
      cpuidle: governors: menu: Always check timers with tick stopped
      thermal: intel: x86_pkg_temp_thermal: Handle invalid temperature

Ralf Lici (3):
      ovpn: set sk_user_data before overriding callbacks
      ovpn: fix possible use-after-free in ovpn_net_xmit
      ovpn: fix VPN TX bytes counting

Randy Dunlap (6):
      iio: test: drop dangling symbol in gain-time-scale helpers
      usb: typec: ucsi: drop an unused Kconfig symbol
      serial: imx: change SERIAL_IMX_CONSOLE to bool
      serial: SH_SCI: improve "DMA support" prompt
      nvmem: an8855: drop an unused Kconfig symbol
      mips: LOONGSON32: drop a dangling Kconfig symbol

René Rebe (1):
      net: sunhme: Fix sbus regression

Ricardo Ribalda (1):
      media: uvcvideo: Fix allocation for small frame sizes

Robert Marko (1):
      mfd: simple-mfd-i2c: Add Delta TN48M CPLD support

Roberto Sassu (1):
      evm: Use ordered xattrs list to calculate HMAC in evm_init_hmac()

Roger Pau Monne (1):
      Partial revert "x86/xen: fix balloon target initialization for PVH dom0"

Roman Penyaev (1):
      RDMA/rtrs-srv: fix SG mapping

Rosen Penev (1):
      wifi: ath9k: add OF dependency to AHB

Russell King (Oracle) (2):
      net: stmmac: remove broken PCS code
      net: stmmac: replace has_xxxx with core_type

Ryan Lee (3):
      apparmor: return -ENOMEM in unpack_perms_table upon alloc failure
      apparmor: fix boolean argument in apparmor_mmap_file
      apparmor: account for in_atomic removal in common_file_perm

Ryan Lin (1):
      HID: intel-ish-hid: fix NULL-ptr-deref in ishtp_bus_remove_all_clients

Sagi Grimberg (1):
      fs/nfs: Fix readdir slow-start regression

Sai Ritvik Tanksalkar (1):
      pstore/ram: fix buffer overflow in persistent_ram_save_old()

Salah Triki (1):
      s390/cio: Fix device lifecycle handling in css_alloc_subchannel()

Samuel Wu (1):
      PM: wakeup: Handle empty list in wakeup_sources_walk_start()

Sandipan Das (1):
      perf/x86/core: Do not set bit width for unavailable counters

Scott Mitchell (1):
      netfilter: nfnetlink_queue: optimize verdict lookup with hash table

Sean V Kelley (1):
      ACPI: CPPC: Fix remaining for_each_possible_cpu() to use online CPUs

Sebastian Andrzej Siewior (10):
      genirq: Set IRQF_COND_ONESHOT in devm_request_irq().
      platform/x86: int0002: Remove IRQF_ONESHOT from request_irq()
      iommu/amd: Use core's primary handler and set IRQF_ONESHOT
      Bluetooth: btintel_pcie: Use IRQF_ONESHOT and default primary handler
      scsi: efct: Use IRQF_ONESHOT and default primary handler
      EDAC/altera: Remove IRQF_ONESHOT
      usb: typec: fusb302: Remove IRQF_ONESHOT
      rtc: amlogic-a4: Remove IRQF_ONESHOT
      mfd: wm8350-core: Use IRQF_ONESHOT
      media: pci: mg4b: Use IRQF_NO_THREAD

Sergey Shtylyov (1):
      PCI: Check parent for NULL in of_pci_bus_release_domain_nr()

Shardul Bankar (1):
      hfsplus: return error when node already exists in hfs_bnode_create

Shay Drory (1):
      net/mlx5: Fix multiport device check over light SFs

Sheetal (1):
      ASoC: tegra: Add AHUB writeable_reg for RX holes

Shengjiu Wang (4):
      remoteproc: imx_dsp_rproc: Only reset carveout memory at RPROC_OFFLINE state
      ASoC: dt-bindings: asahi-kasei,ak4458: set unevaluatedProperties:false
      ASoC: dt-bindings: asahi-kasei,ak4458: Fix the supply names
      ASoC: dt-bindings: asahi-kasei,ak5558: Fix the supply names

Shuai Xue (1):
      Documentation: tracing: Add PCI tracepoint documentation

Shuicheng Lin (3):
      drm/xe: Unregister drm device on probe error
      drm/xe/mmio: Avoid double-adjust in 64-bit reads
      drm/xe: Make xe_modparam.force_vram_bar_size signed

Shyam Prasad N (1):
      netfs: avoid double increment of retry_count in subreq

Shyam Sundar S K (1):
      platform/x86/amd/pmf: Prevent TEE errors after hibernate

Simon Trimmer (1):
      ASoC: SDCA: Allow sample width wild cards in set_usage()

Sjoerd Simons (1):
      clk: mediatek: Drop __initconst from gates

Srinivasan Shanmugam (4):
      drm/amdkfd: Fix signal_eviction_fence() bool return value
      drm/amdgpu: Use explicit VCN instance 0 in SR-IOV init
      drm/amdkfd: Fix watch_id bounds checking in debug address watch v2
      drm/amd/display: Fix out-of-bounds stream encoder index v3

Stefan Metzmacher (1):
      smb: client: correct value for smbd_max_fragmented_recv_size

Steven Rostedt (1):
      tracing: Remove duplicate ENABLE_EVENT_STR and DISABLE_EVENT_STR macros

Sudeep Holla (2):
      firmware: arm_ffa: Correct 32-bit response handling in NOTIFICATION_INFO_GET
      Revert "mailbox/pcc: support mailbox management of the shared buffer"

Svyatoslav Ryhel (1):
      drivers: iio: mpu3050: use dev_err_probe for regulator request

System Administrator (1):
      apparmor: fix NULL pointer dereference in __unix_needs_revalidation

Takashi Iwai (3):
      ALSA: pcm: Relax __free() variable declarations
      ALSA: vmaster: Relax __free() variable declarations
      ALSA: hda/conexant: Fix headphone jack handling on Acer Swift SF314

Taniya Das (1):
      clk: qcom: rcg2: compute 2d using duty fraction directly

Teddy Astie (1):
      xen/virtio: Don't use grant-dma-ops when running as Dom0

Teguh Sobirin (1):
      drm/msm/dpu: Set vsync source irrespective of mdp top support

Thomas Bogendoerfer (1):
      bonding: only set speed/duplex to unknown, if getting speed failed

Thomas Fourier (3):
      auxdisplay: arm-charlcd: fix release_mem_region() size
      crypto: cavium - fix dma_free_coherent() size
      crypto: octeontx - fix dma_free_coherent() size

Thomas Gleixner (2):
      time/sched_clock: Use ACCESS_PRIVATE() to evaluate hrtimer::function
      hrtimer: Fix trace oddity

Thomas Richard (1):
      phy: freescale: imx8qm-hsio: fix NULL pointer dereference

Thomas Richard (TI) (1):
      usb: cdns3: fix role switching during resume

Thomas Weißschuh (1):
      ARM: VDSO: Patch out __vdso_clock_getres() if unavailable

Timur Kristóf (1):
      drm/amd/display: Reject cursor plane on DCE when scaled differently than primary

Titouan Ameline de Cadeville (1):
      fs/tests: exec: drop duplicate bprm_stack_limits test vectors

Tom Lendacky (1):
      crypto: ccp - Fix a case where SNP_SHUTDOWN is missed

Trond Myklebust (1):
      NFS/localio: Handle short writes by retrying

Tuo Li (1):
      of: unittest: fix possible null-pointer dereferences in of_unittest_property_copy()

Tycho Andersen (AMD) (1):
      crypto: ccp - narrow scope of snp_range_list

Tzung-Bi Shih (1):
      platform/chrome: cros_ec_lightbar: Fix response size initialization

Uwe Kleine-König (1):
      PCI/portdrv: Fix potential resource leak

Val Packett (1):
      power: supply: qcom_battmgr: Recognize "LiP" as lithium-polymer

Varun R Mallya (1):
      libbpf: Fix OOB read in btf_dump_get_bitfield_value

Vikas Gupta (1):
      bnge: fix reserving resources from FW

Viken Dadhaniya (1):
      arm64: dts: qcom: talos: Drop opp-shared from QUP OPP table

Vikram Sharma (1):
      dt-bindings: media: qcom,qcs8300-camss: Add missing power supplies

Vimlesh Kumar (3):
      octeon_ep: disable per ring interrupts
      octeon_ep: ensure dbell BADDR updation
      octeon_ep_vf: ensure dbell BADDR updation

Vinay Belgaumkar (1):
      drm/xe/ptl: Disable DCC on PTL

Vladimir Zapolskiy (5):
      arm64: dts: qcom: msm8994-octagon: Fix Analog Devices vendor prefix of AD7147
      arm: dts: lpc32xx: add clocks property to Motor Control PWM device tree node
      clk: qcom: gcc-sm8550: Use floor ops for SDCC RCGs
      clk: qcom: gcc-sm8650: Use floor ops for SDCC RCGs
      Input: adp5589 - remove a leftover header file

Votokina Victoria (1):
      nfc: hci: shdlc: Stop timers and work before freeing context

Waqar Hameed (12):
      power: supply: ab8500: Fix use-after-free in power_supply_changed()
      power: supply: act8945a: Fix use-after-free in power_supply_changed()
      power: supply: bq256xx: Fix use-after-free in power_supply_changed()
      power: supply: bq25980: Fix use-after-free in power_supply_changed()
      power: supply: cpcap-battery: Fix use-after-free in power_supply_changed()
      power: supply: goldfish: Fix use-after-free in power_supply_changed()
      power: supply: pm8916_bms_vm: Fix use-after-free in power_supply_changed()
      power: supply: pm8916_lbc: Fix use-after-free in power_supply_changed()
      power: supply: rt9455: Fix use-after-free in power_supply_changed()
      power: supply: sbs-battery: Fix use-after-free in power_supply_changed()
      power: supply: wm97xx: Fix NULL pointer dereference in power_supply_changed()
      power: supply: pm8916_lbc: Fix use-after-free for extcon in IRQ handler

Wei Li (1):
      pinctrl: single: fix refcount leak in pcs_add_gpio_func()

Weigang He (1):
      mtd: parsers: ofpart: fix OF node refcount leak in parse_fixed_partitions()

Weili Qian (3):
      crypto: hisilicon/hpre - support the hpre algorithm fallback
      crypto: hisilicon/trng - support tfms sharing the device
      hisi_acc_vfio_pci: fix VF reset timeout issue

Xiao Ni (1):
      md: fix return value of mddev_trylock

Xiaochen Shen (1):
      selftests/resctrl: Fix a division by zero error on Hygon

Yao Kai (1):
      rcu: Fix rcu_read_unlock() deadloop due to softirq

Yao Zi (2):
      clk: thead: th1520-ap: Poll for PLL lock and wait for stability
      MIPS: Work around LLVM bug when gp is used as global register variable

Yaxiong Tian (1):
      cpufreq: intel_pstate: Enable asym capacity only when CPU SMT is not possible

Yi Liu (2):
      RDMA/uverbs: Validate wqe_size before using it in ib_uverbs_post_send
      RDMA/uverbs: Add __GFP_NOWARN to ib_uverbs_unmarshall_recv() kmalloc

Yicong Yang (1):
      coresight: tmc-etr: Fix race condition between sysfs and perf mode

Yongjian Sun (1):
      ext4: fix e4b bitmap inconsistency reports

Yu Kuai (3):
      md/raid5: fix raid5_run() to return error when log_init() fails
      md/raid5: fix IO hang with degraded array with llbitmap
      md/md-llbitmap: fix percpu_ref not resurrected on suspend timeout

Yue Haibing (1):
      selftests: net: lib: Fix jq parsing error

YunJe Shin (2):
      RDMA/siw: Fix potential NULL pointer dereference in header processing
      RDMA/umad: Reject negative data_len in ib_umad_write

Yuxiong Wang (1):
      cxl: Fix premature commit_end increment on decoder commit failure

Zesen Liu (1):
      bpf: Fix memory access flags in helper prototypes

Zhai Can (1):
      ACPI: PM: Add unused power resource quirk for THUNDEROBOT ZERO

Zhang Yi (5):
      ext4: subdivide EXT4_EXT_DATA_VALID1
      ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1
      ext4: don't cache extent during splitting extent
      ext4: drop extent cache after doing PARTIAL_VALID1 zeroout
      ext4: drop extent cache when splitting extent fails

Zhengmian Hu (1):
      apparmor: avoid per-cpu hold underflow in aa_get_buffer

Zhiyu Zhang (1):
      fat: avoid parent link count underflow in rmdir

Zilin Guan (14):
      i3c: dw: Fix memory leak in dw_i3c_master_i2c_xfers()
      md/raid1: fix memory leak in raid1_run()
      crypto: starfive - Fix memory leak in starfive_aes_aead_do_one_req()
      soc: mediatek: svs: Fix memory leak in svs_enable_debug_write()
      media: chips-media: wave5: Fix memory leak on codec_info allocation failure
      wifi: rtw89: debug: Fix memory leak in __print_txpwr_map()
      mtd: parsers: Fix memory leak in mtd_parser_tplink_safeloader_parse()
      RDMA/mlx5: Fix memory leak in GET_DATA_DIRECT_SYSFS_PATH handler
      scsi: smartpqi: Fix memory leak in pqi_report_phys_luns()
      gpib: Fix memory leak in ni_usb_init()
      drm/amdgpu: Fix memory leak in amdgpu_acpi_enumerate_xcc()
      drm/amdgpu: Use kvfree instead of kfree in amdgpu_gmc_get_nps_memranges()
      drm/amdgpu: Fix memory leak in amdgpu_ras_init()
      ext4: fix memory leak in ext4_ext_shift_extents()

Zishun Yi (1):
      accel/amdxdna: Fix memory leak in amdxdna_ubuf_map

Ziyi Guo (7):
      wifi: ath10k: sdio: add missing lock protection in ath10k_sdio_fw_crashed_dump()
      net: mscc: ocelot: extract ocelot_xmit_timestamp() helper
      net: mscc: ocelot: split xmit into FDMA and register injection paths
      net: mscc: ocelot: add missing lock protection in ocelot_port_xmit_inj()
      net: usb: catc: enable basic endpoint checking
      xen-netback: reject zero-queue configuration from guest
      ASoC: fsl_xcvr: Revert fix missing lock in fsl_xcvr_mode_put()

lizhi (1):
      crypto: hisilicon/hpre: extend tag field to 64 bits for better performance

zhouwenhao (1):
      objpool: fix the overestimation of object pooling metadata size


