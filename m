Return-Path: <stable+bounces-155150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D96AE1E40
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DE85A289F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876832BEC5F;
	Fri, 20 Jun 2025 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xyHsBUo2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC829C32F
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432406; cv=none; b=n+UvuS1cwXjztsooD5vxwZlVHDyN6gvqHNVGuemxwouPJTUznZ3TyXFQsO1nosdIiJCjb8VKDWACmTFMpl1ZILWhkJvE+XaGkS4/Acx1FOiaQPzG/hpYeyfK0JCEcSNmQAFcERWL2ywgvLntYKIsvKMHFaAM5IjcK9uViOjZ6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432406; c=relaxed/simple;
	bh=qTdZdgqclAIuRxpTGn47zXxeEhmADAGpVQvoXxg68vY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QVD+zLtvvn8cW9zj0kZM3N1eCAJKBzW8MsCEwVac7LknrWGh8FKNzlmIZ5hJp6F+CM3mwb78hRrVD/lbIExGTRx14TCAafoPKgCfZA3apxRgrPjlFi94dVuMZGy0k7FzvFOli65Rz0n0VcJRXMMkzJmciN8svPI1bj6F310hcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xyHsBUo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88FCC4CEE3;
	Fri, 20 Jun 2025 15:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750432406;
	bh=qTdZdgqclAIuRxpTGn47zXxeEhmADAGpVQvoXxg68vY=;
	h=Subject:To:Cc:From:Date:From;
	b=xyHsBUo2enW2FNl0VEfums5SjizBGjnfR+C4ffc3O2EYb6tPw5LX0Q/4YoDtAj9++
	 zIuAkKt9j0BKfWHr8V2XhLVNC9lCKcCHT9Tj8Kde0nef51F1F+3s/IlECICMsMTEuO
	 b/9qUwKpwb34ifDmqCoX64eCIMU5H6mBAjWhV/G8=
Subject: FAILED: patch "[PATCH] x86/its: explicitly manage permissions for ITS pages" failed to apply to 5.15-stable tree
To: peterz@infradead.org,nik.borisov@suse.com,rppt@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 17:13:14 +0200
Message-ID: <2025062014-unvaried-ranch-2d7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a82b26451de126a5ae130361081986bc459afe9b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062014-unvaried-ranch-2d7c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a82b26451de126a5ae130361081986bc459afe9b Mon Sep 17 00:00:00 2001
From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Date: Tue, 3 Jun 2025 14:14:44 +0300
Subject: [PATCH] x86/its: explicitly manage permissions for ITS pages

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

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b50fe6ce4655..6455f7f751b3 100644
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
+	execmem_make_temp_rw(page, PAGE_SIZE);
+	if (pages == &its_pages)
+		set_memory_x((unsigned long)page, 1);
 
-		pages->pages = tmp;
-		pages->pages[pages->num++] = page;
-
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


