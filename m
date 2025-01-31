Return-Path: <stable+bounces-111786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E8AA23B10
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 10:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AA01887B45
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54E3186294;
	Fri, 31 Jan 2025 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ls3/hWsG"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B976176242;
	Fri, 31 Jan 2025 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738314623; cv=none; b=aHJnAsnEKXHSPzyh6uecDiHyZ0u/hKNA/D8H+XhOL3/ZQncqbpH9wg+gtRrQ1BykRT2J8APcy9+w8qL7ozY6Bu5yUhqUKHYHKC8lN9zQctdZxeS15P5TDMs3IizeGmRPyI71bRA0qMTuBN7U2VbkrrfmfZZJVY3oWoU7bTkmnzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738314623; c=relaxed/simple;
	bh=Zq1U6bkea/u9ETwViK/08OSEGHkjaLa87mgwuyoS/CU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=o9Z1uTOhbH3Izgk/S5sUcgWoMjQ+urjII9XSvS9Wy5oacsLhofclanCrA4Fg07N1dVF2aruSJSg0pzrB/JDTuQ9CLdPwq3AxkJYaluogB6VHPSJnMcklofdilJr/M1R9ZRnG8PwUY3o4f47/V2QucWsFx+4zu4NrB26UABe2/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ls3/hWsG; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1738314613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w66nwBa+GHbxorNXdWjdWunCnuLe88jUElmyfHxjB78=;
	b=ls3/hWsGrRsivnoaVnIbnPU1Uf9z93L4dfcm0vJAunbPNK7qG5fKxjGBSNBFijT7dwRS/a
	bz5zyUjR9T69n04l9K6VWu6S05JU/Q2pI3Qu8UfwBcGAjPf9+EZ033YZTwxR7VqYWU29cT
	Hw9iqepXFumcPBXREvGBz5CnlTIGAFcRPM+XPa41FiOqXfvEZ3l2rN+/cSsMSMJ/9hO0AY
	ZdiwDDeJIg8e93wV1GJTfiymUPl7n81Pkslusc+Ffsxl1VkMOTgBHMnalLrKfmjrHXGEj8
	mQOJdfKvuyGmffR87bZtmzrJ4TLKUFA6WfQV55kTHgiCE7oQQOHasdnoRoDFUA==
Date: Fri, 31 Jan 2025 10:10:13 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: change eth phy mode to rgmii-id for
 orangepi r1 plus lts
In-Reply-To: <2910311.mvXUDI8C0e@phil>
References: <20250119091154.1110762-1-cnsztl@gmail.com>
 <98387508-10de-4c2e-80ad-05d0d86b7006@gmail.com>
 <59e46b34e1c8f9197565fea917335d3f@manjaro.org> <2910311.mvXUDI8C0e@phil>
Message-ID: <19d3590613746aef9af98361d8cda4bc@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2025-01-31 10:01, Heiko Stuebner wrote:
> Am Freitag, 24. Januar 2025, 07:35:50 MEZ schrieb Dragan Simic:
>> On 2025-01-24 07:28, Tianling Shen wrote:
>> > On 2025/1/19 23:48, Tianling Shen wrote:
>> >> On 2025/1/19 19:36, Dragan Simic wrote:
>> >>> On 2025-01-19 12:15, Tianling Shen wrote:
>> >>>> On 2025/1/19 17:54, Dragan Simic wrote:
>> >>>>> Thanks for the patch.  Please, see a comment below.
>> >>>>>
>> >>>>> On 2025-01-19 10:11, Tianling Shen wrote:
>> >>>>>> In general the delay should be added by the PHY instead of the
>> >>>>>> MAC,
>> >>>>>> and this improves network stability on some boards which seem to
>> >>>>>> need different delay.
>> >>>>>>
>> >>>>>> Fixes: 387b3bbac5ea ("arm64: dts: rockchip: Add Xunlong OrangePi
>> >>>>>> R1 Plus LTS")
>> >>>>>> Cc: stable@vger.kernel.org # 6.6+
>> >>>>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>> >>>>>> ---
>> >>>>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts | 3
>> >>>>>> +--
>> >>>>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts     | 1
>> >>>>>> +
>> >>>>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi    | 1
>> >>>>>> -
>> >>>>>>  3 files changed, 2 insertions(+), 3 deletions(-)
>> >>>>>>
>> >>>>>> diff --git
>> >>>>>> a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>> >>>>>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>> >>>>>> index 67c246ad8b8c..ec2ce894da1f 100644
>> >>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>> >>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
>> >>>>>> @@ -17,8 +17,7 @@ / {
>> >>>>>>
>> >>>>>>  &gmac2io {
>> >>>>>>      phy-handle = <&yt8531c>;
>> >>>>>> -    tx_delay = <0x19>;
>> >>>>>> -    rx_delay = <0x05>;
>> >>>>>> +    phy-mode = "rgmii-id";
>> >>>>>
>> >>>>> Shouldn't the "tx_delay" and "rx_delay" DT parameters be converted
>> >>>>> into the "tx-internal-delay-ps" and "rx-internal-delay-ps"
>> >>>>> parameters,
>> >>>>> respectively, so the Motorcomm PHY driver can pick them up and
>> >>>>> actually configure the internal PHY delays?
>> >>>>
>> >>>> The documentation[1] says "{t,r}x-internal-delay-ps" default to 1950
>> >>>> and that value already works fine on my board.
>> >>>>
>> >>>> 1. https://www.kernel.org/doc/Documentation/devicetree/bindings/net/
>> >>>> motorcomm%2Cyt8xxx.yaml
>> >>>
>> >>> I see, but those values differ from the values found in the
>> >>> "tx_delay" and "rx_delay" DT parameters, so I think this patch
>> >>> should be tested with at least one more Orange Pi R1 Plus LTS
>> >>> board, to make sure it's all still fine.
>> >>
>> >> This patch has been tested on 2 boards, and we will do more tests in
>> >> next week.
>> >
>> > Managed to test on another board and looks so far so good.
>> > (Working network connection, no packet drop)
>> 
>> Sounds good to me, thanks for the additional testing.
> 
> I assume that means there are no more open issues, right?
> At least I got that impression from glancing at the thread :-)

Yes, Tianling performed the additional testing, and the
introduced changes worked fine on three boards in total.
To me, that sounds good. :)

