Return-Path: <stable+bounces-5910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9040980D7C0
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E70282064
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE4952F8B;
	Mon, 11 Dec 2023 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i6536MdT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2B524D4;
	Mon, 11 Dec 2023 18:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AF9C433C8;
	Mon, 11 Dec 2023 18:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319995;
	bh=nmGmUZ3Bv8fWSJbuiVYbVyvEhRRYFko5xyNpDof0Vas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6536MdTWOZT+qDt9VdUzjRqjG4sXRozq4hi0HJFhODMqI2OR7u124uY13krvKmVo
	 d1ewQbqUmNP6eqjLdlgoYXy1HTdswgRoRhgskkGswQFOPaa8VdLBQzj+ueI59TPblw
	 PhR2GOTMsES1X7FV9oLwGNCusry2usMLYNmX/Muw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namhyung Kim <namhyung@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 5.10 65/97] perf/core: Add a new read format to get a number of lost samples
Date: Mon, 11 Dec 2023 19:22:08 +0100
Message-ID: <20231211182022.546707736@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>
References: <20231211182019.802717483@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 119a784c81270eb88e573174ed2209225d646656 ]

Sometimes we want to know an accurate number of samples even if it's
lost.  Currenlty PERF_RECORD_LOST is generated for a ring-buffer which
might be shared with other events.  So it's hard to know per-event
lost count.

Add event->lost_samples field and PERF_FORMAT_LOST to retrieve it from
userspace.

Original-patch-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220616180623.1358843-1-namhyung@kernel.org
Stable-dep-of: 382c27f4ed28 ("perf: Fix perf_event_validate_size()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/perf_event.h      |  2 ++
 include/uapi/linux/perf_event.h |  5 ++++-
 kernel/events/core.c            | 21 ++++++++++++++++++---
 kernel/events/ring_buffer.c     |  5 ++++-
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 50557d903a059..3b038a2cc0071 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -744,6 +744,8 @@ struct perf_event {
 	struct pid_namespace		*ns;
 	u64				id;
 
+	atomic64_t			lost_samples;
+
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b95d3c485d27e..6ca63ab6bee5d 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -279,6 +279,7 @@ enum {
  *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		id;           } && PERF_FORMAT_ID
+ *	  { u64		lost;         } && PERF_FORMAT_LOST
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
@@ -286,6 +287,7 @@ enum {
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		value;
  *	    { u64	id;           } && PERF_FORMAT_ID
+ *	    { u64	lost;         } && PERF_FORMAT_LOST
  *	  }		cntr[nr];
  *	} && PERF_FORMAT_GROUP
  * };
@@ -295,8 +297,9 @@ enum perf_event_read_format {
 	PERF_FORMAT_TOTAL_TIME_RUNNING		= 1U << 1,
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
+	PERF_FORMAT_LOST			= 1U << 4,
 
-	PERF_FORMAT_MAX = 1U << 4,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5072635f0b0c1..f7ac1b24f93e0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1927,6 +1927,9 @@ static void __perf_event_read_size(struct perf_event *event, int nr_siblings)
 	if (event->attr.read_format & PERF_FORMAT_ID)
 		entry += sizeof(u64);
 
+	if (event->attr.read_format & PERF_FORMAT_LOST)
+		entry += sizeof(u64);
+
 	if (event->attr.read_format & PERF_FORMAT_GROUP) {
 		nr += nr_siblings;
 		size += sizeof(u64);
@@ -5283,11 +5286,15 @@ static int __perf_read_group_add(struct perf_event *leader,
 	values[n++] += perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&leader->lost_samples);
 
 	for_each_sibling_event(sub, leader) {
 		values[n++] += perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
+		if (read_format & PERF_FORMAT_LOST)
+			values[n++] = atomic64_read(&sub->lost_samples);
 	}
 
 unlock:
@@ -5341,7 +5348,7 @@ static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = __perf_event_read_value(event, &enabled, &running);
@@ -5351,6 +5358,8 @@ static int perf_read_one(struct perf_event *event,
 		values[n++] = running;
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&event->lost_samples);
 
 	if (copy_to_user(buf, values, n * sizeof(u64)))
 		return -EFAULT;
@@ -6830,7 +6839,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 				 u64 enabled, u64 running)
 {
 	u64 read_format = event->attr.read_format;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = perf_event_count(event);
@@ -6844,6 +6853,8 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 	}
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&event->lost_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 }
@@ -6854,7 +6865,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
-	u64 values[5];
+	u64 values[6];
 	int n = 0;
 
 	values[n++] = 1 + leader->nr_siblings;
@@ -6872,6 +6883,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&leader->lost_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 
@@ -6885,6 +6898,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
+		if (read_format & PERF_FORMAT_LOST)
+			values[n++] = atomic64_read(&sub->lost_samples);
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 01351e7e25435..ca27946fdaaf2 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -172,8 +172,10 @@ __perf_output_begin(struct perf_output_handle *handle,
 		goto out;
 
 	if (unlikely(rb->paused)) {
-		if (rb->nr_pages)
+		if (rb->nr_pages) {
 			local_inc(&rb->lost);
+			atomic64_inc(&event->lost_samples);
+		}
 		goto out;
 	}
 
@@ -254,6 +256,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 fail:
 	local_inc(&rb->lost);
+	atomic64_inc(&event->lost_samples);
 	perf_output_put_handle(handle);
 out:
 	rcu_read_unlock();
-- 
2.42.0




