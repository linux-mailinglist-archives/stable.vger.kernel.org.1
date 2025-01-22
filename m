Return-Path: <stable+bounces-110155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E45A190CB
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 12:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA5D165279
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 11:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E498211492;
	Wed, 22 Jan 2025 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="yOp90+YB"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360B0189902
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546116; cv=none; b=dN5r37N3oEnshvD5ZC0/SMBoYiZu2iJG6QuVzjeitW0YKhu6m0w30yfA2OGFatEOOdRvzs1FtsT4CecAFQmVDWu64VKvnsdzf7HA5TsZe2FdWim1gFMZOQOG7TGQBujNKGKSzMhYsr4IXFH3loLEo7JEiUcHRKp0Nodgle4m8fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546116; c=relaxed/simple;
	bh=gNIwvmGRTIBCTR3fl88Pr2UAvT4mrz9x/4d64Tbftxc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=TapLiYaYcVV6M1iHc2/Ow5FLNshDa+XplqvJIcmof92DJSKGsI2ouLSyC3420WGts9QURppfQNDDDcvYbUP7WUwC+axmQF0XyMSts1b/sC64DLrB8BDP/6PcLA4agXni1Gaa4i7xViZt2BYrWAn1ZKqMJQDX+tosXTrRe3SKVKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=yOp90+YB; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1737546109;
	bh=qb4Ogy5qj+Q9Si/BMU+XzJFy6cgjKofjVXkNndiEgWo=;
	h=From:To:Cc:Subject:Date;
	b=yOp90+YBcJF37M22msE9Izjj7V7IY6ZgdE2KVo7qAs0+MI54+V+GG18UUaLu4GXGK
	 qcOfYdsKdhhcuO1O3eq5tNZttI7yVkUbHvV3U90eJbboCdcWHf1TUxaX91u0LSoSRT
	 Kz95+QrNJpKum7Og6Knzi9GMVWc/SghbqVCslwVQ=
Received: from public ([120.244.194.224])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 8D4B6C2F; Wed, 22 Jan 2025 19:35:20 +0800
X-QQ-mid: xmsmtpt1737545720txz07ob67
Message-ID: <tencent_CBAD5F0DF387BE24BC3518CE3A4C56833D06@qq.com>
X-QQ-XMAILINFO: OL2sWtCwO8Ndx6fWG4SMWVrilnI3YXLlNpWEsHYBaYSoAGDFJ0gSs9ATSc6p93
	 CZqMAuu5bz2XKVDxlquuQWUfW7TLDLaRSsjtKosw9WcpM8SIEMqWVQ/8ld5NHB3thOuo7l+ihuMq
	 N/MGDeCkAnKimNyaq+WFDRREOr4QN9tYeZhriabi2W/zs08CfYVUjbpk5/Ok7WuKfWUf6YI1Cdu+
	 mU5noehwH3gDqIRR/3WVo8cXJv+HQMTfCGj5IvfTDnEnZpmSGOGa/UlR2z+ka08SM5oCzM/ddt75
	 b/DmAETH0KsnDqyuhbDf1RDMfz3NpBP5GJI8SACqlvd147niur6n7tl/Fq84OqsYlPYq1ZtrDp5O
	 RMMDSDLmwY+2kI+AYAC2HA7RvZXRBYovEhugpz2SX/FWdvZUBiQZ8wJcPqkn1fm1p39Zr6QXyGdE
	 YoG1exIVzGE/4u/1plZn4kx9w5b5P7xdk0aKnNBSRbi96I5pA+a3+aKOUhy67LKTFztPN2oRZSKx
	 mHolmBSQUMcN23iEXB8h1wnXZ9EOqfgVdO/4+tAvcYekzq3awu4kjMwPMKFLDZm082RQ5xmydDQ9
	 MAprK4zB/Haj+2la85mgUJv2Ftkz47pwturQ6S7Yq6Hg0oVE4WgDJXooeyWIxza/Kz3bKNdTjEI+
	 BBpGoZaL1ZMsudxjSFOv0MXf9VeuIneNulpAGyj/a+8mUsFTE6A0ZKhvsImBpUVwPQ+8zSjxJ3UQ
	 cY1YzIHzLWK5s+UN8urlVufuZX+Hnkq6y1EBdBjSuzPxRJyuDtNcw85XlnX9RaKERespch9/ZcUB
	 DUxB8yBwkSBcc7tinwzdHi0hjfybgXMmpVElEXZlw78QCaJkNm4Sywy5GmZ7T2Uotc8+wrBFf/tu
	 Ot1RAWnF3R24s7gv1CQM7SmvN7ouyOzk6yFDq3tQ3ewQAmvgflL7qtrw5gR5FnwJGlYk9rmXFNyn
	 7VV1mUifHq7oWQXLrDoI5/ffl3wbbZjd2DeaeWe400UpotpjiQ/X87u4hIWrKf
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Wang Liang <wangliang74@huawei.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.1.y v2] net: fix data-races around sk->sk_forward_alloc
Date: Wed, 22 Jan 2025 19:35:21 +0800
X-OQ-MSGID: <20250122113521.1924-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Liang <wangliang74@huawei.com>

commit 073d89808c065ac4c672c0a613a71b27a80691cb upstream.

Syzkaller reported this warning:
 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x1c5/0x1e0
 Modules linked in:
 CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc5 #26
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
 RIP: 0010:inet_sock_destruct+0x1c5/0x1e0
 Code: 24 12 4c 89 e2 5b 48 c7 c7 98 ec bb 82 41 5c e9 d1 18 17 ff 4c 89 e6 5b 48 c7 c7 d0 ec bb 82 41 5c e9 bf 18 17 ff 0f 0b eb 83 <0f> 0b eb 97 0f 0b eb 87 0f 0b e9 68 ff ff ff 66 66 2e 0f 1f 84 00
 RSP: 0018:ffffc9000008bd90 EFLAGS: 00010206
 RAX: 0000000000000300 RBX: ffff88810b172a90 RCX: 0000000000000007
 RDX: 0000000000000002 RSI: 0000000000000300 RDI: ffff88810b172a00
 RBP: ffff88810b172a00 R08: ffff888104273c00 R09: 0000000000100007
 R10: 0000000000020000 R11: 0000000000000006 R12: ffff88810b172a00
 R13: 0000000000000004 R14: 0000000000000000 R15: ffff888237c31f78
 FS:  0000000000000000(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007ffc63fecac8 CR3: 000000000342e000 CR4: 00000000000006f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? __warn+0x88/0x130
  ? inet_sock_destruct+0x1c5/0x1e0
  ? report_bug+0x18e/0x1a0
  ? handle_bug+0x53/0x90
  ? exc_invalid_op+0x18/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? inet_sock_destruct+0x1c5/0x1e0
  __sk_destruct+0x2a/0x200
  rcu_do_batch+0x1aa/0x530
  ? rcu_do_batch+0x13b/0x530
  rcu_core+0x159/0x2f0
  handle_softirqs+0xd3/0x2b0
  ? __pfx_smpboot_thread_fn+0x10/0x10
  run_ksoftirqd+0x25/0x30
  smpboot_thread_fn+0xdd/0x1d0
  kthread+0xd3/0x100
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x34/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 ---[ end trace 0000000000000000 ]---

Its possible that two threads call tcp_v6_do_rcv()/sk_forward_alloc_add()
concurrently when sk->sk_state == TCP_LISTEN with sk->sk_lock unlocked,
which triggers a data-race around sk->sk_forward_alloc:
tcp_v6_rcv
    tcp_v6_do_rcv
        skb_clone_and_charge_r
            sk_rmem_schedule
                __sk_mem_schedule
                    sk_forward_alloc_add()
            skb_set_owner_r
                sk_mem_charge
                    sk_forward_alloc_add()
        __kfree_skb
            skb_release_all
                skb_release_head_state
                    sock_rfree
                        sk_mem_uncharge
                            sk_forward_alloc_add()
                            sk_mem_reclaim
                                // set local var reclaimable
                                __sk_mem_reclaim
                                    sk_forward_alloc_add()

In this syzkaller testcase, two threads call
tcp_v6_do_rcv() with skb->truesize=768, the sk_forward_alloc changes like
this:
 (cpu 1)             | (cpu 2)             | sk_forward_alloc
 ...                 | ...                 | 0
 __sk_mem_schedule() |                     | +4096 = 4096
                     | __sk_mem_schedule() | +4096 = 8192
 sk_mem_charge()     |                     | -768  = 7424
                     | sk_mem_charge()     | -768  = 6656
 ...                 |    ...              |
 sk_mem_uncharge()   |                     | +768  = 7424
 reclaimable=7424    |                     |
                     | sk_mem_uncharge()   | +768  = 8192
                     | reclaimable=8192    |
 __sk_mem_reclaim()  |                     | -4096 = 4096
                     | __sk_mem_reclaim()  | -8192 = -4096 != 0

The skb_clone_and_charge_r() should not be called in tcp_v6_do_rcv() when
sk->sk_state is TCP_LISTEN, it happens later in tcp_v6_syn_recv_sock().
Fix the same issue in dccp_v6_do_rcv().

Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
Link: https://patch.msgid.link/20241107023405.889239-1-wangliang74@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
v2: For I had sent the patch two times, I added v2 to the subject to distinguish it from the v1 version.
---
 net/dccp/ipv6.c     | 2 +-
 net/ipv6/tcp_ipv6.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index d90bb941f2ad..8f5f56b1e5f8 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -615,7 +615,7 @@ static int dccp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	   by tcp. Feel free to propose better solution.
 					       --ANK (980728)
 	 */
-	if (np->rxopt.all)
+	if (np->rxopt.all && sk->sk_state != DCCP_LISTEN)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
 	if (sk->sk_state == DCCP_OPEN) { /* Fast path */
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 06b4acbfd314..0ccaa78f6ff3 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1463,7 +1463,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	   by tcp. Feel free to propose better solution.
 					       --ANK (980728)
 	 */
-	if (np->rxopt.all)
+	if (np->rxopt.all && sk->sk_state != TCP_LISTEN)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
 	reason = SKB_DROP_REASON_NOT_SPECIFIED;
@@ -1502,8 +1502,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 		if (nsk != sk) {
 			if (tcp_child_process(sk, nsk, skb))
 				goto reset;
-			if (opt_skb)
-				__kfree_skb(opt_skb);
 			return 0;
 		}
 	} else
-- 
2.43.0


