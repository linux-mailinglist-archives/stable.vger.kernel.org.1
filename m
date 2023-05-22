Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D2270C6F3
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjEVTYX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjEVTYW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:24:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E6B1B5
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFD1562866
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03F2C433D2;
        Mon, 22 May 2023 19:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783450;
        bh=HLRyMgawJujuYVpZlrvvskARUUQdZ/XGpjg2b3W8cVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olvU8Dx8f+Lr4akzajrNrUtde9xCS6JiaLfxS0sNqpcXpTc8olzoEiV9lluTTb6qz
         C4BwYlkUw2mfz+T6/3LDlTZkN+B3/Vy8OLmz+TT9ka6/MEwnClULoC/jp5CmPTFTKV
         RA910NgyBf7pfaoLmZVDL3LS8mXythX4vM1nsOJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 047/292] regmap: cache: Return error in cache sync operations for REGCACHE_NONE
Date:   Mon, 22 May 2023 20:06:44 +0100
Message-Id: <20230522190407.087509139@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 362e043e26d86..8031007b4887d 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -349,6 +349,9 @@ int regcache_sync(struct regmap *map)
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
@@ -418,6 +421,9 @@ int regcache_sync_region(struct regmap *map, unsigned int min,
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
-- 
2.39.2



