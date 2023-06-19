Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890987353CE
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjFSKs7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjFSKsq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:48:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAB91707
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:48:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ED9260B4B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827E3C433C8;
        Mon, 19 Jun 2023 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171715;
        bh=M06j8HG/E5y0kcU+swcjO1/P+HJqiElYs8svk535/b8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sbm348kvA1J65IgqRnEXozucz/N71IJF5jnKJcXA0awiXVf96AvKTYa3xh5b7ptr4
         SIfGHbAm38DkPQasgTxVhilw4wPywGSRefoYukoTds4XG3XoEMtbvxFe0twQdPF5u3
         cMhCs88ZIJ1davFTN46gTNLud0OQuZqRrlb0DSAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 130/166] net: phylink: report correct max speed for QUSGMII
Date:   Mon, 19 Jun 2023 12:30:07 +0200
Message-ID: <20230619102201.099875168@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

[ Upstream commit b9dc1046edfeb7d9dbc2272c8d9ad5a8c47f3199 ]

Q-USGMII is the quad port version of USGMII, and supports a max speed of
1Gbps on each line. Make so that phylink_interface_max_speed() reports
this information correctly.

Fixes: ae0e4bb2a0e0 ("net: phylink: Adjust link settings based on rate matching")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phylink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 4073e8243df3f..acd3405ddc9c6 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -188,6 +188,7 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_QUSGMII:
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_GMII:
 		return SPEED_1000;
@@ -204,7 +205,6 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_10GBASER:
 	case PHY_INTERFACE_MODE_10GKR:
 	case PHY_INTERFACE_MODE_USXGMII:
-	case PHY_INTERFACE_MODE_QUSGMII:
 		return SPEED_10000;
 
 	case PHY_INTERFACE_MODE_25GBASER:
-- 
2.39.2



