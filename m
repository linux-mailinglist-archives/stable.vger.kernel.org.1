Return-Path: <stable+bounces-53639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F9F90D53F
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 16:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4381C218E5
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EF814F100;
	Tue, 18 Jun 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WBFiqwcD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BE14EC5E
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720163; cv=none; b=WZTIg3PtFg3gxYgniVx+FPR50hMif4CUDkeenrgb6i68suMUbIw4gLgvrVRjy8ogP4niGKAJMhTN019u/H485uaqUqtnnua1aMTdU919GCaJeTflTfdlJSIjsqg3yx5QSs+NG9S7LuvRgwrdyYgvtkneUd0t90NySAWlSyaA7UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720163; c=relaxed/simple;
	bh=UtmhztNV0NbEOYTFJ3Pwhii+oJSojY+QK65ka1vWJoM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Rinp9LmfzL6lq6WVQgR6PiuXCFICqcsDCb1oIlV9AQe6gP7CSys72nyA0QXEHGdaXyLqM3Rfaeeo6KY3Ul1Qz/MOeL2bOOIYZe6w8mKODbXc7plNQa3gaX7IeM5mC5tmpXSRuOnRX2hOPx0yLS3zVMJNz0GuCDjI5UQ67tsLv9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WBFiqwcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A72C3277B;
	Tue, 18 Jun 2024 14:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718720162;
	bh=UtmhztNV0NbEOYTFJ3Pwhii+oJSojY+QK65ka1vWJoM=;
	h=Subject:To:Cc:From:Date:From;
	b=WBFiqwcDkHmF72R1v6gXOGVYxmi+WrrlAnuKBCYhjA8+JUyD6ZUbjqtt2cIYTmPtM
	 pbxArihnO5xkT8XeI4Foz3eLrKVsV8PC1UOMbVULKGy88txbake6TejlqJGiHbgv7c
	 4tMTUNY2K3jclPz2f0gPY/Gmq1U75Fqp9gMLU7qE=
Subject: FAILED: patch "[PATCH] ocfs2: update inode fsync transaction id in ocfs2_unlink and" failed to apply to 6.6-stable tree
To: glass.su@suse.com,akpm@linux-foundation.org,gechangwei@live.cn,ghe@suse.com,jlbec@evilplan.org,joseph.qi@linux.alibaba.com,junxiao.bi@oracle.com,mark@fasheh.com,piaojun@huawei.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 16:15:59 +0200
Message-ID: <2024061859-conclude-spoiling-7389@gregkh>
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
git cherry-pick -x 8c40984eeb8804cffcd28640f427f4fe829243fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061859-conclude-spoiling-7389@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

8c40984eeb88 ("ocfs2: update inode fsync transaction id in ocfs2_unlink and ocfs2_link")
fd6acbbc4d1e ("ocfs2: convert to new timestamp accessors")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8c40984eeb8804cffcd28640f427f4fe829243fc Mon Sep 17 00:00:00 2001
From: Su Yue <glass.su@suse.com>
Date: Mon, 8 Apr 2024 16:20:40 +0800
Subject: [PATCH] ocfs2: update inode fsync transaction id in ocfs2_unlink and
 ocfs2_link

transaction id should be updated in ocfs2_unlink and ocfs2_link.
Otherwise, inode link will be wrong after journal replay even fsync was
called before power failure:
=======================================================================
$ touch testdir/bar
$ ln testdir/bar testdir/bar_link
$ fsync testdir/bar
$ stat -c %h $SCRATCH_MNT/testdir/bar
1
$ stat -c %h $SCRATCH_MNT/testdir/bar
1
=======================================================================

Link: https://lkml.kernel.org/r/20240408082041.20925-4-glass.su@suse.com
Fixes: ccd979bdbce9 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Signed-off-by: Su Yue <glass.su@suse.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 9221a33f917b..55c9d90caaaf 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -797,6 +797,7 @@ static int ocfs2_link(struct dentry *old_dentry,
 	ocfs2_set_links_count(fe, inode->i_nlink);
 	fe->i_ctime = cpu_to_le64(inode_get_ctime_sec(inode));
 	fe->i_ctime_nsec = cpu_to_le32(inode_get_ctime_nsec(inode));
+	ocfs2_update_inode_fsync_trans(handle, inode, 0);
 	ocfs2_journal_dirty(handle, fe_bh);
 
 	err = ocfs2_add_entry(handle, dentry, inode,
@@ -993,6 +994,7 @@ static int ocfs2_unlink(struct inode *dir,
 		drop_nlink(inode);
 	drop_nlink(inode);
 	ocfs2_set_links_count(fe, inode->i_nlink);
+	ocfs2_update_inode_fsync_trans(handle, inode, 0);
 	ocfs2_journal_dirty(handle, fe_bh);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));


