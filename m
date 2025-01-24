Return-Path: <stable+bounces-110361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D3DA1B06F
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 07:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1B03AC5F6
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 06:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B111D90A7;
	Fri, 24 Jan 2025 06:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="V7rZp0U4"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40EC1D5CD4;
	Fri, 24 Jan 2025 06:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737700561; cv=none; b=AJi9dHdYDgdX8gFk53rlZ2tZ5aquRn5t8kSgLfXDDkodMkSSekCr7B47SvW18vLmijCAOZB939Y0P4Z0IgNnN2aLx9N0NqRT6vUsrSg9SiQrpZd8nOksnsfCPEa2yiaoTUzDyMp95QGukCDlUFQH/L0GH7jBc/9w8jwg/CwdH7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737700561; c=relaxed/simple;
	bh=WehGuOZPruh3HK8C0tSDDUs3YUz71+0V2RKd11uplro=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OUfCccqnL27B7howOr0Q9k5VbhpExM6A2T6Cq2Ifu/dnT3865j3x4peBoIE/spL3xQ04ZstfKnI/wVGB5aMFYBrPhG7W3OF6TLjgCu5YGsVJXRY49FfyHqqlyXl2lbzoe0Ue7ilrt+P4547meCmlV+Y1zNNA7cIS+t73XH9CLH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=V7rZp0U4; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1737700551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDcVaVVMzrXp9l580+Ibh1Pcrfg4xdal5MP+F108Ii4=;
	b=V7rZp0U47HCH4FUtf6IyKFL7rtDgum7Ud4Vaha/e1ppJBCu+Rkeo6qkO/da+tnAvVu5Oln
	vAy3Uuxq7HvTq9OsNkRaoIQJbdcYQXun/CDw5H8ivsu0PAtAuf2YBwsKGhB91FLiBIaTVJ
	VLCsJXbS196nQF5idKZ/Io+zLZDdDvTs9nrIkBnsSq0v436BKJSpMbEt0PARPWn5ClCenE
	r2SMOEBy2/RAbJvGsRSERPjqKzjGzwYL0u90eGnNFDskz8LIv8eE+tZonUmJtVKNQgUI6J
	QLghRufuU70FSaRfLVD22ZJ0BhxYCC6chXxW/nUmTtM+sas+WrFbA/T9H6mNvA==
Date: Fri, 24 Jan 2025 07:35:50 +0100
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
In-Reply-To: <98387508-10de-4c2e-80ad-05d0d86b7006@gmail.com>
References: <20250119091154.1110762-1-cnsztl@gmail.com>
 <ce15f141688c4c537ac3307b6fbed283@manjaro.org>
 <59893a67-18c7-4ab3-9b2a-5a17091d4b6c@gmail.com>
 <dffd06a341b58e9689f578c3456cc11d@manjaro.org>
 <65f4e27f-3dc4-4eaf-be4d-265ce0325ade@gmail.com>
 <98387508-10de-4c2e-80ad-05d0d86b7006@gmail.com>
Message-ID: <59e46b34e1c8f9197565fea917335d3f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Tianling,

On 2025-01-24 07:28, Tianling Shen wrote:
> On 2025/1/19 23:48, Tianling Shen wrote:
>> On 2025/1/19 19:36, Dragan Simic wrote:
>>> On 2025-01-19 12:15, Tianling Shen wrote:
>>>> On 2025/1/19 17:54, Dragan Simic wrote:
>>>>> Thanks for the patch.  Please, see a comment below.
>>>>> 
>>>>> On 2025-01-19 10:11, Tianling Shen wrote:
>>>>>> In general the delay should be added by the PHY instead of the 
>>>>>> MAC,
>>>>>> and this improves network stability on some boards which seem to
>>>>>> need different delay.
>>>>>> 
>>>>>> Fixes: 387b3bbac5ea ("arm64: dts: rockchip: Add Xunlong OrangePi 
>>>>>> R1 Plus LTS")
>>>>>> Cc: stable@vger.kernel.org # 6.6+
>>>>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>>>>> ---
>>>>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts | 3 
>>>>>> +--
>>>>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts     | 1 
>>>>>> +
>>>>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi    | 1 
>>>>>> -
>>>>>>  3 files changed, 2 insertions(+), 3 deletions(-)
>>>>>> 
>>>>>> diff --git
>>>>>> a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>>>>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>>>>> index 67c246ad8b8c..ec2ce894da1f 100644
>>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>>>>> @@ -17,8 +17,7 @@ / {
>>>>>> 
>>>>>>  &gmac2io {
>>>>>>      phy-handle = <&yt8531c>;
>>>>>> -    tx_delay = <0x19>;
>>>>>> -    rx_delay = <0x05>;
>>>>>> +    phy-mode = "rgmii-id";
>>>>> 
>>>>> Shouldn't the "tx_delay" and "rx_delay" DT parameters be converted
>>>>> into the "tx-internal-delay-ps" and "rx-internal-delay-ps" 
>>>>> parameters,
>>>>> respectively, so the Motorcomm PHY driver can pick them up and
>>>>> actually configure the internal PHY delays?
>>>> 
>>>> The documentation[1] says "{t,r}x-internal-delay-ps" default to 1950
>>>> and that value already works fine on my board.
>>>> 
>>>> 1. https://www.kernel.org/doc/Documentation/devicetree/bindings/net/ 
>>>> motorcomm%2Cyt8xxx.yaml
>>> 
>>> I see, but those values differ from the values found in the
>>> "tx_delay" and "rx_delay" DT parameters, so I think this patch
>>> should be tested with at least one more Orange Pi R1 Plus LTS
>>> board, to make sure it's all still fine.
>> 
>> This patch has been tested on 2 boards, and we will do more tests in 
>> next week.
>> 
> 
> Managed to test on another board and looks so far so good.
> (Working network connection, no packet drop)

Sounds good to me, thanks for the additional testing.

>>>>>>      status = "okay";
>>>>>> 
>>>>>>      mdio {
>>>>>> diff --git 
>>>>>> a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>>>>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>>>>> index 324a8e951f7e..846b931e16d2 100644
>>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>>>>> @@ -15,6 +15,7 @@ / {
>>>>>> 
>>>>>>  &gmac2io {
>>>>>>      phy-handle = <&rtl8211e>;
>>>>>> +    phy-mode = "rgmii";
>>>>>>      tx_delay = <0x24>;
>>>>>>      rx_delay = <0x18>;
>>>>>>      status = "okay";
>>>>>> diff --git 
>>>>>> a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>>>>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>>>>> index 4f193704e5dc..09508e324a28 100644
>>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>>>>> @@ -109,7 +109,6 @@ &gmac2io {
>>>>>>      assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
>>>>>>      assigned-clock-parents = <&gmac_clk>, <&gmac_clk>;
>>>>>>      clock_in_out = "input";
>>>>>> -    phy-mode = "rgmii";
>>>>>>      phy-supply = <&vcc_io>;
>>>>>>      pinctrl-0 = <&rgmiim1_pins>;
>>>>>>      pinctrl-names = "default";

