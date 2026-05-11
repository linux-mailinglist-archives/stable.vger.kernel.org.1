Return-Path: <stable+bounces-245256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOEWFbz6AWrjmwEAu9opvQ
	(envelope-from <stable+bounces-245256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:50:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ADD5118DD
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5388330CED5F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCEC361DB4;
	Mon, 11 May 2026 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QkFh16PN"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0BC40242C;
	Mon, 11 May 2026 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513552; cv=none; b=fWPc7eaBejJyupw354Yf9JyMDZSxWmUHCDGamxmULZxs0BIunDtAz1rckWsf+Kx01ytYAskjp69lFdKFVAlbxtp4eaFzCRB/0QJLcunjnGp33Git/RZccHGAVJuHiC/6Rs9pGa0m/bJS8d8FrzdSQlS+QzFrNs49zxxSuVVR3lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513552; c=relaxed/simple;
	bh=pl8wdqR3J5owQqTKJ9ZiLHKTq5azhHmOEVq9Hfx8phU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iib1ZsS4ttyi4jBNaR8QKKfSdkUEIjzUqW7QvTtmuQ4BOC78Ha3+kHiH/THuBGQ5seFFULhpI01kJjruKEFHmEE+PQXdM8impm15CEDzT2SPiMl6AGqgPoduT8+YAYyaxPStsekb0jiMxbNd0q6N8hVgvu+k+g6XWAJtmAN9cb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QkFh16PN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8591E1477;
	Mon, 11 May 2026 08:32:16 -0700 (PDT)
Received: from [10.57.68.228] (unknown [10.57.68.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBEFD3F836;
	Mon, 11 May 2026 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778513541; bh=pl8wdqR3J5owQqTKJ9ZiLHKTq5azhHmOEVq9Hfx8phU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QkFh16PN2DwDTUj8DhF9YhnLssbOgxSEG2xB+tC8zrFs8TU+3XNmB8Lzhjue6Rrx6
	 tkxm7y7/FhsZyHLvSVwMHrhFb2ZK3RUlOgrft8u/55dOIYtOFrPOg8+OEdILPOAS5j
	 nVwX6YZoBRJ+GKSNpCieHVOx+h4+Y18Lf/5aU2fg=
Message-ID: <98ccdefe-fe16-41fd-9267-00e0a1fe993f@arm.com>
Date: Mon, 11 May 2026 16:32:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-mapping: move dma_map_resource() sanity check into
 debug code
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>, m.szyprowski@samsung.com
Cc: leon@kernel.org, kbusch@kernel.org, jgg@ziepe.ca, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260511083133.1096171-1-jianpeng.chang.cn@windriver.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260511083133.1096171-1-jianpeng.chang.cn@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 67ADD5118DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245256-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:email,arm.com:mid,arm.com:dkim]
X-Rspamd-Action: no action

On 2026-05-11 9:31 am, Jianpeng Chang wrote:
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
>    - move check to debug_dma_map_phys and replace pfn_valid() with
>      pfn_valid() && !PageReserved() as Robin suggested.
>    - update commit message to explain why PageReserved is safe for
>      ZONE_DEVICE PCI_P2PDMA pages
> v1: https://lore.kernel.org/all/20260507032120.4072283-1-jianpeng.chang.cn@windriver.com/
>   kernel/dma/debug.c   | 9 +++++++++
>   kernel/dma/mapping.c | 4 ----
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 1a725edbbbf6..180aa2c930b5 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -1239,6 +1239,15 @@ void debug_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
>   	if (dma_mapping_error(dev, dma_addr))
>   		return;
>   
> +	if (attrs & DMA_ATTR_MMIO) {
> +		unsigned long pfn = PHYS_PFN(phys);
> +
> +		WARN_ONCE(pfn_valid(pfn) && !PageReserved(pfn_to_page(pfn)),
> +			  "dma_map_resource called for RAM address %pa\n",
> +			  &phys);
> +		return;
> +	}

This wants to pair with the existing !MMIO checks slightly further down 
- since we're no longer aborting the map request itself, if we bail out 
early without actually creating the debug entry, we'll end up firing 
another spurious warning if the caller (correctly) unmaps the address. 
Then we can also finish the job of turning it into a proper dma-debug 
check by using err_printk() instead of the open-coded WARN(), so that 
it's subject to filtering etc. as well.

With that fixed,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +
>   	entry = dma_entry_alloc();
>   	if (!entry)
>   		return;
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 23ed8eb9233e..e6b07f160d20 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -365,10 +365,6 @@ EXPORT_SYMBOL(dma_unmap_sg_attrs);
>   dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	if (IS_ENABLED(CONFIG_DMA_API_DEBUG) &&
> -	    WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
> -		return DMA_MAPPING_ERROR;
> -
>   	return dma_map_phys(dev, phys_addr, size, dir, attrs | DMA_ATTR_MMIO);
>   }
>   EXPORT_SYMBOL(dma_map_resource);


