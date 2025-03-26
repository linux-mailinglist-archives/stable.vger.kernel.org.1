Return-Path: <stable+bounces-126712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA8EA7180C
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 15:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCB3189979E
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C9B1F1905;
	Wed, 26 Mar 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJx4/Bvt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A99187876
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997784; cv=none; b=GsK5TKW+YPlfhE/7vsXIe8t5Azn6SA/+GUml3maCXlsAAElmBPNK8ay+jyNMnwSRbnmttt4Vik7QnGV/pux1RrMUhUtElVBaGymaWfIN3fqcBy2dMbSWJEKdG9hYPaqT5UU4MLclUmBKGHPDk+nKssJ5u7O1wzWYb1Shv7N70Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997784; c=relaxed/simple;
	bh=ZxD1L/4SWMjBXyNugknHic6RT5sTa3y09SyW3uPduyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HA9oU7oHi+C3BulChGrLSECib+bP+4CLA+kl8+m+c3M5QJTRFoUyW3eptkb9ijYBMldIIu5yaXZTXVPk4t1dEM0vaA+L2UhfJJVjbpMP+Yv5g0WqGwzcGC7s8ui97ENiMpTudcNhpIn0p1XtH3xxu+Gl/nm7gAxoJ2qznMqlY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJx4/Bvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71BAC4CEE2
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742997783;
	bh=ZxD1L/4SWMjBXyNugknHic6RT5sTa3y09SyW3uPduyI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JJx4/BvtvOnfQQhMCZvCC30cmIdIaTU603jr/TLaivl/oWVl7aSpiR6blXDVCDAHT
	 rHnEXAcQ6OTWyFbtpSnNANubpxbJ841mg9EqDwIzwuasYiNp4wJIokd6cI7Xzuw0kc
	 tfbArprUjmJCuOsJg2DtvM+nkVGBfoJlwftiokOy3lsr7Uv1cbZpnqjqSYSserWBM1
	 HrvafsM0t8sHgv3zxRchR8450EpbEvHhUTq3bKdjSOMZCAi39wONpaHHmcALhPwidY
	 AnM/1IH1DrZ6pnEHZupwyJk/XOXFZFD0OVcoov5zdlMtu6B05wWxLY7eHr3qNSfTfE
	 kus2vdN0/mwuA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac25520a289so1215255666b.3
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 07:03:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMS8whDpvB1rqWTqho3D4wVaV4w1Qn7GAX35PsWDWhZFDBWxRq7HT+I42AKvB8nUu19KDbKrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJR/N4eLyyv2mL4Fru0KJpZ3hlMHsjRL7LRjjMf/9GhsguGdNy
	hmrTpe1IXuzoAfvx+izDwefz4q+gOfzBlX2IhNPULWk28txKURHUxTvIKEA2tbxDZXB+qvORF5s
	RlQf4fdZ5dPcZuR7evnJwIqvyi/k=
X-Google-Smtp-Source: AGHT+IEOs7txicHdgnCHkM7VD2ojvnRpIL9jOkNJTMWkxL8LJTYmiutPKIpoUtBk1oN/TX3nugrzxpNbfsyQruDHFfc=
X-Received: by 2002:a17:907:97c2:b0:ac6:ba92:79c9 with SMTP id
 a640c23a62f3a-ac6ba927fdbmr764161466b.18.1742997781816; Wed, 26 Mar 2025
 07:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111132149.1113736-1-chenhuacai@loongson.cn>
 <87o72lde9r.fsf@intel.com> <CAAhV-H6-yB5d8gXEH9TPHuzx0BJT+g8OCUmwTfSTTtqxfmcHDA@mail.gmail.com>
 <CAAhV-H7m0+-bHp0z0V+uySvBfPym4nMBCCTc5V80mYTfXjpuFA@mail.gmail.com>
In-Reply-To: <CAAhV-H7m0+-bHp0z0V+uySvBfPym4nMBCCTc5V80mYTfXjpuFA@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 26 Mar 2025 22:02:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6AecMYG0t-Ldxy68fm-_Wk4VjcdFfc-s6xwEeddUn-Ew@mail.gmail.com>
X-Gm-Features: AQ5f1JqAcbK99JZmna9O9PUlkNaNGzhBcul1c78t3rzI4dtNkJnBRRtx6Z5UClk
Message-ID: <CAAhV-H6AecMYG0t-Ldxy68fm-_Wk4VjcdFfc-s6xwEeddUn-Ew@mail.gmail.com>
Subject: Re: [PATCH] drm: Remove redundant statement in drm_crtc_helper_set_mode()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Dave,

Gentle ping, can this patch be merged into 6.15?

Huacai

On Mon, Jan 13, 2025 at 10:13=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> Hi, Dave,
>
> Gentle ping, can this patch be merged into 6.14?
>
> Huacai
>
> On Mon, Nov 25, 2024 at 2:00=E2=80=AFPM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > On Mon, Nov 11, 2024 at 10:41=E2=80=AFPM Jani Nikula
> > <jani.nikula@linux.intel.com> wrote:
> > >
> > > On Mon, 11 Nov 2024, Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > Commit dbbfaf5f2641a ("drm: Remove bridge support from legacy helpe=
rs")
> > > > removes the drm_bridge_mode_fixup() call in drm_crtc_helper_set_mod=
e(),
> > > > which makes the subsequent "encoder_funcs =3D encoder->helper_priva=
te" be
> > > > redundant, so remove it.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: dbbfaf5f2641a ("drm: Remove bridge support from legacy helpe=
rs")
> > >
> > > IMO not necessary because nothing's broken, it's just redundant.
> > Maintainer is free to keep or remove the Cc and Fixes tag. :)
> >
> > Huacai
> >
> > >
> > > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> > >
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  drivers/gpu/drm/drm_crtc_helper.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/dr=
m_crtc_helper.c
> > > > index 0955f1c385dd..39497493f74c 100644
> > > > --- a/drivers/gpu/drm/drm_crtc_helper.c
> > > > +++ b/drivers/gpu/drm/drm_crtc_helper.c
> > > > @@ -334,7 +334,6 @@ bool drm_crtc_helper_set_mode(struct drm_crtc *=
crtc,
> > > >               if (!encoder_funcs)
> > > >                       continue;
> > > >
> > > > -             encoder_funcs =3D encoder->helper_private;
> > > >               if (encoder_funcs->mode_fixup) {
> > > >                       if (!(ret =3D encoder_funcs->mode_fixup(encod=
er, mode,
> > > >                                                             adjuste=
d_mode))) {
> > >
> > > --
> > > Jani Nikula, Intel

