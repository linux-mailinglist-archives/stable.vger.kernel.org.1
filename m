Return-Path: <stable+bounces-75619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C562C97356A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C08D1F26202
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397D518C932;
	Tue, 10 Sep 2024 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hBGnjpSv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A6144D1A;
	Tue, 10 Sep 2024 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965261; cv=none; b=ootpjmS6wE305bxh3A6Iv4UGKTtUruGAGeYszG4JsVSITMtakr4Ecsi+NYi9+3ApVFEtSDpH2ljiSGFl4xdtWwzPBu0hUMLFgZy+zWqY424ILEzSeCSUbCnuuhiH9yxbtzB7rXOHGG1Kr0eyfl3Yh/rzmSn1HzOYmwX0irQ14bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965261; c=relaxed/simple;
	bh=GbFcnv6ni1S0oTeIAA6n3oNsrfArzBC6JcquXg4qyyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWCqLslk5PTcxH0nlICJFQvUjgOCj6wHrKP8EXNXvTNXdZmjVMlOTNuj4DrXvBN62a5ahNPlUPGk6ieYEARKprngHeda/60SJfTl6ZozznTsrG9k2CDmkbCZJJGHGQ84gXE6ay8u7joaREthSnis5N/judauLEA11AxLnCAeGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hBGnjpSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75337C4CEC3;
	Tue, 10 Sep 2024 10:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725965260;
	bh=GbFcnv6ni1S0oTeIAA6n3oNsrfArzBC6JcquXg4qyyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hBGnjpSvTHog7X1+RL/9+FOyh8ghvDkY/mny4GfiRmbnU7B8KhXdHCIrPmsHomy9G
	 vxYIpf8NAraiUWKG0pp72oOlkj5bfXJePR6DKeL6uuVgWAYkT7Lax8VCHq72cwvWYt
	 tTSizDy2zNGOQD83Ilj9eszOCvwitcM2sQ75jH5M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 5.10 184/186] x86/mm: Fix PTI for i386 some more
Date: Tue, 10 Sep 2024 11:34:39 +0200
Message-ID: <20240910092602.203187385@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092554.645718780@linuxfoundation.org>
References: <20240910092554.645718780@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit c48b5a4cf3125adb679e28ef093f66ff81368d05 upstream.

So it turns out that we have to do two passes of
pti_clone_entry_text(), once before initcalls, such that device and
late initcalls can use user-mode-helper / modprobe and once after
free_initmem() / mark_readonly().

Now obviously mark_readonly() can cause PMD splits, and
pti_clone_pgtable() doesn't like that much.

Allow the late clone to split PMDs so that pagetables stay in sync.

[peterz: Changelog and comments]
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lkml.kernel.org/r/20240806184843.GX37996@noisy.programming.kicks-ass.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/pti.c |   45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -241,7 +241,7 @@ static pmd_t *pti_user_pagetable_walk_pm
  *
  * Returns a pointer to a PTE on success, or NULL on failure.
  */
-static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
+static pte_t *pti_user_pagetable_walk_pte(unsigned long address, bool late_text)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	pmd_t *pmd;
@@ -251,10 +251,15 @@ static pte_t *pti_user_pagetable_walk_pt
 	if (!pmd)
 		return NULL;
 
-	/* We can't do anything sensible if we hit a large mapping. */
+	/* Large PMD mapping found */
 	if (pmd_large(*pmd)) {
-		WARN_ON(1);
-		return NULL;
+		/* Clear the PMD if we hit a large mapping from the first round */
+		if (late_text) {
+			set_pmd(pmd, __pmd(0));
+		} else {
+			WARN_ON_ONCE(1);
+			return NULL;
+		}
 	}
 
 	if (pmd_none(*pmd)) {
@@ -283,7 +288,7 @@ static void __init pti_setup_vsyscall(vo
 	if (!pte || WARN_ON(level != PG_LEVEL_4K) || pte_none(*pte))
 		return;
 
-	target_pte = pti_user_pagetable_walk_pte(VSYSCALL_ADDR);
+	target_pte = pti_user_pagetable_walk_pte(VSYSCALL_ADDR, false);
 	if (WARN_ON(!target_pte))
 		return;
 
@@ -301,7 +306,7 @@ enum pti_clone_level {
 
 static void
 pti_clone_pgtable(unsigned long start, unsigned long end,
-		  enum pti_clone_level level)
+		  enum pti_clone_level level, bool late_text)
 {
 	unsigned long addr;
 
@@ -390,7 +395,7 @@ pti_clone_pgtable(unsigned long start, u
 				return;
 
 			/* Allocate PTE in the user page-table */
-			target_pte = pti_user_pagetable_walk_pte(addr);
+			target_pte = pti_user_pagetable_walk_pte(addr, late_text);
 			if (WARN_ON(!target_pte))
 				return;
 
@@ -453,7 +458,7 @@ static void __init pti_clone_user_shared
 		phys_addr_t pa = per_cpu_ptr_to_phys((void *)va);
 		pte_t *target_pte;
 
-		target_pte = pti_user_pagetable_walk_pte(va);
+		target_pte = pti_user_pagetable_walk_pte(va, false);
 		if (WARN_ON(!target_pte))
 			return;
 
@@ -476,7 +481,7 @@ static void __init pti_clone_user_shared
 	start = CPU_ENTRY_AREA_BASE;
 	end   = start + (PAGE_SIZE * CPU_ENTRY_AREA_PAGES);
 
-	pti_clone_pgtable(start, end, PTI_CLONE_PMD);
+	pti_clone_pgtable(start, end, PTI_CLONE_PMD, false);
 }
 #endif /* CONFIG_X86_64 */
 
@@ -493,11 +498,11 @@ static void __init pti_setup_espfix64(vo
 /*
  * Clone the populated PMDs of the entry text and force it RO.
  */
-static void pti_clone_entry_text(void)
+static void pti_clone_entry_text(bool late)
 {
 	pti_clone_pgtable((unsigned long) __entry_text_start,
 			  (unsigned long) __entry_text_end,
-			  PTI_LEVEL_KERNEL_IMAGE);
+			  PTI_LEVEL_KERNEL_IMAGE, late);
 }
 
 /*
@@ -572,7 +577,7 @@ static void pti_clone_kernel_text(void)
 	 * pti_set_kernel_image_nonglobal() did to clear the
 	 * global bit.
 	 */
-	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE);
+	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE, false);
 
 	/*
 	 * pti_clone_pgtable() will set the global bit in any PMDs
@@ -639,8 +644,15 @@ void __init pti_init(void)
 
 	/* Undo all global bits from the init pagetables in head_64.S: */
 	pti_set_kernel_image_nonglobal();
+
 	/* Replace some of the global bits just for shared entry text: */
-	pti_clone_entry_text();
+	/*
+	 * This is very early in boot. Device and Late initcalls can do
+	 * modprobe before free_initmem() and mark_readonly(). This
+	 * pti_clone_entry_text() allows those user-mode-helpers to function,
+	 * but notably the text is still RW.
+	 */
+	pti_clone_entry_text(false);
 	pti_setup_espfix64();
 	pti_setup_vsyscall();
 }
@@ -657,10 +669,11 @@ void pti_finalize(void)
 	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 	/*
-	 * We need to clone everything (again) that maps parts of the
-	 * kernel image.
+	 * This is after free_initmem() (all initcalls are done) and we've done
+	 * mark_readonly(). Text is now NX which might've split some PMDs
+	 * relative to the early clone.
 	 */
-	pti_clone_entry_text();
+	pti_clone_entry_text(true);
 	pti_clone_kernel_text();
 
 	debug_checkwx_user();



