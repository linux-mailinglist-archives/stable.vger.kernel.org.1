Return-Path: <stable+bounces-110378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E886A1B3B4
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 11:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848C71888961
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 10:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F6C1CDFC1;
	Fri, 24 Jan 2025 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="O0C1Z+uk"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BAC23B0;
	Fri, 24 Jan 2025 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737715521; cv=none; b=hZJoty0Wfw3bDL7gkpSDBL0kVZ0EC6C11msySIF9EkAoDKm0AcOycsanigzY8R+D7f41bFQ7jflTJuhauGMfUq5d8Vec/dnS/OOZTknONRt7LXdEWybDZ2qDG0xqCgThVNdHiJcvrD/JBE3jvpCmEIm/giEsNaBfSzMSLx5ouF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737715521; c=relaxed/simple;
	bh=UU1D6cLtnNXp1L6yKtrPmNZ2coL0AbJ00Jt9qKxE+hY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gc3TpV2+8RWPofs+LXcCG8kPAxjscQnbjcYfre4lOBaPF3NjBdF5zDUIJT9ksvCLU46GhqMf9R9dlhZ7UFgunFlzO+hiPWdM7XYI9xN8uCmoKsij1+5Y6zlPZGU09BMSUIl67C9yrH9FSstMZSwEeAV7mjDqLYRD9dH2p3hMK+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=O0C1Z+uk; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1737715517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjhryoFxs8c1/zbPEqglA2ihRcdYXJLFxUAIwp/GWlA=;
	b=O0C1Z+ukiA/GBNKIKb7QiaebB/oX8/9TyasBTQkie/GY6B9toAGa9YfndGBpKWWdII1qiA
	icN2t8WbhaZuojCcoJ9ExhKI0mgTKghiKcCSQQsx/ExkXBHpQ3VL61Bm5yWsfIoIUdndNX
	JJyIl8dFszNudd4tSOs145pa/rRlkolsdsKKLQDu82A7BsNxiFLdyauIDmF2ZEE6v1R3KJ
	pmcoRnH0ZhB98NrD8gEelGFC2x/WMSX31/Lvw9zHWe1UH+qtmuc3V1kqA2Se/SpUnh7Osn
	ndY9w3S93zbFIdn+kYEnUC02r0D5wDD0vXm/egp4Qcfh5i6j+sycOllEv9faQw==
Date: Fri, 24 Jan 2025 11:45:17 +0100
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
In-Reply-To: <61b494b209d7360d0f36adbf6d5443a4@manjaro.org>
References: <20250124052611.3705-1-eagle.alexander923@gmail.com>
 <CABjd4YwA8P9LVuDviO6xydkHpuuOY7XT0pk1oa+FDqOo=uZN4A@mail.gmail.com>
 <a76f315f023a3f8f5435e0681119b4eb@manjaro.org>
 <CABjd4Ywh_AkbXHonx-8vL-hNY5LMLJge5e4oqxvUG+qe6OF-Og@mail.gmail.com>
 <61b494b209d7360d0f36adbf6d5443a4@manjaro.org>
Message-ID: <99f5fca6e9778e20287d807d1830b7a2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2025-01-24 11:37, Dragan Simic wrote:
> On 2025-01-24 11:25, Alexey Charkov wrote:
>> On Fri, Jan 24, 2025 at 2:06 PM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>>> On 2025-01-24 09:33, Alexey Charkov wrote:
>>> > On Fri, Jan 24, 2025 at 9:26 AM Alexander Shiyan
>>> > <eagle.alexander923@gmail.com> wrote:
>>> >>
>>> >> There is no pinctrl "gpio" and "otpout" (probably designed as
>>> >> "output")
>>> >> handling in the tsadc driver.
>>> >> Let's use proper binding "default" and "sleep".
>>> >
>>> > This looks reasonable, however I've tried it on my Radxa Rock 5C and
>>> > the driver still doesn't claim GPIO0 RK_PA1 even with this change. As
>>> > a result, a simulated thermal runaway condition (I've changed the
>>> > tshut temperature to 65000 and tshut mode to 1) doesn't trigger a PMIC
>>> > reset, even though a direct `gpioset 0 1=0` does.
>>> >
>>> > Are any additional changes needed to the driver itself?
>>> 
>>> I've been digging through this patch the whole TSADC/OTP thing in the
>>> last couple of hours, and AFAIK some parts of the upstream driver are
>>> still missing, in comparison with the downstream driver.
>>> 
>>> I've got some small suggestions for the patch itself, but the issue
>>> you observed is obviously of higher priority, and I've singled it out
>>> as well while digging through the code.
>>> 
>>> Could you, please, try the patch below quickly, to see is it going to
>>> fix the issue you observed?  I've got some "IRL stuff" to take care 
>>> of
>>> today, so I can't test it myself, and it would be great to know is it
>>> the right path to the proper fix.
>>> 
>>> diff --git i/drivers/thermal/rockchip_thermal.c
>>> w/drivers/thermal/rockchip_thermal.c
>>> index f551df48eef9..62f0e14a8d98 100644
>>> --- i/drivers/thermal/rockchip_thermal.c
>>> +++ w/drivers/thermal/rockchip_thermal.c
>>> @@ -1568,6 +1568,11 @@ static int rockchip_thermal_probe(struct
>>> platform_device *pdev)
>>>          thermal->chip->initialize(thermal->grf, thermal->regs,
>>>                                    thermal->tshut_polarity);
>>> 
>>> +       if (thermal->tshut_mode == TSHUT_MODE_GPIO)
>>> +               pinctrl_select_default_state(dev);
>>> +       else
>>> +               pinctrl_select_sleep_state(dev);
>> 
>> I believe no 'else' block is needed here, because if tshut_mode is not
>> TSHUT_MODE_GPIO then the TSADC doesn't use this pin at all, so there's
>> no reason for the driver to mess with its pinctrl state. I'd rather
>> put a mirroring block to put the pin back to its 'sleep' state in the
>> removal function for the TSHUT_MODE_GPIO case.
> 
> You're right, but the "else block" is what the downstream driver does,
> so I think it's better to simply stay on the safe side and follow that
> logic in the upstream driver.  Is it really needed?  Perhaps not, but
> it also shouldn't hurt.
> 
>> Will try and revert.
> 
> Awesome, thanks!

Actually...  Revert or report? :)

>> P.S. Just looked at the downstream driver, and it actually calls
>> TSHUT_MODE_GPIO TSHUT_MODE_OTP instead, so it seems that "otpout" was
>> not a typo in the first place. So maybe the right approach here is not
>> to change the device tree but rather fix the "gpio" / "otpout" pinctrl
>> state handling in the driver.
> 
> Indeed, "otpout" wasn't a typo, and I've already addressed that in my
> comments to Alexander's patch.  Will send that response a bit later.
> 
> I think it's actually better to accept the approach in Alexander's
> patch, because the whole thing applies to other Rockchip SoCs as well,
> not just to the RK3588(S).

