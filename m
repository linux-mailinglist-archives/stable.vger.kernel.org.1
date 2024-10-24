Return-Path: <stable+bounces-88097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575779AEB83
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 18:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141CC281A81
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DECE1BD504;
	Thu, 24 Oct 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcV33e/E"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84233EA
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786129; cv=none; b=jOhcAqAIur60LLBxNwppk8SvIxgpfC0en5hWAcDTXna7gG+gwW0TYwA77LNvlYiVUc3u1MmC0KDqC1J+RYhpZTLBtfeuxQGDJg1ZQQhtfyGQR8ywS8oh6Jd+EfScnEAy0sx3TBQnd0zVPyqcbQ3rwPxxAifBMiVHZhlVpXTuMsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786129; c=relaxed/simple;
	bh=CD672zf/icrP84JkBNyIXVtqmmmy5ltkgqScRUqyZ0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABk0nUiBbC0L9yg6oGVlOy/+WCj9DPU1EBtiECVqB5BMdrvoaxphMszLGgJ1RCSH/JWp/WjXfwVdgMvzR3i26YhBeerIBXy9y4G5i26ozYCKtkrFMFH1rcFg2sc7sDYMepNfpROo2aeghUrsrrBKqo4hX0flCseJrR6YpT9thGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcV33e/E; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729786127; x=1761322127;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CD672zf/icrP84JkBNyIXVtqmmmy5ltkgqScRUqyZ0I=;
  b=FcV33e/EGWz2YXGHniqKHMKw37lZ3t7S4J8urZcJsERj0Gx4n6cKRuf6
   F4y+mXYnClMHsmElSCRWEydz9U9rG7jKf9p8jpjib9YtC+cjA/19b2PCH
   uCaa8dHhaKBkfoWsDtBgsytdkdEV/Z+yEzu/XdKzMO2J36uiOGe0aenIT
   YI9njt4liU9jn1l4wxtrpfl/0F3zb/IC1L0ebIbtH100EJviywH3+eBMb
   nOTLgMckxMsfNPdBxP02ccl0Jm7oFfpl/KJydXmxJTTvHpI56GQ/sgOax
   XBaDmdp34l6b9VcCC5/z0AF5d3pdjyRBr6l5aCnPBvPcb6RxDniICcpUW
   A==;
X-CSE-ConnectionGUID: JX31snfkSW6iWi9X4uXC8Q==
X-CSE-MsgGUID: 0MeviwLZRam45IbrDLwK6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29645490"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29645490"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 09:08:46 -0700
X-CSE-ConnectionGUID: qiLFrGcfQ5ar0L2Kw9ovZw==
X-CSE-MsgGUID: 8ERYUp9QSXyVhWJRUXaTWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="118098418"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.245.128.192]) ([10.245.128.192])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 09:08:42 -0700
Message-ID: <91c492bd-5001-41fe-b151-fe78be86a9c4@linux.intel.com>
Date: Thu, 24 Oct 2024 18:08:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/ufence: Flush xe ordered_wq in case of ufence
 timeout
To: Nirmoy Das <nirmoy.das@intel.com>, intel-xe@lists.freedesktop.org
Cc: Badal Nilawar <badal.nilawar@intel.com>,
 Jani Nikula <jani.nikula@intel.com>, Matthew Auld <matthew.auld@intel.com>,
 John Harrison <John.C.Harrison@Intel.com>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, stable@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>
References: <20241024151815.929142-1-nirmoy.das@intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <20241024151815.929142-1-nirmoy.das@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/24/2024 5:18 PM, Nirmoy Das wrote:
> Flush xe ordered_wq in case of ufence timeout which is observed
> on LNL and that points to the recent scheduling issue with E-cores.
>
> This is similar to the recent fix:
> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
> response timeout") and should be removed once there is E core
> scheduling fix.
>
> v2: Add platform check(Himal)
>     s/__flush_workqueue/flush_workqueue(Jani)
>
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: John Harrison <John.C.Harrison@Intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.11+
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_wait_user_fence.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> index f5deb81eba01..78a0ad3c78fe 100644
> --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
> +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> @@ -13,6 +13,7 @@
>  #include "xe_device.h"
>  #include "xe_gt.h"
>  #include "xe_macros.h"
> +#include "compat-i915-headers/i915_drv.h"

Sorry sent too soon. This is bit out of place. I will sort it and resend after sometime to accumulate reviews.


>  #include "xe_exec_queue.h"
>  
>  static int do_compare(u64 addr, u64 value, u64 mask, u16 op)
> @@ -155,6 +156,19 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
>  		}
>  
>  		if (!timeout) {
> +			if (IS_LUNARLAKE(xe)) {
> +				/*
> +				 * This is analogous to e51527233804 ("drm/xe/guc/ct: Flush g2h
> +				 * worker in case of g2h response timeout")
> +				 *
> +				 * TODO: Drop this change once workqueue scheduling delay issue is
> +				 * fixed on LNL Hybrid CPU.
> +				 */
> +				flush_workqueue(xe->ordered_wq);
> +				err = do_compare(addr, args->value, args->mask, args->op);
> +				if (err <= 0)
> +					break;
> +			}
>  			err = -ETIME;
>  			break;
>  		}

