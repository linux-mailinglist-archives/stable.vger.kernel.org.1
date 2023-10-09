Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253E87BDE03
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376871AbjJINPA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376665AbjJINO7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:14:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551BB9C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:14:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF91C433C8;
        Mon,  9 Oct 2023 13:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857296;
        bh=o4YYDbdsCFB80Cfbl/SLpuJC8oDbvHkypZjXWM46joQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2D6AZygbMTvCpLtBNONo4zRJarq3Go97CcjAy+gJMjitYpu1AqXPVyn8tYnv90qLB
         o+fzM1M4ZhpSytc0VVDw3q8unUIyUaqTGEWJu6ghV1OeDbrQtw3EdfxWuhbKH6+XyV
         dj6N2cAQSxq0eh5h2TodMzegOPR5O5SQAigBqMSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH 6.5 163/163] RDMA/mlx5: Remove not-used cache disable flag
Date:   Mon,  9 Oct 2023 15:02:07 +0200
Message-ID: <20231009130128.500047722@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@nvidia.com>

commit c99a7457e5bb873914a74307ba2df85f6799203b upstream.

During execution of mlx5_mkey_cache_cleanup(), there is a guarantee
that MR are not registered and/or destroyed. It means that we don't
need newly introduced cache disable flag.

Fixes: 374012b00457 ("RDMA/mlx5: Fix mkey cache possible deadlock on cleanup")
Link: https://lore.kernel.org/r/c7e9c9f98c8ae4a7413d97d9349b29f5b0a23dbe.1695921626.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |    1 -
 drivers/infiniband/hw/mlx5/mr.c      |    5 -----
 2 files changed, 6 deletions(-)

--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -797,7 +797,6 @@ struct mlx5_mkey_cache {
 	struct dentry		*fs_root;
 	unsigned long		last_add;
 	struct delayed_work	remove_ent_dwork;
-	u8			disable: 1;
 };
 
 struct mlx5_ib_port_resources {
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1026,7 +1026,6 @@ void mlx5_mkey_cache_cleanup(struct mlx5
 		return;
 
 	mutex_lock(&dev->cache.rb_lock);
-	dev->cache.disable = true;
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		xa_lock_irq(&ent->mkeys);
@@ -1824,10 +1823,6 @@ static int cache_ent_find_and_store(stru
 	}
 
 	mutex_lock(&cache->rb_lock);
-	if (cache->disable) {
-		mutex_unlock(&cache->rb_lock);
-		return 0;
-	}
 	ent = mkey_cache_ent_from_rb_key(dev, mr->mmkey.rb_key);
 	if (ent) {
 		if (ent->rb_key.ndescs == mr->mmkey.rb_key.ndescs) {


