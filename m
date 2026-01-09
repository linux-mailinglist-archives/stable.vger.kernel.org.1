Return-Path: <stable+bounces-206442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA076D08879
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 11:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4940D3055722
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF49B3382C0;
	Fri,  9 Jan 2026 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="ZGI+t2nW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SFd3Rlw+"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCE1336EC8;
	Fri,  9 Jan 2026 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954193; cv=none; b=H8QJhcjlkJeDgJSburJKmY6+RcvTOqbTNRnNDzjga2p+vdIug7c2vfnMmo0Q2m7jFXcBBuzml7zhKW2mdV95UMUjbOU6HbDPUYnCnnf+/3PlDuxRufdDUMa9DnwsJv0JAVOM0TB+wUrbG5lQGIy9xGJcbS1jwV+Vs/9mCVVNkdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954193; c=relaxed/simple;
	bh=VNATSDjCrEY/jf8XaE9+O0ats9QWrtrAh4NUr3CL8s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nw35T/EDHsCH7xfqF+/ByW4y5hk+7l05rNnSunWnL/MsCVnOtDqdfn8s8oRegcF5BRWbDkqb32URt6jPgHJwIdHO92QWMoSEr7El4EnDJ4Ybn5c7vjKaEdSpAgomsZ0YKOtasNYWQQK2HkEDrwuGuDpbcCM9+2TUv5srE9zkQyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=ZGI+t2nW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SFd3Rlw+; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4DCF37A0159;
	Fri,  9 Jan 2026 05:23:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 05:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767954191; x=1768040591; bh=QyD5/S3P7h
	Qhgp+mxf+HZfsHxt4R/xJ40k1a8U9/co8=; b=ZGI+t2nWoU+whtBN4otdN/Ep9W
	SMkAffK4Gvk81+dnR2mIY27qv7kFjRugMwX23sPNh5kWr6nPokJ7FAD0gHtMYzKx
	PtnOi4AjwZnIephM2weZAQSpTVGJHYddFoATUptKE8eV8rcyzVKZm6HxjgmmqaoR
	IZePIH2JivWNGvVBIb1DmvL2vQmHuZMJ9GkSzZ8cEAV78ixWNKEKPS3slYnHjgL9
	yty3Q/9/7HWg40v9A4t4EM7eAasYByETz6RHqjiJTVSqSHwtxKLcUlsRYajmadD8
	8LuYl6ZMGDEx0tn58TcM/I22Z2cHNVD7JuQh/90SdpvTGRN0rxmSwlVKLlMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767954191; x=1768040591; bh=QyD5/S3P7hQhgp+mxf+HZfsHxt4R/xJ40k1
	a8U9/co8=; b=SFd3Rlw+L5aou7JPLylh5yMmduWngesz6OC3jlrkt5xF32sFXAT
	cCSnh61B2CbfGcdSzxz43BwVsBbQSTECZb1bo+fJMYTZGGU1vEaNp69HuHkdH9f9
	I/8gI2WYT8q0vZpuRwBbL8dKdlECvj0iNC7ZcxM7JJCXX5OSZuogARIO2DWz/GsR
	cbfIyDG7UY4p3GXWFHe1KaW94bZtpUuQX2Bzb/eTNxRP98CZXkNKWXnA9f/Mv+Dj
	xmvhStvc8TcOCkuZkwib6BTpEVVDwckKRTtP0MNff/EkFxsZ/wAgokkQ4Wsof7MX
	/7qz4qoxz1DEtOkXS41RNe0oHZ9zbLvIqFg==
X-ME-Sender: <xms:DtdgaRdyhcMJucOoseeHa_yxjmGROU_SnYAML2vFoBkWk4F25UY9NA>
    <xme:DtdgadfD_qX0DZHWFwvGyczWaTIeWoPeEHx5LGJ6uNMPKNEWTXVFpSIa_lIcUSx3s
    nkI1Wfuj6d4cl06bSNM22vjma-6Pev3qXt2vSM9OjsnGCbkfvq0XKI>
X-ME-Received: <xmr:DtdgaT3Q7oSNJ735QCddXUpMKolfpQNgiOgZSOuqRpyK66MdXTmfpnHuGQ93yM5B7nPzJfF7Lw5RkZ73A72vJuzhujyRNNcSbw8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhnvgcu
    ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgvd
    ffveelgedujeeffeehheekheelheefgfejffeftedugeethfeuudefheefteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
    drnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsvhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvrghlsehgohhmph
    grrdguvghvpdhrtghpthhtohepthhhihhnhhdrnhhguhihvghnsehshihnohhpshihshdr
    tghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghp
    thhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrg
    gurdhorhhgpdhrtghpthhtoheplhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjtggrlhhlihhgvghrohhsleelsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Dtdgad9K5v0acRiFtqxSTkV5bcwXjiToHXTmIf_IpzO-O2vmNNsfpw>
    <xmx:DtdgaQ5WsTkBqmMoFd4pp24thbILTdc9j-WdF-vblOJwCh40GVJWpw>
    <xmx:Dtdgadui6xmFHk4oKdV6nzGqOzsUj5OI3lJF4WBB99k9COGcXt6DBg>
    <xmx:Dtdgaa1S2pG-wjfJYerCosMUsClraUwXBBgY921jqWf3p97yjgrtvw>
    <xmx:D9dgacc9QpM8zOFf9mJEjXzxAXtmi_wEMmVGfhvEb4D94VZ-9N41SCEA>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 05:23:09 -0500 (EST)
Date: Fri, 9 Jan 2026 11:23:09 +0100
From: Janne Grunau <j@jannau.net>
To: Sven Peter <sven@kernel.org>
Cc: Neal Gompa <neal@gompa.dev>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	James Calligeros <jcalligeros99@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: apple: Set USB2 PHY mode before dwc3 init
Message-ID: <20260109102309.GE4068972@robin.jannau.net>
References: <20260108-dwc3-apple-usb2phy-fix-v1-1-5dd7bc642040@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108-dwc3-apple-usb2phy-fix-v1-1-5dd7bc642040@kernel.org>

On Thu, Jan 08, 2026 at 08:21:45PM +0100, Sven Peter wrote:
> Now that the upstream code has been getting broader test coverage by our
> users we occasionally see issues with USB2 devices plugged in during boot.
> Before Linux is running, the USB2 PHY has usually been running in device
> mode and it turns out that sometimes host->device or device->host
> transitions don't work.
> The root cause: If the role inside the USB2 PHY is re-configured when it
> has already been powered on or when dwc2 has already enabled the ULPI

"dwc3", typo noticed by Mark Kettenis

> interface the new configuration sometimes doesn't take affect until dwc3
> is reset again. Fix this rare issue by configuring the role much earlier.
> Note that the USB3 PHY does not suffer from this issue and actually
> requires dwc3 to be up before the correct role can be configured there.
> 
> Reported-by: James Calligeros <jcalligeros99@gmail.com>
> Reported-by: Janne Grunau <j@jannau.net>
> Fixes: 0ec946d32ef7 ("usb: dwc3: Add Apple Silicon DWC3 glue layer driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  drivers/usb/dwc3/dwc3-apple.c | 48 +++++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-apple.c b/drivers/usb/dwc3/dwc3-apple.c
> index cc47cad232e397ac4498b09165dfdb5bd215ded7..c2ae8eb21d514e5e493d2927bc12908c308dfe19 100644
> --- a/drivers/usb/dwc3/dwc3-apple.c
> +++ b/drivers/usb/dwc3/dwc3-apple.c
> @@ -218,25 +218,31 @@ static int dwc3_apple_core_init(struct dwc3_apple *appledwc)
>  	return ret;
>  }
>  
> -static void dwc3_apple_phy_set_mode(struct dwc3_apple *appledwc, enum phy_mode mode)
> -{
> -	lockdep_assert_held(&appledwc->lock);
> -
> -	/*
> -	 * This platform requires SUSPHY to be enabled here already in order to properly configure
> -	 * the PHY and switch dwc3's PIPE interface to USB3 PHY.
> -	 */
> -	dwc3_enable_susphy(&appledwc->dwc, true);
> -	phy_set_mode(appledwc->dwc.usb2_generic_phy[0], mode);
> -	phy_set_mode(appledwc->dwc.usb3_generic_phy[0], mode);
> -}
> -
>  static int dwc3_apple_init(struct dwc3_apple *appledwc, enum dwc3_apple_state state)
>  {
>  	int ret, ret_reset;
>  
>  	lockdep_assert_held(&appledwc->lock);
>  
> +	/*
> +	 * The USB2 PHY on this platform must be configured for host or device mode while it is
> +	 * still powered off and before dwc3 tries to access it. Otherwise, the new configuration
> +	 * will sometimes only take affect after the *next* time dwc3 is brought up which causes
> +	 * the connected device to just not work.
> +	 * The USB3 PHY must be configured later after dwc3 has already been initialized.
> +	 */
> +	switch (state) {
> +	case DWC3_APPLE_HOST:
> +		phy_set_mode(appledwc->dwc.usb2_generic_phy[0], PHY_MODE_USB_HOST);
> +		break;
> +	case DWC3_APPLE_DEVICE:
> +		phy_set_mode(appledwc->dwc.usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
> +		break;
> +	default:
> +		/* Unreachable unless there's a bug in this driver */
> +		return -EINVAL;
> +	}
> +
>  	ret = reset_control_deassert(appledwc->reset);
>  	if (ret) {
>  		dev_err(appledwc->dev, "Failed to deassert reset, err=%d\n", ret);
> @@ -257,7 +263,13 @@ static int dwc3_apple_init(struct dwc3_apple *appledwc, enum dwc3_apple_state st
>  	case DWC3_APPLE_HOST:
>  		appledwc->dwc.dr_mode = USB_DR_MODE_HOST;
>  		dwc3_apple_set_ptrcap(appledwc, DWC3_GCTL_PRTCAP_HOST);
> -		dwc3_apple_phy_set_mode(appledwc, PHY_MODE_USB_HOST);
> +		/*
> +		 * This platform requires SUSPHY to be enabled here already in order to properly
> +		 * configure the PHY and switch dwc3's PIPE interface to USB3 PHY. The USB2 PHY
> +		 * has already been configured to the correct mode earlier.
> +		 */
> +		dwc3_enable_susphy(&appledwc->dwc, true);
> +		phy_set_mode(appledwc->dwc.usb3_generic_phy[0], PHY_MODE_USB_HOST);
>  		ret = dwc3_host_init(&appledwc->dwc);
>  		if (ret) {
>  			dev_err(appledwc->dev, "Failed to initialize host, ret=%d\n", ret);
> @@ -268,7 +280,13 @@ static int dwc3_apple_init(struct dwc3_apple *appledwc, enum dwc3_apple_state st
>  	case DWC3_APPLE_DEVICE:
>  		appledwc->dwc.dr_mode = USB_DR_MODE_PERIPHERAL;
>  		dwc3_apple_set_ptrcap(appledwc, DWC3_GCTL_PRTCAP_DEVICE);
> -		dwc3_apple_phy_set_mode(appledwc, PHY_MODE_USB_DEVICE);
> +		/*
> +		 * This platform requires SUSPHY to be enabled here already in order to properly
> +		 * configure the PHY and switch dwc3's PIPE interface to USB3 PHY. The USB2 PHY
> +		 * has already been configured to the correct mode earlier.
> +		 */
> +		dwc3_enable_susphy(&appledwc->dwc, true);
> +		phy_set_mode(appledwc->dwc.usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
>  		ret = dwc3_gadget_init(&appledwc->dwc);
>  		if (ret) {
>  			dev_err(appledwc->dev, "Failed to initialize gadget, ret=%d\n", ret);
> 

Tested-by: Janne Grunau <j@jannau.net>
Reviewed-by: Janne Grunau <j@jannau.net>

Janne

