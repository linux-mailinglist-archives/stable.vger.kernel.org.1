Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1170F713F27
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjE1Tmb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjE1Tm3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:42:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93383C9
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3165A61EEF
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB96C433D2;
        Sun, 28 May 2023 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302947;
        bh=DgYrxm3x9YTBdF4xZMNWWtnN6XYj8piU96W9ttS+FJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6gauR5NAJaBWveO2zyp++Gvlsk8zU3iK6gKAz+z041EEvbHHIp0V2Bp6LoQBfn0x
         lf39sPCn+rQldejevMb7W3FcHUl/hgJUhzVF7xnzfpS4APJnjXil3B1AI/TOQEoZJh
         HSQzB2NI53ag02kRyIrEWpuCWJguzaO3mhxZtgxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 084/211] btrfs: move btrfs_find_highest_objectid/btrfs_find_free_objectid to disk-io.c
Date:   Sun, 28 May 2023 20:10:05 +0100
Message-Id: <20230528190845.709762698@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

[ Upstream commit ec7d6dfd73b2de1c6bc36f832542061b0ca0e0ff ]

Those functions are going to be used even after inode cache is removed
so moved them to a more appropriate place.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 0004ff15ea26 ("btrfs: fix space cache inconsistency after error loading it from disk")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c   | 55 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/disk-io.h   |  2 ++
 fs/btrfs/inode-map.c | 55 --------------------------------------------
 fs/btrfs/inode-map.h |  3 ---
 4 files changed, 57 insertions(+), 58 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2a7778a88f03b..095c9e4f92248 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4780,3 +4780,58 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 
 	return 0;
 }
+
+int btrfs_find_highest_objectid(struct btrfs_root *root, u64 *objectid)
+{
+	struct btrfs_path *path;
+	int ret;
+	struct extent_buffer *l;
+	struct btrfs_key search_key;
+	struct btrfs_key found_key;
+	int slot;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	search_key.objectid = BTRFS_LAST_FREE_OBJECTID;
+	search_key.type = -1;
+	search_key.offset = (u64)-1;
+	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
+	if (ret < 0)
+		goto error;
+	BUG_ON(ret == 0); /* Corruption */
+	if (path->slots[0] > 0) {
+		slot = path->slots[0] - 1;
+		l = path->nodes[0];
+		btrfs_item_key_to_cpu(l, &found_key, slot);
+		*objectid = max_t(u64, found_key.objectid,
+				  BTRFS_FIRST_FREE_OBJECTID - 1);
+	} else {
+		*objectid = BTRFS_FIRST_FREE_OBJECTID - 1;
+	}
+	ret = 0;
+error:
+	btrfs_free_path(path);
+	return ret;
+}
+
+int btrfs_find_free_objectid(struct btrfs_root *root, u64 *objectid)
+{
+	int ret;
+	mutex_lock(&root->objectid_mutex);
+
+	if (unlikely(root->highest_objectid >= BTRFS_LAST_FREE_OBJECTID)) {
+		btrfs_warn(root->fs_info,
+			   "the objectid of root %llu reaches its highest value",
+			   root->root_key.objectid);
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	*objectid = ++root->highest_objectid;
+	ret = 0;
+out:
+	mutex_unlock(&root->objectid_mutex);
+	return ret;
+}
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 182540bdcea0f..e3b96944ce10c 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -131,6 +131,8 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 int btree_lock_page_hook(struct page *page, void *data,
 				void (*flush_fn)(void *));
 int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
+int btrfs_find_free_objectid(struct btrfs_root *root, u64 *objectid);
+int btrfs_find_highest_objectid(struct btrfs_root *root, u64 *objectid);
 int __init btrfs_end_io_wq_init(void);
 void __cold btrfs_end_io_wq_exit(void);
 
diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
index 76d2e43817eae..c74340d22624e 100644
--- a/fs/btrfs/inode-map.c
+++ b/fs/btrfs/inode-map.c
@@ -525,58 +525,3 @@ int btrfs_save_ino_cache(struct btrfs_root *root,
 	extent_changeset_free(data_reserved);
 	return ret;
 }
-
-int btrfs_find_highest_objectid(struct btrfs_root *root, u64 *objectid)
-{
-	struct btrfs_path *path;
-	int ret;
-	struct extent_buffer *l;
-	struct btrfs_key search_key;
-	struct btrfs_key found_key;
-	int slot;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	search_key.objectid = BTRFS_LAST_FREE_OBJECTID;
-	search_key.type = -1;
-	search_key.offset = (u64)-1;
-	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
-	if (ret < 0)
-		goto error;
-	BUG_ON(ret == 0); /* Corruption */
-	if (path->slots[0] > 0) {
-		slot = path->slots[0] - 1;
-		l = path->nodes[0];
-		btrfs_item_key_to_cpu(l, &found_key, slot);
-		*objectid = max_t(u64, found_key.objectid,
-				  BTRFS_FIRST_FREE_OBJECTID - 1);
-	} else {
-		*objectid = BTRFS_FIRST_FREE_OBJECTID - 1;
-	}
-	ret = 0;
-error:
-	btrfs_free_path(path);
-	return ret;
-}
-
-int btrfs_find_free_objectid(struct btrfs_root *root, u64 *objectid)
-{
-	int ret;
-	mutex_lock(&root->objectid_mutex);
-
-	if (unlikely(root->highest_objectid >= BTRFS_LAST_FREE_OBJECTID)) {
-		btrfs_warn(root->fs_info,
-			   "the objectid of root %llu reaches its highest value",
-			   root->root_key.objectid);
-		ret = -ENOSPC;
-		goto out;
-	}
-
-	*objectid = ++root->highest_objectid;
-	ret = 0;
-out:
-	mutex_unlock(&root->objectid_mutex);
-	return ret;
-}
diff --git a/fs/btrfs/inode-map.h b/fs/btrfs/inode-map.h
index 7a962811dffe0..629baf9aefb15 100644
--- a/fs/btrfs/inode-map.h
+++ b/fs/btrfs/inode-map.h
@@ -10,7 +10,4 @@ int btrfs_find_free_ino(struct btrfs_root *root, u64 *objectid);
 int btrfs_save_ino_cache(struct btrfs_root *root,
 			 struct btrfs_trans_handle *trans);
 
-int btrfs_find_free_objectid(struct btrfs_root *root, u64 *objectid);
-int btrfs_find_highest_objectid(struct btrfs_root *root, u64 *objectid);
-
 #endif
-- 
2.39.2



