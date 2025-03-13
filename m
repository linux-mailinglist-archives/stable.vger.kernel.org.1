Return-Path: <stable+bounces-124251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938C0A5EF33
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082443ADE55
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA620262D35;
	Thu, 13 Mar 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZNmRjsJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5953B206F3D
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857100; cv=none; b=JpRGoEaUwDEeXo9XFq7+oOBMQ5hN7WbgwWmQ9fD9rjxVweKdW2VjHTCpXz6zC8kbj9tRu0xFgeH/uBvq+SHkUOKTvPG7NRaFKIEmNTUbwrYfmEwEDMnfHnVyP9sOXx8mb7cb3nZrHp7IN+BhD5jwLmUSNV9kgmUMWqpnexEVsF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857100; c=relaxed/simple;
	bh=yIr7LZaswVuWNIDY5ihrSHOVg1KWgJh68j6K0nqoGho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdH1bgtRFhgj1kKvAxRjxIq66Ip7Qeo9xIKLysgcqLa6+Jl7PFhdxU77bjXHN1VVpd79Vmem7Mfwqsw/tiN26bzQnAiAJsOiBSXee9VmtLAIiawsI0bbjkEIBoT9imnVdDCB8NT08ZBQUGwQFCNxcHTaeFzQN2laTQ2yfvP9zfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZNmRjsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3318CC4CEDD;
	Thu, 13 Mar 2025 09:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741857099;
	bh=yIr7LZaswVuWNIDY5ihrSHOVg1KWgJh68j6K0nqoGho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZNmRjsJVKxtCLjrK1u0TbbanxObmx0MJCtzq3R21ePW2IiZZ8vsB4zz28ZCglGkX
	 j6buZYTsWYsE+RwK2aTNEWqsoOkciTl2Cj/ty8F9rfgM0SQDGygXp598finxHmcLoO
	 +APKhsjnrenlsfxOlx4Re1Nkc0gcj0/vk2e/Q0kBuvc0pyk0y7o6N4gX7e55CVdGYR
	 NgItI1ffvlK3opiywGsx2KOioVx5iJHHcENscHQyopl9S/MU1fRpLlq98qC2n7xF2a
	 mF1GcMbcAEJNT2lDEjSxFyaLxZkeWNNI57a1ZkGaKwfrqP/OVMUUCz2i0ahRUTC7KX
	 zuZ6+BevDHUoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/1] hrtimer: Use and report correct timerslack values for realtime tasks
Date: Thu, 13 Mar 2025 05:11:37 -0400
Message-Id: <20250312203334-b3cc22061d84f853@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250311140706.435615-1-felix.moessbauer@siemens.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: ed4fb6d7ef68111bb539283561953e5c6e9a6e38

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ed4fb6d7ef681 ! 1:  a4d3916d07d4c hrtimer: Use and report correct timerslack values for realtime tasks
    @@ Metadata
      ## Commit message ##
         hrtimer: Use and report correct timerslack values for realtime tasks
     
    +    commit ed4fb6d7ef68111bb539283561953e5c6e9a6e38 upstream.
    +
         The timerslack_ns setting is used to specify how much the hardware
         timers should be delayed, to potentially dispatch multiple timers in a
         single interrupt. This is a performance optimization. Timers of
    @@ fs/select.c: u64 select_estimate_accuracy(struct timespec64 *tv)
      }
      
     
    - ## kernel/sched/syscalls.c ##
    -@@ kernel/sched/syscalls.c: static void __setscheduler_params(struct task_struct *p,
    + ## kernel/sched/core.c ##
    +@@ kernel/sched/core.c: static void __setscheduler_params(struct task_struct *p,
      	else if (fair_policy(policy))
      		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
      
    @@ kernel/time/hrtimer.c: long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_m
     -	u64 slack;
     -
     -	slack = current->timer_slack_ns;
    --	if (rt_task(current))
    +-	if (dl_task(current) || rt_task(current))
     -		slack = 0;
      
      	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

