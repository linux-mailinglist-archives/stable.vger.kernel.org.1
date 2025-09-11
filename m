Return-Path: <stable+bounces-179257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1593B53244
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 14:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E7A1C86E53
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2AC320CDD;
	Thu, 11 Sep 2025 12:30:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD6D13B284;
	Thu, 11 Sep 2025 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593856; cv=none; b=qBy8+lS3+15+wtKiFJPNNUaz1odCsf8cqVEA+78nIBmo4Um5vF4JGXGFKFGZr8li7RcMRnQCqT/+y7832oUV2bnZUXybXq088nWqKaGghGo4xQCNlZtlV+exxG50AUMUmQrAimZnHLC6iAzJqo8PDsEXJt7sxSN5X3QYG5K69UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593856; c=relaxed/simple;
	bh=YaxswK5ei/lhvQ2pZQoMwTNmCH4do9dlvQfptK9Dxe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BUgiX/kss9/YLo5d/stmQrTQXsazk69ZxG5g0H16xt9VSqJC8Z1R+j7u+/ZEcaYEMnvqkiSr2VuLslvysOM90b7iDBtDlLlkSIbRTZz0NT6JM2uZtOfDgqB+dM9w9azY4A4cNZ7USHgixyxpIW75LPOnOxumb87UDHbHURMezXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cMxcP52p5zdcYH;
	Thu, 11 Sep 2025 20:26:13 +0800 (CST)
Received: from dggpemf100009.china.huawei.com (unknown [7.185.36.128])
	by mail.maildlp.com (Postfix) with ESMTPS id A540D140156;
	Thu, 11 Sep 2025 20:30:46 +0800 (CST)
Received: from [10.67.109.25] (10.67.109.25) by dggpemf100009.china.huawei.com
 (7.185.36.128) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 11 Sep
 2025 20:30:45 +0800
Message-ID: <0614bb1c-3dc9-4ad1-9135-19662e20163b@huawei.com>
Date: Thu, 11 Sep 2025 20:30:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable/linux-5.10.y] sched/core: Fix potential deadlock on
 rq lock
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <mingo@redhat.com>, <peterz@infradead.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <tglx@linutronix.de>,
	<frederic@kernel.org>, <linux-kernel@vger.kernel.org>,
	<tanghui20@huawei.com>, <zhangqiao22@huawei.com>
References: <20250908084230.848195-1-wangtao554@huawei.com>
 <2025091123-unsterile-why-ca1e@gregkh>
From: "wangtao (EQ)" <wangtao554@huawei.com>
In-Reply-To: <2025091123-unsterile-why-ca1e@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf100009.china.huawei.com (7.185.36.128)


在 2025/9/11 20:20, Greg KH 写道:
> On Mon, Sep 08, 2025 at 08:42:30AM +0000, Wang Tao wrote:
>> When CPU 1 enters the nohz_full state, and the kworker on CPU 0 executes
>> the function sched_tick_remote, holding the lock on CPU1's rq
>> and triggering the warning WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3).
>> This leads to the process of printing the warning message, where the
>> console_sem semaphore is held. At this point, the print task on the
>> CPU1's rq cannot acquire the console_sem and joins the wait queue,
>> entering the UNINTERRUPTIBLE state. It waits for the console_sem to be
>> released and then wakes up. After the task on CPU 0 releases
>> the console_sem, it wakes up the waiting console_sem task.
>> In try_to_wake_up, it attempts to acquire the lock on CPU1's rq again,
>> resulting in a deadlock.
>>
>> The triggering scenario is as follows:
>>
>> CPU 0								CPU1
>> sched_tick_remote
>> WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3)
>>
>> report_bug							con_write
>> printk
>>
>> console_unlock
>> 								do_con_write
>> 								console_lock
>> 								down(&console_sem)
>> 								list_add_tail(&waiter.list, &sem->wait_list);
>> up(&console_sem)
>> wake_up_q(&wake_q)
>> try_to_wake_up
>> __task_rq_lock
>> _raw_spin_lock
>>
>> This patch fixes the issue by deffering all printk console printing
>> during the lock holding period.
>>
>> Fixes: d84b31313ef8 ("sched/isolation: Offload residual 1Hz scheduler tick")
>> Signed-off-by: Wang Tao <wangtao554@huawei.com>
>> ---
>>   kernel/sched/core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 40f40f359c5d..fd2c83058ec2 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4091,6 +4091,7 @@ static void sched_tick_remote(struct work_struct *work)
>>   		goto out_requeue;
>>   
>>   	rq_lock_irq(rq, &rf);
>> +	printk_deferred_enter();
>>   	curr = rq->curr;
>>   	if (cpu_is_offline(cpu))
>>   		goto out_unlock;
>> @@ -4109,6 +4110,7 @@ static void sched_tick_remote(struct work_struct *work)
>>   
>>   	calc_load_nohz_remote(rq);
>>   out_unlock:
>> +	printk_deferred_exit();
>>   	rq_unlock_irq(rq, &rf);
>>   out_requeue:
>>   
>> -- 
>> 2.34.1
>>
>>
Sorry, we initially discovered the issue while testing the stable 
branch, and it seems that the mainline has the same problem, but I 
haven't submitted a patch yet.


Thanks

Tao

> What is the git commit id of this in Linus's tree?
>
> thanks,
>
> greg k-h
>

