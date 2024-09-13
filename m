Return-Path: <stable+bounces-76099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 287989786E4
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 19:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1AF91F230F4
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 17:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD99823AF;
	Fri, 13 Sep 2024 17:36:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3841B1C14;
	Fri, 13 Sep 2024 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248999; cv=none; b=pCKoi58N9iZrD3f59WS51LuZWW3ilY1zJc+/2TFUj8EKHEFmysfzX2q5EUXjV9JNSoohXSpLKEWfe2dj/RtqxmbREequur1ifEG+loB5OfHe7Ocl9r4l1MYrfTUMDTppwHNbc0FzXrCFNhnI4omZ0PX17ZRNIVtfLyLNiHvlYGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248999; c=relaxed/simple;
	bh=i4sBOolzT6ahoQSSuKXWmcVCJLLVD2qcsAVFDfhP6MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imANcuoYu31FhyfXgUyZBuy5nONtT8441UzISIbV8UgPxip0ebAZbwlfJid7BEvBQIdwW/Wv+v/OAdtnjKSedU1Ac+WqjG8SBQMKeFekcd78SfCAgJeW4JPWxPTz0ejBg77GDGQslS5Cu9bxRlLlvBOwMveHMZq/u170hdx8MYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 676CD13D5;
	Fri, 13 Sep 2024 10:37:05 -0700 (PDT)
Received: from [192.168.1.12] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC4A33F64C;
	Fri, 13 Sep 2024 10:36:33 -0700 (PDT)
Message-ID: <6f365e5b-220c-4b2e-8a56-a5135b216e62@arm.com>
Date: Fri, 13 Sep 2024 19:36:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix integer underflow
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20240913085824.404709-1-pierre.gondois@arm.com>
 <CAKfTPtB2=_O=dJbTH=e_Hg80_rcSvBgwUP+ZMehfyG4sG5W6iQ@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAKfTPtB2=_O=dJbTH=e_Hg80_rcSvBgwUP+ZMehfyG4sG5W6iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Vincent,

On 9/13/24 18:14, Vincent Guittot wrote:
> Hi Pierre
> 
> On Fri, 13 Sept 2024 at 10:58, Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>> (struct sg_lb_stats).idle_cpus is of type 'unsigned int'.
>> (local->idle_cpus - busiest->idle_cpus) can underflow to UINT_MAX
>> for instance, and max_t(long, 0, UINT_MAX) will output UINT_MAX.
>>
>> Use lsub_positive() instead of max_t().
> 
> Have you faced the problem or this patch is based on code review ?
> 
> we have the below in sched_balance_find_src_group() that should ensure
> that we have local->idle_cpus > busiest->idle_cpus
> 
> if (busiest->group_weight > 1 &&
>      local->idle_cpus <= (busiest->idle_cpus + 1)) {
>      /*
>      * If the busiest group is not overloaded
>      * and there is no imbalance between this and busiest
>      * group wrt idle CPUs, it is balanced. The imbalance
>      * becomes significant if the diff is greater than 1
>      * otherwise we might end up to just move the imbalance
>      * on another group. Of course this applies only if
>      * there is more than 1 CPU per group.
>      */
>      goto out_balanced;
> }

It was with this setup:
- busiest->group_type == group_overloaded
so it might not have checked the value. I can check the exact path if desired,

Regards,
Pierre


> 
>>
>> Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
>> cc: stable@vger.kernel.org
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   kernel/sched/fair.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 9057584ec06d..6d9124499f52 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10775,8 +10775,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>>                           * idle CPUs.
>>                           */
>>                          env->migration_type = migrate_task;
>> -                       env->imbalance = max_t(long, 0,
>> -                                              (local->idle_cpus - busiest->idle_cpus));
>> +                       env->imbalance = local->idle_cpus;
>> +                       lsub_positive(&env->imbalance, busiest->idle_cpus);
>>                  }
>>
>>   #ifdef CONFIG_NUMA
>> --
>> 2.25.1
>>

