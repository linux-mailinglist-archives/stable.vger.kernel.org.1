Return-Path: <stable+bounces-111187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1C4A22116
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623F71881952
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1296A1D6DB7;
	Wed, 29 Jan 2025 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s05e65qX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0033997
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166350; cv=none; b=OpuljnRjqqc5kU6bnPbtVR8zFJXWPJ0LmaGCfFFsTsrG2+3VF34bEm/hb/5b4KUGZXmU9HvNZhSqucdo630MSyXDYBJLbr58SW1IkUuRxe4yGe89C732K19jzVYesQWRwJ2I5AB0qLvSkhbzyrFNLpiOfs73/Hb34XT20Updmhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166350; c=relaxed/simple;
	bh=DvvWrPpK6uTuKLmS7SUbKVS6HaxVo1QCxRJjRKrkMjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwMM6zfZPxaOPbX//lPSAio9dWbJ7cBdoXQmJyYgv5v29AcU9sLHuBCoI9GjHBgPPWuxx3OXIvJCLUxwmwLB+EUlOtfKJmUg0ZSpThhLVK+rLOEAgNEIPSBaLv4jGOM9EpF0FMmZxvuvqFrq71tc/mcPk7PlFQzJ5x/jum/cJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s05e65qX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A989CC4CED1;
	Wed, 29 Jan 2025 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738166350;
	bh=DvvWrPpK6uTuKLmS7SUbKVS6HaxVo1QCxRJjRKrkMjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s05e65qX/ivOOtm2vfx7JqNnHaGv5btEcHMOBWDYpsgCSjCV+NF+1PfQ0hkumvQ/2
	 spGWBkD/5ETO6vE5jbawUfHUKdOWTmNwtcWRkb+zOlOnhZkaw/bz9rM6G9VVY7w1SQ
	 Dz+r+84VcSyaI61s0IFro852zkYRrxqb9PKyGcJA=
Date: Wed, 29 Jan 2025 16:58:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: stable@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: Re: [PATCH 6.1] softirq: Allow raising SCHED_SOFTIRQ from
 SMP-call-function on RT kernel
Message-ID: <2025012928-muppet-amends-b460@gregkh>
References: <20250129153226.818485-1-florian.bezdeka@siemens.com>
 <2025012926-rocker-crispy-f397@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025012926-rocker-crispy-f397@gregkh>

On Wed, Jan 29, 2025 at 04:47:59PM +0100, Greg KH wrote:
> On Wed, Jan 29, 2025 at 04:32:26PM +0100, Florian Bezdeka wrote:
> > From: K Prateek Nayak <kprateek.nayak@amd.com>
> > 
> > commit 6675ce20046d149e1e1ffe7e9577947dee17aad5 upstream.
> > 
> > do_softirq_post_smp_call_flush() on PREEMPT_RT kernels carries a
> > WARN_ON_ONCE() for any SOFTIRQ being raised from an SMP-call-function.
> > Since do_softirq_post_smp_call_flush() is called with preempt disabled,
> > raising a SOFTIRQ during flush_smp_call_function_queue() can lead to
> > longer preempt disabled sections.
> > 
> > Since commit b2a02fc43a1f ("smp: Optimize
> > send_call_function_single_ipi()") IPIs to an idle CPU in
> > TIF_POLLING_NRFLAG mode can be optimized out by instead setting
> > TIF_NEED_RESCHED bit in idle task's thread_info and relying on the
> > flush_smp_call_function_queue() in the idle-exit path to run the
> > SMP-call-function.
> > 
> > To trigger an idle load balancing, the scheduler queues
> > nohz_csd_function() responsible for triggering an idle load balancing on
> > a target nohz idle CPU and sends an IPI. Only now, this IPI is optimized
> > out and the SMP-call-function is executed from
> > flush_smp_call_function_queue() in do_idle() which can raise a
> > SCHED_SOFTIRQ to trigger the balancing.
> > 
> > So far, this went undetected since, the need_resched() check in
> > nohz_csd_function() would make it bail out of idle load balancing early
> > as the idle thread does not clear TIF_POLLING_NRFLAG before calling
> > flush_smp_call_function_queue(). The need_resched() check was added with
> > the intent to catch a new task wakeup, however, it has recently
> > discovered to be unnecessary and will be removed in the subsequent
> > commit after which nohz_csd_function() can raise a SCHED_SOFTIRQ from
> > flush_smp_call_function_queue() to trigger an idle load balance on an
> > idle target in TIF_POLLING_NRFLAG mode.
> > 
> > nohz_csd_function() bails out early if "idle_cpu()" check for the
> > target CPU, and does not lock the target CPU's rq until the very end,
> > once it has found tasks to run on the CPU and will not inhibit the
> > wakeup of, or running of a newly woken up higher priority task. Account
> > for this and prevent a WARN_ON_ONCE() when SCHED_SOFTIRQ is raised from
> > flush_smp_call_function_queue().
> > 
> > Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lore.kernel.org/r/20241119054432.6405-2-kprateek.nayak@amd.com
> > Tested-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> > 
> > Newer stable branches (6.12, 6.6) got this already, 5.10 and lower are
> > not affected.
> > 
> > The warning triggered for SCHED_SOFTIRQ under high network load while
> > testing.
> 
> But RT is not in the 6.1.y tree, right?  Or is it?  Why was it only
> backported to 6.6.y and 6.12.y?

And see:
	https://lore.kernel.org/r/d21a8129-e982-463f-af8b-07a14b6a674a@amd.com
for why we added it to 6.12.y in the first place (I don't know why Sasha
added it to 6.6.y...)

thanks,

greg k-h

