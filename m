Return-Path: <stable+bounces-77760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216CD986EB8
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 10:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B0B1F21A7D
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 08:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A32A1A4B8F;
	Thu, 26 Sep 2024 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="lnOot4Ci"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF736188CB8;
	Thu, 26 Sep 2024 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339109; cv=none; b=KaY6XJ0Bh7S16amkZScYYHgUVH40snKgy47eyZUgje29cxrr0D1J3VjgfA20QcuTKNnCeBZDzktIxQYnHSBNw8E3l0ZwqZR2fGv/oT1frAXHxRCWGTDGRVan2EG+ciqFusuFBbezc8jdBGO/1o2bAwh2l3YQqXYeR2Az/jmwO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339109; c=relaxed/simple;
	bh=nzAJ58vyoHQtO3NGE8PRselJtg6kTzIF26rnk3ElbXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWfSd9KjzdrvB9BBcZMbv7F+JaJq2UG1Hq/PmPlDKpMt8r+HVpt4/7dHVVxgspFbpLDyVohSbBycbU4fgx8ZKOhsSItHRSCftKEiOqC5EnABlp9CQnfm/hMqmwm0uo/UykmpwIi+dtzyvGOuwmZJTf2GkBwNeH5wZ0FKSCWVits=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=lnOot4Ci; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iBsC3mABl+He9E398zbyg48Y1tA2wfpFLTdtcZVXHtw=; b=lnOot4CiQs6jGk5N9O6UHusTzf
	tvYsmgjHyv9XLkoSuitf8eT7HDY5YYLgia0z0d3nLQjR5w0ONlV+THk+5btwcvK1AossjagBYT04Q
	36QKSrnVjx6fzIuEwCitbw9rAUEPuq2K3UaHmTTEInfHIGYF7LvN8XHRGhylDaI/rAzGCVh6Hbdo2
	lR8CKW/yC+j2BIRi/lYeDjsCBGhMnoC6BnuepvEbkcbXzDJtOrzEZJhH7AkoM0KVGq9+JBL6klYme
	Lprgc7g7kRcFIMIH0AYMFdzKCLvJhv684BMiN07OhWgMpJT8s1psLwLwfAhF3SVGRHcHme8Q3oGQ4
	xYRmqqxA==;
Received: from 85-160-70-253.reb.o2.cz ([85.160.70.253] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1stjnu-0001ez-D4; Thu, 26 Sep 2024 10:24:50 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, Dragan Simic <dsimic@manjaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Move L3 cache under CPUs in RK356x SoC dtsi
Date: Thu, 26 Sep 2024 10:24:49 +0200
Message-ID: <3938446.fW5hKsROvD@phil>
In-Reply-To:
 <da07c30302cdb032dbda434438f89692a6cb0a2d.1727336728.git.dsimic@manjaro.org>
References:
 <da07c30302cdb032dbda434438f89692a6cb0a2d.1727336728.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 26. September 2024, 09:49:18 CEST schrieb Dragan Simic:
> Move the "l3_cache" node under the "cpus" node in the dtsi file for Rockchip
> RK356x SoCs.  There's no need for this cache node to be at the higher level.
> 
> Fixes: 8612169a05c5 ("arm64: dts: rockchip: Add cache information to the SoC dtsi for RK356x")
> Cc: stable@vger.kernel.org

I think the commit message needs a bit more rationale on why this is a
stable-worthy fix. Because from the move and commit message it reads
like a styling choice ;-) .

I do agree that it makes more sense as child of cpus, but the commit
message should also elaborate on why that would matter for stable.


Heiko

> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 4690be841a1c..9f7136e5d553 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -113,19 +113,19 @@ cpu3: cpu@300 {
>  			d-cache-sets = <128>;
>  			next-level-cache = <&l3_cache>;
>  		};
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
>  	};
>  
>  	cpu0_opp_table: opp-table-0 {
> 





