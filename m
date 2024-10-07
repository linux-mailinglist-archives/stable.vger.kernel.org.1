Return-Path: <stable+bounces-81286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70E6992BBE
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 14:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490CCB23510
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3541D2229;
	Mon,  7 Oct 2024 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r2JHGCWV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C68C18C015
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304165; cv=none; b=CY5o/LqtBQbRQ64zMGGjn6Oke8O4Nou1iW924J+o3vWONWHENG2LnJxyNvn7b82w0sYCYLYpaOwdk5sDpNY946RQZXyjumMO0rmpEjOLpEVp2mXcApp1FC+9la8n0mExI9lwzDc2qUw6Kh3l561Cu/s0L7rYSy9zQX+nfHyqkmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304165; c=relaxed/simple;
	bh=uzfRT8JKQ9+YTiCNqKntRLqbgmYo8ekwUPODEHiXXvs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uprRXbP63R51QoNstANgQnZBOCrvnH7LEs+i/C9quz5jvFRx5TtxgEII14q6r+VKXCQh6UGnzsEbSzBwHGwYj8jtAf+CF1l1E+B8uC7qTK+nfu2Ta+JzYb7BFZpYk14z+cI1xzXXIPCkFr4CFai4N4NR1GkFe3K9PVdh3nQoVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r2JHGCWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A39C4CEC6;
	Mon,  7 Oct 2024 12:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728304164;
	bh=uzfRT8JKQ9+YTiCNqKntRLqbgmYo8ekwUPODEHiXXvs=;
	h=Subject:To:Cc:From:Date:From;
	b=r2JHGCWVgMJcl8UdZd1nKOs/EhvJnBNKQvt1dI+eK0oBkJEOMlKXZTN6noXc1vcQA
	 q55Nz5aLe5v4MA6R0F+Uol5RVQ5IH42B1WWCmVKqYijla+2kEp+iFto6asp3LjCnnL
	 CPdxXzwXBXn21zyfY3gWpNAYVp2NypCY4GryFXG8=
Subject: FAILED: patch "[PATCH] ext4: update orig_path in ext4_find_extent()" failed to apply to 4.19-stable tree
To: libaokun1@huawei.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 14:29:22 +0200
Message-ID: <2024100721-bouncy-retreat-a211@gregkh>
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
git cherry-pick -x 5b4b2dcace35f618fe361a87bae6f0d13af31bc1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100721-bouncy-retreat-a211@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

5b4b2dcace35 ("ext4: update orig_path in ext4_find_extent()")
c26ab35702f8 ("ext4: fix slab-use-after-free in ext4_split_extent_at()")
082cd4ec240b ("ext4: fix bug on in ext4_es_cache_extent as ext4_split_extent_at failed")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b4b2dcace35f618fe361a87bae6f0d13af31bc1 Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun1@huawei.com>
Date: Thu, 22 Aug 2024 10:35:25 +0800
Subject: [PATCH] ext4: update orig_path in ext4_find_extent()

In ext4_find_extent(), if the path is not big enough, we free it and set
*orig_path to NULL. But after reallocating and successfully initializing
the path, we don't update *orig_path, in which case the caller gets a
valid path but a NULL ppath, and this may cause a NULL pointer dereference
or a path memory leak. For example:

ext4_split_extent
  path = *ppath = 2000
  ext4_find_extent
    if (depth > path[0].p_maxdepth)
      kfree(path = 2000);
      *orig_path = path = NULL;
      path = kcalloc() = 3000
  ext4_split_extent_at(*ppath = NULL)
    path = *ppath;
    ex = path[depth].p_ext;
    // NULL pointer dereference!

==================================================================
BUG: kernel NULL pointer dereference, address: 0000000000000010
CPU: 6 UID: 0 PID: 576 Comm: fsstress Not tainted 6.11.0-rc2-dirty #847
RIP: 0010:ext4_split_extent_at+0x6d/0x560
Call Trace:
 <TASK>
 ext4_split_extent.isra.0+0xcb/0x1b0
 ext4_ext_convert_to_initialized+0x168/0x6c0
 ext4_ext_handle_unwritten_extents+0x325/0x4d0
 ext4_ext_map_blocks+0x520/0xdb0
 ext4_map_blocks+0x2b0/0x690
 ext4_iomap_begin+0x20e/0x2c0
[...]
==================================================================

Therefore, *orig_path is updated when the extent lookup succeeds, so that
the caller can safely use path or *ppath.

Fixes: 10809df84a4d ("ext4: teach ext4_ext_find_extent() to realloc path if necessary")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20240822023545.1994557-6-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index caef91356557..c8e7676f6af9 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -957,6 +957,8 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 
 	ext4_ext_show_path(inode, path);
 
+	if (orig_path)
+		*orig_path = path;
 	return path;
 
 err:
@@ -3268,7 +3270,6 @@ static int ext4_split_extent_at(handle_t *handle,
 	}
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
-	*ppath = path;
 
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
 		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 516897b0218e..228b56f7d047 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -36,7 +36,6 @@ get_ext_path(struct inode *inode, ext4_lblk_t lblock,
 		*ppath = NULL;
 		return -ENODATA;
 	}
-	*ppath = path;
 	return 0;
 }
 


