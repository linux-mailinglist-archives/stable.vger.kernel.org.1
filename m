Return-Path: <stable+bounces-124321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FF5A5F938
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 16:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A752D19C109D
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 15:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D496267F77;
	Thu, 13 Mar 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSauxTuk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9D4267B7A
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878486; cv=none; b=ugx8lv0f3Rh+eH2UowteV6ieXhzaPgzq92EFoYyjaRLGGXl1eAr2SxXrE4SWzZ/BCSfrMdW7osNkTY1RRL1GPeYR5J4Pn+N9L0j+BqOrcbPGupZhPvXrNtLURDK+VtYdfjK/QQuuKf57Mx/ksSOJ2FNPo3fTO7JDL+6IEehdhzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878486; c=relaxed/simple;
	bh=y8q36y3Lm1c3c/d6TMfN3OT27SfYv+jqL3eKxPhx8qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6eM+9ojOND9kMkyJq6faku0PkncC8QYREcU04BVAKRuDvPD0bhadNvCTfUAdsboV1WAr19deLdSH4+XTYevX15nWbhXfRsSEqY1jFcbF8vdn2Tx4N5F+ZPOYofoh2+x20SqOyRVd0mO3P8tcFY5ysFIfL7cQty5sv7pofJnFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSauxTuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04F3C4CEDD;
	Thu, 13 Mar 2025 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741878484;
	bh=y8q36y3Lm1c3c/d6TMfN3OT27SfYv+jqL3eKxPhx8qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSauxTuk2RCTIVYhktiJE2ImioNmDhGTsMV27H3WO3L/Xn2X+m83n0yRtiF8uIBvE
	 hFALaUPQ7gcoLxvPxRcivCsdf0F/+gSfIzdF0WvZ5jV1mJgCQdDaS0bApWyP1zxXYN
	 ujr/6ZjXY0Lz80+H8Pt3jTcG+mAwjK8he5FXINUUOoR62/Upqyj2LKTQSbUvXXILm4
	 2PA12nZwTJNI6SVojnbV/EEn5DYHac3KWksSHh/DhoEnW4l/PSmGifmM576EfY3hVM
	 JvXbeORgbiGcVUmrJbwwpUzBKKh5e8mpsHZTnxbzfxGrDwMofkzcgPbzPXIPdhmFmP
	 cEb5gU0jubkmQ==
Date: Thu, 13 Mar 2025 17:07:59 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	Yajun Deng <yajun.deng@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/memblock: repeat setting reserved region nid if
 array is doubled
Message-ID: <Z9L0z6CNZjh3V8A7@kernel.org>
References: <20250312130728.1117-1-richard.weiyang@gmail.com>
 <20250312130728.1117-3-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312130728.1117-3-richard.weiyang@gmail.com>

Hi Wei,

On Wed, Mar 12, 2025 at 01:07:27PM +0000, Wei Yang wrote:
> Commit 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()") introduce
> a way to set nid to all reserved region.
> 
> But there is a corner case it will leave some region with invalid nid.
> When memblock_set_node() doubles the array of memblock.reserved, it may
> lead to a new reserved region before current position. The new region
> will be left with an invalid node id.
> 
> Repeat the process when detecting it.
> 
> Fixes: 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Mike Rapoport <rppt@kernel.org>
> CC: Yajun Deng <yajun.deng@linux.dev>
> CC: <stable@vger.kernel.org>
> ---
>  mm/memblock.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 85442f1b7f14..302dd7bc622d 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2184,7 +2184,10 @@ static void __init memmap_init_reserved_pages(void)
>  	 * set nid on all reserved pages and also treat struct
>  	 * pages for the NOMAP regions as PageReserved
>  	 */
> +repeat:
>  	for_each_mem_region(region) {
> +		unsigned long max = memblock.reserved.max;
> +
>  		nid = memblock_get_region_node(region);
>  		start = region->base;
>  		end = start + region->size;
> @@ -2193,6 +2196,15 @@ static void __init memmap_init_reserved_pages(void)
>  			reserve_bootmem_region(start, end, nid);
>  
>  		memblock_set_node(start, region->size, &memblock.reserved, nid);
> +
> +		/*
> +		 * 'max' is changed means memblock.reserved has been doubled
> +		 * its array, which may result a new reserved region before
> +		 * current 'start'. Now we should repeat the procedure to set
> +		 * its node id.
> +		 */
> +		if (max != memblock.reserved.max)
> +			goto repeat;

This check can be moved outside the loop, can't it?

>  	}
>  
>  	/*
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

