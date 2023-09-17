Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53857A3B22
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbjIQUN5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240689AbjIQUNg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:13:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F8ACFB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:13:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B168EC433D9;
        Sun, 17 Sep 2023 20:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981582;
        bh=TTPbVlK/bwy8GzrG/ykxT0B8gc6AxMVjY9eJcl9cuvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M4PEWyfoR2RcnVn12VBEfqPUmKmBPHkY7LgJ4yzSnBkuSO34THXXuv13W+g739cQe
         CeD4oQTTZoR/ppvaOSIQLooSoLgKrUCkM1O3Jh78QZGsXXkqftSzTPTin70/cwKUNU
         HBn0m+j4GWuCk26JVCftG3yz1iEAQYYB2fZMYv3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Theodore Tso <tytso@mit.edu>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 6.1 143/219] jbd2: correct the end of the journal recovery scan range
Date:   Sun, 17 Sep 2023 21:14:30 +0200
Message-ID: <20230917191046.174824976@linuxfoundation.org>
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

commit 2dfba3bb40ad8536b9fa802364f2d40da31aa88e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jbd2/recovery.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -229,12 +229,8 @@ static int count_tags(journal_t *journal
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
@@ -517,9 +513,7 @@ static int do_one_pass(journal_t *journa
 				break;
 
 		jbd2_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
-			  next_commit_ID, next_log_block,
-			  jbd2_has_feature_fast_commit(journal) ?
-			  journal->j_fc_last : journal->j_last);
+			  next_commit_ID, next_log_block, journal->j_last);
 
 		/* Skip over each chunk of the transaction looking
 		 * either the next descriptor block or the final commit


