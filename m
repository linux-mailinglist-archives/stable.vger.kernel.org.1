Return-Path: <stable+bounces-125596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EB2A69664
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 18:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D714017BA9E
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65A91EFFA8;
	Wed, 19 Mar 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i12CnLiN"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298E21DE3BF;
	Wed, 19 Mar 2025 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405267; cv=none; b=nqM3uwz2fdAhFcOFqxYUMMiuJSW08/2FrJdjpNz6Z1YFlF/iYB3vVavljP/Y/3ndb2f96qWV+dOSritbthbjio/KzuGszTX7xzB9mlRf+yC3bsZkR5tbKUy78l5F9+aEU/sc/yjZ+j1BK/mGZHrqShMN6phRB5AR0EM6Kjr1O4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405267; c=relaxed/simple;
	bh=b1ehmemObrNSEY3tavCEQgpVqpi0CiCWHTV7wJ1TM7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=npK8UIeFi1j6IZ381IcPn03PahutshngAppQDdp7mLw9vMgOSRh+hKnw+t++PGoC8JsPJQhnZDJesyv1lMHICRpleQeKENn3rKtj6lPxKk4n9GMtsmciYAFFguuD3sHBdL6/xuev4HZ7Zl0jyUc7PjMQUqKWrvB9b67R+mghZ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i12CnLiN; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52JHRX4u2988847
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 12:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742405253;
	bh=+YQ5r1zjhPkBHt5xSY4MTV/x5e+761ppjKpJ10TDTwY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=i12CnLiNl7xj76CoON5mCUyzi/ARerANWj6imIDXhLU1PZ18DtGsPIIonv+YVAq9F
	 Hpdz5yWujaLTnV4oNX2WLOz8ncYqpCYimu3NSwonaYNS/JNvcjO1hSf96b3KiQUGJ7
	 ZeZPC46z5qYs3koa9CI6tEtfysPdgySBP82yBEsA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52JHRXQ7067218
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Mar 2025 12:27:33 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 12:27:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 12:27:32 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52JHRWPI019141;
	Wed, 19 Mar 2025 12:27:32 -0500
Message-ID: <f1601ced-fabb-483d-a91a-cd41e678434b@ti.com>
Date: Wed, 19 Mar 2025 12:27:32 -0500
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
 <3be2f0a1-65f9-4aa7-9c0b-1f4fe626be17@ti.com>
 <a99d2927cc385aaed018b7e5cbf2a0db709918cf.camel@siemens.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <a99d2927cc385aaed018b7e5cbf2a0db709918cf.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Alexander,

On 3/19/25 12:19 PM, Sverdlin, Alexander wrote:
> Hi Judith,
> 
> On Wed, 2025-03-19 at 11:25 -0500, Judith Mendez wrote:
>>>>> This reverts commit 941a7abd4666912b84ab209396fdb54b0dae685d.
>>>>>
>>>>> This commit uses presence of device-tree properties vmmc-supply and
>>>>> vqmmc-supply for deciding whether to enable a quirk affecting timing of
>>>>> clock and data.
>>>>> The intention was to address issues observed with eMMC and SD on AM62
>>>>> platforms.
>>>>>
>>>>> This new quirk is however also enabled for AM64 breaking microSD access
>>>>> on the SolidRun HimmingBoard-T which is supported in-tree since v6.11,
>>>>> causing a regression. During boot microSD initialization now fails with
>>>>> the error below:
>>>>>
>>>>> [    2.008520] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
>>>>> [    2.115348] mmc1: error -110 whilst initialising SD card
>>>>>
>>>>> The heuristics for enabling the quirk are clearly not correct as they
>>>>> break at least one but potentially many existing boards.
>>>>>
>>>>> Revert the change and restore original behaviour until a more
>>>>> appropriate method of selecting the quirk is derived.
>>>>
>>>>
>>>> Somehow I missed these emails, apologies.
>>>>
>>>> Thanks for reporting this issue Josua.
>>>>
>>>> We do need this patch for am62x devices since it fixes timing issues
>>>> with a variety of SD cards on those boards, but if there is a
>>>> regression, too bad, patch had to be reverted.
>>>>
>>>> I will look again into how to implement this quirk, I think using the
>>>> voltage regulator nodes to discover if we need this quirk might not have
>>>> been a good idea, based on your explanation. I believe I did test the
>>>> patch on am64x SK and am64x EVM boards and saw no boot issue there,
>>>> so the issue seems related to the voltage regulator nodes existing in DT
>>>> (the heuristics for enabling the quirk) as you call it.
>>>>
>>>> Again, thanks for reporting, will look into fixing this issue for am62x
>>>> again soon.
>>>
>>> does it mean, that 14afef2333af
>>> ("arm64: dts: ti: k3-am62-main: Update otap/itap values") has to be reverted
>>> as well, for the time being?
>>
>> So sorry for the delay in response.
>>
>> Does this fix: ("arm64: dts: ti: k3-am62-main: Update otap/itap values")
>> cause any issues for you?
>>
>> The otap/itap fix is actually setting tap settings according to the
>> device datasheet since they were wrong in the first place.
>>
>> The values in the datasheet are the optimal tap settings for our
>> boards based off of bench characterization results. If these values
>> provide issues for you, please let me know.
> 
> I've just noticed that 14afef2333af mentioned the reverted 941a7abd4666
> in a way that one may think of it as a dependency:
> ---
>      Now that we have fixed timing issues for am62x [1], lets
>      change the otap/itap values back according to the device
>      datasheet.
>      
>      [1] https://lore.kernel.org/linux-mmc/20240913185403.1339115-1-jm@ti.com/
> ---
> 
> that why I wanted to double check with you. But if you say they are actually
> independent, that's fine for me!
> 

Well actually, the reason why they were not fixed correctly in the first
place is because we had timing issues on am62x devices. Since we had now
"fixed" those timing issues with this patch and some other similar
patches in the host controller driver. I went ahead and fixed the tap
settings as per characterization results.

The current setting are supposed to be the final and best/correct
settings, but again, if you see any obvious issues, please let me know.

~ Judith








