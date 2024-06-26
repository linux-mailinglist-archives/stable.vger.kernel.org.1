Return-Path: <stable+bounces-55888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBB3919A77
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 00:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9497D283144
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 22:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0952416D33A;
	Wed, 26 Jun 2024 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfikK9P/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40E21586C5;
	Wed, 26 Jun 2024 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719440120; cv=none; b=ftT+asCcTd20SKWg+dwDzGq43BWrz+DlYqaE0X3Vr4OH8piaWhWmh9BilcVK4RxlFtkNXosHWfWKZU/UgdBZONkL42kR5cop8pxYZ9RovchJ/WVpegIANa3phJHOJSqFeTS6ZLHWkPnhdTpDWW3V460v2YFxdziZZFF+lNoHYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719440120; c=relaxed/simple;
	bh=yXEwngalSsDQWZskz5bgHKX7+xjzyiQt0/Ekj9cTccc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czGfjekH84L16AdCnEfsOdPwyGrlYZQ0bOd9ZavkQvQ2KgdrkabjMmXuG0fMJMJn4XGpuo/htrXQrPyPG269lk6X2Q97ieKrX/tFCh2uJyEw9QpugB8Zh0JVjVTgVhTSb0XNDxhNmVcDIFw/SDPUD8v7fzgcOrDRJbpLgQRhgTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfikK9P/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79c05313eb5so222831185a.1;
        Wed, 26 Jun 2024 15:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719440118; x=1720044918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/I40GRdvoTwoeWprwuRkVeEl9Qmh04aeRKGM8dWU24=;
        b=ZfikK9P/3WEtBGoVWL873iHnleAgQ/c7E36SjPo7lWf362OizAlD69dGwmTWafJtED
         ciX5P0EkwESNUuRo7hBPTnExL44+fbMYS6nXL38RJ0EYxZUU9YCFSSf7e1HI75KowP86
         1F+/Tsm2PrvEcYZj8bc7KmtBhJvuaCHce5gpuZ7pfykwIrKeWSML4tgpLgl6bVGzzsOE
         5IQ6hBu6cCWGcNYTs0m2W+3qon+ojdsuP+Tfhlszc5rLOcCFYX9rdtmIudHWqFdZmTqg
         zHlUspEHYUQwb0DLQBnLErjSYJFmLx+TS50HDCt9LjioghWYWeIwIE84kcmJO9afuQ1O
         Fu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719440118; x=1720044918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/I40GRdvoTwoeWprwuRkVeEl9Qmh04aeRKGM8dWU24=;
        b=j0/FUCiwJ7ylT8Jy8OIxZNCZx2W7bwj5zcrgQPL5GYnD8Su2vza0wjQ1ozS5XvYEzN
         GIlHFQ5Tjgr+QcoovEnxv/RrfeE8asrgPKOc/CQHKSAsGyrMQlZdWaECUbl9eJy02Qj8
         4rxlI5hZRccQaBRDsePAGKUVObXpS/0B+Nvp8jVZWGVwlW7Ape/Kx8egkvODAilQBBJf
         7ErzXD9IDOerFnbjqY0ltPLRCHOI39FOowTTJAmVFnsFHymj/yReNfuPSv1zCYmdbL4J
         e71WAdgeDvNZlc5Ks7Zo+NbdwOg7HRNlm0zkzdYcUMdLO2Y4Y7lhLdUF/367v0ambXwa
         niPA==
X-Forwarded-Encrypted: i=1; AJvYcCV2ccyiyNIrGHt2NNzE8TM8bbP4PhU2nZACN6UuPmkTAdD07xM3my9lgAZ4egzP2iuzFwyQpPWbbnJPVKczr9mjJ2bjqqRwwOzlgGzjXZ09q2dNQ1H4SuDK6IgPUdGNBSaPrDG5
X-Gm-Message-State: AOJu0YyqDTV/DPdO65xMLPCWwavFwmrdvjbklcSTqnp//7JB3zEcL+x2
	pQYt0T6rzOys6Wzb5Ovu3ImSQRreJA/8bUF8PTWxI604WzsSuW2a
X-Google-Smtp-Source: AGHT+IHtzT6svptcReljKD9AI0oSTnWscFOSwRlBZ7nY4dn68lHsJLP+bO4Fjg27jtHkhu6D/q+sEg==
X-Received: by 2002:a05:620a:2908:b0:797:9e22:767b with SMTP id af79cd13be357-79be6e54413mr1290075285a.29.1719440117668;
        Wed, 26 Jun 2024 15:15:17 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d5c8b8a78sm1107285a.100.2024.06.26.15.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 15:15:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 4B77F120006C;
	Wed, 26 Jun 2024 18:15:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 26 Jun 2024 18:15:16 -0400
X-ME-Sender: <xms:9JJ8Zr5sLK-zaGSp1-RetAaCVAO6mc6ljxs2xJ6qBPcC0WniQoVhvA>
    <xme:9JJ8Zg4du8qe5t0mgilqoykFx4Fft8gZq5IYlnhnllqI5r_-6nFr0Q9cuCEtjCMxm
    u6M44dhGF_lDKpT4g>
X-ME-Received: <xmr:9JJ8ZidLDlIam5t75ZXWgL1BP0mVxF1X7pSBFLFYDwfc0N1QU6BpfzFKdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdefgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddv
    hedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:9JJ8ZsJ1ciatuvLa_Vb3ZTP6om45eHWLjt1TDMVAPjzoz_seDhIP5A>
    <xmx:9JJ8ZvIzpDv4Ttv0lykpnX7DyR5iS-K38pN4gw17rRTxHlExcPv_-A>
    <xmx:9JJ8ZlwmlCun8dP93AOFKC4EzbwxMkbMxdZXVBIcxCs_XqDABhlVRA>
    <xmx:9JJ8ZrKO-D-qHekZ-iUZYKIb9wHuN1Z-nKDT6JtClxFnKolRq7KSRw>
    <xmx:9JJ8ZqZ60X1anaU-JcGuLanxO4pd_kcHA7N1BvKSAetzGo6rzRtEYSUT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jun 2024 18:15:15 -0400 (EDT)
Date: Wed, 26 Jun 2024 15:15:14 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Stultz <jstultz@google.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Zhiguo Niu <zhiguo.niu@unisoc.com>, stable@vger.kernel.org,
	Xuewen Yan <xuewen.yan@unisoc.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4][RESEND x4] lockdep: fix deadlock issue between
 lockdep and rcu
Message-ID: <ZnyS8rH8ZNirufcl@Boquns-Mac-mini.home>
References: <20240514191547.3230887-1-cmllamas@google.com>
 <20240620225436.3127927-1-cmllamas@google.com>
 <b56d0b33-4224-4d54-ab90-e12857446ec8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b56d0b33-4224-4d54-ab90-e12857446ec8@paulmck-laptop>

On Tue, Jun 25, 2024 at 07:38:15AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 20, 2024 at 10:54:34PM +0000, Carlos Llamas wrote:
> > From: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > 
> > There is a deadlock scenario between lockdep and rcu when
> > rcu nocb feature is enabled, just as following call stack:
> 
> I have pulled this into -rcu for further review and testing.
> 
> If someone else (for example, the lockdep folks) would like to take this:
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> 

FWIW, I add this patch and another one [1] to my tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git lockdep

(based on today's tip/locking/core)

I figured I have time to handle lockdep-only patches, which shouldn't
be a lot. So Ingo & Peter, I'm happy to help. If you need me to pick up
lockdep patches and send a PR against tip/master or tip/locking/core,
please let me know.

Regards,
Boqun

[1]: https://lore.kernel.org/all/20240528120008.403511-2-thorsten.blum@toblux.com/

> >      rcuop/x
> > -000|queued_spin_lock_slowpath(lock = 0xFFFFFF817F2A8A80, val = ?)
> > -001|queued_spin_lock(inline) // try to hold nocb_gp_lock
> > -001|do_raw_spin_lock(lock = 0xFFFFFF817F2A8A80)
> > -002|__raw_spin_lock_irqsave(inline)
> > -002|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F2A8A80)
> > -003|wake_nocb_gp_defer(inline)
> > -003|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F30B680)
> > -004|__call_rcu_common(inline)
> > -004|call_rcu(head = 0xFFFFFFC082EECC28, func = ?)
> > -005|call_rcu_zapped(inline)
> > -005|free_zapped_rcu(ch = ?)// hold graph lock
> > -006|rcu_do_batch(rdp = 0xFFFFFF817F245680)
> > -007|nocb_cb_wait(inline)
> > -007|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F245680)
> > -008|kthread(_create = 0xFFFFFF80803122C0)
> > -009|ret_from_fork(asm)
> > 
> >      rcuop/y
> > -000|queued_spin_lock_slowpath(lock = 0xFFFFFFC08291BBC8, val = 0)
> > -001|queued_spin_lock()
> > -001|lockdep_lock()
> > -001|graph_lock() // try to hold graph lock
> > -002|lookup_chain_cache_add()
> > -002|validate_chain()
> > -003|lock_acquire
> > -004|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F211D80)
> > -005|lock_timer_base(inline)
> > -006|mod_timer(inline)
> > -006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
> > -006|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F2A8680)
> > -007|__call_rcu_common(inline)
> > -007|call_rcu(head = 0xFFFFFFC0822E0B58, func = ?)
> > -008|call_rcu_hurry(inline)
> > -008|rcu_sync_call(inline)
> > -008|rcu_sync_func(rhp = 0xFFFFFFC0822E0B58)
> > -009|rcu_do_batch(rdp = 0xFFFFFF817F266680)
> > -010|nocb_cb_wait(inline)
> > -010|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F266680)
> > -011|kthread(_create = 0xFFFFFF8080363740)
> > -012|ret_from_fork(asm)
> > 
> > rcuop/x and rcuop/y are rcu nocb threads with the same nocb gp thread.
> > This patch release the graph lock before lockdep call_rcu.
> > 
> > Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
> > Cc: stable@vger.kernel.org
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Carlos Llamas <cmllamas@google.com>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > Reviewed-by: Waiman Long <longman@redhat.com>
> > Reviewed-by: Carlos Llamas <cmllamas@google.com>
> > Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  kernel/locking/lockdep.c | 48 ++++++++++++++++++++++++++--------------
> >  1 file changed, 32 insertions(+), 16 deletions(-)
> > 
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 151bd3de5936..3468d8230e5f 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -6184,25 +6184,27 @@ static struct pending_free *get_pending_free(void)
> >  static void free_zapped_rcu(struct rcu_head *cb);
> >  
> >  /*
> > - * Schedule an RCU callback if no RCU callback is pending. Must be called with
> > - * the graph lock held.
> > - */
> > -static void call_rcu_zapped(struct pending_free *pf)
> > +* See if we need to queue an RCU callback, must called with
> > +* the lockdep lock held, returns false if either we don't have
> > +* any pending free or the callback is already scheduled.
> > +* Otherwise, a call_rcu() must follow this function call.
> > +*/
> > +static bool prepare_call_rcu_zapped(struct pending_free *pf)
> >  {
> >  	WARN_ON_ONCE(inside_selftest());
> >  
> >  	if (list_empty(&pf->zapped))
> > -		return;
> > +		return false;
> >  
> >  	if (delayed_free.scheduled)
> > -		return;
> > +		return false;
> >  
> >  	delayed_free.scheduled = true;
> >  
> >  	WARN_ON_ONCE(delayed_free.pf + delayed_free.index != pf);
> >  	delayed_free.index ^= 1;
> >  
> > -	call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> > +	return true;
> >  }
> >  
> >  /* The caller must hold the graph lock. May be called from RCU context. */
> > @@ -6228,6 +6230,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
> >  {
> >  	struct pending_free *pf;
> >  	unsigned long flags;
> > +	bool need_callback;
> >  
> >  	if (WARN_ON_ONCE(ch != &delayed_free.rcu_head))
> >  		return;
> > @@ -6239,14 +6242,18 @@ static void free_zapped_rcu(struct rcu_head *ch)
> >  	pf = delayed_free.pf + (delayed_free.index ^ 1);
> >  	__free_zapped_classes(pf);
> >  	delayed_free.scheduled = false;
> > +	need_callback =
> > +		prepare_call_rcu_zapped(delayed_free.pf + delayed_free.index);
> > +	lockdep_unlock();
> > +	raw_local_irq_restore(flags);
> >  
> >  	/*
> > -	 * If there's anything on the open list, close and start a new callback.
> > -	 */
> > -	call_rcu_zapped(delayed_free.pf + delayed_free.index);
> > +	* If there's pending free and its callback has not been scheduled,
> > +	* queue an RCU callback.
> > +	*/
> > +	if (need_callback)
> > +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> >  
> > -	lockdep_unlock();
> > -	raw_local_irq_restore(flags);
> >  }
> >  
> >  /*
> > @@ -6286,6 +6293,7 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
> >  {
> >  	struct pending_free *pf;
> >  	unsigned long flags;
> > +	bool need_callback;
> >  
> >  	init_data_structures_once();
> >  
> > @@ -6293,10 +6301,11 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
> >  	lockdep_lock();
> >  	pf = get_pending_free();
> >  	__lockdep_free_key_range(pf, start, size);
> > -	call_rcu_zapped(pf);
> > +	need_callback = prepare_call_rcu_zapped(pf);
> >  	lockdep_unlock();
> >  	raw_local_irq_restore(flags);
> > -
> > +	if (need_callback)
> > +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> >  	/*
> >  	 * Wait for any possible iterators from look_up_lock_class() to pass
> >  	 * before continuing to free the memory they refer to.
> > @@ -6390,6 +6399,7 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
> >  	struct pending_free *pf;
> >  	unsigned long flags;
> >  	int locked;
> > +	bool need_callback = false;
> >  
> >  	raw_local_irq_save(flags);
> >  	locked = graph_lock();
> > @@ -6398,11 +6408,13 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
> >  
> >  	pf = get_pending_free();
> >  	__lockdep_reset_lock(pf, lock);
> > -	call_rcu_zapped(pf);
> > +	need_callback = prepare_call_rcu_zapped(pf);
> >  
> >  	graph_unlock();
> >  out_irq:
> >  	raw_local_irq_restore(flags);
> > +	if (need_callback)
> > +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> >  }
> >  
> >  /*
> > @@ -6446,6 +6458,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
> >  	struct pending_free *pf;
> >  	unsigned long flags;
> >  	bool found = false;
> > +	bool need_callback = false;
> >  
> >  	might_sleep();
> >  
> > @@ -6466,11 +6479,14 @@ void lockdep_unregister_key(struct lock_class_key *key)
> >  	if (found) {
> >  		pf = get_pending_free();
> >  		__lockdep_free_key_range(pf, key, 1);
> > -		call_rcu_zapped(pf);
> > +		need_callback = prepare_call_rcu_zapped(pf);
> >  	}
> >  	lockdep_unlock();
> >  	raw_local_irq_restore(flags);
> >  
> > +	if (need_callback)
> > +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> > +
> >  	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
> >  	synchronize_rcu();
> >  }
> > -- 
> > 2.45.2.741.gdbec12cfda-goog
> > 

