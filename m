Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12477A2FE5
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbjIPMOo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbjIPMOi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:14:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E181BCEB
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:14:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AC6C433C8;
        Sat, 16 Sep 2023 12:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694866472;
        bh=ecAkuMzdj3HgQHXnv8A28vZcJht9TUA/HIZkJB4DFdQ=;
        h=Subject:To:Cc:From:Date:From;
        b=TX82SnZSFfN5mz6ePOxC7FK3xEvTsvE/+MFodwenWtjQbJ+8y4VWUwGqlAXoDCDeu
         CdxcsXAJr3iyJFn4Fgobu+Ki4URAuFBbMDT7yU0tZPV/aL7jKGVEasJU5KQ3WiwGy8
         nttmz293gMxia+rzl6RhRedC9ZF6JGD+0p6yzSXA=
Subject: FAILED: patch "[PATCH] jbd2: correct the end of the journal recovery scan range" failed to apply to 5.10-stable tree
To:     yi.zhang@huawei.com, jack@suse.cz, tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:14:21 +0200
Message-ID: <2023091621-unviable-character-f8d2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2dfba3bb40ad8536b9fa802364f2d40da31aa88e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091621-unviable-character-f8d2@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

2dfba3bb40ad ("jbd2: correct the end of the journal recovery scan range")
cb3b3bf22cf3 ("jbd2: rename jbd_debug() to jbd2_debug()")
f7f497cb7024 ("jbd2: kill t_handle_lock transaction spinlock")
cc16eecae687 ("jbd2: fix use-after-free of transaction_t race")
4f9818684870 ("jbd2: refactor wait logic for transaction updates into a common function")
fcdf3c34b7ab ("ext4: fix debug format string warning")
d556435156b7 ("jbd2: avoid -Wempty-body warnings")
3042b1b45c41 ("Updated locking documentation for transaction_t")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2dfba3bb40ad8536b9fa802364f2d40da31aa88e Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Mon, 26 Jun 2023 15:33:22 +0800
Subject: [PATCH] jbd2: correct the end of the journal recovery scan range

We got a filesystem inconsistency issue below while running generic/475
I/O failure pressure test with fast_commit feature enabled.

 Symlink /p3/d3/d1c/d6c/dd6/dce/l101 (inode #132605) is invalid.

If fast_commit feature is enabled, a special fast_commit journal area is
appended to the end of the normal journal area. The journal->j_last
point to the first unused block behind the normal journal area instead
of the whole log area, and the journal->j_fc_last point to the first
unused block behind the fast_commit journal area. While doing journal
recovery, do_one_pass(PASS_SCAN) should first scan the normal journal
area and turn around to the first block once it meet journal->j_last,
but the wrap() macro misuse the journal->j_fc_last, so the recovering
could not read the next magic block (commit block perhaps) and would end
early mistakenly and missing tN and every transaction after it in the
following example. Finally, it could lead to filesystem inconsistency.

 | normal journal area                             | fast commit area |
 +-------------------------------------------------+------------------+
 | tN(rere) | tN+1 |~| tN-x |...| tN-1 | tN(front) |       ....       |
 +-------------------------------------------------+------------------+
                     /                             /                  /
                start               journal->j_last journal->j_fc_last

This patch fix it by use the correct ending journal->j_last.

Fixes: 5b849b5f96b4 ("jbd2: fast commit recovery path")
Cc: stable@kernel.org
Reported-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/linux-ext4/20230613043120.GB1584772@mit.edu/
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230626073322.3956567-1-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 0184931d47f7..c269a7d29a46 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -230,12 +230,8 @@ static int count_tags(journal_t *journal, struct buffer_head *bh)
 /* Make sure we wrap around the log correctly! */
 #define wrap(journal, var)						\
 do {									\
-	unsigned long _wrap_last =					\
-		jbd2_has_feature_fast_commit(journal) ?			\
-			(journal)->j_fc_last : (journal)->j_last;	\
-									\
-	if (var >= _wrap_last)						\
-		var -= (_wrap_last - (journal)->j_first);		\
+	if (var >= (journal)->j_last)					\
+		var -= ((journal)->j_last - (journal)->j_first);	\
 } while (0)
 
 static int fc_do_one_pass(journal_t *journal,
@@ -524,9 +520,7 @@ static int do_one_pass(journal_t *journal,
 				break;
 
 		jbd2_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
-			  next_commit_ID, next_log_block,
-			  jbd2_has_feature_fast_commit(journal) ?
-			  journal->j_fc_last : journal->j_last);
+			  next_commit_ID, next_log_block, journal->j_last);
 
 		/* Skip over each chunk of the transaction looking
 		 * either the next descriptor block or the final commit

