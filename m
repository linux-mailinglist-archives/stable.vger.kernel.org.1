Return-Path: <stable+bounces-183403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD81BB9B26
	for <lists+stable@lfdr.de>; Sun, 05 Oct 2025 20:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2303A6602
	for <lists+stable@lfdr.de>; Sun,  5 Oct 2025 18:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318D61DE2CC;
	Sun,  5 Oct 2025 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="d4xcUnIv"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E07E1D63CD;
	Sun,  5 Oct 2025 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688953; cv=none; b=WGwBZ/MojJSv6Dpg6Eqv2qfyvr9R6gq98aeLxsRlOxEPslHdfQePVopH0aKuSbx4uO/C6T2Ao6tOErSDeVu8SqYMrAlmT0X5+7rfvFrIXM6icufWAtPDOkV9y3VX920LZUhjdLFhMSmY1FQ0r4KHG3KwpTA3uYZ9ujH6ApwoY9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688953; c=relaxed/simple;
	bh=TH3yJBoT1mUNCSNf2l7RFS/wz9BfOxVp0X2N76eTNkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNvhuGxswfwRkQbvZyytISHS3TcVurVAMR1sc57bkCNJv2g124jF/zHlH0GN71aDBves4MukIenWyz1qEjfd5hSUQxN8/JQ23wq1pBvOv9UCw8O9YN+NWwAzqMGXD3vRkVCn0b70VFB0HMq4J0a0pgfLOJZ6+khvBhn+WyUa8sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=d4xcUnIv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 4DB701A89;
	Sun,  5 Oct 2025 20:27:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759688857;
	bh=TH3yJBoT1mUNCSNf2l7RFS/wz9BfOxVp0X2N76eTNkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4xcUnIvV0WL2SnbyFsyAiEuedlq5f1Hkj9Wjdv1UDdjEDXh7gsy7XYDNhx5H+HGu
	 g34QPioBoSfVUJfvlPy14h4njDrexj3cgtW1O9qJZ2n2CO9vUzKUVpVNRwVCiTLPok
	 /jZyTqqA/0SxHvsmU/43MTLc+KCpiVbkZaXIUBv8=
Date: Sun, 5 Oct 2025 21:29:03 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Alexey Charkov <alchark@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix broken tsadc pinctrl binding
 for rk3588
Message-ID: <20251005182903.GA29493@pendragon.ideasonboard.com>
References: <61b494b209d7360d0f36adbf6d5443a4@manjaro.org>
 <CABjd4Yx0p0B=e00MjCpDDq8Z=0FtM0s9EN86WdvRimt-_+kh2w@mail.gmail.com>
 <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com>
 <20251003133304.GA21023@pendragon.ideasonboard.com>
 <CABjd4YxbyUWghd1ya8UayFkAE-VWQSd5-J2QD0sV7WmS8AXkCg@mail.gmail.com>
 <CABjd4YwtwUYFX4bX5vy=AFi=Dn1r6nxWtMvmeKBSjkvriNJtsQ@mail.gmail.com>
 <20251003232856.GC1492@pendragon.ideasonboard.com>
 <CABjd4Yx9rt2W=MhCSyO5vaxndD1jvGHNWsz7J=HnvnJcgOvQHw@mail.gmail.com>
 <20251004220326.GC20317@pendragon.ideasonboard.com>
 <CABjd4YwLQ_kr3tA=XnzR4_zmQ0CQs4TuQr-2OWbiOWQfDhP4xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABjd4YwLQ_kr3tA=XnzR4_zmQ0CQs4TuQr-2OWbiOWQfDhP4xw@mail.gmail.com>

On Sun, Oct 05, 2025 at 02:55:07PM +0400, Alexey Charkov wrote:
> On Sun, Oct 5, 2025 at 2:03 AM Laurent Pinchart wrote:
> > On Sat, Oct 04, 2025 at 03:41:41PM +0400, Alexey Charkov wrote:
> > > On Sat, Oct 4, 2025 at 3:29 AM Laurent Pinchart wrote:
> > > > On Fri, Oct 03, 2025 at 06:55:26PM +0400, Alexey Charkov wrote:
> > > > > On Fri, Oct 3, 2025 at 6:13 PM Alexey Charkov wrote:
> > > > > > On Fri, Oct 3, 2025 at 5:33 PM Laurent Pinchart wrote:
> > > > > > > On Fri, Jan 24, 2025 at 11:44:34PM +0400, Alexey Charkov wrote:
> > > > > > > > On Fri, Jan 24, 2025 at 9:23 PM Alexey Charkov wrote:
> > > > > > > > > On Fri, Jan 24, 2025 at 2:37 PM Dragan Simic wrote:
> > > > > > > > > > On 2025-01-24 11:25, Alexey Charkov wrote:
> > > > > > > > > > > On Fri, Jan 24, 2025 at 2:06 PM Dragan Simic wrote:
> > > > > > > > > > >> On 2025-01-24 09:33, Alexey Charkov wrote:
> > > > > > > > > > >> > On Fri, Jan 24, 2025 at 9:26 AM Alexander Shiyan wrote:
> > > > > > > > > > >> >>
> > > > > > > > > > >> >> There is no pinctrl "gpio" and "otpout" (probably designed as
> > > > > > > > > > >> >> "output")
> > > > > > > > > > >> >> handling in the tsadc driver.
> > > > > > > > > > >> >> Let's use proper binding "default" and "sleep".
> > > > > > > > > > >> >
> > > > > > > > > > >> > This looks reasonable, however I've tried it on my Radxa Rock 5C and
> > > > > > > > > > >> > the driver still doesn't claim GPIO0 RK_PA1 even with this change. As
> > > > > > > > > > >> > a result, a simulated thermal runaway condition (I've changed the
> > > > > > > > > > >> > tshut temperature to 65000 and tshut mode to 1) doesn't trigger a PMIC
> > > > > > > > > > >> > reset, even though a direct `gpioset 0 1=0` does.
> > > > > > > > > > >> >
> > > > > > > > > > >> > Are any additional changes needed to the driver itself?
> > > > > > > > > > >>
> > > > > > > > > > >> I've been digging through this patch the whole TSADC/OTP thing in the
> > > > > > > > > > >> last couple of hours, and AFAIK some parts of the upstream driver are
> > > > > > > > > > >> still missing, in comparison with the downstream driver.
> > > > > > > > > > >>
> > > > > > > > > > >> I've got some small suggestions for the patch itself, but the issue
> > > > > > > > > > >> you observed is obviously of higher priority, and I've singled it out
> > > > > > > > > > >> as well while digging through the code.
> > > > > > > > > > >>
> > > > > > > > > > >> Could you, please, try the patch below quickly, to see is it going to
> > > > > > > > > > >> fix the issue you observed?  I've got some "IRL stuff" to take care of
> > > > > > > > > > >> today, so I can't test it myself, and it would be great to know is it
> > > > > > > > > > >> the right path to the proper fix.
> > > > > > > > > > >>
> > > > > > > > > > >> diff --git i/drivers/thermal/rockchip_thermal.c
> > > > > > > > > > >> w/drivers/thermal/rockchip_thermal.c
> > > > > > > > > > >> index f551df48eef9..62f0e14a8d98 100644
> > > > > > > > > > >> --- i/drivers/thermal/rockchip_thermal.c
> > > > > > > > > > >> +++ w/drivers/thermal/rockchip_thermal.c
> > > > > > > > > > >> @@ -1568,6 +1568,11 @@ static int rockchip_thermal_probe(struct
> > > > > > > > > > >> platform_device *pdev)
> > > > > > > > > > >>          thermal->chip->initialize(thermal->grf, thermal->regs,
> > > > > > > > > > >>                                    thermal->tshut_polarity);
> > > > > > > > > > >>
> > > > > > > > > > >> +       if (thermal->tshut_mode == TSHUT_MODE_GPIO)
> > > > > > > > > > >> +               pinctrl_select_default_state(dev);
> > > > > > > > > > >> +       else
> > > > > > > > > > >> +               pinctrl_select_sleep_state(dev);
> > > > > > > > > > >
> > > > > > > > > > > I believe no 'else' block is needed here, because if tshut_mode is not
> > > > > > > > > > > TSHUT_MODE_GPIO then the TSADC doesn't use this pin at all, so there's
> > > > > > > > > > > no reason for the driver to mess with its pinctrl state. I'd rather
> > > > > > > > > > > put a mirroring block to put the pin back to its 'sleep' state in the
> > > > > > > > > > > removal function for the TSHUT_MODE_GPIO case.
> > > > > > > > > >
> > > > > > > > > > You're right, but the "else block" is what the downstream driver does,
> > > > > > > > >
> > > > > > > > > Does it though? It only handles the TSHUT_MODE_GPIO case as far as I
> > > > > > > > > can tell (or TSHUT_MODE_OTP in downstream driver lingo) [1]
> > > > > > > > >
> > > > > > > > > [1] https://github.com/radxa/kernel/blob/edb3eeeaa4643ecac6f4185d6d391c574735fca1/drivers/thermal/rockchip_thermal.c#L2564
> > > > > > > > >
> > > > > > > > > > so I think it's better to simply stay on the safe side and follow that
> > > > > > > > > > logic in the upstream driver.  Is it really needed?  Perhaps not, but
> > > > > > > > > > it also shouldn't hurt.
> > > > > > > > > >
> > > > > > > > > > > Will try and revert.
> > > > > > > > > >
> > > > > > > > > > Awesome, thanks!
> > > > > > > > > >
> > > > > > > > > > > P.S. Just looked at the downstream driver, and it actually calls
> > > > > > > > > > > TSHUT_MODE_GPIO TSHUT_MODE_OTP instead, so it seems that "otpout" was
> > > > > > > > > > > not a typo in the first place. So maybe the right approach here is not
> > > > > > > > > > > to change the device tree but rather fix the "gpio" / "otpout" pinctrl
> > > > > > > > > > > state handling in the driver.
> > > > > > > > > >
> > > > > > > > > > Indeed, "otpout" wasn't a typo, and I've already addressed that in my
> > > > > > > > > > comments to Alexander's patch.  Will send that response a bit later.
> > > > > > > > > >
> > > > > > > > > > I think it's actually better to accept the approach in Alexander's
> > > > > > > > > > patch, because the whole thing applies to other Rockchip SoCs as well,
> > > > > > > > > > not just to the RK3588(S).
> > > > > > > > >
> > > > > > > > > Anyway, I've just tried it after including the changes below, and
> > > > > > > > > while /sys/kernel/debug/pinctrl/pinctrl-handles shows the expected
> > > > > > > > > pinctrls under tsadc, the driver still doesn't seem to be triggering a
> > > > > > > > > PMIC reset. Weird. Any thoughts welcome.
> > > > > > > >
> > > > > > > > I found the culprit. "otpout" (or "default" if we follow Alexander's
> > > > > > > > suggested approach) pinctrl state should refer to the &tsadc_shut_org
> > > > > > > > config instead of &tsadc_shut - then the PMIC reset works.
> > > > > > >
> > > > > > > I've recently brought up an RK3588S-based Orange Pi CM5 Base board, made
> > > > > > > of a compute module (CM5, see [1]) and a carrier board (Base, see [2]).
> > > > > > > The carrier board has a reset button which pulls the PMIC_RESET_L signal
> > > > > > > of the CM5 to GND (see page 3 of the schematics in [3]).
> > > > > > >
> > > > > > > With &tsadc_shut_org the reset button has absolutely no effect. With
> > > > > > > &tsadc_shut it resets the board as expected.
> > > > > >
> > > > > > Interesting. The TSADC shouldn't affect the physical button operation
> > > > > > at all, if it's really wired to the PMIC as the signal name implies.
> > > > > > There isn't even any default pull value associated with the TSHUT pin
> > > > > > config.
> > > > >
> > > > > On a second thought, I've got another hypothesis. Your baseboard only
> > > > > pulls the reset line through  a 100 Ohm resistor when the button is
> > > > > pressed. So if the TSHUT pin is in its default push-pull mode and
> > > > > stays high when no thermal runaway reset is requested, the reset
> > > > > button won't pull the line fully to zero, as the TSHUT line pulls it
> > > > > high at the same time.
> > > >
> > > > That's the most likely cause, I agree.
> > > >
> > > > > If you switch it from &tsadc_shut_org to &tsadc_shut, then it stops
> > > > > working properly as the thermal protection reset, and GPIO0_A1 remains
> > > > > high-impendance, thus allowing the reset button to function even
> > > > > though its pull is too weak.
> > > >
> > > > By the way, what is the difference between tsadc_shut_org and tsadc_shut
> > > > ? I haven't seen it being clearly documented in the TRM.
> > >
> > > No idea frankly. Looks like a half-finished design change to me, which
> > > left the non-"org" version unconnected internally.
> >
> > :-/
> >
> > > > > So maybe change the pin configuration of &tsadc_shut_org in
> > > > > rk3588-base-pinctrl.dtsi to open drain and retry?
> > > >
> > > > That's a good idea, but... how ? The pinctrl-rockchip driver doesn't
> > > > seem to support generic open-drain configuration.
> > >
> > > I thought I saw open-drain configurations here, but after reviewing
> > > the TRM, bindings and the driver it turns out I must have been
> > > daydreaming :( Sorry.
> > >
> > > Looks like the best we can try is a lower drive strength while keeping
> > > the push-pull mode, but I'm afraid this 100 Ohm pulldown is too weak,
> > > because the lowest TSHUT drive strength Rockchip offers is 100 Ohm,
> > > while the PMIC would only count anything below 30% reference voltage
> > > as logical low. Maybe adding a pulldown to the pin config can help,
> > > but most likely this board will require switching the pin to GPIO
> > > input for high-z, and switching the TSHUT mode to CRU.
> >
> > I agree with you, going through the CRU seems the best solution for this
> > board. This is actually the default mode in
> > arch/arm64/boot/dts/rockchip/rk3588-base.dtsi:
> >
> >         rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
> >         rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
> >         pinctrl-0 = <&tsadc_shut_org>;
> >         pinctrl-1 = <&tsadc_gpio_func>;
> >
> > If hw-tshut-mode defaults to 0, why do we need to setup the GPIO0_A1 pin
> > to output the TSADC_SHUT signal ?
> 
> I believe the thinking was along the lines of "it can't hurt, so let's
> provide a default that's likely to work both for the boards where
> TSHUT is routed to the PMIC and those where it's not, with an added
> benefit of hogging the pin to prevent anyone from accidentally
> triggering it to a low level from user space thus suddenly resetting
> the board".
> 
> But this case of "TSHUT is routed, but with a deviation from the
> reference schematic which makes it impossible to use as designed" was
> likely never envisaged.
> 
> Technically, there is no reason to switch the pin to tsadc_shut_org
> when CRU mode is used, and the boottime default for this pin is
> high-impedance.

I tried to trigger an over-temperature condition by setting
rockchip,hw-tshut-temp to 40°C (yes, it's getting cold in Finland). With
pinctrl-0 set to <&tsadc_shut_org>, the system reset when the trip point
was reached, regardless of rockchip,hw-tshut-mode.

With pinctrl-0 set to <&tsadc_gpio_func>, reaching 40°C caused a reset
with rockchip,hw-tshut-mode set to 0 (CRU), and no action occurred when
rockchip,hw-tshut-mode was set to 1 (GPIO).

I've also tested <&tsadc_shut>. It resulted in a reset in CRU mode and
no action in GPIO mode.

> Heiko, shall we remove the pinctrl properties from the common .dtsi
> and move them to board specific .dts for those boards that use
> PMIC-assisted thermal resets? Happy to produce a patch to that effect.

-- 
Regards,

Laurent Pinchart

