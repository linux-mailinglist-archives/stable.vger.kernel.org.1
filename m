Return-Path: <stable+bounces-95344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B849D7B64
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 07:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7982281B72
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 06:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5D5364D6;
	Mon, 25 Nov 2024 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHdOEcvu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2092500AC
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732514467; cv=none; b=lLUW5S8QL3ljppq9NDYRDge1Dt08wOTl05vrrg9isI4/PPg4/ZoATvQ58EVjwWQj3lPcXa81t85LjZBioW7nGPwAAY88+qW1Tv5UntutfjTpo24524zd5dqjA3eEzo8OfaYT+BxS1iVpteDRf64rajK4iJf7w4F2Zhuqjenx6E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732514467; c=relaxed/simple;
	bh=ds4/aIVpFugEaz01RU1zBg4z2TBBiIBiP/DOzbNMUUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlXVZujgt0UIcwoourStnzDHXj1xQKjjuIAAVlEeA13QTpLeGTO9hlJboVrQrcIGCm9LkYqnokuNF4ZGGf2eEv22OAflunsfoFUxQT07ns1Mcd2szllEcyAtCXKUZMFGCdIfHjQiKUOBj+Yac4lBDr7pnBwCmU8XLpBtRNChltE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHdOEcvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29692C4AF09
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 06:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732514467;
	bh=ds4/aIVpFugEaz01RU1zBg4z2TBBiIBiP/DOzbNMUUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CHdOEcvu6wgykl3uA30G62WbHdqi2kmwdkeNByfPgwPGgniPvMGyCY4Ntir5oV7vx
	 RmHWYYU3lfZslNLUqR0pmg/yV0v0op0qSKI/XR+fPaID+Y9VC/p3vDnOqmQZVoLN2B
	 rfhpwxI3nmjRzooSIPUWLWU0ZyNYo2o6B2CMRRsWQO6AtisIifftpf/yF5wKvr+yaz
	 10jdvT1NgL3LTbm1rxUHktgIPJJ8esFsROimDVgUfCnuY+js6Qu8nbubt3nyc6V37x
	 idkREMt0En8RA7Zfblpq47ZV5AVw/UZ1Skqsdu8Rtia+XVepkJ+oEgN1BhPUbP/j/C
	 sKhwYbwu9Uq7Q==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa54adcb894so102676366b.0
        for <stable@vger.kernel.org>; Sun, 24 Nov 2024 22:01:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpL+k3q02Xw8LRRtLZA9TimdUL4CXP9B3RfUrwiu0Ql4lEV+pIVlQEGY3D3fGl0rfVU+Za6O4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+sx24M+IHGxGjyr64UzXy1VMxE6vCqWTgdboL8NUSJPin6ZQO
	UiCpI+nWUrKP1BOjZvlx8GQaM2J+UEAM8vMqICskj8v0Lg843pgoaa4vnXtG7gtSnKazgQ4l+tC
	gQBOmYlWVUA4gfVpHMbwx8aGyNt4=
X-Google-Smtp-Source: AGHT+IEYvuYtvwBciN7RBO1996CaeS0ilOCn3sjf6md8ykfPv7xm0jCk2L9dVBduCLSsyCujMYpWmJ/hg7BuvCbO5qk=
X-Received: by 2002:a17:906:308d:b0:aa5:2573:e38c with SMTP id
 a640c23a62f3a-aa52573e658mr840628466b.16.1732514465650; Sun, 24 Nov 2024
 22:01:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111132149.1113736-1-chenhuacai@loongson.cn> <87o72lde9r.fsf@intel.com>
In-Reply-To: <87o72lde9r.fsf@intel.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 25 Nov 2024 14:00:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6-yB5d8gXEH9TPHuzx0BJT+g8OCUmwTfSTTtqxfmcHDA@mail.gmail.com>
Message-ID: <CAAhV-H6-yB5d8gXEH9TPHuzx0BJT+g8OCUmwTfSTTtqxfmcHDA@mail.gmail.com>
Subject: Re: [PATCH] drm: Remove redundant statement in drm_crtc_helper_set_mode()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 10:41=E2=80=AFPM Jani Nikula
<jani.nikula@linux.intel.com> wrote:
>
> On Mon, 11 Nov 2024, Huacai Chen <chenhuacai@loongson.cn> wrote:
> > Commit dbbfaf5f2641a ("drm: Remove bridge support from legacy helpers")
> > removes the drm_bridge_mode_fixup() call in drm_crtc_helper_set_mode(),
> > which makes the subsequent "encoder_funcs =3D encoder->helper_private" =
be
> > redundant, so remove it.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: dbbfaf5f2641a ("drm: Remove bridge support from legacy helpers")
>
> IMO not necessary because nothing's broken, it's just redundant.
Maintainer is free to keep or remove the Cc and Fixes tag. :)

Huacai

>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/gpu/drm/drm_crtc_helper.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_cr=
tc_helper.c
> > index 0955f1c385dd..39497493f74c 100644
> > --- a/drivers/gpu/drm/drm_crtc_helper.c
> > +++ b/drivers/gpu/drm/drm_crtc_helper.c
> > @@ -334,7 +334,6 @@ bool drm_crtc_helper_set_mode(struct drm_crtc *crtc=
,
> >               if (!encoder_funcs)
> >                       continue;
> >
> > -             encoder_funcs =3D encoder->helper_private;
> >               if (encoder_funcs->mode_fixup) {
> >                       if (!(ret =3D encoder_funcs->mode_fixup(encoder, =
mode,
> >                                                             adjusted_mo=
de))) {
>
> --
> Jani Nikula, Intel

