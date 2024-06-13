Return-Path: <stable+bounces-50395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BD7906486
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F576B22E98
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 06:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD739135A6F;
	Thu, 13 Jun 2024 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wc5ilmp/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD8113774C
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261881; cv=none; b=nGMuKpvkIk9GB8iQeKku3EGqDYTlBSn5LnOkYmHUQKxuSmoPMI1PPVIEdupaw5guf94KX779nWSm5nmU2n0BaYgpu9DS2SdYe5G8+iI7MxMhBllhoiPpzkc4+qkGzFfzIwccB2jXJPpvPDrl9VRh5wy7TgIeE/TqVEZqPg4VMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261881; c=relaxed/simple;
	bh=esbYEXP+o1DWfw37/IKiwzlMCXH6MGPcPgvAd5R5A80=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jkvu6w/wN5iw54KdjmJRRZ6dptNGCLfJVxbxucfqJc0lVNQk0ZCApP3jgQt5/GQMwvAptviWsAWKM6tlVDGbdwM1kNq9t1sVGlEvqNLp/cFvL/MbHhAuNeZKmRGn6feGZBGK682wNi6Gl7q8vYMqH8GA/gXpB+LeD9UNbFAy+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wc5ilmp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B79C2BBFC;
	Thu, 13 Jun 2024 06:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718261880;
	bh=esbYEXP+o1DWfw37/IKiwzlMCXH6MGPcPgvAd5R5A80=;
	h=Subject:To:Cc:From:Date:From;
	b=wc5ilmp/9FqL6uJl7l0i9BoJJ70D0c9VF8rvgGzp/jF6YApNIMH3UMHJG5nX3yNSz
	 Mg4xQ39p99EBzI5L++9pzANXxwtfPJJydyhFnwdujqUGR/c+bGWAW46BDmKdwyb2lR
	 M8c0AE/hG8UfnW4NIPr9qgMc6xpI2pBWA/txUjic=
Subject: FAILED: patch "[PATCH] 9p: add missing locking around taking dentry fid list" failed to apply to 5.15-stable tree
To: asmadeus@codewreck.org,linux_oss@crudebyte.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 08:57:58 +0200
Message-ID: <2024061357-product-rigid-0f3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c898afdc15645efb555acb6d85b484eb40a45409
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061357-product-rigid-0f3e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

c898afdc1564 ("9p: add missing locking around taking dentry fid list")
b48dbb998d70 ("9p fid refcount: add p9_fid_get/put wrappers")
47b1e3432b06 ("9p: Remove unnecessary variable for old fids while walking from d_parent")
cba83f47fc0e ("9p: Track the root fid with its own variable during lookups")
b0017602fdf6 ("9p: fix EBADF errors in cached mode")
2a3dcbccd64b ("9p: Fix refcounting during full path walks for fid lookups")
beca774fc51a ("9p: fix fid refcount leak in v9fs_vfs_atomic_open_dotl")
6e195b0f7c8e ("9p: fix a bunch of checkpatch warnings")
eb497943fa21 ("9p: Convert to using the netfs helper lib to do reads and caching")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c898afdc15645efb555acb6d85b484eb40a45409 Mon Sep 17 00:00:00 2001
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Tue, 21 May 2024 21:13:36 +0900
Subject: [PATCH] 9p: add missing locking around taking dentry fid list

Fix a use-after-free on dentry's d_fsdata fid list when a thread
looks up a fid through dentry while another thread unlinks it:

UAF thread:
refcount_t: addition on 0; use-after-free.
 p9_fid_get linux/./include/net/9p/client.h:262
 v9fs_fid_find+0x236/0x280 linux/fs/9p/fid.c:129
 v9fs_fid_lookup_with_uid linux/fs/9p/fid.c:181
 v9fs_fid_lookup+0xbf/0xc20 linux/fs/9p/fid.c:314
 v9fs_vfs_getattr_dotl+0xf9/0x360 linux/fs/9p/vfs_inode_dotl.c:400
 vfs_statx+0xdd/0x4d0 linux/fs/stat.c:248

Freed by:
 p9_fid_destroy (inlined)
 p9_client_clunk+0xb0/0xe0 linux/net/9p/client.c:1456
 p9_fid_put linux/./include/net/9p/client.h:278
 v9fs_dentry_release+0xb5/0x140 linux/fs/9p/vfs_dentry.c:55
 v9fs_remove+0x38f/0x620 linux/fs/9p/vfs_inode.c:518
 vfs_unlink+0x29a/0x810 linux/fs/namei.c:4335

The problem is that d_fsdata was not accessed under d_lock, because
d_release() normally is only called once the dentry is otherwise no
longer accessible but since we also call it explicitly in v9fs_remove
that lock is required:
move the hlist out of the dentry under lock then unref its fids once
they are no longer accessible.

Fixes: 154372e67d40 ("fs/9p: fix create-unlink-getattr idiom")
Cc: stable@vger.kernel.org
Reported-by: Meysam Firouzi
Reported-by: Amirmohammad Eftekhar
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Message-ID: <20240521122947.1080227-1-asmadeus@codewreck.org>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index f16f73581634..01338d4c2d9e 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -48,12 +48,17 @@ static int v9fs_cached_dentry_delete(const struct dentry *dentry)
 static void v9fs_dentry_release(struct dentry *dentry)
 {
 	struct hlist_node *p, *n;
+	struct hlist_head head;
 
 	p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p)\n",
 		 dentry, dentry);
-	hlist_for_each_safe(p, n, (struct hlist_head *)&dentry->d_fsdata)
+
+	spin_lock(&dentry->d_lock);
+	hlist_move_list((struct hlist_head *)&dentry->d_fsdata, &head);
+	spin_unlock(&dentry->d_lock);
+
+	hlist_for_each_safe(p, n, &head)
 		p9_fid_put(hlist_entry(p, struct p9_fid, dlist));
-	dentry->d_fsdata = NULL;
 }
 
 static int v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)


