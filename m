Return-Path: <stable+bounces-47623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC618D33D3
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 11:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2594285200
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 09:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF5116EBFC;
	Wed, 29 May 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lh618Qqz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40916D9D9;
	Wed, 29 May 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976712; cv=none; b=SzLdA5cva9u1o0aK5ZDlnSesZBSoVl+6eyHH6Cy1dpXMWmJmmsW6e7euwcPxqUFf0Y4a2zI1FLHR/aK+eANox1PYjKiLMWXd0QGkXXSKYgYcFs6ecfkzgUAVPmxHCJgA9aYxIrAgalkUEB3sqUyAR8jHbdzFEFoNXZuieVaLgZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976712; c=relaxed/simple;
	bh=7P5R3ubCOeXHLXpUlDHx/dHy0Jv9kZQpceL925EkVzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXw6rSbbfh6U6eWcMEZs+pMaPh0Qz6i+h5zYedgtKb/tq+D2HgH4m1iJnZWaAa2JfA+u7Kc8fMYUR/YoSIjR1Y3fYS6ZHRY/xd2rF+FDh3XvWogmVi3Mtj09sl1ZewKFCWzHANcRsnglEF6SCDsfQ2LRhrLEc/s8qj3mjgMRKu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lh618Qqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E89C32781;
	Wed, 29 May 2024 09:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976711;
	bh=7P5R3ubCOeXHLXpUlDHx/dHy0Jv9kZQpceL925EkVzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lh618Qqz3GkysW4ZY+oXJomzMGzUN2tTe5pGjPZ7QahtEXY+uwSs27wvqKZFSd5eD
	 WC7/JWMc8JjjsP3q7gZOfDThkRwrs5CtTC17JtzHsEp1y+JGtpu2LDWWUq2+Pgu/YF
	 2cqOBZhrpoiKI5PlRmHNiy05qrIaMj93iPyPoP+jIyNVsGRMRu2yZ5U6Ol5DplSCJF
	 VJyq92nVvCiifPuYMgVDpS0ruoECeKUVL40Uov4JgbmID9o2u7AOebcX4lYfFT6Xv5
	 BEoLT3kqkzV6ZbrtTrArAmuZukOPyHso9lu/47Yys7HulIPjn2VmPr+UH1mZ1G8B/K
	 yMX1Z6aq+oPdA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.6.y 1/3] mptcp: avoid some duplicate code in socket option handling
Date: Wed, 29 May 2024 11:58:19 +0200
Message-ID: <20240529095817.3370953-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529095817.3370953-5-matttbe@kernel.org>
References: <20240529095817.3370953-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=matttbe@kernel.org; h=from:subject; bh=YdsRVgmWu00252Q9jth2tk5Jszjf+SVA7ez0qSUcxr4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVvw5IB+qGhftULCeSRroWOoXwWo1RHoE1LUU0 87BCWeamvCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlb8OQAKCRD2t4JPQmmg c+UzD/0f11Obp4/Uu4Xx+pkY7aFaq65HvhQpi3OwVEfD25hfPKvAs9arHsy37AYfHp2OATYFNCk d5TzLY0cjYMoS0X7S7OCghY8cj9cnOB/o2Q+OXwdjMivNmDhf/ImUQqn6za92LfDIh68CTJFcFe JlvexDUgDu2fbQJIQjusTGaYun6Ud7J/Y061qKeoq0pzJaDTQxUbvrCg4SDpZYkBn6maRMmYm9t NPUGpH8VVXu2RtXTnZDSaYZit9R1Otcu+wCnxmALgQZPbjwosYoXqWY+SqPOnYYs7oIM/GWrnGj l4LAdk/Ex9igFy806DQCSlDPgQkz6zHdJq5PlJ3WilJSIglx3juVOhbcohGLldk5khzx3loD5NG badVNgs/MI8K10WAfyaQeK/QFt9ZavsapkxG8/GroiipsSKD5Nxwkgf7NP4wLEYTvXPwqOKF0To p7gNLrXqJ7ASaQG1/UFSuAntTmngipTWkkJxzHIfeYP8lpXY9+TDdoJDZ7l2cQRvWwzKz/zoTOU KtkM4W3NRWMIhIxXrWIyZPZf01UGI7pM6Xk7xD0r6/zn5Gpv0OMbbNyphsoUtcW/i1JxoMd/hoO kZKzJz3KB/C3Xa64mCrciWxigFPrD3d0ZKGbmeARrrW0i+bjkTK/kSB8xWHT4CHxKz5gc/Fhjlz ygccuAImUK+LbSQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit a74762675f700a5473ebe54a671a0788a5b23cc9 upstream.

The mptcp_get_int_option() helper is needless open-coded in a
couple of places, replace the duplicate code with the helper
call.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: bd11dc4fb969 ("mptcp: fix full TCP keep-alive support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1afa8245f27c..f29949efd7a3 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -626,13 +626,11 @@ static int mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, sockptr_t optva
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val;
+	int val, ret;
 
-	if (optlen < sizeof(int))
-		return -EINVAL;
-
-	if (copy_from_sockptr(&val, optval, sizeof(val)))
-		return -EFAULT;
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
 
 	lock_sock(sk);
 	sockopt_seq_inc(msk);
@@ -656,13 +654,11 @@ static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t op
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val;
+	int val, ret;
 
-	if (optlen < sizeof(int))
-		return -EINVAL;
-
-	if (copy_from_sockptr(&val, optval, sizeof(val)))
-		return -EFAULT;
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
 
 	lock_sock(sk);
 	sockopt_seq_inc(msk);
-- 
2.43.0


