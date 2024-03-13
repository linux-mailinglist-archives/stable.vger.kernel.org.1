Return-Path: <stable+bounces-27598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD1487A962
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 15:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A83F1C20AA1
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1083346430;
	Wed, 13 Mar 2024 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCTl4ylP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32233F7;
	Wed, 13 Mar 2024 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339793; cv=none; b=UXZCUaOjxQ1Df0FwcD0J8iUcS9dZ/QT4qcxcfMo1eRjrI27AOTqd4pml4eQHITr6eb8tW4eLzj1525jNdxohyGSxZL8Xn8JIPGPD3JEMVcFMOjkQpJ9BMs8pSWyX+LxQ2wGbeSV3SGbzQEUK0q7DvUU98wzM8yWslrhKPJc5zoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339793; c=relaxed/simple;
	bh=4LaqYVsfsT2gIbRpf8MF4wFnLpekm5df8tdF/qGd6pE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBXMZRMXT5ZzKrscls4GqnVAJBIy5BLokqztbcwWAZ0spkkAhjN82u8T5QW3eOOMsh3sFw3aVVf9V2/LNqzHMzUoB92T+qNvXuvH9lxd4DTlvL3C8evspZ4XwElc3TrZuVHvHhH7tjSpY7j0fqqsNMW9u+tGm/7rfgCgtAhW1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCTl4ylP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710339792; x=1741875792;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4LaqYVsfsT2gIbRpf8MF4wFnLpekm5df8tdF/qGd6pE=;
  b=jCTl4ylPD4nISEpZ0ZZAYX8VqHKfMeYH4KJvTmrgdPkhn52UiVoJA1R4
   dbKYNrrrFtTdpqi99lNFMnPP1TtAaOfh+9sDcQrhdjX4UqN3JjRjlbGkd
   Hn+XkK0pokLM8YqHA4t9ccIs0D0lX1F2jKAKa8LvDi3sL0zoSHtg/7Y1T
   DEauAmFWtPXfo2oq+GdTC+K+OFJcOI/XXd7K4q6q9WKnr6RWxfXwMBl+9
   GLdlIrwqlPdNZI3NMSUq+dHuGdN7SKN0U1z42KH7Ss45k/XM2n0oF6EP5
   WBfFJ2x2PK9QQmTjr7aFhHOcKYUNJdg52T6jwVeSdshyqvW+jGB140en3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8926032"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="8926032"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 07:23:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="12020970"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.209.20])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 07:23:09 -0700
Message-ID: <c95ad3cf-bcc7-4174-aaf8-2307981568b5@intel.com>
Date: Wed, 13 Mar 2024 16:23:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc core block.c: initialize mmc_blk_ioc_data
Content-Language: en-US
To: mikko.rapeli@linaro.org, linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>, stable@vger.kernel.org
References: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/24 15:37, mikko.rapeli@linaro.org wrote:
> From: Mikko Rapeli <mikko.rapeli@linaro.org>
> 
> Commit "mmc: core: Use mrq.sbc in close-ended ffu" adds flags uint to
> struct mmc_blk_ioc_data but it does not get initialized for RPMB ioctls
> which now fail.
> 
> Fix this by always initializing the struct and flags to zero.
> 
> Fixes access to RPMB storage.
> 
> Fixes: 4d0c8d0aef63 ("mmc: core: Use mrq.sbc in close-ended ffu")
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218587
> 
> Link: https://lore.kernel.org/all/20231129092535.3278-1-avri.altman@wdc.com/
> 
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>

Not used to seeing blank lines after Fixes:, Closes, Link: tags,
nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 32d49100dff5..0df627de9cee 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -413,7 +413,7 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
>  	struct mmc_blk_ioc_data *idata;
>  	int err;
>  
> -	idata = kmalloc(sizeof(*idata), GFP_KERNEL);
> +	idata = kzalloc(sizeof(*idata), GFP_KERNEL);
>  	if (!idata) {
>  		err = -ENOMEM;
>  		goto out;


