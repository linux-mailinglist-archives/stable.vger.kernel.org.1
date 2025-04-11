Return-Path: <stable+bounces-132245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8247AA85F23
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 608E87B6C62
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B1D1DD873;
	Fri, 11 Apr 2025 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LM0H+poP"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648E51A23AF;
	Fri, 11 Apr 2025 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378517; cv=none; b=boulvqzUxHP7z/D7VhNPcIKkhVRARTGZom++DDDBcGazg4PvLWziUUzFOwOd+2F2UkXAdiqfcZYr2OLtwhJ6eAcaE8PSXOBhQtpfev9JI7WfJcov5dgp0EhdtsCWwi4+e8Vd+JrQAO/rSxxUT6CgLJAaIZIgnMQdqejep7rCH/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378517; c=relaxed/simple;
	bh=/VrBix4KFX+LkLZ2ADdTS7rrKcZR25v02dDex2UPKy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f+2rW598UqZkujbd/9yh5/HUico00xvdZ2pHbCUTpobKkOr01zb1V7fOCjSJ2pvi3TCNxLZcONjvQnKKc0qrzOIVNL4HGCN4kIpiznKykqKTL3I+DlclZ1zBJ5x6pd8XVDQVV61GBcJmHK+zIwJr0PlZ9PDXW36xvwshTBUufWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LM0H+poP; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDYgPT2086377
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 08:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744378482;
	bh=vq5qWpYQwtAn+8K0fBlNkwMKc2ZES2aYbbqGIKGkRWw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=LM0H+poPMU7hM+cfUkNMeLijFODEYYO0coGabaLfjrtAZ4NLl45vnP/M3Z7tghlzj
	 yKrGfqAnaQKVs0zMEWWDFVF0mEtR1RxFsjH3mVY4aRYLVrGfn3KbWdlybreA174xUP
	 a/Lzd8N/0j09AsZFmQuBLZSO6WKIBIf0GqDNdBe4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDYgMw047723
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:34:42 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 08:34:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 08:34:42 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BDYbPA110090;
	Fri, 11 Apr 2025 08:34:38 -0500
Message-ID: <44c3ec3d-2fa3-4a61-8c93-5ef4791fcf8a@ti.com>
Date: Fri, 11 Apr 2025 19:04:36 +0530
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
        <stable@vger.kernel.org>, <u-kumar1@ti.com>
References: <20250409134128.2098195-1-y-abhilashchandra@ti.com>
 <20250409134128.2098195-2-y-abhilashchandra@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250409134128.2098195-2-y-abhilashchandra@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 4/9/2025 7:11 PM, Yemike Abhilash Chandra wrote:
> Add device tree nodes for two power regulators on the J721E SK board.
> vsys_5v0: A fixed regulator representing the 5V supply output from the
> LM61460 and vdd_sd_dv: A GPIO-controlled TLV71033 regulator.
>
> J721E-SK schematics: https://www.ti.com/lit/zip/sprr438
> Fixes: 1bfda92a3a36 ("arm64: dts: ti: Add support for J721E SK")

For me does not looks like a fix, you can adding missing nodes


> Cc: stable@vger.kernel.org
> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 31 ++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> index 440ef57be294..4965957e6545 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> @@ -184,6 +184,17 @@ vsys_3v3: fixedregulator-vsys3v3 {
>   		regulator-boot-on;
>   	};
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
>   	vdd_mmc1: fixedregulator-sd {
>   		compatible = "regulator-fixed";
>   		pinctrl-names = "default";
> @@ -211,6 +222,20 @@ vdd_sd_dv_alt: gpio-regulator-tps659411 {
>   			 <3300000 0x1>;
>   	};
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
>   	transceiver1: can-phy1 {
>   		compatible = "ti,tcan1042";
>   		#phy-cells = <0>;
> @@ -613,6 +638,12 @@ J721E_WKUP_IOPAD(0xd4, PIN_OUTPUT, 7) /* (G26) WKUP_GPIO0_9 */
>   		>;
>   	};
>   
> +	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x1dc, PIN_INPUT, 7) /* (Y1) SPI1_CLK.GPIO0_118 */

Shouldn't be this pin be output to control regulator ?


> +		>;
> +	};
> +
>   	wkup_uart0_pins_default: wkup-uart0-default-pins {
>   		pinctrl-single,pins = <
>   			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */

