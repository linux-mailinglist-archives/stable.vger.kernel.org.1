Return-Path: <stable+bounces-225794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCxqBNMjuWm1sQEAu9opvQ
	(envelope-from <stable+bounces-225794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:50:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F82A739F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DA1430882DC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86286371CE2;
	Tue, 17 Mar 2026 09:43:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE91A355026;
	Tue, 17 Mar 2026 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740634; cv=none; b=rLrwFP0GbzHds8MzN6J1HW95q9OJV4uRo4mWzXI8sp3hyPsMi/SIeQ0Bf5hvUlrUaMQ1KT21Qp1CH0m4b9Qau/KZpG8EbA1OYnyzIfbPobdkYcZdv7yxT0e317LRiZOBNBjQe6UF7O6VHrB1UHg2bB8aZZ4UZFp3XyPNaX334Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740634; c=relaxed/simple;
	bh=Qn5AVh3tqcu7iFHj24GKranHlBGlypwdEnqBioGvC2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVSV0mf2a6OkE78JUEGCBvAcPZpEDpXj+OSU3PppBF8e+PXssUkA1JB4dwxrsF6+L0QjQOnpH63Y95UzgjWnWcsqtiKPip0sfrOa3BBNEN9dfa/3ERgf+Ee4Shfs0yXMRdhpjL2jAr1wRGnh4tqCiCP5LZqu/RIE0dwDYYrtNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21CA71476;
	Tue, 17 Mar 2026 02:43:46 -0700 (PDT)
Received: from [10.57.60.199] (unknown [10.57.60.199])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EAB33F778;
	Tue, 17 Mar 2026 02:43:49 -0700 (PDT)
Message-ID: <d2e0fe45-31ae-4879-951e-7d0494d764e4@arm.com>
Date: Tue, 17 Mar 2026 09:43:46 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dma: return 0 from dma_opt_mapping_size() when no
 real hint exists
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me
Cc: martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com,
 john.g.garry@oracle.com, ahuang12@lenovo.com, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com
References: <20260316203956.64515-1-ionut.nechita@windriver.com>
 <20260316203956.64515-2-ionut.nechita@windriver.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260316203956.64515-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,opensource.wdc.com,lenovo.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,yahoo.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-225794-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.925];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:mid]
X-Rspamd-Queue-Id: 884F82A739F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-16 8:39 pm, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> dma_opt_mapping_size() currently initializes its local size to SIZE_MAX
> and, when neither an IOMMU nor a DMA ops opt_mapping_size callback is
> present, returns min(dma_max_mapping_size(dev), SIZE_MAX).  That value
> is a large but finite number that has nothing to do with an optimal
> transfer size — it is simply the maximum the DMA layer can map.

No, the current code is correct. dma_opt_mapping_size() represents the 
largest size that can be mapped without incurring any significant 
performance penalty (compared to smaller sizes). If the implementation 
has no such restriction, then the largest "efficient" size is quite 
obviously just the largest size in total.

> Callers such as scsi_transport_sas treat the return value as a genuine
> optimization hint and propagate it into Scsi_Host.opt_sectors, which in
> turn becomes the block device's optimal_io_size.  On SAS controllers
> like mpt3sas running with IOMMU in passthrough mode the bogus value
> (max_sectors << 9 = 16776704, rounded to 16773120) reaches mkfs.xfs,
> which computes swidth=4095 and sunit=2.  Because 4095 is not a multiple
> of 2, XFS rejects the geometry with "SB stripe unit sanity check
> failed", making it impossible to create filesystems during system
> bootstrap.

And that is obviously a bug. There has never been any guarantee offered 
about the values returned by either dma_max_mapping_size() or 
dma_opt_mapping_size() - they could be very large, very small, and 
certainly do not have to be powers of 2. Say an implementation has some 
internal data size optimisation that makes U32_MAX its largest 
"efficient" size, it's free to return that, and then you'll still have 
the same bug regardless of this bodge.

Fix the actual bug, don't break common code in an attempt to paper over 
it that doesn't even achieve that very well.

Thanks,
Robin.

> Fix this by returning 0 when no backend provides an optimal mapping size
> hint.  A return value of 0 unambiguously means "no preference" and lets
> callers that use min() or min_not_zero() do the right thing without
> special-casing.
> 
> The only other in-tree caller (nvme-pci) is adjusted in the next patch.
> 
> Fixes: a229cc14f339 ("dma-mapping: add dma_opt_mapping_size()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>   kernel/dma/mapping.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 78d8b4039c3e6..fffa6a3f191a3 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -984,14 +984,17 @@ EXPORT_SYMBOL_GPL(dma_max_mapping_size);
>   size_t dma_opt_mapping_size(struct device *dev)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
> -	size_t size = SIZE_MAX;
>   
>   	if (use_dma_iommu(dev))
> -		size = iommu_dma_opt_mapping_size();
> -	else if (ops && ops->opt_mapping_size)
> -		size = ops->opt_mapping_size();
> +		return iommu_dma_opt_mapping_size();
> +	if (ops && ops->opt_mapping_size)
> +		return ops->opt_mapping_size();
>   
> -	return min(dma_max_mapping_size(dev), size);
> +	/*
> +	 * No backend provided an optimal size hint. Return 0 so that
> +	 * callers can distinguish "no hint" from a real value.
> +	 */
> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
>   


