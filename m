Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD92576AD11
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjHAJZ4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjHAJZn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:25:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F271FD2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:24:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4C87614F5
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CA8C433C7;
        Tue,  1 Aug 2023 09:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881866;
        bh=qHBpNdPQpqCi2dkrQ6DUQ2uNNX+cm7smrXbhRd5/UaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DxCaJvyx4QYWwMoo8/dYo5XMJvzASIV+8PbqiNCdUZRjVy+VmxiIp5UYFiOzxCNWT
         ohOpv3A5nYdzPnL057qSWhh+JaWhTuMiEnS7fv+aDB7PD2RJRFqicm+2XrgAXBiU0A
         2ZgXA7hl3OY4pa/3at3EBg3/EEh775b8fC9R3DuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiawen Wu <jiawenwu@trustnetic.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 058/155] net: phy: marvell10g: fix 88x3310 power up
Date:   Tue,  1 Aug 2023 11:19:30 +0200
Message-ID: <20230801091912.272899704@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiawen Wu <jiawenwu@trustnetic.com>

[ Upstream commit c7b75bea853daeb64fc831dbf39a6bbabcc402ac ]

Clear MV_V2_PORT_CTRL_PWRDOWN bit to set power up for 88x3310 PHY,
it sometimes does not take effect immediately. And a read of this
register causes the bit not to clear. This will cause mv3310_reset()
to time out, which will fail the config initialization. So add a delay
before the next access.

Fixes: c9cc1c815d36 ("net: phy: marvell10g: place in powersave mode at probe")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/marvell10g.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index df33637c5269a..1caa6d943a7b7 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -307,6 +307,13 @@ static int mv3310_power_up(struct phy_device *phydev)
 	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, MV_V2_PORT_CTRL,
 				 MV_V2_PORT_CTRL_PWRDOWN);
 
+	/* Sometimes, the power down bit doesn't clear immediately, and
+	 * a read of this register causes the bit not to clear. Delay
+	 * 100us to allow the PHY to come out of power down mode before
+	 * the next access.
+	 */
+	udelay(100);
+
 	if (phydev->drv->phy_id != MARVELL_PHY_ID_88X3310 ||
 	    priv->firmware_ver < 0x00030000)
 		return ret;
-- 
2.39.2



