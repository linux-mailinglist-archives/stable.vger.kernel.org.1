Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250337A3B38
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbjIQUOa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240664AbjIQUOU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:14:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC109F1
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:14:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80E1C433C8;
        Sun, 17 Sep 2023 20:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981654;
        bh=M93lvDmvGYowRjbqFDk0eGbyXa1ztdvRmsI/zOj1GVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vo6AdaubR2qglZvC0iwqsFap2OqncudzsUf/Bf6D9g9X9AJeO9mALDauxU4IJ2eDY
         4b6TYrHugktJuyK8qXzGcjJZYw1WW+fWZVvVtr7OsyEvZFFgeCl1FB1hks4doOf02n
         L+4rn9pnbLYPehYNEFoFAExQeS2piFQXhLIcNhH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 084/511] regmap: rbtree: Use alloc_flags for memory allocations
Date:   Sun, 17 Sep 2023 21:08:31 +0200
Message-ID: <20230917191115.900859974@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 0c8b0bf42c8cef56f7cd9cd876fbb7ece9217064 ]

The kunit tests discovered a sleeping in atomic bug.  The allocations
in the regcache-rbtree code should use the map->alloc_flags instead of
GFP_KERNEL.

[    5.005510] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[    5.005960] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 117, name: kunit_try_catch
[    5.006219] preempt_count: 1, expected: 0
[    5.006414] 1 lock held by kunit_try_catch/117:
[    5.006590]  #0: 833b9010 (regmap_kunit:86:(config)->lock){....}-{2:2}, at: regmap_lock_spinlock+0x14/0x1c
[    5.007493] irq event stamp: 162
[    5.007627] hardirqs last  enabled at (161): [<80786738>] crng_make_state+0x1a0/0x294
[    5.007871] hardirqs last disabled at (162): [<80c531ec>] _raw_spin_lock_irqsave+0x7c/0x80
[    5.008119] softirqs last  enabled at (0): [<801110ac>] copy_process+0x810/0x2138
[    5.008356] softirqs last disabled at (0): [<00000000>] 0x0
[    5.008688] CPU: 0 PID: 117 Comm: kunit_try_catch Tainted: G                 N 6.4.4-rc3-g0e8d2fdfb188 #1
[    5.009011] Hardware name: Generic DT based system
[    5.009277]  unwind_backtrace from show_stack+0x18/0x1c
[    5.009497]  show_stack from dump_stack_lvl+0x38/0x5c
[    5.009676]  dump_stack_lvl from __might_resched+0x188/0x2d0
[    5.009860]  __might_resched from __kmem_cache_alloc_node+0x1dc/0x25c
[    5.010061]  __kmem_cache_alloc_node from kmalloc_trace+0x30/0xc8
[    5.010254]  kmalloc_trace from regcache_rbtree_write+0x26c/0x468
[    5.010446]  regcache_rbtree_write from _regmap_write+0x88/0x140
[    5.010634]  _regmap_write from regmap_write+0x44/0x68
[    5.010803]  regmap_write from basic_read_write+0x8c/0x270
[    5.010980]  basic_read_write from kunit_try_run_case+0x48/0xa0

Fixes: 28644c809f44 ("regmap: Add the rbtree cache support")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net/
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/58f12a07-5f4b-4a8f-ab84-0a42d1908cb9@moroto.mountain
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regcache-rbtree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index fabf87058d80b..ae6b8788d5f3f 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -277,7 +277,7 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
 
 	blk = krealloc(rbnode->block,
 		       blklen * map->cache_word_size,
-		       GFP_KERNEL);
+		       map->alloc_flags);
 	if (!blk)
 		return -ENOMEM;
 
@@ -286,7 +286,7 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
 	if (BITS_TO_LONGS(blklen) > BITS_TO_LONGS(rbnode->blklen)) {
 		present = krealloc(rbnode->cache_present,
 				   BITS_TO_LONGS(blklen) * sizeof(*present),
-				   GFP_KERNEL);
+				   map->alloc_flags);
 		if (!present)
 			return -ENOMEM;
 
@@ -320,7 +320,7 @@ regcache_rbtree_node_alloc(struct regmap *map, unsigned int reg)
 	const struct regmap_range *range;
 	int i;
 
-	rbnode = kzalloc(sizeof(*rbnode), GFP_KERNEL);
+	rbnode = kzalloc(sizeof(*rbnode), map->alloc_flags);
 	if (!rbnode)
 		return NULL;
 
@@ -346,13 +346,13 @@ regcache_rbtree_node_alloc(struct regmap *map, unsigned int reg)
 	}
 
 	rbnode->block = kmalloc_array(rbnode->blklen, map->cache_word_size,
-				      GFP_KERNEL);
+				      map->alloc_flags);
 	if (!rbnode->block)
 		goto err_free;
 
 	rbnode->cache_present = kcalloc(BITS_TO_LONGS(rbnode->blklen),
 					sizeof(*rbnode->cache_present),
-					GFP_KERNEL);
+					map->alloc_flags);
 	if (!rbnode->cache_present)
 		goto err_free_block;
 
-- 
2.40.1



