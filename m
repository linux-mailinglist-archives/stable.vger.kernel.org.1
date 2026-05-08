Return-Path: <stable+bounces-244766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD5RMbnz/WlxlAAAu9opvQ
	(envelope-from <stable+bounces-244766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:31:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F41C4F7BE9
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB76730AD7F1
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 14:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04E3F0762;
	Fri,  8 May 2026 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rwfr24X3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE4A3F075C;
	Fri,  8 May 2026 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250316; cv=none; b=le7nYcb9sneBYrVPb7xJF8vLlLlmkI2OL7Zsga7R8iqE3g/M2rr+J483gsBgETZqNYaub8K5zz5ex5BSysBHt60l3cbs0uPkhqk3nkE23dCg6g188o2kLI9NqdfXGIFf4aqITvSvcjy+qGZKn6bBLvWexCqEEwzu4rs6zGwGBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250316; c=relaxed/simple;
	bh=oZMSLwswhn+q+3TDRgkz0ORZfkjyuYA7JjYa4NiNGkI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Doh8qH3MYA+/fUHvTZdShKQlxGT+ikQ3USFUNXjhnF0tFs0QGW9ua9ravP5Z/X6YWotj5DZ4aJXvpiaEBFZzq/6xN8mRKAfpr89+poNXV6bwOnhQUlNtsLCjRyfkFKvAwmF+QSk8YHFiDbwSwrECn9uiJaoJZRndyxvMPQnmma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rwfr24X3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778250315; x=1809786315;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oZMSLwswhn+q+3TDRgkz0ORZfkjyuYA7JjYa4NiNGkI=;
  b=Rwfr24X3AcdRrrKONmik3q2R5Y+zke5v+jtnEH4todYmpBF3UHYGgHsd
   vg9w67g7IrxHDXUNQAe4VHnBPQ5KPJJfByii14o3/YFYTmagYJbnEAWkc
   UuXy+f95XpH29dx3Po8jTmkAa1XkvJcICCeg273U/iHlf5xkhnnPEu4YF
   AEleSdPxrQ7fWMGR/LWtEePrZgGWwDT6nUQgMixR82uOR1v3NNS6mhqZR
   gREsEJ3gVT0RImu35h0UrSx1jSzG23BtjWP31DTiJVC+Hjq6JZ8jFiP3s
   KTqrRmcc7FYqDKnDbjatfMwdi0oBO6066jNmCvC31aqeFIFcPh0nJUlkx
   g==;
X-CSE-ConnectionGUID: X+hOw1uFQli6yFgb3Agwzg==
X-CSE-MsgGUID: 1kRK6YecRy27NN1ZxrEZzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="83090243"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="83090243"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 07:25:14 -0700
X-CSE-ConnectionGUID: gV8dhuIDSyuDR5T49lm4sQ==
X-CSE-MsgGUID: QBOd+mU2SI23PGZD24hERg==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 07:25:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 8 May 2026 17:25:05 +0300 (EEST)
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Hans de Goede <hansg@kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>, 
    Rong Zhang <i@rong.moe>, Kurt Borja <kuurtb@gmail.com>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    =?ISO-8859-15?Q?N=EDcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>, 
    marshall@shzj.cc, hyacinth@shzj.cc, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v11 08/15] platform/x86: lenovo-wmi-other: Add lwmi_attr_id()
 function
In-Reply-To: <20260507180507.912966-9-derekjohn.clark@gmail.com>
Message-ID: <7fedf7a4-f799-21c0-cd44-0e6fc7c65e7d@linux.intel.com>
References: <20260507180507.912966-1-derekjohn.clark@gmail.com> <20260507180507.912966-9-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 1F41C4F7BE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244766-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,rong.moe:email,squebb.ca:email,linux.intel.com:mid]
X-Rspamd-Action: no action

On Thu, 7 May 2026, Derek J. Clark wrote:

> Adds lwmi_attr_id() function. In the same vein as LWMI_ATTR_ID_FAN_RPM(),
> but as a generic, to de-duplicate attribute_id assignment biolerplate.
> 
> Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")

Also for this, I don't think we're actually fixing anything here (but just 
refactoring code which should result exactly the same behavior)?

> Cc: stable@vger.kernel.org
> Reviewed-by: Rong Zhang <i@rong.moe>
> Tested-by: Rong Zhang <i@rong.moe>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
> v11:
>   - Move to earlier in the series to clean up later patches that can
>     use it.
>   - Add helper function that takes a tunable_attr_01 instead of breaking
>     out all struct members manually each time the macro is used.
> v9:
>   - Fix dropped use of mode variable in current_value_show.
> v7:
>   - Incorporate additional replacements in lwmi_attr_01_is_supported
>     after moving the patch that adds it to earlier in the series.
> v6:
>   - Move lwmi_attr_id to wmi-capdata.h as static inline.
> v5:
>   - Move references to cv/cd_mode_id to patch 4/8.
>   - Move lwmi_attr_id to wmi-capdata.c and export with namespace.
> v4:
>   - Switch from macro to static inline to preserve types.
> ---
>  drivers/platform/x86/lenovo/wmi-capdata.c |  8 ++--
>  drivers/platform/x86/lenovo/wmi-capdata.h | 20 +++++++++
>  drivers/platform/x86/lenovo/wmi-other.c   | 49 +++++++++--------------
>  3 files changed, 44 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/platform/x86/lenovo/wmi-capdata.c b/drivers/platform/x86/lenovo/wmi-capdata.c
> index ee1fb02d8e31..169665be4dcf 100644
> --- a/drivers/platform/x86/lenovo/wmi-capdata.c
> +++ b/drivers/platform/x86/lenovo/wmi-capdata.c
> @@ -27,7 +27,6 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/acpi.h>
> -#include <linux/bitfield.h>
>  #include <linux/bug.h>
>  #include <linux/cleanup.h>
>  #include <linux/component.h>
> @@ -48,6 +47,7 @@
>  #include <linux/wmi.h>
>  
>  #include "wmi-capdata.h"
> +#include "wmi-helpers.h"
>  
>  #define LENOVO_CAPABILITY_DATA_00_GUID "362A3AFE-3D96-4665-8530-96DAD5BB300E"
>  #define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE018154"
> @@ -58,9 +58,9 @@
>  
>  #define LWMI_FEATURE_ID_FAN_TEST 0x05
>  
> -#define LWMI_ATTR_ID_FAN_TEST							\
> -	(FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, LWMI_DEVICE_ID_FAN) |		\
> -	 FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, LWMI_FEATURE_ID_FAN_TEST))
> +#define LWMI_ATTR_ID_FAN_TEST                                      \
> +	lwmi_attr_id(LWMI_DEVICE_ID_FAN, LWMI_FEATURE_ID_FAN_TEST, \
> +		     LWMI_GZ_THERMAL_MODE_NONE, LWMI_TYPE_ID_NONE)
>  
>  enum lwmi_cd_type {
>  	LENOVO_CAPABILITY_DATA_00,
> diff --git a/drivers/platform/x86/lenovo/wmi-capdata.h b/drivers/platform/x86/lenovo/wmi-capdata.h
> index 8c1df3efcc55..1388eaf4ab4a 100644
> --- a/drivers/platform/x86/lenovo/wmi-capdata.h
> +++ b/drivers/platform/x86/lenovo/wmi-capdata.h
> @@ -6,6 +6,7 @@
>  #define _LENOVO_WMI_CAPDATA_H_
>  
>  #include <linux/bits.h>
> +#include <linux/bitfield.h>
>  #include <linux/types.h>
>  
>  #define LWMI_SUPP_VALID		BIT(0)
> @@ -19,6 +20,8 @@
>  
>  #define LWMI_DEVICE_ID_FAN	0x04
>  
> +#define LWMI_TYPE_ID_NONE 0x00
> +
>  struct component_match;
>  struct device;
>  struct cd_list;
> @@ -57,6 +60,23 @@ struct lwmi_cd_binder {
>  	cd_list_cb_t cd_fan_list_cb;
>  };
>  
> +/**
> + * lwmi_attr_id() - Formats a capability data attribute ID
> + * @dev_id: The u8 corresponding to the device ID.
> + * @feat_id: The u8 corresponding to the feature ID on the device.
> + * @mode_id: The u8 corresponding to the wmi-gamezone mode for set/get.
> + * @type_id: The u8 corresponding to the sub-device.
> + *
> + * Return: u32.

Kerneldoc knows the type from C syntax. It's more useful to write what 
the returned value is (encoded attribute ID?).

-- 
 i.


> + */
> +static inline u32 lwmi_attr_id(u8 dev_id, u8 feat_id, u8 mode_id, u8 type_id)
> +{
> +	return (FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, dev_id)   |
> +		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, feat_id) |
> +		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode_id) |
> +		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, type_id));
> +}
> +
>  void lwmi_cd_match_add_all(struct device *master, struct component_match **matchptr);
>  int lwmi_cd00_get_data(struct cd_list *list, u32 attribute_id, struct capdata00 *output);
>  int lwmi_cd01_get_data(struct cd_list *list, u32 attribute_id, struct capdata01 *output);
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
> index b4ed7af50a24..e69bea72e6d3 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -59,8 +59,6 @@
>  
>  #define LWMI_FEATURE_ID_FAN_RPM 0x03
>  
> -#define LWMI_TYPE_ID_NONE 0x00
> -
>  #define LWMI_FEATURE_VALUE_GET 17
>  #define LWMI_FEATURE_VALUE_SET 18
>  
> @@ -68,13 +66,12 @@
>  #define LWMI_FAN_NR 4
>  #define LWMI_FAN_ID(x) ((x) + LWMI_FAN_ID_BASE)
>  
> -#define LWMI_ATTR_ID_FAN_RPM(x)						\
> -	(FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, LWMI_DEVICE_ID_FAN) |	\
> -	 FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, LWMI_FEATURE_ID_FAN_RPM) |	\
> -	 FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, LWMI_FAN_ID(x)))
> -
>  #define LWMI_FAN_DIV 100
>  
> +#define LWMI_ATTR_ID_FAN_RPM(x)                                   \
> +	lwmi_attr_id(LWMI_DEVICE_ID_FAN, LWMI_FEATURE_ID_FAN_RPM, \
> +		     LWMI_GZ_THERMAL_MODE_NONE, LWMI_FAN_ID(x))
> +
>  #define LWMI_OM_FW_ATTR_BASE_PATH "lenovo-wmi-other"
>  #define LWMI_OM_HWMON_NAME "lenovo_wmi_other"
>  
> @@ -547,6 +544,18 @@ struct tunable_attr_01 {
>  	u8 type_id;
>  };
>  
> +/**
> + * tunable_attr_01_id() - Formats a tunable_attr_01 to a capdata attribute ID
> + * @attr: The tunable_attr_01 to format.
> + * @mode: The u8 corresponding to the wmi-gamezone mode for set/get.
> + *
> + * Return: u32.
> + */
> +static u32 tunable_attr_01_id(struct tunable_attr_01 *attr, u8 mode)
> +{
> +	return lwmi_attr_id(attr->device_id, attr->feature_id, mode, attr->type_id);
> +}
> +
>  static struct tunable_attr_01 ppt_pl1_spl = {
>  	.device_id = LWMI_DEVICE_ID_CPU,
>  	.feature_id = LWMI_FEATURE_ID_CPU_SPL,
> @@ -614,12 +623,7 @@ static ssize_t attr_capdata01_show(struct kobject *kobj,
>  	u32 attribute_id;
>  	int value, ret;
>  
> -	attribute_id =
> -		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> -		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> -		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK,
> -			   LWMI_GZ_THERMAL_MODE_CUSTOM) |
> -		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> +	attribute_id = tunable_attr_01_id(tunable_attr, LWMI_GZ_THERMAL_MODE_CUSTOM);
>  
>  	ret = lwmi_cd01_get_data(priv->cd01_list, attribute_id, &capdata);
>  	if (ret)
> @@ -674,7 +678,6 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
>  	struct wmi_method_args_32 args = {};
>  	struct capdata01 capdata;
>  	enum thermal_mode mode;
> -	u32 attribute_id;
>  	u32 value;
>  	int ret;
>  
> @@ -685,13 +688,9 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
>  	if (mode != LWMI_GZ_THERMAL_MODE_CUSTOM)
>  		return -EBUSY;
>  
> -	attribute_id =
> -		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> -		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> -		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> -		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> +	args.arg0 = tunable_attr_01_id(tunable_attr, mode);
>  
> -	ret = lwmi_cd01_get_data(priv->cd01_list, attribute_id, &capdata);
> +	ret = lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata);
>  	if (ret)
>  		return ret;
>  
> @@ -702,7 +701,6 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
>  	if (value < capdata.min_value || value > capdata.max_value)
>  		return -EINVAL;
>  
> -	args.arg0 = attribute_id;
>  	args.arg1 = value;
>  
>  	ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_SET,
> @@ -736,7 +734,6 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
>  	struct lwmi_om_priv *priv = dev_get_drvdata(tunable_attr->dev);
>  	struct wmi_method_args_32 args = {};
>  	enum thermal_mode mode;
> -	u32 attribute_id;
>  	int retval;
>  	int ret;
>  
> @@ -744,13 +741,7 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
>  	if (ret)
>  		return ret;
>  
> -	attribute_id =
> -		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> -		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> -		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> -		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> -
> -	args.arg0 = attribute_id;
> +	args.arg0 = tunable_attr_01_id(tunable_attr, mode);
>  
>  	ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_GET,
>  				    (unsigned char *)&args, sizeof(args),
> 

