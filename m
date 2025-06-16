Return-Path: <stable+bounces-152737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8CAADBC30
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 23:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B07E18902DE
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 21:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76B0224B0E;
	Mon, 16 Jun 2025 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH1Axf1V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEFC223DD1;
	Mon, 16 Jun 2025 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750110415; cv=none; b=FUl9i73uVM27bLXGMu5A4DrRTsBw5swYrj8+PhbU5qOrCf9n29wP7wvadUOGoP3ul0CE1RKJhau1C2Sw4j57lJI4JTllJPFXY1sLkrgmggB45sI5AUKRHcIumB5QxeSwu6yUn5n7DynmEgn04Vfp2/PTA0G32l98coEtqrIzygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750110415; c=relaxed/simple;
	bh=lAcy14owpRzsFcmmXaUy8Ue2E7S1558QynG8B47P8O8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=EpXNqPKo3N54zHMUbRMZZ18tQSUNubswMZhIXd5ZTqENabD8avZWaoz+VForAECRWlVl0wgtSGCgqMSVMQGQtlnKoHV2TzItib5pibXEMWgs3hxrMtgThzRPLiIS3QAe/Bbu88tafrw3XgwHpHtUIjXrxYTrZfOPTKpih1i57Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH1Axf1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01A5C4CEF5;
	Mon, 16 Jun 2025 21:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750110415;
	bh=lAcy14owpRzsFcmmXaUy8Ue2E7S1558QynG8B47P8O8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=pH1Axf1V8bPyNxC6wmvG/lSQK1WlBOXm1q7U2qvfRdqTw/CUDLoXfddLs9h4A2UTr
	 KfigPlZAThSWo7ZusG2+0oplV1umoh9NvNW3GqHDpgl4YiS3knsbo8XxRhHOgOXU9+
	 PhffMTLgRjAlX4oFyD/jt9hG/JZmBN0SxzlcvumH5W4bXAl9GZfqUzPLjfeNN6nZHS
	 /XamOiOLY9XTplnUUez5rnsHVdBOgq3c/0rj+p6NrFEku9XL/EOiLeCJgFHe0galXp
	 20uHhVOpQ9ANUImErbreQsgRsRdH5paf+nriR4wnl+OXtpOYVX75TnCRUNlLN1/AlC
	 QZJUtQkAPEdfw==
Date: Mon, 16 Jun 2025 16:46:54 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Detlev Casanova <detlev.casanova@collabora.com>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>, 
 linux-rockchip@lists.infradead.org, stable@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
To: Alexey Charkov <alchark@gmail.com>
In-Reply-To: <20250614-sige5-updates-v2-0-3bb31b02623c@gmail.com>
References: <20250614-sige5-updates-v2-0-3bb31b02623c@gmail.com>
Message-Id: <175011005578.2433766.276755788637993361.robh@kernel.org>
Subject: Re: [PATCH v2 0/4] arm64: dts: rockchip: enable further
 peripherals on ArmSoM Sige5


On Sat, 14 Jun 2025 22:14:32 +0400, Alexey Charkov wrote:
> Link up the CPU regulators for DVFS, enable WiFi and Bluetooth.
> 
> Different board versions use different incompatible WiFi/Bluetooth modules
> so split the version-specific bits out into an overlay. Basic WiFi
> functionality works even without an overlay, but OOB interrupts and
> all Bluetooth stuff requires one.
> 
> My board is v1.2, so the overlay is only provided for it.
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> Changes in v2:
> - Expand the commit message for the patch linking CPU regulators and add
>   tags for stable (thanks Nicolas)
> - Fix the ordering of cpu_b* nodes vs. combphy0_ps (thanks Diederik)
> - Drop the USB patch, as Nicolas has already posted a more comprehensive
>   series including also the Type-C stuff (thanks Nicolas)
> - Pick up Nicolas' tags
> - Split out board version specific WiFi/Bluetooth stuff into an overlay
> - Link to v1: https://lore.kernel.org/r/20250603-sige5-updates-v1-0-717e8ce4ab77@gmail.com
> 
> ---
> Alexey Charkov (4):
>       arm64: dts: rockchip: list all CPU supplies on ArmSoM Sige5
>       arm64: dts: rockchip: add SDIO controller on RK3576
>       arm64: dts: rockchip: add version-independent WiFi/BT nodes on Sige5
>       arm64: dts: rockchip: add overlay for the WiFi/BT module on Sige5 v1.2
> 
>  arch/arm64/boot/dts/rockchip/Makefile              |  5 ++
>  .../rockchip/rk3576-armsom-sige5-v1.2-wifibt.dtso  | 49 +++++++++++++
>  .../boot/dts/rockchip/rk3576-armsom-sige5.dts      | 85 ++++++++++++++++++++++
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 16 ++++
>  4 files changed, 155 insertions(+)
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250602-sige5-updates-a162b501a1b1
> 
> Best regards,
> --
> Alexey Charkov <alchark@gmail.com>
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


This patch series was applied (using b4) to base:
 Base: using specified base-commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250614-sige5-updates-v2-0-3bb31b02623c@gmail.com:

arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,rk3576-pinctrl): pwm0:pwm0m1-ch1:rockchip,pins:0:2: 14 is greater than the maximum of 13
	from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,pinctrl.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,rk3576-pinctrl): pwm2:pwm2m1-ch1:rockchip,pins:0:2: 14 is greater than the maximum of 13
	from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,pinctrl.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,rk3576-pinctrl): pwm2:pwm2m1-ch0:rockchip,pins:0:2: 14 is greater than the maximum of 13
	from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,pinctrl.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,rk3576-pinctrl): pwm2:pwm2m0-ch4:rockchip,pins:0:2: 14 is greater than the maximum of 13
	from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,pinctrl.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,rk3576-pinctrl): pwm2:pwm2m1-ch2:rockchip,pins:0:2: 14 is greater than the maximum of 13
	from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,pinctrl.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,rk3576-pinctrl): pwm2:pwm2m0-ch2:rockchip,pins:0:2: 14 is greater than the maximum of 13
	from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,pinctrl.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,rk3576-pinctrl): pwm2:pwm2m0-ch3:rockchip,pins:0:2: 14 is greater than the maximum of 13
	from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,pinctrl.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,rk3576-pinctrl): pwm2:pwm2m1-ch3:rockchip,pins:0:2: 14 is greater than the maximum of 13
	from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,pinctrl.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,rk3576-pinctrl): pwm2:pwm2m1-ch5:rockchip,pins:0:2: 14 is greater than the maximum of 13
	from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,pinctrl.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,rk3576-pinctrl): pwm2:pwm2m1-ch6:rockchip,pins:0:2: 14 is greater than the maximum of 13
	from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,pinctrl.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,rk3576-pinctrl): i3c1_sda:i3c1_sdam1-pu:rockchip,pins:0:2: 14 is greater than the maximum of 13
	from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,pinctrl.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,rk3576-pinctrl): pwm1:pwm1m1-ch5:rockchip,pins:0:2: 14 is greater than the maximum of 13
	from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,pinctrl.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,rk3576-pinctrl): i3c1:i3c1m1-xfer:rockchip,pins:0:2: 14 is greater than the maximum of 13
	from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,pinctrl.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pinctrl (rockchip,rk3576-pinctrl): i3c1:i3c1m1-xfer:rockchip,pins:1:2: 14 is greater than the maximum of 13
	from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,pinctrl.yaml#






