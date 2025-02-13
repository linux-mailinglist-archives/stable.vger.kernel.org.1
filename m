Return-Path: <stable+bounces-115134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1160A33FE3
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7F8162280
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 13:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156BC23F42A;
	Thu, 13 Feb 2025 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zTKNYYS9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B323F405
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451951; cv=none; b=jfwllFr2aA+CQ2zSMlScxB4IZ5DQIyiSGE5DnJDVOuU7OGOGfQvbF8GIRcS3gomr2lbd6XL7h2EHfdaZjyvZGH9KrtERY8cziSeWgZBdt9Cx8l4PejTgGSvlw1Ap/vt6ihQGHTcjOVmQW/z+USVsdQjwi7MWjOybYL4eDS9q1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451951; c=relaxed/simple;
	bh=fHwvAKRjZvX0SDsc66bm6lHX3nHavyzGmTs6RNqGvsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGTzDbXZtEHANQawcuGrh3W09Ffn62AvJMcOha0Eff9hP5BuwhYTVJ14SyaWw/JdWlb8Y8SPtzUKrXKWILL8Stbs9eSXaQvjQDu1YHWm2L9Ib+x4D8AI2M3qGyPFFclyw0eBJU40OUaK2VDj4BK87I7oHuh3BzlrDmP+h9LiPBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zTKNYYS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B726FC4CEE7;
	Thu, 13 Feb 2025 13:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739451951;
	bh=fHwvAKRjZvX0SDsc66bm6lHX3nHavyzGmTs6RNqGvsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zTKNYYS9XTGCt7k0DfeGqeVl/5ebJsqG4vwFvqVw8XJJP0frEvk2Qql9u+zkaKe+m
	 alljRyV1o8dAk1RvFsWrJREXaBMkI87n7/GN67HH4mxfyXv0KYMal5zW68C6im99D9
	 LUW1OyPTGkViKeGY2kKE8/mY9WZxxEhVsAvShVaE=
Date: Thu, 13 Feb 2025 14:05:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pavin Joseph <me@pavinjoseph.com>, Sarah Brofeldt <srhb@dbc.dk>,
	Eric Hagberg <ehagberg@gmail.com>,
	Bruno VERNAY <bruno.vernay@se.com>
Subject: Re: [PATCH v6.6-v6.1] x86/mm/ident_map: Use gbpages only where full
 GB page should be mapped.
Message-ID: <2025021301-division-fragment-2a3f@gregkh>
References: <20250210085609.91495-1-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210085609.91495-1-hsimeliere.opensource@witekio.com>

On Mon, Feb 10, 2025 at 09:56:09AM +0100, hsimeliere.opensource@witekio.com wrote:
> From: Steve Wahl <steve.wahl@hpe.com>
> 
> [ Upstream commit cc31744a294584a36bf764a0ffa3255a8e69f036 ]
> 
> When ident_pud_init() uses only GB pages to create identity maps, large
> ranges of addresses not actually requested can be included in the resulting
> table; a 4K request will map a full GB.  This can include a lot of extra
> address space past that requested, including areas marked reserved by the
> BIOS.  That allows processor speculation into reserved regions, that on UV
> systems can cause system halts.
> 
> Only use GB pages when map creation requests include the full GB page of
> space.  Fall back to using smaller 2M pages when only portions of a GB page
> are included in the request.
> 
> No attempt is made to coalesce mapping requests. If a request requires a
> map entry at the 2M (pmd) level, subsequent mapping requests within the
> same 1G region will also be at the pmd level, even if adjacent or
> overlapping such requests could have been combined to map a full GB page.
> Existing usage starts with larger regions and then adds smaller regions, so
> this should not have any great consequence.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Pavin Joseph <me@pavinjoseph.com>
> Tested-by: Sarah Brofeldt <srhb@dbc.dk>
> Tested-by: Eric Hagberg <ehagberg@gmail.com>
> Link: https://lore.kernel.org/all/20240717213121.3064030-3-steve.wahl@hpe.com
> Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
> Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
> ---
>  arch/x86/mm/ident_map.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
> index 968d7005f4a7..a204a332c71f 100644
> --- a/arch/x86/mm/ident_map.c
> +++ b/arch/x86/mm/ident_map.c
> @@ -26,18 +26,31 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
>  	for (; addr < end; addr = next) {
>  		pud_t *pud = pud_page + pud_index(addr);
>  		pmd_t *pmd;
> +		bool use_gbpage;
>  
>  		next = (addr & PUD_MASK) + PUD_SIZE;
>  		if (next > end)
>  			next = end;
>  
> -		if (info->direct_gbpages) {
> -			pud_t pudval;
> +		/* if this is already a gbpage, this portion is already mapped */
> +		if (pud_leaf(*pud))
> +			continue;
> +
> +		/* Is using a gbpage allowed? */
> +		use_gbpage = info->direct_gbpages;
>  
> -			if (pud_present(*pud))
> -				continue;
> +		/* Don't use gbpage if it maps more than the requested region. */
> +		/* at the begining: */
> +		use_gbpage &= ((addr & ~PUD_MASK) == 0);
> +		/* ... or at the end: */
> +		use_gbpage &= ((next & ~PUD_MASK) == 0);
> +
> +		/* Never overwrite existing mappings */
> +		use_gbpage &= !pud_present(*pud);
> +
> +		if (use_gbpage) {
> +			pud_t pudval;
>  
> -			addr &= PUD_MASK;
>  			pudval = __pud((addr - info->offset) | info->page_flag);
>  			set_pud(pud, pudval);
>  			continue;
> -- 
> 2.43.0
> 
> 

Why are you wanting this commit to be backported to these kernel
branches, when the developers explicitly asked for it to NOT be applied
there?  What problem is this fixing that you have determined that it
should be backported?

And most importantly, how did you test this?

thanks,

greg k-h

