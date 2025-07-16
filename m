Return-Path: <stable+bounces-163199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B40B07F40
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 23:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA0EA45C67
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E171292908;
	Wed, 16 Jul 2025 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox6WDTTy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E2526FA4E;
	Wed, 16 Jul 2025 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752699794; cv=none; b=kFQeQVXQJ/M+mPiVnfPvNfTHuk7pqeTB1eP2VzmeTHO2VyEedY6jRrqlMTtpgVpxW2T1Xz4mGHYkUPdCKnYeY4PpSKpnkQxE1XKDM5eu8Qg/aY/bmheM2RKvEx4a+eVuvonB97KTnBl4obBWY029Ah3by3IBs1HX5SbDvQaTNEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752699794; c=relaxed/simple;
	bh=q0Q9+rj56dxBlENaBCdvs7m1IadW9ziKI1ujcrk188I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvA/K5foybhWOSoKm6Hx8rajUiRDBPtSAmpNEsh6pukqeiq1kBkuvaujY7MMpoxYyVsVYXjHsMtLvZOf8sqlPyk2UAq0mLPiED8uSEASQ6GBBE4w1oda747lpV8MRROnjPTvhtQ1lNKTn3jsJxkHwj+PQPFgVWYZ8kvuyVZFpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox6WDTTy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23de2b47a48so184545ad.2;
        Wed, 16 Jul 2025 14:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752699791; x=1753304591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6UIkM+5JfCoSV3Rr9tFp4Y8vvVmQFZv80ACh/YnQDA=;
        b=Ox6WDTTyJQzIc+td8xrRn/4P9tgmGX7j3EbSCuWYEI0QGOKrNjhajmHJScIz5SEfqu
         RjGizrNt87s1HXM3yVjtz0v7pskSL82sO6scFWiJqXQu24YrEYnErPCLoTUxVD4Ot68J
         8+qyOXEb53uGAHuYF/TYNwNPZ+Ifl5gjd6dP1TmwIrpDZQxNCZHzitAnilWCMLDPoTh4
         kj41whKHkyspoAfezPU0pH4frXEsCFTxxigW4vYoLZWVdDG+9q/6iUMsfpfe1Hk5UI/T
         2nrlupjQFmqojI/bmzNtAy5DU6vd8B7v+FPtiOk7LgMRrSACPr/R4KuVjjpGVLxCJHCt
         adFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752699791; x=1753304591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6UIkM+5JfCoSV3Rr9tFp4Y8vvVmQFZv80ACh/YnQDA=;
        b=bZDqGI89xd/tiukhBqk7YK+n1LZpDL+QCTFaRyhJtV0nkvFzN2UB1DRgDoXaiYpEVV
         cw5VHNgiTzyboumWJEHe7HkrppVyKgU8aKpLDH7qVsrS5AfenuJ4yz9PdvX7iqj+kqUy
         RiclTDpx+x7fZ6yUg8hGg8kRa0sXPJV841EDtd188nIMzsf9CqUFD90IAKGeGJsQW8qc
         yBF8wNoszVTIhGKty9rrdSIWqnC1Kw+bNQlKy8lbqiNuNbF7GTaKSBcGzaruFt20Zsgq
         F9Ys1z2kS+i1IbjEQjKcBO+NyYH+BzNHr5PlLTvpxqs9EgC4RfQYGj5k1ymEQ3L0f/nl
         ou2w==
X-Forwarded-Encrypted: i=1; AJvYcCWCLWelV7hMnhrduQeT8zYX20zWErwGR57Sl7qYP+uAxEOyl8aWZZ/g1KGXcRt+AkfPmRX57TkFd/WC1ik=@vger.kernel.org, AJvYcCWPHXHNdkb34TDYBCe0lh5FG707Fi52S3pim7qlD1GOsSh1KY/wf25LoZ5GBZckl5JlBdPrcL9T@vger.kernel.org
X-Gm-Message-State: AOJu0YypE5iuidMLwD6fK75sDBW+kGW/6GmMr9sEkrbdlQYxu1+6FbVk
	cXZk2A2Cxn7oLM9rQrOgmlMqiqSd9pce4WYIXNlzsBWlRzQaJRSVm66gzid5Pxn9oRV+whQBUMf
	jqkVhaNE/bEsItrhnwDgoxvHlntbVlKE=
X-Gm-Gg: ASbGnctP0xYEghk5Kr4H+VF03HxRT2sxfQG88jw+vjh31DvAAVq0dpOwqT0WUhcKpc3
	Elf+LpetFO65J5VvyfryUL9pUDXwK6WfCTOKkKpaHBa5RwTCanyPqX9Dnf3Sfp+NSQxpZnaspvP
	cyBvhpRff8GyOoPxG7iB6g6BapWBZklP5VW1VxE/M0BR4h59lvdB4n3zHEwZRS8YhHYnGuLBqJs
	bkfdg3n
X-Google-Smtp-Source: AGHT+IHsghxRhO1E0ZijyAH2I0nUHRxro/f8IUv0wNQCuD6VDXxJySfi/1GlXQbFrEdYhyP2vJpz+Q//Pz6HZeGbkkc=
X-Received: by 2002:a17:902:e5c8:b0:234:a734:4abe with SMTP id
 d9443c01a7336-23e24ec7c0dmr27962075ad.1.1752699791287; Wed, 16 Jul 2025
 14:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716161753.231145-1-bgeffon@google.com> <CADnq5_P+a2g_YzKW7S4YSF5kQgXe+PNrMKEOAHuf9yhFg98pSQ@mail.gmail.com>
 <CADyq12zB7+opz0vUgyAQSdbHcYMwbZrZp+qxKdYcqaeCeRVbCw@mail.gmail.com>
In-Reply-To: <CADyq12zB7+opz0vUgyAQSdbHcYMwbZrZp+qxKdYcqaeCeRVbCw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Jul 2025 17:02:59 -0400
X-Gm-Features: Ac12FXwLG4TN6wJTWjc81ebRG8OmwjrBMB7idQ0T2AQxzZyfSqA0dNIRVGujuQ8
Message-ID: <CADnq5_OeTJqzg0DgV06b-u_AmgaqXL5XWdQ6h40zcgGj1mCE_A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Raven: don't allow mixing GTT and VRAM
To: Brian Geffon <bgeffon@google.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, 
	"Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>, 
	Pratap Nirujogi <pratap.nirujogi@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Garrick Evans <garrick@google.com>, 
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 12:40=E2=80=AFPM Brian Geffon <bgeffon@google.com> =
wrote:
>
> On Wed, Jul 16, 2025 at 12:33=E2=80=AFPM Alex Deucher <alexdeucher@gmail.=
com> wrote:
> >
> > On Wed, Jul 16, 2025 at 12:18=E2=80=AFPM Brian Geffon <bgeffon@google.c=
om> wrote:
> > >
> > > Commit 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible =
(v2)")
> > > allowed for newer ASICs to mix GTT and VRAM, this change also noted t=
hat
> > > some older boards, such as Stoney and Carrizo do not support this.
> > > It appears that at least one additional ASIC does not support this wh=
ich
> > > is Raven.
> > >
> > > We observed this issue when migrating a device from a 5.4 to 6.6 kern=
el
> > > and have confirmed that Raven also needs to be excluded from mixing G=
TT
> > > and VRAM.
> >
> > Can you elaborate a bit on what the problem is?  For carrizo and
> > stoney this is a hardware limitation (all display buffers need to be
> > in GTT or VRAM, but not both).  Raven and newer don't have this
> > limitation and we tested raven pretty extensively at the time.
>
> Thanks for taking the time to look. We have automated testing and a
> few igt gpu tools tests failed and after debugging we found that
> commit 81d0bcf99009 is what introduced the failures on this hardware
> on 6.1+ kernels. The specific tests that fail are kms_async_flips and
> kms_plane_alpha_blend, excluding Raven from this sharing of GTT and
> VRAM buffers resolves the issue.

+ Harry and Leo

This sounds like the memory placement issue we discussed last week.
In that case, the issue is related to where the buffer ends up when we
try to do an async flip.  In that case, we can't do an async flip
without a full modeset if the buffers locations are different than the
last modeset because we need to update more than just the buffer base
addresses.  This change works around that limitation by always forcing
display buffers into VRAM or GTT.  Adding raven to this case may fix
those tests but will make the overall experience worse because we'll
end up effectively not being able to not fully utilize both gtt and
vram for display which would reintroduce all of the problems fixed by
81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)").

Alex

>
> Brian
>
> >
> >
> > Alex
> >
> > >
> > > Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible =
(v2)")
> > > Cc: Luben Tuikov <luben.tuikov@amd.com>
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: stable@vger.kernel.org # 6.1+
> > > Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_object.c
> > > index 73403744331a..5d7f13e25b7c 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > @@ -1545,7 +1545,8 @@ uint32_t amdgpu_bo_get_preferred_domain(struct =
amdgpu_device *adev,
> > >                                             uint32_t domain)
> > >  {
> > >         if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAI=
N_GTT)) &&
> > > -           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_typ=
e =3D=3D CHIP_STONEY))) {
> > > +           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_typ=
e =3D=3D CHIP_STONEY) ||
> > > +            (adev->asic_type =3D=3D CHIP_RAVEN))) {
> > >                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> > >                 if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHOLD=
)
> > >                         domain =3D AMDGPU_GEM_DOMAIN_GTT;
> > > --
> > > 2.50.0.727.gbf7dc18ff4-goog
> > >

