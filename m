Return-Path: <stable+bounces-230638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IyZLrppxmmkJwUAu9opvQ
	(envelope-from <stable+bounces-230638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:27:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 203143436EF
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF03B308F3D3
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EF73DB64B;
	Fri, 27 Mar 2026 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEATuIPt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971C3B777A;
	Fri, 27 Mar 2026 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774610751; cv=none; b=Da/di1lgoaDAKjuSu8WkvYMpXpMo+sjQ6/tHjF1olDyOHWKJMU6eFtbs6ZbDZ5foY4zg2znhc1sbELsBRPtyOU/BjBPQcXEG/K2zdHmGu6nTPwL0NOvI2hNQTwj9Hw43pNyiMi9rK+GzkbztO5WEkJjaE+zoj6aGo6omBIIS5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774610751; c=relaxed/simple;
	bh=M2loDaZhXemNpvWsIo1YybavRQNIUtIs+a5uaBhfFic=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XmT5v/5V1Lzr2tFAcbkdbT6Jsu5v1U+fYVLwjGB3ONx7P+MZzkU9LNr9I5xyhNREbXkn2AHHg9etsPETf4kli+xz1XkMW1lbuSmGf6aD0KiUqmKKNt4HpuMhcvBSvmQSHb2jqTrlhBPQe8FrjgqRLXLBgVATfwPY+sl8Y0fhdQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEATuIPt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774610747; x=1806146747;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=M2loDaZhXemNpvWsIo1YybavRQNIUtIs+a5uaBhfFic=;
  b=oEATuIPtVIpgvZXP1K0xi6wVKiJpTsvVEpxDPfD94TxrBSvQUQwONif/
   lrUc6nIr+JxDt23LLeVuhsC1HBvoSLjKsdA49dqUJmI9AtL3d/zwlUoG6
   MAXagmPHb8wGw2hQ2S7s6lZi8L8PXFlQus4ZiOu0GGmMv8IKNNiqUcBnE
   vOqzyqMfkbdcbNrh2jA5QO5f66RzqDHkxPHzLBD/rp6kH29bc3w5I19Lu
   zsnSGjBO0TGaU+iQYOr+8D6FXCTDqDMQl8fseg741+JiAJdPwGl9G86bM
   f38SzdiHnjs7Y7OuTRVTwdp+LDVwTpUotGOWIa0zCj5aCHOaQhVGOK/5a
   Q==;
X-CSE-ConnectionGUID: 3jrbT6SrTzSFNQExUOWlYQ==
X-CSE-MsgGUID: iS78pqpAQ7KhMl/WFJ2sEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75563047"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="75563047"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 04:25:46 -0700
X-CSE-ConnectionGUID: l+r004jqRmOYUu9jWAW/fg==
X-CSE-MsgGUID: EZkUO/mvQROmXER8fL+1/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="224331225"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 04:25:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 27 Mar 2026 13:25:37 +0200 (EET)
To: Rong Zhang <i@rong.moe>
cc: Derek John Clark <derekjohn.clark@gmail.com>, 
    Hans de Goede <hansg@kernel.org>, oe-kbuild-all@lists.linux.dev, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
    Jonathan Corbet <corbet@lwn.net>, Kurt Borja <kuurtb@gmail.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: lenovo: Decouple lenovo-wmi-gamezone and
 lenovo-wmi-other
In-Reply-To: <20260326161724.72186-1-i@rong.moe>
Message-ID: <d824bf55-8c1a-1374-04f9-aff9ffdaaa0d@linux.intel.com>
References: <861d0276a759461be446df8e996d196037c9b581.camel@rong.moe> <20260326161724.72186-1-i@rong.moe>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.linux.dev,squebb.ca,gmx.de,lwn.net,vger.kernel.org,intel.com];
	TAGGED_FROM(0.00)[bounces-230638-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: 203143436EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026, Rong Zhang wrote:

> Currently, lenovo-wmi-gamezone depends on lenovo-wmi-other as the former
> imports symbols from the latter. The imported symbols are just used to
> register a notifier block. However, there is no runtime dependency
> between both drivers, and either of them can run without the other,
> which is the major purpose of using the notifier framework.
> 
> Such a link-time dependency is non-optimal. A previous attempt to "fix"
> it made LENOVO_WMI_GAMEZONE select LENOVO_WMI_TUNING, which was
> fundamentally broken and resulted in undefined Kconfig behavior, as
> `select' cannot be used on a symbol with potentially unmet dependencies.
> 
> Decouple both drivers by moving the thermal mode notifier chain to
> lenovo-wmi-helpers. Methods for notifier block (un)registration are
> exported for lenovo-wmi-gamezone, while a method for querying the
> current thermal mode are exported for lenovo-wmi-other.
> 
> This turns the dependency graph from
> 
>             +------------ lenovo-wmi-gamezone
>             |                     |
>             v                     |
>     lenovo-wmi-helpers            |
>             ^                     |
>             |                     V
>             +------------ lenovo-wmi-other
> 
> into
> 
>             +------------ lenovo-wmi-gamezone
>             |
>             v
>     lenovo-wmi-helpers
>             ^
>             |
>             +------------ lenovo-wmi-other
> 
> To make it clear, the name of the notifier chain is also renamed from
> `om_chain_head' to `tm_chain_head', indicating that it's used to query
> the current thermal mode.
> 
> No functional change intended.
> 
> Fixes: 6e38b9fcbfa3 ("platform/x86: lenovo: gamezone needs "other mode"")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603252259.gHvJDyh3-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202603260302.X0NjQOda-lkp@intel.com/
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>  drivers/platform/x86/lenovo/Kconfig        |   1 -
>  drivers/platform/x86/lenovo/wmi-gamezone.c |   4 +-
>  drivers/platform/x86/lenovo/wmi-helpers.c  | 102 ++++++++++++++++++++
>  drivers/platform/x86/lenovo/wmi-helpers.h  |   8 ++
>  drivers/platform/x86/lenovo/wmi-other.c    | 104 +--------------------
>  drivers/platform/x86/lenovo/wmi-other.h    |  16 ----
>  6 files changed, 113 insertions(+), 122 deletions(-)
>  delete mode 100644 drivers/platform/x86/lenovo/wmi-other.h
> 
> diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x86/lenovo/Kconfig
> index f885127b007f..09b1b055d2e0 100644
> --- a/drivers/platform/x86/lenovo/Kconfig
> +++ b/drivers/platform/x86/lenovo/Kconfig
> @@ -252,7 +252,6 @@ config LENOVO_WMI_GAMEZONE
>  	select ACPI_PLATFORM_PROFILE
>  	select LENOVO_WMI_EVENTS
>  	select LENOVO_WMI_HELPERS
> -	select LENOVO_WMI_TUNING
>  	help
>  	  Say Y here if you have a WMI aware Lenovo Legion device and would like to use the
>  	  platform-profile firmware interface to manage power usage.
> diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
> index c7fe7e3c9f17..92020225db27 100644
> --- a/drivers/platform/x86/lenovo/wmi-gamezone.c
> +++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
> @@ -23,7 +23,6 @@
>  #include "wmi-events.h"
>  #include "wmi-gamezone.h"
>  #include "wmi-helpers.h"
> -#include "wmi-other.h"
>  
>  #define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
>  
> @@ -383,7 +382,7 @@ static int lwmi_gz_probe(struct wmi_device *wdev, const void *context)
>  		return ret;
>  
>  	priv->mode_nb.notifier_call = lwmi_gz_mode_call;
> -	return devm_lwmi_om_register_notifier(&wdev->dev, &priv->mode_nb);
> +	return devm_lwmi_tm_register_notifier(&wdev->dev, &priv->mode_nb);
>  }
>  
>  static const struct wmi_device_id lwmi_gz_id_table[] = {
> @@ -405,7 +404,6 @@ module_wmi_driver(lwmi_gz_driver);
>  
>  MODULE_IMPORT_NS("LENOVO_WMI_EVENTS");
>  MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
> -MODULE_IMPORT_NS("LENOVO_WMI_OTHER");
>  MODULE_DEVICE_TABLE(wmi, lwmi_gz_id_table);
>  MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>  MODULE_DESCRIPTION("Lenovo GameZone WMI Driver");
> diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/platform/x86/lenovo/wmi-helpers.c
> index 7379defac500..5a88bccb5037 100644
> --- a/drivers/platform/x86/lenovo/wmi-helpers.c
> +++ b/drivers/platform/x86/lenovo/wmi-helpers.c
> @@ -21,11 +21,16 @@
>  #include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
> +#include <linux/notifier.h>
>  #include <linux/unaligned.h>
>  #include <linux/wmi.h>
>  
> +#include "wmi-gamezone.h"
>  #include "wmi-helpers.h"
>  
> +/* Thermal mode notifier chain. */
> +static BLOCKING_NOTIFIER_HEAD(tm_chain_head);
> +
>  /**
>   * lwmi_dev_evaluate_int() - Helper function for calling WMI methods that
>   * return an integer.
> @@ -84,6 +89,103 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
>  };
>  EXPORT_SYMBOL_NS_GPL(lwmi_dev_evaluate_int, "LENOVO_WMI_HELPERS");
>  
> +/**
> + * lwmi_tm_register_notifier() - Add a notifier to the blocking notifier chain
> + * @nb: The notifier_block struct to register
> + *
> + * Call blocking_notifier_chain_register to register the notifier block to the
> + * thermal mode notifier chain.
> + *
> + * Return: 0 on success, %-EEXIST on error.
> + */
> +int lwmi_tm_register_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&tm_chain_head, nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(lwmi_tm_register_notifier, "LENOVO_WMI_HELPERS");
> +
> +/**
> + * lwmi_tm_unregister_notifier() - Remove a notifier from the blocking notifier
> + * chain.
> + * @nb: The notifier_block struct to register
> + *
> + * Call blocking_notifier_chain_unregister to unregister the notifier block from the
> + * thermal mode notifier chain.
> + *
> + * Return: 0 on success, %-ENOENT on error.
> + */
> +int lwmi_tm_unregister_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&tm_chain_head, nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(lwmi_tm_unregister_notifier, "LENOVO_WMI_HELPERS");
> +
> +/**
> + * devm_lwmi_tm_unregister_notifier() - Remove a notifier from the blocking
> + * notifier chain.
> + * @data: Void pointer to the notifier_block struct to register.
> + *
> + * Call lwmi_tm_unregister_notifier to unregister the notifier block from the
> + * thermal mode notifier chain.
> + *
> + * Return: 0 on success, %-ENOENT on error.
> + */
> +static void devm_lwmi_tm_unregister_notifier(void *data)
> +{
> +	struct notifier_block *nb = data;
> +
> +	lwmi_tm_unregister_notifier(nb);
> +}
> +
> +/**
> + * devm_lwmi_tm_register_notifier() - Add a notifier to the blocking notifier
> + * chain.
> + * @dev: The parent device of the notifier_block struct.
> + * @nb: The notifier_block struct to register
> + *
> + * Call lwmi_tm_register_notifier to register the notifier block to the
> + * thermal mode notifier chain. Then add devm_lwmi_tm_unregister_notifier
> + * as a device managed action to automatically unregister the notifier block
> + * upon parent device removal.
> + *
> + * Return: 0 on success, or an error code.
> + */
> +int devm_lwmi_tm_register_notifier(struct device *dev,
> +				   struct notifier_block *nb)
> +{
> +	int ret;
> +
> +	ret = lwmi_tm_register_notifier(nb);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, devm_lwmi_tm_unregister_notifier,
> +					nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_lwmi_tm_register_notifier, "LENOVO_WMI_HELPERS");
> +
> +/**
> + * lwmi_tm_notifier_call() - Call functions for the notifier call chain.
> + * @mode: Pointer to a thermal mode enum to retrieve the data from.
> + *
> + * Call blocking_notifier_call_chain to retrieve the thermal mode from the
> + * lenovo-wmi-gamezone driver.
> + *
> + * Return: 0 on success, or an error code.
> + */
> +int lwmi_tm_notifier_call(enum thermal_mode *mode)
> +{
> +	int ret;
> +
> +	ret = blocking_notifier_call_chain(&tm_chain_head,
> +					   LWMI_GZ_GET_THERMAL_MODE, &mode);
> +	if ((ret & ~NOTIFY_STOP_MASK) != NOTIFY_OK)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(lwmi_tm_notifier_call, "LENOVO_WMI_HELPERS");
> +
>  MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>  MODULE_DESCRIPTION("Lenovo WMI Helpers Driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/lenovo/wmi-helpers.h b/drivers/platform/x86/lenovo/wmi-helpers.h
> index 20fd21749803..651a039228ed 100644
> --- a/drivers/platform/x86/lenovo/wmi-helpers.h
> +++ b/drivers/platform/x86/lenovo/wmi-helpers.h
> @@ -7,6 +7,8 @@
>  
>  #include <linux/types.h>
>  
> +struct device;
> +struct notifier_block;
>  struct wmi_device;
>  
>  struct wmi_method_args_32 {
> @@ -17,4 +19,10 @@ struct wmi_method_args_32 {
>  int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
>  			  unsigned char *buf, size_t size, u32 *retval);
>  
> +int lwmi_tm_register_notifier(struct notifier_block *nb);
> +int lwmi_tm_unregister_notifier(struct notifier_block *nb);
> +int devm_lwmi_tm_register_notifier(struct device *dev,
> +				   struct notifier_block *nb);
> +int lwmi_tm_notifier_call(enum thermal_mode *mode);

This enum is not introduced earlier within this header?

-- 
 i.

> +
>  #endif /* !_LENOVO_WMI_HELPERS_H_ */
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
> index 6040f45aa2b0..b394cc8168a6 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -40,7 +40,6 @@
>  #include <linux/kobject.h>
>  #include <linux/limits.h>
>  #include <linux/module.h>
> -#include <linux/notifier.h>
>  #include <linux/platform_profile.h>
>  #include <linux/types.h>
>  #include <linux/wmi.h>
> @@ -49,7 +48,6 @@
>  #include "wmi-events.h"
>  #include "wmi-gamezone.h"
>  #include "wmi-helpers.h"
> -#include "wmi-other.h"
>  #include "../firmware_attributes_class.h"
>  
>  #define LENOVO_OTHER_MODE_GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B"
> @@ -81,7 +79,6 @@
>  #define LWMI_OM_FW_ATTR_BASE_PATH "lenovo-wmi-other"
>  #define LWMI_OM_HWMON_NAME "lenovo_wmi_other"
>  
> -static BLOCKING_NOTIFIER_HEAD(om_chain_head);
>  static DEFINE_IDA(lwmi_om_ida);
>  
>  enum attribute_property {
> @@ -109,7 +106,6 @@ struct lwmi_om_priv {
>  	struct device *hwmon_dev;
>  	struct device *fw_attr_dev;
>  	struct kset *fw_attr_kset;
> -	struct notifier_block nb;
>  	struct wmi_device *wdev;
>  	int ida_id;
>  
> @@ -576,102 +572,6 @@ struct capdata01_attr_group {
>  	struct tunable_attr_01 *tunable_attr;
>  };
>  
> -/**
> - * lwmi_om_register_notifier() - Add a notifier to the blocking notifier chain
> - * @nb: The notifier_block struct to register
> - *
> - * Call blocking_notifier_chain_register to register the notifier block to the
> - * lenovo-wmi-other driver notifier chain.
> - *
> - * Return: 0 on success, %-EEXIST on error.
> - */
> -int lwmi_om_register_notifier(struct notifier_block *nb)
> -{
> -	return blocking_notifier_chain_register(&om_chain_head, nb);
> -}
> -EXPORT_SYMBOL_NS_GPL(lwmi_om_register_notifier, "LENOVO_WMI_OTHER");
> -
> -/**
> - * lwmi_om_unregister_notifier() - Remove a notifier from the blocking notifier
> - * chain.
> - * @nb: The notifier_block struct to register
> - *
> - * Call blocking_notifier_chain_unregister to unregister the notifier block from the
> - * lenovo-wmi-other driver notifier chain.
> - *
> - * Return: 0 on success, %-ENOENT on error.
> - */
> -int lwmi_om_unregister_notifier(struct notifier_block *nb)
> -{
> -	return blocking_notifier_chain_unregister(&om_chain_head, nb);
> -}
> -EXPORT_SYMBOL_NS_GPL(lwmi_om_unregister_notifier, "LENOVO_WMI_OTHER");
> -
> -/**
> - * devm_lwmi_om_unregister_notifier() - Remove a notifier from the blocking
> - * notifier chain.
> - * @data: Void pointer to the notifier_block struct to register.
> - *
> - * Call lwmi_om_unregister_notifier to unregister the notifier block from the
> - * lenovo-wmi-other driver notifier chain.
> - *
> - * Return: 0 on success, %-ENOENT on error.
> - */
> -static void devm_lwmi_om_unregister_notifier(void *data)
> -{
> -	struct notifier_block *nb = data;
> -
> -	lwmi_om_unregister_notifier(nb);
> -}
> -
> -/**
> - * devm_lwmi_om_register_notifier() - Add a notifier to the blocking notifier
> - * chain.
> - * @dev: The parent device of the notifier_block struct.
> - * @nb: The notifier_block struct to register
> - *
> - * Call lwmi_om_register_notifier to register the notifier block to the
> - * lenovo-wmi-other driver notifier chain. Then add devm_lwmi_om_unregister_notifier
> - * as a device managed action to automatically unregister the notifier block
> - * upon parent device removal.
> - *
> - * Return: 0 on success, or an error code.
> - */
> -int devm_lwmi_om_register_notifier(struct device *dev,
> -				   struct notifier_block *nb)
> -{
> -	int ret;
> -
> -	ret = lwmi_om_register_notifier(nb);
> -	if (ret < 0)
> -		return ret;
> -
> -	return devm_add_action_or_reset(dev, devm_lwmi_om_unregister_notifier,
> -					nb);
> -}
> -EXPORT_SYMBOL_NS_GPL(devm_lwmi_om_register_notifier, "LENOVO_WMI_OTHER");
> -
> -/**
> - * lwmi_om_notifier_call() - Call functions for the notifier call chain.
> - * @mode: Pointer to a thermal mode enum to retrieve the data from.
> - *
> - * Call blocking_notifier_call_chain to retrieve the thermal mode from the
> - * lenovo-wmi-gamezone driver.
> - *
> - * Return: 0 on success, or an error code.
> - */
> -static int lwmi_om_notifier_call(enum thermal_mode *mode)
> -{
> -	int ret;
> -
> -	ret = blocking_notifier_call_chain(&om_chain_head,
> -					   LWMI_GZ_GET_THERMAL_MODE, &mode);
> -	if ((ret & ~NOTIFY_STOP_MASK) != NOTIFY_OK)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
>  /* Attribute Methods */
>  
>  /**
> @@ -780,7 +680,7 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
>  	u32 value;
>  	int ret;
>  
> -	ret = lwmi_om_notifier_call(&mode);
> +	ret = lwmi_tm_notifier_call(&mode);
>  	if (ret)
>  		return ret;
>  
> @@ -842,7 +742,7 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
>  	int retval;
>  	int ret;
>  
> -	ret = lwmi_om_notifier_call(&mode);
> +	ret = lwmi_tm_notifier_call(&mode);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/platform/x86/lenovo/wmi-other.h b/drivers/platform/x86/lenovo/wmi-other.h
> deleted file mode 100644
> index 8ebf5602bb99..000000000000
> --- a/drivers/platform/x86/lenovo/wmi-other.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -
> -/* Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com> */
> -
> -#ifndef _LENOVO_WMI_OTHER_H_
> -#define _LENOVO_WMI_OTHER_H_
> -
> -struct device;
> -struct notifier_block;
> -
> -int lwmi_om_register_notifier(struct notifier_block *nb);
> -int lwmi_om_unregister_notifier(struct notifier_block *nb);
> -int devm_lwmi_om_register_notifier(struct device *dev,
> -				   struct notifier_block *nb);
> -
> -#endif /* !_LENOVO_WMI_OTHER_H_ */
> 
> base-commit: 0138af2472dfdef0d56fc4697416eaa0ff2589bd
> 

