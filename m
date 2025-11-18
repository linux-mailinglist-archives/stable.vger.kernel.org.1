Return-Path: <stable+bounces-195101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17688C693C0
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 13:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49A244E37C9
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 11:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BDB3502B0;
	Tue, 18 Nov 2025 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2p8Wt0r"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117B830EF82
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763467085; cv=none; b=USyREpFHcPyZYvirCTuKNwiFWPNrU8ptwJx2eRSX214Vi58iyTX6iHJEHpXhl5kLFDYeTTHaNE4EdyrrYPa+t38e6lV2z8C5YMJXdnrXJEd75Vb03s1mZBl3+SJE7dEQ0X2GHcZ8jiZbwFxIhNIRI75GQ8Bc1d0t9FwzJsQOu9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763467085; c=relaxed/simple;
	bh=UR5CO5nbfFCdyoz9Fpmx8J4Izzr2vVogahrJJYc4ywU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrMcUzXMm5uVV8ZEFzNpWE31Vn/6q0ozDTue/7KmPhPKlnIwgy8L3vgG7fLScUDLKCA2YEpYI4zVcQRgpE0tcb98TtU+nTnaLL6/w90bY7m5qxqYiPaapHuSYjuPTQr6hPNqnsWOjeAt0WgWm/nvlymoVizK9ou4mEvUa+NFMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2p8Wt0r; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763467084; x=1795003084;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UR5CO5nbfFCdyoz9Fpmx8J4Izzr2vVogahrJJYc4ywU=;
  b=e2p8Wt0rKipB8pOs3pIP13NbDvTLllcR7CU0YihZhPl0cTWI8wrFIfJW
   XmQbfnc+3qmudbz2y7ggi3CW7BgUZZlHCFbUvs55JC80GmLIsUgczkHes
   KF7YifBvL2hMPLpQy1KXewlMUIPfhA4Gx4XczEEYFYRYqPBGu7hnW7GjJ
   bodvQQ/y4+yHeL77pKyajc8salJnaiVZSAbivVaZ8haAwIc2WRiXSQcyf
   ztcMXWop6n6QxW9IrLw9rGZf7RlnTLH0qJMPPpr2TxG0VLAdyim9C+WAA
   HZsrfyAN52mNeXrT5yBr1cn/WsPMjSLTpAGElbFfNglLstzN5QxdSNv3u
   A==;
X-CSE-ConnectionGUID: L/wgDmrIS/Crjos4UHnsag==
X-CSE-MsgGUID: DzsKESRnTruXClMxG8avLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="82876153"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="82876153"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 03:58:03 -0800
X-CSE-ConnectionGUID: Va9w912XTYuaOYuo8xDsSA==
X-CSE-MsgGUID: FmwtGgsEQRe0mZhvmQawqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190766149"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.245.117]) ([10.245.245.117])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 03:58:03 -0800
Message-ID: <cfd3a3de-068a-49eb-873f-f08b9aab30c7@intel.com>
Date: Tue, 18 Nov 2025 11:57:59 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/oa: Fix potential UAF in
 xe_oa_add_config_ioctl()
To: Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20251118114859.3379952-2-sanjay.kumar.yadav@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20251118114859.3379952-2-sanjay.kumar.yadav@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/11/2025 11:49, Sanjay Yadav wrote:
> In xe_oa_add_config_ioctl(), we accessed oa_config->id after dropping
> metrics_lock. Since this lock protects the lifetime of oa_config, an
> attacker could guess the id and call xe_oa_remove_config_ioctl() with
> perfect timing, freeing oa_config before we dereference it, leading to
> a potential use-after-free.
> 
> Fix this by caching the id in a local variable while holding the lock.
> 
> v2: (Matt A)
> - Dropped mutex_unlock(&oa->metrics_lock) ordering change from
>    xe_oa_remove_config_ioctl()
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6614
> Fixes: cdf02fe1a94a7 ("drm/xe/oa/uapi: Add/remove OA config perf ops")
> Cc: <stable@vger.kernel.org> # v6.11+
> Suggested-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/xe/xe_oa.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
> index 87a2bf53d661..890c363282ae 100644
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


