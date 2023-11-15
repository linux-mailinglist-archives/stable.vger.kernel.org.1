Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3652F7ECC83
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjKOTa7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjKOTa4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:30:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25819F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:30:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265E7C433CA;
        Wed, 15 Nov 2023 19:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076653;
        bh=Bo/lokr+0JMmpPq1AybZ6pFN2Pl2g0JM0mF8zSeYrKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXL/z9mzNRfkeqtoUBtC61npLj1jgByyIgvNkCvTbeU3bLjK4NB7TvFeKyOeffye9
         uZytdWgVjGfDpir3Wb7A1c/O1CK1Z3fqO260Tv6xH2Afj/dsZR9XU8JUsCPfVejuk5
         0aP8jEY9sHo7AGMZRLWdQounrCimv1WFVeCMbJWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 364/550] erofs: fix erofs_insert_workgroup() lockref usage
Date:   Wed, 15 Nov 2023 14:15:48 -0500
Message-ID: <20231115191626.050160137@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 1a0ac8bd7a4fa5b2f4ef14c3b1e9d6e5a5faae06 ]

As Linus pointed out [1], lockref_put_return() is fundamentally
designed to be something that can fail.  It behaves as a fastpath-only
thing, and the failure case needs to be handled anyway.

Actually, since the new pcluster was just allocated without being
populated, it won't be accessed by others until it is inserted into
XArray, so lockref helpers are actually unneeded here.

Let's just set the proper reference count on initializing.

[1] https://lore.kernel.org/r/CAHk-=whCga8BeQnJ3ZBh_Hfm9ctba_wpF444LpwRybVNMzO6Dw@mail.gmail.com

Fixes: 7674a42f35ea ("erofs: use struct lockref to replace handcrafted approach")
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20231031060524.1103921-1-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/utils.c | 8 +-------
 fs/erofs/zdata.c | 1 +
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index cc6fb9e988991..4256a85719a1d 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -77,12 +77,7 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	struct erofs_workgroup *pre;
 
-	/*
-	 * Bump up before making this visible to others for the XArray in order
-	 * to avoid potential UAF without serialized by xa_lock.
-	 */
-	lockref_get(&grp->lockref);
-
+	DBG_BUGON(grp->lockref.count < 1);
 repeat:
 	xa_lock(&sbi->managed_pslots);
 	pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
@@ -96,7 +91,6 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
 			cond_resched();
 			goto repeat;
 		}
-		lockref_put_return(&grp->lockref);
 		grp = pre;
 	}
 	xa_unlock(&sbi->managed_pslots);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 9bfdb4ad7c763..2461a3f74e744 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -805,6 +805,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 		return PTR_ERR(pcl);
 
 	spin_lock_init(&pcl->obj.lockref.lock);
+	pcl->obj.lockref.count = 1;	/* one ref for this request */
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = 0;
 	pcl->partial = true;
-- 
2.42.0



