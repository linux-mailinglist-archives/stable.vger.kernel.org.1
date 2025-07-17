Return-Path: <stable+bounces-163271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3149AB08FF8
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 16:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB9C585680
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 14:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0732F2F7D08;
	Thu, 17 Jul 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhU+0qHk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AF51DB375;
	Thu, 17 Jul 2025 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764347; cv=none; b=ruVlSOw2A7JwyvLph30YSU+iCJmRkh1WAs+gyup+jVDyO00tjSdb5eawi5LcZP7AqFQwq9ziJSH8pOOM52XOAF437HbiP32hSGGjJR06yOhewTUIfrZtIt1OBpQXPH7gXLJkpD7fD1npkmpL/xhFLlgxhRhMFYAdW50DkxWEdl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764347; c=relaxed/simple;
	bh=DTo3ffJbLlUuJEP+zhqi55XqmtMADhA+yWU6G/zt2jI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6rZcbJ+/11+Yr1HxMdQraQRCRWjR7ltvuF+K+tAK8BVQJnrGe7jvcLAcT9/FjmOYfSCCvUrEANp7JigadGDvZf6cOa3V3QDW9z5qWtKHlwbGtGjNYSu0HxHo3JBvl30eCXepxUUUDcRAP3OM74H3m0iVD4avsKbvUxWTzGQ68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhU+0qHk; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b31ef5f24b7so61332a12.0;
        Thu, 17 Jul 2025 07:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752764345; x=1753369145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ya0Pf7GBbiFI9yCYfAdyjgFg/XCTrL1Lup/5nSkjZ4=;
        b=FhU+0qHkHKFZTw3TRKIG+/Mi2dWmhxULIm1f8LDiQobKGMshyXO/GPBCHJy3vevj9A
         cjFJhBzvd652dqLPgxkYiYkBHPmNwjVZSn2y81rhyrXGU+v6mQwOAmpiZUOOAA9lWfOB
         PE6uAL63Vwg7rGBrCWgL4luudcPYW+mrAmVAzn2f/fdUTXtPhqFUjo/rbKSMXUJXpTc6
         wKAurJQ5VLFPcPBcO9pztpkoSoqBDHhEc2RaTLhBfMEQ4z8lHeWYNYmito0tGtLn10Ch
         WWYtz6mKJLxwOdEYl0TjW3WkToSHDn2EDrl6ug4nHeK19vFfa2+IOsKW4FP8QqfrUyAo
         6naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764345; x=1753369145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ya0Pf7GBbiFI9yCYfAdyjgFg/XCTrL1Lup/5nSkjZ4=;
        b=mqnoyPLmHnwcGjg5VlePSwPY2I+2EuFXVAbdJSSavefntfP0gVodZES7OU45okZXxC
         oAgDFiU2r8OHyQLpGhdX3FtXB8ASpaMuI+xHajVSr1KCk/sbqwoJM/2LAGl4lpb1icLU
         0/7Rrz0Nqx7/xcIrEFujHD1uII9EoqjrBcg+hoB15Su11xNR+BX5RadnC2Rlsc+bguTv
         pTh1OjwiaBGjcJr2zCjnWltdWxnO85eRA2KILtFEsOdmOzNsdfd8v4/+Zb+3OW6MDinx
         2ulS4wmMz//U9/5kAbLdD+j7W7Hcaw05HqSkeTt4n7hg/GgOfSMihR++OZGE39dC8SAF
         b+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWV6ri8dt+vsE2Fyg4/n6ISJ5teUtw/0PbGnLsVEjhub0OmtD1axoFnawzcjlMhCneFXOCw1xnA@vger.kernel.org, AJvYcCXfABSH49f4HHHDbXDybjEnonfKDN6BnjIJUbKdxbNUJS/p6jcXPy+ZCY3o1SnM/x7+DFwu9vjut2IO7vs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx44/JCS27IlMcNfdirHeDMZ+wA9ItjPeKWzKF08OHhePRCiNdX
	cVmuXi7woib1z7ly9V3zKYMLgOrXavlvFtYXurRn4oN4a2WsU5yozw9uuEjacaVwCi3k2O2Lacx
	/CCsdgBnrTM+dLUa+tXe2gzJm9PaGkQaoDg==
X-Gm-Gg: ASbGncsT8or5De2GY0/oURF10Jv8btqyV+8yRVS9siosPwJDnxRqJXMHFEu2Hcz2z1M
	hKW9rVAYca+BnsdRdf9Fxi3AiA8vm+YP9XwoQnB3k+66LlrarE+ugH5bL08JtvbCLdOvkyZrpDI
	KZTiYqwaK9hofiS2/DcAks0a68UVUKRMJUzq4m2XJnjENzJ4fD/ulWfIK8IU+bUbxiH8fVZ9mQp
	pV2riBm
X-Google-Smtp-Source: AGHT+IHHlq/nQ9G6EWKKiMZEs2wLT9KLcyNzfgfIaMgOnK9+QgUCsPjP/ogcxgDDwwAVqR5cbpqVFpHPsuJaCZ+oScY=
X-Received: by 2002:a17:90b:4b8b:b0:311:9c9a:58e2 with SMTP id
 98e67ed59e1d1-31c9e798695mr3931081a91.7.1752764345395; Thu, 17 Jul 2025
 07:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716161753.231145-1-bgeffon@google.com> <CADnq5_P+a2g_YzKW7S4YSF5kQgXe+PNrMKEOAHuf9yhFg98pSQ@mail.gmail.com>
 <CADyq12zB7+opz0vUgyAQSdbHcYMwbZrZp+qxKdYcqaeCeRVbCw@mail.gmail.com>
 <CADnq5_OeTJqzg0DgV06b-u_AmgaqXL5XWdQ6h40zcgGj1mCE_A@mail.gmail.com> <CADyq12ysC9C2tsQ3GrQJB3x6aZPzM1o8pyTW8z4bxjGPsfEZvw@mail.gmail.com>
In-Reply-To: <CADyq12ysC9C2tsQ3GrQJB3x6aZPzM1o8pyTW8z4bxjGPsfEZvw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Jul 2025 10:58:53 -0400
X-Gm-Features: Ac12FXzrKvidT2q85M3LPC-hr0sTqZC7FoEbjKXO6dUbumO7fgzZhruHSNnRlGI
Message-ID: <CADnq5_PnktmP+0Hw0T04VkrkKoF_TGz5HOzRd1UZq6XOE0Rm1g@mail.gmail.com>
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

On Wed, Jul 16, 2025 at 8:13=E2=80=AFPM Brian Geffon <bgeffon@google.com> w=
rote:
>
> On Wed, Jul 16, 2025 at 5:03=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Wed, Jul 16, 2025 at 12:40=E2=80=AFPM Brian Geffon <bgeffon@google.c=
om> wrote:
> > >
> > > On Wed, Jul 16, 2025 at 12:33=E2=80=AFPM Alex Deucher <alexdeucher@gm=
ail.com> wrote:
> > > >
> > > > On Wed, Jul 16, 2025 at 12:18=E2=80=AFPM Brian Geffon <bgeffon@goog=
le.com> wrote:
> > > > >
> > > > > Commit 81d0bcf99009 ("drm/amdgpu: make display pinning more flexi=
ble (v2)")
> > > > > allowed for newer ASICs to mix GTT and VRAM, this change also not=
ed that
> > > > > some older boards, such as Stoney and Carrizo do not support this=
.
> > > > > It appears that at least one additional ASIC does not support thi=
s which
> > > > > is Raven.
> > > > >
> > > > > We observed this issue when migrating a device from a 5.4 to 6.6 =
kernel
> > > > > and have confirmed that Raven also needs to be excluded from mixi=
ng GTT
> > > > > and VRAM.
> > > >
> > > > Can you elaborate a bit on what the problem is?  For carrizo and
> > > > stoney this is a hardware limitation (all display buffers need to b=
e
> > > > in GTT or VRAM, but not both).  Raven and newer don't have this
> > > > limitation and we tested raven pretty extensively at the time.
> > >
> > > Thanks for taking the time to look. We have automated testing and a
> > > few igt gpu tools tests failed and after debugging we found that
> > > commit 81d0bcf99009 is what introduced the failures on this hardware
> > > on 6.1+ kernels. The specific tests that fail are kms_async_flips and
> > > kms_plane_alpha_blend, excluding Raven from this sharing of GTT and
> > > VRAM buffers resolves the issue.
> >
> > + Harry and Leo
> >
> > This sounds like the memory placement issue we discussed last week.
> > In that case, the issue is related to where the buffer ends up when we
> > try to do an async flip.  In that case, we can't do an async flip
> > without a full modeset if the buffers locations are different than the
> > last modeset because we need to update more than just the buffer base
> > addresses.  This change works around that limitation by always forcing
> > display buffers into VRAM or GTT.  Adding raven to this case may fix
> > those tests but will make the overall experience worse because we'll
> > end up effectively not being able to not fully utilize both gtt and
> > vram for display which would reintroduce all of the problems fixed by
> > 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)").
>
> Thanks Alex, the thing is, we only observe this on Raven boards, why
> would Raven only be impacted by this? It would seem that all devices
> would have this issue, no? Also, I'm not familiar with how

It depends on memory pressure and available memory in each pool.
E.g., initially the display buffer is in VRAM when the initial mode
set happens.  The watermarks, etc. are set for that scenario.  One of
the next frames ends up in a pool different than the original.  Now
the buffer is in GTT.  The async flip interface does a fast validation
to try and flip as soon as possible, but that validation fails because
the watermarks need to be updated which requires a full modeset.

It's tricky to fix because you don't want to use the worst case
watermarks all the time because that will limit the number available
display options and you don't want to force everything to a particular
memory pool because that will limit the amount of memory that can be
used for display (which is what the patch in question fixed).  Ideally
the caller would do a test commit before the page flip to determine
whether or not it would succeed before issuing it and then we'd have
some feedback mechanism to tell the caller that the commit would fail
due to buffer placement so it would do a full modeset instead.  We
discussed this feedback mechanism last week at the display hackfest.


> kms_plane_alpha_blend works, but does this also support that test
> failing as the cause?

That may be related.  I'm not too familiar with that test either, but
Leo or Harry can provide some guidance.

Alex

>
> Thanks again,
> Brian
>
> >
> > Alex
> >
> > >
> > > Brian
> > >
> > > >
> > > >
> > > > Alex
> > > >
> > > > >
> > > > > Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flexi=
ble (v2)")
> > > > > Cc: Luben Tuikov <luben.tuikov@amd.com>
> > > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > Cc: stable@vger.kernel.org # 6.1+
> > > > > Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > > > > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > > index 73403744331a..5d7f13e25b7c 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > > @@ -1545,7 +1545,8 @@ uint32_t amdgpu_bo_get_preferred_domain(str=
uct amdgpu_device *adev,
> > > > >                                             uint32_t domain)
> > > > >  {
> > > > >         if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_D=
OMAIN_GTT)) &&
> > > > > -           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic=
_type =3D=3D CHIP_STONEY))) {
> > > > > +           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic=
_type =3D=3D CHIP_STONEY) ||
> > > > > +            (adev->asic_type =3D=3D CHIP_RAVEN))) {
> > > > >                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> > > > >                 if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRES=
HOLD)
> > > > >                         domain =3D AMDGPU_GEM_DOMAIN_GTT;
> > > > > --
> > > > > 2.50.0.727.gbf7dc18ff4-goog
> > > > >

