Return-Path: <stable+bounces-127410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEBBA78EEC
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 14:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB527A40BF
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 12:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C8C23A9B0;
	Wed,  2 Apr 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F/Yn087g"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF9923A9A4;
	Wed,  2 Apr 2025 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743598043; cv=none; b=hLxwtbjmNLOVIwKJBrfQ8+P1z7zxzq7mV2Ux4IxqDtQBq3EFnrt4tGc6u6p3/YExpZ/9iPvD/GwQJsZFENhCxviUZZFdWPpyhkG43VxvtrcPOXBM78KQcuLDGCUceJDP1cYDgtTmmkVREsgDtfyfYIpbYg283B0H1hjgJbO928c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743598043; c=relaxed/simple;
	bh=I0q8yuccgOTwPasdvh8g2GR8Zcmx2hyT3zKwoj4ieVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaNXjCaXmqQBok5jkMpceextMCQFhF9X/Mzf91VDbkg9omiTSNHMHGMajpjc7+tL6BeWoUjv1aZn88YG4aGkMB2voIYgHIPtQOiZlHF69mxFijq9TOgtvSjju38+hwToRqvpmWz99uXdElmmHiHt4P3km1lW+/SI6gsjvGGpP94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F/Yn087g; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=iNrXwLiaCyxw5lMHmTmgzkArPeaL8QrC1vfZuM5wnc4=; b=F/Yn087gqPQgTAh2YdjKH/VtZ5
	NU/GYeFc9oCxswyI2Y0uLKR+owwsSciPOgIoAkecu/HWGBS7g0rEdkJ0FXrVo5E39sbEooN8Nv8k4
	ZJlpu+UdPZDOwuRUHnP2vjxNxnnLOZUaBVlwW4gD+4US5UPYYeZ7MsP2N8QatRVoSuv8nGyj4CyG3
	brkMQRuxSOc17oj+BYJejgnoMSEtJTb8RkXJ0YVHKtvw/o6xR/Ovyp1GCBjjwlvPBw+vhUS0AA/ax
	u8qTbhqPFkJoi0kVc1TR+hEgmUrREjo51ZfXVD00KIa6BjqwCm5UMPucUkMwseDLYhaA/ztgyDFES
	ye1dYBHA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzxUu-000000071Gk-2xtB;
	Wed, 02 Apr 2025 12:47:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4A6CF30049D; Wed,  2 Apr 2025 14:47:12 +0200 (CEST)
Date: Wed, 2 Apr 2025 14:47:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Jon Kohler <jon@nutanix.com>,
	Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
	Rahul Chunduru <rahul.chunduru@nutanix.com>,
	Will Ton <william.ton@nutanix.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt: Fix race in push_rt_task
Message-ID: <20250402124712.GN25239@noisy.programming.kicks-ass.net>
References: <20250225180553.167995-1-harshit@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225180553.167995-1-harshit@nutanix.com>

On Tue, Feb 25, 2025 at 06:05:53PM +0000, Harshit Agarwal wrote:

> Details
> =======
> Let's look at the following scenario to understand this race.
> 
> 1) CPU A enters push_rt_task
>   a) CPU A has chosen next_task = task p.
>   b) CPU A calls find_lock_lowest_rq(Task p, CPU Z’s rq).
>   c) CPU A identifies CPU X as a destination CPU (X < Z).
>   d) CPU A enters double_lock_balance(CPU Z’s rq, CPU X’s rq).
>   e) Since X is lower than Z, CPU A unlocks CPU Z’s rq. Someone else has
>      locked CPU X’s rq, and thus, CPU A must wait.
> 
> 2) At CPU Z
>   a) Previous task has completed execution and thus, CPU Z enters
>      schedule, locks its own rq after CPU A releases it.
>   b) CPU Z dequeues previous task and begins executing task p.
>   c) CPU Z unlocks its rq.
>   d) Task p yields the CPU (ex. by doing IO or waiting to acquire a
>      lock) which triggers the schedule function on CPU Z.
>   e) CPU Z enters schedule again, locks its own rq, and dequeues task p.
>   f) As part of dequeue, it sets p.on_rq = 0 and unlocks its rq.
> 
> 3) At CPU B
>   a) CPU B enters try_to_wake_up with input task p.
>   b) Since CPU Z dequeued task p, p.on_rq = 0, and CPU B updates
>      B.state = WAKING.
>   c) CPU B via select_task_rq determines CPU Y as the target CPU.
> 
> 4) The race
>   a) CPU A acquires CPU X’s lock and relocks CPU Z.
>   b) CPU A reads task p.cpu = Z and incorrectly concludes task p is
>      still on CPU Z.
>   c) CPU A failed to notice task p had been dequeued from CPU Z while
>      CPU A was waiting for locks in double_lock_balance. If CPU A knew
>      that task p had been dequeued, it would return NULL forcing
>      push_rt_task to give up the task p's migration.
>   d) CPU B updates task p.cpu = Y and calls ttwu_queue.
>   e) CPU B locks Ys rq. CPU B enqueues task p onto Y and sets task
>      p.on_rq = 1.
>   f) CPU B unlocks CPU Y, triggering memory synchronization.
>   g) CPU A reads task p.on_rq = 1, cementing its assumption that task p
>      has not migrated.
>   h) CPU A decides to migrate p to CPU X.
> 
> This leads to A dequeuing p from Y's queue and various crashes down the
> line.
> 
> Solution
> ========
> The solution here is fairly simple. After obtaining the lock (at 4a),
> the check is enhanced to make sure that the task is still at the head of
> the pushable tasks list. If not, then it is anyway not suitable for
> being pushed out.
> 
> Testing
> =======
> The fix is tested on a cluster of 3 nodes, where the panics due to this
> are hit every couple of days. A fix similar to this was deployed on such
> cluster and was stable for more than 30 days.
> 
> Co-developed-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Co-developed-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
> Signed-off-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
> Co-developed-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
> Signed-off-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
> Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
> Tested-by: Will Ton <william.ton@nutanix.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: stable@vger.kernel.org
> ---

Thanks, I've picked this up to land after -rc1.



