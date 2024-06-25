Return-Path: <stable+bounces-55774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B00916AA6
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 16:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6931C22DEF
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 14:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2F016C685;
	Tue, 25 Jun 2024 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Miq7nW/c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBA71662F1;
	Tue, 25 Jun 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326297; cv=none; b=LCmWnVX1wNtYUsor1zDpVpBfGMoPaqQbmvOW0mpGDEswHN4T/e22y5UpnGNOMMaM4HKxSHVLEfCBkN/1aqlOtuZ1hUVvxf5+gkNaR75Wnwz/Hz8rGOVXYOmY0eITfhKFUkFpiKi6HktyZar4yxIJK14s8AAjacqnA4PC53NVt/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326297; c=relaxed/simple;
	bh=rng6Pxx7DaynLgbJijOT8Ld8UKh2ZuGJqyUGKfti4Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/u0HnCuQXHISbM4wNmlZVa3eYQM+k31k3qRNn11r3t2dlcJ1ixq3Q0rU/fYQJS2oxiDvPhZJexuRX6OgMhybMzl5viE2GKqL9WHr4C/bCm86QN/iwU2jgk+rPvB2XNdLKisxIrBy12VC6QWcqAV0ijKymRi9XMeSlD7b5abE2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Miq7nW/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98419C32781;
	Tue, 25 Jun 2024 14:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719326296;
	bh=rng6Pxx7DaynLgbJijOT8Ld8UKh2ZuGJqyUGKfti4Rg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Miq7nW/c1E//0IYqcj8p5Y+iD6KFHCxrsJs66rTv1/nxGkmXqQnBqcYu46VqAS7OC
	 FnNy9wednJxUSSY+Csf9nUK03c6ulsQpEfN5RjYuwRal0O20Nb02pBAk4E/vt7RfXo
	 qD8FeOrlExVzC7lXsrGdZuesBVyt90lmD0zH8WuviXWGlFT0aCU9dGo4Pd1oBxgvnP
	 3aRB4KD5Wo7E4mHXIGbmbRri2bxQNc8eBlW3x3O6TR3lvkEtXlLyOVzC0kNAuubFnR
	 82CH8Zg2OAiS32dVSSUJDGFcg87DXCQYyiToJItDzlUqaVNvCvy/L8WXN20Sq/c8o2
	 9yUGmZ2nYxuOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 79377CE0485; Tue, 25 Jun 2024 07:38:15 -0700 (PDT)
Date: Tue, 25 Jun 2024 07:38:15 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Stultz <jstultz@google.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Zhiguo Niu <zhiguo.niu@unisoc.com>, stable@vger.kernel.org,
	Xuewen Yan <xuewen.yan@unisoc.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4][RESEND x4] lockdep: fix deadlock issue between
 lockdep and rcu
Message-ID: <b56d0b33-4224-4d54-ab90-e12857446ec8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240514191547.3230887-1-cmllamas@google.com>
 <20240620225436.3127927-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620225436.3127927-1-cmllamas@google.com>

On Thu, Jun 20, 2024 at 10:54:34PM +0000, Carlos Llamas wrote:
> From: Zhiguo Niu <zhiguo.niu@unisoc.com>
> 
> There is a deadlock scenario between lockdep and rcu when
> rcu nocb feature is enabled, just as following call stack:

I have pulled this into -rcu for further review and testing.

If someone else (for example, the lockdep folks) would like to take this:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

>      rcuop/x
> -000|queued_spin_lock_slowpath(lock = 0xFFFFFF817F2A8A80, val = ?)
> -001|queued_spin_lock(inline) // try to hold nocb_gp_lock
> -001|do_raw_spin_lock(lock = 0xFFFFFF817F2A8A80)
> -002|__raw_spin_lock_irqsave(inline)
> -002|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F2A8A80)
> -003|wake_nocb_gp_defer(inline)
> -003|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F30B680)
> -004|__call_rcu_common(inline)
> -004|call_rcu(head = 0xFFFFFFC082EECC28, func = ?)
> -005|call_rcu_zapped(inline)
> -005|free_zapped_rcu(ch = ?)// hold graph lock
> -006|rcu_do_batch(rdp = 0xFFFFFF817F245680)
> -007|nocb_cb_wait(inline)
> -007|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F245680)
> -008|kthread(_create = 0xFFFFFF80803122C0)
> -009|ret_from_fork(asm)
> 
>      rcuop/y
> -000|queued_spin_lock_slowpath(lock = 0xFFFFFFC08291BBC8, val = 0)
> -001|queued_spin_lock()
> -001|lockdep_lock()
> -001|graph_lock() // try to hold graph lock
> -002|lookup_chain_cache_add()
> -002|validate_chain()
> -003|lock_acquire
> -004|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F211D80)
> -005|lock_timer_base(inline)
> -006|mod_timer(inline)
> -006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
> -006|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F2A8680)
> -007|__call_rcu_common(inline)
> -007|call_rcu(head = 0xFFFFFFC0822E0B58, func = ?)
> -008|call_rcu_hurry(inline)
> -008|rcu_sync_call(inline)
> -008|rcu_sync_func(rhp = 0xFFFFFFC0822E0B58)
> -009|rcu_do_batch(rdp = 0xFFFFFF817F266680)
> -010|nocb_cb_wait(inline)
> -010|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F266680)
> -011|kthread(_create = 0xFFFFFF8080363740)
> -012|ret_from_fork(asm)
> 
> rcuop/x and rcuop/y are rcu nocb threads with the same nocb gp thread.
> This patch release the graph lock before lockdep call_rcu.
> 
> Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
> Cc: stable@vger.kernel.org
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Carlos Llamas <cmllamas@google.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  kernel/locking/lockdep.c | 48 ++++++++++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 151bd3de5936..3468d8230e5f 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -6184,25 +6184,27 @@ static struct pending_free *get_pending_free(void)
>  static void free_zapped_rcu(struct rcu_head *cb);
>  
>  /*
> - * Schedule an RCU callback if no RCU callback is pending. Must be called with
> - * the graph lock held.
> - */
> -static void call_rcu_zapped(struct pending_free *pf)
> +* See if we need to queue an RCU callback, must called with
> +* the lockdep lock held, returns false if either we don't have
> +* any pending free or the callback is already scheduled.
> +* Otherwise, a call_rcu() must follow this function call.
> +*/
> +static bool prepare_call_rcu_zapped(struct pending_free *pf)
>  {
>  	WARN_ON_ONCE(inside_selftest());
>  
>  	if (list_empty(&pf->zapped))
> -		return;
> +		return false;
>  
>  	if (delayed_free.scheduled)
> -		return;
> +		return false;
>  
>  	delayed_free.scheduled = true;
>  
>  	WARN_ON_ONCE(delayed_free.pf + delayed_free.index != pf);
>  	delayed_free.index ^= 1;
>  
> -	call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> +	return true;
>  }
>  
>  /* The caller must hold the graph lock. May be called from RCU context. */
> @@ -6228,6 +6230,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
>  {
>  	struct pending_free *pf;
>  	unsigned long flags;
> +	bool need_callback;
>  
>  	if (WARN_ON_ONCE(ch != &delayed_free.rcu_head))
>  		return;
> @@ -6239,14 +6242,18 @@ static void free_zapped_rcu(struct rcu_head *ch)
>  	pf = delayed_free.pf + (delayed_free.index ^ 1);
>  	__free_zapped_classes(pf);
>  	delayed_free.scheduled = false;
> +	need_callback =
> +		prepare_call_rcu_zapped(delayed_free.pf + delayed_free.index);
> +	lockdep_unlock();
> +	raw_local_irq_restore(flags);
>  
>  	/*
> -	 * If there's anything on the open list, close and start a new callback.
> -	 */
> -	call_rcu_zapped(delayed_free.pf + delayed_free.index);
> +	* If there's pending free and its callback has not been scheduled,
> +	* queue an RCU callback.
> +	*/
> +	if (need_callback)
> +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>  
> -	lockdep_unlock();
> -	raw_local_irq_restore(flags);
>  }
>  
>  /*
> @@ -6286,6 +6293,7 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
>  {
>  	struct pending_free *pf;
>  	unsigned long flags;
> +	bool need_callback;
>  
>  	init_data_structures_once();
>  
> @@ -6293,10 +6301,11 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
>  	lockdep_lock();
>  	pf = get_pending_free();
>  	__lockdep_free_key_range(pf, start, size);
> -	call_rcu_zapped(pf);
> +	need_callback = prepare_call_rcu_zapped(pf);
>  	lockdep_unlock();
>  	raw_local_irq_restore(flags);
> -
> +	if (need_callback)
> +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>  	/*
>  	 * Wait for any possible iterators from look_up_lock_class() to pass
>  	 * before continuing to free the memory they refer to.
> @@ -6390,6 +6399,7 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
>  	struct pending_free *pf;
>  	unsigned long flags;
>  	int locked;
> +	bool need_callback = false;
>  
>  	raw_local_irq_save(flags);
>  	locked = graph_lock();
> @@ -6398,11 +6408,13 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
>  
>  	pf = get_pending_free();
>  	__lockdep_reset_lock(pf, lock);
> -	call_rcu_zapped(pf);
> +	need_callback = prepare_call_rcu_zapped(pf);
>  
>  	graph_unlock();
>  out_irq:
>  	raw_local_irq_restore(flags);
> +	if (need_callback)
> +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>  }
>  
>  /*
> @@ -6446,6 +6458,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
>  	struct pending_free *pf;
>  	unsigned long flags;
>  	bool found = false;
> +	bool need_callback = false;
>  
>  	might_sleep();
>  
> @@ -6466,11 +6479,14 @@ void lockdep_unregister_key(struct lock_class_key *key)
>  	if (found) {
>  		pf = get_pending_free();
>  		__lockdep_free_key_range(pf, key, 1);
> -		call_rcu_zapped(pf);
> +		need_callback = prepare_call_rcu_zapped(pf);
>  	}
>  	lockdep_unlock();
>  	raw_local_irq_restore(flags);
>  
> +	if (need_callback)
> +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> +
>  	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
>  	synchronize_rcu();
>  }
> -- 
> 2.45.2.741.gdbec12cfda-goog
> 

