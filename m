Return-Path: <stable+bounces-37067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3EF89C552
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA3BB2F3ED
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC7580027;
	Mon,  8 Apr 2024 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kxgEW2qg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B61978285;
	Mon,  8 Apr 2024 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583157; cv=none; b=c2CMQPq4xwWG9zIuBL5GAhGiUMnAlE/pnwNkGOdFKrXgmqkWFnIucd6DjKAY/VySNEuiA5y7Gz6ErYmtvWsigEgwSb+g3OSJuoGrUqvFUkJLtyUl7iO78iaC/U9DkXA6Mq2JQrBpIYhkBGoqM2I1zypBK5DmulxT05Hiu9qYf5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583157; c=relaxed/simple;
	bh=S3Ftjr1IXYSCSOkKjOpL03yIOvoJj6NwYEyCxq/Vgs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOKfi/9u+405MkPdKebx2uiyEKm/BdPtQBOyoalxon8SHbgF8nHYdwkIzMmO/boZi3o13bnp3ZzbS7HsaM6JrXk7MrbKDEsFvw8yyK1MHwEKc5a4P1BxCluv2QMGXmd2P+W/6I++LrO4Jlc35e5XWKIVV8s9eW0jX9kpbg1kQ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kxgEW2qg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CAFC43394;
	Mon,  8 Apr 2024 13:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583157;
	bh=S3Ftjr1IXYSCSOkKjOpL03yIOvoJj6NwYEyCxq/Vgs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxgEW2qgdX3MMCF4FTWiLxOYQYL95GgvZ1jcbmeSC4iILt4qLtUpQmVXdx+n1u/KG
	 edGWqOal5/5hGlLqK6MFP0e4tmN6Q5SjfTHekHNw+Dp/N7LCY2Y5BBb0ifL++SuIpw
	 2gkfgjQJ1Pq//0P+HOkQ0Utt9jfv404stIJeteYg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 213/690] fsnotify: clarify object type argument
Date: Mon,  8 Apr 2024 14:51:19 +0200
Message-ID: <20240408125407.247825114@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit ad69cd9972e79aba103ba5365de0acd35770c265 ]

In preparation for separating object type from iterator type, rename
some 'type' arguments in functions to 'obj_type' and remove the unused
interface to clear marks by object type mask.

Link: https://lore.kernel.org/r/20211129201537.1932819-2-amir73il@gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/notify/fanotify/fanotify_user.c |  8 ++++----
 fs/notify/group.c                  |  2 +-
 fs/notify/mark.c                   | 27 +++++++++++++++------------
 include/linux/fsnotify_backend.h   | 28 ++++++++++++----------------
 4 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 58b0a7fabd4a6..e8f6c843e9204 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1057,7 +1057,7 @@ static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 						   fsnotify_connp_t *connp,
-						   unsigned int type,
+						   unsigned int obj_type,
 						   __kernel_fsid_t *fsid)
 {
 	struct ucounts *ucounts = group->fanotify_data.ucounts;
@@ -1080,7 +1080,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	}
 
 	fsnotify_init_mark(mark, group);
-	ret = fsnotify_add_mark_locked(mark, connp, type, 0, fsid);
+	ret = fsnotify_add_mark_locked(mark, connp, obj_type, 0, fsid);
 	if (ret) {
 		fsnotify_put_mark(mark);
 		goto out_dec_ucounts;
@@ -1105,7 +1105,7 @@ static int fanotify_group_init_error_pool(struct fsnotify_group *group)
 }
 
 static int fanotify_add_mark(struct fsnotify_group *group,
-			     fsnotify_connp_t *connp, unsigned int type,
+			     fsnotify_connp_t *connp, unsigned int obj_type,
 			     __u32 mask, unsigned int flags,
 			     __kernel_fsid_t *fsid)
 {
@@ -1116,7 +1116,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	mutex_lock(&group->mark_mutex);
 	fsn_mark = fsnotify_find_mark(connp, group);
 	if (!fsn_mark) {
-		fsn_mark = fanotify_add_new_mark(group, connp, type, fsid);
+		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, fsid);
 		if (IS_ERR(fsn_mark)) {
 			mutex_unlock(&group->mark_mutex);
 			return PTR_ERR(fsn_mark);
diff --git a/fs/notify/group.c b/fs/notify/group.c
index 6a297efc47887..b7d4d64f87c29 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -58,7 +58,7 @@ void fsnotify_destroy_group(struct fsnotify_group *group)
 	fsnotify_group_stop_queueing(group);
 
 	/* Clear all marks for this group and queue them for destruction */
-	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_ALL_TYPES_MASK);
+	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_ANY);
 
 	/*
 	 * Some marks can still be pinned when waiting for response from
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index bea106fac0901..7c0946e16918a 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -496,7 +496,7 @@ int fsnotify_compare_groups(struct fsnotify_group *a, struct fsnotify_group *b)
 }
 
 static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
-					       unsigned int type,
+					       unsigned int obj_type,
 					       __kernel_fsid_t *fsid)
 {
 	struct inode *inode = NULL;
@@ -507,7 +507,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		return -ENOMEM;
 	spin_lock_init(&conn->lock);
 	INIT_HLIST_HEAD(&conn->list);
-	conn->type = type;
+	conn->type = obj_type;
 	conn->obj = connp;
 	/* Cache fsid of filesystem containing the object */
 	if (fsid) {
@@ -572,7 +572,8 @@ static struct fsnotify_mark_connector *fsnotify_grab_connector(
  * priority, highest number first, and then by the group's location in memory.
  */
 static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
-				  fsnotify_connp_t *connp, unsigned int type,
+				  fsnotify_connp_t *connp,
+				  unsigned int obj_type,
 				  int allow_dups, __kernel_fsid_t *fsid)
 {
 	struct fsnotify_mark *lmark, *last = NULL;
@@ -580,7 +581,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 	int cmp;
 	int err = 0;
 
-	if (WARN_ON(!fsnotify_valid_obj_type(type)))
+	if (WARN_ON(!fsnotify_valid_obj_type(obj_type)))
 		return -EINVAL;
 
 	/* Backend is expected to check for zero fsid (e.g. tmpfs) */
@@ -592,7 +593,8 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 	conn = fsnotify_grab_connector(connp);
 	if (!conn) {
 		spin_unlock(&mark->lock);
-		err = fsnotify_attach_connector_to_object(connp, type, fsid);
+		err = fsnotify_attach_connector_to_object(connp, obj_type,
+							  fsid);
 		if (err)
 			return err;
 		goto restart;
@@ -665,7 +667,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
  * event types should be delivered to which group.
  */
 int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
-			     fsnotify_connp_t *connp, unsigned int type,
+			     fsnotify_connp_t *connp, unsigned int obj_type,
 			     int allow_dups, __kernel_fsid_t *fsid)
 {
 	struct fsnotify_group *group = mark->group;
@@ -686,7 +688,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	fsnotify_get_mark(mark); /* for g_list */
 	spin_unlock(&mark->lock);
 
-	ret = fsnotify_add_mark_list(mark, connp, type, allow_dups, fsid);
+	ret = fsnotify_add_mark_list(mark, connp, obj_type, allow_dups, fsid);
 	if (ret)
 		goto err;
 
@@ -706,13 +708,14 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 }
 
 int fsnotify_add_mark(struct fsnotify_mark *mark, fsnotify_connp_t *connp,
-		      unsigned int type, int allow_dups, __kernel_fsid_t *fsid)
+		      unsigned int obj_type, int allow_dups,
+		      __kernel_fsid_t *fsid)
 {
 	int ret;
 	struct fsnotify_group *group = mark->group;
 
 	mutex_lock(&group->mark_mutex);
-	ret = fsnotify_add_mark_locked(mark, connp, type, allow_dups, fsid);
+	ret = fsnotify_add_mark_locked(mark, connp, obj_type, allow_dups, fsid);
 	mutex_unlock(&group->mark_mutex);
 	return ret;
 }
@@ -747,14 +750,14 @@ EXPORT_SYMBOL_GPL(fsnotify_find_mark);
 
 /* Clear any marks in a group with given type mask */
 void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
-				   unsigned int type_mask)
+				   unsigned int obj_type)
 {
 	struct fsnotify_mark *lmark, *mark;
 	LIST_HEAD(to_free);
 	struct list_head *head = &to_free;
 
 	/* Skip selection step if we want to clear all marks. */
-	if (type_mask == FSNOTIFY_OBJ_ALL_TYPES_MASK) {
+	if (obj_type == FSNOTIFY_OBJ_TYPE_ANY) {
 		head = &group->marks_list;
 		goto clear;
 	}
@@ -769,7 +772,7 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
 	 */
 	mutex_lock(&group->mark_mutex);
 	list_for_each_entry_safe(mark, lmark, &group->marks_list, g_list) {
-		if ((1U << mark->connector->type) & type_mask)
+		if (mark->connector->type == obj_type)
 			list_move(&mark->g_list, &to_free);
 	}
 	mutex_unlock(&group->mark_mutex);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 51ef2b079bfa0..b9c84b1dbcc8f 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -338,6 +338,7 @@ static inline struct fs_error_report *fsnotify_data_error_report(
 }
 
 enum fsnotify_obj_type {
+	FSNOTIFY_OBJ_TYPE_ANY = -1,
 	FSNOTIFY_OBJ_TYPE_INODE,
 	FSNOTIFY_OBJ_TYPE_PARENT,
 	FSNOTIFY_OBJ_TYPE_VFSMOUNT,
@@ -346,15 +347,9 @@ enum fsnotify_obj_type {
 	FSNOTIFY_OBJ_TYPE_DETACHED = FSNOTIFY_OBJ_TYPE_COUNT
 };
 
-#define FSNOTIFY_OBJ_TYPE_INODE_FL	(1U << FSNOTIFY_OBJ_TYPE_INODE)
-#define FSNOTIFY_OBJ_TYPE_PARENT_FL	(1U << FSNOTIFY_OBJ_TYPE_PARENT)
-#define FSNOTIFY_OBJ_TYPE_VFSMOUNT_FL	(1U << FSNOTIFY_OBJ_TYPE_VFSMOUNT)
-#define FSNOTIFY_OBJ_TYPE_SB_FL		(1U << FSNOTIFY_OBJ_TYPE_SB)
-#define FSNOTIFY_OBJ_ALL_TYPES_MASK	((1U << FSNOTIFY_OBJ_TYPE_COUNT) - 1)
-
-static inline bool fsnotify_valid_obj_type(unsigned int type)
+static inline bool fsnotify_valid_obj_type(unsigned int obj_type)
 {
-	return (type < FSNOTIFY_OBJ_TYPE_COUNT);
+	return (obj_type < FSNOTIFY_OBJ_TYPE_COUNT);
 }
 
 struct fsnotify_iter_info {
@@ -387,7 +382,7 @@ static inline void fsnotify_iter_set_report_type_mark(
 static inline struct fsnotify_mark *fsnotify_iter_##name##_mark( \
 		struct fsnotify_iter_info *iter_info) \
 { \
-	return (iter_info->report_mask & FSNOTIFY_OBJ_TYPE_##NAME##_FL) ? \
+	return (iter_info->report_mask & (1U << FSNOTIFY_OBJ_TYPE_##NAME)) ? \
 		iter_info->marks[FSNOTIFY_OBJ_TYPE_##NAME] : NULL; \
 }
 
@@ -604,11 +599,11 @@ extern int fsnotify_get_conn_fsid(const struct fsnotify_mark_connector *conn,
 				  __kernel_fsid_t *fsid);
 /* attach the mark to the object */
 extern int fsnotify_add_mark(struct fsnotify_mark *mark,
-			     fsnotify_connp_t *connp, unsigned int type,
+			     fsnotify_connp_t *connp, unsigned int obj_type,
 			     int allow_dups, __kernel_fsid_t *fsid);
 extern int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 				    fsnotify_connp_t *connp,
-				    unsigned int type, int allow_dups,
+				    unsigned int obj_type, int allow_dups,
 				    __kernel_fsid_t *fsid);
 
 /* attach the mark to the inode */
@@ -637,22 +632,23 @@ extern void fsnotify_detach_mark(struct fsnotify_mark *mark);
 extern void fsnotify_free_mark(struct fsnotify_mark *mark);
 /* Wait until all marks queued for destruction are destroyed */
 extern void fsnotify_wait_marks_destroyed(void);
-/* run all the marks in a group, and clear all of the marks attached to given object type */
-extern void fsnotify_clear_marks_by_group(struct fsnotify_group *group, unsigned int type);
+/* Clear all of the marks of a group attached to a given object type */
+extern void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
+					  unsigned int obj_type);
 /* run all the marks in a group, and clear all of the vfsmount marks */
 static inline void fsnotify_clear_vfsmount_marks_by_group(struct fsnotify_group *group)
 {
-	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_VFSMOUNT_FL);
+	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_VFSMOUNT);
 }
 /* run all the marks in a group, and clear all of the inode marks */
 static inline void fsnotify_clear_inode_marks_by_group(struct fsnotify_group *group)
 {
-	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_INODE_FL);
+	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_INODE);
 }
 /* run all the marks in a group, and clear all of the sn marks */
 static inline void fsnotify_clear_sb_marks_by_group(struct fsnotify_group *group)
 {
-	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_SB_FL);
+	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_SB);
 }
 extern void fsnotify_get_mark(struct fsnotify_mark *mark);
 extern void fsnotify_put_mark(struct fsnotify_mark *mark);
-- 
2.43.0




