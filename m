Return-Path: <stable+bounces-55921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3961F91A030
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 09:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCB31C20EF9
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 07:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364E648CDD;
	Thu, 27 Jun 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+EBZ6Wp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA5482D3;
	Thu, 27 Jun 2024 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472531; cv=none; b=SsoHlqLqkXP155/7rt9eEBPEaFJ0HC5kY07J0D0Z/jDc7NMpEOawYNTXdPz5KrK3USLIiC36SAZG6s+a0Kv7dnGwfZ1j4QYOYu7maBE47McAc5Is81ve7V6WTvbYzrGiDwyNDnZoLt5f2e/BO3XGJGxyFT67MSQbQUaFJaIzg44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472531; c=relaxed/simple;
	bh=XwbJSYUkScewFom8KPyfpdyPLqr69H4fdItz//XBLlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZwj99JsXek10aR04+uG3T+vae8r+zLN8Y1UduZvSHLOlRrqyLwJIE12eb4yDi7ZEBn/Vty4kGscB5Bjt6Gfhmcgf7TEozqS3GwV4H0hx+O7RktS+6CeQ1tJ7+tyBxK3LUJQNHCg6CTSf5kvTA6NZSuoXiZc8ehHjPdsRGCFu84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+EBZ6Wp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8D8C2BBFC;
	Thu, 27 Jun 2024 07:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719472530;
	bh=XwbJSYUkScewFom8KPyfpdyPLqr69H4fdItz//XBLlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+EBZ6WpJtlliiUw6N1d1pSEJUX/I/jOSxM9i5pnaeUeyQLzXrtDcFtNIxqB+lBoD
	 XZ7JJROf3c+nsRa0VfC7DEsH9DPwVPTAKvbn0BIuup7eyKECJklAlhai6l64iiH3/1
	 qbd4czshDH8OHpaZC6WwjHeR6ulND+w1D6xkJKKw2N8ts0UTa9bHj/gUykJnSAl4cq
	 w27o+fs8Cvzzb2i1/ICw8o+znF3OxQIxGWrTXI4bg2Y4r358qdjLrTyl+3xinyfvuU
	 KV3DWo7GZBXG94FXaHr6XGELyo4m8uq+KoqvnyGX8a1Kp7/IYilMXLJq29VlS1p5qv
	 kgy1uGyIO5gOQ==
Date: Thu, 27 Jun 2024 10:13:00 +0300
From: Mike Rapoport <rppt@kernel.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Patch "mm: memblock: replace dereferences of memblock_region.nid
 with API calls" has been added to the 5.4-stable tree
Message-ID: <Zn0Q_DKvcVF8P5f-@kernel.org>
References: <20240626190708.2059584-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626190708.2059584-1-sashal@kernel.org>

Hi Sasha,

On Wed, Jun 26, 2024 at 03:07:08PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     mm: memblock: replace dereferences of memblock_region.nid with API calls
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mm-memblock-replace-dereferences-of-memblock_region..patch
> and it can be found in the queue-5.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit dd8d9169375a725cadd5e3635342a6e2d483cf4c
> Author: Mike Rapoport <rppt@kernel.org>
> Date:   Wed Jun 3 15:56:53 2020 -0700
> 
>     mm: memblock: replace dereferences of memblock_region.nid with API calls
>     
>     Stable-dep-of: 3ac36aa73073 ("x86/mm/numa: Use NUMA_NO_NODE when calling memblock_set_node()")

The commit 3ac36aa73073 shouldn't be backported to 5.4 or anything before
6.8 for that matter, I don't see a need to bring this in as well.

>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index 53ebb4babf3a7..58c83c2b8748f 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -354,13 +354,16 @@ static int __init numa_register_nodes(void)
>  	struct memblock_region *mblk;
>  
>  	/* Check that valid nid is set to memblks */
> -	for_each_memblock(memory, mblk)
> -		if (mblk->nid == NUMA_NO_NODE || mblk->nid >= MAX_NUMNODES) {
> +	for_each_memblock(memory, mblk) {
> +		int mblk_nid = memblock_get_region_node(mblk);
> +
> +		if (mblk_nid == NUMA_NO_NODE || mblk_nid >= MAX_NUMNODES) {
>  			pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
> -				mblk->nid, mblk->base,
> +				mblk_nid, mblk->base,
>  				mblk->base + mblk->size - 1);
>  			return -EINVAL;
>  		}
> +	}
>  
>  	/* Finally register nodes. */
>  	for_each_node_mask(nid, numa_nodes_parsed) {
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 7316dca7e846a..bd52ce954d59a 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -502,8 +502,10 @@ static void __init numa_clear_kernel_node_hotplug(void)
>  	 *   reserve specific pages for Sandy Bridge graphics. ]
>  	 */
>  	for_each_memblock(reserved, mb_region) {
> -		if (mb_region->nid != MAX_NUMNODES)
> -			node_set(mb_region->nid, reserved_nodemask);
> +		int nid = memblock_get_region_node(mb_region);
> +
> +		if (nid != MAX_NUMNODES)
> +			node_set(nid, reserved_nodemask);
>  	}
>  
>  	/*
> diff --git a/mm/memblock.c b/mm/memblock.c
> index a75cc65f03307..d2d85d4d16b74 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1170,13 +1170,15 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
>  {
>  	struct memblock_type *type = &memblock.memory;
>  	struct memblock_region *r;
> +	int r_nid;
>  
>  	while (++*idx < type->cnt) {
>  		r = &type->regions[*idx];
> +		r_nid = memblock_get_region_node(r);
>  
>  		if (PFN_UP(r->base) >= PFN_DOWN(r->base + r->size))
>  			continue;
> -		if (nid == MAX_NUMNODES || nid == r->nid)
> +		if (nid == MAX_NUMNODES || nid == r_nid)
>  			break;
>  	}
>  	if (*idx >= type->cnt) {
> @@ -1189,7 +1191,7 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
>  	if (out_end_pfn)
>  		*out_end_pfn = PFN_DOWN(r->base + r->size);
>  	if (out_nid)
> -		*out_nid = r->nid;
> +		*out_nid = r_nid;
>  }
>  
>  /**
> @@ -1730,7 +1732,7 @@ int __init_memblock memblock_search_pfn_nid(unsigned long pfn,
>  	*start_pfn = PFN_DOWN(type->regions[mid].base);
>  	*end_pfn = PFN_DOWN(type->regions[mid].base + type->regions[mid].size);
>  
> -	return type->regions[mid].nid;
> +	return memblock_get_region_node(&type->regions[mid]);
>  }
>  #endif
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0ad582945f54d..4a649111178cc 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7214,7 +7214,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>  			if (!memblock_is_hotpluggable(r))
>  				continue;
>  
> -			nid = r->nid;
> +			nid = memblock_get_region_node(r);
>  
>  			usable_startpfn = PFN_DOWN(r->base);
>  			zone_movable_pfn[nid] = zone_movable_pfn[nid] ?
> @@ -7235,7 +7235,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>  			if (memblock_is_mirror(r))
>  				continue;
>  
> -			nid = r->nid;
> +			nid = memblock_get_region_node(r);
>  
>  			usable_startpfn = memblock_region_memory_base_pfn(r);
>  

-- 
Sincerely yours,
Mike.

