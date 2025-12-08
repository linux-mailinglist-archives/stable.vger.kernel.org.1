Return-Path: <stable+bounces-200328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B4CAC87A
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 09:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 979F13038F6B
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1AF296BA2;
	Mon,  8 Dec 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sokPQbvy"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558161EFFB4
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765183378; cv=none; b=b6Bj+zGTCa6bBC4E64m/OkR1mWlq1+lMAR9Dg4uN2MGwHy+8+CafOIwBol4b3VSGlnyI4PFxsoh30IaTgwOZllTvGPeQNLqvq1XPZYh8wUau0lp98g5OzywmVp9JB16b5Hx8O76qGXltjgRGYzz6Qe+p7e7Pf6j73l20bik+mAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765183378; c=relaxed/simple;
	bh=tV4SU9e0hH8WeXPApeSJRL6kAWexD+Z7sjM80xpJdtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=CVEExkkSyyTxTAZmZDUMAIiNXrSLm3b9wtH9q9sxJyovaIpLrdwhfznsXjtpT0TEXyEHCeW2pHPh8e55FD5DEg0B8okOP0mT9d1lJkwpcDFeGK74qhIKcWfDW3eNjhnRQLkSSlORWYBDN1esT7L3VATa4S3pMPzT37vInLb0G5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sokPQbvy; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251208084254euoutp0231c71058658e9d33df598ec2a24a6aee~-MO1RzNZp1096010960euoutp02M
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 08:42:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251208084254euoutp0231c71058658e9d33df598ec2a24a6aee~-MO1RzNZp1096010960euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1765183374;
	bh=T6fMj6wQdFxoPUUn1ui66kl2k9P9jKCOqLNa+VtcJJY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=sokPQbvyTRtiwz597c+7YwJWoR7Z2XfH/M0FTZ8EfwBAfuHJkgs8q7iLztVNQ/wiA
	 Vu48EGbdXAS9cxngxWusjhAfcqijNmpdl1dGvSZKlNv0mJoYwaEMVadZ8J32ua1aIi
	 niWo97H3Qt7oTed1ZWWT43hBHiliAEqn4Wmdf2X4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251208084254eucas1p1e9ccc5b773207bdb23c67fcfa4966f0b~-MO090TkX2957329573eucas1p1N;
	Mon,  8 Dec 2025 08:42:54 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251208084253eusmtip160ec3c0f7073bb5840ab3236c0a88620~-MO0cPnxH1395513955eusmtip1g;
	Mon,  8 Dec 2025 08:42:53 +0000 (GMT)
Message-ID: <5e5ad7e3-583e-4329-be7a-391b5ddeff08@samsung.com>
Date: Mon, 8 Dec 2025 09:42:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 regression fix] dma-mapping: Fix DMA_BIT_MASK()
 macro being broken
To: Hans de Goede <johannes.goede@oss.qualcomm.com>, Robin Murphy
	<robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Sakari Ailus
	<sakari.ailus@linux.intel.com>, James Clark <james.clark@linaro.org>, Nathan
	Chancellor <nathan@kernel.org>, stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251207184756.97904-1-johannes.goede@oss.qualcomm.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251208084254eucas1p1e9ccc5b773207bdb23c67fcfa4966f0b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251207184804eucas1p239087e232b3f09f8617bf6b1daf51ea5
X-EPHeader: CA
X-CMS-RootMailID: 20251207184804eucas1p239087e232b3f09f8617bf6b1daf51ea5
References: <CGME20251207184804eucas1p239087e232b3f09f8617bf6b1daf51ea5@eucas1p2.samsung.com>
	<20251207184756.97904-1-johannes.goede@oss.qualcomm.com>

On 07.12.2025 19:47, Hans de Goede wrote:
> After commit a50f7456f853 ("dma-mapping: Allow use of DMA_BIT_MASK(64) in
> global scope"), the DMA_BIT_MASK() macro is broken when passed non trivial
> statements for the value of 'n'. This is caused by the new version missing
> parenthesis around 'n' when evaluating 'n'.
>
> One example of this breakage is the IPU6 driver now crashing due to
> it getting DMA-addresses with address bit 32 set even though it has
> tried to set a 32 bit DMA mask.
>
> The IPU6 CSI2 engine has a DMA mask of either 31 or 32 bits depending
> on if it is in secure mode or not and it sets this masks like this:
>
>          mmu_info->aperture_end =
>                  (dma_addr_t)DMA_BIT_MASK(isp->secure_mode ?
>                                           IPU6_MMU_ADDR_BITS :
>                                           IPU6_MMU_ADDR_BITS_NON_SECURE);
>
> So the 'n' argument here is "isp->secure_mode ? IPU6_MMU_ADDR_BITS :
> IPU6_MMU_ADDR_BITS_NON_SECURE" which gets expanded into:
>
> isp->secure_mode ? IPU6_MMU_ADDR_BITS : IPU6_MMU_ADDR_BITS_NON_SECURE - 1
>
> With the -1 only being applied in the non secure case, causing
> the secure mode mask to be one 1 bit too large.
>
> Fixes: a50f7456f853 ("dma-mapping: Allow use of DMA_BIT_MASK(64) in global scope")
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Applied to dma-mapping-fixes branch. Thanks!
> ---
>   include/linux/dma-mapping.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 2ceda49c609f..aa36a0d1d9df 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -90,7 +90,7 @@
>    */
>   #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
>   
> -#define DMA_BIT_MASK(n)	GENMASK_ULL(n - 1, 0)
> +#define DMA_BIT_MASK(n)	GENMASK_ULL((n) - 1, 0)
>   
>   struct dma_iova_state {
>   	dma_addr_t addr;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


