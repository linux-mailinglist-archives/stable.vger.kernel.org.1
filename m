Return-Path: <stable+bounces-163703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5F9B0D9BE
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE5D17DCF9
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B0D23ED75;
	Tue, 22 Jul 2025 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHmkD+aB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273315DBC1
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187679; cv=none; b=RgMQXQ2OPXCLupz3H+hjhEKGaJr6bEZmwADoUZBo12spg07kqXmRi779XQ2HQyl8af9KfVdWQmXgSSWA8K4yZQST8NoUbAs/SYLeKlFajBmD2Fzb3JkwSmmyq4+e1NTb4ayXYtKBwbxgNwR29qG6R7LdzQttDoY6eOH1e51/pbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187679; c=relaxed/simple;
	bh=dMncRNs98C7qUkKbCgNx9rq/+qQTcvUIG+Zk7ZmUC+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mm0MLJaFqkDFSeKpBaxqFp+ePi00jglQaf/7ccTTiyc3MIbGohHFHVHNXk4VySwDikLGMl3tvZISKEf/Q6F+47VHvbZwavklKbX7oJ1MFMYXe23pIEzl2u597sSfEtnCKODZGVj4nQ334XpnoM5Kf17FeFnqtUFY+WRN56aBvhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHmkD+aB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AC9C4CEEB;
	Tue, 22 Jul 2025 12:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753187679;
	bh=dMncRNs98C7qUkKbCgNx9rq/+qQTcvUIG+Zk7ZmUC+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHmkD+aB+32lFzWe4blZyEcKSC2zGnZTWxuvx2Y4fgNtZP0Zkm0Y3jIA2rQ0mJL7R
	 ZN/yTEXlsAynTyoUSKMfarsPKvfufvnA4WaHrSVrp7KUwA3Fl0RXugm3UGwRlnT9LJ
	 tYnwd4onCmA+tg2MA+ckosuB1/r5NOiPYcWY1chHXqCVmngCMAeQy5u4a1NOruNBw+
	 8wsbRblSVSrvsG2S09B4ha/gG5R2Hz/MV4ycg9Ahs1ajKWk/8frkNcomEXcMaJjwyW
	 ePamXYrKjgvrBY35Hr7Wljk/YH+U0keY2jcSO8Y06S2GCQtknAqV2TlRJ0QyQcB0ju
	 QR/ihOq0UpE6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y] sched/ext: Prevent update_locked_rq() calls with NULL rq
Date: Tue, 22 Jul 2025 08:34:32 -0400
Message-Id: <20250722123432.934988-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072133-babble-buddhist-9fbe@gregkh>
References: <2025072133-babble-buddhist-9fbe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit e14fd98c6d66cb76694b12c05768e4f9e8c95664 ]

Avoid invoking update_locked_rq() when the runqueue (rq) pointer is NULL
in the SCX_CALL_OP and SCX_CALL_OP_RET macros.

Previously, calling update_locked_rq(NULL) with preemption enabled could
trigger the following warning:

    BUG: using __this_cpu_write() in preemptible [00000000]

This happens because __this_cpu_write() is unsafe to use in preemptible
context.

rq is NULL when an ops invoked from an unlocked context. In such cases, we
don't need to store any rq, since the value should already be NULL
(unlocked). Ensure that update_locked_rq() is only called when rq is
non-NULL, preventing calling __this_cpu_write() on preemptible context.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Fixes: 18853ba782bef ("sched_ext: Track currently locked rq")
Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org # v6.15
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 86ce43fa36693..bb5148c87750e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1149,7 +1149,8 @@ static inline struct rq *scx_locked_rq(void)
 
 #define SCX_CALL_OP(mask, op, rq, args...)					\
 do {										\
-	update_locked_rq(rq);							\
+	if (rq)									\
+		update_locked_rq(rq);						\
 	if (mask) {								\
 		scx_kf_allow(mask);						\
 		scx_ops.op(args);						\
@@ -1157,14 +1158,16 @@ do {										\
 	} else {								\
 		scx_ops.op(args);						\
 	}									\
-	update_locked_rq(NULL);							\
+	if (rq)									\
+		update_locked_rq(NULL);						\
 } while (0)
 
 #define SCX_CALL_OP_RET(mask, op, rq, args...)					\
 ({										\
 	__typeof__(scx_ops.op(args)) __ret;					\
 										\
-	update_locked_rq(rq);							\
+	if (rq)									\
+		update_locked_rq(rq);						\
 	if (mask) {								\
 		scx_kf_allow(mask);						\
 		__ret = scx_ops.op(args);					\
@@ -1172,7 +1175,8 @@ do {										\
 	} else {								\
 		__ret = scx_ops.op(args);					\
 	}									\
-	update_locked_rq(NULL);							\
+	if (rq)									\
+		update_locked_rq(NULL);						\
 	__ret;									\
 })
 
-- 
2.39.5


