Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6829713C42
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjE1TNk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjE1TNh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F76C4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:13:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4389A61919
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C03EC433AE;
        Sun, 28 May 2023 19:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301214;
        bh=EqIMHBb7lsreNcuYs0ZyX0cN2/SZ4HVZvunmtr4aWAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uh5Y4xDsLR4O3KbfCee/+wLAc7l/IBhm2n/rnkxk62POUHWjvUJ46qgRMOpSn07EF
         WyX4SZBfDCpUQwCTQyk/o6XtJ4joDdT4+3SnH1W1KbaM3sIrbncrT4ZtfScwjQuJof
         PbD+BRibBJU9yvJO+1/b6GeWpLwRP3CmtyNTWVxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kevin Groeneveld <kgroeneveld@lenbrook.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 28/86] spi: spi-imx: fix MX51_ECSPI_* macros when cs > 3
Date:   Sun, 28 May 2023 20:10:02 +0100
Message-Id: <20230528190829.624262314@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.564682883@linuxfoundation.org>
References: <20230528190828.564682883@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kevin Groeneveld <kgroeneveld@lenbrook.com>

[ Upstream commit 87c614175bbf28d3fd076dc2d166bac759e41427 ]

When using gpio based chip select the cs value can go outside the range
0 – 3. The various MX51_ECSPI_* macros did not take this into consideration
resulting in possible corruption of the configuration.

For example for any cs value over 3 the SCLKPHA bits would not be set and
other values in the register possibly corrupted.

One way to fix this is to just mask the cs bits to 2 bits. This still
allows all 4 native chip selects to work as well as gpio chip selects
(which can use any of the 4 chip select configurations).

Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
Link: https://lore.kernel.org/r/20230318222132.3373-1-kgroeneveld@lenbrook.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-imx.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index df18d07d544d5..e306de7009295 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -241,6 +241,18 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 	return true;
 }
 
+/*
+ * Note the number of natively supported chip selects for MX51 is 4. Some
+ * devices may have less actual SS pins but the register map supports 4. When
+ * using gpio chip selects the cs values passed into the macros below can go
+ * outside the range 0 - 3. We therefore need to limit the cs value to avoid
+ * corrupting bits outside the allocated locations.
+ *
+ * The simplest way to do this is to just mask the cs bits to 2 bits. This
+ * still allows all 4 native chip selects to work as well as gpio chip selects
+ * (which can use any of the 4 chip select configurations).
+ */
+
 #define MX51_ECSPI_CTRL		0x08
 #define MX51_ECSPI_CTRL_ENABLE		(1 <<  0)
 #define MX51_ECSPI_CTRL_XCH		(1 <<  2)
@@ -249,16 +261,16 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_CTRL_DRCTL(drctl)	((drctl) << 16)
 #define MX51_ECSPI_CTRL_POSTDIV_OFFSET	8
 #define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
-#define MX51_ECSPI_CTRL_CS(cs)		((cs) << 18)
+#define MX51_ECSPI_CTRL_CS(cs)		((cs & 3) << 18)
 #define MX51_ECSPI_CTRL_BL_OFFSET	20
 #define MX51_ECSPI_CTRL_BL_MASK		(0xfff << 20)
 
 #define MX51_ECSPI_CONFIG	0x0c
-#define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
-#define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
-#define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
-#define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
-#define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs) + 20))
+#define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs & 3) +  0))
+#define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs & 3) +  4))
+#define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs & 3) +  8))
+#define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs & 3) + 12))
+#define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs & 3) + 20))
 
 #define MX51_ECSPI_INT		0x10
 #define MX51_ECSPI_INT_TEEN		(1 <<  0)
-- 
2.39.2



