Return-Path: <stable+bounces-124544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF6DA63644
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 16:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFC416E3D0
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196AC40C03;
	Sun, 16 Mar 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fnhw7TMJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA91B808
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742139161; cv=none; b=Spse1g6RZeVZWJCJVqthTEnn5AlhKnGRCq3mYoRbZzSONGXh/yR1pFPuoIW/Gwmz5fhssfMiMbTlQutyTDyPKZPG957t/8CocGOveZa2b9tErgXSdOOBGFGdvfhhdLXYSeZ+jpElSde0/riyO0AW/S/5qoTyXvpnW7Son1Kr/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742139161; c=relaxed/simple;
	bh=YX4sDokxndnlj4S0GiQ3bcDStl7MJnFPUaDHqzdzr+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihcm/Xu8z3GIvZoVRB+jKVnkExoxvIBYCCbKbYceHw47GlJpc0Exii2uC6HEKLCfNl7QjDW791WD1OWVyoVZIOm43tQgbvWnk4R+awUHVDwaCVsTqF6d/KHRl4o4kmVn9fMaeCyZ3CZIzoR86xCOq72sY855xKYy5++M592lBL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fnhw7TMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84288C4CEDD;
	Sun, 16 Mar 2025 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742139161;
	bh=YX4sDokxndnlj4S0GiQ3bcDStl7MJnFPUaDHqzdzr+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fnhw7TMJc2nM3SiUqb0JAJsl4CzqRdnzBA3k0GX1x++N/IGdrDIrCjTdTNIToS+U8
	 BvWigxmhb8lM+0s+yc46UR178cigBrr2+BGn6cXdIYjGbyMZXdeaHvCOW7Omapdmlu
	 aKezhYyo1sOA5cqIjmRHE0GXrUo03VZffyjiBhHk+GhobU2OSiX+0y8uUwlTIzzCNC
	 A2S1sxsYJ1KbKK0y7pK1jEiJNe59zL6vsExxgyobUjY/HLzOAv6mOVNUbm/8wZICgm
	 mzsnMnfIT6iAmJ3NOsGnpDqd6togQMQieprf3zPphvhstntcq8LBgc4szBUMb0osoE
	 TWBsEvatEn4RA==
Date: Sun, 16 Mar 2025 17:32:35 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	Yajun Deng <yajun.deng@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/memblock: repeat setting reserved region nid if
 array is doubled
Message-ID: <Z9bvE-6KsbIGRcTm@kernel.org>
References: <20250312130728.1117-1-richard.weiyang@gmail.com>
 <20250312130728.1117-3-richard.weiyang@gmail.com>
 <Z9L0z6CNZjh3V8A7@kernel.org>
 <20250314020351.bgdjmdjqnobu77s7@master>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314020351.bgdjmdjqnobu77s7@master>

On Fri, Mar 14, 2025 at 02:03:51AM +0000, Wei Yang wrote:
> On Thu, Mar 13, 2025 at 05:07:59PM +0200, Mike Rapoport wrote:
> >> Commit 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()") introduce
> >> a way to set nid to all reserved region.
> >> 
> >> But there is a corner case it will leave some region with invalid nid.
> >> When memblock_set_node() doubles the array of memblock.reserved, it may
> >> lead to a new reserved region before current position. The new region
> >> will be left with an invalid node id.
> >> 
> >> Repeat the process when detecting it.
> >> 
> >> Fixes: 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >> CC: Mike Rapoport <rppt@kernel.org>
> >> CC: Yajun Deng <yajun.deng@linux.dev>
> >> CC: <stable@vger.kernel.org>
> >> ---
> >>  mm/memblock.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >> 
> >> diff --git a/mm/memblock.c b/mm/memblock.c
> >> index 85442f1b7f14..302dd7bc622d 100644
> >> --- a/mm/memblock.c
> >> +++ b/mm/memblock.c
> >> @@ -2184,7 +2184,10 @@ static void __init memmap_init_reserved_pages(void)
> >>  	 * set nid on all reserved pages and also treat struct
> >>  	 * pages for the NOMAP regions as PageReserved
> >>  	 */
> >> +repeat:
> >>  	for_each_mem_region(region) {
> >> +		unsigned long max = memblock.reserved.max;
> >> +
> >>  		nid = memblock_get_region_node(region);
> >>  		start = region->base;
> >>  		end = start + region->size;
> >> @@ -2193,6 +2196,15 @@ static void __init memmap_init_reserved_pages(void)
> >>  			reserve_bootmem_region(start, end, nid);
> >>  
> >>  		memblock_set_node(start, region->size, &memblock.reserved, nid);
> >> +
> >> +		/*
> >> +		 * 'max' is changed means memblock.reserved has been doubled
> >> +		 * its array, which may result a new reserved region before
> >> +		 * current 'start'. Now we should repeat the procedure to set
> >> +		 * its node id.
> >> +		 */
> >> +		if (max != memblock.reserved.max)
> >> +			goto repeat;
> >
> >This check can be moved outside the loop, can't it?
> >
> 
> We can. You mean something like this?

Yes, something like this.
 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 85442f1b7f14..67fd1695cce4 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2179,11 +2179,14 @@ static void __init memmap_init_reserved_pages(void)
>  	struct memblock_region *region;
>  	phys_addr_t start, end;
>  	int nid;
> +	unsigned long max;

maybe max_reserved?
>  
>  	/*
>  	 * set nid on all reserved pages and also treat struct
>  	 * pages for the NOMAP regions as PageReserved
>  	 */
> +repeat:
> +	max = memblock.reserved.max;
>  	for_each_mem_region(region) {
>  		nid = memblock_get_region_node(region);
>  		start = region->base;
> @@ -2194,6 +2197,13 @@ static void __init memmap_init_reserved_pages(void)
>  
>  		memblock_set_node(start, region->size, &memblock.reserved, nid);
>  	}
> +	/*
> +	 * 'max' is changed means memblock.reserved has been doubled its
> +	 * array, which may result a new reserved region before current
> +	 * 'start'. Now we should repeat the procedure to set its node id.
> +	 */
> +	if (max != memblock.reserved.max)
> +		goto repeat;
>  
>  	/*
>  	 * initialize struct pages for reserved regions that don't have
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

