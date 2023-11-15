Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659947ED68C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjKOWCL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbjKOWCK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:02:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF1E193
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:02:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2119DC433CA;
        Wed, 15 Nov 2023 22:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085727;
        bh=2cB0ZkEMWSijQqqI9BC90PWsyPwC3nfO6COHgYoQJVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNgKN9krEhrk93zw4GwFRjq+Z+FFeMpPyVKGIgiTN3a1fl8Mo6cUoLQ1vGPCQyAzo
         +q0JPk8MyTbzfXFlyQBqtBYj+pMVV07uIYi209GMUi0W7hN94V+7adM59m/4TBHilo
         wDJtulJocfRiXp3PIjPwOYxy58gxkqIpPBDSI5as=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Juhee Kang <claudiajkang@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 014/119] r8169: use tp_to_dev instead of open code
Date:   Wed, 15 Nov 2023 17:00:04 -0500
Message-ID: <20231115220133.050554502@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juhee Kang <claudiajkang@gmail.com>

[ Upstream commit 4b6c6065fca123d419afef005a696f51e6590470 ]

The open code is defined as a helper function(tp_to_dev) on r8169_main.c,
which the open code is &tp->pci_dev->dev. The helper function was added
in commit 1e1205b7d3e9 ("r8169: add helper tp_to_dev"). And then later,
commit f1e911d5d0df ("r8169: add basic phylib support") added
r8169_phylink_handler function but it didn't use the helper function.
Thus, tp_to_dev() replaces the open code. This patch doesn't change logic.

Signed-off-by: Juhee Kang <claudiajkang@gmail.com>
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/20221129161244.5356-1-claudiajkang@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 621735f59064 ("r8169: fix rare issue with broken rx after link-down on RTL8125")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index fca2dbdd37aff..9676d599b5ba0 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6293,12 +6293,13 @@ static void rtl8169_rx_missed(struct net_device *dev)
 static void r8169_phylink_handler(struct net_device *ndev)
 {
 	struct rtl8169_private *tp = netdev_priv(ndev);
+	struct device *d = tp_to_dev(tp);
 
 	if (netif_carrier_ok(ndev)) {
 		rtl_link_chg_patch(tp);
-		pm_request_resume(&tp->pci_dev->dev);
+		pm_request_resume(d);
 	} else {
-		pm_runtime_idle(&tp->pci_dev->dev);
+		pm_runtime_idle(d);
 	}
 
 	if (net_ratelimit())
-- 
2.42.0



