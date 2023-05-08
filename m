Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547A76FA94D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjEHKtw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjEHKtX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:49:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D9E2715
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A370862836
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6582C433D2;
        Mon,  8 May 2023 10:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542924;
        bh=/Jl9Jaavl05gJsehmzRCKJ6D3quk8GZDfuxJ44umj78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Rsyl5OLTIkjrXblhqqwOwDH5jVBS1pMS3A3CYi0O3ZvEQpqK6v2r8Odx8KAXPoW0
         NNiXvP5F/JS89SeZ94/U/sJgeK3+m29gu5qCVv2Nbv6+TI76o5jbhw2DsSitWAVJ7J
         +ONCQUeoCXQbztF0wcJGPnQgUG5M5mx6B/vLFFyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Siddharth Vadapalli <s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 591/663] phy: ti: j721e-wiz: Fix unreachable code in wiz_mode_select()
Date:   Mon,  8 May 2023 11:46:57 +0200
Message-Id: <20230508094448.620258094@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Siddharth Vadapalli <s-vadapalli@ti.com>

[ Upstream commit 57c0e1362fdd57d0cea7ab1e583b58abf4bd8c2d ]

In the wiz_mode_select() function, the configuration performed for
PHY_TYPE_USXGMII is unreachable. Fix it.

Fixes: b64a85fb8f53 ("phy: ti: phy-j721e-wiz.c: Add usxgmii support in wiz driver")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Link: https://lore.kernel.org/r/20230403094552.929108-1-s-vadapalli@ti.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/ti/phy-j721e-wiz.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index ddce5ef7711c6..c21b193fb5498 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -430,18 +430,17 @@ static int wiz_mode_select(struct wiz *wiz)
 	int i;
 
 	for (i = 0; i < num_lanes; i++) {
-		if (wiz->lane_phy_type[i] == PHY_TYPE_DP)
+		if (wiz->lane_phy_type[i] == PHY_TYPE_DP) {
 			mode = LANE_MODE_GEN1;
-		else if (wiz->lane_phy_type[i] == PHY_TYPE_QSGMII)
+		} else if (wiz->lane_phy_type[i] == PHY_TYPE_QSGMII) {
 			mode = LANE_MODE_GEN2;
-		else
-			continue;
-
-		if (wiz->lane_phy_type[i] == PHY_TYPE_USXGMII) {
+		} else if (wiz->lane_phy_type[i] == PHY_TYPE_USXGMII) {
 			ret = regmap_field_write(wiz->p0_mac_src_sel[i], 0x3);
 			ret = regmap_field_write(wiz->p0_rxfclk_sel[i], 0x3);
 			ret = regmap_field_write(wiz->p0_refclk_sel[i], 0x3);
 			mode = LANE_MODE_GEN1;
+		} else {
+			continue;
 		}
 
 		ret = regmap_field_write(wiz->p_standard_mode[i], mode);
-- 
2.39.2



