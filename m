Return-Path: <stable+bounces-194964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2AFC64B98
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 15:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 3C3C029704
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 14:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4145C3358BD;
	Mon, 17 Nov 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kE/1sy1X"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FBB30CDAA
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763391203; cv=none; b=sYntfoUkOdRp9qPv1/Yjdti506gZA+LlnvaPu1wZNZJQ87uWgBWa8Cfb1DSSCm+SSF37Ss9KLYLIzqvAXHkiLaLlf8sjj1ziNvamsYThjPb/+SCL/C1+iPURgZTVq0vKEybRQMNQcGymDOm8OKIxdVfJBCDO2cbdIAOFHI9N+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763391203; c=relaxed/simple;
	bh=MW/T2TIKnurIVANFZAq2/cO+kZMt52od2MosbQIMyT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYo7nznSclk6ZaoLREc3J4m7MgIaJB8XlKQfhT0ysxW5kTHuV0F1caJQxFWEtr4UBAKy7gdYzbbS50sx+WHhocEy8sGkHf0IPCV5qFJoLtOVdI7pBSxTFoDCNG9Iw8ufa3fHxUTsguBRyl7H9n8ao+9WsojVkA6ouKyuLyExGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kE/1sy1X; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763391201; x=1794927201;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MW/T2TIKnurIVANFZAq2/cO+kZMt52od2MosbQIMyT4=;
  b=kE/1sy1XKsDigxbw1ZwiOKedSCAzvKMt2d2yirL5PsXmk/5xuA8Uxyoe
   ax/+xCWompGgM5Lx4CzZ5okuEgM7lu3/3K0/NvHlW9vK3SIbnXkWJJLIo
   Cr9d3LcfrhqDo9DP1HR1z6JPvgg7qsr9PG7UY93Fz8VF16SlT8YTAgUIO
   UkWm1kGEgFoC8VjmptgowWyugR31fjxLublqHqHFb7J06wjj16qkTGUbb
   bI1KElt4wm2CoiBeWdUFw0ijnjx2vCIC5rO9TzbeNY/A1Idivh3GAhL5c
   svEXzLCe2RYFX+E1A7yi+f5utSeuOXIo4LZM+wHU2J2eJWHiQhhqRyHS5
   g==;
X-CSE-ConnectionGUID: 1tOxL8RoRnu+26LC8Pmycw==
X-CSE-MsgGUID: nE6qR5/YQeytIw2BIEPn+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="64594830"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="64594830"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 06:53:20 -0800
X-CSE-ConnectionGUID: NXnlTmvtQNaEtKUWUNNE1g==
X-CSE-MsgGUID: HTb+DGNPQ0i600WFq+JD4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="190628336"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.244.254]) ([10.245.244.254])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 06:53:20 -0800
Message-ID: <5fd48726-af72-4bba-9c57-9c9a198d2fa9@intel.com>
Date: Mon, 17 Nov 2025 14:53:17 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/oa: Fix potential UAF in xe_oa_add_config_ioctl()
To: Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20251117144420.2873155-2-sanjay.kumar.yadav@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20251117144420.2873155-2-sanjay.kumar.yadav@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/11/2025 14:44, Sanjay Yadav wrote:
> In xe_oa_add_config_ioctl(), we accessed oa_config->id after dropping
> metrics_lock. Since this lock protects the lifetime of oa_config, an
> attacker could guess the id and call xe_oa_remove_config_ioctl() with
> perfect timing, freeing oa_config before we dereference it, leading to
> a potential use-after-free.
> 
> Fix this by caching the id in a local variable while holding the lock.
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6614
> Fixes: cdf02fe1a94a7 ("drm/xe/oa/uapi: Add/remove OA config perf ops")
> Cc: <stable@vger.kernel.org> # v6.11+
> Suggested-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_oa.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
> index 87a2bf53d661..8f954bc3eed5 100644
> --- a/drivers/gpu/drm/xe/xe_oa.c
> +++ b/drivers/gpu/drm/xe/xe_oa.c
> @@ -2403,11 +2403,13 @@ int xe_oa_add_config_ioctl(struct drm_device *dev, u64 data, struct drm_file *fi
>   		goto sysfs_err;
>   	}
>   
> -	mutex_unlock(&oa->metrics_lock);
> +	id = oa_config->id;
> +
> +	drm_dbg(&oa->xe->drm, "Added config %s id=%i\n", oa_config->uuid, id);
>   
> -	drm_dbg(&oa->xe->drm, "Added config %s id=%i\n", oa_config->uuid, oa_config->id);
> +	mutex_unlock(&oa->metrics_lock);
>   
> -	return oa_config->id;
> +	return id;
>   
>   sysfs_err:
>   	mutex_unlock(&oa->metrics_lock);
> @@ -2461,10 +2463,10 @@ int xe_oa_remove_config_ioctl(struct drm_device *dev, u64 data, struct drm_file
>   	sysfs_remove_group(oa->metrics_kobj, &oa_config->sysfs_metric);
>   	idr_remove(&oa->metrics_idr, arg);
>   
> -	mutex_unlock(&oa->metrics_lock);
> -
>   	drm_dbg(&oa->xe->drm, "Removed config %s id=%i\n", oa_config->uuid, oa_config->id);
>   
> +	mutex_unlock(&oa->metrics_lock);
> +

AFAICT there is not need for this change, since this path is holding a 
reference to the config which is only dropped below?

>   	xe_oa_config_put(oa_config);
>   
>   	return 0;


