Return-Path: <stable+bounces-189750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E77C0A00B
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 23:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 833AA34CCD5
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B25B2798F3;
	Sat, 25 Oct 2025 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="YEASFOKR"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEE41917CD;
	Sat, 25 Oct 2025 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426213; cv=none; b=fqW5vQ17tu3p0suUAdtv+N43iJ/JNrQOReIgIC71W6ot/nWbgk4ezBwZrHbEM9Xv0QWSdCBLuRE8pdEpuVQOvkw451buWJSBIJkEwIHMzZNcYROcggTtOCfrvmrOgWZhVl66ywtcO2LD5W3OHQriGA2IYKuYOB3ZOLO6ZO0UfnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426213; c=relaxed/simple;
	bh=cURQFyyz2SwSVaPXae8hjd6zYbI/epcdwKmNP0WhfjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNeLcyzmUMr2HVo6m4Qm7oPwlNk2OALLD/ezMhLDe0/0XGUwbAEFKYfQB7iKHBVL4/LHakydlMW3xGXXlMd8/mtk1aZ1aJ0OP6lQiQZak7G4qhll8S/aA0d62iJLqW+E7x2/q4BvwAO1JKxrrIRyRH453gJWmdlL3gppuPJj7tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=YEASFOKR; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=UPmSx/rC/bLVWOw7yLLlRYHnQQ8/QE5D94ipJ1ensxQ=; b=YEASFOKREVuSgjHgpy0Y2dRBS3
	s82bVK4joK0JDK3UxqW/p4Y+wOnrE1Z/gZ1xovq/jEE/iWp2erD6477NYCnkHkJhntAkS7Xt/sWMk
	eqxQiHLMv5qgMYH3W+UKGZo9GMivQN0gpIxjon1UaOBTeHvm0QeoPdAbfILHltsECucUdEzwREHmg
	j8wL8BOvlHlTE8ksd5mOq1Wej4mYpIPWPCaeVhwgjWdwSx2nGgrJKXr82Txtqu955ouA+BaqOcdcf
	ZsCwQgQqzoBHmD2rGpH8r/7GmVwM6Q+SssAZ6LxkeYciepqmsKAMgMjs0a0EiDppethbe3IHQ/XSC
	MKArByuA==;
Received: from i53875aba.versanet.de ([83.135.90.186] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vClPs-0005MZ-EF; Sat, 25 Oct 2025 23:03:12 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Coia Prant <coiaprant@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Coia Prant <coiaprant@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add devicetree for the X3568 v4
Date: Sat, 25 Oct 2025 23:03:11 +0200
Message-ID: <2940731.88bMQJbFj6@phil>
In-Reply-To: <20251025203711.3859240-1-coiaprant@gmail.com>
References: <20251025203711.3859240-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

general comments, I haven't disected the devicetrees yet.


Am Samstag, 25. Oktober 2025, 22:37:11 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Coia Prant:

Please also provide some description what type of board this is,
not just a list of specs

> Specification:
> - SoC: RockChip RK3568 ARM64 (4 cores)
> - eMMC: 16-128 GB
> - RAM: 2-8 GB
> - Power: DC 12V 2A
> - Ethernet: 2x YT8521SC RGMII (10/100/1000 Mbps)
> - Wireless radio: 802.11b/g/n/ac/ax dual-band
> - LED:
>   Power: AlwaysOn
>   User: GPIO
> - Button:
>   VOL+: SARADC/0 <35k =C2=B5V>
>   VOL-: SARADC/0 <450k =C2=B5V>
>   Power/Reset: PMIC RK809
> - CAN
>   CAN/1: 4-pin (PH 2.0)
> - PWM
>   PWM/4: Backlight DSI/0 DSI/1
>   PWM/7: IR Receiver [may not install]
> - UART:
>   UART/2: Debug TTL - 1500000 8N1 (1.25mm)
>   UART/3: TTL (PH 2.0)
>   UART/4: TTL (PH 2.0)
>   UART/8: AP6275S Bluetooth
>   UART/9: TTL (PH 2.0)
> - I2C:
>   I2C/0: PMIC RK809
>   I2C/1: Touchscreen DSI/0 DSI/1
>   I2C/4: Camera
>   I2C/5: RTC@51 PCF8563
> - I2S:
>   I2S/0: miniHDMI Sound
>   I2S/1: RK809 Audio Codec
>   I2S/3: AP6275S Bluetooth Sound
> - SDMMC:
>   SDMMC/0: microSD (TF) slot
>   SDMMC/2: AP6275S SDIO WiFi card
> - Camera: 1x CSI
> - Video: miniHDMI / DSI0 (MIPI/LVDS) / DSI1 (MIPI/EDP)
> - Audio: miniHDMI / MIC on-board / Speaker / SPDIF / 3.5mm Headphones / A=
P6275S Bluetooth
> - USB:
>   USB 2.0 HOST x2
>   USB 2.0 HOST x3 (4-pin)
>   USB 2.0 OTG x1 (shared with USB 3.0 OTG/HOST) [slot may not install]
>   USB 3.0 HOST x1
>   USB 3.0 OTG/HOST x1
> - SATA: 1x SATA 3.0 with Power/4-pin [slot may not install]
> - PCIe: 1x PCIe 3.0 x2 (x4 connecter) [clock/slot may not install]
>=20
> Link:
> - https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D=
%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf
> - https://blog.gov.cooking/archives/research-ninetripod-x3568-v4-and-flas=
h.html

2nd link ends in a 404 error, page not found


> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> Tested-by: Coia Prant <coiaprant@gmail.com>


When you submit a patch, we expect you to have tested it, so tere
is no need to have a separate tested-by line :-) .


> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |  11 +
>  .../rockchip/rk3568-x3568-camera-demo.dtso    |  82 ++
>  .../boot/dts/rockchip/rk3568-x3568-v4.dts     | 884 ++++++++++++++++++
>  .../dts/rockchip/rk3568-x3568-video-demo.dtso | 141 +++

please name your boards including the ninetree name, because x3568 is way
too generic, so
rk3568-ninetree-x3568 .....

Additionally, from that PDF above, it seems this is a system-on-module?
X3568CV2 + baseboard? If so, please split this into a dtsi + dts.
See all the other system-on-modules for reference.

Additionally, you'll need to have a 2nd patch to add the board to
Documentation/devicetree/bindings/arm/rockchip.yaml

And also possily a 3rd patch to add ninetree to
Documentation/devicetree/bindings/vendor-prefixes.yaml


Heiko



