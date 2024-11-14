Return-Path: <stable+bounces-92992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C669C8826
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 11:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2195A1F26F5E
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 10:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9D21F8918;
	Thu, 14 Nov 2024 10:54:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F931DE4DF
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731581677; cv=none; b=bheUcWwLS+ExTW/Aw/5hincwhrlBwCSmQ+H+7YFrIxaGyOSt5GX0fVc+OuSDaIrbMVf5sCc61CsYf6ip+l1wd1qwY+qByg+QfkWWg69nyIUCafc6wP0CWLTnmItWHRmdsj8XFyQvGWfRzTjnBkl5pjBGPIYK20r8/N0x2ik9kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731581677; c=relaxed/simple;
	bh=SHJReqYsQIlDAA+Yf89BFwqztPRAny2m9Xkr2nb7rgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpnA+H7AG3pAAI5QmPLFQHEGbqeI2w0W6Xx+3HwFYlHaJ9QfiqGi8uTB0QA3tj6E6RjWjqAiwqK2CxNuzDo8i9om/JjqwazVL58x8/eZat7UEaPPDIiLpXvY88g6dhhp3J0g2947DzptkKS95UeTFwcFOaJFsEXnpneNwmv47n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85B812BC2
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 02:55:04 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31D0C3F6A8
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 02:54:34 -0800 (PST)
Date: Thu, 14 Nov 2024 10:54:20 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Jann Horn <jannh@google.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Mary Guillemard <mary.guillemard@collabora.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix memory leak in
 panthor_ioctl_group_create()
Message-ID: <ZzXW3Jtw2saF-CFb@e110455-lin.cambridge.arm.com>
References: <20241113-panthor-fix-gcq-bailout-v1-1-654307254d68@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241113-panthor-fix-gcq-bailout-v1-1-654307254d68@google.com>

On Wed, Nov 13, 2024 at 10:03:39PM +0100, Jann Horn wrote:
> When bailing out due to group_priority_permit() failure, the queue_args
> need to be freed. Fix it by rearranging the function to use the
> goto-on-error pattern, such that the success case flows straight without
> indentation while error cases jump forward to cleanup.
> 
> Cc: stable@vger.kernel.org
> Fixes: 5f7762042f8a ("drm/panthor: Restrict high priorities on group_create")
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

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

It is intentional, the drivers excluded from DRM-misc have their own trees
and maintainers. DRM-misc is more of a group maintainership where everyone
with maintainer rights in DRM-misc can push patches and send pull requests.
Not all of us do it that often, so the most active ones are listed in the
MAINTAINERS file.

Best regards,
Liviu

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
> -- 
> Jann Horn <jannh@google.com>
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

