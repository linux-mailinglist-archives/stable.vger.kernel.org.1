Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC3579C01D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjIKUwZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242223AbjIKPZY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:25:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B12D8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:25:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BFBC433C7;
        Mon, 11 Sep 2023 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445920;
        bh=cSI3DgVwsEhcKPNlpkURsZZaToyzp1MyWRmH0jPWxTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J/tq9385XpR9Ft+8SNbEJAh7lRZ9sqNUqXO4u+P4sUrhthHjRe5OKya7695KwmHWa
         GMW3y+7EuJNXxwkHBWxFahc+5WNcbsmduUDxcosQs0M2Vv8gzT9sUm/7xiCDL/gpjQ
         bst1gZ8hmSv1KRja0Bstk1MtIDlXz4SPyxJX+9iw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yi Yang <yiyang13@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 511/600] mtd: rawnand: fsmc: handle clk prepare error in fsmc_nand_resume()
Date:   Mon, 11 Sep 2023 15:49:04 +0200
Message-ID: <20230911134648.703112216@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yi Yang <yiyang13@huawei.com>

[ Upstream commit a5a88125d00612586e941ae13e7fcf36ba8f18a7 ]

In fsmc_nand_resume(), the return value of clk_prepare_enable() should be
checked since it might fail.

Fixes: e25da1c07dfb ("mtd: fsmc_nand: Add clk_{un}prepare() support")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230817115839.10192-1-yiyang13@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 6b2bda815b880..17786e1331e6d 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -1202,9 +1202,14 @@ static int fsmc_nand_suspend(struct device *dev)
 static int fsmc_nand_resume(struct device *dev)
 {
 	struct fsmc_nand_data *host = dev_get_drvdata(dev);
+	int ret;
 
 	if (host) {
-		clk_prepare_enable(host->clk);
+		ret = clk_prepare_enable(host->clk);
+		if (ret) {
+			dev_err(dev, "failed to enable clk\n");
+			return ret;
+		}
 		if (host->dev_timings)
 			fsmc_nand_setup(host, host->dev_timings);
 		nand_reset(&host->nand, 0);
-- 
2.40.1



