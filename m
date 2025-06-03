Return-Path: <stable+bounces-150718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBD4ACC88C
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 15:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5866C173D82
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3AA231A55;
	Tue,  3 Jun 2025 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wAbAVYtN"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57FD1DFF8;
	Tue,  3 Jun 2025 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959136; cv=none; b=b8Vbs2ww2WgTswFwSBqRpDonjGOCkjJjFVTdyZoG021ZKHhth8+uvisBqNul5XPS9Tn8ir3Nf0jl3We6v5V3mwtiDTpfG4XnhoxT7jXttnN5f3DiQzPlnDRnBJZCrOitF/6d28VHvvXoa7JrE3VtHim2LwZNPvUp39DqQsvwDjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959136; c=relaxed/simple;
	bh=j5N9G+nyk7+XghWSjF4Qe/rQo8Nq2qXo1/v145Lf3FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhTMDAutWiLHy52LWsqXzeTeyd7I+/A+uitqnQawrnaIUCPC/cQgf9Rb3GaWFbS2wAtCHt2hY2zl4d1KlU0grhE9CtwKSBV0PGS97pndt4dBlN3601gEwmNUM/lq5+SFoIIQ6C1JazntzckR1aqEokzjEzXl+5RDAXOJxitm+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wAbAVYtN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6MP6zOtCaG9WYZELPPHBRIx4k+xnrNHoojsmFur+VLU=; b=wAbAVYtN36EzsXXrHITfdPFHH5
	jgAiTcxdpnvhnOl3qST5v3KFs5qtP40d5NDx2eioSzP5avd6whShorzHTpENm4EBqTZabXvBiAxci
	+sibE16411TlsEt8mdCJcA8aKWPTvKDLLZZV8BhV3G5faexbLdgfdw+wY2hbEJj0eSCMvaraRBvQG
	jdoec+At5nGWLh/k+mPzGOtZ6fzBgPopL3CVTW9u+SkRJXsquUd1UbyuNzknycsplw+O3yNvsJgfD
	8WnYdAgqA8AkFcSNPchkDi/FdPCW564dSAUpIvvjufnoBHO+yCrn8cL2qlY0cLONWkdMCRMwDzM9k
	ooLM1jtw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMSAB-000000025Um-0gwD;
	Tue, 03 Jun 2025 13:58:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B6E54300780; Tue,  3 Jun 2025 15:58:45 +0200 (CEST)
Date: Tue, 3 Jun 2025 15:58:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	=?utf-8?B?Su+/vXJnZW4=?= Gro <jgross@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, Xin Li <xin@zytor.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 4/5] x86/its: explicitly manage permissions for ITS pages
Message-ID: <20250603135845.GA38114@noisy.programming.kicks-ass.net>
References: <20250603111446.2609381-1-rppt@kernel.org>
 <20250603111446.2609381-5-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603111446.2609381-5-rppt@kernel.org>

On Tue, Jun 03, 2025 at 02:14:44PM +0300, Mike Rapoport wrote:
> From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> 
> execmem_alloc() sets permissions differently depending on the kernel
> configuration, CPU support for PSE and whether a page is allocated
> before or after mark_rodata_ro().
> 
> Add tracking for pages allocated for ITS when patching the core kernel
> and make sure the permissions for ITS pages are explicitly managed for
> both kernel and module allocations.
> 
> Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---

How about something like this on top?

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -121,7 +121,6 @@ struct its_array its_pages;
 static void *__its_alloc(struct its_array *pages)
 {
 	void *page __free(execmem) = execmem_alloc(EXECMEM_MODULE_TEXT, PAGE_SIZE);
-
 	if (!page)
 		return NULL;
 
@@ -172,6 +171,9 @@ static void *its_init_thunk(void *thunk,
 
 static void its_pages_protect(struct its_array *pages)
 {
+	if (!IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
+		return;
+
 	for (int i = 0; i < pages->num; i++) {
 		void *page = pages->pages[i];
 		execmem_restore_rox(page, PAGE_SIZE);
@@ -180,8 +182,7 @@ static void its_pages_protect(struct its
 
 static void its_fini_core(void)
 {
-	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
-		its_pages_protect(&its_pages);
+	its_pages_protect(&its_pages);
 	kfree(its_pages.pages);
 }
 
@@ -207,8 +208,7 @@ void its_fini_mod(struct module *mod)
 	its_page = NULL;
 	mutex_unlock(&text_mutex);
 
-	if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
-		its_pages_protect(&mod->arch.its_pages);
+	its_pages_protect(&mod->arch.its_pages);
 }
 
 void its_free_mod(struct module *mod)
@@ -222,40 +222,29 @@ void its_free_mod(struct module *mod)
 	}
 	kfree(mod->arch.its_pages.pages);
 }
+#endif /* CONFIG_MODULES */
 
-static void *its_alloc_mod(void)
+static void *its_alloc(void)
 {
-	void *page = __its_alloc(&its_mod->arch.its_pages);
-
-	if (page)
-		execmem_make_temp_rw(page, PAGE_SIZE);
+	struct its_array *pages = &its_pages;
+	void *page;
 
-	return page;
-}
-#endif /* CONFIG_MODULES */
+#ifdef CONFIG_MODULE
+	if (its_mod)
+		pages = &its_mod->arch.its_pages;
+#endif
 
-static void *its_alloc_core(void)
-{
-	void *page = __its_alloc(&its_pages);
+	page = __its_alloc(pages);
+	if (!page)
+		return NULL;
 
-	if (page) {
-		execmem_make_temp_rw(page, PAGE_SIZE);
+	execmem_make_temp_rw(page, PAGE_SIZE);
+	if (pages == &its_pages)
 		set_memory_x((unsigned long)page, 1);
-	}
 
 	return page;
 }
 
-static void *its_alloc(void)
-{
-#ifdef CONFIG_MODULES
-	if (its_mod)
-		return its_alloc_mod();
-#endif /* CONFIG_MODULES */
-
-	return its_alloc_core();
-}
-
 static void *its_allocate_thunk(int reg)
 {
 	int size = 3 + (reg / 8);

