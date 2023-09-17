Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA7E7A3B1F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbjIQUNz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240628AbjIQUN2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:13:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC687CC9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:12:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE688C43391;
        Sun, 17 Sep 2023 20:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981568;
        bh=7Fle1oQoPk1vKpVCsXj5+JQXaLi6cQ0RBghpAKCdjgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWl9koxJjthfYluDiD8+P53y7Bsk6fvpYs+TT5AvS0Guuv3Bki+lCP+EcgnWjnm/v
         AGsAhwQCtI3XjHp9dlnp1e/39unIKcj8nzs7rwAzLgAHu2Xkzbtc4gZnypF9IhSXbL
         +SUQKGo4plehe3NE+UF1w2od+z8PRuAwJdyKnJQA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.1 141/219] jbd2: fix checkpoint cleanup performance regression
Date:   Sun, 17 Sep 2023 21:14:28 +0200
Message-ID: <20230917191046.099480823@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

commit 373ac521799d9e97061515aca6ec6621789036bb upstream.

journal_clean_one_cp_list() has been merged into
journal_shrink_one_cp_list(), but do chekpoint buffer cleanup from the
committing process is just a best effort, it should stop scan once it
meet a busy buffer, or else it will cause a lot of invalid buffer scan
and checks. We catch a performance regression when doing fs_mark tests
below.

Test cmd:
 ./fs_mark  -d  scratch  -s  1024  -n  10000  -t  1  -D  100  -N  100

Before merging checkpoint buffer cleanup:
 FSUse%        Count         Size    Files/sec     App Overhead
     95        10000         1024       8304.9            49033

After merging checkpoint buffer cleanup:
 FSUse%        Count         Size    Files/sec     App Overhead
     95        10000         1024       7649.0            50012
 FSUse%        Count         Size    Files/sec     App Overhead
     95        10000         1024       2107.1            50871

After merging checkpoint buffer cleanup, the total loop count in
journal_shrink_one_cp_list() could be up to 6,261,600+ (50,000+ ~
100,000+ in general), most of them are invalid. This patch fix it
through passing 'shrink_type' into journal_shrink_one_cp_list() and add
a new 'SHRINK_BUSY_STOP' to indicate it should stop once meet a busy
buffer. After fix, the loop count descending back to 10,000+.

After this fix:
 FSUse%        Count         Size    Files/sec     App Overhead
     95        10000         1024       8558.4            49109

Cc: stable@kernel.org
Fixes: b98dba273a0e ("jbd2: remove journal_clean_one_cp_list()")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230714025528.564988-2-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jbd2/checkpoint.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -349,6 +349,8 @@ int jbd2_cleanup_journal_tail(journal_t
 
 /* Checkpoint list management */
 
+enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
+
 /*
  * journal_shrink_one_cp_list
  *
@@ -360,7 +362,8 @@ int jbd2_cleanup_journal_tail(journal_t
  * Called with j_list_lock held.
  */
 static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
-						bool destroy, bool *released)
+						enum shrink_type type,
+						bool *released)
 {
 	struct journal_head *last_jh;
 	struct journal_head *next_jh = jh;
@@ -376,12 +379,15 @@ static unsigned long journal_shrink_one_
 		jh = next_jh;
 		next_jh = jh->b_cpnext;
 
-		if (destroy) {
+		if (type == SHRINK_DESTROY) {
 			ret = __jbd2_journal_remove_checkpoint(jh);
 		} else {
 			ret = jbd2_journal_try_remove_checkpoint(jh);
-			if (ret < 0)
-				continue;
+			if (ret < 0) {
+				if (type == SHRINK_BUSY_SKIP)
+					continue;
+				break;
+			}
 		}
 
 		nr_freed++;
@@ -445,7 +451,7 @@ again:
 		tid = transaction->t_tid;
 
 		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-						   false, &released);
+						   SHRINK_BUSY_SKIP, &released);
 		nr_freed += freed;
 		(*nr_to_scan) -= min(*nr_to_scan, freed);
 		if (*nr_to_scan == 0)
@@ -485,19 +491,21 @@ out:
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
+	enum shrink_type type;
 	bool released;
 
 	transaction = journal->j_checkpoint_transactions;
 	if (!transaction)
 		return;
 
+	type = destroy ? SHRINK_DESTROY : SHRINK_BUSY_STOP;
 	last_transaction = transaction->t_cpprev;
 	next_transaction = transaction;
 	do {
 		transaction = next_transaction;
 		next_transaction = transaction->t_cpnext;
 		journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-					   destroy, &released);
+					   type, &released);
 		/*
 		 * This function only frees up some memory if possible so we
 		 * dont have an obligation to finish processing. Bail out if


