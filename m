Return-Path: <stable+bounces-124784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E160EA671E2
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 11:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48DF7A441D
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1F71E5209;
	Tue, 18 Mar 2025 10:55:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C9C2080C8
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295331; cv=none; b=KRQJ4BsP3CxsZN9ttEWuSJTGrs/ag+BQgl4nj5eqM3Qkt5/wGcZgyg5C7vsIvsRnxVP9uSfra4yc5cCkvsQALHgq0o2nYdi2+aWN/UooWL6Vp1O1jTdb2CiXPWNkAgt5J+97OfxRwZ+616Ugqzd7G3DA0tIrlu1sCm01xME5ZAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295331; c=relaxed/simple;
	bh=l+XgRdRSxJr+lkKjHlzKtnFQB9gvexI+6qYvoJkS0o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yl4SB2vCPRoG3tUNtSpMw2Z6kf+JLJCV/E+xFl27pKHzhThtGK7WrrxpJzRLGd28crl7q/VYdbRFtvPZfuYNoAcnnb6jkYF5JDySQabL+3tJ2Hfwa0zj6VJYg5taq3tZwcVFqvrMxk/5L/qCYK+VW84xS8G8ZyBvqMXly6CiOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EB2513D5;
	Tue, 18 Mar 2025 03:55:38 -0700 (PDT)
Received: from [10.163.44.33] (unknown [10.163.44.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81E063F63F;
	Tue, 18 Mar 2025 03:55:27 -0700 (PDT)
Message-ID: <0bce0252-dd32-4cef-99f7-2222add43e2c@arm.com>
Date: Tue, 18 Mar 2025 16:25:23 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 2/3] mm/memblock: repeat setting reserved region nid if
 array is doubled
To: Wei Yang <richard.weiyang@gmail.com>, rppt@kernel.org,
 akpm@linux-foundation.org, yajun.deng@linux.dev
Cc: linux-mm@kvack.org, stable@vger.kernel.org
References: <20250318071948.23854-1-richard.weiyang@gmail.com>
 <20250318071948.23854-3-richard.weiyang@gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250318071948.23854-3-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 12:49, Wei Yang wrote:
> Commit 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()") introduce
> a way to set nid to all reserved region.
> 
> But there is a corner case it will leave some region with invalid nid.
> When memblock_set_node() doubles the array of memblock.reserved, it may
> lead to a new reserved region before current position. The new region
> will be left with an invalid node id.

But is it really possible for the memblock array to double during
memmap_init_reserved_pages() ? Just wondering - could you please
give some example scenarios.

> 
> Repeat the process when detecting it.
> 
> Fixes: 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Mike Rapoport <rppt@kernel.org>
> CC: Yajun Deng <yajun.deng@linux.dev>
> CC: <stable@vger.kernel.org>
> 
> ---
> v2: move check out side of the loop
> ---
>  mm/memblock.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 85442f1b7f14..0bae7547d2db 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2179,11 +2179,14 @@ static void __init memmap_init_reserved_pages(void)
>  	struct memblock_region *region;
>  	phys_addr_t start, end;
>  	int nid;
> +	unsigned long max_reserved;
>  
>  	/*
>  	 * set nid on all reserved pages and also treat struct
>  	 * pages for the NOMAP regions as PageReserved
>  	 */
> +repeat:
> +	max_reserved = memblock.reserved.max;
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
> +	if (max_reserved != memblock.reserved.max)
> +		goto repeat;
>  
>  	/*
>  	 * initialize struct pages for reserved regions that don't have

