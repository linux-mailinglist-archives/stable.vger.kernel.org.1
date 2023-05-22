Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EAD70C77C
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjEVTaG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjEVTaF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:30:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB93119
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58C6D628F9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD72C433EF;
        Mon, 22 May 2023 19:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783802;
        bh=m7zSPEB8Nn9SEiXHT57EIv8Xs/xoJzspGFAhmfYy8Yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CPddO6I9RA/eD653BOgMTq7UbC5d8qsfjE6U0EVe41LBvcGZ9qp9EsmMVIoqdC3xs
         wNAOmvo7tEJYWISG9YZBJ8mAKqRKqFKX2W5PQ4Rg0jPyujIEdDtVvfgPrUJ/0gbDnV
         SnKgw0saqmXp7vElgCcM1v4fdO7iPvM0i/tkjJZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 167/292] net: phy: dp83867: add w/a for packet errors seen with short cables
Date:   Mon, 22 May 2023 20:08:44 +0100
Message-Id: <20230522190410.140213772@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit 0b01db274028f5acd207332686ffc92ac77491ac ]

Introduce the W/A for packet errors seen with short cables (<1m) between
two DP83867 PHYs.

The W/A recommended by DM requires FFE Equalizer Configuration tuning by
writing value 0x0E81 to DSP_FFE_CFG register (0x012C), surrounded by hard
and soft resets as follows:

write_reg(0x001F, 0x8000); //hard reset
write_reg(DSP_FFE_CFG, 0x0E81);
write_reg(0x001F, 0x4000); //soft reset

Since  DP83867 PHY DM says "Changing this register to 0x0E81, will not
affect Long Cable performance.", enable the W/A by default.

Fixes: 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83867.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 7446d5c6c7146..14990f8462ae3 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -42,6 +42,7 @@
 #define DP83867_STRAP_STS1	0x006E
 #define DP83867_STRAP_STS2	0x006f
 #define DP83867_RGMIIDCTL	0x0086
+#define DP83867_DSP_FFE_CFG	0x012c
 #define DP83867_RXFCFG		0x0134
 #define DP83867_RXFPMD1	0x0136
 #define DP83867_RXFPMD2	0x0137
@@ -910,8 +911,27 @@ static int dp83867_phy_reset(struct phy_device *phydev)
 
 	usleep_range(10, 20);
 
-	return phy_modify(phydev, MII_DP83867_PHYCTRL,
+	err = phy_modify(phydev, MII_DP83867_PHYCTRL,
 			 DP83867_PHYCR_FORCE_LINK_GOOD, 0);
+	if (err < 0)
+		return err;
+
+	/* Configure the DSP Feedforward Equalizer Configuration register to
+	 * improve short cable (< 1 meter) performance. This will not affect
+	 * long cable performance.
+	 */
+	err = phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_DSP_FFE_CFG,
+			    0x0e81);
+	if (err < 0)
+		return err;
+
+	err = phy_write(phydev, DP83867_CTRL, DP83867_SW_RESTART);
+	if (err < 0)
+		return err;
+
+	usleep_range(10, 20);
+
+	return 0;
 }
 
 static void dp83867_link_change_notify(struct phy_device *phydev)
-- 
2.39.2



