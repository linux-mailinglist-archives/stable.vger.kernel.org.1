Return-Path: <stable+bounces-77762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABF8986ECE
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 10:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD08F1C218E1
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 08:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C0018C336;
	Thu, 26 Sep 2024 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="llo7TmdY"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90C1D5ACF;
	Thu, 26 Sep 2024 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339542; cv=none; b=i+6/SxJBYvjmbMn/weVmrA6ZToxtjzi0eRvTik1lLliN1s//yR2ERevcZKTP1tTwm7UIPWaGV5ZFEcXooikiITQcQ417mGqIxPXiSR0ARJ5MOPPId02bmYu2IKBeaksbRyf1cMSfPs8SR85eVfNV7PTp+MZmjL4/m6p8W/LAZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339542; c=relaxed/simple;
	bh=2q+PoNnVZg0Jk9dK1Vp1DlFTvLPSZXZ39uaGIWjltMk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LO/GuIRIE7GbAa0tBg2gkqcLGXYkronxHQU/aTCQKY4GitVBgirW+xM+Pn9THCSJX+BxGXlH+Si7tTdOYvXezcBjr9x6g8MzHbX+LdTsSDMNQ5xOd1/HFotPSMVgf8d7as51X6NxyM176TJ1juV+28zkqmSI8A4apm45Hyo0RME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=llo7TmdY; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727339537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Cujcqo+iQwaB51AOH25qP+3PrnYOZl6IbH7tj3OMjI=;
	b=llo7TmdY2al+SnSku0mZMt1+FieHQkAnezMq62KeeU6p/7fJQOIXS1nP7/tU+xHVWRa/xb
	hwENaeddf7y9aF+Iw5PmMobELYUJKAk4AeR4T9ADCaBp57NpVY/+r0/WKrWSLqcAvCUU+F
	VOMbaN2b72qZs1AGn9KLYtnFjFtEYa4IIePhA4SIVxjrYX8hwKFYQeN7oGyLaFHDA2xMdL
	Gsslv1OWVZXFnje2Rs0AU2dAIG+sK6RoOvBsn/hOyPQ1pYV7rrqxez0Ib8sevEVG/En2VN
	QMeZSGMRQPHVJTBNdCdHMVxUpnvfYw+J8KP3HKbU85nka4bnJDdqr9iPFUIIfg==
Date: Thu, 26 Sep 2024 10:32:17 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Move L3 cache under CPUs in RK356x
 SoC dtsi
In-Reply-To: <3938446.fW5hKsROvD@phil>
References: <da07c30302cdb032dbda434438f89692a6cb0a2d.1727336728.git.dsimic@manjaro.org>
 <3938446.fW5hKsROvD@phil>
Message-ID: <57d360d73054d1bad8566e3fe0ee1921@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-09-26 10:24, Heiko Stuebner wrote:
> Am Donnerstag, 26. September 2024, 09:49:18 CEST schrieb Dragan Simic:
>> Move the "l3_cache" node under the "cpus" node in the dtsi file for 
>> Rockchip
>> RK356x SoCs.  There's no need for this cache node to be at the higher 
>> level.
>> 
>> Fixes: 8612169a05c5 ("arm64: dts: rockchip: Add cache information to 
>> the SoC dtsi for RK356x")
>> Cc: stable@vger.kernel.org
> 
> I think the commit message needs a bit more rationale on why this is a
> stable-worthy fix. Because from the move and commit message it reads
> like a styling choice ;-) .
> 
> I do agree that it makes more sense as child of cpus, but the commit
> message should also elaborate on why that would matter for stable.

Thanks for your feedback!  Perhaps it would be the best to simply drop 
the
submission to stable kernels...  Believe it or not, :) I spent a fair 
amount
of time deliberating over the submission to stable, but now I think it's
simply better to omit that and not increase the amount of patches that 
go
into stable unnecessary.

Would you like me to send the v2 with no Cc to stable, or would you 
prefer
to drop that line yourself?


>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 24 
>> ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> index 4690be841a1c..9f7136e5d553 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> @@ -113,19 +113,19 @@ cpu3: cpu@300 {
>>  			d-cache-sets = <128>;
>>  			next-level-cache = <&l3_cache>;
>>  		};
>> -	};
>> 
>> -	/*
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
>>  	};
>> 
>>  	cpu0_opp_table: opp-table-0 {
>> 
> 
> 
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

