Return-Path: <stable+bounces-187906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEF5BEE80C
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 17:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FEEA4E6A3E
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 15:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478D62EB874;
	Sun, 19 Oct 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t0ggevx4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F682EAB63;
	Sun, 19 Oct 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760886130; cv=none; b=KJiLU6ypOzdw54+saO4zfBxykG3sTQVvLWqevdNZqvd2Hvm6FHFzr4IV+CSIhknxcBA60UEdjAavTCvo6LHCVCJyC5iuwGVOEWcGimshiJcR4tBOkya7JNRiDlbrFKPOEfedLo//0N+EGRVASQ9z8GbrVP82nGw00KyY6wWIbd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760886130; c=relaxed/simple;
	bh=kCVLbPHG4RYocA7k1VTyKPSKoRWeDVGrocY2eAQ7TEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aalbtfOKaOqemCWxOguBnxBOmCuFedL6VdSNrP9JZvwJlSF0LGOdlp6VvvGySXNtYPW3dEwDH4tzFSTRiGlNi2zul4VLX4YNvY2PUoYMBESnabvQ6utS9RGqYIEWWW0kryGOn3vVKrOAVpX6Bub3A0WBEmlux4vxtBrvhfn0Ht0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t0ggevx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74A5C4CEE7;
	Sun, 19 Oct 2025 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760886127;
	bh=kCVLbPHG4RYocA7k1VTyKPSKoRWeDVGrocY2eAQ7TEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t0ggevx4UAeXoHe48N1JwgNw1w6ECn2ToXf/jPS9kmFpQ+lNCMVcyWAmgLqwIdBeA
	 e2FdJT4TnT/HDjNS5e4j0WnHKSqbveJu5GE90sUmdcTZ6uzJWxV3mgHRiwz7uL5KVP
	 jViqiljA6fG8cISBVsKUHugTPVL4r54aR+LH4YXE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.54
Date: Sun, 19 Oct 2025 17:01:57 +0200
Message-ID: <2025101957-frosted-hunger-9e44@gregkh>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <2025101956-stopwatch-festivity-c7a3@gregkh>
References: <2025101956-stopwatch-festivity-c7a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8724c2c580b8..e88505e945d5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5923,6 +5923,9 @@
 
 	rootflags=	[KNL] Set root filesystem mount option string
 
+	initramfs_options= [KNL]
+                        Specify mount options for for the initramfs mount.
+
 	rootfstype=	[KNL] Set root filesystem type
 
 	rootwait	[KNL] Wait (indefinitely) for root device to show up.
diff --git a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
index 5ac994b3c0aa..b304bc5a08c4 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
@@ -57,11 +57,24 @@ required:
   - clocks
   - clock-names
   - '#phy-cells'
-  - power-domains
   - resets
   - reset-names
   - rockchip,grf
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,px30-csi-dphy
+              - rockchip,rk1808-csi-dphy
+              - rockchip,rk3326-csi-dphy
+              - rockchip,rk3368-csi-dphy
+    then:
+      required:
+        - power-domains
+
 additionalProperties: false
 
 examples:
diff --git a/Makefile b/Makefile
index a4a2228276e6..0c6deb33c239 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 53
+SUBLEVEL = 54
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/mach-omap2/am33xx-restart.c b/arch/arm/mach-omap2/am33xx-restart.c
index fcf3d557aa78..3cdf223addcc 100644
--- a/arch/arm/mach-omap2/am33xx-restart.c
+++ b/arch/arm/mach-omap2/am33xx-restart.c
@@ -2,12 +2,46 @@
 /*
  * am33xx-restart.c - Code common to all AM33xx machines.
  */
+#include <dt-bindings/pinctrl/am33xx.h>
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/reboot.h>
 
 #include "common.h"
+#include "control.h"
 #include "prm.h"
 
+/*
+ * Advisory 1.0.36 EMU0 and EMU1: Terminals Must be Pulled High Before
+ * ICEPick Samples
+ *
+ * If EMU0/EMU1 pins have been used as GPIO outputs and actively driving low
+ * level, the device might not reboot in normal mode. We are in a bad position
+ * to override GPIO state here, so just switch the pins into EMU input mode
+ * (that's what reset will do anyway) and wait a bit, because the state will be
+ * latched 190 ns after reset.
+ */
+static void am33xx_advisory_1_0_36(void)
+{
+	u32 emu0 = omap_ctrl_readl(AM335X_PIN_EMU0);
+	u32 emu1 = omap_ctrl_readl(AM335X_PIN_EMU1);
+
+	/* If both pins are in EMU mode, nothing to do */
+	if (!(emu0 & 7) && !(emu1 & 7))
+		return;
+
+	/* Switch GPIO3_7/GPIO3_8 into EMU0/EMU1 modes respectively */
+	omap_ctrl_writel(emu0 & ~7, AM335X_PIN_EMU0);
+	omap_ctrl_writel(emu1 & ~7, AM335X_PIN_EMU1);
+
+	/*
+	 * Give pull-ups time to load the pin/PCB trace capacity.
+	 * 5 ms shall be enough to load 1 uF (would be huge capacity for these
+	 * pins) with TI-recommended 4k7 external pull-ups.
+	 */
+	mdelay(5);
+}
+
 /**
  * am33xx_restart - trigger a software restart of the SoC
  * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
@@ -18,6 +52,8 @@
  */
 void am33xx_restart(enum reboot_mode mode, const char *cmd)
 {
+	am33xx_advisory_1_0_36();
+
 	/* TODO: Handle cmd if necessary */
 	prm_reboot_mode = mode;
 
diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index c907478be196..4abb86dc98fd 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -388,12 +388,15 @@ static int __init amx3_idle_init(struct device_node *cpu_node, int cpu)
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
 
@@ -403,6 +406,7 @@ static int __init amx3_idle_init(struct device_node *cpu_node, int cpu)
 			states[state_count].wfi_flags |= WFI_FLAG_WAKE_M3 |
 							 WFI_FLAG_FLUSH_CACHE;
 
+		of_node_put(state_node);
 		state_count++;
 	}
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 800bfe83dbf8..b0f1c1b2e6f3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1540,6 +1540,8 @@ mdss: display-subsystem@1a00000 {
 
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 
+			resets = <&gcc GCC_MDSS_BCR>;
+
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index effa3aaeb250..39493f75c0dc 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -1218,6 +1218,8 @@ mdss: display-subsystem@1a00000 {
 
 			power-domains = <&gcc MDSS_GDSC>;
 
+			resets = <&gcc GCC_MDSS_BCR>;
+
 			#address-cells = <1>;
 			#size-cells = <1>;
 			#interrupt-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9bf7a405a964..54956ae1f674 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5365,11 +5365,11 @@ slimbam: dma-controller@17184000 {
 			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
 			qcom,controlled-remotely;
 			reg = <0 0x17184000 0 0x2a000>;
-			num-channels = <31>;
+			num-channels = <23>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <1>;
-			qcom,num-ees = <2>;
+			qcom,num-ees = <4>;
 			iommus = <&apps_smmu 0x1806 0x0>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
index 5b54ee79f048..9986a10ae006 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
@@ -475,6 +475,8 @@ pm8010: pmic@c {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		status = "disabled";
+
 		pm8010_temp_alarm: temp-alarm@2400 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0x2400>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 45d68a0d1b59..c4857bfbeb14 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -258,7 +258,7 @@ secure_proxy_sa3: mailbox@43600000 {
 
 	main_pmx0: pinctrl@f4000 {
 		compatible = "pinctrl-single";
-		reg = <0x00 0xf4000 0x00 0x2ac>;
+		reg = <0x00 0xf4000 0x00 0x25c>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9ca5ffd8d817..5e68d65e675e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2279,17 +2279,21 @@ static void bti_enable(const struct arm64_cpu_capabilities *__unused)
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
-	if (try_page_mte_tagging(ZERO_PAGE(0))) {
+	if (!cleared_zero_page) {
+		cleared_zero_page = true;
 		mte_clear_page_tags(lm_alias(empty_zero_page));
-		set_page_mte_tagged(ZERO_PAGE(0));
 	}
 
 	kasan_init_hw_tags_cpu();
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 6174671be7c1..5d63ca966737 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -428,7 +428,8 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 			put_page(page);
 			break;
 		}
-		WARN_ON_ONCE(!page_mte_tagged(page));
+
+		WARN_ON_ONCE(!page_mte_tagged(page) && !is_zero_page(page));
 
 		/* limit access to the end of the page */
 		offset = offset_in_page(addr);
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index e57b043f324b..adec61b8b278 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -78,6 +78,12 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 	twopass |= enable_scs;
 	prot = twopass ? data_prot : text_prot;
 
+	/*
+	 * [_stext, _text) isn't executed after boot and contains some
+	 * non-executable, unpredictable data, so map it non-executable.
+	 */
+	map_segment(init_pg_dir, &pgdp, va_offset, _text, _stext, data_prot,
+		    false, root_level);
 	map_segment(init_pg_dir, &pgdp, va_offset, _stext, _etext, prot,
 		    !twopass, root_level);
 	map_segment(init_pg_dir, &pgdp, va_offset, __start_rodata,
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 4268678d0e86..6e397d8dcd4c 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "kprobes: " fmt
 
+#include <linux/execmem.h>
 #include <linux/extable.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
@@ -41,6 +42,17 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 static void __kprobes
 post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
 
+void *alloc_insn_page(void)
+{
+	void *addr;
+
+	addr = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
+	if (!addr)
+		return NULL;
+	set_memory_rox((unsigned long)addr, 1);
+	return addr;
+}
+
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
 	kprobe_opcode_t *addr = p->ainsn.api.insn;
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 87f61fd6783c..8185979f0f11 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -213,7 +213,7 @@ static void __init request_standard_resources(void)
 	unsigned long i = 0;
 	size_t res_size;
 
-	kernel_code.start   = __pa_symbol(_stext);
+	kernel_code.start   = __pa_symbol(_text);
 	kernel_code.end     = __pa_symbol(__init_begin - 1);
 	kernel_data.start   = __pa_symbol(_sdata);
 	kernel_data.end     = __pa_symbol(_end - 1);
@@ -281,7 +281,7 @@ u64 cpu_logical_map(unsigned int cpu)
 
 void __init __no_sanitize_address setup_arch(char **cmdline_p)
 {
-	setup_initial_init_mm(_stext, _etext, _edata, _end);
+	setup_initial_init_mm(_text, _etext, _edata, _end);
 
 	*cmdline_p = boot_command_line;
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 93ba66de160c..c59aa6df14db 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -300,7 +300,7 @@ void __init arm64_memblock_init(void)
 	 * Register the kernel text, kernel data, initrd, and initial
 	 * pagetables with memblock.
 	 */
-	memblock_reserve(__pa_symbol(_stext), _end - _stext);
+	memblock_reserve(__pa_symbol(_text), _end - _text);
 	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
 		/* the generic initrd code expects virtual addresses */
 		initrd_start = __phys_to_virt(phys_initrd_start);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index aed8d32979d9..ea80e271301e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -561,8 +561,8 @@ void __init mark_linear_text_alias_ro(void)
 	/*
 	 * Remove the write permissions from the linear alias of .text/.rodata
 	 */
-	update_mapping_prot(__pa_symbol(_stext), (unsigned long)lm_alias(_stext),
-			    (unsigned long)__init_begin - (unsigned long)_stext,
+	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
+			    (unsigned long)__init_begin - (unsigned long)_text,
 			    PAGE_KERNEL_RO);
 }
 
@@ -623,7 +623,7 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
 static void __init map_mem(pgd_t *pgdp)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
-	phys_addr_t kernel_start = __pa_symbol(_stext);
+	phys_addr_t kernel_start = __pa_symbol(_text);
 	phys_addr_t kernel_end = __pa_symbol(__init_begin);
 	phys_addr_t start, end;
 	phys_addr_t early_kfence_pool;
@@ -670,7 +670,7 @@ static void __init map_mem(pgd_t *pgdp)
 	}
 
 	/*
-	 * Map the linear alias of the [_stext, __init_begin) interval
+	 * Map the linear alias of the [_text, __init_begin) interval
 	 * as non-executable now, and remove the write permission in
 	 * mark_linear_text_alias_ro() below (which will be called after
 	 * alternative patching has completed). This makes the contents
@@ -697,6 +697,10 @@ void mark_rodata_ro(void)
 	WRITE_ONCE(rodata_is_rw, false);
 	update_mapping_prot(__pa_symbol(__start_rodata), (unsigned long)__start_rodata,
 			    section_size, PAGE_KERNEL_RO);
+	/* mark the range between _text and _stext as read only. */
+	update_mapping_prot(__pa_symbol(_text), (unsigned long)_text,
+			    (unsigned long)_stext - (unsigned long)_text,
+			    PAGE_KERNEL_RO);
 }
 
 static void __init declare_vma(struct vm_struct *vma,
@@ -767,7 +771,7 @@ static void __init declare_kernel_vmas(void)
 {
 	static struct vm_struct vmlinux_seg[KERNEL_SEGMENT_COUNT];
 
-	declare_vma(&vmlinux_seg[0], _stext, _etext, VM_NO_GUARD);
+	declare_vma(&vmlinux_seg[0], _text, _etext, VM_NO_GUARD);
 	declare_vma(&vmlinux_seg[1], __start_rodata, __inittext_begin, VM_NO_GUARD);
 	declare_vma(&vmlinux_seg[2], __inittext_begin, __inittext_end, VM_NO_GUARD);
 	declare_vma(&vmlinux_seg[3], __initdata_begin, __initdata_end, VM_NO_GUARD);
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 567bd122a9ee..c14ae21075c5 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -114,7 +114,7 @@ KBUILD_RUSTFLAGS_KERNEL		+= -Crelocation-model=pie
 LDFLAGS_vmlinux			+= -static -pie --no-dynamic-linker -z notext $(call ld-option, --apply-dynamic-relocs)
 endif
 
-cflags-y += $(call cc-option, -mno-check-zero-division)
+cflags-y += $(call cc-option, -mno-check-zero-division -fno-isolate-erroneous-paths-dereference)
 
 ifndef CONFIG_KASAN
 cflags-y += -fno-builtin-memcpy -fno-builtin-memmove -fno-builtin-memset
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 1fa6a604734e..2ceb198ae8c8 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -354,6 +354,7 @@ void __init platform_init(void)
 
 #ifdef CONFIG_ACPI
 	acpi_table_upgrade();
+	acpi_gbl_use_global_lock = false;
 	acpi_gbl_use_default_register_widths = false;
 	acpi_boot_table_init();
 #endif
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
diff --git a/arch/parisc/lib/memcpy.c b/arch/parisc/lib/memcpy.c
index 69d65ffab312..03165c82dfdb 100644
--- a/arch/parisc/lib/memcpy.c
+++ b/arch/parisc/lib/memcpy.c
@@ -41,7 +41,6 @@ unsigned long raw_copy_from_user(void *dst, const void __user *src,
 	mtsp(get_kernel_space(), SR_TEMP2);
 
 	/* Check region is user accessible */
-	if (start)
 	while (start < end) {
 		if (!prober_user(SR_TEMP1, start)) {
 			newlen = (start - (unsigned long) src);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b0a14e48175c..4d938c1bfdd3 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1897,7 +1897,7 @@ static int pnv_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	return 0;
 
 out:
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 	msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq, nr_irqs);
 	return ret;
 }
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index ba98a680a12e..169859df1aa9 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -592,7 +592,7 @@ static int pseries_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 
 out:
 	/* TODO: handle RTAS cleanup in ->msi_finish() ? */
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 	return ret;
 }
 
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 5b97af311709..f949f7e1000c 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -25,6 +25,7 @@ endif
 KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -mpacked-stack -std=gnu11
 KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -D__DECOMPRESSOR
+KBUILD_CFLAGS_DECOMPRESSOR += -Wno-pointer-sign
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float -mbackchain
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS_DECOMPRESSOR += -ffreestanding
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index ff1ddba96352..0d18d3267bc4 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -202,6 +202,33 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);
 	_end = . ;
 
+	/* Debugging sections.	*/
+	STABS_DEBUG
+	DWARF_DEBUG
+	ELF_DETAILS
+
+	/*
+	 * Make sure that the .got.plt is either completely empty or it
+	 * contains only the three reserved double words.
+	 */
+	.got.plt : {
+		*(.got.plt)
+	}
+	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
+
+	/*
+	 * Sections that should stay zero sized, which is safer to
+	 * explicitly check instead of blindly discarding.
+	 */
+	.plt : {
+		*(.plt) *(.plt.*) *(.iplt) *(.igot .igot.plt)
+	}
+	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+	.rela.dyn : {
+		*(.rela.*) *(.rela_*)
+	}
+	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
+
 	/*
 	 * uncompressed image info used by the decompressor
 	 * it should match struct vmlinux_info
@@ -232,33 +259,6 @@ SECTIONS
 #endif
 	} :NONE
 
-	/* Debugging sections.	*/
-	STABS_DEBUG
-	DWARF_DEBUG
-	ELF_DETAILS
-
-	/*
-	 * Make sure that the .got.plt is either completely empty or it
-	 * contains only the three reserved double words.
-	 */
-	.got.plt : {
-		*(.got.plt)
-	}
-	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
-
-	/*
-	 * Sections that should stay zero sized, which is safer to
-	 * explicitly check instead of blindly discarding.
-	 */
-	.plt : {
-		*(.plt) *(.plt.*) *(.iplt) *(.igot .igot.plt)
-	}
-	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
-	.rela.dyn : {
-		*(.rela.*) *(.rela_*)
-	}
-	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
-
 	/* Sections to be discarded */
 	DISCARDS
 	/DISCARD/ : {
diff --git a/arch/s390/net/bpf_jit.h b/arch/s390/net/bpf_jit.h
deleted file mode 100644
index 7822ea92e54a..000000000000
--- a/arch/s390/net/bpf_jit.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * BPF Jit compiler defines
- *
- * Copyright IBM Corp. 2012,2015
- *
- * Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
- *	      Michael Holzheu <holzheu@linux.vnet.ibm.com>
- */
-
-#ifndef __ARCH_S390_NET_BPF_JIT_H
-#define __ARCH_S390_NET_BPF_JIT_H
-
-#ifndef __ASSEMBLY__
-
-#include <linux/filter.h>
-#include <linux/types.h>
-
-#endif /* __ASSEMBLY__ */
-
-/*
- * Stackframe layout (packed stack):
- *
- *				    ^ high
- *	      +---------------+     |
- *	      | old backchain |     |
- *	      +---------------+     |
- *	      |   r15 - r6    |     |
- *	      +---------------+     |
- *	      | 4 byte align  |     |
- *	      | tail_call_cnt |     |
- * BFP	   -> +===============+     |
- *	      |		      |     |
- *	      |   BPF stack   |     |
- *	      |		      |     |
- * R15+160 -> +---------------+     |
- *	      | new backchain |     |
- * R15+152 -> +---------------+     |
- *	      | + 152 byte SA |     |
- * R15	   -> +---------------+     + low
- *
- * We get 160 bytes stack space from calling function, but only use
- * 12 * 8 byte for old backchain, r15..r6, and tail_call_cnt.
- *
- * The stack size used by the BPF program ("BPF stack" above) is passed
- * via "aux->stack_depth".
- */
-#define STK_SPACE_ADD	(160)
-#define STK_160_UNUSED	(160 - 12 * 8)
-#define STK_OFF		(STK_SPACE_ADD - STK_160_UNUSED)
-
-#define STK_OFF_R6	(160 - 11 * 8)	/* Offset of r6 on stack */
-#define STK_OFF_TCCNT	(160 - 12 * 8)	/* Offset of tail_call_cnt on stack */
-
-#endif /* __ARCH_S390_NET_BPF_JIT_H */
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index ead8d9ba9032..f305cb42070d 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -32,7 +32,6 @@
 #include <asm/set_memory.h>
 #include <asm/text-patching.h>
 #include <asm/unwind.h>
-#include "bpf_jit.h"
 
 struct bpf_jit {
 	u32 seen;		/* Flags to remember seen eBPF instructions */
@@ -56,6 +55,7 @@ struct bpf_jit {
 	int prologue_plt;	/* Start of prologue hotpatch PLT */
 	int kern_arena;		/* Pool offset of kernel arena address */
 	u64 user_arena;		/* User arena address */
+	u32 frame_off;		/* Offset of struct bpf_prog from %r15 */
 };
 
 #define SEEN_MEM	BIT(0)		/* use mem[] for temporary storage */
@@ -403,12 +403,26 @@ static void jit_fill_hole(void *area, unsigned int size)
 	memset(area, 0, size);
 }
 
+/*
+ * Caller-allocated part of the frame.
+ * Thanks to packed stack, its otherwise unused initial part can be used for
+ * the BPF stack and for the next frame.
+ */
+struct prog_frame {
+	u64 unused[8];
+	/* BPF stack starts here and grows towards 0 */
+	u32 tail_call_cnt;
+	u32 pad;
+	u64 r6[10];  /* r6 - r15 */
+	u64 backchain;
+} __packed;
+
 /*
  * Save registers from "rs" (register start) to "re" (register end) on stack
  */
 static void save_regs(struct bpf_jit *jit, u32 rs, u32 re)
 {
-	u32 off = STK_OFF_R6 + (rs - 6) * 8;
+	u32 off = offsetof(struct prog_frame, r6) + (rs - 6) * 8;
 
 	if (rs == re)
 		/* stg %rs,off(%r15) */
@@ -421,12 +435,9 @@ static void save_regs(struct bpf_jit *jit, u32 rs, u32 re)
 /*
  * Restore registers from "rs" (register start) to "re" (register end) on stack
  */
-static void restore_regs(struct bpf_jit *jit, u32 rs, u32 re, u32 stack_depth)
+static void restore_regs(struct bpf_jit *jit, u32 rs, u32 re)
 {
-	u32 off = STK_OFF_R6 + (rs - 6) * 8;
-
-	if (jit->seen & SEEN_STACK)
-		off += STK_OFF + stack_depth;
+	u32 off = jit->frame_off + offsetof(struct prog_frame, r6) + (rs - 6) * 8;
 
 	if (rs == re)
 		/* lg %rs,off(%r15) */
@@ -470,8 +481,7 @@ static int get_end(u16 seen_regs, int start)
  * Save and restore clobbered registers (6-15) on stack.
  * We save/restore registers in chunks with gap >= 2 registers.
  */
-static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth,
-			      u16 extra_regs)
+static void save_restore_regs(struct bpf_jit *jit, int op, u16 extra_regs)
 {
 	u16 seen_regs = jit->seen_regs | extra_regs;
 	const int last = 15, save_restore_size = 6;
@@ -494,7 +504,7 @@ static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth,
 		if (op == REGS_SAVE)
 			save_regs(jit, rs, re);
 		else
-			restore_regs(jit, rs, re, stack_depth);
+			restore_regs(jit, rs, re);
 		re++;
 	} while (re <= last);
 }
@@ -559,11 +569,12 @@ static void bpf_jit_plt(struct bpf_plt *plt, void *ret, void *target)
  * Emit function prologue
  *
  * Save registers and create stack frame if necessary.
- * See stack frame layout description in "bpf_jit.h"!
+ * Stack frame layout is described by struct prog_frame.
  */
-static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
-			     u32 stack_depth)
+static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp)
 {
+	BUILD_BUG_ON(sizeof(struct prog_frame) != STACK_FRAME_OVERHEAD);
+
 	/* No-op for hotpatching */
 	/* brcl 0,prologue_plt */
 	EMIT6_PCREL_RILC(0xc0040000, 0, jit->prologue_plt);
@@ -571,8 +582,9 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 
 	if (!bpf_is_subprog(fp)) {
 		/* Initialize the tail call counter in the main program. */
-		/* xc STK_OFF_TCCNT(4,%r15),STK_OFF_TCCNT(%r15) */
-		_EMIT6(0xd703f000 | STK_OFF_TCCNT, 0xf000 | STK_OFF_TCCNT);
+		/* xc tail_call_cnt(4,%r15),tail_call_cnt(%r15) */
+		_EMIT6(0xd703f000 | offsetof(struct prog_frame, tail_call_cnt),
+		       0xf000 | offsetof(struct prog_frame, tail_call_cnt));
 	} else {
 		/*
 		 * Skip the tail call counter initialization in subprograms.
@@ -595,7 +607,7 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 		jit->seen_regs |= NVREGS;
 	} else {
 		/* Save registers */
-		save_restore_regs(jit, REGS_SAVE, stack_depth,
+		save_restore_regs(jit, REGS_SAVE,
 				  fp->aux->exception_boundary ? NVREGS : 0);
 	}
 	/* Setup literal pool */
@@ -615,13 +627,15 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 	if (is_first_pass(jit) || (jit->seen & SEEN_STACK)) {
 		/* lgr %w1,%r15 (backchain) */
 		EMIT4(0xb9040000, REG_W1, REG_15);
-		/* la %bfp,STK_160_UNUSED(%r15) (BPF frame pointer) */
-		EMIT4_DISP(0x41000000, BPF_REG_FP, REG_15, STK_160_UNUSED);
-		/* aghi %r15,-STK_OFF */
-		EMIT4_IMM(0xa70b0000, REG_15, -(STK_OFF + stack_depth));
-		/* stg %w1,152(%r15) (backchain) */
+		/* la %bfp,unused_end(%r15) (BPF frame pointer) */
+		EMIT4_DISP(0x41000000, BPF_REG_FP, REG_15,
+			   offsetofend(struct prog_frame, unused));
+		/* aghi %r15,-frame_off */
+		EMIT4_IMM(0xa70b0000, REG_15, -jit->frame_off);
+		/* stg %w1,backchain(%r15) */
 		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W1, REG_0,
-			      REG_15, 152);
+			      REG_15,
+			      offsetof(struct prog_frame, backchain));
 	}
 }
 
@@ -665,13 +679,13 @@ static void call_r1(struct bpf_jit *jit)
 /*
  * Function epilogue
  */
-static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
+static void bpf_jit_epilogue(struct bpf_jit *jit)
 {
 	jit->exit_ip = jit->prg;
 	/* Load exit code: lgr %r2,%b0 */
 	EMIT4(0xb9040000, REG_2, BPF_REG_0);
 	/* Restore registers */
-	save_restore_regs(jit, REGS_RESTORE, stack_depth, 0);
+	save_restore_regs(jit, REGS_RESTORE, 0);
 	if (nospec_uses_trampoline()) {
 		jit->r14_thunk_ip = jit->prg;
 		/* Generate __s390_indirect_jump_r14 thunk */
@@ -862,7 +876,7 @@ static int sign_extend(struct bpf_jit *jit, int r, u8 size, u8 flags)
  * stack space for the large switch statement.
  */
 static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
-				 int i, bool extra_pass, u32 stack_depth)
+				 int i, bool extra_pass)
 {
 	struct bpf_insn *insn = &fp->insnsi[i];
 	s32 branch_oc_off = insn->off;
@@ -1775,17 +1789,11 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		jit->seen |= SEEN_FUNC;
 		/*
 		 * Copy the tail call counter to where the callee expects it.
-		 *
-		 * Note 1: The callee can increment the tail call counter, but
-		 * we do not load it back, since the x86 JIT does not do this
-		 * either.
-		 *
-		 * Note 2: We assume that the verifier does not let us call the
-		 * main program, which clears the tail call counter on entry.
 		 */
-		/* mvc STK_OFF_TCCNT(4,%r15),N(%r15) */
-		_EMIT6(0xd203f000 | STK_OFF_TCCNT,
-		       0xf000 | (STK_OFF_TCCNT + STK_OFF + stack_depth));
+		/* mvc tail_call_cnt(4,%r15),frame_off+tail_call_cnt(%r15) */
+		_EMIT6(0xd203f000 | offsetof(struct prog_frame, tail_call_cnt),
+		       0xf000 | (jit->frame_off +
+				 offsetof(struct prog_frame, tail_call_cnt)));
 
 		/* Sign-extend the kfunc arguments. */
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
@@ -1807,6 +1815,22 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		call_r1(jit);
 		/* lgr %b0,%r2: load return value into %b0 */
 		EMIT4(0xb9040000, BPF_REG_0, REG_2);
+
+		/*
+		 * Copy the potentially updated tail call counter back.
+		 */
+
+		if (insn->src_reg == BPF_PSEUDO_CALL)
+			/*
+			 * mvc frame_off+tail_call_cnt(%r15),
+			 *     tail_call_cnt(4,%r15)
+			 */
+			_EMIT6(0xd203f000 | (jit->frame_off +
+					     offsetof(struct prog_frame,
+						      tail_call_cnt)),
+			       0xf000 | offsetof(struct prog_frame,
+						 tail_call_cnt));
+
 		break;
 	}
 	case BPF_JMP | BPF_TAIL_CALL: {
@@ -1836,10 +1860,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		 *         goto out;
 		 */
 
-		if (jit->seen & SEEN_STACK)
-			off = STK_OFF_TCCNT + STK_OFF + stack_depth;
-		else
-			off = STK_OFF_TCCNT;
+		off = jit->frame_off +
+		      offsetof(struct prog_frame, tail_call_cnt);
 		/* lhi %w0,1 */
 		EMIT4_IMM(0xa7080000, REG_W0, 1);
 		/* laal %w1,%w0,off(%r15) */
@@ -1869,7 +1891,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/*
 		 * Restore registers before calling function
 		 */
-		save_restore_regs(jit, REGS_RESTORE, stack_depth, 0);
+		save_restore_regs(jit, REGS_RESTORE, 0);
 
 		/*
 		 * goto *(prog->bpf_func + tail_call_start);
@@ -2161,7 +2183,7 @@ static int bpf_set_addr(struct bpf_jit *jit, int i)
  * Compile eBPF program into s390x code
  */
 static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
-			bool extra_pass, u32 stack_depth)
+			bool extra_pass)
 {
 	int i, insn_count, lit32_size, lit64_size;
 	u64 kern_arena;
@@ -2170,24 +2192,30 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 	jit->lit64 = jit->lit64_start;
 	jit->prg = 0;
 	jit->excnt = 0;
+	if (is_first_pass(jit) || (jit->seen & SEEN_STACK))
+		jit->frame_off = sizeof(struct prog_frame) -
+				 offsetofend(struct prog_frame, unused) +
+				 round_up(fp->aux->stack_depth, 8);
+	else
+		jit->frame_off = 0;
 
 	kern_arena = bpf_arena_get_kern_vm_start(fp->aux->arena);
 	if (kern_arena)
 		jit->kern_arena = _EMIT_CONST_U64(kern_arena);
 	jit->user_arena = bpf_arena_get_user_vm_start(fp->aux->arena);
 
-	bpf_jit_prologue(jit, fp, stack_depth);
+	bpf_jit_prologue(jit, fp);
 	if (bpf_set_addr(jit, 0) < 0)
 		return -1;
 	for (i = 0; i < fp->len; i += insn_count) {
-		insn_count = bpf_jit_insn(jit, fp, i, extra_pass, stack_depth);
+		insn_count = bpf_jit_insn(jit, fp, i, extra_pass);
 		if (insn_count < 0)
 			return -1;
 		/* Next instruction address */
 		if (bpf_set_addr(jit, i + insn_count) < 0)
 			return -1;
 	}
-	bpf_jit_epilogue(jit, stack_depth);
+	bpf_jit_epilogue(jit);
 
 	lit32_size = jit->lit32 - jit->lit32_start;
 	lit64_size = jit->lit64 - jit->lit64_start;
@@ -2263,7 +2291,6 @@ static struct bpf_binary_header *bpf_jit_alloc(struct bpf_jit *jit,
  */
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 {
-	u32 stack_depth = round_up(fp->aux->stack_depth, 8);
 	struct bpf_prog *tmp, *orig_fp = fp;
 	struct bpf_binary_header *header;
 	struct s390_jit_data *jit_data;
@@ -2316,7 +2343,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	 *   - 3:   Calculate program size and addrs array
 	 */
 	for (pass = 1; pass <= 3; pass++) {
-		if (bpf_jit_prog(&jit, fp, extra_pass, stack_depth)) {
+		if (bpf_jit_prog(&jit, fp, extra_pass)) {
 			fp = orig_fp;
 			goto free_addrs;
 		}
@@ -2330,7 +2357,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		goto free_addrs;
 	}
 skip_init_ctx:
-	if (bpf_jit_prog(&jit, fp, extra_pass, stack_depth)) {
+	if (bpf_jit_prog(&jit, fp, extra_pass)) {
 		bpf_jit_binary_free(header);
 		fp = orig_fp;
 		goto free_addrs;
@@ -2651,9 +2678,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	/* stg %r1,backchain_off(%r15) */
 	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_1, REG_0, REG_15,
 		      tjit->backchain_off);
-	/* mvc tccnt_off(4,%r15),stack_size+STK_OFF_TCCNT(%r15) */
+	/* mvc tccnt_off(4,%r15),stack_size+tail_call_cnt(%r15) */
 	_EMIT6(0xd203f000 | tjit->tccnt_off,
-	       0xf000 | (tjit->stack_size + STK_OFF_TCCNT));
+	       0xf000 | (tjit->stack_size +
+			 offsetof(struct prog_frame, tail_call_cnt)));
 	/* stmg %r2,%rN,fwd_reg_args_off(%r15) */
 	if (nr_reg_args)
 		EMIT6_DISP_LH(0xeb000000, 0x0024, REG_2,
@@ -2790,8 +2818,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 				       (nr_stack_args * sizeof(u64) - 1) << 16 |
 				       tjit->stack_args_off,
 			       0xf000 | tjit->orig_stack_args_off);
-		/* mvc STK_OFF_TCCNT(4,%r15),tccnt_off(%r15) */
-		_EMIT6(0xd203f000 | STK_OFF_TCCNT, 0xf000 | tjit->tccnt_off);
+		/* mvc tail_call_cnt(4,%r15),tccnt_off(%r15) */
+		_EMIT6(0xd203f000 | offsetof(struct prog_frame, tail_call_cnt),
+		       0xf000 | tjit->tccnt_off);
 		/* lgr %r1,%r8 */
 		EMIT4(0xb9040000, REG_1, REG_8);
 		/* %r1() */
@@ -2799,6 +2828,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		/* stg %r2,retval_off(%r15) */
 		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_2, REG_0, REG_15,
 			      tjit->retval_off);
+		/* mvc tccnt_off(%r15),tail_call_cnt(4,%r15) */
+		_EMIT6(0xd203f000 | tjit->tccnt_off,
+		       0xf000 | offsetof(struct prog_frame, tail_call_cnt));
 
 		im->ip_after_call = jit->prg_buf + jit->prg;
 
@@ -2848,8 +2880,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	if (flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET))
 		EMIT6_DISP_LH(0xe3000000, 0x0004, REG_2, REG_0, REG_15,
 			      tjit->retval_off);
-	/* mvc stack_size+STK_OFF_TCCNT(4,%r15),tccnt_off(%r15) */
-	_EMIT6(0xd203f000 | (tjit->stack_size + STK_OFF_TCCNT),
+	/* mvc stack_size+tail_call_cnt(4,%r15),tccnt_off(%r15) */
+	_EMIT6(0xd203f000 | (tjit->stack_size +
+			     offsetof(struct prog_frame, tail_call_cnt)),
 	       0xf000 | tjit->tccnt_off);
 	/* aghi %r15,stack_size */
 	EMIT4_IMM(0xa70b0000, REG_15, tjit->stack_size);
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 06012e68bdca..284a4cafa432 100644
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
index f98c2901f335..f53092b07b9e 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -677,6 +677,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 
 	if (of_device_register(op)) {
 		printk("%pOF: Could not register of device.\n", dp);
+		put_device(&op->dev);
 		kfree(op);
 		op = NULL;
 	}
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index c276d70a7479..305f191ba81b 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -130,6 +130,26 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 
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
 
diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index a02bc6f3d2e6..0ca9db540b16 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -16,7 +16,7 @@
 
 .macro FRED_ENTER
 	UNWIND_HINT_END_OF_STACK
-	ENDBR
+	ANNOTATE_NOENDBR
 	PUSH_AND_CLEAR_REGS
 	movq	%rsp, %rdi	/* %rdi -> pt_regs */
 .endm
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index af87f440bc2a..8c345ad45841 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -681,7 +681,7 @@ void __init hv_vtom_init(void)
 	x86_platform.guest.enc_status_change_finish = hv_vtom_set_host_visibility;
 
 	/* Set WB as the default cache mode. */
-	mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
+	guest_force_mtrr_state(NULL, 0, MTRR_TYPE_WRBACK);
 }
 
 #endif /* defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST) */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 21d07aa9400c..b67280d761f6 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -722,6 +722,7 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET	0xc0000303
 
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 4218248083d9..c69e269937c5 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -58,8 +58,8 @@ struct mtrr_state_type {
  */
 # ifdef CONFIG_MTRR
 void mtrr_bp_init(void);
-void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
-			  mtrr_type def_type);
+void guest_force_mtrr_state(struct mtrr_var_range *var, unsigned int num_var,
+			    mtrr_type def_type);
 extern u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform);
 extern void mtrr_save_fixed_ranges(void *);
 extern void mtrr_save_state(void);
@@ -75,9 +75,9 @@ void mtrr_disable(void);
 void mtrr_enable(void);
 void mtrr_generic_set_state(void);
 #  else
-static inline void mtrr_overwrite_state(struct mtrr_var_range *var,
-					unsigned int num_var,
-					mtrr_type def_type)
+static inline void guest_force_mtrr_state(struct mtrr_var_range *var,
+					  unsigned int num_var,
+					  mtrr_type def_type)
 {
 }
 
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 1ececfce7a46..4b1e2d14e5aa 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -423,7 +423,7 @@ void __init mtrr_copy_map(void)
 }
 
 /**
- * mtrr_overwrite_state - set static MTRR state
+ * guest_force_mtrr_state - set static MTRR state for a guest
  *
  * Used to set MTRR state via different means (e.g. with data obtained from
  * a hypervisor).
@@ -436,8 +436,8 @@ void __init mtrr_copy_map(void)
  * @num_var: length of the @var array
  * @def_type: default caching type
  */
-void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
-			  mtrr_type def_type)
+void guest_force_mtrr_state(struct mtrr_var_range *var, unsigned int num_var,
+			    mtrr_type def_type)
 {
 	unsigned int i;
 
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 989d368be04f..ecbda0341a8a 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -625,7 +625,7 @@ void mtrr_save_state(void)
 static int __init mtrr_init_finalize(void)
 {
 	/*
-	 * Map might exist if mtrr_overwrite_state() has been called or if
+	 * Map might exist if guest_force_mtrr_state() has been called or if
 	 * mtrr_enabled() returns true.
 	 */
 	mtrr_copy_map();
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 21e9e4845354..bd21c568bc2a 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -933,6 +933,19 @@ static void kvm_sev_hc_page_enc_status(unsigned long pfn, int npages, bool enc)
 
 static void __init kvm_init_platform(void)
 {
+	u64 tolud = PFN_PHYS(e820__end_of_low_ram_pfn());
+	/*
+	 * Note, hardware requires variable MTRR ranges to be power-of-2 sized
+	 * and naturally aligned.  But when forcing guest MTRR state, Linux
+	 * doesn't program the forced ranges into hardware.  Don't bother doing
+	 * the math to generate a technically-legal range.
+	 */
+	struct mtrr_var_range pci_hole = {
+		.base_lo = tolud | X86_MEMTYPE_UC,
+		.mask_lo = (u32)(~(SZ_4G - tolud - 1)) | MTRR_PHYSMASK_V,
+		.mask_hi = (BIT_ULL(boot_cpu_data.x86_phys_bits) - 1) >> 32,
+	};
+
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
 	    kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL)) {
 		unsigned long nr_pages;
@@ -982,8 +995,12 @@ static void __init kvm_init_platform(void)
 	kvmclock_init();
 	x86_platform.apic_post_init = kvm_apic_init;
 
-	/* Set WB as the default cache mode for SEV-SNP and TDX */
-	mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
+	/*
+	 * Set WB as the default cache mode for SEV-SNP and TDX, with a single
+	 * UC range for the legacy PCI hole, e.g. so that devices that expect
+	 * to get UC/WC mappings don't get surprised with WB.
+	 */
+	guest_force_mtrr_state(&pci_hole, 1, MTRR_TYPE_WRBACK);
 }
 
 #if defined(CONFIG_AMD_MEM_ENCRYPT)
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 5a4b21389b1d..d432f3824f0c 100644
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
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8f587c5bb6bc..a7a1486ce270 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -816,7 +816,7 @@ void kvm_set_cpu_caps(void)
 		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC) | 0 /* SmmPgCfgLock */ |
 		F(VERW_CLEAR) |
 		F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */ |
-		F(WRMSR_XX_BASE_NS)
+		F(WRMSR_XX_BASE_NS) | F(SRSO_USER_KERNEL_NO)
 	);
 
 	kvm_cpu_cap_check_and_set(X86_FEATURE_SBPB);
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 47a46283c866..a26e8f5ad790 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -650,6 +650,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = pmu->global_ctrl;
 		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
 		msr_info->data = 0;
 		break;
@@ -711,6 +712,10 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!msr_info->host_initiated)
 			pmu->global_status &= ~data;
 		break;
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
+		if (!msr_info->host_initiated)
+			pmu->global_status |= data & ~pmu->global_status_rsvd;
+		break;
 	default:
 		kvm_pmu_mark_pmc_in_use(vcpu, msr_info->index);
 		return kvm_pmu_call(set_msr)(vcpu, msr_info);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 22d5a65b410c..dbca6453ec4d 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -113,6 +113,7 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 		return pmu->version > 1;
 	default:
 		if (msr > MSR_F15H_PERF_CTR5 &&
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 86cabeca6265..20f89bceaeae 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -364,6 +364,7 @@ static const u32 msrs_to_save_pmu[] = {
 	MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
 	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
 	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
 };
 
 static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_base) +
@@ -7449,6 +7450,7 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 		if (!kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2))
 			return;
 		break;
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index a8eb7e0c473c..e033d5594265 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -171,7 +171,7 @@ static void __init xen_set_mtrr_data(void)
 
 	/* Only overwrite MTRR state if any MTRR could be got from Xen. */
 	if (reg)
-		mtrr_overwrite_state(var, reg, MTRR_TYPE_UNCACHABLE);
+		guest_force_mtrr_state(var, reg, MTRR_TYPE_UNCACHABLE);
 #endif
 }
 
@@ -195,7 +195,7 @@ static void __init xen_pv_init_platform(void)
 	if (xen_initial_domain())
 		xen_set_mtrr_data();
 	else
-		mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
+		guest_force_mtrr_state(NULL, 0, MTRR_TYPE_WRBACK);
 
 	/* Adjust nr_cpu_ids before "enumeration" happens */
 	xen_smp_count_cpus();
diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index d6d2b533a574..f5add569ca83 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -230,10 +230,14 @@ static ssize_t proc_read_simdisk(struct file *file, char __user *buf,
 static ssize_t proc_write_simdisk(struct file *file, const char __user *buf,
 			size_t count, loff_t *ppos)
 {
-	char *tmp = memdup_user_nul(buf, count);
+	char *tmp;
 	struct simdisk *dev = pde_data(file_inode(file));
 	int err;
 
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
+
+	tmp = memdup_user_nul(buf, count);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index b1e7415f8439..d04192ae3dce 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/scatterlist.h>
+#include <trace/events/block.h>
 
 #include "blk-cgroup.h"
 #include "blk-crypto-internal.h"
@@ -230,7 +231,9 @@ static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
 			bio->bi_status = BLK_STS_RESOURCE;
 			return false;
 		}
+
 		bio_chain(split_bio, bio);
+		trace_block_split(split_bio, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		*bio_ptr = split_bio;
 	}
diff --git a/crypto/essiv.c b/crypto/essiv.c
index e63fc6442e32..aa7ebc123527 100644
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
index b831cb8e53dc..b75ceaab716e 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -565,6 +565,9 @@ static void acpi_tad_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(dev);
 
+	if (dd->capabilities & ACPI_TAD_RT)
+		sysfs_remove_group(&dev->kobj, &acpi_tad_time_attr_group);
+
 	if (dd->capabilities & ACPI_TAD_DC_WAKE)
 		sysfs_remove_group(&dev->kobj, &acpi_tad_dc_attr_group);
 
diff --git a/drivers/acpi/acpica/evglock.c b/drivers/acpi/acpica/evglock.c
index 989dc01af03f..bc205b330904 100644
--- a/drivers/acpi/acpica/evglock.c
+++ b/drivers/acpi/acpica/evglock.c
@@ -42,6 +42,10 @@ acpi_status acpi_ev_init_global_lock_handler(void)
 		return_ACPI_STATUS(AE_OK);
 	}
 
+	if (!acpi_gbl_use_global_lock) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Attempt installation of the global lock handler */
 
 	status = acpi_install_fixed_event_handler(ACPI_EVENT_GLOBAL,
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 65fa3444367a..11c7e35fafa2 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -92,7 +92,7 @@ enum {
 
 struct acpi_battery {
 	struct mutex lock;
-	struct mutex sysfs_lock;
+	struct mutex update_lock;
 	struct power_supply *bat;
 	struct power_supply_desc bat_desc;
 	struct acpi_device *device;
@@ -903,15 +903,12 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
 {
-	mutex_lock(&battery->sysfs_lock);
-	if (!battery->bat) {
-		mutex_unlock(&battery->sysfs_lock);
+	if (!battery->bat)
 		return;
-	}
+
 	battery_hook_remove_battery(battery);
 	power_supply_unregister(battery->bat);
 	battery->bat = NULL;
-	mutex_unlock(&battery->sysfs_lock);
 }
 
 static void find_battery(const struct dmi_header *dm, void *private)
@@ -1071,6 +1068,9 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 
 	if (!battery)
 		return;
+
+	guard(mutex)(&battery->update_lock);
+
 	old = battery->bat;
 	/*
 	 * On Acer Aspire V5-573G notifications are sometimes triggered too
@@ -1093,21 +1093,22 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 }
 
 static int battery_notify(struct notifier_block *nb,
-			       unsigned long mode, void *_unused)
+			  unsigned long mode, void *_unused)
 {
 	struct acpi_battery *battery = container_of(nb, struct acpi_battery,
 						    pm_nb);
-	int result;
 
-	switch (mode) {
-	case PM_POST_HIBERNATION:
-	case PM_POST_SUSPEND:
+	if (mode == PM_POST_SUSPEND || mode == PM_POST_HIBERNATION) {
+		guard(mutex)(&battery->update_lock);
+
 		if (!acpi_battery_present(battery))
 			return 0;
 
 		if (battery->bat) {
 			acpi_battery_refresh(battery);
 		} else {
+			int result;
+
 			result = acpi_battery_get_info(battery);
 			if (result)
 				return result;
@@ -1119,7 +1120,6 @@ static int battery_notify(struct notifier_block *nb,
 
 		acpi_battery_init_alarm(battery);
 		acpi_battery_get_state(battery);
-		break;
 	}
 
 	return 0;
@@ -1197,6 +1197,8 @@ static int acpi_battery_update_retry(struct acpi_battery *battery)
 {
 	int retry, ret;
 
+	guard(mutex)(&battery->update_lock);
+
 	for (retry = 5; retry; retry--) {
 		ret = acpi_battery_update(battery, false);
 		if (!ret)
@@ -1207,6 +1209,13 @@ static int acpi_battery_update_retry(struct acpi_battery *battery)
 	return ret;
 }
 
+static void sysfs_battery_cleanup(struct acpi_battery *battery)
+{
+	guard(mutex)(&battery->update_lock);
+
+	sysfs_remove_battery(battery);
+}
+
 static int acpi_battery_add(struct acpi_device *device)
 {
 	int result = 0;
@@ -1218,15 +1227,21 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (device->dep_unmet)
 		return -EPROBE_DEFER;
 
-	battery = kzalloc(sizeof(struct acpi_battery), GFP_KERNEL);
+	battery = devm_kzalloc(&device->dev, sizeof(*battery), GFP_KERNEL);
 	if (!battery)
 		return -ENOMEM;
 	battery->device = device;
 	strscpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 	device->driver_data = battery;
-	mutex_init(&battery->lock);
-	mutex_init(&battery->sysfs_lock);
+	result = devm_mutex_init(&device->dev, &battery->lock);
+	if (result)
+		return result;
+
+	result = devm_mutex_init(&device->dev, &battery->update_lock);
+	if (result)
+		return result;
+
 	if (acpi_has_method(battery->device->handle, "_BIX"))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
 
@@ -1253,10 +1268,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
 fail:
-	sysfs_remove_battery(battery);
-	mutex_destroy(&battery->lock);
-	mutex_destroy(&battery->sysfs_lock);
-	kfree(battery);
+	sysfs_battery_cleanup(battery);
 
 	return result;
 }
@@ -1275,11 +1287,10 @@ static void acpi_battery_remove(struct acpi_device *device)
 
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
-	sysfs_remove_battery(battery);
 
-	mutex_destroy(&battery->lock);
-	mutex_destroy(&battery->sysfs_lock);
-	kfree(battery);
+	guard(mutex)(&battery->update_lock);
+
+	sysfs_remove_battery(battery);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1296,6 +1307,9 @@ static int acpi_battery_resume(struct device *dev)
 		return -EINVAL;
 
 	battery->update_time = 0;
+
+	guard(mutex)(&battery->update_lock);
+
 	acpi_battery_update(battery, true);
 	return 0;
 }
diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e9186339f6e6..342e7cef723c 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -83,6 +83,7 @@ static bool acpi_nondev_subnode_extract(union acpi_object *desc,
 					struct fwnode_handle *parent)
 {
 	struct acpi_data_node *dn;
+	acpi_handle scope = NULL;
 	bool result;
 
 	if (acpi_graph_ignore_port(handle))
@@ -98,29 +99,35 @@ static bool acpi_nondev_subnode_extract(union acpi_object *desc,
 	INIT_LIST_HEAD(&dn->data.properties);
 	INIT_LIST_HEAD(&dn->data.subnodes);
 
-	result = acpi_extract_properties(handle, desc, &dn->data);
-
-	if (handle) {
-		acpi_handle scope;
-		acpi_status status;
+	/*
+	 * The scope for the completion of relative pathname segments and
+	 * subnode object lookup is the one of the namespace node (device)
+	 * containing the object that has returned the package.  That is, it's
+	 * the scope of that object's parent device.
+	 */
+	if (handle)
+		acpi_get_parent(handle, &scope);
 
-		/*
-		 * The scope for the subnode object lookup is the one of the
-		 * namespace node (device) containing the object that has
-		 * returned the package.  That is, it's the scope of that
-		 * object's parent.
-		 */
-		status = acpi_get_parent(handle, &scope);
-		if (ACPI_SUCCESS(status)
-		    && acpi_enumerate_nondev_subnodes(scope, desc, &dn->data,
-						      &dn->fwnode))
-			result = true;
-	} else if (acpi_enumerate_nondev_subnodes(NULL, desc, &dn->data,
-						  &dn->fwnode)) {
+	/*
+	 * Extract properties from the _DSD-equivalent package pointed to by
+	 * desc and use scope (if not NULL) for the completion of relative
+	 * pathname segments.
+	 *
+	 * The extracted properties will be held in the new data node dn.
+	 */
+	result = acpi_extract_properties(scope, desc, &dn->data);
+	/*
+	 * Look for subnodes in the _DSD-equivalent package pointed to by desc
+	 * and create child nodes of dn if there are any.
+	 */
+	if (acpi_enumerate_nondev_subnodes(scope, desc, &dn->data, &dn->fwnode))
 		result = true;
-	}
 
 	if (result) {
+		/*
+		 * This will be NULL if the desc package is embedded in an outer
+		 * _DSD-equivalent package and its scope cannot be determined.
+		 */
 		dn->handle = handle;
 		dn->data.pointer = desc;
 		list_add_tail(&dn->sibling, list);
@@ -132,35 +139,21 @@ static bool acpi_nondev_subnode_extract(union acpi_object *desc,
 	return false;
 }
 
-static bool acpi_nondev_subnode_data_ok(acpi_handle handle,
-					const union acpi_object *link,
-					struct list_head *list,
-					struct fwnode_handle *parent)
-{
-	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
-	acpi_status status;
-
-	status = acpi_evaluate_object_typed(handle, NULL, NULL, &buf,
-					    ACPI_TYPE_PACKAGE);
-	if (ACPI_FAILURE(status))
-		return false;
-
-	if (acpi_nondev_subnode_extract(buf.pointer, handle, link, list,
-					parent))
-		return true;
-
-	ACPI_FREE(buf.pointer);
-	return false;
-}
-
 static bool acpi_nondev_subnode_ok(acpi_handle scope,
 				   const union acpi_object *link,
 				   struct list_head *list,
 				   struct fwnode_handle *parent)
 {
+	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
 	acpi_handle handle;
 	acpi_status status;
 
+	/*
+	 * If the scope is unknown, the _DSD-equivalent package being parsed
+	 * was embedded in an outer _DSD-equivalent package as a result of
+	 * direct evaluation of an object pointed to by a reference.  In that
+	 * case, using a pathname as the target object pointer is invalid.
+	 */
 	if (!scope)
 		return false;
 
@@ -169,7 +162,17 @@ static bool acpi_nondev_subnode_ok(acpi_handle scope,
 	if (ACPI_FAILURE(status))
 		return false;
 
-	return acpi_nondev_subnode_data_ok(handle, link, list, parent);
+	status = acpi_evaluate_object_typed(handle, NULL, NULL, &buf,
+					    ACPI_TYPE_PACKAGE);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	if (acpi_nondev_subnode_extract(buf.pointer, handle, link, list,
+					parent))
+		return true;
+
+	ACPI_FREE(buf.pointer);
+	return false;
 }
 
 static bool acpi_add_nondev_subnodes(acpi_handle scope,
@@ -180,9 +183,12 @@ static bool acpi_add_nondev_subnodes(acpi_handle scope,
 	bool ret = false;
 	int i;
 
+	/*
+	 * Every element in the links package is expected to represent a link
+	 * to a non-device node in a tree containing device-specific data.
+	 */
 	for (i = 0; i < links->package.count; i++) {
 		union acpi_object *link, *desc;
-		acpi_handle handle;
 		bool result;
 
 		link = &links->package.elements[i];
@@ -190,26 +196,53 @@ static bool acpi_add_nondev_subnodes(acpi_handle scope,
 		if (link->package.count != 2)
 			continue;
 
-		/* The first one must be a string. */
+		/* The first one (the key) must be a string. */
 		if (link->package.elements[0].type != ACPI_TYPE_STRING)
 			continue;
 
-		/* The second one may be a string, a reference or a package. */
+		/* The second one (the target) may be a string or a package. */
 		switch (link->package.elements[1].type) {
 		case ACPI_TYPE_STRING:
+			/*
+			 * The string is expected to be a full pathname or a
+			 * pathname segment relative to the given scope.  That
+			 * pathname is expected to point to an object returning
+			 * a package that contains _DSD-equivalent information.
+			 */
 			result = acpi_nondev_subnode_ok(scope, link, list,
 							 parent);
 			break;
-		case ACPI_TYPE_LOCAL_REFERENCE:
-			handle = link->package.elements[1].reference.handle;
-			result = acpi_nondev_subnode_data_ok(handle, link, list,
-							     parent);
-			break;
 		case ACPI_TYPE_PACKAGE:
+			/*
+			 * This happens when a reference is used in AML to
+			 * point to the target.  Since the target is expected
+			 * to be a named object, a reference to it will cause it
+			 * to be avaluated in place and its return package will
+			 * be embedded in the links package at the location of
+			 * the reference.
+			 *
+			 * The target package is expected to contain _DSD-
+			 * equivalent information, but the scope in which it
+			 * is located in the original AML is unknown.  Thus
+			 * it cannot contain pathname segments represented as
+			 * strings because there is no way to build full
+			 * pathnames out of them.
+			 */
+			acpi_handle_debug(scope, "subnode %s: Unknown scope\n",
+					  link->package.elements[0].string.pointer);
 			desc = &link->package.elements[1];
 			result = acpi_nondev_subnode_extract(desc, NULL, link,
 							     list, parent);
 			break;
+		case ACPI_TYPE_LOCAL_REFERENCE:
+			/*
+			 * It is not expected to see any local references in
+			 * the links package because referencing a named object
+			 * should cause it to be evaluated in place.
+			 */
+			acpi_handle_info(scope, "subnode %s: Unexpected reference\n",
+					 link->package.elements[0].string.pointer);
+			fallthrough;
 		default:
 			result = false;
 			break;
@@ -369,6 +402,9 @@ static void acpi_untie_nondev_subnodes(struct acpi_device_data *data)
 	struct acpi_data_node *dn;
 
 	list_for_each_entry(dn, &data->subnodes, sibling) {
+		if (!dn->handle)
+			continue;
+
 		acpi_detach_data(dn->handle, acpi_nondev_subnode_tag);
 
 		acpi_untie_nondev_subnodes(&dn->data);
@@ -383,6 +419,9 @@ static bool acpi_tie_nondev_subnodes(struct acpi_device_data *data)
 		acpi_status status;
 		bool ret;
 
+		if (!dn->handle)
+			continue;
+
 		status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
 		if (ACPI_FAILURE(status) && status != AE_ALREADY_EXISTS) {
 			acpi_handle_err(dn->handle, "Can't tag data node\n");
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index db9b5164ccca..dd4117192201 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -536,8 +536,10 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 		return -EBADF;
 
 	error = loop_check_backing_file(file);
-	if (error)
+	if (error) {
+		fput(file);
 		return error;
+	}
 
 	/* suppress uevents while reconfiguring the device */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
@@ -973,8 +975,10 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 		return -EBADF;
 
 	error = loop_check_backing_file(file);
-	if (error)
+	if (error) {
+		fput(file);
 		return error;
+	}
 
 	is_loop = is_loop_device(file);
 
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index b3eafcf2a2c5..cdea24e92919 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -403,17 +403,13 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 {
 	struct mhi_ep_chan *mhi_chan = &mhi_cntrl->mhi_chan[ring->ch_id];
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	size_t tr_len, read_offset, write_offset;
+	size_t tr_len, read_offset;
 	struct mhi_ep_buf_info buf_info = {};
 	u32 len = MHI_EP_DEFAULT_MTU;
 	struct mhi_ring_element *el;
-	bool tr_done = false;
 	void *buf_addr;
-	u32 buf_left;
 	int ret;
 
-	buf_left = len;
-
 	do {
 		/* Don't process the transfer ring if the channel is not in RUNNING state */
 		if (mhi_chan->state != MHI_CH_STATE_RUNNING) {
@@ -426,24 +422,23 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 		/* Check if there is data pending to be read from previous read operation */
 		if (mhi_chan->tre_bytes_left) {
 			dev_dbg(dev, "TRE bytes remaining: %u\n", mhi_chan->tre_bytes_left);
-			tr_len = min(buf_left, mhi_chan->tre_bytes_left);
+			tr_len = min(len, mhi_chan->tre_bytes_left);
 		} else {
 			mhi_chan->tre_loc = MHI_TRE_DATA_GET_PTR(el);
 			mhi_chan->tre_size = MHI_TRE_DATA_GET_LEN(el);
 			mhi_chan->tre_bytes_left = mhi_chan->tre_size;
 
-			tr_len = min(buf_left, mhi_chan->tre_size);
+			tr_len = min(len, mhi_chan->tre_size);
 		}
 
 		read_offset = mhi_chan->tre_size - mhi_chan->tre_bytes_left;
-		write_offset = len - buf_left;
 
 		buf_addr = kmem_cache_zalloc(mhi_cntrl->tre_buf_cache, GFP_KERNEL);
 		if (!buf_addr)
 			return -ENOMEM;
 
 		buf_info.host_addr = mhi_chan->tre_loc + read_offset;
-		buf_info.dev_addr = buf_addr + write_offset;
+		buf_info.dev_addr = buf_addr;
 		buf_info.size = tr_len;
 		buf_info.cb = mhi_ep_read_completion;
 		buf_info.cb_buf = buf_addr;
@@ -459,16 +454,12 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 			goto err_free_buf_addr;
 		}
 
-		buf_left -= tr_len;
 		mhi_chan->tre_bytes_left -= tr_len;
 
-		if (!mhi_chan->tre_bytes_left) {
-			if (MHI_TRE_DATA_GET_IEOT(el))
-				tr_done = true;
-
+		if (!mhi_chan->tre_bytes_left)
 			mhi_chan->rd_offset = (mhi_chan->rd_offset + 1) % ring->ring_size;
-		}
-	} while (buf_left && !tr_done);
+	/* Read until the some buffer is left or the ring becomes not empty */
+	} while (!mhi_ep_queue_is_empty(mhi_chan->mhi_dev, DMA_TO_DEVICE));
 
 	return 0;
 
@@ -502,15 +493,11 @@ static int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring)
 		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
 	} else {
 		/* UL channel */
-		do {
-			ret = mhi_ep_read_channel(mhi_cntrl, ring);
-			if (ret < 0) {
-				dev_err(&mhi_chan->mhi_dev->dev, "Failed to read channel\n");
-				return ret;
-			}
-
-			/* Read until the ring becomes empty */
-		} while (!mhi_ep_queue_is_empty(mhi_chan->mhi_dev, DMA_TO_DEVICE));
+		ret = mhi_ep_read_channel(mhi_cntrl, ring);
+		if (ret < 0) {
+			dev_err(&mhi_chan->mhi_dev->dev, "Failed to read channel\n");
+			return ret;
+		}
 	}
 
 	return 0;
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index a9b1f8beee7b..223fc54c45b3 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -194,7 +194,6 @@ void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl)
 int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 {
 	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	unsigned long irq_flags = IRQF_SHARED | IRQF_NO_SUSPEND;
 	int i, ret;
 
@@ -221,7 +220,7 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 			continue;
 
 		if (mhi_event->irq >= mhi_cntrl->nr_irqs) {
-			dev_err(dev, "irq %d not available for event ring\n",
+			dev_err(mhi_cntrl->cntrl_dev, "irq %d not available for event ring\n",
 				mhi_event->irq);
 			ret = -EINVAL;
 			goto error_request;
@@ -232,7 +231,7 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 				  irq_flags,
 				  "mhi", mhi_event);
 		if (ret) {
-			dev_err(dev, "Error requesting irq:%d for ev:%d\n",
+			dev_err(mhi_cntrl->cntrl_dev, "Error requesting irq:%d for ev:%d\n",
 				mhi_cntrl->irq[mhi_event->irq], i);
 			goto error_request;
 		}
diff --git a/drivers/char/ipmi/ipmi_kcs_sm.c b/drivers/char/ipmi/ipmi_kcs_sm.c
index ecfcb50302f6..efda90dcf5b3 100644
--- a/drivers/char/ipmi/ipmi_kcs_sm.c
+++ b/drivers/char/ipmi/ipmi_kcs_sm.c
@@ -122,10 +122,10 @@ struct si_sm_data {
 	unsigned long  error0_timeout;
 };
 
-static unsigned int init_kcs_data_with_state(struct si_sm_data *kcs,
-				  struct si_sm_io *io, enum kcs_states state)
+static unsigned int init_kcs_data(struct si_sm_data *kcs,
+				  struct si_sm_io *io)
 {
-	kcs->state = state;
+	kcs->state = KCS_IDLE;
 	kcs->io = io;
 	kcs->write_pos = 0;
 	kcs->write_count = 0;
@@ -140,12 +140,6 @@ static unsigned int init_kcs_data_with_state(struct si_sm_data *kcs,
 	return 2;
 }
 
-static unsigned int init_kcs_data(struct si_sm_data *kcs,
-				  struct si_sm_io *io)
-{
-	return init_kcs_data_with_state(kcs, io, KCS_IDLE);
-}
-
 static inline unsigned char read_status(struct si_sm_data *kcs)
 {
 	return kcs->io->inputb(kcs->io, 1);
@@ -276,7 +270,7 @@ static int start_kcs_transaction(struct si_sm_data *kcs, unsigned char *data,
 	if (size > MAX_KCS_WRITE_SIZE)
 		return IPMI_REQ_LEN_EXCEEDED_ERR;
 
-	if (kcs->state != KCS_IDLE) {
+	if ((kcs->state != KCS_IDLE) && (kcs->state != KCS_HOSED)) {
 		dev_warn(kcs->io->dev, "KCS in invalid state %d\n", kcs->state);
 		return IPMI_NOT_IN_MY_STATE_ERR;
 	}
@@ -501,7 +495,7 @@ static enum si_sm_result kcs_event(struct si_sm_data *kcs, long time)
 	}
 
 	if (kcs->state == KCS_HOSED) {
-		init_kcs_data_with_state(kcs, kcs->io, KCS_ERROR0);
+		init_kcs_data(kcs, kcs->io);
 		return SI_SM_HOSED;
 	}
 
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 09405668ebb3..99fe01321971 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -39,7 +39,9 @@
 
 #define IPMI_DRIVER_VERSION "39.2"
 
-static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
+static struct ipmi_recv_msg *ipmi_alloc_recv_msg(struct ipmi_user *user);
+static void ipmi_set_recv_msg_user(struct ipmi_recv_msg *msg,
+				   struct ipmi_user *user);
 static int ipmi_init_msghandler(void);
 static void smi_recv_work(struct work_struct *t);
 static void handle_new_recv_msgs(struct ipmi_smi *intf);
@@ -939,13 +941,11 @@ static int deliver_response(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
 		 * risk.  At this moment, simply skip it in that case.
 		 */
 		ipmi_free_recv_msg(msg);
-		atomic_dec(&msg->user->nr_msgs);
 	} else {
 		int index;
 		struct ipmi_user *user = acquire_ipmi_user(msg->user, &index);
 
 		if (user) {
-			atomic_dec(&user->nr_msgs);
 			user->handler->ipmi_recv_hndl(msg, user->handler_data);
 			release_ipmi_user(user, index);
 		} else {
@@ -1634,8 +1634,7 @@ int ipmi_set_gets_events(struct ipmi_user *user, bool val)
 		spin_unlock_irqrestore(&intf->events_lock, flags);
 
 		list_for_each_entry_safe(msg, msg2, &msgs, link) {
-			msg->user = user;
-			kref_get(&user->refcount);
+			ipmi_set_recv_msg_user(msg, user);
 			deliver_local_response(intf, msg);
 		}
 
@@ -2309,22 +2308,18 @@ static int i_ipmi_request(struct ipmi_user     *user,
 	struct ipmi_recv_msg *recv_msg;
 	int rv = 0;
 
-	if (user) {
-		if (atomic_add_return(1, &user->nr_msgs) > max_msgs_per_user) {
-			/* Decrement will happen at the end of the routine. */
-			rv = -EBUSY;
-			goto out;
-		}
-	}
-
-	if (supplied_recv)
+	if (supplied_recv) {
 		recv_msg = supplied_recv;
-	else {
-		recv_msg = ipmi_alloc_recv_msg();
-		if (recv_msg == NULL) {
-			rv = -ENOMEM;
-			goto out;
+		recv_msg->user = user;
+		if (user) {
+			atomic_inc(&user->nr_msgs);
+			/* The put happens when the message is freed. */
+			kref_get(&user->refcount);
 		}
+	} else {
+		recv_msg = ipmi_alloc_recv_msg(user);
+		if (IS_ERR(recv_msg))
+			return PTR_ERR(recv_msg);
 	}
 	recv_msg->user_msg_data = user_msg_data;
 
@@ -2335,8 +2330,7 @@ static int i_ipmi_request(struct ipmi_user     *user,
 		if (smi_msg == NULL) {
 			if (!supplied_recv)
 				ipmi_free_recv_msg(recv_msg);
-			rv = -ENOMEM;
-			goto out;
+			return -ENOMEM;
 		}
 	}
 
@@ -2346,10 +2340,6 @@ static int i_ipmi_request(struct ipmi_user     *user,
 		goto out_err;
 	}
 
-	recv_msg->user = user;
-	if (user)
-		/* The put happens when the message is freed. */
-		kref_get(&user->refcount);
 	recv_msg->msgid = msgid;
 	/*
 	 * Store the message to send in the receive message so timeout
@@ -2378,8 +2368,10 @@ static int i_ipmi_request(struct ipmi_user     *user,
 
 	if (rv) {
 out_err:
-		ipmi_free_smi_msg(smi_msg);
-		ipmi_free_recv_msg(recv_msg);
+		if (!supplied_smi)
+			ipmi_free_smi_msg(smi_msg);
+		if (!supplied_recv)
+			ipmi_free_recv_msg(recv_msg);
 	} else {
 		dev_dbg(intf->si_dev, "Send: %*ph\n",
 			smi_msg->data_size, smi_msg->data);
@@ -2388,9 +2380,6 @@ static int i_ipmi_request(struct ipmi_user     *user,
 	}
 	rcu_read_unlock();
 
-out:
-	if (rv && user)
-		atomic_dec(&user->nr_msgs);
 	return rv;
 }
 
@@ -3882,7 +3871,7 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
 	unsigned char            chan;
 	struct ipmi_user         *user = NULL;
 	struct ipmi_ipmb_addr    *ipmb_addr;
-	struct ipmi_recv_msg     *recv_msg;
+	struct ipmi_recv_msg     *recv_msg = NULL;
 
 	if (msg->rsp_size < 10) {
 		/* Message not big enough, just ignore it. */
@@ -3903,9 +3892,8 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
 	rcvr = find_cmd_rcvr(intf, netfn, cmd, chan);
 	if (rcvr) {
 		user = rcvr->user;
-		kref_get(&user->refcount);
-	} else
-		user = NULL;
+		recv_msg = ipmi_alloc_recv_msg(user);
+	}
 	rcu_read_unlock();
 
 	if (user == NULL) {
@@ -3940,47 +3928,41 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
 			rv = -1;
 		}
 		rcu_read_unlock();
-	} else {
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
-			/*
-			 * We couldn't allocate memory for the
-			 * message, so requeue it for handling
-			 * later.
-			 */
-			rv = 1;
-			kref_put(&user->refcount, free_user);
-		} else {
-			/* Extract the source address from the data. */
-			ipmb_addr = (struct ipmi_ipmb_addr *) &recv_msg->addr;
-			ipmb_addr->addr_type = IPMI_IPMB_ADDR_TYPE;
-			ipmb_addr->slave_addr = msg->rsp[6];
-			ipmb_addr->lun = msg->rsp[7] & 3;
-			ipmb_addr->channel = msg->rsp[3] & 0xf;
+	} else if (!IS_ERR(recv_msg)) {
+		/* Extract the source address from the data. */
+		ipmb_addr = (struct ipmi_ipmb_addr *) &recv_msg->addr;
+		ipmb_addr->addr_type = IPMI_IPMB_ADDR_TYPE;
+		ipmb_addr->slave_addr = msg->rsp[6];
+		ipmb_addr->lun = msg->rsp[7] & 3;
+		ipmb_addr->channel = msg->rsp[3] & 0xf;
 
-			/*
-			 * Extract the rest of the message information
-			 * from the IPMB header.
-			 */
-			recv_msg->user = user;
-			recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
-			recv_msg->msgid = msg->rsp[7] >> 2;
-			recv_msg->msg.netfn = msg->rsp[4] >> 2;
-			recv_msg->msg.cmd = msg->rsp[8];
-			recv_msg->msg.data = recv_msg->msg_data;
+		/*
+		 * Extract the rest of the message information
+		 * from the IPMB header.
+		 */
+		recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
+		recv_msg->msgid = msg->rsp[7] >> 2;
+		recv_msg->msg.netfn = msg->rsp[4] >> 2;
+		recv_msg->msg.cmd = msg->rsp[8];
+		recv_msg->msg.data = recv_msg->msg_data;
 
-			/*
-			 * We chop off 10, not 9 bytes because the checksum
-			 * at the end also needs to be removed.
-			 */
-			recv_msg->msg.data_len = msg->rsp_size - 10;
-			memcpy(recv_msg->msg_data, &msg->rsp[9],
-			       msg->rsp_size - 10);
-			if (deliver_response(intf, recv_msg))
-				ipmi_inc_stat(intf, unhandled_commands);
-			else
-				ipmi_inc_stat(intf, handled_commands);
-		}
+		/*
+		 * We chop off 10, not 9 bytes because the checksum
+		 * at the end also needs to be removed.
+		 */
+		recv_msg->msg.data_len = msg->rsp_size - 10;
+		memcpy(recv_msg->msg_data, &msg->rsp[9],
+		       msg->rsp_size - 10);
+		if (deliver_response(intf, recv_msg))
+			ipmi_inc_stat(intf, unhandled_commands);
+		else
+			ipmi_inc_stat(intf, handled_commands);
+	} else {
+		/*
+		 * We couldn't allocate memory for the message, so
+		 * requeue it for handling later.
+		 */
+		rv = 1;
 	}
 
 	return rv;
@@ -3993,7 +3975,7 @@ static int handle_ipmb_direct_rcv_cmd(struct ipmi_smi *intf,
 	int                      rv = 0;
 	struct ipmi_user         *user = NULL;
 	struct ipmi_ipmb_direct_addr *daddr;
-	struct ipmi_recv_msg     *recv_msg;
+	struct ipmi_recv_msg     *recv_msg = NULL;
 	unsigned char netfn = msg->rsp[0] >> 2;
 	unsigned char cmd = msg->rsp[3];
 
@@ -4002,9 +3984,8 @@ static int handle_ipmb_direct_rcv_cmd(struct ipmi_smi *intf,
 	rcvr = find_cmd_rcvr(intf, netfn, cmd, 0);
 	if (rcvr) {
 		user = rcvr->user;
-		kref_get(&user->refcount);
-	} else
-		user = NULL;
+		recv_msg = ipmi_alloc_recv_msg(user);
+	}
 	rcu_read_unlock();
 
 	if (user == NULL) {
@@ -4031,44 +4012,38 @@ static int handle_ipmb_direct_rcv_cmd(struct ipmi_smi *intf,
 			rv = -1;
 		}
 		rcu_read_unlock();
-	} else {
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
-			/*
-			 * We couldn't allocate memory for the
-			 * message, so requeue it for handling
-			 * later.
-			 */
-			rv = 1;
-			kref_put(&user->refcount, free_user);
-		} else {
-			/* Extract the source address from the data. */
-			daddr = (struct ipmi_ipmb_direct_addr *)&recv_msg->addr;
-			daddr->addr_type = IPMI_IPMB_DIRECT_ADDR_TYPE;
-			daddr->channel = 0;
-			daddr->slave_addr = msg->rsp[1];
-			daddr->rs_lun = msg->rsp[0] & 3;
-			daddr->rq_lun = msg->rsp[2] & 3;
+	} else if (!IS_ERR(recv_msg)) {
+		/* Extract the source address from the data. */
+		daddr = (struct ipmi_ipmb_direct_addr *)&recv_msg->addr;
+		daddr->addr_type = IPMI_IPMB_DIRECT_ADDR_TYPE;
+		daddr->channel = 0;
+		daddr->slave_addr = msg->rsp[1];
+		daddr->rs_lun = msg->rsp[0] & 3;
+		daddr->rq_lun = msg->rsp[2] & 3;
 
-			/*
-			 * Extract the rest of the message information
-			 * from the IPMB header.
-			 */
-			recv_msg->user = user;
-			recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
-			recv_msg->msgid = (msg->rsp[2] >> 2);
-			recv_msg->msg.netfn = msg->rsp[0] >> 2;
-			recv_msg->msg.cmd = msg->rsp[3];
-			recv_msg->msg.data = recv_msg->msg_data;
-
-			recv_msg->msg.data_len = msg->rsp_size - 4;
-			memcpy(recv_msg->msg_data, msg->rsp + 4,
-			       msg->rsp_size - 4);
-			if (deliver_response(intf, recv_msg))
-				ipmi_inc_stat(intf, unhandled_commands);
-			else
-				ipmi_inc_stat(intf, handled_commands);
-		}
+		/*
+		 * Extract the rest of the message information
+		 * from the IPMB header.
+		 */
+		recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
+		recv_msg->msgid = (msg->rsp[2] >> 2);
+		recv_msg->msg.netfn = msg->rsp[0] >> 2;
+		recv_msg->msg.cmd = msg->rsp[3];
+		recv_msg->msg.data = recv_msg->msg_data;
+
+		recv_msg->msg.data_len = msg->rsp_size - 4;
+		memcpy(recv_msg->msg_data, msg->rsp + 4,
+		       msg->rsp_size - 4);
+		if (deliver_response(intf, recv_msg))
+			ipmi_inc_stat(intf, unhandled_commands);
+		else
+			ipmi_inc_stat(intf, handled_commands);
+	} else {
+		/*
+		 * We couldn't allocate memory for the message, so
+		 * requeue it for handling later.
+		 */
+		rv = 1;
 	}
 
 	return rv;
@@ -4182,7 +4157,7 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
 	unsigned char            chan;
 	struct ipmi_user         *user = NULL;
 	struct ipmi_lan_addr     *lan_addr;
-	struct ipmi_recv_msg     *recv_msg;
+	struct ipmi_recv_msg     *recv_msg = NULL;
 
 	if (msg->rsp_size < 12) {
 		/* Message not big enough, just ignore it. */
@@ -4203,9 +4178,8 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
 	rcvr = find_cmd_rcvr(intf, netfn, cmd, chan);
 	if (rcvr) {
 		user = rcvr->user;
-		kref_get(&user->refcount);
-	} else
-		user = NULL;
+		recv_msg = ipmi_alloc_recv_msg(user);
+	}
 	rcu_read_unlock();
 
 	if (user == NULL) {
@@ -4217,49 +4191,44 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
 		 * them to be freed.
 		 */
 		rv = 0;
-	} else {
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
-			/*
-			 * We couldn't allocate memory for the
-			 * message, so requeue it for handling later.
-			 */
-			rv = 1;
-			kref_put(&user->refcount, free_user);
-		} else {
-			/* Extract the source address from the data. */
-			lan_addr = (struct ipmi_lan_addr *) &recv_msg->addr;
-			lan_addr->addr_type = IPMI_LAN_ADDR_TYPE;
-			lan_addr->session_handle = msg->rsp[4];
-			lan_addr->remote_SWID = msg->rsp[8];
-			lan_addr->local_SWID = msg->rsp[5];
-			lan_addr->lun = msg->rsp[9] & 3;
-			lan_addr->channel = msg->rsp[3] & 0xf;
-			lan_addr->privilege = msg->rsp[3] >> 4;
+	} else if (!IS_ERR(recv_msg)) {
+		/* Extract the source address from the data. */
+		lan_addr = (struct ipmi_lan_addr *) &recv_msg->addr;
+		lan_addr->addr_type = IPMI_LAN_ADDR_TYPE;
+		lan_addr->session_handle = msg->rsp[4];
+		lan_addr->remote_SWID = msg->rsp[8];
+		lan_addr->local_SWID = msg->rsp[5];
+		lan_addr->lun = msg->rsp[9] & 3;
+		lan_addr->channel = msg->rsp[3] & 0xf;
+		lan_addr->privilege = msg->rsp[3] >> 4;
 
-			/*
-			 * Extract the rest of the message information
-			 * from the IPMB header.
-			 */
-			recv_msg->user = user;
-			recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
-			recv_msg->msgid = msg->rsp[9] >> 2;
-			recv_msg->msg.netfn = msg->rsp[6] >> 2;
-			recv_msg->msg.cmd = msg->rsp[10];
-			recv_msg->msg.data = recv_msg->msg_data;
+		/*
+		 * Extract the rest of the message information
+		 * from the IPMB header.
+		 */
+		recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
+		recv_msg->msgid = msg->rsp[9] >> 2;
+		recv_msg->msg.netfn = msg->rsp[6] >> 2;
+		recv_msg->msg.cmd = msg->rsp[10];
+		recv_msg->msg.data = recv_msg->msg_data;
 
-			/*
-			 * We chop off 12, not 11 bytes because the checksum
-			 * at the end also needs to be removed.
-			 */
-			recv_msg->msg.data_len = msg->rsp_size - 12;
-			memcpy(recv_msg->msg_data, &msg->rsp[11],
-			       msg->rsp_size - 12);
-			if (deliver_response(intf, recv_msg))
-				ipmi_inc_stat(intf, unhandled_commands);
-			else
-				ipmi_inc_stat(intf, handled_commands);
-		}
+		/*
+		 * We chop off 12, not 11 bytes because the checksum
+		 * at the end also needs to be removed.
+		 */
+		recv_msg->msg.data_len = msg->rsp_size - 12;
+		memcpy(recv_msg->msg_data, &msg->rsp[11],
+		       msg->rsp_size - 12);
+		if (deliver_response(intf, recv_msg))
+			ipmi_inc_stat(intf, unhandled_commands);
+		else
+			ipmi_inc_stat(intf, handled_commands);
+	} else {
+		/*
+		 * We couldn't allocate memory for the message, so
+		 * requeue it for handling later.
+		 */
+		rv = 1;
 	}
 
 	return rv;
@@ -4281,7 +4250,7 @@ static int handle_oem_get_msg_cmd(struct ipmi_smi *intf,
 	unsigned char         chan;
 	struct ipmi_user *user = NULL;
 	struct ipmi_system_interface_addr *smi_addr;
-	struct ipmi_recv_msg  *recv_msg;
+	struct ipmi_recv_msg  *recv_msg = NULL;
 
 	/*
 	 * We expect the OEM SW to perform error checking
@@ -4310,9 +4279,8 @@ static int handle_oem_get_msg_cmd(struct ipmi_smi *intf,
 	rcvr = find_cmd_rcvr(intf, netfn, cmd, chan);
 	if (rcvr) {
 		user = rcvr->user;
-		kref_get(&user->refcount);
-	} else
-		user = NULL;
+		recv_msg = ipmi_alloc_recv_msg(user);
+	}
 	rcu_read_unlock();
 
 	if (user == NULL) {
@@ -4325,48 +4293,42 @@ static int handle_oem_get_msg_cmd(struct ipmi_smi *intf,
 		 */
 
 		rv = 0;
-	} else {
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
-			/*
-			 * We couldn't allocate memory for the
-			 * message, so requeue it for handling
-			 * later.
-			 */
-			rv = 1;
-			kref_put(&user->refcount, free_user);
-		} else {
-			/*
-			 * OEM Messages are expected to be delivered via
-			 * the system interface to SMS software.  We might
-			 * need to visit this again depending on OEM
-			 * requirements
-			 */
-			smi_addr = ((struct ipmi_system_interface_addr *)
-				    &recv_msg->addr);
-			smi_addr->addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
-			smi_addr->channel = IPMI_BMC_CHANNEL;
-			smi_addr->lun = msg->rsp[0] & 3;
-
-			recv_msg->user = user;
-			recv_msg->user_msg_data = NULL;
-			recv_msg->recv_type = IPMI_OEM_RECV_TYPE;
-			recv_msg->msg.netfn = msg->rsp[0] >> 2;
-			recv_msg->msg.cmd = msg->rsp[1];
-			recv_msg->msg.data = recv_msg->msg_data;
+	} else if (!IS_ERR(recv_msg)) {
+		/*
+		 * OEM Messages are expected to be delivered via
+		 * the system interface to SMS software.  We might
+		 * need to visit this again depending on OEM
+		 * requirements
+		 */
+		smi_addr = ((struct ipmi_system_interface_addr *)
+			    &recv_msg->addr);
+		smi_addr->addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+		smi_addr->channel = IPMI_BMC_CHANNEL;
+		smi_addr->lun = msg->rsp[0] & 3;
+
+		recv_msg->user_msg_data = NULL;
+		recv_msg->recv_type = IPMI_OEM_RECV_TYPE;
+		recv_msg->msg.netfn = msg->rsp[0] >> 2;
+		recv_msg->msg.cmd = msg->rsp[1];
+		recv_msg->msg.data = recv_msg->msg_data;
 
-			/*
-			 * The message starts at byte 4 which follows the
-			 * Channel Byte in the "GET MESSAGE" command
-			 */
-			recv_msg->msg.data_len = msg->rsp_size - 4;
-			memcpy(recv_msg->msg_data, &msg->rsp[4],
-			       msg->rsp_size - 4);
-			if (deliver_response(intf, recv_msg))
-				ipmi_inc_stat(intf, unhandled_commands);
-			else
-				ipmi_inc_stat(intf, handled_commands);
-		}
+		/*
+		 * The message starts at byte 4 which follows the
+		 * Channel Byte in the "GET MESSAGE" command
+		 */
+		recv_msg->msg.data_len = msg->rsp_size - 4;
+		memcpy(recv_msg->msg_data, &msg->rsp[4],
+		       msg->rsp_size - 4);
+		if (deliver_response(intf, recv_msg))
+			ipmi_inc_stat(intf, unhandled_commands);
+		else
+			ipmi_inc_stat(intf, handled_commands);
+	} else {
+		/*
+		 * We couldn't allocate memory for the message, so
+		 * requeue it for handling later.
+		 */
+		rv = 1;
 	}
 
 	return rv;
@@ -4425,8 +4387,8 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
 		if (!user->gets_events)
 			continue;
 
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
+		recv_msg = ipmi_alloc_recv_msg(user);
+		if (IS_ERR(recv_msg)) {
 			rcu_read_unlock();
 			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs,
 						 link) {
@@ -4445,8 +4407,6 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
 		deliver_count++;
 
 		copy_event_into_recv_msg(recv_msg, msg);
-		recv_msg->user = user;
-		kref_get(&user->refcount);
 		list_add_tail(&recv_msg->link, &msgs);
 	}
 	srcu_read_unlock(&intf->users_srcu, index);
@@ -4462,8 +4422,8 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
 		 * No one to receive the message, put it in queue if there's
 		 * not already too many things in the queue.
 		 */
-		recv_msg = ipmi_alloc_recv_msg();
-		if (!recv_msg) {
+		recv_msg = ipmi_alloc_recv_msg(NULL);
+		if (IS_ERR(recv_msg)) {
 			/*
 			 * We couldn't allocate memory for the
 			 * message, so requeue it for handling
@@ -5155,27 +5115,51 @@ static void free_recv_msg(struct ipmi_recv_msg *msg)
 		kfree(msg);
 }
 
-static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void)
+static struct ipmi_recv_msg *ipmi_alloc_recv_msg(struct ipmi_user *user)
 {
 	struct ipmi_recv_msg *rv;
 
+	if (user) {
+		if (atomic_add_return(1, &user->nr_msgs) > max_msgs_per_user) {
+			atomic_dec(&user->nr_msgs);
+			return ERR_PTR(-EBUSY);
+		}
+	}
+
 	rv = kmalloc(sizeof(struct ipmi_recv_msg), GFP_ATOMIC);
-	if (rv) {
-		rv->user = NULL;
-		rv->done = free_recv_msg;
-		atomic_inc(&recv_msg_inuse_count);
+	if (!rv) {
+		if (user)
+			atomic_dec(&user->nr_msgs);
+		return ERR_PTR(-ENOMEM);
 	}
+
+	rv->user = user;
+	rv->done = free_recv_msg;
+	if (user)
+		kref_get(&user->refcount);
+	atomic_inc(&recv_msg_inuse_count);
 	return rv;
 }
 
 void ipmi_free_recv_msg(struct ipmi_recv_msg *msg)
 {
-	if (msg->user && !oops_in_progress)
+	if (msg->user && !oops_in_progress) {
+		atomic_dec(&msg->user->nr_msgs);
 		kref_put(&msg->user->refcount, free_user);
+	}
 	msg->done(msg);
 }
 EXPORT_SYMBOL(ipmi_free_recv_msg);
 
+static void ipmi_set_recv_msg_user(struct ipmi_recv_msg *msg,
+				   struct ipmi_user *user)
+{
+	WARN_ON_ONCE(msg->user); /* User should not be set. */
+	msg->user = user;
+	atomic_inc(&user->nr_msgs);
+	kref_get(&user->refcount);
+}
+
 static atomic_t panic_done_count = ATOMIC_INIT(0);
 
 static void dummy_smi_done_handler(struct ipmi_smi_msg *msg)
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index ed0d3d8449b3..59e992dc65c4 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -977,8 +977,8 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
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
index c173a44c800a..629f050a855a 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -279,8 +279,11 @@ static int clk_sam9x5_peripheral_determine_rate(struct clk_hw *hw,
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
diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
index bb648a88e43a..ad47fdb23460 100644
--- a/drivers/clk/mediatek/clk-mt8195-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
@@ -103,7 +103,7 @@ static const struct mtk_gate infra_ao_clks[] = {
 	GATE_INFRA_AO0(CLK_INFRA_AO_CQ_DMA_FPC, "infra_ao_cq_dma_fpc", "fpc", 28),
 	GATE_INFRA_AO0(CLK_INFRA_AO_UART5, "infra_ao_uart5", "top_uart", 29),
 	/* INFRA_AO1 */
-	GATE_INFRA_AO1(CLK_INFRA_AO_HDMI_26M, "infra_ao_hdmi_26m", "clk26m", 0),
+	GATE_INFRA_AO1(CLK_INFRA_AO_HDMI_26M, "infra_ao_hdmi_26m", "top_hdmi_xtal", 0),
 	GATE_INFRA_AO1(CLK_INFRA_AO_SPI0, "infra_ao_spi0", "top_spi", 1),
 	GATE_INFRA_AO1(CLK_INFRA_AO_MSDC0, "infra_ao_msdc0", "top_msdc50_0_hclk", 2),
 	GATE_INFRA_AO1(CLK_INFRA_AO_MSDC1, "infra_ao_msdc1", "top_axi", 4),
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 60990296450b..9a12e58230be 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -146,9 +146,7 @@ static int mtk_clk_mux_set_parent_setclr_lock(struct clk_hw *hw, u8 index)
 static int mtk_clk_mux_determine_rate(struct clk_hw *hw,
 				      struct clk_rate_request *req)
 {
-	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
-
-	return clk_mux_determine_rate_flags(hw, req, mux->data->flags);
+	return clk_mux_determine_rate_flags(hw, req, 0);
 }
 
 const struct clk_ops mtk_mux_clr_set_upd_ops = {
diff --git a/drivers/clk/nxp/clk-lpc18xx-cgu.c b/drivers/clk/nxp/clk-lpc18xx-cgu.c
index 81efa885069b..b9e204d63a97 100644
--- a/drivers/clk/nxp/clk-lpc18xx-cgu.c
+++ b/drivers/clk/nxp/clk-lpc18xx-cgu.c
@@ -370,23 +370,25 @@ static unsigned long lpc18xx_pll0_recalc_rate(struct clk_hw *hw,
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
@@ -402,7 +404,7 @@ static int lpc18xx_pll0_set_rate(struct clk_hw *hw, unsigned long rate,
 	}
 
 	m = DIV_ROUND_UP_ULL(parent_rate, rate * 2);
-	if (m <= 0 && m > LPC18XX_PLL0_MSEL_MAX) {
+	if (m == 0 || m > LPC18XX_PLL0_MSEL_MAX) {
 		pr_warn("%s: unable to support rate %lu\n", __func__, rate);
 		return -EINVAL;
 	}
@@ -443,7 +445,7 @@ static int lpc18xx_pll0_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops lpc18xx_pll0_ops = {
 	.recalc_rate	= lpc18xx_pll0_recalc_rate,
-	.round_rate	= lpc18xx_pll0_round_rate,
+	.determine_rate = lpc18xx_pll0_determine_rate,
 	.set_rate	= lpc18xx_pll0_set_rate,
 };
 
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 33cc1f73c69d..cab2dbb7a8d4 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -273,8 +273,8 @@ static int qcom_cc_icc_register(struct device *dev,
 		icd[i].slave_id = desc->icc_hws[i].slave_id;
 		hws = &desc->clks[desc->icc_hws[i].clk_id]->hw;
 		icd[i].clk = devm_clk_hw_get_clk(dev, hws, "icc");
-		if (!icd[i].clk)
-			return dev_err_probe(dev, -ENOENT,
+		if (IS_ERR(icd[i].clk))
+			return dev_err_probe(dev, PTR_ERR(icd[i].clk),
 					     "(%d) clock entry is null\n", i);
 		icd[i].name = clk_hw_get_name(hws);
 	}
diff --git a/drivers/clk/qcom/tcsrcc-x1e80100.c b/drivers/clk/qcom/tcsrcc-x1e80100.c
index ff61769a0807..a367e1f55622 100644
--- a/drivers/clk/qcom/tcsrcc-x1e80100.c
+++ b/drivers/clk/qcom/tcsrcc-x1e80100.c
@@ -29,6 +29,10 @@ static struct clk_branch tcsr_edp_clkref_en = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "tcsr_edp_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 0f27c33192e1..112ed81f648e 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -1012,6 +1012,7 @@ static int __init cpg_mssr_reserved_init(struct cpg_mssr_priv *priv,
 
 		of_for_each_phandle(&it, rc, node, "clocks", "#clock-cells", -1) {
 			int idx;
+			unsigned int *new_ids;
 
 			if (it.node != priv->np)
 				continue;
@@ -1022,11 +1023,13 @@ static int __init cpg_mssr_reserved_init(struct cpg_mssr_priv *priv,
 			if (args[0] != CPG_MOD)
 				continue;
 
-			ids = krealloc_array(ids, (num + 1), sizeof(*ids), GFP_KERNEL);
-			if (!ids) {
+			new_ids = krealloc_array(ids, (num + 1), sizeof(*ids), GFP_KERNEL);
+			if (!new_ids) {
 				of_node_put(it.node);
+				kfree(ids);
 				return -ENOMEM;
 			}
+			ids = new_ids;
 
 			if (priv->reg_layout == CLK_REG_LAYOUT_RZ_A)
 				idx = MOD_CLK_PACK_10(args[1]);	/* for DEF_MOD_STB() */
diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index 7bfba0afd778..4ec408c3a26a 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -635,7 +635,7 @@ static int tegra_bpmp_register_clocks(struct tegra_bpmp *bpmp,
 
 	bpmp->num_clocks = count;
 
-	bpmp->clocks = devm_kcalloc(bpmp->dev, count, sizeof(struct tegra_bpmp_clk), GFP_KERNEL);
+	bpmp->clocks = devm_kcalloc(bpmp->dev, count, sizeof(*bpmp->clocks), GFP_KERNEL);
 	if (!bpmp->clocks)
 		return -ENOMEM;
 
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
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 983443396f8f..30e1b64d0558 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -110,7 +110,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
 	if (!transition_latency)
-		transition_latency = CPUFREQ_ETERNAL;
+		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	cpumask_copy(policy->cpus, priv->cpus);
 	policy->driver_data = priv;
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index c20d3ecc5a81..33c1df7f683e 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -443,7 +443,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	if (of_property_read_u32(np, "clock-latency", &transition_latency))
-		transition_latency = CPUFREQ_ETERNAL;
+		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	/*
 	 * Calculate the ramp time for max voltage change in the
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index e90871092038..d0f4f7c2ae4d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1582,10 +1582,10 @@ static void update_qos_request(enum freq_qos_req_type type)
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
@@ -1601,6 +1601,8 @@ static void update_qos_request(enum freq_qos_req_type type)
 
 		if (freq_qos_update_request(req, freq) < 0)
 			pr_warn("Failed to update freq constraint: CPU%d\n", i);
+
+		cpufreq_cpu_put(policy);
 	}
 }
 
diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index aeb5e6304542..1f1ec43aad7c 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -238,7 +238,7 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	latency = readl_relaxed(data->reg_bases[REG_FREQ_LATENCY]) * 1000;
 	if (!latency)
-		latency = CPUFREQ_ETERNAL;
+		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 	policy->fast_switch_possible = true;
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index a2ec1addafc9..bb265541671a 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -280,7 +280,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 
 	latency = perf_ops->transition_latency_get(ph, domain);
 	if (!latency)
-		latency = CPUFREQ_ETERNAL;
+		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index a191d9bdf667..bdbc3923629e 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -157,7 +157,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 
 	latency = scpi_ops->get_transition_latency(cpu_dev);
 	if (!latency)
-		latency = CPUFREQ_ETERNAL;
+		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 
diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index d8ab5b01d46d..c032dd5d12d3 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -183,7 +183,7 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
 
 	if (of_property_read_u32(np, "clock-latency",
 				&spear_cpufreq.transition_latency))
-		spear_cpufreq.transition_latency = CPUFREQ_ETERNAL;
+		spear_cpufreq.transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	cnt = of_property_count_u32_elems(np, "cpufreq_tbl");
 	if (cnt <= 0) {
diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 7b8fcfa55038..39186008afbf 100644
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
diff --git a/drivers/crypto/aspeed/aspeed-hace-crypto.c b/drivers/crypto/aspeed/aspeed-hace-crypto.c
index a72dfebc53ff..fa201dae1f81 100644
--- a/drivers/crypto/aspeed/aspeed-hace-crypto.c
+++ b/drivers/crypto/aspeed/aspeed-hace-crypto.c
@@ -346,7 +346,7 @@ static int aspeed_sk_start_sg(struct aspeed_hace_dev *hace_dev)
 
 	} else {
 		dma_unmap_sg(hace_dev->dev, req->dst, rctx->dst_nents,
-			     DMA_TO_DEVICE);
+			     DMA_FROM_DEVICE);
 		dma_unmap_sg(hace_dev->dev, req->src, rctx->src_nents,
 			     DMA_TO_DEVICE);
 	}
diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index dcc2380a5889..d15b2e943447 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -512,7 +512,7 @@ static int atmel_tdes_crypt_start(struct atmel_tdes_dev *dd)
 
 	if (err && (dd->flags & TDES_FLAGS_FAST)) {
 		dma_unmap_sg(dd->dev, dd->in_sg, 1, DMA_TO_DEVICE);
-		dma_unmap_sg(dd->dev, dd->out_sg, 1, DMA_TO_DEVICE);
+		dma_unmap_sg(dd->dev, dd->out_sg, 1, DMA_FROM_DEVICE);
 	}
 
 	return err;
diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 69d6019d8abc..ba26b4db7a60 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -252,7 +252,7 @@ static void rk_hash_unprepare(struct crypto_engine *engine, void *breq)
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
 	struct rk_crypto_info *rkc = rctx->dev;
 
-	dma_unmap_sg(rkc->dev, areq->src, rctx->nrsg, DMA_TO_DEVICE);
+	dma_unmap_sg(rkc->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
 }
 
 static int rk_hash_run(struct crypto_engine *engine, void *breq)
diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index f25a9746249b..3ab67aaa9e5d 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -232,11 +232,16 @@ EXPORT_SYMBOL(meson_sm_call_write);
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
index cfa7b0a50c8e..03b16b8f639a 100644
--- a/drivers/gpio/gpio-wcd934x.c
+++ b/drivers/gpio/gpio-wcd934x.c
@@ -102,7 +102,7 @@ static int wcd_gpio_probe(struct platform_device *pdev)
 	chip->base = -1;
 	chip->ngpio = WCD934X_NPINS;
 	chip->label = dev_name(dev);
-	chip->can_sleep = false;
+	chip->can_sleep = true;
 
 	return devm_gpiochip_add_data(dev, chip, data);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b02ff92bae0b..ffa0d7483ffc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2027,6 +2027,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.flags.disable_ips_in_vpb = 0;
 
+	/* DCN35 and above supports dynamic DTBCLK switch */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 5, 0))
+		init_data.flags.allow_0_dtb_clk = true;
+
 	/* Enable DWB for tested platforms only */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0))
 		init_data.num_virtual_links = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 2b1673d69ea8..1ab5ae9b5ea5 100644
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
index bd8085ec54ed..da5596fbfdcb 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
@@ -8648,6 +8648,8 @@
 #define REGAMMA_LUT_INDEX__REGAMMA_LUT_INDEX__SHIFT 0x00000000
 #define REGAMMA_LUT_WRITE_EN_MASK__REGAMMA_LUT_WRITE_EN_MASK_MASK 0x00000007L
 #define REGAMMA_LUT_WRITE_EN_MASK__REGAMMA_LUT_WRITE_EN_MASK__SHIFT 0x00000000
+#define SCL_SCALER_ENABLE__SCL_SCALE_EN_MASK 0x00000001L
+#define SCL_SCALER_ENABLE__SCL_SCALE_EN__SHIFT 0x00000000
 #define SCL_ALU_CONTROL__SCL_ALU_DISABLE_MASK 0x00000001L
 #define SCL_ALU_CONTROL__SCL_ALU_DISABLE__SHIFT 0x00000000
 #define SCL_BYPASS_CONTROL__SCL_BYPASS_MODE_MASK 0x00000003L
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 2016c1e7242f..fc433f39c127 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -852,7 +852,7 @@ nouveau_bo_move_prep(struct nouveau_drm *drm, struct ttm_buffer_object *bo,
 		nvif_vmm_put(vmm, &old_mem->vma[1]);
 		nvif_vmm_put(vmm, &old_mem->vma[0]);
 	}
-	return 0;
+	return ret;
 }
 
 static int
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 03eb7d52209a..9360d486e52e 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1032,14 +1032,15 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
 
 	ret = group_priority_permit(file, args->priority);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = panthor_group_create(pfile, args, queue_args);
-	if (ret >= 0) {
-		args->group_handle = ret;
-		ret = 0;
-	}
+	if (ret < 0)
+		goto out;
+	args->group_handle = ret;
+	ret = 0;
 
+out:
 	kvfree(queue_args);
 	return ret;
 }
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
index 92f4261305bd..f2ae5d17ea60 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
@@ -576,7 +576,10 @@ static int rcar_mipi_dsi_startup(struct rcar_mipi_dsi *dsi,
 	udelay(10);
 	rcar_mipi_dsi_clr(dsi, CLOCKSET1, CLOCKSET1_UPDATEPLL);
 
-	ppisetr = PPISETR_DLEN_3 | PPISETR_CLEN;
+	rcar_mipi_dsi_clr(dsi, TXSETR, TXSETR_LANECNT_MASK);
+	rcar_mipi_dsi_set(dsi, TXSETR, dsi->lanes - 1);
+
+	ppisetr = ((BIT(dsi->lanes) - 1) & PPISETR_DLEN_MASK) | PPISETR_CLEN;
 	rcar_mipi_dsi_write(dsi, PPISETR, ppisetr);
 
 	rcar_mipi_dsi_set(dsi, PHYSETUP, PHYSETUP_SHUTDOWNZ);
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h
index a6b276f1d6ee..a54c7eb4113b 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h
@@ -12,6 +12,9 @@
 #define LINKSR_LPBUSY			(1 << 1)
 #define LINKSR_HSBUSY			(1 << 0)
 
+#define TXSETR				0x100
+#define TXSETR_LANECNT_MASK		(0x3 << 0)
+
 /*
  * Video Mode Register
  */
@@ -80,10 +83,7 @@
  * PHY-Protocol Interface (PPI) Registers
  */
 #define PPISETR				0x700
-#define PPISETR_DLEN_0			(0x1 << 0)
-#define PPISETR_DLEN_1			(0x3 << 0)
-#define PPISETR_DLEN_2			(0x7 << 0)
-#define PPISETR_DLEN_3			(0xf << 0)
+#define PPISETR_DLEN_MASK		(0xf << 0)
 #define PPISETR_CLEN			(1 << 8)
 
 #define PPICLCR				0x710
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index ea741bc4ac3f..8b72848bb25c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1515,6 +1515,7 @@ static int vmw_cmd_dma(struct vmw_private *dev_priv,
 		       SVGA3dCmdHeader *header)
 {
 	struct vmw_bo *vmw_bo = NULL;
+	struct vmw_resource *res;
 	struct vmw_surface *srf = NULL;
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdSurfaceDMA);
 	int ret;
@@ -1550,18 +1551,24 @@ static int vmw_cmd_dma(struct vmw_private *dev_priv,
 
 	dirty = (cmd->body.transfer == SVGA3D_WRITE_HOST_VRAM) ?
 		VMW_RES_DIRTY_SET : 0;
-	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
-				dirty, user_surface_converter,
-				&cmd->body.host.sid, NULL);
+	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface, dirty,
+				user_surface_converter, &cmd->body.host.sid,
+				NULL);
 	if (unlikely(ret != 0)) {
 		if (unlikely(ret != -ERESTARTSYS))
 			VMW_DEBUG_USER("could not find surface for DMA.\n");
 		return ret;
 	}
 
-	srf = vmw_res_to_srf(sw_context->res_cache[vmw_res_surface].res);
+	res = sw_context->res_cache[vmw_res_surface].res;
+	if (!res) {
+		VMW_DEBUG_USER("Invalid DMA surface.\n");
+		return -EINVAL;
+	}
 
-	vmw_kms_cursor_snoop(srf, sw_context->fp->tfile, &vmw_bo->tbo, header);
+	srf = vmw_res_to_srf(res);
+	vmw_kms_cursor_snoop(srf, sw_context->fp->tfile, &vmw_bo->tbo,
+			     header);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
index e7625b3f71e0..80e8bbc3021d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
@@ -309,8 +309,10 @@ int vmw_validation_add_resource(struct vmw_validation_context *ctx,
 		hash_add_rcu(ctx->sw_context->res_ht, &node->hash.head, node->hash.key);
 	}
 	node->res = vmw_resource_reference_unless_doomed(res);
-	if (!node->res)
+	if (!node->res) {
+		hash_del_rcu(&node->hash.head);
 		return -ESRCH;
+	}
 
 	node->first_usage = 1;
 	if (!res->dev_priv->has_mob) {
@@ -637,7 +639,7 @@ void vmw_validation_drop_ht(struct vmw_validation_context *ctx)
 		hash_del_rcu(&val->hash.head);
 
 	list_for_each_entry(val, &ctx->resource_ctx_list, head)
-		hash_del_rcu(&entry->hash.head);
+		hash_del_rcu(&val->hash.head);
 
 	ctx->sw_context = NULL;
 }
diff --git a/drivers/gpu/drm/xe/xe_hw_engine_group.c b/drivers/gpu/drm/xe/xe_hw_engine_group.c
index 82750520a90a..f14a3cc7d117 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine_group.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine_group.c
@@ -237,17 +237,13 @@ static int xe_hw_engine_group_suspend_faulting_lr_jobs(struct xe_hw_engine_group
 
 		err = q->ops->suspend_wait(q);
 		if (err)
-			goto err_suspend;
+			return err;
 	}
 
 	if (need_resume)
 		xe_hw_engine_group_resume_faulting_lr_jobs(group);
 
 	return 0;
-
-err_suspend:
-	up_write(&group->mode_sem);
-	return err;
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
index 6e7c940d7e22..71a5e852fbac 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -277,8 +277,7 @@ static int query_mem_regions(struct xe_device *xe,
 	mem_regions->mem_regions[0].instance = 0;
 	mem_regions->mem_regions[0].min_page_size = PAGE_SIZE;
 	mem_regions->mem_regions[0].total_size = man->size << PAGE_SHIFT;
-	if (perfmon_capable())
-		mem_regions->mem_regions[0].used = ttm_resource_manager_usage(man);
+	mem_regions->mem_regions[0].used = ttm_resource_manager_usage(man);
 	mem_regions->num_mem_regions = 1;
 
 	for (i = XE_PL_VRAM0; i <= XE_PL_VRAM1; ++i) {
@@ -294,13 +293,11 @@ static int query_mem_regions(struct xe_device *xe,
 			mem_regions->mem_regions[mem_regions->num_mem_regions].total_size =
 				man->size;
 
-			if (perfmon_capable()) {
-				xe_ttm_vram_get_used(man,
-					&mem_regions->mem_regions
-					[mem_regions->num_mem_regions].used,
-					&mem_regions->mem_regions
-					[mem_regions->num_mem_regions].cpu_visible_used);
-			}
+			xe_ttm_vram_get_used(man,
+					     &mem_regions->mem_regions
+					     [mem_regions->num_mem_regions].used,
+					     &mem_regions->mem_regions
+					     [mem_regions->num_mem_regions].cpu_visible_used);
 
 			mem_regions->mem_regions[mem_regions->num_mem_regions].cpu_visible_size =
 				xe_ttm_vram_get_cpu_visible_size(man);
diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index c3f9fa307b84..2db16c36d814 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -88,6 +88,7 @@
 #define PAC1934_VPOWER_3_ADDR			0x19
 #define PAC1934_VPOWER_4_ADDR			0x1A
 #define PAC1934_REFRESH_V_REG_ADDR		0x1F
+#define PAC1934_SLOW_REG_ADDR			0x20
 #define PAC1934_CTRL_STAT_REGS_ADDR		0x1C
 #define PAC1934_PID_REG_ADDR			0xFD
 #define PAC1934_MID_REG_ADDR			0xFE
@@ -1265,8 +1266,23 @@ static int pac1934_chip_configure(struct pac1934_chip_info *info)
 	/* no SLOW triggered REFRESH, clear POR */
 	regs[PAC1934_SLOW_REG_OFF] = 0;
 
-	ret =  i2c_smbus_write_block_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
-					  ARRAY_SIZE(regs), (u8 *)regs);
+	/*
+	 * Write the three bytes sequentially, as the device does not support
+	 * block write.
+	 */
+	ret = i2c_smbus_write_byte_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
+					regs[PAC1934_CHANNEL_DIS_REG_OFF]);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client,
+					PAC1934_CTRL_STAT_REGS_ADDR + PAC1934_NEG_PWR_REG_OFF,
+					regs[PAC1934_NEG_PWR_REG_OFF]);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, PAC1934_SLOW_REG_ADDR,
+					regs[PAC1934_SLOW_REG_OFF]);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index ebc583b07e0c..e12eb7137b06 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -118,7 +118,7 @@
 #define AMS_ALARM_THRESHOLD_OFF_10	0x10
 #define AMS_ALARM_THRESHOLD_OFF_20	0x20
 
-#define AMS_ALARM_THR_DIRECT_MASK	BIT(1)
+#define AMS_ALARM_THR_DIRECT_MASK	BIT(0)
 #define AMS_ALARM_THR_MIN		0x0000
 #define AMS_ALARM_THR_MAX		(BIT(16) - 1)
 
@@ -389,6 +389,29 @@ static void ams_update_pl_alarm(struct ams *ams, unsigned long alarm_mask)
 	ams_pl_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK, cfg);
 }
 
+static void ams_unmask(struct ams *ams)
+{
+	unsigned int status, unmask;
+
+	status = readl(ams->base + AMS_ISR_0);
+
+	/* Clear those bits which are not active anymore */
+	unmask = (ams->current_masked_alarm ^ status) & ams->current_masked_alarm;
+
+	/* Clear status of disabled alarm */
+	unmask |= ams->intr_mask;
+
+	ams->current_masked_alarm &= status;
+
+	/* Also clear those which are masked out anyway */
+	ams->current_masked_alarm &= ~ams->intr_mask;
+
+	/* Clear the interrupts before we unmask them */
+	writel(unmask, ams->base + AMS_ISR_0);
+
+	ams_update_intrmask(ams, ~AMS_ALARM_MASK, ~AMS_ALARM_MASK);
+}
+
 static void ams_update_alarm(struct ams *ams, unsigned long alarm_mask)
 {
 	unsigned long flags;
@@ -401,6 +424,7 @@ static void ams_update_alarm(struct ams *ams, unsigned long alarm_mask)
 
 	spin_lock_irqsave(&ams->intr_lock, flags);
 	ams_update_intrmask(ams, AMS_ISR0_ALARM_MASK, ~alarm_mask);
+	ams_unmask(ams);
 	spin_unlock_irqrestore(&ams->intr_lock, flags);
 }
 
@@ -1035,28 +1059,9 @@ static void ams_handle_events(struct iio_dev *indio_dev, unsigned long events)
 static void ams_unmask_worker(struct work_struct *work)
 {
 	struct ams *ams = container_of(work, struct ams, ams_unmask_work.work);
-	unsigned int status, unmask;
 
 	spin_lock_irq(&ams->intr_lock);
-
-	status = readl(ams->base + AMS_ISR_0);
-
-	/* Clear those bits which are not active anymore */
-	unmask = (ams->current_masked_alarm ^ status) & ams->current_masked_alarm;
-
-	/* Clear status of disabled alarm */
-	unmask |= ams->intr_mask;
-
-	ams->current_masked_alarm &= status;
-
-	/* Also clear those which are masked out anyway */
-	ams->current_masked_alarm &= ~ams->intr_mask;
-
-	/* Clear the interrupts before we unmask them */
-	writel(unmask, ams->base + AMS_ISR_0);
-
-	ams_update_intrmask(ams, ~AMS_ALARM_MASK, ~AMS_ALARM_MASK);
-
+	ams_unmask(ams);
 	spin_unlock_irq(&ams->intr_lock);
 
 	/* If still pending some alarm re-trigger the timer */
diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index e0b7f658d611..cf9cf90cd6e2 100644
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
index 7644acfd879e..9228e3cee1b8 100644
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
index e13e64a5164c..f58d23c049ec 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -149,6 +149,19 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
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
@@ -157,13 +170,6 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
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
index 73aeddf53b76..790bc8fbf21d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -847,10 +847,6 @@ static int inv_icm42600_resume(struct device *dev)
 	if (ret)
 		goto out_unlock;
 
-	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
 	/* restore sensors state */
 	ret = inv_icm42600_set_pwr_mgmt0(st, st->suspended.gyro,
 					 st->suspended.accel,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 32d6710e264a..667407974e23 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3952,7 +3952,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 			}
 
 			if (info->ats_supported && ecap_prs(iommu->ecap) &&
-			    pci_pri_supported(pdev))
+			    ecap_pds(iommu->ecap) && pci_pri_supported(pdev))
 				info->pri_supported = 1;
 		}
 	}
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 36dbcf2d728a..9c4af7d58846 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -252,11 +252,11 @@ static int plic_irq_suspend(void)
 
 	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
 
-	for (i = 0; i < priv->nr_irqs; i++)
-		if (readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID))
-			__set_bit(i, priv->prio_save);
-		else
-			__clear_bit(i, priv->prio_save);
+	/* irq ID 0 is reserved */
+	for (i = 1; i < priv->nr_irqs; i++) {
+		__assign_bit(i, priv->prio_save,
+			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
+	}
 
 	for_each_cpu(cpu, cpu_present_mask) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
@@ -284,7 +284,8 @@ static void plic_irq_resume(void)
 
 	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
 
-	for (i = 0; i < priv->nr_irqs; i++) {
+	/* irq ID 0 is reserved */
+	for (i = 1; i < priv->nr_irqs; i++) {
 		index = BIT_WORD(i);
 		writel((priv->prio_save[index] & BIT_MASK(i)) ? 1 : 0,
 		       priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index d24f71819c3d..38ab35157c85 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -379,20 +379,13 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
 	struct cmdq_task *task;
 	unsigned long curr_pa, end_pa;
-	int ret;
 
 	/* Client should not flush new tasks if suspended. */
 	WARN_ON(cmdq->suspended);
 
-	ret = pm_runtime_get_sync(cmdq->mbox.dev);
-	if (ret < 0)
-		return ret;
-
 	task = kzalloc(sizeof(*task), GFP_ATOMIC);
-	if (!task) {
-		pm_runtime_put_autosuspend(cmdq->mbox.dev);
+	if (!task)
 		return -ENOMEM;
-	}
 
 	task->cmdq = cmdq;
 	INIT_LIST_HEAD(&task->list_entry);
@@ -439,9 +432,6 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	}
 	list_move_tail(&task->list_entry, &thread->task_busy_list);
 
-	pm_runtime_mark_last_busy(cmdq->mbox.dev);
-	pm_runtime_put_autosuspend(cmdq->mbox.dev);
-
 	return 0;
 }
 
diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index d59fcb74b347..5bf81b60e9e6 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -62,7 +62,8 @@
 #define DST_BIT_POS	9U
 #define SRC_BITMASK	GENMASK(11, 8)
 
-#define MAX_SGI 16
+/* Macro to represent SGI type for IPI IRQs */
+#define IPI_IRQ_TYPE_SGI	2
 
 /*
  * Module parameters
@@ -121,6 +122,7 @@ struct zynqmp_ipi_mbox {
  * @dev:                  device pointer corresponding to the Xilinx ZynqMP
  *                        IPI agent
  * @irq:                  IPI agent interrupt ID
+ * @irq_type:             IPI SGI or SPI IRQ type
  * @method:               IPI SMC or HVC is going to be used
  * @local_id:             local IPI agent ID
  * @virq_sgi:             IRQ number mapped to SGI
@@ -130,6 +132,7 @@ struct zynqmp_ipi_mbox {
 struct zynqmp_ipi_pdata {
 	struct device *dev;
 	int irq;
+	unsigned int irq_type;
 	unsigned int method;
 	u32 local_id;
 	int virq_sgi;
@@ -887,17 +890,14 @@ static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
 	struct zynqmp_ipi_mbox *ipi_mbox;
 	int i;
 
-	if (pdata->irq < MAX_SGI)
+	if (pdata->irq_type == IPI_IRQ_TYPE_SGI)
 		xlnx_mbox_cleanup_sgi(pdata);
 
-	i = pdata->num_mboxes;
+	i = pdata->num_mboxes - 1;
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
 
@@ -959,14 +959,16 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to parse interrupts\n");
 		goto free_mbox_dev;
 	}
-	ret = out_irq.args[1];
+
+	/* Use interrupt type to distinguish SGI and SPI interrupts */
+	pdata->irq_type = out_irq.args[0];
 
 	/*
 	 * If Interrupt number is in SGI range, then request SGI else request
 	 * IPI system IRQ.
 	 */
-	if (ret < MAX_SGI) {
-		pdata->irq = ret;
+	if (pdata->irq_type == IPI_IRQ_TYPE_SGI) {
+		pdata->irq = out_irq.args[1];
 		ret = xlnx_mbox_init_sgi(pdev, pdata->irq, pdata);
 		if (ret)
 			goto free_mbox_dev;
diff --git a/drivers/media/cec/usb/extron-da-hd-4k-plus/Makefile b/drivers/media/cec/usb/extron-da-hd-4k-plus/Makefile
index 2e8f7f60263f..08d58524419f 100644
--- a/drivers/media/cec/usb/extron-da-hd-4k-plus/Makefile
+++ b/drivers/media/cec/usb/extron-da-hd-4k-plus/Makefile
@@ -1,8 +1,2 @@
 extron-da-hd-4k-plus-cec-objs := extron-da-hd-4k-plus.o cec-splitter.o
 obj-$(CONFIG_USB_EXTRON_DA_HD_4K_PLUS_CEC) := extron-da-hd-4k-plus-cec.o
-
-all:
-	$(MAKE) -C $(KDIR) M=$(shell pwd) modules
-
-install:
-	$(MAKE) -C $(KDIR) M=$(shell pwd) modules_install
diff --git a/drivers/media/i2c/mt9v111.c b/drivers/media/i2c/mt9v111.c
index 723fe138e7bc..8bf06a763a25 100644
--- a/drivers/media/i2c/mt9v111.c
+++ b/drivers/media/i2c/mt9v111.c
@@ -532,8 +532,8 @@ static int mt9v111_calc_frame_rate(struct mt9v111_dev *mt9v111,
 static int mt9v111_hw_config(struct mt9v111_dev *mt9v111)
 {
 	struct i2c_client *c = mt9v111->client;
-	unsigned int ret;
 	u16 outfmtctrl2;
+	int ret;
 
 	/* Force device reset. */
 	ret = __mt9v111_hw_reset(mt9v111);
diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
index 56444edaf136..6daa7aa99442 100644
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
@@ -281,6 +276,7 @@ void media_devnode_unregister(struct media_devnode *devnode)
 	/* Delete the cdev on this minor as well */
 	cdev_device_del(&devnode->cdev, &devnode->dev);
 	devnode->media_dev = NULL;
+	clear_bit(devnode->minor, media_devnode_nums);
 	mutex_unlock(&media_devnode_lock);
 
 	put_device(&devnode->dev);
diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index 96dd0f6ccd0d..b3761839a521 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -691,7 +691,7 @@ static int media_pipeline_explore_next_link(struct media_pipeline *pipe,
 		 * (already discovered through iterating over links) and pads
 		 * not internally connected.
 		 */
-		if (origin == local || !local->num_links ||
+		if (origin == local || local->num_links ||
 		    !media_entity_has_pad_interdep(origin->entity, origin->index,
 						   local->index))
 			continue;
diff --git a/drivers/media/pci/cx18/cx18-queue.c b/drivers/media/pci/cx18/cx18-queue.c
index 013694bfcb1c..7cbb2d586932 100644
--- a/drivers/media/pci/cx18/cx18-queue.c
+++ b/drivers/media/pci/cx18/cx18-queue.c
@@ -379,15 +379,22 @@ int cx18_stream_alloc(struct cx18_stream *s)
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
-		buf->dma_handle = dma_map_single(&s->cx->pci_dev->dev,
-						 buf->buf, s->buf_size,
-						 s->dma);
 		cx18_buf_sync_for_cpu(s, buf);
 		list_add_tail(&buf->list, &s->buf_pool);
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
diff --git a/drivers/media/pci/ivtv/ivtv-yuv.c b/drivers/media/pci/ivtv/ivtv-yuv.c
index 2d9274537725..71f040106647 100644
--- a/drivers/media/pci/ivtv/ivtv-yuv.c
+++ b/drivers/media/pci/ivtv/ivtv-yuv.c
@@ -125,7 +125,7 @@ static int ivtv_yuv_prep_user_dma(struct ivtv *itv, struct ivtv_user_dma *dma,
 	ivtv_udma_fill_sg_array(dma, y_buffer_offset, uv_buffer_offset, y_size);
 
 	/* If we've offset the y plane, ensure top area is blanked */
-	if (f->offset_y && yi->blanking_dmaptr) {
+	if (f->offset_y && yi->blanking_ptr) {
 		dma->SGarray[dma->SG_length].size = cpu_to_le32(720*16);
 		dma->SGarray[dma->SG_length].src = cpu_to_le32(yi->blanking_dmaptr);
 		dma->SGarray[dma->SG_length].dst = cpu_to_le32(IVTV_DECODER_OFFSET + yuv_offset[frame]);
@@ -929,6 +929,12 @@ static void ivtv_yuv_init(struct ivtv *itv)
 		yi->blanking_dmaptr = dma_map_single(&itv->pdev->dev,
 						     yi->blanking_ptr,
 						     720 * 16, DMA_TO_DEVICE);
+		if (dma_mapping_error(&itv->pdev->dev, yi->blanking_dmaptr)) {
+			kfree(yi->blanking_ptr);
+			yi->blanking_ptr = NULL;
+			yi->blanking_dmaptr = 0;
+			IVTV_DEBUG_WARN("Failed to dma_map yuv blanking buffer\n");
+		}
 	} else {
 		yi->blanking_dmaptr = 0;
 		IVTV_DEBUG_WARN("Failed to allocate yuv blanking buffer\n");
diff --git a/drivers/media/pci/mgb4/mgb4_trigger.c b/drivers/media/pci/mgb4/mgb4_trigger.c
index 923650d53d4c..d7dddc5c8728 100644
--- a/drivers/media/pci/mgb4/mgb4_trigger.c
+++ b/drivers/media/pci/mgb4/mgb4_trigger.c
@@ -91,7 +91,7 @@ static irqreturn_t trigger_handler(int irq, void *p)
 	struct {
 		u32 data;
 		s64 ts __aligned(8);
-	} scan;
+	} scan = { };
 
 	scan.data = mgb4_read_reg(&st->mgbdev->video, 0xA0);
 	mgb4_write_reg(&st->mgbdev->video, 0xA0, scan.data);
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 66a18830e66d..4e2636b05366 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -30,7 +30,7 @@ static void venus_reset_cpu(struct venus_core *core)
 	u32 fw_size = core->fw.mapped_mem_size;
 	void __iomem *wrapper_base;
 
-	if (IS_IRIS2_1(core))
+	if (IS_IRIS2(core) || IS_IRIS2_1(core))
 		wrapper_base = core->wrapper_tz_base;
 	else
 		wrapper_base = core->wrapper_base;
@@ -42,7 +42,7 @@ static void venus_reset_cpu(struct venus_core *core)
 	writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
 	writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
 
-	if (IS_IRIS2_1(core)) {
+	if (IS_IRIS2(core) || IS_IRIS2_1(core)) {
 		/* Bring XTSS out of reset */
 		writel(0, wrapper_base + WRAPPER_TZ_XTSS_SW_RESET);
 	} else {
@@ -68,7 +68,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
 	if (resume) {
 		venus_reset_cpu(core);
 	} else {
-		if (IS_IRIS2_1(core))
+		if (IS_IRIS2(core) || IS_IRIS2_1(core))
 			writel(WRAPPER_XTSS_SW_RESET_BIT,
 			       core->wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
 		else
@@ -181,7 +181,7 @@ static int venus_shutdown_no_tz(struct venus_core *core)
 	void __iomem *wrapper_base = core->wrapper_base;
 	void __iomem *wrapper_tz_base = core->wrapper_tz_base;
 
-	if (IS_IRIS2_1(core)) {
+	if (IS_IRIS2(core) || IS_IRIS2_1(core)) {
 		/* Assert the reset to XTSS */
 		reg = readl(wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
 		reg |= WRAPPER_XTSS_SW_RESET_BIT;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
index 47bc3014b5d8..f7c682fca645 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
@@ -14,8 +14,7 @@
 #include "s5p_mfc_opr.h"
 #include "s5p_mfc_cmd_v6.h"
 
-static int s5p_mfc_cmd_host2risc_v6(struct s5p_mfc_dev *dev, int cmd,
-				    const struct s5p_mfc_cmd_args *args)
+static int s5p_mfc_cmd_host2risc_v6(struct s5p_mfc_dev *dev, int cmd)
 {
 	mfc_debug(2, "Issue the command: %d\n", cmd);
 
@@ -31,7 +30,6 @@ static int s5p_mfc_cmd_host2risc_v6(struct s5p_mfc_dev *dev, int cmd,
 
 static int s5p_mfc_sys_init_cmd_v6(struct s5p_mfc_dev *dev)
 {
-	struct s5p_mfc_cmd_args h2r_args;
 	const struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size->priv;
 	int ret;
 
@@ -41,33 +39,23 @@ static int s5p_mfc_sys_init_cmd_v6(struct s5p_mfc_dev *dev)
 
 	mfc_write(dev, dev->ctx_buf.dma, S5P_FIMV_CONTEXT_MEM_ADDR_V6);
 	mfc_write(dev, buf_size->dev_ctx, S5P_FIMV_CONTEXT_MEM_SIZE_V6);
-	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_SYS_INIT_V6,
-					&h2r_args);
+	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_SYS_INIT_V6);
 }
 
 static int s5p_mfc_sleep_cmd_v6(struct s5p_mfc_dev *dev)
 {
-	struct s5p_mfc_cmd_args h2r_args;
-
-	memset(&h2r_args, 0, sizeof(struct s5p_mfc_cmd_args));
-	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_SLEEP_V6,
-			&h2r_args);
+	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_SLEEP_V6);
 }
 
 static int s5p_mfc_wakeup_cmd_v6(struct s5p_mfc_dev *dev)
 {
-	struct s5p_mfc_cmd_args h2r_args;
-
-	memset(&h2r_args, 0, sizeof(struct s5p_mfc_cmd_args));
-	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_WAKEUP_V6,
-					&h2r_args);
+	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_WAKEUP_V6);
 }
 
 /* Open a new instance and get its number */
 static int s5p_mfc_open_inst_cmd_v6(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_cmd_args h2r_args;
 	int codec_type;
 
 	mfc_debug(2, "Requested codec mode: %d\n", ctx->codec_mode);
@@ -129,23 +117,20 @@ static int s5p_mfc_open_inst_cmd_v6(struct s5p_mfc_ctx *ctx)
 	mfc_write(dev, ctx->ctx.size, S5P_FIMV_CONTEXT_MEM_SIZE_V6);
 	mfc_write(dev, 0, S5P_FIMV_D_CRC_CTRL_V6); /* no crc */
 
-	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_OPEN_INSTANCE_V6,
-					&h2r_args);
+	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_OPEN_INSTANCE_V6);
 }
 
 /* Close instance */
 static int s5p_mfc_close_inst_cmd_v6(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_cmd_args h2r_args;
 	int ret = 0;
 
 	dev->curr_ctx = ctx->num;
 	if (ctx->state != MFCINST_FREE) {
 		mfc_write(dev, ctx->inst_no, S5P_FIMV_INSTANCE_ID_V6);
 		ret = s5p_mfc_cmd_host2risc_v6(dev,
-					S5P_FIMV_H2R_CMD_CLOSE_INSTANCE_V6,
-					&h2r_args);
+					S5P_FIMV_H2R_CMD_CLOSE_INSTANCE_V6);
 	} else {
 		ret = -EINVAL;
 	}
@@ -153,9 +138,15 @@ static int s5p_mfc_close_inst_cmd_v6(struct s5p_mfc_ctx *ctx)
 	return ret;
 }
 
+static int s5p_mfc_cmd_host2risc_v6_args(struct s5p_mfc_dev *dev, int cmd,
+				    const struct s5p_mfc_cmd_args *ignored)
+{
+	return s5p_mfc_cmd_host2risc_v6(dev, cmd);
+}
+
 /* Initialize cmd function pointers for MFC v6 */
 static const struct s5p_mfc_hw_cmds s5p_mfc_cmds_v6 = {
-	.cmd_host2risc = s5p_mfc_cmd_host2risc_v6,
+	.cmd_host2risc = s5p_mfc_cmd_host2risc_v6_args,
 	.sys_init_cmd = s5p_mfc_sys_init_cmd_v6,
 	.sleep_cmd = s5p_mfc_sleep_cmd_v6,
 	.wakeup_cmd = s5p_mfc_wakeup_cmd_v6,
diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 3853245fcf6e..f8cb93ce9459 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -52,6 +52,8 @@
 #define DRAIN_TIMEOUT_MS		50
 #define DRAIN_BUFFER_SIZE		SZ_32K
 
+#define CSI2RX_BRIDGE_SOURCE_PAD	1
+
 struct ti_csi2rx_fmt {
 	u32				fourcc;	/* Four character code. */
 	u32				code;	/* Mbus code. */
@@ -426,8 +428,9 @@ static int csi_async_notifier_complete(struct v4l2_async_notifier *notifier)
 	if (ret)
 		return ret;
 
-	ret = v4l2_create_fwnode_links_to_pad(csi->source, &csi->pad,
-					      MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
+	ret = media_create_pad_link(&csi->source->entity, CSI2RX_BRIDGE_SOURCE_PAD,
+				    &vdev->entity, csi->pad.index,
+				    MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
 
 	if (ret) {
 		video_unregister_device(vdev);
@@ -1121,7 +1124,7 @@ static int ti_csi2rx_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_vb2q;
 
-	ret = of_platform_populate(csi->dev->of_node, NULL, NULL, csi->dev);
+	ret = devm_of_platform_populate(csi->dev);
 	if (ret) {
 		dev_err(csi->dev, "Failed to create children: %d\n", ret);
 		goto err_subdev;
diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index f042f3f14afa..314f64420f62 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -736,11 +736,11 @@ int lirc_register(struct rc_dev *dev)
 
 	cdev_init(&dev->lirc_cdev, &lirc_fops);
 
+	get_device(&dev->dev);
+
 	err = cdev_device_add(&dev->lirc_cdev, &dev->lirc_dev);
 	if (err)
-		goto out_ida;
-
-	get_device(&dev->dev);
+		goto out_put_device;
 
 	switch (dev->driver_type) {
 	case RC_DRIVER_SCANCODE:
@@ -764,7 +764,8 @@ int lirc_register(struct rc_dev *dev)
 
 	return 0;
 
-out_ida:
+out_put_device:
+	put_device(&dev->lirc_dev);
 	ida_free(&lirc_ida, minor);
 	return err;
 }
diff --git a/drivers/media/test-drivers/vivid/vivid-cec.c b/drivers/media/test-drivers/vivid/vivid-cec.c
index 356a988dd6a1..2d15fdd5d999 100644
--- a/drivers/media/test-drivers/vivid/vivid-cec.c
+++ b/drivers/media/test-drivers/vivid/vivid-cec.c
@@ -327,7 +327,7 @@ static int vivid_received(struct cec_adapter *adap, struct cec_msg *msg)
 		char osd[14];
 
 		if (!cec_is_sink(adap))
-			return -ENOMSG;
+			break;
 		cec_ops_set_osd_string(msg, &disp_ctl, osd);
 		switch (disp_ctl) {
 		case CEC_OP_DISP_CTL_DEFAULT:
@@ -348,7 +348,7 @@ static int vivid_received(struct cec_adapter *adap, struct cec_msg *msg)
 			cec_transmit_msg(adap, &reply, false);
 			break;
 		}
-		break;
+		return 0;
 	}
 	case CEC_MSG_VENDOR_COMMAND_WITH_ID: {
 		u32 vendor_id;
@@ -379,7 +379,7 @@ static int vivid_received(struct cec_adapter *adap, struct cec_msg *msg)
 		if (size == 1) {
 			// Ignore even op values
 			if (!(vendor_cmd[0] & 1))
-				break;
+				return 0;
 			reply.len = msg->len;
 			memcpy(reply.msg + 1, msg->msg + 1, msg->len - 1);
 			reply.msg[msg->len - 1]++;
@@ -388,12 +388,10 @@ static int vivid_received(struct cec_adapter *adap, struct cec_msg *msg)
 					      CEC_OP_ABORT_INVALID_OP);
 		}
 		cec_transmit_msg(adap, &reply, false);
-		break;
+		return 0;
 	}
-	default:
-		return -ENOMSG;
 	}
-	return 0;
+	return -ENOMSG;
 }
 
 static const struct cec_adap_ops vivid_cec_adap_ops = {
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
index 992855bfda3e..6daf33e07ea0 100644
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
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 4b19b8a16b09..2e37700ae36e 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -945,7 +945,11 @@ static void mmc_sdio_remove(struct mmc_host *host)
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
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 47443fb5eb33..f42d5f9c48c1 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -563,7 +563,7 @@ mmc_spi_setup_data_message(struct mmc_spi_host *host, bool multiple, bool write)
 	 * the next token (next data block, or STOP_TRAN).  We can try to
 	 * minimize I/O ops by using a single read to collect end-of-busy.
 	 */
-	if (multiple || write) {
+	if (write) {
 		t = &host->early_status;
 		memset(t, 0, sizeof(*t));
 		t->len = write ? sizeof(scratch->status) : 1;
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index fe5912d31bee..b0a70badf3eb 100644
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
 
 	if (of_property_read_bool(np, "nand-skip-bbtscan"))
diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 026f7270a54d..fb5d12a87872 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -479,10 +479,12 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
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
 
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 10285995c9ed..cc4798026182 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -98,19 +98,21 @@ struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
 
 	index = ice_adapter_xa_index(pdev);
 	scoped_guard(mutex, &ice_adapters_mutex) {
-		err = xa_insert(&ice_adapters, index, NULL, GFP_KERNEL);
-		if (err == -EBUSY) {
-			adapter = xa_load(&ice_adapters, index);
+		adapter = xa_load(&ice_adapters, index);
+		if (adapter) {
 			refcount_inc(&adapter->refcount);
 			WARN_ON_ONCE(adapter->index != ice_adapter_index(pdev));
 			return adapter;
 		}
+		err = xa_reserve(&ice_adapters, index, GFP_KERNEL);
 		if (err)
 			return ERR_PTR(err);
 
 		adapter = ice_adapter_new(pdev);
-		if (!adapter)
+		if (!adapter) {
+			xa_release(&ice_adapters, index);
 			return ERR_PTR(-ENOMEM);
+		}
 		xa_store(&ice_adapters, index, adapter, GFP_KERNEL);
 	}
 	return adapter;
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 281b34af0bb4..3160a1a2d2ab 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -1180,9 +1180,9 @@ static void mlx4_en_do_uc_filter(struct mlx4_en_priv *priv,
 				mlx4_unregister_mac(mdev->dev, priv->port, mac);
 
 				hlist_del_rcu(&entry->hlist);
-				kfree_rcu(entry, rcu);
 				en_dbg(DRV, priv, "Removed MAC %pM on port:%d\n",
 				       entry->mac, priv->port);
+				kfree_rcu(entry, rcu);
 				++removed;
 			}
 		}
diff --git a/drivers/net/ethernet/mscc/ocelot_stats.c b/drivers/net/ethernet/mscc/ocelot_stats.c
index c018783757fb..858d4cbc83d3 100644
--- a/drivers/net/ethernet/mscc/ocelot_stats.c
+++ b/drivers/net/ethernet/mscc/ocelot_stats.c
@@ -984,6 +984,6 @@ int ocelot_stats_init(struct ocelot *ocelot)
 
 void ocelot_stats_deinit(struct ocelot *ocelot)
 {
-	cancel_delayed_work(&ocelot->stats_work);
+	disable_delayed_work_sync(&ocelot->stats_work);
 	destroy_workqueue(ocelot->stats_queue);
 }
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index bb46ef986b2a..afac4a1e9a1d 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1936,14 +1936,10 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	mutex_unlock(&ab->core_lock);
 
 	ath11k_dp_free(ab);
-	ath11k_hal_srng_deinit(ab);
+	ath11k_hal_srng_clear(ab);
 
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
 
-	ret = ath11k_hal_srng_init(ab);
-	if (ret)
-		return ret;
-
 	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
 	ret = ath11k_core_qmi_firmware_ready(ab);
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 65e52ab742b4..e47774b6d992 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1383,6 +1383,22 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 }
 EXPORT_SYMBOL(ath11k_hal_srng_deinit);
 
+void ath11k_hal_srng_clear(struct ath11k_base *ab)
+{
+	/* No need to memset rdp and wrp memory since each individual
+	 * segment would get cleared in ath11k_hal_srng_src_hw_init()
+	 * and ath11k_hal_srng_dst_hw_init().
+	 */
+	memset(ab->hal.srng_list, 0,
+	       sizeof(ab->hal.srng_list));
+	memset(ab->hal.shadow_reg_addr, 0,
+	       sizeof(ab->hal.shadow_reg_addr));
+	ab->hal.avail_blk_resource = 0;
+	ab->hal.current_blk_index = 0;
+	ab->hal.num_shadow_reg_configured = 0;
+}
+EXPORT_SYMBOL(ath11k_hal_srng_clear);
+
 void ath11k_hal_dump_srng_stats(struct ath11k_base *ab)
 {
 	struct hal_srng *srng;
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index dc8bbe073017..0f725668b819 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -965,6 +965,7 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 			  struct hal_srng_params *params);
 int ath11k_hal_srng_init(struct ath11k_base *ath11k);
 void ath11k_hal_srng_deinit(struct ath11k_base *ath11k);
+void ath11k_hal_srng_clear(struct ath11k_base *ab);
 void ath11k_hal_dump_srng_stats(struct ath11k_base *ab);
 void ath11k_hal_srng_get_shadow_config(struct ath11k_base *ab,
 				       u32 **cfg, u32 *len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index e3459295ad88..5be0edb2fe9a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -21,6 +21,9 @@ static const struct usb_device_id mt7921u_device_table[] = {
 	/* Netgear, Inc. [A8000,AXE3000] */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9060, 0xff, 0xff, 0xff),
 		.driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
+	/* Netgear, Inc. A7500 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9065, 0xff, 0xff, 0xff),
+		.driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
 	/* TP-Link TXE50UH */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0107, 0xff, 0xff, 0xff),
 		.driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index 682db1bab21c..a63ff630eaba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -12,6 +12,9 @@
 static const struct usb_device_id mt7925u_device_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7925, 0xff, 0xff, 0xff),
 		.driver_info = (kernel_ulong_t)MT7925_FIRMWARE_WM },
+	/* Netgear, Inc. A9000 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9072, 0xff, 0xff, 0xff),
+		.driver_info = (kernel_ulong_t)MT7925_FIRMWARE_WM },
 	{ },
 };
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fdc9f1df0578..ff004350dc2c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3140,10 +3140,12 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
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
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 9a72f75e5c2d..63b5b435bd3a 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -4191,6 +4191,7 @@ static int of_unittest_pci_node_verify(struct pci_dev *pdev, bool add)
 		unittest(!np, "Child device tree node is not removed\n");
 		child_dev = device_find_any_child(&pdev->dev);
 		unittest(!child_dev, "Child device is not removed\n");
+		put_device(child_dev);
 	}
 
 failed:
diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index eb772c18d44e..c014220d2b24 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -277,6 +277,25 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 	if (!ret)
 		offset = args.args[0];
 
+	/*
+	 * The PCIe Controller's registers have different "reset-values"
+	 * depending on the "strap" settings programmed into the PCIEn_CTRL
+	 * register within the CTRL_MMR memory-mapped register space.
+	 * The registers latch onto a "reset-value" based on the "strap"
+	 * settings sampled after the PCIe Controller is powered on.
+	 * To ensure that the "reset-values" are sampled accurately, power
+	 * off the PCIe Controller before programming the "strap" settings
+	 * and power it on after that. The runtime PM APIs namely
+	 * pm_runtime_put_sync() and pm_runtime_get_sync() will decrement and
+	 * increment the usage counter respectively, causing GENPD to power off
+	 * and power on the PCIe Controller.
+	 */
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to power off PCIe Controller\n");
+		return ret;
+	}
+
 	ret = j721e_pcie_set_mode(pcie, syscon, offset);
 	if (ret < 0) {
 		dev_err(dev, "Failed to set pci mode\n");
@@ -295,6 +314,12 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 		return ret;
 	}
 
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to power on PCIe Controller\n");
+		return ret;
+	}
+
 	/* Enable ACSPCIE refclk output if the optional property exists */
 	syscon = syscon_regmap_lookup_by_phandle_optional(node,
 						"ti,syscon-acspcie-proxy-ctrl");
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 44b34559de1a..4f75d13fe1de 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1202,8 +1202,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = request_irq(irq, ks_pcie_err_irq_handler, IRQF_SHARED,
-			  "ks-pcie-error-irq", ks_pcie);
+	ret = devm_request_irq(dev, irq, ks_pcie_err_irq_handler, IRQF_SHARED,
+			       "ks-pcie-error-irq", ks_pcie);
 	if (ret < 0) {
 		dev_err(dev, "failed to request error IRQ %d\n",
 			irq);
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 14f69efa243c..397c2f9477a1 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -723,7 +723,7 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(23, 22), BIT(22));
 	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(18, 16), GENMASK(17, 16));
 	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(7, 6), BIT(6));
-	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(2, 0), GENMASK(11, 0));
+	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x148, GENMASK(2, 0), GENMASK(1, 0));
 	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x1d4, GENMASK(16, 15), GENMASK(16, 15));
 	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x514, BIT(26), BIT(26));
 	rcar_gen4_pcie_phy_reg_update_bits(rcar, 0x0f8, BIT(16), 0);
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 815599ef72db..c2d626b090e3 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1205,6 +1205,7 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	/*
 	 * Controller-5 doesn't need to have its state set by BPMP-FW in
@@ -1227,7 +1228,13 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	msg.rx.data = &resp;
 	msg.rx.size = sizeof(resp);
 
-	return tegra_bpmp_transfer(pcie->bpmp, &msg);
+	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
 }
 
 static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
@@ -1236,6 +1243,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	memset(&req, 0, sizeof(req));
 	memset(&resp, 0, sizeof(resp));
@@ -1255,7 +1263,13 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	msg.rx.data = &resp;
 	msg.rx.size = sizeof(resp);
 
-	return tegra_bpmp_transfer(pcie->bpmp, &msg);
+	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
 }
 
 static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
@@ -1940,6 +1954,15 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void tegra_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+};
+
 static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
 	/* Tegra194 supports only INTA */
@@ -1954,10 +1977,10 @@ static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
 
 static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
-	if (unlikely(irq > 31))
+	if (unlikely(irq > 32))
 		return -EINVAL;
 
-	appl_writel(pcie, BIT(irq), APPL_MSI_CTRL_1);
+	appl_writel(pcie, BIT(irq - 1), APPL_MSI_CTRL_1);
 
 	return 0;
 }
@@ -2016,6 +2039,7 @@ tegra_pcie_ep_get_features(struct dw_pcie_ep *ep)
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
+	.init = tegra_pcie_ep_init,
 	.raise_irq = tegra_pcie_ep_raise_irq,
 	.get_features = tegra_pcie_ep_get_features,
 };
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 4f70b7f2ded9..927ef421c4fc 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/export.h>
@@ -269,7 +270,7 @@ struct tegra_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
 	struct mutex map_lock;
-	spinlock_t mask_lock;
+	raw_spinlock_t mask_lock;
 	void *virt;
 	dma_addr_t phys;
 	int irq;
@@ -1604,14 +1605,13 @@ static void tegra_msi_irq_mask(struct irq_data *d)
 	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
 	struct tegra_pcie *pcie = msi_to_pcie(msi);
 	unsigned int index = d->hwirq / 32;
-	unsigned long flags;
 	u32 value;
 
-	spin_lock_irqsave(&msi->mask_lock, flags);
-	value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
-	value &= ~BIT(d->hwirq % 32);
-	afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
-	spin_unlock_irqrestore(&msi->mask_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &msi->mask_lock) {
+		value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
+		value &= ~BIT(d->hwirq % 32);
+		afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
+	}
 }
 
 static void tegra_msi_irq_unmask(struct irq_data *d)
@@ -1619,14 +1619,13 @@ static void tegra_msi_irq_unmask(struct irq_data *d)
 	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
 	struct tegra_pcie *pcie = msi_to_pcie(msi);
 	unsigned int index = d->hwirq / 32;
-	unsigned long flags;
 	u32 value;
 
-	spin_lock_irqsave(&msi->mask_lock, flags);
-	value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
-	value |= BIT(d->hwirq % 32);
-	afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
-	spin_unlock_irqrestore(&msi->mask_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &msi->mask_lock) {
+		value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
+		value |= BIT(d->hwirq % 32);
+		afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
+	}
 }
 
 static void tegra_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
@@ -1736,7 +1735,7 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 	int err;
 
 	mutex_init(&msi->map_lock);
-	spin_lock_init(&msi->mask_lock);
+	raw_spin_lock_init(&msi->mask_lock);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = tegra_allocate_domains(msi);
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 3dd653f3d784..a90beedd8e24 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
@@ -37,7 +38,7 @@ struct rcar_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
 	struct mutex map_lock;
-	spinlock_t mask_lock;
+	raw_spinlock_t mask_lock;
 	int irq1;
 	int irq2;
 };
@@ -51,20 +52,13 @@ struct rcar_pcie_host {
 	int			(*phy_init_fn)(struct rcar_pcie_host *host);
 };
 
-static DEFINE_SPINLOCK(pmsr_lock);
-
 static int rcar_pcie_wakeup(struct device *pcie_dev, void __iomem *pcie_base)
 {
-	unsigned long flags;
 	u32 pmsr, val;
 	int ret = 0;
 
-	spin_lock_irqsave(&pmsr_lock, flags);
-
-	if (!pcie_base || pm_runtime_suspended(pcie_dev)) {
-		ret = -EINVAL;
-		goto unlock_exit;
-	}
+	if (!pcie_base || pm_runtime_suspended(pcie_dev))
+		return -EINVAL;
 
 	pmsr = readl(pcie_base + PMSR);
 
@@ -86,8 +80,6 @@ static int rcar_pcie_wakeup(struct device *pcie_dev, void __iomem *pcie_base)
 		writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
 	}
 
-unlock_exit:
-	spin_unlock_irqrestore(&pmsr_lock, flags);
 	return ret;
 }
 
@@ -634,28 +626,26 @@ static void rcar_msi_irq_mask(struct irq_data *d)
 {
 	struct rcar_msi *msi = irq_data_get_irq_chip_data(d);
 	struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
-	unsigned long flags;
 	u32 value;
 
-	spin_lock_irqsave(&msi->mask_lock, flags);
-	value = rcar_pci_read_reg(pcie, PCIEMSIIER);
-	value &= ~BIT(d->hwirq);
-	rcar_pci_write_reg(pcie, value, PCIEMSIIER);
-	spin_unlock_irqrestore(&msi->mask_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &msi->mask_lock) {
+		value = rcar_pci_read_reg(pcie, PCIEMSIIER);
+		value &= ~BIT(d->hwirq);
+		rcar_pci_write_reg(pcie, value, PCIEMSIIER);
+	}
 }
 
 static void rcar_msi_irq_unmask(struct irq_data *d)
 {
 	struct rcar_msi *msi = irq_data_get_irq_chip_data(d);
 	struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
-	unsigned long flags;
 	u32 value;
 
-	spin_lock_irqsave(&msi->mask_lock, flags);
-	value = rcar_pci_read_reg(pcie, PCIEMSIIER);
-	value |= BIT(d->hwirq);
-	rcar_pci_write_reg(pcie, value, PCIEMSIIER);
-	spin_unlock_irqrestore(&msi->mask_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &msi->mask_lock) {
+		value = rcar_pci_read_reg(pcie, PCIEMSIIER);
+		value |= BIT(d->hwirq);
+		rcar_pci_write_reg(pcie, value, PCIEMSIIER);
+	}
 }
 
 static void rcar_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
@@ -765,7 +755,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 	int err;
 
 	mutex_init(&msi->map_lock);
-	spin_lock_init(&msi->mask_lock);
+	raw_spin_lock_init(&msi->mask_lock);
 
 	err = of_address_to_resource(dev->of_node, 0, &res);
 	if (err)
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index a8ae14474dd0..2e7356c28b5e 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -721,9 +721,10 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
 			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
 
-	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
-			  (NWL_ECAM_MAX_SIZE << E_ECAM_SIZE_SHIFT),
-			  E_ECAM_CONTROL);
+	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CONTROL);
+	ecam_val &= ~E_ECAM_SIZE_LOC;
+	ecam_val |= NWL_ECAM_MAX_SIZE << E_ECAM_SIZE_SHIFT;
+	nwl_bridge_writel(pcie, ecam_val, E_ECAM_CONTROL);
 
 	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
 			  E_ECAM_BASE_LO);
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 21aa3709e257..eeb7fbc2d67a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -282,17 +282,20 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 	if (!epf_test->dma_supported)
 		return;
 
-	dma_release_channel(epf_test->dma_chan_tx);
-	if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
+	if (epf_test->dma_chan_tx) {
+		dma_release_channel(epf_test->dma_chan_tx);
+		if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
+			epf_test->dma_chan_tx = NULL;
+			epf_test->dma_chan_rx = NULL;
+			return;
+		}
 		epf_test->dma_chan_tx = NULL;
-		epf_test->dma_chan_rx = NULL;
-		return;
 	}
 
-	dma_release_channel(epf_test->dma_chan_rx);
-	epf_test->dma_chan_rx = NULL;
-
-	return;
+	if (epf_test->dma_chan_rx) {
+		dma_release_channel(epf_test->dma_chan_rx);
+		epf_test->dma_chan_rx = NULL;
+	}
 }
 
 static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index aaa33e8dc4c9..44a33df3c69c 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -581,15 +581,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
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
@@ -709,8 +712,10 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 35270172c833..0c3aa91d1aee 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1600,6 +1600,7 @@ void pci_uevent_ers(struct pci_dev *pdev, enum pci_ers_result err_type)
 	switch (err_type) {
 	case PCI_ERS_RESULT_NONE:
 	case PCI_ERS_RESULT_CAN_RECOVER:
+	case PCI_ERS_RESULT_NEED_RESET:
 		envp[idx++] = "ERROR_EVENT=BEGIN_RECOVERY";
 		envp[idx++] = "DEVICE_ONLINE=0";
 		break;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5af4a804a4f8..96f9cf9f8d64 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -200,8 +200,14 @@ static ssize_t max_link_width_show(struct device *dev,
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
 
@@ -213,7 +219,10 @@ static ssize_t current_link_speed_show(struct device *dev,
 	int err;
 	enum pci_bus_speed speed;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -230,7 +239,10 @@ static ssize_t current_link_width_show(struct device *dev,
 	u16 linkstat;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -246,7 +258,10 @@ static ssize_t secondary_bus_number_show(struct device *dev,
 	u8 sec_bus;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -262,7 +277,10 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
 	u8 sub_bus;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pci_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 13b8586924ea..e5cbea3a4968 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -38,7 +38,7 @@
 #define AER_ERROR_SOURCES_MAX		128
 
 #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
-#define AER_MAX_TYPEOF_UNCOR_ERRS	27	/* as per PCI_ERR_UNCOR_STATUS*/
+#define AER_MAX_TYPEOF_UNCOR_ERRS	32	/* as per PCI_ERR_UNCOR_STATUS*/
 
 struct aer_err_source {
 	u32 status;			/* PCI_ERR_ROOT_STATUS */
@@ -510,11 +510,11 @@ static const char *aer_uncorrectable_error_string[] = {
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
index 31090770fffc..628d192de90b 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -108,6 +108,12 @@ static int report_normal_detected(struct pci_dev *dev, void *data)
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
 	struct pci_driver *pdrv;
@@ -269,7 +275,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 failed:
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
 
-	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
+	pci_walk_bridge(bridge, report_perm_failure_detected, NULL);
 
 	/* TODO: Should kernel panic here? */
 	pci_info(bridge, "device recovery failed\n");
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 978b239ec10b..e6b0c8ec9c1f 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -65,7 +65,7 @@
 /* PMU registers occupy the 3rd 4KB page of each node's region */
 #define CMN_PMU_OFFSET			0x2000
 /* ...except when they don't :( */
-#define CMN_S3_DTM_OFFSET		0xa000
+#define CMN_S3_R1_DTM_OFFSET		0xa000
 #define CMN_S3_PMU_OFFSET		0xd900
 
 /* For most nodes, this is all there is */
@@ -233,6 +233,9 @@ enum cmn_revision {
 	REV_CMN700_R1P0,
 	REV_CMN700_R2P0,
 	REV_CMN700_R3P0,
+	REV_CMNS3_R0P0 = 0,
+	REV_CMNS3_R0P1,
+	REV_CMNS3_R1P0,
 	REV_CI700_R0P0 = 0,
 	REV_CI700_R1P0,
 	REV_CI700_R2P0,
@@ -425,8 +428,8 @@ static enum cmn_model arm_cmn_model(const struct arm_cmn *cmn)
 static int arm_cmn_pmu_offset(const struct arm_cmn *cmn, const struct arm_cmn_node *dn)
 {
 	if (cmn->part == PART_CMN_S3) {
-		if (dn->type == CMN_TYPE_XP)
-			return CMN_S3_DTM_OFFSET;
+		if (cmn->rev >= REV_CMNS3_R1P0 && dn->type == CMN_TYPE_XP)
+			return CMN_S3_R1_DTM_OFFSET;
 		return CMN_S3_PMU_OFFSET;
 	}
 	return CMN_PMU_OFFSET;
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 7ffd2e193e42..02b53ae9d9aa 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -393,10 +393,6 @@ extern const struct samsung_pinctrl_of_match_data exynosautov920_of_data;
 extern const struct samsung_pinctrl_of_match_data fsd_of_data;
 extern const struct samsung_pinctrl_of_match_data gs101_of_data;
 extern const struct samsung_pinctrl_of_match_data s3c64xx_of_data;
-extern const struct samsung_pinctrl_of_match_data s3c2412_of_data;
-extern const struct samsung_pinctrl_of_match_data s3c2416_of_data;
-extern const struct samsung_pinctrl_of_match_data s3c2440_of_data;
-extern const struct samsung_pinctrl_of_match_data s3c2450_of_data;
 extern const struct samsung_pinctrl_of_match_data s5pv210_of_data;
 
 #endif /* __PINCTRL_SAMSUNG_H */
diff --git a/drivers/power/supply/max77976_charger.c b/drivers/power/supply/max77976_charger.c
index d7e520da7688..e2424efb266d 100644
--- a/drivers/power/supply/max77976_charger.c
+++ b/drivers/power/supply/max77976_charger.c
@@ -292,10 +292,10 @@ static int max77976_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		err = max77976_get_online(chg, &val->intval);
 		break;
-	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
 		val->intval = MAX77976_CHG_CC_MAX;
 		break;
-	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		err = max77976_get_integer(chg, CHG_CC,
 					   MAX77976_CHG_CC_MIN,
 					   MAX77976_CHG_CC_MAX,
@@ -330,7 +330,7 @@ static int max77976_set_property(struct power_supply *psy,
 	int err = 0;
 
 	switch (psp) {
-	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		err = max77976_set_integer(chg, CHG_CC,
 					   MAX77976_CHG_CC_MIN,
 					   MAX77976_CHG_CC_MAX,
@@ -355,7 +355,7 @@ static int max77976_property_is_writeable(struct power_supply *psy,
 					  enum power_supply_property psp)
 {
 	switch (psp) {
-	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		return true;
 	default:
@@ -368,8 +368,8 @@ static enum power_supply_property max77976_psy_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
-	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 831aed228caf..858d36991374 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -234,7 +234,7 @@ static int berlin_pwm_suspend(struct device *dev)
 	for (i = 0; i < chip->npwm; i++) {
 		struct berlin_pwm_channel *channel = &bpc->channel[i];
 
-		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_ENABLE);
+		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_EN);
 		channel->ctrl = berlin_pwm_readl(bpc, i, BERLIN_PWM_CONTROL);
 		channel->duty = berlin_pwm_readl(bpc, i, BERLIN_PWM_DUTY);
 		channel->tcnt = berlin_pwm_readl(bpc, i, BERLIN_PWM_TCNT);
@@ -262,7 +262,7 @@ static int berlin_pwm_resume(struct device *dev)
 		berlin_pwm_writel(bpc, i, channel->ctrl, BERLIN_PWM_CONTROL);
 		berlin_pwm_writel(bpc, i, channel->duty, BERLIN_PWM_DUTY);
 		berlin_pwm_writel(bpc, i, channel->tcnt, BERLIN_PWM_TCNT);
-		berlin_pwm_writel(bpc, i, channel->enable, BERLIN_PWM_ENABLE);
+		berlin_pwm_writel(bpc, i, channel->enable, BERLIN_PWM_EN);
 	}
 
 	return 0;
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index aaf76406cd7d..39db12f267cc 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -443,6 +443,29 @@ static int __rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
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
@@ -594,6 +617,10 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
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
diff --git a/drivers/rtc/rtc-optee.c b/drivers/rtc/rtc-optee.c
index 9f8b5d4a8f6b..6b77c122fdc1 100644
--- a/drivers/rtc/rtc-optee.c
+++ b/drivers/rtc/rtc-optee.c
@@ -320,6 +320,7 @@ static int optee_rtc_remove(struct device *dev)
 {
 	struct optee_rtc *priv = dev_get_drvdata(dev);
 
+	tee_shm_free(priv->shm);
 	tee_client_close_session(priv->ctx, priv->session_id);
 	tee_client_close_context(priv->ctx);
 
diff --git a/drivers/rtc/rtc-x1205.c b/drivers/rtc/rtc-x1205.c
index 4bcd7ca32f27..b8a0fccef14e 100644
--- a/drivers/rtc/rtc-x1205.c
+++ b/drivers/rtc/rtc-x1205.c
@@ -669,7 +669,7 @@ static const struct i2c_device_id x1205_id[] = {
 MODULE_DEVICE_TABLE(i2c, x1205_id);
 
 static const struct of_device_id x1205_dt_ids[] = {
-	{ .compatible = "xircom,x1205", },
+	{ .compatible = "xicor,x1205", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, x1205_dt_ids);
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 42a4a996defb..93f346d313e9 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -332,6 +332,11 @@ static int dasd_state_basic_to_ready(struct dasd_device *device)
 	lim.max_dev_sectors = device->discipline->max_sectors(block);
 	lim.max_hw_sectors = lim.max_dev_sectors;
 	lim.logical_block_size = block->bp_block;
+	/*
+	 * Adjust dma_alignment to match block_size - 1
+	 * to ensure proper buffer alignment checks in the block layer.
+	 */
+	lim.dma_alignment = lim.logical_block_size - 1;
 
 	if (device->discipline->has_discard) {
 		unsigned int max_bytes;
@@ -3112,12 +3117,14 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
 		    PTR_ERR(cqr) == -ENOMEM ||
 		    PTR_ERR(cqr) == -EAGAIN) {
 			rc = BLK_STS_RESOURCE;
-			goto out;
+		} else if (PTR_ERR(cqr) == -EINVAL) {
+			rc = BLK_STS_INVAL;
+		} else {
+			DBF_DEV_EVENT(DBF_ERR, basedev,
+				      "CCW creation failed (rc=%ld) on request %p",
+				      PTR_ERR(cqr), req);
+			rc = BLK_STS_IOERR;
 		}
-		DBF_DEV_EVENT(DBF_ERR, basedev,
-			      "CCW creation failed (rc=%ld) on request %p",
-			      PTR_ERR(cqr), req);
-		rc = BLK_STS_IOERR;
 		goto out;
 	}
 	/*
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 9498825d9c7a..858a9e171351 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1318,23 +1318,34 @@ void ccw_device_schedule_recovery(void)
 	spin_unlock_irqrestore(&recovery_lock, flags);
 }
 
-static int purge_fn(struct device *dev, void *data)
+static int purge_fn(struct subchannel *sch, void *data)
 {
-	struct ccw_device *cdev = to_ccwdev(dev);
-	struct ccw_dev_id *id = &cdev->private->dev_id;
-	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_device *cdev;
 
-	spin_lock_irq(cdev->ccwlock);
-	if (is_blacklisted(id->ssid, id->devno) &&
-	    (cdev->private->state == DEV_STATE_OFFLINE) &&
-	    (atomic_cmpxchg(&cdev->private->onoff, 0, 1) == 0)) {
-		CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x\n", id->ssid,
-			      id->devno);
+	spin_lock_irq(&sch->lock);
+	if (sch->st != SUBCHANNEL_TYPE_IO || !sch->schib.pmcw.dnv)
+		goto unlock;
+
+	if (!is_blacklisted(sch->schid.ssid, sch->schib.pmcw.dev))
+		goto unlock;
+
+	cdev = sch_get_cdev(sch);
+	if (cdev) {
+		if (cdev->private->state != DEV_STATE_OFFLINE)
+			goto unlock;
+
+		if (atomic_cmpxchg(&cdev->private->onoff, 0, 1) != 0)
+			goto unlock;
 		ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
-		css_sched_sch_todo(sch, SCH_TODO_UNREG);
 		atomic_set(&cdev->private->onoff, 0);
 	}
-	spin_unlock_irq(cdev->ccwlock);
+
+	css_sched_sch_todo(sch, SCH_TODO_UNREG);
+	CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x%s\n", sch->schid.ssid,
+		      sch->schib.pmcw.dev, cdev ? "" : " (no cdev)");
+
+unlock:
+	spin_unlock_irq(&sch->lock);
 	/* Abort loop in case of pending signal. */
 	if (signal_pending(current))
 		return -EINTR;
@@ -1350,7 +1361,7 @@ static int purge_fn(struct device *dev, void *data)
 int ccw_purge_blacklisted(void)
 {
 	CIO_MSG_EVENT(2, "ccw: purging blacklisted devices\n");
-	bus_for_each_dev(&ccw_bus_type, NULL, NULL, purge_fn);
+	for_each_subchannel_staged(purge_fn, NULL, NULL);
 	return 0;
 }
 
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 0c49414c1f35..6cb6586f4790 100644
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
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 020037cbf0d9..655cca5fe7cc 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -124,7 +124,7 @@ static void mvs_free(struct mvs_info *mvi)
 	if (mvi->shost)
 		scsi_host_put(mvi->shost);
 	list_for_each_entry(mwq, &mvi->wq_list, entry)
-		cancel_delayed_work(&mwq->work_q);
+		cancel_delayed_work_sync(&mwq->work_q);
 	kfree(mvi->rsvd_tags);
 	kfree(mvi);
 }
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index ee1d5dec3bc6..3745cf856917 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3695,10 +3695,10 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	struct scsi_disk *sdkp = scsi_disk(disk);
 	struct scsi_device *sdp = sdkp->device;
 	sector_t old_capacity = sdkp->capacity;
-	struct queue_limits lim;
-	unsigned char *buffer;
+	struct queue_limits *lim = NULL;
+	unsigned char *buffer = NULL;
 	unsigned int dev_max;
-	int err;
+	int err = 0;
 
 	SCSI_LOG_HLQUEUE(3, sd_printk(KERN_INFO, sdkp,
 				      "sd_revalidate_disk\n"));
@@ -3710,6 +3710,10 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	if (!scsi_device_online(sdp))
 		goto out;
 
+	lim = kmalloc(sizeof(*lim), GFP_KERNEL);
+	if (!lim)
+		goto out;
+
 	buffer = kmalloc(SD_BUF_SIZE, GFP_KERNEL);
 	if (!buffer) {
 		sd_printk(KERN_WARNING, sdkp, "sd_revalidate_disk: Memory "
@@ -3719,14 +3723,14 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 	sd_spinup_disk(sdkp);
 
-	lim = queue_limits_start_update(sdkp->disk->queue);
+	*lim = queue_limits_start_update(sdkp->disk->queue);
 
 	/*
 	 * Without media there is no reason to ask; moreover, some devices
 	 * react badly if we do.
 	 */
 	if (sdkp->media_present) {
-		sd_read_capacity(sdkp, &lim, buffer);
+		sd_read_capacity(sdkp, lim, buffer);
 		/*
 		 * Some USB/UAS devices return generic values for mode pages
 		 * until the media has been accessed. Trigger a READ operation
@@ -3740,17 +3744,17 @@ static int sd_revalidate_disk(struct gendisk *disk)
 		 * cause this to be updated correctly and any device which
 		 * doesn't support it should be treated as rotational.
 		 */
-		lim.features |= (BLK_FEAT_ROTATIONAL | BLK_FEAT_ADD_RANDOM);
+		lim->features |= (BLK_FEAT_ROTATIONAL | BLK_FEAT_ADD_RANDOM);
 
 		if (scsi_device_supports_vpd(sdp)) {
 			sd_read_block_provisioning(sdkp);
-			sd_read_block_limits(sdkp, &lim);
+			sd_read_block_limits(sdkp, lim);
 			sd_read_block_limits_ext(sdkp);
-			sd_read_block_characteristics(sdkp, &lim);
-			sd_zbc_read_zones(sdkp, &lim, buffer);
+			sd_read_block_characteristics(sdkp, lim);
+			sd_zbc_read_zones(sdkp, lim, buffer);
 		}
 
-		sd_config_discard(sdkp, &lim, sd_discard_mode(sdkp));
+		sd_config_discard(sdkp, lim, sd_discard_mode(sdkp));
 
 		sd_print_capacity(sdkp, old_capacity);
 
@@ -3760,47 +3764,46 @@ static int sd_revalidate_disk(struct gendisk *disk)
 		sd_read_app_tag_own(sdkp, buffer);
 		sd_read_write_same(sdkp, buffer);
 		sd_read_security(sdkp, buffer);
-		sd_config_protection(sdkp, &lim);
+		sd_config_protection(sdkp, lim);
 	}
 
 	/*
 	 * We now have all cache related info, determine how we deal
 	 * with flush requests.
 	 */
-	sd_set_flush_flag(sdkp, &lim);
+	sd_set_flush_flag(sdkp, lim);
 
 	/* Initial block count limit based on CDB TRANSFER LENGTH field size. */
 	dev_max = sdp->use_16_for_rw ? SD_MAX_XFER_BLOCKS : SD_DEF_XFER_BLOCKS;
 
 	/* Some devices report a maximum block count for READ/WRITE requests. */
 	dev_max = min_not_zero(dev_max, sdkp->max_xfer_blocks);
-	lim.max_dev_sectors = logical_to_sectors(sdp, dev_max);
+	lim->max_dev_sectors = logical_to_sectors(sdp, dev_max);
 
 	if (sd_validate_min_xfer_size(sdkp))
-		lim.io_min = logical_to_bytes(sdp, sdkp->min_xfer_blocks);
+		lim->io_min = logical_to_bytes(sdp, sdkp->min_xfer_blocks);
 	else
-		lim.io_min = 0;
+		lim->io_min = 0;
 
 	/*
 	 * Limit default to SCSI host optimal sector limit if set. There may be
 	 * an impact on performance for when the size of a request exceeds this
 	 * host limit.
 	 */
-	lim.io_opt = sdp->host->opt_sectors << SECTOR_SHIFT;
+	lim->io_opt = sdp->host->opt_sectors << SECTOR_SHIFT;
 	if (sd_validate_opt_xfer_size(sdkp, dev_max)) {
-		lim.io_opt = min_not_zero(lim.io_opt,
+		lim->io_opt = min_not_zero(lim->io_opt,
 				logical_to_bytes(sdp, sdkp->opt_xfer_blocks));
 	}
 
 	sdkp->first_scan = 0;
 
 	set_capacity_and_notify(disk, logical_to_sectors(sdp, sdkp->capacity));
-	sd_config_write_same(sdkp, &lim);
-	kfree(buffer);
+	sd_config_write_same(sdkp, lim);
 
-	err = queue_limits_commit_update_frozen(sdkp->disk->queue, &lim);
+	err = queue_limits_commit_update_frozen(sdkp->disk->queue, lim);
 	if (err)
-		return err;
+		goto out;
 
 	/*
 	 * Query concurrent positioning ranges after
@@ -3819,7 +3822,10 @@ static int sd_revalidate_disk(struct gendisk *disk)
 		set_capacity_and_notify(disk, 0);
 
  out:
-	return 0;
+	kfree(buffer);
+	kfree(lim);
+
+	return err;
 }
 
 /**
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 56be0b6901a8..06e43b184d85 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -712,6 +712,7 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (op->addr.nbytes - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+	readl(reg_base + CQSPI_REG_SIZE); /* Flush posted write. */
 	return 0;
 }
 
@@ -754,6 +755,7 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	reinit_completion(&cqspi->transfer_complete);
 	writel(CQSPI_REG_INDIRECTRD_START_MASK,
 	       reg_base + CQSPI_REG_INDIRECTRD);
+	readl(reg_base + CQSPI_REG_INDIRECTRD); /* Flush posted write. */
 
 	while (remaining > 0) {
 		if (use_irq &&
@@ -1033,6 +1035,7 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (op->addr.nbytes - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+	readl(reg_base + CQSPI_REG_SIZE); /* Flush posted write. */
 	return 0;
 }
 
@@ -1058,6 +1061,8 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	reinit_completion(&cqspi->transfer_complete);
 	writel(CQSPI_REG_INDIRECTWR_START_MASK,
 	       reg_base + CQSPI_REG_INDIRECTWR);
+	readl(reg_base + CQSPI_REG_INDIRECTWR); /* Flush posted write. */
+
 	/*
 	 * As per 66AK2G02 TRM SPRUHY8F section 11.15.5.3 Indirect Access
 	 * Controller programming sequence, couple of cycles of
@@ -1668,12 +1673,10 @@ static const struct spi_controller_mem_caps cqspi_mem_caps = {
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi)
 {
-	unsigned int max_cs = cqspi->num_chipselect - 1;
 	struct platform_device *pdev = cqspi->pdev;
 	struct device *dev = &pdev->dev;
 	struct cqspi_flash_pdata *f_pdata;
-	unsigned int cs;
-	int ret;
+	int ret, cs, max_cs = -1;
 
 	/* Get flash device data */
 	for_each_available_child_of_node_scoped(dev->of_node, np) {
@@ -1686,10 +1689,10 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 		if (cs >= cqspi->num_chipselect) {
 			dev_err(dev, "Chip select %d out of range.\n", cs);
 			return -EINVAL;
-		} else if (cs < max_cs) {
-			max_cs = cs;
 		}
 
+		max_cs = max_t(int, cs, max_cs);
+
 		f_pdata = &cqspi->f_pdata[cs];
 		f_pdata->cqspi = cqspi;
 		f_pdata->cs = cs;
@@ -1699,6 +1702,11 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 			return ret;
 	}
 
+	if (max_cs < 0) {
+		dev_err(dev, "No flash device declared\n");
+		return -ENODEV;
+	}
+
 	cqspi->num_chipselect = max_cs + 1;
 	return 0;
 }
diff --git a/drivers/video/fbdev/core/fb_cmdline.c b/drivers/video/fbdev/core/fb_cmdline.c
index 4d1634c492ec..594b60424d1c 100644
--- a/drivers/video/fbdev/core/fb_cmdline.c
+++ b/drivers/video/fbdev/core/fb_cmdline.c
@@ -40,7 +40,7 @@ int fb_get_options(const char *name, char **option)
 	bool enabled;
 
 	if (name)
-		is_of = strncmp(name, "offb", 4);
+		is_of = !strncmp(name, "offb", 4);
 
 	enabled = __video_get_options(name, &options, is_of);
 
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 81effbd53dc5..ecd3ddda6ccb 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1320,14 +1320,17 @@ int bind_interdomain_evtchn_to_irq_lateeoi(struct xenbus_device *dev,
 }
 EXPORT_SYMBOL_GPL(bind_interdomain_evtchn_to_irq_lateeoi);
 
-static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn)
+static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn,
+		     bool percpu)
 {
 	struct evtchn_status status;
 	evtchn_port_t port;
-	int rc = -ENOENT;
+	bool exists = false;
 
 	memset(&status, 0, sizeof(status));
 	for (port = 0; port < xen_evtchn_max_channels(); port++) {
+		int rc;
+
 		status.dom = DOMID_SELF;
 		status.port = port;
 		rc = HYPERVISOR_event_channel_op(EVTCHNOP_status, &status);
@@ -1335,12 +1338,16 @@ static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn)
 			continue;
 		if (status.status != EVTCHNSTAT_virq)
 			continue;
-		if (status.u.virq == virq && status.vcpu == xen_vcpu_nr(cpu)) {
+		if (status.u.virq != virq)
+			continue;
+		if (status.vcpu == xen_vcpu_nr(cpu)) {
 			*evtchn = port;
-			break;
+			return 0;
+		} else if (!percpu) {
+			exists = true;
 		}
 	}
-	return rc;
+	return exists ? -EEXIST : -ENOENT;
 }
 
 /**
@@ -1387,8 +1394,11 @@ int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
 			evtchn = bind_virq.port;
 		else {
 			if (ret == -EEXIST)
-				ret = find_virq(virq, cpu, &evtchn);
-			BUG_ON(ret < 0);
+				ret = find_virq(virq, cpu, &evtchn, percpu);
+			if (ret) {
+				__unbind_from_irq(info, info->irq);
+				goto out;
+			}
 		}
 
 		ret = xen_irq_info_virq_setup(info, cpu, evtchn, virq);
@@ -1793,9 +1803,20 @@ static int xen_rebind_evtchn_to_cpu(struct irq_info *info, unsigned int tcpu)
 	 * virq or IPI channel, which don't actually need to be rebound. Ignore
 	 * it, but don't do the xenlinux-level rebind in that case.
 	 */
-	if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0)
+	if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0) {
+		int old_cpu = info->cpu;
+
 		bind_evtchn_to_cpu(info, tcpu, false);
 
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
index b4b4ebed68da..8f543c816347 100644
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
index e2b22bea348a..c403117ac013 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -23,7 +23,11 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
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
@@ -45,6 +49,8 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 		parent_root_id = btrfs_root_id(BTRFS_I(parent)->root);
 
 		if (parent_root_id != fid->root_objectid) {
+			if (*max_len < BTRFS_FID_SIZE_CONNECTABLE_ROOT)
+				return FILEID_INVALID;
 			fid->parent_root_objectid = parent_root_id;
 			len = BTRFS_FID_SIZE_CONNECTABLE_ROOT;
 			type = FILEID_BTRFS_WITH_PARENT_ROOT;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 60fe155b1ce0..b310a07a84ad 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -355,6 +355,13 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
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
 	if (!found || delalloc_end <= *start || delalloc_start > orig_end) {
@@ -385,13 +392,14 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 				   delalloc_end);
 	ASSERT(!ret || ret == -EAGAIN);
 	if (ret == -EAGAIN) {
-		/* some of the folios are gone, lets avoid looping by
-		 * shortening the size of the delalloc range we're searching
+		/*
+		 * Some of the folios are gone, lets avoid looping by
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
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index b84d1747a020..e7d192f7ab3b 100644
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
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 075fee4ba29b..8711fac20804 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -46,10 +46,10 @@
  *
  * 1) epnested_mutex (mutex)
  * 2) ep->mtx (mutex)
- * 3) ep->lock (rwlock)
+ * 3) ep->lock (spinlock)
  *
  * The acquire order is the one listed above, from 1 to 3.
- * We need a rwlock (ep->lock) because we manipulate objects
+ * We need a spinlock (ep->lock) because we manipulate objects
  * from inside the poll callback, that might be triggered from
  * a wake_up() that in turn might be called from IRQ context.
  * So we can't sleep inside the poll callback and hence we need
@@ -195,7 +195,7 @@ struct eventpoll {
 	struct list_head rdllist;
 
 	/* Lock which protects rdllist and ovflist */
-	rwlock_t lock;
+	spinlock_t lock;
 
 	/* RB tree root used to store monitored fd structs */
 	struct rb_root_cached rbr;
@@ -713,10 +713,10 @@ static void ep_start_scan(struct eventpoll *ep, struct list_head *txlist)
 	 * in a lockless way.
 	 */
 	lockdep_assert_irqs_enabled();
-	write_lock_irq(&ep->lock);
+	spin_lock_irq(&ep->lock);
 	list_splice_init(&ep->rdllist, txlist);
 	WRITE_ONCE(ep->ovflist, NULL);
-	write_unlock_irq(&ep->lock);
+	spin_unlock_irq(&ep->lock);
 }
 
 static void ep_done_scan(struct eventpoll *ep,
@@ -724,7 +724,7 @@ static void ep_done_scan(struct eventpoll *ep,
 {
 	struct epitem *epi, *nepi;
 
-	write_lock_irq(&ep->lock);
+	spin_lock_irq(&ep->lock);
 	/*
 	 * During the time we spent inside the "sproc" callback, some
 	 * other events might have been queued by the poll callback.
@@ -765,7 +765,7 @@ static void ep_done_scan(struct eventpoll *ep,
 			wake_up(&ep->wq);
 	}
 
-	write_unlock_irq(&ep->lock);
+	spin_unlock_irq(&ep->lock);
 }
 
 static void ep_get(struct eventpoll *ep)
@@ -839,10 +839,10 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 
 	rb_erase_cached(&epi->rbn, &ep->rbr);
 
-	write_lock_irq(&ep->lock);
+	spin_lock_irq(&ep->lock);
 	if (ep_is_linked(epi))
 		list_del_init(&epi->rdllink);
-	write_unlock_irq(&ep->lock);
+	spin_unlock_irq(&ep->lock);
 
 	wakeup_source_unregister(ep_wakeup_source(epi));
 	/*
@@ -1123,7 +1123,7 @@ static int ep_alloc(struct eventpoll **pep)
 		return -ENOMEM;
 
 	mutex_init(&ep->mtx);
-	rwlock_init(&ep->lock);
+	spin_lock_init(&ep->lock);
 	init_waitqueue_head(&ep->wq);
 	init_waitqueue_head(&ep->poll_wait);
 	INIT_LIST_HEAD(&ep->rdllist);
@@ -1210,100 +1210,10 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd,
 }
 #endif /* CONFIG_KCMP */
 
-/*
- * Adds a new entry to the tail of the list in a lockless way, i.e.
- * multiple CPUs are allowed to call this function concurrently.
- *
- * Beware: it is necessary to prevent any other modifications of the
- *         existing list until all changes are completed, in other words
- *         concurrent list_add_tail_lockless() calls should be protected
- *         with a read lock, where write lock acts as a barrier which
- *         makes sure all list_add_tail_lockless() calls are fully
- *         completed.
- *
- *        Also an element can be locklessly added to the list only in one
- *        direction i.e. either to the tail or to the head, otherwise
- *        concurrent access will corrupt the list.
- *
- * Return: %false if element has been already added to the list, %true
- * otherwise.
- */
-static inline bool list_add_tail_lockless(struct list_head *new,
-					  struct list_head *head)
-{
-	struct list_head *prev;
-
-	/*
-	 * This is simple 'new->next = head' operation, but cmpxchg()
-	 * is used in order to detect that same element has been just
-	 * added to the list from another CPU: the winner observes
-	 * new->next == new.
-	 */
-	if (!try_cmpxchg(&new->next, &new, head))
-		return false;
-
-	/*
-	 * Initially ->next of a new element must be updated with the head
-	 * (we are inserting to the tail) and only then pointers are atomically
-	 * exchanged.  XCHG guarantees memory ordering, thus ->next should be
-	 * updated before pointers are actually swapped and pointers are
-	 * swapped before prev->next is updated.
-	 */
-
-	prev = xchg(&head->prev, new);
-
-	/*
-	 * It is safe to modify prev->next and new->prev, because a new element
-	 * is added only to the tail and new->next is updated before XCHG.
-	 */
-
-	prev->next = new;
-	new->prev = prev;
-
-	return true;
-}
-
-/*
- * Chains a new epi entry to the tail of the ep->ovflist in a lockless way,
- * i.e. multiple CPUs are allowed to call this function concurrently.
- *
- * Return: %false if epi element has been already chained, %true otherwise.
- */
-static inline bool chain_epi_lockless(struct epitem *epi)
-{
-	struct eventpoll *ep = epi->ep;
-
-	/* Fast preliminary check */
-	if (epi->next != EP_UNACTIVE_PTR)
-		return false;
-
-	/* Check that the same epi has not been just chained from another CPU */
-	if (cmpxchg(&epi->next, EP_UNACTIVE_PTR, NULL) != EP_UNACTIVE_PTR)
-		return false;
-
-	/* Atomically exchange tail */
-	epi->next = xchg(&ep->ovflist, epi);
-
-	return true;
-}
-
 /*
  * This is the callback that is passed to the wait queue wakeup
  * mechanism. It is called by the stored file descriptors when they
  * have events to report.
- *
- * This callback takes a read lock in order not to contend with concurrent
- * events from another file descriptor, thus all modifications to ->rdllist
- * or ->ovflist are lockless.  Read lock is paired with the write lock from
- * ep_start/done_scan(), which stops all list modifications and guarantees
- * that lists state is seen correctly.
- *
- * Another thing worth to mention is that ep_poll_callback() can be called
- * concurrently for the same @epi from different CPUs if poll table was inited
- * with several wait queues entries.  Plural wakeup from different CPUs of a
- * single wait queue is serialized by wq.lock, but the case when multiple wait
- * queues are used should be detected accordingly.  This is detected using
- * cmpxchg() operation.
  */
 static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
 {
@@ -1314,7 +1224,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	unsigned long flags;
 	int ewake = 0;
 
-	read_lock_irqsave(&ep->lock, flags);
+	spin_lock_irqsave(&ep->lock, flags);
 
 	ep_set_busy_poll_napi_id(epi);
 
@@ -1343,12 +1253,15 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	 * chained in ep->ovflist and requeued later on.
 	 */
 	if (READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR) {
-		if (chain_epi_lockless(epi))
+		if (epi->next == EP_UNACTIVE_PTR) {
+			epi->next = READ_ONCE(ep->ovflist);
+			WRITE_ONCE(ep->ovflist, epi);
 			ep_pm_stay_awake_rcu(epi);
+		}
 	} else if (!ep_is_linked(epi)) {
 		/* In the usual case, add event to ready list. */
-		if (list_add_tail_lockless(&epi->rdllink, &ep->rdllist))
-			ep_pm_stay_awake_rcu(epi);
+		list_add_tail(&epi->rdllink, &ep->rdllist);
+		ep_pm_stay_awake_rcu(epi);
 	}
 
 	/*
@@ -1381,7 +1294,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 		pwake++;
 
 out_unlock:
-	read_unlock_irqrestore(&ep->lock, flags);
+	spin_unlock_irqrestore(&ep->lock, flags);
 
 	/* We have to call this outside the lock */
 	if (pwake)
@@ -1716,7 +1629,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	}
 
 	/* We have to drop the new item inside our item list to keep track of it */
-	write_lock_irq(&ep->lock);
+	spin_lock_irq(&ep->lock);
 
 	/* record NAPI ID of new item if present */
 	ep_set_busy_poll_napi_id(epi);
@@ -1733,7 +1646,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 			pwake++;
 	}
 
-	write_unlock_irq(&ep->lock);
+	spin_unlock_irq(&ep->lock);
 
 	/* We have to call this outside the lock */
 	if (pwake)
@@ -1797,7 +1710,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	 * list, push it inside.
 	 */
 	if (ep_item_poll(epi, &pt, 1)) {
-		write_lock_irq(&ep->lock);
+		spin_lock_irq(&ep->lock);
 		if (!ep_is_linked(epi)) {
 			list_add_tail(&epi->rdllink, &ep->rdllist);
 			ep_pm_stay_awake(epi);
@@ -1808,7 +1721,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 			if (waitqueue_active(&ep->poll_wait))
 				pwake++;
 		}
-		write_unlock_irq(&ep->lock);
+		spin_unlock_irq(&ep->lock);
 	}
 
 	/* We have to call this outside the lock */
@@ -2041,7 +1954,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		init_wait(&wait);
 		wait.func = ep_autoremove_wake_function;
 
-		write_lock_irq(&ep->lock);
+		spin_lock_irq(&ep->lock);
 		/*
 		 * Barrierless variant, waitqueue_active() is called under
 		 * the same lock on wakeup ep_poll_callback() side, so it
@@ -2060,7 +1973,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		if (!eavail)
 			__add_wait_queue_exclusive(&ep->wq, &wait);
 
-		write_unlock_irq(&ep->lock);
+		spin_unlock_irq(&ep->lock);
 
 		if (!eavail)
 			timed_out = !schedule_hrtimeout_range(to, slack,
@@ -2075,7 +1988,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		eavail = 1;
 
 		if (!list_empty_careful(&wait.entry)) {
-			write_lock_irq(&ep->lock);
+			spin_lock_irq(&ep->lock);
 			/*
 			 * If the thread timed out and is not on the wait queue,
 			 * it means that the thread was woken up after its
@@ -2086,7 +1999,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 			if (timed_out)
 				eavail = list_empty(&wait.entry);
 			__remove_wait_queue(&ep->wq, &wait);
-			write_unlock_irq(&ep->lock);
+			spin_unlock_irq(&ep->lock);
 		}
 	}
 }
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 37e18e654f71..d8a059ec1ad6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3107,6 +3107,8 @@ extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
 					 sector_t block, blk_opf_t op_flags);
 extern struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 						   sector_t block);
+extern struct buffer_head *ext4_sb_bread_nofail(struct super_block *sb,
+						sector_t block);
 extern void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
 				bh_end_io_t *end_io, bool simu_fail);
 extern int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 91185c40f755..22fc333244ef 100644
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
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index d45124318200..da76353b3a57 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -1025,7 +1025,7 @@ static void ext4_free_branches(handle_t *handle, struct inode *inode,
 			}
 
 			/* Go read the buffer for the next level down */
-			bh = ext4_sb_bread(inode->i_sb, nr, 0);
+			bh = ext4_sb_bread_nofail(inode->i_sb, nr);
 
 			/*
 			 * A read failure? Report error and clear slot
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 558a585c5df5..6af572425596 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3859,7 +3859,11 @@ int ext4_can_truncate(struct inode *inode)
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
@@ -3870,9 +3874,11 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 	loff_t size = i_size_read(inode);
 
 	WARN_ON(!inode_is_locked(inode));
-	if (offset > size || offset + len < size)
+	if (offset > size)
 		return 0;
 
+	if (offset + len < size)
+		size = offset + len;
 	if (EXT4_I(inode)->i_disksize >= size)
 		return 0;
 
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 898443e98efc..a4c94eabc78e 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -225,7 +225,7 @@ static int mext_page_mkuptodate(struct folio *folio, size_t from, size_t to)
 	do {
 		if (bh_offset(bh) + blocksize <= from)
 			continue;
-		if (bh_offset(bh) > to)
+		if (bh_offset(bh) >= to)
 			break;
 		wait_on_buffer(bh);
 		if (buffer_uptodate(bh))
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index c53918768cb2..05997b4d0120 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -513,7 +513,7 @@ void ext4_release_orphan_info(struct super_block *sb)
 		return;
 	for (i = 0; i < oi->of_blocks; i++)
 		brelse(oi->of_binfo[i].ob_bh);
-	kfree(oi->of_binfo);
+	kvfree(oi->of_binfo);
 }
 
 static struct ext4_orphan_block_tail *ext4_orphan_block_tail(
@@ -584,9 +584,20 @@ int ext4_init_orphan_info(struct super_block *sb)
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
@@ -627,7 +638,7 @@ int ext4_init_orphan_info(struct super_block *sb)
 out_free:
 	for (i--; i >= 0; i--)
 		brelse(oi->of_binfo[i].ob_bh);
-	kfree(oi->of_binfo);
+	kvfree(oi->of_binfo);
 out_put:
 	iput(inode);
 	return ret;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index cbb65e61c492..78ecdedadb07 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -266,6 +266,15 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
 }
 
+struct buffer_head *ext4_sb_bread_nofail(struct super_block *sb,
+					 sector_t block)
+{
+	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_mapping,
+			~__GFP_FS) | __GFP_MOVABLE | __GFP_NOFAIL;
+
+	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
+}
+
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
 	struct buffer_head *bh = bdev_getblk(sb->s_bdev, block,
@@ -2484,7 +2493,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 					struct ext4_fs_context *m_ctx)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char *s_mount_opts = NULL;
+	char s_mount_opts[65];
 	struct ext4_fs_context *s_ctx = NULL;
 	struct fs_context *fc = NULL;
 	int ret = -ENOMEM;
@@ -2492,15 +2501,11 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	if (!sbi->s_es->s_mount_opts[0])
 		return 0;
 
-	s_mount_opts = kstrndup(sbi->s_es->s_mount_opts,
-				sizeof(sbi->s_es->s_mount_opts),
-				GFP_KERNEL);
-	if (!s_mount_opts)
-		return ret;
+	strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts);
 
 	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)
-		goto out_free;
+		return -ENOMEM;
 
 	s_ctx = kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
 	if (!s_ctx)
@@ -2532,11 +2537,8 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	ret = 0;
 
 out_free:
-	if (fc) {
-		ext4_fc_free(fc);
-		kfree(fc);
-	}
-	kfree(s_mount_opts);
+	ext4_fc_free(fc);
+	kfree(fc);
 	return ret;
 }
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 6ff94cdf1515..5ddfa4801bb3 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -251,6 +251,10 @@ check_xattrs(struct inode *inode, struct buffer_head *bh,
 			err_str = "invalid ea_ino";
 			goto errout;
 		}
+		if (ea_ino && !size) {
+			err_str = "invalid size in ea xattr";
+			goto errout;
+		}
 		if (size > EXT4_XATTR_SIZE_MAX) {
 			err_str = "e_value size too large";
 			goto errout;
@@ -1036,7 +1040,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 				       int ref_change)
 {
 	struct ext4_iloc iloc;
-	s64 ref_count;
+	u64 ref_count;
 	int ret;
 
 	inode_lock_nested(ea_inode, I_MUTEX_XATTR);
@@ -1046,13 +1050,17 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
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
@@ -1061,9 +1069,6 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
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
index bfc9eb9e7229..68c1bcc6b7e9 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1262,7 +1262,10 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
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
index 4ae226778d64..28edfad85c62 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -446,22 +446,23 @@ static bool inode_do_switch_wbs(struct inode *inode,
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
@@ -503,6 +504,7 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	 */
 	down_read(&bdi->wb_switch_rwsem);
 
+	inodep = isw->inodes;
 	/*
 	 * By the time control reaches here, RCU grace period has passed
 	 * since I_WB_SWITCH assertion and all wb stat update transactions
@@ -513,6 +515,7 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	 * gives us exclusion against all wb related operations on @inode
 	 * including IO list manipulations and stat updates.
 	 */
+relock:
 	if (old_wb < new_wb) {
 		spin_lock(&old_wb->list_lock);
 		spin_lock_nested(&new_wb->list_lock, SINGLE_DEPTH_NESTING);
@@ -521,10 +524,17 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
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
index 6cef3deccded..8903d2c23db4 100644
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
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1f64ae6d7a69..8207855f9af2 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1989,7 +1989,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	 */
 	if (!oh.unique) {
 		err = fuse_notify(fc, oh.error, nbytes - sizeof(oh), cs);
-		goto out;
+		goto copy_finish;
 	}
 
 	err = -EINVAL;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 49659d1b2932..a8218a3bc0b4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -355,8 +355,14 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * Make the release synchronous if this is a fuseblk mount,
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
+	 *
+	 * Always use the asynchronous file put because the current thread
+	 * might be the fuse server.  This can happen if a process starts some
+	 * aio and closes the fd before the aio completes.  Since aio takes its
+	 * own ref to the file, the IO completion has to drop the ref, which is
+	 * how the fuse server can end up closing its clients' files.
 	 */
-	fuse_file_put(ff, ff->fm->fc->destroy);
+	fuse_file_put(ff, false);
 }
 
 void fuse_release_common(struct file *file, bool isdir)
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index f007e389d5d2..fc01f9dc8c39 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -491,8 +491,14 @@ void minix_set_inode(struct inode *inode, dev_t rdev)
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
index 6795600c5738..1eb20cb5e58f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1388,6 +1388,10 @@ static int follow_automount(struct path *path, int *count, unsigned lookup_flags
 	    dentry->d_inode)
 		return -EISDIR;
 
+	/* No need to trigger automounts if mountpoint crossing is disabled. */
+	if (lookup_flags & LOOKUP_NO_XDEV)
+		return -EXDEV;
+
 	if (count && (*count)++ >= MAXSYMLINKS)
 		return -ELOOP;
 
@@ -1411,6 +1415,10 @@ static int __traverse_mounts(struct path *path, unsigned flags, bool *jumped,
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
index c8519302f582..cc4926d53e7d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
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
@@ -144,7 +153,7 @@ static void mnt_ns_release(struct mnt_namespace *ns)
 	lockdep_assert_not_held(&mnt_ns_tree_lock);
 
 	/* keep alive for {list,stat}mount() */
-	if (refcount_dec_and_test(&ns->passive)) {
+	if (ns && refcount_dec_and_test(&ns->passive)) {
 		put_user_ns(ns->user_ns);
 		kfree(ns);
 	}
@@ -5200,7 +5209,6 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
 static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 			struct mnt_namespace *ns)
 {
-	struct path root __free(path_put) = {};
 	struct mount *m;
 	int err;
 
@@ -5212,7 +5220,7 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!s->mnt)
 		return -ENOENT;
 
-	err = grab_requested_root(ns, &root);
+	err = grab_requested_root(ns, &s->root);
 	if (err)
 		return err;
 
@@ -5221,15 +5229,13 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	 * mounts to show users.
 	 */
 	m = real_mount(s->mnt);
-	if (!is_path_reachable(m, m->mnt.mnt_root, &root) &&
+	if (!is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
 	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	err = security_sb_statfs(s->mnt->mnt_root);
 	if (err)
 		return err;
-
-	s->root = root;
 	if (s->mask & STATMOUNT_SB_BASIC)
 		statmount_sb_basic(s);
 
@@ -5406,28 +5412,40 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 	if (!ret)
 		ret = copy_statmount_to_user(ks);
 	kvfree(ks->seq.buf);
+	path_put(&ks->root);
 	if (retry_statmount(ret, &seq_size))
 		goto retry;
 	return ret;
 }
 
-static ssize_t do_listmount(struct mnt_namespace *ns, u64 mnt_parent_id,
-			    u64 last_mnt_id, u64 *mnt_ids, size_t nr_mnt_ids,
-			    bool reverse)
+struct klistmount {
+	u64 last_mnt_id;
+	u64 mnt_parent_id;
+	u64 *kmnt_ids;
+	u32 nr_mnt_ids;
+	struct mnt_namespace *ns;
+	struct path root;
+};
+
+static ssize_t do_listmount(struct klistmount *kls, bool reverse)
 {
-	struct path root __free(path_put) = {};
+	struct mnt_namespace *ns = kls->ns;
+	u64 mnt_parent_id = kls->mnt_parent_id;
+	u64 last_mnt_id = kls->last_mnt_id;
+	u64 *mnt_ids = kls->kmnt_ids;
+	size_t nr_mnt_ids = kls->nr_mnt_ids;
 	struct path orig;
 	struct mount *r, *first;
 	ssize_t ret;
 
 	rwsem_assert_held(&namespace_sem);
 
-	ret = grab_requested_root(ns, &root);
+	ret = grab_requested_root(ns, &kls->root);
 	if (ret)
 		return ret;
 
 	if (mnt_parent_id == LSMT_ROOT) {
-		orig = root;
+		orig = kls->root;
 	} else {
 		orig.mnt = lookup_mnt_in_ns(mnt_parent_id, ns);
 		if (!orig.mnt)
@@ -5439,7 +5457,7 @@ static ssize_t do_listmount(struct mnt_namespace *ns, u64 mnt_parent_id,
 	 * Don't trigger audit denials. We just want to determine what
 	 * mounts to show users.
 	 */
-	if (!is_path_reachable(real_mount(orig.mnt), orig.dentry, &root) &&
+	if (!is_path_reachable(real_mount(orig.mnt), orig.dentry, &kls->root) &&
 	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
@@ -5472,14 +5490,45 @@ static ssize_t do_listmount(struct mnt_namespace *ns, u64 mnt_parent_id,
 	return ret;
 }
 
+static void __free_klistmount_free(const struct klistmount *kls)
+{
+	path_put(&kls->root);
+	kvfree(kls->kmnt_ids);
+	mnt_ns_release(kls->ns);
+}
+
+static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *kreq,
+				     size_t nr_mnt_ids)
+{
+
+	u64 last_mnt_id = kreq->param;
+
+	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
+	if (last_mnt_id != 0 && last_mnt_id <= MNT_UNIQUE_ID_OFFSET)
+		return -EINVAL;
+
+	kls->last_mnt_id = last_mnt_id;
+
+	kls->nr_mnt_ids = nr_mnt_ids;
+	kls->kmnt_ids = kvmalloc_array(nr_mnt_ids, sizeof(*kls->kmnt_ids),
+				       GFP_KERNEL_ACCOUNT);
+	if (!kls->kmnt_ids)
+		return -ENOMEM;
+
+	kls->ns = grab_requested_mnt_ns(kreq);
+	if (!kls->ns)
+		return -ENOENT;
+
+	kls->mnt_parent_id = kreq->mnt_id;
+	return 0;
+}
+
 SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 		u64 __user *, mnt_ids, size_t, nr_mnt_ids, unsigned int, flags)
 {
-	u64 *kmnt_ids __free(kvfree) = NULL;
+	struct klistmount kls __free(klistmount_free) = {};
 	const size_t maxcount = 1000000;
-	struct mnt_namespace *ns __free(mnt_ns_release) = NULL;
 	struct mnt_id_req kreq;
-	u64 last_mnt_id;
 	ssize_t ret;
 
 	if (flags & ~LISTMOUNT_REVERSE)
@@ -5500,31 +5549,20 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	if (ret)
 		return ret;
 
-	last_mnt_id = kreq.param;
-	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
-	if (last_mnt_id != 0 && last_mnt_id <= MNT_UNIQUE_ID_OFFSET)
-		return -EINVAL;
-
-	kmnt_ids = kvmalloc_array(nr_mnt_ids, sizeof(*kmnt_ids),
-				  GFP_KERNEL_ACCOUNT);
-	if (!kmnt_ids)
-		return -ENOMEM;
-
-	ns = grab_requested_mnt_ns(&kreq);
-	if (!ns)
-		return -ENOENT;
+	ret = prepare_klistmount(&kls, &kreq, nr_mnt_ids);
+	if (ret)
+		return ret;
 
-	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
-	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
+	if (kreq.mnt_ns_id && (kls.ns != current->nsproxy->mnt_ns) &&
+	    !ns_capable_noaudit(kls.ns->user_ns, CAP_SYS_ADMIN))
 		return -ENOENT;
 
 	scoped_guard(rwsem_read, &namespace_sem)
-		ret = do_listmount(ns, kreq.mnt_id, last_mnt_id, kmnt_ids,
-				   nr_mnt_ids, (flags & LISTMOUNT_REVERSE));
+		ret = do_listmount(&kls, (flags & LISTMOUNT_REVERSE));
 	if (ret <= 0)
 		return ret;
 
-	if (copy_to_user(mnt_ids, kmnt_ids, ret * sizeof(*mnt_ids)))
+	if (copy_to_user(mnt_ids, kls.kmnt_ids, ret * sizeof(*mnt_ids)))
 		return -EFAULT;
 
 	return ret;
@@ -5537,7 +5575,7 @@ static void __init init_mount_tree(void)
 	struct mnt_namespace *ns;
 	struct path root;
 
-	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
+	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", initramfs_options);
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
 
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 6cf92498a5ac..86bdc7d23fb9 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -211,10 +211,6 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
 		return ERR_PTR(-ENOMEM);
 	}
 	cb_info->serv = serv;
-	/* As there is only one thread we need to over-ride the
-	 * default maximum of 80 connections
-	 */
-	serv->sv_maxconn = 1024;
 	dprintk("nfs_callback_create_svc: service created\n");
 	return serv;
 }
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index fdeb0b34a3d3..4254ba3ee7c5 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -984,6 +984,7 @@ static __be32 nfs4_callback_compound(struct svc_rqst *rqstp)
 			nfs_put_client(cps.clp);
 			goto out_invalidcred;
 		}
+		svc_xprt_set_valid(rqstp->rq_xprt);
 	}
 
 	cps.minorversion = hdr_arg.minorversion;
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 49aede376d86..3216416ca042 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1075,47 +1075,62 @@ static struct svc_export *exp_find(struct cache_detail *cd,
 }
 
 /**
- * check_nfsd_access - check if access to export is allowed.
+ * check_xprtsec_policy - check if access to export is allowed by the
+ *			  xprtsec policy
  * @exp: svc_export that is being accessed.
- * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
+ * @rqstp: svc_rqst attempting to access @exp.
+ *
+ * Helper function for check_nfsd_access().  Note that callers should be
+ * using check_nfsd_access() instead of calling this function directly.  The
+ * one exception is __fh_verify() since it has logic that may result in one
+ * or both of the helpers being skipped.
  *
  * Return values:
  *   %nfs_ok if access is granted, or
  *   %nfserr_wrongsec if access is denied
  */
-__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
+__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp)
 {
-	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
-	struct svc_xprt *xprt;
-
-	/*
-	 * If rqstp is NULL, this is a LOCALIO request which will only
-	 * ever use a filehandle/credential pair for which access has
-	 * been affirmed (by ACCESS or OPEN NFS requests) over the
-	 * wire. So there is no need for further checks here.
-	 */
-	if (!rqstp)
-		return nfs_ok;
-
-	xprt = rqstp->rq_xprt;
+	struct svc_xprt *xprt = rqstp->rq_xprt;
 
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
 		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
-			goto ok;
+			return nfs_ok;
 	}
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_TLS) {
 		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
 		    !test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
-			goto ok;
+			return nfs_ok;
 	}
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_MTLS) {
 		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
 		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
-			goto ok;
+			return nfs_ok;
 	}
-	goto denied;
+	return nfserr_wrongsec;
+}
+
+/**
+ * check_security_flavor - check if access to export is allowed by the
+ *			   security flavor
+ * @exp: svc_export that is being accessed.
+ * @rqstp: svc_rqst attempting to access @exp.
+ * @may_bypass_gss: reduce strictness of authorization check
+ *
+ * Helper function for check_nfsd_access().  Note that callers should be
+ * using check_nfsd_access() instead of calling this function directly.  The
+ * one exception is __fh_verify() since it has logic that may result in one
+ * or both of the helpers being skipped.
+ *
+ * Return values:
+ *   %nfs_ok if access is granted, or
+ *   %nfserr_wrongsec if access is denied
+ */
+__be32 check_security_flavor(struct svc_export *exp, struct svc_rqst *rqstp,
+			     bool may_bypass_gss)
+{
+	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
 
-ok:
 	/* legacy gss-only clients are always OK: */
 	if (exp->ex_client == rqstp->rq_gssclient)
 		return nfs_ok;
@@ -1140,10 +1155,47 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 	if (nfsd4_spo_must_allow(rqstp))
 		return nfs_ok;
 
-denied:
+	/* Some calls may be processed without authentication
+	 * on GSS exports. For example NFS2/3 calls on root
+	 * directory, see section 2.3.2 of rfc 2623.
+	 * For "may_bypass_gss" check that export has really
+	 * enabled some flavor with authentication (GSS or any
+	 * other) and also check that the used auth flavor is
+	 * without authentication (none or sys).
+	 */
+	if (may_bypass_gss && (
+	     rqstp->rq_cred.cr_flavor == RPC_AUTH_NULL ||
+	     rqstp->rq_cred.cr_flavor == RPC_AUTH_UNIX)) {
+		for (f = exp->ex_flavors; f < end; f++) {
+			if (f->pseudoflavor >= RPC_AUTH_DES)
+				return 0;
+		}
+	}
+
 	return nfserr_wrongsec;
 }
 
+/**
+ * check_nfsd_access - check if access to export is allowed.
+ * @exp: svc_export that is being accessed.
+ * @rqstp: svc_rqst attempting to access @exp.
+ * @may_bypass_gss: reduce strictness of authorization check
+ *
+ * Return values:
+ *   %nfs_ok if access is granted, or
+ *   %nfserr_wrongsec if access is denied
+ */
+__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
+			 bool may_bypass_gss)
+{
+	__be32 status;
+
+	status = check_xprtsec_policy(exp, rqstp);
+	if (status != nfs_ok)
+		return status;
+	return check_security_flavor(exp, rqstp, may_bypass_gss);
+}
+
 /*
  * Uses rq_client and rq_gssclient to find an export; uses rq_client (an
  * auth_unix client) if it's available and has secinfo information;
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index 3794ae253a70..0f4d34943e2c 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -101,7 +101,11 @@ struct svc_expkey {
 
 struct svc_cred;
 int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp);
-__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp);
+__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp);
+__be32 check_security_flavor(struct svc_export *exp, struct svc_rqst *rqstp,
+			     bool may_bypass_gss);
+__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
+			 bool may_bypass_gss);
 
 /*
  * Function declarations
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 46a7f9b813e5..6b042218668b 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -38,16 +38,40 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
 	memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
 	fh.fh_export = NULL;
 
+	/*
+	 * Allow BYPASS_GSS as some client implementations use AUTH_SYS
+	 * for NLM even when GSS is used for NFS.
+	 * Allow OWNER_OVERRIDE as permission might have been changed
+	 * after the file was opened.
+	 * Pass MAY_NLM so that authentication can be completely bypassed
+	 * if NFSEXP_NOAUTHNLM is set.  Some older clients use AUTH_NULL
+	 * for NLM requests.
+	 */
 	access = (mode == O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_READ;
-	access |= NFSD_MAY_LOCK;
+	access |= NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NFSD_MAY_BYPASS_GSS;
 	nfserr = nfsd_open(rqstp, &fh, S_IFREG, access, filp);
 	fh_put(&fh);
- 	/* We return nlm error codes as nlm doesn't know
+	/* We return nlm error codes as nlm doesn't know
 	 * about nfsd, but nfsd does know about nlm..
 	 */
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
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 26f7b34d1a03..a05a45bb1978 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -129,8 +129,8 @@ struct nfsd_net {
 	unsigned char writeverf[8];
 
 	/*
-	 * Max number of connections this nfsd container will allow. Defaults
-	 * to '0' which is means that it bases this on the number of threads.
+	 * Max number of non-validated connections this nfsd container
+	 * will allow.  Defaults to '0' gets mapped to 64.
 	 */
 	unsigned int max_connections;
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 02c9f3b312a0..8f2dc7eb4fc4 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1372,7 +1372,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 		return 0;
 	}
 	if (work) {
-		strscpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr) - 1);
+		strscpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
 		refcount_set(&work->nsui_refcnt, 2);
 		work->nsui_busy = true;
 		list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
@@ -2799,7 +2799,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 
 			if (current_fh->fh_export &&
 					need_wrongsec_check(rqstp))
-				op->status = check_nfsd_access(current_fh->fh_export, rqstp);
+				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
 		}
 encode_op:
 		if (op->status == nfserr_replay_me) {
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index bcb44400e243..7b0fabf8c657 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7998,11 +7998,9 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (check_lock_length(lock->lk_offset, lock->lk_length))
 		 return nfserr_inval;
 
-	if ((status = fh_verify(rqstp, &cstate->current_fh,
-				S_IFREG, NFSD_MAY_LOCK))) {
-		dprintk("NFSD: nfsd4_lock: permission denied!\n");
+	status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0);
+	if (status != nfs_ok)
 		return status;
-	}
 	sb = cstate->current_fh.fh_dentry->d_sb;
 
 	if (lock->lk_is_new) {
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6edeb3bdf81b..90db900b346c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3784,7 +3784,7 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
 			nfserr = nfserrno(err);
 			goto out_put;
 		}
-		nfserr = check_nfsd_access(exp, cd->rd_rqstp);
+		nfserr = check_nfsd_access(exp, cd->rd_rqstp, false);
 		if (nfserr)
 			goto out_put;
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 96e19c50a5d7..854dcdc36b2c 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -320,6 +320,7 @@ __fh_verify(struct svc_rqst *rqstp,
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_export *exp = NULL;
+	bool may_bypass_gss = false;
 	struct dentry	*dentry;
 	__be32		error;
 
@@ -363,12 +364,31 @@ __fh_verify(struct svc_rqst *rqstp,
 		goto out;
 
 	/*
-	 * pseudoflavor restrictions are not enforced on NLM,
-	 * which clients virtually always use auth_sys for,
-	 * even while using RPCSEC_GSS for NFS.
+	 * If rqstp is NULL, this is a LOCALIO request which will only
+	 * ever use a filehandle/credential pair for which access has
+	 * been affirmed (by ACCESS or OPEN NFS requests) over the
+	 * wire.  Skip both the xprtsec policy and the security flavor
+	 * checks.
 	 */
-	if (access & NFSD_MAY_LOCK || access & NFSD_MAY_BYPASS_GSS)
-		goto skip_pseudoflavor_check;
+	if (!rqstp)
+		goto check_permissions;
+
+	if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NOAUTHNLM))
+		/* NLM is allowed to fully bypass authentication */
+		goto out;
+
+	/*
+	 * NLM is allowed to bypass the xprtsec policy check because lockd
+	 * doesn't support xprtsec.
+	 */
+	if (!(access & NFSD_MAY_NLM)) {
+		error = check_xprtsec_policy(exp, rqstp);
+		if (error)
+			goto out;
+	}
+
+	if (access & NFSD_MAY_BYPASS_GSS)
+		may_bypass_gss = true;
 	/*
 	 * Clients may expect to be able to use auth_sys during mount,
 	 * even if they use gss for everything else; see section 2.3.2
@@ -376,13 +396,17 @@ __fh_verify(struct svc_rqst *rqstp,
 	 */
 	if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT
 			&& exp->ex_path.dentry == dentry)
-		goto skip_pseudoflavor_check;
+		may_bypass_gss = true;
 
-	error = check_nfsd_access(exp, rqstp);
+	error = check_security_flavor(exp, rqstp, may_bypass_gss);
 	if (error)
 		goto out;
 
-skip_pseudoflavor_check:
+	/* During LOCALIO call to fh_verify will be called with a NULL rqstp */
+	if (rqstp)
+		svc_xprt_set_valid(rqstp->rq_xprt);
+
+check_permissions:
 	/* Finally, check access permissions. */
 	error = nfsd_permission(cred, exp, dentry, access);
 out:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b8470d4cbe99..3448e444d410 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -79,7 +79,7 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
 		{ NFSD_MAY_READ,		"READ" },		\
 		{ NFSD_MAY_SATTR,		"SATTR" },		\
 		{ NFSD_MAY_TRUNC,		"TRUNC" },		\
-		{ NFSD_MAY_LOCK,		"LOCK" },		\
+		{ NFSD_MAY_NLM,			"NLM" },		\
 		{ NFSD_MAY_OWNER_OVERRIDE,	"OWNER_OVERRIDE" },	\
 		{ NFSD_MAY_LOCAL_ACCESS,	"LOCAL_ACCESS" },	\
 		{ NFSD_MAY_BYPASS_GSS_ON_ROOT,	"BYPASS_GSS_ON_ROOT" },	\
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index ca29a5e1600f..8c4f4e2f9cee 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -321,7 +321,7 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
 	err = nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
 	if (err)
 		return err;
-	err = check_nfsd_access(exp, rqstp);
+	err = check_nfsd_access(exp, rqstp, false);
 	if (err)
 		goto out;
 	/*
@@ -2519,7 +2519,7 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 		(acc & NFSD_MAY_EXEC)?	" exec"  : "",
 		(acc & NFSD_MAY_SATTR)?	" sattr" : "",
 		(acc & NFSD_MAY_TRUNC)?	" trunc" : "",
-		(acc & NFSD_MAY_LOCK)?	" lock"  : "",
+		(acc & NFSD_MAY_NLM)?	" nlm"  : "",
 		(acc & NFSD_MAY_OWNER_OVERRIDE)? " owneroverride" : "",
 		inode->i_mode,
 		IS_IMMUTABLE(inode)?	" immut" : "",
@@ -2544,16 +2544,6 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 	if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
 		return nfserr_perm;
 
-	if (acc & NFSD_MAY_LOCK) {
-		/* If we cannot rely on authentication in NLM requests,
-		 * just allow locks, otherwise require read permission, or
-		 * ownership
-		 */
-		if (exp->ex_flags & NFSEXP_NOAUTHNLM)
-			return 0;
-		else
-			acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
-	}
 	/*
 	 * The file owner always gets access permission for accesses that
 	 * would normally be checked at open time. This is to make
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 3ff146522556..a61ada4fd920 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -20,7 +20,7 @@
 #define NFSD_MAY_READ			0x004 /* == MAY_READ */
 #define NFSD_MAY_SATTR			0x008
 #define NFSD_MAY_TRUNC			0x010
-#define NFSD_MAY_LOCK			0x020
+#define NFSD_MAY_NLM			0x020 /* request is from lockd */
 #define NFSD_MAY_MASK			0x03f
 
 /* extra hints to permission and open routines: */
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index cf4fe21a5039..29b585f443f3 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -1399,6 +1399,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 		mark_buffer_dirty(bh);
 		unlock_buffer(bh);
 		/* err = sync_dirty_buffer(bh); */
+		put_bh(bh);
 
 		b0 = 0;
 		bits -= op;
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 71c0ce31a4c4..94825180385a 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -163,6 +163,9 @@ static struct quota_module_name module_names[] = INIT_QUOTA_MODULE_NAMES;
 /* SLAB cache for dquot structures */
 static struct kmem_cache *dquot_cachep;
 
+/* workqueue for work quota_release_work*/
+static struct workqueue_struct *quota_unbound_wq;
+
 void register_quota_format(struct quota_format_type *fmt)
 {
 	spin_lock(&dq_list_lock);
@@ -882,7 +885,7 @@ void dqput(struct dquot *dquot)
 	put_releasing_dquots(dquot);
 	atomic_dec(&dquot->dq_count);
 	spin_unlock(&dq_list_lock);
-	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
+	queue_delayed_work(quota_unbound_wq, &quota_release_work, 1);
 }
 EXPORT_SYMBOL(dqput);
 
@@ -3042,6 +3045,11 @@ static int __init dquot_init(void)
 
 	shrinker_register(dqcache_shrinker);
 
+	quota_unbound_wq = alloc_workqueue("quota_events_unbound",
+					   WQ_UNBOUND | WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
+	if (!quota_unbound_wq)
+		panic("Cannot create quota_unbound_wq\n");
+
 	return 0;
 }
 fs_initcall(dquot_init);
diff --git a/fs/read_write.c b/fs/read_write.c
index befec0b5c537..46408bab9238 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1600,6 +1600,13 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (len == 0)
 		return 0;
 
+	/*
+	 * Make sure return value doesn't overflow in 32bit compat mode.  Also
+	 * limit the size for all cases except when calling ->copy_file_range().
+	 */
+	if (splice || !file_out->f_op->copy_file_range || in_compat_syscall())
+		len = min_t(size_t, MAX_RW_COUNT, len);
+
 	file_start_write(file_out);
 
 	/*
@@ -1613,9 +1620,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 						      len, flags);
 	} else if (!splice && file_in->f_op->remap_file_range && samesb) {
 		ret = file_in->f_op->remap_file_range(file_in, pos_in,
-				file_out, pos_out,
-				min_t(loff_t, MAX_RW_COUNT, len),
-				REMAP_FILE_CAN_SHORTEN);
+				file_out, pos_out, len, REMAP_FILE_CAN_SHORTEN);
 		/* fallback to splice */
 		if (ret <= 0)
 			splice = true;
@@ -1648,8 +1653,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	 * to splicing from input file, while file_start_write() is held on
 	 * the output file on a different sb.
 	 */
-	ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out,
-			       min_t(size_t, len, MAX_RW_COUNT), 0);
+	ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out, len, 0);
 done:
 	if (ret > 0) {
 		fsnotify_access(file_in);
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 0385a514f59e..4670c3e451a7 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -671,14 +671,72 @@ static int cifs_query_path_info(const unsigned int xid,
 	}
 
 #ifdef CONFIG_CIFS_XATTR
+	/*
+	 * For non-symlink WSL reparse points it is required to fetch
+	 * EA $LXMOD which contains in its S_DT part the mandatory file type.
+	 */
+	if (!rc && data->reparse_point) {
+		struct smb2_file_full_ea_info *ea;
+		u32 next = 0;
+
+		ea = (struct smb2_file_full_ea_info *)data->wsl.eas;
+		do {
+			ea = (void *)((u8 *)ea + next);
+			next = le32_to_cpu(ea->next_entry_offset);
+		} while (next);
+		if (le16_to_cpu(ea->ea_value_length)) {
+			ea->next_entry_offset = cpu_to_le32(ALIGN(sizeof(*ea) +
+						ea->ea_name_length + 1 +
+						le16_to_cpu(ea->ea_value_length), 4));
+			ea = (void *)((u8 *)ea + le32_to_cpu(ea->next_entry_offset));
+		}
+
+		rc = CIFSSMBQAllEAs(xid, tcon, full_path, SMB2_WSL_XATTR_MODE,
+				    &ea->ea_data[SMB2_WSL_XATTR_NAME_LEN + 1],
+				    SMB2_WSL_XATTR_MODE_SIZE, cifs_sb);
+		if (rc == SMB2_WSL_XATTR_MODE_SIZE) {
+			ea->next_entry_offset = cpu_to_le32(0);
+			ea->flags = 0;
+			ea->ea_name_length = SMB2_WSL_XATTR_NAME_LEN;
+			ea->ea_value_length = cpu_to_le16(SMB2_WSL_XATTR_MODE_SIZE);
+			memcpy(&ea->ea_data[0], SMB2_WSL_XATTR_MODE, SMB2_WSL_XATTR_NAME_LEN + 1);
+			data->wsl.eas_len += ALIGN(sizeof(*ea) + SMB2_WSL_XATTR_NAME_LEN + 1 +
+						   SMB2_WSL_XATTR_MODE_SIZE, 4);
+			rc = 0;
+		} else if (rc >= 0) {
+			/* It is an error if EA $LXMOD has wrong size. */
+			rc = -EINVAL;
+		} else {
+			/*
+			 * In all other cases ignore error if fetching
+			 * of EA $LXMOD failed. It is needed only for
+			 * non-symlink WSL reparse points and wsl_to_fattr()
+			 * handle the case when EA is missing.
+			 */
+			rc = 0;
+		}
+	}
+
 	/*
 	 * For WSL CHR and BLK reparse points it is required to fetch
 	 * EA $LXDEV which contains major and minor device numbers.
 	 */
 	if (!rc && data->reparse_point) {
 		struct smb2_file_full_ea_info *ea;
+		u32 next = 0;
 
 		ea = (struct smb2_file_full_ea_info *)data->wsl.eas;
+		do {
+			ea = (void *)((u8 *)ea + next);
+			next = le32_to_cpu(ea->next_entry_offset);
+		} while (next);
+		if (le16_to_cpu(ea->ea_value_length)) {
+			ea->next_entry_offset = cpu_to_le32(ALIGN(sizeof(*ea) +
+						ea->ea_name_length + 1 +
+						le16_to_cpu(ea->ea_value_length), 4));
+			ea = (void *)((u8 *)ea + le32_to_cpu(ea->next_entry_offset));
+		}
+
 		rc = CIFSSMBQAllEAs(xid, tcon, full_path, SMB2_WSL_XATTR_DEV,
 				    &ea->ea_data[SMB2_WSL_XATTR_NAME_LEN + 1],
 				    SMB2_WSL_XATTR_DEV_SIZE, cifs_sb);
@@ -688,8 +746,8 @@ static int cifs_query_path_info(const unsigned int xid,
 			ea->ea_name_length = SMB2_WSL_XATTR_NAME_LEN;
 			ea->ea_value_length = cpu_to_le16(SMB2_WSL_XATTR_DEV_SIZE);
 			memcpy(&ea->ea_data[0], SMB2_WSL_XATTR_DEV, SMB2_WSL_XATTR_NAME_LEN + 1);
-			data->wsl.eas_len = sizeof(*ea) + SMB2_WSL_XATTR_NAME_LEN + 1 +
-					    SMB2_WSL_XATTR_DEV_SIZE;
+			data->wsl.eas_len += ALIGN(sizeof(*ea) + SMB2_WSL_XATTR_NAME_LEN + 1 +
+						   SMB2_WSL_XATTR_MODE_SIZE, 4);
 			rc = 0;
 		} else if (rc >= 0) {
 			/* It is an error if EA $LXDEV has wrong size. */
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 104a563dc317..cb049bc70e0c 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -1220,31 +1220,33 @@ int
 smb2_set_file_info(struct inode *inode, const char *full_path,
 		   FILE_BASIC_INFO *buf, const unsigned int xid)
 {
-	struct cifs_open_parms oparms;
+	struct kvec in_iov = { .iov_base = buf, .iov_len = sizeof(*buf), };
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifsFileInfo *cfile = NULL;
+	struct cifs_open_parms oparms;
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
-	struct cifsFileInfo *cfile;
-	struct kvec in_iov = { .iov_base = buf, .iov_len = sizeof(*buf), };
-	int rc;
-
-	if ((buf->CreationTime == 0) && (buf->LastAccessTime == 0) &&
-	    (buf->LastWriteTime == 0) && (buf->ChangeTime == 0) &&
-	    (buf->Attributes == 0))
-		return 0; /* would be a no op, no sense sending this */
+	int rc = 0;
 
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
 	tcon = tlink_tcon(tlink);
 
-	cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
+	if ((buf->CreationTime == 0) && (buf->LastAccessTime == 0) &&
+	    (buf->LastWriteTime == 0) && (buf->ChangeTime == 0)) {
+		if (buf->Attributes == 0)
+			goto out; /* would be a no op, no sense sending this */
+		cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
+	}
+
 	oparms = CIFS_OPARMS(cifs_sb, tcon, full_path, FILE_WRITE_ATTRIBUTES,
 			     FILE_OPEN, 0, ACL_NO_MODE);
 	rc = smb2_compound_op(xid, tcon, cifs_sb,
 			      full_path, &oparms, &in_iov,
 			      &(int){SMB2_OP_SET_INFO}, 1,
 			      cfile, NULL, NULL, NULL);
+out:
 	cifs_put_tlink(tlink);
 	return rc;
 }
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index c946c3a09245..1b30035d02bc 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4657,7 +4657,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 	unsigned int pad_len;
 	struct cifs_io_subrequest *rdata = mid->callback_data;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
-	int length;
+	size_t copied;
 	bool use_rdma_mr = false;
 
 	if (shdr->Command != SMB2_READ) {
@@ -4770,10 +4770,10 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 	} else if (buf_len >= data_offset + data_len) {
 		/* read response payload is in buf */
 		WARN_ONCE(buffer, "read data can be either in buf or in buffer");
-		length = copy_to_iter(buf + data_offset, data_len, &rdata->subreq.io_iter);
-		if (length < 0)
-			return length;
-		rdata->got_bytes = data_len;
+		copied = copy_to_iter(buf + data_offset, data_len, &rdata->subreq.io_iter);
+		if (copied == 0)
+			return -EIO;
+		rdata->got_bytes = copied;
 	} else {
 		/* read response payload cannot be in both buf and pages */
 		WARN_ONCE(1, "buf can not contain only a part of read data");
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 53104f25de51..f5dcb8353f86 100644
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
@@ -184,8 +192,21 @@ int squashfs_read_inode(struct inode *inode, long long ino)
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
@@ -200,7 +221,6 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 
 		xattr_id = le32_to_cpu(sqsh_ino->xattr);
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
-		inode->i_size = le64_to_cpu(sqsh_ino->file_size);
 		inode->i_op = &squashfs_inode_ops;
 		inode->i_fop = &generic_ro_fops;
 		inode->i_mode |= S_IFREG;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 78b24b090488..f35b29f50097 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -213,6 +213,12 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_osi_data, 0);
  */
 ACPI_INIT_GLOBAL(u8, acpi_gbl_reduced_hardware, FALSE);
 
+/*
+ * ACPI Global Lock is mainly used for systems with SMM, so no-SMM systems
+ * (such as loong_arch) may not have and not use Global Lock.
+ */
+ACPI_INIT_GLOBAL(u8, acpi_gbl_use_global_lock, TRUE);
+
 /*
  * Maximum timeout for While() loop iterations before forced method abort.
  * This mechanism is intended to prevent infinite loops during interpreter
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 80de699bf6af..6862982c5f1a 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -75,6 +75,7 @@
 #if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TRACE_MMIO__))
 #include <linux/tracepoint-defs.h>
 
+#define rwmmio_tracepoint_enabled(tracepoint) tracepoint_enabled(tracepoint)
 DECLARE_TRACEPOINT(rwmmio_write);
 DECLARE_TRACEPOINT(rwmmio_post_write);
 DECLARE_TRACEPOINT(rwmmio_read);
@@ -91,6 +92,7 @@ void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
 
 #else
 
+#define rwmmio_tracepoint_enabled(tracepoint) false
 static inline void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
 				  unsigned long caller_addr, unsigned long caller_addr0) {}
 static inline void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
@@ -189,11 +191,13 @@ static inline u8 readb(const volatile void __iomem *addr)
 {
 	u8 val;
 
-	log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __raw_readb(addr);
 	__io_ar(val);
-	log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -204,11 +208,13 @@ static inline u16 readw(const volatile void __iomem *addr)
 {
 	u16 val;
 
-	log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
 	__io_ar(val);
-	log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -219,11 +225,13 @@ static inline u32 readl(const volatile void __iomem *addr)
 {
 	u32 val;
 
-	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
 	__io_ar(val);
-	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -235,11 +243,13 @@ static inline u64 readq(const volatile void __iomem *addr)
 {
 	u64 val;
 
-	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
 	__io_ar(val);
-	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -249,11 +259,13 @@ static inline u64 readq(const volatile void __iomem *addr)
 #define writeb writeb
 static inline void writeb(u8 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writeb(value, addr);
 	__io_aw();
-	log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -261,11 +273,13 @@ static inline void writeb(u8 value, volatile void __iomem *addr)
 #define writew writew
 static inline void writew(u16 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writew((u16 __force)cpu_to_le16(value), addr);
 	__io_aw();
-	log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -273,11 +287,13 @@ static inline void writew(u16 value, volatile void __iomem *addr)
 #define writel writel
 static inline void writel(u32 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
 	__io_aw();
-	log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -286,11 +302,13 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 #define writeq writeq
 static inline void writeq(u64 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
 	__io_aw();
-	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 #endif /* CONFIG_64BIT */
@@ -306,9 +324,11 @@ static inline u8 readb_relaxed(const volatile void __iomem *addr)
 {
 	u8 val;
 
-	log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
 	val = __raw_readb(addr);
-	log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -319,9 +339,11 @@ static inline u16 readw_relaxed(const volatile void __iomem *addr)
 {
 	u16 val;
 
-	log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
 	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
-	log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -332,9 +354,11 @@ static inline u32 readl_relaxed(const volatile void __iomem *addr)
 {
 	u32 val;
 
-	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
 	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
-	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -345,9 +369,11 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
 {
 	u64 val;
 
-	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
 	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
-	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -356,9 +382,11 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
 #define writeb_relaxed writeb_relaxed
 static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 	__raw_writeb(value, addr);
-	log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -366,9 +394,11 @@ static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 #define writew_relaxed writew_relaxed
 static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 	__raw_writew((u16 __force)cpu_to_le16(value), addr);
-	log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -376,9 +406,11 @@ static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 #define writel_relaxed writel_relaxed
 static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
-	log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -386,9 +418,11 @@ static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 #define writeq_relaxed writeq_relaxed
 static inline void writeq_relaxed(u64 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
-	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a604c54ae44d..794e38320f56 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -32,6 +32,9 @@
  */
 
 #define CPUFREQ_ETERNAL			(-1)
+
+#define CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS	NSEC_PER_MSEC
+
 #define CPUFREQ_NAME_LEN		16
 /* Print length for names. Extra 1 space for accommodating '\n' in prints */
 #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)
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
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index ec9c05044d4f..af303641819a 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -57,8 +57,14 @@ static inline long mm_ksm_zero_pages(struct mm_struct *mm)
 static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	/* Adding mm to ksm is best effort on fork. */
-	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
+	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags)) {
+		long nr_ksm_zero_pages = atomic_long_read(&mm->ksm_zero_pages);
+
+		mm->ksm_merging_pages = 0;
+		mm->ksm_rmap_items = 0;
+		atomic_long_add(nr_ksm_zero_pages, &ksm_zero_pages);
 		__ksm_enter(mm);
+	}
 }
 
 static inline int ksm_execve(struct mm_struct *mm)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 41f5c88bdf3b..f0fa8404957d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4318,14 +4318,13 @@ static inline void pgalloc_tag_copy(struct folio *new, struct folio *old)
  * since this value becomes part of PP_SIGNATURE; meaning we can just use the
  * space between the PP_SIGNATURE value (without POISON_POINTER_DELTA), and the
  * lowest bits of POISON_POINTER_DELTA. On arches where POISON_POINTER_DELTA is
- * 0, we make sure that we leave the two topmost bits empty, as that guarantees
- * we won't mistake a valid kernel pointer for a value we set, regardless of the
- * VMSPLIT setting.
+ * 0, we use the lowest bit of PAGE_OFFSET as the boundary if that value is
+ * known at compile-time.
  *
- * Altogether, this means that the number of bits available is constrained by
- * the size of an unsigned long (at the upper end, subtracting two bits per the
- * above), and the definition of PP_SIGNATURE (with or without
- * POISON_POINTER_DELTA).
+ * If the value of PAGE_OFFSET is not known at compile time, or if it is too
+ * small to leave at least 8 bits available above PP_SIGNATURE, we define the
+ * number of bits to be 0, which turns off the DMA index tracking altogether
+ * (see page_pool_register_dma_index()).
  */
 #define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELTA))
 #if POISON_POINTER_DELTA > 0
@@ -4334,8 +4333,13 @@ static inline void pgalloc_tag_copy(struct folio *new, struct folio *old)
  */
 #define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_INDEX_SHIFT)
 #else
-/* Always leave out the topmost two; see above. */
-#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 2)
+/* Use the lowest bit of PAGE_OFFSET if there's at least 8 bits available; see above */
+#define PP_DMA_INDEX_MIN_OFFSET (1 << (PP_DMA_INDEX_SHIFT + 8))
+#define PP_DMA_INDEX_BITS ((__builtin_constant_p(PAGE_OFFSET) && \
+			    PAGE_OFFSET >= PP_DMA_INDEX_MIN_OFFSET && \
+			    !(PAGE_OFFSET & (PP_DMA_INDEX_MIN_OFFSET - 1))) ? \
+			      MIN(32, __ffs(PAGE_OFFSET) - PP_DMA_INDEX_SHIFT) : 0)
+
 #endif
 
 #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index bc8af3eb5598..1fbeb61babeb 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -7,6 +7,12 @@
 #include <linux/preempt.h>
 #include <linux/sched.h>
 
+#ifdef CONFIG_MEMBARRIER
+# define RSEQ_EVENT_GUARD	irq
+#else
+# define RSEQ_EVENT_GUARD	preempt
+#endif
+
 /*
  * Map the event mask on the user-space ABI enum rseq_cs_flags
  * for direct mask checks.
@@ -41,9 +47,8 @@ static inline void rseq_handle_notify_resume(struct ksignal *ksig,
 static inline void rseq_signal_deliver(struct ksignal *ksig,
 				       struct pt_regs *regs)
 {
-	preempt_disable();
-	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
-	preempt_enable();
+	scoped_guard(RSEQ_EVENT_GUARD)
+		__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
 	rseq_handle_notify_resume(ksig, regs);
 }
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index e68fecf6eab5..617ebfff2f30 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -81,7 +81,7 @@ struct svc_serv {
 	unsigned int		sv_xdrsize;	/* XDR buffer size */
 	struct list_head	sv_permsocks;	/* all permanent sockets */
 	struct list_head	sv_tempsocks;	/* all temporary sockets */
-	int			sv_tmpcnt;	/* count of temporary sockets */
+	int			sv_tmpcnt;	/* count of temporary "valid" sockets */
 	struct timer_list	sv_temptimer;	/* timer for aging temporary sockets */
 
 	char *			sv_name;	/* service name */
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 0981e35a9fed..72d1a08f4828 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -99,8 +99,27 @@ enum {
 	XPT_HANDSHAKE,		/* xprt requests a handshake */
 	XPT_TLS_SESSION,	/* transport-layer security established */
 	XPT_PEER_AUTH,		/* peer has been authenticated */
+	XPT_PEER_VALID,		/* peer has presented a filehandle that
+				 * it has access to.  It is NOT counted
+				 * in ->sv_tmpcnt.
+				 */
+	XPT_RPCB_UNREG,		/* transport that needs unregistering
+				 * with rpcbind (TCP, UDP) on destroy
+				 */
 };
 
+static inline void svc_xprt_set_valid(struct svc_xprt *xpt)
+{
+	if (test_bit(XPT_TEMP, &xpt->xpt_flags) &&
+	    !test_and_set_bit(XPT_PEER_VALID, &xpt->xpt_flags)) {
+		struct svc_serv *serv = xpt->xpt_server;
+
+		spin_lock(&serv->sv_lock);
+		serv->sv_tmpcnt -= 1;
+		spin_unlock(&serv->sv_lock);
+	}
+}
+
 static inline void unregister_xpt_user(struct svc_xprt *xpt, struct svc_xpt_user *u)
 {
 	spin_lock(&xpt->xpt_lock);
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 43343f1586d1..d0746e2c869a 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1952,19 +1952,23 @@ extern const struct v4l2_subdev_ops v4l2_subdev_call_wrappers;
  *
  * Note: only legacy non-MC drivers may need this macro.
  */
-#define v4l2_subdev_call_state_try(sd, o, f, args...)                 \
-	({                                                            \
-		int __result;                                         \
-		static struct lock_class_key __key;                   \
-		const char *name = KBUILD_BASENAME                    \
-			":" __stringify(__LINE__) ":state->lock";     \
-		struct v4l2_subdev_state *state =                     \
-			__v4l2_subdev_state_alloc(sd, name, &__key);  \
-		v4l2_subdev_lock_state(state);                        \
-		__result = v4l2_subdev_call(sd, o, f, state, ##args); \
-		v4l2_subdev_unlock_state(state);                      \
-		__v4l2_subdev_state_free(state);                      \
-		__result;                                             \
+#define v4l2_subdev_call_state_try(sd, o, f, args...)                         \
+	({                                                                    \
+		int __result;                                                 \
+		static struct lock_class_key __key;                           \
+		const char *name = KBUILD_BASENAME                            \
+			":" __stringify(__LINE__) ":state->lock";             \
+		struct v4l2_subdev_state *state =                             \
+			__v4l2_subdev_state_alloc(sd, name, &__key);          \
+		if (IS_ERR(state)) {                                          \
+			__result = PTR_ERR(state);                            \
+		} else {                                                      \
+			v4l2_subdev_lock_state(state);                        \
+			__result = v4l2_subdev_call(sd, o, f, state, ##args); \
+			v4l2_subdev_unlock_state(state);                      \
+			__v4l2_subdev_state_free(state);                      \
+		}                                                             \
+		__result;                                                     \
 	})
 
 /**
diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 63b55ccc4f00..e5187144c91b 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -136,6 +136,7 @@ DECLARE_EVENT_CLASS(dma_alloc_class,
 		__entry->dma_addr = dma_addr;
 		__entry->size = size;
 		__entry->flags = flags;
+		__entry->dir = dir;
 		__entry->attrs = attrs;
 	),
 
diff --git a/init/main.c b/init/main.c
index c4778edae797..821df1f05e9c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -543,6 +543,12 @@ static int __init unknown_bootoption(char *param, char *val,
 				     const char *unused, void *arg)
 {
 	size_t len = strlen(param);
+	/*
+	 * Well-known bootloader identifiers:
+	 * 1. LILO/Grub pass "BOOT_IMAGE=...";
+	 * 2. kexec/kdump (kexec-tools) pass "kexec".
+	 */
+	const char *bootloader[] = { "BOOT_IMAGE=", "kexec", NULL };
 
 	/* Handle params aliased to sysctls */
 	if (sysctl_is_alias(param))
@@ -550,6 +556,12 @@ static int __init unknown_bootoption(char *param, char *val,
 
 	repair_env_string(param, val);
 
+	/* Handle bootloader identifier */
+	for (int i = 0; bootloader[i]; i++) {
+		if (strstarts(param, bootloader[i]))
+			return 0;
+	}
+
 	/* Handle obsolete-style parameters */
 	if (obsolete_checksetup(param))
 		return 0;
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9aaf5124648b..746b5644d9a1 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -775,7 +775,7 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static void bpf_free_inode(struct inode *inode)
+static void bpf_destroy_inode(struct inode *inode)
 {
 	enum bpf_type type;
 
@@ -790,7 +790,7 @@ const struct super_operations bpf_super_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
 	.show_options	= bpf_show_options,
-	.free_inode	= bpf_free_inode,
+	.destroy_inode	= bpf_destroy_inode,
 };
 
 enum {
diff --git a/kernel/fork.c b/kernel/fork.c
index 97c9afe3efc3..e5ec098a6f61 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1807,7 +1807,7 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
 	return 0;
 }
 
-static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_sighand(u64 clone_flags, struct task_struct *tsk)
 {
 	struct sighand_struct *sig;
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 2715afb77eab..b80c3bfb58d0 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -487,7 +487,7 @@ pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns)
 	struct upid *upid;
 	pid_t nr = 0;
 
-	if (pid && ns->level <= pid->level) {
+	if (pid && ns && ns->level <= pid->level) {
 		upid = &pid->numbers[ns->level];
 		if (upid->ns == ns)
 			nr = upid->nr;
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 23894ba8250c..810005f927d7 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -255,12 +255,12 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 
 	/*
 	 * Load and clear event mask atomically with respect to
-	 * scheduler preemption.
+	 * scheduler preemption and membarrier IPIs.
 	 */
-	preempt_disable();
-	event_mask = t->rseq_event_mask;
-	t->rseq_event_mask = 0;
-	preempt_enable();
+	scoped_guard(RSEQ_EVENT_GUARD) {
+		event_mask = t->rseq_event_mask;
+		t->rseq_event_mask = 0;
+	}
 
 	return !!event_mask;
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 53e3670fbb1e..6ec66fef3f91 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2617,6 +2617,25 @@ static int find_later_rq(struct task_struct *task)
 	return -1;
 }
 
+static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_dl_tasks(rq))
+		return NULL;
+
+	p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
+
+	WARN_ON_ONCE(rq->cpu != task_cpu(p));
+	WARN_ON_ONCE(task_current(rq, p));
+	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
+
+	WARN_ON_ONCE(!task_on_rq_queued(p));
+	WARN_ON_ONCE(!dl_task(p));
+
+	return p;
+}
+
 /* Locks the rq it finds */
 static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 {
@@ -2644,12 +2663,37 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
-			if (unlikely(task_rq(task) != rq ||
+			/*
+			 * double_lock_balance had to release rq->lock, in the
+			 * meantime, task may no longer be fit to be migrated.
+			 * Check the following to ensure that the task is
+			 * still suitable for migration:
+			 * 1. It is possible the task was scheduled,
+			 *    migrate_disabled was set and then got preempted,
+			 *    so we must check the task migration disable
+			 *    flag.
+			 * 2. The CPU picked is in the task's affinity.
+			 * 3. For throttled task (dl_task_offline_migration),
+			 *    check the following:
+			 *    - the task is not on the rq anymore (it was
+			 *      migrated)
+			 *    - the task is not on CPU anymore
+			 *    - the task is still a dl task
+			 *    - the task is not queued on the rq anymore
+			 * 4. For the non-throttled task (push_dl_task), the
+			 *    check to ensure that this task is still at the
+			 *    head of the pushable tasks list is enough.
+			 */
+			if (unlikely(is_migration_disabled(task) ||
 				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
-				     task_on_cpu(rq, task) ||
-				     !dl_task(task) ||
-				     is_migration_disabled(task) ||
-				     !task_on_rq_queued(task))) {
+				     (task->dl.dl_throttled &&
+				      (task_rq(task) != rq ||
+				       task_on_cpu(rq, task) ||
+				       !dl_task(task) ||
+				       !task_on_rq_queued(task))) ||
+				     (!task->dl.dl_throttled &&
+				      task != pick_next_pushable_dl_task(rq)))) {
+
 				double_unlock_balance(rq, later_rq);
 				later_rq = NULL;
 				break;
@@ -2672,25 +2716,6 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 	return later_rq;
 }
 
-static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
-{
-	struct task_struct *p;
-
-	if (!has_pushable_dl_tasks(rq))
-		return NULL;
-
-	p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
-
-	WARN_ON_ONCE(rq->cpu != task_cpu(p));
-	WARN_ON_ONCE(task_current(rq, p));
-	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
-
-	WARN_ON_ONCE(!task_on_rq_queued(p));
-	WARN_ON_ONCE(!dl_task(p));
-
-	return p;
-}
-
 /*
  * See if the non running -deadline tasks on this rq
  * can be sent to some other CPU where they can preempt
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index af61769b1d50..b3d9826e25b0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7187,6 +7187,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	int h_nr_delayed = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
+	int ret = 0;
 
 	if (entity_is_task(se)) {
 		p = task_of(se);
@@ -7218,7 +7219,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			return 0;
+			goto out;
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
@@ -7261,7 +7262,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			return 0;
+			goto out;
 	}
 
 	sub_nr_running(rq, h_nr_queued);
@@ -7273,6 +7274,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
+	ret = 1;
+out:
 	if (p && task_delayed) {
 		SCHED_WARN_ON(!task_sleep);
 		SCHED_WARN_ON(p->on_rq != 1);
@@ -7288,7 +7291,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		__block_task(rq, p);
 	}
 
-	return 1;
+	return ret;
 }
 
 /*
diff --git a/kernel/sys.c b/kernel/sys.c
index 4da31f28fda8..35990f0796bc 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1698,6 +1698,7 @@ SYSCALL_DEFINE4(prlimit64, pid_t, pid, unsigned int, resource,
 	struct rlimit old, new;
 	struct task_struct *tsk;
 	unsigned int checkflags = 0;
+	bool need_tasklist;
 	int ret;
 
 	if (old_rlim)
@@ -1724,8 +1725,25 @@ SYSCALL_DEFINE4(prlimit64, pid_t, pid, unsigned int, resource,
 	get_task_struct(tsk);
 	rcu_read_unlock();
 
-	ret = do_prlimit(tsk, resource, new_rlim ? &new : NULL,
-			old_rlim ? &old : NULL);
+	need_tasklist = !same_thread_group(tsk, current);
+	if (need_tasklist) {
+		/*
+		 * Ensure we can't race with group exit or de_thread(),
+		 * so tsk->group_leader can't be freed or changed until
+		 * read_unlock(tasklist_lock) below.
+		 */
+		read_lock(&tasklist_lock);
+		if (!pid_alive(tsk))
+			ret = -ESRCH;
+	}
+
+	if (!ret) {
+		ret = do_prlimit(tsk, resource, new_rlim ? &new : NULL,
+				old_rlim ? &old : NULL);
+	}
+
+	if (need_tasklist)
+		read_unlock(&tasklist_lock);
 
 	if (!ret && old_rlim) {
 		rlim_to_rlim64(&old, &old64);
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index af7d6e2060d9..440dbfa6bbfd 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -343,12 +343,14 @@ static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
 			     void *entry_data)
 {
 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
+	unsigned int flags = trace_probe_load_flag(&tf->tp);
 	int ret = 0;
 
-	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
+	if (flags & TP_FLAG_TRACE)
 		fentry_trace_func(tf, entry_ip, regs);
+
 #ifdef CONFIG_PERF_EVENTS
-	if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
+	if (flags & TP_FLAG_PROFILE)
 		ret = fentry_perf_func(tf, entry_ip, regs);
 #endif
 	return ret;
@@ -360,11 +362,12 @@ static void fexit_dispatcher(struct fprobe *fp, unsigned long entry_ip,
 			     void *entry_data)
 {
 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
+	unsigned int flags = trace_probe_load_flag(&tf->tp);
 
-	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
+	if (flags & TP_FLAG_TRACE)
 		fexit_trace_func(tf, entry_ip, ret_ip, regs, entry_data);
 #ifdef CONFIG_PERF_EVENTS
-	if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
+	if (flags & TP_FLAG_PROFILE)
 		fexit_perf_func(tf, entry_ip, ret_ip, regs, entry_data);
 #endif
 }
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 6b9c3f3f870f..b273611c5026 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1799,14 +1799,15 @@ static int kprobe_register(struct trace_event_call *event,
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
@@ -1818,6 +1819,7 @@ kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
 	struct kretprobe *rp = get_kretprobe(ri);
 	struct trace_kprobe *tk;
+	unsigned int flags;
 
 	/*
 	 * There is a small chance that get_kretprobe(ri) returns NULL when
@@ -1830,10 +1832,11 @@ kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
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
index 8a6797c2278d..4f54f7935d5d 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -269,16 +269,21 @@ struct event_file_link {
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
index 9916677acf24..f210e71bc155 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1531,6 +1531,7 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
 	struct uprobe_cpu_buffer *ucb = NULL;
+	unsigned int flags;
 	int ret = 0;
 
 	tu = container_of(con, struct trace_uprobe, consumer);
@@ -1545,11 +1546,12 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	if (WARN_ON_ONCE(!uprobe_cpu_buffer))
 		return 0;
 
-	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
+	flags = trace_probe_load_flag(&tu->tp);
+	if (flags & TP_FLAG_TRACE)
 		ret |= uprobe_trace_func(tu, regs, &ucb);
 
 #ifdef CONFIG_PERF_EVENTS
-	if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
+	if (flags & TP_FLAG_PROFILE)
 		ret |= uprobe_perf_func(tu, regs, &ucb);
 #endif
 	uprobe_buffer_put(ucb);
@@ -1562,6 +1564,7 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
 	struct uprobe_cpu_buffer *ucb = NULL;
+	unsigned int flags;
 
 	tu = container_of(con, struct trace_uprobe, consumer);
 
@@ -1573,11 +1576,12 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	if (WARN_ON_ONCE(!uprobe_cpu_buffer))
 		return 0;
 
-	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
+	flags = trace_probe_load_flag(&tu->tp);
+	if (flags & TP_FLAG_TRACE)
 		uretprobe_trace_func(tu, func, regs, &ucb);
 
 #ifdef CONFIG_PERF_EVENTS
-	if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
+	if (flags & TP_FLAG_PROFILE)
 		uretprobe_perf_func(tu, func, regs, &ucb);
 #endif
 	uprobe_buffer_put(ucb);
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 969baab8c805..7ccc18accb23 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -33,6 +33,10 @@ obj-$(CONFIG_CRYPTO_LIB_CURVE25519_GENERIC)	+= libcurve25519-generic.o
 libcurve25519-generic-y				:= curve25519-fiat32.o
 libcurve25519-generic-$(CONFIG_ARCH_SUPPORTS_INT128)	:= curve25519-hacl64.o
 libcurve25519-generic-y				+= curve25519-generic.o
+# clang versions prior to 18 may blow out the stack with KASAN
+ifeq ($(call clang-min-version, 180000),)
+KASAN_SANITIZE_curve25519-hacl64.o := n
+endif
 
 obj-$(CONFIG_CRYPTO_LIB_CURVE25519)		+= libcurve25519.o
 libcurve25519-y					+= curve25519.o
diff --git a/lib/genalloc.c b/lib/genalloc.c
index 4fa5635bf81b..841f29783833 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -899,8 +899,11 @@ struct gen_pool *of_gen_pool_get(struct device_node *np,
 		if (!name)
 			name = of_node_full_name(np_pool);
 	}
-	if (pdev)
+	if (pdev) {
 		pool = gen_pool_get(&pdev->dev, name);
+		put_device(&pdev->dev);
+	}
+
 	of_node_put(np_pool);
 
 	return pool;
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index c2b4f0b07147..5654e31a198a 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -203,7 +203,7 @@ static int damon_lru_sort_apply_parameters(void)
 		goto out;
 	}
 
-	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
+	err = damon_set_attrs(param_ctx, &damon_lru_sort_mon_attrs);
 	if (err)
 		goto out;
 
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index dba3b2f4d758..52e5c244bd02 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -324,10 +324,8 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 	}
 
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
-	if (!pte) {
-		walk->action = ACTION_AGAIN;
+	if (!pte)
 		return 0;
-	}
 	if (!pte_present(ptep_get(pte)))
 		goto out;
 	damon_ptep_mkold(pte, walk->vma, addr);
@@ -479,10 +477,8 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
 
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
-	if (!pte) {
-		walk->action = ACTION_AGAIN;
+	if (!pte)
 		return 0;
-	}
 	ptent = ptep_get(pte);
 	if (!pte_present(ptent))
 		goto out;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f94a9d413585..029b67d48d30 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3715,32 +3715,23 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
 static bool thp_underused(struct folio *folio)
 {
 	int num_zero_pages = 0, num_filled_pages = 0;
-	void *kaddr;
 	int i;
 
 	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
 		return false;
 
 	for (i = 0; i < folio_nr_pages(folio); i++) {
-		kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
-		if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
-			num_zero_pages++;
-			if (num_zero_pages > khugepaged_max_ptes_none) {
-				kunmap_local(kaddr);
+		if (pages_identical(folio_page(folio, i), ZERO_PAGE(0))) {
+			if (++num_zero_pages > khugepaged_max_ptes_none)
 				return true;
-			}
 		} else {
 			/*
 			 * Another path for early exit once the number
 			 * of non-zero filled pages exceeds threshold.
 			 */
-			num_filled_pages++;
-			if (num_filled_pages >= HPAGE_PMD_NR - khugepaged_max_ptes_none) {
-				kunmap_local(kaddr);
+			if (++num_filled_pages >= HPAGE_PMD_NR - khugepaged_max_ptes_none)
 				return false;
-			}
 		}
-		kunmap_local(kaddr);
 	}
 	return false;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fff6edb1174d..d404532ae41e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3453,6 +3453,9 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 		initialized = true;
 	}
 
+	if (!h->max_huge_pages)
+		return;
+
 	/* do node specific alloc */
 	if (hugetlb_hstate_alloc_pages_specific_nodes(h))
 		return;
diff --git a/mm/migrate.c b/mm/migrate.c
index 8619aa884eaa..2bcfc41b7e4c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -198,19 +198,16 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
 }
 
 static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
-					  struct folio *folio,
-					  unsigned long idx)
+		struct folio *folio, pte_t old_pte, unsigned long idx)
 {
 	struct page *page = folio_page(folio, idx);
-	bool contains_data;
 	pte_t newpte;
-	void *addr;
 
 	if (PageCompound(page))
 		return false;
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
+	VM_BUG_ON_PAGE(pte_present(old_pte), page);
 
 	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
 	    mm_forbids_zeropage(pvmw->vma->vm_mm))
@@ -221,15 +218,17 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 	 * this subpage has been non present. If the subpage is only zero-filled
 	 * then map it to the shared zeropage.
 	 */
-	addr = kmap_local_page(page);
-	contains_data = memchr_inv(addr, 0, PAGE_SIZE);
-	kunmap_local(addr);
-
-	if (contains_data)
+	if (!pages_identical(page, ZERO_PAGE(0)))
 		return false;
 
 	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
 					pvmw->vma->vm_page_prot));
+
+	if (pte_swp_soft_dirty(old_pte))
+		newpte = pte_mksoft_dirty(newpte);
+	if (pte_swp_uffd_wp(old_pte))
+		newpte = pte_mkuffd_wp(newpte);
+
 	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
 
 	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
@@ -272,13 +271,13 @@ static bool remove_migration_pte(struct folio *folio,
 			continue;
 		}
 #endif
+		old_pte = ptep_get(pvmw.pte);
 		if (rmap_walk_arg->map_unused_to_zeropage &&
-		    try_to_map_unused_to_zeropage(&pvmw, folio, idx))
+		    try_to_map_unused_to_zeropage(&pvmw, folio, old_pte, idx))
 			continue;
 
 		folio_get(folio);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
-		old_pte = ptep_get(pvmw.pte);
 
 		entry = pte_to_swp_entry(old_pte);
 		if (!is_migration_entry_young(entry))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 752576749db9..765c890e6a84 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4052,7 +4052,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
 			alloc_flags |= ALLOC_NON_BLOCK;
 
-			if (order > 0)
+			if (order > 0 && (alloc_flags & ALLOC_MIN_RESERVE))
 				alloc_flags |= ALLOC_HIGHATOMIC;
 		}
 
diff --git a/mm/slab.h b/mm/slab.h
index 92ca5ff20375..b65d2462b3fd 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -572,8 +572,12 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 	unsigned long obj_exts = READ_ONCE(slab->obj_exts);
 
 #ifdef CONFIG_MEMCG
-	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS),
-							slab_page(slab));
+	/*
+	 * obj_exts should be either NULL, a valid pointer with
+	 * MEMCG_DATA_OBJEXTS bit set or be equal to OBJEXTS_ALLOC_FAIL.
+	 */
+	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS) &&
+		       obj_exts != OBJEXTS_ALLOC_FAIL, slab_page(slab));
 	VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
 #endif
 	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
diff --git a/mm/slub.c b/mm/slub.c
index 7fbba36f7aac..b75b50ad6748 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1999,8 +1999,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 			   slab_nid(slab));
 	if (!vec) {
 		/* Mark vectors which failed to allocate */
-		if (new_slab)
-			mark_failed_objexts_alloc(slab);
+		mark_failed_objexts_alloc(slab);
 
 		return -ENOMEM;
 	}
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index f2efb58d152b..13d6c3f51c29 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1455,7 +1455,7 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
 	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
 		return;
 
-	vg = br_vlan_group(br);
+	vg = br_vlan_group_rcu(br);
 
 	if (idx >= 0 &&
 	    ctx->vlan[idx].proto == br->vlan_proto) {
diff --git a/net/core/filter.c b/net/core/filter.c
index c850e5d6cbd8..fef4d85fee00 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2289,6 +2289,7 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 		if (IS_ERR(dst))
 			goto out_drop;
 
+		skb_dst_drop(skb);
 		skb_dst_set(skb, dst);
 	} else if (nh->nh_family != AF_INET6) {
 		goto out_drop;
@@ -2397,6 +2398,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 			goto out_drop;
 		}
 
+		skb_dst_drop(skb);
 		skb_dst_set(skb, &rt->dst);
 	}
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index b1c3e0ad6dbf..6a7d740b396f 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -462,11 +462,60 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 	}
 }
 
+static int page_pool_register_dma_index(struct page_pool *pool,
+					netmem_ref netmem, gfp_t gfp)
+{
+	int err = 0;
+	u32 id;
+
+	if (unlikely(!PP_DMA_INDEX_BITS))
+		goto out;
+
+	if (in_softirq())
+		err = xa_alloc(&pool->dma_mapped, &id, netmem_to_page(netmem),
+			       PP_DMA_INDEX_LIMIT, gfp);
+	else
+		err = xa_alloc_bh(&pool->dma_mapped, &id, netmem_to_page(netmem),
+				  PP_DMA_INDEX_LIMIT, gfp);
+	if (err) {
+		WARN_ONCE(err != -ENOMEM, "couldn't track DMA mapping, please report to netdev@");
+		goto out;
+	}
+
+	netmem_set_dma_index(netmem, id);
+out:
+	return err;
+}
+
+static int page_pool_release_dma_index(struct page_pool *pool,
+				       netmem_ref netmem)
+{
+	struct page *old, *page = netmem_to_page(netmem);
+	unsigned long id;
+
+	if (unlikely(!PP_DMA_INDEX_BITS))
+		return 0;
+
+	id = netmem_get_dma_index(netmem);
+	if (!id)
+		return -1;
+
+	if (in_softirq())
+		old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
+	else
+		old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
+	if (old != page)
+		return -1;
+
+	netmem_set_dma_index(netmem, 0);
+
+	return 0;
+}
+
 static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t gfp)
 {
 	dma_addr_t dma;
 	int err;
-	u32 id;
 
 	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
 	 * since dma_addr_t can be either 32 or 64 bits and does not always fit
@@ -485,18 +534,10 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t g
 		goto unmap_failed;
 	}
 
-	if (in_softirq())
-		err = xa_alloc(&pool->dma_mapped, &id, netmem_to_page(netmem),
-			       PP_DMA_INDEX_LIMIT, gfp);
-	else
-		err = xa_alloc_bh(&pool->dma_mapped, &id, netmem_to_page(netmem),
-				  PP_DMA_INDEX_LIMIT, gfp);
-	if (err) {
-		WARN_ONCE(err != -ENOMEM, "couldn't track DMA mapping, please report to netdev@");
+	err = page_pool_register_dma_index(pool, netmem, gfp);
+	if (err)
 		goto unset_failed;
-	}
 
-	netmem_set_dma_index(netmem, id);
 	page_pool_dma_sync_for_device(pool, netmem, pool->p.max_len);
 
 	return true;
@@ -669,8 +710,6 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 							 netmem_ref netmem)
 {
-	struct page *old, *page = netmem_to_page(netmem);
-	unsigned long id;
 	dma_addr_t dma;
 
 	if (!pool->dma_map)
@@ -679,15 +718,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 		 */
 		return;
 
-	id = netmem_get_dma_index(netmem);
-	if (!id)
-		return;
-
-	if (in_softirq())
-		old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
-	else
-		old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
-	if (old != page)
+	if (page_pool_release_dma_index(pool, netmem))
 		return;
 
 	dma = page_pool_get_dma_addr_netmem(netmem);
@@ -697,7 +728,6 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 	page_pool_set_dma_addr_netmem(netmem, 0);
-	netmem_set_dma_index(netmem, 0);
 }
 
 /* Disconnects a page (from a page_pool).  API users can have a need
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 739931aabb4e..795ffa62cc0e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1735,6 +1735,7 @@ EXPORT_SYMBOL(tcp_peek_len);
 /* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
 int tcp_set_rcvlowat(struct sock *sk, int val)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
 	int space, cap;
 
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
@@ -1753,7 +1754,9 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	space = tcp_space_from_win(sk, val);
 	if (space > sk->sk_rcvbuf) {
 		WRITE_ONCE(sk->sk_rcvbuf, space);
-		WRITE_ONCE(tcp_sk(sk)->window_clamp, val);
+
+		if (tp->window_clamp && tp->window_clamp < val)
+			WRITE_ONCE(tp->window_clamp, val);
 	}
 	return 0;
 }
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 30f4375f8431..4c8d84fc27ca 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7338,7 +7338,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 				    &foc, TCP_SYNACK_FASTOPEN, skb);
 		/* Add the child socket directly into the accept queue */
 		if (!inet_csk_reqsk_queue_add(sk, req, fastopen_sk)) {
-			reqsk_fastopen_remove(fastopen_sk, req, false);
 			bh_unlock_sock(fastopen_sk);
 			sock_put(fastopen_sk);
 			goto drop_and_free;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 2c8815daf5b0..1b7541206a70 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -226,9 +226,12 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 		} else {
 			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 		}
-	/* id0 should not have a different address */
+	/* - id0 should not have a different address
+	 * - special case for C-flag: linked to fill_local_addresses_vec()
+	 */
 	} else if ((addr->id == 0 && !mptcp_pm_nl_is_init_remote_addr(msk, addr)) ||
-		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
+		   (addr->id > 0 && !READ_ONCE(pm->accept_addr) &&
+		    !mptcp_pm_add_addr_c_flag_case(msk))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 463c2e7956d5..8d5406515c30 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -674,10 +674,12 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
+	bool c_flag_case;
 	int i = 0;
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
+	c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
 
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 
@@ -690,12 +692,27 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			continue;
 
 		if (msk->pm.subflows < subflows_max) {
+			bool is_id0;
+
 			locals[i].addr = entry->addr;
 			locals[i].flags = entry->flags;
 			locals[i].ifindex = entry->ifindex;
 
+			is_id0 = mptcp_addresses_equal(&locals[i].addr,
+						       &mpc_addr,
+						       locals[i].addr.port);
+
+			if (c_flag_case &&
+			    (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
+				__clear_bit(locals[i].addr.id,
+					    msk->pm.id_avail_bitmap);
+
+				if (!is_id0)
+					msk->pm.local_addr_used++;
+			}
+
 			/* Special case for ID0: set the correct ID */
-			if (mptcp_addresses_equal(&locals[i].addr, &mpc_addr, locals[i].addr.port))
+			if (is_id0)
 				locals[i].addr.id = 0;
 
 			msk->pm.subflows++;
@@ -704,6 +721,37 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	}
 	rcu_read_unlock();
 
+	/* Special case: peer sets the C flag, accept one ADD_ADDR if default
+	 * limits are used -- accepting no ADD_ADDR -- and use subflow endpoints
+	 */
+	if (!i && c_flag_case) {
+		unsigned int local_addr_max = mptcp_pm_get_local_addr_max(msk);
+
+		while (msk->pm.local_addr_used < local_addr_max &&
+		       msk->pm.subflows < subflows_max) {
+			struct mptcp_pm_local *local = &locals[i];
+
+			if (!select_local_address(pernet, msk, local))
+				break;
+
+			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+
+			if (!mptcp_pm_addr_families_match(sk, &local->addr,
+							  remote))
+				continue;
+
+			if (mptcp_addresses_equal(&local->addr, &mpc_addr,
+						  local->addr.port))
+				continue;
+
+			msk->pm.local_addr_used++;
+			msk->pm.subflows++;
+			i++;
+		}
+
+		return i;
+	}
+
 	/* If the array is empty, fill in the single
 	 * 'IPADDRANY' local address
 	 */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6f191b125978..9653fee227ab 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1172,6 +1172,14 @@ static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 
+static inline bool mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
+	       msk->pm.local_addr_used == 0 &&
+	       mptcp_pm_get_add_addr_accept_max(msk) == 0 &&
+	       msk->pm.subflows < mptcp_pm_get_subflows_max(msk);
+}
+
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
 
 static inline struct mptcp_ext *mptcp_get_ext(const struct sk_buff *skb)
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index 8ee66a86c3bc..1a62e384766a 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -22,6 +22,35 @@ void nft_objref_eval(const struct nft_expr *expr,
 	obj->ops->eval(obj, regs, pkt);
 }
 
+static int nft_objref_validate_obj_type(const struct nft_ctx *ctx, u32 type)
+{
+	unsigned int hooks;
+
+	switch (type) {
+	case NFT_OBJECT_SYNPROXY:
+		if (ctx->family != NFPROTO_IPV4 &&
+		    ctx->family != NFPROTO_IPV6 &&
+		    ctx->family != NFPROTO_INET)
+			return -EOPNOTSUPP;
+
+		hooks = (1 << NF_INET_LOCAL_IN) | (1 << NF_INET_FORWARD);
+
+		return nft_chain_validate_hooks(ctx->chain, hooks);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int nft_objref_validate(const struct nft_ctx *ctx,
+			       const struct nft_expr *expr)
+{
+	struct nft_object *obj = nft_objref_priv(expr);
+
+	return nft_objref_validate_obj_type(ctx, obj->ops->type->type);
+}
+
 static int nft_objref_init(const struct nft_ctx *ctx,
 			   const struct nft_expr *expr,
 			   const struct nlattr * const tb[])
@@ -93,6 +122,7 @@ static const struct nft_expr_ops nft_objref_ops = {
 	.activate	= nft_objref_activate,
 	.deactivate	= nft_objref_deactivate,
 	.dump		= nft_objref_dump,
+	.validate	= nft_objref_validate,
 	.reduce		= NFT_REDUCE_READONLY,
 };
 
@@ -197,6 +227,14 @@ static void nft_objref_map_destroy(const struct nft_ctx *ctx,
 	nf_tables_destroy_set(ctx, priv->set);
 }
 
+static int nft_objref_map_validate(const struct nft_ctx *ctx,
+				   const struct nft_expr *expr)
+{
+	const struct nft_objref_map *priv = nft_expr_priv(expr);
+
+	return nft_objref_validate_obj_type(ctx, priv->set->objtype);
+}
+
 static const struct nft_expr_ops nft_objref_map_ops = {
 	.type		= &nft_objref_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_objref_map)),
@@ -206,6 +244,7 @@ static const struct nft_expr_ops nft_objref_map_ops = {
 	.deactivate	= nft_objref_map_deactivate,
 	.destroy	= nft_objref_map_destroy,
 	.dump		= nft_objref_map_dump,
+	.validate	= nft_objref_map_validate,
 	.reduce		= NFT_REDUCE_READONLY,
 };
 
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index f80208edd6a5..96ca400120e6 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -31,6 +31,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <crypto/hash.h>
+#include <crypto/utils.h>
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
index a0524ba8d787..dc66dff33d6d 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -30,6 +30,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <crypto/utils.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/ip.h>
@@ -885,7 +886,8 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 	return SCTP_DISPOSITION_CONSUME;
 
 nomem_authev:
-	sctp_ulpevent_free(ai_ev);
+	if (ai_ev)
+		sctp_ulpevent_free(ai_ev);
 nomem_aiev:
 	sctp_ulpevent_free(ev);
 nomem_ev:
@@ -4416,7 +4418,7 @@ static enum sctp_ierror sctp_sf_authenticate(
 				 sh_key, GFP_ATOMIC);
 
 	/* Discard the packet if the digests do not match */
-	if (memcmp(save_digest, digest, sig_len)) {
+	if (crypto_memneq(save_digest, digest, sig_len)) {
 		kfree(save_digest);
 		return SCTP_IERROR_BAD_SIG;
 	}
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 43c57124de52..67474470320c 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -606,7 +606,8 @@ int svc_port_is_privileged(struct sockaddr *sin)
 }
 
 /*
- * Make sure that we don't have too many active connections. If we have,
+ * Make sure that we don't have too many connections that have not yet
+ * demonstrated that they have access to the NFS server. If we have,
  * something must be dropped. It's not clear what will happen if we allow
  * "too many" connections, but when dealing with network-facing software,
  * we have to code defensively. Here we do that by imposing hard limits.
@@ -625,27 +626,25 @@ int svc_port_is_privileged(struct sockaddr *sin)
  */
 static void svc_check_conn_limits(struct svc_serv *serv)
 {
-	unsigned int limit = serv->sv_maxconn ? serv->sv_maxconn :
-				(serv->sv_nrthreads+3) * 20;
+	unsigned int limit = serv->sv_maxconn ? serv->sv_maxconn : 64;
 
 	if (serv->sv_tmpcnt > limit) {
-		struct svc_xprt *xprt = NULL;
+		struct svc_xprt *xprt = NULL, *xprti;
 		spin_lock_bh(&serv->sv_lock);
 		if (!list_empty(&serv->sv_tempsocks)) {
-			/* Try to help the admin */
-			net_notice_ratelimited("%s: too many open connections, consider increasing the %s\n",
-					       serv->sv_name, serv->sv_maxconn ?
-					       "max number of connections" :
-					       "number of threads");
 			/*
 			 * Always select the oldest connection. It's not fair,
-			 * but so is life
+			 * but nor is life.
 			 */
-			xprt = list_entry(serv->sv_tempsocks.prev,
-					  struct svc_xprt,
-					  xpt_list);
-			set_bit(XPT_CLOSE, &xprt->xpt_flags);
-			svc_xprt_get(xprt);
+			list_for_each_entry_reverse(xprti, &serv->sv_tempsocks,
+						    xpt_list) {
+				if (!test_bit(XPT_PEER_VALID, &xprti->xpt_flags)) {
+					xprt = xprti;
+					set_bit(XPT_CLOSE, &xprt->xpt_flags);
+					svc_xprt_get(xprt);
+					break;
+				}
+			}
 		}
 		spin_unlock_bh(&serv->sv_lock);
 
@@ -1029,6 +1028,19 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
 	struct svc_serv	*serv = xprt->xpt_server;
 	struct svc_deferred_req *dr;
 
+	/* unregister with rpcbind for when transport type is TCP or UDP.
+	 */
+	if (test_bit(XPT_RPCB_UNREG, &xprt->xpt_flags)) {
+		struct svc_sock *svsk = container_of(xprt, struct svc_sock,
+						     sk_xprt);
+		struct socket *sock = svsk->sk_sock;
+
+		if (svc_register(serv, xprt->xpt_net, sock->sk->sk_family,
+				 sock->sk->sk_protocol, 0) < 0)
+			pr_warn("failed to unregister %s with rpcbind\n",
+				xprt->xpt_class->xcl_name);
+	}
+
 	if (test_and_set_bit(XPT_DEAD, &xprt->xpt_flags))
 		return;
 
@@ -1039,7 +1051,8 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
 
 	spin_lock_bh(&serv->sv_lock);
 	list_del_init(&xprt->xpt_list);
-	if (test_bit(XPT_TEMP, &xprt->xpt_flags))
+	if (test_bit(XPT_TEMP, &xprt->xpt_flags) &&
+	    !test_bit(XPT_PEER_VALID, &xprt->xpt_flags))
 		serv->sv_tmpcnt--;
 	spin_unlock_bh(&serv->sv_lock);
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e61e94576058..443d8390ebf1 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -837,6 +837,7 @@ static void svc_udp_init(struct svc_sock *svsk, struct svc_serv *serv)
 	/* data might have come in before data_ready set up */
 	set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 	set_bit(XPT_CHNGBUF, &svsk->sk_xprt.xpt_flags);
+	set_bit(XPT_RPCB_UNREG, &svsk->sk_xprt.xpt_flags);
 
 	/* make sure we get destination address info */
 	switch (svsk->sk_sk->sk_family) {
@@ -1357,6 +1358,7 @@ static void svc_tcp_init(struct svc_sock *svsk, struct svc_serv *serv)
 	if (sk->sk_state == TCP_LISTEN) {
 		strcpy(svsk->sk_xprt.xpt_remotebuf, "listener");
 		set_bit(XPT_LISTENER, &svsk->sk_xprt.xpt_flags);
+		set_bit(XPT_RPCB_UNREG, &svsk->sk_xprt.xpt_flags);
 		sk->sk_data_ready = svc_tcp_listen_data_ready;
 		set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
 	} else {
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 406b20dfee8d..9351e1298ef4 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -143,14 +143,24 @@ static inline bool xp_unused_options_set(u32 options)
 static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 					    struct xdp_desc *desc)
 {
-	u64 addr = desc->addr - pool->tx_metadata_len;
-	u64 len = desc->len + pool->tx_metadata_len;
-	u64 offset = addr & (pool->chunk_size - 1);
+	u64 len = desc->len;
+	u64 addr, offset;
 
-	if (!desc->len)
+	if (!len)
 		return false;
 
-	if (offset + len > pool->chunk_size)
+	/* Can overflow if desc->addr < pool->tx_metadata_len */
+	if (check_sub_overflow(desc->addr, pool->tx_metadata_len, &addr))
+		return false;
+
+	offset = addr & (pool->chunk_size - 1);
+
+	/*
+	 * Can't overflow: @offset is guaranteed to be < ``U32_MAX``
+	 * (pool->chunk_size is ``u32``), @len is guaranteed
+	 * to be <= ``U32_MAX``.
+	 */
+	if (offset + len + pool->tx_metadata_len > pool->chunk_size)
 		return false;
 
 	if (addr >= pool->addrs_cnt)
@@ -158,27 +168,42 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 
 	if (xp_unused_options_set(desc->options))
 		return false;
+
 	return true;
 }
 
 static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
 					      struct xdp_desc *desc)
 {
-	u64 addr = xp_unaligned_add_offset_to_addr(desc->addr) - pool->tx_metadata_len;
-	u64 len = desc->len + pool->tx_metadata_len;
+	u64 len = desc->len;
+	u64 addr, end;
 
-	if (!desc->len)
+	if (!len)
 		return false;
 
+	/* Can't overflow: @len is guaranteed to be <= ``U32_MAX`` */
+	len += pool->tx_metadata_len;
 	if (len > pool->chunk_size)
 		return false;
 
-	if (addr >= pool->addrs_cnt || addr + len > pool->addrs_cnt ||
-	    xp_desc_crosses_non_contig_pg(pool, addr, len))
+	/* Can overflow if desc->addr is close to 0 */
+	if (check_sub_overflow(xp_unaligned_add_offset_to_addr(desc->addr),
+			       pool->tx_metadata_len, &addr))
+		return false;
+
+	if (addr >= pool->addrs_cnt)
+		return false;
+
+	/* Can overflow if pool->addrs_cnt is high enough */
+	if (check_add_overflow(addr, len, &end) || end > pool->addrs_cnt)
+		return false;
+
+	if (xp_desc_crosses_non_contig_pg(pool, addr, len))
 		return false;
 
 	if (xp_unused_options_set(desc->options))
 		return false;
+
 	return true;
 }
 
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 89c9798d1800..e73f2c6c817a 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -7,6 +7,7 @@
  */
 
 #include <crypto/hash_info.h>
+#include <crypto/utils.h>
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
diff --git a/sound/soc/sof/intel/hda-pcm.c b/sound/soc/sof/intel/hda-pcm.c
index f6e24edd7adb..898e4fcde2dd 100644
--- a/sound/soc/sof/intel/hda-pcm.c
+++ b/sound/soc/sof/intel/hda-pcm.c
@@ -29,6 +29,8 @@
 #define SDnFMT_BITS(x)	((x) << 4)
 #define SDnFMT_CHAN(x)	((x) << 0)
 
+#define HDA_MAX_PERIOD_TIME_HEADROOM	10
+
 static bool hda_always_enable_dmi_l1;
 module_param_named(always_enable_dmi_l1, hda_always_enable_dmi_l1, bool, 0444);
 MODULE_PARM_DESC(always_enable_dmi_l1, "SOF HDA always enable DMI l1");
@@ -276,19 +278,30 @@ int hda_dsp_pcm_open(struct snd_sof_dev *sdev,
 	 * On playback start the DMA will transfer dsp_max_burst_size_in_ms
 	 * amount of data in one initial burst to fill up the host DMA buffer.
 	 * Consequent DMA burst sizes are shorter and their length can vary.
-	 * To make sure that userspace allocate large enough ALSA buffer we need
-	 * to place a constraint on the buffer time.
+	 * To avoid immediate xrun by the initial burst we need to place
+	 * constraint on the period size (via PERIOD_TIME) to cover the size of
+	 * the host buffer.
+	 * We need to add headroom of max 10ms as the firmware needs time to
+	 * settle to the 1ms pacing and initially it can run faster for few
+	 * internal periods.
 	 *
 	 * On capture the DMA will transfer 1ms chunks.
-	 *
-	 * Exact dsp_max_burst_size_in_ms constraint is racy, so set the
-	 * constraint to a minimum of 2x dsp_max_burst_size_in_ms.
 	 */
-	if (spcm->stream[direction].dsp_max_burst_size_in_ms)
+	if (spcm->stream[direction].dsp_max_burst_size_in_ms) {
+		unsigned int period_time = spcm->stream[direction].dsp_max_burst_size_in_ms;
+
+		/*
+		 * add headroom over the maximum burst size to cover the time
+		 * needed for the DMA pace to settle.
+		 * Limit the headroom time to HDA_MAX_PERIOD_TIME_HEADROOM
+		 */
+		period_time += min(period_time, HDA_MAX_PERIOD_TIME_HEADROOM);
+
 		snd_pcm_hw_constraint_minmax(substream->runtime,
-			SNDRV_PCM_HW_PARAM_BUFFER_TIME,
-			spcm->stream[direction].dsp_max_burst_size_in_ms * USEC_PER_MSEC * 2,
+			SNDRV_PCM_HW_PARAM_PERIOD_TIME,
+			period_time * USEC_PER_MSEC,
 			UINT_MAX);
+	}
 
 	/* binding pcm substream to hda stream */
 	substream->runtime->private_data = &dsp_stream->hstream;
diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 24f3cc767614..2be0d02f9cf9 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -1103,10 +1103,35 @@ u64 hda_dsp_get_stream_llp(struct snd_sof_dev *sdev,
 			   struct snd_soc_component *component,
 			   struct snd_pcm_substream *substream)
 {
-	struct hdac_stream *hstream = substream->runtime->private_data;
-	struct hdac_ext_stream *hext_stream = stream_to_hdac_ext_stream(hstream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_pcm_runtime *be_rtd = NULL;
+	struct hdac_ext_stream *hext_stream;
+	struct snd_soc_dai *cpu_dai;
+	struct snd_soc_dpcm *dpcm;
 	u32 llp_l, llp_u;
 
+	/*
+	 * The LLP needs to be read from the Link DMA used for this FE as it is
+	 * allowed to use any combination of Link and Host channels
+	 */
+	for_each_dpcm_be(rtd, substream->stream, dpcm) {
+		if (dpcm->fe != rtd)
+			continue;
+
+		be_rtd = dpcm->be;
+	}
+
+	if (!be_rtd)
+		return 0;
+
+	cpu_dai = snd_soc_rtd_to_cpu(be_rtd, 0);
+	if (!cpu_dai)
+		return 0;
+
+	hext_stream = snd_soc_dai_get_dma_data(cpu_dai, substream);
+	if (!hext_stream)
+		return 0;
+
 	/*
 	 * The pplc_addr have been calculated during probe in
 	 * hda_dsp_stream_init():
diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 9db2cdb32128..b11279f9d3c9 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -19,12 +19,14 @@
  * struct sof_ipc4_timestamp_info - IPC4 timestamp info
  * @host_copier: the host copier of the pcm stream
  * @dai_copier: the dai copier of the pcm stream
- * @stream_start_offset: reported by fw in memory window (converted to frames)
- * @stream_end_offset: reported by fw in memory window (converted to frames)
+ * @stream_start_offset: reported by fw in memory window (converted to
+ *                       frames at host_copier sampling rate)
+ * @stream_end_offset: reported by fw in memory window (converted to
+ *                     frames at host_copier sampling rate)
  * @llp_offset: llp offset in memory window
- * @boundary: wrap boundary should be used for the LLP frame counter
  * @delay: Calculated and stored in pointer callback. The stored value is
- *	   returned in the delay callback.
+ *         returned in the delay callback. Expressed in frames at host copier
+ *         sampling rate.
  */
 struct sof_ipc4_timestamp_info {
 	struct sof_ipc4_copier *host_copier;
@@ -33,7 +35,6 @@ struct sof_ipc4_timestamp_info {
 	u64 stream_end_offset;
 	u32 llp_offset;
 
-	u64 boundary;
 	snd_pcm_sframes_t delay;
 };
 
@@ -48,6 +49,16 @@ struct sof_ipc4_pcm_stream_priv {
 	bool chain_dma_allocated;
 };
 
+/*
+ * Modulus to use to compare host and link position counters. The sampling
+ * rates may be different, so the raw hardware counters will wrap
+ * around at different times. To calculate differences, use
+ * DELAY_BOUNDARY as a common modulus. This value must be smaller than
+ * the wrap-around point of any hardware counter, and larger than any
+ * valid delay measurement.
+ */
+#define DELAY_BOUNDARY		U32_MAX
+
 static inline struct sof_ipc4_timestamp_info *
 sof_ipc4_sps_to_time_info(struct snd_sof_pcm_stream *sps)
 {
@@ -409,9 +420,33 @@ static int sof_ipc4_trigger_pipelines(struct snd_soc_component *component,
 	 * If use_chain_dma attribute is set we proceed to chained DMA
 	 * trigger function that handles the rest for the substream.
 	 */
-	if (pipeline->use_chain_dma)
-		return sof_ipc4_chain_dma_trigger(sdev, spcm, substream->stream,
-						  pipeline_list, state, cmd);
+	if (pipeline->use_chain_dma) {
+		struct sof_ipc4_timestamp_info *time_info;
+
+		time_info = sof_ipc4_sps_to_time_info(&spcm->stream[substream->stream]);
+
+		ret = sof_ipc4_chain_dma_trigger(sdev, spcm, substream->stream,
+						 pipeline_list, state, cmd);
+		if (ret || !time_info)
+			return ret;
+
+		if (state == SOF_IPC4_PIPE_PAUSED) {
+			/*
+			 * Record the DAI position for delay reporting
+			 * To handle multiple pause/resume/xrun we need to add
+			 * the positions to simulate how the firmware behaves
+			 */
+			u64 pos = snd_sof_pcm_get_dai_frame_counter(sdev, component,
+								    substream);
+
+			time_info->stream_end_offset += pos;
+		} else if (state == SOF_IPC4_PIPE_RESET) {
+			/* Reset the end offset as the stream is stopped */
+			time_info->stream_end_offset = 0;
+		}
+
+		return 0;
+	}
 
 	/* allocate memory for the pipeline data */
 	trigger_list = kzalloc(struct_size(trigger_list, pipeline_instance_ids,
@@ -909,6 +944,35 @@ static int sof_ipc4_pcm_hw_params(struct snd_soc_component *component,
 	return 0;
 }
 
+static u64 sof_ipc4_frames_dai_to_host(struct sof_ipc4_timestamp_info *time_info, u64 value)
+{
+	u64 dai_rate, host_rate;
+
+	if (!time_info->dai_copier || !time_info->host_copier)
+		return value;
+
+	/*
+	 * copiers do not change sampling rate, so we can use the
+	 * out_format independently of stream direction
+	 */
+	dai_rate = time_info->dai_copier->data.out_format.sampling_frequency;
+	host_rate = time_info->host_copier->data.out_format.sampling_frequency;
+
+	if (!dai_rate || !host_rate || dai_rate == host_rate)
+		return value;
+
+	/* take care not to overflow u64, rates can be up to 768000 */
+	if (value > U32_MAX) {
+		value = div64_u64(value, dai_rate);
+		value *= host_rate;
+	} else {
+		value *= host_rate;
+		value = div64_u64(value, dai_rate);
+	}
+
+	return value;
+}
+
 static int sof_ipc4_get_stream_start_offset(struct snd_sof_dev *sdev,
 					    struct snd_pcm_substream *substream,
 					    struct snd_sof_pcm_stream *sps,
@@ -924,8 +988,30 @@ static int sof_ipc4_get_stream_start_offset(struct snd_sof_dev *sdev,
 	if (!host_copier || !dai_copier)
 		return -EINVAL;
 
-	if (host_copier->data.gtw_cfg.node_id == SOF_IPC4_INVALID_NODE_ID)
+	if (host_copier->data.gtw_cfg.node_id == SOF_IPC4_INVALID_NODE_ID) {
 		return -EINVAL;
+	} else if (host_copier->data.gtw_cfg.node_id == SOF_IPC4_CHAIN_DMA_NODE_ID) {
+		/*
+		 * While the firmware does not support time_info reporting for
+		 * streams using ChainDMA, it is granted that ChainDMA can only
+		 * be used on Host+Link pairs where the link position is
+		 * accessible from the host side.
+		 *
+		 * Enable delay calculation in case of ChainDMA via host
+		 * accessible registers.
+		 *
+		 * The ChainDMA prefills the link DMA with a preamble
+		 * of zero samples. Set the stream start offset based
+		 * on size of the preamble (driver provided fifo size
+		 * multiplied by 2.5). We add 1ms of margin as the FW
+		 * will align the buffer size to DMA hardware
+		 * alignment that is not known to host.
+		 */
+		int pre_ms = SOF_IPC4_CHAIN_DMA_BUF_SIZE_MS * 5 / 2 + 1;
+
+		time_info->stream_start_offset = pre_ms * substream->runtime->rate / MSEC_PER_SEC;
+		goto out;
+	}
 
 	node_index = SOF_IPC4_NODE_INDEX(host_copier->data.gtw_cfg.node_id);
 	offset = offsetof(struct sof_ipc4_fw_registers, pipeline_regs) + node_index * sizeof(ppl_reg);
@@ -943,13 +1029,13 @@ static int sof_ipc4_get_stream_start_offset(struct snd_sof_dev *sdev,
 	time_info->stream_end_offset = ppl_reg.stream_end_offset;
 	do_div(time_info->stream_end_offset, dai_sample_size);
 
-	/*
-	 * Calculate the wrap boundary need to be used for delay calculation
-	 * The host counter is in bytes, it will wrap earlier than the frames
-	 * based link counter.
-	 */
-	time_info->boundary = div64_u64(~((u64)0),
-					frames_to_bytes(substream->runtime, 1));
+	/* convert to host frame time */
+	time_info->stream_start_offset =
+		sof_ipc4_frames_dai_to_host(time_info, time_info->stream_start_offset);
+	time_info->stream_end_offset =
+		sof_ipc4_frames_dai_to_host(time_info, time_info->stream_end_offset);
+
+out:
 	/* Initialize the delay value to 0 (no delay) */
 	time_info->delay = 0;
 
@@ -992,6 +1078,8 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 
 	/* For delay calculation we need the host counter */
 	host_cnt = snd_sof_pcm_get_host_byte_counter(sdev, component, substream);
+
+	/* Store the original value to host_ptr */
 	host_ptr = host_cnt;
 
 	/* convert the host_cnt to frames */
@@ -1010,6 +1098,8 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 		sof_mailbox_read(sdev, time_info->llp_offset, &llp, sizeof(llp));
 		dai_cnt = ((u64)llp.reading.llp_u << 32) | llp.reading.llp_l;
 	}
+
+	dai_cnt = sof_ipc4_frames_dai_to_host(time_info, dai_cnt);
 	dai_cnt += time_info->stream_end_offset;
 
 	/* In two cases dai dma counter is not accurate
@@ -1043,8 +1133,9 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 		dai_cnt -= time_info->stream_start_offset;
 	}
 
-	/* Wrap the dai counter at the boundary where the host counter wraps */
-	div64_u64_rem(dai_cnt, time_info->boundary, &dai_cnt);
+	/* Convert to a common base before comparisons */
+	dai_cnt &= DELAY_BOUNDARY;
+	host_cnt &= DELAY_BOUNDARY;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		head_cnt = host_cnt;
@@ -1054,14 +1145,11 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 		tail_cnt = host_cnt;
 	}
 
-	if (head_cnt < tail_cnt) {
-		time_info->delay = time_info->boundary - tail_cnt + head_cnt;
-		goto out;
-	}
-
-	time_info->delay =  head_cnt - tail_cnt;
+	if (unlikely(head_cnt < tail_cnt))
+		time_info->delay = DELAY_BOUNDARY - tail_cnt + head_cnt;
+	else
+		time_info->delay = head_cnt - tail_cnt;
 
-out:
 	/*
 	 * Convert the host byte counter to PCM pointer which wraps in buffer
 	 * and it is in frames
diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index f82db7f2a6b7..4849a3ce02dc 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -32,7 +32,6 @@ MODULE_PARM_DESC(ipc4_ignore_cpc,
 
 #define SOF_IPC4_GAIN_PARAM_ID  0
 #define SOF_IPC4_TPLG_ABI_SIZE 6
-#define SOF_IPC4_CHAIN_DMA_BUF_SIZE_MS 2
 
 static DEFINE_IDA(alh_group_ida);
 static DEFINE_IDA(pipeline_ida);
@@ -519,8 +518,13 @@ static int sof_ipc4_widget_setup_pcm(struct snd_sof_widget *swidget)
 				      swidget->tuples,
 				      swidget->num_tuples, sizeof(u32), 1);
 		/* Set default DMA buffer size if it is not specified in topology */
-		if (!sps->dsp_max_burst_size_in_ms)
-			sps->dsp_max_burst_size_in_ms = SOF_IPC4_MIN_DMA_BUFFER_SIZE;
+		if (!sps->dsp_max_burst_size_in_ms) {
+			struct snd_sof_widget *pipe_widget = swidget->spipe->pipe_widget;
+			struct sof_ipc4_pipeline *pipeline = pipe_widget->private;
+
+			sps->dsp_max_burst_size_in_ms = pipeline->use_chain_dma ?
+				SOF_IPC4_CHAIN_DMA_BUFFER_SIZE : SOF_IPC4_MIN_DMA_BUFFER_SIZE;
+		}
 	} else {
 		/* Capture data is copied from DSP to host in 1ms bursts */
 		spcm->stream[dir].dsp_max_burst_size_in_ms = 1;
@@ -1777,10 +1781,10 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 			pipeline->msg.extension |= SOF_IPC4_GLB_EXT_CHAIN_DMA_FIFO_SIZE(fifo_size);
 
 			/*
-			 * Chain DMA does not support stream timestamping, set node_id to invalid
-			 * to skip the code in sof_ipc4_get_stream_start_offset().
+			 * Chain DMA does not support stream timestamping, but it
+			 * can use the host side registers for delay calculation.
 			 */
-			copier_data->gtw_cfg.node_id = SOF_IPC4_INVALID_NODE_ID;
+			copier_data->gtw_cfg.node_id = SOF_IPC4_CHAIN_DMA_NODE_ID;
 
 			return 0;
 		}
diff --git a/sound/soc/sof/ipc4-topology.h b/sound/soc/sof/ipc4-topology.h
index f4dc499c0ffe..da9592430b15 100644
--- a/sound/soc/sof/ipc4-topology.h
+++ b/sound/soc/sof/ipc4-topology.h
@@ -58,10 +58,14 @@
 
 #define SOF_IPC4_DMA_DEVICE_MAX_COUNT 16
 
+#define SOF_IPC4_CHAIN_DMA_NODE_ID	0x7fffffff
 #define SOF_IPC4_INVALID_NODE_ID	0xffffffff
 
-/* FW requires minimum 2ms DMA buffer size */
-#define SOF_IPC4_MIN_DMA_BUFFER_SIZE	2
+/* FW requires minimum 4ms DMA buffer size */
+#define SOF_IPC4_MIN_DMA_BUFFER_SIZE	4
+
+/* ChainDMA in fw uses 5ms DMA buffer */
+#define SOF_IPC4_CHAIN_DMA_BUFFER_SIZE	5
 
 /*
  * The base of multi-gateways. Multi-gateways addressing starts from
@@ -246,6 +250,8 @@ struct sof_ipc4_dma_stream_ch_map {
 #define SOF_IPC4_DMA_METHOD_HDA   1
 #define SOF_IPC4_DMA_METHOD_GPDMA 2 /* defined for consistency but not used */
 
+#define SOF_IPC4_CHAIN_DMA_BUF_SIZE_MS 2
+
 /**
  * struct sof_ipc4_dma_config: DMA configuration
  * @dma_method: HDAudio or GPDMA
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 1658596188bf..592ca17b4b74 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -327,10 +327,10 @@ $(OUTPUT)test-libcapstone.bin:
 	$(BUILD) # -lcapstone provided by $(FEATURE_CHECK_LDFLAGS-libcapstone)
 
 $(OUTPUT)test-compile-32.bin:
-	$(CC) -m32 -o $@ test-compile.c
+	$(CC) -m32 -Wall -Werror -o $@ test-compile.c
 
 $(OUTPUT)test-compile-x32.bin:
-	$(CC) -mx32 -o $@ test-compile.c
+	$(CC) -mx32 -Wall -Werror -o $@ test-compile.c
 
 $(OUTPUT)test-zlib.bin:
 	$(BUILD) -lz
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 37bb7771d914..32b75c0326c9 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -291,6 +291,7 @@ struct perf_record_header_event_type {
 struct perf_record_header_tracing_data {
 	struct perf_event_header header;
 	__u32			 size;
+	__u32			 pad;
 };
 
 #define PERF_RECORD_MISC_BUILD_ID_SIZE (1 << 15)
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 628c61397d2d..b578930ed76a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -639,8 +639,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 	 * (behavior changed with commit b0a873e).
 	 */
 	if (errno == EINVAL || errno == ENOSYS ||
-	    errno == ENOENT || errno == EOPNOTSUPP ||
-	    errno == ENXIO) {
+	    errno == ENOENT || errno == ENXIO) {
 		if (verbose > 0)
 			ui__warning("%s event is not supported by the kernel.\n",
 				    evsel__name(counter));
@@ -658,7 +657,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 		if (verbose > 0)
 			ui__warning("%s\n", msg);
 		return COUNTER_RETRY;
-	} else if (target__has_per_thread(&target) &&
+	} else if (target__has_per_thread(&target) && errno != EOPNOTSUPP &&
 		   evsel_list->core.threads &&
 		   evsel_list->core.threads->err_thread != -1) {
 		/*
@@ -679,6 +678,19 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 		return COUNTER_SKIP;
 	}
 
+	if (errno == EOPNOTSUPP) {
+		if (verbose > 0) {
+			ui__warning("%s event is not supported by the kernel.\n",
+				    evsel__name(counter));
+		}
+		counter->supported = false;
+		counter->errored = true;
+
+		if ((evsel__leader(counter) != counter) ||
+		    !(counter->core.leader->nr_members > 1))
+			return COUNTER_SKIP;
+	}
+
 	evsel__open_strerror(counter, &target, errno, msg, sizeof(msg));
 	ui__error("%s\n", msg);
 
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
index 5228f94a793f..6817cac149e0 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
@@ -113,7 +113,7 @@
     {
         "MetricName": "load_store_spec_rate",
         "MetricExpr": "LDST_SPEC / INST_SPEC",
-        "BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speclatively executed",
+        "BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speculatively executed",
         "MetricGroup": "Operation_Mix",
         "ScaleUnit": "100percent of operations"
     },
@@ -132,7 +132,7 @@
     {
         "MetricName": "pc_write_spec_rate",
         "MetricExpr": "PC_WRITE_SPEC / INST_SPEC",
-        "BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speclatively executed",
+        "BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speculatively executed",
         "MetricGroup": "Operation_Mix",
         "ScaleUnit": "100percent of operations"
     },
@@ -195,14 +195,14 @@
     {
         "MetricName": "stall_frontend_cache_rate",
         "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
-        "BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and cache miss",
+        "BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and cache miss",
         "MetricGroup": "Stall",
         "ScaleUnit": "100percent of cycles"
     },
     {
         "MetricName": "stall_frontend_tlb_rate",
         "MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
-        "BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and TLB miss",
+        "BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and TLB miss",
         "MetricGroup": "Stall",
         "ScaleUnit": "100percent of cycles"
     },
@@ -391,7 +391,7 @@
         "ScaleUnit": "100percent of cache acceses"
     },
     {
-        "MetricName": "l1d_cache_access_prefetces",
+        "MetricName": "l1d_cache_access_prefetches",
         "MetricExpr": "L1D_CACHE_PRFM / L1D_CACHE",
         "BriefDescription": "L1D cache access - prefetch",
         "MetricGroup": "Cache",
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 1c4feec1adff..6e7f053006b4 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -115,6 +115,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (err < 0) {
 		pr_debug("sched__get_first_possible_cpu: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -126,6 +127,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, &cpu_mask) < 0) {
 		pr_debug("sched_setaffinity: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -137,6 +139,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (err < 0) {
 		pr_debug("perf_evlist__open: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -149,6 +152,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (err < 0) {
 		pr_debug("evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
index 32314641217e..5984ca9b78f8 100755
--- a/tools/perf/tests/shell/record_lbr.sh
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -4,7 +4,12 @@
 
 set -e
 
-if [ ! -f /sys/devices/cpu/caps/branches ] && [ ! -f /sys/devices/cpu_core/caps/branches ]
+ParanoidAndNotRoot() {
+  [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
+}
+
+if [ ! -f /sys/bus/event_source/devices/cpu/caps/branches ] &&
+   [ ! -f /sys/bus/event_source/devices/cpu_core/caps/branches ]
 then
   echo "Skip: only x86 CPUs support LBR"
   exit 2
@@ -22,6 +27,7 @@ cleanup() {
 }
 
 trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
   cleanup
   exit 1
 }
@@ -122,8 +128,11 @@ lbr_test "-j ind_call" "any indirect call" 2
 lbr_test "-j ind_jmp" "any indirect jump" 100
 lbr_test "-j call" "direct calls" 2
 lbr_test "-j ind_call,u" "any indirect user call" 100
-lbr_test "-a -b" "system wide any branch" 2
-lbr_test "-a -j any_call" "system wide any call" 2
+if ! ParanoidAndNotRoot 1
+then
+  lbr_test "-a -b" "system wide any branch" 2
+  lbr_test "-a -j any_call" "system wide any call" 2
+fi
 
 # Parallel
 parallel_lbr_test "-b" "parallel any branch" 100 &
@@ -140,10 +149,16 @@ parallel_lbr_test "-j call" "parallel direct calls" 100 &
 pid6=$!
 parallel_lbr_test "-j ind_call,u" "parallel any indirect user call" 100 &
 pid7=$!
-parallel_lbr_test "-a -b" "parallel system wide any branch" 100 &
-pid8=$!
-parallel_lbr_test "-a -j any_call" "parallel system wide any call" 100 &
-pid9=$!
+if ParanoidAndNotRoot 1
+then
+  pid8=
+  pid9=
+else
+  parallel_lbr_test "-a -b" "parallel system wide any branch" 100 &
+  pid8=$!
+  parallel_lbr_test "-a -j any_call" "parallel system wide any call" 100 &
+  pid9=$!
+fi
 
 for pid in $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9
 do
diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 3f1e67795490..62f13dfeae8e 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -146,6 +146,34 @@ test_cputype() {
   echo "cputype test [Success]"
 }
 
+test_hybrid() {
+  # Test the default stat command on hybrid devices opens one cycles event for
+  # each CPU type.
+  echo "hybrid test"
+
+  # Count the number of core PMUs, assume minimum of 1
+  pmus=$(ls /sys/bus/event_source/devices/*/cpus 2>/dev/null | wc -l)
+  if [ "$pmus" -lt 1 ]
+  then
+    pmus=1
+  fi
+
+  # Run default Perf stat
+  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/[uH]*|  cycles[:uH]*  " -c)
+
+  # The expectation is that default output will have a cycles events on each
+  # hybrid PMU. In situations with no cycles PMU events, like virtualized, this
+  # can fall back to task-clock and so the end count may be 0. Fail if neither
+  # condition holds.
+  if [ "$pmus" -ne "$cycles_events" ] && [ "0" -ne "$cycles_events" ]
+  then
+    echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
+    err=1
+    return
+  fi
+  echo "hybrid test [Success]"
+}
+
 test_default_stat
 test_stat_record_report
 test_stat_record_script
@@ -153,4 +181,5 @@ test_stat_repeat_weak_groups
 test_topdown_groups
 test_topdown_weak_groups
 test_cputype
+test_hybrid
 exit $err
diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index 8d1e6bbeac90..1447d7425f38 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -23,6 +23,14 @@ check_vmlinux() {
   fi
 }
 
+check_permissions() {
+  if perf trace -e $syscall $TESTPROG 2>&1 | grep -q "Operation not permitted"
+  then
+    echo "trace+enum test [Skipped permissions]"
+    err=2
+  fi
+}
+
 trace_landlock() {
   echo "Tracing syscall ${syscall}"
 
@@ -54,6 +62,9 @@ trace_non_syscall() {
 }
 
 check_vmlinux
+if [ $err = 0 ]; then
+  check_permissions
+fi
 
 if [ $err = 0 ]; then
   trace_landlock
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 1443c28545a9..358c611eeddb 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -56,15 +56,15 @@ enum arm_spe_op_type {
 	ARM_SPE_OP_BR_INDIRECT	= 1 << 17,
 };
 
-enum arm_spe_neoverse_data_source {
-	ARM_SPE_NV_L1D		 = 0x0,
-	ARM_SPE_NV_L2		 = 0x8,
-	ARM_SPE_NV_PEER_CORE	 = 0x9,
-	ARM_SPE_NV_LOCAL_CLUSTER = 0xa,
-	ARM_SPE_NV_SYS_CACHE	 = 0xb,
-	ARM_SPE_NV_PEER_CLUSTER	 = 0xc,
-	ARM_SPE_NV_REMOTE	 = 0xd,
-	ARM_SPE_NV_DRAM		 = 0xe,
+enum arm_spe_common_data_source {
+	ARM_SPE_COMMON_DS_L1D		= 0x0,
+	ARM_SPE_COMMON_DS_L2		= 0x8,
+	ARM_SPE_COMMON_DS_PEER_CORE	= 0x9,
+	ARM_SPE_COMMON_DS_LOCAL_CLUSTER = 0xa,
+	ARM_SPE_COMMON_DS_SYS_CACHE	= 0xb,
+	ARM_SPE_COMMON_DS_PEER_CLUSTER	= 0xc,
+	ARM_SPE_COMMON_DS_REMOTE	= 0xd,
+	ARM_SPE_COMMON_DS_DRAM		= 0xe,
 };
 
 struct arm_spe_record {
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 2c06f2a85400..9890b17241c3 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -411,15 +411,15 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
 
-static const struct midr_range neoverse_spe[] = {
+static const struct midr_range common_ds_encoding_cpus[] = {
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	{},
 };
 
-static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
-						union perf_mem_data_src *data_src)
+static void arm_spe__synth_data_source_common(const struct arm_spe_record *record,
+					      union perf_mem_data_src *data_src)
 {
 	/*
 	 * Even though four levels of cache hierarchy are possible, no known
@@ -441,17 +441,17 @@ static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *rec
 	}
 
 	switch (record->source) {
-	case ARM_SPE_NV_L1D:
+	case ARM_SPE_COMMON_DS_L1D:
 		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
 		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
 		break;
-	case ARM_SPE_NV_L2:
+	case ARM_SPE_COMMON_DS_L2:
 		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
 		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
 		break;
-	case ARM_SPE_NV_PEER_CORE:
+	case ARM_SPE_COMMON_DS_PEER_CORE:
 		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
 		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
@@ -460,8 +460,8 @@ static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *rec
 	 * We don't know if this is L1, L2 but we do know it was a cache-2-cache
 	 * transfer, so set SNOOPX_PEER
 	 */
-	case ARM_SPE_NV_LOCAL_CLUSTER:
-	case ARM_SPE_NV_PEER_CLUSTER:
+	case ARM_SPE_COMMON_DS_LOCAL_CLUSTER:
+	case ARM_SPE_COMMON_DS_PEER_CLUSTER:
 		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
 		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
@@ -469,7 +469,7 @@ static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *rec
 	/*
 	 * System cache is assumed to be L3
 	 */
-	case ARM_SPE_NV_SYS_CACHE:
+	case ARM_SPE_COMMON_DS_SYS_CACHE:
 		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
 		data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
@@ -478,13 +478,13 @@ static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *rec
 	 * We don't know what level it hit in, except it came from the other
 	 * socket
 	 */
-	case ARM_SPE_NV_REMOTE:
-		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1;
-		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
+	case ARM_SPE_COMMON_DS_REMOTE:
+		data_src->mem_lvl = PERF_MEM_LVL_NA;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
 		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
 		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
 		break;
-	case ARM_SPE_NV_DRAM:
+	case ARM_SPE_COMMON_DS_DRAM:
 		data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
 		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
@@ -514,13 +514,13 @@ static void arm_spe__synth_data_source_generic(const struct arm_spe_record *reco
 	}
 
 	if (record->type & ARM_SPE_REMOTE_ACCESS)
-		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
+		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
 }
 
 static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
 {
 	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
-	bool is_neoverse = is_midr_in_range_list(midr, neoverse_spe);
+	bool is_common = is_midr_in_range_list(midr, common_ds_encoding_cpus);
 
 	/* Only synthesize data source for LDST operations */
 	if (!is_ldst_op(record->op))
@@ -533,8 +533,8 @@ static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 m
 	else
 		return 0;
 
-	if (is_neoverse)
-		arm_spe__synth_data_source_neoverse(record, &data_src);
+	if (is_common)
+		arm_spe__synth_data_source_common(record, &data_src);
 	else
 		arm_spe__synth_data_source_generic(record, &data_src);
 
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 648e8d87ef19..a228a7ba30ca 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -389,13 +389,16 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	 * skip over possible up to 2 operands to get to address, e.g.:
 	 * tbnz	 w0, #26, ffff0000083cd190 <security_file_permission+0xd0>
 	 */
-	if (c++ != NULL) {
+	if (c != NULL) {
+		c++;
 		ops->target.addr = strtoull(c, NULL, 16);
 		if (!ops->target.addr) {
 			c = strchr(c, ',');
 			c = validate_comma(c, ops);
-			if (c++ != NULL)
+			if (c != NULL) {
+				c++;
 				ops->target.addr = strtoull(c, NULL, 16);
+			}
 		}
 	} else {
 		ops->target.addr = strtoull(ops->raw, NULL, 16);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6d7249cc1a99..dda107b12b8c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3237,7 +3237,7 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 
 		/* If event has exclude user then don't exclude kernel. */
 		if (evsel->core.attr.exclude_user)
-			return false;
+			goto no_fallback;
 
 		/* Is there already the separator in the name. */
 		if (strchr(name, '/') ||
@@ -3245,7 +3245,7 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 			sep = "";
 
 		if (asprintf(&new_name, "%s%su", name, sep) < 0)
-			return false;
+			goto no_fallback;
 
 		free(evsel->name);
 		evsel->name = new_name;
@@ -3256,8 +3256,31 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 		evsel->core.attr.exclude_hv     = 1;
 
 		return true;
-	}
+	} else if (err == EOPNOTSUPP && !evsel->core.attr.exclude_guest &&
+		   !evsel->exclude_GH) {
+		const char *name = evsel__name(evsel);
+		char *new_name;
+		const char *sep = ":";
+
+		/* Is there already the separator in the name. */
+		if (strchr(name, '/') ||
+		    (strchr(name, ':') && !evsel->is_libpfm_event))
+			sep = "";
+
+		if (asprintf(&new_name, "%s%sH", name, sep) < 0)
+			goto no_fallback;
 
+		free(evsel->name);
+		evsel->name = new_name;
+		/* Apple M1 requires exclude_guest */
+		scnprintf(msg, msgsize, "Trying to fall back to excluding guest samples");
+		evsel->core.attr.exclude_guest = 1;
+
+		return true;
+	}
+no_fallback:
+	scnprintf(msg, msgsize, "No fallback found for '%s' for error %d",
+		  evsel__name(evsel), err);
 	return false;
 }
 
@@ -3497,6 +3520,8 @@ bool evsel__is_hybrid(const struct evsel *evsel)
 
 struct evsel *evsel__leader(const struct evsel *evsel)
 {
+	if (evsel->core.leader == NULL)
+		return NULL;
 	return container_of(evsel->core.leader, struct evsel, core);
 }
 
diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index af9a97612f9d..f61574d1581e 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -113,7 +113,7 @@ bool lzma_is_compressed(const char *input)
 	ssize_t rc;
 
 	if (fd < 0)
-		return -1;
+		return false;
 
 	rc = read(fd, buf, sizeof(buf));
 	close(fd);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index dbaf07bf6c5f..89e5354fa094 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1371,7 +1371,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	const struct perf_tool *tool = session->tool;
 	struct perf_sample sample = { .time = 0, };
 	int fd = perf_data__fd(session->data);
-	int err;
+	s64 err;
 
 	if (event->header.type != PERF_RECORD_COMPRESSED || perf_tool__compressed_is_stub(tool))
 		dump_event(session->evlist, event, file_offset, &sample, file_path);
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 649550e9b7aa..abb567de3e8a 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -1,6 +1,7 @@
 from os import getenv, path
 from subprocess import Popen, PIPE
 from re import sub
+import shlex
 
 cc = getenv("CC")
 
@@ -16,7 +17,9 @@ cc_is_clang = b"clang version" in Popen([cc, "-v"], stderr=PIPE).stderr.readline
 src_feature_tests  = getenv('srctree') + '/tools/build/feature'
 
 def clang_has_option(option):
-    cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
+    cmd = shlex.split(f"{cc} {cc_options} {option}")
+    cmd.append(path.join(src_feature_tests, "test-hello.c"))
+    cc_output = Popen(cmd, stderr=PIPE).stderr.readlines()
     return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o) or (b"unknown warning option" in o))] == [ ]
 
 if cc_is_clang:
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
diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index ef7d911da13e..16f5754b8b1f 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -264,23 +264,6 @@ static void test_softdirty(void)
 	munmap(addr, SIZE);
 }
 
-static int system_has_softdirty(void)
-{
-	/*
-	 * There is no way to check if the kernel supports soft-dirty, other
-	 * than by writing to a page and seeing if the bit was set. But the
-	 * tests are intended to check that the bit gets set when it should, so
-	 * doing that check would turn a potentially legitimate fail into a
-	 * skip. Fortunately, we know for sure that arm64 does not support
-	 * soft-dirty. So for now, let's just use the arch as a corse guide.
-	 */
-#if defined(__aarch64__)
-	return 0;
-#else
-	return 1;
-#endif
-}
-
 int main(int argc, char **argv)
 {
 	int nr_tests = 16;
@@ -288,7 +271,7 @@ int main(int argc, char **argv)
 
 	pagesize = getpagesize();
 
-	if (system_has_softdirty())
+	if (softdirty_supported())
 		nr_tests += 5;
 
 	ksft_print_header();
@@ -300,7 +283,7 @@ int main(int argc, char **argv)
 	test_holes();
 	test_populate_read();
 	test_populate_write();
-	if (system_has_softdirty())
+	if (softdirty_supported())
 		test_softdirty();
 
 	err = ksft_get_fail_cnt();
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index bdfa5d085f00..7b91df12ce5b 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -193,8 +193,11 @@ int main(int argc, char **argv)
 	int pagesize;
 
 	ksft_print_header();
-	ksft_set_plan(15);
 
+	if (!softdirty_supported())
+		ksft_exit_skip("soft-dirty is not support\n");
+
+	ksft_set_plan(15);
 	pagemap_fd = open(PAGEMAP_FILE_PATH, O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_fail_msg("Failed to open %s\n", PAGEMAP_FILE_PATH);
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index d8d0cf04bb57..a4a2805d3d3e 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -193,6 +193,42 @@ unsigned long rss_anon(void)
 	return rss_anon;
 }
 
+char *__get_smap_entry(void *addr, const char *pattern, char *buf, size_t len)
+{
+	int ret;
+	FILE *fp;
+	char *entry = NULL;
+	char addr_pattern[MAX_LINE_LENGTH];
+
+	ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
+		       (unsigned long)addr);
+	if (ret >= MAX_LINE_LENGTH)
+		ksft_exit_fail_msg("%s: Pattern is too long\n", __func__);
+
+	fp = fopen(SMAP_FILE_PATH, "r");
+	if (!fp)
+		ksft_exit_fail_msg("%s: Failed to open file %s\n", __func__,
+				   SMAP_FILE_PATH);
+
+	if (!check_for_pattern(fp, addr_pattern, buf, len))
+		goto err_out;
+
+	/* Fetch the pattern in the same block */
+	if (!check_for_pattern(fp, pattern, buf, len))
+		goto err_out;
+
+	/* Trim trailing newline */
+	entry = strchr(buf, '\n');
+	if (entry)
+		*entry = '\0';
+
+	entry = buf + strlen(pattern);
+
+err_out:
+	fclose(fp);
+	return entry;
+}
+
 bool __check_huge(void *addr, char *pattern, int nr_hpages,
 		  uint64_t hpage_size)
 {
@@ -384,3 +420,44 @@ unsigned long get_free_hugepages(void)
 	fclose(f);
 	return fhp;
 }
+
+static bool check_vmflag(void *addr, const char *flag)
+{
+	char buffer[MAX_LINE_LENGTH];
+	const char *flags;
+	size_t flaglen;
+
+	flags = __get_smap_entry(addr, "VmFlags:", buffer, sizeof(buffer));
+	if (!flags)
+		ksft_exit_fail_msg("%s: No VmFlags for %p\n", __func__, addr);
+
+	while (true) {
+		flags += strspn(flags, " ");
+
+		flaglen = strcspn(flags, " ");
+		if (!flaglen)
+			return false;
+
+		if (flaglen == strlen(flag) && !memcmp(flags, flag, flaglen))
+			return true;
+
+		flags += flaglen;
+	}
+}
+
+bool softdirty_supported(void)
+{
+	char *addr;
+	bool supported = false;
+	const size_t pagesize = getpagesize();
+
+	/* New mappings are expected to be marked with VM_SOFTDIRTY (sd). */
+	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	if (!addr)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	supported = check_vmflag(addr, "sd");
+	munmap(addr, pagesize);
+	return supported;
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 2eaed8209925..823d07d84ad0 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -53,6 +53,7 @@ int uffd_unregister(int uffd, void *addr, uint64_t len);
 int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 			      bool miss, bool wp, bool minor, uint64_t *ioctls);
 unsigned long get_free_hugepages(void);
+bool softdirty_supported(void);
 
 /*
  * On ppc64 this will only work with radix 2M hugepage size
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c07e2bd3a315..6b22b8c73742 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3160,6 +3160,17 @@ deny_join_id0_tests()
 		run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
+
+	# default limits, server deny join id 0 + signal
+	if reset_with_allow_join_id0 "default limits, server deny join id 0" 0 1; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 2 2 2
+	fi
 }
 
 fullmesh_tests()
diff --git a/tools/testing/selftests/net/netfilter/nf_nat_edemux.sh b/tools/testing/selftests/net/netfilter/nf_nat_edemux.sh
index 1014551dd769..6731fe1eaf2e 100755
--- a/tools/testing/selftests/net/netfilter/nf_nat_edemux.sh
+++ b/tools/testing/selftests/net/netfilter/nf_nat_edemux.sh
@@ -17,9 +17,31 @@ cleanup()
 
 checktool "socat -h" "run test without socat"
 checktool "iptables --version" "run test without iptables"
+checktool "conntrack --version" "run test without conntrack"
 
 trap cleanup EXIT
 
+connect_done()
+{
+	local ns="$1"
+	local port="$2"
+
+	ip netns exec "$ns" ss -nt -o state established "dport = :$port" | grep -q "$port"
+}
+
+check_ctstate()
+{
+	local ns="$1"
+	local dp="$2"
+
+	if ! ip netns exec "$ns" conntrack --get -s 192.168.1.2 -d 192.168.1.1 -p tcp \
+	     --sport 10000 --dport "$dp" --state ESTABLISHED > /dev/null 2>&1;then
+		echo "FAIL: Did not find expected state for dport $2"
+		ip netns exec "$ns" bash -c 'conntrack -L; conntrack -S; ss -nt'
+		ret=1
+	fi
+}
+
 setup_ns ns1 ns2
 
 # Connect the namespaces using a veth pair
@@ -44,15 +66,18 @@ socatpid=$!
 ip netns exec "$ns2" sysctl -q net.ipv4.ip_local_port_range="10000 10000"
 
 # add a virtual IP using DNAT
-ip netns exec "$ns2" iptables -t nat -A OUTPUT -d 10.96.0.1/32 -p tcp --dport 443 -j DNAT --to-destination 192.168.1.1:5201
+ip netns exec "$ns2" iptables -t nat -A OUTPUT -d 10.96.0.1/32 -p tcp --dport 443 -j DNAT --to-destination 192.168.1.1:5201 || exit 1
 
 # ... and route it to the other namespace
 ip netns exec "$ns2" ip route add 10.96.0.1 via 192.168.1.1
 
-# add a persistent connection from the other namespace
-ip netns exec "$ns2" socat -t 10 - TCP:192.168.1.1:5201 > /dev/null &
+# listener should be up by now, wait if it isn't yet.
+wait_local_port_listen "$ns1" 5201 tcp
 
-sleep 1
+# add a persistent connection from the other namespace
+sleep 10 | ip netns exec "$ns2" socat -t 10 - TCP:192.168.1.1:5201 > /dev/null &
+cpid0=$!
+busywait "$BUSYWAIT_TIMEOUT" connect_done "$ns2" "5201"
 
 # ip daddr:dport will be rewritten to 192.168.1.1 5201
 # NAT must reallocate source port 10000 because
@@ -71,26 +96,25 @@ fi
 ip netns exec "$ns1" iptables -t nat -A PREROUTING -p tcp --dport 5202 -j REDIRECT --to-ports 5201
 ip netns exec "$ns1" iptables -t nat -A PREROUTING -p tcp --dport 5203 -j REDIRECT --to-ports 5201
 
-sleep 5 | ip netns exec "$ns2" socat -t 5 -u STDIN TCP:192.168.1.1:5202,connect-timeout=5 >/dev/null &
+sleep 5 | ip netns exec "$ns2" socat -T 5 -u STDIN TCP:192.168.1.1:5202,connect-timeout=5 >/dev/null &
+cpid1=$!
 
-# if connect succeeds, client closes instantly due to EOF on stdin.
-# if connect hangs, it will time out after 5s.
-echo | ip netns exec "$ns2" socat -t 3 -u STDIN TCP:192.168.1.1:5203,connect-timeout=5 >/dev/null &
+sleep 5 | ip netns exec "$ns2" socat -T 5 -u STDIN TCP:192.168.1.1:5203,connect-timeout=5 >/dev/null &
 cpid2=$!
 
-time_then=$(date +%s)
-wait $cpid2
-rv=$?
-time_now=$(date +%s)
+busywait "$BUSYWAIT_TIMEOUT" connect_done "$ns2" 5202
+busywait "$BUSYWAIT_TIMEOUT" connect_done "$ns2" 5203
 
-# Check how much time has elapsed, expectation is for
-# 'cpid2' to connect and then exit (and no connect delay).
-delta=$((time_now - time_then))
+check_ctstate "$ns1" 5202
+check_ctstate "$ns1" 5203
 
-if [ $delta -lt 2 ] && [ $rv -eq 0 ]; then
+kill $socatpid $cpid0 $cpid1 $cpid2
+socatpid=0
+
+if [ $ret -eq 0 ]; then
 	echo "PASS: could connect to service via redirected ports"
 else
-	echo "FAIL: socat cannot connect to service via redirect ($delta seconds elapsed, returned $rv)"
+	echo "FAIL: socat cannot connect to service via redirect"
 	ret=1
 fi
 
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index f6156790c3b4..05dc77fd527b 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -40,9 +40,9 @@
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
@@ -198,7 +198,7 @@ void rseq_init(void)
 	 * libc not having registered a restartable sequence.  Try to find the
 	 * symbols if that's the case.
 	 */
-	if (!*libc_rseq_size_p) {
+	if (!libc_rseq_size_p || !*libc_rseq_size_p) {
 		libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
 		libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
 		libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");

