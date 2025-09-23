Return-Path: <stable+bounces-181470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB809B95BD6
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 13:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8657F4834FC
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 11:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1254632274A;
	Tue, 23 Sep 2025 11:52:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B472E8881;
	Tue, 23 Sep 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758628335; cv=none; b=OwNWhH7jSya6i+TaXUb4uIKu9xpCdOp5+HQzP50vI8tYlBrn9dxXlKyH+qokJsT/UHvEJ6tJYTVsDchoWgcH1k4eE5LRhS/8hCjT/0ulEb11M5QC8ykrzsWzZJCGCTmUPRlCqoFkgv0jzhtR6Zp9rqIDiDtYlXiZkNkIhonqw5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758628335; c=relaxed/simple;
	bh=EsovoJk3iO97HWqD4/DkC87+I2irN6cySa4mX0rbxFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpcFeCm7rrbogPO7UYmGYi6BJZXxM+oH54F4kRZuCl0MuuFYaQXmG3UXrXNGq57NAdq8i+v4CDLFzL40OM+ZMuF1ZWzBmgxN8caqf36IM88S3FBVLJye9ZcADuj9rMAu8XCgE1YLAf0dgcbgGxXrlj6zS8mQPhEneRaoDNkyIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2910BC4CEF5;
	Tue, 23 Sep 2025 11:52:09 +0000 (UTC)
Date: Tue, 23 Sep 2025 12:52:06 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, usamaarif642@gmail.com,
	yuzhao@google.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	baohua@kernel.org, voidice@gmail.com, Liam.Howlett@oracle.com,
	cerasuolodomenico@gmail.com, hannes@cmpxchg.org,
	kaleshsingh@google.com, npache@redhat.com, riel@surriel.com,
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com,
	dev.jain@arm.com, ryncsn@gmail.com, shakeel.butt@linux.dev,
	surenb@google.com, hughd@google.com, willy@infradead.org,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, qun-wei.lin@mediatek.com,
	Andrew.Yang@mediatek.com, casper.li@mediatek.com,
	chinwen.chang@mediatek.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-mm@kvack.org, ioworker0@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing
 zero-filled subpages
Message-ID: <aNKJ5glToE4hMhWA@arm.com>
References: <20250922021458.68123-1-lance.yang@linux.dev>
 <aNGGUXLCn_bWlne5@arm.com>
 <a3412715-6d9d-4809-9588-ba08da450d16@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3412715-6d9d-4809-9588-ba08da450d16@redhat.com>

On Mon, Sep 22, 2025 at 07:59:00PM +0200, David Hildenbrand wrote:
> On 22.09.25 19:24, Catalin Marinas wrote:
> > On Mon, Sep 22, 2025 at 10:14:58AM +0800, Lance Yang wrote:
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 32e0ec2dde36..28d4b02a1aa5 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -4104,29 +4104,20 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
> > >   static bool thp_underused(struct folio *folio)
> > >   {
> > >   	int num_zero_pages = 0, num_filled_pages = 0;
> > > -	void *kaddr;
> > >   	int i;
> > >   	for (i = 0; i < folio_nr_pages(folio); i++) {
> > > -		kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
> > > -		if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
> > > -			num_zero_pages++;
> > > -			if (num_zero_pages > khugepaged_max_ptes_none) {
> > > -				kunmap_local(kaddr);
> > > +		if (pages_identical(folio_page(folio, i), ZERO_PAGE(0))) {
> > > +			if (++num_zero_pages > khugepaged_max_ptes_none)
> > >   				return true;
> > 
> > I wonder what the overhead of doing a memcmp() vs memchr_inv() is. The
> > former will need to read from two places. If it's noticeable, it would
> > affect architectures that don't have an MTE equivalent.
> > 
> > Alternatively we could introduce something like folio_has_metadata()
> > which on arm64 simply checks PG_mte_tagged.
> 
> We discussed something similar in the other thread (I suggested
> page_is_mergable()). I'd prefer to use pages_identical() for now, so we have
> the same logic here and in ksm code.
> 
> (this patch here almost looks like a cleanup :) )
> 
> If this becomes a problem, what we could do is in pages_identical() would be
> simply doing the memchr_inv() in case is_zero_pfn(). KSM might benefit from
> that as well when merging with the shared zeropage through
> try_to_merge_with_zero_page().

Yes, we can always optimise it later.

I just realised that on arm64 with MTE we won't get any merging with the
zero page even if the user page isn't mapped with PROT_MTE. In
cpu_enable_mte() we zero the tags in the zero page and set
PG_mte_tagged. The reason is that we want to use the zero page with
PROT_MTE mappings (until tag setting causes CoW). Hmm, the arm64
memcmp_pages() messed up KSM merging with the zero page even before this
patch.

The MTE tag setting evolved a bit over time with some locking using PG_*
flags to avoid a set_pte_at() race trying to initialise the tags on the
same page. We also moved the swap restoring to arch_swap_restore()
rather than the set_pte_at() path. So it is safe now to merge with the
zero page if the other page isn't tagged. A subsequent set_pte_at()
attempting to clear the tags would notice that the zero page is already
tagged.

We could go a step further and add tag comparison (I had some code
around) but I think the quick fix is to just not treat the zero page as
tagged. Not fully tested yet:

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index e5e773844889..72a1dfc54659 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -73,6 +73,8 @@ int memcmp_pages(struct page *page1, struct page *page2)
 {
 	char *addr1, *addr2;
 	int ret;
+	bool page1_tagged = page_mte_tagged(page1) && !is_zero_page(page1);
+	bool page2_tagged = page_mte_tagged(page2) && !is_zero_page(page2);
 
 	addr1 = page_address(page1);
 	addr2 = page_address(page2);
@@ -83,11 +85,10 @@ int memcmp_pages(struct page *page1, struct page *page2)
 
 	/*
 	 * If the page content is identical but at least one of the pages is
-	 * tagged, return non-zero to avoid KSM merging. If only one of the
-	 * pages is tagged, __set_ptes() may zero or change the tags of the
-	 * other page via mte_sync_tags().
+	 * tagged, return non-zero to avoid KSM merging. Ignore the zero page
+	 * since it is always tagged with the tags cleared.
 	 */
-	if (page_mte_tagged(page1) || page_mte_tagged(page2))
+	if (page1_tagged || page2_tagged)
 		return addr1 != addr2;
 
 	return ret;

-- 
Catalin

