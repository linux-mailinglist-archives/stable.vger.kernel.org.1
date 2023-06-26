Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A1473E8E9
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjFZSao (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjFZSaD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:30:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2C410FB
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89B5460E76
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F7CC433C8;
        Mon, 26 Jun 2023 18:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804201;
        bh=D1Arx740KZgOgqjOrApaOd0z4DuI3rFsWR/0sO8CYLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SELnhM6os+AHVwspC8mZoSPfd5beybyhlGqUA6MuF7pfp4H45Pr+G88pUU8FX0llZ
         kbirs7gO/7vC3ic6QuT+uNsh2zjVYXEPgk8R3Fh06c8Y0a82y0El4CYQSVuEeJt8zH
         jB7LDISjvzh22TMB4TyUO2nGS57a1w7fQnNpZMJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Powers-Holmes <aholmes@omnom.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.1 075/170] arm64: dts: rockchip: Fix rk356x PCIe register and range mappings
Date:   Mon, 26 Jun 2023 20:10:44 +0200
Message-ID: <20230626180803.993054908@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andrew Powers-Holmes <aholmes@omnom.net>

commit 568a67e742dfa90b19a23305317164c5c350b71e upstream.

The register and range mappings for the PCIe controller in Rockchip's
RK356x SoCs are incorrect. Replace them with corrected values from the
vendor BSP sources, updated to match current DT schema.

These values are also used in u-boot.

Fixes: 66b51ea7d70f ("arm64: dts: rockchip: Add rk3568 PCIe2x1 controller")
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Powers-Holmes <aholmes@omnom.net>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Tested-by: Diederik de Haas <didi.debian@cknow.org>
Link: https://lore.kernel.org/r/20230601132516.153934-1-frattaroli.nicolas@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi |   14 ++++++++------
 arch/arm64/boot/dts/rockchip/rk356x.dtsi |    7 ++++---
 2 files changed, 12 insertions(+), 9 deletions(-)

--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -94,9 +94,10 @@
 		power-domains = <&power RK3568_PD_PIPE>;
 		reg = <0x3 0xc0400000 0x0 0x00400000>,
 		      <0x0 0xfe270000 0x0 0x00010000>,
-		      <0x3 0x7f000000 0x0 0x01000000>;
-		ranges = <0x01000000 0x0 0x3ef00000 0x3 0x7ef00000 0x0 0x00100000>,
-			 <0x02000000 0x0 0x00000000 0x3 0x40000000 0x0 0x3ef00000>;
+		      <0x0 0xf2000000 0x0 0x00100000>;
+		ranges = <0x01000000 0x0 0xf2100000 0x0 0xf2100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf2200000 0x0 0xf2200000 0x0 0x01e00000>,
+			 <0x03000000 0x0 0x40000000 0x3 0x40000000 0x0 0x40000000>;
 		reg-names = "dbi", "apb", "config";
 		resets = <&cru SRST_PCIE30X1_POWERUP>;
 		reset-names = "pipe";
@@ -146,9 +147,10 @@
 		power-domains = <&power RK3568_PD_PIPE>;
 		reg = <0x3 0xc0800000 0x0 0x00400000>,
 		      <0x0 0xfe280000 0x0 0x00010000>,
-		      <0x3 0xbf000000 0x0 0x01000000>;
-		ranges = <0x01000000 0x0 0x3ef00000 0x3 0xbef00000 0x0 0x00100000>,
-			 <0x02000000 0x0 0x00000000 0x3 0x80000000 0x0 0x3ef00000>;
+		      <0x0 0xf0000000 0x0 0x00100000>;
+		ranges = <0x01000000 0x0 0xf0100000 0x0 0xf0100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf0200000 0x0 0xf0200000 0x0 0x01e00000>,
+			 <0x03000000 0x0 0x40000000 0x3 0x80000000 0x0 0x40000000>;
 		reg-names = "dbi", "apb", "config";
 		resets = <&cru SRST_PCIE30X2_POWERUP>;
 		reset-names = "pipe";
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -951,7 +951,7 @@
 		compatible = "rockchip,rk3568-pcie";
 		reg = <0x3 0xc0000000 0x0 0x00400000>,
 		      <0x0 0xfe260000 0x0 0x00010000>,
-		      <0x3 0x3f000000 0x0 0x01000000>;
+		      <0x0 0xf4000000 0x0 0x00100000>;
 		reg-names = "dbi", "apb", "config";
 		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
@@ -981,8 +981,9 @@
 		phys = <&combphy2 PHY_TYPE_PCIE>;
 		phy-names = "pcie-phy";
 		power-domains = <&power RK3568_PD_PIPE>;
-		ranges = <0x01000000 0x0 0x3ef00000 0x3 0x3ef00000 0x0 0x00100000
-			  0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x3ef00000>;
+		ranges = <0x01000000 0x0 0xf4100000 0x0 0xf4100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf4200000 0x0 0xf4200000 0x0 0x01e00000>,
+			 <0x03000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;
 		resets = <&cru SRST_PCIE20_POWERUP>;
 		reset-names = "pipe";
 		#address-cells = <3>;


