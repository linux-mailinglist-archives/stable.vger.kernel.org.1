Return-Path: <stable+bounces-26671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F6A870F98
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62FBF281666
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030757992E;
	Mon,  4 Mar 2024 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x2AccVZT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74931C6AB;
	Mon,  4 Mar 2024 21:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589376; cv=none; b=rUNvqOnJL1DgOoosP4ktAC8ZzSjmOuJuh4XhlKnxD6dPzjahq+WCpI82tLyNj+dif9Y1UCeScpf/hL1AUj29sw1LxXWN77e7faENOu32m10GV0kKffX0Du6S3FybWSXX0DWu+9bJQm5h/wVzlv7ePNK1D+L+koqUWR5vD2CkmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589376; c=relaxed/simple;
	bh=A0HFv/h50gW4DwAwTpCaudhMU7ZlxjCSFrW3QwWkw5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAb4oWddJRanOLHpj6e9S/sKvr52M/767xQM7o5FWx10p35cZpDpxGfXFn2pRTu5lksYKZKkqaepUPpW46Kv61+EEW/D/k+E1bpjwpGwLFvR6wo302DsB2mGyFZpFZm4eQaMdNZSP3g9bZpCv1e4EWzx6P30AaIKMScbflpi3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x2AccVZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1633C433F1;
	Mon,  4 Mar 2024 21:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709589376;
	bh=A0HFv/h50gW4DwAwTpCaudhMU7ZlxjCSFrW3QwWkw5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x2AccVZT/+c0mE8udh+FDMqKuIXHFlXBO5YePze3u1V2P/f2ZCZta9AwaS1JFP9t2
	 REmsH8sf9K/se2Ou2L8xTfakae0FEgTlFhFaGkEg0Nh4dRzDHDRSgh07Tu9parNrU4
	 91gTT2rJm3CCpaQfvCu34bxC4ZkPE5Xp6FAT6TGM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	syzbot+ecab4d36f920c3574bf9@syzkaller.appspotmail.com
Subject: [PATCH 5.15 73/84] af_unix: Drop oob_skb ref before purging queue in GC.
Date: Mon,  4 Mar 2024 21:24:46 +0000
Message-ID: <20240304211544.833096606@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211542.332206551@linuxfoundation.org>
References: <20240304211542.332206551@linuxfoundation.org>
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

commit aa82ac51d63328714645c827775d64dbfd9941f3 upstream.

syzbot reported another task hung in __unix_gc().  [0]

The current while loop assumes that all of the left candidates
have oob_skb and calling kfree_skb(oob_skb) releases the remaining
candidates.

However, I missed a case that oob_skb has self-referencing fd and
another fd and the latter sk is placed before the former in the
candidate list.  Then, the while loop never proceeds, resulting
the task hung.

__unix_gc() has the same loop just before purging the collected skb,
so we can call kfree_skb(oob_skb) there and let __skb_queue_purge()
release all inflight sockets.

[0]:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 2784 Comm: kworker/u4:8 Not tainted 6.8.0-rc4-syzkaller-01028-g71b605d32017 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events_unbound __unix_gc
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:200
Code: 89 fb e8 23 00 00 00 48 8b 3d 84 f5 1a 0c 48 89 de 5b e9 43 26 57 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 04 24 65 48 8b 0d 90 52 70 7e 65 8b 15 91 52 70
RSP: 0018:ffffc9000a17fa78 EFLAGS: 00000287
RAX: ffffffff8a0a6108 RBX: ffff88802b6c2640 RCX: ffff88802c0b3b80
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc9000a17fbf0 R08: ffffffff89383f1d R09: 1ffff1100ee5ff84
R10: dffffc0000000000 R11: ffffed100ee5ff85 R12: 1ffff110056d84ee
R13: ffffc9000a17fae0 R14: 0000000000000000 R15: ffffffff8f47b840
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffef5687ff8 CR3: 0000000029b34000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __unix_gc+0xe69/0xf40 net/unix/garbage.c:343
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>

Reported-and-tested-by: syzbot+ecab4d36f920c3574bf9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ecab4d36f920c3574bf9
Fixes: 25236c91b5ab ("af_unix: Fix task hung while purging oob_skb in GC.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/unix/garbage.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -284,9 +284,17 @@ void unix_gc(void)
 	 * which are creating the cycle(s).
 	 */
 	skb_queue_head_init(&hitlist);
-	list_for_each_entry(u, &gc_candidates, link)
+	list_for_each_entry(u, &gc_candidates, link) {
 		scan_children(&u->sk, inc_inflight, &hitlist);
 
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+		if (u->oob_skb) {
+			kfree_skb(u->oob_skb);
+			u->oob_skb = NULL;
+		}
+#endif
+	}
+
 	/* not_cycle_list contains those sockets which do not make up a
 	 * cycle.  Restore these to the inflight list.
 	 */
@@ -314,18 +322,6 @@ void unix_gc(void)
 	/* Here we are. Hitlist is filled. Die. */
 	__skb_queue_purge(&hitlist);
 
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-	while (!list_empty(&gc_candidates)) {
-		u = list_entry(gc_candidates.next, struct unix_sock, link);
-		if (u->oob_skb) {
-			struct sk_buff *skb = u->oob_skb;
-
-			u->oob_skb = NULL;
-			kfree_skb(skb);
-		}
-	}
-#endif
-
 	spin_lock(&unix_gc_lock);
 
 	/* There could be io_uring registered files, just push them back to



