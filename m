Return-Path: <stable+bounces-144598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9812AB9BE6
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 14:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BAB17CF26
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 12:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4152423AE9B;
	Fri, 16 May 2025 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knMWx4yE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C81A32;
	Fri, 16 May 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398104; cv=none; b=axaAvHjhUI1yit+44+mFvx13o90V9/SZJboo916QJMTwHDf012Rze773q6LUNGDjy99mdy9Cj+xXSvYNXhnhjXoIPw+eqDXJh2N0he6l7/7hDVUVzEP0FtCAprTyQ9vMd23FtGxeye7+8Yf3pIPeCA+eOasxYV2ISeCFcpXjlyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398104; c=relaxed/simple;
	bh=4ojXC7ik50H2TK326HYmZyFHAasKbH4mv+ArsdZl0A0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g7mf1J2XMcp4tW2S/RCY15KToHqmoKtIwqCWRMHC+HRZ4YZZ2FVOO8hJUGkYzwxTAYV5jj3aVh2kWpy58jxFv//32+LIUT2ogxI134Lwd8/O0AFMD+Ytw/c2tG2ihJVYs/+8CmtwsXpAEvtEhpgmYJvBbNCDxL8RhM3x2eZ726k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knMWx4yE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747398103; x=1778934103;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4ojXC7ik50H2TK326HYmZyFHAasKbH4mv+ArsdZl0A0=;
  b=knMWx4yEs2t6K63/H8ghG9W5O8p6t7EqxjciM7CIh93Z2JG4zj9zlNjP
   QaaBS1qVjO14tJ8Wa46WxubHWln7cSJUedDp95Gj7U3VYR5s2DatyOmKS
   DoEzK/PPUv87mAJE2Gb0rbC/PxAygjw/xE2r+MZcjThBu2GnXp/ChOAeK
   TaaxezinnMVbyVRQRYr71O7vacVkarI6UiCvN3KqXZDcdRl6uYungIEZe
   vGnKSuZpPUUz43OQw7rPWCuD9AQOCh5mysXjy4KLKGKw5FmMR4Qv0MV9b
   UxZjVDiqYlyXXQ3efK6/BYCK/nZg1swWK2FO6JgKgG+CdXgJh6kNfYe1m
   w==;
X-CSE-ConnectionGUID: s2VJ0rMgRUiXpy9R3jp2zQ==
X-CSE-MsgGUID: HDh2OLCRRdKGU/iGYO603g==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="60710207"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="60710207"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 05:21:42 -0700
X-CSE-ConnectionGUID: Bmt2g5wxRK2maYqAlVmwVA==
X-CSE-MsgGUID: 53srrYjtRJ6fmjG2MygswQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="138594795"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.133])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 05:21:38 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Haoxiang Li <haoxiang_li2024@163.com>, thomas.hellstrom@linux.intel.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Haoxiang Li
 <haoxiang_li2024@163.com>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/xe/display: Add check for
 alloc_ordered_workqueue()
In-Reply-To: <20250424024015.3499778-1-haoxiang_li2024@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250424024015.3499778-1-haoxiang_li2024@163.com>
Date: Fri, 16 May 2025 15:21:36 +0300
Message-ID: <87a57cwxtb.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 24 Apr 2025, Haoxiang Li <haoxiang_li2024@163.com> wrote:
> Add check for the return value of alloc_ordered_workqueue()
> in xe_display_create() to catch potential exception.
>
> Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

This patch seems to have been neglected, apologies.

I've rebased it and included it as part of a bigger series [1].

Thanks for the patch.

BR,
Jani.


[1] https://lore.kernel.org/r/cover.1747397638.git.jani.nikula@intel.com

> ---
>  drivers/gpu/drm/xe/display/xe_display.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
> index 0b0aca7a25af..18062cfb265f 100644
> --- a/drivers/gpu/drm/xe/display/xe_display.c
> +++ b/drivers/gpu/drm/xe/display/xe_display.c
> @@ -104,6 +104,8 @@ int xe_display_create(struct xe_device *xe)
>  	spin_lock_init(&xe->display.fb_tracking.lock);
>  
>  	xe->display.hotplug.dp_wq = alloc_ordered_workqueue("xe-dp", 0);
> +	if (!xe->display.hotplug.dp_wq)
> +		return -ENOMEM;
>  
>  	return drmm_add_action_or_reset(&xe->drm, display_destroy, NULL);
>  }

-- 
Jani Nikula, Intel

