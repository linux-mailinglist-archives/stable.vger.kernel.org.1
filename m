Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5571B78AA39
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjH1KUM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjH1KTv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:19:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B46CDB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:19:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FDB16382C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A266CC433C9;
        Mon, 28 Aug 2023 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217961;
        bh=dRWtVHROzteuaiGl8yaL4AdJMMUGnx5twGuQsIuPxBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TbGGJ/fj5h76YrCytocJza2ZU4/Eb9BmzTDeLjBuxiWwQGVJFdkxK9NyjH05ympmM
         LsJHW4eLlCB6sF9bKX0cjibeux2oheu81OekmZh61eE25ZPtPiSNd0Yg/AqnwlUoLB
         0QyFSMUQmuraCKKecpLIkhUo6F1fXpn8mgE9ek+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 006/129] jbd2: remove journal_clean_one_cp_list()
Date:   Mon, 28 Aug 2023 12:11:25 +0200
Message-ID: <20230828101157.600162985@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit b98dba273a0e47dbfade89c9af73c5b012a4eabb ]

journal_clean_one_cp_list() and journal_shrink_one_cp_list() are almost
the same, so merge them into journal_shrink_one_cp_list(), remove the
nr_to_scan parameter, always scan and try to free the whole checkpoint
list.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230606135928.434610-4-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 46f881b5b175 ("jbd2: fix a race when checking checkpoint buffer busy")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/checkpoint.c        | 75 +++++++++----------------------------
 include/trace/events/jbd2.h | 12 ++----
 2 files changed, 21 insertions(+), 66 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 723b4eb112828..42b34cab64fbd 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -349,50 +349,10 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
 
 /* Checkpoint list management */
 
-/*
- * journal_clean_one_cp_list
- *
- * Find all the written-back checkpoint buffers in the given list and
- * release them. If 'destroy' is set, clean all buffers unconditionally.
- *
- * Called with j_list_lock held.
- * Returns 1 if we freed the transaction, 0 otherwise.
- */
-static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
-{
-	struct journal_head *last_jh;
-	struct journal_head *next_jh = jh;
-
-	if (!jh)
-		return 0;
-
-	last_jh = jh->b_cpprev;
-	do {
-		jh = next_jh;
-		next_jh = jh->b_cpnext;
-
-		if (!destroy && __cp_buffer_busy(jh))
-			return 0;
-
-		if (__jbd2_journal_remove_checkpoint(jh))
-			return 1;
-		/*
-		 * This function only frees up some memory
-		 * if possible so we dont have an obligation
-		 * to finish processing. Bail out if preemption
-		 * requested:
-		 */
-		if (need_resched())
-			return 0;
-	} while (jh != last_jh);
-
-	return 0;
-}
-
 /*
  * journal_shrink_one_cp_list
  *
- * Find 'nr_to_scan' written-back checkpoint buffers in the given list
+ * Find all the written-back checkpoint buffers in the given list
  * and try to release them. If the whole transaction is released, set
  * the 'released' parameter. Return the number of released checkpointed
  * buffers.
@@ -400,15 +360,15 @@ static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
  * Called with j_list_lock held.
  */
 static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
-						unsigned long *nr_to_scan,
-						bool *released)
+						bool destroy, bool *released)
 {
 	struct journal_head *last_jh;
 	struct journal_head *next_jh = jh;
 	unsigned long nr_freed = 0;
 	int ret;
 
-	if (!jh || *nr_to_scan == 0)
+	*released = false;
+	if (!jh)
 		return 0;
 
 	last_jh = jh->b_cpprev;
@@ -416,8 +376,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 		jh = next_jh;
 		next_jh = jh->b_cpnext;
 
-		(*nr_to_scan)--;
-		if (__cp_buffer_busy(jh))
+		if (!destroy && __cp_buffer_busy(jh))
 			continue;
 
 		nr_freed++;
@@ -429,7 +388,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 
 		if (need_resched())
 			break;
-	} while (jh != last_jh && *nr_to_scan);
+	} while (jh != last_jh);
 
 	return nr_freed;
 }
@@ -447,11 +406,11 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 						  unsigned long *nr_to_scan)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
-	bool released;
+	bool __maybe_unused released;
 	tid_t first_tid = 0, last_tid = 0, next_tid = 0;
 	tid_t tid = 0;
 	unsigned long nr_freed = 0;
-	unsigned long nr_scanned = *nr_to_scan;
+	unsigned long freed;
 
 again:
 	spin_lock(&journal->j_list_lock);
@@ -480,10 +439,11 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 		transaction = next_transaction;
 		next_transaction = transaction->t_cpnext;
 		tid = transaction->t_tid;
-		released = false;
 
-		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-						       nr_to_scan, &released);
+		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
+						   false, &released);
+		nr_freed += freed;
+		(*nr_to_scan) -= min(*nr_to_scan, freed);
 		if (*nr_to_scan == 0)
 			break;
 		if (need_resched() || spin_needbreak(&journal->j_list_lock))
@@ -504,9 +464,8 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	if (*nr_to_scan && next_tid)
 		goto again;
 out:
-	nr_scanned -= *nr_to_scan;
 	trace_jbd2_shrink_checkpoint_list(journal, first_tid, tid, last_tid,
-					  nr_freed, nr_scanned, next_tid);
+					  nr_freed, next_tid);
 
 	return nr_freed;
 }
@@ -522,7 +481,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
-	int ret;
+	bool released;
 
 	transaction = journal->j_checkpoint_transactions;
 	if (!transaction)
@@ -533,8 +492,8 @@ void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
 	do {
 		transaction = next_transaction;
 		next_transaction = transaction->t_cpnext;
-		ret = journal_clean_one_cp_list(transaction->t_checkpoint_list,
-						destroy);
+		journal_shrink_one_cp_list(transaction->t_checkpoint_list,
+					   destroy, &released);
 		/*
 		 * This function only frees up some memory if possible so we
 		 * dont have an obligation to finish processing. Bail out if
@@ -547,7 +506,7 @@ void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
 		 * avoids pointless scanning of transactions which still
 		 * weren't checkpointed.
 		 */
-		if (!ret)
+		if (!released)
 			return;
 	} while (transaction != last_transaction);
 }
diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
index 8f5ee380d3093..5646ae15a957a 100644
--- a/include/trace/events/jbd2.h
+++ b/include/trace/events/jbd2.h
@@ -462,11 +462,9 @@ TRACE_EVENT(jbd2_shrink_scan_exit,
 TRACE_EVENT(jbd2_shrink_checkpoint_list,
 
 	TP_PROTO(journal_t *journal, tid_t first_tid, tid_t tid, tid_t last_tid,
-		 unsigned long nr_freed, unsigned long nr_scanned,
-		 tid_t next_tid),
+		 unsigned long nr_freed, tid_t next_tid),
 
-	TP_ARGS(journal, first_tid, tid, last_tid, nr_freed,
-		nr_scanned, next_tid),
+	TP_ARGS(journal, first_tid, tid, last_tid, nr_freed, next_tid),
 
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
@@ -474,7 +472,6 @@ TRACE_EVENT(jbd2_shrink_checkpoint_list,
 		__field(tid_t, tid)
 		__field(tid_t, last_tid)
 		__field(unsigned long, nr_freed)
-		__field(unsigned long, nr_scanned)
 		__field(tid_t, next_tid)
 	),
 
@@ -484,15 +481,14 @@ TRACE_EVENT(jbd2_shrink_checkpoint_list,
 		__entry->tid		= tid;
 		__entry->last_tid	= last_tid;
 		__entry->nr_freed	= nr_freed;
-		__entry->nr_scanned	= nr_scanned;
 		__entry->next_tid	= next_tid;
 	),
 
 	TP_printk("dev %d,%d shrink transaction %u-%u(%u) freed %lu "
-		  "scanned %lu next transaction %u",
+		  "next transaction %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->first_tid, __entry->tid, __entry->last_tid,
-		  __entry->nr_freed, __entry->nr_scanned, __entry->next_tid)
+		  __entry->nr_freed, __entry->next_tid)
 );
 
 #endif /* _TRACE_JBD2_H */
-- 
2.40.1



