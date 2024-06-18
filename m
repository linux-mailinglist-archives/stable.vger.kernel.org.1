Return-Path: <stable+bounces-52645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BA190C6CD
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622EC1C21E3A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B591A00D9;
	Tue, 18 Jun 2024 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcoI6doy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3242D13AA5E;
	Tue, 18 Jun 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697701; cv=none; b=dX0pn6xu6gVHD8PAECLH7jpUUmvgacC//iiQ6F8vLH6gKvQVkeqfcQPgG0IE9ddm03L2iKfa9itnn18mixaWvybLhEzullhZfQzq1hbzKMDFYNagTXjm01KhgLWdUOQA4JYWZ6WRYuvqehuLe7AM6po0Z7Y6OYrVxR+34HY3z6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697701; c=relaxed/simple;
	bh=CK66sCUd96A0IhaHUK5QQ6y4O1/kPTaUtdnMgUo6kQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVvud20WGq1oFCAQj5DdZHb9tB7vhnOwtBX/eaarHddNlYXe7eFL8vnm5839sF6Uh3n2xpBpfXsEdPeHipC1Cvg320bUsGBTPUZvuF7Owo7iJeZMqJAfvIl0B3UXdZL59H/8AOGa3Mu+YzElKZgFHN2HxICOZCegYBRFhxpeB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcoI6doy; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f7b785a01so272285266b.1;
        Tue, 18 Jun 2024 01:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718697698; x=1719302498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEfgk2fYUwOCyIZltP8v1hQ1jJKysr4pnr2KfmirBu0=;
        b=OcoI6doyx3PXxwESeOIIlCgca9xoJ6ncKUSvbcXoM0zD2gCrOzZHcDaGs8PVz3A2s0
         dl5NTqmTf5DGx+N8tFiL0bc0VYAZqVCDKn3Is6pfKyhzCxUjjacae6lfvvuIrDZJDnXv
         XFmT4x6nwXDokNTuZasXIhAzeQXRyuHEQifXfzKtdAe5dwoYK4YXXv0h5iCl2TNiwjVe
         DEpUaBGybn8lvqMfJG5K5qkFXv9i0ZMfnNgcYI5ATYdsuAUOkdhWy0RNpINeb6UmfHdW
         zRrtpx5knxn7aNKPccy5d/VPl+EUyupgWbr6Nn4C65CGw9IdEwJIYcVfDwKREkQsmIPQ
         epyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718697698; x=1719302498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEfgk2fYUwOCyIZltP8v1hQ1jJKysr4pnr2KfmirBu0=;
        b=Exs5qbO1DnfFSIA0qtAiXpsJ8DHrMgeIGXjYI0s0st+AUH1mXiOaYDM9rCJNZM51Mb
         wZtY0sMIacV0A4rrm6E36lq2LLKqXBaLUuSRQlAu3A0VQgNIWSxeW+FZA+aNCLJaVSH1
         1mXUZBkFjeu+1+gLf/r72Pn61bsVRnfMi2zf2zCORF8h3tFnoZsm99t2pPoJE5B/abQ0
         lQvNtzwX0iUiMr4K9N+aAs3e1zH/ymXiYfiIRhmRk1Lzqm1sZ+wypL5XANAQviqMon2/
         w6TYcpF5H8fHDiEL1fJiCXceof7JKa9Lf61EPdC+O6S1xfD3zGd2z9+Z9dMhfeVz3VLD
         OQUw==
X-Forwarded-Encrypted: i=1; AJvYcCXUDVkh/uTEqQoOJucCxfMGqdxMU8Qp7MHH+aDyTdRMrpRAZzEX0Rhai5FkI6EPDhhRmxGJrmh9fSMQoXTOngRDRbEYODWN5hQbBr9JAcT9UZsjSzOHzToxEZONf9XLUKVcLEXw
X-Gm-Message-State: AOJu0YwvZfKeOp2u1n33eETiv/0sPP0wkdB0jlRkitMWd4TOSMpYpRo1
	7NyveDyT7JWoDvmirdGIsFHF/2tKJSHdXnkskB/H5J+Y0WDaC9q54i6YjwwExBjX/D6coaa3kZI
	OD+SpCycT+io4NsYgCFU8llTUpm0=
X-Google-Smtp-Source: AGHT+IHd23BvSCzQlm7Tuey+57rzDaK5qYGqzZqCpTK+jC9NgfLORX/DZ664KaPmEqX41xGojin54yrzfjR9mkTpEyo=
X-Received: by 2002:a17:907:c24d:b0:a6f:96ac:3436 with SMTP id
 a640c23a62f3a-a6f96ac349dmr115982066b.11.1718697698117; Tue, 18 Jun 2024
 01:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fdaf2e41bb6a0c5118ff9cc21f4f62583208d885.1718655070.git.dsimic@manjaro.org>
 <CAKGbVbs8VmCXVOHbhkCYEHNJiKWwy10p0SV9J09h2h7xjs7hUg@mail.gmail.com>
In-Reply-To: <CAKGbVbs8VmCXVOHbhkCYEHNJiKWwy10p0SV9J09h2h7xjs7hUg@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Tue, 18 Jun 2024 16:01:26 +0800
Message-ID: <CAKGbVbsM4rCprWdp+aGXE-pvCkb6N7weUyG2z4nXqFpv+y=LrA@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: Mark simple_ondemand governor as softdep
To: Dragan Simic <dsimic@manjaro.org>
Cc: dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, linux-kernel@vger.kernel.org, 
	Philip Muller <philm@manjaro.org>, Oliver Smith <ollieparanoid@postmarketos.org>, 
	Daniel Smith <danct12@disroot.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 12:33=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrote:
>
> I see the problem that initramfs need to build a module dependency chain,
> but lima does not call any symbol from simpleondemand governor module.
>
> softdep module seems to be optional while our dependency is hard one,
> can we just add MODULE_INFO(depends, _depends), or create a new
> macro called MODULE_DEPENDS()?
>
This doesn't work on my side because depmod generates modules.dep
by symbol lookup instead of modinfo section. So softdep may be our only
choice to add module dependency manually. I can accept the softdep
first, then make PM optional later.

> On Tue, Jun 18, 2024 at 4:22=E2=80=AFAM Dragan Simic <dsimic@manjaro.org>=
 wrote:
> >
> > Lima DRM driver uses devfreq to perform DVFS, while using simple_ondema=
nd
> > devfreq governor by default.  This causes driver initialization to fail=
 on
> > boot when simple_ondemand governor isn't built into the kernel statical=
ly,
> > as a result of the missing module dependency and, consequently, the req=
uired
> > governor module not being included in the initial ramdisk.  Thus, let's=
 mark
> > simple_ondemand governor as a softdep for Lima, to have its kernel modu=
le
> > included in the initial ramdisk.
> >
> > This is a rather longstanding issue that has forced distributions to bu=
ild
> > devfreq governors statically into their kernels, [1][2] or may have for=
ced
> > some users to introduce unnecessary workarounds.
> >
> > Having simple_ondemand marked as a softdep for Lima may not resolve thi=
s
> > issue for all Linux distributions.  In particular, it will remain unres=
olved
> > for the distributions whose utilities for the initial ramdisk generatio=
n do
> > not handle the available softdep information [3] properly yet.  However=
, some
> > Linux distributions already handle softdeps properly while generating t=
heir
> > initial ramdisks, [4] and this is a prerequisite step in the right dire=
ction
> > for the distributions that don't handle them properly yet.
> >
> > [1] https://gitlab.manjaro.org/manjaro-arm/packages/core/linux-pinephon=
e/-/blob/6.7-megi/config?ref_type=3Dheads#L5749
> > [2] https://gitlab.com/postmarketOS/pmaports/-/blob/7f64e287e7732c9eaa0=
29653e73ca3d4ba1c8598/main/linux-postmarketos-allwinner/config-postmarketos=
-allwinner.aarch64#L4654
> > [3] https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/commit/?i=
d=3D49d8e0b59052999de577ab732b719cfbeb89504d
> > [4] https://github.com/archlinux/mkinitcpio/commit/97ac4d37aae084a050be=
512f6d8f4489054668ad
> >
> > Cc: Philip Muller <philm@manjaro.org>
> > Cc: Oliver Smith <ollieparanoid@postmarketos.org>
> > Cc: Daniel Smith <danct12@disroot.org>
> > Cc: stable@vger.kernel.org
> > Fixes: 1996970773a3 ("drm/lima: Add optional devfreq and cooling device=
 support")
> > Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> > ---
> >  drivers/gpu/drm/lima/lima_drv.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lim=
a_drv.c
> > index 739c865b556f..10bce18b7c31 100644
> > --- a/drivers/gpu/drm/lima/lima_drv.c
> > +++ b/drivers/gpu/drm/lima/lima_drv.c
> > @@ -501,3 +501,4 @@ module_platform_driver(lima_platform_driver);
> >  MODULE_AUTHOR("Lima Project Developers");
> >  MODULE_DESCRIPTION("Lima DRM Driver");
> >  MODULE_LICENSE("GPL v2");
> > +MODULE_SOFTDEP("pre: governor_simpleondemand");

