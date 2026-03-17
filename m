Return-Path: <stable+bounces-226027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GFHN3xmuWkyDgIAu9opvQ
	(envelope-from <stable+bounces-226027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:34:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A34C2AC0D2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD6AC3271826
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2996D3E6DF0;
	Tue, 17 Mar 2026 14:14:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03573E51CC;
	Tue, 17 Mar 2026 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756888; cv=none; b=fFP8w48U5WtWGnuBlCG1Ar4Q503WhnvQIxPDxrjqGo94JI9bt5WvuI01+NYk3qYH0KS3WuAUnxEOUAwwAee3kPw7uBX6Dp1Vc+aDDdi/s2f/SY8XL5p4t442JZtj4lBYRvFueHHpdyA3DilaZ9i0JEQ781S1BPJzBoi3TyQ8fcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756888; c=relaxed/simple;
	bh=OKTp1QyVXcviM3oKpHDTri0OhGFwa3TJAL6g6lpU+BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCrzfrpiJzlVCM7Ga0OIAvrckw+KHHMOYOFGDmmqtuCxCbhAmG0Nb2sdZjEUmv9varhBcV5B/nodEx7fKfwXubBsI1fJZBRBhcRJ8d4PC5VSnuRK8i1FQC7gJicTfSa/BIi6Qjr2F6vPc7WhFzIhft91PXKBt+GACF+3n3LduHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7AD9368BEB; Tue, 17 Mar 2026 15:14:42 +0100 (CET)
Date: Tue, 17 Mar 2026 15:14:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, robin.murphy@arm.com,
	martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com,
	john.g.garry@oracle.com, ahuang12@lenovo.com, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, ionut_n2001@yahoo.com,
	sunlightlinux@gmail.com
Subject: Re: [PATCH v1 2/2] nvme-pci: handle dma_opt_mapping_size()
 returning 0
Message-ID: <20260317141442.GA3539@lst.de>
References: <20260316203956.64515-1-ionut.nechita@windriver.com> <20260316203956.64515-3-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316203956.64515-3-ionut.nechita@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226027-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[samsung.com,kernel.org,kernel.dk,lst.de,grimberg.me,arm.com,oracle.com,opensource.wdc.com,lenovo.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,yahoo.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.941];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,windriver.com:email]
X-Rspamd-Queue-Id: 8A34C2AC0D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 10:39:56PM +0200, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> After the previous commit, dma_opt_mapping_size() returns 0 when no DMA
> backend provides an optimal mapping size hint (e.g. IOMMU in passthrough
> mode with no ops->opt_mapping_size callback).
> 
> The NVMe PCI driver used min_t(u32, NVME_MAX_BYTES >> SECTOR_SHIFT,
> dma_opt_mapping_size() >> 9) to cap max_hw_sectors.  With a 0 return
> value this would set max_hw_sectors to 0, which is invalid.

... which means that if you want to change it, you need to combine
both patches into one to not create a regression.


