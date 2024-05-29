Return-Path: <stable+bounces-47624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582828D33D4
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 11:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBCA41F25691
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 09:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AD016E89B;
	Wed, 29 May 2024 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c92HAsCi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DD616E89A;
	Wed, 29 May 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976715; cv=none; b=Mr2SytATj1hO16klkn6qIgoj6To7v5t6cBZLAlgGCJAe0XFqmJQtwtElvOpdszsF/dVAB/mnfhO9wBzjzN+CSyWPcUQk8H57ZW9oKNN8YxJtGj7f+YviH70xJ5C/RONqOupmMlX1JxCJajAr0OQQqzVfTwPvrGiCgyV4qp1jm6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976715; c=relaxed/simple;
	bh=pKYcz1uLT3WVF+Y1ZRMN8WSZGKcnNVn92Lf18YP6QZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFXIDOfa8b8ygdV8XT4dvjwiHyiGCmkEBYHZFVk5w02k6EzdfHRIXv4JP8TM0EzqCQ2CWTbhbANFsDnzlTIjLzLrp1UnwQmDENICkDEL6SrhnRBUGQq7ij0ljYtfDhhpXXaSuMeO7/MM7ggzSaj8NmGZPD4uttdZg12IOz3qMEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c92HAsCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A01C2BD10;
	Wed, 29 May 2024 09:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976714;
	bh=pKYcz1uLT3WVF+Y1ZRMN8WSZGKcnNVn92Lf18YP6QZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c92HAsCiq8Z98T9fnBxV1PU8KoB11zli4TwpgatOAH4NBRuu1A5JtzbXdcDR7Rhc1
	 o4rwTYCqbghn9IxuNANQEw1U5E4OL5/el+cQ+1AkdN+kSEPLaH46mdCC3hva6Z0Jtf
	 KgnrbsQseNrbr9wkF+Yt7VAGfuz8i/a/18X7ok/uH2uI7OYVXaN4nQMbDH85KJMULM
	 70EHhfiJa0Mkl8vvqqjnMEPNQ9Heivt9Ahzu0xYFS3w0f50R9sSWnT7ZvijjHU07r+
	 gUx74Bql0SDK7dJE2LltTGk9eYkydsH/pW3vGwBERKnJMJfK1HfyrVeZLoCzDqYuW2
	 GePahqtq3GQLg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.6.y 2/3] mptcp: cleanup SOL_TCP handling
Date: Wed, 29 May 2024 11:58:20 +0200
Message-ID: <20240529095817.3370953-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529095817.3370953-5-matttbe@kernel.org>
References: <20240529095817.3370953-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4141; i=matttbe@kernel.org; h=from:subject; bh=+XMlOTRgrnNIpJd1C3XW84vhK+avpbvvPETRda1fqVc=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVvw51jJLL3dU026AB06Wo2GIJ75tRnrpEbV2u eVOkWXDmcKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlb8OQAKCRD2t4JPQmmg c6GzD/9SKmmHR5dTM2lBfrCpzrlZTsP1SXmeRoAMn5RIR1WkDKaauIbIvEelAOgTj/XFIWAyJti 6tRVlrDHBGV+Np/FymA74pb0im4ZzmeTIOnbyvR9XntjqfejrJnIs5dpvy1FHzGpjVfY17gTmGp OsTWdnX8oDOsV7kxtgFsV0f8JKBJBvtLDZEVHc+34kkyA7J39J/Hm+em7HVJpB8kFQbvW5NsZMj m3+JxXpYL1LzTytxaNkMfas+ksd851ar21qbLcW508buwAiIZOu4mmhcGd1fNZJeNB8yDu4AQGg qAQDEyLtzL04Jxf4OFNpfNS8thB8M/ckMvsZsBiBJJDAh8vD/jS7EQiiCNey6a4xyeuPGGSr//5 XEU6PHZGFuXGT9xu1j/C43RrL1nEiNOtHA5T1L8bMCgRNgeWmm0dcg+syctY9WDkVXit25s/ea0 0eiFHZGwAqdQoQLsKGxnVZ58lKANm/2ZHSr/wZOReLE/8moNLt4QF6Ei6FOCNW0VIg34IlN/dyB opeOL0+M1vw6e98pMhuBPQ6b3TgGn1rFWib8MFeKNqRa8ZYW/iJqjzGTjolXoQi6Jx9TotNAv9l loQND7yxh+7slkAdufyIQC9slBRg4oviIWYAt853QckjsFL4zoFQQdha66hNAl1lP7A9QgePQ9V Sru58Vj/tfxzLWw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 7f71a337b5152ea0e7bef408d1af53778a919316 upstream.

Most TCP-level socket options get an integer from user space, and
set the corresponding field under the msk-level socket lock.

Reduce the code duplication moving such operations in the common code.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: bd11dc4fb969 ("mptcp: fix full TCP keep-alive support")
[ Without TCP_NOTSENT_LOWAT support, as it is not in this version, see
  commit 29b5e5ef8739 ("mptcp: implement TCP_NOTSENT_LOWAT support") ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 61 +++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index f29949efd7a3..e33d721ed37e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -621,18 +621,11 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
-static int mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, sockptr_t optval,
-					 unsigned int optlen)
+static int __mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, int val)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val, ret;
 
-	ret = mptcp_get_int_option(msk, optval, optlen, &val);
-	if (ret)
-		return ret;
-
-	lock_sock(sk);
 	sockopt_seq_inc(msk);
 	msk->cork = !!val;
 	mptcp_for_each_subflow(msk, subflow) {
@@ -644,23 +637,15 @@ static int mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, sockptr_t optva
 	}
 	if (!val)
 		mptcp_check_and_set_pending(sk);
-	release_sock(sk);
 
 	return 0;
 }
 
-static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t optval,
-					    unsigned int optlen)
+static int __mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, int val)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val, ret;
 
-	ret = mptcp_get_int_option(msk, optval, optlen, &val);
-	if (ret)
-		return ret;
-
-	lock_sock(sk);
 	sockopt_seq_inc(msk);
 	msk->nodelay = !!val;
 	mptcp_for_each_subflow(msk, subflow) {
@@ -672,8 +657,6 @@ static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t op
 	}
 	if (val)
 		mptcp_check_and_set_pending(sk);
-	release_sock(sk);
-
 	return 0;
 }
 
@@ -786,25 +769,10 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	int ret, val;
 
 	switch (optname) {
-	case TCP_INQ:
-		ret = mptcp_get_int_option(msk, optval, optlen, &val);
-		if (ret)
-			return ret;
-		if (val < 0 || val > 1)
-			return -EINVAL;
-
-		lock_sock(sk);
-		msk->recvmsg_inq = !!val;
-		release_sock(sk);
-		return 0;
 	case TCP_ULP:
 		return -EOPNOTSUPP;
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
-	case TCP_CORK:
-		return mptcp_setsockopt_sol_tcp_cork(msk, optval, optlen);
-	case TCP_NODELAY:
-		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
 		/* See tcp.c: TCP_DEFER_ACCEPT does not fail */
 		mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname, optval, optlen);
@@ -817,7 +785,30 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 						      optval, optlen);
 	}
 
-	return -EOPNOTSUPP;
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	switch (optname) {
+	case TCP_INQ:
+		if (val < 0 || val > 1)
+			ret = -EINVAL;
+		else
+			msk->recvmsg_inq = !!val;
+		break;
+	case TCP_CORK:
+		ret = __mptcp_setsockopt_sol_tcp_cork(msk, val);
+		break;
+	case TCP_NODELAY:
+		ret = __mptcp_setsockopt_sol_tcp_nodelay(msk, val);
+		break;
+	default:
+		ret = -ENOPROTOOPT;
+	}
+
+	release_sock(sk);
+	return ret;
 }
 
 int mptcp_setsockopt(struct sock *sk, int level, int optname,
-- 
2.43.0


