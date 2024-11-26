Return-Path: <stable+bounces-95523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8689D96D0
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 12:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE00168A74
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 11:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1CD1CEE97;
	Tue, 26 Nov 2024 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkH9Fpj8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CB1C4616;
	Tue, 26 Nov 2024 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622253; cv=none; b=r06IoI9359wxkoK/P/EOSg0/3vwCVE+cDS84wHT0NSG63hM75qB83uZZ+2wlYI+xj0eAzSNQMrIZstE+T5b0aq+tAqiijvuySFcksLm+PNITfpgqy/2dLcov0xn29noqGQgdrKZ77MEdtvNjyps8ZjmhgeOzIYyW50jUHjwFHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622253; c=relaxed/simple;
	bh=bCmiey7MuLrfGe8OToFkl8ukLY928J1c7ekJ8N9Jf7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlD+Jl8aq+7zheY523PTL92EaBJuoJTFoW237ix2KKXUmxPmnwh80MkRXzR1mRsdZbCIww/sNhfTdsVVvaKrxOPUAo7jH43gyO367UjIrLB25YHTZ1ytl3uLzKIeN1Az0wRGK4bdXnq+4sBJoaL/tf5DqLUTuWJEKqM/oL3lc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkH9Fpj8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732622251; x=1764158251;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bCmiey7MuLrfGe8OToFkl8ukLY928J1c7ekJ8N9Jf7k=;
  b=HkH9Fpj8V0CQvVCXID1KbliXgRo8zGhufCTbzUb6vBv5t9VuLxh38hPT
   AzyrOM2HZBYCEzWgCA1C6tHtnq4wYo6K44jJHHnlbKug0PmmJK6Qqf61h
   PbEipXUqNmJGLwfnG8DgbRY0lwGEry6C/UVFqy8dMuVqacZPlpMS/46wv
   XH2PGQgOAxDXZVIYPySVHxF/yRQIhhagC3lP8Lf1hLm7+f8PZejJL1l7n
   jxFsNsYbF9y520NFDxYiZA9RKHhH4YoeCmkWNNH5L8SeXJGGy8Q8A2QKk
   RVDsizTBQWzTwlVVus/Wnyg/lMi1KXcG5dJcVOYuPDqhVb7WSf3fx46m9
   g==;
X-CSE-ConnectionGUID: c4RWSLQXSu6+6J9/9trbpg==
X-CSE-MsgGUID: slPNkdQTTry636kuWYsq7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43842958"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="43842958"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 03:57:30 -0800
X-CSE-ConnectionGUID: O8YyPQNKRoGY6WezPCr9cg==
X-CSE-MsgGUID: arcrmDY3SNS0WrkxpwqQFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="95688928"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 03:57:29 -0800
Message-ID: <113cb538-f337-464e-9854-3a6dcb5b95e6@intel.com>
Date: Tue, 26 Nov 2024 13:57:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Further prevent card detect during shutdown
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
 Anthony Pighin <anthony.pighin@nokia.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241125122446.18684-1-ulf.hansson@linaro.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241125122446.18684-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/11/24 14:24, Ulf Hansson wrote:
> Disabling card detect from the host's ->shutdown_pre() callback turned out
> to not be the complete solution. More precisely, beyond the point when the
> mmc_bus->shutdown() has been called, to gracefully power off the card, we
> need to prevent card detect. Otherwise the mmc_rescan work may poll for the
> card with a CMD13, to see if it's still alive, which then will fail and
> hang as the card has already been powered off.
> 
> To fix this problem, let's disable mmc_rescan prior to power off the card
> during shutdown.
> 
> Reported-by: Anthony Pighin <anthony.pighin@nokia.com>

Could add a closes tag here

> Fixes: 66c915d09b94 ("mmc: core: Disable card detect during shutdown")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/bus.c  | 2 ++
>  drivers/mmc/core/core.c | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 9283b28bc69f..1cf64e0952fb 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -149,6 +149,8 @@ static void mmc_bus_shutdown(struct device *dev)
>  	if (dev->driver && drv->shutdown)
>  		drv->shutdown(card);
>  
> +	__mmc_stop_host(host);
> +
>  	if (host->bus_ops->shutdown) {
>  		ret = host->bus_ops->shutdown(host);
>  		if (ret)
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index a499f3c59de5..d996d39c0d6f 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2335,6 +2335,9 @@ void mmc_start_host(struct mmc_host *host)
>  
>  void __mmc_stop_host(struct mmc_host *host)
>  {
> +	if (host->rescan_disable)
> +		return;
> +
>  	if (host->slot.cd_irq >= 0) {
>  		mmc_gpio_set_cd_wake(host, false);
>  		disable_irq(host->slot.cd_irq);


