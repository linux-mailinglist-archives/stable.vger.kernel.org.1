Return-Path: <stable+bounces-121248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58AEA54E0E
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250261886F22
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 14:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DA5148FED;
	Thu,  6 Mar 2025 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dphn1F12"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3134416D9AA;
	Thu,  6 Mar 2025 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272241; cv=none; b=Y+4gdUoESlKA/bWXPdiyI9DHnjIA93p6iro2OWtFLR1+LLJ5mUUGo5j3qwJxbciLUN8u0PtRhpkNn0gkqM1ASFKKhqiNEjCCOnzCjhh09L4AkIvVAREA+z5BIYfgtAKphdZCU4iUKJCAIVU9M/DjLbZP/oqZkY3fanaUC8CUbKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272241; c=relaxed/simple;
	bh=IR3HH+r42dNdY13mNau/VyBksWUEJ8Ly+NgzGLbTLfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMaDzJqa0tTSeEi3R5r2axAO1qUk3yVe5rWiRFTzCnJCqP/1MGBLG9JN3XwRGBvr9Cgjgbiqny4O4hDcxwtb3TzMSnNenT0wtJYumB/m75YUhUZ/E8eTAxUcY4ISenDAeZpISNN28UlzBNySnjjjI8PG/6ekafYBnUcnrsd9Nmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dphn1F12; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso182716a91.2;
        Thu, 06 Mar 2025 06:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741272239; x=1741877039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOuXqHLwhoywZeeVkpq77OS6iNRsJcoQHW5JDpHphP4=;
        b=dphn1F12Ja2v3ambfPgjyBs/4NGjXbJLNPCiZnCHY4HRAo4iviDV9sMIyNehzp2LLE
         Db2hC3q3J3lfSaJCTF494dt47L4/ZKcK+6an9qjMNC566iA2C5hfUDX5mlw4HWrB6v0+
         +NmSXhY25VkBz153ajwKRkcVK0ffzzArb6878xBmFoO4TIaiwu8gVbHRv51oNUiTUJ/t
         2oFYRNAPvE130JRq6LIweJOsJYd6YYcoqB/rhLKeA1VARmYO6f8DP06nPwPtWJVNp0iM
         62mVxiLaH7NEZmdYXqc0hbjmVD7JJDs3B1pzd/P/DLpKUhCvLae+14FjlrBjw7CY6j/x
         yZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741272239; x=1741877039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOuXqHLwhoywZeeVkpq77OS6iNRsJcoQHW5JDpHphP4=;
        b=IsZ/NY+ToLWesCuNbWDjAj4uUMQqwXCB6xWhZ1y55lPAqVYu5axd3ZL/AOal8f9fIt
         S3lbc4qtOKpW0XDFF6OhH+JSzTtwUMapTORdwYQjCHBwEZPcjK6LR0oeOjw4iq00Mtjn
         MyxrEcHWLhDmZY6kT0vNmmMcXccpSGTTQrrBSRk4NPyO4RTIXzCxSjCWWJ7N25IzawXW
         hH+tj/He06eUmGCVj5T0gUUicBWkDXbl4V905EppcT0ObGFVX9bIrn3z8LfmgvCDWpP3
         lK0L1F6alWeBGMgoDxa0jUAVP852XBzn3atGGSjupPiIHIwTrYuoJDdbblG/PBF5tPah
         Pkaw==
X-Forwarded-Encrypted: i=1; AJvYcCUwVCjw47FUAVPbwuxka6gwlhuLiOmh8oIvn5xNsRd7/cBvPn2lIuMfeA1Qy70Fk1BuIzOIsPgRkJ6q7Rg=@vger.kernel.org, AJvYcCVO/v4G1KY87b8YXiWx6BD79IVuC/oM6j5CvqblpmVn+VPMJIob2W6H+Bf77dyGBf0CWW7LrCTx@vger.kernel.org
X-Gm-Message-State: AOJu0YxYTL2465zX0xF2XMT8WB1rVjw+AitUlOsiaFWWKx3sDV74lRw6
	9dkeAS9JBktm6zxQAAfUBp7VzAVfm4It8Xgdu/xlveUtoHadDvCbU6euke8o26Xn1Mwmo/lmP7J
	jR7rH6QZq7Y1ZCOKJYWEWdBzYZcU=
X-Gm-Gg: ASbGncsUQ27n6+Cx8LH1+ho+Obu7qEsbLbSkJaF64N+YWoIMZ2oqKNpTRKyr80kr3Mm
	FcY47mjz9FLW2ED2XaFTqXBXSNsN9v1OqPAbNU5whGd3ipSDlLOY2ARiZC1uHAy0yHugQjaZo1t
	V1aJNY0avN4wtYw8YrFfVqk4u/Cg==
X-Google-Smtp-Source: AGHT+IFIMuqvtdQeTvKmw8diwqa5n4LJl9yYalj1aquXZaD0QcmpHfmxn43WeV147qVRmmThhKGTyHR49xtqlcPEJkw=
X-Received: by 2002:a17:90b:1e03:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-2ff497711c1mr4724924a91.2.1741272239200; Thu, 06 Mar 2025
 06:43:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306103603.23350-1-aliaksei.urbanski@gmail.com>
In-Reply-To: <20250306103603.23350-1-aliaksei.urbanski@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Mar 2025 09:43:47 -0500
X-Gm-Features: AQ5f1JoJiql6AXqg8vp_CW1j7N3EvB_WcR1RWX0ZljQ1MNDzXH3Rf9oQxe6OSHc
Message-ID: <CADnq5_PaxnYBeTVaidOVJzqnj_HfQH-xwYwUmf3BVeZOaQeT6g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix missing .is_two_pixels_per_container
To: Aliaksei Urbanski <aliaksei.urbanski@gmail.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rosen Penev <rosenp@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Thu, Mar 6, 2025 at 9:13=E2=80=AFAM Aliaksei Urbanski
<aliaksei.urbanski@gmail.com> wrote:
>
> Starting from 6.11, AMDGPU driver, while being loaded with amdgpu.dc=3D1,
> due to lack of .is_two_pixels_per_container function in dce60_tg_funcs,
> causes a NULL pointer dereference on PCs with old GPUs, such as R9 280X.
>
> So this fix adds missing .is_two_pixels_per_container to dce60_tg_funcs.
>
> Reported-by: Rosen Penev <rosenp@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3942
> Fixes: e6a901a00822 ("drm/amd/display: use even ODM slice width for two p=
ixels per container")
> Cc: <stable@vger.kernel.org> # 6.11+
> Signed-off-by: Aliaksei Urbanski <aliaksei.urbanski@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.=
c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
> index e5fb0e8333..e691a1cf33 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
> @@ -239,6 +239,7 @@ static const struct timing_generator_funcs dce60_tg_f=
uncs =3D {
>                                 dce60_timing_generator_enable_advanced_re=
quest,
>                 .configure_crc =3D dce60_configure_crc,
>                 .get_crc =3D dce110_get_crc,
> +               .is_two_pixels_per_container =3D dce110_is_two_pixels_per=
_container,
>  };
>
>  void dce60_timing_generator_construct(
> --
> 2.48.1
>

