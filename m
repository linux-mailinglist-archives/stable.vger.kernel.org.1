Return-Path: <stable+bounces-124136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A5EA5D9C2
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 10:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16F9176B27
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 09:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1630723AE8D;
	Wed, 12 Mar 2025 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISrhHIqw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F8915820C
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772564; cv=none; b=a9zQCPF3OwtdfxHk8qmcjOv327q/rkTHWnuHkZKzsbCSg6adOMse+FOQgUWttAAAeNZEOiaWzCgoWbRddhbAwMiWLBDvJ/2junn8d944utt3lLtJ3yWO55YIPzkMgCNgkzy2sYXGFZ/c/hT4dRscAy7Yp21qYTniFNRNzcXeypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772564; c=relaxed/simple;
	bh=9BHi7R0N1e0m6MI3+SIcypO7xwKr1WoHcHLF3jQDUW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXK08TiBe3VdcEIRO7xf4n+nPY/+OK+k5dFq1meoS0ju/zGLAdFmvuCjPwA0AKVW4q6UrTDXxYUUi14BbgIgvEnHIfSCJLHNuWaHUtEfbmnCc0bOuieszbm9ktFja+YkFLZfkDYxwvJ2+EzNoW40ROtDs4EaQlnuilZxz7AqmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISrhHIqw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741772561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pFXifyzyx3TlWsPdUelbYNzLeb+XPxEQGzXrwyDafsQ=;
	b=ISrhHIqwpj04gqbih1dVQnAl01vf7yVF5PGASxhAhPr8imE6ZLdDZ5hDifHmJz3u63o/rP
	DqP9q3GxJ583chMHqWEmdpFtXOo6TWBK3b5NIKXekNlqSCaoRrQQctbkkjWL86dEUXbpDp
	xsx1jnfQ7typtvwq34ptB7Ao1AJvDIA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-kbxyOEFjOs6zsa0RQKR9_Q-1; Wed, 12 Mar 2025 05:42:40 -0400
X-MC-Unique: kbxyOEFjOs6zsa0RQKR9_Q-1
X-Mimecast-MFC-AGG-ID: kbxyOEFjOs6zsa0RQKR9_Q_1741772559
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so18578625e9.3
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 02:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741772559; x=1742377359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFXifyzyx3TlWsPdUelbYNzLeb+XPxEQGzXrwyDafsQ=;
        b=tFSNCa/39tsGWvRSJ6T69Aj7pg07/xAwLDiE3lx0FcC6aH7Z4fn5DhHdCGf8rJGfY6
         QZMr4ZlSMvNuinuYGu18cN9lZ/Eofi6JGKo4Pni5YZKRZ8N5Wpjzxum640Ujd7KpUcfa
         ZF2xft0o9ee/U5htPnX/sf0s+n/FQSI5yp8/VupNwazvSByYgO/qKMrWA5/Ogh2KRkAp
         vIlV7DFagPyEAu/tvIXAuhVaDct6wJabZQRcDVUDeX2pb5bG07hkoIn1QNh7Szf/20Co
         h6MAQhmy51tNk3wcgXAkpQL3/jTLY0QeQd5auBMmiHpHjiSiCwHJ/ZqF8s6KfCgRUIaw
         eDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCURw5caqfCUB6CEkih51e0UGjtpWwiWTP4Tj8z6hvj5/7aRNmwwMueJOYk3ibxVwxor/B/UYXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynZoYoQdxlJzPOHWAigwN7Z911yVb9gJwj4ru/MWdLdxRIZAM7
	5inqDYuSjLR5Pl593EiI8gzzCPUpHGu/8jf2HbSCnmLFoIDCoIb3x47mgZLxEoaExY5lJv2Guep
	/NGaJK0ERtpxbUSt6wlv8MjrRC9j0/GgShl2PrxmI1cJvJLTUZP4pSg==
X-Gm-Gg: ASbGnctobL7L941tD3ou1FQYsGSMI/N771ecerlqjlJ+1Pb5ubjwlZOhwzns8RLkn9c
	mZL+DzQ8h5A0yLecSIrax6wIlG8HOwHZhJWRjC/9wl225IpTqzxhdzkfgrJ/LnSer8rHTIzPcOR
	+hVf+lU+lSS9NWhiVQG2RQS7aIzQFdqjYmWYB6WrGQIACGSbHwZOzzLeCQXZosg/i9LodPL+oFV
	WTtRdmshjTpUmFqxubdy+QYVafU0nXWS0BLxCxqVH19l9n4pX0qiYnEwH5wwIgKrq00La6tuTeq
	2V4kSXKYeIqCJsk/YldbII9jE0qMba8NE4fReFxgIE4=
X-Received: by 2002:a05:600c:1548:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-43d01bdbc0cmr60348285e9.9.1741772559298;
        Wed, 12 Mar 2025 02:42:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIyoWUS2iyHpblJuK/FyfuGkvyqkX/245cGSIo/CYaKp2qCmaR23bGtQM/hs3jXJSEjN8Q1g==
X-Received: by 2002:a05:600c:1548:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-43d01bdbc0cmr60348045e9.9.1741772558886;
        Wed, 12 Mar 2025 02:42:38 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c101febsm20045598f8f.81.2025.03.12.02.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 02:42:38 -0700 (PDT)
Date: Wed, 12 Mar 2025 10:42:35 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix race in push_dl_task
Message-ID: <Z9FXC7NMaGxJ6ai6@jlelli-thinkpadt14gen4.remote.csb>
References: <20250307204255.60640-1-harshit@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307204255.60640-1-harshit@nutanix.com>

Hi Harshit,

Thanks for this!

On 07/03/25 20:42, Harshit Agarwal wrote:
> This fix is the deadline version of the change made to the rt scheduler
> here:
> https://lore.kernel.org/lkml/20250225180553.167995-1-harshit@nutanix.com/
> Please go through the original change for more details on the issue.

I don't think we want this kind of URLs in the changelog, as URL might
disappear while the history remains (at least usually a little longer
:). Maybe you could add a very condensed version of the description of
the problem you have on the other fix?
 
> In this fix we bail out or retry in the push_dl_task, if the task is no
> longer at the head of pushable tasks list because this list changed
> while trying to lock the runqueue of the other CPU.
> 
> Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
> Cc: stable@vger.kernel.org
> ---
>  kernel/sched/deadline.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 38e4537790af..c5048969c640 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2704,6 +2704,7 @@ static int push_dl_task(struct rq *rq)
>  {
>  	struct task_struct *next_task;
>  	struct rq *later_rq;
> +	struct task_struct *task;
>  	int ret = 0;
>  
>  	next_task = pick_next_pushable_dl_task(rq);
> @@ -2734,15 +2735,30 @@ static int push_dl_task(struct rq *rq)
>  
>  	/* Will lock the rq it'll find */
>  	later_rq = find_lock_later_rq(next_task, rq);
> -	if (!later_rq) {
> -		struct task_struct *task;
> +	task = pick_next_pushable_dl_task(rq);
> +	if (later_rq && (!task || task != next_task)) {
> +		/*
> +		 * We must check all this again, since
> +		 * find_lock_later_rq releases rq->lock and it is
> +		 * then possible that next_task has migrated and
> +		 * is no longer at the head of the pushable list.
> +		 */
> +		double_unlock_balance(rq, later_rq);
> +		if (!task) {
> +			/* No more tasks */
> +			goto out;
> +		}
>  
> +		put_task_struct(next_task);
> +		next_task = task;
> +		goto retry;

I fear we might hit a pathological condition that can lead us into a
never ending (or very long) loop. find_lock_later_rq() tries to find a
later_rq for at most DL_MAX_TRIES and it bails out if it can't.

Maybe to discern between find_lock_later_rq() callers we can use
dl_throttled flag in dl_se and still implement the fix in find_lock_
later_rq()? I.e., fix similar to the rt.c patch in case the task is not
throttled (so caller is push_dl_task()) and not rely on pick_next_
pushable_dl_task() if the task is throttled.

What do you think?

Thanks,
Juri


