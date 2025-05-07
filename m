Return-Path: <stable+bounces-142000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50380AADA39
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 10:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB973AA2F7
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 08:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999A11DE4CE;
	Wed,  7 May 2025 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fN2iQhvG"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C82672610;
	Wed,  7 May 2025 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746606863; cv=none; b=M9Yw217JAnwifJtAMhRJTLQxE0DQayZosffw/GIIdMOFn30QVc6DjqsQFIewe2UpVGezdLuGYjQxu7hZhewXe3tFQKN3OiNK9LrRC6ELpjnp+Rn6rOv1pC/zD8EyrUZIv8kpyfsFGiA2dnhif/dKCMfXwmuornUeS2NhkS7hUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746606863; c=relaxed/simple;
	bh=0FWqR19wfOftK5g1sJOw3dmhqkvDKk62ALOtseN0Tzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n//QWhmvvzIRF0FLsJx8zVYqaYA093Z41iQPrJWBAEJ16+QFTQLeTTCQXUIysoan0WeTAkAxbKYUaMzaFBdDip12LVlaC24MRgyWryDlGrQayu/5OmYEs/P4Jn8hS313lgbjrCp1i1aNmhM8aPMyNPkN6V21W/gGEh1+Mp6vFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=fN2iQhvG; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5473dDaX032682;
	Wed, 7 May 2025 10:33:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	A6cChK4mVXO0RSZQI0gFGItxCWM0e4VaK27NpIU1GvA=; b=fN2iQhvG8a5fm6y/
	PUmlxMIL5LsXakclNUJXC7NMVqw0GyKIvoGmFz24j0FmPm9KJf7b6hihMDmiLaX/
	wCd2kRxVQb5xiGSWnWzum8y9antqrkUSSOI7xlRQEAduJshB7IrLwVftV9XqG30B
	fLGx6hWYbq2fePmXZwntC5AuVlAsNiIy2GXp0HbX/OY5f+LYGKFxxYgFH2jYbg+m
	1AoE+GrU4aAUs7YhjuSEYTxyHDiZxXAvTNcT+K/D+iz6bWkekvmDDhwb+HJ55FWs
	6XYE2e8L9UflALBq/iwm/HQUxRrNgFoJEU5FfVGVzKiMHjUefgHsSomEd/d6zwx6
	w6LyZg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46dvq45g07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 10:33:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A007640053;
	Wed,  7 May 2025 10:32:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2F09CA23DB2;
	Wed,  7 May 2025 10:31:46 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 10:31:45 +0200
Message-ID: <956c6921-35f1-4238-9e8e-7f335f33d2f3@foss.st.com>
Date: Wed, 7 May 2025 10:31:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/4] Add STM32MP25 SPI NOR support
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
CC: <christophe.kerello@foss.st.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <stable@vger.kernel.org>
References: <20250507-upstream_ospi_v6-v13-0-32290b21419a@foss.st.com>
 <1f7760c6-0fdf-48b0-9c13-85fa5e01cddd@kernel.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <1f7760c6-0fdf-48b0-9c13-85fa5e01cddd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01



On 5/7/25 10:28, Krzysztof Kozlowski wrote:
> On 07/05/2025 09:25, Patrice Chotard wrote:
>> This series adds SPI NOR support for STM32MP25 SoCs from STMicroelectronics.
>>
>> On STM32MP25 SoCs family, an Octo Memory Manager block manages the muxing,
>> the memory area split, the chip select override and the time constraint
>> between its 2 Octo SPI children.
>>
>> Due to these depedencies, this series adds support for:
>>   - Octo Memory Manager driver.
>>   - Octo SPI driver.
>>   - yaml schema for Octo Memory Manager and Octo SPI drivers.
>>
>> The device tree files adds Octo Memory Manager and its 2 associated Octo
>> SPI chidren in stm32mp251.dtsi and adds SPI NOR support in stm32mp257f-ev1
>> board.
>>     
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Changes in v13:
>> - Make firewall prototypes always exposed.
> 
> 
> I do not see any changes here.
> 
> b4 diff suggests this is the same as v11 so I expect the same failures.
Hi Krzysztof,

In this series there is an additional patch vs previous one : "[PATCH v13 1/4] firewall: Always expose firewall prototype"

Patrice


> 
> Best regards,
> Krzysztof

