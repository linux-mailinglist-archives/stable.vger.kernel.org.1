Return-Path: <stable+bounces-95367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 436989D8449
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 12:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3802DB261DB
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 11:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5AC1922F3;
	Mon, 25 Nov 2024 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhU7YJ56"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE9F16F8F5;
	Mon, 25 Nov 2024 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533369; cv=none; b=rNYoeTTeMI4M0I5ATs+eCfh+mp/Q/hhjy7GPUYJ0VZ/F0vkvMk6xEzvlT+uEh1rLhN/3SZeOCE/VliOzCMuMQz45YxL+HdDKqwLZkQ8xrb3vaMomKMeTf0D2pupDkb/VVvFPrHUZwQGZn1brBJ9kZzLrQ5nDBZWIH86Za7/hG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533369; c=relaxed/simple;
	bh=kdnVlIG+B0GvyzI6XnIWhqcMOJeA2ir/FehYBjUqKeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9oCQdkNeJEPbS/EPZ3DqGqMHtVNz0PCe9u2SlMsvIBwHbPtLZE8NruMBSsyUe3XhLmJFp1Yz3+UBO+ZVtUrOx78XE6AnCdBGYCTgM0MQXaQ3GRj8NRHWGbxNOR6Ew54JyHWFU7KaqoMHY+o87Egdfxrw4VrAusGJMGjyIjsq3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhU7YJ56; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732533366; x=1764069366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kdnVlIG+B0GvyzI6XnIWhqcMOJeA2ir/FehYBjUqKeg=;
  b=FhU7YJ56sRfpjO2NPOdG6krrzBI1MMPfhAsuuIVMesQX9Yy1iQBV1jwX
   thbuujFYLD3U3oMTeAZAuXyRnNH3wyOHwQQRK3inrLsZGpxF0GiUpwWyd
   Yqvkg7/AIIAxB/5AyUpWZlQ/AFbq+smdmzVE7ZSGfQ2c1O+1o8g50jpPi
   XIXOhiS3cNQ24sYjnvuWeE6LuIbXO31eIul8hPnu+oXUnRLL7dJbOQfWB
   lyHKjn4ntt6KR6yA/TasKImdCbWyvAIln33Vxh916jC6JVuCSZXNczsuv
   0sNMC9wQoL64thEDaxbx5xja+cGjsLVjzpwxxzDm4A9yq5IjIATJT5Pee
   A==;
X-CSE-ConnectionGUID: nzGlADILRxeKvcOwX41Gbg==
X-CSE-MsgGUID: 8yBrSqIuRuquV+7XblJRTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="35486595"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="35486595"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 03:16:06 -0800
X-CSE-ConnectionGUID: gBeP8Lr+RZqCkZddfOJNRw==
X-CSE-MsgGUID: spSc4BW6RXSzi0N0AoewcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91690128"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa009.fm.intel.com with SMTP; 25 Nov 2024 03:16:04 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 25 Nov 2024 13:16:03 +0200
Date: Mon, 25 Nov 2024 13:16:03 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: anx7411: fix OF node reference leaks in
 anx7411_typec_switch_probe()
Message-ID: <Z0Rcc3_E25-2KJaw@kuha.fi.intel.com>
References: <20241121023914.1194333-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121023914.1194333-1-joe@pf.is.s.u-tokyo.ac.jp>

Hi,

Sorry to keep you waiting.

On Thu, Nov 21, 2024 at 11:39:14AM +0900, Joe Hattori wrote:
> The refcounts of the OF nodes obtained in by of_get_child_by_name()
> calls in anx7411_typec_switch_probe() are not decremented. Add
> additional device_node fields to anx7411_data, and call of_node_put() on
> them in the error path and in the unregister functions.
> 
> Fixes: e45d7337dc0e ("usb: typec: anx7411: Use of_get_child_by_name() instead of of_find_node_by_name()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
> Changes in v3:
> - Add new fields to anx7411_data.
> - Remove an unnecessary include.
> ---
>  drivers/usb/typec/anx7411.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index 95607efb9f7e..e714b04399fa 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -290,6 +290,8 @@ struct anx7411_data {
>  	struct power_supply *psy;
>  	struct power_supply_desc psy_desc;
>  	struct device *dev;
> +	struct device_node *switch_node;
> +	struct device_node *mux_node;

Please make these fwnodes.

>  };
>  
>  static u8 snk_identity[] = {
> @@ -1099,6 +1101,7 @@ static void anx7411_unregister_mux(struct anx7411_data *ctx)
>  	if (ctx->typec.typec_mux) {
>  		typec_mux_unregister(ctx->typec.typec_mux);
>  		ctx->typec.typec_mux = NULL;
> +		of_node_put(ctx->mux_node);

fwnode_handle_put(ctx->mux_node);

>  	}
>  }
>  
> @@ -1107,6 +1110,7 @@ static void anx7411_unregister_switch(struct anx7411_data *ctx)
>  	if (ctx->typec.typec_switch) {
>  		typec_switch_unregister(ctx->typec.typec_switch);
>  		ctx->typec.typec_switch = NULL;
> +		of_node_put(ctx->switch_node);

fwnode_handle_put(ctx->switch_node);

>  	}
>  }
>  
> @@ -1114,28 +1118,29 @@ static int anx7411_typec_switch_probe(struct anx7411_data *ctx,
>  				      struct device *dev)
>  {
>  	int ret;
> -	struct device_node *node;
>  
> -	node = of_get_child_by_name(dev->of_node, "orientation_switch");
> -	if (!node)
> +	ctx->switch_node = of_get_child_by_name(dev->of_node, "orientation_switch");

ctx->switch_node = device_get_named_child_node(dev, "orientation_switch");

> +	if (!ctx->switch_node)
>  		return 0;
>  
> -	ret = anx7411_register_switch(ctx, dev, &node->fwnode);
> +	ret = anx7411_register_switch(ctx, dev, &ctx->switch_node->fwnode);
>  	if (ret) {
>  		dev_err(dev, "failed register switch");
> +		of_node_put(ctx->switch_node);
>  		return ret;
>  	}
>  
> -	node = of_get_child_by_name(dev->of_node, "mode_switch");
> -	if (!node) {
> +	ctx->mux_node = of_get_child_by_name(dev->of_node, "mode_switch");

ctx->mux_node = device_get_named_child_node(dev, "mode_switch");

> +	if (!ctx->mux_node) {
>  		dev_err(dev, "no typec mux exist");
>  		ret = -ENODEV;
>  		goto unregister_switch;
>  	}
>  
> -	ret = anx7411_register_mux(ctx, dev, &node->fwnode);
> +	ret = anx7411_register_mux(ctx, dev, &ctx->mux_node->fwnode);
>  	if (ret) {
>  		dev_err(dev, "failed register mode switch");
> +		of_node_put(ctx->mux_node);
>  		ret = -ENODEV;
>  		goto unregister_switch;
>  	}

thanks,

-- 
heikki

