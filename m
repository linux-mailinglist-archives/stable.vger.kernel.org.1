Return-Path: <stable+bounces-77096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F422985649
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703F71C22EE7
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B02156F30;
	Wed, 25 Sep 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLa6BYI9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56112D20D
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256270; cv=none; b=X5PhKBTnPoGTC6aVJqHCQW6sESA0jaaPiAMgRdxtmRN9OEaEtPISXRfqwrvQrkcnd5RMwbDT5Mjap2D0ZRTA9qRxuLtnruyZuPlpa7ce1lbWj05+CUiNt7E05CM3RI2mqnnHyEBokY6gMA0au9P+r/e2o53BGTeiTvTCrBCLkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256270; c=relaxed/simple;
	bh=I6qIVElgaR7O8BPW73Q41D+G7hk+ZpSQUAI3bLW41Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SI+JmvUDyGLtqoU6qoqVqNzBGUMeCBp5Nj5450Uzj9ere0x4vbHzTP2k9+bZyf7pN9HnH9K+3XcMk3PbuN/6iSfPh06yg9jF72AAL9ejxXCzgEq3M+orbr8YJN7yPLWd3JR6DI/yfmMC24U0BNW1Xqb/983OhlKfxUJoHK6n6OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLa6BYI9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727256268; x=1758792268;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I6qIVElgaR7O8BPW73Q41D+G7hk+ZpSQUAI3bLW41Z0=;
  b=SLa6BYI9bIq9U2EBNjj/YWq3YjGVpK/mxNR/0PXvSntR3ts1NEt+rDgm
   00LGgdYyrmrOp4OHyOqN1y5wytec9PWVQhvzH3/tuQj3b+bClkwS13Og2
   1F2zmBMOvQbH75VQ4o9YE7h9mXA7SKLlrE61ocBQpGhxprvrcC5E8ncRx
   Tsa/TkjG4H99VpSxo17zljZfDiGR8O1DSOWqtvRCZgpRqmh/FNt/Xpbje
   L+1SltHkTbNpq0rjxSbuXJ7vJT7eJTQHBMC5hyRWvkmzAJbpykLWUougd
   f2mey3g4npS+o2TXmqphG3kmW50SRgpFIYBD5j8JwIctt4NBo2tJQoUtU
   g==;
X-CSE-ConnectionGUID: dBDHTAV8QjOFaGEuHWVbRw==
X-CSE-MsgGUID: pA7Zt8/1Sv6DxVdkHFPTSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="13917295"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="13917295"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 02:24:27 -0700
X-CSE-ConnectionGUID: QpBXGGTCQyeFRiffhs9C+w==
X-CSE-MsgGUID: oWbSj22cT6+S5aToxGqnYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71797192"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.245.178.53]) ([10.245.178.53])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 02:24:26 -0700
Message-ID: <5d47b5a8-fe4c-49fb-9f36-06916098829a@linux.intel.com>
Date: Wed, 25 Sep 2024 11:24:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/xe/vm: move xa_alloc to prevent UAF
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
References: <20240925071426.144015-3-matthew.auld@intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <20240925071426.144015-3-matthew.auld@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/25/2024 9:14 AM, Matthew Auld wrote:
> Evil user can guess the next id of the vm before the ioctl completes and
> then call vm destroy ioctl to trigger UAF since create ioctl is still
> referencing the same vm. Move the xa_alloc all the way to the end to
> prevent this.
>
> v2:
>  - Rebase
>
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
Interesting find, LGTM:
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 31fe31db3fdc..ce9dca4d4e87 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1765,10 +1765,6 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
>  	if (IS_ERR(vm))
>  		return PTR_ERR(vm);
>  
> -	err = xa_alloc(&xef->vm.xa, &id, vm, xa_limit_32b, GFP_KERNEL);
> -	if (err)
> -		goto err_close_and_put;
> -
>  	if (xe->info.has_asid) {
>  		down_write(&xe->usm.lock);
>  		err = xa_alloc_cyclic(&xe->usm.asid_to_vm, &asid, vm,
> @@ -1776,12 +1772,11 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
>  				      &xe->usm.next_asid, GFP_KERNEL);
>  		up_write(&xe->usm.lock);
>  		if (err < 0)
> -			goto err_free_id;
> +			goto err_close_and_put;
>  
>  		vm->usm.asid = asid;
>  	}
>  
> -	args->vm_id = id;
>  	vm->xef = xe_file_get(xef);
>  
>  	/* Record BO memory for VM pagetable created against client */
> @@ -1794,10 +1789,15 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
>  	args->reserved[0] = xe_bo_main_addr(vm->pt_root[0]->bo, XE_PAGE_SIZE);
>  #endif
>  
> +	/* user id alloc must always be last in ioctl to prevent UAF */
> +	err = xa_alloc(&xef->vm.xa, &id, vm, xa_limit_32b, GFP_KERNEL);
> +	if (err)
> +		goto err_close_and_put;
> +
> +	args->vm_id = id;
> +
>  	return 0;
>  
> -err_free_id:
> -	xa_erase(&xef->vm.xa, id);
>  err_close_and_put:
>  	xe_vm_close_and_put(vm);
>  

