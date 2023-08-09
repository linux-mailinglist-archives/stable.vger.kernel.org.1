Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1257077589B
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjHIKy3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjHIKyG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:54:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B233F47F2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:52:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DD7063137
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCA2C433C8;
        Wed,  9 Aug 2023 10:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578304;
        bh=er2JIqZGYj+2BymmVfuPjdRYFlrla6/6GmsJC4ke744=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jziV4e7/b+R9x7Bi4vq9+I8NRxJIYLmVj/tJSFxmTs5md6oQml8DpYR/jWYHMHlMk
         Js+OXXkDjdskaK3hUUaMgDxY6h7kJZI9Bhs13hSomjpocD1xmgZEA7WHgmNYOYQ+P2
         A0XeQYkdD0GiPp240dfcGI8eQtXa+fKb/uPzCphY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yashwanth Varakala <y.varakala@phytec.de>,
        Cem Tenruh <c.tenruh@phytec.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 012/127] arm64: dts: phycore-imx8mm: Correction in gpio-line-names
Date:   Wed,  9 Aug 2023 12:39:59 +0200
Message-ID: <20230809103637.041452591@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Yashwanth Varakala <y.varakala@phytec.de>

[ Upstream commit 1ef0aa137a96c5f0564f2db0c556a4f0f60ce8f5 ]

Remove unused nINT_ETHPHY entry from gpio-line-names in gpio1 nodes of
phyCORE-i.MX8MM and phyBOARD-Polis-i.MX8MM devicetrees.

Fixes: ae6847f26ac9 ("arm64: dts: freescale: Add phyBOARD-Polis-i.MX8MM support")
Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
Signed-off-by: Cem Tenruh <c.tenruh@phytec.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
index 4a3df2b77b0be..6720ddf597839 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
@@ -141,7 +141,7 @@
 };
 
 &gpio1 {
-	gpio-line-names = "nINT_ETHPHY", "LED_RED", "WDOG_INT", "X_RTC_INT",
+	gpio-line-names = "", "LED_RED", "WDOG_INT", "X_RTC_INT",
 		"", "", "", "RESET_ETHPHY",
 		"CAN_nINT", "CAN_EN", "nENABLE_FLATLINK", "",
 		"USB_OTG_VBUS_EN", "", "LED_GREEN", "LED_BLUE";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
index 3e5e7d861882f..9d9b103c79c77 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
@@ -111,7 +111,7 @@
 };
 
 &gpio1 {
-	gpio-line-names = "nINT_ETHPHY", "", "WDOG_INT", "X_RTC_INT",
+	gpio-line-names = "", "", "WDOG_INT", "X_RTC_INT",
 		"", "", "", "RESET_ETHPHY",
 		"", "", "nENABLE_FLATLINK";
 };
-- 
2.40.1



