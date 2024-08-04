Return-Path: <stable+bounces-65354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C709470A9
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 23:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5613D1C20839
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 21:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D50136358;
	Sun,  4 Aug 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=radojevic.rs header.i=@radojevic.rs header.b="L4pkWiCk"
X-Original-To: stable@vger.kernel.org
Received: from mail.radojevic.rs (radojevic.rs [139.162.187.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1928A2A;
	Sun,  4 Aug 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.187.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722806631; cv=none; b=WPTNIVg4aMVqqNpYQG/d+ZXuy80UDruMfuY1FNOpmPIai3zlJ+uKMeQRB+c1sCFiMIgNzNV6O0iQtmSlPcj4tx1VX2Cw+pb2uV95mfpTZ7rAzLMnqeA+7CjlRMMPPeNJx7MRCTSNFZFQhqavDV6/7vfmvOi6STfzz0+inaOO5Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722806631; c=relaxed/simple;
	bh=FsKABYar5tCCmqGtOJLbGI3S+bt2cKoGgq3u7smejfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJhl5htLqClIc2BR/f6fpYDYue6a0SVo5XbIdUWDH4UM1KvHdKXJJB93GLOiKL2G77O1SCFh0uqtdYtEIf3FM/+FRvLTPfThn4+f4m4p2OBEs9d4fcGdXe35xv+HwtZ6En70UJjsLYYOC/sopK76fWn0H41gQZeSb/fHHgKTx9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=radojevic.rs; spf=pass smtp.mailfrom=radojevic.rs; dkim=pass (2048-bit key) header.d=radojevic.rs header.i=@radojevic.rs header.b=L4pkWiCk; arc=none smtp.client-ip=139.162.187.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=radojevic.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radojevic.rs
Received: from localhost (178-221-223-10.dynamic.isp.telekom.rs [178.221.223.10])
	by mail.radojevic.rs (Postfix) with ESMTPSA id 33F222FD85;
	Sun,  4 Aug 2024 23:14:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=radojevic.rs; s=mail;
	t=1722806059; bh=FsKABYar5tCCmqGtOJLbGI3S+bt2cKoGgq3u7smejfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4pkWiCkdTYqCKLJrt1kCBlMi6hwyY33b6YqUPLunaklLu9Wwj96oerV09xz0pXhZ
	 sYAUxn8pesk/o1rpnyougzShnE8eSsH0+kL+vWnrpyrCs6TaMgW/WcYf8+/CK+8roH
	 OowVwQiOa+JEEF+NgiUXWBjGIzEMdwJpFrZZMoHXf2U8BxO30NJS01nIMEA/eD2A2K
	 xxmSAkX/eYVwZAWJbKecHBQsp6KOM5b3LuBIe+eE/tSwGShCGkjl525UkhUdQx3yhR
	 i6jZI1z0P5YnTrxefO5YlW1RqIUOmxZjieOMUBcw8fWz/+GTDFpsqe8BvqWfBqa2BJ
	 sQMxWz/R5UNEA==
Date: Sun, 4 Aug 2024 23:14:17 +0200
From: Nikola Radojevic <nikola@radojevic.rs>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Raise Pinebook Pro's panel
 backlight PWM frequency
Message-ID: <pydrzsz36br3e3cgdpvqwxbh3y2kk6z5tdkih7pmqgydq7utzl@ifiyxoegvjjc>
References: <2a23b6cfd8c0513e5b233b4006ee3d3ed09b824f.1722805655.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a23b6cfd8c0513e5b233b4006ee3d3ed09b824f.1722805655.git.dsimic@manjaro.org>

Hello,
I have tested this on my Pinebook Pro and I can confirm that
everything seems to work alright.

Tested-by: Nikola Radojević <nikola@radojevic.rs>

On 24/08/04 11:10PM, Dragan Simic wrote:
> Increase the frequency of the PWM signal that drives the LED backlight of
> the Pinebook Pro's panel, from about 1.35 KHz (which equals to the PWM
> period of 740,740 ns), to exactly 8 kHz (which equals to the PWM period of
> 125,000 ns).  Using a higher PWM frequency for the panel backlight, which
> reduces the flicker, can only be beneficial to the end users' eyes.
> 
> On top of that, increasing the backlight PWM signal frequency reportedly
> eliminates the buzzing emitted from the Pinebook Pro's built-in speakers
> when certain backlight levels are set, which cause some weird interference
> with some of the components of the Pinebook Pro's audio chain.
> 
> The old value for the backlight PWM period, i.e. 740,740 ns, is pretty much
> an arbitrary value that was selected during the very early bring-up of the
> Pinebook Pro, only because that value seemed to minimize horizontal line
> distortion on the display, which resulted from the old X.org drivers causing
> screen tearing when dragging windows around.  That's no longer an issue, so
> there are no reasons to stick with the old PWM period value.
> 
> The lower and the upper backlight PWM frequency limits for the Pinebook Pro's
> panel, according to its datasheet, are 200 Hz and 10 kHz, respectively. [1]
> These changes still leave some headroom, which may have some positive effects
> on the lifetime expectancy of the panel's backlight LEDs.
> 
> [1] https://files.pine64.org/doc/datasheet/PinebookPro/NV140FHM-N49_Rev.P0_20160804_201710235838.pdf
> 
> Fixes: 5a65505a6988 ("arm64: dts: rockchip: Add initial support for Pinebook Pro")
> Cc: stable@vger.kernel.org
> Reported-by: Nikola Radojevic <nikola@radojevic.rs>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> index 294eb2de263d..b3f76cc2d6e1 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> @@ -32,7 +32,7 @@ chosen {
>  	backlight: edp-backlight {
>  		compatible = "pwm-backlight";
>  		power-supply = <&vcc_12v>;
> -		pwms = <&pwm0 0 740740 0>;
> +		pwms = <&pwm0 0 125000 0>;
>  	};
>  
>  	bat: battery {

