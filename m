Return-Path: <stable+bounces-109625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD47A1801B
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 15:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1621167533
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 14:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5614A1F4279;
	Tue, 21 Jan 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="O26jnKtY"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A0B1F3D5D
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470345; cv=none; b=RRY4q5ZGkDPHWu0yUxjucsDaXmckc2fErCROFzC0/bTjOcs8q2Wkx8btEDoGeZi8TaBagENw4gt4H1Cv2ex78SOdRIOKL7h4QV6v8FOVahUOQYgnn5S5PI8hqadBa3UFiuUnHNE0fE9VM9CLuQNM2Nl2NWvKbZL3Ar6rYSueRJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470345; c=relaxed/simple;
	bh=Noln/25our2QOnRN8xWHv7+OXONefvzLOzn7wozz0CA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=TYK3GT3E8FdrbvyF0XNBx7VKsXHTqSbLxNqCGXfp7jHoGI47cg1IwXkrZsBaChxIKYxoozo2qSYfMBm+RZDzyTxpwrgDcBphqv2jWsJyzs5OohiVjDAaw51WzaVgC/3TCGSu1ByaTX6TKiGry8m466SMKZCLI3yMxh3B2EC5We0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=O26jnKtY; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1737470331;
	bh=1b9nqOLaHQiA617CC+iMUWDBMshR+HhEkRMqv3X/lNo=;
	h=From:To:Cc:Subject:Date;
	b=O26jnKtYSLUuAo/hU0JBA0qGiCywpWixzPZFJk/xqSefum3KgJOI22xAJoxDxnF8w
	 XAsLfY6ZyHC+FtixitillHbXm2misW/xsk7FeVOIW3QePytWJfNJAxvwbvqx0ewgFm
	 ZgpxSrsWL81A+bmqXuyCQFST0sr8E7/HNFedSX04=
Received: from public ([120.244.194.224])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 9990E4AF; Tue, 21 Jan 2025 22:38:25 +0800
X-QQ-mid: xmsmtpt1737470305t4ksweqzw
Message-ID: <tencent_A0C9136B409C0E18FC860D5AE51A950F5007@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLjk3OCA4Qsf2wY0L4ZR+Z0/AAvX8N3kaB7DTNzMruSsG4JoSl/n
	 deLX15KjWaB00PIdKlrW13tcal7npH83T6L3PutR4hjoMvT2H3vjroVtw/OxSCNTUBg1rAWz1I+Y
	 zHnuzJA+to051FMHQWBv5W1+ou24JJoD3h3KjJxKI6feq+VVrZSx++wDJFyfrKUQKUGMtr1xfqKy
	 Xn9uE9k5qThWiy2x+tuWNT6xthVwirWvPWcy8trgR+VXI3f8MQ7ZPHcQHXDkZIpFQI8YdChRXta+
	 r9YKXvWmZBJnrcof0hBtPygWTSraGv+YuqUzaVdAE5QitNMFcZU21jmdvKFTnNyx3vOdEypIEuM1
	 Lcrd2CMNMKNoS1CNNENjCVFMzEPFoD0K17rXR+dWe+mVmSQoWgHbkeaGS8YVliUeQnDqWyxIzOpO
	 l20CxfpFVWjQQ4OmZxbawUyT9BjDCAvZ/hVaKygPfbo0HbSQaDV9lwjLMoYU0qmX7JyH4IG9GEvY
	 tAHGeeQ9ZG9ZBozZkH8xxbYMZpSv1ssGAhNPp/qSIyLqxoal6ApnCO55+ew41a/581gxpPi8SfAH
	 KJitb4wuaa37qGuGLtbEI7Fv10zyTzZzs+Bci1HV1xS0T6z2a8ZCO+8NuA3Ilr9aaRhM6Qz8QXzL
	 Bpss/CZ0drntwBK1jEf0rj8mnFQlEG56xf4CZsTlbMQoO3wdcWyGD7NUmzrAWe5wfS2VawxYW9cE
	 fA65IW2HwA6cMMCFLdjZ0J6hHObJrVAEEpGHyH1DUF92Gf1h40Q2OS1dHP18Jsfir4recdfsg7Kl
	 /xRQ+44gTA7UU+Bd49w7BamTDxZ8Fyl1wp6Ddggro8GpR4mtNAqgkfu3isdB6v8cwGdf5NqiSaQ9
	 vECBO2LiMmKZXm9FCaiFV5x/EV9rAGi20fPqzz1lZ5Q8pnFKrJjQjHduGPUjLmY9dc8/K+31wYhw
	 TOfXkY59r+fsyXjVUBN4IhvkQUnUd/OMmp7qVuAWYhKpAytIsw5O6on88EobAXLoBSc5AuBmppTg
	 4hXiKuUYm2chZZE4v4IvisKZfYT2bgG/KsTZfbTqJy+nESSpWYQAetvQZhu0JYcGB1drx9oSVrHZ
	 MbLXK8
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Wang Liang <wangliang74@huawei.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.1.y] net: fix data-races around sk->sk_forward_alloc
Date: Tue, 21 Jan 2025 22:38:25 +0800
X-OQ-MSGID: <20250121143825.6781-1-alvalan9@foxmail.com>
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
Backport to fix CVE-2024-53124.
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-53124
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


