Return-Path: <stable+bounces-109492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFDDA162CE
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 16:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B743A06F0
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF21DB14C;
	Sun, 19 Jan 2025 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEOup5qs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A816D531;
	Sun, 19 Jan 2025 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737301691; cv=none; b=OuVUMA0A3DlBVPd0JK8JC8k49F8ZbvOA006NuQaR3EKWGKhVV4HjETCL5bT3k5gqLLpCrJIXNsUXgmlFTwrYSWspgLRhlr9q0x29Bp0cfng7oQd1BJkij0MST1FxSRurCM8w3F+nANzb5k7rbesVFBPiHvx7HzJxgu6sllVIsvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737301691; c=relaxed/simple;
	bh=ehwc0vdpZCpoJmRBWoRXEisDHYD83uzGJx7P+nUyies=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrqrElOASk+jKHJCNYSu1bplJPjcoyFdgwIvufCBSa8dv4gMfzSKhydFTwAHo6RY+FO5mOdjHRoBZz+ykCx7acWRv9h1HYtLlabGMOqVCS0Tq5fa4FnAUmJXjlWw4+T6Mz9l4l4RxkicNcpzkBsC9AoOz544l8IIQdZ+WmgKLFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEOup5qs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so4692755a91.3;
        Sun, 19 Jan 2025 07:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737301689; x=1737906489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZAYLxkgTuJqE+KNkFf+UOOQy4pcqWaU6mHRJg10BxY=;
        b=mEOup5qsZ23oeODtzlaowv0301MVnZacndP23aG64Er9eINP1x7e40n66moEHXaZqd
         zNda2HrwQ+hCy3aQdloBo4QgQQJqWittni4ThgivKx1J9OsR5Cxahc4rm+1e5v1aQhJe
         BPC5QLbAzm+epZ7i81GwbhBjBUGHBELbGeX3GkGYYhEBo1goh2Yr+V/K/1OjsT2j71D9
         Xizwc2umVFBbnWX0Jbk7slq37tEbRsXh9QDuor6Ogn6W8wuV3AXph1OxT6HgvkGT9vPx
         lJ2Rdr1nFkluX2g33jG0M4onrmJD67T8UF9al3qITz2zbmS+ZGVG68arcJo1a2KUPXa3
         +t+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737301689; x=1737906489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TZAYLxkgTuJqE+KNkFf+UOOQy4pcqWaU6mHRJg10BxY=;
        b=OJsbB1Ju4N7vunAC/cm2pIRwyTaPdx5HqL3EdgiDKqGhEcpjJLXfbwbk43ibaT1VIB
         7508aordGrDcUGL2F47CNeGNQ9yPHmTRwvNb5rt1I2ZpjtoKBCKJO/b1Z0FBaVSkRumq
         e8YfnnbzDEK77jPoMuGsQ6NW9+DX+3PBeQY4oyKb7XDibrQYJxccgq0zCJn/bkUvYTFV
         l137K/eBekm9mjTaQiCU2U+n0m3JB8akocW4t08WnQ4/2SGYPqp5gbwmiXmkjNmTlk9s
         OQ9MmuedWlcYMbjo6hgsdIPtRrvjCXLfqpP0KiWlp+/0W93K/9scDdjxq2KGaiIrNiRq
         dqzw==
X-Forwarded-Encrypted: i=1; AJvYcCW+3eE8gnZQt6Iyp/pym4lOTuhvswctObPkGjcc5/8L6JJfswV+kJtIo2cyYNTObDggplD2oAXwUzdT@vger.kernel.org, AJvYcCWeiocWwkIzjPMh6SDYQwBBc6t2fvCD5wBhSTyAY61b4lTk7TCCXwcIC7BWwBRk58TJ9P1ADIT/BAqTAg0k@vger.kernel.org, AJvYcCWjAnrx1LKL01AxKjdA7W9Ahlg3+RAvYW6sqth2s5E/fBH3Ww0uPnE75d/RZ6yz1v0BHTSFxDQG@vger.kernel.org
X-Gm-Message-State: AOJu0YxNoy9pVJm7h0nput8HNBa8gs3IYkxsy+t8w626y6UyAgi8Z036
	opm4LZqS6l5gVG0+G6uYRFS5iR+NBJpEk7e2OGroOBuHq+q2b+s1
X-Gm-Gg: ASbGnctjLXkTn6pQ5/JurwdF3QDGHiSOaHIH7rDbZPCXy3O2xX5+/PC6TZxvlbGShVR
	bF2zTW4JtPPjPcx2MimYFv8qCL9TYIJKYXKknIJFhzNzJ2oV93knt70gZstQhjaFpGT21xcfEsy
	vLQalPDRKA0vSO0Y+wGC4Qq4t7HHxG5iOJEY3EOprmFFBTR49OR8pRp6wamLG1NScTHcMWlW2ns
	IZeTNegp1WfUm9LxSYWsZphF0UKSZFUlT7NiJLz0SsPwqp3WQIWGbjRJtMGJC9VI8hZoIe0Cjxk
	kItUs0be7arIFR0kYTA9gFK//DtYR88k4nMn
X-Google-Smtp-Source: AGHT+IGvCdSeQSGbyX+8aN4u/Fdvmx1BdTLz8cpVCt8/MNmK2Wh5evJPRODkKIm2pkBBFPhYUCnl6A==
X-Received: by 2002:a17:90b:6c3:b0:2f6:d266:f461 with SMTP id 98e67ed59e1d1-2f782d8c839mr14076613a91.30.1737301688910;
        Sun, 19 Jan 2025 07:48:08 -0800 (PST)
Received: from ?IPV6:2408:8362:245d:4738:bc4b:53ff:fead:2724? ([2401:b60:5:867d:3631:b7db:c3f4:aae2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c14ffaasm8954154a91.4.2025.01.19.07.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2025 07:48:08 -0800 (PST)
Message-ID: <65f4e27f-3dc4-4eaf-be4d-265ce0325ade@gmail.com>
Date: Sun, 19 Jan 2025 23:48:03 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: change eth phy mode to rgmii-id for
 orangepi r1 plus lts
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Peter Geis <pgwipeout@gmail.com>
References: <20250119091154.1110762-1-cnsztl@gmail.com>
 <ce15f141688c4c537ac3307b6fbed283@manjaro.org>
 <59893a67-18c7-4ab3-9b2a-5a17091d4b6c@gmail.com>
 <dffd06a341b58e9689f578c3456cc11d@manjaro.org>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <dffd06a341b58e9689f578c3456cc11d@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/1/19 19:36, Dragan Simic wrote:
> On 2025-01-19 12:15, Tianling Shen wrote:
>> On 2025/1/19 17:54, Dragan Simic wrote:
>>> Thanks for the patch.  Please, see a comment below.
>>>
>>> On 2025-01-19 10:11, Tianling Shen wrote:
>>>> In general the delay should be added by the PHY instead of the MAC,
>>>> and this improves network stability on some boards which seem to
>>>> need different delay.
>>>>
>>>> Fixes: 387b3bbac5ea ("arm64: dts: rockchip: Add Xunlong OrangePi R1 
>>>> Plus LTS")
>>>> Cc: stable@vger.kernel.org # 6.6+
>>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>>> ---
>>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts | 3 +--
>>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts     | 1 +
>>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi    | 1 -
>>>>  3 files changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git
>>>> a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>>> index 67c246ad8b8c..ec2ce894da1f 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>>> @@ -17,8 +17,7 @@ / {
>>>>
>>>>  &gmac2io {
>>>>      phy-handle = <&yt8531c>;
>>>> -    tx_delay = <0x19>;
>>>> -    rx_delay = <0x05>;
>>>> +    phy-mode = "rgmii-id";
>>>
>>> Shouldn't the "tx_delay" and "rx_delay" DT parameters be converted
>>> into the "tx-internal-delay-ps" and "rx-internal-delay-ps" parameters,
>>> respectively, so the Motorcomm PHY driver can pick them up and
>>> actually configure the internal PHY delays?
>>
>> The documentation[1] says "{t,r}x-internal-delay-ps" default to 1950
>> and that value already works fine on my board.
>>
>> 1. https://www.kernel.org/doc/Documentation/devicetree/bindings/net/ 
>> motorcomm%2Cyt8xxx.yaml
> 
> I see, but those values differ from the values found in the
> "tx_delay" and "rx_delay" DT parameters, so I think this patch
> should be tested with at least one more Orange Pi R1 Plus LTS
> board, to make sure it's all still fine.

This patch has been tested on 2 boards, and we will do more tests in 
next week.

Thanks,
Tianling.

> 
>>>
>>>>      status = "okay";
>>>>
>>>>      mdio {
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>>> index 324a8e951f7e..846b931e16d2 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>>> @@ -15,6 +15,7 @@ / {
>>>>
>>>>  &gmac2io {
>>>>      phy-handle = <&rtl8211e>;
>>>> +    phy-mode = "rgmii";
>>>>      tx_delay = <0x24>;
>>>>      rx_delay = <0x18>;
>>>>      status = "okay";
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>>> index 4f193704e5dc..09508e324a28 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>>> @@ -109,7 +109,6 @@ &gmac2io {
>>>>      assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
>>>>      assigned-clock-parents = <&gmac_clk>, <&gmac_clk>;
>>>>      clock_in_out = "input";
>>>> -    phy-mode = "rgmii";
>>>>      phy-supply = <&vcc_io>;
>>>>      pinctrl-0 = <&rgmiim1_pins>;
>>>>      pinctrl-names = "default";


