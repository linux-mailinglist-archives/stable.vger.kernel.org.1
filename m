Return-Path: <stable+bounces-111902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AE4A24B30
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 18:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5231886F17
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 17:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266981C3C10;
	Sat,  1 Feb 2025 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ew0brFOz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B91BEF8A;
	Sat,  1 Feb 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738431943; cv=none; b=Z6IhDaKv/sNAL0obAWZsPEFlc7Ow/mqdep4lvZGDaTStPS8SQnkOgxjzePOWvLYx+UUDm2tFsrcQrQW6LDQi29bhDOi9FTb5hP/fhUm1VDm5QE/4QVoHmgYatnVDhMq0RpQeLQmY+2jLm0OWWYC+Dj03iwzcqQ+3X8kumnrtfdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738431943; c=relaxed/simple;
	bh=x5yxdi0/L3gUJaW1sM0izDLrnJHhNwu89K3nfPVDEY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jm0dyrL7xp8jv8qh6Qtb5ceCg0Hr/8zrWM9WU/3QnheUa765daCNX3RT9zU3HS3w/zNBU04bvEIHqJT0o7tkEJ/ZQUTWrzmjbcqzO/tzo4Y3d6yxYoWvuIuxtH1K+qtJSzRCueK4QM855esk6fQ6NimxFTYmNe7lhJVGfVSPC7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ew0brFOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA6CC4CED3;
	Sat,  1 Feb 2025 17:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738431943;
	bh=x5yxdi0/L3gUJaW1sM0izDLrnJHhNwu89K3nfPVDEY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ew0brFOzeHTt4UgTEMPooI2V9BaoeZm2ziMabH4Q59/jf9fU/Coi7tvAMR/bqwfxW
	 bN+nQaf2ADVIn88k/j3u/++w+Hjk8F9xD4fMvGF4EEzTEfmFYOROGNMr3fIv71ZdYp
	 VCT/JS4NVqpZ0qTA145O1i9sbFSSn1XpEjvXv/EY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.290
Date: Sat,  1 Feb 2025 18:45:26 +0100
Message-ID: <2025020126-preacher-jubilance-5be5@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025020126-bottling-drew-1dae@gregkh>
References: <2025020126-bottling-drew-1dae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index e983a36fa88b..dc7f459fc670 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 289
+SUBLEVEL = 290
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index f297601c9f71..652998c83640 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -219,12 +219,14 @@
 					 <&cru HCLK_OTG>,
 					 <&cru SCLK_OTG_ADP>;
 				pm_qos = <&qos_usb_host>, <&qos_usb_otg>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@PX30_PD_SDCARD {
 				reg = <PX30_PD_SDCARD>;
 				clocks = <&cru HCLK_SDMMC>,
 					 <&cru SCLK_SDMMC>;
 				pm_qos = <&qos_sdmmc>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@PX30_PD_GMAC {
 				reg = <PX30_PD_GMAC>;
@@ -233,6 +235,7 @@
 					 <&cru SCLK_MAC_REF>,
 					 <&cru SCLK_GMAC_RX_TX>;
 				pm_qos = <&qos_gmac>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@PX30_PD_MMC_NAND {
 				reg = <PX30_PD_MMC_NAND>;
@@ -246,6 +249,7 @@
 					  <&cru SCLK_SFC>;
 				pm_qos = <&qos_emmc>, <&qos_nand>,
 					 <&qos_sdio>, <&qos_sfc>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@PX30_PD_VPU {
 				reg = <PX30_PD_VPU>;
@@ -253,6 +257,7 @@
 					 <&cru HCLK_VPU>,
 					 <&cru SCLK_CORE_VPU>;
 				pm_qos = <&qos_vpu>, <&qos_vpu_r128>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@PX30_PD_VO {
 				reg = <PX30_PD_VO>;
@@ -269,6 +274,7 @@
 					 <&cru SCLK_VOPB_PWM>;
 				pm_qos = <&qos_rga_rd>, <&qos_rga_wr>,
 					 <&qos_vop_m0>, <&qos_vop_m1>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@PX30_PD_VI {
 				reg = <PX30_PD_VI>;
@@ -280,11 +286,13 @@
 				pm_qos = <&qos_isp_128>, <&qos_isp_rd>,
 					 <&qos_isp_wr>, <&qos_isp_m1>,
 					 <&qos_vip>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@PX30_PD_GPU {
 				reg = <PX30_PD_GPU>;
 				clocks = <&cru SCLK_GPU>;
 				pm_qos = <&qos_gpu>;
+				#power-domain-cells = <0>;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 5bb84ec31c6f..f6f5a64fef09 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -272,13 +272,17 @@
 
 			power-domain@RK3328_PD_HEVC {
 				reg = <RK3328_PD_HEVC>;
+				clocks = <&cru SCLK_VENC_CORE>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@RK3328_PD_VIDEO {
 				reg = <RK3328_PD_VIDEO>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@RK3328_PD_VPU {
 				reg = <RK3328_PD_VPU>;
 				clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+				#power-domain-cells = <0>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e5a25bc7d799..e52c2dc1710a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1001,6 +1001,7 @@
 				clocks = <&cru ACLK_IEP>,
 					 <&cru HCLK_IEP>;
 				pm_qos = <&qos_iep>;
+				#power-domain-cells = <0>;
 			};
 			pd_rga@RK3399_PD_RGA {
 				reg = <RK3399_PD_RGA>;
@@ -1008,12 +1009,14 @@
 					 <&cru HCLK_RGA>;
 				pm_qos = <&qos_rga_r>,
 					 <&qos_rga_w>;
+				#power-domain-cells = <0>;
 			};
 			pd_vcodec@RK3399_PD_VCODEC {
 				reg = <RK3399_PD_VCODEC>;
 				clocks = <&cru ACLK_VCODEC>,
 					 <&cru HCLK_VCODEC>;
 				pm_qos = <&qos_video_m0>;
+				#power-domain-cells = <0>;
 			};
 			pd_vdu@RK3399_PD_VDU {
 				reg = <RK3399_PD_VDU>;
@@ -1021,6 +1024,7 @@
 					 <&cru HCLK_VDU>;
 				pm_qos = <&qos_video_m1_r>,
 					 <&qos_video_m1_w>;
+				#power-domain-cells = <0>;
 			};
 
 			/* These power domains are grouped by VD_GPU */
@@ -1028,43 +1032,63 @@
 				reg = <RK3399_PD_GPU>;
 				clocks = <&cru ACLK_GPU>;
 				pm_qos = <&qos_gpu>;
+				#power-domain-cells = <0>;
 			};
 
 			/* These power domains are grouped by VD_LOGIC */
 			pd_edp@RK3399_PD_EDP {
 				reg = <RK3399_PD_EDP>;
 				clocks = <&cru PCLK_EDP_CTRL>;
+				#power-domain-cells = <0>;
 			};
 			pd_emmc@RK3399_PD_EMMC {
 				reg = <RK3399_PD_EMMC>;
 				clocks = <&cru ACLK_EMMC>;
 				pm_qos = <&qos_emmc>;
+				#power-domain-cells = <0>;
 			};
 			pd_gmac@RK3399_PD_GMAC {
 				reg = <RK3399_PD_GMAC>;
 				clocks = <&cru ACLK_GMAC>,
 					 <&cru PCLK_GMAC>;
 				pm_qos = <&qos_gmac>;
+				#power-domain-cells = <0>;
 			};
 			pd_sd@RK3399_PD_SD {
 				reg = <RK3399_PD_SD>;
 				clocks = <&cru HCLK_SDMMC>,
 					 <&cru SCLK_SDMMC>;
 				pm_qos = <&qos_sd>;
+				#power-domain-cells = <0>;
 			};
 			pd_sdioaudio@RK3399_PD_SDIOAUDIO {
 				reg = <RK3399_PD_SDIOAUDIO>;
 				clocks = <&cru HCLK_SDIO>;
 				pm_qos = <&qos_sdioaudio>;
+				#power-domain-cells = <0>;
+			};
+			pd_tcpc0@RK3399_PD_TCPD0 {
+				reg = <RK3399_PD_TCPD0>;
+				clocks = <&cru SCLK_UPHY0_TCPDCORE>,
+					 <&cru SCLK_UPHY0_TCPDPHY_REF>;
+				#power-domain-cells = <0>;
+			};
+			pd_tcpc1@RK3399_PD_TCPD1 {
+				reg = <RK3399_PD_TCPD1>;
+				clocks = <&cru SCLK_UPHY1_TCPDCORE>,
+					 <&cru SCLK_UPHY1_TCPDPHY_REF>;
+				#power-domain-cells = <0>;
 			};
 			pd_usb3@RK3399_PD_USB3 {
 				reg = <RK3399_PD_USB3>;
 				clocks = <&cru ACLK_USB3>;
 				pm_qos = <&qos_usb_otg0>,
 					 <&qos_usb_otg1>;
+				#power-domain-cells = <0>;
 			};
 			pd_vio@RK3399_PD_VIO {
 				reg = <RK3399_PD_VIO>;
+				#power-domain-cells = <1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1074,6 +1098,7 @@
 						 <&cru HCLK_HDCP>,
 						 <&cru PCLK_HDCP>;
 					pm_qos = <&qos_hdcp>;
+					#power-domain-cells = <0>;
 				};
 				pd_isp0@RK3399_PD_ISP0 {
 					reg = <RK3399_PD_ISP0>;
@@ -1081,6 +1106,7 @@
 						 <&cru HCLK_ISP0>;
 					pm_qos = <&qos_isp0_m0>,
 						 <&qos_isp0_m1>;
+					#power-domain-cells = <0>;
 				};
 				pd_isp1@RK3399_PD_ISP1 {
 					reg = <RK3399_PD_ISP1>;
@@ -1088,19 +1114,11 @@
 						 <&cru HCLK_ISP1>;
 					pm_qos = <&qos_isp1_m0>,
 						 <&qos_isp1_m1>;
-				};
-				pd_tcpc0@RK3399_PD_TCPC0 {
-					reg = <RK3399_PD_TCPD0>;
-					clocks = <&cru SCLK_UPHY0_TCPDCORE>,
-						 <&cru SCLK_UPHY0_TCPDPHY_REF>;
-				};
-				pd_tcpc1@RK3399_PD_TCPC1 {
-					reg = <RK3399_PD_TCPD1>;
-					clocks = <&cru SCLK_UPHY1_TCPDCORE>,
-						 <&cru SCLK_UPHY1_TCPDPHY_REF>;
+					#power-domain-cells = <0>;
 				};
 				pd_vo@RK3399_PD_VO {
 					reg = <RK3399_PD_VO>;
+					#power-domain-cells = <1>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
@@ -1110,12 +1128,14 @@
 							 <&cru HCLK_VOP0>;
 						pm_qos = <&qos_vop_big_r>,
 							 <&qos_vop_big_w>;
+						#power-domain-cells = <0>;
 					};
 					pd_vopl@RK3399_PD_VOPL {
 						reg = <RK3399_PD_VOPL>;
 						clocks = <&cru ACLK_VOP1>,
 							 <&cru HCLK_VOP1>;
 						pm_qos = <&qos_vop_little>;
+						#power-domain-cells = <0>;
 					};
 				};
 			};
diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index 31a9c634c81e..081922c72daa 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -502,7 +502,8 @@ in_ea:
 	.section .fixup,"ax"
 	.even
 1:
-	jbra	fpsp040_die
+	jbsr	fpsp040_die
+	jbra	.Lnotkern
 
 	.section __ex_table,"a"
 	.align	4
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 417d8f0e8962..0d03b4f2077b 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -182,6 +182,8 @@ ENTRY(ret_from_signal)
 	movel	%curptr@(TASK_STACK),%a1
 	tstb	%a1@(TINFO_FLAGS+2)
 	jge	1f
+	lea	%sp@(SWITCH_STACK_SIZE),%a1
+	movel	%a1,%curptr@(TASK_THREAD+THREAD_ESP0)
 	jbsr	syscall_trace
 1:	RESTORE_SWITCH_STACK
 	addql	#4,%sp
diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index 6363ec83a290..38dcc1a2097d 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -388,6 +388,8 @@ sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
 		ret = -EPERM;
 		if (!capable(CAP_SYS_ADMIN))
 			goto out;
+
+		down_read(&current->mm->mmap_sem);
 	} else {
 		struct vm_area_struct *vma;
 
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 5bf314871e9f..38311a403b08 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -1155,7 +1155,7 @@ asmlinkage void set_esp0(unsigned long ssp)
  */
 asmlinkage void fpsp040_die(void)
 {
-	do_exit(SIGSEGV);
+	force_sigsegv(SIGSEGV);
 }
 
 #ifdef CONFIG_M68KFPU_EMU
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 65567f26d7bd..2750518a5d5e 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -442,6 +442,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2402CBA"),
 		},
 	},
+	{
+		/* Asus Vivobook X1504VAP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "X1504VAP"),
+		},
+	},
 	{
 		/* Asus Vivobook X1704VAP */
 		.matches = {
@@ -514,6 +521,17 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "16T90SP"),
 		},
 	},
+	{
+		/*
+		 * TongFang GM5HG0A in case of the SKIKK Vanaheim relabel the
+		 * board-name is changed, so check OEM strings instead. Note
+		 * OEM string matches are always exact matches.
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=219614
+		 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_OEM_STRING, "GM5HG0A"),
+		},
+	},
 	{ }
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a82352a87808..1c14c8295b45 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -41,7 +41,7 @@
 
 #define DC_VER "3.2.48"
 
-#define MAX_SURFACES 3
+#define MAX_SURFACES 4
 #define MAX_PLANES 6
 #define MAX_STREAMS 6
 #define MAX_SINKS_PER_LINK 4
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
index ded71ea82413..8968aa2bf156 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
@@ -67,11 +67,15 @@ static inline double dml_max5(double a, double b, double c, double d, double e)
 
 static inline double dml_ceil(double a, double granularity)
 {
+	if (granularity == 0)
+		return 0;
 	return (double) dcn_bw_ceil2(a, granularity);
 }
 
 static inline double dml_floor(double a, double granularity)
 {
+	if (granularity == 0)
+		return 0;
 	return (double) dcn_bw_floor2(a, granularity);
 }
 
@@ -97,11 +101,15 @@ static inline double dml_ceil_2(double f)
 
 static inline double dml_ceil_ex(double x, double granularity)
 {
+	if (granularity == 0)
+		return 0;
 	return (double) dcn_bw_ceil2(x, granularity);
 }
 
 static inline double dml_floor_ex(double x, double granularity)
 {
+	if (granularity == 0)
+		return 0;
 	return (double) dcn_bw_floor2(x, granularity);
 }
 
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index 662e67279a7b..41705436a748 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -102,7 +102,10 @@ v3d_irq(int irq, void *arg)
 			to_v3d_fence(v3d->bin_job->base.irq_fence);
 
 		trace_v3d_bcl_irq(&v3d->drm, fence->seqno);
+
+		v3d->bin_job = NULL;
 		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 
@@ -111,7 +114,10 @@ v3d_irq(int irq, void *arg)
 			to_v3d_fence(v3d->render_job->base.irq_fence);
 
 		trace_v3d_rcl_irq(&v3d->drm, fence->seqno);
+
+		v3d->render_job = NULL;
 		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 
@@ -120,7 +126,10 @@ v3d_irq(int irq, void *arg)
 			to_v3d_fence(v3d->csd_job->base.irq_fence);
 
 		trace_v3d_csd_irq(&v3d->drm, fence->seqno);
+
+		v3d->csd_job = NULL;
 		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 
@@ -156,7 +165,10 @@ v3d_hub_irq(int irq, void *arg)
 			to_v3d_fence(v3d->tfu_job->base.irq_fence);
 
 		trace_v3d_tfu_irq(&v3d->drm, fence->seqno);
+
+		v3d->tfu_job = NULL;
 		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 45a3f7e7b3f6..cea057704c00 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -261,7 +261,9 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 	pm_runtime_no_callbacks(&pdev->dev);
 
 	/* switch to first parent as active master */
-	i2c_demux_activate_master(priv, 0);
+	err = i2c_demux_activate_master(priv, 0);
+	if (err)
+		goto err_rollback;
 
 	err = device_create_file(&pdev->dev, &dev_attr_available_masters);
 	if (err)
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index cc81b35ca47a..4226e307ab27 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1139,7 +1139,7 @@ static int at91_ts_register(struct at91_adc_state *st,
 	return ret;
 
 err:
-	input_free_device(st->ts_input);
+	input_free_device(input);
 	return ret;
 }
 
diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 4b706949a67f..b8a506209c35 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -182,9 +182,9 @@ static int ads124s_reset(struct iio_dev *indio_dev)
 	struct ads124s_private *priv = iio_priv(indio_dev);
 
 	if (priv->reset_gpio) {
-		gpiod_set_value(priv->reset_gpio, 0);
+		gpiod_set_value_cansleep(priv->reset_gpio, 0);
 		udelay(200);
-		gpiod_set_value(priv->reset_gpio, 1);
+		gpiod_set_value_cansleep(priv->reset_gpio, 1);
 	} else {
 		return ads124s_write_cmd(indio_dev, ADS124S08_CMD_RESET);
 	}
diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 55a2d619d6dd..f0f16bc68865 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -384,7 +384,7 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	/* Ensure naturally aligned timestamp */
-	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8);
+	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8) = { };
 	int i, j = 0;
 
 	for (i = 0; i < indio_dev->masklength; i++) {
diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 17606eca42b4..0615d34d908b 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -48,7 +48,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	int len = 0;
 	u16 *data;
 
-	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	data = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (!data)
 		goto done;
 
diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index 45e2b5b33072..891969a805b7 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -664,14 +664,21 @@ static irqreturn_t fxas21002c_trigger_handler(int irq, void *p)
 	int ret;
 
 	mutex_lock(&data->lock);
+	ret = fxas21002c_pm_get(data);
+	if (ret < 0)
+		goto out_unlock;
+
 	ret = regmap_bulk_read(data->regmap, FXAS21002C_REG_OUT_X_MSB,
 			       data->buffer, CHANNEL_SCAN_MAX * sizeof(s16));
 	if (ret < 0)
-		goto out_unlock;
+		goto out_pm_put;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
 					   data->timestamp);
 
+out_pm_put:
+	fxas21002c_pm_put(data);
+
 out_unlock:
 	mutex_unlock(&data->lock);
 
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index c7d19f9ca765..fb01b64d356a 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1198,7 +1198,7 @@ static irqreturn_t kmx61_trigger_handler(int irq, void *p)
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 	int bit, ret, i = 0;
 	u8 base;
-	s16 buffer[8];
+	s16 buffer[8] = { };
 
 	if (indio_dev == data->acc_indio_dev)
 		base = KMX61_ACC_XOUT_L;
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 730c821b5221..6374d5091555 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -466,7 +466,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 	return chans;
 
 error_free_chans:
-	for (i = 0; i < nummaps; i++)
+	for (i = 0; i < mapind; i++)
 		iio_device_put(chans[i].indio_dev);
 	kfree(chans);
 error_ret:
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 6c83f9e54e2e..940b80c81d52 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -105,7 +105,7 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct vcnl4035_data *data = iio_priv(indio_dev);
 	/* Ensure naturally aligned timestamp */
-	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8);
+	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8) = { };
 	int ret;
 
 	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, (int *)buffer);
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 7f2e5a8942a4..df60b3d91dad 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -585,6 +585,8 @@ static int zpa2326_fill_sample_buffer(struct iio_dev               *indio_dev,
 	}   sample;
 	int err;
 
+	memset(&sample, 0, sizeof(sample));
+
 	if (test_bit(0, indio_dev->active_scan_mask)) {
 		/* Get current pressure from hardware FIFO. */
 		err = zpa2326_dequeue_pressure(indio_dev, &sample.pressure);
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 239471cf7e4c..00b973e0f79f 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -128,6 +128,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", 0, XTYPE_XBOX360 },
 	{ 0x045e, 0x028f, "Microsoft X-Box 360 pad v2", 0, XTYPE_XBOX360 },
 	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
+	{ 0x045e, 0x02a9, "Xbox 360 Wireless Receiver (Unofficial)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x045e, 0x02d1, "Microsoft X-Box One pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02dd, "Microsoft X-Box One pad (Firmware 2015)", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0, XTYPE_XBOXONE },
@@ -344,6 +345,7 @@ static const struct xpad_device {
 	{ 0x31e3, 0x1200, "Wooting Two", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1210, "Wooting Lekker", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1220, "Wooting Two HE", 0, XTYPE_XBOX360 },
+	{ 0x31e3, 0x1230, "Wooting Two HE (ARM)", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1300, "Wooting 60HE (AVR)", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1310, "Wooting 60HE (ARM)", 0, XTYPE_XBOX360 },
 	{ 0x3285, 0x0607, "Nacon GC-100", 0, XTYPE_XBOX360 },
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index cb7f9b46ce65..c22ef6483c40 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -84,7 +84,7 @@ static const unsigned short atkbd_set2_keycode[ATKBD_KEYMAP_SIZE] = {
 	  0, 46, 45, 32, 18,  5,  4, 95,  0, 57, 47, 33, 20, 19,  6,183,
 	  0, 49, 48, 35, 34, 21,  7,184,  0,  0, 50, 36, 22,  8,  9,185,
 	  0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
-	  0, 89, 40,  0, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0, 85,
+	  0, 89, 40,  0, 26, 13,  0,193, 58, 54, 28, 27,  0, 43,  0, 85,
 	  0, 86, 91, 90, 92,  0, 14, 94,  0, 79,124, 75, 71,121,  0,  0,
 	 82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
 
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 4cbfd8c18615..93fc046f9307 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1185,7 +1185,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
 {
-	if (cmd == CPU_PM_EXIT) {
+	if (cmd == CPU_PM_EXIT || cmd == CPU_PM_ENTER_FAILED) {
 		if (gic_dist_security_disabled())
 			gic_enable_redist(true);
 		gic_cpu_sys_reg_init();
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index a412b5d5d0fa..a2aadfdc4772 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -200,7 +200,8 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	gc->chip_types[0].chip.irq_unmask	= irq_gc_mask_set_bit;
 	gc->chip_types[0].chip.irq_eoi		= irq_gc_ack_set_bit;
 	gc->chip_types[0].chip.irq_set_type	= sunxi_sc_nmi_set_type;
-	gc->chip_types[0].chip.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED;
+	gc->chip_types[0].chip.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
+						  IRQCHIP_SKIP_SET_WAKE;
 	gc->chip_types[0].regs.ack		= reg_offs->pend;
 	gc->chip_types[0].regs.mask		= reg_offs->enable;
 	gc->chip_types[0].regs.type		= reg_offs->ctrl;
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 1ce0d5b52746..9e4332233531 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -2325,10 +2325,9 @@ static struct thin_c *get_first_thin(struct pool *pool)
 	struct thin_c *tc = NULL;
 
 	rcu_read_lock();
-	if (!list_empty(&pool->active_thins)) {
-		tc = list_entry_rcu(pool->active_thins.next, struct thin_c, list);
+	tc = list_first_or_null_rcu(&pool->active_thins, struct thin_c, list);
+	if (tc)
 		thin_get(tc);
-	}
 	rcu_read_unlock();
 
 	return tc;
diff --git a/drivers/md/persistent-data/dm-array.c b/drivers/md/persistent-data/dm-array.c
index 185dc60360b5..4d434d89eadd 100644
--- a/drivers/md/persistent-data/dm-array.c
+++ b/drivers/md/persistent-data/dm-array.c
@@ -907,23 +907,27 @@ static int load_ablock(struct dm_array_cursor *c)
 	if (c->block)
 		unlock_ablock(c->info, c->block);
 
-	c->block = NULL;
-	c->ab = NULL;
 	c->index = 0;
 
 	r = dm_btree_cursor_get_value(&c->cursor, &key, &value_le);
 	if (r) {
 		DMERR("dm_btree_cursor_get_value failed");
-		dm_btree_cursor_end(&c->cursor);
+		goto out;
 
 	} else {
 		r = get_ablock(c->info, le64_to_cpu(value_le), &c->block, &c->ab);
 		if (r) {
 			DMERR("get_ablock failed");
-			dm_btree_cursor_end(&c->cursor);
+			goto out;
 		}
 	}
 
+	return 0;
+
+out:
+	dm_btree_cursor_end(&c->cursor);
+	c->block = NULL;
+	c->ab = NULL;
 	return r;
 }
 
@@ -946,10 +950,10 @@ EXPORT_SYMBOL_GPL(dm_array_cursor_begin);
 
 void dm_array_cursor_end(struct dm_array_cursor *c)
 {
-	if (c->block) {
+	if (c->block)
 		unlock_ablock(c->info, c->block);
-		dm_btree_cursor_end(&c->cursor);
-	}
+
+	dm_btree_cursor_end(&c->cursor);
 }
 EXPORT_SYMBOL_GPL(dm_array_cursor_end);
 
@@ -989,6 +993,7 @@ int dm_array_cursor_skip(struct dm_array_cursor *c, uint32_t count)
 		}
 
 		count -= remaining;
+		c->index += (remaining - 1);
 		r = dm_array_cursor_next(c);
 
 	} while (!r);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 0a15c617c702..fa56ef029315 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -855,7 +855,6 @@ static void xgbe_phy_free_phy_device(struct xgbe_prv_data *pdata)
 
 static bool xgbe_phy_finisar_phy_quirks(struct xgbe_prv_data *pdata)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
 	unsigned int phy_id = phy_data->phydev->phy_id;
 
@@ -877,14 +876,7 @@ static bool xgbe_phy_finisar_phy_quirks(struct xgbe_prv_data *pdata)
 	phy_write(phy_data->phydev, 0x04, 0x0d01);
 	phy_write(phy_data->phydev, 0x00, 0x9140);
 
-	linkmode_set_bit_array(phy_10_100_features_array,
-			       ARRAY_SIZE(phy_10_100_features_array),
-			       supported);
-	linkmode_set_bit_array(phy_gbit_features_array,
-			       ARRAY_SIZE(phy_gbit_features_array),
-			       supported);
-
-	linkmode_copy(phy_data->phydev->supported, supported);
+	linkmode_copy(phy_data->phydev->supported, PHY_GBIT_FEATURES);
 
 	phy_support_asym_pause(phy_data->phydev);
 
@@ -896,7 +888,6 @@ static bool xgbe_phy_finisar_phy_quirks(struct xgbe_prv_data *pdata)
 
 static bool xgbe_phy_belfuse_phy_quirks(struct xgbe_prv_data *pdata)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
 	struct xgbe_sfp_eeprom *sfp_eeprom = &phy_data->sfp_eeprom;
 	unsigned int phy_id = phy_data->phydev->phy_id;
@@ -960,13 +951,7 @@ static bool xgbe_phy_belfuse_phy_quirks(struct xgbe_prv_data *pdata)
 	reg = phy_read(phy_data->phydev, 0x00);
 	phy_write(phy_data->phydev, 0x00, reg & ~0x00800);
 
-	linkmode_set_bit_array(phy_10_100_features_array,
-			       ARRAY_SIZE(phy_10_100_features_array),
-			       supported);
-	linkmode_set_bit_array(phy_gbit_features_array,
-			       ARRAY_SIZE(phy_gbit_features_array),
-			       supported);
-	linkmode_copy(phy_data->phydev->supported, supported);
+	linkmode_copy(phy_data->phydev->supported, PHY_GBIT_FEATURES);
 	phy_support_asym_pause(phy_data->phydev);
 
 	netif_dbg(pdata, drv, pdata->netdev,
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/offload.c b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
index 7ff388ecc7e3..409b636c7647 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
@@ -454,7 +454,8 @@ int nfp_bpf_event_output(struct nfp_app_bpf *bpf, const void *data,
 	map_id_full = be64_to_cpu(cbe->map_ptr);
 	map_id = map_id_full;
 
-	if (len < sizeof(struct cmsg_bpf_event) + pkt_size + data_size)
+	if (size_add(pkt_size, data_size) > INT_MAX ||
+	    len < sizeof(struct cmsg_bpf_event) + pkt_size + data_size)
 		return -EINVAL;
 	if (cbe->hdr.ver != NFP_CCM_ABI_VERSION)
 		return -EINVAL;
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index f17619c545ae..9280601961c7 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -60,15 +60,15 @@
 
 static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 {
-	int idx, idx2;
+	int idx, idx2, index;
 	u32 hi_val = 0;
 
 	idx    = start / 32;
 	idx2 = (start + bits - 1) / 32;
 	/* Check if bits to be fetched exceed a word */
 	if (idx != idx2) {
-		idx2 = 2 - idx2; /* flip */
-		hi_val = ale_entry[idx2] << ((idx2 * 32) - start);
+		index = 2 - idx2; /* flip */
+		hi_val = ale_entry[index] << ((idx2 * 32) - start);
 	}
 	start -= idx * 32;
 	idx    = 2 - idx; /* flip */
@@ -78,16 +78,16 @@ static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 static inline void cpsw_ale_set_field(u32 *ale_entry, u32 start, u32 bits,
 				      u32 value)
 {
-	int idx, idx2;
+	int idx, idx2, index;
 
 	value &= BITMASK(bits);
 	idx = start / 32;
 	idx2 = (start + bits - 1) / 32;
 	/* Check if bits to be set exceed a word */
 	if (idx != idx2) {
-		idx2 = 2 - idx2; /* flip */
-		ale_entry[idx2] &= ~(BITMASK(bits + start - (idx2 * 32)));
-		ale_entry[idx2] |= (value >> ((idx2 * 32) - start));
+		index = 2 - idx2; /* flip */
+		ale_entry[index] &= ~(BITMASK(bits + start - (idx2 * 32)));
+		ale_entry[index] |= (value >> ((idx2 * 32) - start));
 	}
 	start -= idx * 32;
 	idx = 2 - idx; /* flip */
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index f85f4e3d2821..68698457add0 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -690,8 +690,8 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 		goto out_encap;
 	}
 
-	gn = net_generic(dev_net(dev), gtp_net_id);
-	list_add_rcu(&gtp->list, &gn->gtp_dev_list);
+	gn = net_generic(src_net, gtp_net_id);
+	list_add(&gtp->list, &gn->gtp_dev_list);
 	dev->priv_destructor = gtp_destructor;
 
 	netdev_dbg(dev, "registered new GTP interface\n");
@@ -717,7 +717,7 @@ static void gtp_dellink(struct net_device *dev, struct list_head *head)
 		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
 			pdp_context_delete(pctx);
 
-	list_del_rcu(&gtp->list);
+	list_del(&gtp->list);
 	unregister_netdevice_queue(dev, head);
 }
 
@@ -1259,16 +1259,19 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 	struct gtp_dev *last_gtp = (struct gtp_dev *)cb->args[2], *gtp;
 	int i, j, bucket = cb->args[0], skip = cb->args[1];
 	struct net *net = sock_net(skb->sk);
+	struct net_device *dev;
 	struct pdp_ctx *pctx;
-	struct gtp_net *gn;
-
-	gn = net_generic(net, gtp_net_id);
 
 	if (cb->args[4])
 		return 0;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(gtp, &gn->gtp_dev_list, list) {
+	for_each_netdev_rcu(net, dev) {
+		if (dev->rtnl_link_ops != &gtp_link_ops)
+			continue;
+
+		gtp = netdev_priv(dev);
+
 		if (last_gtp && last_gtp != gtp)
 			continue;
 		else
@@ -1355,23 +1358,28 @@ static int __net_init gtp_net_init(struct net *net)
 	return 0;
 }
 
-static void __net_exit gtp_net_exit(struct net *net)
+static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
+					       struct list_head *dev_to_kill)
 {
-	struct gtp_net *gn = net_generic(net, gtp_net_id);
-	struct gtp_dev *gtp;
-	LIST_HEAD(list);
+	struct net *net;
 
-	rtnl_lock();
-	list_for_each_entry(gtp, &gn->gtp_dev_list, list)
-		gtp_dellink(gtp->dev, &list);
+	list_for_each_entry(net, net_list, exit_list) {
+		struct gtp_net *gn = net_generic(net, gtp_net_id);
+		struct gtp_dev *gtp, *gtp_next;
+		struct net_device *dev;
 
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		for_each_netdev(net, dev)
+			if (dev->rtnl_link_ops == &gtp_link_ops)
+				gtp_dellink(dev, dev_to_kill);
+
+		list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list, list)
+			gtp_dellink(gtp->dev, dev_to_kill);
+	}
 }
 
 static struct pernet_operations gtp_net_ops = {
 	.init	= gtp_net_init,
-	.exit	= gtp_net_exit,
+	.exit_batch_rtnl = gtp_net_exit_batch_rtnl,
 	.id	= &gtp_net_id,
 	.size	= sizeof(struct gtp_net),
 };
diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index fdbdc22fe4e5..d394e2b65054 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -3124,7 +3124,11 @@ static int ca8210_probe(struct spi_device *spi_device)
 	spi_set_drvdata(priv->spi, priv);
 	if (IS_ENABLED(CONFIG_IEEE802154_CA8210_DEBUGFS)) {
 		cascoda_api_upstream = ca8210_test_int_driver_write;
-		ca8210_test_interface_init(priv);
+		ret = ca8210_test_interface_init(priv);
+		if (ret) {
+			dev_crit(&spi_device->dev, "ca8210_test_interface_init failed\n");
+			goto error;
+		}
 	} else {
 		cascoda_api_upstream = NULL;
 	}
diff --git a/drivers/net/xen-netback/hash.c b/drivers/net/xen-netback/hash.c
index 10d580c3dea3..dff011bf324b 100644
--- a/drivers/net/xen-netback/hash.c
+++ b/drivers/net/xen-netback/hash.c
@@ -51,7 +51,8 @@ static void xenvif_add_hash(struct xenvif *vif, const u8 *tag,
 
 	found = false;
 	oldest = NULL;
-	list_for_each_entry_rcu(entry, &vif->hash.cache.list, link) {
+	list_for_each_entry_rcu(entry, &vif->hash.cache.list, link,
+				lockdep_is_held(&vif->hash.cache.lock)) {
 		/* Make sure we don't add duplicate entries */
 		if (entry->len == len &&
 		    memcmp(entry->tag, tag, len) == 0)
@@ -94,7 +95,7 @@ static u32 xenvif_new_hash(struct xenvif *vif, const u8 *data,
 
 static void xenvif_flush_hash(struct xenvif *vif)
 {
-	struct xenvif_hash_cache_entry *entry;
+	struct xenvif_hash_cache_entry *entry, *n;
 	unsigned long flags;
 
 	if (xenvif_hash_cache_size == 0)
@@ -102,7 +103,7 @@ static void xenvif_flush_hash(struct xenvif *vif)
 
 	spin_lock_irqsave(&vif->hash.cache.lock, flags);
 
-	list_for_each_entry_rcu(entry, &vif->hash.cache.list, link) {
+	list_for_each_entry_safe(entry, n, &vif->hash.cache.list, link) {
 		list_del_rcu(&entry->link);
 		vif->hash.cache.count--;
 		kfree_rcu(entry, rcu);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 32008d85172b..40afe3d0599d 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -36,7 +36,7 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	 */
 	id->nsfeat |= 1 << 4;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
-	id->npwg = lpp0b;
+	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index c801fe727f09..c94a0d2c4516 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -1094,11 +1094,12 @@ EXPORT_SYMBOL_GPL(of_phy_provider_unregister);
  * of_phy_provider_unregister to unregister the phy provider.
  */
 void devm_of_phy_provider_unregister(struct device *dev,
-	struct phy_provider *phy_provider) {
+				     struct phy_provider *phy_provider)
+{
 	int r;
 
-	r = devres_destroy(dev, devm_phy_provider_release, devm_phy_match,
-		phy_provider);
+	r = devres_release(dev, devm_phy_provider_release, devm_phy_match,
+			   phy_provider);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY provider device resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_provider_unregister);
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 51f53638629c..9ef242d2a2c9 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -3746,7 +3746,7 @@ iscsi_if_rx(struct sk_buff *skb)
 		}
 		do {
 			/*
-			 * special case for GET_STATS:
+			 * special case for GET_STATS, GET_CHAP and GET_HOST_STATS:
 			 * on success - sending reply and stats from
 			 * inside of if_recv_msg(),
 			 * on error - fall through.
@@ -3755,6 +3755,8 @@ iscsi_if_rx(struct sk_buff *skb)
 				break;
 			if (ev->type == ISCSI_UEVENT_GET_CHAP && !err)
 				break;
+			if (ev->type == ISCSI_UEVENT_GET_HOST_STATS && !err)
+				break;
 			err = iscsi_if_send_reply(portid, nlh->nlmsg_type,
 						  ev, sizeof(*ev));
 			if (err == -EAGAIN && --retries < 0) {
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index cc836610e21e..001a3470b3aa 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -390,7 +390,6 @@ sg_release(struct inode *inode, struct file *filp)
 
 	mutex_lock(&sdp->open_rel_lock);
 	scsi_autopm_put_device(sdp->device);
-	kref_put(&sfp->f_ref, sg_remove_sfp);
 	sdp->open_cnt--;
 
 	/* possibly many open()s waiting on exlude clearing, start many;
@@ -402,6 +401,7 @@ sg_release(struct inode *inode, struct file *filp)
 		wake_up_interruptible(&sdp->open_wait);
 	}
 	mutex_unlock(&sdp->open_rel_lock);
+	kref_put(&sfp->f_ref, sg_remove_sfp);
 	return 0;
 }
 
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index d4e04f439865..8097f3fe4688 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -158,7 +158,7 @@ static int ad9832_write_frequency(struct ad9832_state *st,
 static int ad9832_write_phase(struct ad9832_state *st,
 			      unsigned long addr, unsigned long phase)
 {
-	if (phase > BIT(AD9832_PHASE_BITS))
+	if (phase >= BIT(AD9832_PHASE_BITS))
 		return -EINVAL;
 
 	st->phase_data[0] = cpu_to_be16((AD9832_CMD_PHA8BITSW << CMD_SHIFT) |
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 2e661a905a57..ecf74a65a6f0 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -132,7 +132,7 @@ static int ad9834_write_frequency(struct ad9834_state *st,
 static int ad9834_write_phase(struct ad9834_state *st,
 			      unsigned long addr, unsigned long phase)
 {
-	if (phase > BIT(AD9834_PHASE_BITS))
+	if (phase >= BIT(AD9834_PHASE_BITS))
 		return -EINVAL;
 	st->data = cpu_to_be16(addr | phase);
 
diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index f27b4aecff3d..759f567538e2 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -1337,11 +1337,12 @@ static int usblp_set_protocol(struct usblp *usblp, int protocol)
 	if (protocol < USBLP_FIRST_PROTOCOL || protocol > USBLP_LAST_PROTOCOL)
 		return -EINVAL;
 
+	alts = usblp->protocol[protocol].alt_setting;
+	if (alts < 0)
+		return -EINVAL;
+
 	/* Don't unnecessarily set the interface if there's a single alt. */
 	if (usblp->intf->num_altsetting > 1) {
-		alts = usblp->protocol[protocol].alt_setting;
-		if (alts < 0)
-			return -EINVAL;
 		r = usb_set_interface(usblp->dev, usblp->ifnum, alts);
 		if (r < 0) {
 			printk(KERN_ERR "usblp: can't set desired altsetting %d on interface %d\n",
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 238674fab7ce..686a75c37591 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2592,13 +2592,13 @@ int usb_new_device(struct usb_device *udev)
 		err = sysfs_create_link(&udev->dev.kobj,
 				&port_dev->dev.kobj, "port");
 		if (err)
-			goto fail;
+			goto out_del_dev;
 
 		err = sysfs_create_link(&port_dev->dev.kobj,
 				&udev->dev.kobj, "device");
 		if (err) {
 			sysfs_remove_link(&udev->dev.kobj, "port");
-			goto fail;
+			goto out_del_dev;
 		}
 
 		if (!test_and_set_bit(port1, hub->child_usage_bits))
@@ -2610,6 +2610,8 @@ int usb_new_device(struct usb_device *udev)
 	pm_runtime_put_sync_autosuspend(&udev->dev);
 	return err;
 
+out_del_dev:
+	device_del(&udev->dev);
 fail:
 	usb_set_device_state(udev, USB_STATE_NOTATTACHED);
 	pm_runtime_disable(&udev->dev);
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 86e8585a5512..f01b0103fe12 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -294,10 +294,11 @@ static int usb_port_runtime_suspend(struct device *dev)
 static void usb_port_shutdown(struct device *dev)
 {
 	struct usb_port *port_dev = to_usb_port(dev);
+	struct usb_device *udev = port_dev->child;
 
-	if (port_dev->child) {
-		usb_disable_usb2_hardware_lpm(port_dev->child);
-		usb_unlocked_disable_lpm(port_dev->child);
+	if (udev && !udev->port_is_suspended) {
+		usb_disable_usb2_hardware_lpm(udev);
+		usb_unlocked_disable_lpm(udev);
 	}
 }
 
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 53658162b148..9b5f9d503ff0 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1875,7 +1875,7 @@ static int functionfs_bind(struct ffs_data *ffs, struct usb_composite_dev *cdev)
 
 	ENTER();
 
-	if (WARN_ON(ffs->state != FFS_ACTIVE
+	if ((ffs->state != FFS_ACTIVE
 		 || test_and_set_bit(FFS_FL_BOUND, &ffs->flags)))
 		return -EBADFD;
 
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 5353fa7e5969..39c9d1f857fc 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -224,6 +224,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x19CF, 0x3000) }, /* Parrot NMEA GPS Flight Recorder */
 	{ USB_DEVICE(0x1ADB, 0x0001) }, /* Schweitzer Engineering C662 Cable */
 	{ USB_DEVICE(0x1B1C, 0x1C00) }, /* Corsair USB Dongle */
+	{ USB_DEVICE(0x1B93, 0x1013) }, /* Phoenix Contact UPS Device */
 	{ USB_DEVICE(0x1BA4, 0x0002) },	/* Silicon Labs 358x factory default */
 	{ USB_DEVICE(0x1BE3, 0x07A6) }, /* WAGO 750-923 USB Service Cable */
 	{ USB_DEVICE(0x1D6F, 0x0010) }, /* Seluxit ApS RF Dongle */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 3ae4ac4d9857..79f8e3a043fc 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -621,7 +621,7 @@ static void option_instat_callback(struct urb *urb);
 
 /* MeiG Smart Technology products */
 #define MEIGSMART_VENDOR_ID			0x2dee
-/* MeiG Smart SRM825L based on Qualcomm 315 */
+/* MeiG Smart SRM815/SRM825L based on Qualcomm 315 */
 #define MEIGSMART_PRODUCT_SRM825L		0x4d22
 /* MeiG Smart SLM320 based on UNISOC UIS8910 */
 #define MEIGSMART_PRODUCT_SLM320		0x4d41
@@ -2405,6 +2405,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM320, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM770A, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x60) },
@@ -2412,6 +2413,7 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0640, 0xff),			/* TCL IK512 ECM */
 	  .driver_info = NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x2949, 0x8700, 0xff) },			/* Neoway N723-EA */
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index d172e8642d4a..5501898dfcfb 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -555,7 +555,7 @@ static void qt2_process_read_urb(struct urb *urb)
 
 				newport = *(ch + 3);
 
-				if (newport > serial->num_ports) {
+				if (newport >= serial->num_ports) {
 					dev_err(&port->dev,
 						"%s - port change to invalid port: %i\n",
 						__func__, newport);
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index 606a68bd8059..a6dc2faae85d 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -255,6 +255,13 @@ UNUSUAL_DEV(  0x0421, 0x06aa, 0x1110, 0x1110,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_MAX_SECTORS_64 ),
 
+/* Added by Lubomir Rintel <lkundrak@v3.sk>, a very fine chap */
+UNUSUAL_DEV(  0x0421, 0x06c2, 0x0000, 0x0406,
+		"Nokia",
+		"Nokia 208",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_MAX_SECTORS_64 ),
+
 #ifdef NO_SDDR09
 UNUSUAL_DEV(  0x0436, 0x0005, 0x0100, 0x0100,
 		"Microtech",
diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 46a72fe39719..9165bf6ad018 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -405,6 +405,11 @@ static ssize_t vfio_platform_read_mmio(struct vfio_platform_region *reg,
 {
 	unsigned int done = 0;
 
+	if (off >= reg->size)
+		return -EINVAL;
+
+	count = min_t(size_t, count, reg->size - off);
+
 	if (!reg->ioaddr) {
 		reg->ioaddr =
 			ioremap_nocache(reg->addr, reg->size);
@@ -482,6 +487,11 @@ static ssize_t vfio_platform_write_mmio(struct vfio_platform_region *reg,
 {
 	unsigned int done = 0;
 
+	if (off >= reg->size)
+		return -EINVAL;
+
+	count = min_t(size_t, count, reg->size - off);
+
 	if (!reg->ioaddr) {
 		reg->ioaddr =
 			ioremap_nocache(reg->addr, reg->size);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4d02116193de..44bfa589ed36 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -628,6 +628,7 @@ enum {
  */
 #define EXT4_EX_NOCACHE				0x40000000
 #define EXT4_EX_FORCE_CACHE			0x20000000
+#define EXT4_EX_NOFAIL				0x10000000
 
 /*
  * Flags used by ext4_free_blocks
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0d692025f923..5c0ef7a04169 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -304,11 +304,14 @@ ext4_force_split_extent_at(handle_t *handle, struct inode *inode,
 {
 	struct ext4_ext_path *path = *ppath;
 	int unwritten = ext4_ext_is_unwritten(path[path->p_depth].p_ext);
+	int flags = EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_PRE_IO;
+
+	if (nofail)
+		flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL | EXT4_EX_NOFAIL;
 
 	return ext4_split_extent_at(handle, inode, ppath, lblk, unwritten ?
 			EXT4_EXT_MARK_UNWRIT1|EXT4_EXT_MARK_UNWRIT2 : 0,
-			EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_PRE_IO |
-			(nofail ? EXT4_GET_BLOCKS_METADATA_NOFAIL:0));
+			flags);
 }
 
 /*
@@ -572,9 +575,13 @@ __read_extent_tree_block(const char *function, unsigned int line,
 	struct buffer_head		*bh;
 	int				err;
 	ext4_fsblk_t			pblk;
+	gfp_t                           gfp_flags = __GFP_MOVABLE | GFP_NOFS;
+
+	if (flags & EXT4_EX_NOFAIL)
+		 gfp_flags |= __GFP_NOFAIL;
 
 	pblk = ext4_idx_pblock(idx);
-	bh = sb_getblk_gfp(inode->i_sb, pblk, __GFP_MOVABLE | GFP_NOFS);
+	bh = sb_getblk_gfp(inode->i_sb, pblk, gfp_flags);
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
 
@@ -919,6 +926,10 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	struct ext4_ext_path *path = orig_path ? *orig_path : NULL;
 	short int depth, i, ppos = 0;
 	int ret;
+	gfp_t gfp_flags = GFP_NOFS;
+
+	if (flags & EXT4_EX_NOFAIL)
+		gfp_flags |= __GFP_NOFAIL;
 
 	eh = ext_inode_hdr(inode);
 	depth = ext_depth(inode);
@@ -939,7 +950,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	if (!path) {
 		/* account possible depth increase */
 		path = kcalloc(depth + 2, sizeof(struct ext4_ext_path),
-				GFP_NOFS);
+				gfp_flags);
 		if (unlikely(!path))
 			return ERR_PTR(-ENOMEM);
 		path[0].p_maxdepth = depth + 1;
@@ -1088,9 +1099,13 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 	ext4_fsblk_t newblock, oldblock;
 	__le32 border;
 	ext4_fsblk_t *ablocks = NULL; /* array of allocated blocks */
+	gfp_t gfp_flags = GFP_NOFS;
 	int err = 0;
 	size_t ext_size = 0;
 
+	if (flags & EXT4_EX_NOFAIL)
+		gfp_flags |= __GFP_NOFAIL;
+
 	/* make decision: where to split? */
 	/* FIXME: now decision is simplest: at current extent */
 
@@ -1124,7 +1139,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 	 * We need this to handle errors and free blocks
 	 * upon them.
 	 */
-	ablocks = kcalloc(depth, sizeof(ext4_fsblk_t), GFP_NOFS);
+	ablocks = kcalloc(depth, sizeof(ext4_fsblk_t), gfp_flags);
 	if (!ablocks)
 		return -ENOMEM;
 
@@ -2110,7 +2125,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	if (next != EXT_MAX_BLOCKS) {
 		ext_debug("next leaf block - %u\n", next);
 		BUG_ON(npath != NULL);
-		npath = ext4_find_extent(inode, next, NULL, 0);
+		npath = ext4_find_extent(inode, next, NULL, gb_flags);
 		if (IS_ERR(npath))
 			return PTR_ERR(npath);
 		BUG_ON(npath->p_depth != path->p_depth);
@@ -3018,7 +3033,8 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		ext4_fsblk_t pblk;
 
 		/* find extent for or closest extent to this block */
-		path = ext4_find_extent(inode, end, NULL, EXT4_EX_NOCACHE);
+		path = ext4_find_extent(inode, end, NULL,
+					EXT4_EX_NOCACHE | EXT4_EX_NOFAIL);
 		if (IS_ERR(path)) {
 			ext4_journal_stop(handle);
 			return PTR_ERR(path);
@@ -3104,7 +3120,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 				le16_to_cpu(path[k].p_hdr->eh_entries)+1;
 	} else {
 		path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
-			       GFP_NOFS);
+			       GFP_NOFS | __GFP_NOFAIL);
 		if (path == NULL) {
 			ext4_journal_stop(handle);
 			return -ENOMEM;
@@ -3424,6 +3440,25 @@ static int ext4_split_extent_at(handle_t *handle,
 	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
 		goto out;
 
+	/*
+	 * Update path is required because previous ext4_ext_insert_extent()
+	 * may have freed or reallocated the path. Using EXT4_EX_NOFAIL
+	 * guarantees that ext4_find_extent() will not return -ENOMEM,
+	 * otherwise -ENOMEM will cause a retry in do_writepages(), and a
+	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
+	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
+	 */
+	path = ext4_find_extent(inode, ee_block, ppath,
+				flags | EXT4_EX_NOFAIL);
+	if (IS_ERR(path)) {
+		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
+				 split, PTR_ERR(path));
+		return PTR_ERR(path);
+	}
+	depth = ext_depth(inode);
+	ex = path[depth].p_ext;
+	*ppath = path;
+
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
 		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
 			if (split_flag & EXT4_EXT_DATA_VALID1) {
@@ -3472,7 +3507,7 @@ static int ext4_split_extent_at(handle_t *handle,
 	ext4_ext_dirty(handle, inode, path + path->p_depth);
 	return err;
 out:
-	ext4_ext_show_leaf(inode, path);
+	ext4_ext_show_leaf(inode, *ppath);
 	return err;
 }
 
@@ -3528,7 +3563,7 @@ static int ext4_split_extent(handle_t *handle,
 	 * Update path is required because previous ext4_split_extent_at() may
 	 * result in split of original leaf or extent zeroout.
 	 */
-	path = ext4_find_extent(inode, map->m_lblk, ppath, 0);
+	path = ext4_find_extent(inode, map->m_lblk, ppath, flags);
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 	depth = ext_depth(inode);
@@ -4650,7 +4685,14 @@ int ext4_ext_truncate(handle_t *handle, struct inode *inode)
 	}
 	if (err)
 		return err;
-	return ext4_ext_remove_space(inode, last_block, EXT_MAX_BLOCKS - 1);
+retry_remove_space:
+	err = ext4_ext_remove_space(inode, last_block, EXT_MAX_BLOCKS - 1);
+	if (err == -ENOMEM) {
+		cond_resched();
+		congestion_wait(BLK_RW_ASYNC, HZ/50);
+		goto retry_remove_space;
+	}
+	return err;
 }
 
 static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 69c52edf5713..22c1b29c0551 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -271,6 +271,7 @@ static int do_gfs2_set_flags(struct file *filp, u32 reqflags, u32 mask,
 		error = filemap_fdatawait(inode->i_mapping);
 		if (error)
 			goto out;
+		truncate_inode_pages(inode->i_mapping, 0);
 		if (new_flags & GFS2_DIF_JDATA)
 			gfs2_ordered_del_inode(ip);
 	}
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index bcf820ce0e02..f82444fbbedc 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -419,11 +419,13 @@ static int hfs_fill_super(struct super_block *sb, void *data, int silent)
 		goto bail_no_root;
 	res = hfs_cat_find_brec(sb, HFS_ROOT_CNID, &fd);
 	if (!res) {
-		if (fd.entrylength > sizeof(rec) || fd.entrylength < 0) {
+		if (fd.entrylength != sizeof(rec.dir)) {
 			res =  -EIO;
 			goto bail_hfs_find;
 		}
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
+		if (rec.type != HFS_CDR_DIR)
+			res = -EIO;
 	}
 	if (res)
 		goto bail_hfs_find;
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 255026497b8c..8c435c11664d 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -770,9 +770,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	/* 
 	 * If the journal is not located on the file system device,
 	 * then we must flush the file system device before we issue
-	 * the commit record
+	 * the commit record and update the journal tail sequence.
 	 */
-	if (commit_transaction->t_need_data_flush &&
+	if ((commit_transaction->t_need_data_flush || update_tail) &&
 	    (journal->j_fs_dev != journal->j_dev) &&
 	    (journal->j_flags & JBD2_BARRIER))
 		blkdev_issue_flush(journal->j_fs_dev, GFP_NOFS, NULL);
diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index eda83487c9ec..1ce3780e8b49 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -881,7 +881,7 @@ static int ocfs2_get_next_id(struct super_block *sb, struct kqid *qid)
 	int status = 0;
 
 	trace_ocfs2_get_next_id(from_kqid(&init_user_ns, *qid), type);
-	if (!sb_has_quota_loaded(sb, type)) {
+	if (!sb_has_quota_active(sb, type)) {
 		status = -ESRCH;
 		goto out;
 	}
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 7a1c8da9e44b..77d5aa90338f 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -815,7 +815,7 @@ static int ocfs2_local_free_info(struct super_block *sb, int type)
 	struct ocfs2_quota_chunk *chunk;
 	struct ocfs2_local_disk_chunk *dchunk;
 	int mark_clean = 1, len;
-	int status;
+	int status = 0;
 
 	iput(oinfo->dqi_gqinode);
 	ocfs2_simple_drop_lockres(OCFS2_SB(sb), &oinfo->dqi_gqlock);
@@ -857,17 +857,15 @@ static int ocfs2_local_free_info(struct super_block *sb, int type)
 				 oinfo->dqi_libh,
 				 olq_update_info,
 				 info);
-	if (status < 0) {
+	if (status < 0)
 		mlog_errno(status);
-		goto out;
-	}
-
 out:
 	ocfs2_inode_unlock(sb_dqopt(sb)->files[type], 1);
 	brelse(oinfo->dqi_libh);
 	brelse(oinfo->dqi_lqi_bh);
 	kfree(oinfo);
-	return 0;
+	info->dqi_priv = NULL;
+	return status;
 }
 
 static void olq_set_dquot(struct buffer_head *bh, void *private)
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 0ff2f1ddf9ef..fc70107740ab 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -397,6 +397,8 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 			if (buflen == 0)
 				return acc;
 		}
+
+		cond_resched();
 	}
 
 	return acc;
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 7bbcb64eeecf..79b8cb62ce81 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -527,6 +527,7 @@ extern void __init hrtimers_init(void);
 extern void sysrq_timer_list_show(void);
 
 int hrtimers_prepare_cpu(unsigned int cpu);
+int hrtimers_cpu_starting(unsigned int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
 int hrtimers_cpu_dying(unsigned int cpu);
 #else
diff --git a/include/linux/poll.h b/include/linux/poll.h
index 7e0fdcf905d2..a4af5e14dffe 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -43,8 +43,16 @@ typedef struct poll_table_struct {
 
 static inline void poll_wait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
 {
-	if (p && p->_qproc && wait_address)
+	if (p && p->_qproc && wait_address) {
 		p->_qproc(filp, wait_address, p);
+		/*
+		 * This memory barrier is paired in the wq_has_sleeper().
+		 * See the comment above prepare_to_wait(), we need to
+		 * ensure that subsequent tests in this thread can't be
+		 * reordered with __add_wait_queue() in _qproc() paths.
+		 */
+		smp_mb();
+	}
 }
 
 /*
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 7c0e7efbc8f2..ffc16257899f 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -699,13 +699,12 @@ struct usb_device {
 
 	unsigned long active_duration;
 
-#ifdef CONFIG_PM
 	unsigned long connect_time;
 
 	unsigned do_remote_wakeup:1;
 	unsigned reset_resume:1;
 	unsigned port_is_suspended:1;
-#endif
+
 	struct wusb_dev *wusb_dev;
 	int slot_id;
 	enum usb_device_removable removable;
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 0cfd540e7d06..a57e023755aa 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -488,9 +488,7 @@ extern void usb_hcd_pci_shutdown(struct pci_dev *dev);
 
 extern int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *dev);
 
-#ifdef CONFIG_PM
 extern const struct dev_pm_ops usb_hcd_pci_pm_ops;
-#endif
 #endif /* CONFIG_USB_PCI */
 
 /* pci-ish (pdev null is ok) buffer alloc/mapping support */
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 180ff3ca823a..05f07bf60c89 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -285,7 +285,7 @@ static inline int inet_csk_reqsk_queue_len(const struct sock *sk)
 
 static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
 {
-	return inet_csk_reqsk_queue_len(sk) >= sk->sk_max_ack_backlog;
+	return inet_csk_reqsk_queue_len(sk) > READ_ONCE(sk->sk_max_ack_backlog);
 }
 
 bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req);
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 167e390ac9d4..0d61b452b908 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -382,6 +382,9 @@ struct pernet_operations {
 	void (*pre_exit)(struct net *net);
 	void (*exit)(struct net *net);
 	void (*exit_batch)(struct list_head *net_exit_list);
+	/* Following method is called with RTNL held. */
+	void (*exit_batch_rtnl)(struct list_head *net_exit_list,
+				struct list_head *dev_kill_list);
 	unsigned int *id;
 	size_t size;
 };
diff --git a/kernel/cpu.c b/kernel/cpu.c
index ba579bb6b897..5602936d9a9a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1542,7 +1542,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	},
 	[CPUHP_AP_HRTIMERS_DYING] = {
 		.name			= "hrtimers:dying",
-		.startup.single		= NULL,
+		.startup.single		= hrtimers_cpu_starting,
 		.teardown.single	= hrtimers_cpu_dying,
 	},
 
diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 206ab3d41ee7..7fc44d8da205 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -84,6 +84,7 @@ find $cpio_dir -type f -print0 |
 
 # Create archive and try to normalize metadata for reproducibility.
 tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
+    --exclude=".__afs*" --exclude=".nfs*" \
     --owner=0 --group=0 --sort=name --numeric-owner --mode=u=rw,go=r,a+X \
     -I $XZ -cf $tarfile -C $cpio_dir/ . > /dev/null
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2e4f136bdf6a..539bc80787ee 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2065,6 +2065,15 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	}
 
 	cpu_base->cpu = cpu;
+	hrtimer_cpu_base_init_expiry_lock(cpu_base);
+	return 0;
+}
+
+int hrtimers_cpu_starting(unsigned int cpu)
+{
+	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
+
+	/* Clear out any left over state from a CPU down operation */
 	cpu_base->active_bases = 0;
 	cpu_base->hres_active = 0;
 	cpu_base->hang_detected = 0;
@@ -2073,7 +2082,6 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
 	cpu_base->online = 1;
-	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
 
@@ -2151,6 +2159,7 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 void __init hrtimers_init(void)
 {
 	hrtimers_prepare_cpu(smp_processor_id());
+	hrtimers_cpu_starting(smp_processor_id());
 	open_softirq(HRTIMER_SOFTIRQ, hrtimer_run_softirq);
 }
 
diff --git a/net/802/psnap.c b/net/802/psnap.c
index 40ab2aea7b31..7431ec077273 100644
--- a/net/802/psnap.c
+++ b/net/802/psnap.c
@@ -55,11 +55,11 @@ static int snap_rcv(struct sk_buff *skb, struct net_device *dev,
 		goto drop;
 
 	rcu_read_lock();
-	proto = find_snap_client(skb_transport_header(skb));
+	proto = find_snap_client(skb->data);
 	if (proto) {
 		/* Pass the frame on. */
-		skb->transport_header += 5;
 		skb_pull_rcsum(skb, 5);
+		skb_reset_transport_header(skb);
 		rc = proto->rcvfunc(skb, dev, &snap_packet_type, orig_dev);
 	}
 	rcu_read_unlock();
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index c94179d30d42..e6585a758edd 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -98,7 +98,7 @@ static int net_assign_generic(struct net *net, unsigned int id, void *data)
 	}
 
 	ng = net_alloc_generic();
-	if (ng == NULL)
+	if (!ng)
 		return -ENOMEM;
 
 	/*
@@ -155,13 +155,6 @@ static int ops_init(const struct pernet_operations *ops, struct net *net)
 	return err;
 }
 
-static void ops_free(const struct pernet_operations *ops, struct net *net)
-{
-	if (ops->id && ops->size) {
-		kfree(net_generic(net, *ops->id));
-	}
-}
-
 static void ops_pre_exit_list(const struct pernet_operations *ops,
 			      struct list_head *net_exit_list)
 {
@@ -193,7 +186,7 @@ static void ops_free_list(const struct pernet_operations *ops,
 	struct net *net;
 	if (ops->size && ops->id) {
 		list_for_each_entry(net, net_exit_list, exit_list)
-			ops_free(ops, net);
+			kfree(net_generic(net, *ops->id));
 	}
 }
 
@@ -332,8 +325,9 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 {
 	/* Must be called with pernet_ops_rwsem held */
 	const struct pernet_operations *ops, *saved_ops;
-	int error = 0;
 	LIST_HEAD(net_exit_list);
+	LIST_HEAD(dev_kill_list);
+	int error = 0;
 
 	refcount_set(&net->count, 1);
 	refcount_set(&net->passive, 1);
@@ -366,6 +360,15 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 
 	synchronize_rcu();
 
+	ops = saved_ops;
+	rtnl_lock();
+	list_for_each_entry_continue_reverse(ops, &pernet_list, list) {
+		if (ops->exit_batch_rtnl)
+			ops->exit_batch_rtnl(&net_exit_list, &dev_kill_list);
+	}
+	unregister_netdevice_many(&dev_kill_list);
+	rtnl_unlock();
+
 	ops = saved_ops;
 	list_for_each_entry_continue_reverse(ops, &pernet_list, list)
 		ops_exit_list(ops, &net_exit_list);
@@ -448,15 +451,18 @@ static struct net *net_alloc(void)
 
 static void net_free(struct net *net)
 {
-	kfree(rcu_access_pointer(net->gen));
-	kmem_cache_free(net_cachep, net);
+	if (refcount_dec_and_test(&net->passive)) {
+		kfree(rcu_access_pointer(net->gen));
+		kmem_cache_free(net_cachep, net);
+	}
 }
 
 void net_drop_ns(void *p)
 {
-	struct net *ns = p;
-	if (ns && refcount_dec_and_test(&ns->passive))
-		net_free(ns);
+	struct net *net = (struct net *)p;
+
+	if (net)
+		net_free(net);
 }
 
 struct net *copy_net_ns(unsigned long flags,
@@ -496,7 +502,7 @@ struct net *copy_net_ns(unsigned long flags,
 		key_remove_domain(net->key_domain);
 #endif
 		put_user_ns(user_ns);
-		net_drop_ns(net);
+		net_free(net);
 dec_ucounts:
 		dec_net_namespaces(ucounts);
 		return ERR_PTR(rv);
@@ -567,6 +573,7 @@ static void cleanup_net(struct work_struct *work)
 	struct net *net, *tmp, *last;
 	struct llist_node *net_kill_list;
 	LIST_HEAD(net_exit_list);
+	LIST_HEAD(dev_kill_list);
 
 	/* Atomically snapshot the list of namespaces to cleanup */
 	net_kill_list = llist_del_all(&cleanup_list);
@@ -607,6 +614,14 @@ static void cleanup_net(struct work_struct *work)
 	 */
 	synchronize_rcu();
 
+	rtnl_lock();
+	list_for_each_entry_reverse(ops, &pernet_list, list) {
+		if (ops->exit_batch_rtnl)
+			ops->exit_batch_rtnl(&net_exit_list, &dev_kill_list);
+	}
+	unregister_netdevice_many(&dev_kill_list);
+	rtnl_unlock();
+
 	/* Run all of the network namespace exit methods */
 	list_for_each_entry_reverse(ops, &pernet_list, list)
 		ops_exit_list(ops, &net_exit_list);
@@ -630,7 +645,7 @@ static void cleanup_net(struct work_struct *work)
 		key_remove_domain(net->key_domain);
 #endif
 		put_user_ns(net->user_ns);
-		net_drop_ns(net);
+		net_free(net);
 	}
 }
 
@@ -1150,6 +1165,24 @@ static int __init net_ns_init(void)
 
 pure_initcall(net_ns_init);
 
+static void free_exit_list(struct pernet_operations *ops, struct list_head *net_exit_list)
+{
+	ops_pre_exit_list(ops, net_exit_list);
+	synchronize_rcu();
+
+	if (ops->exit_batch_rtnl) {
+		LIST_HEAD(dev_kill_list);
+
+		rtnl_lock();
+		ops->exit_batch_rtnl(net_exit_list, &dev_kill_list);
+		unregister_netdevice_many(&dev_kill_list);
+		rtnl_unlock();
+	}
+	ops_exit_list(ops, net_exit_list);
+
+	ops_free_list(ops, net_exit_list);
+}
+
 #ifdef CONFIG_NET_NS
 static int __register_pernet_operations(struct list_head *list,
 					struct pernet_operations *ops)
@@ -1175,10 +1208,7 @@ static int __register_pernet_operations(struct list_head *list,
 out_undo:
 	/* If I have an error cleanup all namespaces I initialized */
 	list_del(&ops->list);
-	ops_pre_exit_list(ops, &net_exit_list);
-	synchronize_rcu();
-	ops_exit_list(ops, &net_exit_list);
-	ops_free_list(ops, &net_exit_list);
+	free_exit_list(ops, &net_exit_list);
 	return error;
 }
 
@@ -1191,10 +1221,8 @@ static void __unregister_pernet_operations(struct pernet_operations *ops)
 	/* See comment in __register_pernet_operations() */
 	for_each_net(net)
 		list_add_tail(&net->exit_list, &net_exit_list);
-	ops_pre_exit_list(ops, &net_exit_list);
-	synchronize_rcu();
-	ops_exit_list(ops, &net_exit_list);
-	ops_free_list(ops, &net_exit_list);
+
+	free_exit_list(ops, &net_exit_list);
 }
 
 #else
@@ -1217,10 +1245,7 @@ static void __unregister_pernet_operations(struct pernet_operations *ops)
 	} else {
 		LIST_HEAD(net_exit_list);
 		list_add(&init_net.exit_list, &net_exit_list);
-		ops_pre_exit_list(ops, &net_exit_list);
-		synchronize_rcu();
-		ops_exit_list(ops, &net_exit_list);
-		ops_free_list(ops, &net_exit_list);
+		free_exit_list(ops, &net_exit_list);
 	}
 }
 
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index c3a378ef95aa..cbefbe6d07ae 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -602,7 +602,7 @@ static int dccp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	   by tcp. Feel free to propose better solution.
 					       --ANK (980728)
 	 */
-	if (np->rxopt.all)
+	if (np->rxopt.all && sk->sk_state != DCCP_LISTEN)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
 	if (sk->sk_state == DCCP_OPEN) { /* Fast path */
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index f1c2ac967e36..364abcf4b6c1 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -173,7 +173,7 @@ static void rt6_uncached_list_flush_dev(struct net *net, struct net_device *dev)
 			struct inet6_dev *rt_idev = rt->rt6i_idev;
 			struct net_device *rt_dev = rt->dst.dev;
 
-			if (rt_idev->dev == dev) {
+			if (rt_idev && rt_idev->dev == dev) {
 				rt->rt6i_idev = in6_dev_get(loopback_dev);
 				in6_dev_put(rt_idev);
 			}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 8be41d6c4278..8ed5b5dd6ba4 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1393,7 +1393,7 @@ static int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	   by tcp. Feel free to propose better solution.
 					       --ANK (980728)
 	 */
-	if (np->rxopt.all)
+	if (np->rxopt.all && sk->sk_state != TCP_LISTEN)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
@@ -1430,8 +1430,6 @@ static int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 		if (nsk != sk) {
 			if (tcp_child_process(sk, nsk, skb))
 				goto reset;
-			if (opt_skb)
-				__kfree_skb(opt_skb);
 			return 0;
 		}
 	} else
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index a08240fe68a7..22514ab060f8 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -688,6 +688,10 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 	ASSERT_RTNL();
 
 	mutex_lock(&sdata->local->iflist_mtx);
+	if (list_empty(&sdata->local->interfaces)) {
+		mutex_unlock(&sdata->local->iflist_mtx);
+		return;
+	}
 	list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
 
diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index 87398af2715a..117c7b038591 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -354,7 +354,8 @@ static const struct nla_policy flow_policy[TCA_FLOW_MAX + 1] = {
 	[TCA_FLOW_KEYS]		= { .type = NLA_U32 },
 	[TCA_FLOW_MODE]		= { .type = NLA_U32 },
 	[TCA_FLOW_BASECLASS]	= { .type = NLA_U32 },
-	[TCA_FLOW_RSHIFT]	= { .type = NLA_U32 },
+	[TCA_FLOW_RSHIFT]	= NLA_POLICY_MAX(NLA_U32,
+						 31 /* BITS_PER_U32 - 1 */),
 	[TCA_FLOW_ADDEND]	= { .type = NLA_U32 },
 	[TCA_FLOW_MASK]		= { .type = NLA_U32 },
 	[TCA_FLOW_XOR]		= { .type = NLA_U32 },
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 238cf1737576..7777c0096a38 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -326,7 +326,7 @@ static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
 				void __user *buffer, size_t *lenp,
 				loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.auth_enable);
 	struct ctl_table tbl;
 	bool changed = false;
 	char *none = "none";
@@ -372,7 +372,7 @@ static int proc_sctp_do_rto_min(struct ctl_table *ctl, int write,
 				void __user *buffer, size_t *lenp,
 				loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.rto_min);
 	unsigned int min = *(unsigned int *) ctl->extra1;
 	unsigned int max = *(unsigned int *) ctl->extra2;
 	struct ctl_table tbl;
@@ -401,7 +401,7 @@ static int proc_sctp_do_rto_max(struct ctl_table *ctl, int write,
 				void __user *buffer, size_t *lenp,
 				loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.rto_max);
 	unsigned int min = *(unsigned int *) ctl->extra1;
 	unsigned int max = *(unsigned int *) ctl->extra2;
 	struct ctl_table tbl;
@@ -441,7 +441,8 @@ static int proc_sctp_do_auth(struct ctl_table *ctl, int write,
 			     void __user *buffer, size_t *lenp,
 			     loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net,
+				       sctp.sctp_hmac_alg);
 	struct ctl_table tbl;
 	int new_value, ret;
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 910da98d6bfb..03f608da594e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -425,7 +425,7 @@ int tls_tx_records(struct sock *sk, int flags)
 
 tx_err:
 	if (rc < 0 && rc != -EAGAIN)
-		tls_err_abort(sk, -EBADMSG);
+		tls_err_abort(sk, rc);
 
 	return rc;
 }
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index dfc536cd9d2f..7b03ff158d78 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1400,6 +1400,7 @@ config SND_SOC_WM8993
 
 config SND_SOC_WM8994
 	tristate
+	depends on MFD_WM8994
 
 config SND_SOC_WM8995
 	tristate

