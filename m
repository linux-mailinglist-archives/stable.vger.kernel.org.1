Return-Path: <stable+bounces-81539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFEA99431A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479971C24B3E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFCC1DE4F6;
	Tue,  8 Oct 2024 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CQm2krZB"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26E125A9;
	Tue,  8 Oct 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377519; cv=none; b=REX03TrntKw+ftbo2CawJxO5K0s6fP/OMO/FgSsdbZrO2cKz89iW1wqJ4VYQRaOs1doOF3zS/ZOJUJ4scuFDrCwWv6Be5X1j8hRvRsARqTtZWIsty4rknWPbe+P3Kp5fjwFfnzLnUsC2LZVVRkJGTPxO69JGlnmFmin9u9MbFpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377519; c=relaxed/simple;
	bh=FWUBk3EY6ZXr7Y6EY9fd69c8WqbiTjOs2Gxf1AJYQlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5rqWCvyzwqd+makGqXM3+tdKi36BkKcNVQNTsnm7Q8dWaU0F5yJTPujVQpj3oSU0mYeQndUF3vRMYLTsXluMDExY3pO0rfOxz70lBJBMWrRQnXbI68MXTLoU3ej6DkigAOwwkznu1S8FzcagKnovSFL2diK5pXXUQHpVPqKkVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CQm2krZB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728377516;
	bh=FWUBk3EY6ZXr7Y6EY9fd69c8WqbiTjOs2Gxf1AJYQlQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CQm2krZBbDwinxcX7j6HwebxqcvccsGmufZ/xF4FMaN4V07VY+jXstNoMHQ9TdsEm
	 W+cG77Lv5fb4C3APTcpTNjDInPF73Au0OBHj12uJa669U2AHiZfsMsEB8TAJo+U5+j
	 yB+fCF8aiSqu1TwLj+ikrYnRdB+V4YHdlLqU0Lk/KB40Qsz4i2HU21viUH6GXt3AVz
	 hKAGU/CLVoV3XD/otFN731RABmj9asq6bkipFLTOxGHqKvo6b1c08bE7IL3wqE4q1K
	 QHMuOANYMT9OUZCGGvZLzN6uPpLsFzli5/r2qPucZDdExCN/YddCY0Yn4ut38ZAQmX
	 ROvbvXFNKsTXQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BB6C917E10B5;
	Tue,  8 Oct 2024 10:51:55 +0200 (CEST)
Message-ID: <7caa85fa-7186-4f8f-8195-19325ebf06bd@collabora.com>
Date: Tue, 8 Oct 2024 10:51:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186-corsola-voltorb: Merge
 speaker codec nodes
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241008082200.4002798-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241008082200.4002798-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/10/24 10:21, Chen-Yu Tsai ha scritto:
> The Voltorb device uses a speaker codec different from the original
> Corsola device. When the Voltorb device tree was first added, the new
> codec was added as a separate node when it should have just replaced the
> existing one.
> 
> Merge the two nodes. The only differences are the compatible string and
> the GPIO line property name. This keeps the device node path for the
> speaker codec the same across the MT8186 Chromebook line.

Ok, I agree...

But, at this point, can we rename `rt1019p` to `speaker_codec` instead?

Imo, that makes a bit more sense as a phandle, as it reads generic and it's not
screaming "I'm RT1019P" on dts(i) files where it's actually not.

> 
> Fixes: 321ad586e607 ("arm64: dts: mediatek: Add MT8186 Voltorb Chromebooks")
 > Cc: <stable@vger.kernel.org>

Well, that's not a fix - it's an improvement, so we can avoid this Fixes tag :-)

Cheers,
Angelo

> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   .../dts/mediatek/mt8186-corsola-voltorb.dtsi  | 19 ++++---------------
>   1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
> index 52ec58128d56..fbcd97069df9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
> @@ -10,12 +10,6 @@
>   
>   / {
>   	chassis-type = "laptop";
> -
> -	max98360a: max98360a {
> -		compatible = "maxim,max98360a";
> -		sdmode-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
> -		#sound-dai-cells = <0>;
> -	};
>   };
>   
>   &cpu6 {
> @@ -59,19 +53,14 @@ &cluster1_opp_15 {
>   	opp-hz = /bits/ 64 <2200000000>;
>   };
>   
> -&rt1019p{
> -	status = "disabled";
> +&rt1019p {
> +	compatible = "maxim,max98360a";
> +	sdmode-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
> +	/delete-property/ sdb-gpios;
>   };
>   
>   &sound {
>   	compatible = "mediatek,mt8186-mt6366-rt5682s-max98360-sound";
> -	status = "okay";
> -
> -	spk-hdmi-playback-dai-link {
> -		codec {
> -			sound-dai = <&it6505dptx>, <&max98360a>;
> -		};
> -	};
>   };
>   
>   &spmi {


