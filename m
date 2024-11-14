Return-Path: <stable+bounces-92977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C57979C83E0
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 08:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E391F223DE
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 07:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2C31EBA0F;
	Thu, 14 Nov 2024 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="odBwl5pE"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EE270818;
	Thu, 14 Nov 2024 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568515; cv=none; b=FLRVoRQG2qVvVan/3UIsdGky0o7Qwfd4mFjXWcxddFlu28ePoysDzuUEwzRqhef+kIpaNpsgcxwsWnzDAk6qPXpMrBpChLD/KP0u9/MoyvRv/4/hfyWylYfFBcHyzruCaB6h31gNHPwQ8vuj91RmgV8mWiHR/ysguX67GggomW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568515; c=relaxed/simple;
	bh=WpXr/RM7L+0l9LR7VF/wPK+QoQZyKQDk8ICJEympyiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgylZt+y0C5rXaLf2Gm2lmP7kMardGX5TKHd8fqoDSrKU8vlCjrX751rY9nHgv9vKMfEFeM6CoYXyAqz462fb/Hf7CYyUyTWiFngPw5uIt08+kF+GIvDIzl96xDLflJR/yNC0PRweJzW5lTMbE44FVupiTm81hHGYS1arR7nJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=odBwl5pE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731568511;
	bh=WpXr/RM7L+0l9LR7VF/wPK+QoQZyKQDk8ICJEympyiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=odBwl5pE1ksHcTbutVvsh6vqThMdXPFYOaF5cHe90k/0JdWQt4EreYKxTET3HimSc
	 nN5H7Vx/FzYoyaaIT8L1wrj5XxELCfgEJpN1AluNSE1TPi2tRFmShsal1FpxurUptt
	 GNHbpjNH3uNig0HR1bK8sWSkspfL63WrNmwBDGR0WPw4wYz9OkquEAaGUr65aplzd0
	 Ith8YeiKsfXTBX2a6aSRKQpCdsp17zCnHEs7ai5Lj62gMt/FtrdScKOGgfluNznWZQ
	 4VqXhkcK2fTvp9ZmESpZ7qNrgBqL1ZPsECPr5M28U/SqIKdBaIDC5ND8fTd0hwjdn1
	 a5mm3joc4XfjQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BBDC917E120F;
	Thu, 14 Nov 2024 08:15:10 +0100 (CET)
Date: Thu, 14 Nov 2024 08:15:07 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Jann Horn <jannh@google.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Mary Guillemard
 <mary.guillemard@collabora.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix memory leak in
 panthor_ioctl_group_create()
Message-ID: <20241114081507.6ac6b5f9@collabora.com>
In-Reply-To: <20241113-panthor-fix-gcq-bailout-v1-1-654307254d68@google.com>
References: <20241113-panthor-fix-gcq-bailout-v1-1-654307254d68@google.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 22:03:39 +0100
Jann Horn <jannh@google.com> wrote:

> When bailing out due to group_priority_permit() failure, the queue_args
> need to be freed. Fix it by rearranging the function to use the
> goto-on-error pattern, such that the success case flows straight without
> indentation while error cases jump forward to cleanup.
> 
> Cc: stable@vger.kernel.org
> Fixes: 5f7762042f8a ("drm/panthor: Restrict high priorities on group_create")
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

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


