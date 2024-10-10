Return-Path: <stable+bounces-83373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52552998DCD
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 18:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77215B3D8E7
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EE51CCB2D;
	Thu, 10 Oct 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ue3fvJwT"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D942207A;
	Thu, 10 Oct 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576264; cv=none; b=iNvVMDawSe8J1UdOJvds2UOz6LbuEao2wkk8+7v+ftpc3nRSKo8Hl/1ETxR5WIQm+yBeFReHk8KVYKRiI1zn3CcjO1knRwivREq+fNi9hMruxNFdZ0qJVSWECmV5A//eylC9/MfEyJX0eYcGnI7ARUgBYlO3JCVPoenXL5JcDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576264; c=relaxed/simple;
	bh=o3EDci7FnB4sdL4nheWjIvOwpfcKu77OyfInnC/XHw0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eCjGRwrAOTs7WCS+iQHuGQ9ixdmQ+CjQvuOgB0ZeL2K/PWq3X5XgFClaS04JLXiWfsPbhtgK9Cuob8A5eQpxi9W5RpYcHGfM6Ewa6EMJ9qI2yRcB3j6UkEcuVW61h9qDO8ys7TzoJTjBLKvtHNpVCCBNfYQLJhBM4ftmG9CTaL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ue3fvJwT; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728576258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHsk3WKYOtf6YIW4r4cEK0zr25z4Yvu6MikBAKtqoh8=;
	b=ue3fvJwTCGlWlGqqLTCcmuyk7Ws8xNMck/cqE9KU4gs8F/3XbYxuu2dTa6NQ2tsutU1BLf
	IfSuN/9e2j2iT4q3Z1i4reTHcple2eJkka1T9dofIcMMiKozE3DCFDxIAtLvuDBppzmo7Z
	q8oeWPCCuIYFdHzdoxtYLlzNaNl5uI0G7Nj6s91pZrnQUm8m3/ammF4Q1d2OfI//C5r+TG
	KYmUUZC4V6vS5iWaIxV0/x40jAiL9/heGVZwqochIQKQZddHWrjOQR2ZQaWWEs7MVYnBZB
	+5phUGGvstM2tg6olDRq61ovtXGbbAvsJ91j3yczsBr+BHe5IwqHZ48XiN/UZw==
Date: Thu, 10 Oct 2024 18:04:18 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Prevent thermal runaways in RK3308
 SoC dtsi
In-Reply-To: <d3e9dc4201d38894b09f3198368428153a3af1a4.1728555461.git.dsimic@manjaro.org>
References: <d3e9dc4201d38894b09f3198368428153a3af1a4.1728555461.git.dsimic@manjaro.org>
Message-ID: <df92710498f66bcb4580cb2cd1573fb2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-10-10 12:19, Dragan Simic wrote:
> Until the TSADC, thermal zones, thermal trips and cooling maps are 
> defined
> in the RK3308 SoC dtsi, none of the CPU OPPs except the slowest one may 
> be
> enabled under any circumstances.  Allowing the DVFS to scale the CPU 
> cores
> up without even just the critical CPU thermal trip in place can rather 
> easily
> result in thermal runaways and damaged SoCs, which is bad.
> 
> Thus, leave only the lowest available CPU OPP enabled for now.
> 
> Fixes: 6913c45239fd ("arm64: dts: rockchip: Add core dts for RK3308 
> SOC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

As a note, I'll hopefully get back with the proper implementation of the
thermal configuration for the RK3308, but not before the 6.14 merge 
window.
In the meantime, let's stick to having only the lowest CPU OPP in place,
as changed in this patch.

> ---
>  arch/arm64/boot/dts/rockchip/rk3308.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> index 31c25de2d689..a7698e1f6b9e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> @@ -120,16 +120,19 @@ opp-600000000 {
>  			opp-hz = /bits/ 64 <600000000>;
>  			opp-microvolt = <950000 950000 1340000>;
>  			clock-latency-ns = <40000>;
> +			status = "disabled";
>  		};
>  		opp-816000000 {
>  			opp-hz = /bits/ 64 <816000000>;
>  			opp-microvolt = <1025000 1025000 1340000>;
>  			clock-latency-ns = <40000>;
> +			status = "disabled";
>  		};
>  		opp-1008000000 {
>  			opp-hz = /bits/ 64 <1008000000>;
>  			opp-microvolt = <1125000 1125000 1340000>;
>  			clock-latency-ns = <40000>;
> +			status = "disabled";
>  		};
>  	};

