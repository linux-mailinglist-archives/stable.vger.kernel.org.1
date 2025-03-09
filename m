Return-Path: <stable+bounces-121557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DC9A5829B
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 10:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF86188FAED
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 09:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E4B19F103;
	Sun,  9 Mar 2025 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bk4NutRA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5B4192B71;
	Sun,  9 Mar 2025 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741511899; cv=none; b=cBjO/sBybwzWyhD4mqnUlb8SycjQymyI8M6qrrxGnx2CPzzBcjScAcws16tF8RM8Op77vnY21TZLUCNFNFthcG7hl7SOw4hYIrmb2G8PMnhvM3+Fae5v2hJytujzVIxyBpz+TvC4OW84A4nS3C8ppUTRlpn29/pOj1WVU8Bsh2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741511899; c=relaxed/simple;
	bh=vp3FpESTtGAik8FkBDMyuh4YsIV4BO1Z4c3juQS1F+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6GEiPTYFY4F2Xa7OCn6vEAculdnqPBXiua6UA0WDXJw/OkXQWhe7McVLcAPZ9PKWdKV9Ras6cG7VO7+lCWSb119G39mwuoziH29VfkX8woM4s42XKwvqGomdFif8cRs6SEl7n0H4cr7JGT/F9BaoMvltzp7u7JAhSjnPFed30A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bk4NutRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69154C4CEE5;
	Sun,  9 Mar 2025 09:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741511898;
	bh=vp3FpESTtGAik8FkBDMyuh4YsIV4BO1Z4c3juQS1F+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bk4NutRAIxlclWfceac4FiILX+tzCyaMGXjWJAjqqzVYVOJ35F5XoOweA+LX3isZz
	 nyltB/uX1z8GE67xsCUhtaOQElX+b01j7YSkDjBmRDAXs7quzMAx+60Xa4k7ppug10
	 BrzWc48U5+n4pEqoNNgHqRhf6I4KSUR91+B+stFg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.82
Date: Sun,  9 Mar 2025 10:16:53 +0100
Message-ID: <2025030919-laziness-pucker-b338@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025030919-hurdle-tapestry-5b79@gregkh>
References: <2025030919-hurdle-tapestry-5b79@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 892ed237b1e1..bca0f2e14c5c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 81
+SUBLEVEL = 82
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1e666454ebdc..a06fab5016fd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1315,6 +1315,10 @@ config MICROCODE
 	depends on CPU_SUP_AMD || CPU_SUP_INTEL
 	select CRYPTO_LIB_SHA256 if CPU_SUP_AMD
 
+config MICROCODE_INITRD32
+	def_bool y
+	depends on MICROCODE && X86_32 && BLK_DEV_INITRD
+
 config MICROCODE_LATE_LOADING
 	bool "Late microcode loading (DANGEROUS)"
 	default n
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 1ab475a518e9..0ee6ed0ff2bf 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -23,6 +23,8 @@ static inline void load_ucode_ap(void) { }
 static inline void microcode_bsp_resume(void) { }
 #endif
 
+extern unsigned long initrd_start_early;
+
 #ifdef CONFIG_CPU_SUP_INTEL
 /* Intel specific microcode defines. Public for IFS */
 struct microcode_header_intel {
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index f3495623ac99..bf483fcb4e57 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -126,6 +126,7 @@ void clear_bss(void);
 #ifdef __i386__
 
 asmlinkage void __init __noreturn i386_start_kernel(void);
+void __init mk_early_pgtbl_32(void);
 
 #else
 asmlinkage void __init __noreturn x86_64_start_kernel(char *real_mode);
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 3269a0e23d3a..0000325ab98f 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -16,6 +16,7 @@ CFLAGS_REMOVE_kvmclock.o = -pg
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
+CFLAGS_REMOVE_head32.o = -pg
 CFLAGS_REMOVE_sev.o = -pg
 CFLAGS_REMOVE_rethook.o = -pg
 endif
diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index bde27a35bf2e..de001b2146ab 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -30,12 +30,32 @@ static void __init i386_default_early_setup(void)
 	x86_init.mpparse.setup_ioapic_ids = setup_ioapic_ids_from_mpc;
 }
 
+#ifdef CONFIG_MICROCODE_INITRD32
+unsigned long __initdata initrd_start_early;
+static pte_t __initdata *initrd_pl2p_start, *initrd_pl2p_end;
+
+static void zap_early_initrd_mapping(void)
+{
+	pte_t *pl2p = initrd_pl2p_start;
+
+	for (; pl2p < initrd_pl2p_end; pl2p++) {
+		*pl2p = (pte_t){ .pte = 0 };
+
+		if (!IS_ENABLED(CONFIG_X86_PAE))
+			*(pl2p + ((PAGE_OFFSET >> PGDIR_SHIFT))) = (pte_t) {.pte = 0};
+	}
+}
+#else
+static inline void zap_early_initrd_mapping(void) { }
+#endif
+
 asmlinkage __visible void __init __noreturn i386_start_kernel(void)
 {
 	/* Make sure IDT is set up before any exception happens */
 	idt_setup_early_handler();
 
 	load_ucode_bsp();
+	zap_early_initrd_mapping();
 
 	cr4_init_shadow();
 
@@ -72,52 +92,83 @@ asmlinkage __visible void __init __noreturn i386_start_kernel(void)
  * to the first kernel PMD. Note the upper half of each PMD or PTE are
  * always zero at this stage.
  */
-void __init mk_early_pgtbl_32(void);
-void __init mk_early_pgtbl_32(void)
-{
-#ifdef __pa
-#undef __pa
-#endif
-#define __pa(x)  ((unsigned long)(x) - PAGE_OFFSET)
-	pte_t pte, *ptep;
-	int i;
-	unsigned long *ptr;
-	/* Enough space to fit pagetables for the low memory linear map */
-	const unsigned long limit = __pa(_end) +
-		(PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
 #ifdef CONFIG_X86_PAE
-	pmd_t pl2, *pl2p = (pmd_t *)__pa(initial_pg_pmd);
-#define SET_PL2(pl2, val)    { (pl2).pmd = (val); }
+typedef pmd_t			pl2_t;
+#define pl2_base		initial_pg_pmd
+#define SET_PL2(val)		{ .pmd = (val), }
 #else
-	pgd_t pl2, *pl2p = (pgd_t *)__pa(initial_page_table);
-#define SET_PL2(pl2, val)   { (pl2).pgd = (val); }
+typedef pgd_t			pl2_t;
+#define pl2_base		initial_page_table
+#define SET_PL2(val)		{ .pgd = (val), }
 #endif
 
-	ptep = (pte_t *)__pa(__brk_base);
-	pte.pte = PTE_IDENT_ATTR;
-
+static __init __no_stack_protector pte_t init_map(pte_t pte, pte_t **ptep, pl2_t **pl2p,
+						  const unsigned long limit)
+{
 	while ((pte.pte & PTE_PFN_MASK) < limit) {
+		pl2_t pl2 = SET_PL2((unsigned long)*ptep | PDE_IDENT_ATTR);
+		int i;
+
+		**pl2p = pl2;
+		if (!IS_ENABLED(CONFIG_X86_PAE)) {
+			/* Kernel PDE entry */
+			*(*pl2p + ((PAGE_OFFSET >> PGDIR_SHIFT))) = pl2;
+		}
 
-		SET_PL2(pl2, (unsigned long)ptep | PDE_IDENT_ATTR);
-		*pl2p = pl2;
-#ifndef CONFIG_X86_PAE
-		/* Kernel PDE entry */
-		*(pl2p +  ((PAGE_OFFSET >> PGDIR_SHIFT))) = pl2;
-#endif
 		for (i = 0; i < PTRS_PER_PTE; i++) {
-			*ptep = pte;
+			**ptep = pte;
 			pte.pte += PAGE_SIZE;
-			ptep++;
+			(*ptep)++;
 		}
-
-		pl2p++;
+		(*pl2p)++;
 	}
+	return pte;
+}
+
+void __init __no_stack_protector mk_early_pgtbl_32(void)
+{
+	/* Enough space to fit pagetables for the low memory linear map */
+	unsigned long limit = __pa_nodebug(_end) + (PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
+	pte_t pte, *ptep = (pte_t *)__pa_nodebug(__brk_base);
+	struct boot_params __maybe_unused *params;
+	pl2_t *pl2p = (pl2_t *)__pa_nodebug(pl2_base);
+	unsigned long *ptr;
+
+	pte.pte = PTE_IDENT_ATTR;
+	pte = init_map(pte, &ptep, &pl2p, limit);
 
-	ptr = (unsigned long *)__pa(&max_pfn_mapped);
+	ptr = (unsigned long *)__pa_nodebug(&max_pfn_mapped);
 	/* Can't use pte_pfn() since it's a call with CONFIG_PARAVIRT */
 	*ptr = (pte.pte & PTE_PFN_MASK) >> PAGE_SHIFT;
 
-	ptr = (unsigned long *)__pa(&_brk_end);
+	ptr = (unsigned long *)__pa_nodebug(&_brk_end);
 	*ptr = (unsigned long)ptep + PAGE_OFFSET;
-}
 
+#ifdef CONFIG_MICROCODE_INITRD32
+	/* Running on a hypervisor? */
+	if (native_cpuid_ecx(1) & BIT(31))
+		return;
+
+	params = (struct boot_params *)__pa_nodebug(&boot_params);
+	if (!params->hdr.ramdisk_size || !params->hdr.ramdisk_image)
+		return;
+
+	/* Save the virtual start address */
+	ptr = (unsigned long *)__pa_nodebug(&initrd_start_early);
+	*ptr = (pte.pte & PTE_PFN_MASK) + PAGE_OFFSET;
+	*ptr += ((unsigned long)params->hdr.ramdisk_image) & ~PAGE_MASK;
+
+	/* Save PLP2 for cleanup */
+	ptr = (unsigned long *)__pa_nodebug(&initrd_pl2p_start);
+	*ptr = (unsigned long)pl2p + PAGE_OFFSET;
+
+	limit = (unsigned long)params->hdr.ramdisk_image;
+	pte.pte = PTE_IDENT_ATTR | PFN_ALIGN(limit);
+	limit = (unsigned long)params->hdr.ramdisk_image + params->hdr.ramdisk_size;
+
+	init_map(pte, &ptep, &pl2p, limit);
+
+	ptr = (unsigned long *)__pa_nodebug(&initrd_pl2p_end);
+	*ptr = (unsigned long)pl2p + PAGE_OFFSET;
+#endif
+}

