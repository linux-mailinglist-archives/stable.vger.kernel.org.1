Return-Path: <stable+bounces-132251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15720A85F9B
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A8917BB3E
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA831F099A;
	Fri, 11 Apr 2025 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gk2uQTcH"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2CE1D95B3;
	Fri, 11 Apr 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379183; cv=none; b=Ry97x6ZZiiorFGdQLAGNJmYUsmLz5oQ7zucTdZxdqTgAtBsU6KnLckY228ghelTm05Vt0ykbNpdcX77gMtVTMAUuhRrKYKjWa9/JIN8SNP2I9dC38ESBimqMoK5r0EPB1zTspw7baA46L5tXZZZtYakGiNZupBjY/kvD1NB0PFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379183; c=relaxed/simple;
	bh=zw6iXtHpECB8AOe7/FVi+IgvgSypoJ2Ji1MLxsLtHx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YXF3usQq66Z2dSnxt/QkpKspUNMC1+ZJsgDYRHj9m2FktwGHR2MTAZrSH5wWWKyUoD8Jq/KGhXrNL4AppFjkWGFFPs5xDP+SPUjGOXQwBgXVp7yx/oTfAG9VvPFDuTjDtFtTOny5FIh/EIICMDUsqF6NOxMY2lEFR/KkKcUJXok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Gk2uQTcH; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDkB0a2140146
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 08:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744379171;
	bh=dyl4VJ4NFKTvxc57ODEOoVjJmEfMQrs8ZXag1cIaiu0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Gk2uQTcHeH4nzT6Glj0uV8LS0iUAda68IF4ZwTF0mGzcW11qGTDUo24Emn6kLRBpX
	 SWehkYMfkE968s7ORvuFuh0P903Qp2G/RFTtyq1cC6n9wg2WqfZsaKjJK/BZh3/pob
	 QFJTH+KUz9kIz9uawiCPq+jWGG3BNxwZHwU+ub40=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDkBlG054534
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:46:11 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 08:46:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 08:46:10 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BDk6S7109624;
	Fri, 11 Apr 2025 08:46:07 -0500
Message-ID: <6b730f33-9d83-4ced-839d-dc03b2eb8e4c@ti.com>
Date: Fri, 11 Apr 2025 19:16:05 +0530
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
        <stable@vger.kernel.org>
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

Looking at schematic page -3

USB PD Controller is giving input to LM61460 , LM5141(3V3), and TPS62177.

Could you please recheck this, vin-supply for 3v3 regulator

Thanks

Udit


>   		gpios = <&main_gpio0 49 GPIO_ACTIVE_HIGH>;
>   		states = <1800000 0x0>,
>   			 <3300000 0x1>;

