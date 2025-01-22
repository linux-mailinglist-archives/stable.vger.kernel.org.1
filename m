Return-Path: <stable+bounces-110149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D255A19075
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 12:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3706F3ADC61
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 11:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1042211A1D;
	Wed, 22 Jan 2025 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9F5mgGQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7B211A0A;
	Wed, 22 Jan 2025 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737544547; cv=none; b=cOoab1EWlduLODQW7zZzN/ZdfNqpOR3k3J9Lt/PppiX4aXEzt7GZBVpw0TN90Uvt6NjVkf9VfHJlOKGl0vhExS+GtUWldavlNnOfhSFx3qASTxlNvC9Ytr/1gUQAOIzlsqgXkOFsoMvyk7ypBWT996E5p2cbuXXvFrqOILSOMWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737544547; c=relaxed/simple;
	bh=YDrOx5B7d2Y5Le84CZjOgzWnXTAdpeR9BU8Kc84Gtb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQa4GvMMEZ4Z5paPLc6L/SUadZPXJ0GLrnKxMw1V9FetEdJr0HFaAHRYl2nYPHWZeVbVIEqlaEANulfe3GiYFGd6TCJLTTSZsXO817IiYN3Kf8AcWdM6O5dvDC/5FXGAigjMC0QHuYqk4k5/ToMBW6wXnu2veiE/OzmAzJdEdtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9F5mgGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F302C4CED6;
	Wed, 22 Jan 2025 11:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737544547;
	bh=YDrOx5B7d2Y5Le84CZjOgzWnXTAdpeR9BU8Kc84Gtb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9F5mgGQAAK91l+p7k1eK+vU1NOBhywJMs1UycS3TB6wFF0DFNwab4HEa2iVY0sWv
	 opd9wywzdIPKYRPibr6EJZ0PKFdcGQHiEzaw7oGS/vxstOL8XM5QqvcJRzRhDN374s
	 7fN3VzuTL2obkjYXOc+ursBCaa/E2qYwzEVdHpdDQ1FBSS/be+XvKmwvgVNhBS+Djt
	 FbljRif9YoAJEXTZ8S0hbypyHzK/Cure6hPPEBKjQedAXzozGMaGbMJ5J/PcPBrrMl
	 UMjZS8y+UmdtVrEMHveXF4T61+FzrfCu5x+wN/nUaNQaYxvIwuuDhomAKeRjHL4UJo
	 r0CN8Ainydevg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: don't always assume copied data in mptcp_cleanup_rbuf()
Date: Wed, 22 Jan 2025 12:15:18 +0100
Message-ID: <20250122111517.3284651-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025010605-obscurity-buckshot-fc5f@gregkh>
References: <2025010605-obscurity-buckshot-fc5f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3522; i=matttbe@kernel.org; h=from:subject; bh=g3aq2QVbK0t4f2yTFf2FQj1+Op3wV1YhRslbMg0d5rQ=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnkNNFRFpCNYxI1LVQ1w0B6btz6D8a30qGpPMDu bjj8OGbvjuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ5DTRQAKCRD2t4JPQmmg cwP+D/95WKnrpvM6f5SR5bnh9f6mMvMaTNBZznbGfLeUi264iS2FIlOqBepKfDHQKsu5qLeCqdT oVbUZWAtO6YWizXC0Yxdw6AVy0ypOUARSHNB3uUF0ArKC0mTCPV8xh1LNEzBxVPP83lHqPoXpWw L/bfaaXAy/hY1tjfZwiI4lWtRXTu6ppqfU5M1aNkgNQh1AxrfT3Sz1MQBgUk94zCtyLtk4MFSF0 i+fQSXdPdLnlwAiD5mxmApvBQG1EAEE9jSgQ7Fr+EMVfzwQo1C/9uU+49djJ27g6Mu5ePceD0Pe GoLxHVdpMJapw9X0aQLUe67EdbdCJr0Hb2SO07KpYdCSsMVHWqHe60cU1cM52UtkkHHG/EkBvuU jkKwnBZ2LcQM6b4p7CV2CDTHGuEHuJGgy8jNl2PZqcrRf9TCWHqPyya5Hnd9KrtYE+F/7fLKwyt 7NWtfECfn3aTBuXd7D8E2/B4xYiOREe8UyiR0oF/6qsK//RHvmHtEMXGYRGDrqg9X5qAafOta4U ZJ32IuK75zzKQ/lVTMyAmmOV7b+ptWpPXjmvyvQ4YSNe60qKFxt/ddH4Rn4CeWxw5KWX0GsJLIS FQD2q6iBTvf26I8QSUPkJVlohyVkFlxjQu5REnQQGH9u+qsnsr2jHQXdy1F5GO5oLjDet2jDzEU bmmZWQ3dhe99d4g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 551844f26da2a9f76c0a698baaffa631d1178645 upstream.

Under some corner cases the MPTCP protocol can end-up invoking
mptcp_cleanup_rbuf() when no data has been copied, but such helper
assumes the opposite condition.

Explicitly drop such assumption and performs the costly call only
when strictly needed - before releasing the msk socket lock.

Fixes: fd8976790a6c ("mptcp: be careful on MPTCP-level ack.")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241230-net-mptcp-rbuf-fixes-v1-2-8608af434ceb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in this version, because commit 581302298524 ("mptcp: error
  out earlier on disconnect") has not been backported to this version,
  and there was no need to do so. The only conflict was in protocol.c,
  and easy to resolve: the context was different, but the same addition
  can still be made at the same spot in mptcp_recvmsg(). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bcbb1f92ce24..f337dd3323a0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -462,13 +462,13 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
 		mptcp_subflow_send_ack(mptcp_subflow_tcp_sock(subflow));
 }
 
-static void mptcp_subflow_cleanup_rbuf(struct sock *ssk)
+static void mptcp_subflow_cleanup_rbuf(struct sock *ssk, int copied)
 {
 	bool slow;
 
 	slow = lock_sock_fast(ssk);
 	if (tcp_can_send_ack(ssk))
-		tcp_cleanup_rbuf(ssk, 1);
+		tcp_cleanup_rbuf(ssk, copied);
 	unlock_sock_fast(ssk, slow);
 }
 
@@ -485,7 +485,7 @@ static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
 			      (ICSK_ACK_PUSHED2 | ICSK_ACK_PUSHED)));
 }
 
-static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
+static void mptcp_cleanup_rbuf(struct mptcp_sock *msk, int copied)
 {
 	int old_space = READ_ONCE(msk->old_wspace);
 	struct mptcp_subflow_context *subflow;
@@ -493,14 +493,14 @@ static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
 	int space =  __mptcp_space(sk);
 	bool cleanup, rx_empty;
 
-	cleanup = (space > 0) && (space >= (old_space << 1));
-	rx_empty = !__mptcp_rmem(sk);
+	cleanup = (space > 0) && (space >= (old_space << 1)) && copied;
+	rx_empty = !__mptcp_rmem(sk) && copied;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		if (cleanup || mptcp_subflow_could_cleanup(ssk, rx_empty))
-			mptcp_subflow_cleanup_rbuf(ssk);
+			mptcp_subflow_cleanup_rbuf(ssk, copied);
 	}
 }
 
@@ -2098,9 +2098,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		/* be sure to advertise window change */
-		mptcp_cleanup_rbuf(msk);
-
 		if (skb_queue_empty(&msk->receive_queue) && __mptcp_move_skbs(msk))
 			continue;
 
@@ -2152,9 +2149,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 
 		pr_debug("block timeout %ld\n", timeo);
+		mptcp_cleanup_rbuf(msk, copied);
 		sk_wait_data(sk, &timeo, NULL);
 	}
 
+	mptcp_cleanup_rbuf(msk, copied);
+
 out_err:
 	if (cmsg_flags && copied >= 0) {
 		if (cmsg_flags & MPTCP_CMSG_TS)
-- 
2.47.1


