Return-Path: <stable+bounces-192087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CC2C29628
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 21:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893633AD363
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 20:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7FD22301;
	Sun,  2 Nov 2025 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGqagqf2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D0128E5
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762114553; cv=none; b=JGJTmTbcho/aIFRbCpliZAwvChgVV85QFP1yl4Ws7rgGNJxZW5m34mlhCkrSaAW4roJ6wP4cME6mYdyKmJEX+kPwB6Bm9aBef4PtH4tHxs9p5t3FyJCv2pTR8CCdz1dan+wZZjGshafLzJ85aUwaL+KXDMcyuQ7LjKxL6fcgrFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762114553; c=relaxed/simple;
	bh=bFBobO/Iaf7jnfY/ou2I7Nbq7LW4wWQZpvZcNdb1neg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvRcQ7pUewya1y+1+vm90+kmZCGXk3p2aQsKM5CF7jNW0O6jyQU4RrrDCmbyJFJrZY9c3/c8Vjm0hHT30EcDnawOeGjbMHtIpP4n52QEfQ0fdan3zik+2JzTG14kHA5Z7xyXAb+TJP3myux8/HOJqVq5Zg2JMLaD2wUn0NaYPs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGqagqf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F457C4CEF7;
	Sun,  2 Nov 2025 20:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762114553;
	bh=bFBobO/Iaf7jnfY/ou2I7Nbq7LW4wWQZpvZcNdb1neg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGqagqf2Ten/Ds/iHIrTLc70afpbNuc/ecEgwMDu4Pt1DArcPVeAsXZk+hD5SlBrA
	 io0TExZZ2Ru8pAVwDqQmcaK4NqjKQGW07SFCkwFGJgvUq1KpS/TZ4bCQ+b/IroZ3e+
	 6pnGcswam6cmQV5bEmhOgkfhF3oOJGgbIC+0+WA0WJBOhagO0Ml7lpKJpEhAbBvIyM
	 BHLcj310bosAOb1lidCBHVbAwYIt4wHgPMf/mtFwsMAlNbR/y09xUzr9wl+ukTUWbA
	 CERCgxsamJs/FE8ulYxZNOi1FRp0jO7zPQKGPafAfop7u/rS5BXKlfcaFyDh2aAVFm
	 7oa9lUzJ/O9aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mptcp: drop bogus optimization in __mptcp_check_push()
Date: Sun,  2 Nov 2025 15:15:50 -0500
Message-ID: <20251102201550.3588174-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110240-confined-stride-2055@gregkh>
References: <2025110240-confined-stride-2055@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 27b0e701d3872ba59c5b579a9e8a02ea49ad3d3b ]

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
[ split upstream __subflow_push_pending modification across __mptcp_push_pending and __mptcp_subflow_push_pending ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 13 +++++--------
 net/mptcp/protocol.h |  2 +-
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 490fd8b188894..b7bcbc9d3443e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1137,7 +1137,7 @@ static void __mptcp_clean_una(struct sock *sk)
 			if (WARN_ON_ONCE(!msk->recovery))
 				break;
 
-			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+			msk->first_pending = mptcp_send_next(sk);
 		}
 
 		dfrag_clear(sk, dfrag);
@@ -1669,7 +1669,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		msk->first_pending = mptcp_send_next(sk);
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1727,7 +1727,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		msk->first_pending = mptcp_send_next(sk);
 	}
 
 out:
@@ -1845,7 +1845,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			get_page(dfrag->page);
 			list_add_tail(&dfrag->list, &msk->rtx_queue);
 			if (!msk->first_pending)
-				WRITE_ONCE(msk->first_pending, dfrag);
+				msk->first_pending = dfrag;
 		}
 		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d\n", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
@@ -2640,7 +2640,7 @@ static void __mptcp_clear_xmit(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
 
-	WRITE_ONCE(msk->first_pending, NULL);
+	msk->first_pending = NULL;
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list)
 		dfrag_clear(sk, dfrag);
 }
@@ -3109,9 +3109,6 @@ void __mptcp_data_acked(struct sock *sk)
 
 void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 {
-	if (!mptcp_send_head(sk))
-		return;
-
 	if (!sock_owned_by_user(sk)) {
 		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c93399d116508..56169623029ce 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -325,7 +325,7 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 
-	return READ_ONCE(msk->first_pending);
+	return msk->first_pending;
 }
 
 static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
-- 
2.51.0


