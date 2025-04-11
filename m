Return-Path: <stable+bounces-132294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005C9A864BE
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 19:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D05327AD8F3
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 17:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0B8232368;
	Fri, 11 Apr 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HDjyd73M"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C3231A2A;
	Fri, 11 Apr 2025 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392583; cv=none; b=SLcVAsbyA27LW3bD8RthurtbYvjuLsb9eZBaIQf0EiBD9m481u1dCP58TPxLlZzW7p0TvJmzTnF3ufCUSuLjX2XAoHmfopz5qL+BE5fS9wRiawkp4G/TgsSI4CfqH2SWZs3K70kbK5LupBEtsfAwUcuQCywsWeK05bmKMnFAk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392583; c=relaxed/simple;
	bh=SNjjkvPi8mDPCgliOBOb/sKtvfgDejUzyhE44uJp3mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rxdLVEmYVgQgse4KCMmYuPwa6pULMO2rsl5S43l1pAMO3glKvyAgmUQGLCbP0UnlKtkVIIjzZhHeo09auZh+6bGLP4YAdtLmogNKjrgDbyirKCYmL7s5UC9lvtGil9jLfu2vkxTDWmtFuaTYMWATXMqQmeQ6yZfhYNN54hqL3lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HDjyd73M; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BHTU492187578
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 12:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744392570;
	bh=0CmmRFEk2Mpf6bDBwWDF9TSqpw/smnpuGGU09f+E/SM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=HDjyd73MFFe9fhAPqvvRBo9bMJaUdSpHxcNQ+s2jLa7FRWsF95qQFJI28yYTJnrgw
	 kurLC3kqP8AQpXiN6ku8PhT40Z6xpOuEXqM2CzDPTtL98ozxh+QrmViA83CT5KocVZ
	 BXkuXhCqtcE8eY7cTNpEn5+iVZq4oOHiM8VrTIkA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BHTUF6128866
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 12:29:30 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 12:29:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 12:29:29 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BHTPSt002976;
	Fri, 11 Apr 2025 12:29:26 -0500
Message-ID: <624fd8c5-1315-4af3-8fb2-486ca95045f2@ti.com>
Date: Fri, 11 Apr 2025 22:59:25 +0530
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
        <stable@vger.kernel.org>, <u-kumar1@ti.com>
References: <20250409134128.2098195-1-y-abhilashchandra@ti.com>
 <20250409134128.2098195-3-y-abhilashchandra@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250409134128.2098195-3-y-abhilashchandra@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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
>   arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> index 11522b36e0ce..5fa70a874d7b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> @@ -44,6 +44,17 @@ vusb_main: regulator-vusb-main5v0 {
>   		regulator-boot-on;
>   	};
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
>   	vsys_3v3: regulator-vsys3v3 {
>   		/* Output of LM5141 */
>   		compatible = "regulator-fixed";
> @@ -76,7 +87,7 @@ vdd_sd_dv: regulator-tlv71033 {
>   		regulator-min-microvolt = <1800000>;
>   		regulator-max-microvolt = <3300000>;
>   		regulator-boot-on;
> -		vin-supply = <&vsys_3v3>;
> +		vin-supply = <&vsys_5v0>;
>   		gpios = <&main_gpio0 49 GPIO_ACTIVE_HIGH>;


Please ignore previous comment , I realized you are changing parent for 
tlv71033 not for vsys_3v3.

With that

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   		states = <1800000 0x0>,
>   			 <3300000 0x1>;

