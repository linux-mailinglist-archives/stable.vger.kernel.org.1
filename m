Return-Path: <stable+bounces-69861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F5395ACCE
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 07:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1BE1F22FA6
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 05:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE08364DC;
	Thu, 22 Aug 2024 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RcMgJv83"
X-Original-To: stable@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8F729A5;
	Thu, 22 Aug 2024 05:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724304174; cv=none; b=cPnQcs8GVI9UVjAtS4Jsp41605621SCmxTiNrKoOKav1Be/T0Y58eJSoiO8o8U76dtXdsi3QDgGVquNbszRio2BEWf9tE7qcd+SXm71D7WNDPjl/BhRu0LWQGI2zUnLFs94/kkTcCO3/hyQIHYeNmwvz3Ch9HqikavOHJmuBTu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724304174; c=relaxed/simple;
	bh=wBB8OLwdPMIKI0ZGPMFhPRYD31g6/ZptmagEcO/2VOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pk6E9iqnytzGPY3vmhQTjX27fq/wfaI0E4uGxovmB3LeI/gG6oLt61AQMdmPzx4ovpsKj2VoiRNy2Fa69tMhFD5V/L03+XLAA1u/R/CvYjHk59V5eSSVct5eWlwpC4GxJoNMPPxuBHpa5sQ9cHv3ajSgrAyZ+oVJ0EegkD4WvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RcMgJv83; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47M5MijY063532;
	Thu, 22 Aug 2024 00:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724304164;
	bh=QSzuUgLfVeB4msNs33a4Z+SPmNW8bVs+3RUbVH6JXdM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RcMgJv83CpAXVBkoQOQVV1f95TY9XmqpWzY5QLQfAZ187skvTiyViJs8BN8CM3orc
	 +0DdMhZnxHk0EEVSGNyxUKjXcbHQlL5vU0DQwXj4JwuZen5to3gmcxfFtStf2dG762
	 DjSI6+FsBm6tCG/70wbZ+fk2gjGw2xm+O2I7QQME=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47M5Miv6060514
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 00:22:44 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 00:22:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 00:22:44 -0500
Received: from [172.24.156.139] (ltpw0bk3z4.dhcp.ti.com [172.24.156.139])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47M5Me4M027111;
	Thu, 22 Aug 2024 00:22:41 -0500
Message-ID: <716d189d-1f62-4fc0-9bb5-6c78967c5cba@ti.com>
Date: Thu, 22 Aug 2024 10:52:40 +0530
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
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <3c8844db-0712-4727-a54c-0a156b3f9e9c@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 21-08-2024 23:40, Jan Kiszka wrote:
> On 21.08.24 07:30, Beleswar Prasad Padhi wrote:
>> On 19-08-2024 20:54, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> By simply bailing out, the driver was violating its rule and internal
>>
>> Using device lifecycle managed functions to register the rproc
>> (devm_rproc_add()), bailing out with an error code will work.
>>
>>> assumptions that either both or no rproc should be initialized. E.g.,
>>> this could cause the first core to be available but not the second one,
>>> leading to crashes on its shutdown later on while trying to dereference
>>> that second instance.
>>>
>>> Fixes: 61f6f68447ab ("remoteproc: k3-r5: Wait for core0 power-up
>>> before powering up core1")
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>    drivers/remoteproc/ti_k3_r5_remoteproc.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>> b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>> index 39a47540c590..eb09d2e9b32a 100644
>>> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>> @@ -1332,7 +1332,7 @@ static int k3_r5_cluster_rproc_init(struct
>>> platform_device *pdev)
>>>                dev_err(dev,
>>>                    "Timed out waiting for %s core to power up!\n",
>>>                    rproc->name);
>>> -            return ret;
>>> +            goto err_powerup;
>>>            }
>>>        }
>>>    @@ -1348,6 +1348,7 @@ static int k3_r5_cluster_rproc_init(struct
>>> platform_device *pdev)
>>>            }
>>>        }
>>>    +err_powerup:
>>>        rproc_del(rproc);
>>
>> Please use devm_rproc_add() to avoid having to do rproc_del() manually
>> here.
> This is just be the tip of the iceberg. The whole code needs to be
> reworked accordingly so that we can drop these goto, not just this one.


You are correct. Unfortunately, the organic growth of this driver has 
resulted in a need to refactor. I plan on doing this and post the 
refactoring soon. This should be part of the overall refactoring as 
suggested by Mathieu[2]. But for the immediate problem, your fix does 
patch things up.. hence:

Acked-by: Beleswar Padhi <b-padhi@ti.com>

[2]: https://lore.kernel.org/all/Zr4w8Vj0mVo5sBsJ@p14s/

> Just look at k3_r5_reserved_mem_init. Your change in [1] was also too
> early in this regard, breaking current error handling additionally.



Curious, Could you point out how does the change in [1] breaks current 
error handling?

>
> I'll stop my whac-a-mole. Someone needs to sit down and do that for the
> complete code consistently. And test the error cases.
>
> Jan
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=f3f11cfe890733373ddbb1ce8991ccd4ee5e79e1
>
>>>    err_add:
>>>        k3_r5_reserved_mem_exit(kproc);

