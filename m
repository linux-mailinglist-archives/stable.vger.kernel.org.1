Return-Path: <stable+bounces-139559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CF1AA856A
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 11:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF713AC03D
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 09:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9379C199931;
	Sun,  4 May 2025 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+QS6DPY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D018479;
	Sun,  4 May 2025 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746350484; cv=none; b=oWpodp4rKlifkNv+mf/BvNJ91HG309LZb1gRO6jjTxO6dZq+EzdGRbzCdHhZRBQfGMx9g+84H47qWBVfuDL+7ccBcCIdkUshBB4B22JeQ5C3mBdLrPNTIiCSkUEKeIErAU1HjgsBNG0zygFpcc62HJn0KsOlFnP61Yh1Cc3Fx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746350484; c=relaxed/simple;
	bh=ax8+aRdxPyEaO+MlNJoulX1KawP6Rs1aBWyJrGcNdL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkgjQV6JvCrKiJ8zA/F7SLtiHWKbzFtm41Ds/ktmv9G0J7YyQjxMtrBIKQ3vuWqMcoX5oV28/WcZ4w/XixBY7GPR0CTgXDvPuEEtJ3o9vbLf3xrCxUtQMBrsbVDJI6i0AreG33paj0yxYCh9aVWNSBzVpV+LIY+DZBRn0oBESNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+QS6DPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B48C4CEE7;
	Sun,  4 May 2025 09:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746350483;
	bh=ax8+aRdxPyEaO+MlNJoulX1KawP6Rs1aBWyJrGcNdL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+QS6DPY9q4fhLxirBHWrjszL2aPuk5iebh+Hj9bxIeszCWrtxnwRvbcrGsmvznX3
	 4kkFRyl+tREe3pUrNNsQmCU3zaTOwzw2wfKgHXe5b2pXlUTqHPSUsqAl7cPU3WGMxT
	 Qn9mKC4U4+q0YnPLAbth71mQdTCAu2kGlUwqxcE5OaWjUaiC0hih1QmzeQLNl5PpUe
	 bQhXPfrpFaPOTJEoPfRul+hdI/eT4ooYFWB4BpdngZeVM/6eZxTAsz4WkvBO3EXMlv
	 vqoKoUT0E/qdxT7d66pSTZpqPKCWoz+WXH59pV1ZKnbAPykVhjx9JYlutXWmk4HgVm
	 1pI9LATlp6LHw==
Date: Sun, 4 May 2025 11:21:18 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, bp@alien8.de, thomas.lendacky@amd.com,
	hpa@zytor.com, michael.roth@amd.com, nikunj@amd.com,
	seanjc@google.com, ardb@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v4] x86/sev: Fix making shared pages private during kdump
Message-ID: <aBcxjsdC4tsIgIf2@gmail.com>
References: <20250502212143.578866-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502212143.578866-1-Ashish.Kalra@amd.com>


* Ashish Kalra <Ashish.Kalra@amd.com> wrote:

>  
> -			if (addr <= ghcb && ghcb <= addr + size) {
> +			/* Handle the case of a huge page containing the GHCB page */
> +			if (addr <= ghcb && ghcb < addr + size) {
>  				skipped_addr = true;
>  				break;
>  			}
> @@ -1131,9 +1132,8 @@ static void shutdown_all_aps(void)
>  void snp_kexec_finish(void)
>  {
>  	struct sev_es_runtime_data *data;
> +	unsigned long size, mask, ghcb;
>  	unsigned int level, cpu;
> -	unsigned long size;
> -	struct ghcb *ghcb;

So this patch just morphs the type of 'ghcb' from a typed pointer to 
unsigned long, while most 'ghcb' uses in coco/ are typed pointers?

That's just sloppy and fragile. Please just keep 'ghcb' a typed 
pointer, and introduce *another* variable for the virtual address to 
the hugepage.

>  	pte_t *pte;
>  
>  	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> @@ -1157,11 +1157,14 @@ void snp_kexec_finish(void)
>  
>  	for_each_possible_cpu(cpu) {
>  		data = per_cpu(runtime_data, cpu);
> -		ghcb = &data->ghcb_page;
> -		pte = lookup_address((unsigned long)ghcb, &level);
> +		ghcb = (unsigned long)&data->ghcb_page;

If 'ghcb' has the proper type then this ugly forced type-cast goes 
away.

> +		pte = lookup_address(ghcb, &level);
>  		size = page_level_size(level);
> +		mask = page_level_mask(level);
> +		/* Handle the case of a huge page containing the GHCB page */
> +		ghcb &= mask;

This too calls for using a separate variable for this, because after 
this masking 'ghcb' is very much *not* the location of a GHCB page 
anymore...

>  		set_pte_enc(pte, level, (void *)ghcb);
> -		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
> +		snp_set_memory_private(ghcb, (size / PAGE_SIZE));

Do we know whether this is safe? Could the huge page around the GHCB 
page contain anything else? What is the structure of this memory area, 
is it all dedicated to the GHCB, or could it contain random other data?

Thanks,

	Ingo

