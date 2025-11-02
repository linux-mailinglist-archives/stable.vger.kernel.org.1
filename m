Return-Path: <stable+bounces-192038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22873C28FAB
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EAA188BDE2
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529631D798E;
	Sun,  2 Nov 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zk/Lfxr4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052B63CF
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762091053; cv=none; b=MnCdxmhoKlwP4NMgIewCSpfWJnu3oND/BG824/XfbluJCy9RM15LUXnwA1zjzDvUA3xlLx8/eBJ99QwlE7ec8HwZwAriRwE4V/RQixpq6xdBrwL1A8NGuswThtlINWtLLW6JEPdpAYuCfRJ8R/aURpVjPWCzPfSGLaP7CnRqLww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762091053; c=relaxed/simple;
	bh=D5veGy9lOHCSAOsB6/TMGybv7yp+7zJipSkKqE2AJT4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FYQxMzyfwO5+fSgtA+reoS7xBdu9ZIGPGf+39BqLTeGadpatOWn07VSafTepP8MxjL/fPXctUzuT3ca6RRClUqP4h6Fr4iNpyxDCywoxo69Ch8qGC4b8X51/6DywxxGaGnNogOePYQV9goyOh2cWd5EksR8Mkn3DcLZ4qSb4E2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zk/Lfxr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6B0C4CEF7;
	Sun,  2 Nov 2025 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762091052;
	bh=D5veGy9lOHCSAOsB6/TMGybv7yp+7zJipSkKqE2AJT4=;
	h=Subject:To:Cc:From:Date:From;
	b=zk/Lfxr46/FmPwZ6OHdDMJtCpyO/nQj35f/gpa/6rIhLgqclwCWLix3AphhM7aY+W
	 WI7hnGUJKHbWgXGIPFa3xRJkf69GzpJ6xD4tULLnsaoQfp34axxljpbdPQ+CBjg9wA
	 hrDb68/iVRsazk/P14aD+gtFxkxn/UVvxQQasGcw=
Subject: FAILED: patch "[PATCH] mptcp: fix MSG_PEEK stream corruption" failed to apply to 6.12-stable tree
To: pabeni@redhat.com,geliang@kernel.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 02 Nov 2025 22:44:08 +0900
Message-ID: <2025110208-pond-pouring-512d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8e04ce45a8db7a080220e86e249198fa676b83dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110208-pond-pouring-512d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e04ce45a8db7a080220e86e249198fa676b83dc Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 28 Oct 2025 09:16:53 +0100
Subject: [PATCH] mptcp: fix MSG_PEEK stream corruption

If a MSG_PEEK | MSG_WAITALL read operation consumes all the bytes in the
receive queue and recvmsg() need to waits for more data - i.e. it's a
blocking one - upon arrival of the next packet the MPTCP protocol will
start again copying the oldest data present in the receive queue,
corrupting the data stream.

Address the issue explicitly tracking the peeked sequence number,
restarting from the last peeked byte.

Fixes: ca4fb892579f ("mptcp: add MSG_PEEK support")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251028-net-mptcp-send-timeout-v1-2-38ffff5a9ec8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 655a2a45224f..2535788569ab 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1945,22 +1945,36 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
-static int __mptcp_recvmsg_mskq(struct sock *sk,
-				struct msghdr *msg,
-				size_t len, int flags,
+static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
+				size_t len, int flags, int copied_total,
 				struct scm_timestamping_internal *tss,
 				int *cmsg_flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb, *tmp;
+	int total_data_len = 0;
 	int copied = 0;
 
 	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
-		u32 offset = MPTCP_SKB_CB(skb)->offset;
+		u32 delta, offset = MPTCP_SKB_CB(skb)->offset;
 		u32 data_len = skb->len - offset;
-		u32 count = min_t(size_t, len - copied, data_len);
+		u32 count;
 		int err;
 
+		if (flags & MSG_PEEK) {
+			/* skip already peeked skbs */
+			if (total_data_len + data_len <= copied_total) {
+				total_data_len += data_len;
+				continue;
+			}
+
+			/* skip the already peeked data in the current skb */
+			delta = copied_total - total_data_len;
+			offset += delta;
+			data_len -= delta;
+		}
+
+		count = min_t(size_t, len - copied, data_len);
 		if (!(flags & MSG_TRUNC)) {
 			err = skb_copy_datagram_msg(skb, offset, msg, count);
 			if (unlikely(err < 0)) {
@@ -1977,16 +1991,14 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 
 		copied += count;
 
-		if (count < data_len) {
-			if (!(flags & MSG_PEEK)) {
+		if (!(flags & MSG_PEEK)) {
+			msk->bytes_consumed += count;
+			if (count < data_len) {
 				MPTCP_SKB_CB(skb)->offset += count;
 				MPTCP_SKB_CB(skb)->map_seq += count;
-				msk->bytes_consumed += count;
+				break;
 			}
-			break;
-		}
 
-		if (!(flags & MSG_PEEK)) {
 			/* avoid the indirect call, we know the destructor is sock_rfree */
 			skb->destructor = NULL;
 			skb->sk = NULL;
@@ -1994,7 +2006,6 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 			sk_mem_uncharge(sk, skb->truesize);
 			__skb_unlink(skb, &sk->sk_receive_queue);
 			skb_attempt_defer_free(skb);
-			msk->bytes_consumed += count;
 		}
 
 		if (copied >= len)
@@ -2191,7 +2202,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	while (copied < len) {
 		int err, bytes_read;
 
-		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags, &tss, &cmsg_flags);
+		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
+						  copied, &tss, &cmsg_flags);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;


