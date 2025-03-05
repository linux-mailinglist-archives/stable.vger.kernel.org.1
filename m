Return-Path: <stable+bounces-121087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B15A509F0
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 885BE7A4355
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43754253326;
	Wed,  5 Mar 2025 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eTAv9JB6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0102A1C863D;
	Wed,  5 Mar 2025 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199197; cv=none; b=R5WCI5EFXzW3le+1bXGaa6RQju6lwUY0BCex5GTEwjlUsskOtZtRf0GjSM9bJDJpKeaL/FXGWB04s6tD8aH5yVmu/zoDx75KJnNHB90tSzdPAD717Re9q9Zuu/uT7YlHRi4+d5Y2FJ9L6hyWpfXcTuclL6kO6elVMZS2KVAKNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199197; c=relaxed/simple;
	bh=cjZzUA/41ixgEf8cjgnXTpFrNQUJKjT9kMH9ovjM4AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci5TeeClwXkLXRf+pTmzYIMGEecWUnhNnwJMXHJDYvgCP3KII5bjeqnEWks3S3ntcrRcY3CowHYtPjgUe2ai1/dIdcwaUI/HlNrP03slNKzi0DjtmiIfKK8sDwnkYdeYhcOyCndX0i1lKcDls+MwdvJos68oFUCoxXrbkggMMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eTAv9JB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F9BC4CED1;
	Wed,  5 Mar 2025 18:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741199196;
	bh=cjZzUA/41ixgEf8cjgnXTpFrNQUJKjT9kMH9ovjM4AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eTAv9JB6YrxQ63TqHhOVF1LkVp1ffdvswKCZS+EScUgCV5w67oezPSF4QTZw6Q4pt
	 zggZ+XzTAAObSVnHQjCdYh+hFexAVYGsW04FenhzAH7srsBR659lau/Fxn98C77J6L
	 xBx2RM3otqxZlHZVraX4tb+08SCPYp6RZUPEJntQ=
Date: Wed, 5 Mar 2025 19:22:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Paolo Abeni <pabeni@redhat.com>, kuni1840@gmail.com, llfamsec@gmail.com,
	netdev@vger.kernel.org, sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH stable 5.15/6.1/6.6] af_unix: Clear oob_skb in
 scan_inflight().
Message-ID: <2025030533-craving-hunk-afa3@gregkh>
References: <2025030543-banker-impale-9c08@gregkh>
 <20250305181050.17199-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305181050.17199-1-kuniyu@amazon.com>

On Wed, Mar 05, 2025 at 10:10:41AM -0800, Kuniyuki Iwashima wrote:
> +Paolo
> 
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date: Wed, 5 Mar 2025 15:08:26 +0100
> > On Mon, Mar 03, 2025 at 07:01:49PM -0800, Kuniyuki Iwashima wrote:
> > > Embryo socket is not queued in gc_candidates, so we can't drop
> > > a reference held by its oob_skb.
> > > 
> > > Let's say we create listener and embryo sockets, send the
> > > listener's fd to the embryo as OOB data, and close() them
> > > without recv()ing the OOB data.
> > > 
> > > There is a self-reference cycle like
> > > 
> > >   listener -> embryo.oob_skb -> listener
> > > 
> > > , so this must be cleaned up by GC.  Otherwise, the listener's
> > > refcnt is not released and sockets are leaked:
> > > 
> > >   # unshare -n
> > >   # cat /proc/net/protocols | grep UNIX-STREAM
> > >   UNIX-STREAM 1024      0      -1   NI       0   yes  kernel ...
> > > 
> > >   # python3
> > >   >>> from array import array
> > >   >>> from socket import *
> > >   >>>
> > >   >>> s = socket(AF_UNIX, SOCK_STREAM)
> > >   >>> s.bind('\0test\0')
> > >   >>> s.listen()
> > >   >>>
> > >   >>> c = socket(AF_UNIX, SOCK_STREAM)
> > >   >>> c.connect(s.getsockname())
> > >   >>> c.sendmsg([b'x'], [(SOL_SOCKET, SCM_RIGHTS, array('i', [s.fileno()]))], MSG_OOB)
> > >   1
> > >   >>> quit()
> > > 
> > >   # cat /proc/net/protocols | grep UNIX-STREAM
> > >   UNIX-STREAM 1024      3      -1   NI       0   yes  kernel ...
> > >                         ^^^
> > >                         3 sockets still in use after FDs are close()d
> > > 
> > > Let's drop the embryo socket's oob_skb ref in scan_inflight().
> > > 
> > > This also fixes a racy access to oob_skb that commit 9841991a446c
> > > ("af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue
> > > lock.") fixed for the new Tarjan's algo-based GC.
> > > 
> > > Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> > > Reported-by: Lei Lu <llfamsec@gmail.com>
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > > This has no upstream commit because I replaced the entire GC in
> > > 6.10 and the new GC does not have this bug, and this fix is only
> > > applicable to the old GC (<= 6.9), thus for 5.15/6.1/6.6.
> > 
> > You need to get the networking maintainers to review and agree that this
> > is ok for us to take, as we really don't want to take "custom" stuff
> > like thi s at all.
> 
> Paolo, could you take a look at this patch ?
> https://lore.kernel.org/netdev/20250304030149.82265-1-kuniyu@amazon.com/
> 
> 
> > Why not just take the commits that are in newer
> > kernels instead?
> 
> That will be about 20 patches that rewrite the most lines of
> net/unix/garbage.c and cannot be applied cleanly.
> 
> I think backporting these commits is overkill to fix a small
> bug that can be fixed with a much smaller diff.
> 
> 927fa5b3e4f5 af_unix: Fix uninit-value in __unix_walk_scc()
> 041933a1ec7b af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
> 7172dc93d621 af_unix: Add dead flag to struct scm_fp_list.
> 1af2dface5d2 af_unix: Don't access successor in unix_del_edges() during GC.
> fd86344823b5 af_unix: Try not to hold unix_gc_lock during accept().
> 118f457da9ed af_unix: Remove lock dance in unix_peek_fds().
> 4090fa373f0e af_unix: Replace garbage collection algorithm.
> a15702d8b3aa af_unix: Detect dead SCC.
> bfdb01283ee8 af_unix: Assign a unique index to SCC.
> ad081928a8b0 af_unix: Avoid Tarjan's algorithm if unnecessary.
> 77e5593aebba af_unix: Skip GC if no cycle exists.
> ba31b4a4e101 af_unix: Save O(n) setup of Tarjan's algo.
> dcf70df2048d af_unix: Fix up unix_edge.successor for embryo socket.
> 3484f063172d af_unix: Detect Strongly Connected Components.
> 6ba76fd2848e af_unix: Iterate all vertices by DFS.
> 22c3c0c52d32 af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
> 42f298c06b30 af_unix: Link struct unix_edge when queuing skb.
> 29b64e354029 af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
> 1fbfdfaa5902 af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.

Sure, but now all fixes made upstream after these changes will not apply
to older kernels at all, making supporting this old one-off change
harder and harder over time.

But I'll defer to the maintainers here as to what they want.  Taking 20+
patches in a stable tree is trivial for us, not a problem at all.

thanks,

greg k-h

