Return-Path: <stable+bounces-141798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E26AAC265
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 13:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09693A57AB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 11:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9448627A45F;
	Tue,  6 May 2025 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMBd3cc6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEFE2798EC
	for <stable@vger.kernel.org>; Tue,  6 May 2025 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530505; cv=none; b=k99RYkLRYYfx8afPe8wJL+F7ji3wHMMICAGC3tXYmGahYHAGscTkkPQ51BmlFCxZ7zvnBiVERC+0VPZukLdEkM1SfQ8IYfKgHJ99M7Xw7JVw+8S2ykZjhfUoTVGpA+OSJ5Tb8FQ2UwH+YpSg/UyjWrxS/pGheo14hP7qHU+Ddh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530505; c=relaxed/simple;
	bh=s1Ixm6WMboKTsvNooKb2pfTDDOcMCS2D4cfDtbIsAKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JapxTO5gzp8kqXQhdJSq9SJy2LGaVRd6dE5q6nO637OuNxYR113sui8Bukm4fiIQbERnj6Kwy3aXxtW70F822RX6JMTDEOWBSHuKoS6V1eZnKVWh2ioh42ZUwUsnz+xxEKSOGr05Txmcy37McMum3n/0GuieXkZwmdLEoNSz6BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMBd3cc6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746530501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QOvRLaP63gYOR03XxNVBF5K4WBSkpnVksFuYLM7tkcI=;
	b=HMBd3cc6jUxzrCjb4oeC9WU4KngJTtXDz/1f6UDpRNvSUCA00ynu2cNVaRHIIwIolJBR6k
	hO16RQKqUI/UtR0g6E0xM+oZb3HToKNxhSSWu+hL7DegELOcPEVSpJMsLDYxhUTO1I3xrT
	RioFpogs5MLTMLskUAp9CGE81epvPVs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-3ONevib6Nti5-C1YLuD3Ow-1; Tue,
 06 May 2025 07:21:36 -0400
X-MC-Unique: 3ONevib6Nti5-C1YLuD3Ow-1
X-Mimecast-MFC-AGG-ID: 3ONevib6Nti5-C1YLuD3Ow_1746530494
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D44718009A1;
	Tue,  6 May 2025 11:21:33 +0000 (UTC)
Received: from fedora (unknown [10.44.33.231])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 24E85180045B;
	Tue,  6 May 2025 11:21:28 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  6 May 2025 13:21:33 +0200 (CEST)
Date: Tue, 6 May 2025 13:21:27 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Christian Brauner <brauner@kernel.org>, akpm@linux-foundation.org,
	mhocko@suse.com, Liam.Howlett@oracle.com, mjguzik@gmail.com,
	pasha.tatashin@soleen.com, alexjlzheng@tencent.com
Subject: Re: [PATCH AUTOSEL 5.4 66/79] exit: change the release_task() paths
 to call flush_sigqueue() lockless
Message-ID: <aBnwt9cbww5R6TnN@redhat.com>
References: <20250505232151.2698893-1-sashal@kernel.org>
 <20250505232151.2698893-66-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505232151.2698893-66-sashal@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

I'm on PTO until May 15, can't read the code.

Did you verify that 5.14 has all the necessary "recent" posixtimer changes?

Oleg.

On 05/05, Sasha Levin wrote:
>
> From: Oleg Nesterov <oleg@redhat.com>
> 
> [ Upstream commit fb3bbcfe344e64a46574a638b051ffd78762c12d ]
> 
> A task can block a signal, accumulate up to RLIMIT_SIGPENDING sigqueues,
> and exit. In this case __exit_signal()->flush_sigqueue() called with irqs
> disabled can trigger a hard lockup, see
> https://lore.kernel.org/all/20190322114917.GC28876@redhat.com/
> 
> Fortunately, after the recent posixtimer changes sys_timer_delete() paths
> no longer try to clear SIGQUEUE_PREALLOC and/or free tmr->sigq, and after
> the exiting task passes __exit_signal() lock_task_sighand() can't succeed
> and pid_task(tmr->it_pid) will return NULL.
> 
> This means that after __exit_signal(tsk) nobody can play with tsk->pending
> or (if group_dead) with tsk->signal->shared_pending, so release_task() can
> safely call flush_sigqueue() after write_unlock_irq(&tasklist_lock).
> 
> TODO:
> 	- we can probably shift posix_cpu_timers_exit() as well
> 	- do_sigaction() can hit the similar problem
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Link: https://lore.kernel.org/r/20250206152314.GA14620@redhat.com
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/exit.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 5015ecdda6d95..69deb2901ec55 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -204,20 +204,13 @@ static void __exit_signal(struct task_struct *tsk)
>  	__unhash_process(tsk, group_dead);
>  	write_sequnlock(&sig->stats_lock);
>  
> -	/*
> -	 * Do this under ->siglock, we can race with another thread
> -	 * doing sigqueue_free() if we have SIGQUEUE_PREALLOC signals.
> -	 */
> -	flush_sigqueue(&tsk->pending);
>  	tsk->sighand = NULL;
>  	spin_unlock(&sighand->siglock);
>  
>  	__cleanup_sighand(sighand);
>  	clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
> -	if (group_dead) {
> -		flush_sigqueue(&sig->shared_pending);
> +	if (group_dead)
>  		tty_kref_put(tty);
> -	}
>  }
>  
>  static void delayed_put_task_struct(struct rcu_head *rhp)
> @@ -277,6 +270,16 @@ void release_task(struct task_struct *p)
>  
>  	write_unlock_irq(&tasklist_lock);
>  	release_thread(p);
> +	/*
> +	 * This task was already removed from the process/thread/pid lists
> +	 * and lock_task_sighand(p) can't succeed. Nobody else can touch
> +	 * ->pending or, if group dead, signal->shared_pending. We can call
> +	 * flush_sigqueue() lockless.
> +	 */
> +	flush_sigqueue(&p->pending);
> +	if (thread_group_leader(p))
> +		flush_sigqueue(&p->signal->shared_pending);
> +
>  	put_task_struct_rcu_user(p);
>  
>  	p = leader;
> -- 
> 2.39.5
> 


