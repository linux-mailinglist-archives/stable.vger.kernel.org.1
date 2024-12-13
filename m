Return-Path: <stable+bounces-103976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E049F0645
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 09:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2435168866
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690CA1A8F7D;
	Fri, 13 Dec 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TZbJZpy8"
X-Original-To: stable@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849D51A8F76;
	Fri, 13 Dec 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734078205; cv=none; b=HzVT1wgT29zVlPBvP0ESYrG69rWi7lhyqWndfHqtJwXnJuGR0ZllU2Viq9XU7RsGeIr1VDEEIlkPLXBapsVVrTh43e8otW8ThdmPWw/WlCXRU6Ne+feV1+hxBmT43X7arly34NjPKzP+sIV5v+o2NE3/+PunpONIjIiIBzAEw04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734078205; c=relaxed/simple;
	bh=zmxxBOvI8ZMsm18pGcyI7VTpPTjwbbJOf+QSBwAu1ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJJXHs+lgElq4CviLsxbo+yvpOUFE4ed4RfszN6wtUpkgRdPMhlauUc3Jr0NhcUa1HPT+L+fzgv+9Etz+nUt+5REqxKgTI22W1V5ms8tMEYXQ/BjVRpJ343kd52WMryBBdqvRY0fd6h1VFLf4+u06/QEjOjkglX2bE+PAK3pblA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TZbJZpy8; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734078199; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XRhy5zjrYxlzCaTtoo4U77UzxfNTyWLiF59UvfYjO+I=;
	b=TZbJZpy8JuCJY8duAK19Wqqyr0LfHlwIp2y9MBZZEq0vc2648szW2pzXHH0c6E+3uYZmbrT9duPP5gDHtw77hginbYKT9WYILluoc85tEJsCH96plMWr0uZJXNEfyA1zv3AzNEFIe7F1OuMVnMJZwItP6RN5F6T00sXTroSUwGo=
Received: from 30.74.144.152(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WLOR3W7_1734078197 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Dec 2024 16:23:18 +0800
Message-ID: <df357a47-7d76-47b8-b91f-3f4bd4d2176e@linux.alibaba.com>
Date: Fri, 13 Dec 2024 16:23:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, compaction: don't use ALLOC_CMA in long term GUP flow
To: yangge1116@126.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, david@redhat.com, vbabka@suse.cz, liuzixing@hygon.cn
References: <1734075432-14131-1-git-send-email-yangge1116@126.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <1734075432-14131-1-git-send-email-yangge1116@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/12/13 15:37, yangge1116@126.com wrote:
> From: yangge <yangge1116@126.com>
> 
> Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags
> in __compaction_suitable()") allow compaction to proceed when free
> pages required for compaction reside in the CMA pageblocks, it's
> possible that __compaction_suitable() always returns true, and in
> some cases, it's not acceptable.
> 
> There are 4 NUMA nodes on my machine, and each NUMA node has 32GB
> of memory. I have configured 16GB of CMA memory on each NUMA node,
> and starting a 32GB virtual machine with device passthrough is
> extremely slow, taking almost an hour.
> 
> During the start-up of the virtual machine, it will call
> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
> Long term GUP cannot allocate memory from CMA area, so a maximum
> of 16 GB of no-CMA memory on a NUMA node can be used as virtual
> machine memory. Since there is 16G of free CMA memory on the NUMA
> node, watermark for order-0 always be met for compaction, so
> __compaction_suitable() always returns true, even if the node is
> unable to allocate non-CMA memory for the virtual machine.
> 
> For costly allocations, because __compaction_suitable() always
> returns true, __alloc_pages_slowpath() can't exit at the appropriate
> place, resulting in excessively long virtual machine startup times.
> Call trace:
> __alloc_pages_slowpath
>      if (compact_result == COMPACT_SKIPPED ||
>          compact_result == COMPACT_DEFERRED)
>          goto nopage; // should exit __alloc_pages_slowpath() from here
> 
> To sum up, during long term GUP flow, we should remove ALLOC_CMA
> both in __compaction_suitable() and __isolate_free_page().
> 
> Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in __compaction_suitable()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: yangge <yangge1116@126.com>
> ---
>   mm/compaction.c | 8 +++++---
>   mm/page_alloc.c | 4 +++-
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 07bd227..044c2247 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2384,6 +2384,7 @@ static bool __compaction_suitable(struct zone *zone, int order,
>   				  unsigned long wmark_target)
>   {
>   	unsigned long watermark;
> +	bool pin;
>   	/*
>   	 * Watermarks for order-0 must be met for compaction to be able to
>   	 * isolate free pages for migration targets. This means that the
> @@ -2395,14 +2396,15 @@ static bool __compaction_suitable(struct zone *zone, int order,
>   	 * even if compaction succeeds.
>   	 * For costly orders, we require low watermark instead of min for
>   	 * compaction to proceed to increase its chances.
> -	 * ALLOC_CMA is used, as pages in CMA pageblocks are considered
> -	 * suitable migration targets
> +	 * In addition to long term GUP flow, ALLOC_CMA is used, as pages in
> +	 * CMA pageblocks are considered suitable migration targets
>   	 */
>   	watermark = (order > PAGE_ALLOC_COSTLY_ORDER) ?
>   				low_wmark_pages(zone) : min_wmark_pages(zone);
>   	watermark += compact_gap(order);
> +	pin = !!(current->flags & PF_MEMALLOC_PIN);
>   	return __zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
> -				   ALLOC_CMA, wmark_target);
> +				   pin ? 0 : ALLOC_CMA, wmark_target);
>   }

Seems a little hack for me. Using the 'cc->alloc_flags' passed from the 
caller to determin if ‘ALLOC_CMA’ is needed looks more reasonable to me.

>   
>   /*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index dde19db..9a5dfda 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2813,6 +2813,7 @@ int __isolate_free_page(struct page *page, unsigned int order)
>   {
>   	struct zone *zone = page_zone(page);
>   	int mt = get_pageblock_migratetype(page);
> +	bool pin;
>   
>   	if (!is_migrate_isolate(mt)) {
>   		unsigned long watermark;
> @@ -2823,7 +2824,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
>   		 * exists.
>   		 */
>   		watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
> -		if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
> +		pin = !!(current->flags & PF_MEMALLOC_PIN);
> +		if (!zone_watermark_ok(zone, 0, watermark, 0, pin ? 0 : ALLOC_CMA))
>   			return 0;
>   	}
>   

