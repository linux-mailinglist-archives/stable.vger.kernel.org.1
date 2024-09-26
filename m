Return-Path: <stable+bounces-77774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 445F098705F
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 11:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7CD1C24841
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 09:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA781A4F16;
	Thu, 26 Sep 2024 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xRZjG3jm"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1415138FA3;
	Thu, 26 Sep 2024 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343378; cv=none; b=pQtFgjeKfAMNBfYzBiqiHA1lbw77uZi1D8j0k2ikdCGLiXO8xWdFzz3y74kYnelhjQHsKcOh+pYNLE466pa7I6YjEMqwazQyF0+CurL7HO2uUFKCrqxXndOp4jbKsRwwzv6c16JlypUiigl72lmXLk8qORzvpA0ZPRh40kLNvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343378; c=relaxed/simple;
	bh=pGzNXwKK5YrzLSLixZD10eC6c3/sJZzIXc84Paz/rAo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IsS4p5HeazfzCMVdbgq2QJQPoPP/xC+bxoze4oSYAhwXl8D/wpJOOW8hDc6yNP4E4ShL/jhBcrqd3NMgAs1BAElsFL5TvUBzoZHFVmEbUw2Z5WiD5NJZP/vY2ln4MNSiX2PXtm7jQeIqa5zKVQs7405u0CIm4sZKGRm1hANFYx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xRZjG3jm; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727343374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nro0VeXsPWDiC4P3tUhqYu7l5pTbMR920vC1Wc7Li0c=;
	b=xRZjG3jmKHLtNlc2LBKCppMizR+S8E+xrKtSFrT3CleBSAa1GzZdlPUKwBYnaICacxucJP
	SIrXwdOBtgt74wvxprD9w7OUAgzz/YcC7AgOYweaqrX/UpiGb3W9gGxZh7E5XctKLwkzrT
	4z6iJ2n8p/yWGczFxz7EkssWOaFWeGpkjKUHpv1+TKnu6DoWB/cZ/6bvcajQ7djJSJO1fO
	kVjkEQRf8trbGS1NdL1oyY7JruPl3ahFXg2yVImOb2+eDcd8xWu9/4OzbCEJ9+TzndMWoD
	HC/fUEgQ0QCR4yVzmISCIndAKizcc8/Q6IXNY0KV1y20Xj2BsMK8LUWT1KNaaw==
Date: Thu, 26 Sep 2024 11:36:13 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Move L3 cache under CPUs in RK356x
 SoC dtsi
In-Reply-To: <2aa03ce3-1cca-4b3a-935d-6b1b68ebbb6e@arm.com>
References: <da07c30302cdb032dbda434438f89692a6cb0a2d.1727336728.git.dsimic@manjaro.org>
 <2aa03ce3-1cca-4b3a-935d-6b1b68ebbb6e@arm.com>
Message-ID: <c3593744e00a9817533609326ee66346@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Robin,

On 2024-09-26 11:24, Robin Murphy wrote:
> On 2024-09-26 8:49 am, Dragan Simic wrote:
>> Move the "l3_cache" node under the "cpus" node in the dtsi file for 
>> Rockchip
>> RK356x SoCs.  There's no need for this cache node to be at the higher 
>> level.
> 
> Except it does arguably represent the physical topology - the L3 cache
> doesn't belong to the CPUs, it belongs to the DSU, which very much is
> "outside" the CPUs.

That's a very good point, thanks!  I knew there must have been
a very good reason why I placed the L3 cache outside the CPUs
originally, in the commit 8612169a05c5 referenced below, but I
also somehow managed to forget that reason for a moment. :)

Let's drop this patch, and I'll submit another patch for the
RK3588 SoC dtsi files that moves the L3 cache outside the CPUs,
to reflect the physical topology better.

>> Fixes: 8612169a05c5 ("arm64: dts: rockchip: Add cache information to 
>> the SoC dtsi for RK356x")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk356x.dtsi | 24 
>> ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> index 4690be841a1c..9f7136e5d553 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> @@ -113,19 +113,19 @@ cpu3: cpu@300 {
>>   			d-cache-sets = <128>;
>>   			next-level-cache = <&l3_cache>;
>>   		};
>> -	};
>>   -	/*
>> -	 * There are no private per-core L2 caches, but only the
>> -	 * L3 cache that appears to the CPU cores as L2 caches
>> -	 */
>> -	l3_cache: l3-cache {
>> -		compatible = "cache";
>> -		cache-level = <2>;
>> -		cache-unified;
>> -		cache-size = <0x80000>;
>> -		cache-line-size = <64>;
>> -		cache-sets = <512>;
>> +		/*
>> +		 * There are no private per-core L2 caches, but only the
>> +		 * L3 cache that appears to the CPU cores as L2 caches
>> +		 */
>> +		l3_cache: l3-cache {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-unified;
>> +			cache-size = <0x80000>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <512>;
>> +		};
>>   	};
>>     	cpu0_opp_table: opp-table-0 {
>> 
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

