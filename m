Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8637ECE35
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbjKOTle (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjKOTld (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:41:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F86CE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:41:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A743C433C7;
        Wed, 15 Nov 2023 19:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077290;
        bh=nbcBkzwfZTJQcQv5o4Sqg6H6NaSU3NEF7ltTWCuTt4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WcrywimpXNiO/kg2yd3AEPvC4cPcfscBakLD57TYIPiOZUDUYnlE0mrpC7udNZQxP
         wWnFgmeQIgtoh6RCpsdguEOCfbmaEO8OFjqvEHlGt0tMjuuDGIr90TpYN9O7YTrYyd
         h0+oCvj+JCALFyL/uwrSigGoojEAJj57sepuJbtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 182/603] clk: ralink: mtmips: quiet unused variable warning
Date:   Wed, 15 Nov 2023 14:12:07 -0500
Message-ID: <20231115191625.833159278@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergio Paracuellos <sergio.paracuellos@gmail.com>

[ Upstream commit 619102313466eaf8a6ac188e711f5df749dac6d4 ]

When CONFIG_OF is disabled then the matching table is not referenced and
the following warning appears:

drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmips_of_match' [-Wunused-const-variable]
821 |   static const struct of_device_id mtmips_of_match[] = {
    |                          ^

There are two match tables in the driver: one for the clock driver and the
other for the reset driver. The only difference between them is that the
clock driver uses 'data' and does not have 'ralink,rt2880-reset' compatible.
Both just can be merged into a single one just by adding the compatible
'ralink,rt2880-reset' entry to 'mtmips_of_match[]', which will allow it to
be used for 'mtmips_clk_driver' (which doesn't use the data) as well as for
'mtmips_clk_init()' (which doesn't need get called for 'ralink,rt2880-reset').

Doing in this way ensures that 'CONFIG_OF' is not disabled anymore so the
above warning disapears.

Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIPS SoCs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307242310.CdOnd2py-lkp@intel.com/
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Link: https://lore.kernel.org/r/20230827023932.501102-1-sergio.paracuellos@gmail.com
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ralink/clk-mtmips.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtmips.c
index 1e7991439527a..50a443bf79ecd 100644
--- a/drivers/clk/ralink/clk-mtmips.c
+++ b/drivers/clk/ralink/clk-mtmips.c
@@ -821,6 +821,10 @@ static const struct mtmips_clk_data mt76x8_clk_data = {
 };
 
 static const struct of_device_id mtmips_of_match[] = {
+	{
+		.compatible = "ralink,rt2880-reset",
+		.data = NULL,
+	},
 	{
 		.compatible = "ralink,rt2880-sysc",
 		.data = &rt2880_clk_data,
@@ -1088,25 +1092,11 @@ static int mtmips_clk_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mtmips_clk_of_match[] = {
-	{ .compatible = "ralink,rt2880-reset" },
-	{ .compatible = "ralink,rt2880-sysc" },
-	{ .compatible = "ralink,rt3050-sysc" },
-	{ .compatible = "ralink,rt3052-sysc" },
-	{ .compatible = "ralink,rt3352-sysc" },
-	{ .compatible = "ralink,rt3883-sysc" },
-	{ .compatible = "ralink,rt5350-sysc" },
-	{ .compatible = "ralink,mt7620-sysc" },
-	{ .compatible = "ralink,mt7628-sysc" },
-	{ .compatible = "ralink,mt7688-sysc" },
-	{}
-};
-
 static struct platform_driver mtmips_clk_driver = {
 	.probe = mtmips_clk_probe,
 	.driver = {
 		.name = "mtmips-clk",
-		.of_match_table = mtmips_clk_of_match,
+		.of_match_table = mtmips_of_match,
 	},
 };
 
-- 
2.42.0



