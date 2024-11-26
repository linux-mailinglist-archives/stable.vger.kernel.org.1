Return-Path: <stable+bounces-95511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028F39D9471
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 10:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD122815EC
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 09:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775291BD9CD;
	Tue, 26 Nov 2024 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIlM6SgO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D416CA6F;
	Tue, 26 Nov 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613259; cv=none; b=GTc8Ht/Mddgcvym8G25uoZu8uCOg/J2aXTSH3dbo6sI7LSxaHFW6a5fRtGcwCrMy+mV3tfNoOjxKQj0RjzqLcg3rDJbkmZVMQXUZxb6bWxxe5kDyA6uwk4Np4xTdXNGmbADHbVNB4G6dRp/zxSZXWLj1FjjDvM/smFh6S40yalQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613259; c=relaxed/simple;
	bh=XYbpgUtTz1R7Jh/xpPNyurNKBVk4KaG/K/HROA5ztPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5NjV1DQ7mlTJfQkqh5sGdX6kV1s0kc2mGzlqeEqT0LrPCI8p62DQ8hZsV90WoiGHzICxi/rejhlXj536ccy+e/vPP0xXaf7558ESzglWkxKUusPKq1BIEoq16uWf+9JxwSHDOYBhHrWLsIDi9lph1MeIOpJllpxtlEKV8OHX5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIlM6SgO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732613257; x=1764149257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XYbpgUtTz1R7Jh/xpPNyurNKBVk4KaG/K/HROA5ztPA=;
  b=EIlM6SgOprDXZ9wzyx4kf267kINb3fqMmtCv/iICcrxjHPvlueFT6D51
   bzx/KmTMP1aNcXqV+IJDhWvMcLUNjCL8Ay5ts6OtoZXBfTxfWxzhtUf8G
   kZjLu4QYUk8NU0eCOPMbrCAe2bg8gy+lh8HeyCSmWN8/6h9gU92FXN8Wo
   Ta0C/ecNh7eYBEjqTGi0HbFn4r4LqtwxOrn7uRwCcnC6IvrklgmTW594v
   34t+3FtU29mtCPzbkCXJES5yy55xpD4TyAlJlB30kfZxV8vHnmwCZwHau
   vleFd3ACKxvd/frO749X/Hq7hk7xbYgCE5bigLbR1RVAWF3moUy3wK2mm
   g==;
X-CSE-ConnectionGUID: 7pEAc1KiTKGQt6NiLki7/A==
X-CSE-MsgGUID: C7QuXQwKT9OT+8ncyKLTnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32134018"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="32134018"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 01:27:37 -0800
X-CSE-ConnectionGUID: r0+Qyw7XRqqJroZbytcKOQ==
X-CSE-MsgGUID: Ps1qpsRdQueBd7xNK+dEDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="96482204"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa005.jf.intel.com with SMTP; 26 Nov 2024 01:27:35 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 26 Nov 2024 11:27:32 +0200
Date: Tue, 26 Nov 2024 11:27:32 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: anx7411: fix OF node reference leaks in
 anx7411_typec_switch_probe()
Message-ID: <Z0WUhLGlEJceZWO1@kuha.fi.intel.com>
References: <20241126014909.3687917-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126014909.3687917-1-joe@pf.is.s.u-tokyo.ac.jp>

On Tue, Nov 26, 2024 at 10:49:09AM +0900, Joe Hattori wrote:
> The refcounts of the OF nodes obtained by of_get_child_by_name() calls
> in anx7411_typec_switch_probe() are not decremented. Replace them with
> device_get_named_child_node() calls and store the return values to the
> newly created fwnode_handle fields in anx7411_data, and call
> fwnode_handle_put() on them in the error path and in the unregister
> functions.
> 
> Fixes: e45d7337dc0e ("usb: typec: anx7411: Use of_get_child_by_name() instead of of_find_node_by_name()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/anx7411.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index 95607efb9f7e..0ae0a5ee3fae 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -290,6 +290,8 @@ struct anx7411_data {
>  	struct power_supply *psy;
>  	struct power_supply_desc psy_desc;
>  	struct device *dev;
> +	struct fwnode_handle *switch_node;
> +	struct fwnode_handle *mux_node;
>  };
>  
>  static u8 snk_identity[] = {
> @@ -1099,6 +1101,7 @@ static void anx7411_unregister_mux(struct anx7411_data *ctx)
>  	if (ctx->typec.typec_mux) {
>  		typec_mux_unregister(ctx->typec.typec_mux);
>  		ctx->typec.typec_mux = NULL;
> +		fwnode_handle_put(ctx->mux_node);
>  	}
>  }
>  
> @@ -1107,6 +1110,7 @@ static void anx7411_unregister_switch(struct anx7411_data *ctx)
>  	if (ctx->typec.typec_switch) {
>  		typec_switch_unregister(ctx->typec.typec_switch);
>  		ctx->typec.typec_switch = NULL;
> +		fwnode_handle_put(ctx->switch_node);
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
> +	ctx->switch_node = device_get_named_child_node(dev, "orientation_switch");
> +	if (!ctx->switch_node)
>  		return 0;
>  
> -	ret = anx7411_register_switch(ctx, dev, &node->fwnode);
> +	ret = anx7411_register_switch(ctx, dev, ctx->switch_node);
>  	if (ret) {
>  		dev_err(dev, "failed register switch");
> +		fwnode_handle_put(ctx->switch_node);
>  		return ret;
>  	}
>  
> -	node = of_get_child_by_name(dev->of_node, "mode_switch");
> -	if (!node) {
> +	ctx->mux_node = device_get_named_child_node(dev, "mode_switch");
> +	if (!ctx->mux_node) {
>  		dev_err(dev, "no typec mux exist");
>  		ret = -ENODEV;
>  		goto unregister_switch;
>  	}
>  
> -	ret = anx7411_register_mux(ctx, dev, &node->fwnode);
> +	ret = anx7411_register_mux(ctx, dev, ctx->mux_node);
>  	if (ret) {
>  		dev_err(dev, "failed register mode switch");
> +		fwnode_handle_put(ctx->mux_node);
>  		ret = -ENODEV;
>  		goto unregister_switch;
>  	}
> -- 
> 2.34.1

-- 
heikki

