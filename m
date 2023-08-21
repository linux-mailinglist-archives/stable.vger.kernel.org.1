Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238C8783284
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjHUUJg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjHUUJf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:09:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC10DF
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12E2964A85
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25295C433C9;
        Mon, 21 Aug 2023 20:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648573;
        bh=TIFmacErtkdGo8Q6ZjqysLcFmM67zi5bmtSzjFEbY4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z48PNKLE9T0yM9hExfhdVMiRYlunrRqYciiUfriwzhbPi//hOVWWVisBkcEcA8LEN
         aJmNmNxTsmIgEGZNBB0Bl6qj/kBvICwQ5lVAcVBlIPZWNxgYfYyz0GmWnGkQcY0g2k
         oep6+RjyVKI2I2/40Y4TAH8aFKDZ+DDxfiIAVTS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrej Picej <andrej.picej@norik.com>,
        =?UTF-8?q?Stefan=20Riedm=C3=BCller?= <s.riedmueller@phytec.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 184/234] ARM: dts: imx6: phytec: fix RTC interrupt level
Date:   Mon, 21 Aug 2023 21:42:27 +0200
Message-ID: <20230821194136.979902200@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andrej Picej <andrej.picej@norik.com>

[ Upstream commit 762b700982a1e0f562184363f19860c3b9bdd0bf ]

RTC interrupt level should be set to "LOW". This was revealed by the
introduction of commit:

  f181987ef477 ("rtc: m41t80: use IRQ flags obtained from fwnode")

which changed the way IRQ type is obtained.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Reviewed-by: Stefan Riedmüller <s.riedmueller@phytec.de>
Fixes: 800d595151bb ("ARM: dts: imx6: Add initial support for phyBOARD-Mira")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
index 1a599c294ab86..1ca4d219609f6 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
@@ -182,7 +182,7 @@
 		pinctrl-0 = <&pinctrl_rtc_int>;
 		reg = <0x68>;
 		interrupt-parent = <&gpio7>;
-		interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
 		status = "disabled";
 	};
 };
-- 
2.40.1



