Return-Path: <stable+bounces-189761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D9EC0A4B2
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 09:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD0B18A0706
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 08:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3646726D4C2;
	Sun, 26 Oct 2025 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ8fER3V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE8C16132F;
	Sun, 26 Oct 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761467818; cv=none; b=L9kOYkT0NQmKNzAuUTIYNYs4jMRPDCnipblnfMBE112teSxKJeT5kUDyrSMHt2MI6IW3h7Sht6EEIvUReyY5iDWlnPA0Fp/zmpwmdbRUDWPV3q02U6pWoFHqN6t7cCQ7UFSgOTyZqx7W5Fmp5Oad9L1OF2Z0tnUMNl1pAtQs0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761467818; c=relaxed/simple;
	bh=Zim3qGKsCpC2JYTbatO+MU+Eu3vnLSQRr1CABozWbcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUEz8rZh+620A0QT63Yc64WfjxyVyN5FRIMf5DGig7s7eMD/4kEB3VykfwulAVx5rXNqWwz3P+Xv4kHpD/ltvEtUALXek/qMHVIUC8H1sWclRF9gjJjbVTyAxuwLuOcXz3FFv6PdMeuZ4LkJ1uyHPxDr7nWALkpvTMa+/arhfIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ8fER3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15A8C4CEE7;
	Sun, 26 Oct 2025 08:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761467817;
	bh=Zim3qGKsCpC2JYTbatO+MU+Eu3vnLSQRr1CABozWbcM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XZ8fER3VQro4Ggyjf1AxjtI4qhktJF7hl645sn4jiLi+1xu3Rb9pzKp/rIr97TiHP
	 BXANLH2pvo21B8amxi23knLJGukH5FivnQCN4NQ4i25bcawBkJ1L0whBCZtKrVCW1N
	 51JGD5K3vtuFWAGAJ2A9CzHXQqBddNEwJbaHV+JqfzHCEZJO8E0ORSpAxy4kunFnCL
	 K0x0UouQeLhvVStmfrDr43WLhjhmDHV3JMupBziOky08nQAMsUxnhpg6lO/4J/hzL9
	 BKN621dXHnwBGryWBmLsvgoTz8CMc2IabBNX55YRnpxHbj8uCk+JNilSRrryrOMoYJ
	 Vy49jOFYQ+0eg==
Message-ID: <b4395d23-9004-4a01-942f-060876312317@kernel.org>
Date: Sun, 26 Oct 2025 09:36:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add devicetree for the
 NineTripod X3568 v4
To: Coia Prant <coiaprant@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251026062831.4045083-3-coiaprant@gmail.com>
 <20251026062831.4045083-7-coiaprant@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251026062831.4045083-7-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/10/2025 07:28, Coia Prant wrote:
> The NineTripod X3568 v4 is an RK3568-based SBC, just like the RK3568-EVB.
> It always uses soldered connections between the X3568CV2 core board and the X3568bv4 IO board.
> 
> The X3568 board has multiple hardware revisions, and we currently support v4.
> 
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
>   VOL+: SARADC/0 <35k µV>
>   VOL-: SARADC/0 <450k µV>
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
> - Audio: miniHDMI / MIC on-board / Speaker / SPDIF / 3.5mm Headphones / AP6275S Bluetooth
> - USB:
>   USB 2.0 HOST x2
>   USB 2.0 HOST x3 (4-pin)
>   USB 2.0 OTG x1 (shared with USB 3.0 OTG/HOST) [slot may not install]
>   USB 3.0 HOST x1
>   USB 3.0 OTG/HOST x1
> - SATA: 1x SATA 3.0 with Power/4-pin [slot may not install]
> - PCIe: 1x PCIe 3.0 x2 (x4 connecter) [clock/slot may not install]
> 
> Link:
> - https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf
> - https://blog.gov.cooking/archives/research-ninetripod-x3568-v4-and-flash.html
> 
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> Cc: stable@vger.kernel.org


While adding vendor prefix could fall into adding quirks (it's not...),
but how is new support supposed to be bugfix or quirk?

That's definitely not right.


Best regards,
Krzysztof

