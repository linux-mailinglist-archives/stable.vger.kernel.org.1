Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE77A81AA
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbjITMr3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjITMr0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:47:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBE792
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:47:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5829EC433C7;
        Wed, 20 Sep 2023 12:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695214039;
        bh=UXXHrAaKBhfW+5FD3GOd7c8tesDc+Pzrl8F+g7xn1vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kf2brRpQ4PBtyDdEjOGQYzyBZvRnYe0wYV8wq4XRd+qLGIHeg+qV7vc5v9HFz7VIx
         Rm5Hwpf7QPD/Wa1O50y5GheYWT4rrMpeQz1flLWJrnfdeyhiNWm4oPECkM3hu7qIu3
         usaD6jGd9SMuHATDe+wdbZKq+CWQ+79v6ElArixY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 063/110] jbd2: kill t_handle_lock transaction spinlock
Date:   Wed, 20 Sep 2023 13:32:01 +0200
Message-ID: <20230920112832.774274238@linuxfoundation.org>
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

[ Upstream commit f7f497cb702462e8505ff3d8d4e7722ad95626a1 ]

This patch kills t_handle_lock transaction spinlock completely from
jbd2.

To explain the reasoning, currently there were three sites at which
this spinlock was used.

1. jbd2_journal_wait_updates()
   a. Based on careful code review it can be seen that, we don't need this
      lock here. This is since we wait for any currently ongoing updates
      based on a atomic variable t_updates. And we anyway don't take any
      t_handle_lock while in stop_this_handle().
      i.e.

	write_lock(&journal->j_state_lock()
	jbd2_journal_wait_updates() 			stop_this_handle()
		while (atomic_read(txn->t_updates) { 		|
		DEFINE_WAIT(wait); 				|
		prepare_to_wait(); 				|
		if (atomic_read(txn->t_updates) 		if (atomic_dec_and_test(txn->t_updates))
			write_unlock(&journal->j_state_lock);
			schedule();					wake_up()
			write_lock(&journal->j_state_lock);
		finish_wait();
	   }
	txn->t_state = T_COMMIT
	write_unlock(&journal->j_state_lock);

   b.  Also note that between atomic_inc(&txn->t_updates) in
       start_this_handle() and jbd2_journal_wait_updates(), the
       synchronization happens via read_lock(journal->j_state_lock) in
       start_this_handle();

2. jbd2_journal_extend()
   a. jbd2_journal_extend() is called with the handle of each process from
      task_struct. So no lock required in updating member fields of handle_t

   b. For member fields of h_transaction, all updates happens only via
      atomic APIs (which is also within read_lock()).
      So, no need of this transaction spinlock.

3. update_t_max_wait()
   Based on Jan suggestion, this can be carefully removed using atomic
   cmpxchg API.
   Note that there can be several processes which are waiting for a new
   transaction to be allocated and started. For doing this only one
   process will succeed in taking write_lock() and allocating a new txn.
   After that all of the process will be updating the t_max_wait (max
   transaction wait time). This can be done via below method w/o taking
   any locks using atomic cmpxchg.
   For more details refer [1]

	   new = get_new_val();
	   old = READ_ONCE(ptr->max_val);
	   while (old < new)
		old = cmpxchg(&ptr->max_val, old, new);

[1]: https://lwn.net/Articles/849237/

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/d89e599658b4a1f3893a48c6feded200073037fc.1644992076.git.riteshh@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 2dfba3bb40ad ("jbd2: correct the end of the journal recovery scan range")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/transaction.c | 28 +++++++++-------------------
 include/linux/jbd2.h  |  3 ---
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 59292b82d4424..b31145b2bb6bf 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -107,7 +107,6 @@ static void jbd2_get_transaction(journal_t *journal,
 	transaction->t_start_time = ktime_get();
 	transaction->t_tid = journal->j_transaction_sequence++;
 	transaction->t_expires = jiffies + journal->j_commit_interval;
-	spin_lock_init(&transaction->t_handle_lock);
 	atomic_set(&transaction->t_updates, 0);
 	atomic_set(&transaction->t_outstanding_credits,
 		   jbd2_descriptor_blocks_per_trans(journal) +
@@ -139,24 +138,21 @@ static void jbd2_get_transaction(journal_t *journal,
 /*
  * Update transaction's maximum wait time, if debugging is enabled.
  *
- * In order for t_max_wait to be reliable, it must be protected by a
- * lock.  But doing so will mean that start_this_handle() can not be
- * run in parallel on SMP systems, which limits our scalability.  So
- * unless debugging is enabled, we no longer update t_max_wait, which
- * means that maximum wait time reported by the jbd2_run_stats
- * tracepoint will always be zero.
+ * t_max_wait is carefully updated here with use of atomic compare exchange.
+ * Note that there could be multiplre threads trying to do this simultaneously
+ * hence using cmpxchg to avoid any use of locks in this case.
  */
 static inline void update_t_max_wait(transaction_t *transaction,
 				     unsigned long ts)
 {
 #ifdef CONFIG_JBD2_DEBUG
+	unsigned long oldts, newts;
 	if (jbd2_journal_enable_debug &&
 	    time_after(transaction->t_start, ts)) {
-		ts = jbd2_time_diff(ts, transaction->t_start);
-		spin_lock(&transaction->t_handle_lock);
-		if (ts > transaction->t_max_wait)
-			transaction->t_max_wait = ts;
-		spin_unlock(&transaction->t_handle_lock);
+		newts = jbd2_time_diff(ts, transaction->t_start);
+		oldts = READ_ONCE(transaction->t_max_wait);
+		while (oldts < newts)
+			oldts = cmpxchg(&transaction->t_max_wait, oldts, newts);
 	}
 #endif
 }
@@ -690,7 +686,6 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 		DIV_ROUND_UP(
 			handle->h_revoke_credits_requested,
 			journal->j_revoke_records_per_block);
-	spin_lock(&transaction->t_handle_lock);
 	wanted = atomic_add_return(nblocks,
 				   &transaction->t_outstanding_credits);
 
@@ -698,7 +693,7 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 		jbd_debug(3, "denied handle %p %d blocks: "
 			  "transaction too large\n", handle, nblocks);
 		atomic_sub(nblocks, &transaction->t_outstanding_credits);
-		goto unlock;
+		goto error_out;
 	}
 
 	trace_jbd2_handle_extend(journal->j_fs_dev->bd_dev,
@@ -714,8 +709,6 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 	result = 0;
 
 	jbd_debug(3, "extended handle %p by %d\n", handle, nblocks);
-unlock:
-	spin_unlock(&transaction->t_handle_lock);
 error_out:
 	read_unlock(&journal->j_state_lock);
 	return result;
@@ -860,15 +853,12 @@ void jbd2_journal_wait_updates(journal_t *journal)
 		if (!transaction)
 			break;
 
-		spin_lock(&transaction->t_handle_lock);
 		prepare_to_wait(&journal->j_wait_updates, &wait,
 				TASK_UNINTERRUPTIBLE);
 		if (!atomic_read(&transaction->t_updates)) {
-			spin_unlock(&transaction->t_handle_lock);
 			finish_wait(&journal->j_wait_updates, &wait);
 			break;
 		}
-		spin_unlock(&transaction->t_handle_lock);
 		write_unlock(&journal->j_state_lock);
 		schedule();
 		finish_wait(&journal->j_wait_updates, &wait);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 03d8ba98cbeb7..f29fda630b2de 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -554,9 +554,6 @@ struct transaction_chp_stats_s {
  *    ->j_list_lock
  *
  *    j_state_lock
- *    ->t_handle_lock
- *
- *    j_state_lock
  *    ->j_list_lock			(journal_unmap_buffer)
  *
  */
-- 
2.40.1



