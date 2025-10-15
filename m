Return-Path: <stable+bounces-185782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD41BDE0C3
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 12:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C94F403739
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB42430CD97;
	Wed, 15 Oct 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rcQfmf+G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD7E2EA464
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524693; cv=none; b=fbTpT+G0diVqDC+42UaZuABpAstK3SxPQuEFk3hrnOiMF8i+Y+SCntkl4un2XHyd4E2Lhz0pJDzBfiLsMLyX7VNVl3dbJvxWW9k528L2wYJZ2iKOYxgoPgrbM2RDOuo+zyJB87tUXWNSGcUaY3iaHbDrWXvuEeAmhYD5ExXro2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524693; c=relaxed/simple;
	bh=Su+rXhxc7MGxHN+VTR6LMMLSEO9BrKG9MFAjojq5Fb4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tcdKXuXPZABBsknxKRoO7WO6FFr8WQ780YxaBpnADpaixpFV6v18M8d3ZuQfMLISYgCzD6YAbvd2ss4wmzSGZYdxFjO/ljSyNRL/eMPpg+MjtZO7yDBNOPu96erqozH2uJ8yfKcaH984aqcbXD+JybIG2FNvfoZC6dzSeidyQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rcQfmf+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BACC4CEF8;
	Wed, 15 Oct 2025 10:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760524692;
	bh=Su+rXhxc7MGxHN+VTR6LMMLSEO9BrKG9MFAjojq5Fb4=;
	h=Subject:To:Cc:From:Date:From;
	b=rcQfmf+GFBUN+iy2noYUkpdJN4s2W709tBGok6440TeI5EiJK+eNdVLZchnRAxOa6
	 CrRK6hGdhY2fMD/X/eYdfXwZP62FQEsYDDW8HYRU8/Cc5S+HVen8qF2lekBvGtVi2S
	 J4k2GMg9yrc4pF1az5L+4s5h4bvyBlHYY3r0YPKc=
Subject: FAILED: patch "[PATCH] debugfs: fix mount options not being applied" failed to apply to 6.12-stable tree
To: charmitro@posteo.net,brauner@kernel.org,sandeen@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Oct 2025 12:38:02 +0200
Message-ID: <2025101502-elf-bootie-19bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8e7e265d558e0257d6dacc78ec64aff4ba75f61e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101502-elf-bootie-19bf@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e7e265d558e0257d6dacc78ec64aff4ba75f61e Mon Sep 17 00:00:00 2001
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Sat, 16 Aug 2025 14:14:37 +0000
Subject: [PATCH] debugfs: fix mount options not being applied

Mount options (uid, gid, mode) are silently ignored when debugfs is
mounted. This is a regression introduced during the conversion to the
new mount API.

When the mount API conversion was done, the parsed options were never
applied to the superblock when it was reused. As a result, the mount
options were ignored when debugfs was mounted.

Fix this by following the same pattern as the tracefs fix in commit
e4d32142d1de ("tracing: Fix tracefs mount options"). Call
debugfs_reconfigure() in debugfs_get_tree() to apply the mount options
to the superblock after it has been created or reused.

As an example, with the bug the "mode" mount option is ignored:

  $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
  $ mount | grep debugfs_test
  debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
  $ ls -ld /tmp/debugfs_test
  drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test

With the fix applied, it works as expected:

  $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
  $ mount | grep debugfs_test
  debugfs on /tmp/debugfs_test type debugfs (rw,relatime,mode=666)
  $ ls -ld /tmp/debugfs_test
  drw-rw-rw- 37 root root 0 Aug  2 17:28 /tmp/debugfs_test

Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220406
Cc: stable@vger.kernel.org
Reviewed-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
Link: https://lore.kernel.org/20250816-debugfs-mount-opts-v3-1-d271dad57b5b@posteo.net
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index a0357b0cf362..c12d649df6a5 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -183,6 +183,9 @@ static int debugfs_reconfigure(struct fs_context *fc)
 	struct debugfs_fs_info *sb_opts = sb->s_fs_info;
 	struct debugfs_fs_info *new_opts = fc->s_fs_info;
 
+	if (!new_opts)
+		return 0;
+
 	sync_filesystem(sb);
 
 	/* structure copy of new mount options to sb */
@@ -282,10 +285,16 @@ static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int debugfs_get_tree(struct fs_context *fc)
 {
+	int err;
+
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API))
 		return -EPERM;
 
-	return get_tree_single(fc, debugfs_fill_super);
+	err = get_tree_single(fc, debugfs_fill_super);
+	if (err)
+		return err;
+
+	return debugfs_reconfigure(fc);
 }
 
 static void debugfs_free_fc(struct fs_context *fc)


