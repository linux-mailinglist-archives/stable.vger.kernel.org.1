Return-Path: <stable+bounces-144584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 932C1AB9763
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 10:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1CD97A715E
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 08:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF1922D4D0;
	Fri, 16 May 2025 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQW3Q7mv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B61AA1DA;
	Fri, 16 May 2025 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747383528; cv=none; b=KzEJd6zCMOoWMXMBVp50rIzqhQuuLZnvkDpsAwBM8PDZBC25DqzT2N5iR3KUzP7EnjgQdJwNopxB/YIQp8HFHla6SUBu+UkDLZWhkp6FrQCMplkQK3bgb14TmLo4DLg1bseklOMKnxE14+toko7tj9PqwVjMpHJRGZ0ffg3R64c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747383528; c=relaxed/simple;
	bh=hyDHVV2V+U0v3zj5LNN59+2C/hANT3QmMk6DH7/aZho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m11g2opOe0nEk0Ho4tHxXBewNtz7uS6VY4TGtMuidPxN1vqjCNmSEZ8Cxr+Eo15z4dcQdTABnnjIbPP3D5s+AVK5ZUjgd2nhUCk2KlwOujYDN/o0R/O7xng7aU6nlUjsft7aQeI5womnS8pYaMsLrMrVLu2Gc4RjHbWpcergVx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQW3Q7mv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1C6C4CEE4;
	Fri, 16 May 2025 08:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747383528;
	bh=hyDHVV2V+U0v3zj5LNN59+2C/hANT3QmMk6DH7/aZho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQW3Q7mvTNnkdBJczcwdWsLigTxoC4fFjqV6uqejyQCnD7pyrPPsmPm3T7BPIdGMu
	 Kq5OrxN9RZ6/gP0pD3umAZqmDQH3QopfHGdfmgtkXUwj44rshey5vs+dQ/VrWVHGv+
	 o3MvLDgFflDJKF8oopwrBTMfsxMQh60SGd34ddZw5melK1AUcOhhxZ8U0AHDRjCczL
	 V51DUwWqQ+mjOR6z7h+lnggSGFu7FAmJvv1ze3Oz7PseC1ia7HT1FNHEWDuNwXZeSZ
	 WnQ633J+03RobjpHkKcEV6fFAd0crm0kQhR3QuEqWRGQRGG/SnznVWrlprzRVrHVCE
	 wD2FONkPpo30g==
Date: Fri, 16 May 2025 09:18:43 +0100
From: Lee Jones <lee@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Paolo Abeni <pabeni@redhat.com>, gregkh@linuxfoundation.org,
	kuni1840@gmail.com, llfamsec@gmail.com, netdev@vger.kernel.org,
	sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH stable 5.15/6.1/6.6] af_unix: Clear oob_skb in
 scan_inflight().
Message-ID: <20250516081843.GA1044914@google.com>
References: <2025030543-banker-impale-9c08@gregkh>
 <20250305181050.17199-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305181050.17199-1-kuniyu@amazon.com>

On Wed, 05 Mar 2025, Kuniyuki Iwashima wrote:

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

Okay, I've taken some time to apply a set to linux-6.6.y that looks
similar to this [0].  Would someone please give me some advice on how to
test it please?  Are there some unit tests I could run to ensure that
everything is working as expected?

Or even better; if someone could pull the request below and tell me
whether it's correct or not.

Thank you.

[0]
The following changes since commit 9c2dd8954dad0430e83ee55b985ba55070e50cf7:

  Linux 6.6.90 (2025-05-09 09:44:08 +0200)

are available in the Git repository at:

  https://github.com/lag-google/linux.git tb-b404256079-af_unix-uaf

for you to fetch changes up to dcddf5a33645b7e305ab91966ed3c6b319d7e28e:

  af_unix: Fix uninit-value in __unix_walk_scc() (2025-05-15 15:58:08 +0100)

----------------------------------------------------------------
Kuniyuki Iwashima (24):
      af_unix: Return struct unix_sock from unix_get_socket().
      af_unix: Run GC on only one CPU.
      af_unix: Try to run GC async.
      af_unix: Replace BUG_ON() with WARN_ON_ONCE().
      af_unix: Remove io_uring code for GC.
      af_unix: Remove CONFIG_UNIX_SCM.
      af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
      af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
      af_unix: Link struct unix_edge when queuing skb.
      af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
      af_unix: Iterate all vertices by DFS.
      af_unix: Detect Strongly Connected Components.
      af_unix: Save listener for embryo socket.
      af_unix: Fix up unix_edge.successor for embryo socket.
      af_unix: Save O(n) setup of Tarjan's algo.
      af_unix: Skip GC if no cycle exists.
      af_unix: Avoid Tarjan's algorithm if unnecessary.
      af_unix: Assign a unique index to SCC.
      af_unix: Detect dead SCC.
      af_unix: Replace garbage collection algorithm.
      af_unix: Remove lock dance in unix_peek_fds().
      af_unix: Try not to hold unix_gc_lock during accept().
      af_unix: Don't access successor in unix_del_edges() during GC.
      af_unix: Add dead flag to struct scm_fp_list.

Michal Luczaj (1):
      af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS

Shigeru Yoshida (1):
      af_unix: Fix uninit-value in __unix_walk_scc()

 include/net/af_unix.h |  49 +++-
 include/net/scm.h     |  11 +
 net/Makefile          |   2 +-
 net/core/scm.c        |  17 ++
 net/unix/Kconfig      |   5 -
 net/unix/Makefile     |   2 -
 net/unix/af_unix.c    | 120 +++++----
 net/unix/garbage.c    | 691 +++++++++++++++++++++++++++++++++++---------------
 net/unix/scm.c        | 161 ------------
 net/unix/scm.h        |  10 -
 10 files changed, 617 insertions(+), 451 deletions(-)
 delete mode 100644 net/unix/scm.c
 delete mode 100644 net/unix/scm.h

-- 
Lee Jones [李琼斯]

