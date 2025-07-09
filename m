Return-Path: <stable+bounces-161480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DA4AFF0AF
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 20:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AD01C41BD7
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 18:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257D12343C7;
	Wed,  9 Jul 2025 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bPaQulmV"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C1F43147;
	Wed,  9 Jul 2025 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084930; cv=none; b=ll5eT2rAk0X6vP0uEsD9PKr0Pjr2cqNaPCP+IBVeue3eiW+pyUdIxi2RFF2BlSk1GYj5o4rw3MRbcRb/dAJH/4GU3aqqkobEvmsUb9QPf0PXN7ETFEiB05aUfd3LEQDcBJjO9ywSb6nucYea26d1zBlDATaF7WhKJXMf84f/DEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084930; c=relaxed/simple;
	bh=nJ4HJll6gxxt8BDiMOiQizqRJUtnKPXV8yRR9BgUm+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3FvCO6gFdePVjOZNTMsMcPKv79cY53a3YM8TXMWGY+HRE7kRMZ9Je7JhVxjU63QFjPI1c8MxDDjP1pso2Nd+d8BDKIJw/HZr6KmzKlByB2AelksRDmQiMxf7Ojd5LT/7wRFhQuIrwz1U7zzLLrWY8FNGVI628OLr96U3mZItfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bPaQulmV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC. (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9D146201658A;
	Wed,  9 Jul 2025 11:15:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D146201658A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752084929;
	bh=pZXJDcyW08K/zBR1MRZdtfXjVD1yVkuvkO90ndnb6qc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=bPaQulmVpGg8wRcf8NtBb/CcGn4/NZ+R/nyP3tlllSZavitw9AX8y1gs567L1M7OS
	 yDC7sa7RDzx8w7lN/OMhmFXFEUM64er6910FdA8agzyKDq+CLpUHKv1rg3atsyzQxH
	 gZ3JWGxRs8czReq3dXD0C0eJPAOvpQ4lpx/m9o6g=
Date: Wed, 9 Jul 2025 11:15:27 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin
 Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>, Vasant Hegde
 <vasant.hegde@amd.com>, Dave Hansen <dave.hansen@intel.com>, Alistair
 Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Message-ID: <20250709111527.5ba9bc31@DESKTOP-0403QTC.>
In-Reply-To: <20250709162724.GE1599700@nvidia.com>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
	<20250709085158.0f050630@DESKTOP-0403QTC.>
	<20250709162724.GE1599700@nvidia.com>
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

Hi Jason,

On Wed, 9 Jul 2025 13:27:24 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jul 09, 2025 at 08:51:58AM -0700, Jacob Pan wrote:
> > > In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU
> > > hardware shares and walks the CPU's page tables. Architectures
> > > like x86 share static kernel address mappings across all user
> > > page tables, allowing the IOMMU to access the kernel portion of
> > > these tables.  
> 
> > Is there a use case where a SVA user can access kernel memory in the
> > first place?  
> 
> No. It should be fully blocked.
> 
Then I don't understand what is the "vulnerability condition" being
addressed here. We are talking about KVA range here.


