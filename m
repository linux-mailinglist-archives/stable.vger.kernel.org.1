Return-Path: <stable+bounces-53644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8CC90D54F
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 16:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668E0289175
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5CB152DEB;
	Tue, 18 Jun 2024 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OdTYRkpD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F10814F122
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720180; cv=none; b=MtY6IGo3poKSgdIV56VOhdESyQB6OosNigBVtArdX+W/ME9N2KpMjK1jD95Zfw+JMhQxNNw4RWdgDKVLcW83n5i/RZNTg84HMgHKlvgC7IEsVylt61AjeY7uza9IikapH4I6Nbyz/tH6/0JYyArHqnLza6ODwN3lia5cha3tOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720180; c=relaxed/simple;
	bh=yQA1mJZqu5tcnOVTjV574OfRCfqAHRJxCOUtdALmy/E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HpDGACfkCTJl56iNzV6vOSojgsyxZzaA6Br8Ezpin3PSzr4ejQjW4XdkV2Q3UtOl2ZtKmhOMUznhh1y0yMpOpufAC3p7QRXZF7f8q4JRZYFKIlfeBlMoZiaxxYXxSu0r0asYbteZieBDLK+tyTBpWYgdDj8zgL+7eKmwMSuhGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OdTYRkpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B97C3277B;
	Tue, 18 Jun 2024 14:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718720179;
	bh=yQA1mJZqu5tcnOVTjV574OfRCfqAHRJxCOUtdALmy/E=;
	h=Subject:To:Cc:From:Date:From;
	b=OdTYRkpDbe/dwtdZbvH6/yn959fPna9cb0EznTup+DXjFCWTsdpAblXT5A8cwUU3C
	 BU1d+4o8cmeH0+q0B1EQQvnfbVaioxRnbdO+522j6UCqc6tODJSkBxYmGRXvReJ0oE
	 McbUWY+H5gPtVSLc9EgCGXAz4isbOiwZrZFkbH3Q=
Subject: FAILED: patch "[PATCH] ocfs2: update inode fsync transaction id in ocfs2_unlink and" failed to apply to 4.19-stable tree
To: glass.su@suse.com,akpm@linux-foundation.org,gechangwei@live.cn,ghe@suse.com,jlbec@evilplan.org,joseph.qi@linux.alibaba.com,junxiao.bi@oracle.com,mark@fasheh.com,piaojun@huawei.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 16:16:04 +0200
Message-ID: <2024061803-ashen-anytime-8f00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 8c40984eeb8804cffcd28640f427f4fe829243fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061803-ashen-anytime-8f00@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

8c40984eeb88 ("ocfs2: update inode fsync transaction id in ocfs2_unlink and ocfs2_link")
fd6acbbc4d1e ("ocfs2: convert to new timestamp accessors")
6861de979fa0 ("ocfs2: convert to ctime accessor functions")
f2d40141d5d9 ("fs: port inode_init_owner() to mnt_idmap")
011e2b717b1b ("fs: port ->tmpfile() to pass mnt_idmap")
5ebb29bee8d5 ("fs: port ->mknod() to pass mnt_idmap")
c54bd91e9eab ("fs: port ->mkdir() to pass mnt_idmap")
7a77db95511c ("fs: port ->symlink() to pass mnt_idmap")
6c960e68aaed ("fs: port ->create() to pass mnt_idmap")
abf08576afe3 ("fs: port vfs_*() helpers to struct mnt_idmap")
041fae9c105a ("Merge tag 'f2fs-for-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs")

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


