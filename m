Return-Path: <stable+bounces-71708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FD29675EC
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 12:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9974C1C20CF9
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6045E1552FF;
	Sun,  1 Sep 2024 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="jib5dOBm"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5E14D449
	for <stable@vger.kernel.org>; Sun,  1 Sep 2024 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725187788; cv=none; b=d62vMiQLLA0pwDKRT6LjQAFhKJtvpuLepzhBdpIVecgEwy5EudCfpLVXQ4ve8nmDPjnzDq0NnnEFoKt5SK+QOkgVlj2TNSn0rKzefbwznBNUa43sy341kLidwf9q1YxUTVb8tar5U68iVYB0G0vraIxNhfyfGEXEkoXAV12yzSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725187788; c=relaxed/simple;
	bh=1SoUrcuwAezmoBbfSHXp5udejjTS9HsVQxmLO8RhqpI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t6o0LMS0+ewedQBiWVSDNnEja+whp4Uiq894kN59nV0MNEOtABOjLM0jCjhQ4N33ympNDAbx/ykDJng3GFh89QF6hlkmI7gZLI8JxVTNWWuhkg3Qk706CnKoAhc/UZw1wcgXfemwwF7uCwL+DZeiVsOrVr4x2xjJv+SFn5pN7U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=jib5dOBm; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id kZROsSciovH7lki9LsOaxv; Sun, 01 Sep 2024 10:49:39 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id ki9IsOpyHJ5A8ki9JscaZP; Sun, 01 Sep 2024 10:49:38 +0000
X-Authority-Analysis: v=2.4 cv=U6iUD/ru c=1 sm=1 tr=0 ts=66d446c2
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=-pn6D5nKLtMA:10 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=vU9dKmh3AAAA:8 a=DNHG93h_ET7fCttHZXgA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=rsP06fVo5MYu2ilr0aT5:22 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ywGVdaOBlZPdTax7+8AIJtGdavEx9jH0B5JlhRclrvs=; b=jib5dOBmkXongdaFb6+eNDbK5o
	jnSqgEzoUpxAB90W3aZjQLVvK28NhDRgji4ZP7rtMiWm1IApK1PVth707D1xd3aNWPSHTxB1M3Zri
	DE5Zwjl0w+NQ/NnEk0cu96YZ4VzU5JuFIdFi+c1NlkdCsAEUzdzd0UeNGoZneMClDdL0oI2F9YnbJ
	BS7nUBreTbw26dZ6sWt9dONlE6TUBPxUCb8QMas3OiM06uE1rQiA2qnJIYtAegC6aRnEynuMfcOKZ
	QoE1mk7vIb2krjM2jVhY8U6o4FhTkl/WxVbeH4J0sF2d3d4qf2X7zZBtg0PboJSMMNa1oziJt1wsR
	TC/a0KJg==;
Received: from [122.165.245.213] (port=54982 helo=[192.168.1.5])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1ski9D-003WMg-0I;
	Sun, 01 Sep 2024 16:19:31 +0530
Message-ID: <ae9c8916-27b4-4296-b827-92336a158294@linumiz.com>
Date: Sun, 1 Sep 2024 16:19:26 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: imx6ull-seeed-npi: fix fsl,pins property in
 tscgrp pinctrl
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Jagan Teki <jagan@amarulasolutions.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240831101129.15640-1-krzysztof.kozlowski@linaro.org>
 <20240831101129.15640-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <20240831101129.15640-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1ski9D-003WMg-0I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.5]) [122.165.245.213]:54982
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 1
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFiBPlFguHK/3pUlfZUTvmeCRxq+cQmWdRuYmpGoYNmaMlfiEEJkfhcm6SNKslb+QIxf/uMQESniAgnpGL5BHVp5zia8QmZe/+WAj2ZywMGx4lXVlsVy
 rsmV5QywqUAV7yTuKMIqHt/gnCGSvQgZFBAuvaro1pPt+VA+95Ggv2DIDyJn3MK9WeLLxlglkitxKTYAzjVkbLS4lT82XgcP7lQ=

Thanks.

On 8/31/24 3:41 PM, Krzysztof Kozlowski wrote:
> The property is "fsl,pins", not "fsl,pin".  Wrong property means the pin
> configuration was not applied.  Fixes dtbs_check warnings:
> 
>   imx6ull-seeed-npi-dev-board-emmc.dtb: pinctrl@20e0000: uart1grp: 'fsl,pins' is a required property
>   imx6ull-seeed-npi-dev-board-emmc.dtb: pinctrl@20e0000: uart1grp: 'fsl,pin' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Cc: <stable@vger.kernel.org>
> Fixes: e3b5697195c8 ("ARM: dts: imx6ull: add seeed studio NPi dev board")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Parthiban Nallathambi <parthiban@linumiz.com>

Thanks,
Parthiban
> ---
>  .../dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi     | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
> index 6bb12e0bbc7e..50654dbf62e0 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
> @@ -339,14 +339,14 @@ MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x120b0
>  	};
>  
>  	pinctrl_uart1: uart1grp {
> -		fsl,pin = <
> +		fsl,pins = <
>  			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
>  			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
>  		>;
>  	};
>  
>  	pinctrl_uart2: uart2grp {
> -		fsl,pin = <
> +		fsl,pins = <
>  			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
>  			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
>  			MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
> @@ -355,7 +355,7 @@ MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
>  	};
>  
>  	pinctrl_uart3: uart3grp {
> -		fsl,pin = <
> +		fsl,pins = <
>  			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
>  			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
>  			MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b0b1
> @@ -364,21 +364,21 @@ MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
>  	};
>  
>  	pinctrl_uart4: uart4grp {
> -		fsl,pin = <
> +		fsl,pins = <
>  			MX6UL_PAD_UART4_TX_DATA__UART4_DCE_TX	0x1b0b1
>  			MX6UL_PAD_UART4_RX_DATA__UART4_DCE_RX	0x1b0b1
>  		>;
>  	};
>  
>  	pinctrl_uart5: uart5grp {
> -		fsl,pin = <
> +		fsl,pins = <
>  			MX6UL_PAD_UART5_TX_DATA__UART5_DCE_TX	0x1b0b1
>  			MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX	0x1b0b1
>  		>;
>  	};
>  
>  	pinctrl_usb_otg1_id: usbotg1idgrp {
> -		fsl,pin = <
> +		fsl,pins = <
>  			MX6UL_PAD_GPIO1_IO00__ANATOP_OTG1_ID	0x17059
>  		>;
>  	};

