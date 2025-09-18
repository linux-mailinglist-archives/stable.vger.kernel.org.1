Return-Path: <stable+bounces-175361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19094B367D2
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99079566CA9
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2192F35337D;
	Tue, 26 Aug 2025 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EblfReLt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D366C353371;
	Tue, 26 Aug 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216834; cv=none; b=EgxBKABxDoFWpLLfYpIsHqL63EZh2p0fyCIDD07s3FqQDKdoS84cYz4amybCKueZN67889or3TeI3a0EoSD9XCaZaAjVsZwyjuYydcZf45Ec3c8qQ29v1orfQoSIPZVOxfURFJh2HJsBtqRjtGTj2Am2cCoJBj1qw96Kgn2GLQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216834; c=relaxed/simple;
	bh=m57b2/F3nTwCFb2VN4U+17TKgZXj5GYaySd4eEAI82M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XobXVdzA/S4Hkxb2f05Z6+BKDuWeD/TP5rPKDkOAE0mQ8UcbyJNPhuF99yRJsis1fEUgcks09hkz3TigUTGXy59yHCHtng/Xgnnq+1/YtBRUejrwJm1A9Q1UxO5dpvLF5X3IbxpIjQ72KoxAHJSzEh0+qrQoNsX297FCBkujYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EblfReLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6697EC113CF;
	Tue, 26 Aug 2025 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216834;
	bh=m57b2/F3nTwCFb2VN4U+17TKgZXj5GYaySd4eEAI82M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EblfReLtpRxCTSrV2nbHL/ZWNdrA4FAmYlwSLo/q5eun0OI0dZKsi2s/a1I3K15ts
	 Mp+yzNoUQwCy3mq5YULrtQ20u+rnWLOHq/HxnfMF1VB/c33RQ1kxmNcq2OA0LM1ZDc
	 TL/110fR14e7L9cRUDsBnQgvCfwjoXwOVayoDyQ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dipanjan Das <mail.dipanjan.das@gmail.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.15 560/644] mptcp: do not queue data on closed subflows
Date: Tue, 26 Aug 2025 13:10:51 +0200
Message-ID: <20250826111000.406786353@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    8 +++++++-
 net/mptcp/protocol.h |   11 +++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1350,6 +1350,9 @@ static int mptcp_sendmsg_frag(struct soc
 			 info->limit > dfrag->data_len))
 		return 0;
 
+	if (unlikely(!__tcp_can_send(ssk)))
+		return -EAGAIN;
+
 	/* compute send limit */
 	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
 	copy = info->size_goal;
@@ -1512,7 +1515,8 @@ static struct sock *mptcp_subflow_get_se
 	if (__mptcp_check_fallback(msk)) {
 		if (!msk->first)
 			return NULL;
-		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
+		return __tcp_can_send(msk->first) &&
+		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
 	}
 
 	/* re-use last subflow, if the burst allow that */
@@ -1638,6 +1642,8 @@ void __mptcp_push_pending(struct sock *s
 
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 			if (ret <= 0) {
+				if (ret == -EAGAIN)
+					continue;
 				mptcp_push_release(ssk, &info);
 				goto out;
 			}
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -599,16 +599,19 @@ void mptcp_info2sockaddr(const struct mp
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
 
-static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
+static inline bool __tcp_can_send(const struct sock *ssk)
 {
-	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	/* only send if our side has not closed yet */
+	return ((1 << inet_sk_state_load(ssk)) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
+}
 
+static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
+{
 	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
 	if (subflow->request_join && !subflow->fully_established)
 		return false;
 
-	/* only send if our side has not closed yet */
-	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
+	return __tcp_can_send(mptcp_subflow_tcp_sock(subflow));
 }
 
 void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow);



