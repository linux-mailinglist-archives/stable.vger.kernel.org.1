Return-Path: <stable+bounces-37082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FAB89C339
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63951C22051
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4103881AB4;
	Mon,  8 Apr 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wNbMR+Fa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D9E81754;
	Mon,  8 Apr 2024 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583198; cv=none; b=Ir5mB2Iv2FR+pTTR8lcchMKoH8rSX+hn91bM4Ol2w9LogCFTCPtsxXqX09lk2Lx+mNj7md26c1qgzDWmgFmiR0u7AJzN7ldPtRHbo0ltdtY1+KKQxNt4+XcTjXLBlpmRndjqvd/jcSrwip8EEhoun4IZ1geF+0PS6FYRoJRLhoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583198; c=relaxed/simple;
	bh=Bh5ToopYyg/eEYJzjuxg9lHSNUrTPJq7mjC+yEiASEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btZ77rNzwXcDDncGHrknGsodzyvqr45Bx7EGI+8KOGn6bJ78GtqEblEVu3EIJg9KiJFK0Prx2z+iw76rkNCTKvKf7AWd8rzBeS+HYm363K23z6sBx71PqcQ7osA0DiYOSfTMLmYh6wYcX4HMhUEz4HwvdRGoKvkAriPjZ8FEsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wNbMR+Fa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD97C43390;
	Mon,  8 Apr 2024 13:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583197;
	bh=Bh5ToopYyg/eEYJzjuxg9lHSNUrTPJq7mjC+yEiASEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wNbMR+Faqo2oqVSokB4LKv2qASTpWEPcCP/Vp15i/Mf69eb59RjltujPV/U/ulXBi
	 AeBQiiF4f/pGSuGYTGIyczJuxPmO5dZQ/KLGTbX50reklGN40RZzXIA810RMJoobbh
	 7IvUbq2X+taBxhBRjl8RTN6b/JCdQJvYg4n+6twk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 221/690] fanotify: record either old name new name or both for FAN_RENAME
Date: Mon,  8 Apr 2024 14:51:27 +0200
Message-ID: <20240408125407.556826137@linuxfoundation.org>
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

[ Upstream commit 2bfbcccde6e7a787feabad4645f628f963fe0663 ]

We do not want to report the dirfid+name of a directory whose
inode/sb are not watched, because watcher may not have permissions
to see the directory content.

Use an internal iter_info to indicate to fanotify_alloc_event()
which marks of this group are watching FAN_RENAME, so it can decide
if we need to record only the old parent+name, new parent+name or both.

Link: https://lore.kernel.org/r/20211129201537.1932819-10-amir73il@gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[JK: Modified code to pass around only mask of mark types matching
generated event]
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/notify/fanotify/fanotify.c | 59 ++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index db81eab905442..14bc0f12cc9f3 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -284,8 +284,9 @@ static int fanotify_get_response(struct fsnotify_group *group,
  */
 static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 				     struct fsnotify_iter_info *iter_info,
-				     u32 event_mask, const void *data,
-				     int data_type, struct inode *dir)
+				     u32 *match_mask, u32 event_mask,
+				     const void *data, int data_type,
+				     struct inode *dir)
 {
 	__u32 marks_mask = 0, marks_ignored_mask = 0;
 	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
@@ -335,6 +336,9 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 			continue;
 
 		marks_mask |= mark->mask;
+
+		/* Record the mark types of this group that matched the event */
+		*match_mask |= 1U << type;
 	}
 
 	test_mask = event_mask & marks_mask & ~marks_ignored_mask;
@@ -701,11 +705,11 @@ static struct fanotify_event *fanotify_alloc_error_event(
 	return &fee->fae;
 }
 
-static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
-						   u32 mask, const void *data,
-						   int data_type, struct inode *dir,
-						   const struct qstr *file_name,
-						   __kernel_fsid_t *fsid)
+static struct fanotify_event *fanotify_alloc_event(
+				struct fsnotify_group *group,
+				u32 mask, const void *data, int data_type,
+				struct inode *dir, const struct qstr *file_name,
+				__kernel_fsid_t *fsid, u32 match_mask)
 {
 	struct fanotify_event *event = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
@@ -753,13 +757,36 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		}
 
 		/*
-		 * In the special case of FAN_RENAME event, we record both
-		 * old and new parent+name.
+		 * In the special case of FAN_RENAME event, use the match_mask
+		 * to determine if we need to report only the old parent+name,
+		 * only the new parent+name or both.
 		 * 'dirid' and 'file_name' are the old parent+name and
 		 * 'moved' has the new parent+name.
 		 */
-		if (mask & FAN_RENAME)
-			moved = fsnotify_data_dentry(data, data_type);
+		if (mask & FAN_RENAME) {
+			bool report_old, report_new;
+
+			if (WARN_ON_ONCE(!match_mask))
+				return NULL;
+
+			/* Report both old and new parent+name if sb watching */
+			report_old = report_new =
+				match_mask & (1U << FSNOTIFY_ITER_TYPE_SB);
+			report_old |=
+				match_mask & (1U << FSNOTIFY_ITER_TYPE_INODE);
+			report_new |=
+				match_mask & (1U << FSNOTIFY_ITER_TYPE_INODE2);
+
+			if (!report_old) {
+				/* Do not report old parent+name */
+				dirid = NULL;
+				file_name = NULL;
+			}
+			if (report_new) {
+				/* Report new parent+name */
+				moved = fsnotify_data_dentry(data, data_type);
+			}
+		}
 	}
 
 	/*
@@ -872,6 +899,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	struct fanotify_event *event;
 	struct fsnotify_event *fsn_event;
 	__kernel_fsid_t fsid = {};
+	u32 match_mask = 0;
 
 	BUILD_BUG_ON(FAN_ACCESS != FS_ACCESS);
 	BUILD_BUG_ON(FAN_MODIFY != FS_MODIFY);
@@ -897,12 +925,13 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 
 	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
 
-	mask = fanotify_group_event_mask(group, iter_info, mask, data,
-					 data_type, dir);
+	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
+					 mask, data, data_type, dir);
 	if (!mask)
 		return 0;
 
-	pr_debug("%s: group=%p mask=%x\n", __func__, group, mask);
+	pr_debug("%s: group=%p mask=%x report_mask=%x\n", __func__,
+		 group, mask, match_mask);
 
 	if (fanotify_is_perm_event(mask)) {
 		/*
@@ -921,7 +950,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	}
 
 	event = fanotify_alloc_event(group, mask, data, data_type, dir,
-				     file_name, &fsid);
+				     file_name, &fsid, match_mask);
 	ret = -ENOMEM;
 	if (unlikely(!event)) {
 		/*
-- 
2.43.0




