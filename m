Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2B27A81A5
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjITMrT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjITMrS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:47:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE51992
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:47:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B405C433C9;
        Wed, 20 Sep 2023 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695214032;
        bh=DpKevSgEgR3fwceAgNsem892I3K/M0OL3aZ9IoEyvPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgZ8he5Zwx4ggyjGueXPX/CBa6FcUsc2K6nbbLB9GRI3Mq5+FktxTpR5T/5MQArni
         oL6jnlkHZicvv14ioX4tKDFK1+HQR9zJlm0BauXQbVvZOhbxlEh5EOYe6TjtLMGLls
         Z6hBS1LEa7hHmxfdYdElgfji+BxZu1rgUXNjz2Hc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ritesh Harjani <riteshh@linux.ibm.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 061/110] jbd2: refactor wait logic for transaction updates into a common function
Date:   Wed, 20 Sep 2023 13:31:59 +0200
Message-ID: <20230920112832.695623202@linuxfoundation.org>
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

From: Ritesh Harjani <riteshh@linux.ibm.com>

[ Upstream commit 4f98186848707f530669238d90e0562d92a78aab ]

No functionality change as such in this patch. This only refactors the
common piece of code which waits for t_updates to finish into a common
function named as jbd2_journal_wait_updates(journal_t *)

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/8c564f70f4b2591171677a2a74fccb22a7b6c3a4.1642416995.git.riteshh@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 2dfba3bb40ad ("jbd2: correct the end of the journal recovery scan range")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/commit.c      | 19 +++-------------
 fs/jbd2/transaction.c | 53 ++++++++++++++++++++++++++-----------------
 include/linux/jbd2.h  |  4 +++-
 3 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 20294c1bbeab7..2705850ca6460 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -484,22 +484,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	stats.run.rs_running = jbd2_time_diff(commit_transaction->t_start,
 					      stats.run.rs_locked);
 
-	spin_lock(&commit_transaction->t_handle_lock);
-	while (atomic_read(&commit_transaction->t_updates)) {
-		DEFINE_WAIT(wait);
+	// waits for any t_updates to finish
+	jbd2_journal_wait_updates(journal);
 
-		prepare_to_wait(&journal->j_wait_updates, &wait,
-					TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&commit_transaction->t_updates)) {
-			spin_unlock(&commit_transaction->t_handle_lock);
-			write_unlock(&journal->j_state_lock);
-			schedule();
-			write_lock(&journal->j_state_lock);
-			spin_lock(&commit_transaction->t_handle_lock);
-		}
-		finish_wait(&journal->j_wait_updates, &wait);
-	}
-	spin_unlock(&commit_transaction->t_handle_lock);
 	commit_transaction->t_state = T_SWITCH;
 
 	J_ASSERT (atomic_read(&commit_transaction->t_outstanding_credits) <=
@@ -819,7 +806,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	commit_transaction->t_state = T_COMMIT_DFLUSH;
 	write_unlock(&journal->j_state_lock);
 
-	/* 
+	/*
 	 * If the journal is not located on the file system device,
 	 * then we must flush the file system device before we issue
 	 * the commit record
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 62e68c5b8ec3d..69aed72c8206d 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -449,7 +449,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	}
 
 	/* OK, account for the buffers that this operation expects to
-	 * use and add the handle to the running transaction. 
+	 * use and add the handle to the running transaction.
 	 */
 	update_t_max_wait(transaction, ts);
 	handle->h_transaction = transaction;
@@ -836,6 +836,35 @@ int jbd2_journal_restart(handle_t *handle, int nblocks)
 }
 EXPORT_SYMBOL(jbd2_journal_restart);
 
+/*
+ * Waits for any outstanding t_updates to finish.
+ * This is called with write j_state_lock held.
+ */
+void jbd2_journal_wait_updates(journal_t *journal)
+{
+	transaction_t *commit_transaction = journal->j_running_transaction;
+
+	if (!commit_transaction)
+		return;
+
+	spin_lock(&commit_transaction->t_handle_lock);
+	while (atomic_read(&commit_transaction->t_updates)) {
+		DEFINE_WAIT(wait);
+
+		prepare_to_wait(&journal->j_wait_updates, &wait,
+					TASK_UNINTERRUPTIBLE);
+		if (atomic_read(&commit_transaction->t_updates)) {
+			spin_unlock(&commit_transaction->t_handle_lock);
+			write_unlock(&journal->j_state_lock);
+			schedule();
+			write_lock(&journal->j_state_lock);
+			spin_lock(&commit_transaction->t_handle_lock);
+		}
+		finish_wait(&journal->j_wait_updates, &wait);
+	}
+	spin_unlock(&commit_transaction->t_handle_lock);
+}
+
 /**
  * jbd2_journal_lock_updates () - establish a transaction barrier.
  * @journal:  Journal to establish a barrier on.
@@ -863,27 +892,9 @@ void jbd2_journal_lock_updates(journal_t *journal)
 		write_lock(&journal->j_state_lock);
 	}
 
-	/* Wait until there are no running updates */
-	while (1) {
-		transaction_t *transaction = journal->j_running_transaction;
-
-		if (!transaction)
-			break;
+	/* Wait until there are no running t_updates */
+	jbd2_journal_wait_updates(journal);
 
-		spin_lock(&transaction->t_handle_lock);
-		prepare_to_wait(&journal->j_wait_updates, &wait,
-				TASK_UNINTERRUPTIBLE);
-		if (!atomic_read(&transaction->t_updates)) {
-			spin_unlock(&transaction->t_handle_lock);
-			finish_wait(&journal->j_wait_updates, &wait);
-			break;
-		}
-		spin_unlock(&transaction->t_handle_lock);
-		write_unlock(&journal->j_state_lock);
-		schedule();
-		finish_wait(&journal->j_wait_updates, &wait);
-		write_lock(&journal->j_state_lock);
-	}
 	write_unlock(&journal->j_state_lock);
 
 	/*
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index ade8a6d7acff9..03d8ba98cbeb7 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -594,7 +594,7 @@ struct transaction_s
 	 */
 	unsigned long		t_log_start;
 
-	/* 
+	/*
 	 * Number of buffers on the t_buffers list [j_list_lock, no locks
 	 * needed for jbd2 thread]
 	 */
@@ -1538,6 +1538,8 @@ extern int	 jbd2_journal_flush(journal_t *journal, unsigned int flags);
 extern void	 jbd2_journal_lock_updates (journal_t *);
 extern void	 jbd2_journal_unlock_updates (journal_t *);
 
+void jbd2_journal_wait_updates(journal_t *);
+
 extern journal_t * jbd2_journal_init_dev(struct block_device *bdev,
 				struct block_device *fs_dev,
 				unsigned long long start, int len, int bsize);
-- 
2.40.1



