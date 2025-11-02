Return-Path: <stable+bounces-192035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF8BC28FA4
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DEB8F34765E
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CED01D5170;
	Sun,  2 Nov 2025 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZYlImjPa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BA63CF
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762091022; cv=none; b=SQVgzhjVNqWTPzP53b7haOZEyA1j6ZDd5vOgxLbpsUccVttbPkKoVFHk/3jF5rITdwHakzrs7f3AW2D3iI8Y/UxE4Z3wEl6c1xJy7HEWNyZNYib/ODS4EAi0dA8e5cDzfwijJR0qed+xwf2xdvQj9deU5hB2yr0kzRkSCT7dvyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762091022; c=relaxed/simple;
	bh=8qI5GDz3msW4mDbyfzfM+EETxLDqBaB8hfp2sk8WkFU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EePbqcG89WRglmDLYNmQUuE39dVcGOL+tBhOq6VhlGSFjqaJ0s+tFr+cfsNfBHkoP8nN9oIIiBmN70AsdT94ooeD+g+n4+k1/RZedLxZT66ndJ1tydhbw5B4smLVToInvJBs2KLtjvLVvcqcH2EocV1rJv7rReMQiSql25Ky4VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZYlImjPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1175C4CEF7;
	Sun,  2 Nov 2025 13:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762091022;
	bh=8qI5GDz3msW4mDbyfzfM+EETxLDqBaB8hfp2sk8WkFU=;
	h=Subject:To:Cc:From:Date:From;
	b=ZYlImjPaJ0l5gLePO0sc5sF8tIxpVhwzJxKg7q7krx5bykxpVSMogu6zbm0tlLCgl
	 Sy2ejDIhpsmLb0NBrdrEViMn3NP9mwY3/tTzun/5xawSiqeiXaBcnrodxY6SHTJe5z
	 FQgiwJalzU1jX/78FOApeKihrKGHLXlDc1gqsS6o=
Subject: FAILED: patch "[PATCH] mptcp: drop bogus optimization in __mptcp_check_push()" failed to apply to 6.1-stable tree
To: pabeni@redhat.com,geliang@kernel.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 02 Nov 2025 22:43:39 +0900
Message-ID: <2025110239-gender-concise-c9df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 27b0e701d3872ba59c5b579a9e8a02ea49ad3d3b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110239-gender-concise-c9df@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


