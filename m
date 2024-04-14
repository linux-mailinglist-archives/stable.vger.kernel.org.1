Return-Path: <stable+bounces-37282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04F489C431
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C4F282485
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DCB85939;
	Mon,  8 Apr 2024 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bjDMplNk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A8A7E115;
	Mon,  8 Apr 2024 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583780; cv=none; b=MQdlqFEQxwrXoGOma6dImUCGYXSY6KSw0KtyCh66Utf73SUUZO95p8t4pO0sN5DK/xAUrtjp6glTAySfp4qVegK19/LTMl+Mo7LcK6pzHKmOahcOvACaGGWgTJkaFAaxrAPx8I9PQun95Z2SmuNxeviOVI5bQzf6qx2Id9TXJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583780; c=relaxed/simple;
	bh=SpjgU63Kaa0vP7c8YLQ6k77n+LaT6oBSSUzSrOasf7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWl6Tr7ONoy68HlfmiW7YaJ91K+U1vTt7igvTJphVGcFvPDmIJ8/+66qRhA41UT7ubDLcwBL8vtyglly2cE1J44lqQmcMc7dBXHRa5PItUmb84/rvIsQ1xIyVy9GMsThmYUJT42Bj5/rEzZuIO/+rTUVMP/Bo2T2lyt+/fNTpfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bjDMplNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3211BC433F1;
	Mon,  8 Apr 2024 13:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583780;
	bh=SpjgU63Kaa0vP7c8YLQ6k77n+LaT6oBSSUzSrOasf7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bjDMplNk011mUIwL3bR32k1Kq0XeWGDoH+9x4yn6A7CCKHIEkTObqioku74/dPvYt
	 u3QoUuWOjeT8k6tWJitzQjE6rLRZkgz02XLOsForKNCbS0XevvQNelGTJaDNf8zRyd
	 1pT2ArdIqBNGWY9qZ6/ibBU+6wV1lSRveW0VT/p4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 284/690] fsnotify: optimize FS_MODIFY events with no ignored masks
Date: Mon,  8 Apr 2024 14:52:30 +0200
Message-ID: <20240408125409.903614022@linuxfoundation.org>
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

[ Upstream commit 04e317ba72d07901b03399b3d1525e83424df5b3 ]

fsnotify() treats FS_MODIFY events specially - it does not skip them
even if the FS_MODIFY event does not apear in the object's fsnotify
mask.  This is because send_to_group() checks if FS_MODIFY needs to
clear ignored mask of marks.

The common case is that an object does not have any mark with ignored
mask and in particular, that it does not have a mark with ignored mask
and without the FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY flag.

Set FS_MODIFY in object's fsnotify mask during fsnotify_recalc_mask()
if object has a mark with an ignored mask and without the
FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY flag and remove the special
treatment of FS_MODIFY in fsnotify(), so that FS_MODIFY events could
be optimized in the common case.

Call fsnotify_recalc_mask() from fanotify after adding or removing an
ignored mask from a mark without FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY
or when adding the FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY flag to a mark
with ignored mask (the flag cannot be removed by fanotify uapi).

Performance results for doing 10000000 write(2)s to tmpfs:

				vanilla		patched
without notification mark	25.486+-1.054	24.965+-0.244
with notification mark		30.111+-0.139	26.891+-1.355

So we can see the overhead of notification subsystem has been
drastically reduced.

Link: https://lore.kernel.org/r/20220223151438.790268-3-amir73il@gmail.com
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/notify/fanotify/fanotify_user.c | 32 +++++++++++++++++++++++-------
 fs/notify/fsnotify.c               |  8 +++++---
 include/linux/fsnotify_backend.h   |  4 ++++
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9ed9d7f6c2b50..4f607fd793f3a 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1077,8 +1077,28 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
 				    flags, umask);
 }
 
+static void fanotify_mark_add_ignored_mask(struct fsnotify_mark *fsn_mark,
+					   __u32 mask, unsigned int flags,
+					   __u32 *removed)
+{
+	fsn_mark->ignored_mask |= mask;
+
+	/*
+	 * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may lead to
+	 * the removal of the FS_MODIFY bit in calculated mask if it was set
+	 * because of an ignored mask that is now going to survive FS_MODIFY.
+	 */
+	if ((flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
+	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)) {
+		fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY;
+		if (!(fsn_mark->mask & FS_MODIFY))
+			*removed = FS_MODIFY;
+	}
+}
+
 static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
-				       __u32 mask, unsigned int flags)
+				       __u32 mask, unsigned int flags,
+				       __u32 *removed)
 {
 	__u32 oldmask, newmask;
 
@@ -1087,9 +1107,7 @@ static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 	if (!(flags & FAN_MARK_IGNORED_MASK)) {
 		fsn_mark->mask |= mask;
 	} else {
-		fsn_mark->ignored_mask |= mask;
-		if (flags & FAN_MARK_IGNORED_SURV_MODIFY)
-			fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY;
+		fanotify_mark_add_ignored_mask(fsn_mark, mask, flags, removed);
 	}
 	newmask = fsnotify_calc_mask(fsn_mark);
 	spin_unlock(&fsn_mark->lock);
@@ -1152,7 +1170,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			     __kernel_fsid_t *fsid)
 {
 	struct fsnotify_mark *fsn_mark;
-	__u32 added;
+	__u32 added, removed = 0;
 	int ret = 0;
 
 	mutex_lock(&group->mark_mutex);
@@ -1175,8 +1193,8 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			goto out;
 	}
 
-	added = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
-	if (added & ~fsnotify_conn_mask(fsn_mark->connector))
+	added = fanotify_mark_add_to_mask(fsn_mark, mask, flags, &removed);
+	if (removed || (added & ~fsnotify_conn_mask(fsn_mark->connector)))
 		fsnotify_recalc_mask(fsn_mark->connector);
 
 out:
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index ab81a0776ece5..494f653efbc6e 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -531,11 +531,13 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 
 
 	/*
-	 * if this is a modify event we may need to clear the ignored masks
-	 * otherwise return if none of the marks care about this type of event.
+	 * If this is a modify event we may need to clear some ignored masks.
+	 * In that case, the object with ignored masks will have the FS_MODIFY
+	 * event in its mask.
+	 * Otherwise, return if none of the marks care about this type of event.
 	 */
 	test_mask = (mask & ALL_FSNOTIFY_EVENTS);
-	if (!(mask & FS_MODIFY) && !(test_mask & marks_mask))
+	if (!(test_mask & marks_mask))
 		return 0;
 
 	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 5f9c960049b07..0805b74cae441 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -609,6 +609,10 @@ static inline __u32 fsnotify_calc_mask(struct fsnotify_mark *mark)
 	if (!mark->ignored_mask)
 		return mask;
 
+	/* Interest in FS_MODIFY may be needed for clearing ignored mask */
+	if (!(mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
+		mask |= FS_MODIFY;
+
 	/*
 	 * If mark is interested in ignoring events on children, the object must
 	 * show interest in those events for fsnotify_parent() to notice it.
-- 
2.43.0




