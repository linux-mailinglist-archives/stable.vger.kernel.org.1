Return-Path: <stable+bounces-92792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA739C5A1B
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 15:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616C62836C8
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8127B1FC7DB;
	Tue, 12 Nov 2024 14:19:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734CD7F477;
	Tue, 12 Nov 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421162; cv=none; b=CF48GQSSd12VpG80M9JhGvRTy8lBShN8eg4YS/nsx0UKJmWIg2bOY+viZ/46y1GuDW3tSvmpN18Ona1nekXwUGHh7tFSyunJejj98Lq2F4e7hfo/2jbte3v+hJyqbOfVkLX0864iDGtWhQ+NGG+9veybF1n8idJ7HZ0No6n5XUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421162; c=relaxed/simple;
	bh=VhrTi7q5aURo2kniteHKbRgC9LQ2hKX+q6dxYEmI/cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1IHcu75nWSoDStexn7Pgfd+9HgdKX7688IpcF0WkFwt2uQWY2TAGno6hRzmgk+mY6YNoAbAnMqlqGTgludP6oLEqt8wTma7lQWF6pAcMn5ChwTkRNEBdZE+I7TxmwGgMTiUqdy9E09jvDxWsmnbNiocQzno8DA/EBQxFH+O0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BBC425E3;
	Tue, 12 Nov 2024 06:19:48 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 214F13F66E;
	Tue, 12 Nov 2024 06:19:17 -0800 (PST)
Message-ID: <607a731c-41e9-497a-a08c-f718339610ae@arm.com>
Date: Tue, 12 Nov 2024 14:19:09 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Fix vdd_gpu voltage constraints on
 PinePhone Pro
To: Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, stable@vger.kernel.org
References: <0718feb8e95344a0b615f61e6d909f6e105e3bf9.1731264205.git.dsimic@manjaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <0718feb8e95344a0b615f61e6d909f6e105e3bf9.1731264205.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/2024 6:44 pm, Dragan Simic wrote:
> The regulator-{min,max}-microvolt values for the vdd_gpu regulator in the
> PinePhone Pro device dts file are too restrictive, which prevents the highest
> GPU OPP from being used, slowing the GPU down unnecessarily.  Let's fix that
> by making the regulator-{min,max}-microvolt values less strict, using the
> voltage range that the Silergy SYR838 chip used for the vdd_gpu regulator is
> actually capable of producing. [1][2]

Specifying the absolute limits which the regulator driver necessarily 
already knows doesn't seem particularly useful... Moreover, the RK3399 
datasheet specifies the operating range for GPU_VDD as 0.80-1.20V, so at 
the very least, allowing the regulator to go outside that range seems 
inadvisable. However there's a separate datasheet for the RK3399-T 
variant, which does specify this 875-975mV range and a maximum GPU clock 
of 600MHz, along with the same 1.5GHz max. Cortex-A72 clock as 
advertised for RK3399S, so it seems quite possible that these GPU 
constraints here are in fact intentional as well. Obviously users are 
free to overclock and overvolt if they wish - I do for my 
actively-cooled RK3399 board :) - but it's a different matter for 
mainline to force it upon them.

Thanks,
Robin.

> This also eliminates the following error messages from the kernel log:
> 
>    core: _opp_supported_by_regulators: OPP minuV: 1100000 maxuV: 1150000, not supported by regulator
>    panfrost ff9a0000.gpu: _opp_add: OPP not supported by regulators (800000000)
> 
> These changes to the regulator-{min,max}-microvolt values make the PinePhone
> Pro device dts consistent with the dts files for other Rockchip RK3399-based
> boards and devices.  It's possible to be more strict here, by specifying the
> regulator-{min,max}-microvolt values that don't go outside of what the GPU
> actually may use, as the consumer of the vdd_gpu regulator, but those changes
> are left for a later directory-wide regulator cleanup.
> 
> [1] https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf
> [2] https://www.t-firefly.com/download/Firefly-RK3399/docs/Chip%20Specifications/DC-DC_SYR837_838.pdf
> 
> Fixes: 78a21c7d5952 ("arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>   arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index 1a44582a49fb..956d64f5b271 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -410,8 +410,8 @@ vdd_gpu: regulator@41 {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&vsel2_pin>;
>   		regulator-name = "vdd_gpu";
> -		regulator-min-microvolt = <875000>;
> -		regulator-max-microvolt = <975000>;
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1500000>;
>   		regulator-ramp-delay = <1000>;
>   		regulator-always-on;
>   		regulator-boot-on;
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

