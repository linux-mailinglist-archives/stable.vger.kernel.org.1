Return-Path: <stable+bounces-164582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3185BB106CA
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 11:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CCCAE5A65
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 09:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F9C23C397;
	Thu, 24 Jul 2025 09:39:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6862376F2
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349947; cv=none; b=CtCMxXeKevyMKXXpEPl7QSdtkHDr9IAuX3VK9QK1wM2lYdiRZal+8ynOVlZdbfzwTS4CyO5sc2ONKnv5vMS2WMGmXLjRQDagQ2Mu69RYX1bT+7/Us0gsSk/ir+WIJ+/muXofhr7kSMQJ1EG7QfKqCip9TUGhWYfzv7C6F2/MXqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349947; c=relaxed/simple;
	bh=JHTkmpIpkXYWBGQKwKlQ8TLgtOc2H64t4qzuHwRuhlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5w0/+9j8Nk8xMs7RC0WqErlKcdksDtsCCqhqtbYanVOoSAPb/S2gMlPNtnfMETH40LyTsuwJHNRXZVrECE/pYQAiWZxYJQ8WxpfV58sUpgbJHwB/g43J/YziUUhT+QSNmBpHji3zhbZZWUYcbKe+etx92w/riuycxP4O1ROsPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bnmD15fjlzKHMs3
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 17:38:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8801B1A0D2A
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 17:38:56 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgBHBLAt_4Fo6AEyBQ--.6832S2;
	Thu, 24 Jul 2025 17:38:54 +0800 (CST)
Message-ID: <9da3269a-9e50-48e9-a1de-6311942f6ea1@huaweicloud.com>
Date: Thu, 24 Jul 2025 17:38:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "Revert "cgroup_freezer: cgroup_freezing: Check if not
 frozen"" has been added to the 6.15-stable tree
To: Greg KH <gregkh@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: chenridong <chenridong@huawei.com>, stable@vger.kernel.org,
 "stable-commits@vger.kernel.org Sasha Levin" <sashal@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20250721125251.814862-1-sashal@kernel.org>
 <1bafc8a024da4a95b28c02430f3d0c9d@huawei.com>
 <3f80facc-8bef-4fc7-ac7e-59279906a707@huaweicloud.com>
 <2025072222-effective-jumble-c817@gregkh>
 <ebec24b9-e65e-4050-a960-d127b7215543@huaweicloud.com>
 <2025072253-gravity-shown-3a37@gregkh>
 <5c09fe1c-cb0c-46bf-ab6d-fda063a0e812@huaweicloud.com>
 <2025072344-arrogance-shame-7114@gregkh>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <2025072344-arrogance-shame-7114@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHBLAt_4Fo6AEyBQ--.6832S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyDAw1xWrWDtr1xGw43trb_yoW5XFyDp3
	93CFWYya1ktr17Jw42y390qF4UtrZ2yw1jgr1kAr18JF90qa4fXrn7uryak34qqr1vk3WU
	ta4DW34xtF4UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/23 13:06, Greg KH wrote:
> On Wed, Jul 23, 2025 at 09:01:43AM +0800, Chen Ridong wrote:
>>
>>
>> On 2025/7/22 20:38, Greg KH wrote:
>>> On Tue, Jul 22, 2025 at 08:25:49PM +0800, Chen Ridong wrote:
>>>>
>>>>
>>>> On 2025/7/22 20:18, Greg KH wrote:
>>>>> On Tue, Jul 22, 2025 at 09:29:13AM +0800, Chen Ridong wrote:
>>>>>>
>>>>>>> This is a note to let you know that I've just added the patch titled
>>>>>>>
>>>>>>>     Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"
>>>>>>>
>>>>>>> to the 6.15-stable tree which can be found at:
>>>>>>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>>>>>
>>>>>>> The filename of the patch is:
>>>>>>>      revert-cgroup_freezer-cgroup_freezing-check-if-not-f.patch
>>>>>>> and it can be found in the queue-6.15 subdirectory.
>>>>>>>
>>>>>>> If you, or anyone else, feels it should not be added to the stable tree, please let <stable@vger.kernel.org> know about it.
>>>>>>>
>>>>>>
>>>>>> The patch ("sched,freezer: Remove unnecessary warning in __thaw_task") should also be merged to
>>>>>> prevent triggering another warning in __thaw_task().
>>>>>
>>>>> What is the git commit id of that change in Linus's tree?
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>>
>>>> 9beb8c5e77dc10e3889ff5f967eeffba78617a88 ("sched,freezer: Remove unnecessary warning in __thaw_task")
>>>
>>> Thanks, but that didn't apply to 6.1.y or 6.6.y.  Shouldn't it also go
>>> there as that's what this revert was applied back to.
>>>
>>> greg k-h
>>
>> Hi Greg,
>>
>> The commit 9beb8c5e77dc ("sched,freezer: Remove unnecessary warning...") should be merged together
>> with 14a67b42cb6f ("Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"") to avoid the
>> warning for 6.1.y or 6.6.y.
> 
> Ok, but 9beb8c5e77dc does not apply properly there.  Can you please
> provide a working backport?
> 
> thanks,
> 
> greg k-h

IIUC, we need to backport these two commits together:
1.commit 23ab79e8e469 ("freezer,sched: Do not restore saved_state of a thawed task")
2.commit 9beb8c5e77dc ("sched,freezer: Remove unnecessary warning...").

After applying these prerequisites, the required change becomes minimal:

diff --git a/kernel/freezer.c b/kernel/freezer.c
index 4fad0e6fca64..288d1cce1fc4 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -196,7 +196,7 @@ void __thaw_task(struct task_struct *p)
        unsigned long flags, flags2;

        spin_lock_irqsave(&freezer_lock, flags);
-       if (WARN_ON_ONCE(freezing(p)))
+       if (!frozen(p))
                goto unlock;

        if (lock_task_sighand(p, &flags2)) {

Would you like me to prepare and submit this patch for the stable branches (6.6.y and 6.1.y)?

Best regards,
Ridong


