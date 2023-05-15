Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602D1703400
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbjEOQnn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242466AbjEOQnk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:43:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB85446B0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:43:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BE3C6280E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E3DC433D2;
        Mon, 15 May 2023 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169015;
        bh=qonoS5KuDxf1VuDrNx8O3V5Q9HdjLNeq40HFhFAjnXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xbNtOC4RS+A9NF6jJUBDxsY2aL6w9P8sijk4Cn5CGTUNkHZEo5MJewGpQ6eI33v8N
         s8YTD2b6Vgqgn3H5QnttEyWrtd4+sJ3OPgmOjMLF4jngPHaI0IhKgB7VijiiNEs81w
         ArhTslInqKsP4LWnl+0piuIRQ6FmHEF1i8YK38K8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 114/191] clk: add missing of_node_put() in "assigned-clocks" property parsing
Date:   Mon, 15 May 2023 18:25:51 +0200
Message-Id: <20230515161711.399915015@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Clément Léger <clement.leger@bootlin.com>

[ Upstream commit 27a6e1b09a782517fddac91259970ac466a3f7b6 ]

When returning from of_parse_phandle_with_args(), the np member of the
of_phandle_args structure should be put after usage. Add missing
of_node_put() calls in both __set_clk_parents() and __set_clk_rates().

Fixes: 86be408bfbd8 ("clk: Support for clock parents and rates assigned from device tree")
Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Link: https://lore.kernel.org/r/20230131083227.10990-1-clement.leger@bootlin.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-conf.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 49819b546134b..5c6760e45a16e 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -36,9 +36,12 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 			else
 				return rc;
 		}
-		if (clkspec.np == node && !clk_supplier)
+		if (clkspec.np == node && !clk_supplier) {
+			of_node_put(clkspec.np);
 			return 0;
+		}
 		pclk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
 		if (IS_ERR(pclk)) {
 			if (PTR_ERR(pclk) != -EPROBE_DEFER)
 				pr_warn("clk: couldn't get parent clock %d for %pOF\n",
@@ -51,10 +54,12 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 		if (rc < 0)
 			goto err;
 		if (clkspec.np == node && !clk_supplier) {
+			of_node_put(clkspec.np);
 			rc = 0;
 			goto err;
 		}
 		clk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
 		if (IS_ERR(clk)) {
 			if (PTR_ERR(clk) != -EPROBE_DEFER)
 				pr_warn("clk: couldn't get assigned clock %d for %pOF\n",
@@ -96,10 +101,13 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 				else
 					return rc;
 			}
-			if (clkspec.np == node && !clk_supplier)
+			if (clkspec.np == node && !clk_supplier) {
+				of_node_put(clkspec.np);
 				return 0;
+			}
 
 			clk = of_clk_get_from_provider(&clkspec);
+			of_node_put(clkspec.np);
 			if (IS_ERR(clk)) {
 				if (PTR_ERR(clk) != -EPROBE_DEFER)
 					pr_warn("clk: couldn't get clock %d for %pOF\n",
-- 
2.39.2



