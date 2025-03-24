Return-Path: <stable+bounces-125870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66113A6D764
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 10:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99A83AEBCC
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E8B25DAFD;
	Mon, 24 Mar 2025 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfxD3v7a"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB95825E479
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808598; cv=none; b=V04NL34Zmfqv3kkiyXgWb3ZRguq/1xeD51aN2kt6RaMlZp+k+JOeboHKARwoDC1/FnGbluIByi7Nsxfs/1ZjU7CJzp1nua52rRD0kFQpBX1wpYjT8nBrQMkpJbbsT1AqQr15eEx9DRgVWM8OCzn7gsgMQfSbYSmdmrHKhcPivrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808598; c=relaxed/simple;
	bh=BaMAAk8QpLCr2xEJ4h+pzE/PwJSGsYQQ7y2LcRkzuRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p/tcfNK1kKkklwdwhhFl7U2TsD9og33aQ4t8qHqT8Xd0EAb+mU9P+ciU5QlMzABi34pVTvFXjU4owort6GeQ9bRJ+O/3J5AeJYli+iSSVrmjBZL1N9pgczxOiEsMEL6LthFmlEDCs4zhfNl4crJwotPceIW5XNoWUlfruFP2egc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IfxD3v7a; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742808597; x=1774344597;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=BaMAAk8QpLCr2xEJ4h+pzE/PwJSGsYQQ7y2LcRkzuRQ=;
  b=IfxD3v7aypwRwzMuPm8EarMJ3Sj9ANtxhO+r9RsGpNGWdvOhx9kBXbS1
   qkWBLy8vz4z29XbzKVVuSa955YaoLMr0TUN75hzUpQeD/lhjCso6eZzrn
   dgiw4qu+lShILVIO5IOyyMx7Fa4SMcuD0MdU9L/QPF/QQCvfcN+46cRIo
   FPX2E34s54gbNO9WpTbHDjAgg+SVTAZSfmsV0Gy+ZRgmo9/MX8PO9YF0V
   55rtdm5lsHoMjZVPQ2c76eo5U0jeMvu7OhCiX/kHYaRnln2GlxkQ+kmrJ
   Vu16JV3C/DZ5mj0ObCeaip0OQc0xDwzwTPlICc1au7OKOGT4UBnfSvN3c
   w==;
X-CSE-ConnectionGUID: TkZDPsHTSbKHTeAggq8vtQ==
X-CSE-MsgGUID: Z1xteS+0RP2k6qiohCZmsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="55381155"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="55381155"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 02:29:56 -0700
X-CSE-ConnectionGUID: GGDTB0KlRZCg9RWAhYsS3A==
X-CSE-MsgGUID: 1f9qAMuWTuKnv9dqIaldEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="128811328"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 02:29:52 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nicolas Chauvet <kwizart@gmail.com>, Zhenyu Wang
 <zhenyuw@linux.intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Nicolas Chauvet <kwizart@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] [RFC] drm/i915/gvt: change OPREGION_SIGNATURE name
In-Reply-To: <20250324083755.12489-4-kwizart@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250324083755.12489-1-kwizart@gmail.com>
 <20250324083755.12489-4-kwizart@gmail.com>
Date: Mon, 24 Mar 2025 11:29:49 +0200
Message-ID: <87jz8ebwtu.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 24 Mar 2025, Nicolas Chauvet <kwizart@gmail.com> wrote:
> Change the OPREGION_SIGNATURE name so it fit into the
> opregion_header->signature size.
>
> Cc: stable@vger.kernel.org
> Fixes: 93615d59912 ("Revert drm/i915/gvt: Fix out-of-bounds buffer write into opregion->signature[]")
> Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>

Nope, can't do that. The signature is used for checking data in
memory. Which should be obvious if you'd looked at how it's being used
or if this was tested.

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/gvt/opregion.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
> index 0f11cd6ba383..0bd02dfaceb1 100644
> --- a/drivers/gpu/drm/i915/gvt/opregion.c
> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
> @@ -32,7 +32,7 @@
>  #define _INTEL_BIOS_PRIVATE
>  #include "display/intel_vbt_defs.h"
>  
> -#define OPREGION_SIGNATURE "IntelGraphicsMem"
> +#define OPREGION_SIGNATURE "IntelGFXMem"
>  #define MBOX_VBT      (1<<3)
>  
>  /* device handle */

-- 
Jani Nikula, Intel

