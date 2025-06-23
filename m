Return-Path: <stable+bounces-155281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FEBAE33A3
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 04:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28FA3A7081
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 02:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9921A4F12;
	Mon, 23 Jun 2025 02:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yp/WX/Xh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9061A256E;
	Mon, 23 Jun 2025 02:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750646348; cv=none; b=KMbdkaEOMXjz/GrQ6qdQsWqiVynFM8qAoky/FIGlmo0Js2pb4IgqvdovTAz6CBtMj0NCDzBeMlXJzSAkjuPmr3yWnjyMknCY/p4CSg4uJPgGkEj48zBkGFs3k+ZgmaK6yfvC4Hph7f7F7easbWJi18SrNmTR4dRqmvAWkFr5kRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750646348; c=relaxed/simple;
	bh=z+teoxeTAmCgQVzu+Jz6aydCP8vcrbY6GqWslL+3y8Y=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=UcsdRwE3vLeQ40KGosiOqH+zm/fFVwqATtI7SF0u37eSAmxid37qF15viJOSiVLP06IXMtdAgWbY/xqKn7j7Q3HpUi4n0CtxOVq7evx7lHOHI2tCSsmVOlBA7HXU6Fhaw83ZbGE6w45jCie686ys49L2C5kLq47tEDXFy9gLOWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yp/WX/Xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D2AC4CEE3;
	Mon, 23 Jun 2025 02:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750646348;
	bh=z+teoxeTAmCgQVzu+Jz6aydCP8vcrbY6GqWslL+3y8Y=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Yp/WX/XhrPBaXidYPuxT4pjPsfKN5DM2FB5pXmH5ptyaOSlk9l6RCDD4fXpV1vOLu
	 GkjqHgqjKgd9nA5DXGlmqvQ7itU4vwkCOxCmCHxPaWzGXgz5RSC5z3fX/EbJyD5M7t
	 7gA4nXAzScqT9zoaPVxTe4de7a9KhnlCMf3oTGgdwLraz2LWUDXu15rWLZ0AtYzFdu
	 qhlSd9x0iKJishocD+37JnAOFXFQR6FvMxd9JVjwLHo053zUc5/a4FZzuN/GXoH3F4
	 N0ZIIj7Wp8kwEz/Ns8MTKgVOtdVNAjVFRST3N85dqzO9nhv/FK1ep+1NjaWv6gdMjb
	 +hxHD83wIbArg==
Date: Sun, 22 Jun 2025 21:39:07 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Diederik de Haas <didi.debian@cknow.org>, Johan Jonker <jbx6244@gmail.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Farouk Bouabid <farouk.bouabid@cherry.de>, 
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>, 
 stable@vger.kernel.org, Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Dragan Simic <dsimic@manjaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Jakob Unterwurzacher <jakobunt@gmail.com>
In-Reply-To: <20250620113549.2900285-1-jakob.unterwurzacher@cherry.de>
References: <20250620113549.2900285-1-jakob.unterwurzacher@cherry.de>
Message-Id: <175064594664.881054.5188113186564000482.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: use cs-gpios for spi1 on
 ringneck


On Fri, 20 Jun 2025 13:35:46 +0200, Jakob Unterwurzacher wrote:
> From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> 
> Hardware CS has a very slow rise time of about 6us,
> causing transmission errors when CS does not reach
> high between transaction.
> 
> It looks like it's not driven actively when transitioning
> from low to high but switched to input, so only the CPU
> pull-up pulls it high, slowly. Transitions from high to low
> are fast. On the oscilloscope, CS looks like an irregular sawtooth
> pattern like this:
>                          _____
>               ^         /     |
>       ^      /|        /      |
>      /|     / |       /       |
>     / |    /  |      /        |
> ___/  |___/   |_____/         |___
> 
> With cs-gpios we have a CS rise time of about 20ns, as it should be,
> and CS looks rectangular.
> 
> This fixes the data errors when running a flashcp loop against a
> m25p40 spi flash.
> 
> With the Rockchip 6.1 kernel we see the same slow rise time, but
> for some reason CS is always high for long enough to reach a solid
> high.
> 
> The RK3399 and RK3588 SoCs use the same SPI driver, so we also
> checked our "Puma" (RK3399) and "Tiger" (RK3588) boards.
> They do not have this problem. Hardware CS rise time is good.
> 
> Fixes: c484cf93f61b ("arm64: dts: rockchip: add PX30-µQ7 (Ringneck) SoM with Haikou baseboard")
> Cc: stable@vger.kernel.org
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> ---
>  .../boot/dts/rockchip/px30-ringneck.dtsi      | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
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
 Base: attempting to guess base-commit...
 Base: tags/next-20250619 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250620113549.2900285-1-jakob.unterwurzacher@cherry.de:

arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dtb: spi1: spi1-csn0-gpio: {'rockchip,pins': [[3, 9, 0, 150]], 'phandle': 87} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dtb: spi1: spi1-csn1-gpio: {'rockchip,pins': [[3, 10, 0, 150]], 'phandle': 88} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#






