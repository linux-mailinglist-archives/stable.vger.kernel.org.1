Return-Path: <stable+bounces-141577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D856AAB4C3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147AE3B62DD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6FB2F1CD6;
	Tue,  6 May 2025 00:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgYPiTwW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851B62F1CF0;
	Mon,  5 May 2025 23:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486769; cv=none; b=WOHs6R+C14JOkyxLiotqFjSaoS88NyxFeWjaoxc0vEa/nRv39zunKnNswH6JFVLv+JHwaTtM3m+UL8fet3DzGrIZ0yMV+AA0xqVFMsrysla3Dqm+k6G1bOw2d+lcWAVP3PBvmdBKZBi93dRQ6zPzpCtxSEc9XOWj1kBZv5CheIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486769; c=relaxed/simple;
	bh=6B6AcaCuBm4DSAnDvm2zUlswNtIYT6A8wxPac6AlalU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kg+wwXCJznUpfE5mqOjyyJ+tjxDXByn4/8mNYlFuPxIwNmkfPNZl5ASBeWRQ01+ar/y52kxnr4CEYKFVKzcLOvU5Ekwg/NS2ksrFaL5T6eZ2QPxVjbkPE5UaAaBv03fsaoMCz6u4u/XuRYIK/FMDm2tfsL3s05SFmwSLuGHr1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgYPiTwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A467C4CEE4;
	Mon,  5 May 2025 23:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486768;
	bh=6B6AcaCuBm4DSAnDvm2zUlswNtIYT6A8wxPac6AlalU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CgYPiTwWSOAZz2wE+7PCDY9Z0/NkIatVvuOyHv23QhF+8XndVsX+herYQ9Bm0iKbn
	 lkGbrEML8wXHFwaTmr0yZIlrcaGS54JYozJZ9/I+s/dZYxS2lX/q8FF3EZgKjA9+qy
	 vfB+4uRp3eSDH8tTlr3vBsjkenfX69E4/wKHT/mIearF/f9NhEcKFMd3mHXQfV/y4K
	 pgFIbwgAW/B99+fZtZPjgRsqNbNzlYFaZyQCBM9oojVTkENUwrNTDUXi3fsgft0hjF
	 I3F5DyIZzp2NOypKIj6UNpLBAFgVQulwyXgo2f4336P+VefXxBrc6jLe/JuEqdlgg3
	 LVx74pYNrP6Qg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 193/212] perf: Avoid the read if the count is already updated
Date: Mon,  5 May 2025 19:06:05 -0400
Message-Id: <20250505230624.2692522-193-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

[ Upstream commit 8ce939a0fa194939cc1f92dbd8bc1a7806e7d40a ]

The event may have been updated in the PMU-specific implementation,
e.g., Intel PEBS counters snapshotting. The common code should not
read and overwrite the value.

The PERF_SAMPLE_READ in the data->sample_type can be used to detect
whether the PMU-specific value is available. If yes, avoid the
pmu->read() in the common code. Add a new flag, skip_read, to track the
case.

Factor out a perf_pmu_read() to clean up the code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250121152303.3128733-3-kan.liang@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/perf_event.h  |  8 +++++++-
 kernel/events/core.c        | 33 ++++++++++++++++-----------------
 kernel/events/ring_buffer.c |  1 +
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 27b694552d58b..41ff70f315a92 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -935,7 +935,13 @@ struct perf_output_handle {
 	struct perf_buffer		*rb;
 	unsigned long			wakeup;
 	unsigned long			size;
-	u64				aux_flags;
+	union {
+		u64			flags;		/* perf_output*() */
+		u64			aux_flags;	/* perf_aux_output*() */
+		struct {
+			u64		skip_read : 1;
+		};
+	};
 	union {
 		void			*addr;
 		unsigned long		head;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8fc2bc5646ee2..552bb00bfceb0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1180,6 +1180,12 @@ static void perf_event_ctx_deactivate(struct perf_event_context *ctx)
 	list_del_init(&ctx->active_ctx_list);
 }
 
+static inline void perf_pmu_read(struct perf_event *event)
+{
+	if (event->state == PERF_EVENT_STATE_ACTIVE)
+		event->pmu->read(event);
+}
+
 static void get_ctx(struct perf_event_context *ctx)
 {
 	refcount_inc(&ctx->refcount);
@@ -3389,8 +3395,7 @@ static void __perf_event_sync_stat(struct perf_event *event,
 	 * we know the event must be on the current CPU, therefore we
 	 * don't need to use it.
 	 */
-	if (event->state == PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+	perf_pmu_read(event);
 
 	perf_event_update_time(event);
 
@@ -4444,15 +4449,8 @@ static void __perf_event_read(void *info)
 
 	pmu->read(event);
 
-	for_each_sibling_event(sub, event) {
-		if (sub->state == PERF_EVENT_STATE_ACTIVE) {
-			/*
-			 * Use sibling's PMU rather than @event's since
-			 * sibling could be on different (eg: software) PMU.
-			 */
-			sub->pmu->read(sub);
-		}
-	}
+	for_each_sibling_event(sub, event)
+		perf_pmu_read(sub);
 
 	data->ret = pmu->commit_txn(pmu);
 
@@ -7101,9 +7099,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		values[n++] = running;
 
-	if ((leader != event) &&
-	    (leader->state == PERF_EVENT_STATE_ACTIVE))
-		leader->pmu->read(leader);
+	if ((leader != event) && !handle->skip_read)
+		perf_pmu_read(leader);
 
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
@@ -7116,9 +7113,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	for_each_sibling_event(sub, leader) {
 		n = 0;
 
-		if ((sub != event) &&
-		    (sub->state == PERF_EVENT_STATE_ACTIVE))
-			sub->pmu->read(sub);
+		if ((sub != event) && !handle->skip_read)
+			perf_pmu_read(sub);
 
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
@@ -7173,6 +7169,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 {
 	u64 sample_type = data->type;
 
+	if (data->sample_flags & PERF_SAMPLE_READ)
+		handle->skip_read = 1;
+
 	perf_output_put(handle, *header);
 
 	if (sample_type & PERF_SAMPLE_IDENTIFIER)
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 3e1655374c2ed..4c4894de6e5d1 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -181,6 +181,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 	handle->rb    = rb;
 	handle->event = event;
+	handle->flags = 0;
 
 	have_lost = local_read(&rb->lost);
 	if (unlikely(have_lost)) {
-- 
2.39.5


