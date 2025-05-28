Return-Path: <stable+bounces-147983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCBBAC6DCD
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 18:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B8E1C00EBB
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A4828C852;
	Wed, 28 May 2025 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V4UGRwzH"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9ED28C86C;
	Wed, 28 May 2025 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449040; cv=none; b=U2UZ/q0mNFxfbe08HCEzp1bgCNGUCTMIVSsNOwlndrpJNlgsF/CLLViARZCesEKqc8N/H3gAFOxoek96slh/c/pb9FOifl9CwJ8r28akHiTKmI1uRpxry5eHMLU+D/a2XnGvfSOM3djwhdYDRgK+2mhZp8AwwWJs3L+Vq7Ntizc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449040; c=relaxed/simple;
	bh=yopJ+ym4D4c9GzOgtMMZbZiSB/BS+gRQB3VNJDJpKno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDWrPPzI1lDS4pTlaojI1SCE/8sq7sXlTLwBua/5W9mXG/VrDA24Nl+jVF99qp7DRGW1ycJEHkwsiR6+Hgk5+WrOwDfy6PzAxuueEk+hmZpP1+Itwd/7FxvYp46/uPeXlLuRLE6sEkebrSFwqvDd7TPMjT5Zh0VpTOk0R8/D0XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V4UGRwzH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=q860hmjFs3SsTHThmi8S1+4vy1FQNl3Npyj99yAH26Q=; b=V4UGRwzH7m7HaKgEiedURF+qIz
	RHmseAiWu0Oh0YUeZOj4Xb6RfATorkFQSfzqwwNgNM/x3LONbWDsRqHZDH8xYz1mLVOj6l0wH3llt
	3IOIS7r9bqEMLgXOMAYw1C7+vsGT35vsQ7lcQosxB9cey4VaU6g3TqyT/JE7vpcWuKbnYNxKJJd6m
	EnNlJlcnEQpiVBNgIjdAAGuteyue3HXq9437Iy1NyxmTRDPv5ME2MzvOwW1SGR6KxsnGhJrGb9mqZ
	usmGv9wsiUmW3gAqyWZ5N9c+NHfM+lYuqbmwF0ObnbtGRHGItMiy4meng6thvsxtdXFgLj1yOrNI9
	O62f+jIA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKJSq-0000000Dpsx-32zs;
	Wed, 28 May 2025 16:17:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 376633005AF; Wed, 28 May 2025 18:17:12 +0200 (CEST)
Date: Wed, 28 May 2025 18:17:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org,
	rppt@kernel.org
Subject: Re: [PATCH 3/3] x86/alternative: make kernel ITS thunks read-only
Message-ID: <20250528161712.GG31726@noisy.programming.kicks-ass.net>
References: <20250528123557.12847-1-jgross@suse.com>
 <20250528123557.12847-4-jgross@suse.com>
 <20250528131052.GZ39944@noisy.programming.kicks-ass.net>
 <044f0048-95bb-4822-978e-a23528f3891f@suse.com>
 <20250528132231.GB39944@noisy.programming.kicks-ass.net>
 <7c8bf4f5-29a0-4147-b31a-5e420b11468e@suse.com>
 <20250528155821.GD39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250528155821.GD39944@noisy.programming.kicks-ass.net>

On Wed, May 28, 2025 at 05:58:21PM +0200, Peter Zijlstra wrote:
> On Wed, May 28, 2025 at 03:30:33PM +0200, Jürgen Groß wrote:
> 
> > Have a look at its_fini_mod().
> 
> Oh, that's what you mean. But this still isn't very nice, you now have
> restore_rox() without make_temp_rw(), which was the intended usage
> pattern.
> 
> Bah, I hate how execmem works different for !PSE, Mike, you see a sane
> way to fix this?
> 
> Anyway, if we have to do something like this, then I would prefer it
> shaped something like so:
> 

Missing file:

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

> ---
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index ecfe7b497cad..33d4d139cb50 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -111,9 +111,8 @@ static bool cfi_paranoid __ro_after_init;
>  
>  #ifdef CONFIG_MITIGATION_ITS
>  
> -#ifdef CONFIG_MODULES
>  static struct module *its_mod;
> -#endif
> +static struct its_array its_pages;
>  static void *its_page;
>  static unsigned int its_offset;
>  
> @@ -151,68 +150,78 @@ static void *its_init_thunk(void *thunk, int reg)
>  	return thunk + offset;
>  }
>  
> -#ifdef CONFIG_MODULES
>  void its_init_mod(struct module *mod)
>  {
>  	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
>  		return;
>  
> -	mutex_lock(&text_mutex);
> -	its_mod = mod;
> -	its_page = NULL;
> +	if (mod) {
> +		mutex_lock(&text_mutex);
> +		its_mod = mod;
> +		its_page = NULL;
> +	}
>  }
>  
>  void its_fini_mod(struct module *mod)
>  {
> +	struct its_array *pages = &its_pages;
> +
>  	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
>  		return;
>  
>  	WARN_ON_ONCE(its_mod != mod);
>  
> -	its_mod = NULL;
> -	its_page = NULL;
> -	mutex_unlock(&text_mutex);
> +	if (mod) {
> +		pages = &mod->arch.its_pages;
> +		its_mod = NULL;
> +		its_page = NULL;
> +		mutex_unlock(&text_mutex);
> +	}
>  
> -	for (int i = 0; i < mod->its_num_pages; i++) {
> -		void *page = mod->its_page_array[i];
> +	for (int i = 0; i < pages->num; i++) {
> +		void *page = pages->pages[i];
>  		execmem_restore_rox(page, PAGE_SIZE);
>  	}
> +
> +	if (!mod)
> +		kfree(pages->pages);
>  }
>  
>  void its_free_mod(struct module *mod)
>  {
> +	struct its_array *pages = &its_pages;
> +
>  	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
>  		return;
>  
> -	for (int i = 0; i < mod->its_num_pages; i++) {
> -		void *page = mod->its_page_array[i];
> +	if (mod)
> +		pages = &mod->arch.its_pages;
> +
> +	for (int i = 0; i < pages->num; i++) {
> +		void *page = pages->pages[i];
>  		execmem_free(page);
>  	}
> -	kfree(mod->its_page_array);
> +	kfree(pages->pages);
>  }
> -#endif /* CONFIG_MODULES */
>  
>  static void *its_alloc(void)
>  {
> -	void *page __free(execmem) = execmem_alloc(EXECMEM_MODULE_TEXT, PAGE_SIZE);
> +	struct its_array *pages = &its_pages;
> +	void *tmp;
>  
> +	void *page __free(execmem) = execmem_alloc(EXECMEM_MODULE_TEXT, PAGE_SIZE);
>  	if (!page)
>  		return NULL;
>  
> -#ifdef CONFIG_MODULES
> -	if (its_mod) {
> -		void *tmp = krealloc(its_mod->its_page_array,
> -				     (its_mod->its_num_pages+1) * sizeof(void *),
> -				     GFP_KERNEL);
> -		if (!tmp)
> -			return NULL;
> +	tmp = krealloc(pages->pages, (pages->num + 1) * sizeof(void *), GFP_KERNEL);
> +	if (!tmp)
> +		return NULL;
>  
> -		its_mod->its_page_array = tmp;
> -		its_mod->its_page_array[its_mod->its_num_pages++] = page;
> +	pages->pages = tmp;
> +	pages->pages[pages->num++] = page;
>  
> +	if (its_mod)
>  		execmem_make_temp_rw(page, PAGE_SIZE);
> -	}
> -#endif /* CONFIG_MODULES */
>  
>  	return no_free_ptr(page);
>  }
> @@ -2338,6 +2347,8 @@ void __init alternative_instructions(void)
>  	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
>  	apply_returns(__return_sites, __return_sites_end);
>  
> +	its_fini_mod(NULL);
> +
>  	/*
>  	 * Adjust all CALL instructions to point to func()-10, including
>  	 * those in .altinstr_replacement.

