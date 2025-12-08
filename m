Return-Path: <stable+bounces-200320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7796ACABF60
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 04:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5E173017936
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 03:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A1F274B51;
	Mon,  8 Dec 2025 03:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un/IZLfQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0272243954;
	Mon,  8 Dec 2025 03:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765164350; cv=none; b=A55L1wKmxIfoNw9YiW5Zl8BEWSEVAskseUXrgyinAh4auwrcki8nkHd3x6aDTFEsfhyLyngKFXyUl0XNUlDDfRIQNaB2zOsRQY+EV0mMBmmRQWwJGu+5d78EkaO549yQXNGrl2wxhOvxwfvE/0Qt8TTBcpg+Lm2ikaJGsiJVxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765164350; c=relaxed/simple;
	bh=JbduDDkLQ46io1rnDf0vXzxeQyYTvj1xom1cGE2Q18U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ryca3D+Ex0dSKf6ZCjPycb75G62Qw4WC4c8l/CKIKeDm3KWxEWKpL+JpTX9Ww4Qhm9kz8ZY8xCwoAo4tR0Gj/+70XpDyBTzI6/MjmVLeLOIKUj/1HZZnQazvxzGejlYgh47NhIBzm0l2kn+lK38XHzWpZOI8vPKe/D/yaUvYn8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un/IZLfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADBEC4CEFB;
	Mon,  8 Dec 2025 03:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765164349;
	bh=JbduDDkLQ46io1rnDf0vXzxeQyYTvj1xom1cGE2Q18U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Un/IZLfQv9olPoJrI6TWqNgjbvpYgBOKTIBnL4oKy99jQ4uCu0eFmC6cQbk2+cBdp
	 8XlfVRYM+9OCTO5JavQ1ZyZtvhbxjV8YeGtIJRH8XQlYrDTE0YCTbH6q0c/+xcQP/2
	 kLTB4PDrlScRnH1Je1X8Wa3iKgWo2rzTgdXCYVeEcMuuUeViV3MjOJO+vo5GPm+SVh
	 Eb4nI0S3+HsijkBXa1Ixq3mzDYocIxrlXXLZ2Ys3zjTGv9mAa6BTIyFf++DmsaSWDc
	 4x/0aIZ9IBGFIoAExNbFYOEjovCdOkLgt+yIb37kao8OznttxW1xBVLXqdVCiAULp8
	 s5A7n5F4DQPxA==
Date: Sun, 7 Dec 2025 19:25:45 -0800
From: Nathan Chancellor <nathan@kernel.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	James Clark <james.clark@linaro.org>, stable@vger.kernel.org
Subject: Re: [PATCH 6.18 regression fix] dma-mapping: Fix DMA_BIT_MASK()
 macro being broken
Message-ID: <20251208032545.GB1356249@ax162>
References: <20251207184756.97904-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207184756.97904-1-johannes.goede@oss.qualcomm.com>

On Sun, Dec 07, 2025 at 07:47:56PM +0100, Hans de Goede wrote:
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
>         mmu_info->aperture_end =
>                 (dma_addr_t)DMA_BIT_MASK(isp->secure_mode ?
>                                          IPU6_MMU_ADDR_BITS :
>                                          IPU6_MMU_ADDR_BITS_NON_SECURE);
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

Yeah, the parentheses definitely should have been kept.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/dma-mapping.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 2ceda49c609f..aa36a0d1d9df 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -90,7 +90,7 @@
>   */
>  #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
>  
> -#define DMA_BIT_MASK(n)	GENMASK_ULL(n - 1, 0)
> +#define DMA_BIT_MASK(n)	GENMASK_ULL((n) - 1, 0)
>  
>  struct dma_iova_state {
>  	dma_addr_t addr;
> -- 
> 2.52.0
> 

