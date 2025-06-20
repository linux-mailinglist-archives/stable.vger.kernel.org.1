Return-Path: <stable+bounces-155144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD8DAE1E37
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DB5170F63
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3933B29C32F;
	Fri, 20 Jun 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FHczgQ/o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE92C295D92
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432383; cv=none; b=dpgLAzlH52s/zdEP4PoJCfSLAirJ9+2MhALgzDjeLOPJS4lP47PYxkHUkA0xTcq3LRoBn0mcUTlAH1UBr4lxu/FtfRe7n7KuiPNP3y7HUwT8PmOu36ut2j/DcLxI5lal6Xv7BScdNBbxSjffI/yObS+j66CqCGkmh+Jzcg6TzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432383; c=relaxed/simple;
	bh=iOqghJAwQXYp4W90Gn4faqtKan1YsE55shyaLe4a+mQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HnXdPSjBLtUGq5blIrM2x8/AGBxUuTQL9vHJ5WoFPX0oVz8Sp5/SIxJGinHisOHvG7qseHWQfX9qqLzJnOGWV4wbr8CQDW5cSiCg380OH29jM4iNNQjhdjMEZ0L0T6k7GvHHWWVusS6MYiUh5f1JahLzv0dzQwKxQ7ZH71fInLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FHczgQ/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79615C4CEE3;
	Fri, 20 Jun 2025 15:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750432382;
	bh=iOqghJAwQXYp4W90Gn4faqtKan1YsE55shyaLe4a+mQ=;
	h=Subject:To:Cc:From:Date:From;
	b=FHczgQ/orTrX6L+tchPTQeeJjza8/afMdPkwS+PTjJQkPgKxf38J+GA0+wSihZiI/
	 oiS28g5kHPl31noV96fiOT74vDOoXH8BzZxgs3ywyqq3na+kCMfDvvrG118ve5ghgR
	 s4YDFXIl1lDpyyYC1Nn+U+AFgR0/cRXIP1cOofJ8=
Subject: FAILED: patch "[PATCH] x86/its: move its_pages array to struct mod_arch_specific" failed to apply to 6.12-stable tree
To: rppt@kernel.org,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 17:12:59 +0200
Message-ID: <2025062059-map-powdering-0ee4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0b0cae7119a0ec9449d7261b5e672a5fed765068
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062059-map-powdering-0ee4@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


