Return-Path: <stable+bounces-150695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D06ACC529
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015531892628
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34923230BC5;
	Tue,  3 Jun 2025 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/eY4o9e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8722B8D5;
	Tue,  3 Jun 2025 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949307; cv=none; b=fjMHdNXAWUo9PnzUOaMoFSCB/pQfq8PPcEK++UbyBC1+e2stiaYn5xAk5BLx93XKOsFII4awkVkQr2/4dcwMT87IRCHGCR1Xge1ZMC+9APfzDMO0OPbQuNwXtx9wlhSmAMsP+z1l6WOk3Ah9NUODORKSTgVnRmc8M2Pa7kP0nHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949307; c=relaxed/simple;
	bh=XVveGX9BAoGZsog9qJLl62vXx64a4z1iqbf+fJQBS/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftZd+eMcCSmlZDxO2FHbsfFB9+ITR3gDH2EpMsQ9DkwOugu519Kby981ovSI9ZgIS58RRrWCy5YGpLZrjlnfdD08S8lys5pgoAreP7w6MwFdhBqSj3g+xoQwsItenSexP3fgdZ8fZpU74BcSAKdgRSOI3xFsNoEXTHW8i8C7MqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/eY4o9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15B7C4CEED;
	Tue,  3 Jun 2025 11:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748949305;
	bh=XVveGX9BAoGZsog9qJLl62vXx64a4z1iqbf+fJQBS/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/eY4o9eJL4XKtOwpgF9YHAheoGJ3KUGGhoazNoKGr9xDSGWdMP2Bj3dg4HzwBw9H
	 K3trc10Rlm/Dyi1umunTJWOkCgEOejB186FPyNKMBU1ytw+3BKW6KnVkm8nnMk6tAn
	 7olcWj1Db63cuTUF9XOp23g2BVfvqEN9p4sPTaqBzQUpvJ6YjCNw+D7wFIVjthDfEW
	 aje5HhpZFYcospimIZdTgIFp/bJA2b0QDyvCeYfHl/mh0huDPKw7pH6wnd4HtOYtoH
	 +r0L1DY0ZPa6QFdut3MUKXQM6wBd9CiV7NzyR5vXOc1UxKKalKAtA2X9pj37bSqEqv
	 l+Km+FD7xH/GQ==
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	=?UTF-8?q?J=FCrgen=20Gro=DF?= <jgross@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xin Li <xin@zytor.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 4/5] x86/its: explicitly manage permissions for ITS pages
Date: Tue,  3 Jun 2025 14:14:44 +0300
Message-ID: <20250603111446.2609381-5-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603111446.2609381-1-rppt@kernel.org>
References: <20250603111446.2609381-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

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
---
 arch/x86/kernel/alternative.c | 84 ++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 372ef5dff631..8289e9e1f954 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -138,6 +138,25 @@ static struct module *its_mod;
 #endif
 static void *its_page;
 static unsigned int its_offset;
+struct its_array its_pages;
+
+static void *__its_alloc(struct its_array *pages)
+{
+	void *page __free(execmem) = execmem_alloc(EXECMEM_MODULE_TEXT, PAGE_SIZE);
+
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
@@ -173,6 +192,21 @@ static void *its_init_thunk(void *thunk, int reg)
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
@@ -195,10 +229,8 @@ void its_fini_mod(struct module *mod)
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
@@ -212,32 +244,38 @@ void its_free_mod(struct module *mod)
 	}
 	kfree(mod->arch.its_pages.pages);
 }
-#endif /* CONFIG_MODULES */
 
-static void *its_alloc(void)
+static void *its_alloc_mod(void)
 {
-	void *page __free(execmem) = execmem_alloc(EXECMEM_MODULE_TEXT, PAGE_SIZE);
+	void *page = __its_alloc(&its_mod->arch.its_pages);
 
-	if (!page)
-		return NULL;
+	if (page)
+		execmem_make_temp_rw(page, PAGE_SIZE);
 
-#ifdef CONFIG_MODULES
-	if (its_mod) {
-		struct its_array *pages = &its_mod->arch.its_pages;
-		void *tmp = krealloc(pages->pages,
-				     (pages->num+1) * sizeof(void *),
-				     GFP_KERNEL);
-		if (!tmp)
-			return NULL;
+	return page;
+}
+#endif /* CONFIG_MODULES */
 
-		pages->pages = tmp;
-		pages->pages[pages->num++] = page;
+static void *its_alloc_core(void)
+{
+	void *page = __its_alloc(&its_pages);
 
+	if (page) {
 		execmem_make_temp_rw(page, PAGE_SIZE);
+		set_memory_x((unsigned long)page, 1);
 	}
+
+	return page;
+}
+
+static void *its_alloc(void)
+{
+#ifdef CONFIG_MODULES
+	if (its_mod)
+		return its_alloc_mod();
 #endif /* CONFIG_MODULES */
 
-	return no_free_ptr(page);
+	return its_alloc_core();
 }
 
 static void *its_allocate_thunk(int reg)
@@ -291,7 +329,9 @@ u8 *its_static_thunk(int reg)
 	return thunk;
 }
 
-#endif
+#else
+static inline void its_fini_core(void) {}
+#endif /* CONFIG_MITIGATION_ITS */
 
 /*
  * Nomenclature for variable names to simplify and clarify this code and ease
@@ -2368,6 +2408,8 @@ void __init alternative_instructions(void)
 	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
 	apply_returns(__return_sites, __return_sites_end);
 
+	its_fini_core();
+
 	/*
 	 * Adjust all CALL instructions to point to func()-10, including
 	 * those in .altinstr_replacement.
-- 
2.47.2


