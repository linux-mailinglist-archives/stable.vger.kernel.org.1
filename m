Return-Path: <stable+bounces-150720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B660CACC934
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 16:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8045B1675E4
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 14:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B02C23535B;
	Tue,  3 Jun 2025 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msAFfD4F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070BD1DB366;
	Tue,  3 Jun 2025 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961409; cv=none; b=o9guluLIRhq7dnahjsUqUXoKdywd4riOnHPm5D3C4AwRmJWdJ32ePds5dUEBR9Bcm4KNa+X6CcTwMl5g1K+FOPJD+Xo4rcR8wIyHmA3OyD5BngXZ9Ej94Jufr/y7HxZIpGp1UzgbRofzEDUqNwSCBqL7kYM/IT4PZiYrOh7ysgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961409; c=relaxed/simple;
	bh=chuk0IazGmGSV4OgO+a1HkDeBrU6hVZtfNkD4mhEae4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dle6dqisQsolNroZhzQK5D7HYm9XHb3XTMfVwNfhYfEf0daxBRIarGN300bQC5UmttVZ+R2HXz1KYOpvFy1W4v5h/ZB8/+7x4WD3yytHsFDwiVJwfKaKx0WRLNHtYPIvcF0USbu44A9l4n+kXO8RwOef46rXDYS+cTxvznFQcGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msAFfD4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0BEC4CEED;
	Tue,  3 Jun 2025 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748961408;
	bh=chuk0IazGmGSV4OgO+a1HkDeBrU6hVZtfNkD4mhEae4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msAFfD4F47qbZ1+4PfMXz//gQiIv2ar8v3PYfcVcHL0PTVWlUFmMG7JKZqMQbPmDj
	 WmeStKDIIq6FigoPVWYLVW112Ls5/mNkWTANbCnEvHwEdb3QpphfpewF+2qJablnBk
	 lQrXOkCdD4kB/9pS/P1APj0sXAxI5woN2zsh5gNc8cLkEXVgDZgw3AkPLD6MZtTUSE
	 YoPVGzl4xgbeO9y9ecCse+3g4P2j+O59h06mIL1FfssPYVQ6NK8unF0KuozFhQhARi
	 nmL5t4Q445AWF4jE9CDSJFyEedaxyJfLwA+yNtOAm+Hy2/AZsCPwXn1sG6o4gO4e5U
	 ggsMdA1PBvheg==
Date: Tue, 3 Jun 2025 17:36:41 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	=?utf-8?B?Su+/vXJnZW4=?= Gro <jgross@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, Xin Li <xin@zytor.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 4/5] x86/its: explicitly manage permissions for ITS pages
Message-ID: <aD8IeQLZUDvgoQZm@kernel.org>
References: <20250603111446.2609381-1-rppt@kernel.org>
 <20250603111446.2609381-5-rppt@kernel.org>
 <20250603135845.GA38114@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603135845.GA38114@noisy.programming.kicks-ass.net>

On Tue, Jun 03, 2025 at 03:58:45PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 03, 2025 at 02:14:44PM +0300, Mike Rapoport wrote:
> > From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > 
> > execmem_alloc() sets permissions differently depending on the kernel
> > configuration, CPU support for PSE and whether a page is allocated
> > before or after mark_rodata_ro().
> > 
> > Add tracking for pages allocated for ITS when patching the core kernel
> > and make sure the permissions for ITS pages are explicitly managed for
> > both kernel and module allocations.
> > 
> > Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> 
> How about something like this on top?

Works for me :)

> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -121,7 +121,6 @@ struct its_array its_pages;
>  static void *__its_alloc(struct its_array *pages)
>  {
>  	void *page __free(execmem) = execmem_alloc(EXECMEM_MODULE_TEXT, PAGE_SIZE);
> -
>  	if (!page)
>  		return NULL;
>  
> @@ -172,6 +171,9 @@ static void *its_init_thunk(void *thunk,
>  
>  static void its_pages_protect(struct its_array *pages)
>  {
> +	if (!IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
> +		return;
> +

But modules generally use STRICT_MODULE_RWX.
Do you want to make the its pages stricter than normal module text?

>  	for (int i = 0; i < pages->num; i++) {
>  		void *page = pages->pages[i];
>  		execmem_restore_rox(page, PAGE_SIZE);
> @@ -180,8 +182,7 @@ static void its_pages_protect(struct its
>  
>  static void its_fini_core(void)
>  {
> -	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
> -		its_pages_protect(&its_pages);
> +	its_pages_protect(&its_pages);
>  	kfree(its_pages.pages);
>  }
>  
> @@ -207,8 +208,7 @@ void its_fini_mod(struct module *mod)
>  	its_page = NULL;
>  	mutex_unlock(&text_mutex);
>  
> -	if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> -		its_pages_protect(&mod->arch.its_pages);
> +	its_pages_protect(&mod->arch.its_pages);
>  }

-- 
Sincerely yours,
Mike.

