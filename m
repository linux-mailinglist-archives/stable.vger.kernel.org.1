Return-Path: <stable+bounces-187898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6252DBEE740
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 16:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35ED4021B5
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404CE2EB5A4;
	Sun, 19 Oct 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eo+1Uu/9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3162E889C;
	Sun, 19 Oct 2025 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760884703; cv=none; b=m3Rfku5Ot+DRvTGJqGP9R1C+hgftCf2KFnoOgjfcQwaOMl9wuii8CAQ0VVgp8w+6Zx9UqRd3bMCQVBePIvOvtCZ8KzWQbBUJM8lZNBMRIWNDn5PUtWq3v/w5ATtmXvG7CctlpO+z7ufWnYbF5phxpJ0h1xb0RiteF1C+tQoJB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760884703; c=relaxed/simple;
	bh=JJn7jLgotLjqLhO/UGMNLVHYrdCsOhEmhRf+9JNbEO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGNX8nInGangJbPXoQLJzqq5F7h+eLzEJhJSHvJ8Cp1PSMnHyz04TEWXcoexGoQwjRlMncqYhHSJXviBbcnN11cXL3oln+6QXbXACZmeAFMgQckOt0ECNiHLqlQ0C4TR99C3K8zQkEtIFyk6RCVQ/pUMtUi3m+XBOLIk8zGJx8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eo+1Uu/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036D7C4CEE7;
	Sun, 19 Oct 2025 14:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760884703;
	bh=JJn7jLgotLjqLhO/UGMNLVHYrdCsOhEmhRf+9JNbEO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eo+1Uu/9+F1GDPNyf67IwTHG3aXY/OmIzqNpp5RnaI3vF1si0GDSTWA7W4KifuIwS
	 RX9ruA4jTcpBSe1X9U2DNXOEIYdJaGrFjA0GVa3XkFIfvO2D5sPtzC/5GTLoM8Skhi
	 UpvSZfGmOmJefzK162t9CgDyAGdaGhhVh564hGsc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.195
Date: Sun, 19 Oct 2025 16:38:10 +0200
Message-ID: <2025101910-gopher-cardiac-dfe9@gregkh>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <2025101910-granny-unclamped-7b6b@gregkh>
References: <2025101910-granny-unclamped-7b6b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 25e07ac5c1ca..ae09a6c701f0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5148,6 +5148,9 @@
 
 	rootflags=	[KNL] Set root filesystem mount option string
 
+	initramfs_options= [KNL]
+                        Specify mount options for for the initramfs mount.
+
 	rootfstype=	[KNL] Set root filesystem type
 
 	rootwait	[KNL] Wait (indefinitely) for root device to show up.
diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 67de1e94fdf7..f31a838d09fb 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -635,6 +635,17 @@ See drivers/gpu/drm/amd/display/TODO for tasks.
 
 Contact: Harry Wentland, Alex Deucher
 
+vmwgfx: Replace hashtable with Linux' implementation
+----------------------------------------------------
+
+The vmwgfx driver uses its own hashtable implementation. Replace the
+code with Linux' implementation and update the callers. It's mostly a
+refactoring task, but the interfaces are different.
+
+Contact: Zack Rusin, Thomas Zimmermann <tzimmermann@suse.de>
+
+Level: Intermediate
+
 Bootsplash
 ==========
 
diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index 088c8cce738b..6e0d1a48bd50 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -380,7 +380,9 @@ entry, ts0, corresponding to the ts0 variable in the sched_waking
 trigger above.
 
 sched_waking histogram
-----------------------::
+----------------------
+
+.. code-block::
 
   +------------------+
   | hist_data        |<-------------------------------------------------------+
diff --git a/Makefile b/Makefile
index e3cf330f4832..b271b95873cf 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 194
+SUBLEVEL = 195
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 2f0a370a1309..60f9d6f5f822 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -868,7 +868,7 @@ e_done:
 /**
  * at91_mckx_ps_restore: restore MCK1..4 settings
  *
- * Side effects: overwrites tmp1, tmp2
+ * Side effects: overwrites tmp1, tmp2 and tmp3
  */
 .macro at91_mckx_ps_restore
 #ifdef CONFIG_SOC_SAMA7
@@ -912,7 +912,7 @@ r_ps:
 	bic	tmp3, tmp3, #AT91_PMC_MCR_V2_ID_MSK
 	orr	tmp3, tmp3, tmp1
 	orr	tmp3, tmp3, #AT91_PMC_MCR_V2_CMD
-	str	tmp2, [pmc, #AT91_PMC_MCR_V2]
+	str	tmp3, [pmc, #AT91_PMC_MCR_V2]
 
 	wait_mckrdy tmp1
 
diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index bf0d25fd2cea..58b98a17746c 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -393,12 +393,15 @@ static int __init amx3_idle_init(struct device_node *cpu_node, int cpu)
 		if (!state_node)
 			break;
 
-		if (!of_device_is_available(state_node))
+		if (!of_device_is_available(state_node)) {
+			of_node_put(state_node);
 			continue;
+		}
 
 		if (i == CPUIDLE_STATE_MAX) {
 			pr_warn("%s: cpuidle states reached max possible\n",
 				__func__);
+			of_node_put(state_node);
 			break;
 		}
 
@@ -408,6 +411,7 @@ static int __init amx3_idle_init(struct device_node *cpu_node, int cpu)
 			states[state_count].wfi_flags |= WFI_FLAG_WAKE_M3 |
 							 WFI_FLAG_FLUSH_CACHE;
 
+		of_node_put(state_node);
 		state_count++;
 	}
 
diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
index 9790ae3a8c68..3b3bfa825fad 100644
--- a/arch/arm/mm/pageattr.c
+++ b/arch/arm/mm/pageattr.c
@@ -25,7 +25,7 @@ static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
 	return 0;
 }
 
-static bool in_range(unsigned long start, unsigned long size,
+static bool range_in_range(unsigned long start, unsigned long size,
 	unsigned long range_start, unsigned long range_end)
 {
 	return start >= range_start && start < range_end &&
@@ -46,8 +46,8 @@ static int change_memory_common(unsigned long addr, int numpages,
 	if (!size)
 		return 0;
 
-	if (!in_range(start, size, MODULES_VADDR, MODULES_END) &&
-	    !in_range(start, size, VMALLOC_START, VMALLOC_END))
+	if (!range_in_range(start, size, MODULES_VADDR, MODULES_END) &&
+	    !range_in_range(start, size, VMALLOC_START, VMALLOC_END))
 		return -EINVAL;
 
 	data.set_mask = set_mask;
diff --git a/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
index cce642c53812..3d3db33a64dc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
@@ -11,7 +11,7 @@
 
 / {
 	model = "Pumpkin MT8516";
-	compatible = "mediatek,mt8516";
+	compatible = "mediatek,mt8516-pumpkin", "mediatek,mt8516";
 
 	memory@40000000 {
 		device_type = "memory";
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 79d5f1433800..da053ff698a5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -957,6 +957,8 @@ mdss: mdss@1a00000 {
 
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 
+			resets = <&gcc GCC_MDSS_BCR>;
+
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 69212445d22c..c00b5712959d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4839,11 +4839,11 @@ slimbam: dma-controller@17184000 {
 			compatible = "qcom,bam-v1.7.0";
 			qcom,controlled-remotely;
 			reg = <0 0x17184000 0 0x2a000>;
-			num-channels  = <31>;
+			num-channels = <23>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <1>;
-			qcom,num-ees = <2>;
+			qcom,num-ees = <4>;
 			iommus = <&apps_smmu 0x1806 0x0>;
 		};
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e9d1e429456f..a2518ccc5e98 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1948,16 +1948,22 @@ static void bti_enable(const struct arm64_cpu_capabilities *__unused)
 #ifdef CONFIG_ARM64_MTE
 static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 {
+	static bool cleared_zero_page = false;
+
 	sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_ATA | SCTLR_EL1_ATA0);
 
 	mte_cpu_setup();
 
 	/*
 	 * Clear the tags in the zero page. This needs to be done via the
-	 * linear map which has the Tagged attribute.
+	 * linear map which has the Tagged attribute. Since this page is
+	 * always mapped as pte_special(), set_pte_at() will not attempt to
+	 * clear the tags or set PG_mte_tagged.
 	 */
-	if (!test_and_set_bit(PG_mte_tagged, &ZERO_PAGE(0)->flags))
+	if (!cleared_zero_page) {
+		cleared_zero_page = true;
 		mte_clear_page_tags(lm_alias(empty_zero_page));
+	}
 
 	kasan_init_hw_tags_cpu();
 }
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index fc51cdd5aaa7..db1ed940a6dc 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1300,13 +1300,17 @@ static void fpsimd_flush_cpu_state(void)
  */
 void fpsimd_save_and_flush_cpu_state(void)
 {
+	unsigned long flags;
+
 	if (!system_supports_fpsimd())
 		return;
 	WARN_ON(preemptible());
-	get_cpu_fpsimd_context();
+	local_irq_save(flags);
+	__get_cpu_fpsimd_context();
 	fpsimd_save();
 	fpsimd_flush_cpu_state();
-	put_cpu_fpsimd_context();
+	__put_cpu_fpsimd_context();
+	local_irq_restore(flags);
 }
 
 #ifdef CONFIG_KERNEL_MODE_NEON
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index a3898bac5ae6..7f77fedb0901 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -370,7 +370,8 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 			put_page(page);
 			break;
 		}
-		WARN_ON_ONCE(!test_bit(PG_mte_tagged, &page->flags));
+		WARN_ON_ONCE(!test_bit(PG_mte_tagged, &page->flags) &&
+			     !is_zero_pfn(page_to_pfn(page)));
 
 		/* limit access to the end of the page */
 		offset = offset_in_page(addr);
diff --git a/arch/parisc/include/uapi/asm/ioctls.h b/arch/parisc/include/uapi/asm/ioctls.h
index 82d1148c6379..74b4027a4e80 100644
--- a/arch/parisc/include/uapi/asm/ioctls.h
+++ b/arch/parisc/include/uapi/asm/ioctls.h
@@ -10,10 +10,10 @@
 #define TCSETS		_IOW('T', 17, struct termios) /* TCSETATTR */
 #define TCSETSW		_IOW('T', 18, struct termios) /* TCSETATTRD */
 #define TCSETSF		_IOW('T', 19, struct termios) /* TCSETATTRF */
-#define TCGETA		_IOR('T', 1, struct termio)
-#define TCSETA		_IOW('T', 2, struct termio)
-#define TCSETAW		_IOW('T', 3, struct termio)
-#define TCSETAF		_IOW('T', 4, struct termio)
+#define TCGETA          0x40125401
+#define TCSETA          0x80125402
+#define TCSETAW         0x80125403
+#define TCSETAF         0x80125404
 #define TCSBRK		_IO('T', 5)
 #define TCXONC		_IO('T', 6)
 #define TCFLSH		_IO('T', 7)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8cf9e9f29763..d83a6578b0c4 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2243,7 +2243,7 @@ static int pnv_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	return 0;
 
 out:
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 	msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq, nr_irqs);
 	return ret;
 }
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 2017fd30a477..23e75773fc4b 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -607,7 +607,7 @@ static int pseries_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 
 out:
 	/* TODO: handle RTAS cleanup in ->msi_finish() ? */
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 	return ret;
 }
 
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 4ebf51e6e78e..b06b92c9a375 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -387,6 +387,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 
 	if (of_device_register(op)) {
 		printk("%pOF: Could not register of device.\n", dp);
+		put_device(&op->dev);
 		kfree(op);
 		op = NULL;
 	}
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 5a9f86b1d4e7..6e616bd5cc46 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -680,6 +680,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 
 	if (of_device_register(op)) {
 		printk("%pOF: Could not register of device.\n", dp);
+		put_device(&op->dev);
 		kfree(op);
 		op = NULL;
 	}
diff --git a/arch/sparc/lib/M7memcpy.S b/arch/sparc/lib/M7memcpy.S
index cbd42ea7c3f7..99357bfa8e82 100644
--- a/arch/sparc/lib/M7memcpy.S
+++ b/arch/sparc/lib/M7memcpy.S
@@ -696,16 +696,16 @@ FUNC_NAME:
 	EX_LD_FP(LOAD(ldd, %o4+40, %f26), memcpy_retl_o2_plus_o5_plus_40)
 	faligndata %f24, %f26, %f10
 	EX_ST_FP(STORE(std, %f6, %o0+24), memcpy_retl_o2_plus_o5_plus_40)
-	EX_LD_FP(LOAD(ldd, %o4+48, %f28), memcpy_retl_o2_plus_o5_plus_40)
+	EX_LD_FP(LOAD(ldd, %o4+48, %f28), memcpy_retl_o2_plus_o5_plus_32)
 	faligndata %f26, %f28, %f12
-	EX_ST_FP(STORE(std, %f8, %o0+32), memcpy_retl_o2_plus_o5_plus_40)
+	EX_ST_FP(STORE(std, %f8, %o0+32), memcpy_retl_o2_plus_o5_plus_32)
 	add	%o4, 64, %o4
-	EX_LD_FP(LOAD(ldd, %o4-8, %f30), memcpy_retl_o2_plus_o5_plus_40)
+	EX_LD_FP(LOAD(ldd, %o4-8, %f30), memcpy_retl_o2_plus_o5_plus_24)
 	faligndata %f28, %f30, %f14
-	EX_ST_FP(STORE(std, %f10, %o0+40), memcpy_retl_o2_plus_o5_plus_40)
-	EX_ST_FP(STORE(std, %f12, %o0+48), memcpy_retl_o2_plus_o5_plus_40)
+	EX_ST_FP(STORE(std, %f10, %o0+40), memcpy_retl_o2_plus_o5_plus_24)
+	EX_ST_FP(STORE(std, %f12, %o0+48), memcpy_retl_o2_plus_o5_plus_16)
 	add	%o0, 64, %o0
-	EX_ST_FP(STORE(std, %f14, %o0-8), memcpy_retl_o2_plus_o5_plus_40)
+	EX_ST_FP(STORE(std, %f14, %o0-8), memcpy_retl_o2_plus_o5_plus_8)
 	fsrc2	%f30, %f14
 	bgu,pt	%xcc, .Lunalign_sloop
 	 prefetch [%o4 + (8 * BLOCK_SIZE)], 20
@@ -728,7 +728,7 @@ FUNC_NAME:
 	add	%o4, 8, %o4
 	faligndata %f0, %f2, %f16
 	subcc	%o5, 8, %o5
-	EX_ST_FP(STORE(std, %f16, %o0), memcpy_retl_o2_plus_o5)
+	EX_ST_FP(STORE(std, %f16, %o0), memcpy_retl_o2_plus_o5_plus_8)
 	fsrc2	%f2, %f0
 	bgu,pt	%xcc, .Lunalign_by8
 	 add	%o0, 8, %o0
@@ -772,7 +772,7 @@ FUNC_NAME:
 	subcc	%o5, 0x20, %o5
 	EX_ST(STORE(stx, %o3, %o0 + 0x00), memcpy_retl_o2_plus_o5_plus_32)
 	EX_ST(STORE(stx, %g2, %o0 + 0x08), memcpy_retl_o2_plus_o5_plus_24)
-	EX_ST(STORE(stx, %g7, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_24)
+	EX_ST(STORE(stx, %g7, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_16)
 	EX_ST(STORE(stx, %o4, %o0 + 0x18), memcpy_retl_o2_plus_o5_plus_8)
 	bne,pt	%xcc, 1b
 	 add	%o0, 0x20, %o0
@@ -804,12 +804,12 @@ FUNC_NAME:
 	brz,pt	%o3, 2f
 	 sub	%o2, %o3, %o2
 
-1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2), memcpy_retl_o2_plus_g1)
+1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2), memcpy_retl_o2_plus_o3)
 	add	%o1, 1, %o1
 	subcc	%o3, 1, %o3
 	add	%o0, 1, %o0
 	bne,pt	%xcc, 1b
-	 EX_ST(STORE(stb, %g2, %o0 - 0x01), memcpy_retl_o2_plus_g1_plus_1)
+	 EX_ST(STORE(stb, %g2, %o0 - 0x01), memcpy_retl_o2_plus_o3_plus_1)
 2:
 	and	%o1, 0x7, %o3
 	brz,pn	%o3, .Lmedium_noprefetch_cp
diff --git a/arch/sparc/lib/Memcpy_utils.S b/arch/sparc/lib/Memcpy_utils.S
index 64fbac28b3db..207343367bb2 100644
--- a/arch/sparc/lib/Memcpy_utils.S
+++ b/arch/sparc/lib/Memcpy_utils.S
@@ -137,6 +137,15 @@ ENTRY(memcpy_retl_o2_plus_63_8)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, 8, %o0
 ENDPROC(memcpy_retl_o2_plus_63_8)
+ENTRY(memcpy_retl_o2_plus_o3)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o3, %o0
+ENDPROC(memcpy_retl_o2_plus_o3)
+ENTRY(memcpy_retl_o2_plus_o3_plus_1)
+	add	%o3, 1, %o3
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o3, %o0
+ENDPROC(memcpy_retl_o2_plus_o3_plus_1)
 ENTRY(memcpy_retl_o2_plus_o5)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o5, %o0
diff --git a/arch/sparc/lib/NG4memcpy.S b/arch/sparc/lib/NG4memcpy.S
index 7ad58ebe0d00..df0ec1bd1948 100644
--- a/arch/sparc/lib/NG4memcpy.S
+++ b/arch/sparc/lib/NG4memcpy.S
@@ -281,7 +281,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	subcc		%o5, 0x20, %o5
 	EX_ST(STORE(stx, %g1, %o0 + 0x00), memcpy_retl_o2_plus_o5_plus_32)
 	EX_ST(STORE(stx, %g2, %o0 + 0x08), memcpy_retl_o2_plus_o5_plus_24)
-	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_24)
+	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_16)
 	EX_ST(STORE(stx, %o4, %o0 + 0x18), memcpy_retl_o2_plus_o5_plus_8)
 	bne,pt		%icc, 1b
 	 add		%o0, 0x20, %o0
diff --git a/arch/sparc/lib/NGmemcpy.S b/arch/sparc/lib/NGmemcpy.S
index 8e4d22a6ba0b..846a8c4ea394 100644
--- a/arch/sparc/lib/NGmemcpy.S
+++ b/arch/sparc/lib/NGmemcpy.S
@@ -80,8 +80,8 @@
 #ifndef EX_RETVAL
 #define EX_RETVAL(x)	x
 __restore_asi:
-	ret
 	wr	%g0, ASI_AIUS, %asi
+	ret
 	 restore
 ENTRY(NG_ret_i2_plus_i4_plus_1)
 	ba,pt	%xcc, __restore_asi
@@ -126,15 +126,16 @@ ENTRY(NG_ret_i2_plus_g1_minus_56)
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %g1, %i0
 ENDPROC(NG_ret_i2_plus_g1_minus_56)
-ENTRY(NG_ret_i2_plus_i4)
+ENTRY(NG_ret_i2_plus_i4_plus_16)
+        add     %i4, 16, %i4
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %i4, %i0
-ENDPROC(NG_ret_i2_plus_i4)
-ENTRY(NG_ret_i2_plus_i4_minus_8)
-	sub	%i4, 8, %i4
+ENDPROC(NG_ret_i2_plus_i4_plus_16)
+ENTRY(NG_ret_i2_plus_i4_plus_8)
+	add	%i4, 8, %i4
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %i4, %i0
-ENDPROC(NG_ret_i2_plus_i4_minus_8)
+ENDPROC(NG_ret_i2_plus_i4_plus_8)
 ENTRY(NG_ret_i2_plus_8)
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, 8, %i0
@@ -161,6 +162,12 @@ ENTRY(NG_ret_i2_and_7_plus_i4)
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %i4, %i0
 ENDPROC(NG_ret_i2_and_7_plus_i4)
+ENTRY(NG_ret_i2_and_7_plus_i4_plus_8)
+	and	%i2, 7, %i2
+	add	%i4, 8, %i4
+	ba,pt	%xcc, __restore_asi
+	 add	%i2, %i4, %i0
+ENDPROC(NG_ret_i2_and_7_plus_i4)
 #endif
 
 	.align		64
@@ -406,13 +413,13 @@ FUNC_NAME:	/* %i0=dst, %i1=src, %i2=len */
 	andn		%i2, 0xf, %i4
 	and		%i2, 0xf, %i2
 1:	subcc		%i4, 0x10, %i4
-	EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4)
+	EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4_plus_16)
 	add		%i1, 0x08, %i1
-	EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4)
+	EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4_plus_16)
 	sub		%i1, 0x08, %i1
-	EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4)
+	EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4_plus_16)
 	add		%i1, 0x8, %i1
-	EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_minus_8)
+	EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_plus_8)
 	bgu,pt		%XCC, 1b
 	 add		%i1, 0x8, %i1
 73:	andcc		%i2, 0x8, %g0
@@ -469,7 +476,7 @@ FUNC_NAME:	/* %i0=dst, %i1=src, %i2=len */
 	subcc		%i4, 0x8, %i4
 	srlx		%g3, %i3, %i5
 	or		%i5, %g2, %i5
-	EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4)
+	EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4_plus_8)
 	add		%o0, 0x8, %o0
 	bgu,pt		%icc, 1b
 	 sllx		%g3, %g1, %g2
diff --git a/arch/sparc/lib/U1memcpy.S b/arch/sparc/lib/U1memcpy.S
index a6f4ee391897..021b94a383d1 100644
--- a/arch/sparc/lib/U1memcpy.S
+++ b/arch/sparc/lib/U1memcpy.S
@@ -164,17 +164,18 @@ ENTRY(U1_gs_40_fp)
 	retl
 	 add		%o0, %o2, %o0
 ENDPROC(U1_gs_40_fp)
-ENTRY(U1_g3_0_fp)
-	VISExitHalf
-	retl
-	 add		%g3, %o2, %o0
-ENDPROC(U1_g3_0_fp)
 ENTRY(U1_g3_8_fp)
 	VISExitHalf
 	add		%g3, 8, %g3
 	retl
 	 add		%g3, %o2, %o0
 ENDPROC(U1_g3_8_fp)
+ENTRY(U1_g3_16_fp)
+	VISExitHalf
+	add		%g3, 16, %g3
+	retl
+	 add		%g3, %o2, %o0
+ENDPROC(U1_g3_16_fp)
 ENTRY(U1_o2_0_fp)
 	VISExitHalf
 	retl
@@ -547,18 +548,18 @@ FUNC_NAME:		/* %o0=dst, %o1=src, %o2=len */
 62:	FINISH_VISCHUNK(o0, f44, f46)
 63:	UNEVEN_VISCHUNK_LAST(o0, f46, f0)
 
-93:	EX_LD_FP(LOAD(ldd, %o1, %f2), U1_g3_0_fp)
+93:	EX_LD_FP(LOAD(ldd, %o1, %f2), U1_g3_8_fp)
 	add		%o1, 8, %o1
 	subcc		%g3, 8, %g3
 	faligndata	%f0, %f2, %f8
-	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_8_fp)
+	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_16_fp)
 	bl,pn		%xcc, 95f
 	 add		%o0, 8, %o0
-	EX_LD_FP(LOAD(ldd, %o1, %f0), U1_g3_0_fp)
+	EX_LD_FP(LOAD(ldd, %o1, %f0), U1_g3_8_fp)
 	add		%o1, 8, %o1
 	subcc		%g3, 8, %g3
 	faligndata	%f2, %f0, %f8
-	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_8_fp)
+	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_16_fp)
 	bge,pt		%xcc, 93b
 	 add		%o0, 8, %o0
 
diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
index 9248d59c734c..bace3a18f836 100644
--- a/arch/sparc/lib/U3memcpy.S
+++ b/arch/sparc/lib/U3memcpy.S
@@ -267,6 +267,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	faligndata	%f10, %f12, %f26
 	EX_LD_FP(LOAD(ldd, %o1 + 0x040, %f0), U3_retl_o2)
 
+	and		%o2, 0x3f, %o2
 	subcc		GLOBAL_SPARE, 0x80, GLOBAL_SPARE
 	add		%o1, 0x40, %o1
 	bgu,pt		%XCC, 1f
@@ -336,7 +337,6 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	 * Also notice how this code is careful not to perform a
 	 * load past the end of the src buffer.
 	 */
-	and		%o2, 0x3f, %o2
 	andcc		%o2, 0x38, %g2
 	be,pn		%XCC, 2f
 	 subcc		%g2, 0x8, %g2
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 0f49fada2093..7ec6e7bc374a 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -133,6 +133,26 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 
 static pte_t sun4u_hugepage_shift_to_tte(pte_t entry, unsigned int shift)
 {
+	unsigned long hugepage_size = _PAGE_SZ4MB_4U;
+
+	pte_val(entry) = pte_val(entry) & ~_PAGE_SZALL_4U;
+
+	switch (shift) {
+	case HPAGE_256MB_SHIFT:
+		hugepage_size = _PAGE_SZ256MB_4U;
+		pte_val(entry) |= _PAGE_PMD_HUGE;
+		break;
+	case HPAGE_SHIFT:
+		pte_val(entry) |= _PAGE_PMD_HUGE;
+		break;
+	case HPAGE_64K_SHIFT:
+		hugepage_size = _PAGE_SZ64K_4U;
+		break;
+	default:
+		WARN_ONCE(1, "unsupported hugepage shift=%u\n", shift);
+	}
+
+	pte_val(entry) = pte_val(entry) | hugepage_size;
 	return entry;
 }
 
diff --git a/arch/um/drivers/mconsole_user.c b/arch/um/drivers/mconsole_user.c
index e24298a734be..a04cd13c6315 100644
--- a/arch/um/drivers/mconsole_user.c
+++ b/arch/um/drivers/mconsole_user.c
@@ -71,7 +71,9 @@ static struct mconsole_command *mconsole_parse(struct mc_request *req)
 	return NULL;
 }
 
+#ifndef MIN
 #define MIN(a,b) ((a)<(b) ? (a):(b))
+#endif
 
 #define STRINGX(x) #x
 #define STRING(x) STRINGX(x)
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 8dd8e8ec9fa5..879be4ffa06c 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -242,7 +242,7 @@ static inline unsigned long vdso_encode_cpunode(int cpu, unsigned long node)
 
 static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
 {
-	unsigned int p;
+	unsigned long p;
 
 	/*
 	 * Load CPU and node number from the GDT.  LSL is faster than RDTSCP
@@ -252,10 +252,10 @@ static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
 	 *
 	 * If RDPID is available, use it.
 	 */
-	alternative_io ("lsl %[seg],%[p]",
-			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
+	alternative_io ("lsl %[seg],%k[p]",
+			"rdpid %[p]",
 			X86_FEATURE_RDPID,
-			[p] "=a" (p), [seg] "r" (__CPUNODE_SEG));
+			[p] "=r" (p), [seg] "r" (__CPUNODE_SEG));
 
 	if (cpu)
 		*cpu = (p & VDSO_CPUNODE_MASK);
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 576b47e7523d..5f6e0d3cfbc4 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -156,15 +156,26 @@ static int identify_insn(struct insn *insn)
 	if (!insn->modrm.nbytes)
 		return -EINVAL;
 
-	/* All the instructions of interest start with 0x0f. */
-	if (insn->opcode.bytes[0] != 0xf)
+	/* The instructions of interest have 2-byte opcodes: 0F 00 or 0F 01. */
+	if (insn->opcode.nbytes < 2 || insn->opcode.bytes[0] != 0xf)
 		return -EINVAL;
 
 	if (insn->opcode.bytes[1] == 0x1) {
 		switch (X86_MODRM_REG(insn->modrm.value)) {
 		case 0:
+			/* The reg form of 0F 01 /0 encodes VMX instructions. */
+			if (X86_MODRM_MOD(insn->modrm.value) == 3)
+				return -EINVAL;
+
 			return UMIP_INST_SGDT;
 		case 1:
+			/*
+			 * The reg form of 0F 01 /1 encodes MONITOR/MWAIT,
+			 * STAC/CLAC, and ENCLS.
+			 */
+			if (X86_MODRM_MOD(insn->modrm.value) == 3)
+				return -EINVAL;
+
 			return UMIP_INST_SIDT;
 		case 4:
 			return UMIP_INST_SMSW;
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 98b25a7af8ce..dae68691f424 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5452,12 +5452,11 @@ void init_decode_cache(struct x86_emulate_ctxt *ctxt)
 	ctxt->mem_read.end = 0;
 }
 
-int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
+int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts)
 {
 	const struct x86_emulate_ops *ops = ctxt->ops;
 	int rc = X86EMUL_CONTINUE;
 	int saved_dst_type = ctxt->dst.type;
-	unsigned emul_flags;
 
 	ctxt->mem_read.pos = 0;
 
@@ -5471,8 +5470,6 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 		rc = emulate_ud(ctxt);
 		goto done;
 	}
-
-	emul_flags = ctxt->ops->get_hflags(ctxt);
 	if (unlikely(ctxt->d &
 		     (No64|Undefined|Sse|Mmx|Intercept|CheckPerm|Priv|Prot|String))) {
 		if ((ctxt->mode == X86EMUL_MODE_PROT64 && (ctxt->d & No64)) ||
@@ -5506,7 +5503,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 				fetch_possible_mmx_operand(&ctxt->dst);
 		}
 
-		if (unlikely(emul_flags & X86EMUL_GUEST_MASK) && ctxt->intercept) {
+		if (unlikely(check_intercepts) && ctxt->intercept) {
 			rc = emulator_check_intercept(ctxt, ctxt->intercept,
 						      X86_ICPT_PRE_EXCEPT);
 			if (rc != X86EMUL_CONTINUE)
@@ -5535,7 +5532,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 				goto done;
 		}
 
-		if (unlikely(emul_flags & X86EMUL_GUEST_MASK) && (ctxt->d & Intercept)) {
+		if (unlikely(check_intercepts) && (ctxt->d & Intercept)) {
 			rc = emulator_check_intercept(ctxt, ctxt->intercept,
 						      X86_ICPT_POST_EXCEPT);
 			if (rc != X86EMUL_CONTINUE)
@@ -5589,7 +5586,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 
 special_insn:
 
-	if (unlikely(emul_flags & X86EMUL_GUEST_MASK) && (ctxt->d & Intercept)) {
+	if (unlikely(check_intercepts) && (ctxt->d & Intercept)) {
 		rc = emulator_check_intercept(ctxt, ctxt->intercept,
 					      X86_ICPT_POST_MEMACCESS);
 		if (rc != X86EMUL_CONTINUE)
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index fb09cd22cb7f..6507340513cd 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -496,7 +496,7 @@ bool x86_page_table_writing_insn(struct x86_emulate_ctxt *ctxt);
 #define EMULATION_RESTART 1
 #define EMULATION_INTERCEPTED 2
 void init_decode_cache(struct x86_emulate_ctxt *ctxt);
-int x86_emulate_insn(struct x86_emulate_ctxt *ctxt);
+int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts);
 int emulator_task_switch(struct x86_emulate_ctxt *ctxt,
 			 u16 tss_selector, int idt_index, int reason,
 			 bool has_error_code, u32 error_code);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2ba297da7bde..648f80f73e66 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8209,7 +8209,14 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		ctxt->exception.address = 0;
 	}
 
-	r = x86_emulate_insn(ctxt);
+	/*
+	 * Check L1's instruction intercepts when emulating instructions for
+	 * L2, unless KVM is re-emulating a previously decoded instruction,
+	 * e.g. to complete userspace I/O, in which case KVM has already
+	 * checked the intercepts.
+	 */
+	r = x86_emulate_insn(ctxt, is_guest_mode(vcpu) &&
+				   !(emulation_type & EMULTYPE_NO_DECODE));
 
 	if (r == EMULATION_INTERCEPTED)
 		return 1;
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3481b35cb4ec..e649161eb6fc 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -107,7 +107,7 @@ static inline void pgd_list_del(pgd_t *pgd)
 #define UNSHARED_PTRS_PER_PGD				\
 	(SHARED_KERNEL_PMD ? KERNEL_PGD_BOUNDARY : PTRS_PER_PGD)
 #define MAX_UNSHARED_PTRS_PER_PGD			\
-	max_t(size_t, KERNEL_PGD_BOUNDARY, PTRS_PER_PGD)
+	MAX_T(size_t, KERNEL_PGD_BOUNDARY, PTRS_PER_PGD)
 
 
 static void pgd_set_mm(pgd_t *pgd, struct mm_struct *mm)
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 7074ce8d2d03..09f4faca338a 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -178,9 +178,11 @@ static void blk_mq_unregister_hctx(struct blk_mq_hw_ctx *hctx)
 		return;
 
 	hctx_for_each_ctx(hctx, ctx, i)
-		kobject_del(&ctx->kobj);
+		if (ctx->kobj.state_in_sysfs)
+			kobject_del(&ctx->kobj);
 
-	kobject_del(&hctx->kobj);
+	if (hctx->kobj.state_in_sysfs)
+		kobject_del(&hctx->kobj);
 }
 
 static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-settings.c b/block/blk-settings.c
index d501084bab4a..85346a6f1c77 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -514,7 +514,8 @@ static unsigned int blk_round_down_sectors(unsigned int sectors, unsigned int lb
 int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		     sector_t start)
 {
-	unsigned int top, bottom, alignment, ret = 0;
+	unsigned int top, bottom, alignment;
+	int ret = 0;
 
 	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
 	t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
diff --git a/crypto/essiv.c b/crypto/essiv.c
index 3505b071e647..365f3082ea04 100644
--- a/crypto/essiv.c
+++ b/crypto/essiv.c
@@ -186,9 +186,14 @@ static int essiv_aead_crypt(struct aead_request *req, bool enc)
 	const struct essiv_tfm_ctx *tctx = crypto_aead_ctx(tfm);
 	struct essiv_aead_request_ctx *rctx = aead_request_ctx(req);
 	struct aead_request *subreq = &rctx->aead_req;
+	int ivsize = crypto_aead_ivsize(tfm);
+	int ssize = req->assoclen - ivsize;
 	struct scatterlist *src = req->src;
 	int err;
 
+	if (ssize < 0)
+		return -EINVAL;
+
 	crypto_cipher_encrypt_one(tctx->essiv_cipher, req->iv, req->iv);
 
 	/*
@@ -198,19 +203,12 @@ static int essiv_aead_crypt(struct aead_request *req, bool enc)
 	 */
 	rctx->assoc = NULL;
 	if (req->src == req->dst || !enc) {
-		scatterwalk_map_and_copy(req->iv, req->dst,
-					 req->assoclen - crypto_aead_ivsize(tfm),
-					 crypto_aead_ivsize(tfm), 1);
+		scatterwalk_map_and_copy(req->iv, req->dst, ssize, ivsize, 1);
 	} else {
 		u8 *iv = (u8 *)aead_request_ctx(req) + tctx->ivoffset;
-		int ivsize = crypto_aead_ivsize(tfm);
-		int ssize = req->assoclen - ivsize;
 		struct scatterlist *sg;
 		int nents;
 
-		if (ssize < 0)
-			return -EINVAL;
-
 		nents = sg_nents_for_len(req->src, ssize);
 		if (nents < 0)
 			return -EINVAL;
diff --git a/crypto/rng.c b/crypto/rng.c
index fea082b25fe4..a2bf2efb7937 100644
--- a/crypto/rng.c
+++ b/crypto/rng.c
@@ -174,6 +174,11 @@ int crypto_del_default_rng(void)
 EXPORT_SYMBOL_GPL(crypto_del_default_rng);
 #endif
 
+static void rng_default_set_ent(struct crypto_rng *tfm, const u8 *data,
+				unsigned int len)
+{
+}
+
 int crypto_register_rng(struct rng_alg *alg)
 {
 	struct crypto_alg *base = &alg->base;
@@ -185,6 +190,9 @@ int crypto_register_rng(struct rng_alg *alg)
 	base->cra_flags &= ~CRYPTO_ALG_TYPE_MASK;
 	base->cra_flags |= CRYPTO_ALG_TYPE_RNG;
 
+	if (!alg->set_ent)
+		alg->set_ent = rng_default_set_ent;
+
 	return crypto_register_alg(base);
 }
 EXPORT_SYMBOL_GPL(crypto_register_rng);
diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index d50261d05f3a..515b20d0b698 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -569,11 +569,11 @@ static int acpi_aml_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int acpi_aml_read_user(char __user *buf, int len)
+static ssize_t acpi_aml_read_user(char __user *buf, size_t len)
 {
-	int ret;
 	struct circ_buf *crc = &acpi_aml_io.out_crc;
-	int n;
+	ssize_t ret;
+	size_t n;
 	char *p;
 
 	ret = acpi_aml_lock_read(crc, ACPI_AML_OUT_USER);
@@ -582,7 +582,7 @@ static int acpi_aml_read_user(char __user *buf, int len)
 	/* sync head before removing logs */
 	smp_rmb();
 	p = &crc->buf[crc->tail];
-	n = min(len, circ_count_to_end(crc));
+	n = min_t(size_t, len, circ_count_to_end(crc));
 	if (copy_to_user(buf, p, n)) {
 		ret = -EFAULT;
 		goto out;
@@ -599,8 +599,8 @@ static int acpi_aml_read_user(char __user *buf, int len)
 static ssize_t acpi_aml_read(struct file *file, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
-	int ret = 0;
-	int size = 0;
+	ssize_t ret = 0;
+	ssize_t size = 0;
 
 	if (!count)
 		return 0;
@@ -639,11 +639,11 @@ static ssize_t acpi_aml_read(struct file *file, char __user *buf,
 	return size > 0 ? size : ret;
 }
 
-static int acpi_aml_write_user(const char __user *buf, int len)
+static ssize_t acpi_aml_write_user(const char __user *buf, size_t len)
 {
-	int ret;
 	struct circ_buf *crc = &acpi_aml_io.in_crc;
-	int n;
+	ssize_t ret;
+	size_t n;
 	char *p;
 
 	ret = acpi_aml_lock_write(crc, ACPI_AML_IN_USER);
@@ -652,7 +652,7 @@ static int acpi_aml_write_user(const char __user *buf, int len)
 	/* sync tail before inserting cmds */
 	smp_mb();
 	p = &crc->buf[crc->head];
-	n = min(len, circ_space_to_end(crc));
+	n = min_t(size_t, len, circ_space_to_end(crc));
 	if (copy_from_user(p, buf, n)) {
 		ret = -EFAULT;
 		goto out;
@@ -663,14 +663,14 @@ static int acpi_aml_write_user(const char __user *buf, int len)
 	ret = n;
 out:
 	acpi_aml_unlock_fifo(ACPI_AML_IN_USER, ret >= 0);
-	return n;
+	return ret;
 }
 
 static ssize_t acpi_aml_write(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	int ret = 0;
-	int size = 0;
+	ssize_t ret = 0;
+	ssize_t size = 0;
 
 	if (!count)
 		return 0;
diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index e9b8e8305e23..8383d6329c64 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -563,6 +563,9 @@ static int acpi_tad_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(dev);
 
+	if (dd->capabilities & ACPI_TAD_RT)
+		sysfs_remove_group(&dev->kobj, &acpi_tad_time_attr_group);
+
 	if (dd->capabilities & ACPI_TAD_DC_WAKE)
 		sysfs_remove_group(&dev->kobj, &acpi_tad_dc_attr_group);
 
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 2a6fdce3c2e6..e420f773d674 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3021,7 +3021,7 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
 	if (ndr_desc->target_node == NUMA_NO_NODE) {
 		ndr_desc->target_node = phys_to_target_node(spa->address);
 		dev_info(acpi_desc->dev, "changing target node from %d to %d for nfit region [%pa-%pa]",
-			NUMA_NO_NODE, ndr_desc->numa_node, &res.start, &res.end);
+			NUMA_NO_NODE, ndr_desc->target_node, &res.start, &res.end);
 	}
 
 	/*
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 74459ac13f4b..6b71082d474f 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1403,6 +1403,9 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 		if (retval) {
 			if (acpi_processor_registered == 0)
 				cpuidle_unregister_driver(&acpi_idle_driver);
+
+			per_cpu(acpi_cpuidle_device, pr->id) = NULL;
+			kfree(dev);
 			return retval;
 		}
 		acpi_processor_registered++;
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 5366d1b5359c..dd8c8fdfd158 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -983,6 +983,10 @@ int __register_one_node(int nid)
 		return -ENOMEM;
 
 	error = register_node(node_devices[nid], nid);
+	if (error) {
+		node_devices[nid] = NULL;
+		return error;
+	}
 
 	/* link cpu under this node */
 	for_each_present_cpu(cpu) {
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index c784de10b494..9cd0a837af42 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -601,8 +601,20 @@ static void __device_resume_noirq(struct device *dev, pm_message_t state, bool a
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Out;
 
-	if (!dev->power.is_noirq_suspended)
+	if (!dev->power.is_noirq_suspended) {
+		/*
+		 * This means that system suspend has been aborted in the noirq
+		 * phase before invoking the noirq suspend callback for the
+		 * device, so if device_suspend_late() has left it in suspend,
+		 * device_resume_early() should leave it in suspend either in
+		 * case the early resume of it depends on the noirq resume that
+		 * has not run.
+		 */
+		if (dev_pm_skip_suspend(dev))
+			dev->power.must_resume = false;
+
 		goto Out;
+	}
 
 	if (!dpm_wait_for_superior(dev, async))
 		goto Out;
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ebddc69bc969..35cfbec6bf9a 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -888,7 +888,7 @@ struct regmap *__regmap_init(struct device *dev,
 		map->read_flag_mask = bus->read_flag_mask;
 	}
 
-	if (config && config->read && config->write) {
+	if (config->read && config->write) {
 		map->reg_read  = _regmap_bus_read;
 
 		/* Bulk read/write */
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index a5d54dd94eed..40d5249ec55c 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1169,6 +1169,9 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	 * Get physical address of MC portal for the root DPRC:
 	 */
 	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!plat_res)
+		return -EINVAL;
+
 	mc_portal_phys_addr = plat_res->start;
 	mc_portal_size = resource_size(plat_res);
 	mc_portal_base_phys_addr = mc_portal_phys_addr & ~0x3ffffff;
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 7ccc5cd27fd0..c192b3d83bd7 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -161,7 +161,6 @@ void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl)
 int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 {
 	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	unsigned long irq_flags = IRQF_SHARED | IRQF_NO_SUSPEND;
 	int i, ret;
 
@@ -182,7 +181,7 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 			continue;
 
 		if (mhi_event->irq >= mhi_cntrl->nr_irqs) {
-			dev_err(dev, "irq %d not available for event ring\n",
+			dev_err(mhi_cntrl->cntrl_dev, "irq %d not available for event ring\n",
 				mhi_event->irq);
 			ret = -EINVAL;
 			goto error_request;
@@ -193,7 +192,7 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 				  irq_flags,
 				  "mhi", mhi_event);
 		if (ret) {
-			dev_err(dev, "Error requesting irq:%d for ev:%d\n",
+			dev_err(mhi_cntrl->cntrl_dev, "Error requesting irq:%d for ev:%d\n",
 				mhi_cntrl->irq[mhi_event->irq], i);
 			goto error_request;
 		}
diff --git a/drivers/char/hw_random/ks-sa-rng.c b/drivers/char/hw_random/ks-sa-rng.c
index 2f2f21f1b659..d7b42888f25c 100644
--- a/drivers/char/hw_random/ks-sa-rng.c
+++ b/drivers/char/hw_random/ks-sa-rng.c
@@ -240,6 +240,10 @@ static int ks_sa_rng_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ks_sa_rng->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(ks_sa_rng->clk))
+		return dev_err_probe(dev, PTR_ERR(ks_sa_rng->clk), "Failed to get clock\n");
+
 	pm_runtime_enable(dev);
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index b3452259d6e0..c8c68301543b 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -831,8 +831,8 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
 	 * will call disable_irq which undoes all of the above.
 	 */
 	if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
-		tpm_tis_write8(priv, original_int_vec,
-			       TPM_INT_VECTOR(priv->locality));
+		tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality),
+			       original_int_vec);
 		rc = -1;
 	}
 
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index 7a27ba8e0577..7605ab23dc8e 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -268,8 +268,11 @@ static int clk_sam9x5_peripheral_determine_rate(struct clk_hw *hw,
 	long best_diff = LONG_MIN;
 	u32 shift;
 
-	if (periph->id < PERIPHERAL_ID_MIN || !periph->range.max)
-		return parent_rate;
+	if (periph->id < PERIPHERAL_ID_MIN || !periph->range.max) {
+		req->rate = parent_rate;
+
+		return 0;
+	}
 
 	/* Fist step: check the available dividers. */
 	for (shift = 0; shift <= PERIPHERAL_MAX_SHIFT; shift++) {
diff --git a/drivers/clk/nxp/clk-lpc18xx-cgu.c b/drivers/clk/nxp/clk-lpc18xx-cgu.c
index 8b686da5577b..ab8741fe57c9 100644
--- a/drivers/clk/nxp/clk-lpc18xx-cgu.c
+++ b/drivers/clk/nxp/clk-lpc18xx-cgu.c
@@ -374,23 +374,25 @@ static unsigned long lpc18xx_pll0_recalc_rate(struct clk_hw *hw,
 	return 0;
 }
 
-static long lpc18xx_pll0_round_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long *prate)
+static int lpc18xx_pll0_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	unsigned long m;
 
-	if (*prate < rate) {
+	if (req->best_parent_rate < req->rate) {
 		pr_warn("%s: pll dividers not supported\n", __func__);
 		return -EINVAL;
 	}
 
-	m = DIV_ROUND_UP_ULL(*prate, rate * 2);
-	if (m <= 0 && m > LPC18XX_PLL0_MSEL_MAX) {
-		pr_warn("%s: unable to support rate %lu\n", __func__, rate);
+	m = DIV_ROUND_UP_ULL(req->best_parent_rate, req->rate * 2);
+	if (m == 0 || m > LPC18XX_PLL0_MSEL_MAX) {
+		pr_warn("%s: unable to support rate %lu\n", __func__, req->rate);
 		return -EINVAL;
 	}
 
-	return 2 * *prate * m;
+	req->rate = 2 * req->best_parent_rate * m;
+
+	return 0;
 }
 
 static int lpc18xx_pll0_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -406,7 +408,7 @@ static int lpc18xx_pll0_set_rate(struct clk_hw *hw, unsigned long rate,
 	}
 
 	m = DIV_ROUND_UP_ULL(parent_rate, rate * 2);
-	if (m <= 0 && m > LPC18XX_PLL0_MSEL_MAX) {
+	if (m == 0 || m > LPC18XX_PLL0_MSEL_MAX) {
 		pr_warn("%s: unable to support rate %lu\n", __func__, rate);
 		return -EINVAL;
 	}
@@ -447,7 +449,7 @@ static int lpc18xx_pll0_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops lpc18xx_pll0_ops = {
 	.recalc_rate	= lpc18xx_pll0_recalc_rate,
-	.round_rate	= lpc18xx_pll0_round_rate,
+	.determine_rate = lpc18xx_pll0_determine_rate,
 	.set_rate	= lpc18xx_pll0_set_rate,
 };
 
diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
index e95fdc49c226..bbceb0289d45 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -78,24 +78,33 @@ static int __init clps711x_timer_init(struct device_node *np)
 	unsigned int irq = irq_of_parse_and_map(np, 0);
 	struct clk *clock = of_clk_get(np, 0);
 	void __iomem *base = of_iomap(np, 0);
+	int ret = 0;
 
 	if (!base)
 		return -ENOMEM;
-	if (!irq)
-		return -EINVAL;
-	if (IS_ERR(clock))
-		return PTR_ERR(clock);
+	if (!irq) {
+		ret = -EINVAL;
+		goto unmap_io;
+	}
+	if (IS_ERR(clock)) {
+		ret = PTR_ERR(clock);
+		goto unmap_io;
+	}
 
 	switch (of_alias_get_id(np, "timer")) {
 	case CLPS711X_CLKSRC_CLOCKSOURCE:
 		clps711x_clksrc_init(clock, base);
 		break;
 	case CLPS711X_CLKSRC_CLOCKEVENT:
-		return _clps711x_clkevt_init(clock, base, irq);
+		ret =  _clps711x_clkevt_init(clock, base, irq);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	}
 
-	return 0;
+unmap_io:
+	iounmap(base);
+	return ret;
 }
 TIMER_OF_DECLARE(clps711x, "cirrus,ep7209-timer", clps711x_timer_init);
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 9d7a4ef21077..afe99812574a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1307,10 +1307,10 @@ static void update_qos_request(enum freq_qos_req_type type)
 			continue;
 
 		req = policy->driver_data;
-		cpufreq_cpu_put(policy);
-
-		if (!req)
+		if (!req) {
+			cpufreq_cpu_put(policy);
 			continue;
+		}
 
 		if (hwp_active)
 			intel_pstate_get_hwp_cap(cpu);
@@ -1326,6 +1326,8 @@ static void update_qos_request(enum freq_qos_req_type type)
 
 		if (freq_qos_update_request(req, freq) < 0)
 			pr_warn("Failed to update freq constraint: CPU%d\n", i);
+
+		cpufreq_cpu_put(policy);
 	}
 }
 
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 1f12109526fa..35287ab0148a 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -15,6 +15,7 @@
 #include <linux/energy_model.h>
 #include <linux/export.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/scmi_protocol.h>
@@ -319,6 +320,15 @@ static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
 			return true;
 	}
 
+	/*
+	 * Older Broadcom STB chips had a "clocks" property for CPU node(s)
+	 * that did not match the SCMI performance protocol node, if we got
+	 * there, it means we had such an older Device Tree, therefore return
+	 * true to preserve backwards compatibility.
+	 */
+	if (of_machine_is_compatible("brcm,brcmstb"))
+		return true;
+
 	return false;
 }
 
diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 5d1943e787b0..af7edddaa84e 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -86,10 +86,14 @@ static int tegra186_cpufreq_set_target(struct cpufreq_policy *policy,
 {
 	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
 	struct cpufreq_frequency_table *tbl = policy->freq_table + index;
-	unsigned int edvd_offset = data->cpus[policy->cpu].edvd_offset;
+	unsigned int edvd_offset;
 	u32 edvd_val = tbl->driver_data;
+	u32 cpu;
 
-	writel(edvd_val, data->regs + edvd_offset);
+	for_each_cpu(cpu, policy->cpus) {
+		edvd_offset = data->cpus[cpu].edvd_offset;
+		writel(edvd_val, data->regs + edvd_offset);
+	}
 
 	return 0;
 }
diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index e30786ec9f2d..22277b5b5868 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -548,7 +548,7 @@ static int atmel_tdes_crypt_start(struct atmel_tdes_dev *dd)
 
 	if (err && (dd->flags & TDES_FLAGS_FAST)) {
 		dma_unmap_sg(dd->dev, dd->in_sg, 1, DMA_TO_DEVICE);
-		dma_unmap_sg(dd->dev, dd->out_sg, 1, DMA_TO_DEVICE);
+		dma_unmap_sg(dd->dev, dd->out_sg, 1, DMA_FROM_DEVICE);
 	}
 
 	return err;
diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index e2070df6cad2..0b846c605d4b 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -584,11 +584,11 @@ desc_get_errstat(struct ioatdma_chan *ioat_chan, struct ioat_ring_ent *desc)
 }
 
 /**
- * __cleanup - reclaim used descriptors
+ * __ioat_cleanup - reclaim used descriptors
  * @ioat_chan: channel (ring) to clean
  * @phys_complete: zeroed (or not) completion address (from status)
  */
-static void __cleanup(struct ioatdma_chan *ioat_chan, dma_addr_t phys_complete)
+static void __ioat_cleanup(struct ioatdma_chan *ioat_chan, dma_addr_t phys_complete)
 {
 	struct ioatdma_device *ioat_dma = ioat_chan->ioat_dma;
 	struct ioat_ring_ent *desc;
@@ -675,7 +675,7 @@ static void ioat_cleanup(struct ioatdma_chan *ioat_chan)
 	spin_lock_bh(&ioat_chan->cleanup_lock);
 
 	if (ioat_cleanup_preamble(ioat_chan, &phys_complete))
-		__cleanup(ioat_chan, phys_complete);
+		__ioat_cleanup(ioat_chan, phys_complete);
 
 	if (is_ioat_halted(*ioat_chan->completion)) {
 		u32 chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
@@ -712,7 +712,7 @@ static void ioat_restart_channel(struct ioatdma_chan *ioat_chan)
 
 	ioat_quiesce(ioat_chan, 0);
 	if (ioat_cleanup_preamble(ioat_chan, &phys_complete))
-		__cleanup(ioat_chan, phys_complete);
+		__ioat_cleanup(ioat_chan, phys_complete);
 
 	__ioat_restart_chan(ioat_chan);
 }
@@ -786,7 +786,7 @@ static void ioat_eh(struct ioatdma_chan *ioat_chan)
 
 	/* cleanup so tail points to descriptor that caused the error */
 	if (ioat_cleanup_preamble(ioat_chan, &phys_complete))
-		__cleanup(ioat_chan, phys_complete);
+		__ioat_cleanup(ioat_chan, phys_complete);
 
 	chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
 	pci_read_config_dword(pdev, IOAT_PCI_CHANERR_INT_OFFSET, &chanerr_int);
@@ -943,7 +943,7 @@ void ioat_timer_event(struct timer_list *t)
 		/* timer restarted in ioat_cleanup_preamble
 		 * and IOAT_COMPLETION_ACK cleared
 		 */
-		__cleanup(ioat_chan, phys_complete);
+		__ioat_cleanup(ioat_chan, phys_complete);
 		goto unlock_out;
 	}
 
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 1522d4aa2ca6..714020e7405a 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -109,8 +109,8 @@ static const u32 knl_interleave_list[] = {
 	0x104, 0x10c, 0x114, 0x11c,   /* 20-23 */
 };
 #define MAX_INTERLEAVE							\
-	(max_t(unsigned int, ARRAY_SIZE(sbridge_interleave_list),	\
-	       max_t(unsigned int, ARRAY_SIZE(ibridge_interleave_list),	\
+	(MAX_T(unsigned int, ARRAY_SIZE(sbridge_interleave_list),	\
+	       MAX_T(unsigned int, ARRAY_SIZE(ibridge_interleave_list),	\
 		     ARRAY_SIZE(knl_interleave_list))))
 
 struct interleave_pkg {
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 13f761930b4f..1a78f18cf7fe 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -44,7 +44,6 @@
 #define I10NM_NUM_CHANNELS	MAX(I10NM_NUM_DDR_CHANNELS, I10NM_NUM_HBM_CHANNELS)
 #define I10NM_NUM_DIMMS		MAX(I10NM_NUM_DDR_DIMMS, I10NM_NUM_HBM_DIMMS)
 
-#define MAX(a, b)	((a) > (b) ? (a) : (b))
 #define NUM_IMC		MAX(SKX_NUM_IMC, I10NM_NUM_IMC)
 #define NUM_CHANNELS	MAX(SKX_NUM_CHANNELS, I10NM_NUM_CHANNELS)
 #define NUM_DIMMS	MAX(SKX_NUM_DIMMS, I10NM_NUM_DIMMS)
diff --git a/drivers/firmware/meson/Kconfig b/drivers/firmware/meson/Kconfig
index f2fdd3756648..179f5d46d8dd 100644
--- a/drivers/firmware/meson/Kconfig
+++ b/drivers/firmware/meson/Kconfig
@@ -5,7 +5,7 @@
 config MESON_SM
 	tristate "Amlogic Secure Monitor driver"
 	depends on ARCH_MESON || COMPILE_TEST
-	default y
+	default ARCH_MESON
 	depends on ARM64_4K_PAGES
 	help
 	  Say y here to enable the Amlogic secure monitor driver
diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index bf19dd66c213..6a0a5b16663e 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -225,11 +225,16 @@ EXPORT_SYMBOL(meson_sm_call_write);
 struct meson_sm_firmware *meson_sm_get(struct device_node *sm_node)
 {
 	struct platform_device *pdev = of_find_device_by_node(sm_node);
+	struct meson_sm_firmware *fw;
 
 	if (!pdev)
 		return NULL;
 
-	return platform_get_drvdata(pdev);
+	fw = platform_get_drvdata(pdev);
+
+	put_device(&pdev->dev);
+
+	return fw;
 }
 EXPORT_SYMBOL_GPL(meson_sm_get);
 
diff --git a/drivers/gpio/gpio-wcd934x.c b/drivers/gpio/gpio-wcd934x.c
index c00968ce7a56..26d70ac90933 100644
--- a/drivers/gpio/gpio-wcd934x.c
+++ b/drivers/gpio/gpio-wcd934x.c
@@ -101,8 +101,7 @@ static int wcd_gpio_probe(struct platform_device *pdev)
 	chip->base = -1;
 	chip->ngpio = WCD934X_NPINS;
 	chip->label = dev_name(dev);
-	chip->of_gpio_n_cells = 2;
-	chip->can_sleep = false;
+	chip->can_sleep = true;
 
 	return devm_gpiochip_add_data(dev, chip, data);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dbef22f56482..1ee8663fd866 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1277,7 +1277,9 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 
 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
 
+#ifndef MIN
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#endif
 
 /* Common functions */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 0fef925b6602..e458e0d5801b 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -625,7 +625,22 @@ static void uvd_v3_1_enable_mgcg(struct amdgpu_device *adev,
  *
  * @handle: handle used to pass amdgpu_device pointer
  *
- * Initialize the hardware, boot up the VCPU and do some testing
+ * Initialize the hardware, boot up the VCPU and do some testing.
+ *
+ * On SI, the UVD is meant to be used in a specific power state,
+ * or alternatively the driver can manually enable its clock.
+ * In amdgpu we use the dedicated UVD power state when DPM is enabled.
+ * Calling amdgpu_dpm_enable_uvd makes DPM select the UVD power state
+ * for the SMU and afterwards enables the UVD clock.
+ * This is automatically done by amdgpu_uvd_ring_begin_use when work
+ * is submitted to the UVD ring. Here, we have to call it manually
+ * in order to power up UVD before firmware validation.
+ *
+ * Note that we must not disable the UVD clock here, as that would
+ * cause the ring test to fail. However, UVD is powered off
+ * automatically after the ring test: amdgpu_uvd_ring_end_use calls
+ * the UVD idle work handler which will disable the UVD clock when
+ * all fences are signalled.
  */
 static int uvd_v3_1_hw_init(void *handle)
 {
@@ -635,6 +650,15 @@ static int uvd_v3_1_hw_init(void *handle)
 	int r;
 
 	uvd_v3_1_mc_resume(adev);
+	uvd_v3_1_enable_mgcg(adev, true);
+
+	/* Make sure UVD is powered during FW validation.
+	 * It's going to be automatically powered off after the ring test.
+	 */
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_uvd(adev, true);
+	else
+		amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
 
 	r = uvd_v3_1_fw_validate(adev);
 	if (r) {
@@ -642,9 +666,6 @@ static int uvd_v3_1_hw_init(void *handle)
 		return r;
 	}
 
-	uvd_v3_1_enable_mgcg(adev, true);
-	amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
-
 	uvd_v3_1_start(adev);
 
 	r = amdgpu_ring_test_helper(ring);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7f55decc5f37..d21bebfa884e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3228,7 +3228,7 @@ svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
 		r = svm_range_get_attr(p, start, size, nattrs, attrs);
 		break;
 	default:
-		r = EINVAL;
+		r = -EINVAL;
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 670d5ab9d998..f97c18267708 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -154,10 +154,13 @@ static bool dce60_setup_scaling_configuration(
 	REG_SET(SCL_BYPASS_CONTROL, 0, SCL_BYPASS_MODE, 0);
 
 	if (data->taps.h_taps + data->taps.v_taps <= 2) {
-		/* Set bypass */
-
-		/* DCE6 has no SCL_MODE register, skip scale mode programming */
+		/* Disable scaler functionality */
+		REG_WRITE(SCL_SCALER_ENABLE, 0);
 
+		/* Clear registers that can cause glitches even when the scaler is off */
+		REG_WRITE(SCL_TAP_CONTROL, 0);
+		REG_WRITE(SCL_AUTOMATIC_MODE_CONTROL, 0);
+		REG_WRITE(SCL_F_SHARP_CONTROL, 0);
 		return false;
 	}
 
@@ -165,7 +168,7 @@ static bool dce60_setup_scaling_configuration(
 			SCL_H_NUM_OF_TAPS, data->taps.h_taps - 1,
 			SCL_V_NUM_OF_TAPS, data->taps.v_taps - 1);
 
-	/* DCE6 has no SCL_MODE register, skip scale mode programming */
+	REG_WRITE(SCL_SCALER_ENABLE, 1);
 
 	/* DCE6 has no SCL_BOUNDARY_MODE bit, skip replace out of bound pixels */
 
@@ -502,6 +505,8 @@ static void dce60_transform_set_scaler(
 	REG_SET(DC_LB_MEM_SIZE, 0,
 		DC_LB_MEM_SIZE, xfm_dce->lb_memory_size);
 
+	REG_WRITE(SCL_UPDATE, 0x00010000);
+
 	/* Clear SCL_F_SHARP_CONTROL value to 0 */
 	REG_WRITE(SCL_F_SHARP_CONTROL, 0);
 
@@ -527,8 +532,7 @@ static void dce60_transform_set_scaler(
 		if (coeffs_v != xfm_dce->filter_v || coeffs_h != xfm_dce->filter_h) {
 			/* 4. Program vertical filters */
 			if (xfm_dce->filter_v == NULL)
-				REG_SET(SCL_VERT_FILTER_CONTROL, 0,
-						SCL_V_2TAP_HARDCODE_COEF_EN, 0);
+				REG_WRITE(SCL_VERT_FILTER_CONTROL, 0);
 			program_multi_taps_filter(
 					xfm_dce,
 					data->taps.v_taps,
@@ -542,8 +546,7 @@ static void dce60_transform_set_scaler(
 
 			/* 5. Program horizontal filters */
 			if (xfm_dce->filter_h == NULL)
-				REG_SET(SCL_HORZ_FILTER_CONTROL, 0,
-						SCL_H_2TAP_HARDCODE_COEF_EN, 0);
+				REG_WRITE(SCL_HORZ_FILTER_CONTROL, 0);
 			program_multi_taps_filter(
 					xfm_dce,
 					data->taps.h_taps,
@@ -566,6 +569,8 @@ static void dce60_transform_set_scaler(
 	/* DCE6 has no SCL_COEF_UPDATE_COMPLETE bit to flip to new coefficient memory */
 
 	/* DCE6 DATA_FORMAT register does not support ALPHA_EN */
+
+	REG_WRITE(SCL_UPDATE, 0);
 }
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
index cbce194ec7b8..eb716e8337e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
@@ -155,6 +155,9 @@
 	SRI(SCL_COEF_RAM_TAP_DATA, SCL, id), \
 	SRI(VIEWPORT_START, SCL, id), \
 	SRI(VIEWPORT_SIZE, SCL, id), \
+	SRI(SCL_SCALER_ENABLE, SCL, id), \
+	SRI(SCL_HORZ_FILTER_INIT_RGB_LUMA, SCL, id), \
+	SRI(SCL_HORZ_FILTER_INIT_CHROMA, SCL, id), \
 	SRI(SCL_HORZ_FILTER_SCALE_RATIO, SCL, id), \
 	SRI(SCL_VERT_FILTER_SCALE_RATIO, SCL, id), \
 	SRI(SCL_VERT_FILTER_INIT, SCL, id), \
@@ -590,6 +593,7 @@ struct dce_transform_registers {
 	uint32_t SCL_VERT_FILTER_SCALE_RATIO;
 	uint32_t SCL_HORZ_FILTER_INIT;
 #if defined(CONFIG_DRM_AMD_DC_SI)
+	uint32_t SCL_SCALER_ENABLE;
 	uint32_t SCL_HORZ_FILTER_INIT_RGB_LUMA;
 	uint32_t SCL_HORZ_FILTER_INIT_CHROMA;
 #endif
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index 1b2df97226a3..40286e8dd4e1 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -25,7 +25,9 @@
 
 #include "hdcp.h"
 
+#ifndef MIN
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
+#endif
 #define HDCP_I2C_ADDR 0x3a	/* 0x74 >> 1*/
 #define KSV_READ_SIZE 0xf	/* 0x6803b - 0x6802c */
 #define HDCP_MAX_AUX_TRANSACTION_SIZE 16
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h
index 9de01ae574c0..067eddd9c62d 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h
@@ -4115,6 +4115,7 @@
 #define mmSCL0_SCL_COEF_RAM_CONFLICT_STATUS 0x1B55
 #define mmSCL0_SCL_COEF_RAM_SELECT 0x1B40
 #define mmSCL0_SCL_COEF_RAM_TAP_DATA 0x1B41
+#define mmSCL0_SCL_SCALER_ENABLE 0x1B42
 #define mmSCL0_SCL_CONTROL 0x1B44
 #define mmSCL0_SCL_DEBUG 0x1B6A
 #define mmSCL0_SCL_DEBUG2 0x1B69
@@ -4144,6 +4145,7 @@
 #define mmSCL1_SCL_COEF_RAM_CONFLICT_STATUS 0x1E55
 #define mmSCL1_SCL_COEF_RAM_SELECT 0x1E40
 #define mmSCL1_SCL_COEF_RAM_TAP_DATA 0x1E41
+#define mmSCL1_SCL_SCALER_ENABLE 0x1E42
 #define mmSCL1_SCL_CONTROL 0x1E44
 #define mmSCL1_SCL_DEBUG 0x1E6A
 #define mmSCL1_SCL_DEBUG2 0x1E69
@@ -4173,6 +4175,7 @@
 #define mmSCL2_SCL_COEF_RAM_CONFLICT_STATUS 0x4155
 #define mmSCL2_SCL_COEF_RAM_SELECT 0x4140
 #define mmSCL2_SCL_COEF_RAM_TAP_DATA 0x4141
+#define mmSCL2_SCL_SCALER_ENABLE 0x4142
 #define mmSCL2_SCL_CONTROL 0x4144
 #define mmSCL2_SCL_DEBUG 0x416A
 #define mmSCL2_SCL_DEBUG2 0x4169
@@ -4202,6 +4205,7 @@
 #define mmSCL3_SCL_COEF_RAM_CONFLICT_STATUS 0x4455
 #define mmSCL3_SCL_COEF_RAM_SELECT 0x4440
 #define mmSCL3_SCL_COEF_RAM_TAP_DATA 0x4441
+#define mmSCL3_SCL_SCALER_ENABLE 0x4442
 #define mmSCL3_SCL_CONTROL 0x4444
 #define mmSCL3_SCL_DEBUG 0x446A
 #define mmSCL3_SCL_DEBUG2 0x4469
@@ -4231,6 +4235,7 @@
 #define mmSCL4_SCL_COEF_RAM_CONFLICT_STATUS 0x4755
 #define mmSCL4_SCL_COEF_RAM_SELECT 0x4740
 #define mmSCL4_SCL_COEF_RAM_TAP_DATA 0x4741
+#define mmSCL4_SCL_SCALER_ENABLE 0x4742
 #define mmSCL4_SCL_CONTROL 0x4744
 #define mmSCL4_SCL_DEBUG 0x476A
 #define mmSCL4_SCL_DEBUG2 0x4769
@@ -4260,6 +4265,7 @@
 #define mmSCL5_SCL_COEF_RAM_CONFLICT_STATUS 0x4A55
 #define mmSCL5_SCL_COEF_RAM_SELECT 0x4A40
 #define mmSCL5_SCL_COEF_RAM_TAP_DATA 0x4A41
+#define mmSCL5_SCL_SCALER_ENABLE 0x4A42
 #define mmSCL5_SCL_CONTROL 0x4A44
 #define mmSCL5_SCL_DEBUG 0x4A6A
 #define mmSCL5_SCL_DEBUG2 0x4A69
@@ -4287,6 +4293,7 @@
 #define mmSCL_COEF_RAM_CONFLICT_STATUS 0x1B55
 #define mmSCL_COEF_RAM_SELECT 0x1B40
 #define mmSCL_COEF_RAM_TAP_DATA 0x1B41
+#define mmSCL_SCALER_ENABLE 0x1B42
 #define mmSCL_CONTROL 0x1B44
 #define mmSCL_DEBUG 0x1B6A
 #define mmSCL_DEBUG2 0x1B69
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
index 41c4a46ce357..afe7303802c6 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
@@ -8646,6 +8646,8 @@
 #define REGAMMA_LUT_INDEX__REGAMMA_LUT_INDEX__SHIFT 0x00000000
 #define REGAMMA_LUT_WRITE_EN_MASK__REGAMMA_LUT_WRITE_EN_MASK_MASK 0x00000007L
 #define REGAMMA_LUT_WRITE_EN_MASK__REGAMMA_LUT_WRITE_EN_MASK__SHIFT 0x00000000
+#define SCL_SCALER_ENABLE__SCL_SCALE_EN_MASK 0x00000001L
+#define SCL_SCALER_ENABLE__SCL_SCALE_EN__SHIFT 0x00000000
 #define SCL_ALU_CONTROL__SCL_ALU_DISABLE_MASK 0x00000001L
 #define SCL_ALU_CONTROL__SCL_ALU_DISABLE__SHIFT 0x00000000
 #define SCL_BYPASS_CONTROL__SCL_BYPASS_MODE_MASK 0x00000003L
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
index dac29fe6cfc6..abbdb7731996 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
@@ -22,12 +22,18 @@
  */
 #include <asm/div64.h>
 
-#define SHIFT_AMOUNT 16 /* We multiply all original integers with 2^SHIFT_AMOUNT to get the fInt representation */
+enum ppevvmath_constants {
+	/* We multiply all original integers with 2^SHIFT_AMOUNT to get the fInt representation */
+	SHIFT_AMOUNT	= 16,
 
-#define PRECISION 5 /* Change this value to change the number of decimal places in the final output - 5 is a good default */
+	/* Change this value to change the number of decimal places in the final output - 5 is a good default */
+	PRECISION	=  5,
 
-#define SHIFTED_2 (2 << SHIFT_AMOUNT)
-#define MAX (1 << (SHIFT_AMOUNT - 1)) - 1 /* 32767 - Might change in the future */
+	SHIFTED_2	= (2 << SHIFT_AMOUNT),
+
+	/* 32767 - Might change in the future */
+	MAX		= (1 << (SHIFT_AMOUNT - 1)) - 1,
+};
 
 /* -------------------------------------------------------------------------------
  * NEW TYPE - fINT
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index d4fde146bd4c..95894c25881a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1964,7 +1964,9 @@ static void sienna_cichlid_get_override_pcie_settings(struct smu_context *smu,
 	}
 }
 
+#ifndef MAX
 #define MAX(a, b)	((a) > (b) ? (a) : (b))
+#endif
 
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					 uint32_t pcie_gen_cap,
diff --git a/drivers/gpu/drm/arm/display/include/malidp_utils.h b/drivers/gpu/drm/arm/display/include/malidp_utils.h
index 49a1d7f3539c..9f83baac6ed8 100644
--- a/drivers/gpu/drm/arm/display/include/malidp_utils.h
+++ b/drivers/gpu/drm/arm/display/include/malidp_utils.h
@@ -35,7 +35,7 @@ static inline void set_range(struct malidp_range *rg, u32 start, u32 end)
 	rg->end   = end;
 }
 
-static inline bool in_range(struct malidp_range *rg, u32 v)
+static inline bool malidp_in_range(struct malidp_range *rg, u32 v)
 {
 	return (v >= rg->start) && (v <= rg->end);
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index c956fda918be..4aa527ca765b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -305,12 +305,12 @@ komeda_layer_check_cfg(struct komeda_layer *layer,
 	if (komeda_fb_check_src_coords(kfb, src_x, src_y, src_w, src_h))
 		return -EINVAL;
 
-	if (!in_range(&layer->hsize_in, src_w)) {
+	if (!malidp_in_range(&layer->hsize_in, src_w)) {
 		DRM_DEBUG_ATOMIC("invalidate src_w %d.\n", src_w);
 		return -EINVAL;
 	}
 
-	if (!in_range(&layer->vsize_in, src_h)) {
+	if (!malidp_in_range(&layer->vsize_in, src_h)) {
 		DRM_DEBUG_ATOMIC("invalidate src_h %d.\n", src_h);
 		return -EINVAL;
 	}
@@ -452,14 +452,14 @@ komeda_scaler_check_cfg(struct komeda_scaler *scaler,
 	hsize_out = dflow->out_w;
 	vsize_out = dflow->out_h;
 
-	if (!in_range(&scaler->hsize, hsize_in) ||
-	    !in_range(&scaler->hsize, hsize_out)) {
+	if (!malidp_in_range(&scaler->hsize, hsize_in) ||
+	    !malidp_in_range(&scaler->hsize, hsize_out)) {
 		DRM_DEBUG_ATOMIC("Invalid horizontal sizes");
 		return -EINVAL;
 	}
 
-	if (!in_range(&scaler->vsize, vsize_in) ||
-	    !in_range(&scaler->vsize, vsize_out)) {
+	if (!malidp_in_range(&scaler->vsize, vsize_in) ||
+	    !malidp_in_range(&scaler->vsize, vsize_out)) {
 		DRM_DEBUG_ATOMIC("Invalid vertical sizes");
 		return -EINVAL;
 	}
@@ -574,13 +574,13 @@ komeda_splitter_validate(struct komeda_splitter *splitter,
 		return -EINVAL;
 	}
 
-	if (!in_range(&splitter->hsize, dflow->in_w)) {
+	if (!malidp_in_range(&splitter->hsize, dflow->in_w)) {
 		DRM_DEBUG_ATOMIC("split in_w:%d is out of the acceptable range.\n",
 				 dflow->in_w);
 		return -EINVAL;
 	}
 
-	if (!in_range(&splitter->vsize, dflow->in_h)) {
+	if (!malidp_in_range(&splitter->vsize, dflow->in_h)) {
 		DRM_DEBUG_ATOMIC("split in_h: %d exceeds the acceptable range.\n",
 				 dflow->in_h);
 		return -EINVAL;
@@ -624,13 +624,13 @@ komeda_merger_validate(struct komeda_merger *merger,
 		return -EINVAL;
 	}
 
-	if (!in_range(&merger->hsize_merged, output->out_w)) {
+	if (!malidp_in_range(&merger->hsize_merged, output->out_w)) {
 		DRM_DEBUG_ATOMIC("merged_w: %d is out of the accepted range.\n",
 				 output->out_w);
 		return -EINVAL;
 	}
 
-	if (!in_range(&merger->vsize_merged, output->out_h)) {
+	if (!malidp_in_range(&merger->vsize_merged, output->out_h)) {
 		DRM_DEBUG_ATOMIC("merged_h: %d is out of the accepted range.\n",
 				 output->out_h);
 		return -EINVAL;
@@ -866,8 +866,8 @@ void komeda_complete_data_flow_cfg(struct komeda_layer *layer,
 	 * input/output range.
 	 */
 	if (dflow->en_scaling && scaler)
-		dflow->en_split = !in_range(&scaler->hsize, dflow->in_w) ||
-				  !in_range(&scaler->hsize, dflow->out_w);
+		dflow->en_split = !malidp_in_range(&scaler->hsize, dflow->in_w) ||
+				  !malidp_in_range(&scaler->hsize, dflow->out_w);
 }
 
 static bool merger_is_available(struct komeda_pipeline *pipe,
diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index bb14f488c8f6..1ff572d8744e 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -528,7 +528,7 @@ int drm_plane_create_color_properties(struct drm_plane *plane,
 {
 	struct drm_device *dev = plane->dev;
 	struct drm_property *prop;
-	struct drm_prop_enum_list enum_list[max_t(int, DRM_COLOR_ENCODING_MAX,
+	struct drm_prop_enum_list enum_list[MAX_T(int, DRM_COLOR_ENCODING_MAX,
 						       DRM_COLOR_RANGE_MAX)];
 	int i, len;
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index f1daa923f346..9215322fc915 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -676,12 +676,6 @@ struct block_header {
 	u32 data[];
 };
 
-/* this should be a general kernel helper */
-static int in_range(u32 addr, u32 start, u32 size)
-{
-	return addr >= start && addr < start + size;
-}
-
 static bool fw_block_mem(struct a6xx_gmu_bo *bo, const struct block_header *blk)
 {
 	if (!in_range(blk->addr, bo->iova, bo->size))
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 4b16266ac76a..21e81546b157 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -791,7 +791,7 @@ nouveau_bo_move_prep(struct nouveau_drm *drm, struct ttm_buffer_object *bo,
 		nvif_vmm_put(vmm, &old_mem->vma[1]);
 		nvif_vmm_put(vmm, &old_mem->vma[0]);
 	}
-	return 0;
+	return ret;
 }
 
 static int
diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index 820c2c3641d3..1311f10fad66 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -33,8 +33,10 @@
 #include "evergreen_reg_safe.h"
 #include "cayman_reg_safe.h"
 
+#ifndef MIN
 #define MAX(a,b)                   (((a)>(b))?(a):(b))
 #define MIN(a,b)                   (((a)<(b))?(a):(b))
+#endif
 
 #define REG_SAFE_BM_SIZE ARRAY_SIZE(evergreen_reg_safe_bm)
 
diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
index 7fe2c4985498..d5e5f08deeec 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -1410,7 +1410,7 @@ static void r600_texture_size(unsigned nfaces, unsigned blevel, unsigned llevel,
 			      unsigned block_align, unsigned height_align, unsigned base_align,
 			      unsigned *l0_size, unsigned *mipmap_size)
 {
-	unsigned offset, i, level;
+	unsigned offset, i;
 	unsigned width, height, depth, size;
 	unsigned blocksize;
 	unsigned nbx, nby;
@@ -1422,7 +1422,7 @@ static void r600_texture_size(unsigned nfaces, unsigned blevel, unsigned llevel,
 	w0 = r600_mip_minify(w0, 0);
 	h0 = r600_mip_minify(h0, 0);
 	d0 = r600_mip_minify(d0, 0);
-	for(i = 0, offset = 0, level = blevel; i < nlevels; i++, level++) {
+	for (i = 0, offset = 0; i < nlevels; i++) {
 		width = r600_mip_minify(w0, i);
 		nbx = r600_fmt_get_nblocksx(format, width);
 
diff --git a/drivers/gpu/drm/vmwgfx/Makefile b/drivers/gpu/drm/vmwgfx/Makefile
index 18edc7ca5b45..59b0b77456dd 100644
--- a/drivers/gpu/drm/vmwgfx/Makefile
+++ b/drivers/gpu/drm/vmwgfx/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-vmwgfx-y := vmwgfx_execbuf.o vmwgfx_gmr.o vmwgfx_kms.o vmwgfx_drv.o \
+vmwgfx-y := vmwgfx_execbuf.o vmwgfx_gmr.o vmwgfx_hashtab.o vmwgfx_kms.o vmwgfx_drv.o \
 	    vmwgfx_ioctl.o vmwgfx_resource.o vmwgfx_ttm_buffer.o \
 	    vmwgfx_cmd.o vmwgfx_irq.o vmwgfx_ldu.o vmwgfx_ttm_glue.o \
 	    vmwgfx_overlay.o vmwgfx_gmrid_manager.o vmwgfx_fence.o \
diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index 04789b2bb2a2..123ab2cbec48 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -70,7 +70,7 @@ struct ttm_object_file {
 	struct ttm_object_device *tdev;
 	spinlock_t lock;
 	struct list_head ref_list;
-	struct drm_open_hash ref_hash[TTM_REF_NUM];
+	struct vmwgfx_open_hash ref_hash[TTM_REF_NUM];
 	struct kref refcount;
 };
 
@@ -88,7 +88,7 @@ struct ttm_object_file {
 
 struct ttm_object_device {
 	spinlock_t object_lock;
-	struct drm_open_hash object_hash;
+	struct vmwgfx_open_hash object_hash;
 	atomic_t object_count;
 	struct ttm_mem_global *mem_glob;
 	struct dma_buf_ops ops;
@@ -120,7 +120,7 @@ struct ttm_object_device {
 
 struct ttm_ref_object {
 	struct rcu_head rcu_head;
-	struct drm_hash_item hash;
+	struct vmwgfx_hash_item hash;
 	struct list_head head;
 	struct kref kref;
 	enum ttm_ref_type ref_type;
@@ -244,12 +244,12 @@ void ttm_base_object_unref(struct ttm_base_object **p_base)
 struct ttm_base_object *
 ttm_base_object_noref_lookup(struct ttm_object_file *tfile, uint32_t key)
 {
-	struct drm_hash_item *hash;
-	struct drm_open_hash *ht = &tfile->ref_hash[TTM_REF_USAGE];
+	struct vmwgfx_hash_item *hash;
+	struct vmwgfx_open_hash *ht = &tfile->ref_hash[TTM_REF_USAGE];
 	int ret;
 
 	rcu_read_lock();
-	ret = drm_ht_find_item_rcu(ht, key, &hash);
+	ret = vmwgfx_ht_find_item_rcu(ht, key, &hash);
 	if (ret) {
 		rcu_read_unlock();
 		return NULL;
@@ -264,12 +264,12 @@ struct ttm_base_object *ttm_base_object_lookup(struct ttm_object_file *tfile,
 					       uint32_t key)
 {
 	struct ttm_base_object *base = NULL;
-	struct drm_hash_item *hash;
-	struct drm_open_hash *ht = &tfile->ref_hash[TTM_REF_USAGE];
+	struct vmwgfx_hash_item *hash;
+	struct vmwgfx_open_hash *ht = &tfile->ref_hash[TTM_REF_USAGE];
 	int ret;
 
 	rcu_read_lock();
-	ret = drm_ht_find_item_rcu(ht, key, &hash);
+	ret = vmwgfx_ht_find_item_rcu(ht, key, &hash);
 
 	if (likely(ret == 0)) {
 		base = drm_hash_entry(hash, struct ttm_ref_object, hash)->obj;
@@ -309,12 +309,12 @@ ttm_base_object_lookup_for_ref(struct ttm_object_device *tdev, uint32_t key)
 bool ttm_ref_object_exists(struct ttm_object_file *tfile,
 			   struct ttm_base_object *base)
 {
-	struct drm_open_hash *ht = &tfile->ref_hash[TTM_REF_USAGE];
-	struct drm_hash_item *hash;
+	struct vmwgfx_open_hash *ht = &tfile->ref_hash[TTM_REF_USAGE];
+	struct vmwgfx_hash_item *hash;
 	struct ttm_ref_object *ref;
 
 	rcu_read_lock();
-	if (unlikely(drm_ht_find_item_rcu(ht, base->handle, &hash) != 0))
+	if (unlikely(vmwgfx_ht_find_item_rcu(ht, base->handle, &hash) != 0))
 		goto out_false;
 
 	/*
@@ -346,9 +346,9 @@ int ttm_ref_object_add(struct ttm_object_file *tfile,
 		       enum ttm_ref_type ref_type, bool *existed,
 		       bool require_existed)
 {
-	struct drm_open_hash *ht = &tfile->ref_hash[ref_type];
+	struct vmwgfx_open_hash *ht = &tfile->ref_hash[ref_type];
 	struct ttm_ref_object *ref;
-	struct drm_hash_item *hash;
+	struct vmwgfx_hash_item *hash;
 	struct ttm_mem_global *mem_glob = tfile->tdev->mem_glob;
 	struct ttm_operation_ctx ctx = {
 		.interruptible = false,
@@ -364,7 +364,7 @@ int ttm_ref_object_add(struct ttm_object_file *tfile,
 
 	while (ret == -EINVAL) {
 		rcu_read_lock();
-		ret = drm_ht_find_item_rcu(ht, base->handle, &hash);
+		ret = vmwgfx_ht_find_item_rcu(ht, base->handle, &hash);
 
 		if (ret == 0) {
 			ref = drm_hash_entry(hash, struct ttm_ref_object, hash);
@@ -395,7 +395,7 @@ int ttm_ref_object_add(struct ttm_object_file *tfile,
 		kref_init(&ref->kref);
 
 		spin_lock(&tfile->lock);
-		ret = drm_ht_insert_item_rcu(ht, &ref->hash);
+		ret = vmwgfx_ht_insert_item_rcu(ht, &ref->hash);
 
 		if (likely(ret == 0)) {
 			list_add_tail(&ref->head, &tfile->ref_list);
@@ -423,11 +423,11 @@ ttm_ref_object_release(struct kref *kref)
 	    container_of(kref, struct ttm_ref_object, kref);
 	struct ttm_base_object *base = ref->obj;
 	struct ttm_object_file *tfile = ref->tfile;
-	struct drm_open_hash *ht;
+	struct vmwgfx_open_hash *ht;
 	struct ttm_mem_global *mem_glob = tfile->tdev->mem_glob;
 
 	ht = &tfile->ref_hash[ref->ref_type];
-	(void)drm_ht_remove_item_rcu(ht, &ref->hash);
+	(void)vmwgfx_ht_remove_item_rcu(ht, &ref->hash);
 	list_del(&ref->head);
 	spin_unlock(&tfile->lock);
 
@@ -443,13 +443,13 @@ ttm_ref_object_release(struct kref *kref)
 int ttm_ref_object_base_unref(struct ttm_object_file *tfile,
 			      unsigned long key, enum ttm_ref_type ref_type)
 {
-	struct drm_open_hash *ht = &tfile->ref_hash[ref_type];
+	struct vmwgfx_open_hash *ht = &tfile->ref_hash[ref_type];
 	struct ttm_ref_object *ref;
-	struct drm_hash_item *hash;
+	struct vmwgfx_hash_item *hash;
 	int ret;
 
 	spin_lock(&tfile->lock);
-	ret = drm_ht_find_item(ht, key, &hash);
+	ret = vmwgfx_ht_find_item(ht, key, &hash);
 	if (unlikely(ret != 0)) {
 		spin_unlock(&tfile->lock);
 		return -EINVAL;
@@ -483,7 +483,7 @@ void ttm_object_file_release(struct ttm_object_file **p_tfile)
 
 	spin_unlock(&tfile->lock);
 	for (i = 0; i < TTM_REF_NUM; ++i)
-		drm_ht_remove(&tfile->ref_hash[i]);
+		vmwgfx_ht_remove(&tfile->ref_hash[i]);
 
 	ttm_object_file_unref(&tfile);
 }
@@ -505,7 +505,7 @@ struct ttm_object_file *ttm_object_file_init(struct ttm_object_device *tdev,
 	INIT_LIST_HEAD(&tfile->ref_list);
 
 	for (i = 0; i < TTM_REF_NUM; ++i) {
-		ret = drm_ht_create(&tfile->ref_hash[i], hash_order);
+		ret = vmwgfx_ht_create(&tfile->ref_hash[i], hash_order);
 		if (ret) {
 			j = i;
 			goto out_err;
@@ -515,7 +515,7 @@ struct ttm_object_file *ttm_object_file_init(struct ttm_object_device *tdev,
 	return tfile;
 out_err:
 	for (i = 0; i < j; ++i)
-		drm_ht_remove(&tfile->ref_hash[i]);
+		vmwgfx_ht_remove(&tfile->ref_hash[i]);
 
 	kfree(tfile);
 
@@ -536,7 +536,7 @@ ttm_object_device_init(struct ttm_mem_global *mem_glob,
 	tdev->mem_glob = mem_glob;
 	spin_lock_init(&tdev->object_lock);
 	atomic_set(&tdev->object_count, 0);
-	ret = drm_ht_create(&tdev->object_hash, hash_order);
+	ret = vmwgfx_ht_create(&tdev->object_hash, hash_order);
 	if (ret != 0)
 		goto out_no_object_hash;
 
@@ -561,7 +561,7 @@ void ttm_object_device_release(struct ttm_object_device **p_tdev)
 
 	WARN_ON_ONCE(!idr_is_empty(&tdev->idr));
 	idr_destroy(&tdev->idr);
-	drm_ht_remove(&tdev->object_hash);
+	vmwgfx_ht_remove(&tdev->object_hash);
 
 	kfree(tdev);
 }
diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.h b/drivers/gpu/drm/vmwgfx/ttm_object.h
index 49b064f0cb19..6885ccbeec7a 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.h
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.h
@@ -42,9 +42,8 @@
 #include <linux/list.h>
 #include <linux/rcupdate.h>
 
-#include <drm/drm_hashtab.h>
-
 #include "ttm_memory.h"
+#include "vmwgfx_hashtab.h"
 
 /**
  * enum ttm_ref_type
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
index 8381750db81b..494cb98061f2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
@@ -42,7 +42,7 @@
  */
 struct vmw_cmdbuf_res {
 	struct vmw_resource *res;
-	struct drm_hash_item hash;
+	struct vmwgfx_hash_item hash;
 	struct list_head head;
 	enum vmw_cmdbuf_res_state state;
 	struct vmw_cmdbuf_res_manager *man;
@@ -59,7 +59,7 @@ struct vmw_cmdbuf_res {
  * @resources and @list are protected by the cmdbuf mutex for now.
  */
 struct vmw_cmdbuf_res_manager {
-	struct drm_open_hash resources;
+	struct vmwgfx_open_hash resources;
 	struct list_head list;
 	struct vmw_private *dev_priv;
 };
@@ -81,11 +81,11 @@ vmw_cmdbuf_res_lookup(struct vmw_cmdbuf_res_manager *man,
 		      enum vmw_cmdbuf_res_type res_type,
 		      u32 user_key)
 {
-	struct drm_hash_item *hash;
+	struct vmwgfx_hash_item *hash;
 	int ret;
 	unsigned long key = user_key | (res_type << 24);
 
-	ret = drm_ht_find_item(&man->resources, key, &hash);
+	ret = vmwgfx_ht_find_item(&man->resources, key, &hash);
 	if (unlikely(ret != 0))
 		return ERR_PTR(ret);
 
@@ -105,7 +105,7 @@ static void vmw_cmdbuf_res_free(struct vmw_cmdbuf_res_manager *man,
 				struct vmw_cmdbuf_res *entry)
 {
 	list_del(&entry->head);
-	WARN_ON(drm_ht_remove_item(&man->resources, &entry->hash));
+	WARN_ON(vmwgfx_ht_remove_item(&man->resources, &entry->hash));
 	vmw_resource_unreference(&entry->res);
 	kfree(entry);
 }
@@ -167,7 +167,7 @@ void vmw_cmdbuf_res_revert(struct list_head *list)
 			vmw_cmdbuf_res_free(entry->man, entry);
 			break;
 		case VMW_CMDBUF_RES_DEL:
-			ret = drm_ht_insert_item(&entry->man->resources, &entry->hash);
+			ret = vmwgfx_ht_insert_item(&entry->man->resources, &entry->hash);
 			BUG_ON(ret);
 			list_move_tail(&entry->head, &entry->man->list);
 			entry->state = VMW_CMDBUF_RES_COMMITTED;
@@ -206,7 +206,7 @@ int vmw_cmdbuf_res_add(struct vmw_cmdbuf_res_manager *man,
 		return -ENOMEM;
 
 	cres->hash.key = user_key | (res_type << 24);
-	ret = drm_ht_insert_item(&man->resources, &cres->hash);
+	ret = vmwgfx_ht_insert_item(&man->resources, &cres->hash);
 	if (unlikely(ret != 0)) {
 		kfree(cres);
 		goto out_invalid_key;
@@ -244,10 +244,10 @@ int vmw_cmdbuf_res_remove(struct vmw_cmdbuf_res_manager *man,
 			  struct vmw_resource **res_p)
 {
 	struct vmw_cmdbuf_res *entry;
-	struct drm_hash_item *hash;
+	struct vmwgfx_hash_item *hash;
 	int ret;
 
-	ret = drm_ht_find_item(&man->resources, user_key | (res_type << 24),
+	ret = vmwgfx_ht_find_item(&man->resources, user_key | (res_type << 24),
 			       &hash);
 	if (likely(ret != 0))
 		return -EINVAL;
@@ -260,7 +260,7 @@ int vmw_cmdbuf_res_remove(struct vmw_cmdbuf_res_manager *man,
 		*res_p = NULL;
 		break;
 	case VMW_CMDBUF_RES_COMMITTED:
-		(void) drm_ht_remove_item(&man->resources, &entry->hash);
+		(void) vmwgfx_ht_remove_item(&man->resources, &entry->hash);
 		list_del(&entry->head);
 		entry->state = VMW_CMDBUF_RES_DEL;
 		list_add_tail(&entry->head, list);
@@ -295,7 +295,7 @@ vmw_cmdbuf_res_man_create(struct vmw_private *dev_priv)
 
 	man->dev_priv = dev_priv;
 	INIT_LIST_HEAD(&man->list);
-	ret = drm_ht_create(&man->resources, VMW_CMDBUF_RES_MAN_HT_ORDER);
+	ret = vmwgfx_ht_create(&man->resources, VMW_CMDBUF_RES_MAN_HT_ORDER);
 	if (ret == 0)
 		return man;
 
@@ -320,7 +320,7 @@ void vmw_cmdbuf_res_man_destroy(struct vmw_cmdbuf_res_manager *man)
 	list_for_each_entry_safe(entry, next, &man->list, head)
 		vmw_cmdbuf_res_free(man, entry);
 
-	drm_ht_remove(&man->resources);
+	vmwgfx_ht_remove(&man->resources);
 	kfree(man);
 }
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 0f09a9116b05..4fea95a65041 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1149,7 +1149,7 @@ static void vmw_driver_unload(struct drm_device *dev)
 	unregister_pm_notifier(&dev_priv->pm_nb);
 
 	if (dev_priv->ctx.res_ht_initialized)
-		drm_ht_remove(&dev_priv->ctx.res_ht);
+		vmwgfx_ht_remove(&dev_priv->ctx.res_ht);
 	vfree(dev_priv->ctx.cmd_bounce);
 	if (dev_priv->enable_fb) {
 		vmw_fb_off(dev_priv);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 9c60bb2aefe1..1099cb5e2500 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -34,7 +34,6 @@
 #include <drm/drm_auth.h>
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
-#include <drm/drm_hashtab.h>
 #include <drm/drm_rect.h>
 
 #include <drm/ttm/ttm_bo_driver.h>
@@ -43,6 +42,7 @@
 #include "ttm_object.h"
 
 #include "vmwgfx_fence.h"
+#include "vmwgfx_hashtab.h"
 #include "vmwgfx_reg.h"
 #include "vmwgfx_validation.h"
 
@@ -131,7 +131,7 @@ struct vmw_buffer_object {
  */
 struct vmw_validate_buffer {
 	struct ttm_validate_buffer base;
-	struct drm_hash_item hash;
+	struct vmwgfx_hash_item hash;
 	bool validate_as_mob;
 };
 
@@ -404,7 +404,7 @@ struct vmw_ctx_validation_info;
  * @ctx: The validation context
  */
 struct vmw_sw_context{
-	struct drm_open_hash res_ht;
+	struct vmwgfx_open_hash res_ht;
 	bool res_ht_initialized;
 	bool kernel;
 	struct vmw_fpriv *fp;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 21134c7f1838..7dd42c5a7fd6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -4112,7 +4112,7 @@ int vmw_execbuf_process(struct drm_file *file_priv,
 		vmw_binding_state_reset(sw_context->staged_bindings);
 
 	if (!sw_context->res_ht_initialized) {
-		ret = drm_ht_create(&sw_context->res_ht, VMW_RES_HT_ORDER);
+		ret = vmwgfx_ht_create(&sw_context->res_ht, VMW_RES_HT_ORDER);
 		if (unlikely(ret != 0))
 			goto out_unlock;
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_hashtab.c b/drivers/gpu/drm/vmwgfx/vmwgfx_hashtab.c
new file mode 100644
index 000000000000..06aebc12774e
--- /dev/null
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_hashtab.c
@@ -0,0 +1,199 @@
+/*
+ * Copyright 2006 Tungsten Graphics, Inc., Bismarck, ND. USA.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/*
+ * Simple open hash tab implementation.
+ *
+ * Authors:
+ * Thomas Hellström <thomas-at-tungstengraphics-dot-com>
+ */
+
+#include <linux/export.h>
+#include <linux/hash.h>
+#include <linux/mm.h>
+#include <linux/rculist.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include <drm/drm_print.h>
+
+#include "vmwgfx_hashtab.h"
+
+int vmwgfx_ht_create(struct vmwgfx_open_hash *ht, unsigned int order)
+{
+	unsigned int size = 1 << order;
+
+	ht->order = order;
+	ht->table = NULL;
+	if (size <= PAGE_SIZE / sizeof(*ht->table))
+		ht->table = kcalloc(size, sizeof(*ht->table), GFP_KERNEL);
+	else
+		ht->table = vzalloc(array_size(size, sizeof(*ht->table)));
+	if (!ht->table) {
+		DRM_ERROR("Out of memory for hash table\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+void vmwgfx_ht_verbose_list(struct vmwgfx_open_hash *ht, unsigned long key)
+{
+	struct vmwgfx_hash_item *entry;
+	struct hlist_head *h_list;
+	unsigned int hashed_key;
+	int count = 0;
+
+	hashed_key = hash_long(key, ht->order);
+	DRM_DEBUG("Key is 0x%08lx, Hashed key is 0x%08x\n", key, hashed_key);
+	h_list = &ht->table[hashed_key];
+	hlist_for_each_entry(entry, h_list, head)
+		DRM_DEBUG("count %d, key: 0x%08lx\n", count++, entry->key);
+}
+
+static struct hlist_node *vmwgfx_ht_find_key(struct vmwgfx_open_hash *ht, unsigned long key)
+{
+	struct vmwgfx_hash_item *entry;
+	struct hlist_head *h_list;
+	unsigned int hashed_key;
+
+	hashed_key = hash_long(key, ht->order);
+	h_list = &ht->table[hashed_key];
+	hlist_for_each_entry(entry, h_list, head) {
+		if (entry->key == key)
+			return &entry->head;
+		if (entry->key > key)
+			break;
+	}
+	return NULL;
+}
+
+static struct hlist_node *vmwgfx_ht_find_key_rcu(struct vmwgfx_open_hash *ht, unsigned long key)
+{
+	struct vmwgfx_hash_item *entry;
+	struct hlist_head *h_list;
+	unsigned int hashed_key;
+
+	hashed_key = hash_long(key, ht->order);
+	h_list = &ht->table[hashed_key];
+	hlist_for_each_entry_rcu(entry, h_list, head) {
+		if (entry->key == key)
+			return &entry->head;
+		if (entry->key > key)
+			break;
+	}
+	return NULL;
+}
+
+int vmwgfx_ht_insert_item(struct vmwgfx_open_hash *ht, struct vmwgfx_hash_item *item)
+{
+	struct vmwgfx_hash_item *entry;
+	struct hlist_head *h_list;
+	struct hlist_node *parent;
+	unsigned int hashed_key;
+	unsigned long key = item->key;
+
+	hashed_key = hash_long(key, ht->order);
+	h_list = &ht->table[hashed_key];
+	parent = NULL;
+	hlist_for_each_entry(entry, h_list, head) {
+		if (entry->key == key)
+			return -EINVAL;
+		if (entry->key > key)
+			break;
+		parent = &entry->head;
+	}
+	if (parent)
+		hlist_add_behind_rcu(&item->head, parent);
+	else
+		hlist_add_head_rcu(&item->head, h_list);
+	return 0;
+}
+
+/*
+ * Just insert an item and return any "bits" bit key that hasn't been
+ * used before.
+ */
+int vmwgfx_ht_just_insert_please(struct vmwgfx_open_hash *ht, struct vmwgfx_hash_item *item,
+				 unsigned long seed, int bits, int shift,
+				 unsigned long add)
+{
+	int ret;
+	unsigned long mask = (1UL << bits) - 1;
+	unsigned long first, unshifted_key;
+
+	unshifted_key = hash_long(seed, bits);
+	first = unshifted_key;
+	do {
+		item->key = (unshifted_key << shift) + add;
+		ret = vmwgfx_ht_insert_item(ht, item);
+		if (ret)
+			unshifted_key = (unshifted_key + 1) & mask;
+	} while (ret && (unshifted_key != first));
+
+	if (ret) {
+		DRM_ERROR("Available key bit space exhausted\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int vmwgfx_ht_find_item(struct vmwgfx_open_hash *ht, unsigned long key,
+			struct vmwgfx_hash_item **item)
+{
+	struct hlist_node *list;
+
+	list = vmwgfx_ht_find_key_rcu(ht, key);
+	if (!list)
+		return -EINVAL;
+
+	*item = hlist_entry(list, struct vmwgfx_hash_item, head);
+	return 0;
+}
+
+int vmwgfx_ht_remove_key(struct vmwgfx_open_hash *ht, unsigned long key)
+{
+	struct hlist_node *list;
+
+	list = vmwgfx_ht_find_key(ht, key);
+	if (list) {
+		hlist_del_init_rcu(list);
+		return 0;
+	}
+	return -EINVAL;
+}
+
+int vmwgfx_ht_remove_item(struct vmwgfx_open_hash *ht, struct vmwgfx_hash_item *item)
+{
+	hlist_del_init_rcu(&item->head);
+	return 0;
+}
+
+void vmwgfx_ht_remove(struct vmwgfx_open_hash *ht)
+{
+	if (ht->table) {
+		kvfree(ht->table);
+		ht->table = NULL;
+	}
+}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_hashtab.h b/drivers/gpu/drm/vmwgfx/vmwgfx_hashtab.h
new file mode 100644
index 000000000000..a9ce12922e21
--- /dev/null
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_hashtab.h
@@ -0,0 +1,83 @@
+/*
+ * Copyright 2006 Tungsten Graphics, Inc., Bismack, ND. USA.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/*
+ * Simple open hash tab implementation.
+ *
+ * Authors:
+ * Thomas Hellström <thomas-at-tungstengraphics-dot-com>
+ */
+
+/*
+ * TODO: Replace this hashtable with Linux' generic implementation
+ *       from <linux/hashtable.h>.
+ */
+
+#ifndef VMWGFX_HASHTAB_H
+#define VMWGFX_HASHTAB_H
+
+#include <linux/list.h>
+
+#define drm_hash_entry(_ptr, _type, _member) container_of(_ptr, _type, _member)
+
+struct vmwgfx_hash_item {
+	struct hlist_node head;
+	unsigned long key;
+};
+
+struct vmwgfx_open_hash {
+	struct hlist_head *table;
+	u8 order;
+};
+
+int vmwgfx_ht_create(struct vmwgfx_open_hash *ht, unsigned int order);
+int vmwgfx_ht_insert_item(struct vmwgfx_open_hash *ht, struct vmwgfx_hash_item *item);
+int vmwgfx_ht_just_insert_please(struct vmwgfx_open_hash *ht, struct vmwgfx_hash_item *item,
+				 unsigned long seed, int bits, int shift,
+				 unsigned long add);
+int vmwgfx_ht_find_item(struct vmwgfx_open_hash *ht, unsigned long key,
+			struct vmwgfx_hash_item **item);
+
+void vmwgfx_ht_verbose_list(struct vmwgfx_open_hash *ht, unsigned long key);
+int vmwgfx_ht_remove_key(struct vmwgfx_open_hash *ht, unsigned long key);
+int vmwgfx_ht_remove_item(struct vmwgfx_open_hash *ht, struct vmwgfx_hash_item *item);
+void vmwgfx_ht_remove(struct vmwgfx_open_hash *ht);
+
+/*
+ * RCU-safe interface
+ *
+ * The user of this API needs to make sure that two or more instances of the
+ * hash table manipulation functions are never run simultaneously.
+ * The lookup function vmwgfx_ht_find_item_rcu may, however, run simultaneously
+ * with any of the manipulation functions as long as it's called from within
+ * an RCU read-locked section.
+ */
+#define vmwgfx_ht_insert_item_rcu vmwgfx_ht_insert_item
+#define vmwgfx_ht_just_insert_please_rcu vmwgfx_ht_just_insert_please
+#define vmwgfx_ht_remove_key_rcu vmwgfx_ht_remove_key
+#define vmwgfx_ht_remove_item_rcu vmwgfx_ht_remove_item
+#define vmwgfx_ht_find_item_rcu vmwgfx_ht_find_item
+
+#endif
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
index b09094b50c5d..4633bd308185 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
@@ -43,7 +43,7 @@
  */
 struct vmw_validation_bo_node {
 	struct ttm_validate_buffer base;
-	struct drm_hash_item hash;
+	struct vmwgfx_hash_item hash;
 	unsigned int coherent_count;
 	u32 as_mob : 1;
 	u32 cpu_blit : 1;
@@ -72,7 +72,7 @@ struct vmw_validation_bo_node {
  */
 struct vmw_validation_res_node {
 	struct list_head head;
-	struct drm_hash_item hash;
+	struct vmwgfx_hash_item hash;
 	struct vmw_resource *res;
 	struct vmw_buffer_object *new_backup;
 	unsigned long new_backup_offset;
@@ -184,9 +184,9 @@ vmw_validation_find_bo_dup(struct vmw_validation_context *ctx,
 		return NULL;
 
 	if (ctx->ht) {
-		struct drm_hash_item *hash;
+		struct vmwgfx_hash_item *hash;
 
-		if (!drm_ht_find_item(ctx->ht, (unsigned long) vbo, &hash))
+		if (!vmwgfx_ht_find_item(ctx->ht, (unsigned long) vbo, &hash))
 			bo_node = container_of(hash, typeof(*bo_node), hash);
 	} else {
 		struct  vmw_validation_bo_node *entry;
@@ -221,9 +221,9 @@ vmw_validation_find_res_dup(struct vmw_validation_context *ctx,
 		return NULL;
 
 	if (ctx->ht) {
-		struct drm_hash_item *hash;
+		struct vmwgfx_hash_item *hash;
 
-		if (!drm_ht_find_item(ctx->ht, (unsigned long) res, &hash))
+		if (!vmwgfx_ht_find_item(ctx->ht, (unsigned long) res, &hash))
 			res_node = container_of(hash, typeof(*res_node), hash);
 	} else {
 		struct  vmw_validation_res_node *entry;
@@ -280,7 +280,7 @@ int vmw_validation_add_bo(struct vmw_validation_context *ctx,
 
 		if (ctx->ht) {
 			bo_node->hash.key = (unsigned long) vbo;
-			ret = drm_ht_insert_item(ctx->ht, &bo_node->hash);
+			ret = vmwgfx_ht_insert_item(ctx->ht, &bo_node->hash);
 			if (ret) {
 				DRM_ERROR("Failed to initialize a buffer "
 					  "validation entry.\n");
@@ -335,7 +335,7 @@ int vmw_validation_add_resource(struct vmw_validation_context *ctx,
 
 	if (ctx->ht) {
 		node->hash.key = (unsigned long) res;
-		ret = drm_ht_insert_item(ctx->ht, &node->hash);
+		ret = vmwgfx_ht_insert_item(ctx->ht, &node->hash);
 		if (ret) {
 			DRM_ERROR("Failed to initialize a resource validation "
 				  "entry.\n");
@@ -343,8 +343,10 @@ int vmw_validation_add_resource(struct vmw_validation_context *ctx,
 		}
 	}
 	node->res = vmw_resource_reference_unless_doomed(res);
-	if (!node->res)
+	if (!node->res) {
+		hash_del_rcu(&node->hash.head);
 		return -ESRCH;
+	}
 
 	node->first_usage = 1;
 	if (!res->dev_priv->has_mob) {
@@ -688,13 +690,13 @@ void vmw_validation_drop_ht(struct vmw_validation_context *ctx)
 		return;
 
 	list_for_each_entry(entry, &ctx->bo_list, base.head)
-		(void) drm_ht_remove_item(ctx->ht, &entry->hash);
+		(void) vmwgfx_ht_remove_item(ctx->ht, &entry->hash);
 
 	list_for_each_entry(val, &ctx->resource_list, head)
-		(void) drm_ht_remove_item(ctx->ht, &val->hash);
+		(void) vmwgfx_ht_remove_item(ctx->ht, &val->hash);
 
 	list_for_each_entry(val, &ctx->resource_ctx_list, head)
-		(void) drm_ht_remove_item(ctx->ht, &val->hash);
+		(void) vmwgfx_ht_remove_item(ctx->ht, &val->hash);
 
 	ctx->ht = NULL;
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
index 739906d1b3eb..495fd504b8c6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
@@ -31,9 +31,10 @@
 #include <linux/list.h>
 #include <linux/ww_mutex.h>
 
-#include <drm/drm_hashtab.h>
 #include <drm/ttm/ttm_execbuf_util.h>
 
+#include "vmwgfx_hashtab.h"
+
 #define VMW_RES_DIRTY_NONE 0
 #define VMW_RES_DIRTY_SET BIT(0)
 #define VMW_RES_DIRTY_CLEAR BIT(1)
@@ -73,7 +74,7 @@ struct vmw_validation_mem {
  * @total_mem: Amount of reserved memory.
  */
 struct vmw_validation_context {
-	struct drm_open_hash *ht;
+	struct vmwgfx_open_hash *ht;
 	struct list_head resource_list;
 	struct list_head resource_ctx_list;
 	struct list_head bo_list;
@@ -151,7 +152,7 @@ vmw_validation_set_val_mem(struct vmw_validation_context *ctx,
  * available at validation context declaration time
  */
 static inline void vmw_validation_set_ht(struct vmw_validation_context *ctx,
-					 struct drm_open_hash *ht)
+					 struct vmwgfx_open_hash *ht)
 {
 	ctx->ht = ht;
 }
diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 69076d52dccf..589f13ff0b60 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -791,6 +791,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 			}
 			if (data[2] == MCP2221_I2C_READ_COMPL ||
 			    data[2] == MCP2221_I2C_READ_PARTIAL) {
+				if (!mcp->rxbuf || mcp->rxbuf_idx < 0 || data[3] > 60) {
+					mcp->status = -EINVAL;
+					break;
+				}
 				buf = mcp->rxbuf;
 				memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
 				mcp->rxbuf_idx = mcp->rxbuf_idx + data[3];
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index b4c0f01f52c4..1e0678eb0077 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -23,23 +23,23 @@
 #include <linux/util_macros.h>
 
 /* Indexes for the sysfs hooks */
-
-#define INPUT		0
-#define MIN		1
-#define MAX		2
-#define CONTROL		3
-#define OFFSET		3
-#define AUTOMIN		4
-#define THERM		5
-#define HYSTERSIS	6
-
+enum adt_sysfs_id {
+	INPUT		= 0,
+	MIN		= 1,
+	MAX		= 2,
+	CONTROL		= 3,
+	OFFSET		= 3,	// Dup
+	AUTOMIN		= 4,
+	THERM		= 5,
+	HYSTERSIS	= 6,
 /*
  * These are unique identifiers for the sysfs functions - unlike the
  * numbers above, these are not also indexes into an array
  */
+	ALARM		= 9,
+	FAULT		= 10,
+};
 
-#define ALARM		9
-#define FAULT		10
 
 /* 7475 Common Registers */
 
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index fac63d092c7b..dfdb5d426325 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -18,7 +18,8 @@
 #include <asm/barrier.h>
 #include "coresight-trbe.h"
 
-#define PERF_IDX2OFF(idx, buf) ((idx) % ((buf)->nr_pages << PAGE_SHIFT))
+#define PERF_IDX2OFF(idx, buf) \
+	((idx) % ((unsigned long)(buf)->nr_pages << PAGE_SHIFT))
 
 /*
  * A padding packet that will help the user space tools
@@ -502,12 +503,12 @@ static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
 
 	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, trbe_alloc_node(event));
 	if (!buf)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
 	if (!pglist) {
 		kfree(buf);
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	}
 
 	for (i = 0; i < nr_pages; i++)
@@ -517,7 +518,7 @@ static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
 	if (!buf->trbe_base) {
 		kfree(pglist);
 		kfree(buf);
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	}
 	buf->trbe_limit = buf->trbe_base + nr_pages * PAGE_SIZE;
 	buf->trbe_write = buf->trbe_base;
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 718bebe4fb87..09fcd155c641 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -322,6 +322,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 
 exit_probe:
 	dw_i2c_plat_pm_cleanup(dev);
+	i2c_dw_prepare_clk(dev, false);
 exit_reset:
 	reset_control_assert(dev->rst);
 	return ret;
diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 72acda59eb39..03e5d488f874 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -1067,6 +1067,7 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 {
 	int ret;
 	int left_num = num;
+	bool write_then_read_en = false;
 	struct mtk_i2c *i2c = i2c_get_adapdata(adap);
 
 	ret = mtk_i2c_clock_enable(i2c);
@@ -1080,6 +1081,7 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 		if (!(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD) &&
 		    msgs[0].addr == msgs[1].addr) {
 			i2c->auto_restart = 0;
+			write_then_read_en = true;
 		}
 	}
 
@@ -1104,12 +1106,10 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 		else
 			i2c->op = I2C_MASTER_WR;
 
-		if (!i2c->auto_restart) {
-			if (num > 1) {
-				/* combined two messages into one transaction */
-				i2c->op = I2C_MASTER_WRRD;
-				left_num--;
-			}
+		if (write_then_read_en) {
+			/* combined two messages into one transaction */
+			i2c->op = I2C_MASTER_WRRD;
+			left_num--;
 		}
 
 		/* always use DMA mode. */
@@ -1117,7 +1117,10 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 		if (ret < 0)
 			goto err_exit;
 
-		msgs++;
+		if (i2c->op == I2C_MASTER_WRRD)
+			msgs += 2;
+		else
+			msgs++;
 	}
 	/* the return value is number of executed messages */
 	ret = num;
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 62a4d06bcfb5..27f55b5e388d 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -308,6 +308,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
 	if (ret) {
 		dev_err(master->dev, "Timeout when polling for COMPLETE\n");
+		i3c_generic_ibi_recycle_slot(data->ibi_pool, slot);
 		return ret;
 	}
 
diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index 2d3b14c407d8..819ec9a0a7f1 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -262,7 +262,7 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
 	unsigned int clr)
 {
 	struct ad5360_state *st = iio_priv(indio_dev);
-	unsigned int ret;
+	int ret;
 
 	mutex_lock(&st->lock);
 
diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index eedf661d32b2..a7d6900e6540 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -186,7 +186,7 @@ static int ad5421_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
 	unsigned int clr)
 {
 	struct ad5421_state *st = iio_priv(indio_dev);
-	unsigned int ret;
+	int ret;
 
 	mutex_lock(&st->lock);
 
diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 3d9eba716b69..43c667d88c3f 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -143,6 +143,19 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
 	if (freq > ADF4350_MAX_OUT_FREQ || freq < st->min_out_freq)
 		return -EINVAL;
 
+	st->r4_rf_div_sel = 0;
+
+	/*
+	 * !\TODO: The below computation is making sure we get a power of 2
+	 * shift (st->r4_rf_div_sel) so that freq becomes higher or equal to
+	 * ADF4350_MIN_VCO_FREQ. This might be simplified with fls()/fls_long()
+	 * and friends.
+	 */
+	while (freq < ADF4350_MIN_VCO_FREQ) {
+		freq <<= 1;
+		st->r4_rf_div_sel++;
+	}
+
 	if (freq > ADF4350_MAX_FREQ_45_PRESC) {
 		prescaler = ADF4350_REG1_PRESCALER;
 		mdiv = 75;
@@ -151,13 +164,6 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
 		mdiv = 23;
 	}
 
-	st->r4_rf_div_sel = 0;
-
-	while (freq < ADF4350_MIN_VCO_FREQ) {
-		freq <<= 1;
-		st->r4_rf_div_sel++;
-	}
-
 	/*
 	 * Allow a predefined reference division factor
 	 * if not set, compute our own
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 9dec4ad38c0d..f955c3d01fef 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -730,10 +730,6 @@ static int __maybe_unused inv_icm42600_resume(struct device *dev)
 	if (ret)
 		goto out_unlock;
 
-	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
 	/* restore sensors state */
 	ret = inv_icm42600_set_pwr_mgmt0(st, st->suspended.gyro,
 					 st->suspended.accel,
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 5eabb54c1fc7..8815747e67be 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -619,7 +619,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		 * If no channel scaling is available apply consumer scale to
 		 * raw value and return.
 		 */
-		*processed = raw * scale;
+		*processed = raw64 * scale;
 		return 0;
 	}
 
diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 65e3e7df8a4b..779e9af479fd 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -461,14 +461,10 @@ static int addr_resolve_neigh(const struct dst_entry *dst,
 {
 	int ret = 0;
 
-	if (ndev_flags & IFF_LOOPBACK) {
+	if (ndev_flags & IFF_LOOPBACK)
 		memcpy(addr->dst_dev_addr, addr->src_dev_addr, MAX_ADDR_LEN);
-	} else {
-		if (!(ndev_flags & IFF_NOARP)) {
-			/* If the device doesn't do ARP internally */
-			ret = fetch_ha(dst, addr, dst_in, seq);
-		}
-	}
+	else
+		ret = fetch_ha(dst, addr, dst_in, seq);
 	return ret;
 }
 
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 96e00e86ebbf..5dc864cec9f8 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1039,8 +1039,8 @@ static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id,
 	struct cm_id_private *cm_id_priv;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	pr_err("%s: cm_id=%p timed out. state %d -> %d, refcnt=%d\n", __func__,
-	       cm_id, old_state, cm_id->state, refcount_read(&cm_id_priv->refcount));
+	pr_err_ratelimited("%s: cm_id=%p timed out. state %d -> %d, refcnt=%d\n", __func__,
+			   cm_id, old_state, cm_id->state, refcount_read(&cm_id_priv->refcount));
 }
 
 static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 1557c71dd152..2b13cf6e827c 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -982,6 +982,8 @@ int ib_nl_handle_set_timeout(struct sk_buff *skb,
 	if (timeout > IB_SA_LOCAL_SVC_TIMEOUT_MAX)
 		timeout = IB_SA_LOCAL_SVC_TIMEOUT_MAX;
 
+	spin_lock_irqsave(&ib_nl_request_lock, flags);
+
 	delta = timeout - sa_local_svc_timeout_ms;
 	if (delta < 0)
 		abs_delta = -delta;
@@ -989,7 +991,6 @@ int ib_nl_handle_set_timeout(struct sk_buff *skb,
 		abs_delta = delta;
 
 	if (delta != 0) {
-		spin_lock_irqsave(&ib_nl_request_lock, flags);
 		sa_local_svc_timeout_ms = timeout;
 		list_for_each_entry(query, &ib_nl_request_list, list) {
 			if (delta < 0 && abs_delta > query->timeout)
@@ -1007,9 +1008,10 @@ int ib_nl_handle_set_timeout(struct sk_buff *skb,
 		if (delay)
 			mod_delayed_work(ib_nl_wq, &ib_nl_timed_work,
 					 (unsigned long)delay);
-		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
 	}
 
+	spin_unlock_irqrestore(&ib_nl_request_lock, flags);
+
 settimeout_out:
 	return 0;
 }
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 124242e387a5..c83701d04c95 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -759,7 +759,7 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 	struct siw_wqe *wqe = tx_wqe(qp);
 
 	unsigned long flags;
-	int rv = 0;
+	int rv = 0, imm_err = 0;
 
 	if (wr && !rdma_is_kernel_res(&qp->base_qp.res)) {
 		siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
@@ -945,9 +945,17 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 	 * Send directly if SQ processing is not in progress.
 	 * Eventual immediate errors (rv < 0) do not affect the involved
 	 * RI resources (Verbs, 8.3.1) and thus do not prevent from SQ
-	 * processing, if new work is already pending. But rv must be passed
-	 * to caller.
+	 * processing, if new work is already pending. But rv and pointer
+	 * to failed work request must be passed to caller.
 	 */
+	if (unlikely(rv < 0)) {
+		/*
+		 * Immediate error
+		 */
+		siw_dbg_qp(qp, "Immediate error %d\n", rv);
+		imm_err = rv;
+		*bad_wr = wr;
+	}
 	if (wqe->wr_status != SIW_WR_IDLE) {
 		spin_unlock_irqrestore(&qp->sq_lock, flags);
 		goto skip_direct_sending;
@@ -972,15 +980,10 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 
 	up_read(&qp->state_lock);
 
-	if (rv >= 0)
-		return 0;
-	/*
-	 * Immediate error
-	 */
-	siw_dbg_qp(qp, "error %d\n", rv);
+	if (unlikely(imm_err))
+		return imm_err;
 
-	*bad_wr = wr;
-	return rv;
+	return (rv >= 0) ? 0 : rv;
 }
 
 /*
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 790db3ceb208..faed4590a8a9 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -741,6 +741,7 @@ static int uinput_ff_upload_to_user(char __user *buffer,
 	if (in_compat_syscall()) {
 		struct uinput_ff_upload_compat ff_up_compat;
 
+		memset(&ff_up_compat, 0, sizeof(ff_up_compat));
 		ff_up_compat.request_id = ff_up->request_id;
 		ff_up_compat.retval = ff_up->retval;
 		/*
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index eb66cd2689b7..cbff90382ad7 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3239,7 +3239,7 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (data->reset_gpio) {
 		/* Wait a while and then de-assert the RESET GPIO line */
 		msleep(MXT_RESET_GPIO_TIME);
-		gpiod_set_value(data->reset_gpio, 0);
+		gpiod_set_value_cansleep(data->reset_gpio, 0);
 		msleep(MXT_RESET_INVALID_CHG);
 	}
 
diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index dccbcb942fe5..936d69da3bda 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -871,7 +871,7 @@ static void cyttsp4_get_mt_touches(struct cyttsp4_mt_data *md, int num_cur_tch)
 	struct cyttsp4_touch tch;
 	int sig;
 	int i, j, t = 0;
-	int ids[max(CY_TMA1036_MAX_TCH, CY_TMA4XX_MAX_TCH)];
+	int ids[MAX(CY_TMA1036_MAX_TCH, CY_TMA4XX_MAX_TCH)];
 
 	memset(ids, 0, si->si_ofs.tch_abs[CY_TCH_T].max * sizeof(int));
 	for (i = 0; i < num_cur_tch; i++) {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 714c78bf69db..d3a11be8d1dd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2121,7 +2121,8 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 
 	r = (ops->unmap) ? ops->unmap(ops, iova, page_size, gather) : 0;
 
-	amd_iommu_iotlb_gather_add_page(dom, gather, iova, page_size);
+	if (r)
+		amd_iommu_iotlb_gather_add_page(dom, gather, iova, r);
 
 	return r;
 }
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 14a83b564db4..5cd1ac09e581 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2659,7 +2659,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 			}
 
 			if (info->ats_supported && ecap_prs(iommu->ecap) &&
-			    pci_pri_supported(pdev))
+			    ecap_pds(iommu->ecap) && pci_pri_supported(pdev))
 				info->pri_supported = 1;
 		}
 	}
diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
index 4cd3e533740b..74b1bd331425 100644
--- a/drivers/irqchip/irq-sun6i-r.c
+++ b/drivers/irqchip/irq-sun6i-r.c
@@ -268,7 +268,7 @@ static const struct irq_domain_ops sun6i_r_intc_domain_ops = {
 
 static int sun6i_r_intc_suspend(void)
 {
-	u32 buf[BITS_TO_U32(max(SUN6I_NR_TOP_LEVEL_IRQS, SUN6I_NR_MUX_BITS))];
+	u32 buf[BITS_TO_U32(MAX(SUN6I_NR_TOP_LEVEL_IRQS, SUN6I_NR_MUX_BITS))];
 	int i;
 
 	/* Wake IRQs are enabled during system sleep and shutdown. */
diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index be06de791c54..e64f7157f065 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -618,11 +618,8 @@ static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
 	i = pdata->num_mboxes;
 	for (; i >= 0; i--) {
 		ipi_mbox = &pdata->ipi_mboxes[i];
-		if (ipi_mbox->dev.parent) {
-			mbox_controller_unregister(&ipi_mbox->mbox);
-			if (device_is_registered(&ipi_mbox->dev))
-				device_unregister(&ipi_mbox->dev);
-		}
+		if (device_is_registered(&ipi_mbox->dev))
+			device_unregister(&ipi_mbox->dev);
 	}
 }
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index e9d553eea9cd..43d47ba8dabc 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -124,7 +124,7 @@ struct journal_sector {
 	commit_id_t commit_id;
 };
 
-#define MAX_TAG_SIZE			(JOURNAL_SECTOR_DATA - JOURNAL_MAC_PER_SECTOR - offsetof(struct journal_entry, last_bytes[MAX_SECTORS_PER_BLOCK]))
+#define MAX_TAG_SIZE			255
 
 #define METADATA_PADDING_SECTORS	8
 
@@ -1705,7 +1705,7 @@ static void integrity_metadata(struct work_struct *w)
 		struct bio *bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
 		char *checksums;
 		unsigned extra_space = unlikely(digest_size > ic->tag_size) ? digest_size - ic->tag_size : 0;
-		char checksums_onstack[max((size_t)HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
+		char checksums_onstack[MAX(HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 		sector_t sector;
 		unsigned sectors_to_process;
 
@@ -2536,7 +2536,7 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned write_start,
 				    unlikely(from_replay) &&
 #endif
 				    ic->internal_hash) {
-					char test_tag[max_t(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
+					char test_tag[MAX_T(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 
 					integrity_sector_checksum(ic, sec + ((l - j) << ic->sb->log2_sectors_per_block),
 								  (char *)access_journal_data(ic, i, l), test_tag);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8b192fc1f798..26bc77d20586 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2406,7 +2406,7 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 {
 	bool do_lockfs = suspend_flags & DM_SUSPEND_LOCKFS_FLAG;
 	bool noflush = suspend_flags & DM_SUSPEND_NOFLUSH_FLAG;
-	int r;
+	int r = 0;
 
 	lockdep_assert_held(&md->suspend_lock);
 
@@ -2458,7 +2458,7 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	 * Stop md->queue before flushing md->wq in case request-based
 	 * dm defers requests to md->wq from md->queue.
 	 */
-	if (dm_request_based(md))
+	if (map && dm_request_based(md))
 		dm_stop_queue(md->queue);
 
 	flush_workqueue(md->wq);
@@ -2468,7 +2468,8 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	 * We call dm_wait_for_completion to wait for all existing requests
 	 * to finish.
 	 */
-	r = dm_wait_for_completion(md, task_state);
+	if (map)
+		r = dm_wait_for_completion(md, task_state);
 	if (!r)
 		set_bit(dmf_suspended_flag, &md->flags);
 
diff --git a/drivers/media/dvb-frontends/stv0367_priv.h b/drivers/media/dvb-frontends/stv0367_priv.h
index 617f605947b2..7f056d1cce82 100644
--- a/drivers/media/dvb-frontends/stv0367_priv.h
+++ b/drivers/media/dvb-frontends/stv0367_priv.h
@@ -25,8 +25,11 @@
 #endif
 
 /* MACRO definitions */
+#ifndef MIN
 #define MAX(X, Y) ((X) >= (Y) ? (X) : (Y))
 #define MIN(X, Y) ((X) <= (Y) ? (X) : (Y))
+#endif
+
 #define INRANGE(X, Y, Z) \
 	((((X) <= (Y)) && ((Y) <= (Z))) || \
 	(((Z) <= (Y)) && ((Y) <= (X))) ? 1 : 0)
diff --git a/drivers/media/i2c/mt9v111.c b/drivers/media/i2c/mt9v111.c
index 2dc4a0f24ce8..e955b01a8eb8 100644
--- a/drivers/media/i2c/mt9v111.c
+++ b/drivers/media/i2c/mt9v111.c
@@ -534,8 +534,8 @@ static int mt9v111_calc_frame_rate(struct mt9v111_dev *mt9v111,
 static int mt9v111_hw_config(struct mt9v111_dev *mt9v111)
 {
 	struct i2c_client *c = mt9v111->client;
-	unsigned int ret;
 	u16 outfmtctrl2;
+	int ret;
 
 	/* Force device reset. */
 	ret = __mt9v111_hw_reset(mt9v111);
diff --git a/drivers/media/i2c/rj54n1cb0c.c b/drivers/media/i2c/rj54n1cb0c.c
index 2e4018c26912..f1953c819666 100644
--- a/drivers/media/i2c/rj54n1cb0c.c
+++ b/drivers/media/i2c/rj54n1cb0c.c
@@ -1332,10 +1332,13 @@ static int rj54n1_probe(struct i2c_client *client,
 			V4L2_CID_GAIN, 0, 127, 1, 66);
 	v4l2_ctrl_new_std(&rj54n1->hdl, &rj54n1_ctrl_ops,
 			V4L2_CID_AUTO_WHITE_BALANCE, 0, 1, 1, 1);
-	rj54n1->subdev.ctrl_handler = &rj54n1->hdl;
-	if (rj54n1->hdl.error)
-		return rj54n1->hdl.error;
 
+	if (rj54n1->hdl.error) {
+		ret = rj54n1->hdl.error;
+		goto err_free_ctrl;
+	}
+
+	rj54n1->subdev.ctrl_handler = &rj54n1->hdl;
 	rj54n1->clk_div		= clk_div;
 	rj54n1->rect.left	= RJ54N1_COLUMN_SKIP;
 	rj54n1->rect.top	= RJ54N1_ROW_SKIP;
diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index 3167beca4056..48f6fe8f1cc9 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -2201,10 +2201,10 @@ static int tc358743_probe(struct i2c_client *client)
 err_work_queues:
 	cec_unregister_adapter(state->cec_adap);
 	if (!state->i2c_client->irq) {
-		del_timer(&state->timer);
+		timer_delete_sync(&state->timer);
 		flush_work(&state->work_i2c_poll);
 	}
-	cancel_delayed_work(&state->delayed_work_enable_hotplug);
+	cancel_delayed_work_sync(&state->delayed_work_enable_hotplug);
 	mutex_destroy(&state->confctl_mutex);
 err_hdl:
 	media_entity_cleanup(&sd->entity);
diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
index f249199dc616..f8257aa5fc58 100644
--- a/drivers/media/mc/mc-devnode.c
+++ b/drivers/media/mc/mc-devnode.c
@@ -50,11 +50,6 @@ static void media_devnode_release(struct device *cd)
 {
 	struct media_devnode *devnode = to_media_devnode(cd);
 
-	mutex_lock(&media_devnode_lock);
-	/* Mark device node number as free */
-	clear_bit(devnode->minor, media_devnode_nums);
-	mutex_unlock(&media_devnode_lock);
-
 	/* Release media_devnode and perform other cleanups as needed. */
 	if (devnode->release)
 		devnode->release(devnode);
@@ -283,6 +278,7 @@ void media_devnode_unregister(struct media_devnode *devnode)
 	/* Delete the cdev on this minor as well */
 	cdev_device_del(&devnode->cdev, &devnode->dev);
 	devnode->media_dev = NULL;
+	clear_bit(devnode->minor, media_devnode_nums);
 	mutex_unlock(&media_devnode_lock);
 
 	put_device(&devnode->dev);
diff --git a/drivers/media/pci/b2c2/flexcop-pci.c b/drivers/media/pci/b2c2/flexcop-pci.c
index 486c8ec0fa60..ab53c5b02c48 100644
--- a/drivers/media/pci/b2c2/flexcop-pci.c
+++ b/drivers/media/pci/b2c2/flexcop-pci.c
@@ -411,7 +411,7 @@ static void flexcop_pci_remove(struct pci_dev *pdev)
 	struct flexcop_pci *fc_pci = pci_get_drvdata(pdev);
 
 	if (irq_chk_intv > 0)
-		cancel_delayed_work(&fc_pci->irq_check_work);
+		cancel_delayed_work_sync(&fc_pci->irq_check_work);
 
 	flexcop_pci_dma_exit(fc_pci);
 	flexcop_device_exit(fc_pci->fc_dev);
diff --git a/drivers/media/pci/cobalt/cobalt-driver.c b/drivers/media/pci/cobalt/cobalt-driver.c
index f9cee061517b..6e1a0614e6d0 100644
--- a/drivers/media/pci/cobalt/cobalt-driver.c
+++ b/drivers/media/pci/cobalt/cobalt-driver.c
@@ -333,8 +333,8 @@ static int cobalt_setup_pci(struct cobalt *cobalt, struct pci_dev *pci_dev,
 		}
 	}
 
-	if (pci_set_dma_mask(pci_dev, DMA_BIT_MASK(64))) {
-		ret = pci_set_dma_mask(pci_dev, DMA_BIT_MASK(32));
+	if (dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(64))) {
+		ret = dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(32));
 		if (ret) {
 			cobalt_err("no suitable DMA available\n");
 			goto err_disable;
diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
index f2440eb38820..59497ba6bf1f 100644
--- a/drivers/media/pci/cx18/cx18-driver.c
+++ b/drivers/media/pci/cx18/cx18-driver.c
@@ -804,7 +804,7 @@ static int cx18_setup_pci(struct cx18 *cx, struct pci_dev *pci_dev,
 		CX18_ERR("Can't enable device %d!\n", cx->instance);
 		return -EIO;
 	}
-	if (pci_set_dma_mask(pci_dev, DMA_BIT_MASK(32))) {
+	if (dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(32))) {
 		CX18_ERR("No suitable DMA available, card %d\n", cx->instance);
 		return -EIO;
 	}
diff --git a/drivers/media/pci/cx18/cx18-queue.c b/drivers/media/pci/cx18/cx18-queue.c
index 2f5df471dada..7cbb2d586932 100644
--- a/drivers/media/pci/cx18/cx18-queue.c
+++ b/drivers/media/pci/cx18/cx18-queue.c
@@ -325,8 +325,8 @@ void _cx18_mdl_sync_for_device(struct cx18_stream *s, struct cx18_mdl *mdl)
 	struct cx18_buffer *buf;
 
 	list_for_each_entry(buf, &mdl->buf_list, list)
-		pci_dma_sync_single_for_device(pci_dev, buf->dma_handle,
-					       buf_size, dma);
+		dma_sync_single_for_device(&pci_dev->dev, buf->dma_handle,
+					   buf_size, dma);
 }
 
 int cx18_stream_alloc(struct cx18_stream *s)
@@ -379,14 +379,22 @@ int cx18_stream_alloc(struct cx18_stream *s)
 			break;
 		}
 
+		buf->dma_handle = dma_map_single(&s->cx->pci_dev->dev,
+						 buf->buf, s->buf_size,
+						 s->dma);
+		if (dma_mapping_error(&s->cx->pci_dev->dev, buf->dma_handle)) {
+			kfree(buf->buf);
+			kfree(mdl);
+			kfree(buf);
+			break;
+		}
+
 		INIT_LIST_HEAD(&mdl->list);
 		INIT_LIST_HEAD(&mdl->buf_list);
 		mdl->id = s->mdl_base_idx; /* a somewhat safe value */
 		cx18_enqueue(s, mdl, &s->q_idle);
 
 		INIT_LIST_HEAD(&buf->list);
-		buf->dma_handle = pci_map_single(s->cx->pci_dev,
-				buf->buf, s->buf_size, s->dma);
 		cx18_buf_sync_for_cpu(s, buf);
 		list_add_tail(&buf->list, &s->buf_pool);
 	}
@@ -419,8 +427,8 @@ void cx18_stream_free(struct cx18_stream *s)
 		buf = list_first_entry(&s->buf_pool, struct cx18_buffer, list);
 		list_del_init(&buf->list);
 
-		pci_unmap_single(s->cx->pci_dev, buf->dma_handle,
-				s->buf_size, s->dma);
+		dma_unmap_single(&s->cx->pci_dev->dev, buf->dma_handle,
+				 s->buf_size, s->dma);
 		kfree(buf->buf);
 		kfree(buf);
 	}
diff --git a/drivers/media/pci/cx18/cx18-streams.c b/drivers/media/pci/cx18/cx18-streams.c
index c41bae118415..8537bcae524f 100644
--- a/drivers/media/pci/cx18/cx18-streams.c
+++ b/drivers/media/pci/cx18/cx18-streams.c
@@ -49,44 +49,44 @@ static struct {
 	{	/* CX18_ENC_STREAM_TYPE_MPG */
 		"encoder MPEG",
 		VFL_TYPE_VIDEO, 0,
-		PCI_DMA_FROMDEVICE,
+		DMA_FROM_DEVICE,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_READWRITE |
 		V4L2_CAP_AUDIO | V4L2_CAP_TUNER
 	},
 	{	/* CX18_ENC_STREAM_TYPE_TS */
 		"TS",
 		VFL_TYPE_VIDEO, -1,
-		PCI_DMA_FROMDEVICE,
+		DMA_FROM_DEVICE,
 	},
 	{	/* CX18_ENC_STREAM_TYPE_YUV */
 		"encoder YUV",
 		VFL_TYPE_VIDEO, CX18_V4L2_ENC_YUV_OFFSET,
-		PCI_DMA_FROMDEVICE,
+		DMA_FROM_DEVICE,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_READWRITE |
 		V4L2_CAP_STREAMING | V4L2_CAP_AUDIO | V4L2_CAP_TUNER
 	},
 	{	/* CX18_ENC_STREAM_TYPE_VBI */
 		"encoder VBI",
 		VFL_TYPE_VBI, 0,
-		PCI_DMA_FROMDEVICE,
+		DMA_FROM_DEVICE,
 		V4L2_CAP_VBI_CAPTURE | V4L2_CAP_SLICED_VBI_CAPTURE |
 		V4L2_CAP_READWRITE | V4L2_CAP_TUNER
 	},
 	{	/* CX18_ENC_STREAM_TYPE_PCM */
 		"encoder PCM audio",
 		VFL_TYPE_VIDEO, CX18_V4L2_ENC_PCM_OFFSET,
-		PCI_DMA_FROMDEVICE,
+		DMA_FROM_DEVICE,
 		V4L2_CAP_TUNER | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 	},
 	{	/* CX18_ENC_STREAM_TYPE_IDX */
 		"encoder IDX",
 		VFL_TYPE_VIDEO, -1,
-		PCI_DMA_FROMDEVICE,
+		DMA_FROM_DEVICE,
 	},
 	{	/* CX18_ENC_STREAM_TYPE_RAD */
 		"encoder radio",
 		VFL_TYPE_RADIO, 0,
-		PCI_DMA_NONE,
+		DMA_NONE,
 		V4L2_CAP_RADIO | V4L2_CAP_TUNER
 	},
 };
@@ -324,7 +324,7 @@ static int cx18_prep_dev(struct cx18 *cx, int type)
 
 	/* User explicitly selected 0 buffers for these streams, so don't
 	   create them. */
-	if (cx18_stream_info[type].dma != PCI_DMA_NONE &&
+	if (cx18_stream_info[type].dma != DMA_NONE &&
 	    cx->stream_buffers[type] == 0) {
 		CX18_INFO("Disabled %s device\n", cx18_stream_info[type].name);
 		return 0;
diff --git a/drivers/media/pci/ddbridge/ddbridge-main.c b/drivers/media/pci/ddbridge/ddbridge-main.c
index bb7fb6402d6e..5d9f861b9ede 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -180,8 +180,8 @@ static int ddb_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)))
-		if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32)))
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)))
+		if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32)))
 			return -ENODEV;
 
 	dev = vzalloc(sizeof(*dev));
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
index dfb2be0b9625..5a8778030d19 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
@@ -1760,7 +1760,7 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 
 	pci_set_master(pci_dev);
 
-	r = pci_set_dma_mask(pci_dev, CIO2_DMA_MASK);
+	r = dma_set_mask(&pci_dev->dev, CIO2_DMA_MASK);
 	if (r) {
 		dev_err(dev, "failed to set DMA mask (%d)\n", r);
 		return -ENODEV;
diff --git a/drivers/media/pci/ivtv/ivtv-driver.c b/drivers/media/pci/ivtv/ivtv-driver.c
index 8ebc97ebf1a2..57d4d5485d7a 100644
--- a/drivers/media/pci/ivtv/ivtv-driver.c
+++ b/drivers/media/pci/ivtv/ivtv-driver.c
@@ -837,7 +837,7 @@ static int ivtv_setup_pci(struct ivtv *itv, struct pci_dev *pdev,
 		IVTV_ERR("Can't enable device!\n");
 		return -EIO;
 	}
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32))) {
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))) {
 		IVTV_ERR("No suitable DMA available.\n");
 		return -EIO;
 	}
diff --git a/drivers/media/pci/ivtv/ivtv-irq.c b/drivers/media/pci/ivtv/ivtv-irq.c
index b7aaa8b4a784..e39bf64c5c71 100644
--- a/drivers/media/pci/ivtv/ivtv-irq.c
+++ b/drivers/media/pci/ivtv/ivtv-irq.c
@@ -351,7 +351,7 @@ void ivtv_dma_stream_dec_prepare(struct ivtv_stream *s, u32 offset, int lock)
 
 	/* Insert buffer block for YUV if needed */
 	if (s->type == IVTV_DEC_STREAM_TYPE_YUV && f->offset_y) {
-		if (yi->blanking_dmaptr) {
+		if (yi->blanking_ptr) {
 			s->sg_pending[idx].src = yi->blanking_dmaptr;
 			s->sg_pending[idx].dst = offset;
 			s->sg_pending[idx].size = 720 * 16;
diff --git a/drivers/media/pci/ivtv/ivtv-queue.c b/drivers/media/pci/ivtv/ivtv-queue.c
index 7ac4615e92ea..f9b192ab7e7c 100644
--- a/drivers/media/pci/ivtv/ivtv-queue.c
+++ b/drivers/media/pci/ivtv/ivtv-queue.c
@@ -188,7 +188,7 @@ int ivtv_stream_alloc(struct ivtv_stream *s)
 		return 0;
 
 	IVTV_DEBUG_INFO("Allocate %s%s stream: %d x %d buffers (%dkB total)\n",
-		s->dma != PCI_DMA_NONE ? "DMA " : "",
+		s->dma != DMA_NONE ? "DMA " : "",
 		s->name, s->buffers, s->buf_size, s->buffers * s->buf_size / 1024);
 
 	s->sg_pending = kzalloc(SGsize, GFP_KERNEL|__GFP_NOWARN);
@@ -218,8 +218,9 @@ int ivtv_stream_alloc(struct ivtv_stream *s)
 		return -ENOMEM;
 	}
 	if (ivtv_might_use_dma(s)) {
-		s->sg_handle = pci_map_single(itv->pdev, s->sg_dma,
-				sizeof(struct ivtv_sg_element), PCI_DMA_TODEVICE);
+		s->sg_handle = dma_map_single(&itv->pdev->dev, s->sg_dma,
+					      sizeof(struct ivtv_sg_element),
+					      DMA_TO_DEVICE);
 		ivtv_stream_sync_for_cpu(s);
 	}
 
@@ -237,7 +238,7 @@ int ivtv_stream_alloc(struct ivtv_stream *s)
 		}
 		INIT_LIST_HEAD(&buf->list);
 		if (ivtv_might_use_dma(s)) {
-			buf->dma_handle = pci_map_single(s->itv->pdev,
+			buf->dma_handle = dma_map_single(&s->itv->pdev->dev,
 				buf->buf, s->buf_size + 256, s->dma);
 			ivtv_buf_sync_for_cpu(s, buf);
 		}
@@ -260,8 +261,8 @@ void ivtv_stream_free(struct ivtv_stream *s)
 	/* empty q_free */
 	while ((buf = ivtv_dequeue(s, &s->q_free))) {
 		if (ivtv_might_use_dma(s))
-			pci_unmap_single(s->itv->pdev, buf->dma_handle,
-				s->buf_size + 256, s->dma);
+			dma_unmap_single(&s->itv->pdev->dev, buf->dma_handle,
+					 s->buf_size + 256, s->dma);
 		kfree(buf->buf);
 		kfree(buf);
 	}
@@ -269,8 +270,9 @@ void ivtv_stream_free(struct ivtv_stream *s)
 	/* Free SG Array/Lists */
 	if (s->sg_dma != NULL) {
 		if (s->sg_handle != IVTV_DMA_UNMAPPED) {
-			pci_unmap_single(s->itv->pdev, s->sg_handle,
-				 sizeof(struct ivtv_sg_element), PCI_DMA_TODEVICE);
+			dma_unmap_single(&s->itv->pdev->dev, s->sg_handle,
+					 sizeof(struct ivtv_sg_element),
+					 DMA_TO_DEVICE);
 			s->sg_handle = IVTV_DMA_UNMAPPED;
 		}
 		kfree(s->sg_pending);
diff --git a/drivers/media/pci/ivtv/ivtv-streams.c b/drivers/media/pci/ivtv/ivtv-streams.c
index f9de5d1605fe..13d7d55e6594 100644
--- a/drivers/media/pci/ivtv/ivtv-streams.c
+++ b/drivers/media/pci/ivtv/ivtv-streams.c
@@ -100,7 +100,7 @@ static struct {
 	{	/* IVTV_ENC_STREAM_TYPE_MPG */
 		"encoder MPG",
 		VFL_TYPE_VIDEO, 0,
-		PCI_DMA_FROMDEVICE, 0,
+		DMA_FROM_DEVICE, 0,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_TUNER |
 			V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_enc_fops
@@ -108,7 +108,7 @@ static struct {
 	{	/* IVTV_ENC_STREAM_TYPE_YUV */
 		"encoder YUV",
 		VFL_TYPE_VIDEO, IVTV_V4L2_ENC_YUV_OFFSET,
-		PCI_DMA_FROMDEVICE, 0,
+		DMA_FROM_DEVICE, 0,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_TUNER |
 			V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_enc_fops
@@ -116,7 +116,7 @@ static struct {
 	{	/* IVTV_ENC_STREAM_TYPE_VBI */
 		"encoder VBI",
 		VFL_TYPE_VBI, 0,
-		PCI_DMA_FROMDEVICE, 0,
+		DMA_FROM_DEVICE, 0,
 		V4L2_CAP_VBI_CAPTURE | V4L2_CAP_SLICED_VBI_CAPTURE | V4L2_CAP_TUNER |
 			V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_enc_fops
@@ -124,42 +124,42 @@ static struct {
 	{	/* IVTV_ENC_STREAM_TYPE_PCM */
 		"encoder PCM",
 		VFL_TYPE_VIDEO, IVTV_V4L2_ENC_PCM_OFFSET,
-		PCI_DMA_FROMDEVICE, 0,
+		DMA_FROM_DEVICE, 0,
 		V4L2_CAP_TUNER | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_enc_fops
 	},
 	{	/* IVTV_ENC_STREAM_TYPE_RAD */
 		"encoder radio",
 		VFL_TYPE_RADIO, 0,
-		PCI_DMA_NONE, 1,
+		DMA_NONE, 1,
 		V4L2_CAP_RADIO | V4L2_CAP_TUNER,
 		&ivtv_v4l2_radio_fops
 	},
 	{	/* IVTV_DEC_STREAM_TYPE_MPG */
 		"decoder MPG",
 		VFL_TYPE_VIDEO, IVTV_V4L2_DEC_MPG_OFFSET,
-		PCI_DMA_TODEVICE, 0,
+		DMA_TO_DEVICE, 0,
 		V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_dec_fops
 	},
 	{	/* IVTV_DEC_STREAM_TYPE_VBI */
 		"decoder VBI",
 		VFL_TYPE_VBI, IVTV_V4L2_DEC_VBI_OFFSET,
-		PCI_DMA_NONE, 1,
+		DMA_NONE, 1,
 		V4L2_CAP_SLICED_VBI_CAPTURE | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_enc_fops
 	},
 	{	/* IVTV_DEC_STREAM_TYPE_VOUT */
 		"decoder VOUT",
 		VFL_TYPE_VBI, IVTV_V4L2_DEC_VOUT_OFFSET,
-		PCI_DMA_NONE, 1,
+		DMA_NONE, 1,
 		V4L2_CAP_SLICED_VBI_OUTPUT | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_dec_fops
 	},
 	{	/* IVTV_DEC_STREAM_TYPE_YUV */
 		"decoder YUV",
 		VFL_TYPE_VIDEO, IVTV_V4L2_DEC_YUV_OFFSET,
-		PCI_DMA_TODEVICE, 0,
+		DMA_TO_DEVICE, 0,
 		V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_dec_fops
 	}
@@ -179,7 +179,7 @@ static void ivtv_stream_init(struct ivtv *itv, int type)
 	s->vdev.device_caps = ivtv_stream_info[type].v4l2_caps;
 
 	if (ivtv_stream_info[type].pio)
-		s->dma = PCI_DMA_NONE;
+		s->dma = DMA_NONE;
 	else
 		s->dma = ivtv_stream_info[type].dma;
 	s->buf_size = itv->stream_buf_size[type];
@@ -217,7 +217,7 @@ static int ivtv_prep_dev(struct ivtv *itv, int type)
 
 	/* User explicitly selected 0 buffers for these streams, so don't
 	   create them. */
-	if (ivtv_stream_info[type].dma != PCI_DMA_NONE &&
+	if (ivtv_stream_info[type].dma != DMA_NONE &&
 	    itv->options.kilobytes[type] == 0) {
 		IVTV_INFO("Disabled %s device\n", ivtv_stream_info[type].name);
 		return 0;
diff --git a/drivers/media/pci/ivtv/ivtv-udma.c b/drivers/media/pci/ivtv/ivtv-udma.c
index 0d8372cc364a..fd76f88975ae 100644
--- a/drivers/media/pci/ivtv/ivtv-udma.c
+++ b/drivers/media/pci/ivtv/ivtv-udma.c
@@ -81,8 +81,10 @@ void ivtv_udma_alloc(struct ivtv *itv)
 {
 	if (itv->udma.SG_handle == 0) {
 		/* Map DMA Page Array Buffer */
-		itv->udma.SG_handle = pci_map_single(itv->pdev, itv->udma.SGarray,
-			   sizeof(itv->udma.SGarray), PCI_DMA_TODEVICE);
+		itv->udma.SG_handle = dma_map_single(&itv->pdev->dev,
+						     itv->udma.SGarray,
+						     sizeof(itv->udma.SGarray),
+						     DMA_TO_DEVICE);
 		ivtv_udma_sync_for_cpu(itv);
 	}
 }
@@ -129,13 +131,22 @@ int ivtv_udma_setup(struct ivtv *itv, unsigned long ivtv_dest_addr,
 
 	/* Fill SG List with new values */
 	if (ivtv_udma_fill_sg_list(dma, &user_dma, 0) < 0) {
+		IVTV_DEBUG_WARN("%s: could not allocate bounce buffers for highmem userspace buffers\n",
+				__func__);
 		unpin_user_pages(dma->map, dma->page_count);
 		dma->page_count = 0;
 		return -ENOMEM;
 	}
 
 	/* Map SG List */
-	dma->SG_length = pci_map_sg(itv->pdev, dma->SGlist, dma->page_count, PCI_DMA_TODEVICE);
+	dma->SG_length = dma_map_sg(&itv->pdev->dev, dma->SGlist,
+				    dma->page_count, DMA_TO_DEVICE);
+	if (!dma->SG_length) {
+		IVTV_DEBUG_WARN("%s: DMA map error, SG_length is 0\n", __func__);
+		unpin_user_pages(dma->map, dma->page_count);
+		dma->page_count = 0;
+		return -EINVAL;
+	}
 
 	/* Fill SG Array with new values */
 	ivtv_udma_fill_sg_array (dma, ivtv_dest_addr, 0, -1);
@@ -159,7 +170,8 @@ void ivtv_udma_unmap(struct ivtv *itv)
 
 	/* Unmap Scatterlist */
 	if (dma->SG_length) {
-		pci_unmap_sg(itv->pdev, dma->SGlist, dma->page_count, PCI_DMA_TODEVICE);
+		dma_unmap_sg(&itv->pdev->dev, dma->SGlist, dma->page_count,
+			     DMA_TO_DEVICE);
 		dma->SG_length = 0;
 	}
 	/* sync DMA */
@@ -175,13 +187,14 @@ void ivtv_udma_free(struct ivtv *itv)
 
 	/* Unmap SG Array */
 	if (itv->udma.SG_handle) {
-		pci_unmap_single(itv->pdev, itv->udma.SG_handle,
-			 sizeof(itv->udma.SGarray), PCI_DMA_TODEVICE);
+		dma_unmap_single(&itv->pdev->dev, itv->udma.SG_handle,
+				 sizeof(itv->udma.SGarray), DMA_TO_DEVICE);
 	}
 
 	/* Unmap Scatterlist */
 	if (itv->udma.SG_length) {
-		pci_unmap_sg(itv->pdev, itv->udma.SGlist, itv->udma.page_count, PCI_DMA_TODEVICE);
+		dma_unmap_sg(&itv->pdev->dev, itv->udma.SGlist,
+			     itv->udma.page_count, DMA_TO_DEVICE);
 	}
 
 	for (i = 0; i < IVTV_DMA_SG_OSD_ENT; i++) {
diff --git a/drivers/media/pci/ivtv/ivtv-yuv.c b/drivers/media/pci/ivtv/ivtv-yuv.c
index 5f7dc9771f8d..c6573859843e 100644
--- a/drivers/media/pci/ivtv/ivtv-yuv.c
+++ b/drivers/media/pci/ivtv/ivtv-yuv.c
@@ -113,13 +113,20 @@ static int ivtv_yuv_prep_user_dma(struct ivtv *itv, struct ivtv_user_dma *dma,
 		dma->page_count = 0;
 		return -ENOMEM;
 	}
-	dma->SG_length = pci_map_sg(itv->pdev, dma->SGlist, dma->page_count, PCI_DMA_TODEVICE);
+	dma->SG_length = dma_map_sg(&itv->pdev->dev, dma->SGlist,
+				    dma->page_count, DMA_TO_DEVICE);
+	if (!dma->SG_length) {
+		IVTV_DEBUG_WARN("%s: DMA map error, SG_length is 0\n", __func__);
+		unpin_user_pages(dma->map, dma->page_count);
+		dma->page_count = 0;
+		return -EINVAL;
+	}
 
 	/* Fill SG Array with new values */
 	ivtv_udma_fill_sg_array(dma, y_buffer_offset, uv_buffer_offset, y_size);
 
 	/* If we've offset the y plane, ensure top area is blanked */
-	if (f->offset_y && yi->blanking_dmaptr) {
+	if (f->offset_y && yi->blanking_ptr) {
 		dma->SGarray[dma->SG_length].size = cpu_to_le32(720*16);
 		dma->SGarray[dma->SG_length].src = cpu_to_le32(yi->blanking_dmaptr);
 		dma->SGarray[dma->SG_length].dst = cpu_to_le32(IVTV_DECODER_OFFSET + yuv_offset[frame]);
@@ -920,7 +927,15 @@ static void ivtv_yuv_init(struct ivtv *itv)
 	/* We need a buffer for blanking when Y plane is offset - non-fatal if we can't get one */
 	yi->blanking_ptr = kzalloc(720 * 16, GFP_ATOMIC|__GFP_NOWARN);
 	if (yi->blanking_ptr) {
-		yi->blanking_dmaptr = pci_map_single(itv->pdev, yi->blanking_ptr, 720*16, PCI_DMA_TODEVICE);
+		yi->blanking_dmaptr = dma_map_single(&itv->pdev->dev,
+						     yi->blanking_ptr,
+						     720 * 16, DMA_TO_DEVICE);
+		if (dma_mapping_error(&itv->pdev->dev, yi->blanking_dmaptr)) {
+			kfree(yi->blanking_ptr);
+			yi->blanking_ptr = NULL;
+			yi->blanking_dmaptr = 0;
+			IVTV_DEBUG_WARN("Failed to dma_map yuv blanking buffer\n");
+		}
 	} else {
 		yi->blanking_dmaptr = 0;
 		IVTV_DEBUG_WARN("Failed to allocate yuv blanking buffer\n");
@@ -1264,7 +1279,8 @@ void ivtv_yuv_close(struct ivtv *itv)
 	if (yi->blanking_ptr) {
 		kfree(yi->blanking_ptr);
 		yi->blanking_ptr = NULL;
-		pci_unmap_single(itv->pdev, yi->blanking_dmaptr, 720*16, PCI_DMA_TODEVICE);
+		dma_unmap_single(&itv->pdev->dev, yi->blanking_dmaptr,
+				 720 * 16, DMA_TO_DEVICE);
 	}
 
 	/* Invalidate the old dimension information */
diff --git a/drivers/media/pci/ivtv/ivtvfb.c b/drivers/media/pci/ivtv/ivtvfb.c
index 5ad03b2a50bd..1f8b8caa69bd 100644
--- a/drivers/media/pci/ivtv/ivtvfb.c
+++ b/drivers/media/pci/ivtv/ivtvfb.c
@@ -281,10 +281,10 @@ static int ivtvfb_prep_dec_dma_to_device(struct ivtv *itv,
 	/* Map User DMA */
 	if (ivtv_udma_setup(itv, ivtv_dest_addr, userbuf, size_in_bytes) <= 0) {
 		mutex_unlock(&itv->udma.lock);
-		IVTVFB_WARN("ivtvfb_prep_dec_dma_to_device, Error with pin_user_pages: %d bytes, %d pages returned\n",
-			       size_in_bytes, itv->udma.page_count);
+		IVTVFB_WARN("%s, Error in ivtv_udma_setup: %d bytes, %d pages returned\n",
+			       __func__, size_in_bytes, itv->udma.page_count);
 
-		/* pin_user_pages must have failed completely */
+		/* pin_user_pages or DMA must have failed completely */
 		return -EIO;
 	}
 
diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index 7c5061953ee8..d85bfbb77a25 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -846,7 +846,7 @@ static int netup_unidvb_initdev(struct pci_dev *pci_dev,
 		"%s(): board vendor 0x%x, revision 0x%x\n",
 		__func__, board_vendor, board_revision);
 	pci_set_master(pci_dev);
-	if (pci_set_dma_mask(pci_dev, 0xffffffff) < 0) {
+	if (dma_set_mask(&pci_dev->dev, 0xffffffff) < 0) {
 		dev_err(&pci_dev->dev,
 			"%s(): 32bit PCI DMA is not supported\n", __func__);
 		goto pci_detect_err;
diff --git a/drivers/media/pci/pluto2/pluto2.c b/drivers/media/pci/pluto2/pluto2.c
index f1f4793a4452..6ac9b9bd7435 100644
--- a/drivers/media/pci/pluto2/pluto2.c
+++ b/drivers/media/pci/pluto2/pluto2.c
@@ -228,16 +228,16 @@ static void pluto_set_dma_addr(struct pluto *pluto)
 
 static int pluto_dma_map(struct pluto *pluto)
 {
-	pluto->dma_addr = pci_map_single(pluto->pdev, pluto->dma_buf,
-			TS_DMA_BYTES, PCI_DMA_FROMDEVICE);
+	pluto->dma_addr = dma_map_single(&pluto->pdev->dev, pluto->dma_buf,
+					 TS_DMA_BYTES, DMA_FROM_DEVICE);
 
-	return pci_dma_mapping_error(pluto->pdev, pluto->dma_addr);
+	return dma_mapping_error(&pluto->pdev->dev, pluto->dma_addr);
 }
 
 static void pluto_dma_unmap(struct pluto *pluto)
 {
-	pci_unmap_single(pluto->pdev, pluto->dma_addr,
-			TS_DMA_BYTES, PCI_DMA_FROMDEVICE);
+	dma_unmap_single(&pluto->pdev->dev, pluto->dma_addr, TS_DMA_BYTES,
+			 DMA_FROM_DEVICE);
 }
 
 static int pluto_start_feed(struct dvb_demux_feed *f)
@@ -276,8 +276,8 @@ static void pluto_dma_end(struct pluto *pluto, unsigned int nbpackets)
 {
 	/* synchronize the DMA transfer with the CPU
 	 * first so that we see updated contents. */
-	pci_dma_sync_single_for_cpu(pluto->pdev, pluto->dma_addr,
-			TS_DMA_BYTES, PCI_DMA_FROMDEVICE);
+	dma_sync_single_for_cpu(&pluto->pdev->dev, pluto->dma_addr,
+				TS_DMA_BYTES, DMA_FROM_DEVICE);
 
 	/* Workaround for broken hardware:
 	 * [1] On startup NBPACKETS seems to contain an uninitialized value,
@@ -310,8 +310,8 @@ static void pluto_dma_end(struct pluto *pluto, unsigned int nbpackets)
 	pluto_set_dma_addr(pluto);
 
 	/* sync the buffer and give it back to the card */
-	pci_dma_sync_single_for_device(pluto->pdev, pluto->dma_addr,
-			TS_DMA_BYTES, PCI_DMA_FROMDEVICE);
+	dma_sync_single_for_device(&pluto->pdev->dev, pluto->dma_addr,
+				   TS_DMA_BYTES, DMA_FROM_DEVICE);
 }
 
 static irqreturn_t pluto_irq(int irq, void *dev_id)
@@ -595,7 +595,7 @@ static int pluto2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* enable interrupts */
 	pci_write_config_dword(pdev, 0x6c, 0x8000);
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret < 0)
 		goto err_pci_disable_device;
 
diff --git a/drivers/media/pci/pt1/pt1.c b/drivers/media/pci/pt1/pt1.c
index f2aa36814fba..121a4a92ea10 100644
--- a/drivers/media/pci/pt1/pt1.c
+++ b/drivers/media/pci/pt1/pt1.c
@@ -1340,7 +1340,7 @@ static int pt1_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret < 0)
 		goto err;
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret < 0)
 		goto err_pci_disable_device;
 
diff --git a/drivers/media/pci/tw5864/tw5864-core.c b/drivers/media/pci/tw5864/tw5864-core.c
index 282f7dfb7aaf..23d3cae54a5d 100644
--- a/drivers/media/pci/tw5864/tw5864-core.c
+++ b/drivers/media/pci/tw5864/tw5864-core.c
@@ -262,7 +262,7 @@ static int tw5864_initdev(struct pci_dev *pci_dev,
 
 	pci_set_master(pci_dev);
 
-	err = pci_set_dma_mask(pci_dev, DMA_BIT_MASK(32));
+	err = dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(32));
 	if (err) {
 		dev_err(&dev->pci->dev, "32 bit PCI DMA is not supported\n");
 		goto disable_pci;
diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 9faf8365afa7..0257a4f293ec 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -536,7 +536,9 @@ static int display_open(struct inode *inode, struct file *file)
 
 	mutex_lock(&ictx->lock);
 
-	if (!ictx->display_supported) {
+	if (ictx->disconnected) {
+		retval = -ENODEV;
+	} else if (!ictx->display_supported) {
 		pr_err("display not supported by device\n");
 		retval = -ENODEV;
 	} else if (ictx->display_isopen) {
@@ -598,6 +600,9 @@ static int send_packet(struct imon_context *ictx)
 	int retval = 0;
 	struct usb_ctrlrequest *control_req = NULL;
 
+	if (ictx->disconnected)
+		return -ENODEV;
+
 	/* Check if we need to use control or interrupt urb */
 	if (!ictx->tx_control) {
 		pipe = usb_sndintpipe(ictx->usbdev_intf0,
@@ -951,12 +956,14 @@ static ssize_t vfd_write(struct file *file, const char __user *buf,
 	static const unsigned char vfd_packet6[] = {
 		0x01, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF };
 
-	if (ictx->disconnected)
-		return -ENODEV;
-
 	if (mutex_lock_interruptible(&ictx->lock))
 		return -ERESTARTSYS;
 
+	if (ictx->disconnected) {
+		retval = -ENODEV;
+		goto exit;
+	}
+
 	if (!ictx->dev_present_intf0) {
 		pr_err_ratelimited("no iMON device present\n");
 		retval = -ENODEV;
@@ -1031,11 +1038,13 @@ static ssize_t lcd_write(struct file *file, const char __user *buf,
 	int retval = 0;
 	struct imon_context *ictx = file->private_data;
 
-	if (ictx->disconnected)
-		return -ENODEV;
-
 	mutex_lock(&ictx->lock);
 
+	if (ictx->disconnected) {
+		retval = -ENODEV;
+		goto exit;
+	}
+
 	if (!ictx->display_supported) {
 		pr_err_ratelimited("no iMON display present\n");
 		retval = -ENODEV;
@@ -2499,7 +2508,11 @@ static void imon_disconnect(struct usb_interface *interface)
 	int ifnum;
 
 	ictx = usb_get_intfdata(interface);
+
+	mutex_lock(&ictx->lock);
 	ictx->disconnected = true;
+	mutex_unlock(&ictx->lock);
+
 	dev = ictx->dev;
 	ifnum = interface->cur_altsetting->desc.bInterfaceNumber;
 
diff --git a/drivers/media/tuners/xc5000.c b/drivers/media/tuners/xc5000.c
index 2182e5b7b606..ec9a3cd4784e 100644
--- a/drivers/media/tuners/xc5000.c
+++ b/drivers/media/tuners/xc5000.c
@@ -58,7 +58,7 @@ struct xc5000_priv {
 	struct dvb_frontend *fe;
 	struct delayed_work timer_sleep;
 
-	const struct firmware   *firmware;
+	bool inited;
 };
 
 /* Misc Defines */
@@ -1110,23 +1110,19 @@ static int xc_load_fw_and_init_tuner(struct dvb_frontend *fe, int force)
 	if (!force && xc5000_is_firmware_loaded(fe) == 0)
 		return 0;
 
-	if (!priv->firmware) {
-		ret = request_firmware(&fw, desired_fw->name,
-					priv->i2c_props.adap->dev.parent);
-		if (ret) {
-			pr_err("xc5000: Upload failed. rc %d\n", ret);
-			return ret;
-		}
-		dprintk(1, "firmware read %zu bytes.\n", fw->size);
+	ret = request_firmware(&fw, desired_fw->name,
+			       priv->i2c_props.adap->dev.parent);
+	if (ret) {
+		pr_err("xc5000: Upload failed. rc %d\n", ret);
+		return ret;
+	}
+	dprintk(1, "firmware read %zu bytes.\n", fw->size);
 
-		if (fw->size != desired_fw->size) {
-			pr_err("xc5000: Firmware file with incorrect size\n");
-			release_firmware(fw);
-			return -EINVAL;
-		}
-		priv->firmware = fw;
-	} else
-		fw = priv->firmware;
+	if (fw->size != desired_fw->size) {
+		pr_err("xc5000: Firmware file with incorrect size\n");
+		release_firmware(fw);
+		return -EINVAL;
+	}
 
 	/* Try up to 5 times to load firmware */
 	for (i = 0; i < 5; i++) {
@@ -1204,6 +1200,7 @@ static int xc_load_fw_and_init_tuner(struct dvb_frontend *fe, int force)
 	}
 
 err:
+	release_firmware(fw);
 	if (!ret)
 		printk(KERN_INFO "xc5000: Firmware %s loaded and running.\n",
 		       desired_fw->name);
@@ -1274,7 +1271,7 @@ static int xc5000_resume(struct dvb_frontend *fe)
 
 	/* suspended before firmware is loaded.
 	   Avoid firmware load in resume path. */
-	if (!priv->firmware)
+	if (!priv->inited)
 		return 0;
 
 	return xc5000_set_params(fe);
@@ -1293,6 +1290,8 @@ static int xc5000_init(struct dvb_frontend *fe)
 	if (debug)
 		xc_debug_dump(priv);
 
+	priv->inited = true;
+
 	return 0;
 }
 
@@ -1305,11 +1304,7 @@ static void xc5000_release(struct dvb_frontend *fe)
 	mutex_lock(&xc5000_list_mutex);
 
 	if (priv) {
-		cancel_delayed_work(&priv->timer_sleep);
-		if (priv->firmware) {
-			release_firmware(priv->firmware);
-			priv->firmware = NULL;
-		}
+		cancel_delayed_work_sync(&priv->timer_sleep);
 		hybrid_tuner_release_state(priv);
 	}
 
diff --git a/drivers/memory/samsung/exynos-srom.c b/drivers/memory/samsung/exynos-srom.c
index e73dd330af47..d913fb901973 100644
--- a/drivers/memory/samsung/exynos-srom.c
+++ b/drivers/memory/samsung/exynos-srom.c
@@ -121,20 +121,18 @@ static int exynos_srom_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	srom->dev = dev;
-	srom->reg_base = of_iomap(np, 0);
-	if (!srom->reg_base) {
+	srom->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(srom->reg_base)) {
 		dev_err(&pdev->dev, "iomap of exynos srom controller failed\n");
-		return -ENOMEM;
+		return PTR_ERR(srom->reg_base);
 	}
 
 	platform_set_drvdata(pdev, srom);
 
 	srom->reg_offset = exynos_srom_alloc_reg_dump(exynos_srom_offsets,
 						      ARRAY_SIZE(exynos_srom_offsets));
-	if (!srom->reg_offset) {
-		iounmap(srom->reg_base);
+	if (!srom->reg_offset)
 		return -ENOMEM;
-	}
 
 	for_each_child_of_node(np, child) {
 		if (exynos_srom_configure_bank(srom, child)) {
diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
index 1c7577b881ff..5eb790047a4e 100644
--- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
+++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
@@ -81,8 +81,9 @@ static struct mfd_cell chtdc_ti_dev[] = {
 static const struct regmap_config chtdc_ti_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.max_register = 128,
-	.cache_type = REGCACHE_NONE,
+	.max_register = 0xff,
+	/* The hardware does not support reading multiple registers at once */
+	.use_single_read = true,
 };
 
 static const struct regmap_irq chtdc_ti_irqs[] = {
diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index aaf24af287dd..5e2be5a9fe4a 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -98,6 +98,7 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 	struct resource *mem;
 	void __iomem *base;
 	struct gpio_chip *mmc_gpio_chip;
+	int ret;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem)
@@ -118,7 +119,10 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 	bgpio_init(mmc_gpio_chip, &pdev->dev, 0x4, base + SYS_MCI,
 			NULL, NULL, NULL, NULL, 0);
 	mmc_gpio_chip->ngpio = 2;
-	devm_gpiochip_add_data(&pdev->dev, mmc_gpio_chip, NULL);
+
+	ret = devm_gpiochip_add_data(&pdev->dev, mmc_gpio_chip, NULL);
+	if (ret)
+		return ret;
 
 	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
 			vexpress_sysreg_cells,
diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
index 500b1feaf1f6..fd7d5cd50d39 100644
--- a/drivers/misc/genwqe/card_ddcb.c
+++ b/drivers/misc/genwqe/card_ddcb.c
@@ -923,7 +923,7 @@ int __genwqe_execute_raw_ddcb(struct genwqe_dev *cd,
 	}
 	if (cmd->asv_length > DDCB_ASV_LENGTH) {
 		dev_err(&pci_dev->dev, "[%s] err: wrong asv_length of %d\n",
-			__func__, cmd->asiv_length);
+			__func__, cmd->asv_length);
 		return -EINVAL;
 	}
 	rc = __genwqe_enqueue_ddcb(cd, req, f_flags);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index a0cac8c87ef2..cbc9ca0dd56e 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -929,7 +929,11 @@ static void mmc_sdio_remove(struct mmc_host *host)
  */
 static int mmc_sdio_alive(struct mmc_host *host)
 {
-	return mmc_select_card(host->card);
+	if (!mmc_host_is_spi(host))
+		return mmc_select_card(host->card);
+	else
+		return mmc_io_rw_direct(host->card, 0, 0, SDIO_CCCR_CCCR, 0,
+					NULL);
 }
 
 /*
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 5ea362ec3955..0b013a7b9035 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -876,10 +876,14 @@ static int fsmc_nand_probe_config_dt(struct platform_device *pdev,
 	if (!of_property_read_u32(np, "bank-width", &val)) {
 		if (val == 2) {
 			nand->options |= NAND_BUSWIDTH_16;
-		} else if (val != 1) {
+		} else if (val == 1) {
+			nand->options |= NAND_BUSWIDTH_AUTO;
+		} else {
 			dev_err(&pdev->dev, "invalid bank-width %u\n", val);
 			return -EINVAL;
 		}
+	} else {
+		nand->options |= NAND_BUSWIDTH_AUTO;
 	}
 
 	if (of_get_property(np, "nand-skip-bbtscan", NULL))
diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index 413082f10dc1..31f05356a7c0 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -688,7 +688,10 @@ static u32 ena_get_rxfh_indir_size(struct net_device *netdev)
 
 static u32 ena_get_rxfh_key_size(struct net_device *netdev)
 {
-	return ENA_HASH_KEY_SIZE;
+	struct ena_adapter *adapter = netdev_priv(netdev);
+	struct ena_rss *rss = &adapter->ena_dev->rss;
+
+	return rss->hash_key ? ENA_HASH_KEY_SIZE : 0;
 }
 
 static int ena_indirection_table_set(struct ena_adapter *adapter,
diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 07568aa15873..3c3d8ffc3c8b 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -2135,7 +2135,7 @@ static const struct ethtool_ops cxgb_ethtool_ops = {
 	.set_link_ksettings = set_link_ksettings,
 };
 
-static int in_range(int val, int lo, int hi)
+static int cxgb_in_range(int val, int lo, int hi)
 {
 	return val < 0 || (val <= hi && val >= lo);
 }
@@ -2171,19 +2171,19 @@ static int cxgb_siocdevprivate(struct net_device *dev,
 			return -EINVAL;
 		if (t.qset_idx >= SGE_QSETS)
 			return -EINVAL;
-		if (!in_range(t.intr_lat, 0, M_NEWTIMER) ||
-		    !in_range(t.cong_thres, 0, 255) ||
-		    !in_range(t.txq_size[0], MIN_TXQ_ENTRIES,
+		if (!cxgb_in_range(t.intr_lat, 0, M_NEWTIMER) ||
+		    !cxgb_in_range(t.cong_thres, 0, 255) ||
+		    !cxgb_in_range(t.txq_size[0], MIN_TXQ_ENTRIES,
 			      MAX_TXQ_ENTRIES) ||
-		    !in_range(t.txq_size[1], MIN_TXQ_ENTRIES,
+		    !cxgb_in_range(t.txq_size[1], MIN_TXQ_ENTRIES,
 			      MAX_TXQ_ENTRIES) ||
-		    !in_range(t.txq_size[2], MIN_CTRL_TXQ_ENTRIES,
+		    !cxgb_in_range(t.txq_size[2], MIN_CTRL_TXQ_ENTRIES,
 			      MAX_CTRL_TXQ_ENTRIES) ||
-		    !in_range(t.fl_size[0], MIN_FL_ENTRIES,
+		    !cxgb_in_range(t.fl_size[0], MIN_FL_ENTRIES,
 			      MAX_RX_BUFFERS) ||
-		    !in_range(t.fl_size[1], MIN_FL_ENTRIES,
+		    !cxgb_in_range(t.fl_size[1], MIN_FL_ENTRIES,
 			      MAX_RX_JUMBO_BUFFERS) ||
-		    !in_range(t.rspq_size, MIN_RSPQ_ENTRIES,
+		    !cxgb_in_range(t.rspq_size, MIN_RSPQ_ENTRIES,
 			      MAX_RSPQ_ENTRIES))
 			return -EINVAL;
 
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 81395852b4d4..ca8bfd1b8278 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -957,15 +957,18 @@ receive_packet (struct net_device *dev)
 		} else {
 			struct sk_buff *skb;
 
+			skb = NULL;
 			/* Small skbuffs for short packets */
-			if (pkt_len > copy_thresh) {
+			if (pkt_len <= copy_thresh)
+				skb = netdev_alloc_skb_ip_align(dev, pkt_len);
+			if (!skb) {
 				dma_unmap_single(&np->pdev->dev,
 						 desc_to_dma(desc),
 						 np->rx_buf_sz,
 						 DMA_FROM_DEVICE);
 				skb_put (skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
-			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
+			} else {
 				dma_sync_single_for_cpu(&np->pdev->dev,
 							desc_to_dma(desc),
 							np->rx_buf_sz,
diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 9d58d8334467..ea49b0df397e 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -482,10 +482,12 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 					"missing 'reg' property in node %pOF\n",
 					tbi);
 				err = -EBUSY;
+				of_node_put(tbi);
 				goto error;
 			}
 			set_tbipa(*prop, pdev,
 				  data->get_tbipa, priv->map, &res);
+			of_node_put(tbi);
 		}
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 3bd3603873e3..efbb01460f4b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -1176,9 +1176,9 @@ static void mlx4_en_do_uc_filter(struct mlx4_en_priv *priv,
 				mlx4_unregister_mac(mdev->dev, priv->port, mac);
 
 				hlist_del_rcu(&entry->hlist);
-				kfree_rcu(entry, rcu);
 				en_dbg(DRV, priv, "Removed MAC %pM on port:%d\n",
 				       entry->mac, priv->port);
+				kfree_rcu(entry, rcu);
 				++removed;
 			}
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
index a23e3d810f3e..80af7a5ac604 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
@@ -63,23 +63,11 @@ struct mlx5e_port_buffer {
 	struct mlx5e_bufferx_reg  buffer[MLX5E_MAX_BUFFER];
 };
 
-#ifdef CONFIG_MLX5_CORE_EN_DCB
 int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 				    u32 change, unsigned int mtu,
 				    struct ieee_pfc *pfc,
 				    u32 *buffer_size,
 				    u8 *prio2buffer);
-#else
-static inline int
-mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
-				u32 change, unsigned int mtu,
-				void *pfc,
-				u32 *buffer_size,
-				u8 *prio2buffer)
-{
-	return 0;
-}
-#endif
 
 int mlx5e_port_query_buffer(struct mlx5e_priv *priv,
 			    struct mlx5e_port_buffer *port_buffer);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index bb7e3c80ad74..321441e6ad32 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -42,7 +42,6 @@
 #include "eswitch.h"
 #include "en.h"
 #include "en/txrx.h"
-#include "en/port_buffer.h"
 #include "en_tc.h"
 #include "en_rep.h"
 #include "en_accel/ipsec.h"
@@ -2243,11 +2242,9 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
 	struct mlx5e_params *params = &priv->channels.params;
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = priv->mdev;
-	u16 mtu, prev_mtu;
+	u16 mtu;
 	int err;
 
-	mlx5e_query_mtu(mdev, params, &prev_mtu);
-
 	err = mlx5e_set_mtu(mdev, params, params->sw_mtu);
 	if (err)
 		return err;
@@ -2257,18 +2254,6 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
 		netdev_warn(netdev, "%s: VPort MTU %d is different than netdev mtu %d\n",
 			    __func__, mtu, params->sw_mtu);
 
-	if (mtu != prev_mtu && MLX5_BUFFER_SUPPORTED(mdev)) {
-		err = mlx5e_port_manual_buffer_config(priv, 0, mtu,
-						      NULL, NULL, NULL);
-		if (err) {
-			netdev_warn(netdev, "%s: Failed to set Xon/Xoff values with MTU %d (err %d), setting back to previous MTU %d\n",
-				    __func__, mtu, err, prev_mtu);
-
-			mlx5e_set_mtu(mdev, params, prev_mtu);
-			return err;
-		}
-	}
-
 	params->sw_mtu = mtu;
 	return 0;
 }
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index d295942968f3..160f853e93ad 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -1001,7 +1001,7 @@ static u32 nfp_net_get_rxfh_key_size(struct net_device *netdev)
 	struct nfp_net *nn = netdev_priv(netdev);
 
 	if (!(nn->cap & NFP_NET_CFG_CTRL_RSS_ANY))
-		return -EOPNOTSUPP;
+		return 0;
 
 	return nfp_net_rss_key_sz(nn);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2478caeec763..21cc8cd9e023 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2805,7 +2805,7 @@ static void stmmac_dma_interrupt(struct stmmac_priv *priv)
 	u32 channels_to_check = tx_channel_count > rx_channel_count ?
 				tx_channel_count : rx_channel_count;
 	u32 chan;
-	int status[max_t(u32, MTL_MAX_TX_QUEUES, MTL_MAX_RX_QUEUES)];
+	int status[MAX_T(u32, MTL_MAX_TX_QUEUES, MTL_MAX_RX_QUEUES)];
 
 	/* Make sure we never check beyond our status buffer. */
 	if (WARN_ON_ONCE(channels_to_check > ARRAY_SIZE(status)))
diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index 1d1808afd529..792c22ba5b00 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -14,9 +14,7 @@
 #include "fjes.h"
 #include "fjes_trace.h"
 
-#define MAJ 1
-#define MIN 2
-#define DRV_VERSION __stringify(MAJ) "." __stringify(MIN)
+#define DRV_VERSION "1.2"
 #define DRV_NAME	"fjes"
 char fjes_driver_name[] = DRV_NAME;
 char fjes_driver_version[] = DRV_VERSION;
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 97d2037e7fee..2e22be26921b 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -608,6 +608,21 @@ static void ax88772_suspend(struct usbnet *dev)
 		   asix_read_medium_status(dev, 1));
 }
 
+/* Notes on PM callbacks and locking context:
+ *
+ * - asix_suspend()/asix_resume() are invoked for both runtime PM and
+ *   system-wide suspend/resume. For struct usb_driver the ->resume()
+ *   callback does not receive pm_message_t, so the resume type cannot
+ *   be distinguished here.
+ *
+ * - The MAC driver must hold RTNL when calling phylink interfaces such as
+ *   phylink_suspend()/resume(). Those calls will also perform MDIO I/O.
+ *
+ * - Taking RTNL and doing MDIO from a runtime-PM resume callback (while
+ *   the USB PM lock is held) is fragile. Since autosuspend brings no
+ *   measurable power saving here, we block it by holding a PM usage
+ *   reference in ax88772_bind().
+ */
 static int asix_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
@@ -809,7 +824,18 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 	if (ret)
 		return ret;
 
-	return ax88772_init_phy(dev);
+	ret = ax88772_init_phy(dev);
+	if (ret)
+		return ret;
+
+	/* Keep this interface runtime-PM active by taking a usage ref.
+	 * Prevents runtime suspend while bound and avoids resume paths
+	 * that could deadlock (autoresume under RTNL while USB PM lock
+	 * is held, phylink/MDIO wants RTNL).
+	 */
+	pm_runtime_get_noresume(&intf->dev);
+
+	return 0;
 }
 
 static int ax88772_stop(struct usbnet *dev)
@@ -827,6 +853,8 @@ static void ax88772_unbind(struct usbnet *dev, struct usb_interface *intf)
 
 	phy_disconnect(priv->phydev);
 	asix_rx_fixup_common_free(dev->driver_priv);
+	/* Drop the PM usage ref taken in bind() */
+	pm_runtime_put(&intf->dev);
 }
 
 static void ax88178_unbind(struct usbnet *dev, struct usb_interface *intf)
@@ -1452,6 +1480,11 @@ static struct usb_driver asix_driver = {
 	.resume =	asix_resume,
 	.reset_resume =	asix_resume,
 	.disconnect =	usbnet_disconnect,
+	/* usbnet enables autosuspend by default (supports_autosuspend=1).
+	 * We keep runtime-PM active for AX88772* by taking a PM usage
+	 * reference in ax88772_bind() (pm_runtime_get_noresume()) and
+	 * dropping it in unbind(), which effectively blocks autosuspend.
+	 */
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
 };
diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index d5aa92660217..324bec0c22fb 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -664,7 +664,6 @@ static void rtl8150_set_multicast(struct net_device *netdev)
 	rtl8150_t *dev = netdev_priv(netdev);
 	u16 rx_creg = 0x9e;
 
-	netif_stop_queue(netdev);
 	if (netdev->flags & IFF_PROMISC) {
 		rx_creg |= 0x0001;
 		dev_info(&netdev->dev, "%s: promiscuous mode\n", netdev->name);
@@ -678,7 +677,6 @@ static void rtl8150_set_multicast(struct net_device *netdev)
 		rx_creg &= 0x00fc;
 	}
 	async_set_registers(dev, RCR, sizeof(rx_creg), rx_creg);
-	netif_wake_queue(netdev);
 }
 
 static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 572aabc0541c..5817501b0c3f 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1762,33 +1762,32 @@ void ath10k_wmi_put_wmi_channel(struct ath10k *ar, struct wmi_channel *ch,
 
 int ath10k_wmi_wait_for_service_ready(struct ath10k *ar)
 {
+	unsigned long timeout = jiffies + WMI_SERVICE_READY_TIMEOUT_HZ;
 	unsigned long time_left, i;
 
-	time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
-						WMI_SERVICE_READY_TIMEOUT_HZ);
-	if (!time_left) {
-		/* Sometimes the PCI HIF doesn't receive interrupt
-		 * for the service ready message even if the buffer
-		 * was completed. PCIe sniffer shows that it's
-		 * because the corresponding CE ring doesn't fires
-		 * it. Workaround here by polling CE rings once.
-		 */
-		ath10k_warn(ar, "failed to receive service ready completion, polling..\n");
-
+	/* Sometimes the PCI HIF doesn't receive interrupt
+	 * for the service ready message even if the buffer
+	 * was completed. PCIe sniffer shows that it's
+	 * because the corresponding CE ring doesn't fires
+	 * it. Workaround here by polling CE rings. Since
+	 * the message could arrive at any time, continue
+	 * polling until timeout.
+	 */
+	do {
 		for (i = 0; i < CE_COUNT; i++)
 			ath10k_hif_send_complete_check(ar, i, 1);
 
+		/* The 100 ms granularity is a tradeoff considering scheduler
+		 * overhead and response latency
+		 */
 		time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
-							WMI_SERVICE_READY_TIMEOUT_HZ);
-		if (!time_left) {
-			ath10k_warn(ar, "polling timed out\n");
-			return -ETIMEDOUT;
-		}
-
-		ath10k_warn(ar, "service ready completion received, continuing normally\n");
-	}
+							msecs_to_jiffies(100));
+		if (time_left)
+			return 0;
+	} while (time_before(jiffies, timeout));
 
-	return 0;
+	ath10k_warn(ar, "failed to receive service ready completion\n");
+	return -ETIMEDOUT;
 }
 
 int ath10k_wmi_wait_for_unified_ready(struct ath10k *ar)
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index d76a8523ef1d..8978f18d98de 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -663,10 +663,9 @@ static void mwifiex_reg_notifier(struct wiphy *wiphy,
 		return;
 	}
 
-	/* Don't send world or same regdom info to firmware */
-	if (strncmp(request->alpha2, "00", 2) &&
-	    strncmp(request->alpha2, adapter->country_code,
-		    sizeof(request->alpha2))) {
+	/* Don't send same regdom info to firmware */
+	if (strncmp(request->alpha2, adapter->country_code,
+		    sizeof(request->alpha2)) != 0) {
 		memcpy(adapter->country_code, request->alpha2,
 		       sizeof(request->alpha2));
 		mwifiex_send_domain_info_cmd_fw(wiphy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
index ba927033bbe8..1206769cdc7f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
@@ -48,7 +48,7 @@ mt76_wmac_probe(struct platform_device *pdev)
 
 	return 0;
 error:
-	ieee80211_free_hw(mt76_hw(dev));
+	mt76_free_device(mdev);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
index b53daf1b29f7..cd3e92440f6a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
@@ -296,7 +296,6 @@ static const struct usb_device_id rtl8192c_usb_ids[] = {
 	{RTL_USB_DEVICE(0x050d, 0x1102, rtl92cu_hal_cfg)}, /*Belkin - Edimax*/
 	{RTL_USB_DEVICE(0x050d, 0x11f2, rtl92cu_hal_cfg)}, /*Belkin - ISY*/
 	{RTL_USB_DEVICE(0x06f8, 0xe033, rtl92cu_hal_cfg)}, /*Hercules - Edimax*/
-	{RTL_USB_DEVICE(0x07b8, 0x8188, rtl92cu_hal_cfg)}, /*Abocom - Abocom*/
 	{RTL_USB_DEVICE(0x07b8, 0x8189, rtl92cu_hal_cfg)}, /*Funai - Abocom*/
 	{RTL_USB_DEVICE(0x0846, 0x9041, rtl92cu_hal_cfg)}, /*NetGear WNA1000M*/
 	{RTL_USB_DEVICE(0x0846, 0x9043, rtl92cu_hal_cfg)}, /*NG WNA1000Mv2*/
diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index 37d26f01986b..fd7026206f58 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -126,8 +126,6 @@ struct pn544_i2c_fw_secure_blob {
 #define PN544_FW_CMD_RESULT_COMMAND_REJECTED 0xE0
 #define PN544_FW_CMD_RESULT_CHUNK_ERROR 0xE6
 
-#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
-
 #define PN544_FW_WRITE_BUFFER_MAX_LEN 0x9f7
 #define PN544_FW_I2C_MAX_PAYLOAD PN544_HCI_I2C_LLC_MAX_SIZE
 #define PN544_FW_I2C_WRITE_FRAME_HEADER_LEN 8
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5f60a6ca247f..740709ee0852 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2979,10 +2979,12 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		 * Exclude Samsung 990 Evo from NVME_QUIRK_SIMPLE_SUSPEND
 		 * because of high power consumption (> 2 Watt) in s2idle
 		 * sleep. Only some boards with Intel CPU are affected.
+		 * (Note for testing: Samsung 990 Evo Plus has same PCI ID)
 		 */
 		if (dmi_match(DMI_BOARD_NAME, "DN50Z-140HC-YD") ||
 		    dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
 		    dmi_match(DMI_BOARD_NAME, "GXxMRXx") ||
+		    dmi_match(DMI_BOARD_NAME, "NS5X_NS7XAU") ||
 		    dmi_match(DMI_BOARD_NAME, "PH4PG31") ||
 		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1") ||
 		    dmi_match(DMI_BOARD_NAME, "PH6PG01_PH6PG71"))
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 812d085d49c9..4c4b528b89eb 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -54,6 +54,8 @@ struct nvmet_fc_ls_req_op {		/* for an LS RQST XMT */
 	int				ls_error;
 	struct list_head		lsreq_list; /* tgtport->ls_req_list */
 	bool				req_queued;
+
+	struct work_struct		put_work;
 };
 
 
@@ -111,8 +113,6 @@ struct nvmet_fc_tgtport {
 	struct nvmet_fc_port_entry	*pe;
 	struct kref			ref;
 	u32				max_sg_cnt;
-
-	struct work_struct		put_work;
 };
 
 struct nvmet_fc_port_entry {
@@ -236,12 +236,13 @@ static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
 static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
 static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
 static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
-static void nvmet_fc_put_tgtport_work(struct work_struct *work)
+static void nvmet_fc_put_lsop_work(struct work_struct *work)
 {
-	struct nvmet_fc_tgtport *tgtport =
-		container_of(work, struct nvmet_fc_tgtport, put_work);
+	struct nvmet_fc_ls_req_op *lsop =
+		container_of(work, struct nvmet_fc_ls_req_op, put_work);
 
-	nvmet_fc_tgtport_put(tgtport);
+	nvmet_fc_tgtport_put(lsop->tgtport);
+	kfree(lsop);
 }
 static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
 static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
@@ -368,7 +369,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  DMA_BIDIRECTIONAL);
 
 out_putwork:
-	queue_work(nvmet_wq, &tgtport->put_work);
+	queue_work(nvmet_wq, &lsop->put_work);
 }
 
 static int
@@ -389,6 +390,7 @@ __nvmet_fc_send_ls_req(struct nvmet_fc_tgtport *tgtport,
 	lsreq->done = done;
 	lsop->req_queued = false;
 	INIT_LIST_HEAD(&lsop->lsreq_list);
+	INIT_WORK(&lsop->put_work, nvmet_fc_put_lsop_work);
 
 	lsreq->rqstdma = fc_dma_map_single(tgtport->dev, lsreq->rqstaddr,
 				  lsreq->rqstlen + lsreq->rsplen,
@@ -448,8 +450,6 @@ nvmet_fc_disconnect_assoc_done(struct nvmefc_ls_req *lsreq, int status)
 	__nvmet_fc_finish_ls_req(lsop);
 
 	/* fc-nvme target doesn't care about success or failure of cmd */
-
-	kfree(lsop);
 }
 
 /*
@@ -1407,7 +1407,6 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	kref_init(&newrec->ref);
 	ida_init(&newrec->assoc_cnt);
 	newrec->max_sg_cnt = template->max_sgl_segments;
-	INIT_WORK(&newrec->put_work, nvmet_fc_put_tgtport_work);
 
 	ret = nvmet_fc_alloc_ls_iodlist(newrec);
 	if (ret) {
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index d96f89a68b6f..c277f76276ab 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1200,8 +1200,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = request_irq(irq, ks_pcie_err_irq_handler, IRQF_SHARED,
-			  "ks-pcie-error-irq", ks_pcie);
+	ret = devm_request_irq(dev, irq, ks_pcie_err_irq_handler, IRQF_SHARED,
+			       "ks-pcie-error-irq", ks_pcie);
 	if (ret < 0) {
 		dev_err(dev, "failed to request error IRQ %d\n",
 			irq);
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 3703ea0d90c2..0046983e5ab8 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1839,10 +1839,10 @@ static int tegra_pcie_ep_raise_legacy_irq(struct tegra_pcie_dw *pcie, u16 irq)
 
 static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
-	if (unlikely(irq > 31))
+	if (unlikely(irq > 32))
 		return -EINVAL;
 
-	appl_writel(pcie, BIT(irq), APPL_MSI_CTRL_1);
+	appl_writel(pcie, BIT(irq - 1), APPL_MSI_CTRL_1);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index cb0aa65d6934..30d63ae20d8b 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1346,7 +1346,7 @@ static int tegra_pcie_port_get_phys(struct tegra_pcie_port *port)
 	unsigned int i;
 	int err;
 
-	port->phys = devm_kcalloc(dev, sizeof(phy), port->lanes, GFP_KERNEL);
+	port->phys = devm_kcalloc(dev, port->lanes, sizeof(phy), GFP_KERNEL);
 	if (!port->phys)
 		return -ENOMEM;
 
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ef71c1a20400..1175c0e08108 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -541,15 +541,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	if (dev->no_vf_scan)
 		return 0;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
+	pci_unlock_rescan_remove();
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 
 	return rc;
 }
@@ -669,8 +672,10 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 46b82bacaff6..1330a29e5747 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1561,6 +1561,7 @@ void pci_uevent_ers(struct pci_dev *pdev, enum pci_ers_result err_type)
 	switch (err_type) {
 	case PCI_ERS_RESULT_NONE:
 	case PCI_ERS_RESULT_CAN_RECOVER:
+	case PCI_ERS_RESULT_NEED_RESET:
 		envp[idx++] = "ERROR_EVENT=BEGIN_RECOVERY";
 		envp[idx++] = "DEVICE_ONLINE=0";
 		break;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 075c32b91fc4..5f86f49ad3c8 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -174,8 +174,14 @@ static ssize_t max_link_width_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t ret;
 
-	return sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
+	/* We read PCI_EXP_LNKCAP, so we need the device to be accessible. */
+	pci_config_pm_runtime_get(pdev);
+	ret = sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
+	pci_config_pm_runtime_put(pdev);
+
+	return ret;
 }
 static DEVICE_ATTR_RO(max_link_width);
 
@@ -187,7 +193,10 @@ static ssize_t current_link_speed_show(struct device *dev,
 	int err;
 	enum pci_bus_speed speed;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -204,7 +213,10 @@ static ssize_t current_link_width_show(struct device *dev,
 	u16 linkstat;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -220,7 +232,10 @@ static ssize_t secondary_bus_number_show(struct device *dev,
 	u8 sec_bus;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -236,7 +251,10 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
 	u8 sub_bus;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pci_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 2908bfda8880..81ea196ce843 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -37,7 +37,7 @@
 #define AER_ERROR_SOURCES_MAX		128
 
 #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
-#define AER_MAX_TYPEOF_UNCOR_ERRS	27	/* as per PCI_ERR_UNCOR_STATUS*/
+#define AER_MAX_TYPEOF_UNCOR_ERRS	32	/* as per PCI_ERR_UNCOR_STATUS*/
 
 struct aer_err_source {
 	unsigned int status;
@@ -513,11 +513,11 @@ static const char *aer_uncorrectable_error_string[] = {
 	"AtomicOpBlocked",		/* Bit Position 24	*/
 	"TLPBlockedErr",		/* Bit Position 25	*/
 	"PoisonTLPBlocked",		/* Bit Position 26	*/
-	NULL,				/* Bit Position 27	*/
-	NULL,				/* Bit Position 28	*/
-	NULL,				/* Bit Position 29	*/
-	NULL,				/* Bit Position 30	*/
-	NULL,				/* Bit Position 31	*/
+	"DMWrReqBlocked",		/* Bit Position 27	*/
+	"IDECheck",			/* Bit Position 28	*/
+	"MisIDETLP",			/* Bit Position 29	*/
+	"PCRC_CHECK",			/* Bit Position 30	*/
+	"TLPXlatBlocked",		/* Bit Position 31	*/
 };
 
 static const char *aer_agent_string[] = {
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 410fc44d79ee..3eedf51d5b9f 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -102,6 +102,12 @@ static int report_normal_detected(struct pci_dev *dev, void *data)
 	return report_error_detected(dev, pci_channel_io_normal, data);
 }
 
+static int report_perm_failure_detected(struct pci_dev *dev, void *data)
+{
+	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
+	return 0;
+}
+
 static int report_mmio_enabled(struct pci_dev *dev, void *data)
 {
 	pci_ers_result_t vote, *result = data;
@@ -263,7 +269,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 failed:
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
 
-	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
+	pci_walk_bridge(bridge, report_perm_failure_detected, NULL);
 
 	/* TODO: Should kernel panic here? */
 	pci_info(bridge, "device recovery failed\n");
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index cd5945e17fdf..5ba677353d04 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -93,7 +93,8 @@ struct arm_spe_pmu {
 #define to_spe_pmu(p) (container_of(p, struct arm_spe_pmu, pmu))
 
 /* Convert a free-running index from perf into an SPE buffer offset */
-#define PERF_IDX2OFF(idx, buf)	((idx) % ((buf)->nr_pages << PAGE_SHIFT))
+#define PERF_IDX2OFF(idx, buf) \
+	((idx) % ((unsigned long)(buf)->nr_pages << PAGE_SHIFT))
 
 /* Keep track of our dynamic hotplug state */
 static enum cpuhp_state arm_spe_pmu_online;
diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 51408996255b..e2601e45935e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -187,6 +187,9 @@ static const unsigned int i2c_sda_c_pins[]	= { GPIODV_28 };
 static const unsigned int i2c_sck_c_dv19_pins[] = { GPIODV_19 };
 static const unsigned int i2c_sda_c_dv18_pins[] = { GPIODV_18 };
 
+static const unsigned int i2c_sck_d_pins[]	= { GPIOX_11 };
+static const unsigned int i2c_sda_d_pins[]	= { GPIOX_10 };
+
 static const unsigned int eth_mdio_pins[]	= { GPIOZ_0 };
 static const unsigned int eth_mdc_pins[]	= { GPIOZ_1 };
 static const unsigned int eth_clk_rx_clk_pins[] = { GPIOZ_2 };
@@ -411,6 +414,8 @@ static struct meson_pmx_group meson_gxl_periphs_groups[] = {
 	GPIO_GROUP(GPIO_TEST_N),
 
 	/* Bank X */
+	GROUP(i2c_sda_d,	5,	5),
+	GROUP(i2c_sck_d,	5,	4),
 	GROUP(sdio_d0,		5,	31),
 	GROUP(sdio_d1,		5,	30),
 	GROUP(sdio_d2,		5,	29),
@@ -651,6 +656,10 @@ static const char * const i2c_c_groups[] = {
 	"i2c_sck_c", "i2c_sda_c", "i2c_sda_c_dv18", "i2c_sck_c_dv19",
 };
 
+static const char * const i2c_d_groups[] = {
+	"i2c_sck_d", "i2c_sda_d",
+};
+
 static const char * const eth_groups[] = {
 	"eth_mdio", "eth_mdc", "eth_clk_rx_clk", "eth_rx_dv",
 	"eth_rxd0", "eth_rxd1", "eth_rxd2", "eth_rxd3",
@@ -777,6 +786,7 @@ static struct meson_pmx_func meson_gxl_periphs_functions[] = {
 	FUNCTION(i2c_a),
 	FUNCTION(i2c_b),
 	FUNCTION(i2c_c),
+	FUNCTION(i2c_d),
 	FUNCTION(eth),
 	FUNCTION(pwm_a),
 	FUNCTION(pwm_b),
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 6cdbd9ccf2f0..050908aec443 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -328,7 +328,7 @@ static int pinmux_func_name_to_selector(struct pinctrl_dev *pctldev,
 	while (selector < nfuncs) {
 		const char *fname = ops->get_function_name(pctldev, selector);
 
-		if (!strcmp(function, fname))
+		if (fname && !strcmp(function, fname))
 			return selector;
 
 		selector++;
diff --git a/drivers/pinctrl/renesas/pinctrl.c b/drivers/pinctrl/renesas/pinctrl.c
index f3eecb20c086..37f8d51046b8 100644
--- a/drivers/pinctrl/renesas/pinctrl.c
+++ b/drivers/pinctrl/renesas/pinctrl.c
@@ -755,7 +755,8 @@ static int sh_pfc_pinconf_group_set(struct pinctrl_dev *pctldev, unsigned group,
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 	const unsigned int *pins;
 	unsigned int num_pins;
-	unsigned int i, ret;
+	unsigned int i;
+	int ret;
 
 	pins = pmx->pfc->info->groups[group].pins;
 	num_pins = pmx->pfc->info->groups[group].nr_pins;
diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 401fa8f223d6..31494f424786 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -345,6 +345,9 @@ static int skl_int3472_discrete_probe(struct platform_device *pdev)
 	struct int3472_cldb cldb;
 	int ret;
 
+	if (!adev)
+		return -ENODEV;
+
 	ret = skl_int3472_fill_cldb(adev, &cldb);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't fill CLDB structure\n");
diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
index fd3bef449137..b3faae7b2373 100644
--- a/drivers/platform/x86/intel/int3472/tps68470.c
+++ b/drivers/platform/x86/intel/int3472/tps68470.c
@@ -102,6 +102,9 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
 	int device_type;
 	int ret;
 
+	if (!adev)
+		return -ENODEV;
+
 	regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
 	if (IS_ERR(regmap)) {
 		dev_err(&client->dev, "Failed to create regmap: %ld\n", PTR_ERR(regmap));
diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 336dee9485d4..3c27d6b66bb4 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -757,7 +757,6 @@ static union acpi_object *__call_snc_method(acpi_handle handle, char *method,
 	return result;
 }
 
-#define MIN(a, b)	(a > b ? b : a)
 static int sony_nc_buffer_call(acpi_handle handle, char *name, u64 *value,
 		void *buffer, size_t buflen)
 {
diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index 92d1b62ea239..e9389876229e 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -109,16 +109,13 @@ struct pps_device *pps_register_source(struct pps_source_info *info,
 	if (err < 0) {
 		pr_err("%s: unable to create char device\n",
 					info->name);
-		goto kfree_pps;
+		goto pps_register_source_exit;
 	}
 
 	dev_dbg(&pps->dev, "new PPS source %s\n", info->name);
 
 	return pps;
 
-kfree_pps:
-	kfree(pps);
-
 pps_register_source_exit:
 	pr_err("%s: unable to register source\n", info->name);
 
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index ea966fc67d28..dbeb67ffebf3 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -375,6 +375,7 @@ int pps_register_cdev(struct pps_device *pps)
 			       pps->info.name);
 			err = -EBUSY;
 		}
+		kfree(pps);
 		goto out_unlock;
 	}
 	pps->id = err;
@@ -384,13 +385,11 @@ int pps_register_cdev(struct pps_device *pps)
 	pps->dev.devt = MKDEV(pps_major, pps->id);
 	dev_set_drvdata(&pps->dev, pps);
 	dev_set_name(&pps->dev, "pps%d", pps->id);
+	pps->dev.release = pps_device_destruct;
 	err = device_register(&pps->dev);
 	if (err)
 		goto free_idr;
 
-	/* Override the release function with our own */
-	pps->dev.release = pps_device_destruct;
-
 	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name, pps_major,
 		 pps->id);
 
diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index e157273fd2f7..c8a586e02cc6 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -274,7 +274,7 @@ static int berlin_pwm_suspend(struct device *dev)
 		if (!channel)
 			continue;
 
-		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_ENABLE);
+		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_EN);
 		channel->ctrl = berlin_pwm_readl(bpc, i, BERLIN_PWM_CONTROL);
 		channel->duty = berlin_pwm_readl(bpc, i, BERLIN_PWM_DUTY);
 		channel->tcnt = berlin_pwm_readl(bpc, i, BERLIN_PWM_TCNT);
@@ -305,7 +305,7 @@ static int berlin_pwm_resume(struct device *dev)
 		berlin_pwm_writel(bpc, i, channel->ctrl, BERLIN_PWM_CONTROL);
 		berlin_pwm_writel(bpc, i, channel->duty, BERLIN_PWM_DUTY);
 		berlin_pwm_writel(bpc, i, channel->tcnt, BERLIN_PWM_TCNT);
-		berlin_pwm_writel(bpc, i, channel->enable, BERLIN_PWM_ENABLE);
+		berlin_pwm_writel(bpc, i, channel->enable, BERLIN_PWM_EN);
 	}
 
 	return 0;
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 5b723a48c5f1..3fef7d798773 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -167,7 +167,7 @@ static int set_prescale_div(unsigned long rqst_prescaler, u16 *prescale_div,
 
 			*prescale_div = (1 << clkdiv) *
 					(hspclkdiv ? (hspclkdiv * 2) : 1);
-			if (*prescale_div > rqst_prescaler) {
+			if (*prescale_div >= rqst_prescaler) {
 				*tb_clk_div = (clkdiv << TBCTL_CLKDIV_SHIFT) |
 					(hspclkdiv << TBCTL_HSPCLKDIV_SHIFT);
 				return 0;
@@ -266,7 +266,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pc->period_cycles[pwm->hwpwm] = period_cycles;
 
 	/* Configure clock prescaler to support Low frequency PWM wave */
-	if (set_prescale_div(period_cycles/PERIOD_MAX, &ps_divval,
+	if (set_prescale_div(DIV_ROUND_UP(period_cycles, PERIOD_MAX), &ps_divval,
 			     &tb_divval)) {
 		dev_err(chip->dev, "Unsupported values\n");
 		return -EINVAL;
diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 41ae7ac27ff6..7c0d29c7856b 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -257,7 +257,8 @@ static int process_scmi_regulator_of_node(struct scmi_device *sdev,
 					  struct device_node *np,
 					  struct scmi_regulator_info *rinfo)
 {
-	u32 dom, ret;
+	u32 dom;
+	int ret;
 
 	ret = of_property_read_u32(np, "reg", &dom);
 	if (ret)
diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 7e9244c748da..515c6d68e47c 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -116,9 +116,6 @@ int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout)
 	int ret;
 
 	ret = wait_for_completion_timeout(&q6v5->start_done, timeout);
-	if (!ret)
-		disable_irq(q6v5->handover_irq);
-
 	return !ret ? -ETIMEDOUT : 0;
 }
 EXPORT_SYMBOL_GPL(qcom_q6v5_wait_for_start);
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 7c62b1307762..e91ab1df4c6b 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -442,6 +442,29 @@ static int __rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	else
 		err = rtc->ops->set_alarm(rtc->dev.parent, alarm);
 
+	/*
+	 * Check for potential race described above. If the waiting for next
+	 * second, and the second just ticked since the check above, either
+	 *
+	 * 1) It ticked after the alarm was set, and an alarm irq should be
+	 *    generated.
+	 *
+	 * 2) It ticked before the alarm was set, and alarm irq most likely will
+	 * not be generated.
+	 *
+	 * While we cannot easily check for which of these two scenarios we
+	 * are in, we can return -ETIME to signal that the timer has already
+	 * expired, which is true in both cases.
+	 */
+	if ((scheduled - now) <= 1) {
+		err = __rtc_read_time(rtc, &tm);
+		if (err)
+			return err;
+		now = rtc_tm_to_time64(&tm);
+		if (scheduled <= now)
+			return -ETIME;
+	}
+
 	trace_rtc_set_alarm(rtc_tm_to_time64(&alarm->time), err);
 	return err;
 }
@@ -583,6 +606,10 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 		rtc->uie_rtctimer.node.expires = ktime_add(now, onesec);
 		rtc->uie_rtctimer.period = ktime_set(1, 0);
 		err = rtc_timer_enqueue(rtc, &rtc->uie_rtctimer);
+		if (!err && rtc->ops && rtc->ops->alarm_irq_enable)
+			err = rtc->ops->alarm_irq_enable(rtc->dev.parent, 1);
+		if (err)
+			goto out;
 	} else {
 		rtc_timer_remove(rtc, &rtc->uie_rtctimer);
 	}
diff --git a/drivers/rtc/rtc-x1205.c b/drivers/rtc/rtc-x1205.c
index d1d5a44d9122..3b3aaa7d8283 100644
--- a/drivers/rtc/rtc-x1205.c
+++ b/drivers/rtc/rtc-x1205.c
@@ -671,7 +671,7 @@ static const struct i2c_device_id x1205_id[] = {
 MODULE_DEVICE_TABLE(i2c, x1205_id);
 
 static const struct of_device_id x1205_dt_ids[] = {
-	{ .compatible = "xircom,x1205", },
+	{ .compatible = "xicor,x1205", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, x1205_dt_ids);
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index c2ed91b69f07..70c5b85d2dfc 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1327,6 +1327,7 @@ static int purge_fn(struct device *dev, void *data)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
 	struct ccw_dev_id *id = &cdev->private->dev_id;
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
 
 	spin_lock_irq(cdev->ccwlock);
 	if (is_blacklisted(id->ssid, id->devno) &&
@@ -1335,6 +1336,7 @@ static int purge_fn(struct device *dev, void *data)
 		CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x\n", id->ssid,
 			      id->devno);
 		ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
+		css_sched_sch_todo(sch, SCH_TODO_UNREG);
 		atomic_set(&cdev->private->onoff, 0);
 	}
 	spin_unlock_irq(cdev->ccwlock);
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index b54c8aa8e803..6a58f775198e 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6528,18 +6528,21 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h,
 	while (left) {
 		sz = (left > ioc->malloc_size) ? ioc->malloc_size : left;
 		buff_size[sg_used] = sz;
-		buff[sg_used] = kmalloc(sz, GFP_KERNEL);
-		if (buff[sg_used] == NULL) {
-			status = -ENOMEM;
-			goto cleanup1;
-		}
+
 		if (ioc->Request.Type.Direction & XFER_WRITE) {
-			if (copy_from_user(buff[sg_used], data_ptr, sz)) {
-				status = -EFAULT;
+			buff[sg_used] = memdup_user(data_ptr, sz);
+			if (IS_ERR(buff[sg_used])) {
+				status = PTR_ERR(buff[sg_used]);
 				goto cleanup1;
 			}
-		} else
-			memset(buff[sg_used], 0, sz);
+		} else {
+			buff[sg_used] = kzalloc(sz, GFP_KERNEL);
+			if (!buff[sg_used]) {
+				status = -ENOMEM;
+				goto cleanup1;
+			}
+		}
+
 		left -= sz;
 		data_ptr += sz;
 		sg_used++;
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index bd73f6925a9d..73144b2966ba 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -65,11 +65,7 @@
 #include "task.h"
 #include "probe_roms.h"
 
-#define MAJ 1
-#define MIN 2
-#define BUILD 0
-#define DRV_VERSION __stringify(MAJ) "." __stringify(MIN) "." \
-	__stringify(BUILD)
+#define DRV_VERSION "1.2.0"
 
 MODULE_VERSION(DRV_VERSION);
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index e8a4750f6ec4..7d6e4fe31cee 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -991,11 +991,9 @@ mpt3sas_transport_port_remove(struct MPT3SAS_ADAPTER *ioc, u64 sas_address,
 	list_for_each_entry_safe(mpt3sas_phy, next_phy,
 	    &mpt3sas_port->phy_list, port_siblings) {
 		if ((ioc->logging_level & MPT_DEBUG_TRANSPORT))
-			dev_printk(KERN_INFO, &mpt3sas_port->port->dev,
-			    "remove: sas_addr(0x%016llx), phy(%d)\n",
-			    (unsigned long long)
-			    mpt3sas_port->remote_identify.sas_address,
-			    mpt3sas_phy->phy_id);
+			ioc_info(ioc, "remove: sas_addr(0x%016llx), phy(%d)\n",
+				(unsigned long long) mpt3sas_port->remote_identify.sas_address,
+					mpt3sas_phy->phy_id);
 		mpt3sas_phy->phy_belongs_to_port = 0;
 		if (!ioc->remove_host)
 			sas_port_delete_phy(mpt3sas_port->port,
diff --git a/drivers/scsi/mvsas/mv_defs.h b/drivers/scsi/mvsas/mv_defs.h
index 7123a2efbf58..8ef174cd4d37 100644
--- a/drivers/scsi/mvsas/mv_defs.h
+++ b/drivers/scsi/mvsas/mv_defs.h
@@ -40,6 +40,7 @@ enum driver_configuration {
 	MVS_ATA_CMD_SZ		= 96,	/* SATA command table buffer size */
 	MVS_OAF_SZ		= 64,	/* Open address frame buffer size */
 	MVS_QUEUE_SIZE		= 64,	/* Support Queue depth */
+	MVS_RSVD_SLOTS		= 4,
 	MVS_SOC_CAN_QUEUE	= MVS_SOC_SLOTS - 2,
 };
 
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 1c98662db080..d348350c1509 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -141,8 +141,8 @@ static void mvs_free(struct mvs_info *mvi)
 	if (mvi->shost)
 		scsi_host_put(mvi->shost);
 	list_for_each_entry(mwq, &mvi->wq_list, entry)
-		cancel_delayed_work(&mwq->work_q);
-	kfree(mvi->tags);
+		cancel_delayed_work_sync(&mwq->work_q);
+	kfree(mvi->rsvd_tags);
 	kfree(mvi);
 }
 
@@ -284,10 +284,7 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
 			printk(KERN_DEBUG "failed to create dma pool %s.\n", pool_name);
 			goto err_out;
 	}
-	mvi->tags_num = slot_nr;
 
-	/* Initialize tags */
-	mvs_tag_init(mvi);
 	return 0;
 err_out:
 	return 1;
@@ -369,8 +366,8 @@ static struct mvs_info *mvs_pci_alloc(struct pci_dev *pdev,
 	mvi->sas = sha;
 	mvi->shost = shost;
 
-	mvi->tags = kzalloc(MVS_CHIP_SLOT_SZ>>3, GFP_KERNEL);
-	if (!mvi->tags)
+	mvi->rsvd_tags = bitmap_zalloc(MVS_RSVD_SLOTS, GFP_KERNEL);
+	if (!mvi->rsvd_tags)
 		goto err_out;
 
 	if (MVS_CHIP_DISP->chip_ioremap(mvi))
@@ -471,6 +468,8 @@ static void  mvs_post_sas_ha_init(struct Scsi_Host *shost,
 	else
 		can_queue = MVS_CHIP_SLOT_SZ;
 
+	can_queue -= MVS_RSVD_SLOTS;
+
 	shost->sg_tablesize = min_t(u16, SG_ALL, MVS_MAX_SG);
 	shost->can_queue = can_queue;
 	mvi->shost->cmd_per_lun = MVS_QUEUE_SIZE;
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index efd11fabff93..e79297395ac7 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -20,44 +20,40 @@ static int mvs_find_tag(struct mvs_info *mvi, struct sas_task *task, u32 *tag)
 	return 0;
 }
 
-void mvs_tag_clear(struct mvs_info *mvi, u32 tag)
+static void mvs_tag_clear(struct mvs_info *mvi, u32 tag)
 {
-	void *bitmap = mvi->tags;
+	void *bitmap = mvi->rsvd_tags;
 	clear_bit(tag, bitmap);
 }
 
-void mvs_tag_free(struct mvs_info *mvi, u32 tag)
+static void mvs_tag_free(struct mvs_info *mvi, u32 tag)
 {
+	if (tag >= MVS_RSVD_SLOTS)
+		return;
+
 	mvs_tag_clear(mvi, tag);
 }
 
-void mvs_tag_set(struct mvs_info *mvi, unsigned int tag)
+static void mvs_tag_set(struct mvs_info *mvi, unsigned int tag)
 {
-	void *bitmap = mvi->tags;
+	void *bitmap = mvi->rsvd_tags;
 	set_bit(tag, bitmap);
 }
 
-inline int mvs_tag_alloc(struct mvs_info *mvi, u32 *tag_out)
+static int mvs_tag_alloc(struct mvs_info *mvi, u32 *tag_out)
 {
 	unsigned int index, tag;
-	void *bitmap = mvi->tags;
+	void *bitmap = mvi->rsvd_tags;
 
-	index = find_first_zero_bit(bitmap, mvi->tags_num);
+	index = find_first_zero_bit(bitmap, MVS_RSVD_SLOTS);
 	tag = index;
-	if (tag >= mvi->tags_num)
+	if (tag >= MVS_RSVD_SLOTS)
 		return -SAS_QUEUE_FULL;
 	mvs_tag_set(mvi, tag);
 	*tag_out = tag;
 	return 0;
 }
 
-void mvs_tag_init(struct mvs_info *mvi)
-{
-	int i;
-	for (i = 0; i < mvi->tags_num; ++i)
-		mvs_tag_clear(mvi, i);
-}
-
 static struct mvs_info *mvs_find_dev_mvi(struct domain_device *dev)
 {
 	unsigned long i = 0, j = 0, hi = 0;
@@ -698,6 +694,7 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
 	struct mvs_task_exec_info tei;
 	struct mvs_slot_info *slot;
 	u32 tag = 0xdeadbeef, n_elem = 0;
+	struct request *rq;
 	int rc = 0;
 
 	if (!dev->port) {
@@ -762,9 +759,14 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
 		n_elem = task->num_scatter;
 	}
 
-	rc = mvs_tag_alloc(mvi, &tag);
-	if (rc)
-		goto err_out;
+	rq = sas_task_find_rq(task);
+	if (rq) {
+		tag = rq->tag + MVS_RSVD_SLOTS;
+	} else {
+		rc = mvs_tag_alloc(mvi, &tag);
+		if (rc)
+			goto err_out;
+	}
 
 	slot = &mvi->slot_info[tag];
 
@@ -867,7 +869,7 @@ int mvs_queue_command(struct sas_task *task, gfp_t gfp_flags)
 static void mvs_slot_free(struct mvs_info *mvi, u32 rx_desc)
 {
 	u32 slot_idx = rx_desc & RXQ_SLOT_MASK;
-	mvs_tag_clear(mvi, slot_idx);
+	mvs_tag_free(mvi, slot_idx);
 }
 
 static void mvs_slot_task_free(struct mvs_info *mvi, struct sas_task *task,
diff --git a/drivers/scsi/mvsas/mv_sas.h b/drivers/scsi/mvsas/mv_sas.h
index fa654c73beee..cba6e7667a7b 100644
--- a/drivers/scsi/mvsas/mv_sas.h
+++ b/drivers/scsi/mvsas/mv_sas.h
@@ -370,8 +370,7 @@ struct mvs_info {
 	u32 chip_id;
 	const struct mvs_chip_info *chip;
 
-	int tags_num;
-	unsigned long *tags;
+	unsigned long *rsvd_tags;
 	/* further per-slot information */
 	struct mvs_phy phy[MVS_MAX_PHYS];
 	struct mvs_port port[MVS_MAX_PHYS];
@@ -424,11 +423,6 @@ struct mvs_task_exec_info {
 
 /******************** function prototype *********************/
 void mvs_get_sas_addr(void *buf, u32 buflen);
-void mvs_tag_clear(struct mvs_info *mvi, u32 tag);
-void mvs_tag_free(struct mvs_info *mvi, u32 tag);
-void mvs_tag_set(struct mvs_info *mvi, unsigned int tag);
-int mvs_tag_alloc(struct mvs_info *mvi, u32 *tag_out);
-void mvs_tag_init(struct mvs_info *mvi);
 void mvs_iounmap(void __iomem *regs);
 int mvs_ioremap(struct mvs_info *mvi, int bar, int bar_ex);
 void mvs_phys_reset(struct mvs_info *mvi, u32 phy_mask, int hard);
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 3f05f13fb107..ec834b5951e7 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -498,14 +498,14 @@ static bool myrs_enable_mmio_mbox(struct myrs_hba *cs,
 	/* Temporary dma mapping, used only in the scope of this function */
 	mbox = dma_alloc_coherent(&pdev->dev, sizeof(union myrs_cmd_mbox),
 				  &mbox_addr, GFP_KERNEL);
-	if (dma_mapping_error(&pdev->dev, mbox_addr))
+	if (!mbox)
 		return false;
 
 	/* These are the base addresses for the command memory mailbox array */
 	cs->cmd_mbox_size = MYRS_MAX_CMD_MBOX * sizeof(union myrs_cmd_mbox);
 	cmd_mbox = dma_alloc_coherent(&pdev->dev, cs->cmd_mbox_size,
 				      &cs->cmd_mbox_addr, GFP_KERNEL);
-	if (dma_mapping_error(&pdev->dev, cs->cmd_mbox_addr)) {
+	if (!cmd_mbox) {
 		dev_err(&pdev->dev, "Failed to map command mailbox\n");
 		goto out_free;
 	}
@@ -520,7 +520,7 @@ static bool myrs_enable_mmio_mbox(struct myrs_hba *cs,
 	cs->stat_mbox_size = MYRS_MAX_STAT_MBOX * sizeof(struct myrs_stat_mbox);
 	stat_mbox = dma_alloc_coherent(&pdev->dev, cs->stat_mbox_size,
 				       &cs->stat_mbox_addr, GFP_KERNEL);
-	if (dma_mapping_error(&pdev->dev, cs->stat_mbox_addr)) {
+	if (!stat_mbox) {
 		dev_err(&pdev->dev, "Failed to map status mailbox\n");
 		goto out_free;
 	}
@@ -533,7 +533,7 @@ static bool myrs_enable_mmio_mbox(struct myrs_hba *cs,
 	cs->fwstat_buf = dma_alloc_coherent(&pdev->dev,
 					    sizeof(struct myrs_fwstat),
 					    &cs->fwstat_addr, GFP_KERNEL);
-	if (dma_mapping_error(&pdev->dev, cs->fwstat_addr)) {
+	if (!cs->fwstat_buf) {
 		dev_err(&pdev->dev, "Failed to map firmware health buffer\n");
 		cs->fwstat_buf = NULL;
 		goto out_free;
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 0c79f2a9eba7..c4f5a2a17bd6 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -875,6 +875,7 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
 	unsigned long flags = 0;
 	struct pm8001_hba_info *pm8001_ha;
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
+	struct domain_device *parent_dev = dev->parent;
 
 	pm8001_ha = pm8001_find_ha_by_dev(dev);
 	spin_lock_irqsave(&pm8001_ha->lock, flags);
@@ -892,7 +893,13 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
 			spin_lock_irqsave(&pm8001_ha->lock, flags);
 		}
 		PM8001_CHIP_DISP->dereg_dev_req(pm8001_ha, device_id);
-		pm8001_ha->phy[pm8001_dev->attached_phy].phy_attached = 0;
+
+		/*
+		 * The phy array only contains local phys. Thus, we cannot clear
+		 * phy_attached for a device behind an expander.
+		 */
+		if (!(parent_dev && dev_is_expander(parent_dev->dev_type)))
+			pm8001_ha->phy[pm8001_dev->attached_phy].phy_attached = 0;
 		pm8001_free_dev(pm8001_dev);
 	} else {
 		pm8001_dbg(pm8001_ha, DISC, "Found dev has gone.\n");
diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index ac702f74dd98..dfc7bff420cd 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -1539,7 +1539,7 @@ qla24xx_sadb_update(struct bsg_job *bsg_job)
 	switch (rval) {
 	case QLA_SUCCESS:
 		break;
-	case EAGAIN:
+	case -EAGAIN:
 		msleep(EDIF_MSLEEP_INTERVAL);
 		cnt++;
 		if (cnt < EDIF_RETRY_COUNT)
@@ -3525,7 +3525,7 @@ int qla_edif_process_els(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 		       p->e.extra_rx_xchg_address, p->e.extra_control_flags,
 		       sp->handle, sp->remap.req.len, bsg_job);
 		break;
-	case EAGAIN:
+	case -EAGAIN:
 		msleep(EDIF_MSLEEP_INTERVAL);
 		cnt++;
 		if (cnt < EDIF_RETRY_COUNT)
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 2053c560b580..5f3593680c95 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2061,11 +2061,11 @@ static void qla_marker_sp_done(srb_t *sp, int res)
 	int cnt = 5; \
 	do { \
 		if (_chip_gen != sp->vha->hw->chip_reset || _login_gen != sp->fcport->login_gen) {\
-			_rval = EINVAL; \
+			_rval = -EINVAL; \
 			break; \
 		} \
 		_rval = qla2x00_start_sp(_sp); \
-		if (_rval == EAGAIN) \
+		if (_rval == -EAGAIN) \
 			msleep(1); \
 		else \
 			break; \
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 4c9400cf6686..5dc60ee0b07a 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -415,13 +415,10 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 
 		trace_rpmh_tx_done(drv, i, req, err);
 
-		/*
-		 * If wake tcs was re-purposed for sending active
-		 * votes, clear AMC trigger & enable modes and
+		/* Clear AMC trigger & enable modes and
 		 * disable interrupt for this TCS
 		 */
-		if (!drv->tcs[ACTIVE_TCS].num_tcs)
-			__tcs_set_trigger(drv, i, false);
+		__tcs_set_trigger(drv, i, false);
 skip:
 		/* Reclaim the TCS */
 		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i, 0);
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index a60399417a28..91fdc9132b96 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -666,6 +666,7 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (op->addr.nbytes - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+	readl(reg_base + CQSPI_REG_SIZE); /* Flush posted write. */
 	return 0;
 }
 
@@ -694,6 +695,7 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	reinit_completion(&cqspi->transfer_complete);
 	writel(CQSPI_REG_INDIRECTRD_START_MASK,
 	       reg_base + CQSPI_REG_INDIRECTRD);
+	readl(reg_base + CQSPI_REG_INDIRECTRD); /* Flush posted write. */
 
 	while (remaining > 0) {
 		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
@@ -809,6 +811,7 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (op->addr.nbytes - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+	readl(reg_base + CQSPI_REG_SIZE); /* Flush posted write. */
 	return 0;
 }
 
@@ -834,6 +837,8 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	reinit_completion(&cqspi->transfer_complete);
 	writel(CQSPI_REG_INDIRECTWR_START_MASK,
 	       reg_base + CQSPI_REG_INDIRECTWR);
+	readl(reg_base + CQSPI_REG_INDIRECTWR); /* Flush posted write. */
+
 	/*
 	 * As per 66AK2G02 TRM SPRUHY8F section 11.15.5.3 Indirect Access
 	 * Controller programming sequence, couple of cycles of
diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 46b79c945079..a365243ebab6 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -400,6 +400,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 	}
 
 	bytes_available = ioread32(fifo->base_addr + XLLF_RLR_OFFSET);
+	words_available = bytes_available / sizeof(u32);
 	if (!bytes_available) {
 		dev_err(fifo->dt_device, "received a packet of length 0\n");
 		ret = -EIO;
@@ -410,7 +411,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		dev_err(fifo->dt_device, "user read buffer too small (available bytes=%zu user buffer bytes=%zu)\n",
 			bytes_available, len);
 		ret = -EINVAL;
-		goto end_unlock;
+		goto err_flush_rx;
 	}
 
 	if (bytes_available % sizeof(u32)) {
@@ -419,11 +420,9 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		 */
 		dev_err(fifo->dt_device, "received a packet that isn't word-aligned\n");
 		ret = -EIO;
-		goto end_unlock;
+		goto err_flush_rx;
 	}
 
-	words_available = bytes_available / sizeof(u32);
-
 	/* read data into an intermediate buffer, copying the contents
 	 * to userspace when the buffer is full
 	 */
@@ -435,18 +434,23 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 			tmp_buf[i] = ioread32(fifo->base_addr +
 					      XLLF_RDFD_OFFSET);
 		}
+		words_available -= copy;
 
 		if (copy_to_user(buf + copied * sizeof(u32), tmp_buf,
 				 copy * sizeof(u32))) {
 			ret = -EFAULT;
-			goto end_unlock;
+			goto err_flush_rx;
 		}
 
 		copied += copy;
-		words_available -= copy;
 	}
+	mutex_unlock(&fifo->read_lock);
 
-	ret = bytes_available;
+	return bytes_available;
+
+err_flush_rx:
+	while (words_available--)
+		ioread32(fifo->base_addr + XLLF_RDFD_OFFSET);
 
 end_unlock:
 	mutex_unlock(&fifo->read_lock);
@@ -494,11 +498,17 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		return -EINVAL;
 	}
 
-	if (words_to_write > fifo->tx_fifo_depth) {
-		dev_err(fifo->dt_device, "tried to write more words [%u] than slots in the fifo buffer [%u]\n",
-			words_to_write, fifo->tx_fifo_depth);
+	/*
+	 * In 'Store-and-Forward' mode, the maximum packet that can be
+	 * transmitted is limited by the size of the FIFO, which is
+	 * (C_TX_FIFO_DEPTH–4)*(data interface width/8) bytes.
+	 *
+	 * Do not attempt to send a packet larger than 'tx_fifo_depth - 4',
+	 * otherwise a 'Transmit Packet Overrun Error' interrupt will be
+	 * raised, which requires a reset of the TX circuit to recover.
+	 */
+	if (words_to_write > (fifo->tx_fifo_depth - 4))
 		return -EINVAL;
-	}
 
 	if (fifo->write_flags & O_NONBLOCK) {
 		/*
diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h
index a444ec14ff9d..1c17a87a8572 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h
@@ -31,11 +31,6 @@
 /* A => B */
 #define IMPLIES(a, b)        (!(a) || (b))
 
-/* for preprocessor and array sizing use MIN and MAX
-   otherwise use min and max */
-#define MAX(a, b)            (((a) > (b)) ? (a) : (b))
-#define MIN(a, b)            (((a) < (b)) ? (a) : (b))
-
 #define ROUND_DIV(a, b)      (((b) != 0) ? ((a) + ((b) >> 1)) / (b) : 0)
 #define CEIL_DIV(a, b)       (((b) != 0) ? ((a) + (b) - 1) / (b) : 0)
 #define CEIL_MUL(a, b)       (CEIL_DIV(a, b) * (b))
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 30ce3451bc6b..73a9e7b0ecbc 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -2679,7 +2679,7 @@ static ssize_t target_lu_gp_members_show(struct config_item *item, char *page)
 			config_item_name(&dev->dev_group.cg_item));
 		cur_len++; /* Extra byte for NULL terminator */
 
-		if ((cur_len + len) > PAGE_SIZE) {
+		if ((cur_len + len) > PAGE_SIZE || cur_len > LU_GROUP_NAME_BUF) {
 			pr_warn("Ran out of lu_gp_show_attr"
 				"_members buffer\n");
 			break;
diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index bfd889422dd3..22cd3d538491 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -34,7 +34,8 @@ config QCOM_SPMI_TEMP_ALARM
 
 config QCOM_LMH
 	tristate "Qualcomm Limits Management Hardware"
-	depends on ARCH_QCOM && QCOM_SCM
+	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_SCM
 	help
 	  This enables initialization of Qualcomm limits management
 	  hardware(LMh). LMh allows for hardware-enforced mitigation for cpus based on
diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 9006e01e18c2..62c20d5c2a66 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -5,6 +5,8 @@
  */
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
 #include <linux/irqdomain.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 131a6a587acd..4fc5c043adf6 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1438,7 +1438,7 @@ config SERIAL_STM32
 
 config SERIAL_STM32_CONSOLE
 	bool "Support for console on STM32"
-	depends on SERIAL_STM32=y
+	depends on SERIAL_STM32
 	select SERIAL_CORE_CONSOLE
 
 config SERIAL_MVEBU_UART
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 865a5b289e0a..137109f5f69b 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -96,7 +96,6 @@ static void hv_uio_channel_cb(void *context)
 	struct hv_device *hv_dev = chan->device_obj;
 	struct hv_uio_private_data *pdata = hv_get_drvdata(hv_dev);
 
-	chan->inbound.ring_buffer->interrupt_mask = 1;
 	virt_mb();
 
 	uio_event_notify(&pdata->info);
@@ -173,8 +172,6 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
 		return;
 	}
 
-	/* Disable interrupts on sub channel */
-	new_sc->inbound.ring_buffer->interrupt_mask = 1;
 	set_channel_read_mode(new_sc, HV_CALL_ISR);
 
 	ret = sysfs_create_bin_file(&new_sc->kobj, &ring_buffer_bin_attr);
@@ -218,9 +215,7 @@ hv_uio_open(struct uio_info *info, struct inode *inode)
 
 	ret = vmbus_connect_ring(dev->channel,
 				 hv_uio_channel_cb, dev->channel);
-	if (ret == 0)
-		dev->channel->inbound.ring_buffer->interrupt_mask = 1;
-	else
+	if (ret)
 		atomic_dec(&pdata->refcnt);
 
 	return ret;
diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
index b7a1f28faa1f..d177dc6dd441 100644
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -90,7 +90,7 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
 		cdnsp = kzalloc(sizeof(*cdnsp), GFP_KERNEL);
 		if (!cdnsp) {
 			ret = -ENOMEM;
-			goto disable_pci;
+			goto put_pci;
 		}
 	}
 
@@ -173,9 +173,6 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
 	if (!pci_is_enabled(func))
 		kfree(cdnsp);
 
-disable_pci:
-	pci_disable_device(pdev);
-
 put_pci:
 	pci_dev_put(func);
 
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 6423930b0e72..9a3de907de69 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1364,6 +1364,8 @@ static int configfs_composite_bind(struct usb_gadget *gadget,
 		cdev->use_os_string = true;
 		cdev->b_vendor_code = gi->b_vendor_code;
 		memcpy(cdev->qw_sign, gi->qw_sign, OS_STRING_QW_SIGN_LEN);
+	} else {
+		cdev->use_os_string = false;
 	}
 
 	if (gadget_is_otg(gadget) && !otg_desc[0]) {
diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index 37a5914f7987..b2641009519b 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1925,7 +1925,7 @@ max3421_probe(struct spi_device *spi)
 	if (hcd) {
 		kfree(max3421_hcd->tx);
 		kfree(max3421_hcd->rx);
-		if (max3421_hcd->spi_thread)
+		if (!IS_ERR_OR_NULL(max3421_hcd->spi_thread))
 			kthread_stop(max3421_hcd->spi_thread);
 		usb_put_hcd(hcd);
 	}
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index ddb7c88d5365..0ff63e9d815a 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1183,19 +1183,16 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			 * Stopped state, but it will soon change to Running.
 			 *
 			 * Assume this bug on unexpected Stop Endpoint failures.
-			 * Keep retrying until the EP starts and stops again.
+			 * Keep retrying until the EP starts and stops again, on
+			 * chips where this is known to help. Wait for 100ms.
 			 */
+			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
+				break;
 			fallthrough;
 		case EP_STATE_RUNNING:
 			/* Race, HW handled stop ep cmd before ep was running */
 			xhci_dbg(xhci, "Stop ep completion ctx error, ctx_state %d\n",
 					GET_EP_CTX_STATE(ep_ctx));
-			/*
-			 * Don't retry forever if we guessed wrong or a defective HC never starts
-			 * the EP or says 'Running' but fails the command. We must give back TDs.
-			 */
-			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
-				break;
 
 			command = xhci_alloc_command(xhci, false, GFP_ATOMIC);
 			if (!command)
diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6030-usb.c
index ab3c38a7d8ac..a73604af8960 100644
--- a/drivers/usb/phy/phy-twl6030-usb.c
+++ b/drivers/usb/phy/phy-twl6030-usb.c
@@ -328,9 +328,8 @@ static int twl6030_set_vbus(struct phy_companion *comparator, bool enabled)
 
 static int twl6030_usb_probe(struct platform_device *pdev)
 {
-	u32 ret;
 	struct twl6030_usb	*twl;
-	int			status, err;
+	int			status, err, ret;
 	struct device_node	*np = pdev->dev.of_node;
 	struct device		*dev = &pdev->dev;
 
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 7e58be8e1566..6f32842e24d5 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2114,6 +2114,12 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9003, 0xff) },	/* Simcom SIM7500/SIM7600 MBIM mode */
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9011, 0xff),	/* Simcom SIM7500/SIM7600 RNDIS mode */
 	  .driver_info = RSVD(7) },
+	{ USB_DEVICE(0x1e0e, 0x9071),				/* Simcom SIM8230 RMNET mode */
+	  .driver_info = RSVD(3) | RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9078, 0xff),	/* Simcom SIM8230 ECM mode */
+	  .driver_info = RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x907b, 0xff),	/* Simcom SIM8230 RNDIS mode */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9205, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT+ECM mode */
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9206, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT-only mode */
 	{ USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_X060S_X200),
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 6b98f5ab6dfe..e3c8483d7ba4 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -764,6 +764,17 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 				 ctrlreq->wValue, vdev->rhport);
 
 			vdev->udev = usb_get_dev(urb->dev);
+			/*
+			 * NOTE: A similar operation has been done via
+			 * USB_REQ_GET_DESCRIPTOR handler below, which is
+			 * supposed to always precede USB_REQ_SET_ADDRESS.
+			 *
+			 * It's not entirely clear if operating on a different
+			 * usb_device instance here is a real possibility,
+			 * otherwise this call and vdev->udev assignment above
+			 * should be dropped.
+			 */
+			dev_pm_syscore_device(&vdev->udev->dev, true);
 			usb_put_dev(old);
 
 			spin_lock(&vdev->ud.lock);
@@ -784,6 +795,17 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 					"Not yet?:Get_Descriptor to device 0 (get max pipe size)\n");
 
 			vdev->udev = usb_get_dev(urb->dev);
+			/*
+			 * Set syscore PM flag for the virtually attached
+			 * devices to ensure they will not enter suspend on
+			 * the client side.
+			 *
+			 * Note this doesn't have any impact on the physical
+			 * devices attached to the host system on the server
+			 * side, hence there is no need to undo the operation
+			 * on disconnect.
+			 */
+			dev_pm_syscore_device(&vdev->udev->dev, true);
 			usb_put_dev(old);
 			goto out;
 
diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
index 80b2e3f0e276..5446e5bbbff8 100644
--- a/drivers/virt/acrn/ioreq.c
+++ b/drivers/virt/acrn/ioreq.c
@@ -356,7 +356,7 @@ static bool handle_cf8cfc(struct acrn_vm *vm,
 	return is_handled;
 }
 
-static bool in_range(struct acrn_ioreq_range *range,
+static bool acrn_in_range(struct acrn_ioreq_range *range,
 		     struct acrn_io_request *req)
 {
 	bool ret = false;
@@ -394,7 +394,7 @@ static struct acrn_ioreq_client *find_ioreq_client(struct acrn_vm *vm,
 	list_for_each_entry(client, &vm->ioreq_clients, list) {
 		read_lock_bh(&client->range_lock);
 		list_for_each_entry(range, &client->range_list, list) {
-			if (in_range(range, req)) {
+			if (acrn_in_range(range, req)) {
 				found = client;
 				break;
 			}
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 1c569be72ea2..15644ae2387f 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -100,6 +100,8 @@ static int mpc8xxx_wdt_start(struct watchdog_device *w)
 	ddata->swtc = tmp >> 16;
 	set_bit(WDOG_HW_RUNNING, &ddata->wdd.status);
 
+	mpc8xxx_wdt_keepalive(ddata);
+
 	return 0;
 }
 
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 04ff194fecf4..3c0ee857a86f 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1331,10 +1331,11 @@ static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn)
 {
 	struct evtchn_status status;
 	evtchn_port_t port;
-	int rc = -ENOENT;
 
 	memset(&status, 0, sizeof(status));
 	for (port = 0; port < xen_evtchn_max_channels(); port++) {
+		int rc;
+
 		status.dom = DOMID_SELF;
 		status.port = port;
 		rc = HYPERVISOR_event_channel_op(EVTCHNOP_status, &status);
@@ -1344,10 +1345,10 @@ static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn)
 			continue;
 		if (status.u.virq == virq && status.vcpu == xen_vcpu_nr(cpu)) {
 			*evtchn = port;
-			break;
+			return 0;
 		}
 	}
-	return rc;
+	return -ENOENT;
 }
 
 /**
@@ -1819,9 +1820,20 @@ static int xen_rebind_evtchn_to_cpu(struct irq_info *info, unsigned int tcpu)
 	 * virq or IPI channel, which don't actually need to be rebound. Ignore
 	 * it, but don't do the xenlinux-level rebind in that case.
 	 */
-	if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0)
+	if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0) {
+		int old_cpu = info->cpu;
+
 		bind_evtchn_to_cpu(evtchn, tcpu, false);
 
+		if (info->type == IRQT_VIRQ) {
+			int virq = info->u.virq;
+			int irq = per_cpu(virq_to_irq, old_cpu)[virq];
+
+			per_cpu(virq_to_irq, old_cpu)[virq] = -1;
+			per_cpu(virq_to_irq, tcpu)[virq] = irq;
+		}
+	}
+
 	do_unmask(info, EVT_MASK_REASON_TEMPORARY);
 
 	return 0;
diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index 374d36de7f5a..f3e7874a94a9 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -116,7 +116,7 @@ static void do_suspend(void)
 	err = dpm_suspend_start(PMSG_FREEZE);
 	if (err) {
 		pr_err("%s: dpm_suspend_start %d\n", __func__, err);
-		goto out_thaw;
+		goto out_resume_end;
 	}
 
 	printk(KERN_DEBUG "suspending xenstore...\n");
@@ -156,6 +156,7 @@ static void do_suspend(void)
 	else
 		xs_suspend_cancel();
 
+out_resume_end:
 	dpm_resume_end(si.cancelled ? PMSG_THAW : PMSG_RESTORE);
 
 out_thaw:
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 58b0f04d7123..6f81708658ae 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -22,7 +22,11 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	int type;
 
 	if (parent && (len < BTRFS_FID_SIZE_CONNECTABLE)) {
-		*max_len = BTRFS_FID_SIZE_CONNECTABLE;
+		if (btrfs_root_id(BTRFS_I(inode)->root) !=
+		    btrfs_root_id(BTRFS_I(parent)->root))
+			*max_len = BTRFS_FID_SIZE_CONNECTABLE_ROOT;
+		else
+			*max_len = BTRFS_FID_SIZE_CONNECTABLE;
 		return FILEID_INVALID;
 	} else if (len < BTRFS_FID_SIZE_NON_CONNECTABLE) {
 		*max_len = BTRFS_FID_SIZE_NON_CONNECTABLE;
@@ -44,6 +48,8 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 		parent_root_id = BTRFS_I(parent)->root->root_key.objectid;
 
 		if (parent_root_id != fid->root_objectid) {
+			if (*max_len < BTRFS_FID_SIZE_CONNECTABLE_ROOT)
+				return FILEID_INVALID;
 			fid->parent_root_objectid = parent_root_id;
 			len = BTRFS_FID_SIZE_CONNECTABLE_ROOT;
 			type = FILEID_BTRFS_WITH_PARENT_ROOT;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 39619fd6d6aa..3b671e9bf684 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2000,6 +2000,13 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	/* step one, find a bunch of delalloc bytes starting at start */
 	delalloc_start = *start;
 	delalloc_end = 0;
+
+	/*
+	 * If @max_bytes is smaller than a block, btrfs_find_delalloc_range() can
+	 * return early without handling any dirty ranges.
+	 */
+	ASSERT(max_bytes >= fs_info->sectorsize);
+
 	found = btrfs_find_delalloc_range(tree, &delalloc_start, &delalloc_end,
 					  max_bytes, &cached_state);
 	if (!found || delalloc_end <= *start) {
@@ -2028,13 +2035,14 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 				  delalloc_start, delalloc_end);
 	ASSERT(!ret || ret == -EAGAIN);
 	if (ret == -EAGAIN) {
-		/* some of the pages are gone, lets avoid looping by
-		 * shortening the size of the delalloc range we're searching
+		/*
+		 * Some of the pages are gone, lets avoid looping by
+		 * shortening the size of the delalloc range we're searching.
 		 */
 		free_extent_state(cached_state);
 		cached_state = NULL;
 		if (!loops) {
-			max_bytes = PAGE_SIZE;
+			max_bytes = fs_info->sectorsize;
 			loops = 1;
 			goto again;
 		} else {
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 340f995652f2..5269923c8a7d 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -8,8 +8,6 @@
 #include <linux/math64.h>
 #include <linux/rbtree.h>
 
-#define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
-
 static inline void cond_wake_up(struct wait_queue_head *wq)
 {
 	/*
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 51e04efe3e20..8f96ddaceb9a 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -608,7 +608,7 @@ static int check_dir_item(struct extent_buffer *leaf,
 		 */
 		if (key->type == BTRFS_DIR_ITEM_KEY ||
 		    key->type == BTRFS_XATTR_ITEM_KEY) {
-			char namebuf[max(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
+			char namebuf[MAX(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
 
 			read_extent_buffer(leaf, namebuf,
 					(unsigned long)(di + 1), name_len);
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 2be65269a987..c893066e77ab 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -117,9 +117,18 @@ static struct inode *get_cramfs_inode(struct super_block *sb,
 		inode_nohighmem(inode);
 		inode->i_data.a_ops = &cramfs_aops;
 		break;
-	default:
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
 		init_special_inode(inode, cramfs_inode->mode,
 				old_decode_dev(cramfs_inode->size));
+		break;
+	default:
+		printk(KERN_DEBUG "CRAMFS: Invalid file type 0%04o for inode %lu.\n",
+		       inode->i_mode, inode->i_ino);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
 	}
 
 	inode->i_mode = cramfs_inode->mode;
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 3a008f1b9f78..43876fd8a2cb 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -182,7 +182,7 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
 }
 
 #define Z_EROFS_VMAP_ONSTACK_PAGES	\
-	min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
+	MIN_T(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
 #define Z_EROFS_VMAP_GLOBAL_PAGES	2048
 
 #endif
diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 9bf086821eb3..1d9380c5523b 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -36,8 +36,6 @@
  */
 
 
-#define in_range(b, first, len)	((b) >= (first) && (b) <= (first) + (len) - 1)
-
 struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
 					     unsigned int block_group,
 					     struct buffer_head ** bh)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ed477af15b6b..14dc0a3160fd 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1943,6 +1943,16 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
 
 #define NEXT_ORPHAN(inode) EXT4_I(inode)->i_dtime
 
+/*
+ * Check whether the inode is tracked as orphan (either in orphan file or
+ * orphan list).
+ */
+static inline bool ext4_inode_orphan_tracked(struct inode *inode)
+{
+	return ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
+		!list_empty(&EXT4_I(inode)->i_orphan);
+}
+
 /*
  * Codes for operating systems
  */
@@ -3830,8 +3840,6 @@ static inline void set_bitmap_uptodate(struct buffer_head *bh)
 	set_bit(BH_BITMAP_UPTODATE, &(bh)->b_state);
 }
 
-#define in_range(b, first, len)	((b) >= (first) && (b) <= (first) + (len) - 1)
-
 /* For ioend & aio unwritten conversion wait queues */
 #define EXT4_WQ_HASH_SZ		37
 #define ext4_ioend_wq(v)   (&ext4__ioend_wq[((unsigned long)(v)) %\
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6465fe1546d9..c025e8994d19 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -327,7 +327,7 @@ static void ext4_inode_extension_cleanup(struct inode *inode, bool need_trunc)
 	 * to cleanup the orphan list in ext4_handle_inode_extension(). Do it
 	 * now.
 	 */
-	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
+	if (ext4_inode_orphan_tracked(inode) && inode->i_nlink) {
 		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
 
 		if (IS_ERR(handle)) {
diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 1b68586f73f3..c970f41c5048 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -74,7 +74,8 @@ static int ext4_getfsmap_dev_compare(const void *p1, const void *p2)
 static bool ext4_getfsmap_rec_before_low_key(struct ext4_getfsmap_info *info,
 					     struct ext4_fsmap *rec)
 {
-	return rec->fmr_physical < info->gfi_low.fmr_physical;
+	return rec->fmr_physical + rec->fmr_length <=
+	       info->gfi_low.fmr_physical;
 }
 
 /*
@@ -200,15 +201,18 @@ static int ext4_getfsmap_meta_helper(struct super_block *sb,
 			  ext4_group_first_block_no(sb, agno));
 	fs_end = fs_start + EXT4_C2B(sbi, len);
 
-	/* Return relevant extents from the meta_list */
+	/*
+	 * Return relevant extents from the meta_list. We emit all extents that
+	 * partially/fully overlap with the query range
+	 */
 	list_for_each_entry_safe(p, tmp, &info->gfi_meta_list, fmr_list) {
-		if (p->fmr_physical < info->gfi_next_fsblk) {
+		if (p->fmr_physical + p->fmr_length <= info->gfi_next_fsblk) {
 			list_del(&p->fmr_list);
 			kfree(p);
 			continue;
 		}
-		if (p->fmr_physical <= fs_start ||
-		    p->fmr_physical + p->fmr_length <= fs_end) {
+		if (p->fmr_physical <= fs_end &&
+		    p->fmr_physical + p->fmr_length > fs_start) {
 			/* Emit the retained free extent record if present */
 			if (info->gfi_lastfree.fmr_owner) {
 				error = ext4_getfsmap_helper(sb, info,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index aefc138262f7..179ebee9d9a1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3906,7 +3906,11 @@ int ext4_can_truncate(struct inode *inode)
  * We have to make sure i_disksize gets properly updated before we truncate
  * page cache due to hole punching or zero range. Otherwise i_disksize update
  * can get lost as it may have been postponed to submission of writeback but
- * that will never happen after we truncate page cache.
+ * that will never happen if we remove the folio containing i_size from the
+ * page cache. Also if we punch hole within i_size but above i_disksize,
+ * following ext4_page_mkwrite() may mistakenly allocate written blocks over
+ * the hole and thus introduce allocated blocks beyond i_disksize which is
+ * not allowed (e2fsck would complain in case of crash).
  */
 int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 				      loff_t len)
@@ -3917,9 +3921,11 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 	loff_t size = i_size_read(inode);
 
 	WARN_ON(!inode_is_locked(inode));
-	if (offset > size || offset + len < size)
+	if (offset > size)
 		return 0;
 
+	if (offset + len < size)
+		size = offset + len;
 	if (EXT4_I(inode)->i_disksize >= size)
 		return 0;
 
@@ -5122,7 +5128,7 @@ static int ext4_do_update_inode(handle_t *handle,
 		 * old inodes get re-used with the upper 16 bits of the
 		 * uid/gid intact.
 		 */
-		if (ei->i_dtime && list_empty(&ei->i_orphan)) {
+		if (ei->i_dtime && !ext4_inode_orphan_tracked(inode)) {
 			raw_inode->i_uid_high = 0;
 			raw_inode->i_gid_high = 0;
 		} else {
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 72316515a6b0..836db28c4cd2 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -109,11 +109,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 
 	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
 		     !inode_is_locked(inode));
-	/*
-	 * Inode orphaned in orphan file or in orphan list?
-	 */
-	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
-	    !list_empty(&EXT4_I(inode)->i_orphan))
+	if (ext4_inode_orphan_tracked(inode))
 		return 0;
 
 	/*
@@ -517,7 +513,7 @@ void ext4_release_orphan_info(struct super_block *sb)
 		return;
 	for (i = 0; i < oi->of_blocks; i++)
 		brelse(oi->of_binfo[i].ob_bh);
-	kfree(oi->of_binfo);
+	kvfree(oi->of_binfo);
 }
 
 static struct ext4_orphan_block_tail *ext4_orphan_block_tail(
@@ -588,9 +584,20 @@ int ext4_init_orphan_info(struct super_block *sb)
 		ext4_msg(sb, KERN_ERR, "get orphan inode failed");
 		return PTR_ERR(inode);
 	}
+	/*
+	 * This is just an artificial limit to prevent corrupted fs from
+	 * consuming absurd amounts of memory when pinning blocks of orphan
+	 * file in memory.
+	 */
+	if (inode->i_size > 8 << 20) {
+		ext4_msg(sb, KERN_ERR, "orphan file too big: %llu",
+			 (unsigned long long)inode->i_size);
+		ret = -EFSCORRUPTED;
+		goto out_put;
+	}
 	oi->of_blocks = inode->i_size >> sb->s_blocksize_bits;
 	oi->of_csum_seed = EXT4_I(inode)->i_csum_seed;
-	oi->of_binfo = kmalloc_array(oi->of_blocks,
+	oi->of_binfo = kvmalloc_array(oi->of_blocks,
 				     sizeof(struct ext4_orphan_block),
 				     GFP_KERNEL);
 	if (!oi->of_binfo) {
@@ -631,7 +638,7 @@ int ext4_init_orphan_info(struct super_block *sb)
 out_free:
 	for (i--; i >= 0; i--)
 		brelse(oi->of_binfo[i].ob_bh);
-	kfree(oi->of_binfo);
+	kvfree(oi->of_binfo);
 out_put:
 	iput(inode);
 	return ret;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3734ed76cac5..b677b7d14bc2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1352,9 +1352,9 @@ static void ext4_free_in_core_inode(struct inode *inode)
 
 static void ext4_destroy_inode(struct inode *inode)
 {
-	if (!list_empty(&(EXT4_I(inode)->i_orphan))) {
+	if (ext4_inode_orphan_tracked(inode)) {
 		ext4_msg(inode->i_sb, KERN_ERR,
-			 "Inode %lu (%p): orphan list check failed!",
+			 "Inode %lu (%p): inode tracked as orphan!",
 			 inode->i_ino, EXT4_I(inode));
 		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 16, 4,
 				EXT4_I(inode), sizeof(struct ext4_inode_info),
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index d9f57a60f7b9..115c6ddccd7c 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -987,7 +987,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 				       int ref_change)
 {
 	struct ext4_iloc iloc;
-	s64 ref_count;
+	u64 ref_count;
 	int ret;
 
 	inode_lock_nested(ea_inode, I_MUTEX_XATTR);
@@ -997,13 +997,17 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 		goto out;
 
 	ref_count = ext4_xattr_inode_get_ref(ea_inode);
+	if ((ref_count == 0 && ref_change < 0) || (ref_count == U64_MAX && ref_change > 0)) {
+		ext4_error_inode(ea_inode, __func__, __LINE__, 0,
+			"EA inode %lu ref wraparound: ref_count=%lld ref_change=%d",
+			ea_inode->i_ino, ref_count, ref_change);
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
 	ref_count += ref_change;
 	ext4_xattr_inode_set_ref(ea_inode, ref_count);
 
 	if (ref_change > 0) {
-		WARN_ONCE(ref_count <= 0, "EA inode %lu ref_count=%lld",
-			  ea_inode->i_ino, ref_count);
-
 		if (ref_count == 1) {
 			WARN_ONCE(ea_inode->i_nlink, "EA inode %lu i_nlink=%u",
 				  ea_inode->i_ino, ea_inode->i_nlink);
@@ -1012,9 +1016,6 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 			ext4_orphan_del(handle, ea_inode);
 		}
 	} else {
-		WARN_ONCE(ref_count < 0, "EA inode %lu ref_count=%lld",
-			  ea_inode->i_ino, ref_count);
-
 		if (ref_count == 0) {
 			WARN_ONCE(ea_inode->i_nlink != 1,
 				  "EA inode %lu i_nlink=%u",
diff --git a/fs/file.c b/fs/file.c
index 8f013aaf351f..ff8ec0dbe015 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1154,7 +1154,10 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	err = expand_files(files, fd);
 	if (unlikely(err < 0))
 		goto out_unlock;
-	return do_dup2(files, file, fd, flags);
+	err = do_dup2(files, file, fd, flags);
+	if (err < 0)
+		return err;
+	return 0;
 
 out_unlock:
 	spin_unlock(&files->file_lock);
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cb3f1790a296..095eaa896cbe 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -418,22 +418,23 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	 * Transfer to @new_wb's IO list if necessary.  If the @inode is dirty,
 	 * the specific list @inode was on is ignored and the @inode is put on
 	 * ->b_dirty which is always correct including from ->b_dirty_time.
-	 * The transfer preserves @inode->dirtied_when ordering.  If the @inode
-	 * was clean, it means it was on the b_attached list, so move it onto
-	 * the b_attached list of @new_wb.
+	 * If the @inode was clean, it means it was on the b_attached list, so
+	 * move it onto the b_attached list of @new_wb.
 	 */
 	if (!list_empty(&inode->i_io_list)) {
 		inode->i_wb = new_wb;
 
 		if (inode->i_state & I_DIRTY_ALL) {
-			struct inode *pos;
-
-			list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
-				if (time_after_eq(inode->dirtied_when,
-						  pos->dirtied_when))
-					break;
+			/*
+			 * We need to keep b_dirty list sorted by
+			 * dirtied_time_when. However properly sorting the
+			 * inode in the list gets too expensive when switching
+			 * many inodes. So just attach inode at the end of the
+			 * dirty list and clobber the dirtied_time_when.
+			 */
+			inode->dirtied_time_when = jiffies;
 			inode_io_list_move_locked(inode, new_wb,
-						  pos->i_io_list.prev);
+						  &new_wb->b_dirty);
 		} else {
 			inode_cgwb_move_to_attached(inode, new_wb);
 		}
@@ -475,6 +476,7 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	 */
 	down_read(&bdi->wb_switch_rwsem);
 
+	inodep = isw->inodes;
 	/*
 	 * By the time control reaches here, RCU grace period has passed
 	 * since I_WB_SWITCH assertion and all wb stat update transactions
@@ -485,6 +487,7 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	 * gives us exclusion against all wb related operations on @inode
 	 * including IO list manipulations and stat updates.
 	 */
+relock:
 	if (old_wb < new_wb) {
 		spin_lock(&old_wb->list_lock);
 		spin_lock_nested(&new_wb->list_lock, SINGLE_DEPTH_NESTING);
@@ -493,10 +496,17 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 		spin_lock_nested(&old_wb->list_lock, SINGLE_DEPTH_NESTING);
 	}
 
-	for (inodep = isw->inodes; *inodep; inodep++) {
+	while (*inodep) {
 		WARN_ON_ONCE((*inodep)->i_wb != old_wb);
 		if (inode_do_switch_wbs(*inodep, old_wb, new_wb))
 			nr_switched++;
+		inodep++;
+		if (*inodep && need_resched()) {
+			spin_unlock(&new_wb->list_lock);
+			spin_unlock(&old_wb->list_lock);
+			cond_resched();
+			goto relock;
+		}
 	}
 
 	spin_unlock(&new_wb->list_lock);
diff --git a/fs/fsopen.c b/fs/fsopen.c
index 27a890aa493a..056466848979 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -18,50 +18,56 @@
 #include "internal.h"
 #include "mount.h"
 
+static inline const char *fetch_message_locked(struct fc_log *log, size_t len,
+					       bool *need_free)
+{
+	const char *p;
+	int index;
+
+	if (unlikely(log->head == log->tail))
+		return ERR_PTR(-ENODATA);
+
+	index = log->tail & (ARRAY_SIZE(log->buffer) - 1);
+	p = log->buffer[index];
+	if (unlikely(strlen(p) > len))
+		return ERR_PTR(-EMSGSIZE);
+
+	log->buffer[index] = NULL;
+	*need_free = log->need_free & (1 << index);
+	log->need_free &= ~(1 << index);
+	log->tail++;
+
+	return p;
+}
+
 /*
  * Allow the user to read back any error, warning or informational messages.
+ * Only one message is returned for each read(2) call.
  */
 static ssize_t fscontext_read(struct file *file,
 			      char __user *_buf, size_t len, loff_t *pos)
 {
 	struct fs_context *fc = file->private_data;
-	struct fc_log *log = fc->log.log;
-	unsigned int logsize = ARRAY_SIZE(log->buffer);
-	ssize_t ret;
-	char *p;
+	ssize_t err;
+	const char *p __free(kfree) = NULL, *message;
 	bool need_free;
-	int index, n;
+	int n;
 
-	ret = mutex_lock_interruptible(&fc->uapi_mutex);
-	if (ret < 0)
-		return ret;
-
-	if (log->head == log->tail) {
-		mutex_unlock(&fc->uapi_mutex);
-		return -ENODATA;
-	}
-
-	index = log->tail & (logsize - 1);
-	p = log->buffer[index];
-	need_free = log->need_free & (1 << index);
-	log->buffer[index] = NULL;
-	log->need_free &= ~(1 << index);
-	log->tail++;
+	err = mutex_lock_interruptible(&fc->uapi_mutex);
+	if (err < 0)
+		return err;
+	message = fetch_message_locked(fc->log.log, len, &need_free);
 	mutex_unlock(&fc->uapi_mutex);
+	if (IS_ERR(message))
+		return PTR_ERR(message);
 
-	ret = -EMSGSIZE;
-	n = strlen(p);
-	if (n > len)
-		goto err_free;
-	ret = -EFAULT;
-	if (copy_to_user(_buf, p, n) != 0)
-		goto err_free;
-	ret = n;
-
-err_free:
 	if (need_free)
-		kfree(p);
-	return ret;
+		p = message;
+
+	n = strlen(message);
+	if (copy_to_user(_buf, message, n))
+		return -EFAULT;
+	return n;
 }
 
 static int fscontext_release(struct inode *inode, struct file *file)
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 3439dbad9389..c0b5985701bf 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5204,7 +5204,8 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 
 		if (!work->tcon->posix_extensions) {
 			pr_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
-			rc = -EOPNOTSUPP;
+			path_put(&path);
+			return -EOPNOTSUPP;
 		} else {
 			info = (struct filesystem_posix_info *)(rsp->Buffer);
 			info->OptimalTransferSize = cpu_to_le32(stfs.f_bsize);
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index d4bd94234ef7..807ae40b64b0 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -470,8 +470,14 @@ void minix_set_inode(struct inode *inode, dev_t rdev)
 		inode->i_op = &minix_symlink_inode_operations;
 		inode_nohighmem(inode);
 		inode->i_mapping->a_ops = &minix_aops;
-	} else
+	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		init_special_inode(inode, inode->i_mode, rdev);
+	} else {
+		printk(KERN_DEBUG "MINIX-fs: Invalid file type 0%04o for inode %lu.\n",
+		       inode->i_mode, inode->i_ino);
+		make_bad_inode(inode);
+	}
 }
 
 /*
diff --git a/fs/namei.c b/fs/namei.c
index c188d525300d..5cc5b3e98462 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1307,6 +1307,10 @@ static int follow_automount(struct path *path, int *count, unsigned lookup_flags
 	    dentry->d_inode)
 		return -EISDIR;
 
+	/* No need to trigger automounts if mountpoint crossing is disabled. */
+	if (lookup_flags & LOOKUP_NO_XDEV)
+		return -EXDEV;
+
 	if (count && (*count)++ >= MAXSYMLINKS)
 		return -ELOOP;
 
@@ -1330,6 +1334,10 @@ static int __traverse_mounts(struct path *path, unsigned flags, bool *jumped,
 		/* Allow the filesystem to manage the transit without i_mutex
 		 * being held. */
 		if (flags & DCACHE_MANAGE_TRANSIT) {
+			if (lookup_flags & LOOKUP_NO_XDEV) {
+				ret = -EXDEV;
+				break;
+			}
 			ret = path->dentry->d_op->d_manage(path, false);
 			flags = smp_load_acquire(&path->dentry->d_flags);
 			if (ret < 0)
diff --git a/fs/namespace.c b/fs/namespace.c
index 35d63bb3b22d..ae1b8530eb93 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -64,6 +64,15 @@ static int __init set_mphash_entries(char *str)
 }
 __setup("mphash_entries=", set_mphash_entries);
 
+static char * __initdata initramfs_options;
+static int __init initramfs_options_setup(char *str)
+{
+	initramfs_options = str;
+	return 1;
+}
+
+__setup("initramfs_options=", initramfs_options_setup);
+
 static u64 event;
 static DEFINE_IDA(mnt_id_ida);
 static DEFINE_IDA(mnt_group_ida);
@@ -4352,7 +4361,7 @@ static void __init init_mount_tree(void)
 	struct mnt_namespace *ns;
 	struct path root;
 
-	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
+	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", initramfs_options);
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3d854e2537bc..a98b10c85b70 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9117,7 +9117,7 @@ static int nfs4_verify_back_channel_attrs(struct nfs41_create_session_args *args
 		goto out;
 	if (rcvd->max_rqst_sz > sent->max_rqst_sz)
 		return -EINVAL;
-	if (rcvd->max_resp_sz < sent->max_resp_sz)
+	if (rcvd->max_resp_sz > sent->max_resp_sz)
 		return -EINVAL;
 	if (rcvd->max_resp_sz_cached > sent->max_resp_sz_cached)
 		return -EINVAL;
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 46a7f9b813e5..b02886f38925 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -48,6 +48,21 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
 	switch (nfserr) {
 	case nfs_ok:
 		return 0;
+	case nfserr_jukebox:
+		/* this error can indicate a presence of a conflicting
+		 * delegation to an NLM lock request. Options are:
+		 * (1) For now, drop this request and make the client
+		 * retry. When delegation is returned, client's lock retry
+		 * will complete.
+		 * (2) NLM4_DENIED as per "spec" signals to the client
+		 * that the lock is unavailable now but client can retry.
+		 * Linux client implementation does not. It treats
+		 * NLM4_DENIED same as NLM4_FAILED and errors the request.
+		 * (3) For the future, treat this as blocked lock and try
+		 * to callback when the delegation is returned but might
+		 * not have a proper lock request to block on.
+		 */
+		fallthrough;
 	case nfserr_dropit:
 		return nlm_drop_reply;
 	case nfserr_stale:
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 21c4fc5a61b6..a976f67194e8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1335,7 +1335,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 		return 0;
 	}
 	if (work) {
-		strscpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr) - 1);
+		strscpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
 		refcount_set(&work->nsui_refcnt, 2);
 		work->nsui_busy = true;
 		list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 2c29a3b386ba..fb4d20d30838 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -1381,6 +1381,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 		mark_buffer_dirty(bh);
 		unlock_buffer(bh);
 		/* err = sync_dirty_buffer(bh); */
+		put_bh(bh);
 
 		b0 = 0;
 		bits -= op;
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 6940ee5432ba..52ce16218b29 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/fs.h>
 #include <linux/log2.h>
+#include <linux/overflow.h>
 
 #include "debug.h"
 #include "ntfs.h"
@@ -935,12 +936,16 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 
 			if (!dlcn)
 				return -EINVAL;
-			lcn = prev_lcn + dlcn;
+
+			if (check_add_overflow(prev_lcn, dlcn, &lcn))
+				return -EINVAL;
 			prev_lcn = lcn;
 		} else
 			return -EINVAL;
 
-		next_vcn = vcn64 + len;
+		if (check_add_overflow(vcn64, len, &next_vcn))
+			return -EINVAL;
+
 		/* Check boundary. */
 		if (next_vcn > evcn + 1)
 			return -EINVAL;
@@ -1101,7 +1106,8 @@ int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn)
 			return -EINVAL;
 
 		run_buf += size_size + offset_size;
-		vcn64 += len;
+		if (check_add_overflow(vcn64, len, &vcn64))
+			return -EINVAL;
 
 #ifndef CONFIG_NTFS3_64BIT_CLUSTER
 		if (vcn64 > 0x100000000ull)
diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index 85a47621e0c0..f9ecabe3c09e 100644
--- a/fs/ocfs2/stack_user.c
+++ b/fs/ocfs2/stack_user.c
@@ -1030,6 +1030,7 @@ static int user_cluster_connect(struct ocfs2_cluster_connection *conn)
 			printk(KERN_ERR "ocfs2: Could not determine"
 					" locking version\n");
 			user_cluster_disconnect(conn);
+			lc = NULL;
 			goto out;
 		}
 		wait_event(lc->oc_wait, (atomic_read(&lc->oc_this_node) > 0));
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 95a9ff9e2399..42c97c68db63 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -140,8 +140,17 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		if (err < 0)
 			goto failed_read;
 
+		inode->i_size = le32_to_cpu(sqsh_ino->file_size);
 		frag = le32_to_cpu(sqsh_ino->fragment);
 		if (frag != SQUASHFS_INVALID_FRAG) {
+			/*
+			 * the file cannot have a fragment (tailend) and have a
+			 * file size a multiple of the block size
+			 */
+			if ((inode->i_size & (msblk->block_size - 1)) == 0) {
+				err = -EINVAL;
+				goto failed_read;
+			}
 			frag_offset = le32_to_cpu(sqsh_ino->offset);
 			frag_size = squashfs_frag_lookup(sb, frag, &frag_blk);
 			if (frag_size < 0) {
@@ -155,7 +164,6 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		}
 
 		set_nlink(inode, 1);
-		inode->i_size = le32_to_cpu(sqsh_ino->file_size);
 		inode->i_fop = &generic_ro_fops;
 		inode->i_mode |= S_IFREG;
 		inode->i_blocks = ((inode->i_size - 1) >> 9) + 1;
@@ -165,6 +173,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		squashfs_i(inode)->start = le32_to_cpu(sqsh_ino->start_block);
 		squashfs_i(inode)->block_list_start = block;
 		squashfs_i(inode)->offset = offset;
+		squashfs_i(inode)->parent = 0;
 		inode->i_data.a_ops = &squashfs_aops;
 
 		TRACE("File inode %x:%x, start_block %llx, block_list_start "
@@ -183,8 +192,21 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		if (err < 0)
 			goto failed_read;
 
+		inode->i_size = le64_to_cpu(sqsh_ino->file_size);
+		if (inode->i_size < 0) {
+			err = -EINVAL;
+			goto failed_read;
+		}
 		frag = le32_to_cpu(sqsh_ino->fragment);
 		if (frag != SQUASHFS_INVALID_FRAG) {
+			/*
+			 * the file cannot have a fragment (tailend) and have a
+			 * file size a multiple of the block size
+			 */
+			if ((inode->i_size & (msblk->block_size - 1)) == 0) {
+				err = -EINVAL;
+				goto failed_read;
+			}
 			frag_offset = le32_to_cpu(sqsh_ino->offset);
 			frag_size = squashfs_frag_lookup(sb, frag, &frag_blk);
 			if (frag_size < 0) {
@@ -199,7 +221,6 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 
 		xattr_id = le32_to_cpu(sqsh_ino->xattr);
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
-		inode->i_size = le64_to_cpu(sqsh_ino->file_size);
 		inode->i_op = &squashfs_inode_ops;
 		inode->i_fop = &generic_ro_fops;
 		inode->i_mode |= S_IFREG;
@@ -212,6 +233,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		squashfs_i(inode)->start = le64_to_cpu(sqsh_ino->start_block);
 		squashfs_i(inode)->block_list_start = block;
 		squashfs_i(inode)->offset = offset;
+		squashfs_i(inode)->parent = 0;
 		inode->i_data.a_ops = &squashfs_aops;
 
 		TRACE("File inode %x:%x, start_block %llx, block_list_start "
@@ -292,6 +314,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		inode->i_mode |= S_IFLNK;
 		squashfs_i(inode)->start = block;
 		squashfs_i(inode)->offset = offset;
+		squashfs_i(inode)->parent = 0;
 
 		if (type == SQUASHFS_LSYMLINK_TYPE) {
 			__le32 xattr;
@@ -329,6 +352,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		rdev = le32_to_cpu(sqsh_ino->rdev);
 		init_special_inode(inode, inode->i_mode, new_decode_dev(rdev));
+		squashfs_i(inode)->parent = 0;
 
 		TRACE("Device inode %x:%x, rdev %x\n",
 				SQUASHFS_INODE_BLK(ino), offset, rdev);
@@ -353,6 +377,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		rdev = le32_to_cpu(sqsh_ino->rdev);
 		init_special_inode(inode, inode->i_mode, new_decode_dev(rdev));
+		squashfs_i(inode)->parent = 0;
 
 		TRACE("Device inode %x:%x, rdev %x\n",
 				SQUASHFS_INODE_BLK(ino), offset, rdev);
@@ -373,6 +398,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 			inode->i_mode |= S_IFSOCK;
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		init_special_inode(inode, inode->i_mode, 0);
+		squashfs_i(inode)->parent = 0;
 		break;
 	}
 	case SQUASHFS_LFIFO_TYPE:
@@ -392,6 +418,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		inode->i_op = &squashfs_inode_ops;
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		init_special_inode(inode, inode->i_mode, 0);
+		squashfs_i(inode)->parent = 0;
 		break;
 	}
 	default:
diff --git a/fs/squashfs/squashfs_fs_i.h b/fs/squashfs/squashfs_fs_i.h
index 2c82d6f2a456..8e497ac07b9a 100644
--- a/fs/squashfs/squashfs_fs_i.h
+++ b/fs/squashfs/squashfs_fs_i.h
@@ -16,6 +16,7 @@ struct squashfs_inode_info {
 	u64		xattr;
 	unsigned int	xattr_size;
 	int		xattr_count;
+	int		parent;
 	union {
 		struct {
 			u64		fragment_block;
@@ -27,7 +28,6 @@ struct squashfs_inode_info {
 			u64		dir_idx_start;
 			int		dir_idx_offset;
 			int		dir_idx_cnt;
-			int		parent;
 		};
 	};
 	struct inode	vfs_inode;
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4983abca7397..d36e6a56c34a 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -2109,6 +2109,9 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 		if (check_add_overflow(sizeof(struct allocExtDesc),
 				le32_to_cpu(header->lengthAllocDescs), &alen))
 			return -1;
+
+		if (alen > epos->bh->b_size)
+			return -1;
 	}
 
 	switch (iinfo->i_alloc_type) {
diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 4931bec1a01c..89247193d96d 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -11,12 +11,6 @@
 #include <linux/fs.h>
 #include "swab.h"
 
-
-/*
- * some useful macros
- */
-#define in_range(b,first,len)	((b)>=(first)&&(b)<(first)+(len))
-
 /*
  * functions used for retyping
  */
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
new file mode 100644
index 000000000000..53f1a7a932b0
--- /dev/null
+++ b/include/linux/cleanup.h
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_GUARDS_H
+#define __LINUX_GUARDS_H
+
+#include <linux/compiler.h>
+
+/*
+ * DEFINE_FREE(name, type, free):
+ *	simple helper macro that defines the required wrapper for a __free()
+ *	based cleanup function. @free is an expression using '_T' to access
+ *	the variable.
+ *
+ * __free(name):
+ *	variable attribute to add a scoped based cleanup to the variable.
+ *
+ * no_free_ptr(var):
+ *	like a non-atomic xchg(var, NULL), such that the cleanup function will
+ *	be inhibited -- provided it sanely deals with a NULL value.
+ *
+ * return_ptr(p):
+ *	returns p while inhibiting the __free().
+ *
+ * Ex.
+ *
+ * DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
+ *
+ *	struct obj *p __free(kfree) = kmalloc(...);
+ *	if (!p)
+ *		return NULL;
+ *
+ *	if (!init_obj(p))
+ *		return NULL;
+ *
+ *	return_ptr(p);
+ */
+
+#define DEFINE_FREE(_name, _type, _free) \
+	static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
+
+#define __free(_name)	__cleanup(__free_##_name)
+
+#define no_free_ptr(p) \
+	({ __auto_type __ptr = (p); (p) = NULL; __ptr; })
+
+#define return_ptr(p)	return no_free_ptr(p)
+
+
+/*
+ * DEFINE_CLASS(name, type, exit, init, init_args...):
+ *	helper to define the destructor and constructor for a type.
+ *	@exit is an expression using '_T' -- similar to FREE above.
+ *	@init is an expression in @init_args resulting in @type
+ *
+ * EXTEND_CLASS(name, ext, init, init_args...):
+ *	extends class @name to @name@ext with the new constructor
+ *
+ * CLASS(name, var)(args...):
+ *	declare the variable @var as an instance of the named class
+ *
+ * Ex.
+ *
+ * DEFINE_CLASS(fdget, struct fd, fdput(_T), fdget(fd), int fd)
+ *
+ *	CLASS(fdget, f)(fd);
+ *	if (!f.file)
+ *		return -EBADF;
+ *
+ *	// use 'f' without concern
+ */
+
+#define DEFINE_CLASS(_name, _type, _exit, _init, _init_args...)		\
+typedef _type class_##_name##_t;					\
+static inline void class_##_name##_destructor(_type *p)			\
+{ _type _T = *p; _exit; }						\
+static inline _type class_##_name##_constructor(_init_args)		\
+{ _type t = _init; return t; }
+
+#define EXTEND_CLASS(_name, ext, _init, _init_args...)			\
+typedef class_##_name##_t class_##_name##ext##_t;			\
+static inline void class_##_name##ext##_destructor(class_##_name##_t *p)\
+{ class_##_name##_destructor(p); }					\
+static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
+{ class_##_name##_t t = _init; return t; }
+
+#define CLASS(_name, var)						\
+	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
+		class_##_name##_constructor
+
+
+/*
+ * DEFINE_GUARD(name, type, lock, unlock):
+ *	trivial wrapper around DEFINE_CLASS() above specifically
+ *	for locks.
+ *
+ * guard(name):
+ *	an anonymous instance of the (guard) class
+ *
+ * scoped_guard (name, args...) { }:
+ *	similar to CLASS(name, scope)(args), except the variable (with the
+ *	explicit name 'scope') is declard in a for-loop such that its scope is
+ *	bound to the next (compound) statement.
+ *
+ */
+
+#define DEFINE_GUARD(_name, _type, _lock, _unlock) \
+	DEFINE_CLASS(_name, _type, _unlock, ({ _lock; _T; }), _type _T)
+
+#define guard(_name) \
+	CLASS(_name, __UNIQUE_ID(guard))
+
+#define scoped_guard(_name, args...)					\
+	for (CLASS(_name, scope)(args),					\
+	     *done = NULL; !done; done = (void *)1)
+
+/*
+ * Additional helper macros for generating lock guards with types, either for
+ * locks that don't have a native type (eg. RCU, preempt) or those that need a
+ * 'fat' pointer (eg. spin_lock_irqsave).
+ *
+ * DEFINE_LOCK_GUARD_0(name, lock, unlock, ...)
+ * DEFINE_LOCK_GUARD_1(name, type, lock, unlock, ...)
+ *
+ * will result in the following type:
+ *
+ *   typedef struct {
+ *	type *lock;		// 'type := void' for the _0 variant
+ *	__VA_ARGS__;
+ *   } class_##name##_t;
+ *
+ * As above, both _lock and _unlock are statements, except this time '_T' will
+ * be a pointer to the above struct.
+ */
+
+#define __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, ...)		\
+typedef struct {							\
+	_type *lock;							\
+	__VA_ARGS__;							\
+} class_##_name##_t;							\
+									\
+static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
+{									\
+	if (_T->lock) { _unlock; }					\
+}
+
+
+#define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
+static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
+{									\
+	class_##_name##_t _t = { .lock = l }, *_T = &_t;		\
+	_lock;								\
+	return _t;							\
+}
+
+#define __DEFINE_LOCK_GUARD_0(_name, _lock)				\
+static inline class_##_name##_t class_##_name##_constructor(void)	\
+{									\
+	class_##_name##_t _t = { .lock = (void*)1 },			\
+			 *_T __maybe_unused = &_t;			\
+	_lock;								\
+	return _t;							\
+}
+
+#define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
+__DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)		\
+__DEFINE_LOCK_GUARD_1(_name, _type, _lock)
+
+#define DEFINE_LOCK_GUARD_0(_name, _lock, _unlock, ...)			\
+__DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
+__DEFINE_LOCK_GUARD_0(_name, _lock)
+
+#endif /* __LINUX_GUARDS_H */
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index cc3b972f8a27..29be8ad71549 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -5,6 +5,15 @@
 
 /* Compiler specific definitions for Clang compiler */
 
+/*
+ * Clang prior to 17 is being silly and considers many __cleanup() variables
+ * as unused (because they are, their sole purpose is to go out of scope).
+ *
+ * https://reviews.llvm.org/D152180
+ */
+#undef __cleanup
+#define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
+
 /* same as gcc, this was present in clang-2.6 so we can assume it works
  * with any version that can compile the kernel
  */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 4f03dfb6de0d..ee9e39d315c8 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -258,6 +258,15 @@ static inline void *offset_to_ptr(const int *off)
  */
 #define is_signed_type(type) (((type)(-1)) < (__force type)1)
 
+/*
+ * Useful shorthand for "is this condition known at compile-time?"
+ *
+ * Note that the condition may involve non-constant values,
+ * but the compiler may know enough about the details of the
+ * values to determine that the condition is statically true.
+ */
+#define statically_true(x) (__builtin_constant_p(x) && (x))
+
 /*
  * This is needed in functions which generate the stack canary, see
  * arch/x86/kernel/smpboot.c::start_secondary() for an example.
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 932b8fd6f36f..5ee9e2aeab63 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -80,6 +80,12 @@
  */
 #define __cold                          __attribute__((__cold__))
 
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-cleanup-variable-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#cleanup
+ */
+#define __cleanup(func)			__attribute__((__cleanup__(func)))
+
 /*
  * Note the long name.
  *
diff --git a/include/linux/device.h b/include/linux/device.h
index 440c9f1a3f35..89864b918546 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -30,6 +30,7 @@
 #include <linux/device/bus.h>
 #include <linux/device/class.h>
 #include <linux/device/driver.h>
+#include <linux/cleanup.h>
 #include <asm/device.h>
 
 struct device;
@@ -736,6 +737,9 @@ static inline bool device_pm_not_required(struct device *dev)
 static inline void device_set_pm_not_required(struct device *dev)
 {
 	dev->power.no_pm = true;
+#ifdef CONFIG_PM
+	dev->power.no_callbacks = true;
+#endif
 }
 
 static inline void dev_pm_syscore_device(struct device *dev, bool val)
@@ -822,6 +826,9 @@ void device_unregister(struct device *dev);
 void device_initialize(struct device *dev);
 int __must_check device_add(struct device *dev);
 void device_del(struct device *dev);
+
+DEFINE_FREE(device_del, struct device *, if (_T) device_del(_T))
+
 int device_for_each_child(struct device *dev, void *data,
 			  int (*fn)(struct device *dev, void *data));
 int device_for_each_child_reverse(struct device *dev, void *data,
@@ -952,6 +959,9 @@ extern int (*platform_notify_remove)(struct device *dev);
  */
 struct device *get_device(struct device *dev);
 void put_device(struct device *dev);
+
+DEFINE_FREE(put_device, struct device *, if (_T) put_device(_T))
+
 bool kill_device(struct device *dev);
 
 #ifdef CONFIG_DEVTMPFS
diff --git a/include/linux/file.h b/include/linux/file.h
index 51e830b4fe3a..6726240b9279 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/posix_types.h>
 #include <linux/errno.h>
+#include <linux/cleanup.h>
 
 struct file;
 
@@ -82,6 +83,8 @@ static inline void fdput_pos(struct fd f)
 	fdput(f);
 }
 
+DEFINE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)
+
 extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
 extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
 extern void set_close_on_exec(unsigned int fd, int flag);
@@ -90,6 +93,9 @@ extern int __get_unused_fd_flags(unsigned flags, unsigned long nofile);
 extern int get_unused_fd_flags(unsigned flags);
 extern void put_unused_fd(unsigned int fd);
 
+DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
+	     get_unused_fd_flags(flags), unsigned flags)
+
 extern void fd_install(unsigned int fd, struct file *file);
 
 extern int __receive_fd(struct file *file, int __user *ufd,
diff --git a/include/linux/iio/frequency/adf4350.h b/include/linux/iio/frequency/adf4350.h
index de45cf2ee1e4..ce2086f97e3f 100644
--- a/include/linux/iio/frequency/adf4350.h
+++ b/include/linux/iio/frequency/adf4350.h
@@ -51,7 +51,7 @@
 
 /* REG3 Bit Definitions */
 #define ADF4350_REG3_12BIT_CLKDIV(x)		((x) << 3)
-#define ADF4350_REG3_12BIT_CLKDIV_MODE(x)	((x) << 16)
+#define ADF4350_REG3_12BIT_CLKDIV_MODE(x)	((x) << 15)
 #define ADF4350_REG3_12BIT_CSR_EN		(1 << 18)
 #define ADF4351_REG3_CHARGE_CANCELLATION_EN	(1 << 21)
 #define ADF4351_REG3_ANTI_BACKLASH_3ns_EN	(1 << 22)
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 37738ec87de3..c4288c7ae613 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -13,6 +13,7 @@
 #define _LINUX_TRACE_IRQFLAGS_H
 
 #include <linux/typecheck.h>
+#include <linux/cleanup.h>
 #include <asm/irqflags.h>
 #include <asm/percpu.h>
 
@@ -260,4 +261,10 @@ extern void warn_bogus_irq_restore(void);
 
 #define irqs_disabled_flags(flags) raw_irqs_disabled_flags(flags)
 
+DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
+DEFINE_LOCK_GUARD_0(irqsave,
+		    local_irq_save(_T->flags),
+		    local_irq_restore(_T->flags),
+		    unsigned long flags)
+
 #endif
diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index dd52969698f7..eaaf5c008e4d 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -5,15 +5,13 @@
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
 #include <linux/const.h>
+#include <linux/types.h>
 
 /*
- * min()/max()/clamp() macros must accomplish three things:
+ * min()/max()/clamp() macros must accomplish several things:
  *
  * - Avoid multiple evaluations of the arguments (so side-effects like
  *   "x++" happen only once) when non-constant.
- * - Retain result as a constant expressions when called with only
- *   constant expressions (to avoid tripping VLA warnings in stack
- *   allocation usage).
  * - Perform signed v unsigned type-checking (to generate compile
  *   errors instead of nasty runtime surprises).
  * - Unsigned char/short are always promoted to signed int and can be
@@ -25,56 +23,79 @@
 #define __typecheck(x, y) \
 	(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
 
-/* is_signed_type() isn't a constexpr for pointer types */
-#define __is_signed(x) 								\
-	__builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),	\
-		is_signed_type(typeof(x)), 0)
+/*
+ * __sign_use for integer expressions:
+ *   bit #0 set if ok for unsigned comparisons
+ *   bit #1 set if ok for signed comparisons
+ *
+ * In particular, statically non-negative signed integer expressions
+ * are ok for both.
+ *
+ * NOTE! Unsigned types smaller than 'int' are implicitly converted to 'int'
+ * in expressions, and are accepted for signed conversions for now.
+ * This is debatable.
+ *
+ * Note that 'x' is the original expression, and 'ux' is the unique variable
+ * that contains the value.
+ *
+ * We use 'ux' for pure type checking, and 'x' for when we need to look at the
+ * value (but without evaluating it for side effects!
+ * Careful to only ever evaluate it with sizeof() or __builtin_constant_p() etc).
+ *
+ * Pointers end up being checked by the normal C type rules at the actual
+ * comparison, and these expressions only need to be careful to not cause
+ * warnings for pointer use.
+ */
+#define __sign_use(ux) (is_signed_type(typeof(ux)) ? \
+	(2 + __is_nonneg(ux)) : (1 + 2 * (sizeof(ux) < 4)))
 
-/* True for a non-negative signed int constant */
-#define __is_noneg_int(x)	\
-	(__builtin_choose_expr(__is_constexpr(x) && __is_signed(x), x, -1) >= 0)
+/*
+ * Check whether a signed value is always non-negative.
+ *
+ * A cast is needed to avoid any warnings from values that aren't signed
+ * integer types (in which case the result doesn't matter).
+ *
+ * On 64-bit any integer or pointer type can safely be cast to 'long long'.
+ * But on 32-bit we need to avoid warnings about casting pointers to integers
+ * of different sizes without truncating 64-bit values so 'long' or 'long long'
+ * must be used depending on the size of the value.
+ *
+ * This does not work for 128-bit signed integers since the cast would truncate
+ * them, but we do not use s128 types in the kernel (we do use 'u128',
+ * but they are handled by the !is_signed_type() case).
+ */
+#if __SIZEOF_POINTER__ == __SIZEOF_LONG_LONG__
+#define __is_nonneg(ux) statically_true((long long)(ux) >= 0)
+#else
+#define __is_nonneg(ux) statically_true( \
+	(typeof(__builtin_choose_expr(sizeof(ux) > 4, 1LL, 1L)))(ux) >= 0)
+#endif
+
+#define __types_ok(ux, uy) \
+	(__sign_use(ux) & __sign_use(uy))
 
-#define __types_ok(x, y) 					\
-	(__is_signed(x) == __is_signed(y) ||			\
-		__is_signed((x) + 0) == __is_signed((y) + 0) ||	\
-		__is_noneg_int(x) || __is_noneg_int(y))
+#define __types_ok3(ux, uy, uz) \
+	(__sign_use(ux) & __sign_use(uy) & __sign_use(uz))
 
 #define __cmp_op_min <
 #define __cmp_op_max >
 
 #define __cmp(op, x, y)	((x) __cmp_op_##op (y) ? (x) : (y))
 
-#define __cmp_once(op, x, y, unique_x, unique_y) ({	\
-		typeof(x) unique_x = (x);		\
-		typeof(y) unique_y = (y);		\
-		static_assert(__types_ok(x, y),		\
-			#op "(" #x ", " #y ") signedness error, fix types or consider u" #op "() before " #op "_t()"); \
-		__cmp(op, unique_x, unique_y); })
+#define __cmp_once_unique(op, type, x, y, ux, uy) \
+	({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
 
-#define __careful_cmp(op, x, y)					\
-	__builtin_choose_expr(__is_constexpr((x) - (y)),	\
-		__cmp(op, x, y),				\
-		__cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
+#define __cmp_once(op, type, x, y) \
+	__cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
 
-#define __clamp(val, lo, hi)	\
-	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
+#define __careful_cmp_once(op, x, y, ux, uy) ({		\
+	__auto_type ux = (x); __auto_type uy = (y);	\
+	BUILD_BUG_ON_MSG(!__types_ok(ux, uy),		\
+		#op"("#x", "#y") signedness error");	\
+	__cmp(op, ux, uy); })
 
-#define __clamp_once(val, lo, hi, unique_val, unique_lo, unique_hi) ({	\
-		typeof(val) unique_val = (val);				\
-		typeof(lo) unique_lo = (lo);				\
-		typeof(hi) unique_hi = (hi);				\
-		static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)), 	\
-				(lo) <= (hi), true),					\
-			"clamp() low limit " #lo " greater than high limit " #hi);	\
-		static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");	\
-		static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");	\
-		__clamp(unique_val, unique_lo, unique_hi); })
-
-#define __careful_clamp(val, lo, hi) ({					\
-	__builtin_choose_expr(__is_constexpr((val) - (lo) + (hi)),	\
-		__clamp(val, lo, hi),					\
-		__clamp_once(val, lo, hi, __UNIQUE_ID(__val),		\
-			     __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })
+#define __careful_cmp(op, x, y) \
+	__careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
 
 /**
  * min - return minimum of two values of the same or compatible types
@@ -107,13 +128,20 @@
 #define umax(x, y)	\
 	__careful_cmp(max, (x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull)
 
+#define __careful_op3(op, x, y, z, ux, uy, uz) ({			\
+	__auto_type ux = (x); __auto_type uy = (y);__auto_type uz = (z);\
+	BUILD_BUG_ON_MSG(!__types_ok3(ux, uy, uz),			\
+		#op"3("#x", "#y", "#z") signedness error");		\
+	__cmp(op, ux, __cmp(op, uy, uz)); })
+
 /**
  * min3 - return minimum of three values
  * @x: first value
  * @y: second value
  * @z: third value
  */
-#define min3(x, y, z) min((typeof(x))min(x, y), z)
+#define min3(x, y, z) \
+	__careful_op3(min, x, y, z, __UNIQUE_ID(x_), __UNIQUE_ID(y_), __UNIQUE_ID(z_))
 
 /**
  * max3 - return maximum of three values
@@ -121,7 +149,24 @@
  * @y: second value
  * @z: third value
  */
-#define max3(x, y, z) max((typeof(x))max(x, y), z)
+#define max3(x, y, z) \
+	__careful_op3(max, x, y, z, __UNIQUE_ID(x_), __UNIQUE_ID(y_), __UNIQUE_ID(z_))
+
+/**
+ * min_t - return minimum of two values, using the specified type
+ * @type: data type to use
+ * @x: first value
+ * @y: second value
+ */
+#define min_t(type, x, y) __cmp_once(min, type, x, y)
+
+/**
+ * max_t - return maximum of two values, using the specified type
+ * @type: data type to use
+ * @x: first value
+ * @y: second value
+ */
+#define max_t(type, x, y) __cmp_once(max, type, x, y)
 
 /**
  * min_not_zero - return the minimum that is _not_ zero, unless both are zero
@@ -133,39 +178,32 @@
 	typeof(y) __y = (y);			\
 	__x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
 
+#define __clamp(val, lo, hi)	\
+	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
+
+#define __clamp_once(type, val, lo, hi, uval, ulo, uhi) ({			\
+	type uval = (val);							\
+	type ulo = (lo);							\
+	type uhi = (hi);							\
+	BUILD_BUG_ON_MSG(statically_true(ulo > uhi),				\
+		"clamp() low limit " #lo " greater than high limit " #hi);	\
+	BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),				\
+		"clamp("#val", "#lo", "#hi") signedness error");		\
+	__clamp(uval, ulo, uhi); })
+
+#define __careful_clamp(type, val, lo, hi) \
+	__clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
+
 /**
- * clamp - return a value clamped to a given range with strict typechecking
+ * clamp - return a value clamped to a given range with typechecking
  * @val: current value
  * @lo: lowest allowable value
  * @hi: highest allowable value
  *
- * This macro does strict typechecking of @lo/@hi to make sure they are of the
- * same type as @val.  See the unnecessary pointer comparisons.
- */
-#define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
-
-/*
- * ..and if you can't take the strict
- * types, you can specify one yourself.
- *
- * Or not use min/max/clamp at all, of course.
- */
-
-/**
- * min_t - return minimum of two values, using the specified type
- * @type: data type to use
- * @x: first value
- * @y: second value
+ * This macro checks @val/@lo/@hi to make sure they have compatible
+ * signedness.
  */
-#define min_t(type, x, y)	__careful_cmp(min, (type)(x), (type)(y))
-
-/**
- * max_t - return maximum of two values, using the specified type
- * @type: data type to use
- * @x: first value
- * @y: second value
- */
-#define max_t(type, x, y)	__careful_cmp(max, (type)(x), (type)(y))
+#define clamp(val, lo, hi) __careful_clamp(__auto_type, val, lo, hi)
 
 /**
  * clamp_t - return a value clamped to a given range using a given type
@@ -177,7 +215,7 @@
  * This macro does no typechecking and uses temporary variables of type
  * @type to make all the comparisons.
  */
-#define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
+#define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
 
 /**
  * clamp_val - return a value clamped to a given range using val's type
@@ -190,7 +228,76 @@
  * type and @lo and @hi are literals that will otherwise be assigned a signed
  * integer type.
  */
-#define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
+#define clamp_val(val, lo, hi) __careful_clamp(typeof(val), val, lo, hi)
+
+/*
+ * Do not check the array parameter using __must_be_array().
+ * In the following legit use-case where the "array" passed is a simple pointer,
+ * __must_be_array() will return a failure.
+ * --- 8< ---
+ * int *buff
+ * ...
+ * min = min_array(buff, nb_items);
+ * --- 8< ---
+ *
+ * The first typeof(&(array)[0]) is needed in order to support arrays of both
+ * 'int *buff' and 'int buff[N]' types.
+ *
+ * The array can be an array of const items.
+ * typeof() keeps the const qualifier. Use __unqual_scalar_typeof() in order
+ * to discard the const qualifier for the __element variable.
+ */
+#define __minmax_array(op, array, len) ({				\
+	typeof(&(array)[0]) __array = (array);				\
+	typeof(len) __len = (len);					\
+	__unqual_scalar_typeof(__array[0]) __element = __array[--__len];\
+	while (__len--)							\
+		__element = op(__element, __array[__len]);		\
+	__element; })
+
+/**
+ * min_array - return minimum of values present in an array
+ * @array: array
+ * @len: array length
+ *
+ * Note that @len must not be zero (empty array).
+ */
+#define min_array(array, len) __minmax_array(min, array, len)
+
+/**
+ * max_array - return maximum of values present in an array
+ * @array: array
+ * @len: array length
+ *
+ * Note that @len must not be zero (empty array).
+ */
+#define max_array(array, len) __minmax_array(max, array, len)
+
+static inline bool in_range64(u64 val, u64 start, u64 len)
+{
+	return (val - start) < len;
+}
+
+static inline bool in_range32(u32 val, u32 start, u32 len)
+{
+	return (val - start) < len;
+}
+
+/**
+ * in_range - Determine if a value lies within a range.
+ * @val: Value to test.
+ * @start: First value in range.
+ * @len: Number of values in range.
+ *
+ * This is more efficient than "if (start <= val && val < (start + len))".
+ * It also gives a different answer if @start + @len overflows the size of
+ * the type by a sufficient amount to encompass @val.  Decide for yourself
+ * which behaviour you want, or prove that start + len never overflow.
+ * Do not blindly replace one form with the other.
+ */
+#define in_range(val, start, len)					\
+	((sizeof(start) | sizeof(len) | sizeof(val)) <= sizeof(u32) ?	\
+		in_range32(val, start, len) : in_range64(val, start, len))
 
 /**
  * swap - swap values of @a and @b
@@ -200,4 +307,13 @@
 #define swap(a, b) \
 	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
 
+/*
+ * Use these carefully: no type checking, and uses the arguments
+ * multiple times. Use for obvious constants only.
+ */
+#define MIN(a, b) __cmp(min, a, b)
+#define MAX(a, b) __cmp(max, a, b)
+#define MIN_T(type, a, b) __cmp(min, (type)(a), (type)(b))
+#define MAX_T(type, a, b) __cmp(max, (type)(a), (type)(b))
+
 #endif	/* _LINUX_MINMAX_H */
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 9ef01b9d2456..5b5630e58407 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -19,6 +19,7 @@
 #include <asm/processor.h>
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
+#include <linux/cleanup.h>
 
 struct device;
 
@@ -246,4 +247,7 @@ extern void mutex_unlock(struct mutex *lock);
 
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
+DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
+DEFINE_FREE(mutex, struct mutex *, if (_T) mutex_unlock(_T))
+
 #endif /* __LINUX_MUTEX_H */
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 5e76af742c80..c9a84532bb79 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -9,6 +9,7 @@
 #include <linux/printk.h>
 #include <linux/pfn.h>
 #include <linux/init.h>
+#include <linux/cleanup.h>
 
 #include <asm/percpu.h>
 
@@ -134,6 +135,9 @@ extern void __init setup_per_cpu_areas(void);
 extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp);
 extern void __percpu *__alloc_percpu(size_t size, size_t align);
 extern void free_percpu(void __percpu *__pdata);
+
+DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
+
 extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
 
 #define alloc_percpu_gfp(type, gfp)					\
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 9c4534a69a8f..436f030a93f3 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cleanup.h>
 #include <linux/list.h>
 
 /*
@@ -431,4 +432,50 @@ static inline void migrate_enable(void) { }
 
 #endif /* CONFIG_SMP */
 
+/**
+ * preempt_disable_nested - Disable preemption inside a normally preempt disabled section
+ *
+ * Use for code which requires preemption protection inside a critical
+ * section which has preemption disabled implicitly on non-PREEMPT_RT
+ * enabled kernels, by e.g.:
+ *  - holding a spinlock/rwlock
+ *  - soft interrupt context
+ *  - regular interrupt handlers
+ *
+ * On PREEMPT_RT enabled kernels spinlock/rwlock held sections, soft
+ * interrupt context and regular interrupt handlers are preemptible and
+ * only prevent migration. preempt_disable_nested() ensures that preemption
+ * is disabled for cases which require CPU local serialization even on
+ * PREEMPT_RT. For non-PREEMPT_RT kernels this is a NOP.
+ *
+ * The use cases are code sequences which are not serialized by a
+ * particular lock instance, e.g.:
+ *  - seqcount write side critical sections where the seqcount is not
+ *    associated to a particular lock and therefore the automatic
+ *    protection mechanism does not work. This prevents a live lock
+ *    against a preempting high priority reader.
+ *  - RMW per CPU variable updates like vmstat.
+ */
+/* Macro to avoid header recursion hell vs. lockdep */
+#define preempt_disable_nested()				\
+do {								\
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))			\
+		preempt_disable();				\
+	else							\
+		lockdep_assert_preemption_disabled();		\
+} while (0)
+
+/**
+ * preempt_enable_nested - Undo the effect of preempt_disable_nested()
+ */
+static __always_inline void preempt_enable_nested(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+}
+
+DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
+DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(), preempt_enable_notrace())
+DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
+
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 978769e545b5..552216218d73 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -27,6 +27,7 @@
 #include <linux/preempt.h>
 #include <linux/bottom_half.h>
 #include <linux/lockdep.h>
+#include <linux/cleanup.h>
 #include <asm/processor.h>
 #include <linux/cpumask.h>
 
@@ -1060,4 +1061,6 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 extern int rcu_expedited;
 extern int rcu_normal;
 
+DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
+
 #endif /* __LINUX_RCUPDATE_H */
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 352c6127cb90..458a0c92cc68 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -16,6 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/err.h>
+#include <linux/cleanup.h>
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __RWSEM_DEP_MAP_INIT(lockname)			\
@@ -202,6 +203,13 @@ extern void up_read(struct rw_semaphore *sem);
  */
 extern void up_write(struct rw_semaphore *sem);
 
+DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
+DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
+
+DEFINE_FREE(up_read, struct rw_semaphore *, if (_T) up_read(_T))
+DEFINE_FREE(up_write, struct rw_semaphore *, if (_T) up_write(_T))
+
+
 /*
  * downgrade write lock to read lock
  */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index f254a7d851fe..ff5aaed60969 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -142,6 +142,8 @@ static inline void put_task_struct(struct task_struct *t)
 		__put_task_struct(t);
 }
 
+DEFINE_FREE(put_task, struct task_struct *, if (_T) put_task_struct(_T))
+
 static inline void put_task_struct_many(struct task_struct *t, int nr)
 {
 	if (refcount_sub_and_test(nr, &t->usage))
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 3482c2ced139..c13f785c62da 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <linux/percpu-refcount.h>
+#include <linux/cleanup.h>
 
 
 /*
@@ -186,6 +187,8 @@ void kfree(const void *objp);
 void kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
 
+DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
+
 /**
  * ksize - Report actual allocation size of associated object
  *
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 45310ea1b1d7..6c02b2c3974f 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -61,6 +61,7 @@
 #include <linux/stringify.h>
 #include <linux/bottom_half.h>
 #include <linux/lockdep.h>
+#include <linux/cleanup.h>
 #include <asm/barrier.h>
 #include <asm/mmiowb.h>
 
@@ -506,4 +507,35 @@ int __alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 
 void free_bucket_spinlocks(spinlock_t *locks);
 
+DEFINE_LOCK_GUARD_1(raw_spinlock, raw_spinlock_t,
+		    raw_spin_lock(_T->lock),
+		    raw_spin_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(raw_spinlock_nested, raw_spinlock_t,
+		    raw_spin_lock_nested(_T->lock, SINGLE_DEPTH_NESTING),
+		    raw_spin_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(raw_spinlock_irq, raw_spinlock_t,
+		    raw_spin_lock_irq(_T->lock),
+		    raw_spin_unlock_irq(_T->lock))
+
+DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
+		    raw_spin_lock_irqsave(_T->lock, _T->flags),
+		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+
+DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
+		    spin_lock(_T->lock),
+		    spin_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(spinlock_irq, spinlock_t,
+		    spin_lock_irq(_T->lock),
+		    spin_unlock_irq(_T->lock))
+
+DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
+		    spin_lock_irqsave(_T->lock, _T->flags),
+		    spin_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+
+#undef __LINUX_INSIDE_SPINLOCK_H
 #endif /* __LINUX_SPINLOCK_H */
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index e6011a9975af..e94687215fbe 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -211,4 +211,9 @@ static inline void smp_mb__after_srcu_read_unlock(void)
 	/* __srcu_read_unlock has smp_mb() internally so nothing to do here. */
 }
 
+DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
+		    _T->idx = srcu_read_lock(_T->lock),
+		    srcu_read_unlock(_T->lock, _T->idx),
+		    int idx)
+
 #endif
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 306005b3b60f..97e99385f70c 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -631,6 +631,24 @@ extern struct sas_task *sas_alloc_task(gfp_t flags);
 extern struct sas_task *sas_alloc_slow_task(gfp_t flags);
 extern void sas_free_task(struct sas_task *task);
 
+static inline struct request *sas_task_find_rq(struct sas_task *task)
+{
+	struct scsi_cmnd *scmd;
+
+	if (task->task_proto & SAS_PROTOCOL_STP_ALL) {
+		struct ata_queued_cmd *qc = task->uldd_task;
+
+		scmd = qc ? qc->scsicmd : NULL;
+	} else {
+		scmd = task->uldd_task;
+	}
+
+	if (!scmd)
+		return NULL;
+
+	return scsi_cmd_to_rq(scmd);
+}
+
 struct sas_domain_function_template {
 	/* The class calls these to notify the LLDD of an event. */
 	void (*lldd_port_formed)(struct asd_sas_phy *);
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index 1646dadd7f37..3b1c8d93b265 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -27,7 +27,8 @@
 		{ FL_SLEEP,		"FL_SLEEP" },			\
 		{ FL_DOWNGRADE_PENDING,	"FL_DOWNGRADE_PENDING" },	\
 		{ FL_UNLOCK_PENDING,	"FL_UNLOCK_PENDING" },		\
-		{ FL_OFDLCK,		"FL_OFDLCK" })
+		{ FL_OFDLCK,		"FL_OFDLCK" },			\
+		{ FL_RECLAIM,		"FL_RECLAIM"})
 
 #define show_fl_type(val)				\
 	__print_symbolic(val,				\
diff --git a/init/main.c b/init/main.c
index 3f3dc2a8bd86..0b6071b26ccb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -540,6 +540,14 @@ static int __init unknown_bootoption(char *param, char *val,
 				     const char *unused, void *arg)
 {
 	size_t len = strlen(param);
+	int i;
+
+	/*
+	 * Well-known bootloader identifiers:
+	 * 1. LILO/Grub pass "BOOT_IMAGE=...";
+	 * 2. kexec/kdump (kexec-tools) pass "kexec".
+	 */
+	const char *bootloader[] = { "BOOT_IMAGE=", "kexec", NULL };
 
 	/* Handle params aliased to sysctls */
 	if (sysctl_is_alias(param))
@@ -547,6 +555,12 @@ static int __init unknown_bootoption(char *param, char *val,
 
 	repair_env_string(param, val);
 
+	/* Handle bootloader identifier */
+	for (i = 0; bootloader[i]; i++) {
+		if (strstarts(param, bootloader[i]))
+			return 0;
+	}
+
 	/* Handle obsolete-style parameters */
 	if (obsolete_checksetup(param))
 		return 0;
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 5a8d9f7467bf..849df8268af5 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -610,7 +610,7 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static void bpf_free_inode(struct inode *inode)
+static void bpf_destroy_inode(struct inode *inode)
 {
 	enum bpf_type type;
 
@@ -625,7 +625,7 @@ static const struct super_operations bpf_super_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
 	.show_options	= bpf_show_options,
-	.free_inode	= bpf_free_inode,
+	.destroy_inode	= bpf_destroy_inode,
 };
 
 enum {
diff --git a/kernel/fork.c b/kernel/fork.c
index 2fd9c431bf45..2c99d39e2bc0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1595,7 +1595,7 @@ static int copy_io(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_sighand(u64 clone_flags, struct task_struct *tsk)
 {
 	struct sighand_struct *sig;
 
diff --git a/kernel/pid.c b/kernel/pid.c
index efe87db44683..61f6649568b2 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -474,7 +474,7 @@ pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns)
 	struct upid *upid;
 	pid_t nr = 0;
 
-	if (pid && ns->level <= pid->level) {
+	if (pid && ns && ns->level <= pid->level) {
 		upid = &pid->numbers[ns->level];
 		if (upid->ns == ns)
 			nr = upid->nr;
diff --git a/kernel/smp.c b/kernel/smp.c
index b60525b34ab0..387df30ca560 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -976,16 +976,15 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
  * @mask: The set of cpus to run on (only runs on online subset).
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
- * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
- *        (atomically) until function has completed on other CPUs. If
- *        %SCF_RUN_LOCAL is set, the function will also be run locally
- *        if the local CPU is set in the @cpumask.
- *
- * If @wait is true, then returns once @func has returned.
+ * @wait: If true, wait (atomically) until function has completed
+ *        on other CPUs.
  *
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler. Preemption
  * must be disabled when calling this function.
+ *
+ * @func is not called on the local CPU even if @mask contains it.  Consider
+ * using on_each_cpu_cond_mask() instead if this is not desirable.
  */
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait)
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 8af92dbe98f0..acb0c971a408 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -34,8 +34,6 @@ MODULE_PARM_DESC(cpu_affinity, "Cpu num test is running on");
 
 static struct completion done;
 
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-
 static void busy_wait(ulong time)
 {
 	u64 start, end;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index e062f4efec8d..03d4ac41d903 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1722,14 +1722,15 @@ static int kprobe_register(struct trace_event_call *event,
 static int kprobe_dispatcher(struct kprobe *kp, struct pt_regs *regs)
 {
 	struct trace_kprobe *tk = container_of(kp, struct trace_kprobe, rp.kp);
+	unsigned int flags = trace_probe_load_flag(&tk->tp);
 	int ret = 0;
 
 	raw_cpu_inc(*tk->nhit);
 
-	if (trace_probe_test_flag(&tk->tp, TP_FLAG_TRACE))
+	if (flags & TP_FLAG_TRACE)
 		kprobe_trace_func(tk, regs);
 #ifdef CONFIG_PERF_EVENTS
-	if (trace_probe_test_flag(&tk->tp, TP_FLAG_PROFILE))
+	if (flags & TP_FLAG_PROFILE)
 		ret = kprobe_perf_func(tk, regs);
 #endif
 	return ret;
@@ -1741,6 +1742,7 @@ kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
 	struct kretprobe *rp = get_kretprobe(ri);
 	struct trace_kprobe *tk;
+	unsigned int flags;
 
 	/*
 	 * There is a small chance that get_kretprobe(ri) returns NULL when
@@ -1753,10 +1755,11 @@ kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
 	tk = container_of(rp, struct trace_kprobe, rp);
 	raw_cpu_inc(*tk->nhit);
 
-	if (trace_probe_test_flag(&tk->tp, TP_FLAG_TRACE))
+	flags = trace_probe_load_flag(&tk->tp);
+	if (flags & TP_FLAG_TRACE)
 		kretprobe_trace_func(tk, ri, regs);
 #ifdef CONFIG_PERF_EVENTS
-	if (trace_probe_test_flag(&tk->tp, TP_FLAG_PROFILE))
+	if (flags & TP_FLAG_PROFILE)
 		kretprobe_perf_func(tk, ri, regs);
 #endif
 	return 0;	/* We don't tweak kernel, so just return 0 */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 82e1df8aefcb..b08aa3946868 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -258,16 +258,21 @@ struct event_file_link {
 	struct list_head		list;
 };
 
+static inline unsigned int trace_probe_load_flag(struct trace_probe *tp)
+{
+	return smp_load_acquire(&tp->event->flags);
+}
+
 static inline bool trace_probe_test_flag(struct trace_probe *tp,
 					 unsigned int flag)
 {
-	return !!(tp->event->flags & flag);
+	return !!(trace_probe_load_flag(tp) & flag);
 }
 
 static inline void trace_probe_set_flag(struct trace_probe *tp,
 					unsigned int flag)
 {
-	tp->event->flags |= flag;
+	smp_store_release(&tp->event->flags, tp->event->flags | flag);
 }
 
 static inline void trace_probe_clear_flag(struct trace_probe *tp,
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 322d56661d04..707c5373476a 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1485,6 +1485,7 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	struct uprobe_dispatch_data udd;
 	struct uprobe_cpu_buffer *ucb;
 	int dsize, esize;
+	unsigned int flags;
 	int ret = 0;
 
 
@@ -1505,11 +1506,12 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	ucb = uprobe_buffer_get();
 	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
-	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
+	flags = trace_probe_load_flag(&tu->tp);
+	if (flags & TP_FLAG_TRACE)
 		ret |= uprobe_trace_func(tu, regs, ucb, dsize);
 
 #ifdef CONFIG_PERF_EVENTS
-	if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
+	if (flags & TP_FLAG_PROFILE)
 		ret |= uprobe_perf_func(tu, regs, ucb, dsize);
 #endif
 	uprobe_buffer_put(ucb);
@@ -1523,6 +1525,7 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	struct uprobe_dispatch_data udd;
 	struct uprobe_cpu_buffer *ucb;
 	int dsize, esize;
+	unsigned int flags;
 
 	tu = container_of(con, struct trace_uprobe, consumer);
 
@@ -1540,11 +1543,12 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	ucb = uprobe_buffer_get();
 	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
-	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
+	flags = trace_probe_load_flag(&tu->tp);
+	if (flags & TP_FLAG_TRACE)
 		uretprobe_trace_func(tu, func, regs, ucb, dsize);
 
 #ifdef CONFIG_PERF_EVENTS
-	if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
+	if (flags & TP_FLAG_PROFILE)
 		uretprobe_perf_func(tu, func, regs, ucb, dsize);
 #endif
 	uprobe_buffer_put(ucb);
diff --git a/lib/btree.c b/lib/btree.c
index b4cf08a5c267..b12f99d4c45c 100644
--- a/lib/btree.c
+++ b/lib/btree.c
@@ -43,7 +43,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
 #define NODESIZE MAX(L1_CACHE_BYTES, 128)
 
 struct btree_geo {
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index ed43a41f2dcc..a45b7cf6d6c5 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -22,6 +22,10 @@ obj-$(CONFIG_CRYPTO_LIB_CURVE25519_GENERIC)	+= libcurve25519-generic.o
 libcurve25519-generic-y				:= curve25519-fiat32.o
 libcurve25519-generic-$(CONFIG_ARCH_SUPPORTS_INT128)	:= curve25519-hacl64.o
 libcurve25519-generic-y				+= curve25519-generic.o
+# clang versions prior to 18 may blow out the stack with KASAN
+ifeq ($(call clang-min-version, 180000),)
+KASAN_SANITIZE_curve25519-hacl64.o := n
+endif
 
 obj-$(CONFIG_CRYPTO_LIB_CURVE25519)		+= libcurve25519.o
 libcurve25519-y					+= curve25519.o
diff --git a/lib/decompress_unlzma.c b/lib/decompress_unlzma.c
index 20a858031f12..9d34d35908da 100644
--- a/lib/decompress_unlzma.c
+++ b/lib/decompress_unlzma.c
@@ -37,7 +37,9 @@
 
 #include <linux/decompress/mm.h>
 
+#ifndef MIN
 #define	MIN(a, b) (((a) < (b)) ? (a) : (b))
+#endif
 
 static long long INIT read_int(unsigned char *ptr, int size)
 {
diff --git a/lib/genalloc.c b/lib/genalloc.c
index 9a57257988c7..bed308b4493f 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -899,8 +899,11 @@ struct gen_pool *of_gen_pool_get(struct device_node *np,
 		if (!name)
 			name = np_pool->name;
 	}
-	if (pdev)
+	if (pdev) {
 		pool = gen_pool_get(&pdev->dev, name);
+		put_device(&pdev->dev);
+	}
+
 	of_node_put(np_pool);
 
 	return pool;
diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 07b4b9a1f54b..2ea564a40064 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -20,9 +20,6 @@
 static LIST_HEAD(io_range_list);
 static DEFINE_MUTEX(io_range_mutex);
 
-/* Consider a kernel general helper for this */
-#define in_range(b, first, len)        ((b) >= (first) && (b) < (first) + (len))
-
 /**
  * logic_pio_register_range - register logical PIO range for a host
  * @new_range: pointer to the IO range to be registered.
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d86abdc77c26..e46eb93c115d 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1100,7 +1100,7 @@ char *resource_string(char *buf, char *end, struct resource *res,
 #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
 #define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
 #define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
-	char sym[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
+	char sym[MAX(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
 		     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
 
 	char *p = sym, *pend = sym + sizeof(sym);
diff --git a/lib/zstd/zstd_internal.h b/lib/zstd/zstd_internal.h
index dac753397f86..927ed4e8c11c 100644
--- a/lib/zstd/zstd_internal.h
+++ b/lib/zstd/zstd_internal.h
@@ -36,8 +36,6 @@
 /*-*************************************
 *  shared macros
 ***************************************/
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
 #define CHECK_F(f)                       \
 	{                                \
 		size_t const errcod = f; \
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bca110617f51..70ceac102a8d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5714,6 +5714,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			pages++;
 		}
 		spin_unlock(ptl);
+
+		cond_resched();
 	}
 	/*
 	 * Must flush TLB before releasing i_mmap_rwsem: x86's huge_pmd_unshare
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4279ece7eade..63e131dc2b43 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4743,7 +4743,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
 			alloc_flags |= ALLOC_NON_BLOCK;
 
-			if (order > 0)
+			if (order > 0 && (alloc_flags & ALLOC_MIN_RESERVE))
 				alloc_flags |= ALLOC_HIGHATOMIC;
 		}
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 79f389d620c9..fd01f6922874 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -126,7 +126,6 @@
 #define ISOLATED_BITS	3
 #define MAGIC_VAL_BITS	8
 
-#define MAX(a, b) ((a) >= (b) ? (a) : (b))
 /* ZS_MIN_ALLOC_SIZE must be multiple of ZS_ALIGN */
 #define ZS_MIN_ALLOC_SIZE \
 	MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> OBJ_INDEX_BITS))
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index b44b77d3b35d..6b4a984eb989 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -722,10 +722,10 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
 	p9_debug(P9_DEBUG_TRANS, "client %p req %p\n", client, req);
 
 	spin_lock(&m->req_lock);
-	/* Ignore cancelled request if message has been received
-	 * before lock.
-	 */
-	if (req->status == REQ_STATUS_RCVD) {
+	/* Ignore cancelled request if status changed since the request was
+	 * processed in p9_client_flush()
+	*/
+	if (req->status != REQ_STATUS_SENT) {
 		spin_unlock(&m->req_lock);
 		return 0;
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a54eb754e9a7..1d04fb42f13f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3824,13 +3824,11 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 	memset(&buf, 0, sizeof(buf));
 
 #ifdef CONFIG_BT_FEATURE_DEBUG
-	if (!hdev) {
-		flags = bt_dbg_get() ? BIT(0) : 0;
+	flags = bt_dbg_get() ? BIT(0) : 0;
 
-		memcpy(rp->features[idx].uuid, debug_uuid, 16);
-		rp->features[idx].flags = cpu_to_le32(flags);
-		idx++;
-	}
+	memcpy(rp->features[idx].uuid, debug_uuid, 16);
+	rp->features[idx].flags = cpu_to_le32(flags);
+	idx++;
 #endif
 
 	if (hdev) {
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 86441ff78a0f..055d988d280c 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1391,7 +1391,7 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
 	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
 		return;
 
-	vg = br_vlan_group(br);
+	vg = br_vlan_group_rcu(br);
 
 	if (idx >= 0 &&
 	    ctx->vlan[idx].proto == br->vlan_proto) {
diff --git a/net/core/filter.c b/net/core/filter.c
index f346f19cf468..1403829b96db 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2257,6 +2257,7 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 		if (IS_ERR(dst))
 			goto out_drop;
 
+		skb_dst_drop(skb);
 		skb_dst_set(skb, dst);
 	} else if (nh->nh_family != AF_INET6) {
 		goto out_drop;
@@ -2364,6 +2365,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 			goto out_drop;
 		}
 
+		skb_dst_drop(skb);
 		skb_dst_set(skb, &rt->dst);
 	}
 
@@ -8595,13 +8597,17 @@ static bool sock_addr_is_valid_access(int off, int size,
 			return false;
 		info->reg_type = PTR_TO_SOCKET;
 		break;
-	default:
-		if (type == BPF_READ) {
-			if (size != size_default)
-				return false;
-		} else {
+	case bpf_ctx_range(struct bpf_sock_addr, user_family):
+	case bpf_ctx_range(struct bpf_sock_addr, family):
+	case bpf_ctx_range(struct bpf_sock_addr, type):
+	case bpf_ctx_range(struct bpf_sock_addr, protocol):
+		if (type != BPF_READ)
 			return false;
-		}
+		if (size != size_default)
+			return false;
+		break;
+	default:
+		return false;
 	}
 
 	return true;
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 4b9280a3b673..d849f61b7519 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -43,7 +43,7 @@
 #include <net/sock.h>
 #include <net/raw.h>
 
-#define TCPUDP_MIB_MAX max_t(u32, UDP_MIB_MAX, TCP_MIB_MAX)
+#define TCPUDP_MIB_MAX MAX_T(u32, UDP_MIB_MAX, TCP_MIB_MAX)
 
 /*
  *	Report socket allocation statistics [mea@utu.fi]
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9508e2c90b84..b3d373372e84 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2747,8 +2747,8 @@ bool tcp_check_oom(struct sock *sk, int shift)
 
 void __tcp_close(struct sock *sk, long timeout)
 {
+	bool data_was_unread = false;
 	struct sk_buff *skb;
-	int data_was_unread = 0;
 	int state;
 
 	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
@@ -2767,11 +2767,12 @@ void __tcp_close(struct sock *sk, long timeout)
 	 *  reader process may not have drained the data yet!
 	 */
 	while ((skb = __skb_dequeue(&sk->sk_receive_queue)) != NULL) {
-		u32 len = TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)->seq;
+		u32 end_seq = TCP_SKB_CB(skb)->end_seq;
 
 		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
-			len--;
-		data_was_unread += len;
+			end_seq--;
+		if (after(end_seq, tcp_sk(sk)->copied_seq))
+			data_was_unread = true;
 		__kfree_skb(skb);
 	}
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index fea019cc92d3..15548dc3cc5c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7060,7 +7060,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 				    &foc, TCP_SYNACK_FASTOPEN, skb);
 		/* Add the child socket directly into the accept queue */
 		if (!inet_csk_reqsk_queue_add(sk, req, fastopen_sk)) {
-			reqsk_fastopen_remove(fastopen_sk, req, false);
 			bh_unlock_sock(fastopen_sk);
 			sock_put(fastopen_sk);
 			goto drop_and_free;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 51a12fa486b6..3ebd5765fb9f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1459,12 +1459,12 @@ static bool udp_skb_has_head_state(struct sk_buff *skb)
 }
 
 /* fully reclaim rmem/fwd memory allocated for skb */
-static void udp_rmem_release(struct sock *sk, int size, int partial,
-			     bool rx_queue_lock_held)
+static void udp_rmem_release(struct sock *sk, unsigned int size,
+			     int partial, bool rx_queue_lock_held)
 {
 	struct udp_sock *up = udp_sk(sk);
 	struct sk_buff_head *sk_queue;
-	int amt;
+	unsigned int amt;
 
 	if (likely(partial)) {
 		up->forward_deficit += size;
@@ -1484,10 +1484,8 @@ static void udp_rmem_release(struct sock *sk, int size, int partial,
 	if (!rx_queue_lock_held)
 		spin_lock(&sk_queue->lock);
 
-
-	sk->sk_forward_alloc += size;
-	amt = (sk->sk_forward_alloc - partial) & ~(SK_MEM_QUANTUM - 1);
-	sk->sk_forward_alloc -= amt;
+	amt = (size + sk->sk_forward_alloc - partial) & ~(PAGE_SIZE - 1);
+	sk->sk_forward_alloc += size - amt;
 
 	if (amt)
 		__sk_mem_reduce_allocated(sk, amt >> SK_MEM_QUANTUM_SHIFT);
@@ -1671,7 +1669,7 @@ EXPORT_SYMBOL_GPL(skb_consume_udp);
 
 static struct sk_buff *__first_packet_length(struct sock *sk,
 					     struct sk_buff_head *rcvq,
-					     int *total)
+					     unsigned int *total)
 {
 	struct sk_buff *skb;
 
@@ -1704,8 +1702,8 @@ static int first_packet_length(struct sock *sk)
 {
 	struct sk_buff_head *rcvq = &udp_sk(sk)->reader_queue;
 	struct sk_buff_head *sk_queue = &sk->sk_receive_queue;
+	unsigned int total = 0;
 	struct sk_buff *skb;
-	int total = 0;
 	int res;
 
 	spin_lock_bh(&rcvq->lock);
diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
index d6306aa46bb1..e07c43bd5cb0 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -27,7 +27,7 @@
 #include <net/ipv6.h>
 
 #define MAX4(a, b, c, d) \
-	max_t(u32, max_t(u32, a, b), max_t(u32, c, d))
+	MAX_T(u32, MAX_T(u32, a, b), MAX_T(u32, c, d))
 #define SNMP_MIB_MAX MAX4(UDP_MIB_MAX, TCP_MIB_MAX, \
 			IPSTATS_MIB_MAX, ICMP_MIB_MAX)
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4fa31301fe84..737643e84ed1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -189,9 +189,12 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	/* id0 should not have a different address */
+	/* - id0 should not have a different address
+	 * - special case for C-flag: linked to fill_local_addresses_vec()
+	 */
 	if ((addr->id == 0 && !mptcp_pm_nl_is_init_remote_addr(msk, addr)) ||
-	    (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
+	    (addr->id > 0 && !READ_ONCE(pm->accept_addr) &&
+	     !mptcp_pm_add_addr_c_flag_case(msk))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f9839980fcaf..df46ca14ce23 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -571,6 +571,7 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
  * and return the array size.
  */
 static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
+					     struct mptcp_addr_info *remote,
 					     struct mptcp_addr_info *addrs)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -578,10 +579,12 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
+	bool c_flag_case;
 	int i = 0;
 
 	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
+	c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
 
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 
@@ -605,6 +608,10 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			msk->pm.subflows++;
 			addrs[i] = entry->addr;
 
+			if (c_flag_case &&
+			    (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
+				msk->pm.local_addr_used++;
+
 			/* Special case for ID0: set the correct ID */
 			if (addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
 				addrs[i].id = 0;
@@ -614,6 +621,46 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	}
 	rcu_read_unlock();
 
+	/* Special case: peer sets the C flag, accept one ADD_ADDR if default
+	 * limits are used -- accepting no ADD_ADDR -- and use subflow endpoints
+	 */
+	if (!i && c_flag_case) {
+		unsigned int local_addr_max = mptcp_pm_get_local_addr_max(msk);
+
+		rcu_read_lock();
+		__mptcp_flush_join_list(msk);
+		list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+			if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
+				continue;
+
+			if (entry->addr.family != sk->sk_family) {
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+				if ((entry->addr.family == AF_INET &&
+				     !ipv6_addr_v4mapped(&sk->sk_v6_daddr)) ||
+				    (sk->sk_family == AF_INET &&
+				     !ipv6_addr_v4mapped(&entry->addr.addr6)))
+#endif
+					continue;
+			}
+
+			/* avoid any address already in use by subflows and
+			 * pending join
+			 */
+			if (!lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
+			    msk->pm.local_addr_used < local_addr_max &&
+			    msk->pm.subflows < subflows_max) {
+				addrs[i] = entry->addr;
+
+				msk->pm.local_addr_used++;
+				msk->pm.subflows++;
+				i++;
+			}
+		}
+		rcu_read_unlock();
+
+		return i;
+	}
+
 	/* If the array is empty, fill in the single
 	 * 'IPADDRANY' local address
 	 */
@@ -661,7 +708,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
 	 */
-	nr = fill_local_addresses_vec(msk, addrs);
+	nr = fill_local_addresses_vec(msk, &remote, addrs);
 
 	spin_unlock_bh(&msk->pm.lock);
 	for (i = 0; i < nr; i++)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8d05fb205a31..c93399d11650 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -846,6 +846,14 @@ unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
 
+static inline bool mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
+	       msk->pm.local_addr_used == 0 &&
+	       mptcp_pm_get_add_addr_accept_max(msk) == 0 &&
+	       msk->pm.subflows < mptcp_pm_get_subflows_max(msk);
+}
+
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_sockopt_sync_all(struct mptcp_sock *msk);
 
diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 0bd6bf46f05f..1f9ca5040982 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -62,7 +62,7 @@ struct hbucket {
 		: jhash_size((htable_bits) - HTABLE_REGION_BITS))
 #define ahash_sizeof_regions(htable_bits)		\
 	(ahash_numof_locks(htable_bits) * sizeof(struct ip_set_region))
-#define ahash_region(n, htable_bits)		\
+#define ahash_region(n)		\
 	((n) / jhash_size(HTABLE_REGION_BITS))
 #define ahash_bucket_start(h,  htable_bits)	\
 	((htable_bits) < HTABLE_REGION_BITS ? 0	\
@@ -689,7 +689,7 @@ mtype_resize(struct ip_set *set, bool retried)
 #endif
 				key = HKEY(data, h->initval, htable_bits);
 				m = __ipset_dereference(hbucket(t, key));
-				nr = ahash_region(key, htable_bits);
+				nr = ahash_region(key);
 				if (!m) {
 					m = kzalloc(sizeof(*m) +
 					    AHASH_INIT_SIZE * dsize,
@@ -839,7 +839,7 @@ mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	rcu_read_lock_bh();
 	t = rcu_dereference_bh(h->table);
 	key = HKEY(value, h->initval, t->htable_bits);
-	r = ahash_region(key, t->htable_bits);
+	r = ahash_region(key);
 	atomic_inc(&t->uref);
 	elements = t->hregion[r].elements;
 	maxelem = t->maxelem;
@@ -1037,7 +1037,7 @@ mtype_del(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	rcu_read_lock_bh();
 	t = rcu_dereference_bh(h->table);
 	key = HKEY(value, h->initval, t->htable_bits);
-	r = ahash_region(key, t->htable_bits);
+	r = ahash_region(key);
 	atomic_inc(&t->uref);
 	rcu_read_unlock_bh();
 
diff --git a/net/netfilter/ipvs/ip_vs_ftp.c b/net/netfilter/ipvs/ip_vs_ftp.c
index ef1f45e43b63..61d3797fb799 100644
--- a/net/netfilter/ipvs/ip_vs_ftp.c
+++ b/net/netfilter/ipvs/ip_vs_ftp.c
@@ -53,6 +53,7 @@ enum {
 	IP_VS_FTP_EPSV,
 };
 
+static bool exiting_module;
 /*
  * List of ports (up to IP_VS_APP_MAX_PORTS) to be handled by helper
  * First port is set to the default port.
@@ -605,7 +606,7 @@ static void __ip_vs_ftp_exit(struct net *net)
 {
 	struct netns_ipvs *ipvs = net_ipvs(net);
 
-	if (!ipvs)
+	if (!ipvs || !exiting_module)
 		return;
 
 	unregister_ip_vs_app(ipvs, &ip_vs_ftp);
@@ -627,6 +628,7 @@ static int __init ip_vs_ftp_init(void)
  */
 static void __exit ip_vs_ftp_exit(void)
 {
+	exiting_module = true;
 	unregister_pernet_subsys(&ip_vs_ftp_ops);
 	/* rcu_barrier() is called by netns */
 }
diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index b776b3af78ca..1dd160b84d05 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -242,7 +242,7 @@ static bool l4proto_in_range(const struct nf_conntrack_tuple *tuple,
 /* If we source map this tuple so reply looks like reply_tuple, will
  * that meet the constraints of range.
  */
-static int in_range(const struct nf_conntrack_tuple *tuple,
+static int nf_in_range(const struct nf_conntrack_tuple *tuple,
 		    const struct nf_nat_range2 *range)
 {
 	/* If we are supposed to map IPs, then we must be in the
@@ -291,7 +291,7 @@ find_appropriate_src(struct net *net,
 				       &ct->tuplehash[IP_CT_DIR_REPLY].tuple);
 			result->dst = tuple->dst;
 
-			if (in_range(result, range))
+			if (nf_in_range(result, range))
 				return 1;
 		}
 	}
@@ -523,7 +523,7 @@ get_unique_tuple(struct nf_conntrack_tuple *tuple,
 	if (maniptype == NF_NAT_MANIP_SRC &&
 	    !(range->flags & NF_NAT_RANGE_PROTO_RANDOM_ALL)) {
 		/* try the original tuple first */
-		if (in_range(orig_tuple, range)) {
+		if (nf_in_range(orig_tuple, range)) {
 			if (!nf_nat_used_tuple(orig_tuple, ct)) {
 				*tuple = *orig_tuple;
 				return;
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 8f48b1061944..5402987261be 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -27,11 +27,16 @@
 
 /* Handle NCI Notification packets */
 
-static void nci_core_reset_ntf_packet(struct nci_dev *ndev,
-				      const struct sk_buff *skb)
+static int nci_core_reset_ntf_packet(struct nci_dev *ndev,
+				     const struct sk_buff *skb)
 {
 	/* Handle NCI 2.x core reset notification */
-	const struct nci_core_reset_ntf *ntf = (void *)skb->data;
+	const struct nci_core_reset_ntf *ntf;
+
+	if (skb->len < sizeof(struct nci_core_reset_ntf))
+		return -EINVAL;
+
+	ntf = (struct nci_core_reset_ntf *)skb->data;
 
 	ndev->nci_ver = ntf->nci_ver;
 	pr_debug("nci_ver 0x%x, config_status 0x%x\n",
@@ -42,15 +47,22 @@ static void nci_core_reset_ntf_packet(struct nci_dev *ndev,
 		__le32_to_cpu(ntf->manufact_specific_info);
 
 	nci_req_complete(ndev, NCI_STATUS_OK);
+
+	return 0;
 }
 
-static void nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
-					     struct sk_buff *skb)
+static int nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
+					    struct sk_buff *skb)
 {
-	struct nci_core_conn_credit_ntf *ntf = (void *) skb->data;
+	struct nci_core_conn_credit_ntf *ntf;
 	struct nci_conn_info *conn_info;
 	int i;
 
+	if (skb->len < sizeof(struct nci_core_conn_credit_ntf))
+		return -EINVAL;
+
+	ntf = (struct nci_core_conn_credit_ntf *)skb->data;
+
 	pr_debug("num_entries %d\n", ntf->num_entries);
 
 	if (ntf->num_entries > NCI_MAX_NUM_CONN)
@@ -68,7 +80,7 @@ static void nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
 		conn_info = nci_get_conn_info_by_conn_id(ndev,
 							 ntf->conn_entries[i].conn_id);
 		if (!conn_info)
-			return;
+			return 0;
 
 		atomic_add(ntf->conn_entries[i].credits,
 			   &conn_info->credits_cnt);
@@ -77,12 +89,19 @@ static void nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
 	/* trigger the next tx */
 	if (!skb_queue_empty(&ndev->tx_q))
 		queue_work(ndev->tx_wq, &ndev->tx_work);
+
+	return 0;
 }
 
-static void nci_core_generic_error_ntf_packet(struct nci_dev *ndev,
-					      const struct sk_buff *skb)
+static int nci_core_generic_error_ntf_packet(struct nci_dev *ndev,
+					     const struct sk_buff *skb)
 {
-	__u8 status = skb->data[0];
+	__u8 status;
+
+	if (skb->len < 1)
+		return -EINVAL;
+
+	status = skb->data[0];
 
 	pr_debug("status 0x%x\n", status);
 
@@ -91,12 +110,19 @@ static void nci_core_generic_error_ntf_packet(struct nci_dev *ndev,
 		   (the state remains the same) */
 		nci_req_complete(ndev, status);
 	}
+
+	return 0;
 }
 
-static void nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
-						struct sk_buff *skb)
+static int nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
+					       struct sk_buff *skb)
 {
-	struct nci_core_intf_error_ntf *ntf = (void *) skb->data;
+	struct nci_core_intf_error_ntf *ntf;
+
+	if (skb->len < sizeof(struct nci_core_intf_error_ntf))
+		return -EINVAL;
+
+	ntf = (struct nci_core_intf_error_ntf *)skb->data;
 
 	ntf->conn_id = nci_conn_id(&ntf->conn_id);
 
@@ -105,6 +131,8 @@ static void nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
 	/* complete the data exchange transaction, if exists */
 	if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
 		nci_data_exchange_complete(ndev, NULL, ntf->conn_id, -EIO);
+
+	return 0;
 }
 
 static const __u8 *
@@ -329,13 +357,18 @@ void nci_clear_target_list(struct nci_dev *ndev)
 	ndev->n_targets = 0;
 }
 
-static void nci_rf_discover_ntf_packet(struct nci_dev *ndev,
-				       const struct sk_buff *skb)
+static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
+				      const struct sk_buff *skb)
 {
 	struct nci_rf_discover_ntf ntf;
-	const __u8 *data = skb->data;
+	const __u8 *data;
 	bool add_target = true;
 
+	if (skb->len < sizeof(struct nci_rf_discover_ntf))
+		return -EINVAL;
+
+	data = skb->data;
+
 	ntf.rf_discovery_id = *data++;
 	ntf.rf_protocol = *data++;
 	ntf.rf_tech_and_mode = *data++;
@@ -390,6 +423,8 @@ static void nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 		nfc_targets_found(ndev->nfc_dev, ndev->targets,
 				  ndev->n_targets);
 	}
+
+	return 0;
 }
 
 static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
@@ -531,14 +566,19 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	return NCI_STATUS_OK;
 }
 
-static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
-					     const struct sk_buff *skb)
+static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
+					    const struct sk_buff *skb)
 {
 	struct nci_conn_info *conn_info;
 	struct nci_rf_intf_activated_ntf ntf;
-	const __u8 *data = skb->data;
+	const __u8 *data;
 	int err = NCI_STATUS_OK;
 
+	if (skb->len < sizeof(struct nci_rf_intf_activated_ntf))
+		return -EINVAL;
+
+	data = skb->data;
+
 	ntf.rf_discovery_id = *data++;
 	ntf.rf_interface = *data++;
 	ntf.rf_protocol = *data++;
@@ -645,7 +685,7 @@ static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 	if (err == NCI_STATUS_OK) {
 		conn_info = ndev->rf_conn_info;
 		if (!conn_info)
-			return;
+			return 0;
 
 		conn_info->max_pkt_payload_len = ntf.max_data_pkt_payload_size;
 		conn_info->initial_num_credits = ntf.initial_num_credits;
@@ -691,19 +731,26 @@ static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 				pr_err("error when signaling tm activation\n");
 		}
 	}
+
+	return 0;
 }
 
-static void nci_rf_deactivate_ntf_packet(struct nci_dev *ndev,
-					 const struct sk_buff *skb)
+static int nci_rf_deactivate_ntf_packet(struct nci_dev *ndev,
+					const struct sk_buff *skb)
 {
 	const struct nci_conn_info *conn_info;
-	const struct nci_rf_deactivate_ntf *ntf = (void *)skb->data;
+	const struct nci_rf_deactivate_ntf *ntf;
+
+	if (skb->len < sizeof(struct nci_rf_deactivate_ntf))
+		return -EINVAL;
+
+	ntf = (struct nci_rf_deactivate_ntf *)skb->data;
 
 	pr_debug("entry, type 0x%x, reason 0x%x\n", ntf->type, ntf->reason);
 
 	conn_info = ndev->rf_conn_info;
 	if (!conn_info)
-		return;
+		return 0;
 
 	/* drop tx data queue */
 	skb_queue_purge(&ndev->tx_q);
@@ -735,14 +782,20 @@ static void nci_rf_deactivate_ntf_packet(struct nci_dev *ndev,
 	}
 
 	nci_req_complete(ndev, NCI_STATUS_OK);
+
+	return 0;
 }
 
-static void nci_nfcee_discover_ntf_packet(struct nci_dev *ndev,
-					  const struct sk_buff *skb)
+static int nci_nfcee_discover_ntf_packet(struct nci_dev *ndev,
+					 const struct sk_buff *skb)
 {
 	u8 status = NCI_STATUS_OK;
-	const struct nci_nfcee_discover_ntf *nfcee_ntf =
-				(struct nci_nfcee_discover_ntf *)skb->data;
+	const struct nci_nfcee_discover_ntf *nfcee_ntf;
+
+	if (skb->len < sizeof(struct nci_nfcee_discover_ntf))
+		return -EINVAL;
+
+	nfcee_ntf = (struct nci_nfcee_discover_ntf *)skb->data;
 
 	pr_debug("\n");
 
@@ -755,6 +808,8 @@ static void nci_nfcee_discover_ntf_packet(struct nci_dev *ndev,
 	ndev->cur_params.id = nfcee_ntf->nfcee_id;
 
 	nci_req_complete(ndev, status);
+
+	return 0;
 }
 
 static void nci_nfcee_action_ntf_packet(struct nci_dev *ndev,
@@ -787,35 +842,43 @@ void nci_ntf_packet(struct nci_dev *ndev, struct sk_buff *skb)
 
 	switch (ntf_opcode) {
 	case NCI_OP_CORE_RESET_NTF:
-		nci_core_reset_ntf_packet(ndev, skb);
+		if (nci_core_reset_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_CORE_CONN_CREDITS_NTF:
-		nci_core_conn_credits_ntf_packet(ndev, skb);
+		if (nci_core_conn_credits_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_CORE_GENERIC_ERROR_NTF:
-		nci_core_generic_error_ntf_packet(ndev, skb);
+		if (nci_core_generic_error_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_CORE_INTF_ERROR_NTF:
-		nci_core_conn_intf_error_ntf_packet(ndev, skb);
+		if (nci_core_conn_intf_error_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_RF_DISCOVER_NTF:
-		nci_rf_discover_ntf_packet(ndev, skb);
+		if (nci_rf_discover_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_RF_INTF_ACTIVATED_NTF:
-		nci_rf_intf_activated_ntf_packet(ndev, skb);
+		if (nci_rf_intf_activated_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_RF_DEACTIVATE_NTF:
-		nci_rf_deactivate_ntf_packet(ndev, skb);
+		if (nci_rf_deactivate_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_NFCEE_DISCOVER_NTF:
-		nci_nfcee_discover_ntf_packet(ndev, skb);
+		if (nci_nfcee_discover_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_RF_NFCEE_ACTION_NTF:
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index c7503fd64915..088764ba47a1 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -31,6 +31,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <crypto/hash.h>
+#include <crypto/algapi.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/ip.h>
@@ -1796,7 +1797,7 @@ struct sctp_association *sctp_unpack_cookie(
 		}
 	}
 
-	if (memcmp(digest, cookie->signature, SCTP_SIGNATURE_SIZE)) {
+	if (crypto_memneq(digest, cookie->signature, SCTP_SIGNATURE_SIZE)) {
 		*error = -SCTP_IERROR_BAD_SIG;
 		goto fail;
 	}
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index b5f5ee233b59..f9882e0e67b1 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -30,6 +30,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <crypto/algapi.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/ip.h>
@@ -880,7 +881,8 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 	return SCTP_DISPOSITION_CONSUME;
 
 nomem_authev:
-	sctp_ulpevent_free(ai_ev);
+	if (ai_ev)
+		sctp_ulpevent_free(ai_ev);
 nomem_aiev:
 	sctp_ulpevent_free(ev);
 nomem_ev:
@@ -4401,7 +4403,7 @@ static enum sctp_ierror sctp_sf_authenticate(
 				 sh_key, GFP_ATOMIC);
 
 	/* Discard the packet if the digests do not match */
-	if (memcmp(save_digest, digest, sig_len)) {
+	if (crypto_memneq(save_digest, digest, sig_len)) {
 		kfree(save_digest);
 		return SCTP_IERROR_BAD_SIG;
 	}
diff --git a/net/tipc/core.h b/net/tipc/core.h
index 0a3f7a70a50a..7eccd97e0609 100644
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -197,7 +197,7 @@ static inline int less(u16 left, u16 right)
 	return less_eq(left, right) && (mod(right) != mod(left));
 }
 
-static inline int in_range(u16 val, u16 min, u16 max)
+static inline int tipc_in_range(u16 val, u16 min, u16 max)
 {
 	return !less(val, min) && !more(val, max);
 }
diff --git a/net/tipc/link.c b/net/tipc/link.c
index b098b74516d1..c8433ec7661d 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1623,7 +1623,7 @@ static int tipc_link_advance_transmq(struct tipc_link *l, struct tipc_link *r,
 					  last_ga->bgack_cnt);
 			}
 			/* Check against the last Gap ACK block */
-			if (in_range(seqno, start, end))
+			if (tipc_in_range(seqno, start, end))
 				continue;
 			/* Update/release the packet peer is acking */
 			bc_has_acked = true;
@@ -2251,12 +2251,12 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 		strncpy(if_name, data, TIPC_MAX_IF_NAME);
 
 		/* Update own tolerance if peer indicates a non-zero value */
-		if (in_range(peers_tol, TIPC_MIN_LINK_TOL, TIPC_MAX_LINK_TOL)) {
+		if (tipc_in_range(peers_tol, TIPC_MIN_LINK_TOL, TIPC_MAX_LINK_TOL)) {
 			l->tolerance = peers_tol;
 			l->bc_rcvlink->tolerance = peers_tol;
 		}
 		/* Update own priority if peer's priority is higher */
-		if (in_range(peers_prio, l->priority + 1, TIPC_MAX_LINK_PRI))
+		if (tipc_in_range(peers_prio, l->priority + 1, TIPC_MAX_LINK_PRI))
 			l->priority = peers_prio;
 
 		/* If peer is going down we want full re-establish cycle */
@@ -2299,13 +2299,13 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 		l->rcv_nxt_state = msg_seqno(hdr) + 1;
 
 		/* Update own tolerance if peer indicates a non-zero value */
-		if (in_range(peers_tol, TIPC_MIN_LINK_TOL, TIPC_MAX_LINK_TOL)) {
+		if (tipc_in_range(peers_tol, TIPC_MIN_LINK_TOL, TIPC_MAX_LINK_TOL)) {
 			l->tolerance = peers_tol;
 			l->bc_rcvlink->tolerance = peers_tol;
 		}
 		/* Update own prio if peer indicates a different value */
 		if ((peers_prio != l->priority) &&
-		    in_range(peers_prio, 1, TIPC_MAX_LINK_PRI)) {
+		    tipc_in_range(peers_prio, 1, TIPC_MAX_LINK_PRI)) {
 			l->priority = peers_prio;
 			rc = tipc_link_fsm_evt(l, LINK_FAILURE_EVT);
 		}
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 88cb294dc447..b4fe18228805 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4895,7 +4895,7 @@ sub process {
 				if|for|while|switch|return|case|
 				volatile|__volatile__|
 				__attribute__|format|__extension__|
-				asm|__asm__)$/x)
+				asm|__asm__|scoped_guard)$/x)
 			{
 			# cpp #define statements have non-optional spaces, ie
 			# if there is a space between the name and the open
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index aa108bea6739..4863ee08b7b1 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -7,6 +7,7 @@
  */
 
 #include <crypto/hash_info.h>
+#include <crypto/algapi.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/parser.h>
@@ -241,7 +242,7 @@ int TSS_checkhmac1(unsigned char *buffer,
 	if (ret < 0)
 		goto out;
 
-	if (memcmp(testhmac, authdata, SHA1_DIGEST_SIZE))
+	if (crypto_memneq(testhmac, authdata, SHA1_DIGEST_SIZE))
 		ret = -EINVAL;
 out:
 	kfree_sensitive(sdesc);
@@ -334,7 +335,7 @@ static int TSS_checkhmac2(unsigned char *buffer,
 			  TPM_NONCE_SIZE, ononce, 1, continueflag1, 0, 0);
 	if (ret < 0)
 		goto out;
-	if (memcmp(testhmac1, authdata1, SHA1_DIGEST_SIZE)) {
+	if (crypto_memneq(testhmac1, authdata1, SHA1_DIGEST_SIZE)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -343,7 +344,7 @@ static int TSS_checkhmac2(unsigned char *buffer,
 			  TPM_NONCE_SIZE, ononce, 1, continueflag2, 0, 0);
 	if (ret < 0)
 		goto out;
-	if (memcmp(testhmac2, authdata2, SHA1_DIGEST_SIZE))
+	if (crypto_memneq(testhmac2, authdata2, SHA1_DIGEST_SIZE))
 		ret = -EINVAL;
 out:
 	kfree_sensitive(sdesc);
diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index b5b0d43bb8dc..c3f2717aebf2 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -316,7 +316,7 @@ static int lx_message_send_atomic(struct lx6464es *chip, struct lx_rmh *rmh)
 /* low-level dsp access */
 int lx_dsp_get_version(struct lx6464es *chip, u32 *rdsp_version)
 {
-	u16 ret;
+	int ret;
 
 	mutex_lock(&chip->msg_lock);
 
@@ -330,10 +330,10 @@ int lx_dsp_get_version(struct lx6464es *chip, u32 *rdsp_version)
 
 int lx_dsp_get_clock_frequency(struct lx6464es *chip, u32 *rfreq)
 {
-	u16 ret = 0;
 	u32 freq_raw = 0;
 	u32 freq = 0;
 	u32 frequency = 0;
+	int ret;
 
 	mutex_lock(&chip->msg_lock);
 
diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 765ac2a3e963..440b6a40ba60 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5863,6 +5863,13 @@ static const struct snd_soc_component_driver wcd934x_component_drv = {
 	.set_jack = wcd934x_codec_set_jack,
 };
 
+static void wcd934x_put_device_action(void *data)
+{
+	struct device *dev = data;
+
+	put_device(dev);
+}
+
 static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
 {
 	struct device *dev = &wcd->sdev->dev;
@@ -5883,11 +5890,12 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
 	}
 
 	slim_get_logical_addr(wcd->sidev);
-	wcd->if_regmap = regmap_init_slimbus(wcd->sidev,
+	wcd->if_regmap = devm_regmap_init_slimbus(wcd->sidev,
 				  &wcd934x_ifc_regmap_config);
 	if (IS_ERR(wcd->if_regmap)) {
-		dev_err(dev, "Failed to allocate ifc register map\n");
-		return PTR_ERR(wcd->if_regmap);
+		put_device(&wcd->sidev->dev);
+		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
+				     "Failed to allocate ifc register map\n");
 	}
 
 	of_property_read_u32(dev->parent->of_node, "qcom,dmic-sample-rate",
@@ -5932,6 +5940,10 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(dev, wcd934x_put_device_action, &wcd->sidev->dev);
+	if (ret)
+		return ret;
+
 	/* set default rate 9P6MHz */
 	regmap_update_bits(wcd->regmap, WCD934X_CODEC_RPM_CLK_MCLK_CFG,
 			   WCD934X_CODEC_RPM_CLK_MCLK_CFG_MCLK_MASK,
@@ -5940,19 +5952,15 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
 	memcpy(wcd->tx_chs, wcd934x_tx_chs, sizeof(wcd934x_tx_chs));
 
 	irq = regmap_irq_get_virq(data->irq_data, WCD934X_IRQ_SLIMBUS);
-	if (irq < 0) {
-		dev_err(wcd->dev, "Failed to get SLIM IRQ\n");
-		return irq;
-	}
+	if (irq < 0)
+		return dev_err_probe(wcd->dev, irq, "Failed to get SLIM IRQ\n");
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 					wcd934x_slim_irq_handler,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"slim", wcd);
-	if (ret) {
-		dev_err(dev, "Failed to request slimbus irq\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request slimbus irq\n");
 
 	wcd934x_register_mclk_output(wcd);
 	platform_set_drvdata(pdev, wcd);
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index b5c97d35864a..923e69c7695c 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -46,7 +46,8 @@ enum {
 	BYT_CHT_ES8316_INTMIC_IN2_MAP,
 };
 
-#define BYT_CHT_ES8316_MAP(quirk)		((quirk) & GENMASK(3, 0))
+#define BYT_CHT_ES8316_MAP_MASK			GENMASK(3, 0)
+#define BYT_CHT_ES8316_MAP(quirk)		((quirk) & BYT_CHT_ES8316_MAP_MASK)
 #define BYT_CHT_ES8316_SSP0			BIT(16)
 #define BYT_CHT_ES8316_MONO_SPEAKER		BIT(17)
 #define BYT_CHT_ES8316_JD_INVERTED		BIT(18)
@@ -59,10 +60,23 @@ MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 static void log_quirks(struct device *dev)
 {
-	if (BYT_CHT_ES8316_MAP(quirk) == BYT_CHT_ES8316_INTMIC_IN1_MAP)
+	int map;
+
+	map = BYT_CHT_ES8316_MAP(quirk);
+	switch (map) {
+	case BYT_CHT_ES8316_INTMIC_IN1_MAP:
 		dev_info(dev, "quirk IN1_MAP enabled");
-	if (BYT_CHT_ES8316_MAP(quirk) == BYT_CHT_ES8316_INTMIC_IN2_MAP)
+		break;
+	case BYT_CHT_ES8316_INTMIC_IN2_MAP:
 		dev_info(dev, "quirk IN2_MAP enabled");
+		break;
+	default:
+		dev_warn_once(dev, "quirk sets invalid input map: 0x%x, default to INTMIC_IN1_MAP\n", map);
+		quirk &= ~BYT_CHT_ES8316_MAP_MASK;
+		quirk |= BYT_CHT_ES8316_INTMIC_IN1_MAP;
+		break;
+	}
+
 	if (quirk & BYT_CHT_ES8316_SSP0)
 		dev_info(dev, "quirk SSP0 enabled");
 	if (quirk & BYT_CHT_ES8316_MONO_SPEAKER)
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 4954e8c494c6..0c7da72a7b84 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -65,7 +65,8 @@ enum {
 	BYT_RT5640_OVCD_SF_1P5		= (RT5640_OVCD_SF_1P5 << 13),
 };
 
-#define BYT_RT5640_MAP(quirk)		((quirk) &  GENMASK(3, 0))
+#define BYT_RT5640_MAP_MASK		GENMASK(3, 0)
+#define BYT_RT5640_MAP(quirk)		((quirk) & BYT_RT5640_MAP_MASK)
 #define BYT_RT5640_JDSRC(quirk)		(((quirk) & GENMASK(7, 4)) >> 4)
 #define BYT_RT5640_OVCD_TH(quirk)	(((quirk) & GENMASK(12, 8)) >> 8)
 #define BYT_RT5640_OVCD_SF(quirk)	(((quirk) & GENMASK(14, 13)) >> 13)
@@ -134,7 +135,9 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk NO_INTERNAL_MIC_MAP enabled\n");
 		break;
 	default:
-		dev_err(dev, "quirk map 0x%x is not supported, microphone input will not work\n", map);
+		dev_warn_once(dev, "quirk sets invalid input map: 0x%x, default to DMIC1_MAP\n", map);
+		byt_rt5640_quirk &= ~BYT_RT5640_MAP_MASK;
+		byt_rt5640_quirk |= BYT_RT5640_DMIC1_MAP;
 		break;
 	}
 	if (byt_rt5640_quirk & BYT_RT5640_HSMIC2_ON_IN1)
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 93cec4d91627..b0b41a03c083 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -58,7 +58,8 @@ enum {
 	BYT_RT5651_OVCD_SF_1P5	= (RT5651_OVCD_SF_1P5 << 13),
 };
 
-#define BYT_RT5651_MAP(quirk)		((quirk) & GENMASK(3, 0))
+#define BYT_RT5651_MAP_MASK		GENMASK(3, 0)
+#define BYT_RT5651_MAP(quirk)		((quirk) & BYT_RT5651_MAP_MASK)
 #define BYT_RT5651_JDSRC(quirk)		(((quirk) & GENMASK(7, 4)) >> 4)
 #define BYT_RT5651_OVCD_TH(quirk)	(((quirk) & GENMASK(12, 8)) >> 8)
 #define BYT_RT5651_OVCD_SF(quirk)	(((quirk) & GENMASK(14, 13)) >> 13)
@@ -100,14 +101,29 @@ MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 static void log_quirks(struct device *dev)
 {
-	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_DMIC_MAP)
+	int map;
+
+	map = BYT_RT5651_MAP(byt_rt5651_quirk);
+	switch (map) {
+	case BYT_RT5651_DMIC_MAP:
 		dev_info(dev, "quirk DMIC_MAP enabled");
-	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_MAP)
+		break;
+	case BYT_RT5651_IN1_MAP:
 		dev_info(dev, "quirk IN1_MAP enabled");
-	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN2_MAP)
+		break;
+	case BYT_RT5651_IN2_MAP:
 		dev_info(dev, "quirk IN2_MAP enabled");
-	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_IN2_MAP)
+		break;
+	case BYT_RT5651_IN1_IN2_MAP:
 		dev_info(dev, "quirk IN1_IN2_MAP enabled");
+		break;
+	default:
+		dev_warn_once(dev, "quirk sets invalid input map: 0x%x, default to DMIC_MAP\n", map);
+		byt_rt5651_quirk &= ~BYT_RT5651_MAP_MASK;
+		byt_rt5651_quirk |= BYT_RT5651_DMIC_MAP;
+		break;
+	}
+
 	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
 		dev_info(dev, "quirk realtek,jack-detect-source %ld\n",
 			 BYT_RT5651_JDSRC(byt_rt5651_quirk));
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index aa3b0d75e44b..37aa85a81e0a 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -268,10 +268,10 @@ $(OUTPUT)test-libbabeltrace.bin:
 	$(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace)
 
 $(OUTPUT)test-compile-32.bin:
-	$(CC) -m32 -o $@ test-compile.c
+	$(CC) -m32 -Wall -Werror -o $@ test-compile.c
 
 $(OUTPUT)test-compile-x32.bin:
-	$(CC) -mx32 -o $@ test-compile.c
+	$(CC) -mx32 -Wall -Werror -o $@ test-compile.c
 
 $(OUTPUT)test-zlib.bin:
 	$(BUILD) -lz
diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index a0ea830e1ba1..f9eccd40c221 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -46,6 +46,6 @@ typedef unsigned long       nlink_t;
 typedef   signed long         off_t;
 typedef   signed long     blksize_t;
 typedef   signed long      blkcnt_t;
-typedef __kernel_old_time_t  time_t;
+typedef __kernel_time_t      time_t;
 
 #endif /* _NOLIBC_STD_H */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 13dea519e59f..d9589c92e05d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4485,6 +4485,16 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 		return false;
 	}
 
+	/*
+	 * bpf_get_map_info_by_fd() for DEVMAP will always return flags with
+	 * BPF_F_RDONLY_PROG set, but it generally is not set at map creation time.
+	 * Thus, ignore the BPF_F_RDONLY_PROG flag in the flags returned from
+	 * bpf_get_map_info_by_fd() when checking for compatibility with an
+	 * existing DEVMAP.
+	 */
+	if (map->def.type == BPF_MAP_TYPE_DEVMAP || map->def.type == BPF_MAP_TYPE_DEVMAP_HASH)
+		map_info.map_flags &= ~BPF_F_RDONLY_PROG;
+
 	return (map_info.type == map->def.type &&
 		map_info.key_size == map->def.key_size &&
 		map_info.value_size == map->def.value_size &&
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 4d0c02ba3f7d..1187415e2699 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -211,6 +211,7 @@ struct perf_record_header_event_type {
 struct perf_record_header_tracing_data {
 	struct perf_event_header header;
 	__u32			 size;
+	__u32			 pad;
 };
 
 #define PERF_RECORD_MISC_BUILD_ID_SIZE (1 << 15)
diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index 42f57b640f11..687307f2fe0f 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -72,6 +72,9 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 	size_t ci, cj, ei;
 	int cmp;
 
+	if (!excludes->cnt)
+		return;
+
 	ci = cj = ei = 0;
 	while (ci < cmds->cnt && ei < excludes->cnt) {
 		cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 0df471bf1590..b215e89b65f7 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -115,6 +115,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	if (err < 0) {
 		pr_debug("sched__get_first_possible_cpu: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -126,6 +127,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, &cpu_mask) < 0) {
 		pr_debug("sched_setaffinity: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -137,6 +139,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	if (err < 0) {
 		pr_debug("perf_evlist__open: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -149,6 +152,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	if (err < 0) {
 		pr_debug("evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f14c83e6829a..a9cb1aede476 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2930,6 +2930,8 @@ bool evsel__is_hybrid(struct evsel *evsel)
 
 struct evsel *evsel__leader(struct evsel *evsel)
 {
+	if (evsel->core.leader == NULL)
+		return NULL;
 	return container_of(evsel->core.leader, struct evsel, core);
 }
 
diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index 51424cdc3b68..aa9a0ebc1f93 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -115,7 +115,7 @@ bool lzma_is_compressed(const char *input)
 	ssize_t rc;
 
 	if (fd < 0)
-		return -1;
+		return false;
 
 	rc = read(fd, buf, sizeof(buf));
 	close(fd);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 562e9b808027..0ecfda9d9f8b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1598,7 +1598,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	struct perf_tool *tool = session->tool;
 	struct perf_sample sample = { .time = 0, };
 	int fd = perf_data__fd(session->data);
-	int err;
+	s64 err;
 
 	if (event->header.type != PERF_RECORD_COMPRESSED ||
 	    tool->compressed == perf_session__process_compressed_event_stub)
diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index 78d2297c1b67..1f7c06523059 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -88,7 +88,7 @@ bool gzip_is_compressed(const char *input)
 	ssize_t rc;
 
 	if (fd < 0)
-		return -1;
+		return false;
 
 	rc = read(fd, buf, sizeof(buf));
 	close(fd);
diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 6862915f1fb0..d60c305c7ebd 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -981,11 +981,22 @@ static int ndtest_probe(struct platform_device *pdev)
 
 	p->dcr_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
 				 sizeof(dma_addr_t), GFP_KERNEL);
+	if (!p->dcr_dma) {
+		rc = -ENOMEM;
+		goto err;
+	}
 	p->label_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
 				   sizeof(dma_addr_t), GFP_KERNEL);
+	if (!p->label_dma) {
+		rc = -ENOMEM;
+		goto err;
+	}
 	p->dimm_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
 				  sizeof(dma_addr_t), GFP_KERNEL);
-
+	if (!p->dimm_dma) {
+		rc = -ENOMEM;
+		goto err;
+	}
 	rc = ndtest_nvdimm_init(p);
 	if (rc)
 		goto err;
diff --git a/tools/testing/selftests/arm64/pauth/exec_target.c b/tools/testing/selftests/arm64/pauth/exec_target.c
index 4435600ca400..e597861b26d6 100644
--- a/tools/testing/selftests/arm64/pauth/exec_target.c
+++ b/tools/testing/selftests/arm64/pauth/exec_target.c
@@ -13,7 +13,12 @@ int main(void)
 	unsigned long hwcaps;
 	size_t val;
 
-	fread(&val, sizeof(size_t), 1, stdin);
+	size_t size = fread(&val, sizeof(size_t), 1, stdin);
+
+	if (size != 1) {
+		fprintf(stderr, "Could not read input from stdin\n");
+		return EXIT_FAILURE;
+	}
 
 	/* don't try to execute illegal (unimplemented) instructions) caller
 	 * should have checked this and keep worker simple
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 06634417e3c4..2cf9bb39b22b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1826,6 +1826,16 @@ deny_join_id0_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and address allow join id0 2" 1 1 1
+
+	# default limits, server deny join id 0 + signal
+	reset_with_allow_join_id0 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "default limits, server deny join id 0" 2 2 2
 }
 
 fullmesh_tests()
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index e20191fb40d4..036b03aaedc3 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -38,9 +38,9 @@
  * Define weak versions to play nice with binaries that are statically linked
  * against a libc that doesn't support registering its own rseq.
  */
-__weak ptrdiff_t __rseq_offset;
-__weak unsigned int __rseq_size;
-__weak unsigned int __rseq_flags;
+extern __weak ptrdiff_t __rseq_offset;
+extern __weak unsigned int __rseq_size;
+extern __weak unsigned int __rseq_flags;
 
 static const ptrdiff_t *libc_rseq_offset_p = &__rseq_offset;
 static const unsigned int *libc_rseq_size_p = &__rseq_size;
@@ -124,7 +124,7 @@ void rseq_init(void)
 	 * libc not having registered a restartable sequence.  Try to find the
 	 * symbols if that's the case.
 	 */
-	if (!*libc_rseq_size_p) {
+	if (!libc_rseq_size_p || !*libc_rseq_size_p) {
 		libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
 		libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
 		libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");
diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
index 58775dab3cc6..92fb74865f26 100644
--- a/tools/testing/selftests/vm/mremap_test.c
+++ b/tools/testing/selftests/vm/mremap_test.c
@@ -22,7 +22,9 @@
 #define VALIDATION_DEFAULT_THRESHOLD 4	/* 4MB */
 #define VALIDATION_NO_THRESHOLD 0	/* Verify the entire region */
 
+#ifndef MIN
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#endif
 
 struct config {
 	unsigned long long src_alignment;
diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index 09773695d219..4056706d63f7 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -240,6 +240,12 @@ int main(int argc, char *argv[])
 	if (oneshot)
 		goto end;
 
+	/* Check if WDIOF_KEEPALIVEPING is supported */
+	if (!(info.options & WDIOF_KEEPALIVEPING)) {
+		printf("WDIOC_KEEPALIVE not supported by this device\n");
+		goto end;
+	}
+
 	printf("Watchdog Ticking Away!\n");
 
 	/*

