Return-Path: <stable+bounces-4930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4529808B4B
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 16:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8F71C20B39
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9644387;
	Thu,  7 Dec 2023 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt7JeVFL"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277E71AD
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 07:03:17 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1fb9c24a16aso648129fac.0
        for <stable@vger.kernel.org>; Thu, 07 Dec 2023 07:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701961395; x=1702566195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4844r4veaJcnOIn8zsWADMOmvCyMEshKHmGqdlPchjg=;
        b=bt7JeVFLrTCqjWtw6p33WL2LqYa82I3XpkjRzC4QyVyadKpzohbj77gMR9TxSGRsk4
         1OozxjYKA4m6+TrI/Ws1+tXdLqcx+Q2wCvw1hUC5otILRIR9lQkIqWaZdE/1X8AmBAPv
         XQR4oMmTd64XALTrqQAZLIcsPXHdRXjuyX+2XLDEvfvreuis+szCxdMRCb05tRDdyFyk
         zsPDaLExK0RCYolqfqdRV6ph64CYCuhGVBmGQhtGFL743/sxtJmBA+PHDdrvMmVKOus/
         4Svit2rVkX3XIr2kE8RGn4QRv418a0j9o3Ga0U2Ce6n8DtvqOietS78+o9/zJtvtzc5q
         Leug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701961395; x=1702566195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4844r4veaJcnOIn8zsWADMOmvCyMEshKHmGqdlPchjg=;
        b=cp6t+uLuRbriJObo6GxcjvCQ6V7MdKtT8kxu+alDySUj5LCVODa7tKo0V8j5Z6AjOk
         hClpUlGECuhJ1asK7gBU8mHRBDaAM8wIWSZT68f4SdTv2RkFCxxZ/Qfr8Z7xzVXUO3w3
         EWpX6mg30CxZNCFRn5hGWK/sE7kgbhJ7ZECaLKk0N5voBIyy5c4U2wy1E6bYQTp+HOI5
         wJ+LBHMbP7MEKP0/SjOPA8A7e921GVXTkl43FfuHaVnfRamtb2ZDVSM4jkdu6VxTSbPG
         4vFvGvk+VzLbFyEJrr8Fr9yvbc/1OrE4O8B321b+nkzGX0WL2yZLxAeQ5lgpzhKX25ZM
         ogOA==
X-Gm-Message-State: AOJu0YxMbZX1MxS3683qP2S30mGESwMtB4s6m2utHIljKoJfVAKeyeY6
	61jU6/BoYNTFWIm5b5GwhWE1+wPCl2jlMwwcrSw=
X-Google-Smtp-Source: AGHT+IEMtNEXHXyOg3iJvoZKGDtk16r9BmEbBVhKv9Wwmz8+COGpOQziYzxYQ43oGD20miRWyM0yxcPVtMOkKMm53ww=
X-Received: by 2002:a05:6870:1e8e:b0:1fb:14cb:c911 with SMTP id
 pb14-20020a0568701e8e00b001fb14cbc911mr3261929oab.5.1701961395273; Thu, 07
 Dec 2023 07:03:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206180826.13446-1-mario.limonciello@amd.com>
In-Reply-To: <20231206180826.13446-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Dec 2023 10:03:04 -0500
Message-ID: <CADnq5_OrnkGPudqTtBOGm1doaWyaHfYBQaA_sJOGTw1zP4PCyA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Restore guard against default backlight
 value < 1 nit
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Krunoslav Kovac <krunoslav.kovac@amd.com>, 
	stable@vger.kernel.org, Hamza Mahfooz <hamza.mahfooz@amd.com>, 
	Mark Herbert <mark.herbert42@gmail.com>, Camille Cho <camille.cho@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 9:47=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Mark reports that brightness is not restored after Xorg dpms screen blank=
.
>
> This behavior was introduced by commit d9e865826c20 ("drm/amd/display:
> Simplify brightness initialization") which dropped the cached backlight
> value in display code, but also removed code for when the default value
> read back was less than 1 nit.
>
> Restore this code so that the backlight brightness is restored to the
> correct default value in this circumstance.
>
> Reported-by: Mark Herbert <mark.herbert42@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3031
> Cc: stable@vger.kernel.org
> Cc: Camille Cho <camille.cho@amd.com>
> Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Fixes: d9e865826c20 ("drm/amd/display: Simplify brightness initialization=
")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel=
_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_c=
ontrol.c
> index ac0fa88b52a0..bf53a86ea817 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_contro=
l.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_contro=
l.c
> @@ -287,8 +287,8 @@ bool set_default_brightness_aux(struct dc_link *link)
>         if (link && link->dpcd_sink_ext_caps.bits.oled =3D=3D 1) {
>                 if (!read_default_bl_aux(link, &default_backlight))
>                         default_backlight =3D 150000;
> -               // if > 5000, it might be wrong readback
> -               if (default_backlight > 5000000)
> +               // if < 1 nits or > 5000, it might be wrong readback
> +               if (default_backlight < 1000 || default_backlight > 50000=
00)
>                         default_backlight =3D 150000;
>
>                 return edp_set_backlight_level_nits(link, true,
> --
> 2.34.1
>

