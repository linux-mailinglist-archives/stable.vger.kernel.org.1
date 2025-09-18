Return-Path: <stable+bounces-180526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC42B84C07
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 15:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464183BDE62
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEC8308F0D;
	Thu, 18 Sep 2025 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDvHmuzm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5EB225390
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201144; cv=none; b=uQYDHIwJiNoIGQ8uZGbzwwebj2mzffAAM3rKpT2aGUuGgsrwMfzt5J0dJ+l14F1ieXnYhyCngDPDvHSntr3rvFGak4O5NGBY04SNVViVDE+k0h5P4KI3XOBRvuUaKXK9+G27l+4Ol1Z/oSPtgzbv2WBEWU0E0P3k2r/WfabK3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201144; c=relaxed/simple;
	bh=ZLxT69O2gSyWg52xQm3YXSUFli9jeiD60m+YcwAVNlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTMcPfqta5vqNkqji2ucKsrhz+07UOq+rT+7F24rV7TCAOmc3I7s9P3a573omKHB4OvkdM6+RsJsqU8nbVlPLTWk7uW1GRvUKtGOjx8SBTtJeCRN5r3AbB2OfXYM8XlGw1fFnjupBiltIWnUENiwdPVgKTZTTQWfWISnjbLkVao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDvHmuzm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-267fad019d4so1880795ad.3
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758201142; x=1758805942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow/FekpgA7UhV9Mvh36laSeW60WQ/h2Ti7HkmGFnCsM=;
        b=dDvHmuzmmePHl+XNe66WuGEMLQDlzES7k6uW/6JNVhqpEkzaoTKkgURwMFO+dCtPDF
         EtLnD8UkvHm83MY3LsD/KhpPcfhf2Z3GPqqwYsXiNfZzwzQEssDavn6+1dQyE58McNDG
         jLRJ4HU/okKdgR6OuMEI+vWsA5Q1i9cusUoxe+PEZuZvp+N2vERX9EN9QQOg2kijzryk
         x3rdPY+ZP82ApEnPIqfwUwcEhrCJfvsPDoiBpe/gY+LvZRjrfNJwcafH/2YeRl/PmHbG
         jOZkChvC4Yik5rT/jFrDFtG3DRWQAMNTQvn9sfqFa6aUUribzMJxu6K07sBAg1T8j73b
         YXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758201142; x=1758805942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ow/FekpgA7UhV9Mvh36laSeW60WQ/h2Ti7HkmGFnCsM=;
        b=aq1Qm9FSLof6lkV+VnUpHd8bsIJdCED+4JV8TCSAU4pJ/dDRwtafLCLRL+eSCaFc+P
         tCltxSGaSmW4TYjyOYWcWf1Cv6LIwedesOc9LvLSYB5Zde8AoCrX0oKIPYaJSSyKfXA/
         sNyoBIfD73/WE4+T3ZrF3H7TAvCkeiOlLUIcpOrdKBRYdzRO/CNOdjPmyV3pQjti3kU6
         9rKfzOA6LwkiuK4hg8a1hwWL1D+2UA65FBGt9heJBcaUW1c2FzMcLkXERflWpk3EZ6SA
         GI3me8XIdxw1HgRKWXutVq6Al5pcqg1I2zN0qk8tNeqpg/ArVI40Fq2fLnLCXIGSDdyw
         m1pg==
X-Forwarded-Encrypted: i=1; AJvYcCUHVth7/qkRFU9NCfHwUvE9zflI//LQ7v1Vi8jFY29CcSm/+s/4AZlJCg+j2rvjdB7xbaVvpbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjyqNM+6Tb5gAA+Am8H3cEVCXOn+XtOSuZicRMsCdgi7SA9jwj
	4xLlljglBq/ey79zVsCcYQzz7GAleYn3LQzo6mWiK9r3S5b1n5A3zgnKoYA9wTJwhZFAGgVOa5k
	NSZef/QVg7XZHVPObRkVnKmHNYxnfn5k=
X-Gm-Gg: ASbGncu8/6M5BBm28NPE8BaLherwyIIE7VTDGSewzgG+Evx7MF5c96pzG3+X+wbsr0b
	AVIAdMTwRLsDJZCXPO7K9315UHUq/8i0fFzJScqJ53BQV3eV5+jw1Y6sSEPJwY1x+QWxONF/evL
	KNPuSkrNDWmWao2gsSgBhTJJCfI9evFjqHQR/VqgI0igWRmHObCNWkymN0nG2LCFAARN8FHERMj
	GQ3zbKp3/HISLSIIrvPy+4KQNY=
X-Google-Smtp-Source: AGHT+IGPGpvPJnDMA+MU6VEF8DQ0xnGm1dy+iqzuJdF1p3969ZuqYgSVs9i3T569keWH/YmK9RWABocwx0S6kTCDWjQ=
X-Received: by 2002:a17:902:ce81:b0:269:9ae5:26cf with SMTP id
 d9443c01a7336-2699ae52d42mr9215285ad.4.1758201142273; Thu, 18 Sep 2025
 06:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918105705.3480495-1-lgs201920130244@gmail.com>
In-Reply-To: <20250918105705.3480495-1-lgs201920130244@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 09:12:10 -0400
X-Gm-Features: AS18NWBryzMXeisWyksAUCkLKladPwFh28QPE6dGbAFuIaGpcNhnEsksRdkuC1w
Message-ID: <CADnq5_NQMQNpa7=MW4LXHvnKWTc4+QSEoA0zsNqpdfEV5Ho0SA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/atom: Check kcalloc() for WS buffer in amdgpu_atom_execute_table_locked()
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Al Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <kees@kernel.org>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 8:44=E2=80=AFAM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> kcalloc() may fail. When WS is non-zero and allocation fails, ectx.ws
> remains NULL while ectx.ws_size is set, leading to a potential NULL
> pointer dereference in atom_get_src_int() when accessing WS entries.
>
> Return -ENOMEM on allocation failure to avoid the NULL dereference.
>
> Fixes: 6396bb221514 ("treewide: kzalloc() -> kcalloc()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/atom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 82a02f831951..bed3083f317b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1247,9 +1247,9 @@ static int amdgpu_atom_execute_table_locked(struct =
atom_context *ctx, int index,
>         if (ws) {
>                 ectx.ws =3D kcalloc(4, ws, GFP_KERNEL);
>                 if (!ectx.ws) {
> -               ret =3D -ENOMEM;
> -               goto free;
> -        }
> +                       ret =3D -ENOMEM;
> +                       goto free;
> +               }

What branch is this patch against?  This doesn't apply as is.  I've
fixed this up manually and applied it.

Thanks,

Alex

>                 ectx.ws_size =3D ws;
>         } else {
>                 ectx.ws =3D NULL;
> --
> 2.43.0
>

