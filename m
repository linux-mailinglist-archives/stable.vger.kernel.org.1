Return-Path: <stable+bounces-150697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF8AACC52E
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27EBB189436A
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966741A0BE0;
	Tue,  3 Jun 2025 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gev/ZKTW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5F2C325E;
	Tue,  3 Jun 2025 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949429; cv=none; b=V4oFXhj16/LeXWslfHVj2Z8/JGhm28n06P6D4FSIpuUu+hAw60+1sc7KWkHTWsz2zC99pmOzo+FFnBk0jbvZ9YtNC8pQKnA5m/UUqZ9X8tbIKmDTyQ+SegvmqHM8vNJyJWumE4m0Uh4UNYCuZ9hBB6sq2vNhS/Q4CQHzpoLDOhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949429; c=relaxed/simple;
	bh=vIP1JycWXJelHDW71e542yvIuWxbH+nvHLG1zpYF74o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KISHr+KZ6Oep7ylXPmJx/vN7P5zelbmWKMr6KjBx2W+lLsfz6MXqY3kynyYefZh3sxjVnJuqqMDy+30BYO+M9LPDnwPuVoe4XUhE+d7cC3XQE1dLLe021MV1kbnovF9JssZ871ZjxOQ2UjIQTM94rZH1V7YbXHf2uvfIzZwAonc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gev/ZKTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A40DC4CEED;
	Tue,  3 Jun 2025 11:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748949428;
	bh=vIP1JycWXJelHDW71e542yvIuWxbH+nvHLG1zpYF74o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gev/ZKTWcYllNJJEi7FnroPx1QKF23Hs9HlbaVAzMBiCV70fS398SjhVVQvYYy/hD
	 rns2UoNEIyt1cqU5jvTKip8infxvS/be1fqmk2RHQfCT78BGK9hPcUtIicMZxbBtqC
	 cWbFk2bnjIFzvNvLVxIyGwlsLwurzLPk5SPQRfzDRK8wN2Vjq5AYXwrK3C/gnve9sa
	 QpHhImoWih2pu5wuxkV5pclDFz5QeGEyRSVbTZSNbzYlwkoM6W3LwToFqHbGnvgL3i
	 y0n6zAyx+/73ZUgBfvsqzDGvmgZ7Cz7wS7eHx6szpWWd3Wf6tgDaYQIj2SMPh/HMle
	 venj7gf4SeiwQ==
Date: Tue, 3 Jun 2025 14:17:01 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/alternative: make kernel ITS thunks read-only
Message-ID: <aD7ZrYr4we-S7s7b@kernel.org>
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

I expanded this a bit and here's what I've got:

https://lore.kernel.org/lkml/20250603111446.2609381-1-rppt@kernel.org/ 

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

