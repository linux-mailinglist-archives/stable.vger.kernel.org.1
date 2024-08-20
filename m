Return-Path: <stable+bounces-69734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45F2958AE7
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 17:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3B0282CBC
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80231922E0;
	Tue, 20 Aug 2024 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y0gU7KF0"
X-Original-To: stable@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10482190473;
	Tue, 20 Aug 2024 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166970; cv=none; b=S5Qy5M6P+FTjDrDaTl01Cb09UAIN7LKGtLCUFHhKGt6LFqqV1NGQN2N4Qh7VXOUFYE/rFAhS7yevJsMjln0QE/ko9uQ12A7B11+wTAJBOJWu7fyI6dk3L9TfAHdYfl1kgcK2Aj/cdOJPE5aRAMIF14PAY8pnSO7ZUdZ9odFvdrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166970; c=relaxed/simple;
	bh=2htDYgQvswGaU/wI5VetYbAFBjE4OAfABWe3crGFcQk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=bzfKgD876yklxMn3eUk7dyB/v7eeZRO9T7UkHQkoe84dS3r5WwgtR9cHxxhmi4qrg8AtSQaZQUQwjvvChsO/VtaVRG30SW4JXBSYDf9OfyhaLKeCtdz7f7OWe12fBnRbKSoi2zR9gwCagsiKI0JERChq4ZnixFpOPKjjAziP7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y0gU7KF0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47KFG2Bv012791;
	Tue, 20 Aug 2024 10:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724166962;
	bh=o0ex5f/T4fe5xibAfgsBjL2cdHLLg0oekkZAeaRrtYw=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=y0gU7KF0O8ubQ8gGeAOeqEbUEMr6J17SCWOSuBXoKbeVV462pZ0yW+mI7szU2fLO3
	 AX4eQe9yTxJyyad5qiUQ8txtk8XXIjGv1GcNQy4cxrWX9XDPEPS+Ax8NusJh0mLjBA
	 vw4bQpqISIYjv683zgM4xJX2Kgnyd9qehm1nntBI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47KFG2NR047072
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 10:16:02 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 10:16:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 10:16:02 -0500
Received: from [10.249.130.61] ([10.249.130.61])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47KFFwnx027038;
	Tue, 20 Aug 2024 10:15:59 -0500
Message-ID: <3274bdec-e9a3-4c2d-ba8e-58caa033d451@ti.com>
Date: Tue, 20 Aug 2024 20:45:57 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: k3-r5: Fix driver shutdown
From: Beleswar Prasad Padhi <b-padhi@ti.com>
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
References: <bf2bd3df-902f-4cef-91fc-2e6438539a01@siemens.com>
 <3e6075a6-20a9-42ee-8f10-377ba9b0291b@ti.com>
 <9ce9044c-085f-4eff-b142-ab36d39d90b4@siemens.com>
 <2bdd6000-82b4-4f57-a950-e9378c321154@ti.com>
 <7ffe0f80-d4a2-4d6f-8c45-5a407ac2e584@siemens.com>
 <be50e40e-ece6-4784-83f3-031a750d5e79@ti.com>
Content-Language: en-US
In-Reply-To: <be50e40e-ece6-4784-83f3-031a750d5e79@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 20-08-2024 20:29, Beleswar Prasad Padhi wrote:
>
> On 20-08-2024 19:50, Jan Kiszka wrote:
>> On 20.08.24 11:48, Beleswar Prasad Padhi wrote:
>>> On 20-08-2024 15:09, Jan Kiszka wrote:
>>>> On 20.08.24 11:30, Beleswar Prasad Padhi wrote:
>>>>> Hi Jan,
>>>>>
>>>>> On 19-08-2024 22:17, Jan Kiszka wrote:
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> When k3_r5_cluster_rproc_exit is run, core 1 is shutdown and removed
>>>>>> first. When core 0 should then be stopped before its removal, it 
>>>>>> will
>>>>>> find core1->rproc as NULL already and crashes. Happens on rmmod e.g.
>>>>> Did you check this on top of -next-20240820 tag? There was a 
>>>>> series[0]
>>>>> which was merged recently which fixed this condition. I don't see 
>>>>> this
>>>>> issue when trying on top of -next-20240820 tag.
>>>>> [0]:
>>>>> https://lore.kernel.org/all/20240808074127.2688131-1-b-padhi@ti.com/
>>>>>
>>>> I didn't try those yet, I was on 6.11-rcX. But from reading them
>>>> quickly, I'm not seeing the two issues I found directly addressed 
>>>> there.
>>> Check the comment by Andrew Davis[0], that addresses the above issue.
>>>
>>> [0]:
>>> https://lore.kernel.org/all/0bba5293-a55d-4f13-887c-272a54d6e1ca@ti.com/ 
>>>
>>>
>> OK, then someone still needs to update his patch accordingly.
> That comment was addressed in the v4 series revision[1] and was merged 
> to linux-next, available with tag -next-20240820. Request you to 
> please check if the issue persists with -next-20240820 tag. I checked 
> myself, and was not able to reproduce.
> [1]: https://lore.kernel.org/all/Zr9nbWnADDB+ZOlg@p14s/
>>
>>>>>> Fixes: 3c8a9066d584 ("remoteproc: k3-r5: Do not allow core1 to power
>>>>>> up before core0 via sysfs")
>>>>>> CC: stable@vger.kernel.org
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> ---
>>>>>>
>>>>>> There might be one more because I can still make this driver crash
>>>>>> after an operator error. Were error scenarios tested at all?
>>>>> Can you point out what is this issue more specifically, and I can 
>>>>> take
>>>>> this up then.
>>>> Try starting core1 before core0, and then again - system will hang or
>>> If you are trying to stop and then start the cores from sysfs, that is
>>> not yet supported. The hang is thus expected.
>> What? Then the driver is broken, even more. Why wasn't it fully 
>> implemented?


Just wanted to point out that this "graceful shutdown" feature is 
majorly dependent on the Device Manager Firmware(point 3) and minimal 
changes to the remoteproc driver (point 2 and 4). Thus, as soon as 
Firmware is capable, we will send out the patches for this feature.

> The driver is capable of starting a core and stopping it all well. The 
> problem is, when we stop a core from sysfs (without resetting the SoC 
> itself), the remotecore is powered off, but its resources are not 
> relinquished. So when we start it back, there could be some memory 
> corruptions. This feature of "graceful shutdown" of remotecores is 
> almost implemented and will be posted to this driver soon. Request you 
> to try out after that.
>
> With graceful shutdown feature, this will be the flow:
> 1. We issue a core stop operation from sysfs.
> 2. The remoteproc driver sends a special "SHUTDOWN" mailbox message to 
> the remotecore.
> 3. The remotecore relinquishes all of its acquired resources through 
> Device Manager Firmware and sends an ACK back.
> 4. The remotecore enters WFI state and then is resetted through Host 
> core.
> 5. Then, if we try to do the core start operation from sysfs, core 
> should be up as expected.
>
> Thanks,
> Beleswar
>>
>> Jan
>>

