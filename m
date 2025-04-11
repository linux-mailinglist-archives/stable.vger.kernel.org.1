Return-Path: <stable+bounces-132254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE025A85FA4
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D05318949E2
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44181E5B78;
	Fri, 11 Apr 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SR5jd+om"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB39E1C3BEB;
	Fri, 11 Apr 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379431; cv=none; b=j57aPpqVlcoYM+zhahnyJdX9H8lvcoQuf1eny39R2dkpbyTh2smU/VcVSFVsusoQeys46+N6uvUBsv0pxtK3LPbmMEvUqcs45VFAleKGXgRDhWgFkeh1jYEGxioSGVjUMR9Vf6bardMWmivf1uXuJqHGnnXNuqiAx0bXoM6zLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379431; c=relaxed/simple;
	bh=fBMPce3nXkTzC5YitcBdnnxth6H4sTrD9RAuJ+F4s38=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iYWtGeUcXBFoJDcbDwDaY7R9CdcVTMz0T+J0s3dL/X92rW+n3wv9c1GmDgDLHIq/raVvKhF9ZnHmGy9w4XExmAXvCcUXJD0lsS6+2qpP9AsVpYthrlmd52jQTV/NE7TnivWpvI3+GJAkNBIVcjMP5eWyTJK1Lnqgo1a6ZneGKyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SR5jd+om; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDoJUS2141356
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 08:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744379419;
	bh=qQDSFd0KgWBYuvyGNC6FIuW3TAEXHe3afLsrb7vpjYk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SR5jd+omWQxFX6UsqjsPKJ90ihXVqD9unyjxmpgtOwxUWqzaiAGqu+/+jjisWUfZk
	 +WE12+qo/scn+FIl4BsRZoTY1FrVvLWk7j5+i8bflzxwUroKQX+ExD41QTVPhB2l8L
	 qlrxRuy3vo36UxIaEBzPUACKcMxqdba+I8Hu2sRw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDoJCD031578
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:50:19 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 08:50:19 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 08:50:18 -0500
Received: from [10.249.136.157] ([10.249.136.157])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BDoDJO001396;
	Fri, 11 Apr 2025 08:50:14 -0500
Message-ID: <293dfbda-841b-4a5a-85ac-6a6c2df5df09@ti.com>
Date: Fri, 11 Apr 2025 19:20:12 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] arm64: dts: ti: am68-sk: Fix regulator hierarchy
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>, <jai.luthra@linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <stable@vger.kernel.org>
References: <20250409134128.2098195-1-y-abhilashchandra@ti.com>
 <20250409134128.2098195-3-y-abhilashchandra@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20250409134128.2098195-3-y-abhilashchandra@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 4/9/2025 7:11 PM, Yemike Abhilash Chandra wrote:
> Update the vin-supply of the TLV71033 regulator from LM5141 (vsys_3v3) to
> LM61460 (vsys_5v0) to match the schematics. Add a fixed regulator node for
> the LM61460 5V supply to support this change.
> 
> AM68-SK schematics: https://www.ti.com/lit/zip/sprr463
> Fixes: a266c180b398 ("arm64: dts: ti: k3-am68-sk: Add support for AM68 SK base board")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> index 11522b36e0ce..5fa70a874d7b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> @@ -44,6 +44,17 @@ vusb_main: regulator-vusb-main5v0 {
>  		regulator-boot-on;
>  	};
>  
> +	vsys_5v0: regulator-vsys5v0 {
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
>  	vsys_3v3: regulator-vsys3v3 {
>  		/* Output of LM5141 */
>  		compatible = "regulator-fixed";
> @@ -76,7 +87,7 @@ vdd_sd_dv: regulator-tlv71033 {
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <3300000>;
>  		regulator-boot-on;
> -		vin-supply = <&vsys_3v3>;
> +		vin-supply = <&vsys_5v0>;
>  		gpios = <&main_gpio0 49 GPIO_ACTIVE_HIGH>;
>  		states = <1800000 0x0>,
>  			 <3300000 0x1>;

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis


