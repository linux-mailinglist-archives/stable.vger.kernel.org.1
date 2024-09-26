Return-Path: <stable+bounces-77772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54326987004
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 11:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0561C20DAC
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2534C1AAE0E;
	Thu, 26 Sep 2024 09:24:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE931A4E9A;
	Thu, 26 Sep 2024 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342681; cv=none; b=PVqvKVIEn+OsFig1v8k0mgUoaicbcVgtmPVn5NT7FsxebYUM5W1e51kv99tADGlo2izxHKpKqCTvKioRxCKjSXn8ickWRQgsrZ+S0q/qRmFU6/nHqqWjSB5nW8imA4RzpEzyNhCGLkS6Jg81g9xRguGOC7v/xSylwbeVUx6p6jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342681; c=relaxed/simple;
	bh=yE9SptUbwRo/+ux0TQVgq2RykCuECeO5yyFECblI1q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3y2A8iXIdU86Kf14NH51BMVfzJcy9lEyJIeemQJIi2+VxlV6rks42Vuu2URANT1bLH7L2uOgVCQNwpFmBhnz4pAZKataFcbR4oX6qcEDg66vQc0v3mu8o7m2znjsxKOIBeX8BgcINw6y2rBUyFh0es6nLlVB1m2aAh9sGRviGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 355CB12FC;
	Thu, 26 Sep 2024 02:25:07 -0700 (PDT)
Received: from [10.57.75.132] (unknown [10.57.75.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D75183F6A8;
	Thu, 26 Sep 2024 02:24:35 -0700 (PDT)
Message-ID: <2aa03ce3-1cca-4b3a-935d-6b1b68ebbb6e@arm.com>
Date: Thu, 26 Sep 2024 10:24:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Move L3 cache under CPUs in RK356x
 SoC dtsi
To: Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, stable@vger.kernel.org
References: <da07c30302cdb032dbda434438f89692a6cb0a2d.1727336728.git.dsimic@manjaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <da07c30302cdb032dbda434438f89692a6cb0a2d.1727336728.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-26 8:49 am, Dragan Simic wrote:
> Move the "l3_cache" node under the "cpus" node in the dtsi file for Rockchip
> RK356x SoCs.  There's no need for this cache node to be at the higher level.

Except it does arguably represent the physical topology - the L3 cache 
doesn't belong to the CPUs, it belongs to the DSU, which very much is 
"outside" the CPUs.

Thanks,
Robin.

> 
> Fixes: 8612169a05c5 ("arm64: dts: rockchip: Add cache information to the SoC dtsi for RK356x")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>   arch/arm64/boot/dts/rockchip/rk356x.dtsi | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 4690be841a1c..9f7136e5d553 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -113,19 +113,19 @@ cpu3: cpu@300 {
>   			d-cache-sets = <128>;
>   			next-level-cache = <&l3_cache>;
>   		};
> -	};
>   
> -	/*
> -	 * There are no private per-core L2 caches, but only the
> -	 * L3 cache that appears to the CPU cores as L2 caches
> -	 */
> -	l3_cache: l3-cache {
> -		compatible = "cache";
> -		cache-level = <2>;
> -		cache-unified;
> -		cache-size = <0x80000>;
> -		cache-line-size = <64>;
> -		cache-sets = <512>;
> +		/*
> +		 * There are no private per-core L2 caches, but only the
> +		 * L3 cache that appears to the CPU cores as L2 caches
> +		 */
> +		l3_cache: l3-cache {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-unified;
> +			cache-size = <0x80000>;
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
> +		};
>   	};
>   
>   	cpu0_opp_table: opp-table-0 {
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

