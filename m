Return-Path: <stable+bounces-166698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644C0B1C612
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 14:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDDB72140C
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 12:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DFE28C01D;
	Wed,  6 Aug 2025 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ALOz9sx/"
X-Original-To: stable@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60178274FFE;
	Wed,  6 Aug 2025 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483949; cv=none; b=dIgQC2oBQ9GeqXDZyjz4NRO1Coo+rnFIZGHfpqE/LLuvEJYQpXkSBkUMGLQJ9vJM9SwT6AxPBYgGVaytl4cXuz0ZESLHpFw3DEf3sHJRgsTBjHTD2J0UdNo9d3oDvq3sXLeAEME3XWCrr8D7kWEfrXqYjOQvuA7xbf3DYFl+Fq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483949; c=relaxed/simple;
	bh=vrLWGOXRH2r0hNZhUQBXvjB68J36/G9jl4obAQfpRLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LIRcM/2kBOfCSjxBh6L19YkpJANS7F9alHRC4JetXsP3hrPk0FoBQ3axMqnSmnTXETE1bfNuikyhWml25OARhs5jqJi7NP5GnNsOmmyYZaG6IBwKXgihF70YsE+NkCzYaQ5KUWfqIr9Vs9ABldTR4QbOj5zoeG8Qswux5BIpl3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ALOz9sx/; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576CC3qH008508;
	Wed, 6 Aug 2025 14:38:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	+9IsvCzYMDK0gCqL2cCxHQLQ+DlESL1F/sd9l2UbGxI=; b=ALOz9sx/aoS4LcZj
	Jv6BgZX6lM2lEyEM4mykxHVI7EkOCuKkdL9NWek0jfa+QN+KWCJNMlB54vR/4CU2
	gv34OkICK/Oo1dSWTnHLsJiCnrI0/sTov+Gaf4Rgx258D4b4Cfq+l4pwbEgSHmS0
	3pKHOlRdQiUVccAq8hybkfFn66waaXm8aEryafELGWtxmhoYHjvPLeF5rnoHOG0Q
	zPTxxGmVt2ItBW1MJVSUjnbRAwIhL3/QbPBxkkfrZg3WnrPIGMLUVwpAMuA5CIJE
	EGJXiv+vEvyR+aJvmeC0Yl98+Hy6L0uqn2uJGcH5ri8TgPHtAJPJvrfu37jpN6qD
	gVXYiQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48bpx63ddb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 14:38:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CFECC40050;
	Wed,  6 Aug 2025 14:37:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C83B2718A8F;
	Wed,  6 Aug 2025 14:36:56 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 14:36:56 +0200
Message-ID: <832fb088-8862-4bd7-82a4-0e7ad58efe76@foss.st.com>
Date: Wed, 6 Aug 2025 14:36:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: st: Add memory-region-names property for
 stm32mp257f-ev1
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250806-upstream_fix_dts_omm-v1-1-e68c15ed422d@foss.st.com>
 <9e0c5453-b8f4-4d0a-8e8d-82014aac67dd@kernel.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <9e0c5453-b8f4-4d0a-8e8d-82014aac67dd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01



On 8/6/25 10:23, Krzysztof Kozlowski wrote:
> On 06/08/2025 10:09, Patrice Chotard wrote:
>> Add memory-region-names property for stm32mp257f-ev1.
>> This allows to identify and check memory-map area's configuration.
> 
> No, first entry is already identified.

ok

> 
>>
>> Cc: stable@vger.kernel.org
>> Fixes: cad2492de91c ("arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board")
>>
> 
> No blank lines.

ok
> 
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>  arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
>> index 2f561ad4066544445e93db78557bc4be1c27095a..16309029758cf24834f406f5203046ded371a8f9 100644
>> --- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
>> +++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
>> @@ -197,6 +197,7 @@ &i2c8 {
>>  
>>  &ommanager {
>>  	memory-region = <&mm_ospi1>;
>> +	memory-region-names = "mm_ospi1";
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see

My bad, i am preparing the v2.

Thanks

> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> Maybe you need to update your dtschema and yamllint. Don't rely on
> distro packages for dtschema and be sure you are using the latest
> released dtschema.
> 
> Best regards,
> Krzysztof

