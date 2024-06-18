Return-Path: <stable+bounces-53335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F277490D1B7
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E33B2650A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA90158213;
	Tue, 18 Jun 2024 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ds8QAGk5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7791581F6;
	Tue, 18 Jun 2024 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716023; cv=none; b=iWvO4mb8kZj2Jp0dyZidJsD7Od3v1LHfyHAPdDu4ltnVGwjLwA94y6rRwBmNVA+kikwzH3/zvkRDuNR8sa6D8jrfoiTqbpawIlqM/erBwJkxt4VWa5P9xVfMjudEVasu1+kzGTwXGDJafCm3L4b9mRfWq59occlnVVF89qZf4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716023; c=relaxed/simple;
	bh=TOpr59vhA9MGA/Iuwb8CSwb4v8F61w8FY4h1bBDHSfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8xhKfsPMmWpE3axb0Pdm3IYAg16eot9+rGHGEHGUFliecE4yiAgdLi3b8eqNMEvnu52VC5FRGLQzNF1lxfAoL4Jwhla7rPjYM0aeWEBqY7i+SU7Bn2EJfdzYaF1PAqYlZqsu5YwRPGF/RrCjO9/E05oxMYUrnsmM4ur8Lc3ukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ds8QAGk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367ABC3277B;
	Tue, 18 Jun 2024 13:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716023;
	bh=TOpr59vhA9MGA/Iuwb8CSwb4v8F61w8FY4h1bBDHSfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ds8QAGk53AjbiCW7VZYxL3FEqVyDPU2q0ywUGdCXysrey9McV4tx9QupfmeRTMLwG
	 CXEcNZUkBk98tP/nHUdbfwxx/bV+WTlPrMTsMEGl0hEaRiISz1jHS2Zt2EdHbhKcKT
	 BegzJDeCkXnF6VO8DlvrcnUv1GJao1fr2VTHhQP4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 506/770] fsnotify: introduce mark type iterator
Date: Tue, 18 Jun 2024 14:35:59 +0200
Message-ID: <20240618123426.845379107@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 14362a2541797cf9df0e86fb12dcd7950baf566e ]

fsnotify_foreach_iter_mark_type() is used to reduce boilerplate code
of iterating all marks of a specific group interested in an event
by consulting the iterator report_mask.

Use an open coded version of that iterator in fsnotify_iter_next()
that collects all marks of the current iteration group without
consulting the iterator report_mask.

At the moment, the two iterator variants are the same, but this
decoupling will allow us to exclude some of the group's marks from
reporting the event, for example for event on child and inode marks
on parent did not request to watch events on children.

Fixes: 2f02fd3fa13e ("fanotify: fix ignore mask logic for events on child and on dir")
Reported-by: Jan Kara <jack@suse.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220511190213.831646-2-amir73il@gmail.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify.c    | 14 +++------
 fs/notify/fsnotify.c             | 53 ++++++++++++++++----------------
 include/linux/fsnotify_backend.h | 31 ++++++++++++++-----
 3 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 985e995d2a398..263d303d8f8f1 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -319,11 +319,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 			return 0;
 	}
 
-	fsnotify_foreach_iter_type(type) {
-		if (!fsnotify_iter_should_report_type(iter_info, type))
-			continue;
-		mark = iter_info->marks[type];
-
+	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
 		/* Apply ignore mask regardless of ISDIR and ON_CHILD flags */
 		marks_ignored_mask |= mark->ignored_mask;
 
@@ -849,16 +845,14 @@ static struct fanotify_event *fanotify_alloc_event(
  */
 static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 {
+	struct fsnotify_mark *mark;
 	int type;
 	__kernel_fsid_t fsid = {};
 
-	fsnotify_foreach_iter_type(type) {
+	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
 		struct fsnotify_mark_connector *conn;
 
-		if (!fsnotify_iter_should_report_type(iter_info, type))
-			continue;
-
-		conn = READ_ONCE(iter_info->marks[type]->connector);
+		conn = READ_ONCE(mark->connector);
 		/* Mark is just getting destroyed or created? */
 		if (!conn)
 			continue;
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 6eee19d15e8cd..35740a64ee453 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -335,31 +335,23 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 	struct fsnotify_mark *mark;
 	int type;
 
-	if (WARN_ON(!iter_info->report_mask))
+	if (!iter_info->report_mask)
 		return 0;
 
 	/* clear ignored on inode modification */
 	if (mask & FS_MODIFY) {
-		fsnotify_foreach_iter_type(type) {
-			if (!fsnotify_iter_should_report_type(iter_info, type))
-				continue;
-			mark = iter_info->marks[type];
-			if (mark &&
-			    !(mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
+		fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
+			if (!(mark->flags &
+			      FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
 				mark->ignored_mask = 0;
 		}
 	}
 
-	fsnotify_foreach_iter_type(type) {
-		if (!fsnotify_iter_should_report_type(iter_info, type))
-			continue;
-		mark = iter_info->marks[type];
-		/* does the object mark tell us to do something? */
-		if (mark) {
-			group = mark->group;
-			marks_mask |= mark->mask;
-			marks_ignored_mask |= mark->ignored_mask;
-		}
+	/* Are any of the group marks interested in this event? */
+	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
+		group = mark->group;
+		marks_mask |= mark->mask;
+		marks_ignored_mask |= mark->ignored_mask;
 	}
 
 	pr_debug("%s: group=%p mask=%x marks_mask=%x marks_ignored_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
@@ -403,11 +395,11 @@ static struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark)
 
 /*
  * iter_info is a multi head priority queue of marks.
- * Pick a subset of marks from queue heads, all with the
- * same group and set the report_mask for selected subset.
- * Returns the report_mask of the selected subset.
+ * Pick a subset of marks from queue heads, all with the same group
+ * and set the report_mask to a subset of the selected marks.
+ * Returns false if there are no more groups to iterate.
  */
-static unsigned int fsnotify_iter_select_report_types(
+static bool fsnotify_iter_select_report_types(
 		struct fsnotify_iter_info *iter_info)
 {
 	struct fsnotify_group *max_prio_group = NULL;
@@ -423,30 +415,37 @@ static unsigned int fsnotify_iter_select_report_types(
 	}
 
 	if (!max_prio_group)
-		return 0;
+		return false;
 
 	/* Set the report mask for marks from same group as max prio group */
+	iter_info->current_group = max_prio_group;
 	iter_info->report_mask = 0;
 	fsnotify_foreach_iter_type(type) {
 		mark = iter_info->marks[type];
-		if (mark &&
-		    fsnotify_compare_groups(max_prio_group, mark->group) == 0)
+		if (mark && mark->group == iter_info->current_group)
 			fsnotify_iter_set_report_type(iter_info, type);
 	}
 
-	return iter_info->report_mask;
+	return true;
 }
 
 /*
- * Pop from iter_info multi head queue, the marks that were iterated in the
+ * Pop from iter_info multi head queue, the marks that belong to the group of
  * current iteration step.
  */
 static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
 {
+	struct fsnotify_mark *mark;
 	int type;
 
+	/*
+	 * We cannot use fsnotify_foreach_iter_mark_type() here because we
+	 * may need to advance a mark of type X that belongs to current_group
+	 * but was not selected for reporting.
+	 */
 	fsnotify_foreach_iter_type(type) {
-		if (fsnotify_iter_should_report_type(iter_info, type))
+		mark = iter_info->marks[type];
+		if (mark && mark->group == iter_info->current_group)
 			iter_info->marks[type] =
 				fsnotify_next_mark(iter_info->marks[type]);
 	}
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 9a1a9e78f69f5..9560734759fa6 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -399,6 +399,7 @@ static inline bool fsnotify_valid_obj_type(unsigned int obj_type)
 
 struct fsnotify_iter_info {
 	struct fsnotify_mark *marks[FSNOTIFY_ITER_TYPE_COUNT];
+	struct fsnotify_group *current_group;
 	unsigned int report_mask;
 	int srcu_idx;
 };
@@ -415,20 +416,31 @@ static inline void fsnotify_iter_set_report_type(
 	iter_info->report_mask |= (1U << iter_type);
 }
 
-static inline void fsnotify_iter_set_report_type_mark(
-		struct fsnotify_iter_info *iter_info, int iter_type,
-		struct fsnotify_mark *mark)
+static inline struct fsnotify_mark *fsnotify_iter_mark(
+		struct fsnotify_iter_info *iter_info, int iter_type)
 {
-	iter_info->marks[iter_type] = mark;
-	iter_info->report_mask |= (1U << iter_type);
+	if (fsnotify_iter_should_report_type(iter_info, iter_type))
+		return iter_info->marks[iter_type];
+	return NULL;
+}
+
+static inline int fsnotify_iter_step(struct fsnotify_iter_info *iter, int type,
+				     struct fsnotify_mark **markp)
+{
+	while (type < FSNOTIFY_ITER_TYPE_COUNT) {
+		*markp = fsnotify_iter_mark(iter, type);
+		if (*markp)
+			break;
+		type++;
+	}
+	return type;
 }
 
 #define FSNOTIFY_ITER_FUNCS(name, NAME) \
 static inline struct fsnotify_mark *fsnotify_iter_##name##_mark( \
 		struct fsnotify_iter_info *iter_info) \
 { \
-	return (iter_info->report_mask & (1U << FSNOTIFY_ITER_TYPE_##NAME)) ? \
-		iter_info->marks[FSNOTIFY_ITER_TYPE_##NAME] : NULL; \
+	return fsnotify_iter_mark(iter_info, FSNOTIFY_ITER_TYPE_##NAME); \
 }
 
 FSNOTIFY_ITER_FUNCS(inode, INODE)
@@ -438,6 +450,11 @@ FSNOTIFY_ITER_FUNCS(sb, SB)
 
 #define fsnotify_foreach_iter_type(type) \
 	for (type = 0; type < FSNOTIFY_ITER_TYPE_COUNT; type++)
+#define fsnotify_foreach_iter_mark_type(iter, mark, type) \
+	for (type = 0; \
+	     type = fsnotify_iter_step(iter, type, &mark), \
+	     type < FSNOTIFY_ITER_TYPE_COUNT; \
+	     type++)
 
 /*
  * fsnotify_connp_t is what we embed in objects which connector can be attached
-- 
2.43.0




