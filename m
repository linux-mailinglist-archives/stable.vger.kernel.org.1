Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250D87A3BAE
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbjIQUUw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbjIQUUn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:20:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643BF10B
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:20:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8721DC433C7;
        Sun, 17 Sep 2023 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982030;
        bh=tyVbg19/zfFjewda90AciJfAg8bHPcLSRUr6Cn705yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZhwpeDrzSOal9+Kw5duW3l+3w5Oe524abMXGUyolwH6eaPEsq4ifUF38Bw5aYjHr
         ATBX7uWLxcNDTbKAbYXcZHsBeaKBe0pSsUUk7R/6u58QznPeSBQlQ/TosPsVRHGjRE
         YZ6220qs7EcJ6EkTX0Huz6Tt6NiXOo3d80z/peUc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 141/511] ARM: dts: BCM53573: Add cells sizes to PCIe node
Date:   Sun, 17 Sep 2023 21:09:28 +0200
Message-ID: <20230917191117.264957525@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 51546fccc6168..933b6a380c367 100644
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



