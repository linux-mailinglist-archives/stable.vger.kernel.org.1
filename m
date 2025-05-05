Return-Path: <stable+bounces-140017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85096AAA3D6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF65464E2F
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAF428B3FE;
	Mon,  5 May 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmH3dJWa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4423128B3F5;
	Mon,  5 May 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483921; cv=none; b=jhFe7+9yZPdiHMmCSu4xPCHXnyc+t1S1bQYsRtsPTAiJvDOgWhgA9Kmnm3QnJk+kEvZOSYCuGFcmAP2j47I/wQtmbzpLjcF9r8IHuT1xr3p2FLJ/R7E7IdhiB7wXRcp5TdszFFB4rx4IPvT3s4tDoc9mxi9ticXfGyfXv5wqwG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483921; c=relaxed/simple;
	bh=+hymtYd/bNIYeqiKyUuCFDEx1mLoUq9sHor1J9dchoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UQJ0E1LoU3bPTVtuJoHzCyRKMuKKjKeUs8J2S4TJSiBqfNYYTWyenfF1VlgRS9x7bo8vg/Y8nFaGxIXmhfb6DClskp8sQ3qDhO6ajaBi8nyY9jRdjGb6O3yiMTk4k2Bs10uBGuY101YYi+ECugwDZQQC456bAhcCQcL/Oa6peIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmH3dJWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0885C4CEF2;
	Mon,  5 May 2025 22:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483921;
	bh=+hymtYd/bNIYeqiKyUuCFDEx1mLoUq9sHor1J9dchoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hmH3dJWaOgnHz1Tgf6G3pWa2KaiI7oMgLJxgasqjDlaSQMzebHFbwaO8OkqH/CSIa
	 VZKZOqa+0vfz8Fj3RzYQASrzOCCW3rjNfQzTo+GIzU19PX8NtWI+GkyZ6ILuGezcYB
	 xZEw1xdDe4rz+pP6CrqDnPQBQ6w2NQ4WHD7Z1ZZKM5VRevLuEHt1zACC2YsecS7aa8
	 toHT0xutBf0S5MQWH5P8av18qUbuDI5fNf4ID8KzelBi0zq1DCTPAXk2grWQWLD/6m
	 Jdw19nG/zoCB+P48ZW+7F9+vU6vOFOtk96SfQhWT5V/e6hslA58WOtWfTmnxh4WgL6
	 8PHIZ6GW5k+Xg==
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
Subject: [PATCH AUTOSEL 6.14 270/642] perf/hw_breakpoint: Return EOPNOTSUPP for unsupported breakpoint type
Date: Mon,  5 May 2025 18:08:06 -0400
Message-Id: <20250505221419.2672473-270-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index bc4a61029b6dc..8ec2cb6889038 100644
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


