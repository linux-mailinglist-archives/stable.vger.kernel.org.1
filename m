Return-Path: <stable+bounces-81218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CF69926BC
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 10:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52BE28382A
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 08:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22426188728;
	Mon,  7 Oct 2024 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zxag0pHO"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6CE188003;
	Mon,  7 Oct 2024 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728288851; cv=none; b=Vo8jagWtDR4nSKhid91HtxDRvnsIM2k+Nc0gEAnlA1M7QEw+akKexpagp0AMMoX0A9C7ECC8peEIe459nJa3884xojst9G1RidATjpW9AGmJfWYOoixPY8AsMY1KTxqzXlEAZ9bfpJo1hQAx+GqdOE2JkhuyP+JAsumXVDdG8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728288851; c=relaxed/simple;
	bh=CyHYryxsLiYwOZoKOj+rqyE3zGxA4hYzsgEc7oms1nM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jP2Bw20LY6/jNzZrBVtiR48fle+uMR7Qho/GGN8NM6Qmr+dnYPYM/cEZy54NL8lKJHFtCc8A61D4n9NbteTf98+jSr+Ac0DESjHtlKKL8g9Sakqs97YQQ1CbaxtqEdNBZzE9CIFkGG35pfXaOgpF7Hn06OG3rD3kIyjWBC1bkdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zxag0pHO; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 84F16E0004;
	Mon,  7 Oct 2024 08:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728288841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=428uZN4OXNwScrUiihgmWynciO1ldGPtkCDcUGjhV00=;
	b=Zxag0pHOQQ5ssx9daaBMo2XiivlMnFlA+W2w7NgVsUAnw/0VdPmFBc5nLvi8u5c/5tVOPS
	qj8RJSo3TyChHoiPMIchpGXkGdhx07S2+ocaHWKo+HTuRnulDVnFXZn43IUVokR9mMnF4Q
	yXkHPbvi8ZrCIMBB9R29cQGxKhhMyQO2B3qUCvsYx4WlRnNzRR/8rA8fh6mHI7zhxuTp6D
	av6eGb18IyZso5uZ2f2G7lZI5TMWlDmv8yadHVI9DQy9D8DM4I5L70zak3G8b0xeCzEvjQ
	NewMlP7DOZA+I6xmgF5rquONVdXa1x/kIN7AjPKo+Hvz+b4Y0DRJ1YpaTzOtIA==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Josua Mayer <josua@solid-run.com>, Arnd Bergman <arnd.bergmann@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Josua Mayer <josua@solid-run.com>
Subject: Re: [PATCH v2] arm64: dts: marvell: cn9130-sr-som: fix cp0 mdio pin
 numbers
In-Reply-To: <20241002-cn9130-som-mdio-v2-1-ec798e4a83ff@solid-run.com>
References: <20241002-cn9130-som-mdio-v2-1-ec798e4a83ff@solid-run.com>
Date: Mon, 07 Oct 2024 10:13:59 +0200
Message-ID: <874j5oe3eg.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Hi Josua and Arnd,

> SolidRun CN9130 SoM actually uses CP_MPP[0:1] for mdio. CP_MPP[40]
> provides reference clock for dsa switch and ethernet phy on Clearfog
> Pro, wheras MPP[41] controls efuse programming voltage "VHV".
>
> Update the cp0 mdio pinctrl node to specify mpp0, mpp1.


Applied on mvebu/fixes

Thanks,

Arnd,

I've applied it on an mvebu branch and I'll create a PR for it this
week. However, since we don't have many fixes, you might prefer to apply
this patch directly to your trees?

Gregory

>
> Fixes: 1c510c7d82e5 ("arm64: dts: add description for solidrun cn9130 som and clearfog boards")
> Cc: stable@vger.kernel.org # 6.11.x
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v2:
> - corrected Cc: stable list address
> - removed duplicate "mdio" from commit message
> - added Fixes: tag
> - Link to v1: https://lore.kernel.org/r/20241002-cn9130-som-mdio-v1-1-0942be4dc550@solid-run.com
> ---
>  arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
> index 4676e3488f54d53041696d877b510b8d51dcd984..cb8d54895a77753c760b58b8b5103149e21e2094 100644
> --- a/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
> +++ b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
> @@ -136,7 +136,7 @@ cp0_i2c0_pins: cp0-i2c0-pins {
>  		};
>  
>  		cp0_mdio_pins: cp0-mdio-pins {
> -			marvell,pins = "mpp40", "mpp41";
> +			marvell,pins = "mpp0", "mpp1";
>  			marvell,function = "ge";
>  		};
>  
>
> ---
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> change-id: 20241002-cn9130-som-mdio-4a519e6dc7df
>
> Best regards,
> -- 
> Josua Mayer <josua@solid-run.com>

