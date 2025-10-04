Return-Path: <stable+bounces-183390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BDABB9234
	for <lists+stable@lfdr.de>; Sun, 05 Oct 2025 00:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57D83C0C32
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 22:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A378B225788;
	Sat,  4 Oct 2025 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="m3yu5bd/"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CF31DE2A0;
	Sat,  4 Oct 2025 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759615425; cv=none; b=j9WVefnBQpV//84RMtm0kh12VZDmf/raQJt0NGUJSVLmnBGkd7Tg3NjpazDY8WLeom4VT4Qw8RuWgxRa0A8Uflyh1dUUPSJgq2WUWNByKkWg6LIch+2tb55r39TqdqtfJxcnsG3aWFQRNj1kbTBbksg4qOn4ZRytO2h9zZj0yYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759615425; c=relaxed/simple;
	bh=MdzP23QtrxfKPKp7bAx2Wb/OsRq/e/Rri2FPu0hUTOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDkUmB6TTD/UXp6w4VHFaY64fsZjtTM25Y+xakg+jV//6sYqA9lvgQxQ5MxC4oyRtLkX4yYnDlwEUSVvfcl3L+lBWhyHTVPi8UhDTW1l5w9fwBU2MaqNBPX5rkSSJlPS1WDMPTOm/gPGE78J2DPnTVitTNtd5pSS4g+/3JEvBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=m3yu5bd/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 1D79A208E;
	Sun,  5 Oct 2025 00:02:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759615322;
	bh=MdzP23QtrxfKPKp7bAx2Wb/OsRq/e/Rri2FPu0hUTOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3yu5bd/6l0e9ap9a2F9fpPxFFmhiKm+2tBCkTwtzjrlkYuaF9YSwaU7j6/hxrHWt
	 FP5yYiausCCnsGijKPSONQ0Bw/wehT/KioVZiJ1Tz7L698KPU2+mT8/c+ZFsmWNzOD
	 QRq0XLOCNbCG7Dg2hWYnnvncxOByefbSKAg6lLek=
Date: Sun, 5 Oct 2025 01:03:26 +0300
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
Message-ID: <20251004220326.GC20317@pendragon.ideasonboard.com>
References: <a76f315f023a3f8f5435e0681119b4eb@manjaro.org>
 <CABjd4Ywh_AkbXHonx-8vL-hNY5LMLJge5e4oqxvUG+qe6OF-Og@mail.gmail.com>
 <61b494b209d7360d0f36adbf6d5443a4@manjaro.org>
 <CABjd4Yx0p0B=e00MjCpDDq8Z=0FtM0s9EN86WdvRimt-_+kh2w@mail.gmail.com>
 <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com>
 <20251003133304.GA21023@pendragon.ideasonboard.com>
 <CABjd4YxbyUWghd1ya8UayFkAE-VWQSd5-J2QD0sV7WmS8AXkCg@mail.gmail.com>
 <CABjd4YwtwUYFX4bX5vy=AFi=Dn1r6nxWtMvmeKBSjkvriNJtsQ@mail.gmail.com>
 <20251003232856.GC1492@pendragon.ideasonboard.com>
 <CABjd4Yx9rt2W=MhCSyO5vaxndD1jvGHNWsz7J=HnvnJcgOvQHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABjd4Yx9rt2W=MhCSyO5vaxndD1jvGHNWsz7J=HnvnJcgOvQHw@mail.gmail.com>

On Sat, Oct 04, 2025 at 03:41:41PM +0400, Alexey Charkov wrote:
> On Sat, Oct 4, 2025 at 3:29 AM Laurent Pinchart wrote:
> > On Fri, Oct 03, 2025 at 06:55:26PM +0400, Alexey Charkov wrote:
> > > On Fri, Oct 3, 2025 at 6:13 PM Alexey Charkov wrote:
> > > > On Fri, Oct 3, 2025 at 5:33 PM Laurent Pinchart wrote:
> > > > > On Fri, Jan 24, 2025 at 11:44:34PM +0400, Alexey Charkov wrote:
> > > > > > On Fri, Jan 24, 2025 at 9:23 PM Alexey Charkov wrote:
> > > > > > > On Fri, Jan 24, 2025 at 2:37 PM Dragan Simic wrote:
> > > > > > > > On 2025-01-24 11:25, Alexey Charkov wrote:
> > > > > > > > > On Fri, Jan 24, 2025 at 2:06 PM Dragan Simic wrote:
> > > > > > > > >> On 2025-01-24 09:33, Alexey Charkov wrote:
> > > > > > > > >> > On Fri, Jan 24, 2025 at 9:26 AM Alexander Shiyan wrote:
> > > > > > > > >> >>
> > > > > > > > >> >> There is no pinctrl "gpio" and "otpout" (probably designed as
> > > > > > > > >> >> "output")
> > > > > > > > >> >> handling in the tsadc driver.
> > > > > > > > >> >> Let's use proper binding "default" and "sleep".
> > > > > > > > >> >
> > > > > > > > >> > This looks reasonable, however I've tried it on my Radxa Rock 5C and
> > > > > > > > >> > the driver still doesn't claim GPIO0 RK_PA1 even with this change. As
> > > > > > > > >> > a result, a simulated thermal runaway condition (I've changed the
> > > > > > > > >> > tshut temperature to 65000 and tshut mode to 1) doesn't trigger a PMIC
> > > > > > > > >> > reset, even though a direct `gpioset 0 1=0` does.
> > > > > > > > >> >
> > > > > > > > >> > Are any additional changes needed to the driver itself?
> > > > > > > > >>
> > > > > > > > >> I've been digging through this patch the whole TSADC/OTP thing in the
> > > > > > > > >> last couple of hours, and AFAIK some parts of the upstream driver are
> > > > > > > > >> still missing, in comparison with the downstream driver.
> > > > > > > > >>
> > > > > > > > >> I've got some small suggestions for the patch itself, but the issue
> > > > > > > > >> you observed is obviously of higher priority, and I've singled it out
> > > > > > > > >> as well while digging through the code.
> > > > > > > > >>
> > > > > > > > >> Could you, please, try the patch below quickly, to see is it going to
> > > > > > > > >> fix the issue you observed?  I've got some "IRL stuff" to take care of
> > > > > > > > >> today, so I can't test it myself, and it would be great to know is it
> > > > > > > > >> the right path to the proper fix.
> > > > > > > > >>
> > > > > > > > >> diff --git i/drivers/thermal/rockchip_thermal.c
> > > > > > > > >> w/drivers/thermal/rockchip_thermal.c
> > > > > > > > >> index f551df48eef9..62f0e14a8d98 100644
> > > > > > > > >> --- i/drivers/thermal/rockchip_thermal.c
> > > > > > > > >> +++ w/drivers/thermal/rockchip_thermal.c
> > > > > > > > >> @@ -1568,6 +1568,11 @@ static int rockchip_thermal_probe(struct
> > > > > > > > >> platform_device *pdev)
> > > > > > > > >>          thermal->chip->initialize(thermal->grf, thermal->regs,
> > > > > > > > >>                                    thermal->tshut_polarity);
> > > > > > > > >>
> > > > > > > > >> +       if (thermal->tshut_mode == TSHUT_MODE_GPIO)
> > > > > > > > >> +               pinctrl_select_default_state(dev);
> > > > > > > > >> +       else
> > > > > > > > >> +               pinctrl_select_sleep_state(dev);
> > > > > > > > >
> > > > > > > > > I believe no 'else' block is needed here, because if tshut_mode is not
> > > > > > > > > TSHUT_MODE_GPIO then the TSADC doesn't use this pin at all, so there's
> > > > > > > > > no reason for the driver to mess with its pinctrl state. I'd rather
> > > > > > > > > put a mirroring block to put the pin back to its 'sleep' state in the
> > > > > > > > > removal function for the TSHUT_MODE_GPIO case.
> > > > > > > >
> > > > > > > > You're right, but the "else block" is what the downstream driver does,
> > > > > > >
> > > > > > > Does it though? It only handles the TSHUT_MODE_GPIO case as far as I
> > > > > > > can tell (or TSHUT_MODE_OTP in downstream driver lingo) [1]
> > > > > > >
> > > > > > > [1] https://github.com/radxa/kernel/blob/edb3eeeaa4643ecac6f4185d6d391c574735fca1/drivers/thermal/rockchip_thermal.c#L2564
> > > > > > >
> > > > > > > > so I think it's better to simply stay on the safe side and follow that
> > > > > > > > logic in the upstream driver.  Is it really needed?  Perhaps not, but
> > > > > > > > it also shouldn't hurt.
> > > > > > > >
> > > > > > > > > Will try and revert.
> > > > > > > >
> > > > > > > > Awesome, thanks!
> > > > > > > >
> > > > > > > > > P.S. Just looked at the downstream driver, and it actually calls
> > > > > > > > > TSHUT_MODE_GPIO TSHUT_MODE_OTP instead, so it seems that "otpout" was
> > > > > > > > > not a typo in the first place. So maybe the right approach here is not
> > > > > > > > > to change the device tree but rather fix the "gpio" / "otpout" pinctrl
> > > > > > > > > state handling in the driver.
> > > > > > > >
> > > > > > > > Indeed, "otpout" wasn't a typo, and I've already addressed that in my
> > > > > > > > comments to Alexander's patch.  Will send that response a bit later.
> > > > > > > >
> > > > > > > > I think it's actually better to accept the approach in Alexander's
> > > > > > > > patch, because the whole thing applies to other Rockchip SoCs as well,
> > > > > > > > not just to the RK3588(S).
> > > > > > >
> > > > > > > Anyway, I've just tried it after including the changes below, and
> > > > > > > while /sys/kernel/debug/pinctrl/pinctrl-handles shows the expected
> > > > > > > pinctrls under tsadc, the driver still doesn't seem to be triggering a
> > > > > > > PMIC reset. Weird. Any thoughts welcome.
> > > > > >
> > > > > > I found the culprit. "otpout" (or "default" if we follow Alexander's
> > > > > > suggested approach) pinctrl state should refer to the &tsadc_shut_org
> > > > > > config instead of &tsadc_shut - then the PMIC reset works.
> > > > >
> > > > > I've recently brought up an RK3588S-based Orange Pi CM5 Base board, made
> > > > > of a compute module (CM5, see [1]) and a carrier board (Base, see [2]).
> > > > > The carrier board has a reset button which pulls the PMIC_RESET_L signal
> > > > > of the CM5 to GND (see page 3 of the schematics in [3]).
> > > > >
> > > > > With &tsadc_shut_org the reset button has absolutely no effect. With
> > > > > &tsadc_shut it resets the board as expected.
> > > >
> > > > Interesting. The TSADC shouldn't affect the physical button operation
> > > > at all, if it's really wired to the PMIC as the signal name implies.
> > > > There isn't even any default pull value associated with the TSHUT pin
> > > > config.
> > >
> > > On a second thought, I've got another hypothesis. Your baseboard only
> > > pulls the reset line through  a 100 Ohm resistor when the button is
> > > pressed. So if the TSHUT pin is in its default push-pull mode and
> > > stays high when no thermal runaway reset is requested, the reset
> > > button won't pull the line fully to zero, as the TSHUT line pulls it
> > > high at the same time.
> >
> > That's the most likely cause, I agree.
> >
> > > If you switch it from &tsadc_shut_org to &tsadc_shut, then it stops
> > > working properly as the thermal protection reset, and GPIO0_A1 remains
> > > high-impendance, thus allowing the reset button to function even
> > > though its pull is too weak.
> >
> > By the way, what is the difference between tsadc_shut_org and tsadc_shut
> > ? I haven't seen it being clearly documented in the TRM.
> 
> No idea frankly. Looks like a half-finished design change to me, which
> left the non-"org" version unconnected internally.

:-/

> > > So maybe change the pin configuration of &tsadc_shut_org in
> > > rk3588-base-pinctrl.dtsi to open drain and retry?
> >
> > That's a good idea, but... how ? The pinctrl-rockchip driver doesn't
> > seem to support generic open-drain configuration.
> 
> I thought I saw open-drain configurations here, but after reviewing
> the TRM, bindings and the driver it turns out I must have been
> daydreaming :( Sorry.
> 
> Looks like the best we can try is a lower drive strength while keeping
> the push-pull mode, but I'm afraid this 100 Ohm pulldown is too weak,
> because the lowest TSHUT drive strength Rockchip offers is 100 Ohm,
> while the PMIC would only count anything below 30% reference voltage
> as logical low. Maybe adding a pulldown to the pin config can help,
> but most likely this board will require switching the pin to GPIO
> input for high-z, and switching the TSHUT mode to CRU.

I agree with you, going through the CRU seems the best solution for this
board. This is actually the default mode in
arch/arm64/boot/dts/rockchip/rk3588-base.dtsi:

	rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
	rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
	pinctrl-0 = <&tsadc_shut_org>;
	pinctrl-1 = <&tsadc_gpio_func>;

If hw-tshut-mode defaults to 0, why do we need to setup the GPIO0_A1 pin
to output the TSADC_SHUT signal ?

> So how about something like this first:
> 
> &tsadc_shut_org {
>         rockchip,pins = <0 RK_PA1 1 &pcfg_pull_down_drv_level_0>;
> };

I've tested that and it's indeed not enough, the reset button still
doesn't work.

-- 
Regards,

Laurent Pinchart

