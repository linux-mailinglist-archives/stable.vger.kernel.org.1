Return-Path: <stable+bounces-181483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74171B95E0E
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 14:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6F416B5FA
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 12:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80643322744;
	Tue, 23 Sep 2025 12:51:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5298E2EE5FC;
	Tue, 23 Sep 2025 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758631898; cv=none; b=MJ6ABHzySBLTvG9BFI7HV9If2vx91KuAinW3/So179uO/4PJrUo1cotfLX/QFQ7cTpWxQSDRBQ+QBAoLO1thjAUaJkKZuYwQ62HJ8uhT3pqzTF+LfgZPoxPDq7Yt/FHn6ebVjM3I+KSHmd6yl2oorOwvAejbvNWdmxvlWTlWLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758631898; c=relaxed/simple;
	bh=u5l+plMW55Dj7R8Fa7d/lY4KC8chvKCC1EMxWCDzhCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4DUQYA58m/tCLMXKYbhVXeZVh5DOzWjm8XFeKAvDi9EecjiH5zsEzJuggc/2r+fR7N5Fz2eNbdpTh/+ISe1YupElpE7xcBfLNlvJMs0vfpbmAXQBb3jcmaJpjea8PojtUS9b97tokZoYQk3D1eDd44uRWqEKLX5ZiRe30r5YhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A7AC4CEF5;
	Tue, 23 Sep 2025 12:51:30 +0000 (UTC)
Date: Tue, 23 Sep 2025 13:51:27 +0100
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
Message-ID: <aNKXz3B7iIIv7LxK@arm.com>
References: <20250922021458.68123-1-lance.yang@linux.dev>
 <aNGGUXLCn_bWlne5@arm.com>
 <a3412715-6d9d-4809-9588-ba08da450d16@redhat.com>
 <aNKJ5glToE4hMhWA@arm.com>
 <8bf8302a-6aba-4f7e-8356-a933bcf9e4a1@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bf8302a-6aba-4f7e-8356-a933bcf9e4a1@redhat.com>

On Tue, Sep 23, 2025 at 02:00:01PM +0200, David Hildenbrand wrote:
> On 23.09.25 13:52, Catalin Marinas wrote:
> > I just realised that on arm64 with MTE we won't get any merging with the
> > zero page even if the user page isn't mapped with PROT_MTE. In
> > cpu_enable_mte() we zero the tags in the zero page and set
> > PG_mte_tagged. The reason is that we want to use the zero page with
> > PROT_MTE mappings (until tag setting causes CoW). Hmm, the arm64
> > memcmp_pages() messed up KSM merging with the zero page even before this
> > patch.
> > 
> > The MTE tag setting evolved a bit over time with some locking using PG_*
> > flags to avoid a set_pte_at() race trying to initialise the tags on the
> > same page. We also moved the swap restoring to arch_swap_restore()
> > rather than the set_pte_at() path. So it is safe now to merge with the
> > zero page if the other page isn't tagged. A subsequent set_pte_at()
> > attempting to clear the tags would notice that the zero page is already
> > tagged.
> > 
> > We could go a step further and add tag comparison (I had some code
> > around) but I think the quick fix is to just not treat the zero page as
> > tagged.
> 
> I assume any tag changes would result in CoW.

Yes.

> It would be interesting to know if there are use cases with VMs or other
> workloads where that could be beneficial with KSM.

With VMs, if MTE is allowed in the guest, we currently treat any VM page
as tagged. In the initial version of the MTE spec, we did not have any
fine-rained control at the stage 2 page table over whether MTE is in use
by the guest (just a big knob in a control register). We later got
FEAT_MTE_PERM which allows stage 2 to trap tag accesses in a VM on a
page by page basis, though we haven't added KVM support for it yet.

If we add full tag comparison, VMs may be able to share more pages. For
example, code pages are never tagged in a VM but the hypervisor doesn't
know this, so it just avoids sharing. I posted tag comparison some years
ago but dropped it eventually to keep things simple:

https://lore.kernel.org/all/20200421142603.3894-9-catalin.marinas@arm.com/

However, it needs a bit of tidying up since at the time we assumed
everything was tagged. I can respin the above (on top of the fix below),
though I don't see many vendors rushing to deploy MTE in a multi-VM
scenario (Android + pKVM maybe but not sure they enable KSM due to power
constraints).

> > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > index e5e773844889..72a1dfc54659 100644
> > --- a/arch/arm64/kernel/mte.c
> > +++ b/arch/arm64/kernel/mte.c
> > @@ -73,6 +73,8 @@ int memcmp_pages(struct page *page1, struct page *page2)
> >   {
> >   	char *addr1, *addr2;
> >   	int ret;
> > +	bool page1_tagged = page_mte_tagged(page1) && !is_zero_page(page1);
> > +	bool page2_tagged = page_mte_tagged(page2) && !is_zero_page(page2);
> >   	addr1 = page_address(page1);
> >   	addr2 = page_address(page2);
> > @@ -83,11 +85,10 @@ int memcmp_pages(struct page *page1, struct page *page2)
> >   	/*
> >   	 * If the page content is identical but at least one of the pages is
> > -	 * tagged, return non-zero to avoid KSM merging. If only one of the
> > -	 * pages is tagged, __set_ptes() may zero or change the tags of the
> > -	 * other page via mte_sync_tags().
> > +	 * tagged, return non-zero to avoid KSM merging. Ignore the zero page
> > +	 * since it is always tagged with the tags cleared.
> >   	 */
> > -	if (page_mte_tagged(page1) || page_mte_tagged(page2))
> > +	if (page1_tagged || page2_tagged)
> >   		return addr1 != addr2;
> 
> That looks reasonable to me.
> 
> @Lance as you had a test setup, could you give this a try as well with KSM
> shared zeropage deduplication enabled whether it now works as expected as
> well?

Thanks!

> Then, this should likely be an independent fix.

Yes, I'll add a proper commit message. We could do a cc stable, though
it's more of an optimisation.

-- 
Catalin

