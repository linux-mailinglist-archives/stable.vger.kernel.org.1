Return-Path: <stable+bounces-186015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294B7BE33B4
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744441A64511
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53B931D398;
	Thu, 16 Oct 2025 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j9WIVF/r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BE931D383
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616348; cv=none; b=MLIaX4658lgNVgjKlBTzj7Eh2H9kiucHO+n5TjJiiPaDSY+BZjUKABgS/9mZsml1QLDs1H3NJWZTkUjBtMq9StgDKPEDRJ2+voMSOjwqUYWCLI5y0IosdX97mIOAtQd9QfxBSOr4lzYjRbguIytT3x2KusBHAtVaHb2cQ3oJZto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616348; c=relaxed/simple;
	bh=oT96lwrpQkXAtuXJ4RnL6fL4SGFmYic+dh03hl5kZKY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I3SNPbGGakb6Z3pc7WENC6l8JvLu5ETFmZAYqI6WqDW/R8+kPQUf4sIfI7ZC8MdQp3AW98TP5DTqXrZYoGp//wYZGsII8ueK+0jx6KTyTd/cSP6mwqWAyh2jwfypathby5Jl7md7LofyvaE452e6r02BGnIMhfAdmW5qTUQFsn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j9WIVF/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F07EC4CEF9;
	Thu, 16 Oct 2025 12:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760616347;
	bh=oT96lwrpQkXAtuXJ4RnL6fL4SGFmYic+dh03hl5kZKY=;
	h=Subject:To:Cc:From:Date:From;
	b=j9WIVF/rOBQf5DH5MH/ok+k8nqCnJ8kkoHa3i62NiVC7vo50IG9wjsYI4o1y7yQxG
	 TxCfVIoJPtFb78A0QoHRnyURr1GQzVAnZKN3wG1OSBf00b8JPhFqAk9bOQdHo6slvH
	 Cz+yUyT/93Jf5EDxitfCsj6w/D/Umvw08cMGoryM=
Subject: FAILED: patch "[PATCH] btrfs: avoid potential out-of-bounds in btrfs_encode_fh()" failed to apply to 5.4-stable tree
To: anderson@allelesecurity.com,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:05:44 +0200
Message-ID: <2025101644-legacy-starch-6a67@gregkh>
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
git cherry-pick -x dff4f9ff5d7f289e4545cc936362e01ed3252742
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101644-legacy-starch-6a67@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dff4f9ff5d7f289e4545cc936362e01ed3252742 Mon Sep 17 00:00:00 2001
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Mon, 8 Sep 2025 09:49:02 -0300
Subject: [PATCH] btrfs: avoid potential out-of-bounds in btrfs_encode_fh()

The function btrfs_encode_fh() does not properly account for the three
cases it handles.

Before writing to the file handle (fh), the function only returns to the
user BTRFS_FID_SIZE_NON_CONNECTABLE (5 dwords, 20 bytes) or
BTRFS_FID_SIZE_CONNECTABLE (8 dwords, 32 bytes).

However, when a parent exists and the root ID of the parent and the
inode are different, the function writes BTRFS_FID_SIZE_CONNECTABLE_ROOT
(10 dwords, 40 bytes).

If *max_len is not large enough, this write goes out of bounds because
BTRFS_FID_SIZE_CONNECTABLE_ROOT is greater than
BTRFS_FID_SIZE_CONNECTABLE originally returned.

This results in an 8-byte out-of-bounds write at
fid->parent_root_objectid = parent_root_id.

A previous attempt to fix this issue was made but was lost.

https://lore.kernel.org/all/4CADAEEC020000780001B32C@vpn.id2.novell.com/

Although this issue does not seem to be easily triggerable, it is a
potential memory corruption bug that should be fixed. This patch
resolves the issue by ensuring the function returns the appropriate size
for all three cases and validates that *max_len is large enough before
writing any data.

Fixes: be6e8dc0ba84 ("NFS support for btrfs - v3")
CC: stable@vger.kernel.org # 3.0+
Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index d062ac521051..230d9326b685 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -23,7 +23,11 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	int type;
 
 	if (parent && (len < BTRFS_FID_SIZE_CONNECTABLE)) {
-		*max_len = BTRFS_FID_SIZE_CONNECTABLE;
+		if (btrfs_root_id(BTRFS_I(inode)->root) !=
+		    btrfs_root_id(BTRFS_I(parent)->root))
+			*max_len = BTRFS_FID_SIZE_CONNECTABLE_ROOT;
+		else
+			*max_len = BTRFS_FID_SIZE_CONNECTABLE;
 		return FILEID_INVALID;
 	} else if (len < BTRFS_FID_SIZE_NON_CONNECTABLE) {
 		*max_len = BTRFS_FID_SIZE_NON_CONNECTABLE;
@@ -45,6 +49,8 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 		parent_root_id = btrfs_root_id(BTRFS_I(parent)->root);
 
 		if (parent_root_id != fid->root_objectid) {
+			if (*max_len < BTRFS_FID_SIZE_CONNECTABLE_ROOT)
+				return FILEID_INVALID;
 			fid->parent_root_objectid = parent_root_id;
 			len = BTRFS_FID_SIZE_CONNECTABLE_ROOT;
 			type = FILEID_BTRFS_WITH_PARENT_ROOT;


