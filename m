Return-Path: <stable+bounces-147959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA12AC6A11
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3077B4E2A5B
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC1286433;
	Wed, 28 May 2025 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oewuF3I5"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAE17E9;
	Wed, 28 May 2025 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748437860; cv=none; b=FXfQX0RrLvaay0seDFZD06E96pT5W4EfQ6HLvePDM0RopNKS3DAmGW4+kX0Oi8au/pGR/+NNXsK/Txz1eS4oulXznbrYTVkpd7v2qMSl/J8YvpbJFh5VIK7/lsL/k2wWYns3dpF4deTsot2L+D9KHJl/Hi94vwzqRM9NwLWZMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748437860; c=relaxed/simple;
	bh=KpW/GiAaO4IEYVE6pBKqBoHdlU5iOrI46SKaEKNozU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB3cqgBjMDHwN1ImM4PPbfplYayvZlrjEr2O/YjKjGjAg71WhOfVKGvpaeHQZaRAv9Tvzho2BTm876bRxY8kTatku83THwj9o/A+AsT4y44BIW7uwKxqUFYJ5SKpsXJB7UQFrsU5VFm/W2Uw6HTbLod7OXi3OjtNMFT7jBC6pXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oewuF3I5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rI1fCTktbDZK+H9GNDwtSrkRyZD7L6P9hnuVyfA7BUo=; b=oewuF3I5HpADvb9JIl1NwmNqrM
	XDhuRIk63Y5TizxQOMADXEbIjqN7Ib7FNVPF5ES9wGipGJTWNfNWLlgLWVlPv4oaoFx25hrJYh6hH
	/R/+RXWkhnuMFaf7SYY+zVLsP8fRby1ZvDNj93tL1p8Nv/5987vhSx7v0MUXpJWPOtMPVDxjuQOfE
	9jr+IxpFHkrX4bNrdRGIKPCfr56k7Cql7UTptKK/E5tmLg+DRRGCyaBbSf+YIiu4l1bajlYd912Ja
	5nyu2lC4iuuKP1Xdh/zSxkl38Xn+i+mlWodTGbFM1nk1F/qI4D0qsRvruXTfE2s7cgu6z2g5AVOEW
	S4Wgd7Iw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKGYX-0000000DfGu-14zX;
	Wed, 28 May 2025 13:10:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AB4E8300263; Wed, 28 May 2025 15:10:52 +0200 (CEST)
Date: Wed, 28 May 2025 15:10:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/alternative: make kernel ITS thunks read-only
Message-ID: <20250528131052.GZ39944@noisy.programming.kicks-ass.net>
References: <20250528123557.12847-1-jgross@suse.com>
 <20250528123557.12847-4-jgross@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528123557.12847-4-jgross@suse.com>

On Wed, May 28, 2025 at 02:35:57PM +0200, Juergen Gross wrote:
> When allocating memory pages for kernel ITS thunks, make them read-only
> after having written the last thunk.
> 
> This will be needed when X86_FEATURE_PSE isn't available, as the thunk
> memory will have PAGE_KERNEL_EXEC protection, which is including the
> write permission.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 5185e7f9f3bd ("x86/module: enable ROX caches for module text on 64 bit")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/kernel/alternative.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index ecfe7b497cad..bd974a0ac88a 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -217,6 +217,15 @@ static void *its_alloc(void)
>  	return no_free_ptr(page);
>  }
>  
> +static void its_set_kernel_ro(void *addr)
> +{
> +#ifdef CONFIG_MODULES
> +	if (its_mod)
> +		return;
> +#endif
> +	execmem_restore_rox(addr, PAGE_SIZE);
> +}
> +
>  static void *its_allocate_thunk(int reg)
>  {
>  	int size = 3 + (reg / 8);
> @@ -234,6 +243,8 @@ static void *its_allocate_thunk(int reg)
>  #endif
>  
>  	if (!its_page || (its_offset + size - 1) >= PAGE_SIZE) {
> +		if (its_page)
> +			its_set_kernel_ro(its_page);
>  		its_page = its_alloc();
>  		if (!its_page) {
>  			pr_err("ITS page allocation failed\n");
> @@ -2338,6 +2349,11 @@ void __init alternative_instructions(void)
>  	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
>  	apply_returns(__return_sites, __return_sites_end);
>  
> +	/* Make potential last thunk page read-only. */
> +	if (its_page)
> +		its_set_kernel_ro(its_page);
> +	its_page = NULL;
> +
>  	/*
>  	 * Adjust all CALL instructions to point to func()-10, including
>  	 * those in .altinstr_replacement.

No, this is all sorts of wrong. Execmem API should ensure this.

