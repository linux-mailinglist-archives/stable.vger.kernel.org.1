Return-Path: <stable+bounces-58925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FC492C316
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 20:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847471F227E5
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5B817B044;
	Tue,  9 Jul 2024 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOHjujHV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59F817B037;
	Tue,  9 Jul 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720548423; cv=none; b=lWfMPmJKgguiJw+zX/OE/VkuAAJOxIv7WIfs9EHLHg0Az7vYRoW6gCEKWVIcyLSjoOyV1eIGKvDFXZKeP74jwwcfG26EVGUljxiPIWhke7MZmbZqvHhdYJEROEy2e9FD1gpdsDMKmvrLnWedAcV54LkM4N9rwPXmFsFQrxEwLms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720548423; c=relaxed/simple;
	bh=mgk7SHyvf9lK5WrJ5K20qNHaJDi/wOzPgiiLyGmhF3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEzrKxB9jOZpOS33ShP15xbStHoAOXzFEtdcXGAeFl2R+1eqTyUC8Z9tKtXsSJ4LO9oAo/YnXEzXtykG8Mzm79zAT3SauAWRCSjEJIM2ofPE1fT33i+oNVWVE+QWAXucC+yLSDiD/vesq4fpg3ptTPiR04ahWL1H6rgIqoy5HNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOHjujHV; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7036e383089so1332913a34.2;
        Tue, 09 Jul 2024 11:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720548421; x=1721153221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJAo1DXs8ooE0RW3APFpiuREqVJox962WsbSK7msjLw=;
        b=MOHjujHVsdgBm7HDOr2zt0DydTVIURCoWVpt2srYMUAPPL8pAkr0e7lA3Ux77pc+57
         fkdQe31Z+ikiviXXyMK1gtZCLwQEdGgU2jYdydY3DMCd5K5/zjXp27tFpFtuqzQMhoJj
         WY5zDQPSj+i6REzGSN8ZQPvIULTh4YLK/I9ZSvnyBVYX5l/6fdY6oW9iS6Qf0Nwme3v1
         swNVAxhuDp8/EvsH/OHwbADvzQ9LWenkDs7NHNBNr4Amc4qppHqsphUVT/a8zr3gpFMq
         FyAj19w41jES4xESt8VQG8bVud1lrQjZz5T4D9UdklyInLLZpvorKQSCMh8DZGTh9Y5B
         SKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720548421; x=1721153221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJAo1DXs8ooE0RW3APFpiuREqVJox962WsbSK7msjLw=;
        b=qIiVWn0Yhwlkg+FdPi6C/VbQmYAoxmqS+V6Y1nXQwv//ontnDjKO2XJzezqjb1sAbn
         TbXZzQZwTHxXMt0ZM2Kc7Lt+WNeeUtRZhH9shVd1e2TSROjONIi4AjkiDAJg1IKVmDYC
         ZgXf299jMoGKJSvYS5KVbX1ePE/LfvBnIp7YD0IBy3ehlAEfJBludvcLv2JvVzqxNwTh
         nyg3aHBKI4650U++F4Y25F2EMGkbkYw+9SgZ7h0teE/rHqzO9FXfNl/FT0TrgykrRPO+
         Ucf8aNY5kGqdYeBoV2Ga+tyFErFh+pHCcgt0y36zBW2V48MaYgP5bDTZPQp12LjeMV8p
         leIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU64zAKEVrFVjs+h5PqK1/0Vi4Q6z9V35UPMD0I4AP5D37y7lLdKl/Gve3xNBuMi7I100gVs4PwNVG0+3527/73j336V5SRhOIbDWY6IZ881afGvwFImI5zJ0PiNdn/GEHObHYL
X-Gm-Message-State: AOJu0Yz4nckYPhJL1i0DHliCVIm+GuCun7PvpXU3Pj03xk6uN4ZH0ovT
	dK25O2wRb5x6gUGyKxohXfsrco/DCpZzzIQJydqnv3636qN8puCczD/P6j45+3tdTSSt319hDYS
	/5dR0Y4qcDxZRP6plgdegI8rUsKo=
X-Google-Smtp-Source: AGHT+IEK/h7YRFNQ2S7300KC0byBo5gQdt7zCpjTXA4dfoiohxCrmTmLBf7UZXh0AakpB+NhqkARZiuhDFtcgob1/K0=
X-Received: by 2002:a05:6870:c03:b0:25e:1a0f:522d with SMTP id
 586e51a60fabf-25eae8a49b7mr2821143fac.35.1720548420892; Tue, 09 Jul 2024
 11:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709113311.37168-1-make24@iscas.ac.cn>
In-Reply-To: <20240709113311.37168-1-make24@iscas.ac.cn>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Tue, 9 Jul 2024 20:06:49 +0200
Message-ID: <CAMeQTsZojC24Hs_zy0UX0Zjq42zLH21yn_hZhkcSKbL5X1jiSA@mail.gmail.com>
Subject: Re: [PATCH v4] drm/gma500: fix null pointer dereference in cdv_intel_lvds_get_modes
To: Ma Ke <make24@iscas.ac.cn>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, daniel.vetter@ffwll.ch, 
	alan@linux.intel.com, airlied@redhat.com, akpm@linux-foundation.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 1:33=E2=80=AFPM Ma Ke <make24@iscas.ac.cn> wrote:
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
> Changes in v4:
> - revised the recipient email list, apologize for the inadvertent mistake=
.
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

