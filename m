Return-Path: <stable+bounces-2722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CAE7F97A8
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 03:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CE51C20878
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 02:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C99E1C29;
	Mon, 27 Nov 2023 02:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agjfGCz8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B3017E3;
	Mon, 27 Nov 2023 02:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF929C433C7;
	Mon, 27 Nov 2023 02:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701053544;
	bh=3Pa6bcxnUYbjzkwY5l+rItczdYmOvJ+sRLmKggT80qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=agjfGCz8JRXXIXesBromGaIESY2hzaaPocdR8C9+YKJqw/Ciojpkb+wG2c9bFzBlW
	 92clO3WsTdHdP+7V/2MtXNloz6ex/L2m9KLJ5Yl7kHRF6aCMTancW+Easgr1qcxwpL
	 bhBCxsWqt/2K1+ybpQLbYjeHGm14ZOyQMPSHt3UEGfCD550SUWnd0bnPQoChzdTIKa
	 2sZQC2Gt3iFGfMXqCgLNvY1MOTYuPCidyrZ1m9wgJuSGk+4oqrjZ4j5KkxzJW9Jgem
	 29clHg/UM+0mAi2r5ZyERTia9WQ0fVcy26924JfEKE2yO1ViNywRuRZEhx8kEPGwDj
	 R42iV4f/2tZuA==
Date: Mon, 27 Nov 2023 10:52:18 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ARM: dts: imx6q-apalis: add can power-up delay on
 ixora board
Message-ID: <20231127025218.GR87953@dragon>
References: <20231020153022.57858-1-andrejs.cainikovs@gmail.com>
 <20231020153022.57858-3-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020153022.57858-3-andrejs.cainikovs@gmail.com>

On Fri, Oct 20, 2023 at 05:30:22PM +0200, Andrejs Cainikovs wrote:
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> 
> Newer variants of Ixora boards require a power-up delay when powering up
> the CAN transceiver of up to 1ms.
> 
> Cc: stable@vger.kernel.org

Why is only the iMX6 change required for stable?

Shawn

> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> ---
>  arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts
> index 717decda0ceb..3ac7a4501620 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts
> @@ -76,6 +76,7 @@ reg_can1_supply: regulator-can1-supply {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_enable_can1_power>;
>  		regulator-name = "can1_supply";
> +		startup-delay-us = <1000>;
>  	};
>  
>  	reg_can2_supply: regulator-can2-supply {
> @@ -85,6 +86,7 @@ reg_can2_supply: regulator-can2-supply {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_enable_can2_power>;
>  		regulator-name = "can2_supply";
> +		startup-delay-us = <1000>;
>  	};
>  };
>  
> -- 
> 2.34.1
> 

