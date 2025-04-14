Return-Path: <stable+bounces-132443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ED2A87FAF
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09241898156
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342C52980DE;
	Mon, 14 Apr 2025 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pPvENMRg"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD45119924E;
	Mon, 14 Apr 2025 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631436; cv=none; b=lLNzqlJEVdKAqkXPJul1gOXKpK+cPNHQFSSzUnbQ3b4r6SaecDuGn5a09tyTYi9ZPK3TMWGVO1xfwMSs6AYL7BjKdYVLB0Fc41oNgzynskN2WMyAJRk9H0A7Al1Tmhsyya+cyVuAAvgQF5P/udxSSiJR6GYmC3VMyclxL/APpRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631436; c=relaxed/simple;
	bh=ZrzXp43neMTktJlC5UlCc6/EXuIAX9V8IWG+IqHuM7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=no7T1X4/zWAz7/1orOc7fArVD6UlMGbos0srZMZZMIGwOOEi+ah+IFURaEymTHXvlSxZJCOPaeJfgD9P6zg8KrjlTojyN021yajBuQQGxprF75Js/s+cjmEUW66w3sZwWLu+LCuCcz7S9k50dYa7vZLmvQen5jET0r18QQW4f+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pPvENMRg; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EBo9lp2048113
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 06:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744631409;
	bh=y5ACmq3Yrzj3X9LtXUICStUphd4BBh7NKKwspPcqHa0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=pPvENMRg+2qi8WZHRAJ+9bEgDdLWUfvZ0fxDdW/IK49AZLeXQf9sU6sL2RdMksh3O
	 bE4SGKB+lR8N43aalUVftuBBtZpujL5kWWuAzHqiEGtvB3lbf2ojRKcsX43+reUKWg
	 aoJMD2UFL8RTaI31oMiK6Dzo8TMVqVao8Tn6BEoE=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EBo9WB010676
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Apr 2025 06:50:09 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 06:50:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 06:50:08 -0500
Received: from [172.24.227.115] (abhilash-hp.dhcp.ti.com [172.24.227.115])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EBo4rA059109;
	Mon, 14 Apr 2025 06:50:05 -0500
Message-ID: <e08b7127-4f9b-433e-b0f3-e2c4ef279b78@ti.com>
Date: Mon, 14 Apr 2025 17:20:04 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] arm64: dts: ti: j721e-sk: Add DT nodes for power
 regulators
To: "Kumar, Udit" <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>, <jai.luthra@linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250409134128.2098195-1-y-abhilashchandra@ti.com>
 <20250409134128.2098195-2-y-abhilashchandra@ti.com>
 <44c3ec3d-2fa3-4a61-8c93-5ef4791fcf8a@ti.com>
Content-Language: en-US
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
In-Reply-To: <44c3ec3d-2fa3-4a61-8c93-5ef4791fcf8a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Udit,

On 11/04/25 19:04, Kumar, Udit wrote:
> 
> On 4/9/2025 7:11 PM, Yemike Abhilash Chandra wrote:
>> Add device tree nodes for two power regulators on the J721E SK board.
>> vsys_5v0: A fixed regulator representing the 5V supply output from the
>> LM61460 and vdd_sd_dv: A GPIO-controlled TLV71033 regulator.
>>
>> J721E-SK schematics: https://www.ti.com/lit/zip/sprr438
>> Fixes: 1bfda92a3a36 ("arm64: dts: ti: Add support for J721E SK")
> 
> For me does not looks like a fix, you can adding missing nodes
> 

Since we are adding the regulator nodes in the sensor overlay, (Patch 4 
of this series) which in turn references these regulator nodes, I have
included the Fixes tag in this patch as well.

> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 31 ++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts 
>> b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>> index 440ef57be294..4965957e6545 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>> @@ -184,6 +184,17 @@ vsys_3v3: fixedregulator-vsys3v3 {
>>           regulator-boot-on;
>>       };
>> +    vsys_5v0: fixedregulator-vsys5v0 {
>> +        /* Output of LM61460 */
>> +        compatible = "regulator-fixed";
>> +        regulator-name = "vsys_5v0";
>> +        regulator-min-microvolt = <5000000>;
>> +        regulator-max-microvolt = <5000000>;
>> +        vin-supply = <&vusb_main>;
>> +        regulator-always-on;
>> +        regulator-boot-on;
>> +    };
>> +
>>       vdd_mmc1: fixedregulator-sd {
>>           compatible = "regulator-fixed";
>>           pinctrl-names = "default";
>> @@ -211,6 +222,20 @@ vdd_sd_dv_alt: gpio-regulator-tps659411 {
>>                <3300000 0x1>;
>>       };
>> +    vdd_sd_dv: gpio-regulator-TLV71033 {
>> +        compatible = "regulator-gpio";
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&vdd_sd_dv_pins_default>;
>> +        regulator-name = "tlv71033";
>> +        regulator-min-microvolt = <1800000>;
>> +        regulator-max-microvolt = <3300000>;
>> +        regulator-boot-on;
>> +        vin-supply = <&vsys_5v0>;
>> +        gpios = <&main_gpio0 118 GPIO_ACTIVE_HIGH>;
>> +        states = <1800000 0x0>,
>> +             <3300000 0x1>;
>> +    };
>> +
>>       transceiver1: can-phy1 {
>>           compatible = "ti,tcan1042";
>>           #phy-cells = <0>;
>> @@ -613,6 +638,12 @@ J721E_WKUP_IOPAD(0xd4, PIN_OUTPUT, 7) /* (G26) 
>> WKUP_GPIO0_9 */
>>           >;
>>       };
>> +    vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
>> +        pinctrl-single,pins = <
>> +            J721E_IOPAD(0x1dc, PIN_INPUT, 7) /* (Y1) 
>> SPI1_CLK.GPIO0_118 */
> 
> Shouldn't be this pin be output to control regulator ?
> 

Yes, I will correct this in the next revision.

Thanks and Regards
Yemike Abhilash Chandra

> 
>> +        >;
>> +    };
>> +
>>       wkup_uart0_pins_default: wkup-uart0-default-pins {
>>           pinctrl-single,pins = <
>>               J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) 
>> WKUP_UART0_RXD */

