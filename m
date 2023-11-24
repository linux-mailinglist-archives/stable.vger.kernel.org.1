Return-Path: <stable+bounces-1447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4667F7FB6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9ADB2186F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAE138DE8;
	Fri, 24 Nov 2023 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Cfkhv/Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BAD33CCD;
	Fri, 24 Nov 2023 18:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C580C433C7;
	Fri, 24 Nov 2023 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851421;
	bh=t+utuZh8L9WEzsagRNWinQWh0PVzqEvT6ycASvPLIJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Cfkhv/Z3Zvx5cuI2jGm78r7OpCUttkpTW+ZF/ZLSBZDt+gGQACBfP4fIUZwZ+lsP
	 c9aCaP7QC5bqTdcVBVkpGPboFcin2DcK/rXmwSaqPKCG2JLRoKemynBzIEb8OhC6F6
	 /blVPGclpjGF1X+QQf0ltwhKhiXLwryyLJKFs4u0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Paasch <cpaasch@apple.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5 442/491] mptcp: deal with large GSO size
Date: Fri, 24 Nov 2023 17:51:18 +0000
Message-ID: <20231124172037.886743132@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit 9fce92f050f448a0d1ddd9083ef967d9930f1e52 upstream.

After the blamed commit below, the TCP sockets (and the MPTCP subflows)
can build egress packets larger than 64K. That exceeds the maximum DSS
data size, the length being misrepresent on the wire and the stream being
corrupted, as later observed on the receiver:

  WARNING: CPU: 0 PID: 9696 at net/mptcp/protocol.c:705 __mptcp_move_skbs_from_subflow+0x2604/0x26e0
  CPU: 0 PID: 9696 Comm: syz-executor.7 Not tainted 6.6.0-rc5-gcd8bdf563d46 #45
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
  netlink: 8 bytes leftover after parsing attributes in process `syz-executor.4'.
  RIP: 0010:__mptcp_move_skbs_from_subflow+0x2604/0x26e0 net/mptcp/protocol.c:705
  RSP: 0018:ffffc90000006e80 EFLAGS: 00010246
  RAX: ffffffff83e9f674 RBX: ffff88802f45d870 RCX: ffff888102ad0000
  netlink: 8 bytes leftover after parsing attributes in process `syz-executor.4'.
  RDX: 0000000080000303 RSI: 0000000000013908 RDI: 0000000000003908
  RBP: ffffc90000007110 R08: ffffffff83e9e078 R09: 1ffff1100e548c8a
  R10: dffffc0000000000 R11: ffffed100e548c8b R12: 0000000000013908
  R13: dffffc0000000000 R14: 0000000000003908 R15: 000000000031cf29
  FS:  00007f239c47e700(0000) GS:ffff88811b200000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f239c45cd78 CR3: 000000006a66c006 CR4: 0000000000770ef0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
  PKRU: 55555554
  Call Trace:
   <IRQ>
   mptcp_data_ready+0x263/0xac0 net/mptcp/protocol.c:819
   subflow_data_ready+0x268/0x6d0 net/mptcp/subflow.c:1409
   tcp_data_queue+0x21a1/0x7a60 net/ipv4/tcp_input.c:5151
   tcp_rcv_established+0x950/0x1d90 net/ipv4/tcp_input.c:6098
   tcp_v6_do_rcv+0x554/0x12f0 net/ipv6/tcp_ipv6.c:1483
   tcp_v6_rcv+0x2e26/0x3810 net/ipv6/tcp_ipv6.c:1749
   ip6_protocol_deliver_rcu+0xd6b/0x1ae0 net/ipv6/ip6_input.c:438
   ip6_input+0x1c5/0x470 net/ipv6/ip6_input.c:483
   ipv6_rcv+0xef/0x2c0 include/linux/netfilter.h:304
   __netif_receive_skb+0x1ea/0x6a0 net/core/dev.c:5532
   process_backlog+0x353/0x660 net/core/dev.c:5974
   __napi_poll+0xc6/0x5a0 net/core/dev.c:6536
   net_rx_action+0x6a0/0xfd0 net/core/dev.c:6603
   __do_softirq+0x184/0x524 kernel/softirq.c:553
   do_softirq+0xdd/0x130 kernel/softirq.c:454

Address the issue explicitly bounding the maximum GSO size to what MPTCP
actually allows.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/450
Fixes: 7c4e983c4f3c ("net: allow gso_max_size to exceed 65536")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-1-7b9cd6a7b7f4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1233,6 +1233,8 @@ static void mptcp_update_infinite_map(st
 	mptcp_do_fallback(ssk);
 }
 
+#define MPTCP_MAX_GSO_SIZE (GSO_LEGACY_MAX_SIZE - (MAX_TCP_HEADER + 1))
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1259,6 +1261,8 @@ static int mptcp_sendmsg_frag(struct soc
 		return -EAGAIN;
 
 	/* compute send limit */
+	if (unlikely(ssk->sk_gso_max_size > MPTCP_MAX_GSO_SIZE))
+		ssk->sk_gso_max_size = MPTCP_MAX_GSO_SIZE;
 	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
 	copy = info->size_goal;
 



