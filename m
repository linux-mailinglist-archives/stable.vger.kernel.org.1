Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F475EB60
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 08:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGXGSr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 02:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjGXGSr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 02:18:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664CCE52
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 23:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1B2260E9C
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 06:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC62C433C8;
        Mon, 24 Jul 2023 06:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690179523;
        bh=Ec1XQeJKbKI7BP7l7/PcSEk6VAiuzOE5MLelqaHXs2Q=;
        h=Subject:To:Cc:From:Date:From;
        b=JTJuLiFhHSJJldV6vxgR1HPwGEjiELXN2apQ7aq9DK7Ffp0FrsFhYGqYQbYZywGek
         9QXEOvSoFNZ1/KMjhJKxxpGW/EOhPlUWUREIJNaE4teN1LdOYTZM7EgF9cRBSHPnEQ
         r9gD6IXA26cdpxWVNwJ+ENlygth9fP3Z+FV4NwjA=
Subject: FAILED: patch "[PATCH] jbd2: fix a race when checking checkpoint buffer busy" failed to apply to 5.15-stable tree
To:     yi.zhang@huawei.com, jack@suse.cz, tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 24 Jul 2023 08:18:34 +0200
Message-ID: <2023072433-obsessed-limeade-e4b9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
git cherry-pick -x 46f881b5b1758dc4a35fba4a643c10717d0cf427
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072433-obsessed-limeade-e4b9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

46f881b5b175 ("jbd2: fix a race when checking checkpoint buffer busy")
b98dba273a0e ("jbd2: remove journal_clean_one_cp_list()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 46f881b5b1758dc4a35fba4a643c10717d0cf427 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Tue, 6 Jun 2023 21:59:27 +0800
Subject: [PATCH] jbd2: fix a race when checking checkpoint buffer busy

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

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 42b34cab64fb..9ec91017a7f3 100644
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
index 18611241f451..6ef5022949c4 100644
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
index bd660aac8e07..44c298aa58d4 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1443,6 +1443,7 @@ extern void jbd2_journal_commit_transaction(journal_t *);
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy);
 unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal, unsigned long *nr_to_scan);
 int __jbd2_journal_remove_checkpoint(struct journal_head *);
+int jbd2_journal_try_remove_checkpoint(struct journal_head *jh);
 void jbd2_journal_destroy_checkpoint(journal_t *journal);
 void __jbd2_journal_insert_checkpoint(struct journal_head *, transaction_t *);
 

