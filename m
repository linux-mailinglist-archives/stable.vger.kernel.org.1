Return-Path: <stable+bounces-125581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295EBA694DC
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 17:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB18219C1C5F
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E20D1DE881;
	Wed, 19 Mar 2025 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JWyyAMy2"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651539AD6;
	Wed, 19 Mar 2025 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401571; cv=none; b=iEoD06Mfj866lVhY99HJmBr5N3VtkrkicbIrDMvICQ1VoLjIOTKLbs8HGeM9IypGPeEgOcwDIM3cUgnvlTcoJofkF9JnrlhRfUhc2nGA0D1JCncgoUi4GG4Z+Sd79WA0d6quwafrcIQ5MMgTW3OIInkn/RCGYbmSJVE1UHgw6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401571; c=relaxed/simple;
	bh=JxCmPweMsh0+Rt53TtaclNYAL5gRgU57d1LEoHFDFNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y81CXYfeMd7leBg/RpGtaRKOMnAvsFF8uuOFv7zq5DNaMStEyKgUHaKdLxp+OeptgK3FhocYAYMC71vfOl2hb418YvnEaMC2RnXLi3GJAKIAr+AJgwxU8PDf9NtJf1lFi9FhyP/ibUYrgE0DwNmwxcvSPKvoKhwpslFIy1iTVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JWyyAMy2; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52JGPtap368025
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 11:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742401555;
	bh=8EunOXKbmJ/ARqV7n6jMGBLucBQE7UpQk6Ad1sq5D/k=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JWyyAMy2kcOQt10nu8WW+JzQR2w1LlzSKj6UWBM7lvLFbkuntqZsjLoxi99XXKJmV
	 PLU/nS+3qOnWCXgHXVMLC5qs37atr5OHf1ZZmGtJggMB7AhZv1iS00MEdltECw6UC8
	 jEVNozRquBVBGB9XGrdMfH3kB3hygZLnDDqX015E=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52JGPtRa027485
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Mar 2025 11:25:55 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 11:25:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 11:25:54 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52JGPsKI080092;
	Wed, 19 Mar 2025 11:25:54 -0500
Message-ID: <3be2f0a1-65f9-4aa7-9c0b-1f4fe626be17@ti.com>
Date: Wed, 19 Mar 2025 11:25:54 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch"
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>,
        "josua@solid-run.com" <josua@solid-run.com>
CC: "rabeeh@solid-run.com" <rabeeh@solid-run.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "jon@solid-run.com" <jon@solid-run.com>
References: <20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com>
 <93d7e958-be62-45b3-ba8f-d3e4cf2839bf@ti.com>
 <5c6e447ad9633f969cad7ed6641c8f6cfcc51237.camel@siemens.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <5c6e447ad9633f969cad7ed6641c8f6cfcc51237.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi, Alexander,

On 3/19/25 5:22 AM, Sverdlin, Alexander wrote:
> Hi Judith, Ulf,
> 
> On Wed, 2025-02-05 at 13:39 -0600, Judith Mendez wrote:
>> Hi all,
>>
>> On 1/27/25 2:12 PM, Josua Mayer wrote:
>>> This reverts commit 941a7abd4666912b84ab209396fdb54b0dae685d.
>>>
>>> This commit uses presence of device-tree properties vmmc-supply and
>>> vqmmc-supply for deciding whether to enable a quirk affecting timing of
>>> clock and data.
>>> The intention was to address issues observed with eMMC and SD on AM62
>>> platforms.
>>>
>>> This new quirk is however also enabled for AM64 breaking microSD access
>>> on the SolidRun HimmingBoard-T which is supported in-tree since v6.11,
>>> causing a regression. During boot microSD initialization now fails with
>>> the error below:
>>>
>>> [    2.008520] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
>>> [    2.115348] mmc1: error -110 whilst initialising SD card
>>>
>>> The heuristics for enabling the quirk are clearly not correct as they
>>> break at least one but potentially many existing boards.
>>>
>>> Revert the change and restore original behaviour until a more
>>> appropriate method of selecting the quirk is derived.
>>
>>
>> Somehow I missed these emails, apologies.
>>
>> Thanks for reporting this issue Josua.
>>
>> We do need this patch for am62x devices since it fixes timing issues
>> with a variety of SD cards on those boards, but if there is a
>> regression, too bad, patch had to be reverted.
>>
>> I will look again into how to implement this quirk, I think using the
>> voltage regulator nodes to discover if we need this quirk might not have
>> been a good idea, based on your explanation. I believe I did test the
>> patch on am64x SK and am64x EVM boards and saw no boot issue there,
>> so the issue seems related to the voltage regulator nodes existing in DT
>> (the heuristics for enabling the quirk) as you call it.
>>
>> Again, thanks for reporting, will look into fixing this issue for am62x
>> again soon.
> 
> does it mean, that 14afef2333af
> ("arm64: dts: ti: k3-am62-main: Update otap/itap values") has to be reverted
> as well, for the time being?

So sorry for the delay in response.

Does this fix: ("arm64: dts: ti: k3-am62-main: Update otap/itap values")
cause any issues for you?

The otap/itap fix is actually setting tap settings according to the
device datasheet since they were wrong in the first place.

The values in the datasheet are the optimal tap settings for our
boards based off of bench characterization results. If these values
provide issues for you, please let me know.


Changing topic:

Going back to the reverted patch. What the patch does is that it
tries to switch data launch from the rising clock edge to the
falling clock edge if we find two voltage supplies for SD/SDIO, one
for powering the SD/SDIO and another for IO voltage switch, or for
the case that no voltage supplies exist (eMMC).

(this was based off-of some internal debug that resulted with a
request to unset V1P8_SIGNAL_ENA to fix timing issues)

However, if you had one voltage supply, the patch should not have
affected you at all and I am really confused why you see an issue
downstream with only one voltage supply.

That being said, I have dug up more information on V1P8_SIGNAL_ENA.
If HIGH_SPEED_ENA is set or if V1P8_SIGNAL_ENA is set, these two bits
are OR'd and if any of the two is set, then data launch always happens
on rising clock edge. This should be the case for any of the UHS modes
or > mmc_hs mode for MMC.

If this is true, we should be setting HIGH_SPEED_ENA anyways for UHS
modes and thus this patch should have done nothing in this sense, since
data launch should still be happening on the rising clock edge.

I am still digging up more information to make sure disabling
V1P8_SIGNAL_ENA has no other implications.


~ Judith















