Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438AA713D26
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjE1TWY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjE1TWW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:22:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95D9E4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25F5861B38
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439CDC433EF;
        Sun, 28 May 2023 19:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301739;
        bh=1sAK7siXULBkOdJo4LOofxcynx/scLOF9+4VyLSnkiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LvK15gaVjWYEWCEqVvyznvMRyTAqYbqfT8jiNpriZKKCLVQhrMkt6ae+SWJbC/osO
         oy0YZHBjguf8KLxKus4Y4DlMBAJDKBcM15FIo+T+k2prfycBA0a02XhIC46eYVqe0x
         YLNJP0rCkBtXessKYrloUpqhrczwGE/+UPqrO0l4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 017/161] regmap: cache: Return error in cache sync operations for REGCACHE_NONE
Date:   Sun, 28 May 2023 20:09:01 +0100
Message-Id: <20230528190837.678150233@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit fd883d79e4dcd2417c2b80756f22a2ff03b0f6e0 ]

There is no sense in doing a cache sync on REGCACHE_NONE regmaps.
Instead of panicking the kernel due to missing cache_ops, return an error
to client driver.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://lore.kernel.org/r/20230313071812.13577-1-alexander.stein@ew.tq-group.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regcache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 7f4b3b62492ca..7fdd702e564ae 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -343,6 +343,9 @@ int regcache_sync(struct regmap *map)
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
@@ -412,6 +415,9 @@ int regcache_sync_region(struct regmap *map, unsigned int min,
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
-- 
2.39.2



