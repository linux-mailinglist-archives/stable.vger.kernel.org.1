Return-Path: <stable+bounces-166981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDED2B1FD7E
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 03:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0543D1743D4
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19F71BF33F;
	Mon, 11 Aug 2025 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRnmYOwd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF047EEC8
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754875231; cv=none; b=jLjPaiNDgMOyUUYQ6O/mNKL8XW4mQXZQSr/moAKH2BOsdvdKUN5XNT5h9Va1rNddSFsclGz3WZUxptsiqDcGSYk6//gDCQaVBqnGgT5ZSz2UXZVFnMwn7GV+k/iN/XvzyFTKHDE+RAHv6hPhdte4KowKk0xKKucDLTMvxCf7EbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754875231; c=relaxed/simple;
	bh=RgVRpjhnI5cQzoRv8+zkbTkpJSWjOfwgq30v9g/64WE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6s5QeTmbBjwGV9dkyMsewmjCntHclq7YNM/3PifuIORydk4MFGCT4wTUWJKQMZvt4u6AwkgsKWQFTgpbgraz0+Esnfwar6AMeX6z9AVYlJ+ciI811rzpnCbhnKabYP5ywPQoKI7GE34BUGPmwqCg6aR6sZg1wmexSBGFWWB8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRnmYOwd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754875228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/UGlbPEX9jmFnopS8rSRmc0XbVHRXLCuL+wso6yQ+ak=;
	b=KRnmYOwd4l/g7y8DvdTrOiuyXL8FMBgw7vFyr8tchSXhdNN6td+TRB2cQ1XND8z1iMVndT
	hXj6If7RVGtrU9TyYgYf8IEYDqzJyhCFwt0K7Bog3dKBVXcP2iDbH68NfMAApTwUpipLc0
	JLZGZ+RrZlLznBArEUMtpgDHAEHkBbU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-donBBPO5OzqoDWMsbs-eJw-1; Sun,
 10 Aug 2025 21:20:26 -0400
X-MC-Unique: donBBPO5OzqoDWMsbs-eJw-1
X-Mimecast-MFC-AGG-ID: donBBPO5OzqoDWMsbs-eJw_1754875225
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC71A18003FC;
	Mon, 11 Aug 2025 01:20:24 +0000 (UTC)
Received: from localhost (unknown [10.22.64.58])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E81321800446;
	Mon, 11 Aug 2025 01:20:23 +0000 (UTC)
Date: Sun, 10 Aug 2025 22:20:22 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Patch "sched: Do not call __put_task_struct() on rt if
 pi_blocked_on is set" has been added to the 6.16-stable tree
Message-ID: <aJlFVnuKwSyDTXOq@uudg.org>
References: <20250808232726.1423484-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808232726.1423484-1-sashal@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Aug 08, 2025 at 07:27:26PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     sched: Do not call __put_task_struct() on rt if pi_blocked_on is set
> 
> to the 6.16-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      sched-do-not-call-__put_task_struct-on-rt-if-pi_bloc.patch
> and it can be found in the queue-6.16 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Hi Sasha!

I am the author of that patch and I sent a follow-up patch that fixes a
mistake I made on the original patch:

    [RESEND PATCH] sched: restore the behavior of put_task_struct() for non-rt
    https://lore.kernel.org/all/aJOwe_ZS5rHXMrsO@uudg.org/

The patch you have does not match what is in the description. I unfortunately
sent the wrong version of the patch on the verge of leaving for a long vacation
and only noticed that when I returned. The code is correct, but does not
match the commit description and is a change that I would like to propose
later as an RFC, not the simpler bugfix originally intended.

I suggest waiting for the follow-up patch mentioned above to include both on
stable kernels.

Sorry for the inconvenience,
Luis

> 
> 
> commit 7bed29f5ad955444283dca82476dd92c59923f73
> Author: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Date:   Mon Jul 7 11:03:59 2025 -0300
> 
>     sched: Do not call __put_task_struct() on rt if pi_blocked_on is set
>     
>     [ Upstream commit 8671bad873ebeb082afcf7b4501395c374da6023 ]
>     
>     With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
>     from rt_mutex_adjust_prio_chain() could happen in preemptible context and
>     with a mutex enqueued. That could lead to this sequence:
>     
>             rt_mutex_adjust_prio_chain()
>               put_task_struct()
>                 __put_task_struct()
>                   sched_ext_free()
>                     spin_lock_irqsave()
>                       rtlock_lock() --->  TRIGGERS
>                                           lockdep_assert(!current->pi_blocked_on);
>     
>     This is not a SCHED_EXT bug. The first cleanup function called by
>     __put_task_struct() is sched_ext_free() and it happens to take a
>     (RT) spin_lock, which in the scenario described above, would trigger
>     the lockdep assertion of "!current->pi_blocked_on".
>     
>     Crystal Wood was able to identify the problem as __put_task_struct()
>     being called during rt_mutex_adjust_prio_chain(), in the context of
>     a process with a mutex enqueued.
>     
>     Instead of adding more complex conditions to decide when to directly
>     call __put_task_struct() and when to defer the call, unconditionally
>     resort to the deferred call on PREEMPT_RT to simplify the code.
>     
>     Fixes: 893cdaaa3977 ("sched: avoid false lockdep splat in put_task_struct()")
>     Suggested-by: Crystal Wood <crwood@redhat.com>
>     Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Reviewed-by: Wander Lairson Costa <wander@redhat.com>
>     Reviewed-by: Valentin Schneider <vschneid@redhat.com>
>     Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     Link: https://lore.kernel.org/r/aGvTz5VaPFyj0pBV@uudg.org
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index ca1db4b92c32..58ce71715268 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -135,24 +135,17 @@ static inline void put_task_struct(struct task_struct *t)
>  		return;
>  
>  	/*
> -	 * In !RT, it is always safe to call __put_task_struct().
> -	 * Under RT, we can only call it in preemptible context.
> -	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> -		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> -
> -		lock_map_acquire_try(&put_task_map);
> -		__put_task_struct(t);
> -		lock_map_release(&put_task_map);
> -		return;
> -	}
> -
> -	/*
> -	 * under PREEMPT_RT, we can't call put_task_struct
> +	 * Under PREEMPT_RT, we can't call __put_task_struct
>  	 * in atomic context because it will indirectly
> -	 * acquire sleeping locks.
> +	 * acquire sleeping locks. The same is true if the
> +	 * current process has a mutex enqueued (blocked on
> +	 * a PI chain).
> +	 *
> +	 * In !RT, it is always safe to call __put_task_struct().
> +	 * Though, in order to simplify the code, resort to the
> +	 * deferred call too.
>  	 *
> -	 * call_rcu() will schedule delayed_put_task_struct_rcu()
> +	 * call_rcu() will schedule __put_task_struct_rcu_cb()
>  	 * to be called in process context.
>  	 *
>  	 * __put_task_struct() is called when
> @@ -165,7 +158,7 @@ static inline void put_task_struct(struct task_struct *t)
>  	 *
>  	 * delayed_free_task() also uses ->rcu, but it is only called
>  	 * when it fails to fork a process. Therefore, there is no
> -	 * way it can conflict with put_task_struct().
> +	 * way it can conflict with __put_task_struct().
>  	 */
>  	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
>  }
> 
---end quoted text---


