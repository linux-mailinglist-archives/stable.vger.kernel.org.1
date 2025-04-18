Return-Path: <stable+bounces-134621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6CEA93B37
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 18:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E124019E0C2F
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A38421480A;
	Fri, 18 Apr 2025 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJJ2Vy8j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489252CCC0;
	Fri, 18 Apr 2025 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994771; cv=none; b=jmDAb1HTlw3qVY097OQuYlwnmad2cLDaIYOwo5DVmVJonb4PEv9diDWk6m3V8e5kpIwcTT1SGy+r9RTWoTi6VhfhWF6DWmISuEG+4rZL+0o79f1M8CrPpA5M6um3ceSkjY0ws8TXCMxYseJ9IKTZV/GCwv7XnG+hW1s7XiEBThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994771; c=relaxed/simple;
	bh=yhXb463cFleWjagVldQcGB7V6/PW5Ec2PYCoemAhMa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhIiMuXbU3/S3mbxnsGXFFHEV8Qrurnsp1SIX2js3mgd5s1Z1koPArooNFwFgu41c2RM5s2FPgfU2liMqLH9sg42iH5QdSRP6vikr2LiJKqI9JgRPsV7lzrXfzkHblZJGFloAl97mEo/fI2weX6wSNw7Tcx7q9+Fmwn/LLBBTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJJ2Vy8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84118C4CEED;
	Fri, 18 Apr 2025 16:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744994771;
	bh=yhXb463cFleWjagVldQcGB7V6/PW5Ec2PYCoemAhMa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJJ2Vy8j2c8gDC6RNq2SggxyzlxeS7AuBAWzWsyRNGUVCsVikirYDq0Yh2CIJavi0
	 Q3jMhnQTvCXC3fDLy2yN5fDfS9DiFVZjcfN7An7QWE+fLIg98lLixd6cc4zbXx7bwH
	 8lv2uG+Y3rko6Y5KushARBL48SYfh3xF3vn0NiCo21dPb97UmcyAkUNsbr2Q7TlARs
	 5sbDXG+030ougmn0v914Ti5FgZKxZVLSpRwnpKU0vTUObnMDYCuwCcnQRFTxvRdHKs
	 YJ+lor8cyL5jIt6ZFZiZSPS7OrmB7/U6SHyKlbvfTI6EbRRCFsas+xmNtNvUw1MjAc
	 B/Kk6S1/M6jWQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Geliang Tang <geliang@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y 2/3] mptcp: only inc MPJoinAckHMacFailure for HMAC failures
Date: Fri, 18 Apr 2025 18:45:59 +0200
Message-ID: <20250418164556.3926588-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250418164556.3926588-5-matttbe@kernel.org>
References: <20250418164556.3926588-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=matttbe@kernel.org; h=from:subject; bh=yhXb463cFleWjagVldQcGB7V6/PW5Ec2PYCoemAhMa0=; b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBoAoHFK8p1WO0yTZaHnvLJ7eMof6gtV2G0ngwWj z+aYcsWABeJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaAKBxQAKCRD2t4JPQmmg cyM7D/9c60LRbta3hThQ0z3N/YGzHxN4D4C1l9AoB+i23tGKMCpmbfsF87/i5GYFJumiyC81kq1 +LyC/DNpL/+WNHZwboi69NwdcFKj6uk5UA2B2szgzbid1jv0fJ2wY7N+Xk8theN4/LwmhTk5gsa WHahKJ2syAOZspBlld1nUf/kACiEjNhAkqFIQTowlakaqM2rCIYfjhoWybQwg8j2OAvtGpztaaM EkNfoQn6U8iXSeCQfxs73vHtno3Te2dDVM2YZgFRMmwnY9IYQLBeaCIxl4ccIeG8l/LKrE/CANo mZ9Bi06hjV1Kvhp6NG43Za5Bxp48vRdwdAzeDNlzcaOgV7TGsLoDf7+0ti1yrBTDxVs8yxB72cL LChUvUiP+RgX42QJAChpz+q1bUF9SFcJV1yK4OUByheApq4fJsmTLZW7Eg13vzNWZPeRPwVi0rE I5U738WS0v0zAYzxAdMceNZEz9UpFcP4rO8pH9GAYkocBmOpqogu9c/y7Lt902sTJsAHRtbwkve 3kZ84xDdS7QsDyBHf3d2XWEQ1p7CHjuZs0BlxmQDS2+8+KC+iXG+N2HKcMLM69hhH8yQ9jwLBmH Rf+ABnLnuoq3QHpuLOL8Kekn1Bs6ez32ALVzdpMHKv+oxeIukN58TjskxTxl1mRafaxNvT/z0W8 sGWnvD7D+MFKy0w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 21c02e8272bc95ba0dd44943665c669029b42760 upstream.

Recently, during a debugging session using local MPTCP connections, I
noticed MPJoinAckHMacFailure was not zero on the server side. The
counter was in fact incremented when the PM rejected new subflows,
because the 'subflow' limit was reached.

The fix is easy, simply dissociating the two cases: only the HMAC
validation check should increase MPTCP_MIB_JOINACKMAC counter.

Fixes: 4cf8b7e48a09 ("subflow: introduce and use mptcp_can_accept_new_subflow()")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250407-net-mptcp-hmac-failure-mib-v1-1-3c9ecd0a3a50@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ No conflicts, but subflow_add_reset_reason() is not needed is this
 version: the related feature is not supported in this version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5403292d4473..9a8d0d877bd1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -631,12 +631,14 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			if (!owner)
 				goto dispose_child;
 
-			if (!subflow_hmac_valid(req, &mp_opt) ||
-			    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
+			if (!subflow_hmac_valid(req, &mp_opt)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
 				goto dispose_child;
 			}
 
+			if (!mptcp_can_accept_new_subflow(owner))
+				goto dispose_child;
+
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;
 			ctx->conn = (struct sock *)owner;
-- 
2.48.1


