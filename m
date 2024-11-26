Return-Path: <stable+bounces-95561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDD09D9D5B
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 19:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E59B5B2241C
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 18:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874A51DDA36;
	Tue, 26 Nov 2024 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ScMpHpEv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D61D618E
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732645657; cv=none; b=d/ZohOSqvkqU5w81xiXO5R38ndA0RtJamxdWHeFcwt2gDEAGLY4U4vy11fbXUBROBr5/e3gV9gvbI2DxroKJxmomy2vxrQvX1dhsknT4E4gWv7tM+4G7rjSsn7+WZIA2BP0p/58SWeoVpw0CziZnItBhShlh4Wc0bwk9mdE2fs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732645657; c=relaxed/simple;
	bh=Y/VgcZj7shpqvcYRSS3IMWyuQIHtz4hzuV5aBvphYvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkoxptAvrA0dT2E2hhjKUqClj8D4yNzlO+W2xR6Pb6QEX5oEpbXc40/ePMjTX8yUQ0FMTEyOic8wwxJ+DRmvOpWT3sEY54MBgv/go9svQSH8aoBQNtWWUDOT39Paa42uckYCbXNArajYLfsxSIUxqRqF+5Ye7tsrlWtmO6Adq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ScMpHpEv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732645656; x=1764181656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y/VgcZj7shpqvcYRSS3IMWyuQIHtz4hzuV5aBvphYvE=;
  b=ScMpHpEvJDb8205cKG511NUmsECD/MdBBqYE0tzFIJwDRMjMBjCyKLAI
   /y8/SAkcQpFqx0o98vSgYYPF1RPg8SWPV+F6VtaIOUcoUEzR4IT1f/Zfc
   038B+1suVLFigVITZqOTAO0ec0lHz+7doJjxF4c9wIs3lWyPWz3Xi196q
   almFBD1SopeKeGjqA9fLGT4dITt9b8/+J9vdY4IhUn6hxe+k1KMSKwq6m
   fTxjn+OfBOmBVJKHU6d70XuecZbN+WuLE3Wd+Zv5FEJGmBvYLgWzy92Nk
   p6LkvyI/IOVRyxwFVv2IzlqCZFZ5X/2YoZ4whm0NB4SwRR5hh22mbOtAP
   g==;
X-CSE-ConnectionGUID: eTSjmjCWQj2tn4kv4Wvy2g==
X-CSE-MsgGUID: 8MhmjBhrRm618/86IUpcRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="43892436"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="43892436"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 10:27:36 -0800
X-CSE-ConnectionGUID: lQOUGVVTShqy0IJvJjwbtw==
X-CSE-MsgGUID: DQnAiYPhQt65paIQf6I9ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91519735"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.245.160.19]) ([10.245.160.19])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 10:27:33 -0800
Message-ID: <e134fa72-678d-4e3f-9362-d303407a5e85@linux.intel.com>
Date: Tue, 26 Nov 2024 19:27:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/xe/migrate: use XE_BO_FLAG_PAGETABLE
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, Nirmoy Das
 <nirmoy.das@intel.com>, stable@vger.kernel.org
References: <20241126181259.159713-3-matthew.auld@intel.com>
 <20241126181259.159713-4-matthew.auld@intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <20241126181259.159713-4-matthew.auld@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/26/2024 7:13 PM, Matthew Auld wrote:
> On some HW we want to avoid the host caching PTEs, since access from GPU
> side can be incoherent. However here the special migrate object is
> mapping PTEs which are written from the host and potentially cached. Use
> XE_BO_FLAG_PAGETABLE to ensure that non-cached mapping is used, on
> platforms where this matters.
>
> Fixes: 7a060d786cc1 ("drm/xe/mtl: Map PPGTT as CPU:WC")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Nirmoy Das <nirmoy.das@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+

Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_migrate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
> index 48e205a40fd2..1b97d90aadda 100644
> --- a/drivers/gpu/drm/xe/xe_migrate.c
> +++ b/drivers/gpu/drm/xe/xe_migrate.c
> @@ -209,7 +209,8 @@ static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
>  				  num_entries * XE_PAGE_SIZE,
>  				  ttm_bo_type_kernel,
>  				  XE_BO_FLAG_VRAM_IF_DGFX(tile) |
> -				  XE_BO_FLAG_PINNED);
> +				  XE_BO_FLAG_PINNED |
> +				  XE_BO_FLAG_PAGETABLE);
>  	if (IS_ERR(bo))
>  		return PTR_ERR(bo);
>  

