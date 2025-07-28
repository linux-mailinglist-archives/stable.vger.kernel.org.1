Return-Path: <stable+bounces-164995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39532B1414C
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 19:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7B91885C71
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC293274B53;
	Mon, 28 Jul 2025 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDWAH2PD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137ED1E5B60
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753724347; cv=none; b=fkPxahh54l4MZCQhtrYKnftQDxp2uPIBwrScu4Cv6hhVNo4p17AdeLh2i2UCClxxPNpxgK082E506adPi7/mHG3/yb1hJsgc0X4ENTrityQpW3oUkjX0cMxjT8cFmS9SBGqpwuThA3nm7nAU7SwD57Ao8wKpAg65mrf8l5nVPj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753724347; c=relaxed/simple;
	bh=cCUNj/4rZMJuJ8VI4f3trcSfb7jDfua8B2oe6DKOFhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chd3T4pGWd7gL9TKUW3Rw1bpXMQnf9Aokz4NlwrGEztD7VKYSfBMFPVPx2kEcmkxXAiACtl+HrKsi9gvhfBrV02em/XuzGu9P0vzhUI+3TxuNHBayMGi/ccttlgzrhVPWLwingzLMzlUK6/kCQXmjCjXNzEKPRG5zxoPz9cyD94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDWAH2PD; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b3f2f8469b7so386695a12.3
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753724345; x=1754329145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6d9zu/8MXKzz/y5bU6VHaWJ911scU517rl/C+r82DI=;
        b=SDWAH2PDg8k+avYbbysLFBiman8lin8Jg1C2opKdlg8UTLPu0b57xYLbgIvvrGKlB8
         5zpHkBfEKzgBRBmY/Io+bq/rinXZqCecU8KUO9Zhb9dy375XFmH9NSGlEhxjE/JGQXs8
         fn2549i+YSw8P26VTDIARtmUCPNsD5M/8WIB2nipabJS/LsvYhw0YFGcBlgZZDjTT2i8
         fADtDaJVmpdTSBmhbNBBx8ndAqZMSnnpK3q8+HQZLaZYTg+oUoOn36houj7WjpPd7+MK
         b5uyMbyS2IS+qtR38cA8ttFwxFv8IESdoW9VeXKNHQsdpHHTxKZ4wTFWBD2znV711yra
         jUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753724345; x=1754329145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6d9zu/8MXKzz/y5bU6VHaWJ911scU517rl/C+r82DI=;
        b=nXfJEtlROewgySKrDlobtOF01cjaJGOn6XeA2HsTWYNBLFLC5bH9gxBD5G49MBoSuo
         GYQrr6TRPAgQtXO3d+95m573atC/WTu1dCtCM4BbayoDVuBF45Iu5lmPQ+jggBui+6bE
         KLfDt/o7TI+nxu1RYZpo5gi89o2QDsVQjq3Av2ySFZBvD1wt9Poj1K0Fpl02XvyJD30Q
         rzlP5NPJ2sLH9RFgsvwLLAsqzZ1XcOcQI4T55eqNzt9dkOaIlmD04Iz3+urpdJcbYIHR
         5vikfnBrGH9gjyanxyt1bRR6/eF9K3Vj6TqDJ67sQZFq1eqpPEp558fxCEnFzIg52Xdr
         cUqA==
X-Forwarded-Encrypted: i=1; AJvYcCWAW9FZJTS2VZjMzSL7XHKMMjQrHBKenWM8wRmWKxfQf6XY6uaYLzJ3SOjsguyRO2MAt+wg9Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jtdJ6IScAUOYJbdJ7hmSHM0vhPXmyGTB9rA6zwk1SRoKnReH
	89PnMtbKCQrLqa5gG7hJIMjlOfVYa4iRqClFSLoVqzOOjaQ5LJWatUqzf/JGMjEm7m0EhDn7AiR
	coaAsZAxMzm6YKRWbP4c0J9TBT7/Nc+s=
X-Gm-Gg: ASbGnctVccWV0VKdiUelu34ZKvrKNkUWdMtTvoe8kovdOEb040OCWvnQrEx/KYfOs+t
	/DJGyrexT3pvYKJVcam/HfOLoiKyGLYgmMqSZOPpiogahtwUsNRXjhN+LlLIm9QrmR1qGwwBsD6
	ovb6PnDcVJsRRdEUvkZEoILP3DN8oeklQgiBCU5USb3W0bd6kxsxiahxmRu3u8h689gkbSionLM
	sSEYagY
X-Google-Smtp-Source: AGHT+IHHwyLnIh0OOspAb/Ne63WT7VVCdj7/GpZ+4C29aG/ZUicmzCMO21OUQ/TmkZGRxu0XC0Tp2AAmQRVPwroap0c=
X-Received: by 2002:a17:90b:3ece:b0:31f:3f3:4516 with SMTP id
 98e67ed59e1d1-31f03f34736mr1510637a91.2.1753724345268; Mon, 28 Jul 2025
 10:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721134350.4074047-1-superm1@kernel.org> <ead2f2f1-6627-4884-87f8-932f38d54803@amd.com>
In-Reply-To: <ead2f2f1-6627-4884-87f8-932f38d54803@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jul 2025 13:38:53 -0400
X-Gm-Features: Ac12FXyMTQix-9HOMhbljwQ3QOjUYNnGHI87C1rXwEG10kE7ir5R0BmNsD3Ry5Q
Message-ID: <CADnq5_PFp2Qey8JhY=gjgwEF4yWZwwa31XQF=-TQjQy_TWL5kw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value"
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 3:15=E2=80=AFPM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> On 7/21/25 8:43 AM, Mario Limonciello wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > This reverts commit 66abb996999de0d440a02583a6e70c2c24deab45.
> > This broke custom brightness curves but it wasn't obvious because
> > of other related changes. Custom brightness curves are always
> > from a 0-255 input signal. The correct fix was to fix the default
> > value which was done by [1].
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4412
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/amd-gfx/0f094c4b-d2a3-42cd-824c-dc2858a56=
18d@kernel.org/T/#m69f875a7e69aa22df3370b3e3a9e69f4a61fdaf2
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 8e1405e9025ba..f3e407f31de11 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -4740,16 +4740,16 @@ static int get_brightness_range(const struct am=
dgpu_dm_backlight_caps *caps,
> >       return 1;
> >   }
> >
> > -/* Rescale from [min..max] to [0..MAX_BACKLIGHT_LEVEL] */
> > +/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
> >   static inline u32 scale_input_to_fw(int min, int max, u64 input)
> >   {
> > -     return DIV_ROUND_CLOSEST_ULL(input * MAX_BACKLIGHT_LEVEL, max - m=
in);
> > +     return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - m=
in);
> >   }
> >
> > -/* Rescale from [0..MAX_BACKLIGHT_LEVEL] to [min..max] */
> > +/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
> >   static inline u32 scale_fw_to_input(int min, int max, u64 input)
> >   {
> > -     return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), MAX_BACKL=
IGHT_LEVEL);
> > +     return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MA=
X_BL_LEVEL);
> >   }
> >
> >   static void convert_custom_brightness(const struct amdgpu_dm_backligh=
t_caps *caps,
> > @@ -4977,7 +4977,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu=
_dm_connector *aconnector)
> >               drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc=
 %d\n", min, max,
> >                       caps->ac_level, caps->dc_level);
> >       } else
> > -             props.brightness =3D props.max_brightness =3D MAX_BACKLIG=
HT_LEVEL;
> > +             props.brightness =3D props.max_brightness =3D AMDGPU_MAX_=
BL_LEVEL;
>
> This bottom hunk doesn't need to revert, that one is fine.  The other
> two need to be reverted though to fix this issue.

With that fixed, the patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

