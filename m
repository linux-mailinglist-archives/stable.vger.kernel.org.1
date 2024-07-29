Return-Path: <stable+bounces-62449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5A993F243
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788C9285424
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D09140378;
	Mon, 29 Jul 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S6T6MPAd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525884A50
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247832; cv=none; b=UFRylnhMULGlqKtYOpjdThDZHC5PSptToCafiZ4adSM79to0DaHlpmOcCEptKnxFRtzmJiW3q/Dt2By2TnQ0DXE63MRecqEgYJBaxIUks9Ysp4OYoHGgbDhNgUqqh1KWdjpgdgoZBfW4t57yTE1p4MFIgQ5DkrBqRcT/iDfynAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247832; c=relaxed/simple;
	bh=XoZx3pJHFliTiC5Lv0x0YzaVNJ4G+03jjyXw2fopAmI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HjEVm56c1aBZH0Vag5j7X7yJLZdq1xdRpjjIf1HxreUW+nedBTvuRVspW00ter61bgMrZGvpeXKL3EwlVG2ArCh73y+GUpzHg+lrONf/laDH3fui8JO3OIUPNOZ/1DzI4OmfIBf/9JMWLAVhqslDMpr+8O0Oof2VrP+vhttnPXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S6T6MPAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472E2C32786;
	Mon, 29 Jul 2024 10:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722247831;
	bh=XoZx3pJHFliTiC5Lv0x0YzaVNJ4G+03jjyXw2fopAmI=;
	h=Subject:To:Cc:From:Date:From;
	b=S6T6MPAdrAjNC8uFZrXVufSNzYphJsXoryyZA6R4GoQxzNOEnCt1grnfVUTifbC2I
	 apOW8TL3JVmhB9r3ydFSe+k9B/D1g6fxTf/6cpN6218WoJ9NJPt/PY94TLCIR6aGFG
	 8a13fr0eDG7PyCRKhNUxg8dAaxGz7j2rjDQ1pQwA=
Subject: FAILED: patch "[PATCH] udf: Avoid using corrupted block bitmap buffer" failed to apply to 4.19-stable tree
To: jack@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:10:28 +0200
Message-ID: <2024072927-stubbly-curler-09c4@gregkh>
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
git cherry-pick -x a90d4471146de21745980cba51ce88e7926bcc4f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072927-stubbly-curler-09c4@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

a90d4471146d ("udf: Avoid using corrupted block bitmap buffer")
1e0d4adf17e7 ("udf: Check consistency of Space Bitmap Descriptor")
101ee137d32a ("udf: Drop VARCONV support")
a27b2923de7e ("udf: Move udf_expand_dir_adinicb() to its callsite")
57bda9fb169d ("udf: Convert udf_expand_dir_adinicb() to new directory iteration")
d16076d9b684 ("udf: New directory iteration code")
e4ae4735f7c2 ("udf: use sb_bdev_nr_blocks")
b64533344371 ("udf: Fix iocharset=utf8 mount option")
979a6e28dd96 ("udf: Get rid of 0-length arrays in struct fileIdentDesc")
fa236c2b2d44 ("udf: Fix NULL pointer dereference in udf_symlink function")
382a2287bf9c ("udf: Remove pointless union in udf_inode_info")
044e2e26f214 ("udf: Avoid accessing uninitialized data on failed inode read")
8b075e5ba459 ("udf: stop using ioctl_by_bdev")
4eb09e111218 ("fs-udf: Delete an unnecessary check before brelse()")
ab9a3a737284 ("udf: reduce leakage of blocks related to named streams")
a768a9abc625 ("udf: Explain handling of load_nls() failure")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a90d4471146de21745980cba51ce88e7926bcc4f Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 17 Jun 2024 17:41:52 +0200
Subject: [PATCH] udf: Avoid using corrupted block bitmap buffer

When the filesystem block bitmap is corrupted, we detect the corruption
while loading the bitmap and fail the allocation with error. However the
next allocation from the same bitmap will notice the bitmap buffer is
already loaded and tries to allocate from the bitmap with mixed results
(depending on the exact nature of the bitmap corruption). Fix the
problem by using BH_verified bit to indicate whether the bitmap is valid
or not.

Reported-by: syzbot+5f682cd029581f9edfd1@syzkaller.appspotmail.com
CC: stable@vger.kernel.org
Link: https://patch.msgid.link/20240617154201.29512-2-jack@suse.cz
Fixes: 1e0d4adf17e7 ("udf: Check consistency of Space Bitmap Descriptor")
Signed-off-by: Jan Kara <jack@suse.cz>

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index ab3ffc355949..558ad046972a 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -64,8 +64,12 @@ static int read_block_bitmap(struct super_block *sb,
 	}
 
 	for (i = 0; i < count; i++)
-		if (udf_test_bit(i + off, bh->b_data))
+		if (udf_test_bit(i + off, bh->b_data)) {
+			bitmap->s_block_bitmap[bitmap_nr] =
+							ERR_PTR(-EFSCORRUPTED);
+			brelse(bh);
 			return -EFSCORRUPTED;
+		}
 	return 0;
 }
 
@@ -81,8 +85,15 @@ static int __load_block_bitmap(struct super_block *sb,
 			  block_group, nr_groups);
 	}
 
-	if (bitmap->s_block_bitmap[block_group])
+	if (bitmap->s_block_bitmap[block_group]) {
+		/*
+		 * The bitmap failed verification in the past. No point in
+		 * trying again.
+		 */
+		if (IS_ERR(bitmap->s_block_bitmap[block_group]))
+			return PTR_ERR(bitmap->s_block_bitmap[block_group]);
 		return block_group;
+	}
 
 	retval = read_block_bitmap(sb, bitmap, block_group, block_group);
 	if (retval < 0)
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 9381a66c6ce5..92d477053905 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -336,7 +336,8 @@ static void udf_sb_free_bitmap(struct udf_bitmap *bitmap)
 	int nr_groups = bitmap->s_nr_groups;
 
 	for (i = 0; i < nr_groups; i++)
-		brelse(bitmap->s_block_bitmap[i]);
+		if (!IS_ERR_OR_NULL(bitmap->s_block_bitmap[i]))
+			brelse(bitmap->s_block_bitmap[i]);
 
 	kvfree(bitmap);
 }


