Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB83783353
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjHUUAI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjHUUAI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:00:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB605185
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD13A64769
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD0DC433C7;
        Mon, 21 Aug 2023 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648004;
        bh=WOXxEcVIQSNHMTI057wELF3FuRIP59K/RZVdNZJLuyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CT0LzUPSUUMJzfxzjzd0ybjU0PT35KNtsCdX4rvUrJnnfCsWD/dIRNjWyhxrzEAOp
         tudxLO8Xq8AtvkiEAMxu99ukJMNQTXq5iT+fVS4/YulR2MxbFPKPmMZt6lg6l8XXr+
         qGBqU3DFxZaIEI3tY+dSBvshgKq5FtAFexf5Y5qg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 020/234] ARM: dts: imx6dl: prtrvt, prtvt7, prti6q, prtwd2: fix USB related warnings
Date:   Mon, 21 Aug 2023 21:39:43 +0200
Message-ID: <20230821194129.649716147@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 1d14bd943fa2bbdfda1efbcc080b298fed5f1803 ]

Fix USB-related warnings in prtrvt, prtvt7, prti6q and prtwd2 device trees
by disabling unused usbphynop1 and usbphynop2 USB PHYs and providing proper
configuration for the over-current detection. This fixes the following
warnings with the current kernel:
 usb_phy_generic usbphynop1: dummy supplies not allowed for exclusive requests
 usb_phy_generic usbphynop2: dummy supplies not allowed for exclusive requests
 imx_usb 2184200.usb: No over current polarity defined

By the way, fix over-current detection on usbotg port for prtvt7, prti6q
and prtwd2 boards. Only prtrvt do not have OC on USB OTG port.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6dl-prtrvt.dts   |  4 ++++
 arch/arm/boot/dts/imx6qdl-prti6q.dtsi | 11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-prtrvt.dts b/arch/arm/boot/dts/imx6dl-prtrvt.dts
index 56bb1ca56a2df..36b031236e475 100644
--- a/arch/arm/boot/dts/imx6dl-prtrvt.dts
+++ b/arch/arm/boot/dts/imx6dl-prtrvt.dts
@@ -124,6 +124,10 @@ &usbh1 {
 	status = "disabled";
 };
 
+&usbotg {
+	disable-over-current;
+};
+
 &vpu {
 	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-prti6q.dtsi b/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
index f0db0d4471f40..36f84f4da6b0d 100644
--- a/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
@@ -69,6 +69,7 @@ &usbh1 {
 	vbus-supply = <&reg_usb_h1_vbus>;
 	phy_type = "utmi";
 	dr_mode = "host";
+	disable-over-current;
 	status = "okay";
 };
 
@@ -78,10 +79,18 @@ &usbotg {
 	pinctrl-0 = <&pinctrl_usbotg>;
 	phy_type = "utmi";
 	dr_mode = "host";
-	disable-over-current;
+	over-current-active-low;
 	status = "okay";
 };
 
+&usbphynop1 {
+	status = "disabled";
+};
+
+&usbphynop2 {
+	status = "disabled";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
-- 
2.40.1



