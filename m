Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B825C783247
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjHUUEI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHUUEH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:04:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B372EA8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:04:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C120648A9
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4503CC433C7;
        Mon, 21 Aug 2023 20:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648244;
        bh=SCYwbt4veiTOzYc9EpcMiu+jnqhV65nFWDA1vBR30XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6ChSAgSOsaak/te6xX1k+ifV+qkXHZzAcWWXXzFjZSFrdHWk946CGKy+W4U1Pa7H
         Cl8wvCV5J5pkjQ38YxSE23cIRcYAVb2zHI/eqm1ptukjYcPN4xelLzZTw7WHEhUHHL
         Vwxv88X+varHqNIdwEdBg0TtY9AH2iXl3kM0z0jo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Landley <rob@landley.net>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 107/234] btrfs: fix infinite directory reads
Date:   Mon, 21 Aug 2023 21:41:10 +0200
Message-ID: <20230821194133.552391662@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit 9b378f6ad48cfa195ed868db9123c09ee7ec5ea2 upstream.

The readdir implementation currently processes always up to the last index
it finds. This however can result in an infinite loop if the directory has
a large number of entries such that they won't all fit in the given buffer
passed to the readdir callback, that is, dir_emit() returns a non-zero
value. Because in that case readdir() will be called again and if in the
meanwhile new directory entries were added and we still can't put all the
remaining entries in the buffer, we keep repeating this over and over.

The following C program and test script reproduce the problem:

  $ cat /mnt/readdir_prog.c
  #include <sys/types.h>
  #include <dirent.h>
  #include <stdio.h>

  int main(int argc, char *argv[])
  {
    DIR *dir = opendir(".");
    struct dirent *dd;

    while ((dd = readdir(dir))) {
      printf("%s\n", dd->d_name);
      rename(dd->d_name, "TEMPFILE");
      rename("TEMPFILE", dd->d_name);
    }
    closedir(dir);
  }

  $ gcc -o /mnt/readdir_prog /mnt/readdir_prog.c

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdi
  MNT=/mnt/sdi

  mkfs.btrfs -f $DEV &> /dev/null
  #mkfs.xfs -f $DEV &> /dev/null
  #mkfs.ext4 -F $DEV &> /dev/null

  mount $DEV $MNT

  mkdir $MNT/testdir
  for ((i = 1; i <= 2000; i++)); do
      echo -n > $MNT/testdir/file_$i
  done

  cd $MNT/testdir
  /mnt/readdir_prog

  cd /mnt

  umount $MNT

This behaviour is surprising to applications and it's unlike ext4, xfs,
tmpfs, vfat and other filesystems, which always finish. In this case where
new entries were added due to renames, some file names may be reported
more than once, but this varies according to each filesystem - for example
ext4 never reported the same file more than once while xfs reports the
first 13 file names twice.

So change our readdir implementation to track the last index number when
opendir() is called and then make readdir() never process beyond that
index number. This gives the same behaviour as ext4.

Reported-by: Rob Landley <rob@landley.net>
Link: https://lore.kernel.org/linux-btrfs/2c8c55ec-04c6-e0dc-9c5c-8c7924778c35@landley.net/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217681
CC: stable@vger.kernel.org # 6.4+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.h         |    1 
 fs/btrfs/delayed-inode.c |    5 +
 fs/btrfs/delayed-inode.h |    1 
 fs/btrfs/inode.c         |  131 ++++++++++++++++++++++++++++-------------------
 4 files changed, 84 insertions(+), 54 deletions(-)

--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -443,6 +443,7 @@ struct btrfs_drop_extents_args {
 
 struct btrfs_file_private {
 	void *filldir_buf;
+	u64 last_index;
 	struct extent_state *llseek_cached_state;
 };
 
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1632,6 +1632,7 @@ int btrfs_inode_delayed_dir_index_count(
 }
 
 bool btrfs_readdir_get_delayed_items(struct inode *inode,
+				     u64 last_index,
 				     struct list_head *ins_list,
 				     struct list_head *del_list)
 {
@@ -1651,14 +1652,14 @@ bool btrfs_readdir_get_delayed_items(str
 
 	mutex_lock(&delayed_node->mutex);
 	item = __btrfs_first_delayed_insertion_item(delayed_node);
-	while (item) {
+	while (item && item->index <= last_index) {
 		refcount_inc(&item->refs);
 		list_add_tail(&item->readdir_list, ins_list);
 		item = __btrfs_next_delayed_item(item);
 	}
 
 	item = __btrfs_first_delayed_deletion_item(delayed_node);
-	while (item) {
+	while (item && item->index <= last_index) {
 		refcount_inc(&item->refs);
 		list_add_tail(&item->readdir_list, del_list);
 		item = __btrfs_next_delayed_item(item);
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -148,6 +148,7 @@ void btrfs_destroy_delayed_inodes(struct
 
 /* Used for readdir() */
 bool btrfs_readdir_get_delayed_items(struct inode *inode,
+				     u64 last_index,
 				     struct list_head *ins_list,
 				     struct list_head *del_list);
 void btrfs_readdir_put_delayed_items(struct inode *inode,
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5745,6 +5745,74 @@ static struct dentry *btrfs_lookup(struc
 }
 
 /*
+ * Find the highest existing sequence number in a directory and then set the
+ * in-memory index_cnt variable to the first free sequence number.
+ */
+static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
+{
+	struct btrfs_root *root = inode->root;
+	struct btrfs_key key, found_key;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	int ret;
+
+	key.objectid = btrfs_ino(inode);
+	key.type = BTRFS_DIR_INDEX_KEY;
+	key.offset = (u64)-1;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+	/* FIXME: we should be able to handle this */
+	if (ret == 0)
+		goto out;
+	ret = 0;
+
+	if (path->slots[0] == 0) {
+		inode->index_cnt = BTRFS_DIR_START_INDEX;
+		goto out;
+	}
+
+	path->slots[0]--;
+
+	leaf = path->nodes[0];
+	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+
+	if (found_key.objectid != btrfs_ino(inode) ||
+	    found_key.type != BTRFS_DIR_INDEX_KEY) {
+		inode->index_cnt = BTRFS_DIR_START_INDEX;
+		goto out;
+	}
+
+	inode->index_cnt = found_key.offset + 1;
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
+static int btrfs_get_dir_last_index(struct btrfs_inode *dir, u64 *index)
+{
+	if (dir->index_cnt == (u64)-1) {
+		int ret;
+
+		ret = btrfs_inode_delayed_dir_index_count(dir);
+		if (ret) {
+			ret = btrfs_set_inode_index_count(dir);
+			if (ret)
+				return ret;
+		}
+	}
+
+	*index = dir->index_cnt;
+
+	return 0;
+}
+
+/*
  * All this infrastructure exists because dir_emit can fault, and we are holding
  * the tree lock when doing readdir.  For now just allocate a buffer and copy
  * our information into that, and then dir_emit from the buffer.  This is
@@ -5756,10 +5824,17 @@ static struct dentry *btrfs_lookup(struc
 static int btrfs_opendir(struct inode *inode, struct file *file)
 {
 	struct btrfs_file_private *private;
+	u64 last_index;
+	int ret;
+
+	ret = btrfs_get_dir_last_index(BTRFS_I(inode), &last_index);
+	if (ret)
+		return ret;
 
 	private = kzalloc(sizeof(struct btrfs_file_private), GFP_KERNEL);
 	if (!private)
 		return -ENOMEM;
+	private->last_index = last_index;
 	private->filldir_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!private->filldir_buf) {
 		kfree(private);
@@ -5826,7 +5901,8 @@ static int btrfs_real_readdir(struct fil
 
 	INIT_LIST_HEAD(&ins_list);
 	INIT_LIST_HEAD(&del_list);
-	put = btrfs_readdir_get_delayed_items(inode, &ins_list, &del_list);
+	put = btrfs_readdir_get_delayed_items(inode, private->last_index,
+					      &ins_list, &del_list);
 
 again:
 	key.type = BTRFS_DIR_INDEX_KEY;
@@ -5844,6 +5920,8 @@ again:
 			break;
 		if (found_key.offset < ctx->pos)
 			continue;
+		if (found_key.offset > private->last_index)
+			break;
 		if (btrfs_should_delete_dir_index(&del_list, found_key.offset))
 			continue;
 		di = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dir_item);
@@ -5980,57 +6058,6 @@ static int btrfs_update_time(struct inod
 }
 
 /*
- * find the highest existing sequence number in a directory
- * and then set the in-memory index_cnt variable to reflect
- * free sequence numbers
- */
-static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
-{
-	struct btrfs_root *root = inode->root;
-	struct btrfs_key key, found_key;
-	struct btrfs_path *path;
-	struct extent_buffer *leaf;
-	int ret;
-
-	key.objectid = btrfs_ino(inode);
-	key.type = BTRFS_DIR_INDEX_KEY;
-	key.offset = (u64)-1;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-	/* FIXME: we should be able to handle this */
-	if (ret == 0)
-		goto out;
-	ret = 0;
-
-	if (path->slots[0] == 0) {
-		inode->index_cnt = BTRFS_DIR_START_INDEX;
-		goto out;
-	}
-
-	path->slots[0]--;
-
-	leaf = path->nodes[0];
-	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
-
-	if (found_key.objectid != btrfs_ino(inode) ||
-	    found_key.type != BTRFS_DIR_INDEX_KEY) {
-		inode->index_cnt = BTRFS_DIR_START_INDEX;
-		goto out;
-	}
-
-	inode->index_cnt = found_key.offset + 1;
-out:
-	btrfs_free_path(path);
-	return ret;
-}
-
-/*
  * helper to find a free sequence number in a given directory.  This current
  * code is very simple, later versions will do smarter things in the btree
  */


