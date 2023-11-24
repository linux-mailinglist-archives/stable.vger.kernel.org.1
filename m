Return-Path: <stable+bounces-761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE72D7F7C71
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B91B2125E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799939FDD;
	Fri, 24 Nov 2023 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MR+qPzWm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8F381D7;
	Fri, 24 Nov 2023 18:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEF0C433C7;
	Fri, 24 Nov 2023 18:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849711;
	bh=L0ABL8b5W35iITVnTa5J2EszIaHejO+3yHX4kfdZn8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MR+qPzWmY4k3KLO17erCOA98IuT+ePyGwP03VvLOfSmKWlm85OxuvI+1dUCYcv54z
	 ctPEvOykT70n5IFwk1dZ+w/uVgHG258yu+fcGimg6fGxKD0Xc4nZC9+MhWUMXO/zmE
	 tA4fdgufAO5zDVJRyfbyBogC49mp40QeUpObayGg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hector Martin <marcan@marcan.st>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6 289/530] regmap: Ensure range selector registers are updated after cache sync
Date: Fri, 24 Nov 2023 17:47:35 +0000
Message-ID: <20231124172036.837533638@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

commit 0ec7731655de196bc1e4af99e495b38778109d22 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/regmap/regcache.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -334,6 +334,11 @@ static int regcache_default_sync(struct
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
@@ -392,6 +398,30 @@ out:
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



