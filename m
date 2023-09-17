Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E312E7A382D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjIQTcq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbjIQTcP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:32:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAF9CD6
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:31:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD851C433CA;
        Sun, 17 Sep 2023 19:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979109;
        bh=vjGAaPlODyblqKv7O6BAoBVTNOFavrad1Urj/sZDz7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YB2I6ZpNdREaQZawosT2F/yzgMbV+1EGLFp0I7E10AhRp/xqn4/2OFH81u5xTDpkV
         E4XsKrWx+dS12MRU/mAyp/Qbj2kHjNmGQxZKjiY1e03pXL1UTXKgRux5xC+PMtm2Ch
         os0yIMzV42IEJjJ1P1W/jRcbOrR20qfe9JUJETiY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xu Yang <xu.yang_2@nxp.com>,
        Peter Chen <peter.chen@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 216/406] usb: phy: mxs: fix getting wrong state with mxs_phy_is_otg_host()
Date:   Sun, 17 Sep 2023 21:11:10 +0200
Message-ID: <20230917191106.888334981@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 5eda42aebb7668b4dcff025cd3ccb0d3d7c53da6 ]

The function mxs_phy_is_otg_host() will return true if OTG_ID_VALUE is
0 at USBPHY_CTRL register. However, OTG_ID_VALUE will not reflect the real
state if the ID pin is float, such as Host-only or Type-C cases. The value
of OTG_ID_VALUE is always 1 which means device mode.
This patch will fix the issue by judging the current mode based on
last_event. The controller will update last_event in time.

Fixes: 7b09e67639d6 ("usb: phy: mxs: refine mxs_phy_disconnect_line")
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20230627110353.1879477-2-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/phy/phy-mxs-usb.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 67b39dc62b373..70e23334b27f9 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -388,14 +388,8 @@ static void __mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool disconnect)
 
 static bool mxs_phy_is_otg_host(struct mxs_phy *mxs_phy)
 {
-	void __iomem *base = mxs_phy->phy.io_priv;
-	u32 phyctrl = readl(base + HW_USBPHY_CTRL);
-
-	if (IS_ENABLED(CONFIG_USB_OTG) &&
-			!(phyctrl & BM_USBPHY_CTRL_OTG_ID_VALUE))
-		return true;
-
-	return false;
+	return IS_ENABLED(CONFIG_USB_OTG) &&
+		mxs_phy->phy.last_event == USB_EVENT_ID;
 }
 
 static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
-- 
2.40.1



