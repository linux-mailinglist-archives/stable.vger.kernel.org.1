Return-Path: <stable+bounces-110374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EBAA1B345
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 11:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6796B7A2DCF
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33821A422;
	Fri, 24 Jan 2025 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="TcGThC+G"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA91B87C3;
	Fri, 24 Jan 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737713212; cv=none; b=tIe7UxFXHWAP8bQoupQiX/OrP7Pd+K58YsOkGCboKhBbRoiQNyEhzXegCe1b0dwNhB9h3U4cOnFqnopuLelyMfsXidvKw3Yy79plFtvWPP+9FezGVi3YHeSI9+SKdpeZNM+Egwb3/SkQ6B1B6UTILRNkGV41WMyjiCkR4HmrIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737713212; c=relaxed/simple;
	bh=a2RpuIR8Z45DeYLYN8YY8l5drejZaIiOyjQ77ZA1v/4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DKbNIH/N6klu+YZ7Ud817SaGmp25oJY3DhvTTHHoDXrwzBiaOw7lx7pj0Vy3IX4NuSdVxJXA6cLewCnYfj99t/6WrZ5J30alPghccuYusfPxmDSYCfeL3rlqVTedHDbb/n0fZHY4reKqCTOe5hUah14cSLOhuqa01eRh7xisZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=TcGThC+G; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1737713208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKwdTEzM5lSaWxcEJQL3dOATIOQEUYkzh3DpFXffH58=;
	b=TcGThC+GsdFJdZ4xP0tnYgTpMftKU8XSefORI5jxJhNQJJ4GvobaG+aC2S3tdNNGn8hrIJ
	x/Mdi7Eqe7IILPSprRDF6ERrdTwuod+ApSMBhCxcYb50PhnjwzF4YnuDCLoY/F/u0IG/+v
	5dxdcWnuPslFwrEH6o3YsCtYreBE3K23h1/WpoECGE/5t7wdWds6PqZXOPShJSffQ9b8gK
	iaKsB85Ul3uglAtYsTDyhbibr7X1azgjlsuPuSTDuWPTnR2ZZKjM4wgHqB2ME0LxZUcm7h
	7Udp5m5xw07iGmFXgwmHLG8EWdy/kR+i2OqaitqILv4u2cwZuD+JM6l8pqkbEg==
Date: Fri, 24 Jan 2025 11:06:47 +0100
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
In-Reply-To: <CABjd4YwA8P9LVuDviO6xydkHpuuOY7XT0pk1oa+FDqOo=uZN4A@mail.gmail.com>
References: <20250124052611.3705-1-eagle.alexander923@gmail.com>
 <CABjd4YwA8P9LVuDviO6xydkHpuuOY7XT0pk1oa+FDqOo=uZN4A@mail.gmail.com>
Message-ID: <a76f315f023a3f8f5435e0681119b4eb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2025-01-24 09:33, Alexey Charkov wrote:
> On Fri, Jan 24, 2025 at 9:26 AM Alexander Shiyan
> <eagle.alexander923@gmail.com> wrote:
>> 
>> There is no pinctrl "gpio" and "otpout" (probably designed as 
>> "output")
>> handling in the tsadc driver.
>> Let's use proper binding "default" and "sleep".
> 
> This looks reasonable, however I've tried it on my Radxa Rock 5C and
> the driver still doesn't claim GPIO0 RK_PA1 even with this change. As
> a result, a simulated thermal runaway condition (I've changed the
> tshut temperature to 65000 and tshut mode to 1) doesn't trigger a PMIC
> reset, even though a direct `gpioset 0 1=0` does.
> 
> Are any additional changes needed to the driver itself?

I've been digging through this patch the whole TSADC/OTP thing in the
last couple of hours, and AFAIK some parts of the upstream driver are
still missing, in comparison with the downstream driver.

I've got some small suggestions for the patch itself, but the issue
you observed is obviously of higher priority, and I've singled it out
as well while digging through the code.

Could you, please, try the patch below quickly, to see is it going to
fix the issue you observed?  I've got some "IRL stuff" to take care of
today, so I can't test it myself, and it would be great to know is it
the right path to the proper fix.

diff --git i/drivers/thermal/rockchip_thermal.c 
w/drivers/thermal/rockchip_thermal.c
index f551df48eef9..62f0e14a8d98 100644
--- i/drivers/thermal/rockchip_thermal.c
+++ w/drivers/thermal/rockchip_thermal.c
@@ -1568,6 +1568,11 @@ static int rockchip_thermal_probe(struct 
platform_device *pdev)
         thermal->chip->initialize(thermal->grf, thermal->regs,
                                   thermal->tshut_polarity);

+       if (thermal->tshut_mode == TSHUT_MODE_GPIO)
+               pinctrl_select_default_state(dev);
+       else
+               pinctrl_select_sleep_state(dev);
+
         for (i = 0; i < thermal->chip->chn_num; i++) {
                 error = rockchip_thermal_register_sensor(pdev, thermal,
                                                 &thermal->sensors[i],

If you could test it, please, it would be great, and I'd prepare the
proper patch tomorrow or so.

