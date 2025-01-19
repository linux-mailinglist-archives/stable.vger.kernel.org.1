Return-Path: <stable+bounces-109474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5838BA16097
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 07:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8ACE18868DB
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 06:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCB013EFE3;
	Sun, 19 Jan 2025 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="iZsuGWik";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L96THMoR"
X-Original-To: stable@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB75C23BB;
	Sun, 19 Jan 2025 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737268560; cv=none; b=Emg6f55V3pxDfO/5cIECNIuT4CILqKNimShqN+AN1/sPG5uDel39QC+Mk2zjOjS7zHiCuDSHG8t2JF69T9Id8VamHwk3syJqZis50SR5zfcVafgm3Fdm0YttoN/aLSufGvxtw5C2QtTwcJmj1DjQDm9W9cJdr1zB4JJ5mNy72ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737268560; c=relaxed/simple;
	bh=4pc6KlEEP6sBTO1Ba5ZyMq0fkgLKgHY49UAQphPA4vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkpNdhBjlKhbmEoHPbtevZ4dmAql6x/2fOV1wKjSh9qsrC4fOjXuSzhyeyROKqEC1evZtqjnYGReHgHkLmKiW3oaqwt6r3ao/VRMCVszDjI9/jxPYmcwHkz6iPwicCQfJFa32lii7zgdaGtqJX1Fw5wxewXIpybO2ggTleJ/0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=iZsuGWik; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L96THMoR; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 8F54B2011E9;
	Sun, 19 Jan 2025 01:35:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 19 Jan 2025 01:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737268556; x=1737275756; bh=3/6jZ01/uC
	CTpSq3Fao8Iix6OttLd5/bSlWLrKSb+fw=; b=iZsuGWik/KyLleI5OKl/f1Cl/b
	2jXqCMbSiO4TPgJIzueKqFmJ83obVkKo2fZWO3zD0rP7b6BEmFK1YvAvdEbPxVJJ
	ivV/vUvanl+FEKszvP0ST5VrMhS4nWPZwrrIvwLTFw5RJ/wgync0W+kIcUVshUt0
	VdnDld+x2X0y4+PXy8bmWr29PFLd6t+K0jXCIgESRcrb260f8FZy83QxTc8hhyHs
	kmf7bJFls/RGpIhZJFgnACt0DSdJAJHMb1V8HfwCd7rG4b544j9DqdTL3X/SXapp
	bRQeuhEBCpuH2O1x+oTFRw3yhzDeUQUHK+1L6HA2hbz4TnjHlBObJWwse2MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737268556; x=1737275756; bh=3/6jZ01/uCCTpSq3Fao8Iix6OttLd5/bSlW
	LrKSb+fw=; b=L96THMoRjo13raPMbwHBAVnHjQnBXFjmtElyB+L2wc9MoZpKq4h
	EHlgJE7WQiCtyaj7OzLiK96mowCatmyDKgJblhiaGY7y222tIy3M4RUEfJmuPlkX
	zdhbsh38ESsY9jw4NirnBV7pN7evUFYjimRKQxLa7edE4WtOW/ocQECrY8zt4mal
	BRl4LrL4nbcPjKfcFayBHNJ6uw/kNL6x6LrxdqttoA2Sg9OP/FuNE8pP0r9aoSu5
	Dz6STEjj1rNzxNxPXt7fno1b4hGBE68JB+YxKl14nuPIClKJp7bWQ+uVDcK9qwSc
	Q5/9kJM26zijNKWA3x7iJ01prwcftyTUMuQ==
X-ME-Sender: <xms:S52MZxchzhOQkRz7tx4eT-aI68rr5TAPb2uDajfkjY_aLDiCV4rauQ>
    <xme:S52MZ_PcqFu4BT0vI3I1KQMgpUARY_9Uq1eoJ_0BfkJn5W1-Ag5hzzncyC69SWtca
    timTvB926Bg5Q>
X-ME-Received: <xmr:S52MZ6i9zB6CBVkRx_1w0TL3xX5kHenQXJYi5QdJwS2hWUxj-sjQeDOUzPtXYUTtbBSBPFn8PQv-VFAD6gQ6RnKoteVkKHlQDcGvwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiiedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefh
    gfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedviedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhhnshesghholhguvghlihgtohdrtghomhdprhgtph
    htthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiihihs
    iihtohhfrdhkohiilhhofihskhhiodgutheslhhinhgrrhhordhorhhgpdhrtghpthhtoh
    epfhdrfhgrihhnvghllhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhjuhhisegs
    rhhorggutghomhdrtghomhdprhgtphhtthhopehssghrrghnuggvnhessghrohgruggtoh
    hmrdgtohhmpdhrtghpthhtohepsggtmhdqkhgvrhhnvghlqdhfvggvuggsrggtkhdqlhhi
    shhtsegsrhhorggutghomhdrtghomhdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrphhiqdhkvghr
    nhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:S52MZ68cVdsDhsSObbEKTAagf9UOnQ5jppeprDSiQGFOvpOUJnVmug>
    <xmx:S52MZ9s0mkrBiB21dOeQNUf2nWd3fxUcd8u9V8QmcZjCvXjZvyDieg>
    <xmx:S52MZ5Hf73Ntd_87xVVe1LjQJ2ai6E4QG8zZivP7czIdsUeRPnI1TQ>
    <xmx:S52MZ0MISCoYZuk50m8Ynqq_y9vGwFlXMZBGOfezybrT-RO5nWQ0dw>
    <xmx:TJ2MZ2tCFrFEuiaC-kTUUqv6ugK61ddib5_QxSGa-j4ImXLXwWX_7j5X>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jan 2025 01:35:55 -0500 (EST)
Date: Sun, 19 Jan 2025 07:35:52 +0100
From: Greg KH <greg@kroah.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	letux-kernel@openphoenux.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] Revert v6.2-rc1 and later "ARM: dts: bcm2835-rpi: Use
 firmware clocks for display"
Message-ID: <2025011942-basket-subsiding-8bd1@gregkh>
References: <cb9e10dfb4f50207e33ddac16794ee6b806744da.1737217627.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb9e10dfb4f50207e33ddac16794ee6b806744da.1737217627.git.hns@goldelico.com>

On Sat, Jan 18, 2025 at 05:27:07PM +0100, H. Nikolaus Schaller wrote:
> This reverts commit 27ab05e1b7e5c5ec9b4f658e1b2464c0908298a6.
> 
> I tried to upgrade a RasPi 3B+ with Waveshare 7inch HDMI LCD
> from 6.1.y to 6.6.y but found that the display is broken with
> this log message:
> 
> [   17.776315] vc4-drm soc:gpu: bound 3f400000.hvs (ops vc4_drm_unregister [vc4])
> [   17.784034] platform 3f806000.vec: deferred probe pending
> 
> Some tests revealed that while 6.1.y works, 6.2-rc1 is already broken but all
> newer kernels as well. And a bisect did lead me to this patch.
> 
> I could repair several versions up to 6.13-rc7 by doing
> this revert. Newer kernels have just to take care of
> 
> commit f702475b839c ("ARM: dts: bcm2835-rpi: Move duplicate firmware-clocks to bcm2835-rpi.dtsi")
> 
> but that is straightforward.
> 
> Fixes: 27ab05e1b7e5 ("ARM: dts: bcm2835-rpi: Use firmware clocks for display")
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/bcm2835-rpi-common.dtsi | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm2835-rpi-common.dtsi b/arch/arm/boot/dts/bcm2835-rpi-common.dtsi
> index 4e7b4a592da7c..8a55b6cded592 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi-common.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-rpi-common.dtsi
> @@ -7,23 +7,6 @@
>  
>  #include <dt-bindings/power/raspberrypi-power.h>
>  
> -&firmware {
> -	firmware_clocks: clocks {
> -		compatible = "raspberrypi,firmware-clocks";
> -		#clock-cells = <1>;
> -	};
> -};
> -
> -&hdmi {
> -	clocks = <&firmware_clocks 9>,
> -		 <&firmware_clocks 13>;
> -	clock-names = "pixel", "hdmi";
> -};
> -
>  &v3d {
>  	power-domains = <&power RPI_POWER_DOMAIN_V3D>;
>  };
> -
> -&vec {
> -	clocks = <&firmware_clocks 15>;
> -};
> -- 
> 2.47.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

