Return-Path: <stable+bounces-56093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0621091C622
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 20:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375DF1C2167F
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 18:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAE45381B;
	Fri, 28 Jun 2024 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le76Qd8d"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AED27725
	for <stable@vger.kernel.org>; Fri, 28 Jun 2024 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600923; cv=none; b=S1Hm/u381HrYSyEkphiVRywa/3DM/72uRT2GyC695aDG0WDBQh4TtQ0CXMeDAqrZ3coM2MI30ozfTeOGrEXJ6T4MoK68a0gn1rYmnC1Nj+V+99UtWpN9uvS9ayzMqUFzbtdavGsEAF4bTtDLmBRcvfpbVJXHNEbsQhuN6Mshmlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600923; c=relaxed/simple;
	bh=VGnqPJ8wxBUmzeYRoezSLG01KIOdBTaj3d4KEl5C6q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUzAapq1KLAUHCfBevFsw/tX2PpUZEnwE0iN9nttxRu/yEnQJhvdT4HM2hM6AWp2KuRDxa+KUlWbaQVN9sQOim9WsN6HpXR/ZSl2xcbgR/8zOVfMK5ij1QtrxCoOc4+j78aCNAqu0MyYvq6bvnIQH2Jrj6TISay7xbudD1Ucuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le76Qd8d; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d044aa5beso1278584a12.2
        for <stable@vger.kernel.org>; Fri, 28 Jun 2024 11:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719600920; x=1720205720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLIc478CrM8WRyLsKp7HKGbFT+nWGbRboxpgjYNwu6s=;
        b=Le76Qd8dgaODvQFRveEhKk7CsMZn416e2mJeo68WKIz900EyVfCTsUnDeeRvxGo11A
         bm67lQjNyN8mT44svysHSq5F59l4Xv2fgTUbXMUF4mULaGD6Ye3PCJiGwO6g0EmutzFL
         gBweEDJl0LpRONXZAVgjsFJLpBBZg7SZ5ALFB4qbF7KCMBeA3UfXlJMdUGMglIfMpj3e
         O6TarJxdVf7k5HwdnCftPIWyx8JORa1Yj3TDE5q6RL2Y9xP6xsA3Gb9HqLBvafuWKrJk
         hYJUuKnyef8+OEHNHYjp98pRqbKHn+PRkGNF7k8PiqSTK401j8ImwffawdTtYHKi8Dt8
         GQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719600920; x=1720205720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLIc478CrM8WRyLsKp7HKGbFT+nWGbRboxpgjYNwu6s=;
        b=pbi/k4YDcjWwtZUjR52FFcIyyTDVk90PB0Qv/hC+QC2Bz9ZOrbk7pZHJowUw0ucK0Q
         KW5gmfGcIEsMMtzQpRJrJxL3+xeOCPPJPG9cqOhu3GMisea/R0xRHQ/uNBP7WRVAgsI5
         orRbfZ+scjSQPIy/CvhPxwLDp1rRH9qkgrdg7+2G8vtijbDX38LKj90aHSFWGf016K4y
         SNb4zL0GQr75TUNThTj7UcUNRthVb3RtoGYnpSw6gwRyQRTmoElmvjWsd4vPPsDWQ76N
         S1CSqiYcz//e7kJVcIscHRyc4wS6PHrQhLqmTWVPR5wmqkOwDgJypPv3LXGG2E3tijrE
         rznA==
X-Forwarded-Encrypted: i=1; AJvYcCUdrfOWmyNJyhVgdBY6GoMl5IzUn3J/Zc2rmLenSjO8FrDuZh8VYnL21ZCXU88R4Up7+C42SfyV5eKQbj52C7QUEsPEURh/
X-Gm-Message-State: AOJu0YzyYuHUIUGOQnSJPRqYlnZNDJWsrjrbjMf2cKNXedMp9HkvL3qs
	YEtk1WX7dexG82PquWD8KsurHk3IbDuhNVSsYvrVdQdozUT+0RWzDFNM6zQXgU1qPAH25yzYj4I
	awoCNN4GPP9kfH4Iso/Hn3uL+SeU=
X-Google-Smtp-Source: AGHT+IHeGM3d7YvzcLQJxAxEGdEg5stxZMe7tyJA5kiIIVgTMzM2ylMjwUFy3aKkTXzmqtMIOpkybbDc3e5mBxpP3kM=
X-Received: by 2002:a17:906:7955:b0:a72:98a0:7159 with SMTP id
 a640c23a62f3a-a7298a072damr462138866b.68.1719600920041; Fri, 28 Jun 2024
 11:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625081818.15696-1-tzimmermann@suse.de>
In-Reply-To: <20240625081818.15696-1-tzimmermann@suse.de>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 28 Jun 2024 14:54:42 -0400
Message-ID: <CAAxE2A68QveD4nNa_OyQQHYSdbvArck6oWnV7YsmWC89B8x=yA@mail.gmail.com>
Subject: Re: [PATCH] firmware: sysfb: Fix reference count of sysfb parent device
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, dri-devel@lists.freedesktop.org, 
	Helge Deller <deller@gmx.de>, Jani Nikula <jani.nikula@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Sui Jingfeng <suijingfeng@loongson.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

FYI, this doesn't fix the issue of lightdm not being able to start for me.

Marek


Marek

On Tue, Jun 25, 2024 at 4:18=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Retrieving the system framebuffer's parent device in sysfb_init()
> increments the parent device's reference count. Hence release the
> reference before leaving the init function.
>
> Adding the sysfb platform device acquires and additional reference
> for the parent. This keeps the parent device around while the system
> framebuffer is in use.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 9eac534db001 ("firmware/sysfb: Set firmware-framebuffer parent dev=
ice")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Sui Jingfeng <suijingfeng@loongson.cn>
> Cc: <stable@vger.kernel.org> # v6.9+
> ---
>  drivers/firmware/sysfb.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 880ffcb50088..dd274563deeb 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -101,8 +101,10 @@ static __init struct device *sysfb_parent_dev(const =
struct screen_info *si)
>         if (IS_ERR(pdev)) {
>                 return ERR_CAST(pdev);
>         } else if (pdev) {
> -               if (!sysfb_pci_dev_is_enabled(pdev))
> +               if (!sysfb_pci_dev_is_enabled(pdev)) {
> +                       pci_dev_put(pdev);
>                         return ERR_PTR(-ENODEV);
> +               }
>                 return &pdev->dev;
>         }
>
> @@ -137,7 +139,7 @@ static __init int sysfb_init(void)
>         if (compatible) {
>                 pd =3D sysfb_create_simplefb(si, &mode, parent);
>                 if (!IS_ERR(pd))
> -                       goto unlock_mutex;
> +                       goto put_device;
>         }
>
>         /* if the FB is incompatible, create a legacy framebuffer device =
*/
> @@ -155,7 +157,7 @@ static __init int sysfb_init(void)
>         pd =3D platform_device_alloc(name, 0);
>         if (!pd) {
>                 ret =3D -ENOMEM;
> -               goto unlock_mutex;
> +               goto put_device;
>         }
>
>         pd->dev.parent =3D parent;
> @@ -170,9 +172,12 @@ static __init int sysfb_init(void)
>         if (ret)
>                 goto err;
>
> -       goto unlock_mutex;
> +
> +       goto put_device;
>  err:
>         platform_device_put(pd);
> +put_device:
> +       put_device(parent);
>  unlock_mutex:
>         mutex_unlock(&disable_lock);
>         return ret;
> --
> 2.45.2
>

