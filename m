Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FEE7A7FAC
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbjITM3Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjITM3X (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:29:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1313AAD
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:29:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574B6C433C9;
        Wed, 20 Sep 2023 12:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212956;
        bh=O5dZADeKv3e6Tpy/5ua1Asnk07NoBz8V5I7zxj7ASGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JM5Tfm9WqI8vEPLYzclSh0hKM/g0Fu3TQDZzahfKqXxqnR8HlUNWbdgUCKmRY1esE
         EyZkcw0nC2jLwQzwAuk+2KvTpPLvcjm7fPg6cyoT6oIw5QLf2meLIMAJKx7GVGOyEp
         8aACz1X8f6hN8hUlFG25PY3OKHm8IqdRIs9Vy71g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 108/367] ARM: dts: BCM53573: Fix Ethernet info for Luxul devices
Date:   Wed, 20 Sep 2023 13:28:05 +0200
Message-ID: <20230920112901.387921535@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 44ad8207806973f4e4f7d870fff36cc01f494250 ]

Both Luxul's XAP devices (XAP-810 and XAP-1440) are access points that
use a non-default design. They don't include switch but have a single
Ethernet port and BCM54210E PHY connected to the Ethernet controller's
MDIO bus.

Support for those devices regressed due to two changes:

1. Describing MDIO bus with switch
After commit 9fb90ae6cae7 ("ARM: dts: BCM53573: Describe on-SoC BCM53125
rev 4 switch") Linux stopped probing for MDIO devices.

2. Dropping hardcoded BCM54210E delays
In commit fea7fda7f50a ("net: phy: broadcom: Fix RGMII delays
configuration for BCM54210E") support for other PHY modes was added but
that requires a proper "phy-mode" value in DT.

Both above changes are correct (they don't need to be reverted or
anything) but they need this fix for DT data to be correct and for Linux
to work properly.

Fixes: 9fb90ae6cae7 ("ARM: dts: BCM53573: Describe on-SoC BCM53125 rev 4 switch")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/r/20230713111145.14864-1-zajec5@gmail.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts | 13 +++++++++++++
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts  | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
index 02957850c88a8..5901160919dcd 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
@@ -45,3 +45,16 @@ restart {
 		};
 	};
 };
+
+&gmac0 {
+	phy-mode = "rgmii";
+	phy-handle = <&bcm54210e>;
+
+	mdio {
+		/delete-node/ switch@1e;
+
+		bcm54210e: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
index d68e9dbebf26b..8e7483272d47d 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
@@ -81,3 +81,16 @@ pcie0_chipcommon: chipcommon@0 {
 		};
 	};
 };
+
+&gmac0 {
+	phy-mode = "rgmii";
+	phy-handle = <&bcm54210e>;
+
+	mdio {
+		/delete-node/ switch@1e;
+
+		bcm54210e: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
-- 
2.40.1



