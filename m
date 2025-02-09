Return-Path: <stable+bounces-114455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DE1A2DF81
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 18:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D5B7A1805
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4888F1DFE06;
	Sun,  9 Feb 2025 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwQJqtee"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C91119A;
	Sun,  9 Feb 2025 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739122928; cv=none; b=OzgrICV1O/G+Nzj0IP+PG72ehWfLFbCHhFs4OvRjuUpV8BiKMT8fzS33hEMXQJ1M54FUFY0t1zCjnNyf7+2EaGAnNaq4rzhaW0y5uz5AmrQ67ZkFdEsSz554SfwHQKG+yTNBqOT7bM1jnCNnmBG0rlbNZLik98+sTm/VchmVsOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739122928; c=relaxed/simple;
	bh=TimpNBeyxL0kayxrAovtIoY7g5DS8d5Ry/PZmZIBJ7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CplDBP/YTRVY1G7UAupuH1fEyNYDvnphFO+9QMlnY+PZXsi5a74fqt7UXYQRqIpy8jFwj/9St3tD4UVj3WEzaWYu1ebKFnguhQ49THJ432Mh7Ut0s36uwwESJkPqIkS2vMgESBU/sdnJ8Xdx4ty1//usfrQUA5Lmv2T5ZiUZ1gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwQJqtee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CC0C4CEDF;
	Sun,  9 Feb 2025 17:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739122927;
	bh=TimpNBeyxL0kayxrAovtIoY7g5DS8d5Ry/PZmZIBJ7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BwQJqtee+8umG2TlBBdtUDcKlWwBMVdI1Xvk2YbF1u7yPmJ6VWBgW1i1QqrFnyt58
	 2N6LwRn4O1T+R10T0HMy2VZQ37ytbqokSJyk13W7zP6lL/fe9vk2IDg1CRe0qV/f12
	 b6DBPJWK2d5ghtefSYnVP9a6tzOrPmsPQXmeBtbHN7NsTBKCD8xtfbxST8r7u69z1H
	 ZVl1BTEniy9HYG+kEjgar1Ux+ir255EBisTzDklgw2h63B96O18m0CtN9wS4ZOY6yO
	 DcyxxkQEV2s+Dvl9Kuk+D8+pkr60ZNpWpMrZRL+cgzWkyiGsfwTybe8ps3J1M8DyjP
	 OPVWaSaQKVeJA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 1/3] mptcp: pm: only set fullmesh for subflow endp
Date: Sun,  9 Feb 2025 18:41:55 +0100
Message-ID: <20250209174153.3388802-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025020428-unashamed-delicate-248c@gregkh>
References: <2025020428-unashamed-delicate-248c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5979; i=matttbe@kernel.org; h=from:subject; bh=TimpNBeyxL0kayxrAovtIoY7g5DS8d5Ry/PZmZIBJ7o=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnqOjhrVK2ICZMEGKrKykAwlq4qlqWjRQT1IKrg P7kOHGrmL+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6jo4QAKCRD2t4JPQmmg c0BcEACgrfG1Lz8ISEhuUg+11n95ls/yyq68/dn7cdQq8NribJF4nBVwZlbBOzNcA+lorko5iE4 eaKchL/KFSU/ppAQcJQ5Hk6PQ7rLgqWGDYeKAkUydkBAUzcZgkrbKdEDPYG3bWJEobVh9M4vwrl yukx0Wx/qQBU7WZGW1KBKPiblH2wbDZmfu6EzXbgE7HW8RciL6OpAKUUYTT3FpxRaHGxpc5HXh9 70eaYWSM1rrz4790ISoPgOoiQea2Gi2HnCvt3X21Z1BCouyID+7wTQBS4p4umnxsi46YFr6yRLv DsgIPFmLOME33p92wZ/rDhQyPJgCrGDr6V+fmTwCf/bVINwID9v84ZoqdFEJgDtIQDlnN643AGr cpMYjNsK0uzEjJzKVxV6ySEPobET7LbkTwVV6V3f/pPTvqoNbqVGyyuYrOKAtWEIAGQdL8ZOJ/s y2xfGBXITHPuE6M/WmBHLRsZL86011pz4VwClId0q5r+FWfhSXFtiwR3lqkQCkt1UcbSlRabp46 CPcWbgzImFGhFgY1KKFRnQlc6jMoKQiQapoXwYpxBPkA1Z4mI5f5pbIH5IHycj2126Cmf2um3Ly XKrw2wI9DXZhW5sElCeNoFJ2qb81YHhs2ShzRd8X8Mls/uEbFQ7A6qKbRH+F/JcOv6p4hkH/wSa ahiF4pFSyNYwNTA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 1bb0d1348546ad059f55c93def34e67cb2a034a6 upstream.

With the in-kernel path-manager, it is possible to change the 'fullmesh'
flag. The code in mptcp_pm_nl_fullmesh() expects to change it only on
'subflow' endpoints, to recreate more or less subflows using the linked
address.

Unfortunately, the set_flags() hook was a bit more permissive, and
allowed 'implicit' endpoints to get the 'fullmesh' flag while it is not
allowed before.

That's what syzbot found, triggering the following warning:

  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 __mark_subflow_endp_available net/mptcp/pm_netlink.c:1496 [inline]
  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1980 [inline]
  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 mptcp_nl_set_flags net/mptcp/pm_netlink.c:2003 [inline]
  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 mptcp_pm_nl_set_flags+0x974/0xdc0 net/mptcp/pm_netlink.c:2064
  Modules linked in:
  CPU: 0 UID: 0 PID: 6499 Comm: syz.1.413 Not tainted 6.13.0-rc5-syzkaller-00172-gd1bf27c4e176 #0
  Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
  RIP: 0010:__mark_subflow_endp_available net/mptcp/pm_netlink.c:1496 [inline]
  RIP: 0010:mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1980 [inline]
  RIP: 0010:mptcp_nl_set_flags net/mptcp/pm_netlink.c:2003 [inline]
  RIP: 0010:mptcp_pm_nl_set_flags+0x974/0xdc0 net/mptcp/pm_netlink.c:2064
  Code: 01 00 00 49 89 c5 e8 fb 45 e8 f5 e9 b8 fc ff ff e8 f1 45 e8 f5 4c 89 f7 be 03 00 00 00 e8 44 1d 0b f9 eb a0 e8 dd 45 e8 f5 90 <0f> 0b 90 e9 17 ff ff ff 89 d9 80 e1 07 38 c1 0f 8c c9 fc ff ff 48
  RSP: 0018:ffffc9000d307240 EFLAGS: 00010293
  RAX: ffffffff8bb72e03 RBX: 0000000000000000 RCX: ffff88807da88000
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ffffc9000d307430 R08: ffffffff8bb72cf0 R09: 1ffff1100b842a5e
  R10: dffffc0000000000 R11: ffffed100b842a5f R12: ffff88801e2e5ac0
  R13: ffff88805c214800 R14: ffff88805c2152e8 R15: 1ffff1100b842a5d
  FS:  00005555619f6500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000020002840 CR3: 00000000247e6000 CR4: 00000000003526f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
   genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
   genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
   netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
   netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
   sock_sendmsg_nosec net/socket.c:711 [inline]
   __sock_sendmsg+0x221/0x270 net/socket.c:726
   ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
   ___sys_sendmsg net/socket.c:2637 [inline]
   __sys_sendmsg+0x269/0x350 net/socket.c:2669
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7f5fe8785d29
  Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007fff571f5558 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
  RAX: ffffffffffffffda RBX: 00007f5fe8975fa0 RCX: 00007f5fe8785d29
  RDX: 0000000000000000 RSI: 0000000020000480 RDI: 0000000000000007
  RBP: 00007f5fe8801b08 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 00007f5fe8975fa0 R14: 00007f5fe8975fa0 R15: 00000000000011f4
   </TASK>

Here, syzbot managed to set the 'fullmesh' flag on an 'implicit' and
used -- according to 'id_avail_bitmap' -- endpoint, causing the PM to
try decrement the local_addr_used counter which is only incremented for
the 'subflow' endpoint.

Note that 'no type' endpoints -- not 'subflow', 'signal', 'implicit' --
are fine, because their ID will not be marked as used in the 'id_avail'
bitmap, and setting 'fullmesh' can help forcing the creation of subflow
when receiving an ADD_ADDR.

Fixes: 73c762c1f07d ("mptcp: set fullmesh flag in pm_netlink")
Cc: stable@vger.kernel.org
Reported-by: syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/6786ac51.050a0220.216c54.00a6.GAE@google.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/540
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250123-net-mptcp-syzbot-issues-v1-2-af73258a726f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.c, because the code has been moved around in
  commit 6a42477fe449 ("mptcp: update set_flags interfaces"), but the
  same fix can still be applied at the original place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2cf4393e48dc..2b63c5492eed 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2069,7 +2069,8 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
 		return -EINVAL;
 	}
 	if ((addr->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
-	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+	    (entry->flags & (MPTCP_PM_ADDR_FLAG_SIGNAL |
+			     MPTCP_PM_ADDR_FLAG_IMPLICIT))) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
 	}
-- 
2.47.1


