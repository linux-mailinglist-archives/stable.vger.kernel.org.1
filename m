Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B50A79BD2F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377590AbjIKW11 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240039AbjIKOeu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:34:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33F1E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:34:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F368FC433C8;
        Mon, 11 Sep 2023 14:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442883;
        bh=Fzf/7AIHAzWCeVLEwm98e3tTnBE2BY9HIxhxYcA0+z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yXGdUG2fwxAJBdRT79QoT3f9yy4+2Ip3HJoHTy5GA8yD3lrDtMgMO8OiKLbdnb80y
         6NQVmmuP2HEGqzSyC6U/8ZvW83wNHv1FOpzYUQGp8BGWIQzbDZrbS08xusWijEmf8D
         +k8iaNApKWzUQQHLFM4Yq6xtiNP+Q7yhyfpu9GSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 154/737] regmap: Load register defaults in blocks rather than register by register
Date:   Mon, 11 Sep 2023 15:40:13 +0200
Message-ID: <20230911134654.788298054@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 3a48d2127f4dbd767d43bf8280b67d585e701f75 ]

Currently we use the normal single register write function to load the
default values into the cache, resulting in a large number of reallocations
when there are blocks of registers as we extend the memory region we are
using to store the values. Instead scan through the list of defaults for
blocks of adjacent registers and do a single allocation and insert for each
such block. No functional change.

We do not take advantage of the maple tree preallocation, this is purely at
the regcache level. It is not clear to me yet if the maple tree level would
help much here or if we'd have more overhead from overallocating and then
freeing maple tree data.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20230523-regcache-maple-load-defaults-v1-1-0c04336f005d@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: b0393e1fe40e ("regmap: maple: Use alloc_flags for memory allocations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regcache-maple.c | 58 +++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index c2e3a0f6c2183..14f6f49af097c 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -242,11 +242,41 @@ static int regcache_maple_exit(struct regmap *map)
 	return 0;
 }
 
+static int regcache_maple_insert_block(struct regmap *map, int first,
+					int last)
+{
+	struct maple_tree *mt = map->cache;
+	MA_STATE(mas, mt, first, last);
+	unsigned long *entry;
+	int i, ret;
+
+	entry = kcalloc(last - first + 1, sizeof(unsigned long), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	for (i = 0; i < last - first + 1; i++)
+		entry[i] = map->reg_defaults[first + i].def;
+
+	mas_lock(&mas);
+
+	mas_set_range(&mas, map->reg_defaults[first].reg,
+		      map->reg_defaults[last].reg);
+	ret = mas_store_gfp(&mas, entry, GFP_KERNEL);
+
+	mas_unlock(&mas);
+
+	if (ret)
+		kfree(entry);
+
+	return ret;
+}
+
 static int regcache_maple_init(struct regmap *map)
 {
 	struct maple_tree *mt;
 	int i;
 	int ret;
+	int range_start;
 
 	mt = kmalloc(sizeof(*mt), GFP_KERNEL);
 	if (!mt)
@@ -255,14 +285,30 @@ static int regcache_maple_init(struct regmap *map)
 
 	mt_init(mt);
 
-	for (i = 0; i < map->num_reg_defaults; i++) {
-		ret = regcache_maple_write(map,
-					   map->reg_defaults[i].reg,
-					   map->reg_defaults[i].def);
-		if (ret)
-			goto err;
+	if (!map->num_reg_defaults)
+		return 0;
+
+	range_start = 0;
+
+	/* Scan for ranges of contiguous registers */
+	for (i = 1; i < map->num_reg_defaults; i++) {
+		if (map->reg_defaults[i].reg !=
+		    map->reg_defaults[i - 1].reg + 1) {
+			ret = regcache_maple_insert_block(map, range_start,
+							  i - 1);
+			if (ret != 0)
+				goto err;
+
+			range_start = i;
+		}
 	}
 
+	/* Add the last block */
+	ret = regcache_maple_insert_block(map, range_start,
+					  map->num_reg_defaults - 1);
+	if (ret != 0)
+		goto err;
+
 	return 0;
 
 err:
-- 
2.40.1



