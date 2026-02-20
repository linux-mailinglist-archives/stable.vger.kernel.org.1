Return-Path: <stable+bounces-217557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAIYEL84mGkSDQMAu9opvQ
	(envelope-from <stable+bounces-217557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:34:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB48166D9A
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEF96302DE0D
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 10:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DAF33D6FE;
	Fri, 20 Feb 2026 10:34:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47E2322A1F;
	Fri, 20 Feb 2026 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583673; cv=none; b=pxmU09CUvS6ywXOL/2Qc3tR1aqFKpc5Lyt1b0tuvH3C/bZLijc+Yud8Avnj36qYogwOSU/Yy2ZD7EwExrgNS8zk0MhQz+Gqt5Y74hKlXc0C1oHef2M4nq1JNWDFUTCpNqzmJKrQXowtrbBYGewgubA7J9Ltudj84H1YvEIK3aLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583673; c=relaxed/simple;
	bh=e5mOC5kRmE4+CirNn2OSeEpsuTHS7QzHY5b2INi7QLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtIIMub6dw5iuhj6WCQeUGBylGw8HwHFGre3UbasfL90+WfplC46/7z/ol3tCwRMUW6jDNnx42cMbb0B/NLEuu7WV8lV9hLPa3BXuT1juCRS7BGluaKhilwD5oYNwSZvcCKlZuWI/LDhAobIO9iJHNQYJ2bxnSsz2S7wQc6bQ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE8F5339;
	Fri, 20 Feb 2026 02:34:24 -0800 (PST)
Received: from [10.57.58.244] (unknown [10.57.58.244])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F37093F62B;
	Fri, 20 Feb 2026 02:34:28 -0800 (PST)
Message-ID: <555e100a-b995-47c1-b616-275d2e3b0946@arm.com>
Date: Fri, 20 Feb 2026 10:34:11 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/vt-d: Avoid superfluous IOTLB tracking in lazy
 mode
To: Ferdinand Schober <ferdinand.schober@fau.de>, linux-kernel@vger.kernel.org
Cc: ashok.raj@intel.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
 sanjay.k.kumar@intel.com, stable@vger.kernel.org, will@kernel.org,
 yi.l.liu@intel.com
References: <20230209175330.1783556-1-jacob.jun.pan@linux.intel.com>
 <20260220015239.375598-1-ferdinand.schober@fau.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260220015239.375598-1-ferdinand.schober@fau.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217557-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.962];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFB48166D9A
X-Rspamd-Action: no action

On 2026-02-20 1:52 am, Ferdinand Schober wrote:
> 
> Hi,
> 
> I've stumbled upon this patch trying to figure out how lazy invalidation is implemented in intel IOMMUs.
> The patch suggests that lazy invalidation is active whenever iotlb_gather.queued is set.
> 
> However, the only place in which gather.queued is written seems to be in dma-iommu.c:
> 
> -- drivers/iommu/dma-iommu.c
>   820:	iotlb_gather.queued = READ_ONCE(cookie->fq_domain);
> 2038:	iotlb_gather.queued = free_iova && READ_ONCE(cookie->fq_domain);
> 
> 
> Both of these depend on fq_domain but fq_domain is always NULL for intel iommus,
> since iommu/intel/iommu.c reports IOMMU_CAP_DEFERRED_FLUSH:
> 
> -- drivers/iommu/dma-iommu.c:708
> 	if (domain->type == IOMMU_DOMAIN_DMA_FQ &&
> 	    (!device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH) || iommu_dma_init_fq(domain)))
> 		domain->type = IOMMU_DOMAIN_DMA;
> 
> 
> (Above line numbers are from Kernel 6.17).
> 
> So I'm not sure, this commit does what it should?
> Please let me know what I'm missing here.

IOMMU_CAP_DEFERRED_FLUSH *is* the "I can usefully support flush queues" 
capability; if that is reported then iommu_dma_init_fq() is called, and 
if that succeeds then fq_domain will have been set. If it fails, or if 
the IOMMU doesn't support flush queues in the first place, then we fall 
back to the regular strict domain type.

Thanks,
Robin.

> 
> Best Regards,
> Ferdinand Schober
> 
> 
> 
> 


