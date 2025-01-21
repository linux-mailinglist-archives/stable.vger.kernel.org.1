Return-Path: <stable+bounces-109623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF3BA17F9B
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 15:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0766418816F4
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 14:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB4E1F37BC;
	Tue, 21 Jan 2025 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xOPTquQT"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A01F03DC
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469293; cv=none; b=MjpXCGa+9wRQEvT7Mj/F21drtwb2H2vdr8ru7NtoTtCrEsTM2niHZYQrlxm8lh0IUqbdj0J0ww50D+0AaFokcsU5IcU35BddQzRil9sNkGPHyoPqqOEVR+HMg5yFUKwDxDSWyu31OOkddEtcqJ992xICyskWpj+WWQ2QWtsyoeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469293; c=relaxed/simple;
	bh=9knAtGh0/GIDd802jcbPcyMQXYDupyouv9XAIgwEM/w=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=QVu65Qz3wj3EZeFSUznvg5MWfFKP8/6+bq/URE6h7WwvMZXSo9eWj7/QXDKhO89t1HUSDsHg3Da20nRJAxXn1BKblXgjvAejjrCqRCoJLkj7IfhSlIMTl3Mup4FwXda7dyEVx8VPeZPclvZ2f27sJfyHJ8v5vJxUc08VO25UfOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xOPTquQT; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1737469285;
	bh=Nffq1Jir3ue4NKpHrXr002xyHfX/mQmj1kui1Hb7sKE=;
	h=From:To:Cc:Subject:Date;
	b=xOPTquQT5dziJtZ07kiND87yIvSoxLlbYNInPaN0i6KhYSVwVUcMQ+qnZfpYN+RFZ
	 Pomtu0glMNzzRtTHZAX+JrZunKYlr3uZ+BGDmJ+zslrkuDHAVjbhNEWGp4aYVmJaBV
	 ONiGx92/wMYruzBMhFeB5zQngbLHXXVQoPKY+Pdk=
Received: from public ([120.244.194.224])
	by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
	id 54B9A243; Tue, 21 Jan 2025 22:21:11 +0800
X-QQ-mid: xmsmtpt1737469271t4gfx12iu
Message-ID: <tencent_8BB43C35671F0A929BD6A938E8302B0DB808@qq.com>
X-QQ-XMAILINFO: OFGKNgQ2L1vP3qktqbCvkZHorT45NBzVn4k8cEgUiDjMnnF6lRcLPjxasc9c0+
	 EmY3qW3UwgB+RGKu+YdPM4gUbYGDINU4rmNUSRj46GYkWsDYAsEssVSrKHo5IDxAMnGFhXvKYOV3
	 QPAvKp1ESGyL/i21RWsG64f4pahBCXQRt/K0UOSnsgtsOXxdQuqSfn/13te4uo1sqAFPToad9R/i
	 WrR4ABLX2Zqn4xejvG57tkivqlhEKrDOUq5ngVgH6i28Kslk6Z0FkDYqpVw/DTHgVyTzi7UQJTnL
	 MD7UUo9Y1i9eyNdmqfIX7Lp0Pu0B90qwRkmWpPu3V0YuGWE8BF7MpJ8UhYftTJthg59ptbBUWIRE
	 rx2NfwgCbKR7p6YncotqCIjB9d8vMMq133zucLHX5A+vQVkD/vN+zk6FASThiIwdnMf5eC1vHp4r
	 PJKuGQjv6Y3LaFY7w3aVcaQyQa/nQTplhnyqVDXHOqpm8DVQ5bhf3WhnPnJLOI6VgAyJC2q/yWDX
	 WoSSRxWnlFTwR9dGtGxCPnPYdRFV3ZHbcYaaEo1b0/HmStam40O1faZT1okFr7VOKnafcJPMrDMH
	 ChyF1I17AIfXMZvzOx+FU9Gk3LaWOkTjx313s9B/D+pV5AdbKtxdQlNA6c7FtobgeNdKrK2RIUAs
	 CL6ZwrnsceJR/CSbbcgfLpXmnI7GqDXtPFCt2dWJNFULAX2R75MGOYeE7g4bsJvi2I0wTU5X8/9g
	 kFIcMwVovFKWB2AErYg4YgVTFmAGzlnH1yqGOrhBSHMErbby5CczzEA/69QrcR6wdw6C7ozFdbUF
	 5ydleX/Dl8CpVE0cx7vUbhUiuxrGgVVQGJ35mSmIHMmizqiGKd9XhE3w5pY2UWbVukfXm2N5Y6qH
	 k/sL8DyK7smX82amPz3WmZr95kW+vQzd/9AOVZUpIwdkLLR+5Kxrs2OE6ky3K5Kb7cZx8Vijg3ED
	 l51sc4va7yHIjzriLPUr4n7G16i04yA6lsiQM1OkiD9eLXVXt7CEjmjP6+7zdQ69iU++z7dL8YEO
	 BToeRzVXgWxkW6P6rVOUQtjfZwI7RvLr/aibL0Ew==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Wang Liang <wangliang74@huawei.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y] net: fix data-races around sk->sk_forward_alloc
Date: Tue, 21 Jan 2025 22:21:10 +0800
X-OQ-MSGID: <20250121142110.2605-1-alvalan9@foxmail.com>
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
index d25e962b18a5..2839ca8053ba 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -616,7 +616,7 @@ static int dccp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	   by tcp. Feel free to propose better solution.
 					       --ANK (980728)
 	 */
-	if (np->rxopt.all)
+	if (np->rxopt.all && sk->sk_state != DCCP_LISTEN)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
 	if (sk->sk_state == DCCP_OPEN) { /* Fast path */
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 64bdb6d978ee..f285e52b8b85 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1456,7 +1456,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	   by tcp. Feel free to propose better solution.
 					       --ANK (980728)
 	 */
-	if (np->rxopt.all)
+	if (np->rxopt.all && sk->sk_state != TCP_LISTEN)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
 	reason = SKB_DROP_REASON_NOT_SPECIFIED;
@@ -1495,8 +1495,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
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


