Return-Path: <stable+bounces-76088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5011497830F
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 16:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07053B254DC
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D0C6F2EE;
	Fri, 13 Sep 2024 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="frB2zXBk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213AC5EE8D
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239421; cv=none; b=azDwBa01QjOl/WsUm8fsnUWnMW+S1tYpdAy3JcrSdsKk8n2zAa0nEAYbYhqSykuuXMoIJeYtkAvAAAYhQn5aUR211UJiCU0f52aym/Xy3Ybn2m+lrxcTX0wCY6vzvjsshI5tJzYV0P5cp2bQfYtompL9z0JV7ARl9vqVa0aoC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239421; c=relaxed/simple;
	bh=bk5fBYoRubuV3SwJbAObGRT8vGObXynBdtgnt0h4beo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roILXGZlyc0eWJHfsjgSHwaVpp7P5tEQvWPsgahWZFeroEbCShBLvXzqXNxAl3K2tiCoqbnFNlRbmVKJGMGAWadnRHQiyiLoGD4eM/S2AR4m5+HlH1qWVDGw1rpZ6325RWQJhvUKsRWCU9q7i35qsVEm9h8lRDQmyJi23gjKITU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=frB2zXBk; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id p7j0sSUf9oR4tp7j1soqq0; Fri, 13 Sep 2024 16:56:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726239411;
	bh=2ppfZtFE3UF/ZPMPNi/oYz7eBBncngRv+97pSLrZhqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=frB2zXBkPf2SbckhFM/MElr0u4oWmiNEG9WMsoDpJ/9F4I7EYcra7Vs8SKV+jLf+1
	 WWGlSmHvc/f7s+3oGUMSXH5RIL/A2V+mD/tDQ2Npd7phpBuZLSvDKJhe1Lm1JTLPfu
	 aoxhKvyROQrUYZ8kb0VNSo/Qfd2ONclCAzrvbaA7mu5HE+UmjR/zDHxx+E1fE7Es+7
	 kJbvvCde1ENSFzGt/J6Qu/wq7dZt4HKhih6QC9K5ksQM1/n4HyKc1NWK5Yw0uZwRO6
	 s4b/ny6bMWwAvVEVZZhnBEqRRMu4p2PMo2aiVQriYVg2PMV8jODsa9EVN43ryFMzxo
	 R4XOTF72vKrbw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 13 Sep 2024 16:56:51 +0200
X-ME-IP: 90.11.132.44
Message-ID: <e2d7ed77-827b-4b7c-800c-9c8f3bcb6b5a@wanadoo.fr>
Date: Fri, 13 Sep 2024 16:56:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 v2 1/4] riscv: dts: starfive: add assigned-clock* to
 limit frquency
To: WangYuli <wangyuli@uniontech.com>, stable@vger.kernel.org,
 gregkh@linuxfoundation.org, sashal@kernel.org, william.qiu@starfivetech.com,
 emil.renner.berthing@canonical.com, conor.dooley@microchip.com,
 xingyu.wu@starfivetech.com, walker.chen@starfivetech.com, robh@kernel.org,
 hal.feng@starfivetech.com
Cc: kernel@esmil.dk, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com, netdev@vger.kernel.org
References: <3A31C289BC240955+20240912025539.1928223-1-wangyuli@uniontech.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <3A31C289BC240955+20240912025539.1928223-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/09/2024 à 04:55, WangYuli a écrit :
> From: William Qiu <william.qiu@starfivetech.com>
> 
> [ Upstream commit af571133f7ae028ec9b5fdab78f483af13bf28d3 ]
> 
> In JH7110 SoC, we need to go by-pass mode, so we need add the
> assigned-clock* properties to limit clock frquency.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---

Hi,

if/when resent, there is a typo in the subject: s/frquency/frequency/

CJ


>   .../riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 062b97c6e7df..4874e3bb42ab 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -204,6 +204,8 @@ &i2c6 {
>   
>   &mmc0 {
>   	max-frequency = <100000000>;
> +	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> +	assigned-clock-rates = <50000000>;
>   	bus-width = <8>;
>   	cap-mmc-highspeed;
>   	mmc-ddr-1_8v;
> @@ -220,6 +222,8 @@ &mmc0 {
>   
>   &mmc1 {
>   	max-frequency = <100000000>;
> +	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
> +	assigned-clock-rates = <50000000>;
>   	bus-width = <4>;
>   	no-sdio;
>   	no-mmc;


