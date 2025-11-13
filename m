Return-Path: <stable+bounces-194650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B3478C55409
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 02:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D0E5344A81
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 01:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279FA26C3AE;
	Thu, 13 Nov 2025 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9EZH2it"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7091B2673BA;
	Thu, 13 Nov 2025 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762997243; cv=none; b=E3mgLQgw4E9KP5y3Cayy6ILSl0sQDdq0u4GPRSC4S0K+WZ+69g2G01jJG3oMsk78J6YVPGWy/HY00DSrE+2ps6IgmSlK9qO6+bHBNxGLMR8GVy7Rm6EpFMWlcPCGqJmueThu+Pios4Swk9/8G74IiduxswKnkmpNYjYsu3BT5bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762997243; c=relaxed/simple;
	bh=TF5Nr0Z6ILPUdtsJnj/5x/ih/OKOmW3hFeReBsHZthk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1wgW7ph1I7bxIBxyWxDZn4cKX4LGHUursQn6NawFGMmxVQZ08KfwjcqK0SPt2XQUGEbD6vG0IuR6v8VqTpevyyo18UrC2HW4m3YL8i8NqLem0M/Ev99doe8kfYGfAWQQy+jSqfRC2wbTKcr7aYcC6qf4jE7hZGdYkEFWam0o0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9EZH2it; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E905BC4AF0B;
	Thu, 13 Nov 2025 01:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762997243;
	bh=TF5Nr0Z6ILPUdtsJnj/5x/ih/OKOmW3hFeReBsHZthk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=j9EZH2itZecujLn0J/BBW/POwZhnFbrrB7plrJIULMFOn289/jDaE6KBDiy8QUOII
	 ncfIj4xIPZJNS2b2G52A6EF7rfMYg2wUB1sCWY9CGd199fQcSpBu60OdPVwm9WL5/z
	 fpsZS5sTaPyuGt6y8ul+eVQrvOWPFUsAjDeLuTeGXHI7MewSLhMxIET9AjEYh1Tl2Z
	 cv7RTUNLtfaT+EEtsWEdyyxnfQaudACiQMZEzx1dvAgB2aRGPlwujPcWZW3x+dS2va
	 kD2YZ3HmtwaynqlRFn0Sf2RsDvKxiXqu0T0z1OKJfiK6icIGMsOaqyciq1hvzYPYLZ
	 UmfN5Cwn5vszg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 631BFCE0876; Wed, 12 Nov 2025 17:27:22 -0800 (PST)
Date: Wed, 12 Nov 2025 17:27:22 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
	stable@vger.kernel.org,
	syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/mmap_lock: Reset maple state on lock_vma_under_rcu()
 retry
Message-ID: <d9e181fe-e3d8-427a-8323-ea979f5a02ad@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251111215605.1721380-1-Liam.Howlett@oracle.com>
 <2d93af49-fd76-4b05-aee7-0b4a32b1048e@lucifer.local>
 <aRUggwAQJsnQV_07@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRUggwAQJsnQV_07@casper.infradead.org>

On Thu, Nov 13, 2025 at 12:04:19AM +0000, Matthew Wilcox wrote:
> On Wed, Nov 12, 2025 at 03:06:38PM +0000, Lorenzo Stoakes wrote:
> > > Any time the rcu read lock is dropped, the maple state must be
> > > invalidated.  Resetting the address and state to MA_START is the safest
> > > course of action, which will result in the next operation starting from
> > > the top of the tree.
> > 
> > Since we all missed it I do wonder if we need some super clear comment
> > saying 'hey if you drop + re-acquire RCU lock you MUST revalidate mas state
> > by doing 'blah'.
> 
> I mean, this really isn't an RCU thing.  This is also bad:
> 
> 	spin_lock(a);
> 	p = *q;
> 	spin_unlock(a);
> 	spin_lock(a);
> 	b = *p;
> 
> p could have been freed while you didn't hold lock a.  Detecting this
> kind of thing needs compiler assistence (ie Rust) to let you know that
> you don't have the right to do that any more.

While in no way denigrating Rust's compile-time detection of this sort
of thing, use of KASAN combined with CONFIG_RCU_STRICT_GRACE_PERIOD=y
(which restricts you to four CPUs) can sometimes help.

> > I think one source of confusion for me with maple tree operations is - what
> > to do if we are in a position where some kind of reset is needed?
> > 
> > So even if I'd realised 'aha we need to reset this' it wouldn't be obvious
> > to me that we ought to set to the address.
> 
> I think that's a separate problem.
> 
> > > +++ b/mm/mmap_lock.c
> > > @@ -257,6 +257,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > >  		if (PTR_ERR(vma) == -EAGAIN) {
> > >  			count_vm_vma_lock_event(VMA_LOCK_MISS);
> > >  			/* The area was replaced with another one */
> > > +			mas_set(&mas, address);
> > 
> > I wonder if we could detect that the RCU lock was released (+ reacquired) in
> > mas_walk() in a debug mode, like CONFIG_VM_DEBUG_MAPLE_TREE?
> 
> Dropping and reacquiring the RCU read lock should have been a big red
> flag.  I didn't have time to review the patches, but if I had, I would
> have suggested passing the mas down to the routine that drops the rcu
> read lock so it can be invalidated before dropping the readlock.

There has been some academic efforts to check for RCU-protected pointers
leaking from one RCU read-side critical section to another, but nothing
useful has come from this.  :-/

But rcu_pointer_handoff() and unrcu_pointer() are intended not only for
documentation, but also to suppress the inevitable false positives should
anyone figure out how to detect leaking of RCU-protected pointers.

							Thanx, Paul

