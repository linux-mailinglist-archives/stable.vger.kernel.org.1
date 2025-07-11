Return-Path: <stable+bounces-161637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4010BB0165D
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 10:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8FA1894784
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 08:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA5A2236FD;
	Fri, 11 Jul 2025 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s6dRZeGx"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA8D20D4FC;
	Fri, 11 Jul 2025 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222784; cv=none; b=A3FmNuUWsfPhdAdEBtw4+K3dAFiL6A0AcJRa8ll2MZ8wLoQ7JxFkQXi4Lnk+V9qJ4GbOSV5+Rnuksk1F5Ei+dD2f8RjxcSuE2yIlcvLG6UDoNOUmPBKO86Js1U/U39QHtPTmGx+Nagxo+ZG4qPAwN7l1U9jS5WDIic7497OQ3IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222784; c=relaxed/simple;
	bh=mj2leEJsdnBov27pu1W5NvFREYzhMUPQFy8+KOSCW5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNNqD3OzG5uzJA/lbDgjK/QOFs6v3xGYxbrd3sG1b02rVqtTaTVnml1MTkGFa6YObgZj/WsRK/0zm16jS0NmjqGa7H5GwLYbKiWVeQeQ56g+0czaQnyq4ktSpciYOxV5jX4NyomyUvfYB/Opgf3xlQhXS8Y4G1MYhRFdZO2UlCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s6dRZeGx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4/Bq2Rllu0khw/SdqVkhcg5i0SEM7P5c0IGwdRs7+Kc=; b=s6dRZeGxvc03/giN5YcBv+j0fL
	5EitGZ73E9qXlMoE1HZPsMWYAHa9qlWehM3EALzZZHDUmIENbE4Wxz19b0113z2k3R4Ra7re5LXEh
	1VmOMrfKoQkp25HuUDqKUCKmewqsRMgCl04dIL4uPuwDlYVcQxC9bjdEjVLU6wNB/pIBMqSiW/Dbv
	2l1SSlNHZOfPtt7H9pg/8Objsb9eG2xcO7ZmDuX2yLEfcjcT2ewvFntpUKDynf7WSyNy1t13C0yrc
	EEhlPbNEWhd1yQQOXMkI5f1R67r/kRdQjhG/2xdQzkRTVtI9/9FMHmIMR2hQxhpTE6aRGla9UvYxc
	fJag+bcQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua9Be-0000000CExt-3Wwv;
	Fri, 11 Jul 2025 08:32:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1C443005E5; Fri, 11 Jul 2025 10:32:52 +0200 (CEST)
Date: Fri, 11 Jul 2025 10:32:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Tested-by : Yi Lai" <yi1.lai@intel.com>, iommu@lists.linux.dev,
	security@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <20250711083252.GE1099709@noisy.programming.kicks-ass.net>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <20250710135432.GO1613376@noisy.programming.kicks-ass.net>
 <094fdad4-297b-44e9-a81c-0fe4da07e63f@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <094fdad4-297b-44e9-a81c-0fe4da07e63f@linux.intel.com>

On Fri, Jul 11, 2025 at 11:00:06AM +0800, Baolu Lu wrote:
> Hi Peter Z,
> 
> On 7/10/25 21:54, Peter Zijlstra wrote:
> > On Wed, Jul 09, 2025 at 02:28:00PM +0800, Lu Baolu wrote:
> > > The vmalloc() and vfree() functions manage virtually contiguous, but not
> > > necessarily physically contiguous, kernel memory regions. When vfree()
> > > unmaps such a region, it tears down the associated kernel page table
> > > entries and frees the physical pages.
> > > 
> > > In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
> > > shares and walks the CPU's page tables. Architectures like x86 share
> > > static kernel address mappings across all user page tables, allowing the
> > > IOMMU to access the kernel portion of these tables.
> > > 
> > > Modern IOMMUs often cache page table entries to optimize walk performance,
> > > even for intermediate page table levels. If kernel page table mappings are
> > > changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
> > > entries, Use-After-Free (UAF) vulnerability condition arises. If these
> > > freed page table pages are reallocated for a different purpose, potentially
> > > by an attacker, the IOMMU could misinterpret the new data as valid page
> > > table entries. This allows the IOMMU to walk into attacker-controlled
> > > memory, leading to arbitrary physical memory DMA access or privilege
> > > escalation.
> > > 
> > > To mitigate this, introduce a new iommu interface to flush IOMMU caches
> > > and fence pending page table walks when kernel page mappings are updated.
> > > This interface should be invoked from architecture-specific code that
> > > manages combined user and kernel page tables.
> > 
> > I must say I liked the kPTI based idea better. Having to iterate and
> > invalidate an unspecified number of IOMMUs from non-preemptible context
> > seems 'unfortunate'.
> 
> The cache invalidation path in IOMMU drivers is already critical and
> operates within a non-preemptible context. This approach is, in fact,
> already utilized for user-space page table updates since the beginning
> of SVA support.

OK, fair enough I suppose. What kind of delays are we talking about
here? The fact that you basically have a unbounded list of IOMMUs
(although in practise I suppose it is limited by the amount of GPUs and
other fancy stuff you can stick in your machine) does slightly worry me.

At some point the low latency folks are going to come hunting you down.
Do you have a plan on how to deal with this; or are we throwing up our
hands an say, the hardware sucks, deal with it?

