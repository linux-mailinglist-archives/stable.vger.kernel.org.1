Return-Path: <stable+bounces-196534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E22C7AF6A
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 025684EC5D0
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703C12EDD69;
	Fri, 21 Nov 2025 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwR0dThi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19532EAB70;
	Fri, 21 Nov 2025 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743980; cv=none; b=MfWfPS6BsNuXRC7MD6hr3sPyJPc/+3A1jJUdwaYKI9lntq8XsJPRPJGe/gaKUQWiY0ncn2JmlD4/ZvkpN7eAcygP6u7zJGHVYIXUlVZfNDALlN0xX0Am//MGxs/tw5Piv/6jh+JGxhk31ibSGV5AhPwGu0S1ZAkgoX8kJWsCgMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743980; c=relaxed/simple;
	bh=/N91HXefhxeC+TjibAfhi/hv2T3f07kYP8+CY074xk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X08nvq0oRgIhW7uZpQETyL6WAhAako8r5A1bYJdjj+yaEEw79c25zcAj+DXjB3R8YVMyzTp/5uDWehR8/VNVFhFGHkMdtrbWdk3EkG29GNkZSQ47eDEktF3ZJODHQc3Mm069bAMWczFnWpQ9Hx9YAWq/FWSOv/hM64liZ6WptB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwR0dThi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55371C4CEF1;
	Fri, 21 Nov 2025 16:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763743979;
	bh=/N91HXefhxeC+TjibAfhi/hv2T3f07kYP8+CY074xk8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CwR0dThikFIafNMG35RxTBg/8KUFTGPmhKlmYXRNaUGj2yXcRYCV3v1uSFXTkjtAk
	 PRDtKBcFAXgbG91NiCta34y1ZkSnjhNFH8OXuYA3nFMt8QwuQ4UYT6EXiYF6evBTO3
	 zMleIxvRKih4ylPzjiWSpt3DNC/9/D6qRaL97vop7SJGpz+JJkhPHQowSh8ihiQVFc
	 +lgZjrjElyHY2l5dul1xkXcXtNkrr3wc7uMDiA19qgG1zvGK+8rJB8Qv14TyPyBo/d
	 MdGh2gMmfm+9JiXKKkZnbnlVgR9+faOr239I/hQVobOBFZ/CrXkmXe1s+bpxNtR+t8
	 eIxvWWjguSakw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D85F0CE0B6A; Fri, 21 Nov 2025 08:52:58 -0800 (PST)
Date: Fri, 21 Nov 2025 08:52:58 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
	stable@vger.kernel.org,
	syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/mmap_lock: Reset maple state on lock_vma_under_rcu()
 retry
Message-ID: <9df24d5f-99bf-4d8e-8761-dd5dd65e4c76@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251111215605.1721380-1-Liam.Howlett@oracle.com>
 <2d93af49-fd76-4b05-aee7-0b4a32b1048e@lucifer.local>
 <aRUggwAQJsnQV_07@casper.infradead.org>
 <d9e181fe-e3d8-427a-8323-ea979f5a02ad@paulmck-laptop>
 <f7abdb4c-b7e2-4fe4-9198-f313d0cacacb@lucifer.local>
 <18ae4b82-b18a-4ed8-8b72-4a9697a4dc8f@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18ae4b82-b18a-4ed8-8b72-4a9697a4dc8f@suse.cz>

On Fri, Nov 21, 2025 at 10:08:19AM +0100, Vlastimil Babka wrote:
> (sorry for the late reply)

And me for missing this!

> On 11/13/25 12:05, Lorenzo Stoakes wrote:
> >> > > I think one source of confusion for me with maple tree operations is - what
> >> > > to do if we are in a position where some kind of reset is needed?
> >> > >
> >> > > So even if I'd realised 'aha we need to reset this' it wouldn't be obvious
> >> > > to me that we ought to set to the address.
> >> >
> >> > I think that's a separate problem.
> >> >
> >> > > > +++ b/mm/mmap_lock.c
> >> > > > @@ -257,6 +257,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> >> > > >  		if (PTR_ERR(vma) == -EAGAIN) {
> >> > > >  			count_vm_vma_lock_event(VMA_LOCK_MISS);
> >> > > >  			/* The area was replaced with another one */
> >> > > > +			mas_set(&mas, address);
> >> > >
> >> > > I wonder if we could detect that the RCU lock was released (+ reacquired) in
> >> > > mas_walk() in a debug mode, like CONFIG_VM_DEBUG_MAPLE_TREE?
> >> >
> >> > Dropping and reacquiring the RCU read lock should have been a big red
> >> > flag.  I didn't have time to review the patches, but if I had, I would
> >> > have suggested passing the mas down to the routine that drops the rcu
> >> > read lock so it can be invalidated before dropping the readlock.
> >>
> >> There has been some academic efforts to check for RCU-protected pointers
> >> leaking from one RCU read-side critical section to another, but nothing
> >> useful has come from this.  :-/
> > 
> > Ugh a pity. I was hoping we could do (in debug mode only obv) something
> > absolutely roughly like:
> > 
> > On init:
> > 
> > mas->rcu_critical_section = rcu_get_critical_section_blah();
> 
> AFAICT, get_state_synchronize_rcu()?

This would get a grace-period counter, and I believe that Lorenzo wants
a per-task count of RCU read-side critical sections.  In theory, this
is easy, but it does add overhead.  And in practice, there are a lot
of different types of RCU readers, and keeping them all straight would
be quite challenging.  But if you only care about a debug-only facility
for preemptible RCU's rcu_read_lock() and rcu_read_unlock(), something
could be done.

Besides, I didn't understand what Vlastimil was getting at...

> > ...
> > 
> > On walk:
> > 
> > 	VM_WARN_ON(rcu_critical_section_blah() != mas->rcu_critical_section);
> 
> And here, poll_state_synchronize_rcu()?
> 
> It wouldn't detect directly that we dropped and reacquired the rcu read
> lock, but with enough testing, that would at some point translate to a new
> grace period between the first and second read lock, and we'd catch it then?

Ah, good point.  And CONFIG_RCU_STRICT_GRACE_PERIOD=y would make it more
likely to happen.  As would booting with rcupdate.rcu_expedited=1.

> > But sounds like that isn't feasible.
> I don't think what Paul says means your suggestion is not feasible. I think
> he says there are no known ways to do this checking automagicallt. But your
> suggestion is doing it manually for a specific case. I guess it depends on
> how many maple tree functions we'd have to change and how ugly it would be.

All good points!

							Thanx, Paul

> > I always like the idea of us having debug stuff that helps highlight dumb
> > mistakes very quickly, no matter how silly they might be :)
> > 
> >>
> >> But rcu_pointer_handoff() and unrcu_pointer() are intended not only for
> >> documentation, but also to suppress the inevitable false positives should
> >> anyone figure out how to detect leaking of RCU-protected pointers.
> >>
> >> 							Thanx, Paul
> > 
> > Cheers, Lorenzo
> 

