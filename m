Return-Path: <stable+bounces-166771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FCBB1D6F5
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 13:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DD6188ECAA
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 11:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043E9224B0C;
	Thu,  7 Aug 2025 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1eupmTda"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D040BA36;
	Thu,  7 Aug 2025 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567483; cv=none; b=ppQeHVAnNj94Cs02fte10ushhqjCVw+5xPHQJXMQ+WLwo8yn+r/B+Z6uhCOf/C61cuW6p+0xb90+nPvXduQGNi6YvjJ0nslYLJchTCQtnUmLtcSqpbmOSCqzwoXfoCyN7+XdYnu5YwDE+WWfE2rIXetbNxg4MhNGsLw2LyyC70c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567483; c=relaxed/simple;
	bh=8MgaTvrpwz18SmhD8CDTyOO+VJ8bJqJdwJBStqX61eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WialkbnU4tCb4eq2Fi2obsmMoSRoHybddBSG52Vuo2N8iaDLMxVn9i7JkxD1NPVMuAEL8nagTpKRkC/vwlEQSh7+D85WYPyCGDEgYFwabGygeoYSQGWfdcJHVZpnot7kAbKfMZPLZ7GT6huxR7Pl5NXB4no1oygBKccoZOawhUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1eupmTda; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577BcO0H029331;
	Thu, 7 Aug 2025 13:51:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	HVsSu2JQlkuMay902nxoX0MpAL4pe0AraHz4EjlfA/4=; b=1eupmTdait8w75Di
	rmc14oVpRPxnbd94Q+JTpKhZInez4rF4BakuCzwkhYQ5xJrv0nphT8jusphCOV99
	d+FC8Ki805e4PM2bbnIV5nDXr9mkd+pBtznEMX/g7+2H2nbT62V8neuAfek4X5lk
	9K7QxqiGZJU2GaMlbYlrb9fOBiqLMFVFyZBYGthQhpCzzDKq6geeCWOwHMBP1usD
	Mp5mq4H8OvsiOeK4QqEaH2x+9FTMkMS56NH9PfVAvDgJV0bbIfSW+0gdiHXZMeDS
	50nmE+6JxsyyT8OX8dUksu7zFsmsqDEwMhaXt57+O9/2sAj4nA6HvtKQjq6oL/3r
	9zqW8w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48c7pvuxqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:51:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 48F9D4004A;
	Thu,  7 Aug 2025 13:50:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 769D671FDA0;
	Thu,  7 Aug 2025 13:49:30 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 13:49:29 +0200
Message-ID: <48d20fc0-3212-499f-881f-9546607b250d@foss.st.com>
Date: Thu, 7 Aug 2025 13:49:29 +0200
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
 <832fb088-8862-4bd7-82a4-0e7ad58efe76@foss.st.com>
 <5924a691-2533-4856-a169-d16c3e577c42@kernel.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <5924a691-2533-4856-a169-d16c3e577c42@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01



On 8/6/25 14:44, Krzysztof Kozlowski wrote:
> On 06/08/2025 14:36, Patrice CHOTARD wrote:
>>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>>> ---
>>>>  arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
>>>> index 2f561ad4066544445e93db78557bc4be1c27095a..16309029758cf24834f406f5203046ded371a8f9 100644
>>>> --- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
>>>> +++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
>>>> @@ -197,6 +197,7 @@ &i2c8 {
>>>>  
>>>>  &ommanager {
>>>>  	memory-region = <&mm_ospi1>;
>>>> +	memory-region-names = "mm_ospi1";
>>>
>>> It does not look like you tested the DTS against bindings. Please run
>>> `make dtbs_check W=1` (see
>>
>> My bad, i am preparing the v2.
> Why? I claim this is not needed according to your description. You said
> it is necessary to identify "memory-map area's configuration." but
> memory-region already tells that. What exactly is not identified?

Sorry but memory-region doesn't tell if this area is dedicated to ospi1 or ospi2.

In order to set the AMCR register, which configure the memory-region split
between ospi1 and ospi2, we need to identify the ospi instance.

By using memory-region-names, it allows to identify the ospi instance it belongs to.

Thanks
Patrice

> 
> Best regards,
> Krzysztof

