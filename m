Return-Path: <stable+bounces-191407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B619DC137CE
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 09:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89181A6125E
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 08:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7422D8DB0;
	Tue, 28 Oct 2025 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQJH0qsQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19782D8782;
	Tue, 28 Oct 2025 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639437; cv=none; b=JYw5vnSyfMwdE0eEu144yV7NFLcFoQFtLd8kBrILRU6Kl8kpiIOvpRgsSEsjci9oodBlCSnE4CJ7faonoDN3Fbd53jDCKHZrMv2CLJHCYdKmFg1H2eCkKeBlmu2ybl4q8OTubAKxsECCBBBYHTuSrWgR011Axa1maTzhPr8S7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639437; c=relaxed/simple;
	bh=6WX9H7zmpRjzBOI6W8cx5XIfmf0YPXzBr0NE/lefUIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsM/cmHCUZPH9fxqViPEgNSxQ2C41PiLOPUW5q5iMXzTghLz6UXh/vPcnjGWociUQ5mCXAcPernuDcBvQ33UNNhI0QxK+SdsHp2lN7Cl9AElg255tpG716UgPBKkm+Yd12MiooRadwkKNylX4FtIf7SGiAH1NCa04BmCLJTyJ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQJH0qsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345F9C4CEFF;
	Tue, 28 Oct 2025 08:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761639436;
	bh=6WX9H7zmpRjzBOI6W8cx5XIfmf0YPXzBr0NE/lefUIw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YQJH0qsQL5fRwGUltP4F8V72aXhYxQQ9gVvL/M5P4SwJrEw/wjykKQKdoOUy6/hKk
	 r4UPaKQrPlUINvUBYUW1IKeLYtXjQ+gpEEzhVgKwdLpNg185HIgV8J5PT+VM+6wCi6
	 TPHjXOUztzpuMfqnluc1BX41QfcIkX3vqNkgTNUtRU+oI9GLEj2RS/BoEwN1kBHCD2
	 4RUI0ODQIV84Mgf3lD+P+rZQdBiED5xJbHi8tffZUcRgLCVDnHsbPJ+XgTXrcdcHC4
	 1SQeXnYvBevA72Jv0hnq4gfRwvZFeCsn9nAMQPJljFAQwGwM7s0+q2dnuAyJm5nuxF
	 2n5jIpzo3i7gg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 28 Oct 2025 09:16:52 +0100
Subject: [PATCH net 1/4] mptcp: drop bogus optimization in
 __mptcp_check_push()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-net-mptcp-send-timeout-v1-1-38ffff5a9ec8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3245; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7rTrdQHtWaPR0qGO7RKvJQSHNRBIJiHXQUd/rXv6dMg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIZahh2+VqeW2oZs+fW2oIDnuEtHxKc7b/oyT6Yt1jQm
 GXyfu8THaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABM52srIsOZheyzPlLs6v01L
 ls7Y32gy856JrPSrk1M/HgoNLf/DtJjhf9ak3969+X9i7k8zP2hWmPLucetqHde9Oqd0LBaHftG
 azQEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

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
---
 net/mptcp/protocol.c | 11 ++++-------
 net/mptcp/protocol.h |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0292162a14ee..bf2c9e4f3ba9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -998,7 +998,7 @@ static void __mptcp_clean_una(struct sock *sk)
 			if (WARN_ON_ONCE(!msk->recovery))
 				break;
 
-			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+			msk->first_pending = mptcp_send_next(sk);
 		}
 
 		dfrag_clear(sk, dfrag);
@@ -1543,7 +1543,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		msk->first_pending = mptcp_send_next(sk);
 
 		if (msk->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
@@ -1903,7 +1903,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			get_page(dfrag->page);
 			list_add_tail(&dfrag->list, &msk->rtx_queue);
 			if (!msk->first_pending)
-				WRITE_ONCE(msk->first_pending, dfrag);
+				msk->first_pending = dfrag;
 		}
 		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d\n", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
@@ -2874,7 +2874,7 @@ static void __mptcp_clear_xmit(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
 
-	WRITE_ONCE(msk->first_pending, NULL);
+	msk->first_pending = NULL;
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list)
 		dfrag_clear(sk, dfrag);
 }
@@ -3414,9 +3414,6 @@ void __mptcp_data_acked(struct sock *sk)
 
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

-- 
2.51.0


