Return-Path: <stable+bounces-161541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAFEAFFBD4
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 10:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B123C3A9DD6
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 08:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4828BAB9;
	Thu, 10 Jul 2025 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HUiIfGRM"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FFE28B50E;
	Thu, 10 Jul 2025 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135078; cv=none; b=l+aijIzoWBU8WSQKjrUUMPLAHbrQTfzAmzaKDXl15ud6KvkN/f7P5oQ+N6DmG89EiQ1w8yHkUMOPZJb1fke4LZuudkcEa2RGNcQKqeF1RQUS8z8u1Wy3XMgKrIupxU9BYuCmru3b2kcW4tIP/1wuo7lTwWNHzU7wTkGGJNXKJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135078; c=relaxed/simple;
	bh=TNhDjLxLFu+8LEoskEMgvQ5azEalvEUowDOAboTqavc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrBvfwtNqS4IkKybLoTtSIT6VZuerJWJFbXO7RTZX0Ngpt4mIBZ30XpC4oSMdfNMidsiTRvojoL/gOs9cfDhA8WDxUCL5NXs5CAqKpd9i++E3A/dpKCDJUW0NfW2jYKhjUPgxzhIHBpBlk8QPHVg64BTfjuyEydgi+a5wp9CJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HUiIfGRM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.232.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id AB0082114268;
	Thu, 10 Jul 2025 01:11:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB0082114268
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752135076;
	bh=eOoVBg5tar1SHLNJ7Lvmm3yEhUrOVtzS88GwPN9nCs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUiIfGRM+dEKcEE0D7vvZ4OXeRlmO5v8jgRexaIEu1RpK5Vq34RsXE+EfNsNyBBv0
	 AgrO7wD1gwow2NK9ebnfetgf8iEYmBrfZIMXNpoxxVEY1geCIurDiFcm218cEcy2ol
	 oBZZM8UHi6uZBZVm96MgYJC4Sp7ISGYVj6qZO9g8=
Date: Thu, 10 Jul 2025 16:11:13 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jann Horn <jannh@google.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Andy Lutomirski <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "security@kernel.org" <security@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <w3xhahute7xeci2swawsaaet5frxc3cacufsawok6hzkeklzo5@jzvkcpwp46lx>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52765F651EBE0988E35E15FF8C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765F651EBE0988E35E15FF8C48A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Jul 10, 2025 at 03:02:07AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Wednesday, July 9, 2025 2:28 PM
> > 
> > The vmalloc() and vfree() functions manage virtually contiguous, but not
> > necessarily physically contiguous, kernel memory regions. When vfree()
> > unmaps such a region, it tears down the associated kernel page table
> > entries and frees the physical pages.
> > 
> > In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU
> > hardware
> > shares and walks the CPU's page tables. Architectures like x86 share
> > static kernel address mappings across all user page tables, allowing the
> 
> I'd remove 'static'
> 
> > IOMMU to access the kernel portion of these tables.
> > 
> > Modern IOMMUs often cache page table entries to optimize walk
> > performance,
> > even for intermediate page table levels. If kernel page table mappings are
> > changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
> > entries, Use-After-Free (UAF) vulnerability condition arises. If these
> > freed page table pages are reallocated for a different purpose, potentially
> > by an attacker, the IOMMU could misinterpret the new data as valid page
> > table entries. This allows the IOMMU to walk into attacker-controlled
> > memory, leading to arbitrary physical memory DMA access or privilege
> > escalation.
> 
> this lacks of a background that currently the iommu driver is notified
> only for changes of user VA mappings, so the IOMMU's internal caches
> may retain stale entries for kernel VA.
> 
> > 
> > To mitigate this, introduce a new iommu interface to flush IOMMU caches
> > and fence pending page table walks when kernel page mappings are updated.
> > This interface should be invoked from architecture-specific code that
> > manages combined user and kernel page tables.
> 
> this also needs some words about the fact that new flushes are triggered
> not just for freeing page tables.
> 
Thank you, Kevin. A question about the background of this issue: 

My understanding of the attacking scenario is, a malicious user application
could initiate DMAs to some vmalloced address, causing the paging structure
cache being loaded and then possibly being used after that paging structure
is freed(may be allocated to some other users later). 

If that is the case, only when the paging structures are freed, do we need
to do the flush. I mean, the IOTLB entries may not be loaded at all when the
permission check failes. Did I miss anything? :)


B.R.
Yu

