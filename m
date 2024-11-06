Return-Path: <stable+bounces-90047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C8C9BDCF0
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF7AB235C1
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1D9192580;
	Wed,  6 Nov 2024 02:20:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA0A18FC8C;
	Wed,  6 Nov 2024 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859612; cv=none; b=K7vUDXvJTCL/ZLe9ItLXJ8rExd7Et4p4x6GkoRBpFJAVXVu5ip/ibnOybM0ARHV1C/45u8yvNGT63d8pdVMqeZdF8cNAR7q4BoYY5Zr2mtoqhytOYvzmk8d3O0ouoe8J0En3N/ZXyphSIl+PEbwd6cbZEpz4wW/ziciCTomwkYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859612; c=relaxed/simple;
	bh=hciusCmQ46W/T2AcAGCqFbobcRKG3w7tjodOgj0wnp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PShdT2At9FJhRKWhOxuE8JOHAQYfV6q/PKgck64VGZOA9y6/iHvgwoZ7KzKR23VPfmrkGrmVGCPHJvUmPSAe/rfq3YBfdzu9boldf87HYVt17PaTDUsnNTxRb/aVCg62BUxmLUnenPo0lUTUBeDGVGmvXzo/ubOXn565qRJJpt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb49510250so62513251fa.0;
        Tue, 05 Nov 2024 18:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730859608; x=1731464408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w8a8+IO/gHzs/8HUWMdym7QT6xBD7UjDO0WtfEtRhaE=;
        b=N+Wez+5eJtW/41vGQw89hU8JJ6KsD6qAB42JMqTHfOvx1QeGiYQ9jBw4TfIklkYvKu
         Nu9xbm1+GfTiS8rfHZlX9UQbn07ri6n0Oc42c0PYAfFF6DopovUN+KnHlluNBlprSjHL
         AEHeUQ/mxT0EA4gq6VWuUmnRl20bmLArEdqFmu844vipyPJk+1hG0R9nGVyfbSL2DhxK
         iIWCpQ2jMxOQrZBgPsEygBEikFNt3QbmwtGSNxeOClBufS4vgoepHiVhmTxQ36bVwjo8
         mKLpebTxucn+YPuwnfKdhK3UwWHUwy3uZc5H33BHNVaEO6skirWkdtfVkjdSOEH57Yxa
         5i9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPsDx7Q5OAcX/WGrpCJsxrg6HJnBW0Hzrq+nKBkBNmKV2ysfhwjjNsb4zK4DlXQNkxZtJaA9O/8FP4@vger.kernel.org, AJvYcCVQnU+5cwr49wi4kuP5NewIRQKnkNMAe1OrplPoVwXchs7ox8ZIms7QpDIKS07n/PzDaJlEKPmG@vger.kernel.org, AJvYcCX1RBcvORRplmThEuBqiBO7WxRZhNE3njw7IK1sK+4uDW8hcLn1LS7Gc8E6i0wPaIvo3aIJqiLEsEHc3C1g@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9RWwjy8K6oHLC4XyXuiR7DHOYdc3eyijnw42SibSYz3E9Vd2n
	gOjgTlY+G0Mx/9QlVzbZMdPGy1wntypr1P/178kTl5Tzb4NPm98e7EBoFn0Q
X-Google-Smtp-Source: AGHT+IGcxaTmlUfIZV35MmsO37rFwAN/Bn8nB8A94AAzIYXbrX4UepxVRdxRMdWBuBBSTIhoPoxHVw==
X-Received: by 2002:a2e:851:0:b0:2fa:c59d:1af3 with SMTP id 38308e7fff4ca-2fdec8534d3mr66808601fa.20.1730859607379;
        Tue, 05 Nov 2024 18:20:07 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8a66b8sm23061321fa.78.2024.11.05.18.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 18:20:05 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so55701921fa.3;
        Tue, 05 Nov 2024 18:20:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/Ji5Ykd3J9zQ+S2WTEY7oKmEAMujaHj4fRbqw+UzUtHfnQ9MscJYWjev6xoqCfFx+seekJFueKenB@vger.kernel.org, AJvYcCVV8en6LrGv2/cXLdJb8n/rCv8+Mq6KL7DIwk7pprWku/V6AGbnEzDqVSsLGxNAE1r/DGX/Mkj7FhDxnI2v@vger.kernel.org, AJvYcCXDkPOnWM7qnB4za1iaBYvn6xhWyAspuTA8jY9avT/SmnB/odeAEXjqRZLM9e8ClxhP8uo5KBqr@vger.kernel.org
X-Received: by 2002:a05:651c:556:b0:2f6:649e:bf5c with SMTP id
 38308e7fff4ca-2fdec726444mr95931291fa.17.1730859605489; Tue, 05 Nov 2024
 18:20:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <129f0c754d071cca1db5d207d9d4a7bd9831dff7.1726773282.git.dsimic@manjaro.org>
 <bef0570137358c6c4a55f59e7a4977c4@manjaro.org> <CAGb2v66aody60h=Bpk49pxogq93FekmO48uThPET2RKxvx=OGw@mail.gmail.com>
 <cfc090cb87a8b926116d1a436694d17d@manjaro.org>
In-Reply-To: <cfc090cb87a8b926116d1a436694d17d@manjaro.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 6 Nov 2024 10:19:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v67fLPf-yKObuds3LC77gT_W_OmgSK5y2KotRC-Zn9aL7w@mail.gmail.com>
Message-ID: <CAGb2v67fLPf-yKObuds3LC77gT_W_OmgSK5y2KotRC-Zn9aL7w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: pinephone: Add mount matrix to accelerometer
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-sunxi@lists.linux.dev, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ondrej Jirman <megi@xff.cz>, Andrey Skvortsov <andrej.skvortzov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 12:11=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> Hello Chen-Yu,
>
> On 2024-10-25 16:47, Chen-Yu Tsai wrote:
> > On Wed, Oct 23, 2024 at 5:11=E2=80=AFAM Dragan Simic <dsimic@manjaro.or=
g>
> > wrote:
> >> On 2024-09-19 21:15, Dragan Simic wrote:
> >> > The way InvenSense MPU-6050 accelerometer is mounted on the user-fac=
ing
> >> > side
> >> > of the Pine64 PinePhone mainboard, which makes it rotated 90 degrees
> >> > counter-
> >> > clockwise, [1] requires the accelerometer's x- and y-axis to be
> >> > swapped, and
> >> > the direction of the accelerometer's y-axis to be inverted.
> >> >
> >> > Rectify this by adding a mount-matrix to the accelerometer definitio=
n
> >> > in the Pine64 PinePhone dtsi file.
> >> >
> >> > [1] https://files.pine64.org/doc/PinePhone/PinePhone%20mainboard%20b=
ottom%20placement%20v1.1%2020191031.pdf
> >> >
> >> > Fixes: 91f480d40942 ("arm64: dts: allwinner: Add initial support for
> >> > Pine64 PinePhone")
> >> > Cc: stable@vger.kernel.org
> >> > Helped-by: Ondrej Jirman <megi@xff.cz>
> >> > Helped-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> >> > Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >>
> >> Just a brief reminder about this patch...  Please, let me know if some
> >> further work is needed for it to become accepted.
> >
> > There's no "Helped-by" tag, and checkpatch would complain. The closest
> > would be either Suggested-by or Co-developed-by, but with the latter
> > you would also need their Signed-off-by.
>
> Thanks for your response.  You're totally right about checkpatch.pl
> not supporting Helped-by tags, but including neither Suggested-by
> nor Co-developed-by would fit very well in this case, because the
> associated level of credit falls right somewhere between what's
> indicated by these two tags.
>
> > I can change it to Suggested-by if that's OK with you.
>
> I've created and submitted a patch [*] that adds support for Helped-by
> tags to checkpatch.pl.  Let's see what kind of feedback that patch
> will receive, and then we'll be able to move forward accordingly.

There doesn't seem to be any activity. Maybe also try adding it to the

    Documentation/process/submitting-patches.rst

document?


ChenYu


> [*]
> https://lore.kernel.org/linux-kernel/0e1ef28710e3e49222c966f07958a9879fa4=
e903.1729871544.git.dsimic@manjaro.org/T/#u
>
> >> > ---
> >> >
> >> > Notes:
> >> >     See also the linux-sunxi thread [2] that has led to this patch,
> >> > which
> >> >     provides a rather detailed analysis with additional details and
> >> > pictures.
> >> >     This patch effectively replaces the patch submitted in that thre=
ad.
> >> >
> >> >     [2]
> >> > https://lore.kernel.org/linux-sunxi/20240916204521.2033218-1-andrej.=
skvortzov@gmail.com/T/#u
> >> >
> >> >  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
> >> >  1 file changed, 3 insertions(+)
> >> >
> >> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> >> > b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> >> > index 6eab61a12cd8..b844759f52c0 100644
> >> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> >> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> >> > @@ -212,6 +212,9 @@ accelerometer@68 {
> >> >               interrupts =3D <7 5 IRQ_TYPE_EDGE_RISING>; /* PH5 */
> >> >               vdd-supply =3D <&reg_dldo1>;
> >> >               vddio-supply =3D <&reg_dldo1>;
> >> > +             mount-matrix =3D "0", "1", "0",
> >> > +                            "-1", "0", "0",
> >> > +                            "0", "0", "1";
> >> >       };
> >> >  };
> >>

