Return-Path: <stable+bounces-141122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E025AAB0A9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9CC4C4F72
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C80D323358;
	Tue,  6 May 2025 00:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzHaMdgL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E714D370B16;
	Mon,  5 May 2025 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485212; cv=none; b=VAQNPZNJYAVb/salNaRwZ7u2opXlSPDfT8Nopzood5FFcD3y/rB4puEiKKIXBZivTNN8w/Qu3AMHqjiZSrlMKlE29BNmNIJIhEQtlBXha1FbplSVns9q7OwT3QOCji7zWrkf9ESZ5MljpWKEloTWYKHkLEdPcwnN7Xkr5mSY0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485212; c=relaxed/simple;
	bh=8S/5I22qd4S0oH7P51ixZiHczSeXqwMQkKM+m4qTrFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q3IEf+Hls3ZMYmDw0dVFC9zDbmKGLz1DteI0SzvHi4tHMXSX9Zjo/TwVVaNd8bSWq81b6RgKZFZ+WSHp0n5q34mu78vILnvWFKYIq0VMdm86oWwEsVcNL9If/voqUEkSCOpH8yQgHcJ5CpXxv8tzGVwZcReev4QLfKwmHAK0cEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzHaMdgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75A0C4CEEF;
	Mon,  5 May 2025 22:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485211;
	bh=8S/5I22qd4S0oH7P51ixZiHczSeXqwMQkKM+m4qTrFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AzHaMdgLnZTWxOs3wo+pHODzHkhlxPbxbBuNFxmqVmGrjKcpFmAmE0dh1lRnupjDm
	 4gZUyQyyMSEumTPNQCs5BEkJEmwyGpiYb7Zau0IZRXVC+8fPc42RulqLYWHFSfRLcG
	 6F8VO1tI9g6uqaE+Fo1SpakJgDKWqtAKH0kLsH9tzUULKPlOInt10R04eDKkd/W+BG
	 4NuPVMOjxviy6H5IzeQOAaVPeeWF8IBgmwvkYnUXMVIjMz39a/8OrFBqvKkartSqGe
	 d3N6mmmOPwU0VUNubI32iB2glJ5mMgCfD7K4Xz98RuOOXHjbO+rd5LArz7C7i+O1iL
	 WEGluETPRWGog==
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
Subject: [PATCH AUTOSEL 6.12 213/486] perf/hw_breakpoint: Return EOPNOTSUPP for unsupported breakpoint type
Date: Mon,  5 May 2025 18:34:49 -0400
Message-Id: <20250505223922.2682012-213-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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


