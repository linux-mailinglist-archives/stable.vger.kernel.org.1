Return-Path: <stable+bounces-161636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7D2B01607
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 10:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4953BD317
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 08:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF2220DD52;
	Fri, 11 Jul 2025 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A/Whj7Gs"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24F1FE470;
	Fri, 11 Jul 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222479; cv=none; b=a+FTTIeQ3vad5bj2oPacHmT/8K4CPbrkWS2Oy150vQs2bcbqnGZGw+0E8JRSw9erYhi5pE9HFEZklOqw1bJeKq2BNcP1isw4zSpH5j+b+3Q1p0jvkE8P94CAfLP3+eH57J3ZBk90qBytPqdfhCT39dislDzLRmwPYTXVWLE/4do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222479; c=relaxed/simple;
	bh=RRdsqdC1y2DalFWiED+DTOQVdsPj1GGQ/CMLDGZlysU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpxqYfiQLhOciejky0Iz1dBfoDmApkvlHEjbPDs9xwjW412rU2I2y4wn1RLdFl5NP6PqQhWI6o79SiWp+ghY/g3V11N7dXB4U10z4tGDsVSu54Odu5mGdl7YkdTaeGFxj5Dz8QeEXQTBPJyPvGvIQ0ICSYzUD3BaVp0y77kbOtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A/Whj7Gs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J62mNrOujt+BmROjTiUeIdLj3EuDVmgaDfceNzUrnVc=; b=A/Whj7GsjX3G85qcHzAvDBE4Ge
	XGDCjf1uAg8yPZtnlKTn9J1B1rBqAAlgZkAynhooEmFoFWCez2lWysiGFfmmt43+2NNFlxCsfTsg9
	jcvIKEaIF/zSn51/9BvzZGftL9MN4O1Mzj9nxplkGsgRYApDn96Wvp67Xw2xjaVG9KUB1GT3OxMsK
	iFnQ8C5do9Qny4NLMNwH+Z2I5UFaF6rrvK/hFZMB+klTfeMDsa4R3OAXR17S4V9JDsYcYy0mn5wuG
	rABXS4uwVy8CT/Mls7A89dLfbuO3FgZMagznKBDeu6rySp5NoMDcZurdUDsuDdSWepoQ0l0TKmq+d
	w6IuUPlQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua96j-00000009E2r-0Mpj;
	Fri, 11 Jul 2025 08:27:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B67B23001AA; Fri, 11 Jul 2025 10:27:47 +0200 (CEST)
Date: Fri, 11 Jul 2025 10:27:47 +0200
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
Message-ID: <20250711082747.GD1099709@noisy.programming.kicks-ass.net>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <20250710135432.GO1613376@noisy.programming.kicks-ass.net>
 <20250710155319.GK1613633@noisy.programming.kicks-ass.net>
 <e00587f2-ebfa-436b-a17a-198ff9c02f4a@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e00587f2-ebfa-436b-a17a-198ff9c02f4a@linux.intel.com>

On Fri, Jul 11, 2025 at 11:09:00AM +0800, Baolu Lu wrote:
> On 7/10/25 23:53, Peter Zijlstra wrote:
> > On Thu, Jul 10, 2025 at 03:54:32PM +0200, Peter Zijlstra wrote:
> > 
> > > > @@ -132,8 +136,15 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
> > > >   	if (ret)
> > > >   		goto out_free_domain;
> > > >   	domain->users = 1;
> > > > -	list_add(&domain->next, &mm->iommu_mm->sva_domains);
> > > > +	if (list_empty(&iommu_mm->sva_domains)) {
> > > > +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
> > > > +			if (list_empty(&iommu_sva_mms))
> > > > +				static_branch_enable(&iommu_sva_present);
> > > > +			list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
> > > > +		}
> > > > +	}
> > > > +	list_add(&domain->next, &iommu_mm->sva_domains);
> > > >   out:
> > > >   	refcount_set(&handle->users, 1);
> > > >   	mutex_unlock(&iommu_sva_lock);
> > > > @@ -175,6 +186,15 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
> > > >   		list_del(&domain->next);
> > > >   		iommu_domain_free(domain);
> > > >   	}
> > > > +
> > > > +	if (list_empty(&iommu_mm->sva_domains)) {
> > > > +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
> > > > +			list_del(&iommu_mm->mm_list_elm);
> > > > +			if (list_empty(&iommu_sva_mms))
> > > > +				static_branch_disable(&iommu_sva_present);
> > > > +		}
> > > > +	}
> > > > +
> > > >   	mutex_unlock(&iommu_sva_lock);
> > > >   	kfree(handle);
> > > >   }
> > > 
> > > This seems an odd coding style choice; why the extra unneeded
> > > indentation? That is, what's wrong with:
> > > 
> > > 	if (list_empty()) {
> > > 		guard(spinlock_irqsave)(&iommu_mms_lock);
> > > 		list_del();
> > > 		if (list_empty()
> > > 			static_branch_disable();
> > > 	}
> > 
> > Well, for one, you can't do static_branch_{en,dis}able() from atomic
> > context...
> > 
> > Was this ever tested?
> 
> I conducted unit tests for vmalloc()/vfree() scenarios, and Yi performed
> fuzzing tests. We have not observed any warning messages. Perhaps
> static_branch_disable() is not triggered in the test cases?

Same with static_branch_enable(). These functions start with
cpus_read_lock(), which is percpu_down_read(), which has might_sleep().

