Return-Path: <stable+bounces-176113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C8DB36C62
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CBE68770A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1364935AABD;
	Tue, 26 Aug 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BVH+BD8W"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC55350D46;
	Tue, 26 Aug 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218815; cv=none; b=hbepNb3GmnAM7ERQ6ARYw+PxO+M45/ZR4093Ks3ni9gxR3/BQhEbDbNbYznxAxf4ITUCZxjdeFTpeNGPOeLJaBNKICkHSXSBDg32FOHLYJEczALv+QxkCgHTtbXO0A53asnkg5Jh22zgkyjJlB8htaVjrgtRxjwhf9uQvF5Vqrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218815; c=relaxed/simple;
	bh=kLOWvFQJVDLrusSxqECJgYVCxWX0G2z5dgAxEcCSDEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTshE4PN3dFaKpMj6Ym1JHlxRAxaOydRcBPsUTLxFwLaUvjqBbRDQ798iiOLe+T04rPYLWNucSEW+bG200FjcG5dKcpxMdLgUYeHgb9E7G+2pgQh+HuOoMbcTyYlA7eCBGVxkHIAfqHrItgEG4dnc3qBUOpg4CbPg1dthIV1pOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BVH+BD8W; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iOy5JJ5YIUrfAy9c4g7zKkZjWGr9QteMBUOe3zqNu4w=; b=BVH+BD8WO5L54Awa3ucX25EIic
	bbgBGJgwh0zCMI5CHzyxz7duE1lZ+3ZpzwT64C/Oe4WUpjWlQCG/vKVo6B1ENnN1Ramk/Wp81KT47
	YTMFp+EONRS0WfGSaT5e0ukGLarLm4mQSKpdweDe+Zz8ctsgp0+/XTBgol+hx3gaNX//FPbKBLnUQ
	XZiJ7X+qjD06/Te77ZrI23dm8Gu5Y5IcxddXjXb/SejsbvzB4rgzvxyadkivtuqVq/NR5enJEN2WQ
	nM5HOxJWFJm76kzsZ/YjV99qE/Anrw5ebfPl4N/OyHara1eDBMUUsZ7CY+iRjRhsab1ARUI3yujBt
	oUjLHPUg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uquji-00000003epU-0zWu;
	Tue, 26 Aug 2025 14:33:22 +0000
Date: Tue, 26 Aug 2025 15:33:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"security@kernel.org" <security@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	vishal.moola@gmail.com
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <aK3FsU1Dds4OG79o@casper.infradead.org>
References: <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <20250807195154.GO184255@nvidia.com>
 <BN9PR11MB52762A47B347C99F0C0E4C288C2FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87bfc80e-258e-4193-a56c-3096608aec30@linux.intel.com>
 <BN9PR11MB52766165393F7DD8209DA45A8C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e321d374-38a7-4f60-b991-58458a2761b9@linux.intel.com>
 <9a649ff4-55fe-478a-bfd7-f3287534499a@intel.com>
 <b0f613ce-7aad-4b1d-b6a1-4acc1d6c489e@linux.intel.com>
 <dde6d861-daa3-49ed-ad4f-ff9dcaf1f2b8@linux.intel.com>
 <b57d7b97-8110-47c5-9c7a-516b7b535ce9@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b57d7b97-8110-47c5-9c7a-516b7b535ce9@intel.com>

On Tue, Aug 26, 2025 at 07:22:06AM -0700, Dave Hansen wrote:
> On 8/25/25 19:49, Baolu Lu wrote:
> >> The three separate lists are needed because we're handling three
> >> distinct types of page deallocation. Grouping the pages this way allows
> >> the workqueue handler to free each type using the correct function.
> > 
> > Please allow me to add more details.
> 
> Right, I know why it got added this way: it was the quickest way to hack
> together a patch that fixes the IOMMU issue without refactoring anything.
> 
> I agree that you have three cases:
> 1. A full on 'struct ptdesc' that needs its destructor run
> 2. An order-0 'struct page'
> 3. A higher-order 'struct page'
> 
> Long-term, #2 and #3 probably need to get converted over to 'struct
> ptdesc'. They don't look _that_ hard to convert to me. Willy, Vishal,
> any other mm folks: do you agree?

Uhh.  I'm still quite ignorant about iommu page tables.  Let me make
some general observations that may be helpful.

We are attempting to shrink struct page down to 8 bytes.  That's going
to proceed in stages over the next two to three years.  Depending how
much information you need to keep around, you may be able to keep using
struct page for a while, but eventually (unless you only need a few bits
of information), you're going to need a memdesc for your allocations.

One memdesc type already assigned is for page tables.  Maybe iommu page
tables are the same / similar enough to a CPU page table that we keep
the same data structure.  Maybe they'll need their own data structure.
I lack the knowledge to make that decision.

For more on memdescs, please see here:
https://kernelnewbies.org/MatthewWilcox/Memdescs

> Short-term, I'd just consolidate your issue down to a single list.
> 
> #1: For 'struct ptdesc', modify pte_free_kernel() to pass information in
>     to pagetable_dtor_free() to tell it to use the deferred page table
>     free list. Do this with a bit in the ptdesc or a new argument to
>     pagetable_dtor_free().

We should be able to reuse one of the flags in __page_flags or there
are 24 unused bits in __page_type.

> #2. Just append these to the deferred page table free list. Easy.
> #3. The biggest hacky way to do this is to just treat the higher-order
>     non-compound page and put the pages on the deferred page table
>     free list one at a time. The other way to do it is to track down how
>     this thing got allocated in the first place and make sure it's got
>     __GFP_COMP metadata. If so, you can just use __free_pages() for
>     everything.

Non-compound allocations are bad news.  Is there a good reason these
can't be made into compound allocations?

> Yeah, it'll take a couple patches up front to refactor some things. But
> that refactoring will make things more consistent instead of adding
> adding complexity to deal with the inconsistency.

