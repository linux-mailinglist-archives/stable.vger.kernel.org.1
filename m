Return-Path: <stable+bounces-172278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7984B30D10
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F21891310
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8E427FD47;
	Fri, 22 Aug 2025 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuitPRUK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F908393DC5;
	Fri, 22 Aug 2025 03:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834958; cv=none; b=fnDN0FT84XKb4dQEarnLWUpjmY/HeoISsBaOFgvqGYku1IXMB3BhOdJZ0Ct1BJhM3SFc9p9Phhs/YDW0kfGoh2mQoJhgffCG2O8pNvN6huPPOxjm1WCMpGonD+mJgRb63O2pse+xJ6eXpGJFWmq5P1NX92hvGoMjxp1YUradg/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834958; c=relaxed/simple;
	bh=qLCDKmiddCwZUm1CHvqLdPK5X7thVhfZ6TMgqptlyPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3eY36Lxp5/muHAs+c6qdbytk+pwhaeo40td6JQKIlmFOyChRema75cIO43gEurDHYmSwu7oen01SeJHLNqdmN+kLxCXEu1WK5HRaKzCahPfDL/5/xJIvYNtBYlmk7Tpe2YledF5xfIp/SlKKSXpzS3uPzN+u9cJqjZ+MpTFs0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuitPRUK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755834956; x=1787370956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qLCDKmiddCwZUm1CHvqLdPK5X7thVhfZ6TMgqptlyPA=;
  b=OuitPRUK8zCYjpe02edCvsUKYLLri1uL4WjpmA2iicB1E6dl4VcLLjcU
   Z6aMGiT4KzfLFdjwC/aW35XSY+96Na2US/eDv7elcSUhXXH6lfmBs6XAk
   aDLWnfWyYSBrlNICK6nK8DkXEMD4CCXFN3tud0ErzValGAsiB5VyuEBJQ
   AbRTA8KOMo5vYBbnCQCXOk/x2mBtL74RYYmVIbEJAQuBs2JhjK/N50uE0
   F07Gw5Shmb4t997XkZ5D9wITXX+768W9y4yscrpgC29jV2ygLlInAYMt8
   cMKUmtxd+8BhmfNUKJyKEi3P1Q7vkHyo+aVOxYswlGrVCJJN4WxpFi1rm
   A==;
X-CSE-ConnectionGUID: 5sDIrBBgScCVCwVp+BaM9g==
X-CSE-MsgGUID: HeFendWqSNepO0htrFexZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58235450"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58235450"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 20:55:56 -0700
X-CSE-ConnectionGUID: 3j57/HYuSj+nD79Nz5d7LA==
X-CSE-MsgGUID: /oZ7ZHk9SsSojHbGfc/ttA==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 21 Aug 2025 20:55:53 -0700
Date: Fri, 22 Aug 2025 11:45:27 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: jgg@nvidia.com, m.szyprowski@samsung.com, yilun.xu@intel.com,
	stable-commits@vger.kernel.org, yilun.xu@linux.intel.com
Subject: Re: Patch "zynq_fpga: use sgtable-based scatterlist wrappers" has
 been added to the 6.16-stable tree
Message-ID: <aKfn1+1q0VX3zfyG@yilunxu-OptiPlex-7050>
References: <2025082118-visitor-lanky-8451@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025082118-visitor-lanky-8451@gregkh>

On Thu, Aug 21, 2025 at 03:20:18PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     zynq_fpga: use sgtable-based scatterlist wrappers
> 
> to the 6.16-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      zynq_fpga-use-sgtable-based-scatterlist-wrappers.patch
> and it can be found in the queue-6.16 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Hi Greg:

This patch solves sgtable usage issue but causes AMD fpga driver fail,

https://lore.kernel.org/linux-fpga/202508041548.22955.pisa@fel.cvut.cz/


The fix patch should be applied together with this patch:

https://lore.kernel.org/linux-fpga/20250806070605.1920909-2-yilun.xu@linux.intel.com/

Thanks,
Yilun

> 
> 
> From 37e00703228ab44d0aacc32a97809a4f6f58df1b Mon Sep 17 00:00:00 2001
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> Date: Mon, 16 Jun 2025 14:09:32 +0200
> Subject: zynq_fpga: use sgtable-based scatterlist wrappers
> 
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> commit 37e00703228ab44d0aacc32a97809a4f6f58df1b upstream.
> 
> Use common wrappers operating directly on the struct sg_table objects to
> fix incorrect use of statterlists related calls. dma_unmap_sg() function
> has to be called with the number of elements originally passed to the
> dma_map_sg() function, not the one returned in sgtable's nents.
> 
> CC: stable@vger.kernel.org
> Fixes: 425902f5c8e3 ("fpga zynq: Use the scatterlist interface")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Link: https://lore.kernel.org/r/20250616120932.1090614-1-m.szyprowski@samsung.com
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/fpga/zynq-fpga.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -406,7 +406,7 @@ static int zynq_fpga_ops_write(struct fp
>  	}
>  
>  	priv->dma_nelms =
> -	    dma_map_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
> +	    dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
>  	if (priv->dma_nelms == 0) {
>  		dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
>  		return -ENOMEM;
> @@ -478,7 +478,7 @@ out_clk:
>  	clk_disable(priv->clk);
>  
>  out_free:
> -	dma_unmap_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
> +	dma_unmap_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
>  	return err;
>  }
>  
> 
> 
> Patches currently in stable-queue which might be from m.szyprowski@samsung.com are
> 
> queue-6.16/zynq_fpga-use-sgtable-based-scatterlist-wrappers.patch

