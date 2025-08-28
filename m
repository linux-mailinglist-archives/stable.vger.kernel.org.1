Return-Path: <stable+bounces-176666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612A1B3AB06
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 21:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAFC3BC013
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C622765DD;
	Thu, 28 Aug 2025 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DHOiU0Rf"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD64BA4A;
	Thu, 28 Aug 2025 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756409958; cv=none; b=m1yivnbokhJi21fz7uLoZswxj3TzNQlLoKeZ1fZO1JSZkEjqwk8iqXspOUzv4uONedmDYbK4X8MGuQKGWhmm4rU0X9tP1W7raUSVRACjTOFu0auR1Gn64ytPd4mzJ5lnj8xvwfNbjdPHVlbPHJR6rMFehdk5aan34jhwSmNCtQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756409958; c=relaxed/simple;
	bh=n9smJLaGwjwyLu9jP8h0rg16ZUeLHxL4JmcMy5/9VhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8gR+wQsR6HjjWTG5LbjuiBh014AGG1q/Taek0pv7yzN6oXaLhm90AVElBpm1EtAbN2Y7HdUGvuUhq0H9Dw+yo2GkebEvqm9IvZ/Zfp9KrBYSgC4ZkA0DxeDuADJygBvE+7n04BtsYZUhv1neXh5z1I1EH2kiaQTMAkTH/e00og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DHOiU0Rf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v0HLm4Rkc9mc8pIoHGGmMtBul2U6DF9EY18ORPTxBvo=; b=DHOiU0Rfia4BPRmnMFrDQXNqb4
	gTj+QFWmUTTAmPglXHhY75fIN3Cm+GVdHxMVwFUxjQDauiqdbH7JBhUHqdhu+1y+6Y+dBbjUv2Ln5
	IIqKNcQ3sQyXArvZ8mJR4saI+YFQsP8WiU6hKA6CXFNYUexX2cKDWAOws8qVaiMOxi359+fp3BvJQ
	7BQGsQx5rOXXtuQq1NrLBESb/YGCmFNYxC/km7OdjVQxxsySbXq6VUkoou8+d5/v5wg/aLELcTIcr
	ZNc2t6+JPCuklnw5FhG7OB2us/s/w2PCNrNPr1f0DRIyPGsa7VY7hUP+tJXikBCJ0YavlMOkXcnxF
	CE8nCGDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uriSd-0000000FgyN-3vT6;
	Thu, 28 Aug 2025 19:39:03 +0000
Date: Thu, 28 Aug 2025 20:39:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
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
	"vishal.moola@gmail.com" <vishal.moola@gmail.com>
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <aLCwVwjWe07Ievno@casper.infradead.org>
References: <b0f613ce-7aad-4b1d-b6a1-4acc1d6c489e@linux.intel.com>
 <dde6d861-daa3-49ed-ad4f-ff9dcaf1f2b8@linux.intel.com>
 <b57d7b97-8110-47c5-9c7a-516b7b535ce9@intel.com>
 <c69950ee-660b-4f51-9277-522470d0ce5d@linux.intel.com>
 <400cf9ab-de3f-4e8a-ab0a-4ac68c534bb8@intel.com>
 <ee44764b-b9fe-431d-8b84-08fce6b5df75@linux.intel.com>
 <BN9PR11MB5276FCF7D5182D711E135BB78C3BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d88f4f9f-6112-431c-948e-5f48181972aa@intel.com>
 <20250828191057.GG7333@nvidia.com>
 <ba372b0d-beba-4564-a8a8-84318e5d1238@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba372b0d-beba-4564-a8a8-84318e5d1238@intel.com>

On Thu, Aug 28, 2025 at 12:31:40PM -0700, Dave Hansen wrote:
> On 8/28/25 12:10, Jason Gunthorpe wrote:
> >> The biggest single chunk of code is defining ptdesc_*_kernel(). The rest
> >> of it is painfully simple.
> > Seems not great to be casting ptdesc to folio just to use
> > folio_set_referenced(), I'm pretty sure that is no the direction
> > things are going in..
> 
> Ideally, the ptdesc->__page_flags fields would have their own set of
> macros just like folios do, right? Alas, I was too lazy to go to the
> trouble of conjuring those up for this single bit.

There's a bunch of "Ideally" in ptdesc, but I'm equially too lazy to do
that before I've proven everything works great with slab and/or folios.
It'll have to be changed no matter which way we do it, so as long as
it's obvious where needs to be changed, it's fine.  I deem this
"good enough for now".

