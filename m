Return-Path: <stable+bounces-74018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CA69719C5
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 14:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45A30B2282D
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 12:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BBB1B6542;
	Mon,  9 Sep 2024 12:46:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EAC1ACDE6;
	Mon,  9 Sep 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885982; cv=none; b=m7kZQKo20f5IOB+rjV2hAlD/F/QK5UBLh1ZnyIzzgEWKc2jwJYooOhjAXl9iFFaianWtL42VzoKXG1ebO77ra9Yw1p0zYbS/qmlch4d2ZLvHmgVahAVPf3eeq+Ahwg5MRgoN1OdJTgim66t+JZVYNbbvOSPqu2T3zpOHO8nT5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885982; c=relaxed/simple;
	bh=sZU3OKxBlSzVazElfSh77TMkqgMCzx5ikjkHkLKfk+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQV+X5oRHTu47RMqZSjcsR6jbBQvQteI2pO4AKrTb4X/8OVKev37M/Dzs3TDDReXCiMlP7jnKU/x9DfeUNX61Y1GH3SLndaqblJ8rFAy7OnSTjaBqlmMPXUjWhnhVnQh+K6r3KV8cLwdbRyE61m4KpFY75kFzYc5pUUHpOH1hQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: DgsCfJsQQA2pGSFLf5SxYQ==
X-CSE-MsgGUID: LI7UgcoCR+mOGX+jaTBTbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24127589"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24127589"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 05:46:21 -0700
X-CSE-ConnectionGUID: 8ym3nq4QQDG2LboGcvrbLA==
X-CSE-MsgGUID: Oeb9iOyWQGyYaJJoxmnRBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="104120911"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 05:46:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sndma-00000006n3n-2cIT;
	Mon, 09 Sep 2024 15:46:16 +0300
Date: Mon, 9 Sep 2024 15:46:16 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	James Harmison <jharmison@redhat.com>,
	platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] platform/x86: panasonic-laptop: Fix SINF array
 out of bounds accesses
Message-ID: <Zt7uGHDnUa4MVe9N@smile.fi.intel.com>
References: <20240909113227.254470-1-hdegoede@redhat.com>
 <Zt7kzwtNRdohoC-x@smile.fi.intel.com>
 <a8fc0357-8358-4a35-b094-4667e5aa20d5@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8fc0357-8358-4a35-b094-4667e5aa20d5@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 09, 2024 at 02:11:50PM +0200, Hans de Goede wrote:
> On 9/9/24 2:06 PM, Andy Shevchenko wrote:
> > On Mon, Sep 09, 2024 at 01:32:25PM +0200, Hans de Goede wrote:

...

> >> +static umode_t pcc_sysfs_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
> >> +{
> >> +	struct device *dev = kobj_to_dev(kobj);
> >> +	struct acpi_device *acpi = to_acpi_device(dev);
> >> +	struct pcc_acpi *pcc = acpi_driver_data(acpi);
> > 
> > Isn't it the same as dev_get_drvdata()?
> 
> No I also thought so and I checked. It is not the same,
> struct acpi_device has its own driver_data member, which
> this gets.

Ouch, you are right! It's a bit confusing :-(

> >> +	if (attr == &dev_attr_mute.attr)
> >> +		return (pcc->num_sifr > SINF_MUTE) ? attr->mode : 0;
> >> +
> >> +	if (attr == &dev_attr_eco_mode.attr)
> >> +		return (pcc->num_sifr > SINF_ECO_MODE) ? attr->mode : 0;
> >> +
> >> +	if (attr == &dev_attr_current_brightness.attr)
> >> +		return (pcc->num_sifr > SINF_CUR_BRIGHT) ? attr->mode : 0;
> >> +
> >> +	return attr->mode;
> >> +}

...

> >> +	/*
> >> +	 * pcc->sinf is expected to at least have the AC+DC brightness entries.
> >> +	 * Accesses to higher SINF entries are checked against num_sifr.
> >> +	 */
> >> +	if (num_sifr <= SINF_DC_CUR_BRIGHT || num_sifr > 255) {
> >> +		pr_err("num_sifr %d out of range %d - 255\n", num_sifr, SINF_DC_CUR_BRIGHT + 1);
> > 
> > acpi_handle_err() ?
> 
> The driver is using pr_err() already in 18 other places, so IMHO it is better
> to be consistent and also use it here.

Fair enough, so can be material for a followup in the future.

-- 
With Best Regards,
Andy Shevchenko



