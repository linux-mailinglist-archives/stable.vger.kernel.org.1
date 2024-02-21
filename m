Return-Path: <stable+bounces-22360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD9685DBA5
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52A81F2472F
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2367BB03;
	Wed, 21 Feb 2024 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TAJvakn+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FC173161;
	Wed, 21 Feb 2024 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523020; cv=none; b=ZBlXCtw5pCWhAM4H5jzN8cddvTRsCTBun/d7r7pTnsxsu1v6R5r2cTaNOt9vq3oPAMaJfYJdKbJshLAxDnO3xC536zj3Rkhk6RsCO/vmzNgJlNet2bkSWGuCEmMj6InzboND7H5AT/WDjA/W3ex7im/jXPxokzBu9OqDizKWDJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523020; c=relaxed/simple;
	bh=uJgIk9YFXs+mPc9R77PSxtiPhp1VLHpBiH87JEFKXk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoqdMroGAo/+yndbo5kFFGbSmAWVX3Q3xOhnv4BXozvclaBHHJhxXywn1o57Ue0Pq3QKVRoHdSe58Er6dZVZQk+lqj/pPrazgYJ0chZY4bp5AgOHe9zyswzSOs2Twj0Y3Q0gaPQUi0nLIsT+6jy0yrl5ak4yH2bzTk9jj04dBIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TAJvakn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933D0C433F1;
	Wed, 21 Feb 2024 13:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523020;
	bh=uJgIk9YFXs+mPc9R77PSxtiPhp1VLHpBiH87JEFKXk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAJvakn+Hw5AzRc9RDJ4B3IO+ugT6o5ESyp9wK33f/uiARXuXdm7MZvR1qCRGQTF0
	 92faL/9V5BTD/nTAFnDnsLxkz/oPjh3xKZJeCksA3OR5fFQgNF/vaIzIsK2gNw46V2
	 Kahi4g/FenccrBMUYOaCCCZ6pTQFr/5YFUixsneM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 316/476] af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.
Date: Wed, 21 Feb 2024 14:06:07 +0100
Message-ID: <20240221130019.700290963@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 1279f9d9dec2d7462823a18c29ad61359e0a007d ]

syzbot reported a warning [0] in __unix_gc() with a repro, which
creates a socketpair and sends one socket's fd to itself using the
peer.

  socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
  sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\360", iov_len=1}],
          msg_iovlen=1, msg_control=[{cmsg_len=20, cmsg_level=SOL_SOCKET,
                                      cmsg_type=SCM_RIGHTS, cmsg_data=[3]}],
          msg_controllen=24, msg_flags=0}, MSG_OOB|MSG_PROBE|MSG_DONTWAIT|MSG_ZEROCOPY) = 1

This forms a self-cyclic reference that GC should finally untangle
but does not due to lack of MSG_OOB handling, resulting in memory
leak.

Recently, commit 11498715f266 ("af_unix: Remove io_uring code for
GC.") removed io_uring's dead code in GC and revealed the problem.

The code was executed at the final stage of GC and unconditionally
moved all GC candidates from gc_candidates to gc_inflight_list.
That papered over the reported problem by always making the following
WARN_ON_ONCE(!list_empty(&gc_candidates)) false.

The problem has been there since commit 2aab4b969002 ("af_unix: fix
struct pid leaks in OOB support") added full scm support for MSG_OOB
while fixing another bug.

To fix this problem, we must call kfree_skb() for unix_sk(sk)->oob_skb
if the socket still exists in gc_candidates after purging collected skb.

Then, we need to set NULL to oob_skb before calling kfree_skb() because
it calls last fput() and triggers unix_release_sock(), where we call
duplicate kfree_skb(u->oob_skb) if not NULL.

Note that the leaked socket remained being linked to a global list, so
kmemleak also could not detect it.  We need to check /proc/net/protocol
to notice the unfreed socket.

[0]:
WARNING: CPU: 0 PID: 2863 at net/unix/garbage.c:345 __unix_gc+0xc74/0xe80 net/unix/garbage.c:345
Modules linked in:
CPU: 0 PID: 2863 Comm: kworker/u4:11 Not tainted 6.8.0-rc1-syzkaller-00583-g1701940b1a02 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events_unbound __unix_gc
RIP: 0010:__unix_gc+0xc74/0xe80 net/unix/garbage.c:345
Code: 8b 5c 24 50 e9 86 f8 ff ff e8 f8 e4 22 f8 31 d2 48 c7 c6 30 6a 69 89 4c 89 ef e8 97 ef ff ff e9 80 f9 ff ff e8 dd e4 22 f8 90 <0f> 0b 90 e9 7b fd ff ff 48 89 df e8 5c e7 7c f8 e9 d3 f8 ff ff e8
RSP: 0018:ffffc9000b03fba0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000b03fc10 RCX: ffffffff816c493e
RDX: ffff88802c02d940 RSI: ffffffff896982f3 RDI: ffffc9000b03fb30
RBP: ffffc9000b03fce0 R08: 0000000000000001 R09: fffff52001607f66
R10: 0000000000000003 R11: 0000000000000002 R12: dffffc0000000000
R13: ffffc9000b03fc10 R14: ffffc9000b03fc10 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005559c8677a60 CR3: 000000000d57a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work+0x889/0x15e0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x12a0 kernel/workqueue.c:2787
 kthread+0x2c6/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>

Reported-by: syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa3ef895554bdbfd1183
Fixes: 2aab4b969002 ("af_unix: fix struct pid leaks in OOB support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240203183149.63573-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/garbage.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index dc2763540393..767b338a7a2d 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -314,6 +314,17 @@ void unix_gc(void)
 	/* Here we are. Hitlist is filled. Die. */
 	__skb_queue_purge(&hitlist);
 
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+	list_for_each_entry_safe(u, next, &gc_candidates, link) {
+		struct sk_buff *skb = u->oob_skb;
+
+		if (skb) {
+			u->oob_skb = NULL;
+			kfree_skb(skb);
+		}
+	}
+#endif
+
 	spin_lock(&unix_gc_lock);
 
 	/* There could be io_uring registered files, just push them back to
-- 
2.43.0




