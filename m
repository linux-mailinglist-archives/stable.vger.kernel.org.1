Return-Path: <stable+bounces-198174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6FFC9E2AB
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 09:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBAD54E103C
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 08:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C1D22B594;
	Wed,  3 Dec 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jUPrYhaY"
X-Original-To: stable@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD5214204;
	Wed,  3 Dec 2025 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764749849; cv=none; b=hG3LHyAUB00vl23ZHnxvMTeu0RPHQ8+HwaUOkguHngXn3VCK1MOvSQpYsa5hE+9u6TwHFCfYdcryah5Gs4o0/rC2QdZKi4u1J9N6Voumotn9O4bPDSbRAwqAINLCmdlfuO4PHOG2wI3//KzbijZJGyjAyIStGg61iF+J5apVk4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764749849; c=relaxed/simple;
	bh=mvFuhMD54i7/xxkNa7kVr8dfwPQ5KcDNvwjJAfRBj28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6ySoRfmYyARg3SfouDDricc3xTLX9ddYhmQkrk5hzd6ieA1Q/G7uUL5gukepzUEQ9MgI6HarJk3yK+DYH1aW4BcuhgO9bgqkGcXxUBsF76rrtgHgYvbCHgGXjdgG0kw5EPMmekRT5sGuWU4iNkEylhzvJTjWhU/5PkFpfhpIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jUPrYhaY; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764749837; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=S8fvIMewKMZCC3x/STpt5BFZ1WcxOgScYNM9rzC9VGE=;
	b=jUPrYhaYEKnTqXTaNnNZy+H3JG/jPuENmpCV9LZKvGg8cCw/h1y8A2lqN0HryBWYP755Bf10mXFB890TOQ7NzzIwBdbk64ejviHSHvv/Ax2wNy03ZEeVVpUduis/C1yVafNdksASnIvgcFGX+0gdXjMNMrt8YTycllTgjE82OZ4=
Received: from localhost(mailfrom:peng_wang@linux.alibaba.com fp:SMTPD_---0Wu-brGT_1764749835 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Dec 2025 16:17:16 +0800
Date: Wed, 3 Dec 2025 16:17:15 +0800
From: Peng Wang <peng_wang@linux.alibaba.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: bsegall@google.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org, stable@vger.kernel.org,
	vdavydov.dev@gmail.com, vschneid@redhat.com
Subject: Re: [PATCH v3] sched/fair: Clear ->h_load_next when unregistering
 cgroup
Message-ID: <aS_yC_smGTS-_JbK@U-N9MN20RF-1935.local>
Reply-To: Peng Wang <peng_wang@linux.alibaba.com>
References: <CAKfTPtC-L3R6iYA=boxQGKVafC_UhBihYq6n6qTJ6hk4Q76OZg@mail.gmail.com>
 <bf93d41ff9f2da19ef2c1cfb505362e0b48c39de.1761290330.git.peng_wang@linux.alibaba.com>
 <CAKfTPtBMVkCVCSMN2ztpA=kje-BoNFt=bK44_zdkMeAPfNMdqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtBMVkCVCSMN2ztpA=kje-BoNFt=bK44_zdkMeAPfNMdqA@mail.gmail.com>

On Fri, Oct 24, 2025 at 09:52:59AM +0200, Vincent Guittot wrote:
> On Fri, 24 Oct 2025 at 09:24, Peng Wang <peng_wang@linux.alibaba.com> wrote:
> >
> > An invalid pointer dereference bug was reported on arm64 cpu, and has
> > not yet been seen on x86. A partial oops looks like:
> >
> >  Call trace:
> >   update_cfs_rq_h_load+0x80/0xb0
> >   wake_affine+0x158/0x168
> >   select_task_rq_fair+0x364/0x3a8
> >   try_to_wake_up+0x154/0x648
> >   wake_up_q+0x68/0xd0
> >   futex_wake_op+0x280/0x4c8
> >   do_futex+0x198/0x1c0
> >   __arm64_sys_futex+0x11c/0x198
> >
> > Link: https://lore.kernel.org/all/20251013071820.1531295-1-CruzZhao@linux.alibaba.com/
> >
> > We found that the task_group corresponding to the problematic se
> > is not in the parent task_group¡¯s children list, indicating that
> > h_load_next points to an invalid address. Consider the following
> > cgroup and task hierarchy:
> >
> >          A
> >         / \
> >        /   \
> >       B     E
> >      / \    |
> >     /   \   t2
> >    C     D
> >    |     |
> >    t0    t1
> >
> > Here follows a timing sequence that may be responsible for triggering
> > the problem:
> >
> > CPU X                   CPU Y                   CPU Z
> > wakeup t0
> > set list A->B->C
> > traverse A->B->C
> > t0 exits
> > destroy C
> >                         wakeup t2
> >                         set list A->E           wakeup t1
> >                                                 set list A->B->D
> >                         traverse A->B->C
> >                         panic
> >
> > CPU Z sets ->h_load_next list to A->B->D, but due to arm64 weaker memory
> > ordering, Y may observe A->B before it sees B->D, then in this time window,
> > it can traverse A->B->C and reach an invalid se.
> >
> > We can avoid stale pointer accesses by clearing ->h_load_next when
> > unregistering cgroup.
> >
> > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Fixes: 685207963be9 ("sched: Move h_load calculation to task_h_load()")
> > Cc: <stable@vger.kernel.org>
> > Co-developed-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> > Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> > Signed-off-by: Peng Wang <peng_wang@linux.alibaba.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Gentle Ping

Hi, Peter and Vincent,

after applying this patch, update_cfs_rq_h_load crashing has not occurred for the past two weeks.
The patch has proven to be effective. Would you consider merging it?

> 
> > ---
> >  kernel/sched/fair.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index cee1793e8277..32b466605925 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -13418,6 +13418,8 @@ void unregister_fair_sched_group(struct task_group *tg)
> >                 struct rq *rq = cpu_rq(cpu);
> >
> >                 if (se) {
> > +                       struct cfs_rq *parent_cfs_rq = cfs_rq_of(se);
> > +
> >                         if (se->sched_delayed) {
> >                                 guard(rq_lock_irqsave)(rq);
> >                                 if (se->sched_delayed) {
> > @@ -13427,6 +13429,13 @@ void unregister_fair_sched_group(struct task_group *tg)
> >                                 list_del_leaf_cfs_rq(cfs_rq);
> >                         }
> >                         remove_entity_load_avg(se);
> > +
> > +                       /*
> > +                        * Clear parent's h_load_next if it points to the
> > +                        * sched_entity being freed to avoid stale pointer.
> > +                        */
> > +                       if (READ_ONCE(parent_cfs_rq->h_load_next) == se)
> > +                               WRITE_ONCE(parent_cfs_rq->h_load_next, NULL);
> >                 }
> >
> >                 /*
> > --
> > 2.27.0
> >

