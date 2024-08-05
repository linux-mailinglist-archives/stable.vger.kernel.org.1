Return-Path: <stable+bounces-65372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C33947A1E
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 12:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D91B21A4A
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 10:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE94154C0F;
	Mon,  5 Aug 2024 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=radojevic.rs header.i=@radojevic.rs header.b="T7/eKliz"
X-Original-To: stable@vger.kernel.org
Received: from mail.radojevic.rs (radojevic.rs [139.162.187.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CA41311AC;
	Mon,  5 Aug 2024 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.187.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855534; cv=none; b=q3A2Yq4/8TsyLdYU3WKzWGqAl4b8LhVQYPqB5kOWJ5sXqXvdRGtxx036Rh4V3xq70E/fp5/+6GFD5CbEwy3axm4/Aflq9zpJvuVXvmqGeUqsManUKnaYWaB8tHze+DqJ8/s54n5ywynSGLMs3HL1cUtyMvZGwEY5G/4WwgFECF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855534; c=relaxed/simple;
	bh=FsKABYar5tCCmqGtOJLbGI3S+bt2cKoGgq3u7smejfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4B3P2C+murJkn5WwTeO+/2cibB3SQ8a338q6sxeC+QFa0FU/AHeFc9ouvK6hm9IwuFsZA6erTnRs9/JEaCFyG8/Z3UW8zWmUnLYiNYH8OAoTitjzPHxK2/4QfqLQSnVPdcAibz0UHWK0QHtYalcoc4kktizcSOETrNtnQR/eh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=radojevic.rs; spf=pass smtp.mailfrom=radojevic.rs; dkim=pass (2048-bit key) header.d=radojevic.rs header.i=@radojevic.rs header.b=T7/eKliz; arc=none smtp.client-ip=139.162.187.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=radojevic.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radojevic.rs
Received: from localhost (unknown [91.143.223.193])
	by mail.radojevic.rs (Postfix) with ESMTPSA id 587A52FC6D;
	Mon,  5 Aug 2024 12:58:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=radojevic.rs; s=mail;
	t=1722855530; bh=FsKABYar5tCCmqGtOJLbGI3S+bt2cKoGgq3u7smejfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7/eKlizt7sdBNlSEix9YYz9TnlL5rIMAc2bi8FiZVnjgXQ6W3cIbuX3WM3cHra1l
	 WzF3iMB30c+NtbhxFeiJiHtRFdahyRMi8hO9anLs39LOIuNZYSSt7DjuV8DqfOvJAU
	 sq+mCtg+yUU1qg8brul9grOd9JBVtRi1MJd/lDpZsGd22OPY5dTC5egbEbzxoWw2jm
	 Uu6nk4ZnQkPm60M6jhoJirs47BJSDuqcl8YoTMMNyf3/eovCI59Kv3VSstph0ruGQY
	 OpRoZ99cFEk6TvfxkZrA5vgykJRkratRwqXvLluNFYLYfiDA3fFo8Z9tDR03aEEnzx
	 JrERVef+hHZfQ==
Date: Mon, 5 Aug 2024 12:58:45 +0200
From: Nikola Radojevic <nikola@radojevic.rs>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Raise Pinebook Pro's panel
 backlight PWM frequency
Message-ID: <xzzqimycxuwu7yg55pxfgb7sgtmxkjhsltpcst7y7toiwspjeg@jsahtppev3kg>
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

