Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8023D761251
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjGYLBO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjGYLA6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:00:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F9944B2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:58:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72EF361648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817E6C433C8;
        Tue, 25 Jul 2023 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282692;
        bh=XVFKjGUw27pqHaTGOxos+pOAVpK/ZolEXYxWbWIuVbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3FRidTQ719hd+0+m8f0lbaqfeaTBVdtgi3tBq05ZQLBIERgE5txI00nSfSipWphe
         jjgloCH/dr/oV9k/lzLh9FxFMpXEtbfS17DC33Emr8ssIKe/LuQGDvkCvpUwZGhEx1
         c7irtXAhE+q4YAFmydJ+mCnF0wzsTWPag/ki9bb4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Kara <jack@suse.cz>,
        Zhang Yi <yi.zhang@huawei.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.4 219/227] jbd2: recheck chechpointing non-dirty buffer
Date:   Tue, 25 Jul 2023 12:46:26 +0200
Message-ID: <20230725104523.781296882@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Zhang Yi <yi.zhang@huawei.com>

commit c2d6fd9d6f35079f1669f0100f05b46708c74b7f upstream.

There is a long-standing metadata corruption issue that happens from
time to time, but it's very difficult to reproduce and analyse, benefit
from the JBD2_CYCLE_RECORD option, we found out that the problem is the
checkpointing process miss to write out some buffers which are raced by
another do_get_write_access(). Looks below for detail.

jbd2_log_do_checkpoint() //transaction X
 //buffer A is dirty and not belones to any transaction
 __buffer_relink_io() //move it to the IO list
 __flush_batch()
  write_dirty_buffer()
                             do_get_write_access()
                             clear_buffer_dirty
                             __jbd2_journal_file_buffer()
                             //add buffer A to a new transaction Y
   lock_buffer(bh)
   //doesn't write out
 __jbd2_journal_remove_checkpoint()
 //finish checkpoint except buffer A
 //filesystem corrupt if the new transaction Y isn't fully write out.

Due to the t_checkpoint_list walking loop in jbd2_log_do_checkpoint()
have already handles waiting for buffers under IO and re-added new
transaction to complete commit, and it also removing cleaned buffers,
this makes sure the list will eventually get empty. So it's fine to
leave buffers on the t_checkpoint_list while flushing out and completely
stop using the t_checkpoint_io_list.

Cc: stable@vger.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230606135928.434610-2-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jbd2/checkpoint.c |  102 ++++++++++++++-------------------------------------
 1 file changed, 29 insertions(+), 73 deletions(-)

--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -58,28 +58,6 @@ static inline void __buffer_unlink(struc
 }
 
 /*
- * Move a buffer from the checkpoint list to the checkpoint io list
- *
- * Called with j_list_lock held
- */
-static inline void __buffer_relink_io(struct journal_head *jh)
-{
-	transaction_t *transaction = jh->b_cp_transaction;
-
-	__buffer_unlink_first(jh);
-
-	if (!transaction->t_checkpoint_io_list) {
-		jh->b_cpnext = jh->b_cpprev = jh;
-	} else {
-		jh->b_cpnext = transaction->t_checkpoint_io_list;
-		jh->b_cpprev = transaction->t_checkpoint_io_list->b_cpprev;
-		jh->b_cpprev->b_cpnext = jh;
-		jh->b_cpnext->b_cpprev = jh;
-	}
-	transaction->t_checkpoint_io_list = jh;
-}
-
-/*
  * Check a checkpoint buffer could be release or not.
  *
  * Requires j_list_lock
@@ -183,6 +161,7 @@ __flush_batch(journal_t *journal, int *b
 		struct buffer_head *bh = journal->j_chkpt_bhs[i];
 		BUFFER_TRACE(bh, "brelse");
 		__brelse(bh);
+		journal->j_chkpt_bhs[i] = NULL;
 	}
 	*batch_count = 0;
 }
@@ -242,6 +221,11 @@ restart:
 		jh = transaction->t_checkpoint_list;
 		bh = jh2bh(jh);
 
+		/*
+		 * The buffer may be writing back, or flushing out in the
+		 * last couple of cycles, or re-adding into a new transaction,
+		 * need to check it again until it's unlocked.
+		 */
 		if (buffer_locked(bh)) {
 			get_bh(bh);
 			spin_unlock(&journal->j_list_lock);
@@ -287,28 +271,32 @@ restart:
 		}
 		if (!buffer_dirty(bh)) {
 			BUFFER_TRACE(bh, "remove from checkpoint");
-			if (__jbd2_journal_remove_checkpoint(jh))
-				/* The transaction was released; we're done */
+			/*
+			 * If the transaction was released or the checkpoint
+			 * list was empty, we're done.
+			 */
+			if (__jbd2_journal_remove_checkpoint(jh) ||
+			    !transaction->t_checkpoint_list)
 				goto out;
-			continue;
+		} else {
+			/*
+			 * We are about to write the buffer, it could be
+			 * raced by some other transaction shrink or buffer
+			 * re-log logic once we release the j_list_lock,
+			 * leave it on the checkpoint list and check status
+			 * again to make sure it's clean.
+			 */
+			BUFFER_TRACE(bh, "queue");
+			get_bh(bh);
+			J_ASSERT_BH(bh, !buffer_jwrite(bh));
+			journal->j_chkpt_bhs[batch_count++] = bh;
+			transaction->t_chp_stats.cs_written++;
+			transaction->t_checkpoint_list = jh->b_cpnext;
 		}
-		/*
-		 * Important: we are about to write the buffer, and
-		 * possibly block, while still holding the journal
-		 * lock.  We cannot afford to let the transaction
-		 * logic start messing around with this buffer before
-		 * we write it to disk, as that would break
-		 * recoverability.
-		 */
-		BUFFER_TRACE(bh, "queue");
-		get_bh(bh);
-		J_ASSERT_BH(bh, !buffer_jwrite(bh));
-		journal->j_chkpt_bhs[batch_count++] = bh;
-		__buffer_relink_io(jh);
-		transaction->t_chp_stats.cs_written++;
+
 		if ((batch_count == JBD2_NR_BATCH) ||
-		    need_resched() ||
-		    spin_needbreak(&journal->j_list_lock))
+		    need_resched() || spin_needbreak(&journal->j_list_lock) ||
+		    jh2bh(transaction->t_checkpoint_list) == journal->j_chkpt_bhs[0])
 			goto unlock_and_flush;
 	}
 
@@ -322,38 +310,6 @@ restart:
 			goto restart;
 	}
 
-	/*
-	 * Now we issued all of the transaction's buffers, let's deal
-	 * with the buffers that are out for I/O.
-	 */
-restart2:
-	/* Did somebody clean up the transaction in the meanwhile? */
-	if (journal->j_checkpoint_transactions != transaction ||
-	    transaction->t_tid != this_tid)
-		goto out;
-
-	while (transaction->t_checkpoint_io_list) {
-		jh = transaction->t_checkpoint_io_list;
-		bh = jh2bh(jh);
-		if (buffer_locked(bh)) {
-			get_bh(bh);
-			spin_unlock(&journal->j_list_lock);
-			wait_on_buffer(bh);
-			/* the journal_head may have gone by now */
-			BUFFER_TRACE(bh, "brelse");
-			__brelse(bh);
-			spin_lock(&journal->j_list_lock);
-			goto restart2;
-		}
-
-		/*
-		 * Now in whatever state the buffer currently is, we
-		 * know that it has been written out and so we can
-		 * drop it from the list
-		 */
-		if (__jbd2_journal_remove_checkpoint(jh))
-			break;
-	}
 out:
 	spin_unlock(&journal->j_list_lock);
 	result = jbd2_cleanup_journal_tail(journal);


