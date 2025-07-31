Return-Path: <stable+bounces-165605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EC3B16990
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 02:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9C518C5E9B
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 00:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757234690;
	Thu, 31 Jul 2025 00:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjEecx/v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C99A10E5;
	Thu, 31 Jul 2025 00:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753921046; cv=none; b=gzXtKyk0K9nHLEjw3pMzBiX0y75sg7smcAr/GnRuFE2TeFfgGTtvbWKKAJF5e7j9G2JDCoBldKy98yP6+6EtjfyV+QDnKhYFaOozK6dQgJjqrv+5gW3ujAmrDhypdn5nt1FXHeTMebb8B5nh4ndaFBtmQO3Q7R0Pz/dEVfS7gjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753921046; c=relaxed/simple;
	bh=SdCrAcgGtnYmocw+W0qZSbGDaU5Sy9OcegMik9AZgfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDh47u1c4RVDonDQxcow1HWfK2HE7Z2oeOa6t5DMNCvbQeQOQAzXG8ogaCHBMPw6VszjUAcCiGBcg5UphZl55VunorZUA//flWinfMPHmtk48tRpyTi2eyp9jvPl3Pw3b88JQnghvOMBvh4121Ts9e53KQ5uc05bP4/lSzWEZps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjEecx/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7440C4CEE3;
	Thu, 31 Jul 2025 00:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753921046;
	bh=SdCrAcgGtnYmocw+W0qZSbGDaU5Sy9OcegMik9AZgfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjEecx/vvmZS4SALcyWAoonJEPrujzYZDKvI++ulsgBGQV60FqSxx4SwUVY8eaLoJ
	 wuwfVG9/33Ft2QfbsfKLmGlittcBJ8krYRye4hNQWGkMKFmuVMKkvEZvdGGvuGsuxx
	 Psy83nLRw0Cm+5U5EEGWCA+R/6pz/BHtgUfQO2VAPMUCaDPMhicsgutD3IDnq+izHG
	 NNO+rcsGcjuXL6DLxOvvYuBzYrIm6c625iYiw3jTaw27A0AjtmQIjef0dnrpj4wVl+
	 Brg60SrZHq1bVKHh6vASLlXEZecRL4BwkO4RRHs5TdHSYzX0nYJAbhNIXe9VMMxsBo
	 T7KxvJEISu9Fw==
Date: Wed, 30 Jul 2025 19:17:25 -0500
From: Rob Herring <robh@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Jyri Sarha <jyri.sarha@iki.fi>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Benoit Parrot <bparrot@ti.com>, Lee Jones <lee@kernel.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, thomas.petazzoni@bootlin.com,
	Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: ti: k3-am62-main: Add tidss clk-ctrl
 property
Message-ID: <20250731001725.GA1938112-robh@kernel.org>
References: <20250730-fix-edge-handling-v1-0-1bdfb3fe7922@bootlin.com>
 <20250730-fix-edge-handling-v1-3-1bdfb3fe7922@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730-fix-edge-handling-v1-3-1bdfb3fe7922@bootlin.com>

On Wed, Jul 30, 2025 at 07:02:46PM +0200, Louis Chauvet wrote:
> For am62 processors, we need to use the newly created clk-ctrl property to
> properly handle data edge sampling configuration. Add them in the main
> device tree.
> 
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
> 
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 9e0b6eee9ac77d66869915b2d7bec3e2275c03ea..d3131e6da8e70fde035d3c44716f939e8167795a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -76,6 +76,11 @@ audio_refclk1: clock-controller@82e4 {
>  			assigned-clock-parents = <&k3_clks 157 18>;
>  			#clock-cells = <0>;
>  		};
> +
> +		dss_clk_ctrl: dss_clk_ctrl@8300 {
> +			compatible = "ti,am625-dss-clk-ctrl", "syscon";
> +			reg = <0x8300 0x4>;

H/w blocks are rarely only 4 bytes of registers... Does this belong to 
some larger block. The problem with bindings defining single registers 
like this is they don't get defined until needed and you have a constant 
stream of DT updates.

> +		};
>  	};
>  
>  	dmss: bus@48000000 {
> @@ -787,6 +792,7 @@ dss: dss@30200000 {
>  			 <&k3_clks 186 2>;
>  		clock-names = "fck", "vp1", "vp2";
>  		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +		ti,clk-ctrl = <&dss_clk_ctrl>;
>  		status = "disabled";
>  
>  		dss_ports: ports {
> 
> -- 
> 2.50.1
> 

