Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF6E78AD13
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjH1Kpt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjH1KpS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24D919A
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:44:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FE3164156
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A7FC433C7;
        Mon, 28 Aug 2023 10:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219437;
        bh=sRbX9tJNisFPERxiGrvPDi1oL259TkZSYOOAGLbU3+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPwLWLfk5UCMXP2ZA23L7e2Xsai+THMTRLwkIrB0m4IEyfzA81wZpZ1Tg2bQJxY4V
         ld20j2AfVr6dy1XTMaYj0ln1oGYHa1vSLCs28W2vfH1KwemC4Irh2z5FQABBpHcuH5
         Zu9O0zSZUvYNQkLO3kKTBWLJJue+rfFiRkke4nUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 18/89] jbd2: remove t_checkpoint_io_list
Date:   Mon, 28 Aug 2023 12:13:19 +0200
Message-ID: <20230828101150.782849020@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit be22255360f80d3af789daad00025171a65424a5 ]

Since t_checkpoint_io_list was stop using in jbd2_log_do_checkpoint()
now, it's time to remove the whole t_checkpoint_io_list logic.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230606135928.434610-3-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 46f881b5b175 ("jbd2: fix a race when checking checkpoint buffer busy")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/checkpoint.c | 42 ++----------------------------------------
 fs/jbd2/commit.c     |  3 +--
 include/linux/jbd2.h |  6 ------
 3 files changed, 3 insertions(+), 48 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index d2aba55833f92..c1f543e86170a 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -27,7 +27,7 @@
  *
  * Called with j_list_lock held.
  */
-static inline void __buffer_unlink_first(struct journal_head *jh)
+static inline void __buffer_unlink(struct journal_head *jh)
 {
 	transaction_t *transaction = jh->b_cp_transaction;
 
@@ -40,23 +40,6 @@ static inline void __buffer_unlink_first(struct journal_head *jh)
 	}
 }
 
-/*
- * Unlink a buffer from a transaction checkpoint(io) list.
- *
- * Called with j_list_lock held.
- */
-static inline void __buffer_unlink(struct journal_head *jh)
-{
-	transaction_t *transaction = jh->b_cp_transaction;
-
-	__buffer_unlink_first(jh);
-	if (transaction->t_checkpoint_io_list == jh) {
-		transaction->t_checkpoint_io_list = jh->b_cpnext;
-		if (transaction->t_checkpoint_io_list == jh)
-			transaction->t_checkpoint_io_list = NULL;
-	}
-}
-
 /*
  * Check a checkpoint buffer could be release or not.
  *
@@ -505,15 +488,6 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 			break;
 		if (need_resched() || spin_needbreak(&journal->j_list_lock))
 			break;
-		if (released)
-			continue;
-
-		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_io_list,
-						       nr_to_scan, &released);
-		if (*nr_to_scan == 0)
-			break;
-		if (need_resched() || spin_needbreak(&journal->j_list_lock))
-			break;
 	} while (transaction != last_transaction);
 
 	if (transaction != last_transaction) {
@@ -568,17 +542,6 @@ void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
 		 */
 		if (need_resched())
 			return;
-		if (ret)
-			continue;
-		/*
-		 * It is essential that we are as careful as in the case of
-		 * t_checkpoint_list with removing the buffer from the list as
-		 * we can possibly see not yet submitted buffers on io_list
-		 */
-		ret = journal_clean_one_cp_list(transaction->
-				t_checkpoint_io_list, destroy);
-		if (need_resched())
-			return;
 		/*
 		 * Stop scanning if we couldn't free the transaction. This
 		 * avoids pointless scanning of transactions which still
@@ -663,7 +626,7 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 	jbd2_journal_put_journal_head(jh);
 
 	/* Is this transaction empty? */
-	if (transaction->t_checkpoint_list || transaction->t_checkpoint_io_list)
+	if (transaction->t_checkpoint_list)
 		return 0;
 
 	/*
@@ -755,7 +718,6 @@ void __jbd2_journal_drop_transaction(journal_t *journal, transaction_t *transact
 	J_ASSERT(transaction->t_forget == NULL);
 	J_ASSERT(transaction->t_shadow_list == NULL);
 	J_ASSERT(transaction->t_checkpoint_list == NULL);
-	J_ASSERT(transaction->t_checkpoint_io_list == NULL);
 	J_ASSERT(atomic_read(&transaction->t_updates) == 0);
 	J_ASSERT(journal->j_committing_transaction != transaction);
 	J_ASSERT(journal->j_running_transaction != transaction);
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index ac328e3321242..20294c1bbeab7 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -1184,8 +1184,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	spin_lock(&journal->j_list_lock);
 	commit_transaction->t_state = T_FINISHED;
 	/* Check if the transaction can be dropped now that we are finished */
-	if (commit_transaction->t_checkpoint_list == NULL &&
-	    commit_transaction->t_checkpoint_io_list == NULL) {
+	if (commit_transaction->t_checkpoint_list == NULL) {
 		__jbd2_journal_drop_transaction(journal, commit_transaction);
 		jbd2_journal_free_transaction(commit_transaction);
 	}
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index d63b8106796e2..e6cfbcde96f29 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -626,12 +626,6 @@ struct transaction_s
 	 */
 	struct journal_head	*t_checkpoint_list;
 
-	/*
-	 * Doubly-linked circular list of all buffers submitted for IO while
-	 * checkpointing. [j_list_lock]
-	 */
-	struct journal_head	*t_checkpoint_io_list;
-
 	/*
 	 * Doubly-linked circular list of metadata buffers being
 	 * shadowed by log IO.  The IO buffers on the iobuf list and
-- 
2.40.1



