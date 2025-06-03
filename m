Return-Path: <stable+bounces-150694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44326ACC524
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9659171030
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDC722FDFF;
	Tue,  3 Jun 2025 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE0vJp4b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D522FAD4;
	Tue,  3 Jun 2025 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949302; cv=none; b=kF7rMKSed6C5Rxa+CwtNbwi0CmNRkcgzzaL6OjVwSr5pMDoUAIAfRfEoNDIBFc7wm45xdsklmStP1n5FRF3cJ1f7WZYlMkhzG2YfsNJEOeedKW4nFush4gOfGRdwtDsfapIWJkERAz4rOSMAGiNkzO3dC/egkWahLW5n37tIo+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949302; c=relaxed/simple;
	bh=FpPB9RI3yzXwRrEvvORZT0YCghWK/sZm7ZjyisZItyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQmWikkZ67n551WkCRXFVwhVqAJZFCcgmwGnIPUEmfAmGhvf0GR0vyvWXpwx1Pzno1z0aXulGIwfl7NILLYL7cpZakOPQMQz5F9RwP9tdt8A8ZH09OdFylaHN/4wWgpMFsJWbAhu6GH4bk4V5CqQG0UngjAtCPHzgGaRu7ySEGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE0vJp4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E695C4CEEF;
	Tue,  3 Jun 2025 11:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748949302;
	bh=FpPB9RI3yzXwRrEvvORZT0YCghWK/sZm7ZjyisZItyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KE0vJp4bx2DHbMf9A01/RB2WNDwbrQwCUskMQ6oJxroXHMtybMPyjbtxaCfCoIVzI
	 Ul0W40Jq20qzdtQ/8GHvpNNcqNtfSONOz8QAVey/XpxUmBdnjygDWsyf9azXl7AFD4
	 gd/jCR+YOZOgiNZQVXPX3FArpOoxlkCZSkdfTpLF8rC60gTVUSjezlBAbSMwBX5FS8
	 k/4RhmEiny6qtQWoF/ZIrRDzQ1ndmUBwNX6Xy0k4dcc2VSm4qEvwUDErtrNPik4BeS
	 K8n3NmnQv00GOVzidLbbw/c1cINeYgh5xcefVzubaptXyGxiMZr9HTNTVk9IAgGHPu
	 nNsg+t0U+yHkg==
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
Subject: [PATCH 3/5] x86/its: move its_pages array to struct mod_arch_specific
Date: Tue,  3 Jun 2025 14:14:43 +0300
Message-ID: <20250603111446.2609381-4-rppt@kernel.org>
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

The of pages with ITS thunks allocated for modules are tracked by an
array in 'struct module'.

Since this is very architecture specific data structure, move it to
'struct mod_arch_specific'.

No functional changes.

Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/include/asm/module.h |  8 ++++++++
 arch/x86/kernel/alternative.c | 19 ++++++++++---------
 include/linux/module.h        |  5 -----
 3 files changed, 18 insertions(+), 14 deletions(-)

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
index 45bcff181cba..372ef5dff631 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -195,8 +195,8 @@ void its_fini_mod(struct module *mod)
 	its_page = NULL;
 	mutex_unlock(&text_mutex);
 
-	for (int i = 0; i < mod->its_num_pages; i++) {
-		void *page = mod->its_page_array[i];
+	for (int i = 0; i < mod->arch.its_pages.num; i++) {
+		void *page = mod->arch.its_pages.pages[i];
 		execmem_restore_rox(page, PAGE_SIZE);
 	}
 }
@@ -206,11 +206,11 @@ void its_free_mod(struct module *mod)
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
 
@@ -223,14 +223,15 @@ static void *its_alloc(void)
 
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
index 8050f77c3b64..b3329110d668 100644
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
-- 
2.47.2


