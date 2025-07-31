Return-Path: <stable+bounces-165654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A279B170D5
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 14:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CBF47AE9D3
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802401EA73;
	Thu, 31 Jul 2025 12:01:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34782E3716
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753963287; cv=none; b=auQgSjZSAPV6QIKkY56l8XAmacZQY0VNmnkgm4VmzhUeZ22gXvyaSO5CxiYa1Nh5NXI071btr6JBx2tugaPwEAUZEtxh4rzfqM5HR54nIFasSV1MKqXY2FmvLrH+jGEjyiD5VdY3GYPIbEwMQy0wHEYJ4NRBdHvpc5RASdLtVqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753963287; c=relaxed/simple;
	bh=dUF9dfykTwor7tzzG4dxuxvSXrncnCOW38OLEHWIUdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYhBG4lum32ns1QTt7Dzi/+iUKCmqmM7o47XCamzxpMlKJK8BEkdEX3kf+rttbkVgKIZSZ7oRAY+9s6ugJ7I2eMER1OmdkFqrtz6kL7ELx3aoI0D0aXpcY1WBVxJYSTsBGGfHLvl9pwde+GWbctAJaODB3PoOUMxsdUzDwYueBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bt7356p7RzYQv6q
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 20:01:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9EFB21A19A8
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 20:01:20 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgCHTNcNW4to18E_CA--.12633S2;
	Thu, 31 Jul 2025 20:01:18 +0800 (CST)
Message-ID: <0ec06dfd-0cab-4164-b3fc-37bc5effd037@huaweicloud.com>
Date: Thu, 31 Jul 2025 20:01:17 +0800
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
 "mingo@redhat.com >> Ingo Molnar" <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, bristot@redhat.com,
 Valentin Schneider <vschneid@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, pavel@ucw.cz
Cc: Peter Zijlstra <peterz@infradead.org>, chenridong
 <chenridong@huawei.com>, stable@vger.kernel.org,
 "stable-commits@vger.kernel.org Sasha Levin" <sashal@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <1bafc8a024da4a95b28c02430f3d0c9d@huawei.com>
 <3f80facc-8bef-4fc7-ac7e-59279906a707@huaweicloud.com>
 <2025072222-effective-jumble-c817@gregkh>
 <ebec24b9-e65e-4050-a960-d127b7215543@huaweicloud.com>
 <2025072253-gravity-shown-3a37@gregkh>
 <5c09fe1c-cb0c-46bf-ab6d-fda063a0e812@huaweicloud.com>
 <2025072344-arrogance-shame-7114@gregkh>
 <9da3269a-9e50-48e9-a1de-6311942f6ea1@huaweicloud.com>
 <2025072421-deviate-skintight-bbd5@gregkh>
 <89465e3f-7c07-4354-ba41-36d5a5139261@huaweicloud.com>
 <2025072950-tamale-rural-8332@gregkh>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <2025072950-tamale-rural-8332@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCHTNcNW4to18E_CA--.12633S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWDCF1DCF18KFyUKFyUJrb_yoWrtw15pr
	WxJFWYya1Dtr17Jw42yw4YqF4Utws7tr1UWr1kJr18Jrn0qFyfXr1xJry3Cryjqr1xK3WU
	tF1UX34xtF1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	bAw3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/29 22:33, Greg KH wrote:
> On Tue, Jul 29, 2025 at 09:22:10PM +0800, Chen Ridong wrote:
>>
>>
>> On 2025/7/24 17:43, Greg KH wrote:
>>> On Thu, Jul 24, 2025 at 05:38:52PM +0800, Chen Ridong wrote:
>>>>
>>>>
>>>> On 2025/7/23 13:06, Greg KH wrote:
>>>>> On Wed, Jul 23, 2025 at 09:01:43AM +0800, Chen Ridong wrote:
>>>>>>
>>>>>>
>>>>>> On 2025/7/22 20:38, Greg KH wrote:
>>>>>>> On Tue, Jul 22, 2025 at 08:25:49PM +0800, Chen Ridong wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2025/7/22 20:18, Greg KH wrote:
>>>>>>>>> On Tue, Jul 22, 2025 at 09:29:13AM +0800, Chen Ridong wrote:
>>>>>>>>>>
>>>>>>>>>>> This is a note to let you know that I've just added the patch titled
>>>>>>>>>>>
>>>>>>>>>>>     Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"
>>>>>>>>>>>
>>>>>>>>>>> to the 6.15-stable tree which can be found at:
>>>>>>>>>>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>>>>>>>>>
>>>>>>>>>>> The filename of the patch is:
>>>>>>>>>>>      revert-cgroup_freezer-cgroup_freezing-check-if-not-f.patch
>>>>>>>>>>> and it can be found in the queue-6.15 subdirectory.
>>>>>>>>>>>
>>>>>>>>>>> If you, or anyone else, feels it should not be added to the stable tree, please let <stable@vger.kernel.org> know about it.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> The patch ("sched,freezer: Remove unnecessary warning in __thaw_task") should also be merged to
>>>>>>>>>> prevent triggering another warning in __thaw_task().
>>>>>>>>>
>>>>>>>>> What is the git commit id of that change in Linus's tree?
>>>>>>>>>
>>>>>>>>> thanks,
>>>>>>>>>
>>>>>>>>> greg k-h
>>>>>>>>
>>>>>>>> 9beb8c5e77dc10e3889ff5f967eeffba78617a88 ("sched,freezer: Remove unnecessary warning in __thaw_task")
>>>>>>>
>>>>>>> Thanks, but that didn't apply to 6.1.y or 6.6.y.  Shouldn't it also go
>>>>>>> there as that's what this revert was applied back to.
>>>>>>>
>>>>>>> greg k-h
>>>>>>
>>>>>> Hi Greg,
>>>>>>
>>>>>> The commit 9beb8c5e77dc ("sched,freezer: Remove unnecessary warning...") should be merged together
>>>>>> with 14a67b42cb6f ("Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"") to avoid the
>>>>>> warning for 6.1.y or 6.6.y.
>>>>>
>>>>> Ok, but 9beb8c5e77dc does not apply properly there.  Can you please
>>>>> provide a working backport?
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>>
>>>> IIUC, we need to backport these two commits together:
>>>> 1.commit 23ab79e8e469 ("freezer,sched: Do not restore saved_state of a thawed task")
>>>> 2.commit 9beb8c5e77dc ("sched,freezer: Remove unnecessary warning...").
>>>>
>>>> After applying these prerequisites, the required change becomes minimal:
>>>>
>>>> diff --git a/kernel/freezer.c b/kernel/freezer.c
>>>> index 4fad0e6fca64..288d1cce1fc4 100644
>>>> --- a/kernel/freezer.c
>>>> +++ b/kernel/freezer.c
>>>> @@ -196,7 +196,7 @@ void __thaw_task(struct task_struct *p)
>>>>         unsigned long flags, flags2;
>>>>
>>>>         spin_lock_irqsave(&freezer_lock, flags);
>>>> -       if (WARN_ON_ONCE(freezing(p)))
>>>> +       if (!frozen(p))
>>>>                 goto unlock;
>>>>
>>>>         if (lock_task_sighand(p, &flags2)) {
>>>>
>>>> Would you like me to prepare and submit this patch for the stable branches (6.6.y and 6.1.y)?
>>>
>>> Yes, please send me the missing patches as a series for each branch that
>>> needs them.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Hi Greg and maintainers,
>>
>> I've sent the patch series for 6.6.y. Backporting commit 9beb8c5e77dc ("sched,freezer: Remove
>> unnecessary warning...") requires 4 patches for 6.6.y, and the backport to 6.1.y would be even more
>> complex.
>>
>> As an alternative, I'm considering addressing the warning directly with the patch I mentioned
>> previously. What are your thoughts on this approach?
>>
>> The new patch:
>>
>> diff --git a/kernel/freezer.c b/kernel/freezer.c
>> index 4fad0e6fca64..288d1cce1fc4 100644
>> --- a/kernel/freezer.c
>> +++ b/kernel/freezer.c
>> @@ -196,7 +196,7 @@ void __thaw_task(struct task_struct *p)
>>         unsigned long flags, flags2;
>>
>>         spin_lock_irqsave(&freezer_lock, flags);
>> -       if (WARN_ON_ONCE(freezing(p)))
>> +       if (!frozen(p))
>>                 goto unlock;
>>
>>         if (lock_task_sighand(p, &flags2)) {
>>
> 
> I have no idea, sorry, please work with the developers/maintainers of
> the original change and get their approval.  But normally, we do NOT
> want one-off changes being made to older kernel trees unless it has to
> be done, as that makes maintaining them much much much harder over time.
> 
> thanks,
> 
> greg k-h

Hi, developers/maintainers,

Could you please review this series for 6.6.y?

Best regards,
Ridong


