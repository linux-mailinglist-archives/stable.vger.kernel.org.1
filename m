Return-Path: <stable+bounces-50326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF70D905B6E
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 20:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711A1B21B3B
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154DB3BBEC;
	Wed, 12 Jun 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sm1lqskG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15282F3B;
	Wed, 12 Jun 2024 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218069; cv=none; b=kkKU8ySej+TCKgbKh7KawwyAQYrJuIEBCNXu52Rqkk93M9m/GCcHe2AV8FoKoZDIk2LvoSGvdJu56Les5cokXXTZrKZWwsv7AW3SoiD29JTfxvNNPqMRTCNaWUgYVRZHfDHwZuKpDEGNEsPWcBS1njIlBL2rSJftdDtsWz5TST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218069; c=relaxed/simple;
	bh=WAdPbpV16su/L/nLL1I9OCKFq9jqJsizJUL/5Q609jU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=q7wWlFgdLy4kCyITZpTTLKZerisVYkixfTV/IesSB/GSebK7/Gkqj4zvIn2AJ3vBbbeu6HSc8VJ5VXTCenAqkFLAf2CMif1uuGDBjWNQbjmaxztLLZ8iB9tE31gHAO/Vauz/ewRQbrzPjbt0w3e+X1IhgmK4o1x6OY5lt1NLY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sm1lqskG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53EDC116B1;
	Wed, 12 Jun 2024 18:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718218069;
	bh=WAdPbpV16su/L/nLL1I9OCKFq9jqJsizJUL/5Q609jU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sm1lqskGRET2keI9nUnBWAo9NHejyLojU8nIbdRINQDTbTFnHquXRBI3amEYYfRqf
	 MHr0NVCg3m01gJr8LppX/w5oXog83ISpT/eeV4yrRIZimnxBuRdW1qLNYfTy7IEt4I
	 JHmCDvtnsf7cXRN+5v4SiohSXp6hI5njlG4cKRtI=
Date: Wed, 12 Jun 2024 11:47:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "zhai.he" <zhai.he@nxp.com>
Cc: sboyd@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, zhipeng.wang_1@nxp.com, jindong.yue@nxp.com, Barry
 Song <baohua@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Message-Id: <20240612114748.bf5983b50634f23d674bc749@linux-foundation.org>
In-Reply-To: <20240612081216.1319089-1-zhai.he@nxp.com>
References: <20240612081216.1319089-1-zhai.he@nxp.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 16:12:16 +0800 "zhai.he" <zhai.he@nxp.com> wrote:

> From: He Zhai <zhai.he@nxp.com>

(cc Barry & Christoph)

What was your reason for adding cc:stable to the email headers?  Does
this address some serious problem?  If so, please fully describe that
problem.

> In the current code logic, if the device-specified CMA memory
> allocation fails, memory will not be allocated from the default CMA area.
> This patch will use the default cma region when the device's
> specified CMA is not enough.
> 
> In addition, the log level of allocation failure is changed to debug.
> Because these logs will be printed when memory allocation from the
> device specified CMA fails, but if the allocation fails, it will be
> allocated from the default cma area. It can easily mislead developers'
> judgment.
>
> ...
>
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

The dma_alloc_contiguous() kerneldoc should be updated for this.

The patch prompts the question "why does the device-specified CMA area
exist?".  Why not always allocate from the global pool?  If the
device-specified area exists to prevent one device from going crazy and
consuming too much contiguous memory, this patch violates that intent?

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
> index 3e9724716bad..6e12faf1bea7 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -495,8 +495,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  	}
>  
>  	if (ret && !no_warn) {
> -		pr_err_ratelimited("%s: %s: alloc failed, req-size: %lu pages, ret: %d\n",
> -				   __func__, cma->name, count, ret);
> +		pr_debug("%s: alloc failed, req-size: %lu pages, ret: %d, try to use default cma\n",
> +			    cma->name, count, ret);
>  		cma_debug_show_areas(cma);
>  	}


