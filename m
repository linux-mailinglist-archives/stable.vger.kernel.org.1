Return-Path: <stable+bounces-161606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB03B0069E
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 17:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4513B18854B5
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 15:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3805A27467D;
	Thu, 10 Jul 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i04o3jbP"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F90270ECF;
	Thu, 10 Jul 2025 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161298; cv=none; b=MH6e7ksFjhaHULjvCKYiLye+TcJ8lSJUtdIkIMLVF1EaMFN0V6jKnpUnyUNFTrwKwrlPA/6hgggRfuxoHXGXIGTTbUsb+V9XTt8FxPYbvexUOB/gmaiX6/O/ei2RRjLIgdyph2RPE+BAFjwbcXGp+CD3w68qYSbVG8HgBHlItIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161298; c=relaxed/simple;
	bh=dGBvMw3vKqSm7Z2a1/le01d/kxMGm6gLqmJJF9b+F30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWh3Be31AjtAem/kmvbjIOnlK1Zp3w6KmCKZf+9DJwzOSBhrNCZIdWzAlWo3J+cxx7hSe72lYym3jOF/nXmQapKXiA9PgAyHw/4LsuZiSHMYzdxquqGWc9nM3nhJ6IUSV09CDWzjVndoQjy5BJknd3mbcKUEHZykNHV9TRHyunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i04o3jbP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC. (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id AAD03201659C;
	Thu, 10 Jul 2025 08:28:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AAD03201659C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752161290;
	bh=b8OtibJpDleBLUM3qfv+/DrZpEmp0ZVWzP6n1DAx5BY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=i04o3jbPcZp8DbeuzYiFgO/zUUS78Z2hsAs4mBRQZ4h3Uwyjjvdz5fk5dNd/QblG9
	 sJr5xO5Pk2kGIR4LYMqJMtAn3LRfdPLm8A+38MjSX+9f+9PYstM9WqrE3r2LWlnn63
	 JTtlxElf6NDnFj5A748MwUNT60kFlkZORgfBoVGU=
Date: Thu, 10 Jul 2025 08:28:08 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
 <kevin.tian@intel.com>, Jann Horn <jannh@google.com>, Vasant Hegde
 <vasant.hegde@amd.com>, Dave Hansen <dave.hansen@intel.com>, Alistair
 Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Message-ID: <20250710082808.52399e31@DESKTOP-0403QTC.>
In-Reply-To: <2080aaea-0d6e-418e-8391-ddac9b39c109@linux.intel.com>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
	<20250709085158.0f050630@DESKTOP-0403QTC.>
	<20250709162724.GE1599700@nvidia.com>
	<20250709111527.5ba9bc31@DESKTOP-0403QTC.>
	<2080aaea-0d6e-418e-8391-ddac9b39c109@linux.intel.com>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Baolu,

On Thu, 10 Jul 2025 10:57:19 +0800
Baolu Lu <baolu.lu@linux.intel.com> wrote:

> Hi Jacob,
> 
> On 7/10/25 02:15, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Wed, 9 Jul 2025 13:27:24 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> >> On Wed, Jul 09, 2025 at 08:51:58AM -0700, Jacob Pan wrote:  
> >>>> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU
> >>>> hardware shares and walks the CPU's page tables. Architectures
> >>>> like x86 share static kernel address mappings across all user
> >>>> page tables, allowing the IOMMU to access the kernel portion of
> >>>> these tables.  
> >>  
> >>> Is there a use case where a SVA user can access kernel memory in
> >>> the first place?  
> >>
> >> No. It should be fully blocked.
> >>  
> > Then I don't understand what is the "vulnerability condition" being
> > addressed here. We are talking about KVA range here.  
> 
> Let me take a real example:
> 
> A device might be mistakenly configured to access memory at IOVA
> 0xffffa866001d5000 (a vmalloc'd memory region) with user-mode access
> permission. The corresponding page table entries for this IOVA
> translation, assuming a five-level page table, would appear as
> follows:
> 
> PGD: Entry present with U/S bit set (1)
> P4D: Entry present with U/S bit set (1)
> PUD: Entry present with U/S bit set (1)
> PMD: Entry present with U/S bit set (1)
> PTE: Entry present with U/S bit clear (0)
> 
> When the IOMMU walks this page table, it may potentially cache all
> present entries, regardless of the U/S bit's state. Upon reaching the
> leaf PTE, the IOMMU performs a permission check. This involves
> comparing the device's DMA access mode (in this case, user mode)
> against the cumulative U/S permission derived from an AND operation
> across all U/S bits in the traversed page table entries (which here
> results in U/S == 0).
why would IOMMU cache all the entries if the walk is not successful?

Also, per x86 vm map how could this example (UUUUS) happen to SVA? i.e.
sharing intermediate levels.

 ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ioremap
 0000000000000000 |    0       | 00007fffffffffff |  128 TB | user-space

> The IOMMU correctly blocks this DMA access because the device's
> requested access (user mode) exceeds the permissions granted by the
> page table (supervisor-only at the PTE level). However, the PGD, P4D,
> PUD, and PMD entries that were traversed might remain cached within
> the IOMMU's paging structure cache.
> 
> Now, consider a scenario where the page table leaf page is freed and
> subsequently repurposed, and the U/S bit at its previous location is
> modified to 1. From the IOMMU's perspective, the page table for the
> aforementioned IOVA would now appear as follows:
> 
> PGD: Entry present with U/S bit set (1) [retrieved from paging cache]
> P4D: Entry present with U/S bit set (1) [retrieved from paging cache]
> PUD: Entry present with U/S bit set (1) [retrieved from paging cache]
> PMD: Entry present with U/S bit set (1) [retrieved from paging cache]
> PTE: Entry present with U/S bit set (1) {read from physical memory}
> 
> As a result, the device could then potentially access the memory at
> IOVA 0xffffa866001d5000 with user-mode permission, which was
> explicitly disallowed.
> 
> Thanks,
> baolu


