Return-Path: <stable+bounces-144628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91445ABA2C7
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 20:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1CB1BC050B
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF3827AC4D;
	Fri, 16 May 2025 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="gQbnxmf+"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7D2701A7;
	Fri, 16 May 2025 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420151; cv=none; b=t1kxD1rbmJW/uN106hOUOsqadROSTJnFBjX46c13LkrcK6z+zmjrqBGzfl0VAE4IpZj7o9NT9QbRfCFs5OEnkqFSIDTUpVDkAWSaI6QJqJ8i0g5WEtQY46z+6vdW5F/F+X2uAoBHo1euF3CPOjfyLoflAQ3sjK6LUxrWaqPo2fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420151; c=relaxed/simple;
	bh=L1J3lhc3dz/x2gt0Tyu0ZFkEuThw1q/QCIsKDCQAKZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnSJuVNwnGLNKgWGRs5at66UN8yDBQXw1wiF6YirEGmMK2MkYoz2ciOjYAWOilXpzB7jIHZbIDjy88y8Fm+LJgVZDUuj7seCKPCxnwucoGAqCE1aFcGxeOPnt3Y9IatGkQz1K+CvyBk0I6PpbqdIB2Xe0Euu4IDILYjsHhMWijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=gQbnxmf+; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747420150; x=1778956150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EDjwGpHfWYpxzbmgkSZNL4bT3LlkigmlrlW2zDkQW7Q=;
  b=gQbnxmf+GOwGcChFD7o4HGg0ut+5/pehf1rQ7SYa0vXwv87ZZo7EOV27
   aueA7CIR15d44CqC38eJmcw3x1JWBMjY2BSlEtdUiQJ1y3LjkodtW+gL/
   8fHOMxckeYeehC2jmNgfSSe1vzrUfaImKVUSF7Ant0/6MCEPRRs1s4t0f
   SPOtzRRqoHOjdfqDFjHulhUmDBNxOd44AczetUSuJkIllPAX+cxi4pgSc
   G5WXV+7RbkzQgEYKNw+EXwhB/jQGaARVpdmVgAUklQwhN/df3Fibxykum
   T6gR5yx+0KziOT63vJkMo8AQM9ZAQz5BvbxPBujZCpAS7k4GXbe7S7vPl
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,294,1739836800"; 
   d="scan'208";a="490910578"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 18:29:05 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:33913]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.53:2525] with esmtp (Farcaster)
 id 981a322c-17f6-46c5-b60d-3f7c1f4c214a; Fri, 16 May 2025 18:29:04 +0000 (UTC)
X-Farcaster-Flow-ID: 981a322c-17f6-46c5-b60d-3f7c1f4c214a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 18:29:04 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.194.153) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 18:29:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lee@kernel.org>
CC: <gregkh@linuxfoundation.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<llfamsec@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sashal@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH Astable 5.15/6.1/6.6] af_unix: Clear oob_skb in scan_inflight().
Date: Fri, 16 May 2025 11:27:36 -0700
Message-ID: <20250516182853.76205-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516081843.GA1044914@google.com>
References: <20250516081843.GA1044914@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Lee Jones <lee@kernel.org>
Date: Fri, 16 May 2025 09:18:43 +0100
> On Wed, 05 Mar 2025, Kuniyuki Iwashima wrote:
> 
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
> Okay, I've taken some time to apply a set to linux-6.6.y that looks
> similar to this [0].  Would someone please give me some advice on how to
> test it please?  Are there some unit tests I could run to ensure that
> everything is working as expected?

Thanks for working on this! and sorry for the late response, I'm
personally busy this month.

Could you run tools/testing/selftests/net/af_unix/scm_rights.c
with KASAN and kmemleak ?

The test is added by

2a79651bf2fa selftest: af_unix: Add test case for backtrack after finalising SCC.
e060e433e512 selftest: af_unix: Make SCM_RIGHTS into OOB data.
2aa0cff26ed5 selftest: af_unix: Test GC for SCM_RIGHTS.

The 2nd commit will cover the test case of the python script in
the patch of this thread.

