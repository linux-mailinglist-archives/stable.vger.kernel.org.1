Return-Path: <stable+bounces-169980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DF9B29F74
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F6997A488E
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B64258EE7;
	Mon, 18 Aug 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U/5fTebR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1B22C2342
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514102; cv=none; b=KlITYX1LcXTfoo1IueabJu6OAIo/tj+RqXEG1jDOeobvCJkpXn+UZ4O0jlIJLFnisHN1aNuMYXRVcQ7rEw2Xrar0RiuZQs8/2wWXpLt5aB5JmE8fraLUMCnmgby9Yl3KqXt3+1PEl5i5Xou1qUnI5fPrivFO1cMUjixy41cglWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514102; c=relaxed/simple;
	bh=sb6VAndb3Ar0p4jrO5J620BDalMknUpBRbZZcD0RgW4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FX9Rw/95EUcx+lELuNCoiJdNsxZIiYMBjEjLI8q8SukDTcygQXZHPBJSu7cxfLNp0EQpRIcgQRUQjwfoW+Qe7HLlvbd3HT9gANn91zjN4DvDKTx0MksrXZ2+OW4QvmIBwGXUHOJ8qASeQhpXx/wRlnl6aeCWZJm50dd5f31KmlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U/5fTebR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27049C4CEEB;
	Mon, 18 Aug 2025 10:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514101;
	bh=sb6VAndb3Ar0p4jrO5J620BDalMknUpBRbZZcD0RgW4=;
	h=Subject:To:Cc:From:Date:From;
	b=U/5fTebRkT9LWRwVWgymXeW0g7+Tey433UsY/Z4COL5fhBpvb1Xz+F9f83fUOmHrh
	 jkevtu+HZmUwfkKbtb4lqh/8z49gYIa9AW9wjB16WHm5eEXxnW/C3QJEJs62oFIzUx
	 AXkG8kzD/R1IemVJbg0sFTelQ62Bhlofu4xUUQqY=
Subject: FAILED: patch "[PATCH] btrfs: don't skip remaining extrefs if dir not found during" failed to apply to 6.6-stable tree
To: fdmanana@suse.com,boris@bur.io,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:48:18 +0200
Message-ID: <2025081818-rimless-financial-6942@gregkh>
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
git cherry-pick -x 24e066ded45b8147b79c7455ac43a5bff7b5f378
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081818-rimless-financial-6942@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


