Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D131B7ECE95
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjKOToG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjKOToF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E3B9E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2195BC433C9;
        Wed, 15 Nov 2023 19:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077442;
        bh=ivsrO8l6VrxlU3LbH80zt9xK0DnvHHvls1aCcKTQaI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2MBtiJiIR5ZZucV2/98AwnD3OPUN2LgzdWbMU9Bg6v3vrdQonOwMK8FXv+PBmwodi
         /YrI00qI5Xw5neBR+ex00/FTfa1Zi/qIitNPC3KW29oqjanC+BGyr5SwICtx4iE/mu
         AfnEdScULzyd48Dih6BF/ix/UUtdl9zOGr6Ushzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 306/603] arm64: dts: ti: verdin-am62: disable MIPI DSI bridge
Date:   Wed, 15 Nov 2023 14:14:11 -0500
Message-ID: <20231115191634.587665448@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francesco Dolcini <francesco.dolcini@toradex.com>

[ Upstream commit 664e2852aa9142193c2e241327631f032b966742 ]

Keep the DPI to MIPI-DSI bridge disabled in the SoM dtsi file.

The display chain is not wholly described in the device tree file, on
Verdin product family the displays are additional accessories that are
configured/enabled using DT overlays.

With this enabled we have issues when a display is enabled on
TIDSS port1 (LVDS) and port0 (DSI) is not used.

Fixes: 9e77200356ba ("arm64: dts: ti: verdin-am62: Add DSI display support")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Link: https://lore.kernel.org/r/20230922123003.25002-1-francesco@dolcini.it
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 40992e7e4c308..5db52f2372534 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -1061,6 +1061,7 @@ dsi_bridge: dsi@e {
 		vddc-supply = <&reg_1v2_dsi>;
 		vddmipi-supply = <&reg_1v2_dsi>;
 		vddio-supply = <&reg_1v8_dsi>;
+		status = "disabled";
 
 		dsi_bridge_ports: ports {
 			#address-cells = <1>;
-- 
2.42.0



