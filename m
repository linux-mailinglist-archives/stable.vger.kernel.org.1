Return-Path: <stable+bounces-47842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED598D7A8B
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 05:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0A71F2160C
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 03:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C3FFBED;
	Mon,  3 Jun 2024 03:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJr9U5dv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ADC2231F;
	Mon,  3 Jun 2024 03:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717386560; cv=none; b=AHHTIN/gOuzvxGJwidLGusF4ywN/lm3xQIFjtPi2Bq7r7Etup/479hzOuBqYLOV8qqeuR8pQW4xTiG228kCQOe2NBDPE/mKH+B4S5NIHC+oZy7O+02IIQm7L+r0JZQDHlM3uc3yhD9DF5atg0Rs3mFQn5jhm9uipFSSTWJt4B9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717386560; c=relaxed/simple;
	bh=z5mvz1lfU07jZ9iUZyD5kFk1KnR8RI60n0qB14ClCu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNWPLk/c3I7886wBmGaM5VsSw5FGgw31QuP6hhbWFCL+a7A+goVejX924rkli7sWYAlsK14fsM34lHhhsaW7SMgFEpm64a/DAVPeJ0qgdRCncxFZ4TmC1XJnVsGHO2jGICDGEyEDX3A/rbgQi8e24SbjeXBIAr6+A2YsvO6X39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJr9U5dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124F0C4AF0A;
	Mon,  3 Jun 2024 03:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717386560;
	bh=z5mvz1lfU07jZ9iUZyD5kFk1KnR8RI60n0qB14ClCu4=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=nJr9U5dvWsJGp1yXIScseBNGOHsplw9c4KuJi91Sred1RJiDqHgD/ep8QQEctNssz
	 FJJxTWaZ7Lzvtdi1ByGOBqOsKIpdau6v2ltwmMDbbsHBmZSunzFF51ZRztiO4bNN9+
	 f1u9ZrP1kHoOunz1zK5e0TjS0JRL0AAPjjqvlO0eTrO8JYhZiaQpbn33Qfc7YY354N
	 Z6ZSfK01Z4uWajSUpSM1/UczxLX5hbEh2bGAGccKrETs+ujtIurn6GeUO5BwGPQwFi
	 8wNi24KM315TmeFnt78tgc079mBNpBkxkjik6t6WrZ55+q8DJ50S5iL31QsXLkr+bS
	 FUG0yKedcz2eg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e6f2534e41so31293581fa.0;
        Sun, 02 Jun 2024 20:49:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCW08ENm0wIZ1A+Lc2kohqfY0TCVKwU5Yz7bZwGQmAkjIWu3sW1OFjioYZlFvUeHlrIT6ejAw1jaXJ9uHrb9vbCMv28fjRTPzCwen60sio3UmMi/no/rHoWuVLbN/2F3jk1eTJJSGwy0Ha73jeTUsVD2axZ+pIFHwfg6gVlT0Vhg==
X-Gm-Message-State: AOJu0YwnGLLLjFuitHPiI2vrypbwItWi3jaHp1XVFMWlZisTPZTETlWz
	fyeL2mZ5Kt8WrSOCxI3yyRLmhNXJot2q9Q2D524H/+yEcV8ZJlqw0SVGwSz4pfah2w2lCiE/q0V
	heHHkV4Tcv6ic4KHnGkhI4WCS+Bw=
X-Google-Smtp-Source: AGHT+IGeqKCFJubYk+BuVV24uz6Hs7s17epjkgBlNhlX+930U/YvE3OiynaVsYGHCA80uyovp6h4bbLGr3JfLlvXaVs=
X-Received: by 2002:a05:651c:1a28:b0:2ea:7a2a:4d0b with SMTP id
 38308e7fff4ca-2ea950e63b5mr60506571fa.17.1717386558327; Sun, 02 Jun 2024
 20:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org>
 <CAGb2v66DPvvRcq+98vF2mCF8URW_qys1+B_FM9kcm6ppuPvyeg@mail.gmail.com>
 <20cf041dcd6f752174bf29d2a53c61b3@manjaro.org> <1994616.CrzyxZ31qj@diego> <99ea0e0053d3ada3325bdfaec7a937f0@manjaro.org>
In-Reply-To: <99ea0e0053d3ada3325bdfaec7a937f0@manjaro.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 3 Jun 2024 11:49:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v64K7fgeV9GVNnpoZ_4BZU7JKXHSCYU0hKxHmnyojFRu7g@mail.gmail.com>
Message-ID: <CAGb2v64K7fgeV9GVNnpoZ_4BZU7JKXHSCYU0hKxHmnyojFRu7g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage
 on Quartz64 Model B
To: Dragan Simic <dsimic@manjaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Diederik de Haas <didi.debian@cknow.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 6:41=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> wr=
ote:
>
> Hello Heiko,
>
> On 2024-05-31 20:40, Heiko St=C3=BCbner wrote:
> > Am Freitag, 31. Mai 2024, 00:48:45 CEST schrieb Dragan Simic:
> >> On 2024-05-29 18:27, Chen-Yu Tsai wrote:
> >> > On Tue, May 21, 2024 at 1:20=E2=80=AFAM Dragan Simic <dsimic@manjaro=
.org>
> >> > wrote:
> >> >>
> >> >> Correct the specified regulator-min-microvolt value for the buck
> >> >> DCDC_REG2
> >> >> regulator, which is part of the Rockchip RK809 PMIC, in the Pine64
> >> >> Quartz64
> >> >> Model B board dts.  According to the RK809 datasheet, version 1.01,
> >> >> this
> >> >> regulator is capable of producing voltages as low as 0.5 V on its
> >> >> output,
> >> >> instead of going down to 0.9 V only, which is additionally confirme=
d
> >> >> by the
> >> >> regulator-min-microvolt values found in the board dts files for the
> >> >> other
> >> >> supported boards that use the same RK809 PMIC.
> >> >>
> >> >> This allows the DVFS to clock the GPU on the Quartz64 Model B below
> >> >> 700 MHz,
> >> >> all the way down to 200 MHz, which saves some power and reduces the
> >> >> amount of
> >> >> generated heat a bit, improving the thermal headroom and possibly
> >> >> improving
> >> >> the bursty CPU and GPU performance on this board.
> >> >>
> >> >> This also eliminates the following warnings in the kernel log:
> >> >>
> >> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 8250=
00,
> >> >> not supported by regulator
> >> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators
> >> >> (200000000)
> >> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 8250=
00,
> >> >> not supported by regulator
> >> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators
> >> >> (300000000)
> >> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 8250=
00,
> >> >> not supported by regulator
> >> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators
> >> >> (400000000)
> >> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 8250=
00,
> >> >> not supported by regulator
> >> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators
> >> >> (600000000)
> >> >>
> >> >> Fixes: dcc8c66bef79 ("arm64: dts: rockchip: add Pine64 Quartz64-B
> >> >> device tree")
> >> >> Cc: stable@vger.kernel.org
> >> >> Reported-By: Diederik de Haas <didi.debian@cknow.org>
> >> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >> >> ---
> >> >>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 2 +-
> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> >> >> b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> >> >> index 26322a358d91..b908ce006c26 100644
> >> >> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> >> >> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> >> >> @@ -289,7 +289,7 @@ vdd_gpu: DCDC_REG2 {
> >> >>                                 regulator-name =3D "vdd_gpu";
> >> >>                                 regulator-always-on;
> >> >>                                 regulator-boot-on;
> >> >> -                               regulator-min-microvolt =3D <900000=
>;
> >> >> +                               regulator-min-microvolt =3D <500000=
>;
> >> >
> >> > The constraints here are supposed to be the constraints of the
> >> > consumer,
> >> > not the provider. The latter is already known by the implementation.
> >> >
> >> > So if the GPU can go down to 0.825V or 0.81V even (based on the
> >> > datasheet),
> >> > this should say the corresponding value. Surely the GPU can't go dow=
n
> >> > to
> >> > 0.5V?
> >> >
> >> > Can you send another fix for it?
> >>
> >> I can confirm that the voltage of the power supply of GPU found inside
> >> the RK3566 can be as low as 0.81 V, according to the datasheet, or as
> >> low as 0.825 V, according to the GPU OPPs found in rk356x.dtsi.
> >>
> >> If we want the regulator-min-microvolt parameter to reflect the
> >> contraint
> >> of the GPU as the consumer, which I agree with, we should do that for
> >> other
> >> RK3566-based boards as well, and almost surely for the boards based on
> >> the
> >> RK3568, too.
> >
> > Hmm, I'm not so sure about that.
> >
> > The binding does define:
> >       regulator-min-microvolt:
> >           description: smallest voltage consumers may set
> >
> > This does not seem to describe it as a constraint solely of the
> > consumer.
> > At least the wording sounds way more flexible there.
> >
> > Also any regulator _could_ have multiple consumers, whose value would
> > it need then.
>
> The way I see it, the regulator-min-microvolt and
> regulator-max-microvolt
> parameters should be configured in a way that protects the consumer(s)
> of the particular voltage regulator against undervoltage and overvoltage
> conditions, which may be useful in some corner cases.
>
> If there are multiple consumers, which in this case may actually happen
> (IIRC, some boards use the same regulator for the GPU and NPU portions
> of the SoC), the situation becomes far from ideal, because the consumers
> might have different voltage requirements, but that's pretty much an
> unavoidable compromise.

As Dragan mentioned, the min/max voltage constraints are there to prevent
the implementation from setting a voltage that would make the hardware
inoperable, either temporarily or permanently. So the range set here
should be the intersection of the permitted ranges of all consumers on
that power rail.

Now if that intersection happens to be an empty set, then it would up
to the implementation to do proper lock-outs. Hopefully no one designs
such hardware as it's too easy to fry some part of the hardware.

> > While true, setting it to the lowest the regulator can do in the
> > original
> > fix patch, might've been a bit much and a saner value might be better.
>
> Agreed, but the value was selected according to what the other
> RK3566-based
> boards use, to establish some kind of consistency.  Now, there's a good
> chance for the second pass, so to speak, which should establish another
> different state, but also consistent. :)
>
> >> This would ensure consistency, but I'd like to know are all those
> >> resulting
> >> patches going to be accepted before starting to prepare them?  There
> >> will
> >> be a whole bunch of small patches.
> >
> > Hmm, though I'd say that would be one patch per soc?
> >
> > I.e. you're setting the min-voltage of _one_ regulator used
> > on each board to a value to support the defined OPPs.
> >
> > I.e. in my mind you'd end up with:
> >       arm64: dts: rockchip: set better min voltage for vdd_gpu on rk356=
x
> > boards
> >
> > And setting the lower voltage to reach that lower OPP on all affected
> > rk356x boards.
>
> Yes, the same thoughts have already crossed my mind, but I thought we'd
> like those patches to also include Fixes tags, so they also get
> propagated
> into the long-term kernel versions?  In that case, we'd need one patch
> per
> board, to have a clear relation to the commits referenced in the Fixes
> tags.
>
> OTOH, if we don't want the patches to be propagated into the long-term
> kernel
> versions, then having one patch per SoC would be perfectly fine.

It's really up to Heiko, but personally I don't think it's that important
to have them backported. These would be correctness patches, but don't
really affect functionality.

Regards
ChenYu

