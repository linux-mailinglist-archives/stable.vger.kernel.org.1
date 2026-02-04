Return-Path: <stable+bounces-214333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHW1Myh8g2lfnwMAu9opvQ
	(envelope-from <stable+bounces-214333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 18:04:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15992EAC24
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 18:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2095300B070
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 16:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22FC340A51;
	Wed,  4 Feb 2026 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhFMlTtt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C1132D7EC;
	Wed,  4 Feb 2026 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224268; cv=none; b=u4F5Rpz5QgW9zRnESnFT9b6ZEcrmg1Oud/s89PpWjsvjchD0NLvqZhzn4Ed1tAlfRAEHAPBx3AkAH5TyKSpRbeeLu7rQiP2s6Fy5CMPG7pereIUCJKn0WQrfb0bTWtpyp7++JJv/Js6qw61XdmpFIzrkLUY996pGbGn0zuQ3XyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224268; c=relaxed/simple;
	bh=4uBpIawK3UR/dAMLQlFezbz6/CjPyLs71jyLsbRpLg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbhSJ3OOHhXfQzCTm3XxrySPai+WZjtTMkUlZ9UciwDa0yJVDALN8rZ+3wAI1vwP1BuPRlataTCCo9luJCfxFfC35SZH0dd1furoemRXj0Y/XLKuQSihZjPYwuhJFO7LhDZ01F5a2Z16/pY9YH6OSBEQi3wiI0jqnVy0vUCglmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhFMlTtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA35C2BC87;
	Wed,  4 Feb 2026 16:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770224268;
	bh=4uBpIawK3UR/dAMLQlFezbz6/CjPyLs71jyLsbRpLg8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QhFMlTttZFmgazOKnDhOGDVXV4qYo6V2HNex0CgA5xA2dUzYwg7/plM+R1SJeMZMN
	 Fm4cAeKmhjy8nOXT5XESrtdutF8Rc+DVjnR2idKeUiqTVVD4hdyD4F5e2TTKTo4Gmn
	 DyD2C3xPFnhhQrIrUKLdt+sbfUK+7Qfcn+bOhyN4TktjJcj7Hx3++1zutrF3O32F9U
	 WJdqrdq7C2rO5cNkpAIlAjcY3b3MW2ABasWW0wKSh6iNJvyVt+kRc9ZfKB3uv/4svD
	 PWDlalB9XtcLiq+1DuYrntfM3bbfP1nB2tNhKq6ITxTjoPHEMjWVKfZdwtLHIRAsaK
	 9uhVs/F90N6qw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 04 Feb 2026 17:57:25 +0100
Subject: [PATCH net 1/4] mptcp: pm: in-kernel: always set ID as avail when
 rm endp
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-1-cb559fb6b50a@kernel.org>
References: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-0-cb559fb6b50a@kernel.org>
In-Reply-To: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-0-cb559fb6b50a@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+f56f7d56e2c6e11a01b6@syzkaller.appspotmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7745; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4uBpIawK3UR/dAMLQlFezbz6/CjPyLs71jyLsbRpLg8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbq1reGRfONjmrXn3F1yUo5mhRYd7b3qu7w/rqFq+PO
 //tYMDjjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInIsjMynLe8f+2i5kq/X5dO
 TjynUnLQ/CJX1D7LmzvfdlzbdILRmJXhf0R07eHKjz+0kss6ohJrZKqZcvcZpYd6Z/ZZ/mZ+EXO
 YBQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214333-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,f56f7d56e2c6e11a01b6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 15992EAC24
X-Rspamd-Action: no action

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

In this case, msk->pm.local_addr_used has been decremented, but the
corresponding bit in msk->pm.id_avail_bitmap has not been reset.

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
---
 net/mptcp/pm_kernel.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index b26675054b0d..4972c19fc73e 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1056,10 +1056,8 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = mptcp_remove_anno_list_by_saddr(msk, addr);
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
@@ -1097,17 +1095,15 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
 		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
-		if (remove_subflow) {
-			spin_lock_bh(&msk->pm.lock);
-			mptcp_pm_rm_subflow(msk, &list);
-			spin_unlock_bh(&msk->pm.lock);
-		}
 
-		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
-			spin_lock_bh(&msk->pm.lock);
+		spin_lock_bh(&msk->pm.lock);
+		if (remove_subflow)
+			mptcp_pm_rm_subflow(msk, &list);
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


