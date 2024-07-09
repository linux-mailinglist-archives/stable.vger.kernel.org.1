Return-Path: <stable+bounces-58924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C0292C313
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 20:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D7C1C225B8
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C149617B037;
	Tue,  9 Jul 2024 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6ctD8A7"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314F12BAE5;
	Tue,  9 Jul 2024 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720548403; cv=none; b=NNPc+DtlhjQB9iRqnzt6SYu+/2kb2aFJbmso+5/0g8+ntqI4rTOfAhIelc4Tg4jr1WlZi1G1HfXn4T9vZCIfbmskoSi9ZRIIuZ7BWI1GPzDCn4goFbQMGj/svQCLhCwrIDlWC+HgD4erbTWKMIKhGajDP1Yl3uqRGmK+YTOGVvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720548403; c=relaxed/simple;
	bh=0dlgE8JFdCWL2BmwbF8YZztEVIMQuDJGON3Rkj9ekuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUhfimEoIuxORP84x8Ag+EZg34wfIWzvqnOhHryOtOzZ04JXL1dmIs29yRyMl56d03z6fhQoWxi1bEnOFfWY2yQsJu5SBcJbFFNgnSxLVryfBrlqDIEmnDjxnSVa0l/9bteyhsCi/xYR/b7nLTaVBVXEG91Iox+RSmQODNNjG3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6ctD8A7; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25cba5eea69so2671288fac.2;
        Tue, 09 Jul 2024 11:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720548401; x=1721153201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzBDhpjO1TzmBMf6LfzhCg/YH/Iw6PGOmuPK9+lkbGc=;
        b=g6ctD8A7wWjVgLvdeNUeg7ag75ObwsUnH3n3xnog2vL+JDHktD2fm+zFNOkVJD4d+4
         cNpjWYFWYfpyxF9A/4W68O251TbiJ2ozBTw0klBSAOwnWwEo1bxaB9eZoFCLl9NmooZA
         HQOI3IIjkNfXpRprmeP4CbS3uSy2NiL0Lh0gAxlMRmvDYWs0Q11m2B/HMhoX8gCkIOA1
         1P1OLhRaiqV+rVRmmW0UGeWxFIvjSESI/mBSjUBIdb9a+HLiZ9TrwLj/LMsT1pebqJLr
         tDmHJR3SJ2mPCjP2pKIlPh5q2aW8hQkjamMWcir6c4Xovvx193D063CWIw7lgERPLpEY
         ts4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720548401; x=1721153201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzBDhpjO1TzmBMf6LfzhCg/YH/Iw6PGOmuPK9+lkbGc=;
        b=plJhldCBWyh2X4a0waWDLYq3ulIZRZFb/H0wjsRO9CGZs9tn45W3CC/WpR8ORVvWKr
         f4sMOv5ni8JDjqxsrVk0sHg+5YaVJwiNQ5zRotNcuY2WwCx5NUrxKXLv/PihVZHbo64B
         aWyBPQ34a1Yl78/jr82Rzm3EwjyUbEc13nhVxNNUhbsfhKt4yL5GX7sreRAi37TsZEUt
         UyKAyHCnnuBwQ5NeE+bfPmws/Fvk00wnlAYARdZrHm2Fc2sXzaEZ6tu98XFDZHQpY8Gk
         rGOtQe13r4JbAFq5DgJOGypnt3Q6JaJK7YlBW9lrp7ZAghUAU4ihw43zjEK8BnamlBPS
         EmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAMxMdx6P6xT1UH5X20cf/n5q3J+14Y5lDMvYwEMC0D0fBWc9S4kyoZqUSa3m/lfKhOj6lY4t/a5MA2xhNBtyNCTXktW7hzvjLYb5d+PRhWCQu9XT7e2flpcjWYWT8O5mzmWpZ
X-Gm-Message-State: AOJu0YyVfGSQ2kpmZwqSQHwEvKBpIndGvQpUsDpdSPrpMx+ndeXBeCwu
	LSbukt6dofPUsL3BYD5b1SvI+Eda7VowOtWoXCrKItA4/FNXwkQ4OWVFAGDFqAkRuUgtm75pZJn
	NlGDgXZ2zTBr4ocWCM3WFs8OLqaU=
X-Google-Smtp-Source: AGHT+IEGUcQKJ9mnpyPVQXQ1pNx23mMBnkpqX5kngam5zoBvxP51NVErbJOzJhsbwWiQjadnpg0LnTkMyAlCadX5jSY=
X-Received: by 2002:a05:6870:ec87:b0:254:ccac:134d with SMTP id
 586e51a60fabf-25eae7575dcmr2838916fac.2.1720548401179; Tue, 09 Jul 2024
 11:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709085916.3002467-1-make24@iscas.ac.cn>
In-Reply-To: <20240709085916.3002467-1-make24@iscas.ac.cn>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Tue, 9 Jul 2024 20:06:30 +0200
Message-ID: <CAMeQTsa4eYwPW=ut4yheZD0od3Yc9hGc1W3N=Ns7BKuYugcunw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/gma500: fix null pointer dereference in cdv_intel_lvds_get_modes
To: Ma Ke <make24@iscas.ac.cn>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, alan@linux.intel.com, akpm@linux-foundation.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 10:59=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> In cdv_intel_lvds_get_modes(), the return value of drm_mode_duplicate()
> is assigned to mode, which will lead to a NULL pointer dereference on
> failure of drm_mode_duplicate(). Add a check to avoid npd.
>
> Cc: stable@vger.kernel.org
> Fixes: 6a227d5fd6c4 ("gma500: Add support for Cedarview")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Thanks for the patch!
Pushed to drm-misc-fixes

-Patrik

> ---
> Changes in v3:
> - added the recipient's email address, due to the prolonged absence of a
> response from the recipients.
> Changes in v2:
> - modified the patch according to suggestions from other patchs;
> - added Fixes line;
> - added Cc stable;
> - Link: https://lore.kernel.org/lkml/20240622072514.1867582-1-make24@isca=
s.ac.cn/T/
> ---
>  drivers/gpu/drm/gma500/cdv_intel_lvds.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gm=
a500/cdv_intel_lvds.c
> index f08a6803dc18..3adc2c9ab72d 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
> @@ -311,6 +311,9 @@ static int cdv_intel_lvds_get_modes(struct drm_connec=
tor *connector)
>         if (mode_dev->panel_fixed_mode !=3D NULL) {
>                 struct drm_display_mode *mode =3D
>                     drm_mode_duplicate(dev, mode_dev->panel_fixed_mode);
> +               if (!mode)
> +                       return 0;
> +
>                 drm_mode_probed_add(connector, mode);
>                 return 1;
>         }
> --
> 2.25.1
>

