Return-Path: <stable+bounces-94787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E7E9D6F1B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D2A162334
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9DA1E25EC;
	Sun, 24 Nov 2024 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEtqozV/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE41E25E3;
	Sun, 24 Nov 2024 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452408; cv=none; b=eXg8k+bZiQPa5bnUZzFWYVWJRbnar5jMfjZ7j8HPQ2x86SWHzdf0zNSWt2/uh0XoAU/4oSGqOR3Fo/7mGDEcdJAZja5rWHsrhxe9A2nIbNLMGz6n+7qgi2ypj6E73q+bV/RBGJox/SDDEGe/YGYazhZ2bcxmNR06hfqoAvj/6W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452408; c=relaxed/simple;
	bh=Wl5bXFmQtF7SQ2tzqRaZpOWv1XiK8C4Y/d0nvQmMmvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TesWEqELnEQU2GBHkRSXVe+5VD8ViuXDogKzMSiWlYOOWNs6N7wLNZZJWDqM0cMMznPKm+ikormcBxbmE8mvu+ELY9T0gSEL1dEm0t6wSySyxD41pWSHUcuqAuiSLLOEdzaiWI4TDojSJlbHOeloL2yNg66rCPsaw9iVMqUe4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEtqozV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F5FC4CECC;
	Sun, 24 Nov 2024 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452408;
	bh=Wl5bXFmQtF7SQ2tzqRaZpOWv1XiK8C4Y/d0nvQmMmvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qEtqozV/J0UhKp0bfKexBZf5RrKOmTTPJ01QzcIEVohR8LWVlEi4GQ3mgwuA3Zwvq
	 I7kKeFkuS9/kzR3mnN/WQXS5iEBiHlCA/U68dy9BuZDdR7fTLLtUlozGzFAtgZDnmq
	 yq0uhr0prcwn/LSPJe3zW/299PktAN20tttUe89BB45qhV00aoV8271b29z1YROBVR
	 uQ03ZNjUe3RwGUH/gQ6fmBsDpRpf2s/Ve6QqiHSuvDpamN12we6DLin6FBO6SZmLup
	 IoVzCFq5WRqyKHLhqU6rvxE1SYm+Ze5DJYpaFXQCAVvDfWats7TzFCjl/XYUhBSVpI
	 +lcm5IGbbbyDA==
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
Subject: [PATCH AUTOSEL 6.11 2/5] perf/x86/amd: Warn only on new bits set
Date: Sun, 24 Nov 2024 07:46:35 -0500
Message-ID: <20241124124643.3338173-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124643.3338173-1-sashal@kernel.org>
References: <20241124124643.3338173-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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


