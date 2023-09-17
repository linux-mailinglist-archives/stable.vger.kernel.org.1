Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D17A37FA
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbjIQT3f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239602AbjIQT3O (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:29:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DAE11F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:29:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F53FC433C7;
        Sun, 17 Sep 2023 19:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978947;
        bh=gB3aweqeCD/Z5u0E3oYwPpoWNVpLKYcGvctZ9VNNXqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DhwIzPvUT/sHdJyiGMyNlOW0Wzi343Bpu7Ck97gJ9pgoOnRke74HYsZQH9wzSiJdC
         oyxMHKB0onEDXXjVUJqECgwDAMgdkw3JCCWe8CSzuW9/MBl5tR0L+on75tnjpyzFU5
         irezAWJzH2OW9GiDebWM+nEXH9pHtw9C9lumnHPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 145/406] ARM: dts: BCM53573: Fix Ethernet info for Luxul devices
Date:   Sun, 17 Sep 2023 21:09:59 +0200
Message-ID: <20230917191104.990164530@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 57ca1cfaecd8e..00e688b45d981 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
@@ -46,3 +46,16 @@ restart {
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
index 2e1a7e382cb7a..78c80a5d3f4fa 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
@@ -83,3 +83,16 @@ pcie0_chipcommon: chipcommon@0 {
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



