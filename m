Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB77CA2F6
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjJPI7Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjJPI7Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:59:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F64DE
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:59:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3FBC433C7;
        Mon, 16 Oct 2023 08:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446762;
        bh=ZKR1oKDze5kThOWCEPUc9BzKeekYKRQhZDJatRpNS5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkcIlF1h7F2P0kfM4c06S+rDbcI2umTvtuLtvmBDrts28I4Lf0/tlOQZh72nEP3bc
         u2PakNkKarq0NlD3h5SdMrI9V/82U8+VB3L4gArVDRtg1FVMquFJDkFLsUeE6Cu1x0
         Uz6nBThQgNr8bvz+KpY8GysoDIB0YbbCPVT52yFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 040/131] phy: lynx-28g: lock PHY while performing CDR lock workaround
Date:   Mon, 16 Oct 2023 10:40:23 +0200
Message-ID: <20231016084001.069198605@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
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

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 0ac87fe54a171d18c5fb5345e3ee8d14e1b06f4b ]

lynx_28g_cdr_lock_check() runs once per second in a workqueue to reset
the lane receiver if the CDR has not locked onto bit transitions in the
RX stream. But the PHY consumer may do stuff with the PHY simultaneously,
and that isn't okay. Block concurrent generic PHY calls by holding the
PHY mutex from this workqueue.

Fixes: 8f73b37cf3fb ("phy: add support for the Layerscape SerDes 28G")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 9d55dbee2e0a5..d49aa59c7d812 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -507,11 +507,12 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
 		lane = &priv->lane[i];
 
-		if (!lane->init)
-			continue;
+		mutex_lock(&lane->phy->mutex);
 
-		if (!lane->powered_up)
+		if (!lane->init || !lane->powered_up) {
+			mutex_unlock(&lane->phy->mutex);
 			continue;
+		}
 
 		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
 		if (!(rrstctl & LYNX_28G_LNaRRSTCTL_CDR_LOCK)) {
@@ -520,6 +521,8 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 				rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
 			} while (!(rrstctl & LYNX_28G_LNaRRSTCTL_RST_DONE));
 		}
+
+		mutex_unlock(&lane->phy->mutex);
 	}
 	queue_delayed_work(system_power_efficient_wq, &priv->cdr_check,
 			   msecs_to_jiffies(1000));
-- 
2.40.1



