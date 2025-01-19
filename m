Return-Path: <stable+bounces-109484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA4CA16157
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 12:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D095316538B
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE711B0420;
	Sun, 19 Jan 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0sfad/e"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401C2905;
	Sun, 19 Jan 2025 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737285364; cv=none; b=mRtjBH3bGFhOdJ23DYxUUCHWbxirpJ2sC7FimKs8rCR0McqbzbEHhLhSCbZoagT/83F/2unvVXHkQ/eUZu5wnLtpv4R3cXJTMSsTYlwK2TT9d5iDnNWlbhFYCi4zSpSr7K0TNEpCpIk/YxeuQfyEQGXwQL/4V3uWZMXEu0iMtVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737285364; c=relaxed/simple;
	bh=IDueMa37i4dWX7Tn9RD3kf9FqIjkgnSgpD61uu7O6iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+M3BHkjFRPGcmSJio3HvexA/prWqoAxGA67tgmb8SP08F9NsX+/XczdndX2uxjGAXPvZ8hVWRztdQPWgZByp57mQj/1avEJAXP5jFDlHmTHiOVxGnJyYvUd0GiZobDFiPjE5zr1Y31YI3Lu5fwOil+RNnpI3H3l8GOH/i2f5kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0sfad/e; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-218c8aca5f1so84957195ad.0;
        Sun, 19 Jan 2025 03:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737285362; x=1737890162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFwAN4NPK1DZJMX46y1FOD2OnkFuCtYDMQ81C7qA/Ns=;
        b=g0sfad/eMuB5RZd9AWdHEXl/cdxd2jIy0gLsOsNYbZNb7kTh64hWZaqBI3x/mnE3EQ
         t4Ws1T4HmULfOqSEGMZiLtSfcE9TiLNtLqRcRM6uB1WtIrstLtzJTd+He8DXUxEMreVP
         gnOG7CzUOb6Udtpv62Vj+xwuM+GbSesaVeWiZif0ODQl6G9Xy2uz/uyZIECy9b6P+28g
         XZnnErVbmi78cHuxJr9vus85jaLa8Q77XfzfWl6wHcjAejSt+uNCxjl+WIXnSIrhsy8L
         juEYvtYONyYmOtrWD3ZItDXL4Tx60owL+23ZJc6x87FTV4idxZi2M/XuZy5Ed7LcjfFG
         qcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737285362; x=1737890162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jFwAN4NPK1DZJMX46y1FOD2OnkFuCtYDMQ81C7qA/Ns=;
        b=sgDzF0+ygCeBql7PwtSBAAxCAfhcnDqSJq5h5IfspluerbjIi6JLnKZo9HgLYz1bVn
         OrjjTJ8qRr15L88UUNfheUAACuLAcoVRLft2hTGTtyy0Iq/uhU96Nrbz4squ7+mHVApN
         I2CH28lSyx/MzvLf7xO4X/xjZYF/Zg9pYgQV0qaKY1DWrnpdrArl48J1MeU+qUp8DKW2
         bcyxtqWw5Bxm8hrfX7zUvqaKCUGiIyqCrJIlFfNO16vi5N40xlQ4NCSBpGW5ZVnZh14Z
         Cj7b83WwSIhfwqEaRBvpNXJnn8OnR8HPaoaVe6uLnIO5GSv9h4ToA3cb0tF/gge6WwVg
         J2DA==
X-Forwarded-Encrypted: i=1; AJvYcCUD/Q92Qu9pICsx/zMkBhvlHlrGXoRWJCG5GRuD+BMxW6Xkqx4mFXpfe031i8xHcVEtjMKW8axfrqa47mEK@vger.kernel.org, AJvYcCURmhFsG7Ke0+61rzBkTkclQ6G+RjI9ao5CmNRDAIyt37FegMu0cjrcDJVtjP+CJxqjxGJ2c/97@vger.kernel.org, AJvYcCWSaNyZyeQis6CchL/fNzPVuxbosiBSa2H8XSM9xH5MxbXleN9I1he6pC8OaPZNXk3RHr9JAyOzPt56@vger.kernel.org
X-Gm-Message-State: AOJu0YwIi+5t4DeBi6ChEktX09ruQPqLDuuNorW7m3v35668lz25fnyl
	LVCUi1DDdt1CY/RFrFUtfLx8YV77HGUBTo/DWNV6UjuCOQBGQVdn
X-Gm-Gg: ASbGncuXhoMWMQ2Gj8A5VqPNOGESdRvCuwczBX7W9UT5zxdMIfEp1ntMiByOMqOMnlo
	BOUbsQ6MOMQW+QLyEJ/Ms4Lhlq6vQn4EQX5vOPajfLnunWu1GBJKZvApIniBBG1SEV31vnJwshF
	8S0J5UqaS7p7u0GIQd80dHjtHQ6LaiIsN7DibNC0bOepjfUbi/mQ5kIM/GYvUqNyvg4ftJXX9Jb
	oF/0MLiG0q3sL/1thj8WB2iy2dX/YlbuuSMiMR/ivXpznfYWhLCDmRp6IRYDAe7DxnxbBu2iERw
	yTg6uRllvtIx2QmZBGbM/hoqUMS9SI/N9Po+
X-Google-Smtp-Source: AGHT+IHaTt00aOKIg9mcDnsHrjnAg6faqbxOOHMpsfBN2LwzL1GNhhYFrCUK2KkmLZAv0vVu7zGv+Q==
X-Received: by 2002:a17:903:186:b0:216:69ca:772a with SMTP id d9443c01a7336-21c3563ee3fmr144590885ad.53.1737285361827;
        Sun, 19 Jan 2025 03:16:01 -0800 (PST)
Received: from ?IPV6:2408:8362:245d:4738:bc4b:53ff:fead:2724? ([2401:b60:5:867d:3631:b7db:c3f4:aae2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3a87e4sm43606145ad.111.2025.01.19.03.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2025 03:16:01 -0800 (PST)
Message-ID: <59893a67-18c7-4ab3-9b2a-5a17091d4b6c@gmail.com>
Date: Sun, 19 Jan 2025 19:15:55 +0800
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
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <ce15f141688c4c537ac3307b6fbed283@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dragan,

On 2025/1/19 17:54, Dragan Simic wrote:
> Hello Tianling,
> 
> Thanks for the patch.  Please, see a comment below.
> 
> On 2025-01-19 10:11, Tianling Shen wrote:
>> In general the delay should be added by the PHY instead of the MAC,
>> and this improves network stability on some boards which seem to
>> need different delay.
>>
>> Fixes: 387b3bbac5ea ("arm64: dts: rockchip: Add Xunlong OrangePi R1 
>> Plus LTS")
>> Cc: stable@vger.kernel.org # 6.6+
>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts | 3 +--
>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts     | 1 +
>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi    | 1 -
>>  3 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git
>> a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>> index 67c246ad8b8c..ec2ce894da1f 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>> @@ -17,8 +17,7 @@ / {
>>
>>  &gmac2io {
>>      phy-handle = <&yt8531c>;
>> -    tx_delay = <0x19>;
>> -    rx_delay = <0x05>;
>> +    phy-mode = "rgmii-id";
> 
> Shouldn't the "tx_delay" and "rx_delay" DT parameters be converted
> into the "tx-internal-delay-ps" and "rx-internal-delay-ps" parameters,
> respectively, so the Motorcomm PHY driver can pick them up and
> actually configure the internal PHY delays?

The documentation[1] says "{t,r}x-internal-delay-ps" default to 1950 and 
that value already works fine on my board.

1. 
https://www.kernel.org/doc/Documentation/devicetree/bindings/net/motorcomm%2Cyt8xxx.yaml

Thanks,
Tianling.

> 
>>      status = "okay";
>>
>>      mdio {
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>> index 324a8e951f7e..846b931e16d2 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
>> @@ -15,6 +15,7 @@ / {
>>
>>  &gmac2io {
>>      phy-handle = <&rtl8211e>;
>> +    phy-mode = "rgmii";
>>      tx_delay = <0x24>;
>>      rx_delay = <0x18>;
>>      status = "okay";
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>> index 4f193704e5dc..09508e324a28 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>> @@ -109,7 +109,6 @@ &gmac2io {
>>      assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
>>      assigned-clock-parents = <&gmac_clk>, <&gmac_clk>;
>>      clock_in_out = "input";
>> -    phy-mode = "rgmii";
>>      phy-supply = <&vcc_io>;
>>      pinctrl-0 = <&rgmiim1_pins>;
>>      pinctrl-names = "default";


