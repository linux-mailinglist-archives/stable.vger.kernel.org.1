Return-Path: <stable+bounces-37334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC8889C46B
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E442844D3
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4C17F49A;
	Mon,  8 Apr 2024 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Aab9qfSP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A576402;
	Mon,  8 Apr 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583928; cv=none; b=atx4TK/4cIHyTt/YgKQ6ZdP7LstvkH/8Jx0LaYHtbzH+C8V+foHR2khe4u2+eUgzxo8rB0J+jVKTW0TR0yy/ESC1B0H6N34LIq2eGoKvsJWGD//ELuWNwBFrcfFnm8rWB/HjsFYD9Jomh+7/Tr7xavvt8o+v7d9osBjBdGchX/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583928; c=relaxed/simple;
	bh=FsTqoeKIDsgrRv3bwDyXmJ84yYKQAZ6vGKRqtPwp8Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGIVzder9F8cpf2OkdRc0DMbYsCVUr8+pO3WY/LZstOB62gWmVhdIsdCNhtv0A8WFnvAj8yC4E42C12Z6uGxiaG5pBlM8SBFoU9EfiXpKdJ/na13rxz1pQFnftw7b2sNx9D2aAw3vohitY+gS9EXTvR+geWKAptNGzm1dv/Oiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Aab9qfSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C85C433C7;
	Mon,  8 Apr 2024 13:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583928;
	bh=FsTqoeKIDsgrRv3bwDyXmJ84yYKQAZ6vGKRqtPwp8Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aab9qfSPFV2i8NMTeOYV8FaQRcB52D/erce0+9BLAqm9VfBbDZOntqCVByGKYkcAL
	 Vg1/AWhj4f5mRRvcCnzMqToxIAHRshAoEpVsWPxGwbUT/dn+V8kbkKDAe6KDtMn4rb
	 g9lsceelXc9/w41rTDLDRZjBYhwIwlw1ikSHgOfo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 6.6 250/252] x86/sme: Move early SME kernel encryption handling into .head.text
Date: Mon,  8 Apr 2024 14:59:09 +0200
Message-ID: <20240408125314.415138135@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

commit 48204aba801f1b512b3abed10b8e1a63e03f3dd1 upstream.

The .head.text section is the initial primary entrypoint of the core
kernel, and is entered with the CPU executing from a 1:1 mapping of
memory. Such code must never access global variables using absolute
references, as these are based on the kernel virtual mapping which is
not active yet at this point.

Given that the SME startup code is also called from this early execution
context, move it into .head.text as well. This will allow more thorough
build time checks in the future to ensure that early startup code only
uses RIP-relative references to global variables.

Also replace some occurrences of __pa_symbol() [which relies on the
compiler generating an absolute reference, which is not guaranteed] and
an open coded RIP-relative access with RIP_REL_REF().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20240227151907.387873-18-ardb+git@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/mem_encrypt.h |    8 +++----
 arch/x86/mm/mem_encrypt_identity.c |   42 ++++++++++++++-----------------------
 2 files changed, 21 insertions(+), 29 deletions(-)

--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -46,8 +46,8 @@ void __init sme_unmap_bootdata(char *rea
 void __init sme_early_init(void);
 void __init sev_setup_arch(void);
 
-void __init sme_encrypt_kernel(struct boot_params *bp);
-void __init sme_enable(struct boot_params *bp);
+void sme_encrypt_kernel(struct boot_params *bp);
+void sme_enable(struct boot_params *bp);
 
 int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
 int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
@@ -81,8 +81,8 @@ static inline void __init sme_unmap_boot
 static inline void __init sme_early_init(void) { }
 static inline void __init sev_setup_arch(void) { }
 
-static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
-static inline void __init sme_enable(struct boot_params *bp) { }
+static inline void sme_encrypt_kernel(struct boot_params *bp) { }
+static inline void sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
 
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -41,6 +41,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/cc_platform.h>
 
+#include <asm/init.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cmdline.h>
@@ -98,7 +99,7 @@ static char sme_workarea[2 * PMD_SIZE] _
 static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
 
-static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
+static void __head sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
 	pgd_t *pgd_p;
@@ -113,7 +114,7 @@ static void __init sme_clear_pgd(struct
 	memset(pgd_p, 0, pgd_size);
 }
 
-static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
+static pud_t __head *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -150,7 +151,7 @@ static pud_t __init *sme_prepare_pgd(str
 	return pud;
 }
 
-static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
+static void __head sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -166,7 +167,7 @@ static void __init sme_populate_pgd_larg
 	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
 
-static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
+static void __head sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -192,7 +193,7 @@ static void __init sme_populate_pgd(stru
 		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
 
-static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
+static void __head __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd_large(ppd);
@@ -202,7 +203,7 @@ static void __init __sme_map_range_pmd(s
 	}
 }
 
-static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
+static void __head __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd(ppd);
@@ -212,7 +213,7 @@ static void __init __sme_map_range_pte(s
 	}
 }
 
-static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
+static void __head __sme_map_range(struct sme_populate_pgd_data *ppd,
 				   pmdval_t pmd_flags, pteval_t pte_flags)
 {
 	unsigned long vaddr_end;
@@ -236,22 +237,22 @@ static void __init __sme_map_range(struc
 	__sme_map_range_pte(ppd);
 }
 
-static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
+static void __head sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
 }
 
-static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
+static void __head sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
 }
 
-static void __init sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
+static void __head sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC_WP, PTE_FLAGS_DEC_WP);
 }
 
-static unsigned long __init sme_pgtable_calc(unsigned long len)
+static unsigned long __head sme_pgtable_calc(unsigned long len)
 {
 	unsigned long entries = 0, tables = 0;
 
@@ -288,7 +289,7 @@ static unsigned long __init sme_pgtable_
 	return entries + tables;
 }
 
-void __init sme_encrypt_kernel(struct boot_params *bp)
+void __head sme_encrypt_kernel(struct boot_params *bp)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
@@ -323,9 +324,8 @@ void __init sme_encrypt_kernel(struct bo
 	 *     memory from being cached.
 	 */
 
-	/* Physical addresses gives us the identity mapped virtual addresses */
-	kernel_start = __pa_symbol(_text);
-	kernel_end = ALIGN(__pa_symbol(_end), PMD_SIZE);
+	kernel_start = (unsigned long)RIP_REL_REF(_text);
+	kernel_end = ALIGN((unsigned long)RIP_REL_REF(_end), PMD_SIZE);
 	kernel_len = kernel_end - kernel_start;
 
 	initrd_start = 0;
@@ -343,14 +343,6 @@ void __init sme_encrypt_kernel(struct bo
 #endif
 
 	/*
-	 * We're running identity mapped, so we must obtain the address to the
-	 * SME encryption workarea using rip-relative addressing.
-	 */
-	asm ("lea sme_workarea(%%rip), %0"
-	     : "=r" (workarea_start)
-	     : "p" (sme_workarea));
-
-	/*
 	 * Calculate required number of workarea bytes needed:
 	 *   executable encryption area size:
 	 *     stack page (PAGE_SIZE)
@@ -359,7 +351,7 @@ void __init sme_encrypt_kernel(struct bo
 	 *   pagetable structures for the encryption of the kernel
 	 *   pagetable structures for workarea (in case not currently mapped)
 	 */
-	execute_start = workarea_start;
+	execute_start = workarea_start = (unsigned long)RIP_REL_REF(sme_workarea);
 	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_SIZE;
 	execute_len = execute_end - execute_start;
 
@@ -502,7 +494,7 @@ void __init sme_encrypt_kernel(struct bo
 	native_write_cr3(__native_read_cr3());
 }
 
-void __init sme_enable(struct boot_params *bp)
+void __head sme_enable(struct boot_params *bp)
 {
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on;
 	unsigned int eax, ebx, ecx, edx;



