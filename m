Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84BD7A81A6
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjITMrV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjITMrV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:47:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B52793
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:47:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8E6C433C9;
        Wed, 20 Sep 2023 12:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695214035;
        bh=SSylqBAPI1r81Ii9DYjk9g0tyG0FQIOIme71Y7QZ4M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WO4fnY4lc/SOCscIvpYMqgo8FT+R8lj1j/ha1VSOSQDx7XHsMp1IoWt4wAr1nF9Yd
         Bt/eTRw6RfL1YviOxFxpV7QvCO9pdFeeI75SMrNZjmRlXIOjcKQ6lzGUSKlpG74k6v
         E8H1QfAlQs2bzurBAsPY5Ll84EZ65NRzGT/3/NYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com
Subject: [PATCH 5.15 062/110] jbd2: fix use-after-free of transaction_t race
Date:   Wed, 20 Sep 2023 13:32:00 +0200
Message-ID: <20230920112832.735395670@linuxfoundation.org>
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

[ Upstream commit cc16eecae687912238ee6efbff71ad31e2bc414e ]

jbd2_journal_wait_updates() is called with j_state_lock held. But if
there is a commit in progress, then this transaction might get committed
and freed via jbd2_journal_commit_transaction() ->
jbd2_journal_free_transaction(), when we release j_state_lock.
So check for journal->j_running_transaction everytime we release and
acquire j_state_lock to avoid use-after-free issue.

Link: https://lore.kernel.org/r/948c2fed518ae739db6a8f7f83f1d58b504f87d0.1644497105.git.ritesh.list@gmail.com
Fixes: 4f98186848707f53 ("jbd2: refactor wait logic for transaction updates into a common function")
Cc: stable@kernel.org
Reported-and-tested-by: syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 2dfba3bb40ad ("jbd2: correct the end of the journal recovery scan range")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/transaction.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 69aed72c8206d..59292b82d4424 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -842,27 +842,38 @@ EXPORT_SYMBOL(jbd2_journal_restart);
  */
 void jbd2_journal_wait_updates(journal_t *journal)
 {
-	transaction_t *commit_transaction = journal->j_running_transaction;
+	DEFINE_WAIT(wait);
 
-	if (!commit_transaction)
-		return;
+	while (1) {
+		/*
+		 * Note that the running transaction can get freed under us if
+		 * this transaction is getting committed in
+		 * jbd2_journal_commit_transaction() ->
+		 * jbd2_journal_free_transaction(). This can only happen when we
+		 * release j_state_lock -> schedule() -> acquire j_state_lock.
+		 * Hence we should everytime retrieve new j_running_transaction
+		 * value (after j_state_lock release acquire cycle), else it may
+		 * lead to use-after-free of old freed transaction.
+		 */
+		transaction_t *transaction = journal->j_running_transaction;
 
-	spin_lock(&commit_transaction->t_handle_lock);
-	while (atomic_read(&commit_transaction->t_updates)) {
-		DEFINE_WAIT(wait);
+		if (!transaction)
+			break;
 
+		spin_lock(&transaction->t_handle_lock);
 		prepare_to_wait(&journal->j_wait_updates, &wait,
-					TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&commit_transaction->t_updates)) {
-			spin_unlock(&commit_transaction->t_handle_lock);
-			write_unlock(&journal->j_state_lock);
-			schedule();
-			write_lock(&journal->j_state_lock);
-			spin_lock(&commit_transaction->t_handle_lock);
+				TASK_UNINTERRUPTIBLE);
+		if (!atomic_read(&transaction->t_updates)) {
+			spin_unlock(&transaction->t_handle_lock);
+			finish_wait(&journal->j_wait_updates, &wait);
+			break;
 		}
+		spin_unlock(&transaction->t_handle_lock);
+		write_unlock(&journal->j_state_lock);
+		schedule();
 		finish_wait(&journal->j_wait_updates, &wait);
+		write_lock(&journal->j_state_lock);
 	}
-	spin_unlock(&commit_transaction->t_handle_lock);
 }
 
 /**
@@ -877,8 +888,6 @@ void jbd2_journal_wait_updates(journal_t *journal)
  */
 void jbd2_journal_lock_updates(journal_t *journal)
 {
-	DEFINE_WAIT(wait);
-
 	jbd2_might_wait_for_commit(journal);
 
 	write_lock(&journal->j_state_lock);
-- 
2.40.1



