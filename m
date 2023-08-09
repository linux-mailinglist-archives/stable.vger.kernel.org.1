Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1395F775C5D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjHIL0h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjHIL0g (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:26:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533C82103
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1D6263283
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F126AC433C8;
        Wed,  9 Aug 2023 11:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580393;
        bh=Kf1jDU1ZbKvV3M/IZU8xHkuinQORvUBH4+dgXzbBN/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoVIH5/61jO79V5U5Uodqa95s+TyfiwyRM9cup6b1He3ZiWY9aDlR0x90j7hx0dD4
         q5lMRBALYyZqOoxXwPmx0oaewse6lLRyMry+ltvss8vGYlXa7rQWsalQp+Lbh7oU0P
         vjfr9yo02LCLRdRi5pxBguMWN25L+qGH06MufogM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xianting Tian <xianting_tian@126.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 001/154] jbd2: fix incorrect code style
Date:   Wed,  9 Aug 2023 12:40:32 +0200
Message-ID: <20230809103636.944963015@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

From: Xianting Tian <xianting_tian@126.com>

[ Upstream commit 60ed633f51d0c675150a117d96a45e78c3613f91 ]

Remove unnecessary blank.

Signed-off-by: Xianting Tian <xianting_tian@126.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/1595077057-8048-1-git-send-email-xianting_tian@126.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: e34c8dd238d0 ("jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/journal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b7c5819bfc411..1fa88b5bb1cb0 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1266,7 +1266,7 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
  * superblock as being NULL to prevent the journal destroy from writing
  * back a bogus superblock.
  */
-static void journal_fail_superblock (journal_t *journal)
+static void journal_fail_superblock(journal_t *journal)
 {
 	struct buffer_head *bh = journal->j_sb_buffer;
 	brelse(bh);
@@ -1780,7 +1780,7 @@ int jbd2_journal_destroy(journal_t *journal)
 
 
 /**
- *int jbd2_journal_check_used_features () - Check if features specified are used.
+ *int jbd2_journal_check_used_features() - Check if features specified are used.
  * @journal: Journal to check.
  * @compat: bitmask of compatible features
  * @ro: bitmask of features that force read-only mount
@@ -1790,7 +1790,7 @@ int jbd2_journal_destroy(journal_t *journal)
  * features.  Return true (non-zero) if it does.
  **/
 
-int jbd2_journal_check_used_features (journal_t *journal, unsigned long compat,
+int jbd2_journal_check_used_features(journal_t *journal, unsigned long compat,
 				 unsigned long ro, unsigned long incompat)
 {
 	journal_superblock_t *sb;
@@ -1825,7 +1825,7 @@ int jbd2_journal_check_used_features (journal_t *journal, unsigned long compat,
  * all of a given set of features on this journal.  Return true
  * (non-zero) if it can. */
 
-int jbd2_journal_check_available_features (journal_t *journal, unsigned long compat,
+int jbd2_journal_check_available_features(journal_t *journal, unsigned long compat,
 				      unsigned long ro, unsigned long incompat)
 {
 	if (!compat && !ro && !incompat)
@@ -1847,7 +1847,7 @@ int jbd2_journal_check_available_features (journal_t *journal, unsigned long com
 }
 
 /**
- * int jbd2_journal_set_features () - Mark a given journal feature in the superblock
+ * int jbd2_journal_set_features() - Mark a given journal feature in the superblock
  * @journal: Journal to act on.
  * @compat: bitmask of compatible features
  * @ro: bitmask of features that force read-only mount
@@ -1858,7 +1858,7 @@ int jbd2_journal_check_available_features (journal_t *journal, unsigned long com
  *
  */
 
-int jbd2_journal_set_features (journal_t *journal, unsigned long compat,
+int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
 			  unsigned long ro, unsigned long incompat)
 {
 #define INCOMPAT_FEATURE_ON(f) \
-- 
2.39.2



