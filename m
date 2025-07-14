Return-Path: <stable+bounces-161852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C15EB04226
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 16:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950744A15FC
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CB8258CED;
	Mon, 14 Jul 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KW4HSDXH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853572580CA;
	Mon, 14 Jul 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504618; cv=none; b=LAIn6bqdI2YeUzfqHuk25jF+z3EUP8FU2dj+5/Dcvz1YWiRLqczJSpgoqQVWhKM75wGcj9y/ar6mv+U9NdQYagJXuNgBU+Fir/ZoJeDoMpXPWCeG7ybmkyug707wxrPJt/NK3Ys2QRWmNW7qdBe4lciApBFY38c10qAZ5n8fq2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504618; c=relaxed/simple;
	bh=hXzOR+olA7S2G5J00jXZPUDprAPkJ5ZTCiCyKy0y35c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0vqWUXHJfDlPNeW9/jwO8+ZjXWukFOzVxsl2m7u/hrnpYut0ybVzJiJZ6Is0EAToswr0LzBMrxKm6XQXvn789tWYd9222Yn5jbL0INWEK1K283C+AzBrPRMy67ze47mKb1WazOcdvMKp5gAnVSEpsBT9VBFMG2oMHYHPRVlYXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW4HSDXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BDEC4CEED;
	Mon, 14 Jul 2025 14:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752504618;
	bh=hXzOR+olA7S2G5J00jXZPUDprAPkJ5ZTCiCyKy0y35c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KW4HSDXHZxiSFI2dHqjBhYv6RY2g0qN2s0+i+buCp2fRFKF5jb87i/PkMBNKtqmvY
	 h+WBo176r5npnFDpjTt7kwI1UKTUwCxkv5nZT8QRSdh4GnRSfap7TbYAXb7HghImxQ
	 X6z4zXQ4px+Deo0BhYPUrLCxAEFCH95ymy8/tGekYDZRDwIKgWPzlYRv30JdC30pR3
	 N9JdOf1J43u4n6BJwVQjUXQz+g6pZ1DMa1WzCGKzj753GbP21EJTGI7zmb6HqAnG2H
	 DVXartEo4EjFuyc9nNE/L9uoZTnRThzcHy6R0FrTSaReUcwFFgfFaER3D5/IXJMLZp
	 6wC7Dlo3CxsCw==
Date: Mon, 14 Jul 2025 17:50:09 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Dave Hansen <dave.hansen@intel.com>, jacob.pan@linux.microsoft.com,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, iommu@lists.linux.dev,
	security@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Message-ID: <aHUZIVbLV9KAoZ3H@kernel.org>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
 <20250709085158.0f050630@DESKTOP-0403QTC.>
 <20250709162724.GE1599700@nvidia.com>
 <20250709111527.5ba9bc31@DESKTOP-0403QTC.>
 <42c500b8-6ffb-4793-85c0-d3fbae0116f1@intel.com>
 <20250714133920.55fde0f5@pumpkin>
 <aHUD1cklhydR-gE5@pc636>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHUD1cklhydR-gE5@pc636>

On Mon, Jul 14, 2025 at 03:19:17PM +0200, Uladzislau Rezki wrote:
> On Mon, Jul 14, 2025 at 01:39:20PM +0100, David Laight wrote:
> > On Wed, 9 Jul 2025 11:22:34 -0700
> > Dave Hansen <dave.hansen@intel.com> wrote:
> > 
> > > On 7/9/25 11:15, Jacob Pan wrote:
> > > >>> Is there a use case where a SVA user can access kernel memory in the
> > > >>> first place?    
> > > >> No. It should be fully blocked.
> > > >>  
> > > > Then I don't understand what is the "vulnerability condition" being
> > > > addressed here. We are talking about KVA range here.  
> > > 
> > > SVA users can't access kernel memory, but they can compel walks of
> > > kernel page tables, which the IOMMU caches. The trouble starts if the
> > > kernel happens to free that page table page and the IOMMU is using the
> > > cache after the page is freed.
> > > 
> > > That was covered in the changelog, but I guess it could be made a bit
> > > more succinct.

But does this really mean that every flush_tlb_kernel_range() should flush
the IOMMU page tables as well? AFAIU, set_memory flushes TLB even when bits
in pte change and it seems like an overkill...

> > Is it worth just never freeing the page tables used for vmalloc() memory?
> > After all they are likely to be reallocated again.
> > 
> >
> Do we free? Maybe on some arches? According to my tests(AMD x86-64) i did
> once upon a time, the PTE entries were not freed after vfree(). It could be
> expensive if we did it, due to a global "page_table_lock" lock.
> 
> I see one place though, it is in the vmap_try_huge_pud()
> 
> 	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
> 		return 0;
> 
> it is when replace a pud by a huge-page.

There's also a place that replaces a pmd by a smaller huge page, but other
than that vmalloc does not free page tables.

> --
> Uladzislau Rezki

-- 
Sincerely yours,
Mike.

