Return-Path: <stable+bounces-86911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 820D49A4CDF
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 12:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CC61F22755
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F661DE4CE;
	Sat, 19 Oct 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdqADpZt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC4556B81;
	Sat, 19 Oct 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729333758; cv=none; b=Zg6xj7Qoevd1jIZFRIj6uy2/azcqhUPd+4W0LVKdhKhK7NjG849kPqJezNCkzBMt1L7UNHdydinQoTWmdL4iA/TQPkdE5cdzJqQz84veWj8IK5mruTduxc6rK8bJ6eUpAzZbS4sJyUinR2/rhicLk5BW5YsI7mo09ANha3XNIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729333758; c=relaxed/simple;
	bh=K5YBnONewniJvt0wp3E4MXTUXkSnW9pxnlKxUvgNGuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I62ekEyMSIkJVA3LYMj46b8MaWm1IbRBGczpNoPs9544jJriFDt0exUazwcq0pMo21+UHD05TAV845kcyJoU2BuQ0jP78FHleHP0fDmxE6eUH8ZaPRROjgwt0ciPbzViGUi9BMpzTEI3CrBQQVu/8iH6l2CaG1jyEpQ6U8ZNGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdqADpZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DEFC4CEC5;
	Sat, 19 Oct 2024 10:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729333757;
	bh=K5YBnONewniJvt0wp3E4MXTUXkSnW9pxnlKxUvgNGuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rdqADpZt9SCTdAksSDRDj+DnO2uDZ9HCw6pecfSPwvaIp6IWyyd1sRjsEJK+ng1ir
	 dQBLJrFM4CkXceBFsn1/RLZpTUpSpHI5fHryl4M57p2oN3G5HYqCwYhnWNrD0Tb1ZG
	 piSjFpjcXL9AGX0cVVZJ4exoMfvX+geXZUPamo7KpBzfSTKrle0ckqvjoAbGubHPNE
	 jEcg5qaEkvchny76RRM2rtVf7YcvKVRy1pRb3vIiRKOb4xV2fDh+MRje7s5lZ/RQFk
	 5ViY9oTdRxr1jZ9dJv8zCUUvgjX4+YXLzm4Yik5622yitpEWn4EvoHpCzN5nPAy/Q6
	 uLK0X6Iu0ZEyw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	syzbot+d1bff73460e33101f0e7@syzkaller.appspotmail.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y 3/3] tcp: fix mptcp DSS corruption due to large pmtu xmit
Date: Sat, 19 Oct 2024 12:29:09 +0200
Message-ID: <20241019102905.3383483-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241019102905.3383483-5-matttbe@kernel.org>
References: <20241019102905.3383483-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7338; i=matttbe@kernel.org; h=from:subject; bh=ojETHMOMRvRrt27eZAhBiLeAAWqHvBX3+PNF4zvFgv4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnE4nxV3Wulu1CFGAxP59/ItPweWFrC0j0gBLom apHaspmdD2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxOJ8QAKCRD2t4JPQmmg c73bEAC0v+iXHAlBee3U9Za3eOTyiO8dDycVCcNj8DCl4Ro2OkJoVRyqSE5lOUTWN24mfuYepZK 4FQ3lggRKIo9ZKvw5NJBWfZ5L9bTpwp/5iQsHzj2m1Dx+aB+jiNu37rItclDOL03wc6Y3VMNHHX oPbMHa7iLLhDW2I3pZi6Xyb4RflYR19ijeZTwfLtVjzaIo6yXkKxK7Ih+uXqBFU+R7eEi0uh7EN 1s4sWZhMdEVY9pBmTM/9g95+tZtiHJpb2iP1HLdrqMpy9FDvb8FpQYMMkSFkvhuEnwX5YWBTV3k oCf/VSfOiGrYsv7nnDt2Xv+w/6tTv7evtqy2dglM4lafeWidXkhj8hUEA2AV7tsIS8M5d51LuNz C1JyFpw+TzdMGEabUQAcj28iciskKjbMB6YsfSW1+jgIPlaV7ZV6uzQ9uu+Du0VarRi0pW8Lssj +uskt6gNPXb0IyWr+7gzbm8BL/cA3j8UY7/LBnvCB2O4jtOYzsh8pr+9wVtZEHh2tflCBJRXY8h iDddiGUSwvtXvHgUA8zL8StYiPhOzx8cwZxHfs6WQ/T7Hwgn0N2QDi/0BxP1fRc9t/3ix+hGZIy cFoBP713dosF6UlT9CJjHKmSZNPoiWsRGGtJ+XYVUptloITtCfHOjCdV08GqZ+wb8izvk4D9CFj osQ5MWtaua/4Fig==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 4dabcdf581217e60690467a37c956a5b8dbc6bd9 upstream.

Syzkaller was able to trigger a DSS corruption:

  TCP: request_sock_subflow_v4: Possible SYN flooding on port [::]:20002. Sending cookies.
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 5227 at net/mptcp/protocol.c:695 __mptcp_move_skbs_from_subflow+0x20a9/0x21f0 net/mptcp/protocol.c:695
  Modules linked in:
  CPU: 0 UID: 0 PID: 5227 Comm: syz-executor350 Not tainted 6.11.0-syzkaller-08829-gaf9c191ac2a0 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
  RIP: 0010:__mptcp_move_skbs_from_subflow+0x20a9/0x21f0 net/mptcp/protocol.c:695
  Code: 0f b6 dc 31 ff 89 de e8 b5 dd ea f5 89 d8 48 81 c4 50 01 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 98 da ea f5 90 <0f> 0b 90 e9 47 ff ff ff e8 8a da ea f5 90 0f 0b 90 e9 99 e0 ff ff
  RSP: 0018:ffffc90000006db8 EFLAGS: 00010246
  RAX: ffffffff8ba9df18 RBX: 00000000000055f0 RCX: ffff888030023c00
  RDX: 0000000000000100 RSI: 00000000000081e5 RDI: 00000000000055f0
  RBP: 1ffff110062bf1ae R08: ffffffff8ba9cf12 R09: 1ffff110062bf1b8
  R10: dffffc0000000000 R11: ffffed10062bf1b9 R12: 0000000000000000
  R13: dffffc0000000000 R14: 00000000700cec61 R15: 00000000000081e5
  FS:  000055556679c380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000020287000 CR3: 0000000077892000 CR4: 00000000003506f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <IRQ>
   move_skbs_to_msk net/mptcp/protocol.c:811 [inline]
   mptcp_data_ready+0x29c/0xa90 net/mptcp/protocol.c:854
   subflow_data_ready+0x34a/0x920 net/mptcp/subflow.c:1490
   tcp_data_queue+0x20fd/0x76c0 net/ipv4/tcp_input.c:5283
   tcp_rcv_established+0xfba/0x2020 net/ipv4/tcp_input.c:6237
   tcp_v4_do_rcv+0x96d/0xc70 net/ipv4/tcp_ipv4.c:1915
   tcp_v4_rcv+0x2dc0/0x37f0 net/ipv4/tcp_ipv4.c:2350
   ip_protocol_deliver_rcu+0x22e/0x440 net/ipv4/ip_input.c:205
   ip_local_deliver_finish+0x341/0x5f0 net/ipv4/ip_input.c:233
   NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
   NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
   __netif_receive_skb_one_core net/core/dev.c:5662 [inline]
   __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5775
   process_backlog+0x662/0x15b0 net/core/dev.c:6107
   __napi_poll+0xcb/0x490 net/core/dev.c:6771
   napi_poll net/core/dev.c:6840 [inline]
   net_rx_action+0x89b/0x1240 net/core/dev.c:6962
   handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
   do_softirq+0x11b/0x1e0 kernel/softirq.c:455
   </IRQ>
   <TASK>
   __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
   local_bh_enable include/linux/bottom_half.h:33 [inline]
   rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
   __dev_queue_xmit+0x1764/0x3e80 net/core/dev.c:4451
   dev_queue_xmit include/linux/netdevice.h:3094 [inline]
   neigh_hh_output include/net/neighbour.h:526 [inline]
   neigh_output include/net/neighbour.h:540 [inline]
   ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:236
   ip_local_out net/ipv4/ip_output.c:130 [inline]
   __ip_queue_xmit+0x118c/0x1b80 net/ipv4/ip_output.c:536
   __tcp_transmit_skb+0x2544/0x3b30 net/ipv4/tcp_output.c:1466
   tcp_transmit_skb net/ipv4/tcp_output.c:1484 [inline]
   tcp_mtu_probe net/ipv4/tcp_output.c:2547 [inline]
   tcp_write_xmit+0x641d/0x6bf0 net/ipv4/tcp_output.c:2752
   __tcp_push_pending_frames+0x9b/0x360 net/ipv4/tcp_output.c:3015
   tcp_push_pending_frames include/net/tcp.h:2107 [inline]
   tcp_data_snd_check net/ipv4/tcp_input.c:5714 [inline]
   tcp_rcv_established+0x1026/0x2020 net/ipv4/tcp_input.c:6239
   tcp_v4_do_rcv+0x96d/0xc70 net/ipv4/tcp_ipv4.c:1915
   sk_backlog_rcv include/net/sock.h:1113 [inline]
   __release_sock+0x214/0x350 net/core/sock.c:3072
   release_sock+0x61/0x1f0 net/core/sock.c:3626
   mptcp_push_release net/mptcp/protocol.c:1486 [inline]
   __mptcp_push_pending+0x6b5/0x9f0 net/mptcp/protocol.c:1625
   mptcp_sendmsg+0x10bb/0x1b10 net/mptcp/protocol.c:1903
   sock_sendmsg_nosec net/socket.c:730 [inline]
   __sock_sendmsg+0x1a6/0x270 net/socket.c:745
   ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2603
   ___sys_sendmsg net/socket.c:2657 [inline]
   __sys_sendmsg+0x2aa/0x390 net/socket.c:2686
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7fb06e9317f9
  Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007ffe2cfd4f98 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
  RAX: ffffffffffffffda RBX: 00007fb06e97f468 RCX: 00007fb06e9317f9
  RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000005
  RBP: 00007fb06e97f446 R08: 0000555500000000 R09: 0000555500000000
  R10: 0000555500000000 R11: 0000000000000246 R12: 00007fb06e97f406
  R13: 0000000000000001 R14: 00007ffe2cfd4fe0 R15: 0000000000000003
   </TASK>

Additionally syzkaller provided a nice reproducer. The repro enables
pmtu on the loopback device, leading to tcp_mtu_probe() generating
very large probe packets.

tcp_can_coalesce_send_queue_head() currently does not check for
mptcp-level invariants, and allowed the creation of cross-DSS probes,
leading to the mentioned corruption.

Address the issue teaching tcp_can_coalesce_send_queue_head() about
mptcp using the tcp_skb_can_collapse(), also reducing the code
duplication.

Fixes: 85712484110d ("tcp: coalesce/collapse must respect MPTCP extensions")
Cc: stable@vger.kernel.org
Reported-by: syzbot+d1bff73460e33101f0e7@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/513
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241008-net-mptcp-fallback-fixes-v1-2-c6fb8e93e551@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflict in tcp_output.c, because commit 65249feb6b3d ("net: add
  support for skbs with unreadable frags"), and commit 9b65b17db723
  ("net: avoid double accounting for pure zerocopy skbs") are not in
  this version. These commits are linked to new features and introduce
  new conditions which cause the conflicts. Resolving this is easy: we
  can ignore the missing new condition, and use tcp_skb_can_collapse()
  like in the original patch. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 68f1633c477a..165be30e42c0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2305,7 +2305,7 @@ static bool tcp_can_coalesce_send_queue_head(struct sock *sk, int len)
 		if (len <= skb->len)
 			break;
 
-		if (unlikely(TCP_SKB_CB(skb)->eor) || tcp_has_tx_tstamp(skb))
+		if (tcp_has_tx_tstamp(skb) || !tcp_skb_can_collapse(skb, next))
 			return false;
 
 		len -= skb->len;
-- 
2.45.2


