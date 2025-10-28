Return-Path: <stable+bounces-191408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB830C137F8
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 09:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5983F424A4B
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2E12D97BE;
	Tue, 28 Oct 2025 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtrO9Klp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B9F2D978C;
	Tue, 28 Oct 2025 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639439; cv=none; b=KCYUSMiWBwApMTVBGst/Jj0DZ0w5uLhd5R57WA7DCS1pX6VNrOUly6DzhRBHGcc+X26sE3KuAhXxtAziTdckXGm6USm4yGnZ0vmWH5EoykP2GHdCpagQAV7WkEQdjZRRiE3+DtGmeDXX51/qmDv0FJ6GrxJ4+VstHBfsprnppOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639439; c=relaxed/simple;
	bh=nL9dXwI9NSktkJY3wKwnlfnkUqTZJXAP53e/3H1C2qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLgFHgFTFQZi08QxDWD5kYU1xE3i4svOeWgAb0z3K3Rjl+Tbi/YeZ400bFqNCiS7cBGDKHvfy0OwA7S5tGiA5Pli1wtvMGJmQagblPo8L7yxNMyMqb4EZIb0EuQRgqDunws58B/pbUcchs+uABCmfto+AoAkKxRGIg1POR3kaT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtrO9Klp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DFAC4CEE7;
	Tue, 28 Oct 2025 08:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761639439;
	bh=nL9dXwI9NSktkJY3wKwnlfnkUqTZJXAP53e/3H1C2qg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RtrO9KlpThNTCus0C+ihXV98ZlPBA8BA7asqikWWNhm/q4u5UkROR89Xnbsl4Sz29
	 PJD0iekAyQ2CxtrUFtGBqEF6dIC+5fM3+nNEWKscnlXXH6SplJamtcMAGcClZUlz5n
	 FndRiu9qH4/eV4TGJynG/nIa7qQKjQb7gt3GnBo5nsYNGo+MS0eZPLNiJSPyny9v8T
	 ouYxUEznaFNvMq8rFSuePU6NlV8wFOQjBjJ1hN/avFU+e2vW+8P2sq3ZxaiFKiIiP+
	 R8JZNKryJkDVnCP5neJFkhV1dzJhtUsHI4LSsXkHPDuERgmmTuruQDBPeJoJMXebRG
	 gi/Lb0iLIVN8g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 28 Oct 2025 09:16:53 +0100
Subject: [PATCH net 2/4] mptcp: fix MSG_PEEK stream corruption
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-net-mptcp-send-timeout-v1-2-38ffff5a9ec8@kernel.org>
References: <20251028-net-mptcp-send-timeout-v1-0-38ffff5a9ec8@kernel.org>
In-Reply-To: <20251028-net-mptcp-send-timeout-v1-0-38ffff5a9ec8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Yonglong Li <liyonglong@chinatelecom.cn>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3693; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mvPa5cNaO0WufhqYUT0D9AMyoT4bWm+wn7In4tiEqRc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIZapiy2A2c24SijrOkbKyVmH38doK1kZ/u9YM2DduVD
 y6SKJXoKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmIjhMYb/lXFLy3ZdE/+p7er4
 fKH5rDtp+ff0w9Iz/xiF+73ckBC6nuGfypeeJ2vL26fZLbN2UFrnvObChBWzHURfLP4p4S5nqH2
 PGwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

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
---
 net/mptcp/protocol.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bf2c9e4f3ba9..d6d1553fbd61 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1936,22 +1936,36 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
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
@@ -1968,16 +1982,14 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 
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
@@ -1985,7 +1997,6 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 			sk_mem_uncharge(sk, skb->truesize);
 			__skb_unlink(skb, &sk->sk_receive_queue);
 			skb_attempt_defer_free(skb);
-			msk->bytes_consumed += count;
 		}
 
 		if (copied >= len)
@@ -2183,7 +2194,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	while (copied < len) {
 		int err, bytes_read;
 
-		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags, &tss, &cmsg_flags);
+		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
+						  copied, &tss, &cmsg_flags);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;

-- 
2.51.0


