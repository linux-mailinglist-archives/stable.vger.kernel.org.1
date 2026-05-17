Return-Path: <stable+bounces-249068-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNj8DASCCWoodQQAu9opvQ
	(envelope-from <stable+bounces-249068-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 10:53:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF0C56008D
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 10:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C38F300D620
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52D234D382;
	Sun, 17 May 2026 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifdNP9CO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D9334B404;
	Sun, 17 May 2026 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779007997; cv=none; b=Jz5oqn5yuo9RlowFvWgyD4amc7KfFoAz6yHoXfC2nhlboP4TQy3NSKaeAKBVctkySdwuq4Kx9yufd/CBJrPSGP75zT1RKKo6RQUBFTAyd/mMu+SL49yu2hROrkVpsfhavKfJ50exux5Qis5/y22u2Ho3g7nAm3RirJI51t4D7GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779007997; c=relaxed/simple;
	bh=6NVa9dweRdFO6QowVmIg+LhHZ6QpCtoe/HQOJhpzmDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsoK3K0cCTlZo2gFxjKbvQ5DIjBTgbaLj8BNMUhGZhNX5ilXVh8/lIzSsnzUNbQkDN3GjswfO2N3bEL9hpP7GO+3o88lgta6Kwntnso4HJ08Wv3zeQF85EaHij7YsXtwRDg9i490E9WwTfwQu1PlbUR+sbeMoxSdT6jjn3OKKN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifdNP9CO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2FFC2BCB0;
	Sun, 17 May 2026 08:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779007997;
	bh=6NVa9dweRdFO6QowVmIg+LhHZ6QpCtoe/HQOJhpzmDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifdNP9CO0wuF44b4p0OUj9IGvv0S9BP/M8D/6Hbj9bHJEnkX82ksM4dK7Tc7HdCum
	 jiv3do7xPgXmB5e0ZgG5oKbKDrOvruEjhACl19Pjt+1ZM6uU62Fr95YpZ2dwHfCp4N
	 TJjDypJgvF6/UN42GhnDf8gG1AmB/EQS+dSqPJslEuutuHH12/KSnqLUBRehcksgAW
	 lJe18rUz8hTQRoy9eKHH8Y08r5GiGankUKqVNGX1ba0O+XDloSYLnUJj4HAK+n2UwB
	 eSlUyZTvf1sZiAJjpyULKHgkub1mzefm6UcyI+3jQxnD8DVeN5GyaTZCHIcbjTCboI
	 zwM+xVfUt0hmg==
Date: Sun, 17 May 2026 11:53:11 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, kbusch@kernel.org,
	jgg@ziepe.ca, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] dma-mapping: move dma_map_resource() sanity check
 into debug code
Message-ID: <20260517085311.GB33515@unreal>
References: <20260513072209.1486986-1-jianpeng.chang.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513072209.1486986-1-jianpeng.chang.cn@windriver.com>
X-Rspamd-Queue-Id: 9EF0C56008D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249068-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email,windriver.com:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 03:22:09PM +0800, Jianpeng Chang wrote:
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
> The check no longer blocks the mapping and uses err_printk() to
> integrate with dma-debug filtering.
> 
> Fixes: f7326196a781 ("dma-mapping: export new dma_*map_phys() interface")
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
> ---
> v3:
>   - WARN_ONCE -> err_printk()
>   - move the MMIO check down, and delete the return
> v2: https://lore.kernel.org/all/20260511083133.1096171-1-jianpeng.chang.cn@windriver.com/
>    - move check to debug_dma_map_phys and replace pfn_valid() with
>      pfn_valid() && !PageReserved() as Robin suggested.
>    - update commit message to explain why PageReserved is safe for
>      ZONE_DEVICE PCI_P2PDMA pages
> v1: https://lore.kernel.org/all/20260507032120.4072283-1-jianpeng.chang.cn@windriver.com/
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

