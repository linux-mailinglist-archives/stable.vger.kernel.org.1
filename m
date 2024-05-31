Return-Path: <stable+bounces-47810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554028D6916
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 20:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB8D1F278C5
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 18:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BE27E0EA;
	Fri, 31 May 2024 18:40:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD81E498;
	Fri, 31 May 2024 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180813; cv=none; b=ej8AHGj0QsLj/sAblNAQrB/+GSOLAFD9i0WilzGtb5HU/UiAUTK/BKNOpumat0f+XC0TDjHr5nzfGZbn3gfp2486LVSKrPBd92gd0BAHgY1TtQ6/xr3ABnI6cxudxMFg6qYprfRingMUA8ciC2gaAjO6bsDMPvbmzDVQmIL3p8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180813; c=relaxed/simple;
	bh=CWvKLgD3lohvx+6+tnGDOgFXdjwEyCPNuygDN7coiew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chX3pjVs4CjBi1tXpwMPpXCZPRaXKZmAsI+mEAuiyL4G+SOU6laWexGElQuirHRt284Hs6OwWPSRvRkVIGO9vG0mV8lA4WKIkB/Fgq9OXRTvWGylLQaW1kMnkW/GBc39JAFojCk4T72D6AwBR0GcSlPZYDO3YXK6OdASUV7485Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a4d.versanet.de ([83.135.90.77] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sD7AW-0003V4-TM; Fri, 31 May 2024 20:40:00 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: wens@kernel.org, Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Diederik de Haas <didi.debian@cknow.org>
Subject:
 Re: [PATCH] arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage on
 Quartz64 Model B
Date: Fri, 31 May 2024 20:40:00 +0200
Message-ID: <1994616.CrzyxZ31qj@diego>
In-Reply-To: <20cf041dcd6f752174bf29d2a53c61b3@manjaro.org>
References:
 <e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org>
 <CAGb2v66DPvvRcq+98vF2mCF8URW_qys1+B_FM9kcm6ppuPvyeg@mail.gmail.com>
 <20cf041dcd6f752174bf29d2a53c61b3@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Freitag, 31. Mai 2024, 00:48:45 CEST schrieb Dragan Simic:
> Hello Chen-Yu,
>=20
> On 2024-05-29 18:27, Chen-Yu Tsai wrote:
> > On Tue, May 21, 2024 at 1:20=E2=80=AFAM Dragan Simic <dsimic@manjaro.or=
g>=20
> > wrote:
> >>=20
> >> Correct the specified regulator-min-microvolt value for the buck=20
> >> DCDC_REG2
> >> regulator, which is part of the Rockchip RK809 PMIC, in the Pine64=20
> >> Quartz64
> >> Model B board dts.  According to the RK809 datasheet, version 1.01,=20
> >> this
> >> regulator is capable of producing voltages as low as 0.5 V on its=20
> >> output,
> >> instead of going down to 0.9 V only, which is additionally confirmed=20
> >> by the
> >> regulator-min-microvolt values found in the board dts files for the=20
> >> other
> >> supported boards that use the same RK809 PMIC.
> >>=20
> >> This allows the DVFS to clock the GPU on the Quartz64 Model B below=20
> >> 700 MHz,
> >> all the way down to 200 MHz, which saves some power and reduces the=20
> >> amount of
> >> generated heat a bit, improving the thermal headroom and possibly=20
> >> improving
> >> the bursty CPU and GPU performance on this board.
> >>=20
> >> This also eliminates the following warnings in the kernel log:
> >>=20
> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000,=
=20
> >> not supported by regulator
> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators=20
> >> (200000000)
> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000,=
=20
> >> not supported by regulator
> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators=20
> >> (300000000)
> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000,=
=20
> >> not supported by regulator
> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators=20
> >> (400000000)
> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: 825000,=
=20
> >> not supported by regulator
> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulators=20
> >> (600000000)
> >>=20
> >> Fixes: dcc8c66bef79 ("arm64: dts: rockchip: add Pine64 Quartz64-B=20
> >> device tree")
> >> Cc: stable@vger.kernel.org
> >> Reported-By: Diederik de Haas <didi.debian@cknow.org>
> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >> ---
> >>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>=20
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts=20
> >> b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> >> index 26322a358d91..b908ce006c26 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> >> @@ -289,7 +289,7 @@ vdd_gpu: DCDC_REG2 {
> >>                                 regulator-name =3D "vdd_gpu";
> >>                                 regulator-always-on;
> >>                                 regulator-boot-on;
> >> -                               regulator-min-microvolt =3D <900000>;
> >> +                               regulator-min-microvolt =3D <500000>;
> >=20
> > The constraints here are supposed to be the constraints of the=20
> > consumer,
> > not the provider. The latter is already known by the implementation.
> >=20
> > So if the GPU can go down to 0.825V or 0.81V even (based on the=20
> > datasheet),
> > this should say the corresponding value. Surely the GPU can't go down=20
> > to
> > 0.5V?
> >=20
> > Can you send another fix for it?
>=20
> I can confirm that the voltage of the power supply of GPU found inside
> the RK3566 can be as low as 0.81 V, according to the datasheet, or as
> low as 0.825 V, according to the GPU OPPs found in rk356x.dtsi.
>=20
> If we want the regulator-min-microvolt parameter to reflect the=20
> contraint
> of the GPU as the consumer, which I agree with, we should do that for=20
> other
> RK3566-based boards as well, and almost surely for the boards based on=20
> the
> RK3568, too.

Hmm, I'm not so sure about that.

The binding does define:
	regulator-min-microvolt:
	    description: smallest voltage consumers may set

This does not seem to describe it as a constraint solely of the consumer.
At least the wording sounds way more flexible there.

Also any regulator _could_ have multiple consumers, whose value would
it need then.


While true, setting it to the lowest the regulator can do in the original
fix patch, might've been a bit much and a saner value might be better.



> This would ensure consistency, but I'd like to know are all those=20
> resulting
> patches going to be accepted before starting to prepare them?  There=20
> will
> be a whole bunch of small patches.

Hmm, though I'd say that would be one patch per soc?

I.e. you're setting the min-voltage of _one_ regulator used
on each board to a value to support the defined OPPs.

I.e. in my mind you'd end up with:
	arm64: dts: rockchip: set better min voltage for vdd_gpu on rk356x boards

And setting the lower voltage to reach that lower OPP on all affected
rk356x boards.


Heiko

>=20
> >>                                 regulator-max-microvolt =3D <1350000>;
> >>                                 regulator-ramp-delay =3D <6001>;
>=20





