Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642E67A3BFC
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbjIQUZI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbjIQUYx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:24:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4D6101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:24:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C587C433C8;
        Sun, 17 Sep 2023 20:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982287;
        bh=SOuD8+8HltxNpybI94VBXJD4zGYas+uldGbmjUUeAOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZA3uROpkl8q0ABrRfCDKiE5lQia2gthju2wYdjsUAItGDWuQGlICsd5Sf483KHhP
         x5B2ARyuTEHzW4+QcA/EcYepHorRehpQVcb04jmBvkj1HNR34XZFYB17D4Cme7Q+WO
         /C7bxdCXiDwNO3SLcL0laGIkz6gUhkheDI02ieJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 206/511] pinctrl: mcp23s08: check return value of devm_kasprintf()
Date:   Sun, 17 Sep 2023 21:10:33 +0200
Message-ID: <20230917191118.797600155@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit f941714a7c7698eadb59bc27d34d6d6f38982705 ]

devm_kasprintf() returns a pointer to dynamically allocated memory.
Pointer could be NULL in case allocation fails. Check pointer validity.
Identified with coccinelle (kmerr.cocci script).

Fixes: 0f04a81784fe ("pinctrl: mcp23s08: Split to three parts: core, I²C, SPI")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230621100409.1608395-1-claudiu.beznea@microchip.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-mcp23s08_spi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08_spi.c b/drivers/pinctrl/pinctrl-mcp23s08_spi.c
index 9ae10318f6f35..ea059b9c5542e 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08_spi.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08_spi.c
@@ -91,18 +91,28 @@ static int mcp23s08_spi_regmap_init(struct mcp23s08 *mcp, struct device *dev,
 		mcp->reg_shift = 0;
 		mcp->chip.ngpio = 8;
 		mcp->chip.label = devm_kasprintf(dev, GFP_KERNEL, "mcp23s08.%d", addr);
+		if (!mcp->chip.label)
+			return -ENOMEM;
 
 		config = &mcp23x08_regmap;
 		name = devm_kasprintf(dev, GFP_KERNEL, "%d", addr);
+		if (!name)
+			return -ENOMEM;
+
 		break;
 
 	case MCP_TYPE_S17:
 		mcp->reg_shift = 1;
 		mcp->chip.ngpio = 16;
 		mcp->chip.label = devm_kasprintf(dev, GFP_KERNEL, "mcp23s17.%d", addr);
+		if (!mcp->chip.label)
+			return -ENOMEM;
 
 		config = &mcp23x17_regmap;
 		name = devm_kasprintf(dev, GFP_KERNEL, "%d", addr);
+		if (!name)
+			return -ENOMEM;
+
 		break;
 
 	case MCP_TYPE_S18:
-- 
2.40.1



