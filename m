Return-Path: <stable+bounces-12772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E9C8372BD
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606961F251C7
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45013FB0B;
	Mon, 22 Jan 2024 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i/sA/J6Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED483F8FA
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952321; cv=none; b=PMs/VHL66eNcobtwonZFUdI83ZMf7sLWtzjngtrUlCVQfDExmmhyh7LkfsP0c843Ke2CYdlUA2Zvu1xpWGJoyA8YFRWI+rIOrY/IhfoFzZ7le0vX408DLQggCr2IuK4FJAy0m+sqdk1npbtepsNe6Tl0Y26QS0v+pCqr3+qdJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952321; c=relaxed/simple;
	bh=h4l9gomf5vr7XQk6DCdeeAbnUOr5z+eL0FNR9svWN9I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k4aJlu67wJOE+y7AMw9RQ/SqONRlpIblQGzCzudFHJiD8iiVMNQhI6bsLRMuoUWpMlXEaapxOv5dicQ9oC+QUoDpaa/I6pwkMBT47EKdSFwyLtId71vQ2+McjUG3kF1V9zpAXSmJDE7/mc2I3QhC5Onpl3Qy7fgMhFlgMZFAs0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i/sA/J6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA764C433C7;
	Mon, 22 Jan 2024 19:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705952321;
	bh=h4l9gomf5vr7XQk6DCdeeAbnUOr5z+eL0FNR9svWN9I=;
	h=Subject:To:Cc:From:Date:From;
	b=i/sA/J6QpBEe+hpvKVjrMptWSbQqg++Br16M7R8nC+Ai3xsljVacJveuuWuR4HJdd
	 asVO+JGZ574rMEmA9k6ZIci6GGcwAB4uoJ0Sxjye2FU4Fd6dqFJGTQSKiV8wUhTKwQ
	 lj9j1/6V0uz/k4i6DZ3bv73ArhZWDx2Q03NnuY68=
Subject: FAILED: patch "[PATCH] rootfs: Fix support for rootfstype= when root= is given" failed to apply to 4.19-stable tree
To: stefanb@linux.ibm.com,gregkh@linuxfoundation.org,rob@landley.net,stable@vger.kernel.org,zohar@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 11:38:38 -0800
Message-ID: <2024012238-coke-debrief-5c9b@gregkh>
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
git cherry-pick -x 21528c69a0d8483f7c6345b1a0bc8d8975e9a172
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012238-coke-debrief-5c9b@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

21528c69a0d8 ("rootfs: Fix support for rootfstype= when root= is given")
037f11b4752f ("mnt_init(): call shmem_init() unconditionally")
fd3e007f6c6a ("don't bother with registering rootfs")
14a253ce4210 ("init_rootfs(): don't bother with init_ramfs_fs()")
9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount() to it.")
505b050fdf42 ("Merge branch 'mount.part1' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 21528c69a0d8483f7c6345b1a0bc8d8975e9a172 Mon Sep 17 00:00:00 2001
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Sun, 19 Nov 2023 20:12:48 -0500
Subject: [PATCH] rootfs: Fix support for rootfstype= when root= is given

Documentation/filesystems/ramfs-rootfs-initramfs.rst states:

  If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
  default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
  line.

This currently does not work when root= is provided since then
saved_root_name contains a string and rootfstype= is ignored. Therefore,
ramfs is currently always chosen when root= is provided.

The current behavior for rootfs's filesystem is:

   root=       | rootfstype= | chosen rootfs filesystem
   ------------+-------------+--------------------------
   unspecified | unspecified | tmpfs
   unspecified | tmpfs       | tmpfs
   unspecified | ramfs       | ramfs
    provided   | ignored     | ramfs

rootfstype= should be respected regardless whether root= is given,
as shown below:

   root=       | rootfstype= | chosen rootfs filesystem
   ------------+-------------+--------------------------
   unspecified | unspecified | tmpfs  (as before)
   unspecified | tmpfs       | tmpfs  (as before)
   unspecified | ramfs       | ramfs  (as before)
    provided   | unspecified | ramfs  (compatibility with before)
    provided   | tmpfs       | tmpfs  (new)
    provided   | ramfs       | ramfs  (new)

This table represents the new behavior.

Fixes: 6e19eded3684 ("initmpfs: use initramfs if rootfstype= or root= specified")
Cc: <stable@vger.kernel.org>
Signed-off-by: Rob Landley <rob@landley.net>
Link: https://lore.kernel.org/lkml/8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net/
Reviewed-and-Tested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Link: https://lore.kernel.org/r/20231120011248.396012-1-stefanb@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 5fdef94f0864..279ad28bf4fb 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -510,7 +510,10 @@ struct file_system_type rootfs_fs_type = {
 
 void __init init_rootfs(void)
 {
-	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
-		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
-		is_tmpfs = true;
+	if (IS_ENABLED(CONFIG_TMPFS)) {
+		if (!saved_root_name[0] && !root_fs_names)
+			is_tmpfs = true;
+		else if (root_fs_names && !!strstr(root_fs_names, "tmpfs"))
+			is_tmpfs = true;
+	}
 }


