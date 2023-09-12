Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7161B79AFFD
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242207AbjIKWZR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbjIKNzj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:55:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCDDFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:55:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A7DC433C8;
        Mon, 11 Sep 2023 13:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440534;
        bh=3kCuX8xAZjFK53YHKqAZV3eGZ8Fl29KLWfu/YY08Y3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vMs22f+uDPfbyPMrlsOSVEGDtFipTT27Yv7NAcu7+/BNnM1RQ74mHKf/vLZiNL9CD
         jifA7sy63jD5EigTrOl+f1XcikD/Mrr/hU+JaQRtNLW/B3gICGpphBCVhzinDNHmbQ
         3KEr0IWkEFoBYfAt2VApulQ7UDFP5KV0XfK8cQ7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 078/739] regmap: rbtree: Use alloc_flags for memory allocations
Date:   Mon, 11 Sep 2023 15:37:57 +0200
Message-ID: <20230911134653.294709134@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 584bcc55f56e3..06788965aa293 100644
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



