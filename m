Return-Path: <stable+bounces-8981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8B08205B3
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7195B282330
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269AB8483;
	Sat, 30 Dec 2023 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aXDsQP32"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD95B79DD;
	Sat, 30 Dec 2023 12:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F574C433C8;
	Sat, 30 Dec 2023 12:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938264;
	bh=sQjf2bYnJ9XkgObSIqZhtpCXjCSj+zGFroTzr22yV+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXDsQP320bK9mMexFpSEVdXB4zymkqhNJtbtYsFQB4lpffFO/P+pLl1afMDX7HFCT
	 8RhsSAc1gXAdpncC6L4o3RkoFQNQSGwsKMeHLQgrWB0+twYFkXWdhumtm+rrvgjc4Z
	 f6Oo+FEh9Sw+z1CpQhxXclccnExmJsSIcDdW5GNA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 090/112] dm thin metadata: Fix ABBA deadlock by resetting dm_bufio_client
Date: Sat, 30 Dec 2023 12:00:03 +0000
Message-ID: <20231230115809.704889392@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Lingfeng <lilingfeng3@huawei.com>

[ Upstream commit d48300120627a1cb98914738fff38b424625b8ad ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-bufio.c                         |  7 +++
 drivers/md/dm-thin-metadata.c                 | 58 ++++++++-----------
 drivers/md/persistent-data/dm-block-manager.c |  6 ++
 drivers/md/persistent-data/dm-block-manager.h |  1 +
 drivers/md/persistent-data/dm-space-map.h     |  3 +-
 .../persistent-data/dm-transaction-manager.c  |  3 +
 include/linux/dm-bufio.h                      |  2 +
 7 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 382c5cc471952..100a6a236d92a 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1914,6 +1914,13 @@ void dm_bufio_client_destroy(struct dm_bufio_client *c)
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
index 4a0e15109997b..bb0e0a270f62a 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -597,6 +597,8 @@ static int __format_metadata(struct dm_pool_metadata *pmd)
 	r = dm_tm_create_with_sm(pmd->bm, THIN_SUPERBLOCK_LOCATION,
 				 &pmd->tm, &pmd->metadata_sm);
 	if (r < 0) {
+		pmd->tm = NULL;
+		pmd->metadata_sm = NULL;
 		DMERR("tm_create_with_sm failed");
 		return r;
 	}
@@ -605,6 +607,7 @@ static int __format_metadata(struct dm_pool_metadata *pmd)
 	if (IS_ERR(pmd->data_sm)) {
 		DMERR("sm_disk_create failed");
 		r = PTR_ERR(pmd->data_sm);
+		pmd->data_sm = NULL;
 		goto bad_cleanup_tm;
 	}
 
@@ -635,11 +638,15 @@ static int __format_metadata(struct dm_pool_metadata *pmd)
 
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
@@ -705,6 +712,8 @@ static int __open_metadata(struct dm_pool_metadata *pmd)
 			       sizeof(disk_super->metadata_space_map_root),
 			       &pmd->tm, &pmd->metadata_sm);
 	if (r < 0) {
+		pmd->tm = NULL;
+		pmd->metadata_sm = NULL;
 		DMERR("tm_open_with_sm failed");
 		goto bad_unlock_sblock;
 	}
@@ -714,6 +723,7 @@ static int __open_metadata(struct dm_pool_metadata *pmd)
 	if (IS_ERR(pmd->data_sm)) {
 		DMERR("sm_disk_open failed");
 		r = PTR_ERR(pmd->data_sm);
+		pmd->data_sm = NULL;
 		goto bad_cleanup_tm;
 	}
 
@@ -740,9 +750,12 @@ static int __open_metadata(struct dm_pool_metadata *pmd)
 
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
 
@@ -789,9 +802,13 @@ static void __destroy_persistent_data_objects(struct dm_pool_metadata *pmd,
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
@@ -999,8 +1016,7 @@ int dm_pool_metadata_close(struct dm_pool_metadata *pmd)
 			       __func__, r);
 	}
 	pmd_write_unlock(pmd);
-	if (!pmd->fail_io)
-		__destroy_persistent_data_objects(pmd, true);
+	__destroy_persistent_data_objects(pmd, true);
 
 	kfree(pmd);
 	return 0;
@@ -1875,53 +1891,29 @@ static void __set_abort_with_changes_flags(struct dm_pool_metadata *pmd)
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
-	 * - must take shrinker_rwsem without holding pmd->root_lock
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
index 1f40100908d7c..2bbfbb704c751 100644
--- a/drivers/md/persistent-data/dm-block-manager.c
+++ b/drivers/md/persistent-data/dm-block-manager.c
@@ -415,6 +415,12 @@ void dm_block_manager_destroy(struct dm_block_manager *bm)
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
index 58a23b8ec1902..4371d85d3c258 100644
--- a/drivers/md/persistent-data/dm-block-manager.h
+++ b/drivers/md/persistent-data/dm-block-manager.h
@@ -35,6 +35,7 @@ struct dm_block_manager *dm_block_manager_create(
 	struct block_device *bdev, unsigned int block_size,
 	unsigned int max_held_per_thread);
 void dm_block_manager_destroy(struct dm_block_manager *bm);
+void dm_block_manager_reset(struct dm_block_manager *bm);
 
 unsigned int dm_bm_block_size(struct dm_block_manager *bm);
 dm_block_t dm_bm_nr_blocks(struct dm_block_manager *bm);
diff --git a/drivers/md/persistent-data/dm-space-map.h b/drivers/md/persistent-data/dm-space-map.h
index a015cd11f6e97..85aa0a3974fe0 100644
--- a/drivers/md/persistent-data/dm-space-map.h
+++ b/drivers/md/persistent-data/dm-space-map.h
@@ -76,7 +76,8 @@ struct dm_space_map {
 
 static inline void dm_sm_destroy(struct dm_space_map *sm)
 {
-	sm->destroy(sm);
+	if (sm)
+		sm->destroy(sm);
 }
 
 static inline int dm_sm_extend(struct dm_space_map *sm, dm_block_t extra_blocks)
diff --git a/drivers/md/persistent-data/dm-transaction-manager.c b/drivers/md/persistent-data/dm-transaction-manager.c
index 39885f8355847..557a3ecfe75a0 100644
--- a/drivers/md/persistent-data/dm-transaction-manager.c
+++ b/drivers/md/persistent-data/dm-transaction-manager.c
@@ -197,6 +197,9 @@ EXPORT_SYMBOL_GPL(dm_tm_create_non_blocking_clone);
 
 void dm_tm_destroy(struct dm_transaction_manager *tm)
 {
+	if (!tm)
+		return;
+
 	if (!tm->is_clone)
 		wipe_shadow_table(tm);
 
diff --git a/include/linux/dm-bufio.h b/include/linux/dm-bufio.h
index 1262d92ab88fc..2e71ca35942e9 100644
--- a/include/linux/dm-bufio.h
+++ b/include/linux/dm-bufio.h
@@ -37,6 +37,8 @@ dm_bufio_client_create(struct block_device *bdev, unsigned int block_size,
  */
 void dm_bufio_client_destroy(struct dm_bufio_client *c);
 
+void dm_bufio_client_reset(struct dm_bufio_client *c);
+
 /*
  * Set the sector range.
  * When this function is called, there must be no I/O in progress on the bufio
-- 
2.43.0




