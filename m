Return-Path: <stable+bounces-76996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10EC9846D9
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 15:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767B9281810
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 13:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4085C1A7249;
	Tue, 24 Sep 2024 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7AqGC7Y"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A251E505
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185052; cv=none; b=IgOHhneT6XANW/tsOrdRNXfBtYyooQABeIbKQjJHw295RVPwxjowwMX1OWrgmqeA5YMBcmv0iAymqUTaYKyUr4Ci4wg8g2Z9/CuB2ZwCXIZuHyI7zrt1pKZdg7jg0yZsoDIf3OCItECjBfWbXEuDvPYub6ChtCZ7sWLka/1+tpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185052; c=relaxed/simple;
	bh=1coDdoI3FQjwjHSKdOOaReMrK64BktDVhJoYCrWpeFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CAX04JlWg2i1zr3dV3tJ0VCP/Fg6UH3iKIBxToHtqVFYZQ9oegVx5yRMRTcADV+ZwkuNW4wmScwpuJhsb2cHzYz38oh6nvg+f0Q+iu7L7cxWKGZAcW7MdIoRddcvNIoNR3pAkCeyl9rmANpTFFIlqlV9J9HWdi8OumQi3BLw85s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c7AqGC7Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727185048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m3ZMnWSltBVqByR/5ym5WHRFLuJsdiXWp7fp/aKe+pg=;
	b=c7AqGC7Y7bjOsDGW+Rv6sKHEestkNaXyfZLpJlZszCYMbFd02IQBERJKAyUaqPNa8qDBjq
	aAOazIyKvc+UwI1vt1UOepLVJ8KO4WLVNrE3EJvMw1yD3g+CrOgDBK4gK+zkxd5zzcEuWp
	Mvbn901LuylsqrAsXnX+zpnwZCjmsHE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-pUtvYtyOPmSGVYdPJpINDA-1; Tue, 24 Sep 2024 09:37:26 -0400
X-MC-Unique: pUtvYtyOPmSGVYdPJpINDA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb635b108so39057305e9.2
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 06:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727185045; x=1727789845;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3ZMnWSltBVqByR/5ym5WHRFLuJsdiXWp7fp/aKe+pg=;
        b=rt3dLRIk5oNV88/FlETMcbU5ys1GeKPWVwVfVJDskFYPv+BxgiF6rQRqQxMc+EvtNa
         zH/xgrjpBdxCfhMdTI4H0JTi8E1UYHVbds1wSGPoeh71XLXnru9Fln7Cdx6ijmzU1N9m
         IJD4k5ZIsPc0U08rIIYWfF4Js4wC5wKV4n91g4hFv9GUZm9oTYMmWpKkWwLjOFVHi3AW
         H70ws9+2pobvLL7YNMVpZPHV3Rolx51ihhzvH911eui7WBxjlSAldUb1S+5bx9CkHAEf
         qqrzzRoMDhsIOQ6ECMRpQLEwr2klg5DTRHFEXd+GHbXVa8niG00DV1xSXuflDgO61zuQ
         zF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRMr/vwihGdeXdPiOtzHir5lkJF+p6tRWfXpqEewqyW6nyFz9tdxe0fYodsHExFQBzNqDmE4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB/kImLIXxBDua2Tk0QMMjD+hS4AVnzCfApq26H+F1IKMEiD58
	3NmlpMhDxSNgQ9vkwlJ0y0JyMuGX1kaATZmeoUTe0GAQb8r80hxoxnjvgK/WAK2cIZYGBi7Tnvu
	gpfZW9IBT0Q5V3/TzwEULcTcymgE0/f52QetDjuZiFMO7zRjySO+JDg==
X-Received: by 2002:a05:600c:4ed2:b0:42c:b9dd:93ee with SMTP id 5b1f17b1804b1-42e7adbdf3fmr106404145e9.34.1727185045160;
        Tue, 24 Sep 2024 06:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAGSCJGChfO0p/dVmzD7aUd+YN0JjwCVik6wNggfJqRwa1bUk53dA48t1HKhd+ZLlCkGswjA==
X-Received: by 2002:a05:600c:4ed2:b0:42c:b9dd:93ee with SMTP id 5b1f17b1804b1-42e7adbdf3fmr106403925e9.34.1727185044775;
        Tue, 24 Sep 2024 06:37:24 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2c139esm1614306f8f.27.2024.09.24.06.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:37:24 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, alexander.deucher@amd.com,
 chaitanya.kumar.borah@intel.com
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann
 <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Sam Ravnborg
 <sam@ravnborg.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, "Linux
 regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
 stable@vger.kernel.org
Subject: Re: [PATCH] firmware/sysfb: Disable sysfb for firmware buffers with
 unknown parent
In-Reply-To: <20240924084227.262271-1-tzimmermann@suse.de>
References: <20240924084227.262271-1-tzimmermann@suse.de>
Date: Tue, 24 Sep 2024 15:37:23 +0200
Message-ID: <87ldzh8964.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> The sysfb framebuffer handling only operates on graphics devices
> that provide the system's firmware framebuffer. If that device is
> not known, assume that any graphics device has been initialized by
> firmware.
>
> Fixes a problem on i915 where sysfb does not release the firmware
> framebuffer after the native graphics driver loaded.
>
> Reported-by: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
> Closes: https://lore.kernel.org/dri-devel/SJ1PR11MB6129EFB8CE63D1EF6D932F94B96F2@SJ1PR11MB6129.namprd11.prod.outlook.com/
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/12160
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: b49420d6a1ae ("video/aperture: optionally match the device in sysfb_disable()")
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info>
> Cc: <stable@vger.kernel.org> # v6.11+
> ---
>  drivers/firmware/sysfb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 02a07d3d0d40..a3df782fa687 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -67,9 +67,11 @@ static bool sysfb_unregister(void)
>  void sysfb_disable(struct device *dev)
>  {
>  	struct screen_info *si = &screen_info;
> +	struct device *parent;
>  
>  	mutex_lock(&disable_lock);
> -	if (!dev || dev == sysfb_parent_dev(si)) {
> +	parent = sysfb_parent_dev(si);
> +	if (!dev || !parent || dev == parent) {
>  		sysfb_unregister();
>  		disabled = true;
>  	}

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


