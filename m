Return-Path: <stable+bounces-74012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA09718EA
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 14:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD4A283A0D
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 12:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8921B5EC7;
	Mon,  9 Sep 2024 12:06:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBA529CE8;
	Mon,  9 Sep 2024 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883605; cv=none; b=DGCghLuVrY/J6oupZob8j5XMXYFCfsavwtvRQTYsqlJvO//KVspLn+mVagGXX9CzNZLRTiQj9VZ4Vt7PzypU44kqe26i8t5Ex6dqi3rkKE9E/w9DZccOaiSehkvlS2/TKPOSmvJVFIs6/kh16xDTy7Zl8Z2vVj/94mAb9kF9CbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883605; c=relaxed/simple;
	bh=zrqyZaMak6/bIRAUVNtpOqL0u8CgJmcv6E7JySyZ6QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HujEM1j3Edaocklw1+tyjYTekIG5rdqZpZoPyy/cBBWXY+07Hx+96X7l9SP4J3AgtTT6aLZHT3DlbUxH3ISx59H8o4t9Fccwd+ltlPSxzPlmUIq4BVM7Tkr4h4UBFUbkfpzSsXtuuMiHXsmGbX72u7WeqaiSFlOyoZVWyr1CqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: Fr8hFPsLS+uiCfAnDGS91A==
X-CSE-MsgGUID: t94nDTuOTgm7D6fHoJehMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="28460241"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="28460241"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 05:06:43 -0700
X-CSE-ConnectionGUID: 4IyoAIr4TB+wwXb0xjiG0A==
X-CSE-MsgGUID: 0GrTTBnUTUKptvYQoch4TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="104115470"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 05:06:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sndAF-00000006mND-1myF;
	Mon, 09 Sep 2024 15:06:39 +0300
Date: Mon, 9 Sep 2024 15:06:39 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	James Harmison <jharmison@redhat.com>,
	platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] platform/x86: panasonic-laptop: Fix SINF array
 out of bounds accesses
Message-ID: <Zt7kzwtNRdohoC-x@smile.fi.intel.com>
References: <20240909113227.254470-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909113227.254470-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 09, 2024 at 01:32:25PM +0200, Hans de Goede wrote:
> The panasonic laptop code in various places uses the SINF array with index
> values of 0 - SINF_CUR_BRIGHT(0x0d) without checking that the SINF array
> is big enough.
> 
> Not all panasonic laptops have this many SINF array entries, for example
> the Toughbook CF-18 model only has 10 SINF array entries. So it only
> supports the AC+DC brightness entries and mute.
> 
> Check that the SINF array has a minimum size which covers all AC+DC
> brightness entries and refuse to load if the SINF array is smaller.
> 
> For higher SINF indexes hide the sysfs attributes when the SINF array
> does not contain an entry for that attribute, avoiding show()/store()
> accessing the array out of bounds and add bounds checking to the probe()
> and resume() code accessing these.

...

> +static umode_t pcc_sysfs_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct acpi_device *acpi = to_acpi_device(dev);
> +	struct pcc_acpi *pcc = acpi_driver_data(acpi);

Isn't it the same as dev_get_drvdata()?

> +	if (attr == &dev_attr_mute.attr)
> +		return (pcc->num_sifr > SINF_MUTE) ? attr->mode : 0;
> +
> +	if (attr == &dev_attr_eco_mode.attr)
> +		return (pcc->num_sifr > SINF_ECO_MODE) ? attr->mode : 0;
> +
> +	if (attr == &dev_attr_current_brightness.attr)
> +		return (pcc->num_sifr > SINF_CUR_BRIGHT) ? attr->mode : 0;
> +
> +	return attr->mode;
> +}

...

> +	/*
> +	 * pcc->sinf is expected to at least have the AC+DC brightness entries.
> +	 * Accesses to higher SINF entries are checked against num_sifr.
> +	 */
> +	if (num_sifr <= SINF_DC_CUR_BRIGHT || num_sifr > 255) {
> +		pr_err("num_sifr %d out of range %d - 255\n", num_sifr, SINF_DC_CUR_BRIGHT + 1);

acpi_handle_err() ?

>  		return -ENODEV;
>  	}


-- 
With Best Regards,
Andy Shevchenko



