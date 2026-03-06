Return-Path: <stable+bounces-223375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKDeM/ATq2lzZwEAu9opvQ
	(envelope-from <stable+bounces-223375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 18:50:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB28226737
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 18:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9190300A4C5
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 17:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4313EF0C1;
	Fri,  6 Mar 2026 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8rzqp8O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F297D3EBF37;
	Fri,  6 Mar 2026 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772819420; cv=none; b=bpjIIf05XJlZRCD4QrsW84WaZGg/sOY7scC8PPVLuwjXh2Kbn8BHn6O8Zb42ojARLvjGbLRQBdXx5btQ9JoiRif74smaUMdSihgtbJzVCOSq1362/dx5PbuQiYfkLTklBbpn3ivRuQRfrI/hX5dwjyKVnZH7sRbVN/nkPmxWUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772819420; c=relaxed/simple;
	bh=VbJRlfY1MntFcbhcYNVoUDgBwW4O9vvGohXljbwTu2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YR2V63OO5KyNOqPLuMaOJ+DdKXzGWe7wX8+OCfXUvwY5twX8YnIOfUn1u6xt/r+X1dB8mvlMWNhQVic/FLHG/7busSjfosEF4BEYfdqlBxoSIWgIIpD04NTgJ/1arr9BSTqtotvrVngHMpBDtISLP/aSzvwnxtTwW7xGE87pZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8rzqp8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F31C4CEF7;
	Fri,  6 Mar 2026 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772819419;
	bh=VbJRlfY1MntFcbhcYNVoUDgBwW4O9vvGohXljbwTu2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o8rzqp8OVSqolFkVNeQspXer9okqfOX0L782LtG7QirXv//EHvzySIOfYLFfDuum6
	 Wm7sEQeouDM2gHOydFL+E2mjww7fgJgqGF4HgVIMDFJocU861Us3pNpMmC3VxaZnZu
	 cF0Pyz5k9PvVbAM8TRPMnu0pYYOtiHnSLEigu2sbkmghlwDxijNqPyoGjRNMuuUS0G
	 2KKzm2m77jdAUZhgs3Si2OJ+mYgD99cxL6H12R9mX1q3LSa19mPSsyM0BQmXdGvr+T
	 wImpPi7ASm6hCv+qQziUhR5HXbk88MRE5TSi8HRGPicvu1DjZNl+K2qGTk6OI7i1es
	 uLJ1fVNhLfr/A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	syzbot+f56f7d56e2c6e11a01b6@syzkaller.appspotmail.com,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] mptcp: pm: in-kernel: always set ID as avail when rm endp
Date: Fri,  6 Mar 2026 18:50:10 +0100
Message-ID: <20260306175009.2520964-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301014545.1708548-1-sashal@kernel.org>
References: <20260301014545.1708548-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-Developer-Signature: v=1; a=openpgp-sha256; l=8520; i=matttbe@kernel.org; h=from:subject; bh=VbJRlfY1MntFcbhcYNVoUDgBwW4O9vvGohXljbwTu2M=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJXC1/K7dqtLWFQat+TYe+Zr3f5UqXoilviSmYnlESn2 XWpfjfvKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmMgNNYZ/Vm83rq8/+/nY4Z+b ef99spXNnbfgwu7Lubk3vA706D3+PpHhv4f57mUr3zrprlubcteq5c5jrW1KrJ+mek/erWrBZhz 6lBcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4EB28226737
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223375-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable,f56f7d56e2c6e11a01b6];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

commit d191101dee25567c2af3b28565f45346c33d65f5 upstream.

Syzkaller managed to find a combination of actions that was generating
this warning:

  WARNING: net/mptcp/pm_kernel.c:1074 at __mark_subflow_endp_available net/mptcp/pm_kernel.c:1074 [inline], CPU#1: syz.7.48/2535
  WARNING: net/mptcp/pm_kernel.c:1074 at mptcp_pm_nl_fullmesh net/mptcp/pm_kernel.c:1446 [inline], CPU#1: syz.7.48/2535
  WARNING: net/mptcp/pm_kernel.c:1074 at mptcp_pm_nl_set_flags_all net/mptcp/pm_kernel.c:1474 [inline], CPU#1: syz.7.48/2535
  WARNING: net/mptcp/pm_kernel.c:1074 at mptcp_pm_nl_set_flags+0x5de/0x640 net/mptcp/pm_kernel.c:1538, CPU#1: syz.7.48/2535
  Modules linked in:
  CPU: 1 UID: 0 PID: 2535 Comm: syz.7.48 Not tainted 6.18.0-03987-gea5f5e676cf5 #17 PREEMPT(voluntary)
  Hardware name: QEMU Ubuntu 25.10 PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
  RIP: 0010:__mark_subflow_endp_available net/mptcp/pm_kernel.c:1074 [inline]
  RIP: 0010:mptcp_pm_nl_fullmesh net/mptcp/pm_kernel.c:1446 [inline]
  RIP: 0010:mptcp_pm_nl_set_flags_all net/mptcp/pm_kernel.c:1474 [inline]
  RIP: 0010:mptcp_pm_nl_set_flags+0x5de/0x640 net/mptcp/pm_kernel.c:1538
  Code: 89 c7 e8 c5 8c 73 fe e9 f7 fd ff ff 49 83 ef 80 e8 b7 8c 73 fe 4c 89 ff be 03 00 00 00 e8 4a 29 e3 fe eb ac e8 a3 8c 73 fe 90 <0f> 0b 90 e9 3d ff ff ff e8 95 8c 73 fe b8 a1 ff ff ff eb 1a e8 89
  RSP: 0018:ffffc9001535b820 EFLAGS: 00010287
  netdevsim0: tun_chr_ioctl cmd 1074025677
  RAX: ffffffff82da294d RBX: 0000000000000001 RCX: 0000000000080000
  RDX: ffffc900096d0000 RSI: 00000000000006d6 RDI: 00000000000006d7
  netdevsim0: linktype set to 823
  RBP: ffff88802cdb2240 R08: 00000000000104ae R09: ffffffffffffffff
  R10: ffffffff82da27d4 R11: 0000000000000000 R12: 0000000000000000
  R13: ffff88801246d8c0 R14: ffffc9001535b8b8 R15: ffff88802cdb1800
  FS:  00007fc6ac5a76c0(0000) GS:ffff8880f90c8000(0000) knlGS:0000000000000000
  netlink: 'syz.3.50': attribute type 5 has an invalid length.
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  netlink: 1232 bytes leftover after parsing attributes in process `syz.3.50'.
  CR2: 0000200000010000 CR3: 0000000025b1a000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   mptcp_pm_set_flags net/mptcp/pm_netlink.c:277 [inline]
   mptcp_pm_nl_set_flags_doit+0x1d7/0x210 net/mptcp/pm_netlink.c:282
   genl_family_rcv_msg_doit+0x117/0x180 net/netlink/genetlink.c:1115
   genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
   genl_rcv_msg+0x3a8/0x3f0 net/netlink/genetlink.c:1210
   netlink_rcv_skb+0x16d/0x240 net/netlink/af_netlink.c:2550
   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
   netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
   netlink_unicast+0x3e9/0x4c0 net/netlink/af_netlink.c:1344
   netlink_sendmsg+0x4ab/0x5b0 net/netlink/af_netlink.c:1894
   sock_sendmsg_nosec net/socket.c:718 [inline]
   __sock_sendmsg+0xc9/0xf0 net/socket.c:733
   ____sys_sendmsg+0x272/0x3b0 net/socket.c:2608
   ___sys_sendmsg+0x2de/0x320 net/socket.c:2662
   __sys_sendmsg net/socket.c:2694 [inline]
   __do_sys_sendmsg net/socket.c:2699 [inline]
   __se_sys_sendmsg net/socket.c:2697 [inline]
   __x64_sys_sendmsg+0x110/0x1a0 net/socket.c:2697
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xed/0x360 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7fc6adb66f6d
  Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007fc6ac5a6ff8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
  RAX: ffffffffffffffda RBX: 00007fc6addf5fa0 RCX: 00007fc6adb66f6d
  RDX: 0000000000048084 RSI: 00002000000002c0 RDI: 000000000000000e
  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  netlink: 'syz.5.51': attribute type 2 has an invalid length.
  R13: 00007fff25e91fe0 R14: 00007fc6ac5a7ce4 R15: 00007fff25e920d7
   </TASK>

The actions that caused that seem to be:

 - Create an MPTCP endpoint for address A without any flags
 - Create a new MPTCP connection from address A
 - Remove the MPTCP endpoint: the corresponding subflows will be removed
 - Recreate the endpoint with the same ID, but with the subflow flag
 - Change the same endpoint to add the fullmesh flag

In this case, msk->pm.local_addr_used has been kept to 0 as expected,
but the corresponding bit in msk->pm.id_avail_bitmap was still unset
after having removed the endpoint, causing the splat later on.

When removing an endpoint, the corresponding endpoint ID was only marked
as available for "signal" types with an announced address, plus all
"subflow" types, but not the other types like an endpoint corresponding
to the initial subflow. In these cases, re-creating an endpoint with the
same ID didn't signal/create anything. Here, adding the fullmesh flag
was creating the splat when calling __mark_subflow_endp_available() from
mptcp_pm_nl_fullmesh(), because msk->pm.local_addr_used was set to 0
while the ID was marked as used.

To fix this issue, the corresponding bit in msk->pm.id_avail_bitmap can
always be set as available when removing an MPTCP in-kernel endpoint. In
other words, moving the call to __set_bit() to do it in all cases,
except for "subflow" types where this bit is handled in a dedicated
helper.

Note: instead of adding a new spin_(un)lock_bh that would be taken in
all cases, do all the actions requiring the spin lock under the same
block.

This modification potentially fixes another issue reported by syzbot,
see [1]. But without a reproducer or more details about what exactly
happened before, it is hard to confirm.

Fixes: e255683c06df ("mptcp: pm: re-using ID of unused removed ADD_ADDR")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/606
Reported-by: syzbot+f56f7d56e2c6e11a01b6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/68fcfc4a.050a0220.346f24.02fb.GAE@google.com [1]
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260205-net-mptcp-misc-fixes-6-19-rc8-v2-1-c2720ce75c34@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflict in pm_netlink.c, because commit 8617e85e04bd ("mptcp: pm:
  split in-kernel PM specific code") is not in this version, and move
  code from pm_netlink.c to pm_kernel.c. Also, commit 636113918508
  ("mptcp: pm: remove '_nl' from mptcp_pm_nl_rm_addr_received") renamed
  mptcp_pm_nl_rm_subflow_received() to mptcp_pm_rm_subflow(). Apart from
  that, the same patch can be applied in pm_netlink.c. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 293ec3448f52..9450c85c1d87 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1601,10 +1601,8 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
-		if (ret) {
-			__set_bit(addr->id, msk->pm.id_avail_bitmap);
+		if (ret)
 			msk->pm.add_addr_signaled--;
-		}
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
@@ -1642,17 +1640,15 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
 		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
-		if (remove_subflow) {
-			spin_lock_bh(&msk->pm.lock);
-			mptcp_pm_nl_rm_subflow_received(msk, &list);
-			spin_unlock_bh(&msk->pm.lock);
-		}
 
-		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
-			spin_lock_bh(&msk->pm.lock);
+		spin_lock_bh(&msk->pm.lock);
+		if (remove_subflow)
+			mptcp_pm_nl_rm_subflow_received(msk, &list);
+		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
 			__mark_subflow_endp_available(msk, list.ids[0]);
-			spin_unlock_bh(&msk->pm.lock);
-		}
+		else /* mark endp ID as available, e.g. Signal or MPC endp */
+			__set_bit(addr->id, msk->pm.id_avail_bitmap);
+		spin_unlock_bh(&msk->pm.lock);
 
 		if (msk->mpc_endpoint_id == entry->addr.id)
 			msk->mpc_endpoint_id = 0;
-- 
2.51.0


