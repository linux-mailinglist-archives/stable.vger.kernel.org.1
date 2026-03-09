Return-Path: <stable+bounces-223583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I0YMluhrmkLHAIAu9opvQ
	(envelope-from <stable+bounces-223583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:30:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1452371A8
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 994DB3050221
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD0B362129;
	Mon,  9 Mar 2026 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jrw2nBKU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64C881732
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052167; cv=none; b=LitleE7/+zw9oWaW1ZkpwJ/brm3OiMjOcnwPSdyzgD3I9UwhJdBKHK8EzHuL7x1NW7fkB3TcZFMW0eMp1kFyA2/gZTtOUbj6zbD4l/2yHJC5mg0ZAqU214KtiWgBacjA7CX5hzebD/iZLOd42B+XWnAhQu96dxZzn+qYo4R9mvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052167; c=relaxed/simple;
	bh=O6Rkqh6HwGLFdDN2NRsdhXvdcEKo8GbOUmt5UptsTZc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dW7pe71xSGvKqkGmIYVFNuVg9QGSb9V3XpHtjHtaxK/dB5Gq0wEF3rLY60TxGQP0S1z/kaMKbXVNvf6UBUKAAkBi+PXCc0XuSDH1Y5xBjRV/WJOQ3UptiA+ZumlVVZOmF922ezaZ2zB/uFsDPFj+zXu4TGX6qC3b1AxCPkBT5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jrw2nBKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AECC4CEF7;
	Mon,  9 Mar 2026 10:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773052167;
	bh=O6Rkqh6HwGLFdDN2NRsdhXvdcEKo8GbOUmt5UptsTZc=;
	h=Subject:To:Cc:From:Date:From;
	b=jrw2nBKU+OkrmFV9P+JHPLj51BHsYWPEfSUEitKBCQdkecghmih6j0h/2w91vLK+9
	 KJQIiND1KshSo5ZxXGkw1tIs67tZh9obYAL6UlAVO5DPvi/7666mh81cDYhOY6ozpI
	 1oY0wiN/hhvXb1oCTtArfN6Z/1jJfIrbm0ppnwEU=
Subject: FAILED: patch "[PATCH] mptcp: pm: in-kernel: always mark signal+subflow endp as used" failed to apply to 6.6-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:29:19 +0100
Message-ID: <2026030919-paramount-foyer-8351@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1E1452371A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223583-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.234];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 579a752464a64cb5f9139102f0e6b90a1f595ceb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030919-paramount-foyer-8351@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 579a752464a64cb5f9139102f0e6b90a1f595ceb Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 3 Mar 2026 11:56:05 +0100
Subject: [PATCH] mptcp: pm: in-kernel: always mark signal+subflow endp as used

Syzkaller managed to find a combination of actions that was generating
this warning:

  msk->pm.local_addr_used == 0
  WARNING: net/mptcp/pm_kernel.c:1071 at __mark_subflow_endp_available net/mptcp/pm_kernel.c:1071 [inline], CPU#1: syz.2.17/961
  WARNING: net/mptcp/pm_kernel.c:1071 at mptcp_nl_remove_subflow_and_signal_addr net/mptcp/pm_kernel.c:1103 [inline], CPU#1: syz.2.17/961
  WARNING: net/mptcp/pm_kernel.c:1071 at mptcp_pm_nl_del_addr_doit+0x81d/0x8f0 net/mptcp/pm_kernel.c:1210, CPU#1: syz.2.17/961
  Modules linked in:
  CPU: 1 UID: 0 PID: 961 Comm: syz.2.17 Not tainted 6.19.0-08368-gfafda3b4b06b #22 PREEMPT(full)
  Hardware name: QEMU Ubuntu 25.10 PC v2 (i440FX + PIIX, + 10.1 machine, 1996), BIOS 1.17.0-debian-1.17.0-1build1 04/01/2014
  RIP: 0010:__mark_subflow_endp_available net/mptcp/pm_kernel.c:1071 [inline]
  RIP: 0010:mptcp_nl_remove_subflow_and_signal_addr net/mptcp/pm_kernel.c:1103 [inline]
  RIP: 0010:mptcp_pm_nl_del_addr_doit+0x81d/0x8f0 net/mptcp/pm_kernel.c:1210
  Code: 89 c5 e8 46 30 6f fe e9 21 fd ff ff 49 83 ed 80 e8 38 30 6f fe 4c 89 ef be 03 00 00 00 e8 db 49 df fe eb ac e8 24 30 6f fe 90 <0f> 0b 90 e9 1d ff ff ff e8 16 30 6f fe eb 05 e8 0f 30 6f fe e8 9a
  RSP: 0018:ffffc90001663880 EFLAGS: 00010293
  RAX: ffffffff82de1a6c RBX: 0000000000000000 RCX: ffff88800722b500
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ffff8880158b22d0 R08: 0000000000010425 R09: ffffffffffffffff
  R10: ffffffff82de18ba R11: 0000000000000000 R12: ffff88800641a640
  R13: ffff8880158b1880 R14: ffff88801ec3c900 R15: ffff88800641a650
  FS:  00005555722c3500(0000) GS:ffff8880f909d000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f66346e0f60 CR3: 000000001607c000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   genl_family_rcv_msg_doit+0x117/0x180 net/netlink/genetlink.c:1115
   genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
   genl_rcv_msg+0x3a8/0x3f0 net/netlink/genetlink.c:1210
   netlink_rcv_skb+0x16d/0x240 net/netlink/af_netlink.c:2550
   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
   netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
   netlink_unicast+0x3e9/0x4c0 net/netlink/af_netlink.c:1344
   netlink_sendmsg+0x4aa/0x5b0 net/netlink/af_netlink.c:1894
   sock_sendmsg_nosec net/socket.c:727 [inline]
   __sock_sendmsg+0xc9/0xf0 net/socket.c:742
   ____sys_sendmsg+0x272/0x3b0 net/socket.c:2592
   ___sys_sendmsg+0x2de/0x320 net/socket.c:2646
   __sys_sendmsg net/socket.c:2678 [inline]
   __do_sys_sendmsg net/socket.c:2683 [inline]
   __se_sys_sendmsg net/socket.c:2681 [inline]
   __x64_sys_sendmsg+0x110/0x1a0 net/socket.c:2681
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x143/0x440 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7f66346f826d
  Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007ffc83d8bdc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
  RAX: ffffffffffffffda RBX: 00007f6634985fa0 RCX: 00007f66346f826d
  RDX: 00000000040000b0 RSI: 0000200000000740 RDI: 0000000000000007
  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6634985fa8
  R13: 00007f6634985fac R14: 0000000000000000 R15: 0000000000001770
   </TASK>

The actions that caused that seem to be:

 - Set the MPTCP subflows limit to 0
 - Create an MPTCP endpoint with both the 'signal' and 'subflow' flags
 - Create a new MPTCP connection from a different address: an ADD_ADDR
   linked to the MPTCP endpoint will be sent ('signal' flag), but no
   subflows is initiated ('subflow' flag)
 - Remove the MPTCP endpoint

In this case, msk->pm.local_addr_used has been kept to 0 -- because no
subflows have been created -- but the corresponding bit in
msk->pm.id_avail_bitmap has been cleared when the ADD_ADDR has been
sent. This later causes a splat when removing the MPTCP endpoint because
msk->pm.local_addr_used has been kept to 0.

Now, if an endpoint has both the signal and subflow flags, but it is not
possible to create subflows because of the limits or the c-flag case,
then the local endpoint counter is still incremented: the endpoint is
used at the end. This avoids issues later when removing the endpoint and
calling __mark_subflow_endp_available(), which expects
msk->pm.local_addr_used to have been previously incremented if the
endpoint was marked as used according to msk->pm.id_avail_bitmap.

Note that signal_and_subflow variable is reset to false when the limits
and the c-flag case allows subflows creation. Also, local_addr_used is
only incremented for non ID0 subflows.

Fixes: 85df533a787b ("mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/613
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260303-net-mptcp-misc-fixes-7-0-rc2-v1-4-4b5462b6f016@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index b5316a6c7d1b..b2b9df43960e 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -418,6 +418,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	}
 
 exit:
+	/* If an endpoint has both the signal and subflow flags, but it is not
+	 * possible to create subflows -- the 'while' loop body above never
+	 * executed --  then still mark the endp as used, which is somehow the
+	 * case. This avoids issues later when removing the endpoint and calling
+	 * __mark_subflow_endp_available(), which expects the increment here.
+	 */
+	if (signal_and_subflow && local.addr.id != msk->mpc_endpoint_id)
+		msk->pm.local_addr_used++;
+
 	mptcp_pm_nl_check_work_pending(msk);
 }
 


