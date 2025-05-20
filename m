Return-Path: <stable+bounces-145065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F4ABD6D9
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF263B8323
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 11:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6A4274FD0;
	Tue, 20 May 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CMjS+Hvg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E08121A45A
	for <stable@vger.kernel.org>; Tue, 20 May 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740724; cv=none; b=amFxwKOpRRjn3OdNcBXIV434TOk9fo22qqWDBrN9njMvPXiO+KB5IBpsRzyy83gszriNCiKVz1BbgeiM+caIJ05QJ0eoIZK+FsaCRv2C3W0n2tE2IrM4Vk/o2kvwh41rvcfD8E88/sD20IOmur+UXkN+QKt8nyJZk5gIl/dzbGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740724; c=relaxed/simple;
	bh=wh/gshe+/tk2/LUwfoyN4zDpSHkRuzbPie3npPhwlHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlXoucQRbm2xIKlN0Czu316obLXcm+g0kbPW6QcxmANDTDzBq4h636mv30bPCKwprlaKKGcYRW+mNhAyZCuzQ56OT3oL+RKbLesk9FQjbYnWLrCFAl7GY5VZE3M+BqqoSeZwLI+0+BtQgBfIr73L1vouUCOOLRlyFrMfzOFt3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CMjS+Hvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E78DC4CEE9;
	Tue, 20 May 2025 11:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747740723;
	bh=wh/gshe+/tk2/LUwfoyN4zDpSHkRuzbPie3npPhwlHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMjS+Hvg6yyf4OcAViMOtlhVG5pGKx6VMi/l8ERMTB58SnhW47o6pBANugDxIO0gU
	 pBaorPpmvfJ46r0Dy3LPeTxBzBT3RIbsgFY8+I8o+oaWDfbFzTHw5KL5uX1qKY1ahd
	 14GbKR4ZuVKfBE87pcvsXZKG8K8KoXHHCgN/L/TU=
Date: Tue, 20 May 2025 13:32:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhaoyang Li <lizy04@hust.edu.cn>
Cc: stable@vger.kernel.org, dzm91@hust.edu.cn,
	Frederic Weisbecker <frederic@kernel.org>,
	Vlad Poenaru <vlad.wing@gmail.com>,
	Usama Arif <usamaarif642@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6.1.y] hrtimers: Force migrate away hrtimers queued after
 CPUHP_AP_HRTIMERS_DYING
Message-ID: <2025052041-slobbery-slum-3b74@gregkh>
References: <2025021053-unranked-silt-0282@gregkh>
 <20250513060430.378468-1-lizy04@hust.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513060430.378468-1-lizy04@hust.edu.cn>

On Tue, May 13, 2025 at 02:04:30PM +0800, Zhaoyang Li wrote:
> From: Frederic Weisbecker <frederic@kernel.org>
> 
> [ Upstream commit 53dac345395c0d2493cbc2f4c85fe38aef5b63f5 ]
> 
> hrtimers are migrated away from the dying CPU to any online target at
> the CPUHP_AP_HRTIMERS_DYING stage in order not to delay bandwidth timers
> handling tasks involved in the CPU hotplug forward progress.
> 
> However wakeups can still be performed by the outgoing CPU after
> CPUHP_AP_HRTIMERS_DYING. Those can result again in bandwidth timers being
> armed. Depending on several considerations (crystal ball power management
> based election, earliest timer already enqueued, timer migration enabled or
> not), the target may eventually be the current CPU even if offline. If that
> happens, the timer is eventually ignored.
> 
> The most notable example is RCU which had to deal with each and every of
> those wake-ups by deferring them to an online CPU, along with related
> workarounds:
> 
> _ e787644caf76 (rcu: Defer RCU kthreads wakeup when CPU is dying)
> _ 9139f93209d1 (rcu/nocb: Fix RT throttling hrtimer armed from offline CPU)
> _ f7345ccc62a4 (rcu/nocb: Fix rcuog wake-up from offline softirq)
> 
> The problem isn't confined to RCU though as the stop machine kthread
> (which runs CPUHP_AP_HRTIMERS_DYING) reports its completion at the end
> of its work through cpu_stop_signal_done() and performs a wake up that
> eventually arms the deadline server timer:
> 
>    WARNING: CPU: 94 PID: 588 at kernel/time/hrtimer.c:1086 hrtimer_start_range_ns+0x289/0x2d0
>    CPU: 94 UID: 0 PID: 588 Comm: migration/94 Not tainted
>    Stopper: multi_cpu_stop+0x0/0x120 <- stop_machine_cpuslocked+0x66/0xc0
>    RIP: 0010:hrtimer_start_range_ns+0x289/0x2d0
>    Call Trace:
>    <TASK>
>      start_dl_timer
>      enqueue_dl_entity
>      dl_server_start
>      enqueue_task_fair
>      enqueue_task
>      ttwu_do_activate
>      try_to_wake_up
>      complete
>      cpu_stopper_thread
> 
> Instead of providing yet another bandaid to work around the situation, fix
> it in the hrtimers infrastructure instead: always migrate away a timer to
> an online target whenever it is enqueued from an offline CPU.
> 
> This will also allow to revert all the above RCU disgraceful hacks.
> 
> Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
> Reported-by: Vlad Poenaru <vlad.wing@gmail.com>
> Reported-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> Link: https://lore.kernel.org/all/20250117232433.24027-1-frederic@kernel.org
> Closes: 20241213203739.1519801-1-usamaarif642@gmail.com
> 
> Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>
> ---

You forgot to send a 6.6.y version as well :(

Now dropped from my queue, please resend both.

thanks,

greg k-h

