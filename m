Return-Path: <stable+bounces-127070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D526A7681D
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FF016A80E
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F27B219A86;
	Mon, 31 Mar 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJzFj0Fb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AFC21B9D1;
	Mon, 31 Mar 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431673; cv=none; b=F3KzuEwzBbNL+RvX25Avy+GE7f+sQ0h3i0M5+CMy3Rv15nW942JTl6FREzGQka1slVvxqJWA8NBridcWExXjBT6L82j3gBE4iEjagSkj7GLe9YEWrCvvAgaJdvPG+K3emTnYGo0ysSN6KR6ja4303H5V7PaurzDJ0ui21e94Mdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431673; c=relaxed/simple;
	bh=RxXN5ImDkHlxqQmfInHiKTyFOrz987IzeR6333NbSJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mB7xSQd7mEww+b1XQD0X3TZbE5ADUEJlujx1Wd5HIMRfkGt8ng4QCDZUuE66j6qdbNjAb+el5P900lJ8QTQxsoo04lfi26kDcSvnCKx9CZ3kJwrQz9w8aoxdOTB5C1ONoqm41y7R7Jod4nQN1Lvmpjc+1Af+xpWcf2cYQNt/jHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJzFj0Fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47538C4CEE4;
	Mon, 31 Mar 2025 14:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431671;
	bh=RxXN5ImDkHlxqQmfInHiKTyFOrz987IzeR6333NbSJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJzFj0Fb9JehsWcz7uSbYD3tnPXbjTintoKWN9Jb44fNCWgRm/Jl9Ym+tNrx2BqDH
	 medr5Es0YT05yng3VHeBg5vtfcTOcx+g6f2jp3a4dJgIMinDXDRCqa687RQcK8U+y0
	 0e16qgimqzEnxPk7r0W58IK5KF20wMWzAk5bAvU4OFUeUAW10yA2rkCgBVEqvOgK0H
	 UdRLL/GMIcooyU6qKQ2jtfvXpN6stJX2U+VcOB7t1h4kA9GzPPn1ZmoinaIhqnwZKs
	 Z64XpqFRBkjYbcGGpFEGNWgsj2DwoYNK4fM10l2NQNscMrFWn6s30ax0jqeIhGLH/1
	 QpltbptrgswnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 08/18] perf: arm_pmu: Don't disable counter in armpmu_add()
Date: Mon, 31 Mar 2025 10:33:58 -0400
Message-Id: <20250331143409.1682789-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143409.1682789-1-sashal@kernel.org>
References: <20250331143409.1682789-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit dcca27bc1eccb9abc2552aab950b18a9742fb8e7 ]

Currently armpmu_add() tries to handle a newly-allocated counter having
a stale associated event, but this should not be possible, and if this
were to happen the current mitigation is insufficient and potentially
expensive. It would be better to warn if we encounter the impossible
case.

Calls to pmu::add() and pmu::del() are serialized by the core perf code,
and armpmu_del() clears the relevant slot in pmu_hw_events::events[]
before clearing the bit in pmu_hw_events::used_mask such that the
counter can be reallocated. Thus when armpmu_add() allocates a counter
index from pmu_hw_events::used_mask, it should not be possible to observe
a stale even in pmu_hw_events::events[] unless either
pmu_hw_events::used_mask or pmu_hw_events::events[] have been corrupted.

If this were to happen, we'd end up with two events with the same
event->hw.idx, which would clash with each other during reprogramming,
deletion, etc, and produce bogus results. Add a WARN_ON_ONCE() for this
case so that we can detect if this ever occurs in practice.

That possiblity aside, there's no need to call arm_pmu::disable(event)
for the new event. The PMU reset code initialises the counter in a
disabled state, and armpmu_del() will disable the counter before it can
be reused. Remove the redundant disable.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Tested-by: James Clark <james.clark@linaro.org>
Link: https://lore.kernel.org/r/20250218-arm-brbe-v19-v20-2-4e9922fc2e8e@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm_pmu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 398cce3d76fc4..2f33e69a8caf2 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -342,12 +342,10 @@ armpmu_add(struct perf_event *event, int flags)
 	if (idx < 0)
 		return idx;
 
-	/*
-	 * If there is an event in the counter we are going to use then make
-	 * sure it is disabled.
-	 */
+	/* The newly-allocated counter should be empty */
+	WARN_ON_ONCE(hw_events->events[idx]);
+
 	event->hw.idx = idx;
-	armpmu->disable(event);
 	hw_events->events[idx] = event;
 
 	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
-- 
2.39.5


