Return-Path: <stable+bounces-109485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C173DA16163
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 12:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08FA3A6804
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 11:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6621B21AA;
	Sun, 19 Jan 2025 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="fowsOrqX"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15DD2F2F;
	Sun, 19 Jan 2025 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737286616; cv=none; b=EOwE+Wjn5rB30hcdR0JShm4jGn6iAOpnr+i6HjhkogckDLl91bqFn/+Hvg2m9sNfbv/G8wHVpNix0pk1z3GYa9kd0so2McMHMBo7AxgCQ7FfHW1+52ROPIydi+/pOf1Lzsn5T96pzMWezXvUiK1FDf9m9z8Ng0MANCca9LgR6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737286616; c=relaxed/simple;
	bh=tnC3cVs+hRwTDlHKVY2GWtqM6FUVAyHNOTtxstrZ6I0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Vhzt61pbe3bgM+BVK37c56PM1D+VVOUxbL80/f8AxjP5sx8u8tbyzkWNgvodcnr+t2miH9KwvL3lPngJE6LK6/p08Csk9HCBRAsJwFSmeuRkcOyGNUvayFhOjMbTLAT6M98ptvTX5BniPWpyI5s1HhJ739qzpySWyeBJw+YtYjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=fowsOrqX; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1737286612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INVDIv/HWfQ/VgBF6o3bOQpBfdqdzLV30nK1vf4ycdw=;
	b=fowsOrqXCmNuhDPRWhfaMHpCXeNNY9+gEwBhJYXcWhfjuicO50pAZEm6kv8Tnc5DD2B6he
	QeRLQIuNb9lQTG6n+xjB+r9KRLQeRNfqlfNW6sZxQ4Sygc5UMbBT0jiN7xHExkiey1w5SB
	gWKeHiuKIsjglMi9NAToLapjsZFGH7jaCfpi3SruDewz2UFaM8ini85tLbLRDePtRCaMo+
	FH2B/peXfqOqBV5dq3225qf/mpA4xpshLXNjuF8HP302aHsd/a53BsTdBTwaDt7pPGOPxb
	OiS5fWzadzwZmfYZkB9Ud6csyb1YSzqJ/31DlngJQidPxyKfmJFtxl5NReZLjQ==
Date: Sun, 19 Jan 2025 12:36:52 +0100
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
In-Reply-To: <59893a67-18c7-4ab3-9b2a-5a17091d4b6c@gmail.com>
References: <20250119091154.1110762-1-cnsztl@gmail.com>
 <ce15f141688c4c537ac3307b6fbed283@manjaro.org>
 <59893a67-18c7-4ab3-9b2a-5a17091d4b6c@gmail.com>
Message-ID: <dffd06a341b58e9689f578c3456cc11d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2025-01-19 12:15, Tianling Shen wrote:
> On 2025/1/19 17:54, Dragan Simic wrote:
>> Thanks for the patch.  Please, see a comment below.
>> 
>> On 2025-01-19 10:11, Tianling Shen wrote:
>>> In general the delay should be added by the PHY instead of the MAC,
>>> and this improves network stability on some boards which seem to
>>> need different delay.
>>> 
>>> Fixes: 387b3bbac5ea ("arm64: dts: rockchip: Add Xunlong OrangePi R1 
>>> Plus LTS")
>>> Cc: stable@vger.kernel.org # 6.6+
>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts | 3 +--
>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts     | 1 +
>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi    | 1 -
>>>  3 files changed, 2 insertions(+), 3 deletions(-)
>>> 
>>> diff --git
>>> a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>> index 67c246ad8b8c..ec2ce894da1f 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>> @@ -17,8 +17,7 @@ / {
>>> 
>>>  &gmac2io {
>>>      phy-handle = <&yt8531c>;
>>> -    tx_delay = <0x19>;
>>> -    rx_delay = <0x05>;
>>> +    phy-mode = "rgmii-id";
>> 
>> Shouldn't the "tx_delay" and "rx_delay" DT parameters be converted
>> into the "tx-internal-delay-ps" and "rx-internal-delay-ps" parameters,
>> respectively, so the Motorcomm PHY driver can pick them up and
>> actually configure the internal PHY delays?
> 
> The documentation[1] says "{t,r}x-internal-delay-ps" default to 1950
> and that value already works fine on my board.
> 
> 1. 
> https://www.kernel.org/doc/Documentation/devicetree/bindings/net/motorcomm%2Cyt8xxx.yaml

I see, but those values differ from the values found in the
"tx_delay" and "rx_delay" DT parameters, so I think this patch
should be tested with at least one more Orange Pi R1 Plus LTS
board, to make sure it's all still fine.

>> 
>>>      status = "okay";
>>> 
>>>      mdio {
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>> index 324a8e951f7e..846b931e16d2 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>> @@ -15,6 +15,7 @@ / {
>>> 
>>>  &gmac2io {
>>>      phy-handle = <&rtl8211e>;
>>> +    phy-mode = "rgmii";
>>>      tx_delay = <0x24>;
>>>      rx_delay = <0x18>;
>>>      status = "okay";
>>> diff --git 
>>> a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>> index 4f193704e5dc..09508e324a28 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>> @@ -109,7 +109,6 @@ &gmac2io {
>>>      assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
>>>      assigned-clock-parents = <&gmac_clk>, <&gmac_clk>;
>>>      clock_in_out = "input";
>>> -    phy-mode = "rgmii";
>>>      phy-supply = <&vcc_io>;
>>>      pinctrl-0 = <&rgmiim1_pins>;
>>>      pinctrl-names = "default";

