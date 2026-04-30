Return-Path: <stable+bounces-242131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBH+Jwhh82le2AEAu9opvQ
	(envelope-from <stable+bounces-242131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:02:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 097AC4A3CFA
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B3803010171
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECFE429838;
	Thu, 30 Apr 2026 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFYZpfeW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925C142DFEA;
	Thu, 30 Apr 2026 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557728; cv=none; b=uxkAeoeA20dgBc8bpJiZqDhqJ7HvtEgDuPOawD9a1HgMATYmJ5Sensh0T0rpewPFbZCWTaivo7I3uA8SkfffRs/TfCX6+H8Q9R/pdxlmqhBEOxKyHygtAcyy6WBlEeYMbMEBSqGOC1q4PFz+iLL/+XmjW/eUPkDItNN6dBBtW3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557728; c=relaxed/simple;
	bh=5QSG+V0swYPKNFUdYJa00lVGXlMiwC+fdziDH3PEuN4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sYj33O4lD8kqRIW2Zm9V1VEVovYJHd88/Wg8jAgwHl3VdTtqUJxTO142xf8bsV1oBvsWG+a2r559dr54JfAFtlpcuCGmN+8MbqGk54kwXhpyPPid7CSGiZeEGrSxGM4Gg1+9qQuUz0lpkikepH/jXLUnV/dkLHJpmPFx7HqellY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFYZpfeW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777557725; x=1809093725;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5QSG+V0swYPKNFUdYJa00lVGXlMiwC+fdziDH3PEuN4=;
  b=oFYZpfeW9WXxPNZS2xccDqyb4PwYncpy4d1WI3MsW5h1eHgqI8D8VOLw
   RTuArJzmm4Rvy7FMs2e9gS3eEWtfTVrsVNsR1dj3ms9ow0R37TWHmMGVY
   GFCX5la46aKJl9W/Rt4K3n1u+FbInZlQZ1dNgGfeB6m0+dfo9JugMZf6+
   mYNakF4ZCA0lITsxGIYqLJV8Gsyy4alxbkMCirV2Bg8PCYe6iCSfCkICR
   QB9JDRuj7dGQUBnetALc1OFFaF1eYmYF0YWI3fW5GvcRbaGyZtZY7K5kz
   eEHvOUboUvr3hPOA4K6OiqENuZ4eMkhwI6P7jiFX6fvi7DAG1hmOMczAy
   Q==;
X-CSE-ConnectionGUID: 6a+Li8/cSXiAmUXCykYNVA==
X-CSE-MsgGUID: QjmIgjliRAeAM5XZTSIs+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="78611471"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78611471"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 07:02:03 -0700
X-CSE-ConnectionGUID: Gm3sGjn6QcuzpA9Pj+A8pQ==
X-CSE-MsgGUID: qiTu4s48RY+/BllMmlKs7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="234853641"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 07:01:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 30 Apr 2026 17:01:55 +0300 (EEST)
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Hans de Goede <hansg@kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>, 
    Rong Zhang <i@rong.moe>, Kurt Borja <kuurtb@gmail.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v10 06/16] platform/x86: lenovo-wmi-other: Limit adding
 attributes to supported devices
In-Reply-To: <20260412211121.2220556-7-derekjohn.clark@gmail.com>
Message-ID: <1ce1d6f6-9196-c8a1-913d-4bdec2b1af80@linux.intel.com>
References: <20260412211121.2220556-1-derekjohn.clark@gmail.com> <20260412211121.2220556-7-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 097AC4A3CFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-242131-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rong.moe:email,squebb.ca:email,linux.intel.com:mid,intel.com:dkim]

On Sun, 12 Apr 2026, Derek J. Clark wrote:

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
>  drivers/platform/x86/lenovo/wmi-gamezone.h |   1 +
>  drivers/platform/x86/lenovo/wmi-other.c    | 114 ++++++++++++++++++---
>  2 files changed, 98 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.h b/drivers/platform/x86/lenovo/wmi-gamezone.h
> index 6b163a5eeb95..ddb919cf6c36 100644
> --- a/drivers/platform/x86/lenovo/wmi-gamezone.h
> +++ b/drivers/platform/x86/lenovo/wmi-gamezone.h
> @@ -10,6 +10,7 @@ enum gamezone_events_type {
>  };
>  
>  enum thermal_mode {
> +	LWMI_GZ_THERMAL_MODE_NONE =	   0x00,
>  	LWMI_GZ_THERMAL_MODE_QUIET =	   0x01,
>  	LWMI_GZ_THERMAL_MODE_BALANCED =	   0x02,
>  	LWMI_GZ_THERMAL_MODE_PERFORMANCE = 0x03,
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
> index 50a03f5fd6ab..29d062a1c6dc 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -550,6 +550,8 @@ struct tunable_attr_01 {
>  	u8 feature_id;
>  	u8 device_id;
>  	u8 type_id;
> +	u8 cd_mode_id; /* mode arg for searching capdata */
> +	u8 cv_mode_id; /* mode arg for set/get current_value */
>  };
>  
>  static struct tunable_attr_01 ppt_pl1_spl = {
> @@ -775,7 +777,6 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
>  	struct wmi_method_args_32 args = {};
>  	struct capdata01 capdata;
>  	enum thermal_mode mode;
> -	u32 attribute_id;
>  	u32 value;
>  	int ret;
>  
> @@ -786,13 +787,12 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
>  	if (mode != LWMI_GZ_THERMAL_MODE_CUSTOM)
>  		return -EBUSY;
>  
> -	attribute_id =
> -		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> -		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> -		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> -		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> +	args.arg0 = FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cd_mode_id) |
> +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>  
> -	ret = lwmi_cd01_get_data(priv->cd01_list, attribute_id, &capdata);
> +	ret = lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata);
>  	if (ret)
>  		return ret;
>  
> @@ -803,7 +803,10 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
>  	if (value < capdata.min_value || value > capdata.max_value)
>  		return -EINVAL;
>  
> -	args.arg0 = attribute_id;
> +	args.arg0 = FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cv_mode_id) |
> +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);

It's already repeated a few times and you're adding more in this patch.

We should have a helper function for this encoding as it seems to 
repeat. That is, something that takes tunable_attr and mode as input
(the conversion of existing entries should be in own patch preceeding 
this fix patch).

>  	args.arg1 = value;
>  
>  	ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_SET,
> @@ -837,7 +840,6 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
>  	struct lwmi_om_priv *priv = dev_get_drvdata(tunable_attr->dev);
>  	struct wmi_method_args_32 args = {};
>  	enum thermal_mode mode;
> -	u32 attribute_id;
>  	int retval;
>  	int ret;
>  
> @@ -845,13 +847,14 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
>  	if (ret)
>  		return ret;
>  
> -	attribute_id =
> -		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> -		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> -		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> -		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> +	/* If "no-mode" is the supported mode, ensure we never send current mode */
> +	if (tunable_attr->cv_mode_id == LWMI_GZ_THERMAL_MODE_NONE)
> +		mode = tunable_attr->cv_mode_id;
>  
> -	args.arg0 = attribute_id;
> +	args.arg0 = FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>  
>  	ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_GET,
>  				    (unsigned char *)&args, sizeof(args),
> @@ -862,6 +865,81 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
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
> + *
> + * The probed cd_mode_id/cv_mode_id are stored on the tunable_attr for later
> + * reference.
> + *
> + * Return: bool.
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
> +	for (i = 0; i < ARRAY_SIZE(modes); i++) {
> +		args.arg0 = FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> +			    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> +			    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, modes[i]) |
> +			    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> +
> +		ret = lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata);
> +		if (ret || !capdata.supported)
> +			continue;
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
> +	for (i = 0; i < ARRAY_SIZE(modes); i++) {
> +		args.arg0 = FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> +			    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> +			    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, modes[i]) |
> +			    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> +
> +		ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_GET,
> +					    (unsigned char *)&args, sizeof(args),
> +					    &retval);
> +		if (ret || !retval)
> +			continue;
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
> +}
> +
>  /* Lenovo WMI Other Mode Attribute macros */
>  #define __LWMI_ATTR_RO(_func, _name)                                  \
>  	{                                                             \
> @@ -985,12 +1063,14 @@ static void lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
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


