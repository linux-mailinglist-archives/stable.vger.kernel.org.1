Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690097BDDB1
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376971AbjJINMb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376809AbjJINMP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:12:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6F412C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:11:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F99C433CD;
        Mon,  9 Oct 2023 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857069;
        bh=QIfCnUsQtrz7dFkgu68478JUURRxJ2F34ESFKmSJ7Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1nPOX4ubrerkgL3kazkCb7NpDQn94wK/Nx66iLt57SCgHCHktSUI1pHZ0uBLIML/3
         fd8waxxHXvavJ255ajQH6EEZ0nFuRzlJ87Bl8UhonjB/5vSHX7/wOOm+4sARGSzcwP
         FU9Sa18n5hXIXmevBwC8ONIwIb55NYl7tI0ft0OI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 085/163] regmap: rbtree: Fix wrong register marked as in-cache when creating new node
Date:   Mon,  9 Oct 2023 15:00:49 +0200
Message-ID: <20231009130126.392409104@linuxfoundation.org>
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

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 7a795ac8d49e2433e1b97caf5e99129daf8e1b08 ]

When regcache_rbtree_write() creates a new rbtree_node it was passing the
wrong bit number to regcache_rbtree_set_register(). The bit number is the
offset __in number of registers__, but in the case of creating a new block
regcache_rbtree_write() was not dividing by the address stride to get the
number of registers.

Fix this by dividing by map->reg_stride.
Compare with regcache_rbtree_read() where the bit is checked.

This bug meant that the wrong register was marked as present. The register
that was written to the cache could not be read from the cache because it
was not marked as cached. But a nearby register could be marked as having
a cached value even if it was never written to the cache.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 3f4ff561bc88 ("regmap: rbtree: Make cache_present bitmap per node")
Link: https://lore.kernel.org/r/20230922153711.28103-1-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regcache-rbtree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index 06788965aa293..31d7bc682910c 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -453,7 +453,8 @@ static int regcache_rbtree_write(struct regmap *map, unsigned int reg,
 		if (!rbnode)
 			return -ENOMEM;
 		regcache_rbtree_set_register(map, rbnode,
-					     reg - rbnode->base_reg, value);
+					     (reg - rbnode->base_reg) / map->reg_stride,
+					     value);
 		regcache_rbtree_insert(map, &rbtree_ctx->root, rbnode);
 		rbtree_ctx->cached_rbnode = rbnode;
 	}
-- 
2.40.1



