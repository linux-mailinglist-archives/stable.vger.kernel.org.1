Return-Path: <stable+bounces-235379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHJ/I7WR12k2PwgAu9opvQ
	(envelope-from <stable+bounces-235379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 13:47:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A206D3C9D43
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 13:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3712300AD69
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 11:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014C33C4554;
	Thu,  9 Apr 2026 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npZBTkp5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B862E3C1405;
	Thu,  9 Apr 2026 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735117; cv=none; b=pLcpo6Rvd2i79iPnF3+ImbNqNdHusn0Iy5uxrK9qD1wWPWVaf9N4JIN+nNAIAPSLvv8ez/WQ8X2cNKp0ggy/coslp4D+77rUayxvly+qLHVj82b/5tgqI8Xt6zQGE/PxOPEWg+WiYxwAFSjTucl46hbCCSmgaSjLXChJnPwKouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735117; c=relaxed/simple;
	bh=Y1j3MmZpUQlVDuFTcw/PNkbo7UGMUuMOhCn3l9JqQ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hf8QJJEuZcx8VpGFoQtjt4y6/OHAM6kfFZXOzflsEQoEf8wZT1aDUjotylk19BFqnLSR3QeAvkAj0dwPPqAA1xUUqYCflhFlH3/6yE+A/H3XNg6Dw1Wru1LbCfVlqshKR1LIb00UhRC1rgAxUu4c4a/pbWIyEbkPQa19ts6gTW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npZBTkp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31641C2BC87;
	Thu,  9 Apr 2026 11:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775735117;
	bh=Y1j3MmZpUQlVDuFTcw/PNkbo7UGMUuMOhCn3l9JqQ7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=npZBTkp5+KLL64sUhvX8CaQR+i3F+ReJQFlr4Nb/WqBV7nYzP5e3soZWEJBJPyoPs
	 EoxPBT2nKw4iiiOhPcJTrBC60gf91iV28YXvGV4bdYMzmDsODsjP5txn80kkKuUkxC
	 v+TlPsGPH2XtD0pAJMha1h1kBSL4EHj8Bi0ddaT4FhWl/LcJHTySoPOAEm5SGPC8M1
	 gGk/ZQme+ZPqD8oUDxCdTCemFXtW1Vz7g/IOQoRlBD8Nrfzr3bmZ4HF3i36NW8Lv7d
	 rWDksFFF0NZQ3aUVK6vg+AIeiJkV0p+Co0P77hTmGOh2Cay1RnyHFoW/bV+EOPKFyW
	 IeI7Pzr+uH3eA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Li Xiasong <lixiasong1@huawei.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y] mptcp: fix soft lockup in mptcp_recvmsg()
Date: Thu,  9 Apr 2026 13:44:40 +0200
Message-ID: <20260409114439.1158386-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5224; i=matttbe@kernel.org; h=from:subject; bh=5reSsoATsqAIK/gcQNsgdVYQUtbmZgGtG20KQdaivkA=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKvT1RntdEJMOmsYnfzZpzYoNmkueDY+8+si/0YlqQYW S8VTvTsKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmMgHJ0aGe8VR3PwX5+x6NV3x DueUCwqiXboH733+sdEvQvWiCyfnNkaGL9cfSvc5OvyeEy/wuNKplOnG9Rlvt+skF9tPXsQn4LC GGwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235379-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,huawei.com:email]
X-Rspamd-Queue-Id: A206D3C9D43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Li Xiasong <lixiasong1@huawei.com>

commit 5dd8025a49c268ab6b94d978532af3ad341132a7 upstream.

syzbot reported a soft lockup in mptcp_recvmsg() [0].

When receiving data with MSG_PEEK | MSG_WAITALL flags, the skb is not
removed from the sk_receive_queue. This causes sk_wait_data() to always
find available data and never perform actual waiting, leading to a soft
lockup.

Fix this by adding a 'last' parameter to track the last peeked skb.
This allows sk_wait_data() to make informed waiting decisions and prevent
infinite loops when MSG_PEEK is used.

[0]:
watchdog: BUG: soft lockup - CPU#2 stuck for 156s! [server:1963]
Modules linked in:
CPU: 2 UID: 0 PID: 1963 Comm: server Not tainted 6.19.0-rc8 #61 PREEMPT(none)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:sk_wait_data+0x15/0x190
Code: 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 56 41 55 41 54 49 89 f4 55 48 89 d5 53 48 89 fb <48> 83 ec 30 65 48 8b 05 17 a4 6b 01 48 89 44 24 28 31 c0 65 48 8b
RSP: 0018:ffffc90000603ca0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888102bf0800 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffc90000603d18 RDI: ffff888102bf0800
RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000101
R10: 0000000000000000 R11: 0000000000000075 R12: ffffc90000603d18
R13: ffff888102bf0800 R14: ffff888102bf0800 R15: 0000000000000000
FS:  00007f6e38b8c4c0(0000) GS:ffff8881b877e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055aa7bff1680 CR3: 0000000105cbe000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 mptcp_recvmsg+0x547/0x8c0 net/mptcp/protocol.c:2329
 inet_recvmsg+0x11f/0x130 net/ipv4/af_inet.c:891
 sock_recvmsg+0x94/0xc0 net/socket.c:1100
 __sys_recvfrom+0xb2/0x130 net/socket.c:2256
 __x64_sys_recvfrom+0x1f/0x30 net/socket.c:2267
 do_syscall_64+0x59/0x2d0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e arch/x86/entry/entry_64.S:131
RIP: 0033:0x7f6e386a4a1d
Code: 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8d 05 f1 de 2c 00 41 89 ca 8b 00 85 c0 75 20 45 31 c9 45 31 c0 b8 2d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 6b f3 c3 66 0f 1f 84 00 00 00 00 00 41 56 41
RSP: 002b:00007ffc3c4bb078 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
RAX: ffffffffffffffda RBX: 000000000000861e RCX: 00007f6e386a4a1d
RDX: 00000000000003ff RSI: 00007ffc3c4bb150 RDI: 0000000000000004
RBP: 00007ffc3c4bb570 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000103 R11: 0000000000000246 R12: 00005605dbc00be0
R13: 00007ffc3c4bb650 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Fixes: 8e04ce45a8db ("mptcp: fix MSG_PEEK stream corruption")
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260330120335.659027-1-lixiasong1@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in protocol.c, because commit bc68b0efa1bf ("mptcp: move the
  whole rx path under msk socket lock protection") and commit
  d88b2127b242 ("mptcp: add eat_recv_skb helper") (with some
  dependences) are not in this version. These conflicts were in the
  context, and not related to this fix. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e682d52a06b7..c34a06b4f21f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1997,7 +1997,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 				struct msghdr *msg,
 				size_t len, int flags, int copied_total,
 				struct scm_timestamping_internal *tss,
-				int *cmsg_flags)
+				int *cmsg_flags, struct sk_buff **last)
 {
 	struct sk_buff *skb, *tmp;
 	int total_data_len = 0;
@@ -2013,6 +2013,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			/* skip already peeked skbs */
 			if (total_data_len + data_len <= copied_total) {
 				total_data_len += data_len;
+				*last = skb;
 				continue;
 			}
 
@@ -2053,6 +2054,8 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			WRITE_ONCE(msk->rmem_released, msk->rmem_released + skb->truesize);
 			__skb_unlink(skb, &msk->receive_queue);
 			__kfree_skb(skb);
+		} else {
+			*last = skb;
 		}
 
 		if (copied >= len)
@@ -2274,10 +2277,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		cmsg_flags = MPTCP_CMSG_INQ;
 
 	while (copied < len) {
+		struct sk_buff *last = NULL;
 		int err, bytes_read;
 
 		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags,
-						  copied, &tss, &cmsg_flags);
+						  copied, &tss, &cmsg_flags,
+						  &last);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;
@@ -2335,7 +2340,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		pr_debug("block timeout %ld\n", timeo);
 		mptcp_cleanup_rbuf(msk, copied);
-		err = sk_wait_data(sk, &timeo, NULL);
+		err = sk_wait_data(sk, &timeo, last);
 		if (err < 0) {
 			err = copied ? : err;
 			goto out_err;
-- 
2.53.0


