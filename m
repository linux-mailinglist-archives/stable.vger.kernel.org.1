Return-Path: <stable+bounces-110360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE518A1B067
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 07:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD263AB6E5
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 06:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92831D9A7D;
	Fri, 24 Jan 2025 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvwWfQpv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB31D8E16;
	Fri, 24 Jan 2025 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737700121; cv=none; b=POH1MsHuXP6cFBmbRMU5DZQPKPlJJqS8BgyhAMdcP7SUPIz1vM+XKybWgfEt1FEHGZ9FWKzwXhl9ProeiqkpxU9Nm+sZ9vpvt9eoTWqNFjyD8IelPndP2h6DB55xAHOaMKo5h9hyNKby9djQTxyahzTEKfzGqZEoDcjPfgq98BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737700121; c=relaxed/simple;
	bh=j7Sb1nRdSYsrGcVm+Q/v14RfN5XHlU/sgNT4rR6RPJU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pC8/uD4RE68ie1SulWSqM2Wf41p3m4Z1hwjLpo6z453pquNcEHsrszCP1jOQ+Nokd2G4L+WRl46jU/twp+5KCiRE82MhBlTvULgxLpRBX4onOQTDtiuup9wM8welw5skfqfW43ADMLHRSUOBUTxYsPoH8FolM81F0Bn34c07PSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvwWfQpv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166651f752so23503995ad.3;
        Thu, 23 Jan 2025 22:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737700119; x=1738304919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeN5L2YEWJnNE+LNbwNgDchuAps1f8wGg5gZvbxuxxw=;
        b=BvwWfQpvAAd9mKmAooRvyDohRPkeERxi3od/ZRgCQxbg9EKh3MGfJ6nDow/pCH5DdN
         lEXUwl2O6SF2WAVYaloXnn71x2EKjRJ3rF15jYQWmjaoAz+mXRCNQAXRJXmczulf27+3
         DuKc3H+fOC5sXtPSpLiOojFiydpXxjaOWGllAHRu97AiOSR1x9yKjVh2j3OtOGnu1xCt
         6LuTpKzwlCzog0epaz5GAmmjZ/Gfq2y2SeZXVky1lkYp13Dle4ogU9IVkKFeWqWd4PiT
         6Ld/MpXpZw9YjIHCwLyrMeyt4iqSMcfexZA1qnD+m8Y2hnzPjx7ITW8TLxzLzc6gFTmW
         6DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737700119; x=1738304919;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JeN5L2YEWJnNE+LNbwNgDchuAps1f8wGg5gZvbxuxxw=;
        b=G2kpr/mLJHxDWMiwrgXG/37+Uy81y3lR3V3W7vfNZE/FYg+mz82DhjqnyuJmoZljb/
         iDZF8W4JASLsgWDe/zniihD0x1gS1X8G0g8Ng4FQPztrFYcCuDLH+qepPLWRYj8oi97B
         QI34eCQPH0T5XOyhUbUDm9K5MVJgMN9ixwaVhyh3BnitdJ0J0Ve/23xoT2IyAybimEvs
         nziLdKXQkVpJzULLDLZ7DpupsaZy/OHDp/msnohr/l3aiXJUN6cOsWmT7B2x8fhcFf5q
         ijoBax610GiT3kwhWsJSOzk7MwRvqocUFyi+Qtge7NneoVc54BQUjWRa0IHShVV3/wfJ
         Neqw==
X-Forwarded-Encrypted: i=1; AJvYcCU/dBgiyjmcP3OdQK6tZNX7egpWqIZDjUipdau1ILmIipMzLxNDXD4J8YA7pCPk8ptpXH9yNEw42DHrF2/Z@vger.kernel.org, AJvYcCUUf8MfJYGTcid//hgMQH8g2dnUInZP86IvEjutB8NuMzNvitpxXNNTh0o1MAYU5Ydk7tsT0DCj2pIv@vger.kernel.org, AJvYcCWiJzLy2SVWTp3lrHN01NAT6d2XKUwpApsnYJKta3xEkrg7T4k7GYQBI4EuxGeyKiDD5L6wUIii@vger.kernel.org
X-Gm-Message-State: AOJu0YxKiG2m7hKxF4BXqHzkAGeLj1hnXwHEdypKEUMGy3o3qDkYoq/N
	DsdkcWG0KDp+NChRG8wE6NViVAVxUXWzceYpQvG8iROU2TxKYa4p
X-Gm-Gg: ASbGnctIPYiv7sZMH7HKlZo5quvwTwSBpUHVUxoGcegU4Vx50PULolY0bofUqniflrn
	3OJoRH4uBmvHpR58sESZt+ec5Tm2CSuBL40Dyu784RRQ4e2gDLuELN0HgQP+109FacILJjmt4Iy
	3WAKkasWyHmBk2Z4tTIbd9RydT7s6qeWhzxmdvQ5YK1GPzZw3L2EOaq8BUkKCkPHJFsey0vDpBg
	PTmU+vry/MiQRGtPk/LJsEMjlenMFJS5x6ASEdtBnKci45vUuHAaMhuaNAL6jqps25IelXq6D6n
	t6ly25klw0wCxmPzZ2M3C8oOp/NDz+rpzrnLgfpPwaoJzQ==
X-Google-Smtp-Source: AGHT+IHY/D+A068yAUx/g7x+kFr63Bnlf+rIa04USNxKmK/2NSr0XdbeFHP/urcYPUPpXZvoC5hi8Q==
X-Received: by 2002:a17:903:2312:b0:216:69ca:770b with SMTP id d9443c01a7336-21c3550eaacmr474494645ad.12.1737700118732;
        Thu, 23 Jan 2025 22:28:38 -0800 (PST)
Received: from ?IPV6:2408:8362:245d:56a8:bc4b:53ff:fead:2724? ([2401:b60:5:867d:3631:b7db:c3f4:aae2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141dacsm8967865ad.133.2025.01.23.22.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 22:28:38 -0800 (PST)
Message-ID: <98387508-10de-4c2e-80ad-05d0d86b7006@gmail.com>
Date: Fri, 24 Jan 2025 14:28:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: change eth phy mode to rgmii-id for
 orangepi r1 plus lts
From: Tianling Shen <cnsztl@gmail.com>
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
 <65f4e27f-3dc4-4eaf-be4d-265ce0325ade@gmail.com>
In-Reply-To: <65f4e27f-3dc4-4eaf-be4d-265ce0325ade@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/1/19 23:48, Tianling Shen wrote:
> On 2025/1/19 19:36, Dragan Simic wrote:
>> On 2025-01-19 12:15, Tianling Shen wrote:
>>> On 2025/1/19 17:54, Dragan Simic wrote:
>>>> Thanks for the patch.  Please, see a comment below.
>>>>
>>>> On 2025-01-19 10:11, Tianling Shen wrote:
>>>>> In general the delay should be added by the PHY instead of the MAC,
>>>>> and this improves network stability on some boards which seem to
>>>>> need different delay.
>>>>>
>>>>> Fixes: 387b3bbac5ea ("arm64: dts: rockchip: Add Xunlong OrangePi R1 
>>>>> Plus LTS")
>>>>> Cc: stable@vger.kernel.org # 6.6+
>>>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts | 3 +--
>>>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts     | 1 +
>>>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi    | 1 -
>>>>>  3 files changed, 2 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git
>>>>> a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>>>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>>>> index 67c246ad8b8c..ec2ce894da1f 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>>>>> @@ -17,8 +17,7 @@ / {
>>>>>
>>>>>  &gmac2io {
>>>>>      phy-handle = <&yt8531c>;
>>>>> -    tx_delay = <0x19>;
>>>>> -    rx_delay = <0x05>;
>>>>> +    phy-mode = "rgmii-id";
>>>>
>>>> Shouldn't the "tx_delay" and "rx_delay" DT parameters be converted
>>>> into the "tx-internal-delay-ps" and "rx-internal-delay-ps" parameters,
>>>> respectively, so the Motorcomm PHY driver can pick them up and
>>>> actually configure the internal PHY delays?
>>>
>>> The documentation[1] says "{t,r}x-internal-delay-ps" default to 1950
>>> and that value already works fine on my board.
>>>
>>> 1. https://www.kernel.org/doc/Documentation/devicetree/bindings/net/ 
>>> motorcomm%2Cyt8xxx.yaml
>>
>> I see, but those values differ from the values found in the
>> "tx_delay" and "rx_delay" DT parameters, so I think this patch
>> should be tested with at least one more Orange Pi R1 Plus LTS
>> board, to make sure it's all still fine.
> 
> This patch has been tested on 2 boards, and we will do more tests in 
> next week.
> 

Managed to test on another board and looks so far so good.
(Working network connection, no packet drop)

Thanks,
Tianling.

> Thanks,
> Tianling.
> 
>>
>>>>
>>>>>      status = "okay";
>>>>>
>>>>>      mdio {
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>>>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>>>> index 324a8e951f7e..846b931e16d2 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>>>>> @@ -15,6 +15,7 @@ / {
>>>>>
>>>>>  &gmac2io {
>>>>>      phy-handle = <&rtl8211e>;
>>>>> +    phy-mode = "rgmii";
>>>>>      tx_delay = <0x24>;
>>>>>      rx_delay = <0x18>;
>>>>>      status = "okay";
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>>>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>>>> index 4f193704e5dc..09508e324a28 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>>>>> @@ -109,7 +109,6 @@ &gmac2io {
>>>>>      assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
>>>>>      assigned-clock-parents = <&gmac_clk>, <&gmac_clk>;
>>>>>      clock_in_out = "input";
>>>>> -    phy-mode = "rgmii";
>>>>>      phy-supply = <&vcc_io>;
>>>>>      pinctrl-0 = <&rgmiim1_pins>;
>>>>>      pinctrl-names = "default";
> 


