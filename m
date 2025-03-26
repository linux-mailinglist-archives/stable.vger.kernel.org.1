Return-Path: <stable+bounces-126793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDD9A71EE7
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 20:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDEF170EC5
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 19:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67BA2580D3;
	Wed, 26 Mar 2025 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8VJHKQo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59314257ADE;
	Wed, 26 Mar 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743016303; cv=none; b=Gc9rOb/IpCdIItsvRXsS7qS+wQWeczDRvUQirMB000ZT0sa5JcEwTbze8vbx+gSy7pc5b9BGoGnDz5Yugn9VC1gZwLLCkD9FtYdMHnrv7u743lVqwiUCFV0yEx1tUU6/W0yvJiRxZiUmuWfrvDffRXcqEMPjMzrplg0NHBVXFEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743016303; c=relaxed/simple;
	bh=FjoBf5oIKnt+BxBL5ikSxff8xK7Z5Im1gcOrV8814C0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=LdO8+3fl5CPVuMSj/ZELgfUhSsE6LsIPsPsV5eLFEhGgA4i2syMIRy9M7rkE3eNY4olJMX+9JAZvhTJFW3rOduv7KaU9ykqii8aQhKgqGayQImkgdSgjdFoffGa352/b6+hBxuCIkh2cMqEzVo9XJFgqZwOafHUc7hyOoyZ8Xpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8VJHKQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB9BC4AF09;
	Wed, 26 Mar 2025 19:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743016302;
	bh=FjoBf5oIKnt+BxBL5ikSxff8xK7Z5Im1gcOrV8814C0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=X8VJHKQoKx8TN6Nrrw4iVI4qoPraLVsFZAWJKgnItF1dK/53F9EYLQB5pYJXgibly
	 xiyu5iNkZYozvEXYu2kxBf/yCi3qNE7VeRLZh+Zr8/Icir0WpkkciAGz7BM/oPuODG
	 IeAjHVVGKEHMlh7XxXHwTk4UK/Bgpu2lXiTWZCtVJmaOrxOEcmCYgWELL9BTadg6+2
	 gC9KMPu1s7yo0EQ5CFyxfQjDEa9j3SMZvAMh+xsgoK9S2ZFDTN3ym5Fn7x5vcMBb0L
	 kghNDPFmQLQwX46UOq63Q10fyvnULTyKmrj1ZCSpHiFYppVXLGEcqp3wT6IjZ9+o+B
	 sOa2/athzo7lQ==
Date: Wed, 26 Mar 2025 14:11:41 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-rockchip@lists.infradead.org, quentin.schulz@cherry.de, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, 
 Matthias Kaehlcke <mka@chromium.org>, Heiko Stuebner <heiko@sntech.de>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
In-Reply-To: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
References: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
Message-Id: <174301524097.2716484.8735882534615031646.robh@kernel.org>
Subject: Re: [PATCH 0/5] Fix onboard USB hub instability on RK3399 Puma SoM


On Wed, 26 Mar 2025 17:22:55 +0100, Lukasz Czechowski wrote:
> The RK3399 Puma SoM contains the internal Cypress CYUSB3304 USB
> hub, that shows instability due to improper reset pin configuration.
> Currently reset pin is modeled as a vcc5v0_host regulator, that
> might result in too short reset pulse duration.
> Starting with the v6.6, the Onboard USB hub driver (later renamed
> to Onboard USB dev) contains support for Cypress HX3 hub family.
> It can be now used to correctly model the RK3399 Puma SoM hardware.
> 
> The first commits in this series fix the onboard USB dev driver to
> support all HX3 hub variants, including the CYUSB3304 found in
> the RK3399 Puma SoM.
> This allows to introduce fix for internal USB hub instability on
> RK3399 Puma, by replacing the vcc5v0_host regulator with
> cy3304_reset, used inside the hub node.
> Please be aware that the patch that fixes USB hub instability in
> arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi can me merged only
> after updating the Onboard USB dev driver, otherwise the hub
> will not work.
> 
> Two last commits in the series disable unrouted USB controllers
> and PHYs on RK3399 Puma SOM and Haikou carrier board, with no
> intended functional changes.
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
> Lukasz Czechowski (3):
>       usb: misc: onboard_usb_dev: fix support for Cypress HX3 hubs
>       dt-bindings: usb: cypress,hx3: Add support for all variants
>       arm64: dts: rockchip: fix internal USB hub instability on RK3399 Puma
> 
> Quentin Schulz (2):
>       arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma
>       arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma with Haikou
> 
>  .../devicetree/bindings/usb/cypress,hx3.yaml       |  6 +++
>  .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  8 ----
>  arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 43 ++++++++++------------
>  drivers/usb/misc/onboard_usb_dev.c                 | 10 ++++-
>  drivers/usb/misc/onboard_usb_dev.h                 |  6 +++
>  5 files changed, 39 insertions(+), 34 deletions(-)
> ---
> base-commit: 1e26c5e28ca5821a824e90dd359556f5e9e7b89f
> change-id: 20250326-onboard_usb_dev-a7c063a8a515
> 
> Best regards,
> --
> Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
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
 Base: base-commit 1e26c5e28ca5821a824e90dd359556f5e9e7b89f not known, ignoring
 Base: attempting to guess base-commit...
 Base: tags/next-20250326 (best guess, 2/5 blobs matched)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com:

arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: hub@1: 'vdd-supply' is a required property
	from schema $id: http://devicetree.org/schemas/usb/cypress,hx3.yaml#
arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: hub@1: 'vdd2-supply' is a required property
	from schema $id: http://devicetree.org/schemas/usb/cypress,hx3.yaml#
arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: hub@2: 'vdd-supply' is a required property
	from schema $id: http://devicetree.org/schemas/usb/cypress,hx3.yaml#
arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: hub@2: 'vdd2-supply' is a required property
	from schema $id: http://devicetree.org/schemas/usb/cypress,hx3.yaml#
arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: pinctrl: gpios: {'bios-disable-override-hog-pin': {'rockchip,pins': [[3, 29, 0, 190]], 'phandle': 185}, 'q7-thermal-pin': {'rockchip,pins': [[0, 3, 0, 189]], 'phandle': 184}} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#






