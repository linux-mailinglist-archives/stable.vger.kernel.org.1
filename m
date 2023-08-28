Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738BA78AA0E
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjH1KSc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjH1KSH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:18:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CDB19B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66D826375B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B622C433CB;
        Mon, 28 Aug 2023 10:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217877;
        bh=p3qNK9aoILUufrrO2T6oW+4Ynzbt25aAjv4pOk5yZNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oz/EkyK8un6rT3/p4Bg3yCPKPtCzE5StttlY6wUOATJxjuexEOmXam9XiC0paZskD
         CrVuyDlTT9zg2xtpUAWmyrydmr1bUOB3IcsoGmoPIpt6KhJiBBr8NH7bslqGXjZM+B
         fokUpOxDEqTSQ45cTRDpy+nNxJhjwd6fFgOgCzI8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Kara <jack@suse.cz>,
        Zhang Yi <yi.zhang@huawei.com>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 007/129] jbd2: fix a race when checking checkpoint buffer busy
Date:   Mon, 28 Aug 2023 12:11:26 +0200
Message-ID: <20230828101157.630238664@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 46f881b5b1758dc4a35fba4a643c10717d0cf427 ]

Before removing checkpoint buffer from the t_checkpoint_list, we have to
check both BH_Dirty and BH_Lock bits together to distinguish buffers
have not been or were being written back. But __cp_buffer_busy() checks
them separately, it first check lock state and then check dirty, the
window between these two checks could be raced by writing back
procedure, which locks buffer and clears buffer dirty before I/O
completes. So it cannot guarantee checkpointing buffers been written
back to disk if some error happens later. Finally, it may clean
checkpoint transactions and lead to inconsistent filesystem.

jbd2_journal_forget() and __journal_try_to_free_buffer() also have the
same problem (journal_unmap_buffer() escape from this issue since it's
running under the buffer lock), so fix them through introducing a new
helper to try holding the buffer lock and remove really clean buffer.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217490
Cc: stable@vger.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230606135928.434610-6-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/checkpoint.c  | 38 +++++++++++++++++++++++++++++++++++---
 fs/jbd2/transaction.c | 17 +++++------------
 include/linux/jbd2.h  |  1 +
 3 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 42b34cab64fbd..9ec91017a7f3c 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -376,11 +376,15 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 		jh = next_jh;
 		next_jh = jh->b_cpnext;
 
-		if (!destroy && __cp_buffer_busy(jh))
-			continue;
+		if (destroy) {
+			ret = __jbd2_journal_remove_checkpoint(jh);
+		} else {
+			ret = jbd2_journal_try_remove_checkpoint(jh);
+			if (ret < 0)
+				continue;
+		}
 
 		nr_freed++;
-		ret = __jbd2_journal_remove_checkpoint(jh);
 		if (ret) {
 			*released = true;
 			break;
@@ -616,6 +620,34 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 	return 1;
 }
 
+/*
+ * Check the checkpoint buffer and try to remove it from the checkpoint
+ * list if it's clean. Returns -EBUSY if it is not clean, returns 1 if
+ * it frees the transaction, 0 otherwise.
+ *
+ * This function is called with j_list_lock held.
+ */
+int jbd2_journal_try_remove_checkpoint(struct journal_head *jh)
+{
+	struct buffer_head *bh = jh2bh(jh);
+
+	if (!trylock_buffer(bh))
+		return -EBUSY;
+	if (buffer_dirty(bh)) {
+		unlock_buffer(bh);
+		return -EBUSY;
+	}
+	unlock_buffer(bh);
+
+	/*
+	 * Buffer is clean and the IO has finished (we held the buffer
+	 * lock) so the checkpoint is done. We can safely remove the
+	 * buffer from this transaction.
+	 */
+	JBUFFER_TRACE(jh, "remove from checkpoint list");
+	return __jbd2_journal_remove_checkpoint(jh);
+}
+
 /*
  * journal_insert_checkpoint: put a committed buffer onto a checkpoint
  * list so that we know when it is safe to clean the transaction out of
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 18611241f4513..6ef5022949c46 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1784,8 +1784,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 		 * Otherwise, if the buffer has been written to disk,
 		 * it is safe to remove the checkpoint and drop it.
 		 */
-		if (!buffer_dirty(bh)) {
-			__jbd2_journal_remove_checkpoint(jh);
+		if (jbd2_journal_try_remove_checkpoint(jh) >= 0) {
 			spin_unlock(&journal->j_list_lock);
 			goto drop;
 		}
@@ -2112,20 +2111,14 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
 
 	jh = bh2jh(bh);
 
-	if (buffer_locked(bh) || buffer_dirty(bh))
-		goto out;
-
 	if (jh->b_next_transaction != NULL || jh->b_transaction != NULL)
-		goto out;
+		return;
 
 	spin_lock(&journal->j_list_lock);
-	if (jh->b_cp_transaction != NULL) {
-		/* written-back checkpointed metadata buffer */
-		JBUFFER_TRACE(jh, "remove from checkpoint list");
-		__jbd2_journal_remove_checkpoint(jh);
-	}
+	/* Remove written-back checkpointed metadata buffer */
+	if (jh->b_cp_transaction != NULL)
+		jbd2_journal_try_remove_checkpoint(jh);
 	spin_unlock(&journal->j_list_lock);
-out:
 	return;
 }
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 91a2cf4bc5756..c212da35a052c 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1443,6 +1443,7 @@ extern void jbd2_journal_commit_transaction(journal_t *);
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy);
 unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal, unsigned long *nr_to_scan);
 int __jbd2_journal_remove_checkpoint(struct journal_head *);
+int jbd2_journal_try_remove_checkpoint(struct journal_head *jh);
 void jbd2_journal_destroy_checkpoint(journal_t *journal);
 void __jbd2_journal_insert_checkpoint(struct journal_head *, transaction_t *);
 
-- 
2.40.1



