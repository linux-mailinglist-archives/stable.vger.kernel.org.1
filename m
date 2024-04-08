Return-Path: <stable+bounces-36346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E628689BCBC
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870E71F2256F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B1352F62;
	Mon,  8 Apr 2024 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UERHJSgu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F975524C3
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571192; cv=none; b=AiHc96Ce+0gNTQqavlZuaJ15ovXdLJQDB+hpCPHt7Bc3c+ihlI/834FEPPD7Lm9q7xBXTa1sUT1v3sAUOFPGr50KikLJzIFAzPZZbRDR4HMIPkiqJVeLFsmG1/96Fa5hQMMv+Jlp4q1p7a129K11DMUkTfZTSNxskIuDMdpk74o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571192; c=relaxed/simple;
	bh=zRzAGpjrWuZ9EFZvedjukv2D1hIx1Y8GLMnbDytAIZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3SU3NRp5eG0amcnraV0DfA1K0HQ1zDvl2hEBl1UpNoE6v8gy+E8kIrkR/blwJ2zL0dLu9bz8nHqPPvGar+ZyZRfjrvuRag9b+0vr9tepedEa68Daq76+5iuk22wSGkLLpha0Jr4FqShV67q16CDfijTa2w4zIPtc4SuWApEDO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UERHJSgu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712571191; x=1744107191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zRzAGpjrWuZ9EFZvedjukv2D1hIx1Y8GLMnbDytAIZ8=;
  b=UERHJSgu24SpJRC8tJpZWqCvek7kZqkuX36HVtRrzjQoLEGk4/n7xMTD
   RKx380+wUA7Mk6WVPJuJzE0rtWJmAPM+XN0NLY0sk0riCSNjH5Fq0JtFb
   qMFXoBaKNFh03Xe7EZ2FSBPTNePyB0vt/NIFnSIAS3gXiO4kGYx/0A26U
   E4PrsO9Q/+iI4wK3tmtkNZaT/lSHJ0ZAyQv/nwL9rVQx7SrL4mM5/lrUH
   Vg63dXwxl4Yp7L8j4glhIG+D3dLWIVsPCyE36I9aC3SrLBEs+PTnWNBxS
   WRjaRVwj0/VODL3pvxHLRyVrsXVZLnWZpDQ96C5+hifOVgkb7k3jYojnF
   A==;
X-CSE-ConnectionGUID: reG9YKjHSQS6TwczLvWqBg==
X-CSE-MsgGUID: M4rFN0jER/+Q+7oOZ/PSoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="30333622"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="30333622"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 03:13:11 -0700
X-CSE-ConnectionGUID: WnwEhwRvTpa5HAsgaxFviw==
X-CSE-MsgGUID: DidAYF2lSJah1XOXCsatHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="20402414"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.246.36.15]) ([10.246.36.15])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 03:13:08 -0700
Message-ID: <c86e90ef-5bee-4638-9dcd-2666bb7f6e51@linux.intel.com>
Date: Mon, 8 Apr 2024 12:13:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Fix bo leak in intel_fb_bo_framebuffer_init
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20240404090302.68422-1-maarten.lankhorst@linux.intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <20240404090302.68422-1-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/4/2024 11:03 AM, Maarten Lankhorst wrote:
> Add a unreference bo in the error path, to prevent leaking a bo ref.
>
> Return 0 on success to clarify the success path.
>
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
> Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
> ---
>   drivers/gpu/drm/xe/display/intel_fb_bo.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/display/intel_fb_bo.c b/drivers/gpu/drm/xe/display/intel_fb_bo.c
> index dba327f53ac5..e18521acc516 100644
> --- a/drivers/gpu/drm/xe/display/intel_fb_bo.c
> +++ b/drivers/gpu/drm/xe/display/intel_fb_bo.c
> @@ -31,7 +31,7 @@ int intel_fb_bo_framebuffer_init(struct intel_framebuffer *intel_fb,
>   
>   	ret = ttm_bo_reserve(&bo->ttm, true, false, NULL);
>   	if (ret)
> -		return ret;
> +		goto err;
>   
>   	if (!(bo->flags & XE_BO_FLAG_SCANOUT)) {
>   		/*
> @@ -42,12 +42,16 @@ int intel_fb_bo_framebuffer_init(struct intel_framebuffer *intel_fb,
>   		 */
>   		if (XE_IOCTL_DBG(i915, !list_empty(&bo->ttm.base.gpuva.list))) {
>   			ttm_bo_unreserve(&bo->ttm);
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto err;
>   		}
>   		bo->flags |= XE_BO_FLAG_SCANOUT;
>   	}
>   	ttm_bo_unreserve(&bo->ttm);
> +	return 0;
>   
> +err:
> +	xe_bo_put(bo);
>   	return ret;
>   }
>   

