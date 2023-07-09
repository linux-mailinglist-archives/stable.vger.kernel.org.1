Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E74B74C226
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjGILRZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjGILRX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:17:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9C3130
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9531160BDB
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBA9C433C7;
        Sun,  9 Jul 2023 11:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901441;
        bh=ltDdcCX9n0VnJTXuPYQp43NxE5xIOpRKzyXzKrSc6I0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQFJU5nYBdZeTfkwIbl2vF0IihQQS6sCeC3BMo/egXivVJvkg3L+IQGSmgMVnh0nx
         bdpfZTx8FaTW1pmohMPidyZdF9PB2JMizRMMREqhee0EmIdlNhxLD0zOETvs4gFIIm
         xGrRN9ikc5Ua4gziO6/KebZSV6HnsIuiyIDXwbXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Nan <linan122@huawei.com>,
        Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 021/431] md/raid10: fix null-ptr-deref of mreplace in raid10_sync_request
Date:   Sun,  9 Jul 2023 13:09:29 +0200
Message-ID: <20230709111451.599917207@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Li Nan <linan122@huawei.com>

[ Upstream commit 34817a2441747b48e444cb0e05d84e14bc9443da ]

There are two check of 'mreplace' in raid10_sync_request(). In the first
check, 'need_replace' will be set and 'mreplace' will be used later if
no-Faulty 'mreplace' exists, In the second check, 'mreplace' will be
set to NULL if it is Faulty, but 'need_replace' will not be changed
accordingly. null-ptr-deref occurs if Faulty is set between two check.

Fix it by merging two checks into one. And replace 'need_replace' with
'mreplace' because their values are always the same.

Fixes: ee37d7314a32 ("md/raid10: Fix raid10 replace hang when new added disk faulty")
Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230527072218.2365857-2-linan666@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid10.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index ea6967aeaa02a..7b5f26726b310 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3436,7 +3436,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			int must_sync;
 			int any_working;
 			int need_recover = 0;
-			int need_replace = 0;
 			struct raid10_info *mirror = &conf->mirrors[i];
 			struct md_rdev *mrdev, *mreplace;
 
@@ -3448,11 +3447,10 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			    !test_bit(Faulty, &mrdev->flags) &&
 			    !test_bit(In_sync, &mrdev->flags))
 				need_recover = 1;
-			if (mreplace != NULL &&
-			    !test_bit(Faulty, &mreplace->flags))
-				need_replace = 1;
+			if (mreplace && test_bit(Faulty, &mreplace->flags))
+				mreplace = NULL;
 
-			if (!need_recover && !need_replace) {
+			if (!need_recover && !mreplace) {
 				rcu_read_unlock();
 				continue;
 			}
@@ -3468,8 +3466,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				rcu_read_unlock();
 				continue;
 			}
-			if (mreplace && test_bit(Faulty, &mreplace->flags))
-				mreplace = NULL;
 			/* Unless we are doing a full sync, or a replacement
 			 * we only need to recover the block if it is set in
 			 * the bitmap
@@ -3592,11 +3588,11 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				bio = r10_bio->devs[1].repl_bio;
 				if (bio)
 					bio->bi_end_io = NULL;
-				/* Note: if need_replace, then bio
+				/* Note: if replace is not NULL, then bio
 				 * cannot be NULL as r10buf_pool_alloc will
 				 * have allocated it.
 				 */
-				if (!need_replace)
+				if (!mreplace)
 					break;
 				bio->bi_next = biolist;
 				biolist = bio;
-- 
2.39.2



