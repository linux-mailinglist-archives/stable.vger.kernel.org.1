Return-Path: <stable+bounces-226987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIuxIvNaumnFUgIAu9opvQ
	(envelope-from <stable+bounces-226987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:57:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0427C2B7570
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9193305D1EE
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6418736D50B;
	Wed, 18 Mar 2026 07:53:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D67D36AB50;
	Wed, 18 Mar 2026 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820388; cv=none; b=l1mtSIYf/YK1LBLPdn5YURlY204B5En1M6iXeqnbmelLzzX+f8p2Lyt69BaveTIW+s6pwgMtvP4JNJ85JatIxYpRVhhNB9PHeHCIXJ/49BaZK+H7gS7CdIB1qwXplKQIid4gfoGGsb4zvbJ+DvnZUVeM8jaA3gmmjhqWrJWbXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820388; c=relaxed/simple;
	bh=oLzettf5PonOTO1iU1zqd+AsezXYJ9jP4V/gzgeO/pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQs/zUcnfaKhyB59a4nPyoEvmDLEM2H2SuHzdQPjjp3iaJZlgEhqFHTz8Mgr38ZXqXAf8ETaakZS5emsdCNm4IXLrfsn1x7NhriI7rP4TNeYio7+DYp0Wk+KMfrF/oK0tBe3LmkZ+VCr4OpDGsqVUnFYIjy96SBMu2CHa/Ei09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 68DD068B05; Wed, 18 Mar 2026 08:53:01 +0100 (CET)
Date: Wed, 18 Mar 2026 08:53:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	ahuang12@lenovo.com, axboe@kernel.dk,
	damien.lemoal@opensource.wdc.com, hch@lst.de, iommu@lists.linux.dev,
	ionut_n2001@yahoo.com, john.g.garry@oracle.com, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, m.szyprowski@samsung.com,
	robin.murphy@arm.com, sagi@grimberg.me, stable@vger.kernel.org,
	sunlightlinux@gmail.com
Subject: Re: [PATCH 1/1] scsi: sas: skip opt_sectors when DMA reports no
 real optimization hint
Message-ID: <20260318075301.GA25589@lst.de>
References: <20260318074314.17372-1-ionut.nechita@windriver.com> <20260318074314.17372-2-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318074314.17372-2-ionut.nechita@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226987-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[HansenPartnership.com,oracle.com,lenovo.com,kernel.dk,opensource.wdc.com,lst.de,lists.linux.dev,yahoo.com,kernel.org,vger.kernel.org,lists.infradead.org,samsung.com,arm.com,grimberg.me,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.921];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: 0427C2B7570
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>  	if (dma_dev->dma_mask) {
> -		shost->opt_sectors = min_t(unsigned int, shost->max_sectors,
> -				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
> +		size_t opt = dma_opt_mapping_size(dma_dev);
> +
> +		/*
> +		 * Only set opt_sectors when the DMA layer reports a
> +		 * genuine optimization constraint.  When opt equals
> +		 * dma_max_mapping_size() no backend provided a real
> +		 * hint — the value is just the DMA maximum, which is
> +		 * not useful as an optimal I/O size and can cause
> +		 * mkfs.xfs to compute invalid stripe geometry.
> +		 */
> +		if (opt < dma_max_mapping_size(dma_dev))
> +			shost->opt_sectors = min_t(unsigned int,
> +					shost->max_sectors,
> +					opt >> SECTOR_SHIFT);

This looks reasonable, but please also round down the opt value
to a power of two when you touch this anyway.

And especially with that this logic is complicated enough that it
warrants a little helper that is clearly split out.

