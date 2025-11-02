Return-Path: <stable+bounces-192036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95762C28FA7
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83EED4E2C1C
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A3F1D5170;
	Sun,  2 Nov 2025 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xTCgH5Ys"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737B463CF
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762091031; cv=none; b=ZxewvGmPGOSJlme7Q77gpui2DcjXHH8bs5/GF6fcjuXKm7WbAe6PeQ/7MgITHT7U/lsgx5xZvi+srzhTBqouHHq8JwLO7NYRbGAmOGhphnV30kOL81iULu3H8oVZlfpy95lkBBPz90aFkW23ZbEILz0fu5FsNxZZ0Xk+89Vl41U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762091031; c=relaxed/simple;
	bh=+rE3bgAya/GsqzdRVq/pj+WX+eLXQNHjGhOG8iDT0is=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y6DIF5cAGBiyXZTiZkRxd2Zc7FXbjntrVBEUNjQyKc281ePKiHMjPkcPC+9kBrr0RA1E8y9aJQYbhosM6PN2j5rBrryFCNiHdjJsm/h1lIWEs50Av/0xwthr+uQ+bwPb0aPjpXnCUrAkM0DHdsJ/J4C6EH8pq1coUjCi/1FB0B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xTCgH5Ys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE98C4CEF7;
	Sun,  2 Nov 2025 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762091031;
	bh=+rE3bgAya/GsqzdRVq/pj+WX+eLXQNHjGhOG8iDT0is=;
	h=Subject:To:Cc:From:Date:From;
	b=xTCgH5YskLDssNR93lVO0H+jEnyBoDXzVJndz+Pvg9SlrBe/Y+EcLJun+uNPNh01v
	 LiKpcrY9pSEZIT3+dQyiH3rnPwoFsm0zpYbLmA+Oe1XcSc+MdFpOhR5Sze5EYstxMl
	 Rv/uDsobRM/kRX/0VZragQAwok3AYGqmxod9cEtM=
Subject: FAILED: patch "[PATCH] mptcp: drop bogus optimization in __mptcp_check_push()" failed to apply to 5.15-stable tree
To: pabeni@redhat.com,geliang@kernel.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 02 Nov 2025 22:43:40 +0900
Message-ID: <2025110240-confined-stride-2055@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 27b0e701d3872ba59c5b579a9e8a02ea49ad3d3b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110240-confined-stride-2055@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 27b0e701d3872ba59c5b579a9e8a02ea49ad3d3b Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 28 Oct 2025 09:16:52 +0100
Subject: [PATCH] mptcp: drop bogus optimization in __mptcp_check_push()

Accessing the transmit queue without owning the msk socket lock is
inherently racy, hence __mptcp_check_push() could actually quit early
even when there is pending data.

That in turn could cause unexpected tx lock and timeout.

Dropping the early check avoids the race, implicitly relaying on later
tests under the relevant lock. With such change, all the other
mptcp_send_head() call sites are now under the msk socket lock and we
can additionally drop the now unneeded annotation on the transmit head
pointer accesses.

Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251028-net-mptcp-send-timeout-v1-1-38ffff5a9ec8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 875027b9319c..655a2a45224f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1007,7 +1007,7 @@ static void __mptcp_clean_una(struct sock *sk)
 			if (WARN_ON_ONCE(!msk->recovery))
 				break;
 
-			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+			msk->first_pending = mptcp_send_next(sk);
 		}
 
 		dfrag_clear(sk, dfrag);
@@ -1552,7 +1552,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		msk->first_pending = mptcp_send_next(sk);
 
 		if (msk->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
@@ -1912,7 +1912,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			get_page(dfrag->page);
 			list_add_tail(&dfrag->list, &msk->rtx_queue);
 			if (!msk->first_pending)
-				WRITE_ONCE(msk->first_pending, dfrag);
+				msk->first_pending = dfrag;
 		}
 		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d\n", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
@@ -2882,7 +2882,7 @@ static void __mptcp_clear_xmit(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
 
-	WRITE_ONCE(msk->first_pending, NULL);
+	msk->first_pending = NULL;
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list)
 		dfrag_clear(sk, dfrag);
 }
@@ -3422,9 +3422,6 @@ void __mptcp_data_acked(struct sock *sk)
 
 void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 {
-	if (!mptcp_send_head(sk))
-		return;
-
 	if (!sock_owned_by_user(sk))
 		__mptcp_subflow_push_pending(sk, ssk, false);
 	else
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 52f9cfa4ce95..379a88e14e8d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -414,7 +414,7 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 
-	return READ_ONCE(msk->first_pending);
+	return msk->first_pending;
 }
 
 static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)


