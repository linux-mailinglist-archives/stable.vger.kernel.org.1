Return-Path: <stable+bounces-183226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FE4BB705D
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 15:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5528E188D843
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7946D1F03D7;
	Fri,  3 Oct 2025 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ua+yTS4T"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3421EE7DC;
	Fri,  3 Oct 2025 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498395; cv=none; b=u5AKfqolZcrbIPceEpWtMG9+ECRPqygF7+UvUfPnFWEZwupMWabEdYLti3Nh6GOKkTBUnRACAHYcJ5Rdm5Amyh7kMF56xVyuBWLsSISYTNyRuiVyhphjFdkTdXE1++6xrzgFR2WXxu9gT7v2HYh6vTAqBYJGXxAlnL0xnmeCXB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498395; c=relaxed/simple;
	bh=Irk3t8nFf/aTjQgzWVzYN3awPzS0XCH6TsYfkakhoLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzwhoH0/K8t8yD7mxEgGG0QGqHC8kBgjx5UhZnJ6XeIU8SfmIZYa2nE5luoGhd/mpYEFwAUbxpD+vFrLi/fNh4QmrZxnfr7DflDGFYJx7eRKI51L1G1OyG2KieYBAJZpmqNuq+Ovy/U/Z6YvsJSNhFsMnLBf8r0W01YIYcYLaWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Ua+yTS4T; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id CB8F9C7A;
	Fri,  3 Oct 2025 15:31:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759498300;
	bh=Irk3t8nFf/aTjQgzWVzYN3awPzS0XCH6TsYfkakhoLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ua+yTS4T0diRNc63DUkdB+LhCgfV2OdWzdxJF0mw/3otgBNiyn7ImWxMVwpEL+0jk
	 kK/DvPkw27Sb2GR9R9qaDagCbn9ls8b4noWH8JPhjuiZypsf2lwGVTqTkSXt+s8rms
	 du6BDxr/KKuBQCSVtZ5G8vMpcXhao8Ca2ZU+DcAc=
Date: Fri, 3 Oct 2025 16:33:04 +0300
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
Message-ID: <20251003133304.GA21023@pendragon.ideasonboard.com>
References: <20250124052611.3705-1-eagle.alexander923@gmail.com>
 <CABjd4YwA8P9LVuDviO6xydkHpuuOY7XT0pk1oa+FDqOo=uZN4A@mail.gmail.com>
 <a76f315f023a3f8f5435e0681119b4eb@manjaro.org>
 <CABjd4Ywh_AkbXHonx-8vL-hNY5LMLJge5e4oqxvUG+qe6OF-Og@mail.gmail.com>
 <61b494b209d7360d0f36adbf6d5443a4@manjaro.org>
 <CABjd4Yx0p0B=e00MjCpDDq8Z=0FtM0s9EN86WdvRimt-_+kh2w@mail.gmail.com>
 <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com>

On Fri, Jan 24, 2025 at 11:44:34PM +0400, Alexey Charkov wrote:
> On Fri, Jan 24, 2025 at 9:23 PM Alexey Charkov <alchark@gmail.com> wrote:
> > On Fri, Jan 24, 2025 at 2:37 PM Dragan Simic <dsimic@manjaro.org> wrote:
> > > On 2025-01-24 11:25, Alexey Charkov wrote:
> > > > On Fri, Jan 24, 2025 at 2:06 PM Dragan Simic <dsimic@manjaro.org>
> > > > wrote:
> > > >> On 2025-01-24 09:33, Alexey Charkov wrote:
> > > >> > On Fri, Jan 24, 2025 at 9:26 AM Alexander Shiyan
> > > >> > <eagle.alexander923@gmail.com> wrote:
> > > >> >>
> > > >> >> There is no pinctrl "gpio" and "otpout" (probably designed as
> > > >> >> "output")
> > > >> >> handling in the tsadc driver.
> > > >> >> Let's use proper binding "default" and "sleep".
> > > >> >
> > > >> > This looks reasonable, however I've tried it on my Radxa Rock 5C and
> > > >> > the driver still doesn't claim GPIO0 RK_PA1 even with this change. As
> > > >> > a result, a simulated thermal runaway condition (I've changed the
> > > >> > tshut temperature to 65000 and tshut mode to 1) doesn't trigger a PMIC
> > > >> > reset, even though a direct `gpioset 0 1=0` does.
> > > >> >
> > > >> > Are any additional changes needed to the driver itself?
> > > >>
> > > >> I've been digging through this patch the whole TSADC/OTP thing in the
> > > >> last couple of hours, and AFAIK some parts of the upstream driver are
> > > >> still missing, in comparison with the downstream driver.
> > > >>
> > > >> I've got some small suggestions for the patch itself, but the issue
> > > >> you observed is obviously of higher priority, and I've singled it out
> > > >> as well while digging through the code.
> > > >>
> > > >> Could you, please, try the patch below quickly, to see is it going to
> > > >> fix the issue you observed?  I've got some "IRL stuff" to take care of
> > > >> today, so I can't test it myself, and it would be great to know is it
> > > >> the right path to the proper fix.
> > > >>
> > > >> diff --git i/drivers/thermal/rockchip_thermal.c
> > > >> w/drivers/thermal/rockchip_thermal.c
> > > >> index f551df48eef9..62f0e14a8d98 100644
> > > >> --- i/drivers/thermal/rockchip_thermal.c
> > > >> +++ w/drivers/thermal/rockchip_thermal.c
> > > >> @@ -1568,6 +1568,11 @@ static int rockchip_thermal_probe(struct
> > > >> platform_device *pdev)
> > > >>          thermal->chip->initialize(thermal->grf, thermal->regs,
> > > >>                                    thermal->tshut_polarity);
> > > >>
> > > >> +       if (thermal->tshut_mode == TSHUT_MODE_GPIO)
> > > >> +               pinctrl_select_default_state(dev);
> > > >> +       else
> > > >> +               pinctrl_select_sleep_state(dev);
> > > >
> > > > I believe no 'else' block is needed here, because if tshut_mode is not
> > > > TSHUT_MODE_GPIO then the TSADC doesn't use this pin at all, so there's
> > > > no reason for the driver to mess with its pinctrl state. I'd rather
> > > > put a mirroring block to put the pin back to its 'sleep' state in the
> > > > removal function for the TSHUT_MODE_GPIO case.
> > >
> > > You're right, but the "else block" is what the downstream driver does,
> >
> > Does it though? It only handles the TSHUT_MODE_GPIO case as far as I
> > can tell (or TSHUT_MODE_OTP in downstream driver lingo) [1]
> >
> > [1] https://github.com/radxa/kernel/blob/edb3eeeaa4643ecac6f4185d6d391c574735fca1/drivers/thermal/rockchip_thermal.c#L2564
> >
> > > so I think it's better to simply stay on the safe side and follow that
> > > logic in the upstream driver.  Is it really needed?  Perhaps not, but
> > > it also shouldn't hurt.
> > >
> > > > Will try and revert.
> > >
> > > Awesome, thanks!
> > >
> > > > P.S. Just looked at the downstream driver, and it actually calls
> > > > TSHUT_MODE_GPIO TSHUT_MODE_OTP instead, so it seems that "otpout" was
> > > > not a typo in the first place. So maybe the right approach here is not
> > > > to change the device tree but rather fix the "gpio" / "otpout" pinctrl
> > > > state handling in the driver.
> > >
> > > Indeed, "otpout" wasn't a typo, and I've already addressed that in my
> > > comments to Alexander's patch.  Will send that response a bit later.
> > >
> > > I think it's actually better to accept the approach in Alexander's
> > > patch, because the whole thing applies to other Rockchip SoCs as well,
> > > not just to the RK3588(S).
> >
> > Anyway, I've just tried it after including the changes below, and
> > while /sys/kernel/debug/pinctrl/pinctrl-handles shows the expected
> > pinctrls under tsadc, the driver still doesn't seem to be triggering a
> > PMIC reset. Weird. Any thoughts welcome.
> 
> I found the culprit. "otpout" (or "default" if we follow Alexander's
> suggested approach) pinctrl state should refer to the &tsadc_shut_org
> config instead of &tsadc_shut - then the PMIC reset works.

I've recently brought up an RK3588S-based Orange Pi CM5 Base board, made
of a compute module (CM5, see [1]) and a carrier board (Base, see [2]).
The carrier board has a reset button which pulls the PMIC_RESET_L signal
of the CM5 to GND (see page 3 of the schematics in [3]).

With &tsadc_shut_org the reset button has absolutely no effect. With
&tsadc_shut it resets the board as expected.

Unfortunately the schematics of the CM5 is not available so it's not
immediately clear what the reset button is connected exactly. The same
manufacturer sells another board based on the same SoC, the Orange Pi 5B
([4]) whose full schematics is available ([5]). The board also has a
reset button pulling a PMIC_RESET_L signal to GND. The signal is pulled
up to VCC_1V8_S3 and connected to

- RESETB on the PMIC
- NPOR on the RK3588S
- TSADC_SHUT (GPIO0_A1) on the RK3588S

[1] http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-CM5.html
[2] http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-CM5-Board.html
[3] https://drive.google.com/file/d/1t4WmXGWed8NnS0m2PWE7p5YLiR1dbnvP/view
[4] http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-5B.html
[5] https://drive.google.com/file/d/19iPdpAXhA1vFkVOgG5Sz7L6cV8BB6004/view

-- 
Regards,

Laurent Pinchart

