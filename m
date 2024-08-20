Return-Path: <stable+bounces-69729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 707CF958A95
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 17:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193071F23CA2
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4CA193099;
	Tue, 20 Aug 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hlvA53FU"
X-Original-To: stable@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3307818E77E;
	Tue, 20 Aug 2024 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166017; cv=none; b=iES9atjCoYMK/Vzw4mAYvtMNJx9wPjPx0VuLysJ2tUexlkNMxgd+YIHPWdQVwBiTfKPKBexi2QxI48b+d16720CO6QLHCEuFbwn7wZrASl4fZpz63DA5h5zTjA47G2dY2+wPL2QW8HJbyA3X9EKvnRJMUvTe2lTYm7cPV60Hd94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166017; c=relaxed/simple;
	bh=8EZN24Lm7g644Rkwodi4QheuVuQSuzPTOWj6wHcEhcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JW7eowvv5/PkWAmKlaL4OP76gyl6f4EO1UbxN0oTwOvUKAMK2g/nL82xI0orGltVB5aJ0Texmuk4PIlXMs0C4Izsx4E/FeJ0GKa5BgbcqKJn/Y016jh4tZzlh0EcZCyupZ7nuvm+7aE5NPdeIIB5qm8XEgWO+li05U49TBEACeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hlvA53FU; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47KF06LZ045515;
	Tue, 20 Aug 2024 10:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724166006;
	bh=iQpuEYOXZsNRQndfMMivcdZKRLDjv3w0A/rsZz8zjNc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hlvA53FUvYotkRMn5ZPIWJPdL/9wo9TE+L658jkIifRR1WhofXqY2uSL6W0nzVB/2
	 bEWi0sIXjeUsgBZ6MMJ+OYIDtw0Abq2vBmJE3pmDfQuzTN/HS2/EmM2DbFYT/d/ho3
	 ff/tj+gr2SzG0/MRIvajpE9gzGMuSHLRIRfmiNdY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47KF02xx004395
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 10:00:06 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 10:00:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 10:00:04 -0500
Received: from [10.249.130.61] ([10.249.130.61])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47KExxhE003600;
	Tue, 20 Aug 2024 10:00:01 -0500
Message-ID: <be50e40e-ece6-4784-83f3-031a750d5e79@ti.com>
Date: Tue, 20 Aug 2024 20:29:58 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: k3-r5: Fix driver shutdown
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
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <7ffe0f80-d4a2-4d6f-8c45-5a407ac2e584@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 20-08-2024 19:50, Jan Kiszka wrote:
> On 20.08.24 11:48, Beleswar Prasad Padhi wrote:
>> On 20-08-2024 15:09, Jan Kiszka wrote:
>>> On 20.08.24 11:30, Beleswar Prasad Padhi wrote:
>>>> Hi Jan,
>>>>
>>>> On 19-08-2024 22:17, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> When k3_r5_cluster_rproc_exit is run, core 1 is shutdown and removed
>>>>> first. When core 0 should then be stopped before its removal, it will
>>>>> find core1->rproc as NULL already and crashes. Happens on rmmod e.g.
>>>> Did you check this on top of -next-20240820 tag? There was a series[0]
>>>> which was merged recently which fixed this condition. I don't see this
>>>> issue when trying on top of -next-20240820 tag.
>>>> [0]:
>>>> https://lore.kernel.org/all/20240808074127.2688131-1-b-padhi@ti.com/
>>>>
>>> I didn't try those yet, I was on 6.11-rcX. But from reading them
>>> quickly, I'm not seeing the two issues I found directly addressed there.
>> Check the comment by Andrew Davis[0], that addresses the above issue.
>>
>> [0]:
>> https://lore.kernel.org/all/0bba5293-a55d-4f13-887c-272a54d6e1ca@ti.com/
>>
> OK, then someone still needs to update his patch accordingly.
That comment was addressed in the v4 series revision[1] and was merged 
to linux-next, available with tag -next-20240820. Request you to please 
check if the issue persists with -next-20240820 tag. I checked myself, 
and was not able to reproduce.
[1]: https://lore.kernel.org/all/Zr9nbWnADDB+ZOlg@p14s/
>
>>>>> Fixes: 3c8a9066d584 ("remoteproc: k3-r5: Do not allow core1 to power
>>>>> up before core0 via sysfs")
>>>>> CC: stable@vger.kernel.org
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>>
>>>>> There might be one more because I can still make this driver crash
>>>>> after an operator error. Were error scenarios tested at all?
>>>> Can you point out what is this issue more specifically, and I can take
>>>> this up then.
>>> Try starting core1 before core0, and then again - system will hang or
>> If you are trying to stop and then start the cores from sysfs, that is
>> not yet supported. The hang is thus expected.
> What? Then the driver is broken, even more. Why wasn't it fully implemented?
The driver is capable of starting a core and stopping it all well. The 
problem is, when we stop a core from sysfs (without resetting the SoC 
itself), the remotecore is powered off, but its resources are not 
relinquished. So when we start it back, there could be some memory 
corruptions. This feature of "graceful shutdown" of remotecores is 
almost implemented and will be posted to this driver soon. Request you 
to try out after that.

With graceful shutdown feature, this will be the flow:
1. We issue a core stop operation from sysfs.
2. The remoteproc driver sends a special "SHUTDOWN" mailbox message to 
the remotecore.
3. The remotecore relinquishes all of its acquired resources through 
Device Manager Firmware and sends an ACK back.
4. The remotecore enters WFI state and then is resetted through Host core.
5. Then, if we try to do the core start operation from sysfs, core 
should be up as expected.

Thanks,
Beleswar
>
> Jan
>

