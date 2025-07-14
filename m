Return-Path: <stable+bounces-161836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89881B03F18
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 14:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF9D189CB9F
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 12:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DAF248F75;
	Mon, 14 Jul 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mDr9JWBp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2307F2472BA
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497900; cv=none; b=FTPiSTjdotXLRlqKWdCzMYcEr2lVa11DX+KpWOg5vYZBeOrBl28ok07FfuzVl/37Gh8HEy9ju80v0SQHrGKcRZ3UbnIKM985EzM1eVAdCBoEaRHRgzYjCaVGeQ0Hch/S9OqF+4YvOr9mKMMvBPMpFw9T9NXMaMcC+awfK3ikGEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497900; c=relaxed/simple;
	bh=Dcis6FqIQBSmXxWcOJf7XoBQ+u/AFMe5QmuuJ9Gj6/M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NSulnvCK6mL7mKyL5e4uAeMt2AybLil9QwrDvb3U3+aCuSv43zHJXNz1YI2tWh0zXRZlMUce3OJ0eFddpx6dOEWS5MJYJ7IQ6Xhv+VRdOyEJD47KKZNXkaeFr3wIQemW/LuB8x7ELqDNWmtgW7qk8E/wjde390wg1x4YAw9zcXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mDr9JWBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D44C4CEED;
	Mon, 14 Jul 2025 12:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752497897;
	bh=Dcis6FqIQBSmXxWcOJf7XoBQ+u/AFMe5QmuuJ9Gj6/M=;
	h=Subject:To:Cc:From:Date:From;
	b=mDr9JWBpKcxMZzmB+Xbv3cnY29kuLpqIOLfvRD34BNJmcUopf+xtvR57d62+2eREq
	 GIJJhq2ryY7xYZmi8+oUUk8BWAtZ51gqEVipImo0wJBNAmBNBiIi+TzFeSINVYXPA0
	 Y/8m1LOyKLIOm4Z/fiR0ZSs1C5s1gCKoWfpROtz8=
Subject: FAILED: patch "[PATCH] x86/its: move its_pages array to struct mod_arch_specific" failed to apply to 5.10-stable tree
To: rppt@kernel.org,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Jul 2025 14:58:15 +0200
Message-ID: <2025071415-bullpen-error-57e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0b0cae7119a0ec9449d7261b5e672a5fed765068
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071415-bullpen-error-57e3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0b0cae7119a0ec9449d7261b5e672a5fed765068 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 3 Jun 2025 14:14:43 +0300
Subject: [PATCH] x86/its: move its_pages array to struct mod_arch_specific

The of pages with ITS thunks allocated for modules are tracked by an
array in 'struct module'.

Since this is very architecture specific data structure, move it to
'struct mod_arch_specific'.

No functional changes.

Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20250603111446.2609381-4-rppt@kernel.org

diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
index e988bac0a4a1..3c2de4ce3b10 100644
--- a/arch/x86/include/asm/module.h
+++ b/arch/x86/include/asm/module.h
@@ -5,12 +5,20 @@
 #include <asm-generic/module.h>
 #include <asm/orc_types.h>
 
+struct its_array {
+#ifdef CONFIG_MITIGATION_ITS
+	void **pages;
+	int num;
+#endif
+};
+
 struct mod_arch_specific {
 #ifdef CONFIG_UNWINDER_ORC
 	unsigned int num_orcs;
 	int *orc_unwind_ip;
 	struct orc_entry *orc_unwind;
 #endif
+	struct its_array its_pages;
 };
 
 #endif /* _ASM_X86_MODULE_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ecfe7b497cad..b50fe6ce4655 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -173,8 +173,8 @@ void its_fini_mod(struct module *mod)
 	its_page = NULL;
 	mutex_unlock(&text_mutex);
 
-	for (int i = 0; i < mod->its_num_pages; i++) {
-		void *page = mod->its_page_array[i];
+	for (int i = 0; i < mod->arch.its_pages.num; i++) {
+		void *page = mod->arch.its_pages.pages[i];
 		execmem_restore_rox(page, PAGE_SIZE);
 	}
 }
@@ -184,11 +184,11 @@ void its_free_mod(struct module *mod)
 	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
 		return;
 
-	for (int i = 0; i < mod->its_num_pages; i++) {
-		void *page = mod->its_page_array[i];
+	for (int i = 0; i < mod->arch.its_pages.num; i++) {
+		void *page = mod->arch.its_pages.pages[i];
 		execmem_free(page);
 	}
-	kfree(mod->its_page_array);
+	kfree(mod->arch.its_pages.pages);
 }
 #endif /* CONFIG_MODULES */
 
@@ -201,14 +201,15 @@ static void *its_alloc(void)
 
 #ifdef CONFIG_MODULES
 	if (its_mod) {
-		void *tmp = krealloc(its_mod->its_page_array,
-				     (its_mod->its_num_pages+1) * sizeof(void *),
+		struct its_array *pages = &its_mod->arch.its_pages;
+		void *tmp = krealloc(pages->pages,
+				     (pages->num+1) * sizeof(void *),
 				     GFP_KERNEL);
 		if (!tmp)
 			return NULL;
 
-		its_mod->its_page_array = tmp;
-		its_mod->its_page_array[its_mod->its_num_pages++] = page;
+		pages->pages = tmp;
+		pages->pages[pages->num++] = page;
 
 		execmem_make_temp_rw(page, PAGE_SIZE);
 	}
diff --git a/include/linux/module.h b/include/linux/module.h
index 92e1420fccdf..5faa1fb1f4b4 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -586,11 +586,6 @@ struct module {
 	atomic_t refcnt;
 #endif
 
-#ifdef CONFIG_MITIGATION_ITS
-	int its_num_pages;
-	void **its_page_array;
-#endif
-
 #ifdef CONFIG_CONSTRUCTORS
 	/* Constructor functions. */
 	ctor_fn_t *ctors;


