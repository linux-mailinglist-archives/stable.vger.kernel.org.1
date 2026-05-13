Return-Path: <stable+bounces-246949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JSSGhSvBGp6NAIAu9opvQ
	(envelope-from <stable+bounces-246949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:04:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D058C537A18
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 278A730073CE
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947CC3F411C;
	Wed, 13 May 2026 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTnaEnu2"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7EC4D9918
	for <stable@vger.kernel.org>; Wed, 13 May 2026 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691404; cv=none; b=sq2BQ+KhOK/Gt0Omo4tqALZYlsHE7X5maogsZe1rdqB7O22fdPpuloTUEVd9MXO8NzJNhNFyUP8QCa6Vpjr3xnKvA9ce1P4xM91AmC9uA2zJwZyHI56Q5GI/0ParjVC1OlNbpoOy/GK1M2NcNVuf24TMeFBaHUC3GdUr5j5eOg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691404; c=relaxed/simple;
	bh=Ut5l11CKVrSjVJL/SXBTdKTB+m65fhYWOTIJs46hZ4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3dX9RO85H3FrDFe+6ju/GZ+0QSAmVXMll8cPQYW+xPDRo5K8F78AGZIj4pFeqe7+x6/lChN13iM3YYHEgFBm9v9LxhyfXyA3SDLamiE7nWVSkB8WozlLJ2R3E7AeT0//ALtQlkfuCxVhaxYltQrGEXSoLwA9rNOG/i9jzLWa6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aTnaEnu2; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-133362c30cfso1492c88.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778691399; x=1779296199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3lVfNFiffp+uU+9DlG1DEynuXNArzY2ybDWxR4v/kU=;
        b=aTnaEnu2SOWv+Ih1rSXzm9mUnqp2C7WmEXkhpHuUFN526oULyt2fmxBDjx9TT6i8Dt
         LLr0wseIfz0omLJnM/cZkjJUOKdjYuvdQ/9u+kj3cksb+GiedrosowvSy/cBPDqYeB/j
         tUVqR5xChTUJleK0By5m2sFMIUiG8sA3FkcqZ04IZa2PZFQPkxR41oD8K+U4ujh+A8GD
         5y5AeZICJiB98+mUqCMV3xtj3aJDzQFIkVjI0gkygis6YGMzaePNqHZNgsPtLKCnexBH
         zJnm9bIGZPjqxbAphERy5SY+Cg6xfARfwEXjbtiih8sM/fub3zRcwj/LT5/ZRdie7wUm
         fGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778691399; x=1779296199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3lVfNFiffp+uU+9DlG1DEynuXNArzY2ybDWxR4v/kU=;
        b=qZC0v/TRIUAz0yDpXWANgMk3djxFw0zlHrEOI3wjckC8Nb9pvSX+me7cvabg1geDbY
         l0fQs/DdvNJQsG0ugWBXkB+bXo3oM/4MovRPuyIyiLluVlCzSIr4xUQ0EqHGF+kf6JIT
         jObXRR6kZHIH/5DA0hFG2EmLSQGeyM4L7eylv2kLv3vOyh91SatISInXh7zuSQ7FMFeK
         a6532K/YrpztGT88JvESnaegI3qS0O/0paXAHXq5ufi972kbONXCOHXOka8e+zMn54Pa
         rhX40XEtJT7ITPLpq+Dn/3tFw6cXjTV6mxks2aFob/bg8zc/Nv2TcXZKzO1hpSY5PXAa
         Ek9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Vm/l9fIgpnv0aWzmAAK+u62Wt5nNHaNExrIkgOPCCy/jnOqBW1jDleIwUEc7rKZhJWW6mrDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi+yQ/0p8dv1QnPRXY6FZ3rOZ7z7+buFeY+OGmQImXOUxQzqX0
	3SRiQFFGHwMFgPlRcfrLdgUWFjjnJgKScxJ2ceDoBKcX1i4afkjvgrh6YEtOC5KI4g==
X-Gm-Gg: Acq92OHZY34STSKxpyT+3SSTpY4nVUtGr1JL/c2u4ZMPYk+FkM5AZZz3JrCsVOTHEDO
	1tBSKXM5TuMprs/iqW4zcmLuvGRswcOhsoFUEE5LjDpBpgyMXfopNrgyQOIZUpscJMYYR+kmlwS
	rgLpsoigqUM0rIuEE5O3SW3rBlL86DESEJ2jcjrZl6NOeexjSrHd81btiHUc3P7w8gfe1pnfN9j
	harV/IJQNwf2tSTzH9ZRxjw7YIQYlOnGiLu2S1gC9DmLKn0UbRJkwjR0Ykm/r60AMjWV+/5HeVW
	uYV4N3agEoBC6VFC5ECj3sdnAuJZwvndWrD8/WLqRs7PXHeGPwb0xdqDSdzO7QZeujAGGiUNED4
	bSjfAM9ZtXa/Rll7z7N6tgObV+XFDax/o8829JGH4yGSAIPoXHsn7g4SMV+DkLFoEXcKkpi1omF
	sJvZ6s95gqmO5mUaHch5uwsxGDZWZemJFTEu0//g71yDTwGazxl549rX2gVukzibhibxCqzg==
X-Received: by 2002:a05:7022:ef05:b0:12c:7ec:b96 with SMTP id a92af1059eb24-1347dbc6465mr209272c88.1.1778691397968;
        Wed, 13 May 2026 09:56:37 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888c3b301sm29447066eec.23.2026.05.13.09.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:56:37 -0700 (PDT)
Date: Wed, 13 May 2026 16:56:33 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Josua Mayer <josua@solid-run.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 3/5] iommu: Handle unmap error when iommu_debug is
 enabled
Message-ID: <agSswSq8bTYiI6Uv@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <3-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
X-Rspamd-Queue-Id: D058C537A18
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
	TAGGED_FROM(0.00)[bounces-246949-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhawaja@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:46:15PM -0300, Jason Gunthorpe wrote:
>Sashiko noticed a latent bug where the map error flow called iommu_unmap()
>which calls iommu_debug_unmap_begin()/iommu_debug_unmap_end() however
>since this is an error path the map flow never actually established the
>original iommu_debug_map() it will malfunction.
>
>Lift the unmap error handling into iommu_map_nosync() and reorder it so
>the trace_map()/iommu_debug_map() records the partial mapping and then
>immediately unmaps it. This avoid creating the unbalanced tracking and
>provides saner tracing instead of a unmap unmatched to any map.
>
>Fixes: ccc21213f013 ("iommu: Add calls for IOMMU_DEBUG_PAGEALLOC")
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> drivers/iommu/iommu.c | 49 +++++++++++++++++--------------------------
> 1 file changed, 19 insertions(+), 30 deletions(-)
>
>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>index e334588a2476b4..e5fa9875900228 100644
>--- a/drivers/iommu/iommu.c
>+++ b/drivers/iommu/iommu.c
>@@ -2575,12 +2575,11 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
>
> static int __iommu_map_domain_pgtbl(struct iommu_domain *domain,
> 				    unsigned long iova, phys_addr_t paddr,
>-				    size_t size, int prot, gfp_t gfp)
>+				    size_t size, int prot, gfp_t gfp,
>+				    size_t *mapped)
> {
> 	const struct iommu_domain_ops *ops = domain->ops;
>-	unsigned long orig_iova = iova;
> 	unsigned int min_pagesz;
>-	size_t orig_size = size;
> 	int ret = 0;
>
> 	if (WARN_ON(!ops->map_pages))
>@@ -2603,31 +2602,25 @@ static int __iommu_map_domain_pgtbl(struct iommu_domain *domain,
> 	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
>
> 	while (size) {
>-		size_t pgsize, count, mapped = 0;
>+		size_t pgsize, count, op_mapped = 0;
>
> 		pgsize = iommu_pgsize(domain, iova, paddr, size, &count);
>
> 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx count %zu\n",
> 			 iova, &paddr, pgsize, count);
> 		ret = ops->map_pages(domain, iova, paddr, pgsize, count, prot,
>-				     gfp, &mapped);
>+				     gfp, &op_mapped);
> 		/*
> 		 * Some pages may have been mapped, even if an error occurred,
> 		 * so we should account for those so they can be unmapped.
> 		 */
>-		size -= mapped;
>-
>+		*mapped += op_mapped;
> 		if (ret)
>-			break;
>+			return ret;
>
>-		iova += mapped;
>-		paddr += mapped;
>-	}
>-
>-	/* unroll mapping in case something went wrong */
>-	if (ret) {
>-		iommu_unmap(domain, orig_iova, orig_size - size);
>-		return ret;
>+		size -= op_mapped;
>+		iova += op_mapped;
>+		paddr += op_mapped;
> 	}
> 	return 0;
> }
>@@ -2645,6 +2638,7 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
> 		phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> {
> 	struct pt_iommu *pt = iommupt_from_domain(domain);
>+	size_t mapped = 0;
> 	int ret;
>
> 	might_sleep_if(gfpflags_allow_blocking(gfp));
>@@ -2656,24 +2650,19 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
> 				 __GFP_HIGHMEM))))
> 		return -EINVAL;
>
>-	if (pt) {
>-		size_t mapped = 0;
>-
>+	if (pt)
> 		ret = pt->ops->map_range(pt, iova, paddr, size, prot, gfp,
> 					 &mapped);
>-		if (ret) {
>-			iommu_unmap(domain, iova, mapped);
>-			return ret;
>-		}
>-	} else {
>+	else
> 		ret = __iommu_map_domain_pgtbl(domain, iova, paddr, size, prot,
>-					       gfp);
>-		if (ret)
>-			return ret;
>-	}
>+					       gfp, &mapped);
>
>-	trace_map(iova, paddr, size);
>-	iommu_debug_map(domain, paddr, size);
>+	trace_map(iova, paddr, mapped);
>+	iommu_debug_map(domain, paddr, mapped);
>+	if (ret) {
>+		iommu_unmap(domain, iova, mapped);
>+		return ret;
>+	}
> 	return 0;
> }
>
>-- 
>2.43.0
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

