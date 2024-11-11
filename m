Return-Path: <stable+bounces-92170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59859C48C3
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 23:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 388BDB251E9
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 21:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE591BA272;
	Mon, 11 Nov 2024 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io5miDFT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3944638F83;
	Mon, 11 Nov 2024 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362074; cv=none; b=Em8kqOo11c5HoUkkiKMp1Y59zUPQ+YEGzQTzUhs6iKTGHjyOuCLYWyDOEkJmtUjpNHIBKPHsq31bn25RDzVWSh8BnnscHA83fu8E2ejXCx2nZ09Y9YSs9IYZEijcEErM9wx8eB5Sw2fFv164YnU6EZ+FHZe9BHOVdNM2B52NK5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362074; c=relaxed/simple;
	bh=GeEOpknn2g8B/jcqak5KC6c+DyBxdoY4g1+LKLSK8I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWxppCJGYg5+MKraSAf6n++523sk9EcfcX7rVae3tV6CnKQrmFni1zUqSdYSSW1++tfFDBFibjaqmyxtDmocFirHojoMcT/PaNRcPIEzt+k1pI2cDYbKwKOjZqNFxfK4RZy5kL+QiTjkvsFZfkvGjY02Z7unipTnmG58unk92iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io5miDFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB7CC4CECF;
	Mon, 11 Nov 2024 21:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731362073;
	bh=GeEOpknn2g8B/jcqak5KC6c+DyBxdoY4g1+LKLSK8I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=io5miDFTkppzvNl4mKUAy52FHdl44PjMSxklknmg9itmupyCWPRw1sgEne/qNT8gv
	 YhhZ3xS1g7TvNrrfLchRk07NaRI9SZh1Brgn2m3nmRN/0jVZFomXxU+0mcaS7YCYJV
	 D9pM3tbEGEARToRH9jx9zzA/BoD08OC33ZEiIUOVB2T2Ey4M7jFJCM9Ux6S28LhcyE
	 stz/WzSNMT0lVUO+0nGQjMhtBLynj/Fo8pPDed+/dsrhcbUSj8UislQGx89+ilzLBO
	 AC339qXXZXgbw34Go+NjYVAjc/HlIEYYsNzjYX/GolCKOwgAucb3qc4C1bYYnCWabP
	 KQPMKOiSeer8g==
Date: Mon, 11 Nov 2024 22:54:30 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	bsegall@google.com, Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER
 on clone" failed to apply to v4.19-stable tree
Message-ID: <ZzJ9Fr-dV7lCG8m9@pavilion.home>
References: <20241106021416.184155-1-sashal@kernel.org>
 <ZyyVHAwmFIyTc3rR@pavilion.home>
 <2024110957-anaconda-papaya-2f0a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024110957-anaconda-papaya-2f0a@gregkh>

Hi Greg,

Le Sat, Nov 09, 2024 at 03:54:09PM +0100, Greg KH a écrit :
> On Thu, Nov 07, 2024 at 11:23:24AM +0100, Frederic Weisbecker wrote:
> > Le Tue, Nov 05, 2024 at 09:14:15PM -0500, Sasha Levin a écrit :
> > > The patch below does not apply to the v4.19-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > > 
> > > Thanks,
> > > Sasha
> > 
> > Please try this:
> > 
> > ---
> > >From ee0d95090203b7ee4cb1f29c586cd7d0dbf79fff Mon Sep 17 00:00:00 2001
> > From: Benjamin Segall <bsegall@google.com>
> > Date: Fri, 25 Oct 2024 18:35:35 -0700
> > Subject: [PATCH] posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER on clone
> > 
> > When cloning a new thread, its posix_cputimers are not inherited, and
> > are cleared by posix_cputimers_init(). However, this does not clear the
> > tick dependency it creates in tsk->tick_dep_mask, and the handler does
> > not reach the code to clear the dependency if there were no timers to
> > begin with.
> > 
> > Thus if a thread has a cputimer running before clone/fork, all
> > descendants will prevent nohz_full unless they create a cputimer of
> > their own.
> > 
> > Fix this by entirely clearing the tick_dep_mask in copy_process().
> > (There is currently no inherited state that needs a tick dependency)
> > 
> > Process-wide timers do not have this problem because fork does not copy
> > signal_struct as a baseline, it creates one from scratch.
> > 
> > Fixes: b78783000d5c ("posix-cpu-timers: Migrate to use new tick dependency mask model")
> > Signed-off-by: Ben Segall <bsegall@google.com>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/all/xm26o737bq8o.fsf@google.com
> > ---
> >  include/linux/tick.h | 8 ++++++++
> >  kernel/fork.c        | 2 ++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > index 443726085f6c..832381b812c2 100644
> > --- a/include/linux/tick.h
> > +++ b/include/linux/tick.h
> > @@ -233,12 +233,19 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
> >  	if (tick_nohz_full_enabled())
> >  		tick_nohz_dep_set_task(tsk, bit);
> >  }
> > +
> >  static inline void tick_dep_clear_task(struct task_struct *tsk,
> >  				       enum tick_dep_bits bit)
> >  {
> >  	if (tick_nohz_full_enabled())
> >  		tick_nohz_dep_clear_task(tsk, bit);
> >  }
> > +
> > +static inline void tick_dep_init_task(struct task_struct *tsk)
> > +{
> > +	atomic_set(&tsk->tick_dep_mask, 0);
> > +}
> > +
> >  static inline void tick_dep_set_signal(struct signal_struct *signal,
> >  				       enum tick_dep_bits bit)
> >  {
> > @@ -272,6 +279,7 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
> >  				     enum tick_dep_bits bit) { }
> >  static inline void tick_dep_clear_task(struct task_struct *tsk,
> >  				       enum tick_dep_bits bit) { }
> > +static inline void tick_dep_init_task(struct task_struct *tsk) { }
> >  static inline void tick_dep_set_signal(struct signal_struct *signal,
> >  				       enum tick_dep_bits bit) { }
> >  static inline void tick_dep_clear_signal(struct signal_struct *signal,
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index b65871600507..1fb06d8952bc 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -91,6 +91,7 @@
> >  #include <linux/kcov.h>
> >  #include <linux/livepatch.h>
> >  #include <linux/thread_info.h>
> > +#include <linux/tick.h>
> >  
> >  #include <asm/pgtable.h>
> >  #include <asm/pgalloc.h>
> > @@ -1829,6 +1830,7 @@ static __latent_entropy struct task_struct *copy_process(
> >  	acct_clear_integrals(p);
> >  
> >  	posix_cpu_timers_init(p);
> > +	tick_dep_init_task(p);
> >  
> >  	p->io_context = NULL;
> >  	audit_set_context(p, NULL);
> > -- 
> > 2.46.0
> > 
> > 
> 
> What is the git id of this in Linus's tree?

b5413156bad9 (posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER on clone)

Thanks.

> 
> thanks,
> 
> greg k-h

