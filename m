Return-Path: <stable+bounces-110442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B391A1C669
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 07:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE9F3A831B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 06:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B651244C7C;
	Sun, 26 Jan 2025 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="BoSYA+YN"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D9433CE;
	Sun, 26 Jan 2025 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737871834; cv=none; b=K0KH/ZWNNagqcDQVB0PFaIsf/hvvDWpokB8ywTr+hCZ0m5pJXe609tmgl43IM6eARI2W5d8ZzatRa15NgZJ2EK5o0kKi0vyyihTpIXFxCBNDS6dRtE8liz08cB5NEdAurVDX7nNYbKlPFrNjlQsJV5h7xQMRS8U2N/NOuEUUwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737871834; c=relaxed/simple;
	bh=Dg9hTwzDKC3lcngdjYoy+m6pN3yMd5ZfDcbRo9fdDpo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IOFH5BeS8QjHUKyjppERksOxBVBcwZFEckFbWoz/hXLG1bj8sOk0/cD3/7wJeqPz4/ld7aY0YYCw9w21ohR6/lRv/Zur4g20fZKJ9GWiW0yl9b2QwMWXDQANJXaOqMkGwYlNoE8N9QZpfK38rc6HX1FMg9BCN+aiJuTUCfBYosQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=BoSYA+YN; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1737871830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cElRMI26kDUSrPRrVyetsiiM/S0G4rSifs7vMEkuMyM=;
	b=BoSYA+YN8DT70FM/64U/Q+bBiO35QdHpf2DFaywph2W9xYyJWIts4K5wjUescUkk4usIm+
	TOoQzB/ftyB+qevWHicX1H8OmXRYYzI07gN7AnqLaUEgv4NMEddRPpZVyyN9VrYTmMKHwa
	30eFNwTpDdQCdKVlrG1lYKTVK54ryoEYagkqUqSXt/cU4sstvuzubBlEoOAaMb9REkr2eS
	BuwYrO57pnyBqlRdBwbJBTe1q8cnsXZ8RQAOOAUxAtMjDzBHLIvmKSRSTtvQ/N7E5um9pW
	Wd1OReYHbtLte7RXrw/IsWieNfQ9CT6mS0oaOO80UqYK+lwWulf2NuyxTxdY2g==
Date: Sun, 26 Jan 2025 07:10:30 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>, Rob Herring
 <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, devicetree@vger.kernel.org, Sebastian Reichel
 <sebastian.reichel@collabora.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix broken tsadc pinctrl binding
 for rk3588
In-Reply-To: <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com>
References: <20250124052611.3705-1-eagle.alexander923@gmail.com>
 <CABjd4YwA8P9LVuDviO6xydkHpuuOY7XT0pk1oa+FDqOo=uZN4A@mail.gmail.com>
 <a76f315f023a3f8f5435e0681119b4eb@manjaro.org>
 <CABjd4Ywh_AkbXHonx-8vL-hNY5LMLJge5e4oqxvUG+qe6OF-Og@mail.gmail.com>
 <61b494b209d7360d0f36adbf6d5443a4@manjaro.org>
 <CABjd4Yx0p0B=e00MjCpDDq8Z=0FtM0s9EN86WdvRimt-_+kh2w@mail.gmail.com>
 <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com>
Message-ID: <5bfe48fd72e2a82f5b2d8b00d8a79d35@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2025-01-24 20:44, Alexey Charkov wrote:
> On Fri, Jan 24, 2025 at 9:23 PM Alexey Charkov <alchark@gmail.com> 
> wrote:
>> On Fri, Jan 24, 2025 at 2:37 PM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>> > On 2025-01-24 11:25, Alexey Charkov wrote:
>> > > On Fri, Jan 24, 2025 at 2:06 PM Dragan Simic <dsimic@manjaro.org>
>> > > wrote:
>> > >> On 2025-01-24 09:33, Alexey Charkov wrote:
>> > >> > On Fri, Jan 24, 2025 at 9:26 AM Alexander Shiyan
>> > >> > <eagle.alexander923@gmail.com> wrote:
>> > >> >>
>> > >> >> There is no pinctrl "gpio" and "otpout" (probably designed as
>> > >> >> "output")
>> > >> >> handling in the tsadc driver.
>> > >> >> Let's use proper binding "default" and "sleep".
>> > >> >
>> > >> > This looks reasonable, however I've tried it on my Radxa Rock 5C and
>> > >> > the driver still doesn't claim GPIO0 RK_PA1 even with this change. As
>> > >> > a result, a simulated thermal runaway condition (I've changed the
>> > >> > tshut temperature to 65000 and tshut mode to 1) doesn't trigger a PMIC
>> > >> > reset, even though a direct `gpioset 0 1=0` does.
>> > >> >
>> > >> > Are any additional changes needed to the driver itself?
>> > >>
>> > >> I've been digging through this patch the whole TSADC/OTP thing in the
>> > >> last couple of hours, and AFAIK some parts of the upstream driver are
>> > >> still missing, in comparison with the downstream driver.
>> > >>
>> > >> I've got some small suggestions for the patch itself, but the issue
>> > >> you observed is obviously of higher priority, and I've singled it out
>> > >> as well while digging through the code.
>> > >>
>> > >> Could you, please, try the patch below quickly, to see is it going to
>> > >> fix the issue you observed?  I've got some "IRL stuff" to take care of
>> > >> today, so I can't test it myself, and it would be great to know is it
>> > >> the right path to the proper fix.
>> > >>
>> > >> diff --git i/drivers/thermal/rockchip_thermal.c
>> > >> w/drivers/thermal/rockchip_thermal.c
>> > >> index f551df48eef9..62f0e14a8d98 100644
>> > >> --- i/drivers/thermal/rockchip_thermal.c
>> > >> +++ w/drivers/thermal/rockchip_thermal.c
>> > >> @@ -1568,6 +1568,11 @@ static int rockchip_thermal_probe(struct
>> > >> platform_device *pdev)
>> > >>          thermal->chip->initialize(thermal->grf, thermal->regs,
>> > >>                                    thermal->tshut_polarity);
>> > >>
>> > >> +       if (thermal->tshut_mode == TSHUT_MODE_GPIO)
>> > >> +               pinctrl_select_default_state(dev);
>> > >> +       else
>> > >> +               pinctrl_select_sleep_state(dev);
>> > >
>> > > I believe no 'else' block is needed here, because if tshut_mode is not
>> > > TSHUT_MODE_GPIO then the TSADC doesn't use this pin at all, so there's
>> > > no reason for the driver to mess with its pinctrl state. I'd rather
>> > > put a mirroring block to put the pin back to its 'sleep' state in the
>> > > removal function for the TSHUT_MODE_GPIO case.
>> >
>> > You're right, but the "else block" is what the downstream driver does,
>> 
>> Does it though? It only handles the TSHUT_MODE_GPIO case as far as I
>> can tell (or TSHUT_MODE_OTP in downstream driver lingo) [1]
>> 
>> [1] 
>> https://github.com/radxa/kernel/blob/edb3eeeaa4643ecac6f4185d6d391c574735fca1/drivers/thermal/rockchip_thermal.c#L2564
>> 
>> > so I think it's better to simply stay on the safe side and follow that
>> > logic in the upstream driver.  Is it really needed?  Perhaps not, but
>> > it also shouldn't hurt.
>> >
>> > > Will try and revert.
>> >
>> > Awesome, thanks!
>> >
>> > > P.S. Just looked at the downstream driver, and it actually calls
>> > > TSHUT_MODE_GPIO TSHUT_MODE_OTP instead, so it seems that "otpout" was
>> > > not a typo in the first place. So maybe the right approach here is not
>> > > to change the device tree but rather fix the "gpio" / "otpout" pinctrl
>> > > state handling in the driver.
>> >
>> > Indeed, "otpout" wasn't a typo, and I've already addressed that in my
>> > comments to Alexander's patch.  Will send that response a bit later.
>> >
>> > I think it's actually better to accept the approach in Alexander's
>> > patch, because the whole thing applies to other Rockchip SoCs as well,
>> > not just to the RK3588(S).
>> 
>> Anyway, I've just tried it after including the changes below, and
>> while /sys/kernel/debug/pinctrl/pinctrl-handles shows the expected
>> pinctrls under tsadc, the driver still doesn't seem to be triggering a
>> PMIC reset. Weird. Any thoughts welcome.
> 
> I found the culprit. "otpout" (or "default" if we follow Alexander's
> suggested approach) pinctrl state should refer to the &tsadc_shut_org
> config instead of &tsadc_shut - then the PMIC reset works.

Huh, thanks for debugging, but this is quite confusing.  Let me dig
through everything again later today.

