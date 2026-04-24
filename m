Return-Path: <stable+bounces-240660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHjsKFNu62l2MwAAu9opvQ
	(envelope-from <stable+bounces-240660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:21:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 397C945EED4
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FEAB3019531
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CA63B27C7;
	Fri, 24 Apr 2026 13:21:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86FF31E85B;
	Fri, 24 Apr 2026 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777036873; cv=none; b=DU/+NNc6EKUDooUhmp+1OxVMSoROG3+hkhu97O07wappcNVWO9ZSRYZU0+9akyD66okYdFNbITcEo+iciLfYsOG6ogJnvOXt29Ljyb0h4sAuPWTLIOpfjofUKXMzCIAyzp9ndsLYOT3tj1E5+Fv8E3rL6jgE3cyz8R16JVTUQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777036873; c=relaxed/simple;
	bh=9F8VABLsRUEphPoeAAeRlFvMhIld3nJ5fx8YvmC3grw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zaf0ov677H6g5or6QQBShK+Bo/7pNwQTIcR5LXtdM6k2CXahZCOKtrQVW2Qf2hFcJPBb4N9EwWy9jdgUsWtvCR3P7FgERXwS+WmjtS+yYFbag6AObOySZaYy4Nasz1Xr5Pfa0J4KrE9VLqSwnHbEFmi4NxRNemfcGbvixxcMkgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5B7E568C4E; Fri, 24 Apr 2026 15:21:00 +0200 (CEST)
Date: Fri, 24 Apr 2026 15:21:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, hch@lst.de, dlemoal@kernel.org,
	robin.murphy@arm.com, john.g.garry@oracle.com, axboe@kernel.dk,
	m.szyprowski@samsung.com, ahuang12@lenovo.com,
	ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: Re: [PATCH v7 1/1] scsi: sas: skip opt_sectors when DMA reports no
 real optimization hint
Message-ID: <20260424132100.GA15553@lst.de>
References: <20260415071849.25693-1-ionut.nechita@windriver.com> <20260415071849.25693-2-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415071849.25693-2-ionut.nechita@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Queue-Id: 397C945EED4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240660-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[HansenPartnership.com,oracle.com,vger.kernel.org,lst.de,kernel.org,arm.com,kernel.dk,samsung.com,lenovo.com,yahoo.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 15, 2026 at 10:18:49AM +0300, Ionut Nechita (Wind River) wrote:
> +/*
> + * Set shost->opt_sectors from the DMA optimal mapping size, but only
> + * when dma_opt_mapping_size() is strictly less than dma_max_mapping_size(),
> + * indicating a genuine optimization hint from an IOMMU or DMA backend.
> + * When the two are equal (e.g. IOMMU disabled / passthrough), no real
> + * hint exists, so leave opt_sectors at 0 to avoid bogus optimal_io_size
> + * values that break filesystem geometry (e.g. mkfs.xfs stripe alignment).
> + */
> +static void sas_dma_setup_opt_sectors(struct Scsi_Host *shost)
> +{
> +	struct device *dma_dev = shost->dma_dev;
> +	size_t opt, max;
> +	unsigned int opt_sectors;
> +
> +	if (!dma_dev->dma_mask)
> +		return;

Upper layers have no real busines looking at dma_dev->dma_mask. What
is this check intended to do?

> +
> +	opt = dma_opt_mapping_size(dma_dev);
> +	max = dma_max_mapping_size(dma_dev);
> +
> +	if (opt >= max)
> +		return;
> +
> +	opt_sectors = min_t(unsigned int, opt >> SECTOR_SHIFT,
> +			    shost->max_sectors);
> +	if (!opt_sectors)
> +		return;
> +
> +	shost->opt_sectors = rounddown_pow_of_two(opt_sectors);

Please add comments explaining the logic.


