Return-Path: <stable+bounces-132243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3600BA85F37
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F5D1BC4B32
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D7F203714;
	Fri, 11 Apr 2025 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ubbbPPRo"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38B1F1507;
	Fri, 11 Apr 2025 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378374; cv=none; b=PwEnzXn/+zBxbGYVaK+fD6M10BXyG6qkmIUVy3DkJh1HdJH3LnSh9P+MIud8N8S9qup+3GK6u/tbfzZrUXgkq+eEcyU7Zhaks6hf7WmR+hK5A1KP6zELwcwQCLyZXiZixUzhlmOLPHLT6hAZPHrvfF/758c/IYwzHk5xAXL3fo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378374; c=relaxed/simple;
	bh=az4A2h4Fh8Qax5uqmPNNmxM9dROSi+JrFtVmdCqudbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VEtf6G5FabkyrxeREcOMtyyGJ1IFW+ekm46PrWgIWpVghleEv1jTaG760RBFDbM9Ja84fi040w9GJA66mkp2UJ9O4bS4Falag6vLwHxw+Wo4fyOuYcvIV9p4VpoDgVMPYWrDAb9hQbedS9+C8aqPijkmvkf3ird76+h+2hVsVUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ubbbPPRo; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDWWYb2086133
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 08:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744378352;
	bh=Gboexee6mD0L1jweFt2EEXBwApJzHNO1ztWVUzHiKoM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ubbbPPRoTePNDMPdfLtMBZpmJTGOITP771vSjv2qNk/m54WJmWZEd6mPuKrciEIaC
	 DeNzEG0VetxaLfgDHEtM/94Js/4z87J1JVfg1lt0fE71nLWA6oCsnCd9p+GslJqQHC
	 9uLnFeAhmC/jK+P1OqRzsORAQ94R1tTyhlg3Q4D4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDWW1p021039
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:32:32 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 08:32:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 08:32:31 -0500
Received: from [10.249.136.157] ([10.249.136.157])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BDWQDe107922;
	Fri, 11 Apr 2025 08:32:27 -0500
Message-ID: <9d0f7fc5-070d-4475-8569-d3e0e9421313@ti.com>
Date: Fri, 11 Apr 2025 19:02:26 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] arm64: dts: ti: j721e-sk: Add DT nodes for power
 regulators
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>, <jai.luthra@linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <stable@vger.kernel.org>
References: <20250409134128.2098195-1-y-abhilashchandra@ti.com>
 <20250409134128.2098195-2-y-abhilashchandra@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20250409134128.2098195-2-y-abhilashchandra@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Abhilash

On 4/9/2025 7:11 PM, Yemike Abhilash Chandra wrote:
> Add device tree nodes for two power regulators on the J721E SK board.
> vsys_5v0: A fixed regulator representing the 5V supply output from the
> LM61460 and vdd_sd_dv: A GPIO-controlled TLV71033 regulator.
> 
> J721E-SK schematics: https://www.ti.com/lit/zip/sprr438
> Fixes: 1bfda92a3a36 ("arm64: dts: ti: Add support for J721E SK")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 31 ++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> index 440ef57be294..4965957e6545 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> @@ -184,6 +184,17 @@ vsys_3v3: fixedregulator-vsys3v3 {
>  		regulator-boot-on;
>  	};
>  
> +	vsys_5v0: fixedregulator-vsys5v0 {
> +		/* Output of LM61460 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_5v0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vusb_main>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
>  	vdd_mmc1: fixedregulator-sd {
>  		compatible = "regulator-fixed";
>  		pinctrl-names = "default";
> @@ -211,6 +222,20 @@ vdd_sd_dv_alt: gpio-regulator-tps659411 {
>  			 <3300000 0x1>;
>  	};
>  
> +	vdd_sd_dv: gpio-regulator-TLV71033 {
> +		compatible = "regulator-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_sd_dv_pins_default>;
> +		regulator-name = "tlv71033";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		vin-supply = <&vsys_5v0>;
> +		gpios = <&main_gpio0 118 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x0>,
> +			 <3300000 0x1>;
> +	};
> +
>  	transceiver1: can-phy1 {
>  		compatible = "ti,tcan1042";
>  		#phy-cells = <0>;
> @@ -613,6 +638,12 @@ J721E_WKUP_IOPAD(0xd4, PIN_OUTPUT, 7) /* (G26) WKUP_GPIO0_9 */
>  		>;
>  	};
>  
> +	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x1dc, PIN_INPUT, 7) /* (Y1) SPI1_CLK.GPIO0_118 */
> +		>;
> +	};
> +
>  	wkup_uart0_pins_default: wkup-uart0-default-pins {
>  		pinctrl-single,pins = <
>  			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis


