Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534B7726B4D
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjFGUYX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjFGUYC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1276F2D40
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E49EA60C3E
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D01C433D2;
        Wed,  7 Jun 2023 20:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169413;
        bh=y02JoVD6cs1NWLvV/cLT+yyHYfh7fbRxv49mm69/Y8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILvlCI5ZBHihiFwRL84+tCOBpbmDfXDMEh6tQMt36anqU8j3sxXhDBrUuVxyS+wd5
         VOV/K7q0Y6ZJi1eMUdWA4Ul8q3SI3uhOG+IqpcLKCVB2PTJ3ASC2+lSKm4bkIMPLqd
         UFWzIaD/862I5a7WvnWM/nAPczO+Nl9v3WSPaB1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sudheesh Mavila <sudheesh.mavila@amd.com>,
        Simon Horman <simon.horman@corigine.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Raju Rangoju <Raju.Rangoju@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 040/286] amd-xgbe: fix the false linkup in xgbe_phy_status
Date:   Wed,  7 Jun 2023 22:12:19 +0200
Message-ID: <20230607200924.339637989@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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

From: Raju Rangoju <Raju.Rangoju@amd.com>

[ Upstream commit dc362e20cd6ab7a93d1b09669730c406f0910c35 ]

In the event of a change in XGBE mode, the current auto-negotiation
needs to be reset and the AN cycle needs to be re-triggerred. However,
the current code ignores the return value of xgbe_set_mode(), leading to
false information as the link is declared without checking the status
register.

Fix this by propagating the mode switch status information to
xgbe_phy_status().

Fixes: e57f7a3feaef ("amd-xgbe: Prepare for working with more than one type of phy")
Co-developed-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Signed-off-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 33a9574e9e043..32d2c6fac6526 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1329,7 +1329,7 @@ static enum xgbe_mode xgbe_phy_status_aneg(struct xgbe_prv_data *pdata)
 	return pdata->phy_if.phy_impl.an_outcome(pdata);
 }
 
-static void xgbe_phy_status_result(struct xgbe_prv_data *pdata)
+static bool xgbe_phy_status_result(struct xgbe_prv_data *pdata)
 {
 	struct ethtool_link_ksettings *lks = &pdata->phy.lks;
 	enum xgbe_mode mode;
@@ -1367,8 +1367,13 @@ static void xgbe_phy_status_result(struct xgbe_prv_data *pdata)
 
 	pdata->phy.duplex = DUPLEX_FULL;
 
-	if (xgbe_set_mode(pdata, mode) && pdata->an_again)
+	if (!xgbe_set_mode(pdata, mode))
+		return false;
+
+	if (pdata->an_again)
 		xgbe_phy_reconfig_aneg(pdata);
+
+	return true;
 }
 
 static void xgbe_phy_status(struct xgbe_prv_data *pdata)
@@ -1398,7 +1403,8 @@ static void xgbe_phy_status(struct xgbe_prv_data *pdata)
 			return;
 		}
 
-		xgbe_phy_status_result(pdata);
+		if (xgbe_phy_status_result(pdata))
+			return;
 
 		if (test_bit(XGBE_LINK_INIT, &pdata->dev_state))
 			clear_bit(XGBE_LINK_INIT, &pdata->dev_state);
-- 
2.39.2



