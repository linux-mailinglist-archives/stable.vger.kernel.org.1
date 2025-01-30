Return-Path: <stable+bounces-111630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED570A2300E
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651421621DA
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCDE1E8835;
	Thu, 30 Jan 2025 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X4wq7kzG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B351E522;
	Thu, 30 Jan 2025 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247297; cv=none; b=SPItvrfSWAQYjobWIvW+Fm79cSofV+7+K9b8TuRDcOJ4KtNX2UdlKS2wFMBh4V2EdINpA/qUitMfDhdaBSHkyprPPSkPD86ZsTAhVvVwMTaGkQLlhLU24rMPOWPr4gN07yK4cSUyrD0xyyqMP/zN79OqZLjrz5CSruAv5z4lQLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247297; c=relaxed/simple;
	bh=A/KZO45pPPXc33zgC/gjKvAIULTh+cBWXE8OVUaNjGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/pePh20JYxEiFqOGAyWcsnfiPvReosx5ZahTJvBKMlhR4LzJ68k17231dkALrjlyLWj6rmQSBYF+2ANRT4SQhPuj4wu5JJGIueSLOnB//v9KjPsSfww1150fpde3nQ/Te2TccJDT4Tb1yYTQKyyIW8NWDqbWLxqIz4QE+jo+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X4wq7kzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D35C4CED2;
	Thu, 30 Jan 2025 14:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738247297;
	bh=A/KZO45pPPXc33zgC/gjKvAIULTh+cBWXE8OVUaNjGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4wq7kzGTGyt70uBaxYCyjNEeQq+GDkLzVbggkdrSrzfp6CFCXlB1uc3a4Iehga71
	 fLsdpO7w3DJfVKNdKQxXK/A5NXWQFWlYJEjgplP3SNzTqcxT2o1eHCProRQXawPC6W
	 wMiDzG22aTLjN/sYjIVR5I+YLQF6CaSiTLC66QgM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 08/24] mptcp: dont always assume copied data in mptcp_cleanup_rbuf()
Date: Thu, 30 Jan 2025 15:02:00 +0100
Message-ID: <20250130140127.632501332@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140127.295114276@linuxfoundation.org>
References: <20250130140127.295114276@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -462,13 +462,13 @@ static void mptcp_send_ack(struct mptcp_
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
 
@@ -485,7 +485,7 @@ static bool mptcp_subflow_could_cleanup(
 			      (ICSK_ACK_PUSHED2 | ICSK_ACK_PUSHED)));
 }
 
-static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
+static void mptcp_cleanup_rbuf(struct mptcp_sock *msk, int copied)
 {
 	int old_space = READ_ONCE(msk->old_wspace);
 	struct mptcp_subflow_context *subflow;
@@ -493,14 +493,14 @@ static void mptcp_cleanup_rbuf(struct mp
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
 
@@ -2098,9 +2098,6 @@ static int mptcp_recvmsg(struct sock *sk
 
 		copied += bytes_read;
 
-		/* be sure to advertise window change */
-		mptcp_cleanup_rbuf(msk);
-
 		if (skb_queue_empty(&msk->receive_queue) && __mptcp_move_skbs(msk))
 			continue;
 
@@ -2152,9 +2149,12 @@ static int mptcp_recvmsg(struct sock *sk
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



