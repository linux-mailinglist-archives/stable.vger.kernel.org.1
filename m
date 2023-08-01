Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB7B76AEE9
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjHAJnI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjHAJmt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:42:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCBDC1
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AB726151C
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FB0C433C8;
        Tue,  1 Aug 2023 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882826;
        bh=NyjbPFyh8/vpO3bxQ6FOcJkSjE+lBnvIFvA3I59b6bA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e+L1VluteHWvF7AB3U+4O1wEpaAaehyUzAPcvFojD+OKxXXRxneCnqBikjycQ2T+T
         yGEeX9Zjsbh991lQT5P2MBkCuUOiR9Kjt76DEewr4GFBJ7yPW/0Y1j73jLOamfPcrO
         E13xaC6UCRXd55OiFvDtMeRTQbLvP1p79TK8X7VU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 017/239] regmap: Disable locking for RBTREE and MAPLE unit tests
Date:   Tue,  1 Aug 2023 11:18:01 +0200
Message-ID: <20230801091926.266107629@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit a9e26169cfda651802f88262a315146fbe4bc74c ]

REGCACHE_RBTREE and REGCACHE_MAPLE dynamically allocate memory
for regmap operations. This is incompatible with spinlock based locking
which is used for fast_io operations. Disable locking for the associated
unit tests to avoid lockdep splashes.

Fixes: f033c26de5a5 ("regmap: Add maple tree based register cache")
Fixes: 2238959b6ad2 ("regmap: Add some basic kunit tests")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20230720032848.1306349-1-linux@roeck-us.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap-kunit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index f76d416881349..0b3dacc7fa424 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -58,6 +58,9 @@ static struct regmap *gen_regmap(struct regmap_config *config,
 	int i;
 	struct reg_default *defaults;
 
+	config->disable_locking = config->cache_type == REGCACHE_RBTREE ||
+					config->cache_type == REGCACHE_MAPLE;
+
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
-- 
2.39.2



