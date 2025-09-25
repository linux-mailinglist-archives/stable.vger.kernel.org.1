Return-Path: <stable+bounces-181701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5A1B9ECE6
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 12:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C40A34E1CDE
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 10:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730462ED14B;
	Thu, 25 Sep 2025 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxngxCgu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E982E92B3;
	Thu, 25 Sep 2025 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797359; cv=none; b=drdnQLWEvfYJQDjDqmGKOylx7/1r1i8nTWf6Po1JrK2S8qYFx6zoViINAFgoprQfyc1ee+xLXMtfX2iYnH+XC6pFFQtNpPJG3Bl04BvJ8JArYhuMOVjo0YixaX9mPneoC6tL/B+svJ89rv/v16FLl7A5Av3+JW1akNfim9HuYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797359; c=relaxed/simple;
	bh=U6bIptVsNh6jC6pzshQ7TIpbURs7/KG1ReDl3bI6r1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDD1I+OVh2cpz4fkYtGlj94AGJXNqWnD8ENkeXQAEFpEgBbrsyZYAllEhAhC5cPL76J1Q+SyyxNQvbmM9xvW/g9p7mDd17kv1vGNbyrbj9roAq8qmMgcLpDSL96GeSDmK8YAVkfBAF4bNaV/cKKmupYHbBpoMaH7vMXF3SlKKwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxngxCgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114E0C4CEF0;
	Thu, 25 Sep 2025 10:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758797358;
	bh=U6bIptVsNh6jC6pzshQ7TIpbURs7/KG1ReDl3bI6r1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxngxCgu0dSqfpcXNnqv1J9barzynyuFEUHl/3uJ2p71/1Djj0uiyut/46q+1O069
	 RY8eMIk36AYtNWJjGJPuUz5ni1RwfMNF14rq++JpLPUfz+5ntDwrDQPAnGiO+NQlxi
	 08AJArJ5o8WAatsiNzEvS+Q3W6nTxo7xsNlbOf9iVl1h7vER1Lb2CI6Ric9+0znBnC
	 HrQseGszEdzElUwRk0j+8zPGjETeQ0pADdOtBOg12jfV7rdswlY7zAcVppk31pYteR
	 nQQqG3/hNMw75RSxwZQatXaHDO2v9uhoN6gDbpBoCuG1W6fEHuHX0BtCMKaPB9OnW7
	 2HnL+MSEnktTA==
Date: Thu, 25 Sep 2025 11:49:14 +0100
From: Lee Jones <lee@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Jann Horn <jannh@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 070/132] af_unix: Dont leave consecutive consumed OOB
 skbs.
Message-ID: <20250925104914.GC8757@google.com>
References: <20250703143939.370927276@linuxfoundation.org>
 <20250703143942.167088603@linuxfoundation.org>
 <20250925090827.GA514097@google.com>
 <2025092526-grandpa-rebound-6473@gregkh>
 <20250925104732.GB8757@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925104732.GB8757@google.com>

On Thu, 25 Sep 2025, Lee Jones wrote:

> On Thu, 25 Sep 2025, Greg Kroah-Hartman wrote:
> 
> > On Thu, Sep 25, 2025 at 10:08:27AM +0100, Lee Jones wrote:
> > > On Thu, 03 Jul 2025, Greg Kroah-Hartman wrote:
> > > 
> > > > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > > > 
> > > > ------------------
> > > > 
> > > > From: Kuniyuki Iwashima <kuniyu@google.com>
> > > > 
> > > > [ Upstream commit 32ca245464e1479bfea8592b9db227fdc1641705 ]
> > > > 
> > > > Jann Horn reported a use-after-free in unix_stream_read_generic().
> > > > 
> > > > The following sequences reproduce the issue:
> > > > 
> > > >   $ python3
> > > >   from socket import *
> > > >   s1, s2 = socketpair(AF_UNIX, SOCK_STREAM)
> > > >   s1.send(b'x', MSG_OOB)
> > > >   s2.recv(1, MSG_OOB)     # leave a consumed OOB skb
> > > >   s1.send(b'y', MSG_OOB)
> > > >   s2.recv(1, MSG_OOB)     # leave a consumed OOB skb
> > > >   s1.send(b'z', MSG_OOB)
> > > >   s2.recv(1)              # recv 'z' illegally
> > > >   s2.recv(1, MSG_OOB)     # access 'z' skb (use-after-free)
> > > > 
> > > > Even though a user reads OOB data, the skb holding the data stays on
> > > > the recv queue to mark the OOB boundary and break the next recv().
> > > > 
> > > > After the last send() in the scenario above, the sk2's recv queue has
> > > > 2 leading consumed OOB skbs and 1 real OOB skb.
> > > > 
> > > > Then, the following happens during the next recv() without MSG_OOB
> > > > 
> > > >   1. unix_stream_read_generic() peeks the first consumed OOB skb
> > > >   2. manage_oob() returns the next consumed OOB skb
> > > >   3. unix_stream_read_generic() fetches the next not-yet-consumed OOB skb
> > > >   4. unix_stream_read_generic() reads and frees the OOB skb
> > > > 
> > > > , and the last recv(MSG_OOB) triggers KASAN splat.
> > > > 
> > > > The 3. above occurs because of the SO_PEEK_OFF code, which does not
> > > > expect unix_skb_len(skb) to be 0, but this is true for such consumed
> > > > OOB skbs.
> > > > 
> > > >   while (skip >= unix_skb_len(skb)) {
> > > >     skip -= unix_skb_len(skb);
> > > >     skb = skb_peek_next(skb, &sk->sk_receive_queue);
> > > >     ...
> > > >   }
> > > > 
> > > > In addition to this use-after-free, there is another issue that
> > > > ioctl(SIOCATMARK) does not function properly with consecutive consumed
> > > > OOB skbs.
> > > > 
> > > > So, nothing good comes out of such a situation.
> > > > 
> > > > Instead of complicating manage_oob(), ioctl() handling, and the next
> > > > ECONNRESET fix by introducing a loop for consecutive consumed OOB skbs,
> > > > let's not leave such consecutive OOB unnecessarily.
> > > > 
> > > > Now, while receiving an OOB skb in unix_stream_recv_urg(), if its
> > > > previous skb is a consumed OOB skb, it is freed.
> > > > 
> > > > [0]:
> > > > BUG: KASAN: slab-use-after-free in unix_stream_read_actor (net/unix/af_unix.c:3027)
> > > > Read of size 4 at addr ffff888106ef2904 by task python3/315
> > > > 
> > > > CPU: 2 UID: 0 PID: 315 Comm: python3 Not tainted 6.16.0-rc1-00407-gec315832f6f9 #8 PREEMPT(voluntary)
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.fc42 04/01/2014
> > > > Call Trace:
> > > >  <TASK>
> > > >  dump_stack_lvl (lib/dump_stack.c:122)
> > > >  print_report (mm/kasan/report.c:409 mm/kasan/report.c:521)
> > > >  kasan_report (mm/kasan/report.c:636)
> > > >  unix_stream_read_actor (net/unix/af_unix.c:3027)
> > > >  unix_stream_read_generic (net/unix/af_unix.c:2708 net/unix/af_unix.c:2847)
> > > >  unix_stream_recvmsg (net/unix/af_unix.c:3048)
> > > >  sock_recvmsg (net/socket.c:1063 (discriminator 20) net/socket.c:1085 (discriminator 20))
> > > >  __sys_recvfrom (net/socket.c:2278)
> > > >  __x64_sys_recvfrom (net/socket.c:2291 (discriminator 1) net/socket.c:2287 (discriminator 1) net/socket.c:2287 (discriminator 1))
> > > >  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
> > > >  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> > > > RIP: 0033:0x7f8911fcea06
> > > > Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45 10 0f 05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
> > > > RSP: 002b:00007fffdb0dccb0 EFLAGS: 00000202 ORIG_RAX: 000000000000002d
> > > > RAX: ffffffffffffffda RBX: 00007fffdb0dcdc8 RCX: 00007f8911fcea06
> > > > RDX: 0000000000000001 RSI: 00007f8911a5e060 RDI: 0000000000000006
> > > > RBP: 00007fffdb0dccd0 R08: 0000000000000000 R09: 0000000000000000
> > > > R10: 0000000000000001 R11: 0000000000000202 R12: 00007f89119a7d20
> > > > R13: ffffffffc4653600 R14: 0000000000000000 R15: 0000000000000000
> > > >  </TASK>
> > > > 
> > > > Allocated by task 315:
> > > >  kasan_save_stack (mm/kasan/common.c:48)
> > > >  kasan_save_track (mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c:69 (discriminator 1))
> > > >  __kasan_slab_alloc (mm/kasan/common.c:348)
> > > >  kmem_cache_alloc_node_noprof (./include/linux/kasan.h:250 mm/slub.c:4148 mm/slub.c:4197 mm/slub.c:4249)
> > > >  __alloc_skb (net/core/skbuff.c:660 (discriminator 4))
> > > >  alloc_skb_with_frags (./include/linux/skbuff.h:1336 net/core/skbuff.c:6668)
> > > >  sock_alloc_send_pskb (net/core/sock.c:2993)
> > > >  unix_stream_sendmsg (./include/net/sock.h:1847 net/unix/af_unix.c:2256 net/unix/af_unix.c:2418)
> > > >  __sys_sendto (net/socket.c:712 (discriminator 20) net/socket.c:727 (discriminator 20) net/socket.c:2226 (discriminator 20))
> > > >  __x64_sys_sendto (net/socket.c:2233 (discriminator 1) net/socket.c:2229 (discriminator 1) net/socket.c:2229 (discriminator 1))
> > > >  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
> > > >  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> > > > 
> > > > Freed by task 315:
> > > >  kasan_save_stack (mm/kasan/common.c:48)
> > > >  kasan_save_track (mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c:69 (discriminator 1))
> > > >  kasan_save_free_info (mm/kasan/generic.c:579 (discriminator 1))
> > > >  __kasan_slab_free (mm/kasan/common.c:271)
> > > >  kmem_cache_free (mm/slub.c:4643 (discriminator 3) mm/slub.c:4745 (discriminator 3))
> > > >  unix_stream_read_generic (net/unix/af_unix.c:3010)
> > > >  unix_stream_recvmsg (net/unix/af_unix.c:3048)
> > > >  sock_recvmsg (net/socket.c:1063 (discriminator 20) net/socket.c:1085 (discriminator 20))
> > > >  __sys_recvfrom (net/socket.c:2278)
> > > >  __x64_sys_recvfrom (net/socket.c:2291 (discriminator 1) net/socket.c:2287 (discriminator 1) net/socket.c:2287 (discriminator 1))
> > > >  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
> > > >  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> > > > 
> > > > The buggy address belongs to the object at ffff888106ef28c0
> > > >  which belongs to the cache skbuff_head_cache of size 224
> > > > The buggy address is located 68 bytes inside of
> > > >  freed 224-byte region [ffff888106ef28c0, ffff888106ef29a0)
> > > > 
> > > > The buggy address belongs to the physical page:
> > > > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888106ef3cc0 pfn:0x106ef2
> > > > head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > > > flags: 0x200000000000040(head|node=0|zone=2)
> > > > page_type: f5(slab)
> > > > raw: 0200000000000040 ffff8881001d28c0 ffffea000422fe00 0000000000000004
> > > > raw: ffff888106ef3cc0 0000000080190010 00000000f5000000 0000000000000000
> > > > head: 0200000000000040 ffff8881001d28c0 ffffea000422fe00 0000000000000004
> > > > head: ffff888106ef3cc0 0000000080190010 00000000f5000000 0000000000000000
> > > > head: 0200000000000001 ffffea00041bbc81 00000000ffffffff 00000000ffffffff
> > > > head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> > > > page dumped because: kasan: bad access detected
> > > > 
> > > > Memory state around the buggy address:
> > > >  ffff888106ef2800: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
> > > >  ffff888106ef2880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
> > > > >ffff888106ef2900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > >                    ^
> > > >  ffff888106ef2980: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
> > > >  ffff888106ef2a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > 
> > > > Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> > > 
> > > Do we know why this stopped at v6.1?
> > > 
> > > The Fixes: commit was added in v5.15 and this appears to apply fine.
> > > 
> > > If it helps, the upstream commit was:
> > > 
> > >   32ca245464e1 af_unix: Don't leave consecutive consumed OOB skbs.
> > 
> > Commits that are not explicitly tagged with "cc: stable@" are not always
> > backported everywhere.  They are done on a "hey, let's run a script and
> > see what falls out" type of method as the maintainer and developer
> > involved didn't explicitly ask for it to be applied.
> 
> Right.  I'm just surprised that it was backported to some branches, but
> not others, despite seemingly applying just fine and the Fixes: tag
> indicating that it should be applied to v5.15 as well.
> 
> > If you think it should be added to other branches, please always let us
> > know and ideally, send a working backport :)
> 
> I just did let you know. :)
> 
> No backport required.  It should just apply.

I applied it again and submitted it for build testing.

Once complete, I'll let you know the result.

-- 
Lee Jones [李琼斯]

