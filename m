Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBAD7DD3F0
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjJaRGU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjJaRGI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:06:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAF8D6E
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:03:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F07C433C7;
        Tue, 31 Oct 2023 17:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771821;
        bh=Kq1Uvqamcul0iTyiYNZMl4eFlISLOpSZgg/7K2q6qS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lyUzxRCiTwL+zN4NDtKgaF1DRsE7tCqLzu6KdMWGqUwtjep7RjJWHZiltaQknLEgJ
         PleRzKyLyOA1Q6zlWig+sVishtVfGSvI1jaxenk17c9pXgoJtKPKVUr6Zx8rH2OmJv
         sYe+HK6wX5JDBcM5TqgWtvtLqibmMjzweXC6n6Hs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>,
        Javier Rodriguez <josejavier.rodriguez@duagon.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 11/86] mcb-lpc: Reallocate memory region to avoid memory overlapping
Date:   Tue, 31 Oct 2023 18:00:36 +0100
Message-ID: <20231031165918.970355930@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>

[ Upstream commit 2025b2ca8004c04861903d076c67a73a0ec6dfca ]

mcb-lpc requests a fixed-size memory region to parse the chameleon
table, however, if the chameleon table is smaller that the allocated
region, it could overlap with the IP Cores' memory regions.

After parsing the chameleon table, drop/reallocate the memory region
with the actual chameleon table size.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
Link: https://lore.kernel.org/r/20230411083329.4506-4-jth@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mcb/mcb-lpc.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
index 53decd89876ee..a851e02364642 100644
--- a/drivers/mcb/mcb-lpc.c
+++ b/drivers/mcb/mcb-lpc.c
@@ -23,7 +23,7 @@ static int mcb_lpc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct priv *priv;
-	int ret = 0;
+	int ret = 0, table_size;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -58,16 +58,43 @@ static int mcb_lpc_probe(struct platform_device *pdev)
 
 	ret = chameleon_parse_cells(priv->bus, priv->mem->start, priv->base);
 	if (ret < 0) {
-		mcb_release_bus(priv->bus);
-		return ret;
+		goto out_mcb_bus;
 	}
 
-	dev_dbg(&pdev->dev, "Found %d cells\n", ret);
+	table_size = ret;
+
+	if (table_size < CHAM_HEADER_SIZE) {
+		/* Release the previous resources */
+		devm_iounmap(&pdev->dev, priv->base);
+		devm_release_mem_region(&pdev->dev, priv->mem->start, resource_size(priv->mem));
+
+		/* Then, allocate it again with the actual chameleon table size */
+		res = devm_request_mem_region(&pdev->dev, priv->mem->start,
+					      table_size,
+					      KBUILD_MODNAME);
+		if (!res) {
+			dev_err(&pdev->dev, "Failed to request PCI memory\n");
+			ret = -EBUSY;
+			goto out_mcb_bus;
+		}
+
+		priv->base = devm_ioremap(&pdev->dev, priv->mem->start, table_size);
+		if (!priv->base) {
+			dev_err(&pdev->dev, "Cannot ioremap\n");
+			ret = -ENOMEM;
+			goto out_mcb_bus;
+		}
+
+		platform_set_drvdata(pdev, priv);
+	}
 
 	mcb_bus_add_devices(priv->bus);
 
 	return 0;
 
+out_mcb_bus:
+	mcb_release_bus(priv->bus);
+	return ret;
 }
 
 static int mcb_lpc_remove(struct platform_device *pdev)
-- 
2.42.0



