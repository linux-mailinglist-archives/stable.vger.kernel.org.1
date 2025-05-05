Return-Path: <stable+bounces-141297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 346A8AAB239
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CDAD7BB990
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EFF424E60;
	Tue,  6 May 2025 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClS7G8Fu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FC72D645A;
	Mon,  5 May 2025 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485710; cv=none; b=JY8+QNkPXs3DhT9Dfy021MT2Xi8231S4RYmOLgM1q9+9IqeXNPmPOjPDcAx3Awk/3E2LLd5RKlqDLS0JyyoUVnyA+LY2f2sB1Cgn5pveECYaRM+elJk2CMoABRC9RMrYhbal18BoBotZGBrNudPt4GRx6P+oSOHMjssbnFzgVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485710; c=relaxed/simple;
	bh=0TmT3EGhWGw8ky7jmyYpupSiPCHy2eD7NHrXlq8l/Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ro7nO5p2ThtuJulsPsg3b5GTyhbRxjknfXVLqc3rA3fX2nulRXks8YjKyIZMjT+Fliq+6X6dJfCblZofVEfbi/KHMMC/pudo9eSw/yhO5N8MfhzhuuGQyRi2/QiXyOknPp37ycVO0gYszXO/qlGdIH6693pz6dK01FvDFhaFmh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClS7G8Fu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45019C4CEEE;
	Mon,  5 May 2025 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485710;
	bh=0TmT3EGhWGw8ky7jmyYpupSiPCHy2eD7NHrXlq8l/Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ClS7G8FuaIUEiO7lbd4F/uO6dLGW787gVw6YkLh1OyD9E6+zHOOPK1g+h1rBYvCsY
	 rQ6DPaN0YxYD5GSk8TvnLXDz+pAuNJhZsL26+1T/6iSqDIpu3IiYwSL9x520Ff0mb5
	 jtQfc23QjIvWPr/6j2UHOYsKCmFJzHpsMpOOrGINKiOISH6jdhHYZDMmIC3oFHFemU
	 Xb7830jKgdiyK8b23gCcZ6xT3oyw7JgmJhXxPexJ1Ol/WCF4HKqLe4MA7Wzoh4ED99
	 JAMdt967vhklbHHT5h32fRF76UpiAIbC7U4EFp+Ohz5iJMprtGHNZpCUKxdRHFM1pC
	 HD8pJtkSHuoOA==
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
Subject: [PATCH AUTOSEL 6.12 437/486] perf: Avoid the read if the count is already updated
Date: Mon,  5 May 2025 18:38:33 -0400
Message-Id: <20250505223922.2682012-437-sashal@kernel.org>
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
index 0997077bcc52a..ce64b4b937f06 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1063,7 +1063,13 @@ struct perf_output_handle {
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
index 19dde12f23b83..285a4548450bd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1195,6 +1195,12 @@ static void perf_assert_pmu_disabled(struct pmu *pmu)
 	WARN_ON_ONCE(*this_cpu_ptr(pmu->pmu_disable_count) == 0);
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
@@ -3482,8 +3488,7 @@ static void __perf_event_sync_stat(struct perf_event *event,
 	 * we know the event must be on the current CPU, therefore we
 	 * don't need to use it.
 	 */
-	if (event->state == PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+	perf_pmu_read(event);
 
 	perf_event_update_time(event);
 
@@ -4634,15 +4639,8 @@ static void __perf_event_read(void *info)
 
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
 
@@ -7408,9 +7406,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		values[n++] = running;
 
-	if ((leader != event) &&
-	    (leader->state == PERF_EVENT_STATE_ACTIVE))
-		leader->pmu->read(leader);
+	if ((leader != event) && !handle->skip_read)
+		perf_pmu_read(leader);
 
 	values[n++] = perf_event_count(leader, self);
 	if (read_format & PERF_FORMAT_ID)
@@ -7423,9 +7420,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	for_each_sibling_event(sub, leader) {
 		n = 0;
 
-		if ((sub != event) &&
-		    (sub->state == PERF_EVENT_STATE_ACTIVE))
-			sub->pmu->read(sub);
+		if ((sub != event) && !handle->skip_read)
+			perf_pmu_read(sub);
 
 		values[n++] = perf_event_count(sub, self);
 		if (read_format & PERF_FORMAT_ID)
@@ -7484,6 +7480,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 {
 	u64 sample_type = data->type;
 
+	if (data->sample_flags & PERF_SAMPLE_READ)
+		handle->skip_read = 1;
+
 	perf_output_put(handle, *header);
 
 	if (sample_type & PERF_SAMPLE_IDENTIFIER)
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index bbfa22c0a1597..6ecbbc57cdfde 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -185,6 +185,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 	handle->rb    = rb;
 	handle->event = event;
+	handle->flags = 0;
 
 	have_lost = local_read(&rb->lost);
 	if (unlikely(have_lost)) {
-- 
2.39.5


