Return-Path: <stable+bounces-244569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBnOOAWS/Gn3RQAAu9opvQ
	(envelope-from <stable+bounces-244569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 15:22:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 639144E92A0
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 15:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFFCE3052CB3
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 13:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E753F20F4;
	Thu,  7 May 2026 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KZCvQnR2"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D0A3F1660;
	Thu,  7 May 2026 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159889; cv=none; b=UTGFTrgUVHD99zQpS8eyklESq4mRBzlnu/5mKbQeghXWAcw6kZ20IV+TbwmTX4lDU7P4O+3Aw3mNpvJQcej+GlJ3gx6oHhoZj51EdOrspK77+2o8NHgW2w6Yd3JARwWKvXp6D1mFIk8ffjiExs5HzC0WLfnOHflSniSkokThhKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159889; c=relaxed/simple;
	bh=bSPF52eNifvCAHZxfZvtkKjG0swEVvBNGQH1Scuf1Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyTUxoeQYU18SQnZd24WXJT0u9eQL7VaSZC5qtiE+LeOY1ylHI9z8g3dIvwb2Udah5ywEZCW0W71ptOeNck1pfuloVp4zERbKemiKPg09rgpQiAE09eeXBf0nub4tSfdaAoMaZJEPtfwjtrSuSiNgxcIKvwH7gdYXUiu5mQaPc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KZCvQnR2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16F111688;
	Thu,  7 May 2026 06:18:01 -0700 (PDT)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BC1C3F763;
	Thu,  7 May 2026 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778159886; bh=bSPF52eNifvCAHZxfZvtkKjG0swEVvBNGQH1Scuf1Kw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KZCvQnR2+BlMABWo8vx46G/eowjA6P/JPbcz3P9JhFnkZ6hXbEXTUxI85JBnr6oY8
	 ElrYNQmZDy4eOLmYJ5HIIpuQj30tt9OFcYbsmqQV/we26crhbdtCrB+IL8QLoFt7gf
	 LiQ0Y1FlTjnJqOTSpIP7uoqhlQ7s9aIz7tsEhu5o=
Message-ID: <2dcc29d6-a4a9-4fdf-861d-312941ab0f07@arm.com>
Date: Thu, 7 May 2026 14:18:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: remove bogus test for pfn_valid from
 dma_map_resource
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>, m.szyprowski@samsung.com
Cc: leon@kernel.org, kbusch@kernel.org, jgg@ziepe.ca, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260507032120.4072283-1-jianpeng.chang.cn@windriver.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260507032120.4072283-1-jianpeng.chang.cn@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 639144E92A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244569-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:mid,arm.com:dkim]
X-Rspamd-Action: no action

On 07/05/2026 4:21 am, Jianpeng Chang wrote:
> dma_map_resource() uses pfn_valid() to ensure the range is not RAM.
> However, pfn_valid() only checks for availability of the memory map for a
> PFN but it does not ensure that the PFN is actually backed by RAM. On
> ARM64 with SPARSEMEM (128MB section granularity), MMIO addresses that
> share a section with RAM will falsely trigger the WARN_ON_ONCE.
> 
> This causes a WARNING on Raspberry Pi 4 during spi_bcm2835 probe because
> the SPI FIFO register (0xfe204004) falls in the same sparsemem section as
> the end of RAM (0xf8000000-0xfbffffff), both in section 31
> (0xf8000000-0xffffffff).
> 
> The pfn_valid() check was originally removed by commit a9c38c5d267c
> ("dma-mapping: remove bogus test for pfn_valid from dma_map_resource")
> but was accidentally re-introduced by commit f7326196a781
> ("dma-mapping: export new dma_*map_phys() interface") during the
> refactoring of dma_map_resource() into a wrapper around dma_map_phys().
> 
> Drop the pfn_valid() test from dma_map_resource() again.

As I said last time, I think pfn_valid() && !PageReserved(pfn_to_page()) 
would be enough for what we want here, although now it's strictly under 
CONFIG_DMA_API_DEBUG, perhaps the overhead of memblock_is_map_memory() 
might be less of an issue. Either way though, now that it's all 
channelled through the single dma_map_phys() path, it would probably 
make sense to consolidate any MMIO sanity-checking into 
dma_debug_map_phys() anyway :/

Thanks,
Robin.

> Fixes: f7326196a781 ("dma-mapping: export new dma_*map_phys() interface")
> Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
> ---
> Hi,
> 
> I found the WARNING in dma_map_resource() on Raspberry Pi 4 when using the
> downstream kernel from https://github.com/raspberrypi/linux, which calls
> dma_map_resource() in bcm2835-dma.c (mainline uses the physical address
> directly instead).
> 
> Although mainline bcm2835-dma does not call dma_map_resource(), the bogus
> pfn_valid() check can still affect any other driver that does, so it
> should be removed again.
> 
> Thanks,
> Jianpeng
> 
>   kernel/dma/mapping.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
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


