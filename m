Return-Path: <stable+bounces-219481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAaeGvWinmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:21:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CEA193455
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C1F530FBB12
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A862D23A4;
	Wed, 25 Feb 2026 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IbCXRsOP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A746F2D4805;
	Wed, 25 Feb 2026 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002744; cv=none; b=kvMeG8a0DJbztD1UQwXFOMZkXj+xmLECb1wdQuMSKRR7D44XAf306oPO2y+024yyP93gNcJjyaP0RAhRIGLtlktYAeRHWVVZPTKGAzhgwo6A0mZizoTOXx8DK2cZdGNmPqsFSkp80UkaT5dl8ULdjyUcwQ++XyJ4G356QEnMMYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002744; c=relaxed/simple;
	bh=AhYFCe4M6v6o8lxctZ3fAGJ6763eUjqY7VkgM0dx1Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HraQYjJ6gHdlnhRxQcYTWTwiYf2eu7nz44xfnhiTNetWqhVDD8rqSeu99RWzgRwGHmhfkDWjtREfgYTjzaWkWnGLk+9vI6G1WSYrQKb9htIeQWVFGKm79YgjoC3ZDLOqHCmLABP7msqekhVOo6SBg1xFUeex5t70VSvNJmXZ718=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IbCXRsOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9D0C116D0;
	Wed, 25 Feb 2026 06:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002744;
	bh=AhYFCe4M6v6o8lxctZ3fAGJ6763eUjqY7VkgM0dx1Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IbCXRsOP9s7d1rBzist2oG6rNhD/zDjv5Ugd7VK0/JyOTUbyc5sbcLIVrSkNCsFe1
	 /++iF6ryWtq6zRW6hX2lxo0o5MImHO0LrFqWDlDwd9iJeIBBGwJz5eQ1amALWi+l9w
	 GwyaUreDvz47M4ulrFVgyN9boD5PCnVbh+DDz000=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liang Li <liali@redhat.com>,
	Nikolay Aleksandrov <nikolay@nvidia.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 558/641] bonding: alb: fix UAF in rlb_arp_recv during bond up/down
Date: Tue, 24 Feb 2026 17:24:44 -0800
Message-ID: <20260225012402.045830504@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,nvidia.com,jvosburgh.net,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-219481-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1CEA193455
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit e6834a4c474697df23ab9948fd3577b26bf48656 ]

The ALB RX path may access rx_hashtbl concurrently with bond
teardown. During rapid bond up/down cycles, rlb_deinitialize()
frees rx_hashtbl while RX handlers are still running, leading
to a null pointer dereference detected by KASAN.

However, the root cause is that rlb_arp_recv() can still be accessed
after setting recv_probe to NULL, which is actually a use-after-free
(UAF) issue. That is the reason for using the referenced commit in the
Fixes tag.

[  214.174138] Oops: general protection fault, probably for non-canonical address 0xdffffc000000001d: 0000 [#1] SMP KASAN PTI
[  214.186478] KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
[  214.194933] CPU: 30 UID: 0 PID: 2375 Comm: ping Kdump: loaded Not tainted 6.19.0-rc8+ #2 PREEMPT(voluntary)
[  214.205907] Hardware name: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.14.0 01/14/2022
[  214.214357] RIP: 0010:rlb_arp_recv+0x505/0xab0 [bonding]
[  214.220320] Code: 0f 85 2b 05 00 00 48 b8 00 00 00 00 00 fc ff df 40 0f b6 ed 48 c1 e5 06 49 03 ad 78 01 00 00 48 8d 7d 28 48 89 fa 48 c1 ea 03 <0f> b6
 04 02 84 c0 74 06 0f 8e 12 05 00 00 80 7d 28 00 0f 84 8c 00
[  214.241280] RSP: 0018:ffffc900073d8870 EFLAGS: 00010206
[  214.247116] RAX: dffffc0000000000 RBX: ffff888168556822 RCX: ffff88816855681e
[  214.255082] RDX: 000000000000001d RSI: dffffc0000000000 RDI: 00000000000000e8
[  214.263048] RBP: 00000000000000c0 R08: 0000000000000002 R09: ffffed11192021c8
[  214.271013] R10: ffff8888c9010e43 R11: 0000000000000001 R12: 1ffff92000e7b119
[  214.278978] R13: ffff8888c9010e00 R14: ffff888168556822 R15: ffff888168556810
[  214.286943] FS:  00007f85d2d9cb80(0000) GS:ffff88886ccb3000(0000) knlGS:0000000000000000
[  214.295966] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  214.302380] CR2: 00007f0d047b5e34 CR3: 00000008a1c2e002 CR4: 00000000001726f0
[  214.310347] Call Trace:
[  214.313070]  <IRQ>
[  214.315318]  ? __pfx_rlb_arp_recv+0x10/0x10 [bonding]
[  214.320975]  bond_handle_frame+0x166/0xb60 [bonding]
[  214.326537]  ? __pfx_bond_handle_frame+0x10/0x10 [bonding]
[  214.332680]  __netif_receive_skb_core.constprop.0+0x576/0x2710
[  214.339199]  ? __pfx_arp_process+0x10/0x10
[  214.343775]  ? sched_balance_find_src_group+0x98/0x630
[  214.349513]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
[  214.356513]  ? arp_rcv+0x307/0x690
[  214.360311]  ? __pfx_arp_rcv+0x10/0x10
[  214.364499]  ? __lock_acquire+0x58c/0xbd0
[  214.368975]  __netif_receive_skb_one_core+0xae/0x1b0
[  214.374518]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  214.380743]  ? lock_acquire+0x10b/0x140
[  214.385026]  process_backlog+0x3f1/0x13a0
[  214.389502]  ? process_backlog+0x3aa/0x13a0
[  214.394174]  __napi_poll.constprop.0+0x9f/0x370
[  214.399233]  net_rx_action+0x8c1/0xe60
[  214.403423]  ? __pfx_net_rx_action+0x10/0x10
[  214.408193]  ? lock_acquire.part.0+0xbd/0x260
[  214.413058]  ? sched_clock_cpu+0x6c/0x540
[  214.417540]  ? mark_held_locks+0x40/0x70
[  214.421920]  handle_softirqs+0x1fd/0x860
[  214.426302]  ? __pfx_handle_softirqs+0x10/0x10
[  214.431264]  ? __neigh_event_send+0x2d6/0xf50
[  214.436131]  do_softirq+0xb1/0xf0
[  214.439830]  </IRQ>

The issue is reproducible by repeatedly running
ip link set bond0 up/down while receiving ARP messages, where
rlb_arp_recv() can race with rlb_deinitialize() and dereference
a freed rx_hashtbl entry.

Fix this by setting recv_probe to NULL and then calling
synchronize_net() to wait for any concurrent RX processing to finish.
This ensures that no RX handler can access rx_hashtbl after it is freed
in bond_alb_deinitialize().

Reported-by: Liang Li <liali@redhat.com>
Fixes: 3aba891dde38 ("bonding: move processing of recv handlers into handle_frame()")
Reviewed-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20260218060919.101574-1-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 166dff47a029f..dba8f68690947 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4405,9 +4405,13 @@ static int bond_close(struct net_device *bond_dev)
 
 	bond_work_cancel_all(bond);
 	bond->send_peer_notif = 0;
+	WRITE_ONCE(bond->recv_probe, NULL);
+
+	/* Wait for any in-flight RX handlers */
+	synchronize_net();
+
 	if (bond_is_lb(bond))
 		bond_alb_deinitialize(bond);
-	bond->recv_probe = NULL;
 
 	if (BOND_MODE(bond) == BOND_MODE_8023AD &&
 	    bond->params.broadcast_neighbor)
-- 
2.51.0




