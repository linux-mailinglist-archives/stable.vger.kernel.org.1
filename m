Return-Path: <stable+bounces-161418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF378AFE5C3
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 12:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AEBC7A5308
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 10:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4562257AEE;
	Wed,  9 Jul 2025 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UPp6amXj"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D08226173;
	Wed,  9 Jul 2025 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057161; cv=none; b=uNxEi0O6uEBy2rizyVAUh8+VlYJAneozQGXCesPkQUMzoCj8BflJz0HfMo4c/uYt4nl8e76UsgM7w9KzY//bzAaHiB18aDMYqDnwk/daSLxNlXkwbUHCDsCPwAw86D8zB5xzM5TbKdaQPXkaTwE0uSBDEjGUjeuLy6UYmnkNgTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057161; c=relaxed/simple;
	bh=542knEL90v6i/7hz3XV0Vy60hlfpuP7J33yqdYGR1Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2COrOKMora2c/cJk7fClYAW5+fOqO9MVbcZ76yWixPtDQFnXIbJqzeTKmaU2L2UEIYRx6y0jDNF2Qfbd8V7nhRmYEQqennx0Jrfulq68vT0xBMlTzKZXpGaGo36fus181+FgmN4QLyHUJo66S/u+/+pBeiDDeyPI2JuwYKWstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UPp6amXj; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F9RIeA1TZukOUNP6Woaqx12d+XEAnqxID4oNu82lBjM=; b=UPp6amXjeEQPh+k9tBqxn0YSJZ
	u3BBbq8HShliOUHO3Qu1Suc/fYwj+RaBKkzydtQLXgFI8WC6mRENY+PtYmrpdCVRXnW5bWy/uANAR
	xfDYxxfeJYXCODusAjcRqhIyjVgnwkj3SwgrU3kEVKXQGPAWXzVsPtpORB/1+6w57K3IxjiPjlYnJ
	+ruMPgTVLfq/2TFO/B4XOQMFv+6I2eFjfjpCT+GByE8Fbg7d5GPMa/SFAoleKsPBcwdJKp/gNXlWq
	crWa2D7DSGLFo6gfvmbjVE6/PLsRr/PWAL6ch1rbZhE3/feP/CtKS7Idweipu1/0UJLdi40Ei+ryC
	2otWYNCQ==;
Received: from [84.65.48.237] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uZS5y-00EQLN-Ey; Wed, 09 Jul 2025 12:32:10 +0200
Message-ID: <6af2a9c2-b3ac-44e0-8bbb-026809a28a6c@igalia.com>
Date: Wed, 9 Jul 2025 11:32:09 +0100
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
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Binns <frank.binns@imgtec.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250709102957.100849-2-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20250709102957.100849-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
> ---
>   drivers/gpu/drm/panfrost/panfrost_job.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 5657106c2f7d..15e2d505550f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -841,7 +841,6 @@ int panfrost_job_init(struct panfrost_device *pfdev)
>   		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
>   		.credit_limit = 2,
>   		.timeout = msecs_to_jiffies(JOB_TIMEOUT_MS),
> -		.timeout_wq = pfdev->reset.wq,
>   		.name = "pan_js",
>   		.dev = pfdev->dev,
>   	};
> @@ -879,6 +878,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
>   	pfdev->reset.wq = alloc_ordered_workqueue("panfrost-reset", 0);
>   	if (!pfdev->reset.wq)
>   		return -ENOMEM;
> +	args.timeout_wq = pfdev->reset.wq;
>   
>   	for (j = 0; j < NUM_JOB_SLOTS; j++) {
>   		js->queue[j].fence_context = dma_fence_context_alloc(1);

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko


