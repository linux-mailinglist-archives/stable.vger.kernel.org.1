Return-Path: <stable+bounces-176978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED86B3FC84
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12604E3299
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64018281520;
	Tue,  2 Sep 2025 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvkIx0OZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C032F757
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809160; cv=none; b=QplM3m45glkZV2x9fdXCGJ1SlYaS0675RrrQYmExIUkETv0WKbG2kTd60++jTuwvWedZ6116XziKOa0S5pH5IMZxuBO5BU11+jVumJR75Zwm3MFO+BNixUFrmOEegWxEg5d7oGi9eyQGWNQUvpxM3UcVXX+pRoAeb7yzmulzR94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809160; c=relaxed/simple;
	bh=xHgaSh2A4yEv4NX/+7lLbbxdcZbq+h7IkvUfY2N9/WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQgmsWJ2ANQTbESrPhsR9qBUgmWT4BaFY8pPNPKYaGxdSebN0q1IoN34J080TatNnLAi/h6ATpn7U9hrNP2FTHso6R0B0v3+/aqerfyW413bSUX4ujFO2k3QA0TPmUiGa/96YPQ785pYgPD7V8KxBXlXFuN8YgvUVFQ1RyLQ1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvkIx0OZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756809159; x=1788345159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xHgaSh2A4yEv4NX/+7lLbbxdcZbq+h7IkvUfY2N9/WE=;
  b=PvkIx0OZApK05OYNxJXDMSk/Te4MnT8pd0FpMKC0ww0DS14Qf2QO0HxX
   yBL99v2j9E92SdF5vvIvnx8yrfECjJcJeaYD46E5D5t/76O1H5uPX5kVv
   s8ORo7nqe75Anq9j/C0F4JciD7U+JBs95cSJCTaBM6R9oRvH1WACCOHTZ
   UhxkM202R5JwGo4B9JKMQrPCUl2S0mj82aJ8Q+aEw12YbmZ1ixvLEU8It
   FljrM8XpAuXN3oJcuE/4lDLlbheuJ7LXBYtxnWqJ31DgwU1LZgffpFSwd
   q2093dhQaV8babduH6HGhOtBVUg9UihMRYYmGGredW4zgcyE0buNHc+xn
   g==;
X-CSE-ConnectionGUID: oiQ4Fj8bRPyGrrF1f/f2Zw==
X-CSE-MsgGUID: bE9Nrcb2RiuMiMg69BZLcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59026437"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59026437"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:32:37 -0700
X-CSE-ConnectionGUID: dgrQJMdnQkGqG0FBFn4MeQ==
X-CSE-MsgGUID: ynApx5lgSW+TGzzlSL3/BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171402132"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO [10.245.245.71]) ([10.245.245.71])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:32:35 -0700
Message-ID: <f16b5123-ed53-45b3-ac13-656ad839e87f@intel.com>
Date: Tue, 2 Sep 2025 11:32:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/xe: Allow the pm notifier to continue on
 failure
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20250901083829.27341-1-thomas.hellstrom@linux.intel.com>
 <20250901083829.27341-3-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20250901083829.27341-3-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/09/2025 09:38, Thomas Hellström wrote:
> Its actions are opportunistic anyway and will be completed
> on device suspend.

If it fails here, it will likely also fail in the real suspend part 
which is more hostile/restrictive environment, so maybe failing early is 
better? Not completely sure though.

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> 
> Marking as a fix to simplify backporting of the fix
> that follows in the series.
> 
> v2:
> - Keep the runtime pm reference over suspend / hibernate and
>    document why. (Matt Auld, Rodrigo Vivi):
> 
> Fixes: c6a4d46ec1d7 ("drm/xe: evict user memory in PM notifier")
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.16+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>   drivers/gpu/drm/xe/xe_pm.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index a2e85030b7f4..bee9aacd82e7 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -308,17 +308,17 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
>   	case PM_SUSPEND_PREPARE:
>   		xe_pm_runtime_get(xe);
>   		err = xe_bo_evict_all_user(xe);
> -		if (err) {
> +		if (err)
>   			drm_dbg(&xe->drm, "Notifier evict user failed (%d)\n", err);
> -			xe_pm_runtime_put(xe);
> -			break;
> -		}
>   
>   		err = xe_bo_notifier_prepare_all_pinned(xe);
> -		if (err) {
> +		if (err)
>   			drm_dbg(&xe->drm, "Notifier prepare pin failed (%d)\n", err);
> -			xe_pm_runtime_put(xe);
> -		}
> +		/*
> +		 * Keep the runtime pm reference until post hibernation / post suspend to
> +		 * avoid a runtime suspend interfering with evicted objects or backup
> +		 * allocations.
> +		 */
>   		break;
>   	case PM_POST_HIBERNATION:
>   	case PM_POST_SUSPEND:
> @@ -327,9 +327,6 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
>   		break;
>   	}
>   
> -	if (err)
> -		return NOTIFY_BAD;
> -
>   	return NOTIFY_DONE;
>   }
>   


