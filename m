Return-Path: <stable+bounces-83451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B51499A51E
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 15:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA871F24CC8
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 13:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B1F218D6A;
	Fri, 11 Oct 2024 13:32:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86674216454
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653531; cv=none; b=Nyvt2ol2/m/W77yXkM7/5DAk9UPKC2VMnVaS6BNXNbVgKjhRp3MxFxwfuOjC5ABdeyvdL14IzjNVnxkZWgh9UuvY48J3hndC5NqAaGC/hlu7728ORJhnqp+dSeX51WIvVS65a4HlX+1oqeVdUI0OyI+WXYAqLvKk8MaZTtyiKfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653531; c=relaxed/simple;
	bh=4ihZzzH+zxhZ6xV3cK1ggJhaV6bDI2hzwofKtH6UllE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJqpG2O88xX9SzdeMnTXZkz0cJf3nmYx0V00IkxPmftEUQ25TY1l3xlIF5MU1KjY8hAu9dLQSeKl8ctEaLfwdJE8cPLHe2SG1R3aqWs0svKuchVXsQ9W60qE4B4N1n9ddNM4OvGRicsMsGkUnkI4ej7LRWELL9vTJtQa41Rv9m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A4EA497;
	Fri, 11 Oct 2024 06:32:38 -0700 (PDT)
Received: from [10.34.129.34] (e126645.nice.arm.com [10.34.129.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6FA93F64C;
	Fri, 11 Oct 2024 06:32:07 -0700 (PDT)
Message-ID: <64adbaa7-e7be-4d32-bbfc-2a23568b21a0@arm.com>
Date: Fri, 11 Oct 2024 15:32:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] sched/fair: Fix integer underflow
To: stable@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Hongyan Xia <hongyan.xia2@arm.com>,
 Chritian Loehle <christian.loehle@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20241011132617.1331268-1-pierre.gondois@arm.com>
 <20241011132617.1331268-3-pierre.gondois@arm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20241011132617.1331268-3-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This is a mismanipulation, please ignore this patch.
Sorry for the inconvenience,

Regards,
Pierre Gondois

On 10/11/24 15:26, Pierre Gondois wrote:
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

