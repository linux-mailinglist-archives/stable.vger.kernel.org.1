Return-Path: <stable+bounces-108446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1188A0B931
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747AE3A2820
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D4D23ED54;
	Mon, 13 Jan 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWAB+Eoc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D5D23ED45
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777611; cv=none; b=OyHlYeKcNFihakmJiNliynNeT1ty87IMmKGXVDI0gcHnl7RwCvQRlsgjSPv255guiDrylNay8ORuKW+E2C8NXAIzQMPrU61OrChhMKgWFMF47ZBe1bW0fSr/dFJ5B/nnSaqEbRB/wwwp1rPl0G569Z0hHqMncPAbTXET9vULdNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777611; c=relaxed/simple;
	bh=uJ+YPR9rDl6BRcO6LD+GuY5BEFTvr6gj/XmUN79Dvg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6VLC5WnKSKLfmhRltOIdppKubhjvUPJBpHvZUezhvZoP44m52iFjPhm6pBCCxsNC0l4WJoD15XQOCzAh6mRaNt2y34WCiXj6khJkhq0E2JWTXJBKnwO0XL9BACfWtpLDftOge/mjDSpJmjTy1bx/vYJBxWZW7dsme1OkuNMg4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWAB+Eoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06577C4CED6
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736777611;
	bh=uJ+YPR9rDl6BRcO6LD+GuY5BEFTvr6gj/XmUN79Dvg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eWAB+Eocyewz8BxwMh1UtBoaZVIpV3SJ3jhrMF5AkhUzv0pB2jyLG9Z7sRuvjTLeH
	 nknAvlSeD1/bnZvtjduNx1XYtMKtu8tisjA8r7ZgUMKfCvVgWEN1yyY1IUc8cdsdpT
	 padJka9hZ2NAIHFiswFrQJp7oSDI59XkXqfmGKM7y3Sj17ihvDwD1RVkyAE2gjcbPs
	 IzejabphhceFIItGTfPw4wQilnf6MtUv8web3nBOK3lxAcUU3pFUjs9aQNzTBbr00a
	 7wYlpdG/P1O+yp07A+hz82LoUyrC2EMuiPQmv29omRqCPSHrGuP2cIoiryBsGIglRu
	 I3NAhOlZv7NdQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso6292753a12.2
        for <stable@vger.kernel.org>; Mon, 13 Jan 2025 06:13:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsgU/mt4FKhiaZWIs8IbmVXNe5KVz3qD4Y2yt5h+HmbernN3G3AsulXOuUHbagHaCuBYqMfAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8M6vl6ynYpGNNX7KfaF53RtHUQSCpaGMmqbdtmIAsdckfIiNX
	2UF3vijfYKNosxegnVNmpt7HaKRyiarDS5NHLN2twVun+SCDRfp2KC4lHVAkbZCc1Ki+QVUoWA2
	XYiiMTpWkOzEX8GnpsOdDjWEh1Yc=
X-Google-Smtp-Source: AGHT+IET6PpTD+AGjDBipiJDqcifcxJlAHJOwQzR2HLqCqZOKE/wWGn42Xu9sfDIuezeVDRGs4lzHydK9oj3voEc4Y8=
X-Received: by 2002:a17:907:3e91:b0:aaf:74b3:80db with SMTP id
 a640c23a62f3a-ab2ab670608mr1751450066b.3.1736777609506; Mon, 13 Jan 2025
 06:13:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111132149.1113736-1-chenhuacai@loongson.cn>
 <87o72lde9r.fsf@intel.com> <CAAhV-H6-yB5d8gXEH9TPHuzx0BJT+g8OCUmwTfSTTtqxfmcHDA@mail.gmail.com>
In-Reply-To: <CAAhV-H6-yB5d8gXEH9TPHuzx0BJT+g8OCUmwTfSTTtqxfmcHDA@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 13 Jan 2025 22:13:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7m0+-bHp0z0V+uySvBfPym4nMBCCTc5V80mYTfXjpuFA@mail.gmail.com>
X-Gm-Features: AbW1kvYBkUTij32tGBbF0vMyjWI5U27z_8i76ew8CDf9ghGTUx_ZV7HP19iQLK4
Message-ID: <CAAhV-H7m0+-bHp0z0V+uySvBfPym4nMBCCTc5V80mYTfXjpuFA@mail.gmail.com>
Subject: Re: [PATCH] drm: Remove redundant statement in drm_crtc_helper_set_mode()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Dave,

Gentle ping, can this patch be merged into 6.14?

Huacai

On Mon, Nov 25, 2024 at 2:00=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> On Mon, Nov 11, 2024 at 10:41=E2=80=AFPM Jani Nikula
> <jani.nikula@linux.intel.com> wrote:
> >
> > On Mon, 11 Nov 2024, Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > Commit dbbfaf5f2641a ("drm: Remove bridge support from legacy helpers=
")
> > > removes the drm_bridge_mode_fixup() call in drm_crtc_helper_set_mode(=
),
> > > which makes the subsequent "encoder_funcs =3D encoder->helper_private=
" be
> > > redundant, so remove it.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: dbbfaf5f2641a ("drm: Remove bridge support from legacy helpers=
")
> >
> > IMO not necessary because nothing's broken, it's just redundant.
> Maintainer is free to keep or remove the Cc and Fixes tag. :)
>
> Huacai
>
> >
> > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  drivers/gpu/drm/drm_crtc_helper.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_=
crtc_helper.c
> > > index 0955f1c385dd..39497493f74c 100644
> > > --- a/drivers/gpu/drm/drm_crtc_helper.c
> > > +++ b/drivers/gpu/drm/drm_crtc_helper.c
> > > @@ -334,7 +334,6 @@ bool drm_crtc_helper_set_mode(struct drm_crtc *cr=
tc,
> > >               if (!encoder_funcs)
> > >                       continue;
> > >
> > > -             encoder_funcs =3D encoder->helper_private;
> > >               if (encoder_funcs->mode_fixup) {
> > >                       if (!(ret =3D encoder_funcs->mode_fixup(encoder=
, mode,
> > >                                                             adjusted_=
mode))) {
> >
> > --
> > Jani Nikula, Intel

