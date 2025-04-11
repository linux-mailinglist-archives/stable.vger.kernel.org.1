Return-Path: <stable+bounces-132247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE2FA85F55
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE7F188975B
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2951AA786;
	Fri, 11 Apr 2025 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ahzxC4vl"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A247413D53B;
	Fri, 11 Apr 2025 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378717; cv=none; b=OJ21zv5bib7Fn8be1KjdKlUQPzQgEG+WfUwlZWfcWpcqrbQvsq0hm8yfJ0iiubMbvmrN4bB4SKvQrewgr4XcBk0VwrgJ9IwQBR46c34TzlNRvtg+ItxXz7f1XSTZxFTGVIEeEDxqRFm/bZRKFpBITSda4CHNvNK/qiXKOe/T/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378717; c=relaxed/simple;
	bh=FaixQ3OKBn1K5yTLDByMA1GZMZCSbDr4R3TfWKUtEnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MpKzGRrkXTQ/8QCF68O0lSZtH2lSO7dhK6e17vL8PfyB/vaCrIOfqDq7lv2oJwyfYN8S48Wqb/uVZS5ndS2/RCBJ7S5zTv1z/UgvvOo8PHY9JmGU4U4ZxShRGFpV3UKJk9Ox3X//5WZ9eFiFxQ1aLRNTl948CewH3PPfRLx4T9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ahzxC4vl; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDcPjX2086911
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 08:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744378705;
	bh=z5Mp5PjDazBwJKD9kj/i3cvmnBHjj8MU6FFvSOWimtU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ahzxC4vlWCrURiNSqahg/NcY/wlhdcOKJTRl+MxTp8D183C/b7u+NaSHo6BKRccMx
	 ATswupEEkzRFcZIoyTqKVP4Kh1WhMLeNgRbvU/4hU5c2JWxlJtfTVMBvrfb0e+vnQu
	 qKWy+Lir84OaBh+sFi3cwNBlMqTXP5E2VHizUbmc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDcPUX081979
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:38:25 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 08:38:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 08:38:24 -0500
Received: from [10.249.136.157] ([10.249.136.157])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BDcJf0098684;
	Fri, 11 Apr 2025 08:38:20 -0500
Message-ID: <16713a1b-1e74-4b08-bd4c-12dc0a9d32df@ti.com>
Date: Fri, 11 Apr 2025 19:08:18 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] arm64: dts: ti: k3-j721e-sk: Add requiried voltage
 supplies for IMX219
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>, <jai.luthra@linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <stable@vger.kernel.org>
References: <20250409134128.2098195-1-y-abhilashchandra@ti.com>
 <20250409134128.2098195-5-y-abhilashchandra@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20250409134128.2098195-5-y-abhilashchandra@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 4/9/2025 7:11 PM, Yemike Abhilash Chandra wrote:
> The device tree overlay for the IMX219 sensor requires three voltage
> supplies to be defined: VANA (analog), VDIG (digital core), and VDDL
> (digital I/O). Add the corresponding voltage supply definitions to avoid
> dtbs_check warnings.
> 
> Fixes: f767eb918096 ("arm64: dts: ti: k3-j721e-sk: Add overlay for IMX219")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
> ---
>  .../dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso  | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso b/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso
> index 4a395d1209c8..4eb3cffab032 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso

The link to the schematics seems to need updation, would like to see where these
regulators are mentioned, can't find them in [0] which I assume is the latest link.

> @@ -19,6 +19,33 @@ clk_imx219_fixed: imx219-xclk {
>  		#clock-cells = <0>;
>  		clock-frequency = <24000000>;
>  	};
> +
> +	reg_2p8v: regulator-2p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "2P8V";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		vin-supply = <&vdd_sd_dv>;
> +		regulator-always-on;
> +	};
> +
> +	reg_1p8v: regulator-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1P8V";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vdd_sd_dv>;
> +		regulator-always-on;
> +	};
> +
> +	reg_1p2v: regulator-1p2v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1P2V";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		vin-supply = <&vdd_sd_dv>;
> +		regulator-always-on;
> +	};
>  };
>  
>  &csi_mux {
> @@ -34,6 +61,9 @@ imx219_0: imx219-0@10 {
>  		reg = <0x10>;
>  
>  		clocks = <&clk_imx219_fixed>;
> +		VANA-supply = <&reg_2p8v>;
> +		VDIG-supply = <&reg_1p8v>;
> +		VDDL-supply = <&reg_1p2v>;
>  
>  		port {
>  			csi2_cam0: endpoint {
> @@ -55,6 +85,9 @@ imx219_1: imx219-1@10 {
>  		reg = <0x10>;
>  
>  		clocks = <&clk_imx219_fixed>;
> +		VANA-supply = <&reg_2p8v>;
> +		VDIG-supply = <&reg_1p8v>;
> +		VDDL-supply = <&reg_1p2v>;
>  
>  		port {
>  			csi2_cam1: endpoint {
[0] https://datasheets.raspberrypi.com/camera/camera-module-2-schematics.pdf

-- 
Thanking You
Neha Malcom Francis


