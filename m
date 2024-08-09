Return-Path: <stable+bounces-66128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EEE94CCE5
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 11:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CDADB20E7F
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 09:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF9318F2F2;
	Fri,  9 Aug 2024 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC9cpJnx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB5BBA41;
	Fri,  9 Aug 2024 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194374; cv=none; b=mrIKYfyUcoaHnRqNC5QDbuiRhtLicWQKs1q8d3wxhvcKKjHFfoklOqkr3r+9LiU2EpfPfyVMG9+yQdk2wvC5NeeO9Zb5iUQXz/FdmGyTo7WSD2bjXQnqmJQ7q1Sk6I7p3MVYUr75k36dEC2gRWNNydhyS+5UVihwbkJ5IeBZ8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194374; c=relaxed/simple;
	bh=MXX+S2D5WZYgeAmB3lPTZdUuNilF4+TQWzYDy9Dpg0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8h9tyRuX3KNAITprd/FWAWvuVgoBWsK/Kz7DvPiXCRriFYDJBOIk94AMAvVlU1CJgbiTkujLmOYYC0gCuIQ2CT77GVzfgZyPUuTmXSL5zQoreuQc+JLe29MFD8Z1e/W3yZltdODegf3UoUxXyv4QTIvjoFbYgsmR7IWxyhGl4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC9cpJnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994B3C32782;
	Fri,  9 Aug 2024 09:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723194374;
	bh=MXX+S2D5WZYgeAmB3lPTZdUuNilF4+TQWzYDy9Dpg0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BC9cpJnxhA8nIOShZMbwIfAY/9JXPNuDJ/4cAySy+57ss2ZuCyy0/r9BYnGUQEToz
	 gYpZidDKqtzspw7TDgdnG3MnBvR5UofGtssHtDSWqlCy6ACeodpwy4Iew2e/FNmBSK
	 7NhReKbhCpXhgF4bzXpFflQt0SoV48QSGJqVayYcgnPUGNDpDp/gFxcIaT4A3Panwq
	 oP5TyBMGTfYdnmfnpNkR7l555s3BlNG0h+I6sKH4WjvwmPnvLRAcFlQ4nSsmCbHhDM
	 d6O70oWvR9VNFywN0TP4T/KguJe7c43iAiw0HnGVR9qvYUyORk/pFIFl586c+GLUy4
	 YONXRYQKKrSUw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] mptcp: distinguish rcv vs sent backup flag in requests
Date: Fri,  9 Aug 2024 11:06:08 +0200
Message-ID: <20240809090607.2697543-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080750-sesame-overfull-bbb7@gregkh>
References: <2024080750-sesame-overfull-bbb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2766; i=matttbe@kernel.org; h=from:subject; bh=MXX+S2D5WZYgeAmB3lPTZdUuNilF4+TQWzYDy9Dpg0w=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtdv/c6TWwBxPJ07gmi+mCcWpTsDPEQFvpFixO ccnjy3d9YeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrXb/wAKCRD2t4JPQmmg c613EACcy5SS9B3FNyfTyJZgwtzT2xoEAv6hmPy48P/+t9FhSAFV7lU1BuFYB/SefhTYKRAUMq6 CVuxGWhx7zWCDHZG04Bmtyanyc6IITTmBdhNY+GmDnpkpgXORhFYmQ2SKYPgtam8kKQHHZoxCkB dKGEaJ/4UX9i5XFV4NP47Yppv5l6b0xLOJWLsHLcbSeOhvafvQjDt4eaChWc92UrBt2S721cRy/ RH17FPhqd2VoT15upPcjZvFYOxLDAk7bjJujr6Rc+s8FQD4G2ai9CAfobpEb0gURSIWagAjqle1 o4HPrt2y3e426/6n85PidAM9ZUOO9SBM+O60V6xhJIjjViwnFEx/a3ybGMHZfzC2N+xLOnY/ahi IBQUxUInpRjTgVOEBDp4oq6I0L7/i/9v10S2QTMlKFktO5MHA9grK6RRjQXxC1E6/ba9NnOQKJ1 SH+IfJwOceNaQKgsFubgCvh23hRFI7/P0d2MIGEzeJ9uKKhTOdjwXfxtdJn6elGc9hwgPWSinzV 0M7TM/f7sc1uBkqKDQBcZYF86zWPaiciLE9DuJnOAC8VD8Z10TVBNDwDfAUSYQC5p9Dj9H2YN/r 6OVYygaRQU5l4O+m9mTr8Alfv2O8VTXd61fXWtFQ4KpRfvXpJjAg2XILIFJX3yQ4AkR68aQPOHy DY5HkbvfgWZa3+w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit efd340bf3d7779a3a8ec954d8ec0fb8a10f24982 upstream.

When sending an MP_JOIN + SYN + ACK, it is possible to mark the subflow
as 'backup' by setting the flag with the same name. Before this patch,
the backup was set if the other peer set it in its MP_JOIN + SYN
request.

It is not correct: the backup flag should be set in the MPJ+SYN+ACK only
if the host asks for it, and not mirroring what was done by the other
peer. It is then required to have a dedicated bit for each direction,
similar to what is done in the subflow context.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in subflow.c, because the context has changed in commit
  4cf86ae84c71 ("mptcp: strict local address ID selection"), and in
  commit 967d3c27127e ("mptcp: fix data races on remote_id"), which are
  not in this version. These commits are unrelated to this
  modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3b4ce8a06f99..4d8f2f6a8f73 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -877,7 +877,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		return true;
 	} else if (subflow_req->mp_join) {
 		opts->suboptions = OPTION_MPTCP_MPJ_SYNACK;
-		opts->backup = subflow_req->backup;
+		opts->backup = subflow_req->request_bkup;
 		opts->join_id = subflow_req->local_id;
 		opts->thmac = subflow_req->thmac;
 		opts->nonce = subflow_req->local_nonce;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b4ccae4f6849..d2e68f5c6288 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -370,6 +370,7 @@ struct mptcp_subflow_request_sock {
 	u16	mp_capable : 1,
 		mp_join : 1,
 		backup : 1,
+		request_bkup : 1,
 		csum_reqd : 1,
 		allow_join_id0 : 1;
 	u8	local_id;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f96363d83e67..2fdc7b1d2f32 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1766,6 +1766,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->mp_join = 1;
 		new_ctx->fully_established = 1;
 		new_ctx->backup = subflow_req->backup;
+		new_ctx->request_bkup = subflow_req->request_bkup;
 		new_ctx->local_id = subflow_req->local_id;
 		new_ctx->remote_id = subflow_req->remote_id;
 		new_ctx->token = subflow_req->token;
-- 
2.45.2


