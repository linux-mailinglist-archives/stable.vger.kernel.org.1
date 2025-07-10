Return-Path: <stable+bounces-161576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A2DB0047F
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 15:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08D41762DA
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01112701DA;
	Thu, 10 Jul 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q9vefEVO"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBC28373;
	Thu, 10 Jul 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155686; cv=none; b=GWTguGHREk7MTTaj713X7ZmPaULMtXyhloNcSQ2fYxnEwHJn6T8vJG12lGSjUPbd9WWeZ0WgQzkMLAoVxm0RrYuWZCtKQ/K4YjLtva/Yls6mrYXl0xl6UAce6kh8bMD964lA67vYD4Z4ROBpKXtYHYaNS0MOa4kCuNrOWK3ZEM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155686; c=relaxed/simple;
	bh=vzDzTu3wYXCAVPoqRRfXS0PLk58brc7izPX2nCVGDxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFboiMRV573SOfz28Im1cjOvBRmWfjdwuMaXO8xRa5ShCasVsJQ9SyonX+vWF27RdYLNNvEhf7kP/kjbkcwTvViVB/EVMLzqfF0aW0cj7IVg6p/2zr1q0HbPnsJeMqpDKaGsGEx5wmmGheqKk0Yw77VyHox1NFxwnMMoEjrxlsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q9vefEVO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ukfpWO8KD6YeVMsUvRS88Tmw525WloSkaszXd9ES9Ac=; b=Q9vefEVOYiPxaq/DIq4ALZrpaa
	Nv/CuUSH45+Hokqf8nj/t4ICwtfmq/w+wDUCEvTLdzB5Zm1WWeFOqjPz1BzqCS4KzeZtwmULeWctQ
	X5aZQK/TUoFofj6SWV5sjIOj+wUhKujapMKnqvln9P7ZpHsIgdbTYK6FKwjCyrAKv4XHj9NCvqqJO
	zvIfs7N77nV4t4Uo0SN4hbLyid/jydiQjd2vqxXpgZRxBruQiU8E8igBn88BU6HrWL7KHeQmIJNaO
	umNwH5ZC57Eds9of4hdIUagPq9WsDpYsVR0/duiAh7AEFKHBBG3Yqcxmx1Ctw+Ijt2cSZHOGxOKIp
	jxHM8I7w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZrjN-000000091Tj-34Pw;
	Thu, 10 Jul 2025 13:54:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 81088300158; Thu, 10 Jul 2025 15:54:32 +0200 (CEST)
Date: Thu, 10 Jul 2025 15:54:32 +0200
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
Message-ID: <20250710135432.GO1613376@noisy.programming.kicks-ass.net>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709062800.651521-1-baolu.lu@linux.intel.com>

On Wed, Jul 09, 2025 at 02:28:00PM +0800, Lu Baolu wrote:
> The vmalloc() and vfree() functions manage virtually contiguous, but not
> necessarily physically contiguous, kernel memory regions. When vfree()
> unmaps such a region, it tears down the associated kernel page table
> entries and frees the physical pages.
> 
> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
> shares and walks the CPU's page tables. Architectures like x86 share
> static kernel address mappings across all user page tables, allowing the
> IOMMU to access the kernel portion of these tables.
> 
> Modern IOMMUs often cache page table entries to optimize walk performance,
> even for intermediate page table levels. If kernel page table mappings are
> changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
> entries, Use-After-Free (UAF) vulnerability condition arises. If these
> freed page table pages are reallocated for a different purpose, potentially
> by an attacker, the IOMMU could misinterpret the new data as valid page
> table entries. This allows the IOMMU to walk into attacker-controlled
> memory, leading to arbitrary physical memory DMA access or privilege
> escalation.
> 
> To mitigate this, introduce a new iommu interface to flush IOMMU caches
> and fence pending page table walks when kernel page mappings are updated.
> This interface should be invoked from architecture-specific code that
> manages combined user and kernel page tables.

I must say I liked the kPTI based idea better. Having to iterate and
invalidate an unspecified number of IOMMUs from non-preemptible context
seems 'unfortunate'.

Why was this approach chosen over the kPTI one, where we keep a
page-table root that simply does not include the kernel bits, and
therefore the IOMMU will never see them (change) and we'll never have to
invalidate?

> @@ -132,8 +136,15 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>  	if (ret)
>  		goto out_free_domain;
>  	domain->users = 1;
> -	list_add(&domain->next, &mm->iommu_mm->sva_domains);
>  
> +	if (list_empty(&iommu_mm->sva_domains)) {
> +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
> +			if (list_empty(&iommu_sva_mms))
> +				static_branch_enable(&iommu_sva_present);
> +			list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
> +		}
> +	}
> +	list_add(&domain->next, &iommu_mm->sva_domains);
>  out:
>  	refcount_set(&handle->users, 1);
>  	mutex_unlock(&iommu_sva_lock);
> @@ -175,6 +186,15 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>  		list_del(&domain->next);
>  		iommu_domain_free(domain);
>  	}
> +
> +	if (list_empty(&iommu_mm->sva_domains)) {
> +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
> +			list_del(&iommu_mm->mm_list_elm);
> +			if (list_empty(&iommu_sva_mms))
> +				static_branch_disable(&iommu_sva_present);
> +		}
> +	}
> +
>  	mutex_unlock(&iommu_sva_lock);
>  	kfree(handle);
>  }

This seems an odd coding style choice; why the extra unneeded
indentation? That is, what's wrong with:

	if (list_empty()) {
		guard(spinlock_irqsave)(&iommu_mms_lock);
		list_del();
		if (list_empty()
			static_branch_disable();
	}

> @@ -312,3 +332,15 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>  
>  	return domain;
>  }
> +
> +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
> +{
> +	struct iommu_mm_data *iommu_mm;
> +
> +	if (!static_branch_unlikely(&iommu_sva_present))
> +		return;
> +
> +	guard(spinlock_irqsave)(&iommu_mms_lock);
> +	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
> +		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);
> +}

This is absolutely the wrong way to use static_branch. You want them in
inline functions guarding the function call, not inside the function
call.


