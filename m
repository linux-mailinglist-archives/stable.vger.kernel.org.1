Return-Path: <stable+bounces-81287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B51992BC1
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 14:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5BC281C26
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE911C2324;
	Mon,  7 Oct 2024 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tCrEcwK6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4B01C173D
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304234; cv=none; b=GX8uB5V00Yt9EYCWnVD5fLupp2oVEbd09Fr3n/zVz7SPjdK0vdT5WYkhXYlJfqq+d//37jmX3tILzUmuRGzlHMXY4i85/iqktwS3pFT41Rd1rWumC94sq7UF3r+6pl+7e92CZEHtcSSURFdEOVZ0IkXk/jcDkjqvCJ9dvJIuTyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304234; c=relaxed/simple;
	bh=T0Z9iz6c1AK6wM7GYBpTS83Qob/rQ9KMjl46ApFJbGY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z0RGWy1UeRW1B+nQRTnVa5Vi9K5QqckaRmoc+D/Cf7AqSlAjqHOeEpmJ6x+827isk9A3EcJO4mV/9EDDBzLjZOdLQ+qdgTrYprthWOqHVas5Xq+8ja3FuRgihrlVmpIxO64UUPNuBkOfwhrQ+EuusU0e5GSXfqOtWlDZn7f2aOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tCrEcwK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0A0C4CECC;
	Mon,  7 Oct 2024 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728304233;
	bh=T0Z9iz6c1AK6wM7GYBpTS83Qob/rQ9KMjl46ApFJbGY=;
	h=Subject:To:Cc:From:Date:From;
	b=tCrEcwK6XrovNuj/Y2lYqxSjUrFzy4VNdBcnpYJQHqwYrIC5TdSBMzbD5JfiYHuxK
	 uJiHVBjCaaOdE5NEUb+cbMWoPr8xWgJt1+wwnxVo7gZ35qrwL3BeQ8D5ztKzgmD5He
	 03GNyiX9a05EczjzJYHZl1TIkyqUREHmIHiDGbkU=
Subject: FAILED: patch "[PATCH] ext4: fix slab-use-after-free in ext4_split_extent_at()" failed to apply to 5.4-stable tree
To: libaokun1@huawei.com,jack@suse.cz,ojaswin@linux.ibm.com,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 14:30:30 +0200
Message-ID: <2024100730-plural-bobble-031b@gregkh>
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
git cherry-pick -x c26ab35702f8cd0cdc78f96aa5856bfb77be798f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100730-plural-bobble-031b@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

c26ab35702f8 ("ext4: fix slab-use-after-free in ext4_split_extent_at()")
082cd4ec240b ("ext4: fix bug on in ext4_es_cache_extent as ext4_split_extent_at failed")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c26ab35702f8cd0cdc78f96aa5856bfb77be798f Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun1@huawei.com>
Date: Thu, 22 Aug 2024 10:35:23 +0800
Subject: [PATCH] ext4: fix slab-use-after-free in ext4_split_extent_at()

We hit the following use-after-free:

==================================================================
BUG: KASAN: slab-use-after-free in ext4_split_extent_at+0xba8/0xcc0
Read of size 2 at addr ffff88810548ed08 by task kworker/u20:0/40
CPU: 0 PID: 40 Comm: kworker/u20:0 Not tainted 6.9.0-dirty #724
Call Trace:
 <TASK>
 kasan_report+0x93/0xc0
 ext4_split_extent_at+0xba8/0xcc0
 ext4_split_extent.isra.0+0x18f/0x500
 ext4_split_convert_extents+0x275/0x750
 ext4_ext_handle_unwritten_extents+0x73e/0x1580
 ext4_ext_map_blocks+0xe20/0x2dc0
 ext4_map_blocks+0x724/0x1700
 ext4_do_writepages+0x12d6/0x2a70
[...]

Allocated by task 40:
 __kmalloc_noprof+0x1ac/0x480
 ext4_find_extent+0xf3b/0x1e70
 ext4_ext_map_blocks+0x188/0x2dc0
 ext4_map_blocks+0x724/0x1700
 ext4_do_writepages+0x12d6/0x2a70
[...]

Freed by task 40:
 kfree+0xf1/0x2b0
 ext4_find_extent+0xa71/0x1e70
 ext4_ext_insert_extent+0xa22/0x3260
 ext4_split_extent_at+0x3ef/0xcc0
 ext4_split_extent.isra.0+0x18f/0x500
 ext4_split_convert_extents+0x275/0x750
 ext4_ext_handle_unwritten_extents+0x73e/0x1580
 ext4_ext_map_blocks+0xe20/0x2dc0
 ext4_map_blocks+0x724/0x1700
 ext4_do_writepages+0x12d6/0x2a70
[...]
==================================================================

The flow of issue triggering is as follows:

ext4_split_extent_at
  path = *ppath
  ext4_ext_insert_extent(ppath)
    ext4_ext_create_new_leaf(ppath)
      ext4_find_extent(orig_path)
        path = *orig_path
        read_extent_tree_block
          // return -ENOMEM or -EIO
        ext4_free_ext_path(path)
          kfree(path)
        *orig_path = NULL
  a. If err is -ENOMEM:
  ext4_ext_dirty(path + path->p_depth)
  // path use-after-free !!!
  b. If err is -EIO and we have EXT_DEBUG defined:
  ext4_ext_show_leaf(path)
    eh = path[depth].p_hdr
    // path also use-after-free !!!

So when trying to zeroout or fix the extent length, call ext4_find_extent()
to update the path.

In addition we use *ppath directly as an ext4_ext_show_leaf() input to
avoid possible use-after-free when EXT_DEBUG is defined, and to avoid
unnecessary path updates.

Fixes: dfe5080939ea ("ext4: drop EXT4_EX_NOFREE_ON_ERR from rest of extents handling code")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20240822023545.1994557-4-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 4395e2b668ec..fe6bca63f9d6 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3251,6 +3251,25 @@ static int ext4_split_extent_at(handle_t *handle,
 	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
 		goto out;
 
+	/*
+	 * Update path is required because previous ext4_ext_insert_extent()
+	 * may have freed or reallocated the path. Using EXT4_EX_NOFAIL
+	 * guarantees that ext4_find_extent() will not return -ENOMEM,
+	 * otherwise -ENOMEM will cause a retry in do_writepages(), and a
+	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
+	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
+	 */
+	path = ext4_find_extent(inode, ee_block, ppath,
+				flags | EXT4_EX_NOFAIL);
+	if (IS_ERR(path)) {
+		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
+				 split, PTR_ERR(path));
+		return PTR_ERR(path);
+	}
+	depth = ext_depth(inode);
+	ex = path[depth].p_ext;
+	*ppath = path;
+
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
 		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
 			if (split_flag & EXT4_EXT_DATA_VALID1) {
@@ -3303,7 +3322,7 @@ static int ext4_split_extent_at(handle_t *handle,
 	ext4_ext_dirty(handle, inode, path + path->p_depth);
 	return err;
 out:
-	ext4_ext_show_leaf(inode, path);
+	ext4_ext_show_leaf(inode, *ppath);
 	return err;
 }
 


