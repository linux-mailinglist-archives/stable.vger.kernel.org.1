Return-Path: <stable+bounces-214340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC9YJnOUg2mppgMAu9opvQ
	(envelope-from <stable+bounces-214340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 19:48:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F60EBBEE
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 19:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D5D93010141
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 18:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613EF34AAE2;
	Wed,  4 Feb 2026 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+sFaaV6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A52346AFC;
	Wed,  4 Feb 2026 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770230896; cv=none; b=pdSlI8PJXpghjtQ80MvcYH7ZJaWzUn+dpHDdjy5UtBfFoO/VhhLDdlNiCxKXRxnMZRm5KR3JcV9wF1NTot8EIejQpcvT+oW2DN9kivX/FkgBNsrZeAS+Ct8TJseZSOwmYGi7acI2FbPT1i+DV5Szsrlvd1UsTxJdoyi94LfbaYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770230896; c=relaxed/simple;
	bh=5dffcEdKgAFcYj3WU+q5x5hHwMm4789JM2jaUUQpS8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAWqyMjO1JGIKUQ50y120EIeCIuCIAvZpAEe4mBVcLyPZ2P+kzrw0JUcDJ/JNzrFTGXa+r0U8zs0ouYM2yrPtgmknpFW+9g8/s27qlPk+GhhRLyWkX2fAqrJLeGJv1rlnUwuAfCDO4/TQPAuf389+WpD/Vxb1WEyxxs5IGFibbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+sFaaV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FA9C4CEF7;
	Wed,  4 Feb 2026 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770230895;
	bh=5dffcEdKgAFcYj3WU+q5x5hHwMm4789JM2jaUUQpS8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+sFaaV63yEmCbpi41BOmA+J4zmeIGFCjO051PUDmpIHgsAFE1yVGbtECB6/Fi8UU
	 xrJzZKnmSYbAblqtKlif6Pv2NylzYs2hums9P+XTZ057bGwBMV9POyA71OFUArAwMG
	 PBDthJrzcD+No7h3Qpt5vtu0uyhDZQTsQfRdEwutOqym788WzOEHsx6y4J5939ADNY
	 Z3oM6m4MbW1MpWjMoes+2PVvu72t25bkiOhMkFjoCTnNK+VC+zEtbOJyUm0IXIiiEr
	 HAYbbEQH+7+0GZwcRr3NsPFfHUpRPskXkVh6VbfxG5GbUSBboiRu0Cvtm6LnBf5Zfz
	 wbeZn6HXBjdyQ==
Date: Wed, 4 Feb 2026 11:48:10 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Pimyn Girgis <pimyn@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
	Ernesto Martnez Garca <ernesto.martinezgarcia@tugraz.at>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15 195/206] mm/kfence: randomize the freelist on
 initialization
Message-ID: <20260204184810.GA2715873@ax162>
References: <20260204143858.193781818@linuxfoundation.org>
 <20260204143905.245830999@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204143905.245830999@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214340-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: B7F60EBBEE
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 03:40:26PM +0100, Greg Kroah-Hartman wrote:
> 5.15-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Pimyn Girgis <pimyn@google.com>
> 
> commit 870ff19251bf3910dda7a7245da826924045fedd upstream.
> 
> Randomize the KFENCE freelist during pool initialization to make
> allocation patterns less predictable.  This is achieved by shuffling the
> order in which metadata objects are added to the freelist using
> get_random_u32_below().
> 
> Additionally, ensure the error path correctly calculates the address range
> to be reset if initialization fails, as the address increment logic has
> been moved to a separate loop.
> 
> Link: https://lkml.kernel.org/r/20260120161510.3289089-1-pimyn@google.com
> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> Signed-off-by: Pimyn Girgis <pimyn@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Ernesto Martnez Garca <ernesto.martinezgarcia@tugraz.at>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Pimyn Girgis <pimyn@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  mm/kfence/core.c |   24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -520,7 +520,7 @@ static bool __init kfence_init_pool(void
>  {
>  	unsigned long addr = (unsigned long)__kfence_pool;
>  	struct page *pages;
> -	int i;
> +	int i, rand;
>  	char *p;
>  
>  	if (!__kfence_pool)
> @@ -576,13 +576,28 @@ static bool __init kfence_init_pool(void
>  		INIT_LIST_HEAD(&meta->list);
>  		raw_spin_lock_init(&meta->lock);
>  		meta->state = KFENCE_OBJECT_UNUSED;
> -		meta->addr = addr; /* Initialize for validation in metadata_to_pageaddr(). */
> -		list_add_tail(&meta->list, &kfence_freelist);
> +		/* Use addr to randomize the freelist. */
> +		meta->addr = i;
>  
>  		/* Protect the right redzone. */
> -		if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
> +		if (unlikely(!kfence_protect(addr + 2 * i * PAGE_SIZE + PAGE_SIZE)))
>  			goto err;
> +	}
> +
> +	for (i = CONFIG_KFENCE_NUM_OBJECTS; i > 0; i--) {
> +		rand = get_random_u32() % i;
> +		swap(kfence_metadata[i - 1].addr, kfence_metadata[rand].addr);
> +	}
> +
> +	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
> +		struct kfence_metadata *meta_1 = &kfence_metadata[i];
> +		struct kfence_metadata *meta_2 = &kfence_metadata[meta_1->addr];
> +
> +		list_add_tail(&meta_2->list, &kfence_freelist);
> +	}
>  
> +	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
> +		kfence_metadata[i].addr = addr;
>  		addr += 2 * PAGE_SIZE;
>  	}
>  
> @@ -597,6 +612,7 @@ static bool __init kfence_init_pool(void
>  	return true;
>  
>  err:
> +	addr += 2 * i * PAGE_SIZE;
>  	/*
>  	 * Only release unprotected pages, and do not try to go back and change
>  	 * page attributes due to risk of failing to do so as well. If changing
> 
> 

This introduces a new instance of -Wsometimes-uninitialized, as pointed
out by this KernelCI report:

https://lore.kernel.org/177022794292.7001.3716577555750776270@22d5995788c3/

  mm/kfence/core.c:529:6: error: variable 'i' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
    529 |         if (!arch_kfence_init_pool())
        |             ^~~~~~~~~~~~~~~~~~~~~~~~
  mm/kfence/core.c:615:14: note: uninitialized use occurs here
    615 |         addr += 2 * i * PAGE_SIZE;
        |                     ^
  mm/kfence/core.c:529:2: note: remove the 'if' if its condition is always false
    529 |         if (!arch_kfence_init_pool())
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    530 |                 goto err;
        |                 ~~~~~~~~
  mm/kfence/core.c:523:7: note: initialize the variable 'i' to silence this warning
    523 |         int i, rand;
        |              ^
        |               = 0

Cheers,
Nathan

