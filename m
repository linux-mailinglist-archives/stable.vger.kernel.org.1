Return-Path: <stable+bounces-86873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94FF9A44D2
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 19:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19D11C238E2
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 17:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81510204030;
	Fri, 18 Oct 2024 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRjKZEQT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342D22022D6;
	Fri, 18 Oct 2024 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273024; cv=none; b=Qgn53wwL5QeIplz5RdCWzGKrUgjfOIzPci0XpgHMRVzUX6x9BsGRUW8vZdHo4P7nEuqHo0cAEL5ls6IGjmz6Abwiug//cbscJzXwacxr7JEbLxiskPqiCQWpLRHkvibU9Es8qbKJyAIIwcHUXe/WyKy4qniaZ3tKM+8MFhnJjE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273024; c=relaxed/simple;
	bh=RSrTbfgfiEGVpf4xw9lIX7c7tf5aEINM1hgGOILLrio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYUQrGJZZFQ5hhgEJFFcfcgZ3ikBrxZ3VhSIfPcRsS4BkMDzqJoVPCd2Sj3PEmwMz9OSlVp8tnPMFM3KMmwRONk8wnnDWjMLptYSY2iI7kQ4LvCclg9qbT+qsnnTNKJaNMSXWiWoEhAnlCx0Gn6OheUNcmqVFWAEsyxresYM4aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRjKZEQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F167DC4CEC5;
	Fri, 18 Oct 2024 17:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273023;
	bh=RSrTbfgfiEGVpf4xw9lIX7c7tf5aEINM1hgGOILLrio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRjKZEQTTelgfoIm6p1wlDYvAHztF+KDLzb7OACyW4Y2XxwBMF3eR9xgc+10ZICVp
	 lkkItUuW3MaWQqnn2+Z+ZpEBxjvxlIlRclL6E+eByy5aCQymaD0zLBQu5Hto8adrTb
	 yQdvoMB6a0n3PW0fIG4h4T0bN9Ur0Gnu3gJNfB3sbCYWFH9gB9oHP7CKNXOav7LNG9
	 dZgR5auuMfVN7fxAiFg+HABGG1I+wSJVpTHgS5/YL/cNE2h5740ZAf51H1/Zc/kdL8
	 RyNe4LZ45rXALRPzkUd31FAck4n5DUK5yOIGVkJewi2gkndGAvJEN/mqf/FOMCNObd
	 CMyZ0287TIECg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	syzbot+d1bff73460e33101f0e7@syzkaller.appspotmail.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 1/2] tcp: fix mptcp DSS corruption due to large pmtu xmit
Date: Fri, 18 Oct 2024 19:36:58 +0200
Message-ID: <20241018173656.2813913-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018173656.2813913-4-matttbe@kernel.org>
References: <20241018173656.2813913-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7325; i=matttbe@kernel.org; h=from:subject; bh=C6Je/qgsfW9i/TK6d9fttdemKaxZwb2F+OI9ukvQQD0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnEpy4wScYTPV/HoLulYaxfPc8kC+Kpu97LnxPD x9Oz45CeWaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxKcuAAKCRD2t4JPQmmg c2kiD/9qxMvdGsVUO3G07d614WO6KKMZy/D6S8OEqf3T+aV/dDOo3Q+Dww+MCiL8BHUgcW6qr5G oLVavHE7AaKflJT3j27nSLn9qnTtIwg3RutmTp0wz4fvSReCKFGgbdWllEdYaHrz5rZ+vxnqI93 /bCq98l/jpjuWZCgEgg1iVNtQnTWJ+XPlzn3GucegCOHpdkDa3gXJ+BogW2plXbExbDPsodgGiQ HbIZkaNIi61ST0zHMpB05ifWB5Ob026DRghblwIG5fzHuVs/dEci/PgRktDj335ST61MwZ5GD27 vFA5gl5jwI6Ip8uJ2I1OeciE1eLFQBBFqRPDImkOW5EzEmEyMAWtvhbYs6UvW1dTxXJL3+O8ZY2 HN6kTmUXo2OKWL8zEOv4AApcMvCUvpOb2Btt8HuD3Z3fEjfy370hjvrbLLL29Z7DvIXDSK5GZDp 3mwuTngyUxan1DxFuarEJb3I61FrQu2liN2NhfqCLDUg5xdZ1dzYKUVKQ+IJumkZhtWlalafkWL ombHRAQkWAOfSjTgbyo8Aer4ARLF4bmN+YFS5CEgQ0zkjIPbAM7kpzKYevvKlareTGfljT5Mf6u Zy91MoRfYrcHSj1ff4HllaFLdxN8sM85HN9eUet0EvVZ2g2h+u/O+qoceT0gBs0aSgRtoTiWKZG XUhLy/1ATwgJ8hQ==
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
[ Conflict in tcp_output.c, because the commit 65249feb6b3d ("net: add
  support for skbs with unreadable frags") is not in this version. This
  commit is linked to a new feature (Devmem TCP) and introduces a new
  condition which causes the conflicts. Resolving this is easy: we can
  ignore the missing new condition, and use tcp_skb_can_collapse() like
  in the original patch. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/ipv4/tcp_output.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 19b5a6179c06..3f54b76bc281 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2312,9 +2312,7 @@ static bool tcp_can_coalesce_send_queue_head(struct sock *sk, int len)
 		if (len <= skb->len)
 			break;
 
-		if (unlikely(TCP_SKB_CB(skb)->eor) ||
-		    tcp_has_tx_tstamp(skb) ||
-		    !skb_pure_zcopy_same(skb, next))
+		if (tcp_has_tx_tstamp(skb) || !tcp_skb_can_collapse(skb, next))
 			return false;
 
 		len -= skb->len;
-- 
2.45.2


