Return-Path: <stable+bounces-95364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3B69D83F2
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 12:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F80D168EC2
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 11:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF692194C77;
	Mon, 25 Nov 2024 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iY5+TkMw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F94B194C8B;
	Mon, 25 Nov 2024 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532405; cv=none; b=l5sdloeV9mKgL4jMOY0xXRh9p/5KbF/w8r0Aso3xXPefRCK8qSL5izsL7sSNFNvEunN/QsnWZ5dL/2FSw0J0XtoTYVrpKGLn52RL4bksFS0CQ6lb2ruqlvcQggKS+93dMUo6KTcXoOSQ3ir4CaSJRbdyHyx3GMjlJ+qUadSj6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532405; c=relaxed/simple;
	bh=/Quc3TVGoy4pGDVfFhN+c7f352a24FKIfVvfUuYHk+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEKrlgT+288j6Pd+qRxWn0l50PLe2a/qOV/cM+A+sQXQApisRE4hgkk0YIsxvtK0BiGoX12ADzAjK11Rh2VTOIgeXG5my3yOqBo7i7lnLb4k16Y/C/Hbm1mPGoXLQdZM39FcFyuDlRqA8iTbUK01a43cwNqowXX+Yw3dkpqmUSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iY5+TkMw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732532403; x=1764068403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Quc3TVGoy4pGDVfFhN+c7f352a24FKIfVvfUuYHk+8=;
  b=iY5+TkMwflkiq2p7G25vglDaTuL97ZgezgnI9wW4QsVUkxROvLxQvlmN
   NumecsIhhV5bNMt8nOapIiJ4mQM3QF3XjEPnOgORfVzY5MPfPLiTrNbW8
   6QuHkaHBKkIlOdzMUDhr830XM/DkMWnAHNvWJNPtpwiUI1+ti+1fq5lFA
   GI1zVMiEB3ZarSL/Z0JNDJbrqag+712LatZ6G+BwiKRTiCX0+iLRnyHwI
   /OugwdKx8UA0ZdWjEI11pr8VOGISkX3Xhm6xH3r873c5YVC2UvA9ZIM8C
   q/YNTAuef7OtT6/5YD8WXlt9d5ZJ9w+BgcbjfNd6LPi8qeS+Rkk5qehJf
   g==;
X-CSE-ConnectionGUID: ognIg0BJQda1GYSB77J2Cw==
X-CSE-MsgGUID: 5yPVQ9crRFeP6uOY6KNCYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="36553094"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="36553094"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 03:00:03 -0800
X-CSE-ConnectionGUID: vT8KuZrQQYuCAXmurDgi+g==
X-CSE-MsgGUID: cV61WAkET5aMz6yX58YW9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91415169"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa008.fm.intel.com with SMTP; 25 Nov 2024 03:00:00 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 25 Nov 2024 12:59:59 +0200
Date: Mon, 25 Nov 2024 12:59:59 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: anx7411: fix fwnode_handle reference leak
Message-ID: <Z0RYr_H-sy0pfLHN@kuha.fi.intel.com>
References: <20241121023429.962848-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121023429.962848-1-joe@pf.is.s.u-tokyo.ac.jp>

On Thu, Nov 21, 2024 at 11:34:29AM +0900, Joe Hattori wrote:
> An fwnode_handle and usb_role_switch are obtained with an incremented
> refcount in anx7411_typec_port_probe(), however the refcounts are not
> decremented in the error path. The fwnode_handle is also not decremented
> in the .remove() function. Therefore, call fwnode_handle_put() and
> usb_role_switch_put() accordingly.
> 
> Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

You don't need to check for the port nor the role_sw, but never mind:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v2:
> - Call usb_role_switch_put()
> - Remove the port in anx7411_port_unregister().
> ---
>  drivers/usb/typec/anx7411.c | 47 +++++++++++++++++++++++--------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index d1e7c487ddfb..95607efb9f7e 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -1021,6 +1021,16 @@ static void anx7411_port_unregister_altmodes(struct typec_altmode **adev)
>  		}
>  }
>  
> +static void anx7411_port_unregister(struct typec_params *typecp)
> +{
> +	fwnode_handle_put(typecp->caps.fwnode);
> +	anx7411_port_unregister_altmodes(typecp->port_amode);
> +	if (typecp->port)
> +		typec_unregister_port(typecp->port);
> +	if (typecp->role_sw)
> +		usb_role_switch_put(typecp->role_sw);
> +}
> +
>  static int anx7411_usb_mux_set(struct typec_mux_dev *mux,
>  			       struct typec_mux_state *state)
>  {
> @@ -1154,34 +1164,34 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
>  	ret = fwnode_property_read_string(fwnode, "power-role", &buf);
>  	if (ret) {
>  		dev_err(dev, "power-role not found: %d\n", ret);
> -		return ret;
> +		goto put_fwnode;
>  	}
>  
>  	ret = typec_find_port_power_role(buf);
>  	if (ret < 0)
> -		return ret;
> +		goto put_fwnode;
>  	cap->type = ret;
>  
>  	ret = fwnode_property_read_string(fwnode, "data-role", &buf);
>  	if (ret) {
>  		dev_err(dev, "data-role not found: %d\n", ret);
> -		return ret;
> +		goto put_fwnode;
>  	}
>  
>  	ret = typec_find_port_data_role(buf);
>  	if (ret < 0)
> -		return ret;
> +		goto put_fwnode;
>  	cap->data = ret;
>  
>  	ret = fwnode_property_read_string(fwnode, "try-power-role", &buf);
>  	if (ret) {
>  		dev_err(dev, "try-power-role not found: %d\n", ret);
> -		return ret;
> +		goto put_fwnode;
>  	}
>  
>  	ret = typec_find_power_role(buf);
>  	if (ret < 0)
> -		return ret;
> +		goto put_fwnode;
>  	cap->prefer_role = ret;
>  
>  	/* Get source pdos */
> @@ -1193,7 +1203,7 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
>  						     typecp->src_pdo_nr);
>  		if (ret < 0) {
>  			dev_err(dev, "source cap validate failed: %d\n", ret);
> -			return -EINVAL;
> +			goto put_fwnode;
>  		}
>  
>  		typecp->caps_flags |= HAS_SOURCE_CAP;
> @@ -1207,7 +1217,7 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
>  						     typecp->sink_pdo_nr);
>  		if (ret < 0) {
>  			dev_err(dev, "sink cap validate failed: %d\n", ret);
> -			return -EINVAL;
> +			goto put_fwnode;
>  		}
>  
>  		for (i = 0; i < typecp->sink_pdo_nr; i++) {
> @@ -1251,13 +1261,21 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
>  		ret = PTR_ERR(ctx->typec.port);
>  		ctx->typec.port = NULL;
>  		dev_err(dev, "Failed to register type c port %d\n", ret);
> -		return ret;
> +		goto put_usb_role_switch;
>  	}
>  
>  	typec_port_register_altmodes(ctx->typec.port, NULL, ctx,
>  				     ctx->typec.port_amode,
>  				     MAX_ALTMODE);
>  	return 0;
> +
> +put_usb_role_switch:
> +	if (ctx->typec.role_sw)
> +		usb_role_switch_put(ctx->typec.role_sw);
> +put_fwnode:
> +	fwnode_handle_put(fwnode);
> +
> +	return ret;
>  }
>  
>  static int anx7411_typec_check_connection(struct anx7411_data *ctx)
> @@ -1523,8 +1541,7 @@ static int anx7411_i2c_probe(struct i2c_client *client)
>  	destroy_workqueue(plat->workqueue);
>  
>  free_typec_port:
> -	typec_unregister_port(plat->typec.port);
> -	anx7411_port_unregister_altmodes(plat->typec.port_amode);
> +	anx7411_port_unregister(&plat->typec);
>  
>  free_typec_switch:
>  	anx7411_unregister_switch(plat);
> @@ -1548,17 +1565,11 @@ static void anx7411_i2c_remove(struct i2c_client *client)
>  
>  	i2c_unregister_device(plat->spi_client);
>  
> -	if (plat->typec.role_sw)
> -		usb_role_switch_put(plat->typec.role_sw);
> -
>  	anx7411_unregister_mux(plat);
>  
>  	anx7411_unregister_switch(plat);
>  
> -	if (plat->typec.port)
> -		typec_unregister_port(plat->typec.port);
> -
> -	anx7411_port_unregister_altmodes(plat->typec.port_amode);
> +	anx7411_port_unregister(&plat->typec);
>  }
>  
>  static const struct i2c_device_id anx7411_id[] = {
> -- 
> 2.34.1

-- 
heikki

