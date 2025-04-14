Return-Path: <stable+bounces-132441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6724A87F71
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED4B18996CF
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF9629CB36;
	Mon, 14 Apr 2025 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xfUZB7np"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B642989AA;
	Mon, 14 Apr 2025 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630882; cv=none; b=FDGHyqe/vUj3/9kZEl+7qS7rlIgHIaE6T6Y6kaPNgDtDXS1Z3AfeE+1aXWz+b3/Xj81ARfyTrcrMmSilKuR0haDWFwL8VUU5DgUZ8UMQZkKHAk+JnT/VIZjgxijiPQq+f6owZqq8+/lir8fzIefbW5rJBXjUBv+Do898mt9OSr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630882; c=relaxed/simple;
	bh=ChNHziXZOA2FpaIGY9w+vgsO8XllfkcXrxbG4utZ4bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f6QRKNTMH/anK2o+NvWzAipiOcqzw3gQnP9LFSSBX2un6zzA8YGYVvEadJ00BpiQf3/Dp4szm/UETXtieHzW48IuGb8gflNgI8oHAcsYeXr34YcvYchPbIV3UjBkB5fYsLPDfACckViU+4Y0gSb7IjqZEghMcpnfGoF5JMy/GAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xfUZB7np; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EBekXw2046321
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 06:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744630846;
	bh=z2v2YqDM9wvESESnYHXaNZpR11dPLsmv6R7Z15lYtSc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=xfUZB7npYQOpoB54c4TURLLSpjiSlMy8CTSi5P27KH4fLe3UbByHjGqDXcxWveT6W
	 cUClb1Xcl+4td+jDQzvDUzL4rEz70rsnu5gtBYjIp6FjXN5maISUSsHe0UXO5fZusg
	 gvrTGJjo3JO+CEq5C7QbtGbQQpF9FZAvUepIjfRk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EBekMm102049
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Apr 2025 06:40:46 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 06:40:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 06:40:45 -0500
Received: from [172.24.227.115] (abhilash-hp.dhcp.ti.com [172.24.227.115])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EBefOi038625;
	Mon, 14 Apr 2025 06:40:42 -0500
Message-ID: <28fa61b8-15a6-40c6-96b8-268939226a03@ti.com>
Date: Mon, 14 Apr 2025 17:10:41 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] arm64: dts: ti: k3-j721e-sk: Add requiried voltage
 supplies for IMX219
To: "Francis, Neha" <n-francis@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>, <jai.luthra@linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <stable@vger.kernel.org>
References: <20250409134128.2098195-1-y-abhilashchandra@ti.com>
 <20250409134128.2098195-5-y-abhilashchandra@ti.com>
 <16713a1b-1e74-4b08-bd4c-12dc0a9d32df@ti.com>
Content-Language: en-US
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
In-Reply-To: <16713a1b-1e74-4b08-bd4c-12dc0a9d32df@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Neha,

On 11/04/25 19:08, Francis, Neha wrote:
> On 4/9/2025 7:11 PM, Yemike Abhilash Chandra wrote:
>> The device tree overlay for the IMX219 sensor requires three voltage
>> supplies to be defined: VANA (analog), VDIG (digital core), and VDDL
>> (digital I/O). Add the corresponding voltage supply definitions to avoid
>> dtbs_check warnings.
>>
>> Fixes: f767eb918096 ("arm64: dts: ti: k3-j721e-sk: Add overlay for IMX219")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
>> ---
>>   .../dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso  | 33 +++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso b/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso
>> index 4a395d1209c8..4eb3cffab032 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso
> 
> The link to the schematics seems to need updation, would like to see where these
> regulators are mentioned, can't find them in [0] which I assume is the latest link.
> 

Yes, It seems that the link to the schematics has been changed.
I will submit a separate patch to fix that.

While the regulators are not clearly documented in the schematics,
the voltage levels can be observed in the top-right corner of the 
schematics.

However, the required regulators are explicitly described in the device 
tree bindings.
Please refer: ./Documentation/devicetree/bindings/media/i2c/imx219.yaml

Thanks and Regards
Yemike Abhilash Chandra


>> @@ -19,6 +19,33 @@ clk_imx219_fixed: imx219-xclk {
>>   		#clock-cells = <0>;
>>   		clock-frequency = <24000000>;
>>   	};
>> +
>> +	reg_2p8v: regulator-2p8v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "2P8V";
>> +		regulator-min-microvolt = <2800000>;
>> +		regulator-max-microvolt = <2800000>;
>> +		vin-supply = <&vdd_sd_dv>;
>> +		regulator-always-on;
>> +	};
>> +
>> +	reg_1p8v: regulator-1p8v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "1P8V";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		vin-supply = <&vdd_sd_dv>;
>> +		regulator-always-on;
>> +	};
>> +
>> +	reg_1p2v: regulator-1p2v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "1P2V";
>> +		regulator-min-microvolt = <1200000>;
>> +		regulator-max-microvolt = <1200000>;
>> +		vin-supply = <&vdd_sd_dv>;
>> +		regulator-always-on;
>> +	};
>>   };
>>   
>>   &csi_mux {
>> @@ -34,6 +61,9 @@ imx219_0: imx219-0@10 {
>>   		reg = <0x10>;
>>   
>>   		clocks = <&clk_imx219_fixed>;
>> +		VANA-supply = <&reg_2p8v>;
>> +		VDIG-supply = <&reg_1p8v>;
>> +		VDDL-supply = <&reg_1p2v>;
>>   
>>   		port {
>>   			csi2_cam0: endpoint {
>> @@ -55,6 +85,9 @@ imx219_1: imx219-1@10 {
>>   		reg = <0x10>;
>>   
>>   		clocks = <&clk_imx219_fixed>;
>> +		VANA-supply = <&reg_2p8v>;
>> +		VDIG-supply = <&reg_1p8v>;
>> +		VDDL-supply = <&reg_1p2v>;
>>   
>>   		port {
>>   			csi2_cam1: endpoint {
> [0] https://datasheets.raspberrypi.com/camera/camera-module-2-schematics.pdf
> 

