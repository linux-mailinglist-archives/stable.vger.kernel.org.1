Return-Path: <stable+bounces-222872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGSPI9fZpmnHWgAAu9opvQ
	(envelope-from <stable+bounces-222872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 13:53:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 357A11EFBD9
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 13:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C41A302ECB5
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 12:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C516C35E947;
	Tue,  3 Mar 2026 12:53:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851BD35F181
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772542420; cv=none; b=ZSO6IP4V6M+8bRp4gFK3kEgU+57Ldx+OrXJXE3CpCaloQsVtncDlM2b/icdFj3hN+BqBgRZdV7k8iaVPq0Y0NZFkw73DAVDYRUzfjM9jAYAnvpKR1NyTG4cB+vdAWC1QpJjW0wESvcd/WgAVYHITgp5jkjXYWxJzTUBv18BnJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772542420; c=relaxed/simple;
	bh=3VZUa3Z3I4IvtbEVs+gHsiaoPffVUCSkCeCxStE5bd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgGYs/4pk2KiGgFwgshiiMy1kz3kpw0J6KsdYYdmaiH0+CJGVMsByJGPgQrH9o7lPdXSfL4Z3DxgYFAYodKQH2KRtaO4hMr9Ih9hUWES6UEdW1lZWjCL67kUurFpYJu8RkDq4H2rEZFgxxIjRe7BHqy0ZOdzZkP3iy7XYx4DHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 883E1497;
	Tue,  3 Mar 2026 04:53:30 -0800 (PST)
Received: from [10.57.56.165] (unknown [10.57.56.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C67CF3F7BD;
	Tue,  3 Mar 2026 04:53:34 -0800 (PST)
Message-ID: <13e28ac2-a4d6-466a-aef2-7b3d7d9167bd@arm.com>
Date: Tue, 3 Mar 2026 12:53:28 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc 1/2] iommu: Do not call drivers for empty gathers
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Joerg Roedel <joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
 Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org
References: <1-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <1-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 357A11EFBD9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222872-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.869];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,nvidia.com:email]
X-Rspamd-Action: no action

On 2026-03-02 10:22 pm, Jason Gunthorpe wrote:
> An empty gather is coded with start=U64_MAX, end=0 and several drivers go
> on to convert that to a size with:
> 
>   end - start + 1
> 
> Which gives 2 for an empty gather. This then causes Weird Stuff to
> happen (for example an UBSAN splat in VT-d) that is hopefully harmless,
> but maybe not.
> 
> Prevent drivers from being called right in iommu_iotlb_sync().
> 
> Auditing shows that AMD, Intel, Mediatek and RSIC-V drivers all do things
> on these empty gathers.
> 
> Further, there are several callers that can trigger empty gathers,
> especially in unusual conditions. For example iommu_map_nosync() will call
> a 0 size unmap on some error paths. Also in VFIO, iommupt and other
> places.

My instinct is still to tidy up the 0-length unmap case(s), but I guess 
iommu_iotlb_sync() is itself also a public API where being more robust 
against erroneous usage is no bad thing. With one minor nit below,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: stable@vger.kernel.org
> Reported-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> Closes: https://lore.kernel.org/r/11145826.aFP6jjVeTY@jkrzyszt-mobl2.ger.corp.intel.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   include/linux/iommu.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 54b8b48c762e88..555597b54083cd 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -980,7 +980,8 @@ static inline void iommu_flush_iotlb_all(struct iommu_domain *domain)
>   static inline void iommu_iotlb_sync(struct iommu_domain *domain,
>   				  struct iommu_iotlb_gather *iotlb_gather)
>   {
> -	if (domain->ops->iotlb_sync)
> +	if (domain->ops->iotlb_sync &&
> +	    likely(iotlb_gather->start < iotlb_gather->end))

Elsewhere we just use "gather->end != 0" as the "non-empty" condition; 
how concerned are we about defending against more-intentionally 
malformed gathers here?

Thanks,
Robin.

>   		domain->ops->iotlb_sync(domain, iotlb_gather);
>   
>   	iommu_iotlb_gather_init(iotlb_gather);


