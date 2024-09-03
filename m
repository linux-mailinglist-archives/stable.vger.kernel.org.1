Return-Path: <stable+bounces-72809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E14D969A29
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AA81B2181C
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB301B983B;
	Tue,  3 Sep 2024 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nriyu1wb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE761B9834;
	Tue,  3 Sep 2024 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359408; cv=none; b=ftF7VRGxAHaaueHwJLci4/809oplKpz1MuNkRJnHpKNjWVOf2JhC45UnSf4q9smnVlIuYh5P5pLPmyfZOr/vIeEv5aGRcXVdPnX4gPmvKsaPhCPFj6COaah7HWZZqQjuvA8u6f439/3vYHULZUtXqOg7azSUHI5r6zUT/UmfnCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359408; c=relaxed/simple;
	bh=MNeq5lNZbcvPjWlk5Tlv3qcsU2Vuc+ByxVgTNGsAQV8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jOSQKLDNnmurYBYoOGoLzwvTPcYrV5eksm1vYghZ1clumeZvIMewFhzQ4U1npLg0WJnayl1Yoo4Ctv2OcnY+1UH/dYJ2nak5LasxeU28lqP8vYIpWyZWVB3o0/OGIcaw2M1nyNKtbB5g1ckcngXrYtMpHa13rwATaZfmB0JLCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nriyu1wb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725359406; x=1756895406;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MNeq5lNZbcvPjWlk5Tlv3qcsU2Vuc+ByxVgTNGsAQV8=;
  b=nriyu1wbIkLLOn+HzC3mVTp3ojasXQZcS911chwPWlF5kDSsLBIDqiJC
   woiSGB8ugdJpUlJpkFNBlx8JAn7Us+lMoHWGbYMjdknF11U1dKv2ts4nZ
   rZDL7neFiSlJscVwneAakH6rfQvicd116muXXTqwZ1wrkPuE+E4vkfQ5F
   inT7uoueTk6ve5/GK5fHVZFJJSBxIkXYazm6ty3OXXxEIVRT4VW4XoSzY
   /d8Y2CtM3GxDbvdYqUfIzd9FF5GTbaaChw2w0NtguJyCSPYdgMyQ1EXwd
   4Rd6EunjGiBLZ2yuSzeIDBXD1Mces+B3gvZvobJsBtfQ0alvbReh0mEd/
   g==;
X-CSE-ConnectionGUID: IPNNbqqCTEGRHrsVTQR99w==
X-CSE-MsgGUID: AboXVfe7QXqOGZhcodc1Ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="35316810"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="35316810"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 03:30:06 -0700
X-CSE-ConnectionGUID: EboskxK/SEeKZNhUfS6ELw==
X-CSE-MsgGUID: STlpIHedTk+lsNbWTFOKKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="64502270"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.241])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 03:30:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Sep 2024 13:29:59 +0300 (EEST)
To: Hans de Goede <hdegoede@redhat.com>
cc: Andy Shevchenko <andy@kernel.org>, James Harmison <jharmison@redhat.com>, 
    platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] platform/x86: panasonic-laptop: Check minimum SQTY
 value
In-Reply-To: <20240903083533.9403-1-hdegoede@redhat.com>
Message-ID: <dc2b719f-ba72-2d14-83d6-7ff35053d945@linux.intel.com>
References: <20240903083533.9403-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Sep 2024, Hans de Goede wrote:

> The panasonic laptop code in various places uses the sinf array with index
> values of 0 - SINF_CUR_BRIGHT(0x0d) without checking that the sinf array
> is big enough.
> 
> Check for a minimum SQTY value of SINF_CUR_BRIGHT to avoid out of bounds
> accesses of the sinf array.

This description is a bit misleading. The patch is _not_ adding a bounds 
check to sinf array access paths but ensuring the allocation is big 
enough for those accesses. It took me a while to figure out so I suggest 
the wording is improved to clearly explain how the problem has been 
addressed.

-- 
 i.

> Note SQTY returning SINF_CUR_BRIGHT is ok because the driver adds one extra
> entry to the sinf array.
> 
> Fixes: e424fb8cc4e6 ("panasonic-laptop: avoid overflow in acpi_pcc_hotkey_add()")
> Cc: stable@vger.kernel.org
> Tested-by: James Harmison <jharmison@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/panasonic-laptop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
> index cf845ee1c7b1..d7f9017a5a13 100644
> --- a/drivers/platform/x86/panasonic-laptop.c
> +++ b/drivers/platform/x86/panasonic-laptop.c
> @@ -963,8 +963,8 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
>  
>  	num_sifr = acpi_pcc_get_sqty(device);
>  
> -	if (num_sifr < 0 || num_sifr > 255) {
> -		pr_err("num_sifr out of range");
> +	if (num_sifr < SINF_CUR_BRIGHT || num_sifr > 255) {
> +		pr_err("num_sifr %d out of range %d - 255\n", num_sifr, SINF_CUR_BRIGHT);
>  		return -ENODEV;
>  	}
>  
> 

