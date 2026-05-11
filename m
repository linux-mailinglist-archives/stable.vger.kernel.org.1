Return-Path: <stable+bounces-245314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCl0GJwYAmognwEAu9opvQ
	(envelope-from <stable+bounces-245314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:57:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C257A513EE9
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4D543018FB5
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E7946AECC;
	Mon, 11 May 2026 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ju5nl9OE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256A36D9F8;
	Mon, 11 May 2026 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522208; cv=none; b=AcdN+chxQuFlHL/j1+VdTRvq2lQLTxbWP3UbMREkRY40zm872Nmkk6NouPtFbOcMsl73VUauS3Mkko7aEtpw1KIJ8g6L687nRVPxO/7s83aOb2Ez0khIuRL4e/cq7+UHFoH5RJEnyGyaUqM+UzoDAsPN9GZwPORVFeIhDZnHcM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522208; c=relaxed/simple;
	bh=wWPR3Z3pINbn3KtsYC+19U2lza/TgQV1Wvb7U7l2jmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7OeOaPrlHTIDdXz0l3m8I1ZyVd3HGFCefP981b/KsnZr27OUij3XC29A0KaKI+A2kz58b7OnrTs7nR+AqA8zsWONYq0k1Koy4tKprF/l3dEUiyJC6lkQn7wVKgO5W7fLVP0cpcVaX9t6FFKUsRCjBHFMVfaxrRqsCXvSK7XOOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ju5nl9OE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B3CC2BCF5;
	Mon, 11 May 2026 17:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778522207;
	bh=wWPR3Z3pINbn3KtsYC+19U2lza/TgQV1Wvb7U7l2jmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ju5nl9OETjvrFQmOEPGPKlDirxEP18xoxFYafD21aUX0IT3KSmhitqE4dTjsk0Jbd
	 uzUPkPWKF+qD7pvydhtFjOttblywKU/+fc5zcKUt25DUKAyyvoB8WAP4t5L7DAv7oY
	 pfmCIVYTo6Elh6m8n20HB2QnUfVgWKVr59A8SQY45IoDlb7cATRhgaI1C9NKzl34NN
	 eOS0a+4mJ94Q7FO77OSpuFVDuQo1W/b/3aJORsVaE7CaYOEVYO1KpBOfSydU+yHlZD
	 rxK7t0g9YCSkhm9/VC0/sE5pCl8GOcVrn7fGh4TWiQJ+I+B25/7JxC4CNJPjEXh9H6
	 FXSOGS489jxyg==
Date: Mon, 11 May 2026 20:56:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, kbusch@kernel.org,
	jgg@ziepe.ca, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-mapping: move dma_map_resource() sanity check
 into debug code
Message-ID: <20260511175641.GL15586@unreal>
References: <20260511083133.1096171-1-jianpeng.chang.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511083133.1096171-1-jianpeng.chang.cn@windriver.com>
X-Rspamd-Queue-Id: C257A513EE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245314-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,windriver.com:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 04:31:33PM +0800, Jianpeng Chang wrote:
> dma_map_resource() uses pfn_valid() to ensure the range is not RAM.
> However, pfn_valid() only checks for availability of the memory map for
> a PFN but it does not ensure that the PFN is actually backed by RAM. On
> ARM64 with SPARSEMEM (128MB section granularity), MMIO addresses that
> share a section with RAM will falsely trigger the WARN_ON_ONCE and cause
> dma_map_resource() to return DMA_MAPPING_ERROR.
> 
> This causes a WARNING on Raspberry Pi 4 during spi_bcm2835 probe because
> the SPI FIFO register (0xfe204004) falls in the same sparsemem section
> as the end of RAM (0xf8000000-0xfbffffff), both in section 31
> (0xf8000000-0xffffffff).
> 
> Move the sanity check from dma_map_resource() into debug_dma_map_phys()
> and replace the unreliable pfn_valid() with pfn_valid() &&
> !PageReserved(), which correctly identifies actual usable RAM without
> false positives for MMIO regions that happen to have struct pages.
> 
> Since dma_map_resource() is dma_map_phys(DMA_ATTR_MMIO), the check
> applies equally to both APIs. Any non-reserved page represents kernel
> memory to a sufficient degree that using DMA_ATTR_MMIO on it is almost
> certainly wrong and risks breaking coherency on non-coherent platforms.
> ZONE_DEVICE pages used for PCI P2P DMA (MEMORY_DEVICE_PCI_P2PDMA) have
> PageReserved set, so they will not trigger a false positive.
> 
> The check is now a WARN_ONCE that no longer blocks the mapping, since
> being unobtrusive is more important than being exhaustive for what is
> merely a debug sanity check.
> 
> Fixes: f7326196a781 ("dma-mapping: export new dma_*map_phys() interface")
> Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
> ---
> v2:
>   - move check to debug_dma_map_phys and replace pfn_valid() with
>     pfn_valid() && !PageReserved() as Robin suggested.
>   - update commit message to explain why PageReserved is safe for
>     ZONE_DEVICE PCI_P2PDMA pages
> v1: https://lore.kernel.org/all/20260507032120.4072283-1-jianpeng.chang.cn@windriver.com/
>  kernel/dma/debug.c   | 9 +++++++++
>  kernel/dma/mapping.c | 4 ----
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 1a725edbbbf6..180aa2c930b5 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -1239,6 +1239,15 @@ void debug_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
>  	if (dma_mapping_error(dev, dma_addr))
>  		return;
>  
> +	if (attrs & DMA_ATTR_MMIO) {
> +		unsigned long pfn = PHYS_PFN(phys);
> +
> +		WARN_ONCE(pfn_valid(pfn) && !PageReserved(pfn_to_page(pfn)),
> +			  "dma_map_resource called for RAM address %pa\n",
> +			  &phys);
> +		return;

I’m not comfortable with this return statement. It effectively disables  
DMA debugging for any caller that uses dma_map_phys(..., DMA_ATTR_MMIO),
like dma-buf, block layer, HMM, e.t.c

Thanks

> +	}
> +
>  	entry = dma_entry_alloc();
>  	if (!entry)
>  		return;
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 23ed8eb9233e..e6b07f160d20 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -365,10 +365,6 @@ EXPORT_SYMBOL(dma_unmap_sg_attrs);
>  dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> -	if (IS_ENABLED(CONFIG_DMA_API_DEBUG) &&
> -	    WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
> -		return DMA_MAPPING_ERROR;
> -
>  	return dma_map_phys(dev, phys_addr, size, dir, attrs | DMA_ATTR_MMIO);
>  }
>  EXPORT_SYMBOL(dma_map_resource);
> -- 
> 2.54.0
> 

