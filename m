Return-Path: <stable+bounces-125594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF122A695E7
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 18:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814E217FBBC
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928FE1EF371;
	Wed, 19 Mar 2025 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qsbKM2nz"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2F1B4138;
	Wed, 19 Mar 2025 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404041; cv=none; b=nCME9Lpx3O4pGT4Jjr45bKV0V9MUWgU/n/OtalAqMqbF0Ot7HV0/zEtALKKRft3VVXxrJmzodBWNxk79eqeiHST6pZXOkE62XLmPky8tFWq+srosG1mzKGMHArnuZIM3sNH0uv4UCVKrA7tP/CFwTqELjCM+24AwNvFMcydCXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404041; c=relaxed/simple;
	bh=niyYTGDmpTPxcpRG6NKEaQYm6APr+GhvRE14BZy7+c0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=kOYm2iRzy3JbaELBb+p+2KDw23A3OLNJV+jfQ7Op6eQoJaLWcfatJAG0mTCRsqEcweny8ITMzoCzaqtUoXNNG0FSATwWbb6Cqw1upic2ZKHENgrD4ozBF+kG7t+6StqudGBnqfaCwSgiDu6cj127elKyJtqL21Zy9ur6LYTSPZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qsbKM2nz; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52JH72L52985222
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 12:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742404022;
	bh=lI5UQx2IS3qM/+aBZXzoJwCNluD7HLRBssCGs/gwBWQ=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=qsbKM2nzHfrQrlRa9n/BXMiU/wx+6ujjNrqYDNK8Drs/YWhzMoZ/+qVx1wB4Sg7He
	 Yof8fq355RXza0boyc6k5F0lPnWVC2+MSRKAQ5sRCMAAcyeK643nbWGvFJG+glzieE
	 V8dLSW+iIVeb8UYTqlc6MrczAMnO/uhkILtO5BVc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52JH72QB047664
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Mar 2025 12:07:02 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 12:07:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 12:07:01 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52JH71I8093411;
	Wed, 19 Mar 2025 12:07:01 -0500
Message-ID: <5cd9da69-95f1-4cf0-b6ee-cffcf984a390@ti.com>
Date: Wed, 19 Mar 2025 12:07:01 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch"
From: Judith Mendez <jm@ti.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
        "josua@solid-run.com" <josua@solid-run.com>
CC: "rabeeh@solid-run.com" <rabeeh@solid-run.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>
References: <20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com>
 <93d7e958-be62-45b3-ba8f-d3e4cf2839bf@ti.com>
 <5c6e447ad9633f969cad7ed6641c8f6cfcc51237.camel@siemens.com>
 <3be2f0a1-65f9-4aa7-9c0b-1f4fe626be17@ti.com>
Content-Language: en-US
In-Reply-To: <3be2f0a1-65f9-4aa7-9c0b-1f4fe626be17@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi, Alexander, Joshua,


Let me correct who I direct my questions/responses for.

On 3/19/25 11:25 AM, Judith Mendez wrote:
> Hi, Alexander,
> 
> On 3/19/25 5:22 AM, Sverdlin, Alexander wrote:
>> Hi Judith, Ulf,
>>
>> On Wed, 2025-02-05 at 13:39 -0600, Judith Mendez wrote:
>>> Hi all,
>>>
>>> On 1/27/25 2:12 PM, Josua Mayer wrote:
>>>> This reverts commit 941a7abd4666912b84ab209396fdb54b0dae685d.
>>>>
>>>> This commit uses presence of device-tree properties vmmc-supply and
>>>> vqmmc-supply for deciding whether to enable a quirk affecting timing of
>>>> clock and data.
>>>> The intention was to address issues observed with eMMC and SD on AM62
>>>> platforms.
>>>>
>>>> This new quirk is however also enabled for AM64 breaking microSD access
>>>> on the SolidRun HimmingBoard-T which is supported in-tree since v6.11,
>>>> causing a regression. During boot microSD initialization now fails with
>>>> the error below:
>>>>
>>>> [    2.008520] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] 
>>>> using ADMA 64-bit
>>>> [    2.115348] mmc1: error -110 whilst initialising SD card
>>>>
>>>> The heuristics for enabling the quirk are clearly not correct as they
>>>> break at least one but potentially many existing boards.
>>>>
>>>> Revert the change and restore original behaviour until a more
>>>> appropriate method of selecting the quirk is derived.
>>>
>>>
>>> Somehow I missed these emails, apologies.
>>>
>>> Thanks for reporting this issue Josua.
>>>
>>> We do need this patch for am62x devices since it fixes timing issues
>>> with a variety of SD cards on those boards, but if there is a
>>> regression, too bad, patch had to be reverted.
>>>
>>> I will look again into how to implement this quirk, I think using the
>>> voltage regulator nodes to discover if we need this quirk might not have
>>> been a good idea, based on your explanation. I believe I did test the
>>> patch on am64x SK and am64x EVM boards and saw no boot issue there,
>>> so the issue seems related to the voltage regulator nodes existing in DT
>>> (the heuristics for enabling the quirk) as you call it.
>>>
>>> Again, thanks for reporting, will look into fixing this issue for am62x
>>> again soon.
>>
>> does it mean, that 14afef2333af
>> ("arm64: dts: ti: k3-am62-main: Update otap/itap values") has to be 
>> reverted
>> as well, for the time being?
> 
> So sorry for the delay in response.
> 
> Does this fix: ("arm64: dts: ti: k3-am62-main: Update otap/itap values")
> cause any issues for you?
> 
> The otap/itap fix is actually setting tap settings according to the
> device datasheet since they were wrong in the first place.
> 
> The values in the datasheet are the optimal tap settings for our
> boards based off of bench characterization results. If these values
> provide issues for you, please let me know.

This first part is for Alexander.

> 
> 
> Changing topic:
> 
> Going back to the reverted patch. What the patch does is that it
> tries to switch data launch from the rising clock edge to the
> falling clock edge if we find two voltage supplies for SD/SDIO, one
> for powering the SD/SDIO and another for IO voltage switch, or for
> the case that no voltage supplies exist (eMMC).
> 
> (this was based off-of some internal debug that resulted with a
> request to unset V1P8_SIGNAL_ENA to fix timing issues)
> 
> However, if you had one voltage supply, the patch should not have
> affected you at all and I am really confused why you see an issue
> downstream with only one voltage supply.
> 
> That being said, I have dug up more information on V1P8_SIGNAL_ENA.
> If HIGH_SPEED_ENA is set or if V1P8_SIGNAL_ENA is set, these two bits
> are OR'd and if any of the two is set, then data launch always happens
> on rising clock edge. This should be the case for any of the UHS modes
> or > mmc_hs mode for MMC.
> 
> If this is true, we should be setting HIGH_SPEED_ENA anyways for UHS
> modes and thus this patch should have done nothing in this sense, since
> data launch should still be happening on the rising clock edge.
> 
> I am still digging up more information to make sure disabling
> V1P8_SIGNAL_ENA has no other implications.
> 

This second part is to Joshua.

> 
> ~ Judith
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 


