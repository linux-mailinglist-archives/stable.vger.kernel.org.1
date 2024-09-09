Return-Path: <stable+bounces-74016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0559971964
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 14:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EDF1C2301A
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27D81B3B15;
	Mon,  9 Sep 2024 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8MuItam"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C51DFF0
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885167; cv=none; b=agWijTJf3Y2V5pVYCeQe7CbPkYiugAIJl0UHlKGhiHYfdIrnqqZT8J2ywaKTVql3ybk6nTzOuqq+bYgaBwBpWjAJ4g1JraVjkUdKQVoGxmoEGbGHw6baYnmgi5ZpuaVmGtYEZ+LKOY9kHngBdFcA7fZwpJuiIvzE74q5dBq2syA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885167; c=relaxed/simple;
	bh=KHaICYJXR9iYmH086DbtJWq/Y7KA5lt5pMVA3G9kupU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjqU0cRac4U9cUByYMy6xnkGK/kzX6BjDcl4TC/nRqheJI9jjX+RPbSkaF/tV0zHg23CiMKFUr6W5f4ufi6vH3PTXv8JeVnyswcNYIYAv9T0eMzotncARKhvqZqK93oYuwNZcojV1hw9d5y0TQiGdCHdUj3pnl1rmnB4YuAIzbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8MuItam; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725885165; x=1757421165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KHaICYJXR9iYmH086DbtJWq/Y7KA5lt5pMVA3G9kupU=;
  b=L8MuItamT4wKu3TG5wowcgWhINEbm/ziVr3bj2DWEPb81ZiJj4FwIYrT
   wwcKheWaK8kEh9u0RUpOeWw3TFfFgmjAKLgwAI9f1rOFKBUMMLt9fPM0q
   qSLBuoksCy3Eaa1zzf2sgDZ0bHwV6rJSz2GJp/oz0f94EDpxRv83Jugk+
   eSRLyGePXeiDkI+BpFcjKRs8N/mDzz1nS0YxwImvRTsVhxpUc7SyIDv1N
   pR6sRhqsFfSFhiijJ2UyVPO/L3jKTa74PGpN2EeXJ8IF6s8ztD6vJq7bE
   y5JL3KryKqNMthVBT+HM58lZxcHKetj70dw93zXnSgALA13J8o8dGjwC8
   Q==;
X-CSE-ConnectionGUID: pMOSehS/RsG8NrU5nH2/dw==
X-CSE-MsgGUID: 0rZLsIvZSqOE5sRYArY9/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24126537"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24126537"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 05:32:38 -0700
X-CSE-ConnectionGUID: jzJe5r/pSx+W6AfbDHI/XQ==
X-CSE-MsgGUID: TTrlGAapTvCZKONcnlwyrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="104119170"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.245.166.204]) ([10.245.166.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 05:32:35 -0700
Message-ID: <aeeccacb-f2c0-410b-ad63-6e39705dd77e@linux.intel.com>
Date: Mon, 9 Sep 2024 14:32:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/4] drm/sched: Always increment correct scheduler score
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Nirmoy Das <nirmoy.das@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, stable@vger.kernel.org
References: <20240906180618.12180-1-tursulin@igalia.com>
 <20240906180618.12180-4-tursulin@igalia.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <20240906180618.12180-4-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/6/2024 8:06 PM, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Entities run queue can change during drm_sched_entity_push_job() so make
> sure to update the score consistently.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: d41a39dda140 ("drm/scheduler: improve job distribution with multiple queues")
> Cc: Nirmoy Das <nirmoy.das@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Luben Tuikov <ltuikov89@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.9+
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
> ---
>  drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 62b07ef7630a..2a910c1df072 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -586,7 +586,6 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>  	ktime_t submit_ts;
>  
>  	trace_drm_sched_job(sched_job, entity);
> -	atomic_inc(entity->rq->sched->score);
>  	WRITE_ONCE(entity->last_user, current->group_leader);
>  
>  	/*
> @@ -612,6 +611,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>  
>  		rq = entity->rq;
>  
> +		atomic_inc(rq->sched->score);
>  		drm_sched_rq_add_entity(rq, entity);
>  		spin_unlock(&entity->rq_lock);
>  

