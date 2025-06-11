Return-Path: <stable+bounces-152403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D958AD4FD0
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 11:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABB43A45FE
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 09:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB62E263892;
	Wed, 11 Jun 2025 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MTplX32p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iTPw0q50"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF6F253340;
	Wed, 11 Jun 2025 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634234; cv=none; b=LBdEfRqY8FT6Jq+/JVbvZtiOB4dtZdLb73cFM1S5fP9BNQc3N4T0kq5mwRgj4F5vwG2IMNzjC2Antl1Cf79PdT0q9YQlqMuEIAXw9b5fwLqHUR1a4JtOycL/TSrlF/r4paMwgAY0PJOV/4pDGLmMuAx+Wt533qVgXiu3F5j24tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634234; c=relaxed/simple;
	bh=cyfUg3UCeS4VmboH9A7HvIM9GYPGxEZ71wzK5D+pysY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=spIARiq0REjkJbH5mv+60K+xG2s8Y68iBLZDua4gfju+4DPjVR7dcj8eX207/g7X3Kc5Xv34FBjEFUJ5C1rTcAlxzXN5OY3yZk+fLqaNDKMrw21LrBXETYpMDPeOcQVjkUBEx4QryRKOvrsL7lHs2vUNFW9xKM/GsvLgs3QXnJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MTplX32p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iTPw0q50; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:30:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749634231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YOicoXXP8zGw5+DPmgbLmsRPXOYqBys+XV9xC5ubN/E=;
	b=MTplX32pplDMsLquRScbA6g917fSHUh8dpa9m47eAaJxVF7CiG95L+O7i/X9XemgxuWWzr
	iEHBRuC/2ywf2EIuf9rscAsSv2Zkg18EFIA06YBr5o+6Kz8NPGv60GB6uQU7hDkfZzqeLM
	ddje+pqWbLMN/K0dPq6r+x79pD0CvkJdYMMHuVyJ6rvPlOg5PANXDnPyRjEXWmqfCUUoLj
	vEf0LA2sdguR81wpQ0QiZW+EzpKQNLN91tDfsp0BFNJTgnd5bR8g0FeoWagyiwdoxMAwq2
	9mPGdmXljAtNH5iTeZ2l1uHDIZhmaNskM9u3uidt8bHW993HQ5Xrmka96q77eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749634231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YOicoXXP8zGw5+DPmgbLmsRPXOYqBys+XV9xC5ubN/E=;
	b=iTPw0q50EkGxF5TBfg1ksfZXNuR0MD7rwXf9Rw1J5JFYk+7TE3jSCik/sU2vdIIZiwL5kP
	sa4Af8dJmg2guwAw==
From: "tip-bot2 for Mike Rapoport (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/its: move its_pages array to struct mod_arch_specific
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250603111446.2609381-4-rppt@kernel.org>
References: <20250603111446.2609381-4-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963423007.406.3585953198148089593.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0b0cae7119a0ec9449d7261b5e672a5fed765068
Gitweb:        https://git.kernel.org/tip/0b0cae7119a0ec9449d7261b5e672a5fed765068
Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate:    Tue, 03 Jun 2025 14:14:43 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 Jun 2025 11:20:51 +02:00

x86/its: move its_pages array to struct mod_arch_specific

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
---
 arch/x86/include/asm/module.h |  8 ++++++++
 arch/x86/kernel/alternative.c | 19 ++++++++++---------
 include/linux/module.h        |  5 -----
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
index e988bac..3c2de4c 100644
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
index ecfe7b4..b50fe6c 100644
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
index 92e1420..5faa1fb 100644
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

