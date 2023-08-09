Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94575775C63
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjHIL0w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjHIL0w (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:26:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308B51FD8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C353463297
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81A9C433C7;
        Wed,  9 Aug 2023 11:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580410;
        bh=mjbzUxHlJNAr6nscehvz3u18vDlGVe6pZChzPijcCoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FWyPky5Gg331HLL2LII6hJlPCBf2w4t+H9bVAjRq8DvvY5qTnXIwGUnikhhfswZ5t
         9OBati9+RngA9HY8Qn0g+WflwByE0PfQ8LAQK3sM7w6C3TrA+hzYxbtju82gwZgk9f
         Ij5w0y9TM1ehnBJXuJ29Nk4Bp04EUrEEvCkt1xIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Kara <jack@suse.cz>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 002/154] jbd2: fix kernel-doc markups
Date:   Wed,  9 Aug 2023 12:40:33 +0200
Message-ID: <20230809103636.985039684@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit 2bf31d94423c8ae3ff58e38a115b177df6940399 ]

Kernel-doc markup should use this format:
        identifier - description

They should not have any type before that, as otherwise
the parser won't do the right thing.

Also, some identifiers have different names between their
prototypes and the kernel-doc markup.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Link: https://lore.kernel.org/r/72f5c6628f5f278d67625f60893ffbc2ca28d46e.1605521731.git.mchehab+huawei@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: e34c8dd238d0 ("jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/journal.c     | 34 ++++++++++++++++++----------------
 fs/jbd2/transaction.c | 31 ++++++++++++++++---------------
 include/linux/jbd2.h  |  2 +-
 3 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 1fa88b5bb1cb0..eeebe64b7c543 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -562,12 +562,14 @@ static int __jbd2_journal_force_commit(journal_t *journal)
 }
 
 /**
- * Force and wait upon a commit if the calling process is not within
- * transaction.  This is used for forcing out undo-protected data which contains
- * bitmaps, when the fs is running out of space.
+ * jbd2_journal_force_commit_nested - Force and wait upon a commit if the
+ * calling process is not within transaction.
  *
  * @journal: journal to force
  * Returns true if progress was made.
+ *
+ * This is used for forcing out undo-protected data which contains
+ * bitmaps, when the fs is running out of space.
  */
 int jbd2_journal_force_commit_nested(journal_t *journal)
 {
@@ -578,7 +580,7 @@ int jbd2_journal_force_commit_nested(journal_t *journal)
 }
 
 /**
- * int journal_force_commit() - force any uncommitted transactions
+ * jbd2_journal_force_commit() - force any uncommitted transactions
  * @journal: journal to force
  *
  * Caller want unconditional commit. We can only force the running transaction
@@ -1634,7 +1636,7 @@ static int load_superblock(journal_t *journal)
 
 
 /**
- * int jbd2_journal_load() - Read journal from disk.
+ * jbd2_journal_load() - Read journal from disk.
  * @journal: Journal to act on.
  *
  * Given a journal_t structure which tells us which disk blocks contain
@@ -1704,7 +1706,7 @@ int jbd2_journal_load(journal_t *journal)
 }
 
 /**
- * void jbd2_journal_destroy() - Release a journal_t structure.
+ * jbd2_journal_destroy() - Release a journal_t structure.
  * @journal: Journal to act on.
  *
  * Release a journal_t structure once it is no longer in use by the
@@ -1780,7 +1782,7 @@ int jbd2_journal_destroy(journal_t *journal)
 
 
 /**
- *int jbd2_journal_check_used_features() - Check if features specified are used.
+ * jbd2_journal_check_used_features() - Check if features specified are used.
  * @journal: Journal to check.
  * @compat: bitmask of compatible features
  * @ro: bitmask of features that force read-only mount
@@ -1815,7 +1817,7 @@ int jbd2_journal_check_used_features(journal_t *journal, unsigned long compat,
 }
 
 /**
- * int jbd2_journal_check_available_features() - Check feature set in journalling layer
+ * jbd2_journal_check_available_features() - Check feature set in journalling layer
  * @journal: Journal to check.
  * @compat: bitmask of compatible features
  * @ro: bitmask of features that force read-only mount
@@ -1847,7 +1849,7 @@ int jbd2_journal_check_available_features(journal_t *journal, unsigned long comp
 }
 
 /**
- * int jbd2_journal_set_features() - Mark a given journal feature in the superblock
+ * jbd2_journal_set_features() - Mark a given journal feature in the superblock
  * @journal: Journal to act on.
  * @compat: bitmask of compatible features
  * @ro: bitmask of features that force read-only mount
@@ -1929,7 +1931,7 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
 }
 
 /*
- * jbd2_journal_clear_features () - Clear a given journal feature in the
+ * jbd2_journal_clear_features() - Clear a given journal feature in the
  * 				    superblock
  * @journal: Journal to act on.
  * @compat: bitmask of compatible features
@@ -1956,7 +1958,7 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
 EXPORT_SYMBOL(jbd2_journal_clear_features);
 
 /**
- * int jbd2_journal_flush () - Flush journal
+ * jbd2_journal_flush() - Flush journal
  * @journal: Journal to act on.
  *
  * Flush all data for a given journal to disk and empty the journal.
@@ -2031,7 +2033,7 @@ int jbd2_journal_flush(journal_t *journal)
 }
 
 /**
- * int jbd2_journal_wipe() - Wipe journal contents
+ * jbd2_journal_wipe() - Wipe journal contents
  * @journal: Journal to act on.
  * @write: flag (see below)
  *
@@ -2072,7 +2074,7 @@ int jbd2_journal_wipe(journal_t *journal, int write)
 }
 
 /**
- * void jbd2_journal_abort () - Shutdown the journal immediately.
+ * jbd2_journal_abort () - Shutdown the journal immediately.
  * @journal: the journal to shutdown.
  * @errno:   an error number to record in the journal indicating
  *           the reason for the shutdown.
@@ -2158,7 +2160,7 @@ void jbd2_journal_abort(journal_t *journal, int errno)
 }
 
 /**
- * int jbd2_journal_errno () - returns the journal's error state.
+ * jbd2_journal_errno() - returns the journal's error state.
  * @journal: journal to examine.
  *
  * This is the errno number set with jbd2_journal_abort(), the last
@@ -2182,7 +2184,7 @@ int jbd2_journal_errno(journal_t *journal)
 }
 
 /**
- * int jbd2_journal_clear_err () - clears the journal's error state
+ * jbd2_journal_clear_err() - clears the journal's error state
  * @journal: journal to act on.
  *
  * An error must be cleared or acked to take a FS out of readonly
@@ -2202,7 +2204,7 @@ int jbd2_journal_clear_err(journal_t *journal)
 }
 
 /**
- * void jbd2_journal_ack_err() - Ack journal err.
+ * jbd2_journal_ack_err() - Ack journal err.
  * @journal: journal to act on.
  *
  * An error must be cleared or acked to take a FS out of readonly
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 09f4d00fece2f..91c2d3f6d1b3b 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -490,7 +490,7 @@ EXPORT_SYMBOL(jbd2__journal_start);
 
 
 /**
- * handle_t *jbd2_journal_start() - Obtain a new handle.
+ * jbd2_journal_start() - Obtain a new handle.
  * @journal: Journal to start transaction on.
  * @nblocks: number of block buffer we might modify
  *
@@ -525,7 +525,7 @@ void jbd2_journal_free_reserved(handle_t *handle)
 EXPORT_SYMBOL(jbd2_journal_free_reserved);
 
 /**
- * int jbd2_journal_start_reserved() - start reserved handle
+ * jbd2_journal_start_reserved() - start reserved handle
  * @handle: handle to start
  * @type: for handle statistics
  * @line_no: for handle statistics
@@ -579,7 +579,7 @@ int jbd2_journal_start_reserved(handle_t *handle, unsigned int type,
 EXPORT_SYMBOL(jbd2_journal_start_reserved);
 
 /**
- * int jbd2_journal_extend() - extend buffer credits.
+ * jbd2_journal_extend() - extend buffer credits.
  * @handle:  handle to 'extend'
  * @nblocks: nr blocks to try to extend by.
  *
@@ -659,7 +659,7 @@ int jbd2_journal_extend(handle_t *handle, int nblocks)
 
 
 /**
- * int jbd2_journal_restart() - restart a handle .
+ * jbd2__journal_restart() - restart a handle .
  * @handle:  handle to restart
  * @nblocks: nr credits requested
  * @gfp_mask: memory allocation flags (for start_this_handle)
@@ -736,7 +736,7 @@ int jbd2_journal_restart(handle_t *handle, int nblocks)
 EXPORT_SYMBOL(jbd2_journal_restart);
 
 /**
- * void jbd2_journal_lock_updates () - establish a transaction barrier.
+ * jbd2_journal_lock_updates () - establish a transaction barrier.
  * @journal:  Journal to establish a barrier on.
  *
  * This locks out any further updates from being started, and blocks
@@ -795,7 +795,7 @@ void jbd2_journal_lock_updates(journal_t *journal)
 }
 
 /**
- * void jbd2_journal_unlock_updates (journal_t* journal) - release barrier
+ * jbd2_journal_unlock_updates () - release barrier
  * @journal:  Journal to release the barrier on.
  *
  * Release a transaction barrier obtained with jbd2_journal_lock_updates().
@@ -1103,7 +1103,8 @@ static bool jbd2_write_access_granted(handle_t *handle, struct buffer_head *bh,
 }
 
 /**
- * int jbd2_journal_get_write_access() - notify intent to modify a buffer for metadata (not data) update.
+ * jbd2_journal_get_write_access() - notify intent to modify a buffer
+ *				     for metadata (not data) update.
  * @handle: transaction to add buffer modifications to
  * @bh:     bh to be used for metadata writes
  *
@@ -1147,7 +1148,7 @@ int jbd2_journal_get_write_access(handle_t *handle, struct buffer_head *bh)
  * unlocked buffer beforehand. */
 
 /**
- * int jbd2_journal_get_create_access () - notify intent to use newly created bh
+ * jbd2_journal_get_create_access () - notify intent to use newly created bh
  * @handle: transaction to new buffer to
  * @bh: new buffer.
  *
@@ -1227,7 +1228,7 @@ int jbd2_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
 }
 
 /**
- * int jbd2_journal_get_undo_access() -  Notify intent to modify metadata with
+ * jbd2_journal_get_undo_access() -  Notify intent to modify metadata with
  *     non-rewindable consequences
  * @handle: transaction
  * @bh: buffer to undo
@@ -1304,7 +1305,7 @@ int jbd2_journal_get_undo_access(handle_t *handle, struct buffer_head *bh)
 }
 
 /**
- * void jbd2_journal_set_triggers() - Add triggers for commit writeout
+ * jbd2_journal_set_triggers() - Add triggers for commit writeout
  * @bh: buffer to trigger on
  * @type: struct jbd2_buffer_trigger_type containing the trigger(s).
  *
@@ -1346,7 +1347,7 @@ void jbd2_buffer_abort_trigger(struct journal_head *jh,
 }
 
 /**
- * int jbd2_journal_dirty_metadata() -  mark a buffer as containing dirty metadata
+ * jbd2_journal_dirty_metadata() -  mark a buffer as containing dirty metadata
  * @handle: transaction to add buffer to.
  * @bh: buffer to mark
  *
@@ -1524,7 +1525,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 }
 
 /**
- * void jbd2_journal_forget() - bforget() for potentially-journaled buffers.
+ * jbd2_journal_forget() - bforget() for potentially-journaled buffers.
  * @handle: transaction handle
  * @bh:     bh to 'forget'
  *
@@ -1699,7 +1700,7 @@ int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
 }
 
 /**
- * int jbd2_journal_stop() - complete a transaction
+ * jbd2_journal_stop() - complete a transaction
  * @handle: transaction to complete.
  *
  * All done for a particular handle.
@@ -2047,7 +2048,7 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
 }
 
 /**
- * int jbd2_journal_try_to_free_buffers() - try to free page buffers.
+ * jbd2_journal_try_to_free_buffers() - try to free page buffers.
  * @journal: journal for operation
  * @page: to try and free
  * @gfp_mask: we use the mask to detect how hard should we try to release
@@ -2386,7 +2387,7 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 }
 
 /**
- * void jbd2_journal_invalidatepage()
+ * jbd2_journal_invalidatepage()
  * @journal: journal to use for flush...
  * @page:    page to flush
  * @offset:  start of the range to invalidate
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index b0e97e5de8ca4..b60adc4210b57 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -415,7 +415,7 @@ static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
 #define JI_WAIT_DATA (1 << __JI_WAIT_DATA)
 
 /**
- * struct jbd_inode - The jbd_inode type is the structure linking inodes in
+ * struct jbd2_inode - The jbd_inode type is the structure linking inodes in
  * ordered mode present in a transaction so that we can sync them during commit.
  */
 struct jbd2_inode {
-- 
2.39.2



