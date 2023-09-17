Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA2A7A37CF
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbjIQTZW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239574AbjIQTZE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:25:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CA7DB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:24:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675ADC433C8;
        Sun, 17 Sep 2023 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978698;
        bh=dGrTFoBnzdA6puD3lv9pt12ZciUasKQfnkFyQbuYWwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NHChh7CCjHxSiOaJ7IAiiqa1zF9XXJsMTjQtDez/+jeKn+DRe3yutPLsSZ7SVZtg0
         dPoPr7zUI8MnS+/4oubfoWB+TMN/bEZ/nQ6m7TsObJ5N7qupdQ9KDhOV8MhLJ5sEKC
         Xj3bcMipajORhFvZS5VDHU7vlJgVYYw7wC7OlzMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 134/406] ARM: dts: BCM53573: Drop nonexistent #usb-cells
Date:   Sun, 17 Sep 2023 21:09:48 +0200
Message-ID: <20230917191104.699272063@linuxfoundation.org>
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

[ Upstream commit 05d2c3d552b8c92fc397377d9d1112fc58e2cd59 ]

Such property simply doesn't exist (is not documented or used anywhere).

This fixes:
arch/arm/boot/dts/broadcom/bcm47189-luxul-xap-1440.dtb: usb@d000: Unevaluated properties are not allowed ('#usb-cells' was unexpected)
        From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/r/20230707114004.2740-2-zajec5@gmail.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm53573.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index 3f03a381db0f2..3cb71829e8597 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -156,8 +156,6 @@ ehci_port2: port@2 {
 			};
 
 			ohci: usb@d000 {
-				#usb-cells = <0>;
-
 				compatible = "generic-ohci";
 				reg = <0xd000 0x1000>;
 				interrupt-parent = <&gic>;
-- 
2.40.1



