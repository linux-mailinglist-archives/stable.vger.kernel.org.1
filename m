Return-Path: <stable+bounces-61878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC74E93D38C
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 14:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67891C2318D
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 12:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F1A17B503;
	Fri, 26 Jul 2024 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNoLZGn/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97B617BB25;
	Fri, 26 Jul 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998353; cv=none; b=SVB3011WHnVn3w9igimT07tHUD1VOtmXyw7pY2BQBCbn1aKENq4ppHycRQXLQ4DGBkYI8es2l2fJ+eyJtsd4p4rkEnaBpTH4cwE3o1uIXsH9Bl1+FCCHxnmt9HYLhGlWIxe433X6thG9JpdRl30xq2KbpeVbHlWWlVrCABEFa/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998353; c=relaxed/simple;
	bh=oK84gDfb6IKUdxtY3ouBXglqXw6UTA0kWzeWDwGv0nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQ05c39TwFrz3S+6/+CBlNvTjmEqoHIxnR/3xUi4BJ2XQK7Yi/RNcL5423EFk1mv37VxKAahN2zwr+of/eZqHJhmJsf7C3/EgKLOFrmksQv7jQl4dxR+1EXI0cHywS7/YcnJiiEIoS9qQ9lxQp58fKrZWkS6xlQT9DNFP4GBI5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNoLZGn/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc52394c92so6201465ad.1;
        Fri, 26 Jul 2024 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721998350; x=1722603150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nl6ThKFvgtQtUv9d4LulxfTZukBDYJgIsNXgNCVx5ac=;
        b=QNoLZGn/Xb4fd0ClQBDL4HeOPiyYzybqnsIFkC0MUgcyoqSaMxxhD7b3sxr1GWRDoa
         VTzd3Yxc3s68Zw+BJteIG2lMDmo8qiF6bPzWsmdAPds3j4AElUq9xlUBSmIbhXhLewhd
         YyE+Y07Vc6BveTPMj/Uia5Yo0FhQ9/yVjH1zR5JEAIxkihrkeRNPK0+TuMvQVPa9PJoX
         WLLbSvUnqKcauADKW9zHOaLlDu7sJb4AmM/oZy/jWos1DuWw9+dbTfaNnsuc0Xbbs4nz
         qWDTJ4jQM3pln2cWgFXGD8mOKgO/SxgkLFlobZrPir7Dn0Z93SGm1M2Diib+yLcrZZB7
         WBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721998350; x=1722603150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nl6ThKFvgtQtUv9d4LulxfTZukBDYJgIsNXgNCVx5ac=;
        b=pVAXQlEd1/y2BFZlT8lVSXX+LfWUyNs/sOUfUJgiLskjX02y3Rc/HqzZ5Y6UaIXmqi
         51w1Mic/DZMMHchQJO4YqWUthrj0gyyuYVBtIA4P05UhbNVRo/8iG9hYlHHIsEn9Vr4l
         RgWg/UdhCWff121GtDwUZnxX8C947Ig0PKnUxkr5vtDxrzl6ekVVgjLr7WcT1j5DcnKi
         JKakVcIxnZZELyJh+Hfcf/qLIObvnLACXK6v3u6WHltqNj0bxcrsWzb8EMbMrGdSCAtu
         cxLw8l1uLRmWf3G3iL1H9uM2EXVznq8M/D0YpwziDsEkt8qTXECMhVj5uLTbL0rw+6LM
         c+gg==
X-Forwarded-Encrypted: i=1; AJvYcCX7NkgR3ga30F1zscPrdtSOLp+aD3W6XN3X2DpYie5HIgja+oEStc4qE+mY6aF0lVR8CpBFFSNsJCuRBCjQg1bhME+PEuIv97eKfH43+nJXjzNq4rSd2nk7FSqkNFzvzj/YVk6G
X-Gm-Message-State: AOJu0YyBmPVQz9muL6OtfY57kD3ImyhVuU7eU6A0nOGR8zP7SDgCxzYG
	2ZeS7ddUQEeoDNU5jv7TuHyAI071jRn/O8RsXj38SgmgR+4m14Wu6irI8v1GNe8jP8U2O+i4FGm
	/n2jcOKlhHYdnOZQqznY30TuWS3q2jQ==
X-Google-Smtp-Source: AGHT+IEJHhRw/2mhPW780IeoT698zyyYGxwE+9O2EQ0T7VqZtjo0r65t5srrsM5KUTRmbT+dv1QTnf0jjMW7AFpVSkc=
X-Received: by 2002:a17:90b:b03:b0:2c8:e43b:4015 with SMTP id
 98e67ed59e1d1-2cf2377360bmr6772084a91.6.1721998350174; Fri, 26 Jul 2024
 05:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725180950.15820-1-n.zhandarovich@fintech.ru> <e5199bf0-0861-4b79-8f32-d14a784b116f@amd.com>
In-Reply-To: <e5199bf0-0861-4b79-8f32-d14a784b116f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jul 2024 08:52:17 -0400
Message-ID: <CADnq5_PuzU12x=M09HaGkG7Yqg8Lk1M1nWDAut7iP09TT33D6g@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/evergreen_cs: fix int overflow errors in cs
 track offsets
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Alex Deucher <alexander.deucher@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jerome Glisse <jglisse@redhat.com>, Dave Airlie <airlied@redhat.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 3:05=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 25.07.24 um 20:09 schrieb Nikita Zhandarovich:
> > Several cs track offsets (such as 'track->db_s_read_offset')
> > either are initialized with or plainly take big enough values that,
> > once shifted 8 bits left, may be hit with integer overflow if the
> > resulting values end up going over u32 limit.
> >
> > Some debug prints take this into account (see according dev_warn() in
> > evergreen_cs_track_validate_stencil()), even if the actual
> > calculated value assigned to local 'offset' variable is missing
> > similar proper expansion.
> >
> > Mitigate the problem by casting the type of right operands to the
> > wider type of corresponding left ones in all such cases.
> >
> > Found by Linux Verification Center (linuxtesting.org) with static
> > analysis tool SVACE.
> >
> > Fixes: 285484e2d55e ("drm/radeon: add support for evergreen/ni tiling i=
nformations v11")
> > Cc: stable@vger.kernel.org
>
> Well first of all the long cast doesn't makes the value 64bit, it
> depends on the architecture.
>
> Then IIRC the underlying hw can only handle a 32bit address space so
> having the offset as long is incorrect to begin with.

Evergreen chips support a 36 bit internal address space and NI and
newer support a 40 bit one, so this is applicable.

Alex

>
> And finally that is absolutely not material for stable.
>
> Regards,
> Christian.
>
> > Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> > ---
> > P.S. While I am not certain that track->cb_color_bo_offset[id]
> > actually ends up taking values high enough to cause an overflow,
> > nonetheless I thought it prudent to cast it to ulong as well.
> >
> >   drivers/gpu/drm/radeon/evergreen_cs.c | 18 +++++++++---------
> >   1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/ra=
deon/evergreen_cs.c
> > index 1fe6e0d883c7..d734d221e2da 100644
> > --- a/drivers/gpu/drm/radeon/evergreen_cs.c
> > +++ b/drivers/gpu/drm/radeon/evergreen_cs.c
> > @@ -433,7 +433,7 @@ static int evergreen_cs_track_validate_cb(struct ra=
deon_cs_parser *p, unsigned i
> >               return r;
> >       }
> >
> > -     offset =3D track->cb_color_bo_offset[id] << 8;
> > +     offset =3D (unsigned long)track->cb_color_bo_offset[id] << 8;
> >       if (offset & (surf.base_align - 1)) {
> >               dev_warn(p->dev, "%s:%d cb[%d] bo base %ld not aligned wi=
th %ld\n",
> >                        __func__, __LINE__, id, offset, surf.base_align)=
;
> > @@ -455,7 +455,7 @@ static int evergreen_cs_track_validate_cb(struct ra=
deon_cs_parser *p, unsigned i
> >                               min =3D surf.nby - 8;
> >                       }
> >                       bsize =3D radeon_bo_size(track->cb_color_bo[id]);
> > -                     tmp =3D track->cb_color_bo_offset[id] << 8;
> > +                     tmp =3D (unsigned long)track->cb_color_bo_offset[=
id] << 8;
> >                       for (nby =3D surf.nby; nby > min; nby--) {
> >                               size =3D nby * surf.nbx * surf.bpe * surf=
.nsamples;
> >                               if ((tmp + size * mslice) <=3D bsize) {
> > @@ -476,10 +476,10 @@ static int evergreen_cs_track_validate_cb(struct =
radeon_cs_parser *p, unsigned i
> >                       }
> >               }
> >               dev_warn(p->dev, "%s:%d cb[%d] bo too small (layer size %=
d, "
> > -                      "offset %d, max layer %d, bo size %ld, slice %d)=
\n",
> > +                      "offset %ld, max layer %d, bo size %ld, slice %d=
)\n",
> >                        __func__, __LINE__, id, surf.layer_size,
> > -                     track->cb_color_bo_offset[id] << 8, mslice,
> > -                     radeon_bo_size(track->cb_color_bo[id]), slice);
> > +                     (unsigned long)track->cb_color_bo_offset[id] << 8=
,
> > +                     mslice, radeon_bo_size(track->cb_color_bo[id]), s=
lice);
> >               dev_warn(p->dev, "%s:%d problematic surf: (%d %d) (%d %d =
%d %d %d %d %d)\n",
> >                        __func__, __LINE__, surf.nbx, surf.nby,
> >                       surf.mode, surf.bpe, surf.nsamples,
> > @@ -608,7 +608,7 @@ static int evergreen_cs_track_validate_stencil(stru=
ct radeon_cs_parser *p)
> >               return r;
> >       }
> >
> > -     offset =3D track->db_s_read_offset << 8;
> > +     offset =3D (unsigned long)track->db_s_read_offset << 8;
> >       if (offset & (surf.base_align - 1)) {
> >               dev_warn(p->dev, "%s:%d stencil read bo base %ld not alig=
ned with %ld\n",
> >                        __func__, __LINE__, offset, surf.base_align);
> > @@ -627,7 +627,7 @@ static int evergreen_cs_track_validate_stencil(stru=
ct radeon_cs_parser *p)
> >               return -EINVAL;
> >       }
> >
> > -     offset =3D track->db_s_write_offset << 8;
> > +     offset =3D (unsigned long)track->db_s_write_offset << 8;
> >       if (offset & (surf.base_align - 1)) {
> >               dev_warn(p->dev, "%s:%d stencil write bo base %ld not ali=
gned with %ld\n",
> >                        __func__, __LINE__, offset, surf.base_align);
> > @@ -706,7 +706,7 @@ static int evergreen_cs_track_validate_depth(struct=
 radeon_cs_parser *p)
> >               return r;
> >       }
> >
> > -     offset =3D track->db_z_read_offset << 8;
> > +     offset =3D (unsigned long)track->db_z_read_offset << 8;
> >       if (offset & (surf.base_align - 1)) {
> >               dev_warn(p->dev, "%s:%d stencil read bo base %ld not alig=
ned with %ld\n",
> >                        __func__, __LINE__, offset, surf.base_align);
> > @@ -722,7 +722,7 @@ static int evergreen_cs_track_validate_depth(struct=
 radeon_cs_parser *p)
> >               return -EINVAL;
> >       }
> >
> > -     offset =3D track->db_z_write_offset << 8;
> > +     offset =3D (unsigned long)track->db_z_write_offset << 8;
> >       if (offset & (surf.base_align - 1)) {
> >               dev_warn(p->dev, "%s:%d stencil write bo base %ld not ali=
gned with %ld\n",
> >                        __func__, __LINE__, offset, surf.base_align);
>

