Return-Path: <stable+bounces-38947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173C78A1128
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32CF28453D
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DA41474C6;
	Thu, 11 Apr 2024 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mvJIk60J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70283146A74;
	Thu, 11 Apr 2024 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832064; cv=none; b=H8+J0ntzYmkRYRTJADVlfX8aVsonkt2asMKRVW7Ywg2Y4wD4/Br8GrkTQ4yPylWwVawVdWiSZkfy9bqXvAJHbkYgBW+IAd0+XNnxwMBgL1pmPDEE8BJ4pM2sZ1nrKhHMl6p73NPF12V490k/GZENzNNTwosvRtALtnChS+MguxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832064; c=relaxed/simple;
	bh=rOlDSPC3xuq95K9NnR32lLT4QB2+RLGdAqnDqEgM7Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIAcFIFNe2q8DW/lHfXHLudY5NHP0ROONRYHMww8DzuHsMESbIoq+JYSVXOZcbpKwKwVfOcMONI0qCKI7m+y5jdtufo0S6g7hCfWnxLvGnJfQ325V5Dobl6ly5XCRh82qxu3uB/BdiKNW3u0r5Wlw9c/qHcCOS+RNKWToPkkQ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mvJIk60J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B19C433C7;
	Thu, 11 Apr 2024 10:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712832064;
	bh=rOlDSPC3xuq95K9NnR32lLT4QB2+RLGdAqnDqEgM7Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mvJIk60JJ+hWQi5Zp3ISSE7humWZvGRGk30M/5hj4N3kNwwn490hv60wJfPVtaFXq
	 DcdGKQs/bH3Um1g/EBJNdQDDfy0gXcS05u4peoe+muVVHO6q9UaRf9IWIaBp79XSKJ
	 5pfe31eIaqwM+U4L7zljJEBeNvxROxsQQ5Va2uy4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzkaller <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 216/294] ipv6: Fix infinite recursion in fib6_dump_done().
Date: Thu, 11 Apr 2024 11:56:19 +0200
Message-ID: <20240411095442.098074628@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit d21d40605bca7bd5fc23ef03d4c1ca1f48bc2cae upstream.

syzkaller reported infinite recursive calls of fib6_dump_done() during
netlink socket destruction.  [1]

>From the log, syzkaller sent an AF_UNSPEC RTM_GETROUTE message, and then
the response was generated.  The following recvmmsg() resumed the dump
for IPv6, but the first call of inet6_dump_fib() failed at kzalloc() due
to the fault injection.  [0]

  12:01:34 executing program 3:
  r0 = socket$nl_route(0x10, 0x3, 0x0)
  sendmsg$nl_route(r0, ... snip ...)
  recvmmsg(r0, ... snip ...) (fail_nth: 8)

Here, fib6_dump_done() was set to nlk_sk(sk)->cb.done, and the next call
of inet6_dump_fib() set it to nlk_sk(sk)->cb.args[3].  syzkaller stopped
receiving the response halfway through, and finally netlink_sock_destruct()
called nlk_sk(sk)->cb.done().

fib6_dump_done() calls fib6_dump_end() and nlk_sk(sk)->cb.done() if it
is still not NULL.  fib6_dump_end() rewrites nlk_sk(sk)->cb.done() by
nlk_sk(sk)->cb.args[3], but it has the same function, not NULL, calling
itself recursively and hitting the stack guard page.

To avoid the issue, let's set the destructor after kzalloc().

[0]:
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 1 PID: 432110 Comm: syz-executor.3 Not tainted 6.8.0-12821-g537c2e91d354-dirty #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:117)
 should_fail_ex (lib/fault-inject.c:52 lib/fault-inject.c:153)
 should_failslab (mm/slub.c:3733)
 kmalloc_trace (mm/slub.c:3748 mm/slub.c:3827 mm/slub.c:3992)
 inet6_dump_fib (./include/linux/slab.h:628 ./include/linux/slab.h:749 net/ipv6/ip6_fib.c:662)
 rtnl_dump_all (net/core/rtnetlink.c:4029)
 netlink_dump (net/netlink/af_netlink.c:2269)
 netlink_recvmsg (net/netlink/af_netlink.c:1988)
 ____sys_recvmsg (net/socket.c:1046 net/socket.c:2801)
 ___sys_recvmsg (net/socket.c:2846)
 do_recvmmsg (net/socket.c:2943)
 __x64_sys_recvmmsg (net/socket.c:3041 net/socket.c:3034 net/socket.c:3034)

[1]:
BUG: TASK stack guard page was hit at 00000000f2fa9af1 (stack is 00000000b7912430..000000009a436beb)
stack guard page: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 223719 Comm: kworker/1:3 Not tainted 6.8.0-12821-g537c2e91d354-dirty #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Workqueue: events netlink_sock_destruct_work
RIP: 0010:fib6_dump_done (net/ipv6/ip6_fib.c:570)
Code: 3c 24 e8 f3 e9 51 fd e9 28 fd ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 41 57 41 56 41 55 41 54 55 48 89 fd <53> 48 8d 5d 60 e8 b6 4d 07 fd 48 89 da 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc9000d980000 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffffff84405990 RCX: ffffffff844059d3
RDX: ffff8881028e0000 RSI: ffffffff84405ac2 RDI: ffff88810c02f358
RBP: ffff88810c02f358 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000224 R12: 0000000000000000
R13: ffff888007c82c78 R14: ffff888007c82c68 R15: ffff888007c82c68
FS:  0000000000000000(0000) GS:ffff88811b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000d97fff8 CR3: 0000000102309002 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <#DF>
 </#DF>
 <TASK>
 fib6_dump_done (net/ipv6/ip6_fib.c:572 (discriminator 1))
 fib6_dump_done (net/ipv6/ip6_fib.c:572 (discriminator 1))
 ...
 fib6_dump_done (net/ipv6/ip6_fib.c:572 (discriminator 1))
 fib6_dump_done (net/ipv6/ip6_fib.c:572 (discriminator 1))
 netlink_sock_destruct (net/netlink/af_netlink.c:401)
 __sk_destruct (net/core/sock.c:2177 (discriminator 2))
 sk_destruct (net/core/sock.c:2224)
 __sk_free (net/core/sock.c:2235)
 sk_free (net/core/sock.c:2246)
 process_one_work (kernel/workqueue.c:3259)
 worker_thread (kernel/workqueue.c:3329 kernel/workqueue.c:3416)
 kthread (kernel/kthread.c:388)
 ret_from_fork (arch/x86/kernel/process.c:153)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
Modules linked in:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20240401211003.25274-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_fib.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -643,19 +643,19 @@ static int inet6_dump_fib(struct sk_buff
 	if (!w) {
 		/* New dump:
 		 *
-		 * 1. hook callback destructor.
-		 */
-		cb->args[3] = (long)cb->done;
-		cb->done = fib6_dump_done;
-
-		/*
-		 * 2. allocate and initialize walker.
+		 * 1. allocate and initialize walker.
 		 */
 		w = kzalloc(sizeof(*w), GFP_ATOMIC);
 		if (!w)
 			return -ENOMEM;
 		w->func = fib6_dump_node;
 		cb->args[2] = (long)w;
+
+		/* 2. hook callback destructor.
+		 */
+		cb->args[3] = (long)cb->done;
+		cb->done = fib6_dump_done;
+
 	}
 
 	arg.skb = skb;



