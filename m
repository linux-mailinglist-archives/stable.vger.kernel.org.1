Return-Path: <stable+bounces-47847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A248D7B9E
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 08:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5993D1F21606
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 06:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229452942A;
	Mon,  3 Jun 2024 06:33:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75309208CE;
	Mon,  3 Jun 2024 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396416; cv=none; b=WOV/qAdw9rwV7vpJ0UM3skj/IZxR61ie0ZW6kD/K/WsfbQ7XYGhngWFN3D9Ez6dHVrd2qLXMbb9ZThCOv9A7nPACcviXoLaQ9mis6G34tPZTscwFgRavmBkCVHcW3HbxEGy/MXGy5sL+aDZGQG3x2IH3wXNvfyQd65jdJJghofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396416; c=relaxed/simple;
	bh=6X2eWl8m6fp4O9UKOdJmQWu+wh1NOVXg4VKajjLXLgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFoMstbeQScRIbqyq2nJ45puGWRDLs1w8Go7dAo1JXrTkrfedEz0MNzuv5ZfagoWNCUvvJEU1cob50q6pYyZxfQptDSAEr0CyrtnR6VizYb3HWTUvZwbNjUlLjJ7m7PXkn4oh8Tm4BHnccomakZ07XJJPfunjGrdiCZkXBpi3wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b65.versanet.de ([83.135.91.101] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sE1Ft-0004rj-AX; Mon, 03 Jun 2024 08:33:17 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: wens@kernel.org, Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Diederik de Haas <didi.debian@cknow.org>
Subject:
 Re: [PATCH] arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage on
 Quartz64 Model B
Date: Mon, 03 Jun 2024 08:33:16 +0200
Message-ID: <2165494.3Lj2Plt8kZ@diego>
In-Reply-To: <d0ab380955c293cf676938be5ea5bf52@manjaro.org>
References:
 <e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org>
 <ee74c146d1e69bef118e208fdf5cf10f@manjaro.org>
 <d0ab380955c293cf676938be5ea5bf52@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Montag, 3. Juni 2024, 06:51:58 CEST schrieb Dragan Simic:
> On 2024-06-03 06:41, Dragan Simic wrote:
> > On 2024-06-03 05:49, Chen-Yu Tsai wrote:
> >> On Sat, Jun 1, 2024 at 6:41=E2=80=AFAM Dragan Simic <dsimic@manjaro.or=
g>=20
> >> wrote:
> >>> On 2024-05-31 20:40, Heiko St=C3=BCbner wrote:
> >>> > Am Freitag, 31. Mai 2024, 00:48:45 CEST schrieb Dragan Simic:
> >>> >> On 2024-05-29 18:27, Chen-Yu Tsai wrote:
> >>> >> > On Tue, May 21, 2024 at 1:20=E2=80=AFAM Dragan Simic <dsimic@man=
jaro.org>
> >>> >> > wrote:
> >>> >> >>
> >>> >> >> Correct the specified regulator-min-microvolt value for the buck
> >>> >> >> DCDC_REG2
> >>> >> >> regulator, which is part of the Rockchip RK809 PMIC, in the Pin=
e64
> >>> >> >> Quartz64
> >>> >> >> Model B board dts.  According to the RK809 datasheet, version 1=
=2E01,
> >>> >> >> this
> >>> >> >> regulator is capable of producing voltages as low as 0.5 V on i=
ts
> >>> >> >> output,
> >>> >> >> instead of going down to 0.9 V only, which is additionally conf=
irmed
> >>> >> >> by the
> >>> >> >> regulator-min-microvolt values found in the board dts files for=
 the
> >>> >> >> other
> >>> >> >> supported boards that use the same RK809 PMIC.
> >>> >> >>
> >>> >> >> This allows the DVFS to clock the GPU on the Quartz64 Model B b=
elow
> >>> >> >> 700 MHz,
> >>> >> >> all the way down to 200 MHz, which saves some power and reduces=
 the
> >>> >> >> amount of
> >>> >> >> generated heat a bit, improving the thermal headroom and possib=
ly
> >>> >> >> improving
> >>> >> >> the bursty CPU and GPU performance on this board.
> >>> >> >>
> >>> >> >> This also eliminates the following warnings in the kernel log:
> >>> >> >>
> >>> >> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: =
825000,
> >>> >> >> not supported by regulator
> >>> >> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulat=
ors
> >>> >> >> (200000000)
> >>> >> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: =
825000,
> >>> >> >> not supported by regulator
> >>> >> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulat=
ors
> >>> >> >> (300000000)
> >>> >> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: =
825000,
> >>> >> >> not supported by regulator
> >>> >> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulat=
ors
> >>> >> >> (400000000)
> >>> >> >>   core: _opp_supported_by_regulators: OPP minuV: 825000 maxuV: =
825000,
> >>> >> >> not supported by regulator
> >>> >> >>   panfrost fde60000.gpu: _opp_add: OPP not supported by regulat=
ors
> >>> >> >> (600000000)
> >>> >> >>
> >>> >> >> Fixes: dcc8c66bef79 ("arm64: dts: rockchip: add Pine64 Quartz64=
=2DB
> >>> >> >> device tree")
> >>> >> >> Cc: stable@vger.kernel.org
> >>> >> >> Reported-By: Diederik de Haas <didi.debian@cknow.org>
> >>> >> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >>> >> >> ---
> >>> >> >>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 2 +-
> >>> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>> >> >>
> >>> >> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> >>> >> >> b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> >>> >> >> index 26322a358d91..b908ce006c26 100644
> >>> >> >> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> >>> >> >> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> >>> >> >> @@ -289,7 +289,7 @@ vdd_gpu: DCDC_REG2 {
> >>> >> >>                                 regulator-name =3D "vdd_gpu";
> >>> >> >>                                 regulator-always-on;
> >>> >> >>                                 regulator-boot-on;
> >>> >> >> -                               regulator-min-microvolt =3D <90=
0000>;
> >>> >> >> +                               regulator-min-microvolt =3D <50=
0000>;
> >>> >> >
> >>> >> > The constraints here are supposed to be the constraints of the
> >>> >> > consumer,
> >>> >> > not the provider. The latter is already known by the implementat=
ion.
> >>> >> >
> >>> >> > So if the GPU can go down to 0.825V or 0.81V even (based on the
> >>> >> > datasheet),
> >>> >> > this should say the corresponding value. Surely the GPU can't go=
 down
> >>> >> > to
> >>> >> > 0.5V?
> >>> >> >
> >>> >> > Can you send another fix for it?
> >>> >>
> >>> >> I can confirm that the voltage of the power supply of GPU found in=
side
> >>> >> the RK3566 can be as low as 0.81 V, according to the datasheet, or=
 as
> >>> >> low as 0.825 V, according to the GPU OPPs found in rk356x.dtsi.
> >>> >>
> >>> >> If we want the regulator-min-microvolt parameter to reflect the
> >>> >> contraint
> >>> >> of the GPU as the consumer, which I agree with, we should do that =
for
> >>> >> other
> >>> >> RK3566-based boards as well, and almost surely for the boards base=
d on
> >>> >> the
> >>> >> RK3568, too.
> >>> >
> >>> > Hmm, I'm not so sure about that.
> >>> >
> >>> > The binding does define:
> >>> >       regulator-min-microvolt:
> >>> >           description: smallest voltage consumers may set
> >>> >
> >>> > This does not seem to describe it as a constraint solely of the
> >>> > consumer.
> >>> > At least the wording sounds way more flexible there.
> >>> >
> >>> > Also any regulator _could_ have multiple consumers, whose value wou=
ld
> >>> > it need then.
> >>>=20
> >>> The way I see it, the regulator-min-microvolt and
> >>> regulator-max-microvolt
> >>> parameters should be configured in a way that protects the=20
> >>> consumer(s)
> >>> of the particular voltage regulator against undervoltage and=20
> >>> overvoltage
> >>> conditions, which may be useful in some corner cases.
> >>>=20
> >>> If there are multiple consumers, which in this case may actually=20
> >>> happen
> >>> (IIRC, some boards use the same regulator for the GPU and NPU=20
> >>> portions
> >>> of the SoC), the situation becomes far from ideal, because the=20
> >>> consumers
> >>> might have different voltage requirements, but that's pretty much an
> >>> unavoidable compromise.
> >>=20
> >> As Dragan mentioned, the min/max voltage constraints are there to=20
> >> prevent
> >> the implementation from setting a voltage that would make the hardware
> >> inoperable, either temporarily or permanently. So the range set here
> >> should be the intersection of the permitted ranges of all consumers on
> >> that power rail.
> >>=20
> >> Now if that intersection happens to be an empty set, then it would up
> >> to the implementation to do proper lock-outs. Hopefully no one designs
> >> such hardware as it's too easy to fry some part of the hardware.
> >=20
> > Yes, such a hardware design would need fixing first on the schematic
> > level.  When it comes to the RK3566's GPU and NPU sharing the same
> > regulator, we should be fine because the RK3566 datasheet states that
> > both the GPU and the NPU can go as low as 0.81 V, and their upper
> > absolute ratings are the same at 1.2 V, so 1.0 V, which is as far as
> > the GPU OPPs go, should be fine for both.
> >=20
> > As a note, neither the RK3566 datasheet nor the RK3566 hardware design
> > guide specify the recommended upper voltage limit for the GPU or the
> > NPU.  Though, their upper absolute ratings are the same, as already
> > described above.
>=20
> Uh-oh, this rabbit hole goes much deeper than expected.  After a quick
> check, I see there are also RK3399-based boards/devices that specify
> the minimum and maximum values for their GPU regulators far outside
> the recommended operating conditions of the RK3399's GPU.
>=20
> Perhaps the scope of the upcoming patches should be expanded to cover
> other boards as well, not just those based on the RK356x.
>=20
> >>> > While true, setting it to the lowest the regulator can do in the
> >>> > original
> >>> > fix patch, might've been a bit much and a saner value might be bett=
er.
> >>>=20
> >>> Agreed, but the value was selected according to what the other
> >>> RK3566-based
> >>> boards use, to establish some kind of consistency.  Now, there's a=20
> >>> good
> >>> chance for the second pass, so to speak, which should establish=20
> >>> another
> >>> different state, but also consistent. :)
> >>>=20
> >>> >> This would ensure consistency, but I'd like to know are all those
> >>> >> resulting
> >>> >> patches going to be accepted before starting to prepare them?  The=
re
> >>> >> will
> >>> >> be a whole bunch of small patches.
> >>> >
> >>> > Hmm, though I'd say that would be one patch per soc?
> >>> >
> >>> > I.e. you're setting the min-voltage of _one_ regulator used
> >>> > on each board to a value to support the defined OPPs.
> >>> >
> >>> > I.e. in my mind you'd end up with:
> >>> >       arm64: dts: rockchip: set better min voltage for vdd_gpu on r=
k356x
> >>> > boards
> >>> >
> >>> > And setting the lower voltage to reach that lower OPP on all affect=
ed
> >>> > rk356x boards.
> >>>=20
> >>> Yes, the same thoughts have already crossed my mind, but I thought=20
> >>> we'd
> >>> like those patches to also include Fixes tags, so they also get
> >>> propagated
> >>> into the long-term kernel versions?  In that case, we'd need one=20
> >>> patch
> >>> per
> >>> board, to have a clear relation to the commits referenced in the=20
> >>> Fixes
> >>> tags.
> >>>=20
> >>> OTOH, if we don't want the patches to be propagated into the=20
> >>> long-term
> >>> kernel
> >>> versions, then having one patch per SoC would be perfectly fine.
> >>=20
> >> It's really up to Heiko, but personally I don't think it's that=20
> >> important
> >> to have them backported. These would be correctness patches, but don't
> >> really affect functionality.
> >=20
> > On second thought, I also think that it might be better not to have
> > these changes propagated into the long-term kernel versions.  That
> > would keep the amount of backported changes to the bare minimum, i.e.
> > containing just the really important fixes, while these changes are
> > more on the correctness side.  Maybe together with providing a bit
> > of additional safety.

hehe, up to you I guess :-) .

At least we tied down the how (one patch per soc or so) and not meant
to be backported because more of the correctnes side. So yes I agree with
the arguments for changing the constraints.

Heiko



