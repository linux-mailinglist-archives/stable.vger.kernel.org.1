Return-Path: <stable+bounces-161609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A31B007F1
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 18:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025BB1C4481C
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7A8279903;
	Thu, 10 Jul 2025 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b5cBxwJu"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EAD275B01;
	Thu, 10 Jul 2025 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162811; cv=none; b=Fb6QzaMESP6/0gGjoTeFLIdzXHis6cp6qDSIURp2IpKex49FnyUNwKVfO7tVnmTLcoShysasaYGLuxrhJR9gCyERKwfIY8g7LfA16f/iG8oJO8M0+01JwSBIe8Ump5yc4vLrTPQ7xJxoUGusF0N4N8rC6jqnMa8D7/650OK9nj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162811; c=relaxed/simple;
	bh=L+rDpjUR2YolHYl/VFVujaBW6nIbrti+jFY/+WP3xwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQCJ5nqDWV7hp76sf8OBBRwI1BP9gNqLALxTmVrsFd4yiZYyagN9eJ7Dn5ms9rZEdhQd5yNaTg/BdOTFxjnXpP3CuAIobH4HTZYrQuEYBGiWehq1GRqKriEbjoVOV8QlaHxVK3vr5DenunEO5mKlck8M9TQB2izRf+3e5EdOreY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b5cBxwJu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1TxGwpUXO8/utlTFXwknHkG6WKa5EzfB/L/x9yt1Lew=; b=b5cBxwJuWuIJVHbzLh9DToDPhW
	8RRoNBFZOex/z42OZLcHJ6AA41zGfo26ldL6U4weFwJpD3zOeq7BBRLBArMprePiXJ9DMyfC/yDIm
	x5j/ZXvYCHpIk5JjV/N5Jp1CSFXgSiFbs6rEJuBeHxpUlQU507R7TX4QU/HYPyV5N5pU6iPiqsj2S
	/HLQtBefZEApEBQgXfDt4OzSdNS9dLNEUf2iHrVhzMiTCYw311mHft7efdYyEjyqcs9F4mWQ1EnC3
	TBWzhL6d0G4TLNq4iSxirohbficjX6+NaNhERLP71UiM2HlKQFU+TjK+nV4VppGugcMQAYQnIRsfn
	NyxO5zDg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZtaK-00000009UNl-0UqQ;
	Thu, 10 Jul 2025 15:53:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2B120300158; Thu, 10 Jul 2025 17:53:19 +0200 (CEST)
Date: Thu, 10 Jul 2025 17:53:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
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
Message-ID: <20250710155319.GK1613633@noisy.programming.kicks-ass.net>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <20250710135432.GO1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710135432.GO1613376@noisy.programming.kicks-ass.net>

On Thu, Jul 10, 2025 at 03:54:32PM +0200, Peter Zijlstra wrote:

> > @@ -132,8 +136,15 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
> >  	if (ret)
> >  		goto out_free_domain;
> >  	domain->users = 1;
> > -	list_add(&domain->next, &mm->iommu_mm->sva_domains);
> >  
> > +	if (list_empty(&iommu_mm->sva_domains)) {
> > +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
> > +			if (list_empty(&iommu_sva_mms))
> > +				static_branch_enable(&iommu_sva_present);
> > +			list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
> > +		}
> > +	}
> > +	list_add(&domain->next, &iommu_mm->sva_domains);
> >  out:
> >  	refcount_set(&handle->users, 1);
> >  	mutex_unlock(&iommu_sva_lock);
> > @@ -175,6 +186,15 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
> >  		list_del(&domain->next);
> >  		iommu_domain_free(domain);
> >  	}
> > +
> > +	if (list_empty(&iommu_mm->sva_domains)) {
> > +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
> > +			list_del(&iommu_mm->mm_list_elm);
> > +			if (list_empty(&iommu_sva_mms))
> > +				static_branch_disable(&iommu_sva_present);
> > +		}
> > +	}
> > +
> >  	mutex_unlock(&iommu_sva_lock);
> >  	kfree(handle);
> >  }
> 
> This seems an odd coding style choice; why the extra unneeded
> indentation? That is, what's wrong with:
> 
> 	if (list_empty()) {
> 		guard(spinlock_irqsave)(&iommu_mms_lock);
> 		list_del();
> 		if (list_empty()
> 			static_branch_disable();
> 	}

Well, for one, you can't do static_branch_{en,dis}able() from atomic
context...

Was this ever tested?

