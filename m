Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE207F5029
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 20:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjKVTEn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 14:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjKVTEm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 14:04:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045F583
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 11:04:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5527EC433B7;
        Wed, 22 Nov 2023 19:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700679878;
        bh=eye19tI2iBOgyNbY7wGEebDuH2T3sg3qpfaziTf3J2s=;
        h=Subject:To:Cc:From:Date:From;
        b=Q/IrDL+1wGVpQ3rH88KqhX5uo8eIqAiQINLvYUHUc8HEzBk9rxOktc6ib6XK6xKv2
         9JZPzaVjkpUWdl6YAnuvF7NXpKcRegGvS5bQ8MYdSygQNzSwbBPQcQ1/FOthfwlhx6
         2k4MgEY9b70WIMx5l/zgDqI9COhtrLOgrFeHrt6s=
Subject: FAILED: patch "[PATCH] regmap: Ensure range selector registers are updated after" failed to apply to 4.19-stable tree
To:     broonie@kernel.org, marcan@marcan.st
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 19:04:36 +0000
Message-ID: <2023112236-grumble-repose-10b5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 0ec7731655de196bc1e4af99e495b38778109d22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112236-grumble-repose-10b5@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

0ec7731655de ("regmap: Ensure range selector registers are updated after cache sync")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ec7731655de196bc1e4af99e495b38778109d22 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Thu, 26 Oct 2023 16:49:19 +0100
Subject: [PATCH] regmap: Ensure range selector registers are updated after
 cache sync

When we sync the register cache we do so with the cache bypassed in order
to avoid overhead from writing the synced values back into the cache. If
the regmap has ranges and the selector register for those ranges is in a
register which is cached this has the unfortunate side effect of meaning
that the physical and cached copies of the selector register can be out of
sync after a cache sync. The cache will have whatever the selector was when
the sync started and the hardware will have the selector for the register
that was synced last.

Fix this by rewriting all cached selector registers after every sync,
ensuring that the hardware and cache have the same content. This will
result in extra writes that wouldn't otherwise be needed but is simple
so hopefully robust. We don't read from the hardware since not all
devices have physical read support.

Given that nobody noticed this until now it is likely that we are rarely if
ever hitting this case.

Reported-by: Hector Martin <marcan@marcan.st>
Cc: stable@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20231026-regmap-fix-selector-sync-v1-1-633ded82770d@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index c5d151e9c481..92592f944a3d 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -334,6 +334,11 @@ static int regcache_default_sync(struct regmap *map, unsigned int min,
 	return 0;
 }
 
+static int rbtree_all(const void *key, const struct rb_node *node)
+{
+	return 0;
+}
+
 /**
  * regcache_sync - Sync the register cache with the hardware.
  *
@@ -351,6 +356,7 @@ int regcache_sync(struct regmap *map)
 	unsigned int i;
 	const char *name;
 	bool bypass;
+	struct rb_node *node;
 
 	if (WARN_ON(map->cache_type == REGCACHE_NONE))
 		return -EINVAL;
@@ -392,6 +398,30 @@ int regcache_sync(struct regmap *map)
 	/* Restore the bypass state */
 	map->cache_bypass = bypass;
 	map->no_sync_defaults = false;
+
+	/*
+	 * If we did any paging with cache bypassed and a cached
+	 * paging register then the register and cache state might
+	 * have gone out of sync, force writes of all the paging
+	 * registers.
+	 */
+	rb_for_each(node, 0, &map->range_tree, rbtree_all) {
+		struct regmap_range_node *this =
+			rb_entry(node, struct regmap_range_node, node);
+
+		/* If there's nothing in the cache there's nothing to sync */
+		ret = regcache_read(map, this->selector_reg, &i);
+		if (ret != 0)
+			continue;
+
+		ret = _regmap_write(map, this->selector_reg, i);
+		if (ret != 0) {
+			dev_err(map->dev, "Failed to write %x = %x: %d\n",
+				this->selector_reg, i, ret);
+			break;
+		}
+	}
+
 	map->unlock(map->lock_arg);
 
 	regmap_async_complete(map);

