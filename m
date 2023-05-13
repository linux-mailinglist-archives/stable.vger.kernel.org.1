Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104AF70149C
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 08:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjEMGbK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 02:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMGbJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 02:31:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C012121
        for <stable@vger.kernel.org>; Fri, 12 May 2023 23:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4D4D60A7C
        for <stable@vger.kernel.org>; Sat, 13 May 2023 06:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F3BC433EF;
        Sat, 13 May 2023 06:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683959467;
        bh=crV1sVfIr8vEnPygKGUIb0whl5ETh9Gy6ESLoNDnjWc=;
        h=Subject:To:Cc:From:Date:From;
        b=R4pEM7OuNKr+tooFMz21oiV/JhmXfLuZzJgtqtOSO4IGSySyxB3cbERwZfiUni39+
         P88AgHWR13QqKlEod7ecWw9XEw/uiv6EHcf8NYGviECiEP7VZGTfCfaL11V7QmuF3x
         A1FW1lboFU+VLM4+M10ud4pYyRS1Nl22BPhu0ZX8=
Subject: FAILED: patch "[PATCH] btrfs: fix encoded write i_size corruption with no-holes" failed to apply to 5.10-stable tree
To:     boris@bur.io, dsterba@suse.com, josef@toxicpanda.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 15:30:55 +0900
Message-ID: <2023051355-such-snowfall-6415@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e7db9e5c6b9615b287d01f0231904fbc1fbde9c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051355-such-snowfall-6415@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

e7db9e5c6b96 ("btrfs: fix encoded write i_size corruption with no-holes")
76aea5379678 ("btrfs: make btrfs_inode_safe_disk_i_size_write take btrfs_inode")
2766ff61762c ("btrfs: update the number of bytes used by an inode atomically")
5893dfb98f25 ("btrfs: refactor btrfs_drop_extents() to make it easier to extend")
ac5887c8e013 ("btrfs: locking: remove all the blocking helpers")
a14b78ad06ab ("btrfs: introduce btrfs_inode_lock()/unlock()")
b8d8e1fd570a ("btrfs: introduce btrfs_write_check()")
c86537a42f86 ("btrfs: check FS error state bit early during write")
5e8b9ef30392 ("btrfs: move pos increment and pagecache extension to btrfs_buffered_write")
4e4cabece9f9 ("btrfs: split btrfs_direct_IO to read and write")
196d59ab9ccc ("btrfs: switch extent buffer tree lock to rw_semaphore")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e7db9e5c6b9615b287d01f0231904fbc1fbde9c5 Mon Sep 17 00:00:00 2001
From: Boris Burkov <boris@bur.io>
Date: Fri, 28 Apr 2023 14:02:11 -0700
Subject: [PATCH] btrfs: fix encoded write i_size corruption with no-holes

We have observed a btrfs filesystem corruption on workloads using
no-holes and encoded writes via send stream v2. The symptom is that a
file appears to be truncated to the end of its last aligned extent, even
though the final unaligned extent and even the file extent and otherwise
correctly updated inode item have been written.

So if we were writing out a 1MiB+X file via 8 128K extents and one
extent of length X, i_size would be set to 1MiB, but the ninth extent,
nbyte, etc. would all appear correct otherwise.

The source of the race is a narrow (one line of code) window in which a
no-holes fs has read in an updated i_size, but has not yet set a shared
disk_i_size variable to write. Therefore, if two ordered extents run in
parallel (par for the course for receive workloads), the following
sequence can play out: (following "threads" a bit loosely, since there
are callbacks involved for endio but extra threads aren't needed to
cause the issue)

  ENC-WR1 (second to last)                                         ENC-WR2 (last)
  -------                                                          -------
  btrfs_do_encoded_write
    set i_size = 1M
    submit bio B1 ending at 1M
  endio B1
  btrfs_inode_safe_disk_i_size_write
    local i_size = 1M
    falls off a cliff for some reason
							      btrfs_do_encoded_write
								set i_size = 1M+X
								submit bio B2 ending at 1M+X
							      endio B2
							      btrfs_inode_safe_disk_i_size_write
								local i_size = 1M+X
								disk_i_size = 1M+X
    disk_i_size = 1M
							      btrfs_delayed_update_inode
    btrfs_delayed_update_inode

And the delayed inode ends up filled with nbytes=1M+X and isize=1M, and
writes respect i_size and present a corrupted file missing its last
extents.

Fix this by holding the inode lock in the no-holes case so that a thread
can't sneak in a write to disk_i_size that gets overwritten with an out
of date i_size.

Fixes: 41a2ee75aab0 ("btrfs: introduce per-inode file extent tree")
CC: stable@vger.kernel.org # 5.10+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 018c711a0bc8..cd4cce9ba443 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -52,13 +52,13 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 	u64 start, end, i_size;
 	int ret;
 
+	spin_lock(&inode->lock);
 	i_size = new_i_size ?: i_size_read(&inode->vfs_inode);
 	if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
 		inode->disk_i_size = i_size;
-		return;
+		goto out_unlock;
 	}
 
-	spin_lock(&inode->lock);
 	ret = find_contiguous_extent_bit(&inode->file_extent_tree, 0, &start,
 					 &end, EXTENT_DIRTY);
 	if (!ret && start == 0)
@@ -66,6 +66,7 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 	else
 		i_size = 0;
 	inode->disk_i_size = i_size;
+out_unlock:
 	spin_unlock(&inode->lock);
 }
 

