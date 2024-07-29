Return-Path: <stable+bounces-62390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D4A93EF0D
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADF51C21B66
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8903512C522;
	Mon, 29 Jul 2024 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pWJjuALa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05B84A2F
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239546; cv=none; b=gmP6zO01fx6p/b8jo7+atcTFvagj09nFQYHlQUTcoyJfvEz7MvvRpsYzJibYZDU3FZpGMpAXHhx319QocKfl1rTBgXenfdcirIuz6Z5dLFeqsQT9IOHMCFkRS5vAvWQhlrc03lj+ZpWYlL6ms3KhW3YLAOZKD+KztJbNLz22dJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239546; c=relaxed/simple;
	bh=1Jn5uKaeK3fzgq+Vo7JDO5J8e/HRnXpbLBpSc6AJAjA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RC047KKnuoZgorz+nLjyAW/topN74s/hi0mT57tisjfZTshdrBxMGLHzOhwr3YFzt3ZQSzG9KLD21sjfK/11CSz4jIc40igLGj9aNWY5YN1xjtT2+n74qstvo2oxJsFysdsTkFpFtVqhmSEZmKwh5WkZSBHKbyLeJfSdFHbne4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pWJjuALa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FD0C32786;
	Mon, 29 Jul 2024 07:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239546;
	bh=1Jn5uKaeK3fzgq+Vo7JDO5J8e/HRnXpbLBpSc6AJAjA=;
	h=Subject:To:Cc:From:Date:From;
	b=pWJjuALav4haKqPiVciuD9mkMIJShxOOK6SJ3StacsM4X3uyF5ds8EsEp1+7f/5zS
	 fefLPDwQkS6G47A5+sU7FeSvlLOSse8O+bqnNGRHZkMHplmTz9diLFNQggUhk4mSkS
	 GnivAk3d/OvkxNIhYun4Z7NE4Je8j5AwPmOiWuvE=
Subject: FAILED: patch "[PATCH] fuse: verify {g,u}id mount options correctly" failed to apply to 5.4-stable tree
To: sandeen@redhat.com,brauner@kernel.org,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:52:14 +0200
Message-ID: <2024072914-sierra-aflutter-e231@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 525bd65aa759ec320af1dc06e114ed69733e9e23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072914-sierra-aflutter-e231@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

525bd65aa759 ("fuse: verify {g,u}id mount options correctly")
84c215075b57 ("fuse: name fs_context consistently")
1dd539577c42 ("virtiofs: add a mount option to enable dax")
f4fd4ae354ba ("virtiofs: get rid of no_mount_options")
b330966f79fb ("fuse: reject options on reconfigure via fsconfig(2)")
e8b20a474cf2 ("fuse: ignore 'data' argument of mount(..., MS_REMOUNT)")
0189a2d367f4 ("fuse: use ->reconfigure() instead of ->remount_fs()")
7fd3abfa8dd7 ("virtiofs: do not use fuse_fill_super_common() for device installation")
c9d35ee049b4 ("Merge branch 'merge.nfs-fs_parse.1' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 525bd65aa759ec320af1dc06e114ed69733e9e23 Mon Sep 17 00:00:00 2001
From: Eric Sandeen <sandeen@redhat.com>
Date: Tue, 2 Jul 2024 17:22:41 -0500
Subject: [PATCH] fuse: verify {g,u}id mount options correctly

As was done in
0200679fc795 ("tmpfs: verify {g,u}id mount options correctly")
we need to validate that the requested uid and/or gid is representable in
the filesystem's idmapping.

Cribbing from the above commit log,

The contract for {g,u}id mount options and {g,u}id values in general set
from userspace has always been that they are translated according to the
caller's idmapping. In so far, fuse has been doing the correct thing.
But since fuse is mountable in unprivileged contexts it is also
necessary to verify that the resulting {k,g}uid is representable in the
namespace of the superblock.

Fixes: c30da2e981a7 ("fuse: convert to use the new mount API")
Cc: stable@vger.kernel.org # 5.4+
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Link: https://lore.kernel.org/r/8f07d45d-c806-484d-a2e3-7a2199df1cd2@redhat.com
Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..32fe6fa72f46 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -755,6 +755,8 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 	struct fs_parse_result result;
 	struct fuse_fs_context *ctx = fsc->fs_private;
 	int opt;
+	kuid_t kuid;
+	kgid_t kgid;
 
 	if (fsc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
 		/*
@@ -799,16 +801,30 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		break;
 
 	case OPT_USER_ID:
-		ctx->user_id = make_kuid(fsc->user_ns, result.uint_32);
-		if (!uid_valid(ctx->user_id))
+		kuid =  make_kuid(fsc->user_ns, result.uint_32);
+		if (!uid_valid(kuid))
 			return invalfc(fsc, "Invalid user_id");
+		/*
+		 * The requested uid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kuid_has_mapping(fsc->user_ns, kuid))
+			return invalfc(fsc, "Invalid user_id");
+		ctx->user_id = kuid;
 		ctx->user_id_present = true;
 		break;
 
 	case OPT_GROUP_ID:
-		ctx->group_id = make_kgid(fsc->user_ns, result.uint_32);
-		if (!gid_valid(ctx->group_id))
+		kgid = make_kgid(fsc->user_ns, result.uint_32);;
+		if (!gid_valid(kgid))
 			return invalfc(fsc, "Invalid group_id");
+		/*
+		 * The requested gid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kgid_has_mapping(fsc->user_ns, kgid))
+			return invalfc(fsc, "Invalid group_id");
+		ctx->group_id = kgid;
 		ctx->group_id_present = true;
 		break;
 


