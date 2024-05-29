Return-Path: <stable+bounces-47628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E688D33DB
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 12:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05B41C23179
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02271179970;
	Wed, 29 May 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADXF72qs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180C15B14A;
	Wed, 29 May 2024 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976834; cv=none; b=XIQhf6hSHkwKAvUPdvUcr49NVbd1ZGSy3DBMwZX9qW2rsmiIPOFLy7eEZSneQZHjOwPV2VA6ljyHhd8TebJtetfRPSufZAYBJv6Mf9XP+LtkDXd2XsozSumeQIFCvCIuKck1US8/fgaLho2++Q9cSbsFo9t/OTIWVr1N1i0Yqj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976834; c=relaxed/simple;
	bh=P3GGQZ8FeJ9o0UzU++dcb3MV7s7XyEVKCqT6702BOeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWyWsulch3QwOPrCUnOHYvaFjkEjDvdFf1WZnhnD/maKe2oeFUzlR2TL5lL+4kMGntiBnT9yBZGImSVIGFWB46y9Pk1c0qCtERbnE6+aY7Q3stP5ussS6DLB7TFxfDzi73xorVRJM1hVd4NFwLR/tmc5jjflH1KmMVh5rMrVdms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADXF72qs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBF5C32789;
	Wed, 29 May 2024 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976834;
	bh=P3GGQZ8FeJ9o0UzU++dcb3MV7s7XyEVKCqT6702BOeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADXF72qsxr0KEL+qvxYJXBRTSXYnq7zw+6jWKjJ7A48m/e4ZuzAnpIgu3tJJNkdJv
	 M8qimQ3RQDUqjvLkU25gfxawdkuN6DaEo+bGiu7fW6Uw4oEROvLDPgblkrk/J2JV7+
	 SDo4aBJ1QXH254PbP0fk+GdSaKoArBJ4vhe1BlfU8bFaF048du0NVcCSrl+Al2MMU0
	 n8FetvVufHh3HGzHC1hLarMR2S+X1T60okA4FG5mApMo78yLSQwuJsOSi2341tEVoF
	 cPHdHLiJ+LomHV2WSwAmZbZi42sgWJxk8edKeCEV87Hc947jh+TosOUV1jxSkDGSYm
	 8nYVwcNmywrwg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.1.y 2/3] mptcp: cleanup SOL_TCP handling
Date: Wed, 29 May 2024 12:00:25 +0200
Message-ID: <20240529100022.3373664-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529100022.3373664-5-matttbe@kernel.org>
References: <20240529100022.3373664-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4108; i=matttbe@kernel.org; h=from:subject; bh=F2qBAcWKXtJVyJ4F8TA0qu8O2hTBKFZK1nxG+f37xPA=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVvy3jOxhk+GvYM1VZp78S2xT64xVfSLRYPwFX brQ5rra16+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlb8twAKCRD2t4JPQmmg c7l2D/9jWJTdkf70hU7fk3dR9hnsymbYAXsA/4FY2KrKFWUdNP5o4jEz6r16OdR3QAWluu9I6kB 0apTj8naA+XINzeRP+tLsKzTLiokyQkoKx88lYmamWSebx5VNwtlxHcrUrViUkRtw7Rzbq7XFDh CsSLIhOfNTclOBYNxulaZ4lmoF8B/gpE98DUwUIuNmddxZuXz4R1QGQhXy0eUX2Eq/XNbSuuGwM nSPiT3VX8hb8L6NcqmO5p3DF/LoET75Gxzhq/ezk/fPLqmdww4j378m/X9M3iYe7L9Z12aKOkSG eP66csEDKbHYg4NCvMzoOfdxQHpvy1QEH5+7lrEm5uXXUJ2HNGbAaao/T3I5eSbo7/ZUTlFny33 W0rzw2Ytamc9RafpOPQgVTqHEKc7D/lkz/qnLCexIeO7vvmKh/9LYRqIMzAIgsnO5IU/kCkorG1 VqmBxriklZbLFS7g6139k1axcLFdixyhUD/cqIWbvDXjSeVdXate0byKqI9ZdqGLYE+i6+6KtrO 0ngoZ8eCyhDYOE+7lk7Z2NzW39l7B15/e16d9hoNo4tRxCGBm/Vk+kHNvM/t5wJ0m9mc5Zrx9Xc I4IfbJmbG9V6ww9ULF+3+pxb0bTbdrv8htDAF0HnZrJ8R/G2EEBRuwBetLb9HMZ2NU4L/FgHLQK HKrjA3h1ZwAVKjA==
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
index c3967486ce69..7573bbd15f84 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -616,18 +616,11 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
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
@@ -639,23 +632,15 @@ static int mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, sockptr_t optva
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
@@ -667,8 +652,6 @@ static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t op
 	}
 	if (val)
 		mptcp_check_and_set_pending(sk);
-	release_sock(sk);
-
 	return 0;
 }
 
@@ -793,25 +776,10 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
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
 		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
 	case TCP_FASTOPEN_CONNECT:
@@ -819,7 +787,30 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
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


