Return-Path: <stable+bounces-118566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F86A3F162
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 11:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2328B1894961
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 10:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD64204C13;
	Fri, 21 Feb 2025 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="pmmMCG9j"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E96C20469D;
	Fri, 21 Feb 2025 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132466; cv=none; b=OWbGSzHFWv7YdTH/0rmMQ4b46ZrbijHOR3QLPJAlTXhc3wYpW89owx6B8ftGEwuUD+TmUZszS8qihv/pf4/IjyUxrFg/UG/5vX3MNzzL8ArbzTfkyqUvBwBJWipMmQMBRs72vN5noxrjFpdbVMs/wwiRNuRb04h0nkUO4CiUJ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132466; c=relaxed/simple;
	bh=wtNoofFv6KoVXE2Qy2UY/PwELQzz2XofI38+Etocco4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPvoxdpHZT2mZ1mPox3FOEyhAy0MZtfACn66pn2znT11aKoNayQCVOjApQj5bkygnRFy9Z3BYgf+KllKjdLlOk5BA8KzI+5hHfBkw5xmMV4cx1fam6nDiWyrNdGe+d6/N4OlcVNF25ZREthaIESuejFBBMWuhX7e7vePcBUP20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=pmmMCG9j; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W+26npf18RRwsCWtDsEbmc9w9HSuCv1j/NyTX3JxquE=; b=pmmMCG9jXqbiNJJ6GmtbO6FRsX
	ARRLZAhlhtPCOl5SKYYH4jzI1WMpRYPi6B1VK779IhlgPgm+3uGz6H4K2RPVVjx1umDTQT7ILSz6Q
	XmtkEsJfEImhk5hZqrVA6r7EYi35xg+iF2SyPsl/HufSuWsG94G+LPV6Fg3438zjO7i/67O7waij3
	s7Y5zZiwO3U4cbLFzbwFr9ot77cTfKdduSXt+hMQ4A5j2c0TJ8YNNPxy/PLCBHadHN2Ix21ZQL+ic
	J53yrW+4bSLBNJ9jlGXesT0oS65Idbf8QOmu3v6R5BKtVhbD9u4p25ThBL1hN30pHrUM0MIjzaugN
	KgsC6gYw==;
Received: from i53875a87.versanet.de ([83.135.90.135] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tlPwY-0002cL-4E; Fri, 21 Feb 2025 11:07:38 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Quentin Schulz <foss+kernel@0leil.net>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 stable@vger.kernel.org
Subject:
 Re: [PATCH 0/5] arm64: dts: rockchip: pinmux fixes and support for 2 adapters
 for Theobroma boards
Date: Fri, 21 Feb 2025 11:07:37 +0100
Message-ID: <3771836.RUnXabflUD@diego>
In-Reply-To: <f9b40055-bcb0-4245-b899-4c7890e81b20@cherry.de>
References:
 <20250220-ringneck-dtbos-v1-0-25c97f2385e6@cherry.de>
 <174008661935.4046882.3221866764998287397.robh@kernel.org>
 <f9b40055-bcb0-4245-b899-4c7890e81b20@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Quentin,

Am Freitag, 21. Februar 2025, 11:01:44 MEZ schrieb Quentin Schulz:
> On 2/20/25 10:29 PM, Rob Herring (Arm) wrote:
> > On Thu, 20 Feb 2025 13:20:09 +0100, Quentin Schulz wrote:
> I believe this is a false positive due to the node suffix being -gpio? 
> If I change -gpio suffix to -pin, it doesn't complain anymore.
> 
> """
> diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts 
> b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
> index 08a11e4758413..249e50d64791e 100644
> --- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
> +++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
> @@ -196,7 +196,7 @@ sd_card_led_pin: sd-card-led-pin {
>   	};
> 
>   	uart {
> -		uart5_rts_gpio: uart5-rts-gpio {
> +		uart5_rts_pin: uart5-rts-pin {
>   			rockchip,pins =
>   			  <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
>   		};
> @@ -234,7 +234,7 @@ &uart0 {
>   };
> 
>   &uart5 {
> -	pinctrl-0 = <&uart5_xfer &uart5_rts_gpio>;
> +	pinctrl-0 = <&uart5_xfer &uart5_rts_pin>;
>   	rts-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
>   	status = "okay";
>   };
> """
> 
> @Heiko, I guess you would like a warning-less DT :) I can send a v2 with 
> that change then if that works for you? I can wait a few days for other 
> reviews :)

that would be great - the v2.

We already had patches addressing the -gpio thing for other boards in the
past, so going to "-pin" is the preferred solution here.

Also, your patches are totally specific to Theobroma-boards, so just send
your v2 at your convenience - I don't really expect that much additional
outside review comments ;-) .


Heiko



