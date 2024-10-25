Return-Path: <stable+bounces-88172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506409B0624
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 16:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6989B1F22C0C
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74715C14B;
	Fri, 25 Oct 2024 14:47:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483E114B06C;
	Fri, 25 Oct 2024 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867664; cv=none; b=KTrVeJbtA4yB1cn29QOnFOTjYNzIvxJZg8Dd2qPuUx877aCLC20WFg8VdbtcL8klMPg9jDZd0ApfbyBxYrWUGQuCGeu7PPyUdXFF0x8Tq0lyLLTs7A2JlgBNczrvq0vUvvkWPO7UH9wTLcOhkUBgUIKxueozUp2qAIlfpbTF2J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867664; c=relaxed/simple;
	bh=rv0sKfSP/YRFHSgY5CLAidWvnvn2HJW92USZDnpqTOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGsAlRluDk+boDtmpZMYFx8ivfRcPG6oXjFB7uZ9KsJqJGbCsCVNF3INvpRRSAu4QPzT3MP5R6OuCFJm7qR9VxC4HctIVISqCtI1H0yoLzbA+qFZT0kXQBKi9iBQrF1sHkTmGvlW80+8HjBq/UoUbGjyONbxWplGU0HouKYsrzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so3000597e87.0;
        Fri, 25 Oct 2024 07:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867658; x=1730472458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMcatHSssIzBAMp8NeTODM9A2XszLfMDJPzpLz8VH0Y=;
        b=XAQNnJf2FT6yyecpFQZgdLRKQKmAfFnRnHpAChEgJjfhZPHZUO+MmgQHShGvQLH6nO
         apSpgrnOlp6UTfDiAeIUqCgumvqkM78xLUICrHHiOLXciXCpjLi7R0vn2ELkun9IHoyx
         sc0VH6eLzYGF/fgsc8vhYYjH9lbpQg+XhV3DYYGpX6CLRbkIer9ybujppB742NBw6RBQ
         Ztl1TW7Ofnfb9/As2vOzsds1HQ86jfMEJEJIiH9AzwrGzYTWAgENqp7iLEtUMYS4Bm/D
         +ojPOz/D9eC4Z3CaqwVEftO6mQjbqsIhiwWynUByMgSuQ7nlprn/vktufOqJuVHsZHme
         tQaw==
X-Forwarded-Encrypted: i=1; AJvYcCU6bE1AcJZWe8kRFxqtzTVosIiC3oeRzO3dvTzuQE1kB9fQHQjO9XldW6q5ueqszXaep6cnaLzn@vger.kernel.org, AJvYcCV+/FQPgJiyzJ6IYUeLf+YjykUSilbXkBRVlyBts5d0qOYlSOsVyimkrF7oh2+6KEeZCYi6pcFh8FBl@vger.kernel.org, AJvYcCXCw/n3t15LtgBHfCTfJGLErE9Iqnz2fnUQF2320icRabnlMD9WBd/jhS2F5JHF2FVarhoP9TMka1RlZ2Lu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpr8BxKIUDNw5BeU+t4sDxfUF3zLb2IRnT6QGFq7gVbaAV+bMG
	FYohmkKeoqsWdAOqiAwvSQ1ghLBB9G/H1itii6c/PTHKukxGi0b41z1fWtsjgrc=
X-Google-Smtp-Source: AGHT+IFmhOlxR90aLf2Xo8igwN5JHY4LiKlaWjEC24/LJ83VLWYfZ8dFmJdVVPR4to8JEz07CrTcZw==
X-Received: by 2002:a05:6512:3d1f:b0:539:fed8:321 with SMTP id 2adb3069b0e04-53b23e8acd1mr3475085e87.51.1729867657990;
        Fri, 25 Oct 2024 07:47:37 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1dfa9fsm205494e87.254.2024.10.25.07.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 07:47:37 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb6110c8faso20839251fa.1;
        Fri, 25 Oct 2024 07:47:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/pcKBMx+eqZIJBXJzoxs9G4/QAPGKmMEY43xcm5YEnepvnOiYVSSeg6T6kcupNyWWMOzQvrqz@vger.kernel.org, AJvYcCUIoMmbBJqSboNgzylju1gkwAEFg2HFUvkYSGPbwA0bLe2N7+WHGEvURVy0ToWLm4Ebt+B1FuVkgkuR@vger.kernel.org, AJvYcCUkYYhW6JGm72Mz63dOSL410XdY9Y447EOrBeD26x6VgQXKm8AADx32pDpsInwxuc2fMiRJR3mCpcAQrCiL@vger.kernel.org
X-Received: by 2002:a05:651c:50b:b0:2fa:dc24:a346 with SMTP id
 38308e7fff4ca-2fca82143ecmr39122861fa.21.1729867657676; Fri, 25 Oct 2024
 07:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <129f0c754d071cca1db5d207d9d4a7bd9831dff7.1726773282.git.dsimic@manjaro.org>
 <bef0570137358c6c4a55f59e7a4977c4@manjaro.org>
In-Reply-To: <bef0570137358c6c4a55f59e7a4977c4@manjaro.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 25 Oct 2024 22:47:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v66aody60h=Bpk49pxogq93FekmO48uThPET2RKxvx=OGw@mail.gmail.com>
Message-ID: <CAGb2v66aody60h=Bpk49pxogq93FekmO48uThPET2RKxvx=OGw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: pinephone: Add mount matrix to accelerometer
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-sunxi@lists.linux.dev, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ondrej Jirman <megi@xff.cz>, Andrey Skvortsov <andrej.skvortzov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 5:11=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello,
>
> On 2024-09-19 21:15, Dragan Simic wrote:
> > The way InvenSense MPU-6050 accelerometer is mounted on the user-facing
> > side
> > of the Pine64 PinePhone mainboard, which makes it rotated 90 degrees
> > counter-
> > clockwise, [1] requires the accelerometer's x- and y-axis to be
> > swapped, and
> > the direction of the accelerometer's y-axis to be inverted.
> >
> > Rectify this by adding a mount-matrix to the accelerometer definition
> > in the
> > Pine64 PinePhone dtsi file.
> >
> > [1]
> > https://files.pine64.org/doc/PinePhone/PinePhone%20mainboard%20bottom%2=
0placement%20v1.1%2020191031.pdf
> >
> > Fixes: 91f480d40942 ("arm64: dts: allwinner: Add initial support for
> > Pine64 PinePhone")
> > Cc: stable@vger.kernel.org
> > Helped-by: Ondrej Jirman <megi@xff.cz>
> > Helped-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>
> Just a brief reminder about this patch...  Please, let me know if some
> further work is needed for it to become accepted.

Thanks.

There's no "Helped-by" tag, and checkpatch would complain. The closest
would be either Suggested-by or Co-developed-by, but with the latter
you would also need their Signed-off-by.

I can change it to Suggested-by if that's OK with you.


ChenYu

> > ---
> >
> > Notes:
> >     See also the linux-sunxi thread [2] that has led to this patch,
> > which
> >     provides a rather detailed analysis with additional details and
> > pictures.
> >     This patch effectively replaces the patch submitted in that thread.
> >
> >     [2]
> > https://lore.kernel.org/linux-sunxi/20240916204521.2033218-1-andrej.skv=
ortzov@gmail.com/T/#u
> >
> >  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > index 6eab61a12cd8..b844759f52c0 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > @@ -212,6 +212,9 @@ accelerometer@68 {
> >               interrupts =3D <7 5 IRQ_TYPE_EDGE_RISING>; /* PH5 */
> >               vdd-supply =3D <&reg_dldo1>;
> >               vddio-supply =3D <&reg_dldo1>;
> > +             mount-matrix =3D "0", "1", "0",
> > +                            "-1", "0", "0",
> > +                            "0", "0", "1";
> >       };
> >  };
>

