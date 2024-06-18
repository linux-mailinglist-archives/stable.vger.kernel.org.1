Return-Path: <stable+bounces-53238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420D790D0C9
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466B01C23E46
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF0E18E740;
	Tue, 18 Jun 2024 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GeUYUUdn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F114A0A7;
	Tue, 18 Jun 2024 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715737; cv=none; b=BmHBkW97/OkwPoDmceL22iLADaZoOxdvyVF2Ns5XIsRx7xU/N8z+LOWqp+ZQXAnO+G4XCFw+j4AsuROBjWMfFfioPe84wK1eUmMc+/jxCZFV8N6UTCQqI/g/QYpDzJImvtJYAZ1qt859qX3wGmBj29J9rW2gRhYgoBmye5jna1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715737; c=relaxed/simple;
	bh=jfjYCKmiLLL54iUSybo36fBY5HJWK3bM7RiNg7tIn88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjaWW1Hew/HhT8EOJc99DEdUMriFXUrRnmIP3qotSxDwZzu1oQoQiz1O+Mh0nnoOB2QeMLWJUWp5+iJ6YGFRVL3UXhWvprSAI/1ehsAMw+Yq4STrgDWVYKpiJvdkr+utmEGBDh8mmcMgtMkvnTP3+nUVuvW/Q/LPdgMlAGZeYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GeUYUUdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A69C3277B;
	Tue, 18 Jun 2024 13:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715736;
	bh=jfjYCKmiLLL54iUSybo36fBY5HJWK3bM7RiNg7tIn88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GeUYUUdnKPbWL6ITUIOVmTLL3TlAnKw1iZoywjGA3TzN07F6pKZySmzdllK0IZ8p6
	 8NetoXhGnaaJiqD2qJm376aEBi7H/V1m9fcTLEAth2DoSGUX/mTLkPVQWoRjPTost6
	 KAFMmrg2Ukl+jNWt/jDM5Hh92E44Lz4X7ZCZf7yY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 408/770] fsnotify: generate FS_RENAME event with rich information
Date: Tue, 18 Jun 2024 14:34:21 +0200
Message-ID: <20240618123423.036246192@linuxfoundation.org>
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

[ Upstream commit e54183fa7047c15819bc155f4c58501d9a9a3489 ]

The dnotify FS_DN_RENAME event is used to request notification about
a move within the same parent directory and was always coupled with
the FS_MOVED_FROM event.

Rename the FS_DN_RENAME event flag to FS_RENAME, decouple it from
FS_MOVED_FROM and report it with the moved dentry instead of the moved
inode, so it has the information about both old and new parent and name.

Generate the FS_RENAME event regardless of same parent dir and apply
the "same parent" rule in the generic fsnotify_handle_event() helper
that is used to call backends with ->handle_inode_event() method
(i.e. dnotify).  The ->handle_inode_event() method is not rich enough to
report both old and new parent and name anyway.

The enriched event is reported to fanotify over the ->handle_event()
method with the old and new dir inode marks in marks array slots for
ITER_TYPE_INODE and a new iter type slot ITER_TYPE_INODE2.

The enriched event will be used for reporting old and new parent+name to
fanotify groups with FAN_RENAME events.

Link: https://lore.kernel.org/r/20211129201537.1932819-5-amir73il@gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/dnotify/dnotify.c      |  2 +-
 fs/notify/fsnotify.c             | 37 +++++++++++++++++++++++++-------
 include/linux/dnotify.h          |  2 +-
 include/linux/fsnotify.h         |  9 +++++---
 include/linux/fsnotify_backend.h |  7 +++---
 5 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index e85e13c50d6d4..d5ebebb034ffe 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -196,7 +196,7 @@ static __u32 convert_arg(unsigned long arg)
 	if (arg & DN_ATTRIB)
 		new_mask |= FS_ATTRIB;
 	if (arg & DN_RENAME)
-		new_mask |= FS_DN_RENAME;
+		new_mask |= FS_RENAME;
 	if (arg & DN_CREATE)
 		new_mask |= (FS_CREATE | FS_MOVED_TO);
 
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 0c94457c625e2..ab81a0776ece5 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -279,6 +279,18 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
 	    WARN_ON_ONCE(fsnotify_iter_vfsmount_mark(iter_info)))
 		return 0;
 
+	/*
+	 * For FS_RENAME, 'dir' is old dir and 'data' is new dentry.
+	 * The only ->handle_inode_event() backend that supports FS_RENAME is
+	 * dnotify, where it means file was renamed within same parent.
+	 */
+	if (mask & FS_RENAME) {
+		struct dentry *moved = fsnotify_data_dentry(data, data_type);
+
+		if (dir != moved->d_parent->d_inode)
+			return 0;
+	}
+
 	if (parent_mark) {
 		/*
 		 * parent_mark indicates that the parent inode is watching
@@ -469,7 +481,9 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	struct super_block *sb = fsnotify_data_sb(data, data_type);
 	struct fsnotify_iter_info iter_info = {};
 	struct mount *mnt = NULL;
-	struct inode *parent = NULL;
+	struct inode *inode2 = NULL;
+	struct dentry *moved;
+	int inode2_type;
 	int ret = 0;
 	__u32 test_mask, marks_mask;
 
@@ -479,12 +493,19 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	if (!inode) {
 		/* Dirent event - report on TYPE_INODE to dir */
 		inode = dir;
+		/* For FS_RENAME, inode is old_dir and inode2 is new_dir */
+		if (mask & FS_RENAME) {
+			moved = fsnotify_data_dentry(data, data_type);
+			inode2 = moved->d_parent->d_inode;
+			inode2_type = FSNOTIFY_ITER_TYPE_INODE2;
+		}
 	} else if (mask & FS_EVENT_ON_CHILD) {
 		/*
 		 * Event on child - report on TYPE_PARENT to dir if it is
 		 * watching children and on TYPE_INODE to child.
 		 */
-		parent = dir;
+		inode2 = dir;
+		inode2_type = FSNOTIFY_ITER_TYPE_PARENT;
 	}
 
 	/*
@@ -497,7 +518,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	if (!sb->s_fsnotify_marks &&
 	    (!mnt || !mnt->mnt_fsnotify_marks) &&
 	    (!inode || !inode->i_fsnotify_marks) &&
-	    (!parent || !parent->i_fsnotify_marks))
+	    (!inode2 || !inode2->i_fsnotify_marks))
 		return 0;
 
 	marks_mask = sb->s_fsnotify_mask;
@@ -505,8 +526,8 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		marks_mask |= mnt->mnt_fsnotify_mask;
 	if (inode)
 		marks_mask |= inode->i_fsnotify_mask;
-	if (parent)
-		marks_mask |= parent->i_fsnotify_mask;
+	if (inode2)
+		marks_mask |= inode2->i_fsnotify_mask;
 
 
 	/*
@@ -529,9 +550,9 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		iter_info.marks[FSNOTIFY_ITER_TYPE_INODE] =
 			fsnotify_first_mark(&inode->i_fsnotify_marks);
 	}
-	if (parent) {
-		iter_info.marks[FSNOTIFY_ITER_TYPE_PARENT] =
-			fsnotify_first_mark(&parent->i_fsnotify_marks);
+	if (inode2) {
+		iter_info.marks[inode2_type] =
+			fsnotify_first_mark(&inode2->i_fsnotify_marks);
 	}
 
 	/*
diff --git a/include/linux/dnotify.h b/include/linux/dnotify.h
index 0aad774beaec4..b87c3b85a166c 100644
--- a/include/linux/dnotify.h
+++ b/include/linux/dnotify.h
@@ -26,7 +26,7 @@ struct dnotify_struct {
 			    FS_MODIFY | FS_MODIFY_CHILD |\
 			    FS_ACCESS | FS_ACCESS_CHILD |\
 			    FS_ATTRIB | FS_ATTRIB_CHILD |\
-			    FS_CREATE | FS_DN_RENAME |\
+			    FS_CREATE | FS_RENAME |\
 			    FS_MOVED_FROM | FS_MOVED_TO)
 
 extern int dir_notify_enable;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index bec1e23ecf787..bb8467cd11ae2 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -144,16 +144,19 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 	u32 fs_cookie = fsnotify_get_cookie();
 	__u32 old_dir_mask = FS_MOVED_FROM;
 	__u32 new_dir_mask = FS_MOVED_TO;
+	__u32 rename_mask = FS_RENAME;
 	const struct qstr *new_name = &moved->d_name;
 
-	if (old_dir == new_dir)
-		old_dir_mask |= FS_DN_RENAME;
-
 	if (isdir) {
 		old_dir_mask |= FS_ISDIR;
 		new_dir_mask |= FS_ISDIR;
+		rename_mask |= FS_ISDIR;
 	}
 
+	/* Event with information about both old and new parent+name */
+	fsnotify_name(rename_mask, moved, FSNOTIFY_EVENT_DENTRY,
+		      old_dir, old_name, 0);
+
 	fsnotify_name(old_dir_mask, source, FSNOTIFY_EVENT_INODE,
 		      old_dir, old_name, fs_cookie);
 	fsnotify_name(new_dir_mask, source, FSNOTIFY_EVENT_INODE,
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 73739fee1710f..790c31844db5d 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -63,7 +63,7 @@
  */
 #define FS_EVENT_ON_CHILD	0x08000000
 
-#define FS_DN_RENAME		0x10000000	/* file renamed */
+#define FS_RENAME		0x10000000	/* File was renamed */
 #define FS_DN_MULTISHOT		0x20000000	/* dnotify multishot */
 #define FS_ISDIR		0x40000000	/* event occurred against dir */
 #define FS_IN_ONESHOT		0x80000000	/* only send event once */
@@ -76,7 +76,7 @@
  * The watching parent may get an FS_ATTRIB|FS_EVENT_ON_CHILD event
  * when a directory entry inside a child subdir changes.
  */
-#define ALL_FSNOTIFY_DIRENT_EVENTS	(FS_CREATE | FS_DELETE | FS_MOVE)
+#define ALL_FSNOTIFY_DIRENT_EVENTS (FS_CREATE | FS_DELETE | FS_MOVE | FS_RENAME)
 
 #define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
 				  FS_OPEN_EXEC_PERM)
@@ -101,7 +101,7 @@
 /* Events that can be reported to backends */
 #define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
 			     FS_EVENTS_POSS_ON_CHILD | \
-			     FS_DELETE_SELF | FS_MOVE_SELF | FS_DN_RENAME | \
+			     FS_DELETE_SELF | FS_MOVE_SELF | \
 			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
 			     FS_ERROR)
 
@@ -349,6 +349,7 @@ enum fsnotify_iter_type {
 	FSNOTIFY_ITER_TYPE_VFSMOUNT,
 	FSNOTIFY_ITER_TYPE_SB,
 	FSNOTIFY_ITER_TYPE_PARENT,
+	FSNOTIFY_ITER_TYPE_INODE2,
 	FSNOTIFY_ITER_TYPE_COUNT
 };
 
-- 
2.43.0




