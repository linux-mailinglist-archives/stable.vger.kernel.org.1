Return-Path: <stable+bounces-171621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9033B2AD28
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 17:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B911B64064
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203B630E0CB;
	Mon, 18 Aug 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcH3SCBQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE0D2765EB
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531761; cv=none; b=XN5wvFhlMhDrtXiBOIbrsIly97mEzloRT5t5Ws3GWGNL/cG2DvINGUNQcc4PV5aCUqO7YhkYJcTx+Q7G77JY2svT2Ok8JFa1+IdRy9DJcafcvapDYuzHlq0ft57tnxw9ALT7c+t5Gb7h07VLjwHMFarnvPkCPiVmDSKaexCVSBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531761; c=relaxed/simple;
	bh=Mq3dHkJ9V1S56nbZ3gGNslkI75qJJS3R6bbuGvS+TBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noojEkve37V82AKoAUipuMCbz0y4iHeV6NQcSeL4ooGzltmYmL9j4+l2LEvlRoY2UFTgWdFILfU1I1V/UEY65Fgvccm3X/Ci/PA4KJgeNfozAQxZccUOXrKtToaxkResHhrtNQyJ63DpUWsxb5qaIshO88RrTYSZX+GoCH/gz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcH3SCBQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24458051ac6so6660025ad.1
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755531760; x=1756136560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWjR9wVlQD2RfvrWT/us7U/22C2c5eA2O2hDzhadvrQ=;
        b=KcH3SCBQLND6vb/fBiqNIkqScnTa6yd7EHq4I64Hmf/knO9VAXeQkG5kxaehh3hDG4
         IBjlZPQn+bI7A9XYHQ8OQp7dqpDH1isxuqJFl9487KpWzugpoHf/9EkpTn8TtpZTOGOs
         OfhxrlAe1tL0q4jCR61wqzr1Za+oOB9uTB5FtkYZQBnxcXDSZz6/HdDHLJfTRmGsfjR4
         3QFA/jMSC0UldEn754hQ1wYMSly4T9GNN8DaI8Ss2IR6H84BIeZVQv/JzDW6WaCLAITX
         qFyqk/vSbwXW+xHqhAqL29PgCoqNyflZ3b00EEV8xkvTm9A5gZyK7YhwNGtP9Yjw4Lc1
         M5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755531760; x=1756136560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWjR9wVlQD2RfvrWT/us7U/22C2c5eA2O2hDzhadvrQ=;
        b=MhRLm2Tp7whaI7ZByo/4jmM0nW7Il0YERpAtbpl/LKUBLQs3wbOx4mvXzxcheZWFVY
         98ili5+1vCRhmdmhENos2T9f7Pc2dna7k6r0isx0Ya2UZXjIPr1HNVFmq3eqgJtvLgQr
         +w3qLiJXZedDna/plY2gnwgFm+OEUKuxpdocKENTCnmMs6hk3aPj5u6qXzsBtUjRsWi9
         AzFBDvGm7t9Ogl49Df18BEh7z1in8XdKrvLXGH1lie2vKJTnc9eErc+ACzw3WosnJ6HS
         JqLL6UTWq5U1pto8eNdD12tg+Pz7eGBOmExHNyIGw3yLHkwgdpVTdLYK0PDKWP38UrVR
         7lCg==
X-Forwarded-Encrypted: i=1; AJvYcCXL1N5wInoWR8LQY76KmCnE2nlNwWauOS2hBmYCEuNsfgRqc6Npp35+pQ1Mv3Q6xeVsMmyePOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxllHlBTTUDZKFb5YRLvs6yydf0NPDwTWghu7Ja76b4ob0HsdDx
	uGZfby+chpEyNcAVht2BatnHDeR8I8B7uvUujxI+CWIN1MHZOu2wxlsQ8dOsSsoSNGdX78ciwS7
	wia4GmvZxlK5jhioCkyhhgbRQUGX+iWo=
X-Gm-Gg: ASbGncs2XtnlO7ujiR4DX6+50+AjNbDAvb1ZKMXkQMpcTD2PM2bBnGJrRPOvSnoogPM
	J+TfgE5jlAtsPFs9bsnz8uRMYU5qk+VIvevLjW/xUbIMtyWWvFXEPzndmt9ZCrIP9iO7Rk3jLkA
	onX/qKwDnBbtXiTMkdEGG8gRlJbfNwKFa01xQw0FgIEorbfYwXHFJSJ0qQBPlm1v7laZRIvwqmf
	GWUBotqu5d9xx4lKA==
X-Google-Smtp-Source: AGHT+IFlzppuD9dNSIJnnHhIzNxU5p8tpYd3DxpTg9wZMmRJq7jnDuFScfIHVkPHYC+uCbocydQz1sTTgeL7QGR7YWw=
X-Received: by 2002:a17:902:ecc2:b0:240:bd35:c4ec with SMTP id
 d9443c01a7336-2446d893254mr59572885ad.6.1755531759554; Mon, 18 Aug 2025
 08:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808151517.1596616-1-alexander.deucher@amd.com> <CADnq5_OozSsP_qXBPjgYR9-1cChsYTJtg-y8RPb2wA9Xn9dfoA@mail.gmail.com>
In-Reply-To: <CADnq5_OozSsP_qXBPjgYR9-1cChsYTJtg-y8RPb2wA9Xn9dfoA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Aug 2025 11:42:26 -0400
X-Gm-Features: Ac12FXw9pe0IzLWcAt9ziG1lWfA0qbYNMRZKjTIdFRf8u6BBDl4yqo6FHvRpRUw
Message-ID: <CADnq5_Mt2Lxjso_1d+7jJbw7WGqFuY85iKL-Y1ZNCXg3VB0iqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: drop hw access in non-DC audio fini
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, 
	oushixiong <oushixiong1025@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping again?

Alex

On Wed, Aug 13, 2025 at 9:09=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Ping?
>
> On Fri, Aug 8, 2025 at 11:23=E2=80=AFAM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > We already disable the audio pins in hw_fini so
> > there is no need to do it again in sw_fini.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4481
> > Cc: stable@vger.kernel.org
> > Cc: oushixiong <oushixiong1025@163.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 5 -----
> >  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 5 -----
> >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 5 -----
> >  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 5 -----
> >  4 files changed, 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/dce_v10_0.c
> > index bf7c22f81cda3..ba73518f5cdf3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> > @@ -1462,17 +1462,12 @@ static int dce_v10_0_audio_init(struct amdgpu_d=
evice *adev)
> >
> >  static void dce_v10_0_audio_fini(struct amdgpu_device *adev)
> >  {
> > -       int i;
> > -
> >         if (!amdgpu_audio)
> >                 return;
> >
> >         if (!adev->mode_info.audio.enabled)
> >                 return;
> >
> > -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> > -               dce_v10_0_audio_enable(adev, &adev->mode_info.audio.pin=
[i], false);
> > -
> >         adev->mode_info.audio.enabled =3D false;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/dce_v11_0.c
> > index 47e05783c4a0e..b01d88d078fa2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> > @@ -1511,17 +1511,12 @@ static int dce_v11_0_audio_init(struct amdgpu_d=
evice *adev)
> >
> >  static void dce_v11_0_audio_fini(struct amdgpu_device *adev)
> >  {
> > -       int i;
> > -
> >         if (!amdgpu_audio)
> >                 return;
> >
> >         if (!adev->mode_info.audio.enabled)
> >                 return;
> >
> > -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> > -               dce_v11_0_audio_enable(adev, &adev->mode_info.audio.pin=
[i], false);
> > -
> >         adev->mode_info.audio.enabled =3D false;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/dce_v6_0.c
> > index 276c025c4c03d..81760a26f2ffc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > @@ -1451,17 +1451,12 @@ static int dce_v6_0_audio_init(struct amdgpu_de=
vice *adev)
> >
> >  static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
> >  {
> > -       int i;
> > -
> >         if (!amdgpu_audio)
> >                 return;
> >
> >         if (!adev->mode_info.audio.enabled)
> >                 return;
> >
> > -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> > -               dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[=
i], false);
> > -
> >         adev->mode_info.audio.enabled =3D false;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/dce_v8_0.c
> > index e62ccf9eb73de..19a265bd4d196 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > @@ -1443,17 +1443,12 @@ static int dce_v8_0_audio_init(struct amdgpu_de=
vice *adev)
> >
> >  static void dce_v8_0_audio_fini(struct amdgpu_device *adev)
> >  {
> > -       int i;
> > -
> >         if (!amdgpu_audio)
> >                 return;
> >
> >         if (!adev->mode_info.audio.enabled)
> >                 return;
> >
> > -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> > -               dce_v8_0_audio_enable(adev, &adev->mode_info.audio.pin[=
i], false);
> > -
> >         adev->mode_info.audio.enabled =3D false;
> >  }
> >
> > --
> > 2.50.1
> >

