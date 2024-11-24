Return-Path: <stable+bounces-94782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE479D6FDB
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF975B24705
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 12:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102221C07F1;
	Sun, 24 Nov 2024 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSkK98gv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE36B1C07DD;
	Sun, 24 Nov 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452388; cv=none; b=qKq9HNT0SG6EM//k9LjD7bZzyZE1ts0rW6asypF5l7P2y+WebRkAvBZ3jb1WGwgRmMoBsq2EdvorFjDnMbq6iV4dOdP5ljXyrNMT5Oud84MjRBI7rEtNH8yGg7jeIxh8Q8IRrACyMjiSEHio0rW8Kjw2ZvtA255idpG9ns5EizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452388; c=relaxed/simple;
	bh=Wl5bXFmQtF7SQ2tzqRaZpOWv1XiK8C4Y/d0nvQmMmvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDpHYVmRyEmXuQQS50LBY+N39j9sYzVQNST6BCXgL2l3Mb/MczmHea/LesVZHvbMv5bwTtIUXejzCLF47V3x5vumzo9OiSwtShzLGzz29w/IJAUMQmXwpQ0qbVcCyebcz0FJjA4jNdCvYBao+uVNqUr3dqEujt/UmIdLl2j3Faw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSkK98gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC863C4CED1;
	Sun, 24 Nov 2024 12:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452388;
	bh=Wl5bXFmQtF7SQ2tzqRaZpOWv1XiK8C4Y/d0nvQmMmvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tSkK98gv9IURZCnqieOt0gSKndPGJNMhuKIuHPqBxPogdP154X6L4xkI85rMI1NcA
	 xSCrxnT3QXyCiDdnBLsWnDlmLrFZiB7r61z3BQgrK22CNLGjjgX8eho55mQtY6ee4d
	 i+pTUMjkLVS4I9ivFK3ygoYnNzgSQ6Gy7nXChWf2f33m4IokBPkRnjBAgDEQ5ZnhO4
	 IaCv5gpijLiIkeZYtdXoiY2/mo/aKh3ZLBwE0uaYzzsz3jMbHGEt7uRKcb67IhKWbQ
	 YEk+mSX8uWkAOYQOGvjkqhw/hXoRTKDRJtsyom6++AmXYcAtDrKvcGQ2VPxjqwgDs+
	 JEbGorJKDYG0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sandipan Das <sandipan.das@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 2/5] perf/x86/amd: Warn only on new bits set
Date: Sun, 24 Nov 2024 07:46:14 -0500
Message-ID: <20241124124623.3337983-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124623.3337983-1-sashal@kernel.org>
References: <20241124124623.3337983-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit de20037e1b3c2f2ca97b8c12b8c7bca8abd509a7 ]

Warning at every leaking bits can cause a flood of message, triggering
various stall-warning mechanisms to fire, including CSD locks, which
makes the machine to be unusable.

Track the bits that are being leaked, and only warn when a new bit is
set.

That said, this patch will help with the following issues:

1) It will tell us which bits are being set, so, it is easy to
   communicate it back to vendor, and to do a root-cause analyzes.

2) It avoid the machine to be unusable, because, worst case
   scenario, the user gets less than 60 WARNs (one per unhandled bit).

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lkml.kernel.org/r/20241001141020.2620361-1-leitao@debian.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 920e3a640cadd..b4a1a2576510e 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -943,11 +943,12 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
 static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	static atomic64_t status_warned = ATOMIC64_INIT(0);
+	u64 reserved, status, mask, new_bits, prev_bits;
 	struct perf_sample_data data;
 	struct hw_perf_event *hwc;
 	struct perf_event *event;
 	int handled = 0, idx;
-	u64 reserved, status, mask;
 	bool pmu_enabled;
 
 	/*
@@ -1012,7 +1013,12 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	 * the corresponding PMCs are expected to be inactive according to the
 	 * active_mask
 	 */
-	WARN_ON(status > 0);
+	if (status > 0) {
+		prev_bits = atomic64_fetch_or(status, &status_warned);
+		// A new bit was set for the very first time.
+		new_bits = status & ~prev_bits;
+		WARN(new_bits, "New overflows for inactive PMCs: %llx\n", new_bits);
+	}
 
 	/* Clear overflow and freeze bits */
 	amd_pmu_ack_global_status(~status);
-- 
2.43.0


