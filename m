Return-Path: <stable+bounces-194649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA2CC54DFD
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 01:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1B53B3D0B
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 00:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EC3139D;
	Thu, 13 Nov 2025 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sIg+oKfv"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247D035959;
	Thu, 13 Nov 2025 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992270; cv=none; b=FHiWZim63nI1Ab8F0NwGz4IgInNlQSPNakN+MgfmQV0US2DG2VVjwCHqKf+Jst8QJrAIVY1pEHKW02Pwbv3jKmdKRBr0MOK74trsxh2vAqvHJ50uOEfFJMbZ0gOcdx5jQEm00p6unBhFLAgaAFIDQHNfqXbvhGDI5DlIlrvJw4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992270; c=relaxed/simple;
	bh=8gOwi2bERlyNLEUz1gEk5H7Ei+csZdzqkfeGee9p2qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+DxTJaR/8XKwclUPbQUIoBAv/E+EdZvOT0Epgpj4HkEvH0V53fUeRIHwlKlmmEiSAFR7eSrTuvRtv2D7PH6QfbCM/M6jlSq77UtC3b28y2UZ90l7plm8BD65S2W9HjPs+l5tZvu6kyYrOPmPyApcdd46B2q8J0NJ5pDJajyF4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sIg+oKfv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F4Bx1zhXwYb2SedwhCcMZJN0pYhmwiDpj/soRVcSq8c=; b=sIg+oKfvDmXebc4Lw6XgpP8sfb
	LxVwm0OsjGvejrPHAwp/c3/nFwBTRLXeqekKQAo8QS0o3Yn9gNs8ZaawuUwEwpz1Ah7OdwJVfChPo
	s88tAPabJrLsXYskvot5YHhM/9LCLI94W2K2lmcwYzZdV11Zqg35s9PPXdJyrXH8eLyhObn+srGIr
	KhLKmeMWGBLJjBIag7veDwErVy9n2q447NwdhhAT+dqA7Jlk6cF6zo6rO2QmIpHbdZMWH7QFMrtdz
	zKi4XbbB9bDuBbGiAtmMMtkjX49SAKHJSgpoAR+MxyGLSsuzOPbiWujePmP8tIB3wA2t4z2IFl4ne
	TUYG3+iQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJKp1-00000006f8w-0xdi;
	Thu, 13 Nov 2025 00:04:19 +0000
Date: Thu, 13 Nov 2025 00:04:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
	stable@vger.kernel.org,
	syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] mm/mmap_lock: Reset maple state on lock_vma_under_rcu()
 retry
Message-ID: <aRUggwAQJsnQV_07@casper.infradead.org>
References: <20251111215605.1721380-1-Liam.Howlett@oracle.com>
 <2d93af49-fd76-4b05-aee7-0b4a32b1048e@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d93af49-fd76-4b05-aee7-0b4a32b1048e@lucifer.local>

On Wed, Nov 12, 2025 at 03:06:38PM +0000, Lorenzo Stoakes wrote:
> > Any time the rcu read lock is dropped, the maple state must be
> > invalidated.  Resetting the address and state to MA_START is the safest
> > course of action, which will result in the next operation starting from
> > the top of the tree.
> 
> Since we all missed it I do wonder if we need some super clear comment
> saying 'hey if you drop + re-acquire RCU lock you MUST revalidate mas state
> by doing 'blah'.

I mean, this really isn't an RCU thing.  This is also bad:

	spin_lock(a);
	p = *q;
	spin_unlock(a);
	spin_lock(a);
	b = *p;

p could have been freed while you didn't hold lock a.  Detecting this
kind of thing needs compiler assistence (ie Rust) to let you know that
you don't have the right to do that any more.

> I think one source of confusion for me with maple tree operations is - what
> to do if we are in a position where some kind of reset is needed?
> 
> So even if I'd realised 'aha we need to reset this' it wouldn't be obvious
> to me that we ought to set to the address.

I think that's a separate problem.

> > +++ b/mm/mmap_lock.c
> > @@ -257,6 +257,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> >  		if (PTR_ERR(vma) == -EAGAIN) {
> >  			count_vm_vma_lock_event(VMA_LOCK_MISS);
> >  			/* The area was replaced with another one */
> > +			mas_set(&mas, address);
> 
> I wonder if we could detect that the RCU lock was released (+ reacquired) in
> mas_walk() in a debug mode, like CONFIG_VM_DEBUG_MAPLE_TREE?

Dropping and reacquiring the RCU read lock should have been a big red
flag.  I didn't have time to review the patches, but if I had, I would
have suggested passing the mas down to the routine that drops the rcu
read lock so it can be invalidated before dropping the readlock.


