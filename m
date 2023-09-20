Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1FC7A7BB3
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjITLzM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbjITLyj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:54:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3225BF7
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:54:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5749AC433C9;
        Wed, 20 Sep 2023 11:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210868;
        bh=10NLeIdLMVuGb3za/n35W5V+3gl9fL4nvvGdb8WIQls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AWk0FXNQB+Hhg4Fyi1Usd65pxu6bZWNm/cQubymd00ZzfnzTZTe1o1cwG2wmxPuzH
         C26mBHVOEjhqia1nX40koO2IXoDxY00ZOGQOjTYb6oZv3guvZM07ZQgzqUoxkqxoNd
         CmDyoJt1OgWu880AZZ6eVhVLyen7FNHiI8VjkOpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Watts <contact@jookia.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 022/139] can: sun4i_can: Add acceptance register quirk
Date:   Wed, 20 Sep 2023 13:29:16 +0200
Message-ID: <20230920112836.422390424@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
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

From: John Watts <contact@jookia.org>

[ Upstream commit 8cda0c6dfd42ee6f2586e7dffb553aaf1fcb62ca ]

The Allwinner D1's CAN controllers have the ACPC and ACPM registers
moved down. Compensate for this by adding an offset quirk for the
acceptance registers.

Signed-off-by: John Watts <contact@jookia.org>
Link: https://lore.kernel.org/all/20230721221552.1973203-5-contact@jookia.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/sun4i_can.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 2b78f9197681b..dd0c6cd76c5f5 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -205,9 +205,11 @@
  * struct sun4ican_quirks - Differences between SoC variants.
  *
  * @has_reset: SoC needs reset deasserted.
+ * @acp_offset: Offset of ACPC and ACPM registers
  */
 struct sun4ican_quirks {
 	bool has_reset;
+	int acp_offset;
 };
 
 struct sun4ican_priv {
@@ -216,6 +218,7 @@ struct sun4ican_priv {
 	struct clk *clk;
 	struct reset_control *reset;
 	spinlock_t cmdreg_lock;	/* lock for concurrent cmd register writes */
+	int acp_offset;
 };
 
 static const struct can_bittiming_const sun4ican_bittiming_const = {
@@ -338,8 +341,8 @@ static int sun4i_can_start(struct net_device *dev)
 	}
 
 	/* set filters - we accept all */
-	writel(0x00000000, priv->base + SUN4I_REG_ACPC_ADDR);
-	writel(0xFFFFFFFF, priv->base + SUN4I_REG_ACPM_ADDR);
+	writel(0x00000000, priv->base + SUN4I_REG_ACPC_ADDR + priv->acp_offset);
+	writel(0xFFFFFFFF, priv->base + SUN4I_REG_ACPM_ADDR + priv->acp_offset);
 
 	/* clear error counters and error code capture */
 	writel(0, priv->base + SUN4I_REG_ERRC_ADDR);
@@ -768,10 +771,12 @@ static const struct ethtool_ops sun4ican_ethtool_ops = {
 
 static const struct sun4ican_quirks sun4ican_quirks_a10 = {
 	.has_reset = false,
+	.acp_offset = 0,
 };
 
 static const struct sun4ican_quirks sun4ican_quirks_r40 = {
 	.has_reset = true,
+	.acp_offset = 0,
 };
 
 static const struct of_device_id sun4ican_of_match[] = {
@@ -872,6 +877,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 	priv->base = addr;
 	priv->clk = clk;
 	priv->reset = reset;
+	priv->acp_offset = quirks->acp_offset;
 	spin_lock_init(&priv->cmdreg_lock);
 
 	platform_set_drvdata(pdev, dev);
-- 
2.40.1



