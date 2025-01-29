Return-Path: <stable+bounces-111184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0881A220E1
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3BD61654EF
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863A418F2EA;
	Wed, 29 Jan 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V63S8NDg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD033997
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165739; cv=none; b=bjW4UpcZu4qZKbZjvcqPmQ+fa/YAjvFwFn4ffeGi1pgFEqiztiFkLAx8zVIntceRidJ+uNi/k/5W/o/hUX+xJHtIq9wW5KhtwF0PUeM117nxtJPtBunt4NJR9xyxJG9gaU4X5WrV/5ezLk0Kysy10V2KoiOfGqsiZr5sJGyH+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165739; c=relaxed/simple;
	bh=WOpWgoUpCGZ1qXv0/JcUyQ+dNZGmMruo8atD5a2J52c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6CxoBpfG8aNvFm3daogMyqrVHoWhXqc3rY2dW3UZyfLkOPl46fcQmsTHbSfP7+CksCggcVhGUHR2XV6fMZCedyyhimyc/N8QYeeDV42l3JPlbbQKzkX58k7CHZ1JOVPogAVp7sNbSc5nTH/lpf8fWXAg4k1Tt0ceWtWtzvMNnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V63S8NDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566A3C4CED1;
	Wed, 29 Jan 2025 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738165738;
	bh=WOpWgoUpCGZ1qXv0/JcUyQ+dNZGmMruo8atD5a2J52c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V63S8NDgA38dtKe6ElZzME0rsMA3IF4ubYu9HWjzIrw6EA+kVxbD6LEmFHiMAbyfI
	 2qmFtdDtyPqziG+k5rOAOzvCIfdTOQRBUS9+MeDQvkawlR6H5I0XdNORHS5oFeDDm9
	 NZntsi6Xz0iZ56dLiTYBAUa0unPCwjzBudK0kkW0=
Date: Wed, 29 Jan 2025 16:47:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: stable@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: Re: [PATCH 6.1] softirq: Allow raising SCHED_SOFTIRQ from
 SMP-call-function on RT kernel
Message-ID: <2025012926-rocker-crispy-f397@gregkh>
References: <20250129153226.818485-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129153226.818485-1-florian.bezdeka@siemens.com>

On Wed, Jan 29, 2025 at 04:32:26PM +0100, Florian Bezdeka wrote:
> From: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> commit 6675ce20046d149e1e1ffe7e9577947dee17aad5 upstream.
> 
> do_softirq_post_smp_call_flush() on PREEMPT_RT kernels carries a
> WARN_ON_ONCE() for any SOFTIRQ being raised from an SMP-call-function.
> Since do_softirq_post_smp_call_flush() is called with preempt disabled,
> raising a SOFTIRQ during flush_smp_call_function_queue() can lead to
> longer preempt disabled sections.
> 
> Since commit b2a02fc43a1f ("smp: Optimize
> send_call_function_single_ipi()") IPIs to an idle CPU in
> TIF_POLLING_NRFLAG mode can be optimized out by instead setting
> TIF_NEED_RESCHED bit in idle task's thread_info and relying on the
> flush_smp_call_function_queue() in the idle-exit path to run the
> SMP-call-function.
> 
> To trigger an idle load balancing, the scheduler queues
> nohz_csd_function() responsible for triggering an idle load balancing on
> a target nohz idle CPU and sends an IPI. Only now, this IPI is optimized
> out and the SMP-call-function is executed from
> flush_smp_call_function_queue() in do_idle() which can raise a
> SCHED_SOFTIRQ to trigger the balancing.
> 
> So far, this went undetected since, the need_resched() check in
> nohz_csd_function() would make it bail out of idle load balancing early
> as the idle thread does not clear TIF_POLLING_NRFLAG before calling
> flush_smp_call_function_queue(). The need_resched() check was added with
> the intent to catch a new task wakeup, however, it has recently
> discovered to be unnecessary and will be removed in the subsequent
> commit after which nohz_csd_function() can raise a SCHED_SOFTIRQ from
> flush_smp_call_function_queue() to trigger an idle load balance on an
> idle target in TIF_POLLING_NRFLAG mode.
> 
> nohz_csd_function() bails out early if "idle_cpu()" check for the
> target CPU, and does not lock the target CPU's rq until the very end,
> once it has found tasks to run on the CPU and will not inhibit the
> wakeup of, or running of a newly woken up higher priority task. Account
> for this and prevent a WARN_ON_ONCE() when SCHED_SOFTIRQ is raised from
> flush_smp_call_function_queue().
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20241119054432.6405-2-kprateek.nayak@amd.com
> Tested-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> 
> Newer stable branches (6.12, 6.6) got this already, 5.10 and lower are
> not affected.
> 
> The warning triggered for SCHED_SOFTIRQ under high network load while
> testing.

But RT is not in the 6.1.y tree, right?  Or is it?  Why was it only
backported to 6.6.y and 6.12.y?

thanks,

greg k-h

