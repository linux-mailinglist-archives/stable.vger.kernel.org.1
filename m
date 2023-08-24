Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D932787674
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbjHXRQX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241672AbjHXRQE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:16:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0745719A3
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90F9C60F19
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A18C433C7;
        Thu, 24 Aug 2023 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897362;
        bh=9ng7+gjTvXR3BleGUtcEwM5nYqJtj7cPGfCoEML3/nY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DphmrsX0H5lGQ1Q1fBHOgsGAhY9BJbySXz7x0vKJY2+5LEx463REW/FAYUrsMkt7z
         NnlZunFt9R/SN2c6O6q/thCW2HKFk7fOeSht8CegaNdpT2mCFRVxW4Fwsz9WO5+gsr
         AseQfIQUizAMr3rRw0yGTROMw+s1pl4wU1Vjx8X8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 012/135] ARM: dts: imx6dl: prtrvt, prtvt7, prti6q, prtwd2: fix USB related warnings
Date:   Thu, 24 Aug 2023 19:08:04 +0200
Message-ID: <20230824170617.638081971@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 5ac84445e9cc1..90e01de8c2c15 100644
--- a/arch/arm/boot/dts/imx6dl-prtrvt.dts
+++ b/arch/arm/boot/dts/imx6dl-prtrvt.dts
@@ -126,6 +126,10 @@ &usbh1 {
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
index 19578f660b092..70dfa07a16981 100644
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



