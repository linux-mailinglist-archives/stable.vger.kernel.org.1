Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7052378AA05
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjH1KSG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjH1KRt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:17:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5693010C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:17:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32D7163728
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D58AC433C8;
        Mon, 28 Aug 2023 10:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217858;
        bh=KDoaFPaehos2gUDRLbOSQnDqJL1BrHZ1++thCPkYlQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0zU+yhnngBIyHyQ4935P0J19ACZX9mAdbDYpSuTJqF8nGXKGsz23mQ526Q8Xz/TYY
         ZEgbFPbxYVUfAYqbHCyqTE+pXMNNc7wPUl0OsxlZUTxyw1NT1QqVPWWzjfolrVUVHg
         bmIg/GtzE7+1+n3sJQvRhIPOdwiSq24zgzNywpp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Justin Chen <justin.chen@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.14 40/57] net: phy: broadcom: stub c45 read/write for 54810
Date:   Mon, 28 Aug 2023 12:13:00 +0200
Message-ID: <20230828101145.730594925@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101144.231099710@linuxfoundation.org>
References: <20230828101144.231099710@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
[florian: resolved conflicts in 4.14]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/broadcom.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -403,6 +403,17 @@ static int bcm5482_read_status(struct ph
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
@@ -650,6 +661,8 @@ static struct phy_driver broadcom_driver
 	.name           = "Broadcom BCM54810",
 	.features       = PHY_GBIT_FEATURES,
 	.flags          = PHY_HAS_INTERRUPT,
+	.read_mmd	= bcm54810_read_mmd,
+	.write_mmd	= bcm54810_write_mmd,
 	.config_init    = bcm54xx_config_init,
 	.config_aneg    = bcm5481_config_aneg,
 	.read_status    = genphy_read_status,


