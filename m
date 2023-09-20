Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2077A7DC2
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbjITMMC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbjITMMB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:12:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD8DE5
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:11:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDFAC433C8;
        Wed, 20 Sep 2023 12:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211915;
        bh=v0MgJdzaDFZ1dOgBOl7dJYpzpRxkGmuuMwEhf4Xy5lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvHbkTrrmCsdc8y2r/v52r9hojaFRM7s3dIkxkVuG2ayMNw0yrVt3+WnbBM9xaS/g
         n0O1j1V3zuw0d/chjjAroyOPQNTA8mzbqBArCmwQ2EbKQFebS+mk5SsnaW5yj4td8Y
         oEdIqULRfZMxv6yDTn0jrcoHrfzj6FgybEPRndMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 082/273] ARM: dts: BCM53573: Describe on-SoC BCM53125 rev 4 switch
Date:   Wed, 20 Sep 2023 13:28:42 +0200
Message-ID: <20230920112848.983594467@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 9fb90ae6cae7f8fe4fbf626945f32cd9da2c3892 ]

BCM53573 family SoC have Ethernet switch connected to the first Ethernet
controller (accessible over MDIO).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Stable-dep-of: 05d2c3d552b8 ("ARM: dts: BCM53573: Drop nonexistent #usb-cells")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm53573.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index d38f103db8a64..5aef9fd651049 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -180,6 +180,24 @@ ohci_port2: port@2 {
 
 		gmac0: ethernet@5000 {
 			reg = <0x5000 0x1000>;
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				switch: switch@1e {
+					compatible = "brcm,bcm53125";
+					reg = <0x1e>;
+
+					status = "disabled";
+
+					/* ports are defined in board DTS */
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
+				};
+			};
 		};
 
 		gmac1: ethernet@b000 {
-- 
2.40.1



