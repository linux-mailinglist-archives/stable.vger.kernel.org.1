Return-Path: <stable+bounces-242079-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJvHLDgu82m0yAEAu9opvQ
	(envelope-from <stable+bounces-242079-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:26:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 616164A0CB1
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D0183006176
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F515401494;
	Thu, 30 Apr 2026 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwKVIMlp"
X-Original-To: Stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2253D6CCA;
	Thu, 30 Apr 2026 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777544653; cv=none; b=Dyye4Dll23C96k3GNnKjMVu5TCAoh8F+gKKDMvgwHkQeJlSJKxfHBbaBLcUftB/6al+vXTTCjaIxfWQzyh5mzcx7MYB7acUmyGE8qqYSeq8W8CoMzu6SULuVflWqPXSQaTgikyWNzvZHM1V4+5RjpxbzAexvNgeZeqASdy34ui0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777544653; c=relaxed/simple;
	bh=qzAN5+vox86e9la/JEL32MReRe8s4fvtyoKpifqa3Uc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EE7/HRrBeKANSXi9z8GDh91Zp2WlS28MmUmGLFdeOmxV0JHIWopfrp1XlBvE1sfnFfaKiMO22NlOMNzpTLZ72m046aFnK1mVcNEUqHchhzPFNrtvSbauZQ8Jll+Xgw6etJysyR9dKRZwPI0EvGY5ClpSc4Ja5PuYJSZ7sM8fnso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwKVIMlp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777544650; x=1809080650;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qzAN5+vox86e9la/JEL32MReRe8s4fvtyoKpifqa3Uc=;
  b=fwKVIMlpqEEjOtrpat8A47Mic2w03DgDDlFXMi6MuxfH7C2qsZsRg8kn
   5GxnaXS9I6/viF4/D6M95dLmPSBFiORJvuMGst13uUKH8TSNm8EAPw5L3
   Hf97BtVoZauYoPEf8Y/9bJYshqcN6xeAempf63JC4eYKslv19lduPnSwg
   uJ85O8itkSG2wKtTvowvE9SSVzS0HV5H1kwDsPKtGH0xJaEK10YEBH2a2
   7fyVOqHGm+Hr2W5YL/njhGKc8vTxGsxXG5zLiRauIPL8GsVkKmc7BKfWk
   F4CjkCeCRZ8kgN+2DmcfqBbLfuwTwxz+C1g061DNchNHuKQD364cu3NfN
   g==;
X-CSE-ConnectionGUID: bYgM6VwkQVWIbWqrF5jAvA==
X-CSE-MsgGUID: HKpnTVYVS5qXD4ZlfIwukA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89866972"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="89866972"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 03:24:08 -0700
X-CSE-ConnectionGUID: ENu7xj8SQ+WNThZzx5dx0Q==
X-CSE-MsgGUID: tT5/AvJCSjmQxsRXDhfc2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="233512859"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 03:24:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 30 Apr 2026 13:24:03 +0300 (EEST)
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Stable@vger.kernel.org
Subject: Re: [PATCH 3/3] platform/x86/intel/tpmi/plr: Prevent fault during
 unbind
In-Reply-To: <20260429195214.1532711-4-srinivas.pandruvada@linux.intel.com>
Message-ID: <ef77dd1d-57bf-073d-4ef6-54cf70ddd12f@linux.intel.com>
References: <20260429195214.1532711-1-srinivas.pandruvada@linux.intel.com> <20260429195214.1532711-4-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 616164A0CB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242079-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]

On Wed, 29 Apr 2026, Srinivas Pandruvada wrote:

> This driver faults when intel vsec driver unbound from PCI driver
> interface. For example:
> 
> echo 0000:00:03.1 > /sys/bus/pci/drivers/intel_vsec/unbind
> 
> This is caused by accessing plr->dbgfs_dir after vsec_tpmi driver is
> removed. Here vsec_tpmi driver is the parent. On unbind, the parent
> device remove callback is called first which here will remove debugfs
> interface. Hence plr->dbgfs_dir is no longer valid.
> 
> Register notifier for TPMI_CORE_EXIT and make this pointer to NULL,
> so that debugfs_remove_recursive() is not called with bad plr->dbgfs_dir
> pointer.
> 
> After notifier is returned the vsec_tpmi driver will call remove debugfs
> by calling debugfs_remove_recursive().
> 
> Fixes: 811f67c51636 ("platform/x86/intel/tpmi: Add new auxiliary driver for performance limits")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: <Stable@vger.kernel.org>
> ---
>  drivers/platform/x86/intel/plr_tpmi.c | 43 +++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/plr_tpmi.c b/drivers/platform/x86/intel/plr_tpmi.c
> index 05727169f49c..644df673896b 100644
> --- a/drivers/platform/x86/intel/plr_tpmi.c
> +++ b/drivers/platform/x86/intel/plr_tpmi.c
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
> +#include <linux/notifier.h>
>  #include <linux/seq_file.h>
>  #include <linux/sprintf.h>
>  #include <linux/types.h>
> @@ -60,6 +61,8 @@ struct tpmi_plr {
>  	struct tpmi_plr_die *die_info;
>  	int num_dies;
>  	struct auxiliary_device *auxdev;
> +	struct notifier_block nb;
> +	struct mutex lock; /* Protect access to dbgfs_dir  */

Extra whitespace.

Move the comment slightly more right as there's place.

>  };
>  
>  static const char * const plr_coarse_reasons[] = {
> @@ -255,6 +258,30 @@ static ssize_t plr_status_write(struct file *filp, const char __user *ubuf,
>  }
>  DEFINE_SHOW_STORE_ATTRIBUTE(plr_status);
>  
> +static int intel_plr_notify(struct notifier_block *self, unsigned long action, void *data)
> +{
> +	struct tpmi_plr *plr = container_of(self, struct tpmi_plr, nb);
> +
> +	if (action == TPMI_CORE_EXIT) {
> +		guard(mutex)(&plr->lock);
> +		plr->dbgfs_dir = NULL;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int intel_plr_register_notifier(struct notifier_block *nb)
> +{
> +	nb->notifier_call = intel_plr_notify;
> +	nb->priority = 0;
> +	return tpmi_register_notifier(nb);
> +}
> +
> +static void intel_plr_unregister_notifier(struct notifier_block *nb)
> +{
> +	tpmi_unregister_notifier(nb);
> +}
> +
>  static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
>  {
>  	struct oobmsm_plat_info *plat_info;
> @@ -282,10 +309,16 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
>  	if (!plr)
>  		return -ENOMEM;
>  
> +	mutex_init(&plr->lock);

This lacks pairing destroy, but you can probably use devm_mutex_init() as 
there's devm_*() below.

> +
> +	intel_plr_register_notifier(&plr->nb);
> +
>  	plr->die_info = devm_kcalloc(&auxdev->dev, num_resources, sizeof(*plr->die_info),
>  				     GFP_KERNEL);
> -	if (!plr->die_info)
> -		return -ENOMEM;
> +	if (!plr->die_info) {
> +		err = -ENOMEM;
> +		goto err_notify;
> +	}
>  
>  	plr->num_dies = num_resources;
>  	plr->dbgfs_dir = debugfs_create_dir("plr", dentry);
> @@ -326,6 +359,9 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
>  
>  err:
>  	debugfs_remove_recursive(plr->dbgfs_dir);
> +err_notify:
> +	intel_plr_unregister_notifier(&plr->nb);
> +
>  	return err;
>  }
>  
> @@ -333,6 +369,9 @@ static void intel_plr_remove(struct auxiliary_device *auxdev)
>  {
>  	struct tpmi_plr *plr = auxiliary_get_drvdata(auxdev);
>  
> +	intel_plr_unregister_notifier(&plr->nb);
> +
> +	guard(mutex)(&plr->lock);
>  	debugfs_remove_recursive(plr->dbgfs_dir);
>  }
>  
> 

-- 
 i.


