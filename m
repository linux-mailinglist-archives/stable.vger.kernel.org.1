Return-Path: <stable+bounces-169976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C3CB29F70
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65387B319B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A217258EFD;
	Mon, 18 Aug 2025 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NcKww3xD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3978D2C2362
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514029; cv=none; b=JvtmPMGhJ3Tj+w/xbeM7aN7xHRHuWSrI9bAetez0OFq5vhsE9ohjKKqMEQJjaNDZT68/w5DK9ek8c2b5ZeJ19YNgH1QTH/BMCplHpjxU46ebKu2QQBGs+SYrPL5JEdrD47hLIGLSiM/9ezcQjTJkR1geoUVnXaBKdXruZ/QVSag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514029; c=relaxed/simple;
	bh=j5nn0R2SEKEZMiOM066NP72LuT7IOTHcn6fFaxGqXnw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RnImaNwk8wxMZAp+WN2862G/j0yOpebaHrZ2QeGl/gP5JnCa/oYaR4LmuyR24lOzkTcqdKyKyQOZAqsWUvYXwmfA8Io4YTWLnR1heANNLlKTfYgRCuY7UJBSbhdPM6H2Zleq6SySDs+iNmIEz52eUF4VZdO61NKX+utGq8jvkJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NcKww3xD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8B3C4CEEB;
	Mon, 18 Aug 2025 10:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514028;
	bh=j5nn0R2SEKEZMiOM066NP72LuT7IOTHcn6fFaxGqXnw=;
	h=Subject:To:Cc:From:Date:From;
	b=NcKww3xD2OOLbWcRGmGNkMobFLljLy6142abwQeBhggsYH0YnRJHaJ+dcYIliECpc
	 qmojc/lfRD8vxhk8GPsR+UtxJkkh/Wiaycnze3eprxkgLN+LMQEguCvCryD+e8POx/
	 O98NH1ErYK/i87onCi7OMCon9E9B26J16sUuBKB8=
Subject: FAILED: patch "[PATCH] btrfs: don't ignore inode missing when replaying log tree" failed to apply to 6.6-stable tree
To: fdmanana@suse.com,boris@bur.io,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:47:05 +0200
Message-ID: <2025081805-strongly-container-0be3@gregkh>
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
git cherry-pick -x 7ebf381a69421a88265d3c49cd0f007ba7336c9d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081805-strongly-container-0be3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7ebf381a69421a88265d3c49cd0f007ba7336c9d Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Fri, 11 Jul 2025 20:21:28 +0100
Subject: [PATCH] btrfs: don't ignore inode missing when replaying log tree

During log replay, at add_inode_ref(), we return -ENOENT if our current
inode isn't found on the subvolume tree or if a parent directory isn't
found. The error comes from btrfs_iget_logging() <- btrfs_iget() <-
btrfs_read_locked_inode().

The single caller of add_inode_ref(), replay_one_buffer(), ignores an
-ENOENT error because it expects that error to mean only that a parent
directory wasn't found and that is ok.

Before commit 5f61b961599a ("btrfs: fix inode lookup error handling during
log replay") we were converting any error when getting a parent directory
to -ENOENT and any error when getting the current inode to -EIO, so our
caller would fail log replay in case we can't find the current inode.
After that commit however in case the current inode is not found we return
-ENOENT to the caller and therefore it ignores the critical fact that the
current inode was not found in the subvolume tree.

Fix this by converting -ENOENT to 0 when we don't find a parent directory,
returning -ENOENT when we don't find the current inode and making the
caller, replay_one_buffer(), not ignore -ENOENT anymore.

Fixes: 5f61b961599a ("btrfs: fix inode lookup error handling during log replay")
CC: stable@vger.kernel.org # 6.16
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ab0815d9e7e5..e3c77f3d092c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1416,6 +1416,8 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	dir = btrfs_iget_logging(parent_objectid, root);
 	if (IS_ERR(dir)) {
 		ret = PTR_ERR(dir);
+		if (ret == -ENOENT)
+			ret = 0;
 		dir = NULL;
 		goto out;
 	}
@@ -1440,6 +1442,15 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 				if (IS_ERR(dir)) {
 					ret = PTR_ERR(dir);
 					dir = NULL;
+					/*
+					 * A new parent dir may have not been
+					 * logged and not exist in the subvolume
+					 * tree, see the comment above before
+					 * the loop when getting the first
+					 * parent dir.
+					 */
+					if (ret == -ENOENT)
+						ret = 0;
 					goto out;
 				}
 			}
@@ -2551,9 +2562,8 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 			   key.type == BTRFS_INODE_EXTREF_KEY) {
 			ret = add_inode_ref(wc->trans, root, log, path,
 					    eb, i, &key);
-			if (ret && ret != -ENOENT)
+			if (ret)
 				break;
-			ret = 0;
 		} else if (key.type == BTRFS_EXTENT_DATA_KEY) {
 			ret = replay_one_extent(wc->trans, root, path,
 						eb, i, &key);


