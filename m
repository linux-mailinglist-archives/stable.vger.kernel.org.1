Return-Path: <stable+bounces-226029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHojANJmuWkyDgIAu9opvQ
	(envelope-from <stable+bounces-226029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:36:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CA82AC151
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2EE330A5407
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86D6344040;
	Tue, 17 Mar 2026 14:19:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAB92BD012;
	Tue, 17 Mar 2026 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757182; cv=none; b=Me/imsT0ONi4XahrCtkVTVsFqUAefAo5zqV8X0mHZnd2kdIt18rgnYlmWxBMwvFOp5WIWXWYH+8XKlAEkiG2culsSY+63hEzMV1UUgF0VEmUu2A1FQWruVg/3Oo0HBBbLkur/jlatgE7lOLNRJYd53H/z5Ni0XovG2ZI2P1ZjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757182; c=relaxed/simple;
	bh=sI4XKLetPRXqS4BZIU2B9A3ej0kaiCi0AERHYLRq34M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QcWUux6f2w1N4e6BvSFZkN1LB8S+te9txW9verxbnw991Utbx+UZEPBelkVUE4l4Rxht/ujcpCcIMbBZzXdxYsBTLrmlqinx4qZSM8vd0ijTPlx292/XDXtVyI3Kwg0/zy6c4PHqz6HFj5pCdUwgDoME4ovYVXr5FGKxMIWp1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 69E1968BEB; Tue, 17 Mar 2026 15:19:35 +0100 (CET)
Date: Tue, 17 Mar 2026 15:19:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
	m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, martin.petersen@oracle.com,
	damien.lemoal@opensource.wdc.com, john.g.garry@oracle.com,
	ahuang12@lenovo.com, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, ionut_n2001@yahoo.com,
	sunlightlinux@gmail.com
Subject: Re: [PATCH v1 1/2] dma: return 0 from dma_opt_mapping_size() when
 no real hint exists
Message-ID: <20260317141935.GB3539@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2e0fe45-31ae-4879-951e-7d0494d764e4@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226029-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[windriver.com,samsung.com,kernel.org,kernel.dk,grimberg.me,oracle.com,opensource.wdc.com,lenovo.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,yahoo.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.904];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,windriver.com:email]
X-Rspamd-Queue-Id: 56CA82AC151
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 09:43:46AM +0000, Robin Murphy wrote:
> On 2026-03-16 8:39 pm, Ionut Nechita (Wind River) wrote:
>> From: Ionut Nechita <ionut.nechita@windriver.com>
>>
>> dma_opt_mapping_size() currently initializes its local size to SIZE_MAX
>> and, when neither an IOMMU nor a DMA ops opt_mapping_size callback is
>> present, returns min(dma_max_mapping_size(dev), SIZE_MAX).  That value
>> is a large but finite number that has nothing to do with an optimal
>> transfer size — it is simply the maximum the DMA layer can map.
>
> No, the current code is correct. dma_opt_mapping_size() represents the 
> largest size that can be mapped without incurring any significant 
> performance penalty (compared to smaller sizes). If the implementation has 
> no such restriction, then the largest "efficient" size is quite obviously 
> just the largest size in total.

Yes.

>> Callers such as scsi_transport_sas treat the return value as a genuine
>> optimization hint and propagate it into Scsi_Host.opt_sectors, which in
>> turn becomes the block device's optimal_io_size.  On SAS controllers
>> like mpt3sas running with IOMMU in passthrough mode the bogus value
>> (max_sectors << 9 = 16776704, rounded to 16773120) reaches mkfs.xfs,
>> which computes swidth=4095 and sunit=2.  Because 4095 is not a multiple
>> of 2, XFS rejects the geometry with "SB stripe unit sanity check
>> failed", making it impossible to create filesystems during system
>> bootstrap.
>
> And that is obviously a bug. There has never been any guarantee offered 
> about the values returned by either dma_max_mapping_size() or 
> dma_opt_mapping_size() - they could be very large, very small, and 
> certainly do not have to be powers of 2. Say an implementation has some 
> internal data size optimisation that makes U32_MAX its largest "efficient" 
> size, it's free to return that, and then you'll still have the same bug 
> regardless of this bodge.

Yes, the SCSI/SAS code needs to properly round the value.

But we might also need to split the values up a bit, as tools just
assign too much value to the I/O opt value.  I.e. the file system
geometry really should not be affected by the IOMMU details.
>
> Fix the actual bug, don't break common code in an attempt to paper over it 
> that doesn't even achieve that very well.
>
> Thanks,
> Robin.
>
>> Fix this by returning 0 when no backend provides an optimal mapping size
>> hint.  A return value of 0 unambiguously means "no preference" and lets
>> callers that use min() or min_not_zero() do the right thing without
>> special-casing.
>>
>> The only other in-tree caller (nvme-pci) is adjusted in the next patch.
>>
>> Fixes: a229cc14f339 ("dma-mapping: add dma_opt_mapping_size()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
>> ---
>>   kernel/dma/mapping.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>> index 78d8b4039c3e6..fffa6a3f191a3 100644
>> --- a/kernel/dma/mapping.c
>> +++ b/kernel/dma/mapping.c
>> @@ -984,14 +984,17 @@ EXPORT_SYMBOL_GPL(dma_max_mapping_size);
>>   size_t dma_opt_mapping_size(struct device *dev)
>>   {
>>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>> -	size_t size = SIZE_MAX;
>>     	if (use_dma_iommu(dev))
>> -		size = iommu_dma_opt_mapping_size();
>> -	else if (ops && ops->opt_mapping_size)
>> -		size = ops->opt_mapping_size();
>> +		return iommu_dma_opt_mapping_size();
>> +	if (ops && ops->opt_mapping_size)
>> +		return ops->opt_mapping_size();
>>   -	return min(dma_max_mapping_size(dev), size);
>> +	/*
>> +	 * No backend provided an optimal size hint. Return 0 so that
>> +	 * callers can distinguish "no hint" from a real value.
>> +	 */
>> +	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
>>   
---end quoted text---

