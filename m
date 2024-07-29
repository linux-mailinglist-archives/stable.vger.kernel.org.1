Return-Path: <stable+bounces-62444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A4893F1D2
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 11:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEC7284136
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCD8143734;
	Mon, 29 Jul 2024 09:50:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58821422C7;
	Mon, 29 Jul 2024 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246653; cv=none; b=lQ0SFnyIlqYF/p4zWgpyZ+lQgurrCOhvWXIpwh6LYai2A/f5qzajS3UXSbbgcXyw1m/0WPvKS+iBBiBT7+x5VrTemudXaDDkc2bv2RyYYunezg4d/C8rHdRySZx7ZUKUBHSfWQHYG2ZY/aE60pMNwko9skvi4Fgynogn1hOHa1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246653; c=relaxed/simple;
	bh=vnBJjS/Nkhu1Zs0dAazWe/voq1rP6YchWhpCNKQVKhs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fGUSkVwsKJtE1V6rTtC2SfwMcZEBEYDDWbFyt6OLzvHjao0sLaohQ446doZ+pGHih4iBrPzWa+Eg4KHpXe+rzmDC92g6UHf9HoEGpxisTNQ2A/SKCMvM37ZVanmkY3Gbegt8QscW9QFbtVBq34dHNDpbMqazDXTBo+juwSP9r/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D0E81007;
	Mon, 29 Jul 2024 02:51:15 -0700 (PDT)
Received: from [10.57.78.240] (unknown [10.57.78.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BBC63F64C;
	Mon, 29 Jul 2024 02:50:48 -0700 (PDT)
Message-ID: <2cbb3467-1b49-4c86-9fad-9c75ce7d9c8f@arm.com>
Date: Mon, 29 Jul 2024 11:50:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Use all little CPUs for CPU-bound workload
From: Pierre Gondois <pierre.gondois@arm.com>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 Lukasz Luba <Lukasz.Luba@arm.com>
Cc: linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20231206090043.634697-1-pierre.gondois@arm.com>
 <999a6c1d-c21d-4d16-a2a2-6d0b6e7df9a5@arm.com>
Content-Language: en-US
In-Reply-To: <999a6c1d-c21d-4d16-a2a2-6d0b6e7df9a5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Sasha,
Would it be possible to pick this patch for the 6.1 stable branch ?
Or is there something I should do for this purpose ?

Regards,
Pierre

On 6/25/24 15:25, Pierre Gondois wrote:
> Hello stable folk,
> 
> This patch was merged as:
>     commit 3af7524b1419 ("sched/fair: Use all little CPUs for CPU-bound workloads")
> into 6.7, improving the following:
>     commit 0b0695f2b34a ("sched/fair: Rework load_balance()")
> 
> Would it be possible to port it to the 6.1 stable branch ?
> The patch should apply cleanly by cherry-picking onto v6.1.94,
> 
> Regards,
> Pierre
> 
> 
> On 12/6/23 10:00, Pierre Gondois wrote:
>> Running n CPU-bound tasks on an n CPUs platform:
>> - with asymmetric CPU capacity
>> - not being a DynamIq system (i.e. having a PKG level sched domain
>>     without the SD_SHARE_PKG_RESOURCES flag set)
>> might result in a task placement where two tasks run on a big CPU
>> and none on a little CPU. This placement could be more optimal by
>> using all CPUs.
>>
>> Testing platform:
>> Juno-r2:
>> - 2 big CPUs (1-2), maximum capacity of 1024
>> - 4 little CPUs (0,3-5), maximum capacity of 383
>>
>> Testing workload ([1]):
>> Spawn 6 CPU-bound tasks. During the first 100ms (step 1), each tasks
>> is affine to a CPU, except for:
>> - one little CPU which is left idle.
>> - one big CPU which has 2 tasks affine.
>> After the 100ms (step 2), remove the cpumask affinity.
>>
>> Before patch:
>> During step 2, the load balancer running from the idle CPU tags sched
>> domains as:
>> - little CPUs: 'group_has_spare'. Cf. group_has_capacity() and
>>     group_is_overloaded(), 3 CPU-bound tasks run on a 4 CPUs
>>     sched-domain, and the idle CPU provides enough spare capacity
>>     regarding the imbalance_pct
>> - big CPUs: 'group_overloaded'. Indeed, 3 tasks run on a 2 CPUs
>>     sched-domain, so the following path is used:
>>     group_is_overloaded()
>>     \-if (sgs->sum_nr_running <= sgs->group_weight) return true;
>>
>>     The following path which would change the migration type to
>>     'migrate_task' is not taken:
>>     calculate_imbalance()
>>     \-if (env->idle != CPU_NOT_IDLE && env->imbalance == 0)
>>     as the local group has some spare capacity, so the imbalance
>>     is not 0.
>>
>> The migration type requested is 'migrate_util' and the busiest
>> runqueue is the big CPU's runqueue having 2 tasks (each having a
>> utilization of 512). The idle little CPU cannot pull one of these
>> task as its capacity is too small for the task. The following path
>> is used:
>> detach_tasks()
>> \-case migrate_util:
>>     \-if (util > env->imbalance) goto next;
>>
>> After patch:
>> As the number of failed balancing attempts grows (with
>> 'nr_balance_failed'), progressively make it easier to migrate
>> a big task to the idling little CPU. A similar mechanism is
>> used for the 'migrate_load' migration type.
>>
>> Improvement:
>> Running the testing workload [1] with the step 2 representing
>> a ~10s load for a big CPU:
>> Before patch: ~19.3s
>> After patch: ~18s (-6.7%)
>>
>> Similar issue reported at:
>> https://lore.kernel.org/lkml/20230716014125.139577-1-qyousef@layalina.io/
>>
>> v1:
>> https://lore.kernel.org/all/20231110125902.2152380-1-pierre.gondois@arm.com/
>> v2:
>> https://lore.kernel.org/all/20231124153323.3202444-1-pierre.gondois@arm.com/
>>
>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
>> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> ---
>>
>> Notes:
>>       v2:
>>       - Used Vincent's approach.
>>       v3:
>>       - Updated commit message.
>>       - Added Reviewed-by tags
>>
>>    kernel/sched/fair.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d7a3c63a2171..9481b8cff31b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9060,7 +9060,7 @@ static int detach_tasks(struct lb_env *env)
>>    		case migrate_util:
>>    			util = task_util_est(p);
>>    
>> -			if (util > env->imbalance)
>> +			if (shr_bound(util, env->sd->nr_balance_failed) > env->imbalance)
>>    				goto next;
>>    
>>    			env->imbalance -= util;
> 

