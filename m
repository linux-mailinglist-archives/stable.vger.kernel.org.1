Return-Path: <stable+bounces-54888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4994F913961
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 12:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A45A4B21BA3
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 10:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AF6762FF;
	Sun, 23 Jun 2024 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/qJ+nri"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891052CA7;
	Sun, 23 Jun 2024 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719137191; cv=none; b=PPViRILW1+v+zi6YXHPF1qfEGAaN7krgkXhWvQFy2FcfLpBn+D/gZBV8jIVkZ7QAs6iNGcipwY10KEcOcPrgBfgpGM0ySKgBtUiCD8/YIYMVXb+M3xA2lMPlY2vcd73d9CLdtcOPJ6b3wMD1E04NLh6kUgYULs8bbLVytPj9iAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719137191; c=relaxed/simple;
	bh=E+6cl0ki8qlLXqRwIpyYg/tusmYMNU0CoFmFdvS5Aw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHM5UKk9wrLpBA5hfSiifOmS5CuMyHmOJonNRrEpHYtEClj1cLEQm6ODB4dxViOXEDcgTz1dSW65KO2znUA6saeErcJKcdkrrhzSxVmZ3uFR7E7Odm8/kOPXu14VmGokNS3jiOhu2RNKnDaf4B4226pOUAg1W4JVdqwjkJZSK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/qJ+nri; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719137190; x=1750673190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E+6cl0ki8qlLXqRwIpyYg/tusmYMNU0CoFmFdvS5Aw8=;
  b=W/qJ+nriwFA43RYzj8aJZAx9vOasyJyaHTxSL1hm/1Qgc0DQ5iDaWX7x
   JxnPkmfFVrZqNsldQd3XzT1R8M645gRKYS4RjX5H7u6Sv046XNrV/ugrb
   QFbfiFSTiVz4YBanoUaJIZ7yRYwPTjzUUhWOJsWdhvmsoNZlZTaaAoWHI
   ZmAg9k5660LcDSz+969h/St6gi4WWA1sXkgMBOrB3DyOvdwKnHItThBnC
   9mj1JtsdUDEn1nRSd2l1mABaG+7wsuOWtSTjZscKCJ+9VeeObqLwlvozL
   SCxqDySimC3ihYhzBLvOd6uPG4yXj4zTWPl0jC4eO9KFZfhY5RwNnfn4f
   g==;
X-CSE-ConnectionGUID: fYkg943YS3i9i4m7W9Wheg==
X-CSE-MsgGUID: wCPUikUlT9W91QZ0DL4UtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="15876407"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="15876407"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 03:06:29 -0700
X-CSE-ConnectionGUID: K8cxUD+TQoac3luu2QNUAg==
X-CSE-MsgGUID: eXRHbMY5RfWbSfin9nhklw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="43461577"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 03:06:27 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 03C6511FA94;
	Sun, 23 Jun 2024 13:06:24 +0300 (EEST)
Date: Sun, 23 Jun 2024 10:06:23 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Wentong Wu <wentong.wu@intel.com>
Cc: tomas.winkler@intel.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: Re: [PATCH 1/6] mei: vsc: Enhance IVSC chipset reset toggling
Message-ID: <Znfznzd6Mt55XsmN@kekkonen.localdomain>
References: <20240623093056.4169438-1-wentong.wu@intel.com>
 <20240623093056.4169438-2-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623093056.4169438-2-wentong.wu@intel.com>

Hi Wentong,

Thanks for the set.

On Sun, Jun 23, 2024 at 05:30:51PM +0800, Wentong Wu wrote:
> Implementing the hardware recommendation to toggle the chipset reset.
> 
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Cc: stable@vger.kernel.org # for 6.8+
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Tested-by: Jason Chen <jason.z.chen@intel.com>
> ---
>  drivers/misc/mei/vsc-tp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
> index e6a98dba8a73..dcab5174bf00 100644
> --- a/drivers/misc/mei/vsc-tp.c
> +++ b/drivers/misc/mei/vsc-tp.c
> @@ -350,6 +350,8 @@ void vsc_tp_reset(struct vsc_tp *tp)
>  	disable_irq(tp->spi->irq);
>  
>  	/* toggle reset pin */
> +	gpiod_set_value_cansleep(tp->resetfw, 1);
> +	msleep(VSC_TP_RESET_PIN_TOGGLE_INTERVAL_MS);
>  	gpiod_set_value_cansleep(tp->resetfw, 0);
>  	msleep(VSC_TP_RESET_PIN_TOGGLE_INTERVAL_MS);
>  	gpiod_set_value_cansleep(tp->resetfw, 1);

Looking at the patch, the driver appears to leave the reset signal enabled.
As it currently works, also the polarity appears to be wrong.

Could you addrss this, after this patch?

-- 
Kind regards,

Sakari Ailus

