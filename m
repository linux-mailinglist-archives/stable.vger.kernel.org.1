Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2736F78AC69
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjH1Kj4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjH1Kj0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:39:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC2910D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6386B63FDA
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77161C433CB;
        Mon, 28 Aug 2023 10:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219162;
        bh=PcdHo3YF7+nPjxazHlDVQomukqWQziHPBilrjiz+78I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p/kjLrXqODeqaukPPEA84mOhLVhG2hC/OGLd2p8FO/zPmzO02eOssk23N7hqFR6HL
         QYfEbvD6qJPoJZVmSm8vIJcfBg6zLWhSZ/K1I/42ML7OtTfjGhEYbkBIYMEYy9xaKV
         UqSNBzIIqzeP8+CHl37r7l6LDxHMQ14aw7jjCFZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Justin Chen <justin.chen@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 094/158] net: phy: broadcom: stub c45 read/write for 54810
Date:   Mon, 28 Aug 2023 12:13:11 +0200
Message-ID: <20230828101200.467830899@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Chen <justin.chen@broadcom.com>

commit 096516d092d54604d590827d05b1022c8f326639 upstream.

The 54810 does not support c45. The mmd_phy_indirect accesses return
arbirtary values leading to odd behavior like saying it supports EEE
when it doesn't. We also see that reading/writing these non-existent
MMD registers leads to phy instability in some cases.

Fixes: b14995ac2527 ("net: phy: broadcom: Add BCM54810 PHY entry")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/1691901708-28650-1-git-send-email-justin.chen@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[florian: resolved conflicts in 5.4]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/broadcom.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -425,6 +425,17 @@ static int bcm5482_read_status(struct ph
 	return err;
 }
 
+static int bcm54810_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
+{
+	return -EOPNOTSUPP;
+}
+
+static int bcm54810_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
+			      u16 val)
+{
+	return -EOPNOTSUPP;
+}
+
 static int bcm5481_config_aneg(struct phy_device *phydev)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
@@ -696,6 +707,8 @@ static struct phy_driver broadcom_driver
 	.phy_id_mask    = 0xfffffff0,
 	.name           = "Broadcom BCM54810",
 	/* PHY_GBIT_FEATURES */
+	.read_mmd	= bcm54810_read_mmd,
+	.write_mmd	= bcm54810_write_mmd,
 	.config_init    = bcm54xx_config_init,
 	.config_aneg    = bcm5481_config_aneg,
 	.ack_interrupt  = bcm_phy_ack_intr,


