Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B796E7611EA
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjGYK5Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjGYK5A (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7EA4220
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:54:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02FD2615FE
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A1AC433C8;
        Tue, 25 Jul 2023 10:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282471;
        bh=1Q67qdk12FBuGwaaE5LJWkl7u8MfdyCJqcQiR0n6UsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TJJk+V4KPVTPcC9se5Fc1E4po/+Z+5ZHzVTvcpQiB415wvClsXJkdVBOI+O3Jsgi6
         Nk+X0ZfFgZkCFMXdXhpNSPkyHDTeRYK5qMG/sOD/fSwuTMOJwyRbyV6m+uNqhEOobQ
         FsP9ld5U14pvyS5FND89EglgrzjY17wCCsF6WFzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 142/227] pinctrl: renesas: rzg2l: Handle non-unique subnode names
Date:   Tue, 25 Jul 2023 12:45:09 +0200
Message-ID: <20230725104520.757354299@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit bfc374a145ae133613e05b9b89be561f169cb58d ]

Currently, sd1 and sd0 have unique subnode names 'sd1_mux' and 'sd0_mux'.
If we change these to non-unique subnode names such as 'mux' this can
lead to the below conflict as the RZ/G2L pin control driver considers
only the names of the subnodes.

   pinctrl-rzg2l 11030000.pinctrl: pin P47_0 already requested by 11c00000.mmc; cannot claim for 11c10000.mmc
   pinctrl-rzg2l 11030000.pinctrl: pin-376 (11c10000.mmc) status -22
   pinctrl-rzg2l 11030000.pinctrl: could not request pin 376 (P47_0) from group mux  on device pinctrl-rzg2l
   renesas_sdhi_internal_dmac 11c10000.mmc: Error applying setting, reverse things back

Fix this by constructing unique names from the node names of both the
pin control configuration node and its child node, where appropriate.

Based on the work done by Geert for the RZ/V2M pinctrl driver.

Fixes: c4c4637eb57f ("pinctrl: renesas: Add RZ/G2L pin and gpio controller driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230704111858.215278-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 28 ++++++++++++++++++-------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 9511d920565e9..b53d26167da52 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -249,6 +249,7 @@ static int rzg2l_map_add_config(struct pinctrl_map *map,
 
 static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 				   struct device_node *np,
+				   struct device_node *parent,
 				   struct pinctrl_map **map,
 				   unsigned int *num_maps,
 				   unsigned int *index)
@@ -266,6 +267,7 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	struct property *prop;
 	int ret, gsel, fsel;
 	const char **pin_fn;
+	const char *name;
 	const char *pin;
 
 	pinmux = of_find_property(np, "pinmux", NULL);
@@ -349,8 +351,19 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		psel_val[i] = MUX_FUNC(value);
 	}
 
+	if (parent) {
+		name = devm_kasprintf(pctrl->dev, GFP_KERNEL, "%pOFn.%pOFn",
+				      parent, np);
+		if (!name) {
+			ret = -ENOMEM;
+			goto done;
+		}
+	} else {
+		name = np->name;
+	}
+
 	/* Register a single pin group listing all the pins we read from DT */
-	gsel = pinctrl_generic_add_group(pctldev, np->name, pins, num_pinmux, NULL);
+	gsel = pinctrl_generic_add_group(pctldev, name, pins, num_pinmux, NULL);
 	if (gsel < 0) {
 		ret = gsel;
 		goto done;
@@ -360,17 +373,16 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	 * Register a single group function where the 'data' is an array PSEL
 	 * register values read from DT.
 	 */
-	pin_fn[0] = np->name;
-	fsel = pinmux_generic_add_function(pctldev, np->name, pin_fn, 1,
-					   psel_val);
+	pin_fn[0] = name;
+	fsel = pinmux_generic_add_function(pctldev, name, pin_fn, 1, psel_val);
 	if (fsel < 0) {
 		ret = fsel;
 		goto remove_group;
 	}
 
 	maps[idx].type = PIN_MAP_TYPE_MUX_GROUP;
-	maps[idx].data.mux.group = np->name;
-	maps[idx].data.mux.function = np->name;
+	maps[idx].data.mux.group = name;
+	maps[idx].data.mux.function = name;
 	idx++;
 
 	dev_dbg(pctrl->dev, "Parsed %pOF with %d pins\n", np, num_pinmux);
@@ -417,7 +429,7 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 	index = 0;
 
 	for_each_child_of_node(np, child) {
-		ret = rzg2l_dt_subnode_to_map(pctldev, child, map,
+		ret = rzg2l_dt_subnode_to_map(pctldev, child, np, map,
 					      num_maps, &index);
 		if (ret < 0) {
 			of_node_put(child);
@@ -426,7 +438,7 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 	}
 
 	if (*num_maps == 0) {
-		ret = rzg2l_dt_subnode_to_map(pctldev, np, map,
+		ret = rzg2l_dt_subnode_to_map(pctldev, np, NULL, map,
 					      num_maps, &index);
 		if (ret < 0)
 			goto done;
-- 
2.39.2



