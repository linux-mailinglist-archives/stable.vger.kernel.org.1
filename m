Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3436A79B35B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbjIKUy6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241773AbjIKPOL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:14:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB26FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:14:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C0CC433C8;
        Mon, 11 Sep 2023 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445246;
        bh=QS2UsylL1mk0Rw6e95Ga7VkCP1XdaxMvF6hbOHjRmI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwYB0DtDEEXvv9mUX3AO9BAJCQaNn2rtYk6d/tbVQ+V0rYJigjMFqDdq/vxQdOAwW
         XqgXHLzVJouC2SoUm8qIcJXQ3+p7shcdgvS6b1XUDjJVrUxmtC/bH/ZBZN3UdFxHdG
         wm9Zb2KgDj9r98Znb9cwgOJDU5R3ETBTHenWm9Oo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 252/600] ARM: dts: BCM53573: Add cells sizes to PCIe node
Date:   Mon, 11 Sep 2023 15:44:45 +0200
Message-ID: <20230911134641.041443328@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 3392ef368d9b04622fe758b1079b512664b6110a ]

This fixes:
arch/arm/boot/dts/broadcom/bcm47189-luxul-xap-1440.dtb: pcie@2000: '#address-cells' is a required property
        From schema: /lib/python3.10/site-packages/dtschema/schemas/pci/pci-bus.yaml
arch/arm/boot/dts/broadcom/bcm47189-luxul-xap-1440.dtb: pcie@2000: '#size-cells' is a required property
        From schema: /lib/python3.10/site-packages/dtschema/schemas/pci/pci-bus.yaml

Two properties that need to be added later are "device_type" and
"ranges". Adding "device_type" on its own causes a new warning and the
value of "ranges" needs to be determined yet.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/r/20230707114004.2740-3-zajec5@gmail.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm53573.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index 3cb71829e8597..eed1a6147f0bf 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -127,6 +127,9 @@ uart0: serial@300 {
 
 		pcie0: pcie@2000 {
 			reg = <0x00002000 0x1000>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
 		};
 
 		usb2: usb2@4000 {
-- 
2.40.1



