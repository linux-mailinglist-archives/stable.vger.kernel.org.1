Return-Path: <stable+bounces-161635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0F0B015F1
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 10:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD7A5A0A7F
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E926323816B;
	Fri, 11 Jul 2025 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I3EbB0/B"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647E52376FD;
	Fri, 11 Jul 2025 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221830; cv=none; b=kAVQq9eNE2569DIkD/RlF43ti34N1ublqqb2GdAK9737ZIT1f8ga6m1Bb7K3nFgoV7GVtktUvvHsDGc4rPwhfcmFq/fm+U0JAE6blQ9ohbnyDwRT4SSOB+6kjsOsNzDbexSWDquhSQIf16T/TiVXQFB6hE+8QOOI4IrR30N8O1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221830; c=relaxed/simple;
	bh=Ke7L+41wFbFBzuixd1ZJ5CmdlwqS9YunWTD9zUBFclk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDMYSNs+QeLEvmJ6dEgaq1UiL4ih+2RwHcOWIiKg8m62CntLyXYIMm65uw2zLn5owlUx6oC2dX+LET4ysXKydDD/IRUV9Ih25LN4RoUAk8YxPo+lWgZt48lq1PH29UPYG3K4pKmVQ6IT19plmeiTKdH4vjeFrugMg/hZ1byr2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=I3EbB0/B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.232.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id 88AFF201A4DA;
	Fri, 11 Jul 2025 01:17:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88AFF201A4DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752221828;
	bh=pMxWlgE2n/38wP+uBzLBo9danfvbk7bMc1DZjHftJHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3EbB0/BWBsMrXvEuoXJMpspEPiy5UrZdegu7w/AdqEqtu4HlV389Gbf/Ol4GKFsh
	 nUhmvmwsdncC664oWE7OjFtSCY/0duLUIOxdjokkJKWW73SNuUgRE9yOLF0Ii1M7ZW
	 QG6M6C0jn50hZfS8+u9cRpYxqgPgGbGjvqxs4K+A=
Date: Fri, 11 Jul 2025 16:17:06 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>, 
	"Tested-by : Yi Lai" <yi1.lai@intel.com>, iommu@lists.linux.dev, security@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <6dn5n5cge7acmmfgb5zi7ctcbn5hiqyr2xhmgbdxohqydhgmtt@47nnr4tnzlnh>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <ee7585bd-d87c-4f93-9c8e-b8c1d649cdfe@intel.com>
 <228cd2c9-b781-4505-8b54-42dab03f3650@linux.intel.com>
 <326c60aa-37f3-458d-a534-6e0106cc244b@intel.com>
 <20250710132234.GL1599700@nvidia.com>
 <62580eab-3e68-4132-981a-84167d130d9f@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62580eab-3e68-4132-981a-84167d130d9f@intel.com>

On Thu, Jul 10, 2025 at 08:26:06AM -0700, Dave Hansen wrote:
> On 7/10/25 06:22, Jason Gunthorpe wrote:
> >> Why does this matter? We flush the CPU TLB in a bunch of different ways,
> >> _especially_ when it's being done for kernel mappings. For example,
> >> __flush_tlb_all() is a non-ranged kernel flush which has a completely
> >> parallel implementation with flush_tlb_kernel_range(). Call sites that
> >> use _it_ are unaffected by the patch here.
> >>
> >> Basically, if we're only worried about vmalloc/vfree freeing page
> >> tables, then this patch is OK. If the problem is bigger than that, then
> >> we need a more comprehensive patch.
> > I think we are worried about any place that frees page tables.
> 
> The two places that come to mind are the remove_memory() code and
> __change_page_attr().
> 
> The remove_memory() gunk is in arch/x86/mm/init_64.c. It has a few sites
> that do flush_tlb_all(). Now that I'm looking at it, there look to be
> some races between freeing page tables pages and flushing the TLB. But,
> basically, if you stick to the sites in there that do flush_tlb_all()
> after free_pagetable(), you should be good.
> 
> As for the __change_page_attr() code, I think the only spot you need to
> hit is cpa_collapse_large_pages() and maybe the one in
> __split_large_page() as well.
> 
> This is all disturbingly ad-hoc, though. The remove_memory() code needs
> fixing and I'll probably go try to bring some order to the chaos in the
> process of fixing it up. But that's a separate problem than this IOMMU fun.
> 

Could we consider to split the flush_tlb_kernel_range() into 2 different
versions:
- the one which only flushes the CPU TLB
- the one which flushes the CPU paging structure cache and then notifies
  IOMMU to do the same(e.g., in pud_free_pmd_page()/pmd_free_pte_page())?


B.R.
Yu

