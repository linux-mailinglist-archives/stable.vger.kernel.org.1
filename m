Return-Path: <stable+bounces-225783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBvEBLIduWmbrQEAu9opvQ
	(envelope-from <stable+bounces-225783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:24:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFAA2A6980
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 994F530AB0ED
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CA435E92C;
	Tue, 17 Mar 2026 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m63nL6my"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F353612F7;
	Tue, 17 Mar 2026 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739101; cv=none; b=kitAtnItiwZRKoKW5b+GgKpB4h6lFDTEfNLNji1PQl5WDq4sUfdTv4GbqUxDf704rM3JgP3ns1IKdVVB9o7gDtrIPIH56p3b0mXsOKhRbUsNmb8cZp7WeV31ctqhnBzqVnBM9kYh5OiLGM9DnTe597dHiRxbKluYp3XIuQxSHi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739101; c=relaxed/simple;
	bh=JVhzWvd+OP5LpWAEDYHeSZI2zKfGYGGpl4KO6DbJDYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIbVrECXAjNKV9xMEFWRUG2uGXtVZ0vgdZPVaLRGujGByQE5kRWloI/yaGuZf9yntiyOqninRxKC0SUcQTeIUKb3VspwBjfF4uDkVVNSQQtza39UhPhBDTzm6vMeux3iwRO6rKDpLAej1LaNE3z+Z6bQxsKj3qYsdTUeW3kcRPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m63nL6my; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D02C4CEF7;
	Tue, 17 Mar 2026 09:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773739101;
	bh=JVhzWvd+OP5LpWAEDYHeSZI2zKfGYGGpl4KO6DbJDYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m63nL6myA1RadTZGhd5ji6GgsTOy8knFD/ysjPgUq6YYd/jGsgu+FCAV7ts0SoeQ4
	 ayzH3nJbPjrASy8NW+UkLWoYQYk8b/a14ZDOhCwZUYjWnjWq9UeNwAMst1p/Z5DtGQ
	 n3sWi3yEiV9P93Vf7VhQDFTQ21wYMm11n+0hYjekbXWprfC4GX4Fuw1QXnPX6fWhxS
	 KlP5gjeprvjh5Xlr95l+PZMeeZ1JxE836OhRgW/Ypf/8bVTBxAaE2aZFp7TRlzV1LN
	 f9ACsw7gl40Hv7QRkGpikizQGMpX7xI45oGSzGNz7KDSRoMBhv+x1aM/jEac7mUPIK
	 RigvVtyaHimGQ==
Message-ID: <861b88b8-ba58-4264-8892-282c39194d68@kernel.org>
Date: Tue, 17 Mar 2026 18:18:17 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] dma: fix dma_opt_mapping_size() returning bogus
 value when no backend hint exists
To: John Garry <john.g.garry@oracle.com>,
 "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me
Cc: robin.murphy@arm.com, martin.petersen@oracle.com,
 damien.lemoal@opensource.wdc.com, ahuang12@lenovo.com,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, ionut_n2001@yahoo.com,
 sunlightlinux@gmail.com
References: <20260316203956.64515-1-ionut.nechita@windriver.com>
 <8b7706a0-41be-44a2-8247-ebbc33fee937@oracle.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <8b7706a0-41be-44a2-8247-ebbc33fee937@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arm.com,oracle.com,opensource.wdc.com,lenovo.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,yahoo.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-225783-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDFAA2A6980
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 18:11, John Garry wrote:
> On 16/03/2026 20:39, Ionut Nechita (Wind River) wrote:
>> dma_opt_mapping_size() currently returns min(dma_max_mapping_size(),
>> SIZE_MAX) when neither an IOMMU nor a DMA ops opt_mapping_size callback
>> is present.  That value is the DMA maximum, not an optimal transfer
>> size, yet callers treat it as a genuine optimization hint.
>>
>> The concrete problem shows up on SAS controllers (e.g. mpt3sas) running
>> with IOMMU in passthrough mode.  The bogus value propagates through
>> scsi_transport_sas into Scsi_Host.opt_sectors and then into the block
>> device's optimal_io_size.  mkfs.xfs picks it up, computes
>> swidth=4095 / sunit=2, and fails with:
>>
>>    XFS: SB stripe unit sanity check failed
>>
>> making it impossible to create filesystems during system bootstrap.
> 
> For SAS controllers, don't we limit shost->opt_sectors at 
> shost->max_sectors, and then in sd_revalidate_disk() this value is 
> ignored as sdkp->opt_xfer_blocks would be smaller, right?
> 
> What value are you seeing for max_sectors and opt_sectors? That mpt3sas 
> driver seems to have many methods to set max_sectors.

And mpi3mr is also very similar.

> 
> Thanks,
> John
> 
>>
>> Patch 1 changes dma_opt_mapping_size() to return 0 ("no preference")
>> when no backend provides a real hint.
>>
>> Patch 2 adjusts the only other in-tree caller (nvme-pci) to handle the
>> new 0 return value, falling back to its existing default instead of
>> setting max_hw_sectors to 0.
>>
>> Note: the scsi_transport_sas caller (the one that triggers the XFS
>> issue) already handles 0 safely.  It passes the return value through
>> min_t() into shost->opt_sectors, which becomes 0; sd.c then feeds that
>> into min_not_zero() when computing io_opt, so a zero opt_sectors is
>> correctly treated as "no preference" and ignored.
>>
>> Based on linux-next (next-20260316).
>>
>> Ionut Nechita (2):
>>    dma: return 0 from dma_opt_mapping_size() when no real hint exists
>>    nvme-pci: handle dma_opt_mapping_size() returning 0
>>
>>   drivers/nvme/host/pci.c | 15 ++++++++++-----
>>   kernel/dma/mapping.c    | 13 ++++++++-----
>>   2 files changed, 18 insertions(+), 10 deletions(-)
>>
> 
> 


-- 
Damien Le Moal
Western Digital Research

