Return-Path: <stable+bounces-8622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE82881F771
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 12:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3E01F23552
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 11:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91D36FC7;
	Thu, 28 Dec 2023 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EGYLgBpF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D97847C
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 10:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABDCC433C7;
	Thu, 28 Dec 2023 10:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703761187;
	bh=5zZ1pxVezCULyDvUpodrMBANtc+vD4hWBG/zxpuRDQc=;
	h=Subject:To:Cc:From:Date:From;
	b=EGYLgBpF9BNkKYxO+i1q+sWjvwbAngGWTOx8g9Ytpmbj2IuWU5UQSq6yltSqJjyPB
	 0TpbL3Og8fPuMssF9A2t3JZEsVsd/TDOz/7ioMuVa0yqF8HAYQ3LHiNbYZ/i8cv/QJ
	 C9W5f6W9aGX6JX371WZBIdMJlk8zlQS8WhPzlgUY=
Subject: FAILED: patch "[PATCH] eventfs: Have event files and directories default to parent" failed to apply to 6.6-stable tree
To: rostedt@goodmis.org,cuidongliang390@gmail.com,hongyu.jin@unisoc.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 Dec 2023 10:59:44 +0000
Message-ID: <2023122844-pellet-sharpie-7d33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0dfc852b6fe3cbecbea67332a0dce2bebeba540d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023122844-pellet-sharpie-7d33@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

0dfc852b6fe3 ("eventfs: Have event files and directories default to parent uid and gid")
28e12c09f5aa ("eventfs: Save ownership and mode")
db3a397209b0 ("eventfs: Have a free_ei() that just frees the eventfs_inode")
5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0dfc852b6fe3cbecbea67332a0dce2bebeba540d Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Wed, 20 Dec 2023 10:50:17 -0500
Subject: [PATCH] eventfs: Have event files and directories default to parent
 uid and gid

Dongliang reported:

  I found that in the latest version, the nodes of tracefs have been
  changed to dynamically created.

  This has caused me to encounter a problem where the gid I specified in
  the mounting parameters cannot apply to all files, as in the following
  situation:

  /data/tmp/events # mount | grep tracefs
  tracefs on /data/tmp type tracefs (rw,seclabel,relatime,gid=3012)

  gid 3012 = readtracefs

  /data/tmp # ls -lh
  total 0
  -r--r-----   1 root readtracefs 0 1970-01-01 08:00 README
  -r--r-----   1 root readtracefs 0 1970-01-01 08:00 available_events

  ums9621_1h10:/data/tmp/events # ls -lh
  total 0
  drwxr-xr-x 2 root root 0 2023-12-19 00:56 alarmtimer
  drwxr-xr-x 2 root root 0 2023-12-19 00:56 asoc

  It will prevent certain applications from accessing tracefs properly, I
  try to avoid this issue by making the following modifications.

To fix this, have the files created default to taking the ownership of
the parent dentry unless the ownership was previously set by the user.

Link: https://lore.kernel.org/linux-trace-kernel/1703063706-30539-1-git-send-email-dongliang.cui@unisoc.com/
Link: https://lore.kernel.org/linux-trace-kernel/20231220105017.1489d790@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Hongyu Jin  <hongyu.jin@unisoc.com>
Fixes: 28e12c09f5aa0 ("eventfs: Save ownership and mode")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reported-by: Dongliang Cui <cuidongliang390@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 43e237864a42..2ccc849a5bda 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -148,7 +148,8 @@ static const struct file_operations eventfs_file_operations = {
 	.release	= eventfs_release,
 };
 
-static void update_inode_attr(struct inode *inode, struct eventfs_attr *attr, umode_t mode)
+static void update_inode_attr(struct dentry *dentry, struct inode *inode,
+			      struct eventfs_attr *attr, umode_t mode)
 {
 	if (!attr) {
 		inode->i_mode = mode;
@@ -162,9 +163,13 @@ static void update_inode_attr(struct inode *inode, struct eventfs_attr *attr, um
 
 	if (attr->mode & EVENTFS_SAVE_UID)
 		inode->i_uid = attr->uid;
+	else
+		inode->i_uid = d_inode(dentry->d_parent)->i_uid;
 
 	if (attr->mode & EVENTFS_SAVE_GID)
 		inode->i_gid = attr->gid;
+	else
+		inode->i_gid = d_inode(dentry->d_parent)->i_gid;
 }
 
 /**
@@ -206,7 +211,7 @@ static struct dentry *create_file(const char *name, umode_t mode,
 		return eventfs_failed_creating(dentry);
 
 	/* If the user updated the directory's attributes, use them */
-	update_inode_attr(inode, attr, mode);
+	update_inode_attr(dentry, inode, attr, mode);
 
 	inode->i_op = &eventfs_file_inode_operations;
 	inode->i_fop = fop;
@@ -242,7 +247,8 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
 		return eventfs_failed_creating(dentry);
 
 	/* If the user updated the directory's attributes, use them */
-	update_inode_attr(inode, &ei->attr, S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
+	update_inode_attr(dentry, inode, &ei->attr,
+			  S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
 
 	inode->i_op = &eventfs_root_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;


