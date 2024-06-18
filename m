Return-Path: <stable+bounces-53079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D1990D016
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618F21F22149
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E7116B399;
	Tue, 18 Jun 2024 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KPCYRCR1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE413B780;
	Tue, 18 Jun 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715266; cv=none; b=ikojM5zBJw8vOHSa4IKRJbBjSPdu3EIRSe9GNWlR7vEquaelfDZPWqI9kPEvGob6eQD9wO+0IqZ1ZreHKggw3TEjWS+W2JcxtJwJdd1hafJWK0oZhvTuOLrFWGacRlaCMXLdLPQf61RYCeL+wq0uYOMd/Yccw8vxin54pPiGzuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715266; c=relaxed/simple;
	bh=ej+NUv2Wvr4BXSmY/MtDu5ypsJkYnHUkpvyeorp2ZAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eM8zRu8/3BjkahNbIb9mEnoGEL7rRX39665EABvpt9VXKFiper/LHQ+yxgHKmHi/B6P5ZpXTzY1dVBdkj1ZrzdFk/Exx0sLj1Vym9arSo6Kpx8js8Uw0l+fDcW+Iuga7xA9wd3Ym432F7zxa1lVSCenmlctnw2wkdlFXiJiWPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KPCYRCR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6417BC3277B;
	Tue, 18 Jun 2024 12:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715265;
	bh=ej+NUv2Wvr4BXSmY/MtDu5ypsJkYnHUkpvyeorp2ZAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KPCYRCR1GUa5uHOJQqJulma3tXApZzqvu3Z64KdgSdksHOFyzJCJ6xa3ESljT2CfU
	 lilnVzvnVUWg68etIjX+f6beEAofaE4i2HDkmIZsXBdkOIRjIf7eJ5wY8/kLeedk0w
	 xf2bF7hlQwygiPw72cEYczFF4b03nH6+0mB19Gpk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 251/770] fanotify: reduce event objectid to 29-bit hash
Date: Tue, 18 Jun 2024 14:31:44 +0200
Message-ID: <20240618123416.965997257@linuxfoundation.org>
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

[ Upstream commit 8988f11abb820bacfcc53d498370bfb30f792ec4 ]

objectid is only used by fanotify backend and it is just an optimization
for event merge before comparing all fields in event.

Move the objectid member from common struct fsnotify_event into struct
fanotify_event and reduce it to 29-bit hash to cram it together with the
3-bit event type.

Events of different types are never merged, so the combination of event
type and hash form a 32-bit key for fast compare of events.

This reduces the size of events by one pointer and paves the way for
adding hashed queue support for fanotify.

Link: https://lore.kernel.org/r/20210304104826.3993892-3-amir73il@gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify.c        | 25 ++++++++++++-------------
 fs/notify/fanotify/fanotify.h        | 16 +++++++++++++---
 fs/notify/inotify/inotify_fsnotify.c |  2 +-
 fs/notify/inotify/inotify_user.c     |  2 +-
 include/linux/fsnotify_backend.h     |  5 +----
 5 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 1192c99536200..8a2bb6954e02c 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -88,16 +88,12 @@ static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
 	return fanotify_info_equal(info1, info2);
 }
 
-static bool fanotify_should_merge(struct fsnotify_event *old_fsn,
-				  struct fsnotify_event *new_fsn)
+static bool fanotify_should_merge(struct fanotify_event *old,
+				  struct fanotify_event *new)
 {
-	struct fanotify_event *old, *new;
+	pr_debug("%s: old=%p new=%p\n", __func__, old, new);
 
-	pr_debug("%s: old=%p new=%p\n", __func__, old_fsn, new_fsn);
-	old = FANOTIFY_E(old_fsn);
-	new = FANOTIFY_E(new_fsn);
-
-	if (old_fsn->objectid != new_fsn->objectid ||
+	if (old->hash != new->hash ||
 	    old->type != new->type || old->pid != new->pid)
 		return false;
 
@@ -133,10 +129,9 @@ static bool fanotify_should_merge(struct fsnotify_event *old_fsn,
 static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
 {
 	struct fsnotify_event *test_event;
-	struct fanotify_event *new;
+	struct fanotify_event *old, *new = FANOTIFY_E(event);
 
 	pr_debug("%s: list=%p event=%p\n", __func__, list, event);
-	new = FANOTIFY_E(event);
 
 	/*
 	 * Don't merge a permission event with any other event so that we know
@@ -147,8 +142,9 @@ static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
 		return 0;
 
 	list_for_each_entry_reverse(test_event, list, list) {
-		if (fanotify_should_merge(test_event, event)) {
-			FANOTIFY_E(test_event)->mask |= new->mask;
+		old = FANOTIFY_E(test_event);
+		if (fanotify_should_merge(old, new)) {
+			old->mask |= new->mask;
 			return 1;
 		}
 	}
@@ -533,6 +529,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	struct mem_cgroup *old_memcg;
 	struct inode *child = NULL;
 	bool name_event = false;
+	unsigned int hash = 0;
 
 	if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
 		/*
@@ -600,8 +597,10 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	 * Use the victim inode instead of the watching inode as the id for
 	 * event queue, so event reported on parent is merged with event
 	 * reported on child when both directory and child watches exist.
+	 * Hash object id for queue merge.
 	 */
-	fanotify_init_event(event, (unsigned long)id, mask);
+	hash = hash_ptr(id, FANOTIFY_EVENT_HASH_BITS);
+	fanotify_init_event(event, hash, mask);
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
 		event->pid = get_pid(task_pid(current));
 	else
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 896c819a17863..d531f0cfa46f2 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -135,19 +135,29 @@ enum fanotify_event_type {
 	FANOTIFY_EVENT_TYPE_PATH,
 	FANOTIFY_EVENT_TYPE_PATH_PERM,
 	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
+	__FANOTIFY_EVENT_TYPE_NUM
 };
 
+#define FANOTIFY_EVENT_TYPE_BITS \
+	(ilog2(__FANOTIFY_EVENT_TYPE_NUM - 1) + 1)
+#define FANOTIFY_EVENT_HASH_BITS \
+	(32 - FANOTIFY_EVENT_TYPE_BITS)
+
 struct fanotify_event {
 	struct fsnotify_event fse;
 	u32 mask;
-	enum fanotify_event_type type;
+	struct {
+		unsigned int type : FANOTIFY_EVENT_TYPE_BITS;
+		unsigned int hash : FANOTIFY_EVENT_HASH_BITS;
+	};
 	struct pid *pid;
 };
 
 static inline void fanotify_init_event(struct fanotify_event *event,
-				       unsigned long id, u32 mask)
+				       unsigned int hash, u32 mask)
 {
-	fsnotify_init_event(&event->fse, id);
+	fsnotify_init_event(&event->fse);
+	event->hash = hash;
 	event->mask = mask;
 	event->pid = NULL;
 }
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 66991c7fef9e2..e2b124c0081dc 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -114,7 +114,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 		mask &= ~IN_ISDIR;
 
 	fsn_event = &event->fse;
-	fsnotify_init_event(fsn_event, 0);
+	fsnotify_init_event(fsn_event);
 	event->mask = mask;
 	event->wd = wd;
 	event->sync_cookie = cookie;
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index c2018983832e5..62cd91bc00b83 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -641,7 +641,7 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 		return ERR_PTR(-ENOMEM);
 	}
 	group->overflow_event = &oevent->fse;
-	fsnotify_init_event(group->overflow_event, 0);
+	fsnotify_init_event(group->overflow_event);
 	oevent->mask = FS_Q_OVERFLOW;
 	oevent->wd = -1;
 	oevent->sync_cookie = 0;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 7eb979bfc1413..fc98f9f88d126 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -167,7 +167,6 @@ struct fsnotify_ops {
  */
 struct fsnotify_event {
 	struct list_head list;
-	unsigned long objectid;	/* identifier for queue merges */
 };
 
 /*
@@ -582,11 +581,9 @@ extern void fsnotify_put_mark(struct fsnotify_mark *mark);
 extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
 extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
 
-static inline void fsnotify_init_event(struct fsnotify_event *event,
-				       unsigned long objectid)
+static inline void fsnotify_init_event(struct fsnotify_event *event)
 {
 	INIT_LIST_HEAD(&event->list);
-	event->objectid = objectid;
 }
 
 #else
-- 
2.43.0




