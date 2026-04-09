Return-Path: <stable+bounces-235405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D9HDOmb12kUQQgAu9opvQ
	(envelope-from <stable+bounces-235405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:30:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCAB3CA6F8
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3451F301C3F9
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 12:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964CA149C7B;
	Thu,  9 Apr 2026 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKoVWLUv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC03C1403;
	Thu,  9 Apr 2026 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775737806; cv=none; b=IiO81qsYWIcLsoVo9lkeu2sErR9foyfCNEGysotmu45uIjfFo+Xb83C48HzLNrlabhS1hYk6KqeskVuEr6aeapiRIDyP5eUKleFDD4gsEN5WP5+KKMTfz40kwEXvplcGlZQIs6FOJoCX1PjQRRD/Ll+FwyKarhqIrNM+Rc4wFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775737806; c=relaxed/simple;
	bh=xJ3M4J7KKxJBDJmre4wB1TgDOXwOzJsC22Iv2wzUkEk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V0BQMqXn8rL2yDXpG9KwHq1kP/W0PeY+MDqrxfzxqGdwycValQpcLXFchhavTODo8skG8LExzPohqy+HNvaPrWaxOHB5lEpNxyPnRZgIbdH7UyM5ufZp8ueevJvQhlr7GvVhJTX6VD2ppjzk1tzJOftFVVzNrmFm5aOjiY8WNM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKoVWLUv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775737800; x=1807273800;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xJ3M4J7KKxJBDJmre4wB1TgDOXwOzJsC22Iv2wzUkEk=;
  b=RKoVWLUvB5T9V2en+uNkrMXMKuRMWqGYOyRH9SidNpRBAtfY5LNQ0lp3
   ZGwEW+bh+eeKXVCePNXcqbH43gDd/PsvUYcO7mTYx0Eo58mJpt7bNRCOn
   xgHrIKRPHoAFK0786wgsVkXStW45MDaMn3r017LlB2OR9lss2KJhWyMF2
   NBAEaevu6nvg5sc+1BqidOgei+hS7/JQrISNUxHvOxNMxIVF2Bl4gJHsw
   xeLKOjePJLgKlirF9wfo1Ps+HCoALUS3ehQr+SyaeOMicOGDPSdN8Gg2u
   JV9+dQSH8L472Ofyb5lMttbzFrWYOyXh/xtlwQwOa55mavyxC9sSIjy20
   Q==;
X-CSE-ConnectionGUID: 8PhuGm4rSw+IAxIfIdY81A==
X-CSE-MsgGUID: IuYuNCM0Q8OY/jjefWDAxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76702225"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76702225"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 05:29:58 -0700
X-CSE-ConnectionGUID: AxAQxsF/QhKtVHK5JzIn6g==
X-CSE-MsgGUID: iz9TStlaQ3GrFTzh0raR1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="232791765"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.197])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 05:29:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 9 Apr 2026 15:29:36 +0300 (EEST)
To: Rong Zhang <i@rong.moe>
cc: "Derek J . Clark" <derekjohn.clark@gmail.com>, 
    Hans de Goede <hansg@kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>, 
    Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] platform/x86: lenovo-wmi-other: Balance IDA id
 allocation and free
In-Reply-To: <20260401190221.1595264-2-i@rong.moe>
Message-ID: <6a796411-67b4-943b-f8aa-1e5f6b0b2c97@linux.intel.com>
References: <499fa3efd5be054ffdda77dd00ad4d8d3391e073.camel@rong.moe> <20260401190221.1595264-2-i@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,squebb.ca,gmx.de,lwn.net,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-235405-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 2FCAB3CA6F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026, Rong Zhang wrote:

> Currently, the IDA id is only freed on wmi-other device removal or
> failure to create firmware-attributes device, kset, or attributes. It
> leaks IDA ids if the wmi-other device is bound multiple times, as the
> unbind callback never frees the previously allocated IDA id.
> Additionally, if the wmi-other device has failed to create a
> firmware-attributes device before it gets removed, the wmi-device
> removal callback double frees the same IDA id.
> 
> These bugs were found by sashiko.dev [1].
> 
> Fix them by moving ida_free() into lwmi_om_fw_attr_remove() so it is
> balanced with ida_alloc() in lwmi_om_fw_attr_add(). With them fixed,
> properly set and utilize the validity of priv->ida_id to balance
> firmware-attributes registration and removal, without relying on
> propagating the registration error to the component framework, which is
> more reliable and aligns with the hwmon device registration and removal
> sequences.
> 
> No functional change intended.
> 
> Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gmail.com [1]
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>  drivers/platform/x86/lenovo/wmi-other.c | 34 +++++++++++++++----------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
> index 6040f45aa2b0..b47418df099f 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -957,17 +957,17 @@ static struct capdata01_attr_group cd01_attr_groups[] = {
>  /**
>   * lwmi_om_fw_attr_add() - Register all firmware_attributes_class members
>   * @priv: The Other Mode driver data.
> - *
> - * Return: Either 0, or an error code.
>   */
> -static int lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
> +static void lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
>  {
>  	unsigned int i;
>  	int err;
>  
>  	priv->ida_id = ida_alloc(&lwmi_om_ida, GFP_KERNEL);
> -	if (priv->ida_id < 0)
> -		return priv->ida_id;
> +	if (priv->ida_id < 0) {
> +		err = priv->ida_id;

This looks a bit backwards. It would be better to do:

	err = ida_alloc(&lwmi_om_ida, GFP_KERNEL);
	if (err < 0)
> +		goto err;

	priv->ida_id = err;

...This, btw, tells us why "ret" would have been superior name for the 
generic return variable as it does not carry "error" connotation.

> +	}
>  
>  	priv->fw_attr_dev = device_create(&firmware_attributes_class, NULL,
>  					  MKDEV(0, 0), NULL, "%s-%u",
> @@ -993,7 +993,7 @@ static int lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
>  
>  		cd01_attr_groups[i].tunable_attr->dev = &priv->wdev->dev;
>  	}
> -	return 0;
> +	return;
>  
>  err_remove_groups:
>  	while (i--)
> @@ -1007,7 +1007,12 @@ static int lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
>  
>  err_free_ida:
>  	ida_free(&lwmi_om_ida, priv->ida_id);
> -	return err;
> +
> +err:
> +	priv->ida_id = -EIDRM;
> +
> +	dev_warn(&priv->wdev->dev,
> +		 "failed to register firmware-attributes device: %d\n", err);
>  }
>  
>  /**
> @@ -1016,12 +1021,17 @@ static int lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
>   */
>  static void lwmi_om_fw_attr_remove(struct lwmi_om_priv *priv)
>  {
> +	if (priv->ida_id < 0)
> +		return;
> +
>  	for (unsigned int i = 0; i < ARRAY_SIZE(cd01_attr_groups) - 1; i++)
>  		sysfs_remove_group(&priv->fw_attr_kset->kobj,
>  				   cd01_attr_groups[i].attr_group);
>  
>  	kset_unregister(priv->fw_attr_kset);
>  	device_unregister(priv->fw_attr_dev);
> +	ida_free(&lwmi_om_ida, priv->ida_id);
> +	priv->ida_id = -EIDRM;
>  }
>  
>  /* ======== Self (master: lenovo-wmi-other) ======== */
> @@ -1063,7 +1073,9 @@ static int lwmi_om_master_bind(struct device *dev)
>  
>  	lwmi_om_fan_info_collect_cd00(priv);
>  
> -	return lwmi_om_fw_attr_add(priv);
> +	lwmi_om_fw_attr_add(priv);
> +
> +	return 0;
>  }
>  
>  /**
> @@ -1115,13 +1127,7 @@ static int lwmi_other_probe(struct wmi_device *wdev, const void *context)
>  
>  static void lwmi_other_remove(struct wmi_device *wdev)
>  {
> -	struct lwmi_om_priv *priv = dev_get_drvdata(&wdev->dev);
> -
>  	component_master_del(&wdev->dev, &lwmi_om_master_ops);
> -
> -	/* No IDA to free if the driver is never bound to its components. */
> -	if (priv->ida_id >= 0)
> -		ida_free(&lwmi_om_ida, priv->ida_id);
>  }
>  
>  static const struct wmi_device_id lwmi_other_id_table[] = {
> 

-- 
 i.


