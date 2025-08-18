Return-Path: <stable+bounces-169981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F6EB29F75
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB7816AD20
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D769C258EE7;
	Mon, 18 Aug 2025 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d6TK62qp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955952C2342
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514110; cv=none; b=j57Fe/0mGJkmMVcpd3gcesjycUgrkp+1DTSq/KQyQzMDzwYotPJldryzV+s242P9c/4k3lNP40FuSniHLYmgtAfjgaf0Bwm24+TI/0uK5kHnsFhYg1ypQf8a5MZ8hxYeEav1KpUc6XXDLMWp/z+MQozylI1CmZdtTAM1ZOyll3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514110; c=relaxed/simple;
	bh=effzvfmqJlnh/4xGXiApoMnpumykAG0C4yR/5NSGVWs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AJRv4n06e/84hYrpm53+NOTGpJt5XUbEtCxC/9ete35izZ062HDwXZeJyKeoEu+jr2XC2q/OkbSwzUV3/3WRwaRY8tIdZAP5kkY+7K6y0vC749+Bs+ttzGewmOthBAl1h3XeC5HOKqUfMvZv1xZ+DyQ+saOGEYh6f1IOaNQvEko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d6TK62qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0391DC4CEEB;
	Mon, 18 Aug 2025 10:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514110;
	bh=effzvfmqJlnh/4xGXiApoMnpumykAG0C4yR/5NSGVWs=;
	h=Subject:To:Cc:From:Date:From;
	b=d6TK62qpvhf3K70L5WCXA7JCYpgnE5rjCP96WrCsbUSOPHqBwm0zHGl5Oa44kQh2H
	 60DX7CIsJI2IA2gHRDUxBLriXVdLkO8gU2ybU4xjpLxIRwVNWTs/mobD3+UaERQ8RH
	 eOYiew3uaPR687FZwbVAflYaf8D6WRcXZoeepVmE=
Subject: FAILED: patch "[PATCH] btrfs: don't skip remaining extrefs if dir not found during" failed to apply to 6.1-stable tree
To: fdmanana@suse.com,boris@bur.io,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:48:19 +0200
Message-ID: <2025081819-amnesty-yen-4c26@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 24e066ded45b8147b79c7455ac43a5bff7b5f378
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081819-amnesty-yen-4c26@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 24e066ded45b8147b79c7455ac43a5bff7b5f378 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Fri, 11 Jul 2025 20:48:23 +0100
Subject: [PATCH] btrfs: don't skip remaining extrefs if dir not found during
 log replay

During log replay, at add_inode_ref(), if we have an extref item that
contains multiple extrefs and one of them points to a directory that does
not exist in the subvolume tree, we are supposed to ignore it and process
the remaining extrefs encoded in the extref item, since each extref can
point to a different parent inode. However when that happens we just
return from the function and ignore the remaining extrefs.

The problem has been around since extrefs were introduced, in commit
f186373fef00 ("btrfs: extended inode refs"), but it's hard to hit in
practice because getting extref items encoding multiple extref requires
getting a hash collision when computing the offset of the extref's
key. The offset if computed like this:

  key.offset = btrfs_extref_hash(dir_ino, name->name, name->len);

and btrfs_extref_hash() is just a wrapper around crc32c().

Fix this by moving to next iteration of the loop when we don't find
the parent directory that an extref points to.

Fixes: f186373fef00 ("btrfs: extended inode refs")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e3c77f3d092c..467b69a4ef3b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1433,6 +1433,8 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		if (log_ref_ver) {
 			ret = extref_get_fields(eb, ref_ptr, &name,
 						&ref_index, &parent_objectid);
+			if (ret)
+				goto out;
 			/*
 			 * parent object can change from one array
 			 * item to another.
@@ -1449,16 +1451,23 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 					 * the loop when getting the first
 					 * parent dir.
 					 */
-					if (ret == -ENOENT)
+					if (ret == -ENOENT) {
+						/*
+						 * The next extref may refer to
+						 * another parent dir that
+						 * exists, so continue.
+						 */
 						ret = 0;
+						goto next;
+					}
 					goto out;
 				}
 			}
 		} else {
 			ret = ref_get_fields(eb, ref_ptr, &name, &ref_index);
+			if (ret)
+				goto out;
 		}
-		if (ret)
-			goto out;
 
 		ret = inode_in_dir(root, path, btrfs_ino(dir), btrfs_ino(inode),
 				   ref_index, &name);
@@ -1492,10 +1501,11 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		}
 		/* Else, ret == 1, we already have a perfect match, we're done. */
 
+next:
 		ref_ptr = (unsigned long)(ref_ptr + ref_struct_size) + name.len;
 		kfree(name.name);
 		name.name = NULL;
-		if (log_ref_ver) {
+		if (log_ref_ver && dir) {
 			iput(&dir->vfs_inode);
 			dir = NULL;
 		}


