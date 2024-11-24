Return-Path: <stable+bounces-94792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B639D7073
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B17B2B10A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAEA1E32A7;
	Sun, 24 Nov 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnXVS4ls"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C3A1E285B;
	Sun, 24 Nov 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452427; cv=none; b=Io+8RP1CEWjA6X9ZS17uHWmQvLAwUqGEHA7pVZEIzsLUzn0cfaV0/BfitC6q3Vj8IhCUkq2WFerpt/261jcBu1Llh22PLOnf4VvRdqg5Urf30byDgnU/M41o6kfgh1bWV1wDFZJFdoSudbnv5deW/a59vdpWRzyUXsgg5rlo+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452427; c=relaxed/simple;
	bh=IZlChZK1vQgmN2vfVhq6dY7dAB2VH6AVcGibK5P7KoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p30F85qIzr/ift6lA5rwVfYRRqPpKHETHnyJaTczAMt2u1rUW7AD2AVlQhw1uGL1T131rOaRMGlKw5CMFjeGhjFI25bPDfJq3emh2B0DbJ+3Sn+D5lCdFz9dpQ6uD/OpBQdpGtRJFh7UHBrcDGp5vfG7ZPJ9wN5jsGYUy7eqQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnXVS4ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B12C4CECC;
	Sun, 24 Nov 2024 12:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452427;
	bh=IZlChZK1vQgmN2vfVhq6dY7dAB2VH6AVcGibK5P7KoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pnXVS4lsCu9A4b8Gg/5+wYIKrNbOLiKza29NGSVoytaB3Pp1Q9XgW1EEHHK4PLLr6
	 eqy+55J2VIIX5xFCqm3v0We3Mh0u7uKScsZ+iECtc/IWLGgiPjkFs7iRQOjV/Xei9p
	 4gCzDkfAsAk45nlQfNPT/hPsRCe8js3GYQF/f1F9kbE6FeeqEPUj3Z+FeBtsXDTk78
	 DbsJz/gQufWe8960ZUsWA16ighC8onex4kKLQRfvas7v1/XE+Nxcf66r0EckfUZxaf
	 KwI7Bu01FeQv/yMrUCNL4an88D+44NOzJTYjzCl6NMRqzN0iVZnPy0e69UCm2OaK3J
	 tbEKf6Nf45DOQ==
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
Subject: [PATCH AUTOSEL 6.6 2/4] perf/x86/amd: Warn only on new bits set
Date: Sun, 24 Nov 2024 07:46:56 -0500
Message-ID: <20241124124702.3338309-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124702.3338309-1-sashal@kernel.org>
References: <20241124124702.3338309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 8ed10366c4a27..aa8fc2cf1bde7 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -895,11 +895,12 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
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
@@ -964,7 +965,12 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
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


