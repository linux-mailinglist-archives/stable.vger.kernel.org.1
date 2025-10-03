Return-Path: <stable+bounces-183339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F96BB8664
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 01:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 213A14EB24D
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 23:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D488A277CBC;
	Fri,  3 Oct 2025 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bmrkak1L"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A9247DEA;
	Fri,  3 Oct 2025 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534149; cv=none; b=kQnGcmDfo4VnXwJ/g/wAuFmBJu25rdVF6yM66Kw6Oi+BF6PG89iIAdDtkKG3LFLl7zykAufz4LMP9jH0K/uO9g/6eLvRydnAZ7BHh3m2UkfZUsQdZZFRqriATxfpX7ZHNky5kN1kzCtK+mA1xKPOwtxwCbZhcTPiBEzZdRKAIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534149; c=relaxed/simple;
	bh=Gd6MjNS+J2ZgURDuUz7uUsdeGP3zuFb2WjuR8+lGXUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOKDfLkbOW4ltCvO42c6o5lOXitfsk5ZGD9ILqqyN2d9fSoNKrM//tGYiz9PZ/paiDnuKAgovP8ThwATgPxqbLgFG7jMwLSLSdwqfKI24V2dkLrbrSye4Udn2IDW2llw+qK+nGDM/j/Bj31cJsaneedAzBoisMcgzLujMsQ91YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bmrkak1L; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id EE1811340;
	Sat,  4 Oct 2025 01:27:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759534053;
	bh=Gd6MjNS+J2ZgURDuUz7uUsdeGP3zuFb2WjuR8+lGXUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bmrkak1L5TPfv70hwLAyxVvGyPtYS2vSwFF0uzzbrKaVLMpbvUSSxTCoIQmMKh2QB
	 WCij6BrSJzdoeEE5DvIFEUJqTk08aXy++c00jjMUPnmxreofhiTIyfp5PP01Qtu6fH
	 KZhBK27shpa/sXo0GHzitqlI9CNVb5dlpmRmn8o8=
Date: Sat, 4 Oct 2025 02:28:56 +0300
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
Message-ID: <20251003232856.GC1492@pendragon.ideasonboard.com>
References: <20250124052611.3705-1-eagle.alexander923@gmail.com>
 <CABjd4YwA8P9LVuDviO6xydkHpuuOY7XT0pk1oa+FDqOo=uZN4A@mail.gmail.com>
 <a76f315f023a3f8f5435e0681119b4eb@manjaro.org>
 <CABjd4Ywh_AkbXHonx-8vL-hNY5LMLJge5e4oqxvUG+qe6OF-Og@mail.gmail.com>
 <61b494b209d7360d0f36adbf6d5443a4@manjaro.org>
 <CABjd4Yx0p0B=e00MjCpDDq8Z=0FtM0s9EN86WdvRimt-_+kh2w@mail.gmail.com>
 <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com>
 <20251003133304.GA21023@pendragon.ideasonboard.com>
 <CABjd4YxbyUWghd1ya8UayFkAE-VWQSd5-J2QD0sV7WmS8AXkCg@mail.gmail.com>
 <CABjd4YwtwUYFX4bX5vy=AFi=Dn1r6nxWtMvmeKBSjkvriNJtsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABjd4YwtwUYFX4bX5vy=AFi=Dn1r6nxWtMvmeKBSjkvriNJtsQ@mail.gmail.com>

Hi Alexey,

On Fri, Oct 03, 2025 at 06:55:26PM +0400, Alexey Charkov wrote:
> On Fri, Oct 3, 2025 at 6:13 PM Alexey Charkov wrote:
> > On Fri, Oct 3, 2025 at 5:33 PM Laurent Pinchart wrote:
> > > On Fri, Jan 24, 2025 at 11:44:34PM +0400, Alexey Charkov wrote:
> > > > On Fri, Jan 24, 2025 at 9:23 PM Alexey Charkov <alchark@gmail.com> wrote:
> > > > > On Fri, Jan 24, 2025 at 2:37 PM Dragan Simic <dsimic@manjaro.org> wrote:
> > > > > > On 2025-01-24 11:25, Alexey Charkov wrote:
> > > > > > > On Fri, Jan 24, 2025 at 2:06 PM Dragan Simic <dsimic@manjaro.org>
> > > > > > > wrote:
> > > > > > >> On 2025-01-24 09:33, Alexey Charkov wrote:
> > > > > > >> > On Fri, Jan 24, 2025 at 9:26 AM Alexander Shiyan
> > > > > > >> > <eagle.alexander923@gmail.com> wrote:
> > > > > > >> >>
> > > > > > >> >> There is no pinctrl "gpio" and "otpout" (probably designed as
> > > > > > >> >> "output")
> > > > > > >> >> handling in the tsadc driver.
> > > > > > >> >> Let's use proper binding "default" and "sleep".
> > > > > > >> >
> > > > > > >> > This looks reasonable, however I've tried it on my Radxa Rock 5C and
> > > > > > >> > the driver still doesn't claim GPIO0 RK_PA1 even with this change. As
> > > > > > >> > a result, a simulated thermal runaway condition (I've changed the
> > > > > > >> > tshut temperature to 65000 and tshut mode to 1) doesn't trigger a PMIC
> > > > > > >> > reset, even though a direct `gpioset 0 1=0` does.
> > > > > > >> >
> > > > > > >> > Are any additional changes needed to the driver itself?
> > > > > > >>
> > > > > > >> I've been digging through this patch the whole TSADC/OTP thing in the
> > > > > > >> last couple of hours, and AFAIK some parts of the upstream driver are
> > > > > > >> still missing, in comparison with the downstream driver.
> > > > > > >>
> > > > > > >> I've got some small suggestions for the patch itself, but the issue
> > > > > > >> you observed is obviously of higher priority, and I've singled it out
> > > > > > >> as well while digging through the code.
> > > > > > >>
> > > > > > >> Could you, please, try the patch below quickly, to see is it going to
> > > > > > >> fix the issue you observed?  I've got some "IRL stuff" to take care of
> > > > > > >> today, so I can't test it myself, and it would be great to know is it
> > > > > > >> the right path to the proper fix.
> > > > > > >>
> > > > > > >> diff --git i/drivers/thermal/rockchip_thermal.c
> > > > > > >> w/drivers/thermal/rockchip_thermal.c
> > > > > > >> index f551df48eef9..62f0e14a8d98 100644
> > > > > > >> --- i/drivers/thermal/rockchip_thermal.c
> > > > > > >> +++ w/drivers/thermal/rockchip_thermal.c
> > > > > > >> @@ -1568,6 +1568,11 @@ static int rockchip_thermal_probe(struct
> > > > > > >> platform_device *pdev)
> > > > > > >>          thermal->chip->initialize(thermal->grf, thermal->regs,
> > > > > > >>                                    thermal->tshut_polarity);
> > > > > > >>
> > > > > > >> +       if (thermal->tshut_mode == TSHUT_MODE_GPIO)
> > > > > > >> +               pinctrl_select_default_state(dev);
> > > > > > >> +       else
> > > > > > >> +               pinctrl_select_sleep_state(dev);
> > > > > > >
> > > > > > > I believe no 'else' block is needed here, because if tshut_mode is not
> > > > > > > TSHUT_MODE_GPIO then the TSADC doesn't use this pin at all, so there's
> > > > > > > no reason for the driver to mess with its pinctrl state. I'd rather
> > > > > > > put a mirroring block to put the pin back to its 'sleep' state in the
> > > > > > > removal function for the TSHUT_MODE_GPIO case.
> > > > > >
> > > > > > You're right, but the "else block" is what the downstream driver does,
> > > > >
> > > > > Does it though? It only handles the TSHUT_MODE_GPIO case as far as I
> > > > > can tell (or TSHUT_MODE_OTP in downstream driver lingo) [1]
> > > > >
> > > > > [1] https://github.com/radxa/kernel/blob/edb3eeeaa4643ecac6f4185d6d391c574735fca1/drivers/thermal/rockchip_thermal.c#L2564
> > > > >
> > > > > > so I think it's better to simply stay on the safe side and follow that
> > > > > > logic in the upstream driver.  Is it really needed?  Perhaps not, but
> > > > > > it also shouldn't hurt.
> > > > > >
> > > > > > > Will try and revert.
> > > > > >
> > > > > > Awesome, thanks!
> > > > > >
> > > > > > > P.S. Just looked at the downstream driver, and it actually calls
> > > > > > > TSHUT_MODE_GPIO TSHUT_MODE_OTP instead, so it seems that "otpout" was
> > > > > > > not a typo in the first place. So maybe the right approach here is not
> > > > > > > to change the device tree but rather fix the "gpio" / "otpout" pinctrl
> > > > > > > state handling in the driver.
> > > > > >
> > > > > > Indeed, "otpout" wasn't a typo, and I've already addressed that in my
> > > > > > comments to Alexander's patch.  Will send that response a bit later.
> > > > > >
> > > > > > I think it's actually better to accept the approach in Alexander's
> > > > > > patch, because the whole thing applies to other Rockchip SoCs as well,
> > > > > > not just to the RK3588(S).
> > > > >
> > > > > Anyway, I've just tried it after including the changes below, and
> > > > > while /sys/kernel/debug/pinctrl/pinctrl-handles shows the expected
> > > > > pinctrls under tsadc, the driver still doesn't seem to be triggering a
> > > > > PMIC reset. Weird. Any thoughts welcome.
> > > >
> > > > I found the culprit. "otpout" (or "default" if we follow Alexander's
> > > > suggested approach) pinctrl state should refer to the &tsadc_shut_org
> > > > config instead of &tsadc_shut - then the PMIC reset works.
> > >
> > > I've recently brought up an RK3588S-based Orange Pi CM5 Base board, made
> > > of a compute module (CM5, see [1]) and a carrier board (Base, see [2]).
> > > The carrier board has a reset button which pulls the PMIC_RESET_L signal
> > > of the CM5 to GND (see page 3 of the schematics in [3]).
> > >
> > > With &tsadc_shut_org the reset button has absolutely no effect. With
> > > &tsadc_shut it resets the board as expected.
> >
> > Interesting. The TSADC shouldn't affect the physical button operation
> > at all, if it's really wired to the PMIC as the signal name implies.
> > There isn't even any default pull value associated with the TSHUT pin
> > config.
> 
> On a second thought, I've got another hypothesis. Your baseboard only
> pulls the reset line through  a 100 Ohm resistor when the button is
> pressed. So if the TSHUT pin is in its default push-pull mode and
> stays high when no thermal runaway reset is requested, the reset
> button won't pull the line fully to zero, as the TSHUT line pulls it
> high at the same time.

That's the most likely cause, I agree.

> If you switch it from &tsadc_shut_org to &tsadc_shut, then it stops
> working properly as the thermal protection reset, and GPIO0_A1 remains
> high-impendance, thus allowing the reset button to function even
> though its pull is too weak.

By the way, what is the difference between tsadc_shut_org and tsadc_shut
? I haven't seen it being clearly documented in the TRM.

> So maybe change the pin configuration of &tsadc_shut_org in
> rk3588-base-pinctrl.dtsi to open drain and retry?

That's a good idea, but... how ? The pinctrl-rockchip driver doesn't
seem to support generic open-drain configuration.

-- 
Regards,

Laurent Pinchart

