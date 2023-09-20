Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38407A8186
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbjITMqU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbjITMqQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:46:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AB192
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:46:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CC9C433C9;
        Wed, 20 Sep 2023 12:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213967;
        bh=E+HFiD5Lopuu1naoTJImm2Cz4FkLjJU0prd6Ylqr0vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6jRORW6ZKiMug6OSht1LFygthyQvUeV1OWNUvADL0nIaSw5cVHo/yG4lgoMk51CB
         d67guM5vh9NLXiLEWKyKq/E5RUmo/2kq3+4TbHn67T6xZ9kxofNKTsqijBWuZvS/c9
         FpSypQptFmJXebCLdRFUHg3Eki+JuZ/s9u5ELy3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Kara <jack@suse.cz>,
        Lukas Czerner <lczerner@redhat.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 064/110] jbd2: rename jbd_debug() to jbd2_debug()
Date:   Wed, 20 Sep 2023 13:32:02 +0200
Message-ID: <20230920112832.810546053@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

[ Upstream commit cb3b3bf22cf33707d684e74207908ba0ef3b6467 ]

The name of jbd_debug() is confusing as all functions inside jbd2 have
jbd2_ prefix. Rename jbd_debug() to jbd2_debug(). No functional changes.

Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Link: https://lore.kernel.org/r/20220608112355.4397-2-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 2dfba3bb40ad ("jbd2: correct the end of the journal recovery scan range")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/checkpoint.c  |  6 +++---
 fs/jbd2/commit.c      | 30 +++++++++++++++---------------
 fs/jbd2/journal.c     | 34 +++++++++++++++++-----------------
 fs/jbd2/recovery.c    | 30 +++++++++++++++---------------
 fs/jbd2/revoke.c      |  8 ++++----
 fs/jbd2/transaction.c | 26 +++++++++++++-------------
 include/linux/jbd2.h  |  4 ++--
 7 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 95d5bb7d825a6..f033ac807013c 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -165,7 +165,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 	tid_t			this_tid;
 	int			result, batch_count = 0;
 
-	jbd_debug(1, "Start checkpoint\n");
+	jbd2_debug(1, "Start checkpoint\n");
 
 	/*
 	 * First thing: if there are any transactions in the log which
@@ -174,7 +174,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 	 */
 	result = jbd2_cleanup_journal_tail(journal);
 	trace_jbd2_checkpoint(journal, result);
-	jbd_debug(1, "cleanup_journal_tail returned %d\n", result);
+	jbd2_debug(1, "cleanup_journal_tail returned %d\n", result);
 	if (result <= 0)
 		return result;
 
@@ -725,5 +725,5 @@ void __jbd2_journal_drop_transaction(journal_t *journal, transaction_t *transact
 
 	trace_jbd2_drop_transaction(journal, transaction);
 
-	jbd_debug(1, "Dropping transaction %d, all done\n", transaction->t_tid);
+	jbd2_debug(1, "Dropping transaction %d, all done\n", transaction->t_tid);
 }
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 2705850ca6460..e058ef1839377 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -419,7 +419,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 	/* Do we need to erase the effects of a prior jbd2_journal_flush? */
 	if (journal->j_flags & JBD2_FLUSHED) {
-		jbd_debug(3, "super block updated\n");
+		jbd2_debug(3, "super block updated\n");
 		mutex_lock_io(&journal->j_checkpoint_mutex);
 		/*
 		 * We hold j_checkpoint_mutex so tail cannot change under us.
@@ -433,7 +433,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 						REQ_SYNC);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	} else {
-		jbd_debug(3, "superblock not updated\n");
+		jbd2_debug(3, "superblock not updated\n");
 	}
 
 	J_ASSERT(journal->j_running_transaction != NULL);
@@ -465,7 +465,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	commit_transaction = journal->j_running_transaction;
 
 	trace_jbd2_start_commit(journal, commit_transaction);
-	jbd_debug(1, "JBD2: starting commit of transaction %d\n",
+	jbd2_debug(1, "JBD2: starting commit of transaction %d\n",
 			commit_transaction->t_tid);
 
 	write_lock(&journal->j_state_lock);
@@ -538,7 +538,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	__jbd2_journal_clean_checkpoint_list(journal, false);
 	spin_unlock(&journal->j_list_lock);
 
-	jbd_debug(3, "JBD2: commit phase 1\n");
+	jbd2_debug(3, "JBD2: commit phase 1\n");
 
 	/*
 	 * Clear revoked flag to reflect there is no revoked buffers
@@ -571,7 +571,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	wake_up_all(&journal->j_wait_transaction_locked);
 	write_unlock(&journal->j_state_lock);
 
-	jbd_debug(3, "JBD2: commit phase 2a\n");
+	jbd2_debug(3, "JBD2: commit phase 2a\n");
 
 	/*
 	 * Now start flushing things to disk, in the order they appear
@@ -584,7 +584,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	blk_start_plug(&plug);
 	jbd2_journal_write_revoke_records(commit_transaction, &log_bufs);
 
-	jbd_debug(3, "JBD2: commit phase 2b\n");
+	jbd2_debug(3, "JBD2: commit phase 2b\n");
 
 	/*
 	 * Way to go: we have now written out all of the data for a
@@ -640,7 +640,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		if (!descriptor) {
 			J_ASSERT (bufs == 0);
 
-			jbd_debug(4, "JBD2: get descriptor\n");
+			jbd2_debug(4, "JBD2: get descriptor\n");
 
 			descriptor = jbd2_journal_get_descriptor_buffer(
 							commit_transaction,
@@ -650,7 +650,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 				continue;
 			}
 
-			jbd_debug(4, "JBD2: got buffer %llu (%p)\n",
+			jbd2_debug(4, "JBD2: got buffer %llu (%p)\n",
 				(unsigned long long)descriptor->b_blocknr,
 				descriptor->b_data);
 			tagp = &descriptor->b_data[sizeof(journal_header_t)];
@@ -735,7 +735,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		    commit_transaction->t_buffers == NULL ||
 		    space_left < tag_bytes + 16 + csum_size) {
 
-			jbd_debug(4, "JBD2: Submit %d IOs\n", bufs);
+			jbd2_debug(4, "JBD2: Submit %d IOs\n", bufs);
 
 			/* Write an end-of-descriptor marker before
                            submitting the IOs.  "tag" still points to
@@ -837,7 +837,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	   so we incur less scheduling load.
 	*/
 
-	jbd_debug(3, "JBD2: commit phase 3\n");
+	jbd2_debug(3, "JBD2: commit phase 3\n");
 
 	while (!list_empty(&io_bufs)) {
 		struct buffer_head *bh = list_entry(io_bufs.prev,
@@ -880,7 +880,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 	J_ASSERT (commit_transaction->t_shadow_list == NULL);
 
-	jbd_debug(3, "JBD2: commit phase 4\n");
+	jbd2_debug(3, "JBD2: commit phase 4\n");
 
 	/* Here we wait for the revoke record and descriptor record buffers */
 	while (!list_empty(&log_bufs)) {
@@ -904,7 +904,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	if (err)
 		jbd2_journal_abort(journal, err);
 
-	jbd_debug(3, "JBD2: commit phase 5\n");
+	jbd2_debug(3, "JBD2: commit phase 5\n");
 	write_lock(&journal->j_state_lock);
 	J_ASSERT(commit_transaction->t_state == T_COMMIT_DFLUSH);
 	commit_transaction->t_state = T_COMMIT_JFLUSH;
@@ -943,7 +943,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
            transaction can be removed from any checkpoint list it was on
            before. */
 
-	jbd_debug(3, "JBD2: commit phase 6\n");
+	jbd2_debug(3, "JBD2: commit phase 6\n");
 
 	J_ASSERT(list_empty(&commit_transaction->t_inode_list));
 	J_ASSERT(commit_transaction->t_buffers == NULL);
@@ -1120,7 +1120,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 	/* Done with this transaction! */
 
-	jbd_debug(3, "JBD2: commit phase 7\n");
+	jbd2_debug(3, "JBD2: commit phase 7\n");
 
 	J_ASSERT(commit_transaction->t_state == T_COMMIT_JFLUSH);
 
@@ -1162,7 +1162,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		journal->j_fc_cleanup_callback(journal, 1, commit_transaction->t_tid);
 
 	trace_jbd2_end_commit(journal, commit_transaction);
-	jbd_debug(1, "JBD2: commit %d complete, head %d\n",
+	jbd2_debug(1, "JBD2: commit %d complete, head %d\n",
 		  journal->j_commit_sequence, journal->j_tail_sequence);
 
 	write_lock(&journal->j_state_lock);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 580d2fdfe21f5..11fbc9b6ec5cb 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -203,11 +203,11 @@ static int kjournald2(void *arg)
 	if (journal->j_flags & JBD2_UNMOUNT)
 		goto end_loop;
 
-	jbd_debug(1, "commit_sequence=%u, commit_request=%u\n",
+	jbd2_debug(1, "commit_sequence=%u, commit_request=%u\n",
 		journal->j_commit_sequence, journal->j_commit_request);
 
 	if (journal->j_commit_sequence != journal->j_commit_request) {
-		jbd_debug(1, "OK, requests differ\n");
+		jbd2_debug(1, "OK, requests differ\n");
 		write_unlock(&journal->j_state_lock);
 		del_timer_sync(&journal->j_commit_timer);
 		jbd2_journal_commit_transaction(journal);
@@ -222,7 +222,7 @@ static int kjournald2(void *arg)
 		 * good idea, because that depends on threads that may
 		 * be already stopped.
 		 */
-		jbd_debug(1, "Now suspending kjournald2\n");
+		jbd2_debug(1, "Now suspending kjournald2\n");
 		write_unlock(&journal->j_state_lock);
 		try_to_freeze();
 		write_lock(&journal->j_state_lock);
@@ -252,7 +252,7 @@ static int kjournald2(void *arg)
 		finish_wait(&journal->j_wait_commit, &wait);
 	}
 
-	jbd_debug(1, "kjournald2 wakes\n");
+	jbd2_debug(1, "kjournald2 wakes\n");
 
 	/*
 	 * Were we woken up by a commit wakeup event?
@@ -260,7 +260,7 @@ static int kjournald2(void *arg)
 	transaction = journal->j_running_transaction;
 	if (transaction && time_after_eq(jiffies, transaction->t_expires)) {
 		journal->j_commit_request = transaction->t_tid;
-		jbd_debug(1, "woke because of timeout\n");
+		jbd2_debug(1, "woke because of timeout\n");
 	}
 	goto loop;
 
@@ -268,7 +268,7 @@ static int kjournald2(void *arg)
 	del_timer_sync(&journal->j_commit_timer);
 	journal->j_task = NULL;
 	wake_up(&journal->j_wait_done_commit);
-	jbd_debug(1, "Journal thread exiting.\n");
+	jbd2_debug(1, "Journal thread exiting.\n");
 	write_unlock(&journal->j_state_lock);
 	return 0;
 }
@@ -500,7 +500,7 @@ int __jbd2_log_start_commit(journal_t *journal, tid_t target)
 		 */
 
 		journal->j_commit_request = target;
-		jbd_debug(1, "JBD2: requesting commit %u/%u\n",
+		jbd2_debug(1, "JBD2: requesting commit %u/%u\n",
 			  journal->j_commit_request,
 			  journal->j_commit_sequence);
 		journal->j_running_transaction->t_requested = jiffies;
@@ -705,7 +705,7 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
 	}
 #endif
 	while (tid_gt(tid, journal->j_commit_sequence)) {
-		jbd_debug(1, "JBD2: want %u, j_commit_sequence=%u\n",
+		jbd2_debug(1, "JBD2: want %u, j_commit_sequence=%u\n",
 				  tid, journal->j_commit_sequence);
 		read_unlock(&journal->j_state_lock);
 		wake_up(&journal->j_wait_commit);
@@ -1123,7 +1123,7 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block)
 		freed += journal->j_last - journal->j_first;
 
 	trace_jbd2_update_log_tail(journal, tid, block, freed);
-	jbd_debug(1,
+	jbd2_debug(1,
 		  "Cleaning journal tail from %u to %u (offset %lu), "
 		  "freeing %lu\n",
 		  journal->j_tail_sequence, tid, block, freed);
@@ -1498,7 +1498,7 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 		return NULL;
 	}
 
-	jbd_debug(1, "JBD2: inode %s/%ld, size %lld, bits %d, blksize %ld\n",
+	jbd2_debug(1, "JBD2: inode %s/%ld, size %lld, bits %d, blksize %ld\n",
 		  inode->i_sb->s_id, inode->i_ino, (long long) inode->i_size,
 		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
 
@@ -1577,7 +1577,7 @@ static int journal_reset(journal_t *journal)
 	 * attempting a write to a potential-readonly device.
 	 */
 	if (sb->s_start == 0) {
-		jbd_debug(1, "JBD2: Skipping superblock update on recovered sb "
+		jbd2_debug(1, "JBD2: Skipping superblock update on recovered sb "
 			"(start %ld, seq %u, errno %d)\n",
 			journal->j_tail, journal->j_tail_sequence,
 			journal->j_errno);
@@ -1680,7 +1680,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 	}
 
 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
-	jbd_debug(1, "JBD2: updating superblock (start %lu, seq %u)\n",
+	jbd2_debug(1, "JBD2: updating superblock (start %lu, seq %u)\n",
 		  tail_block, tail_tid);
 
 	lock_buffer(journal->j_sb_buffer);
@@ -1721,7 +1721,7 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 		return;
 	}
 
-	jbd_debug(1, "JBD2: Marking journal as empty (seq %u)\n",
+	jbd2_debug(1, "JBD2: Marking journal as empty (seq %u)\n",
 		  journal->j_tail_sequence);
 
 	sb->s_sequence = cpu_to_be32(journal->j_tail_sequence);
@@ -1867,7 +1867,7 @@ void jbd2_journal_update_sb_errno(journal_t *journal)
 	errcode = journal->j_errno;
 	if (errcode == -ESHUTDOWN)
 		errcode = 0;
-	jbd_debug(1, "JBD2: updating superblock error (errno %d)\n", errcode);
+	jbd2_debug(1, "JBD2: updating superblock error (errno %d)\n", errcode);
 	sb->s_errno    = cpu_to_be32(errcode);
 
 	jbd2_write_superblock(journal, REQ_SYNC | REQ_FUA);
@@ -2339,7 +2339,7 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
 	    compat & JBD2_FEATURE_COMPAT_CHECKSUM)
 		compat &= ~JBD2_FEATURE_COMPAT_CHECKSUM;
 
-	jbd_debug(1, "Setting new features 0x%lx/0x%lx/0x%lx\n",
+	jbd2_debug(1, "Setting new features 0x%lx/0x%lx/0x%lx\n",
 		  compat, ro, incompat);
 
 	sb = journal->j_superblock;
@@ -2408,7 +2408,7 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
 {
 	journal_superblock_t *sb;
 
-	jbd_debug(1, "Clear features 0x%lx/0x%lx/0x%lx\n",
+	jbd2_debug(1, "Clear features 0x%lx/0x%lx/0x%lx\n",
 		  compat, ro, incompat);
 
 	sb = journal->j_superblock;
@@ -2865,7 +2865,7 @@ static struct journal_head *journal_alloc_journal_head(void)
 #endif
 	ret = kmem_cache_zalloc(jbd2_journal_head_cache, GFP_NOFS);
 	if (!ret) {
-		jbd_debug(1, "out of memory for journal_head\n");
+		jbd2_debug(1, "out of memory for journal_head\n");
 		pr_notice_ratelimited("ENOMEM in %s, retrying.\n", __func__);
 		ret = kmem_cache_zalloc(jbd2_journal_head_cache,
 				GFP_NOFS | __GFP_NOFAIL);
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 3c5dd010e39d2..18f525f7f4063 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -245,11 +245,11 @@ static int fc_do_one_pass(journal_t *journal,
 		return 0;
 
 	while (next_fc_block <= journal->j_fc_last) {
-		jbd_debug(3, "Fast commit replay: next block %ld\n",
+		jbd2_debug(3, "Fast commit replay: next block %ld\n",
 			  next_fc_block);
 		err = jread(&bh, journal, next_fc_block);
 		if (err) {
-			jbd_debug(3, "Fast commit replay: read error\n");
+			jbd2_debug(3, "Fast commit replay: read error\n");
 			break;
 		}
 
@@ -264,7 +264,7 @@ static int fc_do_one_pass(journal_t *journal,
 	}
 
 	if (err)
-		jbd_debug(3, "Fast commit replay failed, err = %d\n", err);
+		jbd2_debug(3, "Fast commit replay failed, err = %d\n", err);
 
 	return err;
 }
@@ -298,7 +298,7 @@ int jbd2_journal_recover(journal_t *journal)
 	 */
 
 	if (!sb->s_start) {
-		jbd_debug(1, "No recovery required, last transaction %d\n",
+		jbd2_debug(1, "No recovery required, last transaction %d\n",
 			  be32_to_cpu(sb->s_sequence));
 		journal->j_transaction_sequence = be32_to_cpu(sb->s_sequence) + 1;
 		return 0;
@@ -310,10 +310,10 @@ int jbd2_journal_recover(journal_t *journal)
 	if (!err)
 		err = do_one_pass(journal, &info, PASS_REPLAY);
 
-	jbd_debug(1, "JBD2: recovery, exit status %d, "
+	jbd2_debug(1, "JBD2: recovery, exit status %d, "
 		  "recovered transactions %u to %u\n",
 		  err, info.start_transaction, info.end_transaction);
-	jbd_debug(1, "JBD2: Replayed %d and revoked %d/%d blocks\n",
+	jbd2_debug(1, "JBD2: Replayed %d and revoked %d/%d blocks\n",
 		  info.nr_replays, info.nr_revoke_hits, info.nr_revokes);
 
 	/* Restart the log at the next transaction ID, thus invalidating
@@ -363,7 +363,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 #ifdef CONFIG_JBD2_DEBUG
 		int dropped = info.end_transaction - 
 			be32_to_cpu(journal->j_superblock->s_sequence);
-		jbd_debug(1,
+		jbd2_debug(1,
 			  "JBD2: ignoring %d transaction%s from the journal.\n",
 			  dropped, (dropped == 1) ? "" : "s");
 #endif
@@ -485,7 +485,7 @@ static int do_one_pass(journal_t *journal,
 	if (pass == PASS_SCAN)
 		info->start_transaction = first_commit_ID;
 
-	jbd_debug(1, "Starting recovery pass %d\n", pass);
+	jbd2_debug(1, "Starting recovery pass %d\n", pass);
 
 	/*
 	 * Now we walk through the log, transaction by transaction,
@@ -511,7 +511,7 @@ static int do_one_pass(journal_t *journal,
 			if (tid_geq(next_commit_ID, info->end_transaction))
 				break;
 
-		jbd_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
+		jbd2_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
 			  next_commit_ID, next_log_block,
 			  jbd2_has_feature_fast_commit(journal) ?
 			  journal->j_fc_last : journal->j_last);
@@ -520,7 +520,7 @@ static int do_one_pass(journal_t *journal,
 		 * either the next descriptor block or the final commit
 		 * record. */
 
-		jbd_debug(3, "JBD2: checking block %ld\n", next_log_block);
+		jbd2_debug(3, "JBD2: checking block %ld\n", next_log_block);
 		err = jread(&bh, journal, next_log_block);
 		if (err)
 			goto failed;
@@ -543,7 +543,7 @@ static int do_one_pass(journal_t *journal,
 
 		blocktype = be32_to_cpu(tmp->h_blocktype);
 		sequence = be32_to_cpu(tmp->h_sequence);
-		jbd_debug(3, "Found magic %d, sequence %d\n",
+		jbd2_debug(3, "Found magic %d, sequence %d\n",
 			  blocktype, sequence);
 
 		if (sequence != next_commit_ID) {
@@ -576,7 +576,7 @@ static int do_one_pass(journal_t *journal,
 					goto failed;
 				}
 				need_check_commit_time = true;
-				jbd_debug(1,
+				jbd2_debug(1,
 					"invalid descriptor block found in %lu\n",
 					next_log_block);
 			}
@@ -759,7 +759,7 @@ static int do_one_pass(journal_t *journal,
 				 * It likely does not belong to same journal,
 				 * just end this recovery with success.
 				 */
-				jbd_debug(1, "JBD2: Invalid checksum ignored in transaction %u, likely stale data\n",
+				jbd2_debug(1, "JBD2: Invalid checksum ignored in transaction %u, likely stale data\n",
 					  next_commit_ID);
 				brelse(bh);
 				goto done;
@@ -827,7 +827,7 @@ static int do_one_pass(journal_t *journal,
 			if (pass == PASS_SCAN &&
 			    !jbd2_descriptor_block_csum_verify(journal,
 							       bh->b_data)) {
-				jbd_debug(1, "JBD2: invalid revoke block found in %lu\n",
+				jbd2_debug(1, "JBD2: invalid revoke block found in %lu\n",
 					  next_log_block);
 				need_check_commit_time = true;
 			}
@@ -846,7 +846,7 @@ static int do_one_pass(journal_t *journal,
 			continue;
 
 		default:
-			jbd_debug(3, "Unrecognised magic %d, end of scan.\n",
+			jbd2_debug(3, "Unrecognised magic %d, end of scan.\n",
 				  blocktype);
 			brelse(bh);
 			goto done;
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index fa608788b93d7..4556e46890244 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -398,7 +398,7 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 	}
 	handle->h_revoke_credits--;
 
-	jbd_debug(2, "insert revoke for block %llu, bh_in=%p\n",blocknr, bh_in);
+	jbd2_debug(2, "insert revoke for block %llu, bh_in=%p\n",blocknr, bh_in);
 	err = insert_revoke_hash(journal, blocknr,
 				handle->h_transaction->t_tid);
 	BUFFER_TRACE(bh_in, "exit");
@@ -428,7 +428,7 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 	int did_revoke = 0;	/* akpm: debug */
 	struct buffer_head *bh = jh2bh(jh);
 
-	jbd_debug(4, "journal_head %p, cancelling revoke\n", jh);
+	jbd2_debug(4, "journal_head %p, cancelling revoke\n", jh);
 
 	/* Is the existing Revoke bit valid?  If so, we trust it, and
 	 * only perform the full cancel if the revoke bit is set.  If
@@ -444,7 +444,7 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 	if (need_cancel) {
 		record = find_revoke_record(journal, bh->b_blocknr);
 		if (record) {
-			jbd_debug(4, "cancelled existing revoke on "
+			jbd2_debug(4, "cancelled existing revoke on "
 				  "blocknr %llu\n", (unsigned long long)bh->b_blocknr);
 			spin_lock(&journal->j_revoke_lock);
 			list_del(&record->hash);
@@ -560,7 +560,7 @@ void jbd2_journal_write_revoke_records(transaction_t *transaction,
 	}
 	if (descriptor)
 		flush_descriptor(journal, descriptor, offset);
-	jbd_debug(1, "Wrote %d revoke records\n", count);
+	jbd2_debug(1, "Wrote %d revoke records\n", count);
 }
 
 /*
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index b31145b2bb6bf..c2125203ef2d9 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -374,7 +374,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 			return -ENOMEM;
 	}
 
-	jbd_debug(3, "New handle %p going live.\n", handle);
+	jbd2_debug(3, "New handle %p going live.\n", handle);
 
 	/*
 	 * We need to hold j_state_lock until t_updates has been incremented,
@@ -454,7 +454,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	handle->h_start_jiffies = jiffies;
 	atomic_inc(&transaction->t_updates);
 	atomic_inc(&transaction->t_handle_count);
-	jbd_debug(4, "Handle %p given %d credits (total %d, free %lu)\n",
+	jbd2_debug(4, "Handle %p given %d credits (total %d, free %lu)\n",
 		  handle, blocks,
 		  atomic_read(&transaction->t_outstanding_credits),
 		  jbd2_log_space_left(journal));
@@ -675,7 +675,7 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 
 	/* Don't extend a locked-down transaction! */
 	if (transaction->t_state != T_RUNNING) {
-		jbd_debug(3, "denied handle %p %d blocks: "
+		jbd2_debug(3, "denied handle %p %d blocks: "
 			  "transaction not running\n", handle, nblocks);
 		goto error_out;
 	}
@@ -690,7 +690,7 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 				   &transaction->t_outstanding_credits);
 
 	if (wanted > journal->j_max_transaction_buffers) {
-		jbd_debug(3, "denied handle %p %d blocks: "
+		jbd2_debug(3, "denied handle %p %d blocks: "
 			  "transaction too large\n", handle, nblocks);
 		atomic_sub(nblocks, &transaction->t_outstanding_credits);
 		goto error_out;
@@ -708,7 +708,7 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 	handle->h_revoke_credits_requested += revoke_records;
 	result = 0;
 
-	jbd_debug(3, "extended handle %p by %d\n", handle, nblocks);
+	jbd2_debug(3, "extended handle %p by %d\n", handle, nblocks);
 error_out:
 	read_unlock(&journal->j_state_lock);
 	return result;
@@ -796,7 +796,7 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, int revoke_records,
 	 * First unlink the handle from its current transaction, and start the
 	 * commit on that.
 	 */
-	jbd_debug(2, "restarting handle %p\n", handle);
+	jbd2_debug(2, "restarting handle %p\n", handle);
 	stop_this_handle(handle);
 	handle->h_transaction = NULL;
 
@@ -980,7 +980,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 
 	journal = transaction->t_journal;
 
-	jbd_debug(5, "journal_head %p, force_copy %d\n", jh, force_copy);
+	jbd2_debug(5, "journal_head %p, force_copy %d\n", jh, force_copy);
 
 	JBUFFER_TRACE(jh, "entry");
 repeat:
@@ -1280,7 +1280,7 @@ int jbd2_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
 	struct journal_head *jh = jbd2_journal_add_journal_head(bh);
 	int err;
 
-	jbd_debug(5, "journal_head %p\n", jh);
+	jbd2_debug(5, "journal_head %p\n", jh);
 	err = -EROFS;
 	if (is_handle_aborted(handle))
 		goto out;
@@ -1503,7 +1503,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	 * of the running transaction.
 	 */
 	jh = bh2jh(bh);
-	jbd_debug(5, "journal_head %p\n", jh);
+	jbd2_debug(5, "journal_head %p\n", jh);
 	JBUFFER_TRACE(jh, "entry");
 
 	/*
@@ -1836,7 +1836,7 @@ int jbd2_journal_stop(handle_t *handle)
 	pid_t pid;
 
 	if (--handle->h_ref > 0) {
-		jbd_debug(4, "h_ref %d -> %d\n", handle->h_ref + 1,
+		jbd2_debug(4, "h_ref %d -> %d\n", handle->h_ref + 1,
 						 handle->h_ref);
 		if (is_handle_aborted(handle))
 			return -EIO;
@@ -1856,7 +1856,7 @@ int jbd2_journal_stop(handle_t *handle)
 	if (is_handle_aborted(handle))
 		err = -EIO;
 
-	jbd_debug(4, "Handle %p going down\n", handle);
+	jbd2_debug(4, "Handle %p going down\n", handle);
 	trace_jbd2_handle_stats(journal->j_fs_dev->bd_dev,
 				tid, handle->h_type, handle->h_line_no,
 				jiffies - handle->h_start_jiffies,
@@ -1934,7 +1934,7 @@ int jbd2_journal_stop(handle_t *handle)
 		 * completes the commit thread, it just doesn't write
 		 * anything to disk. */
 
-		jbd_debug(2, "transaction too old, requesting commit for "
+		jbd2_debug(2, "transaction too old, requesting commit for "
 					"handle %p\n", handle);
 		/* This is non-blocking */
 		jbd2_log_start_commit(journal, tid);
@@ -2678,7 +2678,7 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
 		return -EROFS;
 	journal = transaction->t_journal;
 
-	jbd_debug(4, "Adding inode %lu, tid:%d\n", jinode->i_vfs_inode->i_ino,
+	jbd2_debug(4, "Adding inode %lu, tid:%d\n", jinode->i_vfs_inode->i_ino,
 			transaction->t_tid);
 
 	spin_lock(&journal->j_list_lock);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index f29fda630b2de..d19f527ade3bb 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -58,10 +58,10 @@ extern ushort jbd2_journal_enable_debug;
 void __jbd2_debug(int level, const char *file, const char *func,
 		  unsigned int line, const char *fmt, ...);
 
-#define jbd_debug(n, fmt, a...) \
+#define jbd2_debug(n, fmt, a...) \
 	__jbd2_debug((n), __FILE__, __func__, __LINE__, (fmt), ##a)
 #else
-#define jbd_debug(n, fmt, a...)  no_printk(fmt, ##a)
+#define jbd2_debug(n, fmt, a...)  no_printk(fmt, ##a)
 #endif
 
 extern void *jbd2_alloc(size_t size, gfp_t flags);
-- 
2.40.1



