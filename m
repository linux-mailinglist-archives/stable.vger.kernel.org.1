Return-Path: <stable+bounces-69864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8754D95ACFD
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 07:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DAA9281CE4
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 05:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E394655E48;
	Thu, 22 Aug 2024 05:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xg2F1uxQ"
X-Original-To: stable@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2FA770E2;
	Thu, 22 Aug 2024 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724305370; cv=none; b=qwuZA8rjDQkfO7Jkh1IkUzilfCcfL00sPV3+5Z6IZPrx9NIGjhOHd7YzDaHF8y9uNcivIdGepNJTxtcR+vI0ppAYIfZcOzHIH2gPZ7tx3ap2ktmTc3Kd/92lnAh2GtF7rHpqfaFYeKc6vGvxeePucdqv8TP/l3uycTdkRMoa5/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724305370; c=relaxed/simple;
	bh=4ny/AX7pmP8OylgEVpTCTj8KvgTX+1PJ3JWGr2PMteY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AKehwLAfd9vs+FZ2ITYZoChDIAyMIcwKC+3K9lg/j1WCmxPXM15eawymVMiETf1O1PAMilurxYscq3yTESoajs7fKYqMUALp5dkxCsQ17k9TuKJrbIqO6cg1yNAzOjJcmMtTj6YGM7hrHQ+3rp1+Q4bGHlu/KMZGKgiV8BRH6Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Xg2F1uxQ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47M5geCs121532;
	Thu, 22 Aug 2024 00:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724305360;
	bh=R3mFWZN4/uiZw/T38Ef+OCPWTrZeTTqTXEWeaYsyccI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Xg2F1uxQE6hhlxkAP4Dptvk8iSZBmnqzaCUYyr6crHClx7EUv7f6oTB9X9lY8hyrJ
	 ob41Lmei0gW+ftWAscnH9iIHDcEEUi7xz/ii/Ke+2GvLjMamgm9nnATXLf0B8Jpy+h
	 j/VrNFREGhOfucloYvPkT82qhPyLR6iDkRf0vQDQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47M5geUg022713
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 00:42:40 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 00:42:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 00:42:40 -0500
Received: from [172.24.156.139] (ltpw0bk3z4.dhcp.ti.com [172.24.156.139])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47M5ga5m068395;
	Thu, 22 Aug 2024 00:42:37 -0500
Message-ID: <94faa49d-3acc-45c5-aa17-817e3fb31b5b@ti.com>
Date: Thu, 22 Aug 2024 11:12:36 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: k3-r5: Fix error handling when power-up
 failed
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Apurva Nandan
	<a-nandan@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
References: <9f481156-f220-4adf-b3d9-670871351e26@siemens.com>
 <cf1783e3-e378-482d-8cc2-e03dedca1271@ti.com>
 <3c8844db-0712-4727-a54c-0a156b3f9e9c@siemens.com>
 <716d189d-1f62-4fc0-9bb5-6c78967c5cba@ti.com>
 <eaa07d0d-e2fc-49f2-8ee6-c18b5d7b3b5f@siemens.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <eaa07d0d-e2fc-49f2-8ee6-c18b5d7b3b5f@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 22-08-2024 10:57, Jan Kiszka wrote:
> On 22.08.24 07:22, Beleswar Prasad Padhi wrote:
>> On 21-08-2024 23:40, Jan Kiszka wrote:
>>> On 21.08.24 07:30, Beleswar Prasad Padhi wrote:
>>>> On 19-08-2024 20:54, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> By simply bailing out, the driver was violating its rule and internal
>>>> Using device lifecycle managed functions to register the rproc
>>>> (devm_rproc_add()), bailing out with an error code will work.
>>>>
>>>>> assumptions that either both or no rproc should be initialized. E.g.,
>>>>> this could cause the first core to be available but not the second one,
>>>>> leading to crashes on its shutdown later on while trying to dereference
>>>>> that second instance.
>>>>>
>>>>> Fixes: 61f6f68447ab ("remoteproc: k3-r5: Wait for core0 power-up
>>>>> before powering up core1")
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>>     drivers/remoteproc/ti_k3_r5_remoteproc.c | 3 ++-
>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>>>> b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>>>> index 39a47540c590..eb09d2e9b32a 100644
>>>>> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>>>> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>>>> @@ -1332,7 +1332,7 @@ static int k3_r5_cluster_rproc_init(struct
>>>>> platform_device *pdev)
>>>>>                 dev_err(dev,
>>>>>                     "Timed out waiting for %s core to power up!\n",
>>>>>                     rproc->name);
>>>>> -            return ret;
>>>>> +            goto err_powerup;
>>>>>             }
>>>>>         }
>>>>>     @@ -1348,6 +1348,7 @@ static int k3_r5_cluster_rproc_init(struct
>>>>> platform_device *pdev)
>>>>>             }
>>>>>         }
>>>>>     +err_powerup:
>>>>>         rproc_del(rproc);
>>>> Please use devm_rproc_add() to avoid having to do rproc_del() manually
>>>> here.
>>> This is just be the tip of the iceberg. The whole code needs to be
>>> reworked accordingly so that we can drop these goto, not just this one.
>>
>> You are correct. Unfortunately, the organic growth of this driver has
>> resulted in a need to refactor. I plan on doing this and post the
>> refactoring soon. This should be part of the overall refactoring as
>> suggested by Mathieu[2]. But for the immediate problem, your fix does
>> patch things up.. hence:
>>
>> Acked-by: Beleswar Padhi <b-padhi@ti.com>
>>
>> [2]: https://lore.kernel.org/all/Zr4w8Vj0mVo5sBsJ@p14s/
>>
>>> Just look at k3_r5_reserved_mem_init. Your change in [1] was also too
>>> early in this regard, breaking current error handling additionally.
>>
>>
>> Curious, Could you point out how does the change in [1] breaks current
>> error handling?
>>
> Same story: You leave the inner loop of k3_r5_cluster_rproc_init() via
> return without that loop having been converted to support this.


The rproc has been allocated via devm_rproc_alloc[3] before the 
return[4] at k3_r5_cluster_rproc_init. Thus, it is capable of freeing 
the rproc just based on error codes. It was tested.
[3]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/remoteproc/ti_k3_r5_remoteproc.c#n1238
[4]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/remoteproc/ti_k3_r5_remoteproc.c#n1259

>
> Jan
>

