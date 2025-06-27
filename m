Return-Path: <stable+bounces-158771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5DBAEB44E
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 12:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1B417CBAD
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C672BF3DB;
	Fri, 27 Jun 2025 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m+hoCE6b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5632BF011;
	Fri, 27 Jun 2025 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019517; cv=none; b=L1E7qiO2AOvN21RhjUtNASIFPB182vhuk4ObjDIE2VgPpFafP+8/qoLqkhXCCkk7r+4SS3vsBSLhw3wjUiMNX5tiJaq14RiLEmoPDVd9EI+ybv7fY9GbSmHdRWydq8GT9sTLeLDG7d3O+GebA93tWfVEsNUL9MWDAvSAwFPGYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019517; c=relaxed/simple;
	bh=qXZmuVRPy5VuRjrDfLPPV1vbS3/mNvkU6pnSeYdiZkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XS6WtU3cwz76C8Lrfxp0dBxm8dxjan5wo8bX1bDQvV/G0gyEdPJ96Yp2G+N0Rp9OUU3BpU1bTdhCOvjr0a/KL184t6Q/HxNqSRyO6rG6poUiGZ6LGl9zIKuCpqMaCAOuIp4Ur9CaJNpukRW8rrBT+S1BtMsPEVe0edfVk0T6hsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m+hoCE6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDB0C4CEEB;
	Fri, 27 Jun 2025 10:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751019517;
	bh=qXZmuVRPy5VuRjrDfLPPV1vbS3/mNvkU6pnSeYdiZkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+hoCE6betViF95DdYxR3ONi0FdR/RRnVJBj6DSHx5ktTGWKWBjLrQgPJ4cvWgRZL
	 tR95jBZH+Ucaa89jNPBanvOPocO32YpcKGOXTw7StcK6Hp7kxboHCl2EHdHtm5B+R8
	 h1Jopa38IulcQjUzELvicv7BOR4w+bhrD7O/L7Mo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.35
Date: Fri, 27 Jun 2025 11:18:27 +0100
Message-ID: <2025062727-manhole-sadly-60a0@gregkh>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2025062727-duo-hush-38c6@gregkh>
References: <2025062727-duo-hush-38c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yaml b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yaml
index b57ae6963e62..6b6f6762d122 100644
--- a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yaml
@@ -97,7 +97,10 @@ properties:
 
   resets:
     items:
-      - description: module reset
+      - description:
+          Module reset. This property is optional for controllers in Tegra194,
+          Tegra234 etc where an internal software reset is available as an
+          alternative.
 
   reset-names:
     items:
@@ -116,6 +119,13 @@ properties:
       - const: rx
       - const: tx
 
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
 allOf:
   - $ref: /schemas/i2c/i2c-controller.yaml
   - if:
@@ -169,6 +179,18 @@ allOf:
       properties:
         power-domains: false
 
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - nvidia,tegra194-i2c
+    then:
+      required:
+        - resets
+        - reset-names
+
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 7964e0c245ae..81607ce40759 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -656,6 +656,20 @@ cc-cross-prefix
             endif
     endif
 
+$(RUSTC) support functions
+--------------------------
+
+rustc-min-version
+  rustc-min-version tests if the value of $(CONFIG_RUSTC_VERSION) is greater
+  than or equal to the provided value and evaluates to y if so.
+
+  Example::
+
+    rustflags-$(call rustc-min-version, 108500) := -Cfoo
+
+  In this example, rustflags-y will be assigned the value -Cfoo if
+  $(CONFIG_RUSTC_VERSION) is >= 1.85.0.
+
 $(LD) support functions
 -----------------------
 
diff --git a/Makefile b/Makefile
index b58a061cb359..535df76f6f78 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 34
+SUBLEVEL = 35
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index c36fb2721261..86a2f9e5d0ef 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -48,6 +48,7 @@
 #define CLKDM_NO_AUTODEPS			(1 << 4)
 #define CLKDM_ACTIVE_WITH_MPU			(1 << 5)
 #define CLKDM_MISSING_IDLE_REPORTING		(1 << 6)
+#define CLKDM_STANDBY_FORCE_WAKEUP		BIT(7)
 
 #define CLKDM_CAN_HWSUP		(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AUTO)
 #define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
diff --git a/arch/arm/mach-omap2/clockdomains33xx_data.c b/arch/arm/mach-omap2/clockdomains33xx_data.c
index 87f4e927eb18..c05a3c07d448 100644
--- a/arch/arm/mach-omap2/clockdomains33xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains33xx_data.c
@@ -19,7 +19,7 @@ static struct clockdomain l4ls_am33xx_clkdm = {
 	.pwrdm		= { .name = "per_pwrdm" },
 	.cm_inst	= AM33XX_CM_PER_MOD,
 	.clkdm_offs	= AM33XX_CM_PER_L4LS_CLKSTCTRL_OFFSET,
-	.flags		= CLKDM_CAN_SWSUP,
+	.flags		= CLKDM_CAN_SWSUP | CLKDM_STANDBY_FORCE_WAKEUP,
 };
 
 static struct clockdomain l3s_am33xx_clkdm = {
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index acdf72a541c0..a4dd42abda89 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -20,6 +20,9 @@
 #include "cm-regbits-34xx.h"
 #include "cm-regbits-33xx.h"
 #include "prm33xx.h"
+#if IS_ENABLED(CONFIG_SUSPEND)
+#include <linux/suspend.h>
+#endif
 
 /*
  * CLKCTRL_IDLEST_*: possible values for the CM_*_CLKCTRL.IDLEST bitfield:
@@ -328,8 +331,17 @@ static int am33xx_clkdm_clk_disable(struct clockdomain *clkdm)
 {
 	bool hwsup = false;
 
+#if IS_ENABLED(CONFIG_SUSPEND)
+	/*
+	 * In case of standby, Don't put the l4ls clk domain to sleep.
+	 * Since CM3 PM FW doesn't wake-up/enable the l4ls clk domain
+	 * upon wake-up, CM3 PM FW fails to wake-up th MPU.
+	 */
+	if (pm_suspend_target_state == PM_SUSPEND_STANDBY &&
+	    (clkdm->flags & CLKDM_STANDBY_FORCE_WAKEUP))
+		return 0;
+#endif
 	hwsup = am33xx_cm_is_clkdm_in_hwsup(clkdm->cm_inst, clkdm->clkdm_offs);
-
 	if (!hwsup && (clkdm->flags & CLKDM_CAN_FORCE_SLEEP))
 		am33xx_clkdm_sleep(clkdm);
 
diff --git a/arch/arm/mach-omap2/pmic-cpcap.c b/arch/arm/mach-omap2/pmic-cpcap.c
index 4f31e61c0c90..9f9a20274db8 100644
--- a/arch/arm/mach-omap2/pmic-cpcap.c
+++ b/arch/arm/mach-omap2/pmic-cpcap.c
@@ -264,7 +264,11 @@ int __init omap4_cpcap_init(void)
 
 static int __init cpcap_late_init(void)
 {
-	omap4_vc_set_pmic_signaling(PWRDM_POWER_RET);
+	if (!of_find_compatible_node(NULL, NULL, "motorola,cpcap"))
+		return 0;
+
+	if (soc_is_omap443x() || soc_is_omap446x() || soc_is_omap447x())
+		omap4_vc_set_pmic_signaling(PWRDM_POWER_RET);
 
 	return 0;
 }
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 89f1c97f3079..cbf5a03d2b18 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -515,7 +515,5 @@ void __init early_ioremap_init(void)
 bool arch_memremap_can_ram_remap(resource_size_t offset, size_t size,
 				 unsigned long flags)
 {
-	unsigned long pfn = PHYS_PFN(offset);
-
-	return memblock_is_map_memory(pfn);
+	return memblock_is_map_memory(offset);
 }
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 19a4988621ac..88029d38b3c6 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -48,7 +48,7 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_NO_FPU) \
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(compat_vdso)
 
-ifeq ($(call test-ge, $(CONFIG_RUSTC_VERSION), 108500),y)
+ifeq ($(call rustc-min-version, 108500),y)
 KBUILD_RUSTFLAGS += --target=aarch64-unknown-none-softfloat
 else
 KBUILD_RUSTFLAGS += --target=aarch64-unknown-none -Ctarget-feature="-neon"
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 9edbd871c31b..5f12cdc2b967 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -330,13 +330,14 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
 }
 
 /*
- * If mprotect/munmap/etc occurs during TLB batched flushing, we need to
- * synchronise all the TLBI issued with a DSB to avoid the race mentioned in
- * flush_tlb_batched_pending().
+ * If mprotect/munmap/etc occurs during TLB batched flushing, we need to ensure
+ * all the previously issued TLBIs targeting mm have completed. But since we
+ * can be executing on a remote CPU, a DSB cannot guarantee this like it can
+ * for arch_tlbbatch_flush(). Our only option is to flush the entire mm.
  */
 static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 {
-	dsb(ish);
+	flush_tlb_mm(mm);
 }
 
 /*
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 1559a239137f..1a8f4284cb69 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -140,7 +140,7 @@ unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
 
 	addr += n;
 	if (regs_within_kernel_stack(regs, (unsigned long)addr))
-		return *addr;
+		return READ_ONCE_NOCHECK(*addr);
 	else
 		return 0;
 }
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9bcd51fd67d4..aed8d32979d9 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1285,7 +1285,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	next = addr;
 	end = addr + PUD_SIZE;
 	do {
-		pmd_free_pte_page(pmdp, next);
+		if (pmd_present(pmdp_get(pmdp)))
+			pmd_free_pte_page(pmdp, next);
 	} while (pmdp++, next += PMD_SIZE, next != end);
 
 	pud_clear(pudp);
diff --git a/arch/loongarch/include/asm/irqflags.h b/arch/loongarch/include/asm/irqflags.h
index 319a8c616f1f..003172b8406b 100644
--- a/arch/loongarch/include/asm/irqflags.h
+++ b/arch/loongarch/include/asm/irqflags.h
@@ -14,40 +14,48 @@
 static inline void arch_local_irq_enable(void)
 {
 	u32 flags = CSR_CRMD_IE;
+	register u32 mask asm("t0") = CSR_CRMD_IE;
+
 	__asm__ __volatile__(
 		"csrxchg %[val], %[mask], %[reg]\n\t"
 		: [val] "+r" (flags)
-		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
+		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
 		: "memory");
 }
 
 static inline void arch_local_irq_disable(void)
 {
 	u32 flags = 0;
+	register u32 mask asm("t0") = CSR_CRMD_IE;
+
 	__asm__ __volatile__(
 		"csrxchg %[val], %[mask], %[reg]\n\t"
 		: [val] "+r" (flags)
-		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
+		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
 		: "memory");
 }
 
 static inline unsigned long arch_local_irq_save(void)
 {
 	u32 flags = 0;
+	register u32 mask asm("t0") = CSR_CRMD_IE;
+
 	__asm__ __volatile__(
 		"csrxchg %[val], %[mask], %[reg]\n\t"
 		: [val] "+r" (flags)
-		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
+		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
 		: "memory");
 	return flags;
 }
 
 static inline void arch_local_irq_restore(unsigned long flags)
 {
+	register u32 mask asm("t0") = CSR_CRMD_IE;
+
 	__asm__ __volatile__(
 		"csrxchg %[val], %[mask], %[reg]\n\t"
 		: [val] "+r" (flags)
-		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
+		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
 		: "memory");
 }
 
diff --git a/arch/loongarch/include/asm/vdso/getrandom.h b/arch/loongarch/include/asm/vdso/getrandom.h
index 02f36772541b..7e9edc1cb610 100644
--- a/arch/loongarch/include/asm/vdso/getrandom.h
+++ b/arch/loongarch/include/asm/vdso/getrandom.h
@@ -20,7 +20,7 @@ static __always_inline ssize_t getrandom_syscall(void *_buffer, size_t _len, uns
 
 	asm volatile(
 	"      syscall 0\n"
-	: "+r" (ret)
+	: "=r" (ret)
 	: "r" (nr), "r" (buffer), "r" (len), "r" (flags)
 	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", "$t8",
 	  "memory");
diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loongarch/include/asm/vdso/gettimeofday.h
index 89e6b222c2f2..2d1a9c27af29 100644
--- a/arch/loongarch/include/asm/vdso/gettimeofday.h
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -25,7 +25,7 @@ static __always_inline long gettimeofday_fallback(
 
 	asm volatile(
 	"       syscall 0\n"
-	: "+r" (ret)
+	: "=r" (ret)
 	: "r" (nr), "r" (tv), "r" (tz)
 	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
 	  "$t8", "memory");
@@ -44,7 +44,7 @@ static __always_inline long clock_gettime_fallback(
 
 	asm volatile(
 	"       syscall 0\n"
-	: "+r" (ret)
+	: "=r" (ret)
 	: "r" (nr), "r" (clkid), "r" (ts)
 	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
 	  "$t8", "memory");
@@ -63,7 +63,7 @@ static __always_inline int clock_getres_fallback(
 
 	asm volatile(
 	"       syscall 0\n"
-	: "+r" (ret)
+	: "=r" (ret)
 	: "r" (nr), "r" (clkid), "r" (ts)
 	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
 	  "$t8", "memory");
diff --git a/arch/loongarch/mm/hugetlbpage.c b/arch/loongarch/mm/hugetlbpage.c
index cea84d7f2b91..02dad4624fe3 100644
--- a/arch/loongarch/mm/hugetlbpage.c
+++ b/arch/loongarch/mm/hugetlbpage.c
@@ -47,7 +47,8 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 				pmd = pmd_offset(pud, addr);
 		}
 	}
-	return pmd_none(pmdp_get(pmd)) ? NULL : (pte_t *) pmd;
+
+	return (!pmd || pmd_none(pmdp_get(pmd))) ? NULL : (pte_t *) pmd;
 }
 
 uint64_t pmd_to_entrylo(unsigned long pmd_val)
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index b289b2c1b294..c729bd687804 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -27,6 +27,7 @@ endif
 # offsets.
 cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
+	$(filter -std=%,$(KBUILD_CFLAGS)) \
 	-O3 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
 	-mrelax-pic-calls $(call cc-option, -mexplicit-relocs) \
 	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index 92227fa813dc..17c42d718eb3 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -18,6 +18,7 @@ KBUILD_CFLAGS += -fno-PIE -mno-space-regs -mdisable-fpregs -Os
 ifndef CONFIG_64BIT
 KBUILD_CFLAGS += -mfast-indirect-calls
 endif
+KBUILD_CFLAGS += -std=gnu11
 
 LDFLAGS_vmlinux := -X -e startup --as-needed -T
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(addprefix $(obj)/, $(OBJECTS)) $(LIBGCC) FORCE
diff --git a/arch/parisc/kernel/unaligned.c b/arch/parisc/kernel/unaligned.c
index f4626943633a..00e97204783e 100644
--- a/arch/parisc/kernel/unaligned.c
+++ b/arch/parisc/kernel/unaligned.c
@@ -25,7 +25,7 @@
 #define DPRINTF(fmt, args...)
 #endif
 
-#define RFMT "%#08lx"
+#define RFMT "0x%08lx"
 
 /* 1111 1100 0000 0000 0001 0011 1100 0000 */
 #define OPCODE1(a,b,c)	((a)<<26|(b)<<12|(c)<<6) 
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 02897f4b0dbf..b891910fce8a 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -183,7 +183,7 @@
 /*
  * Used to name C functions called from asm
  */
-#ifdef CONFIG_PPC_KERNEL_PCREL
+#if defined(__powerpc64__) && defined(CONFIG_PPC_KERNEL_PCREL)
 #define CFUNC(name) name@notoc
 #else
 #define CFUNC(name) name
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 83fe99861eb1..ca7f7bb2b478 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1509,6 +1509,8 @@ int eeh_pe_configure(struct eeh_pe *pe)
 	/* Invalid PE ? */
 	if (!pe)
 		return -ENODEV;
+	else
+		ret = eeh_ops->configure_bridge(pe);
 
 	return ret;
 }
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index c568cad6a22e..6ba68b28ed87 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -53,7 +53,7 @@ ldflags-$(CONFIG_LD_ORPHAN_WARN) += -Wl,--orphan-handling=$(CONFIG_LD_ORPHAN_WAR
 ldflags-y += $(filter-out $(CC_AUTO_VAR_INIT_ZERO_ENABLER) $(CC_FLAGS_FTRACE) -Wa$(comma)%, $(KBUILD_CFLAGS))
 
 CC32FLAGS := -m32
-CC32FLAGSREMOVE := -mcmodel=medium -mabi=elfv1 -mabi=elfv2 -mcall-aixdesc
+CC32FLAGSREMOVE := -mcmodel=medium -mabi=elfv1 -mabi=elfv2 -mcall-aixdesc -mpcrel
 ifdef CONFIG_CC_IS_CLANG
 # This flag is supported by clang for 64-bit but not 32-bit so it will cause
 # an unused command line flag warning for this file.
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 6dfb55b52d36..ba98a680a12e 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -524,7 +524,12 @@ static struct msi_domain_info pseries_msi_domain_info = {
 
 static void pseries_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	__pci_read_msi_msg(irq_data_get_msi_desc(data), msg);
+	struct pci_dev *dev = msi_desc_to_pci_dev(irq_data_get_msi_desc(data));
+
+	if (dev->current_state == PCI_D0)
+		__pci_read_msi_msg(irq_data_get_msi_desc(data), msg);
+	else
+		get_cached_msi_msg(data->irq, msg);
 }
 
 static struct irq_chip pseries_msi_irq_chip = {
diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
index 5fbf3f94f1e8..b17fad091bab 100644
--- a/arch/riscv/kvm/vcpu_sbi_replace.c
+++ b/arch/riscv/kvm/vcpu_sbi_replace.c
@@ -103,7 +103,7 @@ static int kvm_sbi_ext_rfence_handler(struct kvm_vcpu *vcpu, struct kvm_run *run
 		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_FENCE_I_SENT);
 		break;
 	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA:
-		if (cp->a2 == 0 && cp->a3 == 0)
+		if ((cp->a2 == 0 && cp->a3 == 0) || cp->a3 == -1UL)
 			kvm_riscv_hfence_vvma_all(vcpu->kvm, hbase, hmask);
 		else
 			kvm_riscv_hfence_vvma_gva(vcpu->kvm, hbase, hmask,
@@ -111,7 +111,7 @@ static int kvm_sbi_ext_rfence_handler(struct kvm_vcpu *vcpu, struct kvm_run *run
 		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENCE_VVMA_SENT);
 		break;
 	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID:
-		if (cp->a2 == 0 && cp->a3 == 0)
+		if ((cp->a2 == 0 && cp->a3 == 0) || cp->a3 == -1UL)
 			kvm_riscv_hfence_vvma_asid_all(vcpu->kvm,
 						       hbase, hmask, cp->a4);
 		else
@@ -127,9 +127,9 @@ static int kvm_sbi_ext_rfence_handler(struct kvm_vcpu *vcpu, struct kvm_run *run
 	case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID:
 		/*
 		 * Until nested virtualization is implemented, the
-		 * SBI HFENCE calls should be treated as NOPs
+		 * SBI HFENCE calls should return not supported
+		 * hence fallthrough.
 		 */
-		break;
 	default:
 		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
 	}
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index a688351f4ab5..7bc97ebd60d5 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -317,7 +317,7 @@ enum prot_type {
 	PROT_TYPE_DAT  = 3,
 	PROT_TYPE_IEP  = 4,
 	/* Dummy value for passing an initialized value when code != PGM_PROTECTION */
-	PROT_NONE,
+	PROT_TYPE_DUMMY,
 };
 
 static int trans_exc_ending(struct kvm_vcpu *vcpu, int code, unsigned long gva, u8 ar,
@@ -333,7 +333,7 @@ static int trans_exc_ending(struct kvm_vcpu *vcpu, int code, unsigned long gva,
 	switch (code) {
 	case PGM_PROTECTION:
 		switch (prot) {
-		case PROT_NONE:
+		case PROT_TYPE_DUMMY:
 			/* We should never get here, acts like termination */
 			WARN_ON_ONCE(1);
 			break;
@@ -803,7 +803,7 @@ static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 			gpa = kvm_s390_real_to_abs(vcpu, ga);
 			if (!kvm_is_gpa_in_memslot(vcpu->kvm, gpa)) {
 				rc = PGM_ADDRESSING;
-				prot = PROT_NONE;
+				prot = PROT_TYPE_DUMMY;
 			}
 		}
 		if (rc)
@@ -961,7 +961,7 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 		if (rc == PGM_PROTECTION)
 			prot = PROT_TYPE_KEYC;
 		else
-			prot = PROT_NONE;
+			prot = PROT_TYPE_DUMMY;
 		rc = trans_exc_ending(vcpu, rc, ga, ar, mode, prot, terminate);
 	}
 out_unlock:
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 88f72745fa59..9e19d6076d3e 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -44,6 +44,7 @@
 /* list of all detected zpci devices */
 static LIST_HEAD(zpci_list);
 static DEFINE_SPINLOCK(zpci_list_lock);
+static DEFINE_MUTEX(zpci_add_remove_lock);
 
 static DECLARE_BITMAP(zpci_domain, ZPCI_DOMAIN_BITMAP_SIZE);
 static DEFINE_SPINLOCK(zpci_domain_lock);
@@ -69,6 +70,15 @@ EXPORT_SYMBOL_GPL(zpci_aipb);
 struct airq_iv *zpci_aif_sbv;
 EXPORT_SYMBOL_GPL(zpci_aif_sbv);
 
+void zpci_zdev_put(struct zpci_dev *zdev)
+{
+	if (!zdev)
+		return;
+	mutex_lock(&zpci_add_remove_lock);
+	kref_put_lock(&zdev->kref, zpci_release_device, &zpci_list_lock);
+	mutex_unlock(&zpci_add_remove_lock);
+}
+
 struct zpci_dev *get_zdev_by_fid(u32 fid)
 {
 	struct zpci_dev *tmp, *zdev = NULL;
@@ -831,6 +841,7 @@ int zpci_add_device(struct zpci_dev *zdev)
 {
 	int rc;
 
+	mutex_lock(&zpci_add_remove_lock);
 	zpci_dbg(1, "add fid:%x, fh:%x, c:%d\n", zdev->fid, zdev->fh, zdev->state);
 	rc = zpci_init_iommu(zdev);
 	if (rc)
@@ -844,12 +855,14 @@ int zpci_add_device(struct zpci_dev *zdev)
 	spin_lock(&zpci_list_lock);
 	list_add_tail(&zdev->entry, &zpci_list);
 	spin_unlock(&zpci_list_lock);
+	mutex_unlock(&zpci_add_remove_lock);
 	return 0;
 
 error_destroy_iommu:
 	zpci_destroy_iommu(zdev);
 error:
 	zpci_dbg(0, "add fid:%x, rc:%d\n", zdev->fid, rc);
+	mutex_unlock(&zpci_add_remove_lock);
 	return rc;
 }
 
@@ -919,21 +932,20 @@ int zpci_deconfigure_device(struct zpci_dev *zdev)
  * @zdev: the zpci_dev that was reserved
  *
  * Handle the case that a given zPCI function was reserved by another system.
- * After a call to this function the zpci_dev can not be found via
- * get_zdev_by_fid() anymore but may still be accessible via existing
- * references though it will not be functional anymore.
  */
 void zpci_device_reserved(struct zpci_dev *zdev)
 {
-	/*
-	 * Remove device from zpci_list as it is going away. This also
-	 * makes sure we ignore subsequent zPCI events for this device.
-	 */
-	spin_lock(&zpci_list_lock);
-	list_del(&zdev->entry);
-	spin_unlock(&zpci_list_lock);
+	lockdep_assert_held(&zdev->state_lock);
+	/* We may declare the device reserved multiple times */
+	if (zdev->state == ZPCI_FN_STATE_RESERVED)
+		return;
 	zdev->state = ZPCI_FN_STATE_RESERVED;
 	zpci_dbg(3, "rsv fid:%x\n", zdev->fid);
+	/*
+	 * The underlying device is gone. Allow the zdev to be freed
+	 * as soon as all other references are gone by accounting for
+	 * the removal as a dropped reference.
+	 */
 	zpci_zdev_put(zdev);
 }
 
@@ -941,13 +953,14 @@ void zpci_release_device(struct kref *kref)
 {
 	struct zpci_dev *zdev = container_of(kref, struct zpci_dev, kref);
 
+	lockdep_assert_held(&zpci_add_remove_lock);
 	WARN_ON(zdev->state != ZPCI_FN_STATE_RESERVED);
-
-	if (zdev->zbus->bus)
-		zpci_bus_remove_device(zdev, false);
-
-	if (zdev_enabled(zdev))
-		zpci_disable_device(zdev);
+	/*
+	 * We already hold zpci_list_lock thanks to kref_put_lock().
+	 * This makes sure no new reference can be taken from the list.
+	 */
+	list_del(&zdev->entry);
+	spin_unlock(&zpci_list_lock);
 
 	if (zdev->has_hp_slot)
 		zpci_exit_slot(zdev);
diff --git a/arch/s390/pci/pci_bus.h b/arch/s390/pci/pci_bus.h
index af9f0ac79a1b..3febb3b297c0 100644
--- a/arch/s390/pci/pci_bus.h
+++ b/arch/s390/pci/pci_bus.h
@@ -17,11 +17,8 @@ int zpci_bus_scan_device(struct zpci_dev *zdev);
 void zpci_bus_remove_device(struct zpci_dev *zdev, bool set_error);
 
 void zpci_release_device(struct kref *kref);
-static inline void zpci_zdev_put(struct zpci_dev *zdev)
-{
-	if (zdev)
-		kref_put(&zdev->kref, zpci_release_device);
-}
+
+void zpci_zdev_put(struct zpci_dev *zdev);
 
 static inline void zpci_zdev_get(struct zpci_dev *zdev)
 {
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 7f7b732b3f3e..6f48a1073c6e 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -322,6 +322,22 @@ static void zpci_event_hard_deconfigured(struct zpci_dev *zdev, u32 fh)
 	zdev->state = ZPCI_FN_STATE_STANDBY;
 }
 
+static void zpci_event_reappear(struct zpci_dev *zdev)
+{
+	lockdep_assert_held(&zdev->state_lock);
+	/*
+	 * The zdev is in the reserved state. This means that it was presumed to
+	 * go away but there are still undropped references. Now, the platform
+	 * announced its availability again. Bring back the lingering zdev
+	 * to standby. This is safe because we hold a temporary reference
+	 * now so that it won't go away. Account for the re-appearance of the
+	 * underlying device by incrementing the reference count.
+	 */
+	zdev->state = ZPCI_FN_STATE_STANDBY;
+	zpci_zdev_get(zdev);
+	zpci_dbg(1, "rea fid:%x, fh:%x\n", zdev->fid, zdev->fh);
+}
+
 static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 {
 	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
@@ -345,8 +361,10 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 				break;
 			}
 		} else {
+			if (zdev->state == ZPCI_FN_STATE_RESERVED)
+				zpci_event_reappear(zdev);
 			/* the configuration request may be stale */
-			if (zdev->state != ZPCI_FN_STATE_STANDBY)
+			else if (zdev->state != ZPCI_FN_STATE_STANDBY)
 				break;
 			zdev->state = ZPCI_FN_STATE_CONFIGURED;
 		}
@@ -362,6 +380,8 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 				break;
 			}
 		} else {
+			if (zdev->state == ZPCI_FN_STATE_RESERVED)
+				zpci_event_reappear(zdev);
 			zpci_update_fh(zdev, ccdf->fh);
 		}
 		break;
diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 4779c3cb6cfa..0fa34c501296 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -228,7 +228,7 @@ static inline int __pcilg_mio_inuser(
 		[ioaddr_len] "+&d" (ioaddr_len.pair),
 		[cc] "+d" (cc), [val] "=d" (val),
 		[dst] "+a" (dst), [cnt] "+d" (cnt), [tmp] "=d" (tmp),
-		[shift] "+d" (shift)
+		[shift] "+a" (shift)
 		:: "cc", "memory");
 
 	/* did we write everything to the user space buffer? */
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index b5b633294061..2d13ef1f4b05 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -97,7 +97,7 @@ void tdx_init(void);
 
 typedef u64 (*sc_func_t)(u64 fn, struct tdx_module_args *args);
 
-static inline u64 sc_retry(sc_func_t func, u64 fn,
+static __always_inline u64 sc_retry(sc_func_t func, u64 fn,
 			   struct tdx_module_args *args)
 {
 	int retry = RDRAND_RETRY_LOOPS;
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 9ace84486499..147ea26dfdad 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -719,6 +719,8 @@ int arch_memory_failure(unsigned long pfn, int flags)
 		goto out;
 	}
 
+	sgx_unmark_page_reclaimable(page);
+
 	/*
 	 * TBD: Add additional plumbing to enable pre-emptive
 	 * action for asynchronous poison notification. Until
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7cbacd043921..1f42a71b15c0 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1483,7 +1483,7 @@ static void svm_clear_current_vmcb(struct vmcb *vmcb)
 {
 	int i;
 
-	for_each_online_cpu(i)
+	for_each_possible_cpu(i)
 		cmpxchg(per_cpu_ptr(&svm_data.current_vmcb, i), vmcb, NULL);
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a3d45b01dbad..bcbedddacc48 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -770,8 +770,11 @@ void vmx_emergency_disable_virtualization_cpu(void)
 		return;
 
 	list_for_each_entry(v, &per_cpu(loaded_vmcss_on_cpu, cpu),
-			    loaded_vmcss_on_cpu_link)
+			    loaded_vmcss_on_cpu_link) {
 		vmcs_clear(v->vmcs);
+		if (v->shadow_vmcs)
+			vmcs_clear(v->shadow_vmcs);
+	}
 
 	kvm_cpu_vmxoff();
 }
diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 472540aeabc2..08cd913cbd4e 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -10,8 +10,7 @@
 #include <assert.h>
 #include <unistd.h>
 #include <stdarg.h>
-
-#define unlikely(cond) (cond)
+#include <linux/kallsyms.h>
 
 #include <asm/insn.h>
 #include <inat.c>
@@ -106,7 +105,7 @@ static void parse_args(int argc, char **argv)
 	}
 }
 
-#define BUFSIZE 256
+#define BUFSIZE (256 + KSYM_NAME_LEN)
 
 int main(int argc, char **argv)
 {
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4e2b2e2ac9f9..eb91bc5448de 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -69,8 +69,9 @@ static inline void seamcall_err_ret(u64 fn, u64 err,
 			args->r9, args->r10, args->r11);
 }
 
-static inline int sc_retry_prerr(sc_func_t func, sc_err_func_t err_func,
-				 u64 fn, struct tdx_module_args *args)
+static __always_inline int sc_retry_prerr(sc_func_t func,
+					  sc_err_func_t err_func,
+					  u64 fn, struct tdx_module_args *args)
 {
 	u64 sret = sc_retry(func, fn, args);
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index f575cc1705b3..7ddd7dd23dda 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1180,20 +1180,20 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	if (!plug || rq_list_empty(&plug->mq_list))
 		return false;
 
-	rq_list_for_each(&plug->mq_list, rq) {
-		if (rq->q == q) {
-			if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
-			    BIO_MERGE_OK)
-				return true;
-			break;
-		}
+	rq = plug->mq_list.tail;
+	if (rq->q == q)
+		return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
+			BIO_MERGE_OK;
+	else if (!plug->multiple_queues)
+		return false;
 
-		/*
-		 * Only keep iterating plug list for merges if we have multiple
-		 * queues
-		 */
-		if (!plug->multiple_queues)
-			break;
+	rq_list_for_each(&plug->mq_list, rq) {
+		if (rq->q != q)
+			continue;
+		if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
+		    BIO_MERGE_OK)
+			return true;
+		break;
 	}
 	return false;
 }
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 164ded9eb144..d84946eb2f21 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1240,6 +1240,7 @@ void blk_zone_write_plug_bio_endio(struct bio *bio)
 	if (bio_flagged(bio, BIO_EMULATES_ZONE_APPEND)) {
 		bio->bi_opf &= ~REQ_OP_MASK;
 		bio->bi_opf |= REQ_OP_ZONE_APPEND;
+		bio_clear_flag(bio, BIO_EMULATES_ZONE_APPEND);
 	}
 
 	/*
diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index 83e4995540a6..cd40446a22a5 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -53,18 +53,18 @@ static struct {
 	int gen;
 	const char *name;
 } fw_names[] = {
-	{ IVPU_HW_IP_37XX, "vpu_37xx.bin" },
+	{ IVPU_HW_IP_37XX, "intel/vpu/vpu_37xx_v1.bin" },
 	{ IVPU_HW_IP_37XX, "intel/vpu/vpu_37xx_v0.0.bin" },
-	{ IVPU_HW_IP_40XX, "vpu_40xx.bin" },
+	{ IVPU_HW_IP_40XX, "intel/vpu/vpu_40xx_v1.bin" },
 	{ IVPU_HW_IP_40XX, "intel/vpu/vpu_40xx_v0.0.bin" },
-	{ IVPU_HW_IP_50XX, "vpu_50xx.bin" },
+	{ IVPU_HW_IP_50XX, "intel/vpu/vpu_50xx_v1.bin" },
 	{ IVPU_HW_IP_50XX, "intel/vpu/vpu_50xx_v0.0.bin" },
 };
 
 /* Production fw_names from the table above */
-MODULE_FIRMWARE("intel/vpu/vpu_37xx_v0.0.bin");
-MODULE_FIRMWARE("intel/vpu/vpu_40xx_v0.0.bin");
-MODULE_FIRMWARE("intel/vpu/vpu_50xx_v0.0.bin");
+MODULE_FIRMWARE("intel/vpu/vpu_37xx_v1.bin");
+MODULE_FIRMWARE("intel/vpu/vpu_40xx_v1.bin");
+MODULE_FIRMWARE("intel/vpu/vpu_50xx_v1.bin");
 
 static int ivpu_fw_request(struct ivpu_device *vdev)
 {
diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index c8daffd90f30..6b1bda7e130d 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -26,11 +26,21 @@ static inline void ivpu_dbg_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, con
 {
 	ivpu_dbg(vdev, BO,
 		 "%6s: bo %8p vpu_addr %9llx size %8zu ctx %d has_pages %d dma_mapped %d mmu_mapped %d wc %d imported %d\n",
-		 action, bo, bo->vpu_addr, ivpu_bo_size(bo), bo->ctx ? bo->ctx->id : 0,
+		 action, bo, bo->vpu_addr, ivpu_bo_size(bo), bo->ctx_id,
 		 (bool)bo->base.pages, (bool)bo->base.sgt, bo->mmu_mapped, bo->base.map_wc,
 		 (bool)bo->base.base.import_attach);
 }
 
+static inline int ivpu_bo_lock(struct ivpu_bo *bo)
+{
+	return dma_resv_lock(bo->base.base.resv, NULL);
+}
+
+static inline void ivpu_bo_unlock(struct ivpu_bo *bo)
+{
+	dma_resv_unlock(bo->base.base.resv);
+}
+
 /*
  * ivpu_bo_pin() - pin the backing physical pages and map them to VPU.
  *
@@ -41,22 +51,22 @@ static inline void ivpu_dbg_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, con
 int __must_check ivpu_bo_pin(struct ivpu_bo *bo)
 {
 	struct ivpu_device *vdev = ivpu_bo_to_vdev(bo);
+	struct sg_table *sgt;
 	int ret = 0;
 
-	mutex_lock(&bo->lock);
-
 	ivpu_dbg_bo(vdev, bo, "pin");
-	drm_WARN_ON(&vdev->drm, !bo->ctx);
 
-	if (!bo->mmu_mapped) {
-		struct sg_table *sgt = drm_gem_shmem_get_pages_sgt(&bo->base);
+	sgt = drm_gem_shmem_get_pages_sgt(&bo->base);
+	if (IS_ERR(sgt)) {
+		ret = PTR_ERR(sgt);
+		ivpu_err(vdev, "Failed to map BO in IOMMU: %d\n", ret);
+		return ret;
+	}
 
-		if (IS_ERR(sgt)) {
-			ret = PTR_ERR(sgt);
-			ivpu_err(vdev, "Failed to map BO in IOMMU: %d\n", ret);
-			goto unlock;
-		}
+	ivpu_bo_lock(bo);
 
+	if (!bo->mmu_mapped) {
+		drm_WARN_ON(&vdev->drm, !bo->ctx);
 		ret = ivpu_mmu_context_map_sgt(vdev, bo->ctx, bo->vpu_addr, sgt,
 					       ivpu_bo_is_snooped(bo));
 		if (ret) {
@@ -67,7 +77,7 @@ int __must_check ivpu_bo_pin(struct ivpu_bo *bo)
 	}
 
 unlock:
-	mutex_unlock(&bo->lock);
+	ivpu_bo_unlock(bo);
 
 	return ret;
 }
@@ -82,7 +92,7 @@ ivpu_bo_alloc_vpu_addr(struct ivpu_bo *bo, struct ivpu_mmu_context *ctx,
 	if (!drm_dev_enter(&vdev->drm, &idx))
 		return -ENODEV;
 
-	mutex_lock(&bo->lock);
+	ivpu_bo_lock(bo);
 
 	ret = ivpu_mmu_context_insert_node(ctx, range, ivpu_bo_size(bo), &bo->mm_node);
 	if (!ret) {
@@ -92,9 +102,7 @@ ivpu_bo_alloc_vpu_addr(struct ivpu_bo *bo, struct ivpu_mmu_context *ctx,
 		ivpu_err(vdev, "Failed to add BO to context %u: %d\n", ctx->id, ret);
 	}
 
-	ivpu_dbg_bo(vdev, bo, "alloc");
-
-	mutex_unlock(&bo->lock);
+	ivpu_bo_unlock(bo);
 
 	drm_dev_exit(idx);
 
@@ -105,7 +113,7 @@ static void ivpu_bo_unbind_locked(struct ivpu_bo *bo)
 {
 	struct ivpu_device *vdev = ivpu_bo_to_vdev(bo);
 
-	lockdep_assert(lockdep_is_held(&bo->lock) || !kref_read(&bo->base.base.refcount));
+	lockdep_assert(dma_resv_held(bo->base.base.resv) || !kref_read(&bo->base.base.refcount));
 
 	if (bo->mmu_mapped) {
 		drm_WARN_ON(&vdev->drm, !bo->ctx);
@@ -123,14 +131,12 @@ static void ivpu_bo_unbind_locked(struct ivpu_bo *bo)
 	if (bo->base.base.import_attach)
 		return;
 
-	dma_resv_lock(bo->base.base.resv, NULL);
 	if (bo->base.sgt) {
 		dma_unmap_sgtable(vdev->drm.dev, bo->base.sgt, DMA_BIDIRECTIONAL, 0);
 		sg_free_table(bo->base.sgt);
 		kfree(bo->base.sgt);
 		bo->base.sgt = NULL;
 	}
-	dma_resv_unlock(bo->base.base.resv);
 }
 
 void ivpu_bo_unbind_all_bos_from_context(struct ivpu_device *vdev, struct ivpu_mmu_context *ctx)
@@ -142,12 +148,12 @@ void ivpu_bo_unbind_all_bos_from_context(struct ivpu_device *vdev, struct ivpu_m
 
 	mutex_lock(&vdev->bo_list_lock);
 	list_for_each_entry(bo, &vdev->bo_list, bo_list_node) {
-		mutex_lock(&bo->lock);
+		ivpu_bo_lock(bo);
 		if (bo->ctx == ctx) {
 			ivpu_dbg_bo(vdev, bo, "unbind");
 			ivpu_bo_unbind_locked(bo);
 		}
-		mutex_unlock(&bo->lock);
+		ivpu_bo_unlock(bo);
 	}
 	mutex_unlock(&vdev->bo_list_lock);
 }
@@ -167,12 +173,11 @@ struct drm_gem_object *ivpu_gem_create_object(struct drm_device *dev, size_t siz
 	bo->base.pages_mark_dirty_on_put = true; /* VPU can dirty a BO anytime */
 
 	INIT_LIST_HEAD(&bo->bo_list_node);
-	mutex_init(&bo->lock);
 
 	return &bo->base.base;
 }
 
-static struct ivpu_bo *ivpu_bo_alloc(struct ivpu_device *vdev, u64 size, u32 flags)
+static struct ivpu_bo *ivpu_bo_alloc(struct ivpu_device *vdev, u64 size, u32 flags, u32 ctx_id)
 {
 	struct drm_gem_shmem_object *shmem;
 	struct ivpu_bo *bo;
@@ -190,6 +195,7 @@ static struct ivpu_bo *ivpu_bo_alloc(struct ivpu_device *vdev, u64 size, u32 fla
 		return ERR_CAST(shmem);
 
 	bo = to_ivpu_bo(&shmem->base);
+	bo->ctx_id = ctx_id;
 	bo->base.map_wc = flags & DRM_IVPU_BO_WC;
 	bo->flags = flags;
 
@@ -197,6 +203,8 @@ static struct ivpu_bo *ivpu_bo_alloc(struct ivpu_device *vdev, u64 size, u32 fla
 	list_add_tail(&bo->bo_list_node, &vdev->bo_list);
 	mutex_unlock(&vdev->bo_list_lock);
 
+	ivpu_dbg_bo(vdev, bo, "alloc");
+
 	return bo;
 }
 
@@ -234,10 +242,14 @@ static void ivpu_gem_bo_free(struct drm_gem_object *obj)
 	list_del(&bo->bo_list_node);
 	mutex_unlock(&vdev->bo_list_lock);
 
-	drm_WARN_ON(&vdev->drm, !dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_READ));
+	drm_WARN_ON(&vdev->drm, !drm_gem_is_imported(&bo->base.base) &&
+		    !dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_READ));
+	drm_WARN_ON(&vdev->drm, ivpu_bo_size(bo) == 0);
+	drm_WARN_ON(&vdev->drm, bo->base.vaddr);
 
 	ivpu_bo_unbind_locked(bo);
-	mutex_destroy(&bo->lock);
+	drm_WARN_ON(&vdev->drm, bo->mmu_mapped);
+	drm_WARN_ON(&vdev->drm, bo->ctx);
 
 	drm_WARN_ON(obj->dev, bo->base.pages_use_count > 1);
 	drm_gem_shmem_free(&bo->base);
@@ -271,7 +283,7 @@ int ivpu_bo_create_ioctl(struct drm_device *dev, void *data, struct drm_file *fi
 	if (size == 0)
 		return -EINVAL;
 
-	bo = ivpu_bo_alloc(vdev, size, args->flags);
+	bo = ivpu_bo_alloc(vdev, size, args->flags, file_priv->ctx.id);
 	if (IS_ERR(bo)) {
 		ivpu_err(vdev, "Failed to allocate BO: %pe (ctx %u size %llu flags 0x%x)",
 			 bo, file_priv->ctx.id, args->size, args->flags);
@@ -279,7 +291,10 @@ int ivpu_bo_create_ioctl(struct drm_device *dev, void *data, struct drm_file *fi
 	}
 
 	ret = drm_gem_handle_create(file, &bo->base.base, &args->handle);
-	if (!ret)
+	if (ret)
+		ivpu_err(vdev, "Failed to create handle for BO: %pe (ctx %u size %llu flags 0x%x)",
+			 bo, file_priv->ctx.id, args->size, args->flags);
+	else
 		args->vpu_addr = bo->vpu_addr;
 
 	drm_gem_object_put(&bo->base.base);
@@ -302,7 +317,7 @@ ivpu_bo_create(struct ivpu_device *vdev, struct ivpu_mmu_context *ctx,
 	drm_WARN_ON(&vdev->drm, !PAGE_ALIGNED(range->end));
 	drm_WARN_ON(&vdev->drm, !PAGE_ALIGNED(size));
 
-	bo = ivpu_bo_alloc(vdev, size, flags);
+	bo = ivpu_bo_alloc(vdev, size, flags, IVPU_GLOBAL_CONTEXT_MMU_SSID);
 	if (IS_ERR(bo)) {
 		ivpu_err(vdev, "Failed to allocate BO: %pe (vpu_addr 0x%llx size %llu flags 0x%x)",
 			 bo, range->start, size, flags);
@@ -318,9 +333,9 @@ ivpu_bo_create(struct ivpu_device *vdev, struct ivpu_mmu_context *ctx,
 		goto err_put;
 
 	if (flags & DRM_IVPU_BO_MAPPABLE) {
-		dma_resv_lock(bo->base.base.resv, NULL);
+		ivpu_bo_lock(bo);
 		ret = drm_gem_shmem_vmap(&bo->base, &map);
-		dma_resv_unlock(bo->base.base.resv);
+		ivpu_bo_unlock(bo);
 
 		if (ret)
 			goto err_put;
@@ -343,9 +358,9 @@ void ivpu_bo_free(struct ivpu_bo *bo)
 	struct iosys_map map = IOSYS_MAP_INIT_VADDR(bo->base.vaddr);
 
 	if (bo->flags & DRM_IVPU_BO_MAPPABLE) {
-		dma_resv_lock(bo->base.base.resv, NULL);
+		ivpu_bo_lock(bo);
 		drm_gem_shmem_vunmap(&bo->base, &map);
-		dma_resv_unlock(bo->base.base.resv);
+		ivpu_bo_unlock(bo);
 	}
 
 	drm_gem_object_put(&bo->base.base);
@@ -364,12 +379,12 @@ int ivpu_bo_info_ioctl(struct drm_device *dev, void *data, struct drm_file *file
 
 	bo = to_ivpu_bo(obj);
 
-	mutex_lock(&bo->lock);
+	ivpu_bo_lock(bo);
 	args->flags = bo->flags;
 	args->mmap_offset = drm_vma_node_offset_addr(&obj->vma_node);
 	args->vpu_addr = bo->vpu_addr;
 	args->size = obj->size;
-	mutex_unlock(&bo->lock);
+	ivpu_bo_unlock(bo);
 
 	drm_gem_object_put(obj);
 	return ret;
@@ -403,10 +418,10 @@ int ivpu_bo_wait_ioctl(struct drm_device *dev, void *data, struct drm_file *file
 
 static void ivpu_bo_print_info(struct ivpu_bo *bo, struct drm_printer *p)
 {
-	mutex_lock(&bo->lock);
+	ivpu_bo_lock(bo);
 
 	drm_printf(p, "%-9p %-3u 0x%-12llx %-10lu 0x%-8x %-4u",
-		   bo, bo->ctx ? bo->ctx->id : 0, bo->vpu_addr, bo->base.base.size,
+		   bo, bo->ctx_id, bo->vpu_addr, bo->base.base.size,
 		   bo->flags, kref_read(&bo->base.base.refcount));
 
 	if (bo->base.pages)
@@ -420,7 +435,7 @@ static void ivpu_bo_print_info(struct ivpu_bo *bo, struct drm_printer *p)
 
 	drm_printf(p, "\n");
 
-	mutex_unlock(&bo->lock);
+	ivpu_bo_unlock(bo);
 }
 
 void ivpu_bo_list(struct drm_device *dev, struct drm_printer *p)
diff --git a/drivers/accel/ivpu/ivpu_gem.h b/drivers/accel/ivpu/ivpu_gem.h
index d975000abd78..07bffe98c963 100644
--- a/drivers/accel/ivpu/ivpu_gem.h
+++ b/drivers/accel/ivpu/ivpu_gem.h
@@ -17,10 +17,10 @@ struct ivpu_bo {
 	struct list_head bo_list_node;
 	struct drm_mm_node mm_node;
 
-	struct mutex lock; /* Protects: ctx, mmu_mapped, vpu_addr */
 	u64 vpu_addr;
 	u32 flags;
 	u32 job_status; /* Valid only for command buffer */
+	u32 ctx_id;
 	bool mmu_mapped;
 };
 
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index 4e88f9fc2a28..b6588b7fa898 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -504,10 +504,6 @@ struct aml_resource_pin_group_config {
 
 #define AML_RESOURCE_PIN_GROUP_CONFIG_REVISION    1	/* ACPI 6.2 */
 
-/* restore default alignment */
-
-#pragma pack()
-
 /* Union of all resource descriptors, so we can allocate the worst case */
 
 union aml_resource {
@@ -562,6 +558,10 @@ union aml_resource {
 	u8 byte_item;
 };
 
+/* restore default alignment */
+
+#pragma pack()
+
 /* Interfaces used by both the disassembler and compiler */
 
 void
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index fb9ed5e1da89..2bdae8a25e08 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -668,6 +668,8 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 	union acpi_parse_object *arguments[ACPI_OBJ_NUM_OPERANDS];
 	u32 arg_count = 0;
 	u32 index = walk_state->num_operands;
+	u32 prev_num_operands = walk_state->num_operands;
+	u32 new_num_operands;
 	u32 i;
 
 	ACPI_FUNCTION_TRACE_PTR(ds_create_operands, first_arg);
@@ -696,6 +698,7 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 
 	/* Create the interpreter arguments, in reverse order */
 
+	new_num_operands = index;
 	index--;
 	for (i = 0; i < arg_count; i++) {
 		arg = arguments[index];
@@ -720,7 +723,11 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 	 * pop everything off of the operand stack and delete those
 	 * objects
 	 */
-	acpi_ds_obj_stack_pop_and_delete(arg_count, walk_state);
+	walk_state->num_operands = i;
+	acpi_ds_obj_stack_pop_and_delete(new_num_operands, walk_state);
+
+	/* Restore operand count */
+	walk_state->num_operands = prev_num_operands;
 
 	ACPI_EXCEPTION((AE_INFO, status, "While creating Arg %u", index));
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 54471083ba54..0bce1baaa62b 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -636,7 +636,8 @@ acpi_status
 acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 			  union acpi_parse_object *op, acpi_status status)
 {
-	acpi_status status2;
+	acpi_status return_status = status;
+	u8 ascending = TRUE;
 
 	ACPI_FUNCTION_TRACE_PTR(ps_complete_final_op, walk_state);
 
@@ -650,7 +651,7 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 			  op));
 	do {
 		if (op) {
-			if (walk_state->ascending_callback != NULL) {
+			if (ascending && walk_state->ascending_callback != NULL) {
 				walk_state->op = op;
 				walk_state->op_info =
 				    acpi_ps_get_opcode_info(op->common.
@@ -672,49 +673,26 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 				}
 
 				if (status == AE_CTRL_TERMINATE) {
-					status = AE_OK;
-
-					/* Clean up */
-					do {
-						if (op) {
-							status2 =
-							    acpi_ps_complete_this_op
-							    (walk_state, op);
-							if (ACPI_FAILURE
-							    (status2)) {
-								return_ACPI_STATUS
-								    (status2);
-							}
-						}
-
-						acpi_ps_pop_scope(&
-								  (walk_state->
-								   parser_state),
-								  &op,
-								  &walk_state->
-								  arg_types,
-								  &walk_state->
-								  arg_count);
-
-					} while (op);
-
-					return_ACPI_STATUS(status);
+					ascending = FALSE;
+					return_status = AE_CTRL_TERMINATE;
 				}
 
 				else if (ACPI_FAILURE(status)) {
 
 					/* First error is most important */
 
-					(void)
-					    acpi_ps_complete_this_op(walk_state,
-								     op);
-					return_ACPI_STATUS(status);
+					ascending = FALSE;
+					return_status = status;
 				}
 			}
 
-			status2 = acpi_ps_complete_this_op(walk_state, op);
-			if (ACPI_FAILURE(status2)) {
-				return_ACPI_STATUS(status2);
+			status = acpi_ps_complete_this_op(walk_state, op);
+			if (ACPI_FAILURE(status)) {
+				ascending = FALSE;
+				if (ACPI_SUCCESS(return_status) ||
+				    return_status == AE_CTRL_TERMINATE) {
+					return_status = status;
+				}
 			}
 		}
 
@@ -724,5 +702,5 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 
 	} while (op);
 
-	return_ACPI_STATUS(status);
+	return_ACPI_STATUS(return_status);
 }
diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index 27384ee245f0..f92010e667cd 100644
--- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -272,18 +272,13 @@ u8
 acpi_rs_get_address_common(struct acpi_resource *resource,
 			   union aml_resource *aml)
 {
-	struct aml_resource_address address;
-
 	ACPI_FUNCTION_ENTRY();
 
-	/* Avoid undefined behavior: member access within misaligned address */
-
-	memcpy(&address, aml, sizeof(address));
-
 	/* Validate the Resource Type */
 
-	if ((address.resource_type > 2) &&
-	    (address.resource_type < 0xC0) && (address.resource_type != 0x0A)) {
+	if ((aml->address.resource_type > 2) &&
+	    (aml->address.resource_type < 0xC0) &&
+	    (aml->address.resource_type != 0x0A)) {
 		return (FALSE);
 	}
 
@@ -304,7 +299,7 @@ acpi_rs_get_address_common(struct acpi_resource *resource,
 		/* Generic resource type, just grab the type_specific byte */
 
 		resource->data.address.info.type_specific =
-		    address.specific_flags;
+		    aml->address.specific_flags;
 	}
 
 	return (TRUE);
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 6e7a152d6459..242daf45e20e 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -608,18 +608,12 @@ acpi_rs_get_list_length(u8 *aml_buffer,
 
 		case ACPI_RESOURCE_NAME_SERIAL_BUS:{
 
-				/* Avoid undefined behavior: member access within misaligned address */
-
-				struct aml_resource_common_serialbus
-				    common_serial_bus;
-				memcpy(&common_serial_bus, aml_resource,
-				       sizeof(common_serial_bus));
-
 				minimum_aml_resource_length =
 				    acpi_gbl_resource_aml_serial_bus_sizes
-				    [common_serial_bus.type];
+				    [aml_resource->common_serial_bus.type];
 				extra_struct_bytes +=
-				    common_serial_bus.resource_length -
+				    aml_resource->common_serial_bus.
+				    resource_length -
 				    minimum_aml_resource_length;
 				break;
 			}
@@ -688,16 +682,10 @@ acpi_rs_get_list_length(u8 *aml_buffer,
 		 */
 		if (acpi_ut_get_resource_type(aml_buffer) ==
 		    ACPI_RESOURCE_NAME_SERIAL_BUS) {
-
-			/* Avoid undefined behavior: member access within misaligned address */
-
-			struct aml_resource_common_serialbus common_serial_bus;
-			memcpy(&common_serial_bus, aml_resource,
-			       sizeof(common_serial_bus));
-
 			buffer_size =
 			    acpi_gbl_resource_struct_serial_bus_sizes
-			    [common_serial_bus.type] + extra_struct_bytes;
+			    [aml_resource->common_serial_bus.type] +
+			    extra_struct_bytes;
 		} else {
 			buffer_size =
 			    acpi_gbl_resource_struct_sizes[resource_index] +
diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index 164c96e063c6..e46efaa889cd 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -55,21 +55,15 @@ acpi_rs_convert_aml_to_resources(u8 * aml,
 	aml_resource = ACPI_CAST_PTR(union aml_resource, aml);
 
 	if (acpi_ut_get_resource_type(aml) == ACPI_RESOURCE_NAME_SERIAL_BUS) {
-
-		/* Avoid undefined behavior: member access within misaligned address */
-
-		struct aml_resource_common_serialbus common_serial_bus;
-		memcpy(&common_serial_bus, aml_resource,
-		       sizeof(common_serial_bus));
-
-		if (common_serial_bus.type > AML_RESOURCE_MAX_SERIALBUSTYPE) {
+		if (aml_resource->common_serial_bus.type >
+		    AML_RESOURCE_MAX_SERIALBUSTYPE) {
 			conversion_table = NULL;
 		} else {
 			/* This is an I2C, SPI, UART, or CSI2 serial_bus descriptor */
 
 			conversion_table =
 			    acpi_gbl_convert_resource_serial_bus_dispatch
-			    [common_serial_bus.type];
+			    [aml_resource->common_serial_bus.type];
 		}
 	} else {
 		conversion_table =
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 42b30b9f9312..7fad03c5252c 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -333,11 +333,8 @@ int vsnprintf(char *string, acpi_size size, const char *format, va_list args)
 
 	pos = string;
 
-	if (size != ACPI_UINT32_MAX) {
-		end = string + size;
-	} else {
-		end = ACPI_CAST_PTR(char, ACPI_UINT32_MAX);
-	}
+	size = ACPI_MIN(size, ACPI_PTR_DIFF(ACPI_MAX_PTR, string));
+	end = string + size;
 
 	for (; *format; ++format) {
 		if (*format != '%') {
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index cff7901f7866..e1cc3d348750 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -361,20 +361,16 @@ acpi_ut_validate_resource(struct acpi_walk_state *walk_state,
 	aml_resource = ACPI_CAST_PTR(union aml_resource, aml);
 	if (resource_type == ACPI_RESOURCE_NAME_SERIAL_BUS) {
 
-		/* Avoid undefined behavior: member access within misaligned address */
-
-		struct aml_resource_common_serialbus common_serial_bus;
-		memcpy(&common_serial_bus, aml_resource,
-		       sizeof(common_serial_bus));
-
 		/* Validate the bus_type field */
 
-		if ((common_serial_bus.type == 0) ||
-		    (common_serial_bus.type > AML_RESOURCE_MAX_SERIALBUSTYPE)) {
+		if ((aml_resource->common_serial_bus.type == 0) ||
+		    (aml_resource->common_serial_bus.type >
+		     AML_RESOURCE_MAX_SERIALBUSTYPE)) {
 			if (walk_state) {
 				ACPI_ERROR((AE_INFO,
 					    "Invalid/unsupported SerialBus resource descriptor: BusType 0x%2.2X",
-					    common_serial_bus.type));
+					    aml_resource->common_serial_bus.
+					    type));
 			}
 			return (AE_AML_INVALID_RESOURCE_TYPE);
 		}
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 65fa3444367a..6a7ac34d73bd 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -243,10 +243,23 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
+		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN) {
 			ret = -ENODEV;
-		else
-			val->intval = battery->rate_now * 1000;
+			break;
+		}
+
+		val->intval = battery->rate_now * 1000;
+		/*
+		 * When discharging, the current should be reported as a
+		 * negative number as per the power supply class interface
+		 * definition.
+		 */
+		if (psp == POWER_SUPPLY_PROP_CURRENT_NOW &&
+		    (battery->state & ACPI_BATTERY_STATE_DISCHARGING) &&
+		    acpi_battery_handle_discharging(battery)
+				== POWER_SUPPLY_STATUS_DISCHARGING)
+			val->intval = -val->intval;
+
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 16917dc3ad60..6234055d2598 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1444,8 +1444,10 @@ static int __init acpi_init(void)
 	}
 
 	acpi_kobj = kobject_create_and_add("acpi", firmware_kobj);
-	if (!acpi_kobj)
-		pr_debug("%s: kset create error\n", __func__);
+	if (!acpi_kobj) {
+		pr_err("Failed to register kobject\n");
+		return -ENOMEM;
+	}
 
 	init_prmt();
 	acpi_init_pcc();
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 650122deb480..395240cb3666 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1410,8 +1410,15 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 
 static bool ahci_broken_lpm(struct pci_dev *pdev)
 {
+	/*
+	 * Platforms with LPM problems.
+	 * If driver_data is NULL, there is no existing BIOS version with
+	 * functioning LPM.
+	 * If driver_data is non-NULL, then driver_data contains the DMI BIOS
+	 * build date of the first BIOS version with functioning LPM (i.e. older
+	 * BIOS versions have broken LPM).
+	 */
 	static const struct dmi_system_id sysids[] = {
-		/* Various Lenovo 50 series have LPM issues with older BIOSen */
 		{
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
@@ -1446,6 +1453,29 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 			 */
 			.driver_data = "20180310", /* 2.35 */
 		},
+		{
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_PRODUCT_VERSION, "ASUSPRO D840MB_M840SA"),
+			},
+			/* 320 is broken, there is no known good version. */
+		},
+		{
+			/*
+			 * AMD 500 Series Chipset SATA Controller [1022:43eb]
+			 * on this motherboard timeouts on ports 5 and 6 when
+			 * LPM is enabled, at least with WDC WD20EFAX-68FB5N0
+			 * hard drives. LPM with the same drive works fine on
+			 * all other ports on the same controller.
+			 */
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR,
+					  "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_BOARD_NAME,
+					  "ROG STRIX B550-F GAMING (WI-FI)"),
+			},
+			/* 3621 is broken, there is no known good version. */
+		},
 		{ }	/* terminate list */
 	};
 	const struct dmi_system_id *dmi = dmi_first_match(sysids);
@@ -1455,6 +1485,9 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 	if (!dmi)
 		return false;
 
+	if (!dmi->driver_data)
+		return true;
+
 	dmi_get_date(DMI_BIOS_DATE, &year, &month, &date);
 	snprintf(buf, sizeof(buf), "%04d%02d%02d", year, month, date);
 
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 696b99720dcb..d82728a01832 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -368,7 +368,8 @@ static unsigned int via_mode_filter(struct ata_device *dev, unsigned int mask)
 	}
 
 	if (dev->class == ATA_DEV_ATAPI &&
-	    dmi_check_system(no_atapi_dma_dmi_table)) {
+	    (dmi_check_system(no_atapi_dma_dmi_table) ||
+	     config->id == PCI_DEVICE_ID_VIA_6415)) {
 		ata_dev_warn(dev, "controller locks up on ATAPI DMA, forcing PIO\n");
 		mask &= ATA_MASK_PIO;
 	}
diff --git a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
index d4aa0f353b6c..eeae160c898d 100644
--- a/drivers/atm/atmtcp.c
+++ b/drivers/atm/atmtcp.c
@@ -288,7 +288,9 @@ static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 	struct sk_buff *new_skb;
 	int result = 0;
 
-	if (!skb->len) return 0;
+	if (skb->len < sizeof(struct atmtcp_hdr))
+		goto done;
+
 	dev = vcc->dev_data;
 	hdr = (struct atmtcp_hdr *) skb->data;
 	if (hdr->length == ATMTCP_HDR_MAGIC) {
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 0e60dd650b5e..70db08f3ac6f 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -95,5 +95,6 @@ EXPORT_SYMBOL_GPL(platform_device_msi_init_and_alloc_irqs);
 void platform_device_msi_free_irqs_all(struct device *dev)
 {
 	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
+	msi_remove_device_irq_domain(dev, MSI_DEFAULT_DOMAIN);
 }
 EXPORT_SYMBOL_GPL(platform_device_msi_free_irqs_all);
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 04113adb092b..99f25d6b2027 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1003,7 +1003,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 	 * If 'expires' is after the current time, we've been called
 	 * too early.
 	 */
-	if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
+	if (expires > 0 && expires <= ktime_get_mono_fast_ns()) {
 		dev->power.timer_expires = 0;
 		rpm_suspend(dev, dev->power.timer_autosuspends ?
 		    (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index eb6eb25b343b..53b3f0061ad1 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -529,7 +529,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	if (prop->is_inline)
 		return -EINVAL;
 
-	if (index * sizeof(*ref) >= prop->length)
+	if ((index + 1) * sizeof(*ref) > prop->length)
 		return -ENOENT;
 
 	ref_array = prop->pointer;
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 3523dd82d7a0..280679bde3a5 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -198,6 +198,7 @@ aoedev_downdev(struct aoedev *d)
 {
 	struct aoetgt *t, **tt, **te;
 	struct list_head *head, *pos, *nx;
+	struct request *rq, *rqnext;
 	int i;
 
 	d->flags &= ~DEVFL_UP;
@@ -223,6 +224,13 @@ aoedev_downdev(struct aoedev *d)
 	/* clean out the in-process request (if any) */
 	aoe_failip(d);
 
+	/* clean out any queued block requests */
+	list_for_each_entry_safe(rq, rqnext, &d->rq_list, queuelist) {
+		list_del_init(&rq->queuelist);
+		blk_mq_start_request(rq);
+		blk_mq_end_request(rq, BLK_STS_IOERR);
+	}
+
 	/* fast fail all pending I/O */
 	if (d->blkq) {
 		/* UP is cleared, freeze+quiesce to insure all are errored */
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a01a547c562f..746ef36e58df 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2457,6 +2457,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	if (copy_from_user(&info, argp, sizeof(info)))
 		return -EFAULT;
 
+	if (info.queue_depth > UBLK_MAX_QUEUE_DEPTH || info.nr_hw_queues > UBLK_MAX_NR_QUEUES)
+		return -EINVAL;
+
 	if (capable(CAP_SYS_ADMIN))
 		info.flags &= ~UBLK_F_UNPRIVILEGED_DEV;
 	else if (!(info.flags & UBLK_F_UNPRIVILEGED_DEV))
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index af2be0271806..aa6385206050 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -672,6 +672,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3568), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3584), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3605), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3607), .driver_info = BTUSB_MEDIATEK |
@@ -712,6 +714,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3628), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3630), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
diff --git a/drivers/bus/fsl-mc/fsl-mc-uapi.c b/drivers/bus/fsl-mc/fsl-mc-uapi.c
index 9c4c1395fcdb..a376ec661653 100644
--- a/drivers/bus/fsl-mc/fsl-mc-uapi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-uapi.c
@@ -275,13 +275,13 @@ static struct fsl_mc_cmd_desc fsl_mc_accepted_cmds[] = {
 		.size = 8,
 	},
 	[DPSW_GET_TAILDROP] = {
-		.cmdid_value = 0x0A80,
+		.cmdid_value = 0x0A90,
 		.cmdid_mask = 0xFFF0,
 		.token = true,
 		.size = 14,
 	},
 	[DPSW_SET_TAILDROP] = {
-		.cmdid_value = 0x0A90,
+		.cmdid_value = 0x0A80,
 		.cmdid_mask = 0xFFF0,
 		.token = true,
 		.size = 24,
diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
index 95b10a6cf307..8b7a34f4db94 100644
--- a/drivers/bus/fsl-mc/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -214,12 +214,19 @@ int __must_check fsl_mc_portal_allocate(struct fsl_mc_device *mc_dev,
 	if (error < 0)
 		goto error_cleanup_resource;
 
-	dpmcp_dev->consumer_link = device_link_add(&mc_dev->dev,
-						   &dpmcp_dev->dev,
-						   DL_FLAG_AUTOREMOVE_CONSUMER);
-	if (!dpmcp_dev->consumer_link) {
-		error = -EINVAL;
-		goto error_cleanup_mc_io;
+	/* If the DPRC device itself tries to allocate a portal (usually for
+	 * UAPI interaction), don't add a device link between them since the
+	 * DPMCP device is an actual child device of the DPRC and a reverse
+	 * dependency is not allowed.
+	 */
+	if (mc_dev != mc_bus_dev) {
+		dpmcp_dev->consumer_link = device_link_add(&mc_dev->dev,
+							   &dpmcp_dev->dev,
+							   DL_FLAG_AUTOREMOVE_CONSUMER);
+		if (!dpmcp_dev->consumer_link) {
+			error = -EINVAL;
+			goto error_cleanup_mc_io;
+		}
 	}
 
 	*new_mc_io = mc_io;
diff --git a/drivers/bus/fsl-mc/mc-sys.c b/drivers/bus/fsl-mc/mc-sys.c
index f2052cd0a051..b22c59d57c8f 100644
--- a/drivers/bus/fsl-mc/mc-sys.c
+++ b/drivers/bus/fsl-mc/mc-sys.c
@@ -19,7 +19,7 @@
 /*
  * Timeout in milliseconds to wait for the completion of an MC command
  */
-#define MC_CMD_COMPLETION_TIMEOUT_MS	500
+#define MC_CMD_COMPLETION_TIMEOUT_MS	15000
 
 /*
  * usleep_range() min and max values used to throttle down polling
diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
index aeb53b2c34a8..26357ee68dee 100644
--- a/drivers/bus/mhi/ep/ring.c
+++ b/drivers/bus/mhi/ep/ring.c
@@ -131,19 +131,23 @@ int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ring_element *e
 	}
 
 	old_offset = ring->rd_offset;
-	mhi_ep_ring_inc_index(ring);
 
 	dev_dbg(dev, "Adding an element to ring at offset (%zu)\n", ring->rd_offset);
+	buf_info.host_addr = ring->rbase + (old_offset * sizeof(*el));
+	buf_info.dev_addr = el;
+	buf_info.size = sizeof(*el);
+
+	ret = mhi_cntrl->write_sync(mhi_cntrl, &buf_info);
+	if (ret)
+		return ret;
+
+	mhi_ep_ring_inc_index(ring);
 
 	/* Update rp in ring context */
 	rp = cpu_to_le64(ring->rd_offset * sizeof(*el) + ring->rbase);
 	memcpy_toio((void __iomem *) &ring->ring_ctx->generic.rp, &rp, sizeof(u64));
 
-	buf_info.host_addr = ring->rbase + (old_offset * sizeof(*el));
-	buf_info.dev_addr = el;
-	buf_info.size = sizeof(*el);
-
-	return mhi_cntrl->write_sync(mhi_cntrl, &buf_info);
+	return ret;
 }
 
 void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id)
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 11c0e751f223..0ccbcb717955 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -602,6 +602,7 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
 	struct mhi_cmd *mhi_cmd;
 	struct mhi_event_ctxt *er_ctxt;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	bool reset_device = false;
 	int ret, i;
 
 	dev_dbg(dev, "Transitioning from PM state: %s to: %s\n",
@@ -630,8 +631,23 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
 	/* Wake up threads waiting for state transition */
 	wake_up_all(&mhi_cntrl->state_event);
 
-	/* Trigger MHI RESET so that the device will not access host memory */
 	if (MHI_REG_ACCESS_VALID(prev_state)) {
+		/*
+		 * If the device is in PBL or SBL, it will only respond to
+		 * RESET if the device is in SYSERR state. SYSERR might
+		 * already be cleared at this point.
+		 */
+		enum mhi_state cur_state = mhi_get_mhi_state(mhi_cntrl);
+		enum mhi_ee_type cur_ee = mhi_get_exec_env(mhi_cntrl);
+
+		if (cur_state == MHI_STATE_SYS_ERR)
+			reset_device = true;
+		else if (cur_ee != MHI_EE_PBL && cur_ee != MHI_EE_SBL)
+			reset_device = true;
+	}
+
+	/* Trigger MHI RESET so that the device will not access host memory */
+	if (reset_device) {
 		u32 in_reset = -1;
 		unsigned long timeout = msecs_to_jiffies(mhi_cntrl->timeout_ms);
 
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 270a94a06e05..f715c8d28129 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -677,51 +677,6 @@ static int sysc_parse_and_check_child_range(struct sysc *ddata)
 	return 0;
 }
 
-/* Interconnect instances to probe before l4_per instances */
-static struct resource early_bus_ranges[] = {
-	/* am3/4 l4_wkup */
-	{ .start = 0x44c00000, .end = 0x44c00000 + 0x300000, },
-	/* omap4/5 and dra7 l4_cfg */
-	{ .start = 0x4a000000, .end = 0x4a000000 + 0x300000, },
-	/* omap4 l4_wkup */
-	{ .start = 0x4a300000, .end = 0x4a300000 + 0x30000,  },
-	/* omap5 and dra7 l4_wkup without dra7 dcan segment */
-	{ .start = 0x4ae00000, .end = 0x4ae00000 + 0x30000,  },
-};
-
-static atomic_t sysc_defer = ATOMIC_INIT(10);
-
-/**
- * sysc_defer_non_critical - defer non_critical interconnect probing
- * @ddata: device driver data
- *
- * We want to probe l4_cfg and l4_wkup interconnect instances before any
- * l4_per instances as l4_per instances depend on resources on l4_cfg and
- * l4_wkup interconnects.
- */
-static int sysc_defer_non_critical(struct sysc *ddata)
-{
-	struct resource *res;
-	int i;
-
-	if (!atomic_read(&sysc_defer))
-		return 0;
-
-	for (i = 0; i < ARRAY_SIZE(early_bus_ranges); i++) {
-		res = &early_bus_ranges[i];
-		if (ddata->module_pa >= res->start &&
-		    ddata->module_pa <= res->end) {
-			atomic_set(&sysc_defer, 0);
-
-			return 0;
-		}
-	}
-
-	atomic_dec_if_positive(&sysc_defer);
-
-	return -EPROBE_DEFER;
-}
-
 static struct device_node *stdout_path;
 
 static void sysc_init_stdout_path(struct sysc *ddata)
@@ -947,10 +902,6 @@ static int sysc_map_and_check_registers(struct sysc *ddata)
 	if (error)
 		return error;
 
-	error = sysc_defer_non_critical(ddata);
-	if (error)
-		return error;
-
 	sysc_check_children(ddata);
 
 	if (!of_property_present(np, "reg"))
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 4f92b83965d5..b72eebd0fa47 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -4099,6 +4099,7 @@ static const struct clk_parent_data spicc_sclk_parent_data[] = {
 	{ .hw = &g12a_clk81.hw },
 	{ .hw = &g12a_fclk_div4.hw },
 	{ .hw = &g12a_fclk_div3.hw },
+	{ .hw = &g12a_fclk_div2.hw },
 	{ .hw = &g12a_fclk_div5.hw },
 	{ .hw = &g12a_fclk_div7.hw },
 };
diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index 009f39139b64..3e44757e25d3 100644
--- a/drivers/clk/qcom/gcc-x1e80100.c
+++ b/drivers/clk/qcom/gcc-x1e80100.c
@@ -6753,6 +6753,10 @@ static int gcc_x1e80100_probe(struct platform_device *pdev)
 	/* Clear GDSC_SLEEP_ENA_VOTE to stop votes being auto-removed in sleep. */
 	regmap_write(regmap, 0x52224, 0x0);
 
+	/* FORCE_MEM_CORE_ON for ufs phy ice core and gcc ufs phy axi clocks  */
+	qcom_branch_set_force_mem_core(regmap, gcc_ufs_phy_ice_core_clk, true);
+	qcom_branch_set_force_mem_core(regmap, gcc_ufs_phy_axi_clk, true);
+
 	return qcom_cc_really_probe(&pdev->dev, &gcc_x1e80100_desc, regmap);
 }
 
diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index d341ce0708aa..e4af3a928637 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -431,6 +431,7 @@ static const char *const rk3036_critical_clocks[] __initconst = {
 	"hclk_peri",
 	"pclk_peri",
 	"pclk_ddrupctl",
+	"ddrphy",
 };
 
 static void __init rk3036_clk_init(struct device_node *np)
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7a16d1932228..62dbc5701e99 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -482,6 +482,9 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
+	if (!policy)
+		return;
+
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
 			cpudata->max_limit_perf);
 	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 7e7c1613a67c..beb660ca240c 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -367,6 +367,40 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.register_em	= scmi_cpufreq_register_em,
 };
 
+static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
+{
+	struct device_node *scmi_np = dev_of_node(scmi_dev);
+	struct device_node *cpu_np, *np;
+	struct device *cpu_dev;
+	int cpu, idx;
+
+	if (!scmi_np)
+		return false;
+
+	for_each_possible_cpu(cpu) {
+		cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev)
+			continue;
+
+		cpu_np = dev_of_node(cpu_dev);
+
+		np = of_parse_phandle(cpu_np, "clocks", 0);
+		of_node_put(np);
+
+		if (np == scmi_np)
+			return true;
+
+		idx = of_property_match_string(cpu_np, "power-domain-names", "perf");
+		np = of_parse_phandle(cpu_np, "power-domains", idx);
+		of_node_put(np);
+
+		if (np == scmi_np)
+			return true;
+	}
+
+	return false;
+}
+
 static int scmi_cpufreq_probe(struct scmi_device *sdev)
 {
 	int ret;
@@ -375,7 +409,7 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 
 	handle = sdev->handle;
 
-	if (!handle)
+	if (!handle || !scmi_dev_used_by_cpus(dev))
 		return -ENODEV;
 
 	perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_drv.c b/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
index f49818a13013..41420e349572 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
@@ -181,11 +181,19 @@ static void adf_remove(struct pci_dev *pdev)
 	adf_cleanup_accel(accel_dev);
 }
 
+static void adf_shutdown(struct pci_dev *pdev)
+{
+	struct adf_accel_dev *accel_dev = adf_devmgr_pci_to_accel_dev(pdev);
+
+	adf_dev_down(accel_dev);
+}
+
 static struct pci_driver adf_driver = {
 	.id_table = adf_pci_tbl,
 	.name = ADF_420XX_DEVICE_NAME,
 	.probe = adf_probe,
 	.remove = adf_remove,
+	.shutdown = adf_shutdown,
 	.sriov_configure = adf_sriov_configure,
 	.err_handler = &adf_err_handler,
 };
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
index 659905e45950..01b34eda83e9 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
@@ -183,11 +183,19 @@ static void adf_remove(struct pci_dev *pdev)
 	adf_cleanup_accel(accel_dev);
 }
 
+static void adf_shutdown(struct pci_dev *pdev)
+{
+	struct adf_accel_dev *accel_dev = adf_devmgr_pci_to_accel_dev(pdev);
+
+	adf_dev_down(accel_dev);
+}
+
 static struct pci_driver adf_driver = {
 	.id_table = adf_pci_tbl,
 	.name = ADF_4XXX_DEVICE_NAME,
 	.probe = adf_probe,
 	.remove = adf_remove,
+	.shutdown = adf_shutdown,
 	.sriov_configure = adf_sriov_configure,
 	.err_handler = &adf_err_handler,
 };
diff --git a/drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c
index 4d18057745d4..b776f7ea0dfb 100644
--- a/drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c
@@ -19,6 +19,13 @@
 #include <adf_dbgfs.h>
 #include "adf_c3xxx_hw_data.h"
 
+static void adf_shutdown(struct pci_dev *pdev)
+{
+	struct adf_accel_dev *accel_dev = adf_devmgr_pci_to_accel_dev(pdev);
+
+	adf_dev_down(accel_dev);
+}
+
 static const struct pci_device_id adf_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_QAT_C3XXX), },
 	{ }
@@ -33,6 +40,7 @@ static struct pci_driver adf_driver = {
 	.name = ADF_C3XXX_DEVICE_NAME,
 	.probe = adf_probe,
 	.remove = adf_remove,
+	.shutdown = adf_shutdown,
 	.sriov_configure = adf_sriov_configure,
 	.err_handler = &adf_err_handler,
 };
diff --git a/drivers/crypto/intel/qat/qat_c62x/adf_drv.c b/drivers/crypto/intel/qat/qat_c62x/adf_drv.c
index e6b5de55434e..5310149c311e 100644
--- a/drivers/crypto/intel/qat/qat_c62x/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_c62x/adf_drv.c
@@ -19,6 +19,13 @@
 #include <adf_dbgfs.h>
 #include "adf_c62x_hw_data.h"
 
+static void adf_shutdown(struct pci_dev *pdev)
+{
+	struct adf_accel_dev *accel_dev = adf_devmgr_pci_to_accel_dev(pdev);
+
+	adf_dev_down(accel_dev);
+}
+
 static const struct pci_device_id adf_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_QAT_C62X), },
 	{ }
@@ -33,6 +40,7 @@ static struct pci_driver adf_driver = {
 	.name = ADF_C62X_DEVICE_NAME,
 	.probe = adf_probe,
 	.remove = adf_remove,
+	.shutdown = adf_shutdown,
 	.sriov_configure = adf_sriov_configure,
 	.err_handler = &adf_err_handler,
 };
diff --git a/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c b/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c
index 2a50cce41515..5ddf567ffcad 100644
--- a/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c
@@ -19,6 +19,13 @@
 #include <adf_dbgfs.h>
 #include "adf_dh895xcc_hw_data.h"
 
+static void adf_shutdown(struct pci_dev *pdev)
+{
+	struct adf_accel_dev *accel_dev = adf_devmgr_pci_to_accel_dev(pdev);
+
+	adf_dev_down(accel_dev);
+}
+
 static const struct pci_device_id adf_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_QAT_DH895XCC), },
 	{ }
@@ -33,6 +40,7 @@ static struct pci_driver adf_driver = {
 	.name = ADF_DH895XCC_DEVICE_NAME,
 	.probe = adf_probe,
 	.remove = adf_remove,
+	.shutdown = adf_shutdown,
 	.sriov_configure = adf_sriov_configure,
 	.err_handler = &adf_err_handler,
 };
diff --git a/drivers/crypto/marvell/cesa/cesa.c b/drivers/crypto/marvell/cesa/cesa.c
index 5fd31ba715c2..24273cb082ba 100644
--- a/drivers/crypto/marvell/cesa/cesa.c
+++ b/drivers/crypto/marvell/cesa/cesa.c
@@ -94,7 +94,7 @@ static int mv_cesa_std_process(struct mv_cesa_engine *engine, u32 status)
 
 static int mv_cesa_int_process(struct mv_cesa_engine *engine, u32 status)
 {
-	if (engine->chain.first && engine->chain.last)
+	if (engine->chain_hw.first && engine->chain_hw.last)
 		return mv_cesa_tdma_process(engine, status);
 
 	return mv_cesa_std_process(engine, status);
diff --git a/drivers/crypto/marvell/cesa/cesa.h b/drivers/crypto/marvell/cesa/cesa.h
index d215a6bed6bc..50ca1039fdaa 100644
--- a/drivers/crypto/marvell/cesa/cesa.h
+++ b/drivers/crypto/marvell/cesa/cesa.h
@@ -440,8 +440,10 @@ struct mv_cesa_dev {
  *			SRAM
  * @queue:		fifo of the pending crypto requests
  * @load:		engine load counter, useful for load balancing
- * @chain:		list of the current tdma descriptors being processed
- *			by this engine.
+ * @chain_hw:		list of the current tdma descriptors being processed
+ *			by the hardware.
+ * @chain_sw:		list of the current tdma descriptors that will be
+ *			submitted to the hardware.
  * @complete_queue:	fifo of the processed requests by the engine
  *
  * Structure storing CESA engine information.
@@ -463,7 +465,8 @@ struct mv_cesa_engine {
 	struct gen_pool *pool;
 	struct crypto_queue queue;
 	atomic_t load;
-	struct mv_cesa_tdma_chain chain;
+	struct mv_cesa_tdma_chain chain_hw;
+	struct mv_cesa_tdma_chain chain_sw;
 	struct list_head complete_queue;
 	int irq;
 };
diff --git a/drivers/crypto/marvell/cesa/tdma.c b/drivers/crypto/marvell/cesa/tdma.c
index 388a06e180d6..243305354420 100644
--- a/drivers/crypto/marvell/cesa/tdma.c
+++ b/drivers/crypto/marvell/cesa/tdma.c
@@ -38,6 +38,15 @@ void mv_cesa_dma_step(struct mv_cesa_req *dreq)
 {
 	struct mv_cesa_engine *engine = dreq->engine;
 
+	spin_lock_bh(&engine->lock);
+	if (engine->chain_sw.first == dreq->chain.first) {
+		engine->chain_sw.first = NULL;
+		engine->chain_sw.last = NULL;
+	}
+	engine->chain_hw.first = dreq->chain.first;
+	engine->chain_hw.last = dreq->chain.last;
+	spin_unlock_bh(&engine->lock);
+
 	writel_relaxed(0, engine->regs + CESA_SA_CFG);
 
 	mv_cesa_set_int_mask(engine, CESA_SA_INT_ACC0_IDMA_DONE);
@@ -96,25 +105,27 @@ void mv_cesa_dma_prepare(struct mv_cesa_req *dreq,
 void mv_cesa_tdma_chain(struct mv_cesa_engine *engine,
 			struct mv_cesa_req *dreq)
 {
-	if (engine->chain.first == NULL && engine->chain.last == NULL) {
-		engine->chain.first = dreq->chain.first;
-		engine->chain.last  = dreq->chain.last;
-	} else {
-		struct mv_cesa_tdma_desc *last;
+	struct mv_cesa_tdma_desc *last = engine->chain_sw.last;
 
-		last = engine->chain.last;
+	/*
+	 * Break the DMA chain if the request being queued needs the IV
+	 * regs to be set before lauching the request.
+	 */
+	if (!last || dreq->chain.first->flags & CESA_TDMA_SET_STATE)
+		engine->chain_sw.first = dreq->chain.first;
+	else {
 		last->next = dreq->chain.first;
-		engine->chain.last = dreq->chain.last;
-
-		/*
-		 * Break the DMA chain if the CESA_TDMA_BREAK_CHAIN is set on
-		 * the last element of the current chain, or if the request
-		 * being queued needs the IV regs to be set before lauching
-		 * the request.
-		 */
-		if (!(last->flags & CESA_TDMA_BREAK_CHAIN) &&
-		    !(dreq->chain.first->flags & CESA_TDMA_SET_STATE))
-			last->next_dma = cpu_to_le32(dreq->chain.first->cur_dma);
+		last->next_dma = cpu_to_le32(dreq->chain.first->cur_dma);
+	}
+	last = dreq->chain.last;
+	engine->chain_sw.last = last;
+	/*
+	 * Break the DMA chain if the CESA_TDMA_BREAK_CHAIN is set on
+	 * the last element of the current chain.
+	 */
+	if (last->flags & CESA_TDMA_BREAK_CHAIN) {
+		engine->chain_sw.first = NULL;
+		engine->chain_sw.last = NULL;
 	}
 }
 
@@ -127,7 +138,7 @@ int mv_cesa_tdma_process(struct mv_cesa_engine *engine, u32 status)
 
 	tdma_cur = readl(engine->regs + CESA_TDMA_CUR);
 
-	for (tdma = engine->chain.first; tdma; tdma = next) {
+	for (tdma = engine->chain_hw.first; tdma; tdma = next) {
 		spin_lock_bh(&engine->lock);
 		next = tdma->next;
 		spin_unlock_bh(&engine->lock);
@@ -149,12 +160,12 @@ int mv_cesa_tdma_process(struct mv_cesa_engine *engine, u32 status)
 								 &backlog);
 
 			/* Re-chaining to the next request */
-			engine->chain.first = tdma->next;
+			engine->chain_hw.first = tdma->next;
 			tdma->next = NULL;
 
 			/* If this is the last request, clear the chain */
-			if (engine->chain.first == NULL)
-				engine->chain.last  = NULL;
+			if (engine->chain_hw.first == NULL)
+				engine->chain_hw.last  = NULL;
 			spin_unlock_bh(&engine->lock);
 
 			ctx = crypto_tfm_ctx(req->tfm);
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 5e836e4e5b44..959f690b1226 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -223,8 +223,7 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
 			ubuf->sg = NULL;
 		}
 	} else {
-		dma_sync_sg_for_cpu(dev, ubuf->sg->sgl, ubuf->sg->nents,
-				    direction);
+		dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);
 	}
 
 	return ret;
@@ -239,7 +238,7 @@ static int end_cpu_udmabuf(struct dma_buf *buf,
 	if (!ubuf->sg)
 		return -EINVAL;
 
-	dma_sync_sg_for_device(dev, ubuf->sg->sgl, ubuf->sg->nents, direction);
+	dma_sync_sgtable_for_device(dev, ubuf->sg, direction);
 	return 0;
 }
 
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 8420862c90a4..a059964b97f8 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1746,9 +1746,9 @@ altr_edac_a10_device_trig(struct file *file, const char __user *user_buf,
 
 	local_irq_save(flags);
 	if (trig_type == ALTR_UE_TRIGGER_CHAR)
-		writel(priv->ue_set_mask, set_addr);
+		writew(priv->ue_set_mask, set_addr);
 	else
-		writel(priv->ce_set_mask, set_addr);
+		writew(priv->ce_set_mask, set_addr);
 
 	/* Ensure the interrupt test bits are set */
 	wmb();
@@ -1778,7 +1778,7 @@ altr_edac_a10_device_trig2(struct file *file, const char __user *user_buf,
 
 	local_irq_save(flags);
 	if (trig_type == ALTR_UE_TRIGGER_CHAR) {
-		writel(priv->ue_set_mask, set_addr);
+		writew(priv->ue_set_mask, set_addr);
 	} else {
 		/* Setup read/write of 4 bytes */
 		writel(ECC_WORD_WRITE, drvdata->base + ECC_BLK_DBYTECTRL_OFST);
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 5d356b7c4589..c0a8f9c8d4f0 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3882,6 +3882,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 			break;
 		case 0x70 ... 0x7f:
 			pvt->ctl_name			= "F19h_M70h";
+			pvt->max_mcs			= 4;
 			pvt->flags.zn_regs_v2		= 1;
 			break;
 		case 0x90 ... 0x9f:
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 993615fa490e..f1abe605865a 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1708,6 +1708,39 @@ static int scmi_common_get_max_msg_size(const struct scmi_protocol_handle *ph)
 	return info->desc->max_msg_size;
 }
 
+/**
+ * scmi_protocol_msg_check  - Check protocol message attributes
+ *
+ * @ph: A reference to the protocol handle.
+ * @message_id: The ID of the message to check.
+ * @attributes: A parameter to optionally return the retrieved message
+ *		attributes, in case of Success.
+ *
+ * An helper to check protocol message attributes for a specific protocol
+ * and message pair.
+ *
+ * Return: 0 on SUCCESS
+ */
+static int scmi_protocol_msg_check(const struct scmi_protocol_handle *ph,
+				   u32 message_id, u32 *attributes)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	ret = xfer_get_init(ph, PROTOCOL_MESSAGE_ATTRIBUTES,
+			    sizeof(__le32), 0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(message_id, t->tx.buf);
+	ret = do_xfer(ph, t);
+	if (!ret && attributes)
+		*attributes = get_unaligned_le32(t->rx.buf);
+	xfer_put(ph, t);
+
+	return ret;
+}
+
 /**
  * struct scmi_iterator  - Iterator descriptor
  * @msg: A reference to the message TX buffer; filled by @prepare_message with
@@ -1849,6 +1882,7 @@ scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
 	int ret;
 	u32 flags;
 	u64 phys_addr;
+	u32 attributes;
 	u8 size;
 	void __iomem *addr;
 	struct scmi_xfer *t;
@@ -1857,6 +1891,15 @@ scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
 	struct scmi_msg_resp_desc_fc *resp;
 	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
 
+	/* Check if the MSG_ID supports fastchannel */
+	ret = scmi_protocol_msg_check(ph, message_id, &attributes);
+	if (ret || !MSG_SUPPORTS_FASTCHANNEL(attributes)) {
+		dev_dbg(ph->dev,
+			"Skip FC init for 0x%02X/%d  domain:%d - ret:%d\n",
+			pi->proto->id, message_id, domain, ret);
+		return;
+	}
+
 	if (!p_addr) {
 		ret = -EINVAL;
 		goto err_out;
@@ -1984,39 +2027,6 @@ static void scmi_common_fastchannel_db_ring(struct scmi_fc_db_info *db)
 #endif
 }
 
-/**
- * scmi_protocol_msg_check  - Check protocol message attributes
- *
- * @ph: A reference to the protocol handle.
- * @message_id: The ID of the message to check.
- * @attributes: A parameter to optionally return the retrieved message
- *		attributes, in case of Success.
- *
- * An helper to check protocol message attributes for a specific protocol
- * and message pair.
- *
- * Return: 0 on SUCCESS
- */
-static int scmi_protocol_msg_check(const struct scmi_protocol_handle *ph,
-				   u32 message_id, u32 *attributes)
-{
-	int ret;
-	struct scmi_xfer *t;
-
-	ret = xfer_get_init(ph, PROTOCOL_MESSAGE_ATTRIBUTES,
-			    sizeof(__le32), 0, &t);
-	if (ret)
-		return ret;
-
-	put_unaligned_le32(message_id, t->tx.buf);
-	ret = do_xfer(ph, t);
-	if (!ret && attributes)
-		*attributes = get_unaligned_le32(t->rx.buf);
-	xfer_put(ph, t);
-
-	return ret;
-}
-
 static const struct scmi_proto_helpers_ops helpers_ops = {
 	.extended_name_get = scmi_common_extended_name_get,
 	.get_max_msg_size = scmi_common_get_max_msg_size,
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index aaee57cdcd55..d62c4469d1fd 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -31,6 +31,8 @@
 
 #define SCMI_PROTOCOL_VENDOR_BASE	0x80
 
+#define MSG_SUPPORTS_FASTCHANNEL(x)	((x) & BIT(0))
+
 enum scmi_common_cmd {
 	PROTOCOL_VERSION = 0x0,
 	PROTOCOL_ATTRIBUTES = 0x1,
diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index a3df782fa687..e919940c8bf9 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -124,6 +124,7 @@ static __init int sysfb_init(void)
 {
 	struct screen_info *si = &screen_info;
 	struct device *parent;
+	unsigned int type;
 	struct simplefb_platform_data mode;
 	const char *name;
 	bool compatible;
@@ -151,17 +152,26 @@ static __init int sysfb_init(void)
 			goto put_device;
 	}
 
+	type = screen_info_video_type(si);
+
 	/* if the FB is incompatible, create a legacy framebuffer device */
-	if (si->orig_video_isVGA == VIDEO_TYPE_EFI)
-		name = "efi-framebuffer";
-	else if (si->orig_video_isVGA == VIDEO_TYPE_VLFB)
-		name = "vesa-framebuffer";
-	else if (si->orig_video_isVGA == VIDEO_TYPE_VGAC)
-		name = "vga-framebuffer";
-	else if (si->orig_video_isVGA == VIDEO_TYPE_EGAC)
+	switch (type) {
+	case VIDEO_TYPE_EGAC:
 		name = "ega-framebuffer";
-	else
+		break;
+	case VIDEO_TYPE_VGAC:
+		name = "vga-framebuffer";
+		break;
+	case VIDEO_TYPE_VLFB:
+		name = "vesa-framebuffer";
+		break;
+	case VIDEO_TYPE_EFI:
+		name = "efi-framebuffer";
+		break;
+	default:
 		name = "platform-framebuffer";
+		break;
+	}
 
 	pd = platform_device_alloc(name, 0);
 	if (!pd) {
diff --git a/drivers/gpio/gpio-mlxbf3.c b/drivers/gpio/gpio-mlxbf3.c
index 10ea71273c89..9875e34bde72 100644
--- a/drivers/gpio/gpio-mlxbf3.c
+++ b/drivers/gpio/gpio-mlxbf3.c
@@ -190,7 +190,9 @@ static int mlxbf3_gpio_probe(struct platform_device *pdev)
 	struct mlxbf3_gpio_context *gs;
 	struct gpio_irq_chip *girq;
 	struct gpio_chip *gc;
+	char *colon_ptr;
 	int ret, irq;
+	long num;
 
 	gs = devm_kzalloc(dev, sizeof(*gs), GFP_KERNEL);
 	if (!gs)
@@ -227,25 +229,39 @@ static int mlxbf3_gpio_probe(struct platform_device *pdev)
 	gc->owner = THIS_MODULE;
 	gc->add_pin_ranges = mlxbf3_gpio_add_pin_ranges;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq >= 0) {
-		girq = &gs->gc.irq;
-		gpio_irq_chip_set_chip(girq, &gpio_mlxbf3_irqchip);
-		girq->default_type = IRQ_TYPE_NONE;
-		/* This will let us handle the parent IRQ in the driver */
-		girq->num_parents = 0;
-		girq->parents = NULL;
-		girq->parent_handler = NULL;
-		girq->handler = handle_bad_irq;
-
-		/*
-		 * Directly request the irq here instead of passing
-		 * a flow-handler because the irq is shared.
-		 */
-		ret = devm_request_irq(dev, irq, mlxbf3_gpio_irq_handler,
-				       IRQF_SHARED, dev_name(dev), gs);
-		if (ret)
-			return dev_err_probe(dev, ret, "failed to request IRQ");
+	colon_ptr = strchr(dev_name(dev), ':');
+	if (!colon_ptr) {
+		dev_err(dev, "invalid device name format\n");
+		return -EINVAL;
+	}
+
+	ret = kstrtol(++colon_ptr, 16, &num);
+	if (ret) {
+		dev_err(dev, "invalid device instance\n");
+		return ret;
+	}
+
+	if (!num) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq >= 0) {
+			girq = &gs->gc.irq;
+			gpio_irq_chip_set_chip(girq, &gpio_mlxbf3_irqchip);
+			girq->default_type = IRQ_TYPE_NONE;
+			/* This will let us handle the parent IRQ in the driver */
+			girq->num_parents = 0;
+			girq->parents = NULL;
+			girq->parent_handler = NULL;
+			girq->handler = handle_bad_irq;
+
+			/*
+			 * Directly request the irq here instead of passing
+			 * a flow-handler because the irq is shared.
+			 */
+			ret = devm_request_irq(dev, irq, mlxbf3_gpio_irq_handler,
+					       IRQF_SHARED, dev_name(dev), gs);
+			if (ret)
+				return dev_err_probe(dev, ret, "failed to request IRQ");
+		}
 	}
 
 	platform_set_drvdata(pdev, gs);
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index ef3aee1cabcf..bb7c1bf5f856 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -951,7 +951,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 					IRQF_ONESHOT | IRQF_SHARED, dev_name(dev),
 					chip);
 	if (ret)
-		return dev_err_probe(dev, client->irq, "failed to request irq\n");
+		return dev_err_probe(dev, ret, "failed to request irq\n");
 
 	return 0;
 }
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 626daedb0169..36f8c7bb79d8 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -215,6 +215,15 @@ static void of_gpio_try_fixup_polarity(const struct device_node *np,
 		 */
 		{ "lantiq,pci-xway",	"gpio-reset",	false },
 #endif
+#if IS_ENABLED(CONFIG_REGULATOR_S5M8767)
+		/*
+		 * According to S5M8767, the DVS and DS pin are
+		 * active-high signals. However, exynos5250-spring.dts use
+		 * active-low setting.
+		 */
+		{ "samsung,s5m8767-pmic", "s5m8767,pmic-buck-dvs-gpios", true },
+		{ "samsung,s5m8767-pmic", "s5m8767,pmic-buck-ds-gpios", true },
+#endif
 #if IS_ENABLED(CONFIG_TOUCHSCREEN_TSC2005)
 		/*
 		 * DTS for Nokia N900 incorrectly specified "active high"
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index e0b02bf1c563..3d114ea7049f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -985,6 +985,10 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 			VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions */
+	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
 	return 0;
 }
 
@@ -1167,6 +1171,10 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev)
 		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
 		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
 		fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
+
+		/* Keeping one read-back to ensure all register writes are done, otherwise
+		 * it may introduce race conditions */
+		RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 21eb0c5b320d..c43223916a1b 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -115,7 +115,7 @@ static u32 config_mask(const u64 config)
 {
 	unsigned int bit = config_bit(config);
 
-	if (__builtin_constant_p(config))
+	if (__builtin_constant_p(bit))
 		BUILD_BUG_ON(bit >
 			     BITS_PER_TYPE(typeof_member(struct i915_pmu,
 							 enable)) - 1);
@@ -124,7 +124,7 @@ static u32 config_mask(const u64 config)
 			     BITS_PER_TYPE(typeof_member(struct i915_pmu,
 							 enable)) - 1);
 
-	return BIT(config_bit(config));
+	return BIT(bit);
 }
 
 static bool is_engine_event(struct perf_event *event)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index d2189441aa38..80c78aff9643 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -123,6 +123,20 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 		OUT_RING(ring, lower_32_bits(rbmemptr(ring, fence)));
 		OUT_RING(ring, upper_32_bits(rbmemptr(ring, fence)));
 		OUT_RING(ring, submit->seqno - 1);
+
+		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+		OUT_RING(ring, CP_SET_THREAD_BOTH);
+
+		/* Reset state used to synchronize BR and BV */
+		OUT_PKT7(ring, CP_RESET_CONTEXT_STATE, 1);
+		OUT_RING(ring,
+			 CP_RESET_CONTEXT_STATE_0_CLEAR_ON_CHIP_TS |
+			 CP_RESET_CONTEXT_STATE_0_CLEAR_RESOURCE_TABLE |
+			 CP_RESET_CONTEXT_STATE_0_CLEAR_BV_BR_COUNTER |
+			 CP_RESET_CONTEXT_STATE_0_RESET_GLOBAL_LOCAL_TS);
+
+		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+		OUT_RING(ring, CP_SET_THREAD_BR);
 	}
 
 	if (!sysprof) {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index d8a2edebfe8c..b7699ca89dcc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -94,17 +94,21 @@ static void drm_mode_to_intf_timing_params(
 		timing->vsync_polarity = 0;
 	}
 
-	/* for DP/EDP, Shift timings to align it to bottom right */
-	if (phys_enc->hw_intf->cap->type == INTF_DP) {
+	timing->wide_bus_en = dpu_encoder_is_widebus_enabled(phys_enc->parent);
+	timing->compression_en = dpu_encoder_is_dsc_enabled(phys_enc->parent);
+
+	/*
+	 *  For DP/EDP, Shift timings to align it to bottom right.
+	 *  wide_bus_en is set for everything excluding SDM845 &
+	 *  porch changes cause DisplayPort failure and HDMI tearing.
+	 */
+	if (phys_enc->hw_intf->cap->type == INTF_DP && timing->wide_bus_en) {
 		timing->h_back_porch += timing->h_front_porch;
 		timing->h_front_porch = 0;
 		timing->v_back_porch += timing->v_front_porch;
 		timing->v_front_porch = 0;
 	}
 
-	timing->wide_bus_en = dpu_encoder_is_widebus_enabled(phys_enc->parent);
-	timing->compression_en = dpu_encoder_is_dsc_enabled(phys_enc->parent);
-
 	/*
 	 * for DP, divide the horizonal parameters by 2 when
 	 * widebus is enabled
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
index 677c62571811..28cc550e22a8 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
@@ -703,6 +703,13 @@ static int dsi_pll_10nm_init(struct msm_dsi_phy *phy)
 	/* TODO: Remove this when we have proper display handover support */
 	msm_dsi_phy_pll_save_state(phy);
 
+	/*
+	 * Store also proper vco_current_rate, because its value will be used in
+	 * dsi_10nm_pll_restore_state().
+	 */
+	if (!dsi_pll_10nm_vco_recalc_rate(&pll_10nm->clk_hw, VCO_REF_CLK_RATE))
+		pll_10nm->vco_current_rate = pll_10nm->phy->cfg->min_pll_rate;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml b/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml
index c6cdc5c003dc..2ca0ad6efc96 100644
--- a/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml
@@ -2260,7 +2260,8 @@ opcode: CP_LOAD_STATE4 (30) (4 dwords)
 	<reg32 offset="0" name="0">
 		<bitfield name="CLEAR_ON_CHIP_TS" pos="0" type="boolean"/>
 		<bitfield name="CLEAR_RESOURCE_TABLE" pos="1" type="boolean"/>
-		<bitfield name="CLEAR_GLOBAL_LOCAL_TS" pos="2" type="boolean"/>
+		<bitfield name="CLEAR_BV_BR_COUNTER" pos="2" type="boolean"/>
+		<bitfield name="RESET_GLOBAL_LOCAL_TS" pos="3" type="boolean"/>
 	</reg32>
 </domain>
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index d47442125fa1..9aae26eb7d8f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -42,7 +42,7 @@
 #include "nouveau_acpi.h"
 
 static struct ida bl_ida;
-#define BL_NAME_SIZE 15 // 12 for name + 2 for digits + 1 for '\0'
+#define BL_NAME_SIZE 24 // 12 for name + 11 for digits + 1 for '\0'
 
 static bool
 nouveau_get_backlight_name(char backlight_name[BL_NAME_SIZE],
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 06f5057690bd..e0fc12d514d7 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -974,7 +974,7 @@ static void ssd130x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 
 static void ssd132x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 {
-	unsigned int columns = DIV_ROUND_UP(ssd130x->height, SSD132X_SEGMENT_WIDTH);
+	unsigned int columns = DIV_ROUND_UP(ssd130x->width, SSD132X_SEGMENT_WIDTH);
 	unsigned int height = ssd130x->height;
 
 	memset(data_array, 0, columns * height);
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index ad32e584deee..c9c88d3ad669 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -191,7 +191,6 @@ v3d_job_update_stats(struct v3d_job *job, enum v3d_queue queue)
 	struct v3d_dev *v3d = job->v3d;
 	struct v3d_file_priv *file = job->file->driver_priv;
 	struct v3d_stats *global_stats = &v3d->queue[queue].stats;
-	struct v3d_stats *local_stats = &file->stats[queue];
 	u64 now = local_clock();
 	unsigned long flags;
 
@@ -201,7 +200,12 @@ v3d_job_update_stats(struct v3d_job *job, enum v3d_queue queue)
 	else
 		preempt_disable();
 
-	v3d_stats_update(local_stats, now);
+	/* Don't update the local stats if the file context has already closed */
+	if (file)
+		v3d_stats_update(&file->stats[queue], now);
+	else
+		drm_dbg(&v3d->drm, "The file descriptor was closed before job completion\n");
+
 	v3d_stats_update(global_stats, now);
 
 	if (IS_ENABLED(CONFIG_LOCKDEP))
diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index c6e0c8d77a70..a1928cedc7dd 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -352,6 +352,36 @@ void xe_display_pm_suspend(struct xe_device *xe)
 	__xe_display_pm_suspend(xe, false);
 }
 
+void xe_display_pm_shutdown(struct xe_device *xe)
+{
+	struct intel_display *display = &xe->display;
+
+	if (!xe->info.probe_display)
+		return;
+
+	intel_power_domains_disable(xe);
+	intel_fbdev_set_suspend(&xe->drm, FBINFO_STATE_SUSPENDED, true);
+	if (has_display(xe)) {
+		drm_kms_helper_poll_disable(&xe->drm);
+		intel_display_driver_disable_user_access(xe);
+		intel_display_driver_suspend(xe);
+	}
+
+	xe_display_flush_cleanup_work(xe);
+	intel_dp_mst_suspend(xe);
+	intel_hpd_cancel_work(xe);
+
+	if (has_display(xe))
+		intel_display_driver_suspend_access(xe);
+
+	intel_encoder_suspend_all(display);
+	intel_encoder_shutdown_all(display);
+
+	intel_opregion_suspend(display, PCI_D3cold);
+
+	intel_dmc_suspend(xe);
+}
+
 void xe_display_pm_runtime_suspend(struct xe_device *xe)
 {
 	if (!xe->info.probe_display)
@@ -376,6 +406,19 @@ void xe_display_pm_suspend_late(struct xe_device *xe)
 	intel_display_power_suspend_late(xe);
 }
 
+void xe_display_pm_shutdown_late(struct xe_device *xe)
+{
+	if (!xe->info.probe_display)
+		return;
+
+	/*
+	 * The only requirement is to reboot with display DC states disabled,
+	 * for now leaving all display power wells in the INIT power domain
+	 * enabled.
+	 */
+	intel_power_domains_driver_remove(xe);
+}
+
 void xe_display_pm_resume_early(struct xe_device *xe)
 {
 	if (!xe->info.probe_display)
diff --git a/drivers/gpu/drm/xe/display/xe_display.h b/drivers/gpu/drm/xe/display/xe_display.h
index bed55fd26f30..17afa537aee5 100644
--- a/drivers/gpu/drm/xe/display/xe_display.h
+++ b/drivers/gpu/drm/xe/display/xe_display.h
@@ -35,7 +35,9 @@ void xe_display_irq_reset(struct xe_device *xe);
 void xe_display_irq_postinstall(struct xe_device *xe, struct xe_gt *gt);
 
 void xe_display_pm_suspend(struct xe_device *xe);
+void xe_display_pm_shutdown(struct xe_device *xe);
 void xe_display_pm_suspend_late(struct xe_device *xe);
+void xe_display_pm_shutdown_late(struct xe_device *xe);
 void xe_display_pm_resume_early(struct xe_device *xe);
 void xe_display_pm_resume(struct xe_device *xe);
 void xe_display_pm_runtime_suspend(struct xe_device *xe);
@@ -66,7 +68,9 @@ static inline void xe_display_irq_reset(struct xe_device *xe) {}
 static inline void xe_display_irq_postinstall(struct xe_device *xe, struct xe_gt *gt) {}
 
 static inline void xe_display_pm_suspend(struct xe_device *xe) {}
+static inline void xe_display_pm_shutdown(struct xe_device *xe) {}
 static inline void xe_display_pm_suspend_late(struct xe_device *xe) {}
+static inline void xe_display_pm_shutdown_late(struct xe_device *xe) {}
 static inline void xe_display_pm_resume_early(struct xe_device *xe) {}
 static inline void xe_display_pm_resume(struct xe_device *xe) {}
 static inline void xe_display_pm_runtime_suspend(struct xe_device *xe) {}
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 23e02372a49d..0c3db53b93d8 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -374,6 +374,11 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
 	return ERR_PTR(err);
 }
 
+static bool xe_driver_flr_disabled(struct xe_device *xe)
+{
+	return xe_mmio_read32(xe_root_mmio_gt(xe), GU_CNTL_PROTECTED) & DRIVERINT_FLR_DIS;
+}
+
 /*
  * The driver-initiated FLR is the highest level of reset that we can trigger
  * from within the driver. It is different from the PCI FLR in that it doesn't
@@ -387,17 +392,12 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
  * if/when a new instance of i915 is bound to the device it will do a full
  * re-init anyway.
  */
-static void xe_driver_flr(struct xe_device *xe)
+static void __xe_driver_flr(struct xe_device *xe)
 {
 	const unsigned int flr_timeout = 3 * MICRO; /* specs recommend a 3s wait */
 	struct xe_gt *gt = xe_root_mmio_gt(xe);
 	int ret;
 
-	if (xe_mmio_read32(gt, GU_CNTL_PROTECTED) & DRIVERINT_FLR_DIS) {
-		drm_info_once(&xe->drm, "BIOS Disabled Driver-FLR\n");
-		return;
-	}
-
 	drm_dbg(&xe->drm, "Triggering Driver-FLR\n");
 
 	/*
@@ -438,6 +438,16 @@ static void xe_driver_flr(struct xe_device *xe)
 	xe_mmio_write32(gt, GU_DEBUG, DRIVERFLR_STATUS);
 }
 
+static void xe_driver_flr(struct xe_device *xe)
+{
+	if (xe_driver_flr_disabled(xe)) {
+		drm_info_once(&xe->drm, "BIOS Disabled Driver-FLR\n");
+		return;
+	}
+
+	__xe_driver_flr(xe);
+}
+
 static void xe_driver_flr_fini(void *arg)
 {
 	struct xe_device *xe = arg;
@@ -797,6 +807,24 @@ void xe_device_remove(struct xe_device *xe)
 
 void xe_device_shutdown(struct xe_device *xe)
 {
+	struct xe_gt *gt;
+	u8 id;
+
+	drm_dbg(&xe->drm, "Shutting down device\n");
+
+	if (xe_driver_flr_disabled(xe)) {
+		xe_display_pm_shutdown(xe);
+
+		xe_irq_suspend(xe);
+
+		for_each_gt(gt, xe, id)
+			xe_gt_shutdown(gt);
+
+		xe_display_pm_shutdown_late(xe);
+	} else {
+		/* BOOM! */
+		__xe_driver_flr(xe);
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 3a7628fb5ad3..231ed53cf907 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -98,14 +98,14 @@ void xe_gt_sanitize(struct xe_gt *gt)
 
 static void xe_gt_enable_host_l2_vram(struct xe_gt *gt)
 {
+	unsigned int fw_ref;
 	u32 reg;
-	int err;
 
 	if (!XE_WA(gt, 16023588340))
 		return;
 
-	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (WARN_ON(err))
+	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (!fw_ref)
 		return;
 
 	if (!xe_gt_is_media_type(gt)) {
@@ -114,14 +114,14 @@ static void xe_gt_enable_host_l2_vram(struct xe_gt *gt)
 		xe_gt_mcr_multicast_write(gt, XE2_GAMREQSTRM_CTRL, reg);
 	}
 
-	xe_gt_mcr_multicast_write(gt, XEHPC_L3CLOS_MASK(3), 0x3);
-	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
+	xe_gt_mcr_multicast_write(gt, XEHPC_L3CLOS_MASK(3), 0xF);
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 }
 
 static void xe_gt_disable_host_l2_vram(struct xe_gt *gt)
 {
+	unsigned int fw_ref;
 	u32 reg;
-	int err;
 
 	if (!XE_WA(gt, 16023588340))
 		return;
@@ -129,15 +129,15 @@ static void xe_gt_disable_host_l2_vram(struct xe_gt *gt)
 	if (xe_gt_is_media_type(gt))
 		return;
 
-	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (WARN_ON(err))
+	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (!fw_ref)
 		return;
 
 	reg = xe_gt_mcr_unicast_read_any(gt, XE2_GAMREQSTRM_CTRL);
 	reg &= ~CG_DIS_CNTLBUS;
 	xe_gt_mcr_multicast_write(gt, XE2_GAMREQSTRM_CTRL, reg);
 
-	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 }
 
 /**
@@ -405,11 +405,14 @@ static void dump_pat_on_error(struct xe_gt *gt)
 
 static int gt_fw_domain_init(struct xe_gt *gt)
 {
+	unsigned int fw_ref;
 	int err, i;
 
-	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (err)
+	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (!fw_ref) {
+		err = -ETIMEDOUT;
 		goto err_hw_fence_irq;
+	}
 
 	if (!xe_gt_is_media_type(gt)) {
 		err = xe_ggtt_init(gt_to_tile(gt)->mem.ggtt);
@@ -444,14 +447,12 @@ static int gt_fw_domain_init(struct xe_gt *gt)
 	 */
 	gt->info.gmdid = xe_mmio_read32(gt, GMD_ID);
 
-	err = xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
-	XE_WARN_ON(err);
-
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 	return 0;
 
 err_force_wake:
 	dump_pat_on_error(gt);
-	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 err_hw_fence_irq:
 	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
 		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
@@ -461,11 +462,14 @@ static int gt_fw_domain_init(struct xe_gt *gt)
 
 static int all_fw_domain_init(struct xe_gt *gt)
 {
+	unsigned int fw_ref;
 	int err, i;
 
-	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (err)
-		goto err_hw_fence_irq;
+	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL)) {
+		err = -ETIMEDOUT;
+		goto err_force_wake;
+	}
 
 	xe_gt_mcr_set_implicit_defaults(gt);
 	xe_wa_process_gt(gt);
@@ -531,14 +535,12 @@ static int all_fw_domain_init(struct xe_gt *gt)
 	if (IS_SRIOV_PF(gt_to_xe(gt)))
 		xe_gt_sriov_pf_init_hw(gt);
 
-	err = xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	XE_WARN_ON(err);
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 
 	return 0;
 
 err_force_wake:
-	xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-err_hw_fence_irq:
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
 		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
 
@@ -551,11 +553,12 @@ static int all_fw_domain_init(struct xe_gt *gt)
  */
 int xe_gt_init_hwconfig(struct xe_gt *gt)
 {
+	unsigned int fw_ref;
 	int err;
 
-	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (err)
-		goto out;
+	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (!fw_ref)
+		return -ETIMEDOUT;
 
 	xe_gt_mcr_init_early(gt);
 	xe_pat_init(gt);
@@ -573,8 +576,7 @@ int xe_gt_init_hwconfig(struct xe_gt *gt)
 	xe_gt_enable_host_l2_vram(gt);
 
 out_fw:
-	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
-out:
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 	return err;
 }
 
@@ -744,6 +746,7 @@ static int do_gt_restart(struct xe_gt *gt)
 
 static int gt_reset(struct xe_gt *gt)
 {
+	unsigned int fw_ref;
 	int err;
 
 	if (xe_device_wedged(gt_to_xe(gt)))
@@ -764,9 +767,11 @@ static int gt_reset(struct xe_gt *gt)
 
 	xe_gt_sanitize(gt);
 
-	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (err)
-		goto err_msg;
+	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL)) {
+		err = -ETIMEDOUT;
+		goto err_out;
+	}
 
 	xe_uc_gucrc_disable(&gt->uc);
 	xe_uc_stop_prepare(&gt->uc);
@@ -784,8 +789,7 @@ static int gt_reset(struct xe_gt *gt)
 	if (err)
 		goto err_out;
 
-	err = xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	XE_WARN_ON(err);
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 	xe_pm_runtime_put(gt_to_xe(gt));
 
 	xe_gt_info(gt, "reset done\n");
@@ -793,8 +797,7 @@ static int gt_reset(struct xe_gt *gt)
 	return 0;
 
 err_out:
-	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
-err_msg:
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 	XE_WARN_ON(xe_uc_start(&gt->uc));
 err_fail:
 	xe_gt_err(gt, "reset failed (%pe)\n", ERR_PTR(err));
@@ -826,22 +829,25 @@ void xe_gt_reset_async(struct xe_gt *gt)
 
 void xe_gt_suspend_prepare(struct xe_gt *gt)
 {
-	XE_WARN_ON(xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL));
+	unsigned int fw_ref;
+
+	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
 
 	xe_uc_suspend_prepare(&gt->uc);
 
-	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 }
 
 int xe_gt_suspend(struct xe_gt *gt)
 {
+	unsigned int fw_ref;
 	int err;
 
 	xe_gt_dbg(gt, "suspending\n");
 	xe_gt_sanitize(gt);
 
-	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (err)
+	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL))
 		goto err_msg;
 
 	err = xe_uc_suspend(&gt->uc);
@@ -852,19 +858,29 @@ int xe_gt_suspend(struct xe_gt *gt)
 
 	xe_gt_disable_host_l2_vram(gt);
 
-	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 	xe_gt_dbg(gt, "suspended\n");
 
 	return 0;
 
-err_force_wake:
-	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 err_msg:
+	err = -ETIMEDOUT;
+err_force_wake:
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 	xe_gt_err(gt, "suspend failed (%pe)\n", ERR_PTR(err));
 
 	return err;
 }
 
+void xe_gt_shutdown(struct xe_gt *gt)
+{
+	unsigned int fw_ref;
+
+	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	do_gt_reset(gt);
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+}
+
 /**
  * xe_gt_sanitize_freq() - Restore saved frequencies if necessary.
  * @gt: the GT object
@@ -887,11 +903,12 @@ int xe_gt_sanitize_freq(struct xe_gt *gt)
 
 int xe_gt_resume(struct xe_gt *gt)
 {
+	unsigned int fw_ref;
 	int err;
 
 	xe_gt_dbg(gt, "resuming\n");
-	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (err)
+	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL))
 		goto err_msg;
 
 	err = do_gt_restart(gt);
@@ -900,14 +917,15 @@ int xe_gt_resume(struct xe_gt *gt)
 
 	xe_gt_idle_enable_pg(gt);
 
-	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 	xe_gt_dbg(gt, "resumed\n");
 
 	return 0;
 
-err_force_wake:
-	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 err_msg:
+	err = -ETIMEDOUT;
+err_force_wake:
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 	xe_gt_err(gt, "resume failed (%pe)\n", ERR_PTR(err));
 
 	return err;
diff --git a/drivers/gpu/drm/xe/xe_gt.h b/drivers/gpu/drm/xe/xe_gt.h
index ee138e9768a2..881f1cbc2c49 100644
--- a/drivers/gpu/drm/xe/xe_gt.h
+++ b/drivers/gpu/drm/xe/xe_gt.h
@@ -48,6 +48,7 @@ void xe_gt_record_user_engines(struct xe_gt *gt);
 
 void xe_gt_suspend_prepare(struct xe_gt *gt);
 int xe_gt_suspend(struct xe_gt *gt);
+void xe_gt_shutdown(struct xe_gt *gt);
 int xe_gt_resume(struct xe_gt *gt);
 void xe_gt_reset_async(struct xe_gt *gt);
 void xe_gt_sanitize(struct xe_gt *gt);
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index bcdd168cdc6d..c5bdf0f1b32f 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -52,6 +52,10 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define FEATURE_KBD_LED_REPORT_ID1 0x5d
 #define FEATURE_KBD_LED_REPORT_ID2 0x5e
 
+#define ROG_ALLY_REPORT_SIZE 64
+#define ROG_ALLY_X_MIN_MCU 313
+#define ROG_ALLY_MIN_MCU 319
+
 #define SUPPORT_KBD_BACKLIGHT BIT(0)
 
 #define MAX_TOUCH_MAJOR 8
@@ -84,6 +88,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_MEDION_E1239T		BIT(10)
 #define QUIRK_ROG_NKEY_KEYBOARD		BIT(11)
 #define QUIRK_ROG_CLAYMORE_II_KEYBOARD BIT(12)
+#define QUIRK_ROG_ALLY_XPAD		BIT(13)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -534,9 +539,99 @@ static bool asus_kbd_wmi_led_control_present(struct hid_device *hdev)
 	return !!(value & ASUS_WMI_DSTS_PRESENCE_BIT);
 }
 
+/*
+ * We don't care about any other part of the string except the version section.
+ * Example strings: FGA80100.RC72LA.312_T01, FGA80100.RC71LS.318_T01
+ * The bytes "5a 05 03 31 00 1a 13" and possibly more come before the version
+ * string, and there may be additional bytes after the version string such as
+ * "75 00 74 00 65 00" or a postfix such as "_T01"
+ */
+static int mcu_parse_version_string(const u8 *response, size_t response_size)
+{
+	const u8 *end = response + response_size;
+	const u8 *p = response;
+	int dots, err, version;
+	char buf[4];
+
+	dots = 0;
+	while (p < end && dots < 2) {
+		if (*p++ == '.')
+			dots++;
+	}
+
+	if (dots != 2 || p >= end || (p + 3) >= end)
+		return -EINVAL;
+
+	memcpy(buf, p, 3);
+	buf[3] = '\0';
+
+	err = kstrtoint(buf, 10, &version);
+	if (err || version < 0)
+		return -EINVAL;
+
+	return version;
+}
+
+static int mcu_request_version(struct hid_device *hdev)
+{
+	u8 *response __free(kfree) = kzalloc(ROG_ALLY_REPORT_SIZE, GFP_KERNEL);
+	const u8 request[] = { 0x5a, 0x05, 0x03, 0x31, 0x00, 0x20 };
+	int ret;
+
+	if (!response)
+		return -ENOMEM;
+
+	ret = asus_kbd_set_report(hdev, request, sizeof(request));
+	if (ret < 0)
+		return ret;
+
+	ret = hid_hw_raw_request(hdev, FEATURE_REPORT_ID, response,
+				ROG_ALLY_REPORT_SIZE, HID_FEATURE_REPORT,
+				HID_REQ_GET_REPORT);
+	if (ret < 0)
+		return ret;
+
+	ret = mcu_parse_version_string(response, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0) {
+		pr_err("Failed to parse MCU version: %d\n", ret);
+		print_hex_dump(KERN_ERR, "MCU: ", DUMP_PREFIX_NONE,
+			      16, 1, response, ROG_ALLY_REPORT_SIZE, false);
+	}
+
+	return ret;
+}
+
+static void validate_mcu_fw_version(struct hid_device *hdev, int idProduct)
+{
+	int min_version, version;
+
+	version = mcu_request_version(hdev);
+	if (version < 0)
+		return;
+
+	switch (idProduct) {
+	case USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY:
+		min_version = ROG_ALLY_MIN_MCU;
+		break;
+	case USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X:
+		min_version = ROG_ALLY_X_MIN_MCU;
+		break;
+	default:
+		min_version = 0;
+	}
+
+	if (version < min_version) {
+		hid_warn(hdev,
+			"The MCU firmware version must be %d or greater to avoid issues with suspend.\n",
+			min_version);
+	}
+}
+
 static int asus_kbd_register_leds(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct usb_interface *intf;
+	struct usb_device *udev;
 	unsigned char kbd_func;
 	int ret;
 
@@ -560,6 +655,14 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 			if (ret < 0)
 				return ret;
 		}
+
+		if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+			intf = to_usb_interface(hdev->dev.parent);
+			udev = interface_to_usbdev(intf);
+			validate_mcu_fw_version(hdev,
+				le16_to_cpu(udev->descriptor.idProduct));
+		}
+
 	} else {
 		/* Initialize keyboard */
 		ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
@@ -1280,10 +1383,10 @@ static const struct hid_device_id asus_devices[] = {
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_ALLY_XPAD},
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_ALLY_XPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_CLAYMORE_II_KEYBOARD),
 	  QUIRK_ROG_CLAYMORE_II_KEYBOARD },
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index f001ae880e1d..27306c17b0c4 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -206,11 +206,20 @@ int vmbus_connect(void)
 	INIT_LIST_HEAD(&vmbus_connection.chn_list);
 	mutex_init(&vmbus_connection.channel_mutex);
 
+	/*
+	 * The following Hyper-V interrupt and monitor pages can be used by
+	 * UIO for mapping to user-space, so they should always be allocated on
+	 * system page boundaries. The system page size must be >= the Hyper-V
+	 * page size.
+	 */
+	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
+
 	/*
 	 * Setup the vmbus event connection for channel interrupt
 	 * abstraction stuff
 	 */
-	vmbus_connection.int_page = hv_alloc_hyperv_zeroed_page();
+	vmbus_connection.int_page =
+		(void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 	if (vmbus_connection.int_page == NULL) {
 		ret = -ENOMEM;
 		goto cleanup;
@@ -225,8 +234,8 @@ int vmbus_connect(void)
 	 * Setup the monitor notification facility. The 1st page for
 	 * parent->child and the 2nd page for child->parent
 	 */
-	vmbus_connection.monitor_pages[0] = hv_alloc_hyperv_page();
-	vmbus_connection.monitor_pages[1] = hv_alloc_hyperv_page();
+	vmbus_connection.monitor_pages[0] = (void *)__get_free_page(GFP_KERNEL);
+	vmbus_connection.monitor_pages[1] = (void *)__get_free_page(GFP_KERNEL);
 	if ((vmbus_connection.monitor_pages[0] == NULL) ||
 	    (vmbus_connection.monitor_pages[1] == NULL)) {
 		ret = -ENOMEM;
@@ -342,21 +351,23 @@ void vmbus_disconnect(void)
 		destroy_workqueue(vmbus_connection.work_queue);
 
 	if (vmbus_connection.int_page) {
-		hv_free_hyperv_page(vmbus_connection.int_page);
+		free_page((unsigned long)vmbus_connection.int_page);
 		vmbus_connection.int_page = NULL;
 	}
 
 	if (vmbus_connection.monitor_pages[0]) {
 		if (!set_memory_encrypted(
 			(unsigned long)vmbus_connection.monitor_pages[0], 1))
-			hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
+			free_page((unsigned long)
+				vmbus_connection.monitor_pages[0]);
 		vmbus_connection.monitor_pages[0] = NULL;
 	}
 
 	if (vmbus_connection.monitor_pages[1]) {
 		if (!set_memory_encrypted(
 			(unsigned long)vmbus_connection.monitor_pages[1], 1))
-			hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
+			free_page((unsigned long)
+				vmbus_connection.monitor_pages[1]);
 		vmbus_connection.monitor_pages[1] = NULL;
 	}
 }
diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
index a3a07662e491..8aeec16a7a90 100644
--- a/drivers/hwmon/ftsteutates.c
+++ b/drivers/hwmon/ftsteutates.c
@@ -423,13 +423,16 @@ static int fts_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		break;
 	case hwmon_pwm:
 		switch (attr) {
-		case hwmon_pwm_auto_channels_temp:
-			if (data->fan_source[channel] == FTS_FAN_SOURCE_INVALID)
+		case hwmon_pwm_auto_channels_temp: {
+			u8 fan_source = data->fan_source[channel];
+
+			if (fan_source == FTS_FAN_SOURCE_INVALID || fan_source >= BITS_PER_LONG)
 				*val = 0;
 			else
-				*val = BIT(data->fan_source[channel]);
+				*val = BIT(fan_source);
 
 			return 0;
+		}
 		default:
 			break;
 		}
diff --git a/drivers/hwmon/ltc4282.c b/drivers/hwmon/ltc4282.c
index 4f608a3790fb..953dfe2bd166 100644
--- a/drivers/hwmon/ltc4282.c
+++ b/drivers/hwmon/ltc4282.c
@@ -1511,13 +1511,6 @@ static int ltc4282_setup(struct ltc4282_state *st, struct device *dev)
 			return ret;
 	}
 
-	if (device_property_read_bool(dev, "adi,fault-log-enable")) {
-		ret = regmap_set_bits(st->map, LTC4282_ADC_CTRL,
-				      LTC4282_FAULT_LOG_EN_MASK);
-		if (ret)
-			return ret;
-	}
-
 	if (device_property_read_bool(dev, "adi,fault-log-enable")) {
 		ret = regmap_set_bits(st->map, LTC4282_ADC_CTRL, LTC4282_FAULT_LOG_EN_MASK);
 		if (ret)
diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 9486db249c64..b3694a4209b9 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -459,12 +459,10 @@ static ssize_t occ_show_power_1(struct device *dev,
 	return sysfs_emit(buf, "%llu\n", val);
 }
 
-static u64 occ_get_powr_avg(u64 *accum, u32 *samples)
+static u64 occ_get_powr_avg(u64 accum, u32 samples)
 {
-	u64 divisor = get_unaligned_be32(samples);
-
-	return (divisor == 0) ? 0 :
-		div64_u64(get_unaligned_be64(accum) * 1000000ULL, divisor);
+	return (samples == 0) ? 0 :
+		mul_u64_u32_div(accum, 1000000UL, samples);
 }
 
 static ssize_t occ_show_power_2(struct device *dev,
@@ -489,8 +487,8 @@ static ssize_t occ_show_power_2(struct device *dev,
 				  get_unaligned_be32(&power->sensor_id),
 				  power->function_id, power->apss_channel);
 	case 1:
-		val = occ_get_powr_avg(&power->accumulator,
-				       &power->update_tag);
+		val = occ_get_powr_avg(get_unaligned_be64(&power->accumulator),
+				       get_unaligned_be32(&power->update_tag));
 		break;
 	case 2:
 		val = (u64)get_unaligned_be32(&power->update_tag) *
@@ -527,8 +525,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
 		return sysfs_emit(buf, "%u_system\n",
 				  get_unaligned_be32(&power->sensor_id));
 	case 1:
-		val = occ_get_powr_avg(&power->system.accumulator,
-				       &power->system.update_tag);
+		val = occ_get_powr_avg(get_unaligned_be64(&power->system.accumulator),
+				       get_unaligned_be32(&power->system.update_tag));
 		break;
 	case 2:
 		val = (u64)get_unaligned_be32(&power->system.update_tag) *
@@ -541,8 +539,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
 		return sysfs_emit(buf, "%u_proc\n",
 				  get_unaligned_be32(&power->sensor_id));
 	case 5:
-		val = occ_get_powr_avg(&power->proc.accumulator,
-				       &power->proc.update_tag);
+		val = occ_get_powr_avg(get_unaligned_be64(&power->proc.accumulator),
+				       get_unaligned_be32(&power->proc.update_tag));
 		break;
 	case 6:
 		val = (u64)get_unaligned_be32(&power->proc.update_tag) *
@@ -555,8 +553,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
 		return sysfs_emit(buf, "%u_vdd\n",
 				  get_unaligned_be32(&power->sensor_id));
 	case 9:
-		val = occ_get_powr_avg(&power->vdd.accumulator,
-				       &power->vdd.update_tag);
+		val = occ_get_powr_avg(get_unaligned_be64(&power->vdd.accumulator),
+				       get_unaligned_be32(&power->vdd.update_tag));
 		break;
 	case 10:
 		val = (u64)get_unaligned_be32(&power->vdd.update_tag) *
@@ -569,8 +567,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
 		return sysfs_emit(buf, "%u_vdn\n",
 				  get_unaligned_be32(&power->sensor_id));
 	case 13:
-		val = occ_get_powr_avg(&power->vdn.accumulator,
-				       &power->vdn.update_tag);
+		val = occ_get_powr_avg(get_unaligned_be64(&power->vdn.accumulator),
+				       get_unaligned_be32(&power->vdn.update_tag));
 		break;
 	case 14:
 		val = (u64)get_unaligned_be32(&power->vdn.update_tag) *
@@ -747,29 +745,30 @@ static ssize_t occ_show_extended(struct device *dev,
 }
 
 /*
- * Some helper macros to make it easier to define an occ_attribute. Since these
- * are dynamically allocated, we shouldn't use the existing kernel macros which
+ * A helper to make it easier to define an occ_attribute. Since these
+ * are dynamically allocated, we cannot use the existing kernel macros which
  * stringify the name argument.
  */
-#define ATTR_OCC(_name, _mode, _show, _store) {				\
-	.attr	= {							\
-		.name = _name,						\
-		.mode = VERIFY_OCTAL_PERMISSIONS(_mode),		\
-	},								\
-	.show	= _show,						\
-	.store	= _store,						\
-}
-
-#define SENSOR_ATTR_OCC(_name, _mode, _show, _store, _nr, _index) {	\
-	.dev_attr	= ATTR_OCC(_name, _mode, _show, _store),	\
-	.index		= _index,					\
-	.nr		= _nr,						\
+static void occ_init_attribute(struct occ_attribute *attr, int mode,
+	ssize_t (*show)(struct device *dev, struct device_attribute *attr, char *buf),
+	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
+				   const char *buf, size_t count),
+	int nr, int index, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vsnprintf(attr->name, sizeof(attr->name), fmt, args);
+	va_end(args);
+
+	attr->sensor.dev_attr.attr.name = attr->name;
+	attr->sensor.dev_attr.attr.mode = mode;
+	attr->sensor.dev_attr.show = show;
+	attr->sensor.dev_attr.store = store;
+	attr->sensor.index = index;
+	attr->sensor.nr = nr;
 }
 
-#define OCC_INIT_ATTR(_name, _mode, _show, _store, _nr, _index)		\
-	((struct sensor_device_attribute_2)				\
-		SENSOR_ATTR_OCC(_name, _mode, _show, _store, _nr, _index))
-
 /*
  * Allocate and instatiate sensor_device_attribute_2s. It's most efficient to
  * use our own instead of the built-in hwmon attribute types.
@@ -855,14 +854,15 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 		sensors->extended.num_sensors = 0;
 	}
 
-	occ->attrs = devm_kzalloc(dev, sizeof(*occ->attrs) * num_attrs,
+	occ->attrs = devm_kcalloc(dev, num_attrs, sizeof(*occ->attrs),
 				  GFP_KERNEL);
 	if (!occ->attrs)
 		return -ENOMEM;
 
 	/* null-terminated list */
-	occ->group.attrs = devm_kzalloc(dev, sizeof(*occ->group.attrs) *
-					num_attrs + 1, GFP_KERNEL);
+	occ->group.attrs = devm_kcalloc(dev, num_attrs + 1,
+					sizeof(*occ->group.attrs),
+					GFP_KERNEL);
 	if (!occ->group.attrs)
 		return -ENOMEM;
 
@@ -872,43 +872,33 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 		s = i + 1;
 		temp = ((struct temp_sensor_2 *)sensors->temp.data) + i;
 
-		snprintf(attr->name, sizeof(attr->name), "temp%d_label", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_temp, NULL,
-					     0, i);
+		occ_init_attribute(attr, 0444, show_temp, NULL,
+				   0, i, "temp%d_label", s);
 		attr++;
 
 		if (sensors->temp.version == 2 &&
 		    temp->fru_type == OCC_FRU_TYPE_VRM) {
-			snprintf(attr->name, sizeof(attr->name),
-				 "temp%d_alarm", s);
+			occ_init_attribute(attr, 0444, show_temp, NULL,
+					   1, i, "temp%d_alarm", s);
 		} else {
-			snprintf(attr->name, sizeof(attr->name),
-				 "temp%d_input", s);
+			occ_init_attribute(attr, 0444, show_temp, NULL,
+					   1, i, "temp%d_input", s);
 		}
 
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_temp, NULL,
-					     1, i);
 		attr++;
 
 		if (sensors->temp.version > 1) {
-			snprintf(attr->name, sizeof(attr->name),
-				 "temp%d_fru_type", s);
-			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-						     show_temp, NULL, 2, i);
+			occ_init_attribute(attr, 0444, show_temp, NULL,
+					   2, i, "temp%d_fru_type", s);
 			attr++;
 
-			snprintf(attr->name, sizeof(attr->name),
-				 "temp%d_fault", s);
-			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-						     show_temp, NULL, 3, i);
+			occ_init_attribute(attr, 0444, show_temp, NULL,
+					   3, i, "temp%d_fault", s);
 			attr++;
 
 			if (sensors->temp.version == 0x10) {
-				snprintf(attr->name, sizeof(attr->name),
-					 "temp%d_max", s);
-				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-							     show_temp, NULL,
-							     4, i);
+				occ_init_attribute(attr, 0444, show_temp, NULL,
+						   4, i, "temp%d_max", s);
 				attr++;
 			}
 		}
@@ -917,14 +907,12 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 	for (i = 0; i < sensors->freq.num_sensors; ++i) {
 		s = i + 1;
 
-		snprintf(attr->name, sizeof(attr->name), "freq%d_label", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_freq, NULL,
-					     0, i);
+		occ_init_attribute(attr, 0444, show_freq, NULL,
+				   0, i, "freq%d_label", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "freq%d_input", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_freq, NULL,
-					     1, i);
+		occ_init_attribute(attr, 0444, show_freq, NULL,
+				   1, i, "freq%d_input", s);
 		attr++;
 	}
 
@@ -940,32 +928,24 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 			s = (i * 4) + 1;
 
 			for (j = 0; j < 4; ++j) {
-				snprintf(attr->name, sizeof(attr->name),
-					 "power%d_label", s);
-				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-							     show_power, NULL,
-							     nr++, i);
+				occ_init_attribute(attr, 0444, show_power,
+						   NULL, nr++, i,
+						   "power%d_label", s);
 				attr++;
 
-				snprintf(attr->name, sizeof(attr->name),
-					 "power%d_average", s);
-				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-							     show_power, NULL,
-							     nr++, i);
+				occ_init_attribute(attr, 0444, show_power,
+						   NULL, nr++, i,
+						   "power%d_average", s);
 				attr++;
 
-				snprintf(attr->name, sizeof(attr->name),
-					 "power%d_average_interval", s);
-				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-							     show_power, NULL,
-							     nr++, i);
+				occ_init_attribute(attr, 0444, show_power,
+						   NULL, nr++, i,
+						   "power%d_average_interval", s);
 				attr++;
 
-				snprintf(attr->name, sizeof(attr->name),
-					 "power%d_input", s);
-				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-							     show_power, NULL,
-							     nr++, i);
+				occ_init_attribute(attr, 0444, show_power,
+						   NULL, nr++, i,
+						   "power%d_input", s);
 				attr++;
 
 				s++;
@@ -977,28 +957,20 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 		for (i = 0; i < sensors->power.num_sensors; ++i) {
 			s = i + 1;
 
-			snprintf(attr->name, sizeof(attr->name),
-				 "power%d_label", s);
-			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-						     show_power, NULL, 0, i);
+			occ_init_attribute(attr, 0444, show_power, NULL,
+					   0, i, "power%d_label", s);
 			attr++;
 
-			snprintf(attr->name, sizeof(attr->name),
-				 "power%d_average", s);
-			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-						     show_power, NULL, 1, i);
+			occ_init_attribute(attr, 0444, show_power, NULL,
+					   1, i, "power%d_average", s);
 			attr++;
 
-			snprintf(attr->name, sizeof(attr->name),
-				 "power%d_average_interval", s);
-			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-						     show_power, NULL, 2, i);
+			occ_init_attribute(attr, 0444, show_power, NULL,
+					   2, i, "power%d_average_interval", s);
 			attr++;
 
-			snprintf(attr->name, sizeof(attr->name),
-				 "power%d_input", s);
-			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-						     show_power, NULL, 3, i);
+			occ_init_attribute(attr, 0444, show_power, NULL,
+					   3, i, "power%d_input", s);
 			attr++;
 		}
 
@@ -1006,56 +978,43 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 	}
 
 	if (sensors->caps.num_sensors >= 1) {
-		snprintf(attr->name, sizeof(attr->name), "power%d_label", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
-					     0, 0);
+		occ_init_attribute(attr, 0444, show_caps, NULL,
+				   0, 0, "power%d_label", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "power%d_cap", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
-					     1, 0);
+		occ_init_attribute(attr, 0444, show_caps, NULL,
+				   1, 0, "power%d_cap", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "power%d_input", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
-					     2, 0);
+		occ_init_attribute(attr, 0444, show_caps, NULL,
+				   2, 0, "power%d_input", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name),
-			 "power%d_cap_not_redundant", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
-					     3, 0);
+		occ_init_attribute(attr, 0444, show_caps, NULL,
+				   3, 0, "power%d_cap_not_redundant", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "power%d_cap_max", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
-					     4, 0);
+		occ_init_attribute(attr, 0444, show_caps, NULL,
+				   4, 0, "power%d_cap_max", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "power%d_cap_min", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
-					     5, 0);
+		occ_init_attribute(attr, 0444, show_caps, NULL,
+				   5, 0, "power%d_cap_min", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "power%d_cap_user",
-			 s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0644, show_caps,
-					     occ_store_caps_user, 6, 0);
+		occ_init_attribute(attr, 0644, show_caps, occ_store_caps_user,
+				   6, 0, "power%d_cap_user", s);
 		attr++;
 
 		if (sensors->caps.version > 1) {
-			snprintf(attr->name, sizeof(attr->name),
-				 "power%d_cap_user_source", s);
-			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-						     show_caps, NULL, 7, 0);
+			occ_init_attribute(attr, 0444, show_caps, NULL,
+					   7, 0, "power%d_cap_user_source", s);
 			attr++;
 
 			if (sensors->caps.version > 2) {
-				snprintf(attr->name, sizeof(attr->name),
-					 "power%d_cap_min_soft", s);
-				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-							     show_caps, NULL,
-							     8, 0);
+				occ_init_attribute(attr, 0444, show_caps, NULL,
+						   8, 0,
+						   "power%d_cap_min_soft", s);
 				attr++;
 			}
 		}
@@ -1064,19 +1023,16 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 	for (i = 0; i < sensors->extended.num_sensors; ++i) {
 		s = i + 1;
 
-		snprintf(attr->name, sizeof(attr->name), "extn%d_label", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-					     occ_show_extended, NULL, 0, i);
+		occ_init_attribute(attr, 0444, occ_show_extended, NULL,
+				   0, i, "extn%d_label", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "extn%d_flags", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-					     occ_show_extended, NULL, 1, i);
+		occ_init_attribute(attr, 0444, occ_show_extended, NULL,
+				   1, i, "extn%d_flags", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "extn%d_input", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-					     occ_show_extended, NULL, 2, i);
+		occ_init_attribute(attr, 0444, occ_show_extended, NULL,
+				   2, i, "extn%d_input", s);
 		attr++;
 	}
 
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index f0f0f1f2131d..602e98e61cc0 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -94,7 +94,7 @@ static int i2c_dw_unreg_slave(struct i2c_client *slave)
 	i2c_dw_disable(dev);
 	synchronize_irq(dev->irq);
 	dev->slave = NULL;
-	pm_runtime_put(dev->dev);
+	pm_runtime_put_sync_suspend(dev->dev);
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index a693ebb64edf..7b6eb2bfb412 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -1969,10 +1969,14 @@ static int npcm_i2c_init_module(struct npcm_i2c *bus, enum i2c_mode mode,
 
 	/* Check HW is OK: SDA and SCL should be high at this point. */
 	if ((npcm_i2c_get_SDA(&bus->adap) == 0) || (npcm_i2c_get_SCL(&bus->adap) == 0)) {
-		dev_err(bus->dev, "I2C%d init fail: lines are low\n", bus->num);
-		dev_err(bus->dev, "SDA=%d SCL=%d\n", npcm_i2c_get_SDA(&bus->adap),
-			npcm_i2c_get_SCL(&bus->adap));
-		return -ENXIO;
+		dev_warn(bus->dev, " I2C%d SDA=%d SCL=%d, attempting to recover\n", bus->num,
+				 npcm_i2c_get_SDA(&bus->adap), npcm_i2c_get_SCL(&bus->adap));
+		if (npcm_i2c_recovery_tgclk(&bus->adap)) {
+			dev_err(bus->dev, "I2C%d init fail: SDA=%d SCL=%d\n",
+				bus->num, npcm_i2c_get_SDA(&bus->adap),
+				npcm_i2c_get_SCL(&bus->adap));
+			return -ENXIO;
+		}
 	}
 
 	npcm_i2c_int_enable(bus, true);
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 1df5b4204142..89ce8a62b37c 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1395,6 +1395,11 @@ static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			ret = tegra_i2c_xfer_msg(i2c_dev, &msgs[i], MSG_END_CONTINUE);
 			if (ret)
 				break;
+
+			/* Validate message length before proceeding */
+			if (msgs[i].buf[0] == 0 || msgs[i].buf[0] > I2C_SMBUS_BLOCK_MAX)
+				break;
+
 			/* Set the msg length from first byte */
 			msgs[i].len += msgs[i].buf[0];
 			dev_dbg(i2c_dev->dev, "reading %d bytes\n", msgs[i].len);
diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index acadabec4df7..5e17c1e6d2c7 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -22,6 +22,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -436,8 +437,16 @@ static int fxls8962af_read_raw(struct iio_dev *indio_dev,
 		*val = FXLS8962AF_TEMP_CENTER_VAL;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		return fxls8962af_read_full_scale(data, val2);
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = MILLIDEGREE_PER_DEGREE;
+			return IIO_VAL_INT;
+		case IIO_ACCEL:
+			*val = 0;
+			return fxls8962af_read_full_scale(data, val2);
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return fxls8962af_read_samp_freq(data, val, val2);
 	default:
@@ -736,9 +745,11 @@ static const struct iio_event_spec fxls8962af_event[] = {
 	.type = IIO_TEMP, \
 	.address = FXLS8962AF_TEMP_OUT, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE) | \
 			      BIT(IIO_CHAN_INFO_OFFSET),\
 	.scan_index = -1, \
 	.scan_type = { \
+		.sign = 's', \
 		.realbits = 8, \
 		.storagebits = 8, \
 	}, \
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6c4e74420fd2..216f3c9ce183 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1452,6 +1452,7 @@ config TI_ADS1298
 	tristate "Texas Instruments ADS1298"
 	depends on SPI
 	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 	help
 	  If you say yes here you get support for Texas Instruments ADS1298
 	  medical ADC chips
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 32a5448116a1..42112f97fac1 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -151,7 +151,7 @@ static int ad7606_spi_reg_write(struct ad7606_state *st,
 	struct spi_device *spi = to_spi_device(st->dev);
 
 	st->d16[0] = cpu_to_be16((st->bops->rd_wr_cmd(addr, 1) << 8) |
-				  (val & 0x1FF));
+				  (val & 0xFF));
 
 	return spi_write(spi, &st->d16[0], sizeof(st->d16[0]));
 }
diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 58a25792cec3..1e2cf512c2f5 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -290,6 +290,8 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
 
 	if (chan->scan_type.sign == 's')
 		*val = sign_extend32(*val, chan->scan_type.realbits - 1);
+	else
+		*val &= GENMASK(chan->scan_type.realbits - 1, 0);
 
 	return IIO_VAL_INT;
 }
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 213cce1c3111..91f0f381082b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -67,16 +67,18 @@ int inv_icm42600_temp_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	/*
 	 * T°C = (temp / 132.48) + 25
-	 * Tm°C = 1000 * ((temp * 100 / 13248) + 25)
+	 * Tm°C = 1000 * ((temp / 132.48) + 25)
+	 * Tm°C = 7.548309 * temp + 25000
+	 * Tm°C = (temp + 3312) * 7.548309
 	 * scale: 100000 / 13248 ~= 7.548309
-	 * offset: 25000
+	 * offset: 3312
 	 */
 	case IIO_CHAN_INFO_SCALE:
 		*val = 7;
 		*val2 = 548309;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = 25000;
+		*val = 3312;
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 7e3a55349e10..96a678250e55 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -366,12 +366,9 @@ EXPORT_SYMBOL(iw_cm_disconnect);
 /*
  * CM_ID <-- DESTROYING
  *
- * Clean up all resources associated with the connection and release
- * the initial reference taken by iw_create_cm_id.
- *
- * Returns true if and only if the last cm_id_priv reference has been dropped.
+ * Clean up all resources associated with the connection.
  */
-static bool destroy_cm_id(struct iw_cm_id *cm_id)
+static void destroy_cm_id(struct iw_cm_id *cm_id)
 {
 	struct iwcm_id_private *cm_id_priv;
 	struct ib_qp *qp;
@@ -440,20 +437,22 @@ static bool destroy_cm_id(struct iw_cm_id *cm_id)
 		iwpm_remove_mapinfo(&cm_id->local_addr, &cm_id->m_local_addr);
 		iwpm_remove_mapping(&cm_id->local_addr, RDMA_NL_IWCM);
 	}
-
-	return iwcm_deref_id(cm_id_priv);
 }
 
 /*
- * This function is only called by the application thread and cannot
- * be called by the event thread. The function will wait for all
- * references to be released on the cm_id and then kfree the cm_id
- * object.
+ * Destroy cm_id. If the cm_id still has other references, wait for all
+ * references to be released on the cm_id and then release the initial
+ * reference taken by iw_create_cm_id.
  */
 void iw_destroy_cm_id(struct iw_cm_id *cm_id)
 {
-	if (!destroy_cm_id(cm_id))
+	struct iwcm_id_private *cm_id_priv;
+
+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+	destroy_cm_id(cm_id);
+	if (refcount_read(&cm_id_priv->refcount) > 1)
 		flush_workqueue(iwcm_wq);
+	iwcm_deref_id(cm_id_priv);
 }
 EXPORT_SYMBOL(iw_destroy_cm_id);
 
@@ -1033,8 +1032,10 @@ static void cm_work_handler(struct work_struct *_work)
 
 		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
 			ret = process_event(cm_id_priv, &levent);
-			if (ret)
-				WARN_ON_ONCE(destroy_cm_id(&cm_id_priv->id));
+			if (ret) {
+				destroy_cm_id(&cm_id_priv->id);
+				WARN_ON_ONCE(iwcm_deref_id(cm_id_priv));
+			}
 		} else
 			pr_debug("dropping event %d\n", levent.event);
 		if (iwcm_deref_id(cm_id_priv))
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 985b9d7d69f2..81e44b738122 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -942,7 +942,7 @@ static void fill_wqe_idx(struct hns_roce_srq *srq, unsigned int wqe_idx)
 static void update_srq_db(struct hns_roce_srq *srq)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(srq->ibsrq.device);
-	struct hns_roce_v2_db db;
+	struct hns_roce_v2_db db = {};
 
 	hr_reg_write(&db, DB_TAG, srq->srqn);
 	hr_reg_write(&db, DB_CMD, HNS_ROCE_V2_SRQ_DB);
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 380fe8dab3b0..9514f577995f 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -449,6 +449,8 @@ static enum hrtimer_restart gpio_keys_irq_timer(struct hrtimer *t)
 						      release_timer);
 	struct input_dev *input = bdata->input;
 
+	guard(spinlock_irqsave)(&bdata->lock);
+
 	if (bdata->key_pressed) {
 		input_report_key(input, *bdata->code, 0);
 		input_sync(input);
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 4215f9b9c2b0..fc22cbb854a3 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -844,6 +844,12 @@ static int ims_pcu_flash_firmware(struct ims_pcu *pcu,
 		addr = be32_to_cpu(rec->addr) / 2;
 		len = be16_to_cpu(rec->len);
 
+		if (len > sizeof(pcu->cmd_buf) - 1 - sizeof(*fragment)) {
+			dev_err(pcu->dev,
+				"Invalid record length in firmware: %d\n", len);
+			return -EINVAL;
+		}
+
 		fragment = (void *)&pcu->cmd_buf[1];
 		put_unaligned_le32(addr, &fragment->addr);
 		fragment->len = len;
diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index 20020cbc0752..a94699f2bbc6 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -75,9 +75,14 @@ static int bbc_spkr_event(struct input_dev *dev, unsigned int type, unsigned int
 		return -1;
 
 	switch (code) {
-		case SND_BELL: if (value) value = 1000;
-		case SND_TONE: break;
-		default: return -1;
+	case SND_BELL:
+		if (value)
+			value = 1000;
+		break;
+	case SND_TONE:
+		break;
+	default:
+		return -1;
 	}
 
 	if (value > 20 && value < 32767)
@@ -113,9 +118,14 @@ static int grover_spkr_event(struct input_dev *dev, unsigned int type, unsigned
 		return -1;
 
 	switch (code) {
-		case SND_BELL: if (value) value = 1000;
-		case SND_TONE: break;
-		default: return -1;
+	case SND_BELL:
+		if (value)
+			value = 1000;
+		break;
+	case SND_TONE:
+		break;
+	default:
+		return -1;
 	}
 
 	if (value > 20 && value < 32767)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f61e48f23732..23e78a034da8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -107,7 +107,9 @@ static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
-	struct acpihid_map_entry *p;
+	struct acpihid_map_entry *p, *p1 = NULL;
+	int hid_count = 0;
+	bool fw_bug;
 
 	if (!adev)
 		return -ENODEV;
@@ -115,12 +117,33 @@ static inline int get_acpihid_device_id(struct device *dev,
 	list_for_each_entry(p, &acpihid_map, list) {
 		if (acpi_dev_hid_uid_match(adev, p->hid,
 					   p->uid[0] ? p->uid : NULL)) {
-			if (entry)
-				*entry = p;
-			return p->devid;
+			p1 = p;
+			fw_bug = false;
+			hid_count = 1;
+			break;
+		}
+
+		/*
+		 * Count HID matches w/o UID, raise FW_BUG but allow exactly one match
+		 */
+		if (acpi_dev_hid_match(adev, p->hid)) {
+			p1 = p;
+			hid_count++;
+			fw_bug = true;
 		}
 	}
-	return -EINVAL;
+
+	if (!p1)
+		return -EINVAL;
+	if (fw_bug)
+		dev_err_once(dev, FW_BUG "No ACPI device matched UID, but %d device%s matched HID.\n",
+			     hid_count, hid_count > 1 ? "s" : "");
+	if (hid_count > 1)
+		return -EINVAL;
+	if (entry)
+		*entry = p1;
+
+	return p1->devid;
 }
 
 static inline int get_device_sbdf_id(struct device *dev)
@@ -838,6 +861,14 @@ int amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 {
 	iommu_ga_log_notifier = notifier;
 
+	/*
+	 * Ensure all in-flight IRQ handlers run to completion before returning
+	 * to the caller, e.g. to ensure module code isn't unloaded while it's
+	 * being executed in the IRQ handler.
+	 */
+	if (!notifier)
+		synchronize_rcu();
+
 	return 0;
 }
 EXPORT_SYMBOL(amd_iommu_register_ga_log_notifier);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 157542c07aaa..56e9f125cda9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1970,6 +1970,7 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		return ret;
 
 	info->domain = domain;
+	info->domain_attached = true;
 	spin_lock_irqsave(&domain->lock, flags);
 	list_add(&info->link, &domain->devices);
 	spin_unlock_irqrestore(&domain->lock, flags);
@@ -3381,6 +3382,10 @@ void device_block_translation(struct device *dev)
 	struct intel_iommu *iommu = info->iommu;
 	unsigned long flags;
 
+	/* Device in DMA blocking state. Noting to do. */
+	if (!info->domain_attached)
+		return;
+
 	if (info->domain)
 		cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
 
@@ -3393,6 +3398,9 @@ void device_block_translation(struct device *dev)
 			domain_context_clear(info);
 	}
 
+	/* Device now in DMA blocking state. */
+	info->domain_attached = false;
+
 	if (!info->domain)
 		return;
 
@@ -4406,6 +4414,9 @@ static int device_set_dirty_tracking(struct list_head *devices, bool enable)
 			break;
 	}
 
+	if (!ret)
+		info->domain_attached = true;
+
 	return ret;
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1497f3112b12..6f16eeb2ac65 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -776,6 +776,7 @@ struct device_domain_info {
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
 	u8 dtlb_extra_inval:1;	/* Quirk for devices need extra flush */
+	u8 domain_attached:1;	/* Device has domain attached */
 	u8 ats_qdep;
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
 	struct intel_iommu *iommu; /* IOMMU used by this device */
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 433c58944401..3b5251034a87 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -27,8 +27,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	unsigned long flags;
 	int ret = 0;
 
-	if (info->domain)
-		device_block_translation(dev);
+	device_block_translation(dev);
 
 	if (iommu->agaw < dmar_domain->s2_domain->agaw) {
 		dev_err_ratelimited(dev, "Adjusted guest address width not compatible\n");
@@ -62,6 +61,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 		goto unassign_tag;
 
 	info->domain = dmar_domain;
+	info->domain_attached = true;
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_add(&info->link, &dmar_domain->devices);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index 9511dae5b556..94b6c43dfa5c 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -133,10 +133,9 @@ static void queue_bio(struct mirror_set *ms, struct bio *bio, int rw)
 	spin_lock_irqsave(&ms->lock, flags);
 	should_wake = !(bl->head);
 	bio_list_add(bl, bio);
-	spin_unlock_irqrestore(&ms->lock, flags);
-
 	if (should_wake)
 		wakeup_mirrord(ms);
+	spin_unlock_irqrestore(&ms->lock, flags);
 }
 
 static void dispatch_bios(void *context, struct bio_list *bio_list)
@@ -646,9 +645,9 @@ static void write_callback(unsigned long error, void *context)
 	if (!ms->failures.head)
 		should_wake = 1;
 	bio_list_add(&ms->failures, bio);
-	spin_unlock_irqrestore(&ms->lock, flags);
 	if (should_wake)
 		wakeup_mirrord(ms);
+	spin_unlock_irqrestore(&ms->lock, flags);
 }
 
 static void do_write(struct mirror_set *ms, struct bio *bio)
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 883f01e78324..e45cffdd419a 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -431,6 +431,7 @@ static int dm_set_device_limits(struct dm_target *ti, struct dm_dev *dev,
 		return 0;
 	}
 
+	mutex_lock(&q->limits_lock);
 	if (blk_stack_limits(limits, &q->limits,
 			get_start_sect(bdev) + start) < 0)
 		DMWARN("%s: adding target device %pg caused an alignment inconsistency: "
@@ -448,6 +449,7 @@ static int dm_set_device_limits(struct dm_target *ti, struct dm_dev *dev,
 	 */
 	if (!dm_target_has_integrity(ti->type))
 		queue_limits_stack_integrity_bdev(limits, bdev);
+	mutex_unlock(&q->limits_lock);
 	return 0;
 }
 
@@ -1734,8 +1736,12 @@ static int device_not_write_zeroes_capable(struct dm_target *ti, struct dm_dev *
 					   sector_t start, sector_t len, void *data)
 {
 	struct request_queue *q = bdev_get_queue(dev->bdev);
+	int b;
 
-	return !q->limits.max_write_zeroes_sectors;
+	mutex_lock(&q->limits_lock);
+	b = !q->limits.max_write_zeroes_sectors;
+	mutex_unlock(&q->limits_lock);
+	return b;
 }
 
 static bool dm_table_supports_write_zeroes(struct dm_table *t)
diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 6bd9848518d4..559b8179ac50 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -604,6 +604,10 @@ int verity_fec_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
 	(*argc)--;
 
 	if (!strcasecmp(arg_name, DM_VERITY_OPT_FEC_DEV)) {
+		if (v->fec->dev) {
+			ti->error = "FEC device already specified";
+			return -EINVAL;
+		}
 		r = dm_get_device(ti, arg_value, BLK_OPEN_READ, &v->fec->dev);
 		if (r) {
 			ti->error = "FEC device lookup failed";
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 53ba0fbdf495..ce0462e751a6 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1080,6 +1080,9 @@ static int verity_alloc_most_once(struct dm_verity *v)
 {
 	struct dm_target *ti = v->ti;
 
+	if (v->validated_blocks)
+		return 0;
+
 	/* the bitset can only handle INT_MAX blocks */
 	if (v->data_blocks > INT_MAX) {
 		ti->error = "device too large to use check_at_most_once";
@@ -1103,6 +1106,9 @@ static int verity_alloc_zero_digest(struct dm_verity *v)
 	struct dm_verity_io *io;
 	u8 *zero_data;
 
+	if (v->zero_digest)
+		return 0;
+
 	v->zero_digest = kmalloc(v->digest_size, GFP_KERNEL);
 
 	if (!v->zero_digest)
@@ -1537,7 +1543,7 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 			goto bad;
 	}
 
-	/* Root hash signature is  a optional parameter*/
+	/* Root hash signature is an optional parameter */
 	r = verity_verify_root_hash(root_hash_digest_to_validate,
 				    strlen(root_hash_digest_to_validate),
 				    verify_args.sig,
diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
index a9e2c6c0a33c..d5261a0e4232 100644
--- a/drivers/md/dm-verity-verify-sig.c
+++ b/drivers/md/dm-verity-verify-sig.c
@@ -71,9 +71,14 @@ int verity_verify_sig_parse_opt_args(struct dm_arg_set *as,
 				     const char *arg_name)
 {
 	struct dm_target *ti = v->ti;
-	int ret = 0;
+	int ret;
 	const char *sig_key = NULL;
 
+	if (v->signature_key_desc) {
+		ti->error = DM_VERITY_VERIFY_ERR("root_hash_sig_key_desc already specified");
+		return -EINVAL;
+	}
+
 	if (!*argc) {
 		ti->error = DM_VERITY_VERIFY_ERR("Signature key not specified");
 		return -EINVAL;
@@ -83,14 +88,18 @@ int verity_verify_sig_parse_opt_args(struct dm_arg_set *as,
 	(*argc)--;
 
 	ret = verity_verify_get_sig_from_key(sig_key, sig_opts);
-	if (ret < 0)
+	if (ret < 0) {
 		ti->error = DM_VERITY_VERIFY_ERR("Invalid key specified");
+		return ret;
+	}
 
 	v->signature_key_desc = kstrdup(sig_key, GFP_KERNEL);
-	if (!v->signature_key_desc)
+	if (!v->signature_key_desc) {
+		ti->error = DM_VERITY_VERIFY_ERR("Could not allocate memory for signature key");
 		return -ENOMEM;
+	}
 
-	return ret;
+	return 0;
 }
 
 /*
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 6975a71d740f..a5aa6a2a028c 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -469,7 +469,7 @@ vb2_dma_sg_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
 	struct vb2_dma_sg_buf *buf = dbuf->priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
 	return 0;
 }
 
@@ -480,7 +480,7 @@ vb2_dma_sg_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
 	struct vb2_dma_sg_buf *buf = dbuf->priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
 	return 0;
 }
 
diff --git a/drivers/media/i2c/ccs-pll.c b/drivers/media/i2c/ccs-pll.c
index cf8858cb13d4..611c9823be85 100644
--- a/drivers/media/i2c/ccs-pll.c
+++ b/drivers/media/i2c/ccs-pll.c
@@ -312,6 +312,11 @@ __ccs_pll_calculate_vt_tree(struct device *dev,
 	dev_dbg(dev, "more_mul2: %u\n", more_mul);
 
 	pll_fr->pll_multiplier = mul * more_mul;
+	if (pll_fr->pll_multiplier > lim_fr->max_pll_multiplier) {
+		dev_dbg(dev, "pll multiplier %u too high\n",
+			pll_fr->pll_multiplier);
+		return -EINVAL;
+	}
 
 	if (pll_fr->pll_multiplier * pll_fr->pll_ip_clk_freq_hz >
 	    lim_fr->max_pll_op_clk_freq_hz)
@@ -397,6 +402,8 @@ static int ccs_pll_calculate_vt_tree(struct device *dev,
 	min_pre_pll_clk_div = max_t(u16, min_pre_pll_clk_div,
 				    pll->ext_clk_freq_hz /
 				    lim_fr->max_pll_ip_clk_freq_hz);
+	if (!(pll->flags & CCS_PLL_FLAG_EXT_IP_PLL_DIVIDER))
+		min_pre_pll_clk_div = clk_div_even(min_pre_pll_clk_div);
 
 	dev_dbg(dev, "vt min/max_pre_pll_clk_div: %u,%u\n",
 		min_pre_pll_clk_div, max_pre_pll_clk_div);
@@ -792,7 +799,7 @@ int ccs_pll_calculate(struct device *dev, const struct ccs_pll_limits *lim,
 		op_lim_fr->min_pre_pll_clk_div, op_lim_fr->max_pre_pll_clk_div);
 	max_op_pre_pll_clk_div =
 		min_t(u16, op_lim_fr->max_pre_pll_clk_div,
-		      clk_div_even(pll->ext_clk_freq_hz /
+		      DIV_ROUND_UP(pll->ext_clk_freq_hz,
 				   op_lim_fr->min_pll_ip_clk_freq_hz));
 	min_op_pre_pll_clk_div =
 		max_t(u16, op_lim_fr->min_pre_pll_clk_div,
@@ -815,6 +822,8 @@ int ccs_pll_calculate(struct device *dev, const struct ccs_pll_limits *lim,
 			      one_or_more(
 				      DIV_ROUND_UP(op_lim_fr->max_pll_op_clk_freq_hz,
 						   pll->ext_clk_freq_hz))));
+	if (!(pll->flags & CCS_PLL_FLAG_EXT_IP_PLL_DIVIDER))
+		min_op_pre_pll_clk_div = clk_div_even(min_op_pre_pll_clk_div);
 	dev_dbg(dev, "pll_op check: min / max op_pre_pll_clk_div: %u / %u\n",
 		min_op_pre_pll_clk_div, max_op_pre_pll_clk_div);
 
diff --git a/drivers/media/i2c/ds90ub913.c b/drivers/media/i2c/ds90ub913.c
index 7670d6c82d92..5d754372230e 100644
--- a/drivers/media/i2c/ds90ub913.c
+++ b/drivers/media/i2c/ds90ub913.c
@@ -450,10 +450,10 @@ static int ub913_set_fmt(struct v4l2_subdev *sd,
 	if (!fmt)
 		return -EINVAL;
 
-	format->format.code = finfo->outcode;
-
 	*fmt = format->format;
 
+	fmt->code = finfo->outcode;
+
 	return 0;
 }
 
diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 0beb80b8c458..9b4db4cd4929 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -31,7 +31,7 @@
 #define IMX335_REG_CPWAIT_TIME		CCI_REG8(0x300d)
 #define IMX335_REG_WINMODE		CCI_REG8(0x3018)
 #define IMX335_REG_HTRIMMING_START	CCI_REG16_LE(0x302c)
-#define IMX335_REG_HNUM			CCI_REG8(0x302e)
+#define IMX335_REG_HNUM			CCI_REG16_LE(0x302e)
 
 /* Lines per frame */
 #define IMX335_REG_VMAX			CCI_REG24_LE(0x3030)
@@ -660,7 +660,8 @@ static int imx335_enum_frame_size(struct v4l2_subdev *sd,
 	struct imx335 *imx335 = to_imx335(sd);
 	u32 code;
 
-	if (fsize->index > ARRAY_SIZE(imx335_mbus_codes))
+	/* Only a single supported_mode available. */
+	if (fsize->index > 0)
 		return -EINVAL;
 
 	code = imx335_get_format_code(imx335, fsize->code);
diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c
index bd0b2f0f0d45..3a0835fa5766 100644
--- a/drivers/media/i2c/ov2740.c
+++ b/drivers/media/i2c/ov2740.c
@@ -1404,12 +1404,12 @@ static int ov2740_probe(struct i2c_client *client)
 	return 0;
 
 probe_error_v4l2_subdev_cleanup:
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
 	v4l2_subdev_cleanup(&ov2740->sd);
 
 probe_error_media_entity_cleanup:
 	media_entity_cleanup(&ov2740->sd.entity);
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
 
 probe_error_v4l2_ctrl_handler_free:
 	v4l2_ctrl_handler_free(ov2740->sd.ctrl_handler);
diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
index 2833b14ee139..c0ab3c0ed88e 100644
--- a/drivers/media/i2c/ov5675.c
+++ b/drivers/media/i2c/ov5675.c
@@ -1295,11 +1295,8 @@ static int ov5675_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	ret = ov5675_get_hwcfg(ov5675, &client->dev);
-	if (ret) {
-		dev_err(&client->dev, "failed to get HW configuration: %d",
-			ret);
+	if (ret)
 		return ret;
-	}
 
 	v4l2_i2c_subdev_init(&ov5675->sd, client, &ov5675_subdev_ops);
 
diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index 3b94338f55ed..23d524de7d60 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -2276,8 +2276,8 @@ static int ov8856_get_hwcfg(struct ov8856 *ov8856, struct device *dev)
 	if (!is_acpi_node(fwnode)) {
 		ov8856->xvclk = devm_clk_get(dev, "xvclk");
 		if (IS_ERR(ov8856->xvclk)) {
-			dev_err(dev, "could not get xvclk clock (%pe)\n",
-				ov8856->xvclk);
+			dev_err_probe(dev, PTR_ERR(ov8856->xvclk),
+				      "could not get xvclk clock\n");
 			return PTR_ERR(ov8856->xvclk);
 		}
 
@@ -2382,11 +2382,8 @@ static int ov8856_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	ret = ov8856_get_hwcfg(ov8856, &client->dev);
-	if (ret) {
-		dev_err(&client->dev, "failed to get HW configuration: %d",
-			ret);
+	if (ret)
 		return ret;
-	}
 
 	v4l2_i2c_subdev_init(&ov8856->sd, client, &ov8856_subdev_ops);
 
diff --git a/drivers/media/pci/intel/ipu6/ipu6-dma.c b/drivers/media/pci/intel/ipu6/ipu6-dma.c
index b71f66bd8c1f..92d513608395 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-dma.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-dma.c
@@ -172,7 +172,7 @@ void *ipu6_dma_alloc(struct ipu6_bus_device *sys, size_t size,
 	count = PHYS_PFN(size);
 
 	iova = alloc_iova(&mmu->dmap->iovad, count,
-			  PHYS_PFN(dma_get_mask(dev)), 0);
+			  PHYS_PFN(mmu->dmap->mmu_info->aperture_end), 0);
 	if (!iova)
 		goto out_kfree;
 
@@ -398,7 +398,7 @@ int ipu6_dma_map_sg(struct ipu6_bus_device *sys, struct scatterlist *sglist,
 		nents, npages);
 
 	iova = alloc_iova(&mmu->dmap->iovad, npages,
-			  PHYS_PFN(dma_get_mask(dev)), 0);
+			  PHYS_PFN(mmu->dmap->mmu_info->aperture_end), 0);
 	if (!iova)
 		return 0;
 
diff --git a/drivers/media/pci/intel/ipu6/ipu6.c b/drivers/media/pci/intel/ipu6/ipu6.c
index 91718eabd74e..1c5c38a30e62 100644
--- a/drivers/media/pci/intel/ipu6/ipu6.c
+++ b/drivers/media/pci/intel/ipu6/ipu6.c
@@ -463,11 +463,6 @@ static int ipu6_pci_config_setup(struct pci_dev *dev, u8 hw_ver)
 {
 	int ret;
 
-	/* disable IPU6 PCI ATS on mtl ES2 */
-	if (is_ipu6ep_mtl(hw_ver) && boot_cpu_data.x86_stepping == 0x2 &&
-	    pci_ats_supported(dev))
-		pci_disable_ats(dev);
-
 	/* No PCI msi capability for IPU6EP */
 	if (is_ipu6ep(hw_ver) || is_ipu6ep_mtl(hw_ver)) {
 		/* likely do nothing as msi not enabled by default */
diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index 187f2d8abfbb..cb1f7de1b632 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -1057,8 +1057,11 @@ static int e5010_probe(struct platform_device *pdev)
 	e5010->vdev->lock = &e5010->mutex;
 
 	ret = v4l2_device_register(dev, &e5010->v4l2_dev);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to register v4l2 device\n");
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to register v4l2 device\n");
+		goto fail_after_video_device_alloc;
+	}
+
 
 	e5010->m2m_dev = v4l2_m2m_init(&e5010_m2m_ops);
 	if (IS_ERR(e5010->m2m_dev)) {
@@ -1118,6 +1121,8 @@ static int e5010_probe(struct platform_device *pdev)
 	v4l2_m2m_release(e5010->m2m_dev);
 fail_after_v4l2_register:
 	v4l2_device_unregister(&e5010->v4l2_dev);
+fail_after_video_device_alloc:
+	video_device_release(e5010->vdev);
 	return ret;
 }
 
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
index aa721cc43647..2725db882e5b 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
@@ -821,7 +821,7 @@ static int vdec_hevc_slice_setup_core_buffer(struct vdec_hevc_slice_inst *inst,
 	inst->vsi_core->fb.y.dma_addr = y_fb_dma;
 	inst->vsi_core->fb.y.size = ctx->picinfo.fb_sz[0];
 	inst->vsi_core->fb.c.dma_addr = c_fb_dma;
-	inst->vsi_core->fb.y.size = ctx->picinfo.fb_sz[1];
+	inst->vsi_core->fb.c.size = ctx->picinfo.fb_sz[1];
 
 	inst->vsi_core->dec.vdec_fb_va = (unsigned long)fb;
 
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index b8c9bb017fb5..73be1013edd0 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -752,6 +752,32 @@ static int mxc_get_free_slot(struct mxc_jpeg_slot_data *slot_data)
 	return -1;
 }
 
+static void mxc_jpeg_free_slot_data(struct mxc_jpeg_dev *jpeg)
+{
+	/* free descriptor for decoding/encoding phase */
+	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
+			  jpeg->slot_data.desc,
+			  jpeg->slot_data.desc_handle);
+	jpeg->slot_data.desc = NULL;
+	jpeg->slot_data.desc_handle = 0;
+
+	/* free descriptor for encoder configuration phase / decoder DHT */
+	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
+			  jpeg->slot_data.cfg_desc,
+			  jpeg->slot_data.cfg_desc_handle);
+	jpeg->slot_data.cfg_desc_handle = 0;
+	jpeg->slot_data.cfg_desc = NULL;
+
+	/* free configuration stream */
+	dma_free_coherent(jpeg->dev, MXC_JPEG_MAX_CFG_STREAM,
+			  jpeg->slot_data.cfg_stream_vaddr,
+			  jpeg->slot_data.cfg_stream_handle);
+	jpeg->slot_data.cfg_stream_vaddr = NULL;
+	jpeg->slot_data.cfg_stream_handle = 0;
+
+	jpeg->slot_data.used = false;
+}
+
 static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg)
 {
 	struct mxc_jpeg_desc *desc;
@@ -794,30 +820,11 @@ static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg)
 	return true;
 err:
 	dev_err(jpeg->dev, "Could not allocate descriptors for slot %d", jpeg->slot_data.slot);
+	mxc_jpeg_free_slot_data(jpeg);
 
 	return false;
 }
 
-static void mxc_jpeg_free_slot_data(struct mxc_jpeg_dev *jpeg)
-{
-	/* free descriptor for decoding/encoding phase */
-	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
-			  jpeg->slot_data.desc,
-			  jpeg->slot_data.desc_handle);
-
-	/* free descriptor for encoder configuration phase / decoder DHT */
-	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
-			  jpeg->slot_data.cfg_desc,
-			  jpeg->slot_data.cfg_desc_handle);
-
-	/* free configuration stream */
-	dma_free_coherent(jpeg->dev, MXC_JPEG_MAX_CFG_STREAM,
-			  jpeg->slot_data.cfg_stream_vaddr,
-			  jpeg->slot_data.cfg_stream_handle);
-
-	jpeg->slot_data.used = false;
-}
-
 static void mxc_jpeg_check_and_set_last_buffer(struct mxc_jpeg_ctx *ctx,
 					       struct vb2_v4l2_buffer *src_buf,
 					       struct vb2_v4l2_buffer *dst_buf)
@@ -1918,9 +1925,19 @@ static void mxc_jpeg_buf_queue(struct vb2_buffer *vb)
 	jpeg_src_buf = vb2_to_mxc_buf(vb);
 	jpeg_src_buf->jpeg_parse_error = false;
 	ret = mxc_jpeg_parse(ctx, vb);
-	if (ret)
+	if (ret) {
 		jpeg_src_buf->jpeg_parse_error = true;
 
+		/*
+		 * if the capture queue is not setup, the device_run() won't be scheduled,
+		 * need to drop the error buffer, so that the decoding can continue
+		 */
+		if (!vb2_is_streaming(v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx))) {
+			v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
+			return;
+		}
+	}
+
 end:
 	v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
 }
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c
index 9745d6219a16..cd6c52e9d158 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c
@@ -43,6 +43,7 @@ struct mxc_isi_m2m_ctx_queue_data {
 	struct v4l2_pix_format_mplane format;
 	const struct mxc_isi_format_info *info;
 	u32 sequence;
+	bool streaming;
 };
 
 struct mxc_isi_m2m_ctx {
@@ -486,15 +487,18 @@ static int mxc_isi_m2m_streamon(struct file *file, void *fh,
 				enum v4l2_buf_type type)
 {
 	struct mxc_isi_m2m_ctx *ctx = to_isi_m2m_ctx(fh);
+	struct mxc_isi_m2m_ctx_queue_data *q = mxc_isi_m2m_ctx_qdata(ctx, type);
 	const struct v4l2_pix_format_mplane *out_pix = &ctx->queues.out.format;
 	const struct v4l2_pix_format_mplane *cap_pix = &ctx->queues.cap.format;
 	const struct mxc_isi_format_info *cap_info = ctx->queues.cap.info;
 	const struct mxc_isi_format_info *out_info = ctx->queues.out.info;
 	struct mxc_isi_m2m *m2m = ctx->m2m;
 	bool bypass;
-
 	int ret;
 
+	if (q->streaming)
+		return 0;
+
 	mutex_lock(&m2m->lock);
 
 	if (m2m->usage_count == INT_MAX) {
@@ -547,6 +551,8 @@ static int mxc_isi_m2m_streamon(struct file *file, void *fh,
 		goto unchain;
 	}
 
+	q->streaming = true;
+
 	return 0;
 
 unchain:
@@ -569,10 +575,14 @@ static int mxc_isi_m2m_streamoff(struct file *file, void *fh,
 				 enum v4l2_buf_type type)
 {
 	struct mxc_isi_m2m_ctx *ctx = to_isi_m2m_ctx(fh);
+	struct mxc_isi_m2m_ctx_queue_data *q = mxc_isi_m2m_ctx_qdata(ctx, type);
 	struct mxc_isi_m2m *m2m = ctx->m2m;
 
 	v4l2_m2m_ioctl_streamoff(file, fh, type);
 
+	if (!q->streaming)
+		return 0;
+
 	mutex_lock(&m2m->lock);
 
 	/*
@@ -598,6 +608,8 @@ static int mxc_isi_m2m_streamoff(struct file *file, void *fh,
 
 	mutex_unlock(&m2m->lock);
 
+	q->streaming = false;
+
 	return 0;
 }
 
diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index cabcf710c046..4d10e94eefe9 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -354,7 +354,7 @@ static int venus_probe(struct platform_device *pdev)
 
 	ret = v4l2_device_register(dev, &core->v4l2_dev);
 	if (ret)
-		goto err_core_deinit;
+		goto err_hfi_destroy;
 
 	platform_set_drvdata(pdev, core);
 
@@ -386,24 +386,24 @@ static int venus_probe(struct platform_device *pdev)
 
 	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_DEC);
 	if (ret)
-		goto err_venus_shutdown;
+		goto err_core_deinit;
 
 	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_ENC);
 	if (ret)
-		goto err_venus_shutdown;
+		goto err_core_deinit;
 
 	ret = pm_runtime_put_sync(dev);
 	if (ret) {
 		pm_runtime_get_noresume(dev);
-		goto err_dev_unregister;
+		goto err_core_deinit;
 	}
 
 	venus_dbgfs_init(core);
 
 	return 0;
 
-err_dev_unregister:
-	v4l2_device_unregister(&core->v4l2_dev);
+err_core_deinit:
+	hfi_core_deinit(core, false);
 err_venus_shutdown:
 	venus_shutdown(core);
 err_firmware_deinit:
@@ -414,9 +414,9 @@ static int venus_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
+	v4l2_device_unregister(&core->v4l2_dev);
+err_hfi_destroy:
 	hfi_destroy(core);
-err_core_deinit:
-	hfi_core_deinit(core, false);
 err_core_put:
 	if (core->pm_ops->core_put)
 		core->pm_ops->core_put(core);
diff --git a/drivers/media/platform/ti/davinci/vpif.c b/drivers/media/platform/ti/davinci/vpif.c
index f4e1fa76bf37..353e8ad15879 100644
--- a/drivers/media/platform/ti/davinci/vpif.c
+++ b/drivers/media/platform/ti/davinci/vpif.c
@@ -504,7 +504,7 @@ static int vpif_probe(struct platform_device *pdev)
 	pdev_display = kzalloc(sizeof(*pdev_display), GFP_KERNEL);
 	if (!pdev_display) {
 		ret = -ENOMEM;
-		goto err_put_pdev_capture;
+		goto err_del_pdev_capture;
 	}
 
 	pdev_display->name = "vpif_display";
@@ -527,6 +527,8 @@ static int vpif_probe(struct platform_device *pdev)
 
 err_put_pdev_display:
 	platform_device_put(pdev_display);
+err_del_pdev_capture:
+	platform_device_del(pdev_capture);
 err_put_pdev_capture:
 	platform_device_put(pdev_capture);
 err_put_rpm:
diff --git a/drivers/media/platform/ti/omap3isp/ispccdc.c b/drivers/media/platform/ti/omap3isp/ispccdc.c
index dd375c4e180d..7d0c723dcd11 100644
--- a/drivers/media/platform/ti/omap3isp/ispccdc.c
+++ b/drivers/media/platform/ti/omap3isp/ispccdc.c
@@ -446,8 +446,8 @@ static int ccdc_lsc_config(struct isp_ccdc_device *ccdc,
 		if (ret < 0)
 			goto done;
 
-		dma_sync_sg_for_cpu(isp->dev, req->table.sgt.sgl,
-				    req->table.sgt.nents, DMA_TO_DEVICE);
+		dma_sync_sgtable_for_cpu(isp->dev, &req->table.sgt,
+					 DMA_TO_DEVICE);
 
 		if (copy_from_user(req->table.addr, config->lsc,
 				   req->config.size)) {
@@ -455,8 +455,8 @@ static int ccdc_lsc_config(struct isp_ccdc_device *ccdc,
 			goto done;
 		}
 
-		dma_sync_sg_for_device(isp->dev, req->table.sgt.sgl,
-				       req->table.sgt.nents, DMA_TO_DEVICE);
+		dma_sync_sgtable_for_device(isp->dev, &req->table.sgt,
+					    DMA_TO_DEVICE);
 	}
 
 	spin_lock_irqsave(&ccdc->lsc.req_lock, flags);
diff --git a/drivers/media/platform/ti/omap3isp/ispstat.c b/drivers/media/platform/ti/omap3isp/ispstat.c
index 359a846205b0..d3da68408ecb 100644
--- a/drivers/media/platform/ti/omap3isp/ispstat.c
+++ b/drivers/media/platform/ti/omap3isp/ispstat.c
@@ -161,8 +161,7 @@ static void isp_stat_buf_sync_for_device(struct ispstat *stat,
 	if (ISP_STAT_USES_DMAENGINE(stat))
 		return;
 
-	dma_sync_sg_for_device(stat->isp->dev, buf->sgt.sgl,
-			       buf->sgt.nents, DMA_FROM_DEVICE);
+	dma_sync_sgtable_for_device(stat->isp->dev, &buf->sgt, DMA_FROM_DEVICE);
 }
 
 static void isp_stat_buf_sync_for_cpu(struct ispstat *stat,
@@ -171,8 +170,7 @@ static void isp_stat_buf_sync_for_cpu(struct ispstat *stat,
 	if (ISP_STAT_USES_DMAENGINE(stat))
 		return;
 
-	dma_sync_sg_for_cpu(stat->isp->dev, buf->sgt.sgl,
-			    buf->sgt.nents, DMA_FROM_DEVICE);
+	dma_sync_sgtable_for_cpu(stat->isp->dev, &buf->sgt, DMA_FROM_DEVICE);
 }
 
 static void isp_stat_buf_clear(struct ispstat *stat)
diff --git a/drivers/media/test-drivers/vidtv/vidtv_channel.c b/drivers/media/test-drivers/vidtv/vidtv_channel.c
index 7838e6272712..f3023e91b3eb 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_channel.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_channel.c
@@ -497,7 +497,7 @@ int vidtv_channel_si_init(struct vidtv_mux *m)
 	vidtv_psi_sdt_table_destroy(m->si.sdt);
 free_pat:
 	vidtv_psi_pat_table_destroy(m->si.pat);
-	return 0;
+	return -EINVAL;
 }
 
 void vidtv_channel_si_destroy(struct vidtv_mux *m)
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index f25e01115364..0d5919e00075 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -947,8 +947,8 @@ int vivid_vid_cap_s_selection(struct file *file, void *fh, struct v4l2_selection
 			if (dev->has_compose_cap) {
 				v4l2_rect_set_min_size(compose, &min_rect);
 				v4l2_rect_set_max_size(compose, &max_rect);
-				v4l2_rect_map_inside(compose, &fmt);
 			}
+			v4l2_rect_map_inside(compose, &fmt);
 			dev->fmt_cap_rect = fmt;
 			tpg_s_buf_height(&dev->tpg, fmt.height);
 		} else if (dev->has_compose_cap) {
diff --git a/drivers/media/usb/dvb-usb/cxusb.c b/drivers/media/usb/dvb-usb/cxusb.c
index 1d98d3465e28..ce52c936cb93 100644
--- a/drivers/media/usb/dvb-usb/cxusb.c
+++ b/drivers/media/usb/dvb-usb/cxusb.c
@@ -119,9 +119,8 @@ static void cxusb_gpio_tuner(struct dvb_usb_device *d, int onoff)
 
 	o[0] = GPIO_TUNER;
 	o[1] = onoff;
-	cxusb_ctrl_msg(d, CMD_GPIO_WRITE, o, 2, &i, 1);
 
-	if (i != 0x01)
+	if (!cxusb_ctrl_msg(d, CMD_GPIO_WRITE, o, 2, &i, 1) && i != 0x01)
 		dev_info(&d->udev->dev, "gpio_write failed.\n");
 
 	st->gpio_write_state[GPIO_TUNER] = onoff;
diff --git a/drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c b/drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c
index 5a47dcbf1c8e..303b055fefea 100644
--- a/drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c
+++ b/drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c
@@ -520,12 +520,13 @@ static int hdcs_init(struct sd *sd)
 static int hdcs_dump(struct sd *sd)
 {
 	u16 reg, val;
+	int err = 0;
 
 	pr_info("Dumping sensor registers:\n");
 
-	for (reg = HDCS_IDENT; reg <= HDCS_ROWEXPH; reg++) {
-		stv06xx_read_sensor(sd, reg, &val);
+	for (reg = HDCS_IDENT; reg <= HDCS_ROWEXPH && !err; reg++) {
+		err = stv06xx_read_sensor(sd, reg, &val);
 		pr_info("reg 0x%02x = 0x%02x\n", reg, val);
 	}
-	return 0;
+	return (err < 0) ? err : 0;
 }
diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 58d1bc80253e..c70d9c24c6fb 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1689,7 +1689,9 @@ static bool uvc_ctrl_xctrls_has_control(const struct v4l2_ext_control *xctrls,
 }
 
 static void uvc_ctrl_send_events(struct uvc_fh *handle,
-	const struct v4l2_ext_control *xctrls, unsigned int xctrls_count)
+				 struct uvc_entity *entity,
+				 const struct v4l2_ext_control *xctrls,
+				 unsigned int xctrls_count)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
@@ -1700,6 +1702,9 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 
 		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		if (ctrl->entity != entity)
+			continue;
+
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;
@@ -1830,12 +1835,17 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
 	return mutex_lock_interruptible(&chain->ctrl_mutex) ? -ERESTARTSYS : 0;
 }
 
+/*
+ * Returns the number of uvc controls that have been correctly set, or a
+ * negative number if there has been an error.
+ */
 static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				  struct uvc_fh *handle,
 				  struct uvc_entity *entity,
 				  int rollback,
 				  struct uvc_control **err_ctrl)
 {
+	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
 	int ret;
@@ -1870,6 +1880,9 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 		else
 			ret = 0;
 
+		if (!ret)
+			processed_ctrls++;
+
 		if (rollback || ret < 0)
 			memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 			       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_BACKUP),
@@ -1888,7 +1901,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
-	return 0;
+	return processed_ctrls;
 }
 
 static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
@@ -1930,11 +1943,13 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 					uvc_ctrl_find_ctrl_idx(entity, ctrls,
 							       err_ctrl);
 			goto done;
+		} else if (ret > 0 && !rollback) {
+			uvc_ctrl_send_events(handle, entity,
+					     ctrls->controls, ctrls->count);
 		}
 	}
 
-	if (!rollback)
-		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
+	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);
 	return ret;
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index a0d683d26647..241b3f95f327 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2217,13 +2217,16 @@ static int uvc_probe(struct usb_interface *intf,
 #endif
 
 	/* Parse the Video Class control descriptor. */
-	if (uvc_parse_control(dev) < 0) {
+	ret = uvc_parse_control(dev);
+	if (ret < 0) {
+		ret = -ENODEV;
 		uvc_dbg(dev, PROBE, "Unable to parse UVC descriptors\n");
 		goto error;
 	}
 
 	/* Parse the associated GPIOs. */
-	if (uvc_gpio_parse(dev) < 0) {
+	ret = uvc_gpio_parse(dev);
+	if (ret < 0) {
 		uvc_dbg(dev, PROBE, "Unable to parse UVC GPIOs\n");
 		goto error;
 	}
@@ -2249,24 +2252,32 @@ static int uvc_probe(struct usb_interface *intf,
 	}
 
 	/* Register the V4L2 device. */
-	if (v4l2_device_register(&intf->dev, &dev->vdev) < 0)
+	ret = v4l2_device_register(&intf->dev, &dev->vdev);
+	if (ret < 0)
 		goto error;
 
 	/* Scan the device for video chains. */
-	if (uvc_scan_device(dev) < 0)
+	if (uvc_scan_device(dev) < 0) {
+		ret = -ENODEV;
 		goto error;
+	}
 
 	/* Initialize controls. */
-	if (uvc_ctrl_init_device(dev) < 0)
+	if (uvc_ctrl_init_device(dev) < 0) {
+		ret = -ENODEV;
 		goto error;
+	}
 
 	/* Register video device nodes. */
-	if (uvc_register_chains(dev) < 0)
+	if (uvc_register_chains(dev) < 0) {
+		ret = -ENODEV;
 		goto error;
+	}
 
 #ifdef CONFIG_MEDIA_CONTROLLER
 	/* Register the media device node */
-	if (media_device_register(&dev->mdev) < 0)
+	ret = media_device_register(&dev->mdev);
+	if (ret < 0)
 		goto error;
 #endif
 	/* Save our data pointer in the interface data. */
@@ -2300,7 +2311,7 @@ static int uvc_probe(struct usb_interface *intf,
 error:
 	uvc_unregister_video(dev);
 	kref_put(&dev->ref, uvc_delete);
-	return -ENODEV;
+	return ret;
 }
 
 static void uvc_disconnect(struct usb_interface *intf)
diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index 3d7711cc42bc..56f3ab966d60 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -1052,25 +1052,25 @@ int __video_register_device(struct video_device *vdev,
 	vdev->dev.class = &video_class;
 	vdev->dev.devt = MKDEV(VIDEO_MAJOR, vdev->minor);
 	vdev->dev.parent = vdev->dev_parent;
+	vdev->dev.release = v4l2_device_release;
 	dev_set_name(&vdev->dev, "%s%d", name_base, vdev->num);
+
+	/* Increase v4l2_device refcount */
+	v4l2_device_get(vdev->v4l2_dev);
+
 	mutex_lock(&videodev_lock);
 	ret = device_register(&vdev->dev);
 	if (ret < 0) {
 		mutex_unlock(&videodev_lock);
 		pr_err("%s: device_register failed\n", __func__);
-		goto cleanup;
+		put_device(&vdev->dev);
+		return ret;
 	}
-	/* Register the release callback that will be called when the last
-	   reference to the device goes away. */
-	vdev->dev.release = v4l2_device_release;
 
 	if (nr != -1 && nr != vdev->num && warn_if_nr_in_use)
 		pr_warn("%s: requested %s%d, got %s\n", __func__,
 			name_base, nr, video_device_node_name(vdev));
 
-	/* Increase v4l2_device refcount */
-	v4l2_device_get(vdev->v4l2_dev);
-
 	/* Part 5: Register the entity. */
 	ret = video_register_media_controller(vdev);
 
diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 3205feb1e8ff..9cbdd240c3a7 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -89,6 +89,7 @@ struct mmc_fixup {
 #define CID_MANFID_MICRON       0x13
 #define CID_MANFID_SAMSUNG      0x15
 #define CID_MANFID_APACER       0x27
+#define CID_MANFID_SWISSBIT     0x5D
 #define CID_MANFID_KINGSTON     0x70
 #define CID_MANFID_HYNIX	0x90
 #define CID_MANFID_KINGSTON_SD	0x9F
@@ -294,4 +295,9 @@ static inline int mmc_card_broken_sd_poweroff_notify(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY;
 }
 
+static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
+}
+
 #endif
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 89b512905be1..7f893bafaa60 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -34,6 +34,16 @@ static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
 		   MMC_QUIRK_BROKEN_SD_CACHE | MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY,
 		   EXT_CSD_REV_ANY),
 
+	/*
+	 * Swissbit series S46-u cards throw I/O errors during tuning requests
+	 * after the initial tuning request expectedly times out. This has
+	 * only been observed on cards manufactured on 01/2019 that are using
+	 * Bay Trail host controllers.
+	 */
+	_FIXUP_EXT("0016G", CID_MANFID_SWISSBIT, 0x5342, 2019, 1,
+		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
+		   MMC_QUIRK_NO_UHS_DDR50_TUNING, EXT_CSD_REV_ANY),
+
 	END_FIXUP
 };
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 63915541c0e4..916ae9996e9d 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -613,6 +613,29 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 	return 0;
 }
 
+/*
+ * Determine if the card should tune or not.
+ */
+static bool mmc_sd_use_tuning(struct mmc_card *card)
+{
+	/*
+	 * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and
+	 * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
+	 */
+	if (mmc_host_is_spi(card->host))
+		return false;
+
+	switch (card->host->ios.timing) {
+	case MMC_TIMING_UHS_SDR50:
+	case MMC_TIMING_UHS_SDR104:
+		return true;
+	case MMC_TIMING_UHS_DDR50:
+		return !mmc_card_no_uhs_ddr50_tuning(card);
+	}
+
+	return false;
+}
+
 /*
  * UHS-I specific initialization procedure
  */
@@ -656,14 +679,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 	if (err)
 		goto out;
 
-	/*
-	 * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and
-	 * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
-	 */
-	if (!mmc_host_is_spi(card->host) &&
-		(card->host->ios.timing == MMC_TIMING_UHS_SDR50 ||
-		 card->host->ios.timing == MMC_TIMING_UHS_DDR50 ||
-		 card->host->ios.timing == MMC_TIMING_UHS_SDR104)) {
+	if (mmc_sd_use_tuning(card)) {
 		err = mmc_execute_tuning(card);
 
 		/*
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index b8cff9240b28..beafca6ba0df 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2917,7 +2917,7 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 		write_reg_dma(nandc, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
 	}
 
-	nandc->buf_count = len;
+	nandc->buf_count = 512;
 	memset(nandc->data_buffer, 0xff, nandc->buf_count);
 
 	config_nand_single_cw_page_read(chip, false, 0);
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index c28634e20abf..ac887754b98e 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -817,6 +817,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	if (ret)
 		return ret;
 
+	sunxi_nfc_randomizer_config(nand, page, false);
 	sunxi_nfc_randomizer_enable(nand);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
 	       nfc->regs + NFC_REG_CMD);
@@ -1049,6 +1050,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
 	if (ret)
 		return ret;
 
+	sunxi_nfc_randomizer_config(nand, page, false);
 	sunxi_nfc_randomizer_enable(nand);
 	sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, 0, bbm, page);
 
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 3cf100780599..3fa83f05bfcc 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -966,7 +966,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		u32 status, tx_nr_packets_max;
 
 		netdev = alloc_candev(sizeof(struct kvaser_pciefd_can),
-				      KVASER_PCIEFD_CAN_TX_MAX_COUNT);
+				      roundup_pow_of_two(KVASER_PCIEFD_CAN_TX_MAX_COUNT));
 		if (!netdev)
 			return -ENOMEM;
 
@@ -995,7 +995,6 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->tx_max_count = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
 
 		can->can.clock.freq = pcie->freq;
-		can->can.echo_skb_max = roundup_pow_of_two(can->tx_max_count);
 		spin_lock_init(&can->lock);
 
 		can->can.bittiming_const = &kvaser_pciefd_bittiming_const;
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 2f73bf3abad8..b6c5c8bab739 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -385,10 +385,11 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	priv = cdev_to_priv(mcan_class);
 
 	priv->power = devm_regulator_get_optional(&spi->dev, "vsup");
-	if (PTR_ERR(priv->power) == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
-		goto out_m_can_class_free_dev;
-	} else {
+	if (IS_ERR(priv->power)) {
+		if (PTR_ERR(priv->power) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto out_m_can_class_free_dev;
+		}
 		priv->power = NULL;
 	}
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
index c1d1673c5749..b565189e5913 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
@@ -123,7 +123,6 @@ static netdev_tx_t aq_ndev_start_xmit(struct sk_buff *skb, struct net_device *nd
 	}
 #endif
 
-	skb_tx_timestamp(skb);
 	return aq_nic_xmit(aq_nic, skb);
 }
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 71e50fc65c14..b0994bd05874 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -898,6 +898,8 @@ int aq_nic_xmit(struct aq_nic_s *self, struct sk_buff *skb)
 
 	frags = aq_nic_map_skb(self, skb, ring);
 
+	skb_tx_timestamp(skb);
+
 	if (likely(frags)) {
 		err = self->aq_hw_ops->hw_ring_tx_xmit(self->aq_hw,
 						       ring, frags);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2bb1fce350db..154f73f121ec 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10390,6 +10390,72 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 	bp->num_rss_ctx--;
 }
 
+static bool bnxt_vnic_has_rx_ring(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+				  int rxr_id)
+{
+	u16 tbl_size = bnxt_get_rxfh_indir_size(bp->dev);
+	int i, vnic_rx;
+
+	/* Ntuple VNIC always has all the rx rings. Any change of ring id
+	 * must be updated because a future filter may use it.
+	 */
+	if (vnic->flags & BNXT_VNIC_NTUPLE_FLAG)
+		return true;
+
+	for (i = 0; i < tbl_size; i++) {
+		if (vnic->flags & BNXT_VNIC_RSSCTX_FLAG)
+			vnic_rx = ethtool_rxfh_context_indir(vnic->rss_ctx)[i];
+		else
+			vnic_rx = bp->rss_indir_tbl[i];
+
+		if (rxr_id == vnic_rx)
+			return true;
+	}
+
+	return false;
+}
+
+static int bnxt_set_vnic_mru_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+				u16 mru, int rxr_id)
+{
+	int rc;
+
+	if (!bnxt_vnic_has_rx_ring(bp, vnic, rxr_id))
+		return 0;
+
+	if (mru) {
+		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
+		if (rc) {
+			netdev_err(bp->dev, "hwrm vnic %d set rss failure rc: %d\n",
+				   vnic->vnic_id, rc);
+			return rc;
+		}
+	}
+	vnic->mru = mru;
+	bnxt_hwrm_vnic_update(bp, vnic,
+			      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
+
+	return 0;
+}
+
+static int bnxt_set_rss_ctx_vnic_mru(struct bnxt *bp, u16 mru, int rxr_id)
+{
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+	int rc;
+
+	xa_for_each(&bp->dev->ethtool->rss_ctx, context, ctx) {
+		struct bnxt_rss_ctx *rss_ctx = ethtool_rxfh_context_priv(ctx);
+		struct bnxt_vnic_info *vnic = &rss_ctx->vnic;
+
+		rc = bnxt_set_vnic_mru_p5(bp, vnic, mru, rxr_id);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
 static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
 {
 	bool set_tpa = !!(bp->flags & BNXT_FLAG_TPA);
@@ -15326,6 +15392,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	struct bnxt_cp_ring_info *cpr;
 	struct bnxt_vnic_info *vnic;
 	int i, rc;
+	u16 mru;
 
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
@@ -15356,21 +15423,15 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	cpr = &rxr->bnapi->cp_ring;
 	cpr->sw_stats->rx.rx_resets++;
 
-	for (i = 0; i <= bp->nr_vnics; i++) {
+	mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
+	for (i = 0; i < bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
 
-		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
-		if (rc) {
-			netdev_err(bp->dev, "hwrm vnic %d set rss failure rc: %d\n",
-				   vnic->vnic_id, rc);
+		rc = bnxt_set_vnic_mru_p5(bp, vnic, mru, idx);
+		if (rc)
 			return rc;
-		}
-		vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
-		bnxt_hwrm_vnic_update(bp, vnic,
-				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
 	}
-
-	return 0;
+	return bnxt_set_rss_ctx_vnic_mru(bp, mru, idx);
 
 err_free_hwrm_rx_ring:
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
@@ -15384,12 +15445,12 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	struct bnxt_vnic_info *vnic;
 	int i;
 
-	for (i = 0; i <= bp->nr_vnics; i++) {
+	for (i = 0; i < bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
-		vnic->mru = 0;
-		bnxt_hwrm_vnic_update(bp, vnic,
-				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
+
+		bnxt_set_vnic_mru_p5(bp, vnic, 0, idx);
 	}
+	bnxt_set_rss_ctx_vnic_mru(bp, 0, idx);
 	/* Make sure NAPI sees that the VNIC is disabled */
 	synchronize_net();
 	rxr = &bp->rx_ring[idx];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 546d9a3d7efe..1867552a8bdb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -148,7 +148,6 @@ void bnxt_unregister_dev(struct bnxt_en_dev *edev)
 	struct net_device *dev = edev->net;
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_ulp *ulp;
-	int i = 0;
 
 	ulp = edev->ulp_tbl;
 	rtnl_lock();
@@ -164,10 +163,6 @@ void bnxt_unregister_dev(struct bnxt_en_dev *edev)
 	synchronize_rcu();
 	ulp->max_async_event_id = 0;
 	ulp->async_events_bmap = NULL;
-	while (atomic_read(&ulp->ref_count) != 0 && i < 10) {
-		msleep(100);
-		i++;
-	}
 	mutex_unlock(&edev->en_dev_lock);
 	rtnl_unlock();
 	return;
@@ -235,10 +230,9 @@ void bnxt_ulp_stop(struct bnxt *bp)
 		return;
 
 	mutex_lock(&edev->en_dev_lock);
-	if (!bnxt_ulp_registered(edev)) {
-		mutex_unlock(&edev->en_dev_lock);
-		return;
-	}
+	if (!bnxt_ulp_registered(edev) ||
+	    (edev->flags & BNXT_EN_FLAG_ULP_STOPPED))
+		goto ulp_stop_exit;
 
 	edev->flags |= BNXT_EN_FLAG_ULP_STOPPED;
 	if (aux_priv) {
@@ -254,6 +248,7 @@ void bnxt_ulp_stop(struct bnxt *bp)
 			adrv->suspend(adev, pm);
 		}
 	}
+ulp_stop_exit:
 	mutex_unlock(&edev->en_dev_lock);
 }
 
@@ -262,19 +257,13 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
 	struct bnxt_aux_priv *aux_priv = bp->aux_priv;
 	struct bnxt_en_dev *edev = bp->edev;
 
-	if (!edev)
-		return;
-
-	edev->flags &= ~BNXT_EN_FLAG_ULP_STOPPED;
-
-	if (err)
+	if (!edev || err)
 		return;
 
 	mutex_lock(&edev->en_dev_lock);
-	if (!bnxt_ulp_registered(edev)) {
-		mutex_unlock(&edev->en_dev_lock);
-		return;
-	}
+	if (!bnxt_ulp_registered(edev) ||
+	    !(edev->flags & BNXT_EN_FLAG_ULP_STOPPED))
+		goto ulp_start_exit;
 
 	if (edev->ulp_tbl->msix_requested)
 		bnxt_fill_msix_vecs(bp, edev->msix_entries);
@@ -291,6 +280,8 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
 			adrv->resume(adev);
 		}
 	}
+ulp_start_exit:
+	edev->flags &= ~BNXT_EN_FLAG_ULP_STOPPED;
 	mutex_unlock(&edev->en_dev_lock);
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index 4f4914f5c84c..b76a231ca7da 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -48,7 +48,6 @@ struct bnxt_ulp {
 	unsigned long	*async_events_bmap;
 	u16		max_async_event_id;
 	u16		msix_requested;
-	atomic_t	ref_count;
 };
 
 struct bnxt_en_dev {
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ae100ed8ed6b..3c2a7919b128 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5117,7 +5117,11 @@ static int macb_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	if (GEM_BFEXT(DAW64, gem_readl(bp, DCFG6))) {
-		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+		if (err) {
+			dev_err(&pdev->dev, "failed to set DMA mask\n");
+			goto err_out_free_netdev;
+		}
 		bp->hw_dma_cap |= HW_DMA_CAP_64B;
 	}
 #endif
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 73e1c71c5092..92833eefc04b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1143,6 +1143,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	struct gmac_txdesc *txd;
 	skb_frag_t *skb_frag;
 	dma_addr_t mapping;
+	bool tcp = false;
 	void *buffer;
 	u16 mss;
 	int ret;
@@ -1150,6 +1151,13 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	word1 = skb->len;
 	word3 = SOF_BIT;
 
+	/* Determine if we are doing TCP */
+	if (skb->protocol == htons(ETH_P_IP))
+		tcp = (ip_hdr(skb)->protocol == IPPROTO_TCP);
+	else
+		/* IPv6 */
+		tcp = (ipv6_hdr(skb)->nexthdr == IPPROTO_TCP);
+
 	mss = skb_shinfo(skb)->gso_size;
 	if (mss) {
 		/* This means we are dealing with TCP and skb->len is the
@@ -1162,8 +1170,26 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 			   mss, skb->len);
 		word1 |= TSS_MTU_ENABLE_BIT;
 		word3 |= mss;
+	} else if (tcp) {
+		/* Even if we are not using TSO, use the hardware offloader
+		 * for transferring the TCP frame: this hardware has partial
+		 * TCP awareness (called TOE - TCP Offload Engine) and will
+		 * according to the datasheet put packets belonging to the
+		 * same TCP connection in the same queue for the TOE/TSO
+		 * engine to process. The engine will deal with chopping
+		 * up frames that exceed ETH_DATA_LEN which the
+		 * checksumming engine cannot handle (see below) into
+		 * manageable chunks. It flawlessly deals with quite big
+		 * frames and frames containing custom DSA EtherTypes.
+		 */
+		mss = netdev->mtu + skb_tcp_all_headers(skb);
+		mss = min(mss, skb->len);
+		netdev_dbg(netdev, "TOE/TSO len %04x mtu %04x mss %04x\n",
+			   skb->len, netdev->mtu, mss);
+		word1 |= TSS_MTU_ENABLE_BIT;
+		word3 |= mss;
 	} else if (skb->len >= ETH_FRAME_LEN) {
-		/* Hardware offloaded checksumming isn't working on frames
+		/* Hardware offloaded checksumming isn't working on non-TCP frames
 		 * bigger than 1514 bytes. A hypothesis about this is that the
 		 * checksum buffer is only 1518 bytes, so when the frames get
 		 * bigger they get truncated, or the last few bytes get
@@ -1180,21 +1206,16 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	}
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		int tcp = 0;
-
 		/* We do not switch off the checksumming on non TCP/UDP
 		 * frames: as is shown from tests, the checksumming engine
 		 * is smart enough to see that a frame is not actually TCP
 		 * or UDP and then just pass it through without any changes
 		 * to the frame.
 		 */
-		if (skb->protocol == htons(ETH_P_IP)) {
+		if (skb->protocol == htons(ETH_P_IP))
 			word1 |= TSS_IP_CHKSUM_BIT;
-			tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
-		} else { /* IPv6 */
+		else
 			word1 |= TSS_IPV6_ENABLE_BIT;
-			tcp = ipv6_hdr(skb)->nexthdr == IPPROTO_TCP;
-		}
 
 		word1 |= tcp ? TSS_TCP_CHKSUM_BIT : TSS_UDP_CHKSUM_BIT;
 	}
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 6bf8a7aeef90..787218d60c6b 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -146,6 +146,8 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 	np->ioaddr = ioaddr;
 	np->chip_id = chip_idx;
 	np->pdev = pdev;
+
+	spin_lock_init(&np->stats_lock);
 	spin_lock_init (&np->tx_lock);
 	spin_lock_init (&np->rx_lock);
 
@@ -865,7 +867,6 @@ tx_error (struct net_device *dev, int tx_status)
 	frame_id = (tx_status & 0xffff0000);
 	printk (KERN_ERR "%s: Transmit error, TxStatus %4.4x, FrameId %d.\n",
 		dev->name, tx_status, frame_id);
-	dev->stats.tx_errors++;
 	/* Ttransmit Underrun */
 	if (tx_status & 0x10) {
 		dev->stats.tx_fifo_errors++;
@@ -902,9 +903,15 @@ tx_error (struct net_device *dev, int tx_status)
 		rio_set_led_mode(dev);
 		/* Let TxStartThresh stay default value */
 	}
+
+	spin_lock(&np->stats_lock);
 	/* Maximum Collisions */
 	if (tx_status & 0x08)
 		dev->stats.collisions++;
+
+	dev->stats.tx_errors++;
+	spin_unlock(&np->stats_lock);
+
 	/* Restart the Tx */
 	dw32(MACCtrl, dr16(MACCtrl) | TxEnable);
 }
@@ -1073,7 +1080,9 @@ get_stats (struct net_device *dev)
 	int i;
 #endif
 	unsigned int stat_reg;
+	unsigned long flags;
 
+	spin_lock_irqsave(&np->stats_lock, flags);
 	/* All statistics registers need to be acknowledged,
 	   else statistic overflow could cause problems */
 
@@ -1123,6 +1132,9 @@ get_stats (struct net_device *dev)
 	dr16(TCPCheckSumErrors);
 	dr16(UDPCheckSumErrors);
 	dr16(IPCheckSumErrors);
+
+	spin_unlock_irqrestore(&np->stats_lock, flags);
+
 	return &dev->stats;
 }
 
diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 0e33e2eaae96..56aff2f0bdbf 100644
--- a/drivers/net/ethernet/dlink/dl2k.h
+++ b/drivers/net/ethernet/dlink/dl2k.h
@@ -372,6 +372,8 @@ struct netdev_private {
 	struct pci_dev *pdev;
 	void __iomem *ioaddr;
 	void __iomem *eeprom_addr;
+	// To ensure synchronization when stats are updated.
+	spinlock_t stats_lock;
 	spinlock_t tx_lock;
 	spinlock_t rx_lock;
 	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 51b8377edd1d..a89aa4ac0a06 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -1609,7 +1609,7 @@ int be_cmd_get_stats(struct be_adapter *adapter, struct be_dma_mem *nonemb_cmd)
 	/* version 1 of the cmd is not supported only by BE2 */
 	if (BE2_chip(adapter))
 		hdr->version = 0;
-	if (BE3_chip(adapter) || lancer_chip(adapter))
+	else if (BE3_chip(adapter) || lancer_chip(adapter))
 		hdr->version = 1;
 	else
 		hdr->version = 2;
diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
index c699bd6bcbb9..474073c7f94d 100644
--- a/drivers/net/ethernet/faraday/Kconfig
+++ b/drivers/net/ethernet/faraday/Kconfig
@@ -31,6 +31,7 @@ config FTGMAC100
 	depends on ARM || COMPILE_TEST
 	depends on !64BIT || BROKEN
 	select PHYLIB
+	select FIXED_PHY
 	select MDIO_ASPEED if MACH_ASPEED_G6
 	select CRC32
 	help
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 07e903346358..5fe54e9b71e2 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3540,9 +3540,6 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
 	case e1000_pch_cnp:
 	case e1000_pch_tgp:
 	case e1000_pch_adp:
-	case e1000_pch_mtp:
-	case e1000_pch_lnp:
-	case e1000_pch_ptp:
 	case e1000_pch_nvp:
 		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
 			/* Stable 24MHz frequency */
@@ -3558,6 +3555,17 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
 			adapter->cc.shift = shift;
 		}
 		break;
+	case e1000_pch_mtp:
+	case e1000_pch_lnp:
+	case e1000_pch_ptp:
+		/* System firmware can misreport this value, so set it to a
+		 * stable 38400KHz frequency.
+		 */
+		incperiod = INCPERIOD_38400KHZ;
+		incvalue = INCVALUE_38400KHZ;
+		shift = INCVALUE_SHIFT_38400KHZ;
+		adapter->cc.shift = shift;
+		break;
 	case e1000_82574:
 	case e1000_82583:
 		/* Stable 25MHz frequency */
diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index 89d57dd911dc..ea3c3eb2ef20 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -295,15 +295,17 @@ void e1000e_ptp_init(struct e1000_adapter *adapter)
 	case e1000_pch_cnp:
 	case e1000_pch_tgp:
 	case e1000_pch_adp:
-	case e1000_pch_mtp:
-	case e1000_pch_lnp:
-	case e1000_pch_ptp:
 	case e1000_pch_nvp:
 		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI)
 			adapter->ptp_clock_info.max_adj = MAX_PPB_24MHZ;
 		else
 			adapter->ptp_clock_info.max_adj = MAX_PPB_38400KHZ;
 		break;
+	case e1000_pch_mtp:
+	case e1000_pch_lnp:
+	case e1000_pch_ptp:
+		adapter->ptp_clock_info.max_adj = MAX_PPB_38400KHZ;
+		break;
 	case e1000_82574:
 	case e1000_82583:
 		adapter->ptp_clock_info.max_adj = MAX_PPB_25MHZ;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index e8031f1a9b4f..2f5a85014867 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -817,10 +817,11 @@ int i40e_pf_reset(struct i40e_hw *hw)
 void i40e_clear_hw(struct i40e_hw *hw)
 {
 	u32 num_queues, base_queue;
-	u32 num_pf_int;
-	u32 num_vf_int;
+	s32 num_pf_int;
+	s32 num_vf_int;
 	u32 num_vfs;
-	u32 i, j;
+	s32 i;
+	u32 j;
 	u32 val;
 	u32 eol = 0x7ff;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index 405ddd17de1b..0bb4fb56fbe6 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -377,6 +377,50 @@ ice_arfs_is_perfect_flow_set(struct ice_hw *hw, __be16 l3_proto, u8 l4_proto)
 	return false;
 }
 
+/**
+ * ice_arfs_cmp - Check if aRFS filter matches this flow.
+ * @fltr_info: filter info of the saved ARFS entry.
+ * @fk: flow dissector keys.
+ * @n_proto:  One of htons(ETH_P_IP) or htons(ETH_P_IPV6).
+ * @ip_proto: One of IPPROTO_TCP or IPPROTO_UDP.
+ *
+ * Since this function assumes limited values for n_proto and ip_proto, it
+ * is meant to be called only from ice_rx_flow_steer().
+ *
+ * Return:
+ * * true	- fltr_info refers to the same flow as fk.
+ * * false	- fltr_info and fk refer to different flows.
+ */
+static bool
+ice_arfs_cmp(const struct ice_fdir_fltr *fltr_info, const struct flow_keys *fk,
+	     __be16 n_proto, u8 ip_proto)
+{
+	/* Determine if the filter is for IPv4 or IPv6 based on flow_type,
+	 * which is one of ICE_FLTR_PTYPE_NONF_IPV{4,6}_{TCP,UDP}.
+	 */
+	bool is_v4 = fltr_info->flow_type == ICE_FLTR_PTYPE_NONF_IPV4_TCP ||
+		     fltr_info->flow_type == ICE_FLTR_PTYPE_NONF_IPV4_UDP;
+
+	/* Following checks are arranged in the quickest and most discriminative
+	 * fields first for early failure.
+	 */
+	if (is_v4)
+		return n_proto == htons(ETH_P_IP) &&
+			fltr_info->ip.v4.src_port == fk->ports.src &&
+			fltr_info->ip.v4.dst_port == fk->ports.dst &&
+			fltr_info->ip.v4.src_ip == fk->addrs.v4addrs.src &&
+			fltr_info->ip.v4.dst_ip == fk->addrs.v4addrs.dst &&
+			fltr_info->ip.v4.proto == ip_proto;
+
+	return fltr_info->ip.v6.src_port == fk->ports.src &&
+		fltr_info->ip.v6.dst_port == fk->ports.dst &&
+		fltr_info->ip.v6.proto == ip_proto &&
+		!memcmp(&fltr_info->ip.v6.src_ip, &fk->addrs.v6addrs.src,
+			sizeof(struct in6_addr)) &&
+		!memcmp(&fltr_info->ip.v6.dst_ip, &fk->addrs.v6addrs.dst,
+			sizeof(struct in6_addr));
+}
+
 /**
  * ice_rx_flow_steer - steer the Rx flow to where application is being run
  * @netdev: ptr to the netdev being adjusted
@@ -448,6 +492,10 @@ ice_rx_flow_steer(struct net_device *netdev, const struct sk_buff *skb,
 			continue;
 
 		fltr_info = &arfs_entry->fltr_info;
+
+		if (!ice_arfs_cmp(fltr_info, &fk, n_proto, ip_proto))
+			continue;
+
 		ret = fltr_info->fltr_id;
 
 		if (fltr_info->q_index == rxq_idx ||
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index ed21d7f55ac1..5b9a7ee278f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -502,10 +502,14 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_repr *repr, unsigned long *id)
  */
 int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf)
 {
-	struct ice_repr *repr = ice_repr_create_vf(vf);
 	struct devlink *devlink = priv_to_devlink(pf);
+	struct ice_repr *repr;
 	int err;
 
+	if (!ice_is_eswitch_mode_switchdev(pf))
+		return 0;
+
+	repr = ice_repr_create_vf(vf);
 	if (IS_ERR(repr))
 		return PTR_ERR(repr);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 0e740342e294..c5430363e708 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3146,7 +3146,7 @@ ice_add_update_vsi_list(struct ice_hw *hw,
 		u16 vsi_handle_arr[2];
 
 		/* A rule already exists with the new VSI being added */
-		if (cur_fltr->fwd_id.hw_vsi_id == new_fltr->fwd_id.hw_vsi_id)
+		if (cur_fltr->vsi_handle == new_fltr->vsi_handle)
 			return -EEXIST;
 
 		vsi_handle_arr[0] = cur_fltr->vsi_handle;
@@ -5977,7 +5977,7 @@ ice_adv_add_update_vsi_list(struct ice_hw *hw,
 
 		/* A rule already exists with the new VSI being added */
 		if (test_bit(vsi_handle, m_entry->vsi_list_info->vsi_map))
-			return 0;
+			return -EEXIST;
 
 		/* Update the previously created VSI list set with
 		 * the new VSI ID passed in
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 07eaa3c3f4d3..530e4319a2e8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -167,7 +167,7 @@ int ixgbe_write_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 					 u16 reg, u16 val, bool lock)
 {
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
-	int max_retry = 1;
+	int max_retry = 3;
 	int retry = 0;
 	u8 reg_high;
 	u8 csum;
@@ -2284,7 +2284,7 @@ static int ixgbe_write_i2c_byte_generic_int(struct ixgbe_hw *hw, u8 byte_offset,
 					    u8 dev_addr, u8 data, bool lock)
 {
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
-	u32 max_retry = 1;
+	u32 max_retry = 3;
 	u32 retry = 0;
 	int status;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index 7417087b6db5..a2807a1e4f4a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -352,9 +352,12 @@ int cn10k_free_matchall_ipolicer(struct otx2_nic *pfvf)
 	mutex_lock(&pfvf->mbox.lock);
 
 	/* Remove RQ's policer mapping */
-	for (qidx = 0; qidx < hw->rx_queues; qidx++)
-		cn10k_map_unmap_rq_policer(pfvf, qidx,
-					   hw->matchall_ipolicer, false);
+	for (qidx = 0; qidx < hw->rx_queues; qidx++) {
+		rc = cn10k_map_unmap_rq_policer(pfvf, qidx, hw->matchall_ipolicer, false);
+		if (rc)
+			dev_warn(pfvf->dev, "Failed to unmap RQ %d's policer (error %d).",
+				 qidx, rc);
+	}
 
 	rc = cn10k_free_leaf_profile(pfvf, hw->matchall_ipolicer);
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index cd17a3f4faf8..a68cd3f0304c 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1897,6 +1897,7 @@ static int mlx4_en_get_ts_info(struct net_device *dev,
 	if (mdev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_TS) {
 		info->so_timestamping |=
 			SOF_TIMESTAMPING_TX_HARDWARE |
+			SOF_TIMESTAMPING_TX_SOFTWARE |
 			SOF_TIMESTAMPING_RX_HARDWARE |
 			SOF_TIMESTAMPING_RAW_HARDWARE;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
index 72b19b05c0cf..fc9ba534d5d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
@@ -508,7 +508,7 @@ static int
 hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 		       u32 *match_param)
 {
-	bool is_s_ipv6, is_d_ipv6, smac_set, dmac_set;
+	bool is_ipv6, smac_set, dmac_set, ip_addr_set, ip_ver_set;
 	struct mlx5hws_definer_fc *fc = cd->fc;
 	struct mlx5hws_definer_fc *curr_fc;
 	u32 *s_ipv6, *d_ipv6;
@@ -520,6 +520,20 @@ hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 		return -EINVAL;
 	}
 
+	ip_addr_set = HWS_IS_FLD_SET_SZ(match_param,
+					outer_headers.src_ipv4_src_ipv6,
+					0x80) ||
+		      HWS_IS_FLD_SET_SZ(match_param,
+					outer_headers.dst_ipv4_dst_ipv6, 0x80);
+	ip_ver_set = HWS_IS_FLD_SET(match_param, outer_headers.ip_version) ||
+		     HWS_IS_FLD_SET(match_param, outer_headers.ethertype);
+
+	if (ip_addr_set && !ip_ver_set) {
+		mlx5hws_err(cd->ctx,
+			    "Unsupported match on IP address without version or ethertype\n");
+		return -EINVAL;
+	}
+
 	/* L2 Check ethertype */
 	HWS_SET_HDR(fc, match_param, ETH_TYPE_O,
 		    outer_headers.ethertype,
@@ -572,10 +586,16 @@ hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 			      outer_headers.dst_ipv4_dst_ipv6.ipv6_layout);
 
 	/* Assume IPv6 is used if ipv6 bits are set */
-	is_s_ipv6 = s_ipv6[0] || s_ipv6[1] || s_ipv6[2];
-	is_d_ipv6 = d_ipv6[0] || d_ipv6[1] || d_ipv6[2];
+	is_ipv6 = s_ipv6[0] || s_ipv6[1] || s_ipv6[2] ||
+		  d_ipv6[0] || d_ipv6[1] || d_ipv6[2];
 
-	if (is_s_ipv6) {
+	/* IHL is an IPv4-specific field. */
+	if (is_ipv6 && HWS_IS_FLD_SET(match_param, outer_headers.ipv4_ihl)) {
+		mlx5hws_err(cd->ctx, "Unsupported match on IPv6 address and IPv4 IHL\n");
+		return -EINVAL;
+	}
+
+	if (is_ipv6) {
 		/* Handle IPv6 source address */
 		HWS_SET_HDR(fc, match_param, IPV6_SRC_127_96_O,
 			    outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_127_96,
@@ -589,13 +609,6 @@ hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 		HWS_SET_HDR(fc, match_param, IPV6_SRC_31_0_O,
 			    outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0,
 			    ipv6_src_outer.ipv6_address_31_0);
-	} else {
-		/* Handle IPv4 source address */
-		HWS_SET_HDR(fc, match_param, IPV4_SRC_O,
-			    outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0,
-			    ipv4_src_dest_outer.source_address);
-	}
-	if (is_d_ipv6) {
 		/* Handle IPv6 destination address */
 		HWS_SET_HDR(fc, match_param, IPV6_DST_127_96_O,
 			    outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_127_96,
@@ -610,6 +623,10 @@ hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 			    outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0,
 			    ipv6_dst_outer.ipv6_address_31_0);
 	} else {
+		/* Handle IPv4 source address */
+		HWS_SET_HDR(fc, match_param, IPV4_SRC_O,
+			    outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0,
+			    ipv4_src_dest_outer.source_address);
 		/* Handle IPv4 destination address */
 		HWS_SET_HDR(fc, match_param, IPV4_DST_O,
 			    outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0,
@@ -667,7 +684,7 @@ static int
 hws_definer_conv_inner(struct mlx5hws_definer_conv_data *cd,
 		       u32 *match_param)
 {
-	bool is_s_ipv6, is_d_ipv6, smac_set, dmac_set;
+	bool is_ipv6, smac_set, dmac_set, ip_addr_set, ip_ver_set;
 	struct mlx5hws_definer_fc *fc = cd->fc;
 	struct mlx5hws_definer_fc *curr_fc;
 	u32 *s_ipv6, *d_ipv6;
@@ -679,6 +696,20 @@ hws_definer_conv_inner(struct mlx5hws_definer_conv_data *cd,
 		return -EINVAL;
 	}
 
+	ip_addr_set = HWS_IS_FLD_SET_SZ(match_param,
+					inner_headers.src_ipv4_src_ipv6,
+					0x80) ||
+		      HWS_IS_FLD_SET_SZ(match_param,
+					inner_headers.dst_ipv4_dst_ipv6, 0x80);
+	ip_ver_set = HWS_IS_FLD_SET(match_param, inner_headers.ip_version) ||
+		     HWS_IS_FLD_SET(match_param, inner_headers.ethertype);
+
+	if (ip_addr_set && !ip_ver_set) {
+		mlx5hws_err(cd->ctx,
+			    "Unsupported match on IP address without version or ethertype\n");
+		return -EINVAL;
+	}
+
 	/* L2 Check ethertype */
 	HWS_SET_HDR(fc, match_param, ETH_TYPE_I,
 		    inner_headers.ethertype,
@@ -730,10 +761,16 @@ hws_definer_conv_inner(struct mlx5hws_definer_conv_data *cd,
 			      inner_headers.dst_ipv4_dst_ipv6.ipv6_layout);
 
 	/* Assume IPv6 is used if ipv6 bits are set */
-	is_s_ipv6 = s_ipv6[0] || s_ipv6[1] || s_ipv6[2];
-	is_d_ipv6 = d_ipv6[0] || d_ipv6[1] || d_ipv6[2];
+	is_ipv6 = s_ipv6[0] || s_ipv6[1] || s_ipv6[2] ||
+		  d_ipv6[0] || d_ipv6[1] || d_ipv6[2];
 
-	if (is_s_ipv6) {
+	/* IHL is an IPv4-specific field. */
+	if (is_ipv6 && HWS_IS_FLD_SET(match_param, inner_headers.ipv4_ihl)) {
+		mlx5hws_err(cd->ctx, "Unsupported match on IPv6 address and IPv4 IHL\n");
+		return -EINVAL;
+	}
+
+	if (is_ipv6) {
 		/* Handle IPv6 source address */
 		HWS_SET_HDR(fc, match_param, IPV6_SRC_127_96_I,
 			    inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_127_96,
@@ -747,13 +784,6 @@ hws_definer_conv_inner(struct mlx5hws_definer_conv_data *cd,
 		HWS_SET_HDR(fc, match_param, IPV6_SRC_31_0_I,
 			    inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0,
 			    ipv6_src_inner.ipv6_address_31_0);
-	} else {
-		/* Handle IPv4 source address */
-		HWS_SET_HDR(fc, match_param, IPV4_SRC_I,
-			    inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0,
-			    ipv4_src_dest_inner.source_address);
-	}
-	if (is_d_ipv6) {
 		/* Handle IPv6 destination address */
 		HWS_SET_HDR(fc, match_param, IPV6_DST_127_96_I,
 			    inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_127_96,
@@ -768,6 +798,10 @@ hws_definer_conv_inner(struct mlx5hws_definer_conv_data *cd,
 			    inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0,
 			    ipv6_dst_inner.ipv6_address_31_0);
 	} else {
+		/* Handle IPv4 source address */
+		HWS_SET_HDR(fc, match_param, IPV4_SRC_I,
+			    inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0,
+			    ipv4_src_dest_inner.source_address);
 		/* Handle IPv4 destination address */
 		HWS_SET_HDR(fc, match_param, IPV4_DST_I,
 			    inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 0d5f750faa45..b04024d0ae67 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -465,19 +465,22 @@ int mlx5_query_nic_vport_node_guid(struct mlx5_core_dev *mdev, u64 *node_guid)
 {
 	u32 *out;
 	int outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
+	int err;
 
 	out = kvzalloc(outlen, GFP_KERNEL);
 	if (!out)
 		return -ENOMEM;
 
-	mlx5_query_nic_vport_context(mdev, 0, out);
+	err = mlx5_query_nic_vport_context(mdev, 0, out);
+	if (err)
+		goto out;
 
 	*node_guid = MLX5_GET64(query_nic_vport_context_out, out,
 				nic_vport_context.node_guid);
-
+out:
 	kvfree(out);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(mlx5_query_nic_vport_node_guid);
 
@@ -519,19 +522,22 @@ int mlx5_query_nic_vport_qkey_viol_cntr(struct mlx5_core_dev *mdev,
 {
 	u32 *out;
 	int outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
+	int err;
 
 	out = kvzalloc(outlen, GFP_KERNEL);
 	if (!out)
 		return -ENOMEM;
 
-	mlx5_query_nic_vport_context(mdev, 0, out);
+	err = mlx5_query_nic_vport_context(mdev, 0, out);
+	if (err)
+		goto out;
 
 	*qkey_viol_cntr = MLX5_GET(query_nic_vport_context_out, out,
 				   nic_vport_context.qkey_violation_counter);
-
+out:
 	kvfree(out);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(mlx5_query_nic_vport_qkey_viol_cntr);
 
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 385a56ac7348..c82254a8ae66 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -447,8 +447,10 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	priv->llu_plu_irq = platform_get_irq(pdev, MLXBF_GIGE_LLU_PLU_INTR_IDX);
 
 	phy_irq = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(&pdev->dev), "phy", 0);
-	if (phy_irq < 0) {
-		dev_err(&pdev->dev, "Error getting PHY irq. Use polling instead");
+	if (phy_irq == -EPROBE_DEFER) {
+		err = -EPROBE_DEFER;
+		goto out;
+	} else if (phy_irq < 0) {
 		phy_irq = PHY_POLL;
 	}
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 7775418316df..d6cf97ecf327 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -127,11 +127,8 @@ static int fbnic_mbx_map_msg(struct fbnic_dev *fbd, int mbx_idx,
 		return -EBUSY;
 
 	addr = dma_map_single(fbd->dev, msg, PAGE_SIZE, direction);
-	if (dma_mapping_error(fbd->dev, addr)) {
-		free_page((unsigned long)msg);
-
+	if (dma_mapping_error(fbd->dev, addr))
 		return -ENOSPC;
-	}
 
 	mbx->buf_info[tail].msg = msg;
 	mbx->buf_info[tail].addr = addr;
diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 1a1cbd034eda..2acd9c3531de 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -18,6 +18,8 @@
 #define EEPROM_MAC_OFFSET		    (0x01)
 #define MAX_EEPROM_SIZE			    (512)
 #define MAX_OTP_SIZE			    (1024)
+#define MAX_HS_OTP_SIZE			    (8 * 1024)
+#define MAX_HS_EEPROM_SIZE		    (64 * 1024)
 #define OTP_INDICATOR_1			    (0xF3)
 #define OTP_INDICATOR_2			    (0xF7)
 
@@ -272,6 +274,9 @@ static int lan743x_hs_otp_read(struct lan743x_adapter *adapter, u32 offset,
 	int ret;
 	int i;
 
+	if (offset + length > MAX_HS_OTP_SIZE)
+		return -EINVAL;
+
 	ret = lan743x_hs_syslock_acquire(adapter, LOCK_TIMEOUT_MAX_CNT);
 	if (ret < 0)
 		return ret;
@@ -320,6 +325,9 @@ static int lan743x_hs_otp_write(struct lan743x_adapter *adapter, u32 offset,
 	int ret;
 	int i;
 
+	if (offset + length > MAX_HS_OTP_SIZE)
+		return -EINVAL;
+
 	ret = lan743x_hs_syslock_acquire(adapter, LOCK_TIMEOUT_MAX_CNT);
 	if (ret < 0)
 		return ret;
@@ -497,6 +505,9 @@ static int lan743x_hs_eeprom_read(struct lan743x_adapter *adapter,
 	u32 val;
 	int i;
 
+	if (offset + length > MAX_HS_EEPROM_SIZE)
+		return -EINVAL;
+
 	retval = lan743x_hs_syslock_acquire(adapter, LOCK_TIMEOUT_MAX_CNT);
 	if (retval < 0)
 		return retval;
@@ -539,6 +550,9 @@ static int lan743x_hs_eeprom_write(struct lan743x_adapter *adapter,
 	u32 val;
 	int i;
 
+	if (offset + length > MAX_HS_EEPROM_SIZE)
+		return -EINVAL;
+
 	retval = lan743x_hs_syslock_acquire(adapter, LOCK_TIMEOUT_MAX_CNT);
 	if (retval < 0)
 		return retval;
@@ -604,9 +618,9 @@ static int lan743x_ethtool_get_eeprom_len(struct net_device *netdev)
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
 
 	if (adapter->flags & LAN743X_ADAPTER_FLAG_OTP)
-		return MAX_OTP_SIZE;
+		return adapter->is_pci11x1x ? MAX_HS_OTP_SIZE : MAX_OTP_SIZE;
 
-	return MAX_EEPROM_SIZE;
+	return adapter->is_pci11x1x ? MAX_HS_EEPROM_SIZE : MAX_EEPROM_SIZE;
 }
 
 static int lan743x_ethtool_get_eeprom(struct net_device *netdev,
diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.h b/drivers/net/ethernet/microchip/lan743x_ptp.h
index 0d29914cd460..225e8232474d 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.h
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.h
@@ -18,9 +18,9 @@
  */
 #define LAN743X_PTP_N_EVENT_CHAN	2
 #define LAN743X_PTP_N_PEROUT		LAN743X_PTP_N_EVENT_CHAN
-#define LAN743X_PTP_N_EXTTS		4
-#define LAN743X_PTP_N_PPS		0
 #define PCI11X1X_PTP_IO_MAX_CHANNELS	8
+#define LAN743X_PTP_N_EXTTS		PCI11X1X_PTP_IO_MAX_CHANNELS
+#define LAN743X_PTP_N_PPS		0
 #define PTP_CMD_CTL_TIMEOUT_CNT		50
 
 struct lan743x_adapter;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 0f817c3f92d8..533df5993048 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -515,9 +515,9 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 	unsigned long start_time;
 	unsigned long max_wait;
 	unsigned long duration;
-	int done = 0;
 	bool fw_up;
 	int opcode;
+	bool done;
 	int err;
 
 	/* Wait for dev cmd to complete, retrying if we get EAGAIN,
@@ -525,6 +525,7 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 	 */
 	max_wait = jiffies + (max_seconds * HZ);
 try_again:
+	done = false;
 	opcode = idev->opcode;
 	start_time = jiffies;
 	for (fw_up = ionic_is_fw_running(idev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f68e3ece919c..0250c5cb28ff 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4424,8 +4424,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (priv->sarc_type)
 		stmmac_set_desc_sarc(priv, first, priv->sarc_type);
 
-	skb_tx_timestamp(skb);
-
 	if (unlikely((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
 		     priv->hwts_tx_en)) {
 		/* declare that device is doing timestamping */
@@ -4460,6 +4458,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
+	skb_tx_timestamp(skb);
 
 	stmmac_flush_tx_descriptors(priv, queue);
 	stmmac_tx_timer_arm(priv, queue);
@@ -4703,8 +4702,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (priv->sarc_type)
 		stmmac_set_desc_sarc(priv, first, priv->sarc_type);
 
-	skb_tx_timestamp(skb);
-
 	/* Ready to fill the first descriptor and set the OWN bit w/o any
 	 * problems because all the descriptors are actually ready to be
 	 * passed to the DMA engine.
@@ -4751,7 +4748,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
 
 	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
-
+	skb_tx_timestamp(skb);
 	stmmac_flush_tx_descriptors(priv, queue);
 	stmmac_tx_timer_arm(priv, queue);
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 61788a43cb86..393cc5192e90 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2693,7 +2693,9 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 			goto of_node_put;
 
 		ret = of_get_mac_address(port_np, port->slave.mac_addr);
-		if (ret) {
+		if (ret == -EPROBE_DEFER) {
+			goto of_node_put;
+		} else if (ret) {
 			am65_cpsw_am654_get_efuse_macid(port_np,
 							port->port_id,
 							port->slave.mac_addr);
@@ -3586,6 +3588,16 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	am65_cpsw_nuss_get_ver(common);
+
+	ret = am65_cpsw_nuss_init_host_p(common);
+	if (ret)
+		goto err_pm_clear;
+
+	ret = am65_cpsw_nuss_init_slave_ports(common);
+	if (ret)
+		goto err_pm_clear;
+
 	node = of_get_child_by_name(dev->of_node, "mdio");
 	if (!node) {
 		dev_warn(dev, "MDIO node not found\n");
@@ -3602,16 +3614,6 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 	}
 	of_node_put(node);
 
-	am65_cpsw_nuss_get_ver(common);
-
-	ret = am65_cpsw_nuss_init_host_p(common);
-	if (ret)
-		goto err_of_clear;
-
-	ret = am65_cpsw_nuss_init_slave_ports(common);
-	if (ret)
-		goto err_of_clear;
-
 	/* init common data */
 	ale_params.dev = dev;
 	ale_params.ale_ageout = AM65_CPSW_ALE_AGEOUT_DEFAULT;
diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethernet/vertexcom/mse102x.c
index e4d993f31374..545177e84c0e 100644
--- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -306,7 +306,7 @@ static void mse102x_dump_packet(const char *msg, int len, const char *data)
 		       data, len, true);
 }
 
-static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
+static irqreturn_t mse102x_rx_pkt_spi(struct mse102x_net *mse)
 {
 	struct sk_buff *skb;
 	unsigned int rxalign;
@@ -327,7 +327,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
 		mse102x_tx_cmd_spi(mse, CMD_CTR);
 		ret = mse102x_rx_cmd_spi(mse, (u8 *)&rx);
 		if (ret)
-			return;
+			return IRQ_NONE;
 
 		cmd_resp = be16_to_cpu(rx);
 		if ((cmd_resp & CMD_MASK) != CMD_RTS) {
@@ -360,7 +360,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
 	rxalign = ALIGN(rxlen + DET_SOF_LEN + DET_DFT_LEN, 4);
 	skb = netdev_alloc_skb_ip_align(mse->ndev, rxalign);
 	if (!skb)
-		return;
+		return IRQ_NONE;
 
 	/* 2 bytes Start of frame (before ethernet header)
 	 * 2 bytes Data frame tail (after ethernet frame)
@@ -370,7 +370,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
 	if (mse102x_rx_frame_spi(mse, rxpkt, rxlen, drop)) {
 		mse->ndev->stats.rx_errors++;
 		dev_kfree_skb(skb);
-		return;
+		return IRQ_HANDLED;
 	}
 
 	if (netif_msg_pktdata(mse))
@@ -381,6 +381,8 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
 
 	mse->ndev->stats.rx_packets++;
 	mse->ndev->stats.rx_bytes += rxlen;
+
+	return IRQ_HANDLED;
 }
 
 static int mse102x_tx_pkt_spi(struct mse102x_net *mse, struct sk_buff *txb,
@@ -512,12 +514,13 @@ static irqreturn_t mse102x_irq(int irq, void *_mse)
 {
 	struct mse102x_net *mse = _mse;
 	struct mse102x_net_spi *mses = to_mse102x_spi(mse);
+	irqreturn_t ret;
 
 	mutex_lock(&mses->lock);
-	mse102x_rx_pkt_spi(mse);
+	ret = mse102x_rx_pkt_spi(mse);
 	mutex_unlock(&mses->lock);
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static int mse102x_net_open(struct net_device *ndev)
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 79b898311819..ee2a7b2f6268 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -25,6 +25,7 @@
 #include <net/pkt_cls.h>
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
+#include <net/busy_poll.h>
 
 #include "netdevsim.h"
 
@@ -341,6 +342,7 @@ static int nsim_rcv(struct nsim_rq *rq, int budget)
 			break;
 
 		skb = skb_dequeue(&rq->skb_queue);
+		skb_mark_napi_id(skb, &rq->napi);
 		netif_receive_skb(skb);
 	}
 
diff --git a/drivers/net/usb/asix.h b/drivers/net/usb/asix.h
index 74162190bccc..8531b804021a 100644
--- a/drivers/net/usb/asix.h
+++ b/drivers/net/usb/asix.h
@@ -224,7 +224,6 @@ int asix_write_rx_ctl(struct usbnet *dev, u16 mode, int in_pm);
 
 u16 asix_read_medium_status(struct usbnet *dev, int in_pm);
 int asix_write_medium_mode(struct usbnet *dev, u16 mode, int in_pm);
-void asix_adjust_link(struct net_device *netdev);
 
 int asix_write_gpio(struct usbnet *dev, u16 value, int sleep, int in_pm);
 
diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index 72ffc89b477a..7fd763917ae2 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -414,28 +414,6 @@ int asix_write_medium_mode(struct usbnet *dev, u16 mode, int in_pm)
 	return ret;
 }
 
-/* set MAC link settings according to information from phylib */
-void asix_adjust_link(struct net_device *netdev)
-{
-	struct phy_device *phydev = netdev->phydev;
-	struct usbnet *dev = netdev_priv(netdev);
-	u16 mode = 0;
-
-	if (phydev->link) {
-		mode = AX88772_MEDIUM_DEFAULT;
-
-		if (phydev->duplex == DUPLEX_HALF)
-			mode &= ~AX_MEDIUM_FD;
-
-		if (phydev->speed != SPEED_100)
-			mode &= ~AX_MEDIUM_PS;
-	}
-
-	asix_write_medium_mode(dev, mode, 0);
-	phy_print_status(phydev);
-	usbnet_link_change(dev, phydev->link, 0);
-}
-
 int asix_write_gpio(struct usbnet *dev, u16 value, int sleep, int in_pm)
 {
 	int ret;
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index da24941a6e44..9b0318fb50b5 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -752,7 +752,6 @@ static void ax88772_mac_link_down(struct phylink_config *config,
 	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
 
 	asix_write_medium_mode(dev, 0, 0);
-	usbnet_link_change(dev, false, false);
 }
 
 static void ax88772_mac_link_up(struct phylink_config *config,
@@ -783,7 +782,6 @@ static void ax88772_mac_link_up(struct phylink_config *config,
 		m |= AX_MEDIUM_RFC;
 
 	asix_write_medium_mode(dev, m, 0);
-	usbnet_link_change(dev, true, false);
 }
 
 static const struct phylink_mac_ops ax88772_phylink_mac_ops = {
@@ -1350,10 +1348,9 @@ static const struct driver_info ax88772_info = {
 	.description = "ASIX AX88772 USB 2.0 Ethernet",
 	.bind = ax88772_bind,
 	.unbind = ax88772_unbind,
-	.status = asix_status,
 	.reset = ax88772_reset,
 	.stop = ax88772_stop,
-	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR | FLAG_MULTI_PACKET,
+	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET,
 	.rx_fixup = asix_rx_fixup_common,
 	.tx_fixup = asix_tx_fixup,
 };
@@ -1362,11 +1359,9 @@ static const struct driver_info ax88772b_info = {
 	.description = "ASIX AX88772B USB 2.0 Ethernet",
 	.bind = ax88772_bind,
 	.unbind = ax88772_unbind,
-	.status = asix_status,
 	.reset = ax88772_reset,
 	.stop = ax88772_stop,
-	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |
-	         FLAG_MULTI_PACKET,
+	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET,
 	.rx_fixup = asix_rx_fixup_common,
 	.tx_fixup = asix_tx_fixup,
 	.data = FLAG_EEPROM_MAC,
@@ -1376,11 +1371,9 @@ static const struct driver_info lxausb_t1l_info = {
 	.description = "Linux Automation GmbH USB 10Base-T1L",
 	.bind = ax88772_bind,
 	.unbind = ax88772_unbind,
-	.status = asix_status,
 	.reset = ax88772_reset,
 	.stop = ax88772_stop,
-	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |
-		 FLAG_MULTI_PACKET,
+	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET,
 	.rx_fixup = asix_rx_fixup_common,
 	.tx_fixup = asix_tx_fixup,
 	.data = FLAG_EEPROM_MAC,
@@ -1412,10 +1405,8 @@ static const struct driver_info hg20f9_info = {
 	.description = "HG20F9 USB 2.0 Ethernet",
 	.bind = ax88772_bind,
 	.unbind = ax88772_unbind,
-	.status = asix_status,
 	.reset = ax88772_reset,
-	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |
-	         FLAG_MULTI_PACKET,
+	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET,
 	.rx_fixup = asix_rx_fixup_common,
 	.tx_fixup = asix_tx_fixup,
 	.data = FLAG_EEPROM_MAC,
diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index f69d9b902da0..a206ffa76f1b 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -178,6 +178,7 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
 {
 	struct usbnet *dev = netdev_priv(netdev);
 	unsigned char buff[2];
+	int ret;
 
 	netdev_dbg(netdev, "%s phy_id:%02x loc:%02x\n",
 		   __func__, phy_id, loc);
@@ -185,8 +186,10 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	if (phy_id != 0)
 		return -ENODEV;
 
-	control_read(dev, REQUEST_READ, 0, loc * 2, buff, 0x02,
-		     CONTROL_TIMEOUT_MS);
+	ret = control_read(dev, REQUEST_READ, 0, loc * 2, buff, 0x02,
+			   CONTROL_TIMEOUT_MS);
+	if (ret < 0)
+		return ret;
 
 	return (buff[0] | buff[1] << 8);
 }
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 474faccf75fd..1a7077093800 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -605,10 +605,10 @@ static int vxlan_fdb_append(struct vxlan_fdb *f,
 	if (rd == NULL)
 		return -ENOMEM;
 
-	if (dst_cache_init(&rd->dst_cache, GFP_ATOMIC)) {
-		kfree(rd);
-		return -ENOMEM;
-	}
+	/* The driver can work correctly without a dst cache, so do not treat
+	 * dst cache initialization errors as fatal.
+	 */
+	dst_cache_init(&rd->dst_cache, GFP_ATOMIC | __GFP_NOWARN);
 
 	rd->remote_ip = *ip;
 	rd->remote_port = port;
diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index e66e86bdec20..9d8efec46508 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -393,11 +393,10 @@ static int ath11k_ce_completed_recv_next(struct ath11k_ce_pipe *pipe,
 		goto err;
 	}
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
-	if (*nbytes == 0) {
-		ret = -EIO;
-		goto err;
-	}
 
 	*skb = pipe->dest_ring->skb[sw_index];
 	pipe->dest_ring->skb[sw_index] = NULL;
@@ -430,8 +429,8 @@ static void ath11k_ce_recv_process_cb(struct ath11k_ce_pipe *pipe)
 		dma_unmap_single(ab->dev, ATH11K_SKB_RXCB(skb)->paddr,
 				 max_nbytes, DMA_FROM_DEVICE);
 
-		if (unlikely(max_nbytes < nbytes)) {
-			ath11k_warn(ab, "rxed more than expected (nbytes %d, max %d)",
+		if (unlikely(max_nbytes < nbytes || nbytes == 0)) {
+			ath11k_warn(ab, "unexpected rx length (nbytes %d, max %d)",
 				    nbytes, max_nbytes);
 			dev_kfree_skb_any(skb);
 			continue;
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 8002fb32a2cc..2ec1771262fd 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -811,6 +811,52 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 	},
 };
 
+static const struct dmi_system_id ath11k_pm_quirk_table[] = {
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J4"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21K4"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21K6"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21K8"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21KA"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
+		},
+	},
+	{}
+};
+
 static inline struct ath11k_pdev *ath11k_core_get_single_pdev(struct ath11k_base *ab)
 {
 	WARN_ON(!ab->hw_params.single_pdev_only);
@@ -2197,8 +2243,17 @@ EXPORT_SYMBOL(ath11k_core_pre_init);
 
 int ath11k_core_init(struct ath11k_base *ab)
 {
+	const struct dmi_system_id *dmi_id;
 	int ret;
 
+	dmi_id = dmi_first_match(ath11k_pm_quirk_table);
+	if (dmi_id)
+		ab->pm_policy = (kernel_ulong_t)dmi_id->driver_data;
+	else
+		ab->pm_policy = ATH11K_PM_DEFAULT;
+
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "pm policy %u\n", ab->pm_policy);
+
 	ret = ath11k_core_soc_create(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to create soc core: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index fcdec14eb3cf..09fdb7be0e19 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -891,6 +891,11 @@ struct ath11k_msi_config {
 	u16 hw_rev;
 };
 
+enum ath11k_pm_policy {
+	ATH11K_PM_DEFAULT,
+	ATH11K_PM_WOW,
+};
+
 /* Master structure to hold the hw data which may be used in core module */
 struct ath11k_base {
 	enum ath11k_hw_rev hw_rev;
@@ -1053,6 +1058,8 @@ struct ath11k_base {
 	} testmode;
 #endif
 
+	enum ath11k_pm_policy pm_policy;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index bfb8e7b1a300..007d86959042 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2637,7 +2637,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 	struct ath11k *ar;
 	struct hal_reo_dest_ring *desc;
 	enum hal_reo_dest_ring_push_reason push_reason;
-	u32 cookie;
+	u32 cookie, info0, rx_msdu_info0, rx_mpdu_info0;
 	int i;
 
 	for (i = 0; i < MAX_RADIOS; i++)
@@ -2650,11 +2650,14 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 try_again:
 	ath11k_hal_srng_access_begin(ab, srng);
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	while (likely(desc =
 	      (struct hal_reo_dest_ring *)ath11k_hal_srng_dst_get_next_entry(ab,
 									     srng))) {
 		cookie = FIELD_GET(BUFFER_ADDR_INFO1_SW_COOKIE,
-				   desc->buf_addr_info.info1);
+				   READ_ONCE(desc->buf_addr_info.info1));
 		buf_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_BUF_ID,
 				   cookie);
 		mac_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_PDEV_ID, cookie);
@@ -2683,8 +2686,9 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 
 		num_buffs_reaped[mac_id]++;
 
+		info0 = READ_ONCE(desc->info0);
 		push_reason = FIELD_GET(HAL_REO_DEST_RING_INFO0_PUSH_REASON,
-					desc->info0);
+					info0);
 		if (unlikely(push_reason !=
 			     HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION)) {
 			dev_kfree_skb_any(msdu);
@@ -2692,18 +2696,21 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 			continue;
 		}
 
-		rxcb->is_first_msdu = !!(desc->rx_msdu_info.info0 &
+		rx_msdu_info0 = READ_ONCE(desc->rx_msdu_info.info0);
+		rx_mpdu_info0 = READ_ONCE(desc->rx_mpdu_info.info0);
+
+		rxcb->is_first_msdu = !!(rx_msdu_info0 &
 					 RX_MSDU_DESC_INFO0_FIRST_MSDU_IN_MPDU);
-		rxcb->is_last_msdu = !!(desc->rx_msdu_info.info0 &
+		rxcb->is_last_msdu = !!(rx_msdu_info0 &
 					RX_MSDU_DESC_INFO0_LAST_MSDU_IN_MPDU);
-		rxcb->is_continuation = !!(desc->rx_msdu_info.info0 &
+		rxcb->is_continuation = !!(rx_msdu_info0 &
 					   RX_MSDU_DESC_INFO0_MSDU_CONTINUATION);
 		rxcb->peer_id = FIELD_GET(RX_MPDU_DESC_META_DATA_PEER_ID,
-					  desc->rx_mpdu_info.meta_data);
+					  READ_ONCE(desc->rx_mpdu_info.meta_data));
 		rxcb->seq_no = FIELD_GET(RX_MPDU_DESC_INFO0_SEQ_NUM,
-					 desc->rx_mpdu_info.info0);
+					 rx_mpdu_info0);
 		rxcb->tid = FIELD_GET(HAL_REO_DEST_RING_INFO0_RX_QUEUE_NUM,
-				      desc->info0);
+				      info0);
 
 		rxcb->mac_id = mac_id;
 		__skb_queue_tail(&msdu_list[mac_id], msdu);
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index f02599bd1c36..c445bf5cd832 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -599,7 +599,7 @@ u32 ath11k_hal_ce_dst_status_get_length(void *buf)
 	struct hal_ce_srng_dst_status_desc *desc = buf;
 	u32 len;
 
-	len = FIELD_GET(HAL_CE_DST_STATUS_DESC_FLAGS_LEN, desc->flags);
+	len = FIELD_GET(HAL_CE_DST_STATUS_DESC_FLAGS_LEN, READ_ONCE(desc->flags));
 	desc->flags &= ~HAL_CE_DST_STATUS_DESC_FLAGS_LEN;
 
 	return len;
@@ -829,7 +829,7 @@ void ath11k_hal_srng_access_begin(struct ath11k_base *ab, struct hal_srng *srng)
 		srng->u.src_ring.cached_tp =
 			*(volatile u32 *)srng->u.src_ring.tp_addr;
 	} else {
-		srng->u.dst_ring.cached_hp = *srng->u.dst_ring.hp_addr;
+		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
 
 		/* Try to prefetch the next descriptor in the ring */
 		if (srng->flags & HAL_SRNG_FLAGS_CACHED)
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 7a22483b35cd..a5555c959dec 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1989,6 +1989,15 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 			    chunk->prev_size == chunk->size)
 				continue;
 
+			if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {
+				ath11k_dbg(ab, ATH11K_DBG_QMI,
+					   "size/type mismatch (current %d %u) (prev %d %u), try later with small size\n",
+					    chunk->size, chunk->type,
+					    chunk->prev_size, chunk->prev_type);
+				ab->qmi.target_mem_delayed = true;
+				return 0;
+			}
+
 			/* cannot reuse the existing chunk */
 			dma_free_coherent(ab->dev, chunk->prev_size,
 					  chunk->vaddr, chunk->paddr);
diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
index be0d669d31fc..740586fe49d1 100644
--- a/drivers/net/wireless/ath/ath12k/ce.c
+++ b/drivers/net/wireless/ath/ath12k/ce.c
@@ -343,11 +343,10 @@ static int ath12k_ce_completed_recv_next(struct ath12k_ce_pipe *pipe,
 		goto err;
 	}
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	*nbytes = ath12k_hal_ce_dst_status_get_length(desc);
-	if (*nbytes == 0) {
-		ret = -EIO;
-		goto err;
-	}
 
 	*skb = pipe->dest_ring->skb[sw_index];
 	pipe->dest_ring->skb[sw_index] = NULL;
@@ -380,8 +379,8 @@ static void ath12k_ce_recv_process_cb(struct ath12k_ce_pipe *pipe)
 		dma_unmap_single(ab->dev, ATH12K_SKB_RXCB(skb)->paddr,
 				 max_nbytes, DMA_FROM_DEVICE);
 
-		if (unlikely(max_nbytes < nbytes)) {
-			ath12k_warn(ab, "rxed more than expected (nbytes %d, max %d)",
+		if (unlikely(max_nbytes < nbytes || nbytes == 0)) {
+			ath12k_warn(ab, "unexpected rx length (nbytes %d, max %d)",
 				    nbytes, max_nbytes);
 			dev_kfree_skb_any(skb);
 			continue;
diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
index 857bc5f9e946..f9547a3945e4 100644
--- a/drivers/net/wireless/ath/ath12k/ce.h
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_CE_H
@@ -39,8 +39,8 @@
 #define PIPEDIR_INOUT_H2H	4 /* bidirectional, host to host */
 
 /* CE address/mask */
-#define CE_HOST_IE_ADDRESS	0x00A1803C
-#define CE_HOST_IE_2_ADDRESS	0x00A18040
+#define CE_HOST_IE_ADDRESS	0x75804C
+#define CE_HOST_IE_2_ADDRESS	0x758050
 #define CE_HOST_IE_3_ADDRESS	CE_HOST_IE_ADDRESS
 
 #define CE_HOST_IE_3_SHIFT	0xC
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 6a8874536944..7bfd323cdf24 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1080,6 +1080,8 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol_tkip = rxcb->is_eapol;
 
+	status->link_valid = 0;
+
 	if ((status->encoding == RX_ENC_HE) && !(status->flag & RX_FLAG_RADIOTAP_HE) &&
 	    !(status->flag & RX_FLAG_SKIP_MONITOR)) {
 		he = skb_push(msdu, sizeof(known));
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index bfa404997710..3afb11c7bf18 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -449,8 +449,8 @@ static u8 *ath12k_hw_qcn9274_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
 
 static bool ath12k_hw_qcn9274_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
 {
-	return __le32_to_cpu(desc->u.qcn9274.mpdu_start.info6) &
-	       RX_MPDU_START_INFO6_MCAST_BCAST;
+	return __le16_to_cpu(desc->u.qcn9274.msdu_end.info5) &
+	       RX_MSDU_END_INFO5_DA_IS_MCBC;
 }
 
 static void ath12k_hw_qcn9274_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
@@ -902,8 +902,8 @@ static u8 *ath12k_hw_qcn9274_compact_rx_desc_mpdu_start_addr2(struct hal_rx_desc
 
 static bool ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
 {
-	return __le32_to_cpu(desc->u.qcn9274_compact.mpdu_start.info6) &
-	       RX_MPDU_START_INFO6_MCAST_BCAST;
+	return __le16_to_cpu(desc->u.qcn9274_compact.msdu_end.info5) &
+	       RX_MSDU_END_INFO5_DA_IS_MCBC;
 }
 
 static void ath12k_hw_qcn9274_compact_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
@@ -1943,7 +1943,7 @@ u32 ath12k_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc *desc
 {
 	u32 len;
 
-	len = le32_get_bits(desc->flags, HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
+	len = le32_get_bits(READ_ONCE(desc->flags), HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
 	desc->flags &= ~cpu_to_le32(HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
 
 	return len;
@@ -2113,7 +2113,7 @@ void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
 		srng->u.src_ring.cached_tp =
 			*(volatile u32 *)srng->u.src_ring.tp_addr;
 	else
-		srng->u.dst_ring.cached_hp = *srng->u.dst_ring.hp_addr;
+		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
 }
 
 /* Update cached ring head/tail pointers to HW. ath12k_hal_srng_access_begin()
diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index c68998e9667c..8cbe28950d0c 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -705,7 +705,7 @@ enum hal_rx_msdu_desc_reo_dest_ind {
 #define RX_MSDU_DESC_INFO0_DECAP_FORMAT		GENMASK(30, 29)
 
 #define HAL_RX_MSDU_PKT_LENGTH_GET(val)		\
-	(u32_get_bits((val), RX_MSDU_DESC_INFO0_MSDU_LENGTH))
+	(le32_get_bits((val), RX_MSDU_DESC_INFO0_MSDU_LENGTH))
 
 struct rx_msdu_desc {
 	__le32 info0;
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 26f4b440c26d..0ac92a606cea 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1301,6 +1301,9 @@ void ath12k_pci_power_down(struct ath12k_base *ab, bool is_suspend)
 {
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 
+	if (!test_bit(ATH12K_PCI_FLAG_INIT_DONE, &ab_pci->flags))
+		return;
+
 	/* restore aspm in case firmware bootup fails */
 	ath12k_pci_aspm_restore(ab_pci);
 
@@ -1503,6 +1506,8 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
+	/* __free_irq() expects the caller to have cleared the affinity hint */
+	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
 	ath12k_pci_free_irq(ab);
 
 err_ce_free:
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 17ac54047f9a..5c2130f77dac 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -980,14 +980,24 @@ int ath12k_wmi_vdev_down(struct ath12k *ar, u8 vdev_id)
 static void ath12k_wmi_put_wmi_channel(struct ath12k_wmi_channel_params *chan,
 				       struct wmi_vdev_start_req_arg *arg)
 {
+	u32 center_freq1 = arg->band_center_freq1;
+
 	memset(chan, 0, sizeof(*chan));
 
 	chan->mhz = cpu_to_le32(arg->freq);
-	chan->band_center_freq1 = cpu_to_le32(arg->band_center_freq1);
-	if (arg->mode == MODE_11AC_VHT80_80)
+	chan->band_center_freq1 = cpu_to_le32(center_freq1);
+	if (arg->mode == MODE_11BE_EHT160) {
+		if (arg->freq > center_freq1)
+			chan->band_center_freq1 = cpu_to_le32(center_freq1 + 40);
+		else
+			chan->band_center_freq1 = cpu_to_le32(center_freq1 - 40);
+
+		chan->band_center_freq2 = cpu_to_le32(center_freq1);
+	} else if (arg->mode == MODE_11BE_EHT80_80) {
 		chan->band_center_freq2 = cpu_to_le32(arg->band_center_freq2);
-	else
+	} else {
 		chan->band_center_freq2 = 0;
+	}
 
 	chan->info |= le32_encode_bits(arg->mode, WMI_CHAN_INFO_MODE);
 	if (arg->passive)
@@ -5784,7 +5794,7 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 		goto fallback;
 	}
 
-	spin_lock(&ab->base_lock);
+	spin_lock_bh(&ab->base_lock);
 	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags)) {
 		/* Once mac is registered, ar is valid and all CC events from
 		 * fw is considered to be received due to user requests
@@ -5808,7 +5818,7 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 		ab->default_regd[pdev_idx] = regd;
 	}
 	ab->dfs_region = reg_info->dfs_region;
-	spin_unlock(&ab->base_lock);
+	spin_unlock_bh(&ab->base_lock);
 
 	goto mem_free;
 
diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
index a3e03580cd9f..564ca6a61985 100644
--- a/drivers/net/wireless/ath/carl9170/usb.c
+++ b/drivers/net/wireless/ath/carl9170/usb.c
@@ -438,14 +438,21 @@ static void carl9170_usb_rx_complete(struct urb *urb)
 
 		if (atomic_read(&ar->rx_anch_urbs) == 0) {
 			/*
-			 * The system is too slow to cope with
-			 * the enormous workload. We have simply
-			 * run out of active rx urbs and this
-			 * unfortunately leads to an unpredictable
-			 * device.
+			 * At this point, either the system is too slow to
+			 * cope with the enormous workload (so we have simply
+			 * run out of active rx urbs and this unfortunately
+			 * leads to an unpredictable device), or the device
+			 * is not fully functional after an unsuccessful
+			 * firmware loading attempts (so it doesn't pass
+			 * ieee80211_register_hw() and there is no internal
+			 * workqueue at all).
 			 */
 
-			ieee80211_queue_work(ar->hw, &ar->ping_work);
+			if (ar->registered)
+				ieee80211_queue_work(ar->hw, &ar->ping_work);
+			else
+				pr_warn_once("device %s is not registered\n",
+					     dev_name(&ar->udev->dev));
 		}
 	} else {
 		/*
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 2e2fcb3807ef..10d647fbc971 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -44,6 +44,8 @@
 	IWL_QU_C_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_QU_B_JF_B_MODULE_FIRMWARE(api) \
 	IWL_QU_B_JF_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_QU_C_JF_B_MODULE_FIRMWARE(api) \
+	IWL_QU_C_JF_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_CC_A_MODULE_FIRMWARE(api)			\
 	IWL_CC_A_FW_PRE "-" __stringify(api) ".ucode"
 
@@ -423,6 +425,7 @@ const struct iwl_cfg iwl_cfg_quz_a0_hr_b0 = {
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QU_C_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QUZ_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_CC_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index e96ddaeeeeff..d013de30e7ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -962,7 +962,7 @@ u16 iwl_mvm_mac_ctxt_get_beacon_flags(const struct iwl_fw *fw, u8 rate_idx)
 	u16 flags = iwl_mvm_mac80211_idx_to_hwrate(fw, rate_idx);
 	bool is_new_rate = iwl_fw_lookup_cmd_ver(fw, BEACON_TEMPLATE_CMD, 0) > 10;
 
-	if (rate_idx <= IWL_FIRST_CCK_RATE)
+	if (rate_idx <= IWL_LAST_CCK_RATE)
 		flags |= is_new_rate ? IWL_MAC_BEACON_CCK
 			  : IWL_MAC_BEACON_CCK_V1;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 18d7d59ae581..462ebe088b3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2726,6 +2726,8 @@ static ssize_t iwl_dbgfs_rx_queue_read(struct file *file,
 	for (i = 0; i < trans->num_rx_queues && pos < bufsz; i++) {
 		struct iwl_rxq *rxq = &trans_pcie->rxq[i];
 
+		spin_lock_bh(&rxq->lock);
+
 		pos += scnprintf(buf + pos, bufsz - pos, "queue#: %2d\n",
 				 i);
 		pos += scnprintf(buf + pos, bufsz - pos, "\tread: %u\n",
@@ -2746,6 +2748,7 @@ static ssize_t iwl_dbgfs_rx_queue_read(struct file *file,
 			pos += scnprintf(buf + pos, bufsz - pos,
 					 "\tclosed_rb_num: Not Allocated\n");
 		}
+		spin_unlock_bh(&rxq->lock);
 	}
 	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
 	kfree(buf);
@@ -3410,8 +3413,11 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
 		/* Dump RBs is supported only for pre-9000 devices (1 queue) */
 		struct iwl_rxq *rxq = &trans_pcie->rxq[0];
 		/* RBs */
+		spin_lock_bh(&rxq->lock);
 		num_rbs = iwl_get_closed_rb_stts(trans, rxq);
 		num_rbs = (num_rbs - rxq->read) & RX_QUEUE_MASK;
+		spin_unlock_bh(&rxq->lock);
+
 		len += num_rbs * (sizeof(*data) +
 				  sizeof(struct iwl_fw_error_dump_rb) +
 				  (PAGE_SIZE << trans_pcie->rx_page_order));
diff --git a/drivers/net/wireless/intersil/p54/fwio.c b/drivers/net/wireless/intersil/p54/fwio.c
index 772084a9bd8d..3baf8ab01e22 100644
--- a/drivers/net/wireless/intersil/p54/fwio.c
+++ b/drivers/net/wireless/intersil/p54/fwio.c
@@ -231,6 +231,7 @@ int p54_download_eeprom(struct p54_common *priv, void *buf,
 
 	mutex_lock(&priv->eeprom_mutex);
 	priv->eeprom = buf;
+	priv->eeprom_slice_size = len;
 	eeprom_hdr = skb_put(skb, eeprom_hdr_size + len);
 
 	if (priv->fw_var < 0x509) {
@@ -253,6 +254,7 @@ int p54_download_eeprom(struct p54_common *priv, void *buf,
 		ret = -EBUSY;
 	}
 	priv->eeprom = NULL;
+	priv->eeprom_slice_size = 0;
 	mutex_unlock(&priv->eeprom_mutex);
 	return ret;
 }
diff --git a/drivers/net/wireless/intersil/p54/p54.h b/drivers/net/wireless/intersil/p54/p54.h
index 522656de4159..aeb5e40cc5ef 100644
--- a/drivers/net/wireless/intersil/p54/p54.h
+++ b/drivers/net/wireless/intersil/p54/p54.h
@@ -258,6 +258,7 @@ struct p54_common {
 
 	/* eeprom handling */
 	void *eeprom;
+	size_t eeprom_slice_size;
 	struct completion eeprom_comp;
 	struct mutex eeprom_mutex;
 };
diff --git a/drivers/net/wireless/intersil/p54/txrx.c b/drivers/net/wireless/intersil/p54/txrx.c
index 8414aa208655..2deb1bb54f24 100644
--- a/drivers/net/wireless/intersil/p54/txrx.c
+++ b/drivers/net/wireless/intersil/p54/txrx.c
@@ -496,14 +496,19 @@ static void p54_rx_eeprom_readback(struct p54_common *priv,
 		return ;
 
 	if (priv->fw_var >= 0x509) {
-		memcpy(priv->eeprom, eeprom->v2.data,
-		       le16_to_cpu(eeprom->v2.len));
+		if (le16_to_cpu(eeprom->v2.len) != priv->eeprom_slice_size)
+			return;
+
+		memcpy(priv->eeprom, eeprom->v2.data, priv->eeprom_slice_size);
 	} else {
-		memcpy(priv->eeprom, eeprom->v1.data,
-		       le16_to_cpu(eeprom->v1.len));
+		if (le16_to_cpu(eeprom->v1.len) != priv->eeprom_slice_size)
+			return;
+
+		memcpy(priv->eeprom, eeprom->v1.data, priv->eeprom_slice_size);
 	}
 
 	priv->eeprom = NULL;
+	priv->eeprom_slice_size = 0;
 	tmp = p54_find_and_unlink_skb(priv, hdr->req_id);
 	dev_kfree_skb_any(tmp);
 	complete(&priv->eeprom_comp);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 84ef80ab4afb..96cecc576a98 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -17,6 +17,8 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x057c, 0x8503) },	/* Avm FRITZ!WLAN AC860 */
 	{ USB_DEVICE(0x7392, 0xb711) },	/* Edimax EW 7722 UAC */
 	{ USB_DEVICE(0x0e8d, 0x7632) },	/* HC-M7662BU1 */
+	{ USB_DEVICE(0x0471, 0x2126) }, /* LiteOn WN4516R module, nonstandard USB connector */
+	{ USB_DEVICE(0x0471, 0x7600) }, /* LiteOn WN4519R module, nonstandard USB connector */
 	{ USB_DEVICE(0x2c4e, 0x0103) },	/* Mercury UD13 */
 	{ USB_DEVICE(0x0846, 0x9014) },	/* Netgear WNDA3100v3 */
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index 33a14365ec9b..3b5562811511 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -191,6 +191,7 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct mt76_usb *usb = &dev->mt76.usb;
+	bool vht;
 	int err;
 
 	INIT_DELAYED_WORK(&dev->cal_work, mt76x2u_phy_calibrate);
@@ -217,7 +218,17 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 
 	/* check hw sg support in order to enable AMSDU */
 	hw->max_tx_fragments = dev->mt76.usb.sg_en ? MT_TX_SG_MAX_SIZE : 1;
-	err = mt76_register_device(&dev->mt76, true, mt76x02_rates,
+	switch (dev->mt76.rev) {
+	case 0x76320044:
+		/* these ASIC revisions do not support VHT */
+		vht = false;
+		break;
+	default:
+		vht = true;
+		break;
+	}
+
+	err = mt76_register_device(&dev->mt76, vht, mt76x02_rates,
 				   ARRAY_SIZE(mt76x02_rates));
 	if (err)
 		goto fail;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 6a3629f71caa..9c245c23a2d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -83,6 +83,11 @@ mt7921_init_he_caps(struct mt792x_phy *phy, enum nl80211_band band,
 			he_cap_elem->phy_cap_info[9] |=
 				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
 				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
+
+			if (is_mt7922(phy->mt76->dev)) {
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+			}
 			break;
 		case NL80211_IFTYPE_STATION:
 			he_cap_elem->mac_cap_info[1] |=
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 039949b344b9..14553dcc61c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -204,6 +204,12 @@ static void mt7925_init_work(struct work_struct *work)
 		return;
 	}
 
+	ret = mt7925_mcu_set_thermal_protect(dev);
+	if (ret) {
+		dev_err(dev->mt76.dev, "thermal protection enable failed\n");
+		return;
+	}
+
 	/* we support chip reset now */
 	dev->hw_init_done = true;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index a19c108ad4b5..57a1db394dda 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -961,6 +961,23 @@ int mt7925_mcu_set_deep_sleep(struct mt792x_dev *dev, bool enable)
 }
 EXPORT_SYMBOL_GPL(mt7925_mcu_set_deep_sleep);
 
+int mt7925_mcu_set_thermal_protect(struct mt792x_dev *dev)
+{
+	char cmd[64];
+	int ret = 0;
+
+	snprintf(cmd, sizeof(cmd), "ThermalProtGband %d %d %d %d %d %d %d %d %d %d",
+		 0, 100, 90, 80, 30, 1, 1, 115, 105, 5);
+	ret = mt7925_mcu_chip_config(dev, cmd);
+
+	snprintf(cmd, sizeof(cmd), "ThermalProtAband %d %d %d %d %d %d %d %d %d %d",
+		 1, 100, 90, 80, 30, 1, 1, 115, 105, 5);
+	ret |= mt7925_mcu_chip_config(dev, cmd);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt7925_mcu_set_thermal_protect);
+
 int mt7925_run_firmware(struct mt792x_dev *dev)
 {
 	int err;
@@ -3288,7 +3305,8 @@ int mt7925_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 		else
 			uni_txd->option = MCU_CMD_UNI_EXT_ACK;
 
-		if (cmd == MCU_UNI_CMD(HIF_CTRL))
+		if (cmd == MCU_UNI_CMD(HIF_CTRL) ||
+		    cmd == MCU_UNI_CMD(CHIP_CONFIG))
 			uni_txd->option &= ~MCU_CMD_ACK;
 
 		goto exit;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 887427e0760a..780c5921679a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -635,6 +635,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 int mt7925_mcu_set_timing(struct mt792x_phy *phy,
 			  struct ieee80211_bss_conf *link_conf);
 int mt7925_mcu_set_deep_sleep(struct mt792x_dev *dev, bool enable);
+int mt7925_mcu_set_thermal_protect(struct mt792x_dev *dev);
 int mt7925_mcu_set_channel_domain(struct mt76_phy *phy);
 int mt7925_mcu_set_radio_en(struct mt792x_phy *phy, bool enable);
 int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 9aec675450f2..5e428f19f972 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -482,9 +482,6 @@ static int mt7925_pci_suspend(struct device *device)
 
 	/* disable interrupt */
 	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
-	mt76_wr(dev, MT_WFDMA0_HOST_INT_DIS,
-		dev->irq_map->tx.all_complete_mask |
-		MT_INT_RX_DONE_ALL | MT_INT_MCU_CMD);
 
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
index 985794a40c1a..547489092c29 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
@@ -28,7 +28,7 @@
 #define MT_MDP_TO_HIF			0
 #define MT_MDP_TO_WM			1
 
-#define MT_WFDMA0_HOST_INT_ENA		MT_WFDMA0(0x228)
+#define MT_WFDMA0_HOST_INT_ENA		MT_WFDMA0(0x204)
 #define MT_WFDMA0_HOST_INT_DIS		MT_WFDMA0(0x22c)
 #define HOST_RX_DONE_INT_ENA4		BIT(12)
 #define HOST_RX_DONE_INT_ENA5		BIT(13)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index ef2d7eaaaffd..0990a3d481f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -623,6 +623,14 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
 		status->last_amsdu = amsdu_info == MT_RXD4_LAST_AMSDU_FRAME;
 	}
 
+	/* IEEE 802.11 fragmentation can only be applied to unicast frames.
+	 * Hence, drop fragments with multicast/broadcast RA.
+	 * This check fixes vulnerabilities, like CVE-2020-26145.
+	 */
+	if ((ieee80211_has_morefrags(fc) || seq_ctrl & IEEE80211_SCTL_FRAG) &&
+	    FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) != MT_RXD3_NORMAL_U2M)
+		return -EINVAL;
+
 	hdr_gap = (u8 *)rxd - skb->data + 2 * remove_pad;
 	if (hdr_trans && ieee80211_has_morefrags(fc)) {
 		if (mt7996_reverse_frag0_hdr_trans(skb, hdr_gap))
diff --git a/drivers/net/wireless/purelifi/plfxlc/usb.c b/drivers/net/wireless/purelifi/plfxlc/usb.c
index 56d1139ba8bc..7e7bfa532ed2 100644
--- a/drivers/net/wireless/purelifi/plfxlc/usb.c
+++ b/drivers/net/wireless/purelifi/plfxlc/usb.c
@@ -503,8 +503,10 @@ int plfxlc_usb_wreq_async(struct plfxlc_usb *usb, const u8 *buffer,
 			  (void *)buffer, buffer_len, complete_fn, context);
 
 	r = usb_submit_urb(urb, GFP_ATOMIC);
-	if (r)
+	if (r) {
+		usb_free_urb(urb);
 		dev_err(&udev->dev, "Async write submit failed (%d)\n", r);
+	}
 
 	return r;
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 0eafc4d125f9..898f597f70a9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -155,6 +155,16 @@ static void _rtl_pci_update_default_setting(struct ieee80211_hw *hw)
 	    ((u8)init_aspm) == (PCI_EXP_LNKCTL_ASPM_L0S |
 				PCI_EXP_LNKCTL_ASPM_L1 | PCI_EXP_LNKCTL_CCC))
 		ppsc->support_aspm = false;
+
+	/* RTL8723BE found on some ASUSTek laptops, such as F441U and
+	 * X555UQ with subsystem ID 11ad:1723 are known to output large
+	 * amounts of PCIe AER errors during and after boot up, causing
+	 * heavy lags, poor network throughput, and occasional lock-ups.
+	 */
+	if (rtlpriv->rtlhal.hw_type == HARDWARE_TYPE_RTL8723BE &&
+	    (rtlpci->pdev->subsystem_vendor == 0x11ad &&
+	     rtlpci->pdev->subsystem_device == 0x1723))
+		ppsc->support_aspm = false;
 }
 
 static bool _rtl_pci_platform_switch_device_pci_aspm(
diff --git a/drivers/net/wireless/realtek/rtw88/hci.h b/drivers/net/wireless/realtek/rtw88/hci.h
index 96aeda26014e..d4bee9c3ecfe 100644
--- a/drivers/net/wireless/realtek/rtw88/hci.h
+++ b/drivers/net/wireless/realtek/rtw88/hci.h
@@ -19,6 +19,8 @@ struct rtw_hci_ops {
 	void (*link_ps)(struct rtw_dev *rtwdev, bool enter);
 	void (*interface_cfg)(struct rtw_dev *rtwdev);
 	void (*dynamic_rx_agg)(struct rtw_dev *rtwdev, bool enable);
+	void (*write_firmware_page)(struct rtw_dev *rtwdev, u32 page,
+				    const u8 *data, u32 size);
 
 	int (*write_data_rsvd_page)(struct rtw_dev *rtwdev, u8 *buf, u32 size);
 	int (*write_data_h2c)(struct rtw_dev *rtwdev, u8 *buf, u32 size);
@@ -79,6 +81,12 @@ static inline void rtw_hci_dynamic_rx_agg(struct rtw_dev *rtwdev, bool enable)
 		rtwdev->hci.ops->dynamic_rx_agg(rtwdev, enable);
 }
 
+static inline void rtw_hci_write_firmware_page(struct rtw_dev *rtwdev, u32 page,
+					       const u8 *data, u32 size)
+{
+	rtwdev->hci.ops->write_firmware_page(rtwdev, page, data, size);
+}
+
 static inline int
 rtw_hci_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf, u32 size)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index d1c4f5cdcb21..efb1da198e74 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -854,8 +854,8 @@ static void en_download_firmware_legacy(struct rtw_dev *rtwdev, bool en)
 	}
 }
 
-static void
-write_firmware_page(struct rtw_dev *rtwdev, u32 page, const u8 *data, u32 size)
+void rtw_write_firmware_page(struct rtw_dev *rtwdev, u32 page,
+			     const u8 *data, u32 size)
 {
 	u32 val32;
 	u32 block_nr;
@@ -885,6 +885,7 @@ write_firmware_page(struct rtw_dev *rtwdev, u32 page, const u8 *data, u32 size)
 		rtw_write32(rtwdev, write_addr, le32_to_cpu(remain_data));
 	}
 }
+EXPORT_SYMBOL(rtw_write_firmware_page);
 
 static int
 download_firmware_legacy(struct rtw_dev *rtwdev, const u8 *data, u32 size)
@@ -902,11 +903,13 @@ download_firmware_legacy(struct rtw_dev *rtwdev, const u8 *data, u32 size)
 	rtw_write8_set(rtwdev, REG_MCUFW_CTRL, BIT_FWDL_CHK_RPT);
 
 	for (page = 0; page < total_page; page++) {
-		write_firmware_page(rtwdev, page, data, DLFW_PAGE_SIZE_LEGACY);
+		rtw_hci_write_firmware_page(rtwdev, page, data,
+					    DLFW_PAGE_SIZE_LEGACY);
 		data += DLFW_PAGE_SIZE_LEGACY;
 	}
 	if (last_page_size)
-		write_firmware_page(rtwdev, page, data, last_page_size);
+		rtw_hci_write_firmware_page(rtwdev, page, data,
+					    last_page_size);
 
 	if (!check_hw_ready(rtwdev, REG_MCUFW_CTRL, BIT_FWDL_CHK_RPT, 1)) {
 		rtw_err(rtwdev, "failed to check download firmware report\n");
diff --git a/drivers/net/wireless/realtek/rtw88/mac.h b/drivers/net/wireless/realtek/rtw88/mac.h
index 58c3dccc14bb..737c6d5d8da7 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.h
+++ b/drivers/net/wireless/realtek/rtw88/mac.h
@@ -32,6 +32,8 @@ void rtw_set_channel_mac(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 			 u8 primary_ch_idx);
 int rtw_mac_power_on(struct rtw_dev *rtwdev);
 void rtw_mac_power_off(struct rtw_dev *rtwdev);
+void rtw_write_firmware_page(struct rtw_dev *rtwdev, u32 page,
+			     const u8 *data, u32 size);
 int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw);
 int rtw_mac_init(struct rtw_dev *rtwdev);
 void rtw_mac_flush_queues(struct rtw_dev *rtwdev, u32 queues, bool drop);
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 0b9b8807af2c..fab9bb9257dd 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -12,6 +12,7 @@
 #include "fw.h"
 #include "ps.h"
 #include "debug.h"
+#include "mac.h"
 
 static bool rtw_disable_msi;
 static bool rtw_pci_disable_aspm;
@@ -1602,6 +1603,7 @@ static struct rtw_hci_ops rtw_pci_ops = {
 	.link_ps = rtw_pci_link_ps,
 	.interface_cfg = rtw_pci_interface_cfg,
 	.dynamic_rx_agg = NULL,
+	.write_firmware_page = rtw_write_firmware_page,
 
 	.read8 = rtw_pci_read8,
 	.read16 = rtw_pci_read16,
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 5b8e88c9759d..787fa09fd063 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -10,6 +10,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdio_func.h>
 #include "main.h"
+#include "mac.h"
 #include "debug.h"
 #include "fw.h"
 #include "ps.h"
@@ -1155,6 +1156,7 @@ static struct rtw_hci_ops rtw_sdio_ops = {
 	.link_ps = rtw_sdio_link_ps,
 	.interface_cfg = rtw_sdio_interface_cfg,
 	.dynamic_rx_agg = NULL,
+	.write_firmware_page = rtw_write_firmware_page,
 
 	.read8 = rtw_sdio_read8,
 	.read16 = rtw_sdio_read16,
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 07695294767a..a446be45f26e 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -138,7 +138,7 @@ static void rtw_usb_write(struct rtw_dev *rtwdev, u32 addr, u32 val, int len)
 
 	ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
 			      RTW_USB_CMD_REQ, RTW_USB_CMD_WRITE,
-			      addr, 0, data, len, 30000);
+			      addr, 0, data, len, 500);
 	if (ret < 0 && ret != -ENODEV && count++ < 4)
 		rtw_err(rtwdev, "write register 0x%x failed with %d\n",
 			addr, ret);
@@ -164,6 +164,60 @@ static void rtw_usb_write32(struct rtw_dev *rtwdev, u32 addr, u32 val)
 	rtw_usb_write(rtwdev, addr, val, 4);
 }
 
+static void rtw_usb_write_firmware_page(struct rtw_dev *rtwdev, u32 page,
+					const u8 *data, u32 size)
+{
+	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
+	struct usb_device *udev = rtwusb->udev;
+	u32 addr = FW_START_ADDR_LEGACY;
+	u8 *data_dup, *buf;
+	u32 n, block_size;
+	int ret;
+
+	switch (rtwdev->chip->id) {
+	case RTW_CHIP_TYPE_8723D:
+		block_size = 254;
+		break;
+	default:
+		block_size = 196;
+		break;
+	}
+
+	data_dup = kmemdup(data, size, GFP_KERNEL);
+	if (!data_dup)
+		return;
+
+	buf = data_dup;
+
+	rtw_write32_mask(rtwdev, REG_MCUFW_CTRL, BIT_ROM_PGE, page);
+
+	while (size > 0) {
+		if (size >= block_size)
+			n = block_size;
+		else if (size >= 8)
+			n = 8;
+		else
+			n = 1;
+
+		ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+				      RTW_USB_CMD_REQ, RTW_USB_CMD_WRITE,
+				      addr, 0, buf, n, 500);
+		if (ret != n) {
+			if (ret != -ENODEV)
+				rtw_err(rtwdev,
+					"write 0x%x len %d failed: %d\n",
+					addr, n, ret);
+			break;
+		}
+
+		addr += n;
+		buf += n;
+		size -= n;
+	}
+
+	kfree(data_dup);
+}
+
 static int dma_mapping_to_ep(enum rtw_dma_mapping dma_mapping)
 {
 	switch (dma_mapping) {
@@ -815,6 +869,7 @@ static struct rtw_hci_ops rtw_usb_ops = {
 	.link_ps = rtw_usb_link_ps,
 	.interface_cfg = rtw_usb_interface_cfg,
 	.dynamic_rx_agg = rtw_usb_dynamic_rx_agg,
+	.write_firmware_page = rtw_usb_write_firmware_page,
 
 	.write8  = rtw_usb_write8,
 	.write16 = rtw_usb_write16,
diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 8d140b94cb44..0c8ea5e629e6 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -6,6 +6,7 @@
 #include "debug.h"
 #include "fw.h"
 #include "mac.h"
+#include "ps.h"
 
 static struct sk_buff *
 rtw89_cam_get_sec_key_cmd(struct rtw89_dev *rtwdev,
@@ -447,9 +448,11 @@ int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
+		rtw89_leave_ips_by_hwflags(rtwdev);
 		hw_key_type = RTW89_SEC_KEY_TYPE_WEP40;
 		break;
 	case WLAN_CIPHER_SUITE_WEP104:
+		rtw89_leave_ips_by_hwflags(rtwdev);
 		hw_key_type = RTW89_SEC_KEY_TYPE_WEP104;
 		break;
 	case WLAN_CIPHER_SUITE_CCMP:
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 9b09d4b7dea5..2188bca899e3 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5513,11 +5513,11 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	case RTW89_MAC_C2H_CLASS_FWDBG:
 		return;
 	default:
-		rtw89_info(rtwdev, "c2h class %d not support\n", class);
+		rtw89_info(rtwdev, "MAC c2h class %d not support\n", class);
 		return;
 	}
 	if (!handler) {
-		rtw89_info(rtwdev, "c2h class %d func %d not support\n", class,
+		rtw89_info(rtwdev, "MAC c2h class %d func %d not support\n", class,
 			   func);
 		return;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 5c31639b4cad..355c3f58ab18 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3062,10 +3062,16 @@ rtw89_phy_c2h_rfk_report_state(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u3
 		    (int)(len - sizeof(report->hdr)), &report->state);
 }
 
+static void
+rtw89_phy_c2h_rfk_log_tas_pwr(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
 static
 void (* const rtw89_phy_c2h_rfk_report_handler[])(struct rtw89_dev *rtwdev,
 						  struct sk_buff *c2h, u32 len) = {
 	[RTW89_PHY_C2H_RFK_REPORT_FUNC_STATE] = rtw89_phy_c2h_rfk_report_state,
+	[RTW89_PHY_C2H_RFK_LOG_TAS_PWR] = rtw89_phy_c2h_rfk_log_tas_pwr,
 };
 
 bool rtw89_phy_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func)
@@ -3119,11 +3125,11 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			return;
 		fallthrough;
 	default:
-		rtw89_info(rtwdev, "c2h class %d not support\n", class);
+		rtw89_info(rtwdev, "PHY c2h class %d not support\n", class);
 		return;
 	}
 	if (!handler) {
-		rtw89_info(rtwdev, "c2h class %d func %d not support\n", class,
+		rtw89_info(rtwdev, "PHY c2h class %d func %d not support\n", class,
 			   func);
 		return;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 9bb9c9c8e7a1..961a4bacb02a 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -151,6 +151,7 @@ enum rtw89_phy_c2h_rfk_log_func {
 
 enum rtw89_phy_c2h_rfk_report_func {
 	RTW89_PHY_C2H_RFK_REPORT_FUNC_STATE = 0,
+	RTW89_PHY_C2H_RFK_LOG_TAS_PWR = 6,
 };
 
 enum rtw89_phy_c2h_dm_func {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
index 28907df7407d..c958d6ab24d3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
@@ -77,11 +77,6 @@ void rtw8922a_ctl_band_ch_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 					     RR_CFGCH_BAND0 | RR_CFGCH_CH);
 			rf_reg[path][i] |= u32_encode_bits(central_ch, RR_CFGCH_CH);
 
-			if (band == RTW89_BAND_2G)
-				rtw89_write_rf(rtwdev, path, RR_SMD, RR_VCO2, 0x0);
-			else
-				rtw89_write_rf(rtwdev, path, RR_SMD, RR_VCO2, 0x1);
-
 			switch (band) {
 			case RTW89_BAND_2G:
 			default:
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4a2b7c9921bc..6fcc21f596ea 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1229,6 +1229,11 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
 	/* MLD not supported here */
 	u32 bcn_int = data->link_data[0].beacon_int;
 	u64 delta = abs(tsf - now);
+	struct ieee80211_bss_conf *conf;
+
+	conf = link_conf_dereference_protected(vif, data->link_data[0].link_id);
+	if (conf && !conf->enable_beacon)
+		return;
 
 	/* adjust after beaconing with new timestamp at old TBTT */
 	if (tsf > now) {
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a1b3c538a4bd..64ae8af01d9a 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -442,21 +442,14 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
 
 	/*
-	 * For iopoll, complete it directly. Note that using the uring_cmd
-	 * helper for this is safe only because we check blk_rq_is_poll().
-	 * As that returns false if we're NOT on a polled queue, then it's
-	 * safe to use the polled completion helper.
-	 *
-	 * Otherwise, move the completion to task work.
+	 * IOPOLL could potentially complete this request directly, but
+	 * if multiple rings are polling on the same queue, then it's possible
+	 * for one ring to find completions for another ring. Punting the
+	 * completion via task_work will always direct it to the right
+	 * location, rather than potentially complete requests for ringA
+	 * under iopoll invocations from ringB.
 	 */
-	if (blk_rq_is_poll(req)) {
-		if (pdu->bio)
-			blk_rq_unmap_user(pdu->bio);
-		io_uring_cmd_iopoll_done(ioucmd, pdu->result, pdu->status);
-	} else {
-		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
-	}
-
+	io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
 	return RQ_END_IO_FREE;
 }
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 0bf4cde34f51..f700e8c49082 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -292,13 +292,14 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 	struct cdns_pcie *pcie = &ep->pcie;
 	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
 	u32 val, reg;
+	u16 actual_interrupts = interrupts + 1;
 
 	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
 
 	reg = cap + PCI_MSIX_FLAGS;
 	val = cdns_pcie_ep_fn_readw(pcie, fn, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
-	val |= interrupts;
+	val |= interrupts; /* 0's based value */
 	cdns_pcie_ep_fn_writew(pcie, fn, reg, val);
 
 	/* Set MSIX BAR and offset */
@@ -308,7 +309,7 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 
 	/* Set PBA BAR and offset.  BAR must match MSIX BAR */
 	reg = cap + PCI_MSIX_PBA;
-	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = (offset + (actual_interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
 	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 9e7e94f32b43..00289948f9c1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -398,6 +398,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_pcie_ep_func *ep_func;
 	u32 val, reg;
+	u16 actual_interrupts = interrupts + 1;
 
 	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	if (!ep_func || !ep_func->msix_cap)
@@ -408,7 +409,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	reg = ep_func->msix_cap + PCI_MSIX_FLAGS;
 	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
-	val |= interrupts;
+	val |= interrupts; /* 0's based value */
 	dw_pcie_writew_dbi(pci, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
@@ -416,7 +417,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_PBA;
-	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = (offset + (actual_interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 1170e1107508..6b113a1212a9 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -44,7 +44,6 @@
 #define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
 #define PCIE_RDLH_LINK_UP_CHGED		BIT(1)
 #define PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
-#define PCIE_L0S_ENTRY			0x11
 #define PCIE_CLIENT_GENERAL_CONTROL	0x0
 #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
 #define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
@@ -177,8 +176,7 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
 	u32 val = rockchip_pcie_get_ltssm(rockchip);
 
-	if ((val & PCIE_LINKUP) == PCIE_LINKUP &&
-	    (val & PCIE_LTSSM_STATUS_MASK) == PCIE_L0S_ENTRY)
+	if ((val & PCIE_LINKUP) == PCIE_LINKUP)
 		return 1;
 
 	return 0;
@@ -379,8 +377,8 @@ static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
 
 static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
 {
-	phy_exit(rockchip->phy);
 	phy_power_off(rockchip->phy);
+	phy_exit(rockchip->phy);
 }
 
 static const struct dw_pcie_ops dw_pcie_ops = {
diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
index e9e9aaa91770..d9996516f49e 100644
--- a/drivers/pci/hotplug/s390_pci_hpc.c
+++ b/drivers/pci/hotplug/s390_pci_hpc.c
@@ -65,9 +65,9 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
 
 	rc = zpci_deconfigure_device(zdev);
 out:
-	mutex_unlock(&zdev->state_lock);
 	if (pdev)
 		pci_dev_put(pdev);
+	mutex_unlock(&zdev->state_lock);
 	return rc;
 }
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7ca5422feb2d..51a09e48967f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5643,7 +5643,8 @@ static void pci_slot_unlock(struct pci_slot *slot)
 			continue;
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 064067d9c8b5..db609d26811b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4995,6 +4995,18 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
 		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 }
 
+static int pci_quirk_loongson_acs(struct pci_dev *dev, u16 acs_flags)
+{
+	/*
+	 * Loongson PCIe Root Ports don't advertise an ACS capability, but
+	 * they do not allow peer-to-peer transactions between Root Ports.
+	 * Allow each Root Port to be in a separate IOMMU group by masking
+	 * SV/RR/CR/UF bits.
+	 */
+	return pci_acs_ctrl_enabled(acs_flags,
+		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
+}
+
 /*
  * Wangxun 40G/25G/10G/1G NICs have no ACS capability, but on
  * multi-function devices, the hardware isolates the functions by
@@ -5128,6 +5140,17 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_BROADCOM, 0x1762, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1763, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pci_quirk_brcm_acs },
+	/* Loongson PCIe Root Ports */
+	{ PCI_VENDOR_ID_LOONGSON, 0x3C09, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x3C19, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x3C29, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A09, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A19, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A29, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A39, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A49, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A59, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A69, pci_quirk_loongson_acs },
 	/* Amazon Annapurna Labs */
 	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
 	/* Zhaoxin multi-function devices */
diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index adc6394626ce..f914f016b3d2 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -95,12 +95,12 @@ static u32 phy_tx_preemp_amp_tune_from_property(u32 microamp)
 static u32 phy_tx_vboost_level_from_property(u32 microvolt)
 {
 	switch (microvolt) {
-	case 0 ... 960:
-		return 0;
-	case 961 ... 1160:
-		return 2;
-	default:
+	case 1156:
+		return 5;
+	case 844:
 		return 3;
+	default:
+		return 4;
 	}
 }
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 4ce11c74fec1..53b6eb748659 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -358,9 +358,7 @@ static int armada_37xx_pmx_set_by_name(struct pinctrl_dev *pctldev,
 
 	val = grp->val[func];
 
-	regmap_update_bits(info->regmap, reg, mask, val);
-
-	return 0;
+	return regmap_update_bits(info->regmap, reg, mask, val);
 }
 
 static int armada_37xx_pmx_set(struct pinctrl_dev *pctldev,
@@ -402,10 +400,13 @@ static int armada_37xx_gpio_get_direction(struct gpio_chip *chip,
 	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
 	unsigned int reg = OUTPUT_EN;
 	unsigned int val, mask;
+	int ret;
 
 	armada_37xx_update_reg(&reg, &offset);
 	mask = BIT(offset);
-	regmap_read(info->regmap, reg, &val);
+	ret = regmap_read(info->regmap, reg, &val);
+	if (ret)
+		return ret;
 
 	if (val & mask)
 		return GPIO_LINE_DIRECTION_OUT;
@@ -442,11 +443,14 @@ static int armada_37xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
 	unsigned int reg = INPUT_VAL;
 	unsigned int val, mask;
+	int ret;
 
 	armada_37xx_update_reg(&reg, &offset);
 	mask = BIT(offset);
 
-	regmap_read(info->regmap, reg, &val);
+	ret = regmap_read(info->regmap, reg, &val);
+	if (ret)
+		return ret;
 
 	return (val & mask) != 0;
 }
@@ -471,16 +475,17 @@ static int armada_37xx_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 {
 	struct armada_37xx_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
 	struct gpio_chip *chip = range->gc;
+	int ret;
 
 	dev_dbg(info->dev, "gpio_direction for pin %u as %s-%d to %s\n",
 		offset, range->name, offset, input ? "input" : "output");
 
 	if (input)
-		armada_37xx_gpio_direction_input(chip, offset);
+		ret = armada_37xx_gpio_direction_input(chip, offset);
 	else
-		armada_37xx_gpio_direction_output(chip, offset, 0);
+		ret = armada_37xx_gpio_direction_output(chip, offset, 0);
 
-	return 0;
+	return ret;
 }
 
 static int armada_37xx_gpio_request_enable(struct pinctrl_dev *pctldev,
diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index 70d7485ada36..60fcd53830a7 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -636,6 +636,14 @@ int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 
 	mcp->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 
+	/*
+	 * Reset the chip - we don't really know what state it's in, so reset
+	 * all pins to input first to prevent surprises.
+	 */
+	ret = mcp_write(mcp, MCP_IODIR, mcp->chip.ngpio == 16 ? 0xFFFF : 0xFF);
+	if (ret < 0)
+		return ret;
+
 	/* verify MCP_IOCON.SEQOP = 0, so sequential reads work,
 	 * and MCP_IOCON.HAEN = 1, so we work with all chips.
 	 */
diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
index 99203584949d..61b18ac206c9 100644
--- a/drivers/platform/loongarch/loongson-laptop.c
+++ b/drivers/platform/loongarch/loongson-laptop.c
@@ -56,8 +56,7 @@ static struct input_dev *generic_inputdev;
 static acpi_handle hotkey_handle;
 static struct key_entry hotkey_keycode_map[GENERIC_HOTKEY_MAP_MAX];
 
-int loongson_laptop_turn_on_backlight(void);
-int loongson_laptop_turn_off_backlight(void);
+static bool bl_powered;
 static int loongson_laptop_backlight_update(struct backlight_device *bd);
 
 /* 2. ACPI Helpers and device model */
@@ -354,16 +353,42 @@ static int ec_backlight_level(u8 level)
 	return level;
 }
 
+static int ec_backlight_set_power(bool state)
+{
+	int status;
+	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+	struct acpi_object_list args = { 1, &arg0 };
+
+	arg0.integer.value = state;
+	status = acpi_evaluate_object(NULL, "\\BLSW", &args, NULL);
+	if (ACPI_FAILURE(status)) {
+		pr_info("Loongson lvds error: 0x%x\n", status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int loongson_laptop_backlight_update(struct backlight_device *bd)
 {
-	int lvl = ec_backlight_level(bd->props.brightness);
+	bool target_powered = !backlight_is_blank(bd);
+	int ret = 0, lvl = ec_backlight_level(bd->props.brightness);
 
 	if (lvl < 0)
 		return -EIO;
+
 	if (ec_set_brightness(lvl))
 		return -EIO;
 
-	return 0;
+	if (target_powered != bl_powered) {
+		ret = ec_backlight_set_power(target_powered);
+		if (ret < 0)
+			return ret;
+
+		bl_powered = target_powered;
+	}
+
+	return ret;
 }
 
 static int loongson_laptop_get_brightness(struct backlight_device *bd)
@@ -384,7 +409,7 @@ static const struct backlight_ops backlight_laptop_ops = {
 
 static int laptop_backlight_register(void)
 {
-	int status = 0;
+	int status = 0, ret;
 	struct backlight_properties props;
 
 	memset(&props, 0, sizeof(props));
@@ -392,44 +417,20 @@ static int laptop_backlight_register(void)
 	if (!acpi_evalf(hotkey_handle, &status, "ECLL", "d"))
 		return -EIO;
 
-	props.brightness = 1;
+	ret = ec_backlight_set_power(true);
+	if (ret)
+		return ret;
+
+	bl_powered = true;
+
 	props.max_brightness = status;
+	props.brightness = ec_get_brightness();
+	props.power = BACKLIGHT_POWER_ON;
 	props.type = BACKLIGHT_PLATFORM;
 
 	backlight_device_register("loongson_laptop",
 				NULL, NULL, &backlight_laptop_ops, &props);
 
-	return 0;
-}
-
-int loongson_laptop_turn_on_backlight(void)
-{
-	int status;
-	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
-	struct acpi_object_list args = { 1, &arg0 };
-
-	arg0.integer.value = 1;
-	status = acpi_evaluate_object(NULL, "\\BLSW", &args, NULL);
-	if (ACPI_FAILURE(status)) {
-		pr_info("Loongson lvds error: 0x%x\n", status);
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-int loongson_laptop_turn_off_backlight(void)
-{
-	int status;
-	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
-	struct acpi_object_list args = { 1, &arg0 };
-
-	arg0.integer.value = 0;
-	status = acpi_evaluate_object(NULL, "\\BLSW", &args, NULL);
-	if (ACPI_FAILURE(status)) {
-		pr_info("Loongson lvds error: 0x%x\n", status);
-		return -ENODEV;
-	}
 
 	return 0;
 }
@@ -611,11 +612,17 @@ static int __init generic_acpi_laptop_init(void)
 
 static void __exit generic_acpi_laptop_exit(void)
 {
+	int i;
+
 	if (generic_inputdev) {
-		if (input_device_registered)
-			input_unregister_device(generic_inputdev);
-		else
+		if (!input_device_registered) {
 			input_free_device(generic_inputdev);
+		} else {
+			input_unregister_device(generic_inputdev);
+
+			for (i = 0; i < ARRAY_SIZE(generic_sub_drivers); i++)
+				generic_subdriver_exit(&generic_sub_drivers[i]);
+		}
 	}
 }
 
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index dc071b4257d7..357a46fdffed 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -393,6 +393,8 @@ static int amd_pmc_setup_smu_logging(struct amd_pmc_dev *dev)
 			return -ENOMEM;
 	}
 
+	memset_io(dev->smu_virt_addr, 0, sizeof(struct smu_metrics));
+
 	/* Start the logging */
 	amd_pmc_send_cmd(dev, 0, NULL, SMU_MSG_LOG_RESET, false);
 	amd_pmc_send_cmd(dev, 0, NULL, SMU_MSG_LOG_START, false);
diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index b6bcc1d57f96..a9b195ec6f33 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -422,12 +422,12 @@ static int amd_pmf_ta_open_session(struct tee_context *ctx, u32 *id, const uuid_
 	rc = tee_client_open_session(ctx, &sess_arg, NULL);
 	if (rc < 0 || sess_arg.ret != 0) {
 		pr_err("Failed to open TEE session err:%#x, rc:%d\n", sess_arg.ret, rc);
-		return rc;
+		return rc ?: -EINVAL;
 	}
 
 	*id = sess_arg.session;
 
-	return rc;
+	return 0;
 }
 
 static int amd_pmf_register_input_device(struct amd_pmf_dev *dev)
@@ -462,7 +462,9 @@ static int amd_pmf_tee_init(struct amd_pmf_dev *dev, const uuid_t *uuid)
 	dev->tee_ctx = tee_client_open_context(NULL, amd_pmf_amdtee_ta_match, NULL, NULL);
 	if (IS_ERR(dev->tee_ctx)) {
 		dev_err(dev->dev, "Failed to open TEE context\n");
-		return PTR_ERR(dev->tee_ctx);
+		ret = PTR_ERR(dev->tee_ctx);
+		dev->tee_ctx = NULL;
+		return ret;
 	}
 
 	ret = amd_pmf_ta_open_session(dev->tee_ctx, &dev->session_id, uuid);
@@ -502,9 +504,12 @@ static int amd_pmf_tee_init(struct amd_pmf_dev *dev, const uuid_t *uuid)
 
 static void amd_pmf_tee_deinit(struct amd_pmf_dev *dev)
 {
+	if (!dev->tee_ctx)
+		return;
 	tee_shm_free(dev->fw_shm_pool);
 	tee_client_close_session(dev->tee_ctx, dev->session_id);
 	tee_client_close_context(dev->tee_ctx);
+	dev->tee_ctx = NULL;
 }
 
 int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
diff --git a/drivers/platform/x86/dell/dell_rbu.c b/drivers/platform/x86/dell/dell_rbu.c
index 9f51e0fcab04..fee20866b41e 100644
--- a/drivers/platform/x86/dell/dell_rbu.c
+++ b/drivers/platform/x86/dell/dell_rbu.c
@@ -292,7 +292,7 @@ static int packet_read_list(char *data, size_t * pread_length)
 	remaining_bytes = *pread_length;
 	bytes_read = rbu_data.packet_read_count;
 
-	list_for_each_entry(newpacket, (&packet_data_head.list)->next, list) {
+	list_for_each_entry(newpacket, &packet_data_head.list, list) {
 		bytes_copied = do_packet_read(pdest, newpacket,
 			remaining_bytes, bytes_read, &temp_count);
 		remaining_bytes -= bytes_copied;
@@ -315,14 +315,14 @@ static void packet_empty_list(void)
 {
 	struct packet_data *newpacket, *tmp;
 
-	list_for_each_entry_safe(newpacket, tmp, (&packet_data_head.list)->next, list) {
+	list_for_each_entry_safe(newpacket, tmp, &packet_data_head.list, list) {
 		list_del(&newpacket->list);
 
 		/*
 		 * zero out the RBU packet memory before freeing
 		 * to make sure there are no stale RBU packets left in memory
 		 */
-		memset(newpacket->data, 0, rbu_data.packetsize);
+		memset(newpacket->data, 0, newpacket->length);
 		set_memory_wb((unsigned long)newpacket->data,
 			1 << newpacket->ordernum);
 		free_pages((unsigned long) newpacket->data,
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index bdb4cbee4205..93aa72bff3f0 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -15,6 +15,7 @@
 #include <linux/bug.h>
 #include <linux/cleanup.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/i8042.h>
@@ -267,6 +268,20 @@ static void ideapad_shared_exit(struct ideapad_private *priv)
  */
 #define IDEAPAD_EC_TIMEOUT 200 /* in ms */
 
+/*
+ * Some models (e.g., ThinkBook since 2024) have a low tolerance for being
+ * polled too frequently. Doing so may break the state machine in the EC,
+ * resulting in a hard shutdown.
+ *
+ * It is also observed that frequent polls may disturb the ongoing operation
+ * and notably delay the availability of EC response.
+ *
+ * These values are used as the delay before the first poll and the interval
+ * between subsequent polls to solve the above issues.
+ */
+#define IDEAPAD_EC_POLL_MIN_US 150
+#define IDEAPAD_EC_POLL_MAX_US 300
+
 static int eval_int(acpi_handle handle, const char *name, unsigned long *res)
 {
 	unsigned long long result;
@@ -383,7 +398,7 @@ static int read_ec_data(acpi_handle handle, unsigned long cmd, unsigned long *da
 	end_jiffies = jiffies + msecs_to_jiffies(IDEAPAD_EC_TIMEOUT) + 1;
 
 	while (time_before(jiffies, end_jiffies)) {
-		schedule();
+		usleep_range(IDEAPAD_EC_POLL_MIN_US, IDEAPAD_EC_POLL_MAX_US);
 
 		err = eval_vpcr(handle, 1, &val);
 		if (err)
@@ -414,7 +429,7 @@ static int write_ec_cmd(acpi_handle handle, unsigned long cmd, unsigned long dat
 	end_jiffies = jiffies + msecs_to_jiffies(IDEAPAD_EC_TIMEOUT) + 1;
 
 	while (time_before(jiffies, end_jiffies)) {
-		schedule();
+		usleep_range(IDEAPAD_EC_POLL_MIN_US, IDEAPAD_EC_POLL_MAX_US);
 
 		err = eval_vpcr(handle, 1, &val);
 		if (err)
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index 0591053813a2..5ab45b751666 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -467,10 +467,13 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 
 	/* Get the package ID from the TPMI core */
 	plat_info = tpmi_get_platform_data(auxdev);
-	if (plat_info)
-		pkg = plat_info->package_id;
-	else
+	if (unlikely(!plat_info)) {
 		dev_info(&auxdev->dev, "Platform information is NULL\n");
+		ret = -ENODEV;
+		goto err_rem_common;
+	}
+
+	pkg = plat_info->package_id;
 
 	for (i = 0; i < num_resources; ++i) {
 		struct tpmi_uncore_power_domain_info *pd_info;
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 8b1f894f5e79..2643525a572b 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2228,8 +2228,10 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 	return 0;
 put:
 	put_device(&genpd->dev);
-	if (genpd->free_states == genpd_free_default_power_state)
+	if (genpd->free_states == genpd_free_default_power_state) {
 		kfree(genpd->states);
+		genpd->states = NULL;
+	}
 free:
 	if (genpd_is_cpu_domain(genpd))
 		free_cpumask_var(genpd->cpus);
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 1a20c775489c..871f03d160c5 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2062,7 +2062,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	mutex_unlock(&di->lock);
 
 	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
-		return -ENODEV;
+		return di->cache.flags;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index ba0d22d90429..868e95f0887e 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -6,6 +6,7 @@
  *	Andrew F. Davis <afd@ti.com>
  */
 
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -31,6 +32,7 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	struct i2c_msg msg[2];
 	u8 data[2];
 	int ret;
+	int retry = 0;
 
 	if (!client->adapter)
 		return -ENODEV;
@@ -47,7 +49,16 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	else
 		msg[1].len = 2;
 
-	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	do {
+		ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+		if (ret == -EBUSY && ++retry < 3) {
+			/* sleep 10 milliseconds when busy */
+			usleep_range(10000, 11000);
+			continue;
+		}
+		break;
+	} while (1);
+
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/power/supply/collie_battery.c b/drivers/power/supply/collie_battery.c
index 68390bd1004f..3daf7befc0bf 100644
--- a/drivers/power/supply/collie_battery.c
+++ b/drivers/power/supply/collie_battery.c
@@ -440,6 +440,7 @@ static int collie_bat_probe(struct ucb1x00_dev *dev)
 
 static void collie_bat_remove(struct ucb1x00_dev *dev)
 {
+	device_init_wakeup(&ucb->dev, 0);
 	free_irq(gpiod_to_irq(collie_bat_main.gpio_full), &collie_bat_main);
 	power_supply_unregister(collie_bat_bu.psy);
 	power_supply_unregister(collie_bat_main.psy);
diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 51310f6e4803..c1640bc6accd 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -410,8 +410,9 @@ static int max17040_get_property(struct power_supply *psy,
 		if (!chip->channel_temp)
 			return -ENODATA;
 
-		iio_read_channel_processed_scale(chip->channel_temp,
-						 &val->intval, 10);
+		iio_read_channel_processed(chip->channel_temp, &val->intval);
+		val->intval /= 100; /* Convert from milli- to deci-degree */
+
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 1a1edd87122d..b892a7323084 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -121,7 +121,8 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 	struct ptp_clock_info *ops;
 	int err = -EOPNOTSUPP;
 
-	if (ptp_clock_freerun(ptp)) {
+	if (tx->modes & (ADJ_SETOFFSET | ADJ_FREQUENCY | ADJ_OFFSET) &&
+	    ptp_clock_freerun(ptp)) {
 		pr_err("ptp: physical clock is free running\n");
 		return -EBUSY;
 	}
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 528d86a33f37..a6aad743c282 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -98,7 +98,27 @@ static inline int queue_cnt(const struct timestamp_event_queue *q)
 /* Check if ptp virtual clock is in use */
 static inline bool ptp_vclock_in_use(struct ptp_clock *ptp)
 {
-	return !ptp->is_virtual_clock;
+	bool in_use = false;
+
+	/* Virtual clocks can't be stacked on top of virtual clocks.
+	 * Avoid acquiring the n_vclocks_mux on virtual clocks, to allow this
+	 * function to be called from code paths where the n_vclocks_mux of the
+	 * parent physical clock is already held. Functionally that's not an
+	 * issue, but lockdep would complain, because they have the same lock
+	 * class.
+	 */
+	if (ptp->is_virtual_clock)
+		return false;
+
+	if (mutex_lock_interruptible(&ptp->n_vclocks_mux))
+		return true;
+
+	if (ptp->n_vclocks)
+		in_use = true;
+
+	mutex_unlock(&ptp->n_vclocks_mux);
+
+	return in_use;
 }
 
 /* Check if ptp clock shall be free running */
diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index b5477659ba18..73c68f494e7f 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -174,7 +174,7 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct pwm_chip *chip;
 	struct axi_pwmgen_ddata *ddata;
-	struct clk *clk;
+	struct clk *axi_clk, *clk;
 	void __iomem *io_base;
 	int ret;
 
@@ -197,9 +197,26 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
 	ddata = pwmchip_get_drvdata(chip);
 	ddata->regmap = regmap;
 
-	clk = devm_clk_get_enabled(dev, NULL);
+	/*
+	 * Using NULL here instead of "axi" for backwards compatibility. There
+	 * are some dtbs that don't give clock-names and have the "ext" clock
+	 * as the one and only clock (due to mistake in the original bindings).
+	 */
+	axi_clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(axi_clk))
+		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to get axi clock\n");
+
+	clk = devm_clk_get_optional_enabled(dev, "ext");
 	if (IS_ERR(clk))
-		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get ext clock\n");
+
+	/*
+	 * If there is no "ext" clock, it means the HDL was compiled with
+	 * ASYNC_CLK_EN=0. In this case, the AXI clock is also used for the
+	 * PWM output clock.
+	 */
+	if (!clk)
+		clk = axi_clk;
 
 	ret = devm_clk_rate_exclusive_get(dev, clk);
 	if (ret)
diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index 9135227301c8..e548edf64eca 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -789,6 +789,9 @@ static int riocm_ch_send(u16 ch_id, void *buf, int len)
 	if (buf == NULL || ch_id == 0 || len == 0 || len > RIO_MAX_MSG_SIZE)
 		return -EINVAL;
 
+	if (len < sizeof(struct rio_ch_chan_hdr))
+		return -EINVAL;		/* insufficient data from user */
+
 	ch = riocm_get_channel(ch_id);
 	if (!ch) {
 		riocm_error("%s(%d) ch_%d not found", current->comm,
diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index 5e7171b9065a..41fd15adfd1f 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -40,11 +40,14 @@ static int max14577_reg_get_current_limit(struct regulator_dev *rdev)
 	struct max14577 *max14577 = rdev_get_drvdata(rdev);
 	const struct maxim_charger_current *limits =
 		&maxim_charger_currents[max14577->dev_type];
+	int ret;
 
 	if (rdev_get_id(rdev) != MAX14577_CHARGER)
 		return -EINVAL;
 
-	max14577_read_reg(rmap, MAX14577_CHG_REG_CHG_CTRL4, &reg_data);
+	ret = max14577_read_reg(rmap, MAX14577_CHG_REG_CHG_CTRL4, &reg_data);
+	if (ret < 0)
+		return ret;
 
 	if ((reg_data & CHGCTRL4_MBCICHWRCL_MASK) == 0)
 		return limits->min;
diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
index 3d333b61fb18..fcdd2d0317a5 100644
--- a/drivers/regulator/max20086-regulator.c
+++ b/drivers/regulator/max20086-regulator.c
@@ -29,7 +29,7 @@
 #define	MAX20086_REG_ADC4		0x09
 
 /* DEVICE IDs */
-#define MAX20086_DEVICE_ID_MAX20086	0x40
+#define MAX20086_DEVICE_ID_MAX20086	0x30
 #define MAX20086_DEVICE_ID_MAX20087	0x20
 #define MAX20086_DEVICE_ID_MAX20088	0x10
 #define MAX20086_DEVICE_ID_MAX20089	0x00
@@ -264,7 +264,7 @@ static int max20086_i2c_probe(struct i2c_client *i2c)
 	 * shutdown.
 	 */
 	flags = boot_on ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
-	chip->ena_gpiod = devm_gpiod_get(chip->dev, "enable", flags);
+	chip->ena_gpiod = devm_gpiod_get_optional(chip->dev, "enable", flags);
 	if (IS_ERR(chip->ena_gpiod)) {
 		ret = PTR_ERR(chip->ena_gpiod);
 		dev_err(chip->dev, "Failed to get enable GPIO: %d\n", ret);
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index d2308c2f97eb..b7011eb384a5 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1617,7 +1617,7 @@ static int rproc_attach(struct rproc *rproc)
 	ret = rproc_set_rsc_table(rproc);
 	if (ret) {
 		dev_err(dev, "can't load resource table: %d\n", ret);
-		goto unprepare_device;
+		goto clean_up_resources;
 	}
 
 	/* reset max_notifyid */
@@ -1634,7 +1634,7 @@ static int rproc_attach(struct rproc *rproc)
 	ret = rproc_handle_resources(rproc, rproc_loading_handlers);
 	if (ret) {
 		dev_err(dev, "Failed to process resources: %d\n", ret);
-		goto unprepare_device;
+		goto clean_up_resources;
 	}
 
 	/* Allocate carveout resources associated to rproc */
@@ -1653,9 +1653,9 @@ static int rproc_attach(struct rproc *rproc)
 
 clean_up_resources:
 	rproc_resource_cleanup(rproc);
-unprepare_device:
 	/* release HW resources if needed */
 	rproc_unprepare_device(rproc);
+	kfree(rproc->clean_table);
 disable_iommu:
 	rproc_disable_iommu(rproc);
 	return ret;
diff --git a/drivers/remoteproc/ti_k3_m4_remoteproc.c b/drivers/remoteproc/ti_k3_m4_remoteproc.c
index 09f0484a90e1..fba6e393635e 100644
--- a/drivers/remoteproc/ti_k3_m4_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_m4_remoteproc.c
@@ -228,7 +228,7 @@ static int k3_m4_rproc_unprepare(struct rproc *rproc)
 	int ret;
 
 	/* If the core is going to be detached do not assert the module reset */
-	if (rproc->state == RPROC_ATTACHED)
+	if (rproc->state == RPROC_DETACHED)
 		return 0;
 
 	ret = kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
diff --git a/drivers/s390/scsi/zfcp_sysfs.c b/drivers/s390/scsi/zfcp_sysfs.c
index cb67fa80fb12..a95da6768f66 100644
--- a/drivers/s390/scsi/zfcp_sysfs.c
+++ b/drivers/s390/scsi/zfcp_sysfs.c
@@ -450,6 +450,8 @@ static ssize_t zfcp_sysfs_unit_add_store(struct device *dev,
 	if (kstrtoull(buf, 0, (unsigned long long *) &fcp_lun))
 		return -EINVAL;
 
+	flush_work(&port->rport_work);
+
 	retval = zfcp_unit_add(port, fcp_lun);
 	if (retval)
 		return retval;
diff --git a/drivers/scsi/elx/efct/efct_hw.c b/drivers/scsi/elx/efct/efct_hw.c
index 5a5525054d71..5b079b8b7a08 100644
--- a/drivers/scsi/elx/efct/efct_hw.c
+++ b/drivers/scsi/elx/efct/efct_hw.c
@@ -1120,7 +1120,7 @@ int
 efct_hw_parse_filter(struct efct_hw *hw, void *value)
 {
 	int rc = 0;
-	char *p = NULL;
+	char *p = NULL, *pp = NULL;
 	char *token;
 	u32 idx = 0;
 
@@ -1132,6 +1132,7 @@ efct_hw_parse_filter(struct efct_hw *hw, void *value)
 		efc_log_err(hw->os, "p is NULL\n");
 		return -ENOMEM;
 	}
+	pp = p;
 
 	idx = 0;
 	while ((token = strsep(&p, ",")) && *token) {
@@ -1144,7 +1145,7 @@ efct_hw_parse_filter(struct efct_hw *hw, void *value)
 		if (idx == ARRAY_SIZE(hw->config.filter_def))
 			break;
 	}
-	kfree(p);
+	kfree(pp);
 
 	return rc;
 }
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index f2e4237ff3d9..34f77b250387 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -5082,7 +5082,7 @@ lpfc_check_sli_ndlp(struct lpfc_hba *phba,
 		case CMD_GEN_REQUEST64_CR:
 			if (iocb->ndlp == ndlp)
 				return 1;
-			fallthrough;
+			break;
 		case CMD_ELS_REQUEST64_CR:
 			if (remote_id == ndlp->nlp_DID)
 				return 1;
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 6748fba48a07..4dccbaeb6328 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -6020,9 +6020,9 @@ lpfc_sli4_get_ctl_attr(struct lpfc_hba *phba)
 	phba->sli4_hba.flash_id = bf_get(lpfc_cntl_attr_flash_id, cntl_attr);
 	phba->sli4_hba.asic_rev = bf_get(lpfc_cntl_attr_asic_rev, cntl_attr);
 
-	memset(phba->BIOSVersion, 0, sizeof(phba->BIOSVersion));
-	strlcat(phba->BIOSVersion, (char *)cntl_attr->bios_ver_str,
+	memcpy(phba->BIOSVersion, cntl_attr->bios_ver_str,
 		sizeof(phba->BIOSVersion));
+	phba->BIOSVersion[sizeof(phba->BIOSVersion) - 1] = '\0';
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
 			"3086 lnk_type:%d, lnk_numb:%d, bios_ver:%s, "
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 8cc9f924a8ae..c5a21e369e16 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -9708,6 +9708,10 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1bd4, 0x0089)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+				0x1bd4, 0x00a3)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1ff9, 0x00a1)
@@ -10044,6 +10048,30 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_VENDOR_ID_ADAPTEC2, 0x14f0)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x207d, 0x4044)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x207d, 0x4054)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x207d, 0x4084)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x207d, 0x4094)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x207d, 0x4140)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x207d, 0x4240)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_VENDOR_ID_ADVANTECH, 0x8312)
@@ -10260,6 +10288,14 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1cc4, 0x0201)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1018, 0x8238)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1f3f, 0x0610)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_VENDOR_ID_LENOVO, 0x0220)
@@ -10268,10 +10304,30 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_VENDOR_ID_LENOVO, 0x0221)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0222)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0223)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0224)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0225)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_VENDOR_ID_LENOVO, 0x0520)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0521)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_VENDOR_ID_LENOVO, 0x0522)
@@ -10292,6 +10348,26 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_VENDOR_ID_LENOVO, 0x0623)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0624)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0625)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0626)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0627)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0628)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 				0x1014, 0x0718)
@@ -10320,6 +10396,10 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1137, 0x0300)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+				0x1ded, 0x3301)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1ff9, 0x0045)
@@ -10468,6 +10548,10 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 				0x1f51, 0x100a)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+				0x1f51, 0x100b)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1f51, 0x100e)
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 48b0ca92b44f..954a1cc50ba7 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -362,7 +362,7 @@ MODULE_PARM_DESC(ring_avail_percent_lowater,
 /*
  * Timeout in seconds for all devices managed by this driver.
  */
-static int storvsc_timeout = 180;
+static const int storvsc_timeout = 180;
 
 #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
 static struct scsi_transport_template *fc_transport_template;
@@ -768,7 +768,7 @@ static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
 		return;
 	}
 
-	t = wait_for_completion_timeout(&request->wait_event, 10*HZ);
+	t = wait_for_completion_timeout(&request->wait_event, storvsc_timeout * HZ);
 	if (t == 0) {
 		dev_err(dev, "Failed to create sub-channel: timed out\n");
 		return;
@@ -833,7 +833,7 @@ static int storvsc_execute_vstor_op(struct hv_device *device,
 	if (ret != 0)
 		return ret;
 
-	t = wait_for_completion_timeout(&request->wait_event, 5*HZ);
+	t = wait_for_completion_timeout(&request->wait_event, storvsc_timeout * HZ);
 	if (t == 0)
 		return -ETIMEDOUT;
 
@@ -1351,6 +1351,8 @@ static int storvsc_connect_to_vsp(struct hv_device *device, u32 ring_size,
 		return ret;
 
 	ret = storvsc_channel_init(device, is_fc);
+	if (ret)
+		vmbus_close(device->channel);
 
 	return ret;
 }
@@ -1668,7 +1670,7 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
 	if (ret != 0)
 		return FAILED;
 
-	t = wait_for_completion_timeout(&request->wait_event, 5*HZ);
+	t = wait_for_completion_timeout(&request->wait_event, storvsc_timeout * HZ);
 	if (t == 0)
 		return TIMEOUT_ERROR;
 
diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 463b1c528831..db25f406878b 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -219,21 +219,29 @@ static void pmic_glink_altmode_worker(struct work_struct *work)
 {
 	struct pmic_glink_altmode_port *alt_port = work_to_altmode_port(work);
 	struct pmic_glink_altmode *altmode = alt_port->altmode;
+	enum drm_connector_status conn_status;
 
 	typec_switch_set(alt_port->typec_switch, alt_port->orientation);
 
-	if (alt_port->svid == USB_TYPEC_DP_SID && alt_port->mode == 0xff)
-		pmic_glink_altmode_safe(altmode, alt_port);
-	else if (alt_port->svid == USB_TYPEC_DP_SID)
-		pmic_glink_altmode_enable_dp(altmode, alt_port, alt_port->mode,
-					     alt_port->hpd_state, alt_port->hpd_irq);
-	else
-		pmic_glink_altmode_enable_usb(altmode, alt_port);
+	if (alt_port->svid == USB_TYPEC_DP_SID) {
+		if (alt_port->mode == 0xff) {
+			pmic_glink_altmode_safe(altmode, alt_port);
+		} else {
+			pmic_glink_altmode_enable_dp(altmode, alt_port,
+						     alt_port->mode,
+						     alt_port->hpd_state,
+						     alt_port->hpd_irq);
+		}
 
-	drm_aux_hpd_bridge_notify(&alt_port->bridge->dev,
-				  alt_port->hpd_state ?
-				  connector_status_connected :
-				  connector_status_disconnected);
+		if (alt_port->hpd_state)
+			conn_status = connector_status_connected;
+		else
+			conn_status = connector_status_disconnected;
+
+		drm_aux_hpd_bridge_notify(&alt_port->bridge->dev, conn_status);
+	} else {
+		pmic_glink_altmode_enable_usb(altmode, alt_port);
+	}
 
 	pmic_glink_altmode_request(altmode, ALTMODE_PAN_ACK, alt_port->index);
 }
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 4ae1a7039418..1f806ee966c3 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -411,7 +411,7 @@ static ssize_t ad5933_store(struct device *dev,
 		ret = ad5933_cmd(st, 0);
 		break;
 	case AD5933_OUT_SETTLING_CYCLES:
-		val = clamp(val, (u16)0, (u16)0x7FF);
+		val = clamp(val, (u16)0, (u16)0x7FC);
 		st->settling_cycles = val;
 
 		/* 2x, 4x handling, see datasheet */
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index d113679b1e2d..acc7998758ad 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/tee_core.h>
 #include <linux/uaccess.h>
@@ -19,7 +20,7 @@
 
 #define TEE_NUM_DEVICES	32
 
-#define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
+#define TEE_IOCTL_PARAM_SIZE(x) (size_mul(sizeof(struct tee_param), (x)))
 
 #define TEE_UUID_NS_NAME_SIZE	128
 
@@ -487,7 +488,7 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
 	if (copy_from_user(&arg, uarg, sizeof(arg)))
 		return -EFAULT;
 
-	if (sizeof(arg) + TEE_IOCTL_PARAM_SIZE(arg.num_params) != buf.buf_len)
+	if (size_add(sizeof(arg), TEE_IOCTL_PARAM_SIZE(arg.num_params)) != buf.buf_len)
 		return -EINVAL;
 
 	if (arg.num_params) {
@@ -565,7 +566,7 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
 	if (copy_from_user(&arg, uarg, sizeof(arg)))
 		return -EFAULT;
 
-	if (sizeof(arg) + TEE_IOCTL_PARAM_SIZE(arg.num_params) != buf.buf_len)
+	if (size_add(sizeof(arg), TEE_IOCTL_PARAM_SIZE(arg.num_params)) != buf.buf_len)
 		return -EINVAL;
 
 	if (arg.num_params) {
@@ -699,7 +700,7 @@ static int tee_ioctl_supp_recv(struct tee_context *ctx,
 	if (get_user(num_params, &uarg->num_params))
 		return -EFAULT;
 
-	if (sizeof(*uarg) + TEE_IOCTL_PARAM_SIZE(num_params) != buf.buf_len)
+	if (size_add(sizeof(*uarg), TEE_IOCTL_PARAM_SIZE(num_params)) != buf.buf_len)
 		return -EINVAL;
 
 	params = kcalloc(num_params, sizeof(struct tee_param), GFP_KERNEL);
@@ -798,7 +799,7 @@ static int tee_ioctl_supp_send(struct tee_context *ctx,
 	    get_user(num_params, &uarg->num_params))
 		return -EFAULT;
 
-	if (sizeof(*uarg) + TEE_IOCTL_PARAM_SIZE(num_params) > buf.buf_len)
+	if (size_add(sizeof(*uarg), TEE_IOCTL_PARAM_SIZE(num_params)) > buf.buf_len)
 		return -EINVAL;
 
 	params = kcalloc(num_params, sizeof(struct tee_param), GFP_KERNEL);
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index aacbed76c7c5..53236e3e4fa4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -183,6 +183,7 @@ static struct sci_port sci_ports[SCI_NPORTS];
 static unsigned long sci_ports_in_use;
 static struct uart_driver sci_uart_driver;
 static bool sci_uart_earlycon;
+static bool sci_uart_earlycon_dev_probing;
 
 static inline struct sci_port *
 to_sci_port(struct uart_port *uart)
@@ -3404,7 +3405,8 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 static int sci_probe_single(struct platform_device *dev,
 				      unsigned int index,
 				      struct plat_sci_port *p,
-				      struct sci_port *sciport)
+				      struct sci_port *sciport,
+				      struct resource *sci_res)
 {
 	int ret;
 
@@ -3451,6 +3453,30 @@ static int sci_probe_single(struct platform_device *dev,
 		sciport->port.flags |= UPF_HARD_FLOW;
 	}
 
+	if (sci_uart_earlycon && sci_ports[0].port.mapbase == sci_res->start) {
+		/*
+		 * In case:
+		 * - this is the earlycon port (mapped on index 0 in sci_ports[]) and
+		 * - it now maps to an alias other than zero and
+		 * - the earlycon is still alive (e.g., "earlycon keep_bootcon" is
+		 *   available in bootargs)
+		 *
+		 * we need to avoid disabling clocks and PM domains through the runtime
+		 * PM APIs called in __device_attach(). For this, increment the runtime
+		 * PM reference counter (the clocks and PM domains were already enabled
+		 * by the bootloader). Otherwise the earlycon may access the HW when it
+		 * has no clocks enabled leading to failures (infinite loop in
+		 * sci_poll_put_char()).
+		 */
+		pm_runtime_get_noresume(&dev->dev);
+
+		/*
+		 * Skip cleanup the sci_port[0] in early_console_exit(), this
+		 * port is the same as the earlycon one.
+		 */
+		sci_uart_earlycon_dev_probing = true;
+	}
+
 	return uart_add_one_port(&sci_uart_driver, &sciport->port);
 }
 
@@ -3509,7 +3535,7 @@ static int sci_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, sp);
 
-	ret = sci_probe_single(dev, dev_id, p, sp);
+	ret = sci_probe_single(dev, dev_id, p, sp, res);
 	if (ret)
 		return ret;
 
@@ -3666,6 +3692,22 @@ sh_early_platform_init_buffer("earlyprintk", &sci_driver,
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
 static struct plat_sci_port port_cfg;
 
+static int early_console_exit(struct console *co)
+{
+	struct sci_port *sci_port = &sci_ports[0];
+
+	/*
+	 * Clean the slot used by earlycon. A new SCI device might
+	 * map to this slot.
+	 */
+	if (!sci_uart_earlycon_dev_probing) {
+		memset(sci_port, 0, sizeof(*sci_port));
+		sci_uart_earlycon = false;
+	}
+
+	return 0;
+}
+
 static int __init early_console_setup(struct earlycon_device *device,
 				      int type)
 {
@@ -3683,6 +3725,8 @@ static int __init early_console_setup(struct earlycon_device *device,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
 
 	device->con->write = serial_console_write;
+	device->con->exit = early_console_exit;
+
 	return 0;
 }
 static int __init sci_early_console_setup(struct earlycon_device *device,
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index c2759bbeed84..a6551a795f74 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -243,6 +243,9 @@ hv_uio_probe(struct hv_device *dev,
 	if (!ring_size)
 		ring_size = SZ_2M;
 
+	/* Adjust ring size if necessary to have it page aligned */
+	ring_size = VMBUS_RING_SIZE(ring_size);
+
 	pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
@@ -274,13 +277,13 @@ hv_uio_probe(struct hv_device *dev,
 	pdata->info.mem[INT_PAGE_MAP].name = "int_page";
 	pdata->info.mem[INT_PAGE_MAP].addr
 		= (uintptr_t)vmbus_connection.int_page;
-	pdata->info.mem[INT_PAGE_MAP].size = PAGE_SIZE;
+	pdata->info.mem[INT_PAGE_MAP].size = HV_HYP_PAGE_SIZE;
 	pdata->info.mem[INT_PAGE_MAP].memtype = UIO_MEM_LOGICAL;
 
 	pdata->info.mem[MON_PAGE_MAP].name = "monitor_page";
 	pdata->info.mem[MON_PAGE_MAP].addr
 		= (uintptr_t)vmbus_connection.monitor_pages[1];
-	pdata->info.mem[MON_PAGE_MAP].size = PAGE_SIZE;
+	pdata->info.mem[MON_PAGE_MAP].size = HV_HYP_PAGE_SIZE;
 	pdata->info.mem[MON_PAGE_MAP].memtype = UIO_MEM_LOGICAL;
 
 	pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 139049368fdc..7d02470f19b9 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -85,6 +85,15 @@ static bool dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
 	/* Redraw, so that we get putc(s) for output done while blanked */
 	return true;
 }
+
+static bool dummycon_switch(struct vc_data *vc)
+{
+	/*
+	 * Redraw, so that we get putc(s) for output done while switched
+	 * away. Informs deferred consoles to take over the display.
+	 */
+	return true;
+}
 #else
 static void dummycon_putc(struct vc_data *vc, u16 c, unsigned int y,
 			  unsigned int x) { }
@@ -95,6 +104,10 @@ static bool dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
 {
 	return false;
 }
+static bool dummycon_switch(struct vc_data *vc)
+{
+	return false;
+}
 #endif
 
 static const char *dummycon_startup(void)
@@ -124,11 +137,6 @@ static bool dummycon_scroll(struct vc_data *vc, unsigned int top,
 	return false;
 }
 
-static bool dummycon_switch(struct vc_data *vc)
-{
-	return false;
-}
-
 /*
  *  The console `switch' structure for the dummy console
  *
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 37bd18730fe0..f9cdbf8c53e3 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1168,7 +1168,7 @@ static bool vgacon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
 				     c->vc_screenbuf_size - delta);
 			c->vc_origin = vga_vram_end - c->vc_screenbuf_size;
 			vga_rolled_over = 0;
-		} else
+		} else if (oldo - delta >= (unsigned long)c->vc_screenbuf)
 			c->vc_origin -= delta;
 		c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
 		scr_memsetw((u16 *) (c->vc_origin), c->vc_video_erase_char,
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 07d127110ca4..c98786996c64 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -117,9 +117,14 @@ static signed char con2fb_map_boot[MAX_NR_CONSOLES];
 
 static struct fb_info *fbcon_info_from_console(int console)
 {
+	signed char fb;
 	WARN_CONSOLE_UNLOCKED();
 
-	return fbcon_registered_fb[con2fb_map[console]];
+	fb = con2fb_map[console];
+	if (fb < 0 || fb >= ARRAY_SIZE(fbcon_registered_fb))
+		return NULL;
+
+	return fbcon_registered_fb[fb];
 }
 
 static int logo_lines;
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 3c568cff2913..eca2498f2436 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -328,8 +328,10 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 	    !list_empty(&info->modelist))
 		ret = fb_add_videomode(&mode, &info->modelist);
 
-	if (ret)
+	if (ret) {
+		info->var = old_var;
 		return ret;
+	}
 
 	event.info = info;
 	event.data = &mode;
@@ -388,7 +390,7 @@ static int fb_check_foreignness(struct fb_info *fi)
 
 static int do_register_framebuffer(struct fb_info *fb_info)
 {
-	int i;
+	int i, err = 0;
 	struct fb_videomode mode;
 
 	if (fb_check_foreignness(fb_info))
@@ -397,10 +399,18 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	if (num_registered_fb == FB_MAX)
 		return -ENXIO;
 
-	num_registered_fb++;
 	for (i = 0 ; i < FB_MAX; i++)
 		if (!registered_fb[i])
 			break;
+
+	if (!fb_info->modelist.prev || !fb_info->modelist.next)
+		INIT_LIST_HEAD(&fb_info->modelist);
+
+	fb_var_to_videomode(&mode, &fb_info->var);
+	err = fb_add_videomode(&mode, &fb_info->modelist);
+	if (err < 0)
+		return err;
+
 	fb_info->node = i;
 	refcount_set(&fb_info->count, 1);
 	mutex_init(&fb_info->lock);
@@ -426,16 +436,12 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	if (bitmap_empty(fb_info->pixmap.blit_y, FB_MAX_BLIT_HEIGHT))
 		bitmap_fill(fb_info->pixmap.blit_y, FB_MAX_BLIT_HEIGHT);
 
-	if (!fb_info->modelist.prev || !fb_info->modelist.next)
-		INIT_LIST_HEAD(&fb_info->modelist);
-
 	if (fb_info->skip_vt_switch)
 		pm_vt_switch_required(fb_info->device, false);
 	else
 		pm_vt_switch_required(fb_info->device, true);
 
-	fb_var_to_videomode(&mode, &fb_info->var);
-	fb_add_videomode(&mode, &fb_info->modelist);
+	num_registered_fb++;
 	registered_fb[i] = fb_info;
 
 #ifdef CONFIG_GUMSTIX_AM200EPD
diff --git a/drivers/video/screen_info_pci.c b/drivers/video/screen_info_pci.c
index 6c5833517141..66bfc1d0a6dc 100644
--- a/drivers/video/screen_info_pci.c
+++ b/drivers/video/screen_info_pci.c
@@ -7,8 +7,8 @@
 
 static struct pci_dev *screen_info_lfb_pdev;
 static size_t screen_info_lfb_bar;
-static resource_size_t screen_info_lfb_offset;
-static struct resource screen_info_lfb_res = DEFINE_RES_MEM(0, 0);
+static resource_size_t screen_info_lfb_res_start; // original start of resource
+static resource_size_t screen_info_lfb_offset; // framebuffer offset within resource
 
 static bool __screen_info_relocation_is_valid(const struct screen_info *si, struct resource *pr)
 {
@@ -31,7 +31,7 @@ void screen_info_apply_fixups(void)
 	if (screen_info_lfb_pdev) {
 		struct resource *pr = &screen_info_lfb_pdev->resource[screen_info_lfb_bar];
 
-		if (pr->start != screen_info_lfb_res.start) {
+		if (pr->start != screen_info_lfb_res_start) {
 			if (__screen_info_relocation_is_valid(si, pr)) {
 				/*
 				 * Only update base if we have an actual
@@ -47,46 +47,67 @@ void screen_info_apply_fixups(void)
 	}
 }
 
+static int __screen_info_lfb_pci_bus_region(const struct screen_info *si, unsigned int type,
+					    struct pci_bus_region *r)
+{
+	u64 base, size;
+
+	base = __screen_info_lfb_base(si);
+	if (!base)
+		return -EINVAL;
+
+	size = __screen_info_lfb_size(si, type);
+	if (!size)
+		return -EINVAL;
+
+	r->start = base;
+	r->end = base + size - 1;
+
+	return 0;
+}
+
 static void screen_info_fixup_lfb(struct pci_dev *pdev)
 {
 	unsigned int type;
-	struct resource res[SCREEN_INFO_MAX_RESOURCES];
-	size_t i, numres;
+	struct pci_bus_region bus_region;
 	int ret;
+	struct resource r = {
+		.flags = IORESOURCE_MEM,
+	};
+	const struct resource *pr;
 	const struct screen_info *si = &screen_info;
 
 	if (screen_info_lfb_pdev)
 		return; // already found
 
 	type = screen_info_video_type(si);
-	if (type != VIDEO_TYPE_EFI)
-		return; // only applies to EFI
+	if (!__screen_info_has_lfb(type))
+		return; // only applies to EFI; maybe VESA
 
-	ret = screen_info_resources(si, res, ARRAY_SIZE(res));
+	ret = __screen_info_lfb_pci_bus_region(si, type, &bus_region);
 	if (ret < 0)
 		return;
-	numres = ret;
 
-	for (i = 0; i < numres; ++i) {
-		struct resource *r = &res[i];
-		const struct resource *pr;
-
-		if (!(r->flags & IORESOURCE_MEM))
-			continue;
-		pr = pci_find_resource(pdev, r);
-		if (!pr)
-			continue;
-
-		/*
-		 * We've found a PCI device with the framebuffer
-		 * resource. Store away the parameters to track
-		 * relocation of the framebuffer aperture.
-		 */
-		screen_info_lfb_pdev = pdev;
-		screen_info_lfb_bar = pr - pdev->resource;
-		screen_info_lfb_offset = r->start - pr->start;
-		memcpy(&screen_info_lfb_res, r, sizeof(screen_info_lfb_res));
-	}
+	/*
+	 * Translate the PCI bus address to resource. Account
+	 * for an offset if the framebuffer is behind a PCI host
+	 * bridge.
+	 */
+	pcibios_bus_to_resource(pdev->bus, &r, &bus_region);
+
+	pr = pci_find_resource(pdev, &r);
+	if (!pr)
+		return;
+
+	/*
+	 * We've found a PCI device with the framebuffer
+	 * resource. Store away the parameters to track
+	 * relocation of the framebuffer aperture.
+	 */
+	screen_info_lfb_pdev = pdev;
+	screen_info_lfb_bar = pr - pdev->resource;
+	screen_info_lfb_offset = r.start - pr->start;
+	screen_info_lfb_res_start = bus_region.start;
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY, 16,
 			       screen_info_fixup_lfb);
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index 9432d4e303f1..8a638bc34d4a 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -15,6 +15,7 @@
 static struct tsm_provider {
 	const struct tsm_ops *ops;
 	void *data;
+	atomic_t count;
 } provider;
 static DECLARE_RWSEM(tsm_rwsem);
 
@@ -92,6 +93,10 @@ static ssize_t tsm_report_privlevel_store(struct config_item *cfg,
 	if (rc)
 		return rc;
 
+	guard(rwsem_write)(&tsm_rwsem);
+	if (!provider.ops)
+		return -ENXIO;
+
 	/*
 	 * The valid privilege levels that a TSM might accept, if it accepts a
 	 * privilege level setting at all, are a max of TSM_PRIVLEVEL_MAX (see
@@ -101,7 +106,6 @@ static ssize_t tsm_report_privlevel_store(struct config_item *cfg,
 	if (provider.ops->privlevel_floor > val || val > TSM_PRIVLEVEL_MAX)
 		return -EINVAL;
 
-	guard(rwsem_write)(&tsm_rwsem);
 	rc = try_advance_write_generation(report);
 	if (rc)
 		return rc;
@@ -115,6 +119,10 @@ static ssize_t tsm_report_privlevel_floor_show(struct config_item *cfg,
 					       char *buf)
 {
 	guard(rwsem_read)(&tsm_rwsem);
+
+	if (!provider.ops)
+		return -ENXIO;
+
 	return sysfs_emit(buf, "%u\n", provider.ops->privlevel_floor);
 }
 CONFIGFS_ATTR_RO(tsm_report_, privlevel_floor);
@@ -217,6 +225,9 @@ CONFIGFS_ATTR_RO(tsm_report_, generation);
 static ssize_t tsm_report_provider_show(struct config_item *cfg, char *buf)
 {
 	guard(rwsem_read)(&tsm_rwsem);
+	if (!provider.ops)
+		return -ENXIO;
+
 	return sysfs_emit(buf, "%s\n", provider.ops->name);
 }
 CONFIGFS_ATTR_RO(tsm_report_, provider);
@@ -284,7 +295,7 @@ static ssize_t tsm_report_read(struct tsm_report *report, void *buf,
 	guard(rwsem_write)(&tsm_rwsem);
 	ops = provider.ops;
 	if (!ops)
-		return -ENOTTY;
+		return -ENXIO;
 	if (!report->desc.inblob_len)
 		return -EINVAL;
 
@@ -421,12 +432,20 @@ static struct config_item *tsm_report_make_item(struct config_group *group,
 	if (!state)
 		return ERR_PTR(-ENOMEM);
 
+	atomic_inc(&provider.count);
 	config_item_init_type_name(&state->cfg, name, &tsm_report_type);
 	return &state->cfg;
 }
 
+static void tsm_report_drop_item(struct config_group *group, struct config_item *item)
+{
+	config_item_put(item);
+	atomic_dec(&provider.count);
+}
+
 static struct configfs_group_operations tsm_report_group_ops = {
 	.make_item = tsm_report_make_item,
+	.drop_item = tsm_report_drop_item,
 };
 
 static const struct config_item_type tsm_reports_type = {
@@ -459,6 +478,11 @@ int tsm_register(const struct tsm_ops *ops, void *priv)
 		return -EBUSY;
 	}
 
+	if (atomic_read(&provider.count)) {
+		pr_err("configfs/tsm/report not empty\n");
+		return -EBUSY;
+	}
+
 	provider.ops = ops;
 	provider.data = priv;
 	return 0;
@@ -470,6 +494,9 @@ int tsm_unregister(const struct tsm_ops *ops)
 	guard(rwsem_write)(&tsm_rwsem);
 	if (ops != provider.ops)
 		return -EBUSY;
+	if (atomic_read(&provider.count))
+		pr_warn("\"%s\" unregistered with items present in configfs/tsm/report\n",
+			provider.ops->name);
 	provider.ops = NULL;
 	provider.data = NULL;
 	return 0;
diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index d708c091bf1b..180526220d8c 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -164,6 +164,7 @@ static int da9052_wdt_probe(struct platform_device *pdev)
 	da9052_wdt = &driver_data->wdt;
 
 	da9052_wdt->timeout = DA9052_DEF_TIMEOUT;
+	da9052_wdt->min_hw_heartbeat_ms = DA9052_TWDMIN;
 	da9052_wdt->info = &da9052_wdt_info;
 	da9052_wdt->ops = &da9052_wdt_ops;
 	da9052_wdt->parent = dev;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index c2a9e2cc03de..6828a2cff02c 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -396,6 +396,15 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		struct page **pages;
 		size_t page_off;
 
+		/*
+		 * FIXME: io_iter.count needs to be corrected to aligned
+		 * length. Otherwise, iov_iter_get_pages_alloc2() operates
+		 * with the initial unaligned length value. As a result,
+		 * ceph_msg_data_cursor_init() triggers BUG_ON() in the case
+		 * if msg->sparse_read_total > msg->data_length.
+		 */
+		subreq->io_iter.count = len;
+
 		err = iov_iter_get_pages_alloc2(&subreq->io_iter, &pages, len, &page_off);
 		if (err < 0) {
 			doutc(cl, "%llx.%llx failed to allocate pages, %d\n",
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index c235f9a60394..b61074b377ac 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1227,6 +1227,7 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	s->s_time_min = 0;
 	s->s_time_max = U32_MAX;
 	s->s_flags |= SB_NODIRATIME | SB_NOATIME;
+	s->s_magic = CEPH_SUPER_MAGIC;
 
 	ceph_fscrypt_set_ops(s);
 
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 43d6bde1adcc..e5b6a427f31c 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -600,7 +600,7 @@ static int populate_attrs(struct config_item *item)
 				break;
 		}
 	}
-	if (t->ct_bin_attrs) {
+	if (!error && t->ct_bin_attrs) {
 		for (i = 0; (bin_attr = t->ct_bin_attrs[i]) != NULL; i++) {
 			if (ops && ops->is_bin_visible && !ops->is_bin_visible(item, bin_attr, i))
 				continue;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c2e6989a568c..e94df69ee2e0 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3369,6 +3369,13 @@ static inline unsigned int ext4_flex_bg_size(struct ext4_sb_info *sbi)
 	return 1 << sbi->s_log_groups_per_flex;
 }
 
+static inline loff_t ext4_get_maxbytes(struct inode *inode)
+{
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		return inode->i_sb->s_maxbytes;
+	return EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
+}
+
 #define ext4_std_error(sb, errno)				\
 do {								\
 	if ((errno))						\
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ba3419958a83..b16d72275e10 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2396,18 +2396,19 @@ int ext4_ext_calc_credits_for_single_extent(struct inode *inode, int nrblocks,
 int ext4_ext_index_trans_blocks(struct inode *inode, int extents)
 {
 	int index;
-	int depth;
 
 	/* If we are converting the inline data, only one is needed here. */
 	if (ext4_has_inline_data(inode))
 		return 1;
 
-	depth = ext_depth(inode);
-
+	/*
+	 * Extent tree can change between the time we estimate credits and
+	 * the time we actually modify the tree. Assume the worst case.
+	 */
 	if (extents <= 1)
-		index = depth * 2;
+		index = EXT4_MAX_EXTENT_DEPTH * 2;
 	else
-		index = depth * 3;
+		index = EXT4_MAX_EXTENT_DEPTH * 3;
 
 	return index;
 }
@@ -4976,12 +4977,7 @@ static const struct iomap_ops ext4_iomap_xattr_ops = {
 
 static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
 {
-	u64 maxbytes;
-
-	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		maxbytes = inode->i_sb->s_maxbytes;
-	else
-		maxbytes = EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
+	u64 maxbytes = ext4_get_maxbytes(inode);
 
 	if (*len == 0)
 		return -EINVAL;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index f14aed14b9cf..6c692151b0d6 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -896,12 +896,7 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
 loff_t ext4_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
-	loff_t maxbytes;
-
-	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
-		maxbytes = EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
-	else
-		maxbytes = inode->i_sb->s_maxbytes;
+	loff_t maxbytes = ext4_get_maxbytes(inode);
 
 	switch (whence) {
 	default:
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..05b148d6fc71 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -392,7 +392,7 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 }
 
 static int ext4_prepare_inline_data(handle_t *handle, struct inode *inode,
-				    unsigned int len)
+				    loff_t len)
 {
 	int ret, size, no_expand;
 	struct ext4_inode_info *ei = EXT4_I(inode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 38fe9a213d09..f769f5cb6deb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1000,7 +1000,12 @@ int ext4_walk_page_buffers(handle_t *handle, struct inode *inode,
  */
 static int ext4_dirty_journalled_data(handle_t *handle, struct buffer_head *bh)
 {
-	folio_mark_dirty(bh->b_folio);
+	struct folio *folio = bh->b_folio;
+	struct inode *inode = folio->mapping->host;
+
+	/* only regular files have a_ops */
+	if (S_ISREG(inode->i_mode))
+		folio_mark_dirty(folio);
 	return ext4_handle_dirty_metadata(handle, NULL, bh);
 }
 
@@ -4928,7 +4933,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		ei->i_file_acl |=
 			((__u64)le16_to_cpu(raw_inode->i_file_acl_high)) << 32;
 	inode->i_size = ext4_isize(sb, raw_inode);
-	if ((size = i_size_read(inode)) < 0) {
+	size = i_size_read(inode);
+	if (size < 0 || size > ext4_get_maxbytes(inode)) {
 		ext4_error_inode(inode, function, line, 0,
 				 "iget: bad i_size value: %lld", size);
 		ret = -EFSCORRUPTED;
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 7f26440e8595..b05bb7bfa14c 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -178,8 +178,7 @@ void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct folio *folio)
 #ifdef CONFIG_F2FS_FS_LZO
 static int lzo_init_compress_ctx(struct compress_ctx *cc)
 {
-	cc->private = f2fs_kvmalloc(F2FS_I_SB(cc->inode),
-				LZO1X_MEM_COMPRESS, GFP_NOFS);
+	cc->private = f2fs_vmalloc(LZO1X_MEM_COMPRESS);
 	if (!cc->private)
 		return -ENOMEM;
 
@@ -189,7 +188,7 @@ static int lzo_init_compress_ctx(struct compress_ctx *cc)
 
 static void lzo_destroy_compress_ctx(struct compress_ctx *cc)
 {
-	kvfree(cc->private);
+	vfree(cc->private);
 	cc->private = NULL;
 }
 
@@ -246,7 +245,7 @@ static int lz4_init_compress_ctx(struct compress_ctx *cc)
 		size = LZ4HC_MEM_COMPRESS;
 #endif
 
-	cc->private = f2fs_kvmalloc(F2FS_I_SB(cc->inode), size, GFP_NOFS);
+	cc->private = f2fs_vmalloc(size);
 	if (!cc->private)
 		return -ENOMEM;
 
@@ -261,7 +260,7 @@ static int lz4_init_compress_ctx(struct compress_ctx *cc)
 
 static void lz4_destroy_compress_ctx(struct compress_ctx *cc)
 {
-	kvfree(cc->private);
+	vfree(cc->private);
 	cc->private = NULL;
 }
 
@@ -342,8 +341,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
 	params = zstd_get_params(level, cc->rlen);
 	workspace_size = zstd_cstream_workspace_bound(&params.cParams);
 
-	workspace = f2fs_kvmalloc(F2FS_I_SB(cc->inode),
-					workspace_size, GFP_NOFS);
+	workspace = f2fs_vmalloc(workspace_size);
 	if (!workspace)
 		return -ENOMEM;
 
@@ -351,7 +349,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
 	if (!stream) {
 		f2fs_err_ratelimited(F2FS_I_SB(cc->inode),
 				"%s zstd_init_cstream failed", __func__);
-		kvfree(workspace);
+		vfree(workspace);
 		return -EIO;
 	}
 
@@ -364,7 +362,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
 
 static void zstd_destroy_compress_ctx(struct compress_ctx *cc)
 {
-	kvfree(cc->private);
+	vfree(cc->private);
 	cc->private = NULL;
 	cc->private2 = NULL;
 }
@@ -423,8 +421,7 @@ static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
 
 	workspace_size = zstd_dstream_workspace_bound(max_window_size);
 
-	workspace = f2fs_kvmalloc(F2FS_I_SB(dic->inode),
-					workspace_size, GFP_NOFS);
+	workspace = f2fs_vmalloc(workspace_size);
 	if (!workspace)
 		return -ENOMEM;
 
@@ -432,7 +429,7 @@ static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
 	if (!stream) {
 		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
 				"%s zstd_init_dstream failed", __func__);
-		kvfree(workspace);
+		vfree(workspace);
 		return -EIO;
 	}
 
@@ -444,7 +441,7 @@ static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
 
 static void zstd_destroy_decompress_ctx(struct decompress_io_ctx *dic)
 {
-	kvfree(dic->private);
+	vfree(dic->private);
 	dic->private = NULL;
 	dic->private2 = NULL;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1219e37fa7ad..61b715cc2e23 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3494,6 +3494,11 @@ static inline void *f2fs_kvzalloc(struct f2fs_sb_info *sbi,
 	return f2fs_kvmalloc(sbi, size, flags | __GFP_ZERO);
 }
 
+static inline void *f2fs_vmalloc(size_t size)
+{
+	return vmalloc(size);
+}
+
 static inline int get_extra_isize(struct inode *inode)
 {
 	return F2FS_I(inode)->i_extra_isize / sizeof(__le32);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 1061991434b1..06688b9957c8 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -34,7 +34,9 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 	if (f2fs_inode_dirtied(inode, sync))
 		return;
 
-	if (f2fs_is_atomic_file(inode))
+	/* only atomic file w/ FI_ATOMIC_COMMITTED can be set vfs dirty */
+	if (f2fs_is_atomic_file(inode) &&
+			!is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
 		return;
 
 	mark_inode_dirty_sync(inode);
@@ -286,6 +288,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
+	if (ino_of_node(node_page) == fi->i_xattr_nid) {
+		f2fs_warn(sbi, "%s: corrupted inode i_ino=%lx, xnid=%x, run fsck to fix.",
+			  __func__, inode->i_ino, fi->i_xattr_nid);
+		return false;
+	}
+
 	if (f2fs_has_extra_attr(inode)) {
 		if (!f2fs_sb_has_extra_attr(sbi)) {
 			f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 6f70f377f121..781b872fac8c 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -560,6 +560,15 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 		goto fail;
 	}
 
+	if (unlikely(inode->i_nlink == 0)) {
+		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
+			  __func__, inode->i_ino);
+		err = -EFSCORRUPTED;
+		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
+		f2fs_put_page(page, 0);
+		goto fail;
+	}
+
 	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b9ffb2ee9548..449c0acbfabc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -370,7 +370,13 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
 	} else {
 		sbi->committed_atomic_block += fi->atomic_write_cnt;
 		set_inode_flag(inode, FI_ATOMIC_COMMITTED);
+
+		/*
+		 * inode may has no FI_ATOMIC_DIRTIED flag due to no write
+		 * before commit.
+		 */
 		if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
+			/* clear atomic dirty status and set vfs dirty status */
 			clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
 			f2fs_mark_inode_dirty_sync(inode, true);
 		}
@@ -2772,7 +2778,11 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 	}
 got_it:
 	/* set it as dirty segment in free segmap */
-	f2fs_bug_on(sbi, test_bit(segno, free_i->free_segmap));
+	if (test_bit(segno, free_i->free_segmap)) {
+		ret = -EFSCORRUPTED;
+		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_CORRUPTED_FREE_BITMAP);
+		goto out_unlock;
+	}
 
 	/* no free section in conventional zone */
 	if (new_sec && pinning &&
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index faa76531246e..330f89ddb5c8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1516,7 +1516,9 @@ int f2fs_inode_dirtied(struct inode *inode, bool sync)
 	}
 	spin_unlock(&sbi->inode_lock[DIRTY_META]);
 
-	if (!ret && f2fs_is_atomic_file(inode))
+	/* if atomic write is not committed, set inode w/ atomic dirty */
+	if (!ret && f2fs_is_atomic_file(inode) &&
+			!is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
 		set_inode_flag(inode, FI_ATOMIC_DIRTIED);
 
 	return ret;
@@ -3659,6 +3661,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	block_t user_block_count, valid_user_blocks;
 	block_t avail_node_count, valid_node_count;
 	unsigned int nat_blocks, nat_bits_bytes, nat_bits_blocks;
+	unsigned int sit_blk_cnt;
 	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
@@ -3770,6 +3773,13 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		return 1;
 	}
 
+	sit_blk_cnt = DIV_ROUND_UP(main_segs, SIT_ENTRY_PER_BLOCK);
+	if (sit_bitmap_size * 8 < sit_blk_cnt) {
+		f2fs_err(sbi, "Wrong bitmap size: sit: %u, sit_blk_cnt:%u",
+			 sit_bitmap_size, sit_blk_cnt);
+		return 1;
+	}
+
 	cp_pack_start_sum = __start_sum_addr(sbi);
 	cp_payload = __cp_payload(sbi);
 	if (cp_pack_start_sum < cp_payload + 1 ||
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index fa5134df985f..9e27dd8bef88 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -975,14 +975,15 @@ static int control_mount(struct gfs2_sbd *sdp)
 		if (sdp->sd_args.ar_spectator) {
 			fs_info(sdp, "Recovery is required. Waiting for a "
 				"non-spectator to mount.\n");
+			spin_unlock(&ls->ls_recover_spin);
 			msleep_interruptible(1000);
 		} else {
 			fs_info(sdp, "control_mount wait1 block %u start %u "
 				"mount %u lvb %u flags %lx\n", block_gen,
 				start_gen, mount_gen, lvb_gen,
 				ls->ls_recover_flags);
+			spin_unlock(&ls->ls_recover_spin);
 		}
-		spin_unlock(&ls->ls_recover_spin);
 		goto restart;
 	}
 
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 47038e660812..d5da9817df9b 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1275,6 +1275,7 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 	unsigned long offset;
 	struct iso_inode_info *ei = ISOFS_I(inode);
 	int ret = -EIO;
+	struct timespec64 ts;
 
 	block = ei->i_iget5_block;
 	bh = sb_bread(inode->i_sb, block);
@@ -1387,8 +1388,10 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 			inode->i_ino, de->flags[-high_sierra]);
 	}
 #endif
-	inode_set_mtime_to_ts(inode,
-			      inode_set_atime_to_ts(inode, inode_set_ctime(inode, iso_date(de->date, high_sierra), 0)));
+	ts = iso_date(de->date, high_sierra ? ISO_DATE_HIGH_SIERRA : 0);
+	inode_set_ctime_to_ts(inode, ts);
+	inode_set_atime_to_ts(inode, ts);
+	inode_set_mtime_to_ts(inode, ts);
 
 	ei->i_first_extent = (isonum_733(de->extent) +
 			isonum_711(de->ext_attr_length));
diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
index 2d55207c9a99..506555837533 100644
--- a/fs/isofs/isofs.h
+++ b/fs/isofs/isofs.h
@@ -106,7 +106,9 @@ static inline unsigned int isonum_733(u8 *p)
 	/* Ignore bigendian datum due to broken mastering programs */
 	return get_unaligned_le32(p);
 }
-extern int iso_date(u8 *, int);
+#define ISO_DATE_HIGH_SIERRA (1 << 0)
+#define ISO_DATE_LONG_FORM (1 << 1)
+struct timespec64 iso_date(u8 *p, int flags);
 
 struct inode;		/* To make gcc happy */
 
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index dbf911126e61..576498245b9d 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -412,7 +412,12 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 				}
 			}
 			break;
-		case SIG('T', 'F'):
+		case SIG('T', 'F'): {
+			int flags, size, slen;
+
+			flags = rr->u.TF.flags & TF_LONG_FORM ? ISO_DATE_LONG_FORM : 0;
+			size = rr->u.TF.flags & TF_LONG_FORM ? 17 : 7;
+			slen = rr->len - 5;
 			/*
 			 * Some RRIP writers incorrectly place ctime in the
 			 * TF_CREATE field. Try to handle this correctly for
@@ -420,27 +425,28 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 			 */
 			/* Rock ridge never appears on a High Sierra disk */
 			cnt = 0;
-			if (rr->u.TF.flags & TF_CREATE) {
-				inode_set_ctime(inode,
-						iso_date(rr->u.TF.times[cnt++].time, 0),
-						0);
+			if ((rr->u.TF.flags & TF_CREATE) && size <= slen) {
+				inode_set_ctime_to_ts(inode,
+						iso_date(rr->u.TF.data + size * cnt++, flags));
+				slen -= size;
 			}
-			if (rr->u.TF.flags & TF_MODIFY) {
-				inode_set_mtime(inode,
-						iso_date(rr->u.TF.times[cnt++].time, 0),
-						0);
+			if ((rr->u.TF.flags & TF_MODIFY) && size <= slen) {
+				inode_set_mtime_to_ts(inode,
+						iso_date(rr->u.TF.data + size * cnt++, flags));
+				slen -= size;
 			}
-			if (rr->u.TF.flags & TF_ACCESS) {
-				inode_set_atime(inode,
-						iso_date(rr->u.TF.times[cnt++].time, 0),
-						0);
+			if ((rr->u.TF.flags & TF_ACCESS) && size <= slen) {
+				inode_set_atime_to_ts(inode,
+						iso_date(rr->u.TF.data + size * cnt++, flags));
+				slen -= size;
 			}
-			if (rr->u.TF.flags & TF_ATTRIBUTES) {
-				inode_set_ctime(inode,
-						iso_date(rr->u.TF.times[cnt++].time, 0),
-						0);
+			if ((rr->u.TF.flags & TF_ATTRIBUTES) && size <= slen) {
+				inode_set_ctime_to_ts(inode,
+						iso_date(rr->u.TF.data + size * cnt++, flags));
+				slen -= size;
 			}
 			break;
+		}
 		case SIG('S', 'L'):
 			{
 				int slen;
diff --git a/fs/isofs/rock.h b/fs/isofs/rock.h
index 7755e587f778..c0856fa9bb6a 100644
--- a/fs/isofs/rock.h
+++ b/fs/isofs/rock.h
@@ -65,13 +65,9 @@ struct RR_PL_s {
 	__u8 location[8];
 };
 
-struct stamp {
-	__u8 time[7];		/* actually 6 unsigned, 1 signed */
-} __attribute__ ((packed));
-
 struct RR_TF_s {
 	__u8 flags;
-	struct stamp times[];	/* Variable number of these beasts */
+	__u8 data[];
 } __attribute__ ((packed));
 
 /* Linux-specific extension for transparent decompression */
diff --git a/fs/isofs/util.c b/fs/isofs/util.c
index e88dba721661..42f479da0b28 100644
--- a/fs/isofs/util.c
+++ b/fs/isofs/util.c
@@ -16,29 +16,44 @@
  * to GMT.  Thus  we should always be correct.
  */
 
-int iso_date(u8 *p, int flag)
+struct timespec64 iso_date(u8 *p, int flags)
 {
 	int year, month, day, hour, minute, second, tz;
-	int crtime;
+	struct timespec64 ts;
+
+	if (flags & ISO_DATE_LONG_FORM) {
+		year = (p[0] - '0') * 1000 +
+		       (p[1] - '0') * 100 +
+		       (p[2] - '0') * 10 +
+		       (p[3] - '0') - 1900;
+		month = ((p[4] - '0') * 10 + (p[5] - '0'));
+		day = ((p[6] - '0') * 10 + (p[7] - '0'));
+		hour = ((p[8] - '0') * 10 + (p[9] - '0'));
+		minute = ((p[10] - '0') * 10 + (p[11] - '0'));
+		second = ((p[12] - '0') * 10 + (p[13] - '0'));
+		ts.tv_nsec = ((p[14] - '0') * 10 + (p[15] - '0')) * 10000000;
+		tz = p[16];
+	} else {
+		year = p[0];
+		month = p[1];
+		day = p[2];
+		hour = p[3];
+		minute = p[4];
+		second = p[5];
+		ts.tv_nsec = 0;
+		/* High sierra has no time zone */
+		tz = flags & ISO_DATE_HIGH_SIERRA ? 0 : p[6];
+	}
 
-	year = p[0];
-	month = p[1];
-	day = p[2];
-	hour = p[3];
-	minute = p[4];
-	second = p[5];
-	if (flag == 0) tz = p[6]; /* High sierra has no time zone */
-	else tz = 0;
-	
 	if (year < 0) {
-		crtime = 0;
+		ts.tv_sec = 0;
 	} else {
-		crtime = mktime64(year+1900, month, day, hour, minute, second);
+		ts.tv_sec = mktime64(year+1900, month, day, hour, minute, second);
 
 		/* sign extend */
 		if (tz & 0x80)
 			tz |= (-1 << 8);
-		
+
 		/* 
 		 * The timezone offset is unreliable on some disks,
 		 * so we make a sanity check.  In no case is it ever
@@ -65,7 +80,7 @@ int iso_date(u8 *p, int flag)
 		 * for pointing out the sign error.
 		 */
 		if (-52 <= tz && tz <= 52)
-			crtime -= tz * 15 * 60;
+			ts.tv_sec -= tz * 15 * 60;
 	}
-	return crtime;
-}		
+	return ts;
+}
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 66513c18ca29..f440110df93a 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1513,7 +1513,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 				jh->b_next_transaction == transaction);
 		spin_unlock(&jh->b_state_lock);
 	}
-	if (jh->b_modified == 1) {
+	if (data_race(jh->b_modified == 1)) {
 		/* If it's in our transaction it must be in BJ_Metadata list. */
 		if (data_race(jh->b_transaction == transaction &&
 		    jh->b_jlist != BJ_Metadata)) {
@@ -1532,7 +1532,6 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		goto out;
 	}
 
-	journal = transaction->t_journal;
 	spin_lock(&jh->b_state_lock);
 
 	if (is_handle_aborted(handle)) {
@@ -1547,6 +1546,8 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		goto out_unlock_bh;
 	}
 
+	journal = transaction->t_journal;
+
 	if (jh->b_modified == 0) {
 		/*
 		 * This buffer's got modified and becoming part
diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index ef3a1e1b6cb0..fda9f4d6093f 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -425,7 +425,9 @@ static void jffs2_mark_erased_block(struct jffs2_sb_info *c, struct jffs2_eraseb
 			.totlen =	cpu_to_je32(c->cleanmarker_size)
 		};
 
-		jffs2_prealloc_raw_node_refs(c, jeb, 1);
+		ret = jffs2_prealloc_raw_node_refs(c, jeb, 1);
+		if (ret)
+			goto filebad;
 
 		marker.hdr_crc = cpu_to_je32(crc32(0, &marker, sizeof(struct jffs2_unknown_node)-4));
 
diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 29671e33a171..62879c218d4b 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -256,7 +256,9 @@ int jffs2_scan_medium(struct jffs2_sb_info *c)
 
 		jffs2_dbg(1, "%s(): Skipping %d bytes in nextblock to ensure page alignment\n",
 			  __func__, skip);
-		jffs2_prealloc_raw_node_refs(c, c->nextblock, 1);
+		ret = jffs2_prealloc_raw_node_refs(c, c->nextblock, 1);
+		if (ret)
+			goto out;
 		jffs2_scan_dirty_space(c, c->nextblock, skip);
 	}
 #endif
diff --git a/fs/jffs2/summary.c b/fs/jffs2/summary.c
index 4fe64519870f..d83372d3e1a0 100644
--- a/fs/jffs2/summary.c
+++ b/fs/jffs2/summary.c
@@ -858,7 +858,10 @@ int jffs2_sum_write_sumnode(struct jffs2_sb_info *c)
 	spin_unlock(&c->erase_completion_lock);
 
 	jeb = c->nextblock;
-	jffs2_prealloc_raw_node_refs(c, jeb, 1);
+	ret = jffs2_prealloc_raw_node_refs(c, jeb, 1);
+
+	if (ret)
+		goto out;
 
 	if (!c->summary->sum_num || !c->summary->sum_list_head) {
 		JFFS2_WARNING("Empty summary info!!!\n");
@@ -872,6 +875,8 @@ int jffs2_sum_write_sumnode(struct jffs2_sb_info *c)
 	datasize += padsize;
 
 	ret = jffs2_sum_write_data(c, jeb, infosize, datasize, padsize);
+
+out:
 	spin_lock(&c->erase_completion_lock);
 	return ret;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 11f2b5cb3b06..57d49e874f51 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3957,8 +3957,9 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		     FATTR4_WORD0_CASE_INSENSITIVE |
 		     FATTR4_WORD0_CASE_PRESERVING;
 	if (minorversion)
-		bitmask[2] = FATTR4_WORD2_SUPPATTR_EXCLCREAT |
-			     FATTR4_WORD2_OPEN_ARGUMENTS;
+		bitmask[2] = FATTR4_WORD2_SUPPATTR_EXCLCREAT;
+	if (minorversion > 1)
+		bitmask[2] |= FATTR4_WORD2_OPEN_ARGUMENTS;
 
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 	if (status == 0) {
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 81bd1b9aba17..3c1fa320b3f1 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -56,7 +56,8 @@ static int nfs_return_empty_folio(struct folio *folio)
 {
 	folio_zero_segment(folio, 0, folio_size(folio));
 	folio_mark_uptodate(folio);
-	folio_unlock(folio);
+	if (nfs_netfs_folio_unlock(folio))
+		folio_unlock(folio);
 	return 0;
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7a1fdafa42ea..02c9f3b312a0 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3658,7 +3658,8 @@ bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
 	struct nfs4_op_map *allow = &cstate->clp->cl_spo_must_allow;
 	u32 opiter;
 
-	if (!cstate->minorversion)
+	if (rqstp->rq_procinfo != &nfsd_version4.vs_proc[NFSPROC4_COMPOUND] ||
+	    cstate->minorversion == 0)
 		return false;
 
 	if (cstate->spo_must_allowed)
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2fc1919dd3c0..6edeb3bdf81b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3382,6 +3382,23 @@ static __be32 nfsd4_encode_fattr4_suppattr_exclcreat(struct xdr_stream *xdr,
 	return nfsd4_encode_bitmap4(xdr, supp[0], supp[1], supp[2]);
 }
 
+/*
+ * Copied from generic_remap_checks/generic_remap_file_range_prep.
+ *
+ * These generic functions use the file system's s_blocksize, but
+ * individual file systems aren't required to use
+ * generic_remap_file_range_prep. Until there is a mechanism for
+ * determining a particular file system's (or file's) clone block
+ * size, this is the best NFSD can do.
+ */
+static __be32 nfsd4_encode_fattr4_clone_blksize(struct xdr_stream *xdr,
+						const struct nfsd4_fattr_args *args)
+{
+	struct inode *inode = d_inode(args->dentry);
+
+	return nfsd4_encode_uint32_t(xdr, inode->i_sb->s_blocksize);
+}
+
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 static __be32 nfsd4_encode_fattr4_sec_label(struct xdr_stream *xdr,
 					    const struct nfsd4_fattr_args *args)
@@ -3487,7 +3504,7 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_MODE_SET_MASKED]	= nfsd4_encode_fattr4__noop,
 	[FATTR4_SUPPATTR_EXCLCREAT]	= nfsd4_encode_fattr4_suppattr_exclcreat,
 	[FATTR4_FS_CHARSET_CAP]		= nfsd4_encode_fattr4__noop,
-	[FATTR4_CLONE_BLKSIZE]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_CLONE_BLKSIZE]		= nfsd4_encode_fattr4_clone_blksize,
 	[FATTR4_SPACE_FREED]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_CHANGE_ATTR_TYPE]	= nfsd4_encode_fattr4__noop,
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 2e835e7c107e..dcaa31706394 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1653,7 +1653,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
  */
 int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	int *nthreads, count = 0, nrpools, i, ret = -EOPNOTSUPP, rem;
+	int *nthreads, nrpools = 0, i, ret = -EOPNOTSUPP, rem;
 	struct net *net = genl_info_net(info);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	const struct nlattr *attr;
@@ -1665,12 +1665,11 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 	/* count number of SERVER_THREADS values */
 	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
 		if (nla_type(attr) == NFSD_A_SERVER_THREADS)
-			count++;
+			nrpools++;
 	}
 
 	mutex_lock(&nfsd_mutex);
 
-	nrpools = max(count, nfsd_nrpools(net));
 	nthreads = kcalloc(nrpools, sizeof(int), GFP_KERNEL);
 	if (!nthreads) {
 		ret = -ENOMEM;
@@ -2331,12 +2330,9 @@ static int __init init_nfsd(void)
 	if (retval)
 		goto out_free_pnfs;
 	nfsd_lockd_init();	/* lockd->nfsd callbacks */
-	retval = create_proc_exports_entry();
-	if (retval)
-		goto out_free_lockd;
 	retval = register_pernet_subsys(&nfsd_net_ops);
 	if (retval < 0)
-		goto out_free_exports;
+		goto out_free_lockd;
 	retval = register_cld_notifier();
 	if (retval)
 		goto out_free_subsys;
@@ -2345,22 +2341,26 @@ static int __init init_nfsd(void)
 		goto out_free_cld;
 	retval = register_filesystem(&nfsd_fs_type);
 	if (retval)
-		goto out_free_all;
+		goto out_free_nfsd4;
 	retval = genl_register_family(&nfsd_nl_family);
+	if (retval)
+		goto out_free_filesystem;
+	retval = create_proc_exports_entry();
 	if (retval)
 		goto out_free_all;
 	nfsd_localio_ops_init();
 
 	return 0;
 out_free_all:
+	genl_unregister_family(&nfsd_nl_family);
+out_free_filesystem:
+	unregister_filesystem(&nfsd_fs_type);
+out_free_nfsd4:
 	nfsd4_destroy_laundry_wq();
 out_free_cld:
 	unregister_cld_notifier();
 out_free_subsys:
 	unregister_pernet_subsys(&nfsd_net_ops);
-out_free_exports:
-	remove_proc_entry("fs/nfs/exports", NULL);
-	remove_proc_entry("fs/nfs", NULL);
 out_free_lockd:
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
@@ -2373,14 +2373,14 @@ static int __init init_nfsd(void)
 
 static void __exit exit_nfsd(void)
 {
+	remove_proc_entry("fs/nfs/exports", NULL);
+	remove_proc_entry("fs/nfs", NULL);
 	genl_unregister_family(&nfsd_nl_family);
 	unregister_filesystem(&nfsd_fs_type);
 	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
 	nfsd_drc_slab_free();
-	remove_proc_entry("fs/nfs/exports", NULL);
-	remove_proc_entry("fs/nfs", NULL);
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
 	nfsd4_exit_pnfs();
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 49e2f32102ab..45f1bb2c6f13 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -406,13 +406,13 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	if (ret)
 		goto out_filecache;
 
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+	nfsd4_ssc_init_umount_work(nn);
+#endif
 	ret = nfs4_state_start_net(net);
 	if (ret)
 		goto out_reply_cache;
 
-#ifdef CONFIG_NFSD_V4_2_INTER_SSC
-	nfsd4_ssc_init_umount_work(nn);
-#endif
 	nn->nfsd_net_up = true;
 	return 0;
 
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 4444c78e2e0c..94095058da34 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -48,8 +48,8 @@ static struct file *ovl_open_realfile(const struct file *file,
 		if (!inode_owner_or_capable(real_idmap, realinode))
 			flags &= ~O_NOATIME;
 
-		realfile = backing_file_open(&file->f_path, flags, realpath,
-					     current_cred());
+		realfile = backing_file_open(file_user_path((struct file *) file),
+					     flags, realpath, current_cred());
 	}
 	revert_creds(old_cred);
 
diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 749794667295..d64742ba371a 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -484,8 +484,17 @@ void close_all_cached_dirs(struct cifs_sb_info *cifs_sb)
 		spin_lock(&cfids->cfid_list_lock);
 		list_for_each_entry(cfid, &cfids->entries, entry) {
 			tmp_list = kmalloc(sizeof(*tmp_list), GFP_ATOMIC);
-			if (tmp_list == NULL)
-				break;
+			if (tmp_list == NULL) {
+				/*
+				 * If the malloc() fails, we won't drop all
+				 * dentries, and unmounting is likely to trigger
+				 * a 'Dentry still in use' error.
+				 */
+				cifs_tcon_dbg(VFS, "Out of memory while dropping dentries\n");
+				spin_unlock(&cfids->cfid_list_lock);
+				spin_unlock(&cifs_sb->tlink_tree_lock);
+				goto done;
+			}
 			spin_lock(&cfid->fid_lock);
 			tmp_list->dentry = cfid->dentry;
 			cfid->dentry = NULL;
@@ -497,6 +506,7 @@ void close_all_cached_dirs(struct cifs_sb_info *cifs_sb)
 	}
 	spin_unlock(&cifs_sb->tlink_tree_lock);
 
+done:
 	list_for_each_entry_safe(tmp_list, q, &entry, entry) {
 		list_del(&tmp_list->entry);
 		dput(tmp_list->dentry);
diff --git a/fs/smb/client/cached_dir.h b/fs/smb/client/cached_dir.h
index 1dfe79d947a6..bc8a812ff95f 100644
--- a/fs/smb/client/cached_dir.h
+++ b/fs/smb/client/cached_dir.h
@@ -21,10 +21,10 @@ struct cached_dirent {
 struct cached_dirents {
 	bool is_valid:1;
 	bool is_failed:1;
-	struct dir_context *ctx; /*
-				  * Only used to make sure we only take entries
-				  * from a single context. Never dereferenced.
-				  */
+	struct file *file; /*
+			    * Used to associate the cache with a single
+			    * open file instance.
+			    */
 	struct mutex de_mutex;
 	int pos;		 /* Expected ctx->pos */
 	struct list_head entries;
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index a38b40d68b14..e0faee22be07 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1058,6 +1058,7 @@ struct cifs_chan {
 };
 
 #define CIFS_SES_FLAG_SCALE_CHANNELS (0x1)
+#define CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES (0x2)
 
 /*
  * Session structure.  One of these for each uid session with a particular host
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 8260d0e07a62..91f5fd818cbf 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -132,13 +132,9 @@ static void smb2_query_server_interfaces(struct work_struct *work)
 	rc = server->ops->query_server_interfaces(xid, tcon, false);
 	free_xid(xid);
 
-	if (rc) {
-		if (rc == -EOPNOTSUPP)
-			return;
-
+	if (rc)
 		cifs_dbg(FYI, "%s: failed to query server interfaces: %d\n",
 				__func__, rc);
-	}
 
 	queue_delayed_work(cifsiod_wq, &tcon->query_interfaces,
 			   (SMB_INTERFACE_POLL_INTERVAL * HZ));
@@ -393,6 +389,13 @@ static int __cifs_reconnect(struct TCP_Server_Info *server,
 	if (!cifs_tcp_ses_needs_reconnect(server, 1))
 		return 0;
 
+	/*
+	 * if smb session has been marked for reconnect, also reconnect all
+	 * connections. This way, the other connections do not end up bad.
+	 */
+	if (mark_smb_session)
+		cifs_signal_cifsd_for_reconnect(server, mark_smb_session);
+
 	cifs_mark_tcp_ses_conns_for_reconnect(server, mark_smb_session);
 
 	cifs_abort_connection(server);
@@ -401,7 +404,8 @@ static int __cifs_reconnect(struct TCP_Server_Info *server,
 		try_to_freeze();
 		cifs_server_lock(server);
 
-		if (!cifs_swn_set_server_dstaddr(server)) {
+		if (!cifs_swn_set_server_dstaddr(server) &&
+		    !SERVER_IS_CHAN(server)) {
 			/* resolve the hostname again to make sure that IP address is up-to-date */
 			rc = reconn_set_ipaddr_from_hostname(server);
 			cifs_dbg(FYI, "%s: reconn_set_ipaddr_from_hostname: rc=%d\n", __func__, rc);
@@ -3989,6 +3993,7 @@ cifs_negotiate_protocol(const unsigned int xid, struct cifs_ses *ses,
 		return 0;
 	}
 
+	server->lstrp = jiffies;
 	server->tcpStatus = CifsInNegotiate;
 	spin_unlock(&server->srv_lock);
 
diff --git a/fs/smb/client/namespace.c b/fs/smb/client/namespace.c
index e3f9213131c4..a6655807c086 100644
--- a/fs/smb/client/namespace.c
+++ b/fs/smb/client/namespace.c
@@ -146,6 +146,9 @@ static char *automount_fullpath(struct dentry *dentry, void *page)
 	}
 	spin_unlock(&tcon->tc_lock);
 
+	if (unlikely(!page))
+		return ERR_PTR(-ENOMEM);
+
 	s = dentry_path_raw(dentry, page, PATH_MAX);
 	if (IS_ERR(s))
 		return s;
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 787d6bcb5d1d..c3feb26fcfd0 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -850,9 +850,9 @@ static bool emit_cached_dirents(struct cached_dirents *cde,
 }
 
 static void update_cached_dirents_count(struct cached_dirents *cde,
-					struct dir_context *ctx)
+					struct file *file)
 {
-	if (cde->ctx != ctx)
+	if (cde->file != file)
 		return;
 	if (cde->is_valid || cde->is_failed)
 		return;
@@ -861,9 +861,9 @@ static void update_cached_dirents_count(struct cached_dirents *cde,
 }
 
 static void finished_cached_dirents_count(struct cached_dirents *cde,
-					struct dir_context *ctx)
+					struct dir_context *ctx, struct file *file)
 {
-	if (cde->ctx != ctx)
+	if (cde->file != file)
 		return;
 	if (cde->is_valid || cde->is_failed)
 		return;
@@ -876,11 +876,12 @@ static void finished_cached_dirents_count(struct cached_dirents *cde,
 static void add_cached_dirent(struct cached_dirents *cde,
 			      struct dir_context *ctx,
 			      const char *name, int namelen,
-			      struct cifs_fattr *fattr)
+			      struct cifs_fattr *fattr,
+				  struct file *file)
 {
 	struct cached_dirent *de;
 
-	if (cde->ctx != ctx)
+	if (cde->file != file)
 		return;
 	if (cde->is_valid || cde->is_failed)
 		return;
@@ -910,7 +911,8 @@ static void add_cached_dirent(struct cached_dirents *cde,
 static bool cifs_dir_emit(struct dir_context *ctx,
 			  const char *name, int namelen,
 			  struct cifs_fattr *fattr,
-			  struct cached_fid *cfid)
+			  struct cached_fid *cfid,
+			  struct file *file)
 {
 	bool rc;
 	ino_t ino = cifs_uniqueid_to_ino_t(fattr->cf_uniqueid);
@@ -922,7 +924,7 @@ static bool cifs_dir_emit(struct dir_context *ctx,
 	if (cfid) {
 		mutex_lock(&cfid->dirents.de_mutex);
 		add_cached_dirent(&cfid->dirents, ctx, name, namelen,
-				  fattr);
+				  fattr, file);
 		mutex_unlock(&cfid->dirents.de_mutex);
 	}
 
@@ -1022,7 +1024,7 @@ static int cifs_filldir(char *find_entry, struct file *file,
 	cifs_prime_dcache(file_dentry(file), &name, &fattr);
 
 	return !cifs_dir_emit(ctx, name.name, name.len,
-			      &fattr, cfid);
+			      &fattr, cfid, file);
 }
 
 
@@ -1073,8 +1075,8 @@ int cifs_readdir(struct file *file, struct dir_context *ctx)
 	 * we need to initialize scanning and storing the
 	 * directory content.
 	 */
-	if (ctx->pos == 0 && cfid->dirents.ctx == NULL) {
-		cfid->dirents.ctx = ctx;
+	if (ctx->pos == 0 && cfid->dirents.file == NULL) {
+		cfid->dirents.file = file;
 		cfid->dirents.pos = 2;
 	}
 	/*
@@ -1142,7 +1144,7 @@ int cifs_readdir(struct file *file, struct dir_context *ctx)
 	} else {
 		if (cfid) {
 			mutex_lock(&cfid->dirents.de_mutex);
-			finished_cached_dirents_count(&cfid->dirents, ctx);
+			finished_cached_dirents_count(&cfid->dirents, ctx, file);
 			mutex_unlock(&cfid->dirents.de_mutex);
 		}
 		cifs_dbg(FYI, "Could not find entry\n");
@@ -1183,7 +1185,7 @@ int cifs_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos++;
 		if (cfid) {
 			mutex_lock(&cfid->dirents.de_mutex);
-			update_cached_dirents_count(&cfid->dirents, ctx);
+			update_cached_dirents_count(&cfid->dirents, file);
 			mutex_unlock(&cfid->dirents.de_mutex);
 		}
 
diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index b6556fe3dfa1..4d45c31336df 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -738,7 +738,6 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
 	if (!have_xattr_dev && (tag == IO_REPARSE_TAG_LX_CHR || tag == IO_REPARSE_TAG_LX_BLK))
 		return false;
 
-	fattr->cf_dtype = S_DT(fattr->cf_mode);
 	return true;
 }
 
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 9b32f7821b71..10d82d0dc6a9 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -473,6 +473,10 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 
 	ses->chans[chan_index].iface = iface;
 	spin_unlock(&ses->chan_lock);
+
+	spin_lock(&server->srv_lock);
+	memcpy(&server->dstaddr, &iface->sockaddr, sizeof(server->dstaddr));
+	spin_unlock(&server->srv_lock);
 }
 
 static int
@@ -522,8 +526,7 @@ cifs_ses_add_channel(struct cifs_ses *ses,
 	ctx->domainauto = ses->domainAuto;
 	ctx->domainname = ses->domainName;
 
-	/* no hostname for extra channels */
-	ctx->server_hostname = "";
+	ctx->server_hostname = ses->server->hostname;
 
 	ctx->username = ses->user_name;
 	ctx->password = ses->password;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 176be478cd13..c6ae395a4692 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -428,14 +428,23 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	if (!rc &&
 	    (server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL) &&
 	    server->ops->query_server_interfaces) {
-		mutex_unlock(&ses->session_mutex);
-
 		/*
-		 * query server network interfaces, in case they change
+		 * query server network interfaces, in case they change.
+		 * Also mark the session as pending this update while the query
+		 * is in progress. This will be used to avoid calling
+		 * smb2_reconnect recursively.
 		 */
+		ses->flags |= CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES;
 		xid = get_xid();
 		rc = server->ops->query_server_interfaces(xid, tcon, false);
 		free_xid(xid);
+		ses->flags &= ~CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES;
+
+		/* regardless of rc value, setup polling */
+		queue_delayed_work(cifsiod_wq, &tcon->query_interfaces,
+				   (SMB_INTERFACE_POLL_INTERVAL * HZ));
+
+		mutex_unlock(&ses->session_mutex);
 
 		if (rc == -EOPNOTSUPP && ses->chan_count > 1) {
 			/*
@@ -455,11 +464,8 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		if (ses->chan_max > ses->chan_count &&
 		    ses->iface_count &&
 		    !SERVER_IS_CHAN(server)) {
-			if (ses->chan_count == 1) {
+			if (ses->chan_count == 1)
 				cifs_server_dbg(VFS, "supports multichannel now\n");
-				queue_delayed_work(cifsiod_wq, &tcon->query_interfaces,
-						 (SMB_INTERFACE_POLL_INTERVAL * HZ));
-			}
 
 			cifs_try_adding_channels(ses);
 		}
@@ -577,11 +583,18 @@ static int smb2_ioctl_req_init(u32 opcode, struct cifs_tcon *tcon,
 			       struct TCP_Server_Info *server,
 			       void **request_buf, unsigned int *total_len)
 {
-	/* Skip reconnect only for FSCTL_VALIDATE_NEGOTIATE_INFO IOCTLs */
-	if (opcode == FSCTL_VALIDATE_NEGOTIATE_INFO) {
+	/*
+	 * Skip reconnect in one of the following cases:
+	 * 1. For FSCTL_VALIDATE_NEGOTIATE_INFO IOCTLs
+	 * 2. For FSCTL_QUERY_NETWORK_INTERFACE_INFO IOCTL when called from
+	 * smb2_reconnect (indicated by CIFS_SES_FLAG_SCALE_CHANNELS ses flag)
+	 */
+	if (opcode == FSCTL_VALIDATE_NEGOTIATE_INFO ||
+	    (opcode == FSCTL_QUERY_NETWORK_INTERFACE_INFO &&
+	     (tcon->ses->flags & CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES)))
 		return __smb2_plain_req_init(SMB2_IOCTL, tcon, server,
 					     request_buf, total_len);
-	}
+
 	return smb2_plain_req_init(SMB2_IOCTL, tcon, server,
 				   request_buf, total_len);
 }
diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index b0b7254661e9..9d8be034f103 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -2552,13 +2552,14 @@ static ssize_t smb_extract_folioq_to_rdma(struct iov_iter *iter,
 		size_t fsize = folioq_folio_size(folioq, slot);
 
 		if (offset < fsize) {
-			size_t part = umin(maxsize - ret, fsize - offset);
+			size_t part = umin(maxsize, fsize - offset);
 
 			if (!smb_set_sge(rdma, folio_page(folio, 0), offset, part))
 				return -EIO;
 
 			offset += part;
 			ret += part;
+			maxsize -= part;
 		}
 
 		if (offset >= fsize) {
@@ -2573,7 +2574,7 @@ static ssize_t smb_extract_folioq_to_rdma(struct iov_iter *iter,
 				slot = 0;
 			}
 		}
-	} while (rdma->nr_sge < rdma->max_sge || maxsize > 0);
+	} while (rdma->nr_sge < rdma->max_sge && maxsize > 0);
 
 	iter->folioq = folioq;
 	iter->folioq_slot = slot;
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 9f13a705f7f6..35d187118793 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1029,14 +1029,16 @@ struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses)
 	uint index = 0;
 	unsigned int min_in_flight = UINT_MAX, max_in_flight = 0;
 	struct TCP_Server_Info *server = NULL;
-	int i;
+	int i, start, cur;
 
 	if (!ses)
 		return NULL;
 
 	spin_lock(&ses->chan_lock);
+	start = atomic_inc_return(&ses->chan_seq);
 	for (i = 0; i < ses->chan_count; i++) {
-		server = ses->chans[i].server;
+		cur = (start + i) % ses->chan_count;
+		server = ses->chans[cur].server;
 		if (!server || server->terminate)
 			continue;
 
@@ -1053,17 +1055,15 @@ struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses)
 		 */
 		if (server->in_flight < min_in_flight) {
 			min_in_flight = server->in_flight;
-			index = i;
+			index = cur;
 		}
 		if (server->in_flight > max_in_flight)
 			max_in_flight = server->in_flight;
 	}
 
 	/* if all channels are equally loaded, fall back to round-robin */
-	if (min_in_flight == max_in_flight) {
-		index = (uint)atomic_inc_return(&ses->chan_seq);
-		index %= ses->chan_count;
-	}
+	if (min_in_flight == max_in_flight)
+		index = (uint)start % ses->chan_count;
 
 	server = ses->chans[index].server;
 	spin_unlock(&ses->chan_lock);
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 7aaea71a4f20..9eb3e6010aa6 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -40,7 +40,7 @@ void ksmbd_conn_free(struct ksmbd_conn *conn)
 	kvfree(conn->request_buf);
 	kfree(conn->preauth_info);
 	if (atomic_dec_and_test(&conn->refcnt)) {
-		ksmbd_free_transport(conn->transport);
+		conn->transport->ops->free_transport(conn->transport);
 		kfree(conn);
 	}
 }
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index 14620e147dda..572102098c10 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -132,6 +132,7 @@ struct ksmbd_transport_ops {
 			  void *buf, unsigned int len,
 			  struct smb2_buffer_desc_v1 *desc,
 			  unsigned int desc_len);
+	void (*free_transport)(struct ksmbd_transport *kt);
 };
 
 struct ksmbd_transport {
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 08d9a7cfba8c..6537ffd2b965 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1605,17 +1605,18 @@ static int krb5_authenticate(struct ksmbd_work *work,
 	out_len = work->response_sz -
 		(le16_to_cpu(rsp->SecurityBufferOffset) + 4);
 
-	/* Check previous session */
-	prev_sess_id = le64_to_cpu(req->PreviousSessionId);
-	if (prev_sess_id && prev_sess_id != sess->id)
-		destroy_previous_session(conn, sess->user, prev_sess_id);
-
 	retval = ksmbd_krb5_authenticate(sess, in_blob, in_len,
 					 out_blob, &out_len);
 	if (retval) {
 		ksmbd_debug(SMB, "krb5 authentication failed\n");
 		return -EINVAL;
 	}
+
+	/* Check previous session */
+	prev_sess_id = le64_to_cpu(req->PreviousSessionId);
+	if (prev_sess_id && prev_sess_id != sess->id)
+		destroy_previous_session(conn, sess->user, prev_sess_id);
+
 	rsp->SecurityBufferLength = cpu_to_le16(out_len);
 
 	if ((conn->sign || server_conf.enforced_signing) ||
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 7c5a0d712873..6921d62934bc 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -158,7 +158,8 @@ struct smb_direct_transport {
 };
 
 #define KSMBD_TRANS(t) ((struct ksmbd_transport *)&((t)->transport))
-
+#define SMBD_TRANS(t)	((struct smb_direct_transport *)container_of(t, \
+				struct smb_direct_transport, transport))
 enum {
 	SMB_DIRECT_MSG_NEGOTIATE_REQ = 0,
 	SMB_DIRECT_MSG_DATA_TRANSFER
@@ -409,6 +410,11 @@ static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
 	return NULL;
 }
 
+static void smb_direct_free_transport(struct ksmbd_transport *kt)
+{
+	kfree(SMBD_TRANS(kt));
+}
+
 static void free_transport(struct smb_direct_transport *t)
 {
 	struct smb_direct_recvmsg *recvmsg;
@@ -454,7 +460,6 @@ static void free_transport(struct smb_direct_transport *t)
 
 	smb_direct_destroy_pools(t);
 	ksmbd_conn_free(KSMBD_TRANS(t)->conn);
-	kfree(t);
 }
 
 static struct smb_direct_sendmsg
@@ -2300,4 +2305,5 @@ static const struct ksmbd_transport_ops ksmbd_smb_direct_transport_ops = {
 	.read		= smb_direct_read,
 	.rdma_read	= smb_direct_rdma_read,
 	.rdma_write	= smb_direct_rdma_write,
+	.free_transport = smb_direct_free_transport,
 };
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index abedf510899a..4e9f98db9ff4 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -93,7 +93,7 @@ static struct tcp_transport *alloc_transport(struct socket *client_sk)
 	return t;
 }
 
-void ksmbd_free_transport(struct ksmbd_transport *kt)
+static void ksmbd_tcp_free_transport(struct ksmbd_transport *kt)
 {
 	struct tcp_transport *t = TCP_TRANS(kt);
 
@@ -656,4 +656,5 @@ static const struct ksmbd_transport_ops ksmbd_tcp_transport_ops = {
 	.read		= ksmbd_tcp_read,
 	.writev		= ksmbd_tcp_writev,
 	.disconnect	= ksmbd_tcp_disconnect,
+	.free_transport = ksmbd_tcp_free_transport,
 };
diff --git a/fs/xattr.c b/fs/xattr.c
index 4f5a45338a83..0191ac2590e0 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1341,6 +1341,7 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 		buffer += err;
 	}
 	remaining_size -= err;
+	err = 0;
 
 	read_lock(&xattrs->lock);
 	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 80767e8bf3ad..d323dfffa4bf 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -527,7 +527,7 @@ typedef u64 acpi_integer;
 
 /* Support for the special RSDP signature (8 characters) */
 
-#define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, 8))
+#define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, (sizeof(a) < 8) ? ACPI_NAMESEG_SIZE : 8))
 #define ACPI_MAKE_RSDP_SIG(dest)        (memcpy (ACPI_CAST_PTR (char, (dest)), ACPI_SIG_RSDP, 8))
 
 /* Support for OEMx signature (x can be any character) */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d5ee84c468b..f826bb59556a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1110,13 +1110,13 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
 
 acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
 					   u32 val_a, u32 val_b);
-#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
 struct acpi_s2idle_dev_ops {
 	struct list_head list_node;
 	void (*prepare)(void);
 	void (*check)(void);
 	void (*restore)(void);
 };
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 int acpi_get_lps0_constraint(struct acpi_device *adev);
@@ -1125,6 +1125,13 @@ static inline int acpi_get_lps0_constraint(struct device *dev)
 {
 	return ACPI_STATE_UNKNOWN;
 }
+static inline int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
+{
+	return -ENODEV;
+}
+static inline void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
+{
+}
 #endif /* CONFIG_SUSPEND && CONFIG_X86 */
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 9b02961d65ee..45f2f278b50a 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -249,6 +249,12 @@ static inline void atm_account_tx(struct atm_vcc *vcc, struct sk_buff *skb)
 	ATM_SKB(skb)->atm_options = vcc->atm_options;
 }
 
+static inline void atm_return_tx(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	WARN_ON_ONCE(refcount_sub_and_test(ATM_SKB(skb)->acct_truesize,
+					   &sk_atm(vcc)->sk_wmem_alloc));
+}
+
 static inline void atm_force_charge(struct atm_vcc *vcc,int truesize)
 {
 	atomic_add(truesize, &sk_atm(vcc)->sk_rmem_alloc);
diff --git a/include/linux/bus/stm32_firewall_device.h b/include/linux/bus/stm32_firewall_device.h
index 5178b72bc920..eaa7a3f54450 100644
--- a/include/linux/bus/stm32_firewall_device.h
+++ b/include/linux/bus/stm32_firewall_device.h
@@ -114,27 +114,30 @@ void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall, u32 su
 
 #else /* CONFIG_STM32_FIREWALL */
 
-int stm32_firewall_get_firewall(struct device_node *np, struct stm32_firewall *firewall,
-				unsigned int nb_firewall)
+static inline int stm32_firewall_get_firewall(struct device_node *np,
+					      struct stm32_firewall *firewall,
+					      unsigned int nb_firewall)
 {
 	return -ENODEV;
 }
 
-int stm32_firewall_grant_access(struct stm32_firewall *firewall)
+static inline int stm32_firewall_grant_access(struct stm32_firewall *firewall)
 {
 	return -ENODEV;
 }
 
-void stm32_firewall_release_access(struct stm32_firewall *firewall)
+static inline void stm32_firewall_release_access(struct stm32_firewall *firewall)
 {
 }
 
-int stm32_firewall_grant_access_by_id(struct stm32_firewall *firewall, u32 subsystem_id)
+static inline int stm32_firewall_grant_access_by_id(struct stm32_firewall *firewall,
+						    u32 subsystem_id)
 {
 	return -ENODEV;
 }
 
-void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall, u32 subsystem_id)
+static inline void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall,
+						       u32 subsystem_id)
 {
 }
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index c24f8bc01045..5206d63b3386 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -78,6 +78,7 @@ enum stop_cp_reason {
 	STOP_CP_REASON_UPDATE_INODE,
 	STOP_CP_REASON_FLUSH_FAIL,
 	STOP_CP_REASON_NO_SEGMENT,
+	STOP_CP_REASON_CORRUPTED_FREE_BITMAP,
 	STOP_CP_REASON_MAX,
 };
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 12f7a7b9c06e..3897f4492e1f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -272,6 +272,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 bool is_hugetlb_entry_migration(pte_t pte);
 bool is_hugetlb_entry_hwpoisoned(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
+void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -465,6 +466,8 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 
 static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 
+static inline void hugetlb_split(struct vm_area_struct *vma, unsigned long addr) {}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 
 #ifndef pgd_write
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index eb67d3d5ff5b..2e455b20c37c 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -295,6 +295,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache support */
 #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
 #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
+#define MMC_QUIRK_NO_UHS_DDR50_TUNING	(1<<18) /* Disable DDR50 tuning */
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a5e08b937b3..5f56fa878013 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -336,7 +336,7 @@ struct tcp_sock {
 	} rcv_rtt_est;
 /* Receiver queue space */
 	struct {
-		u32	space;
+		int	space;
 		u32	seq;
 		u64	time;
 	} rcvq_space;
diff --git a/include/net/checksum.h b/include/net/checksum.h
index 1338cb92c8e7..28b101f26636 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -158,7 +158,7 @@ void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
 			       const __be32 *from, const __be32 *to,
 			       bool pseudohdr);
 void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
-				     __wsum diff, bool pseudohdr);
+				     __wsum diff, bool pseudohdr, bool ipv6);
 
 static __always_inline
 void inet_proto_csum_replace2(__sum16 *sum, struct sk_buff *skb,
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 248bfb26e2af..6d52b5584d2f 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -363,15 +363,6 @@ struct ipcm6_cookie {
 	struct ipv6_txoptions *opt;
 };
 
-static inline void ipcm6_init(struct ipcm6_cookie *ipc6)
-{
-	*ipc6 = (struct ipcm6_cookie) {
-		.hlimit = -1,
-		.tclass = -1,
-		.dontfrag = -1,
-	};
-}
-
 static inline void ipcm6_init_sk(struct ipcm6_cookie *ipc6,
 				 const struct sock *sk)
 {
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index fee854892bec..8e7094160206 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5311,22 +5311,6 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vif,
 			    struct ieee80211_tx_rate *dest,
 			    int max_rates);
 
-/**
- * ieee80211_sta_set_expected_throughput - set the expected tpt for a station
- *
- * Call this function to notify mac80211 about a change in expected throughput
- * to a station. A driver for a device that does rate control in firmware can
- * call this function when the expected throughput estimate towards a station
- * changes. The information is used to tune the CoDel AQM applied to traffic
- * going towards that station (which can otherwise be too aggressive and cause
- * slow stations to starve).
- *
- * @pubsta: the station to set throughput for.
- * @thr: the current expected throughput in kbps.
- */
-void ieee80211_sta_set_expected_throughput(struct ieee80211_sta *pubsta,
-					   u32 thr);
-
 /**
  * ieee80211_tx_rate_update - transmit rate update callback
  *
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index 57df3843e650..ad79f1ca4fb5 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -211,24 +211,6 @@ TRACE_EVENT(erofs_map_blocks_exit,
 		  show_mflags(__entry->mflags), __entry->ret)
 );
 
-TRACE_EVENT(erofs_destroy_inode,
-	TP_PROTO(struct inode *inode),
-
-	TP_ARGS(inode),
-
-	TP_STRUCT__entry(
-		__field(	dev_t,		dev		)
-		__field(	erofs_nid_t,	nid		)
-	),
-
-	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
-		__entry->nid	= EROFS_I(inode)->nid;
-	),
-
-	TP_printk("dev = (%d,%d), nid = %llu", show_dev_nid(__entry))
-);
-
 #endif /* _TRACE_EROFS_H */
 
  /* This part must be outside protection */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 552fd633f820..5a5cdb453935 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2035,6 +2035,7 @@ union bpf_attr {
  * 		for updates resulting in a null checksum the value is set to
  * 		**CSUM_MANGLED_0** instead. Flag **BPF_F_PSEUDO_HDR** indicates
  * 		the checksum is to be computed against a pseudo-header.
+ * 		Flag **BPF_F_IPV6** should be set for IPv6 packets.
  *
  * 		This helper works in combination with **bpf_csum_diff**\ (),
  * 		which does not update the checksum in-place, but offers more
@@ -6049,6 +6050,7 @@ enum {
 	BPF_F_PSEUDO_HDR		= (1ULL << 4),
 	BPF_F_MARK_MANGLED_0		= (1ULL << 5),
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
+	BPF_F_IPV6			= (1ULL << 7),
 };
 
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index a2d577b09930..8f555c1d7185 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1204,8 +1204,10 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	atomic_set(&wq->worker_refs, 1);
 	init_completion(&wq->worker_done);
 	ret = cpuhp_state_add_instance_nocalls(io_wq_online, &wq->cpuhp_node);
-	if (ret)
+	if (ret) {
+		put_task_struct(wq->task);
 		goto err;
+	}
 
 	return wq;
 err:
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 64870f51b678..52ada466bf98 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1681,7 +1681,7 @@ static __cold void io_drain_req(struct io_kiocb *req)
 	spin_unlock(&ctx->completion_lock);
 
 	io_prep_async_link(req);
-	de = kmalloc(sizeof(*de), GFP_KERNEL);
+	de = kmalloc(sizeof(*de), GFP_KERNEL_ACCOUNT);
 	if (!de) {
 		ret = -ENOMEM;
 		io_req_defer_failed(req, ret);
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 7a8c3a004800..c9289597522f 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -262,8 +262,11 @@ static int io_ring_buffers_peek(struct io_kiocb *req, struct buf_sel_arg *arg,
 		/* truncate end piece, if needed, for non partial buffers */
 		if (len > arg->max_len) {
 			len = arg->max_len;
-			if (!(bl->flags & IOBL_INC))
+			if (!(bl->flags & IOBL_INC)) {
+				if (iov != arg->iovs)
+					break;
 				buf->len = len;
+			}
 		}
 
 		iov->iov_base = u64_to_user_ptr(buf->addr);
@@ -728,7 +731,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		io_destroy_bl(ctx, bl);
 	}
 
-	free_bl = bl = kzalloc(sizeof(*bl), GFP_KERNEL);
+	free_bl = bl = kzalloc(sizeof(*bl), GFP_KERNEL_ACCOUNT);
 	if (!bl)
 		return -ENOMEM;
 
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 9a6306894895..2faa3058b2d0 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -426,7 +426,6 @@ void io_sqpoll_wait_sq(struct io_ring_ctx *ctx)
 __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 				struct io_uring_params *p)
 {
-	struct task_struct *task_to_put = NULL;
 	int ret;
 
 	/* Retain compatibility with failing for an invalid attach attempt */
@@ -510,7 +509,7 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		rcu_assign_pointer(sqd->thread, tsk);
 		mutex_unlock(&sqd->lock);
 
-		task_to_put = get_task_struct(tsk);
+		get_task_struct(tsk);
 		ret = io_uring_alloc_task_context(tsk, ctx);
 		wake_up_new_task(tsk);
 		if (ret)
@@ -525,8 +524,6 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 	complete(&ctx->sq_data->exited);
 err:
 	io_sq_thread_finish(ctx);
-	if (task_to_put)
-		put_task_struct(task_to_put);
 	return ret;
 }
 
diff --git a/ipc/shm.c b/ipc/shm.c
index 99564c870084..492fcc699985 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -431,8 +431,11 @@ static int shm_try_destroy_orphaned(int id, void *p, void *data)
 void shm_destroy_orphaned(struct ipc_namespace *ns)
 {
 	down_write(&shm_ids(ns).rwsem);
-	if (shm_ids(ns).in_use)
+	if (shm_ids(ns).in_use) {
+		rcu_read_lock();
 		idr_for_each(&shm_ids(ns).ipcs_idr, &shm_try_destroy_orphaned, ns);
+		rcu_read_unlock();
+	}
 	up_write(&shm_ids(ns).rwsem);
 }
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 477947456371..2285b27ce68c 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -577,7 +577,7 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 	if (model->ret_size > 0)
 		flags |= BPF_TRAMP_F_RET_FENTRY_RET;
 
-	size = arch_bpf_trampoline_size(model, flags, tlinks, NULL);
+	size = arch_bpf_trampoline_size(model, flags, tlinks, stub_func);
 	if (size <= 0)
 		return size ? : -EFAULT;
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2c54c148a94f..f83bd019db14 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6684,10 +6684,10 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			/* Is this a func with potential NULL args? */
 			if (strcmp(tname, raw_tp_null_args[i].func))
 				continue;
-			if (raw_tp_null_args[i].mask & (0x1 << (arg * 4)))
+			if (raw_tp_null_args[i].mask & (0x1ULL << (arg * 4)))
 				info->reg_type |= PTR_MAYBE_NULL;
 			/* Is the current arg IS_ERR? */
-			if (raw_tp_null_args[i].mask & (0x2 << (arg * 4)))
+			if (raw_tp_null_args[i].mask & (0x2ULL << (arg * 4)))
 				ptr_err_raw_tp = true;
 			break;
 		}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a05aeb345896..9173d107758d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -129,7 +129,8 @@ const struct bpf_func_proto bpf_map_peek_elem_proto = {
 
 BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, key, u32, cpu)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 	return (unsigned long) map->ops->map_lookup_percpu_elem(map, key, cpu);
 }
 
diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 074653f964c1..01c02d116e8e 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -188,13 +188,12 @@ static void freezer_attach(struct cgroup_taskset *tset)
 		if (!(freezer->state & CGROUP_FREEZING)) {
 			__thaw_task(task);
 		} else {
-			freeze_task(task);
-
 			/* clear FROZEN and propagate upwards */
 			while (freezer && (freezer->state & CGROUP_FROZEN)) {
 				freezer->state &= ~CGROUP_FROZEN;
 				freezer = parent_freezer(freezer);
 			}
+			freeze_task(task);
 		}
 	}
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9ce82904f761..7210104b3345 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -206,6 +206,19 @@ static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
 	__perf_ctx_unlock(&cpuctx->ctx);
 }
 
+typedef struct {
+	struct perf_cpu_context *cpuctx;
+	struct perf_event_context *ctx;
+} class_perf_ctx_lock_t;
+
+static inline void class_perf_ctx_lock_destructor(class_perf_ctx_lock_t *_T)
+{ perf_ctx_unlock(_T->cpuctx, _T->ctx); }
+
+static inline class_perf_ctx_lock_t
+class_perf_ctx_lock_constructor(struct perf_cpu_context *cpuctx,
+				struct perf_event_context *ctx)
+{ perf_ctx_lock(cpuctx, ctx); return (class_perf_ctx_lock_t){ cpuctx, ctx }; }
+
 #define TASK_TOMBSTONE ((void *)-1L)
 
 static bool is_kernel_event(struct perf_event *event)
@@ -898,7 +911,13 @@ static void perf_cgroup_switch(struct task_struct *task)
 	if (READ_ONCE(cpuctx->cgrp) == cgrp)
 		return;
 
-	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
+	guard(perf_ctx_lock)(cpuctx, cpuctx->task_ctx);
+	/*
+	 * Re-check, could've raced vs perf_remove_from_context().
+	 */
+	if (READ_ONCE(cpuctx->cgrp) == NULL)
+		return;
+
 	perf_ctx_disable(&cpuctx->ctx, true);
 
 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
@@ -916,7 +935,6 @@ static void perf_cgroup_switch(struct task_struct *task)
 	ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 
 	perf_ctx_enable(&cpuctx->ctx, true);
-	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
 static int perf_cgroup_ensure_storage(struct perf_event *event,
@@ -2111,8 +2129,9 @@ perf_aux_output_match(struct perf_event *event, struct perf_event *aux_event)
 }
 
 static void put_event(struct perf_event *event);
-static void event_sched_out(struct perf_event *event,
-			    struct perf_event_context *ctx);
+static void __event_disable(struct perf_event *event,
+			    struct perf_event_context *ctx,
+			    enum perf_event_state state);
 
 static void perf_put_aux_event(struct perf_event *event)
 {
@@ -2145,8 +2164,7 @@ static void perf_put_aux_event(struct perf_event *event)
 		 * state so that we don't try to schedule it again. Note
 		 * that perf_event_enable() will clear the ERROR status.
 		 */
-		event_sched_out(iter, ctx);
-		perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+		__event_disable(iter, ctx, PERF_EVENT_STATE_ERROR);
 	}
 }
 
@@ -2204,18 +2222,6 @@ static inline struct list_head *get_event_list(struct perf_event *event)
 				    &event->pmu_ctx->flexible_active;
 }
 
-/*
- * Events that have PERF_EV_CAP_SIBLING require being part of a group and
- * cannot exist on their own, schedule them out and move them into the ERROR
- * state. Also see _perf_event_enable(), it will not be able to recover
- * this ERROR state.
- */
-static inline void perf_remove_sibling_event(struct perf_event *event)
-{
-	event_sched_out(event, event->ctx);
-	perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
-}
-
 static void perf_group_detach(struct perf_event *event)
 {
 	struct perf_event *leader = event->group_leader;
@@ -2251,8 +2257,15 @@ static void perf_group_detach(struct perf_event *event)
 	 */
 	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
 
+		/*
+		 * Events that have PERF_EV_CAP_SIBLING require being part of
+		 * a group and cannot exist on their own, schedule them out
+		 * and move them into the ERROR state. Also see
+		 * _perf_event_enable(), it will not be able to recover this
+		 * ERROR state.
+		 */
 		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
-			perf_remove_sibling_event(sibling);
+			__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
 
 		sibling->group_leader = sibling;
 		list_del_init(&sibling->sibling_list);
@@ -2512,6 +2525,15 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
 	event_function_call(event, __perf_remove_from_context, (void *)flags);
 }
 
+static void __event_disable(struct perf_event *event,
+			    struct perf_event_context *ctx,
+			    enum perf_event_state state)
+{
+	event_sched_out(event, ctx);
+	perf_cgroup_event_disable(event, ctx);
+	perf_event_set_state(event, state);
+}
+
 /*
  * Cross CPU call to disable a performance event
  */
@@ -2526,13 +2548,18 @@ static void __perf_event_disable(struct perf_event *event,
 	perf_pmu_disable(event->pmu_ctx->pmu);
 	ctx_time_update_event(ctx, event);
 
+	/*
+	 * When disabling a group leader, the whole group becomes ineligible
+	 * to run, so schedule out the full group.
+	 */
 	if (event == event->group_leader)
 		group_sched_out(event, ctx);
-	else
-		event_sched_out(event, ctx);
 
-	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-	perf_cgroup_event_disable(event, ctx);
+	/*
+	 * But only mark the leader OFF; the siblings will remain
+	 * INACTIVE.
+	 */
+	__event_disable(event, ctx, PERF_EVENT_STATE_OFF);
 
 	perf_pmu_enable(event->pmu_ctx->pmu);
 }
@@ -7097,6 +7124,10 @@ perf_sample_ustack_size(u16 stack_size, u16 header_size,
 	if (!regs)
 		return 0;
 
+	/* No mm, no stack, no dump. */
+	if (!current->mm)
+		return 0;
+
 	/*
 	 * Check if we fit in with the requested stack size into the:
 	 * - TASK_SIZE
@@ -7808,6 +7839,9 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
 
+	if (!current->mm)
+		user = false;
+
 	if (!kernel && !user)
 		return &__empty_callchain;
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 56b8bd9487b4..d465b36bcc86 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -923,6 +923,15 @@ void __noreturn do_exit(long code)
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
 
+	/*
+	 * Since sampling can touch ->mm, make sure to stop everything before we
+	 * tear it down.
+	 *
+	 * Also flushes inherited counters to the parent - before the parent
+	 * gets woken up by child-exit notifications.
+	 */
+	perf_event_exit_task(tsk);
+
 	exit_mm();
 
 	if (group_dead)
@@ -939,14 +948,6 @@ void __noreturn do_exit(long code)
 	exit_task_work(tsk);
 	exit_thread(tsk);
 
-	/*
-	 * Flush inherited counters to the parent - before the parent
-	 * gets woken up by child-exit notifications.
-	 *
-	 * because of cgroup mode, must be called before cgroup_exit()
-	 */
-	perf_event_exit_task(tsk);
-
 	sched_autogroup_exit_task(tsk);
 	cgroup_exit(tsk);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51f36de5990a..d4948a862992 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8423,7 +8423,7 @@ void __init sched_init(void)
 		init_cfs_bandwidth(&root_task_group.cfs_bandwidth, NULL);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 #ifdef CONFIG_EXT_GROUP_SCHED
-		root_task_group.scx_weight = CGROUP_WEIGHT_DFL;
+		scx_tg_init(&root_task_group);
 #endif /* CONFIG_EXT_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
 		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
@@ -8863,7 +8863,7 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
-	scx_group_set_weight(tg, CGROUP_WEIGHT_DFL);
+	scx_tg_init(tg);
 	alloc_uclamp_sched_group(tg, parent);
 
 	return tg;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ace5262642f9..ddd4fa785264 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3918,6 +3918,11 @@ static void scx_cgroup_warn_missing_idle(struct task_group *tg)
 	cgroup_warned_missing_idle = true;
 }
 
+void scx_tg_init(struct task_group *tg)
+{
+	tg->scx_weight = CGROUP_WEIGHT_DFL;
+}
+
 int scx_tg_online(struct task_group *tg)
 {
 	int ret = 0;
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 1079b56b0f7a..67032c30c754 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -70,6 +70,7 @@ static inline void scx_update_idle(struct rq *rq, bool idle, bool do_notify) {}
 
 #ifdef CONFIG_CGROUP_SCHED
 #ifdef CONFIG_EXT_GROUP_SCHED
+void scx_tg_init(struct task_group *tg);
 int scx_tg_online(struct task_group *tg);
 void scx_tg_offline(struct task_group *tg);
 int scx_cgroup_can_attach(struct cgroup_taskset *tset);
@@ -79,6 +80,7 @@ void scx_cgroup_cancel_attach(struct cgroup_taskset *tset);
 void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight);
 void scx_group_set_idle(struct task_group *tg, bool idle);
 #else	/* CONFIG_EXT_GROUP_SCHED */
+static inline void scx_tg_init(struct task_group *tg) {}
 static inline int scx_tg_online(struct task_group *tg) { return 0; }
 static inline void scx_tg_offline(struct task_group *tg) {}
 static inline int scx_cgroup_can_attach(struct cgroup_taskset *tset) { return 0; }
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 58fb7280cabb..ae862ad9642c 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -302,7 +302,7 @@ static void clocksource_verify_choose_cpus(void)
 {
 	int cpu, i, n = verify_n_cpus;
 
-	if (n < 0) {
+	if (n < 0 || n >= num_online_cpus()) {
 		/* Check all of the CPUs. */
 		cpumask_copy(&cpus_chosen, cpu_online_mask);
 		cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e67d67f7b906..ad7db84b0409 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7295,9 +7295,10 @@ void ftrace_release_mod(struct module *mod)
 
 	mutex_lock(&ftrace_lock);
 
-	if (ftrace_disabled)
-		goto out_unlock;
-
+	/*
+	 * To avoid the UAF problem after the module is unloaded, the
+	 * 'mod_map' resource needs to be released unconditionally.
+	 */
 	list_for_each_entry_safe(mod_map, n, &ftrace_mod_maps, list) {
 		if (mod_map->mod == mod) {
 			list_del_rcu(&mod_map->list);
@@ -7306,6 +7307,9 @@ void ftrace_release_mod(struct module *mod)
 		}
 	}
 
+	if (ftrace_disabled)
+		goto out_unlock;
+
 	/*
 	 * Each module has its own ftrace_pages, remove
 	 * them from the list.
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 4dc72540c3b0..8fbb4385e814 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -47,6 +47,7 @@ int __read_mostly watchdog_user_enabled = 1;
 static int __read_mostly watchdog_hardlockup_user_enabled = WATCHDOG_HARDLOCKUP_DEFAULT;
 static int __read_mostly watchdog_softlockup_user_enabled = 1;
 int __read_mostly watchdog_thresh = 10;
+static int __read_mostly watchdog_thresh_next;
 static int __read_mostly watchdog_hardlockup_available;
 
 struct cpumask watchdog_cpumask __read_mostly;
@@ -863,12 +864,20 @@ int lockup_detector_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void __lockup_detector_reconfigure(void)
+static void __lockup_detector_reconfigure(bool thresh_changed)
 {
 	cpus_read_lock();
 	watchdog_hardlockup_stop();
 
 	softlockup_stop_all();
+	/*
+	 * To prevent watchdog_timer_fn from using the old interval and
+	 * the new watchdog_thresh at the same time, which could lead to
+	 * false softlockup reports, it is necessary to update the
+	 * watchdog_thresh after the softlockup is completed.
+	 */
+	if (thresh_changed)
+		watchdog_thresh = READ_ONCE(watchdog_thresh_next);
 	set_sample_period();
 	lockup_detector_update_enable();
 	if (watchdog_enabled && watchdog_thresh)
@@ -881,7 +890,7 @@ static void __lockup_detector_reconfigure(void)
 void lockup_detector_reconfigure(void)
 {
 	mutex_lock(&watchdog_mutex);
-	__lockup_detector_reconfigure();
+	__lockup_detector_reconfigure(false);
 	mutex_unlock(&watchdog_mutex);
 }
 
@@ -901,27 +910,29 @@ static __init void lockup_detector_setup(void)
 		return;
 
 	mutex_lock(&watchdog_mutex);
-	__lockup_detector_reconfigure();
+	__lockup_detector_reconfigure(false);
 	softlockup_initialized = true;
 	mutex_unlock(&watchdog_mutex);
 }
 
 #else /* CONFIG_SOFTLOCKUP_DETECTOR */
-static void __lockup_detector_reconfigure(void)
+static void __lockup_detector_reconfigure(bool thresh_changed)
 {
 	cpus_read_lock();
 	watchdog_hardlockup_stop();
+	if (thresh_changed)
+		watchdog_thresh = READ_ONCE(watchdog_thresh_next);
 	lockup_detector_update_enable();
 	watchdog_hardlockup_start();
 	cpus_read_unlock();
 }
 void lockup_detector_reconfigure(void)
 {
-	__lockup_detector_reconfigure();
+	__lockup_detector_reconfigure(false);
 }
 static inline void lockup_detector_setup(void)
 {
-	__lockup_detector_reconfigure();
+	__lockup_detector_reconfigure(false);
 }
 #endif /* !CONFIG_SOFTLOCKUP_DETECTOR */
 
@@ -939,11 +950,11 @@ void lockup_detector_soft_poweroff(void)
 #ifdef CONFIG_SYSCTL
 
 /* Propagate any changes to the watchdog infrastructure */
-static void proc_watchdog_update(void)
+static void proc_watchdog_update(bool thresh_changed)
 {
 	/* Remove impossible cpus to keep sysctl output clean. */
 	cpumask_and(&watchdog_cpumask, &watchdog_cpumask, cpu_possible_mask);
-	__lockup_detector_reconfigure();
+	__lockup_detector_reconfigure(thresh_changed);
 }
 
 /*
@@ -976,7 +987,7 @@ static int proc_watchdog_common(int which, const struct ctl_table *table, int wr
 		old = READ_ONCE(*param);
 		err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 		if (!err && old != READ_ONCE(*param))
-			proc_watchdog_update();
+			proc_watchdog_update(false);
 	}
 	mutex_unlock(&watchdog_mutex);
 	return err;
@@ -1027,11 +1038,13 @@ static int proc_watchdog_thresh(const struct ctl_table *table, int write,
 
 	mutex_lock(&watchdog_mutex);
 
-	old = READ_ONCE(watchdog_thresh);
+	watchdog_thresh_next = READ_ONCE(watchdog_thresh);
+
+	old = watchdog_thresh_next;
 	err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
-	if (!err && write && old != READ_ONCE(watchdog_thresh))
-		proc_watchdog_update();
+	if (!err && write && old != READ_ONCE(watchdog_thresh_next))
+		proc_watchdog_update(true);
 
 	mutex_unlock(&watchdog_mutex);
 	return err;
@@ -1052,7 +1065,7 @@ static int proc_watchdog_cpumask(const struct ctl_table *table, int write,
 
 	err = proc_do_large_bitmap(table, write, buffer, lenp, ppos);
 	if (!err && write)
-		proc_watchdog_update();
+		proc_watchdog_update(false);
 
 	mutex_unlock(&watchdog_mutex);
 	return err;
@@ -1072,7 +1085,7 @@ static struct ctl_table watchdog_sysctls[] = {
 	},
 	{
 		.procname	= "watchdog_thresh",
-		.data		= &watchdog_thresh,
+		.data		= &watchdog_thresh_next,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_watchdog_thresh,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a9d64e08dffc..3c87eb98609c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7731,7 +7731,8 @@ void __init workqueue_init_early(void)
 		restrict_unbound_cpumask("workqueue.unbound_cpus", &wq_cmdline_cpumask);
 
 	cpumask_copy(wq_requested_unbound_cpumask, wq_unbound_cpumask);
-
+	cpumask_andnot(wq_isolated_cpumask, cpu_possible_mask,
+						housekeeping_cpumask(HK_TYPE_DOMAIN));
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
 	unbound_wq_update_pwq_attrs_buf = alloc_workqueue_attrs();
diff --git a/lib/Kconfig b/lib/Kconfig
index b38849af6f13..b893c9288c14 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -767,6 +767,7 @@ config GENERIC_LIB_DEVMEM_IS_ALLOWED
 
 config PLDMFW
 	bool
+	select CRC32
 	default n
 
 config ASN1_ENCODER
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e48375fe5a50..b1d7c427bbe3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2807,6 +2807,15 @@ config FORTIFY_KUNIT_TEST
 	  by the str*() and mem*() family of functions. For testing runtime
 	  traps of FORTIFY_SOURCE, see LKDTM's "FORTIFY_*" tests.
 
+config LONGEST_SYM_KUNIT_TEST
+	tristate "Test the longest symbol possible" if !KUNIT_ALL_TESTS
+	depends on KUNIT && KPROBES
+	default KUNIT_ALL_TESTS
+	help
+	  Tests the longest symbol possible
+
+	  If unsure, say N.
+
 config HW_BREAKPOINT_KUNIT_TEST
 	bool "Test hw_breakpoint constraints accounting" if !KUNIT_ALL_TESTS
 	depends on HAVE_HW_BREAKPOINT
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..fc878e716825 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -389,6 +389,8 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
+obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
+CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/longest_symbol_kunit.c b/lib/longest_symbol_kunit.c
new file mode 100644
index 000000000000..e3c28ff1807f
--- /dev/null
+++ b/lib/longest_symbol_kunit.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test the longest symbol length. Execute with:
+ *  ./tools/testing/kunit/kunit.py run longest-symbol
+ *  --arch=x86_64 --kconfig_add CONFIG_KPROBES=y --kconfig_add CONFIG_MODULES=y
+ *  --kconfig_add CONFIG_RETPOLINE=n --kconfig_add CONFIG_CFI_CLANG=n
+ *  --kconfig_add CONFIG_MITIGATION_RETPOLINE=n
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <kunit/test.h>
+#include <linux/stringify.h>
+#include <linux/kprobes.h>
+#include <linux/kallsyms.h>
+
+#define DI(name) s##name##name
+#define DDI(name) DI(n##name##name)
+#define DDDI(name) DDI(n##name##name)
+#define DDDDI(name) DDDI(n##name##name)
+#define DDDDDI(name) DDDDI(n##name##name)
+
+/*Generate a symbol whose name length is 511 */
+#define LONGEST_SYM_NAME  DDDDDI(g1h2i3j4k5l6m7n)
+
+#define RETURN_LONGEST_SYM 0xAAAAA
+
+noinline int LONGEST_SYM_NAME(void);
+noinline int LONGEST_SYM_NAME(void)
+{
+	return RETURN_LONGEST_SYM;
+}
+
+_Static_assert(sizeof(__stringify(LONGEST_SYM_NAME)) == KSYM_NAME_LEN,
+"Incorrect symbol length found. Expected KSYM_NAME_LEN: "
+__stringify(KSYM_NAME_LEN) ", but found: "
+__stringify(sizeof(LONGEST_SYM_NAME)));
+
+static void test_longest_symbol(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM, LONGEST_SYM_NAME());
+};
+
+static void test_longest_symbol_kallsyms(struct kunit *test)
+{
+	unsigned long (*kallsyms_lookup_name)(const char *name);
+	static int (*longest_sym)(void);
+
+	struct kprobe kp = {
+		.symbol_name = "kallsyms_lookup_name",
+	};
+
+	if (register_kprobe(&kp) < 0) {
+		pr_info("%s: kprobe not registered", __func__);
+		KUNIT_FAIL(test, "test_longest_symbol kallsyms: kprobe not registered\n");
+		return;
+	}
+
+	kunit_warn(test, "test_longest_symbol kallsyms: kprobe registered\n");
+	kallsyms_lookup_name = (unsigned long (*)(const char *name))kp.addr;
+	unregister_kprobe(&kp);
+
+	longest_sym =
+		(void *) kallsyms_lookup_name(__stringify(LONGEST_SYM_NAME));
+	KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM, longest_sym());
+};
+
+static struct kunit_case longest_symbol_test_cases[] = {
+	KUNIT_CASE(test_longest_symbol),
+	KUNIT_CASE(test_longest_symbol_kallsyms),
+	{}
+};
+
+static struct kunit_suite longest_symbol_test_suite = {
+	.name = "longest-symbol",
+	.test_cases = longest_symbol_test_cases,
+};
+kunit_test_suite(longest_symbol_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Test the longest symbol length");
+MODULE_AUTHOR("Sergio González Collado");
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ad646fe6688a..9c6a4e855481 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -87,7 +87,7 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
 static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end);
+		unsigned long start, unsigned long end, bool take_locks);
 static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
 
 static void hugetlb_free_folio(struct folio *folio)
@@ -5071,26 +5071,40 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
 {
 	if (addr & ~(huge_page_mask(hstate_vma(vma))))
 		return -EINVAL;
+	return 0;
+}
 
+void hugetlb_split(struct vm_area_struct *vma, unsigned long addr)
+{
 	/*
 	 * PMD sharing is only possible for PUD_SIZE-aligned address ranges
 	 * in HugeTLB VMAs. If we will lose PUD_SIZE alignment due to this
 	 * split, unshare PMDs in the PUD_SIZE interval surrounding addr now.
+	 * This function is called in the middle of a VMA split operation, with
+	 * MM, VMA and rmap all write-locked to prevent concurrent page table
+	 * walks (except hardware and gup_fast()).
 	 */
+	vma_assert_write_locked(vma);
+	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+
 	if (addr & ~PUD_MASK) {
-		/*
-		 * hugetlb_vm_op_split is called right before we attempt to
-		 * split the VMA. We will need to unshare PMDs in the old and
-		 * new VMAs, so let's unshare before we split.
-		 */
 		unsigned long floor = addr & PUD_MASK;
 		unsigned long ceil = floor + PUD_SIZE;
 
-		if (floor >= vma->vm_start && ceil <= vma->vm_end)
-			hugetlb_unshare_pmds(vma, floor, ceil);
+		if (floor >= vma->vm_start && ceil <= vma->vm_end) {
+			/*
+			 * Locking:
+			 * Use take_locks=false here.
+			 * The file rmap lock is already held.
+			 * The hugetlb VMA lock can't be taken when we already
+			 * hold the file rmap lock, and we don't need it because
+			 * its purpose is to synchronize against concurrent page
+			 * table walks, which are not possible thanks to the
+			 * locks held by our caller.
+			 */
+			hugetlb_unshare_pmds(vma, floor, ceil, /* take_locks = */ false);
+		}
 	}
-
-	return 0;
 }
 
 static unsigned long hugetlb_vm_op_pagesize(struct vm_area_struct *vma)
@@ -7252,6 +7266,13 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 		return 0;
 
 	pud_clear(pud);
+	/*
+	 * Once our caller drops the rmap lock, some other process might be
+	 * using this page table as a normal, non-hugetlb page table.
+	 * Wait for pending gup_fast() in other threads to finish before letting
+	 * that happen.
+	 */
+	tlb_remove_table_sync_one();
 	ptdesc_pmd_pts_dec(virt_to_ptdesc(ptep));
 	mm_dec_nr_pmds(mm);
 	return 1;
@@ -7484,9 +7505,16 @@ void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int re
 	}
 }
 
+/*
+ * If @take_locks is false, the caller must ensure that no concurrent page table
+ * access can happen (except for gup_fast() and hardware page walks).
+ * If @take_locks is true, we take the hugetlb VMA lock (to lock out things like
+ * concurrent page fault handling) and the file rmap lock.
+ */
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 				   unsigned long start,
-				   unsigned long end)
+				   unsigned long end,
+				   bool take_locks)
 {
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
@@ -7510,8 +7538,12 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
 				start, end);
 	mmu_notifier_invalidate_range_start(&range);
-	hugetlb_vma_lock_write(vma);
-	i_mmap_lock_write(vma->vm_file->f_mapping);
+	if (take_locks) {
+		hugetlb_vma_lock_write(vma);
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+	} else {
+		i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+	}
 	for (address = start; address < end; address += PUD_SIZE) {
 		ptep = hugetlb_walk(vma, address, sz);
 		if (!ptep)
@@ -7521,8 +7553,10 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		spin_unlock(ptl);
 	}
 	flush_hugetlb_tlb_range(vma, start, end);
-	i_mmap_unlock_write(vma->vm_file->f_mapping);
-	hugetlb_vma_unlock_write(vma);
+	if (take_locks) {
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+		hugetlb_vma_unlock_write(vma);
+	}
 	/*
 	 * No need to call mmu_notifier_arch_invalidate_secondary_tlbs(), see
 	 * Documentation/mm/mmu_notifier.rst.
@@ -7537,7 +7571,8 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 {
 	hugetlb_unshare_pmds(vma, ALIGN(vma->vm_start, PUD_SIZE),
-			ALIGN_DOWN(vma->vm_end, PUD_SIZE));
+			ALIGN_DOWN(vma->vm_end, PUD_SIZE),
+			/* take_locks = */ true);
 }
 
 #ifdef CONFIG_CMA
diff --git a/mm/madvise.c b/mm/madvise.c
index c211e8fa4e49..2e66a08fd4f4 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -495,6 +495,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 					pte_offset_map_lock(mm, pmd, addr, &ptl);
 				if (!start_pte)
 					break;
+				flush_tlb_batched_pending(mm);
 				arch_enter_lazy_mmu_mode();
 				if (!err)
 					nr = 0;
@@ -728,6 +729,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 				start_pte = pte;
 				if (!start_pte)
 					break;
+				flush_tlb_batched_pending(mm);
 				arch_enter_lazy_mmu_mode();
 				if (!err)
 					nr = 0;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index fcd4c1439cb9..bfb3f903bb6d 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -543,8 +543,8 @@ static int dirty_ratio_handler(const struct ctl_table *table, int write, void *b
 
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (ret == 0 && write && vm_dirty_ratio != old_ratio) {
-		writeback_set_ratelimit();
 		vm_dirty_bytes = 0;
+		writeback_set_ratelimit();
 	}
 	return ret;
 }
diff --git a/mm/vma.c b/mm/vma.c
index 9b4517944901..1d82ec4ee7bb 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -416,7 +416,14 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	init_vma_prep(&vp, vma);
 	vp.insert = new;
 	vma_prepare(&vp);
+
+	/*
+	 * Get rid of huge pages and shared page tables straddling the split
+	 * boundary.
+	 */
 	vma_adjust_trans_huge(vma, vma->vm_start, addr, 0);
+	if (is_vm_hugetlb_page(vma))
+		hugetlb_split(vma, addr);
 
 	if (new_below) {
 		vma->vm_start = addr;
diff --git a/mm/vma_internal.h b/mm/vma_internal.h
index b930ab12a587..1dd119f266e6 100644
--- a/mm/vma_internal.h
+++ b/mm/vma_internal.h
@@ -17,6 +17,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/huge_mm.h>
+#include <linux/hugetlb.h>
 #include <linux/hugetlb_inline.h>
 #include <linux/kernel.h>
 #include <linux/khugepaged.h>
diff --git a/net/atm/common.c b/net/atm/common.c
index 9b75699992ff..d7f7976ea13a 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -635,6 +635,7 @@ int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t size)
 
 	skb->dev = NULL; /* for paths shared with net_device interfaces */
 	if (!copy_from_iter_full(skb_put(skb, size), size, &m->msg_iter)) {
+		atm_return_tx(vcc, skb);
 		kfree_skb(skb);
 		error = -EFAULT;
 		goto out;
diff --git a/net/atm/lec.c b/net/atm/lec.c
index a948dd47c3f3..42e8047c6510 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -124,6 +124,7 @@ static unsigned char bus_mac[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 
 /* Device structures */
 static struct net_device *dev_lec[MAX_LEC_ITF];
+static DEFINE_MUTEX(lec_mutex);
 
 #if IS_ENABLED(CONFIG_BRIDGE)
 static void lec_handle_bridge(struct sk_buff *skb, struct net_device *dev)
@@ -685,6 +686,7 @@ static int lec_vcc_attach(struct atm_vcc *vcc, void __user *arg)
 	int bytes_left;
 	struct atmlec_ioc ioc_data;
 
+	lockdep_assert_held(&lec_mutex);
 	/* Lecd must be up in this case */
 	bytes_left = copy_from_user(&ioc_data, arg, sizeof(struct atmlec_ioc));
 	if (bytes_left != 0)
@@ -710,6 +712,7 @@ static int lec_vcc_attach(struct atm_vcc *vcc, void __user *arg)
 
 static int lec_mcast_attach(struct atm_vcc *vcc, int arg)
 {
+	lockdep_assert_held(&lec_mutex);
 	if (arg < 0 || arg >= MAX_LEC_ITF)
 		return -EINVAL;
 	arg = array_index_nospec(arg, MAX_LEC_ITF);
@@ -725,6 +728,7 @@ static int lecd_attach(struct atm_vcc *vcc, int arg)
 	int i;
 	struct lec_priv *priv;
 
+	lockdep_assert_held(&lec_mutex);
 	if (arg < 0)
 		arg = 0;
 	if (arg >= MAX_LEC_ITF)
@@ -742,6 +746,7 @@ static int lecd_attach(struct atm_vcc *vcc, int arg)
 		snprintf(dev_lec[i]->name, IFNAMSIZ, "lec%d", i);
 		if (register_netdev(dev_lec[i])) {
 			free_netdev(dev_lec[i]);
+			dev_lec[i] = NULL;
 			return -EINVAL;
 		}
 
@@ -904,7 +909,6 @@ static void *lec_itf_walk(struct lec_state *state, loff_t *l)
 	v = (dev && netdev_priv(dev)) ?
 		lec_priv_walk(state, l, netdev_priv(dev)) : NULL;
 	if (!v && dev) {
-		dev_put(dev);
 		/* Partial state reset for the next time we get called */
 		dev = NULL;
 	}
@@ -928,6 +932,7 @@ static void *lec_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct lec_state *state = seq->private;
 
+	mutex_lock(&lec_mutex);
 	state->itf = 0;
 	state->dev = NULL;
 	state->locked = NULL;
@@ -945,8 +950,9 @@ static void lec_seq_stop(struct seq_file *seq, void *v)
 	if (state->dev) {
 		spin_unlock_irqrestore(&state->locked->lec_arp_lock,
 				       state->flags);
-		dev_put(state->dev);
+		state->dev = NULL;
 	}
+	mutex_unlock(&lec_mutex);
 }
 
 static void *lec_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -1003,6 +1009,7 @@ static int lane_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		return -ENOIOCTLCMD;
 	}
 
+	mutex_lock(&lec_mutex);
 	switch (cmd) {
 	case ATMLEC_CTRL:
 		err = lecd_attach(vcc, (int)arg);
@@ -1017,6 +1024,7 @@ static int lane_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		break;
 	}
 
+	mutex_unlock(&lec_mutex);
 	return err;
 }
 
diff --git a/net/atm/raw.c b/net/atm/raw.c
index 2b5f78a7ec3e..1e6511ec842c 100644
--- a/net/atm/raw.c
+++ b/net/atm/raw.c
@@ -36,7 +36,7 @@ static void atm_pop_raw(struct atm_vcc *vcc, struct sk_buff *skb)
 
 	pr_debug("(%d) %d -= %d\n",
 		 vcc->vci, sk_wmem_alloc_get(sk), ATM_SKB(skb)->acct_truesize);
-	WARN_ON(refcount_sub_and_test(ATM_SKB(skb)->acct_truesize, &sk->sk_wmem_alloc));
+	atm_return_tx(vcc, skb);
 	dev_kfree_skb_any(skb);
 	sk->sk_write_space(sk);
 }
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 1820f09ff59c..3f24b4ee49c2 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -80,10 +80,10 @@ static void br_mst_vlan_set_state(struct net_bridge_vlan_group *vg,
 	if (br_vlan_get_state(v) == state)
 		return;
 
-	br_vlan_set_state(v, state);
-
 	if (v->vid == vg->pvid)
 		br_vlan_set_pvid_state(vg, state);
+
+	br_vlan_set_state(v, state);
 }
 
 int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index b2ae0d2434d2..733ff6b758f6 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2105,12 +2105,17 @@ static void __br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 	}
 }
 
-void br_multicast_enable_port(struct net_bridge_port *port)
+static void br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 {
-	struct net_bridge *br = port->br;
+	struct net_bridge *br = pmctx->port->br;
 
 	spin_lock_bh(&br->multicast_lock);
-	__br_multicast_enable_port_ctx(&port->multicast_ctx);
+	if (br_multicast_port_ctx_is_vlan(pmctx) &&
+	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
+		spin_unlock_bh(&br->multicast_lock);
+		return;
+	}
+	__br_multicast_enable_port_ctx(pmctx);
 	spin_unlock_bh(&br->multicast_lock);
 }
 
@@ -2137,11 +2142,67 @@ static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
 	br_multicast_rport_del_notify(pmctx, del);
 }
 
+static void br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
+{
+	struct net_bridge *br = pmctx->port->br;
+
+	spin_lock_bh(&br->multicast_lock);
+	if (br_multicast_port_ctx_is_vlan(pmctx) &&
+	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
+		spin_unlock_bh(&br->multicast_lock);
+		return;
+	}
+
+	__br_multicast_disable_port_ctx(pmctx);
+	spin_unlock_bh(&br->multicast_lock);
+}
+
+static void br_multicast_toggle_port(struct net_bridge_port *port, bool on)
+{
+#if IS_ENABLED(CONFIG_BRIDGE_VLAN_FILTERING)
+	if (br_opt_get(port->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
+		struct net_bridge_vlan_group *vg;
+		struct net_bridge_vlan *vlan;
+
+		rcu_read_lock();
+		vg = nbp_vlan_group_rcu(port);
+		if (!vg) {
+			rcu_read_unlock();
+			return;
+		}
+
+		/* iterate each vlan, toggle vlan multicast context */
+		list_for_each_entry_rcu(vlan, &vg->vlan_list, vlist) {
+			struct net_bridge_mcast_port *pmctx =
+						&vlan->port_mcast_ctx;
+			u8 state = br_vlan_get_state(vlan);
+			/* enable vlan multicast context when state is
+			 * LEARNING or FORWARDING
+			 */
+			if (on && br_vlan_state_allowed(state, true))
+				br_multicast_enable_port_ctx(pmctx);
+			else
+				br_multicast_disable_port_ctx(pmctx);
+		}
+		rcu_read_unlock();
+		return;
+	}
+#endif
+	/* toggle port multicast context when vlan snooping is disabled */
+	if (on)
+		br_multicast_enable_port_ctx(&port->multicast_ctx);
+	else
+		br_multicast_disable_port_ctx(&port->multicast_ctx);
+}
+
+void br_multicast_enable_port(struct net_bridge_port *port)
+{
+	br_multicast_toggle_port(port, true);
+}
+
 void br_multicast_disable_port(struct net_bridge_port *port)
 {
-	spin_lock_bh(&port->br->multicast_lock);
-	__br_multicast_disable_port_ctx(&port->multicast_ctx);
-	spin_unlock_bh(&port->br->multicast_lock);
+	br_multicast_toggle_port(port, false);
 }
 
 static int __grp_src_delete_marked(struct net_bridge_port_group *pg)
@@ -4211,6 +4272,32 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 #endif
 }
 
+void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state)
+{
+#if IS_ENABLED(CONFIG_BRIDGE_VLAN_FILTERING)
+	struct net_bridge *br;
+
+	if (!br_vlan_should_use(v))
+		return;
+
+	if (br_vlan_is_master(v))
+		return;
+
+	br = v->port->br;
+
+	if (!br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))
+		return;
+
+	if (br_vlan_state_allowed(state, true))
+		br_multicast_enable_port_ctx(&v->port_mcast_ctx);
+
+	/* Multicast is not disabled for the vlan when it goes in
+	 * blocking state because the timers will expire and stop by
+	 * themselves without sending more queries.
+	 */
+#endif
+}
+
 void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 {
 	struct net_bridge *br;
@@ -4304,9 +4391,9 @@ int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 		__br_multicast_open(&br->multicast_ctx);
 	list_for_each_entry(p, &br->port_list, list) {
 		if (on)
-			br_multicast_disable_port(p);
+			br_multicast_disable_port_ctx(&p->multicast_ctx);
 		else
-			br_multicast_enable_port(p);
+			br_multicast_enable_port_ctx(&p->multicast_ctx);
 	}
 
 	list_for_each_entry(vlan, &vg->vlan_list, vlist)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index df502cc1191c..6a1bce8959af 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1053,6 +1053,7 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 				struct net_bridge_vlan *vlan,
 				struct net_bridge_mcast_port *pmctx);
 void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx);
+void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state);
 void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on);
 int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 				      struct netlink_ext_ack *extack);
@@ -1503,6 +1504,11 @@ static inline void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pm
 {
 }
 
+static inline void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v,
+						      u8 state)
+{
+}
+
 static inline void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan,
 						bool on)
 {
@@ -1854,7 +1860,9 @@ bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 			      const struct net_bridge_vlan *v_opts);
 
-/* vlan state manipulation helpers using *_ONCE to annotate lock-free access */
+/* vlan state manipulation helpers using *_ONCE to annotate lock-free access,
+ * while br_vlan_set_state() may access data protected by multicast_lock.
+ */
 static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
 {
 	return READ_ONCE(v->state);
@@ -1863,6 +1871,7 @@ static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
 static inline void br_vlan_set_state(struct net_bridge_vlan *v, u8 state)
 {
 	WRITE_ONCE(v->state, state);
+	br_multicast_update_vlan_mcast_ctx(v, state);
 }
 
 static inline u8 br_vlan_get_pvid_state(const struct net_bridge_vlan_group *vg)
diff --git a/net/core/filter.c b/net/core/filter.c
index 99b23fd2f509..1c0cf6f2fff5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1980,10 +1980,11 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
 	bool is_pseudo = flags & BPF_F_PSEUDO_HDR;
 	bool is_mmzero = flags & BPF_F_MARK_MANGLED_0;
 	bool do_mforce = flags & BPF_F_MARK_ENFORCE;
+	bool is_ipv6   = flags & BPF_F_IPV6;
 	__sum16 *ptr;
 
 	if (unlikely(flags & ~(BPF_F_MARK_MANGLED_0 | BPF_F_MARK_ENFORCE |
-			       BPF_F_PSEUDO_HDR | BPF_F_HDR_FIELD_MASK)))
+			       BPF_F_PSEUDO_HDR | BPF_F_HDR_FIELD_MASK | BPF_F_IPV6)))
 		return -EINVAL;
 	if (unlikely(offset > 0xffff || offset & 1))
 		return -EFAULT;
@@ -1999,7 +2000,7 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
 		if (unlikely(from != 0))
 			return -EINVAL;
 
-		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo);
+		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, is_ipv6);
 		break;
 	case 2:
 		inet_proto_csum_replace2(ptr, skb, from, to, is_pseudo);
@@ -3249,6 +3250,13 @@ static const struct bpf_func_proto bpf_skb_vlan_pop_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
+static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
+{
+	skb->protocol = htons(proto);
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+}
+
 static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
 {
 	/* Caller already did skb_cow() with len as headroom,
@@ -3345,7 +3353,7 @@ static int bpf_skb_proto_4_to_6(struct sk_buff *skb)
 		}
 	}
 
-	skb->protocol = htons(ETH_P_IPV6);
+	bpf_skb_change_protocol(skb, ETH_P_IPV6);
 	skb_clear_hash(skb);
 
 	return 0;
@@ -3375,7 +3383,7 @@ static int bpf_skb_proto_6_to_4(struct sk_buff *skb)
 		}
 	}
 
-	skb->protocol = htons(ETH_P_IP);
+	bpf_skb_change_protocol(skb, ETH_P_IP);
 	skb_clear_hash(skb);
 
 	return 0;
@@ -3566,10 +3574,10 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 		/* Match skb->protocol to new outer l3 protocol */
 		if (skb->protocol == htons(ETH_P_IP) &&
 		    flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
-			skb->protocol = htons(ETH_P_IPV6);
+			bpf_skb_change_protocol(skb, ETH_P_IPV6);
 		else if (skb->protocol == htons(ETH_P_IPV6) &&
 			 flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
-			skb->protocol = htons(ETH_P_IP);
+			bpf_skb_change_protocol(skb, ETH_P_IP);
 	}
 
 	if (skb_is_gso(skb)) {
@@ -3622,10 +3630,10 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 	/* Match skb->protocol to new outer l3 protocol */
 	if (skb->protocol == htons(ETH_P_IP) &&
 	    flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
-		skb->protocol = htons(ETH_P_IPV6);
+		bpf_skb_change_protocol(skb, ETH_P_IPV6);
 	else if (skb->protocol == htons(ETH_P_IPV6) &&
 		 flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
-		skb->protocol = htons(ETH_P_IP);
+		bpf_skb_change_protocol(skb, ETH_P_IP);
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 0f23b3126bda..b1c3e0ad6dbf 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -829,6 +829,10 @@ static bool page_pool_napi_local(const struct page_pool *pool)
 	const struct napi_struct *napi;
 	u32 cpuid;
 
+	/* On PREEMPT_RT the softirq can be preempted by the consumer */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return false;
+
 	if (unlikely(!in_softirq()))
 		return false;
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index fdb36165c58f..cf54593149cc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6197,9 +6197,6 @@ int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len)
 	if (!pskb_may_pull(skb, write_len))
 		return -ENOMEM;
 
-	if (!skb_frags_readable(skb))
-		return -EFAULT;
-
 	if (!skb_cloned(skb) || skb_clone_writable(skb, write_len))
 		return 0;
 
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index a8d238dd982a..97f52394d1eb 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -689,7 +689,8 @@ static void sk_psock_backlog(struct work_struct *work)
 			if (ret <= 0) {
 				if (ret == -EAGAIN) {
 					sk_psock_skb_state(psock, state, len, off);
-
+					/* Restore redir info we cleared before */
+					skb_bpf_set_redir(skb, psock->sk, ingress);
 					/* Delay slightly to prioritize any
 					 * other work that might be here.
 					 */
diff --git a/net/core/sock.c b/net/core/sock.c
index 3c5386c76d6f..9c63da2829f6 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3930,7 +3930,7 @@ static int assign_proto_idx(struct proto *prot)
 {
 	prot->inuse_idx = find_first_zero_bit(proto_inuse_idx, PROTO_INUSE_NR);
 
-	if (unlikely(prot->inuse_idx == PROTO_INUSE_NR - 1)) {
+	if (unlikely(prot->inuse_idx == PROTO_INUSE_NR)) {
 		pr_err("PROTO_INUSE_NR exhausted\n");
 		return -ENOSPC;
 	}
@@ -3941,7 +3941,7 @@ static int assign_proto_idx(struct proto *prot)
 
 static void release_proto_idx(struct proto *prot)
 {
-	if (prot->inuse_idx != PROTO_INUSE_NR - 1)
+	if (prot->inuse_idx != PROTO_INUSE_NR)
 		clear_bit(prot->inuse_idx, proto_inuse_idx);
 }
 #else
diff --git a/net/core/utils.c b/net/core/utils.c
index 27f4cffaae05..b8c21a859e27 100644
--- a/net/core/utils.c
+++ b/net/core/utils.c
@@ -473,11 +473,11 @@ void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
 EXPORT_SYMBOL(inet_proto_csum_replace16);
 
 void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
-				     __wsum diff, bool pseudohdr)
+				     __wsum diff, bool pseudohdr, bool ipv6)
 {
 	if (skb->ip_summed != CHECKSUM_PARTIAL) {
 		csum_replace_by_diff(sum, diff);
-		if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr)
+		if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr && !ipv6)
 			skb->csum = ~csum_sub(diff, skb->csum);
 	} else if (pseudohdr) {
 		*sum = ~csum_fold(csum_add(diff, csum_unfold(*sum)));
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 41b320f0c20e..88d7c96bfac0 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -189,7 +189,11 @@ const __u8 ip_tos2prio[16] = {
 EXPORT_SYMBOL(ip_tos2prio);
 
 static DEFINE_PER_CPU(struct rt_cache_stat, rt_cache_stat);
+#ifndef CONFIG_PREEMPT_RT
 #define RT_CACHE_STAT_INC(field) raw_cpu_inc(rt_cache_stat.field)
+#else
+#define RT_CACHE_STAT_INC(field) this_cpu_inc(rt_cache_stat.field)
+#endif
 
 #ifdef CONFIG_PROC_FS
 static void *rt_cache_seq_start(struct seq_file *seq, loff_t *pos)
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 32b28fc21b63..408985eb74ee 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -3,6 +3,7 @@
 #include <linux/tcp.h>
 #include <linux/rcupdate.h>
 #include <net/tcp.h>
+#include <net/busy_poll.h>
 
 void tcp_fastopen_init_key_once(struct net *net)
 {
@@ -279,6 +280,8 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 
 	refcount_set(&req->rsk_refcnt, 2);
 
+	sk_mark_napi_id_set(child, skb);
+
 	/* Now finish processing the fastopen child socket. */
 	tcp_init_transfer(child, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, skb);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d29219e067b7..d176e7888a20 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -665,10 +665,12 @@ EXPORT_SYMBOL(tcp_initialize_rcv_mss);
  */
 static void tcp_rcv_rtt_update(struct tcp_sock *tp, u32 sample, int win_dep)
 {
-	u32 new_sample = tp->rcv_rtt_est.rtt_us;
-	long m = sample;
+	u32 new_sample, old_sample = tp->rcv_rtt_est.rtt_us;
+	long m = sample << 3;
 
-	if (new_sample != 0) {
+	if (old_sample == 0 || m < old_sample) {
+		new_sample = m;
+	} else {
 		/* If we sample in larger samples in the non-timestamp
 		 * case, we could grossly overestimate the RTT especially
 		 * with chatty applications or bulk transfer apps which
@@ -679,17 +681,9 @@ static void tcp_rcv_rtt_update(struct tcp_sock *tp, u32 sample, int win_dep)
 		 * else with timestamps disabled convergence takes too
 		 * long.
 		 */
-		if (!win_dep) {
-			m -= (new_sample >> 3);
-			new_sample += m;
-		} else {
-			m <<= 3;
-			if (m < new_sample)
-				new_sample = m;
-		}
-	} else {
-		/* No previous measure. */
-		new_sample = m << 3;
+		if (win_dep)
+			return;
+		new_sample = old_sample - (old_sample >> 3) + sample;
 	}
 
 	tp->rcv_rtt_est.rtt_us = new_sample;
@@ -713,7 +707,7 @@ static inline void tcp_rcv_rtt_measure(struct tcp_sock *tp)
 	tp->rcv_rtt_est.time = tp->tcp_mstamp;
 }
 
-static s32 tcp_rtt_tsopt_us(const struct tcp_sock *tp)
+static s32 tcp_rtt_tsopt_us(const struct tcp_sock *tp, u32 min_delta)
 {
 	u32 delta, delta_us;
 
@@ -723,7 +717,7 @@ static s32 tcp_rtt_tsopt_us(const struct tcp_sock *tp)
 
 	if (likely(delta < INT_MAX / (USEC_PER_SEC / TCP_TS_HZ))) {
 		if (!delta)
-			delta = 1;
+			delta = min_delta;
 		delta_us = delta * (USEC_PER_SEC / TCP_TS_HZ);
 		return delta_us;
 	}
@@ -741,9 +735,9 @@ static inline void tcp_rcv_rtt_measure_ts(struct sock *sk,
 
 	if (TCP_SKB_CB(skb)->end_seq -
 	    TCP_SKB_CB(skb)->seq >= inet_csk(sk)->icsk_ack.rcv_mss) {
-		s32 delta = tcp_rtt_tsopt_us(tp);
+		s32 delta = tcp_rtt_tsopt_us(tp, 0);
 
-		if (delta >= 0)
+		if (delta > 0)
 			tcp_rcv_rtt_update(tp, delta, 0);
 	}
 }
@@ -755,8 +749,7 @@ static inline void tcp_rcv_rtt_measure_ts(struct sock *sk,
 void tcp_rcv_space_adjust(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 copied;
-	int time;
+	int time, inq, copied;
 
 	trace_tcp_rcv_space_adjust(sk);
 
@@ -767,6 +760,9 @@ void tcp_rcv_space_adjust(struct sock *sk)
 
 	/* Number of bytes copied to user in last RTT */
 	copied = tp->copied_seq - tp->rcvq_space.seq;
+	/* Number of bytes in receive queue. */
+	inq = tp->rcv_nxt - tp->copied_seq;
+	copied -= inq;
 	if (copied <= tp->rcvq_space.space)
 		goto new_measure;
 
@@ -2486,20 +2482,33 @@ static inline bool tcp_packet_delayed(const struct tcp_sock *tp)
 {
 	const struct sock *sk = (const struct sock *)tp;
 
-	if (tp->retrans_stamp &&
-	    tcp_tsopt_ecr_before(tp, tp->retrans_stamp))
-		return true;  /* got echoed TS before first retransmission */
+	/* Received an echoed timestamp before the first retransmission? */
+	if (tp->retrans_stamp)
+		return tcp_tsopt_ecr_before(tp, tp->retrans_stamp);
+
+	/* We set tp->retrans_stamp upon the first retransmission of a loss
+	 * recovery episode, so normally if tp->retrans_stamp is 0 then no
+	 * retransmission has happened yet (likely due to TSQ, which can cause
+	 * fast retransmits to be delayed). So if snd_una advanced while
+	 * (tp->retrans_stamp is 0 then apparently a packet was merely delayed,
+	 * not lost. But there are exceptions where we retransmit but then
+	 * clear tp->retrans_stamp, so we check for those exceptions.
+	 */
 
-	/* Check if nothing was retransmitted (retrans_stamp==0), which may
-	 * happen in fast recovery due to TSQ. But we ignore zero retrans_stamp
-	 * in TCP_SYN_SENT, since when we set FLAG_SYN_ACKED we also clear
-	 * retrans_stamp even if we had retransmitted the SYN.
+	/* (1) For non-SACK connections, tcp_is_non_sack_preventing_reopen()
+	 * clears tp->retrans_stamp when snd_una == high_seq.
 	 */
-	if (!tp->retrans_stamp &&	   /* no record of a retransmit/SYN? */
-	    sk->sk_state != TCP_SYN_SENT)  /* not the FLAG_SYN_ACKED case? */
-		return true;  /* nothing was retransmitted */
+	if (!tcp_is_sack(tp) && !before(tp->snd_una, tp->high_seq))
+		return false;
 
-	return false;
+	/* (2) In TCP_SYN_SENT tcp_clean_rtx_queue() clears tp->retrans_stamp
+	 * when setting FLAG_SYN_ACKED is set, even if the SYN was
+	 * retransmitted.
+	 */
+	if (sk->sk_state == TCP_SYN_SENT)
+		return false;
+
+	return true;	/* tp->retrans_stamp is zero; no retransmit yet */
 }
 
 /* Undo procedures. */
@@ -3226,7 +3235,7 @@ static bool tcp_ack_update_rtt(struct sock *sk, const int flag,
 	 */
 	if (seq_rtt_us < 0 && tp->rx_opt.saw_tstamp &&
 	    tp->rx_opt.rcv_tsecr && flag & FLAG_ACKED)
-		seq_rtt_us = ca_rtt_us = tcp_rtt_tsopt_us(tp);
+		seq_rtt_us = ca_rtt_us = tcp_rtt_tsopt_us(tp, 1);
 
 	rs->rtt_us = ca_rtt_us; /* RTT of last (S)ACKed packet (or -1) */
 	if (seq_rtt_us < 0)
@@ -6841,6 +6850,9 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (!tp->srtt_us)
 			tcp_synack_rtt_meas(sk, req);
 
+		if (tp->rx_opt.tstamp_ok)
+			tp->advmss -= TCPOLEN_TSTAMP_ALIGNED;
+
 		if (req) {
 			tcp_rcv_synrecv_state_fastopen(sk);
 		} else {
@@ -6866,9 +6878,6 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		tp->snd_wnd = ntohs(th->window) << tp->rx_opt.snd_wscale;
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 
-		if (tp->rx_opt.tstamp_ok)
-			tp->advmss -= TCPOLEN_TSTAMP_ALIGNED;
-
 		if (!inet_csk(sk)->icsk_ca_ops->cong_control)
 			tcp_update_pacing_rate(sk);
 
diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index 62618a058b8f..a247bb93908b 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1207,6 +1207,10 @@ static int calipso_req_setattr(struct request_sock *req,
 	struct ipv6_opt_hdr *old, *new;
 	struct sock *sk = sk_to_full_sk(req_to_sk(req));
 
+	/* sk is NULL for SYN+ACK w/ SYN Cookie */
+	if (!sk)
+		return -ENOMEM;
+
 	if (req_inet->ipv6_opt && req_inet->ipv6_opt->hopopt)
 		old = req_inet->ipv6_opt->hopopt;
 	else
@@ -1247,6 +1251,10 @@ static void calipso_req_delattr(struct request_sock *req)
 	struct ipv6_txoptions *txopts;
 	struct sock *sk = sk_to_full_sk(req_to_sk(req));
 
+	/* sk is NULL for SYN+ACK w/ SYN Cookie */
+	if (!sk)
+		return;
+
 	if (!req_inet->ipv6_opt || !req_inet->ipv6_opt->hopopt)
 		return;
 
diff --git a/net/ipv6/ila/ila_common.c b/net/ipv6/ila/ila_common.c
index 95e9146918cc..b8d43ed4689d 100644
--- a/net/ipv6/ila/ila_common.c
+++ b/net/ipv6/ila/ila_common.c
@@ -86,7 +86,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&th->check, skb,
-							diff, true);
+							diff, true, true);
 		}
 		break;
 	case NEXTHDR_UDP:
@@ -97,7 +97,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
 				diff = get_csum_diff(ip6h, p);
 				inet_proto_csum_replace_by_diff(&uh->check, skb,
-								diff, true);
+								diff, true, true);
 				if (!uh->check)
 					uh->check = CSUM_MANGLED_0;
 			}
@@ -111,7 +111,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&ih->icmp6_cksum, skb,
-							diff, true);
+							diff, true, true);
 		}
 		break;
 	}
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 89a61e040e6a..f0e5431c2d46 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -2043,8 +2043,6 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 		ip6_cork_release(cork, &v6_cork);
 		return ERR_PTR(err);
 	}
-	if (ipc6->dontfrag < 0)
-		ipc6->dontfrag = inet6_test_bit(DONTFRAG, sk);
 
 	err = __ip6_append_data(sk, &queue, cork, &v6_cork,
 				&current->task_frag, getfrag, from,
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 608fa9d05b55..328419e05c81 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -777,7 +777,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	fl6.flowi6_mark = READ_ONCE(sk->sk_mark);
 	fl6.flowi6_uid = sk->sk_uid;
 
-	ipcm6_init(&ipc6);
+	ipcm6_init_sk(&ipc6, sk);
 	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = fl6.flowi6_mark;
 
@@ -890,9 +890,6 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (hdrincl)
 		fl6.flowi6_flags |= FLOWI_FLAG_KNOWN_NH;
 
-	if (ipc6.tclass < 0)
-		ipc6.tclass = np->tclass;
-
 	fl6.flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6.flowlabel);
 
 	dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl6, final_p);
@@ -903,9 +900,6 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (ipc6.hlimit < 0)
 		ipc6.hlimit = ip6_sk_dst_hoplimit(np, &fl6, dst);
 
-	if (ipc6.dontfrag < 0)
-		ipc6.dontfrag = inet6_test_bit(DONTFRAG, sk);
-
 	if (msg->msg_flags&MSG_CONFIRM)
 		goto do_confirm;
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 197d0ac47592..57e38e5e4be9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1399,7 +1399,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int is_udplite = IS_UDPLITE(sk);
 	int (*getfrag)(void *, char *, int, int, int, struct sk_buff *);
 
-	ipcm6_init(&ipc6);
+	ipcm6_init_sk(&ipc6, sk);
 	ipc6.gso_size = READ_ONCE(up->gso_size);
 	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
@@ -1608,9 +1608,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
-	if (ipc6.tclass < 0)
-		ipc6.tclass = np->tclass;
-
 	fl6->flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6->flowlabel);
 
 	dst = ip6_sk_dst_lookup_flow(sk, fl6, final_p, connected);
@@ -1656,8 +1653,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	WRITE_ONCE(up->pending, AF_INET6);
 
 do_append_data:
-	if (ipc6.dontfrag < 0)
-		ipc6.dontfrag = inet6_test_bit(DONTFRAG, sk);
 	up->len += ulen;
 	err = ip6_append_data(sk, getfrag, msg, ulen, sizeof(struct udphdr),
 			      &ipc6, fl6, dst_rt6_info(dst),
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index f4c1da070826..b98d13584c81 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -547,7 +547,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	fl6.flowi6_mark = READ_ONCE(sk->sk_mark);
 	fl6.flowi6_uid = sk->sk_uid;
 
-	ipcm6_init(&ipc6);
+	ipcm6_init_sk(&ipc6, sk);
 
 	if (lsa) {
 		if (addr_len < SIN6_LEN_RFC2133)
@@ -634,9 +634,6 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(&fl6));
 
-	if (ipc6.tclass < 0)
-		ipc6.tclass = np->tclass;
-
 	fl6.flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6.flowlabel);
 
 	dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl6, final_p);
@@ -648,9 +645,6 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (ipc6.hlimit < 0)
 		ipc6.hlimit = ip6_sk_dst_hoplimit(np, &fl6, dst);
 
-	if (ipc6.dontfrag < 0)
-		ipc6.dontfrag = inet6_test_bit(DONTFRAG, sk);
-
 	if (msg->msg_flags & MSG_CONFIRM)
 		goto do_confirm;
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f11fd360b422..cf2b8a05c338 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2876,7 +2876,7 @@ static int ieee80211_scan(struct wiphy *wiphy,
 		 * the frames sent while scanning on other channel will be
 		 * lost)
 		 */
-		if (sdata->deflink.u.ap.beacon &&
+		if (ieee80211_num_beaconing_links(sdata) &&
 		    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
 		     !(req->flags & NL80211_SCAN_FLAG_AP)))
 			return -EOPNOTSUPP;
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 1e9389c49a57..e6f937cfedcf 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -152,12 +152,6 @@ static ssize_t sta_aqm_read(struct file *file, char __user *userbuf,
 	spin_lock_bh(&local->fq.lock);
 	rcu_read_lock();
 
-	p += scnprintf(p,
-		       bufsz + buf - p,
-		       "target %uus interval %uus ecn %s\n",
-		       codel_time_to_us(sta->cparams.target),
-		       codel_time_to_us(sta->cparams.interval),
-		       sta->cparams.ecn ? "yes" : "no");
 	p += scnprintf(p,
 		       bufsz + buf - p,
 		       "tid ac backlog-bytes backlog-packets new-flows drops marks overlimit collisions tx-bytes tx-packets flags\n");
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 2922a9fec950..ba8aeb47bffd 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -636,7 +636,7 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 				mesh_path_add_gate(mpath);
 		}
 		rcu_read_unlock();
-	} else {
+	} else if (ifmsh->mshcfg.dot11MeshForwarding) {
 		rcu_read_lock();
 		mpath = mesh_path_lookup(sdata, target_addr);
 		if (mpath) {
@@ -654,6 +654,8 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 			}
 		}
 		rcu_read_unlock();
+	} else {
+		forward = false;
 	}
 
 	if (reply) {
@@ -671,7 +673,7 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	if (forward && ifmsh->mshcfg.dot11MeshForwarding) {
+	if (forward) {
 		u32 preq_id;
 		u8 hopcount;
 
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 3dc9752188d5..1b045b62961f 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -971,8 +971,6 @@ int rate_control_set_rates(struct ieee80211_hw *hw,
 	if (sta->uploaded)
 		drv_sta_rate_tbl_update(hw_to_local(hw), sta->sdata, pubsta);
 
-	ieee80211_sta_set_expected_throughput(pubsta, sta_get_expected_throughput(sta));
-
 	return 0;
 }
 EXPORT_SYMBOL(rate_control_set_rates);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 49095f19a0f2..4eb45e08b97e 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -18,7 +18,6 @@
 #include <linux/timer.h>
 #include <linux/rtnetlink.h>
 
-#include <net/codel.h>
 #include <net/mac80211.h>
 #include "ieee80211_i.h"
 #include "driver-ops.h"
@@ -683,12 +682,6 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	sta->cparams.ce_threshold = CODEL_DISABLED_THRESHOLD;
-	sta->cparams.target = MS2TIME(20);
-	sta->cparams.interval = MS2TIME(100);
-	sta->cparams.ecn = true;
-	sta->cparams.ce_threshold_selector = 0;
-	sta->cparams.ce_threshold_mask = 0;
 
 	sta_dbg(sdata, "Allocated STA %pM\n", sta->sta.addr);
 
@@ -2878,27 +2871,6 @@ unsigned long ieee80211_sta_last_active(struct sta_info *sta)
 	return sta->deflink.status_stats.last_ack;
 }
 
-static void sta_update_codel_params(struct sta_info *sta, u32 thr)
-{
-	if (thr && thr < STA_SLOW_THRESHOLD * sta->local->num_sta) {
-		sta->cparams.target = MS2TIME(50);
-		sta->cparams.interval = MS2TIME(300);
-		sta->cparams.ecn = false;
-	} else {
-		sta->cparams.target = MS2TIME(20);
-		sta->cparams.interval = MS2TIME(100);
-		sta->cparams.ecn = true;
-	}
-}
-
-void ieee80211_sta_set_expected_throughput(struct ieee80211_sta *pubsta,
-					   u32 thr)
-{
-	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
-
-	sta_update_codel_params(sta, thr);
-}
-
 int ieee80211_sta_allocate_link(struct sta_info *sta, unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 9195d5a2de0a..a9cfeeb13e53 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -466,14 +466,6 @@ struct ieee80211_fragment_cache {
 	unsigned int next;
 };
 
-/*
- * The bandwidth threshold below which the per-station CoDel parameters will be
- * scaled to be more lenient (to prevent starvation of slow stations). This
- * value will be scaled by the number of active stations when it is being
- * applied.
- */
-#define STA_SLOW_THRESHOLD 6000 /* 6 Mbps */
-
 /**
  * struct link_sta_info - Link STA information
  * All link specific sta info are stored here for reference. This can be
@@ -619,7 +611,6 @@ struct link_sta_info {
  * @sta: station information we share with the driver
  * @sta_state: duplicates information about station state (for debug)
  * @rcu_head: RCU head used for freeing this station struct
- * @cparams: CoDel parameters for this station.
  * @reserved_tid: reserved TID (if any, otherwise IEEE80211_TID_UNRESERVED)
  * @amsdu_mesh_control: track the mesh A-MSDU format used by the peer:
  *
@@ -710,8 +701,6 @@ struct sta_info {
 	struct dentry *debugfs_dir;
 #endif
 
-	struct codel_params cparams;
-
 	u8 reserved_tid;
 	s8 amsdu_mesh_control;
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0ff8b56f5807..00c309e7768e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1401,16 +1401,9 @@ static struct sk_buff *fq_tin_dequeue_func(struct fq *fq,
 
 	local = container_of(fq, struct ieee80211_local, fq);
 	txqi = container_of(tin, struct txq_info, tin);
+	cparams = &local->cparams;
 	cstats = &txqi->cstats;
 
-	if (txqi->txq.sta) {
-		struct sta_info *sta = container_of(txqi->txq.sta,
-						    struct sta_info, sta);
-		cparams = &sta->cparams;
-	} else {
-		cparams = &local->cparams;
-	}
-
 	if (flow == &tin->default_flow)
 		cvars = &txqi->def_cvars;
 	else
@@ -4523,8 +4516,10 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
 						     IEEE80211_TX_CTRL_MLO_LINK_UNSPEC,
 						     NULL);
 	} else if (ieee80211_vif_is_mld(&sdata->vif) &&
-		   sdata->vif.type == NL80211_IFTYPE_AP &&
-		   !ieee80211_hw_check(&sdata->local->hw, MLO_MCAST_MULTI_LINK_TX)) {
+		   ((sdata->vif.type == NL80211_IFTYPE_AP &&
+		     !ieee80211_hw_check(&sdata->local->hw, MLO_MCAST_MULTI_LINK_TX)) ||
+		    (sdata->vif.type == NL80211_IFTYPE_AP_VLAN &&
+		     !sdata->wdev.use_4addr))) {
 		ieee80211_mlo_multicast_tx(dev, skb);
 	} else {
 normal:
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index df62638b6498..3373b6b34dc7 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -81,8 +81,8 @@ static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned index)
 
 	if (index < net->mpls.platform_labels) {
 		struct mpls_route __rcu **platform_label =
-			rcu_dereference(net->mpls.platform_label);
-		rt = rcu_dereference(platform_label[index]);
+			rcu_dereference_rtnl(net->mpls.platform_label);
+		rt = rcu_dereference_rtnl(platform_label[index]);
 	}
 	return rt;
 }
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 0529e4ef7520..c5855069bdab 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -663,6 +663,9 @@ static int pipapo_realloc_mt(struct nft_pipapo_field *f,
 	    check_add_overflow(rules, extra, &rules_alloc))
 		return -EOVERFLOW;
 
+	if (rules_alloc > (INT_MAX / sizeof(*new_mt)))
+		return -ENOMEM;
+
 	new_mt = kvmalloc_array(rules_alloc, sizeof(*new_mt), GFP_KERNEL_ACCOUNT);
 	if (!new_mt)
 		return -ENOMEM;
@@ -1499,6 +1502,9 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		       src->groups * NFT_PIPAPO_BUCKETS(src->bb));
 
 		if (src->rules > 0) {
+			if (src->rules_alloc > (INT_MAX / sizeof(*src->mt)))
+				goto out_mt;
+
 			dst->mt = kvmalloc_array(src->rules_alloc,
 						 sizeof(*src->mt),
 						 GFP_KERNEL_ACCOUNT);
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index ed1508a9e093..aab107727f18 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -119,22 +119,22 @@ static int nci_uart_set_driver(struct tty_struct *tty, unsigned int driver)
 
 	memcpy(nu, nci_uart_drivers[driver], sizeof(struct nci_uart));
 	nu->tty = tty;
-	tty->disc_data = nu;
 	skb_queue_head_init(&nu->tx_q);
 	INIT_WORK(&nu->write_work, nci_uart_write_work);
 	spin_lock_init(&nu->rx_lock);
 
 	ret = nu->ops.open(nu);
 	if (ret) {
-		tty->disc_data = NULL;
 		kfree(nu);
+		return ret;
 	} else if (!try_module_get(nu->owner)) {
 		nu->ops.close(nu);
-		tty->disc_data = NULL;
 		kfree(nu);
 		return -ENOENT;
 	}
-	return ret;
+	tty->disc_data = nu;
+
+	return 0;
 }
 
 /* ------ LDISC part ------ */
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index a903b3c46805..11a7d5a25d6b 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -656,6 +656,14 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
 		return -EINVAL;
 	}
+
+	if (ctl->perturb_period < 0 ||
+	    ctl->perturb_period > INT_MAX / HZ) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid perturb period");
+		return -EINVAL;
+	}
+	perturb_period = ctl->perturb_period * HZ;
+
 	if (ctl_v1 && !red_check_params(ctl_v1->qth_min, ctl_v1->qth_max,
 					ctl_v1->Wlog, ctl_v1->Scell_log, NULL))
 		return -EINVAL;
@@ -672,14 +680,12 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 	headdrop = q->headdrop;
 	maxdepth = q->maxdepth;
 	maxflows = q->maxflows;
-	perturb_period = q->perturb_period;
 	quantum = q->quantum;
 	flags = q->flags;
 
 	/* update and validate configuration */
 	if (ctl->quantum)
 		quantum = ctl->quantum;
-	perturb_period = ctl->perturb_period * HZ;
 	if (ctl->flows)
 		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 8623dc0bafc0..3142715d7e41 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1328,13 +1328,15 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
 
 		stab = rtnl_dereference(q->root->stab);
 
-		oper = rtnl_dereference(q->oper_sched);
+		rcu_read_lock();
+		oper = rcu_dereference(q->oper_sched);
 		if (oper)
 			taprio_update_queue_max_sdu(q, oper, stab);
 
-		admin = rtnl_dereference(q->admin_sched);
+		admin = rcu_dereference(q->admin_sched);
 		if (admin)
 			taprio_update_queue_max_sdu(q, admin, stab);
+		rcu_read_unlock();
 
 		break;
 	}
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 53725ee7ba06..b301d64d9d80 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9100,7 +9100,8 @@ static void __sctp_write_space(struct sctp_association *asoc)
 		wq = rcu_dereference(sk->sk_wq);
 		if (wq) {
 			if (waitqueue_active(&wq->wait))
-				wake_up_interruptible(&wq->wait);
+				wake_up_interruptible_poll(&wq->wait, EPOLLOUT |
+						EPOLLWRNORM | EPOLLWRBAND);
 
 			/* Note that we try to include the Async I/O support
 			 * here by modeling from the current TCP/UDP code.
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 79879b7d39cb..46a95877d2de 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1369,7 +1369,8 @@ svc_process_common(struct svc_rqst *rqstp)
 	case SVC_OK:
 		break;
 	case SVC_GARBAGE:
-		goto err_garbage_args;
+		rqstp->rq_auth_stat = rpc_autherr_badcred;
+		goto err_bad_auth;
 	case SVC_SYSERR:
 		goto err_system_err;
 	case SVC_DENIED:
@@ -1510,14 +1511,6 @@ svc_process_common(struct svc_rqst *rqstp)
 	*rqstp->rq_accept_statp = rpc_proc_unavail;
 	goto sendit;
 
-err_garbage_args:
-	svc_printk(rqstp, "failed to decode RPC header\n");
-
-	if (serv->sv_stats)
-		serv->sv_stats->rpcbadfmt++;
-	*rqstp->rq_accept_statp = rpc_garbage_args;
-	goto sendit;
-
 err_system_err:
 	if (serv->sv_stats)
 		serv->sv_stats->rpcbadfmt++;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index ca6172822b68..3d7f1413df02 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -577,6 +577,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	if (newxprt->sc_qp && !IS_ERR(newxprt->sc_qp))
 		ib_destroy_qp(newxprt->sc_qp);
 	rdma_destroy_id(newxprt->sc_cm_id);
+	rpcrdma_rn_unregister(dev, &newxprt->sc_rn);
 	/* This call to put will destroy the transport */
 	svc_xprt_put(&newxprt->sc_xprt);
 	return NULL;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 171ad4e2523f..67d099c7c662 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2743,6 +2743,11 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 	}
 	rpc_shutdown_client(lower_clnt);
 
+	/* Check for ingress data that arrived before the socket's
+	 * ->data_ready callback was set up.
+	 */
+	xs_poll_check_readable(upper_transport);
+
 out_unlock:
 	current_restore_flags(pflags, PF_MEMALLOC);
 	upper_transport->clnt = NULL;
diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 79f91b6ca8c8..ea5bb131ebd0 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -425,7 +425,7 @@ static void tipc_aead_free(struct rcu_head *rp)
 	}
 	free_percpu(aead->tfm_entry);
 	kfree_sensitive(aead->key);
-	kfree(aead);
+	kfree_sensitive(aead);
 }
 
 static int tipc_aead_users(struct tipc_aead __rcu *aead)
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 108a4cc2e001..258d6aa4f21a 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -489,7 +489,7 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struct netlink_callback *cb)
 
 		rtnl_lock();
 		b = tipc_bearer_find(net, bname);
-		if (!b) {
+		if (!b || b->bcast_addr.media_id != TIPC_MEDIA_TYPE_UDP) {
 			rtnl_unlock();
 			return -EINVAL;
 		}
@@ -500,7 +500,7 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struct netlink_callback *cb)
 
 		rtnl_lock();
 		b = rtnl_dereference(tn->bearer_list[bid]);
-		if (!b) {
+		if (!b || b->bcast_addr.media_id != TIPC_MEDIA_TYPE_UDP) {
 			rtnl_unlock();
 			return -EINVAL;
 		}
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 1ce8fff2a28a..586e50678ed8 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -553,6 +553,9 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	INIT_WORK(&rdev->mgmt_registrations_update_wk,
 		  cfg80211_mgmt_registrations_update_wk);
 	spin_lock_init(&rdev->mgmt_registrations_lock);
+	INIT_WORK(&rdev->wiphy_work, cfg80211_wiphy_work);
+	INIT_LIST_HEAD(&rdev->wiphy_work_list);
+	spin_lock_init(&rdev->wiphy_work_lock);
 
 #ifdef CONFIG_CFG80211_DEFAULT_PS
 	rdev->wiphy.flags |= WIPHY_FLAG_PS_ON_BY_DEFAULT;
@@ -570,9 +573,6 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 		return NULL;
 	}
 
-	INIT_WORK(&rdev->wiphy_work, cfg80211_wiphy_work);
-	INIT_LIST_HEAD(&rdev->wiphy_work_list);
-	spin_lock_init(&rdev->wiphy_work_lock);
 	INIT_WORK(&rdev->rfkill_block, cfg80211_rfkill_block_work);
 	INIT_WORK(&rdev->conn_work, cfg80211_conn_work);
 	INIT_WORK(&rdev->event_work, cfg80211_event_work);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index da2a1c00ca8a..d41e5642625e 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -178,11 +178,27 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 				       "Replay seq and seq_hi should be 0 for output SA");
 			return -EINVAL;
 		}
-		if (rs->oseq_hi && !(p->flags & XFRM_STATE_ESN)) {
-			NL_SET_ERR_MSG(
-				extack,
-				"Replay oseq_hi should be 0 in non-ESN mode for output SA");
-			return -EINVAL;
+
+		if (!(p->flags & XFRM_STATE_ESN)) {
+			if (rs->oseq_hi) {
+				NL_SET_ERR_MSG(
+					extack,
+					"Replay oseq_hi should be 0 in non-ESN mode for output SA");
+				return -EINVAL;
+			}
+			if (rs->oseq == U32_MAX) {
+				NL_SET_ERR_MSG(
+					extack,
+					"Replay oseq should be less than 0xFFFFFFFF in non-ESN mode for output SA");
+				return -EINVAL;
+			}
+		} else {
+			if (rs->oseq == U32_MAX && rs->oseq_hi == U32_MAX) {
+				NL_SET_ERR_MSG(
+					extack,
+					"Replay oseq and oseq_hi should be less than 0xFFFFFFFF for output SA");
+				return -EINVAL;
+			}
 		}
 		if (rs->bmp_len) {
 			NL_SET_ERR_MSG(extack, "Replay bmp_len should 0 for output SA");
@@ -196,11 +212,27 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 				       "Replay oseq and oseq_hi should be 0 for input SA");
 			return -EINVAL;
 		}
-		if (rs->seq_hi && !(p->flags & XFRM_STATE_ESN)) {
-			NL_SET_ERR_MSG(
-				extack,
-				"Replay seq_hi should be 0 in non-ESN mode for input SA");
-			return -EINVAL;
+		if (!(p->flags & XFRM_STATE_ESN)) {
+			if (rs->seq_hi) {
+				NL_SET_ERR_MSG(
+					extack,
+					"Replay seq_hi should be 0 in non-ESN mode for input SA");
+				return -EINVAL;
+			}
+
+			if (rs->seq == U32_MAX) {
+				NL_SET_ERR_MSG(
+					extack,
+					"Replay seq should be less than 0xFFFFFFFF in non-ESN mode for input SA");
+				return -EINVAL;
+			}
+		} else {
+			if (rs->seq == U32_MAX && rs->seq_hi == U32_MAX) {
+				NL_SET_ERR_MSG(
+					extack,
+					"Replay seq and seq_hi should be less than 0xFFFFFFFF for input SA");
+				return -EINVAL;
+			}
 		}
 	}
 
diff --git a/rust/Makefile b/rust/Makefile
index 1b00e16951ee..93650b2ee7d5 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -53,6 +53,8 @@ endif
 core-cfgs = \
     --cfg no_fp_fmt_parse
 
+core-edition := $(if $(call rustc-min-version,108700),2024,2021)
+
 quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
       cmd_rustdoc = \
 	OBJTREE=$(abspath $(objtree)) \
@@ -95,8 +97,8 @@ rustdoc-macros: $(src)/macros/lib.rs FORCE
 
 # Starting with Rust 1.82.0, skipping `-Wrustdoc::unescaped_backticks` should
 # not be needed -- see https://github.com/rust-lang/rust/pull/128307.
-rustdoc-core: private skip_flags = -Wrustdoc::unescaped_backticks
-rustdoc-core: private rustc_target_flags = $(core-cfgs)
+rustdoc-core: private skip_flags = --edition=2021 -Wrustdoc::unescaped_backticks
+rustdoc-core: private rustc_target_flags = --edition=$(core-edition) $(core-cfgs)
 rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
 	+$(call if_changed,rustdoc)
 
@@ -372,7 +374,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
       cmd_rustc_library = \
 	OBJTREE=$(abspath $(objtree)) \
 	$(if $(skip_clippy),$(RUSTC),$(RUSTC_OR_CLIPPY)) \
-		$(filter-out $(skip_flags),$(rust_flags) $(rustc_target_flags)) \
+		$(filter-out $(skip_flags),$(rust_flags)) $(rustc_target_flags) \
 		--emit=dep-info=$(depfile) --emit=obj=$@ \
 		--emit=metadata=$(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \
 		--crate-type rlib -L$(objtree)/$(obj) \
@@ -383,7 +385,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 
 rust-analyzer:
 	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
-		--cfgs='core=$(core-cfgs)' \
+		--cfgs='core=$(core-cfgs)' $(core-edition) \
 		$(realpath $(srctree)) $(realpath $(objtree)) \
 		$(rustc_sysroot) $(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
 		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
@@ -407,9 +409,9 @@ define rule_rustc_library
 endef
 
 $(obj)/core.o: private skip_clippy = 1
-$(obj)/core.o: private skip_flags = -Wunreachable_pub
+$(obj)/core.o: private skip_flags = --edition=2021 -Wunreachable_pub
 $(obj)/core.o: private rustc_objcopy = $(foreach sym,$(redirect-intrinsics),--redefine-sym $(sym)=__rust$(sym))
-$(obj)/core.o: private rustc_target_flags = $(core-cfgs)
+$(obj)/core.o: private rustc_target_flags = --edition=$(core-edition) $(core-cfgs)
 $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs \
     $(wildcard $(objtree)/include/config/RUSTC_VERSION_TEXT) FORCE
 	+$(call if_changed_rule,rustc_library)
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index c6cd729b65cb..638e1e729986 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -43,7 +43,7 @@ as-instr = $(call try-run,\
 # __cc-option
 # Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)
 __cc-option = $(call try-run,\
-	$(1) -Werror $(2) $(3) -c -x c /dev/null -o "$$TMP",$(3),$(4))
+	$(1) -Werror $(2) $(3:-Wno-%=-W%) -c -x c /dev/null -o "$$TMP",$(3),$(4))
 
 # cc-option
 # Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
@@ -57,7 +57,7 @@ cc-option-yn = $(if $(call cc-option,$1),y,n)
 
 # cc-disable-warning
 # Usage: cflags-y += $(call cc-disable-warning,unused-but-set-variable)
-cc-disable-warning = $(if $(call cc-option,-W$(strip $1)),-Wno-$(strip $1))
+cc-disable-warning = $(call cc-option,-Wno-$(strip $1))
 
 # gcc-min-version
 # Usage: cflags-$(call gcc-min-version, 70100) += -foo
@@ -67,6 +67,10 @@ gcc-min-version = $(call test-ge, $(CONFIG_GCC_VERSION), $1)
 # Usage: cflags-$(call clang-min-version, 110000) += -foo
 clang-min-version = $(call test-ge, $(CONFIG_CLANG_VERSION), $1)
 
+# rustc-min-version
+# Usage: rustc-$(call rustc-min-version, 108500) += -Cfoo
+rustc-min-version = $(call test-ge, $(CONFIG_RUSTC_VERSION), $1)
+
 # ld-option
 # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
 ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 690f9830f064..f9c9a2117632 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -18,7 +18,7 @@ def args_crates_cfgs(cfgs):
 
     return crates_cfgs
 
-def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
+def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edition):
     # Generate the configuration list.
     cfg = []
     with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
@@ -34,7 +34,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     crates_indexes = {}
     crates_cfgs = args_crates_cfgs(cfgs)
 
-    def append_crate(display_name, root_module, deps, cfg=[], is_workspace_member=True, is_proc_macro=False):
+    def append_crate(display_name, root_module, deps, cfg=[], is_workspace_member=True, is_proc_macro=False, edition="2021"):
         crates_indexes[display_name] = len(crates)
         crates.append({
             "display_name": display_name,
@@ -43,7 +43,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
             "is_proc_macro": is_proc_macro,
             "deps": [{"crate": crates_indexes[dep], "name": dep} for dep in deps],
             "cfg": cfg,
-            "edition": "2021",
+            "edition": edition,
             "env": {
                 "RUST_MODFILE": "This is only for rust-analyzer"
             }
@@ -53,6 +53,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
         display_name,
         deps,
         cfg=[],
+        edition="2021",
     ):
         append_crate(
             display_name,
@@ -60,12 +61,13 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
             deps,
             cfg,
             is_workspace_member=False,
+            edition=edition,
         )
 
     # NB: sysroot crates reexport items from one another so setting up our transitive dependencies
     # here is important for ensuring that rust-analyzer can resolve symbols. The sources of truth
     # for this dependency graph are `(sysroot_src / crate / "Cargo.toml" for crate in crates)`.
-    append_sysroot_crate("core", [], cfg=crates_cfgs.get("core", []))
+    append_sysroot_crate("core", [], cfg=crates_cfgs.get("core", []), edition=core_edition)
     append_sysroot_crate("alloc", ["core"])
     append_sysroot_crate("std", ["alloc", "core"])
     append_sysroot_crate("proc_macro", ["core", "std"])
@@ -155,6 +157,7 @@ def main():
     parser = argparse.ArgumentParser()
     parser.add_argument('--verbose', '-v', action='store_true')
     parser.add_argument('--cfgs', action='append', default=[])
+    parser.add_argument("core_edition")
     parser.add_argument("srctree", type=pathlib.Path)
     parser.add_argument("objtree", type=pathlib.Path)
     parser.add_argument("sysroot", type=pathlib.Path)
@@ -171,7 +174,7 @@ def main():
     assert args.sysroot in args.sysroot_src.parents
 
     rust_project = {
-        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree, args.cfgs),
+        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree, args.cfgs, args.core_edition),
         "sysroot": str(args.sysroot),
     }
 
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 90ec4ef1b082..61d56b0c2be1 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -94,7 +94,7 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
 
 	ctx->ctx_doi = XFRM_SC_DOI_LSM;
 	ctx->ctx_alg = XFRM_SC_ALG_SELINUX;
-	ctx->ctx_len = str_len;
+	ctx->ctx_len = str_len + 1;
 	memcpy(ctx->ctx_str, &uctx[1], str_len);
 	ctx->ctx_str[str_len] = '\0';
 	rc = security_context_to_sid(ctx->ctx_str, str_len,
diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 61d2314834e7..d8249d997c2a 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -31,6 +31,9 @@ struct cs35l41_config {
 };
 
 static const struct cs35l41_config cs35l41_config_table[] = {
+	{ "10251826", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
+	{ "1025182C", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
+	{ "10251844", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "10280B27", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10280B28", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10280BEB", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
@@ -452,6 +455,9 @@ struct cs35l41_prop_model {
 static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
 	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
+	{ "CSC3551", "10251826", generic_dsd_config },
+	{ "CSC3551", "1025182C", generic_dsd_config },
+	{ "CSC3551", "10251844", generic_dsd_config },
 	{ "CSC3551", "10280B27", generic_dsd_config },
 	{ "CSC3551", "10280B28", generic_dsd_config },
 	{ "CSC3551", "10280BEB", generic_dsd_config },
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 25b1984898ab..1872c8b75053 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2286,6 +2286,8 @@ static const struct snd_pci_quirk power_save_denylist[] = {
 	SND_PCI_QUIRK(0x1734, 0x1232, "KONTRON SinglePC", 0),
 	/* Dell ALC3271 */
 	SND_PCI_QUIRK(0x1028, 0x0962, "Dell ALC3271", 0),
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=220210 */
+	SND_PCI_QUIRK(0x17aa, 0x5079, "Lenovo Thinkpad E15", 0),
 	{}
 };
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e714e91c2712..cb41cd2ba0ef 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10449,6 +10449,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0871, "Dell Precision 3630", ALC255_FIXUP_DELL_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0872, "Dell Precision 3630", ALC255_FIXUP_DELL_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0873, "Dell Precision 3930", ALC255_FIXUP_DUMMY_LINEOUT_VERB),
+	SND_PCI_QUIRK(0x1028, 0x0879, "Dell Latitude 5420 Rugged", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x08ad, "Dell WYSE AIO", ALC225_FIXUP_DELL_WYSE_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x08ae, "Dell WYSE NB", ALC225_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0935, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
@@ -10727,6 +10728,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8bb3, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bb4, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bcd, "HP Omen 16-xd0xxx", ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bdd, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bde, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
@@ -10780,6 +10782,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c91, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c97, "HP ZBook", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c9c, "HP Victus 16-s1xxx (MB 8C9C)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8ca1, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca2, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
@@ -10837,6 +10840,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8e60, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e61, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e62, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x1032, "ASUS VivoBook X513EA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1043, 0x1034, "ASUS GU605C", ALC285_FIXUP_ASUS_GU605_SPI_SPEAKER2_TO_DAC1),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x1054, "ASUS G614FH/FM/FP", ALC287_FIXUP_CS35L41_I2C_2),
diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 3be401c72270..99a244f495bd 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -267,7 +267,7 @@ static int create_sdw_dailinks(struct snd_soc_card *card,
 
 	/* generate DAI links by each sdw link */
 	while (sof_dais->initialised) {
-		int current_be_id;
+		int current_be_id = 0;
 
 		ret = create_sdw_dailink(card, sof_dais, dai_links,
 					 &current_be_id, codec_conf);
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index e632f16c9102..3d9da93d22ee 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -311,6 +311,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83AS"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83HN"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
@@ -360,7 +367,7 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M5402RA"),
 		}
 	},
-        {
+	{
 		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 863c3f672ba9..0931b6109755 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -156,11 +156,37 @@ static const struct snd_kcontrol_new isense_switch =
 static const struct snd_kcontrol_new vsense_switch =
 	SOC_DAPM_SINGLE("Switch", TAS2770_PWR_CTRL, 2, 1, 1);
 
+static int sense_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct tas2770_priv *tas2770 = snd_soc_component_get_drvdata(component);
+
+	/*
+	 * Powering up ISENSE/VSENSE requires a trip through the shutdown state.
+	 * Do that here to ensure that our changes are applied properly, otherwise
+	 * we might end up with non-functional IVSENSE if playback started earlier,
+	 * which would break software speaker protection.
+	 */
+	switch (event) {
+	case SND_SOC_DAPM_PRE_REG:
+		return snd_soc_component_update_bits(component, TAS2770_PWR_CTRL,
+						    TAS2770_PWR_CTRL_MASK,
+						    TAS2770_PWR_CTRL_SHUTDOWN);
+	case SND_SOC_DAPM_POST_REG:
+		return tas2770_update_pwr_ctrl(tas2770);
+	default:
+		return 0;
+	}
+}
+
 static const struct snd_soc_dapm_widget tas2770_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("ASI1", "ASI1 Playback", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_MUX("ASI1 Sel", SND_SOC_NOPM, 0, 0, &tas2770_asi1_mux),
-	SND_SOC_DAPM_SWITCH("ISENSE", TAS2770_PWR_CTRL, 3, 1, &isense_switch),
-	SND_SOC_DAPM_SWITCH("VSENSE", TAS2770_PWR_CTRL, 2, 1, &vsense_switch),
+	SND_SOC_DAPM_SWITCH_E("ISENSE", TAS2770_PWR_CTRL, 3, 1, &isense_switch,
+		sense_event, SND_SOC_DAPM_PRE_REG | SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_SWITCH_E("VSENSE", TAS2770_PWR_CTRL, 2, 1, &vsense_switch,
+		sense_event, SND_SOC_DAPM_PRE_REG | SND_SOC_DAPM_POST_REG),
 	SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0, tas2770_dac_event,
 			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_OUTPUT("OUT"),
diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 9c1997a42334..1df827a084ca 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -92,7 +92,6 @@ struct wcd937x_priv {
 	struct regmap_irq_chip *wcd_regmap_irq_chip;
 	struct regmap_irq_chip_data *irq_chip;
 	struct regulator_bulk_data supplies[WCD937X_MAX_BULK_SUPPLY];
-	struct regulator *buck_supply;
 	struct snd_soc_jack *jack;
 	unsigned long status_mask;
 	s32 micb_ref[WCD937X_MAX_MICBIAS];
@@ -2897,10 +2896,8 @@ static int wcd937x_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Failed to get supplies\n");
 
 	ret = regulator_bulk_enable(WCD937X_MAX_BULK_SUPPLY, wcd937x->supplies);
-	if (ret) {
-		regulator_bulk_free(WCD937X_MAX_BULK_SUPPLY, wcd937x->supplies);
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to enable supplies\n");
-	}
 
 	wcd937x_dt_parse_micbias_info(dev, wcd937x);
 
@@ -2936,7 +2933,6 @@ static int wcd937x_probe(struct platform_device *pdev)
 
 err_disable_regulators:
 	regulator_bulk_disable(WCD937X_MAX_BULK_SUPPLY, wcd937x->supplies);
-	regulator_bulk_free(WCD937X_MAX_BULK_SUPPLY, wcd937x->supplies);
 
 	return ret;
 }
@@ -2953,7 +2949,6 @@ static void wcd937x_remove(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(dev);
 
 	regulator_bulk_disable(WCD937X_MAX_BULK_SUPPLY, wcd937x->supplies);
-	regulator_bulk_free(WCD937X_MAX_BULK_SUPPLY, wcd937x->supplies);
 }
 
 #if defined(CONFIG_OF)
diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
index 1a4ef124e4e2..ad38c74166a4 100644
--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -231,7 +231,7 @@ static int meson_card_parse_of_optional(struct snd_soc_card *card,
 						    const char *p))
 {
 	/* If property is not provided, don't fail ... */
-	if (!of_property_read_bool(card->dev->of_node, propname))
+	if (!of_property_present(card->dev->of_node, propname))
 		return 0;
 
 	/* ... but do fail if it is provided and the parsing fails */
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index a479d7e5b7fb..314ff68506d9 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -91,6 +91,10 @@ static int sdm845_slim_snd_hw_params(struct snd_pcm_substream *substream,
 		else
 			ret = snd_soc_dai_set_channel_map(cpu_dai, tx_ch_cnt,
 							  tx_ch, 0, NULL);
+		if (ret != 0 && ret != -ENOTSUPP) {
+			dev_err(rtd->dev, "failed to set cpu chan map, err:%d\n", ret);
+			return ret;
+		}
 	}
 
 	return 0;
diff --git a/sound/soc/sdw_utils/soc_sdw_rt_amp.c b/sound/soc/sdw_utils/soc_sdw_rt_amp.c
index 6951dfb56526..b3d6ca249973 100644
--- a/sound/soc/sdw_utils/soc_sdw_rt_amp.c
+++ b/sound/soc/sdw_utils/soc_sdw_rt_amp.c
@@ -190,7 +190,7 @@ int asoc_sdw_rt_amp_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc
 	const struct snd_soc_dapm_route *rt_amp_map;
 	char codec_name[CODEC_NAME_SIZE];
 	struct snd_soc_dai *codec_dai;
-	int ret;
+	int ret = -EINVAL;
 	int i;
 
 	rt_amp_map = get_codec_name_and_route(dai, codec_name);
diff --git a/sound/soc/tegra/tegra210_ahub.c b/sound/soc/tegra/tegra210_ahub.c
index 1920b996e9aa..51043e556b3e 100644
--- a/sound/soc/tegra/tegra210_ahub.c
+++ b/sound/soc/tegra/tegra210_ahub.c
@@ -1359,6 +1359,8 @@ static int tegra_ahub_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ahub->soc_data = of_device_get_match_data(&pdev->dev);
+	if (!ahub->soc_data)
+		return -ENODEV;
 
 	platform_set_drvdata(pdev, ahub);
 
diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 0e9b5431a47f..faac7df1fbcf 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -383,6 +383,13 @@ static const struct usbmix_name_map ms_usb_link_map[] = {
 	{ 0 }   /* terminator */
 };
 
+/* KTMicro USB */
+static struct usbmix_name_map s31b2_0022_map[] = {
+	{ 23, "Speaker Playback" },
+	{ 18, "Headphone Playback" },
+	{ 0 }
+};
+
 /* ASUS ROG Zenith II with Realtek ALC1220-VB */
 static const struct usbmix_name_map asus_zenith_ii_map[] = {
 	{ 19, NULL, 12 }, /* FU, Input Gain Pad - broken response, disabled */
@@ -692,6 +699,11 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.id = USB_ID(0x045e, 0x083c),
 		.map = ms_usb_link_map,
 	},
+	{
+		/* KTMicro USB */
+		.id = USB_ID(0X31b2, 0x0022),
+		.map = s31b2_0022_map,
+	},
 	{ 0 } /* terminator */
 };
 
diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index afab728468bf..4189c9d74fb0 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -318,11 +318,11 @@ static int show_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 
 static int do_show(int argc, char **argv)
 {
-	enum bpf_attach_type type;
 	int has_attached_progs;
 	const char *path;
 	int cgroup_fd;
 	int ret = -1;
+	unsigned int i;
 
 	query_flags = 0;
 
@@ -370,14 +370,14 @@ static int do_show(int argc, char **argv)
 		       "AttachFlags", "Name");
 
 	btf_vmlinux = libbpf_find_kernel_btf();
-	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
+	for (i = 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {
 		/*
 		 * Not all attach types may be supported, so it's expected,
 		 * that some requests will fail.
 		 * If we were able to get the show for at least one
 		 * attach type, let's return 0.
 		 */
-		if (show_bpf_progs(cgroup_fd, type, 0) == 0)
+		if (show_bpf_progs(cgroup_fd, cgroup_attach_types[i], 0) == 0)
 			ret = 0;
 	}
 
@@ -400,9 +400,9 @@ static int do_show(int argc, char **argv)
 static int do_show_tree_fn(const char *fpath, const struct stat *sb,
 			   int typeflag, struct FTW *ftw)
 {
-	enum bpf_attach_type type;
 	int has_attached_progs;
 	int cgroup_fd;
+	unsigned int i;
 
 	if (typeflag != FTW_D)
 		return 0;
@@ -434,8 +434,8 @@ static int do_show_tree_fn(const char *fpath, const struct stat *sb,
 	}
 
 	btf_vmlinux = libbpf_find_kernel_btf();
-	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++)
-		show_bpf_progs(cgroup_fd, type, ftw->level);
+	for (i = 0; i < ARRAY_SIZE(cgroup_attach_types); i++)
+		show_bpf_progs(cgroup_fd, cgroup_attach_types[i], ftw->level);
 
 	if (errno == EINVAL)
 		/* Last attach type does not support query.
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 552fd633f820..5a5cdb453935 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2035,6 +2035,7 @@ union bpf_attr {
  * 		for updates resulting in a null checksum the value is set to
  * 		**CSUM_MANGLED_0** instead. Flag **BPF_F_PSEUDO_HDR** indicates
  * 		the checksum is to be computed against a pseudo-header.
+ * 		Flag **BPF_F_IPV6** should be set for IPv6 packets.
  *
  * 		This helper works in combination with **bpf_csum_diff**\ (),
  * 		which does not update the checksum in-place, but offers more
@@ -6049,6 +6050,7 @@ enum {
 	BPF_F_PSEUDO_HDR		= (1ULL << 4),
 	BPF_F_MARK_MANGLED_0		= (1ULL << 5),
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
+	BPF_F_IPV6			= (1ULL << 7),
 };
 
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 27e7bfae953b..b770702dab37 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -995,7 +995,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 	if (base_btf) {
 		btf->base_btf = base_btf;
 		btf->start_id = btf__type_cnt(base_btf);
-		btf->start_str_off = base_btf->hdr->str_len;
+		btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
 		btf->swapped_endian = base_btf->swapped_endian;
 	}
 
@@ -4176,6 +4176,19 @@ static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id
 	return true;
 }
 
+static bool btf_dedup_identical_ptrs(struct btf_dedup *d, __u32 id1, __u32 id2)
+{
+	struct btf_type *t1, *t2;
+
+	t1 = btf_type_by_id(d->btf, id1);
+	t2 = btf_type_by_id(d->btf, id2);
+
+	if (!btf_is_ptr(t1) || !btf_is_ptr(t2))
+		return false;
+
+	return t1->type == t2->type;
+}
+
 /*
  * Check equivalence of BTF type graph formed by candidate struct/union (we'll
  * call it "candidate graph" in this description for brevity) to a type graph
@@ -4308,6 +4321,9 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		 */
 		if (btf_dedup_identical_structs(d, hypot_type_id, cand_id))
 			return 1;
+		/* A similar case is again observed for PTRs. */
+		if (btf_dedup_identical_ptrs(d, hypot_type_id, cand_id))
+			return 1;
 		return 0;
 	}
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index bb24f6bac207..1290314da676 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13971,6 +13971,12 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		}
 
 		link = map_skel->link;
+		if (!link) {
+			pr_warn("map '%s': BPF map skeleton link is uninitialized\n",
+				bpf_map__name(map));
+			continue;
+		}
+
 		if (*link)
 			continue;
 
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index ed114b044293..b6986d50dde6 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -255,6 +255,7 @@ static void append_scripts_in_dir(int dir_fd,
 			continue; /* Skip scripts that have a separate driver. */
 		fd = openat(dir_fd, ent->d_name, O_PATH);
 		append_scripts_in_dir(fd, result, result_sz);
+		close(fd);
 	}
 	for (i = 0; i < n_dirs; i++) /* Clean up */
 		zfree(&entlist[i]);
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 81e0135cddf0..a1c71d9793bd 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -282,6 +282,7 @@ bool is_event_supported(u8 type, u64 config)
 			ret = evsel__open(evsel, NULL, tmap) >= 0;
 		}
 
+		evsel__close(evsel);
 		evsel__delete(evsel);
 	}
 
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index d51249f14e2f..5656e58a5380 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -12,7 +12,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh "$(CC)" trivial_program.c -no-pie)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
-			test_vsyscall mov_ss_trap \
+			test_vsyscall mov_ss_trap sigtrap_loop \
 			syscall_arg_fault fsgsbase_restore sigaltstack
 TARGETS_C_BOTHBITS += nx_stack
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
diff --git a/tools/testing/selftests/x86/sigtrap_loop.c b/tools/testing/selftests/x86/sigtrap_loop.c
new file mode 100644
index 000000000000..9d065479e89f
--- /dev/null
+++ b/tools/testing/selftests/x86/sigtrap_loop.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+#define _GNU_SOURCE
+
+#include <err.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ucontext.h>
+
+#ifdef __x86_64__
+# define REG_IP REG_RIP
+#else
+# define REG_IP REG_EIP
+#endif
+
+static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *), int flags)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+
+	return;
+}
+
+static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
+{
+	ucontext_t *ctx = (ucontext_t *)ctx_void;
+	static unsigned int loop_count_on_same_ip;
+	static unsigned long last_trap_ip;
+
+	if (last_trap_ip == ctx->uc_mcontext.gregs[REG_IP]) {
+		printf("\tTrapped at %016lx\n", last_trap_ip);
+
+		/*
+		 * If the same IP is hit more than 10 times in a row, it is
+		 * _considered_ an infinite loop.
+		 */
+		if (++loop_count_on_same_ip > 10) {
+			printf("[FAIL]\tDetected SIGTRAP infinite loop\n");
+			exit(1);
+		}
+
+		return;
+	}
+
+	loop_count_on_same_ip = 0;
+	last_trap_ip = ctx->uc_mcontext.gregs[REG_IP];
+	printf("\tTrapped at %016lx\n", last_trap_ip);
+}
+
+int main(int argc, char *argv[])
+{
+	sethandler(SIGTRAP, sigtrap, 0);
+
+	/*
+	 * Set the Trap Flag (TF) to single-step the test code, therefore to
+	 * trigger a SIGTRAP signal after each instruction until the TF is
+	 * cleared.
+	 *
+	 * Because the arithmetic flags are not significant here, the TF is
+	 * set by pushing 0x302 onto the stack and then popping it into the
+	 * flags register.
+	 *
+	 * Four instructions in the following asm code are executed with the
+	 * TF set, thus the SIGTRAP handler is expected to run four times.
+	 */
+	printf("[RUN]\tSIGTRAP infinite loop detection\n");
+	asm volatile(
+#ifdef __x86_64__
+		/*
+		 * Avoid clobbering the redzone
+		 *
+		 * Equivalent to "sub $128, %rsp", however -128 can be encoded
+		 * in a single byte immediate while 128 uses 4 bytes.
+		 */
+		"add $-128, %rsp\n\t"
+#endif
+		"push $0x302\n\t"
+		"popf\n\t"
+		"nop\n\t"
+		"nop\n\t"
+		"push $0x202\n\t"
+		"popf\n\t"
+#ifdef __x86_64__
+		"sub $-128, %rsp\n\t"
+#endif
+	);
+
+	printf("[OK]\tNo SIGTRAP infinite loop detected\n");
+	return 0;
+}
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index c5b9da034511..1d5bbc8464f1 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -735,6 +735,8 @@ static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
 	(void)adjust_next;
 }
 
+static inline void hugetlb_split(struct vm_area_struct *, unsigned long) {}
+
 static inline void vma_iter_free(struct vma_iterator *vmi)
 {
 	mas_destroy(&vmi->mas);

