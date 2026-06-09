Return-Path: <stable+bounces-262380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EWiIJ093KGp0FAMAu9opvQ
	(envelope-from <stable+bounces-262380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 22:27:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 160DD664154
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 22:27:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=OdMJeTZx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262380-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262380-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C91523031E98
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 20:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A013C10A7;
	Tue,  9 Jun 2026 20:26:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B83101B6
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 20:26:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781036788; cv=none; b=SLfyEALRjS6AUOY6zvlSlomfOFQcessCqF2w3daMvoqaB++HSrArO2pedGH4fhO2/jtn802KkgI761MGiKNu4tClDMxwmVt06MJrnF2DXtfFLW/oepU+35eEFo357OdcnM7xtTXZ8T/GlLANhaauFkly2d9QFshGI5ApAKQfY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781036788; c=relaxed/simple;
	bh=LpJw5/rR2o/yiUMFjEdd7DjoRvMJ/o5BY/vX0A5fvVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=MhsAnjw87OmVi0DugsCsPLHHXHqnSz+RI8go7lno6hK/nZMihMf4Jh7he7KH5Xa8iHjZGYR75sb7JOqHG/oPBp7elwDerWq3BpkHMt5gAR/znOb8Q4P/xzDxPvOu/1/rAWN5tFLCjxVMj+3EzGFJWFYWTi/GWNz9miSZqtY3F6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OdMJeTZx; arc=none smtp.client-ip=210.118.77.12
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260609202624euoutp02da81979351725265e55095747d3498c8~3g4TcMW2t0280102801euoutp02L
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 20:26:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260609202624euoutp02da81979351725265e55095747d3498c8~3g4TcMW2t0280102801euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781036784;
	bh=57bbvLEAqcBhGE8t67ZvZajQ3mKi7qJur7Og6R467TI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=OdMJeTZxDv2kDWMqxEnZy1IVY+qbiCiN3huzI7tnYXA0SDzHXHPz+m0MngV0QyL/O
	 +7NXZRoHGYly3KjWLRlrgEoIyZZ2xffgx88P7FR05far+qsaYJSPhyneY2JG7v7Jtr
	 l01Rt2Qq8ObgULm5P0Or4wflv+ihp/wc1wPzPfZg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260609202623eucas1p2c778d0a0de063740109d0e23aa94be57~3g4SvX7Ps0695906959eucas1p2-;
	Tue,  9 Jun 2026 20:26:23 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260609202622eusmtip2010977d9f71c2e150648808310a6047a~3g4SCJQ9i1572815728eusmtip2I;
	Tue,  9 Jun 2026 20:26:22 +0000 (GMT)
Message-ID: <574ad256-8004-45f6-a226-ad2c74be5060@samsung.com>
Date: Tue, 9 Jun 2026 22:26:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH rc] iommu/dma: Do not try to iommu_map a 0 length region
 in swiotlb
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, "Joerg Roedel
 (AMD)" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon
	<will@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Leon
	Romanovsky <leonro@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Mark
	Lord <mlord@pobox.com>, patches@lists.linux.dev, stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <0-v1-8536728bc89f+469-swiotlb_warn_jgg@nvidia.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260609202623eucas1p2c778d0a0de063740109d0e23aa94be57
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260608181015eucas1p241dfd8c16072125dc760072a080d4cd2
X-EPHeader: CA
X-CMS-RootMailID: 20260608181015eucas1p241dfd8c16072125dc760072a080d4cd2
References: <CGME20260608181015eucas1p241dfd8c16072125dc760072a080d4cd2@eucas1p2.samsung.com>
	<0-v1-8536728bc89f+469-swiotlb_warn_jgg@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:iommu@lists.linux.dev,m:joro@8bytes.org,m:robin.murphy@arm.com,m:will@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:leonro@nvidia.com,m:mcgrof@kernel.org,m:mlord@pobox.com,m:patches@lists.linux.dev,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[m.szyprowski@samsung.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262380-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.szyprowski@samsung.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,samsung.com:dkim,samsung.com:mid,samsung.com:from_mime,pobox.com:email,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 160DD664154

On 08.06.2026 20:10, Jason Gunthorpe wrote:
> iommu_dma_iova_link_swiotlb() processes a mapping that is unaligned in three
> parts, the head, middle and trailer. If the middle is empty because there
> are no aligned pages it will call down to iommu_map() with a 0 size
> which the iommupt implementation will fail as illegal.
>
> It then tries to do an error unwind and starts from the wrong spot
> corrupting the mapping so the eventual destruction triggers a WARN_ON.
>
> Check for 0 length and avoid mapping and use offset not 0 as the starting
> point to unlink.
>
> This is frequently triggered by using some kinds of thunderbolt NVMe
> drives that trigger forced SWIOTLB for unaligned memory. NVMe seems to
> pass in oddly aligned buffers for the passthrough commands from smartctl
> that hit this condition.
>
> Cc: stable@vger.kernel.org
> Fixes: 433a76207dcf ("dma-mapping: Implement link/unlink ranges API")
> Reported-by: Mark Lord <mlord@pobox.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Applied to dma-mapping-fixes, thanks!


> ---
>  drivers/iommu/dma-iommu.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> This was discovered because iommupt errors on mapping length=0 instead of
> making it a NOP, so it is an became an issue since commit d6c65b0fd621
> ("iommupt: Avoid rewalking during map") making it a regression this merge
> window.
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 54d96e847f161b..381b60d9e7ceaf 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1918,12 +1918,18 @@ static int iommu_dma_iova_link_swiotlb(struct device *dev,
>  			return 0;
>  	}
>  
> +	/*
> +	 * After removing the partial head and tail, there may be no aligned
> +	 * middle left to map.  The tail still gets bounced below.
> +	 */
>  	size -= iova_end_pad;
> -	error = __dma_iova_link(dev, addr + mapped, phys + mapped, size, dir,
> -			attrs);
> -	if (error)
> -		goto out_unmap;
> -	mapped += size;
> +	if (size) {
> +		error = __dma_iova_link(dev, addr + mapped, phys + mapped,
> +				size, dir, attrs);
> +		if (error)
> +			goto out_unmap;
> +		mapped += size;
> +	}
>  
>  	if (iova_end_pad) {
>  		error = iommu_dma_iova_bounce_and_link(dev, addr + mapped,
> @@ -1936,7 +1942,8 @@ static int iommu_dma_iova_link_swiotlb(struct device *dev,
>  	return 0;
>  
>  out_unmap:
> -	dma_iova_unlink(dev, state, 0, mapped, dir, attrs);
> +	if (mapped)
> +		dma_iova_unlink(dev, state, offset, mapped, dir, attrs);
>  	return error;
>  }
>  
>
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


