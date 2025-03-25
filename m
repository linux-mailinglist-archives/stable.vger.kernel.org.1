Return-Path: <stable+bounces-126573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A93BBA704B8
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 16:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3967F189820B
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FF725B681;
	Tue, 25 Mar 2025 15:10:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D25BDF78;
	Tue, 25 Mar 2025 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915444; cv=none; b=INS2ZAGpXofek941TvIALsAYrVr5ikbc0mSf7MHI714WxEnj+lY4eymlS3ov/bd4IK+z02F9MNf9GgRY9avkmh0XnK5tOR3JjQAA5xKAR2cg/6/kYXADrkyhuFSbauC8kM0znnlD6wUkyF92J+CrruyYrD5y6yKQgt3hUErtZcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915444; c=relaxed/simple;
	bh=BZYJziINKBIcqjS1/8unrKx3dUgU2wz565xUE4lre5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdRR7jgqVJLCI29T08feWYL3Im+BryAVHT6Ja6YX0L0fMzNIKCPS2gJ7aG5DhCN8RhrBiP2wUAoG4T7YL+38YMqmM6YVycA8bRBGIedmxx2og7o3egDmHafrRmfbI/X6g5htwyNo4nZk7z4usqCMOWAmwsfpEFOca8BVijSAlqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F9641756;
	Tue, 25 Mar 2025 08:10:45 -0700 (PDT)
Received: from [10.57.14.116] (unknown [10.57.14.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DF7A3F58B;
	Tue, 25 Mar 2025 08:10:36 -0700 (PDT)
Message-ID: <d629b646-d04b-4a26-86a2-34300dcd3e9f@arm.com>
Date: Tue, 25 Mar 2025 16:10:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Fix integer underflow
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Rik van Riel <riel@surriel.com>
References: <20241001134603.2758480-1-pierre.gondois@arm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20241001134603.2758480-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Vincent,

This patch should still be relevant, would it be possible to pick it ?
Or maybe something is missing ?

Regards,
Pierre

On 10/1/24 15:46, Pierre Gondois wrote:
> (struct sg_lb_stats).idle_cpus is of type 'unsigned int'.
> (local->idle_cpus - busiest->idle_cpus) can underflow to UINT_MAX
> for instance, and max_t(long, 0, UINT_MAX) will output UINT_MAX.
> 
> Use lsub_positive() instead of max_t().
> 
> Fixes: 16b0a7a1a0af ("sched/fair: Ensure tasks spreading in LLC during LB")
> cc: stable@vger.kernel.org
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/fair.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..6d9124499f52 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10775,8 +10775,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>   			 * idle CPUs.
>   			 */
>   			env->migration_type = migrate_task;
> -			env->imbalance = max_t(long, 0,
> -					       (local->idle_cpus - busiest->idle_cpus));
> +			env->imbalance = local->idle_cpus;
> +			lsub_positive(&env->imbalance, busiest->idle_cpus);
>   		}
>   
>   #ifdef CONFIG_NUMA

