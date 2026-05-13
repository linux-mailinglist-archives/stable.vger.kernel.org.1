Return-Path: <stable+bounces-246903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NiXOi2fBGqbMAIAu9opvQ
	(envelope-from <stable+bounces-246903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:56:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B89536969
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A73EA344D211
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB22A4949FF;
	Wed, 13 May 2026 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Naeqi6PG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF82494A00
	for <stable@vger.kernel.org>; Wed, 13 May 2026 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685236; cv=none; b=pDgL4xUEFEIz2eNrUVAKhVn+p2+I3S72CzmEl+AdyTYRWdchpHMY57tlGYg+kgnp8kOHcXplxUkWHPHQ+Vbvvq9zP06zJOqlOCk44jEre7UNKk3t3mTLErUhtSD75yUU3pCL91M6LJUuNieFHyKvBQuDGQivDjLN2g1VSaShidk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685236; c=relaxed/simple;
	bh=9zHffo3S0bw1RySXVZoK66sIg5ouIst+aOuVoIjjFsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLaY+yzBHQM5xCp2KbJhfE0mf+fiAGxqEoWDVVPgdS4d7k3+HUEiDn3flYkGSTPg5Cfbzn+KnJGtN8gKLeFYK/4cj4RQwIgnTbldPpGnTg0NWAdRcvs93/4/NyaxbUcmOyQUAmOoM1NWdDesrhUM2/Br59mMIc640VLcqXU8sJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Naeqi6PG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so2585e9.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 08:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778685232; x=1779290032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1AfmyKrxvqScsqmboxj2hvUOAUvpypNoCC8X5gzigVM=;
        b=Naeqi6PG5i0SJAPfkxiTJEpUePnm3oXVx535CauHFbMV/BX5Hna2r6eA8ZcLMuNIf2
         FuR9m1zAxDcbKHUnSWKrjS/o7kF9rx+V+YWd/gZH0+K/uWpuTlV0EUu85LYXv6hB581E
         UsZpivP3Sk+nQoDiEPjTD2QMEcfr80HvMGOi1UcPBeixm7H6k+Ynocauw1zf2gvS8ZCw
         0mHTUDHZZFBzkECmwEb8TTpMmTqRU2Ida8SDOzsdwGYbDJc5fWN1LNnbB5/H9EhfHbJ4
         281twrkqCAccccv3xlh2HetIf6B0VFEkwDPpYJhzOQPV/jfMQZ/49b/LYTPpapxZXJBW
         v7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778685232; x=1779290032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AfmyKrxvqScsqmboxj2hvUOAUvpypNoCC8X5gzigVM=;
        b=DG1FQPG7X53Kn9W4oxee0tozNZqJvR6rb5n+xmA2iQccCNfKQ6Vq3daCLL3WrlXjEN
         JAjlALYxr9lfWra0WhlMcSDPvQdW0mJKYNvYM/0uzXdH87XIvUKGHIKfKD1sU7Gx4Qdz
         u9HeSF0boLTcJpfhtcAagkfRHrn4QbikEbaRPaaDsEgib6NgLkIod33uNtbUehKrKjRt
         twbBakAvELej+9pBliZhsZ3MaY80mnPaLx/v2ts12VgbyFwn4HaS7XJtx1InwY6ky6N0
         IYpF1UMp/aJ+SPeG01rlPXAkIxEQL3fqdK9qlC//XaA9QXgDrZCtY0ccpnZQ0SP2yGjh
         T2sA==
X-Forwarded-Encrypted: i=1; AFNElJ9LdopWStI5WsFnw2SYRQkxel0fgvG5dQjssLuNjCh+Kkq7EUcRJktYMadTnLSzyC1DGwcm7WI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5/Nitlw/3Cx+K21chOYIAiOsBGQfzPMVBc4Ysm0V6rZp9h86x
	VYHPVzlJOO046fG9I/EsrZGE5oBo2Jdk/nB6R+7zLxdR0YfsyxSGJcShm2UWoEL5Mw==
X-Gm-Gg: Acq92OHP2g+wVlNqGh6AAWTnC6juq9pZ766zXXENBOSL+z7jzuqWUpMwHkrsw6DMzpu
	wtae0WIVMdu5OEIRTZoIv6p+FvdPSLOjiQbQJmIlgH6+JjTPReHB2Y5IGN6I8OOYxeFmwdxp0eq
	TC8cohbgKS6CmuiQFjLxws3e51qLVaVlqngjoXeFCFRd64aE7RwuJnJI0KjYbNdJjzNxrwiZPDV
	5DemF1Z1rtG/gXrqIuwKB+7D2a27lERqB9IGssPrj0O6hJ6p4Kb1AAUnmwM5TNN649JFfLr7Moy
	/TlTOxxzvDfBB6TN61nAlcdeesf6QvFevsKAY/ayqe+ZECOltIptgd2QPuPZXEOHNEq7YgA8G5Y
	RMvUtr5qIY6/Ekebj6pl6P8mGD3xk8yeWn0zG6znp6diUtgoR5A4p/rhsYG2mZgbZ5wx8S6tPSC
	AGFu5WddLVmBT9/mKSNiggqlBye7Q4iOZDBz/qnx4lFCRFi6fFYIXy8fT+Qhm05oX+OgE=
X-Received: by 2002:a05:600d:6401:10b0:475:d905:9f12 with SMTP id 5b1f17b1804b1-48fc91218abmr868245e9.4.1778685231954;
        Wed, 13 May 2026 08:13:51 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd6278b17sm235225e9.0.2026.05.13.08.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:13:51 -0700 (PDT)
Date: Wed, 13 May 2026 15:13:41 +0000
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
Subject: Re: [PATCH rc 3/5] iommu: Handle unmap error when iommu_debug is
 enabled
Message-ID: <agSVJeBx849TqOBM@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <3-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
X-Rspamd-Queue-Id: 58B89536969
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246903-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:46:15PM -0300, Jason Gunthorpe wrote:
> Sashiko noticed a latent bug where the map error flow called iommu_unmap()
> which calls iommu_debug_unmap_begin()/iommu_debug_unmap_end() however
> since this is an error path the map flow never actually established the
> original iommu_debug_map() it will malfunction.
> 
> Lift the unmap error handling into iommu_map_nosync() and reorder it so
> the trace_map()/iommu_debug_map() records the partial mapping and then
> immediately unmaps it. This avoid creating the unbalanced tracking and
> provides saner tracing instead of a unmap unmatched to any map.

There is usually littel coverage in such paths, I have been thinking
of creating some test-suites on the IOMMU and io-pgtable/SMMUv3 level
to cover some of the failure cases and some of the tricky page table
operations, the problem is that there are many things to cover (starting
from the crashes/logical issues till TLB invalidation correctness of
some operations).

I will try to post something when I get some time.

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> 
> Fixes: ccc21213f013 ("iommu: Add calls for IOMMU_DEBUG_PAGEALLOC")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 49 +++++++++++++++++--------------------------
>  1 file changed, 19 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index e334588a2476b4..e5fa9875900228 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2575,12 +2575,11 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
>  
>  static int __iommu_map_domain_pgtbl(struct iommu_domain *domain,
>  				    unsigned long iova, phys_addr_t paddr,
> -				    size_t size, int prot, gfp_t gfp)
> +				    size_t size, int prot, gfp_t gfp,
> +				    size_t *mapped)
>  {
>  	const struct iommu_domain_ops *ops = domain->ops;
> -	unsigned long orig_iova = iova;
>  	unsigned int min_pagesz;
> -	size_t orig_size = size;
>  	int ret = 0;
>  
>  	if (WARN_ON(!ops->map_pages))
> @@ -2603,31 +2602,25 @@ static int __iommu_map_domain_pgtbl(struct iommu_domain *domain,
>  	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
>  
>  	while (size) {
> -		size_t pgsize, count, mapped = 0;
> +		size_t pgsize, count, op_mapped = 0;
>  
>  		pgsize = iommu_pgsize(domain, iova, paddr, size, &count);
>  
>  		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx count %zu\n",
>  			 iova, &paddr, pgsize, count);
>  		ret = ops->map_pages(domain, iova, paddr, pgsize, count, prot,
> -				     gfp, &mapped);
> +				     gfp, &op_mapped);
>  		/*
>  		 * Some pages may have been mapped, even if an error occurred,
>  		 * so we should account for those so they can be unmapped.
>  		 */
> -		size -= mapped;
> -
> +		*mapped += op_mapped;
>  		if (ret)
> -			break;
> +			return ret;
>  
> -		iova += mapped;
> -		paddr += mapped;
> -	}
> -
> -	/* unroll mapping in case something went wrong */
> -	if (ret) {
> -		iommu_unmap(domain, orig_iova, orig_size - size);
> -		return ret;
> +		size -= op_mapped;
> +		iova += op_mapped;
> +		paddr += op_mapped;
>  	}
>  	return 0;
>  }
> @@ -2645,6 +2638,7 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
>  		phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
>  {
>  	struct pt_iommu *pt = iommupt_from_domain(domain);
> +	size_t mapped = 0;
>  	int ret;
>  
>  	might_sleep_if(gfpflags_allow_blocking(gfp));
> @@ -2656,24 +2650,19 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
>  				 __GFP_HIGHMEM))))
>  		return -EINVAL;
>  
> -	if (pt) {
> -		size_t mapped = 0;
> -
> +	if (pt)
>  		ret = pt->ops->map_range(pt, iova, paddr, size, prot, gfp,
>  					 &mapped);
> -		if (ret) {
> -			iommu_unmap(domain, iova, mapped);
> -			return ret;
> -		}
> -	} else {
> +	else
>  		ret = __iommu_map_domain_pgtbl(domain, iova, paddr, size, prot,
> -					       gfp);
> -		if (ret)
> -			return ret;
> -	}
> +					       gfp, &mapped);
>  
> -	trace_map(iova, paddr, size);
> -	iommu_debug_map(domain, paddr, size);
> +	trace_map(iova, paddr, mapped);
> +	iommu_debug_map(domain, paddr, mapped);
> +	if (ret) {
> +		iommu_unmap(domain, iova, mapped);
> +		return ret;
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 

