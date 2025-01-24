Return-Path: <stable+bounces-110377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBFBA1B39B
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 11:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF8A188DCE3
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA251D5177;
	Fri, 24 Jan 2025 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xpBNefgE"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46231CDA01;
	Fri, 24 Jan 2025 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737715138; cv=none; b=STKWBsksIGE+reJ6ct2gT3nehJbvclgRBnef33bKD5p4IoExotywzMoixfOL7YQGY8J4ZpIx9Q4hLuvg+7vEM9PdsV+ZxQlkE4q+T/GnWpm6nymILxK7D+6ljwm7IB9uNFyZUsuE+W+uWzYkpSzYS5wsqBYRMaZrKrwfnevd9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737715138; c=relaxed/simple;
	bh=ksW4009mbPHdrKewlfF4pVrYBtt7YvevohYAvGeqJG4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GNW0HopV4hFi+rpilrmVZT38XVLxhqv3j2gzw6XyF5o5Z3COOPN1p9YniGS0VHhfCzdLxoKavb3klh/V3DYdhDHYJy8Fvur/BK8Y3um4fdUfDQs+FAs0DQ6SM6UxyFRDj8GD2KR3UU23ftVZcWDaWbGntKE6BFetzFE9bAzP4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xpBNefgE; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1737715134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijHuryPa2Ctq7YAPPlofMfpp4o1jvCo4mMR5trhPOdk=;
	b=xpBNefgEOWUpC64232st7aSuFe3gC3DH5NZSbh4QM0yS2SSuMmfYNzl6cEhDTPqruAzrQF
	7fBnKxbmHADg6V34xrANCRhQz0H9xRxbZVH91iyTnF8HfXLdHPIqDYp2lgm+Z1uZ+dbZTf
	FWIzIn11DvKCuekFoOO3bdCQj9p9jYCCdg024IMTJPryAPw0lHIIZ8t0qgEwipTcGSk9Vq
	ySB7Rk5xGFbQ+bTeUguqnE9sBZAI+bUrCCHqw/kKl/mkqIYLZsbVp4Nf/GtuozYAtvt8q9
	7xwotJRMRnmrFuNgLvPtM3dsFDm1NodDKnuBT1VsEe+P93w46WyoaCLzmwELiw==
Date: Fri, 24 Jan 2025 11:38:54 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexander Shiyan <eagle.alexander923@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Rob Herring <robh@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, Sebastian Reichel
 <sebastian.reichel@collabora.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@gmail.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix broken tsadc pinctrl binding
 for rk3588
In-Reply-To: <20250124052611.3705-1-eagle.alexander923@gmail.com>
References: <20250124052611.3705-1-eagle.alexander923@gmail.com>
Message-ID: <8fe92764f7f3df9b25cd832045d28ad5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexander,

On 2025-01-24 06:26, Alexander Shiyan wrote:
> There is no pinctrl "gpio" and "otpout" (probably designed as "output")
> handling in the tsadc driver.
> Let's use proper binding "default" and "sleep".
> 
> Fixes: 32641b8ab1a5 ("arm64: dts: rockchip: add rk3588 thermal sensor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> index a337f3fb8377..f141065eb69d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> @@ -2667,9 +2667,9 @@ tsadc: tsadc@fec00000 {
>  		rockchip,hw-tshut-temp = <120000>;
>  		rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
>  		rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
> -		pinctrl-0 = <&tsadc_gpio_func>;
> -		pinctrl-1 = <&tsadc_shut>;
> -		pinctrl-names = "gpio", "otpout";
> +		pinctrl-0 = <&tsadc_shut>;
> +		pinctrl-1 = <&tsadc_gpio_func>;
> +		pinctrl-names = "default", "sleep";
>  		#thermal-sensor-cells = <1>;
>  		status = "disabled";
>  	};

Thanks for the patch, it's looking good to me.  The old values
for the pinctrl names are leftovers back from the import of the
downstream kernel code, while the new values follow the expected
pinctrl naming scheme.  The resulting behavior follows, almost
entirely, the behavior found in the downstream kernel code.

Actually, there's some rather critical discrepancy between the
upstream TSADC driver and it's downstream cousin, as already
described in earlier responses from Alexey and me.  However,
those issues have to be addressed in a separate patch, while
this patch, to me, remains fine on its own.

My only suggestions would be to adjust both the patch summary
and the description not to use word "binding", because that
technically isn't fixed here, but to use "pinctrl names" instead.
Also, please note that the downstream kernel uses "otpout" as
a pinctrl name, [1] so the assumption about "output" in the
patch description should be removed.

With the suggestions from above addressed in the v2, please feel
free to include my

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

[1] 
https://raw.githubusercontent.com/rockchip-linux/kernel/refs/heads/develop-5.10/drivers/thermal/rockchip_thermal.c

