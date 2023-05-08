Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA146FAE37
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbjEHLmi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbjEHLmX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:42:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206C4411A4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:41:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE6C963593
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0544CC433EF;
        Mon,  8 May 2023 11:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546100;
        bh=4EJDyu8LfVkNwGe+5qrF8t6ALOw4vfB1sr6a92KXtzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Czdx2pEkvYv0GYrYAd3RpYfpvyUMciUVOc/GPNx/zFflTCUNe3EnHe5wJuAeDzHjs
         I1mcKmnJffxim2EnqrONXmAXRIO6KC6UHu3UTOqpSVq3e796p0y5qWtv+Zcc3ZIScp
         AhDvbwKPyw0LEfXu9W3DmztzW0g+x/dleNR/S4e4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jacob Keller <jacob.e.keller@intel.com>,
        Yan Wang <rk.code@outlook.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 227/371] net: stmmac:fix system hang when setting up tag_8021q VLAN for DSA ports
Date:   Mon,  8 May 2023 11:47:08 +0200
Message-Id: <20230508094821.079693764@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Yan Wang <rk.code@outlook.com>

[ Upstream commit 35226750f7ab9d49140d95bc7d38a2a9b0f4fdfc ]

The system hang because of dsa_tag_8021q_port_setup()->
				stmmac_vlan_rx_add_vid().

I found in stmmac_drv_probe() that cailing pm_runtime_put()
disabled the clock.

First, when the kernel is compiled with CONFIG_PM=y,The stmmac's
resume/suspend is active.

Secondly,stmmac as DSA master,the dsa_tag_8021q_port_setup() function
will callback stmmac_vlan_rx_add_vid when DSA dirver starts. However,
The system is hanged for the stmmac_vlan_rx_add_vid() accesses its
registers after stmmac's clock is closed.

I would suggest adding the pm_runtime_resume_and_get() to the
stmmac_vlan_rx_add_vid().This guarantees that resuming clock output
while in use.

Fixes: b3dcb3127786 ("net: stmmac: correct clocks enabled in stmmac_vlan_rx_kill_vid()")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Yan Wang <rk.code@outlook.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a3bd5396c2f87..179f8d196c890 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6283,6 +6283,10 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 	bool is_double = false;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(priv->device);
+	if (ret < 0)
+		return ret;
+
 	if (be16_to_cpu(proto) == ETH_P_8021AD)
 		is_double = true;
 
@@ -6290,16 +6294,18 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 	ret = stmmac_vlan_update(priv, is_double);
 	if (ret) {
 		clear_bit(vid, priv->active_vlans);
-		return ret;
+		goto err_pm_put;
 	}
 
 	if (priv->hw->num_vlan) {
 		ret = stmmac_add_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 	}
+err_pm_put:
+	pm_runtime_put(priv->device);
 
-	return 0;
+	return ret;
 }
 
 static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vid)
-- 
2.39.2



