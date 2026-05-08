Return-Path: <stable+bounces-244767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ELDCzfz/WlxlAAAu9opvQ
	(envelope-from <stable+bounces-244767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:29:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 998834F7BAC
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29C57301D335
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 14:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2053F1670;
	Fri,  8 May 2026 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEu4bkWs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689D3EF0AD;
	Fri,  8 May 2026 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250529; cv=none; b=Sqgz8PHwcHOKzZu0qDKOAKTEhzDRp22CnY1bH4Ndrky2hm4fIDM44HpdGdaQbf0sY2FU14YqVH/LLNERU0AdEs5KOtlhUhrRq2hTYdJ7dSxeiRd7EpLCipUqzNrwV5c4NiaMwVkx8XkyimAbGCUK0C5WCqv9gc34kY2FmQSoIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250529; c=relaxed/simple;
	bh=EYqIeX6Ax2KzfJQrDZq4E5dZnT83fHNJXJvARIvXH0s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C+QtQPpPIHHXyYpIILm7KyCGMopvZRLCxDb1sytzd3FhVXN1/sRBv+pWLZPUeSyHHh0lFbzPma5pYNrsaOT5vWa/ybuMiW27int7kfp9VukxwOrsX8BbPzQ2y8OQJwKVESSg7HZShVlRcThzySz0dSFu63qnWqgH3iPtoTcRxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEu4bkWs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778250527; x=1809786527;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EYqIeX6Ax2KzfJQrDZq4E5dZnT83fHNJXJvARIvXH0s=;
  b=UEu4bkWsdKglKTwyEBT5RWM4QeuL4eBgp0buxj3e9r6axCz0SKHfmnaj
   SBgF9VN3k6QIHllCYqz9tW8W0CcnjocBQF5Ue1Ps1qLshATTkyo/E294r
   TEGAhRRwOCc4E7L2RvWmhS8I4uG9heEEqtAixqxCoXte+xdop9ZDtXaiv
   gbBvCIAKkxwF6MHCeztHK+XlHnEgaISre4ZhEFWYXtS4XSiyK1Z3ASr8R
   DZeEmc1PDK3/StIaRxMtxd6zc6qnhbTA0Td3ypIai8JFn72JOURYEuSbq
   2ybH9Uw5YY+sV4otldT5eDdSGhN/au7a5sbjQRQ6cobZ+SVlzl0pyR/DW
   A==;
X-CSE-ConnectionGUID: Hdr0N7YaS+atcGIWcrXEgQ==
X-CSE-MsgGUID: Rf7VkVusSGaZvCN9Hkht5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="78240430"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="78240430"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 07:28:46 -0700
X-CSE-ConnectionGUID: lHtuCv5ZShCM3rUouPB+xQ==
X-CSE-MsgGUID: zM9vycEfSVqkx0mCGFE53w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="235950028"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 07:28:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 8 May 2026 17:28:38 +0300 (EEST)
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Hans de Goede <hansg@kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>, 
    Rong Zhang <i@rong.moe>, Kurt Borja <kuurtb@gmail.com>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    =?ISO-8859-15?Q?N=EDcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>, 
    marshall@shzj.cc, hyacinth@shzj.cc, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v11 09/15] platform/x86: lenovo-wmi-other: Limit adding
 attributes to supported devices
In-Reply-To: <20260507180507.912966-10-derekjohn.clark@gmail.com>
Message-ID: <e33cbf52-0485-b181-0258-33cd0877bfb7@linux.intel.com>
References: <20260507180507.912966-1-derekjohn.clark@gmail.com> <20260507180507.912966-10-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 998834F7BAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244767-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rong.moe:email,intel.com:dkim,squebb.ca:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Action: no action

On Thu, 7 May 2026, Derek J. Clark wrote:

> Adds lwmi_is_attr_01_supported, and only creates the attribute subfolder
> if the attribute is supported by the hardware. Due to some poorly
> implemented BIOS this is a multi-step sequence of events. This is
> because:
> - Some BIOS support getting the capability data from custom mode (0xff),
>   while others only support it in no-mode (0x00).
> - Some BIOS support get/set for the current value from custom mode (0xff),
>   while others only support it in no-mode (0x00).
> - Some BIOS report capability data for a method that is not fully
>   implemented.
> - Some BIOS have methods fully implemented, but no complimentary
>   capability data.
> 
> To ensure we only expose fully implemented methods with corresponding
> capability data, we check each outcome before reporting that an
> attribute can be supported.
> 
> Checking for lwmi_is_attr_01_supported during remove is not done to
> ensure that we don't attempt to call cd01 or send WMI events if one of
> the interfaces being removed was the cause of the driver unloading.
> 
> Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
> Reported-by: Kurt Borja <kuurtb@gmail.com>
> Closes: https://lore.kernel.org/platform-driver-x86/DG60P3SHXR8H.3NSEHMZ6J7XRC@gmail.com/
> Cc: stable@vger.kernel.org
> Reviewed-by: Rong Zhang <i@rong.moe>
> Tested-by: Rong Zhang <i@rong.moe>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
> v11:
>   - Also use cd_mode_id in attr_capdata_show.
> v7:
>   - Move earlier in the series. This required dropping the use of
>     lwmi_attr_id as it will be added later.
>   - Add missing switch between cd_mode_id and cv_mode_id in
>     current_value_store.
> v6:
>   - Zero initialize args in lwmi_is_attr_01_supported.
>   - Fix formatting.
> v5:
>   - Move cv/cd_mode_id refrences from path 3/4.
>   - Add missing import for ARRAY_SIZE.
>   - Make lwmi_is_attr_01_supported return bool instead of u32.
>   - Various formatting fixes.
> v4:
>   - Use for loop instead of backtrace gotos for checking if an attribute
>     is supported.
>   - Add include for dev_printk.
>   - Wrap dev_dbg in lwmi_is_attr_01_supported earlier.
>   - Don't use symmetric cleanup of attributes in error states.
> ---
>  drivers/platform/x86/lenovo/wmi-other.c | 86 +++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
> index e69bea72e6d3..e3cdcd0f4331 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -542,6 +542,8 @@ struct tunable_attr_01 {
>  	u8 feature_id;
>  	u8 device_id;
>  	u8 type_id;
> +	u8 cd_mode_id; /* mode arg for searching capdata */
> +	u8 cv_mode_id; /* mode arg for set/get current_value */
>  };
>  
>  /**
> @@ -623,7 +625,7 @@ static ssize_t attr_capdata01_show(struct kobject *kobj,
>  	u32 attribute_id;
>  	int value, ret;
>  
> -	attribute_id = tunable_attr_01_id(tunable_attr, LWMI_GZ_THERMAL_MODE_CUSTOM);
> +	attribute_id = tunable_attr_01_id(tunable_attr, tunable_attr->cd_mode_id);
>  
>  	ret = lwmi_cd01_get_data(priv->cd01_list, attribute_id, &capdata);
>  	if (ret)
> @@ -688,7 +690,7 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
>  	if (mode != LWMI_GZ_THERMAL_MODE_CUSTOM)
>  		return -EBUSY;
>  
> -	args.arg0 = tunable_attr_01_id(tunable_attr, mode);
> +	args.arg0 = tunable_attr_01_id(tunable_attr, tunable_attr->cd_mode_id);
>  
>  	ret = lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata);
>  	if (ret)
> @@ -701,6 +703,7 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
>  	if (value < capdata.min_value || value > capdata.max_value)
>  		return -EINVAL;
>  
> +	args.arg0 = tunable_attr_01_id(tunable_attr, tunable_attr->cv_mode_id);
>  	args.arg1 = value;
>  
>  	ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_SET,
> @@ -741,6 +744,10 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
>  	if (ret)
>  		return ret;
>  
> +	/* If "no-mode" is the supported mode, ensure we never send current mode */
> +	if (tunable_attr->cv_mode_id == LWMI_GZ_THERMAL_MODE_NONE)
> +		mode = tunable_attr->cv_mode_id;
> +
>  	args.arg0 = tunable_attr_01_id(tunable_attr, mode);
>  
>  	ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_GET,
> @@ -752,6 +759,75 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
>  	return sysfs_emit(buf, "%d\n", retval);
>  }
>  
> +/**
> + * lwmi_attr_01_is_supported() - Determine if the given attribute is supported.
> + * @tunable_attr: The attribute to verify.
> + *
> + * First check if the attribute has a corresponding capdata01 table in the cd01
> + * module under the "custom" mode (0xff). If that is not present then check if
> + * there is a corresponding "no-mode" (0x00) entry. If either of those passes,
> + * check capdata->supported for values > 0. If capdata is available, attempt to
> + * determine the set/get mode for the current value property using a similar
> + * pattern. If the value returned by either custom or no-mode is 0, or we get
> + * an error, we assume that mode is not supported. If any of the above checks
> + * fail then the attribute is not fully supported.

Can you try to split this into 2-3 paragraphs. It has the long wall of 
text feel as is.

> + *
> + * The probed cd_mode_id/cv_mode_id are stored on the tunable_attr for later
> + * reference.
> + *
> + * Return: bool.

Describe what is returned, not its type (that is know to kerneldoc from 
syntax).

> + */
> +static bool lwmi_attr_01_is_supported(struct tunable_attr_01 *tunable_attr)
> +{
> +	u8 modes[2] = { LWMI_GZ_THERMAL_MODE_CUSTOM, LWMI_GZ_THERMAL_MODE_NONE };
> +	struct lwmi_om_priv *priv = dev_get_drvdata(tunable_attr->dev);
> +	struct wmi_method_args_32 args = {};
> +	bool cd_mode_found = false;
> +	bool cv_mode_found = false;
> +	struct capdata01 capdata;
> +	int retval, ret, i;
> +
> +	/* Determine tunable_attr->cd_mode_id*/

Missing space.

> +	for (i = 0; i < ARRAY_SIZE(modes); i++) {
> +		args.arg0 = tunable_attr_01_id(tunable_attr, modes[i]);
> +
> +		ret = lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata);
> +		if (ret || !capdata.supported)
> +			continue;

I'd add empty lines here to help.

> +		tunable_attr->cd_mode_id = modes[i];
> +		cd_mode_found = true;
> +		break;
> +	}
> +
> +	if (!cd_mode_found)
> +		return cd_mode_found;
> +
> +	dev_dbg(tunable_attr->dev,
> +		"cd_mode_id: %#010x\n", args.arg0);
> +
> +	/* Determine tunable_attr->cv_mode_id, returns 1 if supported*/

Missing space.

> +	for (i = 0; i < ARRAY_SIZE(modes); i++) {
> +		args.arg0 = tunable_attr_01_id(tunable_attr, modes[i]);
> +
> +		ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_GET,
> +					    (unsigned char *)&args, sizeof(args),
> +					    &retval);
> +		if (ret || !retval)
> +			continue;

Empty line here as well.

> +		tunable_attr->cv_mode_id = modes[i];
> +		cv_mode_found = true;
> +		break;
> +	}
> +
> +	if (!cv_mode_found)
> +		return cv_mode_found;
> +
> +	dev_dbg(tunable_attr->dev, "cv_mode_id: %#010x, attribute support level: %#010x\n",
> +		args.arg0, capdata.supported);
> +
> +	return capdata.supported > 0 ? true : false;

This is enough when the function returns bool:

return capdata.supported > 0;

> +}
> +
>  /* Lenovo WMI Other Mode Attribute macros */
>  #define __LWMI_ATTR_RO(_func, _name)                                  \
>  	{                                                             \
> @@ -875,12 +951,14 @@ static void lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(cd01_attr_groups) - 1; i++) {
> +		cd01_attr_groups[i].tunable_attr->dev = &priv->wdev->dev;
> +		if (!lwmi_attr_01_is_supported(cd01_attr_groups[i].tunable_attr))
> +			continue;
> +
>  		err = sysfs_create_group(&priv->fw_attr_kset->kobj,
>  					 cd01_attr_groups[i].attr_group);
>  		if (err)
>  			goto err_remove_groups;
> -
> -		cd01_attr_groups[i].tunable_attr->dev = &priv->wdev->dev;
>  	}
>  	return;
>  
> 

-- 
 i.


