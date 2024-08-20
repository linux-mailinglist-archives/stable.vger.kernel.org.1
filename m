Return-Path: <stable+bounces-69704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3051E958327
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 11:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533051C2129D
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A50B18991B;
	Tue, 20 Aug 2024 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fYU197p7"
X-Original-To: stable@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230818E364;
	Tue, 20 Aug 2024 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147345; cv=none; b=JEyQ5iK0O4EcJQNiFdamD0Zj0DjM+OQtjJFDgtB4Jz9ta1y9390y43M5lW5RWEijhDqDv+Qgm548GejloVT/xN4UKWVsa14d6wL0oujLbhL1ZFkLa6CYoSFo/39dZ2D1CNbZx9QeIrFry76JlfOkt0c5vR+zm9Q4UWaWI2l/FIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147345; c=relaxed/simple;
	bh=0Afnu0lXJbWwYcmzr7+pFu18fh2L9F4Wjrof18i0YJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W7F5LVzu9t55fMKY5FyMcvWNp3nStkkhCorlINMM8RycI3/H/6kBohj9Q8EcYwX6RhkXYb8UM0+vcVfivbutaBSy5dfwwsZXL2K8pgYrrCiZBK3BlpVxZfTXOFx/s1USdHnHTkeE824SF9ldufeCmRZROHHkQXTBTxbeoAlom9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fYU197p7; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47K9mkKV088846;
	Tue, 20 Aug 2024 04:48:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724147326;
	bh=r8VtDvLN2uM74ukoKWT0T4JrYuAnvjprLETXofO/ufg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=fYU197p7WTGvZKXxXtmZGGErEgT6GpgSIXh0/urMNYLv+q9U55XQUs0TuOVcXRS9x
	 c85WFwIV1YD5NsavkXWrrALXlHsLZ1uyEBUpScshhiOgpg9HLEX8/olBef+yeLjJ8P
	 ZEAc+obl196RcfFwPzpnEjzF2FHzhjas2Jf2VflE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47K9mkn3121572
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 04:48:46 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 04:48:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 04:48:46 -0500
Received: from [172.24.218.186] (ltpw0bk3z4.dhcp.ti.com [172.24.218.186])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47K9mgNC056230;
	Tue, 20 Aug 2024 04:48:43 -0500
Message-ID: <2bdd6000-82b4-4f57-a950-e9378c321154@ti.com>
Date: Tue, 20 Aug 2024 15:18:42 +0530
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
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <9ce9044c-085f-4eff-b142-ab36d39d90b4@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 20-08-2024 15:09, Jan Kiszka wrote:
> On 20.08.24 11:30, Beleswar Prasad Padhi wrote:
>> Hi Jan,
>>
>> On 19-08-2024 22:17, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> When k3_r5_cluster_rproc_exit is run, core 1 is shutdown and removed
>>> first. When core 0 should then be stopped before its removal, it will
>>> find core1->rproc as NULL already and crashes. Happens on rmmod e.g.
>>
>> Did you check this on top of -next-20240820 tag? There was a series[0]
>> which was merged recently which fixed this condition. I don't see this
>> issue when trying on top of -next-20240820 tag.
>> [0]: https://lore.kernel.org/all/20240808074127.2688131-1-b-padhi@ti.com/
>>
> I didn't try those yet, I was on 6.11-rcX. But from reading them
> quickly, I'm not seeing the two issues I found directly addressed there.

Check the comment by Andrew Davis[0], that addresses the above issue.

[0]: 
https://lore.kernel.org/all/0bba5293-a55d-4f13-887c-272a54d6e1ca@ti.com/

>
>>> Fixes: 3c8a9066d584 ("remoteproc: k3-r5: Do not allow core1 to power
>>> up before core0 via sysfs")
>>> CC: stable@vger.kernel.org
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> There might be one more because I can still make this driver crash
>>> after an operator error. Were error scenarios tested at all?
>>
>> Can you point out what is this issue more specifically, and I can take
>> this up then.
> Try starting core1 before core0, and then again - system will hang or
If you are trying to stop and then start the cores from sysfs, that is 
not yet supported. The hang is thus expected.
> crash while trying to wipe ATCM. I do not understand this problem yet -
> same VA is used, and I cannot see where/how the region should have been
> unmapped in between.
>
> Jan
>
>>>    drivers/remoteproc/ti_k3_r5_remoteproc.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>> b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>> index eb09d2e9b32a..9ebd7a34e638 100644
>>> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>> @@ -646,7 +646,8 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>>>            /* do not allow core 0 to stop before core 1 */
>>>            core1 = list_last_entry(&cluster->cores, struct k3_r5_core,
>>>                        elem);
>>> -        if (core != core1 && core1->rproc->state != RPROC_OFFLINE) {
>>> +        if (core != core1 && core1->rproc &&
>>> +            core1->rproc->state != RPROC_OFFLINE) {
>>>                dev_err(dev, "%s: can not stop core 0 before core 1\n",
>>>                    __func__);
>>>                ret = -EPERM;

