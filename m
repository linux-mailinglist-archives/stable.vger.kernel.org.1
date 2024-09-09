Return-Path: <stable+bounces-73989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A22CB9713FD
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 11:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6E71F24562
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930631B14F4;
	Mon,  9 Sep 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh0iTe6N"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BFF1B2EF3
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874836; cv=none; b=YJiUq5ZtGmGLW+kqeaajxF60gLyvLdnS6g1Np4fR5ped3S6O5RW3Nkmh24EpUS/UI2G6bsGIoIgAh/XJvxUyv8R6SKVaVbCx6d6TMkYCY8ebShUzcoeFXc9Xe3PH3LABsA9qtxZngu8xQ8bkDR+UH0Zi42u+ijfvu8nvtAgG3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874836; c=relaxed/simple;
	bh=ellwKWagmGh3M5pU/y0/j8Qi2MbIwWlzwI5DwAy5K44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUivOHbY34+9SBQeTunHPGI1OUlGavRVUEXwuQAFTJbkIX4GE0uVRzLzGIZF7ktVtPLI6n12F234PcJGBYKtn0wGkqplsg6EjXfDbjOfPnSlh280wuuIKe2cTHaVu9ESD36i5Y6uK1tn3JFGfEEmu2rljWrWx+POZeNIzuv8AJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh0iTe6N; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2068bee21d8so40059265ad.2
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 02:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725874834; x=1726479634; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OTeSKbd13UpZ8qI7LopC66Vws2elrpD4RlQ5sx/IQoQ=;
        b=Lh0iTe6NTeRYk41vfQJsBOZLa3v5fdJUjgJKYFXwHJnEJqGf8A99HCyttpDPDs9t0M
         vi2bmqMbzrTkCcGsnI5RkOdF2fXarLbFlrABB5sbzOEpP9Q7OwIszZKOxlpJsr3nOh44
         Kc0kPi7+QfDHWqx5HpDcBmdyL0Sp8acGUNTYP1ZzNLX/nFdh9Ih+3EAa7V9+Rup21Khw
         fmvAOuPZ5SOccUNkI/96U4qWoiZulFdxb6VFMQ9hoE5CtVLTmZdw4Fwcl7dOJMukX877
         MelP9f0GUClxgwbQAHdjkuvlr63U8A6nvz7XrUqQ7eZjLxRzeYusS7+sIuD+OYxmXSu8
         Jyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725874834; x=1726479634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTeSKbd13UpZ8qI7LopC66Vws2elrpD4RlQ5sx/IQoQ=;
        b=jRml4EONfyl/uBUKfXQTtWsQB5wLBPbaT76PsRfvPL4Fe1Fh1ItiX3ALNbWj99sfKG
         9zm60IhvMZf7dbL10LBfgzEqEs4HkGyWzHNJ7FNMtqePN5fOlnWDM6GNwqlilV4qtGIy
         KJQgWWEuGHpHWHPfsFhe98giOZa5puBmAd7ZPMfo2cFwgrh/j0shacFTavDpj2dt6Hy7
         qsuLs9tujo3KIqPOX5rO05FEOpoAxWmGO8rFkLfHKX7/iPS9gfL5fV9BCLhQDOde/A3h
         ZMj+uawgfAFBxDEaZKQ3lXdFKHPOdVusDcTLGI7R9lct9p0+OvmhH2SrCVmy19sWjS3E
         T66w==
X-Forwarded-Encrypted: i=1; AJvYcCWSJ3EGx2899abfL14R6RqwUMXUuZsypYGltfALBN6/Ef86jjQsQWvW80Q8NTVlTtjOd3Y5WSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt5Ch/LS05ULH6lHSqn1gujR3C8JC9ARywh/Gz325QkGnesQ0e
	VJL2Z7f4m7sOH4nfhGR8McIGVGIHZpAPUTUioGb5x0L4VogQcZj1Y+kCfbeVkMqIGjuFwsY91Rk
	Elz8IPvpf9DKszuGdCVQPd3j6aDI=
X-Google-Smtp-Source: AGHT+IEpdHWHxSKpCZUccSYOAO0tk5eEkI/Ok8RircErfWPBY96ntqbHCpVGjCix5Wz1cSiBCOgb0HN1IccEwKOqK+I=
X-Received: by 2002:a17:903:1252:b0:205:7db3:fdd1 with SMTP id
 d9443c01a7336-2070c0f8250mr111016685ad.36.1725874834138; Mon, 09 Sep 2024
 02:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALUcmUncX=LkXWeiSiTKsDY-cOe8QksWhFvcCneOKfrKd0ZajA@mail.gmail.com>
 <20240907134756.46949-1-jandryuk@gmail.com>
In-Reply-To: <20240907134756.46949-1-jandryuk@gmail.com>
From: Arthur Borsboom <arthurborsboom@gmail.com>
Date: Mon, 9 Sep 2024 11:40:18 +0200
Message-ID: <CALUcmUmMzJr=FGN9VArPLVJb0cA1e+QZxqA_nSBAU_9eTjOHng@mail.gmail.com>
Subject: Re: [xen_fbfront] - Xen PVH VM: kernel upgrade 6.9.10 > 6.10.7
 results in crash
To: Jason Andryuk <jandryuk@gmail.com>
Cc: oleksandr_andrushchenko@epam.com, xen-devel@lists.xenproject.org, 
	Jason Andryuk <jason.andryuk@amd.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Sept 2024 at 15:48, Jason Andryuk <jandryuk@gmail.com> wrote:
>
> From: Jason Andryuk <jason.andryuk@amd.com>
>
> Hi Arthur,
>
> Can you give the patch below a try?  If it works, please respond with a
> Tested-by.  I'll then submit it with your Reported-by and Tested-by.

I have tested the following.

- Built and installed the Arch Linux AUR package linux-mainline:
6.11.0-rc6-1-mainline.
- Booted in PVH > failure: VM is inaccessible.
- Booted in HVM > success: VM is accessible.
- Applied the patch to the build above.
- Booted in PVH > success: VM is accessible.

From my point of view this patch works and resolves the issue.
Hereby:

Tested-by: Arthur Borsboom <arthurborsboom@gmail.com>

Do you have an estimation in which kernel version this will land?

> Thanks,
> Jason
>
> [PATCH] fbdev/xen-fbfront: Assign fb_info->device
>
> Probing xen-fbfront faults in video_is_primary_device().  The passed-in
> struct device is NULL since xen-fbfront doesn't assign it and the
> memory is kzalloc()-ed.  Assign fb_info->device to avoid this.
>
> This was exposed by the conversion of fb_is_primary_device() to
> video_is_primary_device() which dropped a NULL check for struct device.
>
> Fixes: f178e96de7f0 ("arch: Remove struct fb_info from video helpers")
> CC: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> ---
> The other option would be to re-instate the NULL check in
> video_is_primary_device()
> ---
>  drivers/video/fbdev/xen-fbfront.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
> index 66d4628a96ae..c90f48ebb15e 100644
> --- a/drivers/video/fbdev/xen-fbfront.c
> +++ b/drivers/video/fbdev/xen-fbfront.c
> @@ -407,6 +407,7 @@ static int xenfb_probe(struct xenbus_device *dev,
>         /* complete the abuse: */
>         fb_info->pseudo_palette = fb_info->par;
>         fb_info->par = info;
> +       fb_info->device = &dev->dev;
>
>         fb_info->screen_buffer = info->fb;
>
> --
> 2.43.0
>

