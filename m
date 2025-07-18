Return-Path: <stable+bounces-163400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E181B0AAF7
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 22:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CDFA45F99
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 20:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B981DF970;
	Fri, 18 Jul 2025 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzP8taYq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2181CD517;
	Fri, 18 Jul 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752869249; cv=none; b=ZgnTPj23y0q3JghRnOke6Z/Hk2qVS/xxR7Gf1qRd5T+U4HDXH7iVbMoar7zgskEB6ZNHgPd96o1LWetrbAj8T6gKcAP4DpmAryaWrPMDLRxD13P6GRbuczzzuzhiEPQmlQ+6WwcC+LqjXAjb6mzWM2hIKM/BqxAleUui+8GuDto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752869249; c=relaxed/simple;
	bh=qiB1Am2MdnaUaej4EZsXEtFdX5Yw7+XNtsIu9hCIgq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8RnGy2Io/3uOj5k3J/l+3l/MA7FRrlEXfIRZd3Y9DnLeP4XQQRGskeopNnGKdLcW1Aojr3+Rd/Z7SUxfnkYaxNoko47spEcI+qUj2c66DAd3bqaEv3LSSbawK9+gKN0PR5ZKuX8L9oxRXrK1IuoA/Yd+La6Zi0edFMU9F1ugD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzP8taYq; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b34b770868dso323695a12.2;
        Fri, 18 Jul 2025 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752869247; x=1753474047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9RhPn6bn+hJA06IZWwattr/+qu6k9jF9QGOYEXW45s=;
        b=TzP8taYqI2pNYDaGGKICgn+ZWke2o5FhPOxbNbi3wUlxL1svtzhp03oBk5r805vPxT
         WayrthpB2k7GGRlmj95t/XN1W1X+ilCMSRdUM8nKhhO+y7r4wR8B0D+agCfK5yBzHFlL
         OQ0j2V/M4Nzpuxy2pigPRLqIoxOEqT8hGAx1zx8k3fWQO+UDlptceqz7XS0hXFGhEwuj
         hMa1TF+dPMM19xt0bO0edU9s48E619qs3g8LgUok9cNIXUlPQGFCX4Y+WFmhoCCxFJSi
         v/ivlo+KdOGoxxcoxsEUZI1PJGHfz0nJTybvp5p4/0js8ZLWvfvSPGOKTCVOvahWGoOc
         ZRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752869247; x=1753474047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9RhPn6bn+hJA06IZWwattr/+qu6k9jF9QGOYEXW45s=;
        b=aSq6bilkMqiGvav+xZihoVgeosMYk6VeDVNh8ZKbLq0zvej53eCmJTt55u6COg25Bu
         uZ+r2APuvWLEfZsuuYRyyWGnWTN//sEKYcBLJ6AL/CHtyo/+35TRRRTOFFYHaLi1okuk
         b7gsIYHv49JYL28jhxsFsU+nOoUaisDVo84CVCkS3jqLEaKTHzUC8hQJhzRsHdIce1zU
         ywUOKr+bIbkVxQMhfxRopDNX1wmKEyUL2cFdlhxnfK1kf4CgL3G/s00OfjY/Id87I8Kv
         10fMv7HPPZsO6uvQQh2e41/y9HI1TFWvhTRxjcjUgHn/t8+0mWqMjO0iIs99HDMxMLef
         EVDg==
X-Forwarded-Encrypted: i=1; AJvYcCVF0LQlRuTQZMaU7U6yfCIQHquncEzq3R1J3+ajtqm2fIeSlzkcetbgUAIFJLS4+P9+fv4N9l2a@vger.kernel.org, AJvYcCXtrsZK9ezE4MJFZlgVflpmMfeNike3g6LW5D3ULsrLJEc5Vcwg3yrm2sMA4IpZMCmq75u2Bc43MBm2Cf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YworISlkTVwJtnvMMEly3Q1fLQrHG+CXOU7Y8Z0ptWqNe8/R754
	cgf6RzspQ6ll6LF3nupD2oc9bOJDzlIP0UJyVwvM1ZePzFbxkDtnOWGdt5J1JcjayWviagKY1ek
	HOjk5al223JAD2tOZuw7tt0+UiZrtPjM=
X-Gm-Gg: ASbGncuTQKExB20ijLEKPFY7meSVytnFZnYAduFIVy7iMKqOc7jCJrGUdX0NS1cgImm
	ZwDjvKo25amyOh/ba+c9q+Ika0Z0FCvx6Not18KUKNwnhJjxra6XEwJBp4sdie937RvpCtotTQY
	cXPiLLy8/GKBJB/kQSjWZn9o/oYYwMujh8J4KE5l5oO+dpXYghU00q7nGFVIwdWxLu3xqEyJu3I
	ck/yq/G
X-Google-Smtp-Source: AGHT+IEEIC7Ov8wCVOKS/R8qsm5tmfCXtvXWU4DJsxwH/1X3wLmGk+yjxCtQD3NZENjz6uOuesxywakCO3vaWoj9Bjc=
X-Received: by 2002:a17:90b:2ec7:b0:312:639:a06d with SMTP id
 98e67ed59e1d1-31c9e78ec64mr6626904a91.5.1752869247216; Fri, 18 Jul 2025
 13:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716161753.231145-1-bgeffon@google.com> <CADnq5_P+a2g_YzKW7S4YSF5kQgXe+PNrMKEOAHuf9yhFg98pSQ@mail.gmail.com>
 <CADyq12zB7+opz0vUgyAQSdbHcYMwbZrZp+qxKdYcqaeCeRVbCw@mail.gmail.com>
 <CADnq5_OeTJqzg0DgV06b-u_AmgaqXL5XWdQ6h40zcgGj1mCE_A@mail.gmail.com>
 <CADyq12ysC9C2tsQ3GrQJB3x6aZPzM1o8pyTW8z4bxjGPsfEZvw@mail.gmail.com>
 <CADnq5_PnktmP+0Hw0T04VkrkKoF_TGz5HOzRd1UZq6XOE0Rm1g@mail.gmail.com> <CADyq12x1f0VLjHKWEmfmis8oLncqSWxeTGs5wL0Xj2hua+onOQ@mail.gmail.com>
In-Reply-To: <CADyq12x1f0VLjHKWEmfmis8oLncqSWxeTGs5wL0Xj2hua+onOQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Jul 2025 16:07:15 -0400
X-Gm-Features: Ac12FXzpSsEJ7zuzpP255sChl3CDubYC6yiCREKgz9m-Uq3Jrl2YudKs6Zl1T3g
Message-ID: <CADnq5_OhHpZDmV5J_5kA+avOdLrexnoRVCCCRddLQ=PPVAJsPQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Raven: don't allow mixing GTT and VRAM
To: Brian Geffon <bgeffon@google.com>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>, 
	Pratap Nirujogi <pratap.nirujogi@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Garrick Evans <garrick@google.com>, 
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 1:57=E2=80=AFPM Brian Geffon <bgeffon@google.com> w=
rote:
>
> On Thu, Jul 17, 2025 at 10:59=E2=80=AFAM Alex Deucher <alexdeucher@gmail.=
com> wrote:
> >
> > On Wed, Jul 16, 2025 at 8:13=E2=80=AFPM Brian Geffon <bgeffon@google.co=
m> wrote:
> > >
> > > On Wed, Jul 16, 2025 at 5:03=E2=80=AFPM Alex Deucher <alexdeucher@gma=
il.com> wrote:
> > > >
> > > > On Wed, Jul 16, 2025 at 12:40=E2=80=AFPM Brian Geffon <bgeffon@goog=
le.com> wrote:
> > > > >
> > > > > On Wed, Jul 16, 2025 at 12:33=E2=80=AFPM Alex Deucher <alexdeuche=
r@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Jul 16, 2025 at 12:18=E2=80=AFPM Brian Geffon <bgeffon@=
google.com> wrote:
> > > > > > >
> > > > > > > Commit 81d0bcf99009 ("drm/amdgpu: make display pinning more f=
lexible (v2)")
> > > > > > > allowed for newer ASICs to mix GTT and VRAM, this change also=
 noted that
> > > > > > > some older boards, such as Stoney and Carrizo do not support =
this.
> > > > > > > It appears that at least one additional ASIC does not support=
 this which
> > > > > > > is Raven.
> > > > > > >
> > > > > > > We observed this issue when migrating a device from a 5.4 to =
6.6 kernel
> > > > > > > and have confirmed that Raven also needs to be excluded from =
mixing GTT
> > > > > > > and VRAM.
> > > > > >
> > > > > > Can you elaborate a bit on what the problem is?  For carrizo an=
d
> > > > > > stoney this is a hardware limitation (all display buffers need =
to be
> > > > > > in GTT or VRAM, but not both).  Raven and newer don't have this
> > > > > > limitation and we tested raven pretty extensively at the time.
> > > > >
> > > > > Thanks for taking the time to look. We have automated testing and=
 a
> > > > > few igt gpu tools tests failed and after debugging we found that
> > > > > commit 81d0bcf99009 is what introduced the failures on this hardw=
are
> > > > > on 6.1+ kernels. The specific tests that fail are kms_async_flips=
 and
> > > > > kms_plane_alpha_blend, excluding Raven from this sharing of GTT a=
nd
> > > > > VRAM buffers resolves the issue.
> > > >
> > > > + Harry and Leo
> > > >
> > > > This sounds like the memory placement issue we discussed last week.
> > > > In that case, the issue is related to where the buffer ends up when=
 we
> > > > try to do an async flip.  In that case, we can't do an async flip
> > > > without a full modeset if the buffers locations are different than =
the
> > > > last modeset because we need to update more than just the buffer ba=
se
> > > > addresses.  This change works around that limitation by always forc=
ing
> > > > display buffers into VRAM or GTT.  Adding raven to this case may fi=
x
> > > > those tests but will make the overall experience worse because we'l=
l
> > > > end up effectively not being able to not fully utilize both gtt and
> > > > vram for display which would reintroduce all of the problems fixed =
by
> > > > 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)"=
).
> > >
> > > Thanks Alex, the thing is, we only observe this on Raven boards, why
> > > would Raven only be impacted by this? It would seem that all devices
> > > would have this issue, no? Also, I'm not familiar with how
> >
> > It depends on memory pressure and available memory in each pool.
> > E.g., initially the display buffer is in VRAM when the initial mode
> > set happens.  The watermarks, etc. are set for that scenario.  One of
> > the next frames ends up in a pool different than the original.  Now
> > the buffer is in GTT.  The async flip interface does a fast validation
> > to try and flip as soon as possible, but that validation fails because
> > the watermarks need to be updated which requires a full modeset.
> >
> > It's tricky to fix because you don't want to use the worst case
> > watermarks all the time because that will limit the number available
> > display options and you don't want to force everything to a particular
> > memory pool because that will limit the amount of memory that can be
> > used for display (which is what the patch in question fixed).  Ideally
> > the caller would do a test commit before the page flip to determine
> > whether or not it would succeed before issuing it and then we'd have
> > some feedback mechanism to tell the caller that the commit would fail
> > due to buffer placement so it would do a full modeset instead.  We
> > discussed this feedback mechanism last week at the display hackfest.
> >
> >
> > > kms_plane_alpha_blend works, but does this also support that test
> > > failing as the cause?
> >
> > That may be related.  I'm not too familiar with that test either, but
> > Leo or Harry can provide some guidance.
> >
> > Alex
>
> Thanks everyone for the input so far. I have a question for the
> maintainers, given that it seems that this is functionally broken for
> ASICs which are iGPUs, and there does not seem to be an easy fix, does
> it make sense to extend this proposed patch to all iGPUs until a more
> permanent fix can be identified? At the end of the day I'll take
> functional correctness over performance.

It's not functional correctness, it's usability.  All that is
potentially broken is async flips (which depend on memory pressure and
buffer placement), while if you effectively revert the patch, you end
up  limiting all display buffers to either VRAM or GTT which may end
up causing the inability to display anything because there is not
enough memory in that pool for the next modeset.  We'll start getting
bug reports about blank screens and failure to set modes because of
memory pressure.  I think if we want a short term fix, it would be to
always set the worst case watermarks.  The downside to that is that it
would possibly cause some working display setups to stop working if
they were on the margins to begin with.

Alex

>
> Brian
>
> >
> > >
> > > Thanks again,
> > > Brian
> > >
> > > >
> > > > Alex
> > > >
> > > > >
> > > > > Brian
> > > > >
> > > > > >
> > > > > >
> > > > > > Alex
> > > > > >
> > > > > > >
> > > > > > > Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more f=
lexible (v2)")
> > > > > > > Cc: Luben Tuikov <luben.tuikov@amd.com>
> > > > > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > > > Cc: stable@vger.kernel.org # 6.1+
> > > > > > > Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com=
>
> > > > > > > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
> > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > > > > index 73403744331a..5d7f13e25b7c 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > > > > @@ -1545,7 +1545,8 @@ uint32_t amdgpu_bo_get_preferred_domain=
(struct amdgpu_device *adev,
> > > > > > >                                             uint32_t domain)
> > > > > > >  {
> > > > > > >         if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_G=
EM_DOMAIN_GTT)) &&
> > > > > > > -           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->=
asic_type =3D=3D CHIP_STONEY))) {
> > > > > > > +           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->=
asic_type =3D=3D CHIP_STONEY) ||
> > > > > > > +            (adev->asic_type =3D=3D CHIP_RAVEN))) {
> > > > > > >                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> > > > > > >                 if (adev->gmc.real_vram_size <=3D AMDGPU_SG_T=
HRESHOLD)
> > > > > > >                         domain =3D AMDGPU_GEM_DOMAIN_GTT;
> > > > > > > --
> > > > > > > 2.50.0.727.gbf7dc18ff4-goog
> > > > > > >

