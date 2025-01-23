Return-Path: <stable+bounces-110318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C743A1A962
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 19:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F255D188B658
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9E318A6AE;
	Thu, 23 Jan 2025 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXnvaXcC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6206E13AD03;
	Thu, 23 Jan 2025 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655650; cv=none; b=jEJdkZnpKUqQrHG/UkJmKFoglU0+Ox0aIIp0mgxrYQt96oHJz5HTcylOJ5VMUDSf5yGjuLR5kN5KWYtDxx5+7jF6rVG/86no9wqb7fRuSJ+6ZLRvk8w5q6QS0yB6SlTWIZmiog1r35ZwpfS8yIKVeJOjpd9h5Ed7CeQaeMJnJik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655650; c=relaxed/simple;
	bh=Seni9OsU2OQmUa2Bh5hsYXVbX5BhW3gIxRzN9HeK6rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UvqC9qCAq3liVAU4CXiviTEE9rsZjbD0hnKeIkfwAZSJg1nwaoxFgVvdonBboqkk2x9QgbXySknsw+rDZeieFsRiS7DQN7JOAXOiEH0MMZLM+QiwAPIdUK1utUPb9i3mP+IgN5P98J6PgrAjK1hyC0GW9WanFTwKcYU/jt97Jz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXnvaXcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0995FC4CEE4;
	Thu, 23 Jan 2025 18:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737655649;
	bh=Seni9OsU2OQmUa2Bh5hsYXVbX5BhW3gIxRzN9HeK6rw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MXnvaXcC5T/hhV+AY/7IMJz06dAEr9TssXjF1gPLqXYI7sPNyB2Pr1v9u8LVlNpR0
	 fqW/s6paBc2+CKRrhoFOEj5jdU+W/PXYgVCHoVD2Z+TBGjHMxD7tUvG4QQod5dm/0T
	 UKnNUBS4Go/9G24LIjlgmCxfO+3xgb6Uewmoz75qbZ3unQmgu1zh4cSjYYkT7Utj3z
	 L3R9QQFh7iUe1L+ltgLXJJV/qSYQTE+sRdjs/RAv4kV28vj+7V0auJstbO2X2D2RJa
	 WBZ/WOgcGIv/HRh4L5yTmQ7nVBMR/XfSREsWL3tsGgNVJhKSKN4T2t/7DuVZUzjbqd
	 ukcLxhm9HVYoQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 23 Jan 2025 19:05:54 +0100
Subject: [PATCH net 1/3] mptcp: consolidate suboption status
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-net-mptcp-syzbot-issues-v1-1-af73258a726f@kernel.org>
References: <20250123-net-mptcp-syzbot-issues-v1-0-af73258a726f@kernel.org>
In-Reply-To: <20250123-net-mptcp-syzbot-issues-v1-0-af73258a726f@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+23728c2df58b3bd175ad@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15527; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=G/U+6PVXsSgzlAY4zlPWG7Si9rgEa2vOI/ylQaE31zE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnkoVbeeSvHm+xEuXCkIImilrYDgnD/ELLB7LV5
 m6lL+4Ap/2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ5KFWwAKCRD2t4JPQmmg
 c195D/wNE73i3NFxS7+vEwleEavvHcFbwSeO62iUin2okaZfKtGOUZX96GHp/2O7H443+ns3PRX
 BZQxc0ZLS49FrXimGqan7oAM6EBPjG9I6ox9sCotngT++YV4CUO2WX81uccI/bQ98K871Hczjcq
 hJmb/TBRD8nLM5YDgWtU33EtzY32Wm5IYGWNpX1LxMzlKIs3cAOjMe+Rk6ffJBQ2bSSJ/gcP7Xa
 zTHy8BejdqBxsUNcgDOwYokB197QElI2WDdi5lXJ8EedFbfSozQxsTxgXNsZE1EhHI4yM7XJZ95
 daNMdJJTdNYdSOlYHOnS7l38K3PbXZ+GzjfpgKutfjyoyLdB6duq2sUxImtWK+tQiM591ssY63m
 e7HgFHH/xXyudHsQS2swokWD2ZnRppJEWzdiwWun53jWwJre9oQHcknyWMJA64cg33lGLPFlb6I
 CaVt1ZOddIyKGSIw2nrD1QFObh5u8FczQjWxPsR2dc5S70z0t13CRhCjvaMJL88YJxxQkCouSku
 s76JKFb7cWPL12AnkxTomlW2M7fOQhdJy2ZNGBijOw+WsojztpaT5Z7TtNzWvopYOx7Ud7t41lC
 YkTBwbUXArpk+BO/Wpj98Fa0Mtw+OD1VDF1GYhEbuM6KtVXXLDhilSL03sI43eihLOlkZzcURu1
 yxzIYMOeA00SvZw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

MPTCP maintains the received sub-options status is the bitmask carrying
the received suboptions and in several bitfields carrying per suboption
additional info.

Zeroing the bitmask before parsing is not enough to ensure a consistent
status, and the MPTCP code has to additionally clear some bitfiled
depending on the actually parsed suboption.

The above schema is fragile, and syzbot managed to trigger a path where
a relevant bitfield is not cleared/initialized:

  BUG: KMSAN: uninit-value in __mptcp_expand_seq net/mptcp/options.c:1030 [inline]
  BUG: KMSAN: uninit-value in mptcp_expand_seq net/mptcp/protocol.h:864 [inline]
  BUG: KMSAN: uninit-value in ack_update_msk net/mptcp/options.c:1060 [inline]
  BUG: KMSAN: uninit-value in mptcp_incoming_options+0x2036/0x3d30 net/mptcp/options.c:1209
   __mptcp_expand_seq net/mptcp/options.c:1030 [inline]
   mptcp_expand_seq net/mptcp/protocol.h:864 [inline]
   ack_update_msk net/mptcp/options.c:1060 [inline]
   mptcp_incoming_options+0x2036/0x3d30 net/mptcp/options.c:1209
   tcp_data_queue+0xb4/0x7be0 net/ipv4/tcp_input.c:5233
   tcp_rcv_established+0x1061/0x2510 net/ipv4/tcp_input.c:6264
   tcp_v4_do_rcv+0x7f3/0x11a0 net/ipv4/tcp_ipv4.c:1916
   tcp_v4_rcv+0x51df/0x5750 net/ipv4/tcp_ipv4.c:2351
   ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
   ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
   NF_HOOK include/linux/netfilter.h:314 [inline]
   ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
   dst_input include/net/dst.h:460 [inline]
   ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:447
   NF_HOOK include/linux/netfilter.h:314 [inline]
   ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:567
   __netif_receive_skb_one_core net/core/dev.c:5704 [inline]
   __netif_receive_skb+0x319/0xa00 net/core/dev.c:5817
   process_backlog+0x4ad/0xa50 net/core/dev.c:6149
   __napi_poll+0xe7/0x980 net/core/dev.c:6902
   napi_poll net/core/dev.c:6971 [inline]
   net_rx_action+0xa5a/0x19b0 net/core/dev.c:7093
   handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
   __do_softirq+0x14/0x1a kernel/softirq.c:595
   do_softirq+0x9a/0x100 kernel/softirq.c:462
   __local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:389
   local_bh_enable include/linux/bottom_half.h:33 [inline]
   rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
   __dev_queue_xmit+0x2758/0x57d0 net/core/dev.c:4493
   dev_queue_xmit include/linux/netdevice.h:3168 [inline]
   neigh_hh_output include/net/neighbour.h:523 [inline]
   neigh_output include/net/neighbour.h:537 [inline]
   ip_finish_output2+0x187c/0x1b70 net/ipv4/ip_output.c:236
   __ip_finish_output+0x287/0x810
   ip_finish_output+0x4b/0x600 net/ipv4/ip_output.c:324
   NF_HOOK_COND include/linux/netfilter.h:303 [inline]
   ip_output+0x15f/0x3f0 net/ipv4/ip_output.c:434
   dst_output include/net/dst.h:450 [inline]
   ip_local_out net/ipv4/ip_output.c:130 [inline]
   __ip_queue_xmit+0x1f2a/0x20d0 net/ipv4/ip_output.c:536
   ip_queue_xmit+0x60/0x80 net/ipv4/ip_output.c:550
   __tcp_transmit_skb+0x3cea/0x4900 net/ipv4/tcp_output.c:1468
   tcp_transmit_skb net/ipv4/tcp_output.c:1486 [inline]
   tcp_write_xmit+0x3b90/0x9070 net/ipv4/tcp_output.c:2829
   __tcp_push_pending_frames+0xc4/0x380 net/ipv4/tcp_output.c:3012
   tcp_send_fin+0x9f6/0xf50 net/ipv4/tcp_output.c:3618
   __tcp_close+0x140c/0x1550 net/ipv4/tcp.c:3130
   __mptcp_close_ssk+0x74e/0x16f0 net/mptcp/protocol.c:2496
   mptcp_close_ssk+0x26b/0x2c0 net/mptcp/protocol.c:2550
   mptcp_pm_nl_rm_addr_or_subflow+0x635/0xd10 net/mptcp/pm_netlink.c:889
   mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:924 [inline]
   mptcp_pm_flush_addrs_and_subflows net/mptcp/pm_netlink.c:1688 [inline]
   mptcp_nl_flush_addrs_list net/mptcp/pm_netlink.c:1709 [inline]
   mptcp_pm_nl_flush_addrs_doit+0xe10/0x1630 net/mptcp/pm_netlink.c:1750
   genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
   genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
   genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
   netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2542
   genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
   netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
   netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1347
   netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1891
   sock_sendmsg_nosec net/socket.c:711 [inline]
   __sock_sendmsg+0x30f/0x380 net/socket.c:726
   ____sys_sendmsg+0x877/0xb60 net/socket.c:2583
   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2637
   __sys_sendmsg net/socket.c:2669 [inline]
   __do_sys_sendmsg net/socket.c:2674 [inline]
   __se_sys_sendmsg net/socket.c:2672 [inline]
   __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2672
   x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Uninit was stored to memory at:
   mptcp_get_options+0x2c0f/0x2f20 net/mptcp/options.c:397
   mptcp_incoming_options+0x19a/0x3d30 net/mptcp/options.c:1150
   tcp_data_queue+0xb4/0x7be0 net/ipv4/tcp_input.c:5233
   tcp_rcv_established+0x1061/0x2510 net/ipv4/tcp_input.c:6264
   tcp_v4_do_rcv+0x7f3/0x11a0 net/ipv4/tcp_ipv4.c:1916
   tcp_v4_rcv+0x51df/0x5750 net/ipv4/tcp_ipv4.c:2351
   ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
   ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
   NF_HOOK include/linux/netfilter.h:314 [inline]
   ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
   dst_input include/net/dst.h:460 [inline]
   ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:447
   NF_HOOK include/linux/netfilter.h:314 [inline]
   ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:567
   __netif_receive_skb_one_core net/core/dev.c:5704 [inline]
   __netif_receive_skb+0x319/0xa00 net/core/dev.c:5817
   process_backlog+0x4ad/0xa50 net/core/dev.c:6149
   __napi_poll+0xe7/0x980 net/core/dev.c:6902
   napi_poll net/core/dev.c:6971 [inline]
   net_rx_action+0xa5a/0x19b0 net/core/dev.c:7093
   handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
   __do_softirq+0x14/0x1a kernel/softirq.c:595

  Uninit was stored to memory at:
   put_unaligned_be32 include/linux/unaligned.h:68 [inline]
   mptcp_write_options+0x17f9/0x3100 net/mptcp/options.c:1417
   mptcp_options_write net/ipv4/tcp_output.c:465 [inline]
   tcp_options_write+0x6d9/0xe90 net/ipv4/tcp_output.c:759
   __tcp_transmit_skb+0x294b/0x4900 net/ipv4/tcp_output.c:1414
   tcp_transmit_skb net/ipv4/tcp_output.c:1486 [inline]
   tcp_write_xmit+0x3b90/0x9070 net/ipv4/tcp_output.c:2829
   __tcp_push_pending_frames+0xc4/0x380 net/ipv4/tcp_output.c:3012
   tcp_send_fin+0x9f6/0xf50 net/ipv4/tcp_output.c:3618
   __tcp_close+0x140c/0x1550 net/ipv4/tcp.c:3130
   __mptcp_close_ssk+0x74e/0x16f0 net/mptcp/protocol.c:2496
   mptcp_close_ssk+0x26b/0x2c0 net/mptcp/protocol.c:2550
   mptcp_pm_nl_rm_addr_or_subflow+0x635/0xd10 net/mptcp/pm_netlink.c:889
   mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:924 [inline]
   mptcp_pm_flush_addrs_and_subflows net/mptcp/pm_netlink.c:1688 [inline]
   mptcp_nl_flush_addrs_list net/mptcp/pm_netlink.c:1709 [inline]
   mptcp_pm_nl_flush_addrs_doit+0xe10/0x1630 net/mptcp/pm_netlink.c:1750
   genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
   genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
   genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
   netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2542
   genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
   netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
   netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1347
   netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1891
   sock_sendmsg_nosec net/socket.c:711 [inline]
   __sock_sendmsg+0x30f/0x380 net/socket.c:726
   ____sys_sendmsg+0x877/0xb60 net/socket.c:2583
   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2637
   __sys_sendmsg net/socket.c:2669 [inline]
   __do_sys_sendmsg net/socket.c:2674 [inline]
   __se_sys_sendmsg net/socket.c:2672 [inline]
   __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2672
   x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Uninit was stored to memory at:
   mptcp_pm_add_addr_signal+0x3d7/0x4c0
   mptcp_established_options_add_addr net/mptcp/options.c:666 [inline]
   mptcp_established_options+0x1b9b/0x3a00 net/mptcp/options.c:884
   tcp_established_options+0x2c4/0x7d0 net/ipv4/tcp_output.c:1012
   __tcp_transmit_skb+0x5b7/0x4900 net/ipv4/tcp_output.c:1333
   tcp_transmit_skb net/ipv4/tcp_output.c:1486 [inline]
   tcp_write_xmit+0x3b90/0x9070 net/ipv4/tcp_output.c:2829
   __tcp_push_pending_frames+0xc4/0x380 net/ipv4/tcp_output.c:3012
   tcp_send_fin+0x9f6/0xf50 net/ipv4/tcp_output.c:3618
   __tcp_close+0x140c/0x1550 net/ipv4/tcp.c:3130
   __mptcp_close_ssk+0x74e/0x16f0 net/mptcp/protocol.c:2496
   mptcp_close_ssk+0x26b/0x2c0 net/mptcp/protocol.c:2550
   mptcp_pm_nl_rm_addr_or_subflow+0x635/0xd10 net/mptcp/pm_netlink.c:889
   mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:924 [inline]
   mptcp_pm_flush_addrs_and_subflows net/mptcp/pm_netlink.c:1688 [inline]
   mptcp_nl_flush_addrs_list net/mptcp/pm_netlink.c:1709 [inline]
   mptcp_pm_nl_flush_addrs_doit+0xe10/0x1630 net/mptcp/pm_netlink.c:1750
   genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
   genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
   genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
   netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2542
   genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
   netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
   netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1347
   netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1891
   sock_sendmsg_nosec net/socket.c:711 [inline]
   __sock_sendmsg+0x30f/0x380 net/socket.c:726
   ____sys_sendmsg+0x877/0xb60 net/socket.c:2583
   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2637
   __sys_sendmsg net/socket.c:2669 [inline]
   __do_sys_sendmsg net/socket.c:2674 [inline]
   __se_sys_sendmsg net/socket.c:2672 [inline]
   __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2672
   x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Uninit was stored to memory at:
   mptcp_pm_add_addr_received+0x95f/0xdd0 net/mptcp/pm.c:235
   mptcp_incoming_options+0x2983/0x3d30 net/mptcp/options.c:1169
   tcp_data_queue+0xb4/0x7be0 net/ipv4/tcp_input.c:5233
   tcp_rcv_state_process+0x2a38/0x49d0 net/ipv4/tcp_input.c:6972
   tcp_v4_do_rcv+0xbf9/0x11a0 net/ipv4/tcp_ipv4.c:1939
   tcp_v4_rcv+0x51df/0x5750 net/ipv4/tcp_ipv4.c:2351
   ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
   ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
   NF_HOOK include/linux/netfilter.h:314 [inline]
   ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
   dst_input include/net/dst.h:460 [inline]
   ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:447
   NF_HOOK include/linux/netfilter.h:314 [inline]
   ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:567
   __netif_receive_skb_one_core net/core/dev.c:5704 [inline]
   __netif_receive_skb+0x319/0xa00 net/core/dev.c:5817
   process_backlog+0x4ad/0xa50 net/core/dev.c:6149
   __napi_poll+0xe7/0x980 net/core/dev.c:6902
   napi_poll net/core/dev.c:6971 [inline]
   net_rx_action+0xa5a/0x19b0 net/core/dev.c:7093
   handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
   __do_softirq+0x14/0x1a kernel/softirq.c:595

  Local variable mp_opt created at:
   mptcp_incoming_options+0x119/0x3d30 net/mptcp/options.c:1127
   tcp_data_queue+0xb4/0x7be0 net/ipv4/tcp_input.c:5233

The current schema is too fragile; address the issue grouping all the
state-related data together and clearing the whole group instead of
just the bitmask. This also cleans-up the code a bit, as there is no
need to individually clear "random" bitfield in a couple of places
any more.

Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
Cc: stable@vger.kernel.org
Reported-by: syzbot+23728c2df58b3bd175ad@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/6786ac51.050a0220.216c54.00a7.GAE@google.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/541
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 13 +++++--------
 net/mptcp/protocol.h | 30 ++++++++++++++++--------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 123f3f2972841aab9fc2ef338687b4c4758efd4a..fd2de185bc939f8730e87a63ac02a015e610e99c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -108,7 +108,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->suboptions |= OPTION_MPTCP_DSS;
 			mp_opt->use_map = 1;
 			mp_opt->mpc_map = 1;
-			mp_opt->use_ack = 0;
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
@@ -157,11 +156,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		pr_debug("DSS\n");
 		ptr++;
 
-		/* we must clear 'mpc_map' be able to detect MP_CAPABLE
-		 * map vs DSS map in mptcp_incoming_options(), and reconstruct
-		 * map info accordingly
-		 */
-		mp_opt->mpc_map = 0;
 		flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;
 		mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 		mp_opt->dsn64 = (flags & MPTCP_DSS_DSN64) != 0;
@@ -369,8 +363,11 @@ void mptcp_get_options(const struct sk_buff *skb,
 	const unsigned char *ptr;
 	int length;
 
-	/* initialize option status */
-	mp_opt->suboptions = 0;
+	/* Ensure that casting the whole status to u32 is efficient and safe */
+	BUILD_BUG_ON(sizeof_field(struct mptcp_options_received, status) != sizeof(u32));
+	BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct mptcp_options_received, status),
+				 sizeof(u32)));
+	*(u32 *)&mp_opt->status = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0174a5aad2796c6e943e618bb677a2baff6eab22..f6a207958459db5bd39f91ed7431b5a766669f92 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -149,22 +149,24 @@ struct mptcp_options_received {
 	u32	subflow_seq;
 	u16	data_len;
 	__sum16	csum;
-	u16	suboptions;
+	struct_group(status,
+		u16 suboptions;
+		u16 use_map:1,
+		    dsn64:1,
+		    data_fin:1,
+		    use_ack:1,
+		    ack64:1,
+		    mpc_map:1,
+		    reset_reason:4,
+		    reset_transient:1,
+		    echo:1,
+		    backup:1,
+		    deny_join_id0:1,
+		    __unused:2;
+	);
+	u8	join_id;
 	u32	token;
 	u32	nonce;
-	u16	use_map:1,
-		dsn64:1,
-		data_fin:1,
-		use_ack:1,
-		ack64:1,
-		mpc_map:1,
-		reset_reason:4,
-		reset_transient:1,
-		echo:1,
-		backup:1,
-		deny_join_id0:1,
-		__unused:2;
-	u8	join_id;
 	u64	thmac;
 	u8	hmac[MPTCPOPT_HMAC_LEN];
 	struct mptcp_addr_info addr;

-- 
2.47.1


