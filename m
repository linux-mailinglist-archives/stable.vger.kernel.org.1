Return-Path: <stable+bounces-125867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05130A6D748
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 10:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3665B3A9286
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC7325D902;
	Mon, 24 Mar 2025 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/LKBwJG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEBE25D554
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808467; cv=none; b=q1Q7R6REsF6HKmos8zfSlnyxkeuSXS7LNwljfa3Tak9wzh91j/QhF1zC6rIZ5LA+kuTa0+FYXJywA1kBOf+3xBp347aw93qZtcl1oVmG8zZtmg8TuKSk1xc5TNKaTCZBeGhfLglpFNPcR1UwCSz4wqDu8RdfA2FlLBxpr4b9oAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808467; c=relaxed/simple;
	bh=RYD5t3NuRz8HBAxtXy8IkWEd7q9CzyXNsr7khC85y9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SF6eKuIl3SaBQGW4R7PJY6ISaDYqu20iYaUDvbsfhJ3lWVK4VTqXJIjqaPop/+KtBSzg/dyArd0x/PAGGEjQ2NlRNC5004UulOzRRhBD2BHUecihfjcWCRWkJZMLE4rCu6HHKhsMkQEMp+6i6sVKd5LRMxsR+3FjJ8VkgH4/WcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/LKBwJG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742808465; x=1774344465;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=RYD5t3NuRz8HBAxtXy8IkWEd7q9CzyXNsr7khC85y9o=;
  b=j/LKBwJGiviuTYyIZLnF8bGkJ/1YXSaRSYOl9lJSgJY3z4nGA7jz0f/T
   ZniR6R2mojsKmuQyKs/NyGsLu5/KxD8bdtFQVY2CEFHUVIFBMZ672lYCU
   FADNVVLqjjhmSwcx9kT4pXzXQdLXMJn6RPtXhQ48dnujsDg1xUS/wlAq9
   Z5FJa+mDvDZxYm3c+oiXHqUlin+JO7GvPNEs9S4TrhNF5Tqd/iKaEaXRf
   covEOMdSb7pgJkBH8OtU1NzOSEluqEKT95L2EKPBvkG0TTfYmhdplxB4Q
   2rq7cWKWpqvMy/oSXG5Ln0vtIZBVLukJxHqLByAQvK34ynNLqWDpPhe0n
   w==;
X-CSE-ConnectionGUID: UEdlF6vGRFeZ3x2oCaN61g==
X-CSE-MsgGUID: mX/kYSNySY2+R8EUK5qHPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="54638187"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="54638187"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 02:27:44 -0700
X-CSE-ConnectionGUID: VXgVYMFjT8SSvlnfPkfTEw==
X-CSE-MsgGUID: tiy7gqRYSaGi52m2zgp9XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="154899700"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 02:27:40 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nicolas Chauvet <kwizart@gmail.com>, Zhenyu Wang
 <zhenyuw@linux.intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Nicolas Chauvet <kwizart@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] [RFC] drm/i915/gvt: Fix opregion_header->signature
 size
In-Reply-To: <20250324083755.12489-3-kwizart@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250324083755.12489-1-kwizart@gmail.com>
 <20250324083755.12489-3-kwizart@gmail.com>
Date: Mon, 24 Mar 2025 11:27:37 +0200
Message-ID: <87pli6bwxi.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 24 Mar 2025, Nicolas Chauvet <kwizart@gmail.com> wrote:
> Enlarge the signature field to accept the string termination.
>
> Cc: stable@vger.kernel.org
> Fixes: 93615d59912 ("Revert drm/i915/gvt: Fix out-of-bounds buffer write into opregion->signature[]")
> Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>

Nope, can't do that. The packed struct is used for parsing data in
memory.

BR,
Jani.


> ---
>  drivers/gpu/drm/i915/gvt/opregion.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
> index 9a8ead6039e2..0f11cd6ba383 100644
> --- a/drivers/gpu/drm/i915/gvt/opregion.c
> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
> @@ -43,7 +43,7 @@
>  #define DEVICE_TYPE_EFP4   0x10
>  
>  struct opregion_header {
> -	u8 signature[16];
> +	u8 signature[32];
>  	u32 size;
>  	u32 opregion_ver;
>  	u8 bios_ver[32];

-- 
Jani Nikula, Intel

