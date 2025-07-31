Return-Path: <stable+bounces-165651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BD2B17055
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 13:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9881726F6
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 11:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2847C2C08B0;
	Thu, 31 Jul 2025 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDyf6dNZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78F2BDC38;
	Thu, 31 Jul 2025 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961069; cv=none; b=j2c6ph1T/oFU51axozmn+kg/Df4X/SugKrwQwivbaoA48ZXT4OdEImrFM/MK7S9A86d+1RRlurtd/VAMHD2evVEWt81CMhp4AXGVLXM50h70E5oWQSnPgvecucb4oFNIo8dof5nWK3DUOOwMG1oP6yMg0ECGINcao8SZdnOw2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961069; c=relaxed/simple;
	bh=p4f9HLKx6WzT9jNMNqLMGwTM73cjvY8OTDsMvc7A11M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3JjzXGlgai4lfpkhDReCyhLdPSUAsoQiZL9noLQwMIOrpQ2WrzEMm/UJ482VqW5jAQ7p9qiFq1tZZzzeh2y2KP0xQnR81wR/Oy/H7WZg09RbZc5B31UTC+NXDa+eN6vX1XnXr1P6dAveEPRHfrGUfPgZpf+xGfKV822mViQdP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDyf6dNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F95C4CEF6;
	Thu, 31 Jul 2025 11:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753961068;
	bh=p4f9HLKx6WzT9jNMNqLMGwTM73cjvY8OTDsMvc7A11M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UDyf6dNZPoUMKXr97mF6WboHWiOtgh3i2Fir1tpCamsOxWgWQznwRkxzEp0MtaiRy
	 h6FI4awdIhbVOMW/BzejNG+XwcBn2zj1ctjbBFqx+PFrV7dAPX1YnDzynC1fIm6ICF
	 LoRDSI3qk9yumIAzLZFlhVk6G9NXpIgxwVJay79qbW3aO9MXUavMC1zC2fA1+kaqMN
	 wGtAYlkgucj2EKHanIKg6ArdRIkzWiPLlH4caU7RrFo/1gWmYgy/yCo5L+fUwF2SMp
	 rRYLfsjCWRYlkMHFayQ+DDBE75G1gxY4454p3zz7/7DvEqSlRQuCzCeZB8NcFgh1rj
	 HuKVgPSW6V6dQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Dipanjan Das <mail.dipanjan.das@gmail.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.15.y 6/6] mptcp: do not queue data on closed subflows
Date: Thu, 31 Jul 2025 13:24:00 +0200
Message-ID: <20250731112353.2638719-14-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250731112353.2638719-8-matttbe@kernel.org>
References: <20250731112353.2638719-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5163; i=matttbe@kernel.org; h=from:subject; bh=U0XNF1CDFKt2Tpezty8ofYSiZ9LjPTlhIFxPrOSkEQY=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK6g8KqwwVcVy9eMn3uB/7vS4/F2ETyb2uSrvjxL5Hz5 4GJXMEbO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZyKIKRob/1c/yUqlmy5ox3 nri8ybzps/F911+vm6ti1ofm7PJ+U83I8HAZ/5T2/Ei5uWevnVtw103hzffGXw69lzvnu/9ItF+ 9mg8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit c886d70286bf3ad411eb3d689328a67f7102c6ae upstream.

Dipanjan reported a syzbot splat at close time:

WARNING: CPU: 1 PID: 10818 at net/ipv4/af_inet.c:153
inet_sock_destruct+0x6d0/0x8e0 net/ipv4/af_inet.c:153
Modules linked in: uio_ivshmem(OE) uio(E)
CPU: 1 PID: 10818 Comm: kworker/1:16 Tainted: G           OE
5.19.0-rc6-g2eae0556bb9d #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: events mptcp_worker
RIP: 0010:inet_sock_destruct+0x6d0/0x8e0 net/ipv4/af_inet.c:153
Code: 21 02 00 00 41 8b 9c 24 28 02 00 00 e9 07 ff ff ff e8 34 4d 91
f9 89 ee 4c 89 e7 e8 4a 47 60 ff e9 a6 fc ff ff e8 20 4d 91 f9 <0f> 0b
e9 84 fe ff ff e8 14 4d 91 f9 0f 0b e9 d4 fd ff ff e8 08 4d
RSP: 0018:ffffc9001b35fa78 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000002879d0 RCX: ffff8881326f3b00
RDX: 0000000000000000 RSI: ffff8881326f3b00 RDI: 0000000000000002
RBP: ffff888179662674 R08: ffffffff87e983a0 R09: 0000000000000000
R10: 0000000000000005 R11: 00000000000004ea R12: ffff888179662400
R13: ffff888179662428 R14: 0000000000000001 R15: ffff88817e38e258
FS:  0000000000000000(0000) GS:ffff8881f5f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020007bc0 CR3: 0000000179592000 CR4: 0000000000150ee0
Call Trace:
 <TASK>
 __sk_destruct+0x4f/0x8e0 net/core/sock.c:2067
 sk_destruct+0xbd/0xe0 net/core/sock.c:2112
 __sk_free+0xef/0x3d0 net/core/sock.c:2123
 sk_free+0x78/0xa0 net/core/sock.c:2134
 sock_put include/net/sock.h:1927 [inline]
 __mptcp_close_ssk+0x50f/0x780 net/mptcp/protocol.c:2351
 __mptcp_destroy_sock+0x332/0x760 net/mptcp/protocol.c:2828
 mptcp_worker+0x5d2/0xc90 net/mptcp/protocol.c:2586
 process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
 worker_thread+0x623/0x1070 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

The root cause of the problem is that an mptcp-level (re)transmit can
race with mptcp_close() and the packet scheduler checks the subflow
state before acquiring the socket lock: we can try to (re)transmit on
an already closed ssk.

Fix the issue checking again the subflow socket status under the
subflow socket lock protection. Additionally add the missing check
for the fallback-to-tcp case.

Fixes: d5f49190def6 ("mptcp: allow picking different xmit subflows")
Reported-by: Dipanjan Das <mail.dipanjan.das@gmail.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c |  8 +++++++-
 net/mptcp/protocol.h | 11 +++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6e9d1a749950..bf2b9ba1c734 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1350,6 +1350,9 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			 info->limit > dfrag->data_len))
 		return 0;
 
+	if (unlikely(!__tcp_can_send(ssk)))
+		return -EAGAIN;
+
 	/* compute send limit */
 	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
 	copy = info->size_goal;
@@ -1512,7 +1515,8 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	if (__mptcp_check_fallback(msk)) {
 		if (!msk->first)
 			return NULL;
-		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
+		return __tcp_can_send(msk->first) &&
+		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
 	}
 
 	/* re-use last subflow, if the burst allow that */
@@ -1638,6 +1642,8 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 			if (ret <= 0) {
+				if (ret == -EAGAIN)
+					continue;
 				mptcp_push_release(ssk, &info);
 				goto out;
 			}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cfb6aa72515e..8d05fb205a31 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -599,16 +599,19 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
 
+static inline bool __tcp_can_send(const struct sock *ssk)
+{
+	/* only send if our side has not closed yet */
+	return ((1 << inet_sk_state_load(ssk)) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
+}
+
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 {
-	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-
 	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
 	if (subflow->request_join && !subflow->fully_established)
 		return false;
 
-	/* only send if our side has not closed yet */
-	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
+	return __tcp_can_send(mptcp_subflow_tcp_sock(subflow));
 }
 
 void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow);
-- 
2.50.0


