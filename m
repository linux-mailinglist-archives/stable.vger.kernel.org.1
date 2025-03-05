Return-Path: <stable+bounces-120892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27715A508E8
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1875C1893FDE
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394A1C6FF6;
	Wed,  5 Mar 2025 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="N7+PPHJm"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49871ACEDD;
	Wed,  5 Mar 2025 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198278; cv=none; b=C7WZusVq1Z5zNHTV3qAInUSG2DjHFmSF+lSowRiLEdJ+OKodWfLVw6IYbHAh+wkhKmZaDSP/S1Kv4TjdnK+QITSet2w1d2hGD0mRknjuzme7HIMv1g0DY7sOK0lrYvASAj1nM0duFlDQEc9wnPJZWFUx4KK5oFRpf4Ho41/OLcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198278; c=relaxed/simple;
	bh=fXTc22PcmEtd2wCu5ddU0VzITl3xDm/HEBT5DknTFhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9M/lMk23Ogx3BkJMhw8iFswR12BtPcQY4pgIvQ5mj4fn4qkYfZ//1ExQaUE9w3NM2HKs9m2Dw/Qm7s2/tvtXFBC8nummDeSX/UZmmOU60iJqR6Ap4FCjuaUqVYM7x4g++S33nJOCkvnXHhZTVgv4wk37DqOFh8HwK2ojdvpXp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=N7+PPHJm; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741198277; x=1772734277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2J15cXOqPd/u5rzTBX8mT/MjrB3duXJF2SeSM4Peubk=;
  b=N7+PPHJmnvWUlEVNN30XYQEVDakz/EZm3TmNDBaB1tDl6gd7M9mxDyRI
   w1Ycl5j8pZDW5/RjzsDybeYmkcbQZYlkwoV452id+DMaPt7G/iLFUyu3S
   MuOUUaKM5RBueilNtZy5WMd/8ZHsLAbNdjaCQpLRVu6eT+lxQ6C1LggBw
   I=;
X-IronPort-AV: E=Sophos;i="6.14,223,1736812800"; 
   d="scan'208";a="724113009"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 18:11:13 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:10366]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.201:2525] with esmtp (Farcaster)
 id f875b2bd-4da4-4b3d-9682-06f6ba307da0; Wed, 5 Mar 2025 18:11:12 +0000 (UTC)
X-Farcaster-Flow-ID: f875b2bd-4da4-4b3d-9682-06f6ba307da0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 5 Mar 2025 18:11:00 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.242.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 5 Mar 2025 18:10:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Paolo Abeni <pabeni@redhat.com>, <gregkh@linuxfoundation.org>
CC: <kuni1840@gmail.com>, <kuniyu@amazon.com>, <llfamsec@gmail.com>,
	<netdev@vger.kernel.org>, <sashal@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH stable 5.15/6.1/6.6] af_unix: Clear oob_skb in scan_inflight().
Date: Wed, 5 Mar 2025 10:10:41 -0800
Message-ID: <20250305181050.17199-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025030543-banker-impale-9c08@gregkh>
References: <2025030543-banker-impale-9c08@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

+Paolo

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 5 Mar 2025 15:08:26 +0100
> On Mon, Mar 03, 2025 at 07:01:49PM -0800, Kuniyuki Iwashima wrote:
> > Embryo socket is not queued in gc_candidates, so we can't drop
> > a reference held by its oob_skb.
> > 
> > Let's say we create listener and embryo sockets, send the
> > listener's fd to the embryo as OOB data, and close() them
> > without recv()ing the OOB data.
> > 
> > There is a self-reference cycle like
> > 
> >   listener -> embryo.oob_skb -> listener
> > 
> > , so this must be cleaned up by GC.  Otherwise, the listener's
> > refcnt is not released and sockets are leaked:
> > 
> >   # unshare -n
> >   # cat /proc/net/protocols | grep UNIX-STREAM
> >   UNIX-STREAM 1024      0      -1   NI       0   yes  kernel ...
> > 
> >   # python3
> >   >>> from array import array
> >   >>> from socket import *
> >   >>>
> >   >>> s = socket(AF_UNIX, SOCK_STREAM)
> >   >>> s.bind('\0test\0')
> >   >>> s.listen()
> >   >>>
> >   >>> c = socket(AF_UNIX, SOCK_STREAM)
> >   >>> c.connect(s.getsockname())
> >   >>> c.sendmsg([b'x'], [(SOL_SOCKET, SCM_RIGHTS, array('i', [s.fileno()]))], MSG_OOB)
> >   1
> >   >>> quit()
> > 
> >   # cat /proc/net/protocols | grep UNIX-STREAM
> >   UNIX-STREAM 1024      3      -1   NI       0   yes  kernel ...
> >                         ^^^
> >                         3 sockets still in use after FDs are close()d
> > 
> > Let's drop the embryo socket's oob_skb ref in scan_inflight().
> > 
> > This also fixes a racy access to oob_skb that commit 9841991a446c
> > ("af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue
> > lock.") fixed for the new Tarjan's algo-based GC.
> > 
> > Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> > Reported-by: Lei Lu <llfamsec@gmail.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> > This has no upstream commit because I replaced the entire GC in
> > 6.10 and the new GC does not have this bug, and this fix is only
> > applicable to the old GC (<= 6.9), thus for 5.15/6.1/6.6.
> 
> You need to get the networking maintainers to review and agree that this
> is ok for us to take, as we really don't want to take "custom" stuff
> like thi s at all.

Paolo, could you take a look at this patch ?
https://lore.kernel.org/netdev/20250304030149.82265-1-kuniyu@amazon.com/


> Why not just take the commits that are in newer
> kernels instead?

That will be about 20 patches that rewrite the most lines of
net/unix/garbage.c and cannot be applied cleanly.

I think backporting these commits is overkill to fix a small
bug that can be fixed with a much smaller diff.

927fa5b3e4f5 af_unix: Fix uninit-value in __unix_walk_scc()
041933a1ec7b af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
7172dc93d621 af_unix: Add dead flag to struct scm_fp_list.
1af2dface5d2 af_unix: Don't access successor in unix_del_edges() during GC.
fd86344823b5 af_unix: Try not to hold unix_gc_lock during accept().
118f457da9ed af_unix: Remove lock dance in unix_peek_fds().
4090fa373f0e af_unix: Replace garbage collection algorithm.
a15702d8b3aa af_unix: Detect dead SCC.
bfdb01283ee8 af_unix: Assign a unique index to SCC.
ad081928a8b0 af_unix: Avoid Tarjan's algorithm if unnecessary.
77e5593aebba af_unix: Skip GC if no cycle exists.
ba31b4a4e101 af_unix: Save O(n) setup of Tarjan's algo.
dcf70df2048d af_unix: Fix up unix_edge.successor for embryo socket.
3484f063172d af_unix: Detect Strongly Connected Components.
6ba76fd2848e af_unix: Iterate all vertices by DFS.
22c3c0c52d32 af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
42f298c06b30 af_unix: Link struct unix_edge when queuing skb.
29b64e354029 af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
1fbfdfaa5902 af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.

