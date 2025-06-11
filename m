Return-Path: <stable+bounces-152402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7BBAD4FCD
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 11:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25813A7682
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C63262FDE;
	Wed, 11 Jun 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N5tUY51I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DYo6GNxn"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82254C79;
	Wed, 11 Jun 2025 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634233; cv=none; b=Pusa0ANN/qA5Cbs6ywF54njs3YsLyBHXPyXxeRMOd9xMGhfrSik3+UGeHdAjfdAVQ96N2uxJtzpvx9yeoF2PSCSJga93ADU22nt6/WfhnReU2a3BlvNdFGmaQ6w9cW4MmBQ4LA4OhoaRml9IywIzDwBR0vNc0MN8fbnqCe07IN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634233; c=relaxed/simple;
	bh=Sgb/DgIaSs3qVbyMpEegddQSYa9SUTmUPj0bH1Up/8M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RxaFgc0lGZEA9K52EAfSBYpUAnsdgQ2hyoM1LxMuVSsBZOS3QWl0dvg1hFamzCL4+slzQHbL7MBZKj0AV7j2BGKtXl+UVGty8oisDufnA+5TWq0ayjqKPkizWYLg5Zop7NsUjTpGQ+M4WxlWLP3eOEC+csMCnhRHQsPXIB67Sxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N5tUY51I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DYo6GNxn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:30:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749634230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wpX3t/47z7P0zY5EBLfYH7y73VToEnsrPps/AcXptXs=;
	b=N5tUY51ICNg65plG3Zh6M4vpUOJ+IdDyR458NvIg9p3CGZ93uGxRAS7AaxrB1q1828RXvJ
	3dZ3xUFJG84E8i2GOy0nShkIlnH6cAnyZaBEKqmJvWhTBjl5vk2haBIx5qcy3TNgNr17Fy
	QHqwe3rxIVtT/iPWgyHXikJr6RpwB3JYP835lQqh3aaxcfw6qYz2Tc+vr3QSig1dvQNNwN
	gmONp+KBTYzIwCeHiDHfEGnf1sZvSZH9mvaMsLQKsIxMH+nPiw7pKjvvixk1vPe4viicR9
	e6vWo9Aok8F+tBveYTerBzvlCxyAfVnewrEqPDsm1srUuHMGadt2V4eos713fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749634230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wpX3t/47z7P0zY5EBLfYH7y73VToEnsrPps/AcXptXs=;
	b=DYo6GNxn3+oO2vU14uz6Oq6SXlbHAsSx3S8lw3AwuILeVMWvkgiOZ1NRUyXAx5cKAepxHk
	Bk9qhsL2Mb0D2FBQ==
From: "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/its: explicitly manage permissions for ITS pages
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Nikolay Borisov <nik.borisov@suse.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250603111446.2609381-5-rppt@kernel.org>
References: <20250603111446.2609381-5-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963422924.406.14483786184878538014.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a82b26451de126a5ae130361081986bc459afe9b
Gitweb:        https://git.kernel.org/tip/a82b26451de126a5ae130361081986bc459afe9b
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Tue, 03 Jun 2025 14:14:44 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 Jun 2025 11:20:52 +02:00

x86/its: explicitly manage permissions for ITS pages

execmem_alloc() sets permissions differently depending on the kernel
configuration, CPU support for PSE and whether a page is allocated
before or after mark_rodata_ro().

Add tracking for pages allocated for ITS when patching the core kernel
and make sure the permissions for ITS pages are explicitly managed for
both kernel and module allocations.

Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20250603111446.2609381-5-rppt@kernel.org
---
 arch/x86/kernel/alternative.c | 74 +++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b50fe6c..6455f7f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -116,6 +116,24 @@ static struct module *its_mod;
 #endif
 static void *its_page;
 static unsigned int its_offset;
+struct its_array its_pages;
+
+static void *__its_alloc(struct its_array *pages)
+{
+	void *page __free(execmem) = execmem_alloc(EXECMEM_MODULE_TEXT, PAGE_SIZE);
+	if (!page)
+		return NULL;
+
+	void *tmp = krealloc(pages->pages, (pages->num+1) * sizeof(void *),
+			     GFP_KERNEL);
+	if (!tmp)
+		return NULL;
+
+	pages->pages = tmp;
+	pages->pages[pages->num++] = page;
+
+	return no_free_ptr(page);
+}
 
 /* Initialize a thunk with the "jmp *reg; int3" instructions. */
 static void *its_init_thunk(void *thunk, int reg)
@@ -151,6 +169,21 @@ static void *its_init_thunk(void *thunk, int reg)
 	return thunk + offset;
 }
 
+static void its_pages_protect(struct its_array *pages)
+{
+	for (int i = 0; i < pages->num; i++) {
+		void *page = pages->pages[i];
+		execmem_restore_rox(page, PAGE_SIZE);
+	}
+}
+
+static void its_fini_core(void)
+{
+	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
+		its_pages_protect(&its_pages);
+	kfree(its_pages.pages);
+}
+
 #ifdef CONFIG_MODULES
 void its_init_mod(struct module *mod)
 {
@@ -173,10 +206,8 @@ void its_fini_mod(struct module *mod)
 	its_page = NULL;
 	mutex_unlock(&text_mutex);
 
-	for (int i = 0; i < mod->arch.its_pages.num; i++) {
-		void *page = mod->arch.its_pages.pages[i];
-		execmem_restore_rox(page, PAGE_SIZE);
-	}
+	if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		its_pages_protect(&mod->arch.its_pages);
 }
 
 void its_free_mod(struct module *mod)
@@ -194,28 +225,23 @@ void its_free_mod(struct module *mod)
 
 static void *its_alloc(void)
 {
-	void *page __free(execmem) = execmem_alloc(EXECMEM_MODULE_TEXT, PAGE_SIZE);
+	struct its_array *pages = &its_pages;
+	void *page;
 
+#ifdef CONFIG_MODULE
+	if (its_mod)
+		pages = &its_mod->arch.its_pages;
+#endif
+
+	page = __its_alloc(pages);
 	if (!page)
 		return NULL;
 
-#ifdef CONFIG_MODULES
-	if (its_mod) {
-		struct its_array *pages = &its_mod->arch.its_pages;
-		void *tmp = krealloc(pages->pages,
-				     (pages->num+1) * sizeof(void *),
-				     GFP_KERNEL);
-		if (!tmp)
-			return NULL;
-
-		pages->pages = tmp;
-		pages->pages[pages->num++] = page;
+	execmem_make_temp_rw(page, PAGE_SIZE);
+	if (pages == &its_pages)
+		set_memory_x((unsigned long)page, 1);
 
-		execmem_make_temp_rw(page, PAGE_SIZE);
-	}
-#endif /* CONFIG_MODULES */
-
-	return no_free_ptr(page);
+	return page;
 }
 
 static void *its_allocate_thunk(int reg)
@@ -269,7 +295,9 @@ u8 *its_static_thunk(int reg)
 	return thunk;
 }
 
-#endif
+#else
+static inline void its_fini_core(void) {}
+#endif /* CONFIG_MITIGATION_ITS */
 
 /*
  * Nomenclature for variable names to simplify and clarify this code and ease
@@ -2339,6 +2367,8 @@ void __init alternative_instructions(void)
 	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
 	apply_returns(__return_sites, __return_sites_end);
 
+	its_fini_core();
+
 	/*
 	 * Adjust all CALL instructions to point to func()-10, including
 	 * those in .altinstr_replacement.

