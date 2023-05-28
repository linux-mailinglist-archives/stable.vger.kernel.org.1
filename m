Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010C0713E3C
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjE1Tdc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjE1Tdc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:33:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124A2A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:33:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A347612E6
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C4CC433EF;
        Sun, 28 May 2023 19:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302410;
        bh=1VLUA8HWeq6VhVyIy4GFFWdztGzpB+qVMQNLruE0kb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LkZ8Y9twUIWvmftyCD3qGZVIKUPEY/UUGsJTMe5GlsMU3PF7v8Pldq+lEyqFqfJOi
         UnXOQYtsq3o8cJLftq9zzSW/oocVXgIbWJfR4tw2mTZEU6v6RY3H+A82S5D8ZmKrwq
         y9MT3vStg/FA46xGEhUSK2MoeWfSdZB7a42jVZyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 6.3 119/127] arm64: dts: imx8mn-var-som: fix PHY detection bug by adding deassert delay
Date:   Sun, 28 May 2023 20:11:35 +0100
Message-Id: <20230528190840.113729818@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

commit f161cea5a20f3aeeb637a88ad1705fc2720b4d58 upstream.

While testing the ethernet interface on a Variscite symphony carrier
board using an imx8mn SOM with an onboard ADIN1300 PHY (EC hardware
configuration), the ethernet PHY is not detected.

The ADIN1300 datasheet indicate that the "Management interface
active (t4)" state is reached at most 5ms after the reset signal is
deasserted.

The device tree in Variscite custom git repository uses the following
property:

    phy-reset-post-delay = <20>;

Add a new MDIO property 'reset-deassert-us' of 20ms to have the same
delay inside the ethphy node. Adding this property fixes the problem
with the PHY detection.

Note that this SOM can also have an Atheros AR8033 PHY. In this case,
a 1ms deassert delay is sufficient. Add a comment to that effect.

Fixes: ade0176dd8a0 ("arm64: dts: imx8mn-var-som: Add Variscite VAR-SOM-MX8MN System on Module")
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
@@ -98,11 +98,17 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		ethphy: ethernet-phy@4 {
+		ethphy: ethernet-phy@4 { /* AR8033 or ADIN1300 */
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <4>;
 			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
+			/*
+			 * Deassert delay:
+			 * ADIN1300 requires 5ms.
+			 * AR8033   requires 1ms.
+			 */
+			reset-deassert-us = <20000>;
 		};
 	};
 };


