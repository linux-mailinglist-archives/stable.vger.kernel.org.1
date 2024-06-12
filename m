Return-Path: <stable+bounces-50204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332CE904C8F
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 09:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31162840A3
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 07:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8877412F5A1;
	Wed, 12 Jun 2024 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u1Re4Ijl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE6417C9;
	Wed, 12 Jun 2024 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176806; cv=none; b=oINYK7PgCi2uTLjAbxZuSBhgaFTQRh6wkpNEKkr8zAmBtY/DXMrn5itMAxZBaWnsVwngQLoDPrKoF4OKalWS3RYYHIVmc5w1X+EbmMRZqstkQallH0dK0THbfmj5IlVb9CYGntiHsijwpryLOZBM4uk/+Q9eZqmiTJWi44c7Ql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176806; c=relaxed/simple;
	bh=6LKNcDkiR6haqhH0c4d9D/aD3KKjTTuaAQYblOONqB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5QZ/ZItLggOArDTLhibKtZmNY7k4+y+LvDgOfQ1TGoj4CeF74OLAfi6dypT1ifehfMqaLlSZMoZGi2rXmnpsHQHqptErgXxp5alu8U9roLM1DVn5rZvxrvD5tmfqdMjiqN75iqOEoPQICe34mNwHoHErmYiJN/pmPb1axmrfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u1Re4Ijl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413E0C3277B;
	Wed, 12 Jun 2024 07:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718176805;
	bh=6LKNcDkiR6haqhH0c4d9D/aD3KKjTTuaAQYblOONqB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1Re4IjlBcM5fzUtCOGLInvUYXE6IPxIpJ2+kVcecipQMs9HVh3kx7J7caR7vLVUn
	 yzOC3UDmjvc/G4G8IpzP2OTa2Kc0/OPeMJtv5MVV7Q41Weu2J3hW+s1qVjOOmr2OTd
	 NLRoFDifDAB32GCuxZP1EYtBN7X3hOM0fRyeZ3HI=
Date: Wed, 12 Jun 2024 09:20:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "zhai.he" <zhai.he@nxp.com>
Cc: akpm@linux-foundation.org, sboyd@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	zhipeng.wang_1@nxp.com, jindong.yue@nxp.com
Subject: Re: [PATCH] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Message-ID: <2024061228-unburned-dander-c9a2@gregkh>
References: <20240612023831.810332-1-zhai.he@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612023831.810332-1-zhai.he@nxp.com>

On Wed, Jun 12, 2024 at 10:38:31AM +0800, zhai.he wrote:
> From: He Zhai <zhai.he@nxp.com>
> 
> In the current code logic, if the device-specified CMA memory
> allocation fails, memory will not be allocated from the default CMA area.
> This patch will use the default cma region when the device's
> specified CMA is not enough.
> 
> Signed-off-by: He Zhai <zhai.he@nxp.com>
> ---
>  kernel/dma/contiguous.c | 11 +++++++++--
>  mm/cma.c                |  2 +-
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 055da410ac71..e45cfb24500f 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -357,8 +357,13 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>  	/* CMA can be used only in the context which permits sleeping */
>  	if (!gfpflags_allow_blocking(gfp))
>  		return NULL;
> -	if (dev->cma_area)
> -		return cma_alloc_aligned(dev->cma_area, size, gfp);
> +	if (dev->cma_area) {
> +		struct page *page = NULL;
> +
> +		page = cma_alloc_aligned(dev->cma_area, size, gfp);
> +		if (page)
> +			return page;
> +	}
>  	if (size <= PAGE_SIZE)
>  		return NULL;
>  
> @@ -406,6 +411,8 @@ void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
>  	if (dev->cma_area) {
>  		if (cma_release(dev->cma_area, page, count))
>  			return;
> +		if (cma_release(dma_contiguous_default_area, page, count))
> +			return;
>  	} else {
>  		/*
>  		 * otherwise, page is from either per-numa cma or default cma
> diff --git a/mm/cma.c b/mm/cma.c
> index 3e9724716bad..f225b3f65bd2 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -495,7 +495,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  	}
>  
>  	if (ret && !no_warn) {
> -		pr_err_ratelimited("%s: %s: alloc failed, req-size: %lu pages, ret: %d\n",
> +		pr_debug("%s: %s: alloc failed, req-size: %lu pages, ret: %d, try to use default cma\n",
>  				   __func__, cma->name, count, ret);

Why did you change the error level here?

And when you use pr_debug(), you NEVER need to use __func__, as it is
already included automatically in the message output.  So now you have
it twice :)

thanks,

greg k-h

