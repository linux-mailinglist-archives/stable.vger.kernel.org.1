Return-Path: <stable+bounces-92993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BF79C886F
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 12:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1461D28232F
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 11:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E291F81AC;
	Thu, 14 Nov 2024 11:08:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9AE1F6688;
	Thu, 14 Nov 2024 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582496; cv=none; b=nI1LaDVtYhYKqG94lp6AYDC9IF4t4Vq+yJLsWNxdbnw7WmX1vKs/we4PWSc7bB8eFPuoSdrPoXuLso0+vqyAI8exO2g5lHjuTKIAmBrHFlFPihTdoJe9t1wYWPBKCaXL9rfqBiL5ekKDxy49Ub5UaowwGRA2X/AQgtNh5wWYOQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582496; c=relaxed/simple;
	bh=tb+DE/3FFVpWcHlT5GqU34l2C45HcATrVfwwmIhWgBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OC3IbYxZs324xhUOgpYSYfJGN0ngFFXM8wnH3Gr6dyylTqCHSDqHZrx/p33WPq0RO56S5pyw1U5/2owB6I2SpvCxPy0UE/Au0J04BiekP8fkLo6qae27ZeQp/VBJH63wXn2Hfmxn22cI5JufP1wNvGk+3o7hSYk91iWZnFrXqVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C29F81480;
	Thu, 14 Nov 2024 03:08:42 -0800 (PST)
Received: from [10.1.26.55] (e122027.cambridge.arm.com [10.1.26.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155EE3F6A8;
	Thu, 14 Nov 2024 03:08:09 -0800 (PST)
Message-ID: <e661a2e2-9a6a-40f4-843b-3c7285ca2172@arm.com>
Date: Thu, 14 Nov 2024 11:08:07 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Fix memory leak in
 panthor_ioctl_group_create()
To: Jann Horn <jannh@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mary Guillemard <mary.guillemard@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241113-panthor-fix-gcq-bailout-v1-1-654307254d68@google.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20241113-panthor-fix-gcq-bailout-v1-1-654307254d68@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2024 21:03, Jann Horn wrote:
> When bailing out due to group_priority_permit() failure, the queue_args
> need to be freed. Fix it by rearranging the function to use the
> goto-on-error pattern, such that the success case flows straight without
> indentation while error cases jump forward to cleanup.
> 
> Cc: stable@vger.kernel.org
> Fixes: 5f7762042f8a ("drm/panthor: Restrict high priorities on group_create")
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

> ---
> testcase:
> ```
> #include <err.h>
> #include <fcntl.h>
> #include <stddef.h>
> #include <sys/ioctl.h>
> #include <drm/panthor_drm.h>
> 
> #define SYSCHK(x) ({          \
>   typeof(x) __res = (x);      \
>   if (__res == (typeof(x))-1) \
>     err(1, "SYSCHK(" #x ")"); \
>   __res;                      \
> })
> 
> #define GPU_PATH "/dev/dri/by-path/platform-fb000000.gpu-card"
> 
> int main(void) {
>   int fd = SYSCHK(open(GPU_PATH, O_RDWR));
> 
>   while (1) {
>     struct drm_panthor_queue_create qc[16] = {};
>     struct drm_panthor_group_create gc = {
>       .queues = {
>         .stride = sizeof(struct drm_panthor_queue_create),
>         .count = 16,
>         .array = (unsigned long)qc
>       },
>       .priority = PANTHOR_GROUP_PRIORITY_HIGH+1/*invalid*/
>     };
>     ioctl(fd, DRM_IOCTL_PANTHOR_GROUP_CREATE, &gc);
>   }
> }
> ```
> 
> I have tested that without this patch, after running the testcase for a
> few seconds and then manually killing it, 2G of RAM in kmalloc-128 have
> been leaked. With the patch applied, the memory leak is gone.
> 
> (By the way, get_maintainer.pl suggests that I also send this patch to
> the general DRM maintainers and the DRM-misc maintainers; looking at
> MAINTAINERS, it looks like it is normal that the general DRM maintainers
> are listed for everything under drivers/gpu/, but DRM-misc has exclusion
> rules for a bunch of drivers but not panthor. I don't know if that is
> intentional.)
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index c520f156e2d73f7e735f8bf2d6d8e8efacec9362..815c23cff25f305d884e8e3e263fa22888f7d5ce 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1032,14 +1032,15 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
>  
>  	ret = group_priority_permit(file, args->priority);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	ret = panthor_group_create(pfile, args, queue_args);
> -	if (ret >= 0) {
> -		args->group_handle = ret;
> -		ret = 0;
> -	}
> +	if (ret < 0)
> +		goto out;
> +	args->group_handle = ret;
> +	ret = 0;
>  
> +out:
>  	kvfree(queue_args);
>  	return ret;
>  }
> 
> ---
> base-commit: 9f8e716d46c68112484a23d1742d9ec725e082fc
> change-id: 20241113-panthor-fix-gcq-bailout-2d9ac36590ed
> 


