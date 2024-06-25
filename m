Return-Path: <stable+bounces-55765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF8A9168C7
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 15:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5568F1C217D7
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B812415A86D;
	Tue, 25 Jun 2024 13:25:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2725F1509A2;
	Tue, 25 Jun 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321937; cv=none; b=rlh2DBTT3WALsQFdoUCL1d4nc0WExSn6JDeO2MJV6bU+bTzchWNcQkr1JhkEaHx3iKIc5FWz6sJyUs2znZSzLNJnUpqp35mGIu+xLro65TpzYvkXDoCELPTG0ykJ+UAVuxRcKMWnTdqFMz+JR32W7hgYIQEvy/FqHMwlJdwy3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321937; c=relaxed/simple;
	bh=tqSBsmMuibHgwLh0R0CfN4nJ6RiBIwpQ9TzxPMB2pdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FeXqnAFVNTEtcd2VAdYgjxaoqKQKtk1bL4vx/l1VDwnfmFZY0mlFzDivaO3Rq2n2jnu3ZIJHqwlR6ehCtiyn7zuSyWlCQewfk8bB0bV+Gsfo7TIt6wD1tKUQbUuVkebI1/grXwp/wpljRn5wtih63BLiBDDxYJYW1hAV+3JbffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA59C339;
	Tue, 25 Jun 2024 06:25:58 -0700 (PDT)
Received: from [10.34.111.183] (e126645.nice.Arm.com [10.34.111.183])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B7723F73B;
	Tue, 25 Jun 2024 06:25:31 -0700 (PDT)
Message-ID: <999a6c1d-c21d-4d16-a2a2-6d0b6e7df9a5@arm.com>
Date: Tue, 25 Jun 2024 15:25:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Use all little CPUs for CPU-bound workload
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Lukasz Luba <Lukasz.Luba@arm.com>
References: <20231206090043.634697-1-pierre.gondois@arm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20231206090043.634697-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello stable folk,

This patch was merged as:
   commit 3af7524b1419 ("sched/fair: Use all little CPUs for CPU-bound workloads")
into 6.7, improving the following:
   commit 0b0695f2b34a ("sched/fair: Rework load_balance()")

Would it be possible to port it to the 6.1 stable branch ?
The patch should apply cleanly by cherry-picking onto v6.1.94,

Regards,
Pierre


On 12/6/23 10:00, Pierre Gondois wrote:
> Running n CPU-bound tasks on an n CPUs platform:
> - with asymmetric CPU capacity
> - not being a DynamIq system (i.e. having a PKG level sched domain
>    without the SD_SHARE_PKG_RESOURCES flag set)
> might result in a task placement where two tasks run on a big CPU
> and none on a little CPU. This placement could be more optimal by
> using all CPUs.
> 
> Testing platform:
> Juno-r2:
> - 2 big CPUs (1-2), maximum capacity of 1024
> - 4 little CPUs (0,3-5), maximum capacity of 383
> 
> Testing workload ([1]):
> Spawn 6 CPU-bound tasks. During the first 100ms (step 1), each tasks
> is affine to a CPU, except for:
> - one little CPU which is left idle.
> - one big CPU which has 2 tasks affine.
> After the 100ms (step 2), remove the cpumask affinity.
> 
> Before patch:
> During step 2, the load balancer running from the idle CPU tags sched
> domains as:
> - little CPUs: 'group_has_spare'. Cf. group_has_capacity() and
>    group_is_overloaded(), 3 CPU-bound tasks run on a 4 CPUs
>    sched-domain, and the idle CPU provides enough spare capacity
>    regarding the imbalance_pct
> - big CPUs: 'group_overloaded'. Indeed, 3 tasks run on a 2 CPUs
>    sched-domain, so the following path is used:
>    group_is_overloaded()
>    \-if (sgs->sum_nr_running <= sgs->group_weight) return true;
> 
>    The following path which would change the migration type to
>    'migrate_task' is not taken:
>    calculate_imbalance()
>    \-if (env->idle != CPU_NOT_IDLE && env->imbalance == 0)
>    as the local group has some spare capacity, so the imbalance
>    is not 0.
> 
> The migration type requested is 'migrate_util' and the busiest
> runqueue is the big CPU's runqueue having 2 tasks (each having a
> utilization of 512). The idle little CPU cannot pull one of these
> task as its capacity is too small for the task. The following path
> is used:
> detach_tasks()
> \-case migrate_util:
>    \-if (util > env->imbalance) goto next;
> 
> After patch:
> As the number of failed balancing attempts grows (with
> 'nr_balance_failed'), progressively make it easier to migrate
> a big task to the idling little CPU. A similar mechanism is
> used for the 'migrate_load' migration type.
> 
> Improvement:
> Running the testing workload [1] with the step 2 representing
> a ~10s load for a big CPU:
> Before patch: ~19.3s
> After patch: ~18s (-6.7%)
> 
> Similar issue reported at:
> https://lore.kernel.org/lkml/20230716014125.139577-1-qyousef@layalina.io/
> 
> v1:
> https://lore.kernel.org/all/20231110125902.2152380-1-pierre.gondois@arm.com/
> v2:
> https://lore.kernel.org/all/20231124153323.3202444-1-pierre.gondois@arm.com/
> 
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
> 
> Notes:
>      v2:
>      - Used Vincent's approach.
>      v3:
>      - Updated commit message.
>      - Added Reviewed-by tags
> 
>   kernel/sched/fair.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d7a3c63a2171..9481b8cff31b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9060,7 +9060,7 @@ static int detach_tasks(struct lb_env *env)
>   		case migrate_util:
>   			util = task_util_est(p);
>   
> -			if (util > env->imbalance)
> +			if (shr_bound(util, env->sd->nr_balance_failed) > env->imbalance)
>   				goto next;
>   
>   			env->imbalance -= util;

