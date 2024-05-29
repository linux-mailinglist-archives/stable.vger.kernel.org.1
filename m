Return-Path: <stable+bounces-47627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FBB8D33DA
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 12:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADE21F22D18
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C1017921D;
	Wed, 29 May 2024 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUl7jxpu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4B15B14A;
	Wed, 29 May 2024 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976832; cv=none; b=aRdz/A11/u9UwJKSuhuFh0IJJ0f46miVtGJuaCx4UxgKY5cz/VEDHXrSRL3GxjQvptBi9blK5CFX+N+fSPBzR4KWxdr7l6+J1WIN6AVk0hdvwNW1aEqXsi4nFtoUQjj0badPhI0v6uv0adUJjZB3w2SH9adyFV4wmTthyogGOA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976832; c=relaxed/simple;
	bh=Rk9gBOSB9qQ7GfZ8l4CL9mV8J2UVvSan3Wcb93C07+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTlGntRaw3ANuP3DxNBbwlRaSjjGLXK0GM51DhdHmotS91fNjXldJTuUOUNdDMCI2yB/SiqrdXG4Q1IHf/XBsHlw8GCt1PQ/G4M2FuWcWpwRjR288awDLxuryLhMOyIvdCd1WICpBM7HTzXgPOlwNCtYvQmSDCyWWgCItbE88Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUl7jxpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21F0C32786;
	Wed, 29 May 2024 10:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976831;
	bh=Rk9gBOSB9qQ7GfZ8l4CL9mV8J2UVvSan3Wcb93C07+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jUl7jxpus2u1urqdyquSPSNLUsec8J3hO9FfYaL/wC7zH4qn4Qce8lLlsV45Z2eiu
	 CrA1dJDHPLvzES39fE5Q7kUvu3J4yoz9evCoFwWOdglYIuX4sMVVLYGGKdZrZ+Hn0r
	 ZurWKmsLRPa6X5IygIgherz8x4jFECn+s61DzPS0eV+7HVa1MPSGhzDGuxbua6HvHa
	 nUquTM6tDidMhzCmNLb/4eNezUMSmyHNN+s+eCUaT7w4wp3rmvG2XjrcB1Ub6dsloS
	 cXjS3z2+X63Ldcg1JvCtI9ZNyDeqpmJftgxDwcwYmQ8aFSty4GPV5zDeXhpg65eztR
	 avmxCmWnGSA+g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.1.y 1/3] mptcp: avoid some duplicate code in socket option handling
Date: Wed, 29 May 2024 12:00:24 +0200
Message-ID: <20240529100022.3373664-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529100022.3373664-5-matttbe@kernel.org>
References: <20240529100022.3373664-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=matttbe@kernel.org; h=from:subject; bh=eIbNr3+rvmmo94rZ8rIGWyjauvCrVEBoRbXK75Y7ADc=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVvy29kgTEuVqS6b2K88/X8mkkMQCOSihYjVqB yjlQrlMWf6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlb8tgAKCRD2t4JPQmmg c8kBD/0UUbcNuUkBf9a3tsk5WAetXuB6illSqW0ntuHhTUZrWwXGhdtfOlZ7KtCGRXCepGoMsE1 CTcGZo/lzR5zgCf+sCsW2OvjyDYZhe0alLhyC7lizDtYICsy838vQg4yv2u11CXik1gb8gTIUfE 8G1F5L693EZ4BuEewoLT2TET4f7otDul7cRSrjQXbH35MkRXDf/t+ddPNYu6Ggek/VEswafc++e iKW4TZiND2ioeyOfQ+knL+iQSJOAz/H6bz/rMI5w7CMync1Xz8z1KOmuRZU+IvYVc8e2KxwUwfF LYmWhUzZCt0yiM+0/cS6IwZsKgV6lH6Fly4gGCwgjd4l3OI/H4MaPiS8PU8fEGLn136iJ2ICpKA GbpkfuZtPfdoceFkpb+XkkBEVd9ut77A9ycbnXr2qAr0Cj2DiMfsl1gIR3AdBlgVEejeyrYuOex DMfBr7LVHqkN/75YdjjyJCE7Cohmx4K7jjct0gYjgtPIqpGBeAnw41WlZUxfyCooi72XeBCMHh4 2h+tm9Xn3GrPTvYWNAYK8sdfI027tDgSkpesCQGC8Yfpa1zrZ6bUGPTjV07EtkNakpd8GCaTaFZ rjvm4qXcoPI3UKnUTJuR3hjg2He44zb1WtpjxbUM+puSCVu6ewmf4FYIhWfRHap/2ZAS2nm4ALO OVUq/2WACr/+L2Q==
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
index e59e46e07b5c..c3967486ce69 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -621,13 +621,11 @@ static int mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, sockptr_t optva
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
@@ -651,13 +649,11 @@ static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t op
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


