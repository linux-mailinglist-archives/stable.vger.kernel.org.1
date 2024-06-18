Return-Path: <stable+bounces-53081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0AA90D018
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207021C23B76
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF601304A3;
	Tue, 18 Jun 2024 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S91GfDX1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD941153BD7;
	Tue, 18 Jun 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715272; cv=none; b=VktbP/h2EM17kk67jRqCT2rfO7tnGEQ5qiC8J3s5s7E7qrgN2lOUeCrDhEh9sVXmN3TFOV3DityTmf0MSc/PwEYWJEBypp+iMI5ONyClQPhnQlijDGKMVCgKYZ6FqBPL0Qhy8+7yLofeN+4uGb8K9Xbq5y85v0Mo+N7pYw9fVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715272; c=relaxed/simple;
	bh=szEgxiOmOJE1ZT3JwQBX2xemnWLWSvMGolD/lPAtzxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPfqyDwajoEAF3fCqBiyLacOWUslMGlenmr6CkZxSF4tE/M0HrVGBERX1cI5BsLlkDC62fNMHgyWdC4MSyQWifZEPXT47aaLGS+NjZVkC3bG+ijlLLkzeFLDPdCkEv+1T1TXP86qitdIL517s3HjuFjD9+fltaO4NTvU2aiT2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S91GfDX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4905BC3277B;
	Tue, 18 Jun 2024 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715271;
	bh=szEgxiOmOJE1ZT3JwQBX2xemnWLWSvMGolD/lPAtzxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S91GfDX169IBH4ftvYiaVkdqwO6W1TslbEzar0tdYfIbjjc6Ju2wlRt0jSLZemgIN
	 Oecjrj2ECxXIro+S4IJnTRjjTzPEEtcJnE8uQngLrsf3kQdCudRfddLbF1tROWh7+B
	 7dFCe+qJyzZiUvSB6DLS5+/CFcQdEKKCXPpEWt/Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 253/770] fsnotify: use hash table for faster events merge
Date: Tue, 18 Jun 2024 14:31:46 +0200
Message-ID: <20240618123417.042011398@linuxfoundation.org>
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

[ Upstream commit 94e00d28a680dff18805ca472b191364347d2234 ]

In order to improve event merge performance, hash events in a 128 size
hash table by the event merge key.

The fanotify_event size grows by two pointers, but we just reduced its
size by removing the objectid member, so overall its size is increased
by one pointer.

Permission events and overflow event are not merged so they are also
not hashed.

Link: https://lore.kernel.org/r/20210304104826.3993892-5-amir73il@gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify.c        | 40 +++++++++++++++++++++++-----
 fs/notify/fanotify/fanotify.h        | 25 +++++++++++++++++
 fs/notify/fanotify/fanotify_user.c   | 39 +++++++++++++++++++++++++++
 fs/notify/inotify/inotify_fsnotify.c |  7 ++---
 fs/notify/notification.c             | 22 ++++++++++-----
 include/linux/fsnotify_backend.h     | 10 ++++---
 6 files changed, 123 insertions(+), 20 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 43a606f153702..50b3abc062156 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -149,12 +149,15 @@ static bool fanotify_should_merge(struct fanotify_event *old,
 }
 
 /* and the list better be locked by something too! */
-static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
+static int fanotify_merge(struct fsnotify_group *group,
+			  struct fsnotify_event *event)
 {
-	struct fsnotify_event *test_event;
 	struct fanotify_event *old, *new = FANOTIFY_E(event);
+	unsigned int bucket = fanotify_event_hash_bucket(group, new);
+	struct hlist_head *hlist = &group->fanotify_data.merge_hash[bucket];
 
-	pr_debug("%s: list=%p event=%p\n", __func__, list, event);
+	pr_debug("%s: group=%p event=%p bucket=%u\n", __func__,
+		 group, event, bucket);
 
 	/*
 	 * Don't merge a permission event with any other event so that we know
@@ -164,8 +167,7 @@ static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
 	if (fanotify_is_perm_event(new->mask))
 		return 0;
 
-	list_for_each_entry_reverse(test_event, list, list) {
-		old = FANOTIFY_E(test_event);
+	hlist_for_each_entry(old, hlist, merge_list) {
 		if (fanotify_should_merge(old, new)) {
 			old->mask |= new->mask;
 			return 1;
@@ -203,8 +205,11 @@ static int fanotify_get_response(struct fsnotify_group *group,
 			return ret;
 		}
 		/* Event not yet reported? Just remove it. */
-		if (event->state == FAN_EVENT_INIT)
+		if (event->state == FAN_EVENT_INIT) {
 			fsnotify_remove_queued_event(group, &event->fae.fse);
+			/* Permission events are not supposed to be hashed */
+			WARN_ON_ONCE(!hlist_unhashed(&event->fae.merge_list));
+		}
 		/*
 		 * Event may be also answered in case signal delivery raced
 		 * with wakeup. In that case we have nothing to do besides
@@ -679,6 +684,24 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 	return fsid;
 }
 
+/*
+ * Add an event to hash table for faster merge.
+ */
+static void fanotify_insert_event(struct fsnotify_group *group,
+				  struct fsnotify_event *fsn_event)
+{
+	struct fanotify_event *event = FANOTIFY_E(fsn_event);
+	unsigned int bucket = fanotify_event_hash_bucket(group, event);
+	struct hlist_head *hlist = &group->fanotify_data.merge_hash[bucket];
+
+	assert_spin_locked(&group->notification_lock);
+
+	pr_debug("%s: group=%p event=%p bucket=%u\n", __func__,
+		 group, event, bucket);
+
+	hlist_add_head(&event->merge_list, hlist);
+}
+
 static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 				 const void *data, int data_type,
 				 struct inode *dir,
@@ -749,7 +772,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	}
 
 	fsn_event = &event->fse;
-	ret = fsnotify_add_event(group, fsn_event, fanotify_merge);
+	ret = fsnotify_add_event(group, fsn_event, fanotify_merge,
+				 fanotify_is_hashed_event(mask) ?
+				 fanotify_insert_event : NULL);
 	if (ret) {
 		/* Permission events shouldn't be merged */
 		BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
@@ -772,6 +797,7 @@ static void fanotify_free_group_priv(struct fsnotify_group *group)
 {
 	struct user_struct *user;
 
+	kfree(group->fanotify_data.merge_hash);
 	user = group->fanotify_data.user;
 	atomic_dec(&user->fanotify_listeners);
 	free_uid(user);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 9871f76cd9c2c..4a5e555dc3d25 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -3,6 +3,7 @@
 #include <linux/path.h>
 #include <linux/slab.h>
 #include <linux/exportfs.h>
+#include <linux/hashtable.h>
 
 extern struct kmem_cache *fanotify_mark_cache;
 extern struct kmem_cache *fanotify_fid_event_cachep;
@@ -150,6 +151,7 @@ enum fanotify_event_type {
 
 struct fanotify_event {
 	struct fsnotify_event fse;
+	struct hlist_node merge_list;	/* List for hashed merge */
 	u32 mask;
 	struct {
 		unsigned int type : FANOTIFY_EVENT_TYPE_BITS;
@@ -162,6 +164,7 @@ static inline void fanotify_init_event(struct fanotify_event *event,
 				       unsigned int hash, u32 mask)
 {
 	fsnotify_init_event(&event->fse);
+	INIT_HLIST_NODE(&event->merge_list);
 	event->hash = hash;
 	event->mask = mask;
 	event->pid = NULL;
@@ -299,3 +302,25 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
 	else
 		return NULL;
 }
+
+/*
+ * Use 128 size hash table to speed up events merge.
+ */
+#define FANOTIFY_HTABLE_BITS	(7)
+#define FANOTIFY_HTABLE_SIZE	(1 << FANOTIFY_HTABLE_BITS)
+#define FANOTIFY_HTABLE_MASK	(FANOTIFY_HTABLE_SIZE - 1)
+
+/*
+ * Permission events and overflow event do not get merged - don't hash them.
+ */
+static inline bool fanotify_is_hashed_event(u32 mask)
+{
+	return !fanotify_is_perm_event(mask) && !(mask & FS_Q_OVERFLOW);
+}
+
+static inline unsigned int fanotify_event_hash_bucket(
+						struct fsnotify_group *group,
+						struct fanotify_event *event)
+{
+	return event->hash & FANOTIFY_HTABLE_MASK;
+}
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 30651e8d1a6d5..1456470d0c4c6 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -89,6 +89,23 @@ static int fanotify_event_info_len(unsigned int fid_mode,
 	return info_len;
 }
 
+/*
+ * Remove an hashed event from merge hash table.
+ */
+static void fanotify_unhash_event(struct fsnotify_group *group,
+				  struct fanotify_event *event)
+{
+	assert_spin_locked(&group->notification_lock);
+
+	pr_debug("%s: group=%p event=%p bucket=%u\n", __func__,
+		 group, event, fanotify_event_hash_bucket(group, event));
+
+	if (WARN_ON_ONCE(hlist_unhashed(&event->merge_list)))
+		return;
+
+	hlist_del_init(&event->merge_list);
+}
+
 /*
  * Get an fanotify notification event if one exists and is small
  * enough to fit in "count". Return an error pointer if the count
@@ -126,6 +143,8 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 	fsnotify_remove_first_event(group);
 	if (fanotify_is_perm_event(event->mask))
 		FANOTIFY_PERM(event)->state = FAN_EVENT_REPORTED;
+	if (fanotify_is_hashed_event(event->mask))
+		fanotify_unhash_event(group, event);
 out:
 	spin_unlock(&group->notification_lock);
 	return event;
@@ -925,6 +944,20 @@ static struct fsnotify_event *fanotify_alloc_overflow_event(void)
 	return &oevent->fse;
 }
 
+static struct hlist_head *fanotify_alloc_merge_hash(void)
+{
+	struct hlist_head *hash;
+
+	hash = kmalloc(sizeof(struct hlist_head) << FANOTIFY_HTABLE_BITS,
+		       GFP_KERNEL_ACCOUNT);
+	if (!hash)
+		return NULL;
+
+	__hash_init(hash, FANOTIFY_HTABLE_SIZE);
+
+	return hash;
+}
+
 /* fanotify syscalls */
 SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 {
@@ -993,6 +1026,12 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	atomic_inc(&user->fanotify_listeners);
 	group->memcg = get_mem_cgroup_from_mm(current->mm);
 
+	group->fanotify_data.merge_hash = fanotify_alloc_merge_hash();
+	if (!group->fanotify_data.merge_hash) {
+		fd = -ENOMEM;
+		goto out_destroy_group;
+	}
+
 	group->overflow_event = fanotify_alloc_overflow_event();
 	if (unlikely(!group->overflow_event)) {
 		fd = -ENOMEM;
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index e2b124c0081dc..b0530f75b274a 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -46,9 +46,10 @@ static bool event_compare(struct fsnotify_event *old_fsn,
 	return false;
 }
 
-static int inotify_merge(struct list_head *list,
-			  struct fsnotify_event *event)
+static int inotify_merge(struct fsnotify_group *group,
+			 struct fsnotify_event *event)
 {
+	struct list_head *list = &group->notification_list;
 	struct fsnotify_event *last_event;
 
 	last_event = list_entry(list->prev, struct fsnotify_event, list);
@@ -122,7 +123,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	if (len)
 		strcpy(event->name, name->name);
 
-	ret = fsnotify_add_event(group, fsn_event, inotify_merge);
+	ret = fsnotify_add_event(group, fsn_event, inotify_merge, NULL);
 	if (ret) {
 		/* Our event wasn't used in the end. Free it. */
 		fsnotify_destroy_event(group, fsn_event);
diff --git a/fs/notify/notification.c b/fs/notify/notification.c
index 001cfe7d2e4e7..32f45543b9c64 100644
--- a/fs/notify/notification.c
+++ b/fs/notify/notification.c
@@ -68,16 +68,22 @@ void fsnotify_destroy_event(struct fsnotify_group *group,
 }
 
 /*
- * Add an event to the group notification queue.  The group can later pull this
- * event off the queue to deal with.  The function returns 0 if the event was
- * added to the queue, 1 if the event was merged with some other queued event,
+ * Try to add an event to the notification queue.
+ * The group can later pull this event off the queue to deal with.
+ * The group can use the @merge hook to merge the event with a queued event.
+ * The group can use the @insert hook to insert the event into hash table.
+ * The function returns:
+ * 0 if the event was added to a queue
+ * 1 if the event was merged with some other queued event
  * 2 if the event was not queued - either the queue of events has overflown
- * or the group is shutting down.
+ *   or the group is shutting down.
  */
 int fsnotify_add_event(struct fsnotify_group *group,
 		       struct fsnotify_event *event,
-		       int (*merge)(struct list_head *,
-				    struct fsnotify_event *))
+		       int (*merge)(struct fsnotify_group *,
+				    struct fsnotify_event *),
+		       void (*insert)(struct fsnotify_group *,
+				      struct fsnotify_event *))
 {
 	int ret = 0;
 	struct list_head *list = &group->notification_list;
@@ -104,7 +110,7 @@ int fsnotify_add_event(struct fsnotify_group *group,
 	}
 
 	if (!list_empty(list) && merge) {
-		ret = merge(list, event);
+		ret = merge(group, event);
 		if (ret) {
 			spin_unlock(&group->notification_lock);
 			return ret;
@@ -114,6 +120,8 @@ int fsnotify_add_event(struct fsnotify_group *group,
 queue:
 	group->q_len++;
 	list_add_tail(&event->list, list);
+	if (insert)
+		insert(group, event);
 	spin_unlock(&group->notification_lock);
 
 	wake_up(&group->notification_waitq);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index fc98f9f88d126..63fb766f0f3ec 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -233,6 +233,8 @@ struct fsnotify_group {
 #endif
 #ifdef CONFIG_FANOTIFY
 		struct fanotify_group_private_data {
+			/* Hash table of events for merge */
+			struct hlist_head *merge_hash;
 			/* allows a group to block waiting for a userspace response */
 			struct list_head access_list;
 			wait_queue_head_t access_waitq;
@@ -486,12 +488,14 @@ extern void fsnotify_destroy_event(struct fsnotify_group *group,
 /* attach the event to the group notification queue */
 extern int fsnotify_add_event(struct fsnotify_group *group,
 			      struct fsnotify_event *event,
-			      int (*merge)(struct list_head *,
-					   struct fsnotify_event *));
+			      int (*merge)(struct fsnotify_group *,
+					   struct fsnotify_event *),
+			      void (*insert)(struct fsnotify_group *,
+					     struct fsnotify_event *));
 /* Queue overflow event to a notification group */
 static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
 {
-	fsnotify_add_event(group, group->overflow_event, NULL);
+	fsnotify_add_event(group, group->overflow_event, NULL, NULL);
 }
 
 static inline bool fsnotify_notify_queue_is_empty(struct fsnotify_group *group)
-- 
2.43.0




