Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAF27ECF2E
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbjKOTqw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbjKOTqv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:46:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45213B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:46:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0A8C433C7;
        Wed, 15 Nov 2023 19:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077607;
        bh=kVsOrmYdArOt7f1QNAwmpu+shbEVATiShSdQb1MNUH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U40D6OORbQJfQ2OuqWOoV8cERKCV00YA1n9mQsjA0ClJ2/s4ih4I3VhuR8xOj4QPq
         7DH40sOurg6NIMAo18+rUkhNXK1RnRxD6vZJQ3//U1WKOXXMqQFE0/Rjrf9PZFzeHd
         9Whu6Qlr0IjX5dIKisUE/pc+1JwXWLG09ruwIBWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 407/603] erofs: fix erofs_insert_workgroup() lockref usage
Date:   Wed, 15 Nov 2023 14:15:52 -0500
Message-ID: <20231115191641.195932398@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 036f610e044b6..a7e6847f6f8f1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -796,6 +796,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 		return PTR_ERR(pcl);
 
 	spin_lock_init(&pcl->obj.lockref.lock);
+	pcl->obj.lockref.count = 1;	/* one ref for this request */
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = 0;
 	pcl->partial = true;
-- 
2.42.0



