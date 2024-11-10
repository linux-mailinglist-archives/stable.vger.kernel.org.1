Return-Path: <stable+bounces-92052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E2A9C3485
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 21:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B3AB20E76
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 20:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3111420DD;
	Sun, 10 Nov 2024 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="vCEufDAN"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E3313BC12;
	Sun, 10 Nov 2024 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731269346; cv=none; b=HxqSgdpvubX5KOFIkS5i9P3wK4SmHeFjFGlCNR0vqVGdhVJuOit6eNJ/UrNhl6VofsHf6YgI6GiuSCb8gDDylvni6VFlO8VAkpu8Njp3VMecTse8gKkbf3Q/6LyKyDn53iL6c8tcQw6nRpqfL+sW5HcB7Ya9acr1sPFQGS5VF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731269346; c=relaxed/simple;
	bh=01E9ofN3CxLtcnOBcQpnSLqdzqAy9TF8Ri5LhV4RvVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VH33vVOW+oGhdjUQmVh9dE44aouIc3IlmjLsiCeBsfeMlzE8S5Yq0F+5LgZZM6FomVQ1BbGM5nUBUpCs25qpPlEiYyESITecszmDILjEpFcIdNDF8Eo2O6aIi6dz9g1jJC8NZAEitF4c3mTzFhgvOSxsbSp1eH7W/m+1jn7IX80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=vCEufDAN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+zZU04tEj4EEZbENw6dSSfYen4JgG0xgFFzxeJ1MLUw=; b=vCEufDANWeR1ag4PqdkTc97zxn
	OBMNW+Ra3cWADI+YjxE50WeJ/hpCXFOAU1cdZJGI6rPpmc4skY6zBTn4mcRYVvJzOwQ4aji7RW/xs
	0sDXTUPG99pGFNxWGsrbCxDQ+Ksv3L3uQaH7zWXRC8fgWkYPPHqfVMmT+Bt4boxmTblHYA3jU9ndY
	VkbtNUQAVnklm53In+hz5Ikmfrrb0Fd9ePgNVkTebPboHrYA+mqUl3uSbYjZqPaSNaqSevGG5pN5D
	msyoMVwMXMET9vYXNNNYuBkP4CGP8MAp5txbqkH/z7Mqln9cW3U3saHIyrM7LHjyt+eydjVoQLcC5
	EDlLADGw==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tAEEp-0006cE-Rt; Sun, 10 Nov 2024 21:08:47 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, Dragan Simic <dsimic@manjaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Fix vdd_gpu voltage constraints on
 PinePhone Pro
Date: Sun, 10 Nov 2024 21:08:47 +0100
Message-ID: <4386271.ejJDZkT8p0@diego>
In-Reply-To:
 <0718feb8e95344a0b615f61e6d909f6e105e3bf9.1731264205.git.dsimic@manjaro.org>
References:
 <0718feb8e95344a0b615f61e6d909f6e105e3bf9.1731264205.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Sonntag, 10. November 2024, 19:44:31 CET schrieb Dragan Simic:
> The regulator-{min,max}-microvolt values for the vdd_gpu regulator in the
> PinePhone Pro device dts file are too restrictive, which prevents the highest
> GPU OPP from being used, slowing the GPU down unnecessarily.  Let's fix that
> by making the regulator-{min,max}-microvolt values less strict, using the
> voltage range that the Silergy SYR838 chip used for the vdd_gpu regulator is
> actually capable of producing. [1][2]
> 
> This also eliminates the following error messages from the kernel log:
> 
>   core: _opp_supported_by_regulators: OPP minuV: 1100000 maxuV: 1150000, not supported by regulator
>   panfrost ff9a0000.gpu: _opp_add: OPP not supported by regulators (800000000)
> 
> These changes to the regulator-{min,max}-microvolt values make the PinePhone
> Pro device dts consistent with the dts files for other Rockchip RK3399-based
> boards and devices.  It's possible to be more strict here, by specifying the
> regulator-{min,max}-microvolt values that don't go outside of what the GPU
> actually may use, as the consumer of the vdd_gpu regulator, but those changes
> are left for a later directory-wide regulator cleanup.

With the Pinephone Pro using some sort of special-rk3399, how much of
"the soc variant cannot use the highest gpu opp" is in there, and just the
original implementation is wrong?

Did you run this on actual hardware?


Heiko


> Fixes: 78a21c7d5952 ("arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index 1a44582a49fb..956d64f5b271 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -410,8 +410,8 @@ vdd_gpu: regulator@41 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&vsel2_pin>;
>  		regulator-name = "vdd_gpu";
> -		regulator-min-microvolt = <875000>;
> -		regulator-max-microvolt = <975000>;
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1500000>;
>  		regulator-ramp-delay = <1000>;
>  		regulator-always-on;
>  		regulator-boot-on;
> 





