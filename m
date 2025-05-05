Return-Path: <stable+bounces-140717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60005AAAEC9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4484E1DC3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02772EEBDE;
	Mon,  5 May 2025 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyi3Vn79"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ABE3867ED;
	Mon,  5 May 2025 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486043; cv=none; b=P6dQ3KjrK4PgQAGSF/LZPBzW/lyMCzyTu8NGUXHjYEJn/mrURoA65qLsoyrnQkochwx01qVRiMCv14l2V+LwlDHl6sfI1hvRWVPctpzZin9EwvQF946erNL1ad86INRfzWSD7AjRMJHuBZG/vVJ/GHB464ApEv6FH0uM1tC9+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486043; c=relaxed/simple;
	bh=8S/5I22qd4S0oH7P51ixZiHczSeXqwMQkKM+m4qTrFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sQhGJJfg0AI7guTYzl8b2gwPomoJJhjeAkH5suwllGMpF1CKpPX+gPbwR/GJuo0/XJzObas9I6OlBuDpuBGC/uZvn92G1OP8i+x87WW/oUqX9PJAH7klrkee7f7BBB+t3ti0YTN6UJ7urO4sxOD06XL+zHlyA6zeNQrAg4SE+Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyi3Vn79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE05C4CEEF;
	Mon,  5 May 2025 23:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486043;
	bh=8S/5I22qd4S0oH7P51ixZiHczSeXqwMQkKM+m4qTrFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyi3Vn79cHk4L0hjx8oPMEqBxGcyv/d0etl95QPj9UYhCogK65HAOwh9txxL5d7Yd
	 GsTDJWzGahDp91FiB/QQcE5V8YeY7jrfwCjr7yl1OPmgLPE8JNpd3tWKWU98pLLIFT
	 gO6VKR8xFInas/KkiB78zvS5aidRsE8gLJpyOlOnwubHJXIpHMDJgj6K7eQ7e7lM5/
	 10vLpPkbLRJIUcxd78POI/6ukc1iltfjxMZ2YMqMS6/64EH1Bbct5tOneUomtZIYoE
	 GhiO+ub0Gka0SPUSJCIx2Iqu5BtPBioAPZdJrg+KLNObsaa2RnrNJ71tvV1PA5qQf6
	 uLe0+28fbLB3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Ingo Molnar <mingo@kernel.org>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ian Rogers <irogers@google.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 124/294] perf/hw_breakpoint: Return EOPNOTSUPP for unsupported breakpoint type
Date: Mon,  5 May 2025 18:53:44 -0400
Message-Id: <20250505225634.2688578-124-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Saket Kumar Bhaskar <skb99@linux.ibm.com>

[ Upstream commit 061c991697062f3bf87b72ed553d1d33a0e370dd ]

Currently, __reserve_bp_slot() returns -ENOSPC for unsupported
breakpoint types on the architecture. For example, powerpc
does not support hardware instruction breakpoints. This causes
the perf_skip BPF selftest to fail, as neither ENOENT nor
EOPNOTSUPP is returned by perf_event_open for unsupported
breakpoint types. As a result, the test that should be skipped
for this arch is not correctly identified.

To resolve this, hw_breakpoint_event_init() should exit early by
checking for unsupported breakpoint types using
hw_breakpoint_slots_cached() and return the appropriate error
(-EOPNOTSUPP).

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: https://lore.kernel.org/r/20250303092451.1862862-1-skb99@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/hw_breakpoint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 6c2cb4e4f48da..8f3f624419aa9 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -950,9 +950,10 @@ static int hw_breakpoint_event_init(struct perf_event *bp)
 		return -ENOENT;
 
 	/*
-	 * no branch sampling for breakpoint events
+	 * Check if breakpoint type is supported before proceeding.
+	 * Also, no branch sampling for breakpoint events.
 	 */
-	if (has_branch_stack(bp))
+	if (!hw_breakpoint_slots_cached(find_slot_idx(bp->attr.bp_type)) || has_branch_stack(bp))
 		return -EOPNOTSUPP;
 
 	err = register_perf_hw_breakpoint(bp);
-- 
2.39.5


