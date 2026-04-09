Return-Path: <stable+bounces-235380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNMqFN2R12k2PwgAu9opvQ
	(envelope-from <stable+bounces-235380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 13:47:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D449A3C9D86
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 13:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E67C306578C
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 11:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022843A2550;
	Thu,  9 Apr 2026 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odAE712+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D1438836A;
	Thu,  9 Apr 2026 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735134; cv=none; b=nZnIm1l9ivhrzyx9BjhZBRDf4q8s+KjwWw1H3IJRM3OtgeK4+masd6CxmlYqLtE8zdoplBDOCJ/YesV2Dg+n3rFm6u+injJibpiNmFRDPTiJFMf9ySSrUdqqVLSjgSgNm5aBHzzJ4uPf3t3eFG3BneaN65KxOq/D1uuwUnBktHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735134; c=relaxed/simple;
	bh=50MkiAbVt7I8o9d1BKURD7MtyMbFg2dS4KX3vjddlsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVPV40okyTfcSrpmVT36pr0YV8oXmdl2JGvCU2GUAMt0xzE/mubqg0Bg5kZoDV7HhhzKuVwTxJIFokM8Kso7DSBzQ1r2sCjEpe185na6ChMvqFCydzHGWeaPhhyMX0DGwh8cU4O+Dp8NEbbAP+d42W+UiTV+t0K/79czFb3UTtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odAE712+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524A8C2BC87;
	Thu,  9 Apr 2026 11:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775735134;
	bh=50MkiAbVt7I8o9d1BKURD7MtyMbFg2dS4KX3vjddlsA=;
	h=From:To:Cc:Subject:Date:From;
	b=odAE712+YzJkCWXpMCKqBPvOXky+il3Qs33PFyl2IVDg6LTrtnQ6tYkuZwkOuVKd+
	 2Scmrjk4hfE75I7Q844sJjRCNqWiWaV0Sbhu5uBA0Q1feyHdOOxd8MLas9dPOzw4Ge
	 fNIao1iCHakTwUZSM2CNKJP9ve/rRZ77EZAA2BH8B0Q+ryX9GBape+wa1jtRsdT50E
	 xm1quN5u46MQCU4D6yrldaHVgpz41iVuH669Pn7IMOW8o8l0Up1MW/P2Agd67eDAIE
	 /DjTVFl4gQkQt8qoQnUNoBpzSnczr3cyNJUbsJUENufVZdHZdw9mJucdMzxwfGUDJj
	 rCaxT8JbczoxQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Li Xiasong <lixiasong1@huawei.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] mptcp: fix soft lockup in mptcp_recvmsg()
Date: Thu,  9 Apr 2026 13:45:26 +0200
Message-ID: <20260409114525.1159899-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5224; i=matttbe@kernel.org; h=from:subject; bh=a/uxjm+nSJGTdf8zPfmSiLHrAtbKBhqHQHfs5R2JC1I=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKvTwyLfu6Snm2iJrzEVf2PxLQu3emZQcsvp0wMejDvo 9fRRHvfjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIl8c2VkWKguH31NafeTmz+9 j96cdORgWfmv+PMCN1x3PbK/22RX/p3hf/49b42WdQ+zIq88at0rmXVn5eLsnVJdcpKPbPycDHW NmAE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235380-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: D449A3C9D86
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
index 85ef9042873b..517b9a5b6867 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1960,7 +1960,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 				struct msghdr *msg,
 				size_t len, int flags, int copied_total,
 				struct scm_timestamping_internal *tss,
-				int *cmsg_flags)
+				int *cmsg_flags, struct sk_buff **last)
 {
 	struct sk_buff *skb, *tmp;
 	int total_data_len = 0;
@@ -1976,6 +1976,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			/* skip already peeked skbs */
 			if (total_data_len + data_len <= copied_total) {
 				total_data_len += data_len;
+				*last = skb;
 				continue;
 			}
 
@@ -2016,6 +2017,8 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			WRITE_ONCE(msk->rmem_released, msk->rmem_released + skb->truesize);
 			__skb_unlink(skb, &msk->receive_queue);
 			__kfree_skb(skb);
+		} else {
+			*last = skb;
 		}
 
 		if (copied >= len)
@@ -2237,10 +2240,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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
@@ -2298,7 +2303,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		pr_debug("block timeout %ld\n", timeo);
 		mptcp_cleanup_rbuf(msk, copied);
-		err = sk_wait_data(sk, &timeo, NULL);
+		err = sk_wait_data(sk, &timeo, last);
 		if (err < 0) {
 			err = copied ? : err;
 			goto out_err;
-- 
2.53.0


