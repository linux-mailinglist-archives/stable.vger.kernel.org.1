Return-Path: <stable+bounces-246902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKMOKCCXBGpQLwIAu9opvQ
	(envelope-from <stable+bounces-246902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:22:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8D6535FE3
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09160301EC5F
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19D44D2EC0;
	Wed, 13 May 2026 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sAOcdQk7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078D24CA262
	for <stable@vger.kernel.org>; Wed, 13 May 2026 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685117; cv=none; b=pzfx26zky0aEIi99wgatkJqLb1cXSWUB63Rwsnzdzl7tS6P3+p6mbFAyPVrHlLJtiqzyeRJ87bkBUvyTuuRqCzVqjDEOyo9YgrJnREQ7PrzGDD24YJ+mXwhNAVehpWBVtfDIdYwzFRjji3/2UpRD/aSMErR2hDs8tR6IQOq4XFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685117; c=relaxed/simple;
	bh=Lfm5qwtvKGVGvwVglM1WEBRrmbR9xt1BsC+h44z8tCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXg1Q1pgDGCD4KjDjhS5uZ5mSY8LiAXQsmPwztWUs03QlfdzYWR1LGj8gNjXxaYBHMlaLs1s70JyeIbdoYKGcXQA7Vo/nxYDVpuBt6/EEhMDieSGuh+ak8btk+f6cpyvwyKtX+2+J5cHtCUfszsBbzwlN/dSLjuOy5ROQfVQVxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sAOcdQk7; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d6b393d60so4831cf.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 08:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778685114; x=1779289914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWAe8c+ElCoD6sU6NETEOpCBbfD46C5Crtt3s27wLQM=;
        b=sAOcdQk7VzD3XloIdPgNWAM1jkR1TiFxuMmE/umAaQUf6D93Ts+789EZ2JO2wKGiKF
         Bs61mMwWfl5ua6X4eJvIK5+uM9SWRenzUZPYL+CjUPntuhzP12UhDYyimcSO1SFZq2yn
         8RpUfhowxe9+pywnvGpH+I/ys0RZtDNfMzXkB8ePyUFZADaNdypSXRNax8Yrkk0gok30
         MgmnYpe8PwmxTm9/j5hB3ubi45CQzVVtaUUwQmIi7SjBEWLs5N3mZ7bULqzvjUrx8Uh6
         eLxz8gTwX+1fif1bS7wmUSc7+fFAiqNlHTiVjR5c+Ine/Rh62YC8Ko/Umiz/sGY8GLp6
         ONdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778685114; x=1779289914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWAe8c+ElCoD6sU6NETEOpCBbfD46C5Crtt3s27wLQM=;
        b=B2gKhzeVaUncBIKW968tvz8YO1rBFQoq4ofcxeDcauB789E4haDK+psEKIO/v1hieC
         GphFsZPDVHIxPH7jQRcrEX+uUcnQ3bmB++uwWtQrzd1vcIPDoT0EeK6EnL4xrYdbaVDF
         q8jstCR1OprQXS+Va4ADI2ny2ZCK5oUKeOFe2wHNVBc/iQDzJIZLzLxyrZB91GX9ZkfO
         irH4MyiV7rHgP9eE/KcORI/BoRF4Gf4hDpw79uWfB8V/pV04w43nd+VK2gL6bbGPO9Yz
         d3K6wZakFAwIwnJXa5+EhDpm8U4TpmszbTLRk5T5KLbFeZeaC9cVUcLs4/DbvEm8B2fO
         8x8A==
X-Forwarded-Encrypted: i=1; AFNElJ95GhwiAwooiNTFT7Yx13c2rj4b0HPlDNsU4fSotb6B5NbcBRXRi+FNa9a7WVXAy3hWRCspi7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD9uHyGdNxy+e5B1HhLvhkOfzdwOTIGinvGlhTL6EreBZRRB+Y
	c5AZUQ/CSJ5Vm4gfX7GOiJZXYg439otGagYVhz01VV34fWD22BoyoV541Nkbke9nFg==
X-Gm-Gg: Acq92OEmePckxa5dm/1Bz4jN97u2PpeA684W2zdbBH461ctGe1PilHJxmVHUi5hnclu
	cHXG1clYus8kKlsE2uPtlKfHxzvWc8oUruCRefAca2esuVLuVX2JWHZQ3PbPFmU9UaQjaTAwl9x
	i/B6mO76D9fVG72/zYjvzvRjjoHnXiTawZrJDfPopVqvcEcczyXLektozvsU/n/r9ypxTXEaUmL
	A/A2406lO+HRtayjqOXLL/u8QkFjqg+kzxBx/XJN0mglUw065JeIkHWY9EyAQE9mcyAa577s95j
	CrU38Q/CJfE8cVbudtS/SOYgsNsapw/+iS9Q5J9ZXiHiizeLCdiwUFyyZI4ai1w3RUOhi54HAUQ
	emy2EM0SIpOriUHOVnxNvy1CM6iIzwWW/l/onylhjbbvAUBl+75FwLClssiQgleC0QH2DbgqI71
	2V85ZjlxLrk7BNjRQob4jYRp+htbpI592T2O4Dyny0A3kxdJHsOGbhsSBnFXtkzERSBr4=
X-Received: by 2002:ac8:5996:0:b0:509:1d4b:f86f with SMTP id d75a77b69052e-5162b156ecemr16742311cf.14.1778685113161;
        Wed, 13 May 2026 08:11:53 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d450dcbsm376655416d6.45.2026.05.13.08.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:11:52 -0700 (PDT)
Date: Wed, 13 May 2026 15:11:44 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Josua Mayer <josua@solid-run.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 2/5] iommu: Fix up map/unmap debugging for iommupt
 domains
Message-ID: <agSUsGB2MabPq_qm@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <2-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
X-Rspamd-Queue-Id: 2F8D6535FE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246902-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:46:14PM -0300, Jason Gunthorpe wrote:
> Sashiko noticed a few issues in this path, and a few more were
> found on review. Tidy them up further. These are intertwined
> because the debug code depends on some of the WARN_ONs to function
> right:
> 
> Lift into iommu_map_nosync():
> - The might_sleep_if()
> - 0 pgsize_bitmap WARN_ON
> - Promote the illegal domain->type to a WARN_ON
> - WARN_ON for illegal gfp flags
> 
> Then remove the return 0 since it is now safe to call
> iommu_debug_map().
> 
> Lift into __iommu_unmap():
> - 0 pgsize_bitmap WARN_ON
> - Promote the illegal domain->type to a WARN_ON
> - iommu_debug_unmap_begin()
> 
> This now pairs with the unconditional iommu_debug_map() on the
> mapping side. Thus iommu debugging now works for iommupt along
> with some of the other debugging features.
> 
> Fixes: 99fb8afa16ad ("iommupt: Directly call iommupt's unmap_range()")
> Fixes: d6c65b0fd621 ("iommupt: Avoid rewalking during map")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/iommu/iommu.c | 43 ++++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 6e53cfad5dc001..e334588a2476b4 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2583,19 +2583,9 @@ static int __iommu_map_domain_pgtbl(struct iommu_domain *domain,
>  	size_t orig_size = size;
>  	int ret = 0;
>  
> -	might_sleep_if(gfpflags_allow_blocking(gfp));
> -
> -	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
> -		return -EINVAL;
> -
> -	if (WARN_ON(!ops->map_pages || domain->pgsize_bitmap == 0UL))
> +	if (WARN_ON(!ops->map_pages))
>  		return -ENODEV;
>  
> -	/* Discourage passing strange GFP flags */
> -	if (WARN_ON_ONCE(gfp & (__GFP_COMP | __GFP_DMA | __GFP_DMA32 |
> -				__GFP_HIGHMEM)))
> -		return -EINVAL;
> -
>  	/* find out the minimum page size supported */
>  	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
>  
> @@ -2657,6 +2647,15 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
>  	struct pt_iommu *pt = iommupt_from_domain(domain);
>  	int ret;
>  
> +	might_sleep_if(gfpflags_allow_blocking(gfp));
> +
> +	/* Discourage passing strange GFP flags or illegal domains */
> +	if (WARN_ON_ONCE(!(domain->type & __IOMMU_DOMAIN_PAGING) ||
> +			 !domain->pgsize_bitmap ||
> +			 (gfp & (__GFP_COMP | __GFP_DMA | __GFP_DMA32 |
> +				 __GFP_HIGHMEM))))
> +		return -EINVAL;
> +
>  	if (pt) {
>  		size_t mapped = 0;
>  
> @@ -2666,11 +2665,12 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
>  			iommu_unmap(domain, iova, mapped);
>  			return ret;
>  		}
> -		return 0;
> +	} else {
> +		ret = __iommu_map_domain_pgtbl(domain, iova, paddr, size, prot,
> +					       gfp);
> +		if (ret)
> +			return ret;
>  	}
> -	ret = __iommu_map_domain_pgtbl(domain, iova, paddr, size, prot, gfp);
> -	if (ret)
> -		return ret;
>  
>  	trace_map(iova, paddr, size);
>  	iommu_debug_map(domain, paddr, size);
> @@ -2702,10 +2702,7 @@ __iommu_unmap_domain_pgtbl(struct iommu_domain *domain, unsigned long iova,
>  	size_t unmapped_page, unmapped = 0;
>  	unsigned int min_pagesz;
>  
> -	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
> -		return 0;
> -
> -	if (WARN_ON(!ops->unmap_pages || domain->pgsize_bitmap == 0UL))
> +	if (WARN_ON(!ops->unmap_pages))
>  		return 0;
>  
>  	/* find out the minimum page size supported */
> @@ -2724,8 +2721,6 @@ __iommu_unmap_domain_pgtbl(struct iommu_domain *domain, unsigned long iova,
>  
>  	pr_debug("unmap this: iova 0x%lx size 0x%zx\n", iova, size);
>  
> -	iommu_debug_unmap_begin(domain, iova, size);
> -
>  	/*
>  	 * Keep iterating until we either unmap 'size' bytes (or more)
>  	 * or we hit an area that isn't mapped.
> @@ -2761,6 +2756,12 @@ static size_t __iommu_unmap(struct iommu_domain *domain, unsigned long iova,
>  	struct pt_iommu *pt = iommupt_from_domain(domain);
>  	size_t unmapped;
>  
> +	if (WARN_ON_ONCE(!(domain->type & __IOMMU_DOMAIN_PAGING) ||
> +			 !domain->pgsize_bitmap))
> +		return 0;
> +
> +	iommu_debug_unmap_begin(domain, iova, size);
> +
>  	if (pt)
>  		unmapped = pt->ops->unmap_range(pt, iova, size, iotlb_gather);
>  	else
> -- 
> 2.43.0
> 

