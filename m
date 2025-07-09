Return-Path: <stable+bounces-161420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF75AFE5E9
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 12:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91583583852
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAB02877CB;
	Wed,  9 Jul 2025 10:37:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FEA25A354;
	Wed,  9 Jul 2025 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057435; cv=none; b=pmEv7mSvZL7AC9gGCdoyqgGsfITa/k9Gh8wTiMJmpafKwCGj/VqdKt7AFL68CYW2WYGXqagAQWeALNK/A7xIXdr2rFceFx5iiC9jIIX7+aHo3zIvTvV529Xyt70GSnhxfDksn8voXTIzfyH+boJA+EVHb0CoheobuN+Qz3IxnT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057435; c=relaxed/simple;
	bh=hIse3im/CiwJjIbl6Zx+237E/cMf6Sjf9+f2leGFGzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=peOpYOM8Odw5OXbienniCKYwBN5OtsBV+UX9HgNE9jdlfbjlUkoVF1XEakn41Ge0x0SyTygHWN3UKNfxBwyojBxjUkwntyC4zcOi/KJ+cbZ5eCTC/imCXhDHQ5+uspSv3pKdqpacOuFtgmCySA0+4rmI7taEUUF0KLyk0n/kd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C35191007;
	Wed,  9 Jul 2025 03:37:01 -0700 (PDT)
Received: from [10.57.86.38] (unknown [10.57.86.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E42B3F694;
	Wed,  9 Jul 2025 03:37:10 -0700 (PDT)
Message-ID: <f66307f4-7745-41a9-8c08-4be3b4d97403@arm.com>
Date: Wed, 9 Jul 2025 11:37:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Fix scheduler workqueue bug
To: Philipp Stanner <phasta@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Frank Binns <frank.binns@imgtec.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250709102957.100849-2-phasta@kernel.org>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250709102957.100849-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/07/2025 11:29, Philipp Stanner wrote:
> When the GPU scheduler was ported to using a struct for its
> initialization parameters, it was overlooked that panfrost creates a
> distinct workqueue for timeout handling.
> 
> The pointer to this new workqueue is not initialized to the struct,
> resulting in NULL being passed to the scheduler, which then uses the
> system_wq for timeout handling.
> 
> Set the correct workqueue to the init args struct.
> 
> Cc: stable@vger.kernel.org # 6.15+
> Fixes: 796a9f55a8d1 ("drm/sched: Use struct for drm_sched_init() params")
> Reported-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Closes: https://lore.kernel.org/dri-devel/b5d0921c-7cbf-4d55-aa47-c35cd7861c02@igalia.com/
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_job.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 5657106c2f7d..15e2d505550f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -841,7 +841,6 @@ int panfrost_job_init(struct panfrost_device *pfdev)
>  		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
>  		.credit_limit = 2,
>  		.timeout = msecs_to_jiffies(JOB_TIMEOUT_MS),
> -		.timeout_wq = pfdev->reset.wq,
>  		.name = "pan_js",
>  		.dev = pfdev->dev,
>  	};
> @@ -879,6 +878,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
>  	pfdev->reset.wq = alloc_ordered_workqueue("panfrost-reset", 0);
>  	if (!pfdev->reset.wq)
>  		return -ENOMEM;
> +	args.timeout_wq = pfdev->reset.wq;
>  
>  	for (j = 0; j < NUM_JOB_SLOTS; j++) {
>  		js->queue[j].fence_context = dma_fence_context_alloc(1);


