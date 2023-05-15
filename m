Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5636F703795
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243760AbjEORW7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbjEORWn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:22:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4584120BB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CA4462C4F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218F3C433EF;
        Mon, 15 May 2023 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171230;
        bh=VBWOec6NQIRi806vB/+Fc3YRQsKjTu60+8ZeoLGuOXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CChcX1GeEyftK+sJApTv78Gi3OScojJ9iBnRZYqFUgKoI5P3VUIjBy/HvUrwZxXjh
         +JCyISck8CtEK2DrK9Uky7CSOmiB6Pij/HFPUYepAENm/22NJoMQT66F24FwB0FIGk
         x39/qKgdvdvnpsT0EJJjMjfe39+y2jcX47g4kLng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.2 135/242] btrfs: make clear_cache mount option to rebuild FST without disabling it
Date:   Mon, 15 May 2023 18:27:41 +0200
Message-Id: <20230515161725.952871313@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

commit 1d6a4fc85717677e00fefffd847a50fc5928ce69 upstream.

Previously clear_cache mount option would simply disable free-space-tree
feature temporarily then re-enable it to rebuild the whole free space
tree.

But this is problematic for block-group-tree feature, as we have an
artificial dependency on free-space-tree feature.

If we go the existing method, after clearing the free-space-tree
feature, we would flip the filesystem to read-only mode, as we detect a
super block write with block-group-tree but no free-space-tree feature.

This patch would change the behavior by properly rebuilding the free
space tree without disabling this feature, thus allowing clear_cache
mount option to work with block group tree.

Now we can mount a filesystem with block-group-tree feature and
clear_mount option:

  $ mkfs.btrfs  -O block-group-tree /dev/test/scratch1  -f
  $ sudo mount /dev/test/scratch1 /mnt/btrfs -o clear_cache
  $ sudo dmesg -t | head -n 5
  BTRFS info (device dm-1): force clearing of disk cache
  BTRFS info (device dm-1): using free space tree
  BTRFS info (device dm-1): auto enabling async discard
  BTRFS info (device dm-1): rebuilding free space tree
  BTRFS info (device dm-1): checking UUID tree

CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c         |   25 ++++++++++++++++------
 fs/btrfs/free-space-tree.c |   50 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/free-space-tree.h |    3 +-
 fs/btrfs/super.c           |    3 --
 4 files changed, 70 insertions(+), 11 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3306,23 +3306,34 @@ int btrfs_start_pre_rw_mount(struct btrf
 {
 	int ret;
 	const bool cache_opt = btrfs_test_opt(fs_info, SPACE_CACHE);
-	bool clear_free_space_tree = false;
+	bool rebuild_free_space_tree = false;
 
 	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
 	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
-		clear_free_space_tree = true;
+		rebuild_free_space_tree = true;
 	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
 		   !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
 		btrfs_warn(fs_info, "free space tree is invalid");
-		clear_free_space_tree = true;
+		rebuild_free_space_tree = true;
 	}
 
-	if (clear_free_space_tree) {
-		btrfs_info(fs_info, "clearing free space tree");
-		ret = btrfs_clear_free_space_tree(fs_info);
+	if (rebuild_free_space_tree) {
+		btrfs_info(fs_info, "rebuilding free space tree");
+		ret = btrfs_rebuild_free_space_tree(fs_info);
 		if (ret) {
 			btrfs_warn(fs_info,
-				   "failed to clear free space tree: %d", ret);
+				   "failed to rebuild free space tree: %d", ret);
+			goto out;
+		}
+	}
+
+	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+	    !btrfs_test_opt(fs_info, FREE_SPACE_TREE)) {
+		btrfs_info(fs_info, "disabling free space tree");
+		ret = btrfs_delete_free_space_tree(fs_info);
+		if (ret) {
+			btrfs_warn(fs_info,
+				   "failed to disable free space tree: %d", ret);
 			goto out;
 		}
 	}
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1252,7 +1252,7 @@ out:
 	return ret;
 }
 
-int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
+int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *tree_root = fs_info->tree_root;
@@ -1295,6 +1295,54 @@ int btrfs_clear_free_space_tree(struct b
 abort:
 	btrfs_abort_transaction(trans, ret);
 	btrfs_end_transaction(trans);
+	return ret;
+}
+
+int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_key key = {
+		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+	struct btrfs_root *free_space_root = btrfs_global_root(fs_info, &key);
+	struct rb_node *node;
+	int ret;
+
+	trans = btrfs_start_transaction(free_space_root, 1);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	set_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
+	set_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
+
+	ret = clear_free_space_tree(trans, free_space_root);
+	if (ret)
+		goto abort;
+
+	node = rb_first_cached(&fs_info->block_group_cache_tree);
+	while (node) {
+		struct btrfs_block_group *block_group;
+
+		block_group = rb_entry(node, struct btrfs_block_group,
+				       cache_node);
+		ret = populate_free_space_tree(trans, block_group);
+		if (ret)
+			goto abort;
+		node = rb_next(node);
+	}
+
+	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE);
+	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
+	clear_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
+
+	ret = btrfs_commit_transaction(trans);
+	clear_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
+	return ret;
+abort:
+	btrfs_abort_transaction(trans, ret);
+	btrfs_end_transaction(trans);
 	return ret;
 }
 
--- a/fs/btrfs/free-space-tree.h
+++ b/fs/btrfs/free-space-tree.h
@@ -18,7 +18,8 @@ struct btrfs_caching_control;
 
 void set_free_space_tree_thresholds(struct btrfs_block_group *block_group);
 int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info);
-int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info);
+int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info);
+int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info);
 int load_free_space_tree(struct btrfs_caching_control *caching_ctl);
 int add_block_group_free_space(struct btrfs_trans_handle *trans,
 			       struct btrfs_block_group *block_group);
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -827,8 +827,7 @@ out:
 		ret = -EINVAL;
 	}
 	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
-	    (btrfs_test_opt(info, CLEAR_CACHE) ||
-	     !btrfs_test_opt(info, FREE_SPACE_TREE))) {
+	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
 		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
 		ret = -EINVAL;
 	}


