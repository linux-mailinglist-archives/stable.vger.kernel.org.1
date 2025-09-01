Return-Path: <stable+bounces-176832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDAEB3E06F
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 12:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4BC2004B5
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA62310644;
	Mon,  1 Sep 2025 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzIZ17Kj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C6F3101C8
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723148; cv=none; b=sOSjuMPKyEv9ebNliTJomyU6uTBlauHu+5Rpy92/EncuyCWmENE6IE6AfAsexIa50pI8f67xKiNCPg7Y6FNlX5Sfv9lQZXeLgbMIWYBI1zJ7SE9mip9Eg/iT5TFwsaGMeORM5TWLrr+mvBDmXYx9GygQw5DbKlEAS26OOQWzmPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723148; c=relaxed/simple;
	bh=dRSrFAqLbSzEqpAHrRj6aOyVqMt0Rv9RbSRogviT0iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tglfrZ4q7zegY7aP1XTboSlmdiKy3M5TfyZ1x96PrpOBt81lp9980tcqGo7D9zsvqotpdvMOez+ZmTTl2fTh28qBDOE3J43C738GEQ3C9Kv8JPaAlyq77hT2C/MSg3cSVInEg3KkTcXlIaiyTAymHpX3Ho3qWRGOJ/837Qpa4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzIZ17Kj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756723147; x=1788259147;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dRSrFAqLbSzEqpAHrRj6aOyVqMt0Rv9RbSRogviT0iM=;
  b=gzIZ17KjOjLi769xJW9hiVNkbbzNOY1EVGvPIufRbnt+9EVKY64k5mZd
   MuvJKNvCu9ZPtKyu53HhBbA4lbEV31S6G72Q1t80aREFLCByrO5bRaJO6
   CP89ywEHj5ttr9ZVLGLVIkOnlrkZnVz9wbbGIOyCC4NZU5PaJhFIyxhfn
   VP/gfxngKRfwWnatVqkZz6YhXI6yyfCJvsYT+FGfSDnR8seKnKs3/cAxT
   ZMkNafZqpoWNzH+ZeRcHvoWeW6pu0hIVX1RmSUMNApP3s0T7uKLM3EbWn
   LzBdJW51UPMaod2VPK2V2zH2TOr51Tf6dalkWDZa5o/HB9Fe416TttIri
   g==;
X-CSE-ConnectionGUID: frNuzavLTt607h8dfMcYgw==
X-CSE-MsgGUID: CUW//Ad/SXKfYqLim56r9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59043934"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59043934"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 03:39:06 -0700
X-CSE-ConnectionGUID: OA3WSyxMSp+dZk3qckImAw==
X-CSE-MsgGUID: 6P65j512TA6zP8voTdwUhA==
X-ExtLoop1: 1
Received: from dmilosz-mobl.ger.corp.intel.com (HELO [10.245.252.194]) ([10.245.252.194])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 03:39:04 -0700
Message-ID: <8f45c329-256f-4e26-89be-6c410d0b7788@linux.intel.com>
Date: Mon, 1 Sep 2025 12:39:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Prevent recovery work from being queued
 during device removal
To: dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 Karol Wachowski <karol.wachowski@intel.com>, stable@vger.kernel.org
References: <20250808110939.328366-1-jacek.lawrynowicz@linux.intel.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20250808110939.328366-1-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Applied to drm-misc-fixes

On 8/8/2025 1:09 PM, Jacek Lawrynowicz wrote:
> From: Karol Wachowski <karol.wachowski@intel.com>
> 
> Use disable_work_sync() instead of cancel_work_sync() in ivpu_dev_fini()
> to ensure that no new recovery work items can be queued after device
> removal has started. Previously, recovery work could be scheduled even
> after canceling existing work, potentially leading to use-after-free
> bugs if recovery accessed freed resources.
> 
> Rename ivpu_pm_cancel_recovery() to ivpu_pm_disable_recovery() to better
> reflect its new behavior.
> 
> Fixes: 58cde80f45a2 ("accel/ivpu: Use dedicated work for job timeout detection")
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> ---
>  drivers/accel/ivpu/ivpu_drv.c | 2 +-
>  drivers/accel/ivpu/ivpu_pm.c  | 4 ++--
>  drivers/accel/ivpu/ivpu_pm.h  | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 3d6d52492536a..3289751b47573 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -677,7 +677,7 @@ static void ivpu_bo_unbind_all_user_contexts(struct ivpu_device *vdev)
>  static void ivpu_dev_fini(struct ivpu_device *vdev)
>  {
>  	ivpu_jobs_abort_all(vdev);
> -	ivpu_pm_cancel_recovery(vdev);
> +	ivpu_pm_disable_recovery(vdev);
>  	ivpu_pm_disable(vdev);
>  	ivpu_prepare_for_reset(vdev);
>  	ivpu_shutdown(vdev);
> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
> index eacda1dbe8405..475ddc94f1cfe 100644
> --- a/drivers/accel/ivpu/ivpu_pm.c
> +++ b/drivers/accel/ivpu/ivpu_pm.c
> @@ -417,10 +417,10 @@ void ivpu_pm_init(struct ivpu_device *vdev)
>  	ivpu_dbg(vdev, PM, "Autosuspend delay = %d\n", delay);
>  }
>  
> -void ivpu_pm_cancel_recovery(struct ivpu_device *vdev)
> +void ivpu_pm_disable_recovery(struct ivpu_device *vdev)
>  {
>  	drm_WARN_ON(&vdev->drm, delayed_work_pending(&vdev->pm->job_timeout_work));
> -	cancel_work_sync(&vdev->pm->recovery_work);
> +	disable_work_sync(&vdev->pm->recovery_work);
>  }
>  
>  void ivpu_pm_enable(struct ivpu_device *vdev)
> diff --git a/drivers/accel/ivpu/ivpu_pm.h b/drivers/accel/ivpu/ivpu_pm.h
> index 89b264cc0e3e7..a2aa7a27f32ef 100644
> --- a/drivers/accel/ivpu/ivpu_pm.h
> +++ b/drivers/accel/ivpu/ivpu_pm.h
> @@ -25,7 +25,7 @@ struct ivpu_pm_info {
>  void ivpu_pm_init(struct ivpu_device *vdev);
>  void ivpu_pm_enable(struct ivpu_device *vdev);
>  void ivpu_pm_disable(struct ivpu_device *vdev);
> -void ivpu_pm_cancel_recovery(struct ivpu_device *vdev);
> +void ivpu_pm_disable_recovery(struct ivpu_device *vdev);
>  
>  int ivpu_pm_suspend_cb(struct device *dev);
>  int ivpu_pm_resume_cb(struct device *dev);


