Return-Path: <stable+bounces-139330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68384AA615D
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7F19A1EDE
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7035321127D;
	Thu,  1 May 2025 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWd/ipQl"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474CE20F07D
	for <stable@vger.kernel.org>; Thu,  1 May 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746116700; cv=none; b=i+l/M17T7BpTEsCwKz9yU7V8vMs5fgnTEbXpWYb6y9G9Hc6XPs46BUi+JyoG4a65HkyXl1UfF0Va3fX2qwZfO9phclNEbrRYB/ElkGW9ujVs8VHmlzENvIuw3iV45FDFud0Iyk3am2mVy/A3C4rZGMrFk8V7+kvWbD1L/6sbW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746116700; c=relaxed/simple;
	bh=o+j3na0UAGbSU7fM3mYK4BrIhyWcuxrYMVo633XqpOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fx5u0EvTPZfKo4Yej+QejOIdZzxBjCmJPAgATPgpR8npSzn1zhv3qWNItErESrND+1PZqGfAcGDg/iE668gkOogmTMZCjURqk3e1Eo29FhJYvDTWcYSXLU31A/zVFAuogmCu1sS+RsbTweyjbQS2suJrrOlPY+mVOV9yLYeIcrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWd/ipQl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746116697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M2q6Oaisc5EemrPoSPV9f41k+mzm9g4CeKF/hOvn80Y=;
	b=PWd/ipQl69kzL1iV/R3c5jMqpT1o2Z/0jLuVeYI9WrGUBOJEOwy2dLYm8fe+sI65VNJKZQ
	lERsYn5zO0KUVgdd18hEonBKdHoJs7zddFmRtyKCjQCvkLqr1ttVz3BlODGub1KcQC670Z
	g+gTVJCLNng0qGXyq96+qZnOPrVSzwo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-kQ80UlgNODqdRSkuHgCWGw-1; Thu, 01 May 2025 12:24:55 -0400
X-MC-Unique: kQ80UlgNODqdRSkuHgCWGw-1
X-Mimecast-MFC-AGG-ID: kQ80UlgNODqdRSkuHgCWGw_1746116695
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4770594a277so45737761cf.0
        for <stable@vger.kernel.org>; Thu, 01 May 2025 09:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746116695; x=1746721495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2q6Oaisc5EemrPoSPV9f41k+mzm9g4CeKF/hOvn80Y=;
        b=mYZBsw8SqDdQiKzYCX74lwDQkEjeSkaPe7bOb+goQ8D8GjNKnywlUo8baQlMqljfGb
         fyb7yM4aKwpKJLmXPBYubph4VrcKh7GUiRw15hcbzy5x4B0uFhWp7/xgojU8qOD80j0k
         ttBlbzuyeivPyE8SBHo9PzVJa68D0Sty1IqRdjQcrZmu3MaORdTHw1budjZqA9qKXGlH
         9GpBLQX+ns3uvdb21DJ3TPUloUqmd+ER+UFH4w10OiAZ5F9mX/Pf4bILGRW9h/xlVO6e
         2PC2px2Aap7/8FVYMnCpu6iH8o8gwTCWN+PT+u3w2VPEnN3ED2WXLmr4GfkM11Y18wlm
         S4rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxqvexG3gtUrsNxxxB2+qDPZHwTrflCJDjDqPsSFWrQsQEyYvPdU8y2wTcFoLkQNSYVzArUqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4rU/QzXcQqqx66m877rELfrw0Jvj7oiimHm+mxmEBZHczWPhG
	2RCrf3fuGXO1pdtjQB5eNeA5GpSphpdH7ibg62dfGEFmGWlwOMIGLWtrTI+Kh9lAkiEJG/4kcU6
	xKvFW/PX4fLWxwxh2Oj0lnAm7m1biEqp0usYpHPyd5xSNisTjhcW3Aw==
X-Gm-Gg: ASbGncvKMombG4jiego6jgBWD1lpgyB/yIeGSzdmt8jWch1H3qNncOaRvgSCOLfoNOh
	zW3e6WOoxUH6hrVe+b55TjRHuJKOvhgxODnEJexvz6dcvO/BACSccpa6sxhmW8xeS0B3T1x5+BU
	bxIVCrBZ6rXJ5XWsSPIptiOWTHVPpffK2tVRk/aHocFx0R34HACKtx5UbWEtFmiKkp726eeFUbI
	1Ac8M9l84O2nP+PqQddUjG1aMue5tGSTe0xa/slUzCb53uCKlf7ocRBfQsA48Ztya+V/TzY/Fxc
	/Og=
X-Received: by 2002:a05:622a:4c88:b0:477:1126:5a33 with SMTP id d75a77b69052e-48b19f8c109mr36246231cf.1.1746116695073;
        Thu, 01 May 2025 09:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyrsiz66QM/b7pQpG95b4llb/hsxXWMgTabyWI5ztMXIPQdn/CxkC0zZkqIku7CycCEzKNUA==
X-Received: by 2002:a05:622a:4c88:b0:477:1126:5a33 with SMTP id d75a77b69052e-48b19f8c109mr36245901cf.1.1746116694685;
        Thu, 01 May 2025 09:24:54 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-48b98c1a459sm5778761cf.69.2025.05.01.09.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:24:54 -0700 (PDT)
Date: Thu, 1 May 2025 12:24:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, willy@infradead.org, stable@vger.kernel.org,
	qq282012236@gmail.com, hannes@cmpxchg.org, axboe@kernel.dk
Subject: Re: +
 mm-userfaultfd-prevent-busy-looping-for-tasks-with-signals-pending.patch
 added to mm-hotfixes-unstable branch
Message-ID: <aBOgU9jJ04F1n1y4@x1.local>
References: <20250425005853.CA516C4CEE3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250425005853.CA516C4CEE3@smtp.kernel.org>

Andrew,

I suggest we drop this one from hotfixes-unstable as of now and wait for
the discussion to complete.  The hope is we could find some better
solution.  While if we merge this we may need to carry the magic bits
forever.. when there's no original reproducer (I wrote one, but it might be
different).

The issue (AFAICT) here is more perf-wise, and I doubt it happens much in
production as long-unresolved userfaults should be uncommon.  Please
correct me otherwise.

Jens, it'll be great to hear from you from the original thread.

Thanks,

On Thu, Apr 24, 2025 at 05:58:53PM -0700, Andrew Morton wrote:
> 
> The patch titled
>      Subject: mm/userfaultfd: prevent busy looping for tasks with signals pending
> has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
>      mm-userfaultfd-prevent-busy-looping-for-tasks-with-signals-pending.patch
> 
> This patch will shortly appear at
>      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-userfaultfd-prevent-busy-looping-for-tasks-with-signals-pending.patch
> 
> This patch will later appear in the mm-hotfixes-unstable branch at
>     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
> 
> The -mm tree is included into linux-next via the mm-everything
> branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> and is updated there every 2-3 working days
> 
> ------------------------------------------------------
> From: Jens Axboe <axboe@kernel.dk>
> Subject: mm/userfaultfd: prevent busy looping for tasks with signals pending
> Date: Wed, 23 Apr 2025 17:37:06 -0600
> 
> userfaultfd may use interruptible sleeps to wait on userspace filling a
> page fault, which works fine if the task can be reliably put to sleeping
> waiting for that.  However, if the task has a normal (ie non-fatal) signal
> pending, then TASK_INTERRUPTIBLE sleep will simply cause schedule() to be
> a no-op.
> 
> For a task that registers a page with userfaultfd and then proceeds to do
> a write from it, if that task also has a signal pending then it'll
> essentially busy loop from do_page_fault() -> handle_userfault() until
> that fault has been filled.  Normally it'd be expected that the task would
> sleep until that happens.  Here's a trace from an application doing just
> that:
> 
> handle_userfault+0x4b8/0xa00 (P)
> hugetlb_fault+0xe24/0x1060
> handle_mm_fault+0x2bc/0x318
> do_page_fault+0x1e8/0x6f0
> do_translation_fault+0x9c/0xd0
> do_mem_abort+0x44/0xa0
> el1_abort+0x3c/0x68
> el1h_64_sync_handler+0xd4/0x100
> el1h_64_sync+0x6c/0x70
> fault_in_readable+0x74/0x108 (P)
> iomap_file_buffered_write+0x14c/0x438
> blkdev_write_iter+0x1a8/0x340
> vfs_write+0x20c/0x348
> ksys_write+0x64/0x108
> __arm64_sys_write+0x1c/0x38
> 
> where the task is looping with 100% CPU time in the above mentioned fault
> path.
> 
> Since it's impossible to handle signals, or other conditions like
> TIF_NOTIFY_SIGNAL that also prevents interruptible sleeping, from the
> fault path, use TASK_UNINTERRUPTIBLE with a short timeout even for vmf
> modes that would normally ask for INTERRUPTIBLE or KILLABLE sleep.  Fatal
> signals will still be handled by the caller, and the timeout is short
> enough to hopefully not cause any issues.  If this is the first invocation
> of this fault, eg FAULT_FLAG_TRIED isn't set, then the normal sleep mode
> is used.
> 
> Link: https://lkml.kernel.org/r/27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk
> Fixes: 4064b9827063 ("mm: allow VM_FAULT_RETRY for multiple times")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Reported-by: Zhiwei Jiang <qq282012236@gmail.com>
> Closes: https://lore.kernel.org/io-uring/20250422162913.1242057-1-qq282012236@gmail.com/
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  fs/userfaultfd.c |   34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> --- a/fs/userfaultfd.c~mm-userfaultfd-prevent-busy-looping-for-tasks-with-signals-pending
> +++ a/fs/userfaultfd.c
> @@ -334,15 +334,29 @@ out:
>  	return ret;
>  }
>  
> -static inline unsigned int userfaultfd_get_blocking_state(unsigned int flags)
> +struct userfault_wait {
> +	unsigned int task_state;
> +	bool timeout;
> +};
> +
> +static struct userfault_wait userfaultfd_get_blocking_state(unsigned int flags)
>  {
> +	/*
> +	 * If the fault has already been tried AND there's a signal pending
> +	 * for this task, use TASK_UNINTERRUPTIBLE with a small timeout.
> +	 * This prevents busy looping where schedule() otherwise does nothing
> +	 * for TASK_INTERRUPTIBLE when the task has a signal pending.
> +	 */
> +	if ((flags & FAULT_FLAG_TRIED) && signal_pending(current))
> +		return (struct userfault_wait) { TASK_UNINTERRUPTIBLE, true };
> +
>  	if (flags & FAULT_FLAG_INTERRUPTIBLE)
> -		return TASK_INTERRUPTIBLE;
> +		return (struct userfault_wait) { TASK_INTERRUPTIBLE, false };
>  
>  	if (flags & FAULT_FLAG_KILLABLE)
> -		return TASK_KILLABLE;
> +		return (struct userfault_wait) { TASK_KILLABLE, false };
>  
> -	return TASK_UNINTERRUPTIBLE;
> +	return (struct userfault_wait) { TASK_UNINTERRUPTIBLE, false };
>  }
>  
>  /*
> @@ -368,7 +382,7 @@ vm_fault_t handle_userfault(struct vm_fa
>  	struct userfaultfd_wait_queue uwq;
>  	vm_fault_t ret = VM_FAULT_SIGBUS;
>  	bool must_wait;
> -	unsigned int blocking_state;
> +	struct userfault_wait wait_mode;
>  
>  	/*
>  	 * We don't do userfault handling for the final child pid update
> @@ -466,7 +480,7 @@ vm_fault_t handle_userfault(struct vm_fa
>  	uwq.ctx = ctx;
>  	uwq.waken = false;
>  
> -	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
> +	wait_mode = userfaultfd_get_blocking_state(vmf->flags);
>  
>          /*
>           * Take the vma lock now, in order to safely call
> @@ -488,7 +502,7 @@ vm_fault_t handle_userfault(struct vm_fa
>  	 * following the spin_unlock to happen before the list_add in
>  	 * __add_wait_queue.
>  	 */
> -	set_current_state(blocking_state);
> +	set_current_state(wait_mode.task_state);
>  	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
>  
>  	if (!is_vm_hugetlb_page(vma))
> @@ -501,7 +515,11 @@ vm_fault_t handle_userfault(struct vm_fa
>  
>  	if (likely(must_wait && !READ_ONCE(ctx->released))) {
>  		wake_up_poll(&ctx->fd_wqh, EPOLLIN);
> -		schedule();
> +		/* See comment in userfaultfd_get_blocking_state() */
> +		if (!wait_mode.timeout)
> +			schedule();
> +		else
> +			schedule_timeout(HZ / 10);
>  	}
>  
>  	__set_current_state(TASK_RUNNING);
> _
> 
> Patches currently in -mm which might be from axboe@kernel.dk are
> 
> mm-userfaultfd-prevent-busy-looping-for-tasks-with-signals-pending.patch
> 

-- 
Peter Xu


