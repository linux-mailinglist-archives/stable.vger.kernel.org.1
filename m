Return-Path: <stable+bounces-132835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 966F7A8B58D
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 11:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A056444CA6
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A482356BC;
	Wed, 16 Apr 2025 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKWwpE4B"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0C423536C
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796183; cv=none; b=gJOBF+F3lTQJNPLcYKx4ia6S4bTQ/2LAdjtwTULLg2t5xgk9PzXlUF7VCngb9gW5f+Acpl3VV/XGtL4/Trgy4Wtq7MljZu7S0KlktMJWtq8nCq7y9NFoqd7UU9D8CE+hmra114FV/5zC/08aAB/v78E1+/tHeH3d2WOTGMnSmQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796183; c=relaxed/simple;
	bh=PPdxECl+94voAqVmhWcgJxKR+G1XeuTCTjP7lbdMAk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TT91z3YyrXMShPWSlVy4VxQPKWZTP0qlW5kkIJGffRGJo1wnnOwJks/nB0UXb8Nde9o4mylngAZ0Y+vVwgHN5Dy7tHK5lp1Ve1NdLI+GB7IZMG8yzjWZT25Uc/fUxmYpUwBwWAbu9JhOjvIRz2VpDp3G44yzexjZ/hLAtgWzBrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKWwpE4B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744796180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sged5tAyl8kCLtoBMdfM15On67zV+o35GLQbuU7lJQk=;
	b=RKWwpE4BYovDPwmrheUgPbUcrhVP9weBdiS1d9afvFP5PdfIPLmv3ANhvpSFclaMLxRKjP
	Zy5DeIyzgiZ7nFzbYRJVpW7zy9De3VpkvY/8UawDYpeTYf9cfZnSY2T0bRdzn+dhTcbxp2
	J6NDd5hcp8/vpsghmxrUMV9FDwDkl7w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-meXb6MmQPwyyQ7_zOvJJWw-1; Wed, 16 Apr 2025 05:36:19 -0400
X-MC-Unique: meXb6MmQPwyyQ7_zOvJJWw-1
X-Mimecast-MFC-AGG-ID: meXb6MmQPwyyQ7_zOvJJWw_1744796178
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43efa869b19so45116275e9.2
        for <stable@vger.kernel.org>; Wed, 16 Apr 2025 02:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744796177; x=1745400977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sged5tAyl8kCLtoBMdfM15On67zV+o35GLQbuU7lJQk=;
        b=Vr5NycqUAgOKL4/daTgyswJJhiXGnfXrS92xptBQFLibH5FC6lHnDEoV2lIzoh6JcC
         9rApRgjDl6ba2W0Fp0oIOPT0WnbeIQ7gabPTWDFA1Zmor0npOn7rI6kvLICN3UXwf0ek
         ME+1F4W+9+OJRZ27pGK5lPOHiaG+Kwxd1OOFOOvdohC2TrnLpskhG48Eiz0482D7KqQM
         6KHnmw0X1HIM3ot4sH0vBB4ePd3+FpxxNd0/Q61ohc58bx0YVkbdiej5msTQBB2gsMTp
         guXvffmul1uFli6/ZRWz4Zu+oilSbFbiv7QJ4HnW/pjabZVnr08YnkYPXIEZNJ9a5SCx
         rrQA==
X-Forwarded-Encrypted: i=1; AJvYcCVSsHxNBlssXCaciZoRAS4RewEkB42WBf//b8hnWgduDvaC/FoDVsdz+d3BOLE/rkQFvA30jnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoscXBJ1nn83m2B9BgbriPTf9O3GLef/U5mZKNEQkeMa3tJqjL
	XIs74z4H9+yqvDPpXGXFnqn7umqlUcj+AIqBRQVR5/WmbRtp5Ve1H3fgneLVT/zBqFgafjTN1My
	vDS1WPaMJz30ti9AAj4cYTNPKnJYgN1DgKeTiiG7dXYj6UrOK4zYffk9+kIMSlQ==
X-Gm-Gg: ASbGncvAt1gqs+KYXqyYvSG0d7hxuGwcEE1vHAwh4WwILn/cT6dYtmb/A+Jn2el2Nmb
	YWyTahTLPOSjMyOms+yuU+SsY+yp8TjKr6uaaswFulOovF0odXNGSmHhPyGzJyAU+j0pqT37itt
	zXYMge+LrZ1r701yhW5p8CNuWRkxRoWcQm1tZL9vWtzJouHHEwVSu8/iD+ONQ7gWZhmpAvLcMIN
	tUkSAv4RPia97sWGQprtGk4zhcP/fbgKPEizTDtL7gLa+Qyy+xxVJE5IYA4lNf6+cAeiI1ikn5l
	Eg32C33nBExDszm+ruZ8f8er0j5blVuo8rkDoH4fWaRqod59DfA=
X-Received: by 2002:a05:600c:4688:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-4405d69b7acmr8320965e9.20.1744796177370;
        Wed, 16 Apr 2025 02:36:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHxus+/zkcBTc5r/1IQaSd+xYWcRd0zPCTMc+e/kR8bd+9MgjmqmAf5ZHQJjwZjgaCDL4+9w==
X-Received: by 2002:a05:600c:4688:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-4405d69b7acmr8320655e9.20.1744796176740;
        Wed, 16 Apr 2025 02:36:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4d105bsm15618345e9.11.2025.04.16.02.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 02:36:15 -0700 (PDT)
Message-ID: <f32eff25-125c-4384-a395-a459ee165429@redhat.com>
Date: Wed, 16 Apr 2025 11:36:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mgag200: Fix value in <VBLKSTR> register
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 wakko@animx.eu.org
Cc: dri-devel@lists.freedesktop.org, =?UTF-8?B?0KHQtdGA0LPQtdC5?=
 <afmerlord@gmail.com>, stable@vger.kernel.org
References: <20250416083847.51764-1-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250416083847.51764-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/04/2025 10:38, Thomas Zimmermann wrote:
> Fix an off-by-one error when setting the vblanking start in
> <VBLKSTR>. Commit d6460bd52c27 ("drm/mgag200: Add dedicated
> variables for blanking fields") switched the value from
> crtc_vdisplay to crtc_vblank_start, which DRM helpers copy
> from the former. The commit missed to subtract one though.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Reported-by: Wakko Warner <wakko@animx.eu.org>
> Closes: https://lore.kernel.org/dri-devel/CAMwc25rKPKooaSp85zDq2eh-9q4UPZD=RqSDBRp1fAagDnmRmA@mail.gmail.com/
> Reported-by: Сергей <afmerlord@gmail.com>
> Closes: https://lore.kernel.org/all/5b193b75-40b1-4342-a16a-ae9fc62f245a@gmail.com/
> Closes: https://bbs.archlinux.org/viewtopic.php?id=303819
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: d6460bd52c27 ("drm/mgag200: Add dedicated variables for blanking fields")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.12+
> ---
>   drivers/gpu/drm/mgag200/mgag200_mode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
> index fb71658c3117..6067d08aeee3 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
> @@ -223,7 +223,7 @@ void mgag200_set_mode_regs(struct mga_device *mdev, const struct drm_display_mod
>   	vsyncstr = mode->crtc_vsync_start - 1;
>   	vsyncend = mode->crtc_vsync_end - 1;
>   	vtotal = mode->crtc_vtotal - 2;
> -	vblkstr = mode->crtc_vblank_start;
> +	vblkstr = mode->crtc_vblank_start - 1;
>   	vblkend = vtotal + 1;
>   
>   	linecomp = vdispend;


