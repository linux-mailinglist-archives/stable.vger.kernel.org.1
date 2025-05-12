Return-Path: <stable+bounces-143129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD00BAB30CC
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 09:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609A5178F95
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 07:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DAC25743F;
	Mon, 12 May 2025 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V338euP/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1384F257435;
	Mon, 12 May 2025 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036388; cv=none; b=ctE8pSi20k9T1puXaUVQdM7pzGcjhiHj+zSwrsYIFo3Zem3k8TDin1iZDQ3jk0gLYDQCmng7600tdzzUI8i4No9E+oR23FCXXuvpEFBAB79tt+FT5L/Xkeqq9I3ji4XInAf95DwTahjGlNgmX2UVYK6OwCe8aVbiEOvXBI8nNi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036388; c=relaxed/simple;
	bh=kaPdMQmvI0OcpmxDBbnOuJ9l3w5mYws0sagA0l1tM8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cv8mBhCI9w4eKXGnBAVULuEbu+2NOEKy1XXDJRXElJefTpEaaWmKwVm6Fuce9YPVojqb4G2ZuuAX2REdwnuJBSTpY+yzJPcc1KCHPzEPtVkJwSWZp5b7kJuEdxMRnb6cVPz6kwDNJS37bf1TvUi4CjdAdS16/KUrp5uwuZc1AmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V338euP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E49C4CEE7;
	Mon, 12 May 2025 07:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747036387;
	bh=kaPdMQmvI0OcpmxDBbnOuJ9l3w5mYws0sagA0l1tM8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V338euP/XGLdmKiwUuhGjLHXyrSkGKp7ge20Wz/Q/OWMuoLue7aksG9QYcC3+9LfG
	 rYRAQ50eb5bEBxJq6ZLHZua01KAymVym9GkXIdNpNhCVJlsvQYTc6dAkgzrB/sgE4T
	 ubBpMiiZ0641Pht6DqPkNTPbvve9joA+LhFbyEnakTVDkRTOhORG/f2jDedrF/EdIK
	 eDWBrIFXtKJLzOnk6DFZq0GN5VDbNA68DM1cC3Rgi7EyI4ZrIbiXdMj4tKjWdHoYic
	 k2hRd4X5ePkRMvs2V0mHIZbBH1yP8XoKYNw5rE7rFbQejDKikF0JLkBNYy1+KySIr/
	 tPHBQJycaL1sg==
Date: Mon, 12 May 2025 08:53:02 +0100
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>,
	kuni1840@gmail.com, llfamsec@gmail.com, netdev@vger.kernel.org,
	sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH stable 5.15/6.1/6.6] af_unix: Clear oob_skb in
 scan_inflight().
Message-ID: <20250512075302.GA3644468@google.com>
References: <2025030543-banker-impale-9c08@gregkh>
 <20250305181050.17199-1-kuniyu@amazon.com>
 <2025030533-craving-hunk-afa3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025030533-craving-hunk-afa3@gregkh>

On Wed, 05 Mar 2025, Greg KH wrote:

> On Wed, Mar 05, 2025 at 10:10:41AM -0800, Kuniyuki Iwashima wrote:
> > +Paolo
> > 
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Date: Wed, 5 Mar 2025 15:08:26 +0100
> > > On Mon, Mar 03, 2025 at 07:01:49PM -0800, Kuniyuki Iwashima wrote:
> > > > Embryo socket is not queued in gc_candidates, so we can't drop
> > > > a reference held by its oob_skb.
> > > > 
> > > > Let's say we create listener and embryo sockets, send the
> > > > listener's fd to the embryo as OOB data, and close() them
> > > > without recv()ing the OOB data.
> > > > 
> > > > There is a self-reference cycle like
> > > > 
> > > >   listener -> embryo.oob_skb -> listener
> > > > 
> > > > , so this must be cleaned up by GC.  Otherwise, the listener's
> > > > refcnt is not released and sockets are leaked:
> > > > 
> > > >   # unshare -n
> > > >   # cat /proc/net/protocols | grep UNIX-STREAM
> > > >   UNIX-STREAM 1024      0      -1   NI       0   yes  kernel ...
> > > > 
> > > >   # python3
> > > >   >>> from array import array
> > > >   >>> from socket import *
> > > >   >>>
> > > >   >>> s = socket(AF_UNIX, SOCK_STREAM)
> > > >   >>> s.bind('\0test\0')
> > > >   >>> s.listen()
> > > >   >>>
> > > >   >>> c = socket(AF_UNIX, SOCK_STREAM)
> > > >   >>> c.connect(s.getsockname())
> > > >   >>> c.sendmsg([b'x'], [(SOL_SOCKET, SCM_RIGHTS, array('i', [s.fileno()]))], MSG_OOB)
> > > >   1
> > > >   >>> quit()
> > > > 
> > > >   # cat /proc/net/protocols | grep UNIX-STREAM
> > > >   UNIX-STREAM 1024      3      -1   NI       0   yes  kernel ...
> > > >                         ^^^
> > > >                         3 sockets still in use after FDs are close()d
> > > > 
> > > > Let's drop the embryo socket's oob_skb ref in scan_inflight().
> > > > 
> > > > This also fixes a racy access to oob_skb that commit 9841991a446c
> > > > ("af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue
> > > > lock.") fixed for the new Tarjan's algo-based GC.
> > > > 
> > > > Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> > > > Reported-by: Lei Lu <llfamsec@gmail.com>
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > ---
> > > > This has no upstream commit because I replaced the entire GC in
> > > > 6.10 and the new GC does not have this bug, and this fix is only
> > > > applicable to the old GC (<= 6.9), thus for 5.15/6.1/6.6.
> > > 
> > > You need to get the networking maintainers to review and agree that this
> > > is ok for us to take, as we really don't want to take "custom" stuff
> > > like thi s at all.
> > 
> > Paolo, could you take a look at this patch ?
> > https://lore.kernel.org/netdev/20250304030149.82265-1-kuniyu@amazon.com/
> > 
> > 
> > > Why not just take the commits that are in newer
> > > kernels instead?
> > 
> > That will be about 20 patches that rewrite the most lines of
> > net/unix/garbage.c and cannot be applied cleanly.
> > 
> > I think backporting these commits is overkill to fix a small
> > bug that can be fixed with a much smaller diff.
> > 
> > 927fa5b3e4f5 af_unix: Fix uninit-value in __unix_walk_scc()
> > 041933a1ec7b af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
> > 7172dc93d621 af_unix: Add dead flag to struct scm_fp_list.
> > 1af2dface5d2 af_unix: Don't access successor in unix_del_edges() during GC.
> > fd86344823b5 af_unix: Try not to hold unix_gc_lock during accept().
> > 118f457da9ed af_unix: Remove lock dance in unix_peek_fds().
> > 4090fa373f0e af_unix: Replace garbage collection algorithm.
> > a15702d8b3aa af_unix: Detect dead SCC.
> > bfdb01283ee8 af_unix: Assign a unique index to SCC.
> > ad081928a8b0 af_unix: Avoid Tarjan's algorithm if unnecessary.
> > 77e5593aebba af_unix: Skip GC if no cycle exists.
> > ba31b4a4e101 af_unix: Save O(n) setup of Tarjan's algo.
> > dcf70df2048d af_unix: Fix up unix_edge.successor for embryo socket.
> > 3484f063172d af_unix: Detect Strongly Connected Components.
> > 6ba76fd2848e af_unix: Iterate all vertices by DFS.
> > 22c3c0c52d32 af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
> > 42f298c06b30 af_unix: Link struct unix_edge when queuing skb.
> > 29b64e354029 af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
> > 1fbfdfaa5902 af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
> 
> Sure, but now all fixes made upstream after these changes will not apply
> to older kernels at all, making supporting this old one-off change
> harder and harder over time.
> 
> But I'll defer to the maintainers here as to what they want.  Taking 20+
> patches in a stable tree is trivial for us, not a problem at all.

Since the general expectation is that branches will be maintained for a
long time, typically around 4 years, it could be seen as shortsighted to
apply a drive-by fix which is highly likely to cause merge conflicts
going forward.  In order to ensure ease of future maintenance it would
be nicer to apply all of the updates above, which as Greg says, would be
trivial from the perspective of Stable.

Kuniyuki, has the suggested stack above been fully tested?

-- 
Lee Jones [李琼斯]

