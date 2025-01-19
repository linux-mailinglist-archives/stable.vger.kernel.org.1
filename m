Return-Path: <stable+bounces-109482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B2EA160FF
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 10:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9221886923
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 09:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4034519B59C;
	Sun, 19 Jan 2025 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="drMt13D0"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E72B18785D;
	Sun, 19 Jan 2025 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737280477; cv=none; b=idy2Q+ECFN1T1TVlOzlcZX08fSp6eKsyvvs+LxLz8Hiiq9fL84T1199gDyappnV3WmYcG+epy1JtbYXyWI8J2mpJcuFCMri9Z5ociC8gU+RqNgHJKdDDUlmuDhtB4786sTeL7ab4JEGVjfK2w+tj7cykYipWpS5FqfV2upPV1LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737280477; c=relaxed/simple;
	bh=a2HPdfGRCMj1csM8sqfY80PbZwMYLa+7+5TANotaYIM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mcS+u12BrVgDda4S7ee3N/IUjkd/EvzJl6kJYDtxFop6hdGlEMY3UpQ49Jdo8WdFGDFiZYKe3e9zdBlIRJFVkDUfYhExJB3bE+uIV80b1oQuxUAIqCrNYBJvjXgNkJj0gVodGrSTz8TTDmFyZXhrmKgrGNbe7zPp2vnXcznnoDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=drMt13D0; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1737280467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Nn8k0teNFTxka8BR1o7+iPaNbCVsXSlBEh/pZkZiuo=;
	b=drMt13D0mBESnIRSdJoKIs2O0Yvux4WeblsUGg/ncC6gnX7mJagQ9HKA9F4IhaoVe66RXa
	PPOyACc95t9F6FoFzbK5Rpp4+zK3q6zQKS7wZq8LQJ5Ao5ccS4s9n0vQG50Lbsa0DQ1vu6
	ptx2GlRV5jP+nIvuh6OiomR24kYjgG5/Qa2FHVuUjMKpS+bwJCceBbJuAuJPAZ29icgwH2
	JUuNdrJkFYya+hMGTZdI4FS91KqZpioJbsaINii8x3fjL/l9OlIofuSgjyc5lxb0yVqecv
	1koxFbDt0CQgueackgTuG1GJh7rVDDoX5OykF5hHI2PQTWTmwXBsprzNcvNv6A==
Date: Sun, 19 Jan 2025 10:54:26 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Tianling Shen <cnsztl@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jonas
 Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Peter Geis
 <pgwipeout@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: change eth phy mode to rgmii-id for
 orangepi r1 plus lts
In-Reply-To: <20250119091154.1110762-1-cnsztl@gmail.com>
References: <20250119091154.1110762-1-cnsztl@gmail.com>
Message-ID: <ce15f141688c4c537ac3307b6fbed283@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Tianling,

Thanks for the patch.  Please, see a comment below.

On 2025-01-19 10:11, Tianling Shen wrote:
> In general the delay should be added by the PHY instead of the MAC,
> and this improves network stability on some boards which seem to
> need different delay.
> 
> Fixes: 387b3bbac5ea ("arm64: dts: rockchip: Add Xunlong OrangePi R1 
> Plus LTS")
> Cc: stable@vger.kernel.org # 6.6+
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts | 3 +--
>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts     | 1 +
>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi    | 1 -
>  3 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git
> a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
> index 67c246ad8b8c..ec2ce894da1f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
> @@ -17,8 +17,7 @@ / {
> 
>  &gmac2io {
>  	phy-handle = <&yt8531c>;
> -	tx_delay = <0x19>;
> -	rx_delay = <0x05>;
> +	phy-mode = "rgmii-id";

Shouldn't the "tx_delay" and "rx_delay" DT parameters be converted
into the "tx-internal-delay-ps" and "rx-internal-delay-ps" parameters,
respectively, so the Motorcomm PHY driver can pick them up and
actually configure the internal PHY delays?

>  	status = "okay";
> 
>  	mdio {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
> index 324a8e951f7e..846b931e16d2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
> @@ -15,6 +15,7 @@ / {
> 
>  &gmac2io {
>  	phy-handle = <&rtl8211e>;
> +	phy-mode = "rgmii";
>  	tx_delay = <0x24>;
>  	rx_delay = <0x18>;
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
> index 4f193704e5dc..09508e324a28 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
> @@ -109,7 +109,6 @@ &gmac2io {
>  	assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
>  	assigned-clock-parents = <&gmac_clk>, <&gmac_clk>;
>  	clock_in_out = "input";
> -	phy-mode = "rgmii";
>  	phy-supply = <&vcc_io>;
>  	pinctrl-0 = <&rgmiim1_pins>;
>  	pinctrl-names = "default";

