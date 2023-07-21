Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E624D75BE4B
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 08:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGUGIi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 02:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGUGIh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 02:08:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9960B10E5
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 23:08:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2068C612B3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 06:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1C6C433C7;
        Fri, 21 Jul 2023 06:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689919714;
        bh=u/hrr0wCpHGYH7Q6u8Q2sZv2t2kpNAdTtICEbiKyCzg=;
        h=Subject:To:Cc:From:Date:From;
        b=lJmMhlr+MrGTSuKONZ1cOT+EVGMdcJT3usjBpwmiv2G1z6o3qxr5hE7eMhwA0tLZf
         zsxNPEhwdkcg2EkxzqPKqIJswiyfqBpuW5oDO6FfSEA22uuOEWtYaT3Z2Ys8qN+2Oo
         vpc3XSuhXa1g0gGRIBW0rKXg3ehY3cJheGGnc824=
Subject: FAILED: patch "[PATCH] dm thin metadata: Fix ABBA deadlock by resetting" failed to apply to 5.15-stable tree
To:     lilingfeng3@huawei.com, snitzer@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 08:08:28 +0200
Message-ID: <2023072128-verdict-thinner-97f6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d48300120627a1cb98914738fff38b424625b8ad
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072128-verdict-thinner-97f6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

d48300120627 ("dm thin metadata: Fix ABBA deadlock by resetting dm_bufio_client")
cf2e309ebca7 ("mm: shrinkers: convert shrinker_rwsem to mutex")
b3cabea3c915 ("mm: vmscan: hold write lock to reparent shrinker nr_deferred")
caa05325c912 ("mm: vmscan: make memcg slab shrink lockless")
f95bdb700bc6 ("mm: vmscan: make global slab shrink lockless")
42c9db397048 ("mm: vmscan: add a map_nr_max field to shrinker_info")
3822a7c40997 ("Merge tag 'mm-stable-2023-02-20-13-37' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d48300120627a1cb98914738fff38b424625b8ad Mon Sep 17 00:00:00 2001
From: Li Lingfeng <lilingfeng3@huawei.com>
Date: Mon, 5 Jun 2023 15:03:16 +0800
Subject: [PATCH] dm thin metadata: Fix ABBA deadlock by resetting
 dm_bufio_client

As described in commit 8111964f1b85 ("dm thin: Fix ABBA deadlock between
shrink_slab and dm_pool_abort_metadata"), ABBA deadlocks will be
triggered because shrinker_rwsem currently needs to held by
dm_pool_abort_metadata() as a side-effect of thin-pool metadata
operation failure.

The following three problem scenarios have been noticed:

1) Described by commit 8111964f1b85 ("dm thin: Fix ABBA deadlock between
   shrink_slab and dm_pool_abort_metadata")

2) shrinker_rwsem and throttle->lock
          P1(drop cache)                        P2(kworker)
drop_caches_sysctl_handler
 drop_slab
  shrink_slab
   down_read(&shrinker_rwsem)  - LOCK A
   do_shrink_slab
    super_cache_scan
     prune_icache_sb
      dispose_list
       evict
        ext4_evict_inode
         ext4_clear_inode
          ext4_discard_preallocations
           ext4_mb_load_buddy_gfp
            ext4_mb_init_cache
             ext4_wait_block_bitmap
              __ext4_error
               ext4_handle_error
                ext4_commit_super
                 ...
                 dm_submit_bio
                                     do_worker
                                      throttle_work_update
                                       down_write(&t->lock) -- LOCK B
                                      process_deferred_bios
                                       commit
                                        metadata_operation_failed
                                         dm_pool_abort_metadata
                                          dm_block_manager_create
                                           dm_bufio_client_create
                                            register_shrinker
                                             down_write(&shrinker_rwsem)
                                             -- LOCK A
                 thin_map
                  thin_bio_map
                   thin_defer_bio_with_throttle
                    throttle_lock
                     down_read(&t->lock)  - LOCK B

3) shrinker_rwsem and wait_on_buffer
          P1(drop cache)                            P2(kworker)
drop_caches_sysctl_handler
 drop_slab
  shrink_slab
   down_read(&shrinker_rwsem)  - LOCK A
   do_shrink_slab
   ...
    ext4_wait_block_bitmap
     __ext4_error
      ext4_handle_error
       jbd2_journal_abort
        jbd2_journal_update_sb_errno
         jbd2_write_superblock
          submit_bh
           // LOCK B
           // RELEASE B
                             do_worker
                              throttle_work_update
                               down_write(&t->lock) - LOCK B
                              process_deferred_bios
                               process_bio
                               commit
                                metadata_operation_failed
                                 dm_pool_abort_metadata
                                  dm_block_manager_create
                                   dm_bufio_client_create
                                    register_shrinker
                                     register_shrinker_prepared
                                      down_write(&shrinker_rwsem)  - LOCK A
                               bio_endio
      wait_on_buffer
       __wait_on_buffer

Fix these by resetting dm_bufio_client without holding shrinker_rwsem.

Fixes: 8111964f1b85 ("dm thin: Fix ABBA deadlock between shrink_slab and dm_pool_abort_metadata")
Cc: stable@vger.kernel.org
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index eea977662e81..a7079b38756a 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -2592,6 +2592,13 @@ void dm_bufio_client_destroy(struct dm_bufio_client *c)
 }
 EXPORT_SYMBOL_GPL(dm_bufio_client_destroy);
 
+void dm_bufio_client_reset(struct dm_bufio_client *c)
+{
+	drop_buffers(c);
+	flush_work(&c->shrink_work);
+}
+EXPORT_SYMBOL_GPL(dm_bufio_client_reset);
+
 void dm_bufio_set_sector_offset(struct dm_bufio_client *c, sector_t start)
 {
 	c->start = start;
diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
index 9f5cb52c5763..63d92d388ee6 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -603,6 +603,8 @@ static int __format_metadata(struct dm_pool_metadata *pmd)
 	r = dm_tm_create_with_sm(pmd->bm, THIN_SUPERBLOCK_LOCATION,
 				 &pmd->tm, &pmd->metadata_sm);
 	if (r < 0) {
+		pmd->tm = NULL;
+		pmd->metadata_sm = NULL;
 		DMERR("tm_create_with_sm failed");
 		return r;
 	}
@@ -611,6 +613,7 @@ static int __format_metadata(struct dm_pool_metadata *pmd)
 	if (IS_ERR(pmd->data_sm)) {
 		DMERR("sm_disk_create failed");
 		r = PTR_ERR(pmd->data_sm);
+		pmd->data_sm = NULL;
 		goto bad_cleanup_tm;
 	}
 
@@ -641,11 +644,15 @@ static int __format_metadata(struct dm_pool_metadata *pmd)
 
 bad_cleanup_nb_tm:
 	dm_tm_destroy(pmd->nb_tm);
+	pmd->nb_tm = NULL;
 bad_cleanup_data_sm:
 	dm_sm_destroy(pmd->data_sm);
+	pmd->data_sm = NULL;
 bad_cleanup_tm:
 	dm_tm_destroy(pmd->tm);
+	pmd->tm = NULL;
 	dm_sm_destroy(pmd->metadata_sm);
+	pmd->metadata_sm = NULL;
 
 	return r;
 }
@@ -711,6 +718,8 @@ static int __open_metadata(struct dm_pool_metadata *pmd)
 			       sizeof(disk_super->metadata_space_map_root),
 			       &pmd->tm, &pmd->metadata_sm);
 	if (r < 0) {
+		pmd->tm = NULL;
+		pmd->metadata_sm = NULL;
 		DMERR("tm_open_with_sm failed");
 		goto bad_unlock_sblock;
 	}
@@ -720,6 +729,7 @@ static int __open_metadata(struct dm_pool_metadata *pmd)
 	if (IS_ERR(pmd->data_sm)) {
 		DMERR("sm_disk_open failed");
 		r = PTR_ERR(pmd->data_sm);
+		pmd->data_sm = NULL;
 		goto bad_cleanup_tm;
 	}
 
@@ -746,9 +756,12 @@ static int __open_metadata(struct dm_pool_metadata *pmd)
 
 bad_cleanup_data_sm:
 	dm_sm_destroy(pmd->data_sm);
+	pmd->data_sm = NULL;
 bad_cleanup_tm:
 	dm_tm_destroy(pmd->tm);
+	pmd->tm = NULL;
 	dm_sm_destroy(pmd->metadata_sm);
+	pmd->metadata_sm = NULL;
 bad_unlock_sblock:
 	dm_bm_unlock(sblock);
 
@@ -795,9 +808,13 @@ static void __destroy_persistent_data_objects(struct dm_pool_metadata *pmd,
 					      bool destroy_bm)
 {
 	dm_sm_destroy(pmd->data_sm);
+	pmd->data_sm = NULL;
 	dm_sm_destroy(pmd->metadata_sm);
+	pmd->metadata_sm = NULL;
 	dm_tm_destroy(pmd->nb_tm);
+	pmd->nb_tm = NULL;
 	dm_tm_destroy(pmd->tm);
+	pmd->tm = NULL;
 	if (destroy_bm)
 		dm_block_manager_destroy(pmd->bm);
 }
@@ -1005,8 +1022,7 @@ int dm_pool_metadata_close(struct dm_pool_metadata *pmd)
 			       __func__, r);
 	}
 	pmd_write_unlock(pmd);
-	if (!pmd->fail_io)
-		__destroy_persistent_data_objects(pmd, true);
+	__destroy_persistent_data_objects(pmd, true);
 
 	kfree(pmd);
 	return 0;
@@ -1877,53 +1893,29 @@ static void __set_abort_with_changes_flags(struct dm_pool_metadata *pmd)
 int dm_pool_abort_metadata(struct dm_pool_metadata *pmd)
 {
 	int r = -EINVAL;
-	struct dm_block_manager *old_bm = NULL, *new_bm = NULL;
 
 	/* fail_io is double-checked with pmd->root_lock held below */
 	if (unlikely(pmd->fail_io))
 		return r;
 
-	/*
-	 * Replacement block manager (new_bm) is created and old_bm destroyed outside of
-	 * pmd root_lock to avoid ABBA deadlock that would result (due to life-cycle of
-	 * shrinker associated with the block manager's bufio client vs pmd root_lock).
-	 * - must take shrinker_mutex without holding pmd->root_lock
-	 */
-	new_bm = dm_block_manager_create(pmd->bdev, THIN_METADATA_BLOCK_SIZE << SECTOR_SHIFT,
-					 THIN_MAX_CONCURRENT_LOCKS);
-
 	pmd_write_lock(pmd);
 	if (pmd->fail_io) {
 		pmd_write_unlock(pmd);
-		goto out;
+		return r;
 	}
-
 	__set_abort_with_changes_flags(pmd);
+
+	/* destroy data_sm/metadata_sm/nb_tm/tm */
 	__destroy_persistent_data_objects(pmd, false);
-	old_bm = pmd->bm;
-	if (IS_ERR(new_bm)) {
-		DMERR("could not create block manager during abort");
-		pmd->bm = NULL;
-		r = PTR_ERR(new_bm);
-		goto out_unlock;
-	}
 
-	pmd->bm = new_bm;
+	/* reset bm */
+	dm_block_manager_reset(pmd->bm);
+
+	/* rebuild data_sm/metadata_sm/nb_tm/tm */
 	r = __open_or_format_metadata(pmd, false);
-	if (r) {
-		pmd->bm = NULL;
-		goto out_unlock;
-	}
-	new_bm = NULL;
-out_unlock:
 	if (r)
 		pmd->fail_io = true;
 	pmd_write_unlock(pmd);
-	dm_block_manager_destroy(old_bm);
-out:
-	if (new_bm && !IS_ERR(new_bm))
-		dm_block_manager_destroy(new_bm);
-
 	return r;
 }
 
diff --git a/drivers/md/persistent-data/dm-block-manager.c b/drivers/md/persistent-data/dm-block-manager.c
index 7bdfc23f758a..0e010e1204aa 100644
--- a/drivers/md/persistent-data/dm-block-manager.c
+++ b/drivers/md/persistent-data/dm-block-manager.c
@@ -421,6 +421,12 @@ void dm_block_manager_destroy(struct dm_block_manager *bm)
 }
 EXPORT_SYMBOL_GPL(dm_block_manager_destroy);
 
+void dm_block_manager_reset(struct dm_block_manager *bm)
+{
+	dm_bufio_client_reset(bm->bufio);
+}
+EXPORT_SYMBOL_GPL(dm_block_manager_reset);
+
 unsigned int dm_bm_block_size(struct dm_block_manager *bm)
 {
 	return dm_bufio_get_block_size(bm->bufio);
diff --git a/drivers/md/persistent-data/dm-block-manager.h b/drivers/md/persistent-data/dm-block-manager.h
index 5746b0f82a03..f706d3de8d5a 100644
--- a/drivers/md/persistent-data/dm-block-manager.h
+++ b/drivers/md/persistent-data/dm-block-manager.h
@@ -36,6 +36,7 @@ struct dm_block_manager *dm_block_manager_create(
 	struct block_device *bdev, unsigned int block_size,
 	unsigned int max_held_per_thread);
 void dm_block_manager_destroy(struct dm_block_manager *bm);
+void dm_block_manager_reset(struct dm_block_manager *bm);
 
 unsigned int dm_bm_block_size(struct dm_block_manager *bm);
 dm_block_t dm_bm_nr_blocks(struct dm_block_manager *bm);
diff --git a/drivers/md/persistent-data/dm-space-map.h b/drivers/md/persistent-data/dm-space-map.h
index dab490353781..6bf69922b5ad 100644
--- a/drivers/md/persistent-data/dm-space-map.h
+++ b/drivers/md/persistent-data/dm-space-map.h
@@ -77,7 +77,8 @@ struct dm_space_map {
 
 static inline void dm_sm_destroy(struct dm_space_map *sm)
 {
-	sm->destroy(sm);
+	if (sm)
+		sm->destroy(sm);
 }
 
 static inline int dm_sm_extend(struct dm_space_map *sm, dm_block_t extra_blocks)
diff --git a/drivers/md/persistent-data/dm-transaction-manager.c b/drivers/md/persistent-data/dm-transaction-manager.c
index 6dc016248baf..c88fa6266203 100644
--- a/drivers/md/persistent-data/dm-transaction-manager.c
+++ b/drivers/md/persistent-data/dm-transaction-manager.c
@@ -199,6 +199,9 @@ EXPORT_SYMBOL_GPL(dm_tm_create_non_blocking_clone);
 
 void dm_tm_destroy(struct dm_transaction_manager *tm)
 {
+	if (!tm)
+		return;
+
 	if (!tm->is_clone)
 		wipe_shadow_table(tm);
 
diff --git a/include/linux/dm-bufio.h b/include/linux/dm-bufio.h
index 681656a1c03d..75e7d8cbb532 100644
--- a/include/linux/dm-bufio.h
+++ b/include/linux/dm-bufio.h
@@ -38,6 +38,8 @@ dm_bufio_client_create(struct block_device *bdev, unsigned int block_size,
  */
 void dm_bufio_client_destroy(struct dm_bufio_client *c);
 
+void dm_bufio_client_reset(struct dm_bufio_client *c);
+
 /*
  * Set the sector range.
  * When this function is called, there must be no I/O in progress on the bufio

