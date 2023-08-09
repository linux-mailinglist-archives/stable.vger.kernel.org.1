Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D354A775C64
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjHIL0z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjHIL0y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:26:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18646FA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:26:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8BD663210
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AC6C433C7;
        Wed,  9 Aug 2023 11:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580413;
        bh=UFz5Mza013pJESPhVYR1HRHfw90tCssGdw1v5/v+nUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QFtr+j6c5fuvP7SIR8xXWvh63M5TYof6tga769Ao4b304Mc/RrLRxdukqbWzJbl4u
         4Sr2RmBQlSt4gLG9K1UAu/KBGVH8YYS58FaAfxaLPvl+GNmNFYpyN+Hsq3IAe/wM00
         nfzz89kgHCpwDEu3JMxHkTfQJ5t8b0n4lHftx0Oo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 003/154] jbd2: remove redundant buffer io error checks
Date:   Wed,  9 Aug 2023 12:40:34 +0200
Message-ID: <20230809103637.024533147@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 214eb5a4d8a2032fb9f0711d1b202eb88ee02920 ]

Now that __jbd2_journal_remove_checkpoint() can detect buffer io error
and mark journal checkpoint error, then we abort the journal later
before updating log tail to ensure the filesystem works consistently.
So we could remove other redundant buffer io error checkes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20210610112440.3438139-5-yi.zhang@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: e34c8dd238d0 ("jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/checkpoint.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 5ef99b9ec8be7..c5f7b7a455fa4 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -91,8 +91,7 @@ static int __try_to_free_cp_buf(struct journal_head *jh)
 	int ret = 0;
 	struct buffer_head *bh = jh2bh(jh);
 
-	if (jh->b_transaction == NULL && !buffer_locked(bh) &&
-	    !buffer_dirty(bh) && !buffer_write_io_error(bh)) {
+	if (!jh->b_transaction && !buffer_locked(bh) && !buffer_dirty(bh)) {
 		JBUFFER_TRACE(jh, "remove from checkpoint list");
 		ret = __jbd2_journal_remove_checkpoint(jh) + 1;
 	}
@@ -228,7 +227,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 	 * OK, we need to start writing disk blocks.  Take one transaction
 	 * and write it.
 	 */
-	result = 0;
 	spin_lock(&journal->j_list_lock);
 	if (!journal->j_checkpoint_transactions)
 		goto out;
@@ -295,8 +293,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			goto restart;
 		}
 		if (!buffer_dirty(bh)) {
-			if (unlikely(buffer_write_io_error(bh)) && !result)
-				result = -EIO;
 			BUFFER_TRACE(bh, "remove from checkpoint");
 			if (__jbd2_journal_remove_checkpoint(jh))
 				/* The transaction was released; we're done */
@@ -356,8 +352,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			spin_lock(&journal->j_list_lock);
 			goto restart2;
 		}
-		if (unlikely(buffer_write_io_error(bh)) && !result)
-			result = -EIO;
 
 		/*
 		 * Now in whatever state the buffer currently is, we
@@ -369,10 +363,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 	}
 out:
 	spin_unlock(&journal->j_list_lock);
-	if (result < 0)
-		jbd2_journal_abort(journal, result);
-	else
-		result = jbd2_cleanup_journal_tail(journal);
+	result = jbd2_cleanup_journal_tail(journal);
 
 	return (result < 0) ? result : 0;
 }
-- 
2.39.2



