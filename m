Return-Path: <stable+bounces-118521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17F3A3E696
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 22:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0347719C4CF4
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 21:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23397266F06;
	Thu, 20 Feb 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCETpwfu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7E926658F;
	Thu, 20 Feb 2025 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086963; cv=none; b=ksNMLWyVxzFcKFEnVmLYjt489aup/6bjHgPayM/oqvjTbwkMDSEy505CDzktuZiy6zzBAnTNjW+2Syfu1RM9HtD75HKFjyY5RkGfUTw/wNYFpwKAxDcuHx9PX9p0HrzTeTwXXSRoy+tiZqUtIWv922pI1X3I5Yq3sBmB/HXG96A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086963; c=relaxed/simple;
	bh=cPMXfJ5EEJSFIc6bQSSqwz/jzpiRbId88b5OIXw7akI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=UEL9TIxlFd+zASMyjxmVPQ1UxjQGcKynX1JRasQmHkJo7Mqkil2KI06zGhEyXXodc9tjBTJxsLsGK+pg0fxFh8jWrpp4oNJ48ZXtHHwYyRzgImDDVdOjy27j4tlaFfllsrh4kWv6ZYJs7s+B3pBrGb2DweGuQmKCbhh94U0Bov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCETpwfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8E1C4CED1;
	Thu, 20 Feb 2025 21:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740086963;
	bh=cPMXfJ5EEJSFIc6bQSSqwz/jzpiRbId88b5OIXw7akI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=WCETpwfuWJO0JWuzIGZRF7sywIRaqSi8e4WpC6+MQMO4xknZ5pLQgbxGDP9+o0I50
	 0R1myaQWgX2sy4QgviPM15qOeoc8s/lRu4+LK+KZsrDJoQFOrp0Tr3Y5aP2DoIhxQW
	 IOgax0/wXj9l4oYTD170yWmsniSod59ztndBZYgi1mrT/Wk0m07vx5Y10j9Kw4+WmI
	 aajGDGqdE/I2TYy/8uRorPwWQHSw5Y3PhcfsV8GvRraFJaw476eCd7j6EL+reXmbJX
	 4jXTaGQvwbwlqZlwak86fcxhfnVkZGK9PsZsHb1vy5gKnsB9pZyUnTzsOte6E8gqWm
	 38VW7E2NpUOzw==
Date: Thu, 20 Feb 2025 15:29:21 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 stable@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>
To: Quentin Schulz <foss+kernel@0leil.net>
In-Reply-To: <20250220-ringneck-dtbos-v1-0-25c97f2385e6@cherry.de>
References: <20250220-ringneck-dtbos-v1-0-25c97f2385e6@cherry.de>
Message-Id: <174008661935.4046882.3221866764998287397.robh@kernel.org>
Subject: Re: [PATCH 0/5] arm64: dts: rockchip: pinmux fixes and support for
 2 adapters for Theobroma boards


On Thu, 20 Feb 2025 13:20:09 +0100, Quentin Schulz wrote:
> This is based on top of
> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/log/?h=v6.15-armsoc/dts64
> 6ee0b9ad3995 ("arm64: dts: rockchip: Add rng node to RK3588") as it
> depends on the (merged) series from
> https://lore.kernel.org/all/20250211-pre-ict-jaguar-v6-0-4484b0f88cfc@cherry.de/
> 
> Patches for Haikou Video Demo adapter for PX30 Ringneck and RK3399 Puma
> (patches 4 and 5) also depend on the following patch series:
> https://lore.kernel.org/linux-devicetree/20250220-pca976x-reset-driver-v1-0-6abbf043050e@cherry.de/
> 
> This fixes incorrect pinmux on UART0 and UART5 for PX30 Ringneck on
> Haikou.
> 
> This adds support for the HAIKOU-LVDS-9904379 adapter for PX30 Ringneck
> fitted on a Haikou carrierboard.
> 
> Additionally, this adds support for Haikou Video Demo adapter on PX30
> Ringneck and RK3399 Puma fitted on a Haikou carrierboard. Notably
> missing from the overlay is the OV5675 camera module which expects
> 19.2MHz which we cannot exactly feed right now. Modifications to the
> OV5675 drivers will be made so it's more flexible and then support for
> the camera module will be added. This adapter has a 720x1280 DSI display
> with a GT911 touchscreen, a GPIO-controllable LED and an I2C GPIO
> expander. Support for this adapter on RK3588 Tiger is being added in a
> separate patch series[1].
> 
> Note that the DSI panel currently is glitchy on both PX30 Ringneck and
> RK3399 Puma but this is being tackled in another series[2]. Since this
> will not be fixed through DT properties for the panel, adding the DT
> nodes for the DSI panel even if not perfect right now seems acceptable
> to me.
> 
> [1] https://lore.kernel.org/linux-rockchip/20241127143719.660658-1-heiko@sntech.de/
> [2] https://lore.kernel.org/r/20240626084722.832763-1-heiko@sntech.de
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (5):
>       arm64: dts: rockchip: fix pinmux of UART0 for PX30 Ringneck on Haikou
>       arm64: dts: rockchip: fix pinmux of UART5 for PX30 Ringneck on Haikou
>       arm64: dts: rockchip: add support for HAIKOU-LVDS-9904379 adapter for PX30 Ringneck
>       arm64: dts: rockchip: add overlay for PX30 Ringneck Haikou Video Demo adapter
>       arm64: dts: rockchip: add overlay for RK3399 Puma Haikou Video Demo adapter
> 
>  arch/arm64/boot/dts/rockchip/Makefile              |  15 ++
>  .../px30-ringneck-haikou-lvds-9904379.dtso         | 130 ++++++++++++++
>  .../rockchip/px30-ringneck-haikou-video-demo.dtso  | 190 +++++++++++++++++++++
>  .../boot/dts/rockchip/px30-ringneck-haikou.dts     |  10 +-
>  .../rockchip/rk3399-puma-haikou-video-demo.dtso    | 166 ++++++++++++++++++
>  5 files changed, 510 insertions(+), 1 deletion(-)
> ---
> base-commit: 6ee0b9ad3995ee5fa229035c69013b7dd0d3634b
> change-id: 20250128-ringneck-dtbos-98064839355e
> prerequisite-change-id: 20250219-pca976x-reset-driver-c9aa95869426:v1
> prerequisite-patch-id: 24af74693654b4a456aca0a1399ec8509e141c01
> prerequisite-patch-id: df17910ec117317f2f456f679a77ed60e9168fa3
> 
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250220-ringneck-dtbos-v1-0-25c97f2385e6@cherry.de:

arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dtb: uart: uart5-rts-gpio: {'rockchip,pins': [[0, 13, 0, 147]], 'phandle': 70} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#






