Return-Path: <stable+bounces-94038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D134E9D2938
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 16:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664311F23D8B
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74401D150D;
	Tue, 19 Nov 2024 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gT9zaEpk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A82E1D1318;
	Tue, 19 Nov 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028924; cv=none; b=pgg8CProuV45OEBzX/8b9Kfg0IcnNEZ775aMOpONxp2Mof6bRit83Iin5fUDyerZ9gG+7LPCb5ltiqBo0BN9Xgd6uMUBYNwZGIAtfQsd5+stlxdm7qCQ4SDyrG7GOwJXYJuMH1lekXYk/PC2thx7U6HQrO/OP/KXz+yH3gSz/C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028924; c=relaxed/simple;
	bh=jOinomfvSkRkzC8TdVy88/VMlbD5SXhu5QQdFZM7Ua4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxNCUMZUeY6GKVixxiu94WYKU6xTVk2S+WSfbkAEnNhW757hhe84AuuzsHP9h2Uh70DtvD7S0VpceAytPk7qpD67qfpFQbQnhiJn4jtMCxPsMDjFOpfbKzcpclYl7OQwEUQDWwPbZ55FLmZu9bJrbf8Pzz5onbPf8UNoVG0OhpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gT9zaEpk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732028922; x=1763564922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jOinomfvSkRkzC8TdVy88/VMlbD5SXhu5QQdFZM7Ua4=;
  b=gT9zaEpkL3z6yS7EMNgLqwZFhm/H89BvqxMJaJk2olLbiGqyflpRuUPC
   KyfmHzHJUruV2WvjHrwIzgAnE9WY98zOspiocqLvBdd/UCf253QiWBsGI
   Zx7zDdHxikrkxrjrR4zzjvkTMajoql+ScL+wvkoZmHpLCFI/CI1YH9Hxp
   bbNVjQIpxNFndlo8TFFgg2kGxcMA+IvCcKUVUYET26soFzKvItQAg10SI
   A3BDWAibAwQi4zrsewll7t031vDOnxVOB1xeE0FfzCE5NSfcyC8MprbiX
   FqrwBRJswwCDeIKQmf9U1y7FAXa+qX250nc2znDi5Vb19+xmAkco7R7u7
   Q==;
X-CSE-ConnectionGUID: jhp1wgr7SR+liPGrQeOrsg==
X-CSE-MsgGUID: 42N9Fm+mQlWtqUj/Uu4U5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42674784"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="42674784"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:08:40 -0800
X-CSE-ConnectionGUID: sMhV3/MPRQCN0S5HC+skug==
X-CSE-MsgGUID: QvZCenRHT0iLS7taIOQ1Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89994684"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa010.fm.intel.com with SMTP; 19 Nov 2024 07:08:39 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Nov 2024 17:08:37 +0200
Date: Tue, 19 Nov 2024 17:08:37 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: anx7411: fix fwnode_handle reference leak
Message-ID: <Zzyp9cSIoqNBFpFa@kuha.fi.intel.com>
References: <20241116085124.3832328-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116085124.3832328-1-joe@pf.is.s.u-tokyo.ac.jp>

On Sat, Nov 16, 2024 at 05:51:24PM +0900, Joe Hattori wrote:
> An fwnode_handle is obtained with an incremented refcount in
> anx7411_typec_port_probe(), however the refcount is not decremented in
> the error path or in the .remove() function. Therefore call
> fwnode_handle_put() accordingly.
> 
> Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>  drivers/usb/typec/anx7411.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index 7e61c3ac8777..d3c5d8f410ca 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -1023,6 +1023,12 @@ static void anx7411_port_unregister_altmodes(struct typec_altmode **adev)
>  		}
>  }
>  
> +static void anx7411_port_unregister(struct typec_params *typecp)
> +{
> +	fwnode_handle_put(typecp->caps.fwnode);
> +	anx7411_port_unregister_altmodes(typecp->port_amode);
> +}

Why not remove the port here while at it.
Otherwise this LGTM.

>  static int anx7411_usb_mux_set(struct typec_mux_dev *mux,
>  			       struct typec_mux_state *state)
>  {
> @@ -1158,34 +1164,34 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
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
> @@ -1197,7 +1203,7 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
>  						     typecp->src_pdo_nr);
>  		if (ret < 0) {
>  			dev_err(dev, "source cap validate failed: %d\n", ret);
> -			return -EINVAL;
> +			goto put_fwnode;
>  		}
>  
>  		typecp->caps_flags |= HAS_SOURCE_CAP;
> @@ -1211,7 +1217,7 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
>  						     typecp->sink_pdo_nr);
>  		if (ret < 0) {
>  			dev_err(dev, "sink cap validate failed: %d\n", ret);
> -			return -EINVAL;
> +			goto put_fwnode;
>  		}
>  
>  		for (i = 0; i < typecp->sink_pdo_nr; i++) {
> @@ -1255,13 +1261,18 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
>  		ret = PTR_ERR(ctx->typec.port);
>  		ctx->typec.port = NULL;
>  		dev_err(dev, "Failed to register type c port %d\n", ret);
> -		return ret;
> +		goto put_fwnode;
>  	}
>  
>  	typec_port_register_altmodes(ctx->typec.port, NULL, ctx,
>  				     ctx->typec.port_amode,
>  				     MAX_ALTMODE);
>  	return 0;
> +
> +put_fwnode:
> +	fwnode_handle_put(fwnode);
> +
> +	return ret;
>  }
>  
>  static int anx7411_typec_check_connection(struct anx7411_data *ctx)
> @@ -1528,7 +1539,7 @@ static int anx7411_i2c_probe(struct i2c_client *client)
>  
>  free_typec_port:
>  	typec_unregister_port(plat->typec.port);
> -	anx7411_port_unregister_altmodes(plat->typec.port_amode);
> +	anx7411_port_unregister(&plat->typec);
>  
>  free_typec_switch:
>  	anx7411_unregister_switch(plat);
> @@ -1562,7 +1573,7 @@ static void anx7411_i2c_remove(struct i2c_client *client)
>  	if (plat->typec.port)
>  		typec_unregister_port(plat->typec.port);
>  
> -	anx7411_port_unregister_altmodes(plat->typec.port_amode);
> +	anx7411_port_unregister(&plat->typec);
>  }
>  
>  static const struct i2c_device_id anx7411_id[] = {

thanks,

-- 
heikki

