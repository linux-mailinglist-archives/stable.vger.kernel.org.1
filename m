Return-Path: <stable+bounces-180993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC097B92684
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14C92A68A4
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EFC3128AA;
	Mon, 22 Sep 2025 17:24:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BAE1FDA82;
	Mon, 22 Sep 2025 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561883; cv=none; b=PBjhXLur3AdGWX1qJOyMqRB6MAyDVeifY69PZ5Z4LzMwZ6i8WLRcYQgP3m0czPUxTaM9AJK5L0CVw35Al7KGzGS3Jq0lbLDyInMlYpze+jVGNEslDs7ShealpVyK2oAlwqUOuu4LHNC951rw6ruHwDHPIBFjUV7nbFgINp/hWGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561883; c=relaxed/simple;
	bh=oxPhOJCQ/qZoiBIau7Zcl2ipPtFqQVDVZ14kTjBCDoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMyeCkomcsM3DT9K7GaW2exw6rzOur1wcM1YV2bv/KVgCm4k3x9F3Rzcg/ktiQng6nYB1Wsi3wZNs5PJrgehtyosbozqcM3nWuJXMAYj6Y9ysypbhdbkEKGryLa1Wdr7FshLrTrKZAExK0eGKRCKkJeWctmq/c/6QqptkpfwCOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AACC4CEF0;
	Mon, 22 Sep 2025 17:24:36 +0000 (UTC)
Date: Mon, 22 Sep 2025 18:24:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	usamaarif642@gmail.com, yuzhao@google.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, baohua@kernel.org, voidice@gmail.com,
	Liam.Howlett@oracle.com, cerasuolodomenico@gmail.com,
	hannes@cmpxchg.org, kaleshsingh@google.com, npache@redhat.com,
	riel@surriel.com, roman.gushchin@linux.dev, rppt@kernel.org,
	ryan.roberts@arm.com, dev.jain@arm.com, ryncsn@gmail.com,
	shakeel.butt@linux.dev, surenb@google.com, hughd@google.com,
	willy@infradead.org, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	qun-wei.lin@mediatek.com, Andrew.Yang@mediatek.com,
	casper.li@mediatek.com, chinwen.chang@mediatek.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-mm@kvack.org,
	ioworker0@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing
 zero-filled subpages
Message-ID: <aNGGUXLCn_bWlne5@arm.com>
References: <20250922021458.68123-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922021458.68123-1-lance.yang@linux.dev>

On Mon, Sep 22, 2025 at 10:14:58AM +0800, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> When both THP and MTE are enabled, splitting a THP and replacing its
> zero-filled subpages with the shared zeropage can cause MTE tag mismatch
> faults in userspace.
> 
> Remapping zero-filled subpages to the shared zeropage is unsafe, as the
> zeropage has a fixed tag of zero, which may not match the tag expected by
> the userspace pointer.
> 
> KSM already avoids this problem by using memcmp_pages(), which on arm64
> intentionally reports MTE-tagged pages as non-identical to prevent unsafe
> merging.
> 
> As suggested by David[1], this patch adopts the same pattern, replacing the
> memchr_inv() byte-level check with a call to pages_identical(). This
> leverages existing architecture-specific logic to determine if a page is
> truly identical to the shared zeropage.
> 
> Having both the THP shrinker and KSM rely on pages_identical() makes the
> design more future-proof, IMO. Instead of handling quirks in generic code,
> we just let the architecture decide what makes two pages identical.
> 
> [1] https://lore.kernel.org/all/ca2106a3-4bb2-4457-81af-301fd99fbef4@redhat.com
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Qun-wei Lin <Qun-wei.Lin@mediatek.com>
> Closes: https://lore.kernel.org/all/a7944523fcc3634607691c35311a5d59d1a3f8d4.camel@mediatek.com
> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

Functionally, the patch looks fine, both with and without MTE.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 32e0ec2dde36..28d4b02a1aa5 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4104,29 +4104,20 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
>  static bool thp_underused(struct folio *folio)
>  {
>  	int num_zero_pages = 0, num_filled_pages = 0;
> -	void *kaddr;
>  	int i;
>  
>  	for (i = 0; i < folio_nr_pages(folio); i++) {
> -		kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
> -		if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
> -			num_zero_pages++;
> -			if (num_zero_pages > khugepaged_max_ptes_none) {
> -				kunmap_local(kaddr);
> +		if (pages_identical(folio_page(folio, i), ZERO_PAGE(0))) {
> +			if (++num_zero_pages > khugepaged_max_ptes_none)
>  				return true;

I wonder what the overhead of doing a memcmp() vs memchr_inv() is. The
former will need to read from two places. If it's noticeable, it would
affect architectures that don't have an MTE equivalent.

Alternatively we could introduce something like folio_has_metadata()
which on arm64 simply checks PG_mte_tagged.

-- 
Catalin

