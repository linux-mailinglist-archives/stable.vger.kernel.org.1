Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF63D7A39C4
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbjIQTyI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240148AbjIQTxl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:53:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878469F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:53:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E231C433CA;
        Sun, 17 Sep 2023 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980416;
        bh=8iEAd/V1lZ+jR4ER1aNolpBBT1QuaTi6V+94sXYJ3lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KxtHQ2VhHdD5xZGpGjviMCWw4mlLG4mm2pLJyXSBX9Rnuy5LaGgsbNMKGAhumdgCV
         0n6q1lWTkS/Z0i9tkO8yJdcf6tTXwxxAAeifkEESOjAv/Jbu1k9BqMIpa4NbN6jkVH
         1MLMP1b6YXd8FwihCKoHvvRMGXcPIu+vzBac0t3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.5 185/285] jbd2: check jh->b_transaction before removing it from checkpoint
Date:   Sun, 17 Sep 2023 21:13:05 +0200
Message-ID: <20230917191058.017005856@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhihao Cheng <chengzhihao1@huawei.com>

commit 590a809ff743e7bd890ba5fb36bc38e20a36de53 upstream.

Following process will corrupt ext4 image:
Step 1:
jbd2_journal_commit_transaction
 __jbd2_journal_insert_checkpoint(jh, commit_transaction)
 // Put jh into trans1->t_checkpoint_list
 journal->j_checkpoint_transactions = commit_transaction
 // Put trans1 into journal->j_checkpoint_transactions

Step 2:
do_get_write_access
 test_clear_buffer_dirty(bh) // clear buffer dirty，set jbd dirty
 __jbd2_journal_file_buffer(jh, transaction) // jh belongs to trans2

Step 3:
drop_cache
 journal_shrink_one_cp_list
  jbd2_journal_try_remove_checkpoint
   if (!trylock_buffer(bh))  // lock bh, true
   if (buffer_dirty(bh))     // buffer is not dirty
   __jbd2_journal_remove_checkpoint(jh)
   // remove jh from trans1->t_checkpoint_list

Step 4:
jbd2_log_do_checkpoint
 trans1 = journal->j_checkpoint_transactions
 // jh is not in trans1->t_checkpoint_list
 jbd2_cleanup_journal_tail(journal)  // trans1 is done

Step 5: Power cut, trans2 is not committed, jh is lost in next mounting.

Fix it by checking 'jh->b_transaction' before remove it from checkpoint.

Cc: stable@kernel.org
Fixes: 46f881b5b175 ("jbd2: fix a race when checking checkpoint buffer busy")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230714025528.564988-3-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jbd2/checkpoint.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -639,6 +639,8 @@ int jbd2_journal_try_remove_checkpoint(s
 {
 	struct buffer_head *bh = jh2bh(jh);
 
+	if (jh->b_transaction)
+		return -EBUSY;
 	if (!trylock_buffer(bh))
 		return -EBUSY;
 	if (buffer_dirty(bh)) {


