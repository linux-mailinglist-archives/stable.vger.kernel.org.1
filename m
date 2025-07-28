Return-Path: <stable+bounces-164993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C36B14143
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 19:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892C15415FA
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 17:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445B827511B;
	Mon, 28 Jul 2025 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sdQRNthE"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B361E8328;
	Mon, 28 Jul 2025 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753724208; cv=none; b=KEXWU4AOwDPbrssz/3Qs6bx3WUFnlw/Hso1fCMLci4COEwr5FRzCqSKaBXar2UyzulxQthYRUpvUt6AiQxjN5aNSNmkKiGmdOVHrmlEPEeJ60ApnJyzntMekJQfeuwslxBSNHZ/QrzYueiTuYH+8xOg1Kg7BM/D71mwn4k9nL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753724208; c=relaxed/simple;
	bh=g/74FjEy7Z1URYnCTf9RzatsO+c6JxJlD6Dl9sI4e30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Le3rER/IVeRHeqZJUAotLPP4hf0rA73jg2mUs39pZPWFhYogy9IOGhWO6/RKBSawsyk8sBEkKjnlSfRaDGG8JT36LPG1FZgPdh1d08ts3u16Fx7UOgq6bIbGqhgmEq5ikWYXQOfDXGq7e1hXhjxtfoORiRa2byDmgK+F4LTnpKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sdQRNthE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.232.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id D44E52021886;
	Mon, 28 Jul 2025 10:36:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D44E52021886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753724206;
	bh=Zh2dRtCWmnZ+nzoDXlzTor6vpxq88+KGK9inssfNS2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdQRNthEWAVk3bi7v2e0exHSqNSJS9oBwon+lQkG1RP8mXLo0ncyJxSHH0qsRvPS2
	 I9s/id3SSGwMTq5nzLSBmYucep4kEnaSWuwpCQsPcSrQlTSUYM8klj8L+mTitRrzKY
	 bPmLPlYnX7CmjvVEERh9taQkLBGRCiewW92BxHeM=
Date: Tue, 29 Jul 2025 01:36:44 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>, 
	"Tested-by : Yi Lai" <yi1.lai@intel.com>, iommu@lists.linux.dev, security@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <pk2b4xgxewxotp557osucliagmziv3erepsret4hbnxnvhff2n@p2gark4kdiqw>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <ee7585bd-d87c-4f93-9c8e-b8c1d649cdfe@intel.com>
 <228cd2c9-b781-4505-8b54-42dab03f3650@linux.intel.com>
 <326c60aa-37f3-458d-a534-6e0106cc244b@intel.com>
 <20250710132234.GL1599700@nvidia.com>
 <62580eab-3e68-4132-981a-84167d130d9f@intel.com>
 <6dn5n5cge7acmmfgb5zi7ctcbn5hiqyr2xhmgbdxohqydhgmtt@47nnr4tnzlnh>
 <2a1ffe30-b0a6-45b3-8dcb-feaa285e1e5b@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a1ffe30-b0a6-45b3-8dcb-feaa285e1e5b@linux.intel.com>

On Thu, Jul 24, 2025 at 11:01:12AM +0800, Baolu Lu wrote:
> On 7/11/25 16:17, Yu Zhang wrote:
> > On Thu, Jul 10, 2025 at 08:26:06AM -0700, Dave Hansen wrote:
> > > On 7/10/25 06:22, Jason Gunthorpe wrote:
> > > > > Why does this matter? We flush the CPU TLB in a bunch of different ways,
> > > > > _especially_ when it's being done for kernel mappings. For example,
> > > > > __flush_tlb_all() is a non-ranged kernel flush which has a completely
> > > > > parallel implementation with flush_tlb_kernel_range(). Call sites that
> > > > > use_it_ are unaffected by the patch here.
> > > > > 
> > > > > Basically, if we're only worried about vmalloc/vfree freeing page
> > > > > tables, then this patch is OK. If the problem is bigger than that, then
> > > > > we need a more comprehensive patch.
> > > > I think we are worried about any place that frees page tables.
> > > The two places that come to mind are the remove_memory() code and
> > > __change_page_attr().
> > > 
> > > The remove_memory() gunk is in arch/x86/mm/init_64.c. It has a few sites
> > > that do flush_tlb_all(). Now that I'm looking at it, there look to be
> > > some races between freeing page tables pages and flushing the TLB. But,
> > > basically, if you stick to the sites in there that do flush_tlb_all()
> > > after free_pagetable(), you should be good.
> > > 
> > > As for the __change_page_attr() code, I think the only spot you need to
> > > hit is cpa_collapse_large_pages() and maybe the one in
> > > __split_large_page() as well.
> > > 
> > > This is all disturbingly ad-hoc, though. The remove_memory() code needs
> > > fixing and I'll probably go try to bring some order to the chaos in the
> > > process of fixing it up. But that's a separate problem than this IOMMU fun.
> > > 
> > Could we consider to split the flush_tlb_kernel_range() into 2 different
> > versions:
> > - the one which only flushes the CPU TLB
> > - the one which flushes the CPU paging structure cache and then notifies
> >    IOMMU to do the same(e.g., in pud_free_pmd_page()/pmd_free_pte_page())?
> 
> From the perspective of an IOMMU, there is no need to split. IOMMU SVA
> only allows the device to access user-space memory with user
> permission. Access to kernel address space with privileged permission
> is not allowed. Therefore, the IOMMU subsystem only needs a callback to
> invalidate the paging structure cache.

Thanks Baolu. 

Indeed. That's why I was wondering if we could split flush_tlb_kernel_range()
into 2 versions - one used only after a kernal virtual address range is
unmapped, and another one used after a kernel paging structure is freed.
Only the 2nd one needs to notify the IOMMU subsystem.

B.R.
Yu

