Return-Path: <stable+bounces-192373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EA9C30F36
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 13:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53DE64F3B48
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 12:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353352EBDC8;
	Tue,  4 Nov 2025 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHPJU8ri"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719329BD96;
	Tue,  4 Nov 2025 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258549; cv=none; b=YJvGr7/pVXNQRxnDke3oZYnd5oeqoCFy5KXUyEy5zUqwdAsdUkL1rSNfB4fcRiOaQTnHAFAU/wxQGqIP1D1YeYaEjzXOSwvqb7tUJ50B43uu999ti3GqAa+KAMod+Wg/dKLV3iFCCQ3nAf33DTbmaXQxF1lO/y4UCYfN7P4Oc3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258549; c=relaxed/simple;
	bh=ACw2vBX42jxFsM07eDSGgWZY/ej/53OwAi0/iqaL8aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwSFcPws9kyKNVpMPYnoN9t7X7Ho+OcJreVQ4Js+M28Qxd1QmFoXoBSdck+kOU7ki3nXhJz0SP9RZtP6XDuj6B/KOacnPg315JuqsQ2SYeu+CX9eymdJ8bfg55HDJJeciZ8vtboYepNcPdf5a6blL17O7qpg8t9XirCo1pucd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHPJU8ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4312C16AAE;
	Tue,  4 Nov 2025 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762258548;
	bh=ACw2vBX42jxFsM07eDSGgWZY/ej/53OwAi0/iqaL8aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sHPJU8ri2tjuWPp2vGJxJ3q3dyjji0vNPiacsibrWwBppMlC42uxZHzVGXD8iKES1
	 dtplSUQF01FOHHvBx8WkxuGfTQq3Ry6YJTeKQBrWwfQdx8inv90cbiYBiNJ8PIacZi
	 5qfxtd0bW5YijrRJkSlPpBEHtavnuWceDUWvRccAY/q77xBSCtffqN8wG7UydaZgiG
	 plfAwS6YCUQDYMV0WJu5Ck/JLqLADdehtM/jN7SLJyCNvrhQPeRVDbyNfCDQdkKiP5
	 GeZFCHutf2bxSGN1pErfhepWeYdCS+vNDp0lFCaNyM+BswqzeL8HmjhVg8whHBThIL
	 oRlGDsPT1Gkxw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: fix MSG_PEEK stream corruption
Date: Tue,  4 Nov 2025 13:15:16 +0100
Message-ID: <20251104121515.1093006-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110208-pond-pouring-512d@gregkh>
References: <2025110208-pond-pouring-512d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4010; i=matttbe@kernel.org; h=from:subject; bh=LOJlpwF16lMiGnFkHh+wBjJqpz1xWbuoVEZ9Jnnsgos=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI534XMjL2cFM9qWW/yQn3+909LA+O9815kiRwyV+SbW nFj5xmtjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInMusvwP3KpAsPCfo1Z/Gom gluZ8jP17JewzF1dz5p14V5fy8R+X0aGOQba0xdcfPH1wu/HWm8WKhvk7F+SE/Tv39uD+7qXJjQ wMgAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 8e04ce45a8db7a080220e86e249198fa676b83dc ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: this is the patch Sasha sent for the v6.6 which applies on v6.12
without conflicts. On v6.12, Sasha sent another version with dependences
that caused some issues, see:
 https://lore.kernel.org/bbe84711-95b2-4257-9f01-560b4473a3da@kernel.org
---
 net/mptcp/protocol.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5ded0841b159..4798892aa178 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1977,19 +1977,35 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
 static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 				struct msghdr *msg,
-				size_t len, int flags,
+				size_t len, int flags, int copied_total,
 				struct scm_timestamping_internal *tss,
 				int *cmsg_flags)
 {
 	struct sk_buff *skb, *tmp;
+	int total_data_len = 0;
 	int copied = 0;
 
 	skb_queue_walk_safe(&msk->receive_queue, skb, tmp) {
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
+
 		if (!(flags & MSG_TRUNC)) {
 			err = skb_copy_datagram_msg(skb, offset, msg, count);
 			if (unlikely(err < 0)) {
@@ -2006,22 +2022,19 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 
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
 			/* we will bulk release the skb memory later */
 			skb->destructor = NULL;
 			WRITE_ONCE(msk->rmem_released, msk->rmem_released + skb->truesize);
 			__skb_unlink(skb, &msk->receive_queue);
 			__kfree_skb(skb);
-			msk->bytes_consumed += count;
 		}
 
 		if (copied >= len)
@@ -2245,7 +2258,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	while (copied < len) {
 		int err, bytes_read;
 
-		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags, &tss, &cmsg_flags);
+		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags,
+						  copied, &tss, &cmsg_flags);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;
-- 
2.51.0


