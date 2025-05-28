Return-Path: <stable+bounces-147989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E47BAC6F44
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 19:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8193B9092
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ADC28CF7F;
	Wed, 28 May 2025 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQGDWWY4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DBC28C5CD;
	Wed, 28 May 2025 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748453083; cv=none; b=AiC2w+JIRfSTpMyztlQ3vI5WShqQoYODoPAOrgDTXyn75hnOO85XLWbrsEJNKUdk9ucScikHIs6leCc6umrh47SVOV4+pm6SI5o6+WzQg/rkIbPmawVP0oxkb4o4v1mLmUpMQlc/GNzrH6KswPkEeuC8IHktLtfcwbgb0hjTN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748453083; c=relaxed/simple;
	bh=xl+HiA5fKcIkxj9tC9RYJv/z6ok1+kvXmKS4mrZe1yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/7b5z233U5Tt592hNx5y2EulxNz59FeMLVtQRCDEKx8ssBNU5FLhRwB0KXV8T6U4uPy+DoCnHB03dT/BTa5kN2wYML9xRLDqgS53GwSY6LaN5ijPGr3FAiuk2+Yk6AB969rNOPYpWVmNI19CIlt6IW2WePd1K2I8KJ/w6b52Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQGDWWY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07719C4CEED;
	Wed, 28 May 2025 17:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748453082;
	bh=xl+HiA5fKcIkxj9tC9RYJv/z6ok1+kvXmKS4mrZe1yQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQGDWWY4RxXpI1BJNG3aGyloC7hTGfN72V52PM8GHltRqJcyj3kH2JlCT0ocipFXM
	 gYawpFMlZwcpPMnN2awtU+odn01+CYDC/TfVacqWqvDrGeImfGEMd1a2VcAtkkTr+1
	 PWgxHD4JUWE2Ngzsu7yeipX2hr90I81H3Kxf5jnLyO5UmkrpGdltIXqJvGITFz8pKu
	 rloqohx8uszXcdHIYJR4F8QXX6bLRVBblNBgPuT7F57aNecC0agUmrlqHG3f45J9xw
	 4Pd1F1nDW4QSDPngOLDYzHTpNcfsaTxvwbikvscuRi4lsYDhmCrbaghoIKE5vr8NFj
	 L2jYeoGheanBw==
Date: Wed, 28 May 2025 20:24:35 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/alternative: make kernel ITS thunks read-only
Message-ID: <aDdG09zhIddI6Wty@kernel.org>
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

Not really :(

But just resetting permissions in the end like you did makes perfect sense
to me. It's like STRICT_MODULE_RWX, somebody has to set the pages to ROX at
some point and running execmem_restore_rox() on something that was already
ROX won't cost much, set_memory will bail out early.

> Anyway, if we have to do something like this, then I would prefer it
> shaped something like so:
> 
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

-- 
Sincerely yours,
Mike.

