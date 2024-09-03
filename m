Return-Path: <stable+bounces-72853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0047296A820
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABCC1F242CF
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7861D0177;
	Tue,  3 Sep 2024 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="db01f5As"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFDB1DC725;
	Tue,  3 Sep 2024 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394503; cv=none; b=WEVXvxqoXeYgOOCh7R74lbRmNz/e49TJV9yCy3Z+cO81iPO5MWOXENZy2e1KsgK7RPIESZR84IOV/+zG40LxH74z8wqXkjWf/dgByXkgRgrfocUbWqLko5OEpLs6fPmcYEgsdLS63PfaGJKB19oaijQ2dhmYiDT786FkhMvcn6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394503; c=relaxed/simple;
	bh=B2JZUSllFXbp81JbHZMl5Zrl7CI+1VuqCXFLo7QAxq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ4Jm+l2fabJvHji0BJS37CEMCLg9n5G+g5Hr4BLWEOna+1JuHiKr5GKXV/7XAHaFI/zZKtcvlAzMBeQxC/SnNpLT83jrKnKyBBfdufx5OfMcWNZ7tFMmzCz2zgbDsLaOVhXPUkgbwG/35OB+AZ1TNSDTh/FydSUxt75sfCKomw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=db01f5As; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725394502; x=1756930502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B2JZUSllFXbp81JbHZMl5Zrl7CI+1VuqCXFLo7QAxq4=;
  b=db01f5AsUXGCKcD58VZj6j2nO0lyoDwuLW74B6WAJDN0sxKhmc4XA/2R
   j09Q0muBXGuSopalQ+EwpSHGusXHj9FQNOu40xt4xiTMAaHaH67X0nqqs
   kxnEcksQm/MHrI/mOYY2vfDLjOlRCQiPPCw9Sg454khD8TG890hjlDIMA
   hRWI7penqfTFRXWfuPaYncIb9sWrgxaHtTmi4rgXohFBiV9yMIl/0Aa2i
   8b50B4nbRA0aRFbWWGRiiYFd9I7/cnoQkcQmrHvIAVbY1ROw/3r06Wsnr
   Lt+UvTaVYfPh5hozeMXTpJerjjNun9inBD2NSyAga5EAW3W6vezQuYDcv
   A==;
X-CSE-ConnectionGUID: 0/QpKTqyQmqjIHsHdtxRQw==
X-CSE-MsgGUID: AtvYaqc0T9S8gNDIkeWoBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23976179"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="23976179"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 13:15:01 -0700
X-CSE-ConnectionGUID: 5mF1nHTQQMyAhO32ckfY8g==
X-CSE-MsgGUID: YGSrp2mjTeKat4m7spVk1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="65053363"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.20])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 13:14:59 -0700
Date: Tue, 3 Sep 2024 13:14:57 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ben Widawsky <bwidawsk@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Fix logic for finding a free cxl decoder
Message-ID: <ZtduQeu2NNyVWTk7@aschofie-mobl2.lan>
References: <20240903-fix_cxld-v1-1-61acba7198ae@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-fix_cxld-v1-1-61acba7198ae@quicinc.com>

On Tue, Sep 03, 2024 at 08:41:44PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> match_free_decoder()'s logic for finding a free cxl decoder depends on
> a prerequisite that all child decoders are sorted by ID in ascending order
> but the prerequisite may not be guaranteed, fix by finding a free cxl
> decoder with minimal ID.

After reading the 'Closes' tag below I have a better understanding of
why you may be doing this, but I don't want to have to jump to that
Link. Can you describe here examples of when the ordered allocation
may not be guaranteed, and the impact when that happens.

This includes a change to device_for_each_child() which I see mentioned
in the Closes tag discussion too. Is that required for this fix?

It's feeling like the fix and api update are comingled. Please clarify.

Thanks,
Alison

> 
> Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> Closes: https://lore.kernel.org/all/cdfc6f98-1aa0-4cb5-bd7d-93256552c39b@icloud.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/cxl/core/region.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..b9607b4fc40b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -797,21 +797,26 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  static int match_free_decoder(struct device *dev, void *data)
>  {
>  	struct cxl_decoder *cxld;
> -	int *id = data;
> +	struct cxl_decoder *target_cxld;
> +	struct device **target_device = data;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
>  
>  	cxld = to_cxl_decoder(dev);
> -
> -	/* enforce ordered allocation */
> -	if (cxld->id != *id)
> +	if (cxld->region)
>  		return 0;
>  
> -	if (!cxld->region)
> -		return 1;
> -
> -	(*id)++;
> +	if (!*target_device) {
> +		*target_device = get_device(dev);
> +		return 0;
> +	}
> +	/* enforce ordered allocation */
> +	target_cxld = to_cxl_decoder(*target_device);
> +	if (cxld->id < target_cxld->id) {
> +		put_device(*target_device);
> +		*target_device = get_device(dev);
> +	}
>  
>  	return 0;
>  }
> @@ -839,8 +844,7 @@ cxl_region_find_decoder(struct cxl_port *port,
>  			struct cxl_endpoint_decoder *cxled,
>  			struct cxl_region *cxlr)
>  {
> -	struct device *dev;
> -	int id = 0;
> +	struct device *dev = NULL;
>  
>  	if (port == cxled_to_port(cxled))
>  		return &cxled->cxld;
> @@ -849,7 +853,8 @@ cxl_region_find_decoder(struct cxl_port *port,
>  		dev = device_find_child(&port->dev, &cxlr->params,
>  					match_auto_decoder);
>  	else
> -		dev = device_find_child(&port->dev, &id, match_free_decoder);
> +		/* Need to put_device(@dev) after use */
> +		device_for_each_child(&port->dev, &dev, match_free_decoder);
>  	if (!dev)
>  		return NULL;
>  	/*
> 
> ---
> base-commit: 67784a74e258a467225f0e68335df77acd67b7ab
> change-id: 20240903-fix_cxld-4f6575a90619
> 
> Best regards,
> -- 
> Zijun Hu <quic_zijuhu@quicinc.com>
> 

