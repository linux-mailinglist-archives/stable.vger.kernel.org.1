Return-Path: <stable+bounces-197632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7518AC93544
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 01:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E5784E1715
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 00:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B977A13A86C;
	Sat, 29 Nov 2025 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExnXopyy"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B01A294
	for <stable@vger.kernel.org>; Sat, 29 Nov 2025 00:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764376435; cv=none; b=FqehA1j2Y2iUraLZA2plOt5VNTj/rEvgnQUvWA6zbV1DYXX41Zk/fHNUQhaSRa41bDpMAgfS+RQAMLO23t97qpUBap2JTD1N8TNvSxaxAISe2Mnx5iIj5EEd9FfLk3e5FPnCRHmJuyV9ubfFQs6ocajkZIkxD1earpnPu0Vt0f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764376435; c=relaxed/simple;
	bh=VKdxlUAsyvsPQk9PY7VuGHunlZNU1UWeC+1uz3cBUjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkBJtsB9VhnGL8GBPzDrCuIh7xZ2+/Tj9gSnhg9VA0Z5kQq1dmnILab6MvN40gi/oLyduz6PyhOdqUYdIINb5Q/NtWxzXmGE8ihpz0lBpR2VwrTjJoJl/ZP+BCxbo8SJFu0NC8b2vF2PyVCz1uvH5VGNMbSq3X+qJ13JzmtCirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExnXopyy; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3ebd1b07919so621042fac.0
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764376433; x=1764981233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSodSdGuLyjVvvJKsb3tcunBDQa4PvWngu2+L5YfjgQ=;
        b=ExnXopyyEnPVMGqD11E/Mpc8WNjppt7G+9k7jXfACVG69b5TD8VCESuVydDzbgkYLt
         damCNt5LdZloZu6kDq90nrkMIkYkkHN70qXi0apPtBjuuyY6uHCPc/2GXtNI65DdC1HI
         VaTOpy4rhsTrARGLaTHA+zOSbL5OhFwIWx9OBDa6RF8MKs9/HV13R9MJblwfxPXHW8Hc
         RBavw5aBizEhbcwfDRabHJmz3c/+qlwweLm2kU/0KjWkh0yrWxt0LPc7oVmAOJbdHRvo
         sFWQ/05NKtS7uoo4jpB2FToVLIHknT+lTyd2uhEnULuOaczE8kKNDRayfNGpPER1dVN3
         7Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764376433; x=1764981233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nSodSdGuLyjVvvJKsb3tcunBDQa4PvWngu2+L5YfjgQ=;
        b=RhCPuX0gB5rWC6UelYCiiA7ZCS0IgeMHtd9V1zSM9FtEdzDcTN+7ycWoC9dcwwCGxX
         VxX52sh1OKMPBrQlXWxM24uqmrBANXH426UNboEmLpBl85yD8abvYxDXzanJ1/pt9Pd/
         KUASZuvetSbj6ZgggeBo6aiq720XoT87YrtNYjR/d4pVsj0j4dcKgbCyRf29ZTSVQdob
         +HP5qcx/wSgkPOuxUyxJLvXvas5EjMefZUyx+eQPKLvmXYNi5f79BN1JRhT/goDnyIbK
         AU5qK3Zi8EBvQOIx8dpII1BJJ+MdIycXICpKcYAPg72MfgjTm6fyktv9KkgpAjCRTSas
         2Z1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXl/ENXQO0vcHx8VCVe+Lb2eQH63Zxoj2ORFH+98sK1cCm/e8sISbvtk8TcxE+SAwSPw+xVEi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaEimuhEQB7bJCUvLb2oLlZIwmg6iur1dkzt88T5NKVHM3PbVw
	1hCnCVvIpSuwcGf1n3tJOzzMleAS/LH70xsPgEA6MU8zgNVLw4dfuLgf+Prv/JCLbi74u68kGkN
	ewKOwbwj4aMdaPH2yHtnvWzaX6+fe24g=
X-Gm-Gg: ASbGnctUNawtnujTcBCzDQ3g9WbUeev2CcLRzsvOrDiRBg0tItsPiDZYlYH6miZwuxN
	jBB80iYFkQZ4o9SBiEX3AxaZJsIRt3Mjd3mXAzNl6vGOuGGYTUeRj9rhU6HNxjJIwPf4JlB+ski
	UrnZj6obukZOIAtB27wVEEedi9UjzdC1DlieajAAK42YI2vE4oR9kPV4ReN263npy7U72cqjTn2
	CnMecpS8oRQdD6vJUm0bfU5VAWsZzWpzT9eVYoiXQNNkFNyBFMHfslgF/neNX3o6oKr57G5XgRl
	Ru1yvkztX24r0bt5zeNNk37YR0I0oVfIiRl/GJM0bA5tYHHfHyN/3jnKPi50uAE=
X-Google-Smtp-Source: AGHT+IFACtgBv+6uHhheSDKubU4VYHCtgP3Xuj1qP8ZDmp1b9dvi/byMpRMtNtrY0Z+LY9fNuFS/3oMvtvivn7gkrHU=
X-Received: by 2002:a05:6808:6d84:b0:450:c602:751d with SMTP id
 5614622812f47-451159812cemr11298062b6e.21.1764376432826; Fri, 28 Nov 2025
 16:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128123816.3670-1-hanguidong02@gmail.com> <20251128193720.0716cc6d@pumpkin>
In-Reply-To: <20251128193720.0716cc6d@pumpkin>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Sat, 29 Nov 2025 08:33:42 +0800
X-Gm-Features: AWmQ_blGVxQEYLfo81--i3d5hQiWFB3fivl4NVPZkaWT8G3DSfXorv9rJHbePV4
Message-ID: <CALbr=LbYY-_-Uc_45fXDYzOMiYTJpwbNpuj41q2nHmdfangcBQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (w83l786ng) Convert macros to functions to avoid TOCTOU
To: david laight <david.laight@runbox.com>
Cc: linux@roeck-us.net, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 3:37=E2=80=AFAM david laight <david.laight@runbox.c=
om> wrote:
>
> On Fri, 28 Nov 2025 20:38:16 +0800
> Gui-Dong Han <hanguidong02@gmail.com> wrote:
>
> > The macros FAN_FROM_REG and TEMP_FROM_REG evaluate their arguments
> > multiple times. When used in lockless contexts involving shared driver
> > data, this causes Time-of-Check to Time-of-Use (TOCTOU) race
> > conditions.
> >
> > Convert the macros to static functions. This guarantees that arguments
> > are evaluated only once (pass-by-value), preventing the race
> > conditions.
> >
> > Adhere to the principle of minimal changes by only converting macros
> > that evaluate arguments multiple times and are used in lockless
> > contexts.
> >
> > Link: https://lore.kernel.org/all/CALbr=3DLYJ_ehtp53HXEVkSpYoub+XYSTU8R=
g=3Do1xxMJ8=3D5z8B-g@mail.gmail.com/
> > Fixes: 85f03bccd6e0 ("hwmon: Add support for Winbond W83L786NG/NR")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> > ---
> > Based on the discussion in the link, I will submit a series of patches =
to
> > address TOCTOU issues in the hwmon subsystem by converting macros to
> > functions or adjusting locking where appropriate.
> > ---
> >  drivers/hwmon/w83l786ng.c | 26 ++++++++++++++++++--------
> >  1 file changed, 18 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
> > index 9b81bd406e05..1d9109ca1585 100644
> > --- a/drivers/hwmon/w83l786ng.c
> > +++ b/drivers/hwmon/w83l786ng.c
> > @@ -76,15 +76,25 @@ FAN_TO_REG(long rpm, int div)
> >       return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254)=
;
> >  }
> >
> > -#define FAN_FROM_REG(val, div)       ((val) =3D=3D 0   ? -1 : \
> > -                             ((val) =3D=3D 255 ? 0 : \
> > -                             1350000 / ((val) * (div))))
> > +static int fan_from_reg(int val, int div)
> > +{
> > +     if (val =3D=3D 0)
> > +             return -1;
> > +     if (val =3D=3D 255)
> > +             return 0;
> > +     return 1350000 / (val * div);
> > +}
> >
> >  /* for temp */
> >  #define TEMP_TO_REG(val)     (clamp_val(((val) < 0 ? (val) + 0x100 * 1=
000 \
> >                                                     : (val)) / 1000, 0,=
 0xff))
>
> Can you change TEMP_TO_REG() as well.
> And just use plain clamp() while you are at it.
> Both these temperature conversion functions have to work with negative te=
mperatures.
> But the signed-ness gets passed through from the parameter - which may no=
t be right.
> IIRC some come from FIELD_GET() and will be 'unsigned long' unless cast s=
omewhere.
> The function parameter 'corrects' the type to a signed one.
>
> So you are fixing potential bugs as well.

Hi David,

Thanks for your feedback on TEMP_TO_REG and the detailed explanation
regarding macro risks.

Guenter has already applied this patch. Since the primary scope here
was strictly addressing TOCTOU race conditions (and TEMP_TO_REG is not
used in lockless contexts), it wasn't included.

However, I appreciate your point regarding type safety. I will look
into addressing that in a future separate patch.

Best regards,
Gui-Dong Han

