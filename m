Return-Path: <stable+bounces-108230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8C1A09BBE
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 20:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDF31697F4
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 19:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7922144BA;
	Fri, 10 Jan 2025 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cQfewTsR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802324B248
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536793; cv=none; b=hY/TkRBC8TtMBZ0CgA4zZ5e/PiFP9Hak7H7rgd6pHzU0y4R+jLsPuFlbqPm7T+KTWUMdubp2dSV+y8b4aFSjqMLN9h6rLo6SXe39hOo0qoKFtinnqqCyRINzYwPze6hL2o10l9l2ZsBdi3+IhOAMGZtObWcKHdY2hIiZbTitkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536793; c=relaxed/simple;
	bh=IWtOdyNlzPCoQDmjGceXDZfyR2Z68NZKetnYn028dbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPFl8IXu8QJVnakF9ZoWZqlSl9OmtOcvP4va69eufpP0rZ9bR1cefLW+44oRaS+8QVMGekN6ma7AZ5k3xJgfwL+OnUQpif/CFg6Xc95U1uGjtCjH2XjTs0FOQaLar2yAIAQBzvF2xO0MlGJAIbOarjzcGi73B0xThunl2LlGSvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=cQfewTsR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436a03197b2so17771645e9.2
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 11:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1736536790; x=1737141590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J80hwrHQqzeoTkDC+Lfua1rPRYfFeh84D/XME2XqQ0g=;
        b=cQfewTsR9RFFpJ5oFBeweHQwSJWqgyqXh11BCQan23WaM6uH9fHjaMJeAbHAsZK8uO
         y1If8Dx966v4xY///714XaKzuNuofP1DGbXyLffDBL6MVTnOtNOmsxBn33etYe/l20AI
         3Q37YMl/8Mguha56wv3r90hin7ysuZIGMMei4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736536790; x=1737141590;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J80hwrHQqzeoTkDC+Lfua1rPRYfFeh84D/XME2XqQ0g=;
        b=bnri5WvxuCMW5gUodICs3SFaYH7j4n+mQEfGyG///X+zoLF3jEQwIk9XW9Hi4EbpX7
         TR3EewBkelIz/U2ReAFK5T+UeBLFEQEcb5Xhg7x7xQsryY0bCOOT6OT1xy3ZSOKKZy3y
         mEJNY43cDIkawSBQG4hcQufmdl/7QUdMTtbTfQ8FsWmud1AsxYzbAGZMKdhSbskLQlpq
         TTaZChvTYGQuLgTarfNCv4qJZr0BS6rVyG2VWr9eDSDz0gVNAkRk1R4px++TYYKEEmrj
         8CXlYMMwNIqp0NHCzWDgAimk8KjTz8ZVRxydmP3qSbU8VB4DQaQiQIVuVbjxYneTC2sl
         LXgw==
X-Forwarded-Encrypted: i=1; AJvYcCXm2a2QqJGz02GiSdn3BSXBFSHup8B3yduynj7ROjSMIHWcO4EvKPjcI9yAXg7n/3/Q15Ibhek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5MCadvyOTKHkQnAVJ/h1jbvDoyY4dFcIn/XauI5kGTWRl3z9o
	d8abTJ6/HoBgRjTQas/F35vQb71EsBQ7Bd8bBq8OjxYqo5pa7z5it0HEbh5lwbw=
X-Gm-Gg: ASbGncs1AyVwWQO203hxxwDA45kDQCz4b9ON3B7xIZp9FbB2/HqD8w2BxgzRKZEo07H
	uwmjapWxpsBaDhakSkk1IvHm1sPPh3IOzQ67BpvsumyHsaVlq7gFpzWCw6RSQRraXMXiecBkcBJ
	v/RoJ1o/HOLBEZnZRnHDsAOLS30h+ddIb7e8N2jTHfoLhtJ5FTGbiTxb7/fBCX0qUOhOeRZPARz
	ii8bzN9XCOPvUnxofw60DdDJAiGwNsOmrI2runSIOHOqqbM7OCPSzVKq5L9LHo5hIQa
X-Google-Smtp-Source: AGHT+IHbD9hx5MizCz9A5ppQUUAZ2G7xGpUfk4GcyU7iEMldA5WVYOdJ209mUwDG82HgKY3UKSxngQ==
X-Received: by 2002:a05:600c:1c85:b0:434:a1d3:a331 with SMTP id 5b1f17b1804b1-436e26f01c1mr99108515e9.22.1736536790079;
        Fri, 10 Jan 2025 11:19:50 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dc8802sm60338755e9.10.2025.01.10.11.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 11:19:49 -0800 (PST)
Date: Fri, 10 Jan 2025 20:19:47 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	syzbot+9a8f87865d5e2e8ef57f@syzkaller.appspotmail.com,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>,
	Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/vblank: fix misuse of drm_WARN in
 drm_wait_one_vblank()
Message-ID: <Z4Fy04u7RjaZIsqI@phenom.ffwll.local>
Mail-Followup-To: Vitaliy Shevtsov <v.shevtsov@maxima.ru>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	syzbot+9a8f87865d5e2e8ef57f@syzkaller.appspotmail.com,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>,
	Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20250110164914.15013-1-v.shevtsov@maxima.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110164914.15013-1-v.shevtsov@maxima.ru>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Fri, Jan 10, 2025 at 04:49:13PM +0000, Vitaliy Shevtsov wrote:
> drm_wait_one_vblank() uses drm_WARN() to check for a time-dependent
> condition. Since syzkaller runs the kernel with the panic_on_warn set, this
> causes the entire kernel to panic with a "vblank wait timed out on crtc %i"
> message.
> 
> In this case it does not mean that there is something wrong with the kernel
> but is caused by time delays in vblanks handling that the fuzzer introduces
> as a side effect when fail_alloc_pages, failslab, fail_usercopy faults are
> injected with maximum verbosity. With lower verbosity this issue disappears.

Hm, unless a drivers vblank handling code is extremely fun, there should
be absolutely no memory allocations or user copies in there at all. Hence
I think you're papering over a real bug here. The vblank itself should be
purely a free-wheeling hrtimer, if those stop we have serious kernel bug
at our hands.

Which wouldn't be a big surprise, because we've fixed a _lot_ of bugs in
vkms' vblank and page flip code, it's surprisingly tricky.

Iow, what kind of memory allocation is holding up vkms vblanks?

Cheers, Sima

> drm_WARN() was introduced here by e8450f51a4b3 ("drm/irq: Implement a
> generic vblank_wait function") and it is intended to indicate a failure with
> vblank irqs handling by the underlying driver. The issue is raised during
> testing of the vkms driver, but it may be potentially reproduced with other
> drivers.
> 
> Fix this by using drm_warn() instead which does not cause the kernel to
> panic with panic_on_warn set, but still provides a way to tell users about
> this unexpected condition.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: e8450f51a4b3 ("drm/irq: Implement a generic vblank_wait function")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+9a8f87865d5e2e8ef57f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9a8f87865d5e2e8ef57f
> Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
> ---
>  drivers/gpu/drm/drm_vblank.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 94e45ed6869d..fa09ff5b1d48 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1304,7 +1304,8 @@ void drm_wait_one_vblank(struct drm_device *dev, unsigned int pipe)
>  				 last != drm_vblank_count(dev, pipe),
>  				 msecs_to_jiffies(100));
>  
> -	drm_WARN(dev, ret == 0, "vblank wait timed out on crtc %i\n", pipe);
> +	if (!ret)
> +		drm_warn(dev, "vblank wait timed out on crtc %i\n", pipe);
>  
>  	drm_vblank_put(dev, pipe);
>  }
> -- 
> 2.47.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

